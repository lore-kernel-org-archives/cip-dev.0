Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D3FC61DA4
	for <webhook@archiver.kernel.org>; Thu, 23 Feb 2023 22:47:55 +0000 (UTC)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
 by mx.groups.io with SMTP id smtpd.web11.3940.1677192470431963909
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 23 Feb 2023 14:47:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=uGG9cNQn;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.53, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f53.google.com with SMTP id m8-20020a17090a4d8800b002377bced051so953752pjh.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 23 Feb 2023 14:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OSn0ofWTJ7J1Drdw2UBywtJgg2mt5BXNHhpCLqypwtI=;
        b=uGG9cNQnOL5W9i3CO1cWoD5xhDlU25Qubz9CfEKNUD9l+TzmFEPOXkXmoDFRALnVFK
         AOjb6c+QyXC0HXdgkd3b/DL+jKCBKto8Lj5PWGBQW+F76ziuFAWXQd+FpYpkOqij9Y1+
         DireL/YSXKL2d2M5WlbaGLrDOj1TyC6C/VAgmGuNx0YIXfz68GIU70eOngmd13gxXbn1
         TpsRK2eqnrIgSGXb4RiRb7bHvlfvjvWB1d4ukHRH8RyTrx//eOWBUEdZA0DnTKD5INnh
         Fp+GA998auXusRv26NzvvQBd/ahxIxLD3emHs92ikZ2NoaARQ/G9dJBQOuIgfp3XwW+e
         8SMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OSn0ofWTJ7J1Drdw2UBywtJgg2mt5BXNHhpCLqypwtI=;
        b=HklDwKzukP7qG9/PKwnp/LKOAX2fIFJ4x2/HD1SsBkIBiGvLd4F2Zk71CQG82qHL+0
         Gm7mzdvP+nvJsCgoYnx+5OEUaQEyUQHvQfBM+YbZrvFGJI6XSI3AhZ8vqUXWKxBGSVRf
         iqZum7MHw1Vd6IR5r/aXZqfOSs3/BZIT4rxw+O96AKHFrL2s2Ea1K4XUuUzSTDS/bHaO
         WCikTO+jeOZuIpAqufa9x5k8gswhdnnOVfX/Lfll1gH73ZseOgbGP/myFAmZcFUn6AXQ
         Ks7fm9FNMagCdZnBj1XtyaVAPBWIU6Q9S8rAJIa1IG1esq47OiPgHYsxYrEHYgtseEvF
         gw+w==
X-Gm-Message-State: AO0yUKX/kxPrz1jy/KK7oZDzvXoVhPM9ajhX+/+UQr7vsmYjEJQeUJ0m
	V0XpDdaGZUDH93F87zf8j/PHIAaFWQdB5X4R43Y=
X-Google-Smtp-Source: AK7set/FWSQCQXasCYY2GQiNfuMKFpPlGXJZfOTmUd5q/nJKW+I3mBD/47etRkxyS4zUnldmtFLhjA==
X-Received: by 2002:a17:903:18c:b0:19c:13c5:4f7c with SMTP id z12-20020a170903018c00b0019c13c54f7cmr16607922plg.1.1677192469199;
        Thu, 23 Feb 2023 14:47:49 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id oj18-20020a17090b4d9200b00233bc4edb77sm204662pjb.25.2023.02.23.14.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 14:47:48 -0800 (PST)
Message-ID: <63f7ed14.170a0220.9f483.09d1@mx.google.com>
Date: Thu, 23 Feb 2023 14:47:48 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.167-cip26-2-g1e87e7748b91
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip baseline-nfs: 58 runs,
 13 regressions (v5.10.167-cip26-2-g1e87e7748b91)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Feb 2023 22:47:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10801

cip/linux-5.10.y-cip baseline-nfs: 58 runs, 13 regressions (v5.10.167-cip26=
-2-g1e87e7748b91)

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
g+kselftest          | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 5          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.167-cip26-2-g1e87e7748b91/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.167-cip26-2-g1e87e7748b91
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      1e87e7748b91cc6ec7f9f32d6d156ee15f651805 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63f7e1be6396ded42f8c884f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-nfs-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-nfs-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230217.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63f7e1be6396ded42f8c8858
        failing since 40 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-23T21:59:15.126771  <8>[   16.964059] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9305532_1.5.2.3.1>

    2023-02-23T21:59:15.130189  + set +x

    2023-02-23T21:59:15.231964  #

    2023-02-23T21:59:15.232275  =


    2023-02-23T21:59:15.333241  / # #export SHELL=3D/bin/sh

    2023-02-23T21:59:15.333463  =


    2023-02-23T21:59:15.434400  / # export SHELL=3D/bin/sh. /lava-9305532/e=
