Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9EFCA553A
	for <webhook@archiver.kernel.org>; Wed, 13 Sep 2023 16:13:40 +0000 (UTC)
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
 by mx.groups.io with SMTP id smtpd.web10.966.1694621613226818287
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 13 Sep 2023 09:13:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=taXDM4u4;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.161.48, mailfrom: bot@kernelci.org)
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-573249e73f8so21598eaf.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 13 Sep 2023 09:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694621612; x=1695226412; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6R7lTRkuFA19JpeOa7CYPqVkOJxrmKesKBsUnEBnlg0=;
        b=taXDM4u4J3D+DLf25GlTUR7d9yytvOkIobiKOvosA+mk9XEIZkOvXxz0r4sskSsC8s
         ouq4LG1/gj1ljKtAZndyu9Kl/VZRJHZ79SJjulfaTwuix96npOOjYzmoCDRd0X4I4aIJ
         AALbUci9HJ2Pf5FEhjS0o/3wTTG7RFdb+1izVkbEEbnwmqk8Gqakb92kUUPBe/agd1hI
         hty92FMMEN2kDPuD+eIv+Pyb+svY/eKbFx3qp8mD+AfQPeKv4wHCo9nV839UzNEXNylJ
         GFQmcknrYzek4FAGKY3tTYdfhgGHk7j4QKD1EZzLLCj2dQnTrQIc6lq8jcBBsoSakQGK
         dGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694621612; x=1695226412;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6R7lTRkuFA19JpeOa7CYPqVkOJxrmKesKBsUnEBnlg0=;
        b=hzbKKnHUxeISlxIqxHj8KAUrw7KLZLb0a3vr8lEc9dSUn3RdGSEiWSOl6jPX+YsX5J
         zyiA/qgt4PSMqJLNazZcx2IWZiHTSP8Ow9ePEoHU4mpKFekzan1Zpn/0NZ0f2u704RNl
         RnZ7x0qFg/H0y9+Z89eecWNl0CicqXP2P/I1Tc3g9kRzk4V0Wt5JTTzc8psRVZxFGNUG
         aV53lHPI9fZwC0Zvp/dxJpIgNCZYuuxrqHbC+Smq7RSjwTDe7EEHzV3b43yetXBZlZOq
         mBbGhyQn8zicJlU0+O3WO9VsDy9MLu6zSaz8eIJl6D7WTz1odra7pYceIffEwIP/O5Ds
         Iarw==
X-Gm-Message-State: AOJu0YxVG7KYEeHASbWhdX23t2SsqzbMEObI3nAXohy9K9/T+1G78yq0
	dTgBbdyIVO7lZmXpBr0yf/VxxzRMVC9DNTwxVi4=
X-Google-Smtp-Source: AGHT+IFnhJwi3MmvhVILNWhPTU9z3GLW9rQjCco23xQ+MoPtLzrlSMXRPmZB2sN3ShZGIKkVkW86uw==
X-Received: by 2002:a05:6358:41a3:b0:139:b123:ae2 with SMTP id w35-20020a05635841a300b00139b1230ae2mr3029791rwc.22.1694621611386;
        Wed, 13 Sep 2023 09:13:31 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b17-20020a637151000000b0057403b0a02esm8620115pgn.27.2023.09.13.09.13.30
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 09:13:30 -0700 (PDT)
Message-ID: <6501dfaa.630a0220.28793.7366@mx.google.com>
Date: Wed, 13 Sep 2023 09:13:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.191-cip38-29-g9e1aa2001db86
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline: 85 runs,
 44 regressions (v5.10.191-cip38-29-g9e1aa2001db86)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Sep 2023 16:13:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13105

cip-gitlab/ci/pavel/linux-test baseline: 85 runs, 44 regressions (v5.10.191=
-cip38-29-g9e1aa2001db86)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cbv514-1h-34uz-brya     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | at91_d=
t_defconfig            | 3          =

at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig           | 1          =

bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | bcm283=
5_defconfig            | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =

fsl-ls1028a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

fsl-ls1088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 10         =

kontron-kbox-a-230-ls        | arm64  | lab-kontron     | gcc-10   | defcon=
fig                    | 3          =

kontron-sl28-var3-ads2       | arm64  | lab-kontron     | gcc-10   | defcon=
fig                    | 3          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

qemu_mips-malta              | mips   | lab-broonie     | gcc-10   | malta_=
defconfig              | 1          =

qemu_mips-malta              | mips   | lab-collabora   | gcc-10   | malta_=
defconfig              | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =

r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 5          =

sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.191-cip38-29-g9e1aa2001db86/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.191-cip38-29-g9e1aa2001db86
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      9e1aa2001db862da32812062860b8756cbc8890a =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cbv514-1h-34uz-brya     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6501d0812f9542cf958a0a6f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/baseline-acer-cbv514-1h-34uz-brya.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/baseline-acer-cbv514-1h-34uz-brya.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6501d0812f9542cf958a0=
a70
        new failure (last pass: v6.1.46-cip4-14-gb994de8f45440) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | at91_d=
t_defconfig            | 3          =


  Details:     https://kernelci.org/test/plan/id/6501cf6b7ebe6da3d48a0a50

  Results:     49 PASS, 4 FAIL, 1 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/arm/at91_dt_defconfig/gcc-10/lab-broonie=
/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/arm/at91_dt_defconfig/gcc-10/lab-broonie=
/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.gpio-keys-probed: https://kernelci.org/test/case/id/650=
1cf6b7ebe6da3d48a0a59
        new failure (last pass: v6.1.46-cip4-14-gb994de8f45440)

    2023-09-13T15:04:07.370150  /lava-105151/1/../bin/lava-test-case
    2023-09-13T15:04:07.408274  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dgpi=
o-keys-probed RESULT=3Dfail>   =


  * baseline.bootrr.wm8731-driver-present: https://kernelci.org/test/case/i=
d/6501cf6b7ebe6da3d48a0a64
        new failure (last pass: v6.1.46-cip4-14-gb994de8f45440)

    2023-09-13T15:04:03.174941  /lava-105151/1/../bin/lava-test-case
    2023-09-13T15:04:03.212991  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Deep=
rom-probed RESULT=3Dblocked>
    2023-09-13T15:04:03.254666  sh: /sys/bus/spi/drivers/wm8731: unknown op=
erand
    2023-09-13T15:04:04.268623  /lava-105151/1/../bin/lava-test-case
    2023-09-13T15:04:04.307247  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dwm8=
731-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.at24-driver-present: https://kernelci.org/test/case/id/=
6501cf6b7ebe6da3d48a0a65
        new failure (last pass: v6.1.46-cip4-14-gb994de8f45440)

    2023-09-13T15:04:02.073389  /lava-105151/1/../bin/lava-test-case
    2023-09-13T15:04:02.112154  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dat2=
4-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6501d2ef1ef1ee992f8a0a59

  Results:     47 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/arm/multi_v5_defconfig/gcc-10/lab-brooni=
e/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/arm/multi_v5_defconfig/gcc-10/lab-brooni=
e/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.gpio-keys-probed: https://kernelci.org/test/case/id/650=
1d2ef1ef1ee992f8a0a62
        new failure (last pass: v6.1.46-cip4-14-gb994de8f45440)

    2023-09-13T15:18:48.476036  /lava-105164/1/../bin/lava-test-case
    2023-09-13T15:18:48.514122  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dgpi=
o-keys-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | bcm283=
5_defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/6501d1cdea5f54aa8a8a0a8e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/arm/bcm2835_defconfig/gcc-10/lab-collabo=
ra/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/arm/bcm2835_defconfig/gcc-10/lab-collabo=
ra/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501d1cdea5f54aa8a8a0a97
        failing since 28 days (last pass: v4.19.288-cip101-1117-g1f3468542a=
a9e, first fail: v5.10.186-cip37-16-gf8567732a40d)

    2023-09-13T15:18:23.848432  / # #

    2023-09-13T15:18:23.950607  export SHELL=3D/bin/sh

    2023-09-13T15:18:23.951318  #

    2023-09-13T15:18:24.052762  / # export SHELL=3D/bin/sh. /lava-11516973/=
