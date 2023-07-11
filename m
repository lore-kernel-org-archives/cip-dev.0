Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C497EB64DD
	for <webhook@archiver.kernel.org>; Tue, 11 Jul 2023 15:37:29 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web10.2799.1689089840921724743
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 11 Jul 2023 08:37:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=uPlIz9fy;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.170, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1b8ad907ba4so29604795ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 11 Jul 2023 08:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689089840; x=1691681840;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lMdYHw+m+FHjgxC7Cqqxoddehs6+HfSzsUWIDUCiIOI=;
        b=uPlIz9fyStjzwiXFC0kbOig5UeOGtFGKyR3G54aC/Ak6j3RceqCxFBv38OPSBmIeSH
         LkQsSRXek+xPIiwAxFy8smLHwVJpwGFt2IotolNZxky1s7KbvybiW9xbEql5x/amZyi/
         hyYG99Md53ioZ3NuEj86jSqbE6g/QJWfzkiphXlRvQPF9rpF+9vV46Y8FNn2QqXOLLCh
         MXWMB4HkkvOJw6Vmp1PGspCR5QdS6tAPOTyVy4c1RRP6O1yHDZN3Fk8F+aXiguap7V8W
         3pqRQdyYAQtuszhZnJcShn6cWDbGEJkNnzM5dWIF3vWeZpsm687V/lR5kQaav8Lzx4Vl
         rAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689089840; x=1691681840;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lMdYHw+m+FHjgxC7Cqqxoddehs6+HfSzsUWIDUCiIOI=;
        b=T7owTXhIoNY/2vIH9BlQMN3f1uBOaO0L/iye80s/M9ix25g/93fApE1SLWVBdNVTUT
         4ELKl9++RLOr4WAA1FlAnN6ZB0fXo1oPuVjfgvvVwgmcfXz2UJHs8tkKOEKsXfxlwjlC
         sXmyENPGM0EI2dreF2m7xs9g+Xq1acL8ukPfDwoKRcfeajrwPI5ZWCCHyU5b08P3LpbP
         9DRc44fpJ0e0pWRbIeNIzpKYTqYMpquecn6LkEgTgd6N+wb/xTvI5V6lPdfWG8gkkM3G
         3vORmshiE7ZJu/0J1N0I0/igXuiKEUmHcmoOK/rEX+KaM7gpfaRSYdmQvm8SxVVN/3KI
         MY4Q==
X-Gm-Message-State: ABy/qLZLXjvp/QPkP5T48ydymVYM0d2WVD5T66R6BDmYn/ngTqS55OAf
	cfM6b1DP4WDYUcxL5RhA0sH5q35Sul58dHUUOuhGbw==
X-Google-Smtp-Source: APBJJlHCPiMyFJbZR18coJfJwf8/F/+S5wmwzO0Dd3gc+yVY9l2C4jqv+QbW4vU8cPzoZ60LdSR+1w==
X-Received: by 2002:a17:902:cec3:b0:1b7:e49f:1d with SMTP id d3-20020a170902cec300b001b7e49f001dmr15500326plg.62.1689089839940;
        Tue, 11 Jul 2023 08:37:19 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jh2-20020a170903328200b001b7feed285csm2074035plb.36.2023.07.11.08.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 08:37:19 -0700 (PDT)
Message-ID: <64ad772f.170a0220.5865c.4516@mx.google.com>
Date: Tue, 11 Jul 2023 08:37:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.184-cip36-13-g8fae18103387
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y-cip
Subject: cip/linux-5.10.y-cip baseline-nfs: 27 runs,
 9 regressions (v5.10.184-cip36-13-g8fae18103387)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Jul 2023 15:37:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12319

