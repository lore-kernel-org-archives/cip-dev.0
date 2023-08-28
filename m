Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CE1C83F14
	for <webhook@archiver.kernel.org>; Mon, 28 Aug 2023 01:40:36 +0000 (UTC)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
 by mx.groups.io with SMTP id smtpd.web10.5037.1693186833847849399
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 27 Aug 2023 18:40:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=b4ExHLs9;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.176, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-56a55c0f8b1so1160779a12.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 27 Aug 2023 18:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1693186833; x=1693791633;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=J1vZ6e76sWhLm3fx7X0EbPSOROSTBiTjjceYzXGSTNs=;
        b=b4ExHLs9PcWl0iH1ZVq4TFWf1UkioP+cvwze+Bz1E8Gdv60Q1ad/N1SY4ID2yXVeI+
         LafEqT+OoviJLYDQ49Hl4Bg5l73iJvte7A1Teb5grdic1zoDEOR1UuHmUXy/1nEWKy8t
         EJ43ySD/oTB9z06y5wWDEu/h83JX0bIIcFL8DYrIWmZc+8lfS9YS5ZUBGQatY9Ow1SxY
         FjH18E6Y90wgGvUbhab+GJ+37hrA5q1D1OXaVs6l2vIepuD+NrEEzk2NFNBN4f9dIBml
         D4kFjwG6BWELuTNGJg2J3aSPByiJCLNYwAUxeEhLaAH8JFtZRe/ENUNf5QaJwA8+uaVZ
         9eXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693186833; x=1693791633;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J1vZ6e76sWhLm3fx7X0EbPSOROSTBiTjjceYzXGSTNs=;
        b=kre51QFKhil3VUVb6YmdIkK8ThO6wthEl459u9y536BOXQEG6rIK44HWGnJOxIPABl
         bJmj6BJCqIFO3QLdOE4VM+W226gSo6Z1FS64wZnPLq6iQ6BDlxQAEw5Q1Bz/Pest5zXH
         ShNpaKKBFiF8hU6hs5QwtSzASr0YiW9HLejPBCWjsjUU9taQdQodkPiDNezrFH/Je3iH
         2z96nrf1WxkqpUZkvte4Z+X7X82RYVDHQJLPrUqU0b4+571FiUI2kCJz2K1i6ODIxAv1
         KzkE1hON3XEAY1D+m8Y6L/YLNZo7VM2KTjgwgJc5jZMg1TiLabFc0rU/OjbRP3spxJtS
         R9+Q==
X-Gm-Message-State: AOJu0YyFweDEPhPtoUb3uwWyH8LMDPHkCNqxEuD4ptBTXoJFhEToxs+D
	WUvvTBsA79PEy78FAQRX0ckETsb3htxaeZ97+6A=
X-Google-Smtp-Source: AGHT+IGQV5G4ndGu3k9EiL0M2tpGXDzOo2P5D8q5aqzNGXmXff7XOT3Eux3Affq3Ecs+OqEjDBBWoA==
X-Received: by 2002:a17:903:120b:b0:1b8:6850:c3c4 with SMTP id l11-20020a170903120b00b001b86850c3c4mr23094808plh.22.1693186831790;
        Sun, 27 Aug 2023 18:40:31 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id g1-20020a170902c38100b001b8a897cd26sm5872550plg.195.2023.08.27.18.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 18:40:31 -0700 (PDT)
Message-ID: <64ebfb0f.170a0220.2ed3a.9274@mx.google.com>
Date: Sun, 27 Aug 2023 18:40:31 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.191-cip38
Subject: cip/linux-5.10.y-cip baseline: 147 runs,
 37 regressions (v5.10.191-cip38)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Aug 2023 01:40:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12864

cip/linux-5.10.y-cip baseline: 147 runs, 37 regressions (v5.10.191-cip38)

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

at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig           | 1          =

bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | bcm283=
5_defconfig            | 1          =

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

fsl-ls2088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
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

imx6ul-14x14-evk             | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =

imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =

imx7ulp-evk                  | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =

juno-uboot                   | arm64  | lab-broonie     | gcc-10   | cip://=
5.10.y-...64_defconfig | 1          =

juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig+kselftest          | 1          =

mt8173-elm-hana              | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip         | gcc-10   | defcon=
fig+kselftest          | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =

r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig+kselftest          | 1          =

r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

r8a77960-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

r8a77960-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig+kselftest          | 1          =

rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 4          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.191-cip38/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.191-cip38
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      78bddf33c2b7d94fc34e09bc56638615095ddc28 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebef79ab156a9673286d72

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ebef79ab156a9673286d7b
        failing since 225 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-28T00:50:42.445159  + set +x

    2023-08-28T00:50:42.451823  <8>[   11.853185] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11368162_1.4.2.3.1>

    2023-08-28T00:50:42.556289  / # #

    2023-08-28T00:50:42.656853  export SHELL=3D/bin/sh

    2023-08-28T00:50:42.657025  #

    2023-08-28T00:50:42.757541  / # export SHELL=3D/bin/sh. /lava-11368162/=
