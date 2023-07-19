Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27692C001DE
	for <webhook@archiver.kernel.org>; Wed, 19 Jul 2023 14:22:07 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.web11.15072.1689776523289492681
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 19 Jul 2023 07:22:03 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=QUDS7wZK;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.171, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-666ecf9a0ceso4722411b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 19 Jul 2023 07:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689776522; x=1692368522;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ohr395/0sqPxBRXhmcjO/WvXsolD2+dnl19NKH1fqGk=;
        b=QUDS7wZKxoT3zxR6No5maDm+v5wtj9gaITumM4lV1RHGFlXfK/A7ffGXwAhVk2wpmK
         nB7beCyCDIknNO1V0v90zuNzq4o1m9g42cGbniJR6s9tE/4AfDQIPg7hRS3O+5ArpIEk
         4TY04O6M5HqKp5PQo7wndSIKheBT6n/kyH8XM8hyShrO5rCN+P13i8Gfm/RJV7w+imU5
         r1Z0sRrHMF4cqDM3g9u/K4VU9qpvkERgX8lLXGZ9mvQN9eGVyomb8oLFcXZHoAHMwhVz
         SndNLOS8plwaKM1YptitliBPPtc0FDuhWhkLnOBCCaTDWF8HOWL0WD4f0NY5d0/C3ldP
         HDBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689776522; x=1692368522;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ohr395/0sqPxBRXhmcjO/WvXsolD2+dnl19NKH1fqGk=;
        b=MtJ/1/qH7KML21yFTk2mzvwvaT6uKBA+xBwSrHj7rhhBLnEU75xoD84AvBXnIsOxCj
         1cH3NO8SSHPEsxP9iezt0Oms8dOFeWxb0IRKVcSgJtyqRG5Uy1KqnxKrEIERetp8xBLt
         pmzLsiKCUDnlMYO08/gp2Es30pFStCrYMWLBqLY67SBXdsTBHyOlnAXk9bTVWIItg9SH
         xUTryft7MrZCLuysm+s3El5mmJYuhUV0DcGRNG0+c6yxA/k1WjLP/E0JRTBCZTTmh3O1
         pQs/zyyHhTu+3mWhi3EyYfpL4wwbCByIxLQ5lQtwMpBysPkRwElwMq3XaY5aq8+rZx+3
         52Pw==
X-Gm-Message-State: ABy/qLYWBrceKe8AK4N+B+OqcDucpGBKA/RFecSjZsM10yUUKk53Sv7J
	/eA3vrNGIZo/gyUlIcizBgKs7CBVWEkLOSYsHmp9fQ==
X-Google-Smtp-Source: APBJJlGKCiEqWhtEiHSb9ENawUWPij/vhtdUVkHOcEmS18DvWuGaXRvFkBTF+Ufa/GsuQ1ab0PtJIA==
X-Received: by 2002:a05:6a00:16c4:b0:668:8493:2545 with SMTP id l4-20020a056a0016c400b0066884932545mr21503878pfc.24.1689776521843;
        Wed, 19 Jul 2023 07:22:01 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ff17-20020a056a002f5100b0068285a7f107sm3446857pfb.177.2023.07.19.07.22.00
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 07:22:01 -0700 (PDT)
Message-ID: <64b7f189.050a0220.75295.78c1@mx.google.com>
Date: Wed, 19 Jul 2023 07:22:01 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v5.10.186-cip37-2-gfcd111609480
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 20 runs,
 25 regressions (v5.10.186-cip37-2-gfcd111609480)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Jul 2023 14:22:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12435

cip-gitlab/ci/pavel/linux-test baseline-nfs: 20 runs, 25 regressions (v5.10=
.186-cip37-2-gfcd111609480)

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
s_defconfig          | 2          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 2          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

mt8173-elm-hana              | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.186-cip37-2-gfcd111609480/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.186-cip37-2-gfcd111609480
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      fcd111609480c664a9d1e68c5ec8c352c2312db5 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 7          =


  Details:     https://kernelci.org/test/plan/id/64b7e0b586b034668f8ace23

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm/multi_v7_defconfig/gcc-10/lab-broonie/=
baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm/multi_v7_defconfig/gcc-10/lab-broonie/=
baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.hdmi-audio: https://kernelci.org/test/case/id/64b7e=
0b586b034668f8ace26
        new failure (last pass: v6.1.38-cip1-10-g02aa22be941dd)

    2023-07-19T13:09:50.535693  /lava-1321/1/../bin/lava-test-case
    2023-07-19T13:09:50.585110  [   94.267267] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/i=
