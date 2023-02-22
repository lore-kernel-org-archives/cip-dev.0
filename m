Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652B0C64EC7
	for <webhook@archiver.kernel.org>; Wed, 22 Feb 2023 19:37:48 +0000 (UTC)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
 by mx.groups.io with SMTP id smtpd.web10.2815.1677094665064084783
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 22 Feb 2023 11:37:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=kg9L2QNT;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.53, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f53.google.com with SMTP id h17-20020a17090aea9100b0023739b10792so4301404pjz.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 22 Feb 2023 11:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wazcIx7v2rGr0UoQ4awlTjiwPT17f7buDeOA1132A2g=;
        b=kg9L2QNT5l+nhPYBFHRneNmCZ03frWmyRCX23WOQEyLoFE/hdF7XyPQNk1nSDbtNaK
         WIJSChetwMvb3j5+nyBmWq245K/tFHm5wgjJROAJdhthEJVX90CbGJ3n0Hn9Tb55BAZJ
         cu1uKUp1Dz72z78rHEbJUN9HnvKFoqn+DCvVYe+QG66djOG9nBTAisZ3rjCEE3rnr5iq
         K9ATUsSBlWvPQ2UoVlpZyKqtspRtzROysjzc37J+uIz/2hPuQOJhRxPI483CtV+zG4BM
         MAdU8ngzPJsRAkruI7fgXxi/bJr96Z1KidjZN1nj1CYM8kV9f+rwMLjV+dXFAXOKeIgn
         WPDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wazcIx7v2rGr0UoQ4awlTjiwPT17f7buDeOA1132A2g=;
        b=tFm0HRSDUvh5rQhljklJ+oIQbY0g2gBI/Ly4yNxTSwJ1a/f/YKu4/Y5C/4nf9+0Dvq
         w2h1s+seb0d1b9cnAe/GkRx4Z+r48RbErl5O+KtXJVmeESEsB9Iee5emylk04HWxjVgo
         Fpc24AKEoKqdHU1Hkn1ouSalv68QeqNy9HPxCHX10ucl8ZyPgADB0/YBX3owQzq5l1w/
         Qg/MruTSfOM1O3PMyb8pKRn9vyJ3cpDLMC/VM/2XR0vqOP8vBXdpXYpSbC70eNJbpkG7
         0YtJZW7Cc213P1VT3p5v7KssQat/JUchUunsXwEg8qgxNi0Xb8eTkZF+SiK4mE0QDpKX
         cjgw==
X-Gm-Message-State: AO0yUKVXhmPSL4n1K0+A3NDkCq5wyYDhRM7zsWtNmZ1pfG9o6U69ItDP
	SlqcmWDaXOGyvqku+cmBiyPox1cUTp478wg4pdYXcA==
X-Google-Smtp-Source: AK7set8ko4fo21gceMUmvvsoC6pe6d+Al5SMCqLKkDDyCqmx6ZFmdREhTUcufzLm9pEz33OrPAuyRA==
X-Received: by 2002:a17:90a:c6:b0:237:3cbb:a1f5 with SMTP id v6-20020a17090a00c600b002373cbba1f5mr3894374pjd.0.1677094663401;
        Wed, 22 Feb 2023 11:37:43 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ei23-20020a17090ae55700b002343e59709asm4367957pjb.46.2023.02.22.11.37.42
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 11:37:43 -0800 (PST)
Message-ID: <63f66f07.170a0220.a54c2.8c8d@mx.google.com>
Date: Wed, 22 Feb 2023 11:37:43 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.19.272-cip91-91-gb4755c11cb57
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 90 runs,
 32 regressions (v4.19.272-cip91-91-gb4755c11cb57)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Feb 2023 19:37:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10789

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 90 runs, 32 regression=
s (v4.19.272-cip91-91-gb4755c11cb57)

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

beaglebone-black           | arm    | lab-broonie     | gcc-10   | omap2plu=
s_defconfig          | 1          =

beaglebone-black           | arm    | lab-cip         | gcc-10   | omap2plu=
s_defconfig          | 1          =

