Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FC6C54E49
	for <webhook@archiver.kernel.org>; Wed,  6 Mar 2024 22:16:55 +0000 (UTC)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
 by mx.groups.io with SMTP id smtpd.web11.9040.1709763410267489860
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 06 Mar 2024 14:16:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=M8yFNc33;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.176, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5d4a1e66750so154294a12.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 06 Mar 2024 14:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709763409; x=1710368209; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=smw4qS6sNvbc7/aavlKfAGRotg/4uiGqEWGEdbYzq9Y=;
        b=M8yFNc33VqXIXBJfzeu2aYsJ8N11O1uTAA3xEr1OLScB9UGDOFSMKzp8sWbfvL23F/
         ClkXxG7og/G860+CTPJHMDKDVZxcJOYPyrUaG+LXwg7BIEqvWtKxatrQDPZMCv1S8Fxh
         cOV95Aq/Pnx+e22eH4jMpF9rhZtQLapwOBqA9FFSZPQsL728U9V5Vm8SHpPOf40nFDec
         gg2jYaPMgjbOmqz9NzgfhKx1+ju3lptBm9/LATliwvKBO/czuCxH3QdB5S59zGovVLDn
         eIEPKOyu5vVgyEDpmAKAmD2Rk8Zgv8OKPALd3i72ySEEmiPCVzUUnVRCy77muAkdfFFE
         QXJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709763409; x=1710368209;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=smw4qS6sNvbc7/aavlKfAGRotg/4uiGqEWGEdbYzq9Y=;
        b=otZq0IAiUZlMy8JMuU6T+tWGpooIf98AFtBZ8Sei9m8OeBCvFb18NkLWmDv4tE45Lx
         8NDVa7LAfTBqp4xAWlXbeZX6yKPITr5O4DJi6fL2QBohjVXadjcgDPJvngxYvTStc0Jq
         HrcNakG56xVQZUWQbpT07mkrrixz8i6uHj3wViNA6F6Wea+bK51LlThETkp0DgeEWWGs
         yNwf717iyfJxRe2xN9wmMcQ/NWs13JEang0D17LnjO5LzVEltoDDM1w1ZkFMhc/sCzrd
         hqAx7WmjOL/w5sy4rsZMk8KVYMhD11Re1tZJ5IgI51WQCUtF1+JGSvnb4WaNEuIAvTKp
         RjaA==
X-Gm-Message-State: AOJu0YzDeKugxShJsE7ItfOK7ox1UlLy9QY2/zDZHORH/WZCQJJ1oETy
	uqAB38k1URyntpomF4WRV9U6iWusqTX+YmvWoM2OjCQAV0EXXDKoNcGd5ULMpIepFbGXtMrd0NO
	J4KQ=
X-Google-Smtp-Source: AGHT+IFLaq7RU9qmEW7N6l0eRpa8RLoYA2vf9bzrFIg+VB4lMQ0kSeR2hjBkMLt5GaIgKxVDcrU2WA==
X-Received: by 2002:a17:90a:a8f:b0:299:7b37:9221 with SMTP id 15-20020a17090a0a8f00b002997b379221mr12746117pjw.12.1709763408828;
        Wed, 06 Mar 2024 14:16:48 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id e12-20020a17090ab38c00b0029a75e027f0sm214432pjr.51.2024.03.06.14.16.47
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 14:16:47 -0800 (PST)
Message-ID: <65e8eb4f.170a0220.438a1.1599@mx.google.com>
Date: Wed, 06 Mar 2024 14:16:47 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.209-cip44-594-gb47da48f3bae7
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 165 runs,
 20 regressions (v5.10.209-cip44-594-gb47da48f3bae7)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Mar 2024 22:16:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15242

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 165 runs, 20 regressio=
ns (v5.10.209-cip44-594-gb47da48f3bae7)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
at91sam9g20ek            | arm   | lab-broonie   | gcc-10   | at91_dt_defco=
nfig          | 2          =

bcm2836-rpi-2-b          | arm   | lab-collabora | gcc-10   | bcm2835_defco=
nfig          | 1          =

