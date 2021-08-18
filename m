Return-Path: <SRS0=3Tcj=NJ=lists.cip-project.org=bounce+64572+6688+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39405C432BE
	for <cip-dev@archiver.kernel.org>; Wed, 18 Aug 2021 16:52:16 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC97B6108D
	for <cip-dev@archiver.kernel.org>; Wed, 18 Aug 2021 16:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DC97B6108D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id MYRjYY4521723xHdL5sRuDzs; Wed, 18 Aug 2021 09:52:15 -0700
X-Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
 by mx.groups.io with SMTP id smtpd.web11.57089.1629305535065797330
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 18 Aug 2021 09:52:15 -0700
X-Received: by mail-pg1-f182.google.com with SMTP id s11so2859559pgr.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 18 Aug 2021 09:52:15 -0700 (PDT)
X-Gm-Message-State: OJ58CeA0N5KTOm3OVHzDF7EDx4520388AA=
X-Google-Smtp-Source: ABdhPJznSRjoQAkTNHM7wFzSO08kC4SsUYg0IlR90tU+PeH1gjx9amBavkddBlMJQIFz5iCubQRolQ==
X-Received: by 2002:a63:4c0e:: with SMTP id z14mr9855483pga.427.1629305534386;
        Wed, 18 Aug 2021 09:52:14 -0700 (PDT)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j13sm290526pgp.29.2021.08.18.09.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 09:52:14 -0700 (PDT)
Message-ID: <611d3abe.1c69fb81.88df4.1279@mx.google.com>
Date: Wed, 18 Aug 2021 09:52:14 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.19.204-cip55
X-Kernelci-Report-Type: test
Subject: [cip-dev] cip/linux-4.19.y-cip baseline: 357 runs, 14 regressions (v4.19.204-cip55) #kernelci
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
Content-Type: multipart/mixed; boundary="QsZS9IOpZDr0dgX0hE3I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1629305535;
 bh=MZ7NuJrZ7CSKdONVA0Q+IArT04dAqE3APcvompz+eEY=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=LcHcV7CueMsPSjR/0HfrxXat8tVvjt/qEoe9P46voCX/4jc0rdeXp1hhqMxoSdMSsIR
 ou/2MBfwjCBwyk0i5XGxpad81o/aVRqsQvsMmA5PYQPdEwK6CIV7VDIZprz6apxC8HrqC
 Xpc+SE7qVbWDXeJ+FoOxqiANN7aH8ueSHls=

--QsZS9IOpZDr0dgX0hE3I
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.19.y-cip baseline: 357 runs, 14 regressions (v4.19.204-cip55)

Regressions Summary
-------------------

platform             | arch | lab           | compiler | defconfig         =
           | regressions
---------------------+------+---------------+----------+-------------------=
-----------+------------
imx6ul-14x14-evk     | arm  | lab-nxp       | gcc-8    | imx_v6_v7_defconfi=
g          | 1          =

qemu_arm-versatilepb | arm  | lab-baylibre  | gcc-8    | versatile_defconfi=
g          | 1          =

qemu_arm-versatilepb | arm  | lab-broonie   | gcc-8    | versatile_defconfi=
g          | 1          =

qemu_arm-versatilepb | arm  | lab-cip       | gcc-8    | versatile_defconfi=
g          | 1          =

qemu_arm-versatilepb | arm  | lab-collabora | gcc-8    | versatile_defconfi=
g          | 1          =

rk3288-veyron-jaq    | arm  | lab-collabora | gcc-8    | multi_v7_defc...CO=
NFIG_SMP=3Dn | 3          =

rk3288-veyron-jaq    | arm  | lab-collabora | gcc-8    | multi_v7_defconfig=
           | 3          =

rk3288-veyron-jaq    | arm  | lab-collabora | gcc-8    | multi_v7_defc...G_=
ARM_LPAE=3Dy | 3          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.204-cip55/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.204-cip55
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      62089879a4547be35f0c23d8992c51ab5898e076 =



