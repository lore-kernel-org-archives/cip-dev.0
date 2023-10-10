Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC69CD80D5
	for <webhook@archiver.kernel.org>; Tue, 10 Oct 2023 13:43:19 +0000 (UTC)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
 by mx.groups.io with SMTP id smtpd.web11.91450.1696945395660528522
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 10 Oct 2023 06:43:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=Qc2+Rb+/;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.167.178, mailfrom: bot@kernelci.org)
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3af5fcb5e37so3925815b6e.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 10 Oct 2023 06:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696945394; x=1697550194; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KesNiIYbIAIPB45fW6WcqtOnnD7bhixqI7EUFR06gEg=;
        b=Qc2+Rb+/cgQFAelm/0hjEbj2PPxLrnHquIwIkvT7EyWbWi0JzzW0e3F6IYSpy2WVgT
         qcgVQYyPfkYZAQvOh6WVL5AwUUUUR7hdAJ7lCMPQ8TzdRTtitYM8Kd5bKleOdGw5FCOF
         tMJAWdzVxshVoIa89Y9XDlqi6Ca1qwD40YsfhALx/H3zF6k2gBv1hsdGjPkTz3XoJfjs
         KfU/2nZJkhc1ua9ATfiGp9YIe1DxWxTIUM+MxJ4abzvJuK2kSijfW6cCbHLxqfxKaxKe
         XOuxAU7qZPJ35k9UrFGcq5xVxrnDNQYOKAh5F1HX5v4miZmzSRAyDRiU49Dyp24Yyymq
         uEdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696945394; x=1697550194;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KesNiIYbIAIPB45fW6WcqtOnnD7bhixqI7EUFR06gEg=;
        b=fRoG3enA51jogQevDwcaGE9pBOKAd0rZKy7xPIJtY8knxMBX8RUMptsRrRh7EEAPqg
         hoVRomfh4vqI9DgKioGKcHOfl2vUf0E2FGdAgb/rvYiLl2RBWkmBeZzhZyGf6SbR4Wpg
         MTaE+wCqgpu2depDsb8QAVTaZ33Qb2G9wDGps9ZW1bOpx8QeJSEVQ/cHgH+0/naYc+/E
         1Vou+Aro0C01c7AEFo0hHMf5LWQB307pdDoGoTgYlyRJiYMsdG6IUESuRoeSB3NSrnE7
         bRxlbtgwdTlvpO+R+Q41cuwBaVmX1nl+Oh8aS/YqHvS9qvcXH65ZwvgZAJUFoTnWJbiQ
         L/yQ==
X-Gm-Message-State: AOJu0YywHYh3MrRYSBacbO2DcIIe+++J45K8QqbEtPama1djuzlJHpPZ
	O3bR86NbZw9CyrI5NtgFVJVl5gl7NaJy0CBKK6bbKQ==
X-Google-Smtp-Source: AGHT+IFLzPqqj08fF+NUZdw9liBuZ/ei3ytJY/56wPya9kpDC9xLaj21UDu7Ioq+G8o2KAuXs59t6Q==
X-Received: by 2002:a05:6808:21a2:b0:3ae:126b:8bfc with SMTP id be34-20020a05680821a200b003ae126b8bfcmr24024952oib.4.1696945393760;
        Tue, 10 Oct 2023 06:43:13 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id k2-20020a632402000000b005898e4acf2dsm8290256pgk.49.2023.10.10.06.43.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 06:43:12 -0700 (PDT)
Message-ID: <652554f0.630a0220.f370d.414a@mx.google.com>
Date: Tue, 10 Oct 2023 06:43:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.194-557-g2932db67f070a
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 42 runs,
 40 regressions (v5.10.194-557-g2932db67f070a)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Oct 2023 13:43:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13374

cip-gitlab/ci/pavel/linux-test baseline-nfs: 42 runs, 40 regressions (v5.10=
.194-557-g2932db67f070a)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cbv514-1h-34uz-brya     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | at91_dt_=
defconfig            | 1          =

