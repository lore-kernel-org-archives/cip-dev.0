Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817DDC48260
	for <webhook@archiver.kernel.org>; Tue,  6 Feb 2024 02:40:12 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web11.13347.1707187208912313818
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Feb 2024 18:40:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=lq6Nt1ed;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.180, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d99c5f6bfeso911605ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Feb 2024 18:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707187208; x=1707792008; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8t1tkf+NcYNXcKF4VTUOz5pLK1XPlStczhXLaucq5cY=;
        b=lq6Nt1edFhrQXzoY1zCbHaRHWDgFNxrZbPRh2QQAFNZGfvC9HgFKzP8kEnEs7gt/+D
         m/CcUGO8o/M7WgZT/W+cKx7EkkhydOfkzQ2bdmJ0RsuHX/CNWqNkoxSpPVRTArnS8iYL
         pagfpAqji30WQQ5ku3kzy0tFGsRDESkhcUtGvbVZe9ker64kU1Ic3MelhLEkkWrkT1nm
         ofAbFXIR+TH1DqeqO5ad5DB2HPIMsK/7RtpHLWsfTxkQmJHXnjeTEnXu52OcFDk1lWDt
         jGTLcoIPL4rA0I1cXtKHVC2tMrqo9DxRIc2EQ3caa3Cq9KN8ComuEp7H2HimUzGLSzEE
         52hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707187208; x=1707792008;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8t1tkf+NcYNXcKF4VTUOz5pLK1XPlStczhXLaucq5cY=;
        b=FWm3S5FZ/WaijVuwpUnRI8qjDygycb2409YojjTjTI7LTn/PUF8LeeygvdhZQ+XD4J
         1c3oHadfxl+zE6AJGVvKrRYcWbtBtzxsWaaflqn9kshlJehgitPVMPppDVWwm089NqPW
         7A2V7vRT+lxIXlOSW+F6D/5/JkCSxS7q5vhuWGBEooorU1Tt/yTEtjfRDXsEXxfIaGQ9
         KLDq9ksHU3q/IiQOwYDqx/n2G4wJAki7pJh0fwmx8yPjxNUwsjHLEuOvsgumgl7xniqE
         PhM4QY9+fhgwPiWKYc01sDs8aX1PW6ugb8LPQKFip/mbXC5fKj113KOSNUZrCy3ZJXCU
         klNA==
X-Gm-Message-State: AOJu0YzjW+6bf/lp3xBI4v09SLU33cHtBru+wJDNwzc6eJJd2J3MdRlu
	AZMaQTI8OW+0humVKMVWA56TxvozYcaZeTQUq8/WLbExfBy+g1mKFTMjGYtVP/6gZBPqtsrU9Ie
	O
X-Google-Smtp-Source: AGHT+IFxFZvtoX12GuP+bDTtWYxgCUlnfSz1PVoOruhpNKwk0Dmrx9qnHpOhvzgaP0zU9surIG556Q==
X-Received: by 2002:a17:902:ea0b:b0:1d9:5ef2:a562 with SMTP id s11-20020a170902ea0b00b001d95ef2a562mr554477plg.10.1707187207531;
        Mon, 05 Feb 2024 18:40:07 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWJl0ArYDTTqHq99gydIxymTDR3doU39+LfBxF/E9DpZQKs+ZobFuOLCP/mFHjiP+GuJbQ+AIVQunME34O4k/TQZP/4me16K+2HynoS6nti3ajc5z6YoLMi5yRLZ1Y8Wv4tuOlrCqo3o7hFHkIZv3daEQ==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jy3-20020a17090342c300b001d9ba397ec7sm598489plb.286.2024.02.05.18.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 18:40:06 -0800 (PST)
Message-ID: <65c19c06.170a0220.50e32.353e@mx.google.com>
Date: Mon, 05 Feb 2024 18:40:06 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Kernel: v5.10.209-cip44-rt18
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip-rt baseline: 183 runs,
 25 regressions (v5.10.209-cip44-rt18)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Feb 2024 02:40:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14768

cip/linux-5.10.y-cip-rt baseline: 183 runs, 25 regressions (v5.10.209-cip44=
-rt18)

Regressions Summary
-------------------

