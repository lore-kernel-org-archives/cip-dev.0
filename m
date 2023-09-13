Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070CCCA553C
	for <webhook@archiver.kernel.org>; Wed, 13 Sep 2023 16:24:21 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web10.1227.1694622259059763845
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 13 Sep 2023 09:24:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=ob3Z75p5;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.181, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1c35ee3b0d2so49537525ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 13 Sep 2023 09:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694622258; x=1695227058; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CScAlbOZVhna4gJrN02coG8ZtrjgxYFKH8f5PBO2DWQ=;
        b=ob3Z75p5zT5uaW5SC7kAMxEXeXRFxYWmJJAbItPgC9zR1ids4GpYw8mTBg4Jl11qz6
         5pJBRutkPsSI8ZKjK88PJcMamk83VDSwlw6MkNapq6n/wy53kvA4vllTdg3UAm1QI8c8
         lWEwnaxPui9Ds9TJEDD3ftUcfdm0IVZst5xKKnM0j2QFzbY1B0xQ2Jsjonayq9vhbM8n
         m5y9fq+g0vZn3Ep+ge2rpTOd907QF2+azGKSRgaX3Vbr4wpgdH68QootytYXozQx0/3z
         a3vj9qbu+kRxnokknUaM7TkOhjJkkyuh84tXEPcLCgZJ2vNfDu9wDwfmtHv0H6BTnwvJ
         8rKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694622258; x=1695227058;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CScAlbOZVhna4gJrN02coG8ZtrjgxYFKH8f5PBO2DWQ=;
        b=HVvWeCh1vEGXvTsh1QiNRoXYRcamk6U2+dknfBxBI+w6yx5Ky0oqgcVKFFkauvKbaZ
         YAXAn2K0MFwamHnF6j/Tmw1ceeS8qaV/y74jQEhZtebPIbcws5fG5oKuWhZ3MPNnRWq0
         3GLwRMgyByX2rN58t8NetFwCCIOURrrLggTXy/Xg82bBta46goJK7tEOZHkCq9wEzwuT
         /kP15GKBsHygyJsLf0IIqyx7woDyA5++XdziyGr8nY7taoR7of4v2FDHcDUrHkLax8oF
         N/3s1N2gq569Z4jgEokOeqPOTdraxGbxpsLLqky3ZYr5Xjzai47IIBguwRf+VqbxA3UV
         de2A==
X-Gm-Message-State: AOJu0YyWlzeduiG/1Vi+qt28xs5YhOxsIVPYSNFtMnEZz8Y+wLD93wUe
	y9DDnLdBTaNtZ3Wz+nr5QT9+MfiCFKIpGUGaAbI=
X-Google-Smtp-Source: AGHT+IFoX3zBqqK6BMXcEBaHdryA6nN8SYrzrPtr74kcKwSDzr6e7nlXgYNe6b/2sStL+y5t7VujAg==
X-Received: by 2002:a17:902:e5cf:b0:1c0:db5a:8c78 with SMTP id u15-20020a170902e5cf00b001c0db5a8c78mr3942267plf.68.1694622257671;
        Wed, 13 Sep 2023 09:24:17 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jh10-20020a170903328a00b001bbb25dd3a7sm10746136plb.187.2023.09.13.09.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 09:24:15 -0700 (PDT)
Message-ID: <6501e22f.170a0220.b1245.f746@mx.google.com>
Date: Wed, 13 Sep 2023 09:24:15 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.191-cip38-17-g8dad6b499cfe5
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip baseline-nfs: 22 runs,
 11 regressions (v5.10.191-cip38-17-g8dad6b499cfe5)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Sep 2023 16:24:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13106

cip/linux-5.10.y-cip baseline-nfs: 22 runs, 11 regressions (v5.10.191-cip38=
-17-g8dad6b499cfe5)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+kselftest          | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.191-cip38-17-g8dad6b499cfe5/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.191-cip38-17-g8dad6b499cfe5
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      8dad6b499cfe588bb00bdbed4e46649fe88260b1 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6501d736ac148b916d8a0aad

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline=
-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline=
-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6501d736ac148b916d8a0ade
        failing since 242 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-09-13T15:36:53.404489  <8>[   49.566050] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 105288_1.6.2.4.1>
    2023-09-13T15:36:53.521852  / # #
    2023-09-13T15:36:53.624486  export SHELL=3D/bin/sh
    2023-09-13T15:36:53.625199  #
    2023-09-13T15:36:53.727490  / # export SHELL=3D/bin/sh. /lava-105288/en=
