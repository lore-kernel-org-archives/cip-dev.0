Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B964C83F01
	for <webhook@archiver.kernel.org>; Wed, 30 Aug 2023 19:04:20 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web10.3376.1693422254179374908
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 30 Aug 2023 12:04:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=RCJBrdKL;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.169, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1c09673b006so32567235ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 30 Aug 2023 12:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1693422253; x=1694027053; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7lAHE4WJktR7akhV2QySgBaxqcreTLurhNvnYXhOi6Q=;
        b=RCJBrdKL2ZKKUFD4DxsaLBOjYC8Bzp3kuaXj6PO1Ak9uNklW+GkcNhGPQWKwIxIdbI
         LGxURX2vmfDL5wS3J6Fijekz4bOsJdYlTQfy0nK5kWbz5ss2WOFZ2jF/Yywt6Ob2yPbH
         B4evqXXgEDgJKbmBEeGMftxN20XEqtKVIHj1Rbjjt/4UcL2ATLrr4YR2nDcZcCMjZZb6
         W11JiPzNloQnsHtpRDIwvTeulyqobnoCyuw5gkMs/60u7a4jJKv7/WkotHbM4/bPqBmL
         HUN6Vl1FXUQsPLTfLKHVasIQtZHa8xbLyMu0GHN2NUPoJX1Qwm4PF20N2u0A5eC68peS
         Rs5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693422253; x=1694027053;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7lAHE4WJktR7akhV2QySgBaxqcreTLurhNvnYXhOi6Q=;
        b=EiNycBtwtt3BVk0cG4OCqobO5AXosV3cdkhS5mtQjRCdJ2X0nIRWT0nckp0kJFBQs0
         eZevdbKR6s3ps6Zmpchwilmm22Z9wgHICW/Pmy0fTIsI30J4eUTWYckEXdCSsK29fydq
         eQqvHewfoTy3txRsaRC6RTZKAGq3qIse31a+BHP+qmhyN9jLPIWVuYDgiOYhz6f/FYKz
         sUaYXZr+2MH0ISDCrFeAMcWvLxrxcRi1MZMGWNytLq88BvUyTfEghT6t0jA13qqHjFgo
         AaAFlfS+av/Sfj4JZ8IOkAgOA2mA03SfJOCzSlqgcpSJpGNZ4pWc4dPwkfyoYWsUhxwM
         0Wyw==
X-Gm-Message-State: AOJu0Yw+UVrAtr3PVPQCG/b2iQA8iLjZva20tx8Qat4leTlERL3GeIgI
	nrriY/g6PKenjtuMb1xaBftztI2EaNDAHNbmj/Q=
X-Google-Smtp-Source: AGHT+IHsTr3yE3D9bAe9ldEfcA65SwjZGZf6U1uLaPgu3xP13KQDJCraBvYbuQ10OAVlu5tYDQSt0A==
X-Received: by 2002:a17:902:d4c3:b0:1b9:c68f:91a5 with SMTP id o3-20020a170902d4c300b001b9c68f91a5mr3589742plg.6.1693422252248;
        Wed, 30 Aug 2023 12:04:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id e19-20020a170902f1d300b001a5260a6e6csm11456217plc.206.2023.08.30.12.04.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 12:04:11 -0700 (PDT)
Message-ID: <64ef92ab.170a0220.2930e.52cb@mx.google.com>
Date: Wed, 30 Aug 2023 12:04:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.292-cip102-130-g18b864070345b
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 105 runs,
 38 regressions (v4.19.292-cip102-130-g18b864070345b)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Aug 2023 19:04:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12919

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 105 runs, 38 regressio=
ns (v4.19.292-cip102-130-g18b864070345b)

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

beaglebone-black           | arm    | lab-cip         | gcc-10   | omap2plu=
s_defconfig          | 1          =

dove-cubox                 | arm    | lab-pengutronix | gcc-10   | mvebu_v7=
_defconfig           | 1          =

imx6q-sabrelite            | arm    | lab-collabora   | gcc-10   | multi_v7=
_defconfig           | 1          =

imx6qp-wandboard-revd1     | arm    | lab-pengutronix | gcc-10   | imx_v6_v=
7_defconfig          | 1          =

imx6qp-wandboard-revd1     | arm    | lab-pengutronix | gcc-10   | multi_v7=
_defconfig           | 1          =

imx6ul-14x14-evk           | arm    | lab-nxp         | gcc-10   | multi_v7=
_defconfig           | 1          =

