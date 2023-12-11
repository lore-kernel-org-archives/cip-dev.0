Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D73DC46CA3
	for <webhook@archiver.kernel.org>; Mon, 11 Dec 2023 10:22:52 +0000 (UTC)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
 by mx.groups.io with SMTP id smtpd.web11.5369.1702290166403557221
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 11 Dec 2023 02:22:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=0hFg2GQX;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.45, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-286b45c5a8dso4459679a91.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 11 Dec 2023 02:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702290165; x=1702894965; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=322ktzw+XRNxaCNJDvuFTchIqWqqyPEIhF3yAc67dGI=;
        b=0hFg2GQXP4sDdduic5D5L9I4rKwzv5cZuDjw+sG1VT1qUGOQyOuvB2nIKOS51JoNn9
         Zx5bqQPQZsAcy09LG2d1BK58+iXUNAYKd7GlvQEWuwQAqVIknGQthZhJ8ySDERDIbvf9
         D+fJoQLrA8vrJF0J6rMjYuDL+0yfENkzj2W7lchHdlwt8KmH7XSEytSMcOV7TBhkW/ic
         XTF9Xkm+p4ohTvbT3kowcEMpWmjSrpows9LUFoKn4qPaEhnDmByixQ5nZj4NPnOIZuwt
         9UjRhmPNfYbyaDd7dM+t454TEP1U581Ush6vx3OFiBmElfsNlmmDmxibsG6rurA4B5ud
         XSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702290165; x=1702894965;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=322ktzw+XRNxaCNJDvuFTchIqWqqyPEIhF3yAc67dGI=;
        b=GqGORGpG/GRqZnH8f9+XwQxbpaMy2srVWDsCkvmZgDEzeSNiiOTqG10Z7O0TSTjFU9
         520p4wRkJ69uAt0EdfVhOqAZmiGvnxspypU69Gjis3+UCnBB5ZsbpQ04lpUVwe+D1Ag2
         yX7b8NQoKnGKlfmoEtISJ6n1NNvGa/t6ilKc/uBCfY+BAdlZhWN1Vk2i0kDnLAjBrLIM
         D9hUPFSO5qP/XN2io4NQB7WYP5kEQMna5mvjsOtiwYuMDPaeJSMXGCNEHu1xbYP2rDlA
         0Xh/wUJj4+5UrYPtdR7mqfi6/UD+wdsLtN2dD95U507/X1lG4NOfgOnQ/nYj9C2RXSzC
         00Gw==
X-Gm-Message-State: AOJu0YxwFSb7eYnOCMBeAM+bLjxTAfc5e5XRg/TGi4xm69wcMWH39LMD
	0ZXN8YyvRkNInL5w+F8ZosN8kmMchZS+IADNsn+ktQ==
X-Google-Smtp-Source: AGHT+IGqYcdkN6tpxbcX+tRPfatxpy2AKiwNJ2iTtdt/ufBEhLMP+kFbI4vOgsy0G4CDsfbME7DcGw==
X-Received: by 2002:a17:90a:984:b0:288:649e:3961 with SMTP id 4-20020a17090a098400b00288649e3961mr3154613pjo.38.1702290164810;
        Mon, 11 Dec 2023 02:22:44 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id pv12-20020a17090b3c8c00b00285e53d90cesm6741637pjb.26.2023.12.11.02.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 02:22:43 -0800 (PST)
Message-ID: <6576e2f3.170a0220.1c7e7.1eb0@mx.google.com>
Date: Mon, 11 Dec 2023 02:22:43 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-63-gfdfe1fbf93bc6
Subject: cip/linux-5.10.y-cip baseline: 100 runs,
 21 regressions (v5.10.201-cip41-63-gfdfe1fbf93bc6)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Dec 2023 10:22:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14006

cip/linux-5.10.y-cip baseline: 100 runs, 21 regressions (v5.10.201-cip41-63=
-gfdfe1fbf93bc6)

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

beaglebone-black         | arm   | lab-cip         | gcc-10   | omap2plus_d=
efconfig          | 1          =

imx6q-sabrelite          | arm   | lab-collabora   | gcc-10   | multi_v7_de=
fconfig           | 1          =

imx6qp-wandboard-revd1   | arm   | lab-pengutronix | gcc-10   | imx_v6_v7_d=
efconfig          | 1          =

