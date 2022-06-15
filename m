Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45450CCA473
	for <webhook@archiver.kernel.org>; Wed, 15 Jun 2022 09:05:04 +0000 (UTC)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by mx.groups.io with SMTP id smtpd.web12.2399.1655283896808983040
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 15 Jun 2022 02:04:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=haIpcafD;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.47,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f47.google.com with SMTP id a10so10662895pju.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 15 Jun 2022 02:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=K00xfO3wiPTAx1qCLdzy1IyO52yUZrgm/RifmES81gk=;
        b=haIpcafDPBDVPGXMG4LzKidieXDjyEqDeB1achrGROWAMoIIfjDSZvLoUQ2QzX8wGg
         lUQEpAEKVB1uL/oQkH9VMNf5ylOAvYdvG79Cz1mj+++qaoVFmxbAeF7oABGDJL+DJtMz
         SjHnodDUYZ+Vj18dAUsIrcd7Fn7aMFF9UvFo/SX42nlmtRCySDgjvRBcK1a1Lzj7C+k4
         VAiIAK6xgcSYMyqQaaUsfl0G6BLKGRsQKGA/4+lkDd6UIYQIW3lpwVQqBvOBphJSBfDn
         uIicuycQ82EMAjKawNtrQakfR1J1cLUWpzA4rj3YbMKvOZR+7bNeWulOFJdyykW7vSfs
         yPAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=K00xfO3wiPTAx1qCLdzy1IyO52yUZrgm/RifmES81gk=;
        b=7jv1mzG3tUygFb60Uygzt5sOuXgK4vEcQkLk6U6Pmk2Uf0SETFv7hlD4D/DM3G/2aI
         bUKGTnXyPqUlh+NflC+w0RkXcS//x0Ifmkso89b/CjRus6EapZ5tYFfp8IX34yqP4ITE
         OBHhOnlkvS4HQ5rJQ5Le3XHj9AhVi572XxfhYJLrltAruLSmnIYvpa7XHKp6Fg7Z2L/m
         ViunbkGR9U2yG+yU2T8u+L7ne1cOVDQ5DiphsKjCXxuDwXTdB2gFkP+CUZhf478uof16
         8zvxlJte1m+1dAH4sy1javFAdCDSXY8X2JFPPH32e19EXNMFlsePgNVVI5Dmb+xdCiV1
         LmZg==
X-Gm-Message-State: AJIora/X+/hyhHnpoDwXIadSLT7cjFXaVBln0JA/MD2RFT3OplGL6o4I
	73vkBMRZkRhRpBcygGeBFeowxCZIFsaTPBMA2fc=
X-Google-Smtp-Source: 
 AGRyM1unsmBUZLovrVnRiSezdPMG6FF5ImwkjvqVxcRLR1s3AOUrqGYtL2BN+bkW/TDG2Hi4LL6E3A==
X-Received: by 2002:a17:90b:1d83:b0:1e2:f63e:bc37 with SMTP id
 pf3-20020a17090b1d8300b001e2f63ebc37mr9048311pjb.119.1655283895095;
        Wed, 15 Jun 2022 02:04:55 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 w1-20020a62c701000000b0050dc7628148sm9179624pfg.34.2022.06.15.02.04.54
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 02:04:54 -0700 (PDT)
Message-ID: <62a9a0b6.1c69fb81.76fcb.b5eb@mx.google.com>
Date: Wed, 15 Jun 2022 02:04:54 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st5-312-g3a12bf5207d81
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test baseline: 63 runs,
 57 regressions (v4.4-st5-312-g3a12bf5207d81)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Jun 2022 09:05:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8561

cip-gitlab/ci/pavel/linux-test baseline: 63 runs, 57 regressions (v4.4-st5-=
312-g3a12bf5207d81)

Regressions Summary
-------------------

platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
at91-sama5d4_xplained      | arm   | lab-baylibre  | gcc-10   | multi_v7_de=
fconfig         | 1          =

beaglebone-black           | arm   | lab-broonie   | gcc-10   | multi_v7_de=
fconfig         | 1          =

beaglebone-black           | arm   | lab-cip       | gcc-10   | multi_v7_de=
fconfig         | 1          =

juno-uboot                 | arm64 | lab-broonie   | gcc-10   | defconfig  =
                | 1          =

odroid-xu3                 | arm   | lab-collabora | gcc-10   | exynos_defc=
onfig           | 1          =

qemu_arm-virt-gicv2        | arm   | lab-baylibre  | gcc-10   | multi_v7_de=
fconfig         | 1          =