platform               | arch  | lab             | compiler | defconfig    =
        | regressions
-----------------------+-------+-----------------+----------+--------------=
--------+------------
at91sam9g20ek          | arm   | lab-broonie     | gcc-10   | at91_dt_defco=
nfig    | 2          =

bcm2836-rpi-2-b        | arm   | lab-collabora   | gcc-10   | bcm2835_defco=
nfig    | 1          =

beaglebone-black       | arm   | lab-broonie     | gcc-10   | defconfig    =
        | 1          =

beaglebone-black       | arm   | lab-cip         | gcc-10   | defconfig    =
        | 1          =

beaglebone-black       | arm   | lab-broonie     | gcc-10   | multi_v7_defc=
onfig   | 1          =

beaglebone-black       | arm   | lab-cip         | gcc-10   | multi_v7_defc=
onfig   | 1          =

beaglebone-black       | arm   | lab-broonie     | gcc-10   | omap2plus_def=
config  | 1          =

beaglebone-black       | arm   | lab-cip         | gcc-10   | omap2plus_def=
config  | 1          =

imx6q-sabrelite        | arm   | lab-collabora   | gcc-10   | multi_v7_defc=
onfig   | 1          =

imx6qp-wandboard-revd1 | arm   | lab-pengutronix | gcc-10   | defconfig    =
        | 1          =

imx6qp-wandboard-revd1 | arm   | lab-pengutronix | gcc-10   | imx_v6_v7_def=
config  | 1          =

imx6qp-wandboard-revd1 | arm   | lab-pengutronix | gcc-10   | multi_v7_defc=
onfig   | 1          =

juno-uboot             | arm64 | lab-broonie     | gcc-10   | defconfig+pre=
empt_rt | 1          =

juno-uboot             | arm64 | lab-broonie     | gcc-10   | defconfig    =
        | 1          =

r8a7743-iwg20d-q7      | arm   | lab-cip         | gcc-10   | shmobile_defc=
onfig   | 1          =

r8a774c0-ek874         | arm64 | lab-cip         | gcc-10   | defconfig    =
        | 1          =

rk3288-veyron-jaq      | arm   | lab-collabora   | gcc-10   | multi_v7_defc=
onfig   | 4          =

rk3399-rock-pi-4b      | arm64 | lab-collabora   | gcc-10   | defconfig+pre=
empt_rt | 1          =

rk3399-rock-pi-4b      | arm64 | lab-collabora   | gcc-10   | defconfig    =
        | 1          =

sun50i-a64-pine64-plus | arm64 | lab-broonie     | gcc-10   | defconfig+pre=
empt_rt | 1          =

sun50i-a64-pine64-plus | arm64 | lab-broonie     | gcc-10   | defconfig    =
        | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.209-cip44-rt18/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.209-cip44-rt18
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      d814befd12dcf6c81b483cb36f507d70112c1097 =



Test Regressions
---------------- =



platform               | arch  | lab             | compiler | defconfig    =
        | regressions
-----------------------+-------+-----------------+----------+--------------=
--------+------------
at91sam9g20ek          | arm   | lab-broonie     | gcc-10   | at91_dt_defco=
nfig    | 2          =


  Details:     https://kernelci.org/test/plan/id/65c18dcadfb9b4eec200a03e

  Results:     47 PASS, 6 FAIL, 1 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm/at91_dt_defconfig/gcc-10/lab-broonie/baseline-at91sam9g2=
0ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm/at91_dt_defconfig/gcc-10/lab-broonie/baseline-at91sam9g2=
0ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/65c18dcbd=
fb9b4eec200a04d
        new failure (last pass: v5.10.201-cip41-rt17)

    2024-02-06T01:39:02.038344  /lava-547182/1/../bin/lava-test-case
    2024-02-06T01:39:02.078296  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dsou=
nd-card RESULT=3Dfail>   =


  * baseline.bootrr.audio-card-probed: https://kernelci.org/test/case/id/65=
c18dcbdfb9b4eec200a04e
        new failure (last pass: v5.10.201-cip41-rt17)

    2024-02-06T01:39:00.936837  /lava-547182/1/../bin/lava-test-case
    2024-02-06T01:39:00.976966  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Daud=
