Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA16C4332F
	for <webhook@archiver.kernel.org>; Wed, 13 Dec 2023 09:52:21 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web10.32783.1702461140348596321
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 13 Dec 2023 01:52:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=xder6HFv;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.180, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d3448937ddso7925095ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 13 Dec 2023 01:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702461139; x=1703065939; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rFtwN6dWMws/skVGHVBz0LRR59N0w6IcZiNv33qdIQ4=;
        b=xder6HFvWcuOHPgU1JzixBQ4iaLnqX2mU4OWX13kqqwhDHrGsVwO05Ncx9GarKvSVa
         6wP19sf2RqUr8V/EaoYrhoY5zfkpx1Mxx1cLmHeXUus79ZP2DawXgS4NENw/LlVEN1vV
         sWAnGIjZG5znmM1rjyAHM4NamgnVrX9o1/Sp4HxPaLZzo4iMD7lYU7YbMv720bxuqXpB
         8JT5TzH8/m1Lekg842l283QZgRyMscyCM08Ta/chyF98oDiXRjWA5LP3JvONwc9ZEJJR
         MS/aqu9kcqLzvEAaf/jCJMO1edRErZO8U/kuS0t9EFMT/OZVGnIQts7BDOY+Vj985Eqk
         Gy7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702461139; x=1703065939;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rFtwN6dWMws/skVGHVBz0LRR59N0w6IcZiNv33qdIQ4=;
        b=ZKIbvhgMNfylNZbLHsfxKdyrvJqOZfWLZonSbLpkCArUOprcypaF5Ylq7BmTJK8+kC
         cWEONclk9BOWPtt41kc8F7HQcRcmBt731R5mgTqind/5yLPJf/JOL1BWQomUvw2FaqGJ
         Kgn7jAq6A9sPoF0tt6oxQA2GyNQ52Ojp917NQSBmTaf0Oxni0dd3jwXIxu0XCmY9+ex3
         pFcqbJF/q8J3h1sk9oVBE6v+GAjeLJXXqHX+TMZ698t4No0hPGm1ayh6WWH6HdvJCoPc
         YWs4DBOVB3mSP0t8UHo8hTXaGBBs4Su493y/4Y2WUWdLhZMaoKNMUWxh9LZefnyiFfFJ
         ulpA==
X-Gm-Message-State: AOJu0YwZ8C9sgKQDlBdfbaL/6McgajdikArTbYZUr4uTwHyVbMjm6C+l
	RqbiIyt/nQPeyGaBaMMa2iB/2mS1bgUi3M5Wh49jjw==
