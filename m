Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FEEC5475B
	for <webhook@archiver.kernel.org>; Fri,  1 Mar 2024 15:28:05 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web10.25929.1709306875298109971
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 01 Mar 2024 07:27:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=gKePXkhl;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.177, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d93edfa76dso20743285ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 01 Mar 2024 07:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709306874; x=1709911674; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=R2/iP6xJHY0xje/DNyWw15od/Ts/Z4jH5oS74VvG/DQ=;
        b=gKePXkhlAPeyG+Kof7zZ2pfk/BzzgQuMtUugJBWqdbo2igfqU4G+6OiYcpeppviHzM
         m7pbFOVytThcqjat4XmmHe00I+wsOSQBVACqrSa36T2Xl0FFM9f6LwirPeVSyHibypHP
         EiQIab3SQuVM6JmpE5sS+T+5lyiT9eBNe2v1AQUpHridivRxyjd2lVsDabfE7zsRV3jV
         S2TIUIOV6Sy2krs6omsuLef/49JFs6oEXoFyUl3GAAFptkstR3A8xLnJTnVosvv3O30Q
         9yl3V/VXlEeSlzzTR+ThRN75ALhyxQUdFJVaNFqbMHkD30d6GDXw7A8fcH2Olrd7lu1L
         R89w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709306874; x=1709911674;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R2/iP6xJHY0xje/DNyWw15od/Ts/Z4jH5oS74VvG/DQ=;
        b=nsJ6poY5Fiem2kOQGtBjTs6TcyUWkR1CQOqNSpm0krqqbnxKiRib9Apbf7BnmA0x5T
         K+NYo3Xr6G7PcOdGHGjixXdXNp83ZGR3DyvYazjoZ8XUe+ikUka3o5kemDF2Ojgm4UsQ
         21e+k+bP31OZr7lT+UcbzDx7+y6Y0QbxsXFMKdP+QFIILdNrEn+R0fWxMvesci8ohrsg
         CoXwp8UWT7Lg2y/jvF+rj6sbkyiAEPs6NDKXa/a3fog3oxWsn5VKhgJjakiPxo0XqUpK
         rDTqu0Xp+W3NoXbVKvlqYdAXLiiuoOsg5C0c+A8WFsPXjqCb3auNW8Y4rCmI7G31zeQV
         b7Pg==
X-Gm-Message-State: AOJu0YwEzn3+LyhnLYL1E0Dib4aqSF6Th23BAETAPnpDKnxj7D7E7AIa
	lEe68MJRlqO50QMGJLOF/nT7Zf+y9aScSuSyUdMQIpvRLL5iVqcWvsqBQletQX1a2IxsNSOKfCG
	NyVM=
X-Google-Smtp-Source: AGHT+IFnQ7NKlTRORfq/gZltg4GVbsymBobxVxlwHy872Yl1/cZZ9nMzJ/WL8emJCcPyNJHrr8IGdw==
X-Received: by 2002:a17:902:e5ca:b0:1dc:b7d2:3fc3 with SMTP id u10-20020a170902e5ca00b001dcb7d23fc3mr2106862plf.68.1709306873729;
        Fri, 01 Mar 2024 07:27:53 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id i3-20020a170902c94300b001dc95205b56sm3568008pla.53.2024.03.01.07.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 07:27:53 -0800 (PST)
