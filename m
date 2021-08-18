Return-Path: <SRS0=hNGG=NJ=lists.cip-project.org=bounce+64572+6687+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F8BC4338F
	for <cip-dev@archiver.kernel.org>; Wed, 18 Aug 2021 16:52:14 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EFF9610E8
	for <cip-dev@archiver.kernel.org>; Wed, 18 Aug 2021 16:52:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2EFF9610E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id pSn7YY4521723x5kHWVqpPFN; Wed, 18 Aug 2021 09:52:13 -0700
X-Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
 by mx.groups.io with SMTP id smtpd.web11.57088.1629305533215583200
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 18 Aug 2021 09:52:13 -0700
X-Received: by mail-pj1-f41.google.com with SMTP id n5so2998287pjt.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 18 Aug 2021 09:52:13 -0700 (PDT)
X-Gm-Message-State: QhcxXFy6IUYr6QokHTWjOp75x4520388AA=
X-Google-Smtp-Source: ABdhPJzDMsxDWHwpEWBBa5rneocIAUYmj9R42xliVFDAPoEqfHUo6mkIWR1l8NFnnzjFxlfoYI2g7A==
X-Received: by 2002:a17:90a:17a6:: with SMTP id q35mr10638101pja.86.1629305532490;
        Wed, 18 Aug 2021 09:52:12 -0700 (PDT)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q68sm304546pgq.5.2021.08.18.09.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 09:52:12 -0700 (PDT)
Message-ID: <611d3abc.1c69fb81.308b4.126a@mx.google.com>
Date: Wed, 18 Aug 2021 09:52:12 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.19.204-cip55
X-Kernelci-Report-Type: test
Subject: [cip-dev] cip/linux-4.19.y-cip baseline-nfs: 46 runs, 12 regressions (v4.19.204-cip55) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="sVPbRARPFpyRDjzCOpLQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1629305533;
 bh=Ybvuk0SwlmHIwE3G2kNuv+KSD+K5X3fDm3Su5AMss2s=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=imjz20KRNb2nfE2a5LI/FKX9T3CWzVojF8bgP+KP76WfaupWrilreoGpkxnfqidnI3m
 uCth9Z8TVsITxo6cR3RfENAlbrByRbcmxV1KKDJIunfMItuzz33U2sokwie9PHr6HzHG8
 +UCnGBgtvOL6uU+ve+7uFnzR4Vf+AqZ+69Q=

--sVPbRARPFpyRDjzCOpLQ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.19.y-cip baseline-nfs: 46 runs, 12 regressions (v4.19.204-cip55)

Regressions Summary
-------------------

platform          | arch  | lab             | compiler | defconfig         =
           | regressions
------------------+-------+-----------------+----------+-------------------=
-----------+------------
dove-cubox        | arm   | lab-pengutronix | gcc-8    | multi_v7_defconfig=
           | 1          =

rk3288-veyron-jaq | arm   | lab-collabora   | gcc-8    | multi_v7_defc...CO=
NFIG_SMP=3Dn | 4          =

rk3288-veyron-jaq | arm   | lab-collabora   | gcc-8    | multi_v7_defc...G_=
ARM_LPAE=3Dy | 3          =

rk3288-veyron-jaq | arm   | lab-collabora   | gcc-8    | multi_v7_defconfig=
           | 3          =

rk3399-gru-kevin  | arm64 | lab-collabora   | gcc-8    | defconfig         =
           | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.204-cip55/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.204-cip55
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      62089879a4547be35f0c23d8992c51ab5898e076 =



Test Regressions
---------------- =



platform          | arch  | lab             | compiler | defconfig         =
           | regressions
------------------+-------+-----------------+----------+-------------------=
-----------+------------
dove-cubox        | arm   | lab-pengutronix | gcc-8    | multi_v7_defconfig=
           | 1          =


  Details:     https://kernelci.org/test/plan/id/611d2f1557e6ad0a29b1366b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.204=