cip/linux-5.10.y-cip baseline-nfs: 27 runs, 9 regressions (v5.10.184-cip36-=
13-g8fae18103387)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.184-cip36-13-g8fae18103387/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.184-cip36-13-g8fae18103387
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      8fae18103387e09e360941d7df884a2fc6010f66 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ad6f2b62b4d48284bb2a96

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-13-g8fae18103387/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-=
nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-13-g8fae18103387/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-=
nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64ad6f2b62b4d48284bb2ac3
        failing since 178 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-07-11T15:02:19.362141  <8>[   50.376997] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 714292_1.6.2.4.1>
    2023-07-11T15:02:19.479597  / # #
    2023-07-11T15:02:19.582055  export SHELL=3D/bin/sh
    2023-07-11T15:02:19.582599  #
    2023-07-11T15:02:19.684174  / # export SHELL=3D/bin/sh. /lava-714292/en=
vironment
    2023-07-11T15:02:19.684659  =

    2023-07-11T15:02:19.786382  / # . /lava-714292/environment/lava-714292/=
bin/lava-test-runner /lava-714292/1
    2023-07-11T15:02:19.787513  =

    2023-07-11T15:02:19.791778  / # /lava-714292/bin/lava-test-runner /lava=
-714292/1
    2023-07-11T15:02:19.993054  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ad7028c43f5f8b1dbb2a82

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-13-g8fae18103387/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-=
beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-13-g8fae18103387/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-=
beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64ad7028c43f5f8b1dbb2a85
        failing since 178 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-07-11T15:06:46.804959  + set +x
    2023-07-11T15:06:46.806814  [   46.592483] <LAVA_SIGNAL_ENDRUN 0_dmesg =
985115_1.6.2.4.1>
    2023-07-11T15:06:46.924105  / # #
    2023-07-11T15:06:47.026107  export SHELL=3D/bin/sh
    2023-07-11T15:06:47.026626  #
    2023-07-11T15:06:47.128021  / # export SHELL=3D/bin/sh. /lava-985115/en=
vironment
    2023-07-11T15:06:47.128518  =

    2023-07-11T15:06:47.229938  / # . /lava-985115/environment/lava-985115/=
bin/lava-test-runner /lava-985115/1
    2023-07-11T15:06:47.230769  =

    2023-07-11T15:06:47.233568  / # /lava-985115/bin/lava-test-runner /lava=
-985115/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64ad6f1b3cdc35a387bb2ab5

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-13-g8fae18103387/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline=
-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-13-g8fae18103387/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline=
-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64ad6f1b3cdc35a387bb2aeb
        failing since 178 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-07-11T15:02:20.513509  [   49.109326] <LAVA_SIGNAL_ENDRUN 0_dmesg =
714277_1.6.2.4.1>
    2023-07-11T15:02:20.644373  #
    2023-07-11T15:02:20.747038  / # #export SHELL=3D/bin/sh
    2023-07-11T15:02:20.747562  =

    2023-07-11T15:02:20.849038  / # export SHELL=3D/bin/sh. /lava-714277/en=
vironment
    2023-07-11T15:02:20.849565  =

    2023-07-11T15:02:20.951050  / # . /lava-714277/environment/lava-714277/=
bin/lava-test-runner /lava-714277/1
    2023-07-11T15:02:20.952162  =

    2023-07-11T15:02:20.956446  / # /lava-714277/bin/lava-test-runner /lava=
-714277/1
    2023-07-11T15:02:21.200514  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64ad6f74c44b551ceebb2ab6

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-13-g8fae18103387/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs=
-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-13-g8fae18103387/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs=
-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64ad6f74c44b551ceebb2ab9
        failing since 178 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-07-11T15:03:54.632400  + set +x
    2023-07-11T15:03:54.634168  [   41.201417] <LAVA_SIGNAL_ENDRUN 0_dmesg =
985113_1.6.2.4.1>
    2023-07-11T15:03:54.757543  #
    2023-07-11T15:03:54.859737  / # #export SHELL=3D/bin/sh
    2023-07-11T15:03:54.860189  =

    2023-07-11T15:03:54.961611  / # export SHELL=3D/bin/sh. /lava-985113/en=
vironment
    2023-07-11T15:03:54.962064  =

    2023-07-11T15:03:55.063504  / # . /lava-985113/environment/lava-985113/=
bin/lava-test-runner /lava-985113/1
    2023-07-11T15:03:55.064256  =

    2023-07-11T15:03:55.066401  / # /lava-985113/bin/lava-test-runner /lava=
