Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF76C48297
	for <webhook@archiver.kernel.org>; Wed,  7 Feb 2024 01:09:37 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web11.10193.1707268172687137351
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 06 Feb 2024 17:09:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=Q29O9swz;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.177, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d953fa3286so1133105ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 06 Feb 2024 17:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707268171; x=1707872971; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5tnCmbVNEd6v8/GIX0Pn5urQFfteMvKdcCFvk2vkd6s=;
        b=Q29O9swzPgGNZyyLHBN2EFwKnaHaVH/dq3/zm3OVGyjFIA5MmjVZK+mpPoemkXbmA+
         XHRxeHLP9SmKp2DMgmNeKw2oX3nTvdj1Wz9/9Fw6CnBiZRSpB2kowMFozhOymjm87CK+
         IvRsKdFlBDYs5S+3wNozdq9mu9WkyaIhC0Y+aZuyNq7uRmxmLUgTY2niP38GZypFomGd
         NzjouhFLF9RyHOO3slkztSILbcjAgaoWJQlmhPi0NEwZilPzhLjMqUfjNPepB+8q4uk2
         kPzKHToPQgpK81vu9Fk4aP+2jr/xcZ7voTmAbOEyXz6NcCmY2XNt+ttaysJK21C1adIx
         uiUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707268171; x=1707872971;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5tnCmbVNEd6v8/GIX0Pn5urQFfteMvKdcCFvk2vkd6s=;
        b=lsDTmqz1aUavhlIRfEL/il84/99HjTAYPW1iRmDH1C3OK8nMIezQ/tdEmqaYZ/+VVI
         Ssre4Y/AcMgdnx0zVEBYigpZDw9bF61D0+sBq2Ipu8Hg6tYBwuhs/U0MsjZmsGmAQNOE
         NE2ZAB8YHVnORv3HveyUN8bJ6yx3sQhsLBCVAZkNnrEqvYCtmgctpA/Vdnfl4Huokbpx
         A68iVIE1Sn5xjQhR5umfM146DTfi0+K8ScTVhYRKZAkqTJpQy2DSqSgm4D4rrLjrIAZa
         DUPQN7UnS4gKMiDicqtV3qltyDXcXhx459Neaaygx94DObanzBSkkE0eNKYxXlDCpsxs
         p+8g==
X-Gm-Message-State: AOJu0YxLmE9BgRnPSRT02/RXZPfOymiH7vh07wuvc8omjp8mtFhhBEPY
	5hru60E2pDVpo6f4OUZpqnRPST+37m+/ZTUtnMpXfWWAbUMwudjkUcUYfDVJv7g8UsIHmqSF5MG
	a
X-Google-Smtp-Source: AGHT+IFevsa2xSarCWVzsqlWVTuWGske/KxphPrHLZUWroijNLKg+0txe6qyYWqs7dhp2SkKPHMwTA==
X-Received: by 2002:a17:902:d2c4:b0:1d9:21bc:c607 with SMTP id n4-20020a170902d2c400b001d921bcc607mr3676810plc.60.1707268170848;
        Tue, 06 Feb 2024 17:09:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVKJgXmzhywXDCDunk1XUN+Es1bRdr+rPskxiLLLWhSEmgCmNYrmPFKSPzks6PJxqsMtvthSBGuwpz3qcbz5t1dCdOTRIy4j/XzUghLizAsX8bE1gu8Paxxn4RUwxYbgFDZYVMscNbbuQrFk/lpTkXK5w==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id kn12-20020a170903078c00b001d8d1a2e5f2sm153599plb.216.2024.02.06.17.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 17:09:30 -0800 (PST)
Message-ID: <65c2d84a.170a0220.ff6d1.09c3@mx.google.com>
Date: Tue, 06 Feb 2024 17:09:30 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.209-cip44-50-ga624abaa85d7
Subject: cip/linux-5.10.y-cip baseline: 112 runs,
 27 regressions (v5.10.209-cip44-50-ga624abaa85d7)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Feb 2024 01:09:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14848

cip/linux-5.10.y-cip baseline: 112 runs, 27 regressions (v5.10.209-cip44-50=
-ga624abaa85d7)

Regressions Summary
-------------------

platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
at91sam9g20ek            | arm   | lab-broonie     | gcc-10   | at91_dt_def=
config            | 2          =

bcm2836-rpi-2-b          | arm   | lab-collabora   | gcc-10   | bcm2835_def=
config            | 1          =

beaglebone-black         | arm   | lab-broonie     | gcc-10   | multi_v7_de=
fconfig           | 1          =

beaglebone-black         | arm   | lab-cip         | gcc-10   | multi_v7_de=
fconfig           | 1          =

beaglebone-black         | arm   | lab-broonie     | gcc-10   | omap2plus_d=
efconfig          | 1          =

beaglebone-black         | arm   | lab-cip         | gcc-10   | omap2plus_d=
efconfig          | 1          =

imx6q-sabrelite          | arm   | lab-collabora   | gcc-10   | multi_v7_de=
fconfig           | 1          =

imx6qp-wandboard-revd1   | arm   | lab-pengutronix | gcc-10   | imx_v6_v7_d=
efconfig          | 1          =

imx6qp-wandboard-revd1   | arm   | lab-pengutronix | gcc-10   | multi_v7_de=
fconfig           | 1          =

juno-uboot               | arm64 | lab-broonie     | gcc-10   | cip://5.10.=
y-...64_defconfig | 1          =

juno-uboot               | arm64 | lab-broonie     | gcc-10   | defconfig  =
                  | 1          =

juno-uboot               | arm64 | lab-broonie     | gcc-10   | defconfig+k=
selftest          | 1          =

mt8173-elm-hana          | arm64 | lab-collabora   | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =

r8a7743-iwg20d-q7        | arm   | lab-cip         | gcc-10   | shmobile_de=
fconfig           | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip         | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =

r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip         | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =

r8a774c0-ek874           | arm64 | lab-cip         | gcc-10   | defconfig  =
                  | 1          =

r8a774c0-ek874           | arm64 | lab-cip         | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =

r8a77960-ulcb            | arm64 | lab-collabora   | gcc-10   | defconfig  =
                  | 1          =

rk3288-veyron-jaq        | arm   | lab-collabora   | gcc-10   | multi_v7_de=
fconfig           | 4          =

rk3399-rock-pi-4b        | arm64 | lab-collabora   | gcc-10   | defconfig  =
                  | 1          =

sun50i-a64-pine64-plus   | arm64 | lab-broonie     | gcc-10   | defconfig  =
                  | 1          =

sun50i-h6-pine-h64       | arm64 | lab-collabora   | gcc-10   | defconfig  =
                  | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.209-cip44-50-ga624abaa85d7/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.209-cip44-50-ga624abaa85d7
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a624abaa85d7f3ff289eb2e257db5c4485d11d18 =



Test Regressions
---------------- =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
at91sam9g20ek            | arm   | lab-broonie     | gcc-10   | at91_dt_def=
config            | 2          =


  Details:     https://kernelci.org/test/plan/id/65c2cc03c429391cfe8e1ea6

  Results:     47 PASS, 6 FAIL, 1 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm/at91_dt_defconfig/gcc-10/lab-broonie/baseline-a=
t91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm/at91_dt_defconfig/gcc-10/lab-broonie/baseline-a=
t91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/65c2cc03c=
429391cfe8e1eb1
        failing since 1 day (last pass: v5.10.208-cip43-4-g1c63c70fb18b8, f=
irst fail: v5.10.209-cip44)

    2024-02-07T00:16:49.578671  /lava-551001/1/../bin/lava-test-case
    2024-02-07T00:16:49.616283  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dsou=
nd-card RESULT=3Dfail>   =


  * baseline.bootrr.audio-card-probed: https://kernelci.org/test/case/id/65=
c2cc03c429391cfe8e1eb2
        failing since 1 day (last pass: v5.10.208-cip43-4-g1c63c70fb18b8, f=
irst fail: v5.10.209-cip44)

    2024-02-07T00:16:48.484968  /lava-551001/1/../bin/lava-test-case
    2024-02-07T00:16:48.523643  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Daud=
