Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A0EEB64D7
	for <webhook@archiver.kernel.org>; Thu, 22 Jun 2023 02:05:02 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web11.126.1687399492712948248
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 21 Jun 2023 19:04:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=v8Hh7wxH;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.48, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-25eb3db3004so3136859a91.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 21 Jun 2023 19:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687399492; x=1689991492;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Xnwd1rPnJmT+2e2ZRlNP37MhqAOVLPwzj1iBCrQ+UDU=;
        b=v8Hh7wxHw3RKLpJ3G3iUknmsAObecOIgNOyHB/L8kGtxFT2FMOOhxKXGpkngx2OdR4
         ZR6yBe1/VVwss2//S8acuOXynfsO4CIyTuCzWOT88/tve2WAI9L8gavMlf5Fi7nqES0W
         5u830JWBDUt1peG0/jTgl9qOPKgmGga0mE+PyQaut9ErNPo5V2gsvH9Zi5Cz7/ZeyB6O
         hSx59WglZfHQbRLAoN5QThKx3/aOSj0KTHWpwzvwYPhjsNO0QVz6j28yzn+i5HNMuMwN
         E4u5cVUr07yiRao4rXnyM3Bn8KTklD+7oem9iuQtssIydQaC46ggXCLlTn+0gb1RZLBz
         tR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687399492; x=1689991492;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xnwd1rPnJmT+2e2ZRlNP37MhqAOVLPwzj1iBCrQ+UDU=;
        b=fy8ezVvuIep5SKLN8R/okt45vzgHgksDKPRq4YFK7j1a2CP1ZH/KIfu7+2GuyIOJdR
         dS0zcMNSLPnHtZcwnnVVHyERfiBu8lWblbMulncH+Vgmua8wMEi5U0nkegzn9oa1dvmw
         b0kVt2fcMVVlQTLdqvTz4ijYyUL0uDfFjmuCwqSyYU6hYqHIXbxa1gv7RI9IG2ptK4j/
         7HMNtikBTs3gflprD73K4VBu7RNjm5M0zNuSKTUwJItSF4tIB26jCQ+xL2/hH2nUeBE2
         YbjiqZJKprYgL/SCyLY4cTN72QwNC0mGSvWxqPw6U0VEH0b3ZYwBvfa2TXe7NYspN3a6
         /bPA==
X-Gm-Message-State: AC+VfDyyIJT5Oi4BatJaPL7gdN66WQWxSLE2VLst6BTKsI3EyZkyMKwW
	HvTykSABduk4zOWsjVjf18QRGK4NbNEVsXiFLa8Icg==
X-Google-Smtp-Source: ACHHUZ5MKVwhCv3vVGcAuBR8pq4C31gqUjScB8U7hefcgHzxuZ89meIO1mbLtra/fhI27YUjUpGmLg==
X-Received: by 2002:a17:90b:1953:b0:25e:b5b9:c2f1 with SMTP id nk19-20020a17090b195300b0025eb5b9c2f1mr10578587pjb.39.1687399491134;
        Wed, 21 Jun 2023 19:04:51 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id nu10-20020a17090b1b0a00b0025645d118adsm3838615pjb.14.2023.06.21.19.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 19:04:50 -0700 (PDT)
Message-ID: <6493ac42.170a0220.87fb.8e23@mx.google.com>
Date: Wed, 21 Jun 2023 19:04:50 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.184-cip36
Subject: cip/linux-5.10.y-cip baseline: 118 runs,
 17 regressions (v5.10.184-cip36)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 22 Jun 2023 02:05:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12107

cip/linux-5.10.y-cip baseline: 118 runs, 17 regressions (v5.10.184-cip36)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =

mt8173-elm-hana              | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =

rk3288-veyron-jaq            | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 4          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.184-cip36/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.184-cip36
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      f34f3ecd0387c3ad8b34bf65ac19ec84a38f2333 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64939eafd341a208b230612e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64939eafd341a208b2306137
        failing since 158 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-22T01:06:32.703827  <8>[   12.314351] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10853273_1.4.2.3.1>

    2023-06-22T01:06:32.707161  + set +x

    2023-06-22T01:06:32.808474  #

    2023-06-22T01:06:32.808744  =


    2023-06-22T01:06:32.909327  / # #export SHELL=3D/bin/sh

    2023-06-22T01:06:32.909515  =


    2023-06-22T01:06:33.010043  / # export SHELL=3D/bin/sh. /lava-10853273/=
environment

    2023-06-22T01:06:33.010269  =


    2023-06-22T01:06:33.110945  / # . /lava-10853273/environment/lava-10853=
273/bin/lava-test-runner /lava-10853273/1

    2023-06-22T01:06:33.111222  =

 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6493a1a2de5233a35330614b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6493a1a2de5233a353306154
        failing since 158 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-22T01:19:14.659845  <8>[   11.810362] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-06-22T01:19:14.661658  + set +x

    2023-06-22T01:19:14.668339  <8>[   11.821232] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10853197_1.4.2.3.1>

    2023-06-22T01:19:14.772875  =


    2023-06-22T01:19:14.873413  / # #export SHELL=3D/bin/sh

    2023-06-22T01:19:14.873611  =


    2023-06-22T01:19:14.974133  / # export SHELL=3D/bin/sh. /lava-10853197/=
environment

    2023-06-22T01:19:14.974332  =


    2023-06-22T01:19:15.074849  / # . /lava-10853197/environment/lava-10853=
197/bin/lava-test-runner /lava-10853197/1

    2023-06-22T01:19:15.075134  =

 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6493a0aa82038a823a306144

  Results:     47 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6493a0aa82038a823a30617b
        failing since 158 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-22T01:14:47.590218  + set +x
    2023-06-22T01:14:47.595459  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 650017_1.5.2=
.4.1>
    2023-06-22T01:14:47.708319  / # #
    2023-06-22T01:14:47.811165  export SHELL=3D/bin/sh
    2023-06-22T01:14:47.811990  #
    2023-06-22T01:14:47.913946  / # export SHELL=3D/bin/sh. /lava-650017/en=
vironment
    2023-06-22T01:14:47.914767  =

    2023-06-22T01:14:48.016827  / # . /lava-650017/environment/lava-650017/=
bin/lava-test-runner /lava-650017/1
    2023-06-22T01:14:48.018143  =

    2023-06-22T01:14:48.024692  / # /lava-650017/bin/lava-test-runner /lava=
-650017/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6493a0c7ce8a78446530614d

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6493a0c7ce8a78446530617e
        failing since 158 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-22T01:15:20.599465  <8>[   18.597896] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 650014_1.5.2.4.1>
    2023-06-22T01:15:20.709702  / # #
    2023-06-22T01:15:20.812866  export SHELL=3D/bin/sh
    2023-06-22T01:15:20.813697  #
    2023-06-22T01:15:20.915956  / # export SHELL=3D/bin/sh. /lava-650014/en=
vironment
    2023-06-22T01:15:20.916878  =

    2023-06-22T01:15:21.018939  / # . /lava-650014/environment/lava-650014/=
bin/lava-test-runner /lava-650014/1
    2023-06-22T01:15:21.020228  =

    2023-06-22T01:15:21.024814  / # /lava-650014/bin/lava-test-runner /lava=
-650014/1
    2023-06-22T01:15:21.119257  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6493a32715824d291d3061cb

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6493a32815824d291d306205
        failing since 158 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-22T01:25:41.858940  <8>[   19.818631] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 650109_1.5.2.4.1>
    2023-06-22T01:25:41.969104  / # #
    2023-06-22T01:25:42.071777  export SHELL=3D/bin/sh
    2023-06-22T01:25:42.072492  #
    2023-06-22T01:25:42.174598  / # export SHELL=3D/bin/sh. /lava-650109/en=
vironment
    2023-06-22T01:25:42.175263  =

    2023-06-22T01:25:42.277144  / # . /lava-650109/environment/lava-650109/=
bin/lava-test-runner /lava-650109/1
    2023-06-22T01:25:42.278244  =

    2023-06-22T01:25:42.282627  / # /lava-650109/bin/lava-test-runner /lava=
