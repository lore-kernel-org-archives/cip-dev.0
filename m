Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9746BC77B73
	for <webhook@archiver.kernel.org>; Mon,  5 Jun 2023 18:07:44 +0000 (UTC)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
 by mx.groups.io with SMTP id smtpd.web11.16244.1685988456829934617
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Jun 2023 11:07:36 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=RSIQWkze;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.170, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5289ce6be53so4472593a12.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Jun 2023 11:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685988455; x=1688580455;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gXmS5qVuhfg3PkjlNFzWIplN5bRHjdxrhm6j3Uyhsyg=;
        b=RSIQWkzeFdyMtOrekpVjCZ+KPJ/bI9H+q8dDAmk/vVkjExy3X9ueOCoIFhnjtl/oUw
         dVo6iC55EQEQgYheeYc654m9RAu5/OkuSCOa+jKz6R6oD0ORHtW8Wp7J7QuRojYHXwFj
         xLobJj/XYsgTNlbpwqpp3hzSAtQMXVQgqnBniYnlCSyu2q9BZPM8XLeDY4oyAgNUIdXq
         M8UK2h80bSUDlZN/8nJgTXusFDVas/qeiaYl9AnA6t2/lpp4rSiMlMVZzeasyZn9arkK
         v7sTiZY4I+DqMcxYw0ymZpfqdHtQlzEhsHX/pkTLZgRhukEnDznzQnuN2QfT0rsxmyFt
         Aabg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685988455; x=1688580455;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gXmS5qVuhfg3PkjlNFzWIplN5bRHjdxrhm6j3Uyhsyg=;
        b=W5lkqgxIh43rVIZ9utLPssiUbIpqzyQEDXchpVfJ/LLW9cHxGaNcMDV/cnm81A6nfy
         rzGQ+7WU+SkWxjlk0Pyypp8DBtOFZx6qcpm4WCX++CEEps0ATUK9Vcs+mhKk4JUXOrqD
         jG4ai7ekAG6jFdLXPSZ6Jd1vZJ1jeF4riyqGq0tzau2/Jw9d6wfb4Slyk3JwvTXP/afh
         bdpmU0qSFKASWCqb4dWlnkUWePbTsebuiRzYoolM9jxKeT5fqN6O1xUwYnDjHmEz2ioT
         rXlb6QoNJjgmQfep3DKvaFeB29etPbH8bL+wKbhNaz15J16ikY8mLxz1brSlP8eQ+xeB
         1+6g==
X-Gm-Message-State: AC+VfDz53MzL1k2piGagPkvK8ZH0SPmEWu1dgVZifqwF8gmkb2Xi8bXO
	1joC1l3AgdIkVAgwp9Yxkh7sMRqPdPQZ54mddZjRYw==
X-Google-Smtp-Source: ACHHUZ79BwIldVXeIpq/qAiOT/SZQeYlb95w3OGimNeboVr+DaXE3gyox4x6FWohfkOOr2gq85uKYw==
X-Received: by 2002:a17:902:cecb:b0:1ad:d95d:ca9c with SMTP id d11-20020a170902cecb00b001add95dca9cmr9425555plg.15.1685988454782;
        Mon, 05 Jun 2023 11:07:34 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id l13-20020a170902f68d00b001a1d553de0fsm6854216plg.271.2023.06.05.11.07.33
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 11:07:34 -0700 (PDT)
Message-ID: <647e2466.170a0220.31a64.c43d@mx.google.com>
Date: Mon, 05 Jun 2023 11:07:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.180-cip34-26-gc198172c84b6a
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 40 runs,
 50 regressions (v5.10.180-cip34-26-gc198172c84b6a)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jun 2023 18:07:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11816

cip-gitlab/ci/pavel/linux-test baseline-nfs: 40 runs, 50 regressions (v5.10=
.180-cip34-26-gc198172c84b6a)

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

dell-latitude...8665U-sarien | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

imx6dl-udoo                  | arm    | lab-broonie   | gcc-10   | imx_v6_v=
7_defconfig          | 1          =

imx6dl-udoo                  | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | imx_v6_v=
7_defconfig          | 1          =

imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 10         =

