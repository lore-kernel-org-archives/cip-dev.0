Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282E8C77B73
	for <webhook@archiver.kernel.org>; Tue,  6 Jun 2023 13:06:01 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
 by mx.groups.io with SMTP id smtpd.web10.8201.1686056755214010583
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 06 Jun 2023 06:05:55 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=BYdWtUch;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.181, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-652dd220d67so4975936b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 06 Jun 2023 06:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686056754; x=1688648754;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eQRK28TMxDc4eKXsK7qfD2aJp3REyJza9lQoBkwNiYE=;
        b=BYdWtUchrYm4DaW8aBHZr4NN1IRapRS+D23LY8Pv4nCJ1aVmfdFuKXhUV8Y3C+5Abo
         l2HPe1vsrrPsE+WGDApSyT+IvOJi8yF0MEsOWI4Y7hZWtOIGFFlCy5iA8AkZ0c+SiI4Q
         /kh2bXiNH2o0hYE7v46vO/55tP3rHkfr4JL1306h2INle+5XiGy95+EvFb0LgvY1wPVK
         yNn7/tOwuBgWtn+iL7+kmUe1eSVij764YCImvAeYs9HcQwlrrd7wAukVFlwJjlsH3dep
         nSMyRLM9c13Dp8llOII3ne6p9QVJEo+olvTpKUEur6QbNrL24eQmKim0MCnBDjCNisNT
         NJ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686056754; x=1688648754;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eQRK28TMxDc4eKXsK7qfD2aJp3REyJza9lQoBkwNiYE=;
        b=cR7Ug7JzAK8r9ojH9pBwlhThTklwq6U9Un3DP+n5RaaY3aX0KPnjPUqAvRC1HwlB52
         aXiArH6PHLqZhpr+EVFxOI62Kj4eny1APu71OCVp5PEbT+CwZnp+jOZ9ZjeBIZLDINVr
         qHHkrHpc7mG5o1ii81Gry7KCv2ZsjrTKA6g0Uplj+EEyaMMdj6LOeKYht+8XOfg6gMxj
         8gJq7dAH2HMpLmVqGWHMRhVrDucza3Kig6OOoJRhDlHCOJoFLJD57+x8+lepwsHcu+h/
         aeVHGA+MWKkhY5ry1j3ok3jDRcVtDvQNaYgE8Xomy13UGcXHrQ3wjj5zo8VpeDVF1/wC
         nLJA==
X-Gm-Message-State: AC+VfDxzFBsjOeHtHwyrsmte9bdHwJg5cbxoveSw/y5NqoUpI0GIZvj2
	yk00YhQx3bi6iTeI3vg7mEo5mAgau4e8S5p9dPltxw==
X-Google-Smtp-Source: ACHHUZ5ffXIWpE3TWzAUmpzIYjJzOkbpI82zimlubj1WuQmOtjC3KImAr5AbkX7a6UBOw49NQmldmw==
X-Received: by 2002:a05:6a21:9986:b0:10f:7e62:3806 with SMTP id ve6-20020a056a21998600b0010f7e623806mr3140195pzb.22.1686056753479;
        Tue, 06 Jun 2023 06:05:53 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 72-20020a63034b000000b005344b30d449sm7490691pgd.86.2023.06.06.06.05.52
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 06:05:52 -0700 (PDT)
Message-ID: <647f2f30.630a0220.95ce8.d867@mx.google.com>
Date: Tue, 06 Jun 2023 06:05:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.26-1320-g1ddf4b637f785
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test baseline: 99 runs,
 19 regressions (v6.1.26-1320-g1ddf4b637f785)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jun 2023 13:06:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11882

cip-gitlab/ci/pavel/linux-test baseline: 99 runs, 19 regressions (v6.1.26-1=
320-g1ddf4b637f785)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | bcm283=
5_defconfig            | 1          =

bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx7ulp-evk                  | arm    | lab-nxp         | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx7ulp-evk                  | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =

rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.26-1320-g1ddf4b637f785/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.26-1320-g1ddf4b637f785
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      1ddf4b637f7858373296265fe09135a077008de6 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647f21a0f106f669a2f5de25

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647f21a0f106f669a2f5de2e
        failing since 0 day (last pass: v5.10.180-cip34-26-gc198172c84b6a, =
first fail: v6.1.26-1321-g3152fb7c8d2d6)

    2023-06-06T12:07:37.060499  + set +x

    2023-06-06T12:07:37.066912  <8>[   10.672533] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10605259_1.4.2.3.1>

    2023-06-06T12:07:37.171639  / # #

    2023-06-06T12:07:37.272278  export SHELL=3D/bin/sh

    2023-06-06T12:07:37.272499  #

    2023-06-06T12:07:37.373028  / # export SHELL=3D/bin/sh. /lava-10605259/=
environment

    2023-06-06T12:07:37.373247  =


    2023-06-06T12:07:37.473802  / # . /lava-10605259/environment/lava-10605=
259/bin/lava-test-runner /lava-10605259/1

    2023-06-06T12:07:37.474136  =


    2023-06-06T12:07:37.479859  / # /lava-10605259/bin/lava-test-runner /la=
va-10605259/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647f2189f8edafb574f5dea5

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647f2189f8edafb574f5deae
        failing since 0 day (last pass: v5.10.180-cip34-26-gc198172c84b6a, =
first fail: v6.1.26-1321-g3152fb7c8d2d6)

    2023-06-06T12:07:22.626467  + set<8>[   11.349134] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10605253_1.4.2.3.1>

    2023-06-06T12:07:22.626550   +x

    2023-06-06T12:07:22.730924  / # #

    2023-06-06T12:07:22.831577  export SHELL=3D/bin/sh

    2023-06-06T12:07:22.831810  #

    2023-06-06T12:07:22.932353  / # export SHELL=3D/bin/sh. /lava-10605253/=
environment

    2023-06-06T12:07:22.932575  =


    2023-06-06T12:07:23.033060  / # . /lava-10605253/environment/lava-10605=
253/bin/lava-test-runner /lava-10605253/1

    2023-06-06T12:07:23.033370  =


    2023-06-06T12:07:23.037998  / # /lava-10605253/bin/lava-test-runner /la=
va-10605253/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647f218a198b8cfadcf5de45

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647f218a198b8cfadcf5de4e
        failing since 0 day (last pass: v5.10.180-cip34-26-gc198172c84b6a, =
first fail: v6.1.26-1321-g3152fb7c8d2d6)

    2023-06-06T12:07:33.531355  <8>[   11.653377] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10605204_1.4.2.3.1>

    2023-06-06T12:07:33.534669  + set +x

    2023-06-06T12:07:33.636096  =


    2023-06-06T12:07:33.736660  / # #export SHELL=3D/bin/sh

    2023-06-06T12:07:33.736824  =


    2023-06-06T12:07:33.837368  / # export SHELL=3D/bin/sh. /lava-10605204/=
environment

    2023-06-06T12:07:33.837535  =


    2023-06-06T12:07:33.938061  / # . /lava-10605204/environment/lava-10605=
204/bin/lava-test-runner /lava-10605204/1

    2023-06-06T12:07:33.938301  =


    2023-06-06T12:07:33.943278  / # /lava-10605204/bin/lava-test-runner /la=
va-10605204/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | bcm283=
5_defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/647f1ebf096102590ff5de56

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/arm/bcm2835_defconfig/gcc-10/lab-collabora/bas=
eline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/arm/bcm2835_defconfig/gcc-10/lab-collabora/bas=
eline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647f1ebf096102590ff5de5f
        failing since 0 day (last pass: v5.10.180-cip34-26-gc198172c84b6a, =
first fail: v6.1.26-1321-g3152fb7c8d2d6)

    2023-06-06T11:56:01.907936  / # #

    2023-06-06T11:56:02.010079  export SHELL=3D/bin/sh

    2023-06-06T11:56:02.010810  #

    2023-06-06T11:56:02.112229  / # export SHELL=3D/bin/sh. /lava-10605109/=
environment

    2023-06-06T11:56:02.112959  =


    2023-06-06T11:56:02.214361  / # . /lava-10605109/environment/lava-10605=
