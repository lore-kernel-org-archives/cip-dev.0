Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B813C64EC4
	for <webhook@archiver.kernel.org>; Fri,  3 Mar 2023 16:20:17 +0000 (UTC)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
 by mx.groups.io with SMTP id smtpd.web11.27741.1677860407945440350
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 03 Mar 2023 08:20:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=AID+HWn7;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.47, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f47.google.com with SMTP id y2so3033880pjg.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 03 Mar 2023 08:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1677860407;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=C0I3HrpaO6IlvxAgb7zIholEGZQgJ9j3nZ0bUwJCVMg=;
        b=AID+HWn7ItUN7I0c3WSHIC6gr7B33o1nBpAMS/6a3A5s1voUeu1WmkGWhUvgY5sO2h
         nSxaj1iXMVSGMouBTayRqiUtCPVU92K4np9G3pfVyh7djEQS3HxO2kxBfbXt3fo72lsn
         7qmITuTS+jGOf8Oen19y9X4/Z4WNnflY9cx9GiGwb1n4zs5FZCY/kGQVtkmPjylFjB1q
         UTvvZYButydO1ef9NNFjod2IHftKi2ALTbh+mQEE98VfcJ/MUYXBPh9oBohP5gi7BCh6
         /kTT137jDhKHc2w7kq3EPeTQX/9FhoXySxKcJN2FV6jSC6x6UpV6fuhEKi0ZUU/nmHqn
         uchA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677860407;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C0I3HrpaO6IlvxAgb7zIholEGZQgJ9j3nZ0bUwJCVMg=;
        b=oi2JVDgEaYhupgkVyHOze689A5sJhiZO0S57gTbPauUBgzjM5+wdDjDJZhPx4YryKm
         tAc2GYeeW5EDKw/rp5MhMa39LPADp63HQ6URNF+RSr56WyIvOzThvOaCs+z9+BD5D0ha
         urz4QldbqIO96QRiAG57/wgaeJhlvXqtPW/0Rl+CW0zeAaQJqWQiRmoRtNUvcRY/PyOW
         jZI+eQond2GyD+MHdBKgXoRATWLDvUbv9fyOWnNsoMt0JCVts7qLkOciNcCppxQ+6Ruf
         gAzrjGUAWmAzu05xAllC+B1bs4AOyVCPrZ7VZYlo2B3vlEVrfYP+/IpyRpIjqzDME8pS
         uvQg==
X-Gm-Message-State: AO0yUKVOGcCdndH8ytcmbd+J8niNUjhd5HkNhVUkZgCZ9B96EFTUQY9x
	/TH23kdtpvWZW0drQF0f+Vihn9NjZ/h54NZpCU/2/A==
X-Google-Smtp-Source: AK7set+UaIQL5yvRTPzrr5xC6igHjvNz5A1F6ZSJ8gXp4nmVW0tzH2E1yFlWiUVB//ynr0GmMzeB3w==
X-Received: by 2002:a17:902:d48b:b0:19a:7622:23e5 with SMTP id c11-20020a170902d48b00b0019a762223e5mr3167437plg.4.1677860406028;
        Fri, 03 Mar 2023 08:20:06 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b2-20020a170903228200b001964c8164aasm1710113plh.129.2023.03.03.08.20.05
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 08:20:05 -0800 (PST)
Message-ID: <64021e35.170a0220.a2a44.36fe@mx.google.com>
Date: Fri, 03 Mar 2023 08:20:05 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.19.273-cip92-24-g2070ce514972
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 107 runs,
 39 regressions (v4.19.273-cip92-24-g2070ce514972)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Mar 2023 16:20:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10919

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 107 runs, 39 regressio=
ns (v4.19.273-cip92-24-g2070ce514972)

Regressions Summary
-------------------

platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus  | x86_64 | lab-collabora   | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C523NA-A20057-coral   | x86_64 | lab-collabora   | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

beaglebone-black           | arm    | lab-broonie     | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black           | arm    | lab-cip         | gcc-10   | multi_v7=
_defconfig           | 1          =

dove-cubox                 | arm    | lab-pengutronix | gcc-10   | mvebu_v7=
_defconfig           | 1          =

imx6q-sabrelite            | arm    | lab-collabora   | gcc-10   | multi_v7=
_defconfig           | 1          =

imx6qp-wandboard-revd1     | arm    | lab-pengutronix | gcc-10   | imx_v6_v=
7_defconfig          | 1          =

