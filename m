Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974C2C7EE25
	for <webhook@archiver.kernel.org>; Mon,  5 Jun 2023 18:07:44 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web11.16243.1685988456640821953
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Jun 2023 11:07:36 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=sAnhCK3W;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.170, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1b026657a6fso44584195ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Jun 2023 11:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685988455; x=1688580455;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Wx2Y2SYycip++DahMk8uidoI34eg0jNplxFdb0Brozs=;
        b=sAnhCK3WzjRLShIBmt5NPAoMJ7/84tKPJ7G2pmD5Tz1j247OQfOI0vVBHdQUNU/Wok
         1bu1LDAHwr/IFTSKW+iPaKoRLhW3GDeHdFEJimw/d8FLoshjZWuJHA6cjwSgcpNehnlb
         GhXC+tqKc296kmIU2Nwspv/NPVl5Rjpy6ZVpcbXMF5MJmBFbS7uPyvsbeDjhgahaSnr7
         gl4RVL54dttXAsBOtv2IekDF4R8rYZiSdbIOv64LBN+KYjGGKu5rJEM7vP8VcG5jCnmT
         tDPAj0pOd8py6pEmus2i+u5/wEVO9OfC5w6ujWxFG6KQSVVxEJvMGg5zHESK43iQtCQK
         mFpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685988455; x=1688580455;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wx2Y2SYycip++DahMk8uidoI34eg0jNplxFdb0Brozs=;
        b=hQ84Qw0turJU42n9wPalbwdZwa0hnVbIL0/LkFwjHY5MAQtoDAxsJWiLEnYU5saGDo
         y8OKOBBkCpz7vQ/yO6RGEE/ChRHuxBCz8EtQ1C64+TG56ZXYYulv71wPlsaEWr3cSGrj
         oMyb3HBczUwOO+kDFXczDqHfqwCiGIH8NIEzvHT2Ev01rtcF5a8gGLvIfUPCDrzuRrcc
         1S+pegQ8UcZXYNc7K8jhoKjUuy84SvBPC9q9VbzreUyIeQUkhjqs7gwYhrfKKKMG4Bh3
         MNyo+9Gz69PWKwicUpC34CEHNqFil975MbcbXt6gQlk62uk2AzYreeo8R+VMRkOWJdaZ
         iEdg==
X-Gm-Message-State: AC+VfDwkfLkR0LgCI5h8I03a6B8P9Ic1yimxNnIwLLx1QxuqgxjQtAFb
	QwiYQWGVKZc4Ud18/caHAlavgr8BUT4OGc2pTNSuZQ==
X-Google-Smtp-Source: ACHHUZ5e9p1wl/rGirJHl6KVwFIBP5yKHKJ8OindOk+FHj5Y4AVw7r9NhD7/Fg1JECatbHos1MCL4Q==
X-Received: by 2002:a17:902:e74f:b0:1b0:5c0a:3f80 with SMTP id p15-20020a170902e74f00b001b05c0a3f80mr9625998plf.44.1685988454168;
        Mon, 05 Jun 2023 11:07:34 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i17-20020a170902c95100b001ac6b926621sm6822920pla.292.2023.06.05.11.07.33
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 11:07:33 -0700 (PDT)
Message-ID: <647e2465.170a0220.6f110.bae0@mx.google.com>
Date: Mon, 05 Jun 2023 11:07:33 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.180-cip34-26-gc198172c84b6a
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test baseline: 105 runs,
 61 regressions (v5.10.180-cip34-26-gc198172c84b6a)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jun 2023 18:07:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11815

cip-gitlab/ci/pavel/linux-test baseline: 105 runs, 61 regressions (v5.10.18=
0-cip34-26-gc198172c84b6a)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 7          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig           | 7          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 2          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 2          =

fsl-ls1028a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

fsl-ls1088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =

imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =

imx7ulp-evk                  | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =

juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 10         =

kontron-kbox-a-230-ls        | arm64  | lab-kontron     | gcc-10   | defcon=
fig                    | 3          =

kontron-sl28-var3-ads2       | arm64  | lab-kontron     | gcc-10   | defcon=
fig                    | 3          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

mt8173-elm-hana              | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

qemu_mips-malta              | mips   | lab-broonie     | gcc-10   | malta_=
defconfig              | 1          =

qemu_mips-malta              | mips   | lab-collabora   | gcc-10   | malta_=
defconfig              | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 5          =

zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =

zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.180-cip34-26-gc198172c84b6a/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.180-cip34-26-gc198172c84b6a
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c198172c84b6a9338925de15df053d71eda6a6cc =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 7          =


  Details:     https://kernelci.org/test/plan/id/647e19b512c36a686bf5de2d

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.hdmi-audio: https://kernelci.org/test/case/id/647e19b51=
2c36a686bf5de34
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:21:45.273013  /lava-564707/1/../bin/lava-test-case
    2023-06-05T17:21:45.307615  <8>[   43.938302] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/id/64=
7e19b512c36a686bf5de35
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:21:44.213069  /lava-564707/1/../bin/lava-test-case
    2023-06-05T17:21:44.247297  <8>[   42.877903] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-codec-driver-present: https://kernelci.org/test/ca=
se/id/647e19b512c36a686bf5de37
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:21:42.044491  /lava-564707/1/../bin/lava-test-case
    2023-06-05T17:21:42.078396  <8>[   40.709042] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-06-05T17:21:43.105474  /lava-564707/1/../bin/lava-test-case
    2023-06-05T17:21:43.141891  <8>[   41.769190] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case/id/=
647e19b512c36a686bf5de38
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:21:39.916031  /lava-564707/1/../bin/lava-test-case
    2023-06-05T17:21:39.954655  <8>[   38.584577] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-06-05T17:21:40.981037  /lava-564707/1/../bin/lava-test-case
    2023-06-05T17:21:41.017256  <8>[   39.647345] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline.bootrr.tda19988-driver-present: https://kernelci.org/test/case=
/id/647e19b512c36a686bf5de39
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:21:37.791692  /lava-564707/1/../bin/lava-test-case
    2023-06-05T17:21:37.826717  <8>[   36.457438] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-06-05T17:21:38.854027  /lava-564707/1/../bin/lava-test-case
    2023-06-05T17:21:38.889113  <8>[   37.519045] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/647e19b512c36a686bf5de45
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:21:25.847753  /lava-564707/1/../bin/lava-test-case
    2023-06-05T17:21:25.878412  <8>[   24.507034] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647e19b612c36a686bf5de5e
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:21:20.087449  <8>[   18.718023] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 564707_1.5.2.4.1>
    2023-06-05T17:21:20.198499  / # #
    2023-06-05T17:21:20.301524  export SHELL=3D/bin/sh
    2023-06-05T17:21:20.302424  #
    2023-06-05T17:21:20.404485  / # export SHELL=3D/bin/sh. /lava-564707/en=
vironment
    2023-06-05T17:21:20.405401  =

    2023-06-05T17:21:20.507516  / # . /lava-564707/environment/lava-564707/=
bin/lava-test-runner /lava-564707/1
    2023-06-05T17:21:20.508895  =

    2023-06-05T17:21:20.513427  / # /lava-564707/bin/lava-test-runner /lava=
-564707/1
    2023-06-05T17:21:20.610678  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig           | 7          =


  Details:     https://kernelci.org/test/plan/id/647e1bf55d2f04a048f5de96

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm/multi_v7_defconfig/gcc-10/lab-cip/ba=
seline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm/multi_v7_defconfig/gcc-10/lab-cip/ba=
seline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647e1bf55d2f04a048f5de9d
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:30:46.466452  + set +x
    2023-06-05T17:30:46.468498  <8>[   18.748966] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 953475_1.5.2.4.1>
    2023-06-05T17:30:46.576723  / # #
    2023-06-05T17:30:46.678595  export SHELL=3D/bin/sh
    2023-06-05T17:30:46.679062  #
    2023-06-05T17:30:46.780441  / # export SHELL=3D/bin/sh. /lava-953475/en=
vironment
    2023-06-05T17:30:46.780905  =

    2023-06-05T17:30:46.882284  / # . /lava-953475/environment/lava-953475/=
bin/lava-test-runner /lava-953475/1
    2023-06-05T17:30:46.883028  =

    2023-06-05T17:30:46.885144  / # /lava-953475/bin/lava-test-runner /lava=
-953475/1 =

    ... (12 line(s) more)  =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/647e1bf55d2f04a048f5deb6
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:30:52.196459  /lava-953475/1/../bin/lava-test-case
    2023-06-05T17:30:52.235848  <8>[   24.514465] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.tda19988-driver-present: https://kernelci.org/test/case=