109/bin/lava-test-runner /lava-10605109/1

    2023-06-06T11:56:02.215444  =


    2023-06-06T11:56:02.232217  / # /lava-10605109/bin/lava-test-runner /la=
va-10605109/1

    2023-06-06T11:56:02.342939  + export 'TESTRUN_ID=3D1_bootrr'

    2023-06-06T11:56:02.343385  + cd /lava-10605109/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647f23e88dd914a3b9f5de27

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/arm/multi_v7_defconfig/gcc-10/lab-collabora/ba=
seline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/arm/multi_v7_defconfig/gcc-10/lab-collabora/ba=
seline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647f23e88dd914a3b9f5d=
e28
        failing since 2 days (last pass: v4.19.280-cip95-rt30, first fail: =
v6.1.26-1281-g84d5372e0f31) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647f22860992554a07f5de2e

  Results:     52 PASS, 3 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/arm/omap2plus_defconfig/gcc-10/lab-broonie/bas=
eline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/arm/omap2plus_defconfig/gcc-10/lab-broonie/bas=
eline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647f22860992554a07f5de65
        failing since 2 days (last pass: v4.19.280-cip95-rt30, first fail: =
v6.1.26-1281-g84d5372e0f31)

    2023-06-06T12:11:34.887260  <8>[   22.118539] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 568864_1.5.2.4.1>
    2023-06-06T12:11:34.997485  / # #
    2023-06-06T12:11:35.100091  export SHELL=3D/bin/sh
    2023-06-06T12:11:35.100992  #
    2023-06-06T12:11:35.202805  / # export SHELL=3D/bin/sh. /lava-568864/en=
vironment
    2023-06-06T12:11:35.203401  =

    2023-06-06T12:11:35.305402  / # . /lava-568864/environment/lava-568864/=
bin/lava-test-runner /lava-568864/1
    2023-06-06T12:11:35.306489  =

    2023-06-06T12:11:35.310923  / # /lava-568864/bin/lava-test-runner /lava=
-568864/1
    2023-06-06T12:11:35.420668  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647f27166c8c797ef5f5de50

  Results:     52 PASS, 3 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/arm/omap2plus_defconfig/gcc-10/lab-cip/baselin=
e-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/arm/omap2plus_defconfig/gcc-10/lab-cip/baselin=
e-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647f27166c8c797ef5f5de57
        failing since 2 days (last pass: v4.19.280-cip95-rt30, first fail: =
v6.1.26-1281-g84d5372e0f31)

    2023-06-06T12:31:07.811192  + set +x
    2023-06-06T12:31:07.813238  <8>[   15.905428] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 954673_1.5.2.4.1>
    2023-06-06T12:31:07.922268  / # #
    2023-06-06T12:31:08.024153  export SHELL=3D/bin/sh
    2023-06-06T12:31:08.024616  #
    2023-06-06T12:31:08.126017  / # export SHELL=3D/bin/sh. /lava-954673/en=
vironment
    2023-06-06T12:31:08.126483  =

    2023-06-06T12:31:08.227898  / # . /lava-954673/environment/lava-954673/=
bin/lava-test-runner /lava-954673/1
    2023-06-06T12:31:08.228634  =

    2023-06-06T12:31:08.230703  / # /lava-954673/bin/lava-test-runner /lava=
-954673/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647f2175998738cb5ff5de76

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647f2175998738cb5ff5de7f
        failing since 2 days (last pass: v4.19.280-cip95-rt30, first fail: =
v6.1.26-1281-g84d5372e0f31)

    2023-06-06T12:07:11.432100  + set +x

    2023-06-06T12:07:11.438253  <8>[   11.248435] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10605209_1.4.2.3.1>

    2023-06-06T12:07:11.542811  / # #

    2023-06-06T12:07:11.643594  export SHELL=3D/bin/sh

    2023-06-06T12:07:11.643794  #

    2023-06-06T12:07:11.744298  / # export SHELL=3D/bin/sh. /lava-10605209/=
environment

    2023-06-06T12:07:11.744499  =


    2023-06-06T12:07:11.845032  / # . /lava-10605209/environment/lava-10605=
209/bin/lava-test-runner /lava-10605209/1

    2023-06-06T12:07:11.845346  =


    2023-06-06T12:07:11.849519  / # /lava-10605209/bin/lava-test-runner /la=
