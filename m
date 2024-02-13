Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDBAC4829F
	for <webhook@archiver.kernel.org>; Tue, 13 Feb 2024 18:36:16 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.web11.21261.1707849375838837766
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 13 Feb 2024 10:36:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=25hBEicN;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.182, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e1040455b5so339151b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 13 Feb 2024 10:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707849375; x=1708454175; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NDanMl+uFFanj/sFTOnlxMO8y3XbftvWOiMUESQn2Ow=;
        b=25hBEicNW3qZpOFVP3QOkP7/TGDfo30W5CdvGJf3qHn6i+crcf0GmAIVeVdTZhQ+qZ
         C2+lgutEcXpfAj8ZMk/d3qpjkfbwSi/hAQUL84KT/xj4JBuk1DDymmMILIUiFUPMi9fb
         4iJKkINh85vy/h6g5fmcbKLaq6QO3x4agrK/LAVPwzHlkfAZ3Xjt88bXRs7vYoS1gWnD
         pYZaKbtRXBYNJCTg3VS/ms8bAlInLvmo2U1T4I2Uxu9m9XdrVV/Xa3nV8lulaLG3T8a1
         a+U46IIqrDfAMhUnyBi7cO0s6ku27L7kIU5bbdJtnZfZ0mOSKPMvQftSgrWU3XrQwyLW
         sg0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707849375; x=1708454175;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NDanMl+uFFanj/sFTOnlxMO8y3XbftvWOiMUESQn2Ow=;
        b=f/ZijX/GNvfGeOfphjT+7ix1YGd57MXde3NuuSEnhYhD2ZXtaCXD+MIRWuoBFeYY3A
         qRKn68fcjZXdx7jk03umaAbf9/CfXoQ6G9aNOyGqxATuBwUKyMWvFkbg4MPCAVsyPDNi
         oYIlT9qaWwSFUTaJ8Hu55Egpa8mq1IJ9vYcS6KS2qk2z6/5zZhsP266tx7nBOvPJe3/R
         Dm2wBaiFiuO2p49hNUWAQzx0XiYZiUJCdD06RWMSx0ri1Qs2PeA1RTB6SviSqaEYSUjy
         +QfjSlquZJ/Az2UwKfCtdF17EDr6NQjdzmP9ovSqt1ICBwCajISrWgK5+A4Z/1PHgL5z
         vF4g==
X-Gm-Message-State: AOJu0YyuDNSnC2VEGpF2LDNMlJGuZIl2FG7f8CL/vgPq7GbaE79ylF6q
	DDVAUEMhx8FiZUpJ0dqmobcrPagin4lId1/Kc26ECF18HTfv+JP3ajqMhRdDn28sGwrmOuhPBZQ
	xQvk=
X-Google-Smtp-Source: AGHT+IHMOXvyWWIPydhkJ8ypdantPJneK37/8XdNM+ZbmREnLS514jk/pRB+A/XGeeC5zPcsGGOjzw==
X-Received: by 2002:a05:6a20:9d92:b0:19c:955e:7100 with SMTP id mu18-20020a056a209d9200b0019c955e7100mr495021pzb.62.1707849374368;
        Tue, 13 Feb 2024 10:36:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXisP8GMQ3Y44GkDPVJe5+fQWwgG+uqJ04U+jXgkiiNLETD0/uWjjzT0uL5+hKo8/cCK6xV3O7aVjkJ2ho9F11w0vGi1ciqpdKuB+ft02J3x0o9erA1bO7yaxSm/B+0s1sGz3TslU/9oCHENzbOML3DbQ==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id v17-20020a170902d09100b001db47423bdfsm830458plv.97.2024.02.13.10.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 10:36:13 -0800 (PST)
Message-ID: <65cbb69d.170a0220.31009.31e4@mx.google.com>
Date: Tue, 13 Feb 2024 10:36:13 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.209-cip44-51-gdb99ac443b0da
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip baseline: 111 runs,
 23 regressions (v5.10.209-cip44-51-gdb99ac443b0da)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Feb 2024 18:36:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14943

cip/linux-5.10.y-cip baseline: 111 runs, 23 regressions (v5.10.209-cip44-51=
-gdb99ac443b0da)

Regressions Summary
-------------------

platform                 | arch  | lab             | compiler | defconfig  =
                | regressions
