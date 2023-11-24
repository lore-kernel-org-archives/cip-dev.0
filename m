Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE61C61D85
	for <webhook@archiver.kernel.org>; Fri, 24 Nov 2023 02:30:13 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web11.128215.1700793013190536176
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 23 Nov 2023 18:30:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=0pj3Ud6D;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.169, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1cf98ffc257so6551115ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 23 Nov 2023 18:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700793012; x=1701397812; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aQsPMlsLa1J0RYsdDjkxFcr69P9rvYmJb6MGztzdnvc=;
        b=0pj3Ud6DdejMetRnHrWc5GSHruhNotgz3UUKO6rKF8irqx51J/KCjdwkcqRca/DpZw
         UILp3kJW32Uz/1wog2+bxcggSISvnwMVbdq+WCoZYtR7h8DwtZQtaNnRpCKhGMZVtCD/
         hHze/JYlZUNZNfrLhgbiTFZXYkVowAiejIsFaFiwYHACe8FUu9U8wZ4pAIMvyCnHhv4u
         GNVppRdOUz0eDw+7MJHoWb4V+VkPoE6AmEctSfyzhpTFSp2wJZsaV2NTJPiOxo8Fjqoo
         5Gzt35aJVaabkQItK+CeBHoPbpWckWYBmqs2sL6tc8gfeANWluAZ3ZUUa1PD9+fZDJML
         /QEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700793012; x=1701397812;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aQsPMlsLa1J0RYsdDjkxFcr69P9rvYmJb6MGztzdnvc=;
        b=WNoesErPiVT41nbYx0OzIr1ZsleK/ZvJk9zPrHMB/LnSZSJmql0ljQvFhw4PA4vKeK
         fPBx/NofdoBk56dqWldpxqETS0tryDl8Y3+dcKc/InjCQAl6/44nzawEyTS/AtiuNZW/
         ZXn9jqaw8CE2urYKQWQvZCPyZIVu5W/cf2IHxbeaAr6ZOrxnFBiKZ5UctgrtN6eQ9srV
         0eLKIWtRW8EoEG+CzXiAuANLXXxdpGtKlROVHSLZs2HG7Xqy+0gSxD6smSuuPRG/5Gvx
         sPIqqtZem8HxoUYpnxwI+kT8To4yh54cE5Pn/7aGN4BmlImyGnYvQJYr4K4/sd8cdqC+
         hfdQ==
X-Gm-Message-State: AOJu0YysyUE6OJpFjBTR2PC0+u/ll7+rilyL8cnhDndgL74ygjx9kKgX
	nL/gKYzd7WQ/mjcY5tE9Ol0DkeV3LEhHuxDsDhs=
X-Google-Smtp-Source: AGHT+IFvu9IcYZGD5Cv4ZFOlpWyu2HwIHAg0v33pbIctATnlUArushvpFiG8rBnSeJYO76+ADpIalg==
X-Received: by 2002:a17:903:246:b0:1cf:6c5d:f0c6 with SMTP id j6-20020a170903024600b001cf6c5df0c6mr1648912plh.10.1700793011245;
        Thu, 23 Nov 2023 18:30:11 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j6-20020a17090276c600b001c9b384731esm2022910plt.270.2023.11.23.18.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 18:30:10 -0800 (PST)
Message-ID: <65600ab2.170a0220.1b733.543b@mx.google.com>
Date: Thu, 23 Nov 2023 18:30:10 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.201-cip41-rt17
Subject: cip/linux-5.10.y-cip-rt baseline: 150 runs,
 23 regressions (v5.10.201-cip41-rt17)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Nov 2023 02:30:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13702

cip/linux-5.10.y-cip-rt baseline: 150 runs, 23 regressions (v5.10.201-cip41=
-rt17)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
        | regressions
-------------------------+-------+---------------+----------+--------------=
--------+------------
bcm2836-rpi-2-b          | arm   | lab-collabora | gcc-10   | bcm2835_defco=
nfig    | 1          =

beaglebone-black         | arm   | lab-broonie   | gcc-10   | defconfig    =
        | 1          =

beaglebone-black         | arm   | lab-broonie   | gcc-10   | multi_v7_defc=
onfig   | 1          =

beaglebone-black         | arm   | lab-cip       | gcc-10   | multi_v7_defc=
onfig   | 1          =

