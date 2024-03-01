Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4F4C5478C
	for <webhook@archiver.kernel.org>; Fri,  1 Mar 2024 20:43:36 +0000 (UTC)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
 by mx.groups.io with SMTP id smtpd.web11.35015.1709325811959161500
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 01 Mar 2024 12:43:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=0F+xicDD;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.167.181, mailfrom: bot@kernelci.org)
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c19aaedfdaso1308655b6e.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 01 Mar 2024 12:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709325811; x=1709930611; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iZ9VcOrRtXfb+le7dQlCkQ3KO6IkRFQqzJ55i/Qxm0k=;
        b=0F+xicDDHqVvBMRIriMUfN2gOqU7c5uKQxisuU5AbqN9fbFLYpYkt3O++/dWz7VJHt
         5yQ2bB9EkPFxc85CEFVVfSUfMEC2QhHJtOALxWElFyofz2GXNzKeu1Z8JyyxRykSiI7F
         l9WTYBTbH5Rhfru1LMD86V/IFfciz2Qxkpg+fVLmCk8vtog3/EKzIpsirpWPzpIq4WOn
         45kH/TL9orrBgLDe+MAaew3zC79IiMPNgEOePeuNBkp/bMWIY5977OB/71P2/em1wsGg
         dsMlLJ4HWdWOhzJM9kg/hsnOmrWltwLD/VYJspEm8/Z2ehagRCIxwKwLRCaOkM4YBf1o
         dcGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709325811; x=1709930611;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iZ9VcOrRtXfb+le7dQlCkQ3KO6IkRFQqzJ55i/Qxm0k=;
        b=tCUDTyBZJvb3PNrN+NqjEgHupkhlOkEpX5AMzuuzHyB5t3HcIXTttbgoeu6dxmjmu/
         aMtePWxgTAtRctonCtHj/uCnt2+wuIF99zc5nuNC8jn8bqeuwWRJe9d8q7BtJX1RPkJ2
         82ArJwY0GkqmEPkGHkYr711wDVEVQ0VVAi03Uy6oomsWD5AIqRvN8acmQxcbow2+OhLT
         8GLaOp0GAC7TNAjCt/cceQF3G9eNgvt2CdKopt++pIV9Ca7nhb9svbbONf/zWjMy315K
         uLuYOMu/q6M3Rvy0hHvb8HvZL1FY5jAOAOGJW145RuMcx1+omiXH1uD12YJT5vqCcAXu
         cDqQ==
X-Gm-Message-State: AOJu0Yx7yvODfISnHuC685V6rmTkdQKpnblNqRL53JMfDnCS46NUX5Cb
	BN+AHxKmjxSpe5t5Avb6D6MCTFu39Mt8tpFqWGe2RyiIC7DJigwlprDMLNLxKEulm17PPiBqrKe
	1e54=
X-Google-Smtp-Source: AGHT+IFYzvBBXIlttepWplVa8S7x4o1JNXoZXQ2qHxvhs/qULpNXU7AmmMuPxhUDtk6vmWDmSfzoUA==
X-Received: by 2002:a05:6808:2e89:b0:3c1:5c1d:f567 with SMTP id gt9-20020a0568082e8900b003c15c1df567mr3757625oib.37.1709325810512;
        Fri, 01 Mar 2024 12:43:30 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id q20-20020a638c54000000b005dcaa45d87esm3466467pgn.42.2024.03.01.12.43.29
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 12:43:30 -0800 (PST)
Message-ID: <65e23df2.630a0220.98cb4.141b@mx.google.com>
Date: Fri, 01 Mar 2024 12:43:30 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.209-cip44-552-gc0460fb20fc00
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 109 runs,
 13 regressions (v5.10.209-cip44-552-gc0460fb20fc00)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 01 Mar 2024 20:43:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15138

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 109 runs, 13 regressio=
ns (v5.10.209-cip44-552-gc0460fb20fc00)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C436FA-Flip-hatch   | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board   | 1          =

at91sam9g20ek            | arm    | lab-broonie   | gcc-10   | at91_dt_defc=
onfig            | 2          =

bcm2836-rpi-2-b          | arm    | lab-collabora | gcc-10   | bcm2835_defc=
onfig            | 1          =

beaglebone-black         | arm    | lab-broonie   | gcc-10   | omap2plus_de=
fconfig          | 1          =

r8a7743-iwg20d-q7        | arm    | lab-cip       | gcc-10   | shmobile_def=
config           | 1          =

r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig+ar=
m64-chromebook   | 1          =

r8a774b1-hihope-rzg2n-ex | arm64  | lab-cip       | gcc-10   | defconfig+ar=
m64-chromebook   | 1          =

r8a774c0-ek874           | arm64  | lab-cip       | gcc-10   | defconfig+ar=
m64-chromebook   | 1          =

rk3399-gru-kevin         | arm64  | lab-collabora | gcc-10   | defconfig+ar=
m...ok+kselftest | 2          =

