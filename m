Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFB5C6FD1F
	for <webhook@archiver.kernel.org>; Wed, 22 Mar 2023 10:38:33 +0000 (UTC)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
 by mx.groups.io with SMTP id smtpd.web11.39101.1679481507018335690
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 22 Mar 2023 03:38:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=ubrqnyEi;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.45, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f45.google.com with SMTP id qe8-20020a17090b4f8800b0023f07253a2cso18684779pjb.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 22 Mar 2023 03:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1679481506;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aiMcc6kRnXPeEeWXWkRV4foErjP2fO7WeJs+M7mD4dw=;
        b=ubrqnyEiV53YjmOmSxXjTc81m3H5I38ikPTXALVgAvTOPCa+fM+7XBUuU4+1gI3h8H
         98mycWvQ5W+hb8NoCd4K+3GNhgNdIzHN+SZ0rhPAJoV66bL8w3NPu4+lqOzpnUMGwXTM
         G/Garz/UeeXgWye6OQ2H5U8kIYmxD6dREnVceIdhNAB3/yBpwlY6MRQG6MU/+JCwdAR7
         PFBN5DY50AtV3WE+8NKiqU6DxSSMaA3GgNr47P5uMU3mZs6Ep8HBMy/1d4c8K8JnP9+w
         fFUH9cTAymSqXY4bpI4l0m860qoSI1gkcnqRMiupCLurVVeZTkUX4R/NLj+n+aqu+q/i
         ilHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679481506;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aiMcc6kRnXPeEeWXWkRV4foErjP2fO7WeJs+M7mD4dw=;
        b=oJSa7uQ56azUYUz3pBQEPcGARd4Dxovb99w25W7eO7fF2WLXzcW6+//OBALFgVrVsp
         bZme9ze1IXKMaGh9VoNBHvSRsjamTVuBz/VBpA2kCC2L87Pjyh5+2iZUKi7Wgct4gyJL
         j5kFpdKTxRpwGYdiBe03tZz64UAlZ/De7SVdFRVonEV6lheRlxjueWTFC7wE4kR+xTSE
         rsVtEKS/8Rra1Ub+S4VmT8nGf7M/8c+4K2y4jhTp3B8WPkXD9LQrXw+pzXfSl4VwEPwc
         W29+QdMM0y9B0BtwYETA0t7QB/9bO7B5vno6JEs5eg8JJJbPKHdgxN8bOxyuSb1+re5P
         Q61Q==
X-Gm-Message-State: AO0yUKWwMt6G3vD8Xz+JO1P065BXn1Ad85XELKkCwgHahg3VmC4pYMqu
	b2nJlaVq5Pw5SeiLFUEpzSpXsSRjsKWGaIXff2GuKg==
X-Google-Smtp-Source: AK7set8TTtryqq/Asz18N6vNpRRKGpf99eJC28wHaC9Nx4Eb1MJqAR7llbUO7KEXw3pepHXWWx31vA==
X-Received: by 2002:a17:903:41cd:b0:19f:2dff:21a4 with SMTP id u13-20020a17090341cd00b0019f2dff21a4mr2739042ple.16.1679481506228;
        Wed, 22 Mar 2023 03:38:26 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t10-20020a170902b20a00b001a0403f6a97sm10280659plr.202.2023.03.22.03.38.25
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 03:38:25 -0700 (PDT)
Message-ID: <641adaa1.170a0220.d5bed.23bd@mx.google.com>
Date: Wed, 22 Mar 2023 03:38:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.277-cip94-1098-g26d9f86d942d
Subject: cip-gitlab/ci/pavel/linux-test kselftest-futex: 6 runs,
 1 regressions (v4.19.277-cip94-1098-g26d9f86d942d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Mar 2023 10:38:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11066

cip-gitlab/ci/pavel/linux-test kselftest-futex: 6 runs, 1 regressions (v4.1=
9.277-cip94-1098-g26d9f86d942d)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.277-cip94-1098-g26d9f86d942d/plan/kselftest-futex/

  Test:     kselftest-futex
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


  Details:     https://kernelci.org/test/plan/id/641accb98dfe43eca29c959d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/kselftest-futex-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/kselftest-futex-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230317.0/amd64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/641accb98dfe43=
eca29c959e
        new failure (last pass: v5.10.168-cip27-456-g42a59c4e5329) =

 =20

