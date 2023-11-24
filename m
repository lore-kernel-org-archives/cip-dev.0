Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75393C636CB
	for <webhook@archiver.kernel.org>; Fri, 24 Nov 2023 11:37:16 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
 by mx.groups.io with SMTP id smtpd.web10.133494.1700825830940755750
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 24 Nov 2023 03:37:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=ndjePrch;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.176, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6cbbfdf72ecso1750071b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 24 Nov 2023 03:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700825830; x=1701430630; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=J8lyUFydS7vnb2Kq04B/xJbrM4fKRsOkcB+LMtjOXJk=;
        b=ndjePrcheR3NqCjRuPb2uZvMkThaO7Ka19HA1IE3dwk0hk2ifAxs5nHrv5KuRKH8z5
         8ajcPyW4Gsb/6prT0fXuRrB5umQy+d5iGj4EOo3BDR/uMOLoOZmdVLX4p061ckWmTCLQ
         Hj8qLNkR6R32mM7xighAlOIbH6xqAa40bIahAp95nQGtpcIqhvDk2EfPR5X7CjWPsqxI
         TjTNFTduYua7wcQGi6yKVH0uwhbk7RBe3JiZ2d2KiXcydV0OAw648K+5EKRDoX7bba9g
         EYgqk19g3o5S23WZgmiojHD7+yC9+/nSbctWV6LWLUlLecWiLkFm8nORFFRyhop7w1q+
         5DXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700825830; x=1701430630;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J8lyUFydS7vnb2Kq04B/xJbrM4fKRsOkcB+LMtjOXJk=;
        b=IL/omISNwsNxs+XRKPmr0pNl/wllQ2676X+2FXc70Ooh8iuIB7Me8NUPTAocsbJU+c
         mt3Lnx25IFcp/HaWBhN2xfJFsZl/kvLfC8GIQ1I3QPYvE6aFjTBco9Om6YoIvrw0JVES
         WcFQw3jMIpoNjHRYz/A2uTzA44PyBQVSzZIQiafZTSq4yPee/yHWz3tkNgRwp3UTGdcz
         inIt/yGtijE5yvMs2aq8WnOTDRtj4r5T4uR2weLyl8nQGlN0STtaRMrBYw9hO0u8HGjl
         AWJDAcOcrKOUu0U4z9SGpVVW9idDpg/766GJjEo48ydzlp7U7hvC4MP8CliCPTGjg+tF
         apAQ==
X-Gm-Message-State: AOJu0YyGRuKDqnevna8gXLCJ2AxIs5SInhE1I6PcdQu1sdL5R+vwrLjS
	/00R9m66OlJ7i6AgWY0cIsSSNsKvdjIHCIq/PtU=
X-Google-Smtp-Source: AGHT+IG+74K13vdB781Z1GYOJfwPFudM9TkbfSLqWjnTwjQcbn7Rxjdil8T3FJNbpXrIEyIQ4jvsAg==
X-Received: by 2002:a05:6a20:8403:b0:18a:d7a8:5e5a with SMTP id c3-20020a056a20840300b0018ad7a85e5amr3995526pzd.58.1700825829526;
        Fri, 24 Nov 2023 03:37:09 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ce9-20020a17090aff0900b002807c61ca2bsm3081577pjb.26.2023.11.24.03.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 03:37:08 -0800 (PST)
Message-ID: <65608ae4.170a0220.bbd2c.8495@mx.google.com>
Date: Fri, 24 Nov 2023 03:37:08 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.201-cip41-11-ga539098fe70dd
Subject: cip/linux-5.10.y-cip baseline: 115 runs,
 21 regressions (v5.10.201-cip41-11-ga539098fe70dd)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Nov 2023 11:37:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13725

cip/linux-5.10.y-cip baseline: 115 runs, 21 regressions (v5.10.201-cip41-11=
-ga539098fe70dd)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
at91sam9g20ek            | arm   | lab-broonie   | gcc-10   | multi_v5_defc=
onfig           | 1          =

