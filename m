Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75897C001B0
	for <webhook@archiver.kernel.org>; Wed, 16 Aug 2023 13:51:39 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web11.161036.1692193891101626741
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 16 Aug 2023 06:51:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=3BLMEUOg;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.177, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1bdb7b0c8afso30173715ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 16 Aug 2023 06:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692193890; x=1692798690;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WkikKj+MVy7tbM4XYm9nfmkE6XohRe6GC0m9mH25fX8=;
        b=3BLMEUOgmt5TLGpKe9hOFj0gxxE/QUXyzZvlzHpFKJ9P/1qoqGkxvqFqb87zg1t0qX
         fWXs7tgY5Ct/zcbFfTrA/UQ62AaRdNU9l9loaoQ3P2jBn07aPDndlU3zoRCWFZYNPZg5
         ojBc+ic2qAT7nD6EtYogVpx7CB5Fsn1nwWVltnOw3NYwDh6KT59OS1E1frw6ayoztA4a
         JnieW+Y/NhVhX2HTT43FUnMyES4yX8G3CBQA7UxpMyxArGEGOyXAdfRZr+LF0Yd5LwZF
         wwPSWGQgGPrlbfCDwH0U4yYREcKaxrXJp09rkBGWNaqkTA5nrCIXyV3NwYuCbbHMGe34
         UopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692193890; x=1692798690;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WkikKj+MVy7tbM4XYm9nfmkE6XohRe6GC0m9mH25fX8=;
        b=jv7TttY/unEmNL4p72OE9KXnmfgcli/kkMUEicJo/PH7JthCzf1MQHCix1QapWpe8b
         ZDZzf/vzRY79eZ/qWBGXvkKP3shzQ2HZAhWi/7nOgIQiJ3Op7y1/JTDmokI1eHNC44A5
         MbGycLmHagsWeaMkETNffnraTa31L16jSelFN7s/9QevjLxG1F4r6Jy4HujwnBuzjnsP
         TWvVbrb7+rXYc7T5JlAUJjuBlaTDaZLfWWCHLYjeqsqgbzSqZ2MFZjyY8RfNw3ov9XYU
         SdiBCGamwamMatBdtkyKYC0rCc1wn8HqLS2FW4FI5DMNb6u6a2CfQVo7+diGYMF2lHC8
         nKNg==
X-Gm-Message-State: AOJu0YwnU/doYZWgWZ0iVYJEvRcL4K7Ji+TxCRhHHQJphcwHEDHlG5OG
	YO52wKSx3Dm0HSEmHAiMA9XC783Qj0lpNSFhGrqC8w==