beaglebone-black         | arm   | lab-broonie   | gcc-10   | omap2plus_def=
config        | 1          =

beaglebone-black         | arm   | lab-cip       | gcc-10   | omap2plus_def=
config        | 1          =

juno-uboot               | arm64 | lab-broonie   | gcc-10   | defconfig+kse=
lftest        | 1          =

juno-uboot               | arm64 | lab-broonie   | gcc-10   | defconfig    =
              | 1          =

r8a7743-iwg20d-q7        | arm   | lab-cip       | gcc-10   | shmobile_defc=
onfig         | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =

r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 1          =

r8a774c0-ek874           | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 1          =

r8a774c0-ek874           | arm64 | lab-cip       | gcc-10   | defconfig+kse=
lftest        | 1          =

r8a774c0-ek874           | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =

r8a77960-ulcb            | arm64 | lab-collabora | gcc-10   | defconfig    =
              | 1          =

rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 2          =

rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig+kse=
lftest        | 1          =

rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig    =
              | 1          =

sun50i-h6-pine-h64       | arm64 | lab-collabora | gcc-10   | defconfig    =
              | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.209-cip44-594-gb47da48f3bae7/plan/baselin=
e/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.209-cip44-594-gb47da48f3bae7
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b47da48f3bae7f477104b0c214451338a6a343df =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
at91sam9g20ek            | arm   | lab-broonie   | gcc-10   | at91_dt_defco=
nfig          | 2          =


  Details:     https://kernelci.org/test/plan/id/65e8dd70e552688c214c4334

  Results:     47 PASS, 6 FAIL, 1 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm/at91_dt_defconfig/gcc-1=
0/lab-broonie/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm/at91_dt_defconfig/gcc-1=
0/lab-broonie/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/65e8dd70e=
552688c214c4342
        failing since 12 days (last pass: v5.10.205-905-gb40421b142370, fir=
st fail: v5.10.209-cip44-424-g38943e302f8c8)

    2024-03-06T21:17:13.841340  /lava-674938/1/../bin/lava-test-case
    2024-03-06T21:17:13.880094  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dsou=
nd-card RESULT=3Dfail>   =


  * baseline.bootrr.audio-card-probed: https://kernelci.org/test/case/id/65=
e8dd70e552688c214c4343
        failing since 12 days (last pass: v5.10.205-905-gb40421b142370, fir=
st fail: v5.10.209-cip44-424-g38943e302f8c8)

    2024-03-06T21:17:12.739794  /lava-674938/1/../bin/lava-test-case
    2024-03-06T21:17:12.779090  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Daud=
io-card-probed RESULT=3Dfail>   =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
bcm2836-rpi-2-b          | arm   | lab-collabora | gcc-10   | bcm2835_defco=
nfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/65e8dd8fbdf2afaadf4c4308

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm/bcm2835_defconfig/gcc-1=
0/lab-collabora/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm/bcm2835_defconfig/gcc-1=
0/lab-collabora/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e8dd8fbdf2afaadf4c4311
        failing since 223 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2024-03-06T21:28:46.899742  / # #

    2024-03-06T21:28:47.001960  export SHELL=3D/bin/sh

    2024-03-06T21:28:47.002688  #

    2024-03-06T21:28:47.104153  / # export SHELL=3D/bin/sh. /lava-12965266/=
environment

    2024-03-06T21:28:47.104858  =


    2024-03-06T21:28:47.206278  / # . /lava-12965266/environment/lava-12965=
266/bin/lava-test-runner /lava-12965266/1

    2024-03-06T21:28:47.207397  =


    2024-03-06T21:28:47.224076  / # /lava-12965266/bin/lava-test-runner /la=
va-12965266/1

    2024-03-06T21:28:47.288068  + export 'TESTRUN_ID=3D1_bootrr'

    2024-03-06T21:28:47.330784  + cd /lava-12965266/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
