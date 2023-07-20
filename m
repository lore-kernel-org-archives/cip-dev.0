Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A958AEB64DD
	for <webhook@archiver.kernel.org>; Thu, 20 Jul 2023 16:15:19 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
 by mx.groups.io with SMTP id smtpd.web11.1230.1689869711622104631
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 20 Jul 2023 09:15:11 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=t10cK0Ul;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.176, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6686708c986so847766b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 20 Jul 2023 09:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689869710; x=1690474510;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5/aG14Lak7o+vUzYfAgwFLZ7Ggt/sCf/JK0DrnCr1S4=;
        b=t10cK0UlVPE1VrOsX3sugy9Q8l+FnQj4HzvQGp3C8/8OixyevLq1Dw+kptkhBgnB/x
         WtjGNQQQY70UZupIhrgsQ6XytNjJoye/ckQ291Op3+EinzYd/c5M9JcgsL/XqTU4Akj8
         nzzDG3cNWM2yd/6uHnpVRh8kaXBNS9MO8wswgevMekGQNN9Gd1adZ5nwLrysy/QVIEPK
         ByrYnDatn04wKYg7sTIcRKTqxsR7dM+tzqdufLL7lAt21odzcdmBbH/bDw1fss7EPMB6
         Nl76LRQRDdEEMlLLJTuf83GwNrm55vdAHy14FBxxHIxedpYqFQoX615CpKGiiU9gqLRL
         VIDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689869710; x=1690474510;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5/aG14Lak7o+vUzYfAgwFLZ7Ggt/sCf/JK0DrnCr1S4=;
        b=X5aZ06EmNT1RioDaRv9l9yBiqmH2kGzC8EQeSZ/9RKJE1Dv37tMKEzRHC8SBTSy8+q
         VOPUEuFVBx1+Ztcaji5tqfZDNeGlLsSofag0B+1n7PPReLejar0h5bvR9ediQy7Cko5m
         h9Thk4Jh+Ei5ge9fiJNoQqD83YaF8eKInzcoOSWwtdxYTrAFArVn6K80nQxoRHXdSwgg
         VTyBeVTSkLSSNBhQNAFwPtkNt15U5w/xxgYv0ZcopbchFfArGab8bxFrNdS1CkEE9gQt
         Cu2aIzBqW1TQsMakaoLzPYnrcfDKJIwdrH8YqDjNuz68zMfuEXZe7W8H+XR8RWowhUb4
         G0sg==
X-Gm-Message-State: ABy/qLaOMsKB9TIoMUCKNrJIuynLEwHpBEGwFBrsDnAf3ARPIA/p5/u/
	jCN4LBxaNc5kSnr+/dNg+PH4rR7TChOZJLFb+SYmJw==
X-Google-Smtp-Source: APBJJlEGd9KR+BQx2uKwIN/+Qw+2l4W7RUwtHySjHsrmKr7xhLJpzbBMNmxqTe6OSQB2dMvkQw3mZQ==
X-Received: by 2002:a05:6a20:6a22:b0:130:a400:1d88 with SMTP id p34-20020a056a206a2200b00130a4001d88mr3425671pzk.32.1689869709825;
        Thu, 20 Jul 2023 09:15:09 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id q14-20020a62e10e000000b0064cca73d911sm1381212pfh.103.2023.07.20.09.15.08
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 09:15:09 -0700 (PDT)
Message-ID: <64b95d8d.620a0220.6f65d.24d3@mx.google.com>
Date: Thu, 20 Jul 2023 09:15:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v5.10.186-cip37-12-gf8c9ce666de7b
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline: 58 runs,
 37 regressions (v5.10.186-cip37-12-gf8c9ce666de7b)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Jul 2023 16:15:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12477

cip-gitlab/ci/pavel/linux-test baseline: 58 runs, 37 regressions (v5.10.186=
-cip37-12-gf8c9ce666de7b)

Regressions Summary
-------------------

platform               | arch | lab             | compiler | defconfig     =
      | regressions
-----------------------+------+-----------------+----------+---------------=
------+------------
at91sam9g20ek          | arm  | lab-broonie     | gcc-10   | at91_dt_defcon=
fig   | 3          =

at91sam9g20ek          | arm  | lab-broonie     | gcc-10   | multi_v5_defco=
nfig  | 1          =

