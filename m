Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8851FCE79A8
	for <webhook@archiver.kernel.org>; Tue, 19 Sep 2023 23:12:15 +0000 (UTC)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
 by mx.groups.io with SMTP id smtpd.web10.24703.1695165125844745895
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 19 Sep 2023 16:12:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=MRFt19HR;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.54, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2746ab05409so3974596a91.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 19 Sep 2023 16:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695165125; x=1695769925; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jE3Uhm9UvGIpWCQsdUQxZhb3FlqJjaxotb5DJU9I1OI=;
        b=MRFt19HRMiBFe8PvRBkHL4pM158hVJggANV0Qqp726mC7wDs7zxf78RQUwhVhvZl4w
         MZIFu3ky04Fw4brf/91Xy1IMu448cYMdkqiZSw9cGHbt0cWKZyCTOJOIR3AJ+H8AAMSx
         XK5Lp4sZnSBC3GCgPC04Oszq1vb10sutwAc17IzIviGuNQ2itexZcilWEV/qkhUVHTpZ
         m+aHdkdqmBz694u8FB9/T0v5o6mX3unArYCaM0xKKdkcxZPUWUNnbR6he3B0MUhUMUNI
         RCDNbzk/cWFIwHGOB6+3Cx6a0Jx1oGAAElpE77urHCFPClDD0YJwEHjJVzvlotkJA3UP
         rRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695165125; x=1695769925;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jE3Uhm9UvGIpWCQsdUQxZhb3FlqJjaxotb5DJU9I1OI=;
        b=E2rxe6VX/vJwGGfhf/Oa8q6YuBI8eCnvI4uJYjIok26C24OZgOsFgFUm/KsoZeUBlg
         1segtw9PNSuNODK+EJKlZVRvJhzkn5yvxLNyUP6A/Dp1KZNmMTxGG3jkR/gFeiLpcmfp
         5yX1vSkw496cWwdvf5EusS0WPoKAMNg2NdVraGw6cbWZ04RCV73FjqRYvlaPjVjeLai+
         V5PX+Wx3IMxF3SvTZKUDbwAwmB8wsdOkpl1VXoirBxy5uPBWjhKON2b3SsFTdtCgL81c
         tWeQHn6ouKbm3eXnqBcw+CyhX9nM2OW8HvSj+X85pKsMbdZ7MuF2kzM0+LlLTNecsOqg
         nQJw==
X-Gm-Message-State: AOJu0YxyhYgWG+vqMUEvgX1achZaCrO5Apyd+jPsUEpxrCxjE59QcXJ5
	h5GioI/72g90fV6NHxMF0vE013fD/oz4jFKnQHpGAw==
X-Google-Smtp-Source: AGHT+IH+ogzC/Bel3/TpLcRFSDBNIOk+l2bnYXCPV76yyQE6sembRahC1A35YUYBZeE7afTt+HPLVA==
X-Received: by 2002:a17:90b:1288:b0:269:3771:7342 with SMTP id fw8-20020a17090b128800b0026937717342mr1019540pjb.18.1695165124525;
        Tue, 19 Sep 2023 16:12:04 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id n92-20020a17090a5ae500b002680dfd368dsm119805pji.51.2023.09.19.16.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 16:12:03 -0700 (PDT)
Message-ID: <650a2ac3.170a0220.a8cfb.0b0c@mx.google.com>
Date: Tue, 19 Sep 2023 16:12:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.194-cip39-rt16
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip-rt baseline-nfs: 35 runs,
 15 regressions (v5.10.194-cip39-rt16)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 19 Sep 2023 23:12:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13168

cip/linux-5.10.y-cip-rt baseline-nfs: 35 runs, 15 regressions (v5.10.194-ci=
p39-rt16)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =

imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+preempt_rt         | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+preempt_rt         | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.194-cip39-rt16/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.194-cip39-rt16
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      7aa1fa8ed3b5d0130443043c96b985082bf55241 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/650a1e3e42278b55e08a0a60

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/650a1e3e42278b55e08a0a69
        failing since 235 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-09-19T22:18:15.953947  + set +x

    2023-09-19T22:18:15.958718  <8>[   16.747268] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11574705_1.5.2.3.1>

    2023-09-19T22:18:16.068090  #

    2023-09-19T22:18:16.170964  / # #export SHELL=3D/bin/sh

    2023-09-19T22:18:16.171736  =


    2023-09-19T22:18:16.273567  / # export SHELL=3D/bin/sh. /lava-11574705/=
environment

    2023-09-19T22:18:16.274447  =


    2023-09-19T22:18:16.376177  / # . /lava-11574705/environment/lava-11574=
705/bin/lava-test-runner /lava-11574705/1

    2023-09-19T22:18:16.377479  =


    2023-09-19T22:18:16.379448  / # /lava-11574705/bin/lava-test-runner /la=
