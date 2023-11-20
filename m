Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A36DC54E76
	for <webhook@archiver.kernel.org>; Mon, 20 Nov 2023 10:51:49 +0000 (UTC)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
 by mx.groups.io with SMTP id smtpd.web10.47741.1700477506013879165
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 20 Nov 2023 02:51:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=YWddaG5/;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.173, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6b20a48522fso3341439b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 20 Nov 2023 02:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700477505; x=1701082305; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GoFieG/IuF1414lZw2Sgkyh6AlX1/CL3qBCeIx9HmeQ=;
        b=YWddaG5/5IYHWdQKldbxo6x4gfewylc2Ahs2U8wHYPlGo6+Ymj8DDesoI6Z867U0bN
         GOeIfMJfPoUn5PQwS+MsuvzNpe2hvZSdsEZEye27eRUqx6z/RVn7Td9z4fRfBikd5mI2
         MJarRGAMLvYRMakaey3iTXGS7hqYjROOic6vzTKIj8nDoZh5m+/VMPbqmzF2NI9qpMpR
         eLP0/zh7voFY9o9VuqUwBUXUUVmKy8fQ922dRMHD/NJhqhST20J5UVToRWQKkycOoUTh
         8N9mHmUJLudkBPRjGkwV2psXcSY/wTTx5SS/yqu/WHnozs/X68TCaukS6jCY5NfHIXkH
         n9LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700477505; x=1701082305;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GoFieG/IuF1414lZw2Sgkyh6AlX1/CL3qBCeIx9HmeQ=;
        b=VVj6UOPobl7sZGEI+lRr5vQmR+RXl/P+95Qnkvl/xsr2YMD6wnds2m4ZAgXx7VBWcx
         aKP3E9Qd9qg7C6mILrJOp0w21HQmug/QM3K9TAPAshd/j//2pb7x00C5KE1KxjphJeNE
         o7ZmJZaDDxP7Fsaqg6yPD9UDN35RjFuUk7ABzPBTqJssjOnEHZ5mf1VBoE1U8M8fNqJZ
         KvbkhCbDbHDzyiwpgJXo/PQrGVfIWTtfE8jKLFqZwt4K5sP/nDDDoGERQE6dqVJcHd4V
         D/5ys4lYTOn1R7XypkJecBhomTkL9Qxv/hKcA4ef62vVQO0EWcLqojwIemnRMHzJGX4w
         /Vtg==
X-Gm-Message-State: AOJu0YyRAfIhTMFE8dOkcGdeXUfBDPNP5zPNcJF6bnA8c9zt7hslGRY7
	En8XxCtzLK+4UO0BrYHvVIy3hiJfSnZUbK8PbF8=
X-Google-Smtp-Source: AGHT+IGqVoBe28EFpUZOK1MgIc6x66xFCPvpO+V1WI1AkRQspo91Ovr3lkCkAfD3s9ZyEqKnughEEA==
X-Received: by 2002:a05:6a20:a29d:b0:187:df72:48f0 with SMTP id a29-20020a056a20a29d00b00187df7248f0mr3787863pzl.41.1700477504305;
        Mon, 20 Nov 2023 02:51:44 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x6-20020a056a00270600b006cb8c92a8acsm2118150pfv.113.2023.11.20.02.51.42
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 02:51:43 -0800 (PST)
Message-ID: <655b3a3f.050a0220.12124.4050@mx.google.com>
Date: Mon, 20 Nov 2023 02:51:43 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.200-cip40-513-g195b5d2b5c744
Subject: cip-gitlab/ci/pavel/linux-test baseline: 81 runs,
 46 regressions (v5.10.200-cip40-513-g195b5d2b5c744)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Nov 2023 10:51:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13597

cip-gitlab/ci/pavel/linux-test baseline: 81 runs, 46 regressions (v5.10.200=
-cip40-513-g195b5d2b5c744)

Regressions Summary
-------------------

platform                     | arch  | lab             | compiler | defconf=
ig           | regressions
-----------------------------+-------+-----------------+----------+--------=
-------------+------------
at91sam9g20ek                | arm   | lab-broonie     | gcc-10   | at91_dt=
_defconfig   | 3          =

