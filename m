Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7682DC41513
	for <webhook@archiver.kernel.org>; Wed, 16 Aug 2023 13:51:39 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web11.161037.1692193892466869092
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 16 Aug 2023 06:51:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=J0ebnHDy;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.178, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1bf078d5f33so731535ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 16 Aug 2023 06:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692193891; x=1692798691;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2x5EK9s1rVB+atMVBTB4mXJqfvVOUx/4Phob5t0DQ3E=;
        b=J0ebnHDymXZjqgVVkBL0fWXA5YvtlX9CFIjaYIVElX4NEmzBA8hLIlNCLfciIsUyS5
         9pwkmcaXcbrtdXt21BlPZE5GRiC1KIxKZ2YzBha/YABn+3ZXhY4oS7x0tH4A5pi9nBK+
         9s+BcX8JSkd18dDn9nHngfqU4JKacj5RboswRLj/sK4J2+khFINgicWy336LOd7+k/zL
         asFWnS+eDAgaudCzHn/vxfF3uw4BOvmDRx9uBernd7ZO1ECSwwbFQMUNYT/GQCBdpUkt
         9s5OGkDbTKspPF2VQGLPVCX/C6K2DMxM1aF+swzFGMJ98pfiyppI/8y6bzCeHErUXZO1
         oxGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692193891; x=1692798691;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2x5EK9s1rVB+atMVBTB4mXJqfvVOUx/4Phob5t0DQ3E=;
        b=kVtExQ2FW2UKukODvHAMIvlvHVjfS6sp74rHw3ewsGOOKHHlJMuu5D1wdXoVQIWU02
         LTXhhOddlEBqWo3zl7OzQA2xOWUWyuBbo8rHosGHSSawgydh6ms/ah7JFT/bC5zN475R
         dYdM9Bm1UUJvfIeyzrSbktdigPtzjows3613+kSy9FoM280ViCDuA3Rqej3CcDSsry7C
         SZ5pBVBubEFsN0WLmX0x5yFPUZYFa7hTwuCi8KlVFcJR3fxVHwAk/pKbqDOQrBd9z94n
         iboWwv9spvRjUOie9r+rcMl2Ld4DcwcIA0y1mV/fS6DPNP3JUpk8PacPIDDeNH/FLM5q
         SDzg==
X-Gm-Message-State: AOJu0Yyi9/SIPy3dK/J2xJibRq6wuHI7ZiD0tfkX6QZQtdSYR+AK2pqd
	UyBd+WqSXhOY0GkpvhNpDQUfrKUsH97NCnLVqrZE8g==
