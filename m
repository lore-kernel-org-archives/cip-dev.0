Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3891C47422
	for <webhook@archiver.kernel.org>; Sat, 13 Jan 2024 06:57:28 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web10.15014.1705129046531561531
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 12 Jan 2024 22:57:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=OiurmY4W;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.176, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d480c6342dso56119335ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 12 Jan 2024 22:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1705129045; x=1705733845; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OA19gCsvR7g3qEHcyXSB0UCGbBeppNex35xue6uvsg4=;
        b=OiurmY4WZhrTAm1yJbvApDkyR/1PA9TYaOF9KnVcf9BYUHl3fHSKTVkDsmZz2Bwraw
         f88b+FZt0gohoMHPqpXznlgbcz8zvNTmQvjf9LHyN/gHNRF03wDMkVNiKSzQz1YC4KPE
         TYRSy3vDT2CGz7VoSooCK4BTAPubaUVJ6xJHu2eMVTEAFcS42CvSGkzwb1FY7V5X5gIL
         TwXpfnF+0NbF5E4thP2ElDyybg27VCMnX2R3+XZTHa3EuwVEG/fAaOKRmk/EEWWIYHSt
         M1cjFxTVmbC1JUb4L6GNjZbwpi+JiwsW+gfhdn6cgMBtE+s3PyjoOtaIW5r5QxO08U5m
         FGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705129045; x=1705733845;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OA19gCsvR7g3qEHcyXSB0UCGbBeppNex35xue6uvsg4=;
        b=Km9cfy7te+Nmz5UEysj/OFUeGFTp/Wenw7XTXSGhH1ZxVP6J3IdNHuei276QzM4q3X
         wKv4vjvwEDdMxusCGqKIFiF6wWdVbgpzVG57lgd7/yvUsBOw0A+zDMjAz2pojcfiSU9x
         R4nSHbINpyU5hZkXDpmSEKyh2+06ejdVyB/rSM3OVP478CXE+zNqoQ3zNU2ltvLw7pd9
         sVhlequZP2s6bPC/Hvc3gFiKwbserwO6QT3w5i1Ll0XE7vI/y9YFQQjZe/hGOY47gdul
         KIAaoxnmDNaSpeEkCHM/2BnhFO70GHbBzOzEYhY1NCQ//LqR2YnyANVDLCOLDfDU97k9
         23GQ==
X-Gm-Message-State: AOJu0YxLQzTo0fdR10c6R//c8ad+u4nebbM9DaQLR28K5NCQf+Vicf7l
	ZwsoxHHYgyt5geJ6XTRfJCWyiHml+1SDI+nDL/LBa6CMLxM=
X-Google-Smtp-Source: AGHT+IGqsIyQVCYlznrPeVWvSI7ObXExMWbPhvoWpjoWAPupb+yWiCKzYj4Gx5JcwwqhQNFWEIc7Bg==
X-Received: by 2002:a17:902:d4c7:b0:1d3:e582:fa60 with SMTP id o7-20020a170902d4c700b001d3e582fa60mr3182836plg.28.1705129044985;
        Fri, 12 Jan 2024 22:57:24 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id mm3-20020a1709030a0300b001d4bb7cdc11sm4250661plb.88.2024.01.12.22.57.23
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 22:57:23 -0800 (PST)
Message-ID: <65a23453.170a0220.80548.eed8@mx.google.com>
Date: Fri, 12 Jan 2024 22:57:23 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.205-905-gb40421b142370
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 152 runs,
 18 regressions (v5.10.205-905-gb40421b142370)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 13 Jan 2024 06:57:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14359

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 152 runs, 18 regressio=
ns (v5.10.205-905-gb40421b142370)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
bcm2836-rpi-2-b          | arm   | lab-collabora | gcc-10   | bcm2835_defco=
nfig            | 1          =

beaglebone-black         | arm   | lab-broonie   | gcc-10   | omap2plus_def=
config          | 1          =

beaglebone-black         | arm   | lab-cip       | gcc-10   | omap2plus_def=
config          | 1          =

juno-uboot               | arm64 | lab-broonie   | gcc-10   | defconfig+kse=
lftest          | 1          =

juno-uboot               | arm64 | lab-broonie   | gcc-10   | defconfig    =
                | 1          =

r8a7743-iwg20d-q7        | arm   | lab-cip       | gcc-10   | shmobile_defc=
onfig           | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook   | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
                | 1          =

r8a774c0-ek874           | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook   | 1          =