environment

    2023-08-28T00:50:42.757739  =


    2023-08-28T00:50:42.858337  / # . /lava-11368162/environment/lava-11368=
162/bin/lava-test-runner /lava-11368162/1

    2023-08-28T00:50:42.858607  =


    2023-08-28T00:50:42.858674  / # /lava-11368162/bin/lava-test-runner /la=
va-11368162/1<4>[   12.239253] i2c_designware i2c_designware.2: timeout in =
disabling adapter
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebef681a099882c3286d80

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ebef681a099882c3286d89
        failing since 225 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-28T00:50:37.454334  + set<8>[   12.177484] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11368189_1.4.2.3.1>

    2023-08-28T00:50:37.455294   +x

    2023-08-28T00:50:37.559007  #

    2023-08-28T00:50:37.659755  / # #export SHELL=3D/bin/sh

    2023-08-28T00:50:37.659924  =


    2023-08-28T00:50:37.760385  / # export SHELL=3D/bin/sh. /lava-11368189/=
environment

    2023-08-28T00:50:37.760603  =


    2023-08-28T00:50:37.760721  / # <4>[   12.424423] i2c_designware i2c_de=
signware.5: timeout in disabling adapter

    2023-08-28T00:50:37.861246  . /lava-11368189/environment/lava-11368189/=
bin/lava-test-runner /lava-11368189/1

    2023-08-28T00:50:37.861505  =

 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebef3605ff179b05286db9

  Results:     47 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ebef3605ff179b05286df2
        failing since 225 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-28T00:49:21.683831  + set +x
    2023-08-28T00:49:21.688957  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 73617_1.5.2.=
4.1>
    2023-08-28T00:49:21.802789  / # #
    2023-08-28T00:49:21.905649  export SHELL=3D/bin/sh
    2023-08-28T00:49:21.906469  #
    2023-08-28T00:49:22.008421  / # export SHELL=3D/bin/sh. /lava-73617/env=
ironment
    2023-08-28T00:49:22.009233  =

    2023-08-28T00:49:22.111214  / # . /lava-73617/environment/lava-73617/bi=
n/lava-test-runner /lava-73617/1
    2023-08-28T00:49:22.112487  =

    2023-08-28T00:49:22.117998  / # /lava-73617/bin/lava-test-runner /lava-=
73617/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | bcm283=
5_defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebeeed64e18ed629286db5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm/bcm2835_defconfig/gcc-10/lab-collabora/baseline-bcm2836-rpi-2-b.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm/bcm2835_defconfig/gcc-10/lab-collabora/baseline-bcm2836-rpi-2-b.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ebeeed64e18ed629286dbe
        failing since 33 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-08-28T00:50:02.476105  / # #

    2023-08-28T00:50:02.578467  export SHELL=3D/bin/sh

    2023-08-28T00:50:02.579230  #

    2023-08-28T00:50:02.680676  / # export SHELL=3D/bin/sh. /lava-11368131/=
environment

    2023-08-28T00:50:02.681482  =


    2023-08-28T00:50:02.782982  / # . /lava-11368131/environment/lava-11368=
131/bin/lava-test-runner /lava-11368131/1

    2023-08-28T00:50:02.784188  =


    2023-08-28T00:50:02.800572  / # /lava-11368131/bin/lava-test-runner /la=
va-11368131/1

    2023-08-28T00:50:02.907458  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-28T00:50:02.907962  + cd /lava-11368131/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebf0d9ef8f82a7fe286d8f

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ebf0d9ef8f82a7fe286dbf
        failing since 225 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-28T00:56:25.757615  <8>[   21.955449] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 73698_1.5.2.4.1>
    2023-08-28T00:56:25.864859  / # #
    2023-08-28T00:56:25.967030  export SHELL=3D/bin/sh
    2023-08-28T00:56:25.967636  #
    2023-08-28T00:56:26.069159  / # export SHELL=3D/bin/sh. /lava-73698/env=
ironment
    2023-08-28T00:56:26.069752  =

    2023-08-28T00:56:26.171341  / # . /lava-73698/environment/lava-73698/bi=
n/lava-test-runner /lava-73698/1
    2023-08-28T00:56:26.172289  =

    2023-08-28T00:56:26.176713  / # /lava-73698/bin/lava-test-runner /lava-=