io-card-probed RESULT=3Dfail>   =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
bcm2836-rpi-2-b          | arm   | lab-collabora   | gcc-10   | bcm2835_def=
config            | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2cc4dc868f4bb528e1ee6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm/bcm2835_defconfig/gcc-10/lab-collabora/baseline=
-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm/bcm2835_defconfig/gcc-10/lab-collabora/baseline=
-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c2cc4dc868f4bb528e1eeb
        failing since 196 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2024-02-07T00:25:40.097999  / # #

    2024-02-07T00:25:40.200124  export SHELL=3D/bin/sh

    2024-02-07T00:25:40.200866  #

    2024-02-07T00:25:40.302189  / # export SHELL=3D/bin/sh. /lava-12710278/=
environment

    2024-02-07T00:25:40.302901  =


    2024-02-07T00:25:40.404363  / # . /lava-12710278/environment/lava-12710=
278/bin/lava-test-runner /lava-12710278/1

    2024-02-07T00:25:40.405484  =


    2024-02-07T00:25:40.422240  / # /lava-12710278/bin/lava-test-runner /la=
va-12710278/1

    2024-02-07T00:25:40.486314  + export 'TESTRUN_ID=3D1_bootrr'

    2024-02-07T00:25:40.524200  + cd /lava-12710278/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
beaglebone-black         | arm   | lab-broonie     | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2d0c0a3fd9811da8e1f24

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-=
beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-=
beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c2d0c0a3fd9811da8e1f4e
        failing since 388 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-07T00:36:43.971250  <8>[   23.995631] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 551086_1.5.2.4.1>
    2024-02-07T00:36:44.079395  / # #
    2024-02-07T00:36:44.181207  export SHELL=3D/bin/sh
    2024-02-07T00:36:44.181647  #
    2024-02-07T00:36:44.282856  / # export SHELL=3D/bin/sh. /lava-551086/en=
vironment
    2024-02-07T00:36:44.283351  =

    2024-02-07T00:36:44.384742  / # . /lava-551086/environment/lava-551086/=
bin/lava-test-runner /lava-551086/1
    2024-02-07T00:36:44.385465  =

    2024-02-07T00:36:44.389585  / # /lava-551086/bin/lava-test-runner /lava=
-551086/1
    2024-02-07T00:36:44.482513  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
beaglebone-black         | arm   | lab-cip         | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2d3eafbd777c8948e1ec9

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c2d3eafbd777c8948e1ef5
        failing since 388 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-07T00:50:13.371466  <8>[   15.780701] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1089503_1.5.2.4.1>
    2024-02-07T00:50:13.479560  / # #
    2024-02-07T00:50:13.581755  export SHELL=3D/bin/sh
    2024-02-07T00:50:13.582438  #
    2024-02-07T00:50:13.683801  / # export SHELL=3D/bin/sh. /lava-1089503/e=
nvironment
    2024-02-07T00:50:13.684487  =

    2024-02-07T00:50:13.785799  / # . /lava-1089503/environment/lava-108950=
3/bin/lava-test-runner /lava-1089503/1
    2024-02-07T00:50:13.786897  =

    2024-02-07T00:50:13.792831  / # /lava-1089503/bin/lava-test-runner /lav=
a-1089503/1
    2024-02-07T00:50:13.876201  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
beaglebone-black         | arm   | lab-broonie     | gcc-10   | omap2plus_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2cd6804b2be8c3c8e1e83

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline=
-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline=
-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c2cd6804b2be8c3c8e1eb9
        failing since 388 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-07T00:22:45.186091  <8>[   18.837607] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 551008_1.5.2.4.1>
    2024-02-07T00:22:45.294100  / # #
    2024-02-07T00:22:45.396694  export SHELL=3D/bin/sh
    2024-02-07T00:22:45.397366  #
    2024-02-07T00:22:45.499207  / # export SHELL=3D/bin/sh. /lava-551008/en=
vironment
    2024-02-07T00:22:45.499911  =

    2024-02-07T00:22:45.601789  / # . /lava-551008/environment/lava-551008/=
bin/lava-test-runner /lava-551008/1
    2024-02-07T00:22:45.602734  =

    2024-02-07T00:22:45.607218  / # /lava-551008/bin/lava-test-runner /lava=
-551008/1
    2024-02-07T00:22:45.702939  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