-------------------------+-------+-----------------+----------+------------=
----------------+------------
at91sam9g20ek            | arm   | lab-broonie     | gcc-10   | at91_dt_def=
config          | 2          =

bcm2836-rpi-2-b          | arm   | lab-collabora   | gcc-10   | bcm2835_def=
config          | 1          =

beaglebone-black         | arm   | lab-broonie     | gcc-10   | multi_v7_de=
fconfig         | 1          =

beaglebone-black         | arm   | lab-cip         | gcc-10   | multi_v7_de=
fconfig         | 1          =

beaglebone-black         | arm   | lab-broonie     | gcc-10   | omap2plus_d=
efconfig        | 1          =

beaglebone-black         | arm   | lab-cip         | gcc-10   | omap2plus_d=
efconfig        | 1          =

imx6q-sabrelite          | arm   | lab-collabora   | gcc-10   | multi_v7_de=
fconfig         | 1          =

imx6qp-wandboard-revd1   | arm   | lab-pengutronix | gcc-10   | imx_v6_v7_d=
efconfig        | 1          =

imx6qp-wandboard-revd1   | arm   | lab-pengutronix | gcc-10   | multi_v7_de=
fconfig         | 1          =

mt8173-elm-hana          | arm64 | lab-collabora   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

r8a7743-iwg20d-q7        | arm   | lab-cip         | gcc-10   | shmobile_de=
fconfig         | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip         | gcc-10   | defconfig  =
                | 1          =

r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip         | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

r8a774c0-ek874           | arm64 | lab-cip         | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

r8a774c0-ek874           | arm64 | lab-cip         | gcc-10   | defconfig  =
                | 1          =

r8a77960-ulcb            | arm64 | lab-collabora   | gcc-10   | defconfig  =
                | 1          =

rk3288-veyron-jaq        | arm   | lab-collabora   | gcc-10   | multi_v7_de=
fconfig         | 4          =

rk3399-rock-pi-4b        | arm64 | lab-collabora   | gcc-10   | defconfig  =
                | 1          =

sun50i-h6-pine-h64       | arm64 | lab-collabora   | gcc-10   | defconfig  =
                | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.209-cip44-51-gdb99ac443b0da/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.209-cip44-51-gdb99ac443b0da
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      db99ac443b0da75f00a4fc49e0040ac5dfa47e72 =



Test Regressions
---------------- =



platform                 | arch  | lab             | compiler | defconfig  =
                | regressions
-------------------------+-------+-----------------+----------+------------=
----------------+------------
at91sam9g20ek            | arm   | lab-broonie     | gcc-10   | at91_dt_def=
config          | 2          =


  Details:     https://kernelci.org/test/plan/id/65cba63b57e305312a637036

  Results:     47 PASS, 6 FAIL, 1 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm/at91_dt_defconfig/gcc-10/lab-broonie/baseline-=
at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm/at91_dt_defconfig/gcc-10/lab-broonie/baseline-=
at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/65cba63c5=
7e305312a637045
        failing since 8 days (last pass: v5.10.208-cip43-4-g1c63c70fb18b8, =
first fail: v5.10.209-cip44)

    2024-02-13T17:26:00.771409  /lava-579362/1/../bin/lava-test-case
    2024-02-13T17:26:00.809247  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dsou=
nd-card RESULT=3Dfail>   =


  * baseline.bootrr.audio-card-probed: https://kernelci.org/test/case/id/65=
cba63c57e305312a637046
        failing since 8 days (last pass: v5.10.208-cip43-4-g1c63c70fb18b8, =
first fail: v5.10.209-cip44)

    2024-02-13T17:25:59.677552  /lava-579362/1/../bin/lava-test-case
    2024-02-13T17:25:59.716624  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Daud=
io-card-probed RESULT=3Dfail>   =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                | regressions
-------------------------+-------+-----------------+----------+------------=
----------------+------------
bcm2836-rpi-2-b          | arm   | lab-collabora   | gcc-10   | bcm2835_def=
config          | 1          =


  Details:     https://kernelci.org/test/plan/id/65cba8ce88fd47213463701c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm/bcm2835_defconfig/gcc-10/lab-collabora/baselin=
