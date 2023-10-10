Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A56CD80A6
	for <webhook@archiver.kernel.org>; Tue, 10 Oct 2023 11:07:07 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web11.88283.1696936025713334340
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 10 Oct 2023 04:07:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=akkVX1ly;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1c5bf7871dcso40329795ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 10 Oct 2023 04:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696936025; x=1697540825; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=H3t0peS3PEmbzMX41p6hi9IypQp68uRuSWMnfI2eb3s=;
        b=akkVX1lyIqL0UsymDN6XLu0Ix3WhzDpnrp1lbm+eIjNO5mqYnN+VTv0O6TUbdHW8qS
         aVRZRrO/OQJxSconpKPb+CUUp8Yr1k13HH28hdFCudaFAhWZCFdMfpQXwkYNzY71qzkj
         3nVC7aqyaguWYJdgYSKihCSokD+N9a38CyHpHlSQJKyfL9TjyIsMNSgILKoygauYk4p2
         zkuM7QP27u+geFDkGVPYAbluAmPOrLoMJllKiN0U6u+LhKBOl5Has+hQbgDU1J4xQ/1O
         IcceWRChEyExhZ25f8Fj9gek9WKlfnX3OQ5CGkWEOv7BDcrsLdwGJCYE47JpDpN1xKVs
         a7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696936025; x=1697540825;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H3t0peS3PEmbzMX41p6hi9IypQp68uRuSWMnfI2eb3s=;
        b=Gs6XJL4ZjsHCzzoGymsVQbDkbWjcTvTvXej6Aitdzul9ckwNrauCc7QK3kTH9SVY2n
         6bibIC3uelrEs9SSkseQbck6kzX67i8yB0Mmwt1X2ZcJxUYTpMEKpWH3vXaor5ePT2J4
         hgMns7SBwJ7mEwrwAJfw8CdE2G6il0/4rJbofPSKa3eOwACOXY/ukEbxjnsjxa0msc/S
         VcPZZXUb4/88Cfk8RXFQiqnU5o7tUV72VhqJi7j8tGmrFT6XQxqESBsH31TXoKkbr42z
         sEYdFtcbwF/canYXaDuCP+U9AGSKvPAmVvicZOb+hAZ7LmFJmLbnQJodGpjwMRCc15d0
         v71w==
X-Gm-Message-State: AOJu0YxpLX60ajXcm/Go6IRTGZSVHWlqfa+9nBR4uCyozsmnLjrJD07n
	PwENW1RLWxE5861IgDMrTjkC2+jmjvb+WWXEC4Pw2A==
X-Google-Smtp-Source: AGHT+IFWwuOCl//KFlqe2EEZIEuxg7cq5azceZAeEhYVq/cDB6wmU9ooRj7xC+ckZnUIbEwDMCvR7w==
X-Received: by 2002:a17:902:9307:b0:1c4:172b:2f7c with SMTP id bc7-20020a170902930700b001c4172b2f7cmr13700895plb.0.1696936023603;
        Tue, 10 Oct 2023 04:07:03 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id v2-20020a170902d68200b001c1f161949fsm950689ply.96.2023.10.10.04.07.02
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 04:07:02 -0700 (PDT)
Message-ID: <65253056.170a0220.2a297.13c0@mx.google.com>
Date: Tue, 10 Oct 2023 04:07:02 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.194-cip39-552-gc89b2c57483f0
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 49 runs,
 54 regressions (v5.10.194-cip39-552-gc89b2c57483f0)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Oct 2023 11:07:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13351

cip-gitlab/ci/pavel/linux-test baseline-nfs: 49 runs, 54 regressions (v5.10=
.194-cip39-552-gc89b2c57483f0)

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
_defconfig           | 7          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =

imx6dl-udoo                  | arm    | lab-broonie   | gcc-10   | imx_v6_v=
7_defconfig          | 1          =

