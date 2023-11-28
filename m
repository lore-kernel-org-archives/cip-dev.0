Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309FBC46CA0
	for <webhook@archiver.kernel.org>; Tue, 28 Nov 2023 23:47:08 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
 by mx.groups.io with SMTP id smtpd.web11.14607.1701215218259193987
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 28 Nov 2023 15:46:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=bPWRr2AZ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.181, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6cbd24d9557so254283b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 28 Nov 2023 15:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701215217; x=1701820017; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FtGbHwgmm7VslqWZZUYuVQ61ij4hDLLj61+uqnlpShg=;
        b=bPWRr2AZwproWWpaUK4bVwOQjfsBzalyhbJj7mhkUzugEo8YPG2jcgwZ2Xbq/zpQr6
         qtc+byb79X7FknhyQJ3JVXUZFN0FqLd3/a41MK9nylGuI9/N8Ah16F1PgZI2JG14eCXe
         fQsFaH7gJHczuSELAeylxZKIAwlk8Efk6QVdfe+m4WgGMQWZHGHhUblxIVF6rWXuvT4K
         XYnJU5W5x2bAzfbotwdHdLbYiGtvLLl2GuUXzkfro15waMvtjgqBen34orm2PxIWQPdk
         gJtsgLlPZY5s8DpaI5z3kpWFAYdDiE2+cy4VZBLKPw6npTJsFMoXSBvw83YZ3WwZkfkr
         /3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701215217; x=1701820017;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FtGbHwgmm7VslqWZZUYuVQ61ij4hDLLj61+uqnlpShg=;
        b=wL6wYN71ABDdEJNtsVZgvq4V559hvoGxjE0CAJ7PjV7RWRRnryG2/KrQfMD5pt0pss
         CglcSIIRby8xdG3tKVS9AeiBk4lCxb2JrWo7ZJNDFrm9SH+22b+nANtBXdZsbDLYlEdx
         jTGkd1lWKVSizQ+SBklxQ5NzCIzUy93ZYrvd8sOQOm4lRe5bp62/ABWBsHIWPdgILY90
         H9eVYp6qdRbNajxJ+Tsfi/X8qO4XKW8g1Zvx9v897U4AHVYzkmfRdLq/f7Kzbvo6bKBL
         bceqQJB3ORyX/OdFAY2ETc8lDYeam/sQ192AR+fBdVob6qExp2indBQ0hBm/knIeZvAZ
         vpNw==
X-Gm-Message-State: AOJu0YwUaGX84qTxbLoAAsp2B/pCbe9HpNcZws7DqOUyHWUfmJEq4v/a
	f22Cs+Pw6Az1kQi/ltpuF9FnAJ7sxceByghmcF8=
X-Google-Smtp-Source: AGHT+IHWyz6mIXtlDC92Z1G2osMVGrVGMxbEQYthAjXMeKqoR8H5sHVSjvqDOvDuDJ/dkdPWzY3PZQ==
X-Received: by 2002:a05:6a00:488a:b0:6c4:d4b1:b535 with SMTP id dk10-20020a056a00488a00b006c4d4b1b535mr23531448pfb.9.1701215216431;
        Tue, 28 Nov 2023 15:46:56 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p126-20020a634284000000b005b9288d51f0sm10170159pga.48.2023.11.28.15.46.55
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 15:46:55 -0800 (PST)
Message-ID: <65667bef.630a0220.b8ca3.96c2@mx.google.com>
Date: Tue, 28 Nov 2023 15:46:55 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.201-cip41-197-g2d08925b44e52
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 175 runs,
 20 regressions (v5.10.201-cip41-197-g2d08925b44e52)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Nov 2023 23:47:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13751

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 175 runs, 20 regressio=
ns (v5.10.201-cip41-197-g2d08925b44e52)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
bcm2836-rpi-2-b          | arm   | lab-collabora | gcc-10   | bcm2835_defco=
nfig            | 1          =

beaglebone-black         | arm   | lab-broonie   | gcc-10   | omap2plus_def=
config          | 1          =