d/64b7e0b586b034668f8ace27
        new failure (last pass: v6.1.38-cip1-10-g02aa22be941dd)

    2023-07-19T13:09:49.435566  /lava-1321/1/../bin/lava-test-case
    2023-07-19T13:09:49.491750  [   93.172441] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-codec-driver-present: https://kernelci.org/tes=
t/case/id/64b7e0b586b034668f8ace29
        new failure (last pass: v6.1.38-cip1-10-g02aa22be941dd)

    2023-07-19T13:09:47.129908  /lava-1321/1/../bin/lava-test-case
    2023-07-19T13:09:47.184163  [   90.865013] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-07-19T13:09:48.234841  /lava-1321/1/../bin/lava-test-case
    2023-07-19T13:09:48.293608  [   91.973646] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case=
/id/64b7e0b586b034668f8ace2a
        new failure (last pass: v6.1.38-cip1-10-g02aa22be941dd)

    2023-07-19T13:09:44.924628  /lava-1321/1/../bin/lava-test-case
    2023-07-19T13:09:44.977534  [   88.658073] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-07-19T13:09:46.027098  /lava-1321/1/../bin/lava-test-case
    2023-07-19T13:09:46.081031  [   89.762426] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tda19988-driver-present: https://kernelci.org/test/=
case/id/64b7e0b586b034668f8ace2b
        new failure (last pass: v6.1.38-cip1-10-g02aa22be941dd)

    2023-07-19T13:09:42.715435  /lava-1321/1/../bin/lava-test-case
    2023-07-19T13:09:42.767486  [   86.448118] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-07-19T13:09:43.816151  /lava-1321/1/../bin/lava-test-case
    2023-07-19T13:09:43.878796  [   87.558758] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/64b7e0b586b034668f8ace37
        new failure (last pass: v6.1.38-cip1-10-g02aa22be941dd)

    2023-07-19T13:09:29.572712  /lava-1321/1/../bin/lava-test-case
    2023-07-19T13:09:29.647550  [   73.327584] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64b7e0b586b034668f8ace50
        new failure (last pass: v6.1.38-cip1-10-g02aa22be941dd)

    2023-07-19T13:09:20.025875  + set +x
    2023-07-19T13:09:20.029299  [   63.710451] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1321_1.6.2.4.1>
    2023-07-19T13:09:20.142963  / # #
    2023-07-19T13:09:20.245712  export SHELL=3D/bin/sh
    2023-07-19T13:09:20.246285  #
    2023-07-19T13:09:20.347894  / # export SHELL=3D/bin/sh. /lava-1321/envi=
ronment
    2023-07-19T13:09:20.348438  =

    2023-07-19T13:09:20.450045  / # . /lava-1321/environment/lava-1321/bin/=
lava-test-runner /lava-1321/1
    2023-07-19T13:09:20.450737  =

    2023-07-19T13:09:20.455827  / # /lava-1321/bin/lava-test-runner /lava-1=
321/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 7          =


  Details:     https://kernelci.org/test/plan/id/64b7e21ea60639daaa8ace2a

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm/multi_v7_defconfig/gcc-10/lab-cip/base=
line-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm/multi_v7_defconfig/gcc-10/lab-cip/base=
line-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64b7e21ea60639daaa8ace2d
        new failure (last pass: v6.1.38-cip1-10-g02aa22be941dd)

    2023-07-19T13:15:15.017033  + set +x
    2023-07-19T13:15:15.020065  [   47.675050] <LAVA_SIGNAL_ENDRUN 0_dmesg =
987478_1.6.2.4.1>
    2023-07-19T13:15:15.260061  #
    2023-07-19T13:15:15.363038  / # #export SHELL=3D/bin/sh
    2023-07-19T13:15:15.363742  =

    2023-07-19T13:15:15.465645  / # export SHELL=3D/bin/sh. /lava-987478/en=
vironment
    2023-07-19T13:15:15.466342  =

    2023-07-19T13:15:15.568164  / # . /lava-987478/environment/lava-987478/=
bin/lava-test-runner /lava-987478/1
    2023-07-19T13:15:15.569337  =

    2023-07-19T13:15:15.576600  / # /lava-987478/bin/lava-test-runner /lava=
-987478/1 =

    ... (12 line(s) more)  =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/64b7e21ea60639daaa8ace46
        new failure (last pass: v6.1.38-cip1-10-g02aa22be941dd)

    2023-07-19T13:15:26.462466  /lava-987478/1/../bin/lava-test-case
    2023-07-19T13:15:26.637850  [   59.292018] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tda19988-driver-present: https://kernelci.org/test/=
