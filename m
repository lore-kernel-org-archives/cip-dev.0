Return-Path: <SRS0=IlSw=IV=lists.cip-project.org=bounce+64572+6317+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC59C433E0
	for <cip-dev@archiver.kernel.org>; Tue, 23 Mar 2021 15:29:36 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 572F961984
	for <cip-dev@archiver.kernel.org>; Tue, 23 Mar 2021 15:29:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 572F961984
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6317+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id RCUZYY4521723xqrcMG2BZo5; Tue, 23 Mar 2021 08:29:36 -0700
X-Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
 by mx.groups.io with SMTP id smtpd.web09.10796.1616513375608703442
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 23 Mar 2021 08:29:35 -0700
X-Received: by mail-pg1-f176.google.com with SMTP id e33so12070602pgm.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 23 Mar 2021 08:29:35 -0700 (PDT)
X-Gm-Message-State: 5CtB0BvwCAiXhraKgArLpLswx4520388AA=
X-Google-Smtp-Source: ABdhPJw5U9up5y/hJL0AwQadCyWjGWeI4nL6QdvYLGGvCtsjigSGpo0U3b1b2M2FdQoVTeKgrK2DUg==
X-Received: by 2002:aa7:9aaa:0:b029:1f3:dd0e:282d with SMTP id x10-20020aa79aaa0000b02901f3dd0e282dmr5273783pfi.38.1616513374649;
        Tue, 23 Mar 2021 08:29:34 -0700 (PDT)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g21sm17752790pfk.30.2021.03.23.08.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 08:29:34 -0700 (PDT)
Message-ID: <605a095e.1c69fb81.163b1.a85c@mx.google.com>
Date: Tue, 23 Mar 2021 08:29:34 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Kernel: v4.19.182-cip45-40-g0e469137cd784
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip
Subject: [cip-dev] cip/linux-4.19.y-cip baseline: 241 runs, 7 regressions (v4.19.182-cip45-40-g0e469137cd784) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="J4FguTRPxjD1U887BOQF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1616513376;
 bh=xAQSIkXNkh7mhl+TlJx4e2aoETGEfhWir3xgIUOgIxY=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=fjvfsQI8XhVrYXIGzbwrb38xFdvYKe5cW4fNLYf56BjAjsd5WN7kUG7ikgQ0051LZ5E
 eru/khBEyHODGGlDm/ehwo/P2gVWgIy4ZfvDPP/cBK0DBmgCiIZ+yvgxgYQgmZ3neKEHe
 tdKcUu2PJlhx0LPqnuluR+rtCeo9gjvbhf0=

--J4FguTRPxjD1U887BOQF
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.19.y-cip baseline: 241 runs, 7 regressions (v4.19.182-cip45-40-=
g0e469137cd784)

Regressions Summary
-------------------

platform             | arch  | lab           | compiler | defconfig        =
            | regressions
---------------------+-------+---------------+----------+------------------=
------------+------------
meson-gxm-q200       | arm64 | lab-baylibre  | gcc-8    | defconfig+CON...O=
MIZE_BASE=3Dy | 1          =

meson-gxm-q200       | arm64 | lab-baylibre  | gcc-8    | defconfig        =
            | 1          =

qemu_arm-versatilepb | arm   | lab-baylibre  | gcc-8    | versatile_defconf=
ig          | 1          =

qemu_arm-versatilepb | arm   | lab-broonie   | gcc-8    | versatile_defconf=
ig          | 1          =

qemu_arm-versatilepb | arm   | lab-cip       | gcc-8    | versatile_defconf=
ig          | 1          =

qemu_arm-versatilepb | arm   | lab-collabora | gcc-8    | versatile_defconf=
ig          | 1          =

rk3288-veyron-jaq    | arm   | lab-collabora | gcc-8    | multi_v7_defc...C=
ONFIG_SMP=3Dn | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.182-cip45-40-g0e469137cd784/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.182-cip45-40-g0e469137cd784
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      0e469137cd784e952b10670400ce2b9143741fd2 =



Test Regressions
---------------- =



platform             | arch  | lab           | compiler | defconfig        =
            | regressions
---------------------+-------+---------------+----------+------------------=
------------+------------
meson-gxm-q200       | arm64 | lab-baylibre  | gcc-8    | defconfig+CON...O=
MIZE_BASE=3Dy | 1          =


  Details:     https://kernelci.org/test/plan/id/6059f78d5fa8793ff9addcd1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+CONFIG_RANDOMIZE_BASE=3Dy
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.182=
-cip45-40-g0e469137cd784/arm64/defconfig+CONFIG_RANDOMIZE_BASE=3Dy/gcc-8/la=
b-baylibre/baseline-meson-gxm-q200.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.182=
-cip45-40-g0e469137cd784/arm64/defconfig+CONFIG_RANDOMIZE_BASE=3Dy/gcc-8/la=
b-baylibre/baseline-meson-gxm-q200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6059f78d5fa8793ff9add=
cd2
        new failure (last pass: v4.19.182-cip45) =

 =



