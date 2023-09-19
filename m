Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C85CD13D3
	for <webhook@archiver.kernel.org>; Tue, 19 Sep 2023 15:25:38 +0000 (UTC)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
 by mx.groups.io with SMTP id smtpd.web10.12249.1695137137254958729
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 19 Sep 2023 08:25:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=au8Dr1VB;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.174, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-68fdcc37827so4808191b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 19 Sep 2023 08:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695137136; x=1695741936; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yELB+dtCWae7jcQ/eY9fJMyD1x0n508gqnEt7fVAtjs=;
        b=au8Dr1VBSYTh/WxumfWGQLoN8CI3rgqeE5HnvekGgyMBNjSuSP5/s1DsxCJHbK5DpI
         99cIXrQ+OHOHJ9AXgGkwSCEaEJ0YCqe7Y5Ay07CN/TtUSOygLv9Txv6ZkSGh6ZFgASzh
         E1jCQeXjepg+DsdPLaBH/TNd6x11Ufqper6p7a2UVh9bQ06AbO8fiKyt5IQC/0UWSzmM
         dMxc0oT7S9ikklQRn7KSYfnVFrXSaPWBBlD/8QLKFtrIEROOA9j1/AdIzSXpMBaNtN0x
         mt312BZNauvjBSz3SnHlsC9KpQb8hL8ba1wnlCpo3TwcS5jdCQsTsDF/nmwbgoZlvkgS
         JhCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695137136; x=1695741936;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yELB+dtCWae7jcQ/eY9fJMyD1x0n508gqnEt7fVAtjs=;
        b=F60QMOD3IgcfUJIC8XJ6vzOP0Bscb9GfP4IercfbUWzrDb5IOFQlvSK+te+qP2GZES
         tx+ZaDDfuI7meWZlrcw0Se7oIOIZxOXEVjjBKmqTeVxWtZAeh57J86sJ0EDPBVhITpfl
         Asw2tKGOZAtvSOTotKiXAu7/+AUFMEhx3FEUwHDApXZ0oKxgncxIOPaZrI3V+UpqPO0U
         mn558yAEg76H2EjYP+9QkhII9vXCmZUHXVivgr2GpGdIqbtMJeda8usmFzqPzfKUfP3V
         pmu5XM0f6TpVv1jxPNysX1fvLy/AHicgZTK5kxAxj5/mKEfWVtnyC3huVz3VONWyKlxa
         osfA==
X-Gm-Message-State: AOJu0Ywyfr+BtmOcQMsAROqKo2CLhltGNIeM868DFqonBCym/cFB01sT
	qP0UIGDpc1hoKLamgp/0PLHwztjlwzB7M9loLWD5wQ==
X-Google-Smtp-Source: AGHT+IFiNQPT063LLcKZ5npd0XzufGpLQLEjJhRi3pNwBtUY7Kd+BR4E4EZr6eA1OzXP/sABQByRhg==
X-Received: by 2002:a05:6a00:2e03:b0:68f:cdb8:ae33 with SMTP id fc3-20020a056a002e0300b0068fcdb8ae33mr4341451pfb.10.1695137135228;
        Tue, 19 Sep 2023 08:25:35 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p15-20020a62ab0f000000b00682a27905b9sm9084302pff.13.2023.09.19.08.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 08:25:34 -0700 (PDT)
Message-ID: <6509bd6e.620a0220.d188c.f2f5@mx.google.com>
Date: Tue, 19 Sep 2023 08:25:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.194-cip39
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip baseline: 128 runs,
 38 regressions (v5.10.194-cip39)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 19 Sep 2023 15:25:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13157

cip/linux-5.10.y-cip baseline: 128 runs, 38 regressions (v5.10.194-cip39)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig           | 1          =

bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | bcm283=
5_defconfig            | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =

fsl-ls1028a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

fsl-ls1028a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig+kselftest          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

imx6ul-14x14-evk             | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =

imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =

juno-uboot                   | arm64  | lab-broonie     | gcc-10   | cip://=
5.10.y-...64_defconfig | 1          =

juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

kontron-kbox-a-230-ls        | arm64  | lab-kontron     | gcc-10   | defcon=
fig+kselftest          | 1          =

kontron-sl28-var3-ads2       | arm64  | lab-kontron     | gcc-10   | defcon=
fig+kselftest          | 1          =

meson-g12b-a311d-khadas-vim3 | arm64  | lab-collabora   | gcc-10   | defcon=
fig+kselftest          | 1          =

mt8173-elm-hana              | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =

r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig+kselftest          | 1          =

r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

r8a77960-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

r8a77960-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig+kselftest          | 1          =

rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 4          =

rk3399-rock-pi-4b            | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

rk3399-rock-pi-4b            | arm64  | lab-collabora   | gcc-10   | defcon=
fig+kselftest          | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.194-cip39/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.194-cip39
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      ecda23c2ad8c5eae1f19054d0b67a7904546b7f4 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6509b5875fd40e17f68a0ab5

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6509b5885fd40e17f68a0abe
        failing since 248 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-09-19T14:51:29.095275  + set +x

    2023-09-19T14:51:29.101778  <8>[   11.722380] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11571911_1.4.2.3.1>

    2023-09-19T14:51:29.205786  / # #

    2023-09-19T14:51:29.306338  export SHELL=3D/bin/sh

    2023-09-19T14:51:29.306523  #

    2023-09-19T14:51:29.407053  / # export SHELL=3D/bin/sh. /lava-11571911/=
environment

    2023-09-19T14:51:29.407221  =


    2023-09-19T14:51:29.507715  / # . /lava-11571911/environment/lava-11571=
911/bin/lava-test-runner /lava-11571911/1

    2023-09-19T14:51:29.508015  =


    2023-09-19T14:51:29.513968  / # /lava-11571911/bin/lava-test-runner /la=
va-11571911/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6509b597f0f9ee4a458a0a73

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6509b597f0f9ee4a458a0a7c
        failing since 248 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-09-19T14:51:59.936302  + set<8>[   11.912075] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11571940_1.4.2.3.1>

    2023-09-19T14:51:59.936396   +x

    2023-09-19T14:52:00.040270  / # #

    2023-09-19T14:52:00.140864  export SHELL=3D/bin/sh

    2023-09-19T14:52:00.141094  #

    2023-09-19T14:52:00.241688  / # export SHELL=3D/bin/sh. /lava-11571940/=
environment

    2023-09-19T14:52:00.241878  =


    2023-09-19T14:52:00.342430  / # . /lava-11571940/environment/lava-11571=
940/bin/lava-test-runner /lava-11571940/1

    2023-09-19T14:52:00.342701  =


    2023-09-19T14:52:00.347631  / # /lava-11571940/bin/lava-test-runner /la=
va-11571940/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6509b99049d8383f008a0a43

  Results:     47 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6509b99049d8383f008a0a7c
        failing since 248 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-09-19T15:08:28.473641  + set +x
    2023-09-19T15:08:28.474167  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 118221_1.5.2=
.4.1>
    2023-09-19T15:08:28.588537  / # #
    2023-09-19T15:08:28.691605  export SHELL=3D/bin/sh
    2023-09-19T15:08:28.692379  #
    2023-09-19T15:08:28.794263  / # export SHELL=3D/bin/sh. /lava-118221/en=
vironment
    2023-09-19T15:08:28.795061  =

    2023-09-19T15:08:28.897126  / # . /lava-118221/environment/lava-118221/=
bin/lava-test-runner /lava-118221/1
    2023-09-19T15:08:28.898460  =

    2023-09-19T15:08:28.902130  / # /lava-118221/bin/lava-test-runner /lava=
-118221/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | bcm283=
5_defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/6509b263d7e463bdc08a0a65

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm/bcm2835_defconfig/gcc-10/lab-collabora/baseline-bcm2836-rpi-2-b.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm/bcm2835_defconfig/gcc-10/lab-collabora/baseline-bcm2836-rpi-2-b.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6509b263d7e463bdc08a0a6e
        failing since 55 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-09-19T14:42:25.653818  / # #

    2023-09-19T14:42:25.755812  export SHELL=3D/bin/sh

    2023-09-19T14:42:25.756518  #

    2023-09-19T14:42:25.857899  / # export SHELL=3D/bin/sh. /lava-11571652/=
environment

    2023-09-19T14:42:25.858598  =


    2023-09-19T14:42:25.960006  / # . /lava-11571652/environment/lava-11571=
652/bin/lava-test-runner /lava-11571652/1

    2023-09-19T14:42:25.961069  =


    2023-09-19T14:42:25.963542  / # /lava-11571652/bin/lava-test-runner /la=