environment

    2023-09-13T15:18:24.053461  =


    2023-09-13T15:18:24.154836  / # . /lava-11516973/environment/lava-11516=
973/bin/lava-test-runner /lava-11516973/1

    2023-09-13T15:18:24.156031  =


    2023-09-13T15:18:24.172689  / # /lava-11516973/bin/lava-test-runner /la=
va-11516973/1

    2023-09-13T15:18:24.236453  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-13T15:18:24.280296  + cd /lava-11516973/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6501d330880b1591e48a0a85

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/arm/omap2plus_defconfig/gcc-10/lab-broon=
ie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/arm/omap2plus_defconfig/gcc-10/lab-broon=
ie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/id/6=
501d330880b1591e48a0aa4
        new failure (last pass: v6.1.46-cip4-14-gb994de8f45440)

    2023-09-13T15:20:05.231291  /lava-105165/1/../bin/lava-test-case
    2023-09-13T15:20:05.270134  <8>[   25.104441] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6501d3213493b5b1718a0a53

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/arm/omap2plus_defconfig/gcc-10/lab-cip/b=
aseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/arm/omap2plus_defconfig/gcc-10/lab-cip/b=
aseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/id/6=
501d3213493b5b1718a0a75
        new failure (last pass: v6.1.46-cip4-14-gb994de8f45440)

    2023-09-13T15:19:53.072751  /lava-1008431/1/../bin/lava-test-case
    2023-09-13T15:19:53.102451  <8>[   18.160554] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls1028a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6501d3da1c6dccd9588a0a7d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/arm64/defconfig/gcc-10/lab-nxp/baseline-=
fsl-ls1028a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/arm64/defconfig/gcc-10/lab-nxp/baseline-=
fsl-ls1028a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501d3da1c6dccd9588a0a84
        new failure (last pass: v6.1.46-cip4-14-gb994de8f45440)

    2023-09-13T15:22:50.152010  [   24.379765] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1251191_1.5.2.4.1>
    2023-09-13T15:22:50.257240  =

    2023-09-13T15:22:50.358399  / # #export SHELL=3D/bin/sh
    2023-09-13T15:22:50.358801  =

    2023-09-13T15:22:50.459740  / # export SHELL=3D/bin/sh. /lava-1251191/e=
nvironment
    2023-09-13T15:22:50.460156  =

    2023-09-13T15:22:50.561132  / # . /lava-1251191/environment/lava-125119=
1/bin/lava-test-runner /lava-1251191/1
    2023-09-13T15:22:50.561816  =

    2023-09-13T15:22:50.565898  / # /lava-1251191/bin/lava-test-runner /lav=
a-1251191/1
    2023-09-13T15:22:50.586943  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls1088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6501d3d61c6dccd9588a0a72

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/arm64/defconfig/gcc-10/lab-nxp/baseline-=
fsl-ls1088a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/arm64/defconfig/gcc-10/lab-nxp/baseline-=
fsl-ls1088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501d3d61c6dccd9588a0a79
        failing since 28 days (last pass: v4.19.288-cip101-1117-g1f3468542a=
a9e, first fail: v5.10.186-cip37-16-gf8567732a40d)

    2023-09-13T15:22:38.316986  [    9.641735] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1251190_1.5.2.4.1>
    2023-09-13T15:22:38.422403  =

    2023-09-13T15:22:38.523640  / # #export SHELL=3D/bin/sh
    2023-09-13T15:22:38.524078  =

    2023-09-13T15:22:38.625038  / # export SHELL=3D/bin/sh. /lava-1251190/e=
nvironment
    2023-09-13T15:22:38.625466  =

    2023-09-13T15:22:38.726454  / # . /lava-1251190/environment/lava-125119=