beaglebone-black         | arm   | lab-cip       | gcc-10   | omap2plus_def=
config          | 1          =

juno-uboot               | arm64 | lab-broonie   | gcc-10   | defconfig+kse=
lftest          | 1          =

juno-uboot               | arm64 | lab-broonie   | gcc-10   | defconfig    =
                | 1          =

r8a7743-iwg20d-q7        | arm   | lab-cip       | gcc-10   | shmobile_defc=
onfig           | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook   | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
                | 1          =

r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook   | 1          =

r8a774c0-ek874           | arm64 | lab-cip       | gcc-10   | defconfig+kse=
lftest          | 1          =

r8a774c0-ek874           | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook   | 1          =

r8a774c0-ek874           | arm64 | lab-cip       | gcc-10   | defconfig    =
                | 1          =

r8a77960-ulcb            | arm64 | lab-collabora | gcc-10   | defconfig    =
                | 1          =

rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
...ok+kselftest | 2          =

rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook   | 2          =

rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig+kse=
lftest          | 1          =

rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig    =
                | 1          =

sun50i-h6-pine-h64       | arm64 | lab-collabora | gcc-10   | defconfig    =
                | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.201-cip41-197-g2d08925b44e52/plan/baselin=
e/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.201-cip41-197-g2d08925b44e52
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      2d08925b44e52ce450bf165f843637412f9c979b =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
bcm2836-rpi-2-b          | arm   | lab-collabora | gcc-10   | bcm2835_defco=
nfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/65666d511835b717867e4aff

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm/bcm2835_defconfig/gcc-1=
0/lab-collabora/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm/bcm2835_defconfig/gcc-1=
0/lab-collabora/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65666d511835b717867e4b08
        failing since 124 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-11-28T22:50:45.955349  / # #

    2023-11-28T22:50:46.057386  export SHELL=3D/bin/sh

    2023-11-28T22:50:46.058126  #

    2023-11-28T22:50:46.159483  / # export SHELL=3D/bin/sh. /lava-12110075/=
environment

    2023-11-28T22:50:46.160188  =


    2023-11-28T22:50:46.261670  / # . /lava-12110075/environment/lava-12110=
075/bin/lava-test-runner /lava-12110075/1

    2023-11-28T22:50:46.262864  =


    2023-11-28T22:50:46.279599  / # /lava-12110075/bin/lava-test-runner /la=
va-12110075/1

    2023-11-28T22:50:46.343389  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-28T22:50:46.387416  + cd /lava-12110075/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
