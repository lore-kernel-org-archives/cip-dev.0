Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68105C7EE23
	for <webhook@archiver.kernel.org>; Tue, 16 May 2023 20:41:45 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web10.33590.1684269703199154747
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 16 May 2023 13:41:43 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=IG7ZqidM;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.180, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1ae408f4d1aso958155ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 16 May 2023 13:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684269702; x=1686861702;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2PmcSuPkjVYTxxaMqoWBiQinMvf6vbMH8ZY1IU3v0U0=;
        b=IG7ZqidMDQmR9PcfqRyjwlxDGgFjGwM4mqD7vz6k+61xuZ/0F9NgVxnqXo+XL35RU0
         nrOM6kL6a+AFuO5ubYJTEqKuLBEDkkkrArmYw6LQMMXQQcUUtEHYsy6k/lfnkIQh22Qg
         ruFtVDwCvy7DKGcX3fa9U+qZ5UyWuPVuXk7JYJaWot3NcF1EIQoh/YEfRd3qE3O8SCZW
         e0tdR5In4ooZ075Yh7PPJgY454HTWumIsMnDHlH+FxQUsLr6+QI4NrqK8cdVD7ZxcBRd
         INvaGLm/a5G23hspD3feg6WibsnjCiqtwc9jzKi8geiGhZmxZZrFJVY8Amwc1hkQgqje
         rrGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684269702; x=1686861702;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2PmcSuPkjVYTxxaMqoWBiQinMvf6vbMH8ZY1IU3v0U0=;
        b=BTM1jMny+FS7XTqz0V5T4ojwZA1rbR2xDRXUFrRRymKzTN0n+2Jvy5RT+Il4yFcDe1
         r76X5URIMHbukMQfuWYnTa73Mw/7gQx0d778CYRdT/eX9OLjxBp5n292O5FG41HQESYC
         JitTVl0njFyjbkIjkfRjbdjtQCWzIN3lXYG+KxbEW6XsC+292RfWFjw/yqXn/Dwa8whT
         Xi/udOIzvSfuYgS2qA+QA6Mu+m5q9OQ0o8yvBIic69TXuRzP9M3ABw/xu77bmLEuIgfz
         umqJK5KywCOFCn2INxkY0qWymxRtc+4kltnZx+8njE2zMVFZKHTWo6K9sY10VqHKqx5j
         FCTQ==
X-Gm-Message-State: AC+VfDwvNwLfg2HINZ0lhI9k52ZUhFtcKWB9YBBwyB3MG7US7rfbVKIg
	axMGfSJ68CRx7z3nAyo4ZQnsfP4bz9pdYULHC63pgw==
X-Google-Smtp-Source: ACHHUZ5ATvLzteYClnx2GXtaEgm/W7fTKeolhwCXdRXU1G0TVH9SxpLjob3si6Stk6OA4VpA3BHo2g==
X-Received: by 2002:a17:902:ee89:b0:1a6:74f6:fa92 with SMTP id a9-20020a170902ee8900b001a674f6fa92mr41401251pld.19.1684269700985;
        Tue, 16 May 2023 13:41:40 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f23-20020a170902ab9700b001a183ade911sm7169076plr.56.2023.05.16.13.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 13:41:40 -0700 (PDT)