io-card-probed RESULT=3Dfail>   =

 =



platform               | arch  | lab             | compiler | defconfig    =
        | regressions
-----------------------+-------+-----------------+----------+--------------=
--------+------------
bcm2836-rpi-2-b        | arm   | lab-collabora   | gcc-10   | bcm2835_defco=
nfig    | 1          =


  Details:     https://kernelci.org/test/plan/id/65c18e0d171919515b00a08c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm/bcm2835_defconfig/gcc-10/lab-collabora/baseline-bcm2836-=
rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm/bcm2835_defconfig/gcc-10/lab-collabora/baseline-bcm2836-=
rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c18e0d171919515b00a095
        failing since 139 days (last pass: v5.10.184-cip36-rt14, first fail=
: v5.10.194-cip39-rt16)

    2024-02-06T01:47:49.409657  #

    2024-02-06T01:47:49.511708  export SHELL=3D/bin/sh

    2024-02-06T01:47:49.512467  #

    2024-02-06T01:47:49.613896  / # export SHELL=3D/bin/sh. /lava-12705305/=
environment

    2024-02-06T01:47:49.614629  =


    2024-02-06T01:47:49.716095  / # . /lava-12705305/environment/lava-12705=
305/bin/lava-test-runner /lava-12705305/1

    2024-02-06T01:47:49.717258  =


    2024-02-06T01:47:49.719010  / # /lava-12705305/bin/lava-test-runner /la=
va-12705305/1

    2024-02-06T01:47:49.798947  + export 'TESTRUN_ID=3D1_bootrr'

    2024-02-06T01:47:49.842878  + cd /lava-12705305/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform               | arch  | lab             | compiler | defconfig    =
        | regressions
-----------------------+-------+-----------------+----------+--------------=
--------+------------
beaglebone-black       | arm   | lab-broonie     | gcc-10   | defconfig    =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/65c1949ff1c819a0e100a065

  Results:     30 PASS, 15 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm/defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm/defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c1949ff1c819a0e100a094
        failing since 375 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2024-02-06T02:08:00.659955  + set +x
    2024-02-06T02:08:00.763780  / # <8>[   22.034371] <LAVA_S#
    2024-02-06T02:08:00.865891  export SHELL=3D/bin/sh
    2024-02-06T02:08:00.866537  IGNAL_TESTCASE TEST_CASE_ID=3Demerg RESULT=
=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2024-02-06T02:08:00.866758  <8>[   22.036274] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 547296_1.5.2.4.1>
    2024-02-06T02:08:00.866939  #
    2024-02-06T02:08:00.968504  / # export SHELL=3D/bin/sh. /lava-547296/en=
vironment
    2024-02-06T02:08:00.969024  =

    2024-02-06T02:08:01.070598  / # . /lava-547296/environment/lava-547296/=
bin/lava-test-runner /lava-547296/1
    2024-02-06T02:08:01.071382   =

    ... (13 line(s) more)  =

 =



platform               | arch  | lab             | compiler | defconfig    =
        | regressions
-----------------------+-------+-----------------+----------+--------------=
--------+------------
beaglebone-black       | arm   | lab-cip         | gcc-10   | defconfig    =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/65c1986d9c2625678700a041

  Results:     30 PASS, 15 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm/defconfig/gcc-10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm/defconfig/gcc-10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c1986d9c2625678700a071
        failing since 375 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2024-02-06T02:24:14.929444  + set +x
    2024-02-06T02:24:15.035123  / # #
    2024-02-06T02:24:15.137226  export SHELL=3D/bin/sh
    2024-02-06T02:24:15.137872  <8>[   15.779924] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2024-02-06T02:24:15.138248  <8>[   15.781846] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1089091_1.5.2.4.1>
    2024-02-06T02:24:15.138599  #
    2024-02-06T02:24:15.239923  / # export SHELL=3D/bin/sh. /lava-1089091/e=
nvironment
    2024-02-06T02:24:15.240574  =

    2024-02-06T02:24:15.341957  / # . /lava-1089091/environment/lava-108909=
1/bin/lava-test-runner /lava-1089091/1
    2024-02-06T02:24:15.343012   =

    ... (13 line(s) more)  =

 =