nvironment

    2023-02-23T21:59:15.434611  =


    2023-02-23T21:59:15.535504  / # . /lava-9305532/environment/lava-930553=
2/bin/lava-test-runner /lava-9305532/1

    2023-02-23T21:59:15.535804  =

 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63f7e1b193b2a741208c8635

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230217.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63f7e1b193b2a741208c863e
        failing since 40 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-23T21:58:45.591331  + set +x

    2023-02-23T21:58:45.597796  <8>[   14.950085] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9305492_1.5.2.3.1>

    2023-02-23T21:58:45.702708  <6>[   14.958590] lava-t#

    2023-02-23T21:58:45.703933  est-runne (267) used greatest stack depth: =
13016 bytes left

    2023-02-23T21:58:45.805823  / # #export SHELL=3D/bin/sh

    2023-02-23T21:58:45.806480  =


    2023-02-23T21:58:45.908131  / # export SHELL=3D/bin/sh. /lava-9305492/e=
nvironment

    2023-02-23T21:58:45.908756  =


    2023-02-23T21:58:46.010123  / # . /lava-9305492/environment/lava-930549=
2/bin/lava-test-runner /lava-9305492/1

    2023-02-23T21:58:46.010417  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63f7e2dcb96259d34a8c8630

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230217.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63f7e2dcb96259d34a8c8639
        failing since 40 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-23T22:03:54.755840  + set +x

    2023-02-23T22:03:54.762747  <8>[   19.249122] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9305512_1.5.2.3.1>

    2023-02-23T22:03:54.873911  / # #

    2023-02-23T22:03:54.974921  export SHELL=3D/bin/sh

    2023-02-23T22:03:54.975106  #

    2023-02-23T22:03:55.075995  / # export SHELL=3D/bin/sh. /lava-9305512/e=
nvironment

    2023-02-23T22:03:55.076222  =


    2023-02-23T22:03:55.177117  / # . /lava-9305512/environment/lava-930551=
2/bin/lava-test-runner /lava-9305512/1

    2023-02-23T22:03:55.177414  =


    2023-02-23T22:03:55.182585  / # /lava-9305512/bin/lava-test-runner /lav=
a-9305512/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63f7e93443a9a80d438c8632

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-n=
fs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-n=
fs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230217.0/armel/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63f7e93443a9a80d438c863b
        failing since 40 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-23T22:31:02.785505  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 65504_1.6.2.=
4.1>
    2023-02-23T22:31:02.904898  #
    2023-02-23T22:31:03.006983  / # #export SHELL=3D/bin/sh
    2023-02-23T22:31:03.007452  =

    2023-02-23T22:31:03.108769  / # export SHELL=3D/bin/sh. /lava-65504/env=
ironment
    2023-02-23T22:31:03.109249  =

    2023-02-23T22:31:03.210594  / # . /lava-65504/environment/lava-65504/bi=
n/lava-test-runner /lava-65504/1
    2023-02-23T22:31:03.211383  =

    2023-02-23T22:31:03.217100  / # /lava-65504/bin/lava-test-runner /lava-=
65504/1
    2023-02-23T22:31:03.599658  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63f7e4d2b9473f7b5d8c8689

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-n=
fs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-n=
fs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230217.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63f7e4d2b9473f7b5d8c8692
        failing since 40 days (last pass: v5.10.158-cip22, first fail: v5.1=
0.162-cip24)

    2023-02-23T22:12:12.926227  <8>[   61.779912] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 65581_1.6.2.4.1>
    2023-02-23T22:12:13.051226  / # #
    2023-02-23T22:12:13.154207  export SHELL=3D/bin/sh
    2023-02-23T22:12:13.154981  #
    2023-02-23T22:12:13.256876  / # export SHELL=3D/bin/sh. /lava-65581/env=
ironment
    2023-02-23T22:12:13.258106  =

    2023-02-23T22:12:13.359834  / # . /lava-65581/environment/lava-65581/bi=
n/lava-test-runner /lava-65581/1
    2023-02-23T22:12:13.361661  =

    2023-02-23T22:12:13.364788  / # /lava-65581/bin/lava-test-runner /lava-=
65581/1
    2023-02-23T22:12:13.593124  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63f7e323ce9f9ba4a08c868d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-=
nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-=
nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230217.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63f7e323ce9f9ba4a08c8696
        failing since 23 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.165-cip25)

    2023-02-23T22:05:04.568857  + set +x
    2023-02-23T22:05:04.572504  <8>[   46.864332] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 65531_1.6.2.4.1>
    2023-02-23T22:05:04.697376  / # #
    2023-02-23T22:05:04.799443  export SHELL=3D/bin/sh
    2023-02-23T22:05:04.799969  #
    2023-02-23T22:05:04.901425  / # export SHELL=3D/bin/sh. /lava-65531/env=
ironment
    2023-02-23T22:05:04.901898  =

    2023-02-23T22:05:05.003350  / # . /lava-65531/environment/lava-65531/bi=
n/lava-test-runner /lava-65531/1
    2023-02-23T22:05:05.004131  =

    2023-02-23T22:05:05.008359  / # /lava-65531/bin/lava-test-runner /lava-=
65531/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63f7e88026fadf39e38c862f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline=
-nfs-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline=
-nfs-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230217.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63f7e88026fadf39e38c8638
        failing since 40 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-23T22:28:08.983986  / # #

    2023-02-23T22:28:09.086941  export SHELL=3D/bin/sh

    2023-02-23T22:28:09.087777  #

    2023-02-23T22:28:09.190190  / # export SHELL=3D/bin/sh. /lava-9305696/e=
nvironment

    2023-02-23T22:28:09.191125  =


    2023-02-23T22:28:09.293269  / # . /lava-9305696/environment/lava-930569=
6/bin/lava-test-runner /lava-9305696/1

    2023-02-23T22:28:09.294629  =


    2023-02-23T22:28:09.306472  / # /lava-9305696/bin/lava-test-runner /lav=
a-9305696/1

    2023-02-23T22:28:09.496064  + export TESTRUN_ID=3D1_bootrr

    2023-02-23T22:28:09.496524  + cd /lava-9305696/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/63f7e553df669a2bd58c8659

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/arm64/defconfig+kselftest/gcc-10/lab-broonie/baselin=
e-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/arm64/defconfig+kselftest/gcc-10/lab-broonie/baselin=
e-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230217.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63f7e553df669a2bd=
58c865a
        new failure (last pass: v5.10.167-cip26) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 5          =


  Details:     https://kernelci.org/test/plan/id/63f7e479f028a46e168c8677

  Results:     86 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabor=
a/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabor=
a/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230217.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/63f7e479f028a46e168c869d
        failing since 331 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81,=
 first fail: v5.10.106-cip4)

    2023-02-23T22:10:43.485496  /lava-9305736/1/../bin/lava-test-case

    2023-02-23T22:10:43.525065  [   35.845828] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-rt5514-present: https://ker=
nelci.org/test/case/id/63f7e479f028a46e168c86ac
        failing since 40 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-23T22:10:40.804642  seq: invalid floating point argument: =E2=
=80=98sound/RT5514=E2=80=99

    2023-02-23T22:10:40.808974  Try 'seq --help' for more information.

    2023-02-23T22:10:40.813210  /lava-9305736/1/../bin/lava-test-case

    2023-02-23T22:10:40.840743  [   33.159628] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk3399-gru-sound-driver-rt5514-present RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-max98357A-present: https://=
kernelci.org/test/case/id/63f7e479f028a46e168c86ad
        failing since 40 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-23T22:10:40.743075  seq: invalid floating point argument: =E2=
=80=98sound/MAX98357A=E2=80=99

    2023-02-23T22:10:40.747255  Try 'seq --help' for more information.

    2023-02-23T22:10:40.751075  /lava-9305736/1/../bin/lava-test-case

    2023-02-23T22:10:40.777702  [   33.096943] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk3399-gru-sound-driver-max98357A-present RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-dp-present: https://kernelc=
i.org/test/case/id/63f7e479f028a46e168c86ae
        failing since 40 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-23T22:10:40.644138  [   32.962805] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk3399-gru-sound-driver-da7219-present RESULT=3Dfail>

    2023-02-23T22:10:40.679516  seq: invalid floating point argument: =E2=
=80=98sound/DP=E2=80=99

    2023-02-23T22:10:40.684212  Try 'seq --help' for more information.

    2023-02-23T22:10:40.687746  /lava-9305736/1/../bin/lava-test-case

    2023-02-23T22:10:40.715044  [   33.035137] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk3399-gru-sound-driver-dp-present RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-da7219-present: https://ker=
nelci.org/test/case/id/63f7e479f028a46e168c86af
        failing since 40 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-23T22:10:40.607597  seq: invalid floating point argument: =E2=
=80=98sound/DA7219=E2=80=99

    2023-02-23T22:10:40.611214  Try 'seq --help' for more information.

    2023-02-23T22:10:40.614961  /lava-9305736/1/../bin/lava-test-case
   =

 =20

