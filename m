Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2D7C4167B
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 12:57:56 +0000 (UTC)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
 by mx.groups.io with SMTP id smtpd.web10.83299.1701953872947724174
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 07 Dec 2023 04:57:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=EseSSW/J;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.41, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2865742e256so737671a91.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 07 Dec 2023 04:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701953872; x=1702558672; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gw9C8WBT51Vz8xh2ZT/GiDEIS0xZwtxQM1QiKLy5k+E=;
        b=EseSSW/Jkcb1pJA8ylils43M6Of2G0Toe8muX4z2oidEM9znyuLqXPxjPwMtJg+60Y
         yvrjn6JzdruIwo3bTr72jAvO229bSM2tKqtOijyQlOXdmIfUSODqgiXPiGa7Tt3OKEN7
         DAH6FYOIQs7GVo4l58yJPTQUH872z1APlmqRotF9CthoRB3sFiF0x2T4C2AvxT0Wrb/W
         hhpFiyan608QKKtVCjWDsX6U3/a/o9xoeNZW9azjqKG3wbqlaqCb68HSC2+hXXGcf6PZ
         1/+lwvi1lgyEJafiNYFNSpL3WOLoPOJfrH18KBrMJAiQx6KksWx3kKC53IA3vrBOLSh3
         3bgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701953872; x=1702558672;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gw9C8WBT51Vz8xh2ZT/GiDEIS0xZwtxQM1QiKLy5k+E=;
        b=J+fLbXmLv8goqKlrpdde72MpiZUPu6jpD45BZnRbefpY9aLWJ6QNtd+AOt1xhPkr6K
         KBXciCmDxYcizPJIgTmluaSS2gMEATwmuwon7wuy0GASaXhAswlXhIGQ3iUowO5ArKBN
         F307GeYlCtKTMaRmfALQWgl5jEHF1liHRwClRsZ8Pz+p/xYVP+CfSg3l7PQaERp0c1x7
         tNvaoiKGbI9TDOdzJ1UYa42dP4OuHn8LJqbY1LVI2EZQvU4yXfDXhM5U6EjBAHLZXaeU
         2YlUWInyMoUenEwMHzo2b0bLMBKyk0F6fA77VYemrYHoDaHGVCkG0LLDD3HzzIhH48WJ
         rgqg==
X-Gm-Message-State: AOJu0YwGr9ofBUqc0OtQbg8Shf0xeCkFkesPxvhhUvu3BbNwmKzK07YB
	uB9zMF/3a5RGDlu5YWSjOHQKaWotz1vY1ZPR9/xg/A==
X-Google-Smtp-Source: AGHT+IGQMLNDaKmxda9OjsLoEKVOe3eLoGV1we0vlPiaQIZubLSg5GgVpFUJ8E59raQoZyvXjcsmSQ==
X-Received: by 2002:a17:90b:1d11:b0:286:bd7a:9f7e with SMTP id on17-20020a17090b1d1100b00286bd7a9f7emr1772772pjb.29.1701953871079;
        Thu, 07 Dec 2023 04:57:51 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id sh6-20020a17090b524600b00285621515e9sm1267734pjb.15.2023.12.07.04.57.50
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 04:57:50 -0800 (PST)
Message-ID: <6571c14e.170a0220.b262e.271b@mx.google.com>
Date: Thu, 07 Dec 2023 04:57:50 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-28-g38e219eb6aa85
Subject: cip-gitlab/ci/pavel/linux-test baseline: 99 runs,
 48 regressions (v5.10.201-cip41-28-g38e219eb6aa85)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 12:57:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13831

cip-gitlab/ci/pavel/linux-test baseline: 99 runs, 48 regressions (v5.10.201=
-cip41-28-g38e219eb6aa85)

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

zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig                  | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.201-cip41-28-g38e219eb6aa85/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.201-cip41-28-g38e219eb6aa85
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      38e219eb6aa85cc3be6dec326b24dcf8cf438d01 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
acer-cbv514-1h-34uz-brya     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/6571b68305bb774fe2e1349c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-acer-cbv514-1h-34uz-brya.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-acer-cbv514-1h-34uz-brya.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6571b68305bb774fe2e13=
49d
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
acer-chromebox-cxi5-brask    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/6571b68c05bb774fe2e134a5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-acer-chromebox-cxi5-brask.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-acer-chromebox-cxi5-brask.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6571b68c05bb774fe2e13=
4a6
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | at91_d=
t_defconfig          | 3          =


  Details:     https://kernelci.org/test/plan/id/6571b61e35efb2dbace134b8

  Results:     49 PASS, 4 FAIL, 1 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/arm/at91_dt_defconfig/gcc-10/lab-broonie=