platform               | arch  | lab             | compiler | defconfig    =
        | regressions
-----------------------+-------+-----------------+----------+--------------=
--------+------------
beaglebone-black       | arm   | lab-broonie     | gcc-10   | multi_v7_defc=
onfig   | 1          =


  Details:     https://kernelci.org/test/plan/id/65c1935ed6e5228d2900a089

  Results:     30 PASS, 14 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebon=
e-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebon=
e-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c1935ed6e5228d2900a0b6
        failing since 375 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2024-02-06T02:02:22.843699  + set +x
    2024-02-06T02:02:22.948100  / # <8>[   21.953310] <LAVA_S#
    2024-02-06T02:02:23.050193  export SHELL=3D/bin/sh
    2024-02-06T02:02:23.050852  IGNAL_TESTCASE TEST_CASE_ID=3Demerg RESULT=
=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2024-02-06T02:02:23.051069  <8>[   21.955131] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 547257_1.5.2.4.1>
    2024-02-06T02:02:23.051237  #
    2024-02-06T02:02:23.153046  / # export SHELL=3D/bin/sh. /lava-547257/en=
vironment
    2024-02-06T02:02:23.153691  =

    2024-02-06T02:02:23.255666  / # . /lava-547257/environment/lava-547257/=
bin/lava-test-runner /lava-547257/1
    2024-02-06T02:02:23.256544   =

    ... (13 line(s) more)  =

 =



platform               | arch  | lab             | compiler | defconfig    =
        | regressions
-----------------------+-------+-----------------+----------+--------------=
--------+------------
beaglebone-black       | arm   | lab-cip         | gcc-10   | multi_v7_defc=
onfig   | 1          =


  Details:     https://kernelci.org/test/plan/id/65c196adc28386f11700a056

  Results:     30 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beaglebone-bl=
ack.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beaglebone-bl=
ack.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c196adc28386f11700a084
        failing since 375 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2024-02-06T02:16:31.910998  + set +x
    2024-02-06T02:16:32.015016  / # #
    2024-02-06T02:16:32.116352  export SHELL=3D/bin/sh
    2024-02-06T02:16:32.116782  <8>[   16.631274] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2024-02-06T02:16:32.117015  <8>[   16.633127] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1089073_1.5.2.4.1>
    2024-02-06T02:16:32.117232  #
    2024-02-06T02:16:32.218141  / # export SHELL=3D/bin/sh. /lava-1089073/e=
nvironment
    2024-02-06T02:16:32.218571  =

    2024-02-06T02:16:32.319493  / # . /lava-1089073/environment/lava-108907=
3/bin/lava-test-runner /lava-1089073/1
    2024-02-06T02:16:32.320175   =

    ... (13 line(s) more)  =

 =



platform               | arch  | lab             | compiler | defconfig    =
        | regressions
-----------------------+-------+-----------------+----------+--------------=
--------+------------
beaglebone-black       | arm   | lab-broonie     | gcc-10   | omap2plus_def=
config  | 1          =


  Details:     https://kernelci.org/test/plan/id/65c1928db70a64156e00a039

  Results:     50 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beaglebo=
ne-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beaglebo=
ne-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c1928eb70a64156e00a06d
        failing since 320 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.175-cip29-rt12)

    2024-02-06T01:59:29.165614  + set +x
    2024-02-06T01:59:29.270572  TESTCASE TEST_CASE_ID=3Demerg RESULT=3Dpass=
 UNITS=3Dlines MEASUREMENT=3D0>
    2024-02-06T01:59:29.270755  =

    2024-02-06T01:59:29.270917  / # <8>[   19.853509] <LAVA_SIGNAL_ENDRUN 0=
_dmesg 547239_1.5.2.4.1>
    2024-02-06T01:59:29.372888  #export SHELL=3D/bin/sh
    2024-02-06T01:59:29.373516  =

    2024-02-06T01:59:29.475411  / # export SHELL=3D/bin/sh. /lava-547239/en=
vironment
    2024-02-06T01:59:29.476077  =

    2024-02-06T01:59:29.577911  / # . /lava-547239/environment/lava-547239/=
bin/lava-test-runner /lava-547239/1
    2024-02-06T01:59:29.578767   =

    ... (13 line(s) more)  =

 =



