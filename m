Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73087C7EE24
	for <webhook@archiver.kernel.org>; Tue,  6 Jun 2023 10:56:40 +0000 (UTC)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
 by mx.groups.io with SMTP id smtpd.web10.5756.1686048991317866442
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 06 Jun 2023 03:56:31 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=XRR3JpZ4;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.128.179, mailfrom: bot@kernelci.org)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-565cfe4ece7so65286177b3.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 06 Jun 2023 03:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686048990; x=1688640990;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xPKpJI9dc/b80gUH7Gu/IuIcbzebcSHr+ESuNsvUfww=;
        b=XRR3JpZ4T9X5q1qizmI/D3bu0kblU/Gv1pJnmspxbI+BFKSU3DknGmzkq/Au9dbtza
         /8Rdj7ifUEL1Wy0XxllLjhwuLv0gkYtWpJy1WJItntzz6BScts+XpI7nuO1aFZdQlSXL
         35f/MHF/tYuc4Gy9VCjg4TG5EENk9KBSF1n4yTMw6ARiLf2Cq0hUnNB10B1DnPWzdq7t
         AKo3Ej7+rwCS9f1M+j2Zasr3MDXhn+3Q5LHszB26RgMcskmhveozISgbFRWzTGW1piCM
         Af+XVaACUANyeviDWvi1fu3s9NTIeDTHUP3M+0pnqVgsAzXxreaqTilRdirTbBralTqu
         zmjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686048990; x=1688640990;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xPKpJI9dc/b80gUH7Gu/IuIcbzebcSHr+ESuNsvUfww=;
        b=LKjG1cc9Rvybzqdh5CAi8ezqv66SbMKTL4bcklgekdmUgzp7cLYJP+HidZbx3EUrdX
         wdGS4vT81gcaDzWvykKK5tbEZbOvLTxaKOp1jjFYOzg94rio9tccUVSsMmwJc+GaF4LT
         ZkLPdrBx3Flhx0DXBnGcEA/OWh/3BagzYRVci5MNcRAxpR5eq7H0eP5Qk9d1XOFek64R
         uqtlrnao+UrTF/HVjkjzQwIS8RJAdgLLmtU/JxH+VlLAhQfAHJym7PJBUaP3EZHGD5s6
         DktVPTbIZqZsxW8s7p08ZFMMmIJWc4mrpkNJE9rf9U3XrjlEEFE2/w+xDTSNSKEdBH+T
         57sw==
X-Gm-Message-State: AC+VfDxH5A0+79stDRNeJoz25HEvj18mw4L6hc0I0npw43/qyZdE+615
	kzkr2tDSN3LTWbwrJkLGQ4r7T+meuw+goxk5lJC5KA==
X-Google-Smtp-Source: ACHHUZ55QL5do4M4jla3hIfbFpHeCNkPdGsq8IFj/n+OAU4a0DnBoRfkxGSi2bDjl5rktfrRhWSMwg==
X-Received: by 2002:a81:6f57:0:b0:561:7351:f56f with SMTP id k84-20020a816f57000000b005617351f56fmr2097848ywc.24.1686048989533;
        Tue, 06 Jun 2023 03:56:29 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e16-20020aa78c50000000b0064d5b82f987sm6770309pfd.140.2023.06.06.03.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 03:56:29 -0700 (PDT)
Message-ID: <647f10dd.a70a0220.9d6c8.c764@mx.google.com>
Date: Tue, 06 Jun 2023 03:56:29 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.180-cip34-26-g462b2292d23e6
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip baseline: 132 runs,
 23 regressions (v5.10.180-cip34-26-g462b2292d23e6)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jun 2023 10:56:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11867

cip/linux-5.10.y-cip baseline: 132 runs, 23 regressions (v5.10.180-cip34-26=
-g462b2292d23e6)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =

fsl-ls1028a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

fsl-ls1088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =

imx7ulp-evk                  | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =

mt8173-elm-hana              | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =

rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 4          =

rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.180-cip34-26-g462b2292d23e6/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.180-cip34-26-g462b2292d23e6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      462b2292d23e6b1dc941676861a2951dd3a98d13 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647f030100acd77c20f5de73

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647f030100acd77c20f5de7c
        failing since 143 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-06T09:57:00.447099  + set +x

    2023-06-06T09:57:00.453798  <8>[   12.018496] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10603927_1.4.2.3.1>

    2023-06-06T09:57:00.555785  =


    2023-06-06T09:57:00.656334  / # #export SHELL=3D/bin/sh

    2023-06-06T09:57:00.656510  =


    2023-06-06T09:57:00.757053  / # export SHELL=3D/bin/sh. /lava-10603927/=
environment

    2023-06-06T09:57:00.757241  =


    2023-06-06T09:57:00.857773  / # . /lava-10603927/environment/lava-10603=
927/bin/lava-test-runner /lava-10603927/1

    2023-06-06T09:57:00.858043  =


    2023-06-06T09:57:00.858121  / # /lava-10603927/bin/lava-test-runner /la=
va-10603927/1<4>[   12.395532] i2c_designware i2c_designware.2: timeout in =
disabling adapter
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647f02f051df279f12f5de79

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647f02f051df279f12f5de82
        failing since 143 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-06T09:57:06.488964  + set +x

    2023-06-06T09:57:06.496194  <8>[    9.455297] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10603976_1.4.2.3.1>

    2023-06-06T09:57:06.600503  / # #

    2023-06-06T09:57:06.701161  export SHELL=3D/bin/sh

    2023-06-06T09:57:06.701396  #

    2023-06-06T09:57:06.801952  / # export SHELL=3D/bin/sh. /lava-10603976/=
environment

    2023-06-06T09:57:06.802189  =


    2023-06-06T09:57:06.902754  / # . /lava-10603976/environment/lava-10603=
976/bin/lava-test-runner /lava-10603976/1

    2023-06-06T09:57:06.903147  =


    2023-06-06T09:57:06.903256  / # <4>[    9.800215] i2c_designware i2c_de=
signware.5: timeout in disabling adapter
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647f018f61cf4b54b7f5de26

  Results:     47 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline=
-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline=
-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647f018f61cf4b54b7f5de5e
        failing since 143 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-06T09:50:36.054048  + set +x
    2023-06-06T09:50:36.060122  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 568539_1.5.2=
.4.1>
    2023-06-06T09:50:36.174445  / # #
    2023-06-06T09:50:36.277322  export SHELL=3D/bin/sh
    2023-06-06T09:50:36.278219  #
    2023-06-06T09:50:36.380219  / # export SHELL=3D/bin/sh. /lava-568539/en=
vironment
    2023-06-06T09:50:36.381040  =

    2023-06-06T09:50:36.483088  / # . /lava-568539/environment/lava-568539/=
bin/lava-test-runner /lava-568539/1
    2023-06-06T09:50:36.484495  =

    2023-06-06T09:50:36.490153  / # /lava-568539/bin/lava-test-runner /lava=
-568539/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647f05612100988849f5de38

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline=
-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline=
-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647f05612100988849f5de68
        failing since 143 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-06T10:06:52.309059  <8>[   22.955139] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 568685_1.5.2.4.1>
    2023-06-06T10:06:52.417051  / # #
    2023-06-06T10:06:52.519521  export SHELL=3D/bin/sh
    2023-06-06T10:06:52.519982  #
    2023-06-06T10:06:52.621408  / # export SHELL=3D/bin/sh. /lava-568685/en=
vironment
    2023-06-06T10:06:52.621967  =

    2023-06-06T10:06:52.723383  / # . /lava-568685/environment/lava-568685/=
bin/lava-test-runner /lava-568685/1
    2023-06-06T10:06:52.724359  =

    2023-06-06T10:06:52.728737  / # /lava-568685/bin/lava-test-runner /lava=