e-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm/bcm2835_defconfig/gcc-10/lab-collabora/baselin=
e-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65cba8ce88fd472134637025
        failing since 202 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2024-02-13T17:44:37.329522  / # #

    2024-02-13T17:44:37.431703  export SHELL=3D/bin/sh

    2024-02-13T17:44:37.432463  #

    2024-02-13T17:44:37.533825  / # export SHELL=3D/bin/sh. /lava-12757529/=
environment

    2024-02-13T17:44:37.534512  =


    2024-02-13T17:44:37.635807  / # . /lava-12757529/environment/lava-12757=
529/bin/lava-test-runner /lava-12757529/1

    2024-02-13T17:44:37.636944  =


    2024-02-13T17:44:37.680875  / # /lava-12757529/bin/lava-test-runner /la=
va-12757529/1

    2024-02-13T17:44:37.718276  + export 'TESTRUN_ID=3D1_bootrr'

    2024-02-13T17:44:37.756210  + cd /lava-12757529/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                | regressions
-------------------------+-------+-----------------+----------+------------=
----------------+------------
beaglebone-black         | arm   | lab-broonie     | gcc-10   | multi_v7_de=
fconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65cbabbff25970bfd863705b

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline=
-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline=
-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65cbabbff25970bfd863708b
        failing since 395 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-13T17:49:17.390401  <8>[   21.566396] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 579663_1.5.2.4.1>
    2024-02-13T17:49:17.499236  / # #
    2024-02-13T17:49:17.601526  export SHELL=3D/bin/sh
    2024-02-13T17:49:17.602163  #
    2024-02-13T17:49:17.703855  / # export SHELL=3D/bin/sh. /lava-579663/en=
vironment
    2024-02-13T17:49:17.704493  =

    2024-02-13T17:49:17.806098  / # . /lava-579663/environment/lava-579663/=
bin/lava-test-runner /lava-579663/1
    2024-02-13T17:49:17.806779  =

    2024-02-13T17:49:17.810717  / # /lava-579663/bin/lava-test-runner /lava=
-579663/1
    2024-02-13T17:49:17.906496  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                | regressions
-------------------------+-------+-----------------+----------+------------=
----------------+------------
beaglebone-black         | arm   | lab-cip         | gcc-10   | multi_v7_de=
fconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65cbacf14126e734aa637012

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-bea=
glebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-bea=
glebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65cbacf14126e734aa63703e
        failing since 395 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-13T17:54:11.524461  <8>[   15.809373] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1092634_1.5.2.4.1>
    2024-02-13T17:54:11.632380  / # #
    2024-02-13T17:54:11.734257  export SHELL=3D/bin/sh
    2024-02-13T17:54:11.734888  #
    2024-02-13T17:54:11.836249  / # export SHELL=3D/bin/sh. /lava-1092634/e=
nvironment
    2024-02-13T17:54:11.836881  =

    2024-02-13T17:54:11.938229  / # . /lava-1092634/environment/lava-109263=
4/bin/lava-test-runner /lava-1092634/1
    2024-02-13T17:54:11.939298  =

    2024-02-13T17:54:11.946343  / # /lava-1092634/bin/lava-test-runner /lav=
a-1092634/1
    2024-02-13T17:54:12.040261  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                | regressions
-------------------------+-------+-----------------+----------+------------=
----------------+------------
beaglebone-black         | arm   | lab-broonie     | gcc-10   | omap2plus_d=
efconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/65cbb00780c99c61dc63701b

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm/omap2plus_defconfig/gcc-10/lab-broonie/baselin=
e-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm/omap2plus_defconfig/gcc-10/lab-broonie/baselin=
e-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65cbb00780c99c61dc63704f
        failing since 395 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-13T18:07:39.720498  + set +x
    2024-02-13T18:07:39.723784  <8>[   25.463865] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 579857_1.5.2.4.1>
    2024-02-13T18:07:39.832195  / # #
    2024-02-13T18:07:39.933719  export SHELL=3D/bin/sh
    2024-02-13T18:07:39.934168  #
    2024-02-13T18:07:40.035357  / # export SHELL=3D/bin/sh. /lava-579857/en=
vironment
    2024-02-13T18:07:40.035768  =

    2024-02-13T18:07:40.136965  / # . /lava-579857/environment/lava-579857/=
bin/lava-test-runner /lava-579857/1
    2024-02-13T18:07:40.137558  =

    2024-02-13T18:07:40.142468  / # /lava-579857/bin/lava-test-runner /lava=
