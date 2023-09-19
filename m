Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AACCE79A9
	for <webhook@archiver.kernel.org>; Tue, 19 Sep 2023 21:56:34 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web10.22866.1695160590290198704
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 19 Sep 2023 14:56:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=gnJ0rI9a;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.179, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1c0c6d4d650so55560185ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 19 Sep 2023 14:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695160589; x=1695765389; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9xiNof1Azgy1L1SntL76hFVC/BsewAUqiXmtu2UMt58=;
        b=gnJ0rI9arNjehP45ABL3QjH8lUZaE3MUQqTPkAwcpw8SlkDPljZrAgQDogxk7RtrWC
         P38oihbHnIDl3cpr6dCiIS9429JIiMhuE1mJuehPhA47JBFSZjlB02V6VbnfPWPikvD2
         M2KTXBeRzswr5ODa6D+3EOoz/xsN4z798aRMoqYUXI/EzPJMLTl2pXb5s6N2hWLQNyUi
         TdAgTPdToChncNjw456OalpxteFv5daBsd3bwp8ugPTJuvgqLb2CxHLsZzIHwnk98qRX
         I52ZzY1Fyt1vUNf+YOgFtFJhtgkLd1r2TFjpqO4OujjoombWDXrfTKaP/c39xuwTWlCs
         7BDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695160589; x=1695765389;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9xiNof1Azgy1L1SntL76hFVC/BsewAUqiXmtu2UMt58=;
        b=gIowUXh9WM6SOcuTYwxkK8Ha5qmfUsQxqcnqa4z/NMZX8oQ8ybAskaCyhOSDD0pGdI
         D6bjTz1Z74PxWP2PvsS/DDn/ti0DY0uNPUTvgQ0TD0ly6YqElMLR9HVgbsaptXhUPYiD
         nHo0m5ZDOQp4td22yx1cvFL3wLcLdQ0dh9f+wddX5+H/7kZmY7itnvyZR7LkPS45y8sC
         7NEBIjTdpdlHudCHvO/s9vmpENd00KaCEBW/huEKSIBUserH97IJvO15GsuE9jJdHT9e
         Wg5JvdIvA+yfYod+qaPk0TExjNYhgaEzBPVEyVtiG1r7VA/59DdzFMFLaHuIXEdvdqxA
         FPZA==
X-Gm-Message-State: AOJu0YweTsF2S49Gy+FGs/xlTkfoyMwg9v5RQ63b6/6T7CmKF9cvZXZC
	/VODId4vqEdmtafUMjYSJFz+qUD74fvi45/AAqPQjQ==
X-Google-Smtp-Source: AGHT+IEEg+DKMDlnOCeH4rFdeVAX+WBze5HW3DUf9VC2j1Go0XDyOJHjm5bmHztF0C/un5Ye6c3QeA==
X-Received: by 2002:a17:903:124d:b0:1bb:9c45:130f with SMTP id u13-20020a170903124d00b001bb9c45130fmr734144plh.69.1695160588166;
        Tue, 19 Sep 2023 14:56:28 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c9-20020a170903234900b001a5260a6e6csm10441510plh.206.2023.09.19.14.56.27
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 14:56:27 -0700 (PDT)
Message-ID: <650a190b.170a0220.dc17a.5c07@mx.google.com>
Date: Tue, 19 Sep 2023 14:56:27 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.194-cip39-500-gc5c4e5fc16817
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline: 119 runs,
 68 regressions (v5.10.194-cip39-500-gc5c4e5fc16817)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 19 Sep 2023 21:56:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13164

cip-gitlab/ci/pavel/linux-test baseline: 119 runs, 68 regressions (v5.10.19=
4-cip39-500-gc5c4e5fc16817)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cbv514-1h-34uz-brya     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | at91_d=
t_defconfig            | 3          =

at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig           | 1          =

bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | bcm283=
5_defconfig            | 1          =

bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 6          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig           | 7          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =

imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =

juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 10         =

kontron-kbox-a-230-ls        | arm64  | lab-kontron     | gcc-10   | defcon=
fig                    | 3          =

kontron-sl28-var3-ads2       | arm64  | lab-kontron     | gcc-10   | defcon=
fig                    | 3          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 2          =

mt8173-elm-hana              | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

qemu_mips-malta              | mips   | lab-broonie     | gcc-10   | malta_=
defconfig              | 1          =

qemu_mips-malta              | mips   | lab-collabora   | gcc-10   | malta_=
defconfig              | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 5          =

rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =

rk3399-rock-pi-4b            | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.194-cip39-500-gc5c4e5fc16817/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.194-cip39-500-gc5c4e5fc16817
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c5c4e5fc16817fa66c225fdaa51cf126889d5c5b =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cbv514-1h-34uz-brya     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/650a10b7974d5cd79c8a0a57

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/baseline-acer-cbv514-1h-34uz-brya.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/baseline-acer-cbv514-1h-34uz-brya.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650a10b7974d5cd79c8a0=
a58
        new failure (last pass: v6.1.52-cip5-29-g9fee06894d496) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | at91_d=
t_defconfig            | 3          =


  Details:     https://kernelci.org/test/plan/id/650a0975b46ecfe6c18a0a57

  Results:     49 PASS, 4 FAIL, 1 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm/at91_dt_defconfig/gcc-10/lab-brooni=
e/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm/at91_dt_defconfig/gcc-10/lab-brooni=
e/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.gpio-keys-probed: https://kernelci.org/test/case/id/650=
a0975b46ecfe6c18a0a60
        new failure (last pass: v6.1.52-cip5-29-g9fee06894d496)

    2023-09-19T20:49:33.319562  /lava-118822/1/../bin/lava-test-case
    2023-09-19T20:49:33.361327  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dgpi=
