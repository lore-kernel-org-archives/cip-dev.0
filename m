Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958CBCD80A3
	for <webhook@archiver.kernel.org>; Tue, 10 Oct 2023 11:07:07 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web10.88694.1696936025552602077
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 10 Oct 2023 04:07:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=UjRa6dZu;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.180, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1c88b467ef8so33721095ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 10 Oct 2023 04:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696936024; x=1697540824; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=S39fQcZzk2bJmeCoRYX+/n9N8WEl+zqj6MFT+z6sGnA=;
        b=UjRa6dZu7OmZOb+Rl9sso0IFye24QJpZwWY85N6PQHtblOxx6bkF4Cm4uNq7L4gvMu
         yZso2OP+YGHr2Qk0mD1tTuZmAMdv9306DHN4+do51oCh/AokJElQIK4ZWmOf4bPXIf+f
         K7tcvrmWV2gs2NB+YvhzQTala2ygygihY57yowN9VEHTRuDyjhA6ewjcxcVI0t4nL1qB
         Ww1K6OJd1psExN8C5UEv+McnLjNTFbj/1Cy0qpuKH/EYcePuFvYqCPA2L737iEbGpkwq
         fmYtRHQVXrQL0gl70q56goUCKZAV5P4AzBOv1p1SAAbRnq7gYwZVW+aWnhvCACBpYG2g
         gH/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696936024; x=1697540824;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S39fQcZzk2bJmeCoRYX+/n9N8WEl+zqj6MFT+z6sGnA=;
        b=i2UjTXxM16rsoGSJ+VygWaKLUh8NrrZLInYr/sawd2tjZJlB0PoJOysVkGHm7voa+g
         MtIFCZqVGBImUc+HyTUarPSAlPKrMavtBOLvABQHRG9NuYUI9pL3IBV47XOcZ10vXKwp
         TSgu+YZLloZINmqvMgPDNv6FK3+cr/KLB6qaz7SVMG4VjKKX6bDhljIhik3CMex/DunE
         k0CWJYjhAvasPI0/pxmkILvUGMlDszeTqSlITzxQmFgPHcfonVJSv9qw9lvwFiciX++Z
         ZWv9SzdnlXLvBPlP6feYThtOFVOwymqj7sERUA0bVlYgngWi17gI8DG4Q3Tqs31AsCd5
         RZkQ==
X-Gm-Message-State: AOJu0YzP/AHU9BhL4cEAhFXyD5YlxlZ3TSQnAqis5BI/TwnrBUhz0dOW
	sEv+7hu3yeYxFDAWFWozqLy6wAzcSmF/5TRHNSPItQ==
X-Google-Smtp-Source: AGHT+IHkilXafODZkoiYcoPsFlp+y2HmsL3PzAa8bpbbEEBO6hrelchdL3XcXN9kpkzoh/gjDODbxw==
X-Received: by 2002:a17:90a:1a16:b0:27b:348a:c5a9 with SMTP id 22-20020a17090a1a1600b0027b348ac5a9mr8123004pjk.12.1696936022890;
        Tue, 10 Oct 2023 04:07:02 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 30-20020a17090a191e00b002792b7182dcsm12852987pjg.49.2023.10.10.04.07.01
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 04:07:02 -0700 (PDT)
Message-ID: <65253056.170a0220.20b10.3a74@mx.google.com>
Date: Tue, 10 Oct 2023 04:07:02 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.194-cip39-552-gc89b2c57483f0
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test baseline: 121 runs,
 78 regressions (v5.10.194-cip39-552-gc89b2c57483f0)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Oct 2023 11:07:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13350

cip-gitlab/ci/pavel/linux-test baseline: 121 runs, 78 regressions (v5.10.19=
4-cip39-552-gc89b2c57483f0)

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
v5_defconfig           | 2          =

bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | bcm283=
5_defconfig            | 1          =

bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 7          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig           | 7          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =

fsl-ls1028a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

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

imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =

juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 10         =

kontron-kbox-a-230-ls        | arm64  | lab-kontron     | gcc-10   | defcon=
fig                    | 3          =

kontron-sl28-var3-ads2       | arm64  | lab-kontron     | gcc-10   | defcon=
fig                    | 3          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

mt8173-elm-hana              | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

qemu_mips-malta              | mips   | lab-broonie     | gcc-10   | malta_=
defconfig              | 1          =

qemu_mips-malta              | mips   | lab-collabora   | gcc-10   | malta_=
defconfig              | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =

r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =

r8a77960-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 5          =

rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =

rk3399-rock-pi-4b            | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 5          =

sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.194-cip39-552-gc89b2c57483f0/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.194-cip39-552-gc89b2c57483f0
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c89b2c57483f0aae7f9cb377230347592eb3520f =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cbv514-1h-34uz-brya     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/652522f3276629e57defcf32

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/baseline-acer-cbv514-1h-34uz-brya.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/baseline-acer-cbv514-1h-34uz-brya.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/652522f3276629e57defc=
f33
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | at91_d=
t_defconfig            | 3          =


  Details:     https://kernelci.org/test/plan/id/652523fd2faa71e8c4efcfe6

  Results:     49 PASS, 4 FAIL, 1 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm/at91_dt_defconfig/gcc-10/lab-brooni=
e/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm/at91_dt_defconfig/gcc-10/lab-brooni=
e/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.gpio-keys-probed: https://kernelci.org/test/case/id/652=
523fd2faa71e8c4efcfef
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:14:02.097495  /lava-160386/1/../bin/lava-test-case
    2023-10-10T10:14:02.135646  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dgpi=
o-keys-probed RESULT=3Dfail>   =


  * baseline.bootrr.wm8731-driver-present: https://kernelci.org/test/case/i=