-650109/1
    2023-06-22T01:25:42.389682  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6493a23bf426809e3730613d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6493a23bf426809e37306146
        failing since 68 days (last pass: v5.10.176-cip30, first fail: v5.1=
0.177-cip31)

    2023-06-22T01:21:49.737234  + set +x

    2023-06-22T01:21:49.744189  <8>[   29.130381] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10853223_1.4.2.3.1>

    2023-06-22T01:21:49.848509  / # #

    2023-06-22T01:21:49.949111  export SHELL=3D/bin/sh

    2023-06-22T01:21:49.949310  #

    2023-06-22T01:21:50.049795  / # export SHELL=3D/bin/sh. /lava-10853223/=
environment

    2023-06-22T01:21:50.049990  =


    2023-06-22T01:21:50.150493  / # . /lava-10853223/environment/lava-10853=
223/bin/lava-test-runner /lava-10853223/1

    2023-06-22T01:21:50.150842  =


    2023-06-22T01:21:50.155981  / # /lava-10853223/bin/lava-test-runner /la=
va-10853223/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6493a120dbccfc09ea30615a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6493a120dbccfc09ea306163
        failing since 68 days (last pass: v5.10.176-cip30, first fail: v5.1=
0.177-cip31)

    2023-06-22T01:17:01.853743  + set +x

    2023-06-22T01:17:01.860456  <8>[   13.679616] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10853225_1.4.2.3.1>

    2023-06-22T01:17:01.962623  =


    2023-06-22T01:17:02.063237  / # #export SHELL=3D/bin/sh

    2023-06-22T01:17:02.063438  =


    2023-06-22T01:17:02.163933  / # export SHELL=3D/bin/sh. /lava-10853225/=
environment

    2023-06-22T01:17:02.164116  =


    2023-06-22T01:17:02.264648  / # . /lava-10853225/environment/lava-10853=
225/bin/lava-test-runner /lava-10853225/1

    2023-06-22T01:17:02.264904  =


    2023-06-22T01:17:02.270234  / # /lava-10853225/bin/lava-test-runner /la=
va-10853225/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6493a0625eff3f5f55306146

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6493a0625eff3f5f5530614f
        failing since 158 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-22T01:14:08.861652  / # #

    2023-06-22T01:14:08.964008  export SHELL=3D/bin/sh

    2023-06-22T01:14:08.964705  #

    2023-06-22T01:14:09.065675  / # export SHELL=3D/bin/sh. /lava-10853494/=
environment

    2023-06-22T01:14:09.066409  =


    2023-06-22T01:14:09.167847  / # . /lava-10853494/environment/lava-10853=
494/bin/lava-test-runner /lava-10853494/1

    2023-06-22T01:14:09.169146  =


    2023-06-22T01:14:09.184062  / # /lava-10853494/bin/lava-test-runner /la=
va-10853494/1

    2023-06-22T01:14:09.287171  + export 'TESTRUN_ID=3D1_bootrr'

    2023-06-22T01:14:09.287725  + cd /lava-10853494/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6493a5bfbf28b7398b306139

  Results:     28 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt817=
3-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt817=
3-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6493a5bfbf28b7398b306159
        failing since 158 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-22T01:36:32.856175  + set +x

    2023-06-22T01:36:32.861820  <8>[   15.661264] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10853655_1.5.2.3.1>

    2023-06-22T01:36:32.966027  / # #

    2023-06-22T01:36:33.066645  export SHELL=3D/bin/sh

    2023-06-22T01:36:33.066867  #

    2023-06-22T01:36:33.167427  / # export SHELL=3D/bin/sh. /lava-10853655/=
environment

    2023-06-22T01:36:33.167731  =


    2023-06-22T01:36:33.268239  / # . /lava-10853655/environment/lava-10853=
655/bin/lava-test-runner /lava-10853655/1

    2023-06-22T01:36:33.268606  =


    2023-06-22T01:36:33.271008  / # /lava-10853655/bin/lava-test-runner /la=