vironment
    2023-09-13T15:36:53.728771  =

    2023-09-13T15:36:53.831580  / # . /lava-105288/environment/lava-105288/=
bin/lava-test-runner /lava-105288/1
    2023-09-13T15:36:53.832715  =

    2023-09-13T15:36:53.836285  / # /lava-105288/bin/lava-test-runner /lava=
-105288/1
    2023-09-13T15:36:54.063253  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6501d8353fbc16b5488a0a6d

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs=
-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs=
-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6501d8353fbc16b5488a0a74
        failing since 242 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-09-13T15:40:45.377628  <8>[   49.581538] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1008457_1.6.2.4.1>
    2023-09-13T15:40:45.540824  #
    2023-09-13T15:40:45.642387  / # #export SHELL=3D/bin/sh
    2023-09-13T15:40:45.642671  =

    2023-09-13T15:40:45.743771  / # export SHELL=3D/bin/sh. /lava-1008457/e=
nvironment
    2023-09-13T15:40:45.744056  =

    2023-09-13T15:40:45.845171  / # . /lava-1008457/environment/lava-100845=
7/bin/lava-test-runner /lava-1008457/1
    2023-09-13T15:40:45.845661  =

    2023-09-13T15:40:45.851505  / # /lava-1008457/bin/lava-test-runner /lav=
a-1008457/1
    2023-09-13T15:40:46.183994  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6501d6d2888fe94c668a0a50

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/arm/omap2plus_defconfig/gcc-10/lab-broonie/baselin=
e-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/arm/omap2plus_defconfig/gcc-10/lab-broonie/baselin=
e-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6501d6d2888fe94c668a0a8a
        failing since 242 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-09-13T15:35:29.232976  + set +x
    2023-09-13T15:35:29.236682  <8>[   46.958725] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 105269_1.6.2.4.1>
    2023-09-13T15:35:29.356054  / # #
    2023-09-13T15:35:29.459251  export SHELL=3D/bin/sh
    2023-09-13T15:35:29.459962  #
    2023-09-13T15:35:29.562122  / # export SHELL=3D/bin/sh. /lava-105269/en=
vironment
    2023-09-13T15:35:29.562684  =

    2023-09-13T15:35:29.664376  / # . /lava-105269/environment/lava-105269/=
bin/lava-test-runner /lava-105269/1
    2023-09-13T15:35:29.665579  =

    2023-09-13T15:35:29.669937  / # /lava-105269/bin/lava-test-runner /lava=
-105269/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6501d6ceb8068212b48a0a96

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nf=
s-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nf=
s-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6501d6ceb8068212b48a0a9d
        failing since 242 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-09-13T15:35:19.646764  + set +x
    2023-09-13T15:35:19.648935  <8>[   39.644350] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1008450_1.6.2.4.1>
    2023-09-13T15:35:19.767338  / # #
    2023-09-13T15:35:19.869212  export SHELL=3D/bin/sh
    2023-09-13T15:35:19.869657  #
    2023-09-13T15:35:19.971036  / # export SHELL=3D/bin/sh. /lava-1008450/e=
nvironment
    2023-09-13T15:35:19.971485  =

    2023-09-13T15:35:20.072884  / # . /lava-1008450/environment/lava-100845=
0/bin/lava-test-runner /lava-1008450/1
    2023-09-13T15:35:20.073612  =

    2023-09-13T15:35:20.075778  / # /lava-1008450/bin/lava-test-runner /lav=
