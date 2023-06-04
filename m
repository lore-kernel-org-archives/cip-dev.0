Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524B7C7EE2E
	for <webhook@archiver.kernel.org>; Sun,  4 Jun 2023 23:52:40 +0000 (UTC)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
 by mx.groups.io with SMTP id smtpd.web11.763.1685922758074147622
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 04 Jun 2023 16:52:38 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=vFs2tI0/;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.167.176, mailfrom: bot@kernelci.org)
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-39810ce3e13so3761763b6e.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 04 Jun 2023 16:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685922757; x=1688514757;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=l2D+UWtRfcVkLra3X5hrjHs2hJaUc0ZwHVgI8mJYyCw=;
        b=vFs2tI0/LYwSQpD6QzSpGT5GeLgk0nuXjO3uLo70KeqeaAqAHZM8s1tHaJ7z/8pPbd
         pfo4ZccPWOlxu7fijP/M5m3kJ+B973zaOie0O0eV7qvWzRCo8NI0IHXLvUxymuwTlMGT
         N2mWgiAkZyOT/5yyNCC0s18n+QoMXoFHVsIZU6eOq9PSXkUW9kCH4Xyi/IcMBTOYrpee
         ftakOry5/nn52snb2XOcNiEc/dtBV6IJ089Bg/z215WC7UiY95jCUKSJGaQHGFwe1rGm
         gOGioWFKOL8H/lNAoQiV35ArSVXb7KxgKqywwXQ7pghQvuOU9S+1VE7k9tFN63xPYUIU
         2yng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685922757; x=1688514757;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l2D+UWtRfcVkLra3X5hrjHs2hJaUc0ZwHVgI8mJYyCw=;
        b=W91YNG66Jmnfyn2xW03O3kOncgS0g9hEN1jO7c2VUc5xIwIdF3EX4lnWkqpNBuQvwe
         mHqtHGPz50o44FvyfImaJ+HpMcW+RfLqTBSn3JTwbDwM6Cy6HEIZHbd5xa55zaQihOJy
         KUVPZb9TgsKNNufyyUt5TZlCOEDX80h+jqM/CeTGKgE17MzwPmCSZ13NiwZfjg9WRqMl
         VPBRYaP+x6ygqwwNzLJXUjn8dBUuA1bT9I6JqdkIuqgAVDoRdIZfpJ+eGwmB3KDmRxtH
         FY/Fstdb24ZeMeeqFLBe1caa6cwRgilZ/9Np3nXLYpKuCdNxk7K0gRusv8c1T8/fpa1s
         XRAg==
X-Gm-Message-State: AC+VfDy7FMnLQFa32G8xzWfE6aIWbdpW3CkMlvWjFsn/h/TicLJnzLQT
	xiMguAwGqvsgx679sqj1m6FsDo0pC4IYgpdyOPTV3w==
X-Google-Smtp-Source: ACHHUZ4ijlkNrQV4Arm2L/bDaO/DXGSXwfupaBNTSwKbdsui6fcs2CnlHJSPnOVxLiSCPd/xL5OtGQ==
X-Received: by 2002:aca:f06:0:b0:39a:ac4c:8f35 with SMTP id 6-20020aca0f06000000b0039aac4c8f35mr1988606oip.20.1685922756356;
        Sun, 04 Jun 2023 16:52:36 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id v19-20020aa78093000000b0064928cb5f03sm4084859pff.69.2023.06.04.16.52.35
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jun 2023 16:52:35 -0700 (PDT)
Message-ID: <647d23c3.a70a0220.d70a0.694f@mx.google.com>
Date: Sun, 04 Jun 2023 16:52:35 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.26-1301-g6369cf0363211
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test baseline: 77 runs,
 16 regressions (v6.1.26-1301-g6369cf0363211)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 04 Jun 2023 23:52:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11763

cip-gitlab/ci/pavel/linux-test baseline: 77 runs, 16 regressions (v6.1.26-1=
301-g6369cf0363211)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | at91_d=
t_defconfig            | 1          =

bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | bcm283=
5_defconfig            | 1          =

bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx7ulp-evk                  | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =

rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.26-1301-g6369cf0363211/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.26-1301-g6369cf0363211
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      6369cf036321117aa7bd9be009c3b7107cea2007 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647d188217a5892a03f5de74

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1301-g6369cf0363211/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1301-g6369cf0363211/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647d188217a5892a03f5de7d
        failing since 1 day (last pass: v4.19.280-cip95-rt30, first fail: v=
6.1.26-1281-g84d5372e0f31)

    2023-06-04T23:04:17.030736  + <8>[   12.704169] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10584287_1.4.2.3.1>

    2023-06-04T23:04:17.031224  set +x

    2023-06-04T23:04:17.139411  / # #

    2023-06-04T23:04:17.241799  export SHELL=3D/bin/sh

    2023-06-04T23:04:17.242457  #

    2023-06-04T23:04:17.343863  / # export SHELL=3D/bin/sh. /lava-10584287/=
