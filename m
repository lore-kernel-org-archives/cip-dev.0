Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC6BC54E49
	for <webhook@archiver.kernel.org>; Fri, 23 Feb 2024 11:36:56 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.web11.8613.1708688210050697213
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 23 Feb 2024 03:36:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=pD4XRO3u;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.42, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-299c11b250fso556977a91.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 23 Feb 2024 03:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1708688209; x=1709293009; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=g/xIX0P+KwaU8Ficfg3sfiyqZt0eolx+vIbplBaOMEM=;
        b=pD4XRO3u9mw+JN/bga7DmJ6qDeguQn1n21Jg+X8PO/5nlev/0i6WfJyPmI01B3Ibzq
         f8LELIpOJmK7bPQUHYwNfed17BGSuSE/gdIxb/JytmnFs7yowROqW4p8eg9Z5AtROds3
         /MoH3JQ2f7RqL3jQR0fRCBNMBAuqrnw2n88p9SWuCj/OjOGvzyhgRv60iPQljDXj4Suk
         +4+dMe8D/w7DqS5uMHMcZTpBvg2ya8c6bi5o+QLrQjz1hXSIUrjuDovFJrIOR5QNZJKX
         gAAgd7LfQ40B3R7MfsT/8ZE8jx9M8DqWxoncWRStodZScsDLHtX4xKXL58cXOCnTpf4U
         Vlgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708688209; x=1709293009;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g/xIX0P+KwaU8Ficfg3sfiyqZt0eolx+vIbplBaOMEM=;
        b=Oko/FLN3zwzTho8+/nUnCF/nKkrT7BBBbciYOwuP/LYbhE9xg25o08X2gHYKVVszdG
         W4W7JR4y+QyD6GDH67LlYEOLZAKtyFVu+/zSTB2SoKAvy6egFUmBeRQoBqsBVIs0nEHB
         FhB2ygQmNxsFCQV2zyYwqSES2sI1mPceFfo2j0OtmvKvqurihOw+iShdyF+oHa7VNNoZ
         mahi09zO6RgqIWt+i8WACjVx2zcJdT7aYoCHXjTTBSNONDKbfBycZb0a28xrhIY5Kr8Y
         k5wrVzeVUe9L4cb2Ew3YbvYtjnvbveMrxt3ePjQGk6/uy3sU8B5HC+7BsejhysTGtvOf
         BHow==
X-Gm-Message-State: AOJu0Yzlw7nJY4BjoWleufWydVXBBQ8RxH7yGBj2dSkSktSysye6nTA6
	UID8NMcp1f9ibabXs2txWppTRfHiMxhprq1xIir9WwLRmo6ViwXTLy4LU76AoVql700+WePA8/Z
	lAX4=
X-Google-Smtp-Source: AGHT+IG8SEuAFIhX61bn6b7Qhf8tVce2vJDllGH84EZYPAI8yD4g/sQCWsz6VmMP/nzStcLDkGOxvw==
X-Received: by 2002:a17:90a:6986:b0:29a:3e34:3473 with SMTP id s6-20020a17090a698600b0029a3e343473mr1173455pjj.46.1708688208972;
        Fri, 23 Feb 2024 03:36:48 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id si4-20020a17090b528400b002963cab9e2asm1255801pjb.2.2024.02.23.03.36.48
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 03:36:48 -0800 (PST)
Message-ID: <65d88350.170a0220.f4ff7.33f8@mx.google.com>
Date: Fri, 23 Feb 2024 03:36:48 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.209-cip44-424-g38943e302f8c8
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 131 runs,
 13 regressions (v5.10.209-cip44-424-g38943e302f8c8)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 23 Feb 2024 11:36:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15068

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 131 runs, 13 regressio=
ns (v5.10.209-cip44-424-g38943e302f8c8)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
at91sam9g20ek            | arm   | lab-broonie   | gcc-10   | at91_dt_defco=
nfig            | 2          =

bcm2836-rpi-2-b          | arm   | lab-collabora | gcc-10   | bcm2835_defco=
nfig            | 1          =

beaglebone-black         | arm   | lab-broonie   | gcc-10   | omap2plus_def=
config          | 1          =

beaglebone-black         | arm   | lab-cip       | gcc-10   | omap2plus_def=
config          | 1          =

r8a7743-iwg20d-q7        | arm   | lab-cip       | gcc-10   | shmobile_defc=
onfig           | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook   | 1          =

r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook   | 1          =

r8a774c0-ek874           | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook   | 1          =

rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
...ok+kselftest | 2          =

rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.209-cip44-424-g38943e302f8c8/plan/baselin=
e/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.209-cip44-424-g38943e302f8c8
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      38943e302f8c8bda23c2853f688afa5e35cae90d =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
at91sam9g20ek            | arm   | lab-broonie   | gcc-10   | at91_dt_defco=
nfig            | 2          =


  Details:     https://kernelci.org/test/plan/id/65d87137cf563c586b637017

  Results:     47 PASS, 6 FAIL, 1 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-424-g38943e302f8c8/arm/at91_dt_defconfig/gcc-1=