beaglebone-black         | arm   | lab-broonie   | gcc-10   | omap2plus_def=
config          | 1          =


  Details:     https://kernelci.org/test/plan/id/65666eb551b3db6a2a7e4a88

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm/omap2plus_defconfig/gcc=
-10/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm/omap2plus_defconfig/gcc=
-10/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65666eb551b3db6a2a7e4ac1
        failing since 328 days (last pass: v5.10.155-cip21-405-g26d566555c3=
de, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2023-11-28T22:50:09.215017  <8>[   18.767401] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 284271_1.5.2.4.1>
    2023-11-28T22:50:09.321415  / # #
    2023-11-28T22:50:09.422923  export SHELL=3D/bin/sh
    2023-11-28T22:50:09.423373  #
    2023-11-28T22:50:09.524590  / # export SHELL=3D/bin/sh. /lava-284271/en=
vironment
    2023-11-28T22:50:09.525056  =

    2023-11-28T22:50:09.626290  / # . /lava-284271/environment/lava-284271/=
bin/lava-test-runner /lava-284271/1
    2023-11-28T22:50:09.626933  =

    2023-11-28T22:50:09.631632  / # /lava-284271/bin/lava-test-runner /lava=
-284271/1
    2023-11-28T22:50:09.736036  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
beaglebone-black         | arm   | lab-cip       | gcc-10   | omap2plus_def=
config          | 1          =


  Details:     https://kernelci.org/test/plan/id/65666e541f388a4b047e4a73

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm/omap2plus_defconfig/gcc=
-10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm/omap2plus_defconfig/gcc=
-10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65666e541f388a4b047e4aab
        failing since 328 days (last pass: v5.10.155-cip21-405-g26d566555c3=
de, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2023-11-28T22:48:38.150612  <8>[   13.001592] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1047679_1.5.2.4.1>
    2023-11-28T22:48:38.261922  / # #
    2023-11-28T22:48:38.363568  export SHELL=3D/bin/sh
    2023-11-28T22:48:38.364223  #
    2023-11-28T22:48:38.465491  / # export SHELL=3D/bin/sh. /lava-1047679/e=
nvironment
    2023-11-28T22:48:38.466130  =

    2023-11-28T22:48:38.567424  / # . /lava-1047679/environment/lava-104767=
9/bin/lava-test-runner /lava-1047679/1
    2023-11-28T22:48:38.568482  =

    2023-11-28T22:48:38.576417  / # /lava-1047679/bin/lava-test-runner /lav=
a-1047679/1
    2023-11-28T22:48:38.669747  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
juno-uboot               | arm64 | lab-broonie   | gcc-10   | defconfig+kse=
lftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/65666ed0afbfada4747e4a6f

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig+kselftest/g=
cc-10/lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig+kselftest/g=
cc-10/lab-broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65666ed0afbfada4747e4aaf
        failing since 68 days (last pass: v5.10.191-cip38-661-g112a3073ff26=
, first fail: v5.10.194-cip39-407-g664623343843d)

    2023-11-28T22:50:21.096760  <8>[   18.098128] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 284248_1.5.2.4.1>
    2023-11-28T22:50:21.204544  / # #
    2023-11-28T22:50:21.307303  export SHELL=3D/bin/sh
    2023-11-28T22:50:21.308046  #
    2023-11-28T22:50:21.409909  / # export SHELL=3D/bin/sh. /lava-284248/en=
vironment
    2023-11-28T22:50:21.410689  =

    2023-11-28T22:50:21.512615  / # . /lava-284248/environment/lava-284248/=
bin/lava-test-runner /lava-284248/1
    2023-11-28T22:50:21.513898  =

    2023-11-28T22:50:21.528203  / # /lava-284248/bin/lava-test-runner /lava=
-284248/1
    2023-11-28T22:50:21.704964  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
juno-uboot               | arm64 | lab-broonie   | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/6566744974ca7e38277e4a7d

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig/gcc-10/lab-=
broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig/gcc-10/lab-=
broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6566744974ca7e38277e4abc
        new failure (last pass: v5.10.200-cip40-188-g33d0b44cd71d)

    2023-11-28T23:14:01.089994  / # #
    2023-11-28T23:14:01.193084  export SHELL=3D/bin/sh
    2023-11-28T23:14:01.193885  #
    2023-11-28T23:14:01.295879  / # export SHELL=3D/bin/sh. /lava-284367/en=
vironment
    2023-11-28T23:14:01.296693  =

    2023-11-28T23:14:01.398742  / # . /lava-284367/environment/lava-284367/=
bin/lava-test-runner /lava-284367/1
    2023-11-28T23:14:01.400131  =

    2023-11-28T23:14:01.412817  / # /lava-284367/bin/lava-test-runner /lava=
-284367/1
    2023-11-28T23:14:01.472671  + export 'TESTRUN_ID=3D1_bootrr'
    2023-11-28T23:14:01.473188  + cd /lava-284367/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a7743-iwg20d-q7        | arm   | lab-cip       | gcc-10   | shmobile_defc=
onfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65666e751f388a4b047e4aba

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm/shmobile_defconfig/gcc-=
10/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm/shmobile_defconfig/gcc-=
10/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65666e751f388a4b047e4=
abb
        failing since 6 days (last pass: v5.10.194-cip39-915-g96fa7f16cf02,=
 first fail: v5.10.200-cip40-188-g33d0b44cd71d) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/656670d497fc5aefab7e4a6e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656670d497fc5aefab7e4a77
        failing since 124 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-11-28T22:59:09.911187  + set +x
    2023-11-28T22:59:09.914481  <8>[   83.800604] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1047720_1.5.2.4.1>
    2023-11-28T22:59:10.023728  / # #
    2023-11-28T22:59:11.481299  export SHELL=3D/bin/sh
    2023-11-28T22:59:11.502201  #
    2023-11-28T22:59:11.502644  / # export SHELL=3D/bin/sh
    2023-11-28T22:59:13.451248  / # . /lava-1047720/environment
    2023-11-28T22:59:17.036186  /lava-1047720/bin/lava-test-runner /lava-10=
47720/1
    2023-11-28T22:59:17.057551  . /lava-1047720/environment
    2023-11-28T22:59:17.057919  / # /lava-1047720/bin/lava-test-runner /lav=
a-1047720/1 =

    ... (28 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/656674a9083f9c8f4f7e4b68

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig/gcc-10/lab-=
cip/baseline-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig/gcc-10/lab-=
cip/baseline-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656674a9083f9c8f4f7e4b71
        failing since 90 days (last pass: v5.10.180-cip33-21-g090289427e8b2=
, first fail: v5.10.191-cip38-218-g9947ff6f0dba7)

    2023-11-28T23:15:35.507946  + set +x
    2023-11-28T23:15:35.511215  <8>[   83.997466] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1047748_1.5.2.4.1>
    2023-11-28T23:15:35.620230  / # #
    2023-11-28T23:15:37.075940  export SHELL=3D/bin/sh
    2023-11-28T23:15:37.096722  #
    2023-11-28T23:15:37.097113  / # export SHELL=3D/bin/sh
    2023-11-28T23:15:39.045403  / # . /lava-1047748/environment
    2023-11-28T23:15:42.630521  /lava-1047748/bin/lava-test-runner /lava-10=
47748/1
    2023-11-28T23:15:42.651728  . /lava-1047748/environment
    2023-11-28T23:15:42.652096  / # /lava-1047748/bin/lava-test-runner /lav=
a-1047748/1 =

    ... (28 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/656673b23b77bb3bdd7e4a83

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-r8a774b1-hihope-rzg2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656673b23b77bb3bdd7e4a8c
        failing since 124 days (last pass: v5.10.182-cip35-289-g3c054954070=
6, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-11-28T23:11:19.555434  + set +x
    2023-11-28T23:11:19.558623  <8>[   84.229602] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1047728_1.5.2.4.1>
    2023-11-28T23:11:19.666722  / # #
    2023-11-28T23:11:21.124885  export SHELL=3D/bin/sh
    2023-11-28T23:11:21.145709  #
    2023-11-28T23:11:21.146094  / # export SHELL=3D/bin/sh
    2023-11-28T23:11:23.095331  / # . /lava-1047728/environment
    2023-11-28T23:11:26.680246  /lava-1047728/bin/lava-test-runner /lava-10=
47728/1
    2023-11-28T23:11:26.701499  . /lava-1047728/environment
    2023-11-28T23:11:26.701856  / # /lava-1047728/bin/lava-test-runner /lav=
a-1047728/1 =

    ... (15 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a774c0-ek874           | arm64 | lab-cip       | gcc-10   | defconfig+kse=
lftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/65666e123dc88d745f7e4abe

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig+kselftest/g=
cc-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig+kselftest/g=
cc-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65666e123dc88d745f7e4ac7
        failing since 124 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-11-28T22:47:21.367510  / # #
    2023-11-28T22:47:22.825537  export SHELL=3D/bin/sh
    2023-11-28T22:47:22.846349  #
    2023-11-28T22:47:22.846774  / # export SHELL=3D/bin/sh
    2023-11-28T22:47:24.795923  / # . /lava-1047668/environment
    2023-11-28T22:47:28.382191  /lava-1047668/bin/lava-test-runner /lava-10=
47668/1
    2023-11-28T22:47:28.403653  . /lava-1047668/environment
    2023-11-28T22:47:28.404018  / # /lava-1047668/bin/lava-test-runner /lav=
a-1047668/1
    2023-11-28T22:47:28.583332  + export 'TESTRUN_ID=3D1_bootrr'
    2023-11-28T22:47:28.583798  + cd /lava-1047668/1/tests/1_bootrr =

    ... (24 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a774c0-ek874           | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6566729aeb5caa94187e4a8a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6566729aeb5caa94187e4a93
        failing since 124 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-11-28T23:06:38.187752  / # #
    2023-11-28T23:06:39.645087  export SHELL=3D/bin/sh
    2023-11-28T23:06:39.666094  #
    2023-11-28T23:06:39.666584  / # export SHELL=3D/bin/sh
    2023-11-28T23:06:41.616508  / # . /lava-1047731/environment
    2023-11-28T23:06:45.201993  /lava-1047731/bin/lava-test-runner /lava-10=
47731/1
    2023-11-28T23:06:45.223129  . /lava-1047731/environment
    2023-11-28T23:06:45.223339  / # /lava-1047731/bin/lava-test-runner /lav=
a-1047731/1
    2023-11-28T23:06:45.301527  + export 'TESTRUN_ID=3D1_bootrr'
    2023-11-28T23:06:45.302007  + cd /lava-1047731/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a774c0-ek874           | arm64 | lab-cip       | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/6566743e0b48754cf47e4a6d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig/gcc-10/lab-=
cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig/gcc-10/lab-=
cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6566743e0b48754cf47e4a76
        failing since 124 days (last pass: v5.10.182-cip35-289-g3c054954070=
6, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-11-28T23:13:53.748910  / # #
    2023-11-28T23:13:55.207441  export SHELL=3D/bin/sh
    2023-11-28T23:13:55.228317  #
    2023-11-28T23:13:55.228762  / # export SHELL=3D/bin/sh
    2023-11-28T23:13:57.177507  / # . /lava-1047750/environment
    2023-11-28T23:14:00.762527  /lava-1047750/bin/lava-test-runner /lava-10=
47750/1
    2023-11-28T23:14:00.784000  . /lava-1047750/environment
    2023-11-28T23:14:00.784420  / # /lava-1047750/bin/lava-test-runner /lav=
a-1047750/1
    2023-11-28T23:14:00.864796  + export 'TESTRUN_ID=3D1_bootrr'
    2023-11-28T23:14:00.865327  + cd /lava-1047750/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a77960-ulcb            | arm64 | lab-collabora | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/656672ca0a05a0ecc17e4ade

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig/gcc-10/lab-=
collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig/gcc-10/lab-=
collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656672ca0a05a0ecc17e4ae7
        failing since 124 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-11-28T23:13:59.351741  / # #

    2023-11-28T23:13:59.453937  export SHELL=3D/bin/sh

    2023-11-28T23:13:59.454656  #

    2023-11-28T23:13:59.555990  / # export SHELL=3D/bin/sh. /lava-12110235/=
environment

    2023-11-28T23:13:59.556697  =


    2023-11-28T23:13:59.658163  / # . /lava-12110235/environment/lava-12110=
235/bin/lava-test-runner /lava-12110235/1

    2023-11-28T23:13:59.659253  =


    2023-11-28T23:13:59.676278  / # /lava-12110235/bin/lava-test-runner /la=
va-12110235/1

    2023-11-28T23:13:59.725276  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-28T23:13:59.725778  + cd /lav<8>[   16.436744] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12110235_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
...ok+kselftest | 2          =


  Details:     https://kernelci.org/test/plan/id/65666f82bcecec8f337e4a81

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/65666f82bcecec8f337e4a8b
        failing since 222 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-11-28T22:55:46.351464  <8>[   42.063450] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-11-28T22:55:47.421571  /lava-12110114/1/../bin/lava-test-case

    2023-11-28T22:55:47.446422  <8>[   43.161245] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/65666f82bcecec8f337e4ad2
        failing since 222 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-11-28T22:55:48.519290  /lava-12110114/1/../bin/lava-test-case

    2023-11-28T22:55:48.543398  <8>[   44.258218] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6566705c81dfbdc0ff7e4a9b

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/6566705c81dfbdc0ff7e4aa5
        failing since 222 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-11-28T22:57:48.073720  <8>[   34.498043] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-11-28T22:57:49.095077  /lava-12110166/1/../bin/lava-test-case

    2023-11-28T22:57:49.106342  <8>[   35.531543] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/6566705c81dfbdc0ff7e4aa6
        failing since 222 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-11-28T22:57:48.061705  /lava-12110166/1/../bin/lava-test-case
   =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig+kse=
lftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/65666d73478d0a280f7e4a93

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig+kselftest/g=
cc-10/lab-collabora/baseline-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig+kselftest/g=
cc-10/lab-collabora/baseline-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65666d73478d0a280f7e4a9c
        failing since 94 days (last pass: v5.10.186-cip37-770-gddd36cfc4c4c=
8, first fail: v5.10.186-cip37-982-g80a0585c0aa62)

    2023-11-28T22:45:12.822686  / # #

    2023-11-28T22:45:14.083178  export SHELL=3D/bin/sh

    2023-11-28T22:45:14.094103  #

    2023-11-28T22:45:14.094569  / # export SHELL=3D/bin/sh

    2023-11-28T22:45:15.837752  / # . /lava-12110084/environment

    2023-11-28T22:45:19.041556  /lava-12110084/bin/lava-test-runner /lava-1=
2110084/1

    2023-11-28T22:45:19.052945  . /lava-12110084/environment

    2023-11-28T22:45:19.057015  / # /lava-12110084/bin/lava-test-runner /la=
va-12110084/1

    2023-11-28T22:45:19.182901  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-28T22:45:19.183350  + cd /lava-12110084/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/656672e113236b031e7e4a6d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig/gcc-10/lab-=
collabora/baseline-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig/gcc-10/lab-=
collabora/baseline-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656672e113236b031e7e4a76
        failing since 94 days (last pass: v5.10.186-cip37-770-gddd36cfc4c4c=
8, first fail: v5.10.186-cip37-982-g80a0585c0aa62)

    2023-11-28T23:07:48.846497  / # #

    2023-11-28T23:07:50.107633  export SHELL=3D/bin/sh

    2023-11-28T23:07:50.118564  #

    2023-11-28T23:07:50.119018  / # export SHELL=3D/bin/sh

    2023-11-28T23:07:51.862570  / # . /lava-12110246/environment

    2023-11-28T23:07:55.063746  /lava-12110246/bin/lava-test-runner /lava-1=
2110246/1

    2023-11-28T23:07:55.074227  . /lava-12110246/environment

    2023-11-28T23:07:55.080324  / # /lava-12110246/bin/lava-test-runner /la=
va-12110246/1

    2023-11-28T23:07:55.117422  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-28T23:07:55.117494  + cd /lava-12110246/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
sun50i-h6-pine-h64       | arm64 | lab-collabora | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/656672cb11becae9597e4a6d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig/gcc-10/lab-=
collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig/gcc-10/lab-=
collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656672cb11becae9597e4a76
        failing since 124 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-11-28T23:14:14.668863  / # #

    2023-11-28T23:14:14.771090  export SHELL=3D/bin/sh

    2023-11-28T23:14:14.771744  #

    2023-11-28T23:14:14.873109  / # export SHELL=3D/bin/sh. /lava-12110236/=
environment

    2023-11-28T23:14:14.873873  =


    2023-11-28T23:14:14.975390  / # . /lava-12110236/environment/lava-12110=
236/bin/lava-test-runner /lava-12110236/1

    2023-11-28T23:14:14.976567  =


    2023-11-28T23:14:14.993479  / # /lava-12110236/bin/lava-test-runner /la=
va-12110236/1

    2023-11-28T23:14:15.037678  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-28T23:14:15.052388  + cd /lava-1211023<8>[   18.226975] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12110236_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