environment

    2023-06-04T23:04:17.344552  =


    2023-06-04T23:04:17.445920  / # . /lava-10584287/environment/lava-10584=
287/bin/lava-test-runner /lava-10584287/1

    2023-06-04T23:04:17.447315  =


    2023-06-04T23:04:17.452072  / # /lava-10584287/bin/lava-test-runner /la=
va-10584287/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | at91_d=
t_defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/647d172d2d6366728bf5de40

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1301-g6369cf0363211/arm/at91_dt_defconfig/gcc-10/lab-broonie/basel=
ine-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1301-g6369cf0363211/arm/at91_dt_defconfig/gcc-10/lab-broonie/basel=
ine-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647d172d2d6366728bf5d=
e41
        new failure (last pass: v6.1.26-1281-g84d5372e0f31) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | bcm283=
5_defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/647d19963b9710ed44f5def8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1301-g6369cf0363211/arm/bcm2835_defconfig/gcc-10/lab-collabora/bas=
eline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1301-g6369cf0363211/arm/bcm2835_defconfig/gcc-10/lab-collabora/bas=
eline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647d19963b9710ed44f5df01
        failing since 1 day (last pass: v4.19.280-cip95-rt30, first fail: v=
6.1.26-1281-g84d5372e0f31)

    2023-06-04T23:08:48.996113  / # #

    2023-06-04T23:08:49.098286  export SHELL=3D/bin/sh

    2023-06-04T23:08:49.099008  #

    2023-06-04T23:08:49.200404  / # export SHELL=3D/bin/sh. /lava-10584341/=
environment

    2023-06-04T23:08:49.201124  =


    2023-06-04T23:08:49.302564  / # . /lava-10584341/environment/lava-10584=
341/bin/lava-test-runner /lava-10584341/1

    2023-06-04T23:08:49.303658  =


    2023-06-04T23:08:49.320324  / # /lava-10584341/bin/lava-test-runner /la=
va-10584341/1

    2023-06-04T23:08:49.430319  + export 'TESTRUN_ID=3D1_bootrr'

    2023-06-04T23:08:49.430839  + cd /lava-10584341/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647d1c67dc31757f17f5de26

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1301-g6369cf0363211/arm/multi_v7_defconfig/gcc-10/lab-collabora/ba=
seline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1301-g6369cf0363211/arm/multi_v7_defconfig/gcc-10/lab-collabora/ba=
seline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647d1c67dc31757f17f5d=
e27
        failing since 1 day (last pass: v4.19.280-cip95-rt30, first fail: v=
6.1.26-1281-g84d5372e0f31) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647d1b3d0463dc408af5de36

  Results:     52 PASS, 3 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1301-g6369cf0363211/arm/omap2plus_defconfig/gcc-10/lab-broonie/bas=
eline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1301-g6369cf0363211/arm/omap2plus_defconfig/gcc-10/lab-broonie/bas=
eline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647d1b3d0463dc408af5de70
        failing since 1 day (last pass: v4.19.280-cip95-rt30, first fail: v=
6.1.26-1281-g84d5372e0f31)

    2023-06-04T23:15:57.924163  <8>[   21.973661] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 560070_1.5.2.4.1>
    2023-06-04T23:15:58.033416  / # #
    2023-06-04T23:15:58.136475  export SHELL=3D/bin/sh
    2023-06-04T23:15:58.137421  #
    2023-06-04T23:15:58.239494  / # export SHELL=3D/bin/sh. /lava-560070/en=
vironment
    2023-06-04T23:15:58.240395  =

    2023-06-04T23:15:58.342541  / # . /lava-560070/environment/lava-560070/=
bin/lava-test-runner /lava-560070/1
    2023-06-04T23:15:58.343947  =

    2023-06-04T23:15:58.347781  / # /lava-560070/bin/lava-test-runner /lava=
-560070/1
    2023-06-04T23:15:58.455201  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647d1b4b9a5b28b9d8f5de31

  Results:     52 PASS, 3 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1301-g6369cf0363211/arm/omap2plus_defconfig/gcc-10/lab-cip/baselin=
