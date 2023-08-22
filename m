Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A80EE49A3
	for <webhook@archiver.kernel.org>; Tue, 22 Aug 2023 12:49:48 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web11.7228.1692708582515496305
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 22 Aug 2023 05:49:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=0u6W41MW;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.182, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1bc63ef9959so34580365ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 22 Aug 2023 05:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692708581; x=1693313381;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fIX61yegSC+OMYDclOFgEHFHV5F8IamBNJxTJYBktTE=;
        b=0u6W41MWVGrWNYPfzpgu+cHJaNhdFyBC/KP0TKOHXgBA1yt0Sy41L9ptEwJEMNGxIL
         O4RF1BfA3KwgdXpXfPZmEzFPuv4H2b+f1Lb/hNt45LPRr8O7RUvW6+tMyALHPlaLpQhp
         FqqajU3unuSBsE+Zf64LCAiuNU0TEZxPHFwpvQYe5AdHVAILN/0LSa92nCP2+5/gwnrD
         TX96i1bV5j7qAUBIRe425c8aVfdjopUKkuVwUujmpi8bcJpXoeIQpgOf2BK1CQKeUX3n
         nX4zLZJS4IZ8OL7/041zySYSAqlu+xWJVQEM6hNjMd2Vtz1jbTk4RnWCE9Gb92MYfIfI
         ZYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692708581; x=1693313381;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fIX61yegSC+OMYDclOFgEHFHV5F8IamBNJxTJYBktTE=;
        b=dMbdBzhy2osyNWPGW7Pa4SzEdkzl/+DAaKD8X0gQaWuM07DTkJiAhcyTyGaBSe09uk
         T/eDkNacPz88mm+AP+rbAAt09cXvu0Nyw5AIBtq7P5r8ACWBsUvhoRlocE1sozgcOduc
         pGv3iATBAnndFz55RvDz3y+XIt1dFMrHy0BUwTuGDCbjjoIEVbUMIe/OBLuW63SSKtEB
         laiL6qFu8nvFIJ6gxd2iCdDur5oc9EdS7sNTE+psN5EuqmCNtHMBh47/fG747vnWoh7q
         OtvrjmJrUZfY1ysSTjeOn+PmS/t76+i1hjT5hJcsUtABQhmtPM/Dy0D+YvY5jNESgPz0
         cPUg==
X-Gm-Message-State: AOJu0YyaYeeC0upXc7WAO62C84WahErrrgIYtGUS4vRqYjW682iuC2VJ
	LAui2xdZBl4nsmptwGoq9YLlA4CXCCBSzy0kuUqO1Q==
X-Google-Smtp-Source: AGHT+IHOo8UPRthAq8Y3k3oWD/YJSvr3NMvWlncnb8De/z2JLUIBKGmhheoNOImeG9jrB0OknqvCFw==
X-Received: by 2002:a17:902:ecd2:b0:1bc:671d:6d31 with SMTP id a18-20020a170902ecd200b001bc671d6d31mr12080796plh.3.1692708580407;
        Tue, 22 Aug 2023 05:49:40 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y2-20020a17090264c200b001bf3bdbceb5sm8816737pli.134.2023.08.22.05.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 05:49:39 -0700 (PDT)
Message-ID: <64e4aee3.170a0220.13ed7.0260@mx.google.com>
Date: Tue, 22 Aug 2023 05:49:39 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.186-cip37-27-gd6d928db0a620
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
Subject: cip/linux-5.10.y-cip baseline: 141 runs,
 36 regressions (v5.10.186-cip37-27-gd6d928db0a620)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Aug 2023 12:49:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12821

cip/linux-5.10.y-cip baseline: 141 runs, 36 regressions (v5.10.186-cip37-27=
-gd6d928db0a620)

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

juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig+kselftest          | 1          =

juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

mt8173-elm-hana              | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig+kselftest          | 1          =

r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =

r8a77960-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig+kselftest          | 1          =

r8a77960-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 4          =

sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.186-cip37-27-gd6d928db0a620/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.186-cip37-27-gd6d928db0a620
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      d6d928db0a620394e433833b5dda4ec7ac822999 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4a23b781fc45a9ab1e3df

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e4a23b781fc45a9ab1e3e4
        failing since 220 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-22T11:55:37.652776  + set +x

    2023-08-22T11:55:37.659546  <8>[   11.656116] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11330292_1.4.2.3.1>

    2023-08-22T11:55:37.764143  / # #

    2023-08-22T11:55:37.864830  export SHELL=3D/bin/sh

    2023-08-22T11:55:37.865048  #

    2023-08-22T11:55:37.965605  / # export SHELL=3D/bin/sh. /lava-11330292/=