0/bin/lava-test-runner /lava-1251190/1
    2023-09-13T15:22:38.727199  =

    2023-09-13T15:22:38.731221  / # /lava-1251190/bin/lava-test-runner /lav=
a-1251190/1
    2023-09-13T15:22:38.747390  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6501d13fd2adb2a1f08a0a54

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501d13fd2adb2a1f08a0a5d
        failing since 28 days (last pass: v4.19.288-cip101-1117-g1f3468542a=
a9e, first fail: v5.10.186-cip37-16-gf8567732a40d)

    2023-09-13T15:11:41.687404  <8>[   12.804435] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11516931_1.4.2.3.1>

    2023-09-13T15:11:41.690570  + set +x

    2023-09-13T15:11:41.798609  / # #

    2023-09-13T15:11:41.901254  export SHELL=3D/bin/sh

    2023-09-13T15:11:41.901990  #

    2023-09-13T15:11:42.003351  / # export SHELL=3D/bin/sh. /lava-11516931/=
environment

    2023-09-13T15:11:42.004080  =


    2023-09-13T15:11:42.105573  / # . /lava-11516931/environment/lava-11516=
931/bin/lava-test-runner /lava-11516931/1

    2023-09-13T15:11:42.106682  =


    2023-09-13T15:11:42.111789  / # /lava-11516931/bin/lava-test-runner /la=
va-11516931/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6501d04bb715d9485d8a0a7a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6501d04bb715d9485d8a0=
a7b
        failing since 21 days (last pass: v4.4-st20-3262-g667bb8d8b2cb, fir=
st fail: v6.1.45-cip3-31-gbae6b8e9a2cff) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6501d0732f9542cf958a0a5c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6501d0732f9542cf958a0=
a5d
        failing since 21 days (last pass: v4.4-st20-3262-g667bb8d8b2cb, fir=
st fail: v6.1.45-cip3-31-gbae6b8e9a2cff) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6501cd967564ea3aba8a0a58

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/arm/imx_v6_v7_defconfig/gcc-10/lab-pengu=
tronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/arm/imx_v6_v7_defconfig/gcc-10/lab-pengu=
tronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501cd967564ea3aba8a0a61
        new failure (last pass: v6.1.46-cip4-14-gb994de8f45440)

    2023-09-13T14:56:15.016520  + set +x
    2023-09-13T14:56:15.016726  [   10.317911] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1000364_1.5.2.3.1>
    2023-09-13T14:56:15.126622  / # #
    2023-09-13T14:56:15.228654  export SHELL=3D/bin/sh
    2023-09-13T14:56:15.229164  #
    2023-09-13T14:56:15.330471  / # export SHELL=3D/bin/sh. /lava-1000364/e=
nvironment
    2023-09-13T14:56:15.331003  =

    2023-09-13T14:56:15.432475  / # . /lava-1000364/environment/lava-100036=
4/bin/lava-test-runner /lava-1000364/1
    2023-09-13T14:56:15.433556  =

    2023-09-13T14:56:15.436204  / # /lava-1000364/bin/lava-test-runner /lav=
a-1000364/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6501cdfb5d4b57cc868a0a8b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/arm/imx_v6_v7_defconfig/gcc-10/lab-nxp/b=
aseline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/arm/imx_v6_v7_defconfig/gcc-10/lab-nxp/b=
aseline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.all-cpus-are-online: https://kernelci.org/test/case/id/=
6501cdfb5d4b57cc868a0a93
        new failure (last pass: v6.1.46-cip4-14-gb994de8f45440)

    2023-09-13T14:57:39.523552  /lava-1251189/1/../bin/lava-test-case
    2023-09-13T14:57:39.555545  <8>[   33.642011] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dall-cpus-are-online RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 10         =


  Details:     https://kernelci.org/test/plan/id/6501d430e3ae06dd768a0ac3

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.led7-probed: https://kernelci.org/test/case/id/6501d430=
e3ae06dd768a0ad4
        new failure (last pass: v6.1.46-cip4-14-gb994de8f45440)

    2023-09-13T15:24:19.282219  /lava-105182/1/../bin/lava-test-case
    2023-09-13T15:24:19.304254  <8>[   27.191536] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled7-probed RESULT=3Dfail>
    2023-09-13T15:24:19.304763  /lava-105182/1/../bin/lava-test-case   =


  * baseline.bootrr.led6-probed: https://kernelci.org/test/case/id/6501d430=