case/id/64b7e21ea60639daaa8ace52
        new failure (last pass: v6.1.38-cip1-10-g02aa22be941dd)

    2023-07-19T13:15:41.375675  /lava-987478/1/../bin/lava-test-case
    2023-07-19T13:15:41.546838  [   74.201724] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-07-19T13:15:42.607191  /lava-987478/1/../bin/lava-test-case
    2023-07-19T13:15:42.771898  [   75.426881] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case=
/id/64b7e21ea60639daaa8ace53
        new failure (last pass: v6.1.38-cip1-10-g02aa22be941dd)

    2023-07-19T13:15:43.836600  /lava-987478/1/../bin/lava-test-case
    2023-07-19T13:15:44.005548  [   76.660096] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-07-19T13:15:45.066830  /lava-987478/1/../bin/lava-test-case
    2023-07-19T13:15:45.279986  [   77.935397] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-codec-driver-present: https://kernelci.org/tes=
t/case/id/64b7e21ea60639daaa8ace54
        new failure (last pass: v6.1.38-cip1-10-g02aa22be941dd)

    2023-07-19T13:15:46.342760  /lava-987478/1/../bin/lava-test-case
    2023-07-19T13:15:46.505286  [   79.160484] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-07-19T13:15:47.568782  /lava-987478/1/../bin/lava-test-case
    2023-07-19T13:15:47.775893  [   80.431296] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/i=
d/64b7e21ea60639daaa8ace56
        new failure (last pass: v6.1.38-cip1-10-g02aa22be941dd)

    2023-07-19T13:15:49.025447  /lava-987478/1/../bin/lava-test-case
    2023-07-19T13:15:49.205021  [   81.860437] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-audio: https://kernelci.org/test/case/id/64b7e=
21ea60639daaa8ace57
        new failure (last pass: v6.1.38-cip1-10-g02aa22be941dd)

    2023-07-19T13:15:50.266624  /lava-987478/1/../bin/lava-test-case
    2023-07-19T13:15:50.446086  [   83.102157] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 2          =


  Details:     https://kernelci.org/test/plan/id/64b7dfb2387400c2eb8ace28

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm/omap2plus_defconfig/gcc-10/lab-broonie=
/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm/omap2plus_defconfig/gcc-10/lab-broonie=
/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/=
id/64b7dfb2387400c2eb8ace43
        new failure (last pass: v6.1.38-cip1-10-g02aa22be941dd)

    2023-07-19T13:05:31.623937  /lava-1308/1/../bin/lava-test-case
    2023-07-19T13:05:31.690114  <8>[   50.250054] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64b7dfb2387400c2eb8ace5a
        failing since 35 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-07-19T13:05:25.816997  + set +x
    2023-07-19T13:05:25.821233  <8>[   44.381981] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1308_1.6.2.4.1>
    2023-07-19T13:05:25.940738  / # #
    2023-07-19T13:05:26.043215  export SHELL=3D/bin/sh
    2023-07-19T13:05:26.043917  #
    2023-07-19T13:05:26.145551  / # export SHELL=3D/bin/sh. /lava-1308/envi=
ronment
    2023-07-19T13:05:26.146273  =

    2023-07-19T13:05:26.247999  / # . /lava-1308/environment/lava-1308/bin/=
lava-test-runner /lava-1308/1
    2023-07-19T13:05:26.248842  =

    2023-07-19T13:05:26.253895  / # /lava-1308/bin/lava-test-runner /lava-1=
308/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 2          =


  Details:     https://kernelci.org/test/plan/id/64b7e12eda1d3a00538ace20

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm/omap2plus_defconfig/gcc-10/lab-cip/bas=
eline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm/omap2plus_defconfig/gcc-10/lab-cip/bas=
eline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64b7e12eda1d3a00538ace23
        failing since 35 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-07-19T13:11:52.570511  + set +x
    2023-07-19T13:11:52.574797  <8>[   43.432444] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 987447_1.6.2.4.1>
    2023-07-19T13:11:52.853927  #
    2023-07-19T13:11:52.956838  / # #export SHELL=3D/bin/sh
    2023-07-19T13:11:52.957539  =

    2023-07-19T13:11:53.059292  / # export SHELL=3D/bin/sh. /lava-987447/en=
vironment
    2023-07-19T13:11:53.059853  =

    2023-07-19T13:11:53.161493  / # . /lava-987447/environment/lava-987447/=
