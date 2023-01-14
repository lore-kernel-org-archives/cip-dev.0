Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF761C54EBE
	for <webhook@archiver.kernel.org>; Sat, 14 Jan 2023 03:00:19 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web10.108683.1673665217112577747
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 13 Jan 2023 19:00:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=FSo3Cvgq;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.177, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f177.google.com with SMTP id d9so25227734pll.9
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 13 Jan 2023 19:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GAL9Qm6DXkLW+orN4Dmddt1/CU6uYlq7/wj7ub79giM=;
        b=FSo3CvgqiUoPe80+cLS2OH/iyCSzwunVPU9KKoQgAOqq4ZbDrf3i3d+tCdAzzxyd8t
         b9gOG43H/D7mcuUPnuabMN2cbU3gZgfBTqzc/cGS4ZbBJhB6+2LCy3qJVMAqVDf6JtP0
         D0813qE77aY0+K8GKD4XiLy/+MnhNeSzw9Gqhl1WxUzKvLCzFGej2N650kOSOMimaE6P
         LKooCZFSjrf1W6gEubA3x0K9kc29vUuWMSy6iIPxpHCocvRhJNqG5mIRK2xYXJvWW+29
         g98+4pii5mIUuC3JPmFHrkKNdvm0YFpAzRgSXNQn+YwjQxhdFZGIB+UtphNEk1FMc2bK
         RE0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GAL9Qm6DXkLW+orN4Dmddt1/CU6uYlq7/wj7ub79giM=;
        b=KkzbFiMaYhyM7X10aXC88AC1dHT+q296icOp+Xj0AvHk46tNiHh9UFz6eVQ4+V+nBi
         vNrYzmqBuXwryISLu9CiCXdWA3LrSMwwkf/zauTVITm8bm8R6VTtciIo4NDhQGbvzuhI
         Kdjkx6WHyqDsJNfZskQVklIQ41UDjgLeCgDRljcNPYXq1qEhd+9gdZS923lUpj0R0Vgm
         QF1eKWdwKKA45vvgmqdxvxpfgv0fvU20J3/pTuZa4hBs2Fu5qKa4FOTWB6V50x4lbHoV
         vMFPMoFMqEIkLiAy0Qjq6l8yzQxRneAfQbTImHvIdnA0Zh8Pll/fPjSdGPvNyJUKOF7O
         CDXw==
X-Gm-Message-State: AFqh2koC2K1DmdYIxo3ItPZWKMMPKpOLP7vILdFcBZM0PAt1ayOB8hDl
	w4yiDa1J/EZn67x4g862qdhb761m9VO0lZqSHuw=
X-Google-Smtp-Source: AMrXdXuYq/7l4EgI6ZctFp5NHEZjeiYSDovkNaMt4T1J4iUahDRS6WA5ISzUktJECM0GhnjfZBOxDA==
X-Received: by 2002:a17:902:f293:b0:193:262e:f6fa with SMTP id k19-20020a170902f29300b00193262ef6famr19702850plc.19.1673665215862;
        Fri, 13 Jan 2023 19:00:15 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y2-20020a17090264c200b001930b7e2c04sm11841384pli.287.2023.01.13.19.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 19:00:15 -0800 (PST)
Message-ID: <63c21abf.170a0220.7db70.4351@mx.google.com>
Date: Fri, 13 Jan 2023 19:00:15 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.162-cip24
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip baseline: 105 runs,
 21 regressions (v5.10.162-cip24)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 14 Jan 2023 03:00:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10351

cip/linux-5.10.y-cip baseline: 105 runs, 21 regressions (v5.10.162-cip24)

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

beaglebone-black          | arm    | lab-cip         | gcc-10   | omap2plus=
_defconfig          | 1          =

fsl-ls1088a-rdb           | arm64  | lab-nxp         | gcc-10   | defconfig=
                    | 1          =

imx6q-sabrelite           | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 1          =

imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | imx_v6_v7=
_defconfig          | 1          =

imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | multi_v7_=
defconfig           | 1          =

imx6sx-sdb                | arm    | lab-nxp         | gcc-10   | multi_v7_=
defconfig           | 1          =

imx7d-sdb                 | arm    | lab-nxp         | gcc-10   | multi_v7_=
defconfig           | 1          =