platform               | arch  | lab             | compiler | defconfig    =
        | regressions
-----------------------+-------+-----------------+----------+--------------=
--------+------------
beaglebone-black       | arm   | lab-cip         | gcc-10   | omap2plus_def=
config  | 1          =


  Details:     https://kernelci.org/test/plan/id/65c194fd332dbdaacc00a048

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beaglebone-b=
lack.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beaglebone-b=
lack.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c194fd332dbdaacc00a07c
        failing since 320 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.175-cip29-rt12)

    2024-02-06T02:09:49.510431  <8>[   13.374305] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1089068_1.5.2.4.1>
    2024-02-06T02:09:49.617873  / # #
    2024-02-06T02:09:49.719741  export SHELL=3D/bin/sh
    2024-02-06T02:09:49.720381  #
    2024-02-06T02:09:49.821608  / # export SHELL=3D/bin/sh. /lava-1089068/e=
nvironment
    2024-02-06T02:09:49.822246  =

    2024-02-06T02:09:49.923380  / # . /lava-1089068/environment/lava-108906=
8/bin/lava-test-runner /lava-1089068/1
    2024-02-06T02:09:49.924464  =

    2024-02-06T02:09:49.931366  / # /lava-1089068/bin/lava-test-runner /lav=
a-1089068/1
    2024-02-06T02:09:50.037976  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform               | arch  | lab             | compiler | defconfig    =
        | regressions
-----------------------+-------+-----------------+----------+--------------=
--------+------------
imx6q-sabrelite        | arm   | lab-collabora   | gcc-10   | multi_v7_defc=
onfig   | 1          =


  Details:     https://kernelci.org/test/plan/id/65c19bf7091424194600a04e

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-s=
abrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-s=
abrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c19bf7091424194600a056
        failing since 375 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2024-02-06T02:45:29.556697  + set +x

    2024-02-06T02:45:29.557605  =


    2024-02-06T02:45:29.557927  / # <8>[    9.900348] <LAVA_SIGNAL_ENDRUN 0=
_dmesg 12705445_1.5.2.4.1>

    2024-02-06T02:45:29.662612  #

    2024-02-06T02:45:29.764985  export SHELL=3D/bin/sh

    2024-02-06T02:45:29.765738  #

    2024-02-06T02:45:29.867182  / # export SHELL=3D/bin/sh. /lava-12705445/=
environment

    2024-02-06T02:45:29.867983  =


    2024-02-06T02:45:29.969500  / # . /lava-12705445/environment/lava-12705=
445/bin/lava-test-runner /lava-12705445/1

    2024-02-06T02:45:29.970704  =

 =

    ... (17 line(s) more)  =

 =



platform               | arch  | lab             | compiler | defconfig    =
        | regressions
-----------------------+-------+-----------------+----------+--------------=
--------+------------
imx6qp-wandboard-revd1 | arm   | lab-pengutronix | gcc-10   | defconfig    =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/65c194111786c179eb00a076

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm/defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandboa=
rd-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm/defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandboa=
rd-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c194111786c179eb00a07e
        failing since 375 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2024-02-06T02:06:01.959809  + set +x
    2024-02-06T02:06:02.065570  / # #
    2024-02-06T02:06:02.167496  export SHELL=3D/bin/sh
    2024-02-06T02:06:02.168034  [    7.276966] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2024-02-06T02:06:02.168181  [    7.278289] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1023859_1.5.2.3.1>
    2024-02-06T02:06:02.168316  #
    2024-02-06T02:06:02.269185  / # export SHELL=3D/bin/sh. /lava-1023859/e=
nvironment
    2024-02-06T02:06:02.269711  =

    2024-02-06T02:06:02.370673  / # . /lava-1023859/environment/lava-102385=
9/bin/lava-test-runner /lava-1023859/1
    2024-02-06T02:06:02.371389   =

    ... (13 line(s) more)  =

 =



platform               | arch  | lab             | compiler | defconfig    =
        | regressions
