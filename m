Return-Path: <SRS0=15z/=PA=lists.cip-project.org=bounce+64572+6811+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446D4C433EF
	for <cip-dev@archiver.kernel.org>; Tue, 12 Oct 2021 19:12:31 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D41B660C4A
	for <cip-dev@archiver.kernel.org>; Tue, 12 Oct 2021 19:12:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D41B660C4A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 5mpjYY4521723xdVBTO0q04g; Tue, 12 Oct 2021 12:12:30 -0700
X-Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
 by mx.groups.io with SMTP id smtpd.web09.18694.1634065950132008491
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 12 Oct 2021 12:12:30 -0700
X-Received: by mail-pg1-f176.google.com with SMTP id q5so45539pgr.7
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 12 Oct 2021 12:12:30 -0700 (PDT)
X-Gm-Message-State: 9RFZWPaqH7389EowAB1lSinPx4520388AA=
X-Google-Smtp-Source: ABdhPJzJWDdAqNGhdPTbUSTWkNlmS7E6InAgLsobDf8fffHzgM8IbQvBS13UmiVa5G86oLkVngLaGw==
X-Received: by 2002:a62:7f4a:0:b0:44d:292f:cc24 with SMTP id a71-20020a627f4a000000b0044d292fcc24mr9933864pfd.58.1634065949380;
        Tue, 12 Oct 2021 12:12:29 -0700 (PDT)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k1sm3467501pjj.54.2021.10.12.12.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 12:12:29 -0700 (PDT)
Message-ID: <6165de1d.1c69fb81.27246.a9b5@mx.google.com>
Date: Tue, 12 Oct 2021 12:12:29 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.209-cip59
Subject: [cip-dev] cip/linux-4.19.y-cip baseline: 210 runs, 10 regressions (v4.19.209-cip59) #kernelci
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
Content-Type: multipart/mixed; boundary="Wye2lB5no3lBaCyLaUuI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1634065950;
 bh=fxyatNkhY6uvJSUu+2taRiNYFGa+a+Hfo7nFvy+PiUM=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=EC0m/BPeHmvnxtg1Y+/q1R9Th3KZHWuHH6Yj9KvMHsIng/fz2iNOc+cgdbg1BuJWHmD
 xJnhBtamzI1yZUaCQNPQWma3HCTTsdzh5rXFFkrBVp9lCAhXO+uCBncaDpsWVTn1sStMD
 eln22fiGbb1zm8VsP+FqvTpCiF9XkGF+2v4=

--Wye2lB5no3lBaCyLaUuI
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.19.y-cip baseline: 210 runs, 10 regressions (v4.19.209-cip59)

Regressions Summary
-------------------

platform             | arch | lab           | compiler | defconfig         =
        | regressions
---------------------+------+---------------+----------+-------------------=
--------+------------
panda                | arm  | lab-collabora | gcc-8    | multi_v7_defconfig=
        | 1          =

panda                | arm  | lab-collabora | gcc-8    | multi_v7_defconfig=
+ima    | 1          =

panda                | arm  | lab-collabora | gcc-8    | multi_v7_defconfig=
+crypto | 1          =

panda                | arm  | lab-collabora | gcc-8    | omap2plus_defconfi=
g       | 1          =

qemu_arm-versatilepb | arm  | lab-baylibre  | gcc-8    | versatile_defconfi=
g       | 1          =

qemu_arm-versatilepb | arm  | lab-broonie   | gcc-8    | versatile_defconfi=
g       | 1          =

qemu_arm-versatilepb | arm  | lab-cip       | gcc-8    | versatile_defconfi=
g       | 1          =

rk3288-veyron-jaq    | arm  | lab-collabora | gcc-8    | multi_v7_defconfig=
        | 3          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.209-cip59/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.209-cip59
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      11e803e05e061dc32e92deb7bd73c20dfbc48ae5 =



Test Regressions
---------------- =



platform             | arch | lab           | compiler | defconfig         =
        | regressions