/id/647e1bf55d2f04a048f5dec2
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:31:04.131389  /lava-953475/1/../bin/lava-test-case
    2023-06-05T17:31:04.166425  <8>[   36.446702] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-06-05T17:31:05.193268  /lava-953475/1/../bin/lava-test-case
    2023-06-05T17:31:05.228746  <8>[   37.508066] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case/id/=
647e1bf55d2f04a048f5dec3
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:31:06.255511  /lava-953475/1/../bin/lava-test-case
    2023-06-05T17:31:06.289396  <8>[   38.569404] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-06-05T17:31:07.315618  /lava-953475/1/../bin/lava-test-case
    2023-06-05T17:31:07.349244  <8>[   39.629173] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-codec-driver-present: https://kernelci.org/test/ca=
se/id/647e1bf55d2f04a048f5dec4
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:31:08.376005  /lava-953475/1/../bin/lava-test-case
    2023-06-05T17:31:08.414743  <8>[   40.694957] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-06-05T17:31:09.441156  /lava-953475/1/../bin/lava-test-case
    2023-06-05T17:31:09.477603  <8>[   41.757083] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/id/64=
7e1bf55d2f04a048f5dec6
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:31:10.551553  /lava-953475/1/../bin/lava-test-case
    2023-06-05T17:31:10.586639  <8>[   42.866821] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-audio: https://kernelci.org/test/case/id/647e1bf55=
d2f04a048f5dec7
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:31:11.612278  /lava-953475/1/../bin/lava-test-case
    2023-06-05T17:31:11.646434  <8>[   43.927285] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 2          =


  Details:     https://kernelci.org/test/plan/id/647e1aec8b9b60e0e5f5de96

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm/omap2plus_defconfig/gcc-10/lab-broon=
ie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm/omap2plus_defconfig/gcc-10/lab-broon=
ie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/id/6=
47e1aec8b9b60e0e5f5deb5
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:26:48.881379  /lava-564729/1/../bin/lava-test-case
    2023-06-05T17:26:48.921593  <8>[   22.858025] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647e1aec8b9b60e0e5f5decf
        failing since 1 day (last pass: v4.19.280-cip95-rt30, first fail: v=
6.1.26-1281-g84d5372e0f31)

    2023-06-05T17:26:44.974024  <8>[   18.910672] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 564729_1.5.2.4.1>
    2023-06-05T17:26:45.083689  / # #
    2023-06-05T17:26:45.187484  export SHELL=3D/bin/sh
    2023-06-05T17:26:45.188421  #
    2023-06-05T17:26:45.291097  / # export SHELL=3D/bin/sh. /lava-564729/en=
vironment
    2023-06-05T17:26:45.291850  =

    2023-06-05T17:26:45.394538  / # . /lava-564729/environment/lava-564729/=
bin/lava-test-runner /lava-564729/1
    2023-06-05T17:26:45.396110  =

    2023-06-05T17:26:45.400783  / # /lava-564729/bin/lava-test-runner /lava=
-564729/1
    2023-06-05T17:26:45.499640  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 2          =


  Details:     https://kernelci.org/test/plan/id/647e1f28b9e1a8c548f5de4e

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm/omap2plus_defconfig/gcc-10/lab-cip/b=
aseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm/omap2plus_defconfig/gcc-10/lab-cip/b=
aseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647e1f28b9e1a8c548f5de55
        failing since 1 day (last pass: v4.19.280-cip95-rt30, first fail: v=
6.1.26-1281-g84d5372e0f31)

    2023-06-05T17:44:57.747298  <8>[   13.225896] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 953487_1.5.2.4.1>
    2023-06-05T17:44:57.856886  / # #
    2023-06-05T17:44:57.959159  export SHELL=3D/bin/sh
    2023-06-05T17:44:57.959866  #
    2023-06-05T17:44:58.061701  / # export SHELL=3D/bin/sh. /lava-953487/en=
vironment
    2023-06-05T17:44:58.062409  =

    2023-06-05T17:44:58.164645  / # . /lava-953487/environment/lava-953487/=
bin/lava-test-runner /lava-953487/1
    2023-06-05T17:44:58.165783  =

    2023-06-05T17:44:58.172681  / # /lava-953487/bin/lava-test-runner /lava=
-953487/1
    2023-06-05T17:44:58.268932  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =


  * baseline.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/id/6=