beaglebone-black         | arm   | lab-cip         | gcc-10   | omap2plus_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2cd77773b3423688e1e8b

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-bea=
glebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-bea=
glebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c2cd78773b3423688e1ebe
        failing since 388 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-07T00:22:46.309440  <8>[   12.971999] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1089473_1.5.2.4.1>
    2024-02-07T00:22:46.419805  / # #
    2024-02-07T00:22:46.521865  export SHELL=3D/bin/sh
    2024-02-07T00:22:46.522523  #
    2024-02-07T00:22:46.623878  / # export SHELL=3D/bin/sh. /lava-1089473/e=
nvironment
    2024-02-07T00:22:46.624546  =

    2024-02-07T00:22:46.725885  / # . /lava-1089473/environment/lava-108947=
3/bin/lava-test-runner /lava-1089473/1
    2024-02-07T00:22:46.726938  =

    2024-02-07T00:22:46.733633  / # /lava-1089473/bin/lava-test-runner /lav=
a-1089473/1
    2024-02-07T00:22:46.839359  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
imx6q-sabrelite          | arm   | lab-collabora   | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2d08d6e38672c998e1e7a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm/multi_v7_defconfig/gcc-10/lab-collabora/baselin=
e-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm/multi_v7_defconfig/gcc-10/lab-collabora/baselin=
e-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c2d08d6e38672c998e1e7f
        failing since 388 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-07T00:36:22.106000  / # #

    2024-02-07T00:36:22.208776  export SHELL=3D/bin/sh

    2024-02-07T00:36:22.209590  #

    2024-02-07T00:36:22.311173  / # export SHELL=3D/bin/sh. /lava-12710306/=
environment

    2024-02-07T00:36:22.311975  =


    2024-02-07T00:36:22.413743  / # . /lava-12710306/environment/lava-12710=
306/bin/lava-test-runner /lava-12710306/1

    2024-02-07T00:36:22.415038  =


    2024-02-07T00:36:22.427596  / # /lava-12710306/bin/lava-test-runner /la=
va-12710306/1

    2024-02-07T00:36:22.538574  + export 'TESTRUN_ID=3D1_bootrr'

    2024-02-07T00:36:22.539185  + cd /lava-12710306/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
imx6qp-wandboard-revd1   | arm   | lab-pengutronix | gcc-10   | imx_v6_v7_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2cfdedfb93f4df88e1eb7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/base=
line-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/base=
line-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c2cfdedfb93f4df88e1ebc
        failing since 388 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-07T00:33:27.734582  + set +x
    2024-02-07T00:33:27.734843  [   10.293075] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1023965_1.5.2.3.1>
    2024-02-07T00:33:27.841908  / # #
    2024-02-07T00:33:27.943053  export SHELL=3D/bin/sh
    2024-02-07T00:33:27.943500  #
    2024-02-07T00:33:28.044294  / # export SHELL=3D/bin/sh. /lava-1023965/e=
nvironment
    2024-02-07T00:33:28.044787  =

    2024-02-07T00:33:28.145628  / # . /lava-1023965/environment/lava-102396=
5/bin/lava-test-runner /lava-1023965/1
    2024-02-07T00:33:28.146227  =

    2024-02-07T00:33:28.149034  / # /lava-1023965/bin/lava-test-runner /lav=
a-1023965/1 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
imx6qp-wandboard-revd1   | arm   | lab-pengutronix | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2d06a4153c8e3b78e1e79

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/basel=
ine-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/basel=
ine-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c2d06a4153c8e3b78e1e7e
        failing since 388 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-07T00:35:47.060436  + set[    7.237404] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 1023967_1.5.2.3.1>
    2024-02-07T00:35:47.060602   +x
    2024-02-07T00:35:47.165659  / # #
    2024-02-07T00:35:47.266678  export SHELL=3D/bin/sh
    2024-02-07T00:35:47.267070  #
    2024-02-07T00:35:47.367865  / # export SHELL=3D/bin/sh. /lava-1023967/e=
nvironment
    2024-02-07T00:35:47.368305  =

    2024-02-07T00:35:47.469092  / # . /lava-1023967/environment/lava-102396=
