Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05958CA553B
	for <webhook@archiver.kernel.org>; Wed, 13 Sep 2023 16:24:21 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
 by mx.groups.io with SMTP id smtpd.web10.1230.1694622260179158898
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 13 Sep 2023 09:24:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=pE2R3Dzf;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.181, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-68fb46f38f9so3599526b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 13 Sep 2023 09:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694622259; x=1695227059; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+d5sw+IfQlBwrIsj568XsCXAxMxc7bRBIY3TEw4y8Pc=;
        b=pE2R3DzfrRrxuizgyaGYWMqE80ge1xQe9n351SVroNDPygCWIs+OH82YQ3KXZ4RpAV
         k8G+L/uUrkMBBcyU23fL2+KiMrO0NtU7npWOCMgs1WBpxBDBxGz0ctZ9hUhl3LorgKI7
         N0Xk0Rwxv4XygEULYVhlkIHMDLwG0O2aofajO7S0VBx7iUfgUyGy5jLt823Z6JM6fJLr
         /3VhxuhpgWo7ZPKhBGNzBZAWDjfcaj094ftBfVrXUGL61Bl/XxR44mxX0y/nJ/A5dq1Y
         K2/gFUiBxar26i43crspCdL/lRTyMYDLKf2iFELXZazPHSzSR/Y3cHC1Oihh/pgyTwTE
         IFdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694622259; x=1695227059;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+d5sw+IfQlBwrIsj568XsCXAxMxc7bRBIY3TEw4y8Pc=;
        b=JA+m0Edi8c8X8J/2pDSZDM7W3aXbV60HILmzUQI4875WUx5yCI85Q0Pl8R6J8lRqun
         lS+VyqybONgsGVXzBzvdFr12NxEtMMuGlXwGmFLzC1OQlV0VGJ3+ENlR1ltjWVCoew2J
         G0Ad9VT4XIT0Qybo/X5bZEEfLogTa+JXVmL1XTVI2EkkVpw7N/2sGLkMhvnALexcuDit
         P6Z6vy5Utfrqi3/E0SazxXdRnxSeXqA6MQOBvAMZFTunTdjIy27OuvXDNRXWQukvBX/v
         s0w7ajL5mVSxuUbOtx5YvPAwoRuKi8PSEV0jsAyghueJXoQ0oFYOAH20y7hyalqYIDMG
         ekAQ==
X-Gm-Message-State: AOJu0Yyh5F2JNa+gDvBrY+6K2yM6+GJjGNeZf4lGHgVJavWPVsO0nLlk
	82ABBnXY4sFCl5sNk3O5UFSQVp9tE6pkhbDXzHQ=
X-Google-Smtp-Source: AGHT+IED6fxF0DSx/5kvIpQXZAPX8QIjAG+9GEoqv2N9FTofuCxF1lyZqzsb3KepHK39nOWCYOxm6A==
X-Received: by 2002:a05:6a21:3387:b0:14d:7511:1c1 with SMTP id yy7-20020a056a21338700b0014d751101c1mr3208146pzb.49.1694622258471;
        Wed, 13 Sep 2023 09:24:18 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l14-20020a62be0e000000b00686dd062207sm9228951pff.150.2023.09.13.09.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 09:24:17 -0700 (PDT)
Message-ID: <6501e231.620a0220.b3b4f.a6ea@mx.google.com>
Date: Wed, 13 Sep 2023 09:24:17 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.191-cip38-17-g8dad6b499cfe5
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip baseline: 115 runs,
 25 regressions (v5.10.191-cip38-17-g8dad6b499cfe5)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Sep 2023 16:24:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13107

cip/linux-5.10.y-cip baseline: 115 runs, 25 regressions (v5.10.191-cip38-17=
-g8dad6b499cfe5)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig           | 1          =

bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | bcm283=
5_defconfig            | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

imx6ul-14x14-evk             | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =

juno-uboot                   | arm64  | lab-broonie     | gcc-10   | cip://=
5.10.y-...64_defconfig | 1          =

juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig+kselftest          | 1          =

mt8173-elm-hana              | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig+kselftest          | 1          =

r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 4          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.191-cip38-17-g8dad6b499cfe5/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.191-cip38-17-g8dad6b499cfe5
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      8dad6b499cfe588bb00bdbed4e46649fe88260b1 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6501d5ae28bc8ff8f38a0a4b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501d5ae28bc8ff8f38a0a54
        failing since 242 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-09-13T15:30:41.954337  + set +x

    2023-09-13T15:30:41.960726  <8>[   12.273095] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11517049_1.4.2.3.1>

    2023-09-13T15:30:42.065271  / # #

    2023-09-13T15:30:42.165948  export SHELL=3D/bin/sh

    2023-09-13T15:30:42.166196  #

    2023-09-13T15:30:42.266747  / # export SHELL=3D/bin/sh. /lava-11517049/=
