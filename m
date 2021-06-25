Return-Path: <SRS0=Ks77=LT=lists.cip-project.org=bounce+64572+6582+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83D2C49EA7
	for <cip-dev@archiver.kernel.org>; Fri, 25 Jun 2021 11:57:30 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D3146161E
	for <cip-dev@archiver.kernel.org>; Fri, 25 Jun 2021 11:57:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D3146161E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6582+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id MdlhYY4521723xLhhnTozoJe; Fri, 25 Jun 2021 04:57:29 -0700
X-Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
 by mx.groups.io with SMTP id smtpd.web10.6489.1624622249410571808
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 25 Jun 2021 04:57:29 -0700
X-Received: by mail-pf1-f179.google.com with SMTP id 21so7873078pfp.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 25 Jun 2021 04:57:29 -0700 (PDT)
X-Gm-Message-State: SQ2oYXB8bj2f5N28YJowy79lx4520388AA=
X-Google-Smtp-Source: ABdhPJwyWcQeI8B52jW3HJKiT3phy+79nxk6aDrh6EhkFIBapbvA2sLD1pVRBwCTPwAa4kMsure7VQ==
X-Received: by 2002:a05:6a00:1913:b029:2ec:8f20:4ea with SMTP id y19-20020a056a001913b02902ec8f2004eamr10374698pfi.3.1624622248730;
        Fri, 25 Jun 2021 04:57:28 -0700 (PDT)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id v8sm5396657pff.34.2021.06.25.04.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 04:57:28 -0700 (PDT)
Message-ID: <60d5c4a8.1c69fb81.33d33.f151@mx.google.com>
Date: Fri, 25 Jun 2021 04:57:28 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.195-cip52-rt20
X-Kernelci-Branch: linux-4.19.y-cip-rt
X-Kernelci-Tree: cip
Subject: [cip-dev] cip/linux-4.19.y-cip-rt baseline: 212 runs, 15 regressions (v4.19.195-cip52-rt20) #kernelci
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
Content-Type: multipart/mixed; boundary="X6QscVDMGJPfe0dya8YH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1624622249;
 bh=XUwm2JW45e2dMLew+4a6SA91DudGff4FtUmAv9HY/I0=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=UKQYL1mxVgQedleB2Nu1eViE2eJr2x0+WPt3w4GmiT/kBbg/QQx1U3p4JAwx8U+bu32
 RpnOhfe3kPCIsc6RLilAH9EUjuPs0wL22vne+4JrzaG/xt+9vU3Ri/w5vZUixso7NaQKS
 srJwI1eQCbYDHsUjurylzS7fg/0A+7baemU=

--X6QscVDMGJPfe0dya8YH
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.19.y-cip-rt baseline: 212 runs, 15 regressions (v4.19.195-cip52=
-rt20)

Regressions Summary
-------------------

platform             | arch | lab           | compiler | defconfig         =
           | regressions
---------------------+------+---------------+----------+-------------------=
-----------+------------
qemu_arm-versatilepb | arm  | lab-baylibre  | gcc-8    | versatile_defconfi=
g          | 1          =

qemu_arm-versatilepb | arm  | lab-broonie   | gcc-8    | versatile_defconfi=
g          | 1          =

qemu_arm-versatilepb | arm  | lab-cip       | gcc-8    | versatile_defconfi=
g          | 1          =

qemu_arm-versatilepb | arm  | lab-collabora | gcc-8    | versatile_defconfi=
g          | 1          =

rk3288-veyron-jaq    | arm  | lab-collabora | gcc-8    | multi_v7_defconfig=
           | 3          =

rk3288-veyron-jaq    | arm  | lab-collabora | gcc-8    | multi_v7_defc...CO=
NFIG_SMP=3Dn | 4          =

rk3288-veyron-jaq    | arm  | lab-collabora | gcc-8    | multi_v7_defc...G_=
ARM_LPAE=3Dy | 3          =