r8a774c0-ek874           | arm64 | lab-cip       | gcc-10   | defconfig+kse=
lftest          | 1          =

r8a774c0-ek874           | arm64 | lab-cip       | gcc-10   | defconfig    =
                | 1          =

rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook   | 2          =

rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
...ok+kselftest | 2          =

rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig+kse=
lftest          | 1          =

rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig    =
                | 1          =

sun50i-h6-pine-h64       | arm64 | lab-collabora | gcc-10   | defconfig    =
                | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.205-905-gb40421b142370/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.205-905-gb40421b142370
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b40421b142370404ab8c5dae183e5541de854979 =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
bcm2836-rpi-2-b          | arm   | lab-collabora | gcc-10   | bcm2835_defco=
nfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/65a227aaf8d33a92dd52a43a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm/bcm2835_defconfig/gcc-10/lab-=
collabora/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm/bcm2835_defconfig/gcc-10/lab-=
collabora/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65a227aaf8d33a92dd52a443
        failing since 169 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2024-01-13T06:10:33.537846  / # #

    2024-01-13T06:10:33.639953  export SHELL=3D/bin/sh

    2024-01-13T06:10:33.640697  #

    2024-01-13T06:10:33.742060  / # export SHELL=3D/bin/sh. /lava-12521822/=
environment

    2024-01-13T06:10:33.742757  =


    2024-01-13T06:10:33.844190  / # . /lava-12521822/environment/lava-12521=
822/bin/lava-test-runner /lava-12521822/1

    2024-01-13T06:10:33.845249  =


    2024-01-13T06:10:33.888878  / # /lava-12521822/bin/lava-test-runner /la=
va-12521822/1

    2024-01-13T06:10:33.926282  + export 'TESTRUN_ID=3D1_bootrr'

    2024-01-13T06:10:33.964113  + cd /lava-12521822/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
