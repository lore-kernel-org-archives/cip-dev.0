Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A51C41535
	for <webhook@archiver.kernel.org>; Fri, 10 Nov 2023 06:46:42 +0000 (UTC)
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
 by mx.groups.io with SMTP id smtpd.web11.22878.1699598797263887530
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 09 Nov 2023 22:46:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=TDF4WePg;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.161.50, mailfrom: bot@kernelci.org)
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-586ad15f9aaso855048eaf.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 09 Nov 2023 22:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1699598796; x=1700203596; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6WmQ98XCDYDFuHgf54hBCusd2ddcjoR9+9U6EDZBit8=;
        b=TDF4WePgeAry2vbX2gNQZhmVBUYTGl53EI4eNNO4EkSmnubZ53rHoQuo99w3JTDGbh
         0aJ/RHBU+4blp9gqycswZIbTT+iCOqfdYymcT6icgQASt1J7S2HI/oh56iCd40lyYBRd
         GIpgVxUhNMdNfr2TmXlW4KNbgqCvaIdWqXLjM9igZckJtWmx1x2LB1HEHOcgf2if5P1g
         TD/dUub0WkwdrO70WRoJKRinL9qhN1AHskecIJ4plJlE/q2aL5x8dzaT7NDjbW2f3HYt
         2nAeLcUwRO7pr1Wkk0eqFULGP0xyAGpxxEdRoH2+J3YbGp1HoiSecVw9J7b39pmkSRRo
         +Pqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699598796; x=1700203596;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6WmQ98XCDYDFuHgf54hBCusd2ddcjoR9+9U6EDZBit8=;
        b=ry4HMJioFtttRiVx9RErrjEQEIwsK1iccsP/hk1l+hEUg1Hcfzc4WX09bI3DoVq1un
         mv7vc5GC8c21kBaRTbt574SQbkGAvZ8gV6c7ZmkoTH3lOr4Q4MC+ogXcamQa28fIzltr
         apidqJbeqh9Rv46bv1zsx17/SGFFKdtsAX9vFWymBxSeu+3EOdnuPNxgf3kSf9Uaelh0
         4zwL3PSkiYud1S8T5Rb4Eo8AJDW6xoehPQ8cYoXwQAjBfTA/Pizk+tR/AqU7KkcYWQwY
         Fh2XHBHvsxQMrgmaHYxgJJ6o8EyErU1lhMrNLQETYua1owVQZD535YCvWV64JL9i+P9Q
         kh6Q==
X-Gm-Message-State: AOJu0YzyFnS4ZG6s8O+v/Im8gV6v63RG0icLlEStB+tmr6RqbHzD0Swu
	iaFwbMAO+yP2lgRnekPPX4u0ufUwLydYd2mSWnPOUw==
X-Google-Smtp-Source: AGHT+IEU5hSEEZ6UBDJEtn19adDGlF4yGERPISes2J09T5YoRFG7sMcxn8Wp11FBpqQcRranu5GRuA==
X-Received: by 2002:a05:6358:785:b0:168:e8a8:6760 with SMTP id n5-20020a056358078500b00168e8a86760mr6499768rwj.6.1699598795446;
        Thu, 09 Nov 2023 22:46:35 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b7-20020a63cf47000000b00588e8421fa8sm5848510pgj.84.2023.11.09.22.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 22:46:34 -0800 (PST)
Message-ID: <654dd1ca.630a0220.1c196.2111@mx.google.com>
Date: Thu, 09 Nov 2023 22:46:34 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.200-cip40
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip baseline: 98 runs,
 22 regressions (v5.10.200-cip40)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Nov 2023 06:46:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13553

cip/linux-5.10.y-cip baseline: 98 runs, 22 regressions (v5.10.200-cip40)

Regressions Summary
-------------------

platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
at91sam9g20ek            | arm   | lab-broonie     | gcc-10   | multi_v5_de=
fconfig           | 1          =

bcm2836-rpi-2-b          | arm   | lab-collabora   | gcc-10   | bcm2835_def=
config            | 1          =

