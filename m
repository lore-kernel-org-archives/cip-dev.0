Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04412C54E41
	for <webhook@archiver.kernel.org>; Sun,  3 Mar 2024 21:13:35 +0000 (UTC)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
 by mx.groups.io with SMTP id smtpd.web10.83228.1709500411227954187
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 03 Mar 2024 13:13:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=pH8XjTFr;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.167.175, mailfrom: bot@kernelci.org)
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3bd4e6a7cb0so2855918b6e.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 03 Mar 2024 13:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709500410; x=1710105210; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ln2qrU/pjIMWOHmepA9TaJWGal8B7yAuxZ0a6PoOsxA=;
        b=pH8XjTFrVAmOUmBHSFH4hq8cHqBbZp/v+vuYGIdFOQJ4+3GdwtgejyuLwENs6ND+EK
         SLTdbztUx/1Oimu2CCVkeaUymQw7xVA1hnzq7zzABB7c7wR1eTr5V6cqzX2icQR1uDUf
         UPsi8uI57kDPfm8XjxHIbUkQvCUoUl7AtPj+lbVSTCiYtvyonYDBLPtBgTVngkQw6DM9
         Fso95zRmrf1/YaoS4nw4EYNaRJqoNb5x/bcbd4aGly4w3f09RLCvekyhLTi7zSWCeGuu
         p2FoV0PHTKK/ksUDjL0canHzoL8pUoJwKU/zb22z20+/ps+HAcwWaxKsfxlldMuQbj6d
         T+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709500410; x=1710105210;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ln2qrU/pjIMWOHmepA9TaJWGal8B7yAuxZ0a6PoOsxA=;
        b=FFF7MydbOJqv0E7YvISpcBprYzm700H1p16QlhPtVIIpimyb2Rp3gkUiv2UvKMCDay
         6n+r8qJCVl+5e61DKphLJNRuKDXkISdTJmIaKQ7TTkwMyMT8I1BhoVbD0L2FozODmlE/
         lqyMWQ146+zslpyla8v80284i3Tn8x+v6A3zfrUfv8fvCKg/CmcrRTCcidYyHOEaCrFE
         GaF/izhB59dBCvhFgwXK+Aor1BQJhSkqUiZExDOz9fcshFN/s2LqtMEthAEuUqpl1Lwz
         YLj1khbpIs3qh/2VkYCg3f3KnTjBD/asZ4+j7PS+CrYmavQJXFfz1eDglsDEVrLYe8O8
         cNXQ==
X-Gm-Message-State: AOJu0YxfVv7M9YchD4nM2GzAt6o6r1CytSE2GrbzsUzKmfhFELlpuRyX
	wQ/1vLYTCbFv3A5suJ1k9NqfP9cqQI2gXqbkDQQTS6ija3sY2eoSHYd0S0pjkQ1LHqoNniv5dUb
	2fTk=
X-Google-Smtp-Source: AGHT+IFsgS0n+PCmebUsD/SuXVxnH6EbCZpDyGtvw1K18xrrHzjxoqEBeEwgThSQttXwmw1YP+OrJQ==
X-Received: by 2002:a05:6808:319b:b0:3c1:af64:436d with SMTP id cd27-20020a056808319b00b003c1af64436dmr11347013oib.41.1709500409594;
        Sun, 03 Mar 2024 13:13:29 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b64-20020a62cf43000000b006e5a915a9e7sm5369059pfg.10.2024.03.03.13.13.28
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 13:13:29 -0800 (PST)
Message-ID: <65e4e7f9.620a0220.566bf.7017@mx.google.com>
Date: Sun, 03 Mar 2024 13:13:29 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v6.1.78-cip15-547-gb5450675e67c
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 53 runs,
 11 regressions (v6.1.78-cip15-547-gb5450675e67c)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 03 Mar 2024 21:13:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15181

cip-gitlab/ci/pavel/linux-test baseline-nfs: 53 runs, 11 regressions (v6.1.=
78-cip15-547-gb5450675e67c)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig         | 1          =

bcm2835-rpi-b-rev2           | arm    | lab-broonie   | gcc-10   | bcm2835_=
defconfig          | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig        | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook | 1          =

stm32mp157a-dhcor-avenger96  | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig         | 1          =

sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.78-cip15-547-gb5450675e67c/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.78-cip15-547-gb5450675e67c
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b5450675e67cda5a44ee81ea4d17ab5db9b7deff =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65e4dd5a2cd99cfa2a637083

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/baseline-nfs-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/baseline-nfs-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65e4dd5a2cd99cfa2a637088
        failing since 0 day (last pass: v4.19.306-cip107-1142-gdcbd51e7744f=
, first fail: v6.1.78-cip15-404-gdddfc5d4f194)

    2024-03-03T20:28:01.044459  <8>[   13.183806] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12928251_1.5.2.3.1>

    2024-03-03T20:28:01.149132  / # #

    2024-03-03T20:28:01.249762  export SHELL=3D/bin/sh

    2024-03-03T20:28:01.249947  #

    2024-03-03T20:28:01.350471  / # export SHELL=3D/bin/sh. /lava-12928251/=
