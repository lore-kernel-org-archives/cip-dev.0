Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFE4C636D3
	for <webhook@archiver.kernel.org>; Wed,  1 Feb 2023 10:39:21 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web11.20289.1675247960824882554
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 01 Feb 2023 02:39:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=1DEzmBTh;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.48, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f48.google.com with SMTP id nm12-20020a17090b19cc00b0022c2155cc0bso1555637pjb.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 01 Feb 2023 02:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dwJYFjpOpEhi2Omkn/+yDaS9jQbJybsvOg3iR9Ou+wE=;
        b=1DEzmBTh38B++e0dKRYc2sUGy79EYCEVwdDyuC8ZiYBweAhKgR1Q49Jj0hXVXcxAr4
         8wNwXjvehNmyw9cmuOsts8jgEQFtsiO7pXz6MYlwj0KGOQIvaDwF7iDWVQlGrqgLDLzl
         iN4xAF/XUvfzu/AkCyBAQuIkZk90BF/FY+9S1vHFBKxa37TQiLzYZEG7LgX/RJBSJu8/
         GmeJABQfumpu6mw762z2PiyqqFbcOriJRUuz13pb0DP0p7J9Tj19nnuZkgR0+L8i0XZx
         wEuph7GNCraJ0bPzKFVqJkl+YXG/wrJOucRjF5co7ILsDyZouutARK6dbeqHPfUwV+nG
         N9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dwJYFjpOpEhi2Omkn/+yDaS9jQbJybsvOg3iR9Ou+wE=;
        b=DWbbyDjQJk5hToTUV1xaHIXh0FkfkWk29lI2kFGxdqLLcfc3WF2ALnTOr+fQ3KtpSZ
         fJF/+5q/Ewew1EbaIFf+DHylY+Q0ML/vBI+fB1+645UNOhyDhzkaEiXVE8nYA9JeXiN7
         Qce2rS8ooPyz0zWuC8I8xr8i0AZPqbpz0rjc3Nbpum33uWukn0LrXiM+IM1VMDcM20Ji
         KTz/pB7EfmaMWhXlDnhf+qKSC647MCcwtVpxjU9oJBHifV0pi5G9xvV0I/ESxR1oalj5
         R5nvLG6/SArkWRT/mchV94dsV4jjeMOFsi4Th9ZOktHAeGMlFlmMrQtMxmOD3cvlHWGP
         IIig==
X-Gm-Message-State: AO0yUKVkzPGJstFLtzyy5Din+hGxxugADkhZTmslTB4AojrW1XPtay3f
	hyOh/zru7LxqxZX9oX92thvcXZa/nbXdqZj3YU/94g==
X-Google-Smtp-Source: AK7set+xiUtXGZOnmT5dTAPZfYm1J23JS+yWIEjbWsen3UQRVxx/EHE3gaGiR+4bdgLRehuUv/ghpg==
X-Received: by 2002:a17:902:d415:b0:196:3c4d:7842 with SMTP id b21-20020a170902d41500b001963c4d7842mr1892329ple.44.1675247959731;
        Wed, 01 Feb 2023 02:39:19 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b14-20020a170903228e00b00192f4fbdeb5sm11392782plh.102.2023.02.01.02.39.19
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 02:39:19 -0800 (PST)
Message-ID: <63da4157.170a0220.cbb4a.4c4c@mx.google.com>
Date: Wed, 01 Feb 2023 02:39:19 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.165-cip25-144-g43e1d8dfbb26
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 181 runs,
 10 regressions (v5.10.165-cip25-144-g43e1d8dfbb26)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 01 Feb 2023 10:39:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10552

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 181 runs, 10 regressio=
ns (v5.10.165-cip25-144-g43e1d8dfbb26)

Regressions Summary
-------------------

platform               | arch  | lab           | compiler | defconfig      =
              | regressions
-----------------------+-------+---------------+----------+----------------=
--------------+------------
beagle-xm              | arm   | lab-baylibre  | gcc-10   | omap2plus_defco=
nfig          | 1          =

beaglebone-black       | arm   | lab-broonie   | gcc-10   | omap2plus_defco=
nfig          | 1          =

cubietruck             | arm   | lab-baylibre  | gcc-10   | multi_v7_defcon=
fig           | 1          =

mt8173-elm-hana        | arm64 | lab-collabora | gcc-10   | defconfig+arm64=
-chromebook   | 1          =