-cip55/arm/multi_v7_defconfig/gcc-8/lab-pengutronix/baseline-nfs-dove-cubox=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.204=
-cip55/arm/multi_v7_defconfig/gcc-8/lab-pengutronix/baseline-nfs-dove-cubox=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0730.6/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/611d2f1557e6ad0a2=
9b1366c
        failing since 114 days (last pass: v4.19.186-cip47-1-g4c2cb7ba796b,=
 first fail: v4.19.188-cip48) =

 =



platform          | arch  | lab             | compiler | defconfig         =
           | regressions
------------------+-------+-----------------+----------+-------------------=
-----------+------------
rk3288-veyron-jaq | arm   | lab-collabora   | gcc-8    | multi_v7_defc...CO=
NFIG_SMP=3Dn | 4          =


  Details:     https://kernelci.org/test/plan/id/611d31cd0d4442bf02b13664

  Results:     62 PASS, 7 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.204=
-cip55/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-collabora/baseline-n=
fs-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.204=
-cip55/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-collabora/baseline-n=
fs-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0730.6/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-iodomain-grf-probed: https://kernelci.org/=
test/case/id/611d31cd0d4442bf02b1367c
        failing since 40 days (last pass: v4.19.194-cip51, first fail: v4.1=
9.196-cip53)

    2021-08-18T16:13:40.231964  /lava-4377487/1/../bin/lava-test-case
    2021-08-18T16:13:40.261257  [   35.407735] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-iodomain-grf-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.dwmmc_rockchip-sdio0-probed: https://kernelci.org/t=
est/case/id/611d31cd0d4442bf02b13695
        failing since 40 days (last pass: v4.19.194-cip51, first fail: v4.1=
9.196-cip53)

    2021-08-18T16:13:36.983274  /lava-4377487/1/../bin/lava-test-case
    2021-08-18T16:13:37.011395  [   32.157252] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddwmmc_rockchip-sdio0-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.dwmmc_rockchip-sdmmc-probed: https://kernelci.org/t=
est/case/id/611d31cd0d4442bf02b13696
        failing since 40 days (last pass: v4.19.194-cip51, first fail: v4.1=
9.196-cip53)

    2021-08-18T16:13:35.926366  /lava-4377487/1/../bin/lava-test-case
    2021-08-18T16:13:35.953372  [   31.099238] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddwmmc_rockchip-sdmmc-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cros-ec-keyb-probed: https://kernelci.org/test/case=
/id/611d31cd0d4442bf02b136a5
        failing since 40 days (last pass: v4.19.194-cip51, first fail: v4.1=
9.196-cip53)

    2021-08-18T16:13:34.139877  /lava-4377487/1/../bin/lava-test-case
    2021-08-18T16:13:34.168155  [   29.314789] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcros-ec-keyb-probed RESULT=3Dfail>   =

 =



platform          | arch  | lab             | compiler | defconfig         =
           | regressions
------------------+-------+-----------------+----------+-------------------=
-----------+------------
rk3288-veyron-jaq | arm   | lab-collabora   | gcc-8    | multi_v7_defc...G_=
ARM_LPAE=3Dy | 3          =


  Details:     https://kernelci.org/test/plan/id/611d3533d8621310d6b13664

  Results:     63 PASS, 6 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_EFI=3Dy+CONFIG_ARM_LPAE=3Dy
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.204=
-cip55/arm/multi_v7_defconfig+CONFIG_EFI=3Dy+CONFIG_ARM_LPAE=3Dy/gcc-8/lab-=
collabora/baseline-nfs-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.204=
-cip55/arm/multi_v7_defconfig+CONFIG_EFI=3Dy+CONFIG_ARM_LPAE=3Dy/gcc-8/lab-=
collabora/baseline-nfs-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0730.6/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-iodomain-grf-probed: https://kernelci.org/=
test/case/id/611d3534d8621310d6b1367c
        failing since 40 days (last pass: v4.19.194-cip51, first fail: v4.1=
9.196-cip53)

    2021-08-18T16:28:28.797851  /lava-4377596/1/../bin/lava-test-case
    2021-08-18T16:28:28.827789  <8>[   33.543214] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-iodomain-grf-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.dwmmc_rockchip-sdio0-probed: https://kernelci.org/t=