kontron-kbox-a-230-ls        | arm64  | lab-kontron   | gcc-10   | defconfi=
g                    | 3          =

kontron-sl28-var3-ads2       | arm64  | lab-kontron   | gcc-10   | defconfi=
g                    | 3          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

mt8173-elm-hana              | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 5          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.180-cip34-26-gc198172c84b6a/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.180-cip34-26-gc198172c84b6a
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c198172c84b6a9338925de15df053d71eda6a6cc =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 7          =


  Details:     https://kernelci.org/test/plan/id/647e1a0f42c988079df5de25

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.hdmi-audio: https://kernelci.org/test/case/id/647e1=
a0f42c988079df5de2c
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:23:09.216250  /lava-564696/1/../bin/lava-test-case
    2023-06-05T17:23:09.294069  <8>[   80.060607] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/i=
d/647e1a0f42c988079df5de2d
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:23:08.096276  /lava-564696/1/../bin/lava-test-case
    2023-06-05T17:23:08.159977  <8>[   78.926793] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-codec-driver-present: https://kernelci.org/tes=
t/case/id/647e1a0f42c988079df5de2f
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:23:05.739791  /lava-564696/1/../bin/lava-test-case
    2023-06-05T17:23:05.809741  <8>[   76.576646] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-06-05T17:23:06.870123  /lava-564696/1/../bin/lava-test-case
    2023-06-05T17:23:06.934561  <8>[   77.700001] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case=
/id/647e1a0f42c988079df5de30
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:23:03.506367  /lava-564696/1/../bin/lava-test-case
    2023-06-05T17:23:03.566751  <8>[   74.332876] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-06-05T17:23:04.618254  /lava-564696/1/../bin/lava-test-case
    2023-06-05T17:23:04.682071  <8>[   75.448052] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tda19988-driver-present: https://kernelci.org/test/=
case/id/647e1a0f42c988079df5de31
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:23:01.285129  /lava-564696/1/../bin/lava-test-case
    2023-06-05T17:23:01.343435  <8>[   72.109950] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-06-05T17:23:02.399005  /lava-564696/1/../bin/lava-test-case
    2023-06-05T17:23:02.456670  <8>[   73.222384] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/647e1a0f42c988079df5de3d
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:22:48.597225  /lava-564696/1/../bin/lava-test-case
    2023-06-05T17:22:48.652666  <8>[   59.418341] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647e1a0f42c988079df5de55
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:22:41.462902  <8>[   52.230430] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 564696_1.6.2.4.1>
    2023-06-05T17:22:41.581683  / # #
    2023-06-05T17:22:41.683771  export SHELL=3D/bin/sh
    2023-06-05T17:22:41.684481  #
    2023-06-05T17:22:41.786059  / # export SHELL=3D/bin/sh. /lava-564696/en=
vironment
    2023-06-05T17:22:41.786405  =

    2023-06-05T17:22:41.888200  / # . /lava-564696/environment/lava-564696/=
bin/lava-test-runner /lava-564696/1
    2023-06-05T17:22:41.889370  =

    2023-06-05T17:22:41.893629  / # /lava-564696/bin/lava-test-runner /lava=
-564696/1
    2023-06-05T17:22:42.103692  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 7          =


  Details:     https://kernelci.org/test/plan/id/647e19381b0d4a3469f5de25

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm/multi_v7_defconfig/gcc-10/lab-cip/ba=
seline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm/multi_v7_defconfig/gcc-10/lab-cip/ba=
seline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647e19381b0d4a3469f5de2c
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:18:52.169484  + set +x
    2023-06-05T17:18:52.173781  <8>[   50.224676] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 953468_1.6.2.4.1>
    2023-06-05T17:18:52.368456  #
    2023-06-05T17:18:52.471427  / # #export SHELL=3D/bin/sh
    2023-06-05T17:18:52.472138  =

    2023-06-05T17:18:52.573994  / # export SHELL=3D/bin/sh. /lava-953468/en=
vironment
    2023-06-05T17:18:52.574720  =

    2023-06-05T17:18:52.676591  / # . /lava-953468/environment/lava-953468/=
