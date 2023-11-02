Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AA3C4332F
	for <webhook@archiver.kernel.org>; Thu,  2 Nov 2023 17:19:19 +0000 (UTC)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
 by mx.groups.io with SMTP id smtpd.web11.37334.1698945554375632865
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 02 Nov 2023 10:19:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=SlgnwumD;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.173, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6bd73395bceso994617b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 02 Nov 2023 10:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698945553; x=1699550353; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vR2IqrHl6IjFceA15O+1+UPS/0tu3++fhf2ANCKNoCM=;
        b=SlgnwumD2f0AvQaI/dnwHQfHZvd4pid4pMnMR93S4tD4ExcIpg4IWnNqpbwwn+d2Kx
         6HaOA7eOom3Rlyfw8xrAtj3ZPBTcRG4dll0ZA7hfp153Jz8rgZ1cZggN+WOQ7e6OLbsz
         677VXnXsCy+CEQf4eyZPw9UpOrUtMnYne0AvfpXXxwHX0lkWFONu82VEAoKGgn6HPERL
         jyYgwnr8CQ3h/5i27hqVEwp4qH8NBWmJetQNEd3w4wYQgQPbxTs3CNlabyyXb9Ml0a9d
         qckvl3RWP//4LDufUl+vQNwsOeLnS7oS1tQf1SY0dePNCgL/zpSzLINmQ8jTj/EJk0UP
         Eu9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698945553; x=1699550353;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vR2IqrHl6IjFceA15O+1+UPS/0tu3++fhf2ANCKNoCM=;
        b=Bo/8BzTAt57wHyqx4q9piCuLu6LwRjOv56r+33e0iShOA3JJXrZnkbVgvs716YH04K
         wuvuSy/8nh7gyHdrnFRWgtaLa2OoQhufXQY4w8PYacuq9vrgDbVggc/wv9uxMWaHuNLF
         w6U83w7opoZHOwYmFs/Uv7LjjTOSAk+snXdSI2ULr9mYSRyfk/rDjeolEA0QBQg+tUC0
         Nrhu0DjlKeS3g2xa1EPQ5qGYLrVHHQ3f0Y2FK+Lqy8JkW7bVZAzHN7eDd6Cg8l80WyhE
         mafSrZc2TxZo0KVHCdBznW7VYK80aYgo58sA+9Wk12ctzS5d8lQF/hrIniXhFp8ltqii
         hfrA==
X-Gm-Message-State: AOJu0YwuaOP0iBh54x19L5I4ofGSD7nHbyP4qSraXLEjyDwHqVHhhdCc
	FHNqbCN6NxlLMm1HpzTpFoJYvcUTew8cibIygKel2Q==
X-Google-Smtp-Source: AGHT+IFKfgNzWjejWaFZrQS/JaGH5LUNFJFOqq2vWngS7ZvjNFh2qmLEjzmeGnr97Y+1U7NSLQ2yKQ==
X-Received: by 2002:a05:6a00:6610:b0:68f:c1e0:a2c4 with SMTP id he16-20020a056a00661000b0068fc1e0a2c4mr173365pfb.3.1698945552813;
        Thu, 02 Nov 2023 10:19:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l5-20020a056a00140500b0068fb783d0c6sm17344pfu.141.2023.11.02.10.19.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 10:19:12 -0700 (PDT)
Message-ID: <6543da10.050a0220.efc94.030f@mx.google.com>
Date: Thu, 02 Nov 2023 10:19:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.194-cip39-915-g96fa7f16cf02
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 172 runs,
 18 regressions (v5.10.194-cip39-915-g96fa7f16cf02)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Nov 2023 17:19:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13520

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 172 runs, 18 regressio=
ns (v5.10.194-cip39-915-g96fa7f16cf02)

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

juno-uboot               | arm64 | lab-broonie   | gcc-10   | defconfig    =
                | 1          =

juno-uboot               | arm64 | lab-broonie   | gcc-10   | defconfig+kse=
lftest          | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook   | 1          =

r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook   | 1          =

r8a774c0-ek874           | arm64 | lab-cip       | gcc-10   | defconfig    =
                | 1          =

r8a774c0-ek874           | arm64 | lab-cip       | gcc-10   | defconfig+kse=
lftest          | 1          =

r8a774c0-ek874           | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook   | 1          =