qemu_arm-virt-gicv2        | arm   | lab-broonie   | gcc-10   | multi_v7_de=
fconfig         | 1          =

qemu_arm-virt-gicv2-uefi   | arm   | lab-baylibre  | gcc-10   | multi_v7_de=
fconfig         | 1          =

qemu_arm-virt-gicv2-uefi   | arm   | lab-broonie   | gcc-10   | multi_v7_de=
fconfig         | 1          =

qemu_arm-virt-gicv3        | arm   | lab-baylibre  | gcc-10   | multi_v7_de=
fconfig         | 1          =

qemu_arm-virt-gicv3        | arm   | lab-broonie   | gcc-10   | multi_v7_de=
fconfig         | 1          =

qemu_arm-virt-gicv3-uefi   | arm   | lab-baylibre  | gcc-10   | multi_v7_de=
fconfig         | 1          =

qemu_arm-virt-gicv3-uefi   | arm   | lab-broonie   | gcc-10   | multi_v7_de=
fconfig         | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-baylibre  | gcc-10   | defconfig  =
                | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-baylibre  | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-broonie   | gcc-10   | defconfig  =
                | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-baylibre  | gcc-10   | defconfig  =
                | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-baylibre  | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
                | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-baylibre  | gcc-10   | defconfig  =
                | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-baylibre  | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig  =
                | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-baylibre  | gcc-10   | defconfig  =
                | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-baylibre  | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
                | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

rk3288-veyron-jaq          | arm   | lab-collabora | gcc-10   | multi_v7_de=
fconfig         | 28         =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-312-g3a12bf5207d81/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-312-g3a12bf5207d81
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      3a12bf5207d810922b696a4c99c88e2841af6212 =



Test Regressions
---------------- =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
at91-sama5d4_xplained      | arm   | lab-baylibre  | gcc-10   | multi_v7_de=
fconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/62a757129245252702a39cd5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm/multi_v7_defconfig/gcc-10/lab-baylibre/bas=
eline-at91-sama5d4_xplained.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm/multi_v7_defconfig/gcc-10/lab-baylibre/bas=
eline-at91-sama5d4_xplained.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220610.1/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62a757129245252702a39=
cd6
        failing since 15 days (last pass: v5.10.112-cip6, first fail: v4.4-=
st5-297-gc0d53c2a5c03d) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
beaglebone-black           | arm   | lab-broonie   | gcc-10   | multi_v7_de=
fconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/62a757a562e279a560a39bdb

  Results:     4 PASS, 1 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm/multi_v7_defconfig/gcc-10/lab-broonie/base=
line-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm/multi_v7_defconfig/gcc-10/lab-broonie/base=
line-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220610.1/armel/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/62a757a562e279a5=
60a39be3
        failing since 15 days (last pass: v5.10.112-cip6, first fail: v4.4-=
st5-297-gc0d53c2a5c03d)
        1 lines

    2022-06-13T15:28:28.028437  / # =

    2022-06-13T15:28:28.033447  =

    2022-06-13T15:28:28.136308  / # #
    2022-06-13T15:28:28.141248  #
    2022-06-13T15:28:28.242428  / # export SHELL=3D/bin/sh
    2022-06-13T15:28:28.247478  export SHELL=3D/bin/sh
    2022-06-13T15:28:28.348630  / # . /lava-219892/environment
    2022-06-13T15:28:28.353771  . /lava-219892/environment
    2022-06-13T15:28:28.454930  / # /lava-219892/bin/lava-test-runner /lava=
-219892/0
    2022-06-13T15:28:28.459304  /lava-219892/bin/lava-test-runner /lava-219=
892/0 =

    ... (9 line(s) more)  =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
beaglebone-black           | arm   | lab-cip       | gcc-10   | multi_v7_de=
fconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/62a7562e8a92bf0f80a39c29

  Results:     4 PASS, 1 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline=
-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline=
-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220610.1/armel/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/62a7562e8a92bf0f=
80a39c30
        failing since 15 days (last pass: v5.10.112-cip6, first fail: v4.4-=
st5-297-gc0d53c2a5c03d)
        1 lines

    2022-06-13T15:22:02.128431  / # =

    2022-06-13T15:22:02.136304  =

    2022-06-13T15:22:02.240460  / # #
    2022-06-13T15:22:02.247571  #
    2022-06-13T15:22:02.349254  / # export SHELL=3D/bin/sh
    2022-06-13T15:22:02.354431  export SHELL=3D/bin/sh
    2022-06-13T15:22:02.456058  / # . /lava-697171/environment
    2022-06-13T15:22:02.462836  . /lava-697171/environment
    2022-06-13T15:22:02.564236  / # /lava-697171/bin/lava-test-runner /lava=