environment

    2023-08-22T11:55:37.965833  =


    2023-08-22T11:55:38.066372  / # . /lava-11330292/environment/lava-11330=
292/bin/lava-test-runner /lava-11330292/1

    2023-08-22T11:55:38.066687  =


    2023-08-22T11:55:38.071686  / # /lava-11330292/bin/lava-test-runner /la=
va-11330292/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4a2542a69a052fbb1e3b3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e4a2542a69a052fbb1e3b8
        failing since 220 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-22T11:55:55.641796  + set +x<8>[   12.180422] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11330327_1.4.2.3.1>

    2023-08-22T11:55:55.641913  =


    2023-08-22T11:55:55.746106  / # #

    2023-08-22T11:55:55.847019  export SHELL=3D/bin/sh

    2023-08-22T11:55:55.847818  #

    2023-08-22T11:55:55.949138  / # export SHELL=3D/bin/sh. /lava-11330327/=
environment

    2023-08-22T11:55:55.949513  =


    2023-08-22T11:55:56.050298  / # . /lava-11330327/environment/lava-11330=
327/bin/lava-test-runner /lava-11330327/1

    2023-08-22T11:55:56.050581  =


    2023-08-22T11:55:56.055285  / # /lava-11330327/bin/lava-test-runner /la=
va-11330327/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4a21dda7f9c053bb1e3d7

  Results:     47 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline=
-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline=
-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e4a21eda7f9c053bb1e40b
        failing since 220 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-22T11:54:36.156539  + set +x
    2023-08-22T11:54:36.161618  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 63986_1.5.2.=
4.1>
    2023-08-22T11:54:36.275768  / # #
    2023-08-22T11:54:36.378559  export SHELL=3D/bin/sh
    2023-08-22T11:54:36.379362  #
    2023-08-22T11:54:36.481227  / # export SHELL=3D/bin/sh. /lava-63986/env=
ironment
    2023-08-22T11:54:36.482013  =

    2023-08-22T11:54:36.583976  / # . /lava-63986/environment/lava-63986/bi=
n/lava-test-runner /lava-63986/1
    2023-08-22T11:54:36.585233  =

    2023-08-22T11:54:36.591749  / # /lava-63986/bin/lava-test-runner /lava-=
63986/1 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | bcm283=
5_defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4a19a36b93df597b1e413

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm/bcm2835_defconfig/gcc-10/lab-collabora/baselin=
e-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm/bcm2835_defconfig/gcc-10/lab-collabora/baselin=
e-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e4a19a36b93df597b1e418
        failing since 27 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-08-22T11:54:15.287351  / # #

    2023-08-22T11:54:15.389516  export SHELL=3D/bin/sh

    2023-08-22T11:54:15.390216  #

    2023-08-22T11:54:15.491612  / # export SHELL=3D/bin/sh. /lava-11330271/=
environment

    2023-08-22T11:54:15.492319  =


    2023-08-22T11:54:15.593814  / # . /lava-11330271/environment/lava-11330=
271/bin/lava-test-runner /lava-11330271/1

    2023-08-22T11:54:15.594892  =


    2023-08-22T11:54:15.611499  / # /lava-11330271/bin/lava-test-runner /la=
va-11330271/1

    2023-08-22T11:54:15.675527  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-22T11:54:15.719483  + cd /lava-11330271/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4a54608c6b4a22cb1e5a2

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline=
-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline=
-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e4a54608c6b4a22cb1e5cf
        failing since 220 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-22T12:07:52.309790  <8>[   22.469906] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 64119_1.5.2.4.1>
    2023-08-22T12:07:52.418627  / # #
    2023-08-22T12:07:52.521667  export SHELL=3D/bin/sh
    2023-08-22T12:07:52.522563  #
    2023-08-22T12:07:52.624527  / # export SHELL=3D/bin/sh. /lava-64119/env=
ironment
    2023-08-22T12:07:52.625495  =

    2023-08-22T12:07:52.727251  / # . /lava-64119/environment/lava-64119/bi=
n/lava-test-runner /lava-64119/1
    2023-08-22T12:07:52.728624  =

    2023-08-22T12:07:52.732721  / # /lava-64119/bin/lava-test-runner /lava-=
64119/1
    2023-08-22T12:07:52.824559  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4a5030465f667a5b1e3bb

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-bea=
glebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-bea=
glebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e4a5030465f667a5b1e3be
        failing since 220 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-22T12:06:48.201423  / # #
    2023-08-22T12:06:48.304848  export SHELL=3D/bin/sh
    2023-08-22T12:06:48.305857  #
    2023-08-22T12:06:48.408178  / # export SHELL=3D/bin/sh. /lava-999341/en=