X-Google-Smtp-Source: AGHT+IF92jMGVhbRzfAPoc11JHJVoTsMxHtS3FPSdSY/+qFqYmG6Ivzy6ajcgmsRLLJ44ehlL6jpCQ==
X-Received: by 2002:a17:902:e5d2:b0:1d3:41b6:6d7b with SMTP id u18-20020a170902e5d200b001d341b66d7bmr1282853plf.108.1702461138493;
        Wed, 13 Dec 2023 01:52:18 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a7-20020a170902b58700b001d0c41b1d03sm10166025pls.32.2023.12.13.01.52.17
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 01:52:17 -0800 (PST)
Message-ID: <65797ed1.170a0220.1746b.eac3@mx.google.com>
Date: Wed, 13 Dec 2023 01:52:17 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-77-g545d45774209f
Subject: cip-gitlab/ci/pavel/linux-test baseline: 72 runs,
 44 regressions (v5.10.201-cip41-77-g545d45774209f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Dec 2023 09:52:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14063

cip-gitlab/ci/pavel/linux-test baseline: 72 runs, 44 regressions (v5.10.201=
-cip41-77-g545d45774209f)

Regressions Summary
-------------------

platform                     | arch  | lab             | compiler | defconf=
ig           | regressions
-----------------------------+-------+-----------------+----------+--------=
-------------+------------
at91sam9g20ek                | arm   | lab-broonie     | gcc-10   | at91_dt=
_defconfig   | 3          =

beaglebone-black             | arm   | lab-broonie     | gcc-10   | multi_v=
7_defconfig  | 7          =

beaglebone-black             | arm   | lab-broonie     | gcc-10   | omap2pl=
us_defconfig | 1          =

beaglebone-black             | arm   | lab-cip         | gcc-10   | omap2pl=
us_defconfig | 1          =

imx6dl-udoo                  | arm   | lab-broonie     | gcc-10   | multi_v=
7_defconfig  | 1          =

imx6q-udoo                   | arm   | lab-broonie     | gcc-10   | multi_v=
7_defconfig  | 1          =

imx6qp-wandboard-revd1       | arm   | lab-pengutronix | gcc-10   | imx_v6_=
v7_defconfig | 1          =

imx6qp-wandboard-revd1       | arm   | lab-pengutronix | gcc-10   | multi_v=
7_defconfig  | 1          =

juno-uboot                   | arm64 | lab-broonie     | gcc-10   | defconf=
ig           | 10         =

kontron-kbox-a-230-ls        | arm64 | lab-kontron     | gcc-10   | defconf=
ig           | 3          =

kontron-sl28-var3-ads2       | arm64 | lab-kontron     | gcc-10   | defconf=
ig           | 3          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie     | gcc-10   | defconf=
ig           | 1          =

qemu_mips-malta              | mips  | lab-broonie     | gcc-10   | malta_d=
efconfig     | 1          =

qemu_mips-malta              | mips  | lab-collabora   | gcc-10   | malta_d=
efconfig     | 1          =

rk3288-veyron-jaq            | arm   | lab-collabora   | gcc-10   | multi_v=
7_defconfig  | 3          =

sun50i-a64-pine64-plus       | arm64 | lab-broonie     | gcc-10   | defconf=
ig           | 5          =

zynqmp-zcu102                | arm64 | lab-cip         | gcc-10   | defconf=
ig           | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.201-cip41-77-g545d45774209f/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.201-cip41-77-g545d45774209f
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      545d45774209f8cd48179f8431020b19faaeef38 =



Test Regressions
---------------- =



platform                     | arch  | lab             | compiler | defconf=
ig           | regressions
-----------------------------+-------+-----------------+----------+--------=
-------------+------------
at91sam9g20ek                | arm   | lab-broonie     | gcc-10   | at91_dt=
_defconfig   | 3          =


  Details:     https://kernelci.org/test/plan/id/6579764743c4095708e13481

  Results:     49 PASS, 4 FAIL, 1 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-77-g545d45774209f/arm/at91_dt_defconfig/gcc-10/lab-broonie=
/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-77-g545d45774209f/arm/at91_dt_defconfig/gcc-10/lab-broonie=
/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.gpio-keys-probed: https://kernelci.org/test/case/id/657=
9764743c4095708e1348a
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:15:28.530252  /lava-348329/1/../bin/lava-test-case
    2023-12-13T09:15:28.567997  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dgpi=
o-keys-probed RESULT=3Dfail>   =


  * baseline.bootrr.wm8731-driver-present: https://kernelci.org/test/case/i=
d/6579764743c4095708e13495
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:15:24.334945  /lava-348329/1/../bin/lava-test-case
    2023-12-13T09:15:24.372724  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Deep=
rom-probed RESULT=3Dblocked>
    2023-12-13T09:15:24.414553  sh: /sys/bus/spi/drivers/wm8731: unknown op=
erand
    2023-12-13T09:15:25.428644  /lava-348329/1/../bin/lava-test-case
    2023-12-13T09:15:25.466988  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dwm8=
731-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.at24-driver-present: https://kernelci.org/test/case/id/=
6579764743c4095708e13496
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:15:23.233216  /lava-348329/1/../bin/lava-test-case
    2023-12-13T09:15:23.272018  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dat2=
4-driver-present RESULT=3Dfail>   =

 =



platform                     | arch  | lab             | compiler | defconf=
ig           | regressions
-----------------------------+-------+-----------------+----------+--------=
-------------+------------
beaglebone-black             | arm   | lab-broonie     | gcc-10   | multi_v=
7_defconfig  | 7          =


  Details:     https://kernelci.org/test/plan/id/6579784dc5060b73bae13475

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-77-g545d45774209f/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-77-g545d45774209f/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/6579784dc5060b73bae13486
        failing since 7 days (last pass: v6.1.62-cip9-12-g3a5321f469b07, fi=
rst fail: v5.10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:24:03.861524  /lava-348461/1/../bin/lava-test-case
    2023-12-13T09:24:03.893535  <8>[   28.628576] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6579784dc5060b73bae1349f
        failing since 7 days (last pass: v6.1.62-cip9-12-g3a5321f469b07, fi=
rst fail: v5.10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:23:58.107381  <8>[   22.844602] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 348461_1.5.2.4.1>
    2023-12-13T09:23:58.215143  / # #
    2023-12-13T09:23:58.317539  export SHELL=3D/bin/sh
    2023-12-13T09:23:58.318028  #
    2023-12-13T09:23:58.419152  / # export SHELL=3D/bin/sh. /lava-348461/en=
vironment
    2023-12-13T09:23:58.419657  =

    2023-12-13T09:23:58.520864  / # . /lava-348461/environment/lava-348461/=
bin/lava-test-runner /lava-348461/1
    2023-12-13T09:23:58.522027  =

    2023-12-13T09:23:58.525070  / # /lava-348461/bin/lava-test-runner /lava=
-348461/1
    2023-12-13T09:23:58.625242  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =


  * baseline.bootrr.hdmi-audio: https://kernelci.org/test/case/id/6579784dc=
5060b73bae134a0
        failing since 7 days (last pass: v6.1.62-cip9-12-g3a5321f469b07, fi=
rst fail: v5.10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:24:23.275477  /lava-348461/1/../bin/lava-test-case
    2023-12-13T09:24:23.310026  <8>[   48.047382] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/id/65=
79784dc5060b73bae134a1
        failing since 7 days (last pass: v6.1.62-cip9-12-g3a5321f469b07, fi=
rst fail: v5.10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:24:22.216164  /lava-348461/1/../bin/lava-test-case
    2023-12-13T09:24:22.250638  <8>[   46.987427] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-codec-driver-present: https://kernelci.org/test/ca=
se/id/6579784dc5060b73bae134a3
        failing since 7 days (last pass: v6.1.62-cip9-12-g3a5321f469b07, fi=
rst fail: v5.10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:24:20.047681  /lava-348461/1/../bin/lava-test-case
    2023-12-13T09:24:20.081602  <8>[   44.818425] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-12-13T09:24:21.108532  /lava-348461/1/../bin/lava-test-case
    2023-12-13T09:24:21.145019  <8>[   45.879083] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case/id/=
6579784dc5060b73bae134a4
        failing since 7 days (last pass: v6.1.62-cip9-12-g3a5321f469b07, fi=
rst fail: v5.10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:24:17.918875  /lava-348461/1/../bin/lava-test-case
    2023-12-13T09:24:17.958091  <8>[   42.694627] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-12-13T09:24:18.984934  /lava-348461/1/../bin/lava-test-case
    2023-12-13T09:24:19.020908  <8>[   43.757286] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline.bootrr.tda19988-driver-present: https://kernelci.org/test/case=
/id/6579784dc5060b73bae134a5
        failing since 7 days (last pass: v6.1.62-cip9-12-g3a5321f469b07, fi=
rst fail: v5.10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:24:15.795225  /lava-348461/1/../bin/lava-test-case
    2023-12-13T09:24:15.830014  <8>[   40.566835] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-12-13T09:24:16.856824  /lava-348461/1/../bin/lava-test-case
    2023-12-13T09:24:16.892029  <8>[   41.628004] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =

 =



platform                     | arch  | lab             | compiler | defconf=
ig           | regressions
-----------------------------+-------+-----------------+----------+--------=
-------------+------------
beaglebone-black             | arm   | lab-broonie     | gcc-10   | omap2pl=
us_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/657974e5c321503020e13480

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-77-g545d45774209f/arm/omap2plus_defconfig/gcc-10/lab-broon=
ie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-77-g545d45774209f/arm/omap2plus_defconfig/gcc-10/lab-broon=
ie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/id/6=
57974e5c321503020e1349f
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:09:45.325590  /lava-348305/1/../bin/lava-test-case
    2023-12-13T09:09:45.364551  <8>[   24.346560] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =

 =



platform                     | arch  | lab             | compiler | defconf=
ig           | regressions
-----------------------------+-------+-----------------+----------+--------=
-------------+------------
beaglebone-black             | arm   | lab-cip         | gcc-10   | omap2pl=
us_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/657977a3bf68cfd88ae13476

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-77-g545d45774209f/arm/omap2plus_defconfig/gcc-10/lab-cip/b=
aseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-77-g545d45774209f/arm/omap2plus_defconfig/gcc-10/lab-cip/b=
aseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/id/6=
57977a3bf68cfd88ae13495
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:21:28.134445  /lava-1058098/1/../bin/lava-test-case
    2023-12-13T09:21:28.169386  <8>[   18.025941] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =

 =



platform                     | arch  | lab             | compiler | defconf=
ig           | regressions
-----------------------------+-------+-----------------+----------+--------=
-------------+------------
imx6dl-udoo                  | arm   | lab-broonie     | gcc-10   | multi_v=
7_defconfig  | 1          =


  Details:     https://kernelci.org/test/plan/id/65797aa40702d97082e13475

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-77-g545d45774209f/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-77-g545d45774209f/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65797aa40702d97082e13=
476
        failing since 7 days (last pass: v6.1.62-cip9-12-g3a5321f469b07, fi=
rst fail: v5.10.201-cip41-16-g3c85fba3b6e5d) =

 =



platform                     | arch  | lab             | compiler | defconf=
ig           | regressions
-----------------------------+-------+-----------------+----------+--------=
-------------+------------
imx6q-udoo                   | arm   | lab-broonie     | gcc-10   | multi_v=
7_defconfig  | 1          =


  Details:     https://kernelci.org/test/plan/id/657979f1fee212ee90e1349d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-77-g545d45774209f/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-77-g545d45774209f/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/657979f1fee212ee90e13=
49e
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d) =

 =



platform                     | arch  | lab             | compiler | defconf=
ig           | regressions
-----------------------------+-------+-----------------+----------+--------=
-------------+------------
imx6qp-wandboard-revd1       | arm   | lab-pengutronix | gcc-10   | imx_v6_=
v7_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/657973d088a6b075d5e1347f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-77-g545d45774209f/arm/imx_v6_v7_defconfig/gcc-10/lab-pengu=
tronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-77-g545d45774209f/arm/imx_v6_v7_defconfig/gcc-10/lab-pengu=
tronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657973d088a6b075d5e13488
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:05:13.525830  + set +x
    2023-12-13T09:05:13.526171  [   10.325873] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1017127_1.5.2.3.1>
    2023-12-13T09:05:13.633250  / # #
    2023-12-13T09:05:13.734433  export SHELL=3D/bin/sh
    2023-12-13T09:05:13.734911  #
    2023-12-13T09:05:13.835723  / # export SHELL=3D/bin/sh. /lava-1017127/e=
nvironment
    2023-12-13T09:05:13.836215  =

    2023-12-13T09:05:13.936999  / # . /lava-1017127/environment/lava-101712=
7/bin/lava-test-runner /lava-1017127/1
    2023-12-13T09:05:13.937575  =

    2023-12-13T09:05:13.940283  / # /lava-1017127/bin/lava-test-runner /lav=
a-1017127/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch  | lab             | compiler | defconf=
ig           | regressions
-----------------------------+-------+-----------------+----------+--------=
-------------+------------
imx6qp-wandboard-revd1       | arm   | lab-pengutronix | gcc-10   | multi_v=
7_defconfig  | 1          =


  Details:     https://kernelci.org/test/plan/id/657977f435a75f8fa5e1348b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-77-g545d45774209f/arm/multi_v7_defconfig/gcc-10/lab-pengut=
ronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-77-g545d45774209f/arm/multi_v7_defconfig/gcc-10/lab-pengut=
ronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657977f435a75f8fa5e13494
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:22:52.941762  + set[    7.245558] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 1017129_1.5.2.3.1>
    2023-12-13T09:22:52.941941   +x
    2023-12-13T09:22:53.047128  / # #
    2023-12-13T09:22:53.148582  export SHELL=3D/bin/sh
    2023-12-13T09:22:53.149017  #
    2023-12-13T09:22:53.249892  / # export SHELL=3D/bin/sh. /lava-1017129/e=
nvironment
    2023-12-13T09:22:53.250528  =

    2023-12-13T09:22:53.351422  / # . /lava-1017129/environment/lava-101712=
9/bin/lava-test-runner /lava-1017129/1
    2023-12-13T09:22:53.351955  =

    2023-12-13T09:22:53.354953  / # /lava-1017129/bin/lava-test-runner /lav=
a-1017129/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch  | lab             | compiler | defconf=
ig           | regressions
-----------------------------+-------+-----------------+----------+--------=
-------------+------------
juno-uboot                   | arm64 | lab-broonie     | gcc-10   | defconf=
ig           | 10         =


  Details:     https://kernelci.org/test/plan/id/657978c730d357d0f0e134e0

  Results:     51 PASS, 10 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-77-g545d45774209f/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-77-g545d45774209f/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.iommu1-probed: https://kernelci.org/test/case/id/657978=
c730d357d0f0e134eb
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:26:04.599632  /lava-348346/1/../bin/lava-test-case
    2023-12-13T09:26:04.602870  <8>[   14.604323] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Diommu1-probed RESULT=3Dfail>   =


  * baseline.bootrr.1c050000_mmc-probed: https://kernelci.org/test/case/id/=
657978c730d357d0f0e134f8
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:26:03.246422  /lava-348346/1/../bin/lava-test-case
    2023-12-13T09:26:03.267397  <8>[   13.267985] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3D1c050000.mmc-probed RESULT=3Dfail>   =


  * baseline.bootrr.led7-probed: https://kernelci.org/test/case/id/657978c7=
30d357d0f0e1350b
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:26:13.256546  /lava-348346/1/../bin/lava-test-case
    2023-12-13T09:26:13.278526  <8>[   23.279125] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled7-probed RESULT=3Dfail>
    2023-12-13T09:26:13.279065  /lava-348346/1/../bin/lava-test-case   =


  * baseline.bootrr.led6-probed: https://kernelci.org/test/case/id/657978c7=
30d357d0f0e1350c
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:26:12.226812  /lava-348346/1/../bin/lava-test-case
    2023-12-13T09:26:12.249822  <8>[   22.249806] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled6-probed RESULT=3Dfail>   =


  * baseline.bootrr.led5-probed: https://kernelci.org/test/case/id/657978c7=
30d357d0f0e1350d
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:26:11.197106  /lava-348346/1/../bin/lava-test-case
    2023-12-13T09:26:11.220128  <8>[   21.220400] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled5-probed RESULT=3Dfail>   =


  * baseline.bootrr.led4-probed: https://kernelci.org/test/case/id/657978c7=
30d357d0f0e1350e
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:26:10.187159  /lava-348346/1/../bin/lava-test-case
    2023-12-13T09:26:10.190378  <8>[   20.191340] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled4-probed RESULT=3Dfail>   =


  * baseline.bootrr.led3-probed: https://kernelci.org/test/case/id/657978c7=
30d357d0f0e1350f
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:26:08.159940  <4>[   18.159949] psmouse serio1: Failed to=
 enable mouse on 1c070000.kmi
    2023-12-13T09:26:09.156535  /lava-348346/1/../bin/lava-test-case
    2023-12-13T09:26:09.159795  <8>[   19.161589] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled3-probed RESULT=3Dfail>   =


  * baseline.bootrr.led2-probed: https://kernelci.org/test/case/id/657978c7=
30d357d0f0e13510
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:26:08.040145  <6>[   18.034303] input: PS/2 Generic Mouse=
 as /devices/platform/bus@8000000/bus@8000000:motherboard-bus/bus@8000000:m=
otherboard-bus:iofpga-bus@300000000/1c070000.kmi/serio1/input/input4
    2023-12-13T09:26:08.125777  /lava-348346/1/../bin/lava-test-case
    2023-12-13T09:26:08.129026  <8>[   18.132458] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled2-probed RESULT=3Dfail>   =


  * baseline.bootrr.led1-probed: https://kernelci.org/test/case/id/657978c7=
30d357d0f0e13511
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:26:07.082096  /lava-348346/1/../bin/lava-test-case
    2023-12-13T09:26:07.103118  <8>[   17.103267] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled1-probed RESULT=3Dfail>   =


  * baseline.bootrr.led0-probed: https://kernelci.org/test/case/id/657978c7=
30d357d0f0e13512
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:26:06.054282  /lava-348346/1/../bin/lava-test-case
    2023-12-13T09:26:06.075269  <8>[   16.074573] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled0-probed RESULT=3Dfail>   =

 =



platform                     | arch  | lab             | compiler | defconf=
ig           | regressions
-----------------------------+-------+-----------------+----------+--------=
-------------+------------
kontron-kbox-a-230-ls        | arm64 | lab-kontron     | gcc-10   | defconf=
ig           | 3          =


  Details:     https://kernelci.org/test/plan/id/657976b813e5b70648e13485

  Results:     89 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-77-g545d45774209f/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-kontron-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-77-g545d45774209f/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-kontron-kbox-a-230-ls.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rcpm-driver-present: https://kernelci.org/test/case/id/=
657976b813e5b70648e134c9
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:17:34.187502  /lava-405335/1/../bin/lava-test-case
    2023-12-13T09:17:34.190733  <8>[   15.555091] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.ftm-alarm-driver-present: https://kernelci.org/test/cas=
e/id/657976b813e5b70648e134ca
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:17:35.205048  /lava-405335/1/../bin/lava-test-case
    2023-12-13T09:17:35.208322  <8>[   16.572556] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2023-12-13T09:17:36.228017  /lava-405335/1/../bin/lava-test-case   =


  * baseline.bootrr.layerscape-sfp-driver-present: https://kernelci.org/tes=
t/case/id/657976b913e5b70648e134e1
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:17:38.643215  /lava-405335/1/../bin/lava-test-case
    2023-12-13T09:17:38.646510  <8>[   20.005504] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =

 =



platform                     | arch  | lab             | compiler | defconf=
ig           | regressions
-----------------------------+-------+-----------------+----------+--------=
-------------+------------
kontron-sl28-var3-ads2       | arm64 | lab-kontron     | gcc-10   | defconf=
ig           | 3          =


  Details:     https://kernelci.org/test/plan/id/657976b773e862fde8e134a4

  Results:     97 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-77-g545d45774209f/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-kontron-sl28-var3-ads2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-77-g545d45774209f/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-kontron-sl28-var3-ads2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rcpm-driver-present: https://kernelci.org/test/case/id/=
657976b773e862fde8e134ef
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:17:28.789001  /lava-405332/1/../bin/lava-test-case
    2023-12-13T09:17:28.792320  <8>[   11.103479] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.ftm-alarm-driver-present: https://kernelci.org/test/cas=
e/id/657976b773e862fde8e134f0
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:17:29.801805  /lava-405332/1/../bin/lava-test-case
    2023-12-13T09:17:29.805102  <8>[   12.121432] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2023-12-13T09:17:30.824161  /lava-405332/1/../bin/lava-test-case   =


  * baseline.bootrr.layerscape-sfp-driver-present: https://kernelci.org/tes=
t/case/id/657976b773e862fde8e13505
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:17:33.249182  /lava-405332/1/../bin/lava-test-case
    2023-12-13T09:17:33.252523  <8>[   15.562753] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =

 =



platform                     | arch  | lab             | compiler | defconf=
ig           | regressions
-----------------------------+-------+-----------------+----------+--------=
-------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie     | gcc-10   | defconf=
ig           | 1          =


  Details:     https://kernelci.org/test/plan/id/657976ed6fd15b07d5e13497

  Results:     51 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-77-g545d45774209f/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-77-g545d45774209f/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/657976ed6=
fd15b07d5e1349e
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:18:27.994203  /lava-348354/1/../bin/lava-test-case
    2023-12-13T09:18:28.004215  <8>[   18.803331] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>   =

 =



platform                     | arch  | lab             | compiler | defconf=
ig           | regressions
-----------------------------+-------+-----------------+----------+--------=
-------------+------------
qemu_mips-malta              | mips  | lab-broonie     | gcc-10   | malta_d=
efconfig     | 1          =


  Details:     https://kernelci.org/test/plan/id/657971043bafbf3044e134a8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-77-g545d45774209f/mips/malta_defconfig/gcc-10/lab-broonie/=
baseline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-77-g545d45774209f/mips/malta_defconfig/gcc-10/lab-broonie/=
baseline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/657971043bafbf3044e13=
4a9
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d) =

 =



platform                     | arch  | lab             | compiler | defconf=
ig           | regressions
-----------------------------+-------+-----------------+----------+--------=
-------------+------------
qemu_mips-malta              | mips  | lab-collabora   | gcc-10   | malta_d=
efconfig     | 1          =


  Details:     https://kernelci.org/test/plan/id/657970f4dd7d350410e13485

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-77-g545d45774209f/mips/malta_defconfig/gcc-10/lab-collabor=
a/baseline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-77-g545d45774209f/mips/malta_defconfig/gcc-10/lab-collabor=
a/baseline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/657970f4dd7d350410e13=
486
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d) =

 =



platform                     | arch  | lab             | compiler | defconf=
ig           | regressions
-----------------------------+-------+-----------------+----------+--------=
-------------+------------
rk3288-veyron-jaq            | arm   | lab-collabora   | gcc-10   | multi_v=
7_defconfig  | 3          =


  Details:     https://kernelci.org/test/plan/id/6579780dfdf6979735e134a7

  Results:     63 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-77-g545d45774209f/arm/multi_v7_defconfig/gcc-10/lab-collab=
ora/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-77-g545d45774209f/arm/multi_v7_defconfig/gcc-10/lab-collab=
ora/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-iodomain-grf-probed: https://kernelci.org/test=
/case/id/6579780dfdf6979735e134c1
        failing since 7 days (last pass: v6.1.62-cip9-12-g3a5321f469b07, fi=
rst fail: v5.10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:30:51.951312  /lava-12258617/1/../bin/lava-test-case<8>[ =
  21.159972] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Drockchip-iodomain-driver-=
present RESULT=3Dpass>

    2023-12-13T09:30:51.951366  =


    2023-12-13T09:30:52.962118  /lava-12258617/1/../bin/lava-test-case
   =


  * baseline.bootrr.dwmmc_rockchip-sdio0-probed: https://kernelci.org/test/=
case/id/6579780dfdf6979735e134d7
        failing since 7 days (last pass: v6.1.62-cip9-12-g3a5321f469b07, fi=
rst fail: v5.10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:30:50.538623  /lava-12258617/1/../bin/lava-test-case<8>[ =
  19.747606] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwmmc_rockchip-sdmmc-prob=
ed RESULT=3Dfail>

    2023-12-13T09:30:50.538689  =


    2023-12-13T09:30:51.549938  /lava-12258617/1/../bin/lava-test-case
   =


  * baseline.bootrr.dwmmc_rockchip-sdmmc-probed: https://kernelci.org/test/=
case/id/6579780dfdf6979735e134d8
        failing since 7 days (last pass: v6.1.62-cip9-12-g3a5321f469b07, fi=
rst fail: v5.10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:30:49.520571  ad to last with leading zeros

    2023-12-13T09:30:49.523014  	-s SEP	String separator

    2023-12-13T09:30:49.527019  /lava-12258617/1/../bin/lava-test-case

    2023-12-13T09:30:49.532998  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.

    2023-12-13T09:30:49.533223  =


    2023-12-13T09:30:49.537551  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-12-13T09:30:49.537773  =


    2023-12-13T09:30:49.542764  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-12-13T09:30:49.545439  FIRST, INC default to 1.

    2023-12-13T09:30:49.545665  =

 =

    ... (4 line(s) more)  =

 =



platform                     | arch  | lab             | compiler | defconf=
ig           | regressions
-----------------------------+-------+-----------------+----------+--------=
-------------+------------
sun50i-a64-pine64-plus       | arm64 | lab-broonie     | gcc-10   | defconf=
ig           | 5          =


  Details:     https://kernelci.org/test/plan/id/657977176600aea3b7e13475

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-77-g545d45774209f/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-77-g545d45774209f/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/657977176=
600aea3b7e1348d
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:19:01.384106  /lava-348374/1/../bin/lava-test-case
    2023-12-13T09:19:01.394743  <8>[   25.508629] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Di2s-probed RESULT=3Dblocked>
    2023-12-13T09:19:02.420261  /lava-348374/1/../bin/lava-test-case
    2023-12-13T09:19:02.430275  <8>[   26.544465] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>   =


  * baseline.bootrr.sun4i-i2s-driver-present: https://kernelci.org/test/cas=
e/id/657977176600aea3b7e1348e
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:18:59.311888  /lava-348374/1/../bin/lava-test-case
    2023-12-13T09:18:59.323622  <8>[   23.436553] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcodec-digital-probed RESULT=3Dblocked>
    2023-12-13T09:19:00.347188  /lava-348374/1/../bin/lava-test-case
    2023-12-13T09:19:00.358958  <8>[   24.471950] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun4i-i2s-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sun8i-codec-driver-present: https://kernelci.org/test/c=
ase/id/657977176600aea3b7e1348f
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:18:57.238748  /lava-348374/1/../bin/lava-test-case
    2023-12-13T09:18:57.251337  <8>[   21.364032] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcodec-analog-probed RESULT=3Dblocked>
    2023-12-13T09:18:58.275163  /lava-348374/1/../bin/lava-test-case
    2023-12-13T09:18:58.287119  <8>[   22.399970] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8i-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sun50i-codec-analog-driver-present: https://kernelci.or=
g/test/case/id/657977176600aea3b7e13490
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:18:56.201916  /lava-348374/1/../bin/lava-test-case
    2023-12-13T09:18:56.213694  <8>[   20.326911] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun50i-codec-analog-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657977176600aea3b7e134a3
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:18:53.079707  <8>[   17.194475] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 348374_1.5.2.4.1>
    2023-12-13T09:18:53.190214  / # #
    2023-12-13T09:18:53.291865  export SHELL=3D/bin/sh
    2023-12-13T09:18:53.292411  #
    2023-12-13T09:18:53.393660  / # export SHELL=3D/bin/sh. /lava-348374/en=
vironment
    2023-12-13T09:18:53.394096  =

    2023-12-13T09:18:53.495439  / # . /lava-348374/environment/lava-348374/=
bin/lava-test-runner /lava-348374/1
    2023-12-13T09:18:53.496144  =

    2023-12-13T09:18:53.500072  / # /lava-348374/bin/lava-test-runner /lava=
-348374/1
    2023-12-13T09:18:53.542000  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab             | compiler | defconf=
ig           | regressions
-----------------------------+-------+-----------------+----------+--------=
-------------+------------
zynqmp-zcu102                | arm64 | lab-cip         | gcc-10   | defconf=
ig           | 1          =


  Details:     https://kernelci.org/test/plan/id/657977bf35a75f8fa5e13485

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-77-g545d45774209f/arm64/defconfig/gcc-10/lab-cip/baseline-=
zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-77-g545d45774209f/arm64/defconfig/gcc-10/lab-cip/baseline-=
zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/657977bf35a75f8fa5e13=
486
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d) =

 =20