bcm2836-rpi-2-b        | arm  | lab-collabora   | gcc-10   | multi_v7_defco=
nfig  | 1          =

beaglebone-black       | arm  | lab-broonie     | gcc-10   | multi_v7_defco=
nfig  | 7          =

beaglebone-black       | arm  | lab-cip         | gcc-10   | multi_v7_defco=
nfig  | 7          =

beaglebone-black       | arm  | lab-broonie     | gcc-10   | omap2plus_defc=
onfig | 2          =

beaglebone-black       | arm  | lab-cip         | gcc-10   | omap2plus_defc=
onfig | 2          =

imx6dl-udoo            | arm  | lab-broonie     | gcc-10   | imx_v6_v7_defc=
onfig | 1          =

imx6dl-udoo            | arm  | lab-broonie     | gcc-10   | multi_v7_defco=
nfig  | 1          =

imx6q-udoo             | arm  | lab-broonie     | gcc-10   | imx_v6_v7_defc=
onfig | 1          =

imx6q-udoo             | arm  | lab-broonie     | gcc-10   | multi_v7_defco=
nfig  | 1          =

imx6qp-wandboard-revd1 | arm  | lab-pengutronix | gcc-10   | imx_v6_v7_defc=
onfig | 1          =

imx6qp-wandboard-revd1 | arm  | lab-pengutronix | gcc-10   | multi_v7_defco=
nfig  | 1          =

imx7d-sdb              | arm  | lab-nxp         | gcc-10   | imx_v6_v7_defc=
onfig | 1          =

imx7d-sdb              | arm  | lab-nxp         | gcc-10   | multi_v7_defco=
nfig  | 1          =

imx7ulp-evk            | arm  | lab-nxp         | gcc-10   | multi_v7_defco=
nfig  | 1          =

rk3288-veyron-jaq      | arm  | lab-collabora   | gcc-10   | multi_v7_defco=
nfig  | 5          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.186-cip37-12-gf8c9ce666de7b/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.186-cip37-12-gf8c9ce666de7b
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      f8c9ce666de7b69f842e25063054c803ff45d06d =



Test Regressions
---------------- =



platform               | arch | lab             | compiler | defconfig     =
      | regressions
-----------------------+------+-----------------+----------+---------------=
------+------------
at91sam9g20ek          | arm  | lab-broonie     | gcc-10   | at91_dt_defcon=
fig   | 3          =


  Details:     https://kernelci.org/test/plan/id/64b9562bc71ec71bf98ace1c

  Results:     49 PASS, 4 FAIL, 1 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-gf8c9ce666de7b/arm/at91_dt_defconfig/gcc-10/lab-broonie=
/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-gf8c9ce666de7b/arm/at91_dt_defconfig/gcc-10/lab-broonie=
/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.gpio-keys-probed: https://kernelci.org/test/case/id/64b=
9562bc71ec71bf98ace21
        new failure (last pass: v6.1.38-cip1-13-ga3621452a4fc)

    2023-07-20T15:43:35.565515  /lava-3575/1/../bin/lava-test-case
    2023-07-20T15:43:35.603930  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dgpi=
o-keys-probed RESULT=3Dfail>   =


  * baseline.bootrr.wm8731-driver-present: https://kernelci.org/test/case/i=
d/64b9562bc71ec71bf98ace2c
        new failure (last pass: v6.1.38-cip1-13-ga3621452a4fc)

    2023-07-20T15:43:31.354767  /lava-3575/1/../bin/lava-test-case
    2023-07-20T15:43:31.393843  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Deep=
rom-probed RESULT=3Dblocked>
    2023-07-20T15:43:31.436889  sh: /sys/bus/spi/drivers/wm8731: unknown op=
erand
    2023-07-20T15:43:32.456341  /lava-3575/1/../bin/lava-test-case
    2023-07-20T15:43:32.495104  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dwm8=
731-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.at24-driver-present: https://kernelci.org/test/case/id/=
64b9562bc71ec71bf98ace2d
        new failure (last pass: v6.1.38-cip1-13-ga3621452a4fc)

    2023-07-20T15:43:30.253237  /lava-3575/1/../bin/lava-test-case
    2023-07-20T15:43:30.292020  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dat2=
4-driver-present RESULT=3Dfail>   =

 =