va-10605209/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647f217af8edafb574f5de5e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647f217af8edafb574f5de67
        failing since 2 days (last pass: v4.19.280-cip95-rt30, first fail: =
v6.1.26-1281-g84d5372e0f31)

    2023-06-06T12:07:08.181290  <8>[   10.055253] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10605214_1.4.2.3.1>

    2023-06-06T12:07:08.184156  + set +x

    2023-06-06T12:07:08.285963  =


    2023-06-06T12:07:08.386698  / # #export SHELL=3D/bin/sh

    2023-06-06T12:07:08.387654  =


    2023-06-06T12:07:08.489535  / # export SHELL=3D/bin/sh. /lava-10605214/=
environment

    2023-06-06T12:07:08.490424  =


    2023-06-06T12:07:08.591872  / # . /lava-10605214/environment/lava-10605=
214/bin/lava-test-runner /lava-10605214/1

    2023-06-06T12:07:08.592199  =


    2023-06-06T12:07:08.597388  / # /lava-10605214/bin/lava-test-runner /la=
va-10605214/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647f218b9d346092d5f5de28

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647f218b9d346092d5f5de31
        failing since 0 day (last pass: v5.10.180-cip34-26-gc198172c84b6a, =
first fail: v6.1.26-1321-g3152fb7c8d2d6)

    2023-06-06T12:07:19.588977  + set<8>[   11.086751] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10605279_1.4.2.3.1>

    2023-06-06T12:07:19.589103   +x

    2023-06-06T12:07:19.693470  / # #

    2023-06-06T12:07:19.794227  export SHELL=3D/bin/sh

    2023-06-06T12:07:19.794471  #

    2023-06-06T12:07:19.895053  / # export SHELL=3D/bin/sh. /lava-10605279/=
environment

    2023-06-06T12:07:19.895269  =


    2023-06-06T12:07:19.995785  / # . /lava-10605279/environment/lava-10605=
279/bin/lava-test-runner /lava-10605279/1

    2023-06-06T12:07:19.996091  =


    2023-06-06T12:07:20.000822  / # /lava-10605279/bin/lava-test-runner /la=
va-10605279/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647f243e30c049ef05f5de56

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/=
baseline-imx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/=
baseline-imx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647f243e30c049ef05f5de5f
        failing since 0 day (last pass: v5.10.180-cip34-26-gc198172c84b6a, =
first fail: v6.1.26-1314-g1ab0ac1d7e2e3)

    2023-06-06T12:18:46.202258  + set +x
    2023-06-06T12:18:46.202447  [   12.877224] <LAVA_SIGNAL_ENDRUN 0_dmesg =
968887_1.5.2.3.1>
    2023-06-06T12:18:46.310024  / # #
    2023-06-06T12:18:46.411665  export SHELL=3D/bin/sh
    2023-06-06T12:18:46.412109  #
    2023-06-06T12:18:46.513364  / # export SHELL=3D/bin/sh. /lava-968887/en=
vironment
    2023-06-06T12:18:46.513823  =

    2023-06-06T12:18:46.615168  / # . /lava-968887/environment/lava-968887/=
bin/lava-test-runner /lava-968887/1
    2023-06-06T12:18:46.615834  =

    2023-06-06T12:18:46.619125  / # /lava-968887/bin/lava-test-runner /lava=
