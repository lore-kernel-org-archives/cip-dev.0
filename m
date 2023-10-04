Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9515E7B5EE
	for <webhook@archiver.kernel.org>; Wed,  4 Oct 2023 11:11:29 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web11.15729.1696417887500617591
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 04 Oct 2023 04:11:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=ynRnGOSh;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.174, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1c60f1a2652so6589765ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 04 Oct 2023 04:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696417886; x=1697022686; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+NZ1042kBcRKWNbI22TpjR4SrguDyyQx5sFYOqs1Ck4=;
        b=ynRnGOSh39FeIVWJYyAySsUv9jcx1HgwzdIoJxpwciHFdrt+FWeVj1LkeF3fA7BwIy
         1C1sPHc0XNrh/Mf08fc2RarJnjUWs1MN52IzmMbwXm/m77vKB+9XS7wPbzA6r/4zKPaC
         lMiBn+yaChl4XDmYZRJIu+Yc8ljOiHMrmFFFNfrJ3WUPtwBgHDnG4+MBSODtP4/8svZn
         THpGPbUXclpwKxBLHDPprjYa20qsDEHMikHp89O39aiUHm4NbZojz6a8Hro30R7UR7wB
         cpfiDbD0d+QEYVVbiuffSbsuG0ia0gDuN0AfMEwjrL7oEsuGHJgr014qOWhuECXSXi4f
         7jQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696417886; x=1697022686;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+NZ1042kBcRKWNbI22TpjR4SrguDyyQx5sFYOqs1Ck4=;
        b=vwokxXNfQsytCIYLUYLCnabmkrB86/fkgd/azKiFlNY+YNvEJBCkXPzJvSnZjk8wEU
         YFML52k8DBTkrd3o+C3SSIEUKih2v1dmy7dJPsOoYufvEzGsmpQZQuMWPdNOXK6hgYC0
         sOp+2VutrNlh29RamhUQ0FTbbgxvtqdIJJBdcxDklrYhZrIIPImvvyFaxzOo4gZUj3dz
         i01x4YJAlQDNAjjGmvg5hmkgmO3pusbl39dju+rSFcneaJ94ftPUPcJBK7d6MZpRLBR5
         1yW3q11HaXjH97nZexjNDwx4NTSftKpDXKNBZ/xF7/osSo29MJ5Vz3oiiWnMpiN7M73L
         U42Q==
X-Gm-Message-State: AOJu0Yz8WenVpubtrOoU6aHZpdxegjQsIgfZoSuuUGwQhglL4MFYmDtc
	Oa6gT+VBqj5bGlGOs6LJjx8+/7+zFI5ltwPnCFFYSg==
X-Google-Smtp-Source: AGHT+IEJdJsaKPadDBhyKn0cRDg5YHHDdaEDlgolg6e7qIz/c6OzsGcsRnrQihpDdCuKfYRGCg0vKg==
X-Received: by 2002:a17:902:b610:b0:1bd:e258:a256 with SMTP id b16-20020a170902b61000b001bde258a256mr2466703pls.32.1696417885894;
        Wed, 04 Oct 2023 04:11:25 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id w9-20020a1709026f0900b001c736370245sm3439634plk.54.2023.10.04.04.11.24
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 04:11:25 -0700 (PDT)
Message-ID: <651d485d.170a0220.11fe1.8918@mx.google.com>
Date: Wed, 04 Oct 2023 04:11:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.194-cip39-1-g53e59f50ca3ff
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 49 runs,
 53 regressions (v5.10.194-cip39-1-g53e59f50ca3ff)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Oct 2023 11:11:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13268

cip-gitlab/ci/pavel/linux-test baseline-nfs: 49 runs, 53 regressions (v5.10=
.194-cip39-1-g53e59f50ca3ff)

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
g                    | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

mt8173-elm-hana              | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 5          =

sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.194-cip39-1-g53e59f50ca3ff/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.194-cip39-1-g53e59f50ca3ff
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      53e59f50ca3ff023b612a48397ad7e057a9fd408 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cbv514-1h-34uz-brya     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/651d3c93430e1c99738a0a4f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-nfs-acer-cbv514-1h-34uz-brya.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-nfs-acer-cbv514-1h-34uz-brya.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/651d3c93430e1c997=
38a0a50
        new failure (last pass: v6.1.31-65-geef5a19d48f6) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | at91_dt_=
defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/651d3ed3c3ca4061088a0a8d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm/at91_dt_defconfig/gcc-10/lab-broonie/=
baseline-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm/at91_dt_defconfig/gcc-10/lab-broonie/=
baseline-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armel/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/651d3ed3c3ca40610=
88a0a8e
        new failure (last pass: v6.1.31-65-geef5a19d48f6) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 7          =


  Details:     https://kernelci.org/test/plan/id/651d3ecf486e9149358a0a58

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm/multi_v7_defconfig/gcc-10/lab-broonie=
/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm/multi_v7_defconfig/gcc-10/lab-broonie=
/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.hdmi-audio: https://kernelci.org/test/case/id/651d3=
ecf486e9149358a0a5f
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T10:30:24.203204  /lava-152046/1/../bin/lava-test-case
    2023-10-04T10:30:24.261758  <8>[   81.894210] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/i=
d/651d3ecf486e9149358a0a60
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T10:30:23.101021  /lava-152046/1/../bin/lava-test-case
    2023-10-04T10:30:23.154433  <8>[   80.786314] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-codec-driver-present: https://kernelci.org/tes=
t/case/id/651d3ecf486e9149358a0a62
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T10:30:20.787827  /lava-152046/1/../bin/lava-test-case
    2023-10-04T10:30:20.842838  <8>[   78.475093] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-10-04T10:30:21.896121  /lava-152046/1/../bin/lava-test-case
    2023-10-04T10:30:21.953255  <8>[   79.584463] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case=
/id/651d3ecf486e9149358a0a63
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T10:30:18.565540  /lava-152046/1/../bin/lava-test-case
    2023-10-04T10:30:18.619864  <8>[   76.251670] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-10-04T10:30:19.669315  /lava-152046/1/../bin/lava-test-case
    2023-10-04T10:30:19.730955  <8>[   77.362741] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tda19988-driver-present: https://kernelci.org/test/=
case/id/651d3ecf486e9149358a0a64
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T10:30:16.322339  /lava-152046/1/../bin/lava-test-case
    2023-10-04T10:30:16.385725  <8>[   74.017504] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-10-04T10:30:17.441600  /lava-152046/1/../bin/lava-test-case
    2023-10-04T10:30:17.509166  <8>[   75.140429] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/651d3ecf486e9149358a0a70
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T10:30:03.443789  /lava-152046/1/../bin/lava-test-case
    2023-10-04T10:30:03.507226  <8>[   61.137534] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/651d3ecf486e9149358a0a89
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T10:29:56.005930  <8>[   53.638149] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 152046_1.6.2.4.1>
    2023-10-04T10:29:56.121827  / # #
    2023-10-04T10:29:56.224767  export SHELL=3D/bin/sh
    2023-10-04T10:29:56.225488  #
    2023-10-04T10:29:56.327751  / # export SHELL=3D/bin/sh. /lava-152046/en=
vironment
    2023-10-04T10:29:56.328476  =

    2023-10-04T10:29:56.430744  / # . /lava-152046/environment/lava-152046/=
bin/lava-test-runner /lava-152046/1
    2023-10-04T10:29:56.431996  =

    2023-10-04T10:29:56.436656  / # /lava-152046/bin/lava-test-runner /lava=
