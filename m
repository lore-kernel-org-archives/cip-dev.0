Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6B8C77B61
	for <webhook@archiver.kernel.org>; Wed, 22 Mar 2023 10:38:33 +0000 (UTC)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
 by mx.groups.io with SMTP id smtpd.web10.39373.1679481507265259769
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 22 Mar 2023 03:38:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=TIsLvDWQ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.45, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f45.google.com with SMTP id e15-20020a17090ac20f00b0023d1b009f52so23171903pjt.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 22 Mar 2023 03:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1679481506;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JCrXo6nCsQ3PjUXN9tLzirJgt52crV4PUMM4d8uHYpg=;
        b=TIsLvDWQrenL4L3Oyvj0jJsfBWl1iMDmJSwrvR6NjkbWYhJCDqvM6MfKKCbmik0Rit
         5zEejUKtKmfuGii5fCjW3YgR1VuV6lKnpXI9zmPKaY4C4kUQHrWxmYgE4dv49OKhvW65
         lZt0KC91TxuLlnx7GqPvuG7vyFNJEdF8bB2/7Thjf/Q74Si6USOYUnD69mDAEp+Qfo30
         QJO6Y0VjUnvJ5YwL+vF4eBdudvTIxaufHhJdLZXdQ5n7Boil9jULNnKObjvZtTZyQOrC
         ev7poQ2FxdwIt2DUqpPouH4cV9QDFAFa49OgpEWTx1840uVLGJ7QRBKivmBgV2jZY/Bo
         iHXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679481506;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JCrXo6nCsQ3PjUXN9tLzirJgt52crV4PUMM4d8uHYpg=;
        b=qnLkG62b4/HS7gYWmYP9u8kCC7Fm5uMd/BiVPWSK55kj1f1M0jYL0eM8HFNXoEL+5v
         xAuK/TspoeGtb7ibDZXr2CaP+dI5U+z7rw7t5IpQ72cvYBp4Q0g5pJJoENB0COy9o2Sv
         DMw20W2bWNZyVTPhTKB4sf2KCQWeFAIZPlbxJEqv32WyytQCn81pb+wHyeoEaubv1UWf
         RZVgWYTaF5YdRC/Czwg3TO/JWmgE4RKxClYRfcf/htzxbzWn0ERGwnKNuvi1xW1fZYMd
         oBYOZlrPrAUQAGCMoahP5tJyDcX4tqhLkbvBxuJPXtW4ipgamH9ye3Im7pf4G0GxW6Lm
         oHZA==
X-Gm-Message-State: AO0yUKWrh3xNRIJgNUU3OKJM1EiNwLoUmQFhCUkfhv83N0BZs+oxC5dG
	7EohbotIYRShdw8HB3l42+tP+tWr9UycBStWmLKnWQ==
X-Google-Smtp-Source: AK7set9aC1TDzuj9klydO4zBxjgRzAdeHbdYGF4lKujel/WpQD7RdAy3v+ydMe+lUhxrAMTUlDqjhA==
X-Received: by 2002:a17:90b:38c2:b0:23f:618a:6bed with SMTP id nn2-20020a17090b38c200b0023f618a6bedmr3479009pjb.47.1679481506076;
        Wed, 22 Mar 2023 03:38:26 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 17-20020a170902c15100b0019f387f2dc3sm10254178plj.24.2023.03.22.03.38.25
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 03:38:25 -0700 (PDT)
Message-ID: <641adaa1.170a0220.b7eb2.2dbe@mx.google.com>
Date: Wed, 22 Mar 2023 03:38:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.277-cip94-1098-g26d9f86d942d
Subject: cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 8 runs,
 1 regressions (v4.19.277-cip94-1098-g26d9f86d942d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Mar 2023 10:38:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11067

cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 8 runs, 1 regressions=
 (v4.19.277-cip94-1098-g26d9f86d942d)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.277-cip94-1098-g26d9f86d942d/plan/kselftest-filesyste=
ms/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.277-cip94-1098-g26d9f86d942d
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      26d9f86d942d1c22bb7542618e47ea5c0e6b4026 =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641acc3f5b1b0a17649c9535

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/kselftest-filesystems-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/kselftest-filesystems-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230317.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/641acc3f=
5b1b0a17649c9536
        new failure (last pass: v5.10.168-cip27-456-g42a59c4e5329) =

 =20