bin/lava-test-runner /lava-953468/1
    2023-06-05T17:18:52.677752  =

    2023-06-05T17:18:52.683631  / # /lava-953468/bin/lava-test-runner /lava=
-953468/1 =

    ... (12 line(s) more)  =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/647e19381b0d4a3469f5de45
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:19:04.045764  /lava-953468/1/../bin/lava-test-case
    2023-06-05T17:19:04.244132  <8>[   62.294381] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tda19988-driver-present: https://kernelci.org/test/=
case/id/647e19381b0d4a3469f5de51
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:19:19.564837  /lava-953468/1/../bin/lava-test-case
    2023-06-05T17:19:19.836193  <8>[   77.888194] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-06-05T17:19:20.897879  /lava-953468/1/../bin/lava-test-case
    2023-06-05T17:19:21.080608  <8>[   79.131236] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case=
/id/647e19381b0d4a3469f5de52
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:19:22.147425  /lava-953468/1/../bin/lava-test-case
    2023-06-05T17:19:22.356371  <8>[   80.408026] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-06-05T17:19:23.422363  /lava-953468/1/../bin/lava-test-case
    2023-06-05T17:19:23.582909  <8>[   81.633610] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-codec-driver-present: https://kernelci.org/tes=
t/case/id/647e19381b0d4a3469f5de53
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:19:24.645605  /lava-953468/1/../bin/lava-test-case
    2023-06-05T17:19:24.833719  <8>[   82.884833] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-06-05T17:19:25.900621  /lava-953468/1/../bin/lava-test-case
    2023-06-05T17:19:26.106671  <8>[   84.157460] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/i=
d/647e19381b0d4a3469f5de55
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:19:27.422981  /lava-953468/1/../bin/lava-test-case
    2023-06-05T17:19:27.680838  <8>[   85.731622] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-audio: https://kernelci.org/test/case/id/647e1=
9381b0d4a3469f5de56
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:19:28.749843  /lava-953468/1/../bin/lava-test-case
    2023-06-05T17:19:28.952633  <8>[   87.004624] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 2          =


  Details:     https://kernelci.org/test/plan/id/647e1bc7c00ae0f879f5de81

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm/omap2plus_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm/omap2plus_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/=
id/647e1bc7c00ae0f879f5dea0
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:30:23.009147  /lava-564734/1/../bin/lava-test-case
    2023-06-05T17:30:23.085405  <8>[   51.783113] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647e1bc7c00ae0f879f5deba
        failing since 1 day (last pass: v4.19.280-cip95-rt30, first fail: v=
6.1.26-1281-g84d5372e0f31)

    2023-06-05T17:30:16.917508  <8>[   45.616305] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 564734_1.6.2.4.1>
    2023-06-05T17:30:17.037486  / # #
    2023-06-05T17:30:17.140389  export SHELL=3D/bin/sh
    2023-06-05T17:30:17.141133  #
    2023-06-05T17:30:17.243272  / # export SHELL=3D/bin/sh. /lava-564734/en=
vironment
    2023-06-05T17:30:17.243967  =

    2023-06-05T17:30:17.346151  / # . /lava-564734/environment/lava-564734/=
bin/lava-test-runner /lava-564734/1
    2023-06-05T17:30:17.347283  =

    2023-06-05T17:30:17.352303  / # /lava-564734/bin/lava-test-runner /lava=
-564734/1
    2023-06-05T17:30:17.618726  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 2          =


  Details:     https://kernelci.org/test/plan/id/647e211c9a50c7c042f5de91

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm/omap2plus_defconfig/gcc-10/lab-cip/b=
aseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm/omap2plus_defconfig/gcc-10/lab-cip/b=
aseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647e211c9a50c7c042f5de98
        failing since 1 day (last pass: v4.19.280-cip95-rt30, first fail: v=
6.1.26-1281-g84d5372e0f31)

    2023-06-05T17:52:56.320298  + set +x
    2023-06-05T17:52:56.324692  <8>[   44.917620] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 953492_1.6.2.4.1>
    2023-06-05T17:52:56.559881  / # #
    2023-06-05T17:52:56.662571  export SHELL=3D/bin/sh
    2023-06-05T17:52:56.663273  #
    2023-06-05T17:52:56.765100  / # export SHELL=3D/bin/sh. /lava-953492/en=
