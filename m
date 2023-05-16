Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608B7C77B7F
	for <webhook@archiver.kernel.org>; Tue, 16 May 2023 20:41:45 +0000 (UTC)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
 by mx.groups.io with SMTP id smtpd.web11.33403.1684269702983572516
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 16 May 2023 13:41:43 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=TSDv0jXm;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.177, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-643bb9cdd6eso12393348b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 16 May 2023 13:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684269702; x=1686861702;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FVKR9O/kbZr+5Qpj4YvXWfR6rrEjIvuwg0mRlMg8t6w=;
        b=TSDv0jXmR054B3cUbC3eBXLwABmrqCcsXqZTRSOtKt1ww1il7D76A0AmBBNiqj1Q5M
         ewEjYBgbkZkCcFL1X4+d81pJ0nypoOGkMT6BeTvJKEbIPpKQmRiZvQ+uxiY+E1E+C94k
         oI44pWx6r7Cor8knOnltoI8VoHlI24JzYmf54WKxrd1JW+8dgioDBIo5c1ldhTyhKAvN
         0sUqOWoApI5xTjFsP5Mok6vp+1vw1Rk2iVGa/6AbSrBcBWWgIOB8PmZMDSY0cgtcikvF
         y/J3+iCMN4YRPHJdKX3a8LmV67+QRVfSIzzL0O6UQnCte6LL1qPXFqPga5lM1/dp5A//
         bDIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684269702; x=1686861702;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FVKR9O/kbZr+5Qpj4YvXWfR6rrEjIvuwg0mRlMg8t6w=;
        b=GLAk+Gh6qEhkGniJY/4Lr/cM/cigdYjbDE/KAMIIaTmZfvA7k2CGZmPwfli7sg4DP2
         e3+dhAju/vBj3rF+EcM2ADCdCbVKDpX1HXKyvtA/PEhp/FHDHVczCDdMHmd29ZTROhQG
         6nis/jmgN1RvEZV1gW7m0cvaGJ393yZYEc/CUej655rRg3ZKHk7bNHdUb5ptpPvb45UT
         ybuhr+O25J8smTcEJKdh6lC6RpV/MbYWjoZ2rDgcTZV5FIJmEV40eOCMCYO+x4IqN56u
         BD1Sxen91eKf5c3sBhFZcV9C5ou7NU0mGdVMOFeSafUjAe10N1wEUVKZFQByM2Q7pB8R
         1Ajg==
X-Gm-Message-State: AC+VfDyPpm8/bdlUUG6vKh15PfkwlYvVT5CNgkaAw4mX02tgfbfcq2Go
	g7BueHGpXPIVxMYhux9U2rVXI77zHuRKwzYR0/nQww==
X-Google-Smtp-Source: ACHHUZ5PPAo1bfCUuMeeQsiUJyIdN4pQmnO8qqrTD1xngH0moK3+RpzCzcUv2UiFHaUSTs7qXG1X4w==
X-Received: by 2002:a05:6a20:7da1:b0:101:65a2:e06b with SMTP id v33-20020a056a207da100b0010165a2e06bmr34572067pzj.20.1684269701713;
        Tue, 16 May 2023 13:41:41 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id v15-20020aa7850f000000b006410f4f3ecdsm13777763pfn.83.2023.05.16.13.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 13:41:41 -0700 (PDT)