r8a77960-ulcb            | arm64 | lab-collabora | gcc-10   | defconfig    =
                | 1          =

rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook   | 2          =

rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
...ok+kselftest | 2          =

rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig    =
                | 1          =

rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig+kse=
lftest          | 1          =

sun50i-h6-pine-h64       | arm64 | lab-collabora | gcc-10   | defconfig    =
                | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.194-cip39-915-g96fa7f16cf02/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.194-cip39-915-g96fa7f16cf02
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      96fa7f16cf0228e65eeaeaeef1b73f242f4e169e =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
bcm2836-rpi-2-b          | arm   | lab-collabora | gcc-10   | bcm2835_defco=
nfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/6543c9a04002420aedefcf0c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm/bcm2835_defconfig/gcc-10=
/lab-collabora/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm/bcm2835_defconfig/gcc-10=
/lab-collabora/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6543c9a04002420aedefcf15
        failing since 98 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-11-02T16:13:01.962911  / # #

    2023-11-02T16:13:02.063569  export SHELL=3D/bin/sh

    2023-11-02T16:13:02.063784  #

    2023-11-02T16:13:02.164322  / # export SHELL=3D/bin/sh. /lava-11931661/=
environment

    2023-11-02T16:13:02.164551  =


    2023-11-02T16:13:02.265160  / # . /lava-11931661/environment/lava-11931=
661/bin/lava-test-runner /lava-11931661/1

    2023-11-02T16:13:02.265484  =


    2023-11-02T16:13:02.275567  / # /lava-11931661/bin/lava-test-runner /la=
va-11931661/1

    2023-11-02T16:13:02.386507  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-02T16:13:02.386685  + cd /lava-11931661/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
