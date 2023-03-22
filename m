Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0088C6FD1F
	for <webhook@archiver.kernel.org>; Wed, 22 Mar 2023 13:56:23 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.web10.43587.1679493374173220940
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 22 Mar 2023 06:56:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=fXVskq6M;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.42, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f42.google.com with SMTP id qe8-20020a17090b4f8800b0023f07253a2cso19214882pjb.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 22 Mar 2023 06:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1679493373;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ewk4zPpTlg4fvKq8fv8S8Tt5fu009xZhmI+GsREUJQo=;
        b=fXVskq6MRR8LhY8OM86yRnRbjVLOMZX+5xdHxl5aYdR/Ctvmqi3oIz7EQMN6sxcSMU
         eepOtjb0nqU35+zIoTrppV1XUyJvNqcfTxxJ/kuKgVB3ss9A2EBciRoivGvlN5Mg/gtP
         7jGYq5AafCgO3dWDF5FWg4YzyT93FA81Bkg2oDD6y/ubCiCwyPLdl5nK8aFLlBsZhpUR
         4j1n1xleHkxoc+Smr54hAJqbj1CFYOHT3CMGDMaz3bXL35/3lZc7khDyyzaAeCN1UocD
         a+M2cFzwzX+OikO+Ab2uw7vvgJotojLbCvYKpgisNhAdXGBwQci0etwFGrRWfOkktWIf
         Elzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679493373;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ewk4zPpTlg4fvKq8fv8S8Tt5fu009xZhmI+GsREUJQo=;
        b=kjUcDsBExdVHjMmWMXUUIebQ1lUEkvjGD1VZU1lvJtMhNB04gcA8U/G9cEtmO77PUw
         R30uFxCxS6ugXZ58ZOPB5Bpmbb7rkemy1rcyE10wms3dTsEFBz1URW0MCjimf7puX44D
         xW+lYXIyc6U2ZzJB1ct1sfVPonwEUTr1LGKujUNB0wsdB070eYs78wgzPnpmbkCKAmS/
         67JQ2vq9ziQn7goa14AL5ytGnFQ9Jh6ZCu9K0fey7iyQWdltpnsjbjbC+75pmDxPdrBW
         rLScWNZRwYWGkALhab+zbTAW7EnEp6603Jma0BKT37y7l5NnqoDjtUkmxHWhRyGHllHm
         H8sA==
X-Gm-Message-State: AO0yUKUxTv+6Umu9KbHbCwx9YkcYMd8R0fJMkj30rCACbvFkFY+vlxos
	ZpkzuAUQgH0zLHUQoxAD5lLJyDHoEihbY3jgbQa5Nw==
X-Google-Smtp-Source: AK7set9xJdp2Jn0OdtwF4B8xem0JwY3G7gIoxRfa+ltgkqfUH3QSi2WgRnvWRWvCnp3n6zal0K4iFw==
X-Received: by 2002:a17:903:247:b0:19a:9880:175f with SMTP id j7-20020a170903024700b0019a9880175fmr2986343plh.51.1679493372876;
        Wed, 22 Mar 2023 06:56:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s7-20020a170902988700b0019edd34dac9sm10631137plp.60.2023.03.22.06.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 06:56:12 -0700 (PDT)
Message-ID: <641b08fc.170a0220.fd693.314f@mx.google.com>
Date: Wed, 22 Mar 2023 06:56:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.175-cip29-rt12
Subject: cip/linux-5.10.y-cip-rt baseline-nfs: 52 runs,
 23 regressions (v5.10.175-cip29-rt12)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Mar 2023 13:56:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11082

cip/linux-5.10.y-cip-rt baseline-nfs: 52 runs, 23 regressions (v5.10.175-ci=
p29-rt12)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =

acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =

asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =

asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

dell-latitude...4305U-sarien | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =

dell-latitude...4305U-sarien | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =

dell-latitude...8665U-sarien | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =

dell-latitude...8665U-sarien | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =

imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+preempt_rt         | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.175-cip29-rt12/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.175-cip29-rt12
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      0a6a8df2de5a8e8f024b47926cff286c6ec0e31f =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/641afccd64aa7b621f9c952c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-nfs-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-nfs-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/641afccd64aa7b621f9c9535
        failing since 54 days (last pass: v5.10.158-cip22-rt9, first fail: =
v5.10.162-cip24-rt10)

    2023-03-22T13:03:54.605979  <8>[   17.136036] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9730062_1.5.2.3.1>

    2023-03-22T13:03:54.715378  / # #

    2023-03-22T13:03:54.816481  export SHELL=3D/bin/sh

    2023-03-22T13:03:54.816733  #

    2023-03-22T13:03:54.917550  / # export SHELL=3D/bin/sh. /lava-9730062/e=
nvironment

    2023-03-22T13:03:54.917801  =


    2023-03-22T13:03:55.018772  / # . /lava-9730062/environment/lava-973006=
2/bin/lava-test-runner /lava-9730062/1

    2023-03-22T13:03:55.019109  =


    2023-03-22T13:03:55.024423  / # /lava-9730062/bin/lava-test-runner /lav=
a-9730062/1

    2023-03-22T13:03:55.141930  + export TESTRUN_ID=3D1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/641afa119d814854139c952c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-nfs-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-nfs-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/641afa119d814854139c9535
        failing since 54 days (last pass: v5.10.158-cip22-rt9, first fail: =
v5.10.162-cip24-rt10)

    2023-03-22T12:52:19.527256  <8>[   16.812832] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9729848_1.5.2.3.1>

    2023-03-22T12:52:19.629503  / ##

    2023-03-22T12:52:19.730557  export SHELL=3D/bin/sh

    2023-03-22T12:52:19.730780   #

    2023-03-22T12:52:19.831503  / # export SHELL=3D/bin/sh. /lava-9729848/e=
nvironment

    2023-03-22T12:52:19.831808  =


    2023-03-22T12:52:19.932640  / # . /lava-9729848/environment/lava-972984=
8/bin/lava-test-runner /lava-9729848/1

    2023-03-22T12:52:19.932958  =


    2023-03-22T12:52:19.938453  / # /lava-9729848/bin/lava-test-runner /lav=
a-9729848/1

    2023-03-22T12:52:20.065681  + export TESTRUN_ID=3D1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/641afd595ff8c5068a9c950c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/641afd595ff8c5068=
a9c950d
        new failure (last pass: v5.10.162-cip24-rt10) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/641afb020301649d899c9521

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/641afb020301649d8=
99c9522
        new failure (last pass: v5.10.162-cip24-rt10) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/641afd6c6b2d889e0d9c950f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-nfs-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-nfs-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/641afd6c6b2d889e0=
d9c9510
        new failure (last pass: v5.10.162-cip24-rt10) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/641afc161e0a1a0a2e9c951c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-nfs-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-nfs-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/641afc161e0a1a0a2=
e9c951d
        new failure (last pass: v5.10.162-cip24-rt10) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/641afc8eb96fc54c4c9c950a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/641afc8eb96fc54c4c9c9513
        failing since 54 days (last pass: v5.10.158-cip22-rt9, first fail: =
v5.10.162-cip24-rt10)

    2023-03-22T13:03:05.842869  <#

    2023-03-22T13:03:05.843288  8>[   17.019633] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 9730041_1.5.2.3.1>

    2023-03-22T13:03:05.944312  / # #export SHELL=3D/bin/sh

    2023-03-22T13:03:05.944539  =


    2023-03-22T13:03:06.045469  / # export SHELL=3D/bin/sh. /lava-9730041/e=
nvironment

    2023-03-22T13:03:06.045713  =


    2023-03-22T13:03:06.146650  / # . /lava-9730041/environment/lava-973004=
1/bin/lava-test-runner /lava-9730041/1

    2023-03-22T13:03:06.146969  =


    2023-03-22T13:03:06.151831  / # /lava-9730041/bin/lava-test-runner /lav=
a-9730041/1

    2023-03-22T13:03:06.326100  + export TESTRUN_ID=3D1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/641afc3e8420653add9c95a4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/641afc3e8420653add9c95ad
        failing since 54 days (last pass: v5.10.158-cip22-rt9, first fail: =
v5.10.162-cip24-rt10)

    2023-03-22T13:01:26.924553  <8>[   17.081911] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-03-22T13:01:26.924643  + set +x

    2023-03-22T13:01:26.930765  <8>[   17.092410] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9729839_1.5.2.3.1>

    2023-03-22T13:01:27.035673  / # #

    2023-03-22T13:01:27.136711  export SHELL=3D/bin/sh

    2023-03-22T13:01:27.136941  #

    2023-03-22T13:01:27.237834  / # export SHELL=3D/bin/sh. /lava-9729839/e=