e3ae06dd768a0ad5
        new failure (last pass: v6.1.46-cip4-14-gb994de8f45440)

    2023-09-13T15:24:18.253315  /lava-105182/1/../bin/lava-test-case
    2023-09-13T15:24:18.275351  <8>[   26.162157] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled6-probed RESULT=3Dfail>   =


  * baseline.bootrr.led5-probed: https://kernelci.org/test/case/id/6501d430=
e3ae06dd768a0ad6
        new failure (last pass: v6.1.46-cip4-14-gb994de8f45440)

    2023-09-13T15:24:17.223448  /lava-105182/1/../bin/lava-test-case
    2023-09-13T15:24:17.246498  <8>[   25.133257] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled5-probed RESULT=3Dfail>   =


  * baseline.bootrr.led4-probed: https://kernelci.org/test/case/id/6501d430=
e3ae06dd768a0ad7
        new failure (last pass: v6.1.46-cip4-14-gb994de8f45440)

    2023-09-13T15:24:16.194553  /lava-105182/1/../bin/lava-test-case
    2023-09-13T15:24:16.216597  <8>[   24.104064] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled4-probed RESULT=3Dfail>   =


  * baseline.bootrr.led3-probed: https://kernelci.org/test/case/id/6501d430=
e3ae06dd768a0ad8
        new failure (last pass: v6.1.46-cip4-14-gb994de8f45440)

    2023-09-13T15:24:15.165745  /lava-105182/1/../bin/lava-test-case
    2023-09-13T15:24:15.187696  <8>[   23.074894] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled3-probed RESULT=3Dfail>   =


  * baseline.bootrr.led2-probed: https://kernelci.org/test/case/id/6501d430=
e3ae06dd768a0ad9
        new failure (last pass: v6.1.46-cip4-14-gb994de8f45440)

    2023-09-13T15:24:14.136788  /lava-105182/1/../bin/lava-test-case
    2023-09-13T15:24:14.158795  <8>[   22.045779] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled2-probed RESULT=3Dfail>   =


  * baseline.bootrr.led1-probed: https://kernelci.org/test/case/id/6501d430=
e3ae06dd768a0ada
        new failure (last pass: v6.1.46-cip4-14-gb994de8f45440)

    2023-09-13T15:24:13.107952  /lava-105182/1/../bin/lava-test-case
    2023-09-13T15:24:13.130056  <8>[   21.016814] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled1-probed RESULT=3Dfail>   =


  * baseline.bootrr.iommu1-probed: https://kernelci.org/test/case/id/6501d4=
30e3ae06dd768a0aec
        new failure (last pass: v6.1.46-cip4-14-gb994de8f45440)

    2023-09-13T15:24:10.159387  <6>[   18.035821] input: PS/2 Generic Mouse=
 as /devices/platform/bus@8000000/bus@8000000:motherboard-bus/bus@8000000:m=
otherboard-bus:iofpga-bus@300000000/1c070000.kmi/serio1/input/input4
    2023-09-13T15:24:10.271182  <4>[   18.161458] psmouse serio1: Failed to=
 enable mouse on 1c070000.kmi
    2023-09-13T15:24:10.618678  /lava-105182/1/../bin/lava-test-case
    2023-09-13T15:24:10.621916  <8>[   18.512545] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Diommu1-probed RESULT=3Dfail>   =


  * baseline.bootrr.1c050000_mmc-probed: https://kernelci.org/test/case/id/=