at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 7          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 3          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =

imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | imx_v6_v=
7_defconfig          | 1          =

juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 11         =

kontron-kbox-a-230-ls        | arm64  | lab-kontron   | gcc-10   | defconfi=
g                    | 3          =

kontron-sl28-var3-ads2       | arm64  | lab-kontron   | gcc-10   | defconfi=
g                    | 3          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

mt8173-elm-hana              | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.194-557-g2932db67f070a/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.194-557-g2932db67f070a
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      2932db67f070a3c9076db35b5abbabb867b599cd =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cbv514-1h-34uz-brya     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65254e009203a1f501efcf20

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-557-g2932db67f070a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-nfs-acer-cbv514-1h-34uz-brya.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-557-g2932db67f070a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-nfs-acer-cbv514-1h-34uz-brya.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65254e009203a1f50=
1efcf21
        failing since 6 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | at91_dt_=
defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/65254ac3815418dcfeefcf2b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-557-g2932db67f070a/arm/at91_dt_defconfig/gcc-10/lab-broonie/base=
line-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-557-g2932db67f070a/arm/at91_dt_defconfig/gcc-10/lab-broonie/base=
line-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armel/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65254ac3815418dcf=
eefcf2c
        failing since 6 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65254ec0658a7c5da2efcf85

  Results:     47 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-557-g2932db67f070a/arm/multi_v5_defconfig/gcc-10/lab-broonie/bas=
eline-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-557-g2932db67f070a/arm/multi_v5_defconfig/gcc-10/lab-broonie/bas=
eline-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armel/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65254ec0658a7c5da2efcfbe
        failing since 0 day (last pass: v5.10.194-cip39-1-g53e59f50ca3ff, f=
irst fail: v5.10.194-cip39-552-gc89b2c57483f0)

    2023-10-10T13:16:16.309114  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 161003_1.6.2=
.4.1>
    2023-10-10T13:16:16.442324  #
    2023-10-10T13:16:16.545053  / # #export SHELL=3D/bin/sh
    2023-10-10T13:16:16.545826  =

    2023-10-10T13:16:16.647852  / # export SHELL=3D/bin/sh. /lava-161003/en=
vironment
    2023-10-10T13:16:16.648688  =

    2023-10-10T13:16:16.750652  / # . /lava-161003/environment/lava-161003/=
bin/lava-test-runner /lava-161003/1
    2023-10-10T13:16:16.751931  =

    2023-10-10T13:16:16.755853  / # /lava-161003/bin/lava-test-runner /lava=
-161003/1
    2023-10-10T13:16:17.151318  + export TESTRUN_ID=3D1_bootrr =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 7          =


  Details:     https://kernelci.org/test/plan/id/65254e353c800c67eeefcf6f

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-557-g2932db67f070a/arm/multi_v7_defconfig/gcc-10/lab-broonie/bas=
eline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-557-g2932db67f070a/arm/multi_v7_defconfig/gcc-10/lab-broonie/bas=
eline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.hdmi-audio: https://kernelci.org/test/case/id/65254=
e353c800c67eeefcf76
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T13:14:14.481087  /lava-161051/1/../bin/lava-test-case
    2023-10-10T13:14:14.532452  <8>[   82.015546] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/i=
d/65254e353c800c67eeefcf77
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T13:14:13.377030  /lava-161051/1/../bin/lava-test-case
    2023-10-10T13:14:13.432821  <8>[   80.915216] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-codec-driver-present: https://kernelci.org/tes=
t/case/id/65254e353c800c67eeefcf79
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T13:14:11.069129  /lava-161051/1/../bin/lava-test-case
    2023-10-10T13:14:11.128368  <8>[   78.610697] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-10-10T13:14:12.180619  /lava-161051/1/../bin/lava-test-case
    2023-10-10T13:14:12.235964  <8>[   79.717483] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case=
