Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AC8C77B78
	for <webhook@archiver.kernel.org>; Wed, 26 Apr 2023 13:54:09 +0000 (UTC)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
 by mx.groups.io with SMTP id smtpd.web11.8581.1682517248247316847
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 26 Apr 2023 06:54:08 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=AchJSVXR;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.175, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-63b7096e2e4so5942473b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 26 Apr 2023 06:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682517247; x=1685109247;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/udKI+3rMHWncFHMLMiJbMnJRixYD2WPdHTz8YDUttY=;
        b=AchJSVXRwhyz8rguYq8Y7ZDByL4AM8QzKq22ZW5HtIUfaqnRnNCvzB0svtCPjEyjy6
         MndGpI6XIXyEzzwCvoneCogZbR/edGwMvIE9xaa4XrUnOAls6XDz8okUI5fRmCy40EgC
         rLjICraLaTrwJohf1FG99+a9ZV/v4rN/K4RuMflNhis/i8YkHjY8GhupU75lnG2lYplA
         vPhMztIRXDEOrmzgzAjaSW989KK9lHTByqerAsV69ivQQ4hC3L5wzwpUQjM6SNJ8sUQe
         YcIk2H1Ct/kCFYtUEXjhqUOlSpZHtqsTK1S8tBELsBl2ixPyDx2LSu+YB/ltCcXKel2B
         inIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682517247; x=1685109247;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/udKI+3rMHWncFHMLMiJbMnJRixYD2WPdHTz8YDUttY=;
        b=iLJKtSFdGCoKXXyy26Ej32KPmeylmkTh05CaDhk+x/94zGSCGp3ZQRTmmEqQE1t9VQ
         7zkM3BPq2eR209k5AMqyMZq1g02ybT1iKbNq8UN1DhXv/sT6qE5awCPlEHpAdh6MrUbH
         Hoj529Uptr33NQN1wFtWGD3XXbQDLS2ct3boZUmC/ecDtPhGVGsjOPV+Dh5AclSMGW3l
         wi/oeBAjvG6ulebFiUdGQf0gYEAHN4er/TmHsnO1HowMjVRY9Oy5GxNJV5BGLt36gZB6
         IRAmcSnt753HA+rZCHcVRwwndqju5XLS3dBptsQcteHi//c4yAf6UwDzl56UZWFOmQ6k
         o69A==
X-Gm-Message-State: AAQBX9drSvsDrLiR47XLg8+Nm6+5yC47/QvySA80xcPKqnLBFVi0maDB
	CfKxVrVAuGT9JCvL39VLat9jQWx4nx+tL+FQ0yJTfg==
X-Google-Smtp-Source: AKy350YzuF+wmsYk0yRdilgZ0jXfOX7NfZFPO+WY6MnTHoRquy5+gDJiU03Xj7do9bS0Qm/6stRKMA==
X-Received: by 2002:a05:6a20:c901:b0:cc:a5d4:c334 with SMTP id gx1-20020a056a20c90100b000cca5d4c334mr23405990pzb.10.1682517246093;
        Wed, 26 Apr 2023 06:54:06 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a15-20020a056a000c8f00b0063b8ddf77f7sm11340168pfv.211.2023.04.26.06.54.05
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 06:54:05 -0700 (PDT)
Message-ID: <64492cfd.050a0220.d6620.6a40@mx.google.com>
Date: Wed, 26 Apr 2023 06:54:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.19.280-cip96-89-g355dfa824cb4
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 104 runs,
 33 regressions (v4.19.280-cip96-89-g355dfa824cb4)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Apr 2023 13:54:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11356

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 104 runs, 33 regressio=
ns (v4.19.280-cip96-89-g355dfa824cb4)

Regressions Summary
-------------------

platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus  | x86_64 | lab-collabora   | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C523NA-A20057-coral   | x86_64 | lab-collabora   | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

beaglebone-black           | arm    | lab-broonie     | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black           | arm    | lab-broonie     | gcc-10   | omap2plu=
s_defconfig          | 1          =

imx6q-sabrelite            | arm    | lab-collabora   | gcc-10   | multi_v7=
_defconfig           | 1          =

imx6qp-wandboard-revd1     | arm    | lab-pengutronix | gcc-10   | imx_v6_v=
7_defconfig          | 1          =

imx6qp-wandboard-revd1     | arm    | lab-pengutronix | gcc-10   | multi_v7=
_defconfig           | 1          =