beaglebone-black         | arm   | lab-broonie     | gcc-10   | multi_v7_de=
fconfig           | 1          =

beaglebone-black         | arm   | lab-broonie     | gcc-10   | omap2plus_d=
efconfig          | 1          =

fsl-ls1028a-rdb          | arm64 | lab-nxp         | gcc-10   | defconfig  =
                  | 1          =

imx6q-sabrelite          | arm   | lab-collabora   | gcc-10   | multi_v7_de=
fconfig           | 1          =

imx6qp-wandboard-revd1   | arm   | lab-pengutronix | gcc-10   | imx_v6_v7_d=
efconfig          | 1          =

imx6qp-wandboard-revd1   | arm   | lab-pengutronix | gcc-10   | multi_v7_de=
fconfig           | 1          =

imx6ul-14x14-evk         | arm   | lab-nxp         | gcc-10   | multi_v7_de=
fconfig           | 1          =

imx7d-sdb                | arm   | lab-nxp         | gcc-10   | multi_v7_de=
fconfig           | 1          =

juno-uboot               | arm64 | lab-broonie     | gcc-10   | cip://5.10.=
y-...64_defconfig | 1          =

juno-uboot               | arm64 | lab-broonie     | gcc-10   | defconfig+k=
selftest          | 1          =

r8a7743-iwg20d-q7        | arm   | lab-cip         | gcc-10   | shmobile_de=
fconfig           | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip         | gcc-10   | defconfig+k=
selftest          | 1          =

r8a774c0-ek874           | arm64 | lab-cip         | gcc-10   | defconfig  =
                  | 1          =

rk3288-veyron-jaq        | arm   | lab-collabora   | gcc-10   | multi_v7_de=
fconfig           | 4          =

rk3399-rock-pi-4b        | arm64 | lab-collabora   | gcc-10   | defconfig  =
                  | 1          =

sun50i-a64-pine64-plus   | arm64 | lab-broonie     | gcc-10   | defconfig  =
                  | 1          =

sun50i-h6-pine-h64       | arm64 | lab-collabora   | gcc-10   | defconfig  =
                  | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.200-cip40/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.200-cip40
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      166400a23a22e665f5d880a99149b73abede402d =



Test Regressions
---------------- =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
at91sam9g20ek            | arm   | lab-broonie     | gcc-10   | multi_v5_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/654dc75c01236a676defcf1a

  Results:     47 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/654dc75d01236a676defcf52
        failing since 300 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-11-10T06:01:41.791623  + set +x
    2023-11-10T06:01:41.792103  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 230845_1.5.2=
.4.1>
    2023-11-10T06:01:41.906059  / # #
    2023-11-10T06:01:42.009140  export SHELL=3D/bin/sh
    2023-11-10T06:01:42.009952  #
    2023-11-10T06:01:42.112027  / # export SHELL=3D/bin/sh. /lava-230845/en=
vironment
    2023-11-10T06:01:42.112812  =

    2023-11-10T06:01:42.214904  / # . /lava-230845/environment/lava-230845/=
bin/lava-test-runner /lava-230845/1
    2023-11-10T06:01:42.216321  =

    2023-11-10T06:01:42.219846  / # /lava-230845/bin/lava-test-runner /lava=
-230845/1 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
bcm2836-rpi-2-b          | arm   | lab-collabora   | gcc-10   | bcm2835_def=
config            | 1          =


  Details:     https://kernelci.org/test/plan/id/654dc58d32bc5b34b1efcefe

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm/bcm2835_defconfig/gcc-10/lab-collabora/baseline-bcm2836-rpi-2-b.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm/bcm2835_defconfig/gcc-10/lab-collabora/baseline-bcm2836-rpi-2-b.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/654dc58d32bc5b34b1efcf07
        failing since 107 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-11-10T06:00:34.914544  / # #

    2023-11-10T06:00:35.016688  export SHELL=3D/bin/sh

    2023-11-10T06:00:35.017441  #

    2023-11-10T06:00:35.118845  / # export SHELL=3D/bin/sh. /lava-11982328/=