e-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1301-g6369cf0363211/arm/omap2plus_defconfig/gcc-10/lab-cip/baselin=
e-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647d1b4b9a5b28b9d8f5de38
        failing since 1 day (last pass: v4.19.280-cip95-rt30, first fail: v=
6.1.26-1281-g84d5372e0f31)

    2023-06-04T23:16:05.092885  / # #
    2023-06-04T23:16:05.196781  export SHELL=3D/bin/sh
    2023-06-04T23:16:05.197982  #
    2023-06-04T23:16:05.300436  / # export SHELL=3D/bin/sh. /lava-952210/en=
vironment
    2023-06-04T23:16:05.301614  =

    2023-06-04T23:16:05.404091  / # . /lava-952210/environment/lava-952210/=
bin/lava-test-runner /lava-952210/1
    2023-06-04T23:16:05.406006  =

    2023-06-04T23:16:05.445922  / # /lava-952210/bin/lava-test-runner /lava=
-952210/1
    2023-06-04T23:16:05.559777  + export 'TESTRUN_ID=3D1_bootrr'
    2023-06-04T23:16:05.560409  + cd /lava-952210/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647d18a9fd6df3570bf5de4a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1301-g6369cf0363211/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1301-g6369cf0363211/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647d18a9fd6df3570bf5de53
        failing since 1 day (last pass: v4.19.280-cip95-rt30, first fail: v=
6.1.26-1281-g84d5372e0f31)

    2023-06-04T23:04:55.643209  + set +x

    2023-06-04T23:04:55.649787  <8>[   10.942476] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10584303_1.4.2.3.1>

    2023-06-04T23:04:55.754868  / # #

    2023-06-04T23:04:55.855514  export SHELL=3D/bin/sh

    2023-06-04T23:04:55.855714  #

    2023-06-04T23:04:55.956225  / # export SHELL=3D/bin/sh. /lava-10584303/=
environment

    2023-06-04T23:04:55.956424  =


    2023-06-04T23:04:56.057009  / # . /lava-10584303/environment/lava-10584=
303/bin/lava-test-runner /lava-10584303/1

    2023-06-04T23:04:56.057357  =


    2023-06-04T23:04:56.061833  / # /lava-10584303/bin/lava-test-runner /la=
va-10584303/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647d187f17a5892a03f5de63

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1301-g6369cf0363211/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1301-g6369cf0363211/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647d187f17a5892a03f5de6c
        failing since 1 day (last pass: v4.19.280-cip95-rt30, first fail: v=
6.1.26-1281-g84d5372e0f31)

    2023-06-04T23:04:17.741024  + set +x

    2023-06-04T23:04:17.747708  <8>[   10.617788] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10584256_1.4.2.3.1>

    2023-06-04T23:04:17.849623  =


    2023-06-04T23:04:17.950311  / # #export SHELL=3D/bin/sh

    2023-06-04T23:04:17.950518  =


    2023-06-04T23:04:18.051022  / # export SHELL=3D/bin/sh. /lava-10584256/=
environment

    2023-06-04T23:04:18.051228  =


    2023-06-04T23:04:18.151718  / # . /lava-10584256/environment/lava-10584=
256/bin/lava-test-runner /lava-10584256/1

    2023-06-04T23:04:18.152011  =


    2023-06-04T23:04:18.157414  / # /lava-10584256/bin/lava-test-runner /la=
va-10584256/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647d1881c63a015fc4f5de3a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1301-g6369cf0363211/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1301-g6369cf0363211/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647d1881c63a015fc4f5de43
        failing since 1 day (last pass: v4.19.280-cip95-rt30, first fail: v=
6.1.26-1281-g84d5372e0f31)

    2023-06-04T23:04:25.199137  + set<8>[   11.147585] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10584330_1.4.2.3.1>

    2023-06-04T23:04:25.199645   +x

    2023-06-04T23:04:25.307440  / # #

    2023-06-04T23:04:25.409669  export SHELL=3D/bin/sh

    2023-06-04T23:04:25.410315  #

    2023-06-04T23:04:25.511615  / # export SHELL=3D/bin/sh. /lava-10584330/=
environment

    2023-06-04T23:04:25.512260  =


    2023-06-04T23:04:25.613486  / # . /lava-10584330/environment/lava-10584=
330/bin/lava-test-runner /lava-10584330/1

    2023-06-04T23:04:25.613748  =


    2023-06-04T23:04:25.618610  / # /lava-10584330/bin/lava-test-runner /la=
