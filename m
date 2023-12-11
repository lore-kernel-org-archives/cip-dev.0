Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783CFC10F07
	for <webhook@archiver.kernel.org>; Mon, 11 Dec 2023 10:22:52 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web11.5370.1702290166690617722
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 11 Dec 2023 02:22:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=RdsKNaxF;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.177, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d045097b4cso23708765ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 11 Dec 2023 02:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702290165; x=1702894965; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=x+sTDtZeAxk9I7zedeA9UQ30w4WCFt5xO6tBuxPkFZI=;
        b=RdsKNaxF5fR7L7pCT5QFg+fAhWd4264Z8/fIYlSwoVGOGQo05k6zZVPm+mrrCkNLZH
         aOVpoE/P2FkoOkSKVAFHaXhFADL3gezlyWkTytVjJlH9bRBccJWFtHm+ywVSkfO+TJZM
         GPuzLMXv5uH13xb/l9R63DWyD1JWqusA82JH77xeW7hQeWjyKlzuMdECSjXdFBgqf/dm
         QfRgyH2fN72MpyrdcAafPxoSpIJ+/gRQAdr2vEZdc3MXIKVKr/GCU59WVuB8ulZbE4C8
         S4I18CuIwWnKFuInHxxioL6qrp3B/EUbGFPHg4TVQskNC/iGqUxR+b0WRHGiEA2Y7PH2
         cVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702290165; x=1702894965;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x+sTDtZeAxk9I7zedeA9UQ30w4WCFt5xO6tBuxPkFZI=;
        b=O6DLBBODAlae/4zsds/p0z8rocwoHxp71apLiWbmveRM88DsShzd9eIlbOPlUAHxwu
         05eL3OLLZpdxDWzk/s/jtNst/jV2UPo+ZhXoJLgns2B+/cirw6YpmhQvcpjRSdnjEsXs
         RAStEbykLR8misqJh8a9wxI99C2C3St2eHRhc/QNCGJj+NAg2Y4MrPdSRXi4HshCEZND
         WRqVxx37ycUU4r50f3BLXAfSRXJ81Pt7HU+HVE4dRlZUsCr/+hiZoN8IMpAt1xmK/2Mn
         oaUO15dRdDOjaaMu6MwuXMFKOaHWKywMbOptLb/t1RZkY3s3diFGT/CYzxCqetAAy0O5
         axvg==
X-Gm-Message-State: AOJu0Yxww+6PtmJps3uBca0u1w1igCjcXZEjYjC9kWHrkCHdCHOiV7Zu
	NVRyl9qjBcVRs8uyM2EFfZqqZzBrxnwSIwO+WXZnjg==
X-Google-Smtp-Source: AGHT+IF6GjShdbHgle7wGs/9fKepjlmI7tVl2fbK8gyU2qQo86FaKIE9bac3zcEU3x6KrS/9lBt/Sg==
X-Received: by 2002:a17:902:d4cb:b0:1cf:c329:6204 with SMTP id o11-20020a170902d4cb00b001cfc3296204mr1705345plg.14.1702290165304;
        Mon, 11 Dec 2023 02:22:45 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jd4-20020a170903260400b001d1d2726130sm6294428plb.240.2023.12.11.02.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 02:22:44 -0800 (PST)
Message-ID: <6576e2f4.170a0220.f3310.0cb2@mx.google.com>
Date: Mon, 11 Dec 2023 02:22:44 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-63-gfdfe1fbf93bc6
Subject: cip/linux-5.10.y-cip baseline-nfs: 51 runs,
 11 regressions (v5.10.201-cip41-63-gfdfe1fbf93bc6)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Dec 2023 10:22:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14007

cip/linux-5.10.y-cip baseline-nfs: 51 runs, 11 regressions (v5.10.201-cip41=
-63-gfdfe1fbf93bc6)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
at91sam9g20ek            | arm   | lab-broonie   | gcc-10   | multi_v5_defc=
onfig           | 1          =

beaglebone-black         | arm   | lab-broonie   | gcc-10   | omap2plus_def=
config          | 1          =

