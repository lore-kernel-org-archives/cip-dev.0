Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E198C10DC1
	for <webhook@archiver.kernel.org>; Wed,  6 Dec 2023 07:04:56 +0000 (UTC)
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
 by mx.groups.io with SMTP id smtpd.web10.26201.1701846292740655642
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 05 Dec 2023 23:04:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=A4ve6R7r;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.161.41, mailfrom: bot@kernelci.org)
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-58e28e0461bso2507465eaf.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 05 Dec 2023 23:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701846291; x=1702451091; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jZ0/mi6r/gpyrcf3Lnm1hr5wVCsLz+3VflTo6pNvn0w=;
        b=A4ve6R7rgBtIQXXRD83ACBMMQ5YoxAgvQLS8L5UcTZov/S1qivegJ7BHiFvrWFLyDR
         5mxHs5LtGhFsDhwck7Hivq6gU4iPa3dmmjiWrDNuWRtbRqmwxsQNtIZAgZZ7kXiI++fD
         RYVyYIQSl+veHcuowVTevlwEH9CDSlI9oyMNb6y4ZD5XXu3Vk2TFSocWfvG/uJqnb3m/
         ujtK1wSBFh0cfkWESd9ZnnV0tI6pe07ED/1Uf9U1AKZUVNOraeiDugHHlImMZ0hskywZ
         nAIUtE1ebakeDP2wFkqo0Q5MF/Q4QycAk43oTUlVb8HfeuASs5oSv6h1bVbjL/yb3v0m
         Pd1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701846291; x=1702451091;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jZ0/mi6r/gpyrcf3Lnm1hr5wVCsLz+3VflTo6pNvn0w=;
        b=DDi+OQrw0HsgLy3/toFYbRoGBvRtioAe4OZl7gw9xD/x17Ta02a41lI19FvJPkOpNm
         PAKkHm9UktbU8DfF7bEcD+h1wd/4nOXl34d2zTH4hEk5+4yweV7+nnGqEToqR8h6aVD0
         Auq7OImkTu5vWIZIEZ2j4DUpEtzAk0GbP5Cvv6hg0xWUOIlKMq5NFoXiqx5rJltZ26Kj
         cDI+8BNy3iZyS8Jsp51xrhf4YZwRX7ScrmwH6rh6z+YJmF6/+QRPLCJDazu3zg8PbVmb
         +cc1USLkTCjlVCHaqBelBPCP3+MpuLpjRhaSwI2agN+OgFQcAqjeEQuY9Co/6q4qZrVb
         awYA==
X-Gm-Message-State: AOJu0YzHTJJ3x2aMlBYjtFfrcrP/kq5xJ8A5i8/OS/UBN5sZuWfn7BZU
	BeSS1v1w2om12iVNTA+BbB5t3sdErHbzbiznVRbEMA==