-152046/1
    2023-10-04T10:29:56.653610  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 7          =


  Details:     https://kernelci.org/test/plan/id/651d46e0d30655eaef8a0ab8

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm/multi_v7_defconfig/gcc-10/lab-cip/bas=
eline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm/multi_v7_defconfig/gcc-10/lab-cip/bas=
eline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/651d46e1d30655eaef8a0abf
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T11:04:14.449237  + set +x
    2023-10-04T11:04:14.451304  <8>[   46.868374] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1016772_1.6.2.4.1>
    2023-10-04T11:04:14.567683  / # #
    2023-10-04T11:04:14.669522  export SHELL=3D/bin/sh
    2023-10-04T11:04:14.669973  #
    2023-10-04T11:04:14.771378  / # export SHELL=3D/bin/sh. /lava-1016772/e=
nvironment
    2023-10-04T11:04:14.771828  =

    2023-10-04T11:04:14.873262  / # . /lava-1016772/environment/lava-101677=
2/bin/lava-test-runner /lava-1016772/1
    2023-10-04T11:04:14.874119  =

    2023-10-04T11:04:14.876134  / # /lava-1016772/bin/lava-test-runner /lav=
a-1016772/1 =

    ... (12 line(s) more)  =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/651d46e1d30655eaef8a0ad8
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T11:04:21.806906  /lava-1016772/1/../bin/lava-test-case
    2023-10-04T11:04:21.869074  <8>[   54.284391] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tda19988-driver-present: https://kernelci.org/test/=
case/id/651d46e1d30655eaef8a0ae4
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T11:04:34.654545  /lava-1016772/1/../bin/lava-test-case
    2023-10-04T11:04:34.717676  <8>[   67.134645] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-10-04T11:04:35.772326  /lava-1016772/1/../bin/lava-test-case
    2023-10-04T11:04:35.839364  <8>[   68.255516] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case=
/id/651d46e1d30655eaef8a0ae5
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T11:04:36.893103  /lava-1016772/1/../bin/lava-test-case
    2023-10-04T11:04:36.959415  <8>[   69.376045] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-10-04T11:04:37.225377  <6>[   69.644514] platform sound: deferred =
probe pending
    2023-10-04T11:04:38.016325  /lava-1016772/1/../bin/lava-test-case
    2023-10-04T11:04:38.078050  <8>[   70.494776] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-codec-driver-present: https://kernelci.org/tes=
t/case/id/651d46e1d30655eaef8a0ae6
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T11:04:39.134274  /lava-1016772/1/../bin/lava-test-case
    2023-10-04T11:04:39.198292  <8>[   71.615299] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-10-04T11:04:40.253023  /lava-1016772/1/../bin/lava-test-case
    2023-10-04T11:04:40.318168  <8>[   72.734359] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/i=
d/651d46e1d30655eaef8a0ae8
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T11:04:41.478276  /lava-1016772/1/../bin/lava-test-case
    2023-10-04T11:04:41.540297  <8>[   73.957274] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-audio: https://kernelci.org/test/case/id/651d4=
6e1d30655eaef8a0ae9
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T11:04:42.593533  /lava-1016772/1/../bin/lava-test-case
    2023-10-04T11:04:42.657238  <8>[   75.074829] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/651d3cbcd65af7925b8a0a46

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm/omap2plus_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm/omap2plus_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/=
id/651d3cbcd65af7925b8a0a65
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T10:21:37.812778  /lava-152007/1/../bin/lava-test-case
    2023-10-04T10:21:37.875043  <8>[   51.018779] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/651d3d940122dbd0f78a0ae1

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm/omap2plus_defconfig/gcc-10/lab-cip/ba=
seline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm/omap2plus_defconfig/gcc-10/lab-cip/ba=
seline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/=
id/651d3d950122dbd0f78a0b03
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T10:25:18.225167  /lava-1016751/1/../bin/lava-test-case
    2023-10-04T10:25:18.296174  <8>[   45.522505] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6dl-udoo                  | arm    | lab-broonie   | gcc-10   | imx_v6_v=
7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/651d42183d963077928a0a59

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm/imx_v6_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm/imx_v6_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/651d42183d9630779=
28a0a5a
        failing since 111 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee92=