0/lab-broonie/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-424-g38943e302f8c8/arm/at91_dt_defconfig/gcc-1=
0/lab-broonie/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/65d87137c=
f563c586b637022
        new failure (last pass: v5.10.205-905-gb40421b142370)

    2024-02-23T10:19:19.052807  /lava-621441/1/../bin/lava-test-case
    2024-02-23T10:19:19.091085  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dsou=
nd-card RESULT=3Dfail>   =


  * baseline.bootrr.audio-card-probed: https://kernelci.org/test/case/id/65=
d87137cf563c586b637023
        new failure (last pass: v5.10.205-905-gb40421b142370)

    2024-02-23T10:19:17.959140  /lava-621441/1/../bin/lava-test-case
    2024-02-23T10:19:17.998281  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Daud=
io-card-probed RESULT=3Dfail>   =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
bcm2836-rpi-2-b          | arm   | lab-collabora | gcc-10   | bcm2835_defco=
nfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/65d8752acad65d8aa563701e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-424-g38943e302f8c8/arm/bcm2835_defconfig/gcc-1=
0/lab-collabora/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-424-g38943e302f8c8/arm/bcm2835_defconfig/gcc-1=
0/lab-collabora/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65d8752acad65d8aa5637023
        failing since 210 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2024-02-23T10:43:42.105832  / # #

    2024-02-23T10:43:42.207896  export SHELL=3D/bin/sh

    2024-02-23T10:43:42.208640  #

    2024-02-23T10:43:42.310044  / # export SHELL=3D/bin/sh. /lava-12837772/=
environment

    2024-02-23T10:43:42.310763  =


    2024-02-23T10:43:42.412192  / # . /lava-12837772/environment/lava-12837=
772/bin/lava-test-runner /lava-12837772/1

    2024-02-23T10:43:42.413226  =


    2024-02-23T10:43:42.430087  / # /lava-12837772/bin/lava-test-runner /la=
va-12837772/1

    2024-02-23T10:43:42.494084  + export 'TESTRUN_ID=3D1_bootrr'

    2024-02-23T10:43:42.538023  + cd /lava-12837772/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