platform               | arch | lab             | compiler | defconfig     =
      | regressions
-----------------------+------+-----------------+----------+---------------=
------+------------
at91sam9g20ek          | arm  | lab-broonie     | gcc-10   | multi_v5_defco=
nfig  | 1          =


  Details:     https://kernelci.org/test/plan/id/64b9559f4b0a13bb2a8ace1c

  Results:     47 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-gf8c9ce666de7b/arm/multi_v5_defconfig/gcc-10/lab-brooni=
e/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-gf8c9ce666de7b/arm/multi_v5_defconfig/gcc-10/lab-brooni=
e/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.gpio-keys-probed: https://kernelci.org/test/case/id/64b=
9559f4b0a13bb2a8ace21
        new failure (last pass: v6.1.38-cip1-13-ga3621452a4fc)

    2023-07-20T15:40:57.711446  /lava-3391/1/../bin/lava-test-case
    2023-07-20T15:40:57.749375  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dgpi=
o-keys-probed RESULT=3Dfail>   =

 =



platform               | arch | lab             | compiler | defconfig     =
      | regressions
-----------------------+------+-----------------+----------+---------------=
------+------------
bcm2836-rpi-2-b        | arm  | lab-collabora   | gcc-10   | multi_v7_defco=
nfig  | 1          =


  Details:     https://kernelci.org/test/plan/id/64b93d21f63845445d8ace24

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-gf8c9ce666de7b/arm/multi_v7_defconfig/gcc-10/lab-collab=
ora/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-gf8c9ce666de7b/arm/multi_v7_defconfig/gcc-10/lab-collab=
ora/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64b93d21f63845445d8ac=
e25
        failing since 36 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70) =

 =



platform               | arch | lab             | compiler | defconfig     =
      | regressions
-----------------------+------+-----------------+----------+---------------=
------+------------
beaglebone-black       | arm  | lab-broonie     | gcc-10   | multi_v7_defco=
nfig  | 7          =


  Details:     https://kernelci.org/test/plan/id/64b9438a90536310e58ace5a

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-gf8c9ce666de7b/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-gf8c9ce666de7b/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.hdmi-audio: https://kernelci.org/test/case/id/64b9438a9=
0536310e58ace5d
        new failure (last pass: v6.1.38-cip1-13-ga3621452a4fc)

    2023-07-20T14:24:03.704762  /lava-3426/1/../bin/lava-test-case
    2023-07-20T14:24:03.739073  <8>[   43.800563] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/id/64=
b9438a90536310e58ace5e
        new failure (last pass: v6.1.38-cip1-13-ga3621452a4fc)

    2023-07-20T14:24:02.644706  /lava-3426/1/../bin/lava-test-case
    2023-07-20T14:24:02.678849  <8>[   42.740435] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-codec-driver-present: https://kernelci.org/test/ca=
se/id/64b9438a90536310e58ace60
        new failure (last pass: v6.1.38-cip1-13-ga3621452a4fc)

    2023-07-20T14:24:00.468698  /lava-3426/1/../bin/lava-test-case
    2023-07-20T14:24:00.507781  <8>[   40.568623] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-07-20T14:24:01.534160  /lava-3426/1/../bin/lava-test-case
    2023-07-20T14:24:01.570037  <8>[   41.630698] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case/id/=
64b9438a90536310e58ace61
        new failure (last pass: v6.1.38-cip1-13-ga3621452a4fc)

    2023-07-20T14:23:58.347745  /lava-3426/1/../bin/lava-test-case
    2023-07-20T14:23:58.381941  <8>[   38.442486] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-07-20T14:23:59.408307  /lava-3426/1/../bin/lava-test-case
    2023-07-20T14:23:59.442147  <8>[   39.502655] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline.bootrr.tda19988-driver-present: https://kernelci.org/test/case=