vironment
    2023-08-22T12:06:48.409309  =

    2023-08-22T12:06:48.511728  / # . /lava-999341/environment/lava-999341/=
bin/lava-test-runner /lava-999341/1
    2023-08-22T12:06:48.513558  =

    2023-08-22T12:06:48.524586  / # /lava-999341/bin/lava-test-runner /lava=
-999341/1
    2023-08-22T12:06:48.650343  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-22T12:06:48.650906  + cd /lava-999341/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4a44f25ec9a2694b1e3af

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm/omap2plus_defconfig/gcc-10/lab-broonie/baselin=
e-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm/omap2plus_defconfig/gcc-10/lab-broonie/baselin=
e-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e4a44f25ec9a2694b1e3e5
        failing since 220 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-22T12:04:13.851924  + set +x
    2023-08-22T12:04:13.861023  <8>[   20.510747] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 64061_1.5.2.4.1>
    2023-08-22T12:04:13.967609  / # #
    2023-08-22T12:04:14.070598  export SHELL=3D/bin/sh
    2023-08-22T12:04:14.071340  #
    2023-08-22T12:04:14.173714  / # export SHELL=3D/bin/sh. /lava-64061/env=
ironment
    2023-08-22T12:04:14.174467  =

    2023-08-22T12:04:14.277002  / # . /lava-64061/environment/lava-64061/bi=
n/lava-test-runner /lava-64061/1
    2023-08-22T12:04:14.278213  =

    2023-08-22T12:04:14.282279  / # /lava-64061/bin/lava-test-runner /lava-=
64061/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4a3729253ee73cfb1e3b2

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-be=
aglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-be=
aglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e4a3729253ee73cfb1e3b5
        failing since 220 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-22T12:00:24.136009  / # #
    2023-08-22T12:00:24.239387  export SHELL=3D/bin/sh
    2023-08-22T12:00:24.240404  #
    2023-08-22T12:00:24.342579  / # export SHELL=3D/bin/sh. /lava-999338/en=
vironment
    2023-08-22T12:00:24.343620  =

    2023-08-22T12:00:24.445974  / # . /lava-999338/environment/lava-999338/=
bin/lava-test-runner /lava-999338/1
    2023-08-22T12:00:24.447584  =

    2023-08-22T12:00:24.457702  / # /lava-999338/bin/lava-test-runner /lava=
-999338/1
    2023-08-22T12:00:24.553756  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-22T12:00:24.592701  + cd /lava-999338/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls1028a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4a6dd52279d293cb1e3bf

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1028=
a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1028=
a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e4a6dd52279d293cb1e3c2
        failing since 161 days (last pass: v5.10.155-cip21, first fail: v5.=
10.173-cip28)

    2023-08-22T12:15:15.655052  [   18.990106] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1244851_1.5.2.4.1>
    2023-08-22T12:15:15.760263  =

    2023-08-22T12:15:15.861431  / # #export SHELL=3D/bin/sh
    2023-08-22T12:15:15.861828  =

    2023-08-22T12:15:15.962786  / # export SHELL=3D/bin/sh. /lava-1244851/e=
nvironment
    2023-08-22T12:15:15.963204  =

    2023-08-22T12:15:16.064184  / # . /lava-1244851/environment/lava-124485=
1/bin/lava-test-runner /lava-1244851/1
    2023-08-22T12:15:16.064846  =

    2023-08-22T12:15:16.069025  / # /lava-1244851/bin/lava-test-runner /lav=
a-1244851/1
    2023-08-22T12:15:16.087206  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls1088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4a6db8aa243d7d6b1e412

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1088=
a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1088=
a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e4a6db8aa243d7d6b1e415
        failing since 220 days (last pass: v5.10.155-cip21, first fail: v5.=
10.162-cip24)

    2023-08-22T12:15:03.391881  [   10.375895] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1244850_1.5.2.4.1>
    2023-08-22T12:15:03.497203  =

    2023-08-22T12:15:03.598387  / # #export SHELL=3D/bin/sh
    2023-08-22T12:15:03.598926  =

    2023-08-22T12:15:03.699920  / # export SHELL=3D/bin/sh. /lava-1244850/e=
nvironment
    2023-08-22T12:15:03.700353  =

    2023-08-22T12:15:03.801334  / # . /lava-1244850/environment/lava-124485=
0/bin/lava-test-runner /lava-1244850/1
    2023-08-22T12:15:03.802058  =

    2023-08-22T12:15:03.806134  / # /lava-1244850/bin/lava-test-runner /lav=
