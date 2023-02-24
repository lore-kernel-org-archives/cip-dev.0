Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C64C678DB
	for <webhook@archiver.kernel.org>; Fri, 24 Feb 2023 11:01:29 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.web10.15041.1677236488133192313
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 24 Feb 2023 03:01:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=mVAS6Ebx;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.50, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f50.google.com with SMTP id gi3-20020a17090b110300b0023762f642dcso2290096pjb.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 24 Feb 2023 03:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dTCZ1cq1tA9eNU2KY9sUQzdI3jxPVwPNUipEm5cRPW8=;
        b=mVAS6EbxKUufaDROF/i/u/B+I5hwnKn5hLiGVm6d/Ssr/nCnEk7U57wdeVyrzYzEcN
         ZaIH+X8JQ+4RauT6UkrnSnM/7PBmHie8o+p6xS0V7INaoCbEods2nuNfR2f6zSchIifi
         Z04thV5WiN7z2AD5ID8FCdXeKCzRmmu0AcDSa236j1clal1Bfs3cImvqvYRh2Gmr2w+F
         BLHMywF9geyD7WKXcpORd20pA/+cKLclkh6Xzmnbs+ULOz3h42D/jUXaIuaENWVQOoxH
         FfN3ZEEu0yaNwjfcCo6FkX2qTYdp9Kaf25z4FptEgwMAB6FnfCxsameAvVo/bd3+eeo9
         83cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dTCZ1cq1tA9eNU2KY9sUQzdI3jxPVwPNUipEm5cRPW8=;
        b=1l1z4HUlPlMcNMq7+VweAszyOF6RRE66nd7fLVPZ3wacLq+RVJ0UuZcGZBj5VfWhOw
         vTQyxbi2ZuEN8E6bFA+NPNFcW4jyxhLp4jf5RdZv4dW6FnuoDjY6T3IwDgurkfq++5sE
         loKbKzW7CMDGwsXln/DETLIB1oa2xjg7likKuz/bHh1tceGxR4C7tGY6MFAebbScCIgC
         gxMDzXGpCvt3U1FG7KTnz8/Fp4nwHb/cpTKR03geqaXo623pdUzTJsNEa6gF2HDCXiYm
         f7qKo1J17ydFwajQmPhLNXSskJdDSXbp/t0kdRZCX4AQCBb0h74DcxBlZVcObAlVa0K1
         aLXA==
X-Gm-Message-State: AO0yUKVv4n7FI1T5eWrGE9XxPCuqOsGU6ScgxOhqhT6NsNGPgLaf6QSx
	ELPO60vodLqRw367wmZapZvqBzMTHxI5YkmZeswe2Q==
X-Google-Smtp-Source: AK7set/xYQP1KjA1Jw6ptsfUFrF+pIdoBDTA+UTHSA24zHY10Sy8pcG2OanTQ9wNca7aJlcsZp5hxA==
X-Received: by 2002:a05:6a20:1443:b0:c3:cc65:165c with SMTP id a3-20020a056a20144300b000c3cc65165cmr9394455pzi.61.1677236487176;
        Fri, 24 Feb 2023 03:01:27 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p10-20020a62ab0a000000b005a8ce67874asm8823129pff.86.2023.02.24.03.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 03:01:26 -0800 (PST)
Message-ID: <63f89906.620a0220.cccef.0bd9@mx.google.com>
Date: Fri, 24 Feb 2023 03:01:26 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.168-cip27
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip baseline-nfs: 70 runs,
 13 regressions (v5.10.168-cip27)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Feb 2023 11:01:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10806

cip/linux-5.10.y-cip baseline-nfs: 70 runs, 13 regressions (v5.10.168-cip27)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 5          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.168-cip27/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.168-cip27
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      cc82f737b68c179240070fa34771bcfd0a5fa421 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63f88ab3ff553eea8c8c8657

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230217.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63f88ab3ff553eea8c8c8660
        failing since 41 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-24T10:00:04.565773  + set +x

    2023-02-24T10:00:04.572269  <8>[   17.928435] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9314496_1.5.2.3.1>

    2023-02-24T10:00:04.685831  / # #

    2023-02-24T10:00:04.786877  export SHELL=3D/bin/sh

    2023-02-24T10:00:04.787132  #

    2023-02-24T10:00:04.888137  / # export SHELL=3D/bin/sh. /lava-9314496/e=
nvironment

    2023-02-24T10:00:04.888374  =


    2023-02-24T10:00:04.989283  / # . /lava-9314496/environment/lava-931449=
