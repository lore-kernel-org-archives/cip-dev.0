Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF2F3C10DC3
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 20:43:10 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web11.103013.1701981785503492749
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 07 Dec 2023 12:43:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=qaZ4TNOk;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d0c4d84bf6so10438965ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 07 Dec 2023 12:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701981784; x=1702586584; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2kt2wqFQPrZcHwhN0XX7zbfM7u55iycNcTs8u81MYvs=;
        b=qaZ4TNOkVfSqPPxHT1hr8LSm4Yql3d1lLTZVjOii34Ws58alRZPnQ0kwHxeVwkeJnb
         krITLO1RX9kEbo9a98TFIDI54h4LGF1CsCA4S0NKAldqDaF18Mv5p5/6ABjkdBhI4j1W
         QVqsWcMwA+HBZOVMwaKEBn0WAOjZi8FFS+mx2O0msKyr4AksMXZv2x5sF9P9wDY2sIZr
         zfsY0z3jbMXtqEva10p49GblQz9t6ZRrey3owh5u3QOsoq0emjjvAg1Mb9S/3WUh3vS7
         mjZZsj9u9h2Ak9Y6Wh3kHxFQDqorIOPYI2mqh9COuSBHdc7/aya+R3DhfhP5dmzfe1js
         XQhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701981784; x=1702586584;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2kt2wqFQPrZcHwhN0XX7zbfM7u55iycNcTs8u81MYvs=;
        b=jHQ44aLmdhBpM0f/SKEu5WqqJ0LhFfl8QkgcNuIobMy+pTOg+q/L+MPPoJfovy+T5D
         tOZh8alLpANGVcjvGoAt97LXpwVRO+KQF1WdzXANtsNoDY+aJLRHs5k7OhYdLKNZl4NP
         7YPMbiJe6r4ydgBUaz4OW3TaGgdz0PQlhcjyHi2DpZGs2hM010t5P+lWYFR3VpLSlLSh
         CCRUGv7toykhh0yXyVL9OcXkPqPwAcHJdQSEFg0TXTgPxExbSxVRF997Oa2GZ5pP1EFJ
         nbEkzvWpqDWzgN+p5BSiBYbQsAKq1W14L8yFeUOoxargKAnyvUyoOyQwioOsP2Diqilm
         OC4A==
X-Gm-Message-State: AOJu0YxAYn5st3R9QwxKBVM3UPBD9JRs8hxAjEA1dMTqS9LiJSpUwYZl
	ojT/2VLeEHTT/IvY00NRij7GNoEAUhdtqhmD0LT2BQ==
X-Google-Smtp-Source: AGHT+IFvbJdWRzcgF5kBVN7Jv4ojQnxIy/3H0dgPmjMokoceBUj67+2VdnJq2A6Ia5ppAkEaN7YvgQ==
X-Received: by 2002:a17:902:bb81:b0:1d0:6ffd:f200 with SMTP id m1-20020a170902bb8100b001d06ffdf200mr2667817pls.86.1701981784074;
        Thu, 07 Dec 2023 12:43:04 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id e8-20020a17090301c800b001c7443d0890sm234185plh.102.2023.12.07.12.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 12:43:02 -0800 (PST)
Message-ID: <65722e56.170a0220.ac5a.177b@mx.google.com>
Date: Thu, 07 Dec 2023 12:43:02 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-28-ga386bc478aa6b
Subject: cip/linux-5.10.y-cip baseline: 119 runs,
 21 regressions (v5.10.201-cip41-28-ga386bc478aa6b)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 20:43:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13908

cip/linux-5.10.y-cip baseline: 119 runs, 21 regressions (v5.10.201-cip41-28=
-ga386bc478aa6b)

Regressions Summary
-------------------

platform               | arch  | lab             | compiler | defconfig    =
                | regressions
-----------------------+-------+-----------------+----------+--------------=
----------------+------------
at91sam9g20ek          | arm   | lab-broonie     | gcc-10   | multi_v5_defc=
onfig           | 1          =

bcm2836-rpi-2-b        | arm   | lab-collabora   | gcc-10   | bcm2835_defco=
nfig            | 1          =

beaglebone-black       | arm   | lab-broonie     | gcc-10   | multi_v7_defc=
onfig           | 1          =