imx6dl-udoo                  | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | imx_v6_v=
7_defconfig          | 1          =

imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 11         =

kontron-kbox-a-230-ls        | arm64  | lab-kontron   | gcc-10   | defconfi=
g                    | 3          =

kontron-sl28-var3-ads2       | arm64  | lab-kontron   | gcc-10   | defconfi=
g                    | 3          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

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

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 5          =

sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.194-cip39-552-gc89b2c57483f0/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.194-cip39-552-gc89b2c57483f0
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c89b2c57483f0aae7f9cb377230347592eb3520f =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cbv514-1h-34uz-brya     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6525230665bba91905efcefb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/baseline-nfs-acer-cbv514-1h-34uz-brya.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/baseline-nfs-acer-cbv514-1h-34uz-brya.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6525230665bba9190=
5efcefc
        failing since 5 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | at91_dt_=
defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/65252565533e53c66cefcf0b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm/at91_dt_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm/at91_dt_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armel/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65252565533e53c66=
cefcf0c
        failing since 5 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/652526ba78157e9f6fefcf09

  Results:     47 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm/multi_v5_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm/multi_v5_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armel/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/652526ba78157e9f6fefcf40
        new failure (last pass: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:25:32.457360  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 160391_1.6.2=
.4.1>
    2023-10-10T10:25:32.581519  #
    2023-10-10T10:25:32.684528  / # #export SHELL=3D/bin/sh
    2023-10-10T10:25:32.685325  =

    2023-10-10T10:25:32.787310  / # export SHELL=3D/bin/sh. /lava-160391/en=
vironment
    2023-10-10T10:25:32.788065  =

    2023-10-10T10:25:32.890133  / # . /lava-160391/environment/lava-160391/=
bin/lava-test-runner /lava-160391/1
    2023-10-10T10:25:32.891442  =

    2023-10-10T10:25:32.895341  / # /lava-160391/bin/lava-test-runner /lava=
-160391/1
    2023-10-10T10:25:33.303516  + export TESTRUN_ID=3D1_bootrr =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 7          =


  Details:     https://kernelci.org/test/plan/id/6525279022ef2fb8d8efcef4

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/i=
d/6525279022ef2fb8d8efcefb
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:29:15.451211  /lava-160439/1/../bin/lava-test-case
    2023-10-10T10:29:16.225753  <8>[   81.748639] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-codec-driver-present: https://kernelci.org/tes=
t/case/id/6525279022ef2fb8d8efcefd
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:29:13.096943  /lava-160439/1/../bin/lava-test-case
    2023-10-10T10:29:13.165094  <8>[   78.687886] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-10-10T10:29:14.219734  /lava-160439/1/../bin/lava-test-case
    2023-10-10T10:29:14.292191  <8>[   79.814423] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case=
/id/6525279022ef2fb8d8efcefe
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:29:10.854120  /lava-160439/1/../bin/lava-test-case
    2023-10-10T10:29:10.921886  <8>[   76.444518] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-10-10T10:29:11.974768  /lava-160439/1/../bin/lava-test-case
    2023-10-10T10:29:12.040875  <8>[   77.563456] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tda19988-driver-present: https://kernelci.org/test/=
case/id/6525279022ef2fb8d8efceff
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:29:08.594436  /lava-160439/1/../bin/lava-test-case
    2023-10-10T10:29:08.671251  <8>[   74.194132] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-10-10T10:29:09.724468  /lava-160439/1/../bin/lava-test-case
    2023-10-10T10:29:09.796595  <8>[   75.319729] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/6525279022ef2fb8d8efcf0b
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:28:54.932154  /lava-160439/1/../bin/lava-test-case
    2023-10-10T10:28:54.997009  <8>[   60.518244] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6525279022ef2fb8d8efcf24
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:28:47.271021  <8>[   52.795035] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 160439_1.6.2.4.1>
    2023-10-10T10:28:47.388513  / # #
    2023-10-10T10:28:47.490016  export SHELL=3D/bin/sh
    2023-10-10T10:28:47.490379  #
    2023-10-10T10:28:47.591521  / # export SHELL=3D/bin/sh. /lava-160439/en=
vironment
    2023-10-10T10:28:47.591873  =

    2023-10-10T10:28:47.693160  / # . /lava-160439/environment/lava-160439/=
bin/lava-test-runner /lava-160439/1
    2023-10-10T10:28:47.693719  =

    2023-10-10T10:28:47.696795  / # /lava-160439/bin/lava-test-runner /lava=
-160439/1
    2023-10-10T10:28:47.921893  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =


  * baseline-nfs.bootrr.hdmi-audio: https://kernelci.org/test/case/id/65252=
79022ef2fb8d8efcf25
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:29:17.276622  /lava-160439/1/../bin/lava-test-case
    2023-10-10T10:29:17.338651  <8>[   82.862279] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 7          =


  Details:     https://kernelci.org/test/plan/id/65252eaf33aedb768aefcf2b

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm/multi_v7_defconfig/gcc-10/lab-cip/b=
aseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm/multi_v7_defconfig/gcc-10/lab-cip/b=
aseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65252eaf33aedb768aefcf32
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:59:17.177913  + set +x
    2023-10-10T10:59:17.182193  <8>[   46.438789] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1018655_1.6.2.4.1>
    2023-10-10T10:59:17.411696  #
    2023-10-10T10:59:17.514736  / # #export SHELL=3D/bin/sh
    2023-10-10T10:59:17.515437  =

    2023-10-10T10:59:17.617307  / # export SHELL=3D/bin/sh. /lava-1018655/e=
nvironment
    2023-10-10T10:59:17.618001  =

    2023-10-10T10:59:17.719893  / # . /lava-1018655/environment/lava-101865=
5/bin/lava-test-runner /lava-1018655/1
    2023-10-10T10:59:17.721062  =

    2023-10-10T10:59:17.727750  / # /lava-1018655/bin/lava-test-runner /lav=
a-1018655/1 =

    ... (12 line(s) more)  =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/65252eb033aedb768aefcf4b
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:59:27.626825  /lava-1018655/1/../bin/lava-test-case
    2023-10-10T10:59:27.790798  <8>[   57.046068] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tda19988-driver-present: https://kernelci.org/test/=
case/id/65252eb033aedb768aefcf57
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:59:42.282152  /lava-1018655/1/../bin/lava-test-case
    2023-10-10T10:59:42.453383  <8>[   71.709226] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-10-10T10:59:43.515161  /lava-1018655/1/../bin/lava-test-case
    2023-10-10T10:59:43.669382  <8>[   72.925888] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case=
/id/65252eb033aedb768aefcf58
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:59:44.732058  /lava-1018655/1/../bin/lava-test-case
    2023-10-10T10:59:44.883193  <8>[   74.139397] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-10-10T10:59:45.948903  /lava-1018655/1/../bin/lava-test-case
    2023-10-10T10:59:46.149737  <8>[   75.405826] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-codec-driver-present: https://kernelci.org/tes=
t/case/id/65252eb033aedb768aefcf59
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:59:47.212359  /lava-1018655/1/../bin/lava-test-case
    2023-10-10T10:59:47.376410  <8>[   76.634283] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-10-10T10:59:48.440053  /lava-1018655/1/../bin/lava-test-case
    2023-10-10T10:59:48.600907  <8>[   77.856150] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/i=
d/65252eb033aedb768aefcf5b
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:59:49.889484  /lava-1018655/1/../bin/lava-test-case
    2023-10-10T10:59:50.055375  <8>[   79.311954] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-audio: https://kernelci.org/test/case/id/65252=
eb033aedb768aefcf5c
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:59:51.116890  /lava-1018655/1/../bin/lava-test-case
    2023-10-10T10:59:51.275239  <8>[   80.532300] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/652523e32faa71e8c4efcf0a

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm/omap2plus_defconfig/gcc-10/lab-broo=
nie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm/omap2plus_defconfig/gcc-10/lab-broo=
nie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/=
id/652523e32faa71e8c4efcf29
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:13:32.297742  /lava-160375/1/../bin/lava-test-case
    2023-10-10T10:13:32.369756  <8>[   53.890494] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/652523bd185d4ad58eefcf1f

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm/omap2plus_defconfig/gcc-10/lab-cip/=
baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm/omap2plus_defconfig/gcc-10/lab-cip/=
baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/=
id/652523be185d4ad58eefcf41
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:13:01.178033  /lava-1018626/1/../bin/lava-test-case
    2023-10-10T10:13:01.245698  <8>[   45.226130] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6dl-udoo                  | arm    | lab-broonie   | gcc-10   | imx_v6_v=
7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/65252b1c850e03aa17efcf23

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm/imx_v6_v7_defconfig/gcc-10/lab-broo=
nie/baseline-nfs-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm/imx_v6_v7_defconfig/gcc-10/lab-broo=
nie/baseline-nfs-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65252b1c850e03aa1=
7efcf24
        failing since 117 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee92=
1e9, first fail: v5.10.182-cip35-8-g2391124f19a70) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6dl-udoo                  | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65252cd1aaf972cc22efcef9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65252cd1aaf972cc2=
2efcefa
        failing since 5 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | imx_v6_v=
