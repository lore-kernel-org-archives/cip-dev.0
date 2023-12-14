Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBECC10F13
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 15:45:49 +0000 (UTC)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
 by mx.groups.io with SMTP id smtpd.web10.25753.1702568743028411199
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 14 Dec 2023 07:45:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=pkGiOoyi;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.174, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6cea2a38b48so7573867b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 14 Dec 2023 07:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702568742; x=1703173542; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8j17breL6WEUj0nx93dJmKLMKyc/s1T6rwIZki2ItPA=;
        b=pkGiOoyizZQ/tNkl87yJurUHeSSgfrTyVaY8XSc749NTrpk0v6J+0WMj6cq5Tjwe4A
         G1Q+WRVi1To8kfSJSlnIYBSfaPA4meyca8FI0OQbT3NQYrKJCLcYccdYqD7uezYrAVrq
         rq+iDRd1D7LjlNVq7J44iPKgnBantJ6S/x+HUwOo/EYBw70EHJrxO5McTIodaOXOC0pA
         BtABtNm98lx1xoblq2grTDJfW07E/BLTvu9hMQMSOM25g6ujUKahhN/+NBPIIhP2VMzx
         yk3FyBRhyFPk0HEFLuB/6TIw7cf/5fJRih6NVvB8cRJ8jz5vNhPLkwCewcaRyXmfMSwF
         COKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702568742; x=1703173542;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8j17breL6WEUj0nx93dJmKLMKyc/s1T6rwIZki2ItPA=;
        b=FG7WKWxcyLi/e/P264BoZvh/wnqZYDtCG5Xjjpnp5eMJLUI4GIAG/xy26+Sih5jSi3
         JcEvmMvGMzQ1Tk8oq/mthFUCXc3jV8AuSWmWoVtLjabMmXzGJ7cyANRJA0K6PSWSOkVs
         PRCb1TkuBvFEeCbfpnH7R92jShDA5gDasc6QqxV1RoCS7wIJsfEtwJikBZD7sDttCX9f
         KlHGvuG5GFhvB1d5DgUYVP4U5OXai/hEaj3ff8xkseaHzq4t5SwaSkSjA2gyPzVt4/cA
         Oyhh3f4Waas7XwKm+xZeP/cja9ANzKYQ6Q7wv47ikZz6E6VlKyUZp45J/C6fst30gdo0
         7BDA==
X-Gm-Message-State: AOJu0YxPd1fktwEzFXghKFSX59ZjvkP0pbPzEBXi5qejM5w3OQ6Bsr8M
	E7DFp0t+/bpNKIR+LCf8gqBQbx1VLo0Aqkj8yXc=
X-Google-Smtp-Source: AGHT+IFQ+2yxdkrucguSOklqg66LOdViszdY/eXmcXIH/gyFty8kvFCWpTUL/1ltylbhox4Vht9PHw==
X-Received: by 2002:a05:6a20:3ca7:b0:18f:97c:8a27 with SMTP id b39-20020a056a203ca700b0018f097c8a27mr12055697pzj.82.1702568741506;
        Thu, 14 Dec 2023 07:45:41 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x3-20020a056a000bc300b006cea17d08ebsm11934398pfu.120.2023.12.14.07.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 07:45:40 -0800 (PST)
Message-ID: <657b2324.050a0220.666bb.56a5@mx.google.com>
Date: Thu, 14 Dec 2023 07:45:40 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-69-g8f7b450fc28ed
Subject: cip/linux-5.10.y-cip baseline: 107 runs,
 18 regressions (v5.10.201-cip41-69-g8f7b450fc28ed)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Dec 2023 15:45:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14112

cip/linux-5.10.y-cip baseline: 107 runs, 18 regressions (v5.10.201-cip41-69=
-g8f7b450fc28ed)

Regressions Summary
-------------------

platform                 | arch  | lab             | compiler | defconfig  =
         | regressions
-------------------------+-------+-----------------+----------+------------=
---------+------------
at91sam9g20ek            | arm   | lab-broonie     | gcc-10   | multi_v5_de=
fconfig  | 1          =

