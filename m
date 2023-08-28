Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEDDC83F12
	for <webhook@archiver.kernel.org>; Mon, 28 Aug 2023 14:29:49 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
 by mx.groups.io with SMTP id smtpd.web11.15353.1693232981767548549
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 28 Aug 2023 07:29:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=W/yzOErX;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.178, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-68a529e1974so2220861b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 28 Aug 2023 07:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1693232981; x=1693837781;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BckHTrkFRS3bTRjrl/86AUW96WkbYr/GCFLOeYmJtz4=;
        b=W/yzOErXg8nbAHtPw6K+sIF2i4IGbcc4DTYCb2OH0sSt6pcZbppSVzH6XkMsL3Nh2g
         svE93610CP3m7ZwMLX1N+1MlglR0RLUOxY6CCLNVHeav2fdNtcP4TjjF6i1oHjOGJimo
         a7ia1acC2g6z1Be+JdCQ5/FCLtWJTxijJkHfyaERDfX1/Ebcbl4ZZV3giZgDxB6X9PYE
         CVHC28kDcrix4UBxanXd0QxZkRFA81tfkCy8fP8nswb4UP06Kbg126kK1whg4AgbN0F5
         Yo62bCeAxqLPUqopgcrWevUNyLz924yT8xG+svk4eVb1P2yEVHo4c7zczZPreDoY1yUm
         Ad9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693232981; x=1693837781;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BckHTrkFRS3bTRjrl/86AUW96WkbYr/GCFLOeYmJtz4=;
        b=MGZpUtkUeRTssPNHqm7sRe4nKuwBnidnmRtkZM3Fu0u9k1iAhcapilf9bE5cqalirf
         HFZALluCbLGoi9IggVhovY7f0u9BeyGEtdmsvOqvDzUBF8BdkC5SZWDxhFLuYX5Xgsam
         2RxH47ZiX+YKvDXVaCGVf3S9BniJ7MmloF0B5S3sVHi/poRtPOs8I8BaMH3tc+bh8Gb0
         fh1Rk1wlcw5+PDhFxW1tseVGfFVErvnjAdGOIO45/M+fnrwFR8x3ZfxRZkz7+Fke7XLh
         KUmSi0ZrhpkAobroPbRh+9B6I1PEjCbGX4c7T9FShN7KH/hRme3uGRgggJ0Q/sYzXunr
         Znmg==
X-Gm-Message-State: AOJu0YyvHDJD7wJ/I5FjaEgE2FDpgHvSQEmuhjqfRyUcA/Hfr3bFdAAQ
	bMD7yodQmdSiIdsDyy+HEszOiRpqSbtsSux6MjU=
X-Google-Smtp-Source: AGHT+IGp9CNOQCjVkti4V6MSXQni8XhJJjViMXUTHbIJFsmWBajWZXSHodu+JQhRl7Nk/7aqNheMYQ==
X-Received: by 2002:a05:6a00:b87:b0:68c:3f2:5ffd with SMTP id g7-20020a056a000b8700b0068c03f25ffdmr8568372pfj.2.1693232979781;
        Mon, 28 Aug 2023 07:29:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b9-20020a63d809000000b0056001f43726sm7268483pgh.92.2023.08.28.07.29.38
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 07:29:39 -0700 (PDT)
Message-ID: <64ecaf53.630a0220.9e51e.9403@mx.google.com>
Date: Mon, 28 Aug 2023 07:29:39 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.46-cip4-rt2
Subject: cip-gitlab/ci/pavel/linux-test baseline: 131 runs,
 23 regressions (v6.1.46-cip4-rt2)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Aug 2023 14:29:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12889

cip-gitlab/ci/pavel/linux-test baseline: 131 runs, 23 regressions (v6.1.46-=
cip4-rt2)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora | gcc-10   | bcm2835_=
defconfig            | 1          =

bcm2836-rpi-2-b              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =

fsl-ls1088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =

fsl-ls2088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =

fsl-lx2160a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

imx6dl-udoo                  | arm    | lab-broonie   | gcc-10   | imx_v6_v=
7_defconfig          | 1          =

imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | imx_v6_v=
7_defconfig          | 1          =

imx6ul-14x14-evk             | arm    | lab-nxp       | gcc-10   | imx_v6_v=
7_defconfig          | 1          =

imx8mp-evk                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

rk3288-veyron-jaq            | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 2          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 3          =

rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.46-cip4-rt2/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.46-cip4-rt2
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c4800588c47085de12fb82c4790e49fdee561258 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora | gcc-10   | bcm2835_=
defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/64eca3b896e288ceeb286ddd

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-rt2/arm/bcm2835_defconfig/gcc-10/lab-collabora/baseline-bcm28=
36-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-rt2/arm/bcm2835_defconfig/gcc-10/lab-collabora/baseline-bcm28=
36-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64eca3b896e288ceeb286de5
        failing since 12 days (last pass: v4.19.288-cip101-1117-g1f3468542a=
a9e, first fail: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-28T13:41:42.212559  + set +x

    2023-08-28T13:41:42.213754  <8>[   10.033747] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-08-28T13:41:42.214119  / # <8>[   10.035907] <LAVA_SIGNAL_ENDRUN 0=
_dmesg 11372140_1.5.2.4.1>

    2023-08-28T13:41:42.318518  #

    2023-08-28T13:41:42.420623  export SHELL=3D/bin/sh

    2023-08-28T13:41:42.421360  #

    2023-08-28T13:41:42.522745  / # export SHELL=3D/bin/sh. /lava-11372140/=
environment

    2023-08-28T13:41:42.523442  =


    2023-08-28T13:41:42.624757  / # . /lava-11372140/environment/lava-11372=
140/bin/lava-test-runner /lava-11372140/1

    2023-08-28T13:41:42.625847  =

 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64eca994de95a73055286ebd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-rt2/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-bcm2=
836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-rt2/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-bcm2=
836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64eca994de95a73055286=
ebe
        failing since 12 days (last pass: v4.19.288-cip101-1117-g1f3468542a=
a9e, first fail: v5.10.186-cip37-16-gf8567732a40d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-ls1088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64eca3eea55c2f1b83286d80

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-rt2/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1088a-rdb.t=
xt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-rt2/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1088a-rdb.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64eca3eea55c2f1b83286d83
        failing since 12 days (last pass: v4.19.288-cip101-1117-g1f3468542a=
a9e, first fail: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-28T13:40:47.132321  [   15.399322] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1247223_1.5.2.4.1>
    2023-08-28T13:40:47.237070  / # #
    2023-08-28T13:40:47.338429  export SHELL=3D/bin/sh
    2023-08-28T13:40:47.338836  #
    2023-08-28T13:40:47.439773  / # export SHELL=3D/bin/sh. /lava-1247223/e=
nvironment
    2023-08-28T13:40:47.440175  =

    2023-08-28T13:40:47.541129  / # . /lava-1247223/environment/lava-124722=
3/bin/lava-test-runner /lava-1247223/1
    2023-08-28T13:40:47.541792  =

    2023-08-28T13:40:47.545888  / # /lava-1247223/bin/lava-test-runner /lav=
a-1247223/1
    2023-08-28T13:40:47.564031  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-ls2088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64eca3da6efd758893286d77

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-rt2/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.t=
xt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-rt2/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64eca3da6efd758893286d7a
        failing since 12 days (last pass: v4.19.288-cip101-1117-g1f3468542a=
a9e, first fail: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-28T13:40:17.586749  / # [   14.836811] <LAVA#
    2023-08-28T13:40:17.688162  export SHELL=3D/bin/sh
    2023-08-28T13:40:17.688570  _SIGNAL_ENDRUN 0_dmesg 1247222_1.5.2.4.1>
    2023-08-28T13:40:17.688849  #
    2023-08-28T13:40:17.789773  / # export SHELL=3D/bin/sh. /lava-1247222/e=
nvironment
    2023-08-28T13:40:17.790177  =

    2023-08-28T13:40:17.891185  / # . /lava-1247222/environment/lava-124722=
2/bin/lava-test-runner /lava-1247222/1
    2023-08-28T13:40:17.891900  =

    2023-08-28T13:40:17.896270  / # /lava-1247222/bin/lava-test-runner /lav=
a-1247222/1
    2023-08-28T13:40:17.917564  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-lx2160a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64eca3dd6efd758893286d84

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-rt2/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.t=
xt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-rt2/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64eca3dd6efd758893286d87
        failing since 129 days (last pass: v5.10.145-rt74-1329-ga59fc50f38f=
6, first fail: v5.10.177-cip31-33-gd59f246891e73)

    2023-08-28T13:40:31.736347  [   11.234916] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1247225_1.5.2.4.1>
    2023-08-28T13:40:31.843524  =

    2023-08-28T13:40:31.944688  / # #export SHELL=3D/bin/sh
    2023-08-28T13:40:31.945070  =

    2023-08-28T13:40:32.046004  / # export SHELL=3D/bin/sh. /lava-1247225/e=
nvironment
    2023-08-28T13:40:32.046442  =

    2023-08-28T13:40:32.147188  / # . /lava-1247225/environment/lava-124722=
5/bin/lava-test-runner /lava-1247225/1
    2023-08-28T13:40:32.147935  =

    2023-08-28T13:40:32.150885  / # /lava-1247225/bin/lava-test-runner /lav=
a-1247225/1
    2023-08-28T13:40:32.172987  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64eca06460e3ad8d4a286d79

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-rt2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-rt2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64eca06460e3ad8d4a286d82
        failing since 12 days (last pass: v4.19.288-cip101-1117-g1f3468542a=
a9e, first fail: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-28T13:25:38.032545  + set +x

    2023-08-28T13:25:38.041948  + KERNELCI_LAVA=3Dy /bin/sh /opt/kernelci/d=
m<8>[    5.708448] <LAVA_SIGNAL_ENDRUN 0_dmesg 11372100_1.4.2.3.1>

    2023-08-28T13:25:38.042042  esg.sh

    2023-08-28T13:25:38.042113  + set +x

    2023-08-28T13:25:38.146780  / # #

    2023-08-28T13:25:38.247431  export SHELL=3D/bin/sh

    2023-08-28T13:25:38.247612  #

    2023-08-28T13:25:38.348233  / # export SHELL=3D/bin/sh. /lava-11372100/=
environment

    2023-08-28T13:25:38.348416  =


    2023-08-28T13:25:38.449038  / # . /lava-11372100/environment/lava-11372=
100/bin/lava-test-runner /lava-11372100/1
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6dl-udoo                  | arm    | lab-broonie   | gcc-10   | imx_v6_v=
7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64eca24566c2fca8a0286db1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-rt2/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-imx6d=
l-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-rt2/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-imx6d=
l-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64eca24566c2fca8a0286=
db2
        failing since 5 days (last pass: v4.4-st20-3262-g667bb8d8b2cb, firs=
t fail: v6.1.45-cip3-31-gbae6b8e9a2cff) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | imx_v6_v=
7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64eca2445a99b9b6ad286dcc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-rt2/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-imx6q=
-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-rt2/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-imx6q=
-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64eca2445a99b9b6ad286=
dcd
        failing since 5 days (last pass: v4.4-st20-3262-g667bb8d8b2cb, firs=
t fail: v6.1.45-cip3-31-gbae6b8e9a2cff) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6ul-14x14-evk             | arm    | lab-nxp       | gcc-10   | imx_v6_v=
7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64eca25ef89a7e7af4286da7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-rt2/arm/imx_v6_v7_defconfig/gcc-10/lab-nxp/baseline-imx6ul-14=
x14-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-rt2/arm/imx_v6_v7_defconfig/gcc-10/lab-nxp/baseline-imx6ul-14=
x14-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64eca25ef89a7e7af4286=
da8
        failing since 5 days (last pass: v4.4-st20-3262-g667bb8d8b2cb, firs=
t fail: v6.1.45-cip3-31-gbae6b8e9a2cff) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx8mp-evk                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64eca38ed524f5a3c3286dec

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-rt2/arm64/defconfig/gcc-10/lab-broonie/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-rt2/arm64/defconfig/gcc-10/lab-broonie/baseline-imx8mp-evk.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64eca38ed524f5a3c3286df5
        failing since 5 days (last pass: v5.10.186-cip37-16-gf8567732a40d, =
first fail: v6.1.45-cip3-31-gbae6b8e9a2cff)

    2023-08-28T13:39:09.486023  =

    2023-08-28T13:39:09.592568  / # #
    2023-08-28T13:39:10.758133  export SHELL=3D/bin/sh
    2023-08-28T13:39:10.764269  #
    2023-08-28T13:39:12.207103  / # export SHELL=3D/bin/sh. /lava-75543/env=
ironment
    2023-08-28T13:39:12.213183  =

    2023-08-28T13:39:14.820520  / # . /lava-75543/environment/lava-75543/bi=
n/lava-test-runner /lava-75543/1
    2023-08-28T13:39:14.827058  =

    2023-08-28T13:39:14.843828  / # /lava-75543/bin/lava-test-runner /lava-=
75543/1
    2023-08-28T13:39:14.856276  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (16 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64eca38fd524f5a3c3286df7

  Results:     51 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-rt2/arm64/defconfig/gcc-10/lab-broonie/baseline-meson-gxl-s90=
5x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-rt2/arm64/defconfig/gcc-10/lab-broonie/baseline-meson-gxl-s90=
5x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.cpufreq-probed: https://kernelci.org/test/case/id/64eca=
38fd524f5a3c3286e26
        new failure (last pass: v6.1.45-cip3-31-gbae6b8e9a2cff)

    2023-08-28T13:39:11.723973  /lava-75546/1/../bin/lava-test-case
    2023-08-28T13:39:11.737442  <8>[   19.126666] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpufreq-probed RESULT=3Dfail>
    2023-08-28T13:39:11.738006  /lava-75546/1/../bin/lava-test-case   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64eca885e117d87299286e4b

  Results:     50 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-rt2/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/basel=
ine-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-rt2/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/basel=
ine-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.cpufreq-probed: https://kernelci.org/test/case/id/64eca=
885e117d87299286e74
        new failure (last pass: v6.1.45-cip3-31-gbae6b8e9a2cff)

    2023-08-28T13:59:20.649363  /lava-75593/1/../bin/lava-test-case
    2023-08-28T13:59:20.664331  <8>[   19.391688] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpufreq-probed RESULT=3Dfail>
    2023-08-28T13:59:20.664773  /lava-75593/1/../bin/lava-test-case   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64eca0cf740d4c1538286d74

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-rt2/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-iw=
g20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-rt2/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-iw=
g20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64eca0cf740d4c1538286=
d75
        new failure (last pass: v6.1.45-cip3-31-gbae6b8e9a2cff) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64eca8b293a9944d3c286e03

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-rt2/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-=
r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-rt2/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-=
r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64eca8b293a9944d3c286e06
        failing since 12 days (last pass: v4.19.288-cip101-1117-g1f3468542a=
a9e, first fail: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-28T14:00:51.936047  / # #
    2023-08-28T14:00:53.400838  export SHELL=3D/bin/sh
    2023-08-28T14:00:53.422027  #
    2023-08-28T14:00:53.422500  / # export SHELL=3D/bin/sh
    2023-08-28T14:00:55.379984  / # . /lava-1002363/environment
    2023-08-28T14:00:58.980630  /lava-1002363/bin/lava-test-runner /lava-10=
02363/1
    2023-08-28T14:00:59.002330  . /lava-1002363/environment
    2023-08-28T14:00:59.002685  / # /lava-1002363/bin/lava-test-runner /lav=
a-1002363/1
    2023-08-28T14:00:59.085202  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-28T14:00:59.085773  + cd /lava-1002363/1/tests/1_bootrr =

    ... (26 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64eca368d7561320f6286d7e

  Results:     3 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-rt2/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ul=
cb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-rt2/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ul=
cb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64eca368d7561320f6286d86
        failing since 39 days (last pass: v6.1.31-65-geef5a19d48f6, first f=
ail: v5.10.186-cip37-2-gfcd111609480)

    2023-08-28T13:40:08.080911  <8>[   17.931659] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT#

    2023-08-28T13:40:08.081933  =3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-08-28T13:40:08.082216  =


    2023-08-28T13:40:08.082512  / # <8>[   17.932419] <LAVA_SIGNAL_ENDRUN 0=
_dmesg 11372129_1.5.2.4.1>

    2023-08-28T13:40:08.183386  #export SHELL=3D/bin/sh

    2023-08-28T13:40:08.183695  =


    2023-08-28T13:40:08.284304  / # export SHELL=3D/bin/sh. /lava-11372129/=
environment

    2023-08-28T13:40:08.284566  =


    2023-08-28T13:40:08.385265  / # . /lava-11372129/environment/lava-11372=
129/bin/lava-test-runner /lava-11372129/1

    2023-08-28T13:40:08.386292  =

 =

    ... (31 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64eca3c5818f442746286d75

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-rt2/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ul=
cb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-rt2/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ul=
cb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64eca3c5818f442746286d7e
        failing since 5 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v6.1.45-cip3-31-gbae6b8e9a2cff)

    2023-08-28T13:40:30.637427  #

    2023-08-28T13:40:31.714777  export SHELL=3D/bin/sh

    2023-08-28T13:40:31.716561  #

    2023-08-28T13:40:33.207321  / # export SHELL=3D/bin/sh. /lava-11372123/=
environment

    2023-08-28T13:40:33.209227  =


    2023-08-28T13:40:35.925088  / # . /lava-11372123/environment/lava-11372=
123/bin/lava-test-runner /lava-11372123/1

    2023-08-28T13:40:35.927292  =


    2023-08-28T13:40:35.936185  / # /lava-11372123/bin/lava-test-runner /la=
va-11372123/1

    2023-08-28T13:40:35.995253  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-28T13:40:35.995652  + cd /lava-11372123/1/tests/1_boo<8>[   27.=
534849] <LAVA_SIGNAL_STARTRUN 1_bootrr 11372123_1.5.2.4.5>
 =

    ... (44 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 2          =


  Details:     https://kernelci.org/test/plan/id/64eca8a693a9944d3c286d88

  Results:     64 PASS, 4 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-rt2/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk32=
88-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-rt2/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk32=
88-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/64eca8a693a9944d3c286dba
        failing since 220 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-08-28T14:02:33.163575  Print numbers f<8>[   27.427881] <LAVA_SIGN=
AL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-audio-present RESULT=3Dfa=
il>

    2023-08-28T14:02:33.167194  rom FIRST to LAST, in steps of INC.

    2023-08-28T14:02:33.169651  FIRST, INC default to 1.

    2023-08-28T14:02:33.169867  =


    2023-08-28T14:02:33.173286  	-w	Pad to last with leading zeros

    2023-08-28T14:02:33.175892  	-s SEP	String separator
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/64eca8a693a9944d3c286dbb
        failing since 220 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-08-28T14:02:33.145317  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC)<8=
>[   27.401996] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-probed=
 RESULT=3Dpass>

    2023-08-28T14:02:33.147171   multi-call binary.

    2023-08-28T14:02:33.147397  =


    2023-08-28T14:02:33.151742  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-08-28T14:02:33.151960  =

   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 3          =


  Details:     https://kernelci.org/test/plan/id/64eca850b6d50d6fce286e50

  Results:     79 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-rt2/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/bas=
eline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-rt2/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/bas=
eline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.cros-ec-sysfs-attr-kb_wake_angle: https://kernelci.org/=
test/case/id/64eca850b6d50d6fce286e8d
        new failure (last pass: v6.1.45-cip3-31-gbae6b8e9a2cff)

    2023-08-28T13:59:21.234270  /lava-11372187/1/../bin/lava-test-case

    2023-08-28T13:59:21.247617  /lava-11372187/1/../bin/lava-test-case
   =


  * baseline.bootrr.cros-ec-sensors-driver-present: https://kernelci.org/te=
st/case/id/64eca850b6d50d6fce286e93
        new failure (last pass: v6.1.45-cip3-31-gbae6b8e9a2cff)

    2023-08-28T13:59:18.041046  /lava-11372187/1/../bin/lava-test-case

    2023-08-28T13:59:18.054851  <8>[   42.885661] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-sensors-driver-present RESULT=3Dfail>
   =


  * baseline.bootrr.cros-ec-rtc-probed: https://kernelci.org/test/case/id/6=
4eca850b6d50d6fce286e94
        new failure (last pass: v6.1.45-cip3-31-gbae6b8e9a2cff)

    2023-08-28T13:59:17.017605  /lava-11372187/1/../bin/lava-test-case

    2023-08-28T13:59:17.029937  <8>[   41.862028] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-rtc-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64eca39b96e288ceeb286d79

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-rt2/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock=
-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-rt2/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock=
-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64eca39b96e288ceeb286d82
        failing since 5 days (last pass: v5.10.186-cip37-16-gf8567732a40d, =
first fail: v6.1.45-cip3-31-gbae6b8e9a2cff)

    2023-08-28T13:39:22.232401  / # #

    2023-08-28T13:39:23.493165  export SHELL=3D/bin/sh

    2023-08-28T13:39:23.504044  #

    2023-08-28T13:39:23.504501  / # export SHELL=3D/bin/sh

    2023-08-28T13:39:25.247543  / # . /lava-11372124/environment

    2023-08-28T13:39:28.450922  /lava-11372124/bin/lava-test-runner /lava-1=
1372124/1

    2023-08-28T13:39:28.462358  . /lava-11372124/environment

    2023-08-28T13:39:28.466698  / # /lava-11372124/bin/lava-test-runner /la=
va-11372124/1

    2023-08-28T13:39:28.514687  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-28T13:39:28.515172  + cd /lava-11372124/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64eca46c1b7ba83fde286d6c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-rt2/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-p=
ine-h64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-rt2/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-p=
ine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64eca46c1b7ba83fde286=
d6d
        new failure (last pass: v6.1.45-cip3-31-gbae6b8e9a2cff) =

 =20