73698/1
    2023-08-28T00:56:26.265264  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebf0bc7de8e795a1286d88

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ebf0bc7de8e795a1286d8f
        failing since 225 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-28T00:55:41.703330  + set +x
    2023-08-28T00:55:41.705509  <8>[   16.767360] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1001786_1.5.2.4.1>
    2023-08-28T00:55:41.813746  / # #
    2023-08-28T00:55:41.915632  export SHELL=3D/bin/sh
    2023-08-28T00:55:41.916078  #
    2023-08-28T00:55:42.017456  / # export SHELL=3D/bin/sh. /lava-1001786/e=
nvironment
    2023-08-28T00:55:42.017903  =

    2023-08-28T00:55:42.119303  / # . /lava-1001786/environment/lava-100178=
6/bin/lava-test-runner /lava-1001786/1
    2023-08-28T00:55:42.120029  =

    2023-08-28T00:55:42.122146  / # /lava-1001786/bin/lava-test-runner /lav=
a-1001786/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebf1b3a610acea1f286dc3

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ebf1b4a610acea1f286dfb
        failing since 225 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-28T01:00:21.981421  + set +x
    2023-08-28T01:00:21.984431  <8>[   19.775166] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 73736_1.5.2.4.1>
    2023-08-28T01:00:22.095064  / # #
    2023-08-28T01:00:22.198214  export SHELL=3D/bin/sh
    2023-08-28T01:00:22.199123  #
    2023-08-28T01:00:22.300968  / # export SHELL=3D/bin/sh. /lava-73736/env=
ironment
    2023-08-28T01:00:22.301871  =

    2023-08-28T01:00:22.404009  / # . /lava-73736/environment/lava-73736/bi=
n/lava-test-runner /lava-73736/1
    2023-08-28T01:00:22.405466  =

    2023-08-28T01:00:22.409118  / # /lava-73736/bin/lava-test-runner /lava-=
73736/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebf27409b938d078286d6f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ebf27409b938d078286=
d70
        new failure (last pass: v5.10.186-cip37-27-gd6d928db0a620) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls1028a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebf016f19277a653286d8d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1028a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1028a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ebf016f19277a653286d94
        failing since 167 days (last pass: v5.10.155-cip21, first fail: v5.=
10.173-cip28)

    2023-08-28T00:53:26.591779  [   20.693394] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1246972_1.5.2.4.1>
    2023-08-28T00:53:26.697107  =

    2023-08-28T00:53:26.798283  / # #export SHELL=3D/bin/sh
    2023-08-28T00:53:26.798684  =

    2023-08-28T00:53:26.899654  / # export SHELL=3D/bin/sh. /lava-1246972/e=
nvironment
    2023-08-28T00:53:26.900062  =

    2023-08-28T00:53:27.001033  / # . /lava-1246972/environment/lava-124697=
2/bin/lava-test-runner /lava-1246972/1
    2023-08-28T00:53:27.001704  =

    2023-08-28T00:53:27.005857  / # /lava-1246972/bin/lava-test-runner /lav=
a-1246972/1
    2023-08-28T00:53:27.024597  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls1088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebf019ab75572d31286dae

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1088a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ebf019ab75572d31286db5
        failing since 225 days (last pass: v5.10.155-cip21, first fail: v5.=
10.162-cip24)

    2023-08-28T00:53:29.375911  + [   10.182431] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 1246974_1.5.2.4.1>
    2023-08-28T00:53:29.376239  set +x
    2023-08-28T00:53:29.481624  =

    2023-08-28T00:53:29.582907  / # #export SHELL=3D/bin/sh
    2023-08-28T00:53:29.583342  =

    2023-08-28T00:53:29.684355  / # export SHELL=3D/bin/sh. /lava-1246974/e=
nvironment
    2023-08-28T00:53:29.684911  =

    2023-08-28T00:53:29.785960  / # . /lava-1246974/environment/lava-124697=
4/bin/lava-test-runner /lava-1246974/1
    2023-08-28T00:53:29.957080  =

    2023-08-28T00:53:29.957505  46/ # /lava-1246974/bin/lava-test-runner /l=
ava-1246974/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls2088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebefff62b65b1f54286da9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ebefff62b65b1f54286db0
        failing since 46 days (last pass: v5.10.155-cip21, first fail: v5.1=
0.165-cip25)

    2023-08-28T00:53:01.919914  [   13.408614] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1246973_1.5.2.4.1>
    2023-08-28T00:53:02.025166  =

    2023-08-28T00:53:02.126403  / # #export SHELL=3D/bin/sh
    2023-08-28T00:53:02.126821  =

    2023-08-28T00:53:02.227786  / # export SHELL=3D/bin/sh. /lava-1246973/e=
nvironment
    2023-08-28T00:53:02.228209  =

    2023-08-28T00:53:02.329195  / # . /lava-1246973/environment/lava-124697=
3/bin/lava-test-runner /lava-1246973/1
    2023-08-28T00:53:02.329917  =

    2023-08-28T00:53:02.333995  / # /lava-1246973/bin/lava-test-runner /lav=