-579857/1 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                | regressions
-------------------------+-------+-----------------+----------+------------=
----------------+------------
beaglebone-black         | arm   | lab-cip         | gcc-10   | omap2plus_d=
efconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/65cbb2410b07e69ad363702a

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-be=
aglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-be=
aglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65cbb2410b07e69ad3637064
        failing since 395 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-13T18:17:24.952296  <8>[   13.029763] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1092663_1.5.2.4.1>
    2024-02-13T18:17:25.063150  / # #
    2024-02-13T18:17:25.165192  export SHELL=3D/bin/sh
    2024-02-13T18:17:25.165840  #
    2024-02-13T18:17:25.267097  / # export SHELL=3D/bin/sh. /lava-1092663/e=
nvironment
    2024-02-13T18:17:25.267790  =

    2024-02-13T18:17:25.369130  / # . /lava-1092663/environment/lava-109266=
3/bin/lava-test-runner /lava-1092663/1
    2024-02-13T18:17:25.370166  =

    2024-02-13T18:17:25.376758  / # /lava-1092663/bin/lava-test-runner /lav=
a-1092663/1
    2024-02-13T18:17:25.482511  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                | regressions
-------------------------+-------+-----------------+----------+------------=
----------------+------------
imx6q-sabrelite          | arm   | lab-collabora   | gcc-10   | multi_v7_de=
fconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65cba9ecfa56040ef5637041

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65cba9ecfa56040ef563704a
        failing since 395 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-13T17:47:48.960691  / # #

    2024-02-13T17:47:49.062871  export SHELL=3D/bin/sh

    2024-02-13T17:47:49.063616  #

    2024-02-13T17:47:49.165063  / # export SHELL=3D/bin/sh. /lava-12757636/=
environment

    2024-02-13T17:47:49.165780  =


    2024-02-13T17:47:49.267289  / # . /lava-12757636/environment/lava-12757=
636/bin/lava-test-runner /lava-12757636/1

    2024-02-13T17:47:49.268388  =


    2024-02-13T17:47:49.284787  / # /lava-12757636/bin/lava-test-runner /la=
va-12757636/1

    2024-02-13T17:47:49.332756  + export 'TESTRUN_ID=3D1_bootrr'

    2024-02-13T17:47:49.387745  + cd /lava-12757636/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                | regressions
-------------------------+-------+-----------------+----------+------------=
----------------+------------
imx6qp-wandboard-revd1   | arm   | lab-pengutronix | gcc-10   | imx_v6_v7_d=
efconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/65cbabe2f25970bfd8637096

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/bas=
eline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/bas=
eline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65cbabe2f25970bfd863709f
        failing since 395 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-13T17:50:18.341017  + set +x
    2024-02-13T17:50:18.341183  [   10.254986] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1024608_1.5.2.3.1>
    2024-02-13T17:50:18.448691  / # #
    2024-02-13T17:50:18.549878  export SHELL=3D/bin/sh
    2024-02-13T17:50:18.550287  #
    2024-02-13T17:50:18.651045  / # export SHELL=3D/bin/sh. /lava-1024608/e=
nvironment
    2024-02-13T17:50:18.651510  =

    2024-02-13T17:50:18.752334  / # . /lava-1024608/environment/lava-102460=
8/bin/lava-test-runner /lava-1024608/1
    2024-02-13T17:50:18.752997  =

    2024-02-13T17:50:18.755502  / # /lava-1024608/bin/lava-test-runner /lav=
a-1024608/1 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                | regressions
-------------------------+-------+-----------------+----------+------------=
----------------+------------
imx6qp-wandboard-revd1   | arm   | lab-pengutronix | gcc-10   | multi_v7_de=
fconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65cba9c631e790c9f563704a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/base=
line-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/base=
line-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65cba9c631e790c9f5637053
        failing since 395 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-13T17:41:19.042843  + set[    7.183298] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 1024607_1.5.2.3.1>
    2024-02-13T17:41:19.042992   +x
    2024-02-13T17:41:19.148029  / # #
    2024-02-13T17:41:19.249101  export SHELL=3D/bin/sh
    2024-02-13T17:41:19.249507  #
    2024-02-13T17:41:19.350253  / # export SHELL=3D/bin/sh. /lava-1024607/e=
