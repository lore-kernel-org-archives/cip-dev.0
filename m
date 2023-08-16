Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB87C001E0
	for <webhook@archiver.kernel.org>; Wed, 16 Aug 2023 11:00:18 +0000 (UTC)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
 by mx.groups.io with SMTP id smtpd.web10.158170.1692183613633770367
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 16 Aug 2023 04:00:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=q95hweKF;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.170, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-565e395e7a6so727756a12.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 16 Aug 2023 04:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692183613; x=1692788413;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=093CAtOpqoC/Xf1lFFq3KO3Zw5+QHrbl+ea8yZqMlw0=;
        b=q95hweKFtI1EMvAcRrLZiTtBL5ag+Q3w1cfWK3CFxgAA838rJU90WkVRgThnxCb0Ih
         kq6du0lPqczvvj/pV7bP3KGs3VzHZXdfQQjnPmbKHjdG5j141z/mld92JZltuVYmS80r
         GEdmEmVvHxbTRQ9v38+hWXvZFwUhS0huDtXllJHq5ekLOV/fNXv3Hssq3BGjflExCsOw
         XZ2+ZaFdzaSs+OJxrYrFYBq7dK48lRjVBf3Rphz6lHxZ4Dl8JTDF/dCMS48zEYXUd8YS
         DrRZ8/Otyg0EpG7339VpP+oNcqs3XW0K7kAqIdWICp6dtNRan1wS5pP8zdpjkgbVWLHv
         BwcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692183613; x=1692788413;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=093CAtOpqoC/Xf1lFFq3KO3Zw5+QHrbl+ea8yZqMlw0=;
        b=lLB13nx2ENxaXHPqTi6hcOfucmKCorch98MIHJGt6rVsTlm6mgEQHOJQ3xpALAAtni
         U5LTt60wsWy3Bbmu0zu3PzFKCHHZmbLTh5m1MpmBrU+cYlMnIaasoq8fj4KrwgAOY05S
         /ZXa0jLHETgb+pouWWV4RD1lDJaGpboa1x5iKrjHRElXTVjU4/XCDG8kp3OQ7gf0r2mA
         /Dr58+0y3JdB2u7pv6miUz6bNwKFQriBXRKW90Its6vHQBWQYJ3yhi3ewqxeUqOEctl9
         5cBTFqN0nkqvE2nMVmo0PnL39K9M4qFfQBt3Fo8LjFLMgY7XkXWs0TzmxaYjJDrWEIl6
         ZxIw==
X-Gm-Message-State: AOJu0YzyXHssSnEuMbP9Mem9pJetSpL8SYKVelL31a0btg0NKSjzseyh
	s35GRfJJtbP7zRvNFJYDuui3xfAE4jkCXOtcGP9+xw==
X-Google-Smtp-Source: AGHT+IGhZP1IXSG18/ziNCiOrBI0DCA2Mmh2afDMz7YUr+PabdzTU0DDBBp1Ck4MR0rOsV62DcvbOg==
X-Received: by 2002:a05:6a21:3e0d:b0:135:4388:3978 with SMTP id bk13-20020a056a213e0d00b0013543883978mr1417330pzc.29.1692183612584;
        Wed, 16 Aug 2023 04:00:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 20-20020a170902e9d400b001b898595be7sm8807862plk.291.2023.08.16.04.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 04:00:11 -0700 (PDT)
Message-ID: <64dcac3b.170a0220.cc2ad.0af0@mx.google.com>
Date: Wed, 16 Aug 2023 04:00:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.186-cip37-14-gc9b5a049d8ea
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
Subject: cip/linux-5.10.y-cip baseline-nfs: 23 runs,
 10 regressions (v5.10.186-cip37-14-gc9b5a049d8ea)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Aug 2023 11:00:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12667

