Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98151C4167B
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 22:45:01 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.web11.106034.1701989093164378196
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 07 Dec 2023 14:44:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=z/vlg3ob;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.171, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ce72730548so1102666b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 07 Dec 2023 14:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701989092; x=1702593892; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EjoSAcSgIc5lVZwywZnhRGxdRmHpu17C297/ZW/6IF0=;
        b=z/vlg3obEMcmFMd4DV6ULlsqar7WKjnF50XcELeqdFmpyO/gYJ9T+itALPMp2P9nfl
         KfQods7q3EsRlMMcN/ANpop5uC1TYjIUik1fhFt51vRsJVEkHrH8a9mLOlilrWYocOUL
         gjLzyZnKbrPiHHfPLLpZxnLENfmIBwY4QCYA5/cIucxTJuzX9B61hIcmTMlXtJy0H/1u
         HMPjQem4dkCfMLv81KmvL0tGq7VBe0ImlPj81ZNqtdn/QAvwPVPtHWAeQKF0NRTiJReP
         qlUQPhl70G2v/NQH/oL2UL6NJRQGEHlA3hQMSP2WqHZAEybLCca/V96vciiaf/inWQ79
         OdpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701989092; x=1702593892;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EjoSAcSgIc5lVZwywZnhRGxdRmHpu17C297/ZW/6IF0=;
        b=GcnB+kvXzKYIvMLTsgAfpdz04xZ9MBB5gqFz9i089RKVkLqatq8sEPLRX3ZpzJtXLk
         xOLFPBvAPBKkpAS7hmNMUV0sEMW6RGMZJM4sNerQI0n1CynGvYG9KUqBxSV2y4FquAkW
         qe+yLm6Wu4aBoSnXHu5PX4yH5BLeuYNF2ucDcNJFR/eA5Gl5ZTySke3AqwPYOGS1m2z7
         0BpX31vQaqPfpiVQWLc0jDGeFD37OdJjIxJQ6KO6V303zvEJfsx4xZ/7+HiquxkPmhiG
         gXljLFbyADbUti1aNWRKiqtX4iThFp55BBBrGn3ERDYxMOT4tP41aGcw+mztu41eXcF/
         vrqQ==
X-Gm-Message-State: AOJu0YxdJWyvysojDISMqf84QHEJz+lVdUDo6C7XKblLKTlBLXPinB5D
	ohX+keBS/AWG7ulioJuzaBn3jSlZlPLebpo+R5Vg8A==
X-Google-Smtp-Source: AGHT+IE2dNHD41jQUcdszJJGXXrefxuAlH/LMM7zK5P2U+B+mrLOOeVpDYzNGTbWYTFB0MWC6s3O0g==
X-Received: by 2002:a05:6a00:1256:b0:6ce:64c5:956e with SMTP id u22-20020a056a00125600b006ce64c5956emr3825274pfi.39.1701989091393;
        Thu, 07 Dec 2023 14:44:51 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p18-20020a056a000b5200b006ce939ebeacsm291879pfo.166.2023.12.07.14.44.49
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 14:44:49 -0800 (PST)
Message-ID: <65724ae1.050a0220.90bb5.19ef@mx.google.com>
Date: Thu, 07 Dec 2023 14:44:49 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-63-g2bc5a8583f4a8
Subject: cip-gitlab/ci/pavel/linux-test baseline: 66 runs,
 44 regressions (v5.10.201-cip41-63-g2bc5a8583f4a8)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 22:45:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13931

cip-gitlab/ci/pavel/linux-test baseline: 66 runs, 44 regressions (v5.10.201=
-cip41-63-g2bc5a8583f4a8)

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

r8a7743-iwg20d-q7            | arm   | lab-cip         | gcc-10   | shmobil=
e_defconfig  | 1          =

rk3288-veyron-jaq            | arm   | lab-collabora   | gcc-10   | multi_v=
7_defconfig  | 3          =

