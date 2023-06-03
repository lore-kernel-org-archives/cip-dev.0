Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4EE5C77B73
	for <webhook@archiver.kernel.org>; Sat,  3 Jun 2023 17:13:26 +0000 (UTC)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
 by mx.groups.io with SMTP id smtpd.web10.1530.1685812397843964103
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 03 Jun 2023 10:13:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=REdp5G7h;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.43, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-25690e009c8so1452899a91.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 03 Jun 2023 10:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685812397; x=1688404397;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZqV2EP2UBF6YsGSr11hApZ6y6iddE0YkkEL2i2m/QEc=;
        b=REdp5G7h/LfDbfWC9L2bAakrUqTubWTLG80AZeWL4i1poK5/smmj0SDFIHxcCpobGP
         XAX43D4RHYTp96juJtGRUZSY4ir3oNCrusY1ciufp3/rN5gb+jUQULs33i9D2Jgd58dx
         ejwdomAP0cPRSHeUqkEeSZ7XeuOc12w+ZpzYcHE98/rCdl9wo35fooOUFSSyavJhvvty
         AV7T6+0Nl69Pl/XSO4XIjgZzppMTmOkApkT2gwlSOgv/U4pb80lMUS9m/SZQUp1Fuetu
         xrBZeAWInvCBf1IRwVQHmmEAnnzIveHDS51w6ILTSlH5M8drqJ5U8PnlGc4HW/Yn/wTC
         p+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685812397; x=1688404397;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZqV2EP2UBF6YsGSr11hApZ6y6iddE0YkkEL2i2m/QEc=;
        b=Gz4Qa6uSAwaOljKs5DRnFelktXO3D9uZHQ9+5/J6Oml3i9DAyVN1OkFc7GCFNqFRUv
         dryG2ciyi+0eFLE1zgRyuwN0YzkRJcUUu7FdIKALEneXSDyNDrdZ97+JSgouXqnWEfMr
         J77q24Y4wyeddxYBKgZOmPzLQfD6RkAUV+Jm38DU2rDHG2SOlOydqkqzdA4hZT3JXPd9
         xABPjR7REeUM1aTdPDqiNu1+BZHY6UzUCi+4NRb+yCRHkK3hZ9a8euHtJpm8oGJwVKSy
         04h2WWZ66iwlbTJa1UBR+wqiqN2ic9nnoKiNi85ChY/IM35wTjybekC5+1D9RXjFK8Ff
         3nag==
X-Gm-Message-State: AC+VfDxAck8Cf/g/DN9EeN3OL7lW04ZpNq7fDFBMEcIVOTP2R5Z4nv2l
	nfSCY8kKPO14+TNHNVjTnTgh8QqdCsGi0yOVVgV0wQ==
X-Google-Smtp-Source: ACHHUZ4OsHJAVzR+PonY78+IBwhPD2Wi2pPjMAryquQwS8GKxY4h8jY/wmvbcIvdbYmp0FP0wKLOcg==
X-Received: by 2002:a17:902:d487:b0:1b1:d8ce:73cb with SMTP id c7-20020a170902d48700b001b1d8ce73cbmr1301392plg.59.1685812396504;
        Sat, 03 Jun 2023 10:13:16 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y4-20020a170902ed4400b001ab0a30c895sm3422853plb.202.2023.06.03.10.13.15
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jun 2023 10:13:15 -0700 (PDT)
Message-ID: <647b74ab.170a0220.cbe6e.5d84@mx.google.com>
Date: Sat, 03 Jun 2023 10:13:15 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.26-1281-g84d5372e0f31
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 49 runs,
 8 regressions (v6.1.26-1281-g84d5372e0f31)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 03 Jun 2023 17:13:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11755

cip-gitlab/ci/pavel/linux-test baseline-nfs: 49 runs, 8 regressions (v6.1.2=
6-1281-g84d5372e0f31)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

rk3399-rock-pi-4b            | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.26-1281-g84d5372e0f31/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.26-1281-g84d5372e0f31
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      84d5372e0f314fb85258229768641315d1a95773 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647b668a7130402bb8f5de30

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1281-g84d5372e0f31/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-nfs-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1281-g84d5372e0f31/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-nfs-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647b668a7130402bb8f5de39
        new failure (last pass: v4.19.280-cip95-rt30)

    2023-06-03T16:12:50.288510  + <8>[   15.755017] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10575932_1.5.2.3.1>

    2023-06-03T16:12:50.288596  set +x

    2023-06-03T16:12:50.393057  / # #

    2023-06-03T16:12:50.493928  export SHELL=3D/bin/sh

    2023-06-03T16:12:50.494650  #

    2023-06-03T16:12:50.596096  / # export SHELL=3D/bin/sh. /lava-10575932/=
environment

    2023-06-03T16:12:50.596803  =


    2023-06-03T16:12:50.698051  / # . /lava-10575932/environment/lava-10575=
932/bin/lava-test-runner /lava-10575932/1

    2023-06-03T16:12:50.698374  =


    2023-06-03T16:12:50.703551  / # /lava-10575932/bin/lava-test-runner /la=