beaglebone-black         | arm   | lab-broonie   | gcc-10   | omap2plus_def=
config  | 1          =

imx6q-sabrelite          | arm   | lab-collabora | gcc-10   | defconfig    =
        | 1          =

imx6q-sabrelite          | arm   | lab-collabora | gcc-10   | multi_v7_defc=
onfig   | 1          =

imx6ul-14x14-evk         | arm   | lab-nxp       | gcc-10   | multi_v7_defc=
onfig   | 1          =

imx7d-sdb                | arm   | lab-nxp       | gcc-10   | defconfig    =
        | 1          =

imx7d-sdb                | arm   | lab-nxp       | gcc-10   | multi_v7_defc=
onfig   | 1          =

juno-uboot               | arm64 | lab-broonie   | gcc-10   | defconfig+pre=
empt_rt | 1          =

juno-uboot               | arm64 | lab-broonie   | gcc-10   | defconfig    =
        | 1          =

r8a7743-iwg20d-q7        | arm   | lab-cip       | gcc-10   | shmobile_defc=
onfig   | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+pre=
empt_rt | 1          =

r8a774c0-ek874           | arm64 | lab-cip       | gcc-10   | defconfig    =
        | 1          =

rk3288-veyron-jaq        | arm   | lab-collabora | gcc-10   | multi_v7_defc=
onfig   | 4          =

rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig+pre=
empt_rt | 1          =

rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig    =
        | 1          =

sun50i-a64-pine64-plus   | arm64 | lab-broonie   | gcc-10   | defconfig+pre=
empt_rt | 1          =

sun50i-a64-pine64-plus   | arm64 | lab-broonie   | gcc-10   | defconfig    =
        | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.201-cip41-rt17/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.201-cip41-rt17
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      78ed1354cecc021db9a1d8a8b4755fdfcd826e33 =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
        | regressions
-------------------------+-------+---------------+----------+--------------=
--------+------------
bcm2836-rpi-2-b          | arm   | lab-collabora | gcc-10   | bcm2835_defco=
nfig    | 1          =


  Details:     https://kernelci.org/test/plan/id/655ffedf769c568fcd7e4a6e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm/bcm2835_defconfig/gcc-10/lab-collabora/baseline-bcm2836-=
rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm/bcm2835_defconfig/gcc-10/lab-collabora/baseline-bcm2836-=
rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/655ffedf769c568fcd7e4a77
        failing since 65 days (last pass: v5.10.184-cip36-rt14, first fail:=
 v5.10.194-cip39-rt16)

    2023-11-24T01:45:55.792783  / # #

    2023-11-24T01:45:55.894966  export SHELL=3D/bin/sh

    2023-11-24T01:45:55.895691  #

    2023-11-24T01:45:55.997145  / # export SHELL=3D/bin/sh. /lava-12070419/=
environment

    2023-11-24T01:45:55.997882  =


    2023-11-24T01:45:56.099328  / # . /lava-12070419/environment/lava-12070=
419/bin/lava-test-runner /lava-12070419/1

    2023-11-24T01:45:56.100448  =


    2023-11-24T01:45:56.117002  / # /lava-12070419/bin/lava-test-runner /la=
va-12070419/1

    2023-11-24T01:45:56.181256  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-24T01:45:56.225084  + cd /lava-12070419/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
        | regressions
-------------------------+-------+---------------+----------+--------------=
--------+------------
beaglebone-black         | arm   | lab-broonie   | gcc-10   | defconfig    =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/6560019edb4535708c7e4a7b

  Results:     30 PASS, 15 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm/defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm/defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6560019fdb4535708c7e4aab
        failing since 301 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-11-24T01:50:52.769123  + set +x
    2023-11-24T01:50:52.877643  TESTCASE TEST_CASE_ID=3Demerg RESULT=3Dpass=
 UNITS=3Dlines MEASUREMENT=3D0>
    2023-11-24T01:50:52.878034  =

    2023-11-24T01:50:52.878380  <8>[   18.246076] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 267703_1.5.2.4.1>
    2023-11-24T01:50:52.980689  / # #export SHELL=3D/bin/sh
    2023-11-24T01:50:52.981633  =

    2023-11-24T01:50:53.083624  / # export SHELL=3D/bin/sh. /lava-267703/en=
