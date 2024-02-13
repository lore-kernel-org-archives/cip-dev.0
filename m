Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586B2C48260
	for <webhook@archiver.kernel.org>; Tue, 13 Feb 2024 18:36:26 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web10.21051.1707849377242595306
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 13 Feb 2024 10:36:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=T+oy6y8H;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.171, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d7393de183so8580165ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 13 Feb 2024 10:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707849376; x=1708454176; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5dOGk1Lj2TMpPe2vGyU8ikkOrCRxNAknqx88jsfZjQc=;
        b=T+oy6y8H9RH3gdCp6E7FHNf6bZpovnMRF+2W+ELoLxqMQkm/V3xNcKzopkFGfrF9Qe
         Ssq9Ll/KOPDQljT/ucVph4OWeQmnyIWc1qtBENhdgjHhLl4x1SBkZKl4U2gSXFTACcKP
         5RcErTdMD9KlvsKmIqSu6so9fxS+DrtquPgyKNbfAY7UMhGkdmoD7JfBUmQUnOBvHPfe
         rIIzySUiSxN3Yqw1PAt5xq3DyTeHhCWxWMxS5lWU8pYQRonXzNvw1jHqVYLwi6vyBp6y
         HuP1pqyVQvwASIc1laAoEHJ6mzqvSmcXIsbJ9RAQfuacQK2+GOlOAdduysbLzXPGxcZj
         VRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707849376; x=1708454176;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5dOGk1Lj2TMpPe2vGyU8ikkOrCRxNAknqx88jsfZjQc=;
        b=GZl35xjy9/Uu3lVKfb84Kc8Cois5X686+y6YnXWbbrZtr/yZKELTSwDjRkf7S7ZoKB
         ULz3LSOjC/Dv4m1mS/GB9RIwLaCHoXUanh2C3SAO0yXE2DMx6PHVV4ICgpPFEpFbsaCC
         lsnE5e/yFFPtjf/DBVG8LOhAywrenIArVUSVKqwrVfaKQdPI9+OX/dtivvJiW2HQHLxu
         TECFdusuVyOMIp9qN1TNrvdsuTm6DUje71FR00ojaoo8YIvC9oOcsa+aha7B48VS0BfW
         uLc9yzB8Q0/HiCN1ydWE/OxT1PhoGtqsxSyedfCYqosSdExfKnifpOFtNHNeybJXM+mS
         orag==
X-Gm-Message-State: AOJu0YypquQF02O8GjtsIwyWLZivYK5aQEY4tQ2ztLHRmo6nF+dI8bMA
	CsNttzJopo+YMXJF2X1d1uR+xHZ4Y58wmvZNaNFxNKj8723yITQuXTo1gMZdVUyb3WCMpiceyYO
	zQ54=
X-Google-Smtp-Source: AGHT+IEUTa5qjWW4f/vi2YO8Zz5jcCyYgiZrke2NC+CfFDH2AYBuo+COFbs6kSimDNgRoOur4V0o8A==
X-Received: by 2002:a17:902:d315:b0:1db:3592:a6a2 with SMTP id b21-20020a170902d31500b001db3592a6a2mr382363plc.12.1707849376065;
        Tue, 13 Feb 2024 10:36:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUEBg1HaNddZzDjk+fD8pIhXjHnnqUoycSDz6nNg4Tz9cSI5k9WTNh+d6PZPveB8zVXtXWwiw4QQA8YoFeuH2C1lARO57FtNGHnGFg5JotNwkQw3PdF1Oc1diwGb/JO7nxaEKfjKZnOAQuJVShJbTTR+w==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t11-20020a170902dccb00b001d7164acf5csm2377998pll.120.2024.02.13.10.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 10:36:14 -0800 (PST)
Message-ID: <65cbb69e.170a0220.36eea.826d@mx.google.com>
Date: Tue, 13 Feb 2024 10:36:14 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.209-cip44-51-gdb99ac443b0da
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip baseline-nfs: 40 runs,
 11 regressions (v5.10.209-cip44-51-gdb99ac443b0da)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Feb 2024 18:36:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14944

cip/linux-5.10.y-cip baseline-nfs: 40 runs, 11 regressions (v5.10.209-cip44=
-51-gdb99ac443b0da)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
beaglebone-black         | arm   | lab-broonie   | gcc-10   | multi_v7_defc=
onfig         | 1          =

beaglebone-black         | arm   | lab-cip       | gcc-10   | multi_v7_defc=
onfig         | 1          =

beaglebone-black         | arm   | lab-broonie   | gcc-10   | omap2plus_def=
config        | 1          =

beaglebone-black         | arm   | lab-cip       | gcc-10   | omap2plus_def=
config        | 1          =

imx6q-sabrelite          | arm   | lab-collabora | gcc-10   | multi_v7_defc=
onfig         | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =

rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 2          =

rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig    =
              | 1          =

rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig+kse=
lftest        | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.209-cip44-51-gdb99ac443b0da/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.209-cip44-51-gdb99ac443b0da
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      db99ac443b0da75f00a4fc49e0040ac5dfa47e72 =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
beaglebone-black         | arm   | lab-broonie   | gcc-10   | multi_v7_defc=
onfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65cbacc2fe6428b94063701a

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline=
-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline=
-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65cbacc2fe6428b94063704b
        failing since 395 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-13T17:53:33.451031  <8>[   49.574175] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 579676_1.6.2.4.1>
    2024-02-13T17:53:33.566941  / # #
    2024-02-13T17:53:33.668558  export SHELL=3D/bin/sh
    2024-02-13T17:53:33.668946  #
    2024-02-13T17:53:33.769932  / # export SHELL=3D/bin/sh. /lava-579676/en=
vironment
    2024-02-13T17:53:33.770358  =

    2024-02-13T17:53:33.871830  / # . /lava-579676/environment/lava-579676/=
bin/lava-test-runner /lava-579676/1
    2024-02-13T17:53:33.872506  =

    2024-02-13T17:53:33.875563  / # /lava-579676/bin/lava-test-runner /lava=
-579676/1
    2024-02-13T17:53:34.072563  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
beaglebone-black         | arm   | lab-cip       | gcc-10   | multi_v7_defc=
onfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65cbaef9e14a11d84c63701a

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs=
-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs=
-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65cbaef9e14a11d84c63704b
        failing since 395 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-13T18:02:46.340035  <8>[   49.032480] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1092638_1.6.2.4.1>
    2024-02-13T18:02:46.525354  #
    2024-02-13T18:02:46.627117  / # #export SHELL=3D/bin/sh
    2024-02-13T18:02:46.627707  =

    2024-02-13T18:02:46.728910  / # export SHELL=3D/bin/sh. /lava-1092638/e=
nvironment
    2024-02-13T18:02:46.729519  =

    2024-02-13T18:02:46.830680  / # . /lava-1092638/environment/lava-109263=
8/bin/lava-test-runner /lava-1092638/1
    2024-02-13T18:02:46.831771  =

    2024-02-13T18:02:46.837782  / # /lava-1092638/bin/lava-test-runner /lav=
a-1092638/1
    2024-02-13T18:02:47.177620  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
beaglebone-black         | arm   | lab-broonie   | gcc-10   | omap2plus_def=
config        | 1          =


  Details:     https://kernelci.org/test/plan/id/65cbb0fae16c6209a3637090

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm/omap2plus_defconfig/gcc-10/lab-broonie/baselin=
e-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm/omap2plus_defconfig/gcc-10/lab-broonie/baselin=
e-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65cbb0fae16c6209a36370c8
        failing since 395 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-13T18:11:39.284693  + set +x
    2024-02-13T18:11:39.287850  <8>[  128.069658] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 579855_1.6.2.4.1>
    2024-02-13T18:11:39.419406  / # #
    2024-02-13T18:11:39.521167  export SHELL=3D/bin/sh
    2024-02-13T18:11:39.521661  #
    2024-02-13T18:11:39.622931  / # export SHELL=3D/bin/sh. /lava-579855/en=
vironment
    2024-02-13T18:11:39.623372  =

    2024-02-13T18:11:39.724752  / # . /lava-579855/environment/lava-579855/=
bin/lava-test-runner /lava-579855/1
    2024-02-13T18:11:39.725447  =

    2024-02-13T18:11:39.728773  / # /lava-579855/bin/lava-test-runner /lava=
-579855/1 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
beaglebone-black         | arm   | lab-cip       | gcc-10   | omap2plus_def=
config        | 1          =


  Details:     https://kernelci.org/test/plan/id/65cbb102e2fea7ebd6637055

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nf=
s-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nf=
s-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65cbb102e2fea7ebd663708d
        failing since 395 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-13T18:11:51.942474  + set +x
    2024-02-13T18:11:51.945775  <8>[   41.936290] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1092661_1.6.2.4.1>
    2024-02-13T18:11:52.201697  #
    2024-02-13T18:11:52.304095  / # #export SHELL=3D/bin/sh
    2024-02-13T18:11:52.304746  =

    2024-02-13T18:11:52.406075  / # export SHELL=3D/bin/sh. /lava-1092661/e=
nvironment
    2024-02-13T18:11:52.406728  =

    2024-02-13T18:11:52.508092  / # . /lava-1092661/environment/lava-109266=
1/bin/lava-test-runner /lava-1092661/1
    2024-02-13T18:11:52.509160  =

    2024-02-13T18:11:52.514731  / # /lava-1092661/bin/lava-test-runner /lav=