environment

    2023-09-13T15:30:42.267005  =


    2023-09-13T15:30:42.367484  / # . /lava-11517049/environment/lava-11517=
049/bin/lava-test-runner /lava-11517049/1

    2023-09-13T15:30:42.367814  =


    2023-09-13T15:30:42.373616  / # /lava-11517049/bin/lava-test-runner /la=
va-11517049/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6501d5bf28bc8ff8f38a0a87

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501d5bf28bc8ff8f38a0a90
        failing since 242 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-09-13T15:30:54.326344  + set<8>[   11.556512] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11517046_1.4.2.3.1>

    2023-09-13T15:30:54.329976   +x

    2023-09-13T15:30:54.434749  / # #

    2023-09-13T15:30:54.537120  export SHELL=3D/bin/sh

    2023-09-13T15:30:54.537879  #

    2023-09-13T15:30:54.639295  / # export SHELL=3D/bin/sh. /lava-11517046/=
environment

    2023-09-13T15:30:54.640007  =


    2023-09-13T15:30:54.741356  / # . /lava-11517046/environment/lava-11517=
046/bin/lava-test-runner /lava-11517046/1

    2023-09-13T15:30:54.743059  =


    2023-09-13T15:30:54.745008  / # /lava-11517046/bin/lava-test-runner /la=
va-11517046/1
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6501d73c6d24b5bfe98a0a42

  Results:     47 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline=
-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline=
-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501d73c6d24b5bfe98a0a79
        failing since 242 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-09-13T15:36:58.385994  + set +x
    2023-09-13T15:36:58.386509  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 105280_1.5.2=
.4.1>
    2023-09-13T15:36:58.500541  / # #
    2023-09-13T15:36:58.603816  export SHELL=3D/bin/sh
    2023-09-13T15:36:58.604680  #
    2023-09-13T15:36:58.706719  / # export SHELL=3D/bin/sh. /lava-105280/en=
vironment
    2023-09-13T15:36:58.707563  =

    2023-09-13T15:36:58.809639  / # . /lava-105280/environment/lava-105280/=
bin/lava-test-runner /lava-105280/1
    2023-09-13T15:36:58.811116  =

    2023-09-13T15:36:58.814666  / # /lava-105280/bin/lava-test-runner /lava=
-105280/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | bcm283=
5_defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/6501d4c6b5904086ef8a0a48

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/arm/bcm2835_defconfig/gcc-10/lab-collabora/baselin=
e-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/arm/bcm2835_defconfig/gcc-10/lab-collabora/baselin=
e-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501d4c6b5904086ef8a0a51
        failing since 49 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-09-13T15:31:06.270092  / # #

    2023-09-13T15:31:06.372324  export SHELL=3D/bin/sh

    2023-09-13T15:31:06.373021  #

    2023-09-13T15:31:06.474398  / # export SHELL=3D/bin/sh. /lava-11517014/=
environment

    2023-09-13T15:31:06.475156  =


    2023-09-13T15:31:06.576503  / # . /lava-11517014/environment/lava-11517=
014/bin/lava-test-runner /lava-11517014/1

    2023-09-13T15:31:06.577614  =


    2023-09-13T15:31:06.594441  / # /lava-11517014/bin/lava-test-runner /la=
va-11517014/1

    2023-09-13T15:31:06.658433  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-13T15:31:06.701408  + cd /lava-11517014/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6501d70cd871ad91298a0a42

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline=
-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline=
-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501d70cd871ad91298a0a71
        failing since 242 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-09-13T15:36:13.841470  <8>[   22.521802] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 105282_1.5.2.4.1>
    2023-09-13T15:36:13.952980  / # #
    2023-09-13T15:36:14.056279  export SHELL=3D/bin/sh
    2023-09-13T15:36:14.057261  #
    2023-09-13T15:36:14.159399  / # export SHELL=3D/bin/sh. /lava-105282/en=
vironment
    2023-09-13T15:36:14.160348  =

    2023-09-13T15:36:14.262498  / # . /lava-105282/environment/lava-105282/=