-697171/0
    2022-06-13T15:22:02.569962  /lava-697171/bin/lava-test-runner /lava-697=
171/0 =

    ... (9 line(s) more)  =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
juno-uboot                 | arm64 | lab-broonie   | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/62a7565eba9e217037a39bda

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm64/defconfig/gcc-10/lab-broonie/baseline-ju=
no-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm64/defconfig/gcc-10/lab-broonie/baseline-ju=
no-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220610.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62a7565eba9e217037a39=
bdb
        failing since 15 days (last pass: v5.10.112-cip6, first fail: v4.4-=
st5-297-gc0d53c2a5c03d) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
odroid-xu3                 | arm   | lab-collabora | gcc-10   | exynos_defc=
onfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/62a7560c8a92bf0f80a39bfa

  Results:     4 PASS, 1 FAIL, 2 SKIP
  Full config: exynos_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm/exynos_defconfig/gcc-10/lab-collabora/base=
line-odroid-xu3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm/exynos_defconfig/gcc-10/lab-collabora/base=
line-odroid-xu3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220610.1/armel/rootfs.cpio.gz =



  * baseline.bootrr.all-cpus-are-online: https://kernelci.org/test/case/id/=
62a7560c8a92bf0f80a39bfe
        failing since 15 days (last pass: v5.10.112-cip6, first fail: v4.4-=
st5-297-gc0d53c2a5c03d)

    2022-06-13T15:21:43.807990  /lava-6606788/1/../bin/lava-test-case
    2022-06-13T15:21:43.825106  [   14.727390] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dall-cpus-are-online RESULT=3Dfail>   =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm-virt-gicv2        | arm   | lab-baylibre  | gcc-10   | multi_v7_de=
fconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/62a7564cc534d87f41a39bf5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm/multi_v7_defconfig/gcc-10/lab-baylibre/bas=
eline-qemu_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm/multi_v7_defconfig/gcc-10/lab-baylibre/bas=
eline-qemu_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220610.1/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62a7564cc534d87f41a39=
bf6
        failing since 33 days (last pass: v5.10.109-cip5-384-g722204542e8a,=
 first fail: v4.4-st5-260-gb0fe64f485ff) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm-virt-gicv2        | arm   | lab-broonie   | gcc-10   | multi_v7_de=
fconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/62a75666ba9e217037a39be0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm/multi_v7_defconfig/gcc-10/lab-broonie/base=
line-qemu_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm/multi_v7_defconfig/gcc-10/lab-broonie/base=
line-qemu_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220610.1/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62a75666ba9e217037a39=
be1
        failing since 33 days (last pass: v5.10.109-cip5-384-g722204542e8a,=
 first fail: v4.4-st5-260-gb0fe64f485ff) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm-virt-gicv2-uefi   | arm   | lab-baylibre  | gcc-10   | multi_v7_de=
fconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/62a7578c8b28585c0da39bd3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm/multi_v7_defconfig/gcc-10/lab-baylibre/bas=
eline-qemu_arm-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm/multi_v7_defconfig/gcc-10/lab-baylibre/bas=
eline-qemu_arm-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220610.1/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62a7578c8b28585c0da39=
bd4
        failing since 33 days (last pass: v5.10.109-cip5-384-g722204542e8a,=
 first fail: v4.4-st5-260-gb0fe64f485ff) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm-virt-gicv2-uefi   | arm   | lab-broonie   | gcc-10   | multi_v7_de=
fconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/62a7586e180dca6973a39bd4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm/multi_v7_defconfig/gcc-10/lab-broonie/base=
line-qemu_arm-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm/multi_v7_defconfig/gcc-10/lab-broonie/base=
line-qemu_arm-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220610.1/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62a7586e180dca6973a39=
bd5
        failing since 33 days (last pass: v5.10.109-cip5-384-g722204542e8a,=
 first fail: v4.4-st5-260-gb0fe64f485ff) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm-virt-gicv3        | arm   | lab-baylibre  | gcc-10   | multi_v7_de=
fconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/62a756388a92bf0f80a39c37

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm/multi_v7_defconfig/gcc-10/lab-baylibre/bas=
eline-qemu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm/multi_v7_defconfig/gcc-10/lab-baylibre/bas=
eline-qemu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220610.1/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62a756388a92bf0f80a39=
c38
        failing since 33 days (last pass: v5.10.109-cip5-384-g722204542e8a,=
 first fail: v4.4-st5-260-gb0fe64f485ff) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm-virt-gicv3        | arm   | lab-broonie   | gcc-10   | multi_v7_de=
fconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/62a7577ed8ac1b3fb2a39be8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm/multi_v7_defconfig/gcc-10/lab-broonie/base=
line-qemu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm/multi_v7_defconfig/gcc-10/lab-broonie/base=
line-qemu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220610.1/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62a7577ed8ac1b3fb2a39=
be9
        failing since 33 days (last pass: v5.10.109-cip5-384-g722204542e8a,=
 first fail: v4.4-st5-260-gb0fe64f485ff) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm-virt-gicv3-uefi   | arm   | lab-baylibre  | gcc-10   | multi_v7_de=
fconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/62a75714fd52d20816a39bd6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm/multi_v7_defconfig/gcc-10/lab-baylibre/bas=
eline-qemu_arm-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm/multi_v7_defconfig/gcc-10/lab-baylibre/bas=
eline-qemu_arm-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220610.1/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62a75714fd52d20816a39=
bd7
        failing since 33 days (last pass: v5.10.109-cip5-384-g722204542e8a,=
 first fail: v4.4-st5-260-gb0fe64f485ff) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm-virt-gicv3-uefi   | arm   | lab-broonie   | gcc-10   | multi_v7_de=
fconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/62a7585a7540cb34fba39bec

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm/multi_v7_defconfig/gcc-10/lab-broonie/base=
line-qemu_arm-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm/multi_v7_defconfig/gcc-10/lab-broonie/base=
line-qemu_arm-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220610.1/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62a7585a7540cb34fba39=
bed
        failing since 33 days (last pass: v5.10.109-cip5-384-g722204542e8a,=
 first fail: v4.4-st5-260-gb0fe64f485ff) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-baylibre  | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/62a7554997fc01b1eaa39be8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm64/defconfig/gcc-10/lab-baylibre/baseline-q=
emu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm64/defconfig/gcc-10/lab-baylibre/baseline-q=
emu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220610.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62a7554997fc01b1eaa39=
be9
        failing since 34 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-baylibre  | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62a756c44e762d1e41a39be4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm64/defconfig+arm64-chromebook/gcc-10/lab-ba=
ylibre/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm64/defconfig+arm64-chromebook/gcc-10/lab-ba=
ylibre/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220610.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62a756c44e762d1e41a39=
be5
        failing since 34 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-broonie   | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/62a7554ea83e002acca39bdf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm64/defconfig/gcc-10/lab-broonie/baseline-qe=
mu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm64/defconfig/gcc-10/lab-broonie/baseline-qe=
mu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220610.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62a7554ea83e002acca39=
be0
        failing since 34 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62a75706d8ac1b3fb2a39bcf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm64/defconfig+arm64-chromebook/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm64/defconfig+arm64-chromebook/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220610.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62a75706d8ac1b3fb2a39=
bd0
        failing since 34 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-baylibre  | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/62a7554ca83e002acca39bd9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm64/defconfig/gcc-10/lab-baylibre/baseline-q=
emu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm64/defconfig/gcc-10/lab-baylibre/baseline-q=
emu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220610.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62a7554ca83e002acca39=
bda
        failing since 34 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-baylibre  | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62a75674ba9e217037a39bf0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm64/defconfig+arm64-chromebook/gcc-10/lab-ba=
ylibre/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm64/defconfig+arm64-chromebook/gcc-10/lab-ba=
ylibre/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220610.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62a75674ba9e217037a39=
bf1
        failing since 34 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/62a75550a83e002acca39be5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm64/defconfig/gcc-10/lab-broonie/baseline-qe=
mu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm64/defconfig/gcc-10/lab-broonie/baseline-qe=
mu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220610.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62a75550a83e002acca39=
be6
        failing since 34 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62a756b64e762d1e41a39bd5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm64/defconfig+arm64-chromebook/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm64/defconfig+arm64-chromebook/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220610.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62a756b64e762d1e41a39=
bd6
        failing since 34 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-baylibre  | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/62a7554aa83e002acca39bd5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm64/defconfig/gcc-10/lab-baylibre/baseline-q=
emu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm64/defconfig/gcc-10/lab-baylibre/baseline-q=
emu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220610.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62a7554aa83e002acca39=
bd6
        failing since 34 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-baylibre  | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62a756c54e762d1e41a39be7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm64/defconfig+arm64-chromebook/gcc-10/lab-ba=