beaglebone-black         | arm   | lab-broonie   | gcc-10   | omap2plus_def=
config          | 1          =


  Details:     https://kernelci.org/test/plan/id/65a22827047deba2bf52a434

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm/omap2plus_defconfig/gcc-10/la=
b-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm/omap2plus_defconfig/gcc-10/la=
b-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65a22827047deba2bf52a46e
        failing since 373 days (last pass: v5.10.155-cip21-405-g26d566555c3=
de, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2024-01-13T06:05:03.362523  <8>[   21.089555] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 454662_1.5.2.4.1>
    2024-01-13T06:05:03.471270  / # #
    2024-01-13T06:05:03.573753  export SHELL=3D/bin/sh
    2024-01-13T06:05:03.574373  #
    2024-01-13T06:05:03.676170  / # export SHELL=3D/bin/sh. /lava-454662/en=
vironment
    2024-01-13T06:05:03.676741  =

    2024-01-13T06:05:03.778404  / # . /lava-454662/environment/lava-454662/=
bin/lava-test-runner /lava-454662/1
    2024-01-13T06:05:03.779257  =

    2024-01-13T06:05:03.783443  / # /lava-454662/bin/lava-test-runner /lava=
-454662/1
    2024-01-13T06:05:03.886612  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
beaglebone-black         | arm   | lab-cip       | gcc-10   | omap2plus_def=
config          | 1          =


  Details:     https://kernelci.org/test/plan/id/65a228ef06ca53e4b852a42b

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm/omap2plus_defconfig/gcc-10/la=
b-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm/omap2plus_defconfig/gcc-10/la=
b-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65a228ef06ca53e4b852a464
        failing since 373 days (last pass: v5.10.155-cip21-405-g26d566555c3=
de, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2024-01-13T06:08:33.747006  / # #
    2024-01-13T06:08:33.847864  export SHELL=3D/bin/sh
    2024-01-13T06:08:33.848203  #
    2024-01-13T06:08:33.948798  / # export SHELL=3D/bin/sh. /lava-1075354/e=
nvironment
    2024-01-13T06:08:33.949142  =

    2024-01-13T06:08:34.049964  / # . /lava-1075354/environment/lava-107535=
4/bin/lava-test-runner /lava-1075354/1
    2024-01-13T06:08:34.050644  =

    2024-01-13T06:08:34.092858  / # /lava-1075354/bin/lava-test-runner /lav=
a-1075354/1
    2024-01-13T06:08:34.202096  + export 'TESTRUN_ID=3D1_bootrr'
    2024-01-13T06:08:34.202393  + cd /lava-1075354/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
juno-uboot               | arm64 | lab-broonie   | gcc-10   | defconfig+kse=
lftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/65a227bea7ffd8f6c952a46b

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig+kselftest/gcc-10/=
lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig+kselftest/gcc-10/=
lab-broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65a227bea7ffd8f6c952a4aa
        failing since 113 days (last pass: v5.10.191-cip38-661-g112a3073ff2=
6, first fail: v5.10.194-cip39-407-g664623343843d)

    2024-01-13T06:03:09.892955  <8>[   27.218533] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 454634_1.5.2.4.1>
    2024-01-13T06:03:10.002095  / # #
    2024-01-13T06:03:10.104029  export SHELL=3D/bin/sh
    2024-01-13T06:03:10.104685  #
    2024-01-13T06:03:10.206061  / # export SHELL=3D/bin/sh. /lava-454634/en=
vironment
    2024-01-13T06:03:10.206564  =

    2024-01-13T06:03:10.308151  / # . /lava-454634/environment/lava-454634/=
bin/lava-test-runner /lava-454634/1
    2024-01-13T06:03:10.308904  =

    2024-01-13T06:03:10.324038  / # /lava-454634/bin/lava-test-runner /lava=
-454634/1
    2024-01-13T06:03:10.500773  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
juno-uboot               | arm64 | lab-broonie   | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/65a22c5a0f99071b9952a471

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig/gcc-10/lab-brooni=
e/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig/gcc-10/lab-brooni=
e/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65a22c5a0f99071b9952a4af
        new failure (last pass: v5.10.205-897-gcc9858ae2881)

    2024-01-13T06:22:53.775662  / # #
    2024-01-13T06:22:53.878521  export SHELL=3D/bin/sh
    2024-01-13T06:22:53.879289  #
    2024-01-13T06:22:53.981231  / # export SHELL=3D/bin/sh. /lava-454774/en=
vironment
    2024-01-13T06:22:53.982107  =

    2024-01-13T06:22:54.084098  / # . /lava-454774/environment/lava-454774/=
bin/lava-test-runner /lava-454774/1
    2024-01-13T06:22:54.085404  =

    2024-01-13T06:22:54.099311  / # /lava-454774/bin/lava-test-runner /lava=
-454774/1
    2024-01-13T06:22:54.158133  + export 'TESTRUN_ID=3D1_bootrr'
    2024-01-13T06:22:54.158660  + cd /lava-454774/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a7743-iwg20d-q7        | arm   | lab-cip       | gcc-10   | shmobile_defc=
onfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65a22821047deba2bf52a3f1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm/shmobile_defconfig/gcc-10/lab=
-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm/shmobile_defconfig/gcc-10/lab=
-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65a22821047deba2bf52a=
3f2
        failing since 29 days (last pass: v5.10.201-cip41-473-gc43d7b7bbe83=
a, first fail: v5.10.201-cip41-69-g8f7b450fc28ed) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/65a2291985d814243052a403

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig+arm64-chromebook/=
gcc-10/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig+arm64-chromebook/=
gcc-10/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65a2291985d814243052a40c
        failing since 169 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2024-01-13T06:09:10.342028  + set +x
    2024-01-13T06:09:10.345235  <8>[   83.971552] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1075334_1.5.2.4.1>
    2024-01-13T06:09:10.451771  / # #
    2024-01-13T06:09:11.907395  export SHELL=3D/bin/sh
    2024-01-13T06:09:11.928279  #
    2024-01-13T06:09:11.928448  / # export SHELL=3D/bin/sh
    2024-01-13T06:09:13.874412  / # . /lava-1075334/environment
    2024-01-13T06:09:17.455646  /lava-1075334/bin/lava-test-runner /lava-10=
75334/1
    2024-01-13T06:09:17.477202  . /lava-1075334/environment
    2024-01-13T06:09:17.477619  / # /lava-1075334/bin/lava-test-runner /lav=
a-1075334/1 =

    ... (28 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/65a22db6481a319d1552a432

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig/gcc-10/lab-cip/ba=
seline-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig/gcc-10/lab-cip/ba=
seline-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65a22db6481a319d1552a43b
        failing since 135 days (last pass: v5.10.180-cip33-21-g090289427e8b=
2, first fail: v5.10.191-cip38-218-g9947ff6f0dba7)

    2024-01-13T06:28:45.778988  + set +x
    2024-01-13T06:28:45.782235  <8>[   83.976527] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1075401_1.5.2.4.1>
    2024-01-13T06:28:45.890572  / # #
    2024-01-13T06:28:47.348540  export SHELL=3D/bin/sh
    2024-01-13T06:28:47.369309  #
    2024-01-13T06:28:47.369725  / # export SHELL=3D/bin/sh
    2024-01-13T06:28:49.319162  / # . /lava-1075401/environment
    2024-01-13T06:28:52.905227  /lava-1075401/bin/lava-test-runner /lava-10=
75401/1
    2024-01-13T06:28:52.926558  . /lava-1075401/environment
    2024-01-13T06:28:52.926924  / # /lava-1075401/bin/lava-test-runner /lav=
a-1075401/1 =

    ... (28 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a774c0-ek874           | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/65a229612ba1db4ddc52a404

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig+arm64-chromebook/=
gcc-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig+arm64-chromebook/=
gcc-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65a229612ba1db4ddc52a40d
        failing since 169 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2024-01-13T06:10:17.820580  / # #
    2024-01-13T06:10:19.278308  export SHELL=3D/bin/sh
    2024-01-13T06:10:19.299289  #
    2024-01-13T06:10:19.299810  / # export SHELL=3D/bin/sh
    2024-01-13T06:10:21.248936  / # . /lava-1075335/environment
    2024-01-13T06:10:24.835741  /lava-1075335/bin/lava-test-runner /lava-10=
75335/1
    2024-01-13T06:10:24.857208  . /lava-1075335/environment
    2024-01-13T06:10:24.857560  / # /lava-1075335/bin/lava-test-runner /lav=
a-1075335/1
    2024-01-13T06:10:24.934171  + export 'TESTRUN_ID=3D1_bootrr'
    2024-01-13T06:10:24.934676  + cd /lava-1075335/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a774c0-ek874           | arm64 | lab-cip       | gcc-10   | defconfig+kse=
lftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/65a22ab58c6c42358e52a3f4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig+kselftest/gcc-10/=
lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig+kselftest/gcc-10/=
lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65a22ab58c6c42358e52a3fd
        failing since 169 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2024-01-13T06:15:58.830511  =

    2024-01-13T06:16:00.289299  / # #export SHELL=3D/bin/sh
    2024-01-13T06:16:00.310297  =

    2024-01-13T06:16:00.310856  / # export SHELL=3D/bin/sh
    2024-01-13T06:16:02.262406  / # . /lava-1075343/environment
    2024-01-13T06:16:05.853815  /lava-1075343/bin/lava-test-runner /lava-10=
75343/1
    2024-01-13T06:16:05.875368  . /lava-1075343/environment
    2024-01-13T06:16:05.875789  / # /lava-1075343/bin/lava-test-runner /lav=
a-1075343/1
    2024-01-13T06:16:06.057804  + export 'TESTRUN_ID=3D1_bootrr'
    2024-01-13T06:16:06.058317  + cd /lava-1075343/1/tests/1_bootrr =

    ... (24 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a774c0-ek874           | arm64 | lab-cip       | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/65a22e894788f643fa52a3fb

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig/gcc-10/lab-cip/ba=
seline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig/gcc-10/lab-cip/ba=
seline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65a22e894788f643fa52a404
        failing since 169 days (last pass: v5.10.182-cip35-289-g3c054954070=
6, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2024-01-13T06:32:16.316717  / # #
    2024-01-13T06:32:17.774925  export SHELL=3D/bin/sh
    2024-01-13T06:32:17.796148  #
    2024-01-13T06:32:17.796726  / # export SHELL=3D/bin/sh
    2024-01-13T06:32:19.745996  / # . /lava-1075399/environment
    2024-01-13T06:32:23.332172  /lava-1075399/bin/lava-test-runner /lava-10=
75399/1
    2024-01-13T06:32:23.353703  . /lava-1075399/environment
    2024-01-13T06:32:23.354150  / # /lava-1075399/bin/lava-test-runner /lav=
a-1075399/1
    2024-01-13T06:32:23.429527  + export 'TESTRUN_ID=3D1_bootrr'
    2024-01-13T06:32:23.430061  + cd /lava-1075399/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/65a227277d9325770152a405

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig+arm64-chromebook/=
gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig+arm64-chromebook/=
gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/65a227277d9325770152a40f
        failing since 267 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2024-01-13T06:00:47.009768  <8>[   61.169181] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2024-01-13T06:00:48.035575  /lava-12521711/1/../bin/lava-test-case

    2024-01-13T06:00:48.047096  <8>[   62.206194] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/65a227277d9325770152a410
        failing since 267 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2024-01-13T06:00:45.974251  <8>[   60.133103] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2024-01-13T06:00:46.999033  /lava-12521711/1/../bin/lava-test-case
   =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
...ok+kselftest | 2          =


  Details:     https://kernelci.org/test/plan/id/65a22def319cb86e3e52a428

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig+arm64-chromebook+=
kselftest/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig+arm64-chromebook+=
kselftest/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/65a22def319cb86e3e52a432
        failing since 267 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2024-01-13T06:30:02.484742  /lava-12521980/1/../bin/lava-test-case

    2024-01-13T06:30:02.510772  <8>[   70.691983] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/65a22def319cb86e3e52a433
        failing since 267 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2024-01-13T06:30:01.385590  /lava-12521980/1/../bin/lava-test-case

    2024-01-13T06:30:01.409224  <8>[   69.591104] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig+kse=
lftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/65a227570ebfcba2e352a3f7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig+kselftest/gcc-10/=
lab-collabora/baseline-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig+kselftest/gcc-10/=
lab-collabora/baseline-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65a227570ebfcba2e352a400
        failing since 139 days (last pass: v5.10.186-cip37-770-gddd36cfc4c4=
c8, first fail: v5.10.186-cip37-982-g80a0585c0aa62)

    2024-01-13T06:06:48.619310  / # #

    2024-01-13T06:06:49.872635  export SHELL=3D/bin/sh

    2024-01-13T06:06:49.882901  #

    2024-01-13T06:06:49.882984  / # export SHELL=3D/bin/sh

    2024-01-13T06:06:51.617187  / # . /lava-12521740/environment

    2024-01-13T06:06:54.805143  /lava-12521740/bin/lava-test-runner /lava-1=
2521740/1

    2024-01-13T06:06:54.815539  . /lava-12521740/environment

    2024-01-13T06:06:54.815603  / # /lava-12521740/bin/lava-test-runner /la=
va-12521740/1

    2024-01-13T06:06:54.953898  + export 'TESTRUN_ID=3D1_bootrr'

    2024-01-13T06:06:54.954066  + cd /lava-12521740/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/65a22be245fb520cf752a402

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig/gcc-10/lab-collab=
ora/baseline-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig/gcc-10/lab-collab=
ora/baseline-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65a22be245fb520cf752a40b
        failing since 139 days (last pass: v5.10.186-cip37-770-gddd36cfc4c4=
c8, first fail: v5.10.186-cip37-982-g80a0585c0aa62)

    2024-01-13T06:26:25.960513  / # #

    2024-01-13T06:26:27.221049  export SHELL=3D/bin/sh

    2024-01-13T06:26:27.231924  #

    2024-01-13T06:26:27.232392  / # export SHELL=3D/bin/sh

    2024-01-13T06:26:28.975363  / # . /lava-12521964/environment

    2024-01-13T06:26:32.178374  /lava-12521964/bin/lava-test-runner /lava-1=
2521964/1

    2024-01-13T06:26:32.189821  . /lava-12521964/environment

    2024-01-13T06:26:32.190135  / # /lava-12521964/bin/lava-test-runner /la=
va-12521964/1

    2024-01-13T06:26:32.245512  + export 'TESTRUN_ID=3D1_bootrr'

    2024-01-13T06:26:32.245998  + cd /lava-12521964/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
sun50i-h6-pine-h64       | arm64 | lab-collabora | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/65a22bd0b1189d63ee52a445

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig/gcc-10/lab-collab=
ora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig/gcc-10/lab-collab=
ora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65a22bd0b1189d63ee52a44e
        failing since 169 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2024-01-13T06:28:24.294665  / # #

    2024-01-13T06:28:24.396855  export SHELL=3D/bin/sh

    2024-01-13T06:28:24.397551  #

    2024-01-13T06:28:24.498932  / # export SHELL=3D/bin/sh. /lava-12521951/=
environment

    2024-01-13T06:28:24.499622  =


    2024-01-13T06:28:24.601132  / # . /lava-12521951/environment/lava-12521=
951/bin/lava-test-runner /lava-12521951/1

    2024-01-13T06:28:24.602192  =


    2024-01-13T06:28:24.619203  / # /lava-12521951/bin/lava-test-runner /la=
va-12521951/1

    2024-01-13T06:28:24.660888  + export 'TESTRUN_ID=3D1_bootrr'

    2024-01-13T06:28:24.678090  + cd /lava-1252195<8>[   18.167548] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12521951_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