bcm2836-rpi-2-b          | arm   | lab-collabora | gcc-10   | bcm2835_defco=
nfig            | 1          =

beaglebone-black         | arm   | lab-cip       | gcc-10   | multi_v7_defc=
onfig           | 1          =

beaglebone-black         | arm   | lab-broonie   | gcc-10   | omap2plus_def=
config          | 1          =

beaglebone-black         | arm   | lab-cip       | gcc-10   | omap2plus_def=
config          | 1          =

fsl-ls1028a-rdb          | arm64 | lab-nxp       | gcc-10   | defconfig    =
                | 1          =

imx6q-sabrelite          | arm   | lab-collabora | gcc-10   | multi_v7_defc=
onfig           | 1          =

imx6ul-14x14-evk         | arm   | lab-nxp       | gcc-10   | multi_v7_defc=
onfig           | 1          =

imx7d-sdb                | arm   | lab-nxp       | gcc-10   | multi_v7_defc=
onfig           | 1          =

juno-uboot               | arm64 | lab-broonie   | gcc-10   | cip://5.10.y-=
...64_defconfig | 1          =

juno-uboot               | arm64 | lab-broonie   | gcc-10   | defconfig+kse=
lftest          | 1          =

r8a7743-iwg20d-q7        | arm   | lab-cip       | gcc-10   | shmobile_defc=
onfig           | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+kse=
lftest          | 1          =

r8a774c0-ek874           | arm64 | lab-cip       | gcc-10   | defconfig    =
                | 1          =

r8a77960-ulcb            | arm64 | lab-collabora | gcc-10   | defconfig    =
                | 1          =

rk3288-veyron-jaq        | arm   | lab-collabora | gcc-10   | multi_v7_defc=
onfig           | 4          =

rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig    =
                | 1          =

sun50i-h6-pine-h64       | arm64 | lab-collabora | gcc-10   | defconfig    =
                | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-11-ga539098fe70dd/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-11-ga539098fe70dd
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a539098fe70dd29de0ce67ad5a39c40867ba5b2c =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
at91sam9g20ek            | arm   | lab-broonie   | gcc-10   | multi_v5_defc=
onfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/656086a0d596c2cda27e4a78

  Results:     47 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline=
-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline=
-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656086a0d596c2cda27e4aaf
        failing since 314 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-11-24T11:18:22.023897  + set +x
    2023-11-24T11:18:22.024396  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 269229_1.5.2=
.4.1>
    2023-11-24T11:18:22.138143  / # #
    2023-11-24T11:18:22.241068  export SHELL=3D/bin/sh
    2023-11-24T11:18:22.241866  #
    2023-11-24T11:18:22.343845  / # export SHELL=3D/bin/sh. /lava-269229/en=
vironment
    2023-11-24T11:18:22.344633  =

    2023-11-24T11:18:22.446581  / # . /lava-269229/environment/lava-269229/=
bin/lava-test-runner /lava-269229/1
    2023-11-24T11:18:22.447906  =

    2023-11-24T11:18:22.451553  / # /lava-269229/bin/lava-test-runner /lava=
-269229/1 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
bcm2836-rpi-2-b          | arm   | lab-collabora | gcc-10   | bcm2835_defco=
nfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/65607fa0f10bd631fe7e4a83

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm/bcm2835_defconfig/gcc-10/lab-collabora/baselin=
e-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm/bcm2835_defconfig/gcc-10/lab-collabora/baselin=
e-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65607fa0f10bd631fe7e4a8c
        failing since 121 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-11-24T10:55:11.855425  / # #

    2023-11-24T10:55:11.957602  export SHELL=3D/bin/sh

    2023-11-24T10:55:11.958322  #

    2023-11-24T10:55:12.059742  / # export SHELL=3D/bin/sh. /lava-12073680/=