---------------------+------+---------------+----------+-------------------=
--------+------------
panda                | arm  | lab-collabora | gcc-8    | multi_v7_defconfig=
        | 1          =


  Details:     https://kernelci.org/test/plan/id/6165cd107f29df582808fad3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.209=
-cip59/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-panda.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.209=
-cip59/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-panda.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6165cd107f29df582808f=
ad4
        new failure (last pass: v4.19.206-cip57) =

 =



platform             | arch | lab           | compiler | defconfig         =
        | regressions
---------------------+------+---------------+----------+-------------------=
--------+------------
panda                | arm  | lab-collabora | gcc-8    | multi_v7_defconfig=
+ima    | 1          =


  Details:     https://kernelci.org/test/plan/id/6165ce89dd8617a0be08faef

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+ima
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.209=
-cip59/arm/multi_v7_defconfig+ima/gcc-8/lab-collabora/baseline-panda.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.209=
-cip59/arm/multi_v7_defconfig+ima/gcc-8/lab-collabora/baseline-panda.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6165ce89dd8617a0be08f=
af0
        new failure (last pass: v4.19.207-cip58) =

 =



platform             | arch | lab           | compiler | defconfig         =
        | regressions
---------------------+------+---------------+----------+-------------------=
--------+------------
panda                | arm  | lab-collabora | gcc-8    | multi_v7_defconfig=
+crypto | 1          =


  Details:     https://kernelci.org/test/plan/id/6165d2c797290488c108faea

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+crypto
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.209=
-cip59/arm/multi_v7_defconfig+crypto/gcc-8/lab-collabora/baseline-panda.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.209=
-cip59/arm/multi_v7_defconfig+crypto/gcc-8/lab-collabora/baseline-panda.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6165d2c797290488c108f=
aeb
        new failure (last pass: v4.19.207-cip58) =

 =



platform             | arch | lab           | compiler | defconfig         =
        | regressions
---------------------+------+---------------+----------+-------------------=
--------+------------
panda                | arm  | lab-collabora | gcc-8    | omap2plus_defconfi=
g       | 1          =


  Details:     https://kernelci.org/test/plan/id/6165d062d64f27e94c08faa7

  Results:     5 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.209=
-cip59/arm/omap2plus_defconfig/gcc-8/lab-collabora/baseline-panda.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.209=
-cip59/arm/omap2plus_defconfig/gcc-8/lab-collabora/baseline-panda.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/6165d062d64f27e=
94c08faaa
        new failure (last pass: v4.19.207-cip58)
        2 lines

    2021-10-12T18:13:40.205981  kern  :emerg : BUG: spinlock bad magic on C=
PU#0, udevd/99
    2021-10-12T18:13:40.214823  kern  :emerg :  lock: emif_lock+0x0/0xffffe=
cf4 [emif], .magic: dead4ead, .owner: <none>/-1, .owner_cpu: -1
    2021-10-12T18:13:40.232136  <8>[   22.398162] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D2>   =

 =



platform             | arch | lab           | compiler | defconfig         =
        | regressions
---------------------+------+---------------+----------+-------------------=
--------+------------
qemu_arm-versatilepb | arm  | lab-baylibre  | gcc-8    | versatile_defconfi=
g       | 1          =


  Details:     https://kernelci.org/test/plan/id/6165cb60b599dd2e5008faa8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: versatile_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.209=
-cip59/arm/versatile_defconfig/gcc-8/lab-baylibre/baseline-qemu_arm-versati=
lepb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.209=
-cip59/arm/versatile_defconfig/gcc-8/lab-baylibre/baseline-qemu_arm-versati=
lepb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6165cb60b599dd2e5008f=
aa9
        failing since 332 days (last pass: v4.19.152-cip37-37-g18852869b06b=
, first fail: v4.19.157-cip38) =

 =



platform             | arch | lab           | compiler | defconfig         =
        | regressions