/id/65254e353c800c67eeefcf7a
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T13:14:08.856329  /lava-161051/1/../bin/lava-test-case
    2023-10-10T13:14:08.916805  <8>[   76.399040] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-10-10T13:14:09.963777  /lava-161051/1/../bin/lava-test-case
    2023-10-10T13:14:10.022664  <8>[   77.504675] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tda19988-driver-present: https://kernelci.org/test/=
case/id/65254e353c800c67eeefcf7b
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T13:14:06.634847  /lava-161051/1/../bin/lava-test-case
    2023-10-10T13:14:06.692359  <8>[   74.175026] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-10-10T13:14:07.737077  /lava-161051/1/../bin/lava-test-case
    2023-10-10T13:14:07.806339  <8>[   75.288101] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/65254e353c800c67eeefcf87
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T13:13:54.023552  /lava-161051/1/../bin/lava-test-case
    2023-10-10T13:13:54.078737  <8>[   61.560236] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65254e353c800c67eeefcfa0
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T13:13:46.873835  <8>[   54.357121] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 161051_1.6.2.4.1>
    2023-10-10T13:13:46.990933  / # #
    2023-10-10T13:13:47.093370  export SHELL=3D/bin/sh
    2023-10-10T13:13:47.094158  #
    2023-10-10T13:13:47.196057  / # export SHELL=3D/bin/sh. /lava-161051/en=
vironment
    2023-10-10T13:13:47.196599  =

    2023-10-10T13:13:47.299964  / # . /lava-161051/environment/lava-161051/=
bin/lava-test-runner /lava-161051/1
    2023-10-10T13:13:47.300914  =

    2023-10-10T13:13:47.304337  / # /lava-161051/bin/lava-test-runner /lava=
-161051/1
    2023-10-10T13:13:47.500921  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 3          =


  Details:     https://kernelci.org/test/plan/id/652551c5c033b36a80efcf31

  Results:     30 PASS, 11 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-557-g2932db67f070a/arm/multi_v7_defconfig/gcc-10/lab-cip/baselin=
e-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-557-g2932db67f070a/arm/multi_v7_defconfig/gcc-10/lab-cip/baselin=
e-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/652551c5c033b36a80efcf38
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T13:28:21.138845  + set +x
    2023-10-10T13:28:21.143025  <8>[   56.235358] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1018846_1.6.2.4.1>
    2023-10-10T13:28:21.400510  #
    2023-10-10T13:28:21.503016  / # #export SHELL=3D/bin/sh
    2023-10-10T13:28:21.503765  =

    2023-10-10T13:28:21.605254  / # export SHELL=3D/bin/sh. /lava-1018846/e=
nvironment
    2023-10-10T13:28:21.605996  =

    2023-10-10T13:28:21.707470  / # . /lava-1018846/environment/lava-101884=
6/bin/lava-test-runner /lava-1018846/1
    2023-10-10T13:28:21.708447  =

    2023-10-10T13:28:21.715236  / # /lava-1018846/bin/lava-test-runner /lav=
a-1018846/1 =

    ... (12 line(s) more)  =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/652551c5c033b36a80efcf51
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T13:28:49.210647  /lava-1018846/1/../bin/lava-test-case
    2023-10-10T13:28:49.893872  <8>[   84.986155] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tda19988-driver-present: https://kernelci.org/test/=
case/id/652551c5c033b36a80efcf5d
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T13:29:17.422543  /lava-1018846/1/../bin/lava-test-case
    2023-10-10T13:29:17.865405  <8>[  112.959461] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-10-10T13:29:18.921007  /lava-1018846/1/../bin/lava-test-case
    2023-10-10T13:29:19.431931  <8>[  114.526193] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/65254dec5bbfcaffb3efcf40

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-557-g2932db67f070a/arm/omap2plus_defconfig/gcc-10/lab-broonie/ba=
seline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-557-g2932db67f070a/arm/omap2plus_defconfig/gcc-10/lab-broonie/ba=
seline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/=
id/65254dec5bbfcaffb3efcf5d
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T13:12:59.613733  /lava-161037/1/../bin/lava-test-case
    2023-10-10T13:12:59.768433  <8>[   56.126277] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/65254df19897b5446befcf0f

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-557-g2932db67f070a/arm/omap2plus_defconfig/gcc-10/lab-cip/baseli=
ne-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-557-g2932db67f070a/arm/omap2plus_defconfig/gcc-10/lab-cip/baseli=
ne-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/=
id/65254df19897b5446befcf31
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T13:12:57.713040  /lava-1018837/1/../bin/lava-test-case
    2023-10-10T13:12:57.914911  <8>[   61.216355] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | imx_v6_v=