beaglebone-black         | arm   | lab-cip       | gcc-10   | omap2plus_def=
config          | 1          =

imx6q-sabrelite          | arm   | lab-collabora | gcc-10   | multi_v7_defc=
onfig           | 1          =

juno-uboot               | arm64 | lab-broonie   | gcc-10   | cip://5.10.y-=
...64_defconfig | 1          =

juno-uboot               | arm64 | lab-broonie   | gcc-10   | defconfig    =
                | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
                | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+kse=
lftest          | 1          =

rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig    =
                | 1          =

rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig+kse=
lftest          | 1          =

sun50i-a64-pine64-plus   | arm64 | lab-broonie   | gcc-10   | defconfig    =
                | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-63-gfdfe1fbf93bc6/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-63-gfdfe1fbf93bc6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      fdfe1fbf93bc6fe6ed2708f11c2613bef556fdeb =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
at91sam9g20ek            | arm   | lab-broonie   | gcc-10   | multi_v5_defc=
onfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6576dc2ad57e4f9b95e13503

  Results:     47 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline=
-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline=
-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armel/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6576dc2ad57e4f9b95e13538
        new failure (last pass: v5.10.201-cip41-46-g596f4c151d286)

    2023-12-11T09:53:13.626989  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 340254_1.6.2=
.4.1>
    2023-12-11T09:53:13.748802  #
    2023-12-11T09:53:13.852146  / # #export SHELL=3D/bin/sh
    2023-12-11T09:53:13.852951  =

    2023-12-11T09:53:13.954929  / # export SHELL=3D/bin/sh. /lava-340254/en=
vironment
    2023-12-11T09:53:13.955723  =

    2023-12-11T09:53:14.057710  / # . /lava-340254/environment/lava-340254/=
bin/lava-test-runner /lava-340254/1
    2023-12-11T09:53:14.059115  =

    2023-12-11T09:53:14.062958  / # /lava-340254/bin/lava-test-runner /lava=