ylibre/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm64/defconfig+arm64-chromebook/gcc-10/lab-ba=
ylibre/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220610.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62a756c54e762d1e41a39=
be8
        failing since 34 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/62a7554f6e65a783e0a39bd6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm64/defconfig/gcc-10/lab-broonie/baseline-qe=
mu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm64/defconfig/gcc-10/lab-broonie/baseline-qe=
mu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220610.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62a7554f6e65a783e0a39=
bd7
        failing since 34 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62a75707f3a10c2b5da39bd3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm64/defconfig+arm64-chromebook/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm64/defconfig+arm64-chromebook/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220610.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62a75707f3a10c2b5da39=
bd4
        failing since 34 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-baylibre  | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/62a7554d6e65a783e0a39bd0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm64/defconfig/gcc-10/lab-baylibre/baseline-q=
emu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm64/defconfig/gcc-10/lab-baylibre/baseline-q=
emu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220610.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62a7554d6e65a783e0a39=
bd1
        failing since 34 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-baylibre  | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62a756b001a19bcac4a39bde

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm64/defconfig+arm64-chromebook/gcc-10/lab-ba=
ylibre/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm64/defconfig+arm64-chromebook/gcc-10/lab-ba=
ylibre/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220610.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62a756b001a19bcac4a39=
bdf
        failing since 34 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/62a755516e65a783e0a39bdc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm64/defconfig/gcc-10/lab-broonie/baseline-qe=
mu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm64/defconfig/gcc-10/lab-broonie/baseline-qe=
mu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220610.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62a755516e65a783e0a39=
bdd
        failing since 34 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62a756b74e762d1e41a39bd8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm64/defconfig+arm64-chromebook/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm64/defconfig+arm64-chromebook/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220610.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62a756b74e762d1e41a39=
bd9
        failing since 34 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
rk3288-veyron-jaq          | arm   | lab-collabora | gcc-10   | multi_v7_de=
fconfig         | 28         =


  Details:     https://kernelci.org/test/plan/id/62a7b5338a4310d37ea39bcd

  Results:     39 PASS, 30 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm/multi_v7_defconfig/gcc-10/lab-collabora/ba=
seline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm/multi_v7_defconfig/gcc-10/lab-collabora/ba=
seline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220610.1/armel/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-vopl-probed: https://kernelci.org/test/case/id=
/62a7b5338a4310d37ea39bd2
        failing since 15 days (last pass: v5.10.112-cip6, first fail: v4.4-=
st5-297-gc0d53c2a5c03d)

    2022-06-13T22:07:35.475548  /lava-6606799/1/../bin/lava-test-case
    2022-06-13T22:07:35.497769  [   48.239990] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-vopl-probed RESULT=3Dfail>   =


  * baseline.bootrr.rockchip-vopb-probed: https://kernelci.org/test/case/id=
/62a7b5338a4310d37ea39bd3
        failing since 15 days (last pass: v5.10.112-cip6, first fail: v4.4-=
st5-297-gc0d53c2a5c03d)

    2022-06-13T22:07:34.415869  /lava-6606799/1/../bin/lava-test-case
    2022-06-13T22:07:34.443585  [   47.180785] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-vopb-probed RESULT=3Dfail>   =


  * baseline.bootrr.rockchip-usb-phy-grf-probed: https://kernelci.org/test/=
case/id/62a7b5338a4310d37ea39bd5
        failing since 15 days (last pass: v5.10.112-cip6, first fail: v4.4-=
st5-297-gc0d53c2a5c03d)

    2022-06-13T22:07:33.322507  /lava-6606799/1/../bin/lava-test-case
    2022-06-13T22:07:33.347217  [   46.088762] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-usb-phy-grf-probed RESULT=3Dfail>   =


  * baseline.bootrr.rockchip-pwm0-probed: https://kernelci.org/test/case/id=
/62a7b5338a4310d37ea39bdd
        failing since 15 days (last pass: v5.10.112-cip6, first fail: v4.4-=
st5-297-gc0d53c2a5c03d)

    2022-06-13T22:07:32.088808  /lava-6606799/1/../bin/lava-test-case
    2022-06-13T22:07:32.104372  [   44.847144] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-pwm0-probed RESULT=3Dfail>   =


  * baseline.bootrr.rockchip-pm-domain-pmu-probed: https://kernelci.org/tes=
