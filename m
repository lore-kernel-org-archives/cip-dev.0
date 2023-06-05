Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67637C7EE2A
	for <webhook@archiver.kernel.org>; Mon,  5 Jun 2023 10:00:42 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web11.3742.1685959238107732805
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Jun 2023 03:00:38 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=AS+YM6HJ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.182, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1b011cffe7fso19905865ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Jun 2023 03:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685959237; x=1688551237;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mrT5pkP7lr1lhTaDOP8kP0Wy2TJ7pSq8u9gF3jJgn+A=;
        b=AS+YM6HJtQ9IpTMJLyUJUgetMxdSrYM+KA6iU+awU2msWXpqNdOJaczSSRAYaA9KCH
         vrq0+iAfNsweA8Af0etA+ZPGVOa57tK9Z0jsVgyQ1fqgyTVJDHo7VdgP1IB3nJaOfxz8
         NBqc3ZJffAkiYiQeQWxXWLITdy2iapeeQOdvQAImTH/t8TX6IEKrqt64hVpmsXLDGJar
         /3eeSBQZ4JeuVmWRDzyvMHcEL6F+JqTx9HhT4BL/tQgLkIDZNOY8oqc7AplqkiaGtCFy
         eeCcH5HzwdGIYf/sXUQvjzGZg0cN5SUudhLEYqe0ZNs9J8d6Rt6btAQOg96ukAl7C+Zh
         rOhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685959237; x=1688551237;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mrT5pkP7lr1lhTaDOP8kP0Wy2TJ7pSq8u9gF3jJgn+A=;
        b=CIQGIf9XkFZ7WfEs1YyauZ7qic7sOPXzsd9rvfozLHUfVxWiOAvP2rg+8DeJnu15sv
         q6sheSAo2c6GTpYLBRH81sbnR5dFTptg6MjoT2psmdEpDOJN1Dttg59W6jL1C4CTZYqv
         rEWL8kxyeLCV/xhVLEmr1S1cULyB1Ed6C5oF8AlV5rva5pI+djHM9nfXptht7VXGE7bM
         TXC3Rj1ZSr529CGk4WQpydcSorGoAQF+HPuFY6xTNc/GKZgPcH77fB72E9OG5ejZlPd0
         JK9AwmIxMf+2CUOXgX01BleLis6Fgrh6O90UnlbvqbCXLtlnil29gPr33yGIbysnUiFT
         6Jbw==
X-Gm-Message-State: AC+VfDwpdtQLY9PvSqJ8/aIPTtKuDMfKq/gkt/xbgj4MCOnSbTU9ZeK0
	7mmy1NXbmojiHrq0jYk7J2AQaOeQP+0bsvqQLZT9NA==
X-Google-Smtp-Source: ACHHUZ68qRMYVu5LQMruO1hMKykYx4sejtwueI2ohNDOs1Q3xfDYnpVpdgD6+YkH5AVCU1Fs+Vytyw==
X-Received: by 2002:a17:903:32c1:b0:1b1:9802:a31b with SMTP id i1-20020a17090332c100b001b19802a31bmr2732570plr.41.1685959235071;
        Mon, 05 Jun 2023 03:00:35 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ix22-20020a170902f81600b001a943c41c37sm6193859plb.7.2023.06.05.03.00.34
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 03:00:34 -0700 (PDT)
Message-ID: <647db242.170a0220.3c03f.a06f@mx.google.com>
Date: Mon, 05 Jun 2023 03:00:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.26-1302-g2631206dd75c2
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test baseline: 61 runs,
 9 regressions (v6.1.26-1302-g2631206dd75c2)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jun 2023 10:00:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11781

cip-gitlab/ci/pavel/linux-test baseline: 61 runs, 9 regressions (v6.1.26-13=
02-g2631206dd75c2)

Regressions Summary
-------------------

platform              | arch   | lab             | compiler | defconfig    =
                | regressions