vironment
    2023-06-05T17:52:56.765805  =

    2023-06-05T17:52:56.867631  / # . /lava-953492/environment/lava-953492/=
bin/lava-test-runner /lava-953492/1
    2023-06-05T17:52:56.868833  =

    2023-06-05T17:52:56.875650  / # /lava-953492/bin/lava-test-runner /lava=
-953492/1 =

    ... (12 line(s) more)  =


  * baseline-nfs.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/=
id/647e211c9a50c7c042f5deb3
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:53:05.653283  /lava-953492/1/../bin/lava-test-case
    2023-06-05T17:53:05.812838  <8>[   54.404529] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
dell-latitude...8665U-sarien | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647e1be55d2f04a048f5de27

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/baseline-nfs-dell-latitude-5400-8665U-sarien.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/baseline-nfs-dell-latitude-5400-8665U-sarien.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/647e1be55d2f04a04=
8f5de28
        new failure (last pass: v6.1.26-1298-g61395b9756bd5) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647e19035f65c995e8f5dea9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647e19035f65c995e8f5deb2
        failing since 2 days (last pass: v4.19.280-cip95-rt30, first fail: =
v6.1.26-1281-g84d5372e0f31)

    2023-06-05T17:14:20.561254  + set +x<8>[   17.890103] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10594645_1.5.2.3.1>

    2023-06-05T17:14:20.561403  =


    2023-06-05T17:14:20.665239  / # #

    2023-06-05T17:14:20.765852  export SHELL=3D/bin/sh

    2023-06-05T17:14:20.766101  #

    2023-06-05T17:14:20.866658  / # export SHELL=3D/bin/sh. /lava-10594645/=
environment

    2023-06-05T17:14:20.866951  =


    2023-06-05T17:14:20.967533  / # . /lava-10594645/environment/lava-10594=
645/bin/lava-test-runner /lava-10594645/1

    2023-06-05T17:14:20.967867  =


    2023-06-05T17:14:20.972934  / # /lava-10594645/bin/lava-test-runner /la=
va-10594645/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6dl-udoo                  | arm    | lab-broonie   | gcc-10   | imx_v6_v=
7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647e1bc5ae5bcf1cb9f5de4c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/647e1bc5ae5bcf1cb=
9f5de4d
        new failure (last pass: v6.1.26-1298-g61395b9756bd5) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6dl-udoo                  | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647e1d2d4eab3bacc1f5de45

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/647e1d2d4eab3bacc=
1f5de46
        new failure (last pass: v6.1.26-1298-g61395b9756bd5) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | imx_v6_v=
7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647e1bc7ae5bcf1cb9f5de52

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/647e1bc7ae5bcf1cb=
9f5de53
        failing since 0 day (last pass: v6.1.26-1281-g84d5372e0f31, first f=
ail: v6.1.26-1301-g6369cf0363211) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647e1d47a1278d138ff5de7a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/647e1d47a1278d138=
ff5de7b
        new failure (last pass: v6.1.26-1298-g61395b9756bd5) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 10         =


  Details:     https://kernelci.org/test/plan/id/647e1a3e31140ba976f5deb1

  Results:     51 PASS, 10 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-nfs-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-nfs-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.led7-probed: https://kernelci.org/test/case/id/647e=
1a3e31140ba976f5dec2
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:24:02.919619  /lava-564663/1/../bin/lava-test-case
    2023-06-05T17:24:02.956476  <8>[   57.101760] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled7-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led6-probed: https://kernelci.org/test/case/id/647e=
1a3e31140ba976f5dec3
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:24:01.816653  /lava-564663/1/../bin/lava-test-case
    2023-06-05T17:24:01.864515  <8>[   56.012876] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled6-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led5-probed: https://kernelci.org/test/case/id/647e=
1a3e31140ba976f5dec4
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:24:00.721429  /lava-564663/1/../bin/lava-test-case
    2023-06-05T17:24:00.777259  <8>[   54.922749] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled5-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led4-probed: https://kernelci.org/test/case/id/647e=