7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/65252b05182f56168befcf58

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm/imx_v6_v7_defconfig/gcc-10/lab-broo=
nie/baseline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm/imx_v6_v7_defconfig/gcc-10/lab-broo=
nie/baseline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65252b05182f56168=
befcf59
        failing since 48 days (last pass: v4.4-st20-3262-g667bb8d8b2cb, fir=
st fail: v6.1.45-cip3-31-gbae6b8e9a2cff) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65252ca8822cfd5e9befcef4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65252ca8822cfd5e9=
befcef5
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 11         =


  Details:     https://kernelci.org/test/plan/id/652529b2abda0af03aefcef6

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig/gcc-10/lab-broonie/base=
line-nfs-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig/gcc-10/lab-broonie/base=
line-nfs-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.led7-probed: https://kernelci.org/test/case/id/6525=
29b2abda0af03aefcf07
        failing since 5 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:38:25.959740  /lava-160471/1/../bin/lava-test-case
    2023-10-10T10:38:25.998366  <8>[   55.271277] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled7-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led6-probed: https://kernelci.org/test/case/id/6525=
29b2abda0af03aefcf08
        failing since 5 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:38:24.882837  /lava-160471/1/../bin/lava-test-case
    2023-10-10T10:38:24.920531  <8>[   54.193310] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled6-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led5-probed: https://kernelci.org/test/case/id/6525=