imx6qp-wandboard-revd1     | arm    | lab-pengutronix | gcc-10   | multi_v7=
_defconfig           | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =

r8a7743-iwg20d-q7          | arm    | lab-cip         | gcc-10   | shmobile=
_defconfig           | 1          =

rk3288-veyron-jaq          | arm    | lab-collabora   | gcc-10   | multi_v7=
_defconfig           | 3          =

rk3399-gru-kevin           | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 5          =

sun50i-a64-pine64-plus     | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64         | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =

tegra124-nyan-big          | arm    | lab-collabora   | gcc-10   | multi_v7=
_defconfig           | 1          =

tegra124-nyan-big          | arm    | lab-collabora   | gcc-10   | tegra_de=
fconfig              | 1          =

zynqmp-zcu102              | arm64  | lab-cip         | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

zynqmp-zcu102              | arm64  | lab-cip         | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.273-cip92-24-g2070ce514972/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.273-cip92-24-g2070ce514972
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      2070ce514972cfaa8912c58feffcc824d465c865 =



Test Regressions
---------------- =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus  | x86_64 | lab-collabora   | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/640216da5039d2366b8c863b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/baseline-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/baseline-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230224.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/640216da5039d2366b8c8644
        failing since 43 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-03T15:48:18.866648  + set +x

    2023-03-03T15:48:18.872985  <8>[   10.327785] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9406234_1.4.2.3.1>

    2023-03-03T15:48:18.975615  =


    2023-03-03T15:48:19.076324  / # #export SHELL=3D/bin/sh

    2023-03-03T15:48:19.076542  =


    2023-03-03T15:48:19.177450  / # export SHELL=3D/bin/sh. /lava-9406234/e=
nvironment

    2023-03-03T15:48:19.177675  =


    2023-03-03T15:48:19.278449  / # . /lava-9406234/environment/lava-940623=
4/bin/lava-test-runner /lava-9406234/1

    2023-03-03T15:48:19.278726  =


    2023-03-03T15:48:19.283814  / # /lava-9406234/bin/lava-test-runner /lav=
a-9406234/1
 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral   | x86_64 | lab-collabora   | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64021571d922d41d338c8649

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/baseline-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/baseline-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230224.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64021571d922d41d338c8652
        failing since 43 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-03T15:42:22.776453  + <8>[   10.271101] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 9406247_1.4.2.3.1>

    2023-03-03T15:42:22.779681  set +x

    2023-03-03T15:42:22.881372  /#

    2023-03-03T15:42:22.982661   # #export SHELL=3D/bin/sh

    2023-03-03T15:42:22.982914  =


    2023-03-03T15:42:23.083897  / # export SHELL=3D/bin/sh. /lava-9406247/e=
nvironment

    2023-03-03T15:42:23.084159  =


    2023-03-03T15:42:23.185144  / # . /lava-9406247/environment/lava-940624=
7/bin/lava-test-runner /lava-9406247/1

    2023-03-03T15:42:23.185486  =


    2023-03-03T15:42:23.190895  / # /lava-9406247/bin/lava-test-runner /lav=
a-9406247/1
 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
beaglebone-black           | arm    | lab-broonie     | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6402166dee1ad8b4f58c8650

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm/multi_v7_defconfig/gcc-10=
/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm/multi_v7_defconfig/gcc-10=
/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230224.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6402166dee1ad8b4f58c8659
        failing since 43 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-03T15:46:44.300375  <8>[   11.811962] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 92042_1.5.2.4.1>
    2023-03-03T15:46:44.409442  / # #
    2023-03-03T15:46:44.512517  export SHELL=3D/bin/sh
    2023-03-03T15:46:44.513434  #
    2023-03-03T15:46:44.513878  / # export SHELL=3D/bin/sh<6>[   12.005957]=
 usb 1-1: new low-speed USB device number 3 using musb-hdrc
    2023-03-03T15:46:44.615858  . /lava-92042/environment
    2023-03-03T15:46:44.616801  =

    2023-03-03T15:46:44.718899  / # . /lava-92042/environment/lava-92042/bi=
n/lava-test-runner /lava-92042/1
    2023-03-03T15:46:44.720334  =

    2023-03-03T15:46:44.720737  / # <3>[   12.155997] usb 1-1: device descr=