6/bin/lava-test-runner /lava-9314496/1

    2023-02-24T10:00:04.989649  =


    2023-02-24T10:00:04.995270  / # /lava-9314496/bin/lava-test-runner /lav=
a-9314496/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63f88a949e33489c708c8707

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230217.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63f88a949e33489c708c8710
        failing since 41 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-24T09:59:38.147664  + set +x

    2023-02-24T09:59:38.154573  [   14.223926] <LAVA_SIGNAL_ENDRUN 0_dmesg =
9314499_1.5.2.3.1>

    2023-02-24T09:59:38.259584  [   14.232086] lava-test-runne#

    2023-02-24T09:59:38.259922   (268) used greatest stack depth: 13016 byt=
es left

    2023-02-24T09:59:38.360880  / # #export SHELL=3D/bin/sh

    2023-02-24T09:59:38.361124  =


    2023-02-24T09:59:38.462006  / # export SHELL=3D/bin/sh. /lava-9314499/e=
nvironment

    2023-02-24T09:59:38.462285  =


    2023-02-24T09:59:38.563184  / # . /lava-9314499/environment/lava-931449=
9/bin/lava-test-runner /lava-9314499/1

    2023-02-24T09:59:38.563584  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63f88ac8f8bfd6bbcf8c86ed

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230217.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63f88ac8f8bfd6bbcf8c86f6
        failing since 41 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-24T10:00:21.266466  + set +x

    2023-02-24T10:00:21.272798  <8>[   18.564128] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9314518_1.5.2.3.1>

    2023-02-24T10:00:21.379588  /#

    2023-02-24T10:00:21.480840   # #export SHELL=3D/bin/sh

    2023-02-24T10:00:21.481080  =


    2023-02-24T10:00:21.582083  / # export SHELL=3D/bin/sh. /lava-9314518/e=
nvironment

    2023-02-24T10:00:21.582368  =


    2023-02-24T10:00:21.683277  / # . /lava-9314518/environment/lava-931451=
8/bin/lava-test-runner /lava-9314518/1

    2023-02-24T10:00:21.683625  =


    2023-02-24T10:00:21.685984  / # /lava-9314518/bin/lava-test-runner /lav=
a-9314518/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63f88cd2087bcd62258c866b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-nfs-at91sam9g20ek=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-nfs-at91sam9g20ek=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230217.0/armel/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63f88cd2087bcd62258c8674
        failing since 41 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-24T10:09:11.102977  + set +x
    2023-02-24T10:09:11.235959  #
    2023-02-24T10:09:11.339275  / # #export SHELL=3D/bin/sh
    2023-02-24T10:09:11.340128  =

    2023-02-24T10:09:11.442033  / # export SHELL=3D/bin/sh. /lava-68785/env=
ironment
    2023-02-24T10:09:11.442870  =

    2023-02-24T10:09:11.544931  / # . /lava-68785/environment/lava-68785/bi=
n/lava-test-runner /lava-68785/1
    2023-02-24T10:09:11.546387  =

    2023-02-24T10:09:11.553067  / # /lava-68785/bin/lava-test-runner /lava-=
68785/1
    2023-02-24T10:09:11.949609  + export TESTRUN_ID=3D1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63f892ae01f9fbe8518c86fc

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-bl=
ack.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-bl=
ack.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230217.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63f892ae01f9fbe8518c8705
        failing since 41 days (last pass: v5.10.158-cip22, first fail: v5.1=
0.162-cip24)

    2023-02-24T10:34:16.080375  + set +x
    2023-02-24T10:34:16.084373  <8>[   73.297559] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 68885_1.6.2.4.1>
    2023-02-24T10:34:16.227855  / # #
    2023-02-24T10:34:16.330456  export SHELL=3D/bin/sh
    2023-02-24T10:34:16.331013  #
    2023-02-24T10:34:16.432984  / # export SHELL=3D/bin/sh. /lava-68885/env=
ironment
    2023-02-24T10:34:16.433579  =

    2023-02-24T10:34:16.535418  / # . /lava-68885/environment/lava-68885/bi=
n/lava-test-runner /lava-68885/1
    2023-02-24T10:34:16.536383  =

    2023-02-24T10:34:16.541181  / # /lava-68885/bin/lava-test-runner /lava-=
68885/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63f88d419b6b7754588c862f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-b=
lack.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-b=
lack.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230217.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63f88d419b6b7754588c8638
        failing since 23 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.165-cip25)

    2023-02-24T10:10:54.131763  + set +x
    2023-02-24T10:10:54.135325  [   46.651663] <LAVA_SIGNAL_ENDRUN 0_dmesg =
