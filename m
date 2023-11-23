Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EC4C61DF7
	for <webhook@archiver.kernel.org>; Thu, 23 Nov 2023 23:49:01 +0000 (UTC)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
 by mx.groups.io with SMTP id smtpd.web11.120273.1700783334906390723
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 23 Nov 2023 15:48:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=L0Cr4Miv;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.180, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6c33ab26dddso1126267b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 23 Nov 2023 15:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700783334; x=1701388134; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=db8NgTjoBkpE4bRUX1twjeJCjL1A0nSVuXjkA4KpIxk=;
        b=L0Cr4MivAbX+OSmos5p900AdW12tXGsGtGl4yEmc/+Jh1YR7cyk0fyfuxHiD/+L5XG
         EsLSz5FpV/yPTmrYCSKxCcWPSUEalKp9hFYarkT5qQHFL+u4h/2FiCilIRdcp7gLQqxg
         R52jq6H3rjtEUzioWytHJfFCI6a9C7K+YOXEILkPLlSDEWh52s0hza/r6KeYh84ujP2i
         6F3Xx6EyKm2BV8BzV7Dzuym3+85JGYPAiwnk8iAg0ouVDeO59vEvG3EObn2M72sXifGM
         EDNSimY0SDlk8jj/caWin62ZUHHkNqeu9VhuCh3/tRMzuSssxhSBckqUZNNZ9EbaN+5w
         +R3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700783334; x=1701388134;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=db8NgTjoBkpE4bRUX1twjeJCjL1A0nSVuXjkA4KpIxk=;
        b=al6KHL83p0qc95QB+PMjXhb2sxGWiQAauyK4rmJIG/tgwhDb2aTm8foDUYJp/tylox
         /N1h0O+Q602A2S2ibXcyGGL5YhXSdMaNryiFk7P19mJMk3uprPmwqueZEp6P2roVrZwp
         h0mT/qTY+UWmGu5c7awzCNkgjY+l3tyAqgWv8xlMLTrl4dAdWXAzurRrSx2KadT0SUE5
         aVe3BltJVkEGcFClh1mr7JmP5OyOCkc9vRMvCLyrCJlEbdjxv5Crh0DbhVoWI8Kv/wa4
         t4430+4H5G1gExDJwMgCliZqND1cFbq66cMmEd4cnHiGoeTrSCL9/ExCOYcMgZSEiJzu
         60ig==
X-Gm-Message-State: AOJu0YwOW7oRHEy3dYhDhQCUop9aukEXPuYoENddhymnIXZTCR7OHEsp
	qrXQDmTYObCuyCwHgdL+DaQppVIso10hZxu0uvg=
X-Google-Smtp-Source: AGHT+IG19u53giAJosdqJRdMgJS668rPTlght0Sg+5GYloGcX6QJhOEjo5quaU5t9N/9vIvc8kVzsw==
X-Received: by 2002:a05:6a20:94c5:b0:18b:2265:c6d3 with SMTP id ht5-20020a056a2094c500b0018b2265c6d3mr1133070pzb.36.1700783332935;
        Thu, 23 Nov 2023 15:48:52 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 1-20020a17090a000100b002855bfa23e3sm2207195pja.53.2023.11.23.15.48.51
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 15:48:52 -0800 (PST)
Message-ID: <655fe4e4.170a0220.e79f2.6c59@mx.google.com>
Date: Thu, 23 Nov 2023 15:48:52 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.201-rt98-828-g27523c64bc5dd
Subject: cip-gitlab/ci/pavel/linux-test baseline: 104 runs,
 46 regressions (v5.10.201-rt98-828-g27523c64bc5dd)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Nov 2023 23:49:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13692

cip-gitlab/ci/pavel/linux-test baseline: 104 runs, 46 regressions (v5.10.20=
1-rt98-828-g27523c64bc5dd)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
acer-cbv514-1h-34uz-brya     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

acer-chromebox-cxi5-brask    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | at91_dt_=
defconfig          | 3          =

at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig         | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig         | 7          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig         | 7          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig        | 1          =

imx6dl-udoo                  | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig         | 1          =

imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig         | 1          =

imx7d-sdb                    | arm    | lab-nxp       | gcc-10   | imx_v6_v=
7_defconfig        | 1          =

