Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C016C4167B
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 20:43:10 +0000 (UTC)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
 by mx.groups.io with SMTP id smtpd.web11.103015.1701981786181956510
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 07 Dec 2023 12:43:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=bZlVqeoc;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.180, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5c68b5cf14bso1038105a12.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 07 Dec 2023 12:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701981785; x=1702586585; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ampKMXu/oSQ37dp0wR3mnd8oKzPzSDF3ZI2QnR9wLi0=;
        b=bZlVqeocxuJPc22sBXDIlNKLjCYhoN+OXwe/v/TjdRWxlov8bowbjYCBqqczn92efF
         VAXfuUwU3oeEDrBPfnvkTmT6rTp631zadBk+QLOWIXwM5ItZik/65sWTPR2G9szLx/Uh
         9OwqjYZ1GO2x+JZEME7DyhHDLuf69cjTAJWnAcPXhHFte3O9JO8Vts2CkTi8+sJyDt28
         XLRRqqupV+p3ctGH+T1LjTTF1C7eQfozL2+eZ4vnSqIcWlDLzXAJ288GevtAzU5+GbAz
         JWKd/JEBEYp/ZhFsH9U84scYT927zF2zvdIo3pxEtcyST/iOOwcYWvmIa7qTAhZlCDH7
         ff/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701981785; x=1702586585;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ampKMXu/oSQ37dp0wR3mnd8oKzPzSDF3ZI2QnR9wLi0=;
        b=go+a3ICfLE7oz+bX3TQ9MkDFDjXqi4xDQiZYT/O4VNziPSFi35ipySnqj0cAPrkc0C
         i5VdBCgKL3DMitePI1uSQE49UBRZWifPVSZt53OXDAwbb8qDe8XC2pjYz/cw0gpVrfNc
         DHJdA6heDFzWnBTJhUcP77aS3sfihz8yPlLminfxG1U0uk1DO5ZRTFXD6GLN5H0ZvqHd
         z/sja2s14ZVmMPY3eyCehm1eWb+3hAtYLv3NQlplUVOUfWyqrvP65hA8FTqUdR3PU1+k
         pokOEhkyFzwijFgsqPirGd79jSkEjjNvhEg/9/3zCJXvj7Kjm+8mWwwW+PVGzFTKJENt
         U46A==
X-Gm-Message-State: AOJu0Yx3AbfZlmqyR6v0FnTV5cQQ8qxaX/zlyatBO88BSrNl3/CD8CTt
	9w8mKwW/AnL1mol5F4h/f5fNKAFQwirNT6Z1lPwMUQ==
X-Google-Smtp-Source: AGHT+IGnMAaB4AYmr3Wdl03jbjeY+N663a1roNn0dJytpY3NJcgBIli2LzA/46dwD2a12QUATzykRg==
X-Received: by 2002:a17:902:bc8c:b0:1d0:6ffd:f222 with SMTP id bb12-20020a170902bc8c00b001d06ffdf222mr2875937plb.120.1701981784804;
        Thu, 07 Dec 2023 12:43:04 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 3-20020a170902c10300b001d1cd7e4acesm238400pli.68.2023.12.07.12.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 12:43:04 -0800 (PST)
Message-ID: <65722e58.170a0220.d07ef.1849@mx.google.com>
Date: Thu, 07 Dec 2023 12:43:04 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-28-ga386bc478aa6b
Subject: cip/linux-5.10.y-cip baseline-nfs: 55 runs,
 14 regressions (v5.10.201-cip41-28-ga386bc478aa6b)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 20:43:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13909

cip/linux-5.10.y-cip baseline-nfs: 55 runs, 14 regressions (v5.10.201-cip41=
-28-ga386bc478aa6b)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
beaglebone-black             | arm   | lab-cip       | gcc-10   | multi_v7_=
defconfig           | 1          =

beaglebone-black             | arm   | lab-broonie   | gcc-10   | omap2plus=
_defconfig          | 1          =

beaglebone-black             | arm   | lab-cip       | gcc-10   | omap2plus=
_defconfig          | 1          =

imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig           | 1          =

juno-uboot                   | arm64 | lab-broonie   | gcc-10   | cip://5.1=
0.y-...64_defconfig | 1          =

juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =

juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
                    | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
                    | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
+kselftest          | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
                    | 1          =

rk3399-rock-pi-4b            | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =

