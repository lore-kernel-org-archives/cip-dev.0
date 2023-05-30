Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95F1C77B7A
	for <webhook@archiver.kernel.org>; Tue, 30 May 2023 15:06:08 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web11.76.1685459159240521459
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 30 May 2023 08:05:59 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=G3W1fgJE;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.172, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1b00ecabdf2so41704085ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 30 May 2023 08:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685459158; x=1688051158;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rle+A/mAmyEXiZlpUEfXhVxxzUuwZqIi1CpaDpm8akc=;
        b=G3W1fgJEHJVeca9jgTp8xebsLq/MVnH29jQwDQF6RZEXOxTLpUepmWNJ8ZY8clfH5W
         Aahg3amNYbtaBrawY/ji/jv+lQ7JZsuSQhH9T1gb4PWjgTts+67bCljUwCZX4HPMmp02
         29YReOc3+D+3rUr0l5wB4/MhYtRSWS2/FFWGQNt8D6OrTZNaFvVHHI0Gf53fTx4kr5KU
         NpmvAHcKDTUkjSecuLS0Nu/nVNZTRLQuNCY00YgV1CJThzGycBmYi8KYR69xEO2mjWyk
         BnDifkrosCSnZEo6OwNVOLAQ0YxUHCmUgy644FZKThHsr51y94rG909fyv4x93uFuDxQ
         LZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685459158; x=1688051158;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rle+A/mAmyEXiZlpUEfXhVxxzUuwZqIi1CpaDpm8akc=;
        b=aaGlRl1EAdRFi8UflPiK4P5Bm3BwNnlayfgQxCErbDLso7sIKgZrcgQHFHZmXIrP1S
         Uy1WL4Rd9eXM0y7Kz0kym/4ISCG2dQ6lhtDqpaMqr48ma+vt/UW5jRWn84AWqHuoaOTh
         mAN4P94v5LtHpWwS3o+d516zeO47Czif0Doq0pA7fwn8c/ya1O4cLzJkdpulaSqITbZQ
         QWvWNiklMsI427/FMXWNt9yZgBF/+IDJv2/pQHgRa8llAHFJJXxpJuEhNpFbFwdZetrZ
         cqOogtPZgpd8P1xCWE8SVfU4WgvunOr9iNbpeO/HzZjtU8H4arJIHkMeEC5baPpVlpTK
         6lUQ==
X-Gm-Message-State: AC+VfDwS0ulhPqSQW65BXgsjZPcMX/sFIpxTMVkdZvqwdPla/hkDhrLF
	1PrDDV+Y/Chl6r0S9Q+LlSJdE3giiXQ9f4jTe21xbA==
X-Google-Smtp-Source: ACHHUZ5LCbcJHfMwvR8BhbLYYcMjbiiLX3pQVc96zyd5h1INQU86wAwbM3yHLo3sDNqrybyS7scr3Q==
X-Received: by 2002:a17:903:41cc:b0:1b0:4772:d344 with SMTP id u12-20020a17090341cc00b001b04772d344mr3373008ple.57.1685459157092;
        Tue, 30 May 2023 08:05:57 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ij13-20020a170902ab4d00b001a1a07d04e6sm10572188plb.77.2023.05.30.08.05.56
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 08:05:56 -0700 (PDT)
Message-ID: <647610d4.170a0220.a27e3.3a86@mx.google.com>
Date: Tue, 30 May 2023 08:05:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.19.283-cip98-135-g4ed206c5dc11
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 97 runs,
 35 regressions (v4.19.283-cip98-135-g4ed206c5dc11)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 May 2023 15:06:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11703

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 97 runs, 35 regression=
s (v4.19.283-cip98-135-g4ed206c5dc11)

Regressions Summary
-------------------

platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus  | x86_64 | lab-collabora   | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C523NA-A20057-coral   | x86_64 | lab-collabora   | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

beaglebone-black           | arm    | lab-broonie     | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black           | arm    | lab-cip         | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black           | arm    | lab-broonie     | gcc-10   | omap2plu=
s_defconfig          | 1          =

dove-cubox                 | arm    | lab-pengutronix | gcc-10   | mvebu_v7=
_defconfig           | 1          =

