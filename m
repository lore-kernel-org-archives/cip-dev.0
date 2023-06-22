Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425AFEB64DA
	for <webhook@archiver.kernel.org>; Thu, 22 Jun 2023 13:11:17 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web10.11011.1687439473382621457
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 22 Jun 2023 06:11:13 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=kYxfeYN/;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.180, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1b512309c86so4656085ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 22 Jun 2023 06:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687439472; x=1690031472;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HzgYjzAd+OBfhhQ/GC6SQbtcWFmO7mvfiRbz846rJ8I=;
        b=kYxfeYN/H1j6+D72f5F388SoXq0sRXVtADUA2tEKaem/cAxOIel5WnFCxehCXJnEXl
         KhgHDVXxgIBSIuxQStoS3SS4DIUIb07RfKqBP0na0/lBSVCS+6JjnJWQh78ZEjvD2xtj
         rLDNxPDMC6Grorn72vMCJ9FEuGwvQu/+PgNZW+2ctIqHiyrze/Qgb7evDhrUdSa0OsBj
         7dX0+l1yV7MNS5MwCdOt1bqcFkrJawCsSnmqHXwUTCKybCjALmiCe194BNRlfhzEsVAk
         ER/p3tQ/TGUZs9X2jwkjH7qP4KKI23mIca74kRtj7S49gvG96phAGRpQn5vDHhoJ7Ok3
         1YAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687439472; x=1690031472;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HzgYjzAd+OBfhhQ/GC6SQbtcWFmO7mvfiRbz846rJ8I=;
        b=Lbn/g+8U4AMk6cWr85vsCwb+HH9++TqFFypY9Abh7fr4zypUeX/IQ5gNRf0WJGPW63
         1/o95kQnpinWlVzr99tfpEVaxp613LOtATFcGoqFcHm5hR9iy7FzZZzdPRNQGWUbPSe0
         8tDMOZHYwBrD+Qi/RP9ojNAq3vSwdG3vUHaxWZEP6tzRgkuSU4rC7Wyn5AqHwOAHvXcU
         ojDdaH32hsmuVmHUOthbj11Z5r7l7PbtIbkuZZK2zUrD+VlS4L/EJwvnumGQdi/Y/JIG
         ri97KQ8BFxkbRzUnqkJwdLpc4D04nuMuIVTSeu/gjiJzmd5xHMp65UjK5yQW0piESSMG
         d48g==
X-Gm-Message-State: AC+VfDzLfVZgwmsqlIcPsFyI8Xr0ODDZcdwm99tcNZWJ2i8eW5fZmLY/
	VnPBlixDfDBfcd/U18PskaLXesiYfF17PfqFGpyBsw==
X-Google-Smtp-Source: ACHHUZ6D1CUaacsgiGau2Luv+VCFbQ0848+kAQwXsIWxbupwUaVZt7WewKiIDw0TemBLv2EoNrbelQ==
X-Received: by 2002:a17:902:e541:b0:1b6:a91d:bd1f with SMTP id n1-20020a170902e54100b001b6a91dbd1fmr4278694plf.6.1687439471402;
        Thu, 22 Jun 2023 06:11:11 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p9-20020a1709026b8900b001b66a71a4a0sm5361897plk.32.2023.06.22.06.11.09
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 06:11:10 -0700 (PDT)
Message-ID: <6494486e.170a0220.36ff1.c089@mx.google.com>
Date: Thu, 22 Jun 2023 06:11:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.31-61-g32a95f5a4e3b
Subject: cip-gitlab/ci/pavel/linux-test baseline: 96 runs,
 18 regressions (v6.1.31-61-g32a95f5a4e3b)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 22 Jun 2023 13:11:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12128

cip-gitlab/ci/pavel/linux-test baseline: 96 runs, 18 regressions (v6.1.31-6=
1-g32a95f5a4e3b)

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

juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 2          =

rk3399-rock-pi-4b            | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.31-61-g32a95f5a4e3b/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.31-61-g32a95f5a4e3b
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      32a95f5a4e3b66089d84743bbec9da44020328ba =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64943c6db63a1dc4c230614f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64943c6db63a1dc4c2306158
        new failure (last pass: v5.10.182-cip35-8-g2391124f19a70)

    2023-06-22T12:19:53.381985  + set +x

    2023-06-22T12:19:53.388994  <8>[   10.705348] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10860365_1.4.2.3.1>

    2023-06-22T12:19:53.496374  / # #

    2023-06-22T12:19:53.598683  export SHELL=3D/bin/sh

    2023-06-22T12:19:53.599414  #

    2023-06-22T12:19:53.701018  / # export SHELL=3D/bin/sh. /lava-10860365/=
environment

    2023-06-22T12:19:53.701749  =


    2023-06-22T12:19:53.803252  / # . /lava-10860365/environment/lava-10860=