o-keys-probed RESULT=3Dfail>   =


  * baseline.bootrr.wm8731-driver-present: https://kernelci.org/test/case/i=
d/650a0975b46ecfe6c18a0a6b
        new failure (last pass: v6.1.52-cip5-29-g9fee06894d496)

    2023-09-19T20:49:29.116685  /lava-118822/1/../bin/lava-test-case
    2023-09-19T20:49:29.156618  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Deep=
rom-probed RESULT=3Dblocked>
    2023-09-19T20:49:29.198410  sh: /sys/bus/spi/drivers/wm8731: unknown op=
erand
    2023-09-19T20:49:30.218302  /lava-118822/1/../bin/lava-test-case
    2023-09-19T20:49:30.259927  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dwm8=
731-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.at24-driver-present: https://kernelci.org/test/case/id/=
650a0975b46ecfe6c18a0a82
        new failure (last pass: v6.1.52-cip5-29-g9fee06894d496)

    2023-09-19T20:49:28.015028  /lava-118822/1/../bin/lava-test-case
    2023-09-19T20:49:28.055620  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dat2=
4-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/650a0e893c0e057f278a0a4d

  Results:     48 PASS, 6 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm/multi_v5_defconfig/gcc-10/lab-broon=
ie/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm/multi_v5_defconfig/gcc-10/lab-broon=
ie/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.gpio-keys-probed: https://kernelci.org/test/case/id/650=
a0e893c0e057f278a0a56
        new failure (last pass: v6.1.52-cip5-29-g9fee06894d496)

    2023-09-19T21:11:25.776648  /lava-118880/1/../bin/lava-test-case
    2023-09-19T21:11:25.816648  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dgpi=
o-keys-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | bcm283=
5_defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/650a0fa7f387d358ba8a0a43

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm/bcm2835_defconfig/gcc-10/lab-collab=
ora/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm/bcm2835_defconfig/gcc-10/lab-collab=
ora/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650a0fa7f387d358ba8a0a4b
        failing since 34 days (last pass: v4.19.288-cip101-1117-g1f3468542a=
a9e, first fail: v5.10.186-cip37-16-gf8567732a40d)

    2023-09-19T21:20:37.783417  + set +x

    2023-09-19T21:20:37.784250  / # <8>[   10.751438] <LAVA_SIGNAL_TESTCASE=
 TEST_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-09-19T21:20:37.784498  <8>[   10.753653] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11574502_1.5.2.4.1>

    2023-09-19T21:20:37.888442  #

    2023-09-19T21:20:37.990453  export SHELL=3D/bin/sh

    2023-09-19T21:20:37.991153  #

    2023-09-19T21:20:38.092557  / # export SHELL=3D/bin/sh. /lava-11574502/=
environment

    2023-09-19T21:20:38.093256  =


    2023-09-19T21:20:38.194685  / # . /lava-11574502/environment/lava-11574=
502/bin/lava-test-runner /lava-11574502/1

    2023-09-19T21:20:38.195782  =

 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/650a0f2e380c37de8b8a0a68

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm/multi_v7_defconfig/gcc-10/lab-colla=
bora/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm/multi_v7_defconfig/gcc-10/lab-colla=
bora/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650a0f2e380c37de8b8a0=
a69
        failing since 34 days (last pass: v4.19.288-cip101-1117-g1f3468542a=
a9e, first fail: v5.10.186-cip37-16-gf8567732a40d) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 6          =


  Details:     https://kernelci.org/test/plan/id/650a0e6af840983da68a0b81

  Results:     30 PASS, 14 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/id/65=
0a0e6af840983da68a0b87
        new failure (last pass: v6.1.52-cip5-29-g9fee06894d496)

    2023-09-19T21:10:59.630320  /lava-118872/1/../bin/lava-test-case
    2023-09-19T21:10:59.674920  <8>[   47.647608] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-codec-driver-present: https://kernelci.org/test/ca=
se/id/650a0e6af840983da68a0b89
        new failure (last pass: v6.1.52-cip5-29-g9fee06894d496)

    2023-09-19T21:10:57.460199  /lava-118872/1/../bin/lava-test-case
    2023-09-19T21:10:57.495216  <8>[   45.476837] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-09-19T21:10:58.521305  /lava-118872/1/../bin/lava-test-case
    2023-09-19T21:10:58.557701  /opt/bootrr/libexec/bootrr/boards/ti,am335x=
-bone-black: line 84: assert_device-present: not found
    2023-09-19T21:10:58.563490  <8>[   46.537599] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case/id/=
650a0e6af840983da68a0b8a
        new failure (last pass: v6.1.52-cip5-29-g9fee06894d496)

    2023-09-19T21:10:55.332780  /lava-118872/1/../bin/lava-test-case
    2023-09-19T21:10:55.375499  <8>[   43.353926] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-09-19T21:10:56.398434  /lava-118872/1/../bin/lava-test-case
    2023-09-19T21:10:56.435492  <8>[   44.415492] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline.bootrr.tda19988-driver-present: https://kernelci.org/test/case=