bin/lava-test-runner /lava-105282/1
    2023-09-13T15:36:14.263951  =

    2023-09-13T15:36:14.268589  / # /lava-105282/bin/lava-test-runner /lava=
-105282/1
    2023-09-13T15:36:14.365358  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6501d745f2187389dd8a0a42

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-bea=
glebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-bea=
glebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501d745f2187389dd8a0a49
        failing since 242 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-09-13T15:36:54.547592  <8>[   15.779402] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1008455_1.5.2.4.1>
    2023-09-13T15:36:54.656289  / # #
    2023-09-13T15:36:54.758652  export SHELL=3D/bin/sh
    2023-09-13T15:36:54.759364  #
    2023-09-13T15:36:54.861157  / # export SHELL=3D/bin/sh. /lava-1008455/e=
nvironment
    2023-09-13T15:36:54.861910  =

    2023-09-13T15:36:54.963751  / # . /lava-1008455/environment/lava-100845=
5/bin/lava-test-runner /lava-1008455/1
    2023-09-13T15:36:54.964943  =

    2023-09-13T15:36:54.971272  / # /lava-1008455/bin/lava-test-runner /lav=
a-1008455/1
    2023-09-13T15:36:55.064285  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6501d6b5c4d52158d08a0a56

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/arm/omap2plus_defconfig/gcc-10/lab-broonie/baselin=
e-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/arm/omap2plus_defconfig/gcc-10/lab-broonie/baselin=
e-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501d6b5c4d52158d08a0a8f
        failing since 242 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-09-13T15:35:00.806980  <8>[   20.376585] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 105268_1.5.2.4.1>
    2023-09-13T15:35:00.918848  / # #
    2023-09-13T15:35:01.021213  export SHELL=3D/bin/sh
    2023-09-13T15:35:01.021911  #
    2023-09-13T15:35:01.123470  / # export SHELL=3D/bin/sh. /lava-105268/en=
vironment
    2023-09-13T15:35:01.124156  =

    2023-09-13T15:35:01.225842  / # . /lava-105268/environment/lava-105268/=
bin/lava-test-runner /lava-105268/1
    2023-09-13T15:35:01.226877  =

    2023-09-13T15:35:01.231744  / # /lava-105268/bin/lava-test-runner /lava=
-105268/1
    2023-09-13T15:35:01.329166  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6501d6a5b8068212b48a0a42

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-be=
aglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-be=
aglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501d6a5b8068212b48a0a49
        failing since 242 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-09-13T15:34:47.984959  <8>[   13.119228] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1008449_1.5.2.4.1>
    2023-09-13T15:34:48.093354  / # #
    2023-09-13T15:34:48.194962  export SHELL=3D/bin/sh
    2023-09-13T15:34:48.195423  #
    2023-09-13T15:34:48.296592  / # export SHELL=3D/bin/sh. /lava-1008449/e=
nvironment
    2023-09-13T15:34:48.297063  =

    2023-09-13T15:34:48.398250  / # . /lava-1008449/environment/lava-100844=
9/bin/lava-test-runner /lava-1008449/1
    2023-09-13T15:34:48.398911  =

    2023-09-13T15:34:48.405013  / # /lava-1008449/bin/lava-test-runner /lav=
a-1008449/1
    2023-09-13T15:34:48.501203  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6501d6b0c4d52158d08a0a48

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501d6b0c4d52158d08a0a51
        failing since 152 days (last pass: v5.10.176-cip30, first fail: v5.=
10.177-cip31)

    2023-09-13T15:34:57.078984  + set +x

    2023-09-13T15:34:57.085604  <8>[   10.284336] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11517050_1.4.2.3.1>

    2023-09-13T15:34:57.194421  / # #

    2023-09-13T15:34:57.296786  export SHELL=3D/bin/sh

    2023-09-13T15:34:57.297503  #

    2023-09-13T15:34:57.399004  / # export SHELL=3D/bin/sh. /lava-11517050/=
environment

    2023-09-13T15:34:57.399738  =


    2023-09-13T15:34:57.501171  / # . /lava-11517050/environment/lava-11517=
050/bin/lava-test-runner /lava-11517050/1

    2023-09-13T15:34:57.502480  =


    2023-09-13T15:34:57.507440  / # /lava-11517050/bin/lava-test-runner /la=