mt8173-elm-hana        | arm64 | lab-collabora | gcc-10   | defconfig+arm..=
.ok+kselftest | 1          =

r8a7743-iwg20d-q7      | arm   | lab-cip       | gcc-10   | shmobile_defcon=
fig           | 1          =

rk3328-rock64          | arm64 | lab-baylibre  | gcc-10   | defconfig      =
              | 1          =

stm32mp157c-dk2        | arm   | lab-baylibre  | gcc-10   | multi_v7_defcon=
fig           | 1          =

sun50i-a64-pine64-plus | arm64 | lab-baylibre  | gcc-10   | defconfig      =
              | 1          =

sun50i-a64-pine64-plus | arm64 | lab-broonie   | gcc-10   | defconfig      =
              | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.165-cip25-144-g43e1d8dfbb26/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.165-cip25-144-g43e1d8dfbb26
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      43e1d8dfbb26af10d1f04a30d7d08cdc4a298862 =



Test Regressions
---------------- =



platform               | arch  | lab           | compiler | defconfig      =
              | regressions
-----------------------+-------+---------------+----------+----------------=
--------------+------------
beagle-xm              | arm   | lab-baylibre  | gcc-10   | omap2plus_defco=
nfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63da3b992fd559e395915ed9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.165-cip25-144-g43e1d8dfbb26/arm/omap2plus_defconfig/gcc-=
10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.165-cip25-144-g43e1d8dfbb26/arm/omap2plus_defconfig/gcc-=
10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63da3b992fd559e395915=
eda
        failing since 41 days (last pass: v5.10.155-cip21-405-g26d566555c3d=
e, first fail: v5.10.158-cip22-142-g79bb6f9db05d) =

 =



platform               | arch  | lab           | compiler | defconfig      =
              | regressions
-----------------------+-------+---------------+----------+----------------=
--------------+------------
beaglebone-black       | arm   | lab-broonie   | gcc-10   | omap2plus_defco=
nfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63da3b69794f56a1e5915eb9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.165-cip25-144-g43e1d8dfbb26/arm/omap2plus_defconfig/gcc-=
10/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.165-cip25-144-g43e1d8dfbb26/arm/omap2plus_defconfig/gcc-=
10/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63da3b69794f56a1e5915ebe
        failing since 27 days (last pass: v5.10.155-cip21-405-g26d566555c3d=
e, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2023-02-01T10:13:41.355216  <8>[   21.448829] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 228993_1.5.2.4.1>
    2023-02-01T10:13:41.512968  / # #
    2023-02-01T10:13:41.630140  export SHELL=3D/bin/sh
    2023-02-01T10:13:41.639266  #
    2023-02-01T10:13:41.645992  / # export SHELL=3D/bin/sh
    2023-02-01T10:13:41.761132  / # . /lava-228993/environment
    2023-02-01T10:13:41.875265  /lava-228993/bin/lava-test-runner /lava-228=
993/1
    2023-02-01T10:13:41.884275  . /lava-228993/environment
    2023-02-01T10:13:41.888119  / # /lava-228993/bin/lava-test-runner /lava=
-228993/1
    2023-02-01T10:13:41.990797  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform               | arch  | lab           | compiler | defconfig      =
              | regressions
-----------------------+-------+---------------+----------+----------------=
--------------+------------
cubietruck             | arm   | lab-baylibre  | gcc-10   | multi_v7_defcon=
fig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63da3a47e8a65b35b6915ec9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.165-cip25-144-g43e1d8dfbb26/arm/multi_v7_defconfig/gcc-1=
0/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.165-cip25-144-g43e1d8dfbb26/arm/multi_v7_defconfig/gcc-1=
0/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63da3a47e8a65b35b6915ece
        failing since 13 days (last pass: v5.10.155-cip21-405-g26d566555c3d=
e, first fail: v5.10.162-cip24-853-g709bb3738fde)

    2023-02-01T10:09:01.205656  <8>[   10.999067] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3263320_1.5.2.4.1>
    2023-02-01T10:09:01.317373  / # #
    2023-02-01T10:09:01.420591  export SHELL=3D/bin/sh
    2023-02-01T10:09:01.421521  #
    2023-02-01T10:09:01.523788  / # export SHELL=3D/bin/sh. /lava-3263320/e=
nvironment
    2023-02-01T10:09:01.524749  =

    2023-02-01T10:09:01.525297  / # . /lava-3263320/environment<3>[   11.29=
0426] Bluetooth: hci0: command 0xfc18 tx timeout
    2023-02-01T10:09:01.627225  /lava-3263320/bin/lava-test-runner /lava-32=
