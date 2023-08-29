Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2751CC71153
	for <webhook@archiver.kernel.org>; Tue, 29 Aug 2023 23:58:09 +0000 (UTC)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
 by mx.groups.io with SMTP id smtpd.web11.2750.1693353483124351012
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 29 Aug 2023 16:58:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=XvvVwO+Z;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.167.181, mailfrom: bot@kernelci.org)
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3a7ca8720a0so3466522b6e.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 29 Aug 2023 16:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1693353482; x=1693958282; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pbSrMfuPrZmeHiKHA1eoS8k10iqgK8yFi1GFx47ZvIA=;
        b=XvvVwO+Z9JYf/Co8HooIbhF2KB5XzFhFpepbkNGT+msyjkXQ4lD/TrybMpxWdw2Wvy
         8eI6isked6QmbYgcGzQe0/3LQAd/k7q9prwV4E1bmQs5SrKGkvZdcD1xDmFts285mCH1
         X5WXAqmKC+ucLwNTCPLZDiMX08MvTapyj11z2GHyLGWXrQiqRBRZGXLupBeJgIjGAeIv
         TpwnUvDTnF1TcEBpaSsLbybA3WZ7/5ihtorhtyA3PGWCorSdS0vyfB1c1oOCuvYt834Q
         vATkyka3f0RUCNwXu/sEYatV4/H0Zyd0IC8KFNkqOEJUe0zBqORfdrpoUNOHvh8pIUl+
         AC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693353482; x=1693958282;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pbSrMfuPrZmeHiKHA1eoS8k10iqgK8yFi1GFx47ZvIA=;
        b=eMJzAw/Teu2IvME2aunuvxvdQQ7HrFO2IosQw6SIB4pr3QnlnXjrY7UWN1CudOGUMQ
         F/zOw+aWcRFvTudc3/tQt6eODr1ySwKDQG9evSzmSrJ0De1C0BAzucqZ2vGUpGGLbR7o
         1/nImMykI/cqIq63EfFVfsYLZ9VxBOdXuPKR2soqVFQrrePRsnmgYCHZmH6rWp/jiOn5
         1AUtTA83bHuFZGRxS6Tu3YlHpmBvlf6ik8Z8DBFwf1nFC2Kc55F7+Ytic8p37nj+LYHo
         0GWbtLV93sK5EkAnkc8u0dRD0V4xfpzVvyCifVeeVDWlVj9rYQYFL7RvUvU5nFm5FfQh
         /9fA==
X-Gm-Message-State: AOJu0Yy9mzn3CTACjqeNOeeC7W+5D9NvNcSK+7X9UagJxFRoxCfYMuWU
	WovYmO0JDWUeOd71Cd2zrX8OAasBYfLSyRDdebw=
X-Google-Smtp-Source: AGHT+IHsM8f94ex4DuHsmcYKbxm7XfBGEt6kVzU1V2yBnUewnTFu5a5MvKOJTSiiOKt32pHViW3+mg==
X-Received: by 2002:a05:6808:1144:b0:3a4:633:44d2 with SMTP id u4-20020a056808114400b003a4063344d2mr964223oiu.18.1693353481716;
        Tue, 29 Aug 2023 16:58:01 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id n22-20020a62e516000000b00687fcb1e609sm8955277pff.116.2023.08.29.16.58.00
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 16:58:01 -0700 (PDT)
Message-ID: <64ee8609.620a0220.c8faf.f9c0@mx.google.com>
Date: Tue, 29 Aug 2023 16:58:01 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.191-cip38-2-g05fb42f86d06a
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 18 runs,
 21 regressions (v5.10.191-cip38-2-g05fb42f86d06a)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 29 Aug 2023 23:58:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12898

cip-gitlab/ci/pavel/linux-test baseline-nfs: 18 runs, 21 regressions (v5.10=
.191-cip38-2-g05fb42f86d06a)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | multi_v7_=
defconfig         | 7          =

beaglebone-black             | arm   | lab-cip       | gcc-10   | multi_v7_=
defconfig         | 7          =

beaglebone-black             | arm   | lab-broonie   | gcc-10   | omap2plus=
_defconfig        | 1          =

beaglebone-black             | arm   | lab-cip       | gcc-10   | omap2plus=
_defconfig        | 1          =

imx6q-udoo                   | arm   | lab-broonie   | gcc-10   | imx_v6_v7=
_defconfig        | 1          =

imx6q-udoo                   | arm   | lab-broonie   | gcc-10   | multi_v7_=
defconfig         | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+arm64-chromebook | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.191-cip38-2-g05fb42f86d06a/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.191-cip38-2-g05fb42f86d06a
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      05fb42f86d06ab31aa144cefe1ccd3c7cd8bbc72 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | multi_v7_=
defconfig         | 7          =


  Details:     https://kernelci.org/test/plan/id/64ee79860774770382286d89

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/arm/multi_v7_defconfig/gcc-10/lab-broonie=
/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/arm/multi_v7_defconfig/gcc-10/lab-broonie=
/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.hdmi-audio: https://kernelci.org/test/case/id/64ee7=
9860774770382286d90
        new failure (last pass: v6.1.46-cip4-rt2)

    2023-08-29T23:04:26.106622  /lava-78032/1/../bin/lava-test-case
    2023-08-29T23:04:26.169185  <8>[   80.676872] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/i=