t/case/id/62a7b5338a4310d37ea39bdf
        failing since 15 days (last pass: v5.10.112-cip6, first fail: v4.4-=
st5-297-gc0d53c2a5c03d)

    2022-06-13T22:07:30.973504  /lava-6606799/1/../bin/lava-test-case
    2022-06-13T22:07:31.000213  [   43.741822] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-pm-domain-pmu-probed RESULT=3Dfail>   =


  * baseline.bootrr.rockchip-pm-domain-driver-present: https://kernelci.org=
/test/case/id/62a7b5338a4310d37ea39be0
        failing since 15 days (last pass: v5.10.112-cip6, first fail: v4.4-=
st5-297-gc0d53c2a5c03d)

    2022-06-13T22:07:29.914752  /lava-6606799/1/../bin/lava-test-case
    2022-06-13T22:07:29.940807  [   42.679769] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-pm-domain-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.rockchip-iodomain-driver-present: https://kernelci.org/=
test/case/id/62a7b5348a4310d37ea39be2
        failing since 15 days (last pass: v5.10.112-cip6, first fail: v4.4-=
st5-297-gc0d53c2a5c03d)

    2022-06-13T22:07:27.792118  /lava-6606799/1/../bin/lava-test-case
    2022-06-13T22:07:27.817887  [   40.558806] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-iodomain-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.rockchip-i2s-probed: https://kernelci.org/test/case/id/=
62a7b5348a4310d37ea39be3
        failing since 15 days (last pass: v5.10.112-cip6, first fail: v4.4-=
st5-297-gc0d53c2a5c03d)

    2022-06-13T22:07:26.734282  /lava-6606799/1/../bin/lava-test-case
    2022-06-13T22:07:26.757894  [   39.499973] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-i2s-probed RESULT=3Dfail>   =


  * baseline.bootrr.rockcip-i2s-driver-present: https://kernelci.org/test/c=
ase/id/62a7b5348a4310d37ea39be4
        failing since 15 days (last pass: v5.10.112-cip6, first fail: v4.4-=
st5-297-gc0d53c2a5c03d)

    2022-06-13T22:07:25.674490  /lava-6606799/1/../bin/lava-test-case
    2022-06-13T22:07:25.699068  [   38.439979] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockcip-i2s-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.rockchip-dp-phy-grf-probed: https://kernelci.org/test/c=
ase/id/62a7b5348a4310d37ea39be5
        failing since 15 days (last pass: v5.10.112-cip6, first fail: v4.4-=
st5-297-gc0d53c2a5c03d)

    2022-06-13T22:07:24.614497  /lava-6606799/1/../bin/lava-test-case
    2022-06-13T22:07:24.639142  [   37.379658] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-dp-phy-grf-probed RESULT=3Dfail>   =


  * baseline.bootrr.rockchip-dp-phy-driver-present: https://kernelci.org/te=
st/case/id/62a7b5348a4310d37ea39be6
        failing since 15 days (last pass: v5.10.112-cip6, first fail: v4.4-=
st5-297-gc0d53c2a5c03d)

    2022-06-13T22:07:23.556688  /lava-6606799/1/../bin/lava-test-case
    2022-06-13T22:07:23.580398  [   36.320781] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-dp-phy-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.rockchip-dp-edp-probed: https://kernelci.org/test/case/=
id/62a7b5348a4310d37ea39be7
        failing since 15 days (last pass: v5.10.112-cip6, first fail: v4.4-=
st5-297-gc0d53c2a5c03d)

    2022-06-13T22:07:22.496908  /lava-6606799/1/../bin/lava-test-case
    2022-06-13T22:07:22.519592  [   35.261250] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-dp-edp-probed RESULT=3Dfail>   =


  * baseline.bootrr.rockchip-dp-driver-present: https://kernelci.org/test/c=
ase/id/62a7b5348a4310d37ea39be8
        failing since 15 days (last pass: v5.10.112-cip6, first fail: v4.4-=
st5-297-gc0d53c2a5c03d)

    2022-06-13T22:07:21.436113  /lava-6606799/1/../bin/lava-test-case
    2022-06-13T22:07:21.460129  [   34.200928] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-dp-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.rk_iommu-vpu_mmu-probed: https://kernelci.org/test/case=
/id/62a7b5348a4310d37ea39be9
        failing since 15 days (last pass: v5.10.112-cip6, first fail: v4.4-=
st5-297-gc0d53c2a5c03d)

    2022-06-13T22:07:20.376410  /lava-6606799/1/../bin/lava-test-case
    2022-06-13T22:07:20.400401  [   33.141137] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk_iommu-vpu_mmu-probed RESULT=3Dfail>   =


  * baseline.bootrr.rk_iommu-vopl_mmu-probed: https://kernelci.org/test/cas=