6501d430e3ae06dd768a0af9
        new failure (last pass: v6.1.46-cip4-14-gb994de8f45440)

    2023-09-13T15:24:09.268381  /lava-105182/1/../bin/lava-test-case
    2023-09-13T15:24:09.289384  <8>[   17.176153] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3D1c050000.mmc-probed RESULT=3Dfail>   =


  * baseline.bootrr.led0-probed: https://kernelci.org/test/case/id/6501d430=
e3ae06dd768a0b02
        new failure (last pass: v6.1.46-cip4-14-gb994de8f45440)

    2023-09-13T15:24:12.079112  /lava-105182/1/../bin/lava-test-case
    2023-09-13T15:24:12.101128  <8>[   19.988087] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled0-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
kontron-kbox-a-230-ls        | arm64  | lab-kontron     | gcc-10   | defcon=
fig                    | 3          =


  Details:     https://kernelci.org/test/plan/id/6501d38ad93bc604f28a0a42

  Results:     89 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-kontron-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-kontron-kbox-a-230-ls.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rcpm-driver-present: https://kernelci.org/test/case/id/=
6501d38ad93bc604f28a0a86
        new failure (last pass: v6.1.46-cip4-14-gb994de8f45440)

    2023-09-13T15:21:35.281358  /lava-379488/1/../bin/lava-test-case
    2023-09-13T15:21:35.284648  <8>[   14.771540] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.ftm-alarm-driver-present: https://kernelci.org/test/cas=
e/id/6501d38ad93bc604f28a0a87
        new failure (last pass: v6.1.46-cip4-14-gb994de8f45440)

    2023-09-13T15:21:36.298925  /lava-379488/1/../bin/lava-test-case
    2023-09-13T15:21:36.302174  <8>[   15.789021] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2023-09-13T15:21:37.322166  /lava-379488/1/../bin/lava-test-case   =


  * baseline.bootrr.layerscape-sfp-driver-present: https://kernelci.org/tes=
t/case/id/6501d38ad93bc604f28a0a9e
        new failure (last pass: v6.1.46-cip4-14-gb994de8f45440)

    2023-09-13T15:21:39.759808  /lava-379488/1/../bin/lava-test-case
    2023-09-13T15:21:39.763101  <8>[   19.244189] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
kontron-sl28-var3-ads2       | arm64  | lab-kontron     | gcc-10   | defcon=
fig                    | 3          =


  Details:     https://kernelci.org/test/plan/id/6501d38cd93bc604f28a0aa0

  Results:     97 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-kontron-sl28-var3-ads2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-kontron-sl28-var3-ads2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rcpm-driver-present: https://kernelci.org/test/case/id/=
6501d38cd93bc604f28a0aeb
        new failure (last pass: v6.1.46-cip4-14-gb994de8f45440)

    2023-09-13T15:21:33.222294  /lava-379489/1/../bin/lava-test-case
    2023-09-13T15:21:33.225493  <8>[   10.962585] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.ftm-alarm-driver-present: https://kernelci.org/test/cas=
e/id/6501d38cd93bc604f28a0aec
        new failure (last pass: v6.1.46-cip4-14-gb994de8f45440)

    2023-09-13T15:21:34.235026  /lava-379489/1/../bin/lava-test-case
    2023-09-13T15:21:34.238179  <8>[   11.980116] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2023-09-13T15:21:35.257702  /lava-379489/1/../bin/lava-test-case   =


  * baseline.bootrr.layerscape-sfp-driver-present: https://kernelci.org/tes=
t/case/id/6501d38cd93bc604f28a0b01
        new failure (last pass: v6.1.46-cip4-14-gb994de8f45440)

    2023-09-13T15:21:37.679433  /lava-379489/1/../bin/lava-test-case
    2023-09-13T15:21:37.682727  <8>[   15.419733] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6501d3b10c2f9fe2e68a0a67

  Results:     51 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/6501d3b10=