---------------------+------+---------------+----------+-------------------=
--------+------------
qemu_arm-versatilepb | arm  | lab-broonie   | gcc-8    | versatile_defconfi=
g       | 1          =


  Details:     https://kernelci.org/test/plan/id/6165cbd2f8f0cd8e0a08faea

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: versatile_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.209=
-cip59/arm/versatile_defconfig/gcc-8/lab-broonie/baseline-qemu_arm-versatil=
epb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.209=
-cip59/arm/versatile_defconfig/gcc-8/lab-broonie/baseline-qemu_arm-versatil=
epb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6165cbd2f8f0cd8e0a08f=
aeb
        failing since 332 days (last pass: v4.19.152-cip37-37-g18852869b06b=
, first fail: v4.19.157-cip38) =

 =



platform             | arch | lab           | compiler | defconfig         =
        | regressions
---------------------+------+---------------+----------+-------------------=
--------+------------
qemu_arm-versatilepb | arm  | lab-cip       | gcc-8    | versatile_defconfi=
g       | 1          =


  Details:     https://kernelci.org/test/plan/id/6165cb8acf9fb71ef508fb26

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: versatile_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.209=
-cip59/arm/versatile_defconfig/gcc-8/lab-cip/baseline-qemu_arm-versatilepb.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.209=
-cip59/arm/versatile_defconfig/gcc-8/lab-cip/baseline-qemu_arm-versatilepb.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6165cb8acf9fb71ef508f=
b27
        failing since 332 days (last pass: v4.19.152-cip37-37-g18852869b06b=
, first fail: v4.19.157-cip38) =

 =



platform             | arch | lab           | compiler | defconfig         =
        | regressions
---------------------+------+---------------+----------+-------------------=
--------+------------
rk3288-veyron-jaq    | arm  | lab-collabora | gcc-8    | multi_v7_defconfig=
        | 3          =


  Details:     https://kernelci.org/test/plan/id/6165ccf0cb68e45b9608fac2

  Results:     64 PASS, 6 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.209=
-cip59/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-rk3288-veyron-ja=
q.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.209=
-cip59/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-rk3288-veyron-ja=
q.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-iodomain-grf-probed: https://kernelci.org/test=
/case/id/6165ccf0cb68e45b9608fada
        failing since 95 days (last pass: v4.19.194-cip51, first fail: v4.1=
9.196-cip53)

    2021-10-12T17:58:56.153845  /lava-4703593/1/../bin/lava-test-case<8>[  =
 18.386682] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Drockchip-iodomain-grf-prob=
ed RESULT=3Dfail>
    2021-10-12T17:58:56.154143  =

    2021-10-12T17:58:56.154334  /lava-4703593/1/../bin/lava-test-case   =


  * baseline.bootrr.dwmmc_rockchip-sdio0-probed: https://kernelci.org/test/=
case/id/6165ccf0cb68e45b9608faf2
        failing since 95 days (last pass: v4.19.194-cip51, first fail: v4.1=
9.196-cip53)

    2021-10-12T17:58:53.695037  /lava-4703593/1/../bin/lava-test-case
    2021-10-12T17:58:53.713465  <8>[   15.945648] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwmmc_rockchip-sdio0-probed RESULT=3Dfail>
    2021-10-12T17:58:53.713685  /lava-4703593/1/../bin/lava-test-case   =


  * baseline.bootrr.dwmmc_rockchip-sdmmc-probed: https://kernelci.org/test/=
case/id/6165ccf0cb68e45b9608faf3
        failing since 95 days (last pass: v4.19.194-cip51, first fail: v4.1=
9.196-cip53)

    2021-10-12T17:58:52.676159  /lava-4703593/1/../bin/lava-test-case
    2021-10-12T17:58:52.681373  <8>[   14.926156] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwmmc_rockchip-sdmmc-probed RESULT=3Dfail>   =

 =20

--Wye2lB5no3lBaCyLaUuI
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6811): https://lists.cip-project.org/g/cip-dev/message/=
6811
Mute This Topic: https://lists.cip-project.org/mt/86270797/4520388
Mute #kernelci:https://lists.cip-project.org/g/cip-dev/mutehashtag/kernelci
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--Wye2lB5no3lBaCyLaUuI--