----------------------+--------+-----------------+----------+--------------=
----------------+------------
asus-CM1400CXA-dalboz | x86_64 | lab-collabora   | gcc-10   | x86_64_defcon=
...6-chromebook | 1          =

beaglebone-black      | arm    | lab-broonie     | gcc-10   | omap2plus_def=
config          | 1          =

beaglebone-black      | arm    | lab-cip         | gcc-10   | omap2plus_def=
config          | 1          =

imx53-qsrb            | arm    | lab-pengutronix | gcc-10   | multi_v7_defc=
onfig           | 1          =

imx6dl-udoo           | arm    | lab-broonie     | gcc-10   | imx_v6_v7_def=
config          | 1          =

imx6q-udoo            | arm    | lab-broonie     | gcc-10   | imx_v6_v7_def=
config          | 1          =

imx7ulp-evk           | arm    | lab-nxp         | gcc-10   | imx_v6_v7_def=
config          | 1          =

imx7ulp-evk           | arm    | lab-nxp         | gcc-10   | multi_v7_defc=
onfig           | 1          =

r8a7743-iwg20d-q7     | arm    | lab-cip         | gcc-10   | shmobile_defc=
onfig           | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.26-1302-g2631206dd75c2/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.26-1302-g2631206dd75c2
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      2631206dd75c25509be5c8ba4a58388ccad120ec =



Test Regressions
---------------- =



platform              | arch   | lab             | compiler | defconfig    =
                | regressions
----------------------+--------+-----------------+----------+--------------=
----------------+------------
asus-CM1400CXA-dalboz | x86_64 | lab-collabora   | gcc-10   | x86_64_defcon=
...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647dae2f9cafb08978f5de68

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1302-g2631206dd75c2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1302-g2631206dd75c2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647dae2f9cafb08978f5de71
        failing since 1 day (last pass: v4.19.280-cip95-rt30, first fail: v=
6.1.26-1281-g84d5372e0f31)

    2023-06-05T09:42:59.694923  + set<8>[   11.331115] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10589509_1.4.2.3.1>

    2023-06-05T09:42:59.695500   +x

    2023-06-05T09:42:59.803430  / # #

    2023-06-05T09:42:59.905929  export SHELL=3D/bin/sh

    2023-06-05T09:42:59.906698  #

    2023-06-05T09:43:00.008243  / # export SHELL=3D/bin/sh. /lava-10589509/=
environment

    2023-06-05T09:43:00.009036  =


    2023-06-05T09:43:00.110835  / # . /lava-10589509/environment/lava-10589=
509/bin/lava-test-runner /lava-10589509/1

    2023-06-05T09:43:00.112153  =


    2023-06-05T09:43:00.116734  / # /lava-10589509/bin/lava-test-runner /la=
va-10589509/1
 =

    ... (12 line(s) more)  =

 =



platform              | arch   | lab             | compiler | defconfig    =
                | regressions
----------------------+--------+-----------------+----------+--------------=
----------------+------------
beaglebone-black      | arm    | lab-broonie     | gcc-10   | omap2plus_def=
config          | 1          =


  Details:     https://kernelci.org/test/plan/id/647daa27c47321316af5de3a

  Results:     52 PASS, 3 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1302-g2631206dd75c2/arm/omap2plus_defconfig/gcc-10/lab-broonie/bas=
eline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1302-g2631206dd75c2/arm/omap2plus_defconfig/gcc-10/lab-broonie/bas=
eline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647daa27c47321316af5de71
        failing since 1 day (last pass: v4.19.280-cip95-rt30, first fail: v=
6.1.26-1281-g84d5372e0f31)

    2023-06-05T09:25:45.497828  + set +x
    2023-06-05T09:25:45.500802  <8>[   22.805899] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 561855_1.5.2.4.1>
    2023-06-05T09:25:45.610748  / # #
    2023-06-05T09:25:45.713217  export SHELL=3D/bin/sh
    2023-06-05T09:25:45.713764  #
    2023-06-05T09:25:45.815541  / # export SHELL=3D/bin/sh. /lava-561855/en=