Message-ID: <6463ea85.a70a0220.a2630.b8ca@mx.google.com>
Date: Tue, 16 May 2023 13:41:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.179-cip32-4-gd8c029e4780f
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip baseline-nfs: 41 runs,
 11 regressions (v5.10.179-cip32-4-gd8c029e4780f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 May 2023 20:41:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11476

cip/linux-5.10.y-cip baseline-nfs: 41 runs, 11 regressions (v5.10.179-cip32=
-4-gd8c029e4780f)

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

beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.179-cip32-4-gd8c029e4780f/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.179-cip32-4-gd8c029e4780f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      d8c029e4780f8e18a07a1a17c1a9de1e01f3adae =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6463e15b5e09c4f1ae2e85ef

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-nfs-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-nfs-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6463e15b5e09c4f1ae2e85f4
        failing since 122 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-16T20:02:23.756773  [   18.508003] <LAVA_SIGNAL_ENDRUN 0_dmesg =
10341537_1.5.2.3.1>

    2023-05-16T20:02:23.759865  + set +x

    2023-05-16T20:02:23.864221  / # #

    2023-05-16T20:02:23.964837  export SHELL=3D/bin/sh

    2023-05-16T20:02:23.965034  #

    2023-05-16T20:02:24.065531  / # export SHELL=3D/bin/sh. /lava-10341537/=
environment

    2023-05-16T20:02:24.065731  =


    2023-05-16T20:02:24.166232  / # . /lava-10341537/environment/lava-10341=
537/bin/lava-test-runner /lava-10341537/1

    2023-05-16T20:02:24.166525  =


    2023-05-16T20:02:24.171605  / # /lava-10341537/bin/lava-test-runner /la=
va-10341537/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6463e161455e807b0d2e85f8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6463e161455e807b0d2e85fd
        failing since 122 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-16T20:02:26.177767  + set +x

    2023-05-16T20:02:26.184206  [   19.644001] <LAVA_SIGNAL_ENDRUN 0_dmesg =
10341518_1.5.2.3.1>

    2023-05-16T20:02:26.288536  / # #

    2023-05-16T20:02:26.389219  export SHELL=3D/bin/sh

    2023-05-16T20:02:26.389401  #

    2023-05-16T20:02:26.489870  / # export SHELL=3D/bin/sh. /lava-10341518/=
environment

    2023-05-16T20:02:26.490075  =


    2023-05-16T20:02:26.590544  / # . /lava-10341518/environment/lava-10341=
518/bin/lava-test-runner /lava-10341518/1

    2023-05-16T20:02:26.590946  =


    2023-05-16T20:02:26.595518  / # /lava-10341518/bin/lava-test-runner /la=
va-10341518/1
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6463e33e8cecd4fdb02e8625

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-n=
fs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-n=
fs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6463e33e8cecd4fdb02e864b
        failing since 122 days (last pass: v5.10.158-cip22, first fail: v5.=
10.162-cip24)

    2023-05-16T20:09:47.386075  + set +x
    2023-05-16T20:09:47.388931  <8>[   52.359603] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 468953_1.6.2.4.1>
    2023-05-16T20:09:47.512779  / # #
    2023-05-16T20:09:47.615670  export SHELL=3D/bin/sh
    2023-05-16T20:09:47.616423  #
    2023-05-16T20:09:47.718507  / # export SHELL=3D/bin/sh. /lava-468953/en=
vironment
    2023-05-16T20:09:47.719221  =

    2023-05-16T20:09:47.821704  / # . /lava-468953/environment/lava-468953/=
bin/lava-test-runner /lava-468953/1
    2023-05-16T20:09:47.822940  =

    2023-05-16T20:09:47.826134  / # /lava-468953/bin/lava-test-runner /lava=
-468953/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6463e780444d41bb792e8611

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-b=
eaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-b=
eaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6463e780444d41bb792e8614
        failing since 122 days (last pass: v5.10.158-cip22, first fail: v5.=
10.162-cip24)

    2023-05-16T20:28:08.391901  / # #
    2023-05-16T20:28:08.495401  export SHELL=3D/bin/sh
    2023-05-16T20:28:08.496490  #
    2023-05-16T20:28:08.598890  / # export SHELL=3D/bin/sh. /lava-934466/en=
vironment
    2023-05-16T20:28:08.599991  =

    2023-05-16T20:28:08.702402  / # . /lava-934466/environment/lava-934466/=
bin/lava-test-runner /lava-934466/1
    2023-05-16T20:28:08.703892  =

    2023-05-16T20:28:08.713789  / # /lava-934466/bin/lava-test-runner /lava=
-934466/1
    2023-05-16T20:28:08.985742  + export TESTRUN_ID=3D1_bootrr
    2023-05-16T20:28:09.001705  + cd /lava-934466/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6463e1980b5fd3714e2e862d

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-=
nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-=
nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6463e1980b5fd3714e2e8655
        failing since 105 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.165-cip25)

    2023-05-16T20:03:21.388721  + set +x
    2023-05-16T20:03:21.392541  [   47.534409] <LAVA_SIGNAL_ENDRUN 0_dmesg =
468872_1.6.2.4.1>
    2023-05-16T20:03:21.515022  / # #
    2023-05-16T20:03:21.617805  export SHELL=3D/bin/sh
    2023-05-16T20:03:21.618373  #
    2023-05-16T20:03:21.720059  / # export SHELL=3D/bin/sh. /lava-468872/en=
vironment
    2023-05-16T20:03:21.720673  =

    2023-05-16T20:03:21.822379  / # . /lava-468872/environment/lava-468872/=
bin/lava-test-runner /lava-468872/1
    2023-05-16T20:03:21.823248  =

    2023-05-16T20:03:21.827334  / # /lava-468872/bin/lava-test-runner /lava=