47e1f28b9e1a8c548f5de70
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:45:01.636615  /lava-953487/1/../bin/lava-test-case
    2023-06-05T17:45:01.680214  <8>[   17.156716] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls1028a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/647e1792041b7bf384f5df65

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm64/defconfig/gcc-10/lab-nxp/baseline-=
fsl-ls1028a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm64/defconfig/gcc-10/lab-nxp/baseline-=
fsl-ls1028a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647e1792041b7bf384f5df6c
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:11:43.102166  + [   22.155056] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 1233698_1.5.2.4.1>
    2023-06-05T17:11:43.102293  set +x
    2023-06-05T17:11:43.205805  / # #
    2023-06-05T17:11:43.306894  export SHELL=3D/bin/sh
    2023-06-05T17:11:43.307116  #
    2023-06-05T17:11:43.408090  / # export SHELL=3D/bin/sh. /lava-1233698/e=
nvironment
    2023-06-05T17:11:43.408394  =

    2023-06-05T17:11:43.509433  / # . /lava-1233698/environment/lava-123369=
8/bin/lava-test-runner /lava-1233698/1
    2023-06-05T17:11:43.509823  =

    2023-06-05T17:11:43.511787  / # /lava-1233698/bin/lava-test-runner /lav=
a-1233698/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls1088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/647e17883ae9f04debf5de4a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm64/defconfig/gcc-10/lab-nxp/baseline-=
fsl-ls1088a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm64/defconfig/gcc-10/lab-nxp/baseline-=
fsl-ls1088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647e17883ae9f04debf5de51
        failing since 2 days (last pass: v4.19.280-cip95-rt30, first fail: =
v6.1.26-1281-g84d5372e0f31)

    2023-06-05T17:11:33.743651  + [   10.575886] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 1233696_1.5.2.4.1>
    2023-06-05T17:11:33.743958  set +x
    2023-06-05T17:11:33.850991  / # #
    2023-06-05T17:11:33.952991  export SHELL=3D/bin/sh
    2023-06-05T17:11:33.953599  #
    2023-06-05T17:11:34.055020  / # export SHELL=3D/bin/sh. /lava-1233696/e=
nvironment
    2023-06-05T17:11:34.055549  =

    2023-06-05T17:11:34.156952  / # . /lava-1233696/environment/lava-123369=
6/bin/lava-test-runner /lava-1233696/1
    2023-06-05T17:11:34.157922  =

    2023-06-05T17:11:34.159752  / # /lava-1233696/bin/lava-test-runner /lav=
a-1233696/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647e1be3c00ae0f879f5dec7

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647e1be3c00ae0f879f5ded0
        failing since 2 days (last pass: v4.19.280-cip95-rt30, first fail: =
v6.1.26-1281-g84d5372e0f31)

    2023-06-05T17:14:03.964530  + set +x

    2023-06-05T17:14:03.970890  <8>[   11.040154] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10594599_1.4.2.3.1>

    2023-06-05T17:14:04.075392  / # #

    2023-06-05T17:14:04.175958  export SHELL=3D/bin/sh

    2023-06-05T17:14:04.176185  #

    2023-06-05T17:14:04.276708  / # export SHELL=3D/bin/sh. /lava-10594599/=
environment

    2023-06-05T17:14:04.276927  =


    2023-06-05T17:14:04.377473  / # . /lava-10594599/environment/lava-10594=
599/bin/lava-test-runner /lava-10594599/1

    2023-06-05T17:14:04.377801  =


    2023-06-05T17:14:04.382422  / # /lava-10594599/bin/lava-test-runner /la=
va-10594599/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647e18fa5f65c995e8f5de63

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647e18fa5f65c995e8f5de6c
        failing since 2 days (last pass: v4.19.280-cip95-rt30, first fail: =
v6.1.26-1281-g84d5372e0f31)

    2023-06-05T17:14:05.349508  + set +x<8>[   11.837402] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10594595_1.4.2.3.1>

    2023-06-05T17:14:05.349622  =


    2023-06-05T17:14:05.451977  #

    2023-06-05T17:14:05.452293  =


    2023-06-05T17:14:05.552950  / # #export SHELL=3D/bin/sh

    2023-06-05T17:14:05.553188  =


    2023-06-05T17:14:05.653751  / # export SHELL=3D/bin/sh. /lava-10594595/=
environment

    2023-06-05T17:14:05.653981  =


    2023-06-05T17:14:05.754562  / # . /lava-10594595/environment/lava-10594=