d/64ee79860774770382286d91
        new failure (last pass: v6.1.46-cip4-rt2)

    2023-08-29T23:04:24.997752  /lava-78032/1/../bin/lava-test-case
    2023-08-29T23:04:25.055738  <8>[   79.562813] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-codec-driver-present: https://kernelci.org/tes=
t/case/id/64ee79860774770382286d93
        new failure (last pass: v6.1.46-cip4-rt2)

    2023-08-29T23:04:22.662168  /lava-78032/1/../bin/lava-test-case
    2023-08-29T23:04:22.716255  <8>[   77.223229] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-08-29T23:04:23.772179  /lava-78032/1/../bin/lava-test-case
    2023-08-29T23:04:23.834215  <8>[   78.340586] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case=
/id/64ee79860774770382286d94
        new failure (last pass: v6.1.46-cip4-rt2)

    2023-08-29T23:04:20.421992  /lava-78032/1/../bin/lava-test-case
    2023-08-29T23:04:20.484747  <8>[   74.991593] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-08-29T23:04:21.539018  /lava-78032/1/../bin/lava-test-case
    2023-08-29T23:04:21.605017  <8>[   76.111536] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tda19988-driver-present: https://kernelci.org/test/=
case/id/64ee79860774770382286d95
        new failure (last pass: v6.1.46-cip4-rt2)

    2023-08-29T23:04:18.190322  /lava-78032/1/../bin/lava-test-case
    2023-08-29T23:04:18.250436  <8>[   72.757310] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-08-29T23:04:19.306365  /lava-78032/1/../bin/lava-test-case
    2023-08-29T23:04:19.373608  <8>[   73.880110] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/64ee79860774770382286d9e
        new failure (last pass: v6.1.46-cip4-rt2)

    2023-08-29T23:04:05.479784  /lava-78032/1/../bin/lava-test-case
    2023-08-29T23:04:05.532220  <8>[   60.037474] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64ee79860774770382286db7
        new failure (last pass: v6.1.46-cip4-rt2)

    2023-08-29T23:03:58.106167  <8>[   52.613507] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 78032_1.6.2.4.1>
    2023-08-29T23:03:58.221793  / # #
    2023-08-29T23:03:58.325254  export SHELL=3D/bin/sh
    2023-08-29T23:03:58.326105  #
    2023-08-29T23:03:58.428670  / # export SHELL=3D/bin/sh. /lava-78032/env=
ironment
    2023-08-29T23:03:58.429509  =

    2023-08-29T23:03:58.532131  / # . /lava-78032/environment/lava-78032/bi=
n/lava-test-runner /lava-78032/1
    2023-08-29T23:03:58.533600  =

    2023-08-29T23:03:58.537984  / # /lava-78032/bin/lava-test-runner /lava-=
78032/1
    2023-08-29T23:03:58.753409  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
beaglebone-black             | arm   | lab-cip       | gcc-10   | multi_v7_=
defconfig         | 7          =


  Details:     https://kernelci.org/test/plan/id/64ee797475000dc59a286d88

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/arm/multi_v7_defconfig/gcc-10/lab-cip/bas=
eline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/arm/multi_v7_defconfig/gcc-10/lab-cip/bas=
eline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64ee797475000dc59a286d8b
        new failure (last pass: v6.1.46-cip4-rt2)

    2023-08-29T23:03:42.268197  / # #
    2023-08-29T23:03:42.371637  export SHELL=3D/bin/sh
    2023-08-29T23:03:42.372840  #
    2023-08-29T23:03:42.475304  / # export SHELL=3D/bin/sh. /lava-1002640/e=
nvironment
    2023-08-29T23:03:42.476444  =

    2023-08-29T23:03:42.579001  / # . /lava-1002640/environment/lava-100264=
0/bin/lava-test-runner /lava-1002640/1
    2023-08-29T23:03:42.580823  =

    2023-08-29T23:03:42.593883  / # /lava-1002640/bin/lava-test-runner /lav=
a-1002640/1
    2023-08-29T23:03:42.873525  + export TESTRUN_ID=3D1_bootrr
    2023-08-29T23:03:42.874116  + cd /lava-1002640/1/tests/1_bootrr =

    ... (10 line(s) more)  =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/64ee797475000dc59a286da4
        new failure (last pass: v6.1.46-cip4-rt2)

    2023-08-29T23:03:50.296168  /lava-1002640/1/../bin/lava-test-case
    2023-08-29T23:03:50.368829  <8>[   52.348548] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tda19988-driver-present: https://kernelci.org/test/=