beaglebone-black         | arm   | lab-broonie   | gcc-10   | omap2plus_def=
config          | 1          =


  Details:     https://kernelci.org/test/plan/id/6543c8ce33defd1543efcf0d

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm/omap2plus_defconfig/gcc-=
10/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm/omap2plus_defconfig/gcc-=
10/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6543c8ce33defd1543efcf45
        failing since 302 days (last pass: v5.10.155-cip21-405-g26d566555c3=
de, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2023-11-02T16:05:09.989135  <8>[   20.706534] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 217550_1.5.2.4.1>
    2023-11-02T16:05:10.098018  / # #
    2023-11-02T16:05:10.200652  export SHELL=3D/bin/sh
    2023-11-02T16:05:10.201323  #
    2023-11-02T16:05:10.303113  / # export SHELL=3D/bin/sh. /lava-217550/en=
vironment
    2023-11-02T16:05:10.303790  =

    2023-11-02T16:05:10.405748  / # . /lava-217550/environment/lava-217550/=
bin/lava-test-runner /lava-217550/1
    2023-11-02T16:05:10.406709  =

    2023-11-02T16:05:10.411538  / # /lava-217550/bin/lava-test-runner /lava=
-217550/1
    2023-11-02T16:05:10.516289  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
beaglebone-black         | arm   | lab-cip       | gcc-10   | omap2plus_def=
config          | 1          =


  Details:     https://kernelci.org/test/plan/id/6543c8a834c25635bcefcf2a

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm/omap2plus_defconfig/gcc-=
10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm/omap2plus_defconfig/gcc-=
10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6543c8a834c25635bcefcf60
        failing since 302 days (last pass: v5.10.155-cip21-405-g26d566555c3=
de, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2023-11-02T16:04:40.662741  <8>[   13.027220] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1032802_1.5.2.4.1>
    2023-11-02T16:04:40.771919  / # #
    2023-11-02T16:04:40.872966  export SHELL=3D/bin/sh
    2023-11-02T16:04:40.873347  #
    2023-11-02T16:04:40.974030  / # export SHELL=3D/bin/sh. /lava-1032802/e=
nvironment
    2023-11-02T16:04:40.974443  =

    2023-11-02T16:04:41.075172  / # . /lava-1032802/environment/lava-103280=
2/bin/lava-test-runner /lava-1032802/1
    2023-11-02T16:04:41.075679  =

    2023-11-02T16:04:41.081685  / # /lava-1032802/bin/lava-test-runner /lav=
a-1032802/1
    2023-11-02T16:04:41.183097  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
juno-uboot               | arm64 | lab-broonie   | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/6543c7d8f71e2db267efcf1a

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig/gcc-10/lab-b=
roonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig/gcc-10/lab-b=
roonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6543c7d8f71e2db267efcf58
        failing since 98 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-11-02T16:00:55.407383  / # #
    2023-11-02T16:00:55.510124  export SHELL=3D/bin/sh
    2023-11-02T16:00:55.510886  #
    2023-11-02T16:00:55.612568  / # export SHELL=3D/bin/sh. /lava-217500/en=
vironment
    2023-11-02T16:00:55.613361  =

    2023-11-02T16:00:55.715331  / # . /lava-217500/environment/lava-217500/=
bin/lava-test-runner /lava-217500/1
    2023-11-02T16:00:55.716571  =

    2023-11-02T16:00:55.731558  / # /lava-217500/bin/lava-test-runner /lava=
-217500/1
    2023-11-02T16:00:55.789329  + export 'TESTRUN_ID=3D1_bootrr'
    2023-11-02T16:00:55.789811  + cd /lava-217500/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
juno-uboot               | arm64 | lab-broonie   | gcc-10   | defconfig+kse=
lftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6543c8dc28970f3689efcefc

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig+kselftest/gc=
c-10/lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig+kselftest/gc=
c-10/lab-broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6543c8dd28970f3689efcf3c
        failing since 42 days (last pass: v5.10.191-cip38-661-g112a3073ff26=
, first fail: v5.10.194-cip39-407-g664623343843d)

    2023-11-02T16:05:14.892440  <8>[   18.929697] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 217542_1.5.2.4.1>
    2023-11-02T16:05:15.000271  / # #
    2023-11-02T16:05:15.103263  export SHELL=3D/bin/sh
    2023-11-02T16:05:15.104080  #
    2023-11-02T16:05:15.206066  / # export SHELL=3D/bin/sh. /lava-217542/en=
vironment
    2023-11-02T16:05:15.206882  =

    2023-11-02T16:05:15.308871  / # . /lava-217542/environment/lava-217542/=
bin/lava-test-runner /lava-217542/1
    2023-11-02T16:05:15.310218  =

    2023-11-02T16:05:15.323780  / # /lava-217542/bin/lava-test-runner /lava=
-217542/1
    2023-11-02T16:05:15.501407  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6543cd79fdcba07c2aefcef3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6543cd79fdcba07c2aefcefc
        failing since 97 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-11-02T16:25:03.293644  + set +x
    2023-11-02T16:25:03.296812  <8>[   83.917046] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1032847_1.5.2.4.1>
    2023-11-02T16:25:03.405222  / # #
    2023-11-02T16:25:04.861709  export SHELL=3D/bin/sh
    2023-11-02T16:25:04.882563  #
    2023-11-02T16:25:04.883023  / # export SHELL=3D/bin/sh
    2023-11-02T16:25:06.833918  / # . /lava-1032847/environment
    2023-11-02T16:25:10.415734  /lava-1032847/bin/lava-test-runner /lava-10=
32847/1
    2023-11-02T16:25:10.436229  . /lava-1032847/environment
    2023-11-02T16:25:10.436320  / # /lava-1032847/bin/lava-test-runner /lav=
a-1032847/1 =

    ... (28 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6543cf069a21c01371efcf21

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/baseline-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/baseline-r8a774b1-hihope-rzg2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6543cf069a21c01371efcf2a
        failing since 98 days (last pass: v5.10.182-cip35-289-g3c0549540706=
, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-11-02T16:31:35.850681  + set +x
    2023-11-02T16:31:35.853784  <8>[   84.184074] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1032842_1.5.2.4.1>
    2023-11-02T16:31:35.958725  / # #
    2023-11-02T16:31:37.413898  export SHELL=3D/bin/sh
    2023-11-02T16:31:37.434251  #
    2023-11-02T16:31:37.434396  / # export SHELL=3D/bin/sh
    2023-11-02T16:31:39.382448  / # . /lava-1032842/environment
    2023-11-02T16:31:42.965901  /lava-1032842/bin/lava-test-runner /lava-10=
32842/1
    2023-11-02T16:31:42.987105  . /lava-1032842/environment
    2023-11-02T16:31:42.987485  / # /lava-1032842/bin/lava-test-runner /lav=
a-1032842/1 =

    ... (15 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a774c0-ek874           | arm64 | lab-cip       | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/6543c9990b1ea0f766efcf35

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig/gcc-10/lab-c=
ip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig/gcc-10/lab-c=
ip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6543c9990b1ea0f766efcf3e
        failing since 98 days (last pass: v5.10.182-cip35-289-g3c0549540706=
, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-11-02T16:08:27.882398  / # #
    2023-11-02T16:08:29.339101  export SHELL=3D/bin/sh
    2023-11-02T16:08:29.359948  #
    2023-11-02T16:08:29.360393  / # export SHELL=3D/bin/sh
    2023-11-02T16:08:31.308205  / # . /lava-1032785/environment
    2023-11-02T16:08:34.893858  /lava-1032785/bin/lava-test-runner /lava-10=
32785/1
    2023-11-02T16:08:34.914415  . /lava-1032785/environment
    2023-11-02T16:08:34.914512  / # /lava-1032785/bin/lava-test-runner /lav=
a-1032785/1
    2023-11-02T16:08:34.992562  + export 'TESTRUN_ID=3D1_bootrr'
    2023-11-02T16:08:34.993072  + cd /lava-1032785/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a774c0-ek874           | arm64 | lab-cip       | gcc-10   | defconfig+kse=
lftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6543cad1c21e7c0406efcf1d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig+kselftest/gc=
c-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig+kselftest/gc=
c-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6543cad1c21e7c0406efcf24
        failing since 98 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-11-02T16:13:54.273834  / # #
    2023-11-02T16:13:55.727549  export SHELL=3D/bin/sh
    2023-11-02T16:13:55.747834  #
    2023-11-02T16:13:55.747945  / # export SHELL=3D/bin/sh
    2023-11-02T16:13:57.692623  / # . /lava-1032797/environment
    2023-11-02T16:14:01.272228  /lava-1032797/bin/lava-test-runner /lava-10=
32797/1
    2023-11-02T16:14:01.292636  . /lava-1032797/environment
    2023-11-02T16:14:01.292717  / # /lava-1032797/bin/lava-test-runner /lav=
a-1032797/1
    2023-11-02T16:14:01.427093  + export 'TESTRUN_ID=3D1_bootrr'
    2023-11-02T16:14:01.474175  + cd /lava-1032797/1/tests/1_bootrr =

    ... (24 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a774c0-ek874           | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6543cbd234c9452caeefcfb9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6543cbd234c9452caeefcfc2
        failing since 98 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-11-02T16:18:02.816149  / # #
    2023-11-02T16:18:04.273860  export SHELL=3D/bin/sh
    2023-11-02T16:18:04.294637  #
    2023-11-02T16:18:04.295054  / # export SHELL=3D/bin/sh
    2023-11-02T16:18:06.242687  / # . /lava-1032843/environment
    2023-11-02T16:18:09.827644  /lava-1032843/bin/lava-test-runner /lava-10=
32843/1
    2023-11-02T16:18:09.849133  . /lava-1032843/environment
    2023-11-02T16:18:09.849564  / # /lava-1032843/bin/lava-test-runner /lav=
a-1032843/1
    2023-11-02T16:18:09.928974  + export 'TESTRUN_ID=3D1_bootrr'
    2023-11-02T16:18:09.929187  + cd /lava-1032843/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a77960-ulcb            | arm64 | lab-collabora | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/6543c743c8fed5d1fdefcef4

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6543c743c8fed5d1fdefcefd
        failing since 98 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-11-02T16:03:00.407929  / # #

    2023-11-02T16:03:00.509839  export SHELL=3D/bin/sh

    2023-11-02T16:03:00.510094  #

    2023-11-02T16:03:00.610740  / # export SHELL=3D/bin/sh. /lava-11931586/=
environment

    2023-11-02T16:03:00.610982  =


    2023-11-02T16:03:00.711619  / # . /lava-11931586/environment/lava-11931=
586/bin/lava-test-runner /lava-11931586/1

    2023-11-02T16:03:00.712587  =


    2023-11-02T16:03:00.721834  / # /lava-11931586/bin/lava-test-runner /la=
va-11931586/1

    2023-11-02T16:03:00.764222  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-02T16:03:00.781395  + cd /lav<8>[   16.445025] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11931586_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6543cadd54cc1a9893efcf15

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/6543cadd54cc1a9893efcf1f
        failing since 196 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-11-02T16:14:33.907654  <8>[   34.165907] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-11-02T16:14:34.932868  /lava-11931781/1/../bin/lava-test-case

    2023-11-02T16:14:34.943338  <8>[   35.201414] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/6543cadd54cc1a9893efcf20
        failing since 196 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-11-02T16:14:32.872235  <8>[   33.129321] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-11-02T16:14:33.896661  /lava-11931781/1/../bin/lava-test-case
   =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
...ok+kselftest | 2          =


  Details:     https://kernelci.org/test/plan/id/6543d3b2e5b71460d2efcf00

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig+arm64-chrome=
book+kselftest/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig+arm64-chrome=
book+kselftest/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/6543d3b2e5b71460d2efcf0a
        failing since 196 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-11-02T16:51:37.703101  <8>[   41.006123] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-11-02T16:51:38.761758  /lava-11932023/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/6543d3b2e5b71460d2efcf0b
        failing since 196 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-11-02T16:51:37.676121  /lava-11932023/1/../bin/lava-test-case
   =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/6543c75e4ef52a5881efcf02

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6543c75e4ef52a5881efcf0b
        failing since 67 days (last pass: v5.10.186-cip37-770-gddd36cfc4c4c=
8, first fail: v5.10.186-cip37-982-g80a0585c0aa62)

    2023-11-02T15:58:58.705368  / # #

    2023-11-02T15:58:59.963586  export SHELL=3D/bin/sh

    2023-11-02T15:58:59.974459  #

    2023-11-02T15:59:01.716919  / # export SHELL=3D/bin/sh. /lava-11931590/=
environment

    2023-11-02T15:59:01.727844  =


    2023-11-02T15:59:01.728295  / # . /lava-11931590/environment

    2023-11-02T15:59:04.918175  / # /lava-11931590/bin/lava-test-runner /la=
va-11931590/1

    2023-11-02T15:59:04.932809  /lava-11931590/bin/lava-test-runner /lava-1=
1931590/1

    2023-11-02T15:59:04.984756  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-02T15:59:04.985256  + cd /lava-11931590/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig+kse=
lftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6543c7f903a6ee1beaefcf1b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig+kselftest/gc=
c-10/lab-collabora/baseline-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig+kselftest/gc=
c-10/lab-collabora/baseline-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6543c7f903a6ee1beaefcf24
        failing since 67 days (last pass: v5.10.186-cip37-770-gddd36cfc4c4c=
8, first fail: v5.10.186-cip37-982-g80a0585c0aa62)

    2023-11-02T16:04:30.144213  / # #

    2023-11-02T16:04:31.405117  export SHELL=3D/bin/sh

    2023-11-02T16:04:31.416118  #

    2023-11-02T16:04:31.416587  / # export SHELL=3D/bin/sh

    2023-11-02T16:04:33.160189  / # . /lava-11931651/environment

    2023-11-02T16:04:36.365044  /lava-11931651/bin/lava-test-runner /lava-1=
1931651/1

    2023-11-02T16:04:36.376517  . /lava-11931651/environment

    2023-11-02T16:04:36.379053  / # /lava-11931651/bin/lava-test-runner /la=
va-11931651/1

    2023-11-02T16:04:36.503966  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-02T16:04:36.504453  + cd /lava-11931651/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
sun50i-h6-pine-h64       | arm64 | lab-collabora | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/6543c7fc03a6ee1beaefcf26

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6543c7fc03a6ee1beaefcf2f
        failing since 98 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-11-02T16:05:58.485041  / # #

    2023-11-02T16:05:58.585892  export SHELL=3D/bin/sh

    2023-11-02T16:05:58.586563  #

    2023-11-02T16:05:58.687789  / # export SHELL=3D/bin/sh. /lava-11931597/=
environment

    2023-11-02T16:05:58.688007  =


    2023-11-02T16:05:58.788772  / # . /lava-11931597/environment/lava-11931=
597/bin/lava-test-runner /lava-11931597/1

    2023-11-02T16:05:58.789778  =


    2023-11-02T16:05:58.799172  / # /lava-11931597/bin/lava-test-runner /la=
va-11931597/1

    2023-11-02T16:05:58.862318  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-02T16:05:58.862762  + cd /lava-1193159<8>[   18.147671] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11931597_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