vironment
    2023-06-05T09:25:45.816156  =

    2023-06-05T09:25:45.917875  / # . /lava-561855/environment/lava-561855/=
bin/lava-test-runner /lava-561855/1
    2023-06-05T09:25:45.918805  =

    2023-06-05T09:25:45.922163  / # /lava-561855/bin/lava-test-runner /lava=
-561855/1 =

    ... (12 line(s) more)  =

 =



platform              | arch   | lab             | compiler | defconfig    =
                | regressions
----------------------+--------+-----------------+----------+--------------=
----------------+------------
beaglebone-black      | arm    | lab-cip         | gcc-10   | omap2plus_def=
config          | 1          =


  Details:     https://kernelci.org/test/plan/id/647daf2058a38d498bf5de30

  Results:     52 PASS, 3 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1302-g2631206dd75c2/arm/omap2plus_defconfig/gcc-10/lab-cip/baselin=
e-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1302-g2631206dd75c2/arm/omap2plus_defconfig/gcc-10/lab-cip/baselin=
e-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647daf2058a38d498bf5de37
        failing since 1 day (last pass: v4.19.280-cip95-rt30, first fail: v=
6.1.26-1281-g84d5372e0f31)

    2023-06-05T09:47:02.200073  + set +x
    2023-06-05T09:47:02.202293  <8>[   15.925557] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 952979_1.5.2.4.1>
    2023-06-05T09:47:02.311251  / # #
    2023-06-05T09:47:02.413227  export SHELL=3D/bin/sh
    2023-06-05T09:47:02.413702  #
    2023-06-05T09:47:02.515098  / # export SHELL=3D/bin/sh. /lava-952979/en=
vironment
    2023-06-05T09:47:02.515602  =

    2023-06-05T09:47:02.617016  / # . /lava-952979/environment/lava-952979/=
bin/lava-test-runner /lava-952979/1
    2023-06-05T09:47:02.617785  =

    2023-06-05T09:47:02.619950  / # /lava-952979/bin/lava-test-runner /lava=
-952979/1 =

    ... (12 line(s) more)  =

 =



platform              | arch   | lab             | compiler | defconfig    =
                | regressions
----------------------+--------+-----------------+----------+--------------=
----------------+------------
imx53-qsrb            | arm    | lab-pengutronix | gcc-10   | multi_v7_defc=
onfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647da7c27d4bc06196f5de5e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1302-g2631206dd75c2/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/=
baseline-imx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1302-g2631206dd75c2/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/=
baseline-imx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647da7c27d4bc06196f5de67
        failing since 1 day (last pass: v4.19.280-cip95-rt30, first fail: v=
6.1.26-1281-g84d5372e0f31)

    2023-06-05T09:15:22.431101  + set +x
    2023-06-05T09:15:22.431273  [   12.881987] <LAVA_SIGNAL_ENDRUN 0_dmesg =
967388_1.5.2.3.1>
    2023-06-05T09:15:22.539399  / # #
    2023-06-05T09:15:22.641050  export SHELL=3D/bin/sh
    2023-06-05T09:15:22.641542  #
    2023-06-05T09:15:22.742779  / # export SHELL=3D/bin/sh. /lava-967388/en=
vironment
    2023-06-05T09:15:22.743307  =

    2023-06-05T09:15:22.844549  / # . /lava-967388/environment/lava-967388/=
bin/lava-test-runner /lava-967388/1
    2023-06-05T09:15:22.845341  =

    2023-06-05T09:15:22.848442  / # /lava-967388/bin/lava-test-runner /lava=
-967388/1 =

    ... (12 line(s) more)  =

 =



platform              | arch   | lab             | compiler | defconfig    =
                | regressions
----------------------+--------+-----------------+----------+--------------=
----------------+------------
imx6dl-udoo           | arm    | lab-broonie     | gcc-10   | imx_v6_v7_def=
config          | 1          =


  Details:     https://kernelci.org/test/plan/id/647daadb85a4a93aa2f5de2b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1302-g2631206dd75c2/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/bas=
