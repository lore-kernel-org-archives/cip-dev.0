Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DFFEE4996
	for <webhook@archiver.kernel.org>; Tue, 22 Aug 2023 12:49:48 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web10.7057.1692708580962152914
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 22 Aug 2023 05:49:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=xOALv1rX;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.172, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1bf078d5fb7so28677795ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 22 Aug 2023 05:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692708580; x=1693313380;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=O76iBXx8+qhNKvtBr7A8erCIjhcMho+p2rdta3HyWys=;
        b=xOALv1rXiCPWsiyeN4JojzPRhg4h/Bt/uxIEA02mJSFUPGY93qzGHuvnnAo6RcKlBu
         GVTjsWBkabtYjX+Ug0XpDtqCt1xTJWHKIgooLw6px/wDCE9Rrv1Kyf6c+wiTRnd6DZtI
         Lf+xw0qA0ZzFW5DyhIXMosuQbDzbZPvm7jRUjVth/Da/zVRrB74PK61PmYbKUx0biOMD
         adm/Yl2uhezkX9Vrx7fqPawwzBti+04O7g9/fWmtFtVB390VD2YPs6q9xzv2g+3Kj1PK
         Ggi0iSIpcVHmhWQZ4JqYpbze//IepwFJQnIJulcfeE7v1YaG96RwyL5aA+q5SeVGkWob
         E74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692708580; x=1693313380;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O76iBXx8+qhNKvtBr7A8erCIjhcMho+p2rdta3HyWys=;
        b=LgiEJ1yJ0DBfa6dH9HX7lJTwb5uZeVL0wP1VTE5KQ/RsY8Rj/vxvgkXq7V+sJoHe3D
         uzWTtlnfaGraDoQfFJOaVanXmPMFnwqmrX1k9dm1EaBKfifRp3X5ZYOrhRxKtYfcBkcb
         6qLszMKxO+kivD/0RwjjSa7laEu3Mss8LZ+KIMbgrfVhC0xYTEpEHDvfd3qHZpXw9kBy
         c7V41R1WgcrsZtEsAVd16IDiDAIL+oDbG6hNwkVtseK/QwFub4mfgrpRvmpyDxAv5kIg
         alFIEko2pgGCENq9ra4IB6BshUWYRI7HKJ4ScIru7BDL24dd+FlShm4HG62sSufp6XKj
         8WTg==
X-Gm-Message-State: AOJu0YxbZPCt+ZG+Ver70GBrV6DeS7qUcSKjzC3XzIOcLJJ5zyj5WfgZ
	Dq/M+LhBmw7+RgvfwrN/b5kEqfekFNiYsh5pdH2eOA==
X-Google-Smtp-Source: AGHT+IEDFaSEcjkx4Gb1t6Pa2e2essGRCnbLNwn8LekSoSUVbwKIlxXDNOeAi4Hyb5Q3yO33nRZIiQ==
X-Received: by 2002:a17:903:230e:b0:1bc:2c58:ad97 with SMTP id d14-20020a170903230e00b001bc2c58ad97mr9158247plh.22.1692708579640;
        Tue, 22 Aug 2023 05:49:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ix12-20020a170902f80c00b001b890b3bbb1sm9001179plb.211.2023.08.22.05.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 05:49:38 -0700 (PDT)
Message-ID: <64e4aee2.170a0220.c39e8.00cd@mx.google.com>
Date: Tue, 22 Aug 2023 05:49:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.186-cip37-27-gd6d928db0a620
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
Subject: cip/linux-5.10.y-cip baseline-nfs: 24 runs,
 13 regressions (v5.10.186-cip37-27-gd6d928db0a620)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Aug 2023 12:49:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12820

cip/linux-5.10.y-cip baseline-nfs: 24 runs, 13 regressions (v5.10.186-cip37=
-27-gd6d928db0a620)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
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

imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+kselftest          | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.186-cip37-27-gd6d928db0a620/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.186-cip37-27-gd6d928db0a620
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      d6d928db0a620394e433833b5dda4ec7ac822999 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4a5fb7c29fa1142b1e3b0

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline=
-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline=
-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64e4a5fb7c29fa1142b1e3dd
        failing since 220 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-22T12:10:49.869702  + set +x
    2023-08-22T12:10:49.873684  <8>[   52.557984] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 64128_1.6.2.4.1>
    2023-08-22T12:10:49.989996  / # #
    2023-08-22T12:10:50.092194  export SHELL=3D/bin/sh
    2023-08-22T12:10:50.092799  #
    2023-08-22T12:10:50.194360  / # export SHELL=3D/bin/sh. /lava-64128/env=
ironment
    2023-08-22T12:10:50.195426  =

    2023-08-22T12:10:50.297731  / # . /lava-64128/environment/lava-64128/bi=
n/lava-test-runner /lava-64128/1
    2023-08-22T12:10:50.298639  =

    2023-08-22T12:10:50.302145  / # /lava-64128/bin/lava-test-runner /lava-=
64128/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4a547ee580883b3b1e3c9

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs=
-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs=
-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64e4a547ee580883b3b1e3cc
        failing since 220 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-22T12:08:05.780635  + set +x
    2023-08-22T12:08:05.782694  <8>[   43.811692] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 999344_1.6.2.4.1>
    2023-08-22T12:08:05.899999  #
    2023-08-22T12:08:06.002083  / # #export SHELL=3D/bin/sh
    2023-08-22T12:08:06.002531  =

    2023-08-22T12:08:06.103906  / # export SHELL=3D/bin/sh. /lava-999344/en=
vironment
    2023-08-22T12:08:06.104357  =

    2023-08-22T12:08:06.205737  / # . /lava-999344/environment/lava-999344/=
bin/lava-test-runner /lava-999344/1
    2023-08-22T12:08:06.206468  =

    2023-08-22T12:08:06.208497  / # /lava-999344/bin/lava-test-runner /lava=
-999344/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4a500516b012293b1e3b8

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm/omap2plus_defconfig/gcc-10/lab-broonie/baselin=
e-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm/omap2plus_defconfig/gcc-10/lab-broonie/baselin=
e-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64e4a500516b012293b1e3d1
        failing since 220 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-22T12:06:33.784278  <8>[   45.275239] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 64062_1.6.2.4.1>
    2023-08-22T12:06:33.902848  / # #
    2023-08-22T12:06:34.005329  export SHELL=3D/bin/sh
    2023-08-22T12:06:34.005913  #
    2023-08-22T12:06:34.107815  / # export SHELL=3D/bin/sh. /lava-64062/env=
ironment
    2023-08-22T12:06:34.108688  =

    2023-08-22T12:06:34.210615  / # . /lava-64062/environment/lava-64062/bi=
n/lava-test-runner /lava-64062/1
    2023-08-22T12:06:34.211490  =

    2023-08-22T12:06:34.215805  / # /lava-64062/bin/lava-test-runner /lava-=
64062/1
    2023-08-22T12:06:34.455185  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4a3f227b2d55cf5b1e3c9

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nf=
s-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nf=
s-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64e4a3f227b2d55cf5b1e3cc
        failing since 220 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-22T12:02:30.819246  + set +x
    2023-08-22T12:02:30.823491  <8>[   45.126065] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 999339_1.6.2.4.1>
    2023-08-22T12:02:30.978431  #
    2023-08-22T12:02:31.081400  / # #export SHELL=3D/bin/sh
    2023-08-22T12:02:31.082111  =

    2023-08-22T12:02:31.183956  / # export SHELL=3D/bin/sh. /lava-999339/en=
vironment
    2023-08-22T12:02:31.184691  =

    2023-08-22T12:02:31.286490  / # . /lava-999339/environment/lava-999339/=
bin/lava-test-runner /lava-999339/1
    2023-08-22T12:02:31.287655  =

    2023-08-22T12:02:31.294123  /lava-999339/bin/lava-test-runner /lava-999=