imx6q-sabrelite            | arm    | lab-collabora   | gcc-10   | multi_v7=
_defconfig           | 1          =

imx6qp-wandboard-revd1     | arm    | lab-pengutronix | gcc-10   | imx_v6_v=
7_defconfig          | 1          =

imx6qp-wandboard-revd1     | arm    | lab-pengutronix | gcc-10   | multi_v7=
_defconfig           | 1          =

imx7d-sdb                  | arm    | lab-nxp         | gcc-10   | multi_v7=
_defconfig           | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =

r8a7743-iwg20d-q7          | arm    | lab-cip         | gcc-10   | shmobile=
_defconfig           | 1          =

rk3288-veyron-jaq          | arm    | lab-collabora   | gcc-10   | multi_v7=
_defconfig           | 3          =

rk3399-gru-kevin           | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

sun50i-h6-pine-h64         | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =

zynqmp-zcu102              | arm64  | lab-cip         | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

zynqmp-zcu102              | arm64  | lab-cip         | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.283-cip98-135-g4ed206c5dc11/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.283-cip98-135-g4ed206c5dc11
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      4ed206c5dc11f3047430e9e28f6b0ba48980512a =



Test Regressions
---------------- =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus  | x86_64 | lab-collabora   | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64760687d5a2b290fa2e8662

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64760687d5a2b290fa2e8667
        failing since 131 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-05-30T14:21:42.512465  + set +x

    2023-05-30T14:21:42.519329  <8>[   10.753196] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10525218_1.4.2.3.1>

    2023-05-30T14:21:42.623580  / # #

    2023-05-30T14:21:42.724145  export SHELL=3D/bin/sh

    2023-05-30T14:21:42.724326  #

    2023-05-30T14:21:42.824811  / # export SHELL=3D/bin/sh. /lava-10525218/=
environment

    2023-05-30T14:21:42.824982  =


    2023-05-30T14:21:42.925481  / # . /lava-10525218/environment/lava-10525=
218/bin/lava-test-runner /lava-10525218/1

    2023-05-30T14:21:42.925806  =


    2023-05-30T14:21:42.930590  / # /lava-10525218/bin/lava-test-runner /la=
va-10525218/1
 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral   | x86_64 | lab-collabora   | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6476068883eac170792e860b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6476068883eac170792e8610
        failing since 131 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-05-30T14:21:46.952580  + set +x

    2023-05-30T14:21:46.959030  <8>[   11.577846] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10525246_1.4.2.3.1>

    2023-05-30T14:21:47.063286  / # #

    2023-05-30T14:21:47.163824  export SHELL=3D/bin/sh

    2023-05-30T14:21:47.164003  #

    2023-05-30T14:21:47.264509  / # export SHELL=3D/bin/sh. /lava-10525246/=
environment

    2023-05-30T14:21:47.264679  =


    2023-05-30T14:21:47.365261  / # . /lava-10525246/environment/lava-10525=
246/bin/lava-test-runner /lava-10525246/1

    2023-05-30T14:21:47.365566  =


    2023-05-30T14:21:47.370249  / # /lava-10525246/bin/lava-test-runner /la=