/id/64b9438a90536310e58ace62
        new failure (last pass: v6.1.38-cip1-13-ga3621452a4fc)

    2023-07-20T14:23:56.219427  /lava-3426/1/../bin/lava-test-case
    2023-07-20T14:23:56.258366  <8>[   36.318941] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-07-20T14:23:57.284667  /lava-3426/1/../bin/lava-test-case
    2023-07-20T14:23:57.320766  <8>[   37.380795] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/64b9438a90536310e58ace6e
        new failure (last pass: v6.1.38-cip1-13-ga3621452a4fc)

    2023-07-20T14:23:44.290325  /lava-3426/1/../bin/lava-test-case
    2023-07-20T14:23:44.329625  <8>[   24.388491] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b9438b90536310e58ace87
        new failure (last pass: v6.1.38-cip1-13-ga3621452a4fc)

    2023-07-20T14:23:38.548317  <8>[   18.609072] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3426_1.5.2.4.1>
    2023-07-20T14:23:38.656152  / # #
    2023-07-20T14:23:38.757905  export SHELL=3D/bin/sh
    2023-07-20T14:23:38.758347  #
    2023-07-20T14:23:38.859614  / # export SHELL=3D/bin/sh. /lava-3426/envi=
ronment
    2023-07-20T14:23:38.860041  =

    2023-07-20T14:23:38.961341  / # . /lava-3426/environment/lava-3426/bin/=
lava-test-runner /lava-3426/1
    2023-07-20T14:23:38.961909  =

    2023-07-20T14:23:38.966118  / # /lava-3426/bin/lava-test-runner /lava-3=
426/1
    2023-07-20T14:23:39.063870  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform               | arch | lab             | compiler | defconfig     =
      | regressions
-----------------------+------+-----------------+----------+---------------=
------+------------
beaglebone-black       | arm  | lab-cip         | gcc-10   | multi_v7_defco=
nfig  | 7          =


  Details:     https://kernelci.org/test/plan/id/64b93d0b51ab6b09ce8ace21

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-gf8c9ce666de7b/arm/multi_v7_defconfig/gcc-10/lab-cip/ba=
seline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-gf8c9ce666de7b/arm/multi_v7_defconfig/gcc-10/lab-cip/ba=
seline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b93d0b51ab6b09ce8ace24
        new failure (last pass: v6.1.38-cip1-13-ga3621452a4fc)

    2023-07-20T13:55:58.362151  <8>[   15.768497] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 987973_1.5.2.4.1>
    2023-07-20T13:55:58.471485  / # #
    2023-07-20T13:55:58.572764  export SHELL=3D/bin/sh
    2023-07-20T13:55:58.573046  #
    2023-07-20T13:55:58.674094  / # export SHELL=3D/bin/sh. /lava-987973/en=
vironment
    2023-07-20T13:55:58.674363  =

    2023-07-20T13:55:58.775428  / # . /lava-987973/environment/lava-987973/=
bin/lava-test-runner /lava-987973/1
    2023-07-20T13:55:58.775923  =

    2023-07-20T13:55:58.782316  / # /lava-987973/bin/lava-test-runner /lava=
-987973/1
    2023-07-20T13:55:58.878603  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/64b93d0b51ab6b09ce8ace3d
        new failure (last pass: v6.1.38-cip1-13-ga3621452a4fc)

    2023-07-20T13:56:04.102349  /lava-987973/1/../bin/lava-test-case
    2023-07-20T13:56:04.137421  <8>[   21.541411] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.tda19988-driver-present: https://kernelci.org/test/case=
/id/64b93d0b51ab6b09ce8ace49
        new failure (last pass: v6.1.38-cip1-13-ga3621452a4fc)

    2023-07-20T13:56:16.042788  /lava-987973/1/../bin/lava-test-case
    2023-07-20T13:56:16.076624  <8>[   33.481544] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-07-20T13:56:17.104664  /lava-987973/1/../bin/lava-test-case
    2023-07-20T13:56:17.137230  <8>[   34.542589] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case/id/=
64b93d0b51ab6b09ce8ace4a
        new failure (last pass: v6.1.38-cip1-13-ga3621452a4fc)

    2023-07-20T13:56:18.165221  /lava-987973/1/../bin/lava-test-case
    2023-07-20T13:56:18.203412  <8>[   35.608185] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-07-20T13:56:19.230034  /lava-987973/1/../bin/lava-test-case
    2023-07-20T13:56:19.266380  <8>[   36.670318] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-codec-driver-present: https://kernelci.org/test/ca=