/id/650a0e6af840983da68a0b8b
        new failure (last pass: v6.1.52-cip5-29-g9fee06894d496)

    2023-09-19T21:10:53.209407  /lava-118872/1/../bin/lava-test-case
    2023-09-19T21:10:53.245472  <8>[   41.226485] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-09-19T21:10:54.271299  /lava-118872/1/../bin/lava-test-case
    2023-09-19T21:10:54.315741  <8>[   42.287585] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/650a0e6af840983da68a0b97
        new failure (last pass: v6.1.52-cip5-29-g9fee06894d496)

    2023-09-19T21:10:41.280073  /lava-118872/1/../bin/lava-test-case
    2023-09-19T21:10:41.316917  <8>[   29.296115] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650a0e6af840983da68a0bb0
        new failure (last pass: v6.1.52-cip5-29-g9fee06894d496)

    2023-09-19T21:10:35.537786  + set +x
    2023-09-19T21:10:35.643413  / # <8>[   23.518205] <LAVA_S#
    2023-09-19T21:10:35.746119  export SHELL=3D/bin/sh
    2023-09-19T21:10:35.746848  IGNAL_TESTCASE TEST_CASE_ID=3Demerg RESULT=
=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-09-19T21:10:35.747340  <8>[   23.520167] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 118872_1.5.2.4.1>
    2023-09-19T21:10:35.747570  #
    2023-09-19T21:10:35.849739  / # export SHELL=3D/bin/sh. /lava-118872/en=
vironment
    2023-09-19T21:10:35.850465  =

    2023-09-19T21:10:35.952779  / # . /lava-118872/environment/lava-118872/=
bin/lava-test-runner /lava-118872/1
    2023-09-19T21:10:35.953911   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig           | 7          =


  Details:     https://kernelci.org/test/plan/id/650a0f5d8914b5f6df8a0a57

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm/multi_v7_defconfig/gcc-10/lab-cip/b=
aseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm/multi_v7_defconfig/gcc-10/lab-cip/b=
aseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650a0f5d8914b5f6df8a0a5e
        new failure (last pass: v6.1.52-cip5-29-g9fee06894d496)

    2023-09-19T21:14:21.891640  + set +x
    2023-09-19T21:14:21.999801  / # #
    2023-09-19T21:14:22.101690  export SHELL=3D/bin/sh
    2023-09-19T21:14:22.102152  <8>[   16.637634] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1010559_1.5.2.4.1>
    2023-09-19T21:14:22.102449  #
    2023-09-19T21:14:22.203838  / # export SHELL=3D/bin/sh. /lava-1010559/e=
nvironment
    2023-09-19T21:14:22.204301  =

    2023-09-19T21:14:22.305707  / # . /lava-1010559/environment/lava-101055=
9/bin/lava-test-runner /lava-1010559/1
    2023-09-19T21:14:22.306500  =

    2023-09-19T21:14:22.308546  / # /lava-1010559/bin/lava-test-runner /lav=
a-1010559/1 =

    ... (12 line(s) more)  =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/650a0f5d8914b5f6df8a0a77
        new failure (last pass: v6.1.52-cip5-29-g9fee06894d496)

    2023-09-19T21:14:27.636119  /lava-1010559/1/../bin/lava-test-case
    2023-09-19T21:14:27.670459  <8>[   22.404985] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.tda19988-driver-present: https://kernelci.org/test/case=
/id/650a0f5d8914b5f6df8a0a83
        new failure (last pass: v6.1.52-cip5-29-g9fee06894d496)

    2023-09-19T21:14:39.572766  /lava-1010559/1/../bin/lava-test-case
    2023-09-19T21:14:39.616470  <8>[   34.346820] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-09-19T21:14:40.633528  /lava-1010559/1/../bin/lava-test-case
    2023-09-19T21:14:40.677441  <8>[   35.406839] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case/id/=
650a0f5d8914b5f6df8a0a84
        new failure (last pass: v6.1.52-cip5-29-g9fee06894d496)

    2023-09-19T21:14:41.694584  /lava-1010559/1/../bin/lava-test-case
    2023-09-19T21:14:41.736861  <8>[   36.473050] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-09-19T21:14:42.759928  /lava-1010559/1/../bin/lava-test-case
    2023-09-19T21:14:42.797335  <8>[   37.534782] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-codec-driver-present: https://kernelci.org/test/ca=
se/id/650a0f5d8914b5f6df8a0a85
        new failure (last pass: v6.1.52-cip5-29-g9fee06894d496)

    2023-09-19T21:14:43.822032  /lava-1010559/1/../bin/lava-test-case
    2023-09-19T21:14:43.866523  <8>[   38.596652] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-09-19T21:14:44.883492  /lava-1010559/1/../bin/lava-test-case
    2023-09-19T21:14:44.921386  /opt/bootrr/libexec/bootrr/boards/ti,am335x=
-bone-black: line 84: assert_device-present: not found
    2023-09-19T21:14:44.928217  <8>[   39.657040] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/id/65=
0a0f5d8914b5f6df8a0a87
        new failure (last pass: v6.1.52-cip5-29-g9fee06894d496)

    2023-09-19T21:14:45.991856  /lava-1010559/1/../bin/lava-test-case
    2023-09-19T21:14:46.026716  <8>[   40.765882] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-audio: https://kernelci.org/test/case/id/650a0f5d8=
914b5f6df8a0a88
        new failure (last pass: v6.1.52-cip5-29-g9fee06894d496)

    2023-09-19T21:14:47.051647  /lava-1010559/1/../bin/lava-test-case
    2023-09-19T21:14:47.085820  <8>[   41.825803] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/650a0cc65e8cdff8288a0a46

  Results:     50 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm/omap2plus_defconfig/gcc-10/lab-broo=
nie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm/omap2plus_defconfig/gcc-10/lab-broo=
nie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/id/6=
50a0cc65e8cdff8288a0a64
        new failure (last pass: v6.1.52-cip5-29-g9fee06894d496)

    2023-09-19T21:03:54.994843  /lava-118845/1/../bin/lava-test-case
    2023-09-19T21:03:55.042188  <8>[   23.285535] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/650a0d7d64922c21ea8a0baf

  Results:     50 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm/omap2plus_defconfig/gcc-10/lab-cip/=
baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm/omap2plus_defconfig/gcc-10/lab-cip/=
baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/id/6=
50a0d7d64922c21ea8a0bd0
        new failure (last pass: v6.1.52-cip5-29-g9fee06894d496)

    2023-09-19T21:07:01.797779  /lava-1010526/1/../bin/lava-test-case
    2023-09-19T21:07:01.840333  <8>[   18.202308] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/650a0fac2dea84fbd78a0a5d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650a0fac2dea84fbd78a0a66
        failing since 34 days (last pass: v4.19.288-cip101-1117-g1f3468542a=
a9e, first fail: v5.10.186-cip37-16-gf8567732a40d)

    2023-09-19T21:16:15.403036  <8>[   10.#

    2023-09-19T21:16:15.404149  276275] <LAVA_SIGNAL_ENDRUN 0_dmesg 1157453=
3_1.4.2.3.1>

    2023-09-19T21:16:15.505976  / # #export SHELL=3D/bin/sh

    2023-09-19T21:16:15.506685  =


    2023-09-19T21:16:15.608123  / # export SHELL=3D/bin/sh. /lava-11574533/=
environment

    2023-09-19T21:16:15.608876  =


    2023-09-19T21:16:15.710515  / # . /lava-11574533/environment/lava-11574=
533/bin/lava-test-runner /lava-11574533/1

    2023-09-19T21:16:15.711655  =


    2023-09-19T21:16:15.717211  / # /lava-11574533/bin/lava-test-runner /la=
va-11574533/1

    2023-09-19T21:16:15.735371  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/650a0df4865ef88ed78a0a44

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm/imx_v6_v7_defconfig/gcc-10/lab-broo=
nie/baseline-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm/imx_v6_v7_defconfig/gcc-10/lab-broo=
nie/baseline-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650a0df4865ef88ed78a0=
a45
        failing since 28 days (last pass: v4.4-st20-3262-g667bb8d8b2cb, fir=
st fail: v6.1.45-cip3-31-gbae6b8e9a2cff) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/650a0f4886ab7866f38a0a42

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650a0f4886ab7866f38a0=
a43
        new failure (last pass: v6.1.52-cip5-29-g9fee06894d496) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/650a0df23532c372128a0a7d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm/imx_v6_v7_defconfig/gcc-10/lab-broo=
nie/baseline-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm/imx_v6_v7_defconfig/gcc-10/lab-broo=
nie/baseline-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650a0df23532c372128a0=
a7e
        failing since 28 days (last pass: v4.4-st20-3262-g667bb8d8b2cb, fir=
st fail: v6.1.45-cip3-31-gbae6b8e9a2cff) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/650a0f468914b5f6df8a0a50

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650a0f468914b5f6df8a0=
a51
        new failure (last pass: v6.1.52-cip5-29-g9fee06894d496) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/650a0cd6920036ece28a0a58

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm/imx_v6_v7_defconfig/gcc-10/lab-peng=
utronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm/imx_v6_v7_defconfig/gcc-10/lab-peng=
utronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650a0cd6920036ece28a0a60
        new failure (last pass: v6.1.52-cip5-29-g9fee06894d496)

    2023-09-19T21:04:12.987041  + set +x
    2023-09-19T21:04:13.102707  / # [    9.005972] <LAVA_SIGNAL_TESTCASE TE=
ST_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dl#
    2023-09-19T21:04:13.204893  export SHELL=3D/bin/sh
    2023-09-19T21:04:13.205429  ines MEASUREMENT=3D0>
    2023-09-19T21:04:13.205590  [    9.008502] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1001029_1.5.2.3.1>
    2023-09-19T21:04:13.205730  #
    2023-09-19T21:04:13.307167  / # export SHELL=3D/bin/sh. /lava-1001029/e=
nvironment
    2023-09-19T21:04:13.307752  =

    2023-09-19T21:04:13.409231  / # . /lava-1001029/environment/lava-100102=
9/bin/lava-test-runner /lava-1001029/1
    2023-09-19T21:04:13.409976   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/650a0e164c34a5adfe8a0a53

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm/multi_v7_defconfig/gcc-10/lab-pengu=
tronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm/multi_v7_defconfig/gcc-10/lab-pengu=
tronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650a0e164c34a5adfe8a0a5b
        new failure (last pass: v6.1.52-cip5-29-g9fee06894d496)

    2023-09-19T21:09:35.217713  + set +x
    2023-09-19T21:09:35.330151  / # [    7.192264] <LAVA_SIGNAL_TESTCASE TE=
ST_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dl#
    2023-09-19T21:09:35.431902  export SHELL=3D/bin/sh
    2023-09-19T21:09:35.432444  ines MEASUREMENT=3D0>
    2023-09-19T21:09:35.432624  [    7.193627] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1001032_1.5.2.3.1>
    2023-09-19T21:09:35.432769  #
    2023-09-19T21:09:35.534343  / # export SHELL=3D/bin/sh. /lava-1001032/e=
nvironment
    2023-09-19T21:09:35.535077  =

    2023-09-19T21:09:35.636744  / # . /lava-1001032/environment/lava-100103=
2/bin/lava-test-runner /lava-1001032/1
    2023-09-19T21:09:35.637687   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/650a0d3a64922c21ea8a0a43

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm/imx_v6_v7_defconfig/gcc-10/lab-nxp/=
baseline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm/imx_v6_v7_defconfig/gcc-10/lab-nxp/=
baseline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.all-cpus-are-online: https://kernelci.org/test/case/id/=
650a0d3a64922c21ea8a0a4a
        new failure (last pass: v6.1.52-cip5-29-g9fee06894d496)

    2023-09-19T21:05:50.842070  /lava-1252248/1/../bin/lava-test-case
    2023-09-19T21:05:50.880143  <8>[   31.540808] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dall-cpus-are-online RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/650a0e62f840983da68a0b74

  Results:     3 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm/multi_v7_defconfig/gcc-10/lab-nxp/b=