365/bin/lava-test-runner /lava-10860365/1

    2023-06-22T12:19:53.804442  =


    2023-06-22T12:19:53.810442  / # /lava-10860365/bin/lava-test-runner /la=
va-10860365/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64943bdd4bec101d953061ce

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64943bdd4bec101d953061d7
        new failure (last pass: v5.10.182-cip35-8-g2391124f19a70)

    2023-06-22T12:17:13.302366  + set<8>[   11.533106] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10860324_1.4.2.3.1>

    2023-06-22T12:17:13.302476   +x

    2023-06-22T12:17:13.407422  / # #

    2023-06-22T12:17:13.508111  export SHELL=3D/bin/sh

    2023-06-22T12:17:13.508360  #

    2023-06-22T12:17:13.608924  / # export SHELL=3D/bin/sh. /lava-10860324/=
environment

    2023-06-22T12:17:13.609140  =


    2023-06-22T12:17:13.709685  / # . /lava-10860324/environment/lava-10860=
324/bin/lava-test-runner /lava-10860324/1

    2023-06-22T12:17:13.710000  =


    2023-06-22T12:17:13.714635  / # /lava-10860324/bin/lava-test-runner /la=
va-10860324/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64943bc19a4932f7b4306170

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64943bc19a4932f7b4306179
        new failure (last pass: v5.10.182-cip35-8-g2391124f19a70)

    2023-06-22T12:16:51.846364  <8>[   10.557122] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10860340_1.4.2.3.1>

    2023-06-22T12:16:51.850020  + set +x

    2023-06-22T12:16:51.955466  #

    2023-06-22T12:16:51.957600  =


    2023-06-22T12:16:52.060605  / # #export SHELL=3D/bin/sh

    2023-06-22T12:16:52.061357  =


    2023-06-22T12:16:52.162754  / # export SHELL=3D/bin/sh. /lava-10860340/=
environment

    2023-06-22T12:16:52.163431  =


    2023-06-22T12:16:52.264965  / # . /lava-10860340/environment/lava-10860=
340/bin/lava-test-runner /lava-10860340/1

    2023-06-22T12:16:52.266326  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | bcm283=
5_defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/64943d851da0d308f3306160

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/arm/bcm2835_defconfig/gcc-10/lab-collabora/baseli=
ne-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/arm/bcm2835_defconfig/gcc-10/lab-collabora/baseli=
ne-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64943d851da0d308f3306169
        new failure (last pass: v5.10.182-cip35-8-g2391124f19a70)

    2023-06-22T12:25:10.325093  / # #

    2023-06-22T12:25:10.427362  export SHELL=3D/bin/sh

    2023-06-22T12:25:10.428104  #

    2023-06-22T12:25:10.529578  / # export SHELL=3D/bin/sh. /lava-10860286/=
environment

    2023-06-22T12:25:10.530338  =


    2023-06-22T12:25:10.631813  / # . /lava-10860286/environment/lava-10860=
286/bin/lava-test-runner /lava-10860286/1

    2023-06-22T12:25:10.633007  =


    2023-06-22T12:25:10.649248  / # /lava-10860286/bin/lava-test-runner /la=
va-10860286/1

    2023-06-22T12:25:10.761209  + export 'TESTRUN_ID=3D1_bootrr'

    2023-06-22T12:25:10.761767  + cd /lava-10860286/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64943ce5fb1d8ec328306179

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/arm/multi_v7_defconfig/gcc-10/lab-collabora/basel=
ine-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/arm/multi_v7_defconfig/gcc-10/lab-collabora/basel=
ine-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64943ce5fb1d8ec328306=
17a
        failing since 7 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921e=
9, first fail: v5.10.182-cip35-8-g2391124f19a70) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64943fb1f888a8dbce30617c

  Results:     52 PASS, 3 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseli=
ne-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseli=
ne-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64943fb1f888a8dbce3061af
        failing since 7 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921e=
9, first fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-06-22T12:33:39.247330  <8>[   21.782970] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 652498_1.5.2.4.1>
    2023-06-22T12:33:39.354188  / # #
    2023-06-22T12:33:39.456153  export SHELL=3D/bin/sh
    2023-06-22T12:33:39.456862  #
    2023-06-22T12:33:39.558459  / # export SHELL=3D/bin/sh. /lava-652498/en=
vironment
    2023-06-22T12:33:39.559002  =

    2023-06-22T12:33:39.660718  / # . /lava-652498/environment/lava-652498/=
bin/lava-test-runner /lava-652498/1
    2023-06-22T12:33:39.661375  =

    2023-06-22T12:33:39.666069  / # /lava-652498/bin/lava-test-runner /lava=