environment

    2024-03-03T20:28:01.350634  =


    2024-03-03T20:28:01.451176  / # . /lava-12928251/environment/lava-12928=
251/bin/lava-test-runner /lava-12928251/1

    2024-03-03T20:28:01.451437  =


    2024-03-03T20:28:01.456628  / # /lava-12928251/bin/lava-test-runner /la=
va-12928251/1

    2024-03-03T20:28:01.541072  + export TESTRUN_ID=3D1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65e4d60db89b04a67763701e

  Results:     48 PASS, 6 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/arm/multi_v5_defconfig/gcc-10/lab-broonie/=
baseline-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/arm/multi_v5_defconfig/gcc-10/lab-broonie/=
baseline-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/armel/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65e4d60db89b04a67763704d
        failing since 0 day (last pass: v4.19.306-cip107-1142-gdcbd51e7744f=
, first fail: v6.1.78-cip15-404-gdddfc5d4f194)

    2024-03-03T19:56:30.003653  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 657304_1.6.2=
.4.1>
    2024-03-03T19:56:30.119941  #
    2024-03-03T19:56:30.223178  / # #export SHELL=3D/bin/sh
    2024-03-03T19:56:30.223951  =

    2024-03-03T19:56:30.325893  / # export SHELL=3D/bin/sh. /lava-657304/en=
vironment
    2024-03-03T19:56:30.326696  =

    2024-03-03T19:56:30.428800  / # . /lava-657304/environment/lava-657304/=
bin/lava-test-runner /lava-657304/1
    2024-03-03T19:56:30.430028  =

    2024-03-03T19:56:30.434037  / # /lava-657304/bin/lava-test-runner /lava=
-657304/1
    2024-03-03T19:56:30.860393  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
bcm2835-rpi-b-rev2           | arm    | lab-broonie   | gcc-10   | bcm2835_=
defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/65e4e67fef113c6184637012

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/arm/bcm2835_defconfig/gcc-10/lab-broonie/b=
aseline-nfs-bcm2835-rpi-b-rev2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/arm/bcm2835_defconfig/gcc-10/lab-broonie/b=
aseline-nfs-bcm2835-rpi-b-rev2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/armel/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65e4e67fef113c618=
4637013
        new failure (last pass: v6.1.78-cip15-404-gdddfc5d4f194) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/65e4e1548df275c066637012

  Results:     52 PASS, 3 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/arm/omap2plus_defconfig/gcc-10/lab-broonie=
/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/arm/omap2plus_defconfig/gcc-10/lab-broonie=
/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65e4e1558df275c066637048
        failing since 0 day (last pass: v4.19.306-cip107-1142-gdcbd51e7744f=
, first fail: v6.1.78-cip15-404-gdddfc5d4f194)

    2024-03-03T20:44:38.210197  <8>[   44.226214] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 657575_1.6.2.4.1>
    2024-03-03T20:44:38.334590  / # #
    2024-03-03T20:44:38.437608  export SHELL=3D/bin/sh
    2024-03-03T20:44:38.438353  #
    2024-03-03T20:44:38.540245  / # export SHELL=3D/bin/sh. /lava-657575/en=
vironment
    2024-03-03T20:44:38.541104  =

    2024-03-03T20:44:38.643149  / # . /lava-657575/environment/lava-657575/=
bin/lava-test-runner /lava-657575/1
    2024-03-03T20:44:38.644475  =

    2024-03-03T20:44:38.649117  / # /lava-657575/bin/lava-test-runner /lava=
-657575/1
    2024-03-03T20:44:39.015631  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65e4ddb48de7a16207637020

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65e4ddb48de7a16207637025
        failing since 0 day (last pass: v4.19.306-cip107-1142-gdcbd51e7744f=
, first fail: v6.1.78-cip15-404-gdddfc5d4f194)

    2024-03-03T20:29:17.787420  <8>[   13.727576] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12928300_1.5.2.3.1>

    2024-03-03T20:29:17.889094  #

    2024-03-03T20:29:17.889344  =


    2024-03-03T20:29:17.989897  / # #export SHELL=3D/bin/sh

    2024-03-03T20:29:17.990071  =


    2024-03-03T20:29:18.090551  / # export SHELL=3D/bin/sh. /lava-12928300/=
environment

    2024-03-03T20:29:18.090734  =


    2024-03-03T20:29:18.191248  / # . /lava-12928300/environment/lava-12928=
300/bin/lava-test-runner /lava-12928300/1

    2024-03-03T20:29:18.191522  =


    2024-03-03T20:29:18.195970  / # /lava-12928300/bin/lava-test-runner /la=