mt8173-elm-hana           | arm64  | lab-collabora   | gcc-10   | defconfig=
+arm64-chromebook   | 1          =

r8a7743-iwg20d-q7         | arm    | lab-cip         | gcc-10   | shmobile_=
defconfig           | 1          =

rk3399-gru-kevin          | arm64  | lab-collabora   | gcc-10   | defconfig=
+arm64-chromebook   | 5          =

sun50i-a64-pine64-plus    | arm64  | lab-broonie     | gcc-10   | defconfig=
                    | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.162-cip24/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.162-cip24
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      7ef5f1fda52a95426084959dac09acdb3c81327b =



Test Regressions
---------------- =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
acer-cb317-1h-c3z6-dedede | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c20de1743284d14c1d3a10

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230109.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c20de2743284d14c1d3a15
        new failure (last pass: v5.10.158-cip22-7-g92462fd9830b)

    2023-01-14T02:04:56.601911  + set +x
    2023-01-14T02:04:56.608848  <8>[   10.115539] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 8713786_1.4.2.3.1>
    2023-01-14T02:04:56.713531  / # #
    2023-01-14T02:04:56.814549  export SHELL=3D/bin/sh
    2023-01-14T02:04:56.814785  #
    2023-01-14T02:04:56.915674  / # export SHELL=3D/bin/sh. /lava-8713786/e=
nvironment
    2023-01-14T02:04:56.915922  =

    2023-01-14T02:04:57.016845  / # . /lava-8713786/environment/lava-871378=
6/bin/lava-test-runner /lava-8713786/1
    2023-01-14T02:04:57.017184  =

    2023-01-14T02:04:57.022542  / # /lava-8713786/bin/lava-test-runner /lav=
a-8713786/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c20dcebbbc3ac89f1d39c3

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230109.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c20dcebbbc3ac89f1d39c8
        new failure (last pass: v5.10.158-cip22-7-g92462fd9830b)

    2023-01-14T02:04:49.667398  + set<8>[   10.377914] <LAVA_SIGNAL_ENDRUN =
0_dmesg 8713774_1.4.2.3.1>
    2023-01-14T02:04:49.667499   +x
    2023-01-14T02:04:49.769517  /#
    2023-01-14T02:04:49.870734   # #export SHELL=3D/bin/sh
    2023-01-14T02:04:49.870921  =

    2023-01-14T02:04:49.971779  / # export SHELL=3D/bin/sh. /lava-8713774/e=
nvironment
    2023-01-14T02:04:49.971973  =

    2023-01-14T02:04:50.072880  / # . /lava-8713774/environment/lava-871377=
4/bin/lava-test-runner /lava-8713774/1
    2023-01-14T02:04:50.073166  =

    2023-01-14T02:04:50.078060  / # /lava-8713774/bin/lava-test-runner /lav=
a-8713774/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c20e3218d7e014b01d39f2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230109.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c20e3218d7e014b01d39f7
        new failure (last pass: v5.10.158-cip22-7-g92462fd9830b)

    2023-01-14T02:06:25.085006  + set<8>[   10.270571] <LAVA_SIGNAL_ENDRUN =
0_dmesg 8713777_1.4.2.3.1>
    2023-01-14T02:06:25.085097   +x
    2023-01-14T02:06:25.189427  / # #
    2023-01-14T02:06:25.290503  export SHELL=3D/bin/sh
    2023-01-14T02:06:25.290767  #
    2023-01-14T02:06:25.391684  / # export SHELL=3D/bin/sh. /lava-8713777/e=
nvironment
    2023-01-14T02:06:25.391915  =

    2023-01-14T02:06:25.492808  / # . /lava-8713777/environment/lava-871377=
7/bin/lava-test-runner /lava-8713777/1
    2023-01-14T02:06:25.493130  =

    2023-01-14T02:06:25.497815  / # /lava-8713777/bin/lava-test-runner /lav=
a-8713777/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
at91sam9g20ek             | arm    | lab-broonie     | gcc-10   | multi_v5_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63c20cda1a8cfd6e561d39c3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230109.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c20cda1a8cfd6e561d39c8
        new failure (last pass: v5.10.158-cip22-7-g92462fd9830b)

    2023-01-14T02:00:46.993648  + set +x
    2023-01-14T02:00:46.998807  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 109976_1.5.2=