imx6q-sabrelite            | arm    | lab-collabora   | gcc-10   | multi_v7=
_defconfig           | 1          =

imx6qp-wandboard-revd1     | arm    | lab-pengutronix | gcc-10   | imx_v6_v=
7_defconfig          | 1          =

imx6qp-wandboard-revd1     | arm    | lab-pengutronix | gcc-10   | multi_v7=
_defconfig           | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

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
g                    | 1          =

zynqmp-zcu102              | arm64  | lab-cip         | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.272-cip91-91-gb4755c11cb57/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.272-cip91-91-gb4755c11cb57
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b4755c11cb578851c6f8f50c94fcac17e987653c =



Test Regressions
---------------- =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus  | x86_64 | lab-collabora   | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63f667253b60ea8cc68c86d7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/baseline-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/baseline-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63f667253b60ea8cc68c86e0
        failing since 34 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-22T19:03:45.032752  + set +x<8>[    9.874121] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 9284107_1.4.2.3.1>

    2023-02-22T19:03:45.033199  =


    2023-02-22T19:03:45.140743  #

    2023-02-22T19:03:45.242221  / # #export SHELL=3D/bin/sh

    2023-02-22T19:03:45.243098  =


    2023-02-22T19:03:45.344882  / # export SHELL=3D/bin/sh. /lava-9284107/e=
nvironment

    2023-02-22T19:03:45.345766  =


    2023-02-22T19:03:45.447708  / # . /lava-9284107/environment/lava-928410=
7/bin/lava-test-runner /lava-9284107/1

    2023-02-22T19:03:45.448861  =


    2023-02-22T19:03:45.453190  / # /lava-9284107/bin/lava-test-runner /lav=
a-9284107/1
 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral   | x86_64 | lab-collabora   | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63f666f798eb8521b48c863e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/baseline-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/baseline-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63f666f798eb8521b48c8647
        failing since 34 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-22T19:03:00.637768  + set +x

    2023-02-22T19:03:00.647257  <8>[   10.230311] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9284100_1.4.2.3.1>

    2023-02-22T19:03:00.753852  / # #

    2023-02-22T19:03:00.857101  export SHELL=3D/bin/sh

    2023-02-22T19:03:00.858006  #

    2023-02-22T19:03:00.960022  / # export SHELL=3D/bin/sh. /lava-9284100/e=
nvironment

    2023-02-22T19:03:00.960893  =


    2023-02-22T19:03:01.062628  / # . /lava-9284100/environment/lava-928410=
0/bin/lava-test-runner /lava-9284100/1

    2023-02-22T19:03:01.064176  =


    2023-02-22T19:03:01.067014  / # /lava-9284100/bin/lava-test-runner /lav=
a-9284100/1
 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
beaglebone-black           | arm    | lab-broonie     | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63f66765d88b642a9e8c8652

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm/multi_v7_defconfig/gcc-10=
/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm/multi_v7_defconfig/gcc-10=
/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63f66765d88b642a9e8c865b
        failing since 34 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-22T19:04:45.314019  <8>[   14.934779] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 57209_1.5.2.4.1>
    2023-02-22T19:04:45.421055  / # #
    2023-02-22T19:04:45.523178  export SHELL=3D/bin/sh
    2023-02-22T19:04:45.523644  #
    2023-02-22T19:04:45.625275  / # export SHELL=3D/bin/sh. /lava-57209/env=
ironment
    2023-02-22T19:04:45.625796  =

    2023-02-22T19:04:45.727373  / # . /lava-57209/environment/lava-57209/bi=
n/lava-test-runner /lava-57209/1
    2023-02-22T19:04:45.728140  =

    2023-02-22T19:04:45.732226  / # /lava-57209/bin/lava-test-runner /lava-=
57209/1
    2023-02-22T19:04:45.800461  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