imx7d-sdb                    | arm    | lab-nxp       | gcc-10   | multi_v7=
_defconfig         | 1          =

juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 10         =

kontron-kbox-a-230-ls        | arm64  | lab-kontron   | gcc-10   | defconfi=
g                  | 3          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 2          =

qemu_mips-malta              | mips   | lab-broonie   | gcc-10   | malta_de=
fconfig            | 1          =

qemu_mips-malta              | mips   | lab-collabora | gcc-10   | malta_de=
fconfig            | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig         | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =

sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =

zynqmp-zcu102                | arm64  | lab-cip       | gcc-10   | defconfi=
g                  | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.201-rt98-828-g27523c64bc5dd/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.201-rt98-828-g27523c64bc5dd
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      27523c64bc5dd6f1af1b227b80017fea69e616b6 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
acer-cbv514-1h-34uz-brya     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/655fdadaac3fe675c47e4a7c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-acer-cbv514-1h-34uz-brya.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-acer-cbv514-1h-34uz-brya.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/655fdadaac3fe675c47e4=
a7d
        new failure (last pass: v6.1.58-cip7-132-gb38ea1474c159) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
acer-chromebox-cxi5-brask    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/655fdadaac3fe675c47e4a7f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-acer-chromebox-cxi5-brask.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-acer-chromebox-cxi5-brask.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/655fdadaac3fe675c47e4=
a80
        new failure (last pass: v6.1.58-cip7-132-gb38ea1474c159) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | at91_dt_=
defconfig          | 3          =


  Details:     https://kernelci.org/test/plan/id/655fdcadc307fbe1ca7e4a7f

  Results:     49 PASS, 4 FAIL, 1 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm/at91_dt_defconfig/gcc-10/lab-broonie=
/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm/at91_dt_defconfig/gcc-10/lab-broonie=
/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.gpio-keys-probed: https://kernelci.org/test/case/id/655=
fdcadc307fbe1ca7e4a88
        new failure (last pass: v6.1.62-cip9-13-g34c303883a305)

    2023-11-23T23:13:26.779739  /lava-267160/1/../bin/lava-test-case
    2023-11-23T23:13:26.819709  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dgpi=
o-keys-probed RESULT=3Dfail>   =


  * baseline.bootrr.wm8731-driver-present: https://kernelci.org/test/case/i=
d/655fdcadc307fbe1ca7e4a93
        new failure (last pass: v6.1.62-cip9-13-g34c303883a305)

    2023-11-23T23:13:22.568960  /lava-267160/1/../bin/lava-test-case
    2023-11-23T23:13:22.609171  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Deep=
rom-probed RESULT=3Dblocked>
    2023-11-23T23:13:22.649407  sh: /sys/bus/spi/drivers/wm8731: unknown op=
erand
    2023-11-23T23:13:23.669654  /lava-267160/1/../bin/lava-test-case
    2023-11-23T23:13:23.711298  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dwm8=
731-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.at24-driver-present: https://kernelci.org/test/case/id/=
655fdcadc307fbe1ca7e4a94
        new failure (last pass: v6.1.62-cip9-13-g34c303883a305)

    2023-11-23T23:13:21.467457  /lava-267160/1/../bin/lava-test-case
    2023-11-23T23:13:21.507758  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dat2=
4-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/655fdaa44efc7aeaa67e4a75

  Results:     48 PASS, 6 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm/multi_v5_defconfig/gcc-10/lab-brooni=
e/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm/multi_v5_defconfig/gcc-10/lab-brooni=
e/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.gpio-keys-probed: https://kernelci.org/test/case/id/655=
fdaa44efc7aeaa67e4a7e
        new failure (last pass: v6.1.62-cip9-13-g34c303883a305)

    2023-11-23T23:04:57.611471  /lava-267116/1/../bin/lava-test-case
    2023-11-23T23:04:57.654613  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dgpi=
o-keys-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig         | 7          =


  Details:     https://kernelci.org/test/plan/id/655fddf1a83729d7a67e4a7b

  Results:     30 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.hdmi-audio: https://kernelci.org/test/case/id/655fddf1a=