63320/1
    2023-02-01T10:09:01.628712  =

    2023-02-01T10:09:01.633567  / # /lava-3263320/bin/lava-test-runner /lav=
a-3263320/1 =

    ... (12 line(s) more)  =

 =



platform               | arch  | lab           | compiler | defconfig      =
              | regressions
-----------------------+-------+---------------+----------+----------------=
--------------+------------
mt8173-elm-hana        | arm64 | lab-collabora | gcc-10   | defconfig+arm64=
-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63da38518fb1e3c970915ef6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.165-cip25-144-g43e1d8dfbb26/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.165-cip25-144-g43e1d8dfbb26/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63da38518fb1e3c970915=
ef7
        new failure (last pass: v5.10.162-cip24-952-gf408044f5bad) =

 =



platform               | arch  | lab           | compiler | defconfig      =
              | regressions
-----------------------+-------+---------------+----------+----------------=
--------------+------------
mt8173-elm-hana        | arm64 | lab-collabora | gcc-10   | defconfig+arm..=
.ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63da39f5ab892e1a98915ee2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.165-cip25-144-g43e1d8dfbb26/arm64/defconfig+arm64-chrome=
book+kselftest/gcc-10/lab-collabora/baseline-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.165-cip25-144-g43e1d8dfbb26/arm64/defconfig+arm64-chrome=
book+kselftest/gcc-10/lab-collabora/baseline-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63da39f5ab892e1a98915=
ee3
        new failure (last pass: v5.10.162-cip24-952-gf408044f5bad) =

 =



platform               | arch  | lab           | compiler | defconfig      =
              | regressions
-----------------------+-------+---------------+----------+----------------=
--------------+------------
r8a7743-iwg20d-q7      | arm   | lab-cip       | gcc-10   | shmobile_defcon=
fig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63da3666c5b502a54a915efe

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.165-cip25-144-g43e1d8dfbb26/arm/shmobile_defconfig/gcc-1=
0/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.165-cip25-144-g43e1d8dfbb26/arm/shmobile_defconfig/gcc-1=
0/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63da3666c5b502a54a915=
eff
        failing since 97 days (last pass: v5.10.147-cip18-56-g87bd4289362be=
, first fail: v5.10.147-cip18-12-g7bc9523ecfb7f) =

 =



platform               | arch  | lab           | compiler | defconfig      =
              | regressions
-----------------------+-------+---------------+----------+----------------=
--------------+------------
rk3328-rock64          | arm64 | lab-baylibre  | gcc-10   | defconfig      =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/63da3897a4eefa610d915f23

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.165-cip25-144-g43e1d8dfbb26/arm64/defconfig/gcc-10/lab-b=
aylibre/baseline-rk3328-rock64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.165-cip25-144-g43e1d8dfbb26/arm64/defconfig/gcc-10/lab-b=
aylibre/baseline-rk3328-rock64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63da3897a4eefa610d915f28
        new failure (last pass: v5.10.145-cip17-192-gbe875d9d93504)

    2023-02-01T10:01:40.705287  [   15.987080] <LAVA_SIGNAL_ENDRUN 0_dmesg =
3263234_1.5.2.4.1>
    2023-02-01T10:01:40.809926  =

    2023-02-01T10:01:40.810193  / # [   16.029621] rockchip-drm display-sub=
system: [drm] Cannot find any crtc or sizes
    2023-02-01T10:01:40.911623  #export SHELL=3D/bin/sh
    2023-02-01T10:01:40.912092  =

    2023-02-01T10:01:41.013389  / # export SHELL=3D/bin/sh. /lava-3263234/e=
nvironment
    2023-02-01T10:01:41.013872  =

    2023-02-01T10:01:41.115250  / # . /lava-3263234/environment/lava-326323=
4/bin/lava-test-runner /lava-3263234/1
    2023-02-01T10:01:41.115917  =

    2023-02-01T10:01:41.120048  / # /lava-3263234/bin/lava-test-runner /lav=
a-3263234/1 =

    ... (13 line(s) more)  =

 =



platform               | arch  | lab           | compiler | defconfig      =
              | regressions