-652498/1
    2023-06-22T12:33:39.776813  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/649445c23f6d28b8d0306142

  Results:     52 PASS, 3 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-b=
eaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-b=
eaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649445c23f6d28b8d0306149
        failing since 7 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921e=
9, first fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-06-22T12:59:33.242607  <8>[   16.005578] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 971318_1.5.2.4.1>
    2023-06-22T12:59:33.351380  / # #
    2023-06-22T12:59:33.453828  export SHELL=3D/bin/sh
    2023-06-22T12:59:33.454561  #
    2023-06-22T12:59:33.556209  / # export SHELL=3D/bin/sh. /lava-971318/en=
vironment
    2023-06-22T12:59:33.556970  =

    2023-06-22T12:59:33.658692  / # . /lava-971318/environment/lava-971318/=
bin/lava-test-runner /lava-971318/1
    2023-06-22T12:59:33.659997  =

    2023-06-22T12:59:33.666471  / # /lava-971318/bin/lava-test-runner /lava=
-971318/1
    2023-06-22T12:59:33.773347  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64943befe40d6f2d20306150

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64943befe40d6f2d20306159
        failing since 7 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921e=
9, first fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-06-22T12:17:33.430109  + set +x

    2023-06-22T12:17:33.436177  <8>[   11.035948] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10860366_1.4.2.3.1>

    2023-06-22T12:17:33.543818  / # #

    2023-06-22T12:17:33.646244  export SHELL=3D/bin/sh

    2023-06-22T12:17:33.646971  #

    2023-06-22T12:17:33.748476  / # export SHELL=3D/bin/sh. /lava-10860366/=
environment

    2023-06-22T12:17:33.749223  =


    2023-06-22T12:17:33.850798  / # . /lava-10860366/environment/lava-10860=
366/bin/lava-test-runner /lava-10860366/1

    2023-06-22T12:17:33.852116  =


    2023-06-22T12:17:33.856904  / # /lava-10860366/bin/lava-test-runner /la=
va-10860366/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64943bc29a4932f7b430617b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64943bc29a4932f7b4306184
        failing since 7 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921e=
9, first fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-06-22T12:16:58.336171  <8>[   10.782096] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10860298_1.4.2.3.1>

    2023-06-22T12:16:58.339676  + set +x

    2023-06-22T12:16:58.441079  #

    2023-06-22T12:16:58.441393  =


    2023-06-22T12:16:58.541948  / # #export SHELL=3D/bin/sh

    2023-06-22T12:16:58.542138  =


    2023-06-22T12:16:58.642638  / # export SHELL=3D/bin/sh. /lava-10860298/=
environment

    2023-06-22T12:16:58.642830  =


    2023-06-22T12:16:58.743345  / # . /lava-10860298/environment/lava-10860=
298/bin/lava-test-runner /lava-10860298/1

    2023-06-22T12:16:58.743617  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64943bdfe55cbb9adb30612f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64943bdfe55cbb9adb306138
        new failure (last pass: v5.10.182-cip35-8-g2391124f19a70)

    2023-06-22T12:17:26.181805  + set<8>[   11.088682] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10860368_1.4.2.3.1>

    2023-06-22T12:17:26.182287   +x

    2023-06-22T12:17:26.290345  / # #

    2023-06-22T12:17:26.392701  export SHELL=3D/bin/sh

    2023-06-22T12:17:26.393496  #

    2023-06-22T12:17:26.494937  / # export SHELL=3D/bin/sh. /lava-10860368/=
environment

    2023-06-22T12:17:26.495669  =


    2023-06-22T12:17:26.597121  / # . /lava-10860368/environment/lava-10860=
368/bin/lava-test-runner /lava-10860368/1

    2023-06-22T12:17:26.598377  =


    2023-06-22T12:17:26.603188  / # /lava-10860368/bin/lava-test-runner /la=
va-10860368/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64943b13fbe74948483061ab

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/bas=
eline-imx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/bas=
eline-imx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64943b13fbe74948483061b4
        new failure (last pass: v5.10.182-cip35-8-g2391124f19a70)

    2023-06-22T12:13:45.666643  + set +x
    2023-06-22T12:13:45.666813  [   12.852846] <LAVA_SIGNAL_ENDRUN 0_dmesg =
985389_1.5.2.3.1>
    2023-06-22T12:13:45.774386  / # #
    2023-06-22T12:13:45.875923  export SHELL=3D/bin/sh
    2023-06-22T12:13:45.876328  #
    2023-06-22T12:13:45.977538  / # export SHELL=3D/bin/sh. /lava-985389/en=
vironment
    2023-06-22T12:13:45.978001  =

    2023-06-22T12:13:46.079306  / # . /lava-985389/environment/lava-985389/=