se/id/64b93d0b51ab6b09ce8ace4b
        new failure (last pass: v6.1.38-cip1-13-ga3621452a4fc)

    2023-07-20T13:56:20.292166  /lava-987973/1/../bin/lava-test-case
    2023-07-20T13:56:20.322979  <8>[   37.727536] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-07-20T13:56:21.350644  /lava-987973/1/../bin/lava-test-case
    2023-07-20T13:56:21.388751  <8>[   38.790582] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/id/64=
b93d0b51ab6b09ce8ace4d
        new failure (last pass: v6.1.38-cip1-13-ga3621452a4fc)

    2023-07-20T13:56:22.459472  /lava-987973/1/../bin/lava-test-case
    2023-07-20T13:56:22.494275  <8>[   39.900364] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-audio: https://kernelci.org/test/case/id/64b93d0b5=
1ab6b09ce8ace4e
        new failure (last pass: v6.1.38-cip1-13-ga3621452a4fc)

    2023-07-20T13:56:23.521080  /lava-987973/1/../bin/lava-test-case
    2023-07-20T13:56:23.554940  <8>[   40.960564] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =

 =



platform               | arch | lab             | compiler | defconfig     =
      | regressions
-----------------------+------+-----------------+----------+---------------=
------+------------
beaglebone-black       | arm  | lab-broonie     | gcc-10   | omap2plus_defc=
onfig | 2          =


  Details:     https://kernelci.org/test/plan/id/64b9509d9f1b0e1d118ace1c

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-gf8c9ce666de7b/arm/omap2plus_defconfig/gcc-10/lab-broon=
ie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-gf8c9ce666de7b/arm/omap2plus_defconfig/gcc-10/lab-broon=
ie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/id/6=
4b9509d9f1b0e1d118ace37
        new failure (last pass: v6.1.38-cip1-13-ga3621452a4fc)

    2023-07-20T15:19:41.938456  /lava-3699/1/../bin/lava-test-case
    2023-07-20T15:19:41.979176  <8>[   23.397636] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b9509d9f1b0e1d118ace52
        failing since 36 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-07-20T15:19:38.034034  <8>[   19.453858] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3699_1.5.2.4.1>
    2023-07-20T15:19:38.144053  / # #
    2023-07-20T15:19:38.247224  export SHELL=3D/bin/sh
    2023-07-20T15:19:38.247993  #
    2023-07-20T15:19:38.350440  / # export SHELL=3D/bin/sh. /lava-3699/envi=
ronment
    2023-07-20T15:19:38.351227  =

    2023-07-20T15:19:38.453865  / # . /lava-3699/environment/lava-3699/bin/=
lava-test-runner /lava-3699/1
    2023-07-20T15:19:38.455239  =

    2023-07-20T15:19:38.459774  / # /lava-3699/bin/lava-test-runner /lava-3=
699/1
    2023-07-20T15:19:38.563906  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform               | arch | lab             | compiler | defconfig     =
      | regressions
-----------------------+------+-----------------+----------+---------------=
------+------------
beaglebone-black       | arm  | lab-cip         | gcc-10   | omap2plus_defc=
onfig | 2          =


  Details:     https://kernelci.org/test/plan/id/64b950bc9f1b0e1d118ace5a

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-gf8c9ce666de7b/arm/omap2plus_defconfig/gcc-10/lab-cip/b=
aseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-gf8c9ce666de7b/arm/omap2plus_defconfig/gcc-10/lab-cip/b=
aseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b950bc9f1b0e1d118ace5d
        failing since 36 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-07-20T15:20:01.050102  <8>[   13.009060] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 987982_1.5.2.4.1>
    2023-07-20T15:20:01.158489  / # #
    2023-07-20T15:20:01.260651  export SHELL=3D/bin/sh
    2023-07-20T15:20:01.261351  #
    2023-07-20T15:20:01.363076  / # export SHELL=3D/bin/sh. /lava-987982/en=
vironment
    2023-07-20T15:20:01.363767  =

    2023-07-20T15:20:01.465597  / # . /lava-987982/environment/lava-987982/=
bin/lava-test-runner /lava-987982/1
    2023-07-20T15:20:01.466565  =

    2023-07-20T15:20:01.473333  / # /lava-987982/bin/lava-test-runner /lava=
-987982/1
    2023-07-20T15:20:01.582343  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =


  * baseline.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/id/6=