at91sam9g20ek                | arm   | lab-broonie     | gcc-10   | multi_v=
5_defconfig  | 1          =

beaglebone-black             | arm   | lab-broonie     | gcc-10   | multi_v=
7_defconfig  | 6          =

beaglebone-black             | arm   | lab-cip         | gcc-10   | multi_v=
7_defconfig  | 7          =

beaglebone-black             | arm   | lab-broonie     | gcc-10   | omap2pl=
us_defconfig | 1          =

imx6dl-udoo                  | arm   | lab-broonie     | gcc-10   | multi_v=
7_defconfig  | 1          =

imx6q-udoo                   | arm   | lab-broonie     | gcc-10   | multi_v=
7_defconfig  | 1          =

imx6qp-wandboard-revd1       | arm   | lab-pengutronix | gcc-10   | imx_v6_=
v7_defconfig | 1          =

imx6qp-wandboard-revd1       | arm   | lab-pengutronix | gcc-10   | multi_v=
7_defconfig  | 1          =

imx7d-sdb                    | arm   | lab-nxp         | gcc-10   | imx_v6_=
v7_defconfig | 1          =

imx7d-sdb                    | arm   | lab-nxp         | gcc-10   | multi_v=
7_defconfig  | 1          =

juno-uboot                   | arm64 | lab-broonie     | gcc-10   | defconf=
ig           | 10         =

kontron-sl28-var3-ads2       | arm64 | lab-kontron     | gcc-10   | defconf=
ig           | 3          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie     | gcc-10   | defconf=
ig           | 1          =

qemu_mips-malta              | mips  | lab-broonie     | gcc-10   | malta_d=
efconfig     | 1          =

qemu_mips-malta              | mips  | lab-collabora   | gcc-10   | malta_d=
efconfig     | 1          =

sun50i-a64-pine64-plus       | arm64 | lab-broonie     | gcc-10   | defconf=
ig           | 5          =

zynqmp-zcu102                | arm64 | lab-cip         | gcc-10   | defconf=
ig           | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.200-cip40-513-g195b5d2b5c744/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.200-cip40-513-g195b5d2b5c744
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      195b5d2b5c7445a89862b44b490b78e540906e81 =



Test Regressions
---------------- =



platform                     | arch  | lab             | compiler | defconf=
ig           | regressions
-----------------------------+-------+-----------------+----------+--------=
-------------+------------
at91sam9g20ek                | arm   | lab-broonie     | gcc-10   | at91_dt=
_defconfig   | 3          =


  Details:     https://kernelci.org/test/plan/id/655b30b2075141fcea7e4a94

  Results:     49 PASS, 4 FAIL, 1 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/arm/at91_dt_defconfig/gcc-10/lab-brooni=
e/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/arm/at91_dt_defconfig/gcc-10/lab-brooni=
e/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.gpio-keys-probed: https://kernelci.org/test/case/id/655=
b30b2075141fcea7e4a9d
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:10:36.361058  /lava-255320/1/../bin/lava-test-case
    2023-11-20T10:10:36.401928  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dgpi=
o-keys-probed RESULT=3Dfail>   =


  * baseline.bootrr.wm8731-driver-present: https://kernelci.org/test/case/i=
d/655b30b2075141fcea7e4aa8
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:10:32.134561  /lava-255320/1/../bin/lava-test-case
    2023-11-20T10:10:32.174589  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Deep=
rom-probed RESULT=3Dblocked>
    2023-11-20T10:10:32.221570  sh: /sys/bus/spi/drivers/wm8731: unknown op=
erand
    2023-11-20T10:10:33.236165  /lava-255320/1/../bin/lava-test-case
    2023-11-20T10:10:33.276944  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dwm8=
731-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.at24-driver-present: https://kernelci.org/test/case/id/=
655b30b2075141fcea7e4aa9
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:10:31.033091  /lava-255320/1/../bin/lava-test-case
    2023-11-20T10:10:31.073666  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dat2=
4-driver-present RESULT=3Dfail>   =

 =