29b2abda0af03aefcf09
        failing since 5 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:38:23.803963  /lava-160471/1/../bin/lava-test-case
    2023-10-10T10:38:23.843512  <8>[   53.116651] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled5-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led4-probed: https://kernelci.org/test/case/id/6525=
29b2abda0af03aefcf0a
        failing since 5 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:38:22.718903  /lava-160471/1/../bin/lava-test-case
    2023-10-10T10:38:22.764597  <8>[   52.037222] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled4-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led3-probed: https://kernelci.org/test/case/id/6525=
29b2abda0af03aefcf0b
        failing since 5 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:38:21.632013  /lava-160471/1/../bin/lava-test-case
    2023-10-10T10:38:21.679997  <8>[   50.953240] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled3-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led2-probed: https://kernelci.org/test/case/id/6525=
29b2abda0af03aefcf0c
        failing since 5 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:38:20.556033  /lava-160471/1/../bin/lava-test-case
    2023-10-10T10:38:20.593063  <8>[   49.865333] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled2-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led1-probed: https://kernelci.org/test/case/id/6525=
29b2abda0af03aefcf0d
        failing since 5 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:38:19.476205  /lava-160471/1/../bin/lava-test-case
    2023-10-10T10:38:19.516853  <8>[   48.789717] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled1-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led0-probed: https://kernelci.org/test/case/id/6525=