nvironment
    2024-02-13T17:41:19.350758  =

    2024-02-13T17:41:19.451581  / # . /lava-1024607/environment/lava-102460=
7/bin/lava-test-runner /lava-1024607/1
    2024-02-13T17:41:19.452318  =

    2024-02-13T17:41:19.454425  / # /lava-1024607/bin/lava-test-runner /lav=
a-1024607/1 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                | regressions
-------------------------+-------+-----------------+----------+------------=
----------------+------------
mt8173-elm-hana          | arm64 | lab-collabora   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65cbadf7072579135e637092

  Results:     28 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm64/defconfig+arm64-chromebook/gcc-10/lab-collab=
ora/baseline-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm64/defconfig+arm64-chromebook/gcc-10/lab-collab=
ora/baseline-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65cbadf7072579135e6370b2
        failing since 395 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-13T17:59:11.488960  <8>[   15.642479] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2024-02-13T17:59:11.489609  + set +x

    2024-02-13T17:59:11.497227  <8>[   15.652039] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12757714_1.5.2.3.1>

    2024-02-13T17:59:11.602711  /#

    2024-02-13T17:59:11.705469   # #export SHELL=3D/bin/sh

    2024-02-13T17:59:11.706292  =


    2024-02-13T17:59:11.807874  / # export SHELL=3D/bin/sh. /lava-12757714/=
environment

    2024-02-13T17:59:11.808655  =


    2024-02-13T17:59:11.910344  / # . /lava-12757714/environment/lava-12757=