Message-ID: <6463ea84.170a0220.b025f.dba7@mx.google.com>
Date: Tue, 16 May 2023 13:41:40 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.179-cip32-4-gd8c029e4780f
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip baseline: 125 runs,
 25 regressions (v5.10.179-cip32-4-gd8c029e4780f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 May 2023 20:41:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11477

cip/linux-5.10.y-cip baseline: 125 runs, 25 regressions (v5.10.179-cip32-4-=
gd8c029e4780f)

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

beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =

fsl-ls1028a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

fsl-ls1088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

fsl-lx2160a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
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

meson-g12b-a311d-khadas-vim3 | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

mt8173-elm-hana              | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =

rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 4          =

rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.179-cip32-4-gd8c029e4780f/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.179-cip32-4-gd8c029e4780f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      d8c029e4780f8e18a07a1a17c1a9de1e01f3adae =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6463e15e5e09c4f1ae2e8659

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6463e15e5e09c4f1ae2e865e
        failing since 122 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-16T20:02:28.728786  <8>[   11.798449] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10341572_1.4.2.3.1>

    2023-05-16T20:02:28.732001  + set +x

    2023-05-16T20:02:28.833204  #

    2023-05-16T20:02:28.934093  / # #export SHELL=3D/bin/sh

    2023-05-16T20:02:28.934327  =


    2023-05-16T20:02:29.034950  / # export SHELL=3D/bin/sh. /lava-10341572/=
environment

    2023-05-16T20:02:29.035197  =


    2023-05-16T20:02:29.135824  / # . /lava-10341572/environment/lava-10341=
572/bin/lava-test-runner /lava-10341572/1

    2023-05-16T20:02:29.136146  =


    2023-05-16T20:02:29.141745  / # /lava-10341572/bin/lava-test-runner /la=
va-10341572/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6463e1830b5fd3714e2e85e6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6463e1830b5fd3714e2e85eb
        failing since 122 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-16T20:02:59.524828  + set +x

    2023-05-16T20:02:59.530932  <8>[   11.520202] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10341577_1.4.2.3.1>

    2023-05-16T20:02:59.635391  / # #

    2023-05-16T20:02:59.735954  export SHELL=3D/bin/sh

    2023-05-16T20:02:59.736140  #

    2023-05-16T20:02:59.836658  / # export SHELL=3D/bin/sh. /lava-10341577/=
environment

    2023-05-16T20:02:59.836842  =


    2023-05-16T20:02:59.937382  / # . /lava-10341577/environment/lava-10341=
577/bin/lava-test-runner /lava-10341577/1

    2023-05-16T20:02:59.937682  =


    2023-05-16T20:02:59.942632  / # /lava-10341577/bin/lava-test-runner /la=
va-10341577/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6463e24c7adcb8579f2e8669

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-b=
eaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-b=
eaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6463e24c7adcb8579f2e867e
        failing since 122 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-16T20:06:02.518474  <8>[   23.142363] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 468951_1.5.2.4.1>
    2023-05-16T20:06:02.626153  / # #
    2023-05-16T20:06:02.728466  export SHELL=3D/bin/sh
    2023-05-16T20:06:02.729117  #
    2023-05-16T20:06:02.830803  / # export SHELL=3D/bin/sh. /lava-468951/en=
vironment
    2023-05-16T20:06:02.831539  =

    2023-05-16T20:06:02.933753  / # . /lava-468951/environment/lava-468951/=
bin/lava-test-runner /lava-468951/1
    2023-05-16T20:06:02.934705  =

    2023-05-16T20:06:02.938663  / # /lava-468951/bin/lava-test-runner /lava=
-468951/1
    2023-05-16T20:06:03.033795  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6463e73e4535ca013b2e861b

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beagl=
ebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beagl=
ebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6463e73e4535ca013b2e861e
        failing since 122 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-16T20:27:12.478020  <8>[   15.554631] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 934465_1.5.2.4.1>
    2023-05-16T20:27:12.589073  / # #
    2023-05-16T20:27:12.691762  export SHELL=3D/bin/sh
    2023-05-16T20:27:12.692500  #
    2023-05-16T20:27:12.794376  / # export SHELL=3D/bin/sh. /lava-934465/en=
vironment
    2023-05-16T20:27:12.794953  =

    2023-05-16T20:27:12.896574  / # . /lava-934465/environment/lava-934465/=
bin/lava-test-runner /lava-934465/1
    2023-05-16T20:27:12.897751  =

    2023-05-16T20:27:12.903922  / # /lava-934465/bin/lava-test-runner /lava=
-934465/1
    2023-05-16T20:27:12.991413  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6463e162455e807b0d2e8603

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-=
beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-=
beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6463e162455e807b0d2e860d
        failing since 122 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-16T20:02:20.160874  <8>[   15.739130] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 468874_1.5.2.4.1>
    2023-05-16T20:02:20.272184  / # #
    2023-05-16T20:02:20.375292  export SHELL=3D/bin/sh
    2023-05-16T20:02:20.376172  #
    2023-05-16T20:02:20.478256  / # export SHELL=3D/bin/sh. /lava-468874/en=
vironment
    2023-05-16T20:02:20.479133  =

    2023-05-16T20:02:20.581241  / # . /lava-468874/environment/lava-468874/=
bin/lava-test-runner /lava-468874/1
    2023-05-16T20:02:20.582561  =

    2023-05-16T20:02:20.587428  / # /lava-468874/bin/lava-test-runner /lava=
-468874/1
    2023-05-16T20:02:20.694017  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6463e1e147b0098c2b2e8681

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6463e1e147b0098c2b2e8684
        failing since 122 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-16T20:04:34.553198  + set +x
    2023-05-16T20:04:34.555245  <8>[   13.958345] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 934439_1.5.2.4.1>
    2023-05-16T20:04:34.663871  / # #
    2023-05-16T20:04:34.765813  export SHELL=3D/bin/sh
    2023-05-16T20:04:34.766267  #
    2023-05-16T20:04:34.867640  / # export SHELL=3D/bin/sh. /lava-934439/en=
vironment
    2023-05-16T20:04:34.868078  =

    2023-05-16T20:04:34.969469  / # . /lava-934439/environment/lava-934439/=
bin/lava-test-runner /lava-934439/1
    2023-05-16T20:04:34.970183  =

    2023-05-16T20:04:34.972414  / # /lava-934439/bin/lava-test-runner /lava=
-934439/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls1028a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6463e2f9534788e7f62e8609

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1028a-=
rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1028a-=
rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6463e2f9534788e7f62e860c
        failing since 64 days (last pass: v5.10.155-cip21, first fail: v5.1=
0.173-cip28)

    2023-05-16T20:08:54.236956  + [   23.154543] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 1222607_1.5.2.4.1>
    2023-05-16T20:08:54.237085  set +x
    2023-05-16T20:08:54.342657  / # #
    2023-05-16T20:08:54.443977  export SHELL=3D/bin/sh
    2023-05-16T20:08:54.444329  #
    2023-05-16T20:08:54.545325  / # export SHELL=3D/bin/sh. /lava-1222607/e=
nvironment
    2023-05-16T20:08:54.545671  =

    2023-05-16T20:08:54.646577  / # . /lava-1222607/environment/lava-122260=
7/bin/lava-test-runner /lava-1222607/1
    2023-05-16T20:08:54.647058  =

    2023-05-16T20:08:54.648903  / # /lava-1222607/bin/lava-test-runner /lav=
a-1222607/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls1088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6463e2dcb615f5c65d2e85ec

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1088a-=
rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1088a-=
rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6463e2dcb615f5c65d2e85ef
        failing since 122 days (last pass: v5.10.155-cip21, first fail: v5.=
10.162-cip24)

    2023-05-16T20:08:49.727291  [   14.458492] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1222610_1.5.2.4.1>
    2023-05-16T20:08:49.833168  / # #
    2023-05-16T20:08:49.934260  export SHELL=3D/bin/sh
    2023-05-16T20:08:49.934479  #
    2023-05-16T20:08:50.035480  / # export SHELL=3D/bin/sh. /lava-1222610/e=
nvironment
    2023-05-16T20:08:50.035803  =

    2023-05-16T20:08:50.136765  / # . /lava-1222610/environment/lava-122261=
0/bin/lava-test-runner /lava-1222610/1
    2023-05-16T20:08:50.137094  =

    2023-05-16T20:08:50.138961  / # /lava-1222610/bin/lava-test-runner /lav=
a-1222610/1
    2023-05-16T20:08:50.157110  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-lx2160a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6463e331bd63f069642e85fe

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-=
rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-=
rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6463e331bd63f069642e8601
        failing since 55 days (last pass: v5.10.154-cip20, first fail: v5.1=
0.175-cip29)

    2023-05-16T20:10:11.943734  [   24.563321] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1222608_1.5.2.4.1>
    2023-05-16T20:10:12.049497  / # #
    2023-05-16T20:10:12.151434  export SHELL=3D/bin/sh
    2023-05-16T20:10:12.152016  #
    2023-05-16T20:10:12.253414  / # export SHELL=3D/bin/sh. /lava-1222608/e=
nvironment
    2023-05-16T20:10:12.253913  =

    2023-05-16T20:10:12.355376  / # . /lava-1222608/environment/lava-122260=
8/bin/lava-test-runner /lava-1222608/1
    2023-05-16T20:10:12.356119  =

    2023-05-16T20:10:12.357870  / # /lava-1222608/bin/lava-test-runner /lav=
a-1222608/1
    2023-05-16T20:10:12.375650  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6463e166455e807b0d2e8656

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6463e166455e807b0d2e865b
        failing since 32 days (last pass: v5.10.176-cip30, first fail: v5.1=
0.177-cip31)

    2023-05-16T20:02:33.182005  + <8>[   15.182351] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10341527_1.4.2.3.1>

    2023-05-16T20:02:33.182097  set +x

    2023-05-16T20:02:33.283305  #

    2023-05-16T20:02:33.384146  / # #export SHELL=3D/bin/sh

    2023-05-16T20:02:33.384404  =


    2023-05-16T20:02:33.485185  / # export SHELL=3D/bin/sh. /lava-10341527/=
environment

    2023-05-16T20:02:33.486192  =


    2023-05-16T20:02:33.587518  / # . /lava-10341527/environment/lava-10341=
527/bin/lava-test-runner /lava-10341527/1

    2023-05-16T20:02:33.587873  =


    2023-05-16T20:02:33.592658  / # /lava-10341527/bin/lava-test-runner /la=
va-10341527/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6463e1454fe139abd52e85e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6463e1454fe139abd52e85eb
        failing since 32 days (last pass: v5.10.176-cip30, first fail: v5.1=
0.177-cip31)

    2023-05-16T20:01:59.442808  + set +x<8>[   11.831331] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10341556_1.4.2.3.1>

    2023-05-16T20:01:59.442891  =


    2023-05-16T20:01:59.544625  #

    2023-05-16T20:01:59.647363  / # #export SHELL=3D/bin/sh

    2023-05-16T20:01:59.647994  =


    2023-05-16T20:01:59.749293  / # export SHELL=3D/bin/sh. /lava-10341556/=
environment

    2023-05-16T20:01:59.750034  =


    2023-05-16T20:01:59.851692  / # . /lava-10341556/environment/lava-10341=
556/bin/lava-test-runner /lava-10341556/1

    2023-05-16T20:01:59.852862  =


    2023-05-16T20:01:59.858285  / # /lava-10341556/bin/lava-test-runner /la=
va-10341556/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6463e22e5a59de70112e871e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline=
-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline=
-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6463e22e5a59de70112e8723
        failing since 122 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-16T20:05:53.757403  / # #

    2023-05-16T20:05:53.858071  export SHELL=3D/bin/sh

    2023-05-16T20:05:53.858216  #

    2023-05-16T20:05:53.958746  / # export SHELL=3D/bin/sh. /lava-10341650/=
environment

    2023-05-16T20:05:53.958890  =


    2023-05-16T20:05:54.059429  / # . /lava-10341650/environment/lava-10341=
650/bin/lava-test-runner /lava-10341650/1

    2023-05-16T20:05:54.059664  =


    2023-05-16T20:05:54.070245  / # /lava-10341650/bin/lava-test-runner /la=
va-10341650/1

    2023-05-16T20:05:54.174064  + export 'TESTRUN_ID=3D1_bootrr'

    2023-05-16T20:05:54.174163  + cd /lava-10341650/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6463e23c7adcb8579f2e8607

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/basel=
ine-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/basel=
ine-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6463e23c7adcb8579f2e860c
        failing since 122 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-16T20:06:11.229522  + set +x
    2023-05-16T20:06:11.229697  [   10.326974] <LAVA_SIGNAL_ENDRUN 0_dmesg =
951839_1.5.2.3.1>
    2023-05-16T20:06:11.338186  / # #
    2023-05-16T20:06:11.439987  export SHELL=3D/bin/sh
    2023-05-16T20:06:11.440472  #
    2023-05-16T20:06:11.541976  / # export SHELL=3D/bin/sh. /lava-951839/en=
vironment
    2023-05-16T20:06:11.542461  =

    2023-05-16T20:06:11.643921  / # . /lava-951839/environment/lava-951839/=
bin/lava-test-runner /lava-951839/1
    2023-05-16T20:06:11.644514  =

    2023-05-16T20:06:11.647693  / # /lava-951839/bin/lava-test-runner /lava=
-951839/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6463e1fef8d4e0b00e2e85f9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseli=
ne-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseli=
ne-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6463e1fef8d4e0b00e2e85fe
        failing since 122 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-16T20:05:10.551603  + set[    7.183796] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 951835_1.5.2.3.1>
    2023-05-16T20:05:10.551781   +x
    2023-05-16T20:05:10.657091  / # #
    2023-05-16T20:05:10.758611  export SHELL=3D/bin/sh
    2023-05-16T20:05:10.759062  #
    2023-05-16T20:05:10.860274  / # export SHELL=3D/bin/sh. /lava-951835/en=
vironment
    2023-05-16T20:05:10.860701  =

    2023-05-16T20:05:10.962003  / # . /lava-951835/environment/lava-951835/=
bin/lava-test-runner /lava-951835/1
    2023-05-16T20:05:10.962766  =

    2023-05-16T20:05:10.965839  / # /lava-951835/bin/lava-test-runner /lava=
-951835/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6463e265fcaa5dad0c2e8610

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7d=
-sdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7d=
-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6463e265fcaa5dad0c2e8613
        failing since 122 days (last pass: v5.10.155-cip21, first fail: v5.=
10.162-cip24)

    2023-05-16T20:06:34.343782  / # #
    2023-05-16T20:06:35.502821  export SHELL=3D/bin/sh
    2023-05-16T20:06:35.508231  #
    2023-05-16T20:06:37.054470  / # export SHELL=3D/bin/sh. /lava-1222603/e=
nvironment
    2023-05-16T20:06:37.059943  =

    2023-05-16T20:06:39.880906  / # . /lava-1222603/environment/lava-122260=
3/bin/lava-test-runner /lava-1222603/1
    2023-05-16T20:06:39.886962  =

    2023-05-16T20:06:39.898927  / # /lava-1222603/bin/lava-test-runner /lav=
a-1222603/1
    2023-05-16T20:06:39.983684  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-16T20:06:39.984264  + cd /lava-1222603/1/tests/1_bootrr =

    ... (18 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7ulp-evk                  | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6463e284c55f6fa8222e85ef

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7u=
lp-evk.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7u=
lp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6463e284c55f6fa8222e85f2
        failing since 64 days (last pass: v5.10.155-cip21, first fail: v5.1=
0.173-cip28)

    2023-05-16T20:06:52.141577  + set +x<8>[   28.979047] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 1222602_1.5.2.4.1>
    2023-05-16T20:06:52.141708  =

    2023-05-16T20:06:52.249139  / # #
    2023-05-16T20:06:53.407234  export SHELL=3D/bin/sh
    2023-05-16T20:06:53.412693  #
    2023-05-16T20:06:53.412860  / # export SHELL=3D/bin/sh
    2023-05-16T20:06:54.958851  / # . /lava-1222602/environment
    2023-05-16T20:06:57.784750  /lava-1222602/bin/lava-test-runner /lava-12=
22602/1
    2023-05-16T20:06:57.790559  . /lava-1222602/environment
    2023-05-16T20:06:57.790736  / # /lava-1222602/bin/lava-test-runner /lav=
a-1222602/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6463e26cfcaa5dad0c2e862a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/arm64/defconfig/gcc-10/lab-collabora/baseline-meson-=
g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/arm64/defconfig/gcc-10/lab-collabora/baseline-meson-=
g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6463e26cfcaa5dad0c2e862f
        new failure (last pass: v5.10.177-cip31)

    2023-05-16T20:06:46.451935  / # #

    2023-05-16T20:06:46.554711  export SHELL=3D/bin/sh

    2023-05-16T20:06:46.555500  #

    2023-05-16T20:06:46.657343  / # export SHELL=3D/bin/sh. /lava-10341652/=
environment

    2023-05-16T20:06:46.658149  =


    2023-05-16T20:06:46.760088  / # . /lava-10341652/environment/lava-10341=
652/bin/lava-test-runner /lava-10341652/1

    2023-05-16T20:06:46.761370  =


    2023-05-16T20:06:46.774151  / # /lava-10341652/bin/lava-test-runner /la=
va-10341652/1

    2023-05-16T20:06:46.817836  + export 'TESTRUN_ID=3D1_bootrr'

    2023-05-16T20:06:46.818414  + cd /lava-10341652/1/tests/1_bootrr
 =

    ... (16 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6463e4046f09170d8c2e85f1

  Results:     28 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabor=
a/baseline-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabor=
a/baseline-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6463e4046f09170d8c2e860d
        failing since 122 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-16T20:13:46.695853  <8>[   15.633808] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-05-16T20:13:46.696246  + set +x

    2023-05-16T20:13:46.703686  <8>[   15.643330] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10341694_1.5.2.3.1>

    2023-05-16T20:13:46.808726  #

    2023-05-16T20:13:46.810047  =


    2023-05-16T20:13:46.911882  / # #export SHELL=3D/bin/sh

    2023-05-16T20:13:46.912685  =


    2023-05-16T20:13:47.014252  / # export SHELL=3D/bin/sh. /lava-10341694/=
environment

    2023-05-16T20:13:47.015042  =


    2023-05-16T20:13:47.116709  / # . /lava-10341694/environment/lava-10341=
694/bin/lava-test-runner /lava-10341694/1
 =

    ... (18 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6463e21ec0b1032d6f2e8603

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a77=
43-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a77=
43-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6463e21ec0b1032d6f2e8=
604
        failing since 32 days (last pass: v5.10.176-cip30, first fail: v5.1=
0.177-cip31) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 4          =


  Details:     https://kernelci.org/test/plan/id/6463e2135a59de70112e8643

  Results:     63 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline=
-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline=
-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-i2c-present: https://kernelci.or=
g/test/case/id/6463e2135a59de70112e8672
        failing since 120 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-16T20:05:26.898804   INC default to 1.

    2023-05-16T20:05:26.899045  =


    2023-05-16T20:05:26.902525  	-w	Pad to last with leading zeros

    2023-05-16T20:05:26.905070  	-s SEP	String separator

    2023-05-16T20:05:26.908759  /lava-10341644/1/../bin/lava-test-case

    2023-05-16T20:05:26.915473  BusyBox v1.31.1 (2023-05-12 17:02:46 UTC) m=
ulti-call binary.

    2023-05-16T20:05:26.915533  =


    2023-05-16T20:05:26.925353  Usag<8>[   18.629252] <LAVA_SIGNAL_TESTCASE=
 TEST_CASE_ID=3Ddwhdmi-rockchip-driver-i2c-present RESULT=3Dfail>
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/6463e2135a59de70112e8673
        failing since 120 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-16T20:05:26.872883  BusyBox v1.31.1 (2023-05-12 17:02:46 UTC)<8=
>[   18.581128] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-05-16T20:05:26.874696   multi-call binary.

    2023-05-16T20:05:26.874911  =


    2023-05-16T20:05:26.879366  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-05-16T20:05:26.879582  =


    2023-05-16T20:05:26.884707  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-05-16T20:05:26.894919  FIRST,<8>[   18.600205] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/6463e2135a59de70112e8674
        failing since 120 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-16T20:05:26.853694  <8>[   18.563347] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6463e2135a59de70112e8688
        failing since 120 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-16T20:05:14.794863  <8>[    6.504313] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-05-16T20:05:14.805037  + <8>[    6.516824] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10341644_1.5.2.3.1>

    2023-05-16T20:05:14.805090  set +x

    2023-05-16T20:05:14.911283  =


    2023-05-16T20:05:15.012758  / # #export SHELL=3D/bin/sh

    2023-05-16T20:05:15.013456  =


    2023-05-16T20:05:15.114868  / # export SHELL=3D/bin/sh. /lava-10341644/=
environment

    2023-05-16T20:05:15.115573  =


    2023-05-16T20:05:15.216931  / # . /lava-10341644/environment/lava-10341=
644/bin/lava-test-runner /lava-10341644/1

    2023-05-16T20:05:15.217788  =

 =

    ... (19 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6463e485d845411e292e85e6

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabor=
a/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabor=
a/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/6463e485d845411e292e85ec
        failing since 55 days (last pass: v5.10.173-cip28, first fail: v5.1=
0.175-cip29)

    2023-05-16T20:15:45.353622  /lava-10341678/1/../bin/lava-test-case

    2023-05-16T20:15:45.364504  <8>[   35.613805] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/6463e485d845411e292e85ed
        failing since 55 days (last pass: v5.10.173-cip28, first fail: v5.1=
0.175-cip29)

    2023-05-16T20:15:43.289860  <8>[   33.538471] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-05-16T20:15:44.315675  /lava-10341678/1/../bin/lava-test-case

    2023-05-16T20:15:44.327365  <8>[   34.576377] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =20