beaglebone-black       | arm   | lab-broonie     | gcc-10   | omap2plus_def=
config          | 1          =

beaglebone-black       | arm   | lab-cip         | gcc-10   | omap2plus_def=
config          | 1          =

imx6q-sabrelite        | arm   | lab-collabora   | gcc-10   | multi_v7_defc=
onfig           | 1          =

imx6qp-wandboard-revd1 | arm   | lab-pengutronix | gcc-10   | imx_v6_v7_def=
config          | 1          =

imx6qp-wandboard-revd1 | arm   | lab-pengutronix | gcc-10   | multi_v7_defc=
onfig           | 1          =

juno-uboot             | arm64 | lab-broonie     | gcc-10   | cip://5.10.y-=
...64_defconfig | 1          =

juno-uboot             | arm64 | lab-broonie     | gcc-10   | defconfig+kse=
lftest          | 1          =

juno-uboot             | arm64 | lab-broonie     | gcc-10   | defconfig    =
                | 1          =

r8a7743-iwg20d-q7      | arm   | lab-cip         | gcc-10   | shmobile_defc=
onfig           | 1          =

r8a774c0-ek874         | arm64 | lab-cip         | gcc-10   | defconfig    =
                | 1          =

r8a77960-ulcb          | arm64 | lab-collabora   | gcc-10   | defconfig    =
                | 1          =

rk3288-veyron-jaq      | arm   | lab-collabora   | gcc-10   | multi_v7_defc=
onfig           | 4          =

rk3399-rock-pi-4b      | arm64 | lab-collabora   | gcc-10   | defconfig    =
                | 1          =

sun50i-a64-pine64-plus | arm64 | lab-broonie     | gcc-10   | defconfig    =
                | 1          =

sun50i-h6-pine-h64     | arm64 | lab-collabora   | gcc-10   | defconfig    =
                | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-28-ga386bc478aa6b/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-28-ga386bc478aa6b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a386bc478aa6b422e6dd5d92a540987ddfca9397 =



Test Regressions
---------------- =



platform               | arch  | lab             | compiler | defconfig    =
                | regressions
-----------------------+-------+-----------------+----------+--------------=
----------------+------------
at91sam9g20ek          | arm   | lab-broonie     | gcc-10   | multi_v5_defc=
onfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/657223f3b4e5e42006e13490

  Results:     47 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline=
-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline=
-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657223f3b4e5e42006e134c7
        failing since 327 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-07T19:58:08.663426  + set +x
    2023-12-07T19:58:08.663737  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 319655_1.5.2=
.4.1>
    2023-12-07T19:58:08.775448  / # #
    2023-12-07T19:58:08.877232  export SHELL=3D/bin/sh
    2023-12-07T19:58:08.877648  #
    2023-12-07T19:58:08.978877  / # export SHELL=3D/bin/sh. /lava-319655/en=
vironment
    2023-12-07T19:58:08.979490  =

    2023-12-07T19:58:09.080943  / # . /lava-319655/environment/lava-319655/=
bin/lava-test-runner /lava-319655/1
    2023-12-07T19:58:09.082052  =

    2023-12-07T19:58:09.085452  / # /lava-319655/bin/lava-test-runner /lava=
-319655/1 =

    ... (12 line(s) more)  =

 =



platform               | arch  | lab             | compiler | defconfig    =
                | regressions
-----------------------+-------+-----------------+----------+--------------=
----------------+------------
bcm2836-rpi-2-b        | arm   | lab-collabora   | gcc-10   | bcm2835_defco=
nfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/657223c682135f8832e1347b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm/bcm2835_defconfig/gcc-10/lab-collabora/baselin=
e-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm/bcm2835_defconfig/gcc-10/lab-collabora/baselin=
e-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657223c682135f8832e13484
        failing since 135 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-12-07T20:05:13.610150  / # #

    2023-12-07T20:05:13.710875  export SHELL=3D/bin/sh

    2023-12-07T20:05:13.711200  #

    2023-12-07T20:05:13.811874  / # export SHELL=3D/bin/sh. /lava-12210209/=
environment

    2023-12-07T20:05:13.812085  =


    2023-12-07T20:05:13.912707  / # . /lava-12210209/environment/lava-12210=