rk3399-gru-kevin         | arm64  | lab-collabora | gcc-10   | defconfig+ar=
m64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.209-cip44-552-gc0460fb20fc00/plan/baselin=
e/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.209-cip44-552-gc0460fb20fc00
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c0460fb20fc000a52548daa693788068d4fc9a8e =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C436FA-Flip-hatch   | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board   | 1          =


  Details:     https://kernelci.org/test/plan/id/65e233bc41fe2397c7637045

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-552-gc0460fb20fc00/x86_64/x86_64_defconfig+x86=
-board/gcc-10/lab-collabora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-552-gc0460fb20fc00/x86_64/x86_64_defconfig+x86=
-board/gcc-10/lab-collabora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65e233bc41fe2397c7637=
046
        new failure (last pass: v5.10.209-cip44-56-g55117716ac0fd) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
at91sam9g20ek            | arm    | lab-broonie   | gcc-10   | at91_dt_defc=
onfig            | 2          =


  Details:     https://kernelci.org/test/plan/id/65e22dc3687342c7c4637017

  Results:     47 PASS, 6 FAIL, 1 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-552-gc0460fb20fc00/arm/at91_dt_defconfig/gcc-1=
0/lab-broonie/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-552-gc0460fb20fc00/arm/at91_dt_defconfig/gcc-1=
0/lab-broonie/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/65e22dc36=
87342c7c4637022
        failing since 7 days (last pass: v5.10.205-905-gb40421b142370, firs=
t fail: v5.10.209-cip44-424-g38943e302f8c8)

    2024-03-01T19:34:07.510079  /lava-651506/1/../bin/lava-test-case
    2024-03-01T19:34:07.548743  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dsou=
nd-card RESULT=3Dfail>   =


  * baseline.bootrr.audio-card-probed: https://kernelci.org/test/case/id/65=
e22dc3687342c7c4637023
        failing since 7 days (last pass: v5.10.205-905-gb40421b142370, firs=
t fail: v5.10.209-cip44-424-g38943e302f8c8)

    2024-03-01T19:34:06.416295  /lava-651506/1/../bin/lava-test-case
    2024-03-01T19:34:06.454809  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Daud=
io-card-probed RESULT=3Dfail>   =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
bcm2836-rpi-2-b          | arm    | lab-collabora | gcc-10   | bcm2835_defc=
onfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/65e22a45a8e707cbf9637025

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-552-gc0460fb20fc00/arm/bcm2835_defconfig/gcc-1=
0/lab-collabora/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-552-gc0460fb20fc00/arm/bcm2835_defconfig/gcc-1=
0/lab-collabora/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e22a45a8e707cbf963702a
        failing since 218 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2024-03-01T19:30:10.928967  / # #

    2024-03-01T19:30:11.030938  export SHELL=3D/bin/sh

    2024-03-01T19:30:11.031622  #

    2024-03-01T19:30:11.132934  / # export SHELL=3D/bin/sh. /lava-12909805/=
environment

    2024-03-01T19:30:11.133646  =


    2024-03-01T19:30:11.235116  / # . /lava-12909805/environment/lava-12909=
805/bin/lava-test-runner /lava-12909805/1

    2024-03-01T19:30:11.236194  =


    2024-03-01T19:30:11.253235  / # /lava-12909805/bin/lava-test-runner /la=
va-12909805/1

    2024-03-01T19:30:11.317148  + export 'TESTRUN_ID=3D1_bootrr'

    2024-03-01T19:30:11.361196  + cd /lava-12909805/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