beaglebone-black         | arm   | lab-broonie   | gcc-10   | omap2plus_def=
config        | 1          =


  Details:     https://kernelci.org/test/plan/id/65e8deec27a051dc824c43b8

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm/omap2plus_defconfig/gcc=
-10/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm/omap2plus_defconfig/gcc=
-10/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e8deec27a051dc824c43f2
        failing since 427 days (last pass: v5.10.155-cip21-405-g26d566555c3=
de, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2024-03-06T21:23:40.602046  <8>[   20.125861] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 674956_1.5.2.4.1>
    2024-03-06T21:23:40.708715  / # #
    2024-03-06T21:23:40.809993  export SHELL=3D/bin/sh
    2024-03-06T21:23:40.810260  #
    2024-03-06T21:23:40.911377  / # export SHELL=3D/bin/sh. /lava-674956/en=
vironment
    2024-03-06T21:23:40.911776  =

    2024-03-06T21:23:41.012868  / # . /lava-674956/environment/lava-674956/=
bin/lava-test-runner /lava-674956/1
    2024-03-06T21:23:41.013269  =

    2024-03-06T21:23:41.017849  / # /lava-674956/bin/lava-test-runner /lava=
-674956/1
    2024-03-06T21:23:41.123931  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
beaglebone-black         | arm   | lab-cip       | gcc-10   | omap2plus_def=
config        | 1          =


  Details:     https://kernelci.org/test/plan/id/65e8defe722d90af8b4c42f2

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm/omap2plus_defconfig/gcc=
-10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm/omap2plus_defconfig/gcc=
-10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e8defe722d90af8b4c4328
        failing since 427 days (last pass: v5.10.155-cip21-405-g26d566555c3=
de, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2024-03-06T21:24:03.940642  <8>[   14.033838] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1104116_1.5.2.4.1>
    2024-03-06T21:24:04.047621  / # #
    2024-03-06T21:24:04.148974  export SHELL=3D/bin/sh
    2024-03-06T21:24:04.149402  #
    2024-03-06T21:24:04.250358  / # export SHELL=3D/bin/sh. /lava-1104116/e=
nvironment
    2024-03-06T21:24:04.250795  =

    2024-03-06T21:24:04.351741  / # . /lava-1104116/environment/lava-110411=
6/bin/lava-test-runner /lava-1104116/1
    2024-03-06T21:24:04.352440  =

    2024-03-06T21:24:04.356690  / # /lava-1104116/bin/lava-test-runner /lav=
a-1104116/1
    2024-03-06T21:24:04.453953  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
juno-uboot               | arm64 | lab-broonie   | gcc-10   | defconfig+kse=
lftest        | 1          =


  Details:     https://kernelci.org/test/plan/id/65e8dfb4340ca896134c42da

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig+kselftest/g=
cc-10/lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig+kselftest/g=
cc-10/lab-broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65e8dfb4340ca896134c4=
2db
        new failure (last pass: v5.10.209-cip44-56-g55117716ac0fd) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
juno-uboot               | arm64 | lab-broonie   | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/65e8e88a725510c3434c42e1

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig/gcc-10/lab-=
broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig/gcc-10/lab-=
broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e8e88a725510c3434c431d
        failing since 53 days (last pass: v5.10.205-897-gcc9858ae2881, firs=
t fail: v5.10.205-905-gb40421b142370)

    2024-03-06T22:04:28.068546  / # #
    2024-03-06T22:04:28.171396  export SHELL=3D/bin/sh
    2024-03-06T22:04:28.172158  #
    2024-03-06T22:04:28.274170  / # export SHELL=3D/bin/sh. /lava-675094/en=
vironment
    2024-03-06T22:04:28.274951  =

    2024-03-06T22:04:28.376954  / # . /lava-675094/environment/lava-675094/=
bin/lava-test-runner /lava-675094/1
    2024-03-06T22:04:28.378244  =

    2024-03-06T22:04:28.392748  / # /lava-675094/bin/lava-test-runner /lava=
-675094/1
    2024-03-06T22:04:28.450619  + export 'TESTRUN_ID=3D1_bootrr'
    2024-03-06T22:04:28.451132  + cd /lava-675094/1/tests/1_bootrr =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a7743-iwg20d-q7        | arm   | lab-cip       | gcc-10   | shmobile_defc=
onfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65e8dfec0fa2ed141f4c42e3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm/shmobile_defconfig/gcc-=
10/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm/shmobile_defconfig/gcc-=
10/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65e8dfec0fa2ed141f4c4=
2e4
        failing since 83 days (last pass: v5.10.201-cip41-473-gc43d7b7bbe83=
a, first fail: v5.10.201-cip41-69-g8f7b450fc28ed) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65e8df8701a0057ed04c439f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e8df8701a0057ed04c43a6
        failing since 223 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2024-03-06T21:26:11.503691  + set +x
    2024-03-06T21:26:11.506753  <8>[   83.968004] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1104125_1.5.2.4.1>
    2024-03-06T21:26:11.612083  / # #
    2024-03-06T21:26:13.066049  export SHELL=3D/bin/sh
    2024-03-06T21:26:13.086369  #
    2024-03-06T21:26:13.086517  / # export SHELL=3D/bin/sh
    2024-03-06T21:26:15.031209  / # . /lava-1104125/environment
    2024-03-06T21:26:18.609396  /lava-1104125/bin/lava-test-runner /lava-11=
04125/1
    2024-03-06T21:26:18.629842  . /lava-1104125/environment
    2024-03-06T21:26:18.629937  / # /lava-1104125/bin/lava-test-runner /lav=
a-1104125/1 =

    ... (28 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/65e8e52034ca536bbe4c4331

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig/gcc-10/lab-=
cip/baseline-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig/gcc-10/lab-=
cip/baseline-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e8e52034ca536bbe4c433a
        failing since 189 days (last pass: v5.10.180-cip33-21-g090289427e8b=
2, first fail: v5.10.191-cip38-218-g9947ff6f0dba7)

    2024-03-06T21:49:53.500333  + set +x
    2024-03-06T21:49:53.503575  <8>[   84.023187] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1104183_1.5.2.4.1>
    2024-03-06T21:49:53.612774  / # #
    2024-03-06T21:49:55.070540  export SHELL=3D/bin/sh
    2024-03-06T21:49:55.091324  #
    2024-03-06T21:49:55.091740  / # export SHELL=3D/bin/sh
    2024-03-06T21:49:57.040711  / # . /lava-1104183/environment
    2024-03-06T21:50:00.625691  /lava-1104183/bin/lava-test-runner /lava-11=
04183/1
    2024-03-06T21:50:00.646351  . /lava-1104183/environment
    2024-03-06T21:50:00.646499  / # /lava-1104183/bin/lava-test-runner /lav=
a-1104183/1 =

    ... (28 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65e8df9beaa70964b24c42e0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-r8a774b1-hihope-rzg2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e8df9beaa70964b24c42e9
        failing since 223 days (last pass: v5.10.182-cip35-289-g3c054954070=
6, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2024-03-06T21:26:35.432470  + set +x
    2024-03-06T21:26:35.435399  <8>[   84.198098] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1104127_1.5.2.4.1>
    2024-03-06T21:26:35.543204  / # #
    2024-03-06T21:26:37.003589  export SHELL=3D/bin/sh
    2024-03-06T21:26:37.024596  #
    2024-03-06T21:26:37.025125  / # export SHELL=3D/bin/sh
    2024-03-06T21:26:38.977088  / # . /lava-1104127/environment
    2024-03-06T21:26:42.568414  /lava-1104127/bin/lava-test-runner /lava-11=
04127/1
    2024-03-06T21:26:42.588990  . /lava-1104127/environment
    2024-03-06T21:26:42.589082  / # /lava-1104127/bin/lava-test-runner /lav=
a-1104127/1 =

    ... (15 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774c0-ek874           | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65e8dfafceb3cb46324c42fd

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e8dfafceb3cb46324c4305
        failing since 223 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2024-03-06T21:26:45.177695  / # #
    2024-03-06T21:26:46.634023  export SHELL=3D/bin/sh
    2024-03-06T21:26:46.654844  #
    2024-03-06T21:26:46.655260  / # export SHELL=3D/bin/sh
    2024-03-06T21:26:48.601701  / # . /lava-1104131/environment
    2024-03-06T21:26:52.191833  /lava-1104131/bin/lava-test-runner /lava-11=
04131/1
    2024-03-06T21:26:52.213434  . /lava-1104131/environment
    2024-03-06T21:26:52.213816  / # /lava-1104131/bin/lava-test-runner /lav=
a-1104131/1
    2024-03-06T21:26:52.291247  + export 'TESTRUN_ID=3D1_bootrr'
    2024-03-06T21:26:52.291817  + cd /lava-1104131/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774c0-ek874           | arm64 | lab-cip       | gcc-10   | defconfig+kse=
lftest        | 1          =


  Details:     https://kernelci.org/test/plan/id/65e8e2cf084d2070144c4356

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig+kselftest/g=
cc-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig+kselftest/g=
cc-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e8e2cf084d2070144c435f
        failing since 223 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2024-03-06T21:40:02.688774  / # #
    2024-03-06T21:40:04.149215  export SHELL=3D/bin/sh
    2024-03-06T21:40:04.170218  #
    2024-03-06T21:40:04.170764  / # export SHELL=3D/bin/sh
    2024-03-06T21:40:06.122546  / # . /lava-1104139/environment
    2024-03-06T21:40:09.714207  /lava-1104139/bin/lava-test-runner /lava-11=
04139/1
    2024-03-06T21:40:09.735802  . /lava-1104139/environment
    2024-03-06T21:40:09.736178  / # /lava-1104139/bin/lava-test-runner /lav=
a-1104139/1
    2024-03-06T21:40:09.916424  + export 'TESTRUN_ID=3D1_bootrr'
    2024-03-06T21:40:09.916958  + cd /lava-1104139/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774c0-ek874           | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/65e8e53d8db797ae754c42e3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig/gcc-10/lab-=
cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig/gcc-10/lab-=
cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e8e53d8db797ae754c42ec
        failing since 223 days (last pass: v5.10.182-cip35-289-g3c054954070=
6, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2024-03-06T21:50:39.367820  / # #
    2024-03-06T21:50:40.823559  export SHELL=3D/bin/sh
    2024-03-06T21:50:40.843929  #
    2024-03-06T21:50:40.844113  / # export SHELL=3D/bin/sh
    2024-03-06T21:50:42.789450  / # . /lava-1104178/environment
    2024-03-06T21:50:46.369374  /lava-1104178/bin/lava-test-runner /lava-11=
04178/1
    2024-03-06T21:50:46.389976  . /lava-1104178/environment
    2024-03-06T21:50:46.390065  / # /lava-1104178/bin/lava-test-runner /lav=
a-1104178/1
    2024-03-06T21:50:46.424885  + export 'TESTRUN_ID=3D1_bootrr'
    2024-03-06T21:50:46.469722  + cd /lava-1104178/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a77960-ulcb            | arm64 | lab-collabora | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/65e8e498535af1f08c4c42db

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig/gcc-10/lab-=
collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig/gcc-10/lab-=
collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e8e498535af1f08c4c42e4
        failing since 223 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2024-03-06T21:58:59.141742  / # #

    2024-03-06T21:58:59.243902  export SHELL=3D/bin/sh

    2024-03-06T21:58:59.244647  #

    2024-03-06T21:58:59.346104  / # export SHELL=3D/bin/sh. /lava-12965577/=
environment

    2024-03-06T21:58:59.346837  =


    2024-03-06T21:58:59.448210  / # . /lava-12965577/environment/lava-12965=
577/bin/lava-test-runner /lava-12965577/1

    2024-03-06T21:58:59.449315  =


    2024-03-06T21:58:59.451328  / # /lava-12965577/bin/lava-test-runner /la=
va-12965577/1

    2024-03-06T21:58:59.515070  + export 'TESTRUN_ID=3D1_bootrr'

    2024-03-06T21:58:59.515591  + cd /lav<8>[   16.417779] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12965577_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/65e8dee027a051dc824c430a

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/65e8dee027a051dc824c4314
        failing since 321 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2024-03-06T21:23:33.878580  <8>[   32.418422] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2024-03-06T21:23:34.902958  /lava-12965283/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/65e8dee027a051dc824c4315
        failing since 321 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2024-03-06T21:23:32.840843  <8>[   31.381471] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2024-03-06T21:23:33.866248  /lava-12965283/1/../bin/lava-test-case
   =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig+kse=
lftest        | 1          =


  Details:     https://kernelci.org/test/plan/id/65e8df14e659c17a1f4c42da

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig+kselftest/g=
cc-10/lab-collabora/baseline-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig+kselftest/g=
cc-10/lab-collabora/baseline-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e8df14e659c17a1f4c42e3
        failing since 193 days (last pass: v5.10.186-cip37-770-gddd36cfc4c4=
c8, first fail: v5.10.186-cip37-982-g80a0585c0aa62)

    2024-03-06T21:24:23.858230  / # #

    2024-03-06T21:24:25.118298  export SHELL=3D/bin/sh

    2024-03-06T21:24:25.129189  #

    2024-03-06T21:24:25.129625  / # export SHELL=3D/bin/sh

    2024-03-06T21:24:26.872594  / # . /lava-12965314/environment

    2024-03-06T21:24:30.074842  /lava-12965314/bin/lava-test-runner /lava-1=
2965314/1

    2024-03-06T21:24:30.086012  . /lava-12965314/environment

    2024-03-06T21:24:30.086374  / # /lava-12965314/bin/lava-test-runner /la=
va-12965314/1

    2024-03-06T21:24:30.218718  + export 'TESTRUN_ID=3D1_bootrr'

    2024-03-06T21:24:30.219197  + cd /lava-12965314/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/65e8e4c33b69b511144c42dd

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig/gcc-10/lab-=
collabora/baseline-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig/gcc-10/lab-=
collabora/baseline-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e8e4c33b69b511144c42e6
        failing since 193 days (last pass: v5.10.186-cip37-770-gddd36cfc4c4=
c8, first fail: v5.10.186-cip37-982-g80a0585c0aa62)

    2024-03-06T21:49:51.528373  / # #

    2024-03-06T21:49:52.789167  export SHELL=3D/bin/sh

    2024-03-06T21:49:52.800107  #

    2024-03-06T21:49:52.800646  / # export SHELL=3D/bin/sh

    2024-03-06T21:49:54.544018  / # . /lava-12965573/environment

    2024-03-06T21:49:57.748610  /lava-12965573/bin/lava-test-runner /lava-1=
2965573/1

    2024-03-06T21:49:57.760033  . /lava-12965573/environment

    2024-03-06T21:49:57.762390  / # /lava-12965573/bin/lava-test-runner /la=
va-12965573/1

    2024-03-06T21:49:57.815472  + export 'TESTRUN_ID=3D1_bootrr'

    2024-03-06T21:49:57.815964  + cd /lava-12965573/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
sun50i-h6-pine-h64       | arm64 | lab-collabora | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/65e8e48d0dde15b5ed4c4305

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig/gcc-10/lab-=
collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig/gcc-10/lab-=
collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e8e48d0dde15b5ed4c430e
        failing since 223 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2024-03-06T21:47:53.311107  / # #

    2024-03-06T21:47:53.411577  export SHELL=3D/bin/sh

    2024-03-06T21:47:53.411684  #

    2024-03-06T21:47:53.512190  / # export SHELL=3D/bin/sh. /lava-12965567/=
environment

    2024-03-06T21:47:53.512296  =


    2024-03-06T21:47:53.612781  / # . /lava-12965567/environment/lava-12965=
567/bin/lava-test-runner /lava-12965567/1

    2024-03-06T21:47:53.612949  =


    2024-03-06T21:47:53.624862  / # /lava-12965567/bin/lava-test-runner /la=
va-12965567/1

    2024-03-06T21:47:53.683737  + export 'TESTRUN_ID=3D1_bootrr'

    2024-03-06T21:47:53.683814  + cd /lava-1296556<8>[   18.205698] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12965567_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