209/bin/lava-test-runner /lava-12210209/1

    2023-12-07T20:05:13.913745  =


    2023-12-07T20:05:13.923868  / # /lava-12210209/bin/lava-test-runner /la=
va-12210209/1

    2023-12-07T20:05:14.034819  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-07T20:05:14.035294  + cd /lava-12210209/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform               | arch  | lab             | compiler | defconfig    =
                | regressions
-----------------------+-------+-----------------+----------+--------------=
----------------+------------
beaglebone-black       | arm   | lab-broonie     | gcc-10   | multi_v7_defc=
onfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/657226432293d5bd87e134cb

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline=
-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline=
-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657226432293d5bd87e134f8
        failing since 327 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-07T20:07:57.075753  <8>[   22.151342] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 319727_1.5.2.4.1>
    2023-12-07T20:07:57.182402  / # #
    2023-12-07T20:07:57.284552  export SHELL=3D/bin/sh
    2023-12-07T20:07:57.285120  #
    2023-12-07T20:07:57.386574  / # export SHELL=3D/bin/sh. /lava-319727/en=
vironment
    2023-12-07T20:07:57.387022  =

    2023-12-07T20:07:57.488337  / # . /lava-319727/environment/lava-319727/=
bin/lava-test-runner /lava-319727/1
    2023-12-07T20:07:57.488998  =

    2023-12-07T20:07:57.493369  / # /lava-319727/bin/lava-test-runner /lava=
-319727/1
    2023-12-07T20:07:57.587722  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform               | arch  | lab             | compiler | defconfig    =
                | regressions
-----------------------+-------+-----------------+----------+--------------=
----------------+------------
beaglebone-black       | arm   | lab-broonie     | gcc-10   | omap2plus_def=
config          | 1          =


  Details:     https://kernelci.org/test/plan/id/657224ce0f3f0356fce134c7

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm/omap2plus_defconfig/gcc-10/lab-broonie/baselin=
e-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm/omap2plus_defconfig/gcc-10/lab-broonie/baselin=
e-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657224ce0f3f0356fce13501
        failing since 327 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-07T20:02:06.538718  <8>[   19.049681] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 319669_1.5.2.4.1>
    2023-12-07T20:02:06.650862  / # #
    2023-12-07T20:02:06.754262  export SHELL=3D/bin/sh
    2023-12-07T20:02:06.755203  #
    2023-12-07T20:02:06.857277  / # export SHELL=3D/bin/sh. /lava-319669/en=
vironment
    2023-12-07T20:02:06.858226  =

    2023-12-07T20:02:06.960396  / # . /lava-319669/environment/lava-319669/=
bin/lava-test-runner /lava-319669/1
    2023-12-07T20:02:06.961961  =

    2023-12-07T20:02:06.966484  / # /lava-319669/bin/lava-test-runner /lava=
-319669/1
    2023-12-07T20:02:07.073832  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform               | arch  | lab             | compiler | defconfig    =
                | regressions
-----------------------+-------+-----------------+----------+--------------=
----------------+------------
beaglebone-black       | arm   | lab-cip         | gcc-10   | omap2plus_def=
config          | 1          =


  Details:     https://kernelci.org/test/plan/id/657226bf3b289b7f97e134ac

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-be=
aglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-be=
aglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657226bf3b289b7f97e134df
        failing since 327 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-07T20:10:14.049349  <8>[   14.111582] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1053530_1.5.2.4.1>
    2023-12-07T20:10:14.158364  / # #
    2023-12-07T20:10:14.260288  export SHELL=3D/bin/sh
    2023-12-07T20:10:14.260991  #
    2023-12-07T20:10:14.362264  / # export SHELL=3D/bin/sh. /lava-1053530/e=
nvironment
    2023-12-07T20:10:14.362919  =

    2023-12-07T20:10:14.464273  / # . /lava-1053530/environment/lava-105353=
0/bin/lava-test-runner /lava-1053530/1
    2023-12-07T20:10:14.465301  =

    2023-12-07T20:10:14.471258  / # /lava-1053530/bin/lava-test-runner /lav=
a-1053530/1
    2023-12-07T20:10:14.567358  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform               | arch  | lab             | compiler | defconfig    =
                | regressions