Test Regressions
---------------- =



platform             | arch | lab           | compiler | defconfig         =
           | regressions
---------------------+------+---------------+----------+-------------------=
-----------+------------
imx6ul-14x14-evk     | arm  | lab-nxp       | gcc-8    | imx_v6_v7_defconfi=
g          | 1          =


  Details:     https://kernelci.org/test/plan/id/611d342b7cc0d07da9b1368e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.204=
-cip55/arm/imx_v6_v7_defconfig/gcc-8/lab-nxp/baseline-imx6ul-14x14-evk.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.204=
-cip55/arm/imx_v6_v7_defconfig/gcc-8/lab-nxp/baseline-imx6ul-14x14-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/611d342b7cc0d07da9b13=
68f
        new failure (last pass: v4.19.196-cip53) =

 =



platform             | arch | lab           | compiler | defconfig         =
           | regressions
---------------------+------+---------------+----------+-------------------=
-----------+------------
qemu_arm-versatilepb | arm  | lab-baylibre  | gcc-8    | versatile_defconfi=
g          | 1          =


  Details:     https://kernelci.org/test/plan/id/611d2aee3a542a7c69b13663

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: versatile_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.204=
-cip55/arm/versatile_defconfig/gcc-8/lab-baylibre/baseline-qemu_arm-versati=
lepb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.204=
-cip55/arm/versatile_defconfig/gcc-8/lab-baylibre/baseline-qemu_arm-versati=
lepb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/611d2aee3a542a7c69b13=
664
        failing since 277 days (last pass: v4.19.152-cip37-37-g18852869b06b=
, first fail: v4.19.157-cip38) =

 =



platform             | arch | lab           | compiler | defconfig         =
           | regressions
---------------------+------+---------------+----------+-------------------=
-----------+------------
qemu_arm-versatilepb | arm  | lab-broonie   | gcc-8    | versatile_defconfi=
g          | 1          =


  Details:     https://kernelci.org/test/plan/id/611d36ce44cf7a72a2b13701

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: versatile_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.204=
-cip55/arm/versatile_defconfig/gcc-8/lab-broonie/baseline-qemu_arm-versatil=
epb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.204=
-cip55/arm/versatile_defconfig/gcc-8/lab-broonie/baseline-qemu_arm-versatil=
epb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/611d36ce44cf7a72a2b13=
702
        failing since 277 days (last pass: v4.19.152-cip37-37-g18852869b06b=
, first fail: v4.19.157-cip38) =

 =



platform             | arch | lab           | compiler | defconfig         =
           | regressions
---------------------+------+---------------+----------+-------------------=
-----------+------------
qemu_arm-versatilepb | arm  | lab-cip       | gcc-8    | versatile_defconfi=
g          | 1          =


  Details:     https://kernelci.org/test/plan/id/611d29b0fb2ac7a26fb13673

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: versatile_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.204=
-cip55/arm/versatile_defconfig/gcc-8/lab-cip/baseline-qemu_arm-versatilepb.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.204=
-cip55/arm/versatile_defconfig/gcc-8/lab-cip/baseline-qemu_arm-versatilepb.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/611d29b0fb2ac7a26fb13=
674
        failing since 277 days (last pass: v4.19.152-cip37-37-g18852869b06b=
, first fail: v4.19.157-cip38) =

 =



platform             | arch | lab           | compiler | defconfig         =
           | regressions
---------------------+------+---------------+----------+-------------------=
-----------+------------
qemu_arm-versatilepb | arm  | lab-collabora | gcc-8    | versatile_defconfi=
g          | 1          =


  Details:     https://kernelci.org/test/plan/id/611d29953ff7d59c3cb1369a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: versatile_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.204=