a-1244850/1
    2023-08-22T12:15:03.821905  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls2088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4a69f05ad74568db1e410

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088=
a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088=
a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e4a69f05ad74568db1e413
        failing since 41 days (last pass: v5.10.155-cip21, first fail: v5.1=
0.165-cip25)

    2023-08-22T12:14:02.457774  + [   15.041151] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 1244849_1.5.2.4.1>
    2023-08-22T12:14:02.458013  set +x
    2023-08-22T12:14:02.563448  =

    2023-08-22T12:14:02.664801  / # #export SHELL=3D/bin/sh
    2023-08-22T12:14:02.665339  =

    2023-08-22T12:14:02.766418  / # export SHELL=3D/bin/sh. /lava-1244849/e=
nvironment
    2023-08-22T12:14:02.766885  =

    2023-08-22T12:14:02.867916  / # . /lava-1244849/environment/lava-124484=
9/bin/lava-test-runner /lava-1244849/1
    2023-08-22T12:14:02.868628  =

    2023-08-22T12:14:02.872637  / # /lava-1244849/bin/lava-test-runner /lav=
a-1244849/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-lx2160a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4a6ef52279d293cb1e3cc

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160=
a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160=
a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e4a6ef52279d293cb1e3cf
        failing since 153 days (last pass: v5.10.154-cip20, first fail: v5.=
10.175-cip29)

    2023-08-22T12:15:20.369692  [   14.202257] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1244848_1.5.2.4.1>
    2023-08-22T12:15:20.475084  =

    2023-08-22T12:15:20.576377  / # #export SHELL=3D/bin/sh
    2023-08-22T12:15:20.576785  =

    2023-08-22T12:15:20.677746  / # export SHELL=3D/bin/sh. /lava-1244848/e=
nvironment
    2023-08-22T12:15:20.678148  =

    2023-08-22T12:15:20.779171  / # . /lava-1244848/environment/lava-124484=
8/bin/lava-test-runner /lava-1244848/1
    2023-08-22T12:15:20.779879  =

    2023-08-22T12:15:20.783802  / # /lava-1244848/bin/lava-test-runner /lav=
a-1244848/1
    2023-08-22T12:15:20.797965  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4a231da7f9c053bb1e429

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e4a231da7f9c053bb1e42e
        failing since 130 days (last pass: v5.10.176-cip30, first fail: v5.=
10.177-cip31)

    2023-08-22T11:55:21.282542  + set +x

    2023-08-22T11:55:21.288915  <8>[   14.299333] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11330326_1.4.2.3.1>

    2023-08-22T11:55:21.392921  / # #

    2023-08-22T11:55:21.493481  export SHELL=3D/bin/sh

    2023-08-22T11:55:21.493663  #

    2023-08-22T11:55:21.594151  / # export SHELL=3D/bin/sh. /lava-11330326/=
environment

    2023-08-22T11:55:21.594410  =


    2023-08-22T11:55:21.695005  / # . /lava-11330326/environment/lava-11330=
326/bin/lava-test-runner /lava-11330326/1

    2023-08-22T11:55:21.695345  =


    2023-08-22T11:55:21.699443  / # /lava-11330326/bin/lava-test-runner /la=
va-11330326/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4a237da7f9c053bb1e43f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e4a237da7f9c053bb1e444
        failing since 130 days (last pass: v5.10.176-cip30, first fail: v5.=
10.177-cip31)

    2023-08-22T11:55:21.140202  <8>[   12.164217] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11330313_1.4.2.3.1>

    2023-08-22T11:55:21.143580  + set +x

    2023-08-22T11:55:21.244896  #

    2023-08-22T11:55:21.245206  =


    2023-08-22T11:55:21.345798  / # #export SHELL=3D/bin/sh

    2023-08-22T11:55:21.346006  =


    2023-08-22T11:55:21.446542  / # export SHELL=3D/bin/sh. /lava-11330313/=
environment

    2023-08-22T11:55:21.446751  =


    2023-08-22T11:55:21.547345  / # . /lava-11330313/environment/lava-11330=
313/bin/lava-test-runner /lava-11330313/1

    2023-08-22T11:55:21.547671  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4a503c474a39447b1e3bc

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e4a503c474a39447b1e3c1
        failing since 220 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-22T12:07:11.833060  / # #

    2023-08-22T12:07:11.934537  export SHELL=3D/bin/sh

    2023-08-22T12:07:11.934766  #

    2023-08-22T12:07:12.035755  / # export SHELL=3D/bin/sh. /lava-11330349/=
environment

    2023-08-22T12:07:12.036483  =


    2023-08-22T12:07:12.138222  / # . /lava-11330349/environment/lava-11330=
349/bin/lava-test-runner /lava-11330349/1

    2023-08-22T12:07:12.139357  =


    2023-08-22T12:07:12.156122  / # /lava-11330349/bin/lava-test-runner /la=