-340254/1
    2023-12-11T09:53:14.461179  + export TESTRUN_ID=3D1_bootrr =

    ... (14 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
beaglebone-black         | arm   | lab-broonie   | gcc-10   | omap2plus_def=
config          | 1          =


  Details:     https://kernelci.org/test/plan/id/6576dbbba8260c9962e13483

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm/omap2plus_defconfig/gcc-10/lab-broonie/baselin=
e-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm/omap2plus_defconfig/gcc-10/lab-broonie/baselin=
e-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6576dbbba8260c9962e134b9
        failing since 331 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-11T09:51:23.200527  <8>[   46.651894] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 340249_1.6.2.4.1>
    2023-12-11T09:51:23.325180  / # #
    2023-12-11T09:51:23.426806  export SHELL=3D/bin/sh
    2023-12-11T09:51:23.427217  #
    2023-12-11T09:51:23.528668  / # export SHELL=3D/bin/sh. /lava-340249/en=
vironment
    2023-12-11T09:51:23.529107  =

    2023-12-11T09:51:23.630443  / # . /lava-340249/environment/lava-340249/=
bin/lava-test-runner /lava-340249/1
    2023-12-11T09:51:23.630840  =

    2023-12-11T09:51:23.635394  / # /lava-340249/bin/lava-test-runner /lava=
-340249/1
    2023-12-11T09:51:23.852425  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
beaglebone-black         | arm   | lab-cip       | gcc-10   | omap2plus_def=
config          | 1          =


  Details:     https://kernelci.org/test/plan/id/6576dfaf9fa91ea88fe1347b

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nf=
s-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nf=
s-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6576dfaf9fa91ea88fe134af
        failing since 331 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-11T10:08:07.609216  + set +x
    2023-12-11T10:08:07.613543  <8>[   44.872978] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1056337_1.6.2.4.1>
    2023-12-11T10:08:07.847279  / # #
    2023-12-11T10:08:07.949178  export SHELL=3D/bin/sh
    2023-12-11T10:08:07.949937  #
    2023-12-11T10:08:08.051068  / # export SHELL=3D/bin/sh. /lava-1056337/e=
nvironment
    2023-12-11T10:08:08.051848  =

    2023-12-11T10:08:08.153203  / # . /lava-1056337/environment/lava-105633=
7/bin/lava-test-runner /lava-1056337/1
    2023-12-11T10:08:08.154426  =

    2023-12-11T10:08:08.160119  / # /lava-1056337/bin/lava-test-runner /lav=
a-1056337/1 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
imx6q-sabrelite          | arm   | lab-collabora | gcc-10   | multi_v7_defc=
onfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6576db8af064fe6450e13485

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-nfs-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-nfs-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6576db8af064fe6450e1348a
        failing since 331 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-11T09:51:09.854143  / # #

    2023-12-11T09:51:09.954701  export SHELL=3D/bin/sh

    2023-12-11T09:51:09.954833  #

    2023-12-11T09:51:10.055335  / # export SHELL=3D/bin/sh. /lava-12243974/=
environment

    2023-12-11T09:51:10.055464  =


    2023-12-11T09:51:10.155960  / # . /lava-12243974/environment/lava-12243=
974/bin/lava-test-runner /lava-12243974/1

    2023-12-11T09:51:10.156197  =


    2023-12-11T09:51:10.167043  / # /lava-12243974/bin/lava-test-runner /la=
va-12243974/1

    2023-12-11T09:51:10.306744  + export TESTRUN_ID=3D1_bootrr

    2023-12-11T09:51:10.306856  + cd /lava-12243974/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
juno-uboot               | arm64 | lab-broonie   | gcc-10   | cip://5.10.y-=
...64_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6576dfae7274e0dec9e13478

  Results:     47 PASS, 13 FAIL, 1 SKIP
  Full config: cip://5.10.y-cip/arm64/qemu_arm64_defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm64/cip---5.10.y-cip-arm64-qemu_arm64_defconfig/=
gcc-10/lab-broonie/baseline-nfs-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm64/cip---5.10.y-cip-arm64-qemu_arm64_defconfig/=
gcc-10/lab-broonie/baseline-nfs-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6576dfaf7274e0dec9e134b2
        failing since 67 days (last pass: v5.10.184-cip36-8-gb192df20e8c9, =
first fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-12-11T10:08:16.250262  / # #
    2023-12-11T10:08:16.353114  export SHELL=3D/bin/sh
    2023-12-11T10:08:16.353913  #
    2023-12-11T10:08:16.455884  / # export SHELL=3D/bin/sh. /lava-340322/en=
vironment
    2023-12-11T10:08:16.456740  =

    2023-12-11T10:08:16.558840  / # . /lava-340322/environment/lava-340322/=
bin/lava-test-runner /lava-340322/1
    2023-12-11T10:08:16.559636  =

    2023-12-11T10:08:16.578976  / # /lava-340322/bin/lava-test-runner /lava=
-340322/1
    2023-12-11T10:08:16.717867  + export TESTRUN_ID=3D1_bootrr
    2023-12-11T10:08:16.718550  + cd /lava-340322/1/tests/1_bootrr =

    ... (9 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
juno-uboot               | arm64 | lab-broonie   | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/6576db3ad5a4193735e134f1

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-ju=
no-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-ju=
no-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6576db3ad5a4193735e1352d
        failing since 67 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.194-cip39-1-g53e59f50ca3ff)

    2023-12-11T09:49:18.942234  <8>[   43.673145] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 340221_1.6.2.4.1>
    2023-12-11T09:49:19.050465  / # #
    2023-12-11T09:49:19.153265  export SHELL=3D/bin/sh
    2023-12-11T09:49:19.154071  #
    2023-12-11T09:49:19.256000  / # export SHELL=3D/bin/sh. /lava-340221/en=
vironment
    2023-12-11T09:49:19.256779  =

    2023-12-11T09:49:19.358890  / # . /lava-340221/environment/lava-340221/=
bin/lava-test-runner /lava-340221/1
    2023-12-11T09:49:19.360179  =

    2023-12-11T09:49:19.375582  / # /lava-340221/bin/lava-test-runner /lava=
-340221/1
    2023-12-11T09:49:19.519538  + export TESTRUN_ID=3D1_bootrr =

    ... (10 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/6576dc52c7408f469ae1347b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm64/defconfig/gcc-10/lab-cip/baseline-nfs-r8a774=
a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm64/defconfig/gcc-10/lab-cip/baseline-nfs-r8a774=
a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6576dc52c7408f469=
ae1347c
        failing since 67 days (last pass: v5.10.194-cip39, first fail: v5.1=
0.194-cip39-1-g53e59f50ca3ff) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+kse=
lftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6576de46bbce33dff1e13483

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-=
nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-=
nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6576de46bbce33dff=
1e13484
        failing since 116 days (last pass: v5.10.186-cip37-13-g260094841fe1=
a, first fail: v5.10.186-cip37-14-gc9b5a049d8ea) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/6576d9740e216714dfe1348a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm64/defconfig/gcc-10/lab-collabora/baseline-nfs-=
rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm64/defconfig/gcc-10/lab-collabora/baseline-nfs-=
rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6576d9740e216714dfe1348f
        failing since 67 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.194-cip39-1-g53e59f50ca3ff)

    2023-12-11T09:41:59.788040  / # #

    2023-12-11T09:42:01.048796  export SHELL=3D/bin/sh

    2023-12-11T09:42:01.059761  #

    2023-12-11T09:42:01.060266  / # export SHELL=3D/bin/sh

    2023-12-11T09:42:02.803552  / # . /lava-12243957/environment

    2023-12-11T09:42:06.008963  /lava-12243957/bin/lava-test-runner /lava-1=
2243957/1

    2023-12-11T09:42:06.020404  . /lava-12243957/environment

    2023-12-11T09:42:06.022910  / # /lava-12243957/bin/lava-test-runner /la=
va-12243957/1

    2023-12-11T09:42:06.203592  + export TESTRUN_ID=3D1_bootrr

    2023-12-11T09:42:06.204124  + cd /lava-12243957/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig+kse=
lftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6576dc1e950d6920dfe13475

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm64/defconfig+kselftest/gcc-10/lab-collabora/bas=
eline-nfs-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm64/defconfig+kselftest/gcc-10/lab-collabora/bas=
eline-nfs-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6576dc1e950d6920dfe1347a
        failing since 67 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.194-cip39-1-g53e59f50ca3ff)

    2023-12-11T09:53:03.233284  / # #

    2023-12-11T09:53:04.491429  export SHELL=3D/bin/sh

    2023-12-11T09:53:04.502131  #

    2023-12-11T09:53:06.241445  / # export SHELL=3D/bin/sh. /lava-12243987/=
environment

    2023-12-11T09:53:06.252151  =


    2023-12-11T09:53:06.252494  / # . /lava-12243987/environment

    2023-12-11T09:53:09.438835  /lava-12243987/bin/lava-test-runner /lava-1=
2243987/1

    2023-12-11T09:53:09.455643  / # /lava-12243987/bin/lava-test-runner /la=
va-12243987/1

    2023-12-11T09:53:09.811849  + export TESTRUN_ID=3D1_bootrr

    2023-12-11T09:53:09.812241  + cd /lava-12243987/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
sun50i-a64-pine64-plus   | arm64 | lab-broonie   | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/6576da3fe44478e7fde134df

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-su=
n50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-su=
n50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6576da3fe44478e7fde1350b
        failing since 331 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-11T09:45:01.286308  <8>[   30.617887] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 340195_1.6.2.4.1>
    2023-12-11T09:45:01.401113  / # #
    2023-12-11T09:45:01.503312  export SHELL=3D/bin/sh
    2023-12-11T09:45:01.503919  #
    2023-12-11T09:45:01.605738  / # export SHELL=3D/bin/sh. /lava-340195/en=
vironment
    2023-12-11T09:45:01.606397  =

    2023-12-11T09:45:01.708273  / # . /lava-340195/environment/lava-340195/=
bin/lava-test-runner /lava-340195/1
    2023-12-11T09:45:01.709123  =

    2023-12-11T09:45:01.712945  / # /lava-340195/bin/lava-test-runner /lava=
-340195/1
    2023-12-11T09:45:01.845778  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =20