va-10525246/1
 =

    ... (13 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
beaglebone-black           | arm    | lab-broonie     | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647607953fa3a9b5922e85fc

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm/multi_v7_defconfig/gcc-1=
0/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm/multi_v7_defconfig/gcc-1=
0/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647607953fa3a9b5922e8627
        failing since 131 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-05-30T14:25:47.332929  <8>[   15.132108] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 535929_1.5.2.4.1>
    2023-05-30T14:25:47.440901  / # #
    2023-05-30T14:25:47.543189  export SHELL=3D/bin/sh
    2023-05-30T14:25:47.543747  #
    2023-05-30T14:25:47.645524  / # export SHELL=3D/bin/sh. /lava-535929/en=
vironment
    2023-05-30T14:25:47.646117  =

    2023-05-30T14:25:47.748049  / # . /lava-535929/environment/lava-535929/=
bin/lava-test-runner /lava-535929/1
    2023-05-30T14:25:47.749080  =

    2023-05-30T14:25:47.753126  / # /lava-535929/bin/lava-test-runner /lava=
-535929/1
    2023-05-30T14:25:47.821403  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
beaglebone-black           | arm    | lab-cip         | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64760d8d8763ce06012e8602

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm/multi_v7_defconfig/gcc-1=
0/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm/multi_v7_defconfig/gcc-1=
0/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64760d8d8763ce06012e8605
        failing since 131 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-05-30T14:51:05.197786  <8>[    8.878353] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 947279_1.5.2.4.1>
    2023-05-30T14:51:05.307319  / # #
    2023-05-30T14:51:05.409911  export SHELL=3D/bin/sh
    2023-05-30T14:51:05.410481  #
    2023-05-30T14:51:05.511910  / # export SHELL=3D/bin/sh. /lava-947279/en=
vironment
    2023-05-30T14:51:05.512207  =

    2023-05-30T14:51:05.613493  / # . /lava-947279/environment/lava-947279/=
bin/lava-test-runner /lava-947279/1
    2023-05-30T14:51:05.614590  =

    2023-05-30T14:51:05.620757  / # /lava-947279/bin/lava-test-runner /lava=
-947279/1
    2023-05-30T14:51:05.687355  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
beaglebone-black           | arm    | lab-broonie     | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64760926969ab21b932e864f

  Results:     41 PASS, 10 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm/omap2plus_defconfig/gcc-=
10/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm/omap2plus_defconfig/gcc-=
10/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64760926969ab21b932e867d
        failing since 34 days (last pass: v4.19.280-cip96-59-g4b02e7efb967d=
, first fail: v4.19.280-cip96-89-g355dfa824cb4)

    2023-05-30T14:32:34.227187  + set +x<8>[   18.656452] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 535979_1.5.2.4.1>
    2023-05-30T14:32:34.227595  =

    2023-05-30T14:32:34.340388  / # #
    2023-05-30T14:32:34.443117  export SHELL=3D/bin/sh
    2023-05-30T14:32:34.443755  #
    2023-05-30T14:32:34.545596  / # export SHELL=3D/bin/sh. /lava-535979/en=
vironment
    2023-05-30T14:32:34.546392  =

    2023-05-30T14:32:34.647879  / # . /lava-535979/environment/lava-535979/=
bin/lava-test-runner /lava-535979/1
    2023-05-30T14:32:34.649850  =

    2023-05-30T14:32:34.653641  / # /lava-535979/bin/lava-test-runner /lava=
-535979/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
dove-cubox                 | arm    | lab-pengutronix | gcc-10   | mvebu_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64760883ce993382a32e85e7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: mvebu_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm/mvebu_v7_defconfig/gcc-1=
0/lab-pengutronix/baseline-dove-cubox.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm/mvebu_v7_defconfig/gcc-1=
0/lab-pengutronix/baseline-dove-cubox.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64760883ce993382a32e85ec
        failing since 131 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-05-30T14:30:09.843801  + set +x
    2023-05-30T14:30:09.843980  [    4.252936] <LAVA_SIGNAL_ENDRUN 0_dmesg =
962723_1.5.2.3.1>
    2023-05-30T14:30:09.950468  / # #
    2023-05-30T14:30:10.052312  export SHELL=3D/bin/sh
    2023-05-30T14:30:10.052820  #
    2023-05-30T14:30:10.154160  / # export SHELL=3D/bin/sh. /lava-962723/en=
vironment
    2023-05-30T14:30:10.154639  =

    2023-05-30T14:30:10.256078  / # . /lava-962723/environment/lava-962723/=
bin/lava-test-runner /lava-962723/1
    2023-05-30T14:30:10.256689  =

    2023-05-30T14:30:10.259688  / # /lava-962723/bin/lava-test-runner /lava=
-962723/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx6q-sabrelite            | arm    | lab-collabora   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6476074b9fb98ce4b92e8614

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm/multi_v7_defconfig/gcc-1=
0/lab-collabora/baseline-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm/multi_v7_defconfig/gcc-1=
0/lab-collabora/baseline-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6476074b9fb98ce4b92e8619
        failing since 131 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-05-30T14:25:00.936045  / # #

    2023-05-30T14:25:01.038646  export SHELL=3D/bin/sh

    2023-05-30T14:25:01.039384  #

    2023-05-30T14:25:01.141194  / # export SHELL=3D/bin/sh. /lava-10525305/=
environment

    2023-05-30T14:25:01.141971  =


    2023-05-30T14:25:01.243560  / # . /lava-10525305/environment/lava-10525=
305/bin/lava-test-runner /lava-10525305/1

    2023-05-30T14:25:01.244727  =


    2023-05-30T14:25:01.259235  / # /lava-10525305/bin/lava-test-runner /la=
va-10525305/1

    2023-05-30T14:25:01.307139  + export 'TESTRUN_ID=3D1_bootrr'

    2023-05-30T14:25:01.359176  + cd /lava-10525305/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx6qp-wandboard-revd1     | arm    | lab-pengutronix | gcc-10   | imx_v6_v=
7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6476080b521ea2b9502e8602

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm/imx_v6_v7_defconfig/gcc-=
10/lab-pengutronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm/imx_v6_v7_defconfig/gcc-=
10/lab-pengutronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6476080b521ea2b9502e8607
        failing since 131 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-05-30T14:28:06.411715  + set +x
    2023-05-30T14:28:06.411894  [    7.299177] <LAVA_SIGNAL_ENDRUN 0_dmesg =
962720_1.5.2.3.1>
    2023-05-30T14:28:06.518871  / # #
    2023-05-30T14:28:06.620416  export SHELL=3D/bin/sh
    2023-05-30T14:28:06.620762  #
    2023-05-30T14:28:06.721895  / # export SHELL=3D/bin/sh. /lava-962720/en=
vironment
    2023-05-30T14:28:06.722251  =

    2023-05-30T14:28:06.823605  / # . /lava-962720/environment/lava-962720/=
bin/lava-test-runner /lava-962720/1
    2023-05-30T14:28:06.824162  =

    2023-05-30T14:28:06.826846  / # /lava-962720/bin/lava-test-runner /lava=
-962720/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx6qp-wandboard-revd1     | arm    | lab-pengutronix | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6476071c47bd02ec8d2e8633

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm/multi_v7_defconfig/gcc-1=
0/lab-pengutronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm/multi_v7_defconfig/gcc-1=
0/lab-pengutronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6476071c47bd02ec8d2e8638
        failing since 131 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-05-30T14:24:17.200830  + set +x
    2023-05-30T14:24:17.201031  [    4.904547] <LAVA_SIGNAL_ENDRUN 0_dmesg =
962718_1.5.2.3.1>
    2023-05-30T14:24:17.307169  / # #
    2023-05-30T14:24:17.408707  export SHELL=3D/bin/sh
    2023-05-30T14:24:17.409188  #
    2023-05-30T14:24:17.510532  / # export SHELL=3D/bin/sh. /lava-962718/en=
vironment
    2023-05-30T14:24:17.510987  =

    2023-05-30T14:24:17.612238  / # . /lava-962718/environment/lava-962718/=
bin/lava-test-runner /lava-962718/1
    2023-05-30T14:24:17.612796  =

    2023-05-30T14:24:17.615258  / # /lava-962718/bin/lava-test-runner /lava=
-962718/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx7d-sdb                  | arm    | lab-nxp         | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6476078e91acc960332e8607

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm/multi_v7_defconfig/gcc-1=
0/lab-nxp/baseline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm/multi_v7_defconfig/gcc-1=
0/lab-nxp/baseline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6476078e91acc960332e860a
        failing since 126 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.270-cip89-39-g43ce130174aa)

    2023-05-30T14:25:17.053447  <8>[   12.960107] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1230802_1.5.2.4.1>
    2023-05-30T14:25:17.158978  / # #
    2023-05-30T14:25:18.319276  export SHELL=3D/bin/sh
    2023-05-30T14:25:18.324990  #
    2023-05-30T14:25:19.872874  / # export SHELL=3D/bin/sh. /lava-1230802/e=