va-11571652/1

    2023-09-19T14:42:26.043495  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-19T14:42:26.082509  + cd /lava-11571652/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6509b378ed1c3b51b28a0a50

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6509b378ed1c3b51b28a0a81
        failing since 248 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-09-19T14:42:30.541916  <8>[   21.655102] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 118277_1.5.2.4.1>
    2023-09-19T14:42:30.651622  / # #
    2023-09-19T14:42:30.754749  export SHELL=3D/bin/sh
    2023-09-19T14:42:30.755663  #
    2023-09-19T14:42:30.857705  / # export SHELL=3D/bin/sh. /lava-118277/en=
vironment
    2023-09-19T14:42:30.858668  =

    2023-09-19T14:42:30.960650  / # . /lava-118277/environment/lava-118277/=
bin/lava-test-runner /lava-118277/1
    2023-09-19T14:42:30.962118  =

    2023-09-19T14:42:30.965038  / # /lava-118277/bin/lava-test-runner /lava=
-118277/1
    2023-09-19T14:42:31.051262  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6509b61eeb771f995e8a0a91

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6509b61eeb771f995e8a0a98
        failing since 248 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-09-19T14:53:33.573909  <8>[   15.744763] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1010463_1.5.2.4.1>
    2023-09-19T14:53:33.685189  / # #
    2023-09-19T14:53:33.787396  export SHELL=3D/bin/sh
    2023-09-19T14:53:33.788102  #
    2023-09-19T14:53:33.889993  / # export SHELL=3D/bin/sh. /lava-1010463/e=
nvironment
    2023-09-19T14:53:33.890699  =

    2023-09-19T14:53:33.992595  / # . /lava-1010463/environment/lava-101046=
3/bin/lava-test-runner /lava-1010463/1
    2023-09-19T14:53:33.993751  =

    2023-09-19T14:53:34.000403  / # /lava-1010463/bin/lava-test-runner /lav=
a-1010463/1
    2023-09-19T14:53:34.094669  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6509b33703213e0bb58a0a62

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6509b33703213e0bb58a0a9c
        failing since 248 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-09-19T14:41:35.348075  <8>[   18.972881] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 118240_1.5.2.4.1>
    2023-09-19T14:41:35.457048  / # #
    2023-09-19T14:41:35.559034  export SHELL=3D/bin/sh
    2023-09-19T14:41:35.559732  #
    2023-09-19T14:41:35.661628  / # export SHELL=3D/bin/sh. /lava-118240/en=
vironment
    2023-09-19T14:41:35.662302  =

    2023-09-19T14:41:35.763938  / # . /lava-118240/environment/lava-118240/=
bin/lava-test-runner /lava-118240/1
    2023-09-19T14:41:35.764954  =

    2023-09-19T14:41:35.769442  / # /lava-118240/bin/lava-test-runner /lava=
-118240/1
    2023-09-19T14:41:35.875657  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6509b340a04bb551678a0a4c

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6509b340a04bb551678a0a53
        failing since 248 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-09-19T14:41:56.353626  + set +x
    2023-09-19T14:41:56.355684  <8>[   14.037838] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1010447_1.5.2.4.1>
    2023-09-19T14:41:56.465594  / # #
    2023-09-19T14:41:56.567916  export SHELL=3D/bin/sh
    2023-09-19T14:41:56.568354  #
    2023-09-19T14:41:56.669731  / # export SHELL=3D/bin/sh. /lava-1010447/e=
nvironment
    2023-09-19T14:41:56.670171  =

    2023-09-19T14:41:56.771589  / # . /lava-1010447/environment/lava-101044=
7/bin/lava-test-runner /lava-1010447/1
    2023-09-19T14:41:56.772437  =

    2023-09-19T14:41:56.774554  / # /lava-1010447/bin/lava-test-runner /lav=
a-1010447/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls1028a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6509b34b60df6b1f728a0a6e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1028a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1028a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6509b34b60df6b1f728a0a75
        failing since 190 days (last pass: v5.10.155-cip21, first fail: v5.=
10.173-cip28)

    2023-09-19T14:42:09.429646  + [   19.839296] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 1252182_1.5.2.4.1>
    2023-09-19T14:42:09.429962  set +x
    2023-09-19T14:42:09.535291  =

    2023-09-19T14:42:09.636524  / # #export SHELL=3D/bin/sh
    2023-09-19T14:42:09.636933  =

    2023-09-19T14:42:09.737899  / # export SHELL=3D/bin/sh. /lava-1252182/e=
nvironment
    2023-09-19T14:42:09.738371  =

    2023-09-19T14:42:09.839361  / # . /lava-1252182/environment/lava-125218=
2/bin/lava-test-runner /lava-1252182/1
    2023-09-19T14:42:09.840063  =

    2023-09-19T14:42:09.844297  / # /lava-1252182/bin/lava-test-runner /lav=