-----------------------+-------+---------------+----------+----------------=
--------------+------------
stm32mp157c-dk2        | arm   | lab-baylibre  | gcc-10   | multi_v7_defcon=
fig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63da3a146096e08f9e915f20

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.165-cip25-144-g43e1d8dfbb26/arm/multi_v7_defconfig/gcc-1=
0/lab-baylibre/baseline-stm32mp157c-dk2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.165-cip25-144-g43e1d8dfbb26/arm/multi_v7_defconfig/gcc-1=
0/lab-baylibre/baseline-stm32mp157c-dk2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63da3a146096e08f9e915f25
        new failure (last pass: v5.10.131-cip13-431-g420b8f43ddc46)

    2023-02-01T10:08:10.789118  <8>[   12.690853] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3263332_1.5.2.4.1>
    2023-02-01T10:08:10.896199  / # #
    2023-02-01T10:08:10.998008  export SHELL=3D/bin/sh
    2023-02-01T10:08:10.998818  #
    2023-02-01T10:08:11.100792  / # export SHELL=3D/bin/sh. /lava-3263332/e=
nvironment
    2023-02-01T10:08:11.101345  =

    2023-02-01T10:08:11.202902  / # . /lava-3263332/environment/lava-326333=
2/bin/lava-test-runner /lava-3263332/1
    2023-02-01T10:08:11.203586  =

    2023-02-01T10:08:11.208189  / # /lava-3263332/bin/lava-test-runner /lav=
a-3263332/1
    2023-02-01T10:08:11.273081  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform               | arch  | lab           | compiler | defconfig      =
              | regressions
-----------------------+-------+---------------+----------+----------------=
--------------+------------
sun50i-a64-pine64-plus | arm64 | lab-baylibre  | gcc-10   | defconfig      =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/63da3b4daf13712637915ed3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.165-cip25-144-g43e1d8dfbb26/arm64/defconfig/gcc-10/lab-b=
aylibre/baseline-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.165-cip25-144-g43e1d8dfbb26/arm64/defconfig/gcc-10/lab-b=
aylibre/baseline-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63da3b4daf13712637915ed8
        new failure (last pass: v5.10.153-cip19-122-g149fbc7cd21d)

    2023-02-01T10:12:53.301253  + set +x
    2023-02-01T10:12:53.305412  <8>[   17.132508] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3263229_1.5.2.4.1>
    2023-02-01T10:12:53.425490  / # #
    2023-02-01T10:12:53.531088  export SHELL=3D/bin/sh
    2023-02-01T10:12:53.532610  #
    2023-02-01T10:12:53.636017  / # export SHELL=3D/bin/sh. /lava-3263229/e=
nvironment
    2023-02-01T10:12:53.637534  =

    2023-02-01T10:12:53.740935  / # . /lava-3263229/environment/lava-326322=
9/bin/lava-test-runner /lava-3263229/1
    2023-02-01T10:12:53.743678  =

    2023-02-01T10:12:53.746818  / # /lava-3263229/bin/lava-test-runner /lav=
a-3263229/1 =

    ... (12 line(s) more)  =

 =



platform               | arch  | lab           | compiler | defconfig      =
              | regressions
-----------------------+-------+---------------+----------+----------------=
--------------+------------
sun50i-a64-pine64-plus | arm64 | lab-broonie   | gcc-10   | defconfig      =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/63da38c1679f89be01915ede

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.165-cip25-144-g43e1d8dfbb26/arm64/defconfig/gcc-10/lab-b=
roonie/baseline-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.165-cip25-144-g43e1d8dfbb26/arm64/defconfig/gcc-10/lab-b=
roonie/baseline-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63da38c1679f89be01915ee3
        new failure (last pass: v5.10.153-cip19-122-g149fbc7cd21d)

    2023-02-01T10:02:28.068263  + set +x
    2023-02-01T10:02:28.071460  <8>[   17.057244] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 228870_1.5.2.4.1>
    2023-02-01T10:02:28.183418  / # #
    2023-02-01T10:02:28.286227  export SHELL=3D/bin/sh
    2023-02-01T10:02:28.286811  #
    2023-02-01T10:02:28.388683  / # export SHELL=3D/bin/sh. /lava-228870/en=
vironment
    2023-02-01T10:02:28.389420  =

    2023-02-01T10:02:28.491545  / # . /lava-228870/environment/lava-228870/=
bin/lava-test-runner /lava-228870/1
    2023-02-01T10:02:28.492587  =

    2023-02-01T10:02:28.497060  / # /lava-228870/bin/lava-test-runner /lava=
-228870/1 =

    ... (12 line(s) more)  =

 =20