aseline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm/multi_v7_defconfig/gcc-10/lab-nxp/b=
aseline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.all-cpus-are-online: https://kernelci.org/test/case/id/=
650a0e62f840983da68a0b7b
        new failure (last pass: v6.1.52-cip5-29-g9fee06894d496)

    2023-09-19T21:10:39.737749  /lava-1252250/1/../bin/lava-test-case
    2023-09-19T21:10:39.768762  /lava-1252250/1/../bin/lava-test-<8>[   25.=
081804] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dall-cpus-are-online RESULT=3Df=
ail>
    2023-09-19T21:10:39.769074  case   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 10         =


  Details:     https://kernelci.org/test/plan/id/650a12fe2c7889173b8a0a5b

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm64/defconfig/gcc-10/lab-broonie/base=
line-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm64/defconfig/gcc-10/lab-broonie/base=
line-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.led7-probed: https://kernelci.org/test/case/id/650a12fe=
2c7889173b8a0a6c
        failing since 6 days (last pass: v6.1.46-cip4-14-gb994de8f45440, fi=
rst fail: v5.10.191-cip38-29-g9e1aa2001db86)

    2023-09-19T21:30:21.210676  /lava-118893/1/../bin/lava-test-case
    2023-09-19T21:30:21.211275  <8>[   39.173175] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled7-probed RESULT=3Dfail>
    2023-09-19T21:30:21.211705  /lava-118893/1/../bin/lava-test-case
    2023-09-19T21:30:21.212087  <8>[   39.190985] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dkmi-pl050-driver-present RESULT=3Dpass>   =


  * baseline.bootrr.led6-probed: https://kernelci.org/test/case/id/650a12fe=
2c7889173b8a0a6d
        failing since 6 days (last pass: v6.1.46-cip4-14-gb994de8f45440, fi=
rst fail: v5.10.191-cip38-29-g9e1aa2001db86)

    2023-09-19T21:30:20.125577  /lava-118893/1/../bin/lava-test-case
    2023-09-19T21:30:20.146480  <8>[   38.150518] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled6-probed RESULT=3Dfail>   =


  * baseline.bootrr.led5-probed: https://kernelci.org/test/case/id/650a12fe=
2c7889173b8a0a6e
        failing since 6 days (last pass: v6.1.46-cip4-14-gb994de8f45440, fi=
rst fail: v5.10.191-cip38-29-g9e1aa2001db86)

    2023-09-19T21:30:19.115437  /lava-118893/1/../bin/lava-test-case
    2023-09-19T21:30:19.118705  <8>[   37.128421] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled5-probed RESULT=3Dfail>   =


  * baseline.bootrr.led4-probed: https://kernelci.org/test/case/id/650a12fe=
2c7889173b8a0a6f
        failing since 6 days (last pass: v6.1.46-cip4-14-gb994de8f45440, fi=
rst fail: v5.10.191-cip38-29-g9e1aa2001db86)

    2023-09-19T21:30:18.081607  /lava-118893/1/../bin/lava-test-case
    2023-09-19T21:30:18.102468  <8>[   36.106458] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled4-probed RESULT=3Dfail>   =


  * baseline.bootrr.led3-probed: https://kernelci.org/test/case/id/650a12fe=
2c7889173b8a0a70
        failing since 6 days (last pass: v6.1.46-cip4-14-gb994de8f45440, fi=
rst fail: v5.10.191-cip38-29-g9e1aa2001db86)

    2023-09-19T21:30:17.071493  /lava-118893/1/../bin/lava-test-case
    2023-09-19T21:30:17.074753  <8>[   35.084371] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled3-probed RESULT=3Dfail>   =


  * baseline.bootrr.led2-probed: https://kernelci.org/test/case/id/650a12fe=
2c7889173b8a0a71
        failing since 6 days (last pass: v6.1.46-cip4-14-gb994de8f45440, fi=
rst fail: v5.10.191-cip38-29-g9e1aa2001db86)

    2023-09-19T21:30:16.037665  /lava-118893/1/../bin/lava-test-case
    2023-09-19T21:30:16.058615  <8>[   34.062000] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled2-probed RESULT=3Dfail>   =


  * baseline.bootrr.led1-probed: https://kernelci.org/test/case/id/650a12fe=
2c7889173b8a0a72
        failing since 6 days (last pass: v6.1.46-cip4-14-gb994de8f45440, fi=
rst fail: v5.10.191-cip38-29-g9e1aa2001db86)

    2023-09-19T21:30:15.027462  /lava-118893/1/../bin/lava-test-case
    2023-09-19T21:30:15.030626  <8>[   33.039983] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled1-probed RESULT=3Dfail>   =


  * baseline.bootrr.led0-probed: https://kernelci.org/test/case/id/650a12fe=
2c7889173b8a0a73
        failing since 6 days (last pass: v6.1.46-cip4-14-gb994de8f45440, fi=
rst fail: v5.10.191-cip38-29-g9e1aa2001db86)

    2023-09-19T21:30:14.008288  /lava-118893/1/../bin/lava-test-case
    2023-09-19T21:30:14.011540  <8>[   32.017538] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled0-probed RESULT=3Dfail>   =


  * baseline.bootrr.iommu1-probed: https://kernelci.org/test/case/id/650a12=
