Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675EEC7EE23
	for <webhook@archiver.kernel.org>; Mon,  5 Jun 2023 10:00:42 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web10.3723.1685959236869493940
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Jun 2023 03:00:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=4YyHUDwC;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.178, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1b00ffb4186so25150385ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Jun 2023 03:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685959236; x=1688551236;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Gve0XyHhMGGOOZTVv4pwQbStUN4j5RL3QctQ4ag8Jys=;
        b=4YyHUDwCTXbUfXCVf4EfKLcJ4Ys6+7bcZjNc+vfBJPVlWrc3rcbadgossKv/laOEXs
         9Ael7PBrhUXlVkuIccPzjrO1V5sa0XKacoerQdnlTnSCRNDmOo6JI2e5EbHVUgAY9nMt
         GLzjXlvkgI+dEHL8l7NZ/5i5gmkVUK4kP/MxzpCTByzxSt62U38c5HDaxoPxfZZNbzZL
         P+IhtDWmF3v7GLdfgkHkAMRYXylrSCooU3bZQp2DFdgUJtbdMmeB3vfrk89nJEtzFQEg
         BTpVez+1PykAgAJ6bPT8aaeInaKT2RAWj4iQbH9AY5QpbevOCWay8H7/fab+TB/i5Bn9
         pHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685959236; x=1688551236;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gve0XyHhMGGOOZTVv4pwQbStUN4j5RL3QctQ4ag8Jys=;
        b=DomexyVZq/w5fqmXU/A/dAPrQ32liFfaIpD2ARVmnfa+LY9/2P3n+V09aJy/xp9Ret
         47YGSpwSyTf+XwgC9V5YMWr9wStk7MshLYT2qPTKrbX8KKRz1UBl18RxOL9AWiujVF1X
         D2VWmDZ1fEOFUIPnCjmptTGog16/wNJF4UWXkROTkjTpoALRCA9UP62lS0QtcohDticb
         nuE9BRrCmoG98kDtaZaGYb69ZsdayyhzrDmw4ufD2UFpCPMLYzJRzTOVf40UbG6ozF4e
         NsxQiNdflk3u/rzJrtMTxkYzsXijSk51h8Ew4UB7FSWUr0dYEnWjHz4p53VPmWZaRR/X
         8/7w==
X-Gm-Message-State: AC+VfDwfeRCDbM3yc9IwazouBIEdTflW0rFo5hHe2emCXLlVascecRYm
	sL2lSS1oOwDJIV7J9O08al4PknXRy3ETqYLaBY7mbw==
X-Google-Smtp-Source: ACHHUZ601COfH2T7fYYFyFmMDkD656ZYEuNckgBysi2ZsMDHaq5loRcGHKqn8/V/+BoysHVmeGHvGA==
X-Received: by 2002:a17:902:db86:b0:1b1:9968:53be with SMTP id m6-20020a170902db8600b001b1996853bemr3298910pld.64.1685959235636;
        Mon, 05 Jun 2023 03:00:35 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id l2-20020a170902ec0200b001b0034557afsm6161149pld.15.2023.06.05.03.00.34
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 03:00:35 -0700 (PDT)
Message-ID: <647db243.170a0220.66f79.a522@mx.google.com>
Date: Mon, 05 Jun 2023 03:00:35 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.26-1302-g2631206dd75c2
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 20 runs,
 9 regressions (v6.1.26-1302-g2631206dd75c2)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jun 2023 10:00:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11780

cip-gitlab/ci/pavel/linux-test baseline-nfs: 20 runs, 9 regressions (v6.1.2=
6-1302-g2631206dd75c2)

Regressions Summary
-------------------

platform              | arch   | lab             | compiler | defconfig    =
                | regressions
----------------------+--------+-----------------+----------+--------------=
----------------+------------
asus-CM1400CXA-dalboz | x86_64 | lab-collabora   | gcc-10   | x86_64_defcon=
...6-chromebook | 1          =

at91sam9g20ek         | arm    | lab-broonie     | gcc-10   | at91_dt_defco=
nfig            | 1          =

at91sam9g20ek         | arm    | lab-broonie     | gcc-10   | multi_v5_defc=
onfig           | 1          =

beaglebone-black      | arm    | lab-broonie     | gcc-10   | omap2plus_def=
config          | 1          =

beaglebone-black      | arm    | lab-cip         | gcc-10   | omap2plus_def=
config          | 1          =

imx53-qsrb            | arm    | lab-pengutronix | gcc-10   | imx_v6_v7_def=
config          | 1          =

imx6dl-riotboard      | arm    | lab-pengutronix | gcc-10   | multi_v7_defc=
onfig           | 1          =

imx6dl-udoo           | arm    | lab-broonie     | gcc-10   | imx_v6_v7_def=
config          | 1          =