-----------------------+-------+-----------------+----------+--------------=
----------------+------------
imx6q-sabrelite        | arm   | lab-collabora   | gcc-10   | multi_v7_defc=
onfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6572260dd67a8e37f8e134e8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6572260dd67a8e37f8e134f1
        failing since 327 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-07T20:12:01.807172  / # #

    2023-12-07T20:12:01.909370  export SHELL=3D/bin/sh

    2023-12-07T20:12:01.910073  #

    2023-12-07T20:12:02.011480  / # export SHELL=3D/bin/sh. /lava-12210300/=
environment

    2023-12-07T20:12:02.012149  =


    2023-12-07T20:12:02.113565  / # . /lava-12210300/environment/lava-12210=
300/bin/lava-test-runner /lava-12210300/1

    2023-12-07T20:12:02.114657  =


    2023-12-07T20:12:02.131126  / # /lava-12210300/bin/lava-test-runner /la=
va-12210300/1

    2023-12-07T20:12:02.179027  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-07T20:12:02.220956  + cd /lava-12210300/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform               | arch  | lab             | compiler | defconfig    =
                | regressions
-----------------------+-------+-----------------+----------+--------------=
----------------+------------
imx6qp-wandboard-revd1 | arm   | lab-pengutronix | gcc-10   | imx_v6_v7_def=
config          | 1          =


  Details:     https://kernelci.org/test/plan/id/65722692dc4789bd1de1348c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/bas=
eline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/bas=
eline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65722692dc4789bd1de13495
        failing since 327 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-07T20:09:47.206622  + set +x
    2023-12-07T20:09:47.206799  [   10.329052] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1015379_1.5.2.3.1>
    2023-12-07T20:09:47.314063  / # #
    2023-12-07T20:09:47.415180  export SHELL=3D/bin/sh
    2023-12-07T20:09:47.415655  #
    2023-12-07T20:09:47.516361  / # export SHELL=3D/bin/sh. /lava-1015379/e=
nvironment
    2023-12-07T20:09:47.516716  =

    2023-12-07T20:09:47.617442  / # . /lava-1015379/environment/lava-101537=
9/bin/lava-test-runner /lava-1015379/1
    2023-12-07T20:09:47.617992  =

    2023-12-07T20:09:47.620990  / # /lava-1015379/bin/lava-test-runner /lav=
a-1015379/1 =

    ... (12 line(s) more)  =

 =



platform               | arch  | lab             | compiler | defconfig    =
                | regressions
-----------------------+-------+-----------------+----------+--------------=
----------------+------------
imx6qp-wandboard-revd1 | arm   | lab-pengutronix | gcc-10   | multi_v7_defc=
onfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65722606d67a8e37f8e1348f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/base=
line-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/base=
line-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65722606d67a8e37f8e13498
        failing since 327 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-07T20:07:09.399402  + set[    7.286070] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 1015374_1.5.2.3.1>
    2023-12-07T20:07:09.399671   +x
    2023-12-07T20:07:09.504859  / # #
    2023-12-07T20:07:09.606988  export SHELL=3D/bin/sh
    2023-12-07T20:07:09.607696  #
    2023-12-07T20:07:09.708640  / # export SHELL=3D/bin/sh. /lava-1015374/e=
nvironment
    2023-12-07T20:07:09.709109  =

    2023-12-07T20:07:09.810027  / # . /lava-1015374/environment/lava-101537=
4/bin/lava-test-runner /lava-1015374/1
    2023-12-07T20:07:09.810823  =

    2023-12-07T20:07:09.813775  / # /lava-1015374/bin/lava-test-runner /lav=
a-1015374/1 =

    ... (12 line(s) more)  =

 =



platform               | arch  | lab             | compiler | defconfig    =
                | regressions
-----------------------+-------+-----------------+----------+--------------=
----------------+------------
juno-uboot             | arm64 | lab-broonie     | gcc-10   | cip://5.10.y-=
...64_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/657223b79aa58d7d34e13494

  Results:     47 PASS, 13 FAIL, 1 SKIP
  Full config: cip://5.10.y-cip/arm64/qemu_arm64_defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm64/cip---5.10.y-cip-arm64-qemu_arm64_defconfig/=