fe2c7889173b8a0a83
        failing since 6 days (last pass: v6.1.46-cip4-14-gb994de8f45440, fi=
rst fail: v5.10.191-cip38-29-g9e1aa2001db86)

    2023-09-19T21:30:12.709568  /lava-118893/1/../bin/lava-test-case
    2023-09-19T21:30:12.710222  <8>[   30.672159] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Diommu1-probed RESULT=3Dfail>   =


  * baseline.bootrr.1c050000_mmc-probed: https://kernelci.org/test/case/id/=
650a12fe2c7889173b8a0a90
        failing since 6 days (last pass: v6.1.46-cip4-14-gb994de8f45440, fi=
rst fail: v5.10.191-cip38-29-g9e1aa2001db86)

    2023-09-19T21:30:11.417602  /lava-118893/1/../bin/lava-test-case
    2023-09-19T21:30:11.418234  <8>[   29.421371] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3D1c050000.mmc-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
kontron-kbox-a-230-ls        | arm64  | lab-kontron     | gcc-10   | defcon=
fig                    | 3          =


  Details:     https://kernelci.org/test/plan/id/650a125a8d1bcdc0378a0a78

  Results:     89 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm64/defconfig/gcc-10/lab-kontron/base=
line-kontron-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm64/defconfig/gcc-10/lab-kontron/base=
line-kontron-kbox-a-230-ls.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rcpm-driver-present: https://kernelci.org/test/case/id/=
650a125a8d1bcdc0378a0abc
        failing since 6 days (last pass: v6.1.46-cip4-14-gb994de8f45440, fi=
rst fail: v5.10.191-cip38-29-g9e1aa2001db86)

    2023-09-19T21:27:30.758137  /lava-380660/1/../bin/lava-test-case
    2023-09-19T21:27:30.761380  <8>[   14.034626] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.ftm-alarm-driver-present: https://kernelci.org/test/cas=
e/id/650a125a8d1bcdc0378a0abd
        failing since 6 days (last pass: v6.1.46-cip4-14-gb994de8f45440, fi=
rst fail: v5.10.191-cip38-29-g9e1aa2001db86)

    2023-09-19T21:27:31.751104  /lava-380660/1/../bin/lava-test-case
    2023-09-19T21:27:31.772288  <8>[   15.045846] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2023-09-19T21:27:32.762314  /lava-380660/1/../bin/lava-test-case
    2023-09-19T21:27:32.782877  <8>[   16.057744] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dftm-alarm-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.layerscape-sfp-driver-present: https://kernelci.org/tes=
t/case/id/650a125b8d1bcdc0378a0ad4
        failing since 6 days (last pass: v6.1.46-cip4-14-gb994de8f45440, fi=
rst fail: v5.10.191-cip38-29-g9e1aa2001db86)

    2023-09-19T21:27:35.056608  /lava-380660/1/../bin/lava-test-case
    2023-09-19T21:27:35.078526  <8>[   18.354423] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
kontron-sl28-var3-ads2       | arm64  | lab-kontron     | gcc-10   | defcon=
fig                    | 3          =


  Details:     https://kernelci.org/test/plan/id/650a1246e0d720dd7a8a0a76

  Results:     97 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm64/defconfig/gcc-10/lab-kontron/base=
line-kontron-sl28-var3-ads2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm64/defconfig/gcc-10/lab-kontron/base=
line-kontron-sl28-var3-ads2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rcpm-driver-present: https://kernelci.org/test/case/id/=
650a1247e0d720dd7a8a0ac1
        failing since 6 days (last pass: v6.1.46-cip4-14-gb994de8f45440, fi=
rst fail: v5.10.191-cip38-29-g9e1aa2001db86)

    2023-09-19T21:27:23.820495  /lava-380659/1/../bin/lava-test-case
    2023-09-19T21:27:23.841660  <8>[   10.432127] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.ftm-alarm-driver-present: https://kernelci.org/test/cas=
e/id/650a1247e0d720dd7a8a0ac2
        failing since 6 days (last pass: v6.1.46-cip4-14-gb994de8f45440, fi=
rst fail: v5.10.191-cip38-29-g9e1aa2001db86)

    2023-09-19T21:27:24.833041  /lava-380659/1/../bin/lava-test-case
    2023-09-19T21:27:24.854177  <8>[   11.443258] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2023-09-19T21:27:25.845657  /lava-380659/1/../bin/lava-test-case
    2023-09-19T21:27:25.866589  <8>[   12.454776] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dftm-alarm-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.layerscape-sfp-driver-present: https://kernelci.org/tes=
t/case/id/650a1247e0d720dd7a8a0ad7
        failing since 6 days (last pass: v6.1.46-cip4-14-gb994de8f45440, fi=
rst fail: v5.10.191-cip38-29-g9e1aa2001db86)

    2023-09-19T21:27:28.139486  /lava-380659/1/../bin/lava-test-case
    2023-09-19T21:27:28.160660  <8>[   14.751984] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/650a0d6e15f3ab6c8b8a0a78

  Results:     49 PASS, 4 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-broonie/baseline-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-broonie/baseline-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/650a0d6e1=
5f3ab6c8b8a0a7e
        new failure (last pass: v6.1.46-cip4-14-gb994de8f45440)

    2023-09-19T21:05:47.224314  /lava-118861/1/../bin/lava-test-case
    2023-09-19T21:05:47.236736  <8>[   19.176058] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>
    2023-09-19T21:05:47.237242  + set +x   =


  * baseline.bootrr.cpufreq-probed: https://kernelci.org/test/case/id/650a0=