68828_1.6.2.4.1>
    2023-02-24T10:10:54.278011  / # #
    2023-02-24T10:10:54.380314  export SHELL=3D/bin/sh
    2023-02-24T10:10:54.380951  #
    2023-02-24T10:10:54.482695  / # export SHELL=3D/bin/sh. /lava-68828/env=
ironment
    2023-02-24T10:10:54.483476  =

    2023-02-24T10:10:54.585499  / # . /lava-68828/environment/lava-68828/bi=
n/lava-test-runner /lava-68828/1
    2023-02-24T10:10:54.586621  =

    2023-02-24T10:10:54.590826  /lava-68828/bin/lava-test-runner /lava-6882=
8/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63f89267fc4286d9a78c8632

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-nfs-imx6q-sabre=
lite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-nfs-imx6q-sabre=
lite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230217.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63f89267fc4286d9a78c863b
        failing since 41 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-24T10:33:04.718773  / # #

    2023-02-24T10:33:04.822005  export SHELL=3D/bin/sh

    2023-02-24T10:33:04.822834  #

    2023-02-24T10:33:04.924835  / # export SHELL=3D/bin/sh. /lava-9315284/e=
nvironment

    2023-02-24T10:33:04.925690  =


    2023-02-24T10:33:05.028103  / # . /lava-9315284/environment/lava-931528=
4/bin/lava-test-runner /lava-9315284/1

    2023-02-24T10:33:05.029402  =


    2023-02-24T10:33:05.030973  / # /lava-9315284/bin/lava-test-runner /lav=
a-9315284/1

    2023-02-24T10:33:05.205883  + export TESTRUN_ID=3D1_bootrr

    2023-02-24T10:33:05.206375  + cd /lava-9315284/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63f88f02583d303a348c8779

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-broonie/baseli=
ne-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-broonie/baseli=
ne-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230217.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63f88f02583d303a3=
48c877a
        new failure (last pass: v5.10.167-cip26-2-g1e87e7748b91) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 5          =


  Details:     https://kernelci.org/test/plan/id/63f88bcbd31991f2668c8655

  Results:     86 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-r=
k3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-r=
k3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230217.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/63f88bcbd31991f2668c867b
        failing since 331 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81,=
 first fail: v5.10.106-cip4)

    2023-02-24T10:04:39.350958  /lava-9314672/1/../bin/lava-test-case

    2023-02-24T10:04:39.390361  <8>[   34.641747] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-rt5514-present: https://ker=
nelci.org/test/case/id/63f88bcbd31991f2668c8690
        failing since 41 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-24T10:04:36.769023  seq: invalid floating point argument: =E2=
=80=98sound/RT5514=E2=80=99

    2023-02-24T10:04:36.772828  Try 'seq --help' for more information.

    2023-02-24T10:04:36.776620  /lava-9314672/1/../bin/lava-test-case

    2023-02-24T10:04:36.811170  <8>[   32.061310] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-rt5514-present RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-max98357A-present: https://=
kernelci.org/test/case/id/63f88bcbd31991f2668c8691
        failing since 41 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-24T10:04:36.703713  seq: invalid floating point argument: =E2=
=80=98sound/MAX98357A=E2=80=99

    2023-02-24T10:04:36.707027  Try 'seq --help' for more information.

    2023-02-24T10:04:36.711632  /lava-9314672/1/../bin/lava-test-case

    2023-02-24T10:04:36.738332  <8>[   31.988283] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-max98357A-present RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-dp-present: https://kernelc=
i.org/test/case/id/63f88bcbd31991f2668c8692
        failing since 41 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-24T10:04:36.643023  seq: invalid floating point argument: =E2=
=80=98sound/DP=E2=80=99

    2023-02-24T10:04:36.647227  Try 'seq --help' for more information.

    2023-02-24T10:04:36.650955  /lava-9314672/1/../bin/lava-test-case

    2023-02-24T10:04:36.676364  <8>[   31.926856] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-dp-present RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-da7219-present: https://ker=
nelci.org/test/case/id/63f88bcbd31991f2668c8693
        failing since 41 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-24T10:04:36.554296  <8>[   31.804730] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-present RESULT=3Dpass>

    2023-02-24T10:04:36.578341  seq: invalid floating point argument: =E2=
=80=98sound/DA7219=E2=80=99

    2023-02-24T10:04:36.582069  Try 'seq --help' for more information.

    2023-02-24T10:04:36.586154  /lava-9314672/1/../bin/lava-test-case

    2023-02-24T10:04:36.612658  <8>[   31.862666] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-da7219-present RESULT=3Dfail>
   =

 =20