1e9, first fail: v5.10.182-cip35-8-g2391124f19a70) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6dl-udoo                  | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/651d43e12d297c74668a0a43

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm/multi_v7_defconfig/gcc-10/lab-broonie=
/baseline-nfs-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm/multi_v7_defconfig/gcc-10/lab-broonie=
/baseline-nfs-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/651d43e12d297c746=
68a0a44
        new failure (last pass: v6.1.31-65-geef5a19d48f6) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | imx_v6_v=
7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/651d42014a064c5b7d8a0ab2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm/imx_v6_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm/imx_v6_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/651d42014a064c5b7=
d8a0ab3
        failing since 42 days (last pass: v4.4-st20-3262-g667bb8d8b2cb, fir=
st fail: v6.1.45-cip3-31-gbae6b8e9a2cff) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/651d43681db6ea220a8a0a47

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm/multi_v7_defconfig/gcc-10/lab-broonie=
/baseline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm/multi_v7_defconfig/gcc-10/lab-broonie=
/baseline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/651d43681db6ea220=
a8a0a48
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 11         =


  Details:     https://kernelci.org/test/plan/id/651d41185ac092213c8a0a4b

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-broonie/baseli=
ne-nfs-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-broonie/baseli=
ne-nfs-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.led7-probed: https://kernelci.org/test/case/id/651d=
41185ac092213c8a0a5c
        new failure (last pass: v6.1.31-65-geef5a19d48f6)

    2023-10-04T10:40:16.738891  /lava-152081/1/../bin/lava-test-case
    2023-10-04T10:40:16.781670  <8>[   56.042725] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled7-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led6-probed: https://kernelci.org/test/case/id/651d=
41185ac092213c8a0a5d
        new failure (last pass: v6.1.31-65-geef5a19d48f6)

    2023-10-04T10:40:15.658645  /lava-152081/1/../bin/lava-test-case
    2023-10-04T10:40:15.699640  <8>[   54.959930] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled6-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led5-probed: https://kernelci.org/test/case/id/651d=
41185ac092213c8a0a5e
        new failure (last pass: v6.1.31-65-geef5a19d48f6)

    2023-10-04T10:40:14.579920  /lava-152081/1/../bin/lava-test-case
    2023-10-04T10:40:14.619924  <8>[   53.880654] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled5-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led4-probed: https://kernelci.org/test/case/id/651d=
41185ac092213c8a0a5f
        new failure (last pass: v6.1.31-65-geef5a19d48f6)

    2023-10-04T10:40:13.493989  /lava-152081/1/../bin/lava-test-case
    2023-10-04T10:40:13.541968  <8>[   52.803102] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled4-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led3-probed: https://kernelci.org/test/case/id/651d=
41185ac092213c8a0a60
        new failure (last pass: v6.1.31-65-geef5a19d48f6)

    2023-10-04T10:40:12.408024  /lava-152081/1/../bin/lava-test-case
    2023-10-04T10:40:12.455802  <8>[   51.719265] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled3-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led2-probed: https://kernelci.org/test/case/id/651d=
41185ac092213c8a0a61
        new failure (last pass: v6.1.31-65-geef5a19d48f6)

    2023-10-04T10:40:11.323171  /lava-152081/1/../bin/lava-test-case
    2023-10-04T10:40:11.368985  <8>[   50.629866] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled2-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led1-probed: https://kernelci.org/test/case/id/651d=
41185ac092213c8a0a62
        new failure (last pass: v6.1.31-65-geef5a19d48f6)

    2023-10-04T10:40:10.240165  /lava-152081/1/../bin/lava-test-case
    2023-10-04T10:40:10.283849  <8>[   49.545228] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled1-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led0-probed: https://kernelci.org/test/case/id/651d=
41185ac092213c8a0a63
        new failure (last pass: v6.1.31-65-geef5a19d48f6)

    2023-10-04T10:40:09.156249  /lava-152081/1/../bin/lava-test-case
    2023-10-04T10:40:09.201122  <8>[   48.462216] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled0-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.iommu1-probed: https://kernelci.org/test/case/id/65=