7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/65254eb4658a7c5da2efcf7f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-557-g2932db67f070a/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/ba=
seline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-557-g2932db67f070a/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/ba=
seline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65254eb4658a7c5da=
2efcf80
        failing since 48 days (last pass: v4.4-st20-3262-g667bb8d8b2cb, fir=
st fail: v6.1.45-cip3-31-gbae6b8e9a2cff) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 11         =


  Details:     https://kernelci.org/test/plan/id/6525526d062856bc5cefcf00

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-557-g2932db67f070a/arm64/defconfig/gcc-10/lab-broonie/baseline-n=
fs-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-557-g2932db67f070a/arm64/defconfig/gcc-10/lab-broonie/baseline-n=
fs-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.led7-probed: https://kernelci.org/test/case/id/6525=
526d062856bc5cefcf11
        failing since 6 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T13:32:19.388161  /lava-161119/1/../bin/lava-test-case
    2023-10-10T13:32:19.429204  <8>[   59.517703] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled7-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led6-probed: https://kernelci.org/test/case/id/6525=
526d062856bc5cefcf12
        failing since 6 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T13:32:18.306433  /lava-161119/1/../bin/lava-test-case
    2023-10-10T13:32:18.349235  <8>[   58.438289] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled6-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led5-probed: https://kernelci.org/test/case/id/6525=
526d062856bc5cefcf13
        failing since 6 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T13:32:17.221821  /lava-161119/1/../bin/lava-test-case
    2023-10-10T13:32:17.267686  <8>[   57.356505] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled5-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led4-probed: https://kernelci.org/test/case/id/6525=
526d062856bc5cefcf14
        failing since 6 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T13:32:16.143876  /lava-161119/1/../bin/lava-test-case
    2023-10-10T13:32:16.182847  <8>[   56.272215] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled4-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led3-probed: https://kernelci.org/test/case/id/6525=
526d062856bc5cefcf15
        failing since 6 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T13:32:15.066072  /lava-161119/1/../bin/lava-test-case
    2023-10-10T13:32:15.105045  <8>[   55.193997] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled3-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led2-probed: https://kernelci.org/test/case/id/6525=
526d062856bc5cefcf16
        failing since 6 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T13:32:13.983390  /lava-161119/1/../bin/lava-test-case
    2023-10-10T13:32:14.027369  <8>[   54.116019] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled2-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led1-probed: https://kernelci.org/test/case/id/6525=
526d062856bc5cefcf17
        failing since 6 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T13:32:12.905590  /lava-161119/1/../bin/lava-test-case
    2023-10-10T13:32:12.944539  <8>[   53.034033] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled1-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led0-probed: https://kernelci.org/test/case/id/6525=
526d062856bc5cefcf18
        failing since 6 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T13:32:11.827840  /lava-161119/1/../bin/lava-test-case
    2023-10-10T13:32:11.866803  <8>[   51.955619] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled0-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.iommu1-probed: https://kernelci.org/test/case/id/65=
25526d062856bc5cefcf2b
        failing since 6 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T13:32:09.635518  /lava-161119/1/../bin/lava-test-case
    2023-10-10T13:32:09.677178  <8>[   49.766075] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Diommu1-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.1c050000_mmc-probed: https://kernelci.org/test/case=