29b2abda0af03aefcf0e
        failing since 5 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:38:18.390171  /lava-160471/1/../bin/lava-test-case
    2023-10-10T10:38:18.436830  <8>[   47.710228] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled0-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.iommu1-probed: https://kernelci.org/test/case/id/65=
2529b2abda0af03aefcf21
        failing since 5 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:38:16.139524  /lava-160471/1/../bin/lava-test-case
    2023-10-10T10:38:16.186334  <8>[   45.459073] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Diommu1-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.1c050000_mmc-probed: https://kernelci.org/test/case=
/id/652529b2abda0af03aefcf2c
        failing since 5 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:38:14.207606  /lava-160471/1/../bin/lava-test-case
    2023-10-10T10:38:14.247229  <8>[   43.520367] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3D1c050000.mmc-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/652529b2abda0af03aefcf34
        failing since 109 days (last pass: v5.10.182-cip35-8-g2391124f19a70=
, first fail: v6.1.31-61-g32a95f5a4e3b)

    2023-10-10T10:38:11.033361  / # #
    2023-10-10T10:38:11.136169  export SHELL=3D/bin/sh
    2023-10-10T10:38:11.136921  #
    2023-10-10T10:38:11.238862  / # export SHELL=3D/bin/sh. /lava-160471/en=
vironment
    2023-10-10T10:38:11.239621  =

    2023-10-10T10:38:11.341699  / # . /lava-160471/environment/lava-160471/=
bin/lava-test-runner /lava-160471/1
    2023-10-10T10:38:11.343035  =

    2023-10-10T10:38:11.362211  / # /lava-160471/bin/lava-test-runner /lava=
-160471/1
    2023-10-10T10:38:11.550080  + export TESTRUN_ID=3D1_bootrr
    2023-10-10T10:38:11.550717  + cd /lava-160471/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
kontron-kbox-a-230-ls        | arm64  | lab-kontron   | gcc-10   | defconfi=
g                    | 3          =


  Details:     https://kernelci.org/test/plan/id/652527fa9fddd43e00efcef9

  Results:     89 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig/gcc-10/lab-kontron/base=
line-nfs-kontron-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig/gcc-10/lab-kontron/base=
line-nfs-kontron-kbox-a-230-ls.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rcpm-driver-present: https://kernelci.org/test/case=
/id/652527fa9fddd43e00efcf3d
        failing since 5 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:31:06.811965  /lava-384906/1/../bin/lava-test-case
    2023-10-10T10:31:06.839950  <8>[   19.953642] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.ftm-alarm-driver-present: https://kernelci.org/test=
/case/id/652527fa9fddd43e00efcf3e
        failing since 5 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:31:07.847372  /lava-384906/1/../bin/lava-test-case
    2023-10-10T10:31:07.873251  <8>[   20.987873] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2023-10-10T10:31:08.880791  /lava-384906/1/../bin/lava-test-case
    2023-10-10T10:31:08.908732  <8>[   22.023117] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dftm-alarm-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.layerscape-sfp-driver-present: https://kernelci.org=
/test/case/id/652527fa9fddd43e00efcf55
        failing since 5 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:31:11.731233  /lava-384906/1/../bin/lava-test-case
    2023-10-10T10:31:11.755105  <8>[   24.869870] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
kontron-sl28-var3-ads2       | arm64  | lab-kontron   | gcc-10   | defconfi=
g                    | 3          =


  Details:     https://kernelci.org/test/plan/id/6525280e97bdaf7865efcf06

  Results:     97 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig/gcc-10/lab-kontron/base=