bcm2836-rpi-2-b          | arm   | lab-collabora   | gcc-10   | bcm2835_def=
config   | 1          =

beaglebone-black         | arm   | lab-cip         | gcc-10   | multi_v7_de=
fconfig  | 1          =

beaglebone-black         | arm   | lab-broonie     | gcc-10   | omap2plus_d=
efconfig | 1          =

imx6q-sabrelite          | arm   | lab-collabora   | gcc-10   | multi_v7_de=
fconfig  | 1          =

imx6qp-wandboard-revd1   | arm   | lab-pengutronix | gcc-10   | imx_v6_v7_d=
efconfig | 1          =

imx6qp-wandboard-revd1   | arm   | lab-pengutronix | gcc-10   | multi_v7_de=
fconfig  | 1          =

r8a7743-iwg20d-q7        | arm   | lab-cip         | gcc-10   | shmobile_de=
fconfig  | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip         | gcc-10   | defconfig+k=
selftest | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip         | gcc-10   | defconfig  =
         | 1          =

r8a774c0-ek874           | arm64 | lab-cip         | gcc-10   | defconfig  =
         | 1          =

r8a77960-ulcb            | arm64 | lab-collabora   | gcc-10   | defconfig  =
         | 1          =

rk3288-veyron-jaq        | arm   | lab-collabora   | gcc-10   | multi_v7_de=
fconfig  | 4          =

rk3399-rock-pi-4b        | arm64 | lab-collabora   | gcc-10   | defconfig  =
         | 1          =

sun50i-h6-pine-h64       | arm64 | lab-collabora   | gcc-10   | defconfig  =
         | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-69-g8f7b450fc28ed/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-69-g8f7b450fc28ed
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      8f7b450fc28ed99196853536c98ae36c2567e160 =



Test Regressions
---------------- =



platform                 | arch  | lab             | compiler | defconfig  =
         | regressions
-------------------------+-------+-----------------+----------+------------=
---------+------------
at91sam9g20ek            | arm   | lab-broonie     | gcc-10   | multi_v5_de=
fconfig  | 1          =


  Details:     https://kernelci.org/test/plan/id/657b2208e3835c4a22e134d3

  Results:     47 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline=
-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline=
-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657b2208e3835c4a22e13506
        failing since 334 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-14T15:40:23.373596  + set +x
    2023-12-14T15:40:23.374109  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 354267_1.5.2=
.4.1>
    2023-12-14T15:40:23.487786  / # #
    2023-12-14T15:40:23.590956  export SHELL=3D/bin/sh
    2023-12-14T15:40:23.591793  #
    2023-12-14T15:40:23.693798  / # export SHELL=3D/bin/sh. /lava-354267/en=
vironment
    2023-12-14T15:40:23.694619  =

    2023-12-14T15:40:23.796682  / # . /lava-354267/environment/lava-354267/=
bin/lava-test-runner /lava-354267/1
    2023-12-14T15:40:23.798123  =

    2023-12-14T15:40:23.801655  / # /lava-354267/bin/lava-test-runner /lava=
-354267/1 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
         | regressions
-------------------------+-------+-----------------+----------+------------=
---------+------------
bcm2836-rpi-2-b          | arm   | lab-collabora   | gcc-10   | bcm2835_def=
config   | 1          =


  Details:     https://kernelci.org/test/plan/id/657b19a87e08862f10e13475

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm/bcm2835_defconfig/gcc-10/lab-collabora/baselin=
e-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm/bcm2835_defconfig/gcc-10/lab-collabora/baselin=
e-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657b19a87e08862f10e1347a
        failing since 141 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-12-14T15:12:24.980057  / # #

    2023-12-14T15:12:25.081178  export SHELL=3D/bin/sh

    2023-12-14T15:12:25.081858  #

    2023-12-14T15:12:25.183066  / # export SHELL=3D/bin/sh. /lava-12271898/=
environment

    2023-12-14T15:12:25.183765  =


    2023-12-14T15:12:25.285052  / # . /lava-12271898/environment/lava-12271=
898/bin/lava-test-runner /lava-12271898/1

    2023-12-14T15:12:25.285360  =


    2023-12-14T15:12:25.288141  / # /lava-12271898/bin/lava-test-runner /la=