-cip55/arm/versatile_defconfig/gcc-8/lab-collabora/baseline-qemu_arm-versat=
ilepb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.204=
-cip55/arm/versatile_defconfig/gcc-8/lab-collabora/baseline-qemu_arm-versat=
ilepb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/611d29953ff7d59c3cb13=
69b
        failing since 277 days (last pass: v4.19.152-cip37-37-g18852869b06b=
, first fail: v4.19.157-cip38) =

 =



platform             | arch | lab           | compiler | defconfig         =
           | regressions
---------------------+------+---------------+----------+-------------------=
-----------+------------
rk3288-veyron-jaq    | arm  | lab-collabora | gcc-8    | multi_v7_defc...CO=
NFIG_SMP=3Dn | 3          =


  Details:     https://kernelci.org/test/plan/id/611d312daa53039bccb136c2

  Results:     64 PASS, 6 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.204=
-cip55/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-collabora/baseline-r=
k3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.204=
-cip55/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-collabora/baseline-r=
k3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-iodomain-grf-probed: https://kernelci.org/test=
/case/id/611d312daa53039bccb136da
        failing since 40 days (last pass: v4.19.194-cip51, first fail: v4.1=
9.196-cip53)

    2021-08-18T16:11:06.006545  <4>[   18.739876] cros-ec-spi spi0.0: EC fa=
iled to respond in time
    2021-08-18T16:11:06.014942  <3>[   18.748509] cros-ec-spi spi0.0: Comma=
nd xfer error (err:-110)
    2021-08-18T16:11:06.027757  <3>[   18.757216] cros-ec-i2c-tunnel ff1100=
00.spi:ec@0:i2c-tunnel: Error transferring EC i2c message -110
    2021-08-18T16:11:06.245019  <4>[   18.969910] cros-ec-spi spi0.0: EC fa=
iled to respond in time
    2021-08-18T16:11:06.245412  <3>[   18.978567] cros-ec-spi spi0.0: Comma=
nd xfer error (err:-110)
    2021-08-18T16:11:06.257992  <3>[   18.987308] cros-ec-i2c-tunnel ff1100=
00.spi:ec@0:i2c-tunnel: Error transferring EC i2c message -110
    2021-08-18T16:11:06.507030  <4>[   19.239877] cros-ec-spi spi0.0: EC fa=
iled to respond in time
    2021-08-18T16:11:06.528137  <3>[   19.248560] cros-ec-spi spi0.0: Comma=
nd xfer error (err:-110)
    2021-08-18T16:11:06.528433  <3>[   19.257308] cros-ec-i2c-tunnel ff1100=
00.spi:ec@0:i2c-tunnel: Error transferring EC i2c message -110
    2021-08-18T16:11:06.746870  <4>[   19.479882] cros-ec-spi spi0.0: EC fa=
iled to respond in time =

    ... (4 line(s) more)  =


  * baseline.bootrr.dwmmc_rockchip-sdio0-probed: https://kernelci.org/test/=
case/id/611d312daa53039bccb136f1
        failing since 40 days (last pass: v4.19.194-cip51, first fail: v4.1=
9.196-cip53)

    2021-08-18T16:11:02.877050  <4>[   15.609893] cros-ec-spi spi0.0: EC fa=
iled to respond in time
    2021-08-18T16:11:02.885082  <3>[   15.618649] cros-ec-spi spi0.0: Comma=
nd xfer error (err:-110)
    2021-08-18T16:11:02.897981  <3>[   15.627468] cros-ec-i2c-tunnel ff1100=
00.spi:ec@0:i2c-tunnel: Error transferring EC i2c message -110
    2021-08-18T16:11:03.125264  <4>[   15.849909] cros-ec-spi spi0.0: EC fa=
iled to respond in time
    2021-08-18T16:11:03.125557  <3>[   15.858639] cros-ec-spi spi0.0: Comma=
nd xfer error (err:-110)
    2021-08-18T16:11:03.137992  <3>[   15.867457] cros-ec-i2c-tunnel ff1100=