83729d7a67e4a81
        failing since 3 days (last pass: v6.1.59-cip8-106-g65bd536c294e, fi=
rst fail: v5.10.200-cip40-513-g195b5d2b5c744)

    2023-11-23T23:19:07.322659  /lava-267170/1/../bin/lava-test-case
    2023-11-23T23:19:07.354382  <8>[   52.506381] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/id/65=
5fddf1a83729d7a67e4a82
        failing since 3 days (last pass: v6.1.59-cip8-106-g65bd536c294e, fi=
rst fail: v5.10.200-cip40-513-g195b5d2b5c744)

    2023-11-23T23:19:06.266918  /lava-267170/1/../bin/lava-test-case
    2023-11-23T23:19:06.304893  <8>[   51.448241] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-codec-driver-present: https://kernelci.org/test/ca=
se/id/655fddf1a83729d7a67e4a84
        failing since 3 days (last pass: v6.1.59-cip8-106-g65bd536c294e, fi=
rst fail: v5.10.200-cip40-513-g195b5d2b5c744)

    2023-11-23T23:19:04.090159  /lava-267170/1/../bin/lava-test-case
    2023-11-23T23:19:04.133755  <8>[   49.277235] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-11-23T23:19:05.150587  /lava-267170/1/../bin/lava-test-case
    2023-11-23T23:19:05.198038  /opt/bootrr/libexec/bootrr/boards/ti,am335x=
-bone-black: <8>[   50.342384] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dhdmi-co=
dec-driver-present RESULT=3Dfail>
    2023-11-23T23:19:05.198325  line 84: assert_device-present: not found   =


  * baseline.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case/id/=
655fddf1a83729d7a67e4a85
        failing since 3 days (last pass: v6.1.59-cip8-106-g65bd536c294e, fi=
rst fail: v5.10.200-cip40-513-g195b5d2b5c744)

    2023-11-23T23:19:01.967348  /lava-267170/1/../bin/lava-test-case
    2023-11-23T23:19:02.005658  <8>[   47.155229] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-11-23T23:19:03.029810  /lava-267170/1/../bin/lava-test-case
    2023-11-23T23:19:03.063782  <8>[   48.216118] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline.bootrr.tda19988-driver-present: https://kernelci.org/test/case=
/id/655fddf1a83729d7a67e4a86
        failing since 3 days (last pass: v6.1.59-cip8-106-g65bd536c294e, fi=
rst fail: v5.10.200-cip40-513-g195b5d2b5c744)

    2023-11-23T23:18:59.840099  /lava-267170/1/../bin/lava-test-case
    2023-11-23T23:18:59.884040  <8>[   45.027092] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-11-23T23:19:00.901851  /lava-267170/1/../bin/lava-test-case
    2023-11-23T23:19:00.945616  <8>[   46.092646] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/655fddf1a83729d7a67e4aa5
        failing since 3 days (last pass: v6.1.59-cip8-106-g65bd536c294e, fi=
rst fail: v5.10.200-cip40-513-g195b5d2b5c744)

    2023-11-23T23:18:42.168341  + set +x
    2023-11-23T23:18:42.273462  TESTCASE TEST_CASE_ID=3Demerg RESULT=3Dpass=
 UNITS=3Dlines MEASUREMENT=3D0>
    2023-11-23T23:18:42.273652  =

    2023-11-23T23:18:42.273812  / # <8>[   27.323390] <LAVA_SIGNAL_ENDRUN 0=
_dmesg 267170_1.5.2.4.1>
    2023-11-23T23:18:42.375784  #export SHELL=3D/bin/sh
    2023-11-23T23:18:42.376436  =

    2023-11-23T23:18:42.478297  / # export SHELL=3D/bin/sh. /lava-267170/en=
vironment
    2023-11-23T23:18:42.478977  =

    2023-11-23T23:18:42.580863  / # . /lava-267170/environment/lava-267170/=
bin/lava-test-runner /lava-267170/1
    2023-11-23T23:18:42.581750   =

    ... (13 line(s) more)  =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/655fddf1a83729d7a67e4aa7
        failing since 3 days (last pass: v6.1.59-cip8-106-g65bd536c294e, fi=
rst fail: v5.10.200-cip40-513-g195b5d2b5c744)

    2023-11-23T23:18:47.912219  /lava-267170/1/../bin/lava-test-case
    2023-11-23T23:18:47.956362  <8>[   33.097258] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig         | 7          =


  Details:     https://kernelci.org/test/plan/id/655fdfa66b92ac17737e4a6d

  Results:     30 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm/multi_v7_defconfig/gcc-10/lab-cip/ba=