a-1246973/1
    2023-08-28T00:53:02.349841  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-lx2160a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebf013bc0ce39e73286dbb

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ebf013bc0ce39e73286dc2
        failing since 158 days (last pass: v5.10.154-cip20, first fail: v5.=
10.175-cip29)

    2023-08-28T00:53:24.874500  [   14.374861] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1246971_1.5.2.4.1>
    2023-08-28T00:53:24.979851  =

    2023-08-28T00:53:25.081019  / # #export SHELL=3D/bin/sh
    2023-08-28T00:53:25.081416  =

    2023-08-28T00:53:25.182353  / # export SHELL=3D/bin/sh. /lava-1246971/e=
nvironment
    2023-08-28T00:53:25.182815  =

    2023-08-28T00:53:25.283811  / # . /lava-1246971/environment/lava-124697=
1/bin/lava-test-runner /lava-1246971/1
    2023-08-28T00:53:25.284477  =

    2023-08-28T00:53:25.288404  / # /lava-1246971/bin/lava-test-runner /lav=
a-1246971/1
    2023-08-28T00:53:25.304447  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebef6e01880929e0286d8e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ebef6e01880929e0286d97
        failing since 135 days (last pass: v5.10.176-cip30, first fail: v5.=
10.177-cip31)

    2023-08-28T00:50:43.239956  + <8>[   10.648583] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11368195_1.4.2.3.1>

    2023-08-28T00:50:43.240039  set +x

    2023-08-28T00:50:43.341129  #

    2023-08-28T00:50:43.341377  =


    2023-08-28T00:50:43.441974  / # #export SHELL=3D/bin/sh

    2023-08-28T00:50:43.442135  =


    2023-08-28T00:50:43.542643  / # export SHELL=3D/bin/sh. /lava-11368195/=
environment

    2023-08-28T00:50:43.542808  =


    2023-08-28T00:50:43.643326  / # . /lava-11368195/environment/lava-11368=
195/bin/lava-test-runner /lava-11368195/1

    2023-08-28T00:50:43.643608  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebef661a099882c3286d73

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ebef661a099882c3286d7c
        failing since 135 days (last pass: v5.10.176-cip30, first fail: v5.=
10.177-cip31)

    2023-08-28T00:51:40.006990  + set +x

    2023-08-28T00:51:40.013990  <8>[   12.966958] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11368181_1.4.2.3.1>

    2023-08-28T00:51:40.115626  #

    2023-08-28T00:51:40.115892  =


    2023-08-28T00:51:40.216455  / # #export SHELL=3D/bin/sh

    2023-08-28T00:51:40.216616  =


    2023-08-28T00:51:40.317096  / # export SHELL=3D/bin/sh. /lava-11368181/=
environment

    2023-08-28T00:51:40.317270  =


    2023-08-28T00:51:40.417763  / # . /lava-11368181/environment/lava-11368=
181/bin/lava-test-runner /lava-11368181/1

    2023-08-28T00:51:40.418005  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebf0c67de8e795a1286dd4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ebf0c67de8e795a1286ddd
        failing since 225 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-28T00:56:28.364814  / # #

    2023-08-28T00:56:28.466210  export SHELL=3D/bin/sh

    2023-08-28T00:56:28.466304  #

    2023-08-28T00:56:28.566756  / # export SHELL=3D/bin/sh. /lava-11368315/=
environment

    2023-08-28T00:56:28.567226  =


    2023-08-28T00:56:28.668208  / # . /lava-11368315/environment/lava-11368=
315/bin/lava-test-runner /lava-11368315/1

    2023-08-28T00:56:28.668480  =


    2023-08-28T00:56:28.673565  / # /lava-11368315/bin/lava-test-runner /la=
va-11368315/1

    2023-08-28T00:56:28.772382  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-28T00:56:28.772445  + cd /lava-11368315/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebef0f2c5ec6477e286d74

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandb=
oard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandb=
oard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ebef0f2c5ec6477e286d7d
        failing since 225 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-28T00:49:11.755391  + set +x
    2023-08-28T00:49:11.755645  [   10.276073] <LAVA_SIGNAL_ENDRUN 0_dmesg =
998652_1.5.2.3.1>
    2023-08-28T00:49:11.863101  / # #
    2023-08-28T00:49:11.965041  export SHELL=3D/bin/sh
    2023-08-28T00:49:11.965572  #
    2023-08-28T00:49:12.066860  / # export SHELL=3D/bin/sh. /lava-998652/en=
vironment
    2023-08-28T00:49:12.067408  =

    2023-08-28T00:49:12.168786  / # . /lava-998652/environment/lava-998652/=
bin/lava-test-runner /lava-998652/1
    2023-08-28T00:49:12.170099  =

    2023-08-28T00:49:12.172200  / # /lava-998652/bin/lava-test-runner /lava=
