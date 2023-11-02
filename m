Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFBDC4332F
	for <webhook@archiver.kernel.org>; Thu,  2 Nov 2023 17:49:30 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.web10.38690.1698947359969637830
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 02 Nov 2023 10:49:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=CEkkMT2j;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.50, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-280109daaaaso1077862a91.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 02 Nov 2023 10:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698947359; x=1699552159; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jiOdpYAGDKIwPJMlQbivGl3fMjr+fBRL6A31jlLYlso=;
        b=CEkkMT2juyp6GjYNr0LwThkk7ZGFUWnGHgn/tHQQg4ta15vkGDO8iRL9ywVwNGqb1F
         6ly0n1TVh4ICTAgWmdKBSDQkcyeRp08Wdp1U0URwgaLNWncnwwMyw6r04Co9K/v90VL+
         GmpknRHmuuZ3q1n3MN/0O5sjdKYfa4oX7vwcRmaD2yOT61ZEHTSKCCoryG3R1HfC6bYU
         0gKByfMSKwWPd8+8/FGNlfkmVwAoTHba6YOJwgn+T32WXQk+rWtaukDWWvcjduZr4W1e
         2yixk5LBxwJawKphEiavED3xQP4923gf8882vra7SV2AD1QeEoL9Y8aQQWmWetFsVFhH
         AVPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698947359; x=1699552159;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jiOdpYAGDKIwPJMlQbivGl3fMjr+fBRL6A31jlLYlso=;
        b=sTK7Yv9pOtM24Ydkmhcv8qWQqF/EwC7uw1zvtks9xhpVHd+QuLj8uIE7HgIVZYnOMB
         ResGaL8nEoYxDqJrQ1ZM0nIetATh3/dQjFECtRrWr5um29THI26FXimQiqBGYyTfU8kl
         rJDlNMDu9tCwBOyK6XpVm3J2iTUI12fYKbmIhViTyZe4v/HKnzPK3YcyhunlfjgnIYOG
         68bzgvprYHdPoYKEpKMgB7cGmOMhiLskI3pZpQfbhpdi3zaoDLwaEY1hiR8iiQsnfNJ5
         O4NnlajJjKn78vjPv1SbCSN5yaKlaJtEZQVRSgy7hRpxBRZrTULejQiuTxUGqvddN+Ax
         1rdA==
X-Gm-Message-State: AOJu0YwT4Kku5mj5NLDJxyLuDA6AcPTYhr/ouaHRd/a3z2+ET+kmaOTb
	X8cZniTzFRwXxzni3h4eOu2U1mus1ZowB+IjYSa9HQ==
X-Google-Smtp-Source: AGHT+IGMNZ1HmvjfANdi4X3hIyr3Hnv9rnniNr+s3iK22l6+2ed3ezxdjtRPTUo0/kTyM1Ar21l3Pg==
X-Received: by 2002:a17:90a:ad91:b0:27d:b9d:bd6f with SMTP id s17-20020a17090aad9100b0027d0b9dbd6fmr16077024pjq.45.1698947358851;
        Thu, 02 Nov 2023 10:49:18 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ge17-20020a17090b0e1100b0027cf8869ee7sm160155pjb.0.2023.11.02.10.49.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 10:49:15 -0700 (PDT)
Message-ID: <6543e11b.170a0220.8aa05.024b@mx.google.com>
Date: Thu, 02 Nov 2023 10:49:15 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.194-cip39-915-g96fa7f16cf02
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 10 runs,
 2 regressions (v5.10.194-cip39-915-g96fa7f16cf02)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Nov 2023 17:49:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13530

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 10 runs, 2 re=
gressions (v5.10.194-cip39-915-g96fa7f16cf02)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
          | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm...ok+=
kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.194-cip39-915-g96fa7f16cf02/plan/kselftes=
t-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.194-cip39-915-g96fa7f16cf02
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      96fa7f16cf0228e65eeaeaeef1b73f242f4e169e =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
          | 1          =


  Details:     https://kernelci.org/test/plan/id/6543cc4a3058d1a426efcf55

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig+kselftest/gc=
c-10/lab-cip/kselftest-seccomp-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig+kselftest/gc=
c-10/lab-cip/kselftest-seccomp-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/6543cc4a3058=
d1a426efcf56
        new failure (last pass: v5.10.184-cip36-10-ga711f789c23e1) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm...ok+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6543d461fa06883195efcef8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig+arm64-chrome=
book+kselftest/gcc-10/lab-cip/kselftest-seccomp-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig+arm64-chrome=
book+kselftest/gcc-10/lab-cip/kselftest-seccomp-r8a774a1-hihope-rzg2m-ex.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/6543d461fa06=
883195efcef9
        new failure (last pass: v5.10.184-cip36-10-ga711f789c23e1) =

 =20

