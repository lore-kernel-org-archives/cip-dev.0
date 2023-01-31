Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8E0C38142
	for <webhook@archiver.kernel.org>; Tue, 31 Jan 2023 13:41:34 +0000 (UTC)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
 by mx.groups.io with SMTP id smtpd.web11.12175.1675172486514400492
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 31 Jan 2023 05:41:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=fwg/gcO9;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.173, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f173.google.com with SMTP id s67so10080289pgs.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 31 Jan 2023 05:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=t/vG91KKDnexdygqvOdVGvELYeH6YMn+3Y3wWC4lFHI=;
        b=fwg/gcO9UFs05xP7H/mkKo0BeEHjsAIQ92WTGAxlEXEVVtHVSficH20jYLBC5CfbQE
         42oxpuGYMDUarn1jCOmPUu1x4i8GU0QhfFrloEUgNf16PIKAIJ4MBXPliOAy/FdxOkyj
         aYJENNKEbV1Khf7NdIpgPI6MIkerUyhM9xxUDD8AC/zrxPd3/mRbty9uq6tSq6SrL0Hf
         NHyzrNu0iZ+d5okvYqioBOvpZtEO4Rx6838MWHGv63FWkd2eoglZbC04UGUS+dIHl+PZ
         5SA22J8licmj6c9wQzBlrwgIskOzphCCiB4asyD9xCRQTMahhVV72vCkcsMbxGWI0Wza
         2vbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t/vG91KKDnexdygqvOdVGvELYeH6YMn+3Y3wWC4lFHI=;
        b=rSRY8RqbvBt/eJAKWzNd0uGZJHvUnKNbYxYynJGtunl8Rbmws2WjKDku1mDBrtlKin
         UhJaxp781C/sxQImWKJPvhXsRnBd+QxQIU/Ev+xnM/SxxsjErbLodcoBr84DU3qml7It
         ay7e2l7tq5C+lZdGqGqFSq58bSOHO58t28veAG8AIG76qan28GB/ejQwawgqhDPkpl/o
         UNtefFi+YzHT9vtngme+U4yi5pSuxR35mHtO6Rsnlq0zTGrRp194clRBPWmkfz6reIEG
         QNSO3qe/m1QJzq3mRnIgwQjnWmSdplA1qeUxHXJDLPHmHtjRRs4AI4QoRIhgdMnayfJL
         B9tQ==
X-Gm-Message-State: AFqh2kpz8Vjx9y1QLBtxpm5AwOcfc74gZ2BrhdkixEgs0jwPZoE5ROdq
	oT/hjWRs7qgKGYFNOf4uF76h4FyjnTHYif8s6W318A==
X-Google-Smtp-Source: AMrXdXtBkdeNx/ydTpg08R4KrXthcGQKnWHqfhjTglRlvwEYndwImmuLknHlAntBYtgsGp9moBlv5w==
X-Received: by 2002:aa7:80d3:0:b0:58d:e33b:d565 with SMTP id a19-20020aa780d3000000b0058de33bd565mr41630310pfn.5.1675172484924;
        Tue, 31 Jan 2023 05:41:24 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g5-20020a056a00078500b0058d8db0e4adsm9808354pfu.171.2023.01.31.05.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 05:41:24 -0800 (PST)
Message-ID: <63d91a84.050a0220.e790b.00b2@mx.google.com>
Date: Tue, 31 Jan 2023 05:41:24 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.165-cip25
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip baseline: 163 runs,
 22 regressions (v5.10.165-cip25)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 31 Jan 2023 13:41:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10535

cip/linux-5.10.y-cip baseline: 163 runs, 22 regressions (v5.10.165-cip25)

Regressions Summary
-------------------

platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
acer-cb317-1h-c3z6-dedede | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =

asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =

at91sam9g20ek             | arm    | lab-broonie     | gcc-10   | multi_v5_=
defconfig           | 1          =

beaglebone-black          | arm    | lab-broonie     | gcc-10   | multi_v7_=
defconfig           | 1          =