a-1252182/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls1028a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6509b6e1cede2471b48a0aca

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm64/defconfig+kselftest/gcc-10/lab-nxp/baseline-fsl-ls1028a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm64/defconfig+kselftest/gcc-10/lab-nxp/baseline-fsl-ls1028a-rdb.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6509b6e1cede2471b48a0=
acb
        new failure (last pass: v5.10.191-cip38-29-g9e1aa2001db8) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6509b5785fd40e17f68a0a53

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6509b5785fd40e17f68a0a5c
        failing since 158 days (last pass: v5.10.176-cip30, first fail: v5.=
10.177-cip31)

    2023-09-19T14:51:25.224387  + <8>[   10.408570] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11571902_1.4.2.3.1>

    2023-09-19T14:51:25.224490  set +x

    2023-09-19T14:51:25.326010  =


    2023-09-19T14:51:25.426530  / # #export SHELL=3D/bin/sh

    2023-09-19T14:51:25.426721  =


    2023-09-19T14:51:25.527269  / # export SHELL=3D/bin/sh. /lava-11571902/=
environment

    2023-09-19T14:51:25.527426  =


    2023-09-19T14:51:25.627911  / # . /lava-11571902/environment/lava-11571=
902/bin/lava-test-runner /lava-11571902/1

    2023-09-19T14:51:25.628236  =


    2023-09-19T14:51:25.632875  / # /lava-11571902/bin/lava-test-runner /la=
va-11571902/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6509b5775fd40e17f68a0a48

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6509b5775fd40e17f68a0a51
        failing since 158 days (last pass: v5.10.176-cip30, first fail: v5.=
10.177-cip31)

    2023-09-19T14:51:22.508385  <8>[   12.888835] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11571932_1.4.2.3.1>

    2023-09-19T14:51:22.511410  + set +x

    2023-09-19T14:51:22.616360  #

    2023-09-19T14:51:22.718831  / # #export SHELL=3D/bin/sh

    2023-09-19T14:51:22.719584  =


    2023-09-19T14:51:22.820966  / # export SHELL=3D/bin/sh. /lava-11571932/=
environment

    2023-09-19T14:51:22.821678  =


    2023-09-19T14:51:22.923119  / # . /lava-11571932/environment/lava-11571=
932/bin/lava-test-runner /lava-11571932/1

    2023-09-19T14:51:22.924222  =


    2023-09-19T14:51:22.929732  / # /lava-11571932/bin/lava-test-runner /la=
va-11571932/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6509b35860df6b1f728a0aa8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6509b35860df6b1f728a0ab1
        failing since 248 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-09-19T14:42:17.493206  / # #

    2023-09-19T14:42:17.595496  export SHELL=3D/bin/sh

    2023-09-19T14:42:17.596264  #

    2023-09-19T14:42:17.698104  / # export SHELL=3D/bin/sh. /lava-11571729/=
environment

    2023-09-19T14:42:17.698796  =


    2023-09-19T14:42:17.800701  / # . /lava-11571729/environment/lava-11571=
729/bin/lava-test-runner /lava-11571729/1

    2023-09-19T14:42:17.801881  =


    2023-09-19T14:42:17.816920  / # /lava-11571729/bin/lava-test-runner /la=
va-11571729/1

    2023-09-19T14:42:17.900866  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-19T14:42:17.901396  + cd /lava-11571729/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6509b5b8005a072ae38a0a95

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandb=
oard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandb=
oard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6509b5b8005a072ae38a0a9e
        failing since 248 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-09-19T14:52:33.716442  + set +x
    2023-09-19T14:52:33.716615  [   10.490846] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1000982_1.5.2.3.1>
    2023-09-19T14:52:33.825081  / # #
    2023-09-19T14:52:33.927147  export SHELL=3D/bin/sh
    2023-09-19T14:52:33.927736  #
    2023-09-19T14:52:34.029137  / # export SHELL=3D/bin/sh. /lava-1000982/e=
nvironment
    2023-09-19T14:52:34.029664  =

    2023-09-19T14:52:34.131025  / # . /lava-1000982/environment/lava-100098=
2/bin/lava-test-runner /lava-1000982/1
    2023-09-19T14:52:34.131733  =

    2023-09-19T14:52:34.134374  / # /lava-1000982/bin/lava-test-runner /lav=