imx7d-sdb                  | arm    | lab-nxp         | gcc-10   | multi_v7=
_defconfig           | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a7743-iwg20d-q7          | arm    | lab-cip         | gcc-10   | shmobile=
_defconfig           | 1          =

r8a7796-m3ulcb             | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =

rk3288-veyron-jaq          | arm    | lab-collabora   | gcc-10   | multi_v7=
_defconfig           | 3          =

rk3399-gru-kevin           | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

sun50i-h6-pine-h64         | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =

zynqmp-zcu102              | arm64  | lab-cip         | gcc-10   | defconfi=
g                    | 1          =

zynqmp-zcu102              | arm64  | lab-cip         | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.292-cip102-130-g18b864070345b/plan/baseli=
ne/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.292-cip102-130-g18b864070345b
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      18b864070345b810401a67174ba9abccd8dc9dd8 =



Test Regressions
---------------- =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus  | x86_64 | lab-collabora   | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef842f0cf11ffd26286da6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/x86_64/x86_64_defconfig+x8=
6-chromebook/gcc-10/lab-collabora/baseline-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/x86_64/x86_64_defconfig+x8=
6-chromebook/gcc-10/lab-collabora/baseline-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef842f0cf11ffd26286daf
        failing since 223 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-08-30T18:02:06.258475  + set +x

    2023-08-30T18:02:06.265141  <8>[    9.502718] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11385857_1.4.2.3.1>

    2023-08-30T18:02:06.369817  / # #

    2023-08-30T18:02:06.470397  export SHELL=3D/bin/sh

    2023-08-30T18:02:06.470599  #

    2023-08-30T18:02:06.571104  / # export SHELL=3D/bin/sh. /lava-11385857/=
environment

    2023-08-30T18:02:06.571307  =


    2023-08-30T18:02:06.671881  / # . /lava-11385857/environment/lava-11385=
857/bin/lava-test-runner /lava-11385857/1

    2023-08-30T18:02:06.672219  =


    2023-08-30T18:02:06.677017  / # /lava-11385857/bin/lava-test-runner /la=
va-11385857/1
 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral   | x86_64 | lab-collabora   | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef84315f7aacc40f286d9e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/x86_64/x86_64_defconfig+x8=
6-chromebook/gcc-10/lab-collabora/baseline-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/x86_64/x86_64_defconfig+x8=
6-chromebook/gcc-10/lab-collabora/baseline-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef84315f7aacc40f286da7
        failing since 223 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-08-30T18:02:10.093885  + <8>[   12.649621] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11385837_1.4.2.3.1>

    2023-08-30T18:02:10.097303  set +x

    2023-08-30T18:02:10.201773  / # #

    2023-08-30T18:02:10.303958  export SHELL=3D/bin/sh

    2023-08-30T18:02:10.304656  #

    2023-08-30T18:02:10.406053  / # export SHELL=3D/bin/sh. /lava-11385837/=
environment

    2023-08-30T18:02:10.406249  =


    2023-08-30T18:02:10.506903  / # . /lava-11385837/environment/lava-11385=
837/bin/lava-test-runner /lava-11385837/1

    2023-08-30T18:02:10.507193  =


    2023-08-30T18:02:10.509191  / # /lava-11385837/bin/lava-test-runner /la=