imx6qp-wandboard-revd1   | arm   | lab-pengutronix | gcc-10   | multi_v7_de=
fconfig           | 1          =

juno-uboot               | arm64 | lab-broonie     | gcc-10   | cip://5.10.=
y-...64_defconfig | 1          =

juno-uboot               | arm64 | lab-broonie     | gcc-10   | defconfig+k=
selftest          | 1          =

r8a7743-iwg20d-q7        | arm   | lab-cip         | gcc-10   | shmobile_de=
fconfig           | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip         | gcc-10   | defconfig  =
                  | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip         | gcc-10   | defconfig+k=
selftest          | 1          =

r8a77960-ulcb            | arm64 | lab-collabora   | gcc-10   | defconfig  =
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
l/v5.10.201-cip41-63-gfdfe1fbf93bc6/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-63-gfdfe1fbf93bc6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      fdfe1fbf93bc6fe6ed2708f11c2613bef556fdeb =



Test Regressions
---------------- =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
at91sam9g20ek            | arm   | lab-broonie     | gcc-10   | multi_v5_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6576db62ab9c4bb4d0e1347d

  Results:     47 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline=
-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline=
-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6576db62ab9c4bb4d0e134b2
        failing since 331 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-11T09:49:54.329897  + set +x
    2023-12-11T09:49:54.330402  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 340253_1.5.2=
.4.1>
    2023-12-11T09:49:54.444309  / # #
    2023-12-11T09:49:54.547301  export SHELL=3D/bin/sh
    2023-12-11T09:49:54.548097  #
    2023-12-11T09:49:54.650068  / # export SHELL=3D/bin/sh. /lava-340253/en=
vironment
    2023-12-11T09:49:54.650889  =

    2023-12-11T09:49:54.752844  / # . /lava-340253/environment/lava-340253/=
bin/lava-test-runner /lava-340253/1
    2023-12-11T09:49:54.754213  =

    2023-12-11T09:49:54.757819  / # /lava-340253/bin/lava-test-runner /lava=
-340253/1 =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
bcm2836-rpi-2-b          | arm   | lab-collabora   | gcc-10   | bcm2835_def=
config            | 1          =


  Details:     https://kernelci.org/test/plan/id/6576db6bab9c4bb4d0e134d7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm/bcm2835_defconfig/gcc-10/lab-collabora/baselin=
e-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm/bcm2835_defconfig/gcc-10/lab-collabora/baselin=
e-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6576db6bab9c4bb4d0e134dc
        failing since 138 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-12-11T09:57:49.405873  / # #

    2023-12-11T09:57:49.506679  export SHELL=3D/bin/sh

    2023-12-11T09:57:49.506978  #

    2023-12-11T09:57:49.607755  / # export SHELL=3D/bin/sh. /lava-12243967/=
environment

    2023-12-11T09:57:49.608521  =


    2023-12-11T09:57:49.709849  / # . /lava-12243967/environment/lava-12243=
967/bin/lava-test-runner /lava-12243967/1

    2023-12-11T09:57:49.710836  =


    2023-12-11T09:57:49.720028  / # /lava-12243967/bin/lava-test-runner /la=
va-12243967/1

    2023-12-11T09:57:49.832024  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-11T09:57:49.832578  + cd /lava-12243967/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
beaglebone-black         | arm   | lab-broonie     | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6576db9bd8f82a0b1de13555

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline=
-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline=
-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6576db9bd8f82a0b1de1357b
        failing since 331 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-11T09:50:52.128215  <8>[   24.109084] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 340272_1.5.2.4.1>
    2023-12-11T09:50:52.237630  / # #
    2023-12-11T09:50:52.339864  export SHELL=3D/bin/sh
    2023-12-11T09:50:52.340492  #
    2023-12-11T09:50:52.442281  / # export SHELL=3D/bin/sh. /lava-340272/en=
vironment
    2023-12-11T09:50:52.442904  =

    2023-12-11T09:50:52.544539  / # . /lava-340272/environment/lava-340272/=
bin/lava-test-runner /lava-340272/1
    2023-12-11T09:50:52.545241  =

    2023-12-11T09:50:52.549802  / # /lava-340272/bin/lava-test-runner /lava=
-340272/1
    2023-12-11T09:50:52.633661  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