1d41185ac092213c8a0a76
        new failure (last pass: v6.1.31-65-geef5a19d48f6)

    2023-10-04T10:40:06.880611  /lava-152081/1/../bin/lava-test-case
    2023-10-04T10:40:06.920532  <8>[   46.181888] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Diommu1-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.1c050000_mmc-probed: https://kernelci.org/test/case=
/id/651d41185ac092213c8a0a83
        new failure (last pass: v6.1.31-65-geef5a19d48f6)

    2023-10-04T10:40:04.913541  /lava-152081/1/../bin/lava-test-case
    2023-10-04T10:40:04.950285  <8>[   44.210009] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3D1c050000.mmc-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/651d41185ac092213c8a0a8a
        failing since 103 days (last pass: v5.10.182-cip35-8-g2391124f19a70=
, first fail: v6.1.31-61-g32a95f5a4e3b)

    2023-10-04T10:40:01.745615  / # #
    2023-10-04T10:40:01.848397  export SHELL=3D/bin/sh
    2023-10-04T10:40:01.849176  #
    2023-10-04T10:40:01.951076  / # export SHELL=3D/bin/sh. /lava-152081/en=
vironment
    2023-10-04T10:40:01.951903  =

    2023-10-04T10:40:02.053856  / # . /lava-152081/environment/lava-152081/=
bin/lava-test-runner /lava-152081/1
    2023-10-04T10:40:02.055130  =

    2023-10-04T10:40:02.074420  / # /lava-152081/bin/lava-test-runner /lava=