d6e15f3ab6c8b8a0aa5
        new failure (last pass: v6.1.46-cip4-14-gb994de8f45440)

    2023-09-19T21:05:45.612412  /lava-118861/1/../bin/lava-test-case
    2023-09-19T21:05:45.624680  <8>[   17.564201] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpufreq-probed RESULT=3Dfail>
    2023-09-19T21:05:45.625183  /lava-118861/1/../bin/lava-test-case   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 2          =


  Details:     https://kernelci.org/test/plan/id/650a1266b4087b17d58a0a44

  Results:     49 PASS, 4 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm64/defconfig/gcc-10/lab-broonie/base=
line-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm64/defconfig/gcc-10/lab-broonie/base=
line-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/650a1266b=
4087b17d58a0a4a
        failing since 6 days (last pass: v6.1.46-cip4-14-gb994de8f45440, fi=
rst fail: v5.10.191-cip38-29-g9e1aa2001db86)

    2023-09-19T21:27:59.704612  /lava-118899/1/../bin/lava-test-case
    2023-09-19T21:27:59.715817  <8>[   19.143608] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>
    2023-09-19T21:27:59.716321  + set +x   =


  * baseline.bootrr.cpufreq-probed: https://kernelci.org/test/case/id/650a1=
266b4087b17d58a0a6e
        new failure (last pass: v5.10.191-cip38-29-g9e1aa2001db86)

    2023-09-19T21:27:57.084080  <8>[   16.512014] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dscpi-cpufreq-driver-present RESULT=3Dpass>
    2023-09-19T21:27:58.092511  /lava-118899/1/../bin/lava-test-case
    2023-09-19T21:27:58.105470  <8>[   17.531465] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpufreq-probed RESULT=3Dfail>
    2023-09-19T21:27:58.105973  /lava-118899/1/../bin/lava-test-case   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/650a0d6615f3ab6c8b8a0a4d

  Results:     28 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/baseline-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/baseline-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650a0d6615f3ab6c8b8a0a6d
        new failure (last pass: v6.1.46-cip4-14-gb994de8f45440)

    2023-09-19T21:05:32.963480  <8>[   15.447358] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11574482_1.5.2.3.1>

    2023-09-19T21:05:33.067597  #

    2023-09-19T21:05:33.170347  / # #export SHELL=3D/bin/sh

    2023-09-19T21:05:33.171182  =


    2023-09-19T21:05:33.272963  / # export SHELL=3D/bin/sh. /lava-11574482/=
environment

    2023-09-19T21:05:33.273745  =


    2023-09-19T21:05:33.375365  / # . /lava-11574482/environment/lava-11574=
482/bin/lava-test-runner /lava-11574482/1

    2023-09-19T21:05:33.376647  =


    2023-09-19T21:05:33.378200  / # /lava-11574482/bin/lava-test-runner /la=