beaglebone-black         | arm   | lab-broonie     | gcc-10   | omap2plus_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6576db07d5a4193735e13480

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm/omap2plus_defconfig/gcc-10/lab-broonie/baselin=
e-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm/omap2plus_defconfig/gcc-10/lab-broonie/baselin=
e-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6576db07d5a4193735e134b4
        failing since 331 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-11T09:48:40.200629  <8>[   24.572509] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 340246_1.5.2.4.1>
    2023-12-11T09:48:40.309128  / # #
    2023-12-11T09:48:40.410664  export SHELL=3D/bin/sh
    2023-12-11T09:48:40.411047  #
    2023-12-11T09:48:40.512068  / # export SHELL=3D/bin/sh. /lava-340246/en=
vironment
    2023-12-11T09:48:40.512495  =

    2023-12-11T09:48:40.613688  / # . /lava-340246/environment/lava-340246/=
bin/lava-test-runner /lava-340246/1
    2023-12-11T09:48:40.614406  =

    2023-12-11T09:48:40.617776  / # /lava-340246/bin/lava-test-runner /lava=
-340246/1
    2023-12-11T09:48:40.727885  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
beaglebone-black         | arm   | lab-cip         | gcc-10   | omap2plus_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6576de5a62395a3a2ee13477

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-be=
aglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-be=
aglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6576de5a62395a3a2ee134a8
        failing since 331 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-11T10:02:53.538228  / # #
    2023-12-11T10:02:53.639474  export SHELL=3D/bin/sh
    2023-12-11T10:02:53.639824  #
    2023-12-11T10:02:53.740490  / # export SHELL=3D/bin/sh. /lava-1056334/e=
nvironment
    2023-12-11T10:02:53.740865  =

    2023-12-11T10:02:53.841677  / # . /lava-1056334/environment/lava-105633=
4/bin/lava-test-runner /lava-1056334/1
    2023-12-11T10:02:53.842215  =

    2023-12-11T10:02:53.884902  / # /lava-1056334/bin/lava-test-runner /lav=
a-1056334/1
    2023-12-11T10:02:53.989966  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-11T10:02:53.990218  + cd /lava-1056334/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
imx6q-sabrelite          | arm   | lab-collabora   | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6576db620199279485e13494

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6576db620199279485e13499
        failing since 331 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-11T09:50:43.186217  / # #

    2023-12-11T09:50:43.288091  export SHELL=3D/bin/sh

    2023-12-11T09:50:43.288745  #

    2023-12-11T09:50:43.389872  / # export SHELL=3D/bin/sh. /lava-12243970/=
environment

    2023-12-11T09:50:43.390433  =


    2023-12-11T09:50:43.491642  / # . /lava-12243970/environment/lava-12243=
970/bin/lava-test-runner /lava-12243970/1

    2023-12-11T09:50:43.492479  =


    2023-12-11T09:50:43.495024  / # /lava-12243970/bin/lava-test-runner /la=
va-12243970/1

    2023-12-11T09:50:43.607659  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-11T09:50:43.608047  + cd /lava-12243970/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
imx6qp-wandboard-revd1   | arm   | lab-pengutronix | gcc-10   | imx_v6_v7_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6576dc18bb8509b41ee13476

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/bas=
eline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/bas=
eline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6576dc18bb8509b41ee13479
        failing since 331 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-11T09:53:21.420944  + set +x
    2023-12-11T09:53:21.421183  [   10.419603] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1016701_1.5.2.3.1>
    2023-12-11T09:53:21.529093  / # #
    2023-12-11T09:53:21.630503  export SHELL=3D/bin/sh
    2023-12-11T09:53:21.630991  #
    2023-12-11T09:53:21.731885  / # export SHELL=3D/bin/sh. /lava-1016701/e=
nvironment
    2023-12-11T09:53:21.732350  =

    2023-12-11T09:53:21.833207  / # . /lava-1016701/environment/lava-101670=
1/bin/lava-test-runner /lava-1016701/1
    2023-12-11T09:53:21.833826  =

    2023-12-11T09:53:21.836936  / # /lava-1016701/bin/lava-test-runner /lav=