tegra124-nyan-big    | arm  | lab-collabora | gcc-8    | tegra_defconfig   =
           | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip-rt/ke=
rnel/v4.19.195-cip52-rt20/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.19.y-cip-rt
  Describe: v4.19.195-cip52-rt20
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      7f732dada94956f37e51436f20562ae815aa3bf7 =



Test Regressions
---------------- =



platform             | arch | lab           | compiler | defconfig         =
           | regressions
---------------------+------+---------------+----------+-------------------=
-----------+------------
qemu_arm-versatilepb | arm  | lab-baylibre  | gcc-8    | versatile_defconfi=
g          | 1          =


  Details:     https://kernelci.org/test/plan/id/60d5b5ba7f11036c4d41329b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: versatile_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
195-cip52-rt20/arm/versatile_defconfig/gcc-8/lab-baylibre/baseline-qemu_arm=
-versatilepb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
195-cip52-rt20/arm/versatile_defconfig/gcc-8/lab-baylibre/baseline-qemu_arm=
-versatilepb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60d5b5ba7f11036c4d413=
29c
        failing since 208 days (last pass: v4.19.152-cip37-rt16, first fail=
: v4.19.160-cip39-rt17) =

 =



platform             | arch | lab           | compiler | defconfig         =
           | regressions
---------------------+------+---------------+----------+-------------------=
-----------+------------
qemu_arm-versatilepb | arm  | lab-broonie   | gcc-8    | versatile_defconfi=
g          | 1          =


  Details:     https://kernelci.org/test/plan/id/60d5b5b67f11036c4d413283

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: versatile_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
195-cip52-rt20/arm/versatile_defconfig/gcc-8/lab-broonie/baseline-qemu_arm-=
versatilepb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
195-cip52-rt20/arm/versatile_defconfig/gcc-8/lab-broonie/baseline-qemu_arm-=
versatilepb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60d5b5b67f11036c4d413=
284
        failing since 208 days (last pass: v4.19.152-cip37-rt16, first fail=
: v4.19.160-cip39-rt17) =

 =



platform             | arch | lab           | compiler | defconfig         =
           | regressions
---------------------+------+---------------+----------+-------------------=
-----------+------------
qemu_arm-versatilepb | arm  | lab-cip       | gcc-8    | versatile_defconfi=
g          | 1          =


  Details:     https://kernelci.org/test/plan/id/60d5b5a47f11036c4d41326b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: versatile_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
195-cip52-rt20/arm/versatile_defconfig/gcc-8/lab-cip/baseline-qemu_arm-vers=
atilepb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
195-cip52-rt20/arm/versatile_defconfig/gcc-8/lab-cip/baseline-qemu_arm-vers=
atilepb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60d5b5a47f11036c4d413=
26c
        failing since 208 days (last pass: v4.19.152-cip37-rt16, first fail=
: v4.19.160-cip39-rt17) =

 =



platform             | arch | lab           | compiler | defconfig         =
           | regressions
---------------------+------+---------------+----------+-------------------=
-----------+------------
qemu_arm-versatilepb | arm  | lab-collabora | gcc-8    | versatile_defconfi=
g          | 1          =


  Details:     https://kernelci.org/test/plan/id/60d5c2bc305a0999fd41328d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: versatile_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
195-cip52-rt20/arm/versatile_defconfig/gcc-8/lab-collabora/baseline-qemu_ar=
m-versatilepb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
195-cip52-rt20/arm/versatile_defconfig/gcc-8/lab-collabora/baseline-qemu_ar=
m-versatilepb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60d5c2bc305a0999fd413=
28e
        failing since 208 days (last pass: v4.19.152-cip37-rt16, first fail=
: v4.19.160-cip39-rt17) =

 =



platform             | arch | lab           | compiler | defconfig         =
           | regressions
---------------------+------+---------------+----------+-------------------=
-----------+------------
rk3288-veyron-jaq    | arm  | lab-collabora | gcc-8    | multi_v7_defconfig=
           | 3          =


  Details:     https://kernelci.org/test/plan/id/60d5bce7ab08fc4ff54132ba

  Results:     63 PASS, 6 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