-568685/1
    2023-06-06T10:06:52.816871  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647f04f0471df00e61f5de43

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/arm/omap2plus_defconfig/gcc-10/lab-broonie/baselin=
e-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/arm/omap2plus_defconfig/gcc-10/lab-broonie/baselin=
e-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647f04f0471df00e61f5de74
        failing since 143 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-06T10:05:17.839608  <8>[   18.987720] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 568646_1.5.2.4.1>
    2023-06-06T10:05:17.951079  / # #
    2023-06-06T10:05:18.054120  export SHELL=3D/bin/sh
    2023-06-06T10:05:18.054985  #
    2023-06-06T10:05:18.157002  / # export SHELL=3D/bin/sh. /lava-568646/en=
vironment
    2023-06-06T10:05:18.157859  =

    2023-06-06T10:05:18.259952  / # . /lava-568646/environment/lava-568646/=
bin/lava-test-runner /lava-568646/1
    2023-06-06T10:05:18.261310  =

    2023-06-06T10:05:18.265964  / # /lava-568646/bin/lava-test-runner /lava=
-568646/1
    2023-06-06T10:05:18.375273  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls1028a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/647f03c1176273f2b5f5ded2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1028=
a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1028=
a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647f03c1176273f2b5f5ded9
        failing since 84 days (last pass: v5.10.155-cip21, first fail: v5.1=
0.173-cip28)

    2023-06-06T10:00:06.664872  [   19.463722] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1234247_1.5.2.4.1>
    2023-06-06T10:00:06.770885  / # #
    2023-06-06T10:00:06.872027  export SHELL=3D/bin/sh
    2023-06-06T10:00:06.872252  #
    2023-06-06T10:00:06.973226  / # export SHELL=3D/bin/sh. /lava-1234247/e=
nvironment
    2023-06-06T10:00:06.973440  =

    2023-06-06T10:00:07.074410  / # . /lava-1234247/environment/lava-123424=
7/bin/lava-test-runner /lava-1234247/1
    2023-06-06T10:00:07.074774  =

    2023-06-06T10:00:07.076737  / # /lava-1234247/bin/lava-test-runner /lav=
a-1234247/1
    2023-06-06T10:00:07.097525  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls1088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/647f02e851df279f12f5de5c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1088=
a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1088=
a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647f02e851df279f12f5de63
        failing since 143 days (last pass: v5.10.155-cip21, first fail: v5.=
10.162-cip24)

    2023-06-06T09:55:47.884935  + [    9.967958] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 1234246_1.5.2.4.1>
    2023-06-06T09:55:47.885215  set +x
    2023-06-06T09:55:47.991032  / # #
    2023-06-06T09:55:48.092857  export SHELL=3D/bin/sh
    2023-06-06T09:55:48.093296  #
    2023-06-06T09:55:48.194640  / # export SHELL=3D/bin/sh. /lava-1234246/e=
nvironment
    2023-06-06T09:55:48.195081  =

    2023-06-06T09:55:48.296444  / # . /lava-1234246/environment/lava-123424=
6/bin/lava-test-runner /lava-1234246/1
    2023-06-06T09:55:48.297152  =

    2023-06-06T09:55:48.299104  / # /lava-1234246/bin/lava-test-runner /lav=
a-1234246/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647f02e651df279f12f5de4c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647f02e651df279f12f5de55
        failing since 52 days (last pass: v5.10.176-cip30, first fail: v5.1=
0.177-cip31)

    2023-06-06T09:56:47.418082  + set +x

    2023-06-06T09:56:47.425006  <8>[   14.644593] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10603979_1.4.2.3.1>

    2023-06-06T09:56:47.532533  / # #

    2023-06-06T09:56:47.634738  export SHELL=3D/bin/sh

    2023-06-06T09:56:47.635493  #

    2023-06-06T09:56:47.737091  / # export SHELL=3D/bin/sh. /lava-10603979/=
environment

    2023-06-06T09:56:47.737887  =


    2023-06-06T09:56:47.839401  / # . /lava-10603979/environment/lava-10603=