gcc-10/lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm64/cip---5.10.y-cip-arm64-qemu_arm64_defconfig/=
gcc-10/lab-broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657223b79aa58d7d34e134d3
        failing since 101 days (last pass: v5.10.186-cip37-27-gd6d928db0a62=
0, first fail: v5.10.191-cip38)

    2023-12-07T19:57:09.913981  / # #
    2023-12-07T19:57:10.016858  export SHELL=3D/bin/sh
    2023-12-07T19:57:10.017624  #
    2023-12-07T19:57:10.119647  / # export SHELL=3D/bin/sh. /lava-319651/en=
vironment
    2023-12-07T19:57:10.120400  =

    2023-12-07T19:57:10.222422  / # . /lava-319651/environment/lava-319651/=
bin/lava-test-runner /lava-319651/1
    2023-12-07T19:57:10.223712  =

    2023-12-07T19:57:10.238165  / # /lava-319651/bin/lava-test-runner /lava=
-319651/1
    2023-12-07T19:57:10.294032  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-07T19:57:10.294578  + cd /lava-319651/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform               | arch  | lab             | compiler | defconfig    =
                | regressions
-----------------------+-------+-----------------+----------+--------------=
----------------+------------
juno-uboot             | arm64 | lab-broonie     | gcc-10   | defconfig+kse=
lftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/657225e89de7e7ac57e134e2

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm64/defconfig+kselftest/gcc-10/lab-broonie/basel=
ine-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm64/defconfig+kselftest/gcc-10/lab-broonie/basel=
ine-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657225e89de7e7ac57e13521
        failing since 134 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-12-07T20:06:29.636833  <8>[   18.498641] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 319685_1.5.2.4.1>
    2023-12-07T20:06:29.745936  / # #
    2023-12-07T20:06:29.848948  export SHELL=3D/bin/sh
    2023-12-07T20:06:29.849719  #
    2023-12-07T20:06:29.951718  / # export SHELL=3D/bin/sh. /lava-319685/en=
vironment
    2023-12-07T20:06:29.952507  =

    2023-12-07T20:06:30.055013  / # . /lava-319685/environment/lava-319685/=
bin/lava-test-runner /lava-319685/1
    2023-12-07T20:06:30.056282  =

    2023-12-07T20:06:30.068202  / # /lava-319685/bin/lava-test-runner /lava=
-319685/1
    2023-12-07T20:06:30.246973  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform               | arch  | lab             | compiler | defconfig    =
                | regressions