environment

    2023-11-10T06:00:35.119557  =


    2023-11-10T06:00:35.221000  / # . /lava-11982328/environment/lava-11982=
328/bin/lava-test-runner /lava-11982328/1

    2023-11-10T06:00:35.222144  =


    2023-11-10T06:00:35.238528  / # /lava-11982328/bin/lava-test-runner /la=
va-11982328/1

    2023-11-10T06:00:35.346685  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-10T06:00:35.347199  + cd /lava-11982328/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
beaglebone-black         | arm   | lab-broonie     | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/654dc66ebcfe75d3ccefcf30

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/654dc66ebcfe75d3ccefcf61
        failing since 300 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-11-10T05:57:19.824896  <8>[   23.093912] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 230839_1.5.2.4.1>
    2023-11-10T05:57:19.932573  / # #
    2023-11-10T05:57:20.035041  export SHELL=3D/bin/sh
    2023-11-10T05:57:20.035702  #
    2023-11-10T05:57:20.137585  / # export SHELL=3D/bin/sh. /lava-230839/en=
vironment
    2023-11-10T05:57:20.138236  =

    2023-11-10T05:57:20.240164  / # . /lava-230839/environment/lava-230839/=
bin/lava-test-runner /lava-230839/1
    2023-11-10T05:57:20.241052  =

    2023-11-10T05:57:20.246008  / # /lava-230839/bin/lava-test-runner /lava=
-230839/1
    2023-11-10T05:57:20.335364  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
beaglebone-black         | arm   | lab-broonie     | gcc-10   | omap2plus_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/654dc7ea51e84649bfefcf10

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/654dc7ea51e84649bfefcf47
        failing since 300 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-11-10T06:04:07.661862  <8>[   16.183936] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 230860_1.5.2.4.1>
    2023-11-10T06:04:07.770347  / # #
    2023-11-10T06:04:07.872371  export SHELL=3D/bin/sh
    2023-11-10T06:04:07.872895  #
    2023-11-10T06:04:07.974267  / # export SHELL=3D/bin/sh. /lava-230860/en=
vironment
    2023-11-10T06:04:07.975029  =

    2023-11-10T06:04:08.076604  / # . /lava-230860/environment/lava-230860/=
bin/lava-test-runner /lava-230860/1
    2023-11-10T06:04:08.077337  =

    2023-11-10T06:04:08.080793  / # /lava-230860/bin/lava-test-runner /lava=
-230860/1
    2023-11-10T06:04:08.189726  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
fsl-ls1028a-rdb          | arm64 | lab-nxp         | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/654dcad09f896464b0efcf20

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1028a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1028a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/654dcad09f896464b0efcf27
        failing since 241 days (last pass: v5.10.155-cip21, first fail: v5.=
10.173-cip28)

    2023-11-10T06:16:22.999896  [   23.725567] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1258019_1.5.2.4.1>
    2023-11-10T06:16:23.105553  =

    2023-11-10T06:16:23.206846  / # #export SHELL=3D/bin/sh
    2023-11-10T06:16:23.207471  =

    2023-11-10T06:16:23.308564  / # export SHELL=3D/bin/sh. /lava-1258019/e=
nvironment
    2023-11-10T06:16:23.308925  =

    2023-11-10T06:16:23.409772  / # . /lava-1258019/environment/lava-125801=
9/bin/lava-test-runner /lava-1258019/1
    2023-11-10T06:16:23.410572  =

    2023-11-10T06:16:23.414638  / # /lava-1258019/bin/lava-test-runner /lav=
a-1258019/1
    2023-11-10T06:16:23.433403  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
imx6q-sabrelite          | arm   | lab-collabora   | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/654dc63f8969ad15e2efcf6c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/654dc63f8969ad15e2efcf75
        failing since 300 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-11-10T05:57:17.230561  / # #

    2023-11-10T05:57:17.332579  export SHELL=3D/bin/sh

    2023-11-10T05:57:17.333266  #

    2023-11-10T05:57:17.434729  / # export SHELL=3D/bin/sh. /lava-11982365/=