979/bin/lava-test-runner /lava-10603979/1

    2023-06-06T09:56:47.840622  =


    2023-06-06T09:56:47.845534  / # /lava-10603979/bin/lava-test-runner /la=
va-10603979/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647f02e96dafa79179f5de73

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647f02e96dafa79179f5de7c
        failing since 52 days (last pass: v5.10.176-cip30, first fail: v5.1=
0.177-cip31)

    2023-06-06T09:56:42.803180  + set +x<8>[   12.558638] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10603933_1.4.2.3.1>

    2023-06-06T09:56:42.803287  =


    2023-06-06T09:56:42.905120  #

    2023-06-06T09:56:42.905404  =


    2023-06-06T09:56:43.005999  / # #export SHELL=3D/bin/sh

    2023-06-06T09:56:43.006183  =


    2023-06-06T09:56:43.106682  / # export SHELL=3D/bin/sh. /lava-10603933/=
environment

    2023-06-06T09:56:43.106898  =


    2023-06-06T09:56:43.207477  / # . /lava-10603933/environment/lava-10603=
933/bin/lava-test-runner /lava-10603933/1

    2023-06-06T09:56:43.207809  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647f051866bfc34e2bf5de86

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647f051866bfc34e2bf5de8f
        failing since 143 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-06T10:06:10.694568  / # #

    2023-06-06T10:06:10.796797  export SHELL=3D/bin/sh

    2023-06-06T10:06:10.797036  #

    2023-06-06T10:06:10.897856  / # export SHELL=3D/bin/sh. /lava-10604079/=
environment

    2023-06-06T10:06:10.898153  =


    2023-06-06T10:06:10.999245  / # . /lava-10604079/environment/lava-10604=
079/bin/lava-test-runner /lava-10604079/1

    2023-06-06T10:06:11.000471  =


    2023-06-06T10:06:11.044026  / # /lava-10604079/bin/lava-test-runner /la=
va-10604079/1

    2023-06-06T10:06:11.114442  + export 'TESTRUN_ID=3D1_bootrr'

    2023-06-06T10:06:11.114942  + cd /lava-10604079/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647f0525c52b4638d0f5de5d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/bas=
eline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/bas=
eline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647f0525c52b4638d0f5de66
        failing since 143 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-06T10:06:21.805634  + set +x
    2023-06-06T10:06:21.805879  [   10.310536] <LAVA_SIGNAL_ENDRUN 0_dmesg =
968849_1.5.2.3.1>
    2023-06-06T10:06:21.914230  / # #
    2023-06-06T10:06:22.015915  export SHELL=3D/bin/sh
    2023-06-06T10:06:22.016501  #
    2023-06-06T10:06:22.117903  / # export SHELL=3D/bin/sh. /lava-968849/en=
vironment
    2023-06-06T10:06:22.118551  =

    2023-06-06T10:06:22.219854  / # . /lava-968849/environment/lava-968849/=
bin/lava-test-runner /lava-968849/1
    2023-06-06T10:06:22.220471  =

    2023-06-06T10:06:22.223472  / # /lava-968849/bin/lava-test-runner /lava=
-968849/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647f04e9f975f079d3f5df93

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/base=
line-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/base=
line-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647f04e9f975f079d3f5df9c
        failing since 143 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-06T10:05:22.699816  + set[    7.170368] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 968842_1.5.2.3.1>
    2023-06-06T10:05:22.699983   +x
    2023-06-06T10:05:22.805025  / # #
    2023-06-06T10:05:22.906558  export SHELL=3D/bin/sh
    2023-06-06T10:05:22.907037  #
    2023-06-06T10:05:23.008245  / # export SHELL=3D/bin/sh. /lava-968842/en=
vironment
    2023-06-06T10:05:23.008777  =

    2023-06-06T10:05:23.110119  / # . /lava-968842/environment/lava-968842/=