1a3e31140ba976f5dec5
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:23:59.651261  /lava-564663/1/../bin/lava-test-case
    2023-06-05T17:23:59.697824  <8>[   53.843496] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled4-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led3-probed: https://kernelci.org/test/case/id/647e=
1a3e31140ba976f5dec6
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:23:58.565068  /lava-564663/1/../bin/lava-test-case
    2023-06-05T17:23:58.611834  <8>[   52.757171] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled3-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led2-probed: https://kernelci.org/test/case/id/647e=
1a3e31140ba976f5dec7
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:23:57.477668  /lava-564663/1/../bin/lava-test-case
    2023-06-05T17:23:57.525606  <8>[   51.673149] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled2-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led1-probed: https://kernelci.org/test/case/id/647e=
1a3e31140ba976f5dec8
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:23:56.413524  /lava-564663/1/../bin/lava-test-case
    2023-06-05T17:23:56.454166  <8>[   50.599631] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled1-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led0-probed: https://kernelci.org/test/case/id/647e=
1a3e31140ba976f5dec9
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:23:55.327283  /lava-564663/1/../bin/lava-test-case
    2023-06-05T17:23:55.373849  <8>[   49.519338] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled0-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.iommu1-probed: https://kernelci.org/test/case/id/64=
7e1a3e31140ba976f5dedc
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:23:53.085747  /lava-564663/1/../bin/lava-test-case
    2023-06-05T17:23:53.130817  <8>[   47.275724] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Diommu1-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.1c050000_mmc-probed: https://kernelci.org/test/case=
/id/647e1a3e31140ba976f5dee9
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:23:51.098224  /lava-564663/1/../bin/lava-test-case
    2023-06-05T17:23:51.146115  <8>[   45.291537] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3D1c050000.mmc-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
kontron-kbox-a-230-ls        | arm64  | lab-kontron   | gcc-10   | defconfi=
g                    | 3          =


  Details:     https://kernelci.org/test/plan/id/647e17e16c91c731d7f5de36

  Results:     89 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-nfs-kontron-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-nfs-kontron-kbox-a-230-ls.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rcpm-driver-present: https://kernelci.org/test/case=
/id/647e17e26c91c731d7f5de7a
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:13:54.927879  /lava-350611/1/../bin/lava-test-case
    2023-06-05T17:13:54.930953  [   20.710608] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drcpm-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.ftm-alarm-driver-present: https://kernelci.org/test=
/case/id/647e17e26c91c731d7f5de7b
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:13:55.938373  /lava-350611/1/../bin/lava-test-case
    2023-06-05T17:13:55.967185  [   21.746676] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2023-06-05T17:13:56.974787  /lava-350611/1/../bin/lava-test-case
    2023-06-05T17:13:57.003727  [   22.783101] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dftm-alarm-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.layerscape-sfp-driver-present: https://kernelci.org=
/test/case/id/647e17e26c91c731d7f5de92
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:13:59.818203  /lava-350611/1/../bin/lava-test-case
    2023-06-05T17:13:59.841210  [   25.619707] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
kontron-sl28-var3-ads2       | arm64  | lab-kontron   | gcc-10   | defconfi=
g                    | 3          =


  Details:     https://kernelci.org/test/plan/id/647e176a041b7bf384f5de30

  Results:     97 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-nfs-kontron-sl28-var3-ads2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-nfs-kontron-sl28-var3-ads2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rcpm-driver-present: https://kernelci.org/test/case=
/id/647e176a041b7bf384f5de7b
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:11:53.637346  /lava-350613/1/../bin/lava-test-case
    2023-06-05T17:11:53.659399  <8>[   16.501848] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.ftm-alarm-driver-present: https://kernelci.org/test=
/case/id/647e176a041b7bf384f5de7c
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:11:54.682890  /lava-350613/1/../bin/lava-test-case
    2023-06-05T17:11:54.703784  <8>[   17.544759] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2023-06-05T17:11:55.727671  /lava-350613/1/../bin/lava-test-case
    2023-06-05T17:11:55.743466  <8>[   18.586450] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dftm-alarm-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.layerscape-sfp-driver-present: https://kernelci.org=