a-1000982/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6509b3243e9c2b4f7d8a0a71

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandbo=
ard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandbo=
ard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6509b3243e9c2b4f7d8a0a7a
        failing since 248 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-09-19T14:41:32.101006  + set[    7.297261] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 1000979_1.5.2.3.1>
    2023-09-19T14:41:32.101204   +x
    2023-09-19T14:41:32.206960  / # #
    2023-09-19T14:41:32.308691  export SHELL=3D/bin/sh
    2023-09-19T14:41:32.309197  #
    2023-09-19T14:41:32.410461  / # export SHELL=3D/bin/sh. /lava-1000979/e=
nvironment
    2023-09-19T14:41:32.410910  =

    2023-09-19T14:41:32.512198  / # . /lava-1000979/environment/lava-100097=
9/bin/lava-test-runner /lava-1000979/1
    2023-09-19T14:41:32.512957  =

    2023-09-19T14:41:32.515263  / # /lava-1000979/bin/lava-test-runner /lav=
a-1000979/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6ul-14x14-evk             | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6509b387598379af2d8a0a67

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx6ul-14x14-evk.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx6ul-14x14-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6509b387598379af2d8a0a6e
        failing since 181 days (last pass: v5.10.145-cip17, first fail: v5.=
10.175-cip29)

    2023-09-19T14:42:52.765450  + set +x
    2023-09-19T14:42:52.768619  <8>[   29.394527] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1252184_1.5.2.4.1>
    2023-09-19T14:42:52.879013  / # #
    2023-09-19T14:42:54.034979  export SHELL=3D/bin/sh
    2023-09-19T14:42:54.040487  #
    2023-09-19T14:42:55.582252  / # export SHELL=3D/bin/sh. /lava-1252184/e=
nvironment
    2023-09-19T14:42:55.587876  =

    2023-09-19T14:42:58.400365  / # . /lava-1252184/environment/lava-125218=
4/bin/lava-test-runner /lava-1252184/1
    2023-09-19T14:42:58.406339  =

    2023-09-19T14:42:58.408024  / # /lava-1252184/bin/lava-test-runner /lav=