platform                     | arch  | lab             | compiler | defconf=
ig           | regressions
-----------------------------+-------+-----------------+----------+--------=
-------------+------------
at91sam9g20ek                | arm   | lab-broonie     | gcc-10   | multi_v=
5_defconfig  | 1          =


  Details:     https://kernelci.org/test/plan/id/655b32ce06383641e97e4afc

  Results:     48 PASS, 6 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/arm/multi_v5_defconfig/gcc-10/lab-broon=
ie/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/arm/multi_v5_defconfig/gcc-10/lab-broon=
ie/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.gpio-keys-probed: https://kernelci.org/test/case/id/655=
b32ce06383641e97e4b05
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:19:46.836260  /lava-255407/1/../bin/lava-test-case
    2023-11-20T10:19:46.876901  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dgpi=
o-keys-probed RESULT=3Dfail>   =

 =



platform                     | arch  | lab             | compiler | defconf=
ig           | regressions
-----------------------------+-------+-----------------+----------+--------=
-------------+------------
beaglebone-black             | arm   | lab-broonie     | gcc-10   | multi_v=
7_defconfig  | 6          =


  Details:     https://kernelci.org/test/plan/id/655b3153804f1819547e4a97

  Results:     31 PASS, 14 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/id/65=
5b3153804f1819547e4a9e
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:13:22.336885  /lava-255347/1/../bin/lava-test-case
    2023-11-20T10:13:22.379782  <8>[   51.648672] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-codec-driver-present: https://kernelci.org/test/ca=
se/id/655b3153804f1819547e4aa0
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:13:20.157274  /lava-255347/1/../bin/lava-test-case
    2023-11-20T10:13:20.200093  <8>[   49.474564] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-11-20T10:13:21.223626  /lava-255347/1/../bin/lava-test-case
    2023-11-20T10:13:21.267462  /opt/bootrr/libexec/bootrr/boards/ti,am335x=
-bone-black: <8>[   50.536344] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dhdmi-co=
dec-driver-present RESULT=3Dfail>
    2023-11-20T10:13:21.267905  line 84: assert_device-present: not found   =


  * baseline.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case/id/=
655b3153804f1819547e4aa1
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:13:18.034044  /lava-255347/1/../bin/lava-test-case
    2023-11-20T10:13:18.071881  <8>[   47.346871] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-11-20T10:13:19.096401  /lava-255347/1/../bin/lava-test-case
    2023-11-20T10:13:19.141271  <8>[   48.408359] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline.bootrr.tda19988-driver-present: https://kernelci.org/test/case=
/id/655b3153804f1819547e4aa2
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:13:15.908215  /lava-255347/1/../bin/lava-test-case
    2023-11-20T10:13:15.950931  <8>[   45.224638] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-11-20T10:13:16.974036  /lava-255347/1/../bin/lava-test-case
    2023-11-20T10:13:17.012374  <8>[   46.281228] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/655b3153804f1819547e4aae
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:13:03.976176  /lava-255347/1/../bin/lava-test-case
    2023-11-20T10:13:04.012058  <8>[   33.287118] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/655b3153804f1819547e4ac7
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:12:58.239546  <8>[   27.507517] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 255347_1.5.2.4.1>
    2023-11-20T10:12:58.346584  / # #
    2023-11-20T10:12:58.448568  export SHELL=3D/bin/sh
    2023-11-20T10:12:58.449094  #
    2023-11-20T10:12:58.550494  / # export SHELL=3D/bin/sh. /lava-255347/en=
vironment
    2023-11-20T10:12:58.551099  =

    2023-11-20T10:12:58.652991  / # . /lava-255347/environment/lava-255347/=
bin/lava-test-runner /lava-255347/1
    2023-11-20T10:12:58.653778  =

    2023-11-20T10:12:58.658709  / # /lava-255347/bin/lava-test-runner /lava=
-255347/1
    2023-11-20T10:12:58.754360  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab             | compiler | defconf=
ig           | regressions
-----------------------------+-------+-----------------+----------+--------=
-------------+------------
beaglebone-black             | arm   | lab-cip         | gcc-10   | multi_v=
7_defconfig  | 7          =


  Details:     https://kernelci.org/test/plan/id/655b36ef88d048a7c07e4ab7

  Results:     30 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/arm/multi_v7_defconfig/gcc-10/lab-cip/b=
aseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/arm/multi_v7_defconfig/gcc-10/lab-cip/b=
aseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.hdmi-audio: https://kernelci.org/test/case/id/655b36ef8=
8d048a7c07e4abd
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:37:15.792642  /lava-1041893/1/../bin/lava-test-case
    2023-11-20T10:37:15.828268  <8>[   41.799105] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/id/65=
5b36ef88d048a7c07e4abe
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:37:14.732956  /lava-1041893/1/../bin/lava-test-case
    2023-11-20T10:37:14.768631  <8>[   40.739114] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-codec-driver-present: https://kernelci.org/test/ca=
se/id/655b36ef88d048a7c07e4ac0
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:37:12.562615  /lava-1041893/1/../bin/lava-test-case
    2023-11-20T10:37:12.598703  <8>[   38.568963] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-11-20T10:37:13.623713  /lava-1041893/1/../bin/lava-test-case
    2023-11-20T10:37:13.660845  /opt/bootrr/libexec/bootrr/boards/ti,am335x=
-bone-black: line 84: assert_device-present: not found
    2023-11-20T10:37:13.666486  <8>[   39.630128] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case/id/=
655b36ef88d048a7c07e4ac1
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:37:10.435645  /lava-1041893/1/../bin/lava-test-case
    2023-11-20T10:37:10.478452  <8>[   36.446027] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-11-20T10:37:11.500973  /lava-1041893/1/../bin/lava-test-case
    2023-11-20T10:37:11.538366  <8>[   37.507520] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline.bootrr.tda19988-driver-present: https://kernelci.org/test/case=
/id/655b36ef88d048a7c07e4ac2
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:37:08.313961  /lava-1041893/1/../bin/lava-test-case
    2023-11-20T10:37:08.348256  <8>[   34.319628] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-11-20T10:37:09.374665  /lava-1041893/1/../bin/lava-test-case
    2023-11-20T10:37:09.418853  <8>[   35.380188] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/655b36ef88d048a7c07e4ace
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:36:56.379594  /lava-1041893/1/../bin/lava-test-case
    2023-11-20T10:36:56.419930  <8>[   22.387274] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/655b36ef88d048a7c07e4ae7
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:36:50.644109  + set +x
    2023-11-20T10:36:50.748819  TESTCASE TEST_CASE_ID=3Demerg RESULT=3Dpass=
 UNITS=3Dlines MEASUREMENT=3D0>
    2023-11-20T10:36:50.749058  =

    2023-11-20T10:36:50.749325  <8>[   16.618429] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1041893_1.5.2.4.1>
    2023-11-20T10:36:50.850548  / # #export SHELL=3D/bin/sh
    2023-11-20T10:36:50.850998  =

    2023-11-20T10:36:50.951922  / # export SHELL=3D/bin/sh. /lava-1041893/e=
nvironment
    2023-11-20T10:36:50.952369  =

    2023-11-20T10:36:51.053298  / # . /lava-1041893/environment/lava-104189=
3/bin/lava-test-runner /lava-1041893/1
    2023-11-20T10:36:51.054057   =

    ... (13 line(s) more)  =

 =



platform                     | arch  | lab             | compiler | defconf=
ig           | regressions
-----------------------------+-------+-----------------+----------+--------=
-------------+------------
beaglebone-black             | arm   | lab-broonie     | gcc-10   | omap2pl=
us_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/655b339ac0244f47577e4a71

  Results:     50 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/arm/omap2plus_defconfig/gcc-10/lab-broo=
nie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/arm/omap2plus_defconfig/gcc-10/lab-broo=
nie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/id/6=
55b339ac0244f47577e4a8f
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:23:09.937843  /lava-255426/1/../bin/lava-test-case
    2023-11-20T10:23:09.984847  <8>[   23.050294] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =

 =



