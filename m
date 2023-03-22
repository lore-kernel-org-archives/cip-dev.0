Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E743C6FD1F
	for <webhook@archiver.kernel.org>; Wed, 22 Mar 2023 08:03:02 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web11.37328.1679472178277863460
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 22 Mar 2023 01:02:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=Xjai0kTm;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.171, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f171.google.com with SMTP id k2so18539099pll.8
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 22 Mar 2023 01:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1679472177;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zYTsQNWCA8ynI6igjNgnBmE/g7cGBVLoYeqy58D6h24=;
        b=Xjai0kTm5hXcbknjVK+pnvwJep1iashluiUHIBR9aaJS2SDk/p2XjSrBf8akk/z+lB
         XLURx4JAOJrqnBEufLMlnybRbv6/hCJBt56I/Ff5zYDa2SQzxH0WhXpU1ETZjW+rnWua
         wC5/MAiSb/tbm3UyF5OugqszwO1HdWv30D+aytJqgJXYy4bgb5gcllUu02Xrg2Byfzby
         TTOpSkfE4rRxLuDDQ6S0fattEcl6Y+XGwnHd2TUDb9fgDOHqkzZr6IwazS0iTIduCbg6
         s7dAX4vBCVIcVJwiIskL8oB1Nnw3cbpS+eizWg+p5qNrnLpjT9rNbxfqzMXFBSEZpu0I
         iBGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679472177;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zYTsQNWCA8ynI6igjNgnBmE/g7cGBVLoYeqy58D6h24=;
        b=39cYxADiVCbMHwPBHrX7eX5LHSuBJs3+r5tCF32onkB6jQtH6XDCnlDGzIbB6PE5XE
         AqC7Pu1SavGgElaTRylHahP+/tYpaVguJ7v8nXOrWrMN7ZJX4aExTtlRUaKmNbt//pbm
         fdWR12xRPl1eFzFFuwOM4SOSE5xdz59Rj+yNIqqs1kJfWhkwvdwjQLmEMR5XsbqqIL0Z
         LiE30Dvbo4EwEwC27NukxmirrXledTKZWE3tfoKbKfLaphDmesLYCsdtCPxH74E+xvEd
         L1fE6HBzerG6Qn2WdBLvXAyC8FKoGih5RJgOZRUYT5kxrKektj3xhslABmq+VKcLxNOu
         k+GA==
X-Gm-Message-State: AO0yUKVKOSIVNzNPaXoTSi8mUJ7HgFPtsWxOhoWkDBJNig4w40ziPOEj
	ziUK1GRKvg9/GiU6/wtv7dj8v5My2UyVenfK1/Q=
X-Google-Smtp-Source: AK7set9+7dWnG5OWl8fvwcvTug8KIIzP+s7W4Cuiek1Gk2aUyPoW4wu3OpNQjjm+zPZK1bzeD+GVhA==
X-Received: by 2002:a17:903:686:b0:19c:c87b:4740 with SMTP id ki6-20020a170903068600b0019cc87b4740mr1743740plb.34.1679472176397;
        Wed, 22 Mar 2023 01:02:56 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q23-20020a170902b11700b0019edc1b421asm6336615plr.163.2023.03.22.01.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 01:02:56 -0700 (PDT)
Message-ID: <641ab630.170a0220.c6314.b32a@mx.google.com>
Date: Wed, 22 Mar 2023 01:02:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.175-cip29
Subject: cip/linux-5.10.y-cip baseline: 120 runs,
 30 regressions (v5.10.175-cip29)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Mar 2023 08:03:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11048

cip/linux-5.10.y-cip baseline: 120 runs, 30 regressions (v5.10.175-cip29)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =

dell-latitude...4305U-sarien | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

dell-latitude...8665U-sarien | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

fsl-ls1028a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

fsl-ls1088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

fsl-lx2160a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

imx6ul-14x14-evk             | arm    | lab-nxp         | gcc-10   | multi_=
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