a-1252184/1 =

    ... (18 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6509b385598379af2d8a0a5c

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6509b385598379af2d8a0a63
        failing since 248 days (last pass: v5.10.155-cip21, first fail: v5.=
10.162-cip24)

    2023-09-19T14:42:46.237551  / # #
    2023-09-19T14:42:47.393463  export SHELL=3D/bin/sh
    2023-09-19T14:42:47.399106  #
    2023-09-19T14:42:48.941030  / # export SHELL=3D/bin/sh. /lava-1252183/e=
nvironment
    2023-09-19T14:42:48.946699  =

    2023-09-19T14:42:48.947109  / # . /lava-1252183/environment
    2023-09-19T14:42:51.759323  / # /lava-1252183/bin/lava-test-runner /lav=
a-1252183/1
    2023-09-19T14:42:51.776331  /lava-1252183/bin/lava-test-runner /lava-12=
52183/1
    2023-09-19T14:42:51.862522  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-19T14:42:51.862902  + cd /lava-1252183/1/tests/1_bootrr =

    ... (19 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
juno-uboot                   | arm64  | lab-broonie     | gcc-10   | cip://=
5.10.y-...64_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6509bd3da8f2fd8a758a0a42

  Results:     47 PASS, 13 FAIL, 1 SKIP
  Full config: cip://5.10.y-cip/arm64/qemu_arm64_defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm64/cip---5.10.y-cip-arm64-qemu_arm64_defconfig/gcc-10/lab-broonie=
/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm64/cip---5.10.y-cip-arm64-qemu_arm64_defconfig/gcc-10/lab-broonie=
/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6509bd3da8f2fd8a758a0a7a
        failing since 22 days (last pass: v5.10.186-cip37-27-gd6d928db0a620=
, first fail: v5.10.191-cip38)

    2023-09-19T15:24:22.414404  / # #
    2023-09-19T15:24:22.517164  export SHELL=3D/bin/sh
    2023-09-19T15:24:22.517969  #
    2023-09-19T15:24:22.619954  / # export SHELL=3D/bin/sh. /lava-118286/en=
vironment
    2023-09-19T15:24:22.620718  =

    2023-09-19T15:24:22.722685  / # . /lava-118286/environment/lava-118286/=
bin/lava-test-runner /lava-118286/1
    2023-09-19T15:24:22.723917  =

    2023-09-19T15:24:22.738725  / # /lava-118286/bin/lava-test-runner /lava=
-118286/1
    2023-09-19T15:24:22.793589  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-19T15:24:22.794131  + cd /lava-118286/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6509bc4d1c32db446d8a0a55

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6509bc4d1c32db446d8a0a94
        failing since 5 days (last pass: v5.10.191-cip38-2-g09e5ecd8645b, f=
irst fail: v5.10.191-cip38-29-g9e1aa2001db8)

    2023-09-19T15:20:20.045739  / # #
    2023-09-19T15:20:20.148634  export SHELL=3D/bin/sh
    2023-09-19T15:20:20.149357  #
    2023-09-19T15:20:20.251313  / # export SHELL=3D/bin/sh. /lava-118258/en=
vironment
    2023-09-19T15:20:20.252075  =

    2023-09-19T15:20:20.354133  / # . /lava-118258/environment/lava-118258/=
bin/lava-test-runner /lava-118258/1
    2023-09-19T15:20:20.355384  =

    2023-09-19T15:20:20.369568  / # /lava-118258/bin/lava-test-runner /lava=
-118258/1
    2023-09-19T15:20:20.428404  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-19T15:20:20.428918  + cd /lava-118258/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
kontron-kbox-a-230-ls        | arm64  | lab-kontron     | gcc-10   | defcon=
fig+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6509b6cf63c9fc59388a0a7e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm64/defconfig+kselftest/gcc-10/lab-kontron/baseline-kontron-kbox-a=
-230-ls.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm64/defconfig+kselftest/gcc-10/lab-kontron/baseline-kontron-kbox-a=
-230-ls.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6509b6cf63c9fc59388a0=
a7f
        new failure (last pass: v5.10.191-cip38-29-g9e1aa2001db8) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
kontron-sl28-var3-ads2       | arm64  | lab-kontron     | gcc-10   | defcon=
fig+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6509b6bccede2471b48a0a42

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm64/defconfig+kselftest/gcc-10/lab-kontron/baseline-kontron-sl28-v=
ar3-ads2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm64/defconfig+kselftest/gcc-10/lab-kontron/baseline-kontron-sl28-v=
ar3-ads2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6509b6bccede2471b48a0=
a43
        new failure (last pass: v5.10.191-cip38-29-g9e1aa2001db8) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64  | lab-collabora   | gcc-10   | defcon=
fig+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6509b6389df0cd72618a0aa2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm64/defconfig+kselftest/gcc-10/lab-collabora/baseline-meson-g12b-a=
311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm64/defconfig+kselftest/gcc-10/lab-collabora/baseline-meson-g12b-a=
311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6509b6389df0cd72618a0=
aa3
        new failure (last pass: v5.10.191-cip38-29-g9e1aa2001db8) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6509b6dc63c9fc59388a0aca

  Results:     28 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt817=
3-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt817=
3-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6509b6dc63c9fc59388a0aea
        failing since 248 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-09-19T14:57:15.771916  <8>[   15.652799] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-09-19T14:57:15.772475  + set +x

    2023-09-19T14:57:15.778394  <8>[   15.662187] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11571975_1.5.2.3.1>

    2023-09-19T14:57:15.885681  / # #

    2023-09-19T14:57:15.988074  export SHELL=3D/bin/sh

    2023-09-19T14:57:15.988916  #

    2023-09-19T14:57:16.090564  / # export SHELL=3D/bin/sh. /lava-11571975/=
environment

    2023-09-19T14:57:16.091411  =


    2023-09-19T14:57:16.193173  / # . /lava-11571975/environment/lava-11571=
975/bin/lava-test-runner /lava-11571975/1

    2023-09-19T14:57:16.194442  =

 =

    ... (22 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6509b1be4f89f3776d8a0a5c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6509b1be4f89f3776d8a0=
a5d
        failing since 5 days (last pass: v5.10.191-cip38-2-g09e5ecd8645b, f=
irst fail: v5.10.191-cip38-17-g8dad6b499cfe5) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6509b39de64ad0a3a68a0a81

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6509b39de64ad0a3a68a0a88
        failing since 41 days (last pass: v5.10.182-cip35-1-g7cde3fba93966,=
 first fail: v5.10.186-cip37-13-g260094841fe1a)

    2023-09-19T14:43:26.679078  + set +x
    2023-09-19T14:43:26.682215  <8>[   83.895283] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1010457_1.5.2.4.1>
    2023-09-19T14:43:26.790919  / # #
    2023-09-19T14:43:28.254602  export SHELL=3D/bin/sh
    2023-09-19T14:43:28.275500  #
    2023-09-19T14:43:28.275922  / # export SHELL=3D/bin/sh
    2023-09-19T14:43:30.233393  / # . /lava-1010457/environment
    2023-09-19T14:43:33.834414  /lava-1010457/bin/lava-test-runner /lava-10=
10457/1
    2023-09-19T14:43:33.855832  . /lava-1010457/environment
    2023-09-19T14:43:33.856247  / # /lava-1010457/bin/lava-test-runner /lav=
a-1010457/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6509b737d65831d2748a0ab5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774a1-hi=
hope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774a1-hi=
hope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6509b737d65831d2748a0abc
        failing since 55 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-09-19T14:58:33.883945  + set +x
    2023-09-19T14:58:33.884071  <8>[   83.882628] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1010478_1.5.2.4.1>
    2023-09-19T14:58:33.989772  / # #
    2023-09-19T14:58:35.449750  export SHELL=3D/bin/sh
    2023-09-19T14:58:35.470209  #
    2023-09-19T14:58:35.470380  / # export SHELL=3D/bin/sh
    2023-09-19T14:58:37.423079  / # . /lava-1010478/environment
    2023-09-19T14:58:41.015625  /lava-1010478/bin/lava-test-runner /lava-10=
10478/1
    2023-09-19T14:58:41.036212  . /lava-1010478/environment
    2023-09-19T14:58:41.036333  / # /lava-1010478/bin/lava-test-runner /lav=
a-1010478/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6509b402d5251adeea8a0a42

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6509b402d5251adeea8a0a49
        failing since 55 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-09-19T14:45:02.551783  / # #
    2023-09-19T14:45:04.014435  export SHELL=3D/bin/sh
    2023-09-19T14:45:04.035081  #
    2023-09-19T14:45:04.035289  / # export SHELL=3D/bin/sh
    2023-09-19T14:45:05.991276  / # . /lava-1010452/environment
    2023-09-19T14:45:09.591761  /lava-1010452/bin/lava-test-runner /lava-10=
10452/1
    2023-09-19T14:45:09.612595  . /lava-1010452/environment
    2023-09-19T14:45:09.612706  / # /lava-1010452/bin/lava-test-runner /lav=
a-1010452/1
    2023-09-19T14:45:09.690986  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-19T14:45:09.691205  + cd /lava-1010452/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6509b6facede2471b48a0adb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6509b6facede2471b48a0=
adc
        new failure (last pass: v5.10.191-cip38-29-g9e1aa2001db8) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6509b7d6c9f8aedb208a0b23

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774c0-ek=
874.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774c0-ek=
874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6509b7d6c9f8aedb208a0b2a
        failing since 55 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-09-19T15:01:20.246983  / # #
    2023-09-19T15:01:21.710989  export SHELL=3D/bin/sh
    2023-09-19T15:01:21.731598  #
    2023-09-19T15:01:21.731805  / # export SHELL=3D/bin/sh
    2023-09-19T15:01:23.688486  / # . /lava-1010474/environment
    2023-09-19T15:01:27.288548  /lava-1010474/bin/lava-test-runner /lava-10=
10474/1
    2023-09-19T15:01:27.309375  . /lava-1010474/environment
    2023-09-19T15:01:27.309485  / # /lava-1010474/bin/lava-test-runner /lav=
a-1010474/1
    2023-09-19T15:01:27.343768  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-19T15:01:27.392965  + cd /lava-1010474/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6509b32d24006bf33c8a0acf

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6509b32d24006bf33c8a0ad8
        failing since 55 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-09-19T14:45:48.146627  / # #

    2023-09-19T14:45:48.247186  export SHELL=3D/bin/sh

    2023-09-19T14:45:48.247322  #

    2023-09-19T14:45:48.347793  / # export SHELL=3D/bin/sh. /lava-11571721/=
environment

    2023-09-19T14:45:48.347968  =


    2023-09-19T14:45:48.448483  / # . /lava-11571721/environment/lava-11571=
721/bin/lava-test-runner /lava-11571721/1

    2023-09-19T14:45:48.448698  =


    2023-09-19T14:45:48.460223  / # /lava-11571721/bin/lava-test-runner /la=
va-11571721/1

    2023-09-19T14:45:48.503795  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-19T14:45:48.519511  + cd /lav<8>[   16.435593] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11571721_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6509b6d963c9fc59388a0ac7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm64/defconfig+kselftest/gcc-10/lab-collabora/baseline-r8a77960-ulc=
b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm64/defconfig+kselftest/gcc-10/lab-collabora/baseline-r8a77960-ulc=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6509b6d963c9fc59388a0=
ac8
        new failure (last pass: v5.10.191-cip38-29-g9e1aa2001db8) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 4          =


  Details:     https://kernelci.org/test/plan/id/6509b44457f27875418a0a42

  Results:     63 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-j=
aq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-j=
aq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-i2c-present: https://kernelci.or=
g/test/case/id/6509b44457f27875418a0a75
        failing since 246 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-09-19T14:50:34.275169  FIRST,<8>[   18.648277] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>

    2023-09-19T14:50:34.277043   INC default to 1.

    2023-09-19T14:50:34.277332  =


    2023-09-19T14:50:34.280769  	-w	Pad to last with leading zeros

    2023-09-19T14:50:34.283291  	-s SEP	String separator

    2023-09-19T14:50:34.287202  /lava-11571731/1/../bin/lava-test-case

    2023-09-19T14:50:34.293142  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.

    2023-09-19T14:50:34.293383  =

   =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/6509b44457f27875418a0a76
        failing since 246 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-09-19T14:50:34.252955  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC)<8=
>[   18.629210] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-09-19T14:50:34.254936   multi-call binary.

    2023-09-19T14:50:34.255004  =


    2023-09-19T14:50:34.259508  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-09-19T14:50:34.259569  =


    2023-09-19T14:50:34.264675  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/6509b44457f27875418a0a77
        failing since 246 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-09-19T14:50:34.234039  <8>[   18.611519] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6509b44457f27875418a0a8b
        failing since 246 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-09-19T14:50:22.175179  <8>[    6.552719] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-09-19T14:50:22.184705  + <8>[    6.565061] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11571731_1.5.2.3.1>

    2023-09-19T14:50:22.185084  set +x

    2023-09-19T14:50:22.290861  #

    2023-09-19T14:50:22.291759  =


    2023-09-19T14:50:22.393160  / # #export SHELL=3D/bin/sh

    2023-09-19T14:50:22.393824  =


    2023-09-19T14:50:22.495174  / # export SHELL=3D/bin/sh. /lava-11571731/=
environment

    2023-09-19T14:50:22.495843  =


    2023-09-19T14:50:22.597119  / # . /lava-11571731/environment/lava-11571=
731/bin/lava-test-runner /lava-11571731/1
 =

    ... (20 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6509b35360df6b1f728a0a7b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6509b35360df6b1f728a0a84
        new failure (last pass: v5.10.191-cip38-29-g9e1aa2001db8)

    2023-09-19T14:42:17.209124  / # #

    2023-09-19T14:42:18.469522  export SHELL=3D/bin/sh

    2023-09-19T14:42:18.480425  #

    2023-09-19T14:42:18.480881  / # export SHELL=3D/bin/sh

    2023-09-19T14:42:20.223943  / # . /lava-11571719/environment

    2023-09-19T14:42:23.427649  /lava-11571719/bin/lava-test-runner /lava-1=
1571719/1

    2023-09-19T14:42:23.439033  . /lava-11571719/environment

    2023-09-19T14:42:23.444215  / # /lava-11571719/bin/lava-test-runner /la=
va-11571719/1

    2023-09-19T14:42:23.494287  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-19T14:42:23.494754  + cd /lava-11571719/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora   | gcc-10   | defcon=
fig+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6509b6e763c9fc59388a0af2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm64/defconfig+kselftest/gcc-10/lab-collabora/baseline-rk3399-rock-=
pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm64/defconfig+kselftest/gcc-10/lab-collabora/baseline-rk3399-rock-=
pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6509b6e763c9fc59388a0=
af3
        new failure (last pass: v5.10.191-cip38-29-g9e1aa2001db8) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6509b32b60df6b1f728a0a42

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6509b32c60df6b1f728a0a4b
        failing since 55 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-09-19T14:46:02.850706  / # #

    2023-09-19T14:46:02.952811  export SHELL=3D/bin/sh

    2023-09-19T14:46:02.953518  #

    2023-09-19T14:46:03.054921  / # export SHELL=3D/bin/sh. /lava-11571709/=
environment

    2023-09-19T14:46:03.055625  =


    2023-09-19T14:46:03.157109  / # . /lava-11571709/environment/lava-11571=
709/bin/lava-test-runner /lava-11571709/1

    2023-09-19T14:46:03.158175  =


    2023-09-19T14:46:03.175114  / # /lava-11571709/bin/lava-test-runner /la=
va-11571709/1

    2023-09-19T14:46:03.234273  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-19T14:46:03.234775  + cd /lava-1157170<8>[   18.390673] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11571709_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