va-11574705/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/650a1e61692cdc98568a0a7a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/650a1e61692cdc98568a0a83
        failing since 235 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-09-19T22:19:00.744099  + set +x

    2023-09-19T22:19:00.751076  <8>[   18.406465] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11574746_1.5.2.3.1>

    2023-09-19T22:19:00.854374  #

    2023-09-19T22:19:00.854701  =


    2023-09-19T22:19:00.955319  / # #export SHELL=3D/bin/sh

    2023-09-19T22:19:00.955543  =


    2023-09-19T22:19:01.056090  / # export SHELL=3D/bin/sh. /lava-11574746/=
environment

    2023-09-19T22:19:01.056331  =


    2023-09-19T22:19:01.156881  / # . /lava-11574746/environment/lava-11574=
746/bin/lava-test-runner /lava-11574746/1

    2023-09-19T22:19:01.157182  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/650a202858643b6df28a0a7f

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-beagl=
ebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-beagl=
ebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/650a202858643b6df28a0aae
        failing since 235 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-09-19T22:26:02.390049  <8>[   54.400458] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 118996_1.6.2.4.1>
    2023-09-19T22:26:02.504678  / # #
    2023-09-19T22:26:02.607713  export SHELL=3D/bin/sh
    2023-09-19T22:26:02.608431  #
    2023-09-19T22:26:02.710772  / # export SHELL=3D/bin/sh. /lava-118996/en=
vironment
    2023-09-19T22:26:02.711479  =

    2023-09-19T22:26:02.813596  / # . /lava-118996/environment/lava-118996/=
bin/lava-test-runner /lava-118996/1
    2023-09-19T22:26:02.814652  =

    2023-09-19T22:26:02.822659  / # /lava-118996/bin/lava-test-runner /lava=
-118996/1
    2023-09-19T22:26:03.045034  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/650a202358643b6df28a0a4c

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebon=
e-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebon=
e-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/650a202358643b6df28a0a53
        failing since 235 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-09-19T22:25:45.273517  <8>[   47.501704] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1010657_1.6.2.4.1>
    2023-09-19T22:25:45.433412  / # #
    2023-09-19T22:25:45.536012  export SHELL=3D/bin/sh
    2023-09-19T22:25:45.536739  #
    2023-09-19T22:25:45.638538  / # export SHELL=3D/bin/sh. /lava-1010657/e=
nvironment
    2023-09-19T22:25:45.639243  =

    2023-09-19T22:25:45.741088  / # . /lava-1010657/environment/lava-101065=
7/bin/lava-test-runner /lava-1010657/1
    2023-09-19T22:25:45.742255  =

    2023-09-19T22:25:45.748157  / # /lava-1010657/bin/lava-test-runner /lav=
a-1010657/1
    2023-09-19T22:25:46.072115  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/650a2088e02c53f6ba8a0b23

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nfs-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nfs-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/650a2088e02c53f6ba8a0b5d
        failing since 181 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.175-cip29-rt12)

    2023-09-19T22:27:50.506183  + set +x
    2023-09-19T22:27:50.523083  <8>[   44.477739] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 119007_1.6.2.4.1>
    2023-09-19T22:27:50.629916  #
    2023-09-19T22:27:50.733531  / # #export SHELL=3D/bin/sh
    2023-09-19T22:27:50.734454  =

    2023-09-19T22:27:50.836425  / # export SHELL=3D/bin/sh. /lava-119007/en=
vironment
    2023-09-19T22:27:50.837043  =

    2023-09-19T22:27:50.938735  / # . /lava-119007/environment/lava-119007/=
bin/lava-test-runner /lava-119007/1
    2023-09-19T22:27:50.940008  =

    2023-09-19T22:27:50.943481  / # /lava-119007/bin/lava-test-runner /lava=
-119007/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/650a217e9c9a1780bf8a0a42

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebo=
ne-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebo=
ne-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/650a217e9c9a1780bf8a0a49
        failing since 181 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.175-cip29-rt12)

    2023-09-19T22:32:12.342681  <8>[   39.294042] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1010662_1.6.2.4.1>
    2023-09-19T22:32:12.456662  #
    2023-09-19T22:32:12.558796  / # #export SHELL=3D/bin/sh
    2023-09-19T22:32:12.559254  =

    2023-09-19T22:32:12.660656  / # export SHELL=3D/bin/sh. /lava-1010662/e=
nvironment
    2023-09-19T22:32:12.661117  =

    2023-09-19T22:32:12.762526  / # . /lava-1010662/environment/lava-101066=
2/bin/lava-test-runner /lava-1010662/1
    2023-09-19T22:32:12.763280  =

    2023-09-19T22:32:12.765196  / # /lava-1010662/bin/lava-test-runner /lav=
a-1010662/1
    2023-09-19T22:32:13.021411  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/650a1f6ca67b12eb688a0a44

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/650a1f6ca67b12eb688a0a4d
        failing since 123 days (last pass: v5.10.175-cip29-rt12, first fail=
: v5.10.179-cip32-rt13)

    2023-09-19T22:23:20.148682  <8>[   16.625190] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11574696_1.5.2.3.1>

    2023-09-19T22:23:20.250298  #

    2023-09-19T22:23:20.250612  =


    2023-09-19T22:23:20.351219  / # #export SHELL=3D/bin/sh

    2023-09-19T22:23:20.351380  =


    2023-09-19T22:23:20.451935  / # export SHELL=3D/bin/sh. /lava-11574696/=