platform                     | arch  | lab             | compiler | defconf=
ig           | regressions
-----------------------------+-------+-----------------+----------+--------=
-------------+------------
imx6dl-udoo                  | arm   | lab-broonie     | gcc-10   | multi_v=
7_defconfig  | 1          =


  Details:     https://kernelci.org/test/plan/id/655b3223c11915fcc77e4a91

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/655b3223c11915fcc77e4=
a92
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e) =

 =



platform                     | arch  | lab             | compiler | defconf=
ig           | regressions
-----------------------------+-------+-----------------+----------+--------=
-------------+------------
imx6q-udoo                   | arm   | lab-broonie     | gcc-10   | multi_v=
7_defconfig  | 1          =


  Details:     https://kernelci.org/test/plan/id/655b337632e06d6fb87e4a7c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/655b337632e06d6fb87e4=
a7d
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e) =

 =



platform                     | arch  | lab             | compiler | defconf=
ig           | regressions
-----------------------------+-------+-----------------+----------+--------=
-------------+------------
imx6qp-wandboard-revd1       | arm   | lab-pengutronix | gcc-10   | imx_v6_=
v7_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/655b323858f48291b27e4a6d

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/arm/imx_v6_v7_defconfig/gcc-10/lab-peng=
utronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/arm/imx_v6_v7_defconfig/gcc-10/lab-peng=
utronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/655b323858f48291b27e4a75
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:17:18.280820  + set +x
    2023-11-20T10:17:18.394779  EASUREMENT=3D0>
    2023-11-20T10:17:18.394907  =

    2023-11-20T10:17:18.395047  / # [    9.106339] <LAVA_SIGNAL_ENDRUN 0_dm=
esg 1010025_1.5.2.3.1>
    2023-11-20T10:17:18.496015  #export SHELL=3D/bin/sh
    2023-11-20T10:17:18.496496  =

    2023-11-20T10:17:18.597309  / # export SHELL=3D/bin/sh. /lava-1010025/e=
nvironment
    2023-11-20T10:17:18.597832  =

    2023-11-20T10:17:18.698724  / # . /lava-1010025/environment/lava-101002=
5/bin/lava-test-runner /lava-1010025/1
    2023-11-20T10:17:18.699431   =

    ... (13 line(s) more)  =

 =



platform                     | arch  | lab             | compiler | defconf=
ig           | regressions
-----------------------------+-------+-----------------+----------+--------=
-------------+------------
imx6qp-wandboard-revd1       | arm   | lab-pengutronix | gcc-10   | multi_v=
7_defconfig  | 1          =


  Details:     https://kernelci.org/test/plan/id/655b30f6b10a0aaa507e4afb

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/arm/multi_v7_defconfig/gcc-10/lab-pengu=
tronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/arm/multi_v7_defconfig/gcc-10/lab-pengu=
tronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/655b30f6b10a0aaa507e4b04
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:11:41.418135  [    7.256881] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-11-20T10:11:41.418430  [    7.258175] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1010019_1.5.2.3.1>
    2023-11-20T10:11:41.520481  / # #
    2023-11-20T10:11:41.621620  export SHELL=3D/bin/sh
    2023-11-20T10:11:41.622063  #
    2023-11-20T10:11:41.722961  / # export SHELL=3D/bin/sh. /lava-1010019/e=
nvironment
    2023-11-20T10:11:41.723472  =

    2023-11-20T10:11:41.824336  / # . /lava-1010019/environment/lava-101001=
9/bin/lava-test-runner /lava-1010019/1
    2023-11-20T10:11:41.824953  =

    2023-11-20T10:11:41.827436  / # /lava-1010019/bin/lava-test-runner /lav=
a-1010019/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch  | lab             | compiler | defconf=
ig           | regressions
-----------------------------+-------+-----------------+----------+--------=
-------------+------------
imx7d-sdb                    | arm   | lab-nxp         | gcc-10   | imx_v6_=
v7_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/655b32940f05210bea7e4a7f

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/arm/imx_v6_v7_defconfig/gcc-10/lab-nxp/=
baseline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/arm/imx_v6_v7_defconfig/gcc-10/lab-nxp/=
baseline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.all-cpus-are-online: https://kernelci.org/test/case/id/=
655b32940f05210bea7e4a86
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:18:48.670904  /lava-1259423/1/../bin/lava-test-case
    2023-11-20T10:18:48.709973  <8>[   30.856038] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dall-cpus-are-online RESULT=3Dfail>   =

 =