595/bin/lava-test-runner /lava-10594595/1

    2023-06-05T17:14:05.754964  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647e190b5f65c995e8f5dec7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647e190b5f65c995e8f5d=
ec8
        failing since 2 days (last pass: v4.19.280-cip95-rt30, first fail: =
v6.1.26-1281-g84d5372e0f31) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647e1a60af33d415f4f5de37

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647e1a60af33d415f4f5d=
e38
        new failure (last pass: v6.1.26-1298-g61395b9756bd5) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647e19095f65c995e8f5debb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647e19095f65c995e8f5d=
ebc
        failing since 2 days (last pass: v4.19.280-cip95-rt30, first fail: =
v6.1.26-1281-g84d5372e0f31) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647e1a5ffa4d5c34def5de57

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647e1a5ffa4d5c34def5d=
e58
        new failure (last pass: v6.1.26-1298-g61395b9756bd5) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647e1819672951dc4af5de25

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm/imx_v6_v7_defconfig/gcc-10/lab-pengu=
tronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm/imx_v6_v7_defconfig/gcc-10/lab-pengu=
tronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647e1819672951dc4af5de2e
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:14:42.298500  + set +x
    2023-06-05T17:14:42.298666  [   10.332468] <LAVA_SIGNAL_ENDRUN 0_dmesg =
967857_1.5.2.3.1>
    2023-06-05T17:14:42.406261  / # #
    2023-06-05T17:14:42.508028  export SHELL=3D/bin/sh
    2023-06-05T17:14:42.508502  #
    2023-06-05T17:14:42.609847  / # export SHELL=3D/bin/sh. /lava-967857/en=
vironment
    2023-06-05T17:14:42.610363  =

    2023-06-05T17:14:42.711692  / # . /lava-967857/environment/lava-967857/=
bin/lava-test-runner /lava-967857/1
    2023-06-05T17:14:42.712313  =

    2023-06-05T17:14:42.715381  / # /lava-967857/bin/lava-test-runner /lava=
-967857/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647e18a55d2977048cf5de39

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm/multi_v7_defconfig/gcc-10/lab-pengut=
ronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm/multi_v7_defconfig/gcc-10/lab-pengut=
ronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647e18a55d2977048cf5de42
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:17:00.731763  + set[    7.242820] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 967862_1.5.2.3.1>
    2023-06-05T17:17:00.731965   +x
    2023-06-05T17:17:00.838087  / # #
    2023-06-05T17:17:00.939711  export SHELL=3D/bin/sh
    2023-06-05T17:17:00.940278  #
    2023-06-05T17:17:01.041505  / # export SHELL=3D/bin/sh. /lava-967862/en=
vironment
    2023-06-05T17:17:01.042008  =

    2023-06-05T17:17:01.143238  / # . /lava-967862/environment/lava-967862/=
bin/lava-test-runner /lava-967862/1
    2023-06-05T17:17:01.143828  =

    2023-06-05T17:17:01.146498  / # /lava-967862/bin/lava-test-runner /lava=
-967862/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647e18f65f65c995e8f5de58

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm/multi_v7_defconfig/gcc-10/lab-nxp/ba=
seline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm/multi_v7_defconfig/gcc-10/lab-nxp/ba=
seline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.all-cpus-are-online: https://kernelci.org/test/case/id/=
647e18f65f65c995e8f5de60
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:18:27.086492  /lava-1233707/1/../bin/lava-test-case
    2023-06-05T17:18:27.133825  <8>[   24.953791] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dall-cpus-are-online RESULT=3Dfail>
    2023-06-05T17:18:27.134194  /lava-1233707/1/../bin/lava-test-case   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7ulp-evk                  | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647e198d38a5ab6e70f5de63

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm/multi_v7_defconfig/gcc-10/lab-nxp/ba=
seline-imx7ulp-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm/multi_v7_defconfig/gcc-10/lab-nxp/ba=
seline-imx7ulp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647e198d38a5ab6e70f5de6a
        failing since 75 days (last pass: v5.10.145-rt74-1329-ga59fc50f38f6=
, first fail: v5.10.175-cip29-rt12)

    2023-06-05T17:20:37.334813  + set +x<8>[   29.004313] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 1233706_1.5.2.4.1>
    2023-06-05T17:20:37.335124  =

    2023-06-05T17:20:37.443546  / # #
    2023-06-05T17:20:38.603773  export SHELL=3D/bin/sh
    2023-06-05T17:20:38.609464  #
    2023-06-05T17:20:38.609760  / # export SHELL=3D/bin/sh
    2023-06-05T17:20:40.157473  / # . /lava-1233706/environment
    2023-06-05T17:20:42.985454  /lava-1233706/bin/lava-test-runner /lava-12=