environment

    2023-11-10T05:57:17.435407  =


    2023-11-10T05:57:17.536838  / # . /lava-11982365/environment/lava-11982=
365/bin/lava-test-runner /lava-11982365/1

    2023-11-10T05:57:17.537885  =


    2023-11-10T05:57:17.539418  / # /lava-11982365/bin/lava-test-runner /la=
va-11982365/1

    2023-11-10T05:57:17.603525  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-10T05:57:17.645532  + cd /lava-11982365/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
imx6qp-wandboard-revd1   | arm   | lab-pengutronix | gcc-10   | imx_v6_v7_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/654dc7324e64d4d1f3efcf30

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandb=
oard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandb=
oard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/654dc7324e64d4d1f3efcf39
        failing since 300 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-11-10T06:00:57.218537  + set +x
    2023-11-10T06:00:57.218963  [   10.307462] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1008081_1.5.2.3.1>
    2023-11-10T06:00:57.326969  / # #
    2023-11-10T06:00:57.429119  export SHELL=3D/bin/sh
    2023-11-10T06:00:57.429754  #
    2023-11-10T06:00:57.531333  / # export SHELL=3D/bin/sh. /lava-1008081/e=
nvironment
    2023-11-10T06:00:57.531908  =

    2023-11-10T06:00:57.633422  / # . /lava-1008081/environment/lava-100808=
1/bin/lava-test-runner /lava-1008081/1
    2023-11-10T06:00:57.634271  =

    2023-11-10T06:00:57.637261  / # /lava-1008081/bin/lava-test-runner /lav=
a-1008081/1 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
imx6qp-wandboard-revd1   | arm   | lab-pengutronix | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/654dc607cce6da1b90efcf09

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandbo=
ard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandbo=
ard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/654dc607cce6da1b90efcf12
        failing since 300 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-11-10T05:56:15.602667  + set[    7.324807] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 1008077_1.5.2.3.1>
    2023-11-10T05:56:15.602851   +x
    2023-11-10T05:56:15.708135  / # #
    2023-11-10T05:56:15.809733  export SHELL=3D/bin/sh
    2023-11-10T05:56:15.810248  #
    2023-11-10T05:56:15.911699  / # export SHELL=3D/bin/sh. /lava-1008077/e=
nvironment
    2023-11-10T05:56:15.912205  =

    2023-11-10T05:56:16.013473  / # . /lava-1008077/environment/lava-100807=
7/bin/lava-test-runner /lava-1008077/1
    2023-11-10T05:56:16.014117  =

    2023-11-10T05:56:16.016546  / # /lava-1008077/bin/lava-test-runner /lav=
a-1008077/1 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
imx6ul-14x14-evk         | arm   | lab-nxp         | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/654dc6488969ad15e2efcf7a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx6ul-14x14-evk.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx6ul-14x14-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/654dc6488969ad15e2efcf81
        failing since 232 days (last pass: v5.10.145-cip17, first fail: v5.=
10.175-cip29)

    2023-11-10T05:57:01.780580  + set +x
    2023-11-10T05:57:01.783706  <8>[   29.685459] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1258012_1.5.2.4.1>
    2023-11-10T05:57:01.891724  / # #
    2023-11-10T05:57:03.048701  export SHELL=3D/bin/sh
    2023-11-10T05:57:03.054416  #
    2023-11-10T05:57:04.596189  / # export SHELL=3D/bin/sh. /lava-1258012/e=
nvironment
    2023-11-10T05:57:04.601699  =

    2023-11-10T05:57:07.413833  / # . /lava-1258012/environment/lava-125801=
2/bin/lava-test-runner /lava-1258012/1
    2023-11-10T05:57:07.420109  =

    2023-11-10T05:57:07.421616  / # /lava-1258012/bin/lava-test-runner /lav=