4b950bc9f1b0e1d118ace78
        new failure (last pass: v6.1.38-cip1-13-ga3621452a4fc)

    2023-07-20T15:20:04.955400  /lava-987982/1/../bin/lava-test-case
    2023-07-20T15:20:04.998719  <8>[   16.956045] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =

 =



platform               | arch | lab             | compiler | defconfig     =
      | regressions
-----------------------+------+-----------------+----------+---------------=
------+------------
imx6dl-udoo            | arm  | lab-broonie     | gcc-10   | imx_v6_v7_defc=
onfig | 1          =


  Details:     https://kernelci.org/test/plan/id/64b94ca06a7a0787ef8ace2d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-gf8c9ce666de7b/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-gf8c9ce666de7b/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64b94ca06a7a0787ef8ac=
e2e
        failing since 36 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70) =

 =



platform               | arch | lab             | compiler | defconfig     =
      | regressions
-----------------------+------+-----------------+----------+---------------=
------+------------
imx6dl-udoo            | arm  | lab-broonie     | gcc-10   | multi_v7_defco=
nfig  | 1          =


  Details:     https://kernelci.org/test/plan/id/64b9431615e469cf978ace1d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-gf8c9ce666de7b/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-gf8c9ce666de7b/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64b9431615e469cf978ac=
e1e
        new failure (last pass: v6.1.38-cip1-13-ga3621452a4fc) =

 =



platform               | arch | lab             | compiler | defconfig     =
      | regressions
-----------------------+------+-----------------+----------+---------------=
------+------------
imx6q-udoo             | arm  | lab-broonie     | gcc-10   | imx_v6_v7_defc=
onfig | 1          =


  Details:     https://kernelci.org/test/plan/id/64b94cdc6a7a0787ef8ace3b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-gf8c9ce666de7b/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-gf8c9ce666de7b/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64b94cdc6a7a0787ef8ac=
e3c
        failing since 36 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70) =

 =



platform               | arch | lab             | compiler | defconfig     =
      | regressions
-----------------------+------+-----------------+----------+---------------=
------+------------
imx6q-udoo             | arm  | lab-broonie     | gcc-10   | multi_v7_defco=
nfig  | 1          =


  Details:     https://kernelci.org/test/plan/id/64b943521a7d433b7e8ace2e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-gf8c9ce666de7b/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-gf8c9ce666de7b/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64b943521a7d433b7e8ac=
e2f
        new failure (last pass: v6.1.38-cip1-13-ga3621452a4fc) =

 =



platform               | arch | lab             | compiler | defconfig     =
      | regressions
-----------------------+------+-----------------+----------+---------------=
------+------------
imx6qp-wandboard-revd1 | arm  | lab-pengutronix | gcc-10   | imx_v6_v7_defc=
onfig | 1          =


  Details:     https://kernelci.org/test/plan/id/64b94ba24031d970a08ace46

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-gf8c9ce666de7b/arm/imx_v6_v7_defconfig/gcc-10/lab-pengu=
tronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-gf8c9ce666de7b/arm/imx_v6_v7_defconfig/gcc-10/lab-pengu=
tronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b94ba24031d970a08ace4b
        new failure (last pass: v6.1.38-cip1-13-ga3621452a4fc)

    2023-07-20T14:58:16.834199  + set +x
    2023-07-20T14:58:16.834381  [   10.295771] <LAVA_SIGNAL_ENDRUN 0_dmesg =
995851_1.5.2.3.1>
    2023-07-20T14:58:16.942621  / # #
    2023-07-20T14:58:17.044228  export SHELL=3D/bin/sh
    2023-07-20T14:58:17.044677  #
    2023-07-20T14:58:17.145945  / # export SHELL=3D/bin/sh. /lava-995851/en=
vironment
    2023-07-20T14:58:17.146512  =

    2023-07-20T14:58:17.248050  / # . /lava-995851/environment/lava-995851/=
bin/lava-test-runner /lava-995851/1
    2023-07-20T14:58:17.249226  =

    2023-07-20T14:58:17.251797  / # /lava-995851/bin/lava-test-runner /lava=
-995851/1 =

    ... (12 line(s) more)  =

 =



platform               | arch | lab             | compiler | defconfig     =
      | regressions