va-10575932/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647b6a2b89ba58d083f5df23

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1281-g84d5372e0f31/arm/multi_v5_defconfig/gcc-10/lab-broonie/basel=
ine-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1281-g84d5372e0f31/arm/multi_v5_defconfig/gcc-10/lab-broonie/basel=
ine-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armel/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/647b6a2b89ba58d08=
3f5df24
        new failure (last pass: v4.19.280-cip95-rt30) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647b6a5ff0f9c3aaf9f5dec2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1281-g84d5372e0f31/arm/omap2plus_defconfig/gcc-10/lab-broonie/base=
line-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1281-g84d5372e0f31/arm/omap2plus_defconfig/gcc-10/lab-broonie/base=
line-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/647b6a5ff0f9c3aaf=
9f5dec3
        failing since 17 days (last pass: v5.10.177-cip31-33-gd59f246891e73=
, first fail: v5.10.179-cip32-4-g580ea5dd85ae) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647b66ddc1d00ebe45f5de27

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1281-g84d5372e0f31/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1281-g84d5372e0f31/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647b66ddc1d00ebe45f5de30
        new failure (last pass: v4.19.280-cip95-rt30)

    2023-06-03T16:14:04.483802  + set +x

    2023-06-03T16:14:04.490412  <8>[   21.216015] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10575936_1.5.2.3.1>

    2023-06-03T16:14:04.594287  / # #

    2023-06-03T16:14:04.694965  export SHELL=3D/bin/sh

    2023-06-03T16:14:04.695207  #

    2023-06-03T16:14:04.795724  / # export SHELL=3D/bin/sh. /lava-10575936/=
environment

    2023-06-03T16:14:04.795903  =


    2023-06-03T16:14:04.896384  / # . /lava-10575936/environment/lava-10575=
936/bin/lava-test-runner /lava-10575936/1

    2023-06-03T16:14:04.896769  =


    2023-06-03T16:14:04.901206  / # /lava-10575936/bin/lava-test-runner /la=
va-10575936/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647b669d7130402bb8f5dfaf

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1281-g84d5372e0f31/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-nfs-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1281-g84d5372e0f31/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-nfs-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647b669d7130402bb8f5dfb8
        new failure (last pass: v4.19.280-cip95-rt30)

    2023-06-03T16:12:51.983217  + set +x<8>[   17.764893] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10575968_1.5.2.3.1>

    2023-06-03T16:12:51.983339  =


    2023-06-03T16:12:52.087974  / # #

    2023-06-03T16:12:52.188654  export SHELL=3D/bin/sh

    2023-06-03T16:12:52.188838  #

    2023-06-03T16:12:52.289303  / # export SHELL=3D/bin/sh. /lava-10575968/=
environment

    2023-06-03T16:12:52.289501  =


    2023-06-03T16:12:52.390054  / # . /lava-10575968/environment/lava-10575=
968/bin/lava-test-runner /lava-10575968/1

    2023-06-03T16:12:52.390377  =


    2023-06-03T16:12:52.395451  / # /lava-10575968/bin/lava-test-runner /la=
va-10575968/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647b69f479876dc766f5de50

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1281-g84d5372e0f31/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/=
baseline-nfs-imx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1281-g84d5372e0f31/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/=
baseline-nfs-imx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/647b69f479876dc76=
6f5de51
        new failure (last pass: v4.19.280-cip95-rt30) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647b66897130402bb8f5de25

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1281-g84d5372e0f31/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1281-g84d5372e0f31/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647b66897130402bb8f5de2e
        new failure (last pass: v4.19.280-cip95-rt30)

    2023-06-03T16:12:39.626325  <8>[   17.933729] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10575892_1.5.2.3.1>

    2023-06-03T16:12:39.731286  / # #

    2023-06-03T16:12:39.833368  export SHELL=3D/bin/sh

    2023-06-03T16:12:39.834052  #

    2023-06-03T16:12:39.935384  / # export SHELL=3D/bin/sh. /lava-10575892/=
environment

    2023-06-03T16:12:39.936195  =


    2023-06-03T16:12:40.037671  / # . /lava-10575892/environment/lava-10575=
892/bin/lava-test-runner /lava-10575892/1

    2023-06-03T16:12:40.038818  =


    2023-06-03T16:12:40.043719  / # /lava-10575892/bin/lava-test-runner /la=
va-10575892/1

    2023-06-03T16:12:40.095308  + export TESTRUN_ID=3D1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/647b6a2a8baec92cecf5de54

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1281-g84d5372e0f31/arm64/defconfig/gcc-10/lab-collabora/baseline-n=
fs-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1281-g84d5372e0f31/arm64/defconfig/gcc-10/lab-collabora/baseline-n=
fs-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647b6a2a8baec92cecf5de5d
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935)

    2023-06-03T16:28:09.059487  / # #

    2023-06-03T16:28:09.160021  export SHELL=3D/bin/sh

    2023-06-03T16:28:09.160173  #

    2023-06-03T16:28:09.260757  / # export SHELL=3D/bin/sh. /lava-10576057/=
environment

    2023-06-03T16:28:09.260906  =


    2023-06-03T16:28:09.361435  / # . /lava-10576057/environment/lava-10576=
057/bin/lava-test-runner /lava-10576057/1

    2023-06-03T16:28:09.361783  =


    2023-06-03T16:28:09.372704  / # /lava-10576057/bin/lava-test-runner /la=
va-10576057/1

    2023-06-03T16:28:09.552510  + export TESTRUN_ID=3D1_bootrr

    2023-06-03T16:28:09.552607  + cd /lava-10576057/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =20