va-12271898/1

    2023-12-14T15:12:25.405205  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-14T15:12:25.405414  + cd /lava-12271898/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
         | regressions
-------------------------+-------+-----------------+----------+------------=
---------+------------
beaglebone-black         | arm   | lab-cip         | gcc-10   | multi_v7_de=
fconfig  | 1          =


  Details:     https://kernelci.org/test/plan/id/657b1d7d1deff53847e13492

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-bea=
glebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-bea=
glebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657b1d7d1deff53847e134b9
        failing since 334 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-14T15:20:45.952141  <8>[   16.719837] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1059356_1.5.2.4.1>
    2023-12-14T15:20:46.059091  / # #
    2023-12-14T15:20:46.160490  export SHELL=3D/bin/sh
    2023-12-14T15:20:46.160929  #
    2023-12-14T15:20:46.261835  / # export SHELL=3D/bin/sh. /lava-1059356/e=
nvironment
    2023-12-14T15:20:46.262275  =

    2023-12-14T15:20:46.363194  / # . /lava-1059356/environment/lava-105935=
6/bin/lava-test-runner /lava-1059356/1
    2023-12-14T15:20:46.363922  =

    2023-12-14T15:20:46.367996  / # /lava-1059356/bin/lava-test-runner /lav=
a-1059356/1
    2023-12-14T15:20:46.460710  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
         | regressions
-------------------------+-------+-----------------+----------+------------=
---------+------------
beaglebone-black         | arm   | lab-broonie     | gcc-10   | omap2plus_d=
efconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/657b2215961c85151fe13479

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm/omap2plus_defconfig/gcc-10/lab-broonie/baselin=
e-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm/omap2plus_defconfig/gcc-10/lab-broonie/baselin=
e-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657b2215961c85151fe134ae
        failing since 334 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-14T15:40:51.483101  <8>[   20.199499] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 354374_1.5.2.4.1>
    2023-12-14T15:40:51.591913  / # #
    2023-12-14T15:40:51.693772  export SHELL=3D/bin/sh
    2023-12-14T15:40:51.694421  #
    2023-12-14T15:40:51.796022  / # export SHELL=3D/bin/sh. /lava-354374/en=
vironment
    2023-12-14T15:40:51.796538  =

    2023-12-14T15:40:51.898086  / # . /lava-354374/environment/lava-354374/=
bin/lava-test-runner /lava-354374/1
    2023-12-14T15:40:51.898839  =

    2023-12-14T15:40:51.902967  / # /lava-354374/bin/lava-test-runner /lava=
-354374/1
    2023-12-14T15:40:52.012534  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
         | regressions
-------------------------+-------+-----------------+----------+------------=
---------+------------
imx6q-sabrelite          | arm   | lab-collabora   | gcc-10   | multi_v7_de=
fconfig  | 1          =


  Details:     https://kernelci.org/test/plan/id/657b19d06e6efeca14e134b1

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657b19d06e6efeca14e134b6
        failing since 334 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-14T15:05:44.966941  / # #

    2023-12-14T15:05:45.069322  export SHELL=3D/bin/sh

    2023-12-14T15:05:45.070105  #

    2023-12-14T15:05:45.171691  / # export SHELL=3D/bin/sh. /lava-12271975/=
environment

    2023-12-14T15:05:45.172474  =


    2023-12-14T15:05:45.274213  / # . /lava-12271975/environment/lava-12271=
975/bin/lava-test-runner /lava-12271975/1

    2023-12-14T15:05:45.275504  =


    2023-12-14T15:05:45.292495  / # /lava-12271975/bin/lava-test-runner /la=
va-12271975/1

    2023-12-14T15:05:45.402042  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-14T15:05:45.402611  + cd /lava-12271975/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
         | regressions