nvironment
    2023-05-30T14:25:19.878607  =

    2023-05-30T14:25:22.701442  / # . /lava-1230802/environment/lava-123080=
2/bin/lava-test-runner /lava-1230802/1
    2023-05-30T14:25:22.707535  =

    2023-05-30T14:25:22.711605  / # /lava-1230802/bin/lava-test-runner /lav=
a-1230802/1
    2023-05-30T14:25:22.759790  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (16 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64760a1ffc05af08422e85ee

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64760a1ffc05af08422e8=
5ef
        failing since 376 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64760aaad2414bb0f72e86d6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm64/defconfig/gcc-10/lab-b=
roonie/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm64/defconfig/gcc-10/lab-b=
roonie/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64760aaad2414bb0f72e8=
6d7
        failing since 376 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/647609d2b79f85097a2e8600

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647609d2b79f85097a2e8=
601
        failing since 376 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/647609ea017b310de52e8655

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647609ea017b310de52e8=
656
        failing since 376 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64760a6e30e1fe27612e864b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64760a6e30e1fe27612e8=
64c
        failing since 376 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64760b87e2d5bf17fe2e861e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm64/defconfig/gcc-10/lab-b=
roonie/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm64/defconfig/gcc-10/lab-b=
roonie/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64760b87e2d5bf17fe2e8=
61f
        failing since 376 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/647609d441e01e65a62e85f1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647609d441e01e65a62e8=
5f2
        failing since 376 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/647609ec1a45e755e42e8617

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647609ec1a45e755e42e8=
618
        failing since 376 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64760a0ae825016df42e8645

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64760a0ae825016df42e8=
646
        failing since 376 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64760b5fe2d5bf17fe2e85f6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm64/defconfig/gcc-10/lab-b=
roonie/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm64/defconfig/gcc-10/lab-b=
roonie/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64760b5fe2d5bf17fe2e8=
5f7
        failing since 376 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/647609d141e01e65a62e85e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647609d141e01e65a62e8=
5e7
        failing since 376 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/647609ebe825016df42e85e7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647609ebe825016df42e8=
5e8
        failing since 376 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64760a33c33e80f27c2e8648

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64760a33c33e80f27c2e8=
649
        failing since 376 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64760b73e2d5bf17fe2e860b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm64/defconfig/gcc-10/lab-b=
roonie/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm64/defconfig/gcc-10/lab-b=
roonie/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64760b73e2d5bf17fe2e8=
60c
        failing since 376 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/647609d641e01e65a62e85f6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647609d641e01e65a62e8=
5f7
        failing since 376 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/647609e41a45e755e42e85e7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647609e41a45e755e42e8=
5e8
        failing since 376 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
r8a7743-iwg20d-q7          | arm    | lab-cip         | gcc-10   | shmobile=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647609d241e01e65a62e85eb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm/shmobile_defconfig/gcc-1=
0/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm/shmobile_defconfig/gcc-1=
0/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647609d241e01e65a62e8=
5ec
        new failure (last pass: v4.19.280-cip96-89-g355dfa824cb4) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
rk3288-veyron-jaq          | arm    | lab-collabora   | gcc-10   | multi_v7=
_defconfig           | 3          =


  Details:     https://kernelci.org/test/plan/id/64760730922744aacc2e8629

  Results:     61 PASS, 8 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm/multi_v7_defconfig/gcc-1=
0/lab-collabora/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm/multi_v7_defconfig/gcc-1=
0/lab-collabora/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/64760730922744aacc2e8659
        failing since 129 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-05-30T14:24:31.106733  BusyBox v1.31.1 (2023-05-27 14:14:16 UTC)<8=
>[    9.962270] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-05-30T14:24:31.108734   multi-call binary.

    2023-05-30T14:24:31.108788  =


    2023-05-30T14:24:31.113153  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-05-30T14:24:31.113207  =


    2023-05-30T14:24:31.118289  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/64760730922744aacc2e865a
        failing since 129 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-05-30T14:24:31.087552  <8>[    9.944536] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64760730922744aacc2e866d
        failing since 129 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-05-30T14:24:27.262624  <8>[    6.119712] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-05-30T14:24:27.272041  + <8>[    6.131918] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10525306_1.5.2.3.1>

    2023-05-30T14:24:27.272330  set +x

    2023-05-30T14:24:27.377193  #

    2023-05-30T14:24:27.377367  =


    2023-05-30T14:24:27.477867  / # #export SHELL=3D/bin/sh

    2023-05-30T14:24:27.477993  =


    2023-05-30T14:24:27.578475  / # export SHELL=3D/bin/sh. /lava-10525306/=
environment

    2023-05-30T14:24:27.578611  =


    2023-05-30T14:24:27.679108  / # . /lava-10525306/environment/lava-10525=
306/bin/lava-test-runner /lava-10525306/1
 =

    ... (17 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
rk3399-gru-kevin           | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64760987c37080c9ce2e85e6

  Results:     77 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/64760987c37080c9ce2e85ec
        failing since 77 days (last pass: v4.19.273-cip92-277-g507c8d80b9e2=
0, first fail: v4.19.276-cip93-5-g2eb2a953ab59)

    2023-05-30T14:34:25.040490  /lava-10525352/1/../bin/lava-test-case<8>[ =
  36.496772] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Drockchip-usb2phy1-probed =
RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/64760987c37080c9ce2e85ed
        failing since 77 days (last pass: v4.19.273-cip92-277-g507c8d80b9e2=
0, first fail: v4.19.276-cip93-5-g2eb2a953ab59)

    2023-05-30T14:34:22.994867  <8>[   34.448614] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-05-30T14:34:24.009758  /lava-10525352/1/../bin/lava-test-case

    2023-05-30T14:34:24.018574  <8>[   35.474695] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64         | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/647608fca765c9bce12e8658

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647608fca765c9bce12e865d
        failing since 131 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-05-30T14:32:08.724084  / # #

    2023-05-30T14:32:08.826208  export SHELL=3D/bin/sh

    2023-05-30T14:32:08.826445  #

    2023-05-30T14:32:08.927086  / # export SHELL=3D/bin/sh. /lava-10525361/=
environment

    2023-05-30T14:32:08.927767  =


    2023-05-30T14:32:09.029146  / # . /lava-10525361/environment/lava-10525=
361/bin/lava-test-runner /lava-10525361/1

    2023-05-30T14:32:09.030339  =


    2023-05-30T14:32:09.032668  / # /lava-10525361/bin/lava-test-runner /la=
va-10525361/1

    2023-05-30T14:32:09.105381  + export 'TESTRUN_ID=3D1_bootrr'

    2023-05-30T14:32:09.105938  + cd /lava-1052536<8>[   15.628233] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 10525361_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
zynqmp-zcu102              | arm64  | lab-cip         | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6476090877b3e031342e8602

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6476090877b3e031342e8605
        failing since 131 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-05-30T14:32:20.208485  <8>[    3.743667] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 947322_1.5.2.4.1>
    2023-05-30T14:32:20.313800  / # #
    2023-05-30T14:32:20.415868  export SHELL=3D/bin/sh
    2023-05-30T14:32:20.416491  #
    2023-05-30T14:32:20.517808  / # export SHELL=3D/bin/sh. /lava-947322/en=
vironment
    2023-05-30T14:32:20.518388  =

    2023-05-30T14:32:20.619765  / # . /lava-947322/environment/lava-947322/=
bin/lava-test-runner /lava-947322/1
    2023-05-30T14:32:20.620529  =

    2023-05-30T14:32:20.622738  / # /lava-947322/bin/lava-test-runner /lava=
-947322/1
    2023-05-30T14:32:20.659870  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
zynqmp-zcu102              | arm64  | lab-cip         | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64760958316bb763dc2e85ef

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm64/defconfig/gcc-10/lab-c=
ip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm64/defconfig/gcc-10/lab-c=
ip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64760958316bb763dc2e85f2
        failing since 131 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-05-30T14:33:39.866388  + set +x
    2023-05-30T14:33:39.867281  <8>[    3.740632] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 947348_1.5.2.4.1>
    2023-05-30T14:33:39.973470  / # #
    2023-05-30T14:33:40.075279  export SHELL=3D/bin/sh
    2023-05-30T14:33:40.075865  #
    2023-05-30T14:33:40.177289  / # export SHELL=3D/bin/sh. /lava-947348/en=
vironment
    2023-05-30T14:33:40.177775  =

    2023-05-30T14:33:40.279202  / # . /lava-947348/environment/lava-947348/=
bin/lava-test-runner /lava-947348/1
    2023-05-30T14:33:40.280035  =

    2023-05-30T14:33:40.282319  / # /lava-947348/bin/lava-test-runner /lava=
-947348/1 =

    ... (13 line(s) more)  =

 =20