7/bin/lava-test-runner /lava-1023967/1
    2024-02-07T00:35:47.469942  =

    2024-02-07T00:35:47.472285  / # /lava-1023967/bin/lava-test-runner /lav=
a-1023967/1 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
juno-uboot               | arm64 | lab-broonie     | gcc-10   | cip://5.10.=
y-...64_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2cfc4dc745e77498e1e7a

  Results:     47 PASS, 13 FAIL, 1 SKIP
  Full config: cip://5.10.y-cip/arm64/qemu_arm64_defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/cip---5.10.y-cip-arm64-qemu_arm64_defconfig/g=
cc-10/lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/cip---5.10.y-cip-arm64-qemu_arm64_defconfig/g=
cc-10/lab-broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c2cfc4dc745e77498e1eb5
        failing since 162 days (last pass: v5.10.186-cip37-27-gd6d928db0a62=
0, first fail: v5.10.191-cip38)

    2024-02-07T00:32:33.636706  / # #
    2024-02-07T00:32:33.739864  export SHELL=3D/bin/sh
    2024-02-07T00:32:33.740643  #
    2024-02-07T00:32:33.842568  / # export SHELL=3D/bin/sh. /lava-551024/en=
vironment
    2024-02-07T00:32:33.843395  =

    2024-02-07T00:32:33.945372  / # . /lava-551024/environment/lava-551024/=
bin/lava-test-runner /lava-551024/1
    2024-02-07T00:32:33.946753  =

    2024-02-07T00:32:33.960897  / # /lava-551024/bin/lava-test-runner /lava=
-551024/1
    2024-02-07T00:32:34.016704  + export 'TESTRUN_ID=3D1_bootrr'
    2024-02-07T00:32:34.017229  + cd /lava-551024/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
juno-uboot               | arm64 | lab-broonie     | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2d0c0a3fd9811da8e1ee2

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-ub=
oot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-ub=
oot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c2d0c0a3fd9811da8e1f1e
        failing since 1 day (last pass: v5.10.208-cip43-4-g1c63c70fb18b8, f=
irst fail: v5.10.209-cip44)

    2024-02-07T00:37:00.411986  / # #
    2024-02-07T00:37:00.515093  export SHELL=3D/bin/sh
    2024-02-07T00:37:00.515876  #
    2024-02-07T00:37:00.617842  / # export SHELL=3D/bin/sh. /lava-551027/en=
vironment
    2024-02-07T00:37:00.618730  =

    2024-02-07T00:37:00.720790  / # . /lava-551027/environment/lava-551027/=
bin/lava-test-runner /lava-551027/1
    2024-02-07T00:37:00.722189  =

    2024-02-07T00:37:00.734781  / # /lava-551027/bin/lava-test-runner /lava=
-551027/1
    2024-02-07T00:37:00.795599  + export 'TESTRUN_ID=3D1_bootrr'
    2024-02-07T00:37:00.796115  + cd /lava-551027/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
juno-uboot               | arm64 | lab-broonie     | gcc-10   | defconfig+k=
selftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2d1c44a419cde758e1f06

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig+kselftest/gcc-10/lab-broonie/baseli=
ne-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig+kselftest/gcc-10/lab-broonie/baseli=
ne-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c2d1c44a419cde758e1f41
        failing since 196 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2024-02-07T00:41:10.282657  <8>[   18.969870] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 551114_1.5.2.4.1>
    2024-02-07T00:41:10.390541  / # #
    2024-02-07T00:41:10.493673  export SHELL=3D/bin/sh
    2024-02-07T00:41:10.494502  #
    2024-02-07T00:41:10.596491  / # export SHELL=3D/bin/sh. /lava-551114/en=
vironment
    2024-02-07T00:41:10.597320  =

    2024-02-07T00:41:10.699349  / # . /lava-551114/environment/lava-551114/=
bin/lava-test-runner /lava-551114/1
    2024-02-07T00:41:10.700699  =

    2024-02-07T00:41:10.714051  / # /lava-551114/bin/lava-test-runner /lava=
-551114/1
    2024-02-07T00:41:10.891823  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