33706/1
    2023-06-05T17:20:42.991526  . /lava-1233706/environment
    2023-06-05T17:20:42.991822  / # /lava-1233706/bin/lava-test-runner /lav=
a-1233706/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 10         =


  Details:     https://kernelci.org/test/plan/id/647e19125f65c995e8f5dece

  Results:     51 PASS, 10 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.led7-probed: https://kernelci.org/test/case/id/647e1912=
5f65c995e8f5dedf
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:18:59.290275  /lava-564665/1/../bin/lava-test-case
    2023-06-05T17:18:59.311290  <8>[   27.160950] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled7-probed RESULT=3Dfail>
    2023-06-05T17:18:59.311822  /lava-564665/1/../bin/lava-test-case   =


  * baseline.bootrr.led6-probed: https://kernelci.org/test/case/id/647e1912=
5f65c995e8f5dee0
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:18:58.260909  /lava-564665/1/../bin/lava-test-case
    2023-06-05T17:18:58.282866  <8>[   26.132307] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled6-probed RESULT=3Dfail>   =


  * baseline.bootrr.led5-probed: https://kernelci.org/test/case/id/647e1912=
5f65c995e8f5dee1
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:18:57.231570  /lava-564665/1/../bin/lava-test-case
    2023-06-05T17:18:57.253614  <8>[   25.102677] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled5-probed RESULT=3Dfail>   =


  * baseline.bootrr.led4-probed: https://kernelci.org/test/case/id/647e1912=
5f65c995e8f5dee2
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:18:56.201289  /lava-564665/1/../bin/lava-test-case
    2023-06-05T17:18:56.224393  <8>[   24.073435] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled4-probed RESULT=3Dfail>   =


  * baseline.bootrr.led3-probed: https://kernelci.org/test/case/id/647e1912=
5f65c995e8f5dee3
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:18:55.172001  /lava-564665/1/../bin/lava-test-case
    2023-06-05T17:18:55.193969  <8>[   23.043636] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled3-probed RESULT=3Dfail>   =


  * baseline.bootrr.led2-probed: https://kernelci.org/test/case/id/647e1912=
5f65c995e8f5dee4
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:18:54.142655  /lava-564665/1/../bin/lava-test-case
    2023-06-05T17:18:54.164608  <8>[   22.014198] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled2-probed RESULT=3Dfail>   =


  * baseline.bootrr.led1-probed: https://kernelci.org/test/case/id/647e1912=
5f65c995e8f5dee5
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:18:53.112363  /lava-564665/1/../bin/lava-test-case
    2023-06-05T17:18:53.135417  <8>[   20.984612] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled1-probed RESULT=3Dfail>   =


  * baseline.bootrr.led0-probed: https://kernelci.org/test/case/id/647e1912=
5f65c995e8f5dee6
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:18:52.101722  /lava-564665/1/../bin/lava-test-case
    2023-06-05T17:18:52.105022  <8>[   19.955672] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled0-probed RESULT=3Dfail>   =


  * baseline.bootrr.iommu1-probed: https://kernelci.org/test/case/id/647e19=
125f65c995e8f5def6
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:18:50.193436  <6>[   18.032211] input: PS/2 Generic Mouse=
 as /devices/platform/bus@8000000/bus@8000000:motherboard-bus/bus@8000000:m=
otherboard-bus:iofpga-bus@300000000/1c070000.kmi/serio1/input/input4
    2023-06-05T17:18:50.305111  <4>[   18.158368] psmouse serio1: Failed to=
 enable mouse on 1c070000.kmi
    2023-06-05T17:18:50.608921  /lava-564665/1/../bin/lava-test-case
    2023-06-05T17:18:50.631969  <8>[   18.481844] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Diommu1-probed RESULT=3Dfail>   =


  * baseline.bootrr.1c050000_mmc-probed: https://kernelci.org/test/case/id/=
647e19125f65c995e8f5df03
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:18:49.291691  /lava-564665/1/../bin/lava-test-case
    2023-06-05T17:18:49.294905  <8>[   17.145369] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3D1c050000.mmc-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