seline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm/multi_v7_defconfig/gcc-10/lab-cip/ba=
seline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.hdmi-audio: https://kernelci.org/test/case/id/655fdfa66=
b92ac17737e4a73
        failing since 3 days (last pass: v6.1.59-cip8-106-g65bd536c294e, fi=
rst fail: v5.10.200-cip40-513-g195b5d2b5c744)

    2023-11-23T23:26:10.119451  /lava-1044091/1/../bin/lava-test-case
    2023-11-23T23:26:10.154217  <8>[   41.455763] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/id/65=
5fdfa66b92ac17737e4a74
        failing since 3 days (last pass: v6.1.59-cip8-106-g65bd536c294e, fi=
rst fail: v5.10.200-cip40-513-g195b5d2b5c744)

    2023-11-23T23:26:09.057069  /lava-1044091/1/../bin/lava-test-case
    2023-11-23T23:26:09.094931  <8>[   40.395783] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-codec-driver-present: https://kernelci.org/test/ca=
se/id/655fdfa66b92ac17737e4a76
        failing since 3 days (last pass: v6.1.59-cip8-106-g65bd536c294e, fi=
rst fail: v5.10.200-cip40-513-g195b5d2b5c744)

    2023-11-23T23:26:06.882299  /lava-1044091/1/../bin/lava-test-case
    2023-11-23T23:26:06.925731  <8>[   38.223483] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-11-23T23:26:07.948056  /lava-1044091/1/../bin/lava-test-case
    2023-11-23T23:26:07.986731  <8>[   39.286172] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case/id/=
655fdfa66b92ac17737e4a77
        failing since 3 days (last pass: v6.1.59-cip8-106-g65bd536c294e, fi=
rst fail: v5.10.200-cip40-513-g195b5d2b5c744)

    2023-11-23T23:26:04.759818  /lava-1044091/1/../bin/lava-test-case
    2023-11-23T23:26:04.796162  <8>[   36.096542] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-11-23T23:26:05.821834  /lava-1044091/1/../bin/lava-test-case
    2023-11-23T23:26:05.865131  <8>[   37.157958] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline.bootrr.tda19988-driver-present: https://kernelci.org/test/case=
/id/655fdfa66b92ac17737e4a78
        failing since 3 days (last pass: v6.1.59-cip8-106-g65bd536c294e, fi=
rst fail: v5.10.200-cip40-513-g195b5d2b5c744)

    2023-11-23T23:26:02.632500  /lava-1044091/1/../bin/lava-test-case
    2023-11-23T23:26:02.675956  <8>[   33.973281] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-11-23T23:26:03.697190  /lava-1044091/1/../bin/lava-test-case
    2023-11-23T23:26:03.736375  <8>[   35.035036] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/655fdfa66b92ac17737e4a84
        failing since 3 days (last pass: v6.1.59-cip8-106-g65bd536c294e, fi=
rst fail: v5.10.200-cip40-513-g195b5d2b5c744)

    2023-11-23T23:25:50.701821  /lava-1044091/1/../bin/lava-test-case
    2023-11-23T23:25:50.746426  <8>[   22.037680] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/655fdfa76b92ac17737e4a97
        failing since 3 days (last pass: v6.1.59-cip8-106-g65bd536c294e, fi=
rst fail: v5.10.200-cip40-513-g195b5d2b5c744)

    2023-11-23T23:25:44.968217  + set +x
    2023-11-23T23:25:45.073824  / # <8>[   16.268819] <LAVA_S#
    2023-11-23T23:25:45.175883  export SHELL=3D/bin/sh
    2023-11-23T23:25:45.176561  IGNAL_TESTCASE TEST_CASE_ID=3Demerg RESULT=
=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-11-23T23:25:45.176930  <8>[   16.270836] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1044091_1.5.2.4.1>
    2023-11-23T23:25:45.177279  #
    2023-11-23T23:25:45.278603  / # export SHELL=3D/bin/sh. /lava-1044091/e=
nvironment
    2023-11-23T23:25:45.279250  =

    2023-11-23T23:25:45.380593  / # . /lava-1044091/environment/lava-104409=