.4.1>
    2023-01-14T02:00:47.113281  / # #
    2023-01-14T02:00:47.216143  export SHELL=3D/bin/sh
    2023-01-14T02:00:47.216956  #
    2023-01-14T02:00:47.318998  / # export SHELL=3D/bin/sh. /lava-109976/en=
vironment
    2023-01-14T02:00:47.319800  =

    2023-01-14T02:00:47.421764  / # . /lava-109976/environment/lava-109976/=
bin/lava-test-runner /lava-109976/1
    2023-01-14T02:00:47.423080  =

    2023-01-14T02:00:47.429594  / # /lava-109976/bin/lava-test-runner /lava=
-109976/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
beaglebone-black          | arm    | lab-broonie     | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63c2110e97a3f0b37e1d39ff

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230109.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c2110e97a3f0b37e1d3a04
        new failure (last pass: v5.10.158-cip22-7-g92462fd9830b)

    2023-01-14T02:18:40.620283  <8>[   18.519766] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 110092_1.5.2.4.1>
    2023-01-14T02:18:40.731409  / # #
    2023-01-14T02:18:40.834078  export SHELL=3D/bin/sh
    2023-01-14T02:18:40.834812  #
    2023-01-14T02:18:40.936789  / # export SHELL=3D/bin/sh. /lava-110092/en=
vironment
    2023-01-14T02:18:40.937656  =

    2023-01-14T02:18:41.039717  / # . /lava-110092/environment/lava-110092/=
bin/lava-test-runner /lava-110092/1
    2023-01-14T02:18:41.041118  =

    2023-01-14T02:18:41.045637  / # /lava-110092/bin/lava-test-runner /lava=
-110092/1
    2023-01-14T02:18:41.139480  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
beaglebone-black          | arm    | lab-broonie     | gcc-10   | omap2plus=
_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63c20e3dfe8421e2431d39e0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230109.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c20e3dfe8421e2431d39e5
        new failure (last pass: v5.10.158-cip22-7-g92462fd9830b)

    2023-01-14T02:06:40.019835  <8>[   19.144930] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 109990_1.5.2.4.1>
    2023-01-14T02:06:40.138226  / # #
    2023-01-14T02:06:40.241148  export SHELL=3D/bin/sh
    2023-01-14T02:06:40.242574  #
    2023-01-14T02:06:40.344679  / # export SHELL=3D/bin/sh. /lava-109990/en=
vironment
    2023-01-14T02:06:40.345927  =

    2023-01-14T02:06:40.449273  / # . /lava-109990/environment/lava-109990/=
bin/lava-test-runner /lava-109990/1
    2023-01-14T02:06:40.451038  =

    2023-01-14T02:06:40.455582  / # /lava-109990/bin/lava-test-runner /lava=
-109990/1
    2023-01-14T02:06:40.554341  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
beaglebone-black          | arm    | lab-cip         | gcc-10   | omap2plus=
_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63c21a77193261dc1e1d3a0e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230109.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c21a77193261dc1e1d3a11
        new failure (last pass: v5.10.158-cip22-7-g92462fd9830b)

    2023-01-14T02:58:49.858011  <8>[   13.060864] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 824920_1.5.2.4.1>
    2023-01-14T02:58:49.968152  / # #
    2023-01-14T02:58:50.070314  export SHELL=3D/bin/sh
    2023-01-14T02:58:50.070753  #
    2023-01-14T02:58:50.172176  / # export SHELL=3D/bin/sh. /lava-824920/en=
vironment
    2023-01-14T02:58:50.172584  =

    2023-01-14T02:58:50.274107  / # . /lava-824920/environment/lava-824920/=
bin/lava-test-runner /lava-824920/1
    2023-01-14T02:58:50.275182  =

    2023-01-14T02:58:50.280608  / # /lava-824920/bin/lava-test-runner /lava=
-824920/1
    2023-01-14T02:58:50.387038  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