environment

    2023-11-24T10:55:12.060471  =


    2023-11-24T10:55:12.161975  / # . /lava-12073680/environment/lava-12073=
680/bin/lava-test-runner /lava-12073680/1

    2023-11-24T10:55:12.163138  =


    2023-11-24T10:55:12.205710  / # /lava-12073680/bin/lava-test-runner /la=
va-12073680/1

    2023-11-24T10:55:12.244361  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-24T10:55:12.282196  + cd /lava-12073680/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
beaglebone-black         | arm   | lab-cip       | gcc-10   | multi_v7_defc=
onfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65608524410ae163f07e4a89

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-bea=
glebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-bea=
glebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65608524410ae163f07e4aba
        failing since 314 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-11-24T11:11:50.599285  <8>[   16.644736] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1044710_1.5.2.4.1>
    2023-11-24T11:11:50.706257  / # #
    2023-11-24T11:11:50.807663  export SHELL=3D/bin/sh
    2023-11-24T11:11:50.808104  #
    2023-11-24T11:11:50.909046  / # export SHELL=3D/bin/sh. /lava-1044710/e=
nvironment
    2023-11-24T11:11:50.909608  =

    2023-11-24T11:11:51.010640  / # . /lava-1044710/environment/lava-104471=
0/bin/lava-test-runner /lava-1044710/1
    2023-11-24T11:11:51.011464  =

    2023-11-24T11:11:51.015572  / # /lava-1044710/bin/lava-test-runner /lav=
a-1044710/1
    2023-11-24T11:11:51.109297  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
beaglebone-black         | arm   | lab-broonie   | gcc-10   | omap2plus_def=
config          | 1          =


  Details:     https://kernelci.org/test/plan/id/656080c7436b1759987e4a96

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm/omap2plus_defconfig/gcc-10/lab-broonie/baselin=
e-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm/omap2plus_defconfig/gcc-10/lab-broonie/baselin=
e-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656080c7436b1759987e4acf
        failing since 314 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-11-24T10:53:41.024447  <8>[   19.608289] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 269261_1.5.2.4.1>
    2023-11-24T10:53:41.132770  / # #
    2023-11-24T10:53:41.234255  export SHELL=3D/bin/sh
    2023-11-24T10:53:41.234679  #
    2023-11-24T10:53:41.335945  / # export SHELL=3D/bin/sh. /lava-269261/en=
vironment
    2023-11-24T10:53:41.336357  =

    2023-11-24T10:53:41.437556  / # . /lava-269261/environment/lava-269261/=
bin/lava-test-runner /lava-269261/1
    2023-11-24T10:53:41.438150  =

    2023-11-24T10:53:41.442902  / # /lava-269261/bin/lava-test-runner /lava=
-269261/1
    2023-11-24T10:53:41.547343  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
beaglebone-black         | arm   | lab-cip       | gcc-10   | omap2plus_def=
config          | 1          =


  Details:     https://kernelci.org/test/plan/id/656082541e4109011c7e4a6f

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-be=
aglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-be=
aglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656082541e4109011c7e4aa9
        failing since 314 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-11-24T11:00:09.630000  <8>[   13.957759] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1044674_1.5.2.4.1>
    2023-11-24T11:00:09.738771  / # #
    2023-11-24T11:00:09.840147  export SHELL=3D/bin/sh
    2023-11-24T11:00:09.840576  #
    2023-11-24T11:00:09.941446  / # export SHELL=3D/bin/sh. /lava-1044674/e=
nvironment
    2023-11-24T11:00:09.941891  =

    2023-11-24T11:00:10.042838  / # . /lava-1044674/environment/lava-104467=
4/bin/lava-test-runner /lava-1044674/1
    2023-11-24T11:00:10.043635  =

    2023-11-24T11:00:10.048064  / # /lava-1044674/bin/lava-test-runner /lav=