vironment
    2023-11-24T01:50:53.084484  =

    2023-11-24T01:50:53.186630  / # . /lava-267703/environment/lava-267703/=
bin/lava-test-runner /lava-267703/1
    2023-11-24T01:50:53.187984   =

    ... (13 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
        | regressions
-------------------------+-------+---------------+----------+--------------=
--------+------------
beaglebone-black         | arm   | lab-broonie   | gcc-10   | multi_v7_defc=
onfig   | 1          =


  Details:     https://kernelci.org/test/plan/id/656001277d49354c887e4ad9

  Results:     30 PASS, 14 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebon=
e-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebon=
e-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656001277d49354c887e4b07
        failing since 301 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-11-24T01:48:53.626973  + set +x
    2023-11-24T01:48:53.730552  / # <8>[   21.971241] <LAVA_S#
    2023-11-24T01:48:53.832672  export SHELL=3D/bin/sh
    2023-11-24T01:48:53.833489  IGNAL_TESTCASE TEST_CASE_ID=3Demerg RESULT=
=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-11-24T01:48:53.833846  <8>[   21.973076] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 267658_1.5.2.4.1>
    2023-11-24T01:48:53.834074  #
    2023-11-24T01:48:53.935364  / # export SHELL=3D/bin/sh. /lava-267658/en=
vironment
    2023-11-24T01:48:53.936218  =

    2023-11-24T01:48:54.038189  / # . /lava-267658/environment/lava-267658/=
bin/lava-test-runner /lava-267658/1
    2023-11-24T01:48:54.039714   =

    ... (13 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
        | regressions
-------------------------+-------+---------------+----------+--------------=
--------+------------
beaglebone-black         | arm   | lab-cip       | gcc-10   | multi_v7_defc=
onfig   | 1          =


  Details:     https://kernelci.org/test/plan/id/65600606b6c925c0537e4ab2

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beaglebone-bl=
ack.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beaglebone-bl=
ack.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65600606b6c925c0537e4ae3
        failing since 301 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-11-24T02:09:27.005665  <8>[   16.587117] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1044237_1.5.2.4.1>
    2023-11-24T02:09:27.112508  / # #
    2023-11-24T02:09:27.213907  export SHELL=3D/bin/sh
    2023-11-24T02:09:27.214352  #
    2023-11-24T02:09:27.315313  / # export SHELL=3D/bin/sh. /lava-1044237/e=
nvironment
    2023-11-24T02:09:27.315876  =

    2023-11-24T02:09:27.416838  / # . /lava-1044237/environment/lava-104423=
7/bin/lava-test-runner /lava-1044237/1
    2023-11-24T02:09:27.417563  =

    2023-11-24T02:09:27.421797  / # /lava-1044237/bin/lava-test-runner /lav=
a-1044237/1
    2023-11-24T02:09:27.514852  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
        | regressions
-------------------------+-------+---------------+----------+--------------=
--------+------------
beaglebone-black         | arm   | lab-broonie   | gcc-10   | omap2plus_def=
config  | 1          =


  Details:     https://kernelci.org/test/plan/id/6560011d7d49354c887e4a8d

  Results:     50 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beaglebo=
ne-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beaglebo=
ne-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6560011d7d49354c887e4ac6
        failing since 246 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.175-cip29-rt12)

    2023-11-24T01:49:02.567407  / # #
    2023-11-24T01:49:02.669870  export SHELL=3D/bin/sh
    2023-11-24T01:49:02.670510  <8>[   21.281943] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 267672_1.5.2.4.1>
    2023-11-24T01:49:02.670727  #
    2023-11-24T01:49:02.772562  / # export SHELL=3D/bin/sh. /lava-267672/en=
vironment
    2023-11-24T01:49:02.773200  =

    2023-11-24T01:49:02.875099  / # . /lava-267672/environment/lava-267672/=
bin/lava-test-runner /lava-267672/1
    2023-11-24T01:49:02.875966  =

    2023-11-24T01:49:02.880983  / # /lava-267672/bin/lava-test-runner /lava=
-267672/1
    2023-11-24T01:49:02.979759  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
        | regressions
-------------------------+-------+---------------+----------+--------------=
--------+------------
imx6q-sabrelite          | arm   | lab-collabora | gcc-10   | defconfig    =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/6560009078e5f34ff97e4a8a

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm/defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm/defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6560009078e5f34ff97e4a92
        failing since 301 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-11-24T01:46:51.117715  + set +x

    2023-11-24T01:46:51.118676  / # <8>[    9.190408] <LAVA_SIGNAL_TESTCASE=
 TEST_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-11-24T01:46:51.119036  <8>[    9.191687] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12070530_1.5.2.4.1>

    2023-11-24T01:46:51.224503  #

    2023-11-24T01:46:51.327164  export SHELL=3D/bin/sh

    2023-11-24T01:46:51.327968  #

    2023-11-24T01:46:51.429539  / # export SHELL=3D/bin/sh. /lava-12070530/=
environment

    2023-11-24T01:46:51.430369  =


    2023-11-24T01:46:51.532134  / # . /lava-12070530/environment/lava-12070=
530/bin/lava-test-runner /lava-12070530/1

    2023-11-24T01:46:51.533417  =

 =

    ... (18 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
        | regressions
-------------------------+-------+---------------+----------+--------------=
--------+------------
imx6q-sabrelite          | arm   | lab-collabora | gcc-10   | multi_v7_defc=
onfig   | 1          =


  Details:     https://kernelci.org/test/plan/id/656000045216e6dca87e4a9d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-s=
abrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-s=
abrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656000045216e6dca87e4aa6
        failing since 301 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-11-24T01:44:28.779894  / # #

    2023-11-24T01:44:28.882617  export SHELL=3D/bin/sh

    2023-11-24T01:44:28.883434  #

    2023-11-24T01:44:28.985296  / # export SHELL=3D/bin/sh. /lava-12070504/=
environment

    2023-11-24T01:44:28.986142  =


    2023-11-24T01:44:29.088065  / # . /lava-12070504/environment/lava-12070=
504/bin/lava-test-runner /lava-12070504/1

    2023-11-24T01:44:29.089436  =


    2023-11-24T01:44:29.104582  / # /lava-12070504/bin/lava-test-runner /la=
va-12070504/1

    2023-11-24T01:44:29.220462  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-24T01:44:29.221060  + cd /lava-12070504/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
        | regressions
-------------------------+-------+---------------+----------+--------------=
--------+------------
imx6ul-14x14-evk         | arm   | lab-nxp       | gcc-10   | multi_v7_defc=
onfig   | 1          =


  Details:     https://kernelci.org/test/plan/id/6560004376e8c3f5117e4a92

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx6ul-14x14-=
evk.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx6ul-14x14-=
evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6560004376e8c3f5117e4a99
        failing since 246 days (last pass: v5.10.100-cip2-rt2, first fail: =
v5.10.175-cip29-rt12)

    2023-11-24T01:45:09.851776  =

    2023-11-24T01:45:09.852020  / # <8>[   29.785888] <LAVA_SIGNAL_ENDRUN 0=
_dmesg 1260110_1.5.2.4.1>
    2023-11-24T01:45:11.007647  #export SHELL=3D/bin/sh
    2023-11-24T01:45:11.013310  =

    2023-11-24T01:45:12.554910  / # export SHELL=3D/bin/sh. /lava-1260110/e=
nvironment
    2023-11-24T01:45:12.560588  =

    2023-11-24T01:45:15.372564  / # . /lava-1260110/environment/lava-126011=
0/bin/lava-test-runner /lava-1260110/1
    2023-11-24T01:45:15.378505  =

    2023-11-24T01:45:15.380165  / # /lava-1260110/bin/lava-test-runner /lav=
a-1260110/1
    2023-11-24T01:45:15.478835  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (17 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
        | regressions
-------------------------+-------+---------------+----------+--------------=
--------+------------
imx7d-sdb                | arm   | lab-nxp       | gcc-10   | defconfig    =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/656000a778e5f34ff97e4ae1

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm/defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm/defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656000a778e5f34ff97e4ae8
        failing since 301 days (last pass: v5.10.153-cip19-rt8, first fail:=
 v5.10.162-cip24-rt10)

    2023-11-24T01:46:58.247897  4.1>
    2023-11-24T01:46:58.248137  =

    2023-11-24T01:46:59.403616  / # #export SHELL=3D/bin/sh
    2023-11-24T01:46:59.409269  =

    2023-11-24T01:46:59.409556  / # export SHELL=3D/bin/sh
    2023-11-24T01:47:00.951299  / #. /lava-1260112/environment
    2023-11-24T01:47:03.767920  /lava-1260112/bin/lava-test-runner /lava-12=
60112/1
    2023-11-24T01:47:03.773991   . /lava-1260112/environment
    2023-11-24T01:47:03.774309  / # /lava-1260112/bin/lava-test-runner /lav=
a-1260112/1
    2023-11-24T01:47:03.865511  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (20 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
        | regressions
-------------------------+-------+---------------+----------+--------------=
--------+------------
imx7d-sdb                | arm   | lab-nxp       | gcc-10   | multi_v7_defc=
onfig   | 1          =


  Details:     https://kernelci.org/test/plan/id/656000301e635f066b7e4a7c

  Results:     3 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656000301e635f066b7e4a82
        failing since 301 days (last pass: v5.10.153-cip19-rt8, first fail:=
 v5.10.162-cip24-rt10)

    2023-11-24T01:45:04.436942  + set +x
    2023-11-24T01:45:04.437719  / # <8>[   17.239795] <LAVA_SIGNAL_TESTCASE=
 TEST_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-11-24T01:45:04.541723  <8>[   17.241241] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1260109_#
    2023-11-24T01:45:05.697248  export SHELL=3D/bin/sh
    2023-11-24T01:45:05.702920  1.5.2.4.1>
    2023-11-24T01:45:05.703261  #
    2023-11-24T01:45:05.703556  / # export SHELL=3D/bin/sh
    2023-11-24T01:45:07.245546  / # . /lava-1260109/environment
    2023-11-24T01:45:10.062569  /lava-1260109/bin/lava-test-runner /lava-12=
60109/1
    2023-11-24T01:45:10.068562  . /lava-1260109/environment =

    ... (22 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
        | regressions
-------------------------+-------+---------------+----------+--------------=
--------+------------
juno-uboot               | arm64 | lab-broonie   | gcc-10   | defconfig+pre=
empt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/656001074be934504a7e4aef

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-juno-=
uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-juno-=
uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656001074be934504a7e4b2f
        failing since 65 days (last pass: v5.10.186-cip37-rt15, first fail:=
 v5.10.194-cip39-rt16)

    2023-11-24T01:48:19.456206  / # <8>[   18.816429] <LAVA_SIGNAL_ENDRUN 0=
_dmesg 267678_1.5.2.4.1>#
    2023-11-24T01:48:19.559195  export SHELL=3D/bin/sh
    2023-11-24T01:48:19.559998  =

    2023-11-24T01:48:19.560481  #
    2023-11-24T01:48:19.662444  / # export SHELL=3D/bin/sh. /lava-267678/en=
vironment
    2023-11-24T01:48:19.663240  =

    2023-11-24T01:48:19.765212  / # . /lava-267678/environment/lava-267678/=
bin/lava-test-runner /lava-267678/1
    2023-11-24T01:48:19.766599  =

    2023-11-24T01:48:19.782066  / # /lava-267678/bin/lava-test-runner /lava=
-267678/1
    2023-11-24T01:48:19.839860  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (13 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
        | regressions
-------------------------+-------+---------------+----------+--------------=
--------+------------
juno-uboot               | arm64 | lab-broonie   | gcc-10   | defconfig    =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/6560049f7bdc2b36a07e4ae6

  Results:     49 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6560049f7bdc2b36a07e4b25
        new failure (last pass: v5.10.194-cip39-rt16)

    2023-11-24T02:03:44.538857  + set +x
    2023-11-24T02:03:44.539735  <8>[   26.770343] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-11-24T02:03:44.645902  / # <8>[   26.771662] <LAVA_SIGNAL_ENDRUN 0=
_dmesg 267745_1#
    2023-11-24T02:03:44.748784  export SHELL=3D/bin/sh
    2023-11-24T02:03:44.749543  .5.2.4.1>
    2023-11-24T02:03:44.750046  #
    2023-11-24T02:03:44.851911  / # export SHELL=3D/bin/sh. /lava-267745/en=
vironment
    2023-11-24T02:03:44.852654  =

    2023-11-24T02:03:44.954646  / # . /lava-267745/environment/lava-267745/=
bin/lava-test-runner /lava-267745/1
    2023-11-24T02:03:44.955911   =

    ... (16 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
        | regressions
-------------------------+-------+---------------+----------+--------------=
--------+------------
r8a7743-iwg20d-q7        | arm   | lab-cip       | gcc-10   | shmobile_defc=
onfig   | 1          =


  Details:     https://kernelci.org/test/plan/id/656001d1b2d59d214a7e4a75

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-iwg20=
d-q7.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-iwg20=
d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/656001d1b2d59d214a7e4=
a76
        new failure (last pass: v5.10.194-cip39-rt16) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
        | regressions
-------------------------+-------+---------------+----------+--------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+pre=
empt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/6560027758882d56737e4a7c

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig+preempt_rt/gcc-10/lab-cip/baseline-r8a774a1-=
hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig+preempt_rt/gcc-10/lab-cip/baseline-r8a774a1-=
hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6560027758882d56737e4a84
        new failure (last pass: v5.10.186-cip37-rt15)

    2023-11-24T01:54:37.305758  + set +x
    2023-11-24T01:54:37.321489  / # <8>[   83.444213] <LAVA_SIGNAL_TESTCASE=
 TEST_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-11-24T01:54:37.426965  <8>[   83.445433] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1044266_1.5.2.4.1>#
    2023-11-24T01:54:38.885315  export SHELL=3D/bin/sh
    2023-11-24T01:54:38.906064  =

    2023-11-24T01:54:38.906483  #
    2023-11-24T01:54:38.906840  / # export SHELL=3D/bin/sh
    2023-11-24T01:54:40.856444  / # . /lava-1044266/environment
    2023-11-24T01:54:44.443979  /lava-1044266/bin/lava-test-runner /lava-10=
44266/1
    2023-11-24T01:54:44.465218  . /lava-1044266/environment =

    ... (29 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
        | regressions
-------------------------+-------+---------------+----------+--------------=
--------+------------
r8a774c0-ek874           | arm64 | lab-cip       | gcc-10   | defconfig    =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/656004c8b1edf557187e4a98

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656004c8b1edf557187e4aa1
        new failure (last pass: v5.10.194-cip39-rt16)

    2023-11-24T02:04:38.140103  <8>[   84.798041] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1044282_1.5.2.4.1>
    2023-11-24T02:04:38.247223  / # #
    2023-11-24T02:04:39.707153  export SHELL=3D/bin/sh
    2023-11-24T02:04:39.728069  #
    2023-11-24T02:04:39.728510  / # export SHELL=3D/bin/sh
    2023-11-24T02:04:41.679988  / # . /lava-1044282/environment
    2023-11-24T02:04:45.270635  /lava-1044282/bin/lava-test-runner /lava-10=
44282/1
    2023-11-24T02:04:45.292243  . /lava-1044282/environment
    2023-11-24T02:04:45.292624  / # /lava-1044282/bin/lava-test-runner /lav=
a-1044282/1
    2023-11-24T02:04:45.330679  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (31 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
        | regressions
-------------------------+-------+---------------+----------+--------------=
--------+------------
rk3288-veyron-jaq        | arm   | lab-collabora | gcc-10   | multi_v7_defc=
onfig   | 4          =


  Details:     https://kernelci.org/test/plan/id/6560000b3e95f602d37e4a8f

  Results:     61 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-=
veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-=
veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6560000b3e95f602d37e4a96
        failing since 300 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-11-24T01:50:34.837084  + set +x

    2023-11-24T01:50:34.940659  #

    2023-11-24T01:50:34.941761  / # <8>[    6.503256] <LAVA_SIGNAL_TESTCASE=
 TEST_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-11-24T01:50:34.942040  <8>[    6.512925] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12070508_1.5.2.3.1>

    2023-11-24T01:50:35.043536  #export SHELL=3D/bin/sh

    2023-11-24T01:50:35.044248  =


    2023-11-24T01:50:35.145733  / # export SHELL=3D/bin/sh. /lava-12070508/=
environment

    2023-11-24T01:50:35.146425  =


    2023-11-24T01:50:35.247857  / # . /lava-12070508/environment/lava-12070=
508/bin/lava-test-runner /lava-12070508/1

    2023-11-24T01:50:35.248910  =

 =

    ... (19 line(s) more)  =


  * baseline.bootrr.dwhdmi-rockchip-driver-i2c-present: https://kernelci.or=
g/test/case/id/6560000c3e95f602d37e4ac2
        failing since 300 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-11-24T01:50:46.809557  FIRST,<8>[   18.457478] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>

    2023-11-24T01:50:46.811284   INC default to 1.

    2023-11-24T01:50:46.811510  =


    2023-11-24T01:50:46.814962  	-w	Pad to last with leading zeros
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/6560000c3e95f602d37e4ac3
        failing since 300 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-11-24T01:50:46.793930  ST

    2023-11-24T01:50:46.793982  =


    2023-11-24T01:50:46.798968  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/6560000c3e95f602d37e4ac4
        failing since 300 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-11-24T01:50:46.777089  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC)<8=
>[   18.432556] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-probed=
 RESULT=3Dpass>

    2023-11-24T01:50:46.778894   multi-call binary.

    2023-11-24T01:50:46.779109  =


    2023-11-24T01:50:46.793531  Usage: seq [-w] [-s SEP] [FIRST [INC]] LA<8=
>[   18.444738] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>
   =

 =



platform                 | arch  | lab           | compiler | defconfig    =
        | regressions
-------------------------+-------+---------------+----------+--------------=
--------+------------
rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig+pre=
empt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/6560009378e5f34ff97e4a9b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-rk3=
399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-rk3=
399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6560009378e5f34ff97e4aa4
        failing since 65 days (last pass: v5.10.186-cip37-rt15, first fail:=
 v5.10.194-cip39-rt16)

    2023-11-24T01:50:26.850861  / # #

    2023-11-24T01:50:28.111443  export SHELL=3D/bin/sh

    2023-11-24T01:50:28.122357  #

    2023-11-24T01:50:28.122791  / # export SHELL=3D/bin/sh

    2023-11-24T01:50:29.865611  / # . /lava-12070524/environment

    2023-11-24T01:50:33.069307  /lava-12070524/bin/lava-test-runner /lava-1=
2070524/1

    2023-11-24T01:50:33.080740  . /lava-12070524/environment

    2023-11-24T01:50:33.081062  / # /lava-12070524/bin/lava-test-runner /la=
va-12070524/1

    2023-11-24T01:50:33.130137  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-24T01:50:33.130608  + cd /lava-12070524/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
        | regressions
-------------------------+-------+---------------+----------+--------------=
--------+------------
rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig    =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/65600429fca517a1a27e4a82

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock-pi=
-4b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock-pi=
-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65600429fca517a1a27e4a8b
        failing since 65 days (last pass: v5.10.186-cip37-rt15, first fail:=
 v5.10.194-cip39-rt16)

    2023-11-24T02:01:51.722469  #

    2023-11-24T02:01:52.983660  export SHELL=3D/bin/sh

    2023-11-24T02:01:52.994626  #

    2023-11-24T02:01:52.995096  / # export SHELL=3D/bin/sh

    2023-11-24T02:01:54.738692  / # . /lava-12070622/environment

    2023-11-24T02:01:57.938966  /lava-12070622/bin/lava-test-runner /lava-1=
2070622/1

    2023-11-24T02:01:57.949365  . /lava-12070622/environment

    2023-11-24T02:01:57.949440  / # /lava-12070622/bin/lava-test-runner /la=
va-12070622/1

    2023-11-24T02:01:58.004205  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-24T02:01:58.004355  + cd /lava-12070622/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
        | regressions
-------------------------+-------+---------------+----------+--------------=
--------+------------
sun50i-a64-pine64-plus   | arm64 | lab-broonie   | gcc-10   | defconfig+pre=
empt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/6560019545bc72128a7e4a89

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-sun50=
i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-sun50=
i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6560019545bc72128a7e4=
a8a
        new failure (last pass: v5.10.194-cip39-rt16) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
        | regressions
-------------------------+-------+---------------+----------+--------------=
--------+------------
sun50i-a64-pine64-plus   | arm64 | lab-broonie   | gcc-10   | defconfig    =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/6560050309cfdafe247e4a76

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine6=
4-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine6=
4-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6560050309cfdafe247e4=
a77
        failing since 131 days (last pass: v5.10.175-cip29-rt12, first fail=
: v5.10.186-cip37-rt15) =

 =20