line-nfs-kontron-sl28-var3-ads2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig/gcc-10/lab-kontron/base=
line-nfs-kontron-sl28-var3-ads2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rcpm-driver-present: https://kernelci.org/test/case=
/id/6525280e97bdaf7865efcf51
        failing since 5 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:31:16.541804  <8>[   15.666210] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dpci-host-generic-probed RESULT=3Dpass>
    2023-10-10T10:31:17.548592  /lava-384907/1/../bin/lava-test-case
    2023-10-10T10:31:17.575270  <8>[   16.701497] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.ftm-alarm-driver-present: https://kernelci.org/test=
/case/id/6525280e97bdaf7865efcf52
        failing since 5 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:31:18.581755  /lava-384907/1/../bin/lava-test-case
    2023-10-10T10:31:18.613699  <8>[   17.740337] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2023-10-10T10:31:19.620008  /lava-384907/1/../bin/lava-test-case
    2023-10-10T10:31:19.650961  <8>[   18.777476] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dftm-alarm-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.layerscape-sfp-driver-present: https://kernelci.org=
/test/case/id/6525280e97bdaf7865efcf67
        failing since 5 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:31:22.416410  /lava-384907/1/../bin/lava-test-case
    2023-10-10T10:31:22.443320  <8>[   21.569252] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/652523c161219e6e0befcf2f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/652523c161219e6e0=
befcf30
        failing since 5 days (last pass: v5.10.194-cip39-500-gc5c4e5fc16817=
, first fail: v5.10.194-cip39-1-g53e59f50ca3ff) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6525293a47d51a1db4efcf05

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig/gcc-10/lab-broonie/base=
line-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig/gcc-10/lab-broonie/base=
line-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6525293a47d51a1db=
4efcf06
        new failure (last pass: v5.10.194-cip39-1-g53e59f50ca3ff) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/652522b759be730f8cefcf5d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/baseline-nfs-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/baseline-nfs-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/652522b759be730f8=