-------------------------+-------+-----------------+----------+------------=
---------+------------
imx6qp-wandboard-revd1   | arm   | lab-pengutronix | gcc-10   | imx_v6_v7_d=
efconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/657b16e7d58c8cd59fe1349c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/bas=
eline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/bas=
eline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657b16e7d58c8cd59fe134a1
        failing since 334 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-14T14:53:20.393144  + set +x
    2023-12-14T14:53:20.393297  [   10.291633] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1017476_1.5.2.3.1>
    2023-12-14T14:53:20.500408  / # #
    2023-12-14T14:53:20.601484  export SHELL=3D/bin/sh
    2023-12-14T14:53:20.601955  #
    2023-12-14T14:53:20.702701  / # export SHELL=3D/bin/sh. /lava-1017476/e=
nvironment
    2023-12-14T14:53:20.703380  =

    2023-12-14T14:53:20.804471  / # . /lava-1017476/environment/lava-101747=
6/bin/lava-test-runner /lava-1017476/1
    2023-12-14T14:53:20.804966  =

    2023-12-14T14:53:20.807965  / # /lava-1017476/bin/lava-test-runner /lav=
a-1017476/1 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
         | regressions
-------------------------+-------+-----------------+----------+------------=
---------+------------
imx6qp-wandboard-revd1   | arm   | lab-pengutronix | gcc-10   | multi_v7_de=
fconfig  | 1          =


  Details:     https://kernelci.org/test/plan/id/657b19b7d50b015947e134d0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/base=
line-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/base=
line-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657b19b7d50b015947e134d5
        failing since 334 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-14T15:05:06.992378  + set[    7.298705] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 1017477_1.5.2.3.1>
    2023-12-14T15:05:06.992559   +x
    2023-12-14T15:05:07.097733  / # #
    2023-12-14T15:05:07.199005  export SHELL=3D/bin/sh
    2023-12-14T15:05:07.199481  #
    2023-12-14T15:05:07.300345  / # export SHELL=3D/bin/sh. /lava-1017477/e=
nvironment
    2023-12-14T15:05:07.300848  =

    2023-12-14T15:05:07.401735  / # . /lava-1017477/environment/lava-101747=
7/bin/lava-test-runner /lava-1017477/1
    2023-12-14T15:05:07.402406  =

    2023-12-14T15:05:07.404619  / # /lava-1017477/bin/lava-test-runner /lav=
a-1017477/1 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
         | regressions
-------------------------+-------+-----------------+----------+------------=
---------+------------
r8a7743-iwg20d-q7        | arm   | lab-cip         | gcc-10   | shmobile_de=
fconfig  | 1          =


  Details:     https://kernelci.org/test/plan/id/657b19e08f1d74df70e13478

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a=
7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a=
7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/657b19e08f1d74df70e13=
479
        failing since 6 days (last pass: v5.10.201-cip41-16-g3c85fba3b6e5d,=
 first fail: v5.10.201-cip41-28-ga386bc478aa6b) =

 =



platform                 | arch  | lab             | compiler | defconfig  =
         | regressions
-------------------------+-------+-----------------+----------+------------=
---------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip         | gcc-10   | defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/657b193d7f7ad21445e13475

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-=
r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-=
r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657b193d7f7ad21445e1347a
        failing since 127 days (last pass: v5.10.182-cip35, first fail: v5.=
10.186-cip37-13-g260094841fe1a)

    2023-12-14T15:02:58.435584  + set +x
    2023-12-14T15:02:58.438695  <8>[   87.699282] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1059348_1.5.2.4.1>
    2023-12-14T15:02:58.549702  / # #
    2023-12-14T15:03:00.005975  export SHELL=3D/bin/sh
    2023-12-14T15:03:00.026613  #
    2023-12-14T15:03:00.026860  / # export SHELL=3D/bin/sh
    2023-12-14T15:03:01.973334  / # . /lava-1059348/environment
    2023-12-14T15:03:05.555438  /lava-1059348/bin/lava-test-runner /lava-10=
59348/1
    2023-12-14T15:03:05.576459  . /lava-1059348/environment
    2023-12-14T15:03:05.576669  / # /lava-1059348/bin/lava-test-runner /lav=