/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/arm/at91_dt_defconfig/gcc-10/lab-broonie=
/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.gpio-keys-probed: https://kernelci.org/test/case/id/657=
1b61e35efb2dbace134bd
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:09:48.069356  /lava-318116/1/../bin/lava-test-case
    2023-12-07T12:09:48.108082  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dgpi=
o-keys-probed RESULT=3Dfail>   =


  * baseline.bootrr.wm8731-driver-present: https://kernelci.org/test/case/i=
d/6571b61e35efb2dbace134c8
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:09:43.843083  /lava-318116/1/../bin/lava-test-case
    2023-12-07T12:09:43.881771  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Deep=
rom-probed RESULT=3Dblocked>
    2023-12-07T12:09:43.924624  sh: /sys/bus/spi/drivers/wm8731: unknown op=
erand
    2023-12-07T12:09:44.944532  /lava-318116/1/../bin/lava-test-case
    2023-12-07T12:09:44.983627  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dwm8=
731-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.at24-driver-present: https://kernelci.org/test/case/id/=
6571b61e35efb2dbace134c9
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:09:42.741558  /lava-318116/1/../bin/lava-test-case
    2023-12-07T12:09:42.781034  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dat2=
4-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig         | 7          =


  Details:     https://kernelci.org/test/plan/id/6571b5a4c5e11893d1e134b0

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.hdmi-audio: https://kernelci.org/test/case/id/6571b5a4c=
5e11893d1e134b3
        failing since 1 day (last pass: v6.1.62-cip9-12-g3a5321f469b07, fir=
st fail: v5.10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:07:57.327763  /lava-318092/1/../bin/lava-test-case
    2023-12-07T12:07:57.361675  <8>[   47.047497] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/id/65=
71b5a4c5e11893d1e134b4
        failing since 1 day (last pass: v6.1.62-cip9-12-g3a5321f469b07, fir=
st fail: v5.10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:07:56.264562  /lava-318092/1/../bin/lava-test-case
    2023-12-07T12:07:56.301818  <8>[   45.986359] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-codec-driver-present: https://kernelci.org/test/ca=
se/id/6571b5a4c5e11893d1e134b6
        failing since 1 day (last pass: v6.1.62-cip9-12-g3a5321f469b07, fir=
st fail: v5.10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:07:54.100152  /lava-318092/1/../bin/lava-test-case
    2023-12-07T12:07:54.133657  <8>[   43.818191] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-12-07T12:07:55.160340  /lava-318092/1/../bin/lava-test-case
    2023-12-07T12:07:55.190136  <8>[   44.873909] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case/id/=
6571b5a4c5e11893d1e134b7
        failing since 1 day (last pass: v6.1.62-cip9-12-g3a5321f469b07, fir=
st fail: v5.10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:07:51.980433  /lava-318092/1/../bin/lava-test-case
    2023-12-07T12:07:52.010040  <8>[   41.694143] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-12-07T12:07:53.038201  /lava-318092/1/../bin/lava-test-case
    2023-12-07T12:07:53.073323  <8>[   42.757619] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline.bootrr.tda19988-driver-present: https://kernelci.org/test/case=
/id/6571b5a4c5e11893d1e134b8
        failing since 1 day (last pass: v6.1.62-cip9-12-g3a5321f469b07, fir=
st fail: v5.10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:07:49.852173  /lava-318092/1/../bin/lava-test-case
    2023-12-07T12:07:49.890224  <8>[   39.575485] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-12-07T12:07:50.917658  /lava-318092/1/../bin/lava-test-case
    2023-12-07T12:07:50.954082  <8>[   40.637882] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/6571b5a4c5e11893d1e134c4
        failing since 1 day (last pass: v6.1.62-cip9-12-g3a5321f469b07, fir=
st fail: v5.10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:07:37.928545  /lava-318092/1/../bin/lava-test-case
    2023-12-07T12:07:37.965004  <8>[   27.648513] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6571b5a4c5e11893d1e134d9
        failing since 1 day (last pass: v6.1.62-cip9-12-g3a5321f469b07, fir=
st fail: v5.10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:07:32.200101  <8>[   21.884135] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 318092_1.5.2.4.1>
    2023-12-07T12:07:32.306592  / # #
    2023-12-07T12:07:32.408127  export SHELL=3D/bin/sh
    2023-12-07T12:07:32.408488  #
    2023-12-07T12:07:32.509661  / # export SHELL=3D/bin/sh. /lava-318092/en=
vironment
    2023-12-07T12:07:32.509978  =

    2023-12-07T12:07:32.611169  / # . /lava-318092/environment/lava-318092/=
bin/lava-test-runner /lava-318092/1
    2023-12-07T12:07:32.611792  =

    2023-12-07T12:07:32.616171  / # /lava-318092/bin/lava-test-runner /lava=
-318092/1
    2023-12-07T12:07:32.709837  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig         | 7          =


  Details:     https://kernelci.org/test/plan/id/6571bac5297c8bddc3e13478

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/arm/multi_v7_defconfig/gcc-10/lab-cip/ba=
seline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/arm/multi_v7_defconfig/gcc-10/lab-cip/ba=
seline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.hdmi-audio: https://kernelci.org/test/case/id/6571bac52=
97c8bddc3e1347b
        failing since 1 day (last pass: v6.1.62-cip9-12-g3a5321f469b07, fir=
st fail: v5.10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:29:35.428624  /lava-1053277/1/../bin/lava-test-case
    2023-12-07T12:29:35.462961  <8>[   41.797678] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/id/65=
71bac5297c8bddc3e1347c
        failing since 1 day (last pass: v6.1.62-cip9-12-g3a5321f469b07, fir=
st fail: v5.10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:29:34.366956  /lava-1053277/1/../bin/lava-test-case
    2023-12-07T12:29:34.402872  <8>[   40.736984] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-codec-driver-present: https://kernelci.org/test/ca=
se/id/6571bac5297c8bddc3e1347e
        failing since 1 day (last pass: v6.1.62-cip9-12-g3a5321f469b07, fir=
st fail: v5.10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:29:32.191727  /lava-1053277/1/../bin/lava-test-case
    2023-12-07T12:29:32.229952  <8>[   38.564174] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-12-07T12:29:33.256726  /lava-1053277/1/../bin/lava-test-case
    2023-12-07T12:29:33.294988  <8>[   39.626327] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case/id/=
6571bac5297c8bddc3e1347f
        failing since 1 day (last pass: v6.1.62-cip9-12-g3a5321f469b07, fir=
st fail: v5.10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:29:30.071114  /lava-1053277/1/../bin/lava-test-case
    2023-12-07T12:29:30.104923  <8>[   36.438860] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-12-07T12:29:31.131554  /lava-1053277/1/../bin/lava-test-case
    2023-12-07T12:29:31.165217  <8>[   37.499065] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline.bootrr.tda19988-driver-present: https://kernelci.org/test/case=
/id/6571bac5297c8bddc3e13480
        failing since 1 day (last pass: v6.1.62-cip9-12-g3a5321f469b07, fir=
st fail: v5.10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:29:27.947712  /lava-1053277/1/../bin/lava-test-case
    2023-12-07T12:29:27.982974  <8>[   34.316991] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-12-07T12:29:29.009335  /lava-1053277/1/../bin/lava-test-case
    2023-12-07T12:29:29.044057  <8>[   35.377522] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/6571bac5297c8bddc3e13487
        failing since 1 day (last pass: v6.1.62-cip9-12-g3a5321f469b07, fir=
st fail: v5.10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:29:15.998299  /lava-1053277/1/../bin/lava-test-case
    2023-12-07T12:29:16.034797  <8>[   22.367368] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6571bac5297c8bddc3e134a0
        failing since 1 day (last pass: v6.1.62-cip9-12-g3a5321f469b07, fir=
st fail: v5.10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:29:10.261519  <8>[   16.594630] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1053277_1.5.2.4.1>
    2023-12-07T12:29:10.368513  / # #
    2023-12-07T12:29:10.469887  export SHELL=3D/bin/sh
    2023-12-07T12:29:10.470342  #
    2023-12-07T12:29:10.571241  / # export SHELL=3D/bin/sh. /lava-1053277/e=
nvironment
    2023-12-07T12:29:10.571711  =

    2023-12-07T12:29:10.672651  / # . /lava-1053277/environment/lava-105327=
7/bin/lava-test-runner /lava-1053277/1
    2023-12-07T12:29:10.673365  =

    2023-12-07T12:29:10.677472  / # /lava-1053277/bin/lava-test-runner /lav=
a-1053277/1
    2023-12-07T12:29:10.768720  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/6571b61c35efb2dbace13475

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/arm/omap2plus_defconfig/gcc-10/lab-broon=
ie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/arm/omap2plus_defconfig/gcc-10/lab-broon=
ie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/id/6=
571b61c35efb2dbace13490
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:09:51.822610  /lava-318127/1/../bin/lava-test-case
    2023-12-07T12:09:51.860840  <8>[   23.888117] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/6571b67a05bb774fe2e13498

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6571b67a05bb774fe2e13=
499
        failing since 1 day (last pass: v6.1.62-cip9-12-g3a5321f469b07, fir=
st fail: v5.10.201-cip41-16-g3c85fba3b6e5d) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/6571b64d42c4338756e13488

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6571b64d42c4338756e13=
489
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/6571b891c6a74ac7e2e13475

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/arm/imx_v6_v7_defconfig/gcc-10/lab-pengu=
tronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/arm/imx_v6_v7_defconfig/gcc-10/lab-pengu=
tronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6571b891c6a74ac7e2e1347a
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:20:24.206504  + set +x
    2023-12-07T12:20:24.206698  [   10.309724] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1015288_1.5.2.3.1>
    2023-12-07T12:20:24.314091  / # #
    2023-12-07T12:20:24.415575  export SHELL=3D/bin/sh
    2023-12-07T12:20:24.416131  #
    2023-12-07T12:20:24.516983  / # export SHELL=3D/bin/sh. /lava-1015288/e=
nvironment
    2023-12-07T12:20:24.517505  =

    2023-12-07T12:20:24.618433  / # . /lava-1015288/environment/lava-101528=
8/bin/lava-test-runner /lava-1015288/1
    2023-12-07T12:20:24.619160  =

    2023-12-07T12:20:24.621927  / # /lava-1015288/bin/lava-test-runner /lav=
a-1015288/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/6571b46c830936290de1348a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/arm/multi_v7_defconfig/gcc-10/lab-pengut=
ronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/arm/multi_v7_defconfig/gcc-10/lab-pengut=
ronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6571b46c830936290de1348f
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:02:44.037011  + set[    7.251497] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 1015283_1.5.2.3.1>
    2023-12-07T12:02:44.037188   +x
    2023-12-07T12:02:44.142293  / # #
    2023-12-07T12:02:44.243489  export SHELL=3D/bin/sh
    2023-12-07T12:02:44.243999  #
    2023-12-07T12:02:44.344815  / # export SHELL=3D/bin/sh. /lava-1015283/e=
nvironment
    2023-12-07T12:02:44.345333  =

    2023-12-07T12:02:44.446150  / # . /lava-1015283/environment/lava-101528=
3/bin/lava-test-runner /lava-1015283/1
    2023-12-07T12:02:44.446770  =

    2023-12-07T12:02:44.448957  / # /lava-1015283/bin/lava-test-runner /lav=
a-1015283/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                  | 10         =


  Details:     https://kernelci.org/test/plan/id/6571bb83d78e023f2de13475

  Results:     51 PASS, 10 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.led7-probed: https://kernelci.org/test/case/id/6571bb83=
d78e023f2de13482
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:32:48.510499  /lava-318249/1/../bin/lava-test-case
    2023-12-07T12:32:48.532543  <8>[   25.775932] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled7-probed RESULT=3Dfail>
    2023-12-07T12:32:48.533146  /lava-318249/1/../bin/lava-test-case   =


  * baseline.bootrr.led6-probed: https://kernelci.org/test/case/id/6571bb83=
d78e023f2de13483
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:32:47.481423  /lava-318249/1/../bin/lava-test-case
    2023-12-07T12:32:47.503429  <8>[   24.746952] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled6-probed RESULT=3Dfail>   =


  * baseline.bootrr.led5-probed: https://kernelci.org/test/case/id/6571bb83=
d78e023f2de13484
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:32:46.452452  /lava-318249/1/../bin/lava-test-case
    2023-12-07T12:32:46.474417  <8>[   23.717959] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled5-probed RESULT=3Dfail>   =


  * baseline.bootrr.led4-probed: https://kernelci.org/test/case/id/6571bb83=
d78e023f2de13485
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:32:45.422383  /lava-318249/1/../bin/lava-test-case
    2023-12-07T12:32:45.445362  <8>[   22.688511] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled4-probed RESULT=3Dfail>   =


  * baseline.bootrr.led3-probed: https://kernelci.org/test/case/id/6571bb83=
d78e023f2de13486
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:32:44.393249  /lava-318249/1/../bin/lava-test-case
    2023-12-07T12:32:44.415291  <8>[   21.659113] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled3-probed RESULT=3Dfail>   =


  * baseline.bootrr.led2-probed: https://kernelci.org/test/case/id/6571bb83=
d78e023f2de13487
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:32:43.363151  /lava-318249/1/../bin/lava-test-case
    2023-12-07T12:32:43.386166  <8>[   20.629630] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled2-probed RESULT=3Dfail>   =


  * baseline.bootrr.led1-probed: https://kernelci.org/test/case/id/6571bb83=
d78e023f2de13488
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:32:42.334134  /lava-318249/1/../bin/lava-test-case
    2023-12-07T12:32:42.356152  <8>[   19.599767] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled1-probed RESULT=3Dfail>   =


  * baseline.bootrr.led0-probed: https://kernelci.org/test/case/id/6571bb83=
d78e023f2de13489
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:32:40.810690  <6>[   18.043689] input: PS/2 Generic Mouse=
 as /devices/platform/bus@8000000/bus@8000000:motherboard-bus/bus@8000000:m=
otherboard-bus:iofpga-bus@300000000/1c070000.kmi/serio1/input/input4
    2023-12-07T12:32:40.922397  <4>[   18.169383] psmouse serio1: Failed to=
 enable mouse on 1c070000.kmi
    2023-12-07T12:32:41.306093  /lava-318249/1/../bin/lava-test-case
    2023-12-07T12:32:41.327159  <8>[   18.570293] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled0-probed RESULT=3Dfail>   =


  * baseline.bootrr.iommu1-probed: https://kernelci.org/test/case/id/6571bb=
83d78e023f2de1349c
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:32:39.849264  /lava-318249/1/../bin/lava-test-case
    2023-12-07T12:32:39.852522  <8>[   17.096564] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Diommu1-probed RESULT=3Dfail>   =


  * baseline.bootrr.1c050000_mmc-probed: https://kernelci.org/test/case/id/=
6571bb83d78e023f2de134a9
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:32:38.492542  /lava-318249/1/../bin/lava-test-case
    2023-12-07T12:32:38.513455  <8>[   15.758152] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3D1c050000.mmc-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
kontron-kbox-a-230-ls        | arm64  | lab-kontron     | gcc-10   | defcon=
fig                  | 3          =


  Details:     https://kernelci.org/test/plan/id/6571baa2606f3f141ee13483

  Results:     89 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-kontron-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-kontron-kbox-a-230-ls.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rcpm-driver-present: https://kernelci.org/test/case/id/=
6571baa2606f3f141ee134c3
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:29:11.291391  /lava-402918/1/../bin/lava-test-case
    2023-12-07T12:29:11.294685  <8>[   14.422594] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.ftm-alarm-driver-present: https://kernelci.org/test/cas=
e/id/6571baa2606f3f141ee134c4
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:29:12.303101  /lava-402918/1/../bin/lava-test-case
    2023-12-07T12:29:12.306208  <8>[   15.439887] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2023-12-07T12:29:13.325992  /lava-402918/1/../bin/lava-test-case   =


  * baseline.bootrr.layerscape-sfp-driver-present: https://kernelci.org/tes=
t/case/id/6571baa2606f3f141ee134db
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:29:15.747805  /lava-402918/1/../bin/lava-test-case
    2023-12-07T12:29:15.751188  <8>[   18.878633] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
kontron-sl28-var3-ads2       | arm64  | lab-kontron     | gcc-10   | defcon=
fig                  | 3          =


  Details:     https://kernelci.org/test/plan/id/6571ba90eb32583db3e1349a

  Results:     97 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-kontron-sl28-var3-ads2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-kontron-sl28-var3-ads2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rcpm-driver-present: https://kernelci.org/test/case/id/=
6571ba90eb32583db3e134e1
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:28:51.019995  /lava-402917/1/../bin/lava-test-case
    2023-12-07T12:28:51.023280  <8>[   11.083988] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.ftm-alarm-driver-present: https://kernelci.org/test/cas=
e/id/6571ba90eb32583db3e134e2
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:28:52.032135  /lava-402917/1/../bin/lava-test-case
    2023-12-07T12:28:52.034804  <8>[   12.101592] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2023-12-07T12:28:53.054450  /lava-402917/1/../bin/lava-test-case   =


  * baseline.bootrr.layerscape-sfp-driver-present: https://kernelci.org/tes=
t/case/id/6571ba90eb32583db3e134f7
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:28:55.482910  /lava-402917/1/../bin/lava-test-case
    2023-12-07T12:28:55.486135  <8>[   15.546609] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6571bb4383d8a1d41de1347b

  Results:     51 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/6571bb438=
3d8a1d41de1347e
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:31:42.350987  /lava-318237/1/../bin/lava-test-case
    2023-12-07T12:31:42.362279  <8>[   19.206827] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>
    2023-12-07T12:31:42.362626  + set +x   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
qemu_mips-malta              | mips   | lab-broonie     | gcc-10   | malta_=
defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/6571b2bf26b4bd31ffe13486

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/mips/malta_defconfig/gcc-10/lab-broonie/=
baseline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/mips/malta_defconfig/gcc-10/lab-broonie/=
baseline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6571b2bf26b4bd31ffe13=
487
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
qemu_mips-malta              | mips   | lab-collabora   | gcc-10   | malta_=
defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/6571b288d025460a23e1348c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/mips/malta_defconfig/gcc-10/lab-collabor=
a/baseline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/mips/malta_defconfig/gcc-10/lab-collabor=
a/baseline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6571b288d025460a23e13=
48d
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/6571b2e0d4b92ad399e13487

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/arm/shmobile_defconfig/gcc-10/lab-cip/ba=
seline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/arm/shmobile_defconfig/gcc-10/lab-cip/ba=
seline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6571b2e0d4b92ad399e13=
488
        failing since 3 days (last pass: v6.1.62-cip9-12-g3a5321f469b07, fi=
rst fail: v6.1.64-cip10-rt5) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig         | 3          =


  Details:     https://kernelci.org/test/plan/id/6571b489830936290de134aa

  Results:     63 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/arm/multi_v7_defconfig/gcc-10/lab-collab=
ora/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/arm/multi_v7_defconfig/gcc-10/lab-collab=
ora/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-iodomain-grf-probed: https://kernelci.org/test=
/case/id/6571b489830936290de134c0
        failing since 1 day (last pass: v6.1.62-cip9-12-g3a5321f469b07, fir=
st fail: v5.10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:10:39.994668  <8>[   21.035687] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-iodomain-driver-present RESULT=3Dpass>

    2023-12-07T12:10:41.014725  /lava-12207016/1/../bin/lava-test-case<8>[ =
  22.056620] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Drockchip-iodomain-grf-pro=
bed RESULT=3Dfail>
   =


  * baseline.bootrr.dwmmc_rockchip-sdio0-probed: https://kernelci.org/test/=
case/id/6571b489830936290de134d6
        failing since 1 day (last pass: v6.1.62-cip9-12-g3a5321f469b07, fir=
st fail: v5.10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:10:38.582170  /lava-12207016/1/../bin/lava-test-case<8>[ =
  19.623650] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwmmc_rockchip-sdmmc-prob=
ed RESULT=3Dfail>

    2023-12-07T12:10:38.582232  =


    2023-12-07T12:10:39.593335  /lava-12207016/1/../bin/lava-test-case
   =


  * baseline.bootrr.dwmmc_rockchip-sdmmc-probed: https://kernelci.org/test/=
case/id/6571b489830936290de134d7
        failing since 1 day (last pass: v6.1.62-cip9-12-g3a5321f469b07, fir=
st fail: v5.10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:10:37.561360  	-w	P<8>[   18.599110] <LAVA_SIGNAL_TESTCAS=
E TEST_CASE_ID=3Ddwmmc_rockchip-driver-present RESULT=3Dpass>

    2023-12-07T12:10:37.563980  ad to last with leading zeros

    2023-12-07T12:10:37.566696  	-s SEP	String separator

    2023-12-07T12:10:37.570838  /lava-12207016/1/../bin/lava-test-case

    2023-12-07T12:10:37.576455  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.

    2023-12-07T12:10:37.576833  =


    2023-12-07T12:10:37.581239  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-12-07T12:10:37.581291  =


    2023-12-07T12:10:37.586243  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-12-07T12:10:37.588921  FIRST, INC default to 1.
 =

    ... (5 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6571bb8ccf52a2e661e13520

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/arm64/defconfig/gcc-10/lab-cip/baseline-=
zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/arm64/defconfig/gcc-10/lab-cip/baseline-=
zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6571bb8ccf52a2e661e13=
521
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d) =

 =20