mt8173-elm-hana          | arm64 | lab-collabora   | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2d1b44a419cde758e1e86

  Results:     28 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/baseline-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/baseline-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c2d1b44a419cde758e1ea2
        failing since 388 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-07T00:41:39.519448  <8>[   15.582286] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2024-02-07T00:41:39.520684  + set +x

    2024-02-07T00:41:39.526552  <8>[   15.591822] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12710347_1.5.2.3.1>

    2024-02-07T00:41:39.632857  #

    2024-02-07T00:41:39.735766  / # #export SHELL=3D/bin/sh

    2024-02-07T00:41:39.736550  =


    2024-02-07T00:41:39.838475  / # export SHELL=3D/bin/sh. /lava-12710347/=
environment

    2024-02-07T00:41:39.839290  =


    2024-02-07T00:41:39.941093  / # . /lava-12710347/environment/lava-12710=
347/bin/lava-test-runner /lava-12710347/1

    2024-02-07T00:41:39.942397  =

 =

    ... (21 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
r8a7743-iwg20d-q7        | arm   | lab-cip         | gcc-10   | shmobile_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2ccb1fb9d8bfb6a8e203a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7=
743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7=
743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65c2ccb1fb9d8bfb6a8e2=
03b
        failing since 61 days (last pass: v5.10.201-cip41-16-g3c85fba3b6e5d=
, first fail: v5.10.201-cip41-28-ga386bc478aa6b) =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip         | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2d3cefbd777c8948e1ebe

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/bas=
eline-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/bas=
eline-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c2d3cefbd777c8948e1ec3
        failing since 196 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2024-02-07T00:49:52.648687  + set +x
    2024-02-07T00:49:52.651970  <8>[   84.046636] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1089518_1.5.2.4.1>
    2024-02-07T00:49:52.760379  / # #
    2024-02-07T00:49:54.218802  export SHELL=3D/bin/sh
    2024-02-07T00:49:54.239789  #
    2024-02-07T00:49:54.240293  / # export SHELL=3D/bin/sh
    2024-02-07T00:49:56.189771  / # . /lava-1089518/environment
    2024-02-07T00:49:59.771217  /lava-1089518/bin/lava-test-runner /lava-10=
89518/1
    2024-02-07T00:49:59.792093  . /lava-1089518/environment
    2024-02-07T00:49:59.792315  / # /lava-1089518/bin/lava-test-runner /lav=
a-1089518/1 =

    ... (28 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip         | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2d612fb861655f78e1e7b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/bas=
eline-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/bas=
eline-r8a774b1-hihope-rzg2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c2d612fb861655f78e1e80
        failing since 196 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2024-02-07T00:59:48.568860  + set +x
    2024-02-07T00:59:48.572305  <8>[   84.287545] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1089521_1.5.2.4.1>
    2024-02-07T00:59:48.680094  / # #
    2024-02-07T00:59:50.140650  export SHELL=3D/bin/sh
    2024-02-07T00:59:50.161683  #
    2024-02-07T00:59:50.162233  / # export SHELL=3D/bin/sh
    2024-02-07T00:59:52.114246  / # . /lava-1089521/environment
    2024-02-07T00:59:55.706543  /lava-1089521/bin/lava-test-runner /lava-10=
89521/1
    2024-02-07T00:59:55.727156  . /lava-1089521/environment
    2024-02-07T00:59:55.727246  / # /lava-1089521/bin/lava-test-runner /lav=
a-1089521/1 =

    ... (15 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
r8a774c0-ek874           | arm64 | lab-cip         | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2d0c2a3fd9811da8e1f57

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek=
874.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek=
874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c2d0c2a3fd9811da8e1f5c
        failing since 196 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2024-02-07T00:36:55.842755  / # #
    2024-02-07T00:36:57.301533  export SHELL=3D/bin/sh
    2024-02-07T00:36:57.322451  #
    2024-02-07T00:36:57.322943  / # export SHELL=3D/bin/sh
    2024-02-07T00:36:59.272595  / # . /lava-1089481/environment
    2024-02-07T00:37:02.859242  /lava-1089481/bin/lava-test-runner /lava-10=
89481/1
    2024-02-07T00:37:02.880423  . /lava-1089481/environment
    2024-02-07T00:37:02.880620  / # /lava-1089481/bin/lava-test-runner /lav=
a-1089481/1
    2024-02-07T00:37:02.958116  + export 'TESTRUN_ID=3D1_bootrr'
    2024-02-07T00:37:02.958285  + cd /lava-1089481/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
r8a774c0-ek874           | arm64 | lab-cip         | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2d536fe9213a03e8e1e7b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/bas=
eline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/bas=
eline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c2d536fe9213a03e8e1e80
        failing since 196 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2024-02-07T00:55:56.284876  / # #
    2024-02-07T00:55:57.745165  export SHELL=3D/bin/sh
    2024-02-07T00:55:57.766183  #
    2024-02-07T00:55:57.766721  / # export SHELL=3D/bin/sh
    2024-02-07T00:55:59.718648  / # . /lava-1089525/environment
    2024-02-07T00:56:03.310133  /lava-1089525/bin/lava-test-runner /lava-10=
89525/1
    2024-02-07T00:56:03.331753  . /lava-1089525/environment
    2024-02-07T00:56:03.332131  / # /lava-1089525/bin/lava-test-runner /lav=
a-1089525/1
    2024-02-07T00:56:03.369216  + export 'TESTRUN_ID=3D1_bootrr'
    2024-02-07T00:56:03.413947  + cd /lava-1089525/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
r8a77960-ulcb            | arm64 | lab-collabora   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2cfe6dfb93f4df88e1ec2

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77=
960-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77=
960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c2cfe6dfb93f4df88e1ec7
        failing since 196 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2024-02-07T00:41:10.689659  / # #

    2024-02-07T00:41:10.791801  export SHELL=3D/bin/sh

    2024-02-07T00:41:10.792545  #

    2024-02-07T00:41:10.893962  / # export SHELL=3D/bin/sh. /lava-12710289/=
environment

    2024-02-07T00:41:10.894670  =


    2024-02-07T00:41:10.996057  / # . /lava-12710289/environment/lava-12710=
289/bin/lava-test-runner /lava-12710289/1

    2024-02-07T00:41:10.997188  =


    2024-02-07T00:41:11.013765  / # /lava-12710289/bin/lava-test-runner /la=
va-12710289/1

    2024-02-07T00:41:11.063174  + export 'TESTRUN_ID=3D1_bootrr'

    2024-02-07T00:41:11.063678  + cd /lav<8>[   16.478798] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12710289_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
rk3288-veyron-jaq        | arm   | lab-collabora   | gcc-10   | multi_v7_de=
fconfig           | 4          =


  Details:     https://kernelci.org/test/plan/id/65c2d09a581a416e708e1f2d

  Results:     63 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm/multi_v7_defconfig/gcc-10/lab-collabora/baselin=
e-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm/multi_v7_defconfig/gcc-10/lab-collabora/baselin=
e-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-i2c-present: https://kernelci.or=
g/test/case/id/65c2d09a581a416e708e1f5c
        failing since 387 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-07T00:43:51.878963  FIRST,<8>[   21.281443] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>

    2024-02-07T00:43:51.880718   INC default to 1.

    2024-02-07T00:43:51.881106  =


    2024-02-07T00:43:51.884407  	-w	Pad to last with leading zeros

    2024-02-07T00:43:51.887016  	-s SEP	String separator

    2024-02-07T00:43:51.890784  /lava-12710311/1/../bin/lava-test-case

    2024-02-07T00:43:51.896887  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.

    2024-02-07T00:43:51.897110  =


    2024-02-07T00:43:51.907220  Usag<8>[   21.310450] <LAVA_SIGNAL_TESTCASE=
 TEST_CASE_ID=3Ddwhdmi-rockchip-driver-i2c-present RESULT=3Dfail>
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/65c2d09a581a416e708e1f5d
        failing since 387 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-07T00:43:51.856517  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC)<8=
>[   21.262443] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2024-02-07T00:43:51.858513   multi-call binary.

    2024-02-07T00:43:51.858736  =


    2024-02-07T00:43:51.862951  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2024-02-07T00:43:51.863178  =


    2024-02-07T00:43:51.868272  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/65c2d09a581a416e708e1f5e
        failing since 387 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-07T00:43:51.837456  <8>[   21.244608] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c2d09a581a416e708e1f72
        failing since 387 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-07T00:43:39.780413  <8>[    9.187369] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2024-02-07T00:43:39.790021  + <8>[    9.199823] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 12710311_1.5.2.3.1>

    2024-02-07T00:43:39.790555  set +x

    2024-02-07T00:43:39.897173  =


    2024-02-07T00:43:39.998929  / # #export SHELL=3D/bin/sh

    2024-02-07T00:43:39.999637  =


    2024-02-07T00:43:40.101158  / # export SHELL=3D/bin/sh. /lava-12710311/=
environment

    2024-02-07T00:43:40.101386  =


    2024-02-07T00:43:40.202157  / # . /lava-12710311/environment/lava-12710=
311/bin/lava-test-runner /lava-12710311/1

    2024-02-07T00:43:40.203276  =

 =

    ... (19 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
rk3399-rock-pi-4b        | arm64 | lab-collabora   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2d017e5a2525fad8e1e7a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig/gcc-10/lab-collabora/baseline-rk339=
9-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig/gcc-10/lab-collabora/baseline-rk339=
9-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c2d017e5a2525fad8e1e7f
        failing since 140 days (last pass: v5.10.191-cip38-29-g9e1aa2001db8=
, first fail: v5.10.194-cip39)

    2024-02-07T00:34:05.713249  / # #

    2024-02-07T00:34:06.974021  export SHELL=3D/bin/sh

    2024-02-07T00:34:06.984912  #

    2024-02-07T00:34:06.985380  / # export SHELL=3D/bin/sh

    2024-02-07T00:34:08.728878  / # . /lava-12710300/environment

    2024-02-07T00:34:11.933477  /lava-12710300/bin/lava-test-runner /lava-1=
2710300/1

    2024-02-07T00:34:11.944920  . /lava-12710300/environment

    2024-02-07T00:34:11.950269  / # /lava-12710300/bin/lava-test-runner /la=
va-12710300/1

    2024-02-07T00:34:12.000251  + export 'TESTRUN_ID=3D1_bootrr'

    2024-02-07T00:34:12.000733  + cd /lava-12710300/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
sun50i-a64-pine64-plus   | arm64 | lab-broonie     | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2d02d2c216892578e1e7f

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-=
a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-=
a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c2d02d2c216892578e1eaa
        failing since 388 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-07T00:33:50.996451  + set +x
    2024-02-07T00:33:51.000336  <8>[   17.004777] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 551047_1.5.2.4.1>
    2024-02-07T00:33:51.110963  / # #
    2024-02-07T00:33:51.212725  export SHELL=3D/bin/sh
    2024-02-07T00:33:51.213147  #
    2024-02-07T00:33:51.314536  / # export SHELL=3D/bin/sh. /lava-551047/en=
vironment
    2024-02-07T00:33:51.314948  =

    2024-02-07T00:33:51.416548  / # . /lava-551047/environment/lava-551047/=
bin/lava-test-runner /lava-551047/1
    2024-02-07T00:33:51.417204  =

    2024-02-07T00:33:51.421310  / # /lava-551047/bin/lava-test-runner /lava=
-551047/1 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
sun50i-h6-pine-h64       | arm64 | lab-collabora   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2cffadfb93f4df88e1f91

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50=
i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50=
i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c2cffadfb93f4df88e1f96
        failing since 196 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2024-02-07T00:41:22.499811  / # #

    2024-02-07T00:41:22.602040  export SHELL=3D/bin/sh

    2024-02-07T00:41:22.602764  #

    2024-02-07T00:41:22.704179  / # export SHELL=3D/bin/sh. /lava-12710295/=
environment

    2024-02-07T00:41:22.704996  =


    2024-02-07T00:41:22.806450  / # . /lava-12710295/environment/lava-12710=
295/bin/lava-test-runner /lava-12710295/1

    2024-02-07T00:41:22.807551  =


    2024-02-07T00:41:22.809330  / # /lava-12710295/bin/lava-test-runner /la=
va-12710295/1

    2024-02-07T00:41:22.852864  + export 'TESTRUN_ID=3D1_bootrr'

    2024-02-07T00:41:22.884407  + cd /lava-1271029<8>[   18.187893] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12710295_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