-----------------------+-------+-----------------+----------+--------------=
----------------+------------
juno-uboot             | arm64 | lab-broonie     | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/65722840d4248448a5e134ae

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-u=
boot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-u=
boot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65722840d4248448a5e134ed
        failing since 0 day (last pass: v5.10.201-cip41-11-ga539098fe70dd, =
first fail: v5.10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T20:16:32.338305  / # #
    2023-12-07T20:16:32.441313  export SHELL=3D/bin/sh
    2023-12-07T20:16:32.442110  #
    2023-12-07T20:16:32.544043  / # export SHELL=3D/bin/sh. /lava-319772/en=
vironment
    2023-12-07T20:16:32.544826  =

    2023-12-07T20:16:32.646859  / # . /lava-319772/environment/lava-319772/=
bin/lava-test-runner /lava-319772/1
    2023-12-07T20:16:32.648243  =

    2023-12-07T20:16:32.661044  / # /lava-319772/bin/lava-test-runner /lava=
-319772/1
    2023-12-07T20:16:32.721893  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-07T20:16:32.722447  + cd /lava-319772/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform               | arch  | lab             | compiler | defconfig    =
                | regressions
-----------------------+-------+-----------------+----------+--------------=
----------------+------------
r8a7743-iwg20d-q7      | arm   | lab-cip         | gcc-10   | shmobile_defc=
onfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/657223b39aa58d7d34e1347b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a=
7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a=
7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/657223b39aa58d7d34e13=
47c
        new failure (last pass: v5.10.201-cip41-16-g3c85fba3b6e5d) =

 =



platform               | arch  | lab             | compiler | defconfig    =
                | regressions
-----------------------+-------+-----------------+----------+--------------=
----------------+------------
r8a774c0-ek874         | arm64 | lab-cip         | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/657226f18f8cae7943e134e9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-e=
k874.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-e=
k874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657226f18f8cae7943e134f2
        failing since 135 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-12-07T20:11:15.798566  / # #
    2023-12-07T20:11:17.257273  export SHELL=3D/bin/sh
    2023-12-07T20:11:17.278206  #
    2023-12-07T20:11:17.278620  / # export SHELL=3D/bin/sh
    2023-12-07T20:11:19.227459  / # . /lava-1053571/environment
    2023-12-07T20:11:22.813338  /lava-1053571/bin/lava-test-runner /lava-10=
53571/1
    2023-12-07T20:11:22.834770  . /lava-1053571/environment
    2023-12-07T20:11:22.835229  / # /lava-1053571/bin/lava-test-runner /lav=
a-1053571/1
    2023-12-07T20:11:22.912845  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-07T20:11:22.913873  + cd /lava-1053571/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform               | arch  | lab             | compiler | defconfig    =
                | regressions
-----------------------+-------+-----------------+----------+--------------=
----------------+------------
r8a77960-ulcb          | arm64 | lab-collabora   | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/65722682c028b20301e13489

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a7=
7960-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a7=
7960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65722682c028b20301e13492
        failing since 135 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-12-07T20:16:59.570004  / # #

    2023-12-07T20:16:59.671909  export SHELL=3D/bin/sh

    2023-12-07T20:16:59.672595  #

    2023-12-07T20:16:59.773830  / # export SHELL=3D/bin/sh. /lava-12210317/=
environment

    2023-12-07T20:16:59.774449  =


    2023-12-07T20:16:59.875757  / # . /lava-12210317/environment/lava-12210=
317/bin/lava-test-runner /lava-12210317/1

    2023-12-07T20:16:59.876813  =


    2023-12-07T20:16:59.878155  / # /lava-12210317/bin/lava-test-runner /la=
va-12210317/1

    2023-12-07T20:16:59.942427  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-07T20:16:59.942922  + cd /lav<8>[   16.467700] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12210317_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform               | arch  | lab             | compiler | defconfig    =
                | regressions
-----------------------+-------+-----------------+----------+--------------=
----------------+------------
rk3288-veyron-jaq      | arm   | lab-collabora   | gcc-10   | multi_v7_defc=
onfig           | 4          =


  Details:     https://kernelci.org/test/plan/id/6572260ad67a8e37f8e1349d

  Results:     63 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-i2c-present: https://kernelci.or=
g/test/case/id/6572260ad67a8e37f8e134d0
        failing since 325 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-07T20:14:47.511296  FIRST,<8>[   18.866928] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>

    2023-12-07T20:14:47.513008   INC default to 1.

    2023-12-07T20:14:47.513062  =


    2023-12-07T20:14:47.516289  	-w	Pad to last with leading zeros

    2023-12-07T20:14:47.518845  	-s SEP	String separator

    2023-12-07T20:14:47.522737  /lava-12210294/1/../bin/lava-test-case

    2023-12-07T20:14:47.528949  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.

    2023-12-07T20:14:47.529006  =


    2023-12-07T20:14:47.539202  Usag<8>[   18.895942] <LAVA_SIGNAL_TESTCASE=
 TEST_CASE_ID=3Ddwhdmi-rockchip-driver-i2c-present RESULT=3Dfail>
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/6572260ad67a8e37f8e134d1
        failing since 325 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-07T20:14:47.488451  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC)<8=
>[   18.847817] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-12-07T20:14:47.490499   multi-call binary.

    2023-12-07T20:14:47.490716  =


    2023-12-07T20:14:47.495098  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-12-07T20:14:47.495316  =


    2023-12-07T20:14:47.500241  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/6572260ad67a8e37f8e134d2
        failing since 325 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-07T20:14:47.469350  /lava-12210294/1/../bin/lava-test-case<8>[ =
  18.830111] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-probed RE=
SULT=3Dpass>

    2023-12-07T20:14:47.469400  =

   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6572260ad67a8e37f8e134e6
        failing since 325 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-07T20:14:35.410223  <8>[    6.770621] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-12-07T20:14:35.419944  + <8>[    6.783065] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 12210294_1.5.2.3.1>

    2023-12-07T20:14:35.420375  set +x

    2023-12-07T20:14:35.525818  #

    2023-12-07T20:14:35.628036  / # #export SHELL=3D/bin/sh

    2023-12-07T20:14:35.628794  =


    2023-12-07T20:14:35.730199  / # export SHELL=3D/bin/sh. /lava-12210294/=