-998652/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebf077f1c4f70fa0286d9c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandbo=
ard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandbo=
ard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ebf077f1c4f70fa0286da5
        failing since 225 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-28T00:55:11.058368  + set[    7.271721] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 998656_1.5.2.3.1>
    2023-08-28T00:55:11.058532   +x
    2023-08-28T00:55:11.164510  / # #
    2023-08-28T00:55:11.266142  export SHELL=3D/bin/sh
    2023-08-28T00:55:11.266644  #
    2023-08-28T00:55:11.367934  / # export SHELL=3D/bin/sh. /lava-998656/en=
vironment
    2023-08-28T00:55:11.368430  =

    2023-08-28T00:55:11.469911  / # . /lava-998656/environment/lava-998656/=
bin/lava-test-runner /lava-998656/1
    2023-08-28T00:55:11.470553  =

    2023-08-28T00:55:11.472983  / # /lava-998656/bin/lava-test-runner /lava=
-998656/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6ul-14x14-evk             | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebf117d73ea2db30286d79

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx6ul-14x14-evk.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx6ul-14x14-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ebf117d73ea2db30286d80
        failing since 158 days (last pass: v5.10.145-cip17, first fail: v5.=
10.175-cip29)

    2023-08-28T00:57:29.911307  + set +x
    2023-08-28T00:57:29.913787  <8>[   29.070440] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1246982_1.5.2.4.1>
    2023-08-28T00:57:30.023434  / # #
    2023-08-28T00:57:31.179221  export SHELL=3D/bin/sh
    2023-08-28T00:57:31.184857  #
    2023-08-28T00:57:32.725744  / # export SHELL=3D/bin/sh. /lava-1246982/e=
nvironment
    2023-08-28T00:57:32.731274  =

    2023-08-28T00:57:35.542252  / # . /lava-1246982/environment/lava-124698=
2/bin/lava-test-runner /lava-1246982/1
    2023-08-28T00:57:35.548232  =

    2023-08-28T00:57:35.549894  / # /lava-1246982/bin/lava-test-runner /lav=