-----------------------+-------+-----------------+----------+--------------=
--------+------------
imx6qp-wandboard-revd1 | arm   | lab-pengutronix | gcc-10   | imx_v6_v7_def=
config  | 1          =


  Details:     https://kernelci.org/test/plan/id/65c18ead98df1c5f7500a04e

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6=
qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6=
qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c18ead98df1c5f7500a056
        failing since 375 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2024-02-06T01:43:00.264671  + set +x
    2024-02-06T01:43:00.378455  [    8.750332] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines#
    2024-02-06T01:43:00.379453   MEASUREMENT=3D0>
    2024-02-06T01:43:00.379567  / # [    8.752854] <LAVA_SIGNAL_ENDRUN 0_dm=
esg 1023851_1.5.2.3.1>
    2024-02-06T01:43:00.480427  #export SHELL=3D/bin/sh
    2024-02-06T01:43:00.480949  =

    2024-02-06T01:43:00.581774  / # export SHELL=3D/bin/sh. /lava-1023851/e=
nvironment
    2024-02-06T01:43:00.582238  =

    2024-02-06T01:43:00.683058  / # . /lava-1023851/environment/lava-102385=
1/bin/lava-test-runner /lava-1023851/1
    2024-02-06T01:43:00.683666   =

    ... (13 line(s) more)  =

 =



platform               | arch  | lab             | compiler | defconfig    =
        | regressions
-----------------------+-------+-----------------+----------+--------------=
--------+------------
imx6qp-wandboard-revd1 | arm   | lab-pengutronix | gcc-10   | multi_v7_defc=
onfig   | 1          =


  Details:     https://kernelci.org/test/plan/id/65c192fa74448f0c7600a07d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6q=
p-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6q=
p-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c192fa74448f0c7600a086
        failing since 375 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2024-02-06T02:01:22.135211  [    7.269330] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2024-02-06T02:01:22.135356  [    7.270716] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1023857_1.5.2.3.1>
    2024-02-06T02:01:22.238038  / # #
    2024-02-06T02:01:22.339254  export SHELL=3D/bin/sh
    2024-02-06T02:01:22.339685  #
    2024-02-06T02:01:22.440578  / # export SHELL=3D/bin/sh. /lava-1023857/e=
nvironment
    2024-02-06T02:01:22.441002  =

    2024-02-06T02:01:22.541941  / # . /lava-1023857/environment/lava-102385=
7/bin/lava-test-runner /lava-1023857/1
    2024-02-06T02:01:22.542801  =

    2024-02-06T02:01:22.544946  / # /lava-1023857/bin/lava-test-runner /lav=
a-1023857/1 =

    ... (12 line(s) more)  =

 =



platform               | arch  | lab             | compiler | defconfig    =
        | regressions
-----------------------+-------+-----------------+----------+--------------=
--------+------------
juno-uboot             | arm64 | lab-broonie     | gcc-10   | defconfig+pre=
empt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/65c1945997e4d9b54a00a055

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm64/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-juno-=
uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm64/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-juno-=
uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c1945997e4d9b54a00a095
        failing since 139 days (last pass: v5.10.186-cip37-rt15, first fail=
: v5.10.194-cip39-rt16)

    2024-02-06T02:06:58.442977  895212] <LAVA_SIGNAL_ENDRUN 0_dmesg 547266_=
1.5.2.4.1>
    2024-02-06T02:06:58.443370  =

    2024-02-06T02:06:58.545530  / # #export SHELL=3D/bin/sh
    2024-02-06T02:06:58.546330  =

    2024-02-06T02:06:58.648233  / # export SHELL=3D/bin/sh. /lava-547266/en=
vironment
    2024-02-06T02:06:58.649015  =

    2024-02-06T02:06:58.751013  / # . /lava-547266/environment/lava-547266/=
bin/lava-test-runner /lava-547266/1
    2024-02-06T02:06:58.752238  =

    2024-02-06T02:06:58.768583  / # /lava-547266/bin/lava-test-runner /lava=
-547266/1
    2024-02-06T02:06:58.824451  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (14 line(s) more)  =

 =



platform               | arch  | lab             | compiler | defconfig    =
        | regressions