platform                     | arch  | lab             | compiler | defconf=
ig           | regressions
-----------------------------+-------+-----------------+----------+--------=
-------------+------------
imx7d-sdb                    | arm   | lab-nxp         | gcc-10   | multi_v=
7_defconfig  | 1          =


  Details:     https://kernelci.org/test/plan/id/655b313e804f1819547e4a73

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/arm/multi_v7_defconfig/gcc-10/lab-nxp/b=
aseline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/arm/multi_v7_defconfig/gcc-10/lab-nxp/b=
aseline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.all-cpus-are-online: https://kernelci.org/test/case/id/=
655b313f804f1819547e4a7b
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:12:57.207839  /lava-1259418/1/../bin/lava-test-case   =

 =



platform                     | arch  | lab             | compiler | defconf=
ig           | regressions
-----------------------------+-------+-----------------+----------+--------=
-------------+------------
juno-uboot                   | arm64 | lab-broonie     | gcc-10   | defconf=
ig           | 10         =


  Details:     https://kernelci.org/test/plan/id/655b326a58f48291b27e4aa4

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/arm64/defconfig/gcc-10/lab-broonie/base=
line-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/arm64/defconfig/gcc-10/lab-broonie/base=
line-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.led7-probed: https://kernelci.org/test/case/id/655b326a=
58f48291b27e4ab4
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:17:57.262065  /lava-255388/1/../bin/lava-test-case
    2023-11-20T10:17:57.262643  <8>[   40.708334] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled7-probed RESULT=3Dfail>
    2023-11-20T10:17:57.263018  /lava-255388/1/../bin/lava-test-case
    2023-11-20T10:17:57.263360  <8>[   40.723276] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dkmi-pl050-driver-present RESULT=3Dpass>   =


  * baseline.bootrr.led6-probed: https://kernelci.org/test/case/id/655b326a=
58f48291b27e4ab5
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:17:56.180927  /lava-255388/1/../bin/lava-test-case
    2023-11-20T10:17:56.202255  <8>[   39.685729] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled6-probed RESULT=3Dfail>   =


  * baseline.bootrr.led5-probed: https://kernelci.org/test/case/id/655b326a=
58f48291b27e4ab6
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:17:55.171167  /lava-255388/1/../bin/lava-test-case
    2023-11-20T10:17:55.173672  <8>[   38.663322] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled5-probed RESULT=3Dfail>   =


  * baseline.bootrr.led4-probed: https://kernelci.org/test/case/id/655b326a=
58f48291b27e4ab7
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:17:54.151165  /lava-255388/1/../bin/lava-test-case
    2023-11-20T10:17:54.154314  <8>[   37.641117] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled4-probed RESULT=3Dfail>   =


  * baseline.bootrr.led3-probed: https://kernelci.org/test/case/id/655b326a=
58f48291b27e4ab8
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:17:53.111901  /lava-255388/1/../bin/lava-test-case
    2023-11-20T10:17:53.132845  <8>[   36.618474] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled3-probed RESULT=3Dfail>   =


  * baseline.bootrr.led2-probed: https://kernelci.org/test/case/id/655b326a=
58f48291b27e4ab9
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:17:52.102708  /lava-255388/1/../bin/lava-test-case
    2023-11-20T10:17:52.104920  <8>[   35.595995] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled2-probed RESULT=3Dfail>   =


  * baseline.bootrr.led1-probed: https://kernelci.org/test/case/id/655b326a=
58f48291b27e4aba
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:17:51.070119  /lava-255388/1/../bin/lava-test-case
    2023-11-20T10:17:51.086103  <8>[   34.573149] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled1-probed RESULT=3Dfail>   =


  * baseline.bootrr.led0-probed: https://kernelci.org/test/case/id/655b326a=
58f48291b27e4abb
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:17:50.059880  /lava-255388/1/../bin/lava-test-case
    2023-11-20T10:17:50.063137  <8>[   33.550212] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled0-probed RESULT=3Dfail>   =


  * baseline.bootrr.iommu1-probed: https://kernelci.org/test/case/id/655b32=