a-1016701/1 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
imx6qp-wandboard-revd1   | arm   | lab-pengutronix | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6576db3cd5a4193735e13533

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/base=
line-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/base=
line-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6576db3cd5a4193735e13538
        failing since 331 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-11T09:49:40.264733  + set[    7.295143] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 1016700_1.5.2.3.1>
    2023-12-11T09:49:40.265065   +x
    2023-12-11T09:49:40.370746  / # #
    2023-12-11T09:49:40.472263  export SHELL=3D/bin/sh
    2023-12-11T09:49:40.472764  #
    2023-12-11T09:49:40.573705  / # export SHELL=3D/bin/sh. /lava-1016700/e=
nvironment
    2023-12-11T09:49:40.574226  =

    2023-12-11T09:49:40.675028  / # . /lava-1016700/environment/lava-101670=
0/bin/lava-test-runner /lava-1016700/1
    2023-12-11T09:49:40.675670  =

    2023-12-11T09:49:40.677948  / # /lava-1016700/bin/lava-test-runner /lav=
a-1016700/1 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
juno-uboot               | arm64 | lab-broonie     | gcc-10   | cip://5.10.=
y-...64_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6576dd30f5fa3481b1e13475

  Results:     47 PASS, 13 FAIL, 1 SKIP
  Full config: cip://5.10.y-cip/arm64/qemu_arm64_defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm64/cip---5.10.y-cip-arm64-qemu_arm64_defconfig/=
gcc-10/lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm64/cip---5.10.y-cip-arm64-qemu_arm64_defconfig/=
gcc-10/lab-broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6576dd30f5fa3481b1e134af
        failing since 105 days (last pass: v5.10.186-cip37-27-gd6d928db0a62=
0, first fail: v5.10.191-cip38)

    2023-12-11T09:57:44.938213  / # #
    2023-12-11T09:57:45.040544  export SHELL=3D/bin/sh
    2023-12-11T09:57:45.041069  #
    2023-12-11T09:57:45.142410  / # export SHELL=3D/bin/sh. /lava-340323/en=
vironment
    2023-12-11T09:57:45.142877  =

    2023-12-11T09:57:45.244257  / # . /lava-340323/environment/lava-340323/=
bin/lava-test-runner /lava-340323/1
    2023-12-11T09:57:45.245039  =

    2023-12-11T09:57:45.261775  / # /lava-340323/bin/lava-test-runner /lava=
-340323/1
    2023-12-11T09:57:45.316624  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-11T09:57:45.316943  + cd /lava-340323/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
juno-uboot               | arm64 | lab-broonie     | gcc-10   | defconfig+k=
selftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6576dc3e8dcfb0d6ece134af

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm64/defconfig+kselftest/gcc-10/lab-broonie/basel=
ine-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm64/defconfig+kselftest/gcc-10/lab-broonie/basel=
ine-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6576dc3f8dcfb0d6ece134eb
        failing since 138 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-12-11T09:53:31.211122  <8>[   19.275859] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 340315_1.5.2.4.1>
    2023-12-11T09:53:31.315228  / # #
    2023-12-11T09:53:31.417074  export SHELL=3D/bin/sh
    2023-12-11T09:53:31.417584  #
    2023-12-11T09:53:31.518921  / # export SHELL=3D/bin/sh. /lava-340315/en=
vironment
    2023-12-11T09:53:31.519869  =

    2023-12-11T09:53:31.621958  / # . /lava-340315/environment/lava-340315/=
bin/lava-test-runner /lava-340315/1
    2023-12-11T09:53:31.623352  =

    2023-12-11T09:53:31.642829  / # /lava-340315/bin/lava-test-runner /lava=
-340315/1
    2023-12-11T09:53:31.812591  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
r8a7743-iwg20d-q7        | arm   | lab-cip         | gcc-10   | shmobile_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6576dd2fdffb4b3488e13492

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a=
7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a=
7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6576dd2fdffb4b3488e13=
493
        failing since 3 days (last pass: v5.10.201-cip41-16-g3c85fba3b6e5d,=
 first fail: v5.10.201-cip41-28-ga386bc478aa6b) =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip         | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6576d9c17707c957dee13485

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774a1-h=
ihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774a1-h=
ihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6576d9c17707c957dee1348a
        failing since 124 days (last pass: v5.10.182-cip35-1-g7cde3fba93966=
, first fail: v5.10.186-cip37-13-g260094841fe1a)

    2023-12-11T09:43:06.191278  + set +x
    2023-12-11T09:43:06.194450  <8>[   83.989424] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1056296_1.5.2.4.1>
    2023-12-11T09:43:06.299632  / # #
    2023-12-11T09:43:07.753547  export SHELL=3D/bin/sh
    2023-12-11T09:43:07.773986  #
    2023-12-11T09:43:07.774168  / # export SHELL=3D/bin/sh
    2023-12-11T09:43:09.719871  / # . /lava-1056296/environment
    2023-12-11T09:43:13.303918  /lava-1056296/bin/lava-test-runner /lava-10=
