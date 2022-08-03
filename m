Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E604DC3F6B0
	for <webhook@archiver.kernel.org>; Wed,  3 Aug 2022 17:25:29 +0000 (UTC)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by mx.groups.io with SMTP id smtpd.web10.553.1659547525826705667
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 10:25:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=O8wltndf;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.170,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f170.google.com with SMTP id i71so10172333pge.9
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 10:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=dAmnT3fEhO3ZH8Clho1FPNbDXg2vQi9jaZKVgtLPlW4=;
        b=O8wltndfVQMPTaCpIbbVYwlwQzARstrt5IcNBJpd8rLnMMH8oqzPAngyQ7N+jbxs/M
         BbR9aSw6RuBKY7F7m1njSrd8KMtzL0Su1ajZcGUyDSPHaxQpHcAr4borhMriy/6bnDSj
         r2wdNn439frryrWfJ5jNvpHOJdZ0YBfiiIys7M+5ITue+/Agkudn8cEqSU4Pa5A10tNf
         Gv563Z8rP94/WhZMea5UspNuqv4expjha+ME3Cs/o9Hsnf9qPetOkrfDg2f0Zvhe5sdN
         uLS3r4/ulSPjNxfaSsMKBh+TlaLcjiuBFYIX1iyEOxv4gLNzvF4xrQKtAq7DFSDfrh8+
         BFeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=dAmnT3fEhO3ZH8Clho1FPNbDXg2vQi9jaZKVgtLPlW4=;
        b=oXEabX8J8v9TNoaX9a/U7PEdRX27VeuUcwdJiSLJb1wNmfi2D5YF1GTp6DwDBJ7t2z
         9F9wNLFesXc+Ntz2ISzLC0T0d9aFIcmBRkKwM1glj66ihZvWI9fKmPlmqlWYxVE7ngbZ
         iqs/D9WvHcewMQwdxzscL8hjSi9UKUbFeFtjfYvRhPAuelDo99MN7PQPnYpP3rfYtsrC
         43Myyl4ntsq1uF/VJKFR1m9/6SBsMv770iJCbK4SAy93rk0sxJlQ0L/dCcYOuZDAXVHk
         InYFuQzUZYspLC0dANknUeOnHVuCGLr5zGqCLjEKUDlGb28DqxkU8CPvo++SigXcOTxg
         Ilow==
X-Gm-Message-State: AJIora+or7Nf8PVbAm4PFrU9SYHRE96rEW0aRy6ly34EXEaPEsgRSTA/
	5ozXxzTcC0nzqFJWP77sRZ5A9z4gkD/pAEZWgOY=
X-Google-Smtp-Source: 
 AGRyM1tuNoL+BfsmfUJqIHKnSqd+4VwUIc0iV5OWx8a4/F1hbObEA+UL5WEiC3PvsHL6mU47p9xoCA==
X-Received: by 2002:a65:6494:0:b0:419:9527:2a69 with SMTP id
 e20-20020a656494000000b0041995272a69mr21717433pgv.80.1659547525048;
        Wed, 03 Aug 2022 10:25:25 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 h3-20020a63df43000000b00416018b5bbbsm11435972pgj.76.2022.08.03.10.25.24
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 10:25:24 -0700 (PDT)
Message-ID: <62eaaf84.630a0220.c23fc.0f17@mx.google.com>
Date: Wed, 03 Aug 2022 10:25:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st20-74-gc99f2b257bde3
Subject: cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 4 runs,
 4 regressions (v4.4-st20-74-gc99f2b257bde3)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Aug 2022 17:25:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9086

cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 4 runs, 4 regressions (v4.=
4-st20-74-gc99f2b257bde3)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig  | 1 =
         =

beaglebone-black | arm  | lab-cip     | gcc-10   | multi_v7_defconfig  | 1 =
         =

beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =

beaglebone-black | arm  | lab-cip     | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st20-74-gc99f2b257bde3/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st20-74-gc99f2b257bde3
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c99f2b257bde3cd60a833056aab624ad5fab3812 =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig  | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/62eaa48d426c3a643edaf0c7

  Results:     3 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-74-gc99f2b257bde3/arm/multi_v7_defconfig/gcc-10/lab-broonie/base=