195-cip52-rt20/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-rk3288-v=
eyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
195-cip52-rt20/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-rk3288-v=
eyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.bootrr.dwmmc_rockchip-sdmmc-probed: https://kernelci.org/test/=
case/id/60d5bce7ab08fc4ff54132d6
        new failure (last pass: v4.19.182-cip45-rt19)

    2021-06-25T11:24:15.340988  /lava-4093696/1/../bin/lava-test-case
    2021-06-25T11:24:15.346193  <8>[   14.976518] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwmmc_rockchip-sdmmc-probed RESULT=3Dfail>   =


  * baseline.bootrr.dwmmc_rockchip-sdio0-probed: https://kernelci.org/test/=
case/id/60d5bce7ab08fc4ff54132d7
        new failure (last pass: v4.19.182-cip45-rt19)

    2021-06-25T11:24:16.359788  /lava-4093696/1/../bin/lava-test-case
    2021-06-25T11:24:16.377953  <8>[   15.996046] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwmmc_rockchip-sdio0-probed RESULT=3Dfail>
    2021-06-25T11:24:16.378465  /lava-4093696/1/../bin/lava-test-case   =


  * baseline.bootrr.rockchip-iodomain-grf-probed: https://kernelci.org/test=
/case/id/60d5bce7ab08fc4ff54132f0
        new failure (last pass: v4.19.182-cip45-rt19)

    2021-06-25T11:24:18.802652  /lava-4093696/1/../bin/lava-test-case
    2021-06-25T11:24:18.819852  <8>[   18.439161] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-iodomain-grf-probed RESULT=3Dfail>
    2021-06-25T11:24:18.820396  /lava-4093696/1/../bin/lava-test-case   =

 =



platform             | arch | lab           | compiler | defconfig         =
           | regressions
---------------------+------+---------------+----------+-------------------=
-----------+------------
rk3288-veyron-jaq    | arm  | lab-collabora | gcc-8    | multi_v7_defc...CO=
NFIG_SMP=3Dn | 4          =


  Details:     https://kernelci.org/test/plan/id/60d5c2aa358250f0ae41327c

  Results:     62 PASS, 7 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
195-cip52-rt20/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-collabora/ba=
seline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
195-cip52-rt20/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-collabora/ba=
seline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.bootrr.cros-ec-keyb-probed: https://kernelci.org/test/case/id/=
60d5c2aa358250f0ae413289
        new failure (last pass: v4.19.182-cip45-rt19)

    2021-06-25T11:48:47.558821  /lava-4093742/1/../bin/lava-test-case<8>[  =
 15.124968] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dcros-ec-keyb-probed RESULT=
=3Dfail>   =


  * baseline.bootrr.dwmmc_rockchip-sdmmc-probed: https://kernelci.org/test/=
case/id/60d5c2aa358250f0ae413298
        new failure (last pass: v4.19.182-cip45-rt19)

    2021-06-25T11:48:48.835712  /lava-4093742/1/../bin/lava-test-case<8>[  =
 16.396393] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwmmc_rockchip-sdmmc-probe=
d RESULT=3Dfail>
    2021-06-25T11:48:48.836345     =


  * baseline.bootrr.dwmmc_rockchip-sdio0-probed: https://kernelci.org/test/=
case/id/60d5c2aa358250f0ae413299
        new failure (last pass: v4.19.182-cip45-rt19)

    2021-06-25T11:48:49.865802  /lava-4093742/1/../bin/lava-test-case<8>[  =
 17.415410] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwmmc_rockchip-sdio0-probe=
d RESULT=3Dfail>
    2021-06-25T11:48:49.866323     =


  * baseline.bootrr.rockchip-iodomain-grf-probed: https://kernelci.org/test=