-----------------------+-------+-----------------+----------+--------------=
--------+------------
juno-uboot             | arm64 | lab-broonie     | gcc-10   | defconfig    =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/65c19675911f93f72800a05d

  Results:     49 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c19675911f93f72800a09c
        failing since 74 days (last pass: v5.10.194-cip39-rt16, first fail:=
 v5.10.201-cip41-rt17)

    2024-02-06T02:15:52.825276  / # <8>[   13.897368] <LAVA_SIGNAL_TESTCASE=
 TEST_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2024-02-06T02:15:52.931256  <8>[   13.898707] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 547332_1.5.2.4.1>#
    2024-02-06T02:15:53.033989  export SHELL=3D/bin/sh
    2024-02-06T02:15:53.034783  =

    2024-02-06T02:15:53.035206  #
    2024-02-06T02:15:53.136995  / # export SHELL=3D/bin/sh. /lava-547332/en=
vironment
    2024-02-06T02:15:53.137757  =

    2024-02-06T02:15:53.239816  / # . /lava-547332/environment/lava-547332/=
bin/lava-test-runner /lava-547332/1
    2024-02-06T02:15:53.241089  =

    2024-02-06T02:15:53.259520  / # /lava-547332/bin/lava-test-runner /lava=
-547332/1 =

    ... (15 line(s) more)  =

 =



platform               | arch  | lab             | compiler | defconfig    =
        | regressions
-----------------------+-------+-----------------+----------+--------------=
--------+------------
r8a7743-iwg20d-q7      | arm   | lab-cip         | gcc-10   | shmobile_defc=
onfig   | 1          =


  Details:     https://kernelci.org/test/plan/id/65c191b422b33572ed00a03b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-iwg20=
d-q7.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-iwg20=
d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65c191b522b33572ed00a=
03c
        failing since 74 days (last pass: v5.10.194-cip39-rt16, first fail:=
 v5.10.201-cip41-rt17) =

 =



platform               | arch  | lab             | compiler | defconfig    =
        | regressions
-----------------------+-------+-----------------+----------+--------------=
--------+------------
r8a774c0-ek874         | arm64 | lab-cip         | gcc-10   | defconfig    =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/65c196fd1c9ea447e300a06e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c196fd1c9ea447e300a077
        failing since 74 days (last pass: v5.10.194-cip39-rt16, first fail:=
 v5.10.201-cip41-rt17)

    2024-02-06T02:18:11.890128  / # #
    2024-02-06T02:18:13.350430  export SHELL=3D/bin/sh
    2024-02-06T02:18:13.371415  #
    2024-02-06T02:18:13.371977  / # export SHELL=3D/bin/sh
    2024-02-06T02:18:15.324314  / # . /lava-1089105/environment
    2024-02-06T02:18:18.915686  /lava-1089105/bin/lava-test-runner /lava-10=
89105/1
    2024-02-06T02:18:18.937205  . /lava-1089105/environment
    2024-02-06T02:18:18.937584  / # /lava-1089105/bin/lava-test-runner /lav=
a-1089105/1
    2024-02-06T02:18:18.974520  + export 'TESTRUN_ID=3D1_bootrr'
    2024-02-06T02:18:19.014661  + cd /lava-1089105/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform               | arch  | lab             | compiler | defconfig    =
        | regressions
-----------------------+-------+-----------------+----------+--------------=
--------+------------
rk3288-veyron-jaq      | arm   | lab-collabora   | gcc-10   | multi_v7_defc=
onfig   | 4          =


  Details:     https://kernelci.org/test/plan/id/65c1930e192d1ff90e00a056

  Results:     61 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-=
veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-=
veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-i2c-present: https://kernelci.or=
g/test/case/id/65c1930e192d1ff90e00a087
        failing since 374 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2024-02-06T02:09:14.500089  	<8>[   18.135497] <LAVA_SIGNAL_TESTCASE TE=
ST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>

    2024-02-06T02:09:14.503524  -w	Pad to last with leading zeros

    2024-02-06T02:09:14.505948  	-s SEP	String separator
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/65c1930e192d1ff90e00a088
        failing since 374 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2024-02-06T02:09:14.487344  m FIRST to LAST, in steps of INC.

    2024-02-06T02:09:14.489825  FIRST, INC default to 1.

    2024-02-06T02:09:14.490210  =

   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/65c1930e192d1ff90e00a089
        failing since 374 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2024-02-06T02:09:14.467672  <8>[   18.106694] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>

    2024-02-06T02:09:14.471984  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2024-02-06T02:09:14.472248  =


    2024-02-06T02:09:14.483709  Print numbers fro<8>[   18.120617] <LAVA_SI=
GNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-audio-present RESULT=3D=
fail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c1930e192d1ff90e00a09d
        failing since 374 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2024-02-06T02:09:02.527286  <8>[    6.174682] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dalert RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2024-02-06T02:09:02.528506  + set +x

    2024-02-06T02:09:02.633074  =


    2024-02-06T02:09:02.633382  / # <8>[    6.183808] <LAVA_SIGNAL_TESTCASE=
 TEST_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2024-02-06T02:09:02.633627  <8>[    6.191777] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12705440_1.5.2.3.1>

    2024-02-06T02:09:02.735057  #export SHELL=3D/bin/sh

    2024-02-06T02:09:02.735771  =


    2024-02-06T02:09:02.837126  / # export SHELL=3D/bin/sh. /lava-12705440/=
environment

    2024-02-06T02:09:02.837827  =


    2024-02-06T02:09:02.939279  / # . /lava-12705440/environment/lava-12705=
440/bin/lava-test-runner /lava-12705440/1
 =

    ... (22 line(s) more)  =

 =



platform               | arch  | lab             | compiler | defconfig    =
        | regressions
-----------------------+-------+-----------------+----------+--------------=
--------+------------
rk3399-rock-pi-4b      | arm64 | lab-collabora   | gcc-10   | defconfig+pre=
empt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/65c193f153bcdbd98900a048

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm64/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-rk3=
399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm64/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-rk3=
399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c193f153bcdbd98900a051
        failing since 139 days (last pass: v5.10.186-cip37-rt15, first fail=
: v5.10.194-cip39-rt16)

    2024-02-06T02:05:09.276053  #

    2024-02-06T02:05:10.537220  export SHELL=3D/bin/sh

    2024-02-06T02:05:10.548205  #

    2024-02-06T02:05:10.548672  / # export SHELL=3D/bin/sh

    2024-02-06T02:05:12.292699  / # . /lava-12705516/environment

    2024-02-06T02:05:15.497794  /lava-12705516/bin/lava-test-runner /lava-1=
2705516/1

    2024-02-06T02:05:15.509145  . /lava-12705516/environment

    2024-02-06T02:05:15.513439  / # /lava-12705516/bin/lava-test-runner /la=
va-12705516/1

    2024-02-06T02:05:15.561488  + export 'TESTRUN_ID=3D1_bootrr'

    2024-02-06T02:05:15.561977  + cd /lava-12705516/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform               | arch  | lab             | compiler | defconfig    =
        | regressions
-----------------------+-------+-----------------+----------+--------------=
--------+------------
rk3399-rock-pi-4b      | arm64 | lab-collabora   | gcc-10   | defconfig    =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/65c196426e967f1aed00a054

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock-pi=
-4b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock-pi=
-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65c196426e967f1aed00a=
055
        new failure (last pass: v5.10.201-cip41-rt17) =

 =



platform               | arch  | lab             | compiler | defconfig    =
        | regressions
-----------------------+-------+-----------------+----------+--------------=
--------+------------
sun50i-a64-pine64-plus | arm64 | lab-broonie     | gcc-10   | defconfig+pre=
empt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/65c194aa269ec5a41300a094

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm64/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-sun50=
i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm64/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-sun50=
i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65c194aa269ec5a41300a=
095
        failing since 74 days (last pass: v5.10.194-cip39-rt16, first fail:=
 v5.10.201-cip41-rt17) =

 =



platform               | arch  | lab             | compiler | defconfig    =
        | regressions
-----------------------+-------+-----------------+----------+--------------=
--------+------------
sun50i-a64-pine64-plus | arm64 | lab-broonie     | gcc-10   | defconfig    =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/65c19752871dd0d30100a054

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine6=
4-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine6=
4-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65c19752871dd0d30100a=
055
        failing since 205 days (last pass: v5.10.175-cip29-rt12, first fail=
: v5.10.186-cip37-rt15) =

 =20