a-1044674/1
    2023-11-24T11:00:10.149170  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
fsl-ls1028a-rdb          | arm64 | lab-nxp       | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/656081e364649dac127e4a82

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1028=
a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1028=
a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656081e364649dac127e4a89
        failing since 255 days (last pass: v5.10.155-cip21, first fail: v5.=
10.173-cip28)

    2023-11-24T10:58:23.725922  + [   20.407190] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 1260214_1.5.2.4.1>
    2023-11-24T10:58:23.726213  set +x
    2023-11-24T10:58:23.831468  =

    2023-11-24T10:58:23.932633  / # #export SHELL=3D/bin/sh
    2023-11-24T10:58:23.933052  =

    2023-11-24T10:58:24.034009  / # export SHELL=3D/bin/sh. /lava-1260214/e=
nvironment
    2023-11-24T10:58:24.034521  =

    2023-11-24T10:58:24.135528  / # . /lava-1260214/environment/lava-126021=
4/bin/lava-test-runner /lava-1260214/1
    2023-11-24T10:58:24.136311  =

    2023-11-24T10:58:24.140411  / # /lava-1260214/bin/lava-test-runner /lav=
a-1260214/1 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
imx6q-sabrelite          | arm   | lab-collabora | gcc-10   | multi_v7_defc=
onfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65608436aaf78b81937e4aa7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65608436aaf78b81937e4ab0
        failing since 314 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-11-24T11:12:25.405014  / # #

    2023-11-24T11:12:25.507166  export SHELL=3D/bin/sh

    2023-11-24T11:12:25.507877  #

    2023-11-24T11:12:25.609309  / # export SHELL=3D/bin/sh. /lava-12073837/=
environment

    2023-11-24T11:12:25.610017  =


    2023-11-24T11:12:25.711536  / # . /lava-12073837/environment/lava-12073=
837/bin/lava-test-runner /lava-12073837/1

    2023-11-24T11:12:25.712629  =


    2023-11-24T11:12:25.729086  / # /lava-12073837/bin/lava-test-runner /la=
va-12073837/1

    2023-11-24T11:12:25.818874  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-24T11:12:25.819378  + cd /lava-12073837/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
imx6ul-14x14-evk         | arm   | lab-nxp       | gcc-10   | multi_v7_defc=
onfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65608461a34edd2d127e4a84

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx=
6ul-14x14-evk.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx=
6ul-14x14-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65608461a34edd2d127e4a8b
        failing since 247 days (last pass: v5.10.145-cip17, first fail: v5.=
10.175-cip29)

    2023-11-24T11:09:00.918564  + set +x
    2023-11-24T11:09:00.921721  <8>[   29.687977] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1260218_1.5.2.4.1>
    2023-11-24T11:09:01.029880  / # #
    2023-11-24T11:09:02.185897  export SHELL=3D/bin/sh
    2023-11-24T11:09:02.191556  #
    2023-11-24T11:09:03.733698  / # export SHELL=3D/bin/sh. /lava-1260218/e=
nvironment
    2023-11-24T11:09:03.739355  =

    2023-11-24T11:09:06.551755  / # . /lava-1260218/environment/lava-126021=
8/bin/lava-test-runner /lava-1260218/1
    2023-11-24T11:09:06.557730  =

    2023-11-24T11:09:06.559451  / # /lava-1260218/bin/lava-test-runner /lav=