case/id/64ee797475000dc59a286db0
        new failure (last pass: v6.1.46-cip4-rt2)

    2023-08-29T23:04:03.493720  /lava-1002640/1/../bin/lava-test-case
    2023-08-29T23:04:03.578457  <8>[   65.557951] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-08-29T23:04:04.649314  /lava-1002640/1/../bin/lava-test-case
    2023-08-29T23:04:04.719383  <8>[   66.699841] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case=
/id/64ee797475000dc59a286db1
        new failure (last pass: v6.1.46-cip4-rt2)

    2023-08-29T23:04:05.789841  /lava-1002640/1/../bin/lava-test-case
    2023-08-29T23:04:05.860861  <8>[   67.841326] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-08-29T23:04:06.931821  /lava-1002640/1/../bin/lava-test-case
    2023-08-29T23:04:07.001573  <8>[   68.982014] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-codec-driver-present: https://kernelci.org/tes=
t/case/id/64ee797475000dc59a286db2
        new failure (last pass: v6.1.46-cip4-rt2)

    2023-08-29T23:04:07.656878  <6>[   69.642646] platform sound: deferred =
probe pending
    2023-08-29T23:04:08.072408  /lava-1002640/1/../bin/lava-test-case
    2023-08-29T23:04:08.136282  <8>[   70.119081] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-08-29T23:04:09.207012  /lava-1002640/1/../bin/lava-test-case
    2023-08-29T23:04:09.275647  <8>[   71.255017] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/i=
d/64ee797475000dc59a286db4
        new failure (last pass: v6.1.46-cip4-rt2)

    2023-08-29T23:04:10.456471  /lava-1002640/1/../bin/lava-test-case
    2023-08-29T23:04:10.536198  <8>[   72.518119] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-audio: https://kernelci.org/test/case/id/64ee7=
97475000dc59a286db5
        new failure (last pass: v6.1.46-cip4-rt2)

    2023-08-29T23:04:11.607006  /lava-1002640/1/../bin/lava-test-case
    2023-08-29T23:04:11.678877  <8>[   73.659566] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | omap2plus=
_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/64ee775d62d46cbd7a286d7b

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/arm/omap2plus_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/arm/omap2plus_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/=
id/64ee775d62d46cbd7a286d9a
        new failure (last pass: v6.1.46-cip4-rt2)

    2023-08-29T22:55:09.395131  /lava-78002/1/../bin/lava-test-case
    2023-08-29T22:55:09.479720  <8>[   53.331267] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
beaglebone-black             | arm   | lab-cip       | gcc-10   | omap2plus=
_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/64ee775f21a10a7905286d79

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/arm/omap2plus_defconfig/gcc-10/lab-cip/ba=
seline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/arm/omap2plus_defconfig/gcc-10/lab-cip/ba=
seline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/=
id/64ee775f21a10a7905286d97
        new failure (last pass: v6.1.46-cip4-rt2)

    2023-08-29T22:55:14.076602  /lava-1002622/1/../bin/lava-test-case
    2023-08-29T22:55:14.146507  <8>[   45.492083] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
imx6q-udoo                   | arm   | lab-broonie   | gcc-10   | imx_v6_v7=
_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/64ee79c26865da4200286d7d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/arm/imx_v6_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/arm/imx_v6_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64ee79c26865da420=
0286d7e
        failing since 7 days (last pass: v4.4-st20-3262-g667bb8d8b2cb, firs=
t fail: v6.1.45-cip3-31-gbae6b8e9a2cff) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
imx6q-udoo                   | arm   | lab-broonie   | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/64ee7c7e539befbe6c286da0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/arm/multi_v7_defconfig/gcc-10/lab-broonie=
/baseline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/arm/multi_v7_defconfig/gcc-10/lab-broonie=
/baseline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64ee7c7e539befbe6=
c286da1
        new failure (last pass: v6.1.46-cip4-rt2) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ee78d2abc4696f28286edc

  Results:     51 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.sound-card: https://kernelci.org/test/case/id/64ee7=
8d2abc4696f28286ee3
        new failure (last pass: v6.1.46-cip4-rt2)

    2023-08-29T23:01:33.973305  /lava-78014/1/../bin/lava-test-case
    2023-08-29T23:01:34.020771  <8>[   38.886927] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>   =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ee79b08ea49f9422286d87

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/baseline-nfs-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/baseline-nfs-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64ee79b08ea49f942=
2286d88
        new failure (last pass: v6.1.46-cip4-rt2) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ee797e0774770382286d86

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64ee797e077477038=
2286d87
        failing since 7 days (last pass: v5.10.186-cip37-16-gf8567732a40d, =
first fail: v6.1.45-cip3-31-gbae6b8e9a2cff) =

 =20