sun50i-a64-pine64-plus       | arm64 | lab-broonie     | gcc-10   | defconf=
ig           | 5          =

zynqmp-zcu102                | arm64 | lab-cip         | gcc-10   | defconf=
ig           | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.201-cip41-63-g2bc5a8583f4a8/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.201-cip41-63-g2bc5a8583f4a8
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      2bc5a8583f4a8a28f328fe05c444332335079a44 =



Test Regressions
---------------- =



platform                     | arch  | lab             | compiler | defconf=
ig           | regressions
-----------------------------+-------+-----------------+----------+--------=
-------------+------------
at91sam9g20ek                | arm   | lab-broonie     | gcc-10   | at91_dt=
_defconfig   | 3          =


  Details:     https://kernelci.org/test/plan/id/6572407c95fa81a01de13485

  Results:     49 PASS, 4 FAIL, 1 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-g2bc5a8583f4a8/arm/at91_dt_defconfig/gcc-10/lab-broonie=
/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-g2bc5a8583f4a8/arm/at91_dt_defconfig/gcc-10/lab-broonie=
/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.gpio-keys-probed: https://kernelci.org/test/case/id/657=
2407c95fa81a01de1348e
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T22:00:14.039401  /lava-320229/1/../bin/lava-test-case
    2023-12-07T22:00:14.077446  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dgpi=
o-keys-probed RESULT=3Dfail>   =


  * baseline.bootrr.wm8731-driver-present: https://kernelci.org/test/case/i=
d/6572407c95fa81a01de13499
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T22:00:09.836276  /lava-320229/1/../bin/lava-test-case
    2023-12-07T22:00:09.875144  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Deep=
rom-probed RESULT=3Dblocked>
    2023-12-07T22:00:09.917832  sh: /sys/bus/spi/drivers/wm8731: unknown op=
erand
    2023-12-07T22:00:10.937953  /lava-320229/1/../bin/lava-test-case
    2023-12-07T22:00:10.976849  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dwm8=
731-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.at24-driver-present: https://kernelci.org/test/case/id/=
6572407c95fa81a01de1349a
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T22:00:08.734780  /lava-320229/1/../bin/lava-test-case
    2023-12-07T22:00:08.773963  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dat2=
4-driver-present RESULT=3Dfail>   =

 =