X-Google-Smtp-Source: AGHT+IHKuvMlXVz7VWjczNVMPnZEbZocVqapXmqb1NfdBMUj4sXik2bSGtYdwoP2OtuKGC0tWbH2Og==
X-Received: by 2002:a17:902:c18b:b0:1b8:b433:7fa with SMTP id d11-20020a170902c18b00b001b8b43307famr1835540pld.13.1692193889560;
        Wed, 16 Aug 2023 06:51:29 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c20d00b001bbb8d5166bsm13167068pll.123.2023.08.16.06.51.28
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 06:51:28 -0700 (PDT)
Message-ID: <64dcd460.170a0220.aa29a.8be0@mx.google.com>
Date: Wed, 16 Aug 2023 06:51:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.186-cip37-16-gf8567732a40d
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 23 runs,
 24 regressions (v5.10.186-cip37-16-gf8567732a40d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Aug 2023 13:51:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12678

cip-gitlab/ci/pavel/linux-test baseline-nfs: 23 runs, 24 regressions (v5.10=
.186-cip37-16-gf8567732a40d)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 7          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 7          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | imx_v6_v=
7_defconfig          | 1          =

imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

mt8173-elm-hana              | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.186-cip37-16-gf8567732a40d/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.186-cip37-16-gf8567732a40d
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      f8567732a40de26cd92366e14e0f9857935fd92d =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 7          =


  Details:     https://kernelci.org/test/plan/id/64dccb2b6291afe52a35b1ec

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm/multi_v7_defconfig/gcc-10/lab-broonie=
/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm/multi_v7_defconfig/gcc-10/lab-broonie=
/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.hdmi-audio: https://kernelci.org/test/case/id/64dcc=
b2b6291afe52a35b1ef
        failing since 26 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-16T13:12:03.368604  /lava-56871/1/../bin/lava-test-case
    2023-08-16T13:12:03.428571  <8>[   81.231790] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/i=
d/64dccb2b6291afe52a35b1f0
        failing since 26 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-16T13:12:02.247606  /lava-56871/1/../bin/lava-test-case
    2023-08-16T13:12:02.313033  <8>[   80.115357] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-codec-driver-present: https://kernelci.org/tes=
t/case/id/64dccb2b6291afe52a35b1f2
        failing since 26 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-16T13:11:59.817327  /lava-56871/1/../bin/lava-test-case
    2023-08-16T13:11:59.901552  <8>[   77.703985] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-08-16T13:12:00.960310  /lava-56871/1/../bin/lava-test-case
    2023-08-16T13:12:01.055047  <8>[   78.857524] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case=
/id/64dccb2b6291afe52a35b1f3
        failing since 26 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-16T13:11:57.350025  /lava-56871/1/../bin/lava-test-case
    2023-08-16T13:11:57.439309  <8>[   75.241794] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-08-16T13:11:58.493204  /lava-56871/1/../bin/lava-test-case
    2023-08-16T13:11:58.757240  <8>[   76.559226] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tda19988-driver-present: https://kernelci.org/test/=
case/id/64dccb2b6291afe52a35b1f4
        failing since 26 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-16T13:11:54.869177  /lava-56871/1/../bin/lava-test-case
    2023-08-16T13:11:55.074147  <8>[   72.876640] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-08-16T13:11:56.134581  /lava-56871/1/../bin/lava-test-case
    2023-08-16T13:11:56.292200  <8>[   74.094169] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/64dccb2b6291afe52a35b200
        failing since 26 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-16T13:11:41.050989  /lava-56871/1/../bin/lava-test-case
    2023-08-16T13:11:41.122100  <8>[   58.923621] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64dccb2b6291afe52a35b219
        failing since 26 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-16T13:11:33.008840  <8>[   50.812645] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 56871_1.6.2.4.1>
    2023-08-16T13:11:33.132801  / # #
    2023-08-16T13:11:33.235398  export SHELL=3D/bin/sh
    2023-08-16T13:11:33.236203  #
    2023-08-16T13:11:33.338320  / # export SHELL=3D/bin/sh. /lava-56871/env=
ironment
    2023-08-16T13:11:33.339110  =

    2023-08-16T13:11:33.441487  / # . /lava-56871/environment/lava-56871/bi=
n/lava-test-runner /lava-56871/1
    2023-08-16T13:11:33.442659  =

    2023-08-16T13:11:33.447026  / # /lava-56871/bin/lava-test-runner /lava-=
56871/1
    2023-08-16T13:11:33.682765  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 7          =


  Details:     https://kernelci.org/test/plan/id/64dccc5c2d4e7c012935b209

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm/multi_v7_defconfig/gcc-10/lab-cip/bas=
eline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm/multi_v7_defconfig/gcc-10/lab-cip/bas=
eline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64dccc5c2d4e7c012935b20c
        failing since 26 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-16T13:16:38.329899  / # #
    2023-08-16T13:16:38.433307  export SHELL=3D/bin/sh
    2023-08-16T13:16:38.434396  #
    2023-08-16T13:16:38.536922  / # export SHELL=3D/bin/sh. /lava-997880/en=
vironment
    2023-08-16T13:16:38.538094  =

    2023-08-16T13:16:38.640542  / # . /lava-997880/environment/lava-997880/=
bin/lava-test-runner /lava-997880/1
    2023-08-16T13:16:38.642396  =

    2023-08-16T13:16:38.656475  / # /lava-997880/bin/lava-test-runner /lava=
-997880/1
    2023-08-16T13:16:38.933013  + export TESTRUN_ID=3D1_bootrr
    2023-08-16T13:16:38.933730  + cd /lava-997880/1/tests/1_bootrr =

    ... (10 line(s) more)  =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/64dccc5c2d4e7c012935b225
        failing since 26 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-16T13:16:46.364631  /lava-997880/1/../bin/lava-test-case
    2023-08-16T13:16:46.439314  <8>[   52.617252] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tda19988-driver-present: https://kernelci.org/test/=
case/id/64dccc5c2d4e7c012935b231
        failing since 26 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-16T13:16:59.562510  /lava-997880/1/../bin/lava-test-case
    2023-08-16T13:16:59.654318  <8>[   65.833004] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-08-16T13:17:00.709115  /lava-997880/1/../bin/lava-test-case
    2023-08-16T13:17:00.786957  <8>[   66.965826] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case=
/id/64dccc5c2d4e7c012935b232
        failing since 26 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-16T13:17:01.842150  /lava-997880/1/../bin/lava-test-case
    2023-08-16T13:17:01.915810  <8>[   68.094485] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-08-16T13:17:02.970678  /lava-997880/1/../bin/lava-test-case
    2023-08-16T13:17:03.050699  <8>[   69.231113] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-codec-driver-present: https://kernelci.org/tes=
t/case/id/64dccc5c2d4e7c012935b233
        failing since 26 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-16T13:17:03.450304  <6>[   69.638856] platform sound: deferred =
probe pending
    2023-08-16T13:17:04.120855  /lava-997880/1/../bin/lava-test-case
    2023-08-16T13:17:04.201281  <8>[   70.381595] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-08-16T13:17:05.272134  /lava-997880/1/../bin/lava-test-case
    2023-08-16T13:17:05.346033  <8>[   71.524997] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/i=
d/64dccc5c2d4e7c012935b235
        failing since 26 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-16T13:17:06.539675  /lava-997880/1/../bin/lava-test-case
    2023-08-16T13:17:06.615352  <8>[   72.794277] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-audio: https://kernelci.org/test/case/id/64dcc=
c5c2d4e7c012935b236
        failing since 26 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-16T13:17:07.670201  /lava-997880/1/../bin/lava-test-case
    2023-08-16T13:17:07.755211  <8>[   73.934331] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64dccab8bb9429bd8935b22c

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm/omap2plus_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm/omap2plus_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64dccab8bb9429bd8935b262
        new failure (last pass: v4.19.288-cip101-1117-g1f3468542aa9e)

    2023-08-16T13:09:53.938441  <8>[   46.816887] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 56854_1.6.2.4.1>
    2023-08-16T13:09:54.067589  / # #
    2023-08-16T13:09:54.169268  export SHELL=3D/bin/sh
    2023-08-16T13:09:54.169694  #
    2023-08-16T13:09:54.271021  / # export SHELL=3D/bin/sh. /lava-56854/env=
ironment
    2023-08-16T13:09:54.271496  =

    2023-08-16T13:09:54.372834  / # . /lava-56854/environment/lava-56854/bi=
n/lava-test-runner /lava-56854/1
    2023-08-16T13:09:54.373529  =

    2023-08-16T13:09:54.377852  / # /lava-56854/bin/lava-test-runner /lava-=
56854/1
    2023-08-16T13:09:54.623169  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64dccab6bb9429bd8935b1ec

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm/omap2plus_defconfig/gcc-10/lab-cip/ba=
seline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm/omap2plus_defconfig/gcc-10/lab-cip/ba=
seline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64dccab6bb9429bd8935b1ef
        new failure (last pass: v4.19.288-cip101-1117-g1f3468542aa9e)

    2023-08-16T13:09:55.405824  + set +x
    2023-08-16T13:09:55.407875  <8>[   39.514065] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 997875_1.6.2.4.1>
    2023-08-16T13:09:55.523963  #
    2023-08-16T13:09:55.626086  / # #export SHELL=3D/bin/sh
    2023-08-16T13:09:55.626667  =

    2023-08-16T13:09:55.728095  / # export SHELL=3D/bin/sh. /lava-997875/en=
vironment
    2023-08-16T13:09:55.728695  =

    2023-08-16T13:09:55.830097  / # . /lava-997875/environment/lava-997875/=
bin/lava-test-runner /lava-997875/1
    2023-08-16T13:09:55.830835  =

    2023-08-16T13:09:55.833002  / # /lava-997875/bin/lava-test-runner /lava=
-997875/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dccba69d08f531a035b1f5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64dccba69d08f531a035b1fa
        new failure (last pass: v4.19.288-cip101-1117-g1f3468542aa9e)

    2023-08-16T13:14:00.101856  + <8>[   17.791008] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11299416_1.5.2.3.1>

    2023-08-16T13:14:00.101941  set +x

    2023-08-16T13:14:00.206151  / # #

    2023-08-16T13:14:00.306723  export SHELL=3D/bin/sh

    2023-08-16T13:14:00.306900  #

    2023-08-16T13:14:00.407454  / # export SHELL=3D/bin/sh. /lava-11299416/=
environment

    2023-08-16T13:14:00.407623  =


    2023-08-16T13:14:00.508149  / # . /lava-11299416/environment/lava-11299=
416/bin/lava-test-runner /lava-11299416/1

    2023-08-16T13:14:00.508391  =


    2023-08-16T13:14:00.512896  / # /lava-11299416/bin/lava-test-runner /la=
va-11299416/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | imx_v6_v=
7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64dcd16b30d554361b35b1db

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm/imx_v6_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm/imx_v6_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64dcd16b30d554361=
b35b1dc
        new failure (last pass: v4.19.288-cip101-1117-g1f3468542aa9e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64dccd4a6a6dd5d3f235b24a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm/multi_v7_defconfig/gcc-10/lab-broonie=
/baseline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm/multi_v7_defconfig/gcc-10/lab-broonie=
/baseline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64dccd4a6a6dd5d3f=
235b24b
        new failure (last pass: v4.19.288-cip101-1117-g1f3468542aa9e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64dccd0d9e794e0f6035b1da

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm64/defconfig/gcc-10/lab-broonie/baseli=
ne-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm64/defconfig/gcc-10/lab-broonie/baseli=
ne-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64dccd0d9e794e0f6=
035b1db
        failing since 27 days (last pass: v6.1.31-65-geef5a19d48f6, first f=
ail: v5.10.186-cip37-2-gfcd111609480) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64dccda0b242f337f635b1f5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/baseline-nfs-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/baseline-nfs-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64dccda0b242f337f=
635b1f6
        failing since 63 days (last pass: v6.1.26-1320-g1ddf4b637f785, firs=
t fail: v5.10.182-cip35-8-g2391124f19a70) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64dccc5c2d4e7c012935b23c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm64/defconfig/gcc-10/lab-cip/baseline-n=
fs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm64/defconfig/gcc-10/lab-cip/baseline-n=
fs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64dccc5c2d4e7c012=
935b23d
        new failure (last pass: v4.19.288-cip101-1117-g1f3468542aa9e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64dccdb25e3640f7e935b1ef

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/64dccdb25e3640f7e935b1f5
        failing since 63 days (last pass: v6.1.26-1320-g1ddf4b637f785, firs=
t fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-08-16T13:23:43.723946  /lava-11299475/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/64dccdb25e3640f7e935b1f6
        failing since 63 days (last pass: v6.1.26-1320-g1ddf4b637f785, firs=
t fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-08-16T13:23:42.623753  /lava-11299475/1/../bin/lava-test-case

    2023-08-16T13:23:42.666997  <8>[   37.300587] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =20