fsl-ls1088a-rdb           | arm64  | lab-nxp         | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c20ed81d3f4831b11d39d9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1088a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230109.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c20ed81d3f4831b11d39dc
        new failure (last pass: v5.10.155-cip21)

    2023-01-14T02:09:11.308218  + [   13.600064] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 1136714_1.5.2.4.1>
    2023-01-14T02:09:11.308518  set +x
    2023-01-14T02:09:11.414112  / # #
    2023-01-14T02:09:11.515931  export SHELL=3D/bin/sh
    2023-01-14T02:09:11.516374  #
    2023-01-14T02:09:11.617724  / # export SHELL=3D/bin/sh. /lava-1136714/e=
nvironment
    2023-01-14T02:09:11.618163  =

    2023-01-14T02:09:11.719528  / # . /lava-1136714/environment/lava-113671=
4/bin/lava-test-runner /lava-1136714/1
    2023-01-14T02:09:11.720234  =

    2023-01-14T02:09:11.722273  / # /lava-1136714/bin/lava-test-runner /lav=
a-1136714/1 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6q-sabrelite           | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63c21078e681ceb6061d39c2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230109.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c21078e681ceb6061d39c7
        new failure (last pass: v5.10.158-cip22-7-g92462fd9830b)

    2023-01-14T02:16:17.319053  / # #
    2023-01-14T02:16:17.422236  export SHELL=3D/bin/sh
    2023-01-14T02:16:17.423061  #
    2023-01-14T02:16:17.525310  / # export SHELL=3D/bin/sh. /lava-8713909/e=
nvironment
    2023-01-14T02:16:17.526138  =

    2023-01-14T02:16:17.628449  / # . /lava-8713909/environment/lava-871390=
9/bin/lava-test-runner /lava-8713909/1
    2023-01-14T02:16:17.629704  =

    2023-01-14T02:16:17.641440  / # /lava-8713909/bin/lava-test-runner /lav=