-468872/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6463e19e0b5fd3714e2e866c

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs-=
beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs-=
beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6463e19e0b5fd3714e2e866f
        failing since 105 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.165-cip25)

    2023-05-16T20:03:10.050484  + set +x
    2023-05-16T20:03:10.054902  <8>[   43.096919] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 934437_1.6.2.4.1>
    2023-05-16T20:03:10.328325  #
    2023-05-16T20:03:10.431153  / # #export SHELL=3D/bin/sh
    2023-05-16T20:03:10.431995  =

    2023-05-16T20:03:10.533799  / # export SHELL=3D/bin/sh. /lava-934437/en=
vironment
    2023-05-16T20:03:10.537297  =

    2023-05-16T20:03:10.638980  / # . /lava-934437/environment/lava-934437/=
bin/lava-test-runner /lava-934437/1
    2023-05-16T20:03:10.640009  =

    2023-05-16T20:03:10.645898  / # /lava-934437/bin/lava-test-runner /lava=
-934437/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6463e16cd2b3c77b052e85e6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6463e16cd2b3c77b052e85eb
        failing since 32 days (last pass: v5.10.176-cip30, first fail: v5.1=
0.177-cip31)

    2023-05-16T20:02:31.192749  + set +x<8>[   18.604099] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10341502_1.5.2.3.1>

    2023-05-16T20:02:31.192898  =


    2023-05-16T20:02:31.297501  / # #

    2023-05-16T20:02:31.398169  export SHELL=3D/bin/sh

    2023-05-16T20:02:31.398409  #

    2023-05-16T20:02:31.498967  / # export SHELL=3D/bin/sh. /lava-10341502/=
environment

    2023-05-16T20:02:31.499213  =


    2023-05-16T20:02:31.599765  / # . /lava-10341502/environment/lava-10341=
502/bin/lava-test-runner /lava-10341502/1

    2023-05-16T20:02:31.600217  =


    2023-05-16T20:02:31.604972  / # /lava-10341502/bin/lava-test-runner /la=
va-10341502/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6463e15f455e807b0d2e85ed

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6463e15f455e807b0d2e85f2
        failing since 32 days (last pass: v5.10.176-cip30, first fail: v5.1=
0.177-cip31)

    2023-05-16T20:02:18.273679  + set +x

    2023-05-16T20:02:18.280584  <8>[   19.680783] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10341515_1.5.2.3.1>

    2023-05-16T20:02:18.385140  / # #

    2023-05-16T20:02:18.486533  export SHELL=3D/bin/sh

    2023-05-16T20:02:18.487364  #

    2023-05-16T20:02:18.588758  / # export SHELL=3D/bin/sh. /lava-10341515/=
environment

    2023-05-16T20:02:18.589061  =


    2023-05-16T20:02:18.690041  / # . /lava-10341515/environment/lava-10341=
515/bin/lava-test-runner /lava-10341515/1

    2023-05-16T20:02:18.691375  =


    2023-05-16T20:02:18.697332  / # /lava-10341515/bin/lava-test-runner /la=
va-10341515/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6463e24a7adcb8579f2e8650

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline=
-nfs-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline=
-nfs-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6463e24a7adcb8579f2e8655
        failing since 122 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-16T20:06:18.327893  / # #

    2023-05-16T20:06:18.430427  export SHELL=3D/bin/sh

    2023-05-16T20:06:18.431205  #

    2023-05-16T20:06:18.533070  / # export SHELL=3D/bin/sh. /lava-10341642/=
environment

    2023-05-16T20:06:18.533833  =


    2023-05-16T20:06:18.635770  / # . /lava-10341642/environment/lava-10341=
642/bin/lava-test-runner /lava-10341642/1

    2023-05-16T20:06:18.636958  =


    2023-05-16T20:06:18.652722  / # /lava-10341642/bin/lava-test-runner /la=
va-10341642/1

    2023-05-16T20:06:18.841478  + export TESTRUN_ID=3D1_bootrr

    2023-05-16T20:06:18.841947  + cd /lava-10341642/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6463e51cdd4a4f19a42e860d

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabor=
a/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabor=
a/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/6463e51cdd4a4f19a42e8613
        failing since 55 days (last pass: v5.10.173-cip28, first fail: v5.1=
0.175-cip29)

    2023-05-16T20:18:17.347157  /lava-10341689/1/../bin/lava-test-case

    2023-05-16T20:18:17.381323  <8>[   96.224645] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/6463e51cdd4a4f19a42e8614
        failing since 55 days (last pass: v5.10.173-cip28, first fail: v5.1=
0.175-cip29)

    2023-05-16T20:18:16.264004  /lava-10341689/1/../bin/lava-test-case

    2023-05-16T20:18:16.295686  <8>[   95.139434] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =20

