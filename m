Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C55C61DA7
	for <webhook@archiver.kernel.org>; Wed, 22 Nov 2023 20:04:52 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web11.34269.1700683483064088156
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 22 Nov 2023 12:04:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=KMaLGoPR;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.170, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6be0277c05bso219577b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 22 Nov 2023 12:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700683482; x=1701288282; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fj1uobh0HW5bmybb5MqiQN16lUxn+xiv38uwuGhCO0c=;
        b=KMaLGoPRz44USHVQBBvGXh97Os9nnMlY3iYqqPna9ZyZEaoxXzQTbkadNOYanLmj4l
         3mrenCuvwOjzx/20EMyrDO4K16vzgx+RFexUbUC2AYICcz52bgP0LKWi9vW5ZAbEwMO0
         SAwyWEoG4yb+9gUl1T0p6TEgHagqShSw1q1jimFY25CCO4i4keKR/rEdaLipIRRnGQMW
         sEWedLJ9sOTrgViGlzBQrauQVRIbc7z7ilgQFJWCyTgDMARzYvBGA5504VWop1h0HjlH
         enfk2UbdESM8KNWBuQA03hNJAlrUasVCNfNw7yocu3IXU2XHtPNCWv0mmKTn/WTqQBKq
         l15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700683482; x=1701288282;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fj1uobh0HW5bmybb5MqiQN16lUxn+xiv38uwuGhCO0c=;
        b=SVTyBkY0kPZ47MTrY0CSJu1LoxcqQcYSQTMjNct2gRPyufpl0blWSX+ECWnSnj5D/7
         LhckSvaaqWz/Ql/RzbEHUspdHCf9LYicqmXLW8wgiqxq+vU8Qexaq/eZ+0FUl9RHIhBn
         BgVK3hJBwWb2Fifgp3Uz8phuYL/S+HWauTVqLoKxaxi+5FOGcVcH5nH6rO7CJXuUG3Um
         pbkiuK0lLQkyIkE/I3qfpI5jTrBNmayWAZ73tFqN4G5Dz/2uYhWUuf4sjSXzYw+mXuYf
         AmPQi9MDIbCGF5EYzy04htsP3D09WOAC24ohOcE1DxlJzoBe8dnV+PBxk6emAHUhNFK+
         2ARQ==
X-Gm-Message-State: AOJu0YxwfY6a5SeJlabBQOg2VhvcZUFnQ14fHKoq3uZkHPI392dZP9k1
	7CFuUdzEW2krSckoS0rpozrQChzPjYSgvu6x38Y=
