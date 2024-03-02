Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D330BC54E55
	for <webhook@archiver.kernel.org>; Sat,  2 Mar 2024 23:06:38 +0000 (UTC)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
 by mx.groups.io with SMTP id smtpd.web11.62883.1709420795962944869
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 02 Mar 2024 15:06:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=Y0MFD/Qo;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.47, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-299d3b09342so2648205a91.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 02 Mar 2024 15:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709420795; x=1710025595; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XshE+R+ck4Qf9mBTMwbzUttauTuNO1dMs+srCZl8HQ0=;
        b=Y0MFD/Qo+8tz+ROG4/TpZLMelDtG+axNK5ZP+rIPUH97AYHqKgODZ8KlHkjJ8/yo8+
         Zwgz+ft5YOH4Hs24Qt0keICYZphcpw1o+KFZVvOfWMtTwAcSC8q0dPfdHkcjkdrcUz0+
         OrWGAtxqwYfB/Qu2rw9+4QB2OPCaAVoH3Skg5VPiuL6HtngbiL2l/8QRAbxWdft4OxIa
         HfajGq9R6WWX3e06RhpjEU/u3p58ZVOaXZdtNMHjZqEh5jptBafiwxH/eeB9ymRgO7JJ
         Kb0lutoFP0PtWjcSxbOXOPqWTVOomLRwAT3e6rA0lTLwHzvswU1t63jZZdCPItEhpEEq
         jMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709420795; x=1710025595;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XshE+R+ck4Qf9mBTMwbzUttauTuNO1dMs+srCZl8HQ0=;
        b=ohoc60ovxSm+NTrRiETWUhOXhvwnJwFxvAp4CElyvEJB8ljoCvXpOzcUvUr++aIVwY
         g2FbFWcW4E8mjWT1J9mM8nlsc3volY/EJjUnt2wWJw4UOGrVfvpp0002DuY5vWE16Po3
         wj3SvRRtOI8gMW8Q7lNU7yrxo/7yMT5MCxfq4xC4dRjfrAkNHAaKOdyujuGIZjPsHvSI
         7SjKMEKaLpfM6tFkvQHHu6AnuoqDdK2+1lMQ/ThzH9KeBLGuDwuIBVIfflcO4Y/MFWii
         A87eHUQPRaNhbvA69j18Z+EFKbnaWO6yv4f9j/nJAs8qQRLiHVfHcnHGrXzkSTyaZvfE
         dd6A==
X-Gm-Message-State: AOJu0YxidOi/sYrmpT6I+RvCgDNDIjEcRSWzJo533mYZpudoVNPXm9d9
	dB8Y/s8ZErnJGkWJdYnWa01w1DboU4tO2ztz/SaIqhh5IQwSXWeWdX3ErltsOHXwmwKNu7nrFpU
	Ci3E=
X-Google-Smtp-Source: AGHT+IEX10jiJr8ur6H6NH896ktm7RfEHyEesyVkN1soEnoTroRvMNMYumhUjUgB6tFYaBsqNCgAsg==
X-Received: by 2002:a17:903:22c2:b0:1dc:7bc:d025 with SMTP id y2-20020a17090322c200b001dc07bcd025mr6974821plg.4.1709420794288;
        Sat, 02 Mar 2024 15:06:34 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l4-20020a170903244400b001db6de983d3sm5718324pls.85.2024.03.02.15.06.33
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 15:06:33 -0800 (PST)
Message-ID: <65e3b0f9.170a0220.afa34.848c@mx.google.com>
Date: Sat, 02 Mar 2024 15:06:33 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v6.1.78-cip15-404-gdddfc5d4f194
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline: 107 runs,
 14 regressions (v6.1.78-cip15-404-gdddfc5d4f194)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 02 Mar 2024 23:06:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15167

cip-gitlab/ci/pavel/linux-test baseline: 107 runs, 14 regressions (v6.1.78-=
cip15-404-gdddfc5d4f194)

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

bcm2836-rpi-2-b              | arm    | lab-collabora | gcc-10   | bcm2835_=
defconfig          | 1          =

bcm2836-rpi-2-b              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig         | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig        | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

imx6dl-udoo                  | arm    | lab-broonie   | gcc-10   | imx_v6_v=
7_defconfig        | 1          =

imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | imx_v6_v=
7_defconfig        | 1          =

imx8mp-evk                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig         | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                  | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.78-cip15-404-gdddfc5d4f194/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.78-cip15-404-gdddfc5d4f194
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      dddfc5d4f194925df6ee3d06e86b1d1e12412f06 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65e3a1ec06f98b3ad2637016

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e3a1ec06f98b3ad263701b
        new failure (last pass: v4.19.306-cip107-1142-gdcbd51e7744f)

    2024-03-02T22:02:41.275254  + set<8>[   11.464500] <LAVA_SIGNAL_ENDRUN =
0_dmesg 12919782_1.4.2.3.1>

    2024-03-02T22:02:41.275759   +x

    2024-03-02T22:02:41.383985  / # #

    2024-03-02T22:02:41.486393  export SHELL=3D/bin/sh

    2024-03-02T22:02:41.487177  #

    2024-03-02T22:02:41.588615  / # export SHELL=3D/bin/sh. /lava-12919782/=
environment

    2024-03-02T22:02:41.588806  =


    2024-03-02T22:02:41.689421  / # . /lava-12919782/environment/lava-12919=
782/bin/lava-test-runner /lava-12919782/1

    2024-03-02T22:02:41.689693  =


    2024-03-02T22:02:41.694433  / # /lava-12919782/bin/lava-test-runner /la=
va-12919782/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65e3a51a26369ec56863702e

  Results:     48 PASS, 6 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/arm/multi_v5_defconfig/gcc-10/lab-broonie/=
baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/arm/multi_v5_defconfig/gcc-10/lab-broonie/=
baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e3a51a26369ec568637062
        new failure (last pass: v4.19.306-cip107-1142-gdcbd51e7744f)

    2024-03-02T22:15:27.000487  + set +x
    2024-03-02T22:15:27.000960  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 654613_1.5.2=
.4.1>
    2024-03-02T22:15:27.115615  / # #
    2024-03-02T22:15:27.218686  export SHELL=3D/bin/sh
    2024-03-02T22:15:27.219480  #
    2024-03-02T22:15:27.321517  / # export SHELL=3D/bin/sh. /lava-654613/en=
vironment
    2024-03-02T22:15:27.322352  =

    2024-03-02T22:15:27.424354  / # . /lava-654613/environment/lava-654613/=
bin/lava-test-runner /lava-654613/1
    2024-03-02T22:15:27.425757  =

    2024-03-02T22:15:27.429341  / # /lava-654613/bin/lava-test-runner /lava=
-654613/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora | gcc-10   | bcm2835_=
defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/65e3a83cd717fa9462637012

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/arm/bcm2835_defconfig/gcc-10/lab-collabora=
/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/arm/bcm2835_defconfig/gcc-10/lab-collabora=
/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e3a83cd717fa9462637017
        new failure (last pass: v4.19.306-cip107-1142-gdcbd51e7744f)

    2024-03-02T22:39:54.911271  / # #

    2024-03-02T22:39:55.013378  export SHELL=3D/bin/sh

    2024-03-02T22:39:55.014148  #

    2024-03-02T22:39:55.115615  / # export SHELL=3D/bin/sh. /lava-12919897/=
environment

    2024-03-02T22:39:55.116352  =


    2024-03-02T22:39:55.217842  / # . /lava-12919897/environment/lava-12919=
897/bin/lava-test-runner /lava-12919897/1

    2024-03-02T22:39:55.219047  =


    2024-03-02T22:39:55.235705  / # /lava-12919897/bin/lava-test-runner /la=
va-12919897/1

    2024-03-02T22:39:55.344735  + export 'TESTRUN_ID=3D1_bootrr'

    2024-03-02T22:39:55.345254  + cd /lava-12919897/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65e3a6aceed4b93016637094

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/arm/multi_v7_defconfig/gcc-10/lab-collabor=
a/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/arm/multi_v7_defconfig/gcc-10/lab-collabor=
a/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65e3a6aceed4b93016637=
095
        new failure (last pass: v4.19.306-cip107-1142-gdcbd51e7744f) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/65e3a72438914686f4637018

  Results:     52 PASS, 3 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/arm/omap2plus_defconfig/gcc-10/lab-broonie=