beaglebone-black          | arm    | lab-broonie     | gcc-10   | omap2plus=
_defconfig          | 1          =

fsl-ls1088a-rdb           | arm64  | lab-nxp         | gcc-10   | defconfig=
                    | 1          =

imx6q-sabrelite           | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 1          =

imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | imx_v6_v7=
_defconfig          | 1          =

imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | multi_v7_=
defconfig           | 1          =

imx7d-sdb                 | arm    | lab-nxp         | gcc-10   | multi_v7_=
defconfig           | 1          =

mt8173-elm-hana           | arm64  | lab-collabora   | gcc-10   | defconfig=
+arm64-chromebook   | 1          =

rk3288-veyron-jaq         | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 4          =

rk3399-gru-kevin          | arm64  | lab-collabora   | gcc-10   | defconfig=
+arm64-chromebook   | 5          =

tegra124-nyan-big         | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.165-cip25/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.165-cip25
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      52aae1dc6afe62fedb14c89fd4feca1d8bb13416 =



Test Regressions
---------------- =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
acer-cb317-1h-c3z6-dedede | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63d90af495719a2d5f915ebd

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d90af495719a2d5f915ec2
        failing since 17 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-01-31T12:34:52.181294  + set +x
    2023-01-31T12:34:52.187912  <8>[   11.020895] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 8948451_1.4.2.3.1>
    2023-01-31T12:34:52.292389  / # #
    2023-01-31T12:34:52.393476  export SHELL=3D/bin/sh
    2023-01-31T12:34:52.393748  #
    2023-01-31T12:34:52.494636  / # export SHELL=3D/bin/sh. /lava-8948451/e=
nvironment
    2023-01-31T12:34:52.494879  =

    2023-01-31T12:34:52.595837  / # . /lava-8948451/environment/lava-894845=
1/bin/lava-test-runner /lava-8948451/1
    2023-01-31T12:34:52.596165  =

    2023-01-31T12:34:52.601425  / # /lava-8948451/bin/lava-test-runner /lav=
a-8948451/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63d90af188f3c6b195915ed8

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d90af188f3c6b195915edd
        failing since 17 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-01-31T12:34:38.097483  + set +x<8>[   10.093429] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 8948437_1.4.2.3.1>
    2023-01-31T12:34:38.097591  =

    2023-01-31T12:34:38.201051  #
    2023-01-31T12:34:38.302254  / # #export SHELL=3D/bin/sh
    2023-01-31T12:34:38.302486  =

    2023-01-31T12:34:38.403366  / # export SHELL=3D/bin/sh. /lava-8948437/e=
nvironment
    2023-01-31T12:34:38.403614  =

    2023-01-31T12:34:38.504528  / # . /lava-8948437/environment/lava-894843=
7/bin/lava-test-runner /lava-8948437/1
    2023-01-31T12:34:38.504858  =

    2023-01-31T12:34:38.506280  / # /lava-8948437/bin/lava-test-runner /lav=