/case/id/60d5c2aa358250f0ae4132b2
        new failure (last pass: v4.19.182-cip45-rt19)

    2021-06-25T11:48:52.286433  /lava-4093742/1/../bin/lava-test-case<8>[  =
 19.850885] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Drockchip-iodomain-grf-prob=
ed RESULT=3Dfail>
    2021-06-25T11:48:52.287036     =

 =



platform             | arch | lab           | compiler | defconfig         =
           | regressions
---------------------+------+---------------+----------+-------------------=
-----------+------------
rk3288-veyron-jaq    | arm  | lab-collabora | gcc-8    | multi_v7_defc...G_=
ARM_LPAE=3Dy | 3          =


  Details:     https://kernelci.org/test/plan/id/60d5c356b2cb9f0a46413276

  Results:     63 PASS, 6 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_EFI=3Dy+CONFIG_ARM_LPAE=3Dy
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
195-cip52-rt20/arm/multi_v7_defconfig+CONFIG_EFI=3Dy+CONFIG_ARM_LPAE=3Dy/gc=
c-8/lab-collabora/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
195-cip52-rt20/arm/multi_v7_defconfig+CONFIG_EFI=3Dy+CONFIG_ARM_LPAE=3Dy/gc=
c-8/lab-collabora/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.bootrr.dwmmc_rockchip-sdmmc-probed: https://kernelci.org/test/=
case/id/60d5c356b2cb9f0a46413292
        new failure (last pass: v4.19.182-cip45-rt19)

    2021-06-25T11:51:43.022548  /lava-4093790/1/../bin/lava-test-case
    2021-06-25T11:51:43.028128  <8>[   14.079034] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwmmc_rockchip-sdmmc-probed RESULT=3Dfail>   =


  * baseline.bootrr.dwmmc_rockchip-sdio0-probed: https://kernelci.org/test/=
case/id/60d5c356b2cb9f0a46413293
        new failure (last pass: v4.19.182-cip45-rt19)

    2021-06-25T11:51:44.058673  /lava-4093790/1/../bin/lava-test-case<8>[  =
 15.098328] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwmmc_rockchip-sdio0-probe=
d RESULT=3Dfail>
    2021-06-25T11:51:44.059102  =

    2021-06-25T11:51:44.059367  /lava-4093790/1/../bin/lava-test-case   =


  * baseline.bootrr.rockchip-iodomain-grf-probed: https://kernelci.org/test=
/case/id/60d5c356b2cb9f0a464132ac
        new failure (last pass: v4.19.182-cip45-rt19)

    2021-06-25T11:51:46.483621  /lava-4093790/1/../bin/lava-test-case
    2021-06-25T11:51:46.499347  <8>[   17.539516] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-iodomain-grf-probed RESULT=3Dfail>
    2021-06-25T11:51:46.499616  /lava-4093790/1/../bin/lava-test-case   =

 =



platform             | arch | lab           | compiler | defconfig         =
           | regressions
---------------------+------+---------------+----------+-------------------=
-----------+------------
tegra124-nyan-big    | arm  | lab-collabora | gcc-8    | tegra_defconfig   =
           | 1          =


  Details:     https://kernelci.org/test/plan/id/60d5be3acc3f4d18264132c3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: tegra_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
195-cip52-rt20/arm/tegra_defconfig/gcc-8/lab-collabora/baseline-tegra124-ny=
an-big.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
195-cip52-rt20/arm/tegra_defconfig/gcc-8/lab-collabora/baseline-tegra124-ny=
an-big.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60d5be3acc3f4d1826413=
2c4
        new failure (last pass: v4.19.160-cip39-rt17) =

 =20

--X6QscVDMGJPfe0dya8YH
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6582): https://lists.cip-project.org/g/cip-dev/message=
/6582
Mute This Topic: https://lists.cip-project.org/mt/83782326/4520388
Mute #kernelci:https://lists.cip-project.org/g/cip-dev/mutehashtag/kernelc=
i
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--X6QscVDMGJPfe0dya8YH--