va-11517050/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6501d580e2212e9a3c8a0a42

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501d580e2212e9a3c8a0a4b
        failing since 152 days (last pass: v5.10.176-cip30, first fail: v5.=
10.177-cip31)

    2023-09-13T15:31:22.881652  + set +x<8>[   12.816696] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11517019_1.4.2.3.1>

    2023-09-13T15:31:22.882080  =


    2023-09-13T15:31:22.989082  #

    2023-09-13T15:31:23.092253  / # #export SHELL=3D/bin/sh

    2023-09-13T15:31:23.093043  =


    2023-09-13T15:31:23.194476  / # export SHELL=3D/bin/sh. /lava-11517019/=
environment

    2023-09-13T15:31:23.195219  =


    2023-09-13T15:31:23.296581  / # . /lava-11517019/environment/lava-11517=
019/bin/lava-test-runner /lava-11517019/1

    2023-09-13T15:31:23.297810  =


    2023-09-13T15:31:23.303132  / # /lava-11517019/bin/lava-test-runner /la=
va-11517019/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6501d6f3888fe94c668a0af5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501d6f3888fe94c668a0afe
        failing since 242 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-09-13T15:38:04.767235  / # #

    2023-09-13T15:38:04.869309  export SHELL=3D/bin/sh

    2023-09-13T15:38:04.869968  #

    2023-09-13T15:38:04.971344  / # export SHELL=3D/bin/sh. /lava-11517180/=
environment

    2023-09-13T15:38:04.972003  =


    2023-09-13T15:38:05.073401  / # . /lava-11517180/environment/lava-11517=
180/bin/lava-test-runner /lava-11517180/1

    2023-09-13T15:38:05.074488  =


    2023-09-13T15:38:05.075665  / # /lava-11517180/bin/lava-test-runner /la=
va-11517180/1

    2023-09-13T15:38:05.181852  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-13T15:38:05.182355  + cd /lava-11517180/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6501d733d871ad91298a0a9f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/bas=
eline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/bas=
eline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501d733d871ad91298a0aa8
        failing since 242 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-09-13T15:37:16.832084  + set +x
    2023-09-13T15:37:16.832302  [   10.394701] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1000372_1.5.2.3.1>
    2023-09-13T15:37:16.941055  / # #
    2023-09-13T15:37:17.042782  export SHELL=3D/bin/sh
    2023-09-13T15:37:17.043285  #
    2023-09-13T15:37:17.144638  / # export SHELL=3D/bin/sh. /lava-1000372/e=
nvironment
    2023-09-13T15:37:17.145105  =

    2023-09-13T15:37:17.246419  / # . /lava-1000372/environment/lava-100037=
2/bin/lava-test-runner /lava-1000372/1
    2023-09-13T15:37:17.247110  =

    2023-09-13T15:37:17.250181  / # /lava-1000372/bin/lava-test-runner /lav=
a-1000372/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6501d6f8888fe94c668a0b16

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/base=
line-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/base=
line-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501d6f8888fe94c668a0b1f
        failing since 242 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-09-13T15:36:10.379016  + set[    7.163261] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 1000369_1.5.2.3.1>
    2023-09-13T15:36:10.379298   +x
    2023-09-13T15:36:10.485049  / # #
    2023-09-13T15:36:10.586768  export SHELL=3D/bin/sh
    2023-09-13T15:36:10.587301  #
    2023-09-13T15:36:10.688645  / # export SHELL=3D/bin/sh. /lava-1000369/e=
nvironment
    2023-09-13T15:36:10.689175  =

    2023-09-13T15:36:10.790803  / # . /lava-1000369/environment/lava-100036=
9/bin/lava-test-runner /lava-1000369/1
    2023-09-13T15:36:10.791549  =

    2023-09-13T15:36:10.793896  / # /lava-1000369/bin/lava-test-runner /lav=
a-1000369/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6ul-14x14-evk             | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6501d709888fe94c668a0b38

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx=
6ul-14x14-evk.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx=
6ul-14x14-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501d709888fe94c668a0b3f
        failing since 175 days (last pass: v5.10.145-cip17, first fail: v5.=
10.175-cip29)

    2023-09-13T15:36:27.860547  + set +x
    2023-09-13T15:36:27.863692  <8>[   29.239305] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1251194_1.5.2.4.1>
    2023-09-13T15:36:27.971921  / # #
    2023-09-13T15:36:29.127812  export SHELL=3D/bin/sh
    2023-09-13T15:36:29.133491  #
    2023-09-13T15:36:30.675605  / # export SHELL=3D/bin/sh. /lava-1251194/e=
nvironment
    2023-09-13T15:36:30.681249  =

    2023-09-13T15:36:33.493376  / # . /lava-1251194/environment/lava-125119=