va-11385837/1
 =

    ... (13 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
beaglebone-black           | arm    | lab-broonie     | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef84bc94f726db75286d6d

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm/multi_v7_defconfig/gcc=
-10/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm/multi_v7_defconfig/gcc=
-10/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef84bc94f726db75286d9c
        failing since 223 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-08-30T18:04:01.950051  <8>[   16.337049] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 79640_1.5.2.4.1>
    2023-08-30T18:04:02.058499  / # #
    2023-08-30T18:04:02.161669  export SHELL=3D/bin/sh
    2023-08-30T18:04:02.162423  #
    2023-08-30T18:04:02.264823  / # export SHELL=3D/bin/sh. /lava-79640/env=
ironment
    2023-08-30T18:04:02.265622  =

    2023-08-30T18:04:02.368089  / # . /lava-79640/environment/lava-79640/bi=
n/lava-test-runner /lava-79640/1
    2023-08-30T18:04:02.369408  =

    2023-08-30T18:04:02.373432  / # /lava-79640/bin/lava-test-runner /lava-=
79640/1
    2023-08-30T18:04:02.440906  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
beaglebone-black           | arm    | lab-cip         | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef84be94f726db75286da0

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm/multi_v7_defconfig/gcc=
-10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm/multi_v7_defconfig/gcc=
-10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef84be94f726db75286da3
        failing since 223 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-08-30T18:03:54.159635  / # #
    2023-08-30T18:03:54.263096  export SHELL=3D/bin/sh
    2023-08-30T18:03:54.264096  #
    2023-08-30T18:03:54.366431  / # export SHELL=3D/bin/sh. /lava-1002987/e=
nvironment
    2023-08-30T18:03:54.367418  =

    2023-08-30T18:03:54.469842  / # . /lava-1002987/environment/lava-100298=
7/bin/lava-test-runner /lava-1002987/1
    2023-08-30T18:03:54.471442  =

    2023-08-30T18:03:54.481656  / # /lava-1002987/bin/lava-test-runner /lav=
a-1002987/1
    2023-08-30T18:03:54.581595  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-30T18:03:54.582196  + cd /lava-1002987/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
beaglebone-black           | arm    | lab-broonie     | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef84dffa23e4a5fa286dd0

  Results:     41 PASS, 10 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm/omap2plus_defconfig/gc=
c-10/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm/omap2plus_defconfig/gc=
c-10/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef84e0fa23e4a5fa286e06
        new failure (last pass: v4.19.288-cip101-388-g468a029f1562)

    2023-08-30T18:04:40.954188  + set +x<8>[   18.551826] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 79656_1.5.2.4.1>
    2023-08-30T18:04:40.954635  =

    2023-08-30T18:04:41.067014  / # #
    2023-08-30T18:04:41.169851  export SHELL=3D/bin/sh
    2023-08-30T18:04:41.170414  #
    2023-08-30T18:04:41.272099  / # export SHELL=3D/bin/sh. /lava-79656/env=
ironment
    2023-08-30T18:04:41.272785  =

    2023-08-30T18:04:41.374836  / # . /lava-79656/environment/lava-79656/bi=
n/lava-test-runner /lava-79656/1
    2023-08-30T18:04:41.375683  =

    2023-08-30T18:04:41.380796  / # /lava-79656/bin/lava-test-runner /lava-=
79656/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
beaglebone-black           | arm    | lab-cip         | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef8577207fc9dae8286d83

  Results:     41 PASS, 10 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm/omap2plus_defconfig/gc=
c-10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm/omap2plus_defconfig/gc=
c-10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef8577207fc9dae8286d86
        new failure (last pass: v4.19.288-cip101-388-g468a029f1562)

    2023-08-30T18:07:20.608562  + set +x<8>[   11.470661] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 1002993_1.5.2.4.1>
    2023-08-30T18:07:20.608870  =

    2023-08-30T18:07:20.721770  / # #
    2023-08-30T18:07:20.823661  export SHELL=3D/bin/sh
    2023-08-30T18:07:20.824137  #
    2023-08-30T18:07:20.925506  / # export SHELL=3D/bin/sh. /lava-1002993/e=
nvironment
    2023-08-30T18:07:20.925984  =

    2023-08-30T18:07:21.027370  / # . /lava-1002993/environment/lava-100299=
3/bin/lava-test-runner /lava-1002993/1
    2023-08-30T18:07:21.028133  =

    2023-08-30T18:07:21.030363  / # /lava-1002993/bin/lava-test-runner /lav=
a-1002993/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
dove-cubox                 | arm    | lab-pengutronix | gcc-10   | mvebu_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef88b0bd0dd717d6286d6c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: mvebu_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm/mvebu_v7_defconfig/gcc=
-10/lab-pengutronix/baseline-dove-cubox.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm/mvebu_v7_defconfig/gcc=
-10/lab-pengutronix/baseline-dove-cubox.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef88b0bd0dd717d6286d75
        failing since 223 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-08-30T18:21:18.676157  + set +x
    2023-08-30T18:21:18.676342  [    4.237871] <LAVA_SIGNAL_ENDRUN 0_dmesg =
999041_1.5.2.3.1>
    2023-08-30T18:21:18.782633  / # #
    2023-08-30T18:21:18.884283  export SHELL=3D/bin/sh
    2023-08-30T18:21:18.884823  #
    2023-08-30T18:21:18.986142  / # export SHELL=3D/bin/sh. /lava-999041/en=
vironment
    2023-08-30T18:21:18.986645  =

    2023-08-30T18:21:19.088130  / # . /lava-999041/environment/lava-999041/=
bin/lava-test-runner /lava-999041/1
    2023-08-30T18:21:19.088794  =

    2023-08-30T18:21:19.091397  / # /lava-999041/bin/lava-test-runner /lava=
-999041/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx6q-sabrelite            | arm    | lab-collabora   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef8496e245e77e9c286e42

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm/multi_v7_defconfig/gcc=
-10/lab-collabora/baseline-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm/multi_v7_defconfig/gcc=
-10/lab-collabora/baseline-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef8496e245e77e9c286e4b
        failing since 223 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-08-30T18:03:58.244126  / # #

    2023-08-30T18:03:58.346179  export SHELL=3D/bin/sh

    2023-08-30T18:03:58.346874  #

    2023-08-30T18:03:58.448725  / # export SHELL=3D/bin/sh. /lava-11385877/=
environment

    2023-08-30T18:03:58.449429  =


    2023-08-30T18:03:58.551191  / # . /lava-11385877/environment/lava-11385=
877/bin/lava-test-runner /lava-11385877/1

    2023-08-30T18:03:58.552402  =


    2023-08-30T18:03:58.567150  / # /lava-11385877/bin/lava-test-runner /la=
va-11385877/1

    2023-08-30T18:03:58.676136  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-30T18:03:58.676632  + cd /lava-11385877/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx6qp-wandboard-revd1     | arm    | lab-pengutronix | gcc-10   | imx_v6_v=
7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef8414f1dc3fb7dc286d94

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm/imx_v6_v7_defconfig/gc=
c-10/lab-pengutronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm/imx_v6_v7_defconfig/gc=
c-10/lab-pengutronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef8414f1dc3fb7dc286d9d
        failing since 223 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-08-30T18:01:45.484741  + set +x[    7.251977] <LAVA_SIGNAL_ENDRUN =
0_dmesg 999035_1.5.2.3.1>
    2023-08-30T18:01:45.484986  =

    2023-08-30T18:01:45.592431  / # #
    2023-08-30T18:01:45.694100  export SHELL=3D/bin/sh
    2023-08-30T18:01:45.694576  #
    2023-08-30T18:01:45.795769  / # export SHELL=3D/bin/sh. /lava-999035/en=
vironment
    2023-08-30T18:01:45.796239  =

    2023-08-30T18:01:45.897443  / # . /lava-999035/environment/lava-999035/=
bin/lava-test-runner /lava-999035/1
    2023-08-30T18:01:45.898033  =

    2023-08-30T18:01:45.900863  / # /lava-999035/bin/lava-test-runner /lava=
-999035/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx6qp-wandboard-revd1     | arm    | lab-pengutronix | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef8479e8e08259b8286da5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm/multi_v7_defconfig/gcc=
-10/lab-pengutronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm/multi_v7_defconfig/gcc=
-10/lab-pengutronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef8479e8e08259b8286dae
        failing since 223 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-08-30T18:03:25.688297  + set +x
    2023-08-30T18:03:25.688639  [    4.841788] <LAVA_SIGNAL_ENDRUN 0_dmesg =
999037_1.5.2.3.1>
    2023-08-30T18:03:25.794894  / # #
    2023-08-30T18:03:25.896369  export SHELL=3D/bin/sh
    2023-08-30T18:03:25.896772  #
    2023-08-30T18:03:25.998087  / # export SHELL=3D/bin/sh. /lava-999037/en=
vironment
    2023-08-30T18:03:25.998622  =

    2023-08-30T18:03:26.099976  / # . /lava-999037/environment/lava-999037/=
bin/lava-test-runner /lava-999037/1
    2023-08-30T18:03:26.100712  =

    2023-08-30T18:03:26.103036  / # /lava-999037/bin/lava-test-runner /lava=
-999037/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx6ul-14x14-evk           | arm    | lab-nxp         | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef8517dc3e3f7c34286dc6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm/multi_v7_defconfig/gcc=
-10/lab-nxp/baseline-imx6ul-14x14-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm/multi_v7_defconfig/gcc=
-10/lab-nxp/baseline-imx6ul-14x14-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef8517dc3e3f7c34286dc9
        failing since 132 days (last pass: v4.19.259-cip82-57-ge54228ee5a88=
d, first fail: v4.19.280-cip96-59-g4b02e7efb967d)

    2023-08-30T18:05:59.025458  + set +x<8>[   23.088874] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 1248099_1.5.2.4.1>
    2023-08-30T18:05:59.025758  =

    2023-08-30T18:05:59.136408  / # #
    2023-08-30T18:06:00.292204  export SHELL=3D/bin/sh
    2023-08-30T18:06:00.297847  #
    2023-08-30T18:06:01.839363  / # export SHELL=3D/bin/sh. /lava-1248099/e=
nvironment
    2023-08-30T18:06:01.844970  =

    2023-08-30T18:06:04.655697  / # . /lava-1248099/environment/lava-124809=
9/bin/lava-test-runner /lava-1248099/1
    2023-08-30T18:06:04.661648  =

    2023-08-30T18:06:04.663428  / # /lava-1248099/bin/lava-test-runner /lav=
a-1248099/1 =

    ... (15 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx7d-sdb                  | arm    | lab-nxp         | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef84b426891cab0c286e12

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm/multi_v7_defconfig/gcc=
-10/lab-nxp/baseline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm/multi_v7_defconfig/gcc=
-10/lab-nxp/baseline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef84b426891cab0c286e15
        failing since 218 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.270-cip89-39-g43ce130174aa)

    2023-08-30T18:04:13.916423  / # #
    2023-08-30T18:04:15.072292  export SHELL=3D/bin/sh
    2023-08-30T18:04:15.077960  #
    2023-08-30T18:04:16.619715  / # export SHELL=3D/bin/sh. /lava-1248098/e=
nvironment
    2023-08-30T18:04:16.625525  =

    2023-08-30T18:04:19.437567  / # . /lava-1248098/environment/lava-124809=
8/bin/lava-test-runner /lava-1248098/1
    2023-08-30T18:04:19.443572  =

    2023-08-30T18:04:19.456538  / # /lava-1248098/bin/lava-test-runner /lav=
a-1248098/1
    2023-08-30T18:04:19.551473  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-30T18:04:19.551770  + cd /lava-1248098/1/tests/1_bootrr =

    ... (16 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef8baa9838cebd96286d84

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm64/defconfig/gcc-10/lab=
-broonie/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm64/defconfig/gcc-10/lab=
-broonie/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ef8baa9838cebd96286=
d85
        failing since 469 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef8ce8aeae19d60b286d8d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm64/defconfig+arm64-chro=
mebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm64/defconfig+arm64-chro=
mebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ef8ce8aeae19d60b286=
d8e
        failing since 469 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef8aab83cdb992b8286d73

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm64/defconfig/gcc-10/lab=
-collabora/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm64/defconfig/gcc-10/lab=
-collabora/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ef8aab83cdb992b8286=
d74
        failing since 469 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef8bd6f206a3fb75286d70

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm64/defconfig+arm64-chro=
mebook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm64/defconfig+arm64-chro=
mebook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ef8bd6f206a3fb75286=
d71
        failing since 469 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef8cd5445b11d036286d74

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm64/defconfig/gcc-10/lab=
-broonie/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm64/defconfig/gcc-10/lab=
-broonie/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ef8cd5445b11d036286=
d75
        failing since 469 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef8d115c3b3aca6b286d87

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm64/defconfig+arm64-chro=
mebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm64/defconfig+arm64-chro=
mebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ef8d115c3b3aca6b286=
d88
        failing since 469 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef8ab283cdb992b8286d79

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm64/defconfig/gcc-10/lab=
-collabora/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm64/defconfig/gcc-10/lab=
-collabora/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ef8ab283cdb992b8286=
d7a
        failing since 469 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef8bd7d97f099919286d89

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm64/defconfig+arm64-chro=
mebook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm64/defconfig+arm64-chro=
mebook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ef8bd7d97f099919286=
d8a
        failing since 469 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef8b804f647e7a57286d89

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm64/defconfig/gcc-10/lab=
-broonie/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm64/defconfig/gcc-10/lab=
-broonie/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ef8b804f647e7a57286=
d8a
        failing since 469 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef8d9ecd5a4e9e1b286d80

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm64/defconfig+arm64-chro=
mebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm64/defconfig+arm64-chro=
mebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ef8d9ecd5a4e9e1b286=
d81
        failing since 469 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef8ab183cdb992b8286d76

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm64/defconfig/gcc-10/lab=
-collabora/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm64/defconfig/gcc-10/lab=
-collabora/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ef8ab183cdb992b8286=
d77
        failing since 469 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef8bc9d97f099919286d82

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm64/defconfig+arm64-chro=
mebook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm64/defconfig+arm64-chro=
mebook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ef8bc9d97f099919286=
d83
        failing since 469 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef8b5be71e7952cd286d87

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm64/defconfig/gcc-10/lab=
-broonie/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm64/defconfig/gcc-10/lab=
-broonie/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ef8b5be71e7952cd286=
d88
        failing since 469 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef8dd9906af37867286d77

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm64/defconfig+arm64-chro=
mebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm64/defconfig+arm64-chro=
mebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ef8dd9906af37867286=
d78
        failing since 469 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef8aaa83cdb992b8286d70

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm64/defconfig/gcc-10/lab=
-collabora/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm64/defconfig/gcc-10/lab=
-collabora/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ef8aaa83cdb992b8286=
d71
        failing since 469 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef8bcaf206a3fb75286d6c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm64/defconfig+arm64-chro=
mebook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm64/defconfig+arm64-chro=
mebook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ef8bcaf206a3fb75286=
d6d
        failing since 469 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
r8a7743-iwg20d-q7          | arm    | lab-cip         | gcc-10   | shmobile=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef92885358e9fd3b286d6d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm/shmobile_defconfig/gcc=
-10/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm/shmobile_defconfig/gcc=
-10/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ef92885358e9fd3b286=
d6e
        failing since 62 days (last pass: v4.19.284-cip99-114-g02e97826987b=
f, first fail: v4.19.287-cip100-43-g1a6518aa81690) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
r8a7796-m3ulcb             | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef89a61164a16f82286d8e

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm64/defconfig/gcc-10/lab=
-collabora/baseline-r8a7796-m3ulcb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm64/defconfig/gcc-10/lab=
-collabora/baseline-r8a7796-m3ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef89a61164a16f82286d97
        failing since 222 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-08-30T18:27:02.769207  / # #

    2023-08-30T18:27:02.871605  export SHELL=3D/bin/sh

    2023-08-30T18:27:02.872372  #

    2023-08-30T18:27:02.973861  / # export SHELL=3D/bin/sh. /lava-11385898/=
environment

    2023-08-30T18:27:02.974634  =


    2023-08-30T18:27:03.076157  / # . /lava-11385898/environment/lava-11385=
898/bin/lava-test-runner /lava-11385898/1

    2023-08-30T18:27:03.077443  =


    2023-08-30T18:27:03.092219  / # /lava-11385898/bin/lava-test-runner /la=
va-11385898/1

    2023-08-30T18:27:03.144210  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-30T18:27:03.144729  + cd /lav<8>[   13.058114] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11385898_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
rk3288-veyron-jaq          | arm    | lab-collabora   | gcc-10   | multi_v7=
_defconfig           | 3          =


  Details:     https://kernelci.org/test/plan/id/64ef85e741ac42bbd3286d8e

  Results:     61 PASS, 8 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm/multi_v7_defconfig/gcc=
-10/lab-collabora/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm/multi_v7_defconfig/gcc=
-10/lab-collabora/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/64ef85e741ac42bbd3286dc2
        failing since 221 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-08-30T18:10:57.739715  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC)<8=
>[   10.974562] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-08-30T18:10:57.741671   multi-call binary.

    2023-08-30T18:10:57.741892  =


    2023-08-30T18:10:57.746225  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-08-30T18:10:57.746446  =


    2023-08-30T18:10:57.751443  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/64ef85e741ac42bbd3286dc3
        failing since 221 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-08-30T18:10:57.720934  <8>[   10.957004] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef85e741ac42bbd3286dd6
        failing since 221 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-08-30T18:10:53.893543  <8>[    7.129757] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-08-30T18:10:53.902803  + <8>[    7.141848] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11385878_1.5.2.3.1>

    2023-08-30T18:10:53.903194  set +x

    2023-08-30T18:10:54.009414  =


    2023-08-30T18:10:54.111089  / # #export SHELL=3D/bin/sh

    2023-08-30T18:10:54.111791  =


    2023-08-30T18:10:54.213196  / # export SHELL=3D/bin/sh. /lava-11385878/=
environment

    2023-08-30T18:10:54.213951  =


    2023-08-30T18:10:54.315400  / # . /lava-11385878/environment/lava-11385=
878/bin/lava-test-runner /lava-11385878/1

    2023-08-30T18:10:54.316576  =

 =

    ... (16 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
rk3399-gru-kevin           | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64ef8af5523cba5055286d6e

  Results:     77 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm64/defconfig+arm64-chro=
mebook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm64/defconfig+arm64-chro=
mebook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/64ef8af5523cba5055286d78
        failing since 169 days (last pass: v4.19.273-cip92-277-g507c8d80b9e=
20, first fail: v4.19.276-cip93-5-g2eb2a953ab59)

    2023-08-30T18:32:08.544898  <8>[   36.368147] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-08-30T18:32:09.560432  /lava-11385916/1/../bin/lava-test-case

    2023-08-30T18:32:09.569766  <8>[   37.393442] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/64ef8af5523cba5055286d79
        failing since 169 days (last pass: v4.19.273-cip92-277-g507c8d80b9e=
20, first fail: v4.19.276-cip93-5-g2eb2a953ab59)

    2023-08-30T18:32:07.519385  <8>[   35.341761] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-08-30T18:32:08.535330  /lava-11385916/1/../bin/lava-test-case
   =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64         | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef89a8fd2e17c399286d86

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm64/defconfig/gcc-10/lab=
-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm64/defconfig/gcc-10/lab=
-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef89a8fd2e17c399286d8f
        failing since 223 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-08-30T18:27:16.408118  / # #

    2023-08-30T18:27:16.510290  export SHELL=3D/bin/sh

    2023-08-30T18:27:16.510990  #

    2023-08-30T18:27:16.612388  / # export SHELL=3D/bin/sh. /lava-11385901/=
environment

    2023-08-30T18:27:16.613127  =


    2023-08-30T18:27:16.714546  / # . /lava-11385901/environment/lava-11385=
901/bin/lava-test-runner /lava-11385901/1

    2023-08-30T18:27:16.715630  =


    2023-08-30T18:27:16.732547  / # /lava-11385901/bin/lava-test-runner /la=
va-11385901/1

    2023-08-30T18:27:16.790573  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-30T18:27:16.791080  + cd /lava-1138590<8>[   15.625227] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11385901_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
zynqmp-zcu102              | arm64  | lab-cip         | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef89c33e64a96d82286d7f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm64/defconfig/gcc-10/lab=
-cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm64/defconfig/gcc-10/lab=
-cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef89c33e64a96d82286d82
        failing since 223 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-08-30T18:25:49.395232  + set +x
    2023-08-30T18:25:49.396317  <8>[    3.740556] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1003003_1.5.2.4.1>
    2023-08-30T18:25:49.499522  / # #
    2023-08-30T18:25:49.600939  export SHELL=3D/bin/sh
    2023-08-30T18:25:49.601303  #
    2023-08-30T18:25:49.702313  / # export SHELL=3D/bin/sh. /lava-1003003/e=
nvironment
    2023-08-30T18:25:49.702627  =

    2023-08-30T18:25:49.803652  / # . /lava-1003003/environment/lava-100300=
3/bin/lava-test-runner /lava-1003003/1
    2023-08-30T18:25:49.804117  =

    2023-08-30T18:25:49.806252  / # /lava-1003003/bin/lava-test-runner /lav=
a-1003003/1 =

    ... (13 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
zynqmp-zcu102              | arm64  | lab-cip         | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef8ac7866e74ab4b286d74

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm64/defconfig+arm64-chro=
mebook/gcc-10/lab-cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm64/defconfig+arm64-chro=
mebook/gcc-10/lab-cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef8ac7866e74ab4b286d77
        failing since 223 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-08-30T18:30:13.535162  <8>[    3.729334] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1003012_1.5.2.4.1>
    2023-08-30T18:30:13.640841  / # #
    2023-08-30T18:30:13.742801  export SHELL=3D/bin/sh
    2023-08-30T18:30:13.743296  #
    2023-08-30T18:30:13.844725  / # export SHELL=3D/bin/sh. /lava-1003012/e=
nvironment
    2023-08-30T18:30:13.845199  =

    2023-08-30T18:30:13.946644  / # . /lava-1003012/environment/lava-100301=
2/bin/lava-test-runner /lava-1003012/1
    2023-08-30T18:30:13.947449  =

    2023-08-30T18:30:13.950248  / # /lava-1003012/bin/lava-test-runner /lav=
a-1003012/1
    2023-08-30T18:30:13.987257  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20