X-Google-Smtp-Source: AGHT+IHX921WRjFOGcL+nyjdNqOCscKMApWIOoEQT8hHoQ1N/JhkGCo3dPoUYrChehMFgXaFuvM6Tw==
X-Received: by 2002:a05:6a00:4287:b0:6bd:71e3:b647 with SMTP id bx7-20020a056a00428700b006bd71e3b647mr4690956pfb.19.1700683481444;
        Wed, 22 Nov 2023 12:04:41 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b5-20020aa78705000000b006cb69ff0444sm110625pfo.151.2023.11.22.12.04.40
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 12:04:40 -0800 (PST)
Message-ID: <655e5ed8.a70a0220.12d37.09e3@mx.google.com>
Date: Wed, 22 Nov 2023 12:04:40 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.200-cip40-188-g33d0b44cd71d
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 151 runs,
 12 regressions (v5.10.200-cip40-188-g33d0b44cd71d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Nov 2023 20:04:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13640

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 151 runs, 12 regressio=
ns (v5.10.200-cip40-188-g33d0b44cd71d)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
       | regressions
-------------------------+-------+---------------+----------+--------------=
-------+------------
bcm2836-rpi-2-b          | arm   | lab-collabora | gcc-10   | bcm2835_defco=
nfig   | 1          =

beaglebone-black         | arm   | lab-broonie   | gcc-10   | omap2plus_def=
config | 1          =

beaglebone-black         | arm   | lab-cip       | gcc-10   | omap2plus_def=
config | 1          =

juno-uboot               | arm64 | lab-broonie   | gcc-10   | defconfig+kse=
lftest | 1          =

r8a7743-iwg20d-q7        | arm   | lab-cip       | gcc-10   | shmobile_defc=
onfig  | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
       | 1          =

r8a774c0-ek874           | arm64 | lab-cip       | gcc-10   | defconfig+kse=
lftest | 1          =

r8a774c0-ek874           | arm64 | lab-cip       | gcc-10   | defconfig    =
       | 1          =

r8a77960-ulcb            | arm64 | lab-collabora | gcc-10   | defconfig    =
       | 1          =

rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig+kse=
lftest | 1          =

rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig    =
       | 1          =

sun50i-h6-pine-h64       | arm64 | lab-collabora | gcc-10   | defconfig    =
       | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.200-cip40-188-g33d0b44cd71d/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.200-cip40-188-g33d0b44cd71d
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      33d0b44cd71d9f81944784e605bc1def7fa0b71e =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
       | regressions
-------------------------+-------+---------------+----------+--------------=
-------+------------
bcm2836-rpi-2-b          | arm   | lab-collabora | gcc-10   | bcm2835_defco=
nfig   | 1          =


  Details:     https://kernelci.org/test/plan/id/655e51b141d1e1815c7e4a73

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm/bcm2835_defconfig/gcc-10=
/lab-collabora/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm/bcm2835_defconfig/gcc-10=
/lab-collabora/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/655e51b141d1e1815c7e4a7c
        failing since 118 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-11-22T19:14:44.349238  / # #

    2023-11-22T19:14:44.451392  export SHELL=3D/bin/sh

    2023-11-22T19:14:44.452091  #

    2023-11-22T19:14:44.553501  / # export SHELL=3D/bin/sh. /lava-12061836/=
environment

    2023-11-22T19:14:44.554210  =


    2023-11-22T19:14:44.655685  / # . /lava-12061836/environment/lava-12061=
836/bin/lava-test-runner /lava-12061836/1

    2023-11-22T19:14:44.656814  =


    2023-11-22T19:14:44.673450  / # /lava-12061836/bin/lava-test-runner /la=
va-12061836/1

    2023-11-22T19:14:44.737307  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-22T19:14:44.780271  + cd /lava-12061836/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
       | regressions
-------------------------+-------+---------------+----------+--------------=
-------+------------
beaglebone-black         | arm   | lab-broonie   | gcc-10   | omap2plus_def=
config | 1          =


  Details:     https://kernelci.org/test/plan/id/655e53f8a05b6302727e4a7d

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm/omap2plus_defconfig/gcc-=
10/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm/omap2plus_defconfig/gcc-=
10/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/655e53f8a05b6302727e4ab2
        failing since 322 days (last pass: v5.10.155-cip21-405-g26d566555c3=
de, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2023-11-22T19:18:01.589020  <8>[   18.967324] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 262808_1.5.2.4.1>
    2023-11-22T19:18:01.696625  / # #
    2023-11-22T19:18:01.798660  export SHELL=3D/bin/sh
    2023-11-22T19:18:01.799174  #
    2023-11-22T19:18:01.900607  / # export SHELL=3D/bin/sh. /lava-262808/en=
vironment
    2023-11-22T19:18:01.901180  =

    2023-11-22T19:18:02.002612  / # . /lava-262808/environment/lava-262808/=
bin/lava-test-runner /lava-262808/1
    2023-11-22T19:18:02.003503  =

    2023-11-22T19:18:02.006948  / # /lava-262808/bin/lava-test-runner /lava=
-262808/1
    2023-11-22T19:18:02.116099  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
       | regressions
-------------------------+-------+---------------+----------+--------------=
-------+------------
beaglebone-black         | arm   | lab-cip       | gcc-10   | omap2plus_def=
config | 1          =


  Details:     https://kernelci.org/test/plan/id/655e5a30749fdc27577e4aff

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm/omap2plus_defconfig/gcc-=
10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm/omap2plus_defconfig/gcc-=
10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/655e5a30749fdc27577e4b37
        failing since 322 days (last pass: v5.10.155-cip21-405-g26d566555c3=
de, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2023-11-22T19:44:35.381923  <8>[   14.026800] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1043314_1.5.2.4.1>
    2023-11-22T19:44:35.490479  / # #
    2023-11-22T19:44:35.591921  export SHELL=3D/bin/sh
    2023-11-22T19:44:35.592459  #
    2023-11-22T19:44:35.693376  / # export SHELL=3D/bin/sh. /lava-1043314/e=
nvironment
    2023-11-22T19:44:35.693813  =

    2023-11-22T19:44:35.794795  / # . /lava-1043314/environment/lava-104331=
4/bin/lava-test-runner /lava-1043314/1
    2023-11-22T19:44:35.795511  =

    2023-11-22T19:44:35.799743  / # /lava-1043314/bin/lava-test-runner /lav=
a-1043314/1
    2023-11-22T19:44:35.896523  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
       | regressions
-------------------------+-------+---------------+----------+--------------=
-------+------------
juno-uboot               | arm64 | lab-broonie   | gcc-10   | defconfig+kse=
lftest | 1          =


  Details:     https://kernelci.org/test/plan/id/655e525ffc83bf48fb7e4ab8

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm64/defconfig+kselftest/gc=
c-10/lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm64/defconfig+kselftest/gc=
c-10/lab-broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/655e5260fc83bf48fb7e4af8
        failing since 62 days (last pass: v5.10.191-cip38-661-g112a3073ff26=
, first fail: v5.10.194-cip39-407-g664623343843d)

    2023-11-22T19:10:47.830492  <8>[   32.356635] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 262742_1.5.2.4.1>
    2023-11-22T19:10:47.938591  / # #
    2023-11-22T19:10:48.041500  export SHELL=3D/bin/sh
    2023-11-22T19:10:48.042276  #
    2023-11-22T19:10:48.144258  / # export SHELL=3D/bin/sh. /lava-262742/en=
vironment
    2023-11-22T19:10:48.145021  =

    2023-11-22T19:10:48.247101  / # . /lava-262742/environment/lava-262742/=
bin/lava-test-runner /lava-262742/1
    2023-11-22T19:10:48.248390  =

    2023-11-22T19:10:48.261846  / # /lava-262742/bin/lava-test-runner /lava=
-262742/1
    2023-11-22T19:10:48.438555  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
       | regressions
-------------------------+-------+---------------+----------+--------------=
-------+------------
r8a7743-iwg20d-q7        | arm   | lab-cip       | gcc-10   | shmobile_defc=
onfig  | 1          =


  Details:     https://kernelci.org/test/plan/id/655e51fccc1032fb6b7e4b10

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm/shmobile_defconfig/gcc-1=
0/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm/shmobile_defconfig/gcc-1=
0/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/655e51fccc1032fb6b7e4=
b11
        new failure (last pass: v5.10.194-cip39-915-g96fa7f16cf02) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
       | regressions
-------------------------+-------+---------------+----------+--------------=
-------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
       | 1          =


  Details:     https://kernelci.org/test/plan/id/655e520beb52821baf7e4ad8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm64/defconfig/gcc-10/lab-c=
ip/baseline-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm64/defconfig/gcc-10/lab-c=
ip/baseline-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/655e520beb52821baf7e4ae1
        failing since 84 days (last pass: v5.10.180-cip33-21-g090289427e8b2=
, first fail: v5.10.191-cip38-218-g9947ff6f0dba7)

    2023-11-22T19:09:45.485579  + set +x
    2023-11-22T19:09:45.488814  <8>[   83.974075] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1043291_1.5.2.4.1>
    2023-11-22T19:09:45.594248  / # #
    2023-11-22T19:09:47.049340  export SHELL=3D/bin/sh
    2023-11-22T19:09:47.069839  #
    2023-11-22T19:09:47.070009  / # export SHELL=3D/bin/sh
    2023-11-22T19:09:49.016657  / # . /lava-1043291/environment
    2023-11-22T19:09:52.599636  /lava-1043291/bin/lava-test-runner /lava-10=
43291/1
    2023-11-22T19:09:52.621043  . /lava-1043291/environment
    2023-11-22T19:09:52.621413  / # /lava-1043291/bin/lava-test-runner /lav=
a-1043291/1 =

    ... (28 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
       | regressions
-------------------------+-------+---------------+----------+--------------=
-------+------------
r8a774c0-ek874           | arm64 | lab-cip       | gcc-10   | defconfig+kse=
lftest | 1          =


  Details:     https://kernelci.org/test/plan/id/655e511d5442218eac7e4a78

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm64/defconfig+kselftest/gc=
c-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm64/defconfig+kselftest/gc=
c-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/655e511d5442218eac7e4a81
        failing since 118 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-11-22T19:05:40.721965  <8>[   93.334225] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1043285_1.5.2.4.1>
    2023-11-22T19:05:40.830213  / # #
    2023-11-22T19:05:42.288944  export SHELL=3D/bin/sh
    2023-11-22T19:05:42.309605  #
    2023-11-22T19:05:42.309906  / # export SHELL=3D/bin/sh
    2023-11-22T19:05:44.257974  / # . /lava-1043285/environment
    2023-11-22T19:05:47.842887  /lava-1043285/bin/lava-test-runner /lava-10=
43285/1
    2023-11-22T19:05:47.864386  . /lava-1043285/environment
    2023-11-22T19:05:47.864751  / # /lava-1043285/bin/lava-test-runner /lav=
a-1043285/1
    2023-11-22T19:05:48.044219  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (26 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
       | regressions
-------------------------+-------+---------------+----------+--------------=
-------+------------
r8a774c0-ek874           | arm64 | lab-cip       | gcc-10   | defconfig    =
       | 1          =


  Details:     https://kernelci.org/test/plan/id/655e539dc43fd89ce27e4a75

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm64/defconfig/gcc-10/lab-c=
ip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm64/defconfig/gcc-10/lab-c=
ip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/655e539dc43fd89ce27e4a7e
        failing since 118 days (last pass: v5.10.182-cip35-289-g3c054954070=
6, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-11-22T19:16:19.022646  / # #
    2023-11-22T19:16:20.479052  export SHELL=3D/bin/sh
    2023-11-22T19:16:20.499394  #
    2023-11-22T19:16:20.499570  / # export SHELL=3D/bin/sh
    2023-11-22T19:16:22.445393  / # . /lava-1043304/environment
    2023-11-22T19:16:26.029343  /lava-1043304/bin/lava-test-runner /lava-10=
43304/1
    2023-11-22T19:16:26.050384  . /lava-1043304/environment
    2023-11-22T19:16:26.050514  / # /lava-1043304/bin/lava-test-runner /lav=
a-1043304/1
    2023-11-22T19:16:26.128700  + export 'TESTRUN_ID=3D1_bootrr'
    2023-11-22T19:16:26.129217  + cd /lava-1043304/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
       | regressions
-------------------------+-------+---------------+----------+--------------=
-------+------------
r8a77960-ulcb            | arm64 | lab-collabora | gcc-10   | defconfig    =
       | 1          =


  Details:     https://kernelci.org/test/plan/id/655e50ec2f008a05e87e4ae1

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/655e50ec2f008a05e87e4aea
        failing since 118 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-11-22T19:11:18.824517  / # #

    2023-11-22T19:11:18.925479  export SHELL=3D/bin/sh

    2023-11-22T19:11:18.926178  #

    2023-11-22T19:11:19.027479  / # export SHELL=3D/bin/sh. /lava-12061811/=
environment

    2023-11-22T19:11:19.028153  =


    2023-11-22T19:11:19.129380  / # . /lava-12061811/environment/lava-12061=
811/bin/lava-test-runner /lava-12061811/1

    2023-11-22T19:11:19.129979  =


    2023-11-22T19:11:19.137699  / # /lava-12061811/bin/lava-test-runner /la=
va-12061811/1

    2023-11-22T19:11:19.196608  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-22T19:11:19.196745  + cd /lav<8>[   16.443454] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12061811_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
       | regressions
-------------------------+-------+---------------+----------+--------------=
-------+------------
rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig+kse=
lftest | 1          =


  Details:     https://kernelci.org/test/plan/id/655e50542877b5aaaf7e4b1c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm64/defconfig+kselftest/gc=
c-10/lab-collabora/baseline-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm64/defconfig+kselftest/gc=
c-10/lab-collabora/baseline-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/655e50542877b5aaaf7e4b25
        failing since 88 days (last pass: v5.10.186-cip37-770-gddd36cfc4c4c=
8, first fail: v5.10.186-cip37-982-g80a0585c0aa62)

    2023-11-22T19:06:17.741033  / # #

    2023-11-22T19:06:18.999573  export SHELL=3D/bin/sh

    2023-11-22T19:06:19.010489  #

    2023-11-22T19:06:19.010958  / # export SHELL=3D/bin/sh

    2023-11-22T19:06:20.752040  / # . /lava-12061803/environment

    2023-11-22T19:06:23.953786  /lava-12061803/bin/lava-test-runner /lava-1=
2061803/1

    2023-11-22T19:06:23.964956  . /lava-12061803/environment

    2023-11-22T19:06:23.965239  / # /lava-12061803/bin/lava-test-runner /la=
va-12061803/1

    2023-11-22T19:06:24.096484  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-22T19:06:24.096923  + cd /lava-12061803/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
       | regressions
-------------------------+-------+---------------+----------+--------------=
-------+------------
rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig    =
       | 1          =


  Details:     https://kernelci.org/test/plan/id/655e5107248f5848917e4afe

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/655e5107248f5848917e4b07
        failing since 88 days (last pass: v5.10.186-cip37-770-gddd36cfc4c4c=
8, first fail: v5.10.186-cip37-982-g80a0585c0aa62)

    2023-11-22T19:09:11.957215  / # #

    2023-11-22T19:09:13.218488  export SHELL=3D/bin/sh

    2023-11-22T19:09:13.229459  #

    2023-11-22T19:09:13.229933  / # export SHELL=3D/bin/sh

    2023-11-22T19:09:14.974133  / # . /lava-12061816/environment

    2023-11-22T19:09:18.179098  /lava-12061816/bin/lava-test-runner /lava-1=
2061816/1

    2023-11-22T19:09:18.190615  . /lava-12061816/environment

    2023-11-22T19:09:18.195231  / # /lava-12061816/bin/lava-test-runner /la=
va-12061816/1

    2023-11-22T19:09:18.246179  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-22T19:09:18.246675  + cd /lava-12061816/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
       | regressions
-------------------------+-------+---------------+----------+--------------=
-------+------------
sun50i-h6-pine-h64       | arm64 | lab-collabora | gcc-10   | defconfig    =
       | 1          =


  Details:     https://kernelci.org/test/plan/id/655e50fe248f5848917e4a95

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/655e50fe248f5848917e4a9e
        failing since 118 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-11-22T19:11:34.273138  / # #

    2023-11-22T19:11:34.373810  export SHELL=3D/bin/sh

    2023-11-22T19:11:34.374030  #

    2023-11-22T19:11:34.474629  / # export SHELL=3D/bin/sh. /lava-12061809/=
environment

    2023-11-22T19:11:34.474790  =


    2023-11-22T19:11:34.575461  / # . /lava-12061809/environment/lava-12061=
809/bin/lava-test-runner /lava-12061809/1

    2023-11-22T19:11:34.575742  =


    2023-11-22T19:11:34.581255  / # /lava-12061809/bin/lava-test-runner /la=
va-12061809/1

    2023-11-22T19:11:34.648109  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-22T19:11:34.648267  + cd /lava-1206180<8>[   18.144942] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12061809_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