tegra124-nyan-big            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.175-cip29/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.175-cip29
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      bb7267e6d2a6f131bb46ba14f0d3c418379e8bd4 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641aa84a8ca70bc49a9c950a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641aa84a8ca70bc49a9c9513
        failing since 67 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-22T07:03:15.674247  <8>[   11.813328] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9726665_1.4.2.3.1>

    2023-03-22T07:03:15.677345  + set +x

    2023-03-22T07:03:15.779111  #

    2023-03-22T07:03:15.880395  / # #export SHELL=3D/bin/sh

    2023-03-22T07:03:15.880636  =


    2023-03-22T07:03:15.981387  / # export SHELL=3D/bin/sh. /lava-9726665/e=
nvironment

    2023-03-22T07:03:15.981613  =


    2023-03-22T07:03:16.082521  / # . /lava-9726665/environment/lava-972666=
5/bin/lava-test-runner /lava-9726665/1

    2023-03-22T07:03:16.082842  =


    2023-03-22T07:03:16.087256  / # /lava-9726665/bin/lava-test-runner /lav=
a-9726665/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641aa94e16cd3fd3449c9524

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/641aa94e16cd3fd3449c9=
525
        new failure (last pass: v5.10.173-cip28) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641aa94e9b61cebbf69c950b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/641aa94e9b61cebbf69c9=
50c
        new failure (last pass: v5.10.173-cip28) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641aa84adbf2a457b19c9550

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641aa84adbf2a457b19c9559
        failing since 67 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-22T07:03:25.992713  + set +x

    2023-03-22T07:03:25.998503  <8>[   12.146757] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9726681_1.4.2.3.1>

    2023-03-22T07:03:26.108165  / # #

    2023-03-22T07:03:26.211151  export SHELL=3D/bin/sh

    2023-03-22T07:03:26.212048  #

    2023-03-22T07:03:26.314098  / # export SHELL=3D/bin/sh. /lava-9726681/e=
nvironment

    2023-03-22T07:03:26.315112  =


    2023-03-22T07:03:26.417119  / # . /lava-9726681/environment/lava-972668=
1/bin/lava-test-runner /lava-9726681/1

    2023-03-22T07:03:26.418419  =


    2023-03-22T07:03:26.418865  / # /lava-9726681/bin/lava-test-runner /lav=
a-9726681/1<4>[   12.563680] i2c_designware i2c_designware.5: timeout in di=
sabling adapter
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641aa94ec64b7112b29c9555

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/641aa94ec64b7112b29c9=
556
        new failure (last pass: v5.10.173-cip28) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/641aaa38a300f9e8849c950b

  Results:     47 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641aaa38a300f9e8849c9544
        failing since 67 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-22T07:11:18.848079  + set +x
    2023-03-22T07:11:18.853326  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 205606_1.5.2=
.4.1>
    2023-03-22T07:11:18.967349  / # #
    2023-03-22T07:11:19.069965  export SHELL=3D/bin/sh
    2023-03-22T07:11:19.070738  #
    2023-03-22T07:11:19.172367  / # export SHELL=3D/bin/sh. /lava-205606/en=
vironment
    2023-03-22T07:11:19.173135  =

    2023-03-22T07:11:19.275097  / # . /lava-205606/environment/lava-205606/=
bin/lava-test-runner /lava-205606/1
    2023-03-22T07:11:19.276315  =

    2023-03-22T07:11:19.282853  / # /lava-205606/bin/lava-test-runner /lava=
-205606/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/641aafb4560885d7c39c9649

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641aafb4560885d7c39c967a
        failing since 67 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-22T07:34:44.038097  <8>[   18.517410] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 205713_1.5.2.4.1>
    2023-03-22T07:34:44.148890  / # #
    2023-03-22T07:34:44.251848  export SHELL=3D/bin/sh
    2023-03-22T07:34:44.252534  #
    2023-03-22T07:34:44.354373  / # export SHELL=3D/bin/sh. /lava-205713/en=
vironment
    2023-03-22T07:34:44.355270  =

    2023-03-22T07:34:44.457952  / # . /lava-205713/environment/lava-205713/=
bin/lava-test-runner /lava-205713/1
    2023-03-22T07:34:44.459153  =

    2023-03-22T07:34:44.463965  / # /lava-205713/bin/lava-test-runner /lava=
-205713/1
    2023-03-22T07:34:44.561565  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/641aab1903a75b71859c958b

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641aab1903a75b71859c95c5
        failing since 67 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-22T07:15:23.902237  <8>[   19.794903] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 205634_1.5.2.4.1>
    2023-03-22T07:15:24.012844  / # #
    2023-03-22T07:15:24.115937  export SHELL=3D/bin/sh
    2023-03-22T07:15:24.116493  #
    2023-03-22T07:15:24.218541  / # export SHELL=3D/bin/sh. /lava-205634/en=