beaglebone-black         | arm    | lab-broonie   | gcc-10   | omap2plus_de=
fconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/65e2347fa21698ecb463701f

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-552-gc0460fb20fc00/arm/omap2plus_defconfig/gcc=
-10/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-552-gc0460fb20fc00/arm/omap2plus_defconfig/gcc=
-10/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e2347fa21698ecb4637055
        failing since 422 days (last pass: v5.10.155-cip21-405-g26d566555c3=
de, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2024-03-01T20:02:58.275609  <8>[   19.861891] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 651562_1.5.2.4.1>
    2024-03-01T20:02:58.383890  / # #
    2024-03-01T20:02:58.485306  export SHELL=3D/bin/sh
    2024-03-01T20:02:58.485604  #
    2024-03-01T20:02:58.586879  / # export SHELL=3D/bin/sh. /lava-651562/en=
vironment
    2024-03-01T20:02:58.587178  =

    2024-03-01T20:02:58.688469  / # . /lava-651562/environment/lava-651562/=
bin/lava-test-runner /lava-651562/1
    2024-03-01T20:02:58.688977  =

    2024-03-01T20:02:58.693393  / # /lava-651562/bin/lava-test-runner /lava=
-651562/1
    2024-03-01T20:02:58.794564  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
r8a7743-iwg20d-q7        | arm    | lab-cip       | gcc-10   | shmobile_def=
config           | 1          =


  Details:     https://kernelci.org/test/plan/id/65e22f39660caa8dfc637025

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-552-gc0460fb20fc00/arm/shmobile_defconfig/gcc-=
10/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-552-gc0460fb20fc00/arm/shmobile_defconfig/gcc-=
10/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65e22f39660caa8dfc637=
026
        failing since 78 days (last pass: v5.10.201-cip41-473-gc43d7b7bbe83=
a, first fail: v5.10.201-cip41-69-g8f7b450fc28ed) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig+ar=
m64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/65e238e2293ccdd719637019

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-552-gc0460fb20fc00/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-552-gc0460fb20fc00/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e238e2293ccdd71963701e
        failing since 218 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2024-03-01T20:21:29.814472  + set +x
    2024-03-01T20:21:29.817737  <8>[   84.012167] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1101393_1.5.2.4.1>
    2024-03-01T20:21:29.926016  / # #
    2024-03-01T20:21:31.384572  export SHELL=3D/bin/sh
    2024-03-01T20:21:31.405291  #
    2024-03-01T20:21:31.405706  / # export SHELL=3D/bin/sh
    2024-03-01T20:21:33.355571  / # . /lava-1101393/environment
    2024-03-01T20:21:36.942923  /lava-1101393/bin/lava-test-runner /lava-11=
01393/1
    2024-03-01T20:21:36.964146  . /lava-1101393/environment
    2024-03-01T20:21:36.964510  / # /lava-1101393/bin/lava-test-runner /lav=
a-1101393/1 =

    ... (28 line(s) more)  =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
r8a774b1-hihope-rzg2n-ex | arm64  | lab-cip       | gcc-10   | defconfig+ar=
m64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/65e237e51cdde74368637025

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-552-gc0460fb20fc00/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-552-gc0460fb20fc00/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-r8a774b1-hihope-rzg2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e237e51cdde7436863702a
        failing since 218 days (last pass: v5.10.182-cip35-289-g3c054954070=
6, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2024-03-01T20:17:19.441414  + set +x
    2024-03-01T20:17:19.443663  <8>[   84.234400] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1101387_1.5.2.4.1>
    2024-03-01T20:17:19.553784  / # #
    2024-03-01T20:17:21.011074  export SHELL=3D/bin/sh
    2024-03-01T20:17:21.031854  #
    2024-03-01T20:17:21.032263  / # export SHELL=3D/bin/sh
    2024-03-01T20:17:22.980724  / # . /lava-1101387/environment
    2024-03-01T20:17:26.572379  /lava-1101387/bin/lava-test-runner /lava-11=
01387/1
    2024-03-01T20:17:26.593854  . /lava-1101387/environment
    2024-03-01T20:17:26.594229  / # /lava-1101387/bin/lava-test-runner /lav=
a-1101387/1 =

    ... (15 line(s) more)  =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
r8a774c0-ek874           | arm64  | lab-cip       | gcc-10   | defconfig+ar=
m64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/65e237f9543858ecca63701b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-552-gc0460fb20fc00/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-552-gc0460fb20fc00/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e237f9543858ecca637020
        failing since 218 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2024-03-01T20:17:42.866212  / # #
    2024-03-01T20:17:44.326791  export SHELL=3D/bin/sh
    2024-03-01T20:17:44.347849  #
    2024-03-01T20:17:44.348393  / # export SHELL=3D/bin/sh
    2024-03-01T20:17:46.300562  / # . /lava-1101394/environment
    2024-03-01T20:17:49.892343  /lava-1101394/bin/lava-test-runner /lava-11=
01394/1
    2024-03-01T20:17:49.913931  . /lava-1101394/environment
    2024-03-01T20:17:49.914316  / # /lava-1101394/bin/lava-test-runner /lav=
a-1101394/1
    2024-03-01T20:17:49.950185  + export 'TESTRUN_ID=3D1_bootrr'
    2024-03-01T20:17:49.995271  + cd /lava-1101394/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
rk3399-gru-kevin         | arm64  | lab-collabora | gcc-10   | defconfig+ar=
m...ok+kselftest | 2          =


  Details:     https://kernelci.org/test/plan/id/65e235aabd9c92a6cc637012

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-552-gc0460fb20fc00/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-552-gc0460fb20fc00/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/65e235aabd9c92a6cc637018
        failing since 316 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2024-03-01T20:08:00.297104  <8>[   69.576531] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2024-03-01T20:08:01.369932  /lava-12909995/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/65e235aabd9c92a6cc637019
        failing since 316 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2024-03-01T20:08:00.272092  /lava-12909995/1/../bin/lava-test-case
   =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
rk3399-gru-kevin         | arm64  | lab-collabora | gcc-10   | defconfig+ar=
m64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/65e23765ec0e2e5209637041

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-552-gc0460fb20fc00/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-552-gc0460fb20fc00/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/65e23766ec0e2e5209637047
        failing since 316 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2024-03-01T20:18:06.522492  /lava-12910043/1/../bin/lava-test-case

    2024-03-01T20:18:06.533852  <8>[   34.924159] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/65e23766ec0e2e5209637048
        failing since 316 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2024-03-01T20:18:05.486347  /lava-12910043/1/../bin/lava-test-case

    2024-03-01T20:18:05.497390  <8>[   33.887450] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =20