/test/case/id/647e176a041b7bf384f5de91
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:11:58.535394  /lava-350613/1/../bin/lava-test-case
    2023-06-05T17:11:58.558353  <8>[   21.400670] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/647e186a9417c1f3d3f5de63

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/647e186a9417c1f3d=
3f5de64
        new failure (last pass: v6.1.26-1298-g61395b9756bd5) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/647e1da768eebc16c4f5de28

  Results:     51 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.sound-card: https://kernelci.org/test/case/id/647e1=
da768eebc16c4f5de2f
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:38:36.850809  /lava-564743/1/../bin/lava-test-case
    2023-06-05T17:38:36.889982  <8>[   37.847849] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/647e1cfdf8a0b91fe2f5de42

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/baseline-nfs-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/baseline-nfs-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/647e1cfdf8a0b91fe=
2f5de43
        new failure (last pass: v6.1.26-1298-g61395b9756bd5) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/647e1cc931fd2a6b96f5de2e

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/647e1cc931fd2a6b96f5de38
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:34:56.562729  <8>[   40.496952] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-06-05T17:34:57.613549  /lava-10594668/1/../bin/lava-test-case

    2023-06-05T17:34:57.652116  <8>[   41.587227] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/647e1cc931fd2a6b96f5de39
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:34:55.470595  <8>[   39.404095] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-06-05T17:34:56.532218  /lava-10594668/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 5          =


  Details:     https://kernelci.org/test/plan/id/647e18f55f65c995e8f5de25

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-nfs-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-nfs-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.sound-card: https://kernelci.org/test/case/id/647e1=
8f55f65c995e8f5de3f
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:18:33.827945  /lava-564666/1/../bin/lava-test-case
    2023-06-05T17:18:33.856934  <8>[   39.348431] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Di2s-probed RESULT=3Dblocked>
    2023-06-05T17:18:34.888369  /lava-564666/1/../bin/lava-test-case
    2023-06-05T17:18:34.917659  <8>[   40.409223] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sun4i-i2s-driver-present: https://kernelci.org/test=
/case/id/647e18f55f65c995e8f5de40
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:18:31.680169  /lava-564666/1/../bin/lava-test-case
    2023-06-05T17:18:31.721611  <8>[   37.212475] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcodec-digital-probed RESULT=3Dblocked>
    2023-06-05T17:18:32.764529  /lava-564666/1/../bin/lava-test-case
    2023-06-05T17:18:32.794903  <8>[   38.285573] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun4i-i2s-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sun8i-codec-driver-present: https://kernelci.org/te=
st/case/id/647e18f55f65c995e8f5de41
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:18:29.554057  /lava-564666/1/../bin/lava-test-case
    2023-06-05T17:18:29.583358  <8>[   35.074280] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcodec-analog-probed RESULT=3Dblocked>
    2023-06-05T17:18:30.612847  /lava-564666/1/../bin/lava-test-case
    2023-06-05T17:18:30.643048  <8>[   36.133875] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8i-codec-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sun50i-codec-analog-driver-present: https://kernelc=
i.org/test/case/id/647e18f55f65c995e8f5de42
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:18:28.472162  /lava-564666/1/../bin/lava-test-case
    2023-06-05T17:18:28.505182  <8>[   33.995189] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun50i-codec-analog-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647e18f55f65c995e8f5de55
        new failure (last pass: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:18:24.521004  <8>[   30.013879] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 564666_1.6.2.4.1>
    2023-06-05T17:18:24.634512  / # #
    2023-06-05T17:18:24.737203  export SHELL=3D/bin/sh
    2023-06-05T17:18:24.738333  #
    2023-06-05T17:18:24.840184  / # export SHELL=3D/bin/sh. /lava-564666/en=
vironment
    2023-06-05T17:18:24.840825  =

    2023-06-05T17:18:24.942929  / # . /lava-564666/environment/lava-564666/=
bin/lava-test-runner /lava-564666/1
    2023-06-05T17:18:24.943879  =

    2023-06-05T17:18:24.948228  / # /lava-564666/bin/lava-test-runner /lava=
-564666/1
    2023-06-05T17:18:25.084192  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =20