bin/lava-test-runner /lava-987447/1
    2023-07-19T13:11:53.162516  =

    2023-07-19T13:11:53.169048  / # /lava-987447/bin/lava-test-runner /lava=
-987447/1 =

    ... (12 line(s) more)  =


  * baseline-nfs.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/=
id/64b7e12eda1d3a00538ace3e
        new failure (last pass: v6.1.38-cip1-10-g02aa22be941dd)

    2023-07-19T13:12:01.820926  /lava-987447/1/../bin/lava-test-case
    2023-07-19T13:12:02.045933  <8>[   52.902734] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7e35c6187b94af58ace47

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64b7e35c6187b94af58ace4c
        failing since 35 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-07-19T13:21:22.545043  + [   19.036019] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 11111946_1.5.2.3.1>

    2023-07-19T13:21:22.548013  set +x

    2023-07-19T13:21:22.656228  / # #

    2023-07-19T13:21:22.758539  export SHELL=3D/bin/sh

    2023-07-19T13:21:22.759282  #

    2023-07-19T13:21:22.860842  / # export SHELL=3D/bin/sh. /lava-11111946/=
environment

    2023-07-19T13:21:22.861573  =


    2023-07-19T13:21:22.963060  / # . /lava-11111946/environment/lava-11111=
946/bin/lava-test-runner /lava-11111946/1

    2023-07-19T13:21:22.964185  =


    2023-07-19T13:21:22.969263  / # /lava-11111946/bin/lava-test-runner /la=
va-11111946/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7e10186b034668f8ace85

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64b7e10186b034668f8ace8a
        failing since 35 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-07-19T13:11:17.752732  + set +x[   18.546198] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11111928_1.5.2.3.1>

    2023-07-19T13:11:17.756266  =


    2023-07-19T13:11:17.857785  =


    2023-07-19T13:11:17.958508  / # #export SHELL=3D/bin/sh

    2023-07-19T13:11:17.958639  =


    2023-07-19T13:11:18.059136  / # export SHELL=3D/bin/sh. /lava-11111928/=
environment

    2023-07-19T13:11:18.059312  =


    2023-07-19T13:11:18.159799  / # . /lava-11111928/environment/lava-11111=
928/bin/lava-test-runner /lava-11111928/1

    2023-07-19T13:11:18.160050  =


    2023-07-19T13:11:18.164943  / # /lava-11111928/bin/lava-test-runner /la=
va-11111928/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7e8ed3e72c291f18ace1e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm/multi_v7_defconfig/gcc-10/lab-broonie/=
baseline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm/multi_v7_defconfig/gcc-10/lab-broonie/=
baseline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64b7e8ed3e72c291f=
18ace1f
        new failure (last pass: v6.1.38-cip1-10-g02aa22be941dd) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7eb4dd6bc2a291b8acf55

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm64/defconfig+arm64-chromebook/gcc-10/la=
b-collabora/baseline-nfs-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm64/defconfig+arm64-chromebook/gcc-10/la=
b-collabora/baseline-nfs-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64b7eb4dd6bc2a291=
b8acf56
        failing since 35 days (last pass: v6.1.26-1320-g1ddf4b637f785, firs=
t fail: v5.10.182-cip35-8-g2391124f19a70) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7ec06e846819e5c8ace2b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm64/defconfig+arm64-chromebook/gcc-10/la=
b-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm64/defconfig+arm64-chromebook/gcc-10/la=
b-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64b7ec06e846819e5=
c8ace2c
        new failure (last pass: v5.10.184-cip36-13-g8201543bbc8b6) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64b7eb75d6bc2a291b8acf7e

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm64/defconfig+arm64-chromebook/gcc-10/la=
b-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm64/defconfig+arm64-chromebook/gcc-10/la=
b-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/64b7eb75d6bc2a291b8acf81
        failing since 35 days (last pass: v6.1.26-1320-g1ddf4b637f785, firs=
t fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-07-19T13:55:49.354664  [   97.326493] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-07-19T13:55:50.406583  /lava-11112186/1/../bin/lava-test-case

    2023-07-19T13:55:50.438084  [   98.410928] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/64b7eb75d6bc2a291b8acfb3
        failing since 35 days (last pass: v6.1.26-1320-g1ddf4b637f785, firs=
t fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-07-19T13:55:51.485397  /lava-11112186/1/../bin/lava-test-case

    2023-07-19T13:55:51.513885  [   99.486230] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =

 =20