rk3399-rock-pi-4b            | arm64 | lab-collabora | gcc-10   | defconfig=
                    | 1          =

sun50i-a64-pine64-plus       | arm64 | lab-broonie   | gcc-10   | defconfig=
                    | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-28-ga386bc478aa6b/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-28-ga386bc478aa6b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a386bc478aa6b422e6dd5d92a540987ddfca9397 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
beaglebone-black             | arm   | lab-cip       | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65722a7e69bb16078de13479

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs=
-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs=
-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65722a7e69bb16078de134aa
        failing since 327 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-07T20:25:47.351617  + set +x
    2023-12-07T20:25:47.355725  <8>[   47.152664] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1053545_1.6.2.4.1>
    2023-12-07T20:25:47.471187  / # #
    2023-12-07T20:25:47.572670  export SHELL=3D/bin/sh
    2023-12-07T20:25:47.573122  #
    2023-12-07T20:25:47.674064  / # export SHELL=3D/bin/sh. /lava-1053545/e=
nvironment
    2023-12-07T20:25:47.674515  =

    2023-12-07T20:25:47.775494  / # . /lava-1053545/environment/lava-105354=
5/bin/lava-test-runner /lava-1053545/1
    2023-12-07T20:25:47.776264  =

    2023-12-07T20:25:47.780321  / # /lava-1053545/bin/lava-test-runner /lav=
a-1053545/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | omap2plus=
_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6572253247e9c432c8e134a9

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm/omap2plus_defconfig/gcc-10/lab-broonie/baselin=
e-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm/omap2plus_defconfig/gcc-10/lab-broonie/baselin=
e-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6572253247e9c432c8e134e3
        failing since 327 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-07T20:03:26.868971  + set +x
    2023-12-07T20:03:26.873064  <8>[   56.028772] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 319668_1.6.2.4.1>
    2023-12-07T20:03:26.994012  / # #
    2023-12-07T20:03:27.095689  export SHELL=3D/bin/sh
    2023-12-07T20:03:27.096214  #
    2023-12-07T20:03:27.197804  / # export SHELL=3D/bin/sh. /lava-319668/en=
vironment
    2023-12-07T20:03:27.198193  =

    2023-12-07T20:03:27.299422  / # . /lava-319668/environment/lava-319668/=
bin/lava-test-runner /lava-319668/1
    2023-12-07T20:03:27.300079  =

    2023-12-07T20:03:27.304423  / # /lava-319668/bin/lava-test-runner /lava=
-319668/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
beaglebone-black             | arm   | lab-cip       | gcc-10   | omap2plus=
_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/657225f7c21fba3070e1347f

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nf=
s-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nf=
s-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/657225f8c21fba3070e134b2
        failing since 327 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-07T20:07:00.130808  + set +x
    2023-12-07T20:07:00.134121  <8>[   44.257855] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1053529_1.6.2.4.1>
    2023-12-07T20:07:00.377208  #
    2023-12-07T20:07:00.479567  / # #export SHELL=3D/bin/sh
    2023-12-07T20:07:00.480211  =

    2023-12-07T20:07:00.581505  / # export SHELL=3D/bin/sh. /lava-1053529/e=
nvironment
    2023-12-07T20:07:00.582154  =

    2023-12-07T20:07:00.683502  / # . /lava-1053529/environment/lava-105352=
9/bin/lava-test-runner /lava-1053529/1
    2023-12-07T20:07:00.684554  =

    2023-12-07T20:07:00.691199  / # /lava-1053529/bin/lava-test-runner /lav=
a-1053529/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/657226422293d5bd87e134c0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-nfs-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-nfs-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/657226422293d5bd87e134c9
        failing since 327 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-07T20:08:19.566494  / # #

    2023-12-07T20:08:19.669057  export SHELL=3D/bin/sh

    2023-12-07T20:08:19.669849  #

    2023-12-07T20:08:19.771839  / # export SHELL=3D/bin/sh. /lava-12210296/=
environment

    2023-12-07T20:08:19.772628  =


    2023-12-07T20:08:19.874292  / # . /lava-12210296/environment/lava-12210=
296/bin/lava-test-runner /lava-12210296/1

    2023-12-07T20:08:19.875643  =


    2023-12-07T20:08:19.879959  / # /lava-12210296/bin/lava-test-runner /la=