va-12928300/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65e4dd532cd99cfa2a63701e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65e4dd532cd99cfa2a637023
        failing since 0 day (last pass: v4.19.306-cip107-1142-gdcbd51e7744f=
, first fail: v6.1.78-cip15-404-gdddfc5d4f194)

    2024-03-03T20:27:47.260007  <8>[   13.704404] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12928238_1.5.2.3.1>

    2024-03-03T20:27:47.362298  / #

    2024-03-03T20:27:47.465068  # #export SHELL=3D/bin/sh

    2024-03-03T20:27:47.465913  =


    2024-03-03T20:27:47.568082  / # export SHELL=3D/bin/sh. /lava-12928238/=
environment

    2024-03-03T20:27:47.568903  =


    2024-03-03T20:27:47.670218  / # . /lava-12928238/environment/lava-12928=
238/bin/lava-test-runner /lava-12928238/1

    2024-03-03T20:27:47.670518  =


    2024-03-03T20:27:47.675542  / # /lava-12928238/bin/lava-test-runner /la=
va-12928238/1

    2024-03-03T20:27:47.761933  + export TESTRUN_ID=3D1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65e4dd68e21e2c461a637015

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/baseline-nfs-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/baseline-nfs-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65e4dd68e21e2c461a63701a
        failing since 0 day (last pass: v4.19.306-cip107-1142-gdcbd51e7744f=
, first fail: v6.1.78-cip15-404-gdddfc5d4f194)

    2024-03-03T20:28:12.056425  <8>[   17.487595] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12928299_1.5.2.3.1>

    2024-03-03T20:28:12.160947  / # #

    2024-03-03T20:28:12.261655  export SHELL=3D/bin/sh

    2024-03-03T20:28:12.261838  #

    2024-03-03T20:28:12.362342  / # export SHELL=3D/bin/sh. /lava-12928299/=
environment

    2024-03-03T20:28:12.362537  =


    2024-03-03T20:28:12.463113  / # . /lava-12928299/environment/lava-12928=
299/bin/lava-test-runner /lava-12928299/1

    2024-03-03T20:28:12.463366  =


    2024-03-03T20:28:12.467757  / # /lava-12928299/bin/lava-test-runner /la=
va-12928299/1

    2024-03-03T20:28:12.562856  + export TESTRUN_ID=3D1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65e4dd5c725948375a63701e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65e4dd5c725948375a637023
        failing since 0 day (last pass: v4.19.306-cip107-1142-gdcbd51e7744f=
, first fail: v6.1.78-cip15-404-gdddfc5d4f194)

    2024-03-03T20:28:35.222652  <8>[   15.279588] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12928237_1.5.2.3.1>

    2024-03-03T20:28:35.327339  / # #

    2024-03-03T20:28:35.427962  export SHELL=3D/bin/sh

    2024-03-03T20:28:35.428159  #

    2024-03-03T20:28:35.528694  / # export SHELL=3D/bin/sh. /lava-12928237/=
environment

    2024-03-03T20:28:35.528902  =


    2024-03-03T20:28:35.629422  / # . /lava-12928237/environment/lava-12928=
237/bin/lava-test-runner /lava-12928237/1

    2024-03-03T20:28:35.629741  =


    2024-03-03T20:28:35.634501  / # /lava-12928237/bin/lava-test-runner /la=
va-12928237/1

    2024-03-03T20:28:35.681590  + export TESTRUN_ID=3D1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65e4da7f10f34a6c2163702f

  Results:     51 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/arm64/defconfig+arm64-chromebook/gcc-10/la=
b-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/arm64/defconfig+arm64-chromebook/gcc-10/la=
b-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.cpufreq-probed: https://kernelci.org/test/case/id/6=
5e4da7f10f34a6c21637056
        new failure (last pass: v5.10.209-cip44-51-gdb99ac443b0da)

    2024-03-03T20:15:39.157773  /lava-657402/1/../bin/lava-test-case
    2024-03-03T20:15:39.222252  <8>[   37.433047] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpufreq-probed RESULT=3Dfail>
    2024-03-03T20:15:39.222576  /lava-657402/1/../bin/lava-test-case   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
stm32mp157a-dhcor-avenger96  | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65e4dd4a78b20b24ed637029

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/arm/multi_v7_defconfig/gcc-10/lab-broonie/=
baseline-nfs-stm32mp157a-dhcor-avenger96.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/arm/multi_v7_defconfig/gcc-10/lab-broonie/=
baseline-nfs-stm32mp157a-dhcor-avenger96.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65e4dd4a78b20b24e=
d63702a
        new failure (last pass: v6.1.78-cip15-404-gdddfc5d4f194) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65e4dd3b1c8bdc6b0163701c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/arm64/defconfig/gcc-10/lab-broonie/baselin=
e-nfs-sun50i-h5-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/arm64/defconfig/gcc-10/lab-broonie/baselin=
e-nfs-sun50i-h5-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65e4dd3b1c8bdc6b0=
163701d
        new failure (last pass: v6.1.78-cip15-404-gdddfc5d4f194) =

 =20