a-1059348/1 =

    ... (27 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
         | regressions
-------------------------+-------+-----------------+----------+------------=
---------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip         | gcc-10   | defconfig  =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/657b1caff0425c6653e1347f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774a1-h=
ihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774a1-h=
ihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657b1caff0425c6653e13484
        failing since 127 days (last pass: v5.10.182-cip35-1-g7cde3fba93966=
, first fail: v5.10.186-cip37-13-g260094841fe1a)

    2023-12-14T15:17:33.769448  + set +x
    2023-12-14T15:17:33.772655  <8>[   83.969304] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1059389_1.5.2.4.1>
    2023-12-14T15:17:33.879153  / # #
    2023-12-14T15:17:35.334791  export SHELL=3D/bin/sh
    2023-12-14T15:17:35.355431  #
    2023-12-14T15:17:35.355774  / # export SHELL=3D/bin/sh
    2023-12-14T15:17:37.302870  / # . /lava-1059389/environment
    2023-12-14T15:17:40.885804  /lava-1059389/bin/lava-test-runner /lava-10=
59389/1
    2023-12-14T15:17:40.907069  . /lava-1059389/environment
    2023-12-14T15:17:40.907467  / # /lava-1059389/bin/lava-test-runner /lav=
a-1059389/1 =

    ... (28 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
         | regressions
-------------------------+-------+-----------------+----------+------------=
---------+------------
r8a774c0-ek874           | arm64 | lab-cip         | gcc-10   | defconfig  =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/657b1c834b6f8eab81e134be

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-e=
k874.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-e=
k874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657b1c834b6f8eab81e134c3
        failing since 141 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-12-14T15:17:10.839195  / # #
    2023-12-14T15:17:12.298134  export SHELL=3D/bin/sh
    2023-12-14T15:17:12.319154  #
    2023-12-14T15:17:12.319671  / # export SHELL=3D/bin/sh
    2023-12-14T15:17:14.271021  / # . /lava-1059393/environment
    2023-12-14T15:17:17.862700  /lava-1059393/bin/lava-test-runner /lava-10=
59393/1
    2023-12-14T15:17:17.884318  . /lava-1059393/environment
    2023-12-14T15:17:17.884692  / # /lava-1059393/bin/lava-test-runner /lav=
a-1059393/1
    2023-12-14T15:17:17.962940  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-14T15:17:17.963455  + cd /lava-1059393/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
         | regressions
-------------------------+-------+-----------------+----------+------------=
---------+------------
r8a77960-ulcb            | arm64 | lab-collabora   | gcc-10   | defconfig  =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/657b1a9897a12e895be13475

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a7=
7960-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a7=
7960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657b1a9897a12e895be1347a
        failing since 141 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-12-14T15:16:34.684915  / # #

    2023-12-14T15:16:34.786844  export SHELL=3D/bin/sh

    2023-12-14T15:16:34.787543  #

    2023-12-14T15:16:34.888898  / # export SHELL=3D/bin/sh. /lava-12272029/=
environment

    2023-12-14T15:16:34.889571  =


    2023-12-14T15:16:34.990948  / # . /lava-12272029/environment/lava-12272=
029/bin/lava-test-runner /lava-12272029/1

    2023-12-14T15:16:34.992010  =


    2023-12-14T15:16:35.008816  / # /lava-12272029/bin/lava-test-runner /la=
va-12272029/1

    2023-12-14T15:16:35.057784  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-14T15:16:35.058252  + cd /lav<8>[   16.402446] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12272029_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
         | regressions
-------------------------+-------+-----------------+----------+------------=
---------+------------
rk3288-veyron-jaq        | arm   | lab-collabora   | gcc-10   | multi_v7_de=
fconfig  | 4          =


  Details:     https://kernelci.org/test/plan/id/657b19cfd5a78729eee1347a

  Results:     63 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-i2c-present: https://kernelci.or=
g/test/case/id/657b19cfd5a78729eee1349b
        failing since 332 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-14T15:13:09.428236  FIRST,<8>[   18.933887] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>

    2023-12-14T15:13:09.429910   INC default to 1.

    2023-12-14T15:13:09.430292  =


    2023-12-14T15:13:09.433926  	-w	Pad to last with leading zeros

    2023-12-14T15:13:09.436245  	-s SEP	String separator

    2023-12-14T15:13:09.440083  /lava-12271981/1/../bin/lava-test-case

    2023-12-14T15:13:09.445959  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.

    2023-12-14T15:13:09.446360  =

   =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/657b19cfd5a78729eee1349c
        failing since 332 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-14T15:13:09.405834  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC)<8=
>[   18.914976] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-12-14T15:13:09.407671   multi-call binary.

    2023-12-14T15:13:09.407733  =


    2023-12-14T15:13:09.412268  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-12-14T15:13:09.412495  =


    2023-12-14T15:13:09.417526  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/657b19cfd5a78729eee1349d
        failing since 332 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-14T15:13:09.387022  <8>[   18.897028] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657b19cfd5a78729eee134b4
        failing since 332 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-14T15:12:57.323331  <8>[    6.833496] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-12-14T15:12:57.333030  + <8>[    6.845990] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 12271981_1.5.2.3.1>

    2023-12-14T15:12:57.333497  set +x

    2023-12-14T15:12:57.440060  =


    2023-12-14T15:12:57.541652  / # #export SHELL=3D/bin/sh

    2023-12-14T15:12:57.542349  =


    2023-12-14T15:12:57.643733  / # export SHELL=3D/bin/sh. /lava-12271981/=
environment

    2023-12-14T15:12:57.644467  =


    2023-12-14T15:12:57.745823  / # . /lava-12271981/environment/lava-12271=
981/bin/lava-test-runner /lava-12271981/1

    2023-12-14T15:12:57.746880  =

 =

    ... (19 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
         | regressions
-------------------------+-------+-----------------+----------+------------=
---------+------------
rk3399-rock-pi-4b        | arm64 | lab-collabora   | gcc-10   | defconfig  =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/657b1ad548a6e0b8b0e134eb

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm64/defconfig/gcc-10/lab-collabora/baseline-rk33=
99-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm64/defconfig/gcc-10/lab-collabora/baseline-rk33=
99-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657b1ad548a6e0b8b0e134f0
        failing since 86 days (last pass: v5.10.191-cip38-29-g9e1aa2001db8,=
 first fail: v5.10.194-cip39)

    2023-12-14T15:14:28.391022  / # #

    2023-12-14T15:14:29.652374  export SHELL=3D/bin/sh

    2023-12-14T15:14:29.663406  #

    2023-12-14T15:14:29.663879  / # export SHELL=3D/bin/sh

    2023-12-14T15:14:31.408271  / # . /lava-12272023/environment

    2023-12-14T15:14:34.614351  /lava-12272023/bin/lava-test-runner /lava-1=
2272023/1

    2023-12-14T15:14:34.625837  . /lava-12272023/environment

    2023-12-14T15:14:34.626174  / # /lava-12272023/bin/lava-test-runner /la=
va-12272023/1

    2023-12-14T15:14:34.681683  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-14T15:14:34.682149  + cd /lava-12272023/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
         | regressions
-------------------------+-------+-----------------+----------+------------=
---------+------------
sun50i-h6-pine-h64       | arm64 | lab-collabora   | gcc-10   | defconfig  =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/657b1aaba590fbabb0e13518

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm64/defconfig/gcc-10/lab-collabora/baseline-sun5=
0i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm64/defconfig/gcc-10/lab-collabora/baseline-sun5=
0i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657b1aaba590fbabb0e1351d
        failing since 141 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-12-14T15:16:52.509966  / # #

    2023-12-14T15:16:52.611921  export SHELL=3D/bin/sh

    2023-12-14T15:16:52.612727  #

    2023-12-14T15:16:52.714183  / # export SHELL=3D/bin/sh. /lava-12272024/=
environment

    2023-12-14T15:16:52.714869  =


    2023-12-14T15:16:52.816271  / # . /lava-12272024/environment/lava-12272=
024/bin/lava-test-runner /lava-12272024/1

    2023-12-14T15:16:52.817370  =


    2023-12-14T15:16:52.834159  / # /lava-12272024/bin/lava-test-runner /la=
va-12272024/1

    2023-12-14T15:16:52.880864  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-14T15:16:52.893278  + cd /lava-1227202<8>[   18.227840] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12272024_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