a-1246982/1 =

    ... (18 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebf155d7f2b10872286d95

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ebf155d7f2b10872286d9c
        failing since 225 days (last pass: v5.10.155-cip21, first fail: v5.=
10.162-cip24)

    2023-08-28T00:58:26.787125  / # #
    2023-08-28T00:58:27.942837  export SHELL=3D/bin/sh
    2023-08-28T00:58:27.948491  #
    2023-08-28T00:58:29.490206  / # export SHELL=3D/bin/sh. /lava-1246979/e=
nvironment
    2023-08-28T00:58:29.495706  =

    2023-08-28T00:58:32.306902  / # . /lava-1246979/environment/lava-124697=
9/bin/lava-test-runner /lava-1246979/1
    2023-08-28T00:58:32.312849  =

    2023-08-28T00:58:32.325726  / # /lava-1246979/bin/lava-test-runner /lav=
a-1246979/1
    2023-08-28T00:58:32.412522  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-28T00:58:32.412881  + cd /lava-1246979/1/tests/1_bootrr =

    ... (19 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7ulp-evk                  | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebf12fc618663599286d6f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7ulp-evk.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7ulp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ebf12fc618663599286d76
        failing since 167 days (last pass: v5.10.155-cip21, first fail: v5.=
10.173-cip28)

    2023-08-28T00:57:52.555729  + set +x<8>[   28.998652] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 1246981_1.5.2.4.1>
    2023-08-28T00:57:52.556083  =

    2023-08-28T00:57:52.665269  / # #
    2023-08-28T00:57:53.820572  export SHELL=3D/bin/sh
    2023-08-28T00:57:53.826224  #
    2023-08-28T00:57:53.826550  / # export SHELL=3D/bin/sh
    2023-08-28T00:57:55.367932  / # . /lava-1246981/environment
    2023-08-28T00:57:58.183545  /lava-1246981/bin/lava-test-runner /lava-12=
46981/1
    2023-08-28T00:57:58.189059  . /lava-1246981/environment
    2023-08-28T00:57:58.189177  / # /lava-1246981/bin/lava-test-runner /lav=
a-1246981/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
juno-uboot                   | arm64  | lab-broonie     | gcc-10   | cip://=
5.10.y-...64_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebf2a6a8204c87ab286d70

  Results:     47 PASS, 13 FAIL, 1 SKIP
  Full config: cip://5.10.y-cip/arm64/qemu_arm64_defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm64/cip---5.10.y-cip-arm64-qemu_arm64_defconfig/gcc-10/lab-broonie=
/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm64/cip---5.10.y-cip-arm64-qemu_arm64_defconfig/gcc-10/lab-broonie=
/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ebf2a6a8204c87ab286daf
        new failure (last pass: v5.10.186-cip37-27-gd6d928db0a620)

    2023-08-28T01:04:14.955000  <8>[   27.073459] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 73706_1.5.2.4.1>
    2023-08-28T01:04:15.064299  / # #
    2023-08-28T01:04:15.167545  export SHELL=3D/bin/sh
    2023-08-28T01:04:15.168475  #
    2023-08-28T01:04:15.270466  / # export SHELL=3D/bin/sh. /lava-73706/env=
ironment
    2023-08-28T01:04:15.271399  =

    2023-08-28T01:04:15.373490  / # . /lava-73706/environment/lava-73706/bi=
n/lava-test-runner /lava-73706/1
    2023-08-28T01:04:15.374954  =

    2023-08-28T01:04:15.387003  / # /lava-73706/bin/lava-test-runner /lava-=
73706/1
    2023-08-28T01:04:15.444906  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebf076cfe3eaabfd286d7e

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ebf076cfe3eaabfd286dba
        failing since 33 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-08-28T00:54:50.979346  / # #
    2023-08-28T00:54:51.082242  export SHELL=3D/bin/sh
    2023-08-28T00:54:51.083023  #
    2023-08-28T00:54:51.185038  / # export SHELL=3D/bin/sh. /lava-73647/env=
ironment
    2023-08-28T00:54:51.185809  =

    2023-08-28T00:54:51.287769  / # . /lava-73647/environment/lava-73647/bi=
n/lava-test-runner /lava-73647/1
    2023-08-28T00:54:51.289090  =

    2023-08-28T00:54:51.303488  / # /lava-73647/bin/lava-test-runner /lava-=
73647/1
    2023-08-28T00:54:51.362261  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-28T00:54:51.362770  + cd /lava-73647/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebf1a2a610acea1f286d71

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm64/defconfig+kselftest/gcc-10/lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm64/defconfig+kselftest/gcc-10/lab-broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ebf1a2a610acea1f286db0
        failing since 33 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-08-28T00:59:50.978780  / # #
    2023-08-28T00:59:51.081596  export SHELL=3D/bin/sh
    2023-08-28T00:59:51.082365  #
    2023-08-28T00:59:51.184267  / # export SHELL=3D/bin/sh. /lava-73673/env=
ironment
    2023-08-28T00:59:51.185027  =

    2023-08-28T00:59:51.286943  / # . /lava-73673/environment/lava-73673/bi=
n/lava-test-runner /lava-73673/1
    2023-08-28T00:59:51.288237  =

    2023-08-28T00:59:51.303131  / # /lava-73673/bin/lava-test-runner /lava-=
73673/1
    2023-08-28T00:59:51.483904  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-28T00:59:51.484426  + cd /lava-73673/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebf45325dc0bf5a2286d8c

  Results:     28 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt817=
3-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt817=
3-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ebf45425dc0bf5a2286dac
        failing since 225 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-28T01:11:42.032185  + set +x

    2023-08-28T01:11:42.039776  <8>[   15.590088] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11368419_1.5.2.3.1>

    2023-08-28T01:11:42.144834  / #

    2023-08-28T01:11:42.247661  # #export SHELL=3D/bin/sh

    2023-08-28T01:11:42.248472  =


    2023-08-28T01:11:42.350346  / # export SHELL=3D/bin/sh. /lava-11368419/=
environment

    2023-08-28T01:11:42.351155  =


    2023-08-28T01:11:42.452912  / # . /lava-11368419/environment/lava-11368=
419/bin/lava-test-runner /lava-11368419/1

    2023-08-28T01:11:42.454133  =


    2023-08-28T01:11:42.456379  / # /lava-11368419/bin/lava-test-runner /la=
va-11368419/1
 =

    ... (20 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip         | gcc-10   | defcon=
fig+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebf0e4a1593a85aa286d75

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-r8a774a1-hihope-rz=
g2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-r8a774a1-hihope-rz=
g2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ebf0e4a1593a85aa286d7c
        failing since 18 days (last pass: v5.10.182-cip35, first fail: v5.1=
0.186-cip37-13-g260094841fe1a)

    2023-08-28T00:56:49.564489  + set +x
    2023-08-28T00:56:49.565072  <8>[   87.673236] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1001781_1.5.2.4.1>
    2023-08-28T00:56:49.678385  #
    2023-08-28T00:56:51.150386  / # #export SHELL=3D/bin/sh
    2023-08-28T00:56:51.171747  =

    2023-08-28T00:56:51.172319  / # export SHELL=3D/bin/sh
    2023-08-28T00:56:53.138786  / # . /lava-1001781/environment
    2023-08-28T00:56:56.755572  /lava-1001781/bin/lava-test-runner /lava-10=
01781/1
    2023-08-28T00:56:56.777503  . /lava-1001781/environment
    2023-08-28T00:56:56.777941  / # /lava-1001781/bin/lava-test-runner /lav=
a-1001781/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebf4ff8e081a42a9286d6c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774a1-hi=
hope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774a1-hi=
hope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ebf4ff8e081a42a9286d73
        failing since 33 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-08-28T01:14:18.290180  + set +x
    2023-08-28T01:14:18.290398  <8>[   83.951502] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1001798_1.5.2.4.1>
    2023-08-28T01:14:18.396626  / # #
    2023-08-28T01:14:19.858389  export SHELL=3D/bin/sh
    2023-08-28T01:14:19.878928  #
    2023-08-28T01:14:19.879130  / # export SHELL=3D/bin/sh
    2023-08-28T01:14:21.834129  / # . /lava-1001798/environment
    2023-08-28T01:14:25.432295  /lava-1001798/bin/lava-test-runner /lava-10=
01798/1
    2023-08-28T01:14:25.453089  . /lava-1001798/environment
    2023-08-28T01:14:25.453200  / # /lava-1001798/bin/lava-test-runner /lav=
a-1001798/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebf04ffd0a4d33df286d6c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ebf04ffd0a4d33df286d73
        failing since 33 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-08-28T00:54:10.742216  / # #
    2023-08-28T00:54:12.210000  export SHELL=3D/bin/sh
    2023-08-28T00:54:12.230572  #
    2023-08-28T00:54:12.230779  / # export SHELL=3D/bin/sh
    2023-08-28T00:54:14.187234  / # . /lava-1001774/environment
    2023-08-28T00:54:17.785902  /lava-1001774/bin/lava-test-runner /lava-10=
01774/1
    2023-08-28T00:54:17.806788  . /lava-1001774/environment
    2023-08-28T00:54:17.806900  / # /lava-1001774/bin/lava-test-runner /lav=
a-1001774/1
    2023-08-28T00:54:17.886102  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-28T00:54:17.886323  + cd /lava-1001774/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebf13fc618663599286d7d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ebf13fc618663599286d84
        failing since 33 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-08-28T00:58:10.584326  / # #
    2023-08-28T00:58:12.046055  export SHELL=3D/bin/sh
    2023-08-28T00:58:12.066735  #
    2023-08-28T00:58:12.066942  / # export SHELL=3D/bin/sh
    2023-08-28T00:58:14.023409  / # . /lava-1001780/environment
    2023-08-28T00:58:17.622781  /lava-1001780/bin/lava-test-runner /lava-10=
01780/1
    2023-08-28T00:58:17.643572  . /lava-1001780/environment
    2023-08-28T00:58:17.643683  / # /lava-1001780/bin/lava-test-runner /lav=
a-1001780/1
    2023-08-28T00:58:17.825323  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-28T00:58:17.825667  + cd /lava-1001780/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebf5138e081a42a9286d79

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774c0-ek=
874.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774c0-ek=
874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ebf5138e081a42a9286d80
        failing since 33 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-08-28T01:14:28.657910  / # #
    2023-08-28T01:14:30.121250  export SHELL=3D/bin/sh
    2023-08-28T01:14:30.141824  #
    2023-08-28T01:14:30.142029  / # export SHELL=3D/bin/sh
    2023-08-28T01:14:32.097487  / # . /lava-1001797/environment
    2023-08-28T01:14:35.695775  /lava-1001797/bin/lava-test-runner /lava-10=
01797/1
    2023-08-28T01:14:35.716539  . /lava-1001797/environment
    2023-08-28T01:14:35.716647  / # /lava-1001797/bin/lava-test-runner /lav=
a-1001797/1
    2023-08-28T01:14:35.795800  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-28T01:14:35.796017  + cd /lava-1001797/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebefa19ccc16f9b6286d84

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ebefa19ccc16f9b6286d8d
        failing since 33 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-08-28T00:53:02.759310  / # #

    2023-08-28T00:53:02.861421  export SHELL=3D/bin/sh

    2023-08-28T00:53:02.862040  #

    2023-08-28T00:53:02.963022  / # export SHELL=3D/bin/sh. /lava-11368214/=
environment

    2023-08-28T00:53:02.963249  =


    2023-08-28T00:53:03.063897  / # . /lava-11368214/environment/lava-11368=
214/bin/lava-test-runner /lava-11368214/1

    2023-08-28T00:53:03.064354  =


    2023-08-28T00:53:03.067894  / # /lava-11368214/bin/lava-test-runner /la=
va-11368214/1

    2023-08-28T00:53:03.129996  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-28T00:53:03.130458  + cd /lav<8>[   16.416617] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11368214_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebf07d9bf45dd6e4286dd0

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm64/defconfig+kselftest/gcc-10/lab-collabora/baseline-r8a77960-ulc=
b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm64/defconfig+kselftest/gcc-10/lab-collabora/baseline-r8a77960-ulc=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ebf07d9bf45dd6e4286dd9
        failing since 33 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-08-28T00:56:47.694525  / # #

    2023-08-28T00:56:47.795057  export SHELL=3D/bin/sh

    2023-08-28T00:56:47.795164  #

    2023-08-28T00:56:47.895578  / # export SHELL=3D/bin/sh. /lava-11368237/=
environment

    2023-08-28T00:56:47.895709  =


    2023-08-28T00:56:47.996153  / # . /lava-11368237/environment/lava-11368=
237/bin/lava-test-runner /lava-11368237/1

    2023-08-28T00:56:47.996350  =


    2023-08-28T00:56:48.008271  / # /lava-11368237/bin/lava-test-runner /la=
va-11368237/1

    2023-08-28T00:56:48.115266  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-28T00:56:48.115348  + cd /lava-11368237/1/tests/1_bootrr
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 4          =


  Details:     https://kernelci.org/test/plan/id/64ebf092fd0a4d33df286d9c

  Results:     63 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-j=
aq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-j=
aq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-i2c-present: https://kernelci.or=
g/test/case/id/64ebf092fd0a4d33df286dcf
        failing since 224 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-28T00:57:14.071134  FIRST,<8>[   18.707284] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>

    2023-08-28T00:57:14.074949   INC default to 1.

    2023-08-28T00:57:14.075016  =


    2023-08-28T00:57:14.078610  	-w	Pad to last with leading zeros

    2023-08-28T00:57:14.081084  	-s SEP	String separator

    2023-08-28T00:57:14.084958  /lava-11368320/1/../bin/lava-test-case

    2023-08-28T00:57:14.091073  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.

    2023-08-28T00:57:14.091138  =

   =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/64ebf092fd0a4d33df286dd0
        failing since 224 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-28T00:57:14.048850  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC)<8=
>[   18.688207] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-08-28T00:57:14.050833   multi-call binary.

    2023-08-28T00:57:14.051052  =


    2023-08-28T00:57:14.055432  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-08-28T00:57:14.055653  =


    2023-08-28T00:57:14.060618  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/64ebf092fd0a4d33df286dd1
        failing since 224 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24) =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ebf092fd0a4d33df286de5
        failing since 224 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-28T00:57:01.976101  + <8>[    6.619304] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11368320_1.5.2.3.1>

    2023-08-28T00:57:01.976648  set +x

    2023-08-28T00:57:02.082535  #

    2023-08-28T00:57:02.083739  =


    2023-08-28T00:57:02.185403  / # #export SHELL=3D/bin/sh

    2023-08-28T00:57:02.186180  =


    2023-08-28T00:57:02.287541  / # export SHELL=3D/bin/sh. /lava-11368320/=
environment

    2023-08-28T00:57:02.288255  =


    2023-08-28T00:57:02.389683  / # . /lava-11368320/environment/lava-11368=
320/bin/lava-test-runner /lava-11368320/1

    2023-08-28T00:57:02.390729  =

 =

    ... (19 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebefb7f413c1a9ff286d7a

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ebefb7f413c1a9ff286daa
        failing since 225 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-28T00:51:33.537901  <8>[   17.063679] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 73641_1.5.2.4.1>
    2023-08-28T00:51:33.650129  / # #
    2023-08-28T00:51:33.753018  export SHELL=3D/bin/sh
    2023-08-28T00:51:33.753722  #
    2023-08-28T00:51:33.855813  / # export SHELL=3D/bin/sh. /lava-73641/env=
ironment
    2023-08-28T00:51:33.856532  =

    2023-08-28T00:51:33.958848  / # . /lava-73641/environment/lava-73641/bi=
n/lava-test-runner /lava-73641/1
    2023-08-28T00:51:33.960246  =

    2023-08-28T00:51:33.964724  / # /lava-73641/bin/lava-test-runner /lava-=
73641/1
    2023-08-28T00:51:34.009828  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebefb5cb49d2d552286d84

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ebefb5cb49d2d552286d8d
        failing since 33 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-08-28T00:53:19.860339  / # #

    2023-08-28T00:53:19.960841  export SHELL=3D/bin/sh

    2023-08-28T00:53:19.961025  #

    2023-08-28T00:53:20.061529  / # export SHELL=3D/bin/sh. /lava-11368216/=
environment

    2023-08-28T00:53:20.061648  =


    2023-08-28T00:53:20.162154  / # . /lava-11368216/environment/lava-11368=
216/bin/lava-test-runner /lava-11368216/1

    2023-08-28T00:53:20.162381  =


    2023-08-28T00:53:20.174192  / # /lava-11368216/bin/lava-test-runner /la=
va-11368216/1

    2023-08-28T00:53:20.235223  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-28T00:53:20.235297  + cd /lava-1136821<8>[   18.293100] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11368216_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