environment

    2023-09-19T22:23:20.452100  =


    2023-09-19T22:23:20.552688  / # . /lava-11574696/environment/lava-11574=
696/bin/lava-test-runner /lava-11574696/1

    2023-09-19T22:23:20.552983  =


    2023-09-19T22:23:20.557510  / # /lava-11574696/bin/lava-test-runner /la=
va-11574696/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/650a1fd1ad06e56c908a0b60

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/650a1fd1ad06e56c908a0b69
        failing since 123 days (last pass: v5.10.175-cip29-rt12, first fail=
: v5.10.179-cip32-rt13)

    2023-09-19T22:25:02.906423  <8>[   20.851855] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11574741_1.5.2.3.1>

    2023-09-19T22:25:03.008016  #

    2023-09-19T22:25:03.008256  =


    2023-09-19T22:25:03.008343  <6>[   20.869314] lava-test-runne (278) use=
d greatest stack depth: 12184 bytes left

    2023-09-19T22:25:03.108911  / # #export SHELL=3D/bin/sh

    2023-09-19T22:25:03.109071  =


    2023-09-19T22:25:03.209551  / # export SHELL=3D/bin/sh. /lava-11574741/=
environment

    2023-09-19T22:25:03.209702  =


    2023-09-19T22:25:03.310186  / # . /lava-11574741/environment/lava-11574=
741/bin/lava-test-runner /lava-11574741/1

    2023-09-19T22:25:03.310435  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/650a1e9952cdcbd9508a0a78

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/650a1e9952cdcbd95=
08a0a79
        new failure (last pass: v5.10.186-cip37-rt15) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/650a21df187282727a8a0a42

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm/defconfig/gcc-10/lab-collabora/baseline-nfs-imx6q-sabrel=
ite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm/defconfig/gcc-10/lab-collabora/baseline-nfs-imx6q-sabrel=
ite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/650a21df187282727a8a0a4a
        failing since 235 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-09-19T22:33:55.166422  + set +x

    2023-09-19T22:33:55.167091  =


    2023-09-19T22:33:55.167296  / # <8>[   25.952444] <LAVA_SIGNAL_ENDRUN 0=
_dmesg 11574914_1.6.2.4.1>

    2023-09-19T22:33:55.270775  #

    2023-09-19T22:33:55.372792  export SHELL=3D/bin/sh

    2023-09-19T22:33:55.373430  #

    2023-09-19T22:33:55.474778  / # export SHELL=3D/bin/sh. /lava-11574914/=
environment

    2023-09-19T22:33:55.475443  =


    2023-09-19T22:33:55.576832  / # . /lava-11574914/environment/lava-11574=
914/bin/lava-test-runner /lava-11574914/1

    2023-09-19T22:33:55.577811  =

 =

    ... (17 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/650a1fbdad06e56c908a0a74

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-nfs-imx=
6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-nfs-imx=
6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/650a1fbdad06e56c908a0a7d
        failing since 235 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-09-19T22:26:40.891599  / # #

    2023-09-19T22:26:40.993739  export SHELL=3D/bin/sh

    2023-09-19T22:26:40.994388  #

    2023-09-19T22:26:41.095798  / # export SHELL=3D/bin/sh. /lava-11574825/=
environment

    2023-09-19T22:26:41.096494  =


    2023-09-19T22:26:41.197959  / # . /lava-11574825/environment/lava-11574=
825/bin/lava-test-runner /lava-11574825/1

    2023-09-19T22:26:41.199013  =


    2023-09-19T22:26:41.241484  / # /lava-11574825/bin/lava-test-runner /la=
va-11574825/1

    2023-09-19T22:26:41.352158  + export TESTRUN_ID=3D1_bootrr

    2023-09-19T22:26:41.352312  + cd /lava-11574825/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/650a20c8d3050384a48a0a43

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm64/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-nfs-m=
eson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm64/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-nfs-m=
eson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/650a20c8d3050384a=
48a0a44
        failing since 181 days (last pass: v5.10.162-cip24-rt10, first fail=
: v5.10.175-cip29-rt12) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/650a22308b19384b128a0a78

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-meson-gxl-s9=
05x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-meson-gxl-s9=
05x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/650a22308b19384b1=
28a0a79
        new failure (last pass: v5.10.179-cip32-rt13) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/650a211a9a4d14edb98a0a65

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm64/defconfig+preempt_rt/gcc-10/lab-cip/baseline-nfs-r8a77=
4a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm64/defconfig+preempt_rt/gcc-10/lab-cip/baseline-nfs-r8a77=
4a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/650a211b9a4d14edb=
98a0a66
        new failure (last pass: v5.10.186-cip37-rt15) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/650a22b93ec7031d838a0a43

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm64/defconfig/gcc-10/lab-cip/baseline-nfs-r8a774a1-hihope-=
rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm64/defconfig/gcc-10/lab-cip/baseline-nfs-r8a774a1-hihope-=
rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/650a22b93ec7031d8=
38a0a44
        new failure (last pass: v5.10.186-cip37-rt15) =

 =20