e/id/62a7b5348a4310d37ea39bea
        failing since 15 days (last pass: v5.10.112-cip6, first fail: v4.4-=
st5-297-gc0d53c2a5c03d)

    2022-06-13T22:07:19.324610  /lava-6606799/1/../bin/lava-test-case
    2022-06-13T22:07:19.348561  [   32.089234] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk_iommu-vopl_mmu-probed RESULT=3Dfail>   =


  * baseline.bootrr.rk_iommu-vopb_mmu-probed: https://kernelci.org/test/cas=
e/id/62a7b5348a4310d37ea39beb
        failing since 15 days (last pass: v5.10.112-cip6, first fail: v4.4-=
st5-297-gc0d53c2a5c03d)

    2022-06-13T22:07:18.280412  /lava-6606799/1/../bin/lava-test-case
    2022-06-13T22:07:18.298232  [   31.039656] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk_iommu-vopb_mmu-probed RESULT=3Dfail>   =


  * baseline.bootrr.rk3288-crypto-probed: https://kernelci.org/test/case/id=
/62a7b5348a4310d37ea39bf3
        failing since 15 days (last pass: v5.10.112-cip6, first fail: v4.4-=
st5-297-gc0d53c2a5c03d)

    2022-06-13T22:07:17.014418  /lava-6606799/1/../bin/lava-test-case
    2022-06-13T22:07:17.032248  [   29.774551] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk3288-crypto-probed RESULT=3Dfail>   =


  * baseline.bootrr.rk3288-crypto-driver-present: https://kernelci.org/test=
/case/id/62a7b5348a4310d37ea39bf4
        failing since 15 days (last pass: v5.10.112-cip6, first fail: v4.4-=
st5-297-gc0d53c2a5c03d)

    2022-06-13T22:07:15.968362  /lava-6606799/1/../bin/lava-test-case
    2022-06-13T22:07:15.986210  [   28.727886] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk3288-crypto-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.ramoops-probed: https://kernelci.org/test/case/id/62a7b=
5348a4310d37ea39bf5
        failing since 15 days (last pass: v5.10.112-cip6, first fail: v4.4-=
st5-297-gc0d53c2a5c03d)

    2022-06-13T22:07:14.910768  /lava-6606799/1/../bin/lava-test-case
    2022-06-13T22:07:14.933468  [   27.675835] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dramoops-probed RESULT=3Dfail>   =


  * baseline.bootrr.ramoops-driver-present: https://kernelci.org/test/case/=
id/62a7b5348a4310d37ea39bf6
        failing since 15 days (last pass: v5.10.112-cip6, first fail: v4.4-=
st5-297-gc0d53c2a5c03d)

    2022-06-13T22:07:13.851007  /lava-6606799/1/../bin/lava-test-case
    2022-06-13T22:07:13.874820  [   26.615972] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dramoops-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.dwhdmi-rockchip-probed: https://kernelci.org/test/case/=
id/62a7b5348a4310d37ea39bff
        failing since 15 days (last pass: v5.10.112-cip6, first fail: v4.4-=
st5-297-gc0d53c2a5c03d)

    2022-06-13T22:07:11.578252  /lava-6606799/1/../bin/lava-test-case
    2022-06-13T22:07:11.595461  [   24.337470] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dfail>   =


  * baseline.bootrr.dw_wdt-probed: https://kernelci.org/test/case/id/62a7b5=
348a4310d37ea39c04
        failing since 15 days (last pass: v5.10.112-cip6, first fail: v4.4-=
st5-297-gc0d53c2a5c03d)

    2022-06-13T22:07:10.417614  /lava-6606799/1/../bin/lava-test-case
    2022-06-13T22:07:10.440748  [   23.183294] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddw_wdt-probed RESULT=3Dfail>   =


  * baseline.bootrr.dw_wdt-driver-present: https://kernelci.org/test/case/i=
d/62a7b5348a4310d37ea39c05
        failing since 15 days (last pass: v5.10.112-cip6, first fail: v4.4-=
st5-297-gc0d53c2a5c03d)

    2022-06-13T22:07:09.359501  /lava-6606799/1/../bin/lava-test-case
    2022-06-13T22:07:09.382226  [   22.123375] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddw_wdt-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cros-ec-keyb-probed: https://kernelci.org/test/case/id/=
62a7b5348a4310d37ea39c0a
        failing since 15 days (last pass: v5.10.112-cip6, first fail: v4.4-=
st5-297-gc0d53c2a5c03d)

    2022-06-13T22:07:08.188826  /lava-6606799/1/../bin/lava-test-case
    2022-06-13T22:07:08.207539  [   20.949669] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcros-ec-keyb-probed RESULT=3Dfail>   =


  * baseline.bootrr.cros-ec-i2c-tunnel-probed: https://kernelci.org/test/ca=