339/1/ #  =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4a2622a69a052fbb1e3e8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64e4a2622a69a052fbb1e3ed
        failing since 130 days (last pass: v5.10.176-cip30, first fail: v5.=
10.177-cip31)

    2023-08-22T11:55:57.771943  + <8>[   23.113758] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11330328_1.5.2.3.1>

    2023-08-22T11:55:57.772534  set +x

    2023-08-22T11:55:57.881317  / # #

    2023-08-22T11:55:57.983765  export SHELL=3D/bin/sh

    2023-08-22T11:55:57.983980  #

    2023-08-22T11:55:58.084695  / # export SHELL=3D/bin/sh. /lava-11330328/=
environment

    2023-08-22T11:55:58.085662  =


    2023-08-22T11:55:58.187506  / # . /lava-11330328/environment/lava-11330=
328/bin/lava-test-runner /lava-11330328/1

    2023-08-22T11:55:58.189049  =


    2023-08-22T11:55:58.193723  / # /lava-11330328/bin/lava-test-runner /la=
va-11330328/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4a53df3fefe9c02b1e3e2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-nfs-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-nfs-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64e4a53df3fefe9c02b1e3e7
        failing since 220 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-22T12:08:15.069316  / # #

    2023-08-22T12:08:15.171279  export SHELL=3D/bin/sh

    2023-08-22T12:08:15.171915  #

    2023-08-22T12:08:15.273355  / # export SHELL=3D/bin/sh. /lava-11330347/=
environment

    2023-08-22T12:08:15.273997  =


    2023-08-22T12:08:15.375408  / # . /lava-11330347/environment/lava-11330=
347/bin/lava-test-runner /lava-11330347/1

    2023-08-22T12:08:15.376435  =


    2023-08-22T12:08:15.377940  / # /lava-11330347/bin/lava-test-runner /la=
va-11330347/1

    2023-08-22T12:08:15.489675  + export TESTRUN_ID=3D1_bootrr

    2023-08-22T12:08:15.536919  + cd /lava-11330347/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4a56708c6b4a22cb1e5eb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm64/defconfig+arm64-chromebook/gcc-10/lab-brooni=
e/baseline-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm64/defconfig+arm64-chromebook/gcc-10/lab-brooni=
e/baseline-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64e4a56708c6b4a22=
cb1e5ec
        new failure (last pass: v5.10.186-cip37-14-gc9b5a049d8ea) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4ac7005ccde60f5b1e3c4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-me=
son-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-me=
son-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64e4ac7005ccde60f=
5b1e3c5
        new failure (last pass: v5.10.186-cip37-13-g260094841fe1a) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4a5a98d463c41a3b1e3db

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ba=
seline-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ba=
seline-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64e4a5a98d463c41a=
3b1e3dc
        new failure (last pass: v5.10.186-cip37-14-gc9b5a049d8ea) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4a6422b2a4bd663b1e3af

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-=
nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-=
nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64e4a6422b2a4bd66=
3b1e3b0
        failing since 6 days (last pass: v5.10.186-cip37-13-g260094841fe1a,=
 first fail: v5.10.186-cip37-14-gc9b5a049d8ea) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4a74507ee7cdfb3b1e3b2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm64/defconfig/gcc-10/lab-cip/baseline-nfs-r8a774=
a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm64/defconfig/gcc-10/lab-cip/baseline-nfs-r8a774=
a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64e4a74507ee7cdfb=
3b1e3b3
        failing since 27 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64e4a53808c6b4a22cb1e4ec

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm64/defconfig+arm64-chromebook/gcc-10/lab-collab=
ora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm64/defconfig+arm64-chromebook/gcc-10/lab-collab=
ora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/64e4a53808c6b4a22cb1e4f2
        failing since 153 days (last pass: v5.10.173-cip28, first fail: v5.=
10.175-cip29)

    2023-08-22T12:08:13.703649  <8>[   38.513768] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-08-22T12:08:14.770726  /lava-11330358/1/../bin/lava-test-case

    2023-08-22T12:08:14.810771  <8>[   39.621997] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/64e4a53808c6b4a22cb1e4f3
        failing since 153 days (last pass: v5.10.173-cip28, first fail: v5.=
10.175-cip29)

    2023-08-22T12:08:13.661157  /lava-11330358/1/../bin/lava-test-case
   =

 =20