nvironment

    2023-03-22T13:01:27.238047  =


    2023-03-22T13:01:27.338975  / # . /lava-9729839/environment/lava-972983=
9/bin/lava-test-runner /lava-9729839/1

    2023-03-22T13:01:27.339312  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/641afd427ce806806a9c9552

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-nfs-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-nfs-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/641afd427ce806806=
a9c9553
        new failure (last pass: v5.10.162-cip24-rt10) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/641afb010301649d899c951e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-nfs-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-nfs-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/641afb010301649d8=
99c951f
        new failure (last pass: v5.10.162-cip24-rt10) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/641b030bdc3beb48f59c9514

  Results:     30 PASS, 15 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/arm/defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-bla=
ck.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/arm/defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-bla=
ck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/641b030bdc3beb48f59c9544
        failing since 54 days (last pass: v5.10.158-cip22-rt9, first fail: =
v5.10.162-cip24-rt10)

    2023-03-22T13:30:15.618727  + set +x
    2023-03-22T13:30:15.733028  <8>[   50.572894] <LAVA_SIGNAL_TESTCASE#
    2023-03-22T13:30:15.734223   TEST_CASE_ID=3Demerg RESULT=3Dpass UNITS=
=3Dlines MEASUREMENT=3D0>
    2023-03-22T13:30:15.734664  <8>[   50.574588] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 207140_1.6.2.4.1>
    2023-03-22T13:30:15.836797  / # #export SHELL=3D/bin/sh
    2023-03-22T13:30:15.837437  =

    2023-03-22T13:30:15.938845  / # export SHELL=3D/bin/sh. /lava-207140/en=
vironment
    2023-03-22T13:30:15.939412  =

    2023-03-22T13:30:16.041275  / # . /lava-207140/environment/lava-207140/=
bin/lava-test-runner /lava-207140/1
    2023-03-22T13:30:16.042111   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/641afd52088e0122399c952e

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-beagl=
ebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-beagl=
ebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/641afd52088e0122399c955f
        failing since 54 days (last pass: v5.10.158-cip22-rt9, first fail: =
v5.10.162-cip24-rt10)

    2023-03-22T13:05:42.895847  [   53.471357] <LAVA_SIGNAL_ENDRUN 0_dmesg =
206896_1.6.2.4.1>
    2023-03-22T13:05:43.002399  =

    2023-03-22T13:05:43.104461  / # #export SHELL=3D/bin/sh
    2023-03-22T13:05:43.104906  =

    2023-03-22T13:05:43.206462  / # export SHELL=3D/bin/sh. /lava-206896/en=
vironment
    2023-03-22T13:05:43.206891  =

    2023-03-22T13:05:43.308281  / # . /lava-206896/environment/lava-206896/=
bin/lava-test-runner /lava-206896/1
    2023-03-22T13:05:43.309080  =

    2023-03-22T13:05:43.313892  / # /lava-206896/bin/lava-test-runner /lava=
-206896/1
    2023-03-22T13:05:43.500561  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/641b01180c88027e3b9c950d

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nfs-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nfs-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/641b01180c88027e3b9c9546
        new failure (last pass: v5.10.158-cip22-rt9)

    2023-03-22T13:21:59.946981  <8>[   47.613393] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 207002_1.6.2.4.1>
    2023-03-22T13:22:00.064785  / # #
    2023-03-22T13:22:00.169128  export SHELL=3D/bin/sh
    2023-03-22T13:22:00.169885  #
    2023-03-22T13:22:00.272424  / # export SHELL=3D/bin/sh. /lava-207002/en=
vironment
    2023-03-22T13:22:00.273357  =

    2023-03-22T13:22:00.375601  / # . /lava-207002/environment/lava-207002/=
bin/lava-test-runner /lava-207002/1
    2023-03-22T13:22:00.376891  =

    2023-03-22T13:22:00.381381  / # /lava-207002/bin/lava-test-runner /lava=
-207002/1
    2023-03-22T13:22:00.671195  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
dell-latitude...4305U-sarien | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/641afd56a93124b2259c9505

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-nfs-dell-latitude-5400-4305U-sarien.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-nfs-dell-latitude-5400-4305U-sarien.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/641afd56a93124b22=
59c9506
        new failure (last pass: v5.10.162-cip24-rt10) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