kontron-kbox-a-230-ls        | arm64  | lab-kontron     | gcc-10   | defcon=
fig                    | 3          =


  Details:     https://kernelci.org/test/plan/id/647e17192bf83c2ac2f5de3f

  Results:     89 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-kontron-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-kontron-kbox-a-230-ls.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.layerscape-sfp-driver-present: https://kernelci.org/tes=
t/case/id/647e171a2bf83c2ac2f5de6f
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:10:26.108953  /lava-350612/1/../bin/lava-test-case
    2023-06-05T17:10:26.112255  <8>[   20.147975] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.rcpm-driver-present: https://kernelci.org/test/case/id/=
647e171a2bf83c2ac2f5de85
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:10:21.643810  /lava-350612/1/../bin/lava-test-case
    2023-06-05T17:10:21.647075  <8>[   15.682850] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.ftm-alarm-driver-present: https://kernelci.org/test/cas=
e/id/647e171a2bf83c2ac2f5de86
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:10:22.655972  /lava-350612/1/../bin/lava-test-case
    2023-06-05T17:10:22.659129  <8>[   16.699992] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2023-06-05T17:10:23.678950  /lava-350612/1/../bin/lava-test-case   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
kontron-sl28-var3-ads2       | arm64  | lab-kontron     | gcc-10   | defcon=
fig                    | 3          =


  Details:     https://kernelci.org/test/plan/id/647e17059eef5a0571f5de4e

  Results:     97 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-kontron-sl28-var3-ads2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-kontron-sl28-var3-ads2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rcpm-driver-present: https://kernelci.org/test/case/id/=
647e17059eef5a0571f5de99
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:10:14.494742  /lava-350614/1/../bin/lava-test-case
    2023-06-05T17:10:14.497955  <8>[   10.967357] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.ftm-alarm-driver-present: https://kernelci.org/test/cas=
e/id/647e17059eef5a0571f5de9a
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:10:15.507317  /lava-350614/1/../bin/lava-test-case
    2023-06-05T17:10:15.510555  <8>[   11.984934] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2023-06-05T17:10:16.528830  /lava-350614/1/../bin/lava-test-case   =


  * baseline.bootrr.layerscape-sfp-driver-present: https://kernelci.org/tes=
t/case/id/647e17059eef5a0571f5deaf
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:10:18.949473  /lava-350614/1/../bin/lava-test-case
    2023-06-05T17:10:18.952880  <8>[   15.422369] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/647e1765a08263b258f5de4d

  Results:     51 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/647e1765a=
08263b258f5de54
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:11:43.036873  /lava-564639/1/../bin/lava-test-case
    2023-06-05T17:11:43.046941  <8>[   19.098307] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/647e1cf3f8ac233bfef5de27

  Results:     51 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-broonie/baseline-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-broonie/baseline-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/647e1cf3f=
8ac233bfef5de2e
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:35:27.385257  /lava-564750/1/../bin/lava-test-case
    2023-06-05T17:35:27.395825  <8>[   18.799447] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/647e1cafb933330aacf5de4c

  Results:     28 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/baseline-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/baseline-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647e1cafb933330aacf5de6c
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:34:15.546051  + set +x

    2023-06-05T17:34:15.551756  <8>[   15.657091] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10594679_1.5.2.3.1>

    2023-06-05T17:34:15.658954  / # #

    2023-06-05T17:34:15.761877  export SHELL=3D/bin/sh

    2023-06-05T17:34:15.762599  #

    2023-06-05T17:34:15.864082  / # export SHELL=3D/bin/sh. /lava-10594679/=
environment

    2023-06-05T17:34:15.864860  =


    2023-06-05T17:34:15.966415  / # . /lava-10594679/environment/lava-10594=
679/bin/lava-test-runner /lava-10594679/1

    2023-06-05T17:34:15.967693  =


    2023-06-05T17:34:15.969760  / # /lava-10594679/bin/lava-test-runner /la=
va-10594679/1
 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_mips-malta              | mips   | lab-broonie     | gcc-10   | malta_=
defconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/647e17a549b4e8af8af5de2e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/mips/malta_defconfig/gcc-10/lab-broonie/=
baseline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/mips/malta_defconfig/gcc-10/lab-broonie/=
baseline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647e17a549b4e8af8af5d=
e2f
        new failure (last pass: v6.1.26-1298-g61395b9756bd5) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_mips-malta              | mips   | lab-collabora   | gcc-10   | malta_=
defconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/647e17212bf83c2ac2f5dea2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/mips/malta_defconfig/gcc-10/lab-collabor=
a/baseline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/mips/malta_defconfig/gcc-10/lab-collabor=
a/baseline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647e17212bf83c2ac2f5d=
ea3
        new failure (last pass: v6.1.26-1298-g61395b9756bd5) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647e1684752ba4abdef5de4e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm/shmobile_defconfig/gcc-10/lab-cip/ba=
seline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm/shmobile_defconfig/gcc-10/lab-cip/ba=
seline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647e1684752ba4abdef5d=
e4f
        new failure (last pass: v6.1.26-1298-g61395b9756bd5) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/647e1cb0989e1ce6e2f5de60

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/647e1cb0989e1ce6e2f5de6a
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:34:30.497983  /lava-10594674/1/../bin/lava-test-case

    2023-06-05T17:34:30.508805  <8>[   33.331648] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/647e1cb0989e1ce6e2f5de6b
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:34:28.435713  <8>[   31.256521] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-06-05T17:34:29.461391  /lava-10594674/1/../bin/lava-test-case

    2023-06-05T17:34:29.471888  <8>[   32.294887] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 5          =


  Details:     https://kernelci.org/test/plan/id/647e18699417c1f3d3f5de25

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/647e18699=
417c1f3d3f5de3f
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:16:00.940385  /lava-564654/1/../bin/lava-test-case
    2023-06-05T17:16:00.952465  <8>[   25.437223] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Di2s-probed RESULT=3Dblocked>
    2023-06-05T17:16:01.968167  /lava-564654/1/../bin/lava-test-case
    2023-06-05T17:16:01.981746  <8>[   26.466677] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>   =


  * baseline.bootrr.sun4i-i2s-driver-present: https://kernelci.org/test/cas=
e/id/647e18699417c1f3d3f5de40
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:15:58.870080  /lava-564654/1/../bin/lava-test-case
    2023-06-05T17:15:58.881791  <8>[   23.365697] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcodec-digital-probed RESULT=3Dblocked>
    2023-06-05T17:15:59.906335  /lava-564654/1/../bin/lava-test-case
    2023-06-05T17:15:59.918050  <8>[   24.401895] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun4i-i2s-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sun8i-codec-driver-present: https://kernelci.org/test/c=
ase/id/647e18699417c1f3d3f5de41
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:15:56.795372  /lava-564654/1/../bin/lava-test-case
    2023-06-05T17:15:56.806590  <8>[   21.291039] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcodec-analog-probed RESULT=3Dblocked>
    2023-06-05T17:15:57.833344  /lava-564654/1/../bin/lava-test-case
    2023-06-05T17:15:57.845237  <8>[   22.329044] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8i-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sun50i-codec-analog-driver-present: https://kernelci.or=
g/test/case/id/647e18699417c1f3d3f5de42
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:15:55.755117  /lava-564654/1/../bin/lava-test-case
    2023-06-05T17:15:55.771515  <8>[   20.254867] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun50i-codec-analog-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647e18699417c1f3d3f5de55
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:15:52.614590  + set +x
    2023-06-05T17:15:52.618467  <8>[   17.104599] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 564654_1.5.2.4.1>
    2023-06-05T17:15:52.731165  / # #
    2023-06-05T17:15:52.834336  export SHELL=3D/bin/sh
    2023-06-05T17:15:52.835142  #
    2023-06-05T17:15:52.937615  / # export SHELL=3D/bin/sh. /lava-564654/en=
vironment
    2023-06-05T17:15:52.938377  =

    2023-06-05T17:15:53.040993  / # . /lava-564654/environment/lava-564654/=
bin/lava-test-runner /lava-564654/1
    2023-06-05T17:15:53.042325  =

    2023-06-05T17:15:53.046498  / # /lava-564654/bin/lava-test-runner /lava=
-564654/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/647e180deb02745901f5de38

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm64/defconfig/gcc-10/lab-cip/baseline-=
zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm64/defconfig/gcc-10/lab-cip/baseline-=
zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647e180deb02745901f5d=
e39
        new failure (last pass: v6.1.26-1298-g61395b9756bd5) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/647e1dad599d7e5905f5de90

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647e1dad599d7e5905f5d=
e91
        new failure (last pass: v6.1.26-1298-g61395b9756bd5) =

 =20