vironment
    2023-03-22T07:15:24.219100  =

    2023-03-22T07:15:24.321405  / # . /lava-205634/environment/lava-205634/=
bin/lava-test-runner /lava-205634/1
    2023-03-22T07:15:24.322581  =

    2023-03-22T07:15:24.326515  / # /lava-205634/bin/lava-test-runner /lava=
-205634/1
    2023-03-22T07:15:24.431318  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
dell-latitude...4305U-sarien | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641aa94f88a3a12cd49c9505

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-dell-latitude-5400-4305U-sarien.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-dell-latitude-5400-4305U-sarien.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/641aa94f88a3a12cd49c9=
506
        new failure (last pass: v5.10.173-cip28) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
dell-latitude...8665U-sarien | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641aa94cdf2fc69cd59c953c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-dell-latitude-5400-8665U-sarien.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-dell-latitude-5400-8665U-sarien.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/641aa94cdf2fc69cd59c9=
53d
        new failure (last pass: v5.10.173-cip28) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls1028a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/641aaddab09f210c669c951e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1028a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1028a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641aaddab09f210c669c9527
        failing since 8 days (last pass: v5.10.155-cip21, first fail: v5.10=
.173-cip28)

    2023-03-22T07:27:02.085439  [   21.027032] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1181473_1.5.2.4.1>
    2023-03-22T07:27:02.193006  / # #
    2023-03-22T07:27:02.294820  export SHELL=3D/bin/sh
    2023-03-22T07:27:02.295289  #
    2023-03-22T07:27:02.396638  / # export SHELL=3D/bin/sh. /lava-1181473/e=
nvironment
    2023-03-22T07:27:02.397080  =

    2023-03-22T07:27:02.498450  / # . /lava-1181473/environment/lava-118147=
3/bin/lava-test-runner /lava-1181473/1
    2023-03-22T07:27:02.499196  =

    2023-03-22T07:27:02.501246  / # /lava-1181473/bin/lava-test-runner /lav=
a-1181473/1
    2023-03-22T07:27:02.521174  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls1088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/641aadddb09f210c669c9529

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1088a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641aadddb09f210c669c9532
        failing since 67 days (last pass: v5.10.155-cip21, first fail: v5.1=
0.162-cip24)

    2023-03-22T07:27:01.737996  [   10.536854] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1181476_1.5.2.4.1>
    2023-03-22T07:27:01.845315  / # #
    2023-03-22T07:27:01.947309  export SHELL=3D/bin/sh
    2023-03-22T07:27:01.947850  #
    2023-03-22T07:27:02.049271  / # export SHELL=3D/bin/sh. /lava-1181476/e=
nvironment
    2023-03-22T07:27:02.049872  =

    2023-03-22T07:27:02.151402  / # . /lava-1181476/environment/lava-118147=
6/bin/lava-test-runner /lava-1181476/1
    2023-03-22T07:27:02.152173  =

    2023-03-22T07:27:02.154130  / # /lava-1181476/bin/lava-test-runner /lav=
a-1181476/1
    2023-03-22T07:27:02.172308  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-lx2160a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/641aadef775b0287869c9523

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641aadef775b0287869c952c
        new failure (last pass: v5.10.154-cip20)

    2023-03-22T07:27:26.993952  [   15.247854] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1181474_1.5.2.4.1>
    2023-03-22T07:27:27.099727  / # #
    2023-03-22T07:27:27.201621  export SHELL=3D/bin/sh
    2023-03-22T07:27:27.202134  #
    2023-03-22T07:27:27.303281  / # export SHELL=3D/bin/sh. /lava-1181474/e=
nvironment
    2023-03-22T07:27:27.303644  =

    2023-03-22T07:27:27.404755  / # . /lava-1181474/environment/lava-118147=
4/bin/lava-test-runner /lava-1181474/1
    2023-03-22T07:27:27.405292  =

    2023-03-22T07:27:27.407081  / # /lava-1181474/bin/lava-test-runner /lav=