6a58f48291b27e4acf
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:17:48.760770  /lava-255388/1/../bin/lava-test-case
    2023-11-20T10:17:48.761390  <8>[   32.203948] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Diommu1-probed RESULT=3Dfail>
    2023-11-20T10:17:48.761816  /lava-255388/1/../bin/lava-test-case
    2023-11-20T10:17:48.762253  <8>[   32.223160] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Diommu2-probed RESULT=3Dpass>   =


  * baseline.bootrr.1c050000_mmc-probed: https://kernelci.org/test/case/id/=
655b326a58f48291b27e4adc
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:17:47.468321  /lava-255388/1/../bin/lava-test-case
    2023-11-20T10:17:47.468884  <8>[   30.953359] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3D1c050000.mmc-probed RESULT=3Dfail>   =

 =



platform                     | arch  | lab             | compiler | defconf=
ig           | regressions
-----------------------------+-------+-----------------+----------+--------=
-------------+------------
kontron-sl28-var3-ads2       | arm64 | lab-kontron     | gcc-10   | defconf=
ig           | 3          =


  Details:     https://kernelci.org/test/plan/id/655b317c9c1025f99d7e4de5

  Results:     96 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/arm64/defconfig/gcc-10/lab-kontron/base=
line-kontron-sl28-var3-ads2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/arm64/defconfig/gcc-10/lab-kontron/base=
line-kontron-sl28-var3-ads2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rcpm-driver-present: https://kernelci.org/test/case/id/=
655b317c9c1025f99d7e4e2f
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:13:50.960486  /lava-396932/1/../bin/lava-test-case
    2023-11-20T10:13:50.982513  <8>[   10.584117] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.ftm-alarm-driver-present: https://kernelci.org/test/cas=
e/id/655b317c9c1025f99d7e4e30
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:13:51.973951  /lava-396932/1/../bin/lava-test-case
    2023-11-20T10:13:51.995113  <8>[   11.595280] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2023-11-20T10:13:52.986109  /lava-396932/1/../bin/lava-test-case
    2023-11-20T10:13:53.007053  <8>[   12.606720] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dftm-alarm-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.layerscape-sfp-driver-present: https://kernelci.org/tes=
t/case/id/655b317c9c1025f99d7e4e45
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:13:55.281591  /lava-396932/1/../bin/lava-test-case
    2023-11-20T10:13:55.302579  <8>[   14.903966] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =

 =



platform                     | arch  | lab             | compiler | defconf=
ig           | regressions
-----------------------------+-------+-----------------+----------+--------=
-------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie     | gcc-10   | defconf=
ig           | 1          =


  Details:     https://kernelci.org/test/plan/id/655b31ce05b402b2c17e4b9e

  Results:     49 PASS, 4 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/arm64/defconfig/gcc-10/lab-broonie/base=
line-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/arm64/defconfig/gcc-10/lab-broonie/base=
line-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/655b31ce0=
5b402b2c17e4ba4
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:14:38.495798  /lava-255382/1/../bin/lava-test-case
    2023-11-20T10:14:38.508341  <8>[   19.270026] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>
    2023-11-20T10:14:38.508989  + set +x   =

 =



platform                     | arch  | lab             | compiler | defconf=
ig           | regressions
-----------------------------+-------+-----------------+----------+--------=
-------------+------------
qemu_mips-malta              | mips  | lab-broonie     | gcc-10   | malta_d=
efconfig     | 1          =


  Details:     https://kernelci.org/test/plan/id/655b308b476e5b2da77e4a86

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/mips/malta_defconfig/gcc-10/lab-broonie=
/baseline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/mips/malta_defconfig/gcc-10/lab-broonie=
/baseline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/655b308b476e5b2da77e4=
a87
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e) =

 =