beaglebone-black         | arm   | lab-broonie   | gcc-10   | omap2plus_def=
config          | 1          =


  Details:     https://kernelci.org/test/plan/id/65d87137a5cade2d9d637012

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-424-g38943e302f8c8/arm/omap2plus_defconfig/gcc=
-10/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-424-g38943e302f8c8/arm/omap2plus_defconfig/gcc=
-10/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65d87137a5cade2d9d637048
        failing since 414 days (last pass: v5.10.155-cip21-405-g26d566555c3=
de, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2024-02-23T10:19:17.076232  + set +x
    2024-02-23T10:19:17.085496  <8>[   19.483341] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 621443_1.5.2.4.1>
    2024-02-23T10:19:17.189591  / # #
    2024-02-23T10:19:17.291184  export SHELL=3D/bin/sh
    2024-02-23T10:19:17.291648  #
    2024-02-23T10:19:17.392650  / # export SHELL=3D/bin/sh. /lava-621443/en=
vironment
    2024-02-23T10:19:17.393090  =

    2024-02-23T10:19:17.494307  / # . /lava-621443/environment/lava-621443/=
bin/lava-test-runner /lava-621443/1
    2024-02-23T10:19:17.494921  =

    2024-02-23T10:19:17.499462  / # /lava-621443/bin/lava-test-runner /lava=
-621443/1 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
beaglebone-black         | arm   | lab-cip       | gcc-10   | omap2plus_def=
config          | 1          =


  Details:     https://kernelci.org/test/plan/id/65d871cf32e4bf836f637012

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-424-g38943e302f8c8/arm/omap2plus_defconfig/gcc=
-10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-424-g38943e302f8c8/arm/omap2plus_defconfig/gcc=
-10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65d871cf32e4bf836f637048
        failing since 414 days (last pass: v5.10.155-cip21-405-g26d566555c3=
de, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2024-02-23T10:21:56.557479  <8>[   14.025695] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1097733_1.5.2.4.1>
    2024-02-23T10:21:56.666093  / # #
    2024-02-23T10:21:56.767564  export SHELL=3D/bin/sh
    2024-02-23T10:21:56.768004  #
    2024-02-23T10:21:56.868926  / # export SHELL=3D/bin/sh. /lava-1097733/e=
nvironment
    2024-02-23T10:21:56.869363  =

    2024-02-23T10:21:56.970345  / # . /lava-1097733/environment/lava-109773=
3/bin/lava-test-runner /lava-1097733/1
    2024-02-23T10:21:56.971169  =

    2024-02-23T10:21:56.975331  / # /lava-1097733/bin/lava-test-runner /lav=
a-1097733/1
    2024-02-23T10:21:57.078972  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a7743-iwg20d-q7        | arm   | lab-cip       | gcc-10   | shmobile_defc=
onfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65d87f0fd5984b477363701d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-424-g38943e302f8c8/arm/shmobile_defconfig/gcc-=
10/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-424-g38943e302f8c8/arm/shmobile_defconfig/gcc-=
10/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65d87f0fd5984b4773637=
01e
        failing since 70 days (last pass: v5.10.201-cip41-473-gc43d7b7bbe83=
a, first fail: v5.10.201-cip41-69-g8f7b450fc28ed) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/65d87beffa20268d04637021

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-424-g38943e302f8c8/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-424-g38943e302f8c8/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65d87beffa20268d04637026
        failing since 210 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2024-02-23T11:04:57.360592  + set +x
    2024-02-23T11:04:57.363819  <8>[   83.961830] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1097772_1.5.2.4.1>
    2024-02-23T11:04:57.472850  / # #
    2024-02-23T11:04:58.930477  export SHELL=3D/bin/sh
    2024-02-23T11:04:58.951350  #
    2024-02-23T11:04:58.951776  / # export SHELL=3D/bin/sh
    2024-02-23T11:05:00.901409  / # . /lava-1097772/environment
    2024-02-23T11:05:04.487788  /lava-1097772/bin/lava-test-runner /lava-10=
97772/1
    2024-02-23T11:05:04.509035  . /lava-1097772/environment
    2024-02-23T11:05:04.509404  / # /lava-1097772/bin/lava-test-runner /lav=
a-1097772/1 =

    ... (28 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/65d87c2c21b8d58ce5637031

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-424-g38943e302f8c8/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-424-g38943e302f8c8/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-r8a774b1-hihope-rzg2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65d87c2c21b8d58ce5637036
        failing since 210 days (last pass: v5.10.182-cip35-289-g3c054954070=
6, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2024-02-23T11:06:02.263578  + set +x
    2024-02-23T11:06:02.266892  <8>[   84.197286] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1097775_1.5.2.4.1>
    2024-02-23T11:06:02.375024  / # #
    2024-02-23T11:06:03.833715  export SHELL=3D/bin/sh
    2024-02-23T11:06:03.854631  #
    2024-02-23T11:06:03.855153  / # export SHELL=3D/bin/sh
    2024-02-23T11:06:05.803547  / # . /lava-1097775/environment
    2024-02-23T11:06:09.389077  /lava-1097775/bin/lava-test-runner /lava-10=
97775/1
    2024-02-23T11:06:09.409578  . /lava-1097775/environment
    2024-02-23T11:06:09.409663  / # /lava-1097775/bin/lava-test-runner /lav=
a-1097775/1 =

    ... (15 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a774c0-ek874           | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/65d87de6670bf1224e63701d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-424-g38943e302f8c8/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-424-g38943e302f8c8/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65d87de6670bf1224e637022
        failing since 211 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2024-02-23T11:13:21.028951  / # #
    2024-02-23T11:13:22.486150  export SHELL=3D/bin/sh
    2024-02-23T11:13:22.506827  #
    2024-02-23T11:13:22.507175  / # export SHELL=3D/bin/sh
    2024-02-23T11:13:24.453737  / # . /lava-1097782/environment
    2024-02-23T11:13:28.037609  /lava-1097782/bin/lava-test-runner /lava-10=
97782/1
    2024-02-23T11:13:28.058029  . /lava-1097782/environment
    2024-02-23T11:13:28.058110  / # /lava-1097782/bin/lava-test-runner /lav=
a-1097782/1
    2024-02-23T11:13:28.135962  + export 'TESTRUN_ID=3D1_bootrr'
    2024-02-23T11:13:28.136074  + cd /lava-1097782/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
...ok+kselftest | 2          =


  Details:     https://kernelci.org/test/plan/id/65d8768aed33de372263704a

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-424-g38943e302f8c8/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-424-g38943e302f8c8/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/65d8768aed33de3722637050
        failing since 308 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2024-02-23T10:42:13.021735  <8>[   40.956220] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2024-02-23T10:42:14.082545  /lava-12837854/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/65d8768aed33de3722637051
        failing since 308 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2024-02-23T10:42:11.936362  <8>[   39.869373] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2024-02-23T10:42:12.995231  /lava-12837854/1/../bin/lava-test-case
   =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/65d87b955fc4f2e63b637018

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-424-g38943e302f8c8/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-424-g38943e302f8c8/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/65d87b955fc4f2e63b637020
        failing since 308 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2024-02-23T11:06:29.001916  /lava-12838073/1/../bin/lava-test-case

    2024-02-23T11:06:29.013301  <8>[   35.202509] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/65d87b955fc4f2e63b637021
        failing since 308 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2024-02-23T11:06:26.946847  <8>[   33.134371] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2024-02-23T11:06:27.966714  /lava-12838073/1/../bin/lava-test-case

    2024-02-23T11:06:27.977899  <8>[   34.167407] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =20