-968887/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647f235322b5486b14f5de9c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/bas=
eline-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/bas=
eline-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647f235322b5486b14f5d=
e9d
        failing since 2 days (last pass: v4.19.280-cip95-rt30, first fail: =
v6.1.26-1281-g84d5372e0f31) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647f235222b5486b14f5de99

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/bas=
eline-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/bas=
eline-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647f235222b5486b14f5d=
e9a
        failing since 2 days (last pass: v4.19.280-cip95-rt30, first fail: =
v6.1.26-1281-g84d5372e0f31) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7ulp-evk                  | arm    | lab-nxp         | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647f2396f3137f0444f5de9c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/arm/imx_v6_v7_defconfig/gcc-10/lab-nxp/baselin=
e-imx7ulp-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/arm/imx_v6_v7_defconfig/gcc-10/lab-nxp/baselin=
e-imx7ulp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647f2396f3137f0444f5d=
e9d
        failing since 0 day (last pass: v5.10.180-cip34-26-gc198172c84b6a, =
first fail: v6.1.26-1321-g3152fb7c8d2d6) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7ulp-evk                  | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647f26b84b8a59c175f5de91

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline=
-imx7ulp-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline=
-imx7ulp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647f26b84b8a59c175f5de98
        failing since 75 days (last pass: v5.10.145-rt74-1329-ga59fc50f38f6=
, first fail: v5.10.175-cip29-rt12)

    2023-06-06T12:28:56.592279  + set +x<8>[   33.564789] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 1234267_1.5.2.4.1>
    2023-06-06T12:28:56.592583  =

    2023-06-06T12:28:56.701058  / # #
    2023-06-06T12:28:57.861433  export SHELL=3D/bin/sh
    2023-06-06T12:28:57.867000  #
    2023-06-06T12:28:57.867290  / # export SHELL=3D/bin/sh
    2023-06-06T12:28:59.415183  / # . /lava-1234267/environment
    2023-06-06T12:29:02.243018  /lava-1234267/bin/lava-test-runner /lava-12=
34267/1
    2023-06-06T12:29:02.249054  . /lava-1234267/environment
    2023-06-06T12:29:02.249323  / # /lava-1234267/bin/lava-test-runner /lav=
a-1234267/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647f218b156b68448ff5de5b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647f218b156b68448ff5de64
        failing since 0 day (last pass: v5.10.180-cip34-26-gc198172c84b6a, =
first fail: v6.1.26-1321-g3152fb7c8d2d6)

    2023-06-06T12:07:28.330204  <8>[   12.470369] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10605224_1.4.2.3.1>

    2023-06-06T12:07:28.435076  / # #

    2023-06-06T12:07:28.535675  export SHELL=3D/bin/sh

    2023-06-06T12:07:28.535868  #

    2023-06-06T12:07:28.636352  / # export SHELL=3D/bin/sh. /lava-10605224/=
environment

    2023-06-06T12:07:28.636577  =


    2023-06-06T12:07:28.737142  / # . /lava-10605224/environment/lava-10605=
224/bin/lava-test-runner /lava-10605224/1

    2023-06-06T12:07:28.737440  =


    2023-06-06T12:07:28.741806  / # /lava-10605224/bin/lava-test-runner /la=
va-10605224/1

    2023-06-06T12:07:28.748429  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647f245fb07631e9bcf5e0e5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/arm/shmobile_defconfig/gcc-10/lab-cip/baseline=
-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/arm/shmobile_defconfig/gcc-10/lab-cip/baseline=
-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647f245fb07631e9bcf5e=
0e6
        failing since 0 day (last pass: v6.1.26-1314-g1ab0ac1d7e2e3, first =
fail: v6.1.26-1321-g3152fb7c8d2d6) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 2          =


  Details:     https://kernelci.org/test/plan/id/647f23aeeb42cc27baf5de5d

  Results:     66 PASS, 4 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/arm/multi_v7_defconfig/gcc-10/lab-collabora/ba=
seline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/arm/multi_v7_defconfig/gcc-10/lab-collabora/ba=
seline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/647f23aeeb42cc27baf5de91
        failing since 137 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-06-06T12:17:02.015452  Usage: seq [-w] [-s SEP] [FIRST [INC]] LA<8=
>[   19.821127] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-06-06T12:17:02.015683  ST

    2023-06-06T12:17:02.015916  =


    2023-06-06T12:17:02.020982  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-06-06T12:17:02.023594  FIRST, INC default to 1.

    2023-06-06T12:17:02.023646  =


    2023-06-06T12:17:02.027179  	-w	Pad to last with leading zeros
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/647f23aeeb42cc27baf5de92
        failing since 137 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-06-06T12:17:01.984646  <8>[   19.796294] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>

    2023-06-06T12:17:02.001255  BusyBox v1.31.1 (2023-05-27 14:14:16 UTC) m=
ulti-call binary.

    2023-06-06T12:17:02.001329  =

   =

 =20