va-11330349/1

    2023-08-22T12:07:12.272239  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-22T12:07:12.272777  + cd /lava-11330349/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4a6297c29fa1142b1e41c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/bas=
eline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/bas=
eline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e4a6297c29fa1142b1e421
        failing since 220 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-22T12:12:01.017817  + set +x
    2023-08-22T12:12:01.018048  [   10.252859] <LAVA_SIGNAL_ENDRUN 0_dmesg =
997989_1.5.2.3.1>
    2023-08-22T12:12:01.126003  / # #
    2023-08-22T12:12:01.227538  export SHELL=3D/bin/sh
    2023-08-22T12:12:01.227990  #
    2023-08-22T12:12:01.329233  / # export SHELL=3D/bin/sh. /lava-997989/en=
vironment
    2023-08-22T12:12:01.329677  =

    2023-08-22T12:12:01.430863  / # . /lava-997989/environment/lava-997989/=
bin/lava-test-runner /lava-997989/1
    2023-08-22T12:12:01.431436  =

    2023-08-22T12:12:01.433979  / # /lava-997989/bin/lava-test-runner /lava=
-997989/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4a4ea5bda705a70b1e3bd

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/base=
line-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/base=
line-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e4a4ea5bda705a70b1e3c2
        failing since 220 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-22T12:06:19.884302  + set[    7.312134] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 997988_1.5.2.3.1>
    2023-08-22T12:06:19.884505   +x
    2023-08-22T12:06:19.990622  / # #
    2023-08-22T12:06:20.092168  export SHELL=3D/bin/sh
    2023-08-22T12:06:20.092714  #
    2023-08-22T12:06:20.194119  / # export SHELL=3D/bin/sh. /lava-997988/en=
vironment
    2023-08-22T12:06:20.194796  =

    2023-08-22T12:06:20.296430  / # . /lava-997988/environment/lava-997988/=
bin/lava-test-runner /lava-997988/1
    2023-08-22T12:06:20.297136  =

    2023-08-22T12:06:20.299557  / # /lava-997988/bin/lava-test-runner /lava=
-997988/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6ul-14x14-evk             | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4a536832ab52b1cb1e3c9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx=
6ul-14x14-evk.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx=
6ul-14x14-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e4a536832ab52b1cb1e3cc
        failing since 153 days (last pass: v5.10.145-cip17, first fail: v5.=
10.175-cip29)

    2023-08-22T12:07:51.743459  + set +x
    2023-08-22T12:07:51.746594  <8>[   29.929386] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1244837_1.5.2.4.1>
    2023-08-22T12:07:51.858579  / # #
    2023-08-22T12:07:53.014325  export SHELL=3D/bin/sh
    2023-08-22T12:07:53.019976  #
    2023-08-22T12:07:54.561883  / # export SHELL=3D/bin/sh. /lava-1244837/e=
nvironment
    2023-08-22T12:07:54.567517  =

    2023-08-22T12:07:57.379445  / # . /lava-1244837/environment/lava-124483=
7/bin/lava-test-runner /lava-1244837/1
    2023-08-22T12:07:57.385472  =

    2023-08-22T12:07:57.387177  / # /lava-1244837/bin/lava-test-runner /lav=