c2f9fe2e68a0a6e
        new failure (last pass: v6.1.46-cip4-14-gb994de8f45440)

    2023-09-13T15:22:16.028301  /lava-105177/1/../bin/lava-test-case
    2023-09-13T15:22:16.039573  <8>[   18.771681] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>
    2023-09-13T15:22:16.040082  + set +x   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_mips-malta              | mips   | lab-broonie     | gcc-10   | malta_=
defconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/6501cd21acd03d85ef8a0a48

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/mips/malta_defconfig/gcc-10/lab-broonie/=
baseline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/mips/malta_defconfig/gcc-10/lab-broonie/=
baseline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6501cd21acd03d85ef8a0=
a49
        new failure (last pass: v6.1.46-cip4-14-gb994de8f45440) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_mips-malta              | mips   | lab-collabora   | gcc-10   | malta_=
defconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/6501cd027e4adfc6c68a0a56

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/mips/malta_defconfig/gcc-10/lab-collabor=
a/baseline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/mips/malta_defconfig/gcc-10/lab-collabor=
a/baseline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6501cd027e4adfc6c68a0=
a57
        new failure (last pass: v6.1.46-cip4-14-gb994de8f45440) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6501d0492f9542cf958a0a44

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/arm/shmobile_defconfig/gcc-10/lab-cip/ba=
seline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/arm/shmobile_defconfig/gcc-10/lab-cip/ba=
seline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6501d0492f9542cf958a0=
a45
        failing since 7 days (last pass: v5.10.191-cip38-2-g05fb42f86d06a, =
first fail: v6.1.46-cip4-14-gb994de8f45440) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6501d411cfabd995dc8a0a42

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/arm64/defconfig/gcc-10/lab-cip/baseline-=
r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/arm64/defconfig/gcc-10/lab-cip/baseline-=
r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501d411cfabd995dc8a0a49
        new failure (last pass: v4.19.288-cip101-1117-g1f3468542aa9e)

    2023-09-13T15:23:40.103586  + set +x
    2023-09-13T15:23:40.106819  <8>[   84.012729] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1008438_1.5.2.4.1>
    2023-09-13T15:23:40.214318  / # #
    2023-09-13T15:23:41.678084  export SHELL=3D/bin/sh
    2023-09-13T15:23:41.699021  #
    2023-09-13T15:23:41.699475  / # export SHELL=3D/bin/sh
    2023-09-13T15:23:43.656420  / # . /lava-1008438/environment
    2023-09-13T15:23:47.256502  /lava-1008438/bin/lava-test-runner /lava-10=
08438/1
    2023-09-13T15:23:47.277986  . /lava-1008438/environment
    2023-09-13T15:23:47.278405  / # /lava-1008438/bin/lava-test-runner /lav=
a-1008438/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6501d45ae3ae06dd768a0b2c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/arm64/defconfig/gcc-10/lab-cip/baseline-=
r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/arm64/defconfig/gcc-10/lab-cip/baseline-=
r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501d45ae3ae06dd768a0b33
        failing since 7 days (last pass: v6.1.46-cip4-rt2, first fail: v6.1=
.46-cip4-14-gb994de8f45440)

    2023-09-13T15:25:01.939093  / # #
    2023-09-13T15:25:03.402652  export SHELL=3D/bin/sh
    2023-09-13T15:25:03.423280  #
    2023-09-13T15:25:03.423494  / # export SHELL=3D/bin/sh
    2023-09-13T15:25:05.380053  / # . /lava-1008440/environment
    2023-09-13T15:25:08.979880  /lava-1008440/bin/lava-test-runner /lava-10=
08440/1
    2023-09-13T15:25:09.000686  . /lava-1008440/environment
    2023-09-13T15:25:09.000800  / # /lava-1008440/bin/lava-test-runner /lav=