/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/arm/omap2plus_defconfig/gcc-10/lab-broonie=
/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e3a72438914686f463704b
        new failure (last pass: v4.19.306-cip107-1142-gdcbd51e7744f)

    2024-03-02T22:24:23.748330  <8>[   22.245980] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 654646_1.5.2.4.1>
    2024-03-02T22:24:23.856998  / # #
    2024-03-02T22:24:23.958477  export SHELL=3D/bin/sh
    2024-03-02T22:24:23.958815  #
    2024-03-02T22:24:24.059756  / # export SHELL=3D/bin/sh. /lava-654646/en=
vironment
    2024-03-02T22:24:24.060087  =

    2024-03-02T22:24:24.161254  / # . /lava-654646/environment/lava-654646/=
bin/lava-test-runner /lava-654646/1
    2024-03-02T22:24:24.161810  =

    2024-03-02T22:24:24.166437  / # /lava-654646/bin/lava-test-runner /lava=
-654646/1
    2024-03-02T22:24:24.276706  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65e3a24c67bad9d347637051

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e3a24c67bad9d347637056
        new failure (last pass: v4.19.306-cip107-1142-gdcbd51e7744f)

    2024-03-02T22:06:30.991925  + set +x

    2024-03-02T22:06:30.998912  <8>[    9.954564] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12919858_1.4.2.3.1>

    2024-03-02T22:06:31.103100  / # #

    2024-03-02T22:06:31.203795  export SHELL=3D/bin/sh

    2024-03-02T22:06:31.204003  #

    2024-03-02T22:06:31.304603  / # export SHELL=3D/bin/sh. /lava-12919858/=
environment

    2024-03-02T22:06:31.304820  =


    2024-03-02T22:06:31.405318  / # . /lava-12919858/environment/lava-12919=
858/bin/lava-test-runner /lava-12919858/1

    2024-03-02T22:06:31.405616  =


    2024-03-02T22:06:31.410356  / # /lava-12919858/bin/lava-test-runner /la=
va-12919858/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65e3a1d9a2b214b0ca637022

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e3a1d9a2b214b0ca637027
        new failure (last pass: v4.19.306-cip107-1142-gdcbd51e7744f)

    2024-03-02T22:02:24.142547  + set +x<8>[   10.122181] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 12919815_1.4.2.3.1>

    2024-03-02T22:02:24.142686  =


    2024-03-02T22:02:24.244316  /#

    2024-03-02T22:02:24.345136   # #export SHELL=3D/bin/sh

    2024-03-02T22:02:24.345326  =


    2024-03-02T22:02:24.445823  / # export SHELL=3D/bin/sh. /lava-12919815/=
environment

    2024-03-02T22:02:24.446131  =


    2024-03-02T22:02:24.546631  / # . /lava-12919815/environment/lava-12919=
815/bin/lava-test-runner /lava-12919815/1

    2024-03-02T22:02:24.546901  =


    2024-03-02T22:02:24.552053  / # /lava-12919815/bin/lava-test-runner /la=
va-12919815/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65e3a1f14bbd763ff063703f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e3a1f14bbd763ff0637044
        new failure (last pass: v4.19.306-cip107-1142-gdcbd51e7744f)

    2024-03-02T22:02:03.818904  + set<8>[   11.218496] <LAVA_SIGNAL_ENDRUN =
0_dmesg 12919825_1.4.2.3.1>

    2024-03-02T22:02:03.818991   +x

    2024-03-02T22:02:03.923284  / # #

    2024-03-02T22:02:04.023854  export SHELL=3D/bin/sh

    2024-03-02T22:02:04.024001  #

    2024-03-02T22:02:04.124548  / # export SHELL=3D/bin/sh. /lava-12919825/=
environment

    2024-03-02T22:02:04.124688  =


    2024-03-02T22:02:04.225215  / # . /lava-12919825/environment/lava-12919=
825/bin/lava-test-runner /lava-12919825/1

    2024-03-02T22:02:04.225449  =


    2024-03-02T22:02:04.230153  / # /lava-12919825/bin/lava-test-runner /la=
va-12919825/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
imx6dl-udoo                  | arm    | lab-broonie   | gcc-10   | imx_v6_v=
7_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/65e3a40b5b29a15aa0637045

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie=
/baseline-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie=
/baseline-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65e3a40b5b29a15aa0637=
046
        new failure (last pass: v4.19.306-cip107-1142-gdcbd51e7744f) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | imx_v6_v=