/id/6525526d062856bc5cefcf38
        failing since 6 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T13:32:07.761423  /lava-161119/1/../bin/lava-test-case
    2023-10-10T13:32:07.801407  <8>[   47.890520] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3D1c050000.mmc-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6525526d062856bc5cefcf3e
        failing since 110 days (last pass: v5.10.182-cip35-8-g2391124f19a70=
, first fail: v6.1.31-61-g32a95f5a4e3b)

    2023-10-10T13:32:04.518256  <8>[   44.609610] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 161119_1.6.2.4.1>
    2023-10-10T13:32:04.637165  / # #
    2023-10-10T13:32:04.738859  export SHELL=3D/bin/sh
    2023-10-10T13:32:04.739314  #
    2023-10-10T13:32:04.840431  / # export SHELL=3D/bin/sh. /lava-161119/en=
vironment
    2023-10-10T13:32:04.840875  =

    2023-10-10T13:32:04.942080  / # . /lava-161119/environment/lava-161119/=
bin/lava-test-runner /lava-161119/1
    2023-10-10T13:32:04.942789  =

    2023-10-10T13:32:04.949696  / # /lava-161119/bin/lava-test-runner /lava=
-161119/1
    2023-10-10T13:32:05.077480  + export TESTRUN_ID=3D1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
kontron-kbox-a-230-ls        | arm64  | lab-kontron   | gcc-10   | defconfi=
g                    | 3          =


  Details:     https://kernelci.org/test/plan/id/65254e85528810dd8cefcf07

  Results:     89 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-557-g2932db67f070a/arm64/defconfig/gcc-10/lab-kontron/baseline-n=
fs-kontron-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-557-g2932db67f070a/arm64/defconfig/gcc-10/lab-kontron/baseline-n=
fs-kontron-kbox-a-230-ls.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rcpm-driver-present: https://kernelci.org/test/case=
/id/65254e85528810dd8cefcf4b
        failing since 6 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T13:15:31.655256  /lava-384921/1/../bin/lava-test-case
    2023-10-10T13:15:31.676029  <8>[   19.809393] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.ftm-alarm-driver-present: https://kernelci.org/test=
/case/id/65254e85528810dd8cefcf4c
        failing since 6 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T13:15:32.697918  /lava-384921/1/../bin/lava-test-case
    2023-10-10T13:15:32.713799  <8>[   20.849604] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2023-10-10T13:15:33.745837  /lava-384921/1/../bin/lava-test-case
    2023-10-10T13:15:33.748953  <8>[   21.883280] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dftm-alarm-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.layerscape-sfp-driver-present: https://kernelci.org=
/test/case/id/65254e85528810dd8cefcf63
        failing since 6 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T13:15:36.494210  /lava-384921/1/../bin/lava-test-case
    2023-10-10T13:15:36.523126  <8>[   24.658247] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
kontron-sl28-var3-ads2       | arm64  | lab-kontron   | gcc-10   | defconfi=
g                    | 3          =


  Details:     https://kernelci.org/test/plan/id/65254ed5676331ef9cefcf21

  Results:     97 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-557-g2932db67f070a/arm64/defconfig/gcc-10/lab-kontron/baseline-n=
fs-kontron-sl28-var3-ads2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-557-g2932db67f070a/arm64/defconfig/gcc-10/lab-kontron/baseline-n=
fs-kontron-sl28-var3-ads2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rcpm-driver-present: https://kernelci.org/test/case=
/id/65254ed5676331ef9cefcf6c
        failing since 6 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T13:16:53.626602  /lava-384922/1/../bin/lava-test-case
    2023-10-10T13:16:53.647586  <8>[   16.661958] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.ftm-alarm-driver-present: https://kernelci.org/test=
/case/id/65254ed5676331ef9cefcf6d
        failing since 6 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T13:16:54.654966  /lava-384922/1/../bin/lava-test-case
    2023-10-10T13:16:54.683960  <8>[   17.698308] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2023-10-10T13:16:55.691480  /lava-384922/1/../bin/lava-test-case
    2023-10-10T13:16:55.721435  <8>[   18.735761] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dftm-alarm-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.layerscape-sfp-driver-present: https://kernelci.org=