a-8713909/1
    2023-01-14T02:16:17.745616  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-14T02:16:17.746151  + cd /lava-8713909/1/tests/1_bootrr =

    ... (14 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | imx_v6_v7=
_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63c21031107f57ffad1d39c2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandb=
oard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandb=
oard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230109.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c21031107f57ffad1d39c7
        new failure (last pass: v5.10.158-cip22-7-g92462fd9830b)

    2023-01-14T02:14:50.370705  + set +x
    2023-01-14T02:14:50.371092  [   11.415228] <LAVA_SIGNAL_ENDRUN 0_dmesg =
879511_1.5.2.3.1>
    2023-01-14T02:14:50.479572  / # #
    2023-01-14T02:14:50.581317  export SHELL=3D/bin/sh
    2023-01-14T02:14:50.581883  #
    2023-01-14T02:14:50.683293  / # export SHELL=3D/bin/sh. /lava-879511/en=
vironment
    2023-01-14T02:14:50.683848  =

    2023-01-14T02:14:50.785168  / # . /lava-879511/environment/lava-879511/=
bin/lava-test-runner /lava-879511/1
    2023-01-14T02:14:50.786005  =

    2023-01-14T02:14:50.788656  / # /lava-879511/bin/lava-test-runner /lava=
-879511/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63c21080340ab063a01d39fe

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandbo=
ard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandbo=
ard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230109.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c21080340ab063a01d3a03
        new failure (last pass: v5.10.158-cip22-7-g92462fd9830b)

    2023-01-14T02:16:10.964146  + set[    7.183104] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 879517_1.5.2.3.1>
    2023-01-14T02:16:10.964362   +x
    2023-01-14T02:16:11.069596  / # #
    2023-01-14T02:16:11.171526  export SHELL=3D/bin/sh
    2023-01-14T02:16:11.172111  #
    2023-01-14T02:16:11.273441  / # export SHELL=3D/bin/sh. /lava-879517/en=
vironment
    2023-01-14T02:16:11.273916  =

    2023-01-14T02:16:11.375142  / # . /lava-879517/environment/lava-879517/=
bin/lava-test-runner /lava-879517/1
    2023-01-14T02:16:11.375662  =

    2023-01-14T02:16:11.378445  / # /lava-879517/bin/lava-test-runner /lava=
-879517/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6sx-sdb                | arm    | lab-nxp         | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63c2111f069af088af1d39fd

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx6sx-sdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx6sx-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230109.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c2111f069af088af1d3a00
        new failure (last pass: v5.10.153-cip19-3-gc76f4e7e5c71)

    2023-01-14T02:18:51.135338  <8>[   23.325160] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1136719_1.5.2.4.1>
    2023-01-14T02:18:51.240994  / # #
    2023-01-14T02:18:52.401284  export SHELL=3D/bin/sh
    2023-01-14T02:18:52.406987  #
    2023-01-14T02:18:53.954799  / # export SHELL=3D/bin/sh. /lava-1136719/e=
nvironment
    2023-01-14T02:18:53.960520  =

    2023-01-14T02:18:53.960825  / # . /lava-1136719/environment
    2023-01-14T02:18:56.783478  / # /lava-1136719/bin/lava-test-runner /lav=
a-1136719/1
    2023-01-14T02:18:56.800993  /lava-1136719/bin/lava-test-runner /lava-11=
36719/1
    2023-01-14T02:18:56.893482  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (19 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx7d-sdb                 | arm    | lab-nxp         | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63c2110b069af088af1d39c2

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230109.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c2110b069af088af1d39c5
        new failure (last pass: v5.10.155-cip21)

    2023-01-14T02:18:32.083395  + set<8>[   17.112396] <LAVA_SIGNAL_ENDRUN =
0_dmesg 1136721_1.5.2.4.1>
    2023-01-14T02:18:32.083647   +x
    2023-01-14T02:18:32.188946  / # #
    2023-01-14T02:18:33.349263  export SHELL=3D/bin/sh
    2023-01-14T02:18:33.354943  #
    2023-01-14T02:18:34.902419  / # export SHELL=3D/bin/sh. /lava-1136721/e=
nvironment
    2023-01-14T02:18:34.908097  =

    2023-01-14T02:18:37.730619  / # . /lava-1136721/environment/lava-113672=
1/bin/lava-test-runner /lava-1136721/1
    2023-01-14T02:18:37.736728  =

    2023-01-14T02:18:37.743260  / # /lava-1136721/bin/lava-test-runner /lav=
a-1136721/1 =

    ... (20 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
mt8173-elm-hana           | arm64  | lab-collabora   | gcc-10   | defconfig=
+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63c20ee652593642af1d39e8

  Results:     28 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt817=
3-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt817=
3-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230109.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c20ee652593642af1d3a04
        new failure (last pass: v5.10.158-cip22-7-g92462fd9830b)

    2023-01-14T02:09:27.887067  + set +x
    2023-01-14T02:09:27.891489  <8>[   15.337873] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 8713878_1.5.2.3.1>
    2023-01-14T02:09:27.892206  =

    2023-01-14T02:09:27.996489  /#
    2023-01-14T02:09:28.099907   # #export SHELL=3D/bin/sh
    2023-01-14T02:09:28.100779  =

    2023-01-14T02:09:28.202765  / # export SHELL=3D/bin/sh. /lava-8713878/e=
nvironment
    2023-01-14T02:09:28.203647  =

    2023-01-14T02:09:28.305720  / # . /lava-8713878/environment/lava-871387=
8/bin/lava-test-runner /lava-8713878/1
    2023-01-14T02:09:28.307039   =

    ... (20 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
r8a7743-iwg20d-q7         | arm    | lab-cip         | gcc-10   | shmobile_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63c20c9f77bf4b79021d3ab8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230109.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c20c9f77bf4b79021d3=
ab9
        failing since 35 days (last pass: v5.10.154-cip20, first fail: v5.1=
0.158-cip22) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora   | gcc-10   | defconfig=
+arm64-chromebook   | 5          =


  Details:     https://kernelci.org/test/plan/id/63c212ba1c583e74e21d39ce

  Results:     86 PASS, 6 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk339=
9-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk339=
9-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230109.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/case/id=
/63c212bb1c583e74e21d39f0
        failing since 290 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81,=
 first fail: v5.10.106-cip4)

    2023-01-14T02:25:48.531398  /lava-8713868/1/../bin/lava-test-case
    2023-01-14T02:25:48.531761  =

    2023-01-14T02:25:48.542245  <8>[   59.647506] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =


  * baseline.bootrr.rk3399-gru-sound-driver-rt5514-present: https://kernelc=
i.org/test/case/id/63c212bb1c583e74e21d3a05
        new failure (last pass: v5.10.158-cip22-7-g92462fd9830b)

    2023-01-14T02:25:46.996063  RST [INC]] LAST
    2023-01-14T02:25:46.996691  =

    2023-01-14T02:25:46.996776  =

    2023-01-14T02:25:47.001916  Print numbers from FIRST to LAST, in steps =
of INC.
    2023-01-14T02:25:47.003724  FIRST, INC default to 1.
    2023-01-14T02:25:47.004247  =

    2023-01-14T02:25:47.004333  =

    2023-01-14T02:25:47.016646  	-w	Pad to last with leading <8>[   58.1192=
45] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Drk3399-gru-sound-driver-rt5514-pre=
sent RESULT=3Dfail>   =


  * baseline.bootrr.rk3399-gru-sound-driver-max98357A-present: https://kern=
elci.org/test/case/id/63c212bb1c583e74e21d3a06
        new failure (last pass: v5.10.158-cip22-7-g92462fd9830b)

    2023-01-14T02:25:46.971712  =

    2023-01-14T02:25:46.975568  va-8713868/1/../bin/lava-test-case
    2023-01-14T02:25:46.980672  BusyBox v1.31.1 (2023-01-09 05:51:17 UTC) m=
ulti-call binary.
    2023-01-14T02:25:46.980757  =

    2023-01-14T02:25:46.981001  =

    2023-01-14T02:25:46.994602  Usage: seq [-w] [-s SEP] [FI<8>[   58.09607=
5] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Drk3399-gru-sound-driver-max98357A-p=
resent RESULT=3Dfail>   =


  * baseline.bootrr.rk3399-gru-sound-driver-dp-present: https://kernelci.or=
g/test/case/id/63c212bb1c583e74e21d3a07
        new failure (last pass: v5.10.158-cip22-7-g92462fd9830b)

    2023-01-14T02:25:46.943126  <8>[   58.045794] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-da7219-present RESULT=3Dfail>
    2023-01-14T02:25:46.947387  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST
    2023-01-14T02:25:46.947828  =

    2023-01-14T02:25:46.952572  Print numbers from FIRST to LAST, in steps =
of INC.
    2023-01-14T02:25:46.952915  =

    2023-01-14T02:25:46.954935  FIRST, INC default to 1.
    2023-01-14T02:25:46.955011  =

    2023-01-14T02:25:46.958212  	-w	Pad to last with leading zeros
    2023-01-14T02:25:46.958664  =

    2023-01-14T02:25:46.960853  	-s SEP	String separator =

    ... (2 line(s) more)  =


  * baseline.bootrr.rk3399-gru-sound-driver-da7219-present: https://kernelc=
i.org/test/case/id/63c212bb1c583e74e21d3a08
        new failure (last pass: v5.10.158-cip22-7-g92462fd9830b)

    2023-01-14T02:25:46.920334  =

    2023-01-14T02:25:46.932476  BusyBox v1.31.1 (2023-01-09 05:51:17 UTC) m=
ulti-call binary.
    2023-01-14T02:25:46.932561  =

    2023-01-14T02:25:46.932807     =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
sun50i-a64-pine64-plus    | arm64  | lab-broonie     | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c20fc37110b1ba861d39cf

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230109.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c20fc37110b1ba861d39d4
        new failure (last pass: v5.10.158-cip22-7-g92462fd9830b)

    2023-01-14T02:13:12.918259  + set +x
    2023-01-14T02:13:12.922316  <8>[   17.123968] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 110003_1.5.2.4.1>
    2023-01-14T02:13:13.036396  / # #
    2023-01-14T02:13:13.139502  export SHELL=3D/bin/sh
    2023-01-14T02:13:13.140086  #
    2023-01-14T02:13:13.241812  / # export SHELL=3D/bin/sh. /lava-110003/en=
vironment
    2023-01-14T02:13:13.242322  =

    2023-01-14T02:13:13.343924  / # . /lava-110003/environment/lava-110003/=
bin/lava-test-runner /lava-110003/1
    2023-01-14T02:13:13.344861  =

    2023-01-14T02:13:13.348662  / # /lava-110003/bin/lava-test-runner /lava=
-110003/1 =

    ... (12 line(s) more)  =

 =20