eline-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1302-g2631206dd75c2/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/bas=
eline-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647daadb85a4a93aa2f5d=
e2c
        failing since 1 day (last pass: v4.19.280-cip95-rt30, first fail: v=
6.1.26-1281-g84d5372e0f31) =

 =



platform              | arch   | lab             | compiler | defconfig    =
                | regressions
----------------------+--------+-----------------+----------+--------------=
----------------+------------
imx6q-udoo            | arm    | lab-broonie     | gcc-10   | imx_v6_v7_def=
config          | 1          =


  Details:     https://kernelci.org/test/plan/id/647dab182f95d39618f5de25

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1302-g2631206dd75c2/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/bas=
eline-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1302-g2631206dd75c2/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/bas=
eline-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647dab182f95d39618f5d=
e26
        failing since 1 day (last pass: v4.19.280-cip95-rt30, first fail: v=
6.1.26-1281-g84d5372e0f31) =

 =



platform              | arch   | lab             | compiler | defconfig    =
                | regressions
----------------------+--------+-----------------+----------+--------------=
----------------+------------
imx7ulp-evk           | arm    | lab-nxp         | gcc-10   | imx_v6_v7_def=
config          | 1          =


  Details:     https://kernelci.org/test/plan/id/647dab4e1f0bd9dea6f5decb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1302-g2631206dd75c2/arm/imx_v6_v7_defconfig/gcc-10/lab-nxp/baselin=
e-imx7ulp-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1302-g2631206dd75c2/arm/imx_v6_v7_defconfig/gcc-10/lab-nxp/baselin=
e-imx7ulp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647dab4e1f0bd9dea6f5d=
ecc
        new failure (last pass: v5.10.179-cip32-471-g18129e1b68691) =

 =



platform              | arch   | lab             | compiler | defconfig    =
                | regressions
----------------------+--------+-----------------+----------+--------------=
----------------+------------
imx7ulp-evk           | arm    | lab-nxp         | gcc-10   | multi_v7_defc=
onfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647da8b187e43a917ff5de4b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1302-g2631206dd75c2/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline=
-imx7ulp-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1302-g2631206dd75c2/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline=
-imx7ulp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647da8b187e43a917ff5de52
        failing since 74 days (last pass: v5.10.145-rt74-1329-ga59fc50f38f6=
, first fail: v5.10.175-cip29-rt12)

    2023-06-05T09:17:42.275700  + set +x
    2023-06-05T09:17:42.276833  <8>[   33.571387] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1233448_1.5.2.4.1>
    2023-06-05T09:17:42.386391  / # #
    2023-06-05T09:17:43.546583  export SHELL=3D/bin/sh
    2023-06-05T09:17:43.552101  #
    2023-06-05T09:17:43.552311  / # export SHELL=3D/bin/sh
    2023-06-05T09:17:45.099817  / # . /lava-1233448/environment
    2023-06-05T09:17:47.927739  /lava-1233448/bin/lava-test-runner /lava-12=
33448/1
    2023-06-05T09:17:47.933820  . /lava-1233448/environment
    2023-06-05T09:17:47.934119  / # /lava-1233448/bin/lava-test-runner /lav=
a-1233448/1 =

    ... (12 line(s) more)  =

 =



platform              | arch   | lab             | compiler | defconfig    =
                | regressions
----------------------+--------+-----------------+----------+--------------=
----------------+------------
r8a7743-iwg20d-q7     | arm    | lab-cip         | gcc-10   | shmobile_defc=
onfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647da8bcdbd3709e74f5dea1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1302-g2631206dd75c2/arm/shmobile_defconfig/gcc-10/lab-cip/baseline=
-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1302-g2631206dd75c2/arm/shmobile_defconfig/gcc-10/lab-cip/baseline=
-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647da8bcdbd3709e74f5d=
ea2
        failing since 0 day (last pass: v6.1.26-1281-g84d5372e0f31, first f=
ail: v6.1.26-1301-g6369cf0363211) =

 =20