-----------------------+------+-----------------+----------+---------------=
------+------------
imx6qp-wandboard-revd1 | arm  | lab-pengutronix | gcc-10   | multi_v7_defco=
nfig  | 1          =


  Details:     https://kernelci.org/test/plan/id/64b93cca28dbdfe7368ace44

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-gf8c9ce666de7b/arm/multi_v7_defconfig/gcc-10/lab-pengut=
ronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-gf8c9ce666de7b/arm/multi_v7_defconfig/gcc-10/lab-pengut=
ronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b93cca28dbdfe7368ace49
        new failure (last pass: v6.1.38-cip1-13-ga3621452a4fc)

    2023-07-20T13:55:14.427147  + set[    7.257784] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 995843_1.5.2.3.1>
    2023-07-20T13:55:14.427304   +x
    2023-07-20T13:55:14.532791  / # #
    2023-07-20T13:55:14.634508  export SHELL=3D/bin/sh
    2023-07-20T13:55:14.634949  #
    2023-07-20T13:55:14.736189  / # export SHELL=3D/bin/sh. /lava-995843/en=
vironment
    2023-07-20T13:55:14.736643  =

    2023-07-20T13:55:14.837899  / # . /lava-995843/environment/lava-995843/=
bin/lava-test-runner /lava-995843/1
    2023-07-20T13:55:14.838481  =

    2023-07-20T13:55:14.840994  / # /lava-995843/bin/lava-test-runner /lava=
-995843/1 =

    ... (12 line(s) more)  =

 =



platform               | arch | lab             | compiler | defconfig     =
      | regressions
-----------------------+------+-----------------+----------+---------------=
------+------------
imx7d-sdb              | arm  | lab-nxp         | gcc-10   | imx_v6_v7_defc=
onfig | 1          =


  Details:     https://kernelci.org/test/plan/id/64b94bc7c044e8d2db8ace1c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-gf8c9ce666de7b/arm/imx_v6_v7_defconfig/gcc-10/lab-nxp/b=
aseline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-gf8c9ce666de7b/arm/imx_v6_v7_defconfig/gcc-10/lab-nxp/b=
aseline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.all-cpus-are-online: https://kernelci.org/test/case/id/=
64b94bc7c044e8d2db8ace20
        new failure (last pass: v6.1.38-cip1-13-ga3621452a4fc)

    2023-07-20T14:59:03.789474  /lava-1237803/1/../bin/lava-test-case
    2023-07-20T14:59:03.837428  <8>[   32.450357] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dall-cpus-are-online RESULT=3Dfail>   =

 =



platform               | arch | lab             | compiler | defconfig     =
      | regressions
-----------------------+------+-----------------+----------+---------------=
------+------------
imx7d-sdb              | arm  | lab-nxp         | gcc-10   | multi_v7_defco=
nfig  | 1          =


  Details:     https://kernelci.org/test/plan/id/64b93d2bf63845445d8ace75

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-gf8c9ce666de7b/arm/multi_v7_defconfig/gcc-10/lab-nxp/ba=
seline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-gf8c9ce666de7b/arm/multi_v7_defconfig/gcc-10/lab-nxp/ba=
seline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.all-cpus-are-online: https://kernelci.org/test/case/id/=
64b93d2bf63845445d8ace79
        new failure (last pass: v6.1.38-cip1-13-ga3621452a4fc)

    2023-07-20T13:56:33.566490  /lava-1237793/1/../bin/lava-test-case
    2023-07-20T13:56:33.587480  <8>[   24.966763] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dall-cpus-are-online RESULT=3Dfail>
    2023-07-20T13:56:33.587737  /lava-1237793/1/../bin/lava-test-case   =

 =



platform               | arch | lab             | compiler | defconfig     =
      | regressions
-----------------------+------+-----------------+----------+---------------=
------+------------
imx7ulp-evk            | arm  | lab-nxp         | gcc-10   | multi_v7_defco=
nfig  | 1          =


  Details:     https://kernelci.org/test/plan/id/64b93d1744ea2f1e978ace2e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-gf8c9ce666de7b/arm/multi_v7_defconfig/gcc-10/lab-nxp/ba=