va-10584330/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647d1dd862ad9f22b0f5de25

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1301-g6369cf0363211/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/=
baseline-imx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1301-g6369cf0363211/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/=
baseline-imx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647d1dd862ad9f22b0f5de2e
        failing since 1 day (last pass: v4.19.280-cip95-rt30, first fail: v=
6.1.26-1281-g84d5372e0f31)

    2023-06-04T23:26:57.519150  + set +x
    2023-06-04T23:26:57.519349  [   12.782697] <LAVA_SIGNAL_ENDRUN 0_dmesg =
967157_1.5.2.3.1>
    2023-06-04T23:26:57.627419  / # #
    2023-06-04T23:26:57.729097  export SHELL=3D/bin/sh
    2023-06-04T23:26:57.729581  #
    2023-06-04T23:26:57.830818  / # export SHELL=3D/bin/sh. /lava-967157/en=
vironment
    2023-06-04T23:26:57.831242  =

    2023-06-04T23:26:57.932469  / # . /lava-967157/environment/lava-967157/=
bin/lava-test-runner /lava-967157/1
    2023-06-04T23:26:57.933125  =

    2023-06-04T23:26:57.936499  / # /lava-967157/bin/lava-test-runner /lava=
-967157/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647d1959b001bf878bf5deeb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1301-g6369cf0363211/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/bas=
eline-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1301-g6369cf0363211/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/bas=
eline-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647d1959b001bf878bf5d=
eec
        failing since 1 day (last pass: v4.19.280-cip95-rt30, first fail: v=
6.1.26-1281-g84d5372e0f31) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647d194222493578dbf5de7a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1301-g6369cf0363211/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/bas=
eline-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1301-g6369cf0363211/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/bas=
eline-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647d194222493578dbf5d=
e7b
        failing since 1 day (last pass: v4.19.280-cip95-rt30, first fail: v=
6.1.26-1281-g84d5372e0f31) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7ulp-evk                  | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647d1cb4595ca642e6f5de41

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1301-g6369cf0363211/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline=
-imx7ulp-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1301-g6369cf0363211/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline=
-imx7ulp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647d1cb4595ca642e6f5de48
        failing since 74 days (last pass: v5.10.145-rt74-1329-ga59fc50f38f6=
, first fail: v5.10.175-cip29-rt12)

    2023-06-04T23:21:24.765159  + set +x
    2023-06-04T23:21:24.766306  <8>[   33.484643] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1233300_1.5.2.4.1>
    2023-06-04T23:21:24.875244  / # #
    2023-06-04T23:21:26.035536  export SHELL=3D/bin/sh
    2023-06-04T23:21:26.041106  #
    2023-06-04T23:21:26.041395  / # export SHELL=3D/bin/sh
    2023-06-04T23:21:27.589071  / # . /lava-1233300/environment
    2023-06-04T23:21:30.416885  /lava-1233300/bin/lava-test-runner /lava-12=
33300/1
    2023-06-04T23:21:30.422809  . /lava-1233300/environment
    2023-06-04T23:21:30.423068  / # /lava-1233300/bin/lava-test-runner /lav=
a-1233300/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647d177e929826a142f5def0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1301-g6369cf0363211/arm/shmobile_defconfig/gcc-10/lab-cip/baseline=
-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1301-g6369cf0363211/arm/shmobile_defconfig/gcc-10/lab-cip/baseline=
-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647d177e929826a142f5d=
ef1
        new failure (last pass: v6.1.26-1281-g84d5372e0f31) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 2          =


  Details:     https://kernelci.org/test/plan/id/647d1c3f51d149866df5de26

  Results:     66 PASS, 4 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1301-g6369cf0363211/arm/multi_v7_defconfig/gcc-10/lab-collabora/ba=
seline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1301-g6369cf0363211/arm/multi_v7_defconfig/gcc-10/lab-collabora/ba=
seline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/647d1c3f51d149866df5de5a
        failing since 135 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-06-04T23:20:09.673784  Usage: seq [-w] [-s SEP] [FIRST [INC]] LA<8=
>[   19.527233] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-06-04T23:20:09.674160  ST

    2023-06-04T23:20:09.674212  =


    2023-06-04T23:20:09.679301  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-06-04T23:20:09.681704  FIRST, INC default to 1.

    2023-06-04T23:20:09.682080  =


    2023-06-04T23:20:09.685411  	-w	Pad to last with leading zeros
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/647d1c3f51d149866df5de5b
        failing since 135 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-06-04T23:20:09.640357  <8>[   19.499590] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>

    2023-06-04T23:20:09.659302  BusyBox v1.31.1 (2023-05-27 14:14:16 UTC) m=
ulti-call binary.

    2023-06-04T23:20:09.659591  =

   =

 =20

