Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E74EB64DA
	for <webhook@archiver.kernel.org>; Wed, 19 Jul 2023 13:51:56 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web10.14234.1689774714663687879
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 19 Jul 2023 06:51:54 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=z8ytGHQ4;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1b9cdef8619so44103765ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 19 Jul 2023 06:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689774713; x=1692366713;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DZBihQ/iSnibi46PeXEjNzIkvz+byshmK56XW9Rsvyk=;
        b=z8ytGHQ4x8uDftNLPNGY26tUQWemYZAq3dKJWVeUmHoWKMtyijufbFHYrE9OnX4/9r
         esElXHZnrB/bnponpqsRojjvqEryZAYTBAGuwQOAR3Cv46Is3lAp/OMLsGldLLjkpO4R
         d2NRrmEcZLsMSIVPmMZHtBdSc290DfZHpkzBipXq/3RCxBVLcKWV0fnTsWulvcP/Mt3D
         K1dBI9kA087xYmPmfuXte5jcVD1cvwyLKy5tiwLVvdMtubNa6bRv3H0t1ZOx6uZlg7y+
         quf5TQTv3j+JAX1lCXAoImmeUJBpTG6IyjsQEaEqNYMbr/zhjaCm2q4PJmHli3m2WYEO
         e6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689774713; x=1692366713;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DZBihQ/iSnibi46PeXEjNzIkvz+byshmK56XW9Rsvyk=;
        b=OIptonSOPk2nCVkjlgWv9lez9YyBZM2W8KSphycCEvDVejWIMp/J772PsGWoFxXgLw
         V4eevaxcdMR+rvMQ9iL3LYEv7CzXNYFVRsJ5gh6iYI4VEcPG/gkeG2mi7ENZ43hWngqD
         FAha/1pXaYDVCIp9gYZCmvIa9h5jv1otsBx+wubczyMXDr+NJCaNx+nzpILBR3Nw89Wd
         ftiH7tBpxW28fXMV5M4vqJm3uT/hrYRwi+qRxwLo5kM+2UKFHi7tbo4Gj972sitFhRXJ
         1DlVXEuJGusVDKNBbZLNJV7HPYR9C4iCdh4bJxzal/EUoCEYKGQTyuNOdhX1SFZ4pWzL
         WUfw==
X-Gm-Message-State: ABy/qLYk4ZQXUFvdtreoSAYfJNGuBGjI/lKWQ7ewZmMPCyD7PU93mZ3+
	dMs2aG/MHgOxe6SNWYa3AUFAdTpxVCl7W6aAmISEUQ==
X-Google-Smtp-Source: APBJJlG9d5znZIyKmxAN8cBouG3lQYEn8VLysZDYFQSJUbzGRA24oh43ehKDNw9r7HIreF92EjQ4Vg==
X-Received: by 2002:a17:902:ab4a:b0:1bb:1a64:5a74 with SMTP id ij10-20020a170902ab4a00b001bb1a645a74mr4168250plb.33.1689774713413;
        Wed, 19 Jul 2023 06:51:53 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h5-20020a170902f54500b001ae0152d280sm4001240plf.193.2023.07.19.06.51.52
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 06:51:52 -0700 (PDT)
Message-ID: <64b7ea78.170a0220.803da.8a8c@mx.google.com>
Date: Wed, 19 Jul 2023 06:51:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v6.1.38-cip1-10-g02aa22be941dd
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 8 runs,
 4 regressions (v6.1.38-cip1-10-g02aa22be941dd)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Jul 2023 13:51:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12430

cip-gitlab/ci/pavel/linux-test ltp-timers: 8 runs, 4 regressions (v6.1.38-c=
ip1-10-g02aa22be941dd)

Regressions Summary
-------------------

platform     | arch  | lab           | compiler | defconfig | regressions
-------------+-------+---------------+----------+-----------+------------
qemu_riscv64 | riscv | lab-broonie   | gcc-10   | defconfig | 2          =

qemu_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.38-cip1-10-g02aa22be941dd/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.38-cip1-10-g02aa22be941dd
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      02aa22be941dd7a72690f834f897a77275f9f6a5

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform     | arch  | lab           | compiler | defconfig | regressions
-------------+-------+---------------+----------+-----------+------------
qemu_riscv64 | riscv | lab-broonie   | gcc-10   | defconfig | 2          =


  Details:     https://kernelci.org/test/plan/id/64b7d6ea039cb430898ace23

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-10-g02aa22be941dd/riscv/defconfig/gcc-10/lab-broonie/ltp-time=
rs-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-10-g02aa22be941dd/riscv/defconfig/gcc-10/lab-broonie/ltp-time=
rs-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64b7d6ea039=
cb430898ace28
        failing since 27 days (last pass: v5.10.182-cip35-8-g2391124f19a70,=
 first fail: v6.1.31-61-g32a95f5a4e3b) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64b7d6ea039=
cb430898ace28
        failing since 27 days (last pass: v5.10.182-cip35-8-g2391124f19a70,=
 first fail: v6.1.31-61-g32a95f5a4e3b) =

 =



platform     | arch  | lab           | compiler | defconfig | regressions
-------------+-------+---------------+----------+-----------+------------
qemu_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 2          =


  Details:     https://kernelci.org/test/plan/id/64b7d51da7597421908ace20

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-10-g02aa22be941dd/riscv/defconfig/gcc-10/lab-collabora/ltp-ti=
mers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-10-g02aa22be941dd/riscv/defconfig/gcc-10/lab-collabora/ltp-ti=
mers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64b7d51da75=
97421908ace25
        failing since 27 days (last pass: v5.10.182-cip35-8-g2391124f19a70,=
 first fail: v6.1.31-61-g32a95f5a4e3b)

    2023-07-19T12:20:36.241609  =

   =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64b7d51da75=
97421908ace25
        failing since 27 days (last pass: v5.10.182-cip35-8-g2391124f19a70,=
 first fail: v6.1.31-61-g32a95f5a4e3b)

    2023-07-19T12:20:36.241609  =

   =

 =20