imx6q-udoo            | arm    | lab-broonie     | gcc-10   | imx_v6_v7_def=
config          | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.26-1302-g2631206dd75c2/plan/baseline-nfs/

  Test:     baseline-nfs
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


  Details:     https://kernelci.org/test/plan/id/647db1054ccee71331f5de40

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1302-g2631206dd75c2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1302-g2631206dd75c2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647db1054ccee71331f5de49
        failing since 1 day (last pass: v4.19.280-cip95-rt30, first fail: v=
6.1.26-1281-g84d5372e0f31)

    2023-06-05T09:55:11.473114  <8>[   18.796949] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10589482_1.5.2.3.1>

    2023-06-05T09:55:11.582954  / # #

    2023-06-05T09:55:11.685446  export SHELL=3D/bin/sh

    2023-06-05T09:55:11.686260  #

    2023-06-05T09:55:11.787933  / # export SHELL=3D/bin/sh. /lava-10589482/=
environment

    2023-06-05T09:55:11.788721  =


    2023-06-05T09:55:11.890301  / # . /lava-10589482/environment/lava-10589=
482/bin/lava-test-runner /lava-10589482/1

    2023-06-05T09:55:11.891582  =


    2023-06-05T09:55:11.896360  / # /lava-10589482/bin/lava-test-runner /la=
va-10589482/1

    2023-06-05T09:55:12.005953  + export TESTRUN_ID=3D1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform              | arch   | lab             | compiler | defconfig    =
                | regressions
----------------------+--------+-----------------+----------+--------------=
----------------+------------
at91sam9g20ek         | arm    | lab-broonie     | gcc-10   | at91_dt_defco=
nfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/647da90c53d915a35ff5de62

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1302-g2631206dd75c2/arm/at91_dt_defconfig/gcc-10/lab-broonie/basel=
ine-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1302-g2631206dd75c2/arm/at91_dt_defconfig/gcc-10/lab-broonie/basel=
ine-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armel/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/647da90c53d915a35=
ff5de63
        failing since 0 day (last pass: v6.1.26-1281-g84d5372e0f31, first f=
ail: v6.1.26-1301-g6369cf0363211) =

 =



platform              | arch   | lab             | compiler | defconfig    =
                | regressions
----------------------+--------+-----------------+----------+--------------=
----------------+------------
at91sam9g20ek         | arm    | lab-broonie     | gcc-10   | multi_v5_defc=
onfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647da5d7d3b13d964af5de46

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1302-g2631206dd75c2/arm/multi_v5_defconfig/gcc-10/lab-broonie/base=
line-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1302-g2631206dd75c2/arm/multi_v5_defconfig/gcc-10/lab-broonie/base=
line-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armel/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/647da5d7d3b13d964=
af5de47
        new failure (last pass: v6.1.26-1301-g6369cf0363211) =

 =



platform              | arch   | lab             | compiler | defconfig    =
                | regressions
----------------------+--------+-----------------+----------+--------------=
----------------+------------
beaglebone-black      | arm    | lab-broonie     | gcc-10   | omap2plus_def=
config          | 1          =


  Details:     https://kernelci.org/test/plan/id/647daa582242196d5af5de6c

  Results:     52 PASS, 3 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1302-g2631206dd75c2/arm/omap2plus_defconfig/gcc-10/lab-broonie/bas=
eline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1302-g2631206dd75c2/arm/omap2plus_defconfig/gcc-10/lab-broonie/bas=
eline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647daa582242196d5af5dea6
        failing since 1 day (last pass: v4.19.280-cip95-rt30, first fail: v=
6.1.26-1281-g84d5372e0f31)

    2023-06-05T09:26:18.864238  + set +x
    2023-06-05T09:26:18.868024  <8>[   44.877369] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 561860_1.6.2.4.1>
    2023-06-05T09:26:18.988874  / # #
    2023-06-05T09:26:19.093090  export SHELL=3D/bin/sh
    2023-06-05T09:26:19.093802  #
    2023-06-05T09:26:19.196043  / # export SHELL=3D/bin/sh. /lava-561860/en=
vironment
    2023-06-05T09:26:19.196835  =

    2023-06-05T09:26:19.298887  / # . /lava-561860/environment/lava-561860/=
bin/lava-test-runner /lava-561860/1
    2023-06-05T09:26:19.299847  =

    2023-06-05T09:26:19.303276  / # /lava-561860/bin/lava-test-runner /lava=
-561860/1 =

    ... (12 line(s) more)  =

 =



platform              | arch   | lab             | compiler | defconfig    =
                | regressions
----------------------+--------+-----------------+----------+--------------=
----------------+------------
beaglebone-black      | arm    | lab-cip         | gcc-10   | omap2plus_def=
config          | 1          =


  Details:     https://kernelci.org/test/plan/id/647db1124ccee71331f5de66

  Results:     52 PASS, 3 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1302-g2631206dd75c2/arm/omap2plus_defconfig/gcc-10/lab-cip/baselin=