environment

    2023-12-07T20:14:35.730916  =


    2023-12-07T20:14:35.832367  / # . /lava-12210294/environment/lava-12210=
294/bin/lava-test-runner /lava-12210294/1

    2023-12-07T20:14:35.833438  =

 =

    ... (19 line(s) more)  =

 =



platform               | arch  | lab             | compiler | defconfig    =
                | regressions
-----------------------+-------+-----------------+----------+--------------=
----------------+------------
rk3399-rock-pi-4b      | arm64 | lab-collabora   | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/657226a93b289b7f97e13476

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm64/defconfig/gcc-10/lab-collabora/baseline-rk33=
99-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm64/defconfig/gcc-10/lab-collabora/baseline-rk33=
99-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657226a93b289b7f97e1347f
        failing since 79 days (last pass: v5.10.191-cip38-29-g9e1aa2001db8,=
 first fail: v5.10.194-cip39)

    2023-12-07T20:10:15.204240  / # #

    2023-12-07T20:10:16.464621  export SHELL=3D/bin/sh

    2023-12-07T20:10:16.475523  #

    2023-12-07T20:10:16.475987  / # export SHELL=3D/bin/sh

    2023-12-07T20:10:18.218817  / # . /lava-12210316/environment

    2023-12-07T20:10:21.422900  /lava-12210316/bin/lava-test-runner /lava-1=
2210316/1

    2023-12-07T20:10:21.434246  . /lava-12210316/environment

    2023-12-07T20:10:21.438486  / # /lava-12210316/bin/lava-test-runner /la=
va-12210316/1

    2023-12-07T20:10:21.489478  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-07T20:10:21.489925  + cd /lava-12210316/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform               | arch  | lab             | compiler | defconfig    =
                | regressions
-----------------------+-------+-----------------+----------+--------------=
----------------+------------
sun50i-a64-pine64-plus | arm64 | lab-broonie     | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/657227602b6a545c98e13481

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i=
-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i=
-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657227602b6a545c98e134b1
        failing since 327 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-07T20:13:01.236998  + set +x
    2023-12-07T20:13:01.241064  <8>[   17.077882] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 319745_1.5.2.4.1>
    2023-12-07T20:13:01.350873  / # #
    2023-12-07T20:13:01.452830  export SHELL=3D/bin/sh
    2023-12-07T20:13:01.453405  #
    2023-12-07T20:13:01.554723  / # export SHELL=3D/bin/sh. /lava-319745/en=
vironment
    2023-12-07T20:13:01.555230  =

    2023-12-07T20:13:01.656731  / # . /lava-319745/environment/lava-319745/=
bin/lava-test-runner /lava-319745/1
    2023-12-07T20:13:01.657325  =

    2023-12-07T20:13:01.661414  / # /lava-319745/bin/lava-test-runner /lava=
-319745/1 =

    ... (12 line(s) more)  =

 =



platform               | arch  | lab             | compiler | defconfig    =
                | regressions
-----------------------+-------+-----------------+----------+--------------=
----------------+------------
sun50i-h6-pine-h64     | arm64 | lab-collabora   | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/65722698dc4789bd1de134b6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm64/defconfig/gcc-10/lab-collabora/baseline-sun5=
0i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm64/defconfig/gcc-10/lab-collabora/baseline-sun5=
0i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65722698dc4789bd1de134bf
        failing since 135 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-12-07T20:17:11.668507  / # #

    2023-12-07T20:17:11.770362  export SHELL=3D/bin/sh

    2023-12-07T20:17:11.770972  #

    2023-12-07T20:17:11.872206  / # export SHELL=3D/bin/sh. /lava-12210319/=
environment

    2023-12-07T20:17:11.872862  =


    2023-12-07T20:17:11.974092  / # . /lava-12210319/environment/lava-12210=
319/bin/lava-test-runner /lava-12210319/1

    2023-12-07T20:17:11.975204  =


    2023-12-07T20:17:11.977290  / # /lava-12210319/bin/lava-test-runner /la=
va-12210319/1

    2023-12-07T20:17:12.020724  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-07T20:17:12.051180  + cd /lava-1221031<8>[   18.271895] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12210319_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