platform                     | arch  | lab             | compiler | defconf=
ig           | regressions
-----------------------------+-------+-----------------+----------+--------=
-------------+------------
qemu_mips-malta              | mips  | lab-collabora   | gcc-10   | malta_d=
efconfig     | 1          =


  Details:     https://kernelci.org/test/plan/id/655b2f940381b046177e4abe

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/mips/malta_defconfig/gcc-10/lab-collabo=
ra/baseline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/mips/malta_defconfig/gcc-10/lab-collabo=
ra/baseline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/655b2f940381b046177e4=
abf
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e) =

 =



platform                     | arch  | lab             | compiler | defconf=
ig           | regressions
-----------------------------+-------+-----------------+----------+--------=
-------------+------------
sun50i-a64-pine64-plus       | arm64 | lab-broonie     | gcc-10   | defconf=
ig           | 5          =


  Details:     https://kernelci.org/test/plan/id/655b31e6b8cad800fe7e4a6d

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/arm64/defconfig/gcc-10/lab-broonie/base=
line-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/arm64/defconfig/gcc-10/lab-broonie/base=
line-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/655b31e6b=
8cad800fe7e4a87
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:15:57.914532  /lava-255380/1/../bin/lava-test-case
    2023-11-20T10:15:57.927719  <8>[   24.777799] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Di2s-probed RESULT=3Dblocked>
    2023-11-20T10:15:58.935204  /lava-255380/1/../bin/lava-test-case
    2023-11-20T10:15:58.950474  <8>[   25.798442] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>
    2023-11-20T10:15:58.950912  /lava-255380/1/../bin/lava-test-case   =


  * baseline.bootrr.sun4i-i2s-driver-present: https://kernelci.org/test/cas=
e/id/655b31e6b8cad800fe7e4a88
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:15:55.869695  /lava-255380/1/../bin/lava-test-case
    2023-11-20T10:15:55.884110  <8>[   22.732989] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcodec-digital-probed RESULT=3Dblocked>
    2023-11-20T10:15:56.891170  /lava-255380/1/../bin/lava-test-case
    2023-11-20T10:15:56.904496  <8>[   23.754659] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun4i-i2s-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sun8i-codec-driver-present: https://kernelci.org/test/c=
ase/id/655b31e6b8cad800fe7e4a89
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:15:53.818914  /lava-255380/1/../bin/lava-test-case
    2023-11-20T10:15:53.831935  <8>[   20.682747] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcodec-analog-probed RESULT=3Dblocked>
    2023-11-20T10:15:54.840511  /lava-255380/1/../bin/lava-test-case
    2023-11-20T10:15:54.852435  <8>[   21.704021] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8i-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sun50i-codec-analog-driver-present: https://kernelci.or=
g/test/case/id/655b31e6b8cad800fe7e4a8a
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:15:52.797130  /lava-255380/1/../bin/lava-test-case
    2023-11-20T10:15:52.812756  <8>[   19.661191] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun50i-codec-analog-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/655b31e6b8cad800fe7e4a9d
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:15:49.829598  <8>[   16.683020] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 255380_1.5.2.4.1>
    2023-11-20T10:15:49.933235  / # #
    2023-11-20T10:15:50.034477  export SHELL=3D/bin/sh
    2023-11-20T10:15:50.034777  #
    2023-11-20T10:15:50.135791  / # export SHELL=3D/bin/sh. /lava-255380/en=
vironment
    2023-11-20T10:15:50.136104  =

    2023-11-20T10:15:50.237139  / # . /lava-255380/environment/lava-255380/=
bin/lava-test-runner /lava-255380/1
    2023-11-20T10:15:50.237541  =

    2023-11-20T10:15:50.242000  / # /lava-255380/bin/lava-test-runner /lava=
-255380/1
    2023-11-20T10:15:50.286846  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab             | compiler | defconf=
ig           | regressions
-----------------------------+-------+-----------------+----------+--------=
-------------+------------
zynqmp-zcu102                | arm64 | lab-cip         | gcc-10   | defconf=
ig           | 1          =


  Details:     https://kernelci.org/test/plan/id/655b327b7bd4b2adc57e4bd0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/arm64/defconfig/gcc-10/lab-cip/baseline=
-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/arm64/defconfig/gcc-10/lab-cip/baseline=
-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/655b327b7bd4b2adc57e4=
bd1
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e) =

 =20