bin/lava-test-runner /lava-985389/1
    2023-06-22T12:13:46.079920  =

    2023-06-22T12:13:46.083525  / # /lava-985389/bin/lava-test-runner /lava=
-985389/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64943bf0e40d6f2d2030616f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseli=
ne-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseli=
ne-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64943bf0e40d6f2d20306=
170
        failing since 7 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921e=
9, first fail: v5.10.182-cip35-8-g2391124f19a70) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64943bf23a5540535730615f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseli=
ne-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseli=
ne-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64943bf23a55405357306=
160
        failing since 7 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921e=
9, first fail: v5.10.182-cip35-8-g2391124f19a70) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6494444857dcde2e66306158

  Results:     60 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-=
uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-=
uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6494444857dcde2e66306195
        new failure (last pass: v5.10.182-cip35-8-g2391124f19a70)

    2023-06-22T12:53:11.029632  <8>[   16.107241] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 652443_1.5.2.4.1>
    2023-06-22T12:53:11.138817  / # #
    2023-06-22T12:53:11.242044  export SHELL=3D/bin/sh
    2023-06-22T12:53:11.242929  #
    2023-06-22T12:53:11.344996  / # export SHELL=3D/bin/sh. /lava-652443/en=
vironment
    2023-06-22T12:53:11.345924  =

    2023-06-22T12:53:11.447919  / # . /lava-652443/environment/lava-652443/=
bin/lava-test-runner /lava-652443/1
    2023-06-22T12:53:11.449356  =

    2023-06-22T12:53:11.461125  / # /lava-652443/bin/lava-test-runner /lava=
-652443/1
    2023-06-22T12:53:11.527492  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (41 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64943bc44bec101d95306145

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64943bc44bec101d9530614e
        new failure (last pass: v5.10.182-cip35-8-g2391124f19a70)

    2023-06-22T12:16:59.929004  <8>[   11.830047] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10860335_1.4.2.3.1>

    2023-06-22T12:17:00.033058  / # #

    2023-06-22T12:17:00.133665  export SHELL=3D/bin/sh

    2023-06-22T12:17:00.133846  #

    2023-06-22T12:17:00.234376  / # export SHELL=3D/bin/sh. /lava-10860335/=
environment

    2023-06-22T12:17:00.234534  =


    2023-06-22T12:17:00.335321  / # . /lava-10860335/environment/lava-10860=
335/bin/lava-test-runner /lava-10860335/1

    2023-06-22T12:17:00.335573  =


    2023-06-22T12:17:00.340147  / # /lava-10860335/bin/lava-test-runner /la=
va-10860335/1

    2023-06-22T12:17:00.346892  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 2          =


  Details:     https://kernelci.org/test/plan/id/64943b05fbe7494848306154

  Results:     66 PASS, 4 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/arm/multi_v7_defconfig/gcc-10/lab-collabora/basel=
ine-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/arm/multi_v7_defconfig/gcc-10/lab-collabora/basel=
ine-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/64943b05fbe7494848306188
        failing since 153 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-06-22T12:14:47.393734  Usage: seq [-w] [-s SEP] [FIRST [INC]] LA<8=
>[   19.659110] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-06-22T12:14:47.393954  ST

    2023-06-22T12:14:47.394387  =


    2023-06-22T12:14:47.399495  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-06-22T12:14:47.401681  FIRST, INC default to 1.

    2023-06-22T12:14:47.402156  =


    2023-06-22T12:14:47.405464  	-w	Pad to last with leading zeros
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/64943b05fbe7494848306189
        failing since 153 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-06-22T12:14:47.363252  <8>[   19.635322] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>

    2023-06-22T12:14:47.379472  BusyBox v1.31.1 (2023-06-09 10:32:04 UTC) m=
ulti-call binary.

    2023-06-22T12:14:47.379827  =

   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64943e3d78cd2cec4a3061e9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3=
399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3=
399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64943e3d78cd2cec4a3061f2
        new failure (last pass: v5.10.182-cip35-8-g2391124f19a70)

    2023-06-22T12:27:31.749811  / # #

    2023-06-22T12:27:33.003761  export SHELL=3D/bin/sh

    2023-06-22T12:27:33.014082  #

    2023-06-22T12:27:33.014207  / # export SHELL=3D/bin/sh

    2023-06-22T12:27:34.754192  / # . /lava-10860398/environment

    2023-06-22T12:27:37.947132  /lava-10860398/bin/lava-test-runner /lava-1=
0860398/1

    2023-06-22T12:27:37.957696  . /lava-10860398/environment

    2023-06-22T12:27:37.960405  / # /lava-10860398/bin/lava-test-runner /la=
va-10860398/1

    2023-06-22T12:27:38.012212  + export 'TESTRUN_ID=3D1_bootrr'

    2023-06-22T12:27:38.012303  + cd /lava-10860398/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =20