est/case/id/611d3534d8621310d6b13695
        failing since 40 days (last pass: v4.19.194-cip51, first fail: v4.1=
9.196-cip53)

    2021-08-18T16:28:25.569268  /lava-4377596/1/../bin/lava-test-case
    2021-08-18T16:28:25.597188  <8>[   30.313137] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwmmc_rockchip-sdio0-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.dwmmc_rockchip-sdmmc-probed: https://kernelci.org/t=
est/case/id/611d3534d8621310d6b13696
        failing since 40 days (last pass: v4.19.194-cip51, first fail: v4.1=
9.196-cip53)

    2021-08-18T16:28:24.512147  /lava-4377596/1/../bin/lava-test-case
    2021-08-18T16:28:24.540143  <8>[   29.256175] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwmmc_rockchip-sdmmc-probed RESULT=3Dfail>   =

 =



platform          | arch  | lab             | compiler | defconfig         =
           | regressions
------------------+-------+-----------------+----------+-------------------=
-----------+------------
rk3288-veyron-jaq | arm   | lab-collabora   | gcc-8    | multi_v7_defconfig=
           | 3          =


  Details:     https://kernelci.org/test/plan/id/611d3613e522f074e0b13661

  Results:     63 PASS, 6 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.204=
-cip55/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-nfs-rk3288-veyro=
n-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.204=
-cip55/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-nfs-rk3288-veyro=
n-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0730.6/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-iodomain-grf-probed: https://kernelci.org/=
test/case/id/611d3613e522f074e0b13676
        failing since 40 days (last pass: v4.19.194-cip51, first fail: v4.1=
9.196-cip53)

    2021-08-18T16:32:02.633842  /lava-4377602/1/../bin/lava-test-case
    2021-08-18T16:32:02.663796  [   33.440275] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-iodomain-grf-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.dwmmc_rockchip-sdio0-probed: https://kernelci.org/t=
est/case/id/611d3613e522f074e0b13690
        failing since 40 days (last pass: v4.19.194-cip51, first fail: v4.1=
9.196-cip53)

    2021-08-18T16:31:59.382429  /lava-4377602/1/../bin/lava-test-case
    2021-08-18T16:31:59.410570  [   30.186328] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddwmmc_rockchip-sdio0-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.dwmmc_rockchip-sdmmc-probed: https://kernelci.org/t=
est/case/id/611d3613e522f074e0b13691
        failing since 40 days (last pass: v4.19.194-cip51, first fail: v4.1=
9.196-cip53)

    2021-08-18T16:31:58.323347  /lava-4377602/1/../bin/lava-test-case
    2021-08-18T16:31:58.352424  [   29.128770] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddwmmc_rockchip-sdmmc-probed RESULT=3Dfail>   =

 =



platform          | arch  | lab             | compiler | defconfig         =
           | regressions
------------------+-------+-----------------+----------+-------------------=
-----------+------------
rk3399-gru-kevin  | arm64 | lab-collabora   | gcc-8    | defconfig         =
           | 1          =


  Details:     https://kernelci.org/test/plan/id/611d2fa61dd0e837bbb13675

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.204=
-cip55/arm64/defconfig/gcc-8/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.204=
-cip55/arm64/defconfig/gcc-8/lab-collabora/baseline-nfs-rk3399-gru-kevin.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0730.6/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/611d2fa61dd0e837b=
bb13676
        new failure (last pass: v4.19.196-cip53) =

 =20

--sVPbRARPFpyRDjzCOpLQ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6687): https://lists.cip-project.org/g/cip-dev/message/=
6687
Mute This Topic: https://lists.cip-project.org/mt/84976765/4520388
Mute #kernelci:https://lists.cip-project.org/g/cip-dev/mutehashtag/kernelci
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--sVPbRARPFpyRDjzCOpLQ--