platform                     | arch  | lab             | compiler | defconf=
ig           | regressions
-----------------------------+-------+-----------------+----------+--------=
-------------+------------
beaglebone-black             | arm   | lab-broonie     | gcc-10   | multi_v=
7_defconfig  | 7          =


  Details:     https://kernelci.org/test/plan/id/6572403b6c608949fce1348e

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-g2bc5a8583f4a8/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-g2bc5a8583f4a8/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.hdmi-audio: https://kernelci.org/test/case/id/6572403b6=
c608949fce13495
        failing since 1 day (last pass: v6.1.62-cip9-12-g3a5321f469b07, fir=
st fail: v5.10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T21:59:01.519796  /lava-320231/1/../bin/lava-test-case
    2023-12-07T21:59:01.554427  <8>[   53.163425] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/id/65=
72403b6c608949fce13496
        failing since 1 day (last pass: v6.1.62-cip9-12-g3a5321f469b07, fir=
st fail: v5.10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T21:59:00.459348  /lava-320231/1/../bin/lava-test-case
    2023-12-07T21:59:00.494077  <8>[   52.102082] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-codec-driver-present: https://kernelci.org/test/ca=
se/id/6572403b6c608949fce13498
        failing since 1 day (last pass: v6.1.62-cip9-12-g3a5321f469b07, fir=
st fail: v5.10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T21:58:58.290004  /lava-320231/1/../bin/lava-test-case
    2023-12-07T21:58:58.324065  <8>[   49.932425] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-12-07T21:58:59.351691  /lava-320231/1/../bin/lava-test-case
    2023-12-07T21:58:59.387967  <8>[   50.993564] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case/id/=
6572403b6c608949fce13499
        failing since 1 day (last pass: v6.1.62-cip9-12-g3a5321f469b07, fir=
st fail: v5.10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T21:58:56.163130  /lava-320231/1/../bin/lava-test-case
    2023-12-07T21:58:56.201737  <8>[   47.809245] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-12-07T21:58:57.227703  /lava-320231/1/../bin/lava-test-case
    2023-12-07T21:58:57.263167  <8>[   48.871104] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline.bootrr.tda19988-driver-present: https://kernelci.org/test/case=
/id/6572403b6c608949fce1349a
        failing since 1 day (last pass: v6.1.62-cip9-12-g3a5321f469b07, fir=
st fail: v5.10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T21:58:54.041867  /lava-320231/1/../bin/lava-test-case
    2023-12-07T21:58:54.075085  <8>[   45.683503] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-12-07T21:58:55.102278  /lava-320231/1/../bin/lava-test-case
    2023-12-07T21:58:55.136164  <8>[   46.743788] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/6572403b6c608949fce134a6
        failing since 1 day (last pass: v6.1.62-cip9-12-g3a5321f469b07, fir=
st fail: v5.10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T21:58:42.101251  /lava-320231/1/../bin/lava-test-case
    2023-12-07T21:58:42.136439  <8>[   33.743465] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6572403b6c608949fce134bf
        failing since 1 day (last pass: v6.1.62-cip9-12-g3a5321f469b07, fir=
st fail: v5.10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T21:58:36.363369  <8>[   27.971064] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 320231_1.5.2.4.1>
    2023-12-07T21:58:36.470269  / # #
    2023-12-07T21:58:36.572032  export SHELL=3D/bin/sh
    2023-12-07T21:58:36.572457  #
    2023-12-07T21:58:36.673632  / # export SHELL=3D/bin/sh. /lava-320231/en=
vironment
    2023-12-07T21:58:36.674071  =

    2023-12-07T21:58:36.775272  / # . /lava-320231/environment/lava-320231/=
bin/lava-test-runner /lava-320231/1
    2023-12-07T21:58:36.776018  =

    2023-12-07T21:58:36.780576  / # /lava-320231/bin/lava-test-runner /lava=
-320231/1
    2023-12-07T21:58:36.876593  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab             | compiler | defconf=
ig           | regressions
-----------------------------+-------+-----------------+----------+--------=
-------------+------------
beaglebone-black             | arm   | lab-broonie     | gcc-10   | omap2pl=
us_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/65723f900706bfe3c2e13479

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-g2bc5a8583f4a8/arm/omap2plus_defconfig/gcc-10/lab-broon=
ie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-g2bc5a8583f4a8/arm/omap2plus_defconfig/gcc-10/lab-broon=
ie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/id/6=
5723f900706bfe3c2e13494
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T21:56:08.266735  /lava-320218/1/../bin/lava-test-case
    2023-12-07T21:56:08.305655  <8>[   24.198005] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =

 =



platform                     | arch  | lab             | compiler | defconf=
ig           | regressions
-----------------------------+-------+-----------------+----------+--------=
-------------+------------
beaglebone-black             | arm   | lab-cip         | gcc-10   | omap2pl=
us_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6572490c7c36ea9b6ee134c2

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-g2bc5a8583f4a8/arm/omap2plus_defconfig/gcc-10/lab-cip/b=
aseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-g2bc5a8583f4a8/arm/omap2plus_defconfig/gcc-10/lab-cip/b=
aseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/id/6=
572490c7c36ea9b6ee134de
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T22:36:48.311891  /lava-1053691/1/../bin/lava-test-case
    2023-12-07T22:36:48.354242  <8>[   16.979260] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =

 =



platform                     | arch  | lab             | compiler | defconf=
ig           | regressions
-----------------------------+-------+-----------------+----------+--------=
-------------+------------
imx6q-udoo                   | arm   | lab-broonie     | gcc-10   | multi_v=
7_defconfig  | 1          =


  Details:     https://kernelci.org/test/plan/id/6572423b4052d8dd8de13482

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-g2bc5a8583f4a8/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-g2bc5a8583f4a8/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6572423b4052d8dd8de13=
483
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d) =

 =



platform                     | arch  | lab             | compiler | defconf=
ig           | regressions
-----------------------------+-------+-----------------+----------+--------=
-------------+------------
imx6qp-wandboard-revd1       | arm   | lab-pengutronix | gcc-10   | imx_v6_=
v7_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6572401f787f98da79e1348f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-g2bc5a8583f4a8/arm/imx_v6_v7_defconfig/gcc-10/lab-pengu=
tronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-g2bc5a8583f4a8/arm/imx_v6_v7_defconfig/gcc-10/lab-pengu=
tronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6572401f787f98da79e13498
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T21:58:46.544113  + set +x
    2023-12-07T21:58:46.544256  [   10.354580] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1015428_1.5.2.3.1>
    2023-12-07T21:58:46.651653  / # #
    2023-12-07T21:58:46.752765  export SHELL=3D/bin/sh
    2023-12-07T21:58:46.753229  #
    2023-12-07T21:58:46.853995  / # export SHELL=3D/bin/sh. /lava-1015428/e=
nvironment
    2023-12-07T21:58:46.854417  =

    2023-12-07T21:58:46.955269  / # . /lava-1015428/environment/lava-101542=
8/bin/lava-test-runner /lava-1015428/1
    2023-12-07T21:58:46.955917  =

    2023-12-07T21:58:46.958506  / # /lava-1015428/bin/lava-test-runner /lav=
a-1015428/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch  | lab             | compiler | defconf=
ig           | regressions
-----------------------------+-------+-----------------+----------+--------=
-------------+------------
imx6qp-wandboard-revd1       | arm   | lab-pengutronix | gcc-10   | multi_v=
7_defconfig  | 1          =


  Details:     https://kernelci.org/test/plan/id/65723f6aa78556e107e1348b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-g2bc5a8583f4a8/arm/multi_v7_defconfig/gcc-10/lab-pengut=
ronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-g2bc5a8583f4a8/arm/multi_v7_defconfig/gcc-10/lab-pengut=
ronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65723f6aa78556e107e13494
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T21:55:46.336982  + set[    7.379697] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 1015425_1.5.2.3.1>
    2023-12-07T21:55:46.337141   +x
    2023-12-07T21:55:46.442410  / # #
    2023-12-07T21:55:46.543519  export SHELL=3D/bin/sh
    2023-12-07T21:55:46.543991  #
    2023-12-07T21:55:46.644894  / # export SHELL=3D/bin/sh. /lava-1015425/e=
nvironment
    2023-12-07T21:55:46.645351  =

    2023-12-07T21:55:46.746144  / # . /lava-1015425/environment/lava-101542=
5/bin/lava-test-runner /lava-1015425/1
    2023-12-07T21:55:46.746736  =

    2023-12-07T21:55:46.749000  / # /lava-1015425/bin/lava-test-runner /lav=
a-1015425/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch  | lab             | compiler | defconf=
ig           | regressions
-----------------------------+-------+-----------------+----------+--------=
-------------+------------
juno-uboot                   | arm64 | lab-broonie     | gcc-10   | defconf=
ig           | 10         =


  Details:     https://kernelci.org/test/plan/id/657241e57581d9d0bfe1348a

  Results:     51 PASS, 10 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-g2bc5a8583f4a8/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-g2bc5a8583f4a8/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.led7-probed: https://kernelci.org/test/case/id/657241e6=
7581d9d0bfe1349b
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T22:06:09.327832  /lava-320278/1/../bin/lava-test-case
    2023-12-07T22:06:09.349840  <8>[   23.531538] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled7-probed RESULT=3Dfail>
    2023-12-07T22:06:09.350402  /lava-320278/1/../bin/lava-test-case   =


  * baseline.bootrr.led6-probed: https://kernelci.org/test/case/id/657241e6=
7581d9d0bfe1349c
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T22:06:08.298533  /lava-320278/1/../bin/lava-test-case
    2023-12-07T22:06:08.320460  <8>[   22.501993] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled6-probed RESULT=3Dfail>   =


  * baseline.bootrr.led5-probed: https://kernelci.org/test/case/id/657241e6=
7581d9d0bfe1349d
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T22:06:07.268977  /lava-320278/1/../bin/lava-test-case
    2023-12-07T22:06:07.291949  <8>[   21.472949] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled5-probed RESULT=3Dfail>   =


  * baseline.bootrr.led4-probed: https://kernelci.org/test/case/id/657241e6=
7581d9d0bfe1349e
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T22:06:06.238052  /lava-320278/1/../bin/lava-test-case
    2023-12-07T22:06:06.262064  <8>[   20.443542] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled4-probed RESULT=3Dfail>   =


  * baseline.bootrr.led3-probed: https://kernelci.org/test/case/id/657241e6=
7581d9d0bfe1349f
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T22:06:05.227956  /lava-320278/1/../bin/lava-test-case
    2023-12-07T22:06:05.231273  <8>[   19.414533] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled3-probed RESULT=3Dfail>   =


  * baseline.bootrr.led2-probed: https://kernelci.org/test/case/id/657241e6=
7581d9d0bfe134a0
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T22:06:03.866777  <6>[   18.037496] input: PS/2 Generic Mouse=
 as /devices/platform/bus@8000000/bus@8000000:motherboard-bus/bus@8000000:m=
otherboard-bus:iofpga-bus@300000000/1c070000.kmi/serio1/input/input4
    2023-12-07T22:06:03.978518  <4>[   18.163191] psmouse serio1: Failed to=
 enable mouse on 1c070000.kmi
    2023-12-07T22:06:04.197175  /lava-320278/1/../bin/lava-test-case
    2023-12-07T22:06:04.200429  <8>[   18.385243] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled2-probed RESULT=3Dfail>   =


  * baseline.bootrr.led1-probed: https://kernelci.org/test/case/id/657241e6=
7581d9d0bfe134a1
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T22:06:03.150493  /lava-320278/1/../bin/lava-test-case
    2023-12-07T22:06:03.174469  <8>[   17.355944] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled1-probed RESULT=3Dfail>   =


  * baseline.bootrr.led0-probed: https://kernelci.org/test/case/id/657241e6=
7581d9d0bfe134a2
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T22:06:02.140271  /lava-320278/1/../bin/lava-test-case
    2023-12-07T22:06:02.143528  <8>[   16.327109] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled0-probed RESULT=3Dfail>   =


  * baseline.bootrr.iommu1-probed: https://kernelci.org/test/case/id/657241=
e67581d9d0bfe134b3
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T22:06:00.666947  /lava-320278/1/../bin/lava-test-case
    2023-12-07T22:06:00.670195  <8>[   14.852859] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Diommu1-probed RESULT=3Dfail>   =


  * baseline.bootrr.1c050000_mmc-probed: https://kernelci.org/test/case/id/=
657241e67581d9d0bfe134c0
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T22:05:59.314620  /lava-320278/1/../bin/lava-test-case
    2023-12-07T22:05:59.335651  <8>[   13.516510] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3D1c050000.mmc-probed RESULT=3Dfail>   =

 =



platform                     | arch  | lab             | compiler | defconf=
ig           | regressions
-----------------------------+-------+-----------------+----------+--------=
-------------+------------
kontron-kbox-a-230-ls        | arm64 | lab-kontron     | gcc-10   | defconf=
ig           | 3          =


  Details:     https://kernelci.org/test/plan/id/65724093142270c507e134ad

  Results:     89 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-g2bc5a8583f4a8/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-kontron-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-g2bc5a8583f4a8/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-kontron-kbox-a-230-ls.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rcpm-driver-present: https://kernelci.org/test/case/id/=
65724093142270c507e134ed
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T22:00:25.792697  /lava-403054/1/../bin/lava-test-case
    2023-12-07T22:00:25.795993  <8>[   14.515906] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.ftm-alarm-driver-present: https://kernelci.org/test/cas=
e/id/65724093142270c507e134ee
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T22:00:26.806167  /lava-403054/1/../bin/lava-test-case
    2023-12-07T22:00:26.809384  <8>[   15.534753] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2023-12-07T22:00:27.828425  /lava-403054/1/../bin/lava-test-case   =


  * baseline.bootrr.layerscape-sfp-driver-present: https://kernelci.org/tes=
t/case/id/65724093142270c507e13505
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T22:00:30.243104  /lava-403054/1/../bin/lava-test-case
    2023-12-07T22:00:30.246423  <8>[   18.966918] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =

 =



platform                     | arch  | lab             | compiler | defconf=
ig           | regressions
-----------------------------+-------+-----------------+----------+--------=
-------------+------------
kontron-sl28-var3-ads2       | arm64 | lab-kontron     | gcc-10   | defconf=
ig           | 3          =


  Details:     https://kernelci.org/test/plan/id/6572408f95fa81a01de13533

  Results:     97 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-g2bc5a8583f4a8/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-kontron-sl28-var3-ads2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-g2bc5a8583f4a8/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-kontron-sl28-var3-ads2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rcpm-driver-present: https://kernelci.org/test/case/id/=
6572408f95fa81a01de1357a
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T22:00:34.438651  /lava-403053/1/../bin/lava-test-case
    2023-12-07T22:00:34.441891  <8>[   11.090700] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.ftm-alarm-driver-present: https://kernelci.org/test/cas=
e/id/6572408f95fa81a01de1357b
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T22:00:35.452317  /lava-403053/1/../bin/lava-test-case
    2023-12-07T22:00:35.455592  <8>[   12.108924] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2023-12-07T22:00:36.474514  /lava-403053/1/../bin/lava-test-case   =


  * baseline.bootrr.layerscape-sfp-driver-present: https://kernelci.org/tes=
t/case/id/6572408f95fa81a01de13590
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T22:00:38.897975  /lava-403053/1/../bin/lava-test-case
    2023-12-07T22:00:38.901264  <8>[   15.549556] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =

 =



platform                     | arch  | lab             | compiler | defconf=
ig           | regressions
-----------------------------+-------+-----------------+----------+--------=
-------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie     | gcc-10   | defconf=
ig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65724179b7257f2fa4e1362d

  Results:     51 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-g2bc5a8583f4a8/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-g2bc5a8583f4a8/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/65724179b=
7257f2fa4e13634
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T22:04:20.350983  /lava-320320/1/../bin/lava-test-case
    2023-12-07T22:04:20.361144  <8>[   18.828173] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>   =

 =



platform                     | arch  | lab             | compiler | defconf=
ig           | regressions
-----------------------------+-------+-----------------+----------+--------=
-------------+------------
qemu_mips-malta              | mips  | lab-broonie     | gcc-10   | malta_d=
efconfig     | 1          =


  Details:     https://kernelci.org/test/plan/id/65724296fa6fe22542e1350e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-g2bc5a8583f4a8/mips/malta_defconfig/gcc-10/lab-broonie/=
baseline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-g2bc5a8583f4a8/mips/malta_defconfig/gcc-10/lab-broonie/=
baseline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65724296fa6fe22542e13=
50f
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d) =

 =



platform                     | arch  | lab             | compiler | defconf=
ig           | regressions
-----------------------------+-------+-----------------+----------+--------=
-------------+------------
qemu_mips-malta              | mips  | lab-collabora   | gcc-10   | malta_d=
efconfig     | 1          =


  Details:     https://kernelci.org/test/plan/id/65724289221b78bc48e13477

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-g2bc5a8583f4a8/mips/malta_defconfig/gcc-10/lab-collabor=
a/baseline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-g2bc5a8583f4a8/mips/malta_defconfig/gcc-10/lab-collabor=
a/baseline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65724289221b78bc48e13=
478
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d) =

 =



platform                     | arch  | lab             | compiler | defconf=
ig           | regressions
-----------------------------+-------+-----------------+----------+--------=
-------------+------------
r8a7743-iwg20d-q7            | arm   | lab-cip         | gcc-10   | shmobil=
e_defconfig  | 1          =


  Details:     https://kernelci.org/test/plan/id/657242c56aa56382e2e13475

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-g2bc5a8583f4a8/arm/shmobile_defconfig/gcc-10/lab-cip/ba=
seline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-g2bc5a8583f4a8/arm/shmobile_defconfig/gcc-10/lab-cip/ba=
seline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/657242c56aa56382e2e13=
476
        failing since 3 days (last pass: v6.1.62-cip9-12-g3a5321f469b07, fi=
rst fail: v6.1.64-cip10-rt5) =

 =



platform                     | arch  | lab             | compiler | defconf=
ig           | regressions
-----------------------------+-------+-----------------+----------+--------=
-------------+------------
rk3288-veyron-jaq            | arm   | lab-collabora   | gcc-10   | multi_v=
7_defconfig  | 3          =


  Details:     https://kernelci.org/test/plan/id/65723f74a78556e107e134b2

  Results:     63 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-g2bc5a8583f4a8/arm/multi_v7_defconfig/gcc-10/lab-collab=
ora/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-g2bc5a8583f4a8/arm/multi_v7_defconfig/gcc-10/lab-collab=
ora/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-iodomain-grf-probed: https://kernelci.org/test=
/case/id/65723f74a78556e107e134cc
        failing since 1 day (last pass: v6.1.62-cip9-12-g3a5321f469b07, fir=
st fail: v5.10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T22:03:33.018451  <8>[   20.947088] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-iodomain-driver-present RESULT=3Dpass>

    2023-12-07T22:03:34.029888  /lava-12210761/1/../bin/lava-test-case

    2023-12-07T22:03:34.038626  <8>[   21.968158] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-iodomain-grf-probed RESULT=3Dfail>
   =


  * baseline.bootrr.dwmmc_rockchip-sdio0-probed: https://kernelci.org/test/=
case/id/65723f74a78556e107e134e2
        failing since 1 day (last pass: v6.1.62-cip9-12-g3a5321f469b07, fir=
st fail: v5.10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T22:03:31.603523  <8>[   19.532737] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwmmc_rockchip-sdmmc-probed RESULT=3Dfail>

    2023-12-07T22:03:32.615453  /lava-12210761/1/../bin/lava-test-case

    2023-12-07T22:03:32.624131  <8>[   20.553604] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwmmc_rockchip-sdio0-probed RESULT=3Dfail>
   =


  * baseline.bootrr.dwmmc_rockchip-sdmmc-probed: https://kernelci.org/test/=
case/id/65723f74a78556e107e134e3
        failing since 1 day (last pass: v6.1.62-cip9-12-g3a5321f469b07, fir=
st fail: v5.10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T22:03:30.582673  	-w	P<8>[   18.508103] <LAVA_SIGNAL_TESTCAS=
E TEST_CASE_ID=3Ddwmmc_rockchip-driver-present RESULT=3Dpass>

    2023-12-07T22:03:30.587494  ad to last with leading zeros

    2023-12-07T22:03:30.589831  	-s SEP	String separator

    2023-12-07T22:03:30.593710  /lava-12210761/1/../bin/lava-test-case

    2023-12-07T22:03:30.599777  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.

    2023-12-07T22:03:30.599836  =


    2023-12-07T22:03:30.604802  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-12-07T22:03:30.605480  =


    2023-12-07T22:03:30.609608  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-12-07T22:03:30.612198  FIRST, INC default to 1.
 =

    ... (6 line(s) more)  =

 =



platform                     | arch  | lab             | compiler | defconf=
ig           | regressions
-----------------------------+-------+-----------------+----------+--------=
-------------+------------
sun50i-a64-pine64-plus       | arm64 | lab-broonie     | gcc-10   | defconf=
ig           | 5          =


  Details:     https://kernelci.org/test/plan/id/6572412def8dd8916fe135d0

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-g2bc5a8583f4a8/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-g2bc5a8583f4a8/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/6572412de=
f8dd8916fe135e7
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T22:02:59.887651  /lava-320295/1/../bin/lava-test-case
    2023-12-07T22:02:59.898450  <8>[   25.362740] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Di2s-probed RESULT=3Dblocked>
    2023-12-07T22:03:00.923187  /lava-320295/1/../bin/lava-test-case
    2023-12-07T22:03:00.933550  <8>[   26.398028] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>   =


  * baseline.bootrr.sun4i-i2s-driver-present: https://kernelci.org/test/cas=
e/id/6572412def8dd8916fe135e8
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T22:02:57.824091  /lava-320295/1/../bin/lava-test-case
    2023-12-07T22:02:57.835576  <8>[   23.299046] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcodec-digital-probed RESULT=3Dblocked>
    2023-12-07T22:02:58.858853  /lava-320295/1/../bin/lava-test-case
    2023-12-07T22:02:58.870467  <8>[   24.333853] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun4i-i2s-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sun8i-codec-driver-present: https://kernelci.org/test/c=
ase/id/6572412def8dd8916fe135e9
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T22:02:55.750633  /lava-320295/1/../bin/lava-test-case
    2023-12-07T22:02:55.762065  <8>[   21.225691] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcodec-analog-probed RESULT=3Dblocked>
    2023-12-07T22:02:56.787668  /lava-320295/1/../bin/lava-test-case
    2023-12-07T22:02:56.799611  <8>[   22.262790] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8i-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sun50i-codec-analog-driver-present: https://kernelci.or=
g/test/case/id/6572412def8dd8916fe135eb
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T22:02:54.714480  /lava-320295/1/../bin/lava-test-case
    2023-12-07T22:02:54.728112  <8>[   20.190827] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun50i-codec-analog-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6572412def8dd8916fe135fe
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T22:02:51.562307  <8>[   17.027772] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 320295_1.5.2.4.1>
    2023-12-07T22:02:51.671852  / # #
    2023-12-07T22:02:51.773430  export SHELL=3D/bin/sh
    2023-12-07T22:02:51.773767  #
    2023-12-07T22:02:51.874955  / # export SHELL=3D/bin/sh. /lava-320295/en=
vironment
    2023-12-07T22:02:51.875403  =

    2023-12-07T22:02:51.977262  / # . /lava-320295/environment/lava-320295/=
bin/lava-test-runner /lava-320295/1
    2023-12-07T22:02:51.978121  =

    2023-12-07T22:02:51.982460  / # /lava-320295/bin/lava-test-runner /lava=
-320295/1
    2023-12-07T22:02:52.026389  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab             | compiler | defconf=
ig           | regressions
-----------------------------+-------+-----------------+----------+--------=
-------------+------------
zynqmp-zcu102                | arm64 | lab-cip         | gcc-10   | defconf=
ig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6572419eb7257f2fa4e13689

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-g2bc5a8583f4a8/arm64/defconfig/gcc-10/lab-cip/baseline-=
zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-g2bc5a8583f4a8/arm64/defconfig/gcc-10/lab-cip/baseline-=
zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6572419eb7257f2fa4e13=
68a
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d) =

 =20