imx6sx-sdb                 | arm    | lab-nxp         | gcc-10   | multi_v7=
_defconfig           | 1          =

imx6ul-14x14-evk           | arm    | lab-nxp         | gcc-10   | multi_v7=
_defconfig           | 1          =

imx7d-sdb                  | arm    | lab-nxp         | gcc-10   | multi_v7=
_defconfig           | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

rk3288-veyron-jaq          | arm    | lab-collabora   | gcc-10   | multi_v7=
_defconfig           | 3          =

rk3399-gru-kevin           | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

sun50i-a64-pine64-plus     | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64         | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =

zynqmp-zcu102              | arm64  | lab-cip         | gcc-10   | defconfi=
g                    | 1          =

zynqmp-zcu102              | arm64  | lab-cip         | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.280-cip96-89-g355dfa824cb4/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.280-cip96-89-g355dfa824cb4
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      355dfa824cb4c11c1525b77bd5e76e4c0733b7c9 =



Test Regressions
---------------- =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus  | x86_64 | lab-collabora   | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64491f8d144aaee1f22e861a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/baseline-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/baseline-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64491f8d144aaee1f22e861f
        failing since 97 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-04-26T12:56:28.963537  + set +x

    2023-04-26T12:56:28.970343  <8>[   10.199133] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10130706_1.4.2.3.1>

    2023-04-26T12:56:29.074430  / # #

    2023-04-26T12:56:29.174943  export SHELL=3D/bin/sh

    2023-04-26T12:56:29.175206  #

    2023-04-26T12:56:29.275677  / # export SHELL=3D/bin/sh. /lava-10130706/=
environment

    2023-04-26T12:56:29.275914  =


    2023-04-26T12:56:29.376384  / # . /lava-10130706/environment/lava-10130=
706/bin/lava-test-runner /lava-10130706/1

    2023-04-26T12:56:29.376653  =


    2023-04-26T12:56:29.381586  / # /lava-10130706/bin/lava-test-runner /la=
va-10130706/1
 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral   | x86_64 | lab-collabora   | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64491f8dfc02dcab352e85e6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/baseline-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/baseline-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64491f8dfc02dcab352e85eb
        failing since 97 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-04-26T12:56:32.478254  + set +x

    2023-04-26T12:56:32.485050  <8>[   12.400942] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10130662_1.4.2.3.1>

    2023-04-26T12:56:32.589353  / # #

    2023-04-26T12:56:32.690162  export SHELL=3D/bin/sh

    2023-04-26T12:56:32.690395  #

    2023-04-26T12:56:32.790946  / # export SHELL=3D/bin/sh. /lava-10130662/=
environment

    2023-04-26T12:56:32.791178  =


    2023-04-26T12:56:32.891749  / # . /lava-10130662/environment/lava-10130=
662/bin/lava-test-runner /lava-10130662/1

    2023-04-26T12:56:32.892098  =


    2023-04-26T12:56:32.897101  / # /lava-10130662/bin/lava-test-runner /la=