-985113/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ad6fa39ef34b35fbbb2a89

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-13-g8fae18103387/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-13-g8fae18103387/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64ad6fa39ef34b35fbbb2a8e
        failing since 88 days (last pass: v5.10.176-cip30, first fail: v5.1=
0.177-cip31)

    2023-07-11T15:04:46.684593  + <8>[   18.545630] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11062032_1.5.2.3.1>

    2023-07-11T15:04:46.685007  set +x

    2023-07-11T15:04:46.792736  / # #

    2023-07-11T15:04:46.895068  export SHELL=3D/bin/sh

    2023-07-11T15:04:46.895797  #

    2023-07-11T15:04:46.997236  / # export SHELL=3D/bin/sh. /lava-11062032/=
environment

    2023-07-11T15:04:46.998006  =


    2023-07-11T15:04:47.099471  / # . /lava-11062032/environment/lava-11062=
032/bin/lava-test-runner /lava-11062032/1

    2023-07-11T15:04:47.100825  =


    2023-07-11T15:04:47.105800  / # /lava-11062032/bin/lava-test-runner /la=
va-11062032/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ad6eb2818ec70e70bb2b1c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-13-g8fae18103387/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-13-g8fae18103387/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64ad6eb2818ec70e70bb2b21
        failing since 88 days (last pass: v5.10.176-cip30, first fail: v5.1=
0.177-cip31)

    2023-07-11T15:00:42.120620  + <8>[   19.421002] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11062086_1.5.2.3.1>

    2023-07-11T15:00:42.120705  set +x

    2023-07-11T15:00:42.225017  / # #

    2023-07-11T15:00:42.327567  export SHELL=3D/bin/sh

    2023-07-11T15:00:42.328419  #

    2023-07-11T15:00:42.430074  / # export SHELL=3D/bin/sh. /lava-11062086/=
environment

    2023-07-11T15:00:42.430912  =


    2023-07-11T15:00:42.532677  / # . /lava-11062086/environment/lava-11062=
086/bin/lava-test-runner /lava-11062086/1

    2023-07-11T15:00:42.534006  =


    2023-07-11T15:00:42.539597  / # /lava-11062086/bin/lava-test-runner /la=
va-11062086/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ad6ecf23a6d25a73bb2ad5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-13-g8fae18103387/arm/multi_v7_defconfig/gcc-10/lab-collabora/baselin=
e-nfs-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-13-g8fae18103387/arm/multi_v7_defconfig/gcc-10/lab-collabora/baselin=
e-nfs-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64ad6ecf23a6d25a73bb2ada
        failing since 178 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-07-11T15:01:22.899976  / # #

    2023-07-11T15:01:23.002577  export SHELL=3D/bin/sh

    2023-07-11T15:01:23.003319  #

    2023-07-11T15:01:23.105319  / # export SHELL=3D/bin/sh. /lava-11062012/=
environment

    2023-07-11T15:01:23.106063  =


    2023-07-11T15:01:23.207921  / # . /lava-11062012/environment/lava-11062=
012/bin/lava-test-runner /lava-11062012/1

    2023-07-11T15:01:23.209152  =


    2023-07-11T15:01:23.223074  / # /lava-11062012/bin/lava-test-runner /la=
va-11062012/1

    2023-07-11T15:01:23.411669  + export TESTRUN_ID=3D1_bootrr

    2023-07-11T15:01:23.412161  + cd /lava-11062012/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64ad6f7a6e2271b374bb2a96

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-13-g8fae18103387/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-13-g8fae18103387/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/64ad6f7a6e2271b374bb2a9c
        failing since 111 days (last pass: v5.10.173-cip28, first fail: v5.=
10.175-cip29)

    2023-07-11T15:04:06.952358  /lava-11062104/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/64ad6f7a6e2271b374bb2ada
        failing since 111 days (last pass: v5.10.173-cip28, first fail: v5.=
10.175-cip29)

    2023-07-11T15:04:06.980336  [   35.834745] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-07-11T15:04:08.025206  /lava-11062104/1/../bin/lava-test-case

    2023-07-11T15:04:08.053086  [   36.907540] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =

 =20