X-Google-Smtp-Source: AGHT+IEqrcNfX7s0eKVrobwrWSVuZtMWwJql3a8+pinLIAoO8k018sVp5eQ1YzH0tzah9H9Ug9oFHQ==
X-Received: by 2002:a17:902:ce86:b0:1bf:728:7459 with SMTP id f6-20020a170902ce8600b001bf07287459mr252782plg.63.1692193890258;
        Wed, 16 Aug 2023 06:51:30 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id o93-20020a17090a0a6600b0026b3773043dsm8409597pjo.22.2023.08.16.06.51.29
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 06:51:29 -0700 (PDT)
Message-ID: <64dcd461.170a0220.cd5b.f79a@mx.google.com>
Date: Wed, 16 Aug 2023 06:51:29 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.186-cip37-16-gf8567732a40d
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
Subject: cip-gitlab/ci/pavel/linux-test baseline: 115 runs,
 65 regressions (v5.10.186-cip37-16-gf8567732a40d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Aug 2023 13:51:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12679

cip-gitlab/ci/pavel/linux-test baseline: 115 runs, 65 regressions (v5.10.18=
6-cip37-16-gf8567732a40d)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cbv514-1h-34uz-brya     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

bcm2836-rpi-2-b              | arm    | lab-collabora | gcc-10   | bcm2835_=
defconfig            | 1          =

bcm2836-rpi-2-b              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 7          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 7          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =

fsl-ls1028a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =

fsl-ls1088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =

fsl-ls2088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =

fsl-lx2160a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

imx6dl-udoo                  | arm    | lab-broonie   | gcc-10   | imx_v6_v=
7_defconfig          | 1          =

imx6dl-udoo                  | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | imx_v6_v=
7_defconfig          | 1          =

imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

imx7d-sdb                    | arm    | lab-nxp       | gcc-10   | imx_v6_v=
7_defconfig          | 1          =

imx7d-sdb                    | arm    | lab-nxp       | gcc-10   | multi_v7=
_defconfig           | 1          =

imx7ulp-evk                  | arm    | lab-nxp       | gcc-10   | multi_v7=
_defconfig           | 1          =

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

qemu_mips-malta              | mips   | lab-broonie   | gcc-10   | malta_de=
fconfig              | 1          =

qemu_mips-malta              | mips   | lab-collabora | gcc-10   | malta_de=
fconfig              | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

rk3288-veyron-jaq            | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 5          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 5          =

sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

zynqmp-zcu102                | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

zynqmp-zcu102                | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.186-cip37-16-gf8567732a40d/plan/baseline/

  Test:     baseline
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
acer-cbv514-1h-34uz-brya     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dcccaa2c011c253135b1e1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-acer-cbv514-1h-34uz-brya.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-acer-cbv514-1h-34uz-brya.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dcccaa2c011c253135b=
1e2
        failing since 28 days (last pass: v6.1.38-cip1-10-g02aa22be941dd, f=
irst fail: v5.10.186-cip37-2-gfcd111609480) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora | gcc-10   | bcm2835_=
defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/64dccb8a73973c64c235b1d9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm/bcm2835_defconfig/gcc-10/lab-collabor=
a/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm/bcm2835_defconfig/gcc-10/lab-collabor=
a/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dccb8a73973c64c235b1de
        new failure (last pass: v4.19.288-cip101-1117-g1f3468542aa9e)

    2023-08-16T13:15:02.801237  / # #

    2023-08-16T13:15:02.903375  export SHELL=3D/bin/sh

    2023-08-16T13:15:02.904106  #

    2023-08-16T13:15:03.005523  / # export SHELL=3D/bin/sh. /lava-11299397/=
environment

    2023-08-16T13:15:03.006259  =


    2023-08-16T13:15:03.107656  / # . /lava-11299397/environment/lava-11299=
397/bin/lava-test-runner /lava-11299397/1

    2023-08-16T13:15:03.108772  =


    2023-08-16T13:15:03.125919  / # /lava-11299397/bin/lava-test-runner /la=
va-11299397/1

    2023-08-16T13:15:03.189997  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-16T13:15:03.233912  + cd /lava-11299397/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64dccaff7bfa7a0ac235b22e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm/multi_v7_defconfig/gcc-10/lab-collabo=
ra/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm/multi_v7_defconfig/gcc-10/lab-collabo=
ra/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dccaff7bfa7a0ac235b=
22f
        new failure (last pass: v4.19.288-cip101-1117-g1f3468542aa9e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 7          =


  Details:     https://kernelci.org/test/plan/id/64dccaf17bfa7a0ac235b1e0

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm/multi_v7_defconfig/gcc-10/lab-broonie=
/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm/multi_v7_defconfig/gcc-10/lab-broonie=
/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.hdmi-codec-driver-present: https://kernelci.org/test/ca=
se/id/64dccaf17bfa7a0ac235b1e4
        failing since 26 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-16T13:10:56.673046  /lava-56874/1/../bin/lava-test-case
    2023-08-16T13:10:56.708805  <8>[   44.300938] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-08-16T13:10:57.735370  /lava-56874/1/../bin/lava-test-case
    2023-08-16T13:10:57.765936  <8>[   45.357361] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case/id/=
64dccaf17bfa7a0ac235b1e5
        failing since 26 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-16T13:10:54.546698  /lava-56874/1/../bin/lava-test-case
    2023-08-16T13:10:54.580707  <8>[   42.172456] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-08-16T13:10:55.606868  /lava-56874/1/../bin/lava-test-case
    2023-08-16T13:10:55.645935  <8>[   43.237940] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/id/64=
dccaf17bfa7a0ac235b1e6
        failing since 26 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-16T13:10:58.841031  /lava-56874/1/../bin/lava-test-case
    2023-08-16T13:10:58.877535  <8>[   46.469611] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline.bootrr.tda19988-driver-present: https://kernelci.org/test/case=
/id/64dccaf17bfa7a0ac235b1e7
        failing since 26 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-16T13:10:52.423102  /lava-56874/1/../bin/lava-test-case
    2023-08-16T13:10:52.458212  <8>[   40.050381] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-08-16T13:10:53.484896  /lava-56874/1/../bin/lava-test-case
    2023-08-16T13:10:53.519887  <8>[   41.111342] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/64dccaf17bfa7a0ac235b1f3
        failing since 26 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-16T13:10:40.487009  /lava-56874/1/../bin/lava-test-case
    2023-08-16T13:10:40.521718  <8>[   28.112655] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dccaf17bfa7a0ac235b20c
        failing since 26 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-16T13:10:34.716799  <8>[   22.309753] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 56874_1.5.2.4.1>
    2023-08-16T13:10:34.826717  / # #
    2023-08-16T13:10:34.929872  export SHELL=3D/bin/sh
    2023-08-16T13:10:34.930624  #
    2023-08-16T13:10:35.032922  / # export SHELL=3D/bin/sh. /lava-56874/env=
ironment
    2023-08-16T13:10:35.033670  =

    2023-08-16T13:10:35.135849  / # . /lava-56874/environment/lava-56874/bi=
n/lava-test-runner /lava-56874/1
    2023-08-16T13:10:35.137060  =

    2023-08-16T13:10:35.141823  / # /lava-56874/bin/lava-test-runner /lava-=
56874/1
    2023-08-16T13:10:35.236275  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =


  * baseline.bootrr.hdmi-audio: https://kernelci.org/test/case/id/64dccaf17=
bfa7a0ac235b20d
        failing since 26 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-16T13:10:59.903124  /lava-56874/1/../bin/lava-test-case
    2023-08-16T13:10:59.937847  <8>[   47.530787] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 7          =


  Details:     https://kernelci.org/test/plan/id/64dccce8f8c571879235b1e5

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm/multi_v7_defconfig/gcc-10/lab-cip/bas=
eline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm/multi_v7_defconfig/gcc-10/lab-cip/bas=
eline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dccce8f8c571879235b1e8
        failing since 26 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-16T13:18:54.043246  / # #
    2023-08-16T13:18:54.146690  export SHELL=3D/bin/sh
    2023-08-16T13:18:54.147625  #
    2023-08-16T13:18:54.249811  / # export SHELL=3D/bin/sh. /lava-997881/en=
vironment
    2023-08-16T13:18:54.250678  =

    2023-08-16T13:18:54.352828  / # . /lava-997881/environment/lava-997881/=
bin/lava-test-runner /lava-997881/1
    2023-08-16T13:18:54.354361  =

    2023-08-16T13:18:54.365669  / # /lava-997881/bin/lava-test-runner /lava=
-997881/1
    2023-08-16T13:18:54.490517  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-16T13:18:54.491089  + cd /lava-997881/1/tests/1_bootrr =

    ... (10 line(s) more)  =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/64dccce8f8c571879235b201
        failing since 26 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-16T13:18:59.704302  /lava-997881/1/../bin/lava-test-case
    2023-08-16T13:18:59.745306  <8>[   22.558636] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.tda19988-driver-present: https://kernelci.org/test/case=
/id/64dccce8f8c571879235b20d
        failing since 26 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-16T13:19:11.639114  /lava-997881/1/../bin/lava-test-case
    2023-08-16T13:19:11.677069  <8>[   34.491173] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-08-16T13:19:12.699836  /lava-997881/1/../bin/lava-test-case
    2023-08-16T13:19:12.737705  <8>[   35.551346] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case/id/=
64dccce8f8c571879235b20e
        failing since 26 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-16T13:19:13.760490  /lava-997881/1/../bin/lava-test-case
    2023-08-16T13:19:13.798506  <8>[   36.612603] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-08-16T13:19:14.821318  /lava-997881/1/../bin/lava-test-case
    2023-08-16T13:19:14.864320  <8>[   37.678240] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-codec-driver-present: https://kernelci.org/test/ca=
se/id/64dccce8f8c571879235b20f
        failing since 26 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-16T13:19:15.886916  /lava-997881/1/../bin/lava-test-case
    2023-08-16T13:19:15.927081  <8>[   38.741014] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-08-16T13:19:16.949812  /lava-997881/1/../bin/lava-test-case
    2023-08-16T13:19:17.000661  <8>[   39.801988] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>
    2023-08-16T13:19:17.001274  /opt/bootrr/libexec/bootrr/boards/ti,am335x=
-bone-black: line 84: assert_device-present: not found
    2023-08-16T13:19:17.001626  /lava-997881/1/../bin/lava-test-case   =


  * baseline.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/id/64=
dccce8f8c571879235b211
        failing since 26 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-16T13:19:18.050770  /lava-997881/1/../bin/lava-test-case
    2023-08-16T13:19:18.096575  <8>[   40.910675] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-audio: https://kernelci.org/test/case/id/64dccce8f=
8c571879235b212
        failing since 26 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-16T13:19:19.119328  /lava-997881/1/../bin/lava-test-case
    2023-08-16T13:19:19.170315  <8>[   41.970626] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>
    2023-08-16T13:19:19.170894  + set +x
    2023-08-16T13:19:19.171238  <8>[   41.986137] <LAVA_SIGNAL_ENDRUN 1_boo=
trr 997881_1.5.2.4.5>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64dcca8c125f10c73035b1db

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm/omap2plus_defconfig/gcc-10/lab-brooni=
e/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm/omap2plus_defconfig/gcc-10/lab-brooni=
e/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dcca8c125f10c73035b210
        new failure (last pass: v4.19.288-cip101-1117-g1f3468542aa9e)

    2023-08-16T13:09:20.969682  <8>[   25.315582] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 56855_1.5.2.4.1>
    2023-08-16T13:09:21.077718  / # #
    2023-08-16T13:09:21.180308  export SHELL=3D/bin/sh
    2023-08-16T13:09:21.180847  #
    2023-08-16T13:09:21.282527  / # export SHELL=3D/bin/sh. /lava-56855/env=
ironment
    2023-08-16T13:09:21.282976  =

    2023-08-16T13:09:21.384771  / # . /lava-56855/environment/lava-56855/bi=
n/lava-test-runner /lava-56855/1
    2023-08-16T13:09:21.385397  =

    2023-08-16T13:09:21.390623  / # /lava-56855/bin/lava-test-runner /lava-=
56855/1
    2023-08-16T13:09:21.486836  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64dccab893d0ff538d35b1d9

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm/omap2plus_defconfig/gcc-10/lab-cip/ba=
seline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm/omap2plus_defconfig/gcc-10/lab-cip/ba=
seline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dccab893d0ff538d35b1dc
        new failure (last pass: v4.19.288-cip101-1117-g1f3468542aa9e)

    2023-08-16T13:09:49.058257  / # #
    2023-08-16T13:09:49.161678  export SHELL=3D/bin/sh
    2023-08-16T13:09:49.162646  #
    2023-08-16T13:09:49.265062  / # export SHELL=3D/bin/sh. /lava-997876/en=
vironment
    2023-08-16T13:09:49.266159  =

    2023-08-16T13:09:49.368699  / # . /lava-997876/environment/lava-997876/=
bin/lava-test-runner /lava-997876/1
    2023-08-16T13:09:49.370380  =

    2023-08-16T13:09:49.380570  / # /lava-997876/bin/lava-test-runner /lava=
-997876/1
    2023-08-16T13:09:49.521343  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-16T13:09:49.521899  + cd /lava-997876/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-ls1028a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64dccc432d4e7c012935b1f3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm64/defconfig/gcc-10/lab-nxp/baseline-f=
sl-ls1028a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm64/defconfig/gcc-10/lab-nxp/baseline-f=
sl-ls1028a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dccc432d4e7c012935b1f8
        failing since 27 days (last pass: v6.1.26-1314-g1ab0ac1d7e2e3, firs=
t fail: v5.10.186-cip37-2-gfcd111609480)

    2023-08-16T13:16:28.455334  [   23.496118] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1244120_1.5.2.4.1>
    2023-08-16T13:16:28.560541  =

    2023-08-16T13:16:28.661834  / # #export SHELL=3D/bin/sh
    2023-08-16T13:16:28.662369  =

    2023-08-16T13:16:28.763391  / # export SHELL=3D/bin/sh. /lava-1244120/e=
nvironment
    2023-08-16T13:16:28.763799  =

    2023-08-16T13:16:28.864768  / # . /lava-1244120/environment/lava-124412=
0/bin/lava-test-runner /lava-1244120/1
    2023-08-16T13:16:28.865437  =

    2023-08-16T13:16:28.868499  / # /lava-1244120/bin/lava-test-runner /lav=
a-1244120/1
    2023-08-16T13:16:28.888492  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-ls1088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64dccc403e9504e13a35b21a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm64/defconfig/gcc-10/lab-nxp/baseline-f=
sl-ls1088a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm64/defconfig/gcc-10/lab-nxp/baseline-f=
sl-ls1088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dccc403e9504e13a35b21f
        new failure (last pass: v4.19.288-cip101-1117-g1f3468542aa9e)

    2023-08-16T13:16:18.678669  [   10.401840] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1244119_1.5.2.4.1>
    2023-08-16T13:16:18.784149  =

    2023-08-16T13:16:18.885480  / # #export SHELL=3D/bin/sh
    2023-08-16T13:16:18.885912  =

    2023-08-16T13:16:18.986930  / # export SHELL=3D/bin/sh. /lava-1244119/e=
nvironment
    2023-08-16T13:16:18.987366  =

    2023-08-16T13:16:19.088378  / # . /lava-1244119/environment/lava-124411=
9/bin/lava-test-runner /lava-1244119/1
    2023-08-16T13:16:19.089102  =

    2023-08-16T13:16:19.093160  / # /lava-1244119/bin/lava-test-runner /lav=
a-1244119/1
    2023-08-16T13:16:19.109479  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-ls2088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64dccc3dda5ab3478335b25c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm64/defconfig/gcc-10/lab-nxp/baseline-f=
sl-ls2088a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm64/defconfig/gcc-10/lab-nxp/baseline-f=
sl-ls2088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dccc3dda5ab3478335b261
        new failure (last pass: v4.19.288-cip101-1117-g1f3468542aa9e)

    2023-08-16T13:16:23.150128  + [   15.080806] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 1244118_1.5.2.4.1>
    2023-08-16T13:16:23.150426  set +x
    2023-08-16T13:16:23.256295  =

    2023-08-16T13:16:23.357546  / # #export SHELL=3D/bin/sh
    2023-08-16T13:16:23.357989  =

    2023-08-16T13:16:23.458964  / # export SHELL=3D/bin/sh. /lava-1244118/e=
nvironment
    2023-08-16T13:16:23.459423  =

    2023-08-16T13:16:23.560410  / # . /lava-1244118/environment/lava-124411=
8/bin/lava-test-runner /lava-1244118/1
    2023-08-16T13:16:23.561232  =

    2023-08-16T13:16:23.565436  / # /lava-1244118/bin/lava-test-runner /lav=
a-1244118/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-lx2160a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64dccc502d4e7c012935b1fe

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm64/defconfig/gcc-10/lab-nxp/baseline-f=
sl-lx2160a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm64/defconfig/gcc-10/lab-nxp/baseline-f=
sl-lx2160a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dccc502d4e7c012935b203
        failing since 117 days (last pass: v5.10.145-rt74-1329-ga59fc50f38f=
6, first fail: v5.10.177-cip31-33-gd59f246891e73)

    2023-08-16T13:16:39.917691  [   14.785219] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1244117_1.5.2.4.1>
    2023-08-16T13:16:40.023481  =

    2023-08-16T13:16:40.124736  / # #export SHELL=3D/bin/sh
    2023-08-16T13:16:40.125175  =

    2023-08-16T13:16:40.226138  / # export SHELL=3D/bin/sh. /lava-1244117/e=
nvironment
    2023-08-16T13:16:40.226581  =

    2023-08-16T13:16:40.327584  / # . /lava-1244117/environment/lava-124411=
7/bin/lava-test-runner /lava-1244117/1
    2023-08-16T13:16:40.328330  =

    2023-08-16T13:16:40.332257  / # /lava-1244117/bin/lava-test-runner /lav=
a-1244117/1
    2023-08-16T13:16:40.348177  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dccb9d73973c64c235b1f3

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dccb9d73973c64c235b1f8
        new failure (last pass: v4.19.288-cip101-1117-g1f3468542aa9e)

    2023-08-16T13:13:52.978279  + set +x

    2023-08-16T13:13:52.985199  <8>[   14.891351] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11299406_1.4.2.3.1>

    2023-08-16T13:13:53.092577  / # #

    2023-08-16T13:13:53.194899  export SHELL=3D/bin/sh

    2023-08-16T13:13:53.195652  #

    2023-08-16T13:13:53.297027  / # export SHELL=3D/bin/sh. /lava-11299406/=
environment

    2023-08-16T13:13:53.297765  =


    2023-08-16T13:13:53.399178  / # . /lava-11299406/environment/lava-11299=
406/bin/lava-test-runner /lava-11299406/1

    2023-08-16T13:13:53.400462  =


    2023-08-16T13:13:53.405138  / # /lava-11299406/bin/lava-test-runner /la=
va-11299406/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dccb842e65f9c93235b1fd

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dccb842e65f9c93235b202
        new failure (last pass: v4.19.288-cip101-1117-g1f3468542aa9e)

    2023-08-16T13:13:34.578978  <8>[   13.193120] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11299411_1.4.2.3.1>

    2023-08-16T13:13:34.582390  + set +x

    2023-08-16T13:13:34.687854  #

    2023-08-16T13:13:34.790701  / # #export SHELL=3D/bin/sh

    2023-08-16T13:13:34.791464  =


    2023-08-16T13:13:34.893013  / # export SHELL=3D/bin/sh. /lava-11299411/=
environment

    2023-08-16T13:13:34.893816  =


    2023-08-16T13:13:34.995488  / # . /lava-11299411/environment/lava-11299=
411/bin/lava-test-runner /lava-11299411/1

    2023-08-16T13:13:34.996954  =


    2023-08-16T13:13:35.001952  / # /lava-11299411/bin/lava-test-runner /la=
va-11299411/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6dl-udoo                  | arm    | lab-broonie   | gcc-10   | imx_v6_v=
7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64dcceb1df7810ff5635b205

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm/imx_v6_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm/imx_v6_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dcceb1df7810ff5635b=
206
        new failure (last pass: v4.19.288-cip101-1117-g1f3468542aa9e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6dl-udoo                  | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64dccbca1cb07ad31535b1da

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm/multi_v7_defconfig/gcc-10/lab-broonie=
/baseline-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm/multi_v7_defconfig/gcc-10/lab-broonie=
/baseline-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dccbca1cb07ad31535b=
1db
        new failure (last pass: v4.19.288-cip101-1117-g1f3468542aa9e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | imx_v6_v=
7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64dcd0035891b076d435b1dd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm/imx_v6_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm/imx_v6_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dcd0035891b076d435b=
1de
        new failure (last pass: v4.19.288-cip101-1117-g1f3468542aa9e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64dccbdf1cb07ad31535b26e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm/multi_v7_defconfig/gcc-10/lab-broonie=
/baseline-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm/multi_v7_defconfig/gcc-10/lab-broonie=
/baseline-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dccbdf1cb07ad31535b=
26f
        new failure (last pass: v4.19.288-cip101-1117-g1f3468542aa9e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx7d-sdb                    | arm    | lab-nxp       | gcc-10   | imx_v6_v=
7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64dccdb8c9c8ecab1c35b1df

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm/imx_v6_v7_defconfig/gcc-10/lab-nxp/ba=
seline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm/imx_v6_v7_defconfig/gcc-10/lab-nxp/ba=
seline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.all-cpus-are-online: https://kernelci.org/test/case/id/=
64dccdb8c9c8ecab1c35b1e3
        failing since 26 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-16T13:22:52.718904  /lava-1244129/1/../bin/lava-test-case
    2023-08-16T13:22:52.755901  <8>[   31.167485] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dall-cpus-are-online RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx7d-sdb                    | arm    | lab-nxp       | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64dccae8b07a2e2cd035b215

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm/multi_v7_defconfig/gcc-10/lab-nxp/bas=
eline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm/multi_v7_defconfig/gcc-10/lab-nxp/bas=
eline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.all-cpus-are-online: https://kernelci.org/test/case/id/=
64dccae8b07a2e2cd035b219
        failing since 26 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-16T13:10:52.847714  /lava-1244113/1/../bin/lava-test-case
    2023-08-16T13:10:52.868746  <8>[   25.036378] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dall-cpus-are-online RESULT=3Dfail>
    2023-08-16T13:10:52.869086  /lava-1244113/1/../bin/lava-test-case   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx7ulp-evk                  | arm    | lab-nxp       | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64dccafc7bfa7a0ac235b220

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm/multi_v7_defconfig/gcc-10/lab-nxp/bas=
eline-imx7ulp-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm/multi_v7_defconfig/gcc-10/lab-nxp/bas=
eline-imx7ulp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dccafc7bfa7a0ac235b225
        failing since 147 days (last pass: v5.10.145-rt74-1329-ga59fc50f38f=
6, first fail: v5.10.175-cip29-rt12)

    2023-08-16T13:11:02.294309  + set +x<8>[   29.031416] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 1244114_1.5.2.4.1>
    2023-08-16T13:11:02.294599  =

    2023-08-16T13:11:02.402925  / # #
    2023-08-16T13:11:03.558875  export SHELL=3D/bin/sh
    2023-08-16T13:11:03.564420  #
    2023-08-16T13:11:03.564697  / # export SHELL=3D/bin/sh
    2023-08-16T13:11:05.106817  / # . /lava-1244114/environment
    2023-08-16T13:11:07.924426  /lava-1244114/bin/lava-test-runner /lava-12=
44114/1
    2023-08-16T13:11:07.930431  . /lava-1244114/environment
    2023-08-16T13:11:07.930707  / # /lava-1244114/bin/lava-test-runner /lav=
a-1244114/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
kontron-kbox-a-230-ls        | arm64  | lab-kontron   | gcc-10   | defconfi=
g                    | 3          =


  Details:     https://kernelci.org/test/plan/id/64dccbe3bfa920ea2f35b1e1

  Results:     89 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm64/defconfig/gcc-10/lab-kontron/baseli=
ne-kontron-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm64/defconfig/gcc-10/lab-kontron/baseli=
ne-kontron-kbox-a-230-ls.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rcpm-driver-present: https://kernelci.org/test/case/id/=
64dccbe4bfa920ea2f35b221
        failing since 27 days (last pass: v6.1.31-65-geef5a19d48f6, first f=
ail: v5.10.186-cip37-2-gfcd111609480)

    2023-08-16T13:15:00.767879  /lava-375254/1/../bin/lava-test-case
    2023-08-16T13:15:00.771124  <8>[   14.102461] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.ftm-alarm-driver-present: https://kernelci.org/test/cas=
e/id/64dccbe4bfa920ea2f35b222
        failing since 27 days (last pass: v6.1.31-65-geef5a19d48f6, first f=
ail: v5.10.186-cip37-2-gfcd111609480)

    2023-08-16T13:15:01.780901  /lava-375254/1/../bin/lava-test-case
    2023-08-16T13:15:01.784105  <8>[   15.120160] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2023-08-16T13:15:02.804081  /lava-375254/1/../bin/lava-test-case   =


  * baseline.bootrr.layerscape-sfp-driver-present: https://kernelci.org/tes=
t/case/id/64dccbe4bfa920ea2f35b239
        failing since 27 days (last pass: v6.1.31-65-geef5a19d48f6, first f=
ail: v5.10.186-cip37-2-gfcd111609480)

    2023-08-16T13:15:05.225278  /lava-375254/1/../bin/lava-test-case
    2023-08-16T13:15:05.228591  <8>[   18.559117] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
kontron-sl28-var3-ads2       | arm64  | lab-kontron   | gcc-10   | defconfi=
g                    | 3          =


  Details:     https://kernelci.org/test/plan/id/64dccbd01cb07ad31535b1f4

  Results:     97 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm64/defconfig/gcc-10/lab-kontron/baseli=
ne-kontron-sl28-var3-ads2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm64/defconfig/gcc-10/lab-kontron/baseli=
ne-kontron-sl28-var3-ads2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rcpm-driver-present: https://kernelci.org/test/case/id/=
64dccbd01cb07ad31535b23b
        failing since 27 days (last pass: v6.1.31-65-geef5a19d48f6, first f=
ail: v5.10.186-cip37-2-gfcd111609480)

    2023-08-16T13:14:43.516033  /lava-375255/1/../bin/lava-test-case
    2023-08-16T13:14:43.519123  <8>[   11.009405] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.ftm-alarm-driver-present: https://kernelci.org/test/cas=
e/id/64dccbd01cb07ad31535b23c
        failing since 27 days (last pass: v6.1.31-65-geef5a19d48f6, first f=
ail: v5.10.186-cip37-2-gfcd111609480)

    2023-08-16T13:14:44.529610  /lava-375255/1/../bin/lava-test-case
    2023-08-16T13:14:44.532847  <8>[   12.028050] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2023-08-16T13:14:45.552290  /lava-375255/1/../bin/lava-test-case   =


  * baseline.bootrr.layerscape-sfp-driver-present: https://kernelci.org/tes=
t/case/id/64dccbd01cb07ad31535b251
        failing since 27 days (last pass: v6.1.31-65-geef5a19d48f6, first f=
ail: v5.10.186-cip37-2-gfcd111609480)

    2023-08-16T13:14:47.976373  /lava-375255/1/../bin/lava-test-case
    2023-08-16T13:14:47.979697  <8>[   15.469256] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64dccc09b5b32069bf35b218

  Results:     51 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm64/defconfig/gcc-10/lab-broonie/baseli=
ne-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm64/defconfig/gcc-10/lab-broonie/baseli=
ne-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/64dccc09b=
5b32069bf35b21b
        failing since 27 days (last pass: v6.1.31-65-geef5a19d48f6, first f=
ail: v5.10.186-cip37-2-gfcd111609480)

    2023-08-16T13:15:45.694758  /lava-56903/1/../bin/lava-test-case
    2023-08-16T13:15:45.706265  <8>[   18.818673] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>
    2023-08-16T13:15:45.706652  + set +x   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64dccd853a0587cdfa35b1e8

  Results:     51 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-broonie/baseline-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-broonie/baseline-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/64dccd853=
a0587cdfa35b1eb
        failing since 63 days (last pass: v6.1.26-1320-g1ddf4b637f785, firs=
t fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-08-16T13:22:06.729209  /lava-56926/1/../bin/lava-test-case
    2023-08-16T13:22:06.741479  <8>[   18.705163] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>
    2023-08-16T13:22:06.741875  + set +x   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64dccd8a3a0587cdfa35b226

  Results:     28 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/baseline-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/baseline-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dccd8a3a0587cdfa35b242
        failing since 63 days (last pass: v6.1.26-1320-g1ddf4b637f785, firs=
t fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-08-16T13:23:13.823019  + set +x

    2023-08-16T13:23:13.827821  <8>[   15.600809] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11299481_1.5.2.3.1>

    2023-08-16T13:23:13.936506  / # #

    2023-08-16T13:23:14.038933  export SHELL=3D/bin/sh

    2023-08-16T13:23:14.039850  #

    2023-08-16T13:23:14.141553  / # export SHELL=3D/bin/sh. /lava-11299481/=
environment

    2023-08-16T13:23:14.142333  =


    2023-08-16T13:23:14.244096  / # . /lava-11299481/environment/lava-11299=
481/bin/lava-test-runner /lava-11299481/1

    2023-08-16T13:23:14.245538  =


    2023-08-16T13:23:14.247564  / # /lava-11299481/bin/lava-test-runner /la=
va-11299481/1
 =

    ... (21 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_mips-malta              | mips   | lab-broonie   | gcc-10   | malta_de=
fconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/64dccb3c6a34fb3ecf35b1fe

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/mips/malta_defconfig/gcc-10/lab-broonie/b=
aseline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/mips/malta_defconfig/gcc-10/lab-broonie/b=
aseline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dccb3c6a34fb3ecf35b=
1ff
        failing since 2 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fir=
st fail: v4.19.288-cip101-1117-g1f3468542aa9e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_mips-malta              | mips   | lab-collabora | gcc-10   | malta_de=
fconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/64dccb087bfa7a0ac235b234

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/mips/malta_defconfig/gcc-10/lab-collabora=
/baseline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/mips/malta_defconfig/gcc-10/lab-collabora=
/baseline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dccb087bfa7a0ac235b=
235
        failing since 2 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fir=
st fail: v4.19.288-cip101-1117-g1f3468542aa9e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64dcc9c2a7474d78e735b1dc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm/shmobile_defconfig/gcc-10/lab-cip/bas=
eline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm/shmobile_defconfig/gcc-10/lab-cip/bas=
eline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dcc9c2a7474d78e735b=
1dd
        failing since 38 days (last pass: v6.1.31-61-g32a95f5a4e3b, first f=
ail: v6.1.31-65-geef5a19d48f6) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64dccdd8792cb1977435b1dc

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-cip/baseline-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-cip/baseline-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dccdd8792cb1977435b1df
        new failure (last pass: v4.19.288-cip101-1117-g1f3468542aa9e)

    2023-08-16T13:23:17.911690  + set +x
    2023-08-16T13:23:17.912281  <8>[   83.767573] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 997902_1.5.2.4.1>
    2023-08-16T13:23:18.020721  / # #
    2023-08-16T13:23:19.492286  export SHELL=3D/bin/sh
    2023-08-16T13:23:19.513547  #
    2023-08-16T13:23:19.514314  / # export SHELL=3D/bin/sh
    2023-08-16T13:23:21.409818  / # . /lava-997902/environment
    2023-08-16T13:23:24.885592  /lava-997902/bin/lava-test-runner /lava-997=
902/1
    2023-08-16T13:23:24.907471  . /lava-997902/environment
    2023-08-16T13:23:24.907911  / # /lava-997902/bin/lava-test-runner /lava=
-997902/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64dccdf91a7bf5247235b1fc

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-cip/baseline-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-cip/baseline-r8a774b1-hihope-rzg2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dccdf91a7bf5247235b1ff
        new failure (last pass: v4.19.288-cip101-1117-g1f3468542aa9e)

    2023-08-16T13:23:50.894758  + set +x
    2023-08-16T13:23:50.894979  <8>[   84.008823] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 997893_1.5.2.4.1>
    2023-08-16T13:23:51.000282  / # #
    2023-08-16T13:23:52.463661  export SHELL=3D/bin/sh
    2023-08-16T13:23:52.484238  #
    2023-08-16T13:23:52.484468  / # export SHELL=3D/bin/sh
    2023-08-16T13:23:54.370033  / # . /lava-997893/environment
    2023-08-16T13:23:57.828663  /lava-997893/bin/lava-test-runner /lava-997=
893/1
    2023-08-16T13:23:57.849450  . /lava-997893/environment
    2023-08-16T13:23:57.849562  / # /lava-997893/bin/lava-test-runner /lava=
-997893/1 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64dccc69b01542e68d35b1e0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm64/defconfig/gcc-10/lab-cip/baseline-r=
8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm64/defconfig/gcc-10/lab-cip/baseline-r=
8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dccc69b01542e68d35b1e3
        new failure (last pass: v4.19.288-cip101-1117-g1f3468542aa9e)

    2023-08-16T13:17:06.000356  / # #
    2023-08-16T13:17:07.462902  export SHELL=3D/bin/sh
    2023-08-16T13:17:07.483472  #
    2023-08-16T13:17:07.483678  / # export SHELL=3D/bin/sh
    2023-08-16T13:17:09.369225  / # . /lava-997884/environment
    2023-08-16T13:17:12.827840  /lava-997884/bin/lava-test-runner /lava-997=
884/1
    2023-08-16T13:17:12.848626  . /lava-997884/environment
    2023-08-16T13:17:12.848733  / # /lava-997884/bin/lava-test-runner /lava=
-997884/1
    2023-08-16T13:17:12.928744  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-16T13:17:12.928960  + cd /lava-997884/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64dcce35ec8e1e778935b1e7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dcce35ec8e1e778935b1ea
        new failure (last pass: v4.19.288-cip101-1117-g1f3468542aa9e)

    2023-08-16T13:24:42.055851  / # #
    2023-08-16T13:24:43.519646  export SHELL=3D/bin/sh
    2023-08-16T13:24:43.540218  #
    2023-08-16T13:24:43.540448  / # export SHELL=3D/bin/sh
    2023-08-16T13:24:45.425975  / # . /lava-997900/environment
    2023-08-16T13:24:48.884102  /lava-997900/bin/lava-test-runner /lava-997=
900/1
    2023-08-16T13:24:48.904915  . /lava-997900/environment
    2023-08-16T13:24:48.905028  / # /lava-997900/bin/lava-test-runner /lava=
-997900/1
    2023-08-16T13:24:48.984377  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-16T13:24:48.984595  + cd /lava-997900/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64dccd2e6a6dd5d3f235b1eb

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm64/defconfig/gcc-10/lab-collabora/base=
line-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm64/defconfig/gcc-10/lab-collabora/base=
line-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dccd2e6a6dd5d3f235b1f0
        failing since 27 days (last pass: v6.1.31-65-geef5a19d48f6, first f=
ail: v5.10.186-cip37-2-gfcd111609480)

    2023-08-16T13:22:02.473684  / # #

    2023-08-16T13:22:02.575838  export SHELL=3D/bin/sh

    2023-08-16T13:22:02.576567  #

    2023-08-16T13:22:02.678047  / # export SHELL=3D/bin/sh. /lava-11299458/=
environment

    2023-08-16T13:22:02.678781  =


    2023-08-16T13:22:02.780173  / # . /lava-11299458/environment/lava-11299=
458/bin/lava-test-runner /lava-11299458/1

    2023-08-16T13:22:02.781367  =


    2023-08-16T13:22:02.798009  / # /lava-11299458/bin/lava-test-runner /la=
va-11299458/1

    2023-08-16T13:22:02.847078  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-16T13:22:02.847575  + cd /lav<8>[   16.394320] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11299458_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 5          =


  Details:     https://kernelci.org/test/plan/id/64dccaafd66407064d35b1f5

  Results:     63 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm/multi_v7_defconfig/gcc-10/lab-collabo=
ra/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm/multi_v7_defconfig/gcc-10/lab-collabo=
ra/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-iodomain-grf-probed: https://kernelci.org/test=
/case/id/64dccaafd66407064d35b20b
        failing since 26 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-16T13:11:40.674174  /lava-11299382/1/../bin/lava-test-case<8>[ =
  21.075260] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Drockchip-iodomain-driver-=
present RESULT=3Dpass>

    2023-08-16T13:11:40.674224  =


    2023-08-16T13:11:41.685247  /lava-11299382/1/../bin/lava-test-case

    2023-08-16T13:11:41.694293  <8>[   22.095751] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-iodomain-grf-probed RESULT=3Dfail>
   =


  * baseline.bootrr.dwmmc_rockchip-sdio0-probed: https://kernelci.org/test/=
case/id/64dccaafd66407064d35b221
        failing since 26 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-16T13:11:39.260690  <8>[   19.661701] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwmmc_rockchip-sdmmc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.dwmmc_rockchip-sdmmc-probed: https://kernelci.org/test/=
case/id/64dccaafd66407064d35b222
        failing since 26 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-16T13:11:38.239608  	-w	P<8>[   18.637050] <LAVA_SIGNAL_TESTCAS=
E TEST_CASE_ID=3Ddwmmc_rockchip-driver-present RESULT=3Dpass>

    2023-08-16T13:11:38.242487  ad to last with leading zeros

    2023-08-16T13:11:38.244885  	-s SEP	String separator

    2023-08-16T13:11:38.248962  /lava-11299382/1/../bin/lava-test-case

    2023-08-16T13:11:38.254882  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.

    2023-08-16T13:11:38.255114  =


    2023-08-16T13:11:38.259632  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-08-16T13:11:38.259858  =


    2023-08-16T13:11:38.264705  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-08-16T13:11:38.267321  FIRST, INC default to 1.
 =

    ... (6 line(s) more)  =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/64dccaafd66407064d35b225
        failing since 208 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-08-16T13:11:38.166915  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC)<8=
>[   18.567200] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-08-16T13:11:38.168921   multi-call binary.

    2023-08-16T13:11:38.168977  =


    2023-08-16T13:11:38.173292  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-08-16T13:11:38.173642  =


    2023-08-16T13:11:38.178598  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/64dccaafd66407064d35b226
        failing since 208 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-08-16T13:11:38.147665  <8>[   18.549214] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64dccdaeb242f337f635b1f9

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/64dccdaeb242f337f635b1ff
        failing since 63 days (last pass: v6.1.26-1320-g1ddf4b637f785, firs=
t fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-08-16T13:22:43.295367  <8>[   61.034809] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-08-16T13:22:44.320147  /lava-11299479/1/../bin/lava-test-case

    2023-08-16T13:22:44.331170  <8>[   62.071428] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/64dccdaeb242f337f635b200
        failing since 63 days (last pass: v6.1.26-1320-g1ddf4b637f785, firs=
t fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-08-16T13:22:43.283049  /lava-11299479/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 5          =


  Details:     https://kernelci.org/test/plan/id/64dcd1e41c62507d9935b1d9

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm64/defconfig/gcc-10/lab-broonie/baseli=
ne-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm64/defconfig/gcc-10/lab-broonie/baseli=
ne-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/64dcd1e41=
c62507d9935b1ef
        failing since 27 days (last pass: v6.1.31-65-geef5a19d48f6, first f=
ail: v5.10.186-cip37-2-gfcd111609480)

    2023-08-16T13:40:44.738136  /lava-56905/1/../bin/lava-test-case
    2023-08-16T13:40:44.748832  <8>[   25.459977] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Di2s-probed RESULT=3Dblocked>
    2023-08-16T13:40:45.773368  /lava-56905/1/../bin/lava-test-case
    2023-08-16T13:40:45.783843  <8>[   26.495320] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>   =


  * baseline.bootrr.sun4i-i2s-driver-present: https://kernelci.org/test/cas=
e/id/64dcd1e41c62507d9935b1f0
        failing since 27 days (last pass: v6.1.31-65-geef5a19d48f6, first f=
ail: v5.10.186-cip37-2-gfcd111609480)

    2023-08-16T13:40:42.665059  /lava-56905/1/../bin/lava-test-case
    2023-08-16T13:40:42.676654  <8>[   23.387045] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcodec-digital-probed RESULT=3Dblocked>
    2023-08-16T13:40:43.702115  /lava-56905/1/../bin/lava-test-case
    2023-08-16T13:40:43.713808  <8>[   24.424156] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun4i-i2s-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sun8i-codec-driver-present: https://kernelci.org/test/c=
ase/id/64dcd1e41c62507d9935b1f1
        failing since 27 days (last pass: v6.1.31-65-geef5a19d48f6, first f=
ail: v5.10.186-cip37-2-gfcd111609480)

    2023-08-16T13:40:40.590114  /lava-56905/1/../bin/lava-test-case
    2023-08-16T13:40:40.601471  <8>[   21.312294] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcodec-analog-probed RESULT=3Dblocked>
    2023-08-16T13:40:41.626978  /lava-56905/1/../bin/lava-test-case
    2023-08-16T13:40:41.638945  <8>[   22.349142] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8i-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sun50i-codec-analog-driver-present: https://kernelci.or=
g/test/case/id/64dcd1e41c62507d9935b1f2
        failing since 27 days (last pass: v6.1.31-65-geef5a19d48f6, first f=
ail: v5.10.186-cip37-2-gfcd111609480)

    2023-08-16T13:40:39.552558  /lava-56905/1/../bin/lava-test-case
    2023-08-16T13:40:39.565227  <8>[   20.274982] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun50i-codec-analog-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dcd1e41c62507d9935b205
        failing since 27 days (last pass: v6.1.31-65-geef5a19d48f6, first f=
ail: v5.10.186-cip37-2-gfcd111609480)

    2023-08-16T13:40:36.413614  + set +x
    2023-08-16T13:40:36.417423  <8>[   17.130025] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 56905_1.5.2.4.1>
    2023-08-16T13:40:36.529140  / # #
    2023-08-16T13:40:36.632268  export SHELL=3D/bin/sh
    2023-08-16T13:40:36.632979  #
    2023-08-16T13:40:36.735405  / # export SHELL=3D/bin/sh. /lava-56905/env=
ironment
    2023-08-16T13:40:36.736149  =

    2023-08-16T13:40:36.838668  / # . /lava-56905/environment/lava-56905/bi=
n/lava-test-runner /lava-56905/1
    2023-08-16T13:40:36.840192  =

    2023-08-16T13:40:36.844329  / # /lava-56905/bin/lava-test-runner /lava-=
56905/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64dccdbf525917929135b1da

  Results:     40 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm64/defconfig/gcc-10/lab-broonie/baseli=
ne-sun50i-h5-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm64/defconfig/gcc-10/lab-broonie/baseli=
ne-sun50i-h5-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.sun8-codec-analog-driver-present: https://kernelci.org/=
test/case/id/64dccdbf525917929135b1e5
        failing since 27 days (last pass: v6.1.31-65-geef5a19d48f6, first f=
ail: v5.10.186-cip37-2-gfcd111609480)

    2023-08-16T13:23:05.952710  /lava-56912/1/../bin/lava-test-case
    2023-08-16T13:23:05.965234  <8>[   19.912941] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8-codec-analog-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64dccbda6ab1f9991835b20d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm64/defconfig/gcc-10/lab-collabora/base=
line-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm64/defconfig/gcc-10/lab-collabora/base=
line-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dccbda6ab1f9991835b212
        failing since 27 days (last pass: v6.1.31-65-geef5a19d48f6, first f=
ail: v5.10.186-cip37-2-gfcd111609480)

    2023-08-16T13:16:36.917613  / # #

    2023-08-16T13:16:37.019730  export SHELL=3D/bin/sh

    2023-08-16T13:16:37.020444  #

    2023-08-16T13:16:37.121751  / # export SHELL=3D/bin/sh. /lava-11299462/=
environment

    2023-08-16T13:16:37.122441  =


    2023-08-16T13:16:37.223666  / # . /lava-11299462/environment/lava-11299=
462/bin/lava-test-runner /lava-11299462/1

    2023-08-16T13:16:37.224664  =


    2023-08-16T13:16:37.265407  / # /lava-11299462/bin/lava-test-runner /la=
va-11299462/1

    2023-08-16T13:16:37.296593  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-16T13:16:37.297163  + cd /lava-1129946<8>[   18.319154] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11299462_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
zynqmp-zcu102                | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64dcccfaf0961091c335b1e8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm64/defconfig/gcc-10/lab-cip/baseline-z=
ynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm64/defconfig/gcc-10/lab-cip/baseline-z=
ynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dcccfaf0961091c335b=
1e9
        new failure (last pass: v4.19.288-cip101-1117-g1f3468542aa9e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
zynqmp-zcu102                | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64dcce761533dbf37835b1d9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dcce761533dbf37835b=
1da
        new failure (last pass: v4.19.288-cip101-1117-g1f3468542aa9e) =

 =20