a-8948437/1 =

    ... (14 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63d90af335c939365a915ebb

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d90af335c939365a915ec0
        failing since 17 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-01-31T12:34:47.319353  + set<8>[   11.195953] <LAVA_SIGNAL_ENDRUN =
0_dmesg 8948486_1.4.2.3.1>
    2023-01-31T12:34:47.319459   +x
    2023-01-31T12:34:47.423902  / # #
    2023-01-31T12:34:47.524949  export SHELL=3D/bin/sh
    2023-01-31T12:34:47.525172  #
    2023-01-31T12:34:47.626075  / # export SHELL=3D/bin/sh. /lava-8948486/e=
nvironment
    2023-01-31T12:34:47.626334  =

    2023-01-31T12:34:47.727252  / # . /lava-8948486/environment/lava-894848=
6/bin/lava-test-runner /lava-8948486/1
    2023-01-31T12:34:47.727593  =

    2023-01-31T12:34:47.732632  / # /lava-8948486/bin/lava-test-runner /lav=
a-8948486/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
at91sam9g20ek             | arm    | lab-broonie     | gcc-10   | multi_v5_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63d90f4aa62ee9caa8915fc4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d90f4aa62ee9caa8915fc9
        failing since 17 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-01-31T12:53:19.757461  + set +x
    2023-01-31T12:53:19.762625  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 219651_1.5.2=
.4.1>
    2023-01-31T12:53:19.877410  / # #
    2023-01-31T12:53:19.980519  export SHELL=3D/bin/sh
    2023-01-31T12:53:19.981342  #
    2023-01-31T12:53:20.083326  / # export SHELL=3D/bin/sh. /lava-219651/en=
vironment
    2023-01-31T12:53:20.084169  =

    2023-01-31T12:53:20.186238  / # . /lava-219651/environment/lava-219651/=
bin/lava-test-runner /lava-219651/1
    2023-01-31T12:53:20.187670  =

    2023-01-31T12:53:20.194069  / # /lava-219651/bin/lava-test-runner /lava=
-219651/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
beaglebone-black          | arm    | lab-broonie     | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63d910961844bdd1e3915eea

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d910961844bdd1e3915eef
        failing since 17 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-01-31T12:58:31.418918  <8>[   22.135661] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 219794_1.5.2.4.1>
    2023-01-31T12:58:31.581138  / # #
    2023-01-31T12:58:31.699374  export SHELL=3D/bin/sh
    2023-01-31T12:58:31.704996  #
    2023-01-31T12:58:31.814744  / # export SHELL=3D/bin/sh. /lava-219794/en=
vironment
    2023-01-31T12:58:31.820112  =

    2023-01-31T12:58:31.929830  / # . /lava-219794/environment/lava-219794/=
bin/lava-test-runner /lava-219794/1
    2023-01-31T12:58:31.938777  =

    2023-01-31T12:58:31.942606  / # /lava-219794/bin/lava-test-runner /lava=
-219794/1
    2023-01-31T12:58:32.038354  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
beaglebone-black          | arm    | lab-broonie     | gcc-10   | omap2plus=
_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63d90f9c683c995c0a915ee7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d90f9c683c995c0a915eec
        failing since 17 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-01-31T12:54:35.003311  <8>[   19.998336] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 219658_1.5.2.4.1>
    2023-01-31T12:54:35.111324  / # #
    2023-01-31T12:54:35.213045  export SHELL=3D/bin/sh
    2023-01-31T12:54:35.213716  #
    2023-01-31T12:54:35.315116  / # export SHELL=3D/bin/sh. /lava-219658/en=
vironment
    2023-01-31T12:54:35.315555  =

    2023-01-31T12:54:35.417073  / # . /lava-219658/environment/lava-219658/=
bin/lava-test-runner /lava-219658/1
    2023-01-31T12:54:35.418072  =

    2023-01-31T12:54:35.423445  / # /lava-219658/bin/lava-test-runner /lava=
-219658/1
    2023-01-31T12:54:35.532130  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
fsl-ls1088a-rdb           | arm64  | lab-nxp         | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63d9159ebdbdadf8ea915ebc

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1088a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d9159ebdbdadf8ea915ebf
        failing since 17 days (last pass: v5.10.155-cip21, first fail: v5.1=
0.162-cip24)

    2023-01-31T13:20:15.768842  [   14.879681] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1149829_1.5.2.4.1>
    2023-01-31T13:20:15.875791  / # #
    2023-01-31T13:20:15.977542  export SHELL=3D/bin/sh
    2023-01-31T13:20:15.977983  #
    2023-01-31T13:20:16.079339  / # export SHELL=3D/bin/sh. /lava-1149829/e=
nvironment
    2023-01-31T13:20:16.079722  =

    2023-01-31T13:20:16.180818  / # . /lava-1149829/environment/lava-114982=
9/bin/lava-test-runner /lava-1149829/1
    2023-01-31T13:20:16.181354  =

    2023-01-31T13:20:16.183295  / # /lava-1149829/bin/lava-test-runner /lav=
a-1149829/1
    2023-01-31T13:20:16.202330  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6q-sabrelite           | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63d90f9d29a2c44f16915efd

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d90f9d29a2c44f16915f02
        failing since 17 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-01-31T12:54:48.042615  / # #
    2023-01-31T12:54:48.144835  export SHELL=3D/bin/sh
    2023-01-31T12:54:48.145690  #
    2023-01-31T12:54:48.247997  / # export SHELL=3D/bin/sh. /lava-8948775/e=
nvironment
    2023-01-31T12:54:48.248900  =

    2023-01-31T12:54:48.351069  / # . /lava-8948775/environment/lava-894877=
5/bin/lava-test-runner /lava-8948775/1
    2023-01-31T12:54:48.352384  =

    2023-01-31T12:54:48.365052  / # /lava-8948775/bin/lava-test-runner /lav=
a-8948775/1
    2023-01-31T12:54:48.457885  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-31T12:54:48.458451  + cd /lava-8948775/1/tests/1_bootrr =

    ... (14 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | imx_v6_v7=
_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63d90d493443bba2b4915eb9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandb=
oard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandb=
oard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d90d493443bba2b4915ebe
        failing since 17 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-01-31T12:44:34.898823  + set +x
    2023-01-31T12:44:34.898993  [   11.765128] <LAVA_SIGNAL_ENDRUN 0_dmesg =
892838_1.5.2.3.1>
    2023-01-31T12:44:35.007449  / # #
    2023-01-31T12:44:35.109225  export SHELL=3D/bin/sh
    2023-01-31T12:44:35.109726  #
    2023-01-31T12:44:35.211039  / # export SHELL=3D/bin/sh. /lava-892838/en=
vironment
    2023-01-31T12:44:35.211410  =

    2023-01-31T12:44:35.312728  / # . /lava-892838/environment/lava-892838/=
bin/lava-test-runner /lava-892838/1
    2023-01-31T12:44:35.313372  =

    2023-01-31T12:44:35.316032  / # /lava-892838/bin/lava-test-runner /lava=
-892838/1 =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63d90f8d683c995c0a915ebe

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandbo=
ard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandbo=
ard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d90f8d683c995c0a915ec3
        failing since 17 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-01-31T12:54:12.743973  + set[    7.303200] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 892852_1.5.2.3.1>
    2023-01-31T12:54:12.744373   +x
    2023-01-31T12:54:12.849970  / # #
    2023-01-31T12:54:12.955523  export SHELL=3D/bin/sh
    2023-01-31T12:54:12.959998  #
    2023-01-31T12:54:13.061527  / # export SHELL=3D/bin/sh. /lava-892852/en=
vironment
    2023-01-31T12:54:13.062129  =

    2023-01-31T12:54:13.163524  / # . /lava-892852/environment/lava-892852/=
bin/lava-test-runner /lava-892852/1
    2023-01-31T12:54:13.164376  =

    2023-01-31T12:54:13.167037  / # /lava-892852/bin/lava-test-runner /lava=
-892852/1 =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx7d-sdb                 | arm    | lab-nxp         | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63d90fb9983523f4b4915ee0

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d90fb9983523f4b4915ee3
        failing since 17 days (last pass: v5.10.155-cip21, first fail: v5.1=
0.162-cip24)

    2023-01-31T12:55:01.202228  + set<8>[   17.222547] <LAVA_SIGNAL_ENDRUN =
0_dmesg 1149802_1.5.2.4.1>
    2023-01-31T12:55:01.202478   +x
    2023-01-31T12:55:01.308003  / # #
    2023-01-31T12:55:02.468081  export SHELL=3D/bin/sh
    2023-01-31T12:55:02.473793  #
    2023-01-31T12:55:04.021233  / # export SHELL=3D/bin/sh. /lava-1149802/e=
nvironment
    2023-01-31T12:55:04.026967  =

    2023-01-31T12:55:06.848385  / # . /lava-1149802/environment/lava-114980=
2/bin/lava-test-runner /lava-1149802/1
    2023-01-31T12:55:06.854462  =

    2023-01-31T12:55:06.858314  / # /lava-1149802/bin/lava-test-runner /lav=
a-1149802/1 =

    ... (20 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
mt8173-elm-hana           | arm64  | lab-collabora   | gcc-10   | defconfig=
+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63d90d25e293a57a67915efa

  Results:     28 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt817=
3-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt817=
3-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d90d25e293a57a67915f16
        failing since 17 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-01-31T12:43:59.868547  <8>[   15.679619] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-01-31T12:43:59.869810  + set +x
    2023-01-31T12:43:59.876091  <8>[   15.689148] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 8948544_1.5.2.3.1>
    2023-01-31T12:43:59.980725  #
    2023-01-31T12:44:00.081932  / # #export SHELL=3D/bin/sh
    2023-01-31T12:44:00.082204  =

    2023-01-31T12:44:00.183390  / # export SHELL=3D/bin/sh. /lava-8948544/e=
nvironment
    2023-01-31T12:44:00.184151  =

    2023-01-31T12:44:00.285922  / # . /lava-8948544/environment/lava-894854=
4/bin/lava-test-runner /lava-8948544/1
    2023-01-31T12:44:00.287297   =

    ... (16 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
rk3288-veyron-jaq         | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 4          =


  Details:     https://kernelci.org/test/plan/id/63d90fd97fec034a44915ed5

  Results:     63 PASS, 8 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-j=
aq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-j=
aq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-i2c-present: https://kernelci.or=
g/test/case/id/63d90fd97fec034a44915f04
        failing since 15 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-01-31T12:55:29.914599  =

    2023-01-31T12:55:29.915606   INC default to 1.
    2023-01-31T12:55:29.916092  =

    2023-01-31T12:55:29.916309  =

    2023-01-31T12:55:29.919094  	-w	Pad to last with leading zeros
    2023-01-31T12:55:29.919570  =

    2023-01-31T12:55:29.921606  	-s SEP	String separator
    2023-01-31T12:55:29.925540  /lava-8948776/1/../bin/lava-test-case
    2023-01-31T12:55:29.931532  BusyBox v1.31.1 (2023-01-27 15:57:34 UTC) m=
ulti-call binary.
    2023-01-31T12:55:29.932014   =

    ... (1 line(s) more)  =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/63d90fd97fec034a44915f05
        failing since 15 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-01-31T12:55:29.893541   multi-call binary.
    2023-01-31T12:55:29.893757  =

    2023-01-31T12:55:29.897881  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST
    2023-01-31T12:55:29.898349  =

    2023-01-31T12:55:29.898829  =

    2023-01-31T12:55:29.903292  Print numbers from FIRST to LAST, in steps =
of INC.
    2023-01-31T12:55:29.913448  FIRST,<8>[   21.251071] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/63d90fd97fec034a44915f06
        failing since 15 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-01-31T12:55:29.873532  =

    2023-01-31T12:55:29.891355  BusyBox v1.31.1 (2023-01-27 15:57:34 UTC)<8=
>[   21.232189] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d90fd97fec034a44915f1a
        failing since 15 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-01-31T12:55:17.833573  + <8>[    9.140626] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 8948776_1.5.2.3.1>
    2023-01-31T12:55:17.834037  set +x
    2023-01-31T12:55:17.835887  =

    2023-01-31T12:55:17.939328  / # #
    2023-01-31T12:55:18.041229  export SHELL=3D/bin/sh
    2023-01-31T12:55:18.041764  #
    2023-01-31T12:55:18.143092  / # export SHELL=3D/bin/sh. /lava-8948776/e=
nvironment
    2023-01-31T12:55:18.143489  =

    2023-01-31T12:55:18.244874  / # . /lava-8948776/environment/lava-894877=
6/bin/lava-test-runner /lava-8948776/1
    2023-01-31T12:55:18.245520   =

    ... (26 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora   | gcc-10   | defconfig=
+arm64-chromebook   | 5          =


  Details:     https://kernelci.org/test/plan/id/63d90cc6056246433c915ef0

  Results:     86 PASS, 6 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk339=
9-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk339=
9-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/case/id=
/63d90cc6056246433c915f12
        failing since 308 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81,=
 first fail: v5.10.106-cip4)

    2023-01-31T12:42:38.234605  <8>[   32.806888] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s0-probed RESULT=3Dpass>
    2023-01-31T12:42:39.259942  /lava-8948545/1/../bin/lava-test-case   =


  * baseline.bootrr.rk3399-gru-sound-driver-rt5514-present: https://kernelc=
i.org/test/case/id/63d90cc6056246433c915f27
        failing since 17 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-01-31T12:42:37.531167  BusyBox v1.31.1 (2023-01-27 <8>[   32.10109=
2] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Drk3399-gru-sound-driver-max98357A-p=
resent RESULT=3Dfail>
    2023-01-31T12:42:37.544306  15:57:07 UTC) multi-call binary.
    2023-01-31T12:42:37.544883  =

    2023-01-31T12:42:37.548802  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST
    2023-01-31T12:42:37.549083  =

    2023-01-31T12:42:37.564009  Print numbers from FIRST to LAST, in steps =
of<8>[   32.133615] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Drk3399-gru-sound-d=
river-rt5514-present RESULT=3Dfail>   =


  * baseline.bootrr.rk3399-gru-sound-driver-max98357A-present: https://kern=
elci.org/test/case/id/63d90cc6056246433c915f28
        failing since 17 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-01-31T12:42:37.500360  =

    2023-01-31T12:42:37.510850  -w	Pad to last with leading zeros
    2023-01-31T12:42:37.513771  	-s SEP	String separator
    2023-01-31T12:42:37.514407  =

    2023-01-31T12:42:37.517169  /lava-8948545/1/../bin/lava-test-case
    2023-01-31T12:42:37.517634     =


  * baseline.bootrr.rk3399-gru-sound-driver-dp-present: https://kernelci.or=
g/test/case/id/63d90cc6056246433c915f29
        failing since 17 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-01-31T12:42:37.481135  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST
    2023-01-31T12:42:37.481796  =

    2023-01-31T12:42:37.482078  =

    2023-01-31T12:42:37.487088  Print numbers from FIRST to LAST, in steps =
of INC.
    2023-01-31T12:42:37.489797  FIRST, INC default to 1.
    2023-01-31T12:42:37.489892  =

    2023-01-31T12:42:37.499652  	<8>[   32.068597] <LAVA_SIGNAL_TESTCASE TE=
ST_CASE_ID=3Drk3399-gru-sound-driver-dp-present RESULT=3Dfail>   =


  * baseline.bootrr.rk3399-gru-sound-driver-da7219-present: https://kernelc=
i.org/test/case/id/63d90cc6056246433c915f4a
        failing since 17 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-01-31T12:42:37.457715  BusyBox v1.31.1 (2023-01-27 15:57:07 UTC) m=
ulti-call binary.
    2023-01-31T12:42:37.457995  =

    2023-01-31T12:42:37.458075  =

    2023-01-31T12:42:37.468339  <8>[   32.037943] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-da7219-present RESULT=3Dfail>   =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
tegra124-nyan-big         | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63d91029eccf8d9a76915eea

  Results:     5 PASS, 2 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-tegra124-nyan-b=
ig.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-tegra124-nyan-b=
ig.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d91029eccf8d9a76915eef
        failing since 15 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-01-31T12:56:40.348663  <8>[   17.522765] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-01-31T12:56:40.352974  + set +x
    2023-01-31T12:56:40.355888  <8>[   17.533492] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 8948791_1.5.2.3.1>
    2023-01-31T12:56:40.463277  #
    2023-01-31T12:56:40.565709  / # #export SHELL=3D/bin/sh
    2023-01-31T12:56:40.566525  =

    2023-01-31T12:56:40.669307  / # export SHELL=3D/bin/sh. /lava-8948791/e=
nvironment
    2023-01-31T12:56:40.670047  =

    2023-01-31T12:56:40.771483  / # . /lava-8948791/environment/lava-894879=
1/bin/lava-test-runner /lava-8948791/1
    2023-01-31T12:56:40.772440   =

    ... (19 line(s) more)  =

 =20