cip/linux-5.10.y-cip baseline-nfs: 23 runs, 10 regressions (v5.10.186-cip37=
-14-gc9b5a049d8ea)

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

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+kselftest          | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.186-cip37-14-gc9b5a049d8ea/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.186-cip37-14-gc9b5a049d8ea
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      c9b5a049d8ead0f771ee3424c42b20632ebc5b3b =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64dc9fcd6418827f0635b1e3

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-=
nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-=
nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64dc9fcd6418827f0635b210
        failing since 214 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-16T10:06:16.102298  <8>[   54.225637] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 56522_1.6.2.4.1>
    2023-08-16T10:06:16.219923  / # #
    2023-08-16T10:06:16.322011  export SHELL=3D/bin/sh
    2023-08-16T10:06:16.322680  #
    2023-08-16T10:06:16.424214  / # export SHELL=3D/bin/sh. /lava-56522/env=
ironment
    2023-08-16T10:06:16.424806  =

    2023-08-16T10:06:16.526312  / # . /lava-56522/environment/lava-56522/bi=
n/lava-test-runner /lava-56522/1
    2023-08-16T10:06:16.527344  =

    2023-08-16T10:06:16.531233  / # /lava-56522/bin/lava-test-runner /lava-=
56522/1
    2023-08-16T10:06:16.734214  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64dc9f96686db3e05335b1de

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-=
beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-=
beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64dc9f96686db3e05335b1e1
        failing since 214 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-16T10:05:30.148451  + set +x
    2023-08-16T10:05:30.150521  <8>[   46.569630] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 997814_1.6.2.4.1>
    2023-08-16T10:05:30.266842  / # #
    2023-08-16T10:05:30.368744  export SHELL=3D/bin/sh
    2023-08-16T10:05:30.369357  #
    2023-08-16T10:05:30.470735  / # export SHELL=3D/bin/sh. /lava-997814/en=
vironment
    2023-08-16T10:05:30.471198  =

    2023-08-16T10:05:30.572634  / # . /lava-997814/environment/lava-997814/=
bin/lava-test-runner /lava-997814/1
    2023-08-16T10:05:30.573375  =

    2023-08-16T10:05:30.575478  / # /lava-997814/bin/lava-test-runner /lava=
-997814/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64dca358ed00e05a4b35b1eb

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline=
-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline=
-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64dca358ed00e05a4b35b221
        failing since 214 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-16T10:22:01.072128  + set +x
    2023-08-16T10:22:01.076038  <8>[   46.011568] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 56575_1.6.2.4.1>
    2023-08-16T10:22:01.193285  / # #
    2023-08-16T10:22:01.296185  export SHELL=3D/bin/sh
    2023-08-16T10:22:01.296898  #
    2023-08-16T10:22:01.399179  / # export SHELL=3D/bin/sh. /lava-56575/env=
ironment
    2023-08-16T10:22:01.399926  =

    2023-08-16T10:22:01.502232  / # . /lava-56575/environment/lava-56575/bi=
n/lava-test-runner /lava-56575/1
    2023-08-16T10:22:01.503377  =

    2023-08-16T10:22:01.507537  / # /lava-56575/bin/lava-test-runner /lava-=
56575/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64dca3bafe257ee37135b1d9

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs=
-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs=
-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64dca3bafe257ee37135b1dc
        failing since 214 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-16T10:23:33.130628  + set +x
    2023-08-16T10:23:33.132558  <8>[   39.195309] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 997842_1.6.2.4.1>
    2023-08-16T10:23:33.255870  #
    2023-08-16T10:23:33.358067  / # #export SHELL=3D/bin/sh
    2023-08-16T10:23:33.358659  =

    2023-08-16T10:23:33.460054  / # export SHELL=3D/bin/sh. /lava-997842/en=
vironment
    2023-08-16T10:23:33.460509  =

    2023-08-16T10:23:33.561938  / # . /lava-997842/environment/lava-997842/=
bin/lava-test-runner /lava-997842/1
    2023-08-16T10:23:33.562708  =

    2023-08-16T10:23:33.564694  / # /lava-997842/bin/lava-test-runner /lava=