X-Google-Smtp-Source: AGHT+IF5b6IQiJxram7KHCbBJgH9/3KTcErCKFSBpoYJsohv8LYsj7IBlJRm/QPiMlvjcSvPOAiy6Q==
X-Received: by 2002:a05:6358:e95:b0:16d:bcfa:e0cf with SMTP id 21-20020a0563580e9500b0016dbcfae0cfmr442808rwg.30.1701846290799;
        Tue, 05 Dec 2023 23:04:50 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x13-20020a056a000bcd00b006ce65bf5376sm2359087pfu.75.2023.12.05.23.04.49
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 23:04:50 -0800 (PST)
Message-ID: <65701d12.050a0220.7ca5a.702c@mx.google.com>
Date: Tue, 05 Dec 2023 23:04:50 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-16-g3c85fba3b6e5d
Subject: cip-gitlab/ci/pavel/linux-test baseline: 102 runs,
 54 regressions (v5.10.201-cip41-16-g3c85fba3b6e5d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Dec 2023 07:04:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13796

cip-gitlab/ci/pavel/linux-test baseline: 102 runs, 54 regressions (v5.10.20=
1-cip41-16-g3c85fba3b6e5d)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
acer-cbv514-1h-34uz-brya     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =

acer-chromebox-cxi5-brask    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =

at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | at91_d=
t_defconfig          | 3          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig         | 7          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig         | 7          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig        | 1          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig        | 1          =

imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig         | 1          =

imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig         | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig        | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig         | 1          =

juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                  | 10         =

kontron-kbox-a-230-ls        | arm64  | lab-kontron     | gcc-10   | defcon=
fig                  | 3          =

kontron-sl28-var3-ads2       | arm64  | lab-kontron     | gcc-10   | defcon=
fig                  | 3          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig                  | 1          =

qemu_mips-malta              | mips   | lab-broonie     | gcc-10   | malta_=
defconfig            | 1          =

qemu_mips-malta              | mips   | lab-collabora   | gcc-10   | malta_=
defconfig            | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig         | 1          =

rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig         | 3          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                  | 5          =

zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig                  | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.201-cip41-16-g3c85fba3b6e5d/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.201-cip41-16-g3c85fba3b6e5d
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      3c85fba3b6e5da8b112e7ecd142649674648028f =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
acer-cbv514-1h-34uz-brya     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65700ef8af31925ad3e13488

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-acer-cbv514-1h-34uz-brya.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-acer-cbv514-1h-34uz-brya.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65700ef8af31925ad3e13=
489
        new failure (last pass: v6.1.64-cip10-rt5) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
acer-chromebox-cxi5-brask    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65700ee50127323244e134aa

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-acer-chromebox-cxi5-brask.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-acer-chromebox-cxi5-brask.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65700ee50127323244e13=
4ab
        new failure (last pass: v6.1.64-cip10-rt5) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | at91_d=
t_defconfig          | 3          =


  Details:     https://kernelci.org/test/plan/id/65701070ab4a44383be134e1

  Results:     49 PASS, 4 FAIL, 1 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/arm/at91_dt_defconfig/gcc-10/lab-broonie=
/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/arm/at91_dt_defconfig/gcc-10/lab-broonie=
/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.gpio-keys-probed: https://kernelci.org/test/case/id/657=
01070ab4a44383be134e6
        new failure (last pass: v6.1.64-cip10-rt5)

    2023-12-06T06:10:33.089311  /lava-313454/1/../bin/lava-test-case
    2023-12-06T06:10:33.126870  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dgpi=
o-keys-probed RESULT=3Dfail>   =


  * baseline.bootrr.wm8731-driver-present: https://kernelci.org/test/case/i=
d/65701070ab4a44383be134f1
        new failure (last pass: v6.1.64-cip10-rt5)

    2023-12-06T06:10:28.886267  /lava-313454/1/../bin/lava-test-case
    2023-12-06T06:10:28.925120  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Deep=
rom-probed RESULT=3Dblocked>
    2023-12-06T06:10:28.967905  sh: /sys/bus/spi/drivers/wm8731: unknown op=
erand
    2023-12-06T06:10:29.987821  /lava-313454/1/../bin/lava-test-case
    2023-12-06T06:10:30.026134  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dwm8=
731-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.at24-driver-present: https://kernelci.org/test/case/id/=
65701070ab4a44383be134f2
        new failure (last pass: v6.1.64-cip10-rt5)

    2023-12-06T06:10:27.784853  /lava-313454/1/../bin/lava-test-case
    2023-12-06T06:10:27.824136  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dat2=
4-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig         | 7          =


  Details:     https://kernelci.org/test/plan/id/657016a26d2987283de134ac

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.hdmi-audio: https://kernelci.org/test/case/id/657016a26=
d2987283de134af
        new failure (last pass: v6.1.62-cip9-12-g3a5321f469b07)

    2023-12-06T06:37:11.486091  /lava-313521/1/../bin/lava-test-case
    2023-12-06T06:37:11.519748  <8>[   47.979236] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/id/65=
7016a26d2987283de134b0
        new failure (last pass: v6.1.62-cip9-12-g3a5321f469b07)

    2023-12-06T06:37:10.428874  /lava-313521/1/../bin/lava-test-case
    2023-12-06T06:37:10.459023  <8>[   46.917621] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-codec-driver-present: https://kernelci.org/test/ca=
se/id/657016a26d2987283de134b2
        new failure (last pass: v6.1.62-cip9-12-g3a5321f469b07)

    2023-12-06T06:37:08.257022  /lava-313521/1/../bin/lava-test-case
    2023-12-06T06:37:08.290278  <8>[   44.749218] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-12-06T06:37:09.316570  /lava-313521/1/../bin/lava-test-case
    2023-12-06T06:37:09.358354  <8>[   45.814487] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case/id/=
657016a26d2987283de134b3
        new failure (last pass: v6.1.62-cip9-12-g3a5321f469b07)

    2023-12-06T06:37:06.136577  /lava-313521/1/../bin/lava-test-case
    2023-12-06T06:37:06.170413  <8>[   42.629123] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-12-06T06:37:07.197238  /lava-313521/1/../bin/lava-test-case
    2023-12-06T06:37:07.230191  <8>[   43.688739] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline.bootrr.tda19988-driver-present: https://kernelci.org/test/case=
/id/657016a26d2987283de134b4
        new failure (last pass: v6.1.62-cip9-12-g3a5321f469b07)

    2023-12-06T06:37:04.012941  /lava-313521/1/../bin/lava-test-case
    2023-12-06T06:37:04.047874  <8>[   40.507055] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-12-06T06:37:05.074795  /lava-313521/1/../bin/lava-test-case
    2023-12-06T06:37:05.109569  <8>[   41.567874] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/657016a26d2987283de134c0
        new failure (last pass: v6.1.62-cip9-12-g3a5321f469b07)

    2023-12-06T06:36:52.083364  /lava-313521/1/../bin/lava-test-case
    2023-12-06T06:36:52.119990  <8>[   28.577513] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657016a26d2987283de134d9
        new failure (last pass: v6.1.62-cip9-12-g3a5321f469b07)

    2023-12-06T06:36:46.337532  <8>[   22.797669] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 313521_1.5.2.4.1>
    2023-12-06T06:36:46.446600  / # #
    2023-12-06T06:36:46.548723  export SHELL=3D/bin/sh
    2023-12-06T06:36:46.549412  #
    2023-12-06T06:36:46.651057  / # export SHELL=3D/bin/sh. /lava-313521/en=
vironment
    2023-12-06T06:36:46.651514  =

    2023-12-06T06:36:46.753153  / # . /lava-313521/environment/lava-313521/=
bin/lava-test-runner /lava-313521/1
    2023-12-06T06:36:46.754086  =

    2023-12-06T06:36:46.757212  / # /lava-313521/bin/lava-test-runner /lava=
-313521/1
    2023-12-06T06:36:46.853548  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig         | 7          =


  Details:     https://kernelci.org/test/plan/id/65701b96c9b6bd9959e13475

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/arm/multi_v7_defconfig/gcc-10/lab-cip/ba=
seline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/arm/multi_v7_defconfig/gcc-10/lab-cip/ba=
seline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.hdmi-audio: https://kernelci.org/test/case/id/65701b96c=
9b6bd9959e13478
        new failure (last pass: v6.1.62-cip9-12-g3a5321f469b07)

    2023-12-06T06:58:10.667904  /lava-1052627/1/../bin/lava-test-case
    2023-12-06T06:58:10.701548  <8>[   41.836833] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/id/65=
701b96c9b6bd9959e13479
        new failure (last pass: v6.1.62-cip9-12-g3a5321f469b07)

    2023-12-06T06:58:09.607263  /lava-1052627/1/../bin/lava-test-case
    2023-12-06T06:58:09.642205  <8>[   40.776849] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-codec-driver-present: https://kernelci.org/test/ca=
se/id/65701b96c9b6bd9959e1347b
        new failure (last pass: v6.1.62-cip9-12-g3a5321f469b07)

    2023-12-06T06:58:07.436725  /lava-1052627/1/../bin/lava-test-case
    2023-12-06T06:58:07.471631  <8>[   38.606366] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-12-06T06:58:08.498388  /lava-1052627/1/../bin/lava-test-case
    2023-12-06T06:58:08.535705  <8>[   39.667418] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case/id/=
65701b96c9b6bd9959e1347c
        new failure (last pass: v6.1.62-cip9-12-g3a5321f469b07)

    2023-12-06T06:58:05.311408  /lava-1052627/1/../bin/lava-test-case
    2023-12-06T06:58:05.344552  <8>[   36.478918] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-12-06T06:58:06.370992  /lava-1052627/1/../bin/lava-test-case
    2023-12-06T06:58:06.409922  <8>[   37.544292] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline.bootrr.tda19988-driver-present: https://kernelci.org/test/case=
/id/65701b96c9b6bd9959e1347d
        new failure (last pass: v6.1.62-cip9-12-g3a5321f469b07)

    2023-12-06T06:58:03.190424  /lava-1052627/1/../bin/lava-test-case
    2023-12-06T06:58:03.223607  <8>[   34.358212] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-12-06T06:58:04.250466  /lava-1052627/1/../bin/lava-test-case
    2023-12-06T06:58:04.285019  <8>[   35.418929] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/65701b96c9b6bd9959e13488
        new failure (last pass: v6.1.62-cip9-12-g3a5321f469b07)

    2023-12-06T06:57:51.258049  /lava-1052627/1/../bin/lava-test-case
    2023-12-06T06:57:51.293707  <8>[   22.426812] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65701b96c9b6bd9959e134a1
        new failure (last pass: v6.1.62-cip9-12-g3a5321f469b07)

    2023-12-06T06:57:45.520135  <8>[   16.653689] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1052627_1.5.2.4.1>
    2023-12-06T06:57:45.627061  / # #
    2023-12-06T06:57:45.728418  export SHELL=3D/bin/sh
    2023-12-06T06:57:45.728847  #
    2023-12-06T06:57:45.829720  / # export SHELL=3D/bin/sh. /lava-1052627/e=
nvironment
    2023-12-06T06:57:45.830148  =

    2023-12-06T06:57:45.931100  / # . /lava-1052627/environment/lava-105262=
7/bin/lava-test-runner /lava-1052627/1
    2023-12-06T06:57:45.931809  =

    2023-12-06T06:57:45.935973  / # /lava-1052627/bin/lava-test-runner /lav=
a-1052627/1
    2023-12-06T06:57:46.028713  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/65700f310eaeaa2c3ee13487

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/arm/omap2plus_defconfig/gcc-10/lab-broon=
ie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/arm/omap2plus_defconfig/gcc-10/lab-broon=
ie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/id/6=
5700f310eaeaa2c3ee134a2
        new failure (last pass: v6.1.64-cip10-rt5)

    2023-12-06T06:05:24.888563  /lava-313441/1/../bin/lava-test-case
    2023-12-06T06:05:24.922059  <8>[   24.449024] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/6570101a54e1c18d69e134c8

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/arm/omap2plus_defconfig/gcc-10/lab-cip/b=
aseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/arm/omap2plus_defconfig/gcc-10/lab-cip/b=
aseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/id/6=
570101a54e1c18d69e134e2
        new failure (last pass: v6.1.64-cip10-rt5)

    2023-12-06T06:09:22.895866  /lava-1052588/1/../bin/lava-test-case
    2023-12-06T06:09:22.936087  <8>[   17.978384] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65701773f1ccaeb4ece13479

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65701773f1ccaeb4ece13=
47a
        new failure (last pass: v6.1.62-cip9-12-g3a5321f469b07) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/6570190f72dad1efe2e1347c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6570190f72dad1efe2e13=
47d
        new failure (last pass: v6.1.64-cip10-rt5) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/65701050ab4a44383be134a3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/arm/imx_v6_v7_defconfig/gcc-10/lab-pengu=
tronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/arm/imx_v6_v7_defconfig/gcc-10/lab-pengu=
tronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65701050ab4a44383be134a8
        new failure (last pass: v6.1.64-cip10-rt5)

    2023-12-06T06:10:19.002789  + set +x
    2023-12-06T06:10:19.002937  [   10.347080] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1014817_1.5.2.3.1>
    2023-12-06T06:10:19.110287  / # #
    2023-12-06T06:10:19.211532  export SHELL=3D/bin/sh
    2023-12-06T06:10:19.211984  #
    2023-12-06T06:10:19.312736  / # export SHELL=3D/bin/sh. /lava-1014817/e=
nvironment
    2023-12-06T06:10:19.313144  =

    2023-12-06T06:10:19.413946  / # . /lava-1014817/environment/lava-101481=
7/bin/lava-test-runner /lava-1014817/1
    2023-12-06T06:10:19.414616  =

    2023-12-06T06:10:19.417307  / # /lava-1014817/bin/lava-test-runner /lav=
a-1014817/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/6570162d829121c671e13483

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/arm/multi_v7_defconfig/gcc-10/lab-pengut=
ronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/arm/multi_v7_defconfig/gcc-10/lab-pengut=
ronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6570162d829121c671e13488
        new failure (last pass: v6.1.64-cip10-rt5)

    2023-12-06T06:35:00.109996  + set[    7.342622] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 1014824_1.5.2.3.1>
    2023-12-06T06:35:00.110160   +x
    2023-12-06T06:35:00.215335  / # #
    2023-12-06T06:35:00.316518  export SHELL=3D/bin/sh
    2023-12-06T06:35:00.316967  #
    2023-12-06T06:35:00.417690  / # export SHELL=3D/bin/sh. /lava-1014824/e=
nvironment
    2023-12-06T06:35:00.418205  =

    2023-12-06T06:35:00.519122  / # . /lava-1014824/environment/lava-101482=
4/bin/lava-test-runner /lava-1014824/1
    2023-12-06T06:35:00.519967  =

    2023-12-06T06:35:00.522038  / # /lava-1014824/bin/lava-test-runner /lav=
a-1014824/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                  | 10         =


  Details:     https://kernelci.org/test/plan/id/6570116067f81c0529e13477

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.led7-probed: https://kernelci.org/test/case/id/65701160=
67f81c0529e13484
        new failure (last pass: v6.1.64-cip10-rt5)

    2023-12-06T06:14:43.812575  /lava-313489/1/../bin/lava-test-case
    2023-12-06T06:14:43.834552  <8>[   27.900310] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled7-probed RESULT=3Dfail>
    2023-12-06T06:14:43.835100  /lava-313489/1/../bin/lava-test-case   =


  * baseline.bootrr.led6-probed: https://kernelci.org/test/case/id/65701160=
67f81c0529e13485
        new failure (last pass: v6.1.64-cip10-rt5)

    2023-12-06T06:14:42.782491  /lava-313489/1/../bin/lava-test-case
    2023-12-06T06:14:42.805591  <8>[   26.870690] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled6-probed RESULT=3Dfail>   =


  * baseline.bootrr.led5-probed: https://kernelci.org/test/case/id/65701160=
67f81c0529e13486
        new failure (last pass: v6.1.64-cip10-rt5)

    2023-12-06T06:14:41.753492  /lava-313489/1/../bin/lava-test-case
    2023-12-06T06:14:41.775540  <8>[   25.840883] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled5-probed RESULT=3Dfail>   =


  * baseline.bootrr.led4-probed: https://kernelci.org/test/case/id/65701160=
67f81c0529e13487
        new failure (last pass: v6.1.64-cip10-rt5)

    2023-12-06T06:14:40.723615  /lava-313489/1/../bin/lava-test-case
    2023-12-06T06:14:40.746473  <8>[   24.812058] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled4-probed RESULT=3Dfail>   =


  * baseline.bootrr.led3-probed: https://kernelci.org/test/case/id/65701160=
67f81c0529e13488
        new failure (last pass: v6.1.64-cip10-rt5)

    2023-12-06T06:14:39.694463  /lava-313489/1/../bin/lava-test-case
    2023-12-06T06:14:39.717429  <8>[   23.782557] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled3-probed RESULT=3Dfail>   =


  * baseline.bootrr.led2-probed: https://kernelci.org/test/case/id/65701160=
67f81c0529e13489
        new failure (last pass: v6.1.64-cip10-rt5)

    2023-12-06T06:14:38.664333  /lava-313489/1/../bin/lava-test-case
    2023-12-06T06:14:38.687351  <8>[   22.752801] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled2-probed RESULT=3Dfail>   =


  * baseline.bootrr.led1-probed: https://kernelci.org/test/case/id/65701160=
67f81c0529e1348a
        new failure (last pass: v6.1.64-cip10-rt5)

    2023-12-06T06:14:37.635257  /lava-313489/1/../bin/lava-test-case
    2023-12-06T06:14:37.657315  <8>[   21.723022] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled1-probed RESULT=3Dfail>   =


  * baseline.bootrr.led0-probed: https://kernelci.org/test/case/id/65701160=
67f81c0529e1348b
        new failure (last pass: v6.1.64-cip10-rt5)

    2023-12-06T06:14:36.606182  /lava-313489/1/../bin/lava-test-case
    2023-12-06T06:14:36.628210  <8>[   20.693378] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled0-probed RESULT=3Dfail>   =


  * baseline.bootrr.iommu1-probed: https://kernelci.org/test/case/id/657011=
6067f81c0529e1349e
        new failure (last pass: v6.1.64-cip10-rt5)

    2023-12-06T06:14:35.147421  /lava-313489/1/../bin/lava-test-case
    2023-12-06T06:14:35.150651  <8>[   19.217366] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Diommu1-probed RESULT=3Dfail>   =


  * baseline.bootrr.1c050000_mmc-probed: https://kernelci.org/test/case/id/=
6570116067f81c0529e134ad
        new failure (last pass: v6.1.64-cip10-rt5)

    2023-12-06T06:14:33.797463  /lava-313489/1/../bin/lava-test-case
    2023-12-06T06:14:33.800737  <8>[   17.867793] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3D1c050000.mmc-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
kontron-kbox-a-230-ls        | arm64  | lab-kontron     | gcc-10   | defcon=
fig                  | 3          =


  Details:     https://kernelci.org/test/plan/id/657010cfe8bb351e86e134a8

  Results:     89 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-kontron-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-kontron-kbox-a-230-ls.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.layerscape-sfp-driver-present: https://kernelci.org/tes=
t/case/id/657010cfe8bb351e86e134d7
        new failure (last pass: v6.1.64-cip10-rt5)

    2023-12-06T06:12:23.211097  /lava-402289/1/../bin/lava-test-case
    2023-12-06T06:12:23.214396  <8>[   20.155817] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.rcpm-driver-present: https://kernelci.org/test/case/id/=
657010cfe8bb351e86e134ed
        new failure (last pass: v6.1.64-cip10-rt5)

    2023-12-06T06:12:18.752812  /lava-402289/1/../bin/lava-test-case
    2023-12-06T06:12:18.756106  <8>[   15.701970] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.ftm-alarm-driver-present: https://kernelci.org/test/cas=
e/id/657010cfe8bb351e86e134ee
        new failure (last pass: v6.1.64-cip10-rt5)

    2023-12-06T06:12:19.769020  /lava-402289/1/../bin/lava-test-case
    2023-12-06T06:12:19.772370  <8>[   16.719459] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2023-12-06T06:12:20.791445  /lava-402289/1/../bin/lava-test-case   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
kontron-sl28-var3-ads2       | arm64  | lab-kontron     | gcc-10   | defcon=
fig                  | 3          =


  Details:     https://kernelci.org/test/plan/id/657010d0023c820da2e13488

  Results:     97 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-kontron-sl28-var3-ads2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-kontron-sl28-var3-ads2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rcpm-driver-present: https://kernelci.org/test/case/id/=
657010d0023c820da2e134cf
        new failure (last pass: v6.1.64-cip10-rt5)

    2023-12-06T06:12:18.996857  /lava-402291/1/../bin/lava-test-case
    2023-12-06T06:12:19.000180  <8>[   11.136339] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.ftm-alarm-driver-present: https://kernelci.org/test/cas=
e/id/657010d0023c820da2e134d0
        new failure (last pass: v6.1.64-cip10-rt5)

    2023-12-06T06:12:20.009327  /lava-402291/1/../bin/lava-test-case
    2023-12-06T06:12:20.012596  <8>[   12.153798] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2023-12-06T06:12:21.030910  /lava-402291/1/../bin/lava-test-case   =


  * baseline.bootrr.layerscape-sfp-driver-present: https://kernelci.org/tes=
t/case/id/657010d1023c820da2e134e5
        new failure (last pass: v6.1.64-cip10-rt5)

    2023-12-06T06:12:23.445894  /lava-402291/1/../bin/lava-test-case
    2023-12-06T06:12:23.449173  <8>[   15.585588] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig                  | 1          =


  Details:     https://kernelci.org/test/plan/id/657012ef11149e7032e1347d

  Results:     51 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/657012ef1=
1149e7032e13480
        new failure (last pass: v6.1.64-cip10-rt5)

    2023-12-06T06:21:17.973671  /lava-313503/1/../bin/lava-test-case
    2023-12-06T06:21:17.983707  <8>[   18.867450] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
qemu_mips-malta              | mips   | lab-broonie     | gcc-10   | malta_=
defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/6570163e88c077a89ce13498

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/mips/malta_defconfig/gcc-10/lab-broonie/=
baseline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/mips/malta_defconfig/gcc-10/lab-broonie/=
baseline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6570163e88c077a89ce13=
499
        new failure (last pass: v6.1.64-cip10-rt5) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
qemu_mips-malta              | mips   | lab-collabora   | gcc-10   | malta_=
defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/657016258bd7e5268ae134a2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/mips/malta_defconfig/gcc-10/lab-collabor=
a/baseline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/mips/malta_defconfig/gcc-10/lab-collabor=
a/baseline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/657016258bd7e5268ae13=
4a3
        new failure (last pass: v6.1.64-cip10-rt5) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/657012a3cbb5cd2332e13478

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/arm/shmobile_defconfig/gcc-10/lab-cip/ba=
seline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/arm/shmobile_defconfig/gcc-10/lab-cip/ba=
seline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/657012a3cbb5cd2332e13=
479
        failing since 2 days (last pass: v6.1.62-cip9-12-g3a5321f469b07, fi=
rst fail: v6.1.64-cip10-rt5) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig         | 3          =


  Details:     https://kernelci.org/test/plan/id/6570164e88c077a89ce1349d

  Results:     63 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/arm/multi_v7_defconfig/gcc-10/lab-collab=
ora/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/arm/multi_v7_defconfig/gcc-10/lab-collab=
ora/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-iodomain-grf-probed: https://kernelci.org/test=
/case/id/6570164e88c077a89ce134b3
        new failure (last pass: v6.1.62-cip9-12-g3a5321f469b07)

    2023-12-06T06:43:09.261462  <8>[   21.211597] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-iodomain-driver-present RESULT=3Dpass>

    2023-12-06T06:43:10.272269  /lava-12195290/1/../bin/lava-test-case

    2023-12-06T06:43:10.281501  <8>[   22.232338] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-iodomain-grf-probed RESULT=3Dfail>
   =


  * baseline.bootrr.dwmmc_rockchip-sdio0-probed: https://kernelci.org/test/=
case/id/6570164e88c077a89ce134c9
        new failure (last pass: v6.1.62-cip9-12-g3a5321f469b07)

    2023-12-06T06:43:07.848199  <8>[   19.798831] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwmmc_rockchip-sdmmc-probed RESULT=3Dfail>

    2023-12-06T06:43:08.868895  /lava-12195290/1/../bin/lava-test-case<8>[ =
  20.819792] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwmmc_rockchip-sdio0-prob=
ed RESULT=3Dfail>
   =


  * baseline.bootrr.dwmmc_rockchip-sdmmc-probed: https://kernelci.org/test/=
case/id/6570164e88c077a89ce134ca
        new failure (last pass: v6.1.62-cip9-12-g3a5321f469b07)

    2023-12-06T06:43:06.827368  Print numbers from FI<8>[   18.778610] <LAV=
A_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwmmc_rockchip-driver-present RESULT=3Dpas=
s>

    2023-12-06T06:43:06.830225  RST to LAST, in steps of INC.

    2023-12-06T06:43:06.832410  FIRST, INC default to 1.

    2023-12-06T06:43:06.833085  =


    2023-12-06T06:43:06.836224  	-w	Pad to last with leading zeros

    2023-12-06T06:43:06.838684  	-s SEP	String separator

    2023-12-06T06:43:06.842670  /lava-12195290/1/../bin/lava-test-case

    2023-12-06T06:43:06.848883  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.

    2023-12-06T06:43:06.849278  =


    2023-12-06T06:43:06.853320  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST
 =

    ... (9 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                  | 5          =


  Details:     https://kernelci.org/test/plan/id/6570131ce8c66d09aae13482

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/6570131ce=
8c66d09aae13498
        new failure (last pass: v6.1.64-cip10-rt5)

    2023-12-06T06:21:57.822392  /lava-313490/1/../bin/lava-test-case
    2023-12-06T06:21:57.833163  <8>[   25.414566] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Di2s-probed RESULT=3Dblocked>
    2023-12-06T06:21:58.858818  /lava-313490/1/../bin/lava-test-case
    2023-12-06T06:21:58.869182  <8>[   26.450933] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>   =


  * baseline.bootrr.sun4i-i2s-driver-present: https://kernelci.org/test/cas=
e/id/6570131ce8c66d09aae13499
        new failure (last pass: v6.1.64-cip10-rt5)

    2023-12-06T06:21:55.747204  /lava-313490/1/../bin/lava-test-case
    2023-12-06T06:21:55.758595  <8>[   23.339344] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcodec-digital-probed RESULT=3Dblocked>
    2023-12-06T06:21:56.785240  /lava-313490/1/../bin/lava-test-case
    2023-12-06T06:21:56.795993  <8>[   24.377342] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun4i-i2s-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sun8i-codec-driver-present: https://kernelci.org/test/c=
ase/id/6570131ce8c66d09aae1349a
        new failure (last pass: v6.1.64-cip10-rt5)

    2023-12-06T06:21:53.673269  /lava-313490/1/../bin/lava-test-case
    2023-12-06T06:21:53.684648  <8>[   21.265597] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcodec-analog-probed RESULT=3Dblocked>
    2023-12-06T06:21:54.709467  /lava-313490/1/../bin/lava-test-case
    2023-12-06T06:21:54.722627  <8>[   22.301864] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8i-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sun50i-codec-analog-driver-present: https://kernelci.or=
g/test/case/id/6570131ce8c66d09aae1349b
        new failure (last pass: v6.1.64-cip10-rt5)

    2023-12-06T06:21:52.641877  /lava-313490/1/../bin/lava-test-case
    2023-12-06T06:21:52.653757  <8>[   20.234446] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun50i-codec-analog-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6570131ce8c66d09aae134ae
        new failure (last pass: v6.1.64-cip10-rt5)

    2023-12-06T06:21:49.488624  + set +x
    2023-12-06T06:21:49.492745  <8>[   17.075220] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 313490_1.5.2.4.1>
    2023-12-06T06:21:49.602556  / # #
    2023-12-06T06:21:49.704227  export SHELL=3D/bin/sh
    2023-12-06T06:21:49.704684  #
    2023-12-06T06:21:49.805946  / # export SHELL=3D/bin/sh. /lava-313490/en=
vironment
    2023-12-06T06:21:49.806551  =

    2023-12-06T06:21:49.908342  / # . /lava-313490/environment/lava-313490/=
bin/lava-test-runner /lava-313490/1
    2023-12-06T06:21:49.909133  =

    2023-12-06T06:21:49.913583  / # /lava-313490/bin/lava-test-runner /lava=
-313490/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig                  | 1          =


  Details:     https://kernelci.org/test/plan/id/657011d2e19b64fe5ae1347b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/arm64/defconfig/gcc-10/lab-cip/baseline-=
zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/arm64/defconfig/gcc-10/lab-cip/baseline-=
zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/657011d2e19b64fe5ae13=
47c
        new failure (last pass: v6.1.64-cip10-rt5) =

 =20