e-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1302-g2631206dd75c2/arm/omap2plus_defconfig/gcc-10/lab-cip/baselin=
e-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647db1124ccee71331f5de6d
        failing since 1 day (last pass: v4.19.280-cip95-rt30, first fail: v=
6.1.26-1281-g84d5372e0f31)

    2023-06-05T09:55:03.209505  / # #
    2023-06-05T09:55:03.314138  export SHELL=3D/bin/sh
    2023-06-05T09:55:03.315510  #
    2023-06-05T09:55:03.418265  / # export SHELL=3D/bin/sh. /lava-952985/en=
vironment
    2023-06-05T09:55:03.419495  =

    2023-06-05T09:55:03.522357  / # . /lava-952985/environment/lava-952985/=
bin/lava-test-runner /lava-952985/1
    2023-06-05T09:55:03.524287  =

    2023-06-05T09:55:03.534238  / # /lava-952985/bin/lava-test-runner /lava=
-952985/1
    2023-06-05T09:55:03.879523  + export TESTRUN_ID=3D1_bootrr
    2023-06-05T09:55:03.880154  + cd /lava-952985/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform              | arch   | lab             | compiler | defconfig    =
                | regressions
----------------------+--------+-----------------+----------+--------------=
----------------+------------
imx53-qsrb            | arm    | lab-pengutronix | gcc-10   | imx_v6_v7_def=
config          | 1          =


  Details:     https://kernelci.org/test/plan/id/647dab1bd623c8a677f5deb7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1302-g2631206dd75c2/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix=
/baseline-nfs-imx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1302-g2631206dd75c2/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix=
/baseline-nfs-imx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/647dab1bd623c8a67=
7f5deb8
        failing since 1 day (last pass: v4.19.280-cip95-rt30, first fail: v=
6.1.26-1281-g84d5372e0f31) =

 =



platform              | arch   | lab             | compiler | defconfig    =
                | regressions
----------------------+--------+-----------------+----------+--------------=
----------------+------------
imx6dl-riotboard      | arm    | lab-pengutronix | gcc-10   | multi_v7_defc=
onfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647da839f5887726a7f5de37

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1302-g2631206dd75c2/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/=
baseline-nfs-imx6dl-riotboard.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1302-g2631206dd75c2/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/=
baseline-nfs-imx6dl-riotboard.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647da839f5887726a7f5de40
        new failure (last pass: v6.1.26-1301-g6369cf0363211)

    2023-06-05T09:17:26.582899  + set +x
    2023-06-05T09:17:26.583114  [   27.677372] <LAVA_SIGNAL_ENDRUN 0_dmesg =
967391_1.6.2.3.1>
    2023-06-05T09:17:26.699210  / # #
    2023-06-05T09:17:26.800846  export SHELL=3D/bin/sh
    2023-06-05T09:17:26.801310  #
    2023-06-05T09:17:26.902610  / # export SHELL=3D/bin/sh. /lava-967391/en=
vironment
    2023-06-05T09:17:26.903280  =

    2023-06-05T09:17:27.004650  / # . /lava-967391/environment/lava-967391/=
bin/lava-test-runner /lava-967391/1
    2023-06-05T09:17:27.005408  =

    2023-06-05T09:17:27.008204  / # /lava-967391/bin/lava-test-runner /lava=
-967391/1 =

    ... (12 line(s) more)  =

 =



platform              | arch   | lab             | compiler | defconfig    =
                | regressions
----------------------+--------+-----------------+----------+--------------=
----------------+------------
imx6dl-udoo           | arm    | lab-broonie     | gcc-10   | imx_v6_v7_def=
config          | 1          =


  Details:     https://kernelci.org/test/plan/id/647daed7967c694f8bf5ded8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1302-g2631206dd75c2/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/bas=
eline-nfs-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1302-g2631206dd75c2/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/bas=
eline-nfs-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/647daed7967c694f8=
bf5ded9
        failing since 0 day (last pass: v6.1.26-1281-g84d5372e0f31, first f=
ail: v6.1.26-1301-g6369cf0363211) =

 =



platform              | arch   | lab             | compiler | defconfig    =
                | regressions
----------------------+--------+-----------------+----------+--------------=
----------------+------------
imx6q-udoo            | arm    | lab-broonie     | gcc-10   | imx_v6_v7_def=
config          | 1          =


  Details:     https://kernelci.org/test/plan/id/647daf3b58a38d498bf5df9a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1302-g2631206dd75c2/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/bas=
eline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1302-g2631206dd75c2/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/bas=
eline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/647daf3b58a38d498=
bf5df9b
        failing since 0 day (last pass: v6.1.26-1281-g84d5372e0f31, first f=
ail: v6.1.26-1301-g6369cf0363211) =

 =20