-997842/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dca02803e3a1bb4235b244

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64dca02803e3a1bb4235b249
        failing since 124 days (last pass: v5.10.176-cip30, first fail: v5.=
10.177-cip31)

    2023-08-16T10:08:30.402404  + <8>[   19.117749] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11298099_1.5.2.3.1>

    2023-08-16T10:08:30.402496  set +x

    2023-08-16T10:08:30.506917  / # #

    2023-08-16T10:08:30.607614  export SHELL=3D/bin/sh

    2023-08-16T10:08:30.607813  #

    2023-08-16T10:08:30.708301  / # export SHELL=3D/bin/sh. /lava-11298099/=
environment

    2023-08-16T10:08:30.708527  =


    2023-08-16T10:08:30.809109  / # . /lava-11298099/environment/lava-11298=
099/bin/lava-test-runner /lava-11298099/1

    2023-08-16T10:08:30.809422  =


    2023-08-16T10:08:30.813857  / # /lava-11298099/bin/lava-test-runner /la=
va-11298099/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dca020a65a921c2635b1ef

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64dca020a65a921c2635b1f4
        failing since 124 days (last pass: v5.10.176-cip30, first fail: v5.=
10.177-cip31)

    2023-08-16T10:09:31.855441  + set +x

    2023-08-16T10:09:31.862241  <8>[   18.604508] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11298123_1.5.2.3.1>

    2023-08-16T10:09:31.966628  / # #

    2023-08-16T10:09:32.067430  export SHELL=3D/bin/sh

    2023-08-16T10:09:32.067633  #

    2023-08-16T10:09:32.168160  / # export SHELL=3D/bin/sh. /lava-11298123/=
environment

    2023-08-16T10:09:32.168368  =


    2023-08-16T10:09:32.268892  / # . /lava-11298123/environment/lava-11298=
123/bin/lava-test-runner /lava-11298123/1

    2023-08-16T10:09:32.269155  =


    2023-08-16T10:09:32.274295  / # /lava-11298123/bin/lava-test-runner /la=
va-11298123/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64dc9f9d686db3e05335b216

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/arm/multi_v7_defconfig/gcc-10/lab-collabora/baselin=
e-nfs-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/arm/multi_v7_defconfig/gcc-10/lab-collabora/baselin=
e-nfs-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64dc9f9d686db3e05335b21b
        failing since 214 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-16T10:06:02.525284  / # #

    2023-08-16T10:06:02.626239  export SHELL=3D/bin/sh

    2023-08-16T10:06:02.626890  #

    2023-08-16T10:06:02.728295  / # export SHELL=3D/bin/sh. /lava-11298038/=
environment

    2023-08-16T10:06:02.728946  =


    2023-08-16T10:06:02.830375  / # . /lava-11298038/environment/lava-11298=
038/bin/lava-test-runner /lava-11298038/1

    2023-08-16T10:06:02.831403  =


    2023-08-16T10:06:02.838899  / # /lava-11298038/bin/lava-test-runner /la=
va-11298038/1

    2023-08-16T10:06:03.011317  + export TESTRUN_ID=3D1_bootrr

    2023-08-16T10:06:03.011726  + cd /lava-11298038/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64dca01e3a6167df2035b315

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-n=
fs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-n=
fs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64dca01e3a6167df2=
035b316
        new failure (last pass: v5.10.186-cip37-13-g260094841fe1a) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64dca0cf85fa3d506f35b1f6

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/64dca0cf85fa3d506f35b1fc
        failing since 147 days (last pass: v5.10.173-cip28, first fail: v5.=
10.175-cip29)

    2023-08-16T10:11:12.950920  <8>[   94.844606] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-08-16T10:11:13.989308  /lava-11298136/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/64dca0cf85fa3d506f35b1fd
        failing since 147 days (last pass: v5.10.173-cip28, first fail: v5.=
10.175-cip29)

    2023-08-16T10:11:11.873897  <8>[   93.766369] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-08-16T10:11:12.924614  /lava-11298136/1/../bin/lava-test-case
   =

 =20