1/bin/lava-test-runner /lava-1044091/1
    2023-11-23T23:25:45.381842   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/655fde6900e3dae7027e4aea

  Results:     50 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm/omap2plus_defconfig/gcc-10/lab-broon=
ie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm/omap2plus_defconfig/gcc-10/lab-broon=
ie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/id/6=
55fde6900e3dae7027e4b08
        failing since 3 days (last pass: v6.1.59-cip8-106-g65bd536c294e, fi=
rst fail: v5.10.200-cip40-513-g195b5d2b5c744)

    2023-11-23T23:20:58.140736  /lava-267200/1/../bin/lava-test-case
    2023-11-23T23:20:58.185229  <8>[   23.048317] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
imx6dl-udoo                  | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/655fdee2e9c09f3c097e4a6d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/655fdee2e9c09f3c097e4=
a6e
        failing since 3 days (last pass: v6.1.59-cip8-106-g65bd536c294e, fi=
rst fail: v5.10.200-cip40-513-g195b5d2b5c744) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/655fdee343e513d9387e4a88

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/655fdee343e513d9387e4=
a89
        failing since 3 days (last pass: v6.1.59-cip8-106-g65bd536c294e, fi=
rst fail: v5.10.200-cip40-513-g195b5d2b5c744) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
imx7d-sdb                    | arm    | lab-nxp       | gcc-10   | imx_v6_v=
7_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/655fda5fd10611f6127e4a94

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm/imx_v6_v7_defconfig/gcc-10/lab-nxp/b=
aseline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm/imx_v6_v7_defconfig/gcc-10/lab-nxp/b=
aseline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.all-cpus-are-online: https://kernelci.org/test/case/id/=
655fda5fd10611f6127e4a9c
        failing since 3 days (last pass: v6.1.59-cip8-106-g65bd536c294e, fi=
rst fail: v5.10.200-cip40-513-g195b5d2b5c744)

    2023-11-23T23:03:42.750964  /lava-1260084/1/../bin/lava-test-case
    2023-11-23T23:03:42.794938  <8>[   31.789467] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dall-cpus-are-online RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
imx7d-sdb                    | arm    | lab-nxp       | gcc-10   | multi_v7=
_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/655fddf762c4c0c5d07e4a7c

  Results:     3 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm/multi_v7_defconfig/gcc-10/lab-nxp/ba=
seline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm/multi_v7_defconfig/gcc-10/lab-nxp/ba=
seline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.all-cpus-are-online: https://kernelci.org/test/case/id/=
655fddf762c4c0c5d07e4a83
        failing since 3 days (last pass: v6.1.59-cip8-106-g65bd536c294e, fi=
rst fail: v5.10.200-cip40-513-g195b5d2b5c744)

    2023-11-23T23:19:05.478259  /lava-1260090/1/../bin/lava-test-case
    2023-11-23T23:19:05.523098  <8>[   25.012122] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dall-cpus-are-online RESULT=3Dfail>
    2023-11-23T23:19:05.523419  /lava-1260090/1/../bin/lava-test-case   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 10         =


  Details:     https://kernelci.org/test/plan/id/655fdd2589fccfc9e97e4a92

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.led7-probed: https://kernelci.org/test/case/id/655fdd25=
89fccfc9e97e4aa3
        new failure (last pass: v6.1.62-cip9-13-g34c303883a305)

    2023-11-23T23:15:37.195650  /lava-267145/1/../bin/lava-test-case
    2023-11-23T23:15:37.261762  <8>[   25.978754] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled7-probed RESULT=3Dfail>
    2023-11-23T23:15:37.262383  /lava-267145/1/../bin/lava-test-case   =


  * baseline.bootrr.led6-probed: https://kernelci.org/test/case/id/655fdd25=
89fccfc9e97e4aa4
        new failure (last pass: v6.1.62-cip9-13-g34c303883a305)

    2023-11-23T23:15:36.185524  /lava-267145/1/../bin/lava-test-case
    2023-11-23T23:15:36.188780  <8>[   24.956245] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled6-probed RESULT=3Dfail>   =


  * baseline.bootrr.led5-probed: https://kernelci.org/test/case/id/655fdd25=