56296/1
    2023-12-11T09:43:13.325028  . /lava-1056296/environment
    2023-12-11T09:43:13.325346  / # /lava-1056296/bin/lava-test-runner /lav=
a-1056296/1 =

    ... (28 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip         | gcc-10   | defconfig+k=
selftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6576df74cbd92c4c2be13477

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-=
r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-=
r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6576df74cbd92c4c2be1347c
        failing since 124 days (last pass: v5.10.182-cip35, first fail: v5.=
10.186-cip37-13-g260094841fe1a)

    2023-12-11T10:05:55.243496  + set +x
    2023-12-11T10:05:55.246730  <8>[   87.760389] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1056367_1.5.2.4.1>
    2023-12-11T10:05:55.358765  / # #
    2023-12-11T10:05:56.815193  export SHELL=3D/bin/sh
    2023-12-11T10:05:56.835750  #
    2023-12-11T10:05:56.835962  / # export SHELL=3D/bin/sh
    2023-12-11T10:05:58.783587  / # . /lava-1056367/environment
    2023-12-11T10:06:02.366421  /lava-1056367/bin/lava-test-runner /lava-10=
56367/1
    2023-12-11T10:06:02.387519  . /lava-1056367/environment
    2023-12-11T10:06:02.387792  / # /lava-1056367/bin/lava-test-runner /lav=
a-1056367/1 =

    ... (27 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
r8a77960-ulcb            | arm64 | lab-collabora   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6576d92765a734674ee1350b

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a7=
7960-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a7=
7960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6576d92765a734674ee13510
        failing since 138 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-12-11T09:48:09.685367  / # #

    2023-12-11T09:48:09.785807  export SHELL=3D/bin/sh

    2023-12-11T09:48:09.785945  #

    2023-12-11T09:48:09.886357  / # export SHELL=3D/bin/sh. /lava-12243963/=
environment

    2023-12-11T09:48:09.886483  =


    2023-12-11T09:48:09.986914  / # . /lava-12243963/environment/lava-12243=
963/bin/lava-test-runner /lava-12243963/1

    2023-12-11T09:48:09.987095  =


    2023-12-11T09:48:09.999292  / # /lava-12243963/bin/lava-test-runner /la=
va-12243963/1

    2023-12-11T09:48:10.052503  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-11T09:48:10.052572  + cd /lav<8>[   16.428623] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12243963_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
rk3288-veyron-jaq        | arm   | lab-collabora   | gcc-10   | multi_v7_de=
fconfig           | 4          =


  Details:     https://kernelci.org/test/plan/id/6576dbe307dfd9f5a6e13478

  Results:     63 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-i2c-present: https://kernelci.or=
g/test/case/id/6576dbe307dfd9f5a6e134a7
        failing since 329 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-11T09:59:57.588145  FIRST,<8>[   21.335624] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>

    2023-12-11T09:59:57.590033   INC default to 1.

    2023-12-11T09:59:57.590096  =


    2023-12-11T09:59:57.593512  	-w	Pad to last with leading zeros

    2023-12-11T09:59:57.596117  	-s SEP	String separator

    2023-12-11T09:59:57.600141  /lava-12243979/1/../bin/lava-test-case

    2023-12-11T09:59:57.606022  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.

    2023-12-11T09:59:57.606076  =

   =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/6576dbe307dfd9f5a6e134a8
        failing since 329 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-11T09:59:57.564267  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC)<8=
>[   21.316817] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-12-11T09:59:57.567623   multi-call binary.

    2023-12-11T09:59:57.568013  =


    2023-12-11T09:59:57.572127  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-12-11T09:59:57.572360  =


    2023-12-11T09:59:57.577652  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/6576dbe307dfd9f5a6e134a9
        failing since 329 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-11T09:59:57.545557  =

   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6576dbe307dfd9f5a6e134bd
        failing since 329 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-11T09:59:45.487560  <8>[    9.241361] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-12-11T09:59:45.497275  + <8>[    9.253726] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 12243979_1.5.2.3.1>

    2023-12-11T09:59:45.499873  set +x

    2023-12-11T09:59:45.603240  =


    2023-12-11T09:59:45.703753  / # #export SHELL=3D/bin/sh

    2023-12-11T09:59:45.703862  =


    2023-12-11T09:59:45.703918  / # <6>[    9.381956] sbs-battery 20-000b: =
Disabling PEC because of broken Cros-EC implementation

    2023-12-11T09:59:45.703967  <4>[    9.415835] sbs-battery 20-000b: Unkn=
own chemistry: POLY

    2023-12-11T09:59:45.704012  export SHELL=3D/bin/sh<4>[    9.429136] sbs=
-battery 20-000b: Unknown chemistry: POLY

    2023-12-11T09:59:45.804539  . /lava-12243979/environment
 =

    ... (27 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
rk3399-rock-pi-4b        | arm64 | lab-collabora   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6576d9326937132cf2e134eb

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm64/defconfig/gcc-10/lab-collabora/baseline-rk33=
99-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm64/defconfig/gcc-10/lab-collabora/baseline-rk33=
99-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6576d9326937132cf2e134f0
        failing since 82 days (last pass: v5.10.191-cip38-29-g9e1aa2001db8,=
 first fail: v5.10.194-cip39)

    2023-12-11T09:41:17.436274  / # #

    2023-12-11T09:41:18.696937  export SHELL=3D/bin/sh

    2023-12-11T09:41:18.707857  #

    2023-12-11T09:41:18.708315  / # export SHELL=3D/bin/sh

    2023-12-11T09:41:20.451722  / # . /lava-12243951/environment

    2023-12-11T09:41:23.655566  /lava-12243951/bin/lava-test-runner /lava-1=
2243951/1

    2023-12-11T09:41:23.666958  . /lava-12243951/environment

    2023-12-11T09:41:23.670718  / # /lava-12243951/bin/lava-test-runner /la=
va-12243951/1

    2023-12-11T09:41:23.721781  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-11T09:41:23.722256  + cd /lava-12243951/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
sun50i-a64-pine64-plus   | arm64 | lab-broonie     | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6576d9c2fc2127c14be1347a

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i=
-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i=
-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6576d9c3fc2127c14be134a6
        failing since 331 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-11T09:42:39.214398  + set +x
    2023-12-11T09:42:39.218402  <8>[   17.079393] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 340218_1.5.2.4.1>
    2023-12-11T09:42:39.328848  / # #
    2023-12-11T09:42:39.430797  export SHELL=3D/bin/sh
    2023-12-11T09:42:39.431302  #
    2023-12-11T09:42:39.532634  / # export SHELL=3D/bin/sh. /lava-340218/en=
vironment
    2023-12-11T09:42:39.533132  =

    2023-12-11T09:42:39.634672  / # . /lava-340218/environment/lava-340218/=
bin/lava-test-runner /lava-340218/1
    2023-12-11T09:42:39.635346  =

    2023-12-11T09:42:39.639615  / # /lava-340218/bin/lava-test-runner /lava=
-340218/1 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
sun50i-h6-pine-h64       | arm64 | lab-collabora   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6576d926d02d92cb18e134ed

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm64/defconfig/gcc-10/lab-collabora/baseline-sun5=
0i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm64/defconfig/gcc-10/lab-collabora/baseline-sun5=
0i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6576d926d02d92cb18e134f2
        failing since 138 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-12-11T09:48:24.385204  / # #

    2023-12-11T09:48:24.487321  export SHELL=3D/bin/sh

    2023-12-11T09:48:24.488020  #

    2023-12-11T09:48:24.589439  / # export SHELL=3D/bin/sh. /lava-12243952/=
environment

    2023-12-11T09:48:24.590149  =


    2023-12-11T09:48:24.691580  / # . /lava-12243952/environment/lava-12243=
952/bin/lava-test-runner /lava-12243952/1

    2023-12-11T09:48:24.692722  =


    2023-12-11T09:48:24.709428  / # /lava-12243952/bin/lava-test-runner /la=
va-12243952/1

    2023-12-11T09:48:24.752853  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-11T09:48:24.767215  + cd /lava-1224395<8>[   18.190350] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12243952_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