a-1244837/1 =

    ... (18 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4a50f8d463c41a3b1e3b2

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx=
7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx=
7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e4a50f8d463c41a3b1e3b5
        failing since 220 days (last pass: v5.10.155-cip21, first fail: v5.=
10.162-cip24)

    2023-08-22T12:07:26.086672  / # #
    2023-08-22T12:07:27.242411  export SHELL=3D/bin/sh
    2023-08-22T12:07:27.248063  #
    2023-08-22T12:07:28.789684  / # export SHELL=3D/bin/sh. /lava-1244838/e=
nvironment
    2023-08-22T12:07:28.795337  =

    2023-08-22T12:07:31.607157  / # . /lava-1244838/environment/lava-124483=
8/bin/lava-test-runner /lava-1244838/1
    2023-08-22T12:07:31.613107  =

    2023-08-22T12:07:31.627042  / # /lava-1244838/bin/lava-test-runner /lav=
a-1244838/1
    2023-08-22T12:07:31.710814  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-22T12:07:31.711106  + cd /lava-1244838/1/tests/1_bootrr =

    ... (19 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7ulp-evk                  | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4a539ee580883b3b1e3bb

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx=
7ulp-evk.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx=
7ulp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e4a539ee580883b3b1e3be
        failing since 161 days (last pass: v5.10.155-cip21, first fail: v5.=
10.173-cip28)

    2023-08-22T12:07:54.365232  + set +x<8>[   29.021651] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 1244839_1.5.2.4.1>
    2023-08-22T12:07:54.365534  =

    2023-08-22T12:07:54.474204  / # #
    2023-08-22T12:07:55.629946  export SHELL=3D/bin/sh
    2023-08-22T12:07:55.635575  #
    2023-08-22T12:07:55.635873  / # export SHELL=3D/bin/sh
    2023-08-22T12:07:57.177645  / # . /lava-1244839/environment
    2023-08-22T12:07:59.994581  /lava-1244839/bin/lava-test-runner /lava-12=
44839/1
    2023-08-22T12:08:00.000647  . /lava-1244839/environment
    2023-08-22T12:08:00.001014  / # /lava-1244839/bin/lava-test-runner /lav=
a-1244839/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4ad3708509a39a9b1e3af

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm64/defconfig+kselftest/gcc-10/lab-broonie/basel=
ine-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm64/defconfig+kselftest/gcc-10/lab-broonie/basel=
ine-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e4ad3808509a39a9b1e3ea
        failing since 27 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-08-22T12:41:52.631118  <8>[   18.550801] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 64179_1.5.2.4.1>
    2023-08-22T12:41:52.740408  / # #
    2023-08-22T12:41:52.843533  export SHELL=3D/bin/sh
    2023-08-22T12:41:52.844321  #
    2023-08-22T12:41:52.946320  / # export SHELL=3D/bin/sh. /lava-64179/env=
ironment
    2023-08-22T12:41:52.947291  =

    2023-08-22T12:41:53.049732  / # . /lava-64179/environment/lava-64179/bi=
n/lava-test-runner /lava-64179/1
    2023-08-22T12:41:53.051129  =

    2023-08-22T12:41:53.062569  / # /lava-64179/bin/lava-test-runner /lava-=
64179/1
    2023-08-22T12:41:53.241335  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4ae3c4e48ee81aeb1e3c1

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-u=
boot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-u=
boot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e4ae3c4e48ee81aeb1e3fa
        failing since 27 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-08-22T12:46:27.010508  / # #
    2023-08-22T12:46:27.113501  export SHELL=3D/bin/sh
    2023-08-22T12:46:27.114290  #
    2023-08-22T12:46:27.216693  / # export SHELL=3D/bin/sh. /lava-64226/env=
ironment
    2023-08-22T12:46:27.217475  =

    2023-08-22T12:46:27.319424  / # . /lava-64226/environment/lava-64226/bi=
n/lava-test-runner /lava-64226/1
    2023-08-22T12:46:27.320328  =

    2023-08-22T12:46:27.333446  / # /lava-64226/bin/lava-test-runner /lava-=
64226/1
    2023-08-22T12:46:27.393453  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-22T12:46:27.393975  + cd /lava-64226/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4a521f3fefe9c02b1e3bd

  Results:     28 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm64/defconfig+arm64-chromebook/gcc-10/lab-collab=
ora/baseline-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm64/defconfig+arm64-chromebook/gcc-10/lab-collab=
ora/baseline-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e4a521f3fefe9c02b1e3d9
        failing since 220 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-22T12:07:43.043944  <8>[   15.595528] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-08-22T12:07:43.045420  + set +x

    2023-08-22T12:07:43.051248  <8>[   15.605091] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11330355_1.5.2.3.1>

    2023-08-22T12:07:43.155827  =


    2023-08-22T12:07:43.256368  / # #export SHELL=3D/bin/sh

    2023-08-22T12:07:43.256576  =


    2023-08-22T12:07:43.357178  / # export SHELL=3D/bin/sh. /lava-11330355/=
environment

    2023-08-22T12:07:43.357329  =


    2023-08-22T12:07:43.457872  / # . /lava-11330355/environment/lava-11330=
355/bin/lava-test-runner /lava-11330355/1

    2023-08-22T12:07:43.458115  =

 =

    ... (21 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4a30cf9b4d0cc6db1e3bc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a=
7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a=
7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64e4a30cf9b4d0cc6db1e=
3bd
        failing since 78 days (last pass: v5.10.180-cip34, first fail: v5.1=
0.180-cip34-19-gf0f6960f132cd) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4a578832ab52b1cb1e3d9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ba=
seline-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ba=
seline-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e4a578832ab52b1cb1e3dc
        failing since 27 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-08-22T12:09:13.407109  + set +x
    2023-08-22T12:09:13.407231  <8>[   83.737086] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 999346_1.5.2.4.1>
    2023-08-22T12:09:13.513414  / # #
    2023-08-22T12:09:14.972352  export SHELL=3D/bin/sh
    2023-08-22T12:09:14.992769  #
    2023-08-22T12:09:14.992932  / # export SHELL=3D/bin/sh
    2023-08-22T12:09:16.874138  / # . /lava-999346/environment
    2023-08-22T12:09:20.324451  /lava-999346/bin/lava-test-runner /lava-999=
346/1
    2023-08-22T12:09:20.345107  . /lava-999346/environment
    2023-08-22T12:09:20.345255  / # /lava-999346/bin/lava-test-runner /lava=
-999346/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4a5b5583b655e79b1e3ba

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ba=
seline-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ba=
seline-r8a774b1-hihope-rzg2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e4a5b5583b655e79b1e3bd
        failing since 27 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-08-22T12:10:00.318231  + set +x
    2023-08-22T12:10:00.318351  <8>[   84.037040] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 999351_1.5.2.4.1>
    2023-08-22T12:10:00.423002  / # #
    2023-08-22T12:10:01.882696  export SHELL=3D/bin/sh
    2023-08-22T12:10:01.903220  #
    2023-08-22T12:10:01.903373  / # export SHELL=3D/bin/sh
    2023-08-22T12:10:03.785513  / # . /lava-999351/environment
    2023-08-22T12:10:07.238026  /lava-999351/bin/lava-test-runner /lava-999=
351/1
    2023-08-22T12:10:07.258576  . /lava-999351/environment
    2023-08-22T12:10:07.258684  / # /lava-999351/bin/lava-test-runner /lava=
-999351/1 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4a5a0f3fefe9c02b1e3fa

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ba=
seline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ba=
seline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e4a5a0f3fefe9c02b1e3fd
        failing since 27 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-08-22T12:09:49.005359  / # #
    2023-08-22T12:09:50.465522  export SHELL=3D/bin/sh
    2023-08-22T12:09:50.486023  #
    2023-08-22T12:09:50.486229  / # export SHELL=3D/bin/sh
    2023-08-22T12:09:52.369304  / # . /lava-999347/environment
    2023-08-22T12:09:55.821422  /lava-999347/bin/lava-test-runner /lava-999=
347/1
    2023-08-22T12:09:55.842103  . /lava-999347/environment
    2023-08-22T12:09:55.842224  / # /lava-999347/bin/lava-test-runner /lava=
-999347/1
    2023-08-22T12:09:55.919156  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-22T12:09:55.919355  + cd /lava-999347/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4a6f457ea5f3466b1e3af

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-=
r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-=
r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e4a6f457ea5f3466b1e3b2
        failing since 27 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-08-22T12:15:24.540126  / # #
    2023-08-22T12:15:26.001941  export SHELL=3D/bin/sh
    2023-08-22T12:15:26.022486  #
    2023-08-22T12:15:26.022692  / # export SHELL=3D/bin/sh
    2023-08-22T12:15:27.907165  / # . /lava-999357/environment
    2023-08-22T12:15:31.365823  /lava-999357/bin/lava-test-runner /lava-999=
357/1
    2023-08-22T12:15:31.386605  . /lava-999357/environment
    2023-08-22T12:15:31.386712  / # /lava-999357/bin/lava-test-runner /lava=
-999357/1
    2023-08-22T12:15:31.568312  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-22T12:15:31.568529  + cd /lava-999357/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4a7d0a90f24d8e7b1e3b3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-e=
k874.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-e=
k874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e4a7d0a90f24d8e7b1e3b6
        failing since 27 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-08-22T12:19:00.709969  / # #
    2023-08-22T12:19:02.173244  export SHELL=3D/bin/sh
    2023-08-22T12:19:02.193943  #
    2023-08-22T12:19:02.194194  / # export SHELL=3D/bin/sh
    2023-08-22T12:19:04.079811  / # . /lava-999366/environment
    2023-08-22T12:19:07.537791  /lava-999366/bin/lava-test-runner /lava-999=
366/1
    2023-08-22T12:19:07.558579  . /lava-999366/environment
    2023-08-22T12:19:07.558691  / # /lava-999366/bin/lava-test-runner /lava=
-999366/1
    2023-08-22T12:19:07.638148  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-22T12:19:07.638370  + cd /lava-999366/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4a85307b001c1efb1e3ca

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm64/defconfig+kselftest/gcc-10/lab-collabora/bas=
eline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm64/defconfig+kselftest/gcc-10/lab-collabora/bas=
eline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e4a85307b001c1efb1e3cf
        failing since 27 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-08-22T12:22:59.407116  / # #

    2023-08-22T12:22:59.507909  export SHELL=3D/bin/sh

    2023-08-22T12:22:59.508172  #

    2023-08-22T12:22:59.608810  / # export SHELL=3D/bin/sh. /lava-11330374/=
environment

    2023-08-22T12:22:59.609096  =


    2023-08-22T12:22:59.709723  / # . /lava-11330374/environment/lava-11330=
374/bin/lava-test-runner /lava-11330374/1

    2023-08-22T12:22:59.710106  =


    2023-08-22T12:22:59.720133  / # /lava-11330374/bin/lava-test-runner /la=
va-11330374/1

    2023-08-22T12:22:59.826040  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-22T12:22:59.826245  + cd /lava-11330374/1/tests/1_bootrr
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4a867a90f24d8e7b1e3c3

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a7=
7960-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a7=
7960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e4a867a90f24d8e7b1e3c8
        failing since 27 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-08-22T12:23:16.161581  / # #

    2023-08-22T12:23:16.263619  export SHELL=3D/bin/sh

    2023-08-22T12:23:16.263862  #

    2023-08-22T12:23:16.364484  / # export SHELL=3D/bin/sh. /lava-11330391/=
environment

    2023-08-22T12:23:16.365200  =


    2023-08-22T12:23:16.466484  / # . /lava-11330391/environment/lava-11330=
391/bin/lava-test-runner /lava-11330391/1

    2023-08-22T12:23:16.467478  =


    2023-08-22T12:23:16.470035  / # /lava-11330391/bin/lava-test-runner /la=
va-11330391/1

    2023-08-22T12:23:16.533436  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-22T12:23:16.533947  + cd /lav<8>[   16.417318] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11330391_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 4          =


  Details:     https://kernelci.org/test/plan/id/64e4a501d4b9538edbb1e3af

  Results:     63 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-i2c-present: https://kernelci.or=
g/test/case/id/64e4a501d4b9538edbb1e3de
        failing since 218 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-22T12:08:24.040716  FIRST,<8>[   21.472727] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>

    2023-08-22T12:08:24.042414   INC default to 1.

    2023-08-22T12:08:24.042834  =


    2023-08-22T12:08:24.046223  	-w	Pad to last with leading zeros

    2023-08-22T12:08:24.048725  	-s SEP	String separator

    2023-08-22T12:08:24.052725  /lava-11330350/1/../bin/lava-test-case

    2023-08-22T12:08:24.058606  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.

    2023-08-22T12:08:24.058830  =

   =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/64e4a501d4b9538edbb1e3df
        failing since 218 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-22T12:08:24.016443  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC)<8=
>[   21.453726] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-08-22T12:08:24.020164   multi-call binary.

    2023-08-22T12:08:24.020388  =


    2023-08-22T12:08:24.024903  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-08-22T12:08:24.025121  =


    2023-08-22T12:08:24.029964  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/64e4a501d4b9538edbb1e3e0
        failing since 218 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-22T12:08:23.997621  /lava-11330350/1/../bin/lava-test-case<8>[ =
  21.436061] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-probed RE=
SULT=3Dpass>

    2023-08-22T12:08:23.997681  =

   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e4a501d4b9538edbb1e3f4
        failing since 218 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-22T12:08:11.933857  <8>[    9.372175] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-08-22T12:08:11.943589  + <8>[    9.384669] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11330350_1.5.2.3.1>

    2023-08-22T12:08:11.943994  set +x

    2023-08-22T12:08:12.050867  =


    2023-08-22T12:08:12.152541  / # #export SHELL=3D/bin/sh

    2023-08-22T12:08:12.153339  =


    2023-08-22T12:08:12.254743  / # export SHELL=3D/bin/sh. /lava-11330350/=
environment

    2023-08-22T12:08:12.255511  =


    2023-08-22T12:08:12.357207  / # . /lava-11330350/environment/lava-11330=
350/bin/lava-test-runner /lava-11330350/1

    2023-08-22T12:08:12.358391  =

 =

    ... (19 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4a6884ca6138f5fb1e3bc

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm64/defconfig/gcc-10/lab-collabora/baseline-sun5=
0i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/arm64/defconfig/gcc-10/lab-collabora/baseline-sun5=
0i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e4a6884ca6138f5fb1e3c1
        failing since 27 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-08-22T12:15:28.851826  / # #

    2023-08-22T12:15:28.953988  export SHELL=3D/bin/sh

    2023-08-22T12:15:28.954723  #

    2023-08-22T12:15:29.056016  / # export SHELL=3D/bin/sh. /lava-11330395/=
environment

    2023-08-22T12:15:29.056702  =


    2023-08-22T12:15:29.158052  / # . /lava-11330395/environment/lava-11330=
395/bin/lava-test-runner /lava-11330395/1

    2023-08-22T12:15:29.159247  =


    2023-08-22T12:15:29.176010  / # /lava-11330395/bin/lava-test-runner /la=
va-11330395/1

    2023-08-22T12:15:29.234017  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-22T12:15:29.234528  + cd /lava-1133039<8>[   18.285714] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11330395_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