89fccfc9e97e4aa5
        new failure (last pass: v6.1.62-cip9-13-g34c303883a305)

    2023-11-23T23:15:35.150592  /lava-267145/1/../bin/lava-test-case
    2023-11-23T23:15:35.171752  <8>[   23.934094] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled5-probed RESULT=3Dfail>   =


  * baseline.bootrr.led4-probed: https://kernelci.org/test/case/id/655fdd25=
89fccfc9e97e4aa6
        new failure (last pass: v6.1.62-cip9-13-g34c303883a305)

    2023-11-23T23:15:34.140699  /lava-267145/1/../bin/lava-test-case
    2023-11-23T23:15:34.143850  <8>[   22.911951] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled4-probed RESULT=3Dfail>   =


  * baseline.bootrr.led3-probed: https://kernelci.org/test/case/id/655fdd25=
89fccfc9e97e4aa7
        new failure (last pass: v6.1.62-cip9-13-g34c303883a305)

    2023-11-23T23:15:33.120712  /lava-267145/1/../bin/lava-test-case
    2023-11-23T23:15:33.123922  <8>[   21.889489] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled3-probed RESULT=3Dfail>   =


  * baseline.bootrr.led2-probed: https://kernelci.org/test/case/id/655fdd25=
89fccfc9e97e4aa8
        new failure (last pass: v6.1.62-cip9-13-g34c303883a305)

    2023-11-23T23:15:32.082836  /lava-267145/1/../bin/lava-test-case
    2023-11-23T23:15:32.103975  <8>[   20.867299] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled2-probed RESULT=3Dfail>   =


  * baseline.bootrr.led1-probed: https://kernelci.org/test/case/id/655fdd25=
89fccfc9e97e4aa9
        new failure (last pass: v6.1.62-cip9-13-g34c303883a305)

    2023-11-23T23:15:31.072635  /lava-267145/1/../bin/lava-test-case
    2023-11-23T23:15:31.075875  <8>[   19.844474] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled1-probed RESULT=3Dfail>   =


  * baseline.bootrr.led0-probed: https://kernelci.org/test/case/id/655fdd25=
89fccfc9e97e4aaa
        new failure (last pass: v6.1.62-cip9-13-g34c303883a305)

    2023-11-23T23:15:30.052623  /lava-267145/1/../bin/lava-test-case
    2023-11-23T23:15:30.055874  <8>[   18.821646] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled0-probed RESULT=3Dfail>   =


  * baseline.bootrr.iommu1-probed: https://kernelci.org/test/case/id/655fdd=
2589fccfc9e97e4abd
        new failure (last pass: v6.1.62-cip9-13-g34c303883a305)

    2023-11-23T23:15:28.458418  <6>[   17.211647] input: PS/2 Generic Mouse=
 as /devices/platform/bus@8000000/bus@8000000:motherboard-bus/bus@8000000:m=
otherboard-bus:iofpga-bus@300000000/1c070000.kmi/serio1/input/input4
    2023-11-23T23:15:28.554170  <4>[   17.320843] psmouse serio1: Failed to=
 enable mouse on 1c070000.kmi
    2023-11-23T23:15:28.755506  /lava-267145/1/../bin/lava-test-case
    2023-11-23T23:15:28.756074  <8>[   17.475392] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Diommu1-probed RESULT=3Dfail>   =


  * baseline.bootrr.1c050000_mmc-probed: https://kernelci.org/test/case/id/=
655fdd2589fccfc9e97e4aca
        new failure (last pass: v6.1.62-cip9-13-g34c303883a305)

    2023-11-23T23:15:27.466196  /lava-267145/1/../bin/lava-test-case
    2023-11-23T23:15:27.466759  <8>[   16.232302] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3D1c050000.mmc-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
kontron-kbox-a-230-ls        | arm64  | lab-kontron   | gcc-10   | defconfi=
g                  | 3          =


  Details:     https://kernelci.org/test/plan/id/655fdba83fa1bc5d077e4aad

  Results:     88 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-kontron-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-kontron-kbox-a-230-ls.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rcpm-driver-present: https://kernelci.org/test/case/id/=
655fdba83fa1bc5d077e4af0
        new failure (last pass: v6.1.62-cip9-13-g34c303883a305)

    2023-11-23T23:08:14.639161  /lava-397898/1/../bin/lava-test-case   =


  * baseline.bootrr.ftm-alarm-driver-present: https://kernelci.org/test/cas=