line-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-74-gc99f2b257bde3/arm/multi_v7_defconfig/gcc-10/lab-broonie/base=
line-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.dmesg.crit: https://kernelci.org/test/case/id/62eaa48d=
426c3a643edaf0cc
        failing since 0 day (last pass: v5.10.131-cip13-24-ga6f4ea41fe167, =
first fail: v4.4.302-cip70-rt40)
        1 lines

    2022-08-03T16:38:07.347114  / # =

    2022-08-03T16:38:07.350747  =

    2022-08-03T16:38:12.371544  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/382134/extract-nfsrootfs-7_f665zj'
    2022-08-03T16:38:12.382476  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/382134/extract-nfsrootfs-</lib/lava/dispatcher/tmp/382134/extract-nf=
srootfs-7                         _f665zj'
    2022-08-03T16:38:14.675434  / # export NFS_SERVER_IP=3D'192.168.56.123'
    2022-08-03T16:38:14.686106  export NFS_SERVER_IP=3D'192.168.56.123'
    2022-08-03T16:38:14.796450  / # #
    2022-08-03T16:38:14.801072  #
    2022-08-03T16:38:14.913390  / # export SHELL=3D/bin/sh
    2022-08-03T16:38:14.917387  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-cip     | gcc-10   | multi_v7_defconfig  | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/62eaa63becb009a6f3daf075

  Results:     3 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-74-gc99f2b257bde3/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline=
-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-74-gc99f2b257bde3/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline=
-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.dmesg.crit: https://kernelci.org/test/case/id/62eaa63b=
ecb009a6f3daf078
        failing since 0 day (last pass: v5.10.131-cip13-24-ga6f4ea41fe167, =
first fail: v4.4.302-cip70-rt40)
        1 lines

    2022-08-03T16:45:14.867566  / # =

    2022-08-03T16:45:14.874580  =

    2022-08-03T16:45:19.890300  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/720591/extract-nfsrootfs-v85ag0xx'
    2022-08-03T16:45:19.901074  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/720591/extract-nfsrootfs-</lib/lava/dispatcher/tmp/720591/extract-nf=
srootfs-v                         85ag0xx'
    2022-08-03T16:45:21.957583  / # export NFS_SERVER_IP=3D'172.16.3.3'
    2022-08-03T16:45:21.968427  export NFS_SERVER_IP=3D'172.16.3.3'
    2022-08-03T16:45:22.079654  / # #
    2022-08-03T16:45:22.086391  #
    2022-08-03T16:45:22.197366  / # export SHELL=3D/bin/sh
    2022-08-03T16:45:22.203599  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/62eaa3ebe30a6cbed9daf06e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-74-gc99f2b257bde3/arm/omap2plus_defconfig/gcc-10/lab-broonie/bas=
eline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-74-gc99f2b257bde3/arm/omap2plus_defconfig/gcc-10/lab-broonie/bas=
eline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/62eaa3ebe30a6=
cbed9daf06f
        new failure (last pass: v5.10.131-cip13) =

 =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-cip     | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/62eaa1b3d6f280e03ddaf07d

  Results:     3 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-74-gc99f2b257bde3/arm/omap2plus_defconfig/gcc-10/lab-cip/baselin=
e-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-74-gc99f2b257bde3/arm/omap2plus_defconfig/gcc-10/lab-cip/baselin=
e-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.dmesg.crit: https://kernelci.org/test/case/id/62eaa1b3=
d6f280e03ddaf080
        failing since 0 day (last pass: v5.10.131-cip13, first fail: v4.4.3=
02-cip70-rt40)
        1 lines

    2022-08-03T16:26:00.233722  / # =

    2022-08-03T16:26:00.243555  =

    2022-08-03T16:26:05.300461  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/720576/extract-nfsrootfs-d7f6zfor'
    2022-08-03T16:26:05.311587  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/720576/extract-nfsrootfs-</lib/lava/dispatcher/tmp/720576/extract-nf=
srootfs-d                         7f6zfor'
    2022-08-03T16:26:07.424601  / # export NFS_SERVER_IP=3D'172.16.3.3'
    2022-08-03T16:26:07.435124  export NFS_SERVER_IP=3D'172.16.3.3'
    2022-08-03T16:26:07.595615  / # #
    2022-08-03T16:26:07.602726  #
    2022-08-03T16:26:07.737399  / # export SHELL=3D/bin/sh
    2022-08-03T16:26:07.744021  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =20