seline-imx7ulp-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-gf8c9ce666de7b/arm/multi_v7_defconfig/gcc-10/lab-nxp/ba=
seline-imx7ulp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b93d1744ea2f1e978ace31
        failing since 120 days (last pass: v5.10.145-rt74-1329-ga59fc50f38f=
6, first fail: v5.10.175-cip29-rt12)

    2023-07-20T13:56:26.586655  + set +x<8>[   29.024177] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 1237791_1.5.2.4.1>
    2023-07-20T13:56:26.586954  =

    2023-07-20T13:56:26.694805  / # #
    2023-07-20T13:56:27.850861  export SHELL=3D/bin/sh
    2023-07-20T13:56:27.856486  #
    2023-07-20T13:56:27.856781  / # export SHELL=3D/bin/sh
    2023-07-20T13:56:29.398816  / # . /lava-1237791/environment
    2023-07-20T13:56:32.216207  /lava-1237791/bin/lava-test-runner /lava-12=
37791/1
    2023-07-20T13:56:32.222249  . /lava-1237791/environment
    2023-07-20T13:56:32.222518  / # /lava-1237791/bin/lava-test-runner /lav=
a-1237791/1 =

    ... (12 line(s) more)  =

 =



platform               | arch | lab             | compiler | defconfig     =
      | regressions
-----------------------+------+-----------------+----------+---------------=
------+------------
rk3288-veyron-jaq      | arm  | lab-collabora   | gcc-10   | multi_v7_defco=
nfig  | 5          =


  Details:     https://kernelci.org/test/plan/id/64b93cd128dbdfe7368ace52

  Results:     63 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-gf8c9ce666de7b/arm/multi_v7_defconfig/gcc-10/lab-collab=
ora/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-gf8c9ce666de7b/arm/multi_v7_defconfig/gcc-10/lab-collab=
ora/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-iodomain-grf-probed: https://kernelci.org/test=
/case/id/64b93cd128dbdfe7368ace68
        new failure (last pass: v6.1.38-cip1-13-ga3621452a4fc)

    2023-07-20T13:57:00.285509  <8>[   21.349521] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-iodomain-driver-present RESULT=3Dpass>
   =


  * baseline.bootrr.dwmmc_rockchip-sdio0-probed: https://kernelci.org/test/=
case/id/64b93cd128dbdfe7368ace7e
        new failure (last pass: v6.1.38-cip1-13-ga3621452a4fc)

    2023-07-20T13:56:58.873066  /lava-11119597/1/../bin/lava-test-case<8>[ =
  19.937656] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwmmc_rockchip-sdmmc-prob=
ed RESULT=3Dfail>

    2023-07-20T13:56:58.873122  =


    2023-07-20T13:56:59.884383  /lava-11119597/1/../bin/lava-test-case
   =


  * baseline.bootrr.dwmmc_rockchip-sdmmc-probed: https://kernelci.org/test/=
case/id/64b93cd128dbdfe7368ace7f
        new failure (last pass: v6.1.38-cip1-13-ga3621452a4fc)

    2023-07-20T13:56:57.852150  	-w	P<8>[   18.912847] <LAVA_SIGNAL_TESTCAS=
E TEST_CASE_ID=3Ddwmmc_rockchip-driver-present RESULT=3Dpass>

    2023-07-20T13:56:57.854952  ad to last with leading zeros

    2023-07-20T13:56:57.857607  	-s SEP	String separator

    2023-07-20T13:56:57.861284  /lava-11119597/1/../bin/lava-test-case

    2023-07-20T13:56:57.867423  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.

    2023-07-20T13:56:57.867647  =


    2023-07-20T13:56:57.871832  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-07-20T13:56:57.872216  =


    2023-07-20T13:56:57.877169  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-07-20T13:56:57.879674  FIRST, INC default to 1.
 =

    ... (5 line(s) more)  =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/64b93cd128dbdfe7368ace82
        failing since 181 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-07-20T13:56:57.779378  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC)<8=
>[   18.843122] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-07-20T13:56:57.781209   multi-call binary.

    2023-07-20T13:56:57.781441  =


    2023-07-20T13:56:57.785856  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-07-20T13:56:57.786090  =


    2023-07-20T13:56:57.791175  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/64b93cd128dbdfe7368ace83
        failing since 181 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-07-20T13:56:57.760396  /lava-11119597/1/../bin/lava-test-case<8>[ =
  18.825622] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-probed RE=
SULT=3Dpass>

    2023-07-20T13:56:57.760464  =

   =

 =20