beaglebone-black           | arm    | lab-broonie     | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63f666fa98eb8521b48c8649

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm/omap2plus_defconfig/gcc-1=
0/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm/omap2plus_defconfig/gcc-1=
0/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63f666fa98eb8521b48c8652
        new failure (last pass: v4.19.271-cip90-81-g5d0e00d43751)

    2023-02-22T19:02:59.163474  + set +x<8>[   17.013703] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 57165_1.5.2.4.1>
    2023-02-22T19:02:59.164129  =

    2023-02-22T19:02:59.277305  / # #
    2023-02-22T19:02:59.380451  export SHELL=3D/bin/sh
    2023-02-22T19:02:59.381378  #
    2023-02-22T19:02:59.483466  / # export SHELL=3D/bin/sh. /lava-57165/env=
ironment
    2023-02-22T19:02:59.484440  =

    2023-02-22T19:02:59.586570  / # . /lava-57165/environment/lava-57165/bi=
n/lava-test-runner /lava-57165/1
    2023-02-22T19:02:59.588064  =

    2023-02-22T19:02:59.591511  / # /lava-57165/bin/lava-test-runner /lava-=
57165/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
beaglebone-black           | arm    | lab-cip         | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63f66ec3388edb1f038c86bc

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm/omap2plus_defconfig/gcc-1=
0/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm/omap2plus_defconfig/gcc-1=
0/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63f66ec3388edb1f038c86c3
        new failure (last pass: v4.19.271-cip90-81-g5d0e00d43751)

    2023-02-22T19:36:20.589027  + set +x<8>[   10.771732] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 856824_1.5.2.4.1>
    2023-02-22T19:36:20.589530  =

    2023-02-22T19:36:20.700480  / # #
    2023-02-22T19:36:20.803088  export SHELL=3D/bin/sh
    2023-02-22T19:36:20.803733  #
    2023-02-22T19:36:20.905272  / # export SHELL=3D/bin/sh. /lava-856824/en=
vironment
    2023-02-22T19:36:20.905970  =

    2023-02-22T19:36:21.007804  / # . /lava-856824/environment/lava-856824/=
bin/lava-test-runner /lava-856824/1
    2023-02-22T19:36:21.008969  =

    2023-02-22T19:36:21.015674  / # /lava-856824/bin/lava-test-runner /lava=
-856824/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx6q-sabrelite            | arm    | lab-collabora   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63f6673f1eedc30b028c8644

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm/multi_v7_defconfig/gcc-10=
/lab-collabora/baseline-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm/multi_v7_defconfig/gcc-10=
/lab-collabora/baseline-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63f6673f1eedc30b028c864d
        failing since 34 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-22T19:04:13.122879  / # #

    2023-02-22T19:04:13.225839  export SHELL=3D/bin/sh

    2023-02-22T19:04:13.226667  #

    2023-02-22T19:04:13.328888  / # export SHELL=3D/bin/sh. /lava-9284187/e=
nvironment

    2023-02-22T19:04:13.329725  =


    2023-02-22T19:04:13.431623  / # . /lava-9284187/environment/lava-928418=
7/bin/lava-test-runner /lava-9284187/1

    2023-02-22T19:04:13.432839  =


    2023-02-22T19:04:13.445438  / # /lava-9284187/bin/lava-test-runner /lav=
a-9284187/1

    2023-02-22T19:04:13.552399  + export 'TESTRUN_ID=3D1_bootrr'

    2023-02-22T19:04:13.552957  + cd /lava-9284187/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx6qp-wandboard-revd1     | arm    | lab-pengutronix | gcc-10   | imx_v6_v=
7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63f6671e3b60ea8cc68c8632

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm/imx_v6_v7_defconfig/gcc-1=
0/lab-pengutronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm/imx_v6_v7_defconfig/gcc-1=
0/lab-pengutronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63f6671e3b60ea8cc68c863b
        failing since 34 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-22T19:03:32.482558  + set +x
    2023-02-22T19:03:32.482731  [    7.093112] <LAVA_SIGNAL_ENDRUN 0_dmesg =