d/652523fd2faa71e8c4efcff9
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:13:57.886777  /lava-160386/1/../bin/lava-test-case
    2023-10-10T10:13:57.925034  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Deep=
rom-probed RESULT=3Dblocked>
    2023-10-10T10:13:57.967528  sh: /sys/bus/spi/drivers/wm8731: unknown op=
erand
    2023-10-10T10:13:58.988417  /lava-160386/1/../bin/lava-test-case
    2023-10-10T10:13:59.027010  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dwm8=
731-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.at24-driver-present: https://kernelci.org/test/case/id/=
652523fd2faa71e8c4efcffa
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:13:56.785208  /lava-160386/1/../bin/lava-test-case
    2023-10-10T10:13:56.824016  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dat2=
4-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig           | 2          =


  Details:     https://kernelci.org/test/plan/id/652525f12a126809cbefcefe

  Results:     47 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm/multi_v5_defconfig/gcc-10/lab-broon=
ie/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm/multi_v5_defconfig/gcc-10/lab-broon=
ie/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.gpio-keys-probed: https://kernelci.org/test/case/id/652=
525f22a126809cbefcf07
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:22:31.065536  /lava-160392/1/../bin/lava-test-case
    2023-10-10T10:22:31.103095  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dgpi=
o-keys-probed RESULT=3Dfail>   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652525f22a126809cbefcf34
        failing since 18 days (last pass: v5.10.194-cip39-500-gc5c4e5fc1681=
7, first fail: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-10T10:22:16.567221  + set +x
    2023-10-10T10:22:16.567747  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 160392_1.5.2=
.4.1>
    2023-10-10T10:22:16.681982  / # #
    2023-10-10T10:22:16.785009  export SHELL=3D/bin/sh
    2023-10-10T10:22:16.785780  #
    2023-10-10T10:22:16.887730  / # export SHELL=3D/bin/sh. /lava-160392/en=
vironment
    2023-10-10T10:22:16.888524  =

    2023-10-10T10:22:16.990468  / # . /lava-160392/environment/lava-160392/=
bin/lava-test-runner /lava-160392/1
    2023-10-10T10:22:16.991774  =

    2023-10-10T10:22:16.995425  / # /lava-160392/bin/lava-test-runner /lava=
-160392/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | bcm283=
5_defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/652525e46170258e8aefcef7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm/bcm2835_defconfig/gcc-10/lab-collab=
ora/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm/bcm2835_defconfig/gcc-10/lab-collab=
ora/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652525e46170258e8aefcf00
        failing since 54 days (last pass: v4.19.288-cip101-1117-g1f3468542a=
a9e, first fail: v5.10.186-cip37-16-gf8567732a40d)

    2023-10-10T10:26:32.564517  / # #

    2023-10-10T10:26:32.666624  export SHELL=3D/bin/sh

    2023-10-10T10:26:32.667311  #

    2023-10-10T10:26:32.768683  / # export SHELL=3D/bin/sh. /lava-11723568/=
environment

    2023-10-10T10:26:32.769374  =


    2023-10-10T10:26:32.870819  / # . /lava-11723568/environment/lava-11723=
568/bin/lava-test-runner /lava-11723568/1

    2023-10-10T10:26:32.871915  =


    2023-10-10T10:26:32.888921  / # /lava-11723568/bin/lava-test-runner /la=
va-11723568/1

    2023-10-10T10:26:32.953094  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-10T10:26:32.991031  + cd /lava-11723568/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6525274ca85024b42defcf37

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm/multi_v7_defconfig/gcc-10/lab-colla=
bora/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm/multi_v7_defconfig/gcc-10/lab-colla=
bora/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525274ca85024b42defc=
f38
        failing since 54 days (last pass: v4.19.288-cip101-1117-g1f3468542a=
a9e, first fail: v5.10.186-cip37-16-gf8567732a40d) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 7          =


  Details:     https://kernelci.org/test/plan/id/6525275794dab110f2efcef4

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.hdmi-audio: https://kernelci.org/test/case/id/652527579=
4dab110f2efcefb
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:28:27.851404  /lava-160441/1/../bin/lava-test-case
    2023-10-10T10:28:27.886519  <8>[   46.975399] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/id/65=
25275794dab110f2efcefc
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:28:26.791046  /lava-160441/1/../bin/lava-test-case
    2023-10-10T10:28:26.825276  <8>[   45.914481] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-codec-driver-present: https://kernelci.org/test/ca=
se/id/6525275794dab110f2efcefe
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:28:24.619644  /lava-160441/1/../bin/lava-test-case
    2023-10-10T10:28:24.656727  <8>[   43.745129] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-10-10T10:28:25.682963  /lava-160441/1/../bin/lava-test-case
    2023-10-10T10:28:25.720203  <8>[   44.805802] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case/id/=
6525275794dab110f2efceff
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:28:22.494900  /lava-160441/1/../bin/lava-test-case
    2023-10-10T10:28:22.528997  <8>[   41.617057] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-10-10T10:28:23.555066  /lava-160441/1/../bin/lava-test-case
    2023-10-10T10:28:23.594007  <8>[   42.682178] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline.bootrr.tda19988-driver-present: https://kernelci.org/test/case=
/id/6525275794dab110f2efcf00
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:28:20.373610  /lava-160441/1/../bin/lava-test-case
    2023-10-10T10:28:20.406607  <8>[   39.496036] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-10-10T10:28:21.433298  /lava-160441/1/../bin/lava-test-case
    2023-10-10T10:28:21.469190  <8>[   40.556879] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/6525275794dab110f2efcf0c
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:28:08.439562  /lava-160441/1/../bin/lava-test-case
    2023-10-10T10:28:08.477285  <8>[   27.564034] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525275794dab110f2efcf23
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:28:02.703271  <8>[   21.790880] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 160441_1.5.2.4.1>
    2023-10-10T10:28:02.811970  / # #
    2023-10-10T10:28:02.914315  export SHELL=3D/bin/sh
    2023-10-10T10:28:02.914858  #
    2023-10-10T10:28:03.016502  / # export SHELL=3D/bin/sh. /lava-160441/en=
vironment
    2023-10-10T10:28:03.017111  =

    2023-10-10T10:28:03.119337  / # . /lava-160441/environment/lava-160441/=
bin/lava-test-runner /lava-160441/1
    2023-10-10T10:28:03.120528  =

    2023-10-10T10:28:03.125051  / # /lava-160441/bin/lava-test-runner /lava=
-160441/1
    2023-10-10T10:28:03.220786  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig           | 7          =


  Details:     https://kernelci.org/test/plan/id/65252f3a0595c434abefcefa

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm/multi_v7_defconfig/gcc-10/lab-cip/b=
aseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm/multi_v7_defconfig/gcc-10/lab-cip/b=
aseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65252f3a0595c434abefcf01
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:01:30.792761  + set +x
    2023-10-10T11:01:30.794815  <8>[   16.501707] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1018657_1.5.2.4.1>
    2023-10-10T11:01:30.903753  / # #
    2023-10-10T11:01:31.005604  export SHELL=3D/bin/sh
    2023-10-10T11:01:31.006055  #
    2023-10-10T11:01:31.107390  / # export SHELL=3D/bin/sh. /lava-1018657/e=
nvironment
    2023-10-10T11:01:31.107813  =

    2023-10-10T11:01:31.209197  / # . /lava-1018657/environment/lava-101865=
7/bin/lava-test-runner /lava-1018657/1
    2023-10-10T11:01:31.209919  =

    2023-10-10T11:01:31.212098  / # /lava-1018657/bin/lava-test-runner /lav=
a-1018657/1 =

    ... (12 line(s) more)  =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/65252f3a0595c434abefcf1a
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:01:36.528940  /lava-1018657/1/../bin/lava-test-case
    2023-10-10T11:01:36.567917  <8>[   22.273176] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.tda19988-driver-present: https://kernelci.org/test/case=
/id/65252f3a0595c434abefcf26
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:01:48.461307  /lava-1018657/1/../bin/lava-test-case
    2023-10-10T11:01:48.497223  <8>[   34.204168] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-10-10T11:01:49.524094  /lava-1018657/1/../bin/lava-test-case
    2023-10-10T11:01:49.559506  <8>[   35.265647] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case/id/=
65252f3a0595c434abefcf27
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:01:50.586402  /lava-1018657/1/../bin/lava-test-case
    2023-10-10T11:01:50.619564  <8>[   36.326224] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-10-10T11:01:51.646638  /lava-1018657/1/../bin/lava-test-case
    2023-10-10T11:01:51.679891  <8>[   37.386489] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-codec-driver-present: https://kernelci.org/test/ca=
se/id/65252f3a0595c434abefcf28
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:01:52.706767  /lava-1018657/1/../bin/lava-test-case
    2023-10-10T11:01:52.740565  <8>[   38.447347] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-10-10T11:01:53.766877  /lava-1018657/1/../bin/lava-test-case
    2023-10-10T11:01:53.805942  <8>[   39.512141] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/id/65=
252f3a0595c434abefcf2a
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:01:54.879262  /lava-1018657/1/../bin/lava-test-case
    2023-10-10T11:01:54.916152  <8>[   40.623063] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-audio: https://kernelci.org/test/case/id/65252f3a0=
595c434abefcf2b
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:01:55.941512  /lava-1018657/1/../bin/lava-test-case
    2023-10-10T11:01:55.976579  <8>[   41.684200] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/652523abfcb46bd657efcf27

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm/omap2plus_defconfig/gcc-10/lab-broo=
nie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm/omap2plus_defconfig/gcc-10/lab-broo=
nie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/id/6=
52523abfcb46bd657efcf46
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:12:35.191420  /lava-160377/1/../bin/lava-test-case
    2023-10-10T10:12:35.232884  <8>[   24.393947] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/65252422e9ff3b8ce3efcef3

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm/omap2plus_defconfig/gcc-10/lab-cip/=
baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm/omap2plus_defconfig/gcc-10/lab-cip/=
baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/id/6=
5252422e9ff3b8ce3efcf15
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:14:50.491250  /lava-1018628/1/../bin/lava-test-case
    2023-10-10T10:14:50.533412  <8>[   17.832375] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls1028a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/652527ae22ef2fb8d8efcf4d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig/gcc-10/lab-nxp/baseline=
-fsl-ls1028a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig/gcc-10/lab-nxp/baseline=
-fsl-ls1028a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652527ae22ef2fb8d8efcf54
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:29:49.041580  [   21.449795] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1253976_1.5.2.4.1>
    2023-10-10T10:29:49.146815  =

    2023-10-10T10:29:49.247979  / # #export SHELL=3D/bin/sh
    2023-10-10T10:29:49.248385  =

    2023-10-10T10:29:49.349342  / # export SHELL=3D/bin/sh. /lava-1253976/e=
nvironment
    2023-10-10T10:29:49.349747  =

    2023-10-10T10:29:49.450717  / # . /lava-1253976/environment/lava-125397=
6/bin/lava-test-runner /lava-1253976/1
    2023-10-10T10:29:49.451454  =

    2023-10-10T10:29:49.455585  / # /lava-1253976/bin/lava-test-runner /lav=
a-1253976/1
    2023-10-10T10:29:49.474478  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/652521f9f0468cca3cefcf2f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652521f9f0468cca3cefcf38
        failing since 54 days (last pass: v4.19.288-cip101-1117-g1f3468542a=
a9e, first fail: v5.10.186-cip37-16-gf8567732a40d)

    2023-10-10T10:05:26.031450  <8>[   12.713956] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11723406_1.4.2.3.1>

    2023-10-10T10:05:26.034217  + set +x

    2023-10-10T10:05:26.135559  #

    2023-10-10T10:05:26.135869  =


    2023-10-10T10:05:26.236498  / # #export SHELL=3D/bin/sh

    2023-10-10T10:05:26.236706  =


    2023-10-10T10:05:26.337252  / # export SHELL=3D/bin/sh. /lava-11723406/=
environment

    2023-10-10T10:05:26.337474  =


    2023-10-10T10:05:26.438051  / # . /lava-11723406/environment/lava-11723=
406/bin/lava-test-runner /lava-11723406/1

    2023-10-10T10:05:26.438373  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/652528219fddd43e00efd058

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm/imx_v6_v7_defconfig/gcc-10/lab-broo=
nie/baseline-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm/imx_v6_v7_defconfig/gcc-10/lab-broo=
nie/baseline-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/652528219fddd43e00efd=
059
        failing since 48 days (last pass: v4.4-st20-3262-g667bb8d8b2cb, fir=
st fail: v6.1.45-cip3-31-gbae6b8e9a2cff) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65252974435e097677efcf0f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65252974435e097677efc=
f10
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6525281f9fddd43e00efd04b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm/imx_v6_v7_defconfig/gcc-10/lab-broo=
nie/baseline-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm/imx_v6_v7_defconfig/gcc-10/lab-broo=
nie/baseline-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525281f9fddd43e00efd=
04c
        failing since 48 days (last pass: v4.4-st20-3262-g667bb8d8b2cb, fir=
st fail: v6.1.45-cip3-31-gbae6b8e9a2cff) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6525298cf1c76fbc9cefcef3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525298cf1c76fbc9cefc=
ef4
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/652526eb32e086b27eefcf1f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm/imx_v6_v7_defconfig/gcc-10/lab-peng=
utronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm/imx_v6_v7_defconfig/gcc-10/lab-peng=
utronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652526eb32e086b27eefcf28
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:26:44.393138  + set +x
    2023-10-10T10:26:44.393309  [   10.432904] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1002881_1.5.2.3.1>
    2023-10-10T10:26:44.502065  / # #
    2023-10-10T10:26:44.603670  export SHELL=3D/bin/sh
    2023-10-10T10:26:44.604136  #
    2023-10-10T10:26:44.705417  / # export SHELL=3D/bin/sh. /lava-1002881/e=
nvironment
    2023-10-10T10:26:44.705854  =

    2023-10-10T10:26:44.807145  / # . /lava-1002881/environment/lava-100288=
1/bin/lava-test-runner /lava-1002881/1
    2023-10-10T10:26:44.807757  =

    2023-10-10T10:26:44.810467  / # /lava-1002881/bin/lava-test-runner /lav=
a-1002881/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/652527264c70ccecf1efcf53

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm/multi_v7_defconfig/gcc-10/lab-pengu=
tronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm/multi_v7_defconfig/gcc-10/lab-pengu=
tronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652527264c70ccecf1efcf5c
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:27:43.022516  + set[    7.138126] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 1002883_1.5.2.3.1>
    2023-10-10T10:27:43.022804   +x
    2023-10-10T10:27:43.128541  / # #
    2023-10-10T10:27:43.230301  export SHELL=3D/bin/sh
    2023-10-10T10:27:43.230817  #
    2023-10-10T10:27:43.332116  / # export SHELL=3D/bin/sh. /lava-1002883/e=
nvironment
    2023-10-10T10:27:43.332606  =

    2023-10-10T10:27:43.434129  / # . /lava-1002883/environment/lava-100288=
3/bin/lava-test-runner /lava-1002883/1
    2023-10-10T10:27:43.434948  =

    2023-10-10T10:27:43.437359  / # /lava-1002883/bin/lava-test-runner /lav=
a-1002883/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6525274aa8f676a1a9efcefe

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm/imx_v6_v7_defconfig/gcc-10/lab-nxp/=
baseline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm/imx_v6_v7_defconfig/gcc-10/lab-nxp/=
baseline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.all-cpus-are-online: https://kernelci.org/test/case/id/=
6525274aa8f676a1a9efcf06
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:28:18.798526  /lava-1253971/1/../bin/lava-test-case
    2023-10-10T10:28:18.835559  <8>[   33.878681] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dall-cpus-are-online RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65252736a85024b42defcf0c

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm/multi_v7_defconfig/gcc-10/lab-nxp/b=
aseline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm/multi_v7_defconfig/gcc-10/lab-nxp/b=
aseline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.all-cpus-are-online: https://kernelci.org/test/case/id/=
65252736a85024b42defcf14
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:27:57.775853  /lava-1253974/1/../bin/lava-test-case
    2023-10-10T10:27:57.796869  <8>[   24.874538] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dall-cpus-are-online RESULT=3Dfail>
    2023-10-10T10:27:57.797174  /lava-1253974/1/../bin/lava-test-case   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 10         =


  Details:     https://kernelci.org/test/plan/id/652528361840410264efcef5

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig/gcc-10/lab-broonie/base=
line-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig/gcc-10/lab-broonie/base=
line-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.led7-probed: https://kernelci.org/test/case/id/65252836=
1840410264efcf06
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:32:00.723769  /lava-160453/1/../bin/lava-test-case
    2023-10-10T10:32:00.745834  <8>[   40.525955] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled7-probed RESULT=3Dfail>
    2023-10-10T10:32:00.746358  /lava-160453/1/../bin/lava-test-case   =


  * baseline.bootrr.led6-probed: https://kernelci.org/test/case/id/65252836=
1840410264efcf07
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:31:59.693722  /lava-160453/1/../bin/lava-test-case
    2023-10-10T10:31:59.716771  <8>[   39.496143] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled6-probed RESULT=3Dfail>   =


  * baseline.bootrr.led5-probed: https://kernelci.org/test/case/id/65252836=
1840410264efcf08
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:31:58.663672  /lava-160453/1/../bin/lava-test-case
    2023-10-10T10:31:58.686683  <8>[   38.466439] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled5-probed RESULT=3Dfail>   =


  * baseline.bootrr.led4-probed: https://kernelci.org/test/case/id/65252836=
1840410264efcf09
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:31:57.635538  /lava-160453/1/../bin/lava-test-case
    2023-10-10T10:31:57.656531  <8>[   37.436783] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled4-probed RESULT=3Dfail>   =


  * baseline.bootrr.led3-probed: https://kernelci.org/test/case/id/65252836=
1840410264efcf0a
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:31:56.606507  /lava-160453/1/../bin/lava-test-case
    2023-10-10T10:31:56.628425  <8>[   36.408752] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled3-probed RESULT=3Dfail>   =


  * baseline.bootrr.led2-probed: https://kernelci.org/test/case/id/65252836=
1840410264efcf0b
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:31:55.576353  /lava-160453/1/../bin/lava-test-case
    2023-10-10T10:31:55.599288  <8>[   35.378939] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled2-probed RESULT=3Dfail>   =


  * baseline.bootrr.led1-probed: https://kernelci.org/test/case/id/65252836=
1840410264efcf0c
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:31:54.547301  /lava-160453/1/../bin/lava-test-case
    2023-10-10T10:31:54.569338  <8>[   34.349244] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled1-probed RESULT=3Dfail>   =


  * baseline.bootrr.led0-probed: https://kernelci.org/test/case/id/65252836=
1840410264efcf0d
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:31:53.518164  /lava-160453/1/../bin/lava-test-case
    2023-10-10T10:31:53.540212  <8>[   33.319936] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled0-probed RESULT=3Dfail>   =


  * baseline.bootrr.iommu1-probed: https://kernelci.org/test/case/id/652528=
361840410264efcf20
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:31:52.056524  /lava-160453/1/../bin/lava-test-case
    2023-10-10T10:31:52.059781  <8>[   31.840859] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Diommu1-probed RESULT=3Dfail>   =


  * baseline.bootrr.1c050000_mmc-probed: https://kernelci.org/test/case/id/=
652528361840410264efcf2d
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:31:50.700931  /lava-160453/1/../bin/lava-test-case
    2023-10-10T10:31:50.722921  <8>[   30.502770] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3D1c050000.mmc-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
kontron-kbox-a-230-ls        | arm64  | lab-kontron     | gcc-10   | defcon=
fig                    | 3          =


  Details:     https://kernelci.org/test/plan/id/6525278358c85673a7efcefd

  Results:     89 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig/gcc-10/lab-kontron/base=
line-kontron-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig/gcc-10/lab-kontron/base=
line-kontron-kbox-a-230-ls.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rcpm-driver-present: https://kernelci.org/test/case/id/=
6525278358c85673a7efcf41
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:29:12.062762  /lava-384905/1/../bin/lava-test-case
    2023-10-10T10:29:12.065929  <8>[   16.004273] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.ftm-alarm-driver-present: https://kernelci.org/test/cas=
e/id/6525278358c85673a7efcf42
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:29:13.076523  /lava-384905/1/../bin/lava-test-case
    2023-10-10T10:29:13.079706  <8>[   17.023000] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2023-10-10T10:29:14.098801  /lava-384905/1/../bin/lava-test-case   =


  * baseline.bootrr.layerscape-sfp-driver-present: https://kernelci.org/tes=
t/case/id/6525278358c85673a7efcf59
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:29:16.518156  /lava-384905/1/../bin/lava-test-case
    2023-10-10T10:29:16.521369  <8>[   20.459849] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
kontron-sl28-var3-ads2       | arm64  | lab-kontron     | gcc-10   | defcon=
fig                    | 3          =


  Details:     https://kernelci.org/test/plan/id/6525278294dab110f2efcf58

  Results:     97 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig/gcc-10/lab-kontron/base=
line-kontron-sl28-var3-ads2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig/gcc-10/lab-kontron/base=
line-kontron-sl28-var3-ads2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rcpm-driver-present: https://kernelci.org/test/case/id/=
6525278294dab110f2efcfa3
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:29:07.658374  /lava-384904/1/../bin/lava-test-case
    2023-10-10T10:29:07.661672  <8>[   11.035819] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.ftm-alarm-driver-present: https://kernelci.org/test/cas=
e/id/6525278294dab110f2efcfa4
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:29:08.670979  /lava-384904/1/../bin/lava-test-case
    2023-10-10T10:29:08.674270  <8>[   12.053253] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2023-10-10T10:29:09.691501  /lava-384904/1/../bin/lava-test-case   =


  * baseline.bootrr.layerscape-sfp-driver-present: https://kernelci.org/tes=
t/case/id/6525278294dab110f2efcfb9
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:29:12.120014  /lava-384904/1/../bin/lava-test-case
    2023-10-10T10:29:12.123071  <8>[   15.498732] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6525228edef1686820efcf04

  Results:     51 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-broonie/baseline-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-broonie/baseline-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/6525228ed=
ef1686820efcf0b
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:08:01.724438  /lava-160358/1/../bin/lava-test-case
    2023-10-10T10:08:01.736739  <8>[   18.839193] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>
    2023-10-10T10:08:01.737358  + set +x   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6525287039139c5edeefcf12

  Results:     51 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig/gcc-10/lab-broonie/base=
line-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig/gcc-10/lab-broonie/base=
line-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/652528703=
9139c5edeefcf19
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:33:15.201533  /lava-160456/1/../bin/lava-test-case
    2023-10-10T10:33:15.213807  <8>[   19.003637] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>
    2023-10-10T10:33:15.214063  + set +x   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6525226f75b714efebefcf00

  Results:     28 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/baseline-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/baseline-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525226f75b714efebefcf20
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:09:04.553041  + set +x

    2023-10-10T10:09:04.561326  <8>[   15.628355] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11723442_1.5.2.3.1>

    2023-10-10T10:09:04.666580  #

    2023-10-10T10:09:04.666916  =


    2023-10-10T10:09:04.767548  / # #export SHELL=3D/bin/sh

    2023-10-10T10:09:04.767778  =


    2023-10-10T10:09:04.868274  / # export SHELL=3D/bin/sh. /lava-11723442/=
environment

    2023-10-10T10:09:04.868464  =


    2023-10-10T10:09:04.968992  / # . /lava-11723442/environment/lava-11723=
442/bin/lava-test-runner /lava-11723442/1

    2023-10-10T10:09:04.969364  =

 =

    ... (21 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_mips-malta              | mips   | lab-broonie     | gcc-10   | malta_=
defconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/652521d0ad8ee7cf2aefcef3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/mips/malta_defconfig/gcc-10/lab-broonie=
/baseline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/mips/malta_defconfig/gcc-10/lab-broonie=
/baseline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/652521d0ad8ee7cf2aefc=
ef4
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_mips-malta              | mips   | lab-collabora   | gcc-10   | malta_=
defconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/652521c35218222d78efcf09

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/mips/malta_defconfig/gcc-10/lab-collabo=
ra/baseline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/mips/malta_defconfig/gcc-10/lab-collabo=
ra/baseline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/652521c35218222d78efc=
f0a
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6525265232e086b27eefcef9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm/shmobile_defconfig/gcc-10/lab-cip/b=
aseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm/shmobile_defconfig/gcc-10/lab-cip/b=
aseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525265232e086b27eefc=
efa
        failing since 20 days (last pass: v6.1.52-cip5-29-g9fee06894d496, f=
irst fail: v5.10.194-cip39-500-gc5c4e5fc16817) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6525253adbc0192244efcef3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525253adbc0192244efcefa
        failing since 41 days (last pass: v6.1.46-cip4-rt2, first fail: v5.=
10.191-cip38-2-g05fb42f86d06a)

    2023-10-10T10:19:15.547557  + set +x
    2023-10-10T10:19:15.547664  <8>[   83.937925] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1018623_1.5.2.4.1>
    2023-10-10T10:19:15.653753  / # #
    2023-10-10T10:19:17.112934  export SHELL=3D/bin/sh
    2023-10-10T10:19:17.133351  #
    2023-10-10T10:19:17.133501  / # export SHELL=3D/bin/sh
    2023-10-10T10:19:19.085239  / # . /lava-1018623/environment
    2023-10-10T10:19:22.676659  /lava-1018623/bin/lava-test-runner /lava-10=
18623/1
    2023-10-10T10:19:22.697271  . /lava-1018623/environment
    2023-10-10T10:19:22.697389  / # /lava-1018623/bin/lava-test-runner /lav=
a-1018623/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/652529ebabda0af03aefcf51

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig/gcc-10/lab-cip/baseline=
-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig/gcc-10/lab-cip/baseline=
-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652529ebabda0af03aefcf58
        failing since 26 days (last pass: v4.19.288-cip101-1117-g1f3468542a=
a9e, first fail: v5.10.191-cip38-29-g9e1aa2001db86)

    2023-10-10T10:39:22.025056  + set +x
    2023-10-10T10:39:22.028404  <8>[   83.995140] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1018669_1.5.2.4.1>
    2023-10-10T10:39:22.136464  / # #
    2023-10-10T10:39:23.598413  export SHELL=3D/bin/sh
    2023-10-10T10:39:23.619043  #
    2023-10-10T10:39:23.619351  / # export SHELL=3D/bin/sh
    2023-10-10T10:39:25.574146  / # . /lava-1018669/environment
    2023-10-10T10:39:29.172741  /lava-1018669/bin/lava-test-runner /lava-10=
18669/1
    2023-10-10T10:39:29.193529  . /lava-1018669/environment
    2023-10-10T10:39:29.193700  / # /lava-1018669/bin/lava-test-runner /lav=
a-1018669/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/65252371abc1132d4eefcf21

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-cip/baseline-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-cip/baseline-r8a774b1-hihope-rzg2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65252371abc1132d4eefcf28
        failing since 54 days (last pass: v4.19.288-cip101-1117-g1f3468542a=
a9e, first fail: v5.10.186-cip37-16-gf8567732a40d)

    2023-10-10T10:11:33.738735  + set +x
    2023-10-10T10:11:33.738865  <8>[   84.142994] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1018616_1.5.2.4.1>
    2023-10-10T10:11:33.843916  / # #
    2023-10-10T10:11:35.303525  export SHELL=3D/bin/sh
    2023-10-10T10:11:35.324179  #
    2023-10-10T10:11:35.324385  / # export SHELL=3D/bin/sh
    2023-10-10T10:11:37.285712  / # . /lava-1018616/environment
    2023-10-10T10:11:40.878346  /lava-1018616/bin/lava-test-runner /lava-10=
18616/1
    2023-10-10T10:11:40.899145  . /lava-1018616/environment
    2023-10-10T10:11:40.899275  / # /lava-1018616/bin/lava-test-runner /lav=
a-1018616/1 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/65252385fcb46bd657efcef4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65252385fcb46bd657efcefb
        failing since 18 days (last pass: v5.10.194-cip39-500-gc5c4e5fc1681=
7, first fail: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-10T10:12:01.408527  / # #
    2023-10-10T10:12:02.867990  export SHELL=3D/bin/sh
    2023-10-10T10:12:02.888575  #
    2023-10-10T10:12:02.888787  / # export SHELL=3D/bin/sh
    2023-10-10T10:12:04.859856  / # . /lava-1018609/environment
    2023-10-10T10:12:08.456535  /lava-1018609/bin/lava-test-runner /lava-10=
18609/1
    2023-10-10T10:12:08.478090  . /lava-1018609/environment
    2023-10-10T10:12:08.478195  / # /lava-1018609/bin/lava-test-runner /lav=
a-1018609/1
    2023-10-10T10:12:08.558143  + export 'TESTRUN_ID=3D1_bootrr'
    2023-10-10T10:12:08.558337  + cd /lava-1018609/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/65252885d247fbafeeefcf16

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig/gcc-10/lab-cip/baseline=
-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig/gcc-10/lab-cip/baseline=
-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65252885d247fbafeeefcf1d
        failing since 18 days (last pass: v5.10.194-cip39-500-gc5c4e5fc1681=
7, first fail: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-10T10:33:10.325684  / # #
    2023-10-10T10:33:11.785093  export SHELL=3D/bin/sh
    2023-10-10T10:33:11.805638  #
    2023-10-10T10:33:11.805800  / # export SHELL=3D/bin/sh
    2023-10-10T10:33:13.757625  / # . /lava-1018674/environment
    2023-10-10T10:33:17.349596  /lava-1018674/bin/lava-test-runner /lava-10=
18674/1
    2023-10-10T10:33:17.370249  . /lava-1018674/environment
    2023-10-10T10:33:17.370365  / # /lava-1018674/bin/lava-test-runner /lav=
a-1018674/1
    2023-10-10T10:33:17.449407  + export 'TESTRUN_ID=3D1_bootrr'
    2023-10-10T10:33:17.449531  + cd /lava-1018674/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6525278858c85673a7efcf60

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig/gcc-10/lab-collabora/ba=
seline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig/gcc-10/lab-collabora/ba=
seline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525278858c85673a7efcf69
        failing since 82 days (last pass: v6.1.31-65-geef5a19d48f6, first f=
ail: v5.10.186-cip37-2-gfcd111609480)

    2023-10-10T10:33:26.370269  / # #

    2023-10-10T10:33:26.470850  export SHELL=3D/bin/sh

    2023-10-10T10:33:26.470979  #

    2023-10-10T10:33:26.571469  / # export SHELL=3D/bin/sh. /lava-11723632/=
environment

    2023-10-10T10:33:26.571591  =


    2023-10-10T10:33:26.672099  / # . /lava-11723632/environment/lava-11723=
632/bin/lava-test-runner /lava-11723632/1

    2023-10-10T10:33:26.672291  =


    2023-10-10T10:33:26.683837  / # /lava-11723632/bin/lava-test-runner /la=
va-11723632/1

    2023-10-10T10:33:26.727845  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-10T10:33:26.743046  + cd /lav<8>[   16.384410] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11723632_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 5          =


  Details:     https://kernelci.org/test/plan/id/652527114c70ccecf1efcf02

  Results:     63 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm/multi_v7_defconfig/gcc-10/lab-colla=
bora/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm/multi_v7_defconfig/gcc-10/lab-colla=
bora/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-iodomain-grf-probed: https://kernelci.org/test=
/case/id/652527114c70ccecf1efcf1c
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:31:40.965831  <8>[   21.425988] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-iodomain-driver-present RESULT=3Dpass>

    2023-10-10T10:31:41.976471  /lava-11723613/1/../bin/lava-test-case
   =


  * baseline.bootrr.dwmmc_rockchip-sdio0-probed: https://kernelci.org/test/=
case/id/652527124c70ccecf1efcf32
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:31:39.554042  <8>[   20.014201] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwmmc_rockchip-sdmmc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.dwmmc_rockchip-sdmmc-probed: https://kernelci.org/test/=
case/id/652527124c70ccecf1efcf33
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:31:38.532659  	-w	P<8>[   18.989459] <LAVA_SIGNAL_TESTCAS=
E TEST_CASE_ID=3Ddwmmc_rockchip-driver-present RESULT=3Dpass>

    2023-10-10T10:31:38.535587  ad to last with leading zeros

    2023-10-10T10:31:38.538093  	-s SEP	String separator

    2023-10-10T10:31:38.541924  /lava-11723613/1/../bin/lava-test-case

    2023-10-10T10:31:38.547895  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.

    2023-10-10T10:31:38.548124  =


    2023-10-10T10:31:38.552569  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-10-10T10:31:38.552793  =


    2023-10-10T10:31:38.557807  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-10-10T10:31:38.560293  FIRST, INC default to 1.
 =

    ... (6 line(s) more)  =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/652527124c70ccecf1efcf36
        failing since 262 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-10-10T10:31:38.459955  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC)<8=
>[   18.919780] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-10-10T10:31:38.461831   multi-call binary.

    2023-10-10T10:31:38.462050  =


    2023-10-10T10:31:38.466316  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-10-10T10:31:38.466535  =


    2023-10-10T10:31:38.471669  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-10-10T10:31:38.481988  FIRST,<8>[   18.938776] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/652527124c70ccecf1efcf37
        failing since 262 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6525229b16f9194cbcefcf7a

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/6525229b16f9194cbcefcf84
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:08:14.164493  <8>[   32.463783] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-10-10T10:08:15.189790  /lava-11723456/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/6525229b16f9194cbcefcf85
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:08:14.153167  /lava-11723456/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/652527ad22ef2fb8d8efcf36

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig/gcc-10/lab-collabora/ba=
seline-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig/gcc-10/lab-collabora/ba=
seline-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652527ad22ef2fb8d8efcf3f
        failing since 20 days (last pass: v5.10.191-cip38-29-g9e1aa2001db86=
, first fail: v5.10.194-cip39-500-gc5c4e5fc16817)

    2023-10-10T10:32:03.545094  / # #

    2023-10-10T10:32:04.806396  export SHELL=3D/bin/sh

    2023-10-10T10:32:04.817425  #

    2023-10-10T10:32:04.817894  / # export SHELL=3D/bin/sh

    2023-10-10T10:32:06.561912  / # . /lava-11723641/environment

    2023-10-10T10:32:09.767727  /lava-11723641/bin/lava-test-runner /lava-1=
1723641/1

    2023-10-10T10:32:09.779148  . /lava-11723641/environment

    2023-10-10T10:32:09.779553  / # /lava-11723641/bin/lava-test-runner /la=
va-11723641/1

    2023-10-10T10:32:09.834719  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-10T10:32:09.835208  + cd /lava-11723641/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 5          =


  Details:     https://kernelci.org/test/plan/id/6525279358c85673a7efcf7b

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig/gcc-10/lab-broonie/base=
line-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig/gcc-10/lab-broonie/base=
line-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/652527935=
8c85673a7efcf95
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:29:21.538929  /lava-160451/1/../bin/lava-test-case
    2023-10-10T10:29:21.549671  <8>[   25.543969] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Di2s-probed RESULT=3Dblocked>
    2023-10-10T10:29:22.574903  /lava-160451/1/../bin/lava-test-case
    2023-10-10T10:29:22.585628  <8>[   26.579535] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>   =


  * baseline.bootrr.sun4i-i2s-driver-present: https://kernelci.org/test/cas=
e/id/6525279358c85673a7efcf96
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:29:19.466394  /lava-160451/1/../bin/lava-test-case
    2023-10-10T10:29:19.477984  <8>[   23.470989] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcodec-digital-probed RESULT=3Dblocked>
    2023-10-10T10:29:20.502501  /lava-160451/1/../bin/lava-test-case
    2023-10-10T10:29:20.514737  <8>[   24.507728] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun4i-i2s-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sun8i-codec-driver-present: https://kernelci.org/test/c=
ase/id/6525279358c85673a7efcf97
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:29:17.391754  /lava-160451/1/../bin/lava-test-case
    2023-10-10T10:29:17.403595  <8>[   21.396726] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcodec-analog-probed RESULT=3Dblocked>
    2023-10-10T10:29:18.428816  /lava-160451/1/../bin/lava-test-case
    2023-10-10T10:29:18.439797  <8>[   22.433835] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8i-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525279358c85673a7efcfa9
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:29:13.199729  + set +x
    2023-10-10T10:29:13.204023  <8>[   17.198969] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 160451_1.5.2.4.1>
    2023-10-10T10:29:13.313023  / # #
    2023-10-10T10:29:13.415156  export SHELL=3D/bin/sh
    2023-10-10T10:29:13.415555  #
    2023-10-10T10:29:13.516977  / # export SHELL=3D/bin/sh. /lava-160451/en=
vironment
    2023-10-10T10:29:13.517316  =

    2023-10-10T10:29:13.618577  / # . /lava-160451/environment/lava-160451/=
bin/lava-test-runner /lava-160451/1
    2023-10-10T10:29:13.619998  =

    2023-10-10T10:29:13.623672  / # /lava-160451/bin/lava-test-runner /lava=
-160451/1 =

    ... (12 line(s) more)  =


  * baseline.bootrr.sun50i-codec-analog-driver-present: https://kernelci.or=
g/test/case/id/6525279358c85673a7efcfaa
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:29:16.354027  /lava-160451/1/../bin/lava-test-case
    2023-10-10T10:29:16.366918  <8>[   20.359214] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun50i-codec-analog-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/652527958083f519afefcefd

  Results:     40 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig/gcc-10/lab-broonie/base=
line-sun50i-h5-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig/gcc-10/lab-broonie/base=
line-sun50i-h5-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.sun8-codec-analog-driver-present: https://kernelci.org/=
test/case/id/652527958083f519afefcf0c
        failing since 26 days (last pass: v6.1.46-cip4-14-gb994de8f45440, f=
irst fail: v5.10.191-cip38-29-g9e1aa2001db86)

    2023-10-10T10:29:34.330307  /lava-160458/1/../bin/lava-test-case
    2023-10-10T10:29:34.342694  <8>[   20.093001] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8-codec-analog-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6525236deaccb4ff59efcf0e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525236deaccb4ff59efc=
f0f
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/65252881d247fbafeeefcf11

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig/gcc-10/lab-cip/baseline=
-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig/gcc-10/lab-cip/baseline=
-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65252881d247fbafeeefc=
f12
        failing since 5 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff) =

 =20