a-1260218/1 =

    ... (18 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
imx7d-sdb                | arm   | lab-nxp       | gcc-10   | multi_v7_defc=
onfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6560844fac442b31bd7e4a6d

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx=
7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx=
7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6560844fac442b31bd7e4a74
        failing since 314 days (last pass: v5.10.155-cip21, first fail: v5.=
10.162-cip24)

    2023-11-24T11:08:48.658558  / # #
    2023-11-24T11:08:49.814447  export SHELL=3D/bin/sh
    2023-11-24T11:08:49.820093  #
    2023-11-24T11:08:51.362285  / # export SHELL=3D/bin/sh. /lava-1260217/e=
nvironment
    2023-11-24T11:08:51.367928  =

    2023-11-24T11:08:51.368234  / # . /lava-1260217/environment
    2023-11-24T11:08:54.180643  / #/lava-1260217/bin/lava-test-runner /lava=
-1260217/1
    2023-11-24T11:08:54.197109   /lava-1260217/bin/lava-test-runner /lava-1=
260217/1
    2023-11-24T11:08:54.286557  + export 'TESTRUN_ID=3D1_bootrr'
    2023-11-24T11:08:54.286943  + cd /lava-1260217/1/tests/1_bootrr =

    ... (19 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
juno-uboot               | arm64 | lab-broonie   | gcc-10   | cip://5.10.y-=
...64_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/656087cc9fa02778a87e4a8c

  Results:     47 PASS, 13 FAIL, 1 SKIP
  Full config: cip://5.10.y-cip/arm64/qemu_arm64_defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm64/cip---5.10.y-cip-arm64-qemu_arm64_defconfig/=
gcc-10/lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm64/cip---5.10.y-cip-arm64-qemu_arm64_defconfig/=
gcc-10/lab-broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656087cc9fa02778a87e4aca
        failing since 88 days (last pass: v5.10.186-cip37-27-gd6d928db0a620=
, first fail: v5.10.191-cip38)

    2023-11-24T11:23:18.892764  <8>[   13.735829] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 269332_1.5.2.4.1>
    2023-11-24T11:23:19.002129  / # #
    2023-11-24T11:23:19.105111  export SHELL=3D/bin/sh
    2023-11-24T11:23:19.105890  #
    2023-11-24T11:23:19.207878  / # export SHELL=3D/bin/sh. /lava-269332/en=
vironment
    2023-11-24T11:23:19.208688  =

    2023-11-24T11:23:19.310674  / # . /lava-269332/environment/lava-269332/=
bin/lava-test-runner /lava-269332/1
    2023-11-24T11:23:19.312012  =

    2023-11-24T11:23:19.324951  / # /lava-269332/bin/lava-test-runner /lava=
-269332/1
    2023-11-24T11:23:19.381827  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
juno-uboot               | arm64 | lab-broonie   | gcc-10   | defconfig+kse=
lftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/656085ece42d8e65637e4a6d

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm64/defconfig+kselftest/gcc-10/lab-broonie/basel=
ine-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm64/defconfig+kselftest/gcc-10/lab-broonie/basel=
ine-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656085ece42d8e65637e4aad
        failing since 121 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-11-24T11:15:25.492515  <8>[   19.147250] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 269274_1.5.2.4.1>
    2023-11-24T11:15:25.602749  / # #
    2023-11-24T11:15:25.705792  export SHELL=3D/bin/sh
    2023-11-24T11:15:25.706631  #
    2023-11-24T11:15:25.808527  / # export SHELL=3D/bin/sh. /lava-269274/en=
vironment
    2023-11-24T11:15:25.809311  =

    2023-11-24T11:15:25.911447  / # . /lava-269274/environment/lava-269274/=
bin/lava-test-runner /lava-269274/1
    2023-11-24T11:15:25.912825  =

    2023-11-24T11:15:25.923770  / # /lava-269274/bin/lava-test-runner /lava=
-269274/1
    2023-11-24T11:15:26.101534  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a7743-iwg20d-q7        | arm   | lab-cip       | gcc-10   | shmobile_defc=
onfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/656080117d1c41b8f27e4a6d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a=
7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a=
7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/656080127d1c41b8f27e4=
a6e
        failing since 71 days (last pass: v5.10.191-cip38-2-g09e5ecd8645b, =
first fail: v5.10.191-cip38-17-g8dad6b499cfe5) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+kse=
lftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/656081754c7543586a7e4a83

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-=
r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-=
r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656081754c7543586a7e4a8c
        failing since 107 days (last pass: v5.10.182-cip35, first fail: v5.=
10.186-cip37-13-g260094841fe1a)

    2023-11-24T10:56:33.226292  + set +x
    2023-11-24T10:56:33.229423  <8>[   87.691722] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1044679_1.5.2.4.1>
    2023-11-24T10:56:33.340864  / # #
    2023-11-24T10:56:34.796081  export SHELL=3D/bin/sh
    2023-11-24T10:56:34.816655  #
    2023-11-24T10:56:34.816849  / # export SHELL=3D/bin/sh
    2023-11-24T10:56:36.763068  / # . /lava-1044679/environment
    2023-11-24T10:56:40.344184  /lava-1044679/bin/lava-test-runner /lava-10=
44679/1
    2023-11-24T10:56:40.364803  . /lava-1044679/environment
    2023-11-24T10:56:40.364960  / # /lava-1044679/bin/lava-test-runner /lav=
a-1044679/1 =

    ... (28 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a774c0-ek874           | arm64 | lab-cip       | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/6560831d1ca3fef84e7e4ac3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-e=
k874.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-e=
k874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6560831d1ca3fef84e7e4acc
        failing since 121 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-11-24T11:03:37.338978  / # #
    2023-11-24T11:03:38.799203  export SHELL=3D/bin/sh
    2023-11-24T11:03:38.820242  #
    2023-11-24T11:03:38.820760  / # export SHELL=3D/bin/sh
    2023-11-24T11:03:40.772315  / # . /lava-1044695/environment
    2023-11-24T11:03:44.362106  /lava-1044695/bin/lava-test-runner /lava-10=
44695/1
    2023-11-24T11:03:44.383674  . /lava-1044695/environment
    2023-11-24T11:03:44.384087  / # /lava-1044695/bin/lava-test-runner /lav=
a-1044695/1
    2023-11-24T11:03:44.461791  + export 'TESTRUN_ID=3D1_bootrr'
    2023-11-24T11:03:44.462328  + cd /lava-1044695/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a77960-ulcb            | arm64 | lab-collabora | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/656081583025fc154d7e4a7b

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a7=
7960-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a7=
7960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656081583025fc154d7e4a84
        failing since 121 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-11-24T11:02:45.979585  / # #

    2023-11-24T11:02:46.081721  export SHELL=3D/bin/sh

    2023-11-24T11:02:46.082417  #

    2023-11-24T11:02:46.183789  / # export SHELL=3D/bin/sh. /lava-12073821/=
environment

    2023-11-24T11:02:46.184499  =


    2023-11-24T11:02:46.285990  / # . /lava-12073821/environment/lava-12073=
821/bin/lava-test-runner /lava-12073821/1

    2023-11-24T11:02:46.287147  =


    2023-11-24T11:02:46.303733  / # /lava-12073821/bin/lava-test-runner /la=
va-12073821/1

    2023-11-24T11:02:46.352896  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-24T11:02:46.353442  + cd /lav<8>[   16.468587] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12073821_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
rk3288-veyron-jaq        | arm   | lab-collabora | gcc-10   | multi_v7_defc=
onfig           | 4          =


  Details:     https://kernelci.org/test/plan/id/656084166a6e6babb27e4a91

  Results:     63 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656084166a6e6babb27e4a99
        failing since 312 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-11-24T11:14:12.255453  <8>[    6.595381] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-11-24T11:14:12.264771  + <8>[    6.607708] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 12073841_1.5.2.3.1>

    2023-11-24T11:14:12.265127  set +x

    2023-11-24T11:14:12.370492  #

    2023-11-24T11:14:12.471424  / # #export SHELL=3D/bin/sh

    2023-11-24T11:14:12.471929  =


    2023-11-24T11:14:12.472198  / # export SHELL=3D/bin/sh<6>[    6.786639]=
 sbs-battery 20-000b: Disabling PEC because of broken Cros-EC implementation

    2023-11-24T11:14:12.573188  . /lava-12073841/environment

    2023-11-24T11:14:12.573370  =


    2023-11-24T11:14:12.573453  / # <4>[    6.825954] sbs-battery 20-000b: =
Unknown chemistry: POLY
 =

    ... (26 line(s) more)  =


  * baseline.bootrr.dwhdmi-rockchip-driver-i2c-present: https://kernelci.or=
g/test/case/id/656084166a6e6babb27e4ac6
        failing since 312 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-11-24T11:14:24.359558  FIRST,<8>[   18.694866] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>

    2023-11-24T11:14:24.361331   INC default to 1.

    2023-11-24T11:14:24.361387  =


    2023-11-24T11:14:24.364733  	-w	Pad to last with leading zeros

    2023-11-24T11:14:24.367292  	-s SEP	String separator

    2023-11-24T11:14:24.371318  /lava-12073841/1/../bin/lava-test-case

    2023-11-24T11:14:24.377128  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.

    2023-11-24T11:14:24.377588  =

   =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/656084166a6e6babb27e4ac7
        failing since 312 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-11-24T11:14:24.336866  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC)<8=
>[   18.676054] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-11-24T11:14:24.339076   multi-call binary.

    2023-11-24T11:14:24.339572  =


    2023-11-24T11:14:24.343713  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-11-24T11:14:24.343767  =


    2023-11-24T11:14:24.348575  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/656084166a6e6babb27e4ac8
        failing since 312 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/656081b764649dac127e4a6e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm64/defconfig/gcc-10/lab-collabora/baseline-rk33=
99-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm64/defconfig/gcc-10/lab-collabora/baseline-rk33=
99-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656081b764649dac127e4a77
        failing since 65 days (last pass: v5.10.191-cip38-29-g9e1aa2001db8,=
 first fail: v5.10.194-cip39)

    2023-11-24T10:57:35.543505  / # #

    2023-11-24T10:57:36.802926  export SHELL=3D/bin/sh

    2023-11-24T10:57:36.813359  #

    2023-11-24T10:57:36.813431  / # export SHELL=3D/bin/sh

    2023-11-24T10:57:38.554804  / # . /lava-12073820/environment

    2023-11-24T10:57:41.750797  /lava-12073820/bin/lava-test-runner /lava-1=
2073820/1

    2023-11-24T10:57:41.761186  . /lava-12073820/environment

    2023-11-24T10:57:41.762984  / # /lava-12073820/bin/lava-test-runner /la=
va-12073820/1

    2023-11-24T10:57:41.816900  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-24T10:57:41.816974  + cd /lava-12073820/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
sun50i-h6-pine-h64       | arm64 | lab-collabora | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/6560816cb32b16b9a57e4a73

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm64/defconfig/gcc-10/lab-collabora/baseline-sun5=
0i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm64/defconfig/gcc-10/lab-collabora/baseline-sun5=
0i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6560816cb32b16b9a57e4a7c
        failing since 121 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-11-24T11:03:03.307704  / # #

    2023-11-24T11:03:03.409831  export SHELL=3D/bin/sh

    2023-11-24T11:03:03.410524  #

    2023-11-24T11:03:03.511920  / # export SHELL=3D/bin/sh. /lava-12073813/=
environment

    2023-11-24T11:03:03.512612  =


    2023-11-24T11:03:03.613986  / # . /lava-12073813/environment/lava-12073=
813/bin/lava-test-runner /lava-12073813/1

    2023-11-24T11:03:03.615002  =


    2023-11-24T11:03:03.632104  / # /lava-12073813/bin/lava-test-runner /la=
va-12073813/1

    2023-11-24T11:03:03.673746  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-24T11:03:03.689943  + cd /lava-1207381<8>[   18.229607] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12073813_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

