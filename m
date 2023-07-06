Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9A7EB64D9
	for <webhook@archiver.kernel.org>; Thu,  6 Jul 2023 04:48:08 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web10.14567.1688618879817582852
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 05 Jul 2023 21:47:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=EHiZ//c/;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.169, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1b8062c1ee1so1223905ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 05 Jul 2023 21:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1688618879; x=1691210879;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QVoT1e/V4nyyxzcgdouVXcaGp4kx9gsz9OS9VIbJdY8=;
        b=EHiZ//c/ub+QdcEgtj9LP9kHJM9DWJyCYNgLCaJvkTJ1SEdmVdEiqUoTK0gB7DlSNE
         xnMHRH/CrnV7XfrPa/pLFDYXBuuxrWZvnvvbaax+uWOH4P1GeMWyynlA6TDHWORgumii
         mosDV967XjqcxtIyxQakwU7+J4yXFO27U5Q2Eald3DoMowW1J2AQVIaK+WEYTR5fKvP2
         Bdm8xUwFlQF6hW8MXnR02E1UeVVUNTysfU3dSDTlU9LXLf7kUsaN2Y1Bts5hRcOlaPJG
         1LbKfpKBNCAQRoHrRsp/bYBIaiSp7VcnH84jFKyv5yNIey89YYD7untj8FNpO5YuE5+h
         L70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688618879; x=1691210879;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QVoT1e/V4nyyxzcgdouVXcaGp4kx9gsz9OS9VIbJdY8=;
        b=fK3T9nGAzugf6Hkc5z2hXcq5ilmT8Oqz4J/OJTeNMxzvLfJbmeRQOdTPdkPXbirCLE
         LkeXGem5qS3zgzxUnhKJtDWgCaAu78Pp29HEVw0uiGQpn+3EJL6bdT/BBb4GdVqgMG6m
         5l3z3Gh3L0S/wQL/nXs9H7WKlQDYQK/Nl2QuN7hvwUNMcBbBDXz3BMrBkncg+4FDo3HA
         qx2iRvdswXKq3l8NVW8XSUw5iiitQ8nJUifZbss5J2szMp/5WTLuMz9L2rWi6eW0Z8nP
         dx+E7EhjaKguq5Cw028lwr5sPqhQIioC3otJ8dMFx/u11K18pQc2Hyy2qu53buHD4FYX
         yqPg==
X-Gm-Message-State: ABy/qLbxthHf5uPp/VmiUGULaj3MugTimtRqJywfOPA133ukBYlG3fAm
	EjzcvIzeXyRxLRbq/ivBsEoZsegzuP2LcnGsDG0r0w==
X-Google-Smtp-Source: APBJJlH2hup0Xiqyih+PpTXgFEYHPKGpjV080HzllKPRq7I5CwwANIuyuH2S0mANqs4sjdc9YjklJQ==
X-Received: by 2002:a17:902:d4ce:b0:1b8:7e53:70f with SMTP id o14-20020a170902d4ce00b001b87e53070fmr1190632plg.27.1688618878780;
        Wed, 05 Jul 2023 21:47:58 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902a60200b001b881a8251bsm332145plq.106.2023.07.05.21.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 21:47:58 -0700 (PDT)
Message-ID: <64a6477e.170a0220.37111.0bef@mx.google.com>
Date: Wed, 05 Jul 2023 21:47:58 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.31-64-g93fc2d0f5008
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-6.1.y-cip
Subject: cip/linux-6.1.y-cip ltp-timers: 6 runs,
 6 regressions (v6.1.31-64-g93fc2d0f5008)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Jul 2023 04:48:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12250

cip/linux-6.1.y-cip ltp-timers: 6 runs, 6 regressions (v6.1.31-64-g93fc2d0f=
5008)

Regressions Summary
-------------------

platform     | arch   | lab           | compiler | defconfig        | regre=
ssions
-------------+--------+---------------+----------+------------------+------=
------
qemu_riscv64 | riscv  | lab-broonie   | gcc-10   | defconfig        | 2    =
      =

qemu_riscv64 | riscv  | lab-collabora | gcc-10   | defconfig        | 2    =
      =

qemu_x86_64  | x86_64 | lab-collabora | gcc-10   | x86_64_defconfig | 2    =
      =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.31-64-g93fc2d0f5008/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.31-64-g93fc2d0f5008
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      93fc2d0f50088e8475632061960ee7cdb9756010

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform     | arch   | lab           | compiler | defconfig        | regre=
ssions
-------------+--------+---------------+----------+------------------+------=
------
qemu_riscv64 | riscv  | lab-broonie   | gcc-10   | defconfig        | 2    =
      =


  Details:     https://kernelci.org/test/plan/id/64a63e48024fe5cb72bb2a75

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.31-64=
-g93fc2d0f5008/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_riscv64.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.31-64=
-g93fc2d0f5008/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_riscv64.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64a63e48024=
fe5cb72bb2a7a
        new failure (last pass: v6.1.31-53-g486caac40d06) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64a63e48024=
fe5cb72bb2a7a
        new failure (last pass: v6.1.31-53-g486caac40d06) =

 =



platform     | arch   | lab           | compiler | defconfig        | regre=
ssions
-------------+--------+---------------+----------+------------------+------=
------
qemu_riscv64 | riscv  | lab-collabora | gcc-10   | defconfig        | 2    =
      =


  Details:     https://kernelci.org/test/plan/id/64a6363688136c43f9bb2aa7

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.31-64=
-g93fc2d0f5008/riscv/defconfig/gcc-10/lab-collabora/ltp-timers-qemu_riscv64=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.31-64=
-g93fc2d0f5008/riscv/defconfig/gcc-10/lab-collabora/ltp-timers-qemu_riscv64=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64a63636881=
36c43f9bb2aac
        new failure (last pass: v6.1.31-53-g486caac40d06) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64a63636881=
36c43f9bb2aac
        new failure (last pass: v6.1.31-53-g486caac40d06) =

 =



platform     | arch   | lab           | compiler | defconfig        | regre=
ssions
-------------+--------+---------------+----------+------------------+------=
------
qemu_x86_64  | x86_64 | lab-collabora | gcc-10   | x86_64_defconfig | 2    =
      =


  Details:     https://kernelci.org/test/plan/id/64a6378a1f2a3120fabb2aa5

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.31-64=
-g93fc2d0f5008/x86_64/x86_64_defconfig/gcc-10/lab-collabora/ltp-timers-qemu=
_x86_64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.31-64=
-g93fc2d0f5008/x86_64/x86_64_defconfig/gcc-10/lab-collabora/ltp-timers-qemu=
_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64a6378a1f2=
a3120fabb2aaa
        new failure (last pass: v6.1.31-53-g486caac40d06)

    2023-07-06T03:39:38.396637  =

   =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64a6378a1f2=
a3120fabb2aaa
        new failure (last pass: v6.1.31-53-g486caac40d06)

    2023-07-06T03:39:38.396637  =

   =

 =20