911042_1.5.2.3.1>
    2023-02-22T19:03:32.589932  / # #
    2023-02-22T19:03:32.691602  export SHELL=3D/bin/sh
    2023-02-22T19:03:32.692128  #
    2023-02-22T19:03:32.793294  / # export SHELL=3D/bin/sh. /lava-911042/en=
vironment
    2023-02-22T19:03:32.793828  =

    2023-02-22T19:03:32.895148  / # . /lava-911042/environment/lava-911042/=
bin/lava-test-runner /lava-911042/1
    2023-02-22T19:03:32.895884  =

    2023-02-22T19:03:32.898717  / # /lava-911042/bin/lava-test-runner /lava=
-911042/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx6qp-wandboard-revd1     | arm    | lab-pengutronix | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63f6676d595dd8a6a68c8644

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm/multi_v7_defconfig/gcc-10=
/lab-pengutronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm/multi_v7_defconfig/gcc-10=
/lab-pengutronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63f6676d595dd8a6a68c864d
        failing since 34 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-22T19:04:53.499938  + set +x
    2023-02-22T19:04:53.500171  [    4.849819] <LAVA_SIGNAL_ENDRUN 0_dmesg =
911047_1.5.2.3.1>
    2023-02-22T19:04:53.606687  / # #
    2023-02-22T19:04:53.708373  export SHELL=3D/bin/sh
    2023-02-22T19:04:53.708781  #
    2023-02-22T19:04:53.809959  / # export SHELL=3D/bin/sh. /lava-911047/en=
vironment
    2023-02-22T19:04:53.810395  =

    2023-02-22T19:04:53.911651  / # . /lava-911047/environment/lava-911047/=
bin/lava-test-runner /lava-911047/1
    2023-02-22T19:04:53.912345  =

    2023-02-22T19:04:53.914692  / # /lava-911047/bin/lava-test-runner /lava=
-911047/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63f667cc7bfe43229d8c868b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f667cc7bfe43229d8c8=
68c
        failing since 280 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63f6695cfb4d03ef628c8645

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f6695cfb4d03ef628c8=
646
        failing since 280 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63f667b79c2e951fe38c8639

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f667b79c2e951fe38c8=
63a
        failing since 280 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63f66947fb4d03ef628c8634

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f66947fb4d03ef628c8=
635
        failing since 280 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63f667cd7bfe43229d8c8691

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f667cd7bfe43229d8c8=
692
        failing since 280 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63f6695bd4571960c18c8648

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f6695bd4571960c18c8=
649
        failing since 280 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63f6674a1eedc30b028c86b2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm64/defconfig/gcc-10/lab-co=
llabora/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm64/defconfig/gcc-10/lab-co=
llabora/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f6674a1eedc30b028c8=
6b3
        failing since 280 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63f667df29726c98058c862f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f667df29726c98058c8=
630
        failing since 280 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63f66933cb917167ea8c8635

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f66933cb917167ea8c8=
636
        failing since 280 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
r8a7743-iwg20d-q7          | arm    | lab-cip         | gcc-10   | shmobile=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63f6657e5ede073bc98c8653

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm/shmobile_defconfig/gcc-10=
/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm/shmobile_defconfig/gcc-10=
/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f6657e5ede073bc98c8=
654
        new failure (last pass: v4.19.271-cip90-81-g5d0e00d43751) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
rk3288-veyron-jaq          | arm    | lab-collabora   | gcc-10   | multi_v7=
_defconfig           | 3          =


  Details:     https://kernelci.org/test/plan/id/63f667401eedc30b028c8652

  Results:     61 PASS, 8 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm/multi_v7_defconfig/gcc-10=
/lab-collabora/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm/multi_v7_defconfig/gcc-10=
/lab-collabora/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/63f667401eedc30b028c8680
        failing since 32 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-22T19:04:03.149437  BusyBox v1.31.1 (2023-02-17 15:41:33 UTC)<8=