00.spi:ec@0:i2c-tunnel: Error transferring EC i2c message -110
    2021-08-18T16:11:03.357088  <4>[   16.089910] cros-ec-spi spi0.0: EC fa=
iled to respond in time
    2021-08-18T16:11:03.378179  <3>[   16.098636] cros-ec-spi spi0.0: Comma=
nd xfer error (err:-110)
    2021-08-18T16:11:03.378494  <3>[   16.107429] cros-ec-i2c-tunnel ff1100=
00.spi:ec@0:i2c-tunnel: Error transferring EC i2c message -110
    2021-08-18T16:11:03.597253  <4>[   16.329926] cros-ec-spi spi0.0: EC fa=
iled to respond in time =

    ... (7 line(s) more)  =


  * baseline.bootrr.dwmmc_rockchip-sdmmc-probed: https://kernelci.org/test/=
case/id/611d312daa53039bccb136f2
        failing since 40 days (last pass: v4.19.194-cip51, first fail: v4.1=
9.196-cip53)

    2021-08-18T16:11:01.782954  <3>[   14.513010] cros-ec-i2c-tunnel ff1100=
00.spi:ec@0:i2c-tunnel: Error transferring EC i2c message -110
    2021-08-18T16:11:01.997007  <4>[   14.729893] cros-ec-spi spi0.0: EC fa=
iled to respond in time
    2021-08-18T16:11:02.005053  <3>[   14.738641] cros-ec-spi spi0.0: Comma=
nd xfer error (err:-110)
    2021-08-18T16:11:02.018246  <3>[   14.747461] cros-ec-i2c-tunnel ff1100=
00.spi:ec@0:i2c-tunnel: Error transferring EC i2c message -110
    2021-08-18T16:11:02.236536  <4>[   14.969876] cros-ec-spi spi0.0: EC fa=
iled to respond in time
    2021-08-18T16:11:02.256324  <3>[   14.978593] cros-ec-spi spi0.0: Comma=
nd xfer error (err:-110)
    2021-08-18T16:11:02.262060  <3>[   14.987374] cros-ec-i2c-tunnel ff1100=
00.spi:ec@0:i2c-tunnel: Error transferring EC i2c message -110
    2021-08-18T16:11:02.637189  <4>[   15.369887] cros-ec-spi spi0.0: EC fa=
iled to respond in time
    2021-08-18T16:11:02.645148  <3>[   15.378609] cros-ec-spi spi0.0: Comma=
nd xfer error (err:-110)
    2021-08-18T16:11:02.661034  <3>[   15.387393] cros-ec-i2c-tunnel ff1100=
00.spi:ec@0:i2c-tunnel: Error transferring EC i2c message -110 =

    ... (2 line(s) more)  =

 =



platform             | arch | lab           | compiler | defconfig         =
           | regressions
---------------------+------+---------------+----------+-------------------=
-----------+------------
rk3288-veyron-jaq    | arm  | lab-collabora | gcc-8    | multi_v7_defconfig=
           | 3          =


  Details:     https://kernelci.org/test/plan/id/611d330392824da1b1b1366f

  Results:     64 PASS, 6 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.204=
-cip55/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-rk3288-veyron-ja=
q.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.204=
-cip55/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-rk3288-veyron-ja=
q.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-iodomain-grf-probed: https://kernelci.org/test=
/case/id/611d330392824da1b1b13687
        failing since 40 days (last pass: v4.19.194-cip51, first fail: v4.1=
9.196-cip53)

    2021-08-18T16:19:04.202493  /lava-4377579/1/../bin/lava-test-case
    2021-08-18T16:19:04.218549  <8>[   22.864076] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-iodomain-grf-probed RESULT=3Dfail>
    2021-08-18T16:19:04.218787  /lava-4377579/1/../bin/lava-test-case   =


  * baseline.bootrr.dwmmc_rockchip-sdio0-probed: https://kernelci.org/test/=