e/id/655fdba83fa1bc5d077e4af1
        new failure (last pass: v6.1.62-cip9-13-g34c303883a305)

    2023-11-23T23:08:14.660266  <8>[   13.874465] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-driver-present RESULT=3Dfail>
    2023-11-23T23:08:15.663455  /lava-397898/1/../bin/lava-test-case
    2023-11-23T23:08:15.666690  <8>[   14.885549] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2023-11-23T23:08:16.657941  /lava-397898/1/../bin/lava-test-case
    2023-11-23T23:08:16.682141  <8>[   15.896976] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dftm-alarm-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.layerscape-sfp-driver-present: https://kernelci.org/tes=
t/case/id/655fdba83fa1bc5d077e4b08
        new failure (last pass: v6.1.62-cip9-13-g34c303883a305)

    2023-11-23T23:08:18.956599  /lava-397898/1/../bin/lava-test-case
    2023-11-23T23:08:18.978885  <8>[   18.194269] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 2          =


  Details:     https://kernelci.org/test/plan/id/655fdc732bd40114067e4a88

  Results:     49 PASS, 4 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/655fdc732=
bd40114067e4a8e
        new failure (last pass: v6.1.62-cip9-13-g34c303883a305)

    2023-11-23T23:11:35.901326  /lava-267139/1/../bin/lava-test-case
    2023-11-23T23:11:35.915275  <8>[   19.224882] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>
    2023-11-23T23:11:35.915736  + set +x   =


  * baseline.bootrr.cpufreq-probed: https://kernelci.org/test/case/id/655fd=
c732bd40114067e4ab6
        new failure (last pass: v6.1.62-cip9-13-g34c303883a305)

    2023-11-23T23:11:34.294407  /lava-267139/1/../bin/lava-test-case
    2023-11-23T23:11:34.299948  <8>[   17.616099] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpufreq-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
qemu_mips-malta              | mips   | lab-broonie   | gcc-10   | malta_de=
fconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/655fd9613ed9c37ac87e4aa1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/mips/malta_defconfig/gcc-10/lab-broonie/=
baseline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/mips/malta_defconfig/gcc-10/lab-broonie/=
baseline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/655fd9613ed9c37ac87e4=
aa2
        new failure (last pass: v6.1.62-cip9-13-g34c303883a305) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
qemu_mips-malta              | mips   | lab-collabora | gcc-10   | malta_de=
fconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/655fd9f95bd443fd0f7e4a9e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/mips/malta_defconfig/gcc-10/lab-collabor=
a/baseline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/mips/malta_defconfig/gcc-10/lab-collabor=
a/baseline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/655fd9f95bd443fd0f7e4=
a9f
        new failure (last pass: v6.1.62-cip9-13-g34c303883a305) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/655fdc4c151dbccf547e4a6d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm/shmobile_defconfig/gcc-10/lab-cip/ba=
seline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm/shmobile_defconfig/gcc-10/lab-cip/ba=
seline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/655fdc4c151dbccf547e4=
a6e
        new failure (last pass: v5.10.200-cip40-513-g195b5d2b5c744) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/655fdc722bd40114067e4a84

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/655fdc722bd40114067e4=
a85
        new failure (last pass: v6.1.62-cip9-13-g34c303883a305) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/655fdbf90e869dd7f07e4a76

  Results:     39 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-sun50i-h5-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-sun50i-h5-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.sun8-codec-analog-driver-present: https://kernelci.org/=
test/case/id/655fdbf90e869dd7f07e4a83
        new failure (last pass: v6.1.62-cip9-13-g34c303883a305)

    2023-11-23T23:10:33.036656  /lava-267147/1/../bin/lava-test-case
    2023-11-23T23:10:33.049528  <8>[   19.422586] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8-codec-analog-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
zynqmp-zcu102                | arm64  | lab-cip       | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/655fdc75151dbccf547e4a7f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm64/defconfig/gcc-10/lab-cip/baseline-=
zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm64/defconfig/gcc-10/lab-cip/baseline-=
zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/655fdc75151dbccf547e4=
a80
        new failure (last pass: v6.1.62-cip9-13-g34c303883a305) =

 =20