714/bin/lava-test-runner /lava-12757714/1

    2024-02-13T17:59:11.911667  =

 =

    ... (22 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                | regressions
-------------------------+-------+-----------------+----------+------------=
----------------+------------
r8a7743-iwg20d-q7        | arm   | lab-cip         | gcc-10   | shmobile_de=
fconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65cba82d28008ad39563702e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a=
7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a=
7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65cba82d28008ad395637=
02f
        failing since 67 days (last pass: v5.10.201-cip41-16-g3c85fba3b6e5d=
, first fail: v5.10.201-cip41-28-ga386bc478aa6b) =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                | regressions
-------------------------+-------+-----------------+----------+------------=
----------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip         | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/65cbb0fce2fea7ebd6637042

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774a1-h=
ihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774a1-h=
ihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65cbb0fce2fea7ebd6637049
        failing since 188 days (last pass: v5.10.182-cip35-1-g7cde3fba93966=
, first fail: v5.10.186-cip37-13-g260094841fe1a)

    2024-02-13T18:11:49.440944  + set +x
    2024-02-13T18:11:49.444289  <8>[   84.036428] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1092681_1.5.2.4.1>
    2024-02-13T18:11:49.553140  / # #
    2024-02-13T18:11:51.017456  export SHELL=3D/bin/sh
    2024-02-13T18:11:51.038515  #
    2024-02-13T18:11:51.039002  / # export SHELL=3D/bin/sh
    2024-02-13T18:11:52.998322  / # . /lava-1092681/environment
    2024-02-13T18:11:56.602505  /lava-1092681/bin/lava-test-runner /lava-10=
92681/1
    2024-02-13T18:11:56.624028  . /lava-1092681/environment
    2024-02-13T18:11:56.624479  / # /lava-1092681/bin/lava-test-runner /lav=
a-1092681/1 =

    ... (28 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                | regressions
-------------------------+-------+-----------------+----------+------------=
----------------+------------
r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip         | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65cbb02477f0ff80dc637018

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ba=
seline-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ba=
seline-r8a774b1-hihope-rzg2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65cbb02477f0ff80dc637021
        failing since 202 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2024-02-13T18:08:22.355176  + set +x
    2024-02-13T18:08:22.357569  <8>[   84.198437] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1092655_1.5.2.4.1>
    2024-02-13T18:08:22.468226  / # #
    2024-02-13T18:08:23.926765  export SHELL=3D/bin/sh
    2024-02-13T18:08:23.947713  #
    2024-02-13T18:08:23.948176  / # export SHELL=3D/bin/sh
    2024-02-13T18:08:25.897306  / # . /lava-1092655/environment
    2024-02-13T18:08:29.483942  /lava-1092655/bin/lava-test-runner /lava-10=
92655/1
    2024-02-13T18:08:29.505503  . /lava-1092655/environment
    2024-02-13T18:08:29.505940  / # /lava-1092655/bin/lava-test-runner /lav=
a-1092655/1 =

    ... (15 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                | regressions
-------------------------+-------+-----------------+----------+------------=
----------------+------------
r8a774c0-ek874           | arm64 | lab-cip         | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65cbb088f2e50c1d13637012

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ba=
seline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ba=
seline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65cbb088f2e50c1d1363701b
        failing since 202 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2024-02-13T18:09:50.299420  / # #
    2024-02-13T18:09:51.753310  export SHELL=3D/bin/sh
    2024-02-13T18:09:51.773660  #
    2024-02-13T18:09:51.773801  / # export SHELL=3D/bin/sh
    2024-02-13T18:09:53.718412  / # . /lava-1092656/environment
    2024-02-13T18:09:57.301166  /lava-1092656/bin/lava-test-runner /lava-10=
92656/1
    2024-02-13T18:09:57.322485  . /lava-1092656/environment
    2024-02-13T18:09:57.322855  / # /lava-1092656/bin/lava-test-runner /lav=
a-1092656/1
    2024-02-13T18:09:57.402180  + export 'TESTRUN_ID=3D1_bootrr'
    2024-02-13T18:09:57.402716  + cd /lava-1092656/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                | regressions
-------------------------+-------+-----------------+----------+------------=
----------------+------------
r8a774c0-ek874           | arm64 | lab-cip         | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/65cbb164812a780c91637014

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-e=
k874.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-e=
k874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65cbb164812a780c9163701d
        failing since 202 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2024-02-13T18:13:43.226155  / # #
    2024-02-13T18:13:44.685496  export SHELL=3D/bin/sh
    2024-02-13T18:13:44.706512  #
    2024-02-13T18:13:44.707037  / # export SHELL=3D/bin/sh
    2024-02-13T18:13:46.656984  / # . /lava-1092673/environment
    2024-02-13T18:13:50.243328  /lava-1092673/bin/lava-test-runner /lava-10=
92673/1
    2024-02-13T18:13:50.264608  . /lava-1092673/environment
    2024-02-13T18:13:50.264973  / # /lava-1092673/bin/lava-test-runner /lav=
a-1092673/1
    2024-02-13T18:13:50.341330  + export 'TESTRUN_ID=3D1_bootrr'
    2024-02-13T18:13:50.342146  + cd /lava-1092673/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                | regressions
-------------------------+-------+-----------------+----------+------------=
----------------+------------
r8a77960-ulcb            | arm64 | lab-collabora   | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/65cbaeab1712acbb4263701c

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a7=
7960-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a7=
7960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65cbaeab1712acbb42637025
        failing since 202 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2024-02-13T18:09:44.360232  / # #

    2024-02-13T18:09:44.462443  export SHELL=3D/bin/sh

    2024-02-13T18:09:44.463219  #

    2024-02-13T18:09:44.564579  / # export SHELL=3D/bin/sh. /lava-12757832/=
environment

    2024-02-13T18:09:44.565309  =


    2024-02-13T18:09:44.666722  / # . /lava-12757832/environment/lava-12757=
832/bin/lava-test-runner /lava-12757832/1

    2024-02-13T18:09:44.667953  =


    2024-02-13T18:09:44.684576  / # /lava-12757832/bin/lava-test-runner /la=
va-12757832/1

    2024-02-13T18:09:44.733741  + export 'TESTRUN_ID=3D1_bootrr'

    2024-02-13T18:09:44.734258  + cd /lav<8>[   16.385249] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12757832_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                | regressions
-------------------------+-------+-----------------+----------+------------=
----------------+------------
rk3288-veyron-jaq        | arm   | lab-collabora   | gcc-10   | multi_v7_de=
fconfig         | 4          =


  Details:     https://kernelci.org/test/plan/id/65cba9e669abfb831b63701c

  Results:     63 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-i2c-present: https://kernelci.or=
g/test/case/id/65cba9e669abfb831b63704f
        failing since 393 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-13T17:49:26.919004  FIRST,<8>[   18.896908] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>

    2024-02-13T17:49:26.920831   INC default to 1.

    2024-02-13T17:49:26.921047  =


    2024-02-13T17:49:26.924474  	-w	Pad to last with leading zeros

    2024-02-13T17:49:26.927102  	-s SEP	String separator

    2024-02-13T17:49:26.930821  /lava-12757639/1/../bin/lava-test-case

    2024-02-13T17:49:26.936916  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.

    2024-02-13T17:49:26.937134  =

   =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/65cba9e669abfb831b637050
        failing since 393 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-13T17:49:26.896724  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC)<8=
>[   18.877804] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2024-02-13T17:49:26.898426   multi-call binary.

    2024-02-13T17:49:26.898643  =


    2024-02-13T17:49:26.903179  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2024-02-13T17:49:26.903527  =


    2024-02-13T17:49:26.908256  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/65cba9e669abfb831b637051
        failing since 393 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-13T17:49:26.877414  <8>[   18.859930] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65cba9e669abfb831b637065
        failing since 393 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-13T17:49:14.817841  <8>[    6.800166] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2024-02-13T17:49:14.827550  + <8>[    6.812693] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 12757639_1.5.2.3.1>

    2024-02-13T17:49:14.827977  set +x

    2024-02-13T17:49:14.934415  =


    2024-02-13T17:49:15.035871  / # #export SHELL=3D/bin/sh

    2024-02-13T17:49:15.036551  =


    2024-02-13T17:49:15.137799  / # export SHELL=3D/bin/sh. /lava-12757639/=
environment

    2024-02-13T17:49:15.138488  =


    2024-02-13T17:49:15.239852  / # . /lava-12757639/environment/lava-12757=
639/bin/lava-test-runner /lava-12757639/1

    2024-02-13T17:49:15.240973  =

 =

    ... (19 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                | regressions
-------------------------+-------+-----------------+----------+------------=
----------------+------------
rk3399-rock-pi-4b        | arm64 | lab-collabora   | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/65cbaedcee966cf678637031

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm64/defconfig/gcc-10/lab-collabora/baseline-rk33=
99-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm64/defconfig/gcc-10/lab-collabora/baseline-rk33=
99-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65cbaedcee966cf67863703a
        failing since 147 days (last pass: v5.10.191-cip38-29-g9e1aa2001db8=
, first fail: v5.10.194-cip39)

    2024-02-13T18:03:51.195948  / # #

    2024-02-13T18:03:52.456413  export SHELL=3D/bin/sh

    2024-02-13T18:03:52.467346  #

    2024-02-13T18:03:52.467809  / # export SHELL=3D/bin/sh

    2024-02-13T18:03:54.211205  / # . /lava-12757842/environment

    2024-02-13T18:03:57.415407  /lava-12757842/bin/lava-test-runner /lava-1=
2757842/1

    2024-02-13T18:03:57.426803  . /lava-12757842/environment

    2024-02-13T18:03:57.430058  / # /lava-12757842/bin/lava-test-runner /la=
va-12757842/1

    2024-02-13T18:03:57.481081  + export 'TESTRUN_ID=3D1_bootrr'

    2024-02-13T18:03:57.481567  + cd /lava-12757842/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                | regressions
-------------------------+-------+-----------------+----------+------------=
----------------+------------
sun50i-h6-pine-h64       | arm64 | lab-collabora   | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/65cbaebf88e5710bc1637039

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm64/defconfig/gcc-10/lab-collabora/baseline-sun5=
0i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm64/defconfig/gcc-10/lab-collabora/baseline-sun5=
0i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65cbaebf88e5710bc1637042
        failing since 202 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2024-02-13T18:09:59.690731  / # #

    2024-02-13T18:09:59.792908  export SHELL=3D/bin/sh

    2024-02-13T18:09:59.793619  #

    2024-02-13T18:09:59.895042  / # export SHELL=3D/bin/sh. /lava-12757835/=
environment

    2024-02-13T18:09:59.895756  =


    2024-02-13T18:09:59.997189  / # . /lava-12757835/environment/lava-12757=
835/bin/lava-test-runner /lava-12757835/1

    2024-02-13T18:09:59.998267  =


    2024-02-13T18:10:00.015097  / # /lava-12757835/bin/lava-test-runner /la=
va-12757835/1

    2024-02-13T18:10:00.056909  + export 'TESTRUN_ID=3D1_bootrr'

    2024-02-13T18:10:00.072955  + cd /lava-1275783<8>[   18.173725] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12757835_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