case/id/611d330392824da1b1b136a0
        failing since 40 days (last pass: v4.19.194-cip51, first fail: v4.1=
9.196-cip53)

    2021-08-18T16:19:01.775925  /lava-4377579/1/../bin/lava-test-case<8>[  =
 20.421423] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwmmc_rockchip-sdio0-probe=
d RESULT=3Dfail>
    2021-08-18T16:19:01.776272  =

    2021-08-18T16:19:01.776466  /lava-4377579/1/../bin/lava-test-case   =


  * baseline.bootrr.dwmmc_rockchip-sdmmc-probed: https://kernelci.org/test/=
case/id/611d330392824da1b1b136a1
        failing since 40 days (last pass: v4.19.194-cip51, first fail: v4.1=
9.196-cip53)

    2021-08-18T16:19:00.738547  /lava-4377579/1/../bin/lava-test-case
    2021-08-18T16:19:00.743719  <8>[   19.401948] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwmmc_rockchip-sdmmc-probed RESULT=3Dfail>   =

 =



platform             | arch | lab           | compiler | defconfig         =
           | regressions
---------------------+------+---------------+----------+-------------------=
-----------+------------
rk3288-veyron-jaq    | arm  | lab-collabora | gcc-8    | multi_v7_defc...G_=
ARM_LPAE=3Dy | 3          =


  Details:     https://kernelci.org/test/plan/id/611d35970f556b668eb13681

  Results:     64 PASS, 6 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_EFI=3Dy+CONFIG_ARM_LPAE=3Dy
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.204=
-cip55/arm/multi_v7_defconfig+CONFIG_EFI=3Dy+CONFIG_ARM_LPAE=3Dy/gcc-8/lab-=
collabora/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.204=
-cip55/arm/multi_v7_defconfig+CONFIG_EFI=3Dy+CONFIG_ARM_LPAE=3Dy/gcc-8/lab-=
collabora/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-iodomain-grf-probed: https://kernelci.org/test=
/case/id/611d35970f556b668eb13699
        failing since 40 days (last pass: v4.19.194-cip51, first fail: v4.1=
9.196-cip53)

    2021-08-18T16:29:58.539646  /lava-4377601/1/../bin/lava-test-case
    2021-08-18T16:29:58.556795  <8>[   17.390104] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-iodomain-grf-probed RESULT=3Dfail>
    2021-08-18T16:29:58.557112  /lava-4377601/1/../bin/lava-test-case   =


  * baseline.bootrr.dwmmc_rockchip-sdio0-probed: https://kernelci.org/test/=
case/id/611d35970f556b668eb136af
        failing since 40 days (last pass: v4.19.194-cip51, first fail: v4.1=
9.196-cip53)

    2021-08-18T16:29:56.102860  /lava-4377601/1/../bin/lava-test-case
    2021-08-18T16:29:56.103261  <8>[   14.951016] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwmmc_rockchip-sdio0-probed RESULT=3Dfail>   =


  * baseline.bootrr.dwmmc_rockchip-sdmmc-probed: https://kernelci.org/test/=
case/id/611d35970f556b668eb136b0
        failing since 40 days (last pass: v4.19.194-cip51, first fail: v4.1=
9.196-cip53)

    2021-08-18T16:29:55.081926  /lava-4377601/1/../bin/lava-test-case
    2021-08-18T16:29:55.087100  <8>[   13.931800] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwmmc_rockchip-sdmmc-probed RESULT=3Dfail>   =

 =20

--QsZS9IOpZDr0dgX0hE3I
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6688): https://lists.cip-project.org/g/cip-dev/message/=
6688
Mute This Topic: https://lists.cip-project.org/mt/84976767/4520388
Mute #kernelci:https://lists.cip-project.org/g/cip-dev/mutehashtag/kernelci
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--QsZS9IOpZDr0dgX0hE3I--