a-1181474/1
    2023-03-22T07:27:27.425473  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641aaa7a0f8d8d8e149c950d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/641aaa7a0f8d8d8e149c9=
50e
        new failure (last pass: v5.10.173-cip28) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/641aaf7e5733b26db89c9634

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641aaf7e5733b26db89c963d
        failing since 67 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-22T07:34:11.516560  / # #

    2023-03-22T07:34:11.618783  export SHELL=3D/bin/sh

    2023-03-22T07:34:11.619684  #

    2023-03-22T07:34:11.721926  / # export SHELL=3D/bin/sh. /lava-9726920/e=
nvironment

    2023-03-22T07:34:11.722736  =


    2023-03-22T07:34:11.824869  / # . /lava-9726920/environment/lava-972692=
0/bin/lava-test-runner /lava-9726920/1

    2023-03-22T07:34:11.826173  =


    2023-03-22T07:34:11.838834  / # /lava-9726920/bin/lava-test-runner /lav=
a-9726920/1

    2023-03-22T07:34:11.930742  + export 'TESTRUN_ID=3D1_bootrr'

    2023-03-22T07:34:11.931319  + cd /lava-9726920/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/641aabfcd76d18b69b9c9505

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandb=
oard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandb=
oard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641aabfcd76d18b69b9c950e
        failing since 67 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-22T07:18:58.912124  + set +x
    2023-03-22T07:18:58.912303  [   11.969433] <LAVA_SIGNAL_ENDRUN 0_dmesg =
921688_1.5.2.3.1>
    2023-03-22T07:18:59.020752  / # #
    2023-03-22T07:18:59.122448  export SHELL=3D/bin/sh
    2023-03-22T07:18:59.122952  #
    2023-03-22T07:18:59.224192  / # export SHELL=3D/bin/sh. /lava-921688/en=
vironment
    2023-03-22T07:18:59.224744  =

    2023-03-22T07:18:59.326116  / # . /lava-921688/environment/lava-921688/=
bin/lava-test-runner /lava-921688/1
    2023-03-22T07:18:59.326790  =

    2023-03-22T07:18:59.329802  / # /lava-921688/bin/lava-test-runner /lava=
-921688/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/641aaf588fec31595c9c950d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandbo=
ard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandbo=
ard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641aaf588fec31595c9c9516
        failing since 67 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-22T07:33:37.115748  + set[    7.130250] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 921689_1.5.2.3.1>
    2023-03-22T07:33:37.115972   +x
    2023-03-22T07:33:37.221915  / # #
    2023-03-22T07:33:37.323509  export SHELL=3D/bin/sh
    2023-03-22T07:33:37.323973  #
    2023-03-22T07:33:37.425196  / # export SHELL=3D/bin/sh. /lava-921689/en=
vironment
    2023-03-22T07:33:37.425679  =

    2023-03-22T07:33:37.526991  / # . /lava-921689/environment/lava-921689/=
bin/lava-test-runner /lava-921689/1
    2023-03-22T07:33:37.527671  =

    2023-03-22T07:33:37.530052  / # /lava-921689/bin/lava-test-runner /lava=
-921689/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6ul-14x14-evk             | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/641aafe69c456d7c8d9c9547

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx6ul-14x14-evk.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx6ul-14x14-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641aafe69c456d7c8d9c9550
        new failure (last pass: v5.10.145-cip17)

    2023-03-22T07:34:54.550229  + set +x
    2023-03-22T07:34:54.551353  <8>[   29.698566] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1181480_1.5.2.4.1>
    2023-03-22T07:34:54.661073  =

    2023-03-22T07:34:55.820882  / # #export SHELL=3D/bin/sh
    2023-03-22T07:34:55.826377  =

    2023-03-22T07:34:57.373775  / # export SHELL=3D/bin/sh. /lava-1181480/e=
nvironment
    2023-03-22T07:34:57.379456  =

    2023-03-22T07:34:57.379749  / # . /lava-1181480/environment
    2023-03-22T07:35:00.201638  /lava-1181480/bin/lava-test-runner /lava-11=
81480/1
    2023-03-22T07:35:00.207647  / # /lava-1181480/bin/lava-test-runner /lav=