a-1008450/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6501d714a0120d0d9c8a0a45

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6501d714a0120d0d9c8a0a4e
        failing since 152 days (last pass: v5.10.176-cip30, first fail: v5.=
10.177-cip31)

    2023-09-13T15:36:33.390305  + set<8>[   18.656794] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11517039_1.5.2.3.1>

    2023-09-13T15:36:33.390398   +x

    2023-09-13T15:36:33.495051  / # #

    2023-09-13T15:36:33.597634  export SHELL=3D/bin/sh

    2023-09-13T15:36:33.598592  #

    2023-09-13T15:36:33.700081  / # export SHELL=3D/bin/sh. /lava-11517039/=
environment

    2023-09-13T15:36:33.700901  =


    2023-09-13T15:36:33.802306  / # . /lava-11517039/environment/lava-11517=
039/bin/lava-test-runner /lava-11517039/1

    2023-09-13T15:36:33.803603  =


    2023-09-13T15:36:33.808357  / # /lava-11517039/bin/lava-test-runner /la=
va-11517039/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6501d5d96e263568e48a0a77

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6501d5d96e263568e48a0a80
        failing since 152 days (last pass: v5.10.176-cip30, first fail: v5.=
10.177-cip31)

    2023-09-13T15:31:10.571866  + set +x<8>[   18.409505] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11517058_1.5.2.3.1>

    2023-09-13T15:31:10.572108  =


    2023-09-13T15:31:10.677567  / # #

    2023-09-13T15:31:10.778147  export SHELL=3D/bin/sh

    2023-09-13T15:31:10.778381  #

    2023-09-13T15:31:10.878952  / # export SHELL=3D/bin/sh. /lava-11517058/=
environment

    2023-09-13T15:31:10.879185  =


    2023-09-13T15:31:10.979768  / # . /lava-11517058/environment/lava-11517=
058/bin/lava-test-runner /lava-11517058/1

    2023-09-13T15:31:10.980098  =


    2023-09-13T15:31:10.985608  / # /lava-11517058/bin/lava-test-runner /la=
va-11517058/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6501d719d871ad91298a0a78

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-nfs-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-nfs-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6501d719d871ad91298a0a81
        failing since 242 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-09-13T15:36:43.574736  / # #

    2023-09-13T15:36:43.676773  export SHELL=3D/bin/sh

    2023-09-13T15:36:43.677421  #

    2023-09-13T15:36:43.778782  / # export SHELL=3D/bin/sh. /lava-11517176/=
environment

    2023-09-13T15:36:43.779464  =


    2023-09-13T15:36:43.880863  / # . /lava-11517176/environment/lava-11517=
176/bin/lava-test-runner /lava-11517176/1

    2023-09-13T15:36:43.881857  =


    2023-09-13T15:36:43.883291  / # /lava-11517176/bin/lava-test-runner /la=
va-11517176/1

    2023-09-13T15:36:44.049965  + export TESTRUN_ID=3D1_bootrr

    2023-09-13T15:36:44.050118  + cd /lava-11517176/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6501dcb607655165808a0a5b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ba=
seline-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ba=
seline-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6501dcb6076551658=
08a0a5c
        failing since 22 days (last pass: v5.10.186-cip37-14-gc9b5a049d8ea,=
 first fail: v5.10.186-cip37-27-gd6d928db0a620) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6501dcde78f8f864588a0a5f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-=
nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-=
nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6501dcde78f8f8645=
88a0a60
        failing since 28 days (last pass: v5.10.186-cip37-13-g260094841fe1a=
, first fail: v5.10.186-cip37-14-gc9b5a049d8ea) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6501dbc3510a31d21d8a0acc

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/arm64/defconfig+arm64-chromebook/gcc-10/lab-collab=
ora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/arm64/defconfig+arm64-chromebook/gcc-10/lab-collab=
ora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/6501dbc3510a31d21d8a0ad6
        failing since 175 days (last pass: v5.10.173-cip28, first fail: v5.=
10.175-cip29)

    2023-09-13T15:56:35.882623  /lava-11517240/1/../bin/lava-test-case

    2023-09-13T15:56:35.922012  <8>[   38.623455] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/6501dbc3510a31d21d8a0ad7
        failing since 175 days (last pass: v5.10.173-cip28, first fail: v5.=
10.175-cip29)

    2023-09-13T15:56:34.778313  /lava-11517240/1/../bin/lava-test-case

    2023-09-13T15:56:34.817528  <8>[   37.519408] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =20