va-12210296/1

    2023-12-07T20:08:20.085342  + export TESTRUN_ID=3D1_bootrr

    2023-12-07T20:08:20.085506  + cd /lava-12210296/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
juno-uboot                   | arm64 | lab-broonie   | gcc-10   | cip://5.1=
0.y-...64_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/657224e40f3f0356fce13504

  Results:     47 PASS, 13 FAIL, 1 SKIP
  Full config: cip://5.10.y-cip/arm64/qemu_arm64_defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm64/cip---5.10.y-cip-arm64-qemu_arm64_defconfig/=
gcc-10/lab-broonie/baseline-nfs-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm64/cip---5.10.y-cip-arm64-qemu_arm64_defconfig/=
gcc-10/lab-broonie/baseline-nfs-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/657224e40f3f0356fce13542
        failing since 64 days (last pass: v5.10.184-cip36-8-gb192df20e8c9, =
first fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-12-07T20:02:20.535032  <8>[   55.942183] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 319650_1.6.2.4.1>
    2023-12-07T20:02:20.653904  / # #
    2023-12-07T20:02:20.756651  export SHELL=3D/bin/sh
    2023-12-07T20:02:20.757392  #
    2023-12-07T20:02:20.859324  / # export SHELL=3D/bin/sh. /lava-319650/en=
vironment
    2023-12-07T20:02:20.860088  =

    2023-12-07T20:02:20.962127  / # . /lava-319650/environment/lava-319650/=
bin/lava-test-runner /lava-319650/1
    2023-12-07T20:02:20.963399  =

    2023-12-07T20:02:20.982607  / # /lava-319650/bin/lava-test-runner /lava=
-319650/1
    2023-12-07T20:02:21.078654  + export TESTRUN_ID=3D1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6572273c2f3caf9e0ae13498

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm64/defconfig+kselftest/gcc-10/lab-broonie/basel=
ine-nfs-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm64/defconfig+kselftest/gcc-10/lab-broonie/basel=
ine-nfs-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6572273c2f3caf9e0ae134d5
        failing since 13 days (last pass: v5.10.200-cip40, first fail: v5.1=
0.201-cip41-11-ga539098fe70dd)

    2023-12-07T20:12:05.320720  <8>[   54.291324] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 319689_1.6.2.4.1>
    2023-12-07T20:12:05.439462  / # #
    2023-12-07T20:12:05.541271  export SHELL=3D/bin/sh
    2023-12-07T20:12:05.541727  #
    2023-12-07T20:12:05.643037  / # export SHELL=3D/bin/sh. /lava-319689/en=
vironment
    2023-12-07T20:12:05.643500  =

    2023-12-07T20:12:05.744867  / # . /lava-319689/environment/lava-319689/=
bin/lava-test-runner /lava-319689/1
    2023-12-07T20:12:05.746302  =

    2023-12-07T20:12:05.752391  / # /lava-319689/bin/lava-test-runner /lava=
-319689/1
    2023-12-07T20:12:06.146881  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/657229947e2113e6a4e13479

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-ju=
no-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-ju=
no-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/657229957e2113e6a4e134b0
        failing since 64 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.194-cip39-1-g53e59f50ca3ff)

    2023-12-07T20:22:20.856139  <8>[   43.058726] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 319755_1.6.2.4.1>
    2023-12-07T20:22:20.973836  / # #
    2023-12-07T20:22:21.076588  export SHELL=3D/bin/sh
    2023-12-07T20:22:21.077401  #
    2023-12-07T20:22:21.179298  / # export SHELL=3D/bin/sh. /lava-319755/en=
vironment
    2023-12-07T20:22:21.180086  =

    2023-12-07T20:22:21.282127  / # . /lava-319755/environment/lava-319755/=
bin/lava-test-runner /lava-319755/1
    2023-12-07T20:22:21.283433  =

    2023-12-07T20:22:21.287820  / # /lava-319755/bin/lava-test-runner /lava=
-319755/1
    2023-12-07T20:22:21.450519  + export TESTRUN_ID=3D1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6572285399f2ba097ce134d7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm64/defconfig+kselftest/gcc-10/lab-broonie/basel=
ine-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm64/defconfig+kselftest/gcc-10/lab-broonie/basel=
ine-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6572285399f2ba097=
ce134d8
        new failure (last pass: v5.10.201-cip41-16-g3c85fba3b6e5d) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/65722867d4248448a5e134f6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-me=