va-10130662/1
 =

    ... (13 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
beaglebone-black           | arm    | lab-broonie     | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6449265408632cfb8a2e85ec

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm/multi_v7_defconfig/gcc-10=
/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm/multi_v7_defconfig/gcc-10=
/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6449265408632cfb8a2e8617
        failing since 97 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-04-26T13:25:00.575682  <8>[   21.108003] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 390172_1.5.2.4.1>
    2023-04-26T13:25:00.682931  / # #
    2023-04-26T13:25:00.785022  export SHELL=3D/bin/sh
    2023-04-26T13:25:00.786100  #
    2023-04-26T13:25:00.888036  / # export SHELL=3D/bin/sh. /lava-390172/en=
vironment
    2023-04-26T13:25:00.888626  =

    2023-04-26T13:25:00.990280  / # . /lava-390172/environment/lava-390172/=
bin/lava-test-runner /lava-390172/1
    2023-04-26T13:25:00.991236  =

    2023-04-26T13:25:00.994102  / # /lava-390172/bin/lava-test-runner /lava=
-390172/1
    2023-04-26T13:25:01.063671  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
beaglebone-black           | arm    | lab-broonie     | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/644922555b336cf6f42e85ef

  Results:     41 PASS, 10 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm/omap2plus_defconfig/gcc-1=
0/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm/omap2plus_defconfig/gcc-1=
0/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644922555b336cf6f42e8621
        new failure (last pass: v4.19.280-cip96-59-g4b02e7efb967d)

    2023-04-26T13:08:15.585216  + set +x
    2023-04-26T13:08:15.589219  <8>[   16.815310] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 390088_1.5.2.4.1>
    2023-04-26T13:08:15.703398  / # #
    2023-04-26T13:08:15.806113  export SHELL=3D/bin/sh
    2023-04-26T13:08:15.806830  #
    2023-04-26T13:08:15.908971  / # export SHELL=3D/bin/sh. /lava-390088/en=
vironment
    2023-04-26T13:08:15.909681  =

    2023-04-26T13:08:16.011699  / # . /lava-390088/environment/lava-390088/=
bin/lava-test-runner /lava-390088/1
    2023-04-26T13:08:16.013033  =

    2023-04-26T13:08:16.017703  / # /lava-390088/bin/lava-test-runner /lava=
-390088/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx6q-sabrelite            | arm    | lab-collabora   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64492a0fb41cc6f2dc2e8601

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm/multi_v7_defconfig/gcc-10=
/lab-collabora/baseline-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm/multi_v7_defconfig/gcc-10=
/lab-collabora/baseline-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64492a0fb41cc6f2dc2e8606
        failing since 97 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-04-26T13:41:20.095694  / # #

    2023-04-26T13:41:20.198064  export SHELL=3D/bin/sh

    2023-04-26T13:41:20.198403  #

    2023-04-26T13:41:20.299783  / # export SHELL=3D/bin/sh. /lava-10130920/=
environment

    2023-04-26T13:41:20.300589  =


    2023-04-26T13:41:20.402200  / # . /lava-10130920/environment/lava-10130=
920/bin/lava-test-runner /lava-10130920/1

    2023-04-26T13:41:20.403499  =


    2023-04-26T13:41:20.408179  / # /lava-10130920/bin/lava-test-runner /la=
va-10130920/1

    2023-04-26T13:41:20.518227  + export 'TESTRUN_ID=3D1_bootrr'

    2023-04-26T13:41:20.518824  + cd /lava-10130920/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx6qp-wandboard-revd1     | arm    | lab-pengutronix | gcc-10   | imx_v6_v=
7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64491f61c668297bc32e865f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm/imx_v6_v7_defconfig/gcc-1=
0/lab-pengutronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm/imx_v6_v7_defconfig/gcc-1=
0/lab-pengutronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64491f61c668297bc32e8664
        failing since 97 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-04-26T12:55:40.352904  + set +x[    7.314198] <LAVA_SIGNAL_ENDRUN =
0_dmesg 938335_1.5.2.3.1>
    2023-04-26T12:55:40.353072  =

    2023-04-26T12:55:40.460186  / # #
    2023-04-26T12:55:40.561567  export SHELL=3D/bin/sh
    2023-04-26T12:55:40.562016  #
    2023-04-26T12:55:40.663320  / # export SHELL=3D/bin/sh. /lava-938335/en=
vironment
    2023-04-26T12:55:40.663796  =

    2023-04-26T12:55:40.765056  / # . /lava-938335/environment/lava-938335/=
bin/lava-test-runner /lava-938335/1
    2023-04-26T12:55:40.765637  =

    2023-04-26T12:55:40.768389  / # /lava-938335/bin/lava-test-runner /lava=
-938335/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx6qp-wandboard-revd1     | arm    | lab-pengutronix | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/644925b7fadf4bf8612e860c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm/multi_v7_defconfig/gcc-10=
/lab-pengutronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm/multi_v7_defconfig/gcc-10=
/lab-pengutronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644925b7fadf4bf8612e8611
        failing since 97 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-04-26T13:22:51.934482  + set +x
    2023-04-26T13:22:51.934645  [    4.881645] <LAVA_SIGNAL_ENDRUN 0_dmesg =
938348_1.5.2.3.1>
    2023-04-26T13:22:52.040733  / # #
    2023-04-26T13:22:52.142459  export SHELL=3D/bin/sh
    2023-04-26T13:22:52.143111  #
    2023-04-26T13:22:52.244573  / # export SHELL=3D/bin/sh. /lava-938348/en=
vironment
    2023-04-26T13:22:52.245170  =

    2023-04-26T13:22:52.346659  / # . /lava-938348/environment/lava-938348/=
bin/lava-test-runner /lava-938348/1
    2023-04-26T13:22:52.347508  =

    2023-04-26T13:22:52.349898  / # /lava-938348/bin/lava-test-runner /lava=
-938348/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx6sx-sdb                 | arm    | lab-nxp         | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6449263dd58c5828d92e8631

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm/multi_v7_defconfig/gcc-10=
/lab-nxp/baseline-imx6sx-sdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm/multi_v7_defconfig/gcc-10=
/lab-nxp/baseline-imx6sx-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6449263dd58c5828d92e8634
        failing since 97 days (last pass: v4.19.264-cip84-50-g1e56b70eaf66,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-04-26T13:24:26.781791  / # #
    2023-04-26T13:24:27.942100  export SHELL=3D/bin/sh
    2023-04-26T13:24:27.947797  #
    2023-04-26T13:24:29.495068  / # export SHELL=3D/bin/sh. /lava-1208963/e=
nvironment
    2023-04-26T13:24:29.500750  =

    2023-04-26T13:24:32.320366  / # . /lava-1208963/environment/lava-120896=
3/bin/lava-test-runner /lava-1208963/1
    2023-04-26T13:24:32.326036  =

    2023-04-26T13:24:32.338356  / # /lava-1208963/bin/lava-test-runner /lav=
a-1208963/1
    2023-04-26T13:24:32.421155  + export 'TESTRUN_ID=3D1_bootrr'
    2023-04-26T13:24:32.421338  + cd /lava-1208963/1/tests/1_bootrr =

    ... (16 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx6ul-14x14-evk           | arm    | lab-nxp         | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6449264180788359ea2e85e6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm/multi_v7_defconfig/gcc-10=
/lab-nxp/baseline-imx6ul-14x14-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm/multi_v7_defconfig/gcc-10=
/lab-nxp/baseline-imx6ul-14x14-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6449264180788359ea2e85e9
        failing since 5 days (last pass: v4.19.259-cip82-57-ge54228ee5a88d,=
 first fail: v4.19.280-cip96-59-g4b02e7efb967d)

    2023-04-26T13:24:32.590774  + set +x<8>[   22.689873] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 1208964_1.5.2.4.1>
    2023-04-26T13:24:32.590904  =

    2023-04-26T13:24:32.697953  =

    2023-04-26T13:24:33.855925  / # #export SHELL=3D/bin/sh
    2023-04-26T13:24:33.861350  =

    2023-04-26T13:24:33.861537  / # export SHELL=3D/bin/sh
    2023-04-26T13:24:35.406747  . /lava-1208964/environment
    2023-04-26T13:24:35.412125  / # . /lava-1208964/environment
    2023-04-26T13:24:38.230623  /lava-1208964/bin/lava-test-runner /lava-12=
08964/1
    2023-04-26T13:24:38.236840  / # /lava-1208964/bin/lava-test-runner /lav=
a-1208964/1 =

    ... (15 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx7d-sdb                  | arm    | lab-nxp         | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6449264580788359ea2e85f4

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm/multi_v7_defconfig/gcc-10=
/lab-nxp/baseline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm/multi_v7_defconfig/gcc-10=
/lab-nxp/baseline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6449264580788359ea2e85f7
        failing since 92 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.270-cip89-39-g43ce130174aa)

    2023-04-26T13:24:32.112296  <8>[   12.951229] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1208965_1.5.2.4.1>
    2023-04-26T13:24:32.215420  / # #
    2023-04-26T13:24:33.373305  export SHELL=3D/bin/sh
    2023-04-26T13:24:33.378694  #
    2023-04-26T13:24:33.378837  / # export SHELL=3D/bin/sh
    2023-04-26T13:24:34.924229  / #. /lava-1208965/environment
    2023-04-26T13:24:37.747520  /lava-1208965/bin/lava-test-runner /lava-12=
08965/1
    2023-04-26T13:24:37.753102   . /lava-1208965/environment
    2023-04-26T13:24:37.756668  / # /lava-1208965/bin/lava-test-runner /lav=
a-1208965/1
    2023-04-26T13:24:37.804704  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (16 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64492a46f404a918092e8627

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64492a46f404a918092e8=
628
        failing since 342 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64492b9be8ffc89ec22e8743

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64492b9be8ffc89ec22e8=
744
        failing since 342 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64492503bf6d37da7f2e85ef

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm64/defconfig/gcc-10/lab-co=
llabora/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm64/defconfig/gcc-10/lab-co=
llabora/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64492503bf6d37da7f2e8=
5f0
        failing since 342 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6449261333bd6ffb972e85e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6449261333bd6ffb972e8=
5e7
        failing since 342 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/644928f21c7f0c963e2e85f3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644928f21c7f0c963e2e8=
5f4
        failing since 342 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/644924faacb27b0da52e861a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm64/defconfig/gcc-10/lab-co=
llabora/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm64/defconfig/gcc-10/lab-co=
llabora/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644924faacb27b0da52e8=
61b
        failing since 342 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/644929ba29a02ab1092e85e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644929ba29a02ab1092e8=
5e7
        failing since 342 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64492b0fb40a93a1e92e8655

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64492b0fb40a93a1e92e8=
656
        failing since 342 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64492502bf6d37da7f2e85ec

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm64/defconfig/gcc-10/lab-co=
llabora/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm64/defconfig/gcc-10/lab-co=
llabora/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64492502bf6d37da7f2e8=
5ed
        failing since 342 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/644926129a92e02af52e85e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644926129a92e02af52e8=
5e7
        failing since 342 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64492866479b517ed52e85f3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64492866479b517ed52e8=
5f4
        failing since 342 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64492c775bd9b8047e2e85f9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64492c775bd9b8047e2e8=
5fa
        failing since 342 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64492500bf6d37da7f2e85e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm64/defconfig/gcc-10/lab-co=
llabora/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm64/defconfig/gcc-10/lab-co=
llabora/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64492500bf6d37da7f2e8=
5e7
        failing since 342 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/644926149a92e02af52e85ef

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644926149a92e02af52e8=
5f0
        failing since 342 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
rk3288-veyron-jaq          | arm    | lab-collabora   | gcc-10   | multi_v7=
_defconfig           | 3          =


  Details:     https://kernelci.org/test/plan/id/644925df6dbe29dc802e85ee

  Results:     61 PASS, 8 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm/multi_v7_defconfig/gcc-10=
/lab-collabora/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm/multi_v7_defconfig/gcc-10=
/lab-collabora/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/644925df6dbe29dc802e861e
        failing since 95 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-04-26T13:23:23.397378  BusyBox v1.31.1 (2023-04-14 10:59:35 UTC)<8=
>[   13.190309] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-04-26T13:23:23.399454   multi-call binary.

    2023-04-26T13:23:23.399873  =


    2023-04-26T13:23:23.404006  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-04-26T13:23:23.404414  =


    2023-04-26T13:23:23.409263  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-04-26T13:23:23.419537  FIRST,<8>[   13.208782] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/644925df6dbe29dc802e861f
        failing since 95 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-04-26T13:23:23.378729  <8>[   13.172615] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644925df6dbe29dc802e8632
        failing since 95 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-04-26T13:23:19.551288  <8>[    9.345231] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-04-26T13:23:19.560411  + <8>[    9.357232] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10130928_1.5.2.3.1>

    2023-04-26T13:23:19.560848  set +x

    2023-04-26T13:23:19.666709  =


    2023-04-26T13:23:19.768256  / # #export SHELL=3D/bin/sh

    2023-04-26T13:23:19.768939  =


    2023-04-26T13:23:19.870191  / # export SHELL=3D/bin/sh. /lava-10130928/=
environment

    2023-04-26T13:23:19.870923  =


    2023-04-26T13:23:19.972443  / # . /lava-10130928/environment/lava-10130=
928/bin/lava-test-runner /lava-10130928/1

    2023-04-26T13:23:19.973505  =

 =

    ... (18 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
rk3399-gru-kevin           | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6449255574889ee92c2e85f2

  Results:     77 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/6449255574889ee92c2e85f8
        failing since 43 days (last pass: v4.19.273-cip92-277-g507c8d80b9e2=
0, first fail: v4.19.276-cip93-5-g2eb2a953ab59)

    2023-04-26T13:21:08.153915  /lava-10130886/1/../bin/lava-test-case

    2023-04-26T13:21:08.162769  <8>[   37.501437] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/6449255574889ee92c2e85f9
        failing since 43 days (last pass: v4.19.273-cip92-277-g507c8d80b9e2=
0, first fail: v4.19.276-cip93-5-g2eb2a953ab59)

    2023-04-26T13:21:07.129010  /lava-10130886/1/../bin/lava-test-case

    2023-04-26T13:21:07.137900  <8>[   36.476549] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus     | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64492422ff49cb1fc72e8601

  Results:     23 PASS, 16 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64492422ff49cb1fc72e8623
        failing since 97 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-04-26T13:15:39.928678  <8>[   16.001489] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 390111_1.5.2.4.1>
    2023-04-26T13:15:40.034441  / # #
    2023-04-26T13:15:40.136668  export SHELL=3D/bin/sh
    2023-04-26T13:15:40.137359  #
    2023-04-26T13:15:40.239549  / # export SHELL=3D/bin/sh. /lava-390111/en=
vironment
    2023-04-26T13:15:40.240090  =

    2023-04-26T13:15:40.341988  / # . /lava-390111/environment/lava-390111/=
bin/lava-test-runner /lava-390111/1
    2023-04-26T13:15:40.343106  =

    2023-04-26T13:15:40.347826  / # /lava-390111/bin/lava-test-runner /lava=
-390111/1
    2023-04-26T13:15:40.379215  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64         | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/644923fdc1cab85eeb2e85e7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm64/defconfig/gcc-10/lab-co=
llabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm64/defconfig/gcc-10/lab-co=
llabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644923fdc1cab85eeb2e85ec
        failing since 97 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-04-26T13:15:36.901240  / # #

    2023-04-26T13:15:37.003390  export SHELL=3D/bin/sh

    2023-04-26T13:15:37.004111  #

    2023-04-26T13:15:37.105456  / # export SHELL=3D/bin/sh. /lava-10130866/=
environment

    2023-04-26T13:15:37.106206  =


    2023-04-26T13:15:37.207617  / # . /lava-10130866/environment/lava-10130=
866/bin/lava-test-runner /lava-10130866/1

    2023-04-26T13:15:37.208766  =


    2023-04-26T13:15:37.225331  / # /lava-10130866/bin/lava-test-runner /la=
va-10130866/1

    2023-04-26T13:15:37.283246  + export 'TESTRUN_ID=3D1_bootrr'

    2023-04-26T13:15:37.283768  + cd /lava-1013086<8>[   15.632729] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 10130866_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
zynqmp-zcu102              | arm64  | lab-cip         | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/644923e9f3ba927ea42e85fa

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm64/defconfig/gcc-10/lab-ci=
p/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm64/defconfig/gcc-10/lab-ci=
p/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644923e9f3ba927ea42e85fd
        failing since 97 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-04-26T13:14:58.098650  + set +x
    2023-04-26T13:14:58.099747  <8>[    3.734622] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 917334_1.5.2.4.1>
    2023-04-26T13:14:58.205645  / # #
    2023-04-26T13:14:58.306966  export SHELL=3D/bin/sh
    2023-04-26T13:14:58.307346  #
    2023-04-26T13:14:58.408376  / # export SHELL=3D/bin/sh. /lava-917334/en=
vironment
    2023-04-26T13:14:58.408647  =

    2023-04-26T13:14:58.509679  / # . /lava-917334/environment/lava-917334/=
bin/lava-test-runner /lava-917334/1
    2023-04-26T13:14:58.510138  =

    2023-04-26T13:14:58.512660  / # /lava-917334/bin/lava-test-runner /lava=
-917334/1 =

    ... (13 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
zynqmp-zcu102              | arm64  | lab-cip         | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/644925a176b46963282e85ec

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644925a176b46963282e85ef
        failing since 97 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-04-26T13:22:23.136865  <8>[    3.753294] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 917357_1.5.2.4.1>
    2023-04-26T13:22:23.242575  / # #
    2023-04-26T13:22:23.344478  export SHELL=3D/bin/sh
    2023-04-26T13:22:23.344968  #
    2023-04-26T13:22:23.446376  / # export SHELL=3D/bin/sh. /lava-917357/en=
vironment
    2023-04-26T13:22:23.446946  =

    2023-04-26T13:22:23.548356  / # . /lava-917357/environment/lava-917357/=
bin/lava-test-runner /lava-917357/1
    2023-04-26T13:22:23.549134  =

    2023-04-26T13:22:23.551936  / # /lava-917357/bin/lava-test-runner /lava=
-917357/1
    2023-04-26T13:22:23.588952  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =20