-152081/1
    2023-10-04T10:40:02.242123  + export TESTRUN_ID=3D1_bootrr
    2023-10-04T10:40:02.242689  + cd /lava-152081/1/tests/1_bootrr =

    ... (8 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
kontron-kbox-a-230-ls        | arm64  | lab-kontron   | gcc-10   | defconfi=
g                    | 3          =


  Details:     https://kernelci.org/test/plan/id/651d3fb546163202978a0a9c

  Results:     89 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-kontron/baseli=
ne-nfs-kontron-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-kontron/baseli=
ne-nfs-kontron-kbox-a-230-ls.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rcpm-driver-present: https://kernelci.org/test/case=
/id/651d3fb546163202978a0ae0
        new failure (last pass: v6.1.31-65-geef5a19d48f6)

    2023-10-04T10:34:00.533098  /lava-384167/1/../bin/lava-test-case
    2023-10-04T10:34:00.536202  <8>[   20.927200] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.ftm-alarm-driver-present: https://kernelci.org/test=
/case/id/651d3fb546163202978a0ae1
        new failure (last pass: v6.1.31-65-geef5a19d48f6)

    2023-10-04T10:34:01.543710  /lava-384167/1/../bin/lava-test-case
    2023-10-04T10:34:01.575397  <8>[   21.968602] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2023-10-04T10:34:02.583006  /lava-384167/1/../bin/lava-test-case
    2023-10-04T10:34:02.609977  <8>[   23.002705] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dftm-alarm-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.layerscape-sfp-driver-present: https://kernelci.org=
/test/case/id/651d3fb546163202978a0af8
        new failure (last pass: v6.1.31-65-geef5a19d48f6)

    2023-10-04T10:34:05.473524  /lava-384167/1/../bin/lava-test-case
    2023-10-04T10:34:05.503355  <8>[   25.895974] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
kontron-sl28-var3-ads2       | arm64  | lab-kontron   | gcc-10   | defconfi=
g                    | 3          =


  Details:     https://kernelci.org/test/plan/id/651d3fb7f6b61a09918a0a5a

  Results:     97 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-kontron/baseli=
ne-nfs-kontron-sl28-var3-ads2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-kontron/baseli=
ne-nfs-kontron-sl28-var3-ads2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rcpm-driver-present: https://kernelci.org/test/case=
/id/651d3fb7f6b61a09918a0aa5
        new failure (last pass: v6.1.31-65-geef5a19d48f6)

    2023-10-04T10:33:58.202230  <8>[   15.271239] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dpci-host-generic-probed RESULT=3Dpass>
    2023-10-04T10:33:59.209699  /lava-384168/1/../bin/lava-test-case
    2023-10-04T10:33:59.237792  <8>[   16.308654] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.ftm-alarm-driver-present: https://kernelci.org/test=
/case/id/651d3fb7f6b61a09918a0aa6
        new failure (last pass: v6.1.31-65-geef5a19d48f6)

    2023-10-04T10:34:00.245386  /lava-384168/1/../bin/lava-test-case
    2023-10-04T10:34:00.277175  <8>[   17.348510] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2023-10-04T10:34:01.284902  /lava-384168/1/../bin/lava-test-case
    2023-10-04T10:34:01.312810  <8>[   18.383993] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dftm-alarm-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.layerscape-sfp-driver-present: https://kernelci.org=
/test/case/id/651d3fb7f6b61a09918a0abb
        new failure (last pass: v6.1.31-65-geef5a19d48f6)

    2023-10-04T10:34:04.126135  /lava-384168/1/../bin/lava-test-case
    2023-10-04T10:34:04.155513  <8>[   21.226445] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/651d41265ac092213c8a0a9c

  Results:     51 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-broonie/baseli=
ne-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-broonie/baseli=
ne-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.sound-card: https://kernelci.org/test/case/id/651d4=
1265ac092213c8a0aa3
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T10:40:25.530024  /lava-152103/1/../bin/lava-test-case
    2023-10-04T10:40:25.698443  <8>[   51.854595] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/651d43cd16a551dcb28a0a48

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/651d43cd16a551dcb=
28a0a49
        new failure (last pass: v5.10.194-cip39-500-gc5c4e5fc16817) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/651d42173d963077928a0a56

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/baseline-nfs-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/baseline-nfs-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/651d42173d9630779=
28a0a57
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/651d44472d297c74668a0a7e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-cip/baseline-n=
fs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-cip/baseline-n=
fs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/651d44472d297c746=
68a0a7f
        failing since 48 days (last pass: v4.19.288-cip101-1117-g1f3468542a=
a9e, first fail: v5.10.186-cip37-16-gf8567732a40d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/651d45b02e4fd745a28a0a43

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/651d45b02e4fd745a=
28a0a44
        failing since 12 days (last pass: v5.10.194-cip39-500-gc5c4e5fc1681=
7, first fail: v6.1.54-cip6-101-gb060fea6ba099) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/651d41eff3118cba328a0a45

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/651d41eff3118cba328a0a4f
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T10:45:12.289301  /lava-11675971/1/../bin/lava-test-case

    2023-10-04T10:45:12.322392  <8>[   46.362282] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/651d41eff3118cba328a0a50
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T10:45:10.160792  <8>[   44.198671] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-10-04T10:45:11.210427  /lava-11675971/1/../bin/lava-test-case

    2023-10-04T10:45:11.239500  <8>[   45.278619] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/651d3f8c23ec08dd708a0a53

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-collabora/base=
line-nfs-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-collabora/base=
line-nfs-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/651d3f8c23ec08dd708a0a5c
        failing since 103 days (last pass: v5.10.182-cip35-8-g2391124f19a70=
, first fail: v6.1.31-61-g32a95f5a4e3b)

    2023-10-04T10:33:19.579537  / # #

    2023-10-04T10:33:20.840795  export SHELL=3D/bin/sh

    2023-10-04T10:33:20.851686  #

    2023-10-04T10:33:20.852091  / # export SHELL=3D/bin/sh

    2023-10-04T10:33:22.598189  / # . /lava-11675901/environment

    2023-10-04T10:33:25.803868  /lava-11675901/bin/lava-test-runner /lava-1=
1675901/1

    2023-10-04T10:33:25.815332  . /lava-11675901/environment

    2023-10-04T10:33:25.818378  / # /lava-11675901/bin/lava-test-runner /la=
va-11675901/1

    2023-10-04T10:33:25.992140  + export TESTRUN_ID=3D1_bootrr

    2023-10-04T10:33:25.992587  + cd /lava-11675901/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 5          =


  Details:     https://kernelci.org/test/plan/id/651d40216b2094ab508a0a4f

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-broonie/baseli=
ne-nfs-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-broonie/baseli=
ne-nfs-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.sound-card: https://kernelci.org/test/case/id/651d4=
0216b2094ab508a0a69
        new failure (last pass: v6.1.31-65-geef5a19d48f6)

    2023-10-04T10:36:07.344724  /lava-152072/1/../bin/lava-test-case
    2023-10-04T10:36:07.373546  <8>[   40.789156] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Di2s-probed RESULT=3Dblocked>
    2023-10-04T10:36:08.404559  /lava-152072/1/../bin/lava-test-case
    2023-10-04T10:36:08.430212  <8>[   41.846023] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sun4i-i2s-driver-present: https://kernelci.org/test=
/case/id/651d40216b2094ab508a0a6a
        new failure (last pass: v6.1.31-65-geef5a19d48f6)

    2023-10-04T10:36:05.224047  /lava-152072/1/../bin/lava-test-case
    2023-10-04T10:36:05.254111  <8>[   38.670230] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcodec-digital-probed RESULT=3Dblocked>
    2023-10-04T10:36:06.286937  /lava-152072/1/../bin/lava-test-case
    2023-10-04T10:36:06.315416  <8>[   39.730444] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun4i-i2s-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sun8i-codec-driver-present: https://kernelci.org/te=
st/case/id/651d40216b2094ab508a0a6b
        new failure (last pass: v6.1.31-65-geef5a19d48f6)

    2023-10-04T10:36:03.104594  /lava-152072/1/../bin/lava-test-case
    2023-10-04T10:36:03.134496  <8>[   36.549721] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcodec-analog-probed RESULT=3Dblocked>
    2023-10-04T10:36:04.253691  /lava-152072/1/../bin/lava-test-case
    2023-10-04T10:36:04.256716  <8>[   37.606515] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8i-codec-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sun50i-codec-analog-driver-present: https://kernelc=
i.org/test/case/id/651d40216b2094ab508a0a6c
        new failure (last pass: v6.1.31-65-geef5a19d48f6)

    2023-10-04T10:36:02.044810  /lava-152072/1/../bin/lava-test-case
    2023-10-04T10:36:02.074160  <8>[   35.488394] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun50i-codec-analog-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/651d40216b2094ab508a0a7f
        new failure (last pass: v6.1.31-65-geef5a19d48f6)

    2023-10-04T10:35:58.205785  <8>[   31.622746] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 152072_1.6.2.4.1>
    2023-10-04T10:35:58.318403  / # #
    2023-10-04T10:35:58.421154  export SHELL=3D/bin/sh
    2023-10-04T10:35:58.421637  #
    2023-10-04T10:35:58.523320  / # export SHELL=3D/bin/sh. /lava-152072/en=
vironment
    2023-10-04T10:35:58.524100  =

    2023-10-04T10:35:58.625530  / # . /lava-152072/environment/lava-152072/=
bin/lava-test-runner /lava-152072/1
    2023-10-04T10:35:58.626494  =

    2023-10-04T10:35:58.629595  / # /lava-152072/bin/lava-test-runner /lava=
-152072/1
    2023-10-04T10:35:58.757579  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/651d3ff888cd78ebff8a0a4e

  Results:     40 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-broonie/baseli=
ne-nfs-sun50i-h5-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-broonie/baseli=
ne-nfs-sun50i-h5-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.sun8-codec-analog-driver-present: https://kernelci.=
org/test/case/id/651d3ff888cd78ebff8a0a5d
        new failure (last pass: v6.1.31-65-geef5a19d48f6)

    2023-10-04T10:35:29.713981  /lava-152091/1/../bin/lava-test-case
    2023-10-04T10:35:29.751243  <8>[   49.553518] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8-codec-analog-driver-present RESULT=3Dfail>   =

 =20