bin/lava-test-runner /lava-968842/1
    2023-06-06T10:05:23.110751  =

    2023-06-06T10:05:23.113224  / # /lava-968842/bin/lava-test-runner /lava=
-968842/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647f05321204bc7352f5de42

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx=
7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx=
7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647f05321204bc7352f5de49
        failing since 143 days (last pass: v5.10.155-cip21, first fail: v5.=
10.162-cip24)

    2023-06-06T10:06:20.686799  / # #
    2023-06-06T10:06:21.845954  export SHELL=3D/bin/sh
    2023-06-06T10:06:21.851587  #
    2023-06-06T10:06:23.397465  / # export SHELL=3D/bin/sh. /lava-1234253/e=
nvironment
    2023-06-06T10:06:23.403158  =

    2023-06-06T10:06:26.224878  / # . /lava-1234253/environment/lava-123425=
3/bin/lava-test-runner /lava-1234253/1
    2023-06-06T10:06:26.231007  =

    2023-06-06T10:06:26.240107  / # /lava-1234253/bin/lava-test-runner /lav=
a-1234253/1
    2023-06-06T10:06:26.330437  + export 'TESTRUN_ID=3D1_bootrr'
    2023-06-06T10:06:26.330851  + cd /lava-1234253/1/tests/1_bootrr =

    ... (18 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7ulp-evk                  | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647f0567461cf7a3baf5de35

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx=
7ulp-evk.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx=
7ulp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647f0567461cf7a3baf5de3c
        failing since 84 days (last pass: v5.10.155-cip21, first fail: v5.1=
0.173-cip28)

    2023-06-06T10:07:16.311281  + set +x<8>[   28.990698] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 1234254_1.5.2.4.1>
    2023-06-06T10:07:16.311421  =

    2023-06-06T10:07:16.419045  / # #
    2023-06-06T10:07:17.578652  export SHELL=3D/bin/sh
    2023-06-06T10:07:17.584347  #
    2023-06-06T10:07:17.584670  / # export SHELL=3D/bin/sh
    2023-06-06T10:07:19.132189  / # . /lava-1234254/environment
    2023-06-06T10:07:21.957459  /lava-1234254/bin/lava-test-runner /lava-12=
34254/1
    2023-06-06T10:07:21.963414  . /lava-1234254/environment
    2023-06-06T10:07:21.963669  / # /lava-1234254/bin/lava-test-runner /lav=
a-1234254/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/647f0439fb94946aaaf5de70

  Results:     28 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/arm64/defconfig+arm64-chromebook/gcc-10/lab-collab=
ora/baseline-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/arm64/defconfig+arm64-chromebook/gcc-10/lab-collab=
ora/baseline-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647f043afb94946aaaf5de90
        failing since 143 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-06T10:02:14.695650  + set +x

    2023-06-06T10:02:14.700874  <8>[   15.686032] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10604008_1.5.2.3.1>

    2023-06-06T10:02:14.805639  #

    2023-06-06T10:02:14.906380  / # #export SHELL=3D/bin/sh

    2023-06-06T10:02:14.906573  =


    2023-06-06T10:02:15.007106  / # export SHELL=3D/bin/sh. /lava-10604008/=
environment

    2023-06-06T10:02:15.007279  =


    2023-06-06T10:02:15.107813  / # . /lava-10604008/environment/lava-10604=
008/bin/lava-test-runner /lava-10604008/1

    2023-06-06T10:02:15.108091  =


    2023-06-06T10:02:15.110311  / # /lava-10604008/bin/lava-test-runner /la=
va-10604008/1
 =

    ... (16 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647f02f37b62f5e7aef5de25

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a=
7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a=
7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647f02f37b62f5e7aef5d=
e26
        failing since 0 day (last pass: v5.10.180-cip34, first fail: v5.10.=
180-cip34-19-gf0f6960f132cd) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 4          =


  Details:     https://kernelci.org/test/plan/id/647f050766bfc34e2bf5de29

  Results:     63 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-i2c-present: https://kernelci.or=
g/test/case/id/647f050766bfc34e2bf5de5c
        failing since 141 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-06T10:06:25.193554   INC default to 1.

    2023-06-06T10:06:25.193780  =


    2023-06-06T10:06:25.197347  	-w	Pad to last with leading zeros

    2023-06-06T10:06:25.199705  	-s SEP	String separator

    2023-06-06T10:06:25.203642  /lava-10604082/1/../bin/lava-test-case

    2023-06-06T10:06:25.209723  BusyBox v1.31.1 (2023-05-27 14:14:16 UTC) m=
ulti-call binary.

    2023-06-06T10:06:25.209953  =

   =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/647f050766bfc34e2bf5de5d
        failing since 141 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-06T10:06:25.167621  BusyBox v1.31.1 (2023-05-27 14:14:16 UTC)<8=
>[   20.915330] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-06-06T10:06:25.169671   multi-call binary.

    2023-06-06T10:06:25.169726  =


    2023-06-06T10:06:25.174229  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-06-06T10:06:25.174285  =


    2023-06-06T10:06:25.179307  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-06-06T10:06:25.189825  FIRST,<8>[   20.934294] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/647f050766bfc34e2bf5de5e
        failing since 141 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-06T10:06:25.148456  <8>[   20.897281] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647f050766bfc34e2bf5de72
        failing since 141 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-06T10:06:13.084894  <8>[    8.833525] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-06-06T10:06:13.094421  + <8>[    8.846041] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10604082_1.5.2.3.1>

    2023-06-06T10:06:13.097390  set +x

    2023-06-06T10:06:13.201994  =


    2023-06-06T10:06:13.303526  / # #export SHELL=3D/bin/sh

    2023-06-06T10:06:13.304218  =


    2023-06-06T10:06:13.405535  / # export SHELL=3D/bin/sh. /lava-10604082/=
environment

    2023-06-06T10:06:13.406039  =


    2023-06-06T10:06:13.507060  / # . /lava-10604082/environment/lava-10604=
082/bin/lava-test-runner /lava-10604082/1

    2023-06-06T10:06:13.507530  =

 =

    ... (19 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/647f04432893927b91f5de79

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/arm64/defconfig+arm64-chromebook/gcc-10/lab-collab=
ora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/arm64/defconfig+arm64-chromebook/gcc-10/lab-collab=
ora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/647f04432893927b91f5de83
        failing since 76 days (last pass: v5.10.173-cip28, first fail: v5.1=
0.175-cip29)

    2023-06-06T10:02:38.330950  <8>[   34.373583] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-06-06T10:02:39.356814  /lava-10604020/1/../bin/lava-test-case

    2023-06-06T10:02:39.367881  <8>[   35.410361] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/647f04432893927b91f5de84
        failing since 76 days (last pass: v5.10.173-cip28, first fail: v5.1=
0.175-cip29)

    2023-06-06T10:02:38.320104  /lava-10604020/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/647f02928ff829ad4ff5dee7

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i=
-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i=
-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647f02928ff829ad4ff5df17
        failing since 143 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-06T09:55:13.782202  + set +x
    2023-06-06T09:55:13.786214  <8>[   17.075402] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 568584_1.5.2.4.1>
    2023-06-06T09:55:13.896589  / # #
    2023-06-06T09:55:13.999152  export SHELL=3D/bin/sh
    2023-06-06T09:55:13.999811  #
    2023-06-06T09:55:14.101639  / # export SHELL=3D/bin/sh. /lava-568584/en=
vironment
    2023-06-06T09:55:14.102319  =

    2023-06-06T09:55:14.204145  / # . /lava-568584/environment/lava-568584/=
bin/lava-test-runner /lava-568584/1
    2023-06-06T09:55:14.204995  =

    2023-06-06T09:55:14.209214  / # /lava-568584/bin/lava-test-runner /lava=
-568584/1 =

    ... (12 line(s) more)  =

 =20