platform             | arch  | lab           | compiler | defconfig        =
            | regressions
---------------------+-------+---------------+----------+------------------=
------------+------------
meson-gxm-q200       | arm64 | lab-baylibre  | gcc-8    | defconfig        =
            | 1          =


  Details:     https://kernelci.org/test/plan/id/6059f96eddb38495bfaddce3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.182=
-cip45-40-g0e469137cd784/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-=
gxm-q200.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.182=
-cip45-40-g0e469137cd784/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-=
gxm-q200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6059f96eddb38495bfadd=
ce4
        new failure (last pass: v4.19.182-cip45) =

 =



platform             | arch  | lab           | compiler | defconfig        =
            | regressions
---------------------+-------+---------------+----------+------------------=
------------+------------
qemu_arm-versatilepb | arm   | lab-baylibre  | gcc-8    | versatile_defconf=
ig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6059f5fe46e212550eaddcdb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: versatile_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.182=
-cip45-40-g0e469137cd784/arm/versatile_defconfig/gcc-8/lab-baylibre/baselin=
e-qemu_arm-versatilepb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.182=
-cip45-40-g0e469137cd784/arm/versatile_defconfig/gcc-8/lab-baylibre/baselin=
e-qemu_arm-versatilepb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6059f5fe46e212550eadd=
cdc
        failing since 129 days (last pass: v4.19.152-cip37-37-g18852869b06b=
, first fail: v4.19.157-cip38) =

 =



platform             | arch  | lab           | compiler | defconfig        =
            | regressions
---------------------+-------+---------------+----------+------------------=
------------+------------
qemu_arm-versatilepb | arm   | lab-broonie   | gcc-8    | versatile_defconf=
ig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6059f5fcd21855dfd2addce8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: versatile_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.182=
-cip45-40-g0e469137cd784/arm/versatile_defconfig/gcc-8/lab-broonie/baseline=
-qemu_arm-versatilepb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.182=
-cip45-40-g0e469137cd784/arm/versatile_defconfig/gcc-8/lab-broonie/baseline=
-qemu_arm-versatilepb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6059f5fcd21855dfd2add=
ce9
        failing since 129 days (last pass: v4.19.152-cip37-37-g18852869b06b=
, first fail: v4.19.157-cip38) =

 =



platform             | arch  | lab           | compiler | defconfig        =
            | regressions
---------------------+-------+---------------+----------+------------------=
------------+------------
qemu_arm-versatilepb | arm   | lab-cip       | gcc-8    | versatile_defconf=
ig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6059f61ddbbd9a4c74addcf8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: versatile_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.182=
-cip45-40-g0e469137cd784/arm/versatile_defconfig/gcc-8/lab-cip/baseline-qem=
u_arm-versatilepb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.182=
-cip45-40-g0e469137cd784/arm/versatile_defconfig/gcc-8/lab-cip/baseline-qem=
u_arm-versatilepb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6059f61ddbbd9a4c74add=
cf9
        failing since 129 days (last pass: v4.19.152-cip37-37-g18852869b06b=
, first fail: v4.19.157-cip38) =

 =



platform             | arch  | lab           | compiler | defconfig        =
            | regressions
---------------------+-------+---------------+----------+------------------=
------------+------------
qemu_arm-versatilepb | arm   | lab-collabora | gcc-8    | versatile_defconf=
ig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6059f5bb0dcf69cd0baddcbf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: versatile_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.182=
-cip45-40-g0e469137cd784/arm/versatile_defconfig/gcc-8/lab-collabora/baseli=
ne-qemu_arm-versatilepb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.182=
-cip45-40-g0e469137cd784/arm/versatile_defconfig/gcc-8/lab-collabora/baseli=
ne-qemu_arm-versatilepb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6059f5bb0dcf69cd0badd=
cc0
        failing since 129 days (last pass: v4.19.152-cip37-37-g18852869b06b=
, first fail: v4.19.157-cip38) =

 =



platform             | arch  | lab           | compiler | defconfig        =
            | regressions
---------------------+-------+---------------+----------+------------------=
------------+------------
rk3288-veyron-jaq    | arm   | lab-collabora | gcc-8    | multi_v7_defc...C=
ONFIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/6059ffbfe77de17fccaddcb1

  Results:     65 PASS, 4 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.182=
-cip45-40-g0e469137cd784/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-co=
llabora/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.182=
-cip45-40-g0e469137cd784/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-co=
llabora/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.bootrr.cros-ec-keyb-probed: https://kernelci.org/test/case/id/=
6059ffbfe77de17fccaddcbe
        failing since 1 day (last pass: v4.19.177-cip44, first fail: v4.19.=
182-cip45) =

 =20

--J4FguTRPxjD1U887BOQF
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6317): https://lists.cip-project.org/g/cip-dev/message=
/6317
Mute This Topic: https://lists.cip-project.org/mt/81553658/4520388
Mute #kernelci:https://lists.cip-project.org/g/cip-dev/mutehashtag/kernelc=
i
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--J4FguTRPxjD1U887BOQF--