a-1181480/1 =

    ... (18 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/641aafe9bbbe09589e9c9513

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641aafe9bbbe09589e9c951c
        failing since 67 days (last pass: v5.10.155-cip21, first fail: v5.1=
0.162-cip24)

    2023-03-22T07:34:50.022173  + set<8>[   17.066745] <LAVA_SIGNAL_ENDRUN =
0_dmesg 1181481_1.5.2.4.1>
    2023-03-22T07:34:50.022418   +x
    2023-03-22T07:34:50.128026  / # #
    2023-03-22T07:34:51.288085  export SHELL=3D/bin/sh
    2023-03-22T07:34:51.293767  #
    2023-03-22T07:34:52.841612  / # export SHELL=3D/bin/sh. /lava-1181481/e=
nvironment
    2023-03-22T07:34:52.847326  =

    2023-03-22T07:34:55.669824  / # . /lava-1181481/environment/lava-118148=
1/bin/lava-test-runner /lava-1181481/1
    2023-03-22T07:34:55.676113  =

    2023-03-22T07:34:55.681979  / # /lava-1181481/bin/lava-test-runner /lav=
a-1181481/1 =

    ... (20 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7ulp-evk                  | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/641aafe2bbbe09589e9c9505

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7ulp-evk.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7ulp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641aafe2bbbe09589e9c950e
        failing since 8 days (last pass: v5.10.155-cip21, first fail: v5.10=
.173-cip28)

    2023-03-22T07:35:15.023253  + set +x<8>[   28.988879] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 1181479_1.5.2.4.1>
    2023-03-22T07:35:15.023564  =

    2023-03-22T07:35:15.132644  / # #
    2023-03-22T07:35:16.292979  export SHELL=3D/bin/sh
    2023-03-22T07:35:16.298684  #
    2023-03-22T07:35:16.299064  / # export SHELL=3D/bin/sh
    2023-03-22T07:35:17.847084  / # . /lava-1181479/environment
    2023-03-22T07:35:20.675184  /lava-1181479/bin/lava-test-runner /lava-11=
81479/1
    2023-03-22T07:35:20.681258  . /lava-1181479/environment
    2023-03-22T07:35:20.681558  / # /lava-1181479/bin/lava-test-runner /lav=
a-1181479/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/641aac8196bb4a250c9c95e7

  Results:     28 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt817=
3-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt817=
3-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641aac8196bb4a250c9c9607
        failing since 67 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-22T07:21:31.666943  + set +x

    2023-03-22T07:21:31.671925  <8>[   15.678447] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9726860_1.5.2.3.1>

    2023-03-22T07:21:31.780912  / #

    2023-03-22T07:21:31.884264  # #export SHELL=3D/bin/sh

    2023-03-22T07:21:31.885093  =


    2023-03-22T07:21:31.987050  / # export SHELL=3D/bin/sh. /lava-9726860/e=
nvironment

    2023-03-22T07:21:31.987876  =


    2023-03-22T07:21:32.089915  / # . /lava-9726860/environment/lava-972686=
0/bin/lava-test-runner /lava-9726860/1

    2023-03-22T07:21:32.091172  =


    2023-03-22T07:21:32.093294  / # /lava-9726860/bin/lava-test-runner /lav=
a-9726860/1
 =

    ... (16 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/641aaa5f3a2dad33dd9c950d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/641aaa5f3a2dad33dd9c9=
50e
        failing since 25 days (last pass: v5.10.167-cip26-2-g1e87e7748b91, =
first fail: v5.10.168-cip27) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 4          =


  Details:     https://kernelci.org/test/plan/id/641aaf94560885d7c39c9523

  Results:     63 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-j=
aq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-j=
aq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-i2c-present: https://kernelci.or=
g/test/case/id/641aaf94560885d7c39c9556
        failing since 65 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-22T07:34:17.567223   INC default to 1.

    2023-03-22T07:34:17.567467  =


    2023-03-22T07:34:17.570675  	-w	Pad to last with leading zeros

    2023-03-22T07:34:17.573134  	-s SEP	String separator

    2023-03-22T07:34:17.576809  /lava-9726922/1/../bin/lava-test-case

    2023-03-22T07:34:17.583193  BusyBox v1.31.1 (2023-03-10 17:51:43 UTC) m=
ulti-call binary.

    2023-03-22T07:34:17.583425  =


    2023-03-22T07:34:17.593597  Usage<8>[   20.897244] <LAVA_SIGNAL_TESTCAS=
E TEST_CASE_ID=3Ddwhdmi-rockchip-driver-i2c-present RESULT=3Dfail>
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/641aaf94560885d7c39c9557
        failing since 65 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-22T07:34:17.543437  BusyBox v1.31.1 (2023-03-10 17:51:43 UTC)<8=
>[   20.849333] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-03-22T07:34:17.544673   multi-call binary.

    2023-03-22T07:34:17.545175  =


    2023-03-22T07:34:17.549100  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-03-22T07:34:17.549587  =


    2023-03-22T07:34:17.554698  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-03-22T07:34:17.564827  FIRST,<8>[   20.868298] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/641aaf94560885d7c39c9558
        failing since 65 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24) =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641aaf94560885d7c39c956c
        failing since 65 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-22T07:34:05.458954  <8>[    8.765925] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-03-22T07:34:05.469050  + <8>[    8.778331] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 9726922_1.5.2.3.1>

    2023-03-22T07:34:05.469255  set +x

    2023-03-22T07:34:05.576510  =


    2023-03-22T07:34:05.678076  / # #export SHELL=3D/bin/sh

    2023-03-22T07:34:05.678711  =


    2023-03-22T07:34:05.678949  / # <6>[    8.938808] sbs-battery 20-000b: =
Disabling PEC because of broken Cros-EC implementation

    2023-03-22T07:34:05.679163  export SHELL=3D/bin/sh<4>[    8.975049] sbs=
-battery 20-000b: Unknown chemistry: POLY

    2023-03-22T07:34:05.780494  . /lava-9726922/environment

    2023-03-22T07:34:05.781022  =

 =

    ... (22 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/641aacbdf29b0dde139c95a3

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk339=
9-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk339=
9-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/641aacbdf29b0dde139c95ad
        new failure (last pass: v5.10.173-cip28)

    2023-03-22T07:22:20.301159  <8>[   61.078957] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-03-22T07:22:21.326769  /lava-9726864/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/641aacbdf29b0dde139c95ae
        new failure (last pass: v5.10.173-cip28)

    2023-03-22T07:22:19.268215  <8>[   60.045268] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-03-22T07:22:20.289496  /lava-9726864/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/641aae5f0eae2c9bd59c9507

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641aae5f0eae2c9bd59c9534
        failing since 67 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-22T07:29:05.552794  + set +x
    2023-03-22T07:29:05.556779  <8>[   17.038463] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 205683_1.5.2.4.1>
    2023-03-22T07:29:05.667973  / # #
    2023-03-22T07:29:05.771497  export SHELL=3D/bin/sh
    2023-03-22T07:29:05.772237  #
    2023-03-22T07:29:05.874288  / # export SHELL=3D/bin/sh. /lava-205683/en=
vironment
    2023-03-22T07:29:05.875036  =

    2023-03-22T07:29:05.977201  / # . /lava-205683/environment/lava-205683/=
bin/lava-test-runner /lava-205683/1
    2023-03-22T07:29:05.978429  =

    2023-03-22T07:29:05.981873  / # /lava-205683/bin/lava-test-runner /lava=
-205683/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
tegra124-nyan-big            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/641ab1c41b6b97f36f9c9521

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-tegra124-nyan-b=
ig.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-tegra124-nyan-b=
ig.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641ab1c41b6b97f36f9c952a
        failing since 65 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-22T07:43:35.704924  <8>[   17.447099] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-03-22T07:43:35.705822  + set +x

    2023-03-22T07:43:35.713312  <8>[   17.457492] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9726927_1.5.2.3.1>

    2023-03-22T07:43:35.819762  #

    2023-03-22T07:43:35.821124  =


    2023-03-22T07:43:35.923647  / # #export SHELL=3D/bin/sh

    2023-03-22T07:43:35.924558  =


    2023-03-22T07:43:36.026643  / # export SHELL=3D/bin/sh. /lava-9726927/e=
nvironment

    2023-03-22T07:43:36.027569  =


    2023-03-22T07:43:36.129773  / # . /lava-9726927/environment/lava-972692=
7/bin/lava-test-runner /lava-9726927/1
 =

    ... (17 line(s) more)  =

 =20