4/bin/lava-test-runner /lava-1251194/1
    2023-09-13T15:36:33.499612  =

    2023-09-13T15:36:33.501201  / # /lava-1251194/bin/lava-test-runner /lav=
a-1251194/1 =

    ... (18 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
juno-uboot                   | arm64  | lab-broonie     | gcc-10   | cip://=
5.10.y-...64_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6501d7dc1b475129ca8a0a74

  Results:     47 PASS, 13 FAIL, 1 SKIP
  Full config: cip://5.10.y-cip/arm64/qemu_arm64_defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/arm64/cip---5.10.y-cip-arm64-qemu_arm64_defconfig/=
gcc-10/lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/arm64/cip---5.10.y-cip-arm64-qemu_arm64_defconfig/=
gcc-10/lab-broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501d7dd1b475129ca8a0ab3
        failing since 16 days (last pass: v5.10.186-cip37-27-gd6d928db0a620=
, first fail: v5.10.191-cip38)

    2023-09-13T15:39:39.106924  / # #
    2023-09-13T15:39:39.210040  export SHELL=3D/bin/sh
    2023-09-13T15:39:39.210876  #
    2023-09-13T15:39:39.313336  / # export SHELL=3D/bin/sh. /lava-105272/en=
vironment
    2023-09-13T15:39:39.314187  =

    2023-09-13T15:39:39.416184  / # . /lava-105272/environment/lava-105272/=
bin/lava-test-runner /lava-105272/1
    2023-09-13T15:39:39.417467  =

    2023-09-13T15:39:39.430097  / # /lava-105272/bin/lava-test-runner /lava=
-105272/1
    2023-09-13T15:39:39.487913  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-13T15:39:39.488411  + cd /lava-105272/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6501dc298d158a7fe88a0add

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/arm64/defconfig+kselftest/gcc-10/lab-broonie/basel=
ine-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/arm64/defconfig+kselftest/gcc-10/lab-broonie/basel=
ine-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501dc298d158a7fe88a0b1d
        failing since 49 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-09-13T15:57:52.823248  / # #
    2023-09-13T15:57:52.926243  export SHELL=3D/bin/sh
    2023-09-13T15:57:52.927018  #
    2023-09-13T15:57:53.028950  / # export SHELL=3D/bin/sh. /lava-105306/en=
vironment
    2023-09-13T15:57:53.029716  =

    2023-09-13T15:57:53.131788  / # . /lava-105306/environment/lava-105306/=
bin/lava-test-runner /lava-105306/1
    2023-09-13T15:57:53.133139  =

    2023-09-13T15:57:53.146164  / # /lava-105306/bin/lava-test-runner /lava=
-105306/1
    2023-09-13T15:57:53.327916  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-13T15:57:53.328444  + cd /lava-105306/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6501db86c35ae643998a0acb

  Results:     28 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/arm64/defconfig+arm64-chromebook/gcc-10/lab-collab=
ora/baseline-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/arm64/defconfig+arm64-chromebook/gcc-10/lab-collab=
ora/baseline-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501db86c35ae643998a0aeb
        failing since 242 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-09-13T15:55:27.766064  + set +x

    2023-09-13T15:55:27.773976  <8>[   15.573333] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11517225_1.5.2.3.1>

    2023-09-13T15:55:27.878852  #

    2023-09-13T15:55:27.879988  =


    2023-09-13T15:55:27.981919  / # #export SHELL=3D/bin/sh

    2023-09-13T15:55:27.982719  =


    2023-09-13T15:55:28.084405  / # export SHELL=3D/bin/sh. /lava-11517225/=
environment

    2023-09-13T15:55:28.085195  =


    2023-09-13T15:55:28.186697  / # . /lava-11517225/environment/lava-11517=
225/bin/lava-test-runner /lava-11517225/1

    2023-09-13T15:55:28.187928  =

 =

    ... (22 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6501d3d00c2f9fe2e68a0aa8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a=
7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a=
7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6501d3d00c2f9fe2e68a0=
aa9
        new failure (last pass: v5.10.191-cip38-2-g09e5ecd8645b) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6501dbf5e0fcba352d8a0b7a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ba=
seline-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ba=
seline-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501dbf5e0fcba352d8a0b81
        failing since 49 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-09-13T15:57:26.211041  + set +x
    2023-09-13T15:57:26.214304  <8>[   84.000838] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1008476_1.5.2.4.1>
    2023-09-13T15:57:26.321567  / # #
    2023-09-13T15:57:27.786277  export SHELL=3D/bin/sh
    2023-09-13T15:57:27.807222  #
    2023-09-13T15:57:27.807688  / # export SHELL=3D/bin/sh
    2023-09-13T15:57:29.765829  / # . /lava-1008476/environment
    2023-09-13T15:57:33.368006  /lava-1008476/bin/lava-test-runner /lava-10=
08476/1
    2023-09-13T15:57:33.389437  . /lava-1008476/environment
    2023-09-13T15:57:33.389853  / # /lava-1008476/bin/lava-test-runner /lav=
a-1008476/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6501dc068d158a7fe88a0aa5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-=
r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-=
r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501dc068d158a7fe88a0aac
        failing since 49 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-09-13T15:57:37.860323  / # #
    2023-09-13T15:57:39.320356  export SHELL=3D/bin/sh
    2023-09-13T15:57:39.340877  #
    2023-09-13T15:57:39.341078  / # export SHELL=3D/bin/sh
    2023-09-13T15:57:41.294853  / # . /lava-1008469/environment
    2023-09-13T15:57:44.889955  /lava-1008469/bin/lava-test-runner /lava-10=
08469/1
    2023-09-13T15:57:44.910726  . /lava-1008469/environment
    2023-09-13T15:57:44.910837  / # /lava-1008469/bin/lava-test-runner /lav=
a-1008469/1
    2023-09-13T15:57:45.094447  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-13T15:57:45.094669  + cd /lava-1008469/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6501dd0528afd2bf748a0a4e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ba=
seline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ba=
seline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501dd0528afd2bf748a0a55
        failing since 49 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-09-13T16:01:56.693436  / # #
    2023-09-13T16:01:58.154965  export SHELL=3D/bin/sh
    2023-09-13T16:01:58.175534  #
    2023-09-13T16:01:58.175744  / # export SHELL=3D/bin/sh
    2023-09-13T16:02:00.131911  / # . /lava-1008475/environment
    2023-09-13T16:02:03.730694  /lava-1008475/bin/lava-test-runner /lava-10=
08475/1
    2023-09-13T16:02:03.751475  . /lava-1008475/environment
    2023-09-13T16:02:03.751586  / # /lava-1008475/bin/lava-test-runner /lav=
a-1008475/1
    2023-09-13T16:02:03.829274  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-13T16:02:03.829494  + cd /lava-1008475/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 4          =


  Details:     https://kernelci.org/test/plan/id/6501d6e3888fe94c668a0a9f

  Results:     63 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-i2c-present: https://kernelci.or=
g/test/case/id/6501d6e3888fe94c668a0ad2
        failing since 240 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-09-13T15:40:11.227821  FIRST,<8>[   18.628308] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>

    2023-09-13T15:40:11.229472   INC default to 1.

    2023-09-13T15:40:11.229995  =


    2023-09-13T15:40:11.233258  	-w	Pad to last with leading zeros

    2023-09-13T15:40:11.235947  	-s SEP	String separator

    2023-09-13T15:40:11.239725  /lava-11517184/1/../bin/lava-test-case

    2023-09-13T15:40:11.245956  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.

    2023-09-13T15:40:11.246197  =

   =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/6501d6e3888fe94c668a0ad3
        failing since 240 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-09-13T15:40:11.205425  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC)<8=
>[   18.609295] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-09-13T15:40:11.207530   multi-call binary.

    2023-09-13T15:40:11.207586  =


    2023-09-13T15:40:11.211906  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-09-13T15:40:11.212486  =


    2023-09-13T15:40:11.217113  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/6501d6e3888fe94c668a0ad4
        failing since 240 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-09-13T15:40:11.186540  <8>[   18.591439] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501d6e3888fe94c668a0ae8
        failing since 240 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-09-13T15:39:59.126142  <8>[    6.531051] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-09-13T15:39:59.135950  + <8>[    6.543580] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11517184_1.5.2.3.1>

    2023-09-13T15:39:59.136173  set +x

    2023-09-13T15:39:59.241629  #

    2023-09-13T15:39:59.343771  / # #export SHELL=3D/bin/sh

    2023-09-13T15:39:59.344415  =


    2023-09-13T15:39:59.445257  / # export SHELL=3D/bin/sh. /lava-11517184/=
environment

    2023-09-13T15:39:59.445924  =


    2023-09-13T15:39:59.547118  / # . /lava-11517184/environment/lava-11517=
184/bin/lava-test-runner /lava-11517184/1

    2023-09-13T15:39:59.548107  =

 =

    ... (20 line(s) more)  =

 =20