/test/case/id/65254ed5676331ef9cefcf82
        failing since 6 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T13:16:58.566375  /lava-384922/1/../bin/lava-test-case
    2023-10-10T13:16:58.590373  <8>[   21.604322] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/65255104eb0f777513efcef3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-557-g2932db67f070a/arm64/defconfig/gcc-10/lab-broonie/baseline-n=
fs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-557-g2932db67f070a/arm64/defconfig/gcc-10/lab-broonie/baseline-n=
fs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65255104eb0f77751=
3efcef4
        new failure (last pass: v5.10.194-553-gd498c00818b88) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/65254ceac3b99ea6c8efcf00

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-557-g2932db67f070a/arm64/defconfig+arm64-chromebook/gcc-10/lab-c=
ollabora/baseline-nfs-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-557-g2932db67f070a/arm64/defconfig+arm64-chromebook/gcc-10/lab-c=
ollabora/baseline-nfs-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65254ceac3b99ea6c=
8efcf01
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/65254db52bb7231f7defcefc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-557-g2932db67f070a/arm64/defconfig+arm64-chromebook/gcc-10/lab-c=
ip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-557-g2932db67f070a/arm64/defconfig+arm64-chromebook/gcc-10/lab-c=
ip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65254db52bb7231f7=
defcefd
        failing since 18 days (last pass: v5.10.194-cip39-500-gc5c4e5fc1681=
7, first fail: v6.1.54-cip6-101-gb060fea6ba099) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6525535283d70a8d5cefcf02

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-557-g2932db67f070a/arm64/defconfig/gcc-10/lab-cip/baseline-nfs-r=
8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-557-g2932db67f070a/arm64/defconfig/gcc-10/lab-cip/baseline-nfs-r=
8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6525535283d70a8d5=
cefcf03
        failing since 55 days (last pass: v4.19.288-cip101-1117-g1f3468542a=
a9e, first fail: v5.10.186-cip37-16-gf8567732a40d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/65254cceedf089a7bcefcf0e

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-557-g2932db67f070a/arm64/defconfig+arm64-chromebook/gcc-10/lab-c=
ollabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-557-g2932db67f070a/arm64/defconfig+arm64-chromebook/gcc-10/lab-c=
ollabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/65254cceedf089a7bcefcf18
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T13:08:16.298313  <8>[   95.356177] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-10-10T13:08:17.338854  /lava-11724983/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/65254cceedf089a7bcefcf19
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T13:08:16.273073  /lava-11724983/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/65254e73528810dd8cefcef3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-557-g2932db67f070a/arm64/defconfig/gcc-10/lab-collabora/baseline=
-nfs-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-557-g2932db67f070a/arm64/defconfig/gcc-10/lab-collabora/baseline=
-nfs-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65254e73528810dd8cefcefc
        failing since 110 days (last pass: v5.10.182-cip35-8-g2391124f19a70=
, first fail: v6.1.31-61-g32a95f5a4e3b)

    2023-10-10T13:17:37.852953  / # #

    2023-10-10T13:17:39.113841  export SHELL=3D/bin/sh

    2023-10-10T13:17:39.124803  #

    2023-10-10T13:17:39.125304  / # export SHELL=3D/bin/sh

    2023-10-10T13:17:40.868963  / # . /lava-11725153/environment

    2023-10-10T13:17:44.075177  /lava-11725153/bin/lava-test-runner /lava-1=
1725153/1

    2023-10-10T13:17:44.086519  . /lava-11725153/environment

    2023-10-10T13:17:44.089720  / # /lava-11725153/bin/lava-test-runner /la=
va-11725153/1

    2023-10-10T13:17:44.265554  + export TESTRUN_ID=3D1_bootrr

    2023-10-10T13:17:44.265970  + cd /lava-11725153/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =20