Message-ID: <65e1f3f9.170a0220.3d668.003a@mx.google.com>
Date: Fri, 01 Mar 2024 07:27:53 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.209-cip44-56-g6ff909810a18d
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip baseline: 97 runs,
 14 regressions (v5.10.209-cip44-56-g6ff909810a18d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 01 Mar 2024 15:28:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15125

cip/linux-5.10.y-cip baseline: 97 runs, 14 regressions (v5.10.209-cip44-56-=
g6ff909810a18d)

Regressions Summary
-------------------

platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
at91sam9g20ek            | arm    | lab-broonie     | gcc-10   | at91_dt_de=
fconfig            | 2          =

bcm2836-rpi-2-b          | arm    | lab-collabora   | gcc-10   | bcm2835_de=
fconfig            | 1          =

beaglebone-black         | arm    | lab-broonie     | gcc-10   | multi_v7_d=
efconfig           | 1          =

beaglebone-black         | arm    | lab-broonie     | gcc-10   | omap2plus_=
defconfig          | 1          =

hp-11A-G6-EE-grunt       | x86_64 | lab-collabora   | gcc-10   | x86_64_def=
config+x86-board   | 1          =

imx6q-sabrelite          | arm    | lab-collabora   | gcc-10   | multi_v7_d=
efconfig           | 1          =

imx6qp-wandboard-revd1   | arm    | lab-pengutronix | gcc-10   | imx_v6_v7_=
defconfig          | 1          =

imx6qp-wandboard-revd1   | arm    | lab-pengutronix | gcc-10   | multi_v7_d=
efconfig           | 1          =

juno-uboot               | arm64  | lab-broonie     | gcc-10   | cip://5.10=
.y-...64_defconfig | 1          =

mt8173-elm-hana          | arm64  | lab-collabora   | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

r8a7743-iwg20d-q7        | arm    | lab-cip         | gcc-10   | shmobile_d=
efconfig           | 1          =

r8a774b1-hihope-rzg2n-ex | arm64  | lab-cip         | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

r8a774c0-ek874           | arm64  | lab-cip         | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.209-cip44-56-g6ff909810a18d/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.209-cip44-56-g6ff909810a18d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      6ff909810a18da01523521db983d48116abb28ec =



Test Regressions
---------------- =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
at91sam9g20ek            | arm    | lab-broonie     | gcc-10   | at91_dt_de=
fconfig            | 2          =


  Details:     https://kernelci.org/test/plan/id/65e1e8acab5665ac80637017

  Results:     47 PASS, 6 FAIL, 1 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-56-g6ff909810a18d/arm/at91_dt_defconfig/gcc-10/lab-broonie/baseline-=
at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-56-g6ff909810a18d/arm/at91_dt_defconfig/gcc-10/lab-broonie/baseline-=
at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/65e1e8aca=
b5665ac80637022
        failing since 24 days (last pass: v5.10.208-cip43-4-g1c63c70fb18b8,=
 first fail: v5.10.209-cip44)

    2024-03-01T14:39:21.293984  /lava-649911/1/../bin/lava-test-case
    2024-03-01T14:39:21.332192  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dsou=
nd-card RESULT=3Dfail>   =


  * baseline.bootrr.audio-card-probed: https://kernelci.org/test/case/id/65=
e1e8acab5665ac80637023
        failing since 24 days (last pass: v5.10.208-cip43-4-g1c63c70fb18b8,=
 first fail: v5.10.209-cip44)

    2024-03-01T14:39:20.200204  /lava-649911/1/../bin/lava-test-case
    2024-03-01T14:39:20.239147  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Daud=
io-card-probed RESULT=3Dfail>   =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
bcm2836-rpi-2-b          | arm    | lab-collabora   | gcc-10   | bcm2835_de=
fconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/65e1e7d335b5109953637012

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-56-g6ff909810a18d/arm/bcm2835_defconfig/gcc-10/lab-collabora/baselin=
e-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-56-g6ff909810a18d/arm/bcm2835_defconfig/gcc-10/lab-collabora/baselin=
e-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e1e7d335b5109953637017
        failing since 219 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2024-03-01T14:46:43.136945  / # #

    2024-03-01T14:46:43.237780  export SHELL=3D/bin/sh

    2024-03-01T14:46:43.238234  #

    2024-03-01T14:46:43.338930  / # export SHELL=3D/bin/sh. /lava-12907146/=
environment

    2024-03-01T14:46:43.339644  =


    2024-03-01T14:46:43.441064  / # . /lava-12907146/environment/lava-12907=
146/bin/lava-test-runner /lava-12907146/1

    2024-03-01T14:46:43.442104  =


    2024-03-01T14:46:43.451224  / # /lava-12907146/bin/lava-test-runner /la=
va-12907146/1

    2024-03-01T14:46:43.562950  + export 'TESTRUN_ID=3D1_bootrr'

    2024-03-01T14:46:43.563461  + cd /lava-12907146/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
beaglebone-black         | arm    | lab-broonie     | gcc-10   | multi_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65e1eaa6b5c0659400637023

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-56-g6ff909810a18d/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline=
-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-56-g6ff909810a18d/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline=
-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e1eaa6b5c0659400637050
        failing since 412 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-03-01T14:47:31.670826  <8>[   18.432510] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 649955_1.5.2.4.1>
    2024-03-01T14:47:31.781200  / # #
    2024-03-01T14:47:31.884266  export SHELL=3D/bin/sh
    2024-03-01T14:47:31.885177  #
    2024-03-01T14:47:31.987246  / # export SHELL=3D/bin/sh. /lava-649955/en=
vironment
    2024-03-01T14:47:31.988205  =

    2024-03-01T14:47:32.090324  / # . /lava-649955/environment/lava-649955/=
bin/lava-test-runner /lava-649955/1
    2024-03-01T14:47:32.091765  =

    2024-03-01T14:47:32.096033  / # /lava-649955/bin/lava-test-runner /lava=
-649955/1
    2024-03-01T14:47:32.181343  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
beaglebone-black         | arm    | lab-broonie     | gcc-10   | omap2plus_=
defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/65e1e868e98b972ba363702c

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-56-g6ff909810a18d/arm/omap2plus_defconfig/gcc-10/lab-broonie/baselin=
e-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-56-g6ff909810a18d/arm/omap2plus_defconfig/gcc-10/lab-broonie/baselin=
e-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e1e868e98b972ba363705f
        failing since 412 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-03-01T14:38:04.503002  <8>[   26.250776] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 649909_1.5.2.4.1>
    2024-03-01T14:38:04.613011  / # #
    2024-03-01T14:38:04.715484  export SHELL=3D/bin/sh
    2024-03-01T14:38:04.716130  #
    2024-03-01T14:38:04.818074  / # export SHELL=3D/bin/sh. /lava-649909/en=
vironment
    2024-03-01T14:38:04.818723  =

    2024-03-01T14:38:04.920611  / # . /lava-649909/environment/lava-649909/=
bin/lava-test-runner /lava-649909/1
    2024-03-01T14:38:04.921484  =

    2024-03-01T14:38:04.925211  / # /lava-649909/bin/lava-test-runner /lava=
-649909/1
    2024-03-01T14:38:05.032651  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
hp-11A-G6-EE-grunt       | x86_64 | lab-collabora   | gcc-10   | x86_64_def=
config+x86-board   | 1          =


  Details:     https://kernelci.org/test/plan/id/65e1e370879fcea2c263703e

  Results:     17 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-56-g6ff909810a18d/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-colla=
bora/baseline-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-56-g6ff909810a18d/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-colla=
bora/baseline-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/65e1e370879fcea=
2c2637051
        new failure (last pass: v5.10.209-cip44-51-gdb99ac443b0da)
        1 lines

    2024-03-01T14:19:49.663654  kern  :emerg : __common_interrupt: 1.55 No =
irq handler for vector

    2024-03-01T14:19:49.673766  <8>[    8.322877] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D1>
   =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
imx6q-sabrelite          | arm    | lab-collabora   | gcc-10   | multi_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65e1ea820e03f306a1637045

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-56-g6ff909810a18d/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-56-g6ff909810a18d/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e1ea820e03f306a163704a
        failing since 412 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-03-01T14:47:22.974733  / # #

    2024-03-01T14:47:23.077206  export SHELL=3D/bin/sh

    2024-03-01T14:47:23.078014  #

    2024-03-01T14:47:23.179870  / # export SHELL=3D/bin/sh. /lava-12907261/=
environment

    2024-03-01T14:47:23.180691  =


    2024-03-01T14:47:23.282416  / # . /lava-12907261/environment/lava-12907=
261/bin/lava-test-runner /lava-12907261/1

    2024-03-01T14:47:23.283724  =


    2024-03-01T14:47:23.296593  / # /lava-12907261/bin/lava-test-runner /la=
va-12907261/1

    2024-03-01T14:47:23.344745  + export 'TESTRUN_ID=3D1_bootrr'

    2024-03-01T14:47:23.400014  + cd /lava-12907261/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
imx6qp-wandboard-revd1   | arm    | lab-pengutronix | gcc-10   | imx_v6_v7_=
defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/65e1e91dd28f0b8e4e637012

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-56-g6ff909810a18d/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/bas=
eline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-56-g6ff909810a18d/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/bas=
eline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e1e91dd28f0b8e4e637017
        failing since 412 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-03-01T14:41:25.221130  + set +x
    2024-03-01T14:41:25.221277  [   10.277156] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1031040_1.5.2.3.1>
    2024-03-01T14:41:25.328946  / # #
    2024-03-01T14:41:25.430247  export SHELL=3D/bin/sh
    2024-03-01T14:41:25.430813  #
    2024-03-01T14:41:25.531668  / # export SHELL=3D/bin/sh. /lava-1031040/e=
nvironment
    2024-03-01T14:41:25.532134  =

    2024-03-01T14:41:25.632907  / # . /lava-1031040/environment/lava-103104=
0/bin/lava-test-runner /lava-1031040/1
    2024-03-01T14:41:25.633484  =

    2024-03-01T14:41:25.636531  / # /lava-1031040/bin/lava-test-runner /lav=
a-1031040/1 =

    ... (12 line(s) more)  =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
imx6qp-wandboard-revd1   | arm    | lab-pengutronix | gcc-10   | multi_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65e1ea704dfc93da45637032

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-56-g6ff909810a18d/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/base=
line-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-56-g6ff909810a18d/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/base=
line-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e1ea704dfc93da45637037
        failing since 412 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-03-01T14:46:49.238819  + set[    7.219702] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 1031045_1.5.2.3.1>
    2024-03-01T14:46:49.238990   +x
    2024-03-01T14:46:49.343976  / # #
    2024-03-01T14:46:49.445229  export SHELL=3D/bin/sh
    2024-03-01T14:46:49.445681  #
    2024-03-01T14:46:49.546478  / # export SHELL=3D/bin/sh. /lava-1031045/e=
nvironment
    2024-03-01T14:46:49.546954  =

    2024-03-01T14:46:49.647732  / # . /lava-1031045/environment/lava-103104=
5/bin/lava-test-runner /lava-1031045/1
    2024-03-01T14:46:49.648362  =

    2024-03-01T14:46:49.650514  / # /lava-1031045/bin/lava-test-runner /lav=
a-1031045/1 =

    ... (12 line(s) more)  =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
juno-uboot               | arm64  | lab-broonie     | gcc-10   | cip://5.10=
.y-...64_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/65e1e5c83212545cc8637017

  Results:     47 PASS, 13 FAIL, 1 SKIP
  Full config: cip://5.10.y-cip/arm64/qemu_arm64_defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-56-g6ff909810a18d/arm64/cip---5.10.y-cip-arm64-qemu_arm64_defconfig/=
gcc-10/lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-56-g6ff909810a18d/arm64/cip---5.10.y-cip-arm64-qemu_arm64_defconfig/=
gcc-10/lab-broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e1e5c83212545cc8637051
        failing since 186 days (last pass: v5.10.186-cip37-27-gd6d928db0a62=
0, first fail: v5.10.191-cip38)

    2024-03-01T14:26:41.632466  <8>[   26.752322] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 649896_1.5.2.4.1>
    2024-03-01T14:26:41.741739  / # #
    2024-03-01T14:26:41.844846  export SHELL=3D/bin/sh
    2024-03-01T14:26:41.845628  #
    2024-03-01T14:26:41.947631  / # export SHELL=3D/bin/sh. /lava-649896/en=
vironment
    2024-03-01T14:26:41.948463  =

    2024-03-01T14:26:42.050473  / # . /lava-649896/environment/lava-649896/=
bin/lava-test-runner /lava-649896/1
    2024-03-01T14:26:42.051805  =

    2024-03-01T14:26:42.064457  / # /lava-649896/bin/lava-test-runner /lava=
-649896/1
    2024-03-01T14:26:42.122311  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
mt8173-elm-hana          | arm64  | lab-collabora   | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/65e1eb7a4850492e8b637055

  Results:     28 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-56-g6ff909810a18d/arm64/defconfig+arm64-chromebook/gcc-10/lab-collab=
ora/baseline-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-56-g6ff909810a18d/arm64/defconfig+arm64-chromebook/gcc-10/lab-collab=
ora/baseline-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e1eb7a4850492e8b637071
        failing since 412 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-03-01T14:51:16.433617  <8>[   15.584989] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2024-03-01T14:51:16.435153  + set +x

    2024-03-01T14:51:16.441506  <8>[   15.594858] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12907285_1.5.2.3.1>

    2024-03-01T14:51:16.545809  =


    2024-03-01T14:51:16.646382  / # #export SHELL=3D/bin/sh

    2024-03-01T14:51:16.646663  =


    2024-03-01T14:51:16.747219  / # export SHELL=3D/bin/sh. /lava-12907285/=
environment

    2024-03-01T14:51:16.747468  =


    2024-03-01T14:51:16.848085  / # . /lava-12907285/environment/lava-12907=
285/bin/lava-test-runner /lava-12907285/1

    2024-03-01T14:51:16.848386  =

 =

    ... (22 line(s) more)  =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
r8a7743-iwg20d-q7        | arm    | lab-cip         | gcc-10   | shmobile_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65e1f2fc1d29e4ccf9637026

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-56-g6ff909810a18d/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a=
7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-56-g6ff909810a18d/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a=
7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65e1f2fc1d29e4ccf9637=
027
        failing since 84 days (last pass: v5.10.201-cip41-16-g3c85fba3b6e5d=
, first fail: v5.10.201-cip41-28-ga386bc478aa6b) =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
r8a774b1-hihope-rzg2n-ex | arm64  | lab-cip         | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/65e1ed5fd2cd7ba48b63704c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-56-g6ff909810a18d/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ba=
seline-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-56-g6ff909810a18d/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ba=
seline-r8a774b1-hihope-rzg2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e1ed5fd2cd7ba48b637051
        failing since 219 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2024-03-01T14:59:22.693542  + set +x
    2024-03-01T14:59:22.696720  <8>[   84.179220] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1101259_1.5.2.4.1>
    2024-03-01T14:59:22.804408  / # #
    2024-03-01T14:59:24.259916  export SHELL=3D/bin/sh
    2024-03-01T14:59:24.280289  #
    2024-03-01T14:59:24.280428  / # export SHELL=3D/bin/sh
    2024-03-01T14:59:26.225811  / # . /lava-1101259/environment
    2024-03-01T14:59:29.805672  /lava-1101259/bin/lava-test-runner /lava-11=
01259/1
    2024-03-01T14:59:29.826301  . /lava-1101259/environment
    2024-03-01T14:59:29.826413  / # /lava-1101259/bin/lava-test-runner /lav=
a-1101259/1 =

    ... (15 line(s) more)  =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
r8a774c0-ek874           | arm64  | lab-cip         | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/65e1ed620861b1cb67637064

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-56-g6ff909810a18d/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ba=
seline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-56-g6ff909810a18d/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ba=
seline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e1ed620861b1cb67637069
        failing since 219 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2024-03-01T14:59:24.606424  / # #
    2024-03-01T14:59:26.061422  export SHELL=3D/bin/sh
    2024-03-01T14:59:26.081823  #
    2024-03-01T14:59:26.081995  / # export SHELL=3D/bin/sh
    2024-03-01T14:59:28.027663  / # . /lava-1101269/environment
    2024-03-01T14:59:31.608035  /lava-1101269/bin/lava-test-runner /lava-11=
01269/1
    2024-03-01T14:59:31.628723  . /lava-1101269/environment
    2024-03-01T14:59:31.628889  / # /lava-1101269/bin/lava-test-runner /lav=
a-1101269/1
    2024-03-01T14:59:31.663661  + export 'TESTRUN_ID=3D1_bootrr'
    2024-03-01T14:59:31.708752  + cd /lava-1101269/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =20