a-1258012/1 =

    ... (18 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
imx7d-sdb                | arm   | lab-nxp         | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/654dc65abcfe75d3ccefcf02

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/654dc65abcfe75d3ccefcf09
        failing since 300 days (last pass: v5.10.155-cip21, first fail: v5.=
10.162-cip24)

    2023-11-10T05:57:18.743222  / # #
    2023-11-10T05:57:19.899591  export SHELL=3D/bin/sh
    2023-11-10T05:57:19.905317  #
    2023-11-10T05:57:21.447639  / # export SHELL=3D/bin/sh. /lava-1258014/e=
nvironment
    2023-11-10T05:57:21.453349  =

    2023-11-10T05:57:21.453672  / # . /lava-1258014/environment
    2023-11-10T05:57:24.265763  / # /lava-1258014/bin/lava-test-runner /lav=
a-1258014/1
    2023-11-10T05:57:24.282466  /lava-1258014/bin/lava-test-runner /lava-12=
58014/1
    2023-11-10T05:57:24.369228  + export 'TESTRUN_ID=3D1_bootrr'
    2023-11-10T05:57:24.369622  + cd /lava-1258014/1/tests/1_bootrr =

    ... (19 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
juno-uboot               | arm64 | lab-broonie     | gcc-10   | cip://5.10.=
y-...64_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/654dc861f705ebfd1eefcef3

  Results:     47 PASS, 13 FAIL, 1 SKIP
  Full config: cip://5.10.y-cip/arm64/qemu_arm64_defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm64/cip---5.10.y-cip-arm64-qemu_arm64_defconfig/gcc-10/lab-broonie=
/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm64/cip---5.10.y-cip-arm64-qemu_arm64_defconfig/gcc-10/lab-broonie=
/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/654dc861f705ebfd1eefcf30
        failing since 74 days (last pass: v5.10.186-cip37-27-gd6d928db0a620=
, first fail: v5.10.191-cip38)

    2023-11-10T06:05:49.463738  <8>[   15.613803] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 230859_1.5.2.4.1>
    2023-11-10T06:05:49.573246  / # #
    2023-11-10T06:05:49.676306  export SHELL=3D/bin/sh
    2023-11-10T06:05:49.677087  #
    2023-11-10T06:05:49.779059  / # export SHELL=3D/bin/sh. /lava-230859/en=
vironment
    2023-11-10T06:05:49.779836  =

    2023-11-10T06:05:49.881843  / # . /lava-230859/environment/lava-230859/=
bin/lava-test-runner /lava-230859/1
    2023-11-10T06:05:49.883217  =

    2023-11-10T06:05:49.896026  / # /lava-230859/bin/lava-test-runner /lava=
-230859/1
    2023-11-10T06:05:49.952803  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
juno-uboot               | arm64 | lab-broonie     | gcc-10   | defconfig+k=
selftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/654dcc2165f9456fa7efcf72

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm64/defconfig+kselftest/gcc-10/lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm64/defconfig+kselftest/gcc-10/lab-broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/654dcc2165f9456fa7efcfb2
        failing since 107 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-11-10T06:21:55.900416  <8>[   19.388758] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 230919_1.5.2.4.1>
    2023-11-10T06:21:56.008316  / # #
    2023-11-10T06:21:56.111171  export SHELL=3D/bin/sh
    2023-11-10T06:21:56.111953  #
    2023-11-10T06:21:56.213786  / # export SHELL=3D/bin/sh. /lava-230919/en=
vironment
    2023-11-10T06:21:56.214578  =

    2023-11-10T06:21:56.316507  / # . /lava-230919/environment/lava-230919/=
bin/lava-test-runner /lava-230919/1
    2023-11-10T06:21:56.317738  =

    2023-11-10T06:21:56.331736  / # /lava-230919/bin/lava-test-runner /lava=
-230919/1
    2023-11-10T06:21:56.507340  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (13 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
r8a7743-iwg20d-q7        | arm   | lab-cip         | gcc-10   | shmobile_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/654dc6308969ad15e2efcf5d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/654dc6308969ad15e2efc=
f5e
        failing since 57 days (last pass: v5.10.191-cip38-2-g09e5ecd8645b, =
first fail: v5.10.191-cip38-17-g8dad6b499cfe5) =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip         | gcc-10   | defconfig+k=
selftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/654dcd89ce4335ea76efcf01

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-r8a774a1-hihope-rz=
g2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-r8a774a1-hihope-rz=
g2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/654dcd89ce4335ea76efcf0a
        failing since 93 days (last pass: v5.10.182-cip35, first fail: v5.1=
0.186-cip37-13-g260094841fe1a)

    2023-11-10T06:27:55.895381  + set +x
    2023-11-10T06:27:55.898622  <8>[   87.662320] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1036409_1.5.2.4.1>
    2023-11-10T06:27:56.011298  / # #
    2023-11-10T06:27:57.469929  export SHELL=3D/bin/sh
    2023-11-10T06:27:57.490707  #
    2023-11-10T06:27:57.491119  / # export SHELL=3D/bin/sh
    2023-11-10T06:27:59.441009  / # . /lava-1036409/environment
    2023-11-10T06:28:03.028492  /lava-1036409/bin/lava-test-runner /lava-10=
36409/1
    2023-11-10T06:28:03.049752  . /lava-1036409/environment
    2023-11-10T06:28:03.050115  / # /lava-1036409/bin/lava-test-runner /lav=
a-1036409/1 =

    ... (27 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
r8a774c0-ek874           | arm64 | lab-cip         | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/654dcb30bee6a812b4efcf68

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/654dcb30bee6a812b4efcf71
        failing since 107 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-11-10T06:18:07.139443  / # #
    2023-11-10T06:18:08.596616  export SHELL=3D/bin/sh
    2023-11-10T06:18:08.617567  #
    2023-11-10T06:18:08.618149  / # export SHELL=3D/bin/sh
    2023-11-10T06:18:10.567288  / # . /lava-1036399/environment
    2023-11-10T06:18:14.153836  /lava-1036399/bin/lava-test-runner /lava-10=
36399/1
    2023-11-10T06:18:14.175433  . /lava-1036399/environment
    2023-11-10T06:18:14.175796  / # /lava-1036399/bin/lava-test-runner /lav=
a-1036399/1
    2023-11-10T06:18:14.254335  + export 'TESTRUN_ID=3D1_bootrr'
    2023-11-10T06:18:14.254872  + cd /lava-1036399/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
rk3288-veyron-jaq        | arm   | lab-collabora   | gcc-10   | multi_v7_de=
fconfig           | 4          =


  Details:     https://kernelci.org/test/plan/id/654dc61a8969ad15e2efcf00

  Results:     63 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-j=
aq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-j=
aq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/654dc61a8969ad15e2efcf08
        failing since 298 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-11-10T06:02:50.811479  <8>[    8.528261] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-11-10T06:02:50.820457  + <8>[    8.540693] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11982370_1.5.2.3.1>

    2023-11-10T06:02:50.821690  set +x

    2023-11-10T06:02:50.927026  =


    2023-11-10T06:02:51.027686  / # #export SHELL=3D/bin/sh

    2023-11-10T06:02:51.027897  =


    2023-11-10T06:02:51.027966  / # <6>[    8.675522] sbs-battery 20-000b: =
Disabling PEC because of broken Cros-EC implementation

    2023-11-10T06:02:51.028017  export SHELL=3D/bin/sh<4>[    8.712436] sbs=
-battery 20-000b: Unknown chemistry: POLY

    2023-11-10T06:02:51.128497  . /lava-11982370/environment

    2023-11-10T06:02:51.128713  =

 =

    ... (26 line(s) more)  =


  * baseline.bootrr.dwhdmi-rockchip-driver-i2c-present: https://kernelci.or=
g/test/case/id/654dc61a8969ad15e2efcf35
        failing since 298 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-11-10T06:03:02.913535  FIRST,<8>[   20.626041] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>

    2023-11-10T06:03:02.915370   INC default to 1.

    2023-11-10T06:03:02.915426  =


    2023-11-10T06:03:02.918979  	-w	Pad to last with leading zeros

    2023-11-10T06:03:02.921378  	-s SEP	String separator

    2023-11-10T06:03:02.925484  /lava-11982370/1/../bin/lava-test-case

    2023-11-10T06:03:02.931409  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.

    2023-11-10T06:03:02.931673  =


    2023-11-10T06:03:02.941741  Usag<8>[   20.655100] <LAVA_SIGNAL_TESTCASE=
 TEST_CASE_ID=3Ddwhdmi-rockchip-driver-i2c-present RESULT=3Dfail>
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/654dc61a8969ad15e2efcf36
        failing since 298 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-11-10T06:03:02.890971  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC)<8=
>[   20.606992] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-11-10T06:03:02.893064   multi-call binary.

    2023-11-10T06:03:02.893299  =


    2023-11-10T06:03:02.897414  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-11-10T06:03:02.897635  =


    2023-11-10T06:03:02.902828  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/654dc61a8969ad15e2efcf37
        failing since 298 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24) =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
rk3399-rock-pi-4b        | arm64 | lab-collabora   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/654dca8f7208dc65efefcf66

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/654dca8f7208dc65efefcf6f
        failing since 51 days (last pass: v5.10.191-cip38-29-g9e1aa2001db8,=
 first fail: v5.10.194-cip39)

    2023-11-10T06:15:32.694199  / # #

    2023-11-10T06:15:33.954921  export SHELL=3D/bin/sh

    2023-11-10T06:15:33.965837  #

    2023-11-10T06:15:33.966300  / # export SHELL=3D/bin/sh

    2023-11-10T06:15:35.710163  / # . /lava-11982462/environment

    2023-11-10T06:15:38.915006  /lava-11982462/bin/lava-test-runner /lava-1=
1982462/1

    2023-11-10T06:15:38.926410  . /lava-11982462/environment

    2023-11-10T06:15:38.926775  / # /lava-11982462/bin/lava-test-runner /la=
va-11982462/1

    2023-11-10T06:15:38.980675  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-10T06:15:38.981103  + cd /lava-11982462/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
sun50i-a64-pine64-plus   | arm64 | lab-broonie     | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/654dcab4d8fbd2486cefcf30

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/654dcab4d8fbd2486cefcf60
        failing since 300 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-11-10T06:15:52.872079  + set +x
    2023-11-10T06:15:52.876102  <8>[   17.008269] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 230874_1.5.2.4.1>
    2023-11-10T06:15:52.985109  / # #
    2023-11-10T06:15:53.086286  export SHELL=3D/bin/sh
    2023-11-10T06:15:53.086698  #
    2023-11-10T06:15:53.187878  / # export SHELL=3D/bin/sh. /lava-230874/en=
vironment
    2023-11-10T06:15:53.188244  =

    2023-11-10T06:15:53.289296  / # . /lava-230874/environment/lava-230874/=
bin/lava-test-runner /lava-230874/1
    2023-11-10T06:15:53.290043  =

    2023-11-10T06:15:53.293869  / # /lava-230874/bin/lava-test-runner /lava=
-230874/1 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
sun50i-h6-pine-h64       | arm64 | lab-collabora   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/654dca79dccfa486dfefcf6c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/654dca79dccfa486dfefcf75
        failing since 107 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-11-10T06:21:38.353398  / # #

    2023-11-10T06:21:38.454302  export SHELL=3D/bin/sh

    2023-11-10T06:21:38.455006  #

    2023-11-10T06:21:38.556218  / # export SHELL=3D/bin/sh. /lava-11982447/=
environment

    2023-11-10T06:21:38.556910  =


    2023-11-10T06:21:38.658119  / # . /lava-11982447/environment/lava-11982=
447/bin/lava-test-runner /lava-11982447/1

    2023-11-10T06:21:38.658340  =


    2023-11-10T06:21:38.701338  / # /lava-11982447/bin/lava-test-runner /la=
va-11982447/1

    2023-11-10T06:21:38.730443  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-10T06:21:38.730558  + cd /lava-1198244<8>[   18.212866] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11982447_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