a-1008440/1
    2023-09-13T15:25:09.079082  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-13T15:25:09.079305  + cd /lava-1008440/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 5          =


  Details:     https://kernelci.org/test/plan/id/6501ddaa5f99479d8c8a0a56

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/6501ddaa5=
f99479d8c8a0a70
        new failure (last pass: v6.1.46-cip4-14-gb994de8f45440)

    2023-09-13T16:04:52.346137  /lava-105174/1/../bin/lava-test-case
    2023-09-13T16:04:52.357034  <8>[   25.424359] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Di2s-probed RESULT=3Dblocked>
    2023-09-13T16:04:53.371760  /lava-105174/1/../bin/lava-test-case
    2023-09-13T16:04:53.386848  <8>[   26.454562] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>   =


  * baseline.bootrr.sun4i-i2s-driver-present: https://kernelci.org/test/cas=
e/id/6501ddaa5f99479d8c8a0a71
        new failure (last pass: v6.1.46-cip4-14-gb994de8f45440)

    2023-09-13T16:04:50.267974  /lava-105174/1/../bin/lava-test-case
    2023-09-13T16:04:50.279692  <8>[   23.346298] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcodec-digital-probed RESULT=3Dblocked>
    2023-09-13T16:04:51.307014  /lava-105174/1/../bin/lava-test-case
    2023-09-13T16:04:51.318830  <8>[   24.385389] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun4i-i2s-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sun8i-codec-driver-present: https://kernelci.org/test/c=
ase/id/6501ddaa5f99479d8c8a0a72
        new failure (last pass: v6.1.46-cip4-14-gb994de8f45440)

    2023-09-13T16:04:48.191638  /lava-105174/1/../bin/lava-test-case
    2023-09-13T16:04:48.202836  <8>[   21.269982] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcodec-analog-probed RESULT=3Dblocked>
    2023-09-13T16:04:49.230313  /lava-105174/1/../bin/lava-test-case
    2023-09-13T16:04:49.242191  <8>[   22.308680] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8i-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sun50i-codec-analog-driver-present: https://kernelci.or=
g/test/case/id/6501ddaa5f99479d8c8a0a73
        new failure (last pass: v6.1.46-cip4-14-gb994de8f45440)

    2023-09-13T16:04:47.153192  /lava-105174/1/../bin/lava-test-case
    2023-09-13T16:04:47.165798  <8>[   20.231967] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun50i-codec-analog-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501ddaa5f99479d8c8a0a86
        new failure (last pass: v6.1.46-cip4-14-gb994de8f45440)

    2023-09-13T16:04:43.999144  + set +x
    2023-09-13T16:04:44.003162  <8>[   17.071891] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 105174_1.5.2.4.1>
    2023-09-13T16:04:44.115613  / # #
    2023-09-13T16:04:44.218695  export SHELL=3D/bin/sh
    2023-09-13T16:04:44.219538  #
    2023-09-13T16:04:44.322000  / # export SHELL=3D/bin/sh. /lava-105174/en=
vironment
    2023-09-13T16:04:44.322766  =

    2023-09-13T16:04:44.425288  / # . /lava-105174/environment/lava-105174/=
bin/lava-test-runner /lava-105174/1
    2023-09-13T16:04:44.426617  =

    2023-09-13T16:04:44.430842  / # /lava-105174/bin/lava-test-runner /lava=
-105174/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6501d3f811b04244678a0a49

  Results:     40 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-sun50i-h5-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-sun50i-h5-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.sun8-codec-analog-driver-present: https://kernelci.org/=
test/case/id/6501d3f811b04244678a0a58
        new failure (last pass: v6.1.46-cip4-14-gb994de8f45440)

    2023-09-13T15:23:32.235384  /lava-105178/1/../bin/lava-test-case
    2023-09-13T15:23:32.247632  <8>[   19.972462] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8-codec-analog-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6501d4b20870c9b8218a0a42

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/arm64/defconfig/gcc-10/lab-cip/baseline-=
zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/arm64/defconfig/gcc-10/lab-cip/baseline-=
zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6501d4b20870c9b8218a0=
a43
        new failure (last pass: v6.1.46-cip4-14-gb994de8f45440) =

 =20