cefcf5e
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/65252487ec8ce7a42befcef6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65252487ec8ce7a42=
befcef7
        failing since 18 days (last pass: v5.10.194-cip39-500-gc5c4e5fc1681=
7, first fail: v6.1.54-cip6-101-gb060fea6ba099) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/652528471840410264efcf42

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig/gcc-10/lab-cip/baseline=
-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig/gcc-10/lab-cip/baseline=
-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65252847184041026=
4efcf43
        failing since 54 days (last pass: v4.19.288-cip101-1117-g1f3468542a=
a9e, first fail: v5.10.186-cip37-16-gf8567732a40d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6525229859be730f8cefcef4

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/6525229859be730f8cefcefe
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:09:33.504359  /lava-11723432/1/../bin/lava-test-case

    2023-10-10T10:09:33.538997  <8>[   36.650208] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/6525229859be730f8cefceff
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:09:31.370048  <8>[   34.480340] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-10-10T10:09:32.421215  /lava-11723432/1/../bin/lava-test-case

    2023-10-10T10:09:32.453503  <8>[   35.564173] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/652527c822ef2fb8d8efcf8d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig/gcc-10/lab-collabora/ba=
seline-nfs-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig/gcc-10/lab-collabora/ba=
seline-nfs-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/652527c822ef2fb8d8efcf96
        failing since 109 days (last pass: v5.10.182-cip35-8-g2391124f19a70=
, first fail: v6.1.31-61-g32a95f5a4e3b)

    2023-10-10T10:30:32.175747  / # #

    2023-10-10T10:30:33.436416  export SHELL=3D/bin/sh

    2023-10-10T10:30:33.447334  #

    2023-10-10T10:30:33.447762  / # export SHELL=3D/bin/sh

    2023-10-10T10:30:35.191088  / # . /lava-11723638/environment

    2023-10-10T10:30:38.395212  /lava-11723638/bin/lava-test-runner /lava-1=
1723638/1

    2023-10-10T10:30:38.406672  . /lava-11723638/environment

    2023-10-10T10:30:38.408423  / # /lava-11723638/bin/lava-test-runner /la=
va-11723638/1

    2023-10-10T10:30:38.582916  + export TESTRUN_ID=3D1_bootrr

    2023-10-10T10:30:38.583349  + cd /lava-11723638/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 5          =


  Details:     https://kernelci.org/test/plan/id/652528840da3e8d0d5efcef6

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig/gcc-10/lab-broonie/base=
line-nfs-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig/gcc-10/lab-broonie/base=
line-nfs-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.sound-card: https://kernelci.org/test/case/id/65252=
8840da3e8d0d5efcf10
        failing since 5 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:33:26.498411  /lava-160468/1/../bin/lava-test-case
    2023-10-10T10:33:26.949074  <8>[   41.939797] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Di2s-probed RESULT=3Dblocked>
    2023-10-10T10:33:28.071199  /lava-160468/1/../bin/lava-test-case
    2023-10-10T10:33:29.116967  <8>[   44.107771] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sun4i-i2s-driver-present: https://kernelci.org/test=
/case/id/652528840da3e8d0d5efcf11
        failing since 5 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:33:22.513133  /lava-160468/1/../bin/lava-test-case
    2023-10-10T10:33:23.882321  <8>[   38.872243] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcodec-digital-probed RESULT=3Dblocked>
    2023-10-10T10:33:24.920037  /lava-160468/1/../bin/lava-test-case
    2023-10-10T10:33:25.466638  <8>[   40.456562] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun4i-i2s-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sun8i-codec-driver-present: https://kernelci.org/te=
st/case/id/652528840da3e8d0d5efcf12
        failing since 5 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:33:20.146115  /lava-160468/1/../bin/lava-test-case
    2023-10-10T10:33:20.197183  <8>[   35.187287] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcodec-analog-probed RESULT=3Dblocked>
    2023-10-10T10:33:21.232793  /lava-160468/1/../bin/lava-test-case
    2023-10-10T10:33:21.481661  <8>[   36.471413] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8i-codec-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sun50i-codec-analog-driver-present: https://kernelc=
i.org/test/case/id/652528840da3e8d0d5efcf13
        failing since 5 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:33:18.993632  /lava-160468/1/../bin/lava-test-case
    2023-10-10T10:33:19.105822  <8>[   34.095037] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun50i-codec-analog-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/652528840da3e8d0d5efcf26
        failing since 5 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:33:15.076361  + set +x
    2023-10-10T10:33:15.080384  <8>[   30.073293] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 160468_1.6.2.4.1>
    2023-10-10T10:33:15.193239  / # #
    2023-10-10T10:33:15.295019  export SHELL=3D/bin/sh
    2023-10-10T10:33:15.295628  #
    2023-10-10T10:33:15.397132  / # export SHELL=3D/bin/sh. /lava-160468/en=
vironment
    2023-10-10T10:33:15.397820  =

    2023-10-10T10:33:15.499200  / # . /lava-160468/environment/lava-160468/=
bin/lava-test-runner /lava-160468/1
    2023-10-10T10:33:15.500081  =

    2023-10-10T10:33:15.503893  / # /lava-160468/bin/lava-test-runner /lava=
-160468/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/652528ad0da3e8d0d5efcf3d

  Results:     40 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig/gcc-10/lab-broonie/base=
line-nfs-sun50i-h5-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig/gcc-10/lab-broonie/base=
line-nfs-sun50i-h5-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.sun8-codec-analog-driver-present: https://kernelci.=
org/test/case/id/652528ad0da3e8d0d5efcf4c
        failing since 5 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:34:03.210092  /lava-160470/1/../bin/lava-test-case
    2023-10-10T10:34:03.258790  <8>[   65.693301] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8-codec-analog-driver-present RESULT=3Dfail>   =

 =20