>[   13.449854] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-02-22T19:04:03.150673   multi-call binary.

    2023-02-22T19:04:03.151402  =


    2023-02-22T19:04:03.155380  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-02-22T19:04:03.155857  =


    2023-02-22T19:04:03.160912  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-02-22T19:04:03.171030  FIRST,<8>[   13.468614] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/63f667401eedc30b028c8681
        failing since 32 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-22T19:04:03.130642  <8>[   13.432396] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63f667401eedc30b028c8694
        failing since 32 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-22T19:03:59.300618  <8>[    9.602040] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-02-22T19:03:59.308454  + <8>[    9.614260] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 9284178_1.5.2.3.1>

    2023-02-22T19:03:59.310443  set +x

    2023-02-22T19:03:59.416881  #

    2023-02-22T19:03:59.518992  / # #export SHELL=3D/bin/sh

    2023-02-22T19:03:59.519468  =


    2023-02-22T19:03:59.620745  / # export SHELL=3D/bin/sh. /lava-9284178/e=
nvironment

    2023-02-22T19:03:59.621208  =


    2023-02-22T19:03:59.722497  / # . /lava-9284178/environment/lava-928417=
8/bin/lava-test-runner /lava-9284178/1

    2023-02-22T19:03:59.723183  =

 =

    ... (17 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
rk3399-gru-kevin           | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 5          =


  Details:     https://kernelci.org/test/plan/id/63f6680b29a04bece28c8685

  Results:     79 PASS, 9 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/case/id=
/63f6680b29a04bece28c86ab
        failing since 345 days (last pass: v4.19.229-cip67-111-g5c3c0b39cf3=
b, first fail: v4.19.231-cip68-123-g92e3e7f3d4df)

    2023-02-22T19:07:42.962535  <8>[   34.835193] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s0-probed RESULT=3Dpass>

    2023-02-22T19:07:43.983813  /lava-9284232/1/../bin/lava-test-case<8>[  =
 35.857110] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Drockchip-i2s1-probed RESUL=
T=3Dfail>

    2023-02-22T19:07:43.983953  =

   =


  * baseline.bootrr.rk3399-gru-sound-driver-rt5514-present: https://kernelc=
i.org/test/case/id/63f6680b29a04bece28c86b8
        failing since 34 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-22T19:07:42.487537  BusyBox v1.31.1 (2023-02-17 <8>[   34.35403=
1] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Drk3399-gru-sound-driver-max98357A-p=
resent RESULT=3Dfail>

    2023-02-22T19:07:42.490808  14:37:44 UTC) multi-call binary.

    2023-02-22T19:07:42.491081  =


    2023-02-22T19:07:42.495541  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-02-22T19:07:42.495629  =


    2023-02-22T19:07:42.500550  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-02-22T19:07:42.503263  FIRST, INC default to 1.

    2023-02-22T19:07:42.503354  =


    2023-02-22T19:07:42.516411  	-w	Pad to last with leading <8>[   34.3842=
23] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Drk3399-gru-sound-driver-rt5514-pre=
sent RESULT=3Dfail>
   =


  * baseline.bootrr.rk3399-gru-sound-driver-max98357A-present: https://kern=
elci.org/test/case/id/63f6680b29a04bece28c86b9
        failing since 34 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-22T19:07:42.467857  -w	Pad to last with leading zeros

    2023-02-22T19:07:42.470282  	-s SEP	String separator

    2023-02-22T19:07:42.474152  /lava-9284232/1/../bin/lava-test-case
   =


  * baseline.bootrr.rk3399-gru-sound-driver-dp-present: https://kernelci.or=
g/test/case/id/63f6680b29a04bece28c86ba
        failing since 34 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-22T19:07:42.439854  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-02-22T19:07:42.439939  =


    2023-02-22T19:07:42.444810  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-02-22T19:07:42.447398  FIRST, INC default to 1.

    2023-02-22T19:07:42.447841  =


    2023-02-22T19:07:42.457472  	<8>[   34.327457] <LAVA_SIGNAL_TESTCASE TE=
ST_CASE_ID=3Drk3399-gru-sound-driver-dp-present RESULT=3Dfail>
   =


  * baseline.bootrr.rk3399-gru-sound-driver-da7219-present: https://kernelc=
i.org/test/case/id/63f6680b29a04bece28c86bb
        failing since 34 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-22T19:07:42.424981  BusyBox v1.31.1 (2023-02-17 14:37:44 UTC) m=
ulti-call binary.

    2023-02-22T19:07:42.425075  =


    2023-02-22T19:07:42.435128  <8>[   34.304308] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-da7219-present RESULT=3Dfail>
   =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus     | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63f6669ad0249b7dda8c86c6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63f6669ad0249b7dda8c86cf
        failing since 34 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-22T19:01:28.396743  <8>[   15.920786] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 57122_1.5.2.4.1>
    2023-02-22T19:01:28.502210  / # #
    2023-02-22T19:01:28.604672  export SHELL=3D/bin/sh
    2023-02-22T19:01:28.605108  #
    2023-02-22T19:01:28.706692  / # export SHELL=3D/bin/sh. /lava-57122/env=
ironment
    2023-02-22T19:01:28.707239  =

    2023-02-22T19:01:28.808791  / # . /lava-57122/environment/lava-57122/bi=
n/lava-test-runner /lava-57122/1
    2023-02-22T19:01:28.809577  =

    2023-02-22T19:01:28.813043  / # /lava-57122/bin/lava-test-runner /lava-=
57122/1
    2023-02-22T19:01:28.845431  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64         | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63f666517323dcb3798c869d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm64/defconfig/gcc-10/lab-co=
llabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm64/defconfig/gcc-10/lab-co=
llabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63f666517323dcb3798c86a6
        failing since 34 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-22T19:00:16.229006  / # #

    2023-02-22T19:00:16.330649  export SHELL=3D/bin/sh

    2023-02-22T19:00:16.331209  #

    2023-02-22T19:00:16.432621  / # export SHELL=3D/bin/sh. /lava-9284011/e=
nvironment

    2023-02-22T19:00:16.433335  =


    2023-02-22T19:00:16.534875  / # . /lava-9284011/environment/lava-928401=
1/bin/lava-test-runner /lava-9284011/1

    2023-02-22T19:00:16.535663  =


    2023-02-22T19:00:16.538735  / # /lava-9284011/bin/lava-test-runner /lav=
a-9284011/1

    2023-02-22T19:00:16.610805  + export 'TESTRUN_ID=3D1_bootrr'

    2023-02-22T19:00:16.611189  + cd /lava-9284011<8>[   15.626795] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 9284011_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
tegra124-nyan-big          | arm    | lab-collabora   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63f667cc3fd578fa308c866c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm/multi_v7_defconfig/gcc-10=
/lab-collabora/baseline-tegra124-nyan-big.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm/multi_v7_defconfig/gcc-10=
/lab-collabora/baseline-tegra124-nyan-big.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63f667cc3fd578fa308c8675
        failing since 32 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-22T19:06:37.195195  + set +x

    2023-02-22T19:06:37.200976  <8>[   17.966240] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9284177_1.5.2.3.1>

    2023-02-22T19:06:37.312463  =


    2023-02-22T19:06:37.414860  / # #export SHELL=3D/bin/sh

    2023-02-22T19:06:37.415439  =


    2023-02-22T19:06:37.517132  / # export SHELL=3D/bin/sh. /lava-9284177/e=
nvironment

    2023-02-22T19:06:37.518044  =


    2023-02-22T19:06:37.620168  / # . /lava-9284177/environment/lava-928417=
7/bin/lava-test-runner /lava-9284177/1

    2023-02-22T19:06:37.621585  =


    2023-02-22T19:06:37.623475  / # /lava-9284177/bin/lava-test-runner /lav=
a-9284177/1
 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
tegra124-nyan-big          | arm    | lab-collabora   | gcc-10   | tegra_de=
fconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/63f66768595dd8a6a68c8637

  Results:     3 PASS, 3 FAIL, 1 SKIP
  Full config: tegra_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm/tegra_defconfig/gcc-10/la=
b-collabora/baseline-tegra124-nyan-big.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm/tegra_defconfig/gcc-10/la=
b-collabora/baseline-tegra124-nyan-big.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63f66768595dd8a6a68c8640
        failing since 32 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-22T19:04:51.444839  kern  :emerg : Process udevadm (pid<8>[   1=
8.588931] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Demerg RESULT=3Dfail UNITS=3D=
lines MEASUREMENT=3D11>

    2023-02-22T19:04:51.447148  : 139, stack limit =3D 0x(ptrval))

    2023-02-22T19:04:51.455437  kern  :emerg : Stack: (0xc2c4b<8>[   18.602=
782] <LAVA_SIGNAL_ENDRUN 0_dmesg 9284058_1.5.2.3.1>

    2023-02-22T19:04:51.458822  f2c to 0xc2c4c000)

    2023-02-22T19:04:51.466961  kern  :emerg : bf20:                       =
     c02e7ff0 00000000 00000000 c026d69c 00000003

    2023-02-22T19:04:51.475190  kern  :emerg : bf40: c2b85540 bed1cf74 c2c4=
bf80 00000000 c2c4a000 00000004 00000003 c0270550

    2023-02-22T19:04:51.482893  kern  :emerg : bf60: edfd0668 c026d69c c2b8=
5540 c2b85540 bed1cf74 00000003 c0101264 c02707b4

    2023-02-22T19:04:51.491523  kern  :emerg : bf80: 00000000 00000000 c2c4=
bfb0 ff31c75a b6fef7c0 00000003 b6fef7c0 bed1c468

    2023-02-22T19:04:51.499419  kern  :emerg : bfa0: 00000004 c0101000 0000=
0003 b6fef7c0 00000003 bed1cf74 00000003 00000000

    2023-02-22T19:04:51.507771  kern  :emerg : bfc0: 00000003 b6fef7c0 bed1=
c468 00000004 00000003 0003c90c bed1ce58 00000003
 =

    ... (23 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
zynqmp-zcu102              | arm64  | lab-cip         | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63f666457323dcb3798c866b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm64/defconfig/gcc-10/lab-ci=
p/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm64/defconfig/gcc-10/lab-ci=
p/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63f666457323dcb3798c8672
        failing since 34 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-22T19:00:08.887890  <8>[    3.776765] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 856801_1.5.2.4.1>
    2023-02-22T19:00:08.995232  / # #
    2023-02-22T19:00:09.096888  export SHELL=3D/bin/sh
    2023-02-22T19:00:09.097338  #
    2023-02-22T19:00:09.198554  / # export SHELL=3D/bin/sh. /lava-856801/en=
vironment
    2023-02-22T19:00:09.199186  =

    2023-02-22T19:00:09.300674  / # . /lava-856801/environment/lava-856801/=
bin/lava-test-runner /lava-856801/1
    2023-02-22T19:00:09.301609  =

    2023-02-22T19:00:09.305024  / # /lava-856801/bin/lava-test-runner /lava=
-856801/1
    2023-02-22T19:00:09.341014  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
zynqmp-zcu102              | arm64  | lab-cip         | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63f669a1dfef53051e8c8640

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63f669a1dfef53051e8c8647
        failing since 34 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-22T19:14:22.435082  <8>[    3.726334] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 856871_1.5.2.4.1>
    2023-02-22T19:14:22.541027  / # #
    2023-02-22T19:14:22.642875  export SHELL=3D/bin/sh
    2023-02-22T19:14:22.643421  #
    2023-02-22T19:14:22.744822  / # export SHELL=3D/bin/sh. /lava-856871/en=
vironment
    2023-02-22T19:14:22.745266  =

    2023-02-22T19:14:22.846684  / # . /lava-856871/environment/lava-856871/=
bin/lava-test-runner /lava-856871/1
    2023-02-22T19:14:22.847442  =

    2023-02-22T19:14:22.850456  / # /lava-856871/bin/lava-test-runner /lava=
-856871/1
    2023-02-22T19:14:22.887483  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =20