se/id/62a7b5348a4310d37ea39c0c
        failing since 15 days (last pass: v5.10.112-cip6, first fail: v4.4-=
st5-297-gc0d53c2a5c03d)

    2022-06-13T22:07:07.092891  /lava-6606799/1/../bin/lava-test-case
    2022-06-13T22:07:07.116651  [   19.857454] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcros-ec-i2c-tunnel-probed RESULT=3Dfail>   =


  * baseline.bootrr.cros-ec-i2c-tunnel-driver-present: https://kernelci.org=
/test/case/id/62a7b5348a4310d37ea39c0d
        failing since 15 days (last pass: v5.10.112-cip6, first fail: v4.4-=
st5-297-gc0d53c2a5c03d)

    2022-06-13T22:07:06.032122  /lava-6606799/1/../bin/lava-test-case
    2022-06-13T22:07:06.056699  [   18.797079] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcros-ec-i2c-tunnel-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cros-ec-dev-probed: https://kernelci.org/test/case/id/6=
2a7b5348a4310d37ea39c0e
        failing since 15 days (last pass: v5.10.112-cip6, first fail: v4.4-=
st5-297-gc0d53c2a5c03d)

    2022-06-13T22:07:04.055600  [   16.803302] smsc95xx v1.0.4
    2022-06-13T22:07:04.121769  [   16.854872] smsc95xx 3-1.1:1.0 eth0: reg=
ister 'smsc95xx' at usb-ff580000.usb-1.1, smsc95xx USB 2.0 Ethernet, 94:eb:=
2c:00:03:cf
    2022-06-13T22:07:04.133599  [   16.870873] dwmmc_rockchip ff0d0000.dwmm=
c: IDMAC supports 32-bit address mode.
    2022-06-13T22:07:04.144944  [   16.878543] dwmmc_rockchip ff0d0000.dwmm=
c: Using internal DMA controller.
    2022-06-13T22:07:04.145182  [   16.885407] dwmmc_rockchip ff0d0000.dwmm=
c: Version ID is 270a
    2022-06-13T22:07:04.152685  [   16.891227] dwmmc_rockchip ff0d0000.dwmm=
c: DW MMC controller at irq 30,32 bit host data width,256 deep fifo
    2022-06-13T22:07:04.494097  [   17.238210] random: nonblocking pool is =
initialized
    2022-06-13T22:07:04.987362  /lava-6606799/1/../bin/lava-test-case
    2022-06-13T22:07:05.007115  [   17.748848] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcros-ec-dev-probed RESULT=3Dfail>   =


  * baseline.bootrr.cros-ec-dev-driver-present: https://kernelci.org/test/c=
ase/id/62a7b5348a4310d37ea39c0f
        failing since 15 days (last pass: v5.10.112-cip6, first fail: v4.4-=
st5-297-gc0d53c2a5c03d)

    2022-06-13T22:07:03.161821  [   15.900129] dwc2 ff580000.usb: DWC OTG C=
ontroller
    2022-06-13T22:07:03.167196  [   15.904862] dwc2 ff580000.usb: new USB b=
us registered, assigned bus number 3
    2022-06-13T22:07:03.167401  [   15.911950] dwc2 ff580000.usb: irq 43, i=
o mem 0x00000000
    2022-06-13T22:07:03.177115  [   15.918217] hub 3-0:1.0: USB hub found
    2022-06-13T22:07:03.177318  [   15.922008] hub 3-0:1.0: 1 port detected
    2022-06-13T22:07:03.190531  [   15.928123] dwmmc_rockchip ff0d0000.dwmm=
c: IDMAC supports 32-bit address mode.
    2022-06-13T22:07:03.200904  [   15.935471] dwmmc_rockchip ff0d0000.dwmm=
c: Using internal DMA controller.
    2022-06-13T22:07:03.201125  [   15.942276] dwmmc_rockchip ff0d0000.dwmm=
c: Version ID is 270a
    2022-06-13T22:07:03.208679  [   15.948047] dwmmc_rockchip ff0d0000.dwmm=
c: DW MMC controller at irq 30,32 bit host data width,256 deep fifo
    2022-06-13T22:07:03.473339  [   16.215112] usb 3-1: new high-speed USB =
device number 2 using dwc2 =

    ... (9 line(s) more)  =

 =20