iptor read/64, error -71 =

    ... (17 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
beaglebone-black           | arm    | lab-cip         | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6402169a403287176e8c8638

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm/multi_v7_defconfig/gcc-10=
/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm/multi_v7_defconfig/gcc-10=
/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230224.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6402169a403287176e8c863f
        failing since 43 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-03T15:47:17.727313  + set +x
    2023-03-03T15:47:17.729378  <8>[    9.803511] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 864632_1.5.2.4.1>
    2023-03-03T15:47:17.838020  / # #
    2023-03-03T15:47:17.940017  export SHELL=3D/bin/sh
    2023-03-03T15:47:17.940473  #
    2023-03-03T15:47:18.041910  / # export SHELL=3D/bin/sh. /lava-864632/en=
vironment
    2023-03-03T15:47:18.042370  =

    2023-03-03T15:47:18.143849  / # . /lava-864632/environment/lava-864632/=
bin/lava-test-runner /lava-864632/1
    2023-03-03T15:47:18.144605  =

    2023-03-03T15:47:18.146249  / # /lava-864632/bin/lava-test-runner /lava=
-864632/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
dove-cubox                 | arm    | lab-pengutronix | gcc-10   | mvebu_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/640215b2c9116fe0ee8c869e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: mvebu_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm/mvebu_v7_defconfig/gcc-10=
/lab-pengutronix/baseline-dove-cubox.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm/mvebu_v7_defconfig/gcc-10=
/lab-pengutronix/baseline-dove-cubox.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230224.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/640215b2c9116fe0ee8c86a7
        failing since 43 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-03T15:43:35.363249  + set +x
    2023-03-03T15:43:35.363399  [    4.242750] <LAVA_SIGNAL_ENDRUN 0_dmesg =
914381_1.5.2.3.1>
    2023-03-03T15:43:35.469825  / # #
    2023-03-03T15:43:35.571449  export SHELL=3D/bin/sh
    2023-03-03T15:43:35.571826  #
    2023-03-03T15:43:35.672987  / # export SHELL=3D/bin/sh. /lava-914381/en=
vironment
    2023-03-03T15:43:35.673441  =

    2023-03-03T15:43:35.774607  / # . /lava-914381/environment/lava-914381/=
bin/lava-test-runner /lava-914381/1
    2023-03-03T15:43:35.775359  =

    2023-03-03T15:43:35.777714  / # /lava-914381/bin/lava-test-runner /lava=
-914381/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx6q-sabrelite            | arm    | lab-collabora   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6402166111cb2ab2f88c864d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm/multi_v7_defconfig/gcc-10=
/lab-collabora/baseline-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm/multi_v7_defconfig/gcc-10=
/lab-collabora/baseline-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230224.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6402166111cb2ab2f88c8656
        failing since 43 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-03T15:46:23.088647  / # #

    2023-03-03T15:46:23.191500  export SHELL=3D/bin/sh

    2023-03-03T15:46:23.192314  #

    2023-03-03T15:46:23.294356  / # export SHELL=3D/bin/sh. /lava-9406447/e=
nvironment

    2023-03-03T15:46:23.295232  =


    2023-03-03T15:46:23.397570  / # . /lava-9406447/environment/lava-940644=
7/bin/lava-test-runner /lava-9406447/1

    2023-03-03T15:46:23.398890  =


    2023-03-03T15:46:23.410745  / # /lava-9406447/bin/lava-test-runner /lav=
a-9406447/1

    2023-03-03T15:46:23.514387  + export 'TESTRUN_ID=3D1_bootrr'

    2023-03-03T15:46:23.514962  + cd /lava-9406447/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx6qp-wandboard-revd1     | arm    | lab-pengutronix | gcc-10   | imx_v6_v=
7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64021332107f4f8e228c8687

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm/imx_v6_v7_defconfig/gcc-1=
0/lab-pengutronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm/imx_v6_v7_defconfig/gcc-1=
0/lab-pengutronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230224.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64021332107f4f8e228c8690
        failing since 43 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-03T15:32:42.187588  + set +x
    2023-03-03T15:32:42.187761  [    7.036911] <LAVA_SIGNAL_ENDRUN 0_dmesg =
914360_1.5.2.3.1>
    2023-03-03T15:32:42.295545  / # #
    2023-03-03T15:32:42.397028  export SHELL=3D/bin/sh
    2023-03-03T15:32:42.397408  #
    2023-03-03T15:32:42.498558  / # export SHELL=3D/bin/sh. /lava-914360/en=
vironment
    2023-03-03T15:32:42.498907  =

    2023-03-03T15:32:42.600052  / # . /lava-914360/environment/lava-914360/=
bin/lava-test-runner /lava-914360/1
    2023-03-03T15:32:42.600541  =

    2023-03-03T15:32:42.603777  / # /lava-914360/bin/lava-test-runner /lava=
-914360/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx6qp-wandboard-revd1     | arm    | lab-pengutronix | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6402165311cb2ab2f88c863e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm/multi_v7_defconfig/gcc-10=
/lab-pengutronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm/multi_v7_defconfig/gcc-10=
/lab-pengutronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230224.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6402165311cb2ab2f88c8647
        failing since 43 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-03T15:46:19.329572  + set +x
    2023-03-03T15:46:19.329738  [    4.960921] <LAVA_SIGNAL_ENDRUN 0_dmesg =
914393_1.5.2.3.1>
    2023-03-03T15:46:19.435837  / # #
    2023-03-03T15:46:19.537309  export SHELL=3D/bin/sh
    2023-03-03T15:46:19.537693  #
    2023-03-03T15:46:19.638853  / # export SHELL=3D/bin/sh. /lava-914393/en=
vironment
    2023-03-03T15:46:19.639259  =

    2023-03-03T15:46:19.740695  / # . /lava-914393/environment/lava-914393/=
bin/lava-test-runner /lava-914393/1
    2023-03-03T15:46:19.741236  =

    2023-03-03T15:46:19.743650  / # /lava-914393/bin/lava-test-runner /lava=
-914393/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64021821e18d7f95c78c868a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230224.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64021821e18d7f95c78c8=
68b
        failing since 288 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6402192544fce0be2b8c864a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230224.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6402192544fce0be2b8c8=
64b
        failing since 288 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6402158d39fb4b10fa8c86fc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230224.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6402158d39fb4b10fa8c8=
6fd
        failing since 288 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/640216295bc8a8bc718c871a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm64/defconfig/gcc-10/lab-co=
llabora/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm64/defconfig/gcc-10/lab-co=
llabora/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230224.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640216295bc8a8bc718c8=
71b
        failing since 288 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/640218fd97a51710738c8660

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230224.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640218fd97a51710738c8=
661
        failing since 288 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64021961e76268f4a18c8666

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230224.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64021961e76268f4a18c8=
667
        failing since 288 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64021619e151b3ee118c864a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230224.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64021619e151b3ee118c8=
64b
        failing since 288 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64021641d987f69edb8c867a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm64/defconfig/gcc-10/lab-co=
llabora/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm64/defconfig/gcc-10/lab-co=
llabora/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230224.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64021641d987f69edb8c8=
67b
        failing since 288 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64021835ed52e360618c8647

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230224.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64021835ed52e360618c8=
648
        failing since 288 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6402191197a51710738c868e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230224.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6402191197a51710738c8=
68f
        failing since 288 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6402158e4bcfcc21bf8c8680

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230224.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6402158e4bcfcc21bf8c8=
681
        failing since 288 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/640215a1e0918906ab8c867d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm64/defconfig/gcc-10/lab-co=
llabora/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm64/defconfig/gcc-10/lab-co=
llabora/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230224.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640215a1e0918906ab8c8=
67e
        failing since 288 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/640217f9e18d7f95c78c867a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230224.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640217f9e18d7f95c78c8=
67b
        failing since 288 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64021989851e97c71d8c8643

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230224.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64021989851e97c71d8c8=
644
        failing since 288 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/640215748006d843248c870e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230224.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640215748006d843248c8=
70f
        failing since 288 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64021665b5159b93988c8694

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm64/defconfig/gcc-10/lab-co=
llabora/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm64/defconfig/gcc-10/lab-co=
llabora/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230224.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64021665b5159b93988c8=
695
        failing since 288 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
r8a7743-iwg20d-q7          | arm    | lab-cip         | gcc-10   | shmobile=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/640216feb7a4361e278c8658

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm/shmobile_defconfig/gcc-10=
/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm/shmobile_defconfig/gcc-10=
/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230224.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640216feb7a4361e278c8=
659
        new failure (last pass: v4.19.273-cip92-14-ga8d1f73f2a28) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
rk3288-veyron-jaq          | arm    | lab-collabora   | gcc-10   | multi_v7=
_defconfig           | 3          =


  Details:     https://kernelci.org/test/plan/id/64021664b5159b93988c863b

  Results:     61 PASS, 8 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm/multi_v7_defconfig/gcc-10=
/lab-collabora/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm/multi_v7_defconfig/gcc-10=
/lab-collabora/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230224.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/64021664b5159b93988c866f
        failing since 41 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-03T15:46:16.772262  BusyBox v1.31.1 (2023-02-24 15:56:01 UTC)<8=
>[   15.199005] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-03-03T15:46:16.775186   multi-call binary.

    2023-03-03T15:46:16.775716  =


    2023-03-03T15:46:16.789216  Usage: seq [-w] [-s SEP] [FIRST [INC]] LA<8=
>[   15.217533] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-cec-present RESULT=3Dfail>
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/64021664b5159b93988c8670
        failing since 41 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-03T15:46:16.753556  /lava-9406451/1/../bin/lava-test-case<8>[  =
 15.181614] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-probed RES=
ULT=3Dpass>

    2023-03-03T15:46:16.753762  =

   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64021664b5159b93988c8683
        failing since 41 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-03T15:46:12.931618  + <8>[   11.363506] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 9406451_1.5.2.3.1>

    2023-03-03T15:46:12.933365  set +x

    2023-03-03T15:46:13.040233  =


    2023-03-03T15:46:13.141732  / # #export SHELL=3D/bin/sh

    2023-03-03T15:46:13.142279  =


    2023-03-03T15:46:13.243532  / # export SHELL=3D/bin/sh. /lava-9406451/e=
nvironment

    2023-03-03T15:46:13.243920  =


    2023-03-03T15:46:13.345229  / # . /lava-9406451/environment/lava-940645=
1/bin/lava-test-runner /lava-9406451/1

    2023-03-03T15:46:13.345982  =


    2023-03-03T15:46:13.348445  / # /lava-9406451/bin/lava-test-runner /lav=
a-9406451/1
 =

    ... (17 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
rk3399-gru-kevin           | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 5          =


  Details:     https://kernelci.org/test/plan/id/640214abbd18c1a7408c8670

  Results:     79 PASS, 9 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230224.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/case/id=
/640214abbd18c1a7408c8696
        failing since 354 days (last pass: v4.19.229-cip67-111-g5c3c0b39cf3=
b, first fail: v4.19.231-cip68-123-g92e3e7f3d4df)

    2023-03-03T15:38:54.555654  /lava-9406009/1/../bin/lava-test-case

    2023-03-03T15:38:54.563967  <8>[   35.964315] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rk3399-gru-sound-driver-rt5514-present: https://kernelc=
i.org/test/case/id/640214abbd18c1a7408c86ab
        failing since 43 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-03T15:38:53.053181  of INC.

    2023-03-03T15:38:53.056425  FIRST, INC default to 1.

    2023-03-03T15:38:53.057136  =


    2023-03-03T15:38:53.059861  	-w	Pad to last with leading zeros

    2023-03-03T15:38:53.062101  	-s SEP	String separator

    2023-03-03T15:38:53.075840  /lava-9406009/1/../bin/lava-t<8>[   34.4696=
77] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Drk3399-gru-sound-driver-rt5514-pre=
sent RESULT=3Dfail>
   =


  * baseline.bootrr.rk3399-gru-sound-driver-max98357A-present: https://kern=
elci.org/test/case/id/640214abbd18c1a7408c86ac
        failing since 43 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-03T15:38:53.016570  /<8>[   34.412030] <LAVA_SIGNAL_TESTCASE TE=
ST_CASE_ID=3Drk3399-gru-sound-driver-dp-present RESULT=3Dfail>

    2023-03-03T15:38:53.020646  lava-9406009/1/../bin/lava-test-case

    2023-03-03T15:38:53.026973  BusyBox v1.31.1 (2023-02-24 16:18:20 UTC) m=
ulti-call binary.

    2023-03-03T15:38:53.027066  =


    2023-03-03T15:38:53.031192  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-03-03T15:38:53.031276  =


    2023-03-03T15:38:53.046094  Print numbers from FIRST to LAST, in steps =
<8>[   34.440567] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Drk3399-gru-sound-dri=
ver-max98357A-present RESULT=3Dfail>
   =


  * baseline.bootrr.rk3399-gru-sound-driver-dp-present: https://kernelci.or=
g/test/case/id/640214abbd18c1a7408c86ad
        failing since 43 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-03T15:38:52.988803  =


    2023-03-03T15:38:52.992984  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-03-03T15:38:52.993072  =


    2023-03-03T15:38:52.998523  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-03-03T15:38:53.000100  FIRST, INC default to 1.

    2023-03-03T15:38:53.000189  =


    2023-03-03T15:38:53.004613  	-w	Pad to last with leading zeros

    2023-03-03T15:38:53.006801  	-s SEP	String separator
   =


  * baseline.bootrr.rk3399-gru-sound-driver-da7219-present: https://kernelc=
i.org/test/case/id/640214abbd18c1a7408c86ae
        failing since 43 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-03T15:38:52.961582  /lava-9406009/1/../bin/lava-test-case<8>[  =
 34.360917] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Drk3399-gru-sound-driver-pr=
esent RESULT=3Dpass>

    2023-03-03T15:38:52.961659  =


    2023-03-03T15:38:52.977666  BusyBox v1.31.1 (2023-02-24 16:18:20 UTC) m=
ulti-call binary.

    2023-03-03T15:38:52.988121  <8>[   34.385320] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-da7219-present RESULT=3Dfail>
   =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus     | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64021657d987f69edb8c869a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230224.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64021657d987f69edb8c86a3
        failing since 43 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-03T15:46:14.109483  <8>[   15.947785] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 91986_1.5.2.4.1>
    2023-03-03T15:46:14.216167  / # #
    2023-03-03T15:46:14.319110  export SHELL=3D/bin/sh
    2023-03-03T15:46:14.319844  #
    2023-03-03T15:46:14.422146  / # export SHELL=3D/bin/sh. /lava-91986/env=
ironment
    2023-03-03T15:46:14.422751  =

    2023-03-03T15:46:14.524727  / # . /lava-91986/environment/lava-91986/bi=
n/lava-test-runner /lava-91986/1
    2023-03-03T15:46:14.525725  =

    2023-03-03T15:46:14.529128  / # /lava-91986/bin/lava-test-runner /lava-=
91986/1
    2023-03-03T15:46:14.560965  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64         | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6402146fb502ad81d28c864b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm64/defconfig/gcc-10/lab-co=
llabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm64/defconfig/gcc-10/lab-co=
llabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230224.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6402146fb502ad81d28c8654
        failing since 43 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-03T15:38:06.044188  / # #

    2023-03-03T15:38:06.145983  export SHELL=3D/bin/sh

    2023-03-03T15:38:06.146516  #

    2023-03-03T15:38:06.247918  / # export SHELL=3D/bin/sh. /lava-9406025/e=
nvironment

    2023-03-03T15:38:06.248450  =


    2023-03-03T15:38:06.349872  / # . /lava-9406025/environment/lava-940602=
5/bin/lava-test-runner /lava-9406025/1

    2023-03-03T15:38:06.350727  =


    2023-03-03T15:38:06.352785  / # /lava-9406025/bin/lava-test-runner /lav=
a-9406025/1

    2023-03-03T15:38:06.425963  + export 'TESTRUN_ID=3D1_bootrr'

    2023-03-03T15:38:06.426324  + cd /lava-9406025<8>[   15.609549] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 9406025_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
tegra124-nyan-big          | arm    | lab-collabora   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64021768f4c3647e348c8676

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm/multi_v7_defconfig/gcc-10=
/lab-collabora/baseline-tegra124-nyan-big.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm/multi_v7_defconfig/gcc-10=
/lab-collabora/baseline-tegra124-nyan-big.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230224.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64021768f4c3647e348c867f
        failing since 41 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-03T15:50:51.658144  <8>[   17.898006] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-03-03T15:50:51.662988  + set +x

    2023-03-03T15:50:51.669998  <8>[   17.911354] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9406458_1.5.2.3.1>

    2023-03-03T15:50:51.778408  #

    2023-03-03T15:50:51.779204  =


    2023-03-03T15:50:51.880738  / # #export SHELL=3D/bin/sh

    2023-03-03T15:50:51.881203  =


    2023-03-03T15:50:51.982520  / # export SHELL=3D/bin/sh. /lava-9406458/e=
nvironment

    2023-03-03T15:50:51.983101  =


    2023-03-03T15:50:52.084454  / # . /lava-9406458/environment/lava-940645=
8/bin/lava-test-runner /lava-9406458/1
 =

    ... (14 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
tegra124-nyan-big          | arm    | lab-collabora   | gcc-10   | tegra_de=
fconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/6402150f6c3309bbc18c8630

  Results:     3 PASS, 3 FAIL, 1 SKIP
  Full config: tegra_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm/tegra_defconfig/gcc-10/la=
b-collabora/baseline-tegra124-nyan-big.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm/tegra_defconfig/gcc-10/la=
b-collabora/baseline-tegra124-nyan-big.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230224.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6402150f6c3309bbc18c8639
        failing since 41 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-03T15:40:41.997158  kern  :emerg : Process udevadm (pid<8>[   1=
8.468885] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Demerg RESULT=3Dfail UNITS=3D=
lines MEASUREMENT=3D11>

    2023-03-03T15:40:41.999635  : 139, stack limit =3D 0x(ptrval))

    2023-03-03T15:40:42.007694  kern  :emerg : Stack: (0xc2c8b<8>[   18.483=
071] <LAVA_SIGNAL_ENDRUN 0_dmesg 9406149_1.5.2.3.1>

    2023-03-03T15:40:42.009808  f2c to 0xc2c8c000)

    2023-03-03T15:40:42.017874  kern  :emerg : bf20:                       =
     c02e8030 00000000 00000000 c026d6dc 00000003

    2023-03-03T15:40:42.025886  kern  :emerg : bf40: c2bb9000 becf3f74 c2c8=
bf80 00000000 c2c8a000 00000004 00000003 c0270590

    2023-03-03T15:40:42.034124  kern  :emerg : bf60: edfd4318 c026d6dc c2bb=
9000 c2bb9000 becf3f74 00000003 c0101264 c02707f4

    2023-03-03T15:40:42.042378  kern  :emerg : bf80: 00000000 00000000 c2c8=
bfb0 760243fe b6f9d7c0 00000003 b6f9d7c0 becf3468

    2023-03-03T15:40:42.050393  kern  :emerg : bfa0: 00000004 c0101000 0000=
0003 b6f9d7c0 00000003 becf3f74 00000003 00000000

    2023-03-03T15:40:42.058577  kern  :emerg : bfc0: 00000003 b6f9d7c0 becf=
3468 00000004 00000003 0003c90c becf3e58 00000003
 =

    ... (23 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
zynqmp-zcu102              | arm64  | lab-cip         | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/640214a6a7fcbbd9198c863a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230224.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/640214a6a7fcbbd9198c8641
        failing since 43 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-03T15:39:12.397602  <8>[    3.715358] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 864608_1.5.2.4.1>
    2023-03-03T15:39:12.502493  / # #
    2023-03-03T15:39:12.604072  export SHELL=3D/bin/sh
    2023-03-03T15:39:12.604570  #
    2023-03-03T15:39:12.705930  / # export SHELL=3D/bin/sh. /lava-864608/en=
vironment
    2023-03-03T15:39:12.706426  =

    2023-03-03T15:39:12.807822  / # . /lava-864608/environment/lava-864608/=
bin/lava-test-runner /lava-864608/1
    2023-03-03T15:39:12.808365  =

    2023-03-03T15:39:12.811355  / # /lava-864608/bin/lava-test-runner /lava=
-864608/1
    2023-03-03T15:39:12.848487  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
zynqmp-zcu102              | arm64  | lab-cip         | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64021672ee1ad8b4f58c865b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm64/defconfig/gcc-10/lab-ci=
p/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm64/defconfig/gcc-10/lab-ci=
p/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230224.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64021672ee1ad8b4f58c8662
        failing since 43 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-03T15:46:42.583884  + set +x
    2023-03-03T15:46:42.585015  <8>[    3.786888] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 864617_1.5.2.4.1>
    2023-03-03T15:46:42.691337  / # #
    2023-03-03T15:46:42.793218  export SHELL=3D/bin/sh
    2023-03-03T15:46:42.793671  #
    2023-03-03T15:46:42.895059  / # export SHELL=3D/bin/sh. /lava-864617/en=
vironment
    2023-03-03T15:46:42.895508  =

    2023-03-03T15:46:42.996947  / # . /lava-864617/environment/lava-864617/=
bin/lava-test-runner /lava-864617/1
    2023-03-03T15:46:42.997703  =

    2023-03-03T15:46:43.000820  / # /lava-864617/bin/lava-test-runner /lava=
-864617/1 =

    ... (13 line(s) more)  =

 =20