a-1092661/1 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
imx6q-sabrelite          | arm   | lab-collabora | gcc-10   | multi_v7_defc=
onfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65cbaa16e54700efef63706d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-nfs-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-nfs-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65cbaa16e54700efef637076
        failing since 395 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-13T17:43:32.927754  / # #

    2024-02-13T17:43:33.029758  export SHELL=3D/bin/sh

    2024-02-13T17:43:33.030389  #

    2024-02-13T17:43:33.131736  / # export SHELL=3D/bin/sh. /lava-12757632/=
environment

    2024-02-13T17:43:33.132365  =


    2024-02-13T17:43:33.233804  / # . /lava-12757632/environment/lava-12757=
632/bin/lava-test-runner /lava-12757632/1

    2024-02-13T17:43:33.234761  =


    2024-02-13T17:43:33.236630  / # /lava-12757632/bin/lava-test-runner /la=
va-12757632/1

    2024-02-13T17:43:33.393531  + export TESTRUN_ID=3D1_bootrr

    2024-02-13T17:43:33.393936  + cd /lava-12757632/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65cbae955eb9f1a793637026

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ba=
seline-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ba=
seline-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65cbae955eb9f1a79=
3637027
        failing since 175 days (last pass: v5.10.186-cip37-14-gc9b5a049d8ea=
, first fail: v5.10.186-cip37-27-gd6d928db0a620) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/65cbb02077f0ff80dc637012

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm64/defconfig/gcc-10/lab-cip/baseline-nfs-r8a774=
a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm64/defconfig/gcc-10/lab-cip/baseline-nfs-r8a774=
a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65cbb02077f0ff80d=
c637013
        failing since 132 days (last pass: v5.10.194-cip39, first fail: v5.=
10.194-cip39-1-g53e59f50ca3ff) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/65cbaded072579135e63701e

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm64/defconfig+arm64-chromebook/gcc-10/lab-collab=
ora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm64/defconfig+arm64-chromebook/gcc-10/lab-collab=
ora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/65cbaded072579135e637028
        failing since 328 days (last pass: v5.10.173-cip28, first fail: v5.=
10.175-cip29)

    2024-02-13T18:01:39.151096  <8>[   36.034900] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2024-02-13T18:01:40.203606  /lava-12757721/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/65cbaded072579135e637029
        failing since 328 days (last pass: v5.10.173-cip28, first fail: v5.=
10.175-cip29)

    2024-02-13T18:01:39.116647  /lava-12757721/1/../bin/lava-test-case
   =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/65cbaf00e8734c2b08637012

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm64/defconfig/gcc-10/lab-collabora/baseline-nfs-=
rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm64/defconfig/gcc-10/lab-collabora/baseline-nfs-=
rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65cbaf00e8734c2b0863701b
        failing since 132 days (last pass: v5.10.184-cip36, first fail: v5.=
10.194-cip39-1-g53e59f50ca3ff)

    2024-02-13T18:03:16.639134  / # #

    2024-02-13T18:03:17.893675  export SHELL=3D/bin/sh

    2024-02-13T18:03:17.903931  #

    2024-02-13T18:03:17.904008  / # export SHELL=3D/bin/sh

    2024-02-13T18:03:19.641099  . /lava-12757828/environment

    2024-02-13T18:03:22.839002  / # . /lava-12757828/environment/lava-12757=
828/bin/lava-test-runner /lava-12757828/1

    2024-02-13T18:03:22.850236  =


    2024-02-13T18:03:22.850511  / # /lava-12757828/bin/lava-test-runner /la=
va-12757828/1

    2024-02-13T18:03:23.024221  + export TESTRUN_ID=3D1_bootrr

    2024-02-13T18:03:23.024304  + cd /lava-12757828/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig+kse=
lftest        | 1          =


  Details:     https://kernelci.org/test/plan/id/65cbb055c3229a91a763707c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm64/defconfig+kselftest/gcc-10/lab-collabora/bas=
eline-nfs-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm64/defconfig+kselftest/gcc-10/lab-collabora/bas=
eline-nfs-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65cbb055c3229a91a7637085
        failing since 132 days (last pass: v5.10.184-cip36, first fail: v5.=
10.194-cip39-1-g53e59f50ca3ff)

    2024-02-13T18:08:55.935719  + set +x

    2024-02-13T18:08:55.936209  <8>[   51.362877] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12757859_1.6.2.4.1>

    2024-02-13T18:08:56.041382  #

    2024-02-13T18:08:57.301533  / # #export SHELL=3D/bin/sh

    2024-02-13T18:08:57.312409  =


    2024-02-13T18:08:57.312858  / # export SHELL=3D/bin/sh

    2024-02-13T18:08:59.054436  . /lava-12757859/environment

    2024-02-13T18:09:02.255768  / # . /lava-12757859/environment/lava-12757=
859/bin/lava-test-runner /lava-12757859/1

    2024-02-13T18:09:02.267111  =


    2024-02-13T18:09:02.267417  / # /lava-12757859/bin/lava-test-runner /la=
va-12757859/1
 =

    ... (13 line(s) more)  =

 =20