7_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/65e3a4095b29a15aa0637042

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie=
/baseline-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie=
/baseline-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65e3a4095b29a15aa0637=
043
        new failure (last pass: v4.19.306-cip107-1142-gdcbd51e7744f) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
imx8mp-evk                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65e3aa71691e776e2d637041

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/arm64/defconfig/gcc-10/lab-broonie/baselin=
e-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/arm64/defconfig/gcc-10/lab-broonie/baselin=
e-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e3aa71691e776e2d637046
        new failure (last pass: v5.10.209-cip44-51-gdb99ac443b0da)

    2024-03-02T22:38:14.040001  + set<8>[   24.482367] <LAVA_SIGNAL_ENDRUN =
0_dmesg 654735_1.5.2.4.1>
    2024-03-02T22:38:14.040553   +x
    2024-03-02T22:38:14.149429  / # #
    2024-03-02T22:38:15.311813  export SHELL=3D/bin/sh
    2024-03-02T22:38:15.317506  #
    2024-03-02T22:38:16.810533  / # export SHELL=3D/bin/sh. /lava-654735/en=
vironment
    2024-03-02T22:38:16.816002  =

    2024-03-02T22:38:19.525921  / # . /lava-654735/environment/lava-654735/=
bin/lava-test-runner /lava-654735/1
    2024-03-02T22:38:19.531766  =

    2024-03-02T22:38:19.546259  / # /lava-654735/bin/lava-test-runner /lava=
-654735/1 =

    ... (17 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65e3a1ee258010e94d637021

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e3a1ee258010e94d637026
        new failure (last pass: v4.19.306-cip107-1142-gdcbd51e7744f)

    2024-03-02T22:02:11.222221  + <8>[   11.806623] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 12919793_1.4.2.3.1>

    2024-03-02T22:02:11.222688  set +x

    2024-03-02T22:02:11.330336  / # #

    2024-03-02T22:02:11.433309  export SHELL=3D/bin/sh

    2024-03-02T22:02:11.434091  #

    2024-03-02T22:02:11.535666  / # export SHELL=3D/bin/sh. /lava-12919793/=
environment

    2024-03-02T22:02:11.536464  =


    2024-03-02T22:02:11.638156  / # . /lava-12919793/environment/lava-12919=
793/bin/lava-test-runner /lava-12919793/1

    2024-03-02T22:02:11.639439  =


    2024-03-02T22:02:11.644205  / # /lava-12919793/bin/lava-test-runner /la=
va-12919793/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65e3a13200583b1d3763702b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/arm/shmobile_defconfig/gcc-10/lab-cip/base=
line-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/arm/shmobile_defconfig/gcc-10/lab-cip/base=
line-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65e3a13200583b1d37637=
02c
        failing since 25 days (last pass: v5.10.209-cip44-rebase, first fai=
l: v5.10.209-cip44-526-gbbb905888ca85) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65e3abfb94be8a400a637035

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/arm64/defconfig/gcc-10/lab-cip/baseline-r8=
a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/arm64/defconfig/gcc-10/lab-cip/baseline-r8=
a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e3abfb94be8a400a63703a
        new failure (last pass: v4.19.306-cip107-1142-gdcbd51e7744f)

    2024-03-02T22:44:49.744676  / # #
    2024-03-02T22:44:51.205068  export SHELL=3D/bin/sh
    2024-03-02T22:44:51.226012  #
    2024-03-02T22:44:51.226588  / # export SHELL=3D/bin/sh
    2024-03-02T22:44:53.177935  / # . /lava-1102017/environment
    2024-03-02T22:44:56.769522  /lava-1102017/bin/lava-test-runner /lava-11=
02017/1
    2024-03-02T22:44:56.791126  . /lava-1102017/environment
    2024-03-02T22:44:56.791511  / # /lava-1102017/bin/lava-test-runner /lav=
a-1102017/1
    2024-03-02T22:44:56.881949  + export 'TESTRUN_ID=3D1_bootrr'
    2024-03-02T22:44:56.882494  + cd /lava-1102017/1/tests/1_bootrr =

    ... (26 line(s) more)  =

 =20