va-11574482/1

    2023-09-19T21:05:33.399548  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (20 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_mips-malta              | mips   | lab-broonie     | gcc-10   | malta_=
defconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/650a0c27f7660f187b8a0a6e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/mips/malta_defconfig/gcc-10/lab-broonie=
/baseline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/mips/malta_defconfig/gcc-10/lab-broonie=
/baseline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650a0c27f7660f187b8a0=
a6f
        new failure (last pass: v6.1.52-cip5-29-g9fee06894d496) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_mips-malta              | mips   | lab-collabora   | gcc-10   | malta_=
defconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/650a0c265341f61f0e8a0a5e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/mips/malta_defconfig/gcc-10/lab-collabo=
ra/baseline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/mips/malta_defconfig/gcc-10/lab-collabo=
ra/baseline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650a0c265341f61f0e8a0=
a5f
        new failure (last pass: v6.1.52-cip5-29-g9fee06894d496) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/650a0a2f11b3d1f7ef8a0a4a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm/shmobile_defconfig/gcc-10/lab-cip/b=
aseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm/shmobile_defconfig/gcc-10/lab-cip/b=
aseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650a0a2f11b3d1f7ef8a0=
a4b
        new failure (last pass: v6.1.52-cip5-29-g9fee06894d496) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/650a0d8b15f3ab6c8b8a0b1b

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650a0d8b15f3ab6c8b8a0b21
        failing since 20 days (last pass: v6.1.46-cip4-rt2, first fail: v5.=
10.191-cip38-2-g05fb42f86d06a)

    2023-09-19T21:07:02.286966  + set +x
    2023-09-19T21:07:02.301580  / # <8>[   83.717818] <LAVA_SIGNAL_TESTCASE=
 TEST_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-09-19T21:07:02.408402  #
    2023-09-19T21:07:03.872252  export SHELL=3D/bin/sh
    2023-09-19T21:07:03.893105  <8>[   83.719104] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1010530_1.5.2.4.1>
    2023-09-19T21:07:03.893541  #
    2023-09-19T21:07:03.893919  / # export SHELL=3D/bin/sh
    2023-09-19T21:07:05.850771  / # . /lava-1010530/environment
    2023-09-19T21:07:09.450275  /lava-1010530/bin/lava-test-runner /lava-10=
10530/1
    2023-09-19T21:07:09.472042  . /lava-1010530/environment =

    ... (29 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 5          =


  Details:     https://kernelci.org/test/plan/id/650a0e3ea6ef8adfe98a0a66

  Results:     61 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm/multi_v7_defconfig/gcc-10/lab-colla=
bora/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm/multi_v7_defconfig/gcc-10/lab-colla=
bora/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-iodomain-grf-probed: https://kernelci.org/test=
/case/id/650a0e3ea6ef8adfe98a0a7e
        new failure (last pass: v6.1.52-cip5-29-g9fee06894d496)

    2023-09-19T21:14:20.007052  <8>[   23.455900] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-iodomain-driver-present RESULT=3Dpass>

    2023-09-19T21:14:20.997050  /lava-11574493/1/../bin/lava-test-case
   =


  * baseline.bootrr.dwmmc_rockchip-sdio0-probed: https://kernelci.org/test/=
case/id/650a0e3ea6ef8adfe98a0a94
        new failure (last pass: v6.1.52-cip5-29-g9fee06894d496)

    2023-09-19T21:14:18.728937  <8>[   22.178102] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwmmc_rockchip-sdmmc-probed RESULT=3Dfail>

    2023-09-19T21:14:19.719261  /lava-11574493/1/../bin/lava-test-case

    2023-09-19T21:14:19.726673  /lava-11574493/1/../bin/lava-test-case

    2023-09-19T21:14:19.732863  /lava-11574493/1/../bin/lava-test-case
   =


  * baseline.bootrr.dwmmc_rockchip-sdmmc-probed: https://kernelci.org/test/=
case/id/650a0e3ea6ef8adfe98a0a95
        new failure (last pass: v6.1.52-cip5-29-g9fee06894d496)

    2023-09-19T21:14:17.727225  Busy<8>[   21.169170] <LAVA_SIGNAL_TESTCASE=
 TEST_CASE_ID=3Ddwmmc_rockchip-driver-present RESULT=3Dpass>

    2023-09-19T21:14:17.732974  Box v1.31.1 (2023-06-23 08:10:20 UTC) multi=
-call binary.

    2023-09-19T21:14:17.733049  =


    2023-09-19T21:14:17.737450  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-09-19T21:14:17.737692  =


    2023-09-19T21:14:17.742518  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-09-19T21:14:17.745248  FIRST, INC default to 1.

    2023-09-19T21:14:17.745304  =


    2023-09-19T21:14:17.748806  	-w	Pad to last with leading zeros

    2023-09-19T21:14:17.751474  	-s SEP	String separator
 =

    ... (13 line(s) more)  =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/650a0e3ea6ef8adfe98a0a98
        failing since 242 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-09-19T21:14:17.679571  ST

    2023-09-19T21:14:17.679946  =


    2023-09-19T21:14:17.684925  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/650a0e3ea6ef8adfe98a0a99
        failing since 242 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-09-19T21:14:17.662904  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC)<8=
>[   21.108924] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-probed=
 RESULT=3Dpass>

    2023-09-19T21:14:17.665103   multi-call binary.

    2023-09-19T21:14:17.665327  =


    2023-09-19T21:14:17.679195  Usage: seq [-w] [-s SEP] [FIRST [INC]] LA<8=
>[   21.122593] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>
   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/650a0d1f742cac6de88a0a52

  Results:     83 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/650a0d1f742cac6de88a0a5b
        new failure (last pass: v6.1.46-cip4-14-gb994de8f45440)

    2023-09-19T21:05:29.128180  <8>[   30.498104] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-09-19T21:05:30.132458  /lava-11574474/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/650a0d1f742cac6de88a0a5c
        new failure (last pass: v6.1.46-cip4-14-gb994de8f45440)

    2023-09-19T21:05:29.112124  /lava-11574474/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/650a128cb7764c1dad8a0ab0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm64/defconfig/gcc-10/lab-collabora/ba=
seline-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm64/defconfig/gcc-10/lab-collabora/ba=
seline-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650a128cb7764c1dad8a0ab9
        new failure (last pass: v5.10.191-cip38-29-g9e1aa2001db86)

    2023-09-19T21:28:27.637351  / # #

    2023-09-19T21:28:28.897753  export SHELL=3D/bin/sh

    2023-09-19T21:28:28.908651  #

    2023-09-19T21:28:28.909118  / # export SHELL=3D/bin/sh

    2023-09-19T21:28:30.652628  / # . /lava-11574569/environment

    2023-09-19T21:28:33.856453  /lava-11574569/bin/lava-test-runner /lava-1=
1574569/1

    2023-09-19T21:28:33.867897  . /lava-11574569/environment

    2023-09-19T21:28:33.871226  / # /lava-11574569/bin/lava-test-runner /la=
va-11574569/1

    2023-09-19T21:28:33.922076  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-19T21:28:33.922563  + cd /lava-11574569/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/650a1357edbb4d842c8a0a4f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm64/defconfig/gcc-10/lab-broonie/base=
line-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm64/defconfig/gcc-10/lab-broonie/base=
line-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650a1357edbb4d842c8a0=
a50
        new failure (last pass: v5.10.191-cip38-29-g9e1aa2001db86) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/650a1267b4087b17d58a0a81

  Results:     39 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm64/defconfig/gcc-10/lab-broonie/base=
line-sun50i-h5-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm64/defconfig/gcc-10/lab-broonie/base=
line-sun50i-h5-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.sun8-codec-analog-driver-present: https://kernelci.org/=
test/case/id/650a1267b4087b17d58a0aaa
        failing since 6 days (last pass: v6.1.46-cip4-14-gb994de8f45440, fi=
rst fail: v5.10.191-cip38-29-g9e1aa2001db86)

    2023-09-19T21:27:50.874846  /lava-118890/1/../bin/lava-test-case
    2023-09-19T21:27:50.894205  <8>[   19.363236] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8-codec-analog-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/650a0e099f29c753f98a0a4d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650a0e099f29c753f98a0=
a4e
        new failure (last pass: v6.1.46-cip4-14-gb994de8f45440) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/650a1359877a48efe48a0a43

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm64/defconfig/gcc-10/lab-cip/baseline=
-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm64/defconfig/gcc-10/lab-cip/baseline=
-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650a1359877a48efe48a0=
a44
        failing since 6 days (last pass: v6.1.46-cip4-14-gb994de8f45440, fi=
rst fail: v5.10.191-cip38-29-g9e1aa2001db86) =

 =20