dell-latitude...4305U-sarien | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/641afb147b31187cc49c9530

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-nfs-dell-latitude-5400-4305U-sarien.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-nfs-dell-latitude-5400-4305U-sarien.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/641afb147b31187cc=
49c9531
        new failure (last pass: v5.10.162-cip24-rt10) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
dell-latitude...8665U-sarien | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/641b076cd37b35ce329c9567

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-nfs-dell-latitude-5400-8665U-sarien.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-nfs-dell-latitude-5400-8665U-sarien.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/641b076cd37b35ce3=
29c9568
        new failure (last pass: v5.10.162-cip24-rt10) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
dell-latitude...8665U-sarien | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/641afb12e2bf6f9d029c9505

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-nfs-dell-latitude-5400-8665U-sarien.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-nfs-dell-latitude-5400-8665U-sarien.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/641afb12e2bf6f9d0=
29c9506
        new failure (last pass: v5.10.162-cip24-rt10) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/641afed3ba05fa91c39c95db

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/641afed3ba05fa91c=
39c95dc
        new failure (last pass: v5.10.162-cip24-rt10) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/641afc2ae1cb9185c09c9515

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/641afc2ae1cb9185c=
09c9516
        new failure (last pass: v5.10.162-cip24-rt10) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/641b028712bf9e5b359c95dd

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/arm/defconfig/gcc-10/lab-collabora/baseline-nfs-imx6q-sabrel=
ite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/arm/defconfig/gcc-10/lab-collabora/baseline-nfs-imx6q-sabrel=
ite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/641b028712bf9e5b359c95e3
        failing since 54 days (last pass: v5.10.158-cip22-rt9, first fail: =
v5.10.162-cip24-rt10)

    2023-03-22T13:28:15.096205  + set +x

    2023-03-22T13:28:15.127914  / # [   25.543655] <LAVA_SIGNAL_TESTCASE TE=
ST_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-03-22T13:28:15.128377  [   25.544626] <LAVA_SIGNAL_ENDRUN 0_dmesg =
9730549_1.6.2.4.1>

    2023-03-22T13:28:15.233849  #

    2023-03-22T13:28:15.337125  export SHELL=3D/bin/sh

    2023-03-22T13:28:15.338115  #

    2023-03-22T13:28:15.440190  / # export SHELL=3D/bin/sh. /lava-9730549/e=
nvironment

    2023-03-22T13:28:15.441034  =


    2023-03-22T13:28:15.542931  / # . /lava-9730549/environment/lava-973054=
9/bin/lava-test-runner /lava-9730549/1

    2023-03-22T13:28:15.543299  =

 =

    ... (17 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/641afcbe92f57ca91f9c9533

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-nfs-imx=
6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-nfs-imx=
6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/641afcbe92f57ca91f9c953c
        failing since 54 days (last pass: v5.10.158-cip22-rt9, first fail: =
v5.10.162-cip24-rt10)

    2023-03-22T13:03:50.538158  / # #

    2023-03-22T13:03:50.641357  export SHELL=3D/bin/sh

    2023-03-22T13:03:50.642222  #

    2023-03-22T13:03:50.744365  / # export SHELL=3D/bin/sh. /lava-9730077/e=
nvironment

    2023-03-22T13:03:50.745193  =


    2023-03-22T13:03:50.847480  / # . /lava-9730077/environment/lava-973007=
7/bin/lava-test-runner /lava-9730077/1

    2023-03-22T13:03:50.848726  =


    2023-03-22T13:03:50.861289  / # /lava-9730077/bin/lava-test-runner /lav=
a-9730077/1

    2023-03-22T13:03:50.995631  + export TESTRUN_ID=3D1_bootrr

    2023-03-22T13:03:50.995842  + cd /lava-9730077/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/641b04b9c9d53d00029c9516

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/arm64/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-nfs-m=
eson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/arm64/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-nfs-m=
eson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/641b04b9c9d53d000=
29c9517
        new failure (last pass: v5.10.162-cip24-rt10) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/641b068cce40b7e9059c9515

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-sun50i-a64-p=
ine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-sun50i-a64-p=
ine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/641b068cce40b7e90=
59c9516
        new failure (last pass: v5.10.162-cip24-rt10) =

 =20