son-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-me=
son-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65722867d4248448a=
5e134f7
        new failure (last pass: v5.10.201-cip41-16-g3c85fba3b6e5d) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6572258e914db21373e13555

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-=
nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-=
nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6572258e914db2137=
3e13556
        failing since 113 days (last pass: v5.10.186-cip37-13-g260094841fe1=
a, first fail: v5.10.186-cip37-14-gc9b5a049d8ea) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/657227b9b19bdb6eaae1347c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm64/defconfig/gcc-10/lab-cip/baseline-nfs-r8a774=
a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm64/defconfig/gcc-10/lab-cip/baseline-nfs-r8a774=
a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/657227b9b19bdb6ea=
ae1347d
        failing since 64 days (last pass: v5.10.194-cip39, first fail: v5.1=
0.194-cip39-1-g53e59f50ca3ff) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
rk3399-rock-pi-4b            | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6572256d914db21373e1352f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm64/defconfig+kselftest/gcc-10/lab-collabora/bas=
eline-nfs-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm64/defconfig+kselftest/gcc-10/lab-collabora/bas=
eline-nfs-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6572256d914db21373e13538
        failing since 64 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.194-cip39-1-g53e59f50ca3ff)

    2023-12-07T20:09:13.659322  / # #

    2023-12-07T20:09:14.920715  export SHELL=3D/bin/sh

    2023-12-07T20:09:14.931650  #

    2023-12-07T20:09:14.932116  / # export SHELL=3D/bin/sh

    2023-12-07T20:09:16.676677  . /lava-12210286/environment

    2023-12-07T20:09:16.687627  / # . /lava-12210286/environment

    2023-12-07T20:09:19.883501  /lava-12210286/bin/lava-test-runner /lava-1=
2210286/1

    2023-12-07T20:09:19.896195  / # /lava-12210286/bin/lava-test-runner /la=
va-12210286/1

    2023-12-07T20:09:20.306231  + export TESTRUN_ID=3D1_bootrr

    2023-12-07T20:09:20.306714  + cd /lava-12210286/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
rk3399-rock-pi-4b            | arm64 | lab-collabora | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/657226d55bb4deeffce13501

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm64/defconfig/gcc-10/lab-collabora/baseline-nfs-=
rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm64/defconfig/gcc-10/lab-collabora/baseline-nfs-=
rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/657226d55bb4deeffce1350a
        failing since 64 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.194-cip39-1-g53e59f50ca3ff)

    2023-12-07T20:15:02.146304  / # #

    2023-12-07T20:15:03.407759  export SHELL=3D/bin/sh

    2023-12-07T20:15:03.418717  #

    2023-12-07T20:15:03.419184  / # export SHELL=3D/bin/sh

    2023-12-07T20:15:05.163403  / # . /lava-12210309/environment

    2023-12-07T20:15:08.368322  /lava-12210309/bin/lava-test-runner /lava-1=
2210309/1

    2023-12-07T20:15:08.379813  . /lava-12210309/environment

    2023-12-07T20:15:08.380242  / # /lava-12210309/bin/lava-test-runner /la=
va-12210309/1

    2023-12-07T20:15:08.556840  + export TESTRUN_ID=3D1_bootrr

    2023-12-07T20:15:08.557244  + cd /lava-12210309/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
sun50i-a64-pine64-plus       | arm64 | lab-broonie   | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6572283f99f2ba097ce13475

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-su=
n50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-su=
n50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6572283f99f2ba097ce134a5
        failing since 327 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-07T20:16:35.877877  <8>[   49.012065] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 319740_1.6.2.4.1>
    2023-12-07T20:16:36.071694  / # #
    2023-12-07T20:16:36.173719  export SHELL=3D/bin/sh
    2023-12-07T20:16:36.174220  #
    2023-12-07T20:16:36.275649  / # export SHELL=3D/bin/sh. /lava-319740/en=
vironment
    2023-12-07T20:16:36.276127  =

    2023-12-07T20:16:36.377474  / # . /lava-319740/environment/lava-319740/=
bin/lava-test-runner /lava-319740/1
    2023-12-07T20:16:36.378197  =

    2023-12-07T20:16:36.381566  / # /lava-319740/bin/lava-test-runner /lava=
-319740/1
    2023-12-07T20:16:36.555403  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =20