va-10853655/1
 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6493a0ac96868b75bc30612f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6493a0ac96868b75bc306=
130
        failing since 16 days (last pass: v5.10.180-cip34, first fail: v5.1=
0.180-cip34-19-gf0f6960f132cd) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 4          =


  Details:     https://kernelci.org/test/plan/id/6493a0c961ec0c0b8d30612e

  Results:     63 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-j=
aq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-j=
aq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-i2c-present: https://kernelci.or=
g/test/case/id/6493a0c961ec0c0b8d306161
        failing since 157 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-22T01:16:37.790853  FIRST,<8>[   18.653949] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>

    2023-06-22T01:16:37.792743   INC default to 1.

    2023-06-22T01:16:37.792958  =


    2023-06-22T01:16:37.796766  	-w	Pad to last with leading zeros

    2023-06-22T01:16:37.798762  	-s SEP	String separator

    2023-06-22T01:16:37.802960  /lava-10853492/1/../bin/lava-test-case

    2023-06-22T01:16:37.808945  BusyBox v1.31.1 (2023-06-09 10:32:04 UTC) m=
ulti-call binary.

    2023-06-22T01:16:37.808996  =

   =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/6493a0c961ec0c0b8d306162
        failing since 157 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-22T01:16:37.768503  BusyBox v1.31.1 (2023-06-09 10:32:04 UTC)<8=
>[   18.634889] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-06-22T01:16:37.770462   multi-call binary.

    2023-06-22T01:16:37.770707  =


    2023-06-22T01:16:37.775001  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-06-22T01:16:37.775301  =


    2023-06-22T01:16:37.780180  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/6493a0c961ec0c0b8d306163
        failing since 157 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24) =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6493a0c961ec0c0b8d306177
        failing since 157 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-22T01:16:25.689519  <8>[    6.556836] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-06-22T01:16:25.698503  + <8>[    6.569277] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10853492_1.5.2.3.1>

    2023-06-22T01:16:25.699468  set +x

    2023-06-22T01:16:25.805067  =


    2023-06-22T01:16:25.905863  / # #export SHELL=3D/bin/sh

    2023-06-22T01:16:25.906627  =


    2023-06-22T01:16:26.008239  / # export SHELL=3D/bin/sh. /lava-10853492/=
environment

    2023-06-22T01:16:26.008951  =


    2023-06-22T01:16:26.110367  / # . /lava-10853492/environment/lava-10853=
492/bin/lava-test-runner /lava-10853492/1

    2023-06-22T01:16:26.111345  =

 =

    ... (19 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6493a5d9bf28b7398b306246

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk339=
9-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk339=
9-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/6493a5d9bf28b7398b306250
        failing since 91 days (last pass: v5.10.173-cip28, first fail: v5.1=
0.175-cip29)

    2023-06-22T01:37:08.393388  /lava-10853636/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/6493a5d9bf28b7398b306251
        failing since 91 days (last pass: v5.10.173-cip28, first fail: v5.1=
0.175-cip29)

    2023-06-22T01:37:07.356725  /lava-10853636/1/../bin/lava-test-case

    2023-06-22T01:37:07.368232  <8>[   33.992293] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6493a3cfaddc19f97f306169

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6493a3cfaddc19f97f306196
        failing since 158 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-22T01:28:16.334310  <8>[   17.127238] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 650101_1.5.2.4.1>
    2023-06-22T01:28:16.454449  / # #
    2023-06-22T01:28:16.557452  export SHELL=3D/bin/sh
    2023-06-22T01:28:16.557988  #
    2023-06-22T01:28:16.659266  / # export SHELL=3D/bin/sh. /lava-650101/en=
vironment
    2023-06-22T01:28:16.659760  =

    2023-06-22T01:28:16.761726  / # . /lava-650101/environment/lava-650101/=
bin/lava-test-runner /lava-650101/1
    2023-06-22T01:28:16.763041  =

    2023-06-22T01:28:16.771921  / # /lava-650101/bin/lava-test-runner /lava=
-650101/1
    2023-06-22T01:28:16.813050  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20

