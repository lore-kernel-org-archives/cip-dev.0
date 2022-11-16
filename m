Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BA6C43217
	for <webhook@archiver.kernel.org>; Wed, 16 Nov 2022 03:46:11 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web10.2792.1668570369962391076
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 15 Nov 2022 19:46:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=6j7ttsxT;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.171, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f171.google.com with SMTP id p12so15278121plq.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 15 Nov 2022 19:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6mD0fq27segFnx3V6/BrHoz2LUI3UrDlnXDbNSDD8vA=;
        b=6j7ttsxTvg8ClA4yQ8C0V7+9s/i7AjcjabQyKwLfQukPSi6SHymBcMy2v0HA/QYxdB
         iAZ8F/87ue/6K/ZwEAO/UNi9h3vrapFq2OXFibFqVPcD33rWhNI+cVgJL+9fbg2wiCfV
         UIiCemMAerI51hUnksGtZ8jwfkkg4lsZoWFktRXYEl7JROx1dhDNMjAc259W5eiQThVg
         k++Js739ofR2zWFM/z3Dqr9yy8MxmCpiD3c5/OHZP4TXkzBZvK6d2T4SHVzsSKo2AkpF
         yz8VAznff14Hf6DRwwOSeT5djQCoi3B7VEabAPcQEAv02f1XjGiVA7TIz3ilMkcGWlFr
         Q4qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6mD0fq27segFnx3V6/BrHoz2LUI3UrDlnXDbNSDD8vA=;
        b=6hujEubtu3fFZ/AJphcRU+D2EPKW3Tmo+amkl/gZMGnwFR108+JUJn/zq2TRnXpX3/
         uvaNE6UjeUQ1+o7yTKxbBmvlAHkhFnIXr53yga2ZZ508aClc8bbxNU0eV21VkUZ1XIj+
         Rio9G60NTqW+QKoTCkz8TyTn7cLhWwuQE+Jk5c5qdOtktfcKsaWaCFzIRY65Eeb6Nb50
         QpGxBFisx23kowwQB3D6VxfcmRPacqLpBgbmbi1Z6sUoMVGvWlGj5RDWuMj4zdfqQg60
         6zIQuBiezByausBQE8au0b3xiHbtNLifA7KeFpIgQkiS/HtAP7D0PjsLSqxTXlT6BJrl
         ovMA==
X-Gm-Message-State: ANoB5pm9qH6iIjG57AKHTB7Md2C8HTEqOwk3tDV9QFNRTxvMaN97VWuv
	x7xGDCS8f2y973W/bM5W5NYQS9qS1j36LDZh
X-Google-Smtp-Source: AA0mqf7N1ziSkJMQ7ikoSN1XvIcVMlEgp9qdDL2aiumrq0w5koLfnrVm7nYlOBw3VQ1gQaxQ2y1Idg==
X-Received: by 2002:a17:902:ee55:b0:188:dd3d:ca0a with SMTP id 21-20020a170902ee5500b00188dd3dca0amr1998180plo.115.1668570368495;
        Tue, 15 Nov 2022 19:46:08 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g11-20020a170902e38b00b00186c3af9644sm10622979ple.273.2022.11.15.19.46.08
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 19:46:08 -0800 (PST)
Message-ID: <63745d00.170a0220.2d49d.04ac@mx.google.com>
Date: Tue, 15 Nov 2022 19:46:08 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.19.265-cip85-rt27
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test baseline: 71 runs,
 26 regressions (v4.19.265-cip85-rt27)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Nov 2022 03:46:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10040

cip-gitlab/ci/pavel/linux-test baseline: 71 runs, 26 regressions (v4.19.265=
-cip85-rt27)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =

da850-lcdk                   | arm    | lab-baylibre  | gcc-10   | davinci_=
all_defconfig        | 2          =

juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

qemu_x86_64-uefi-mixed       | x86_64 | lab-baylibre  | gcc-10   | x86_64_d=
efconfig             | 1          =

qemu_x86_64-uefi-mixed       | x86_64 | lab-baylibre  | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 5          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.265-cip85-rt27/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.265-cip85-rt27
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      7b2b3defe99e6a33cd295c5120b96288f81f8bd7 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/637451fe2ffb4788e52abd04

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221107.1/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/637451fe2ffb4788e52ab=
d05
        new failure (last pass: v5.10.145-rt74-1329-ga59fc50f38f6) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63745137eda67bd9ee2abcfb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221107.1/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63745137eda67bd9ee2ab=
cfc
        new failure (last pass: v5.10.145-rt74-1329-ga59fc50f38f6) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/637450b871b7835f2e2abd20

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-be=
aglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-be=
aglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221107.1/armel/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/637450b871b7835f=
2e2abd29
        new failure (last pass: v5.10.145-rt74-1329-ga59fc50f38f6)
        1 lines

    2022-11-16T02:53:26.997633  / # =

    2022-11-16T02:53:27.003815  =

    2022-11-16T02:53:27.110293  / # #
    2022-11-16T02:53:27.115911  #
    2022-11-16T02:53:27.218745  / # export SHELL=3D/bin/sh
    2022-11-16T02:53:27.224675  export SHELL=3D/bin/sh
    2022-11-16T02:53:27.326777  / # . /lava-141070/environment
    2022-11-16T02:53:27.332820  . /lava-141070/environment
    2022-11-16T02:53:27.435110  / # /lava-141070/bin/lava-test-runner /lava=
-141070/0
    2022-11-16T02:53:27.440568  /lava-141070/bin/lava-test-runner /lava-141=
070/0 =

    ... (9 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/637450c120a3bfdbec2abcfa

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beagle=
bone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beagle=
bone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221107.1/armel/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/637450c120a3bfdb=
ec2abd01
        new failure (last pass: v5.10.145-rt74-1329-ga59fc50f38f6)
        1 lines

    2022-11-16T02:53:32.850660  / # =

    2022-11-16T02:53:32.857260  =

    2022-11-16T02:53:32.961241  / # #
    2022-11-16T02:53:32.968685  #
    2022-11-16T02:53:33.070576  / # export SHELL=3D/bin/sh
    2022-11-16T02:53:33.077140  export SHELL=3D/bin/sh
    2022-11-16T02:53:33.178632  / # . /lava-784910/environment
    2022-11-16T02:53:33.185573  . /lava-784910/environment
    2022-11-16T02:53:33.287250  / # /lava-784910/bin/lava-test-runner /lava=
-784910/0
    2022-11-16T02:53:33.294343  /lava-784910/bin/lava-test-runner /lava-784=
910/0 =

    ... (9 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63744fdc5f653133ff2abd18

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-b=
eaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-b=
eaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221107.1/armel/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/63744fdc5f653133=
ff2abd21
        new failure (last pass: v5.10.145-rt74-1329-ga59fc50f38f6)
        1 lines

    2022-11-16T02:49:44.128706  / # =

    2022-11-16T02:49:44.137657  =

    2022-11-16T02:49:44.241558  / # #
    2022-11-16T02:49:44.248149  #
    2022-11-16T02:49:44.349891  / # export SHELL=3D/bin/sh
    2022-11-16T02:49:44.356959  export SHELL=3D/bin/sh
    2022-11-16T02:49:44.459455  / # . /lava-141028/environment
    2022-11-16T02:49:44.466490  . /lava-141028/environment
    2022-11-16T02:49:44.568703  / # /lava-141028/bin/lava-test-runner /lava=
-141028/0
    2022-11-16T02:49:44.574264  /lava-141028/bin/lava-test-runner /lava-141=
028/0 =

    ... (9 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63744fd031dac89b132abd24

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beagl=
ebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beagl=
ebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221107.1/armel/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/63744fd031dac89b=
132abd2b
        new failure (last pass: v5.10.145-rt74-1329-ga59fc50f38f6)
        1 lines

    2022-11-16T02:49:34.124477  / # =

    2022-11-16T02:49:34.135904  =

    2022-11-16T02:49:34.240503  / # #
    2022-11-16T02:49:34.249744  #
    2022-11-16T02:49:34.351593  / # export SHELL=3D/bin/sh
    2022-11-16T02:49:34.360474  export SHELL=3D/bin/sh
    2022-11-16T02:49:34.462101  / # . /lava-784909/environment
    2022-11-16T02:49:34.470557  . /lava-784909/environment
    2022-11-16T02:49:34.572120  / # /lava-784909/bin/lava-test-runner /lava=
-784909/0
    2022-11-16T02:49:34.579688  /lava-784909/bin/lava-test-runner /lava-784=
909/0 =

    ... (9 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
da850-lcdk                   | arm    | lab-baylibre  | gcc-10   | davinci_=
all_defconfig        | 2          =


  Details:     https://kernelci.org/test/plan/id/6374501d590658a8e32abd0c

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: davinci_all_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/arm/davinci_all_defconfig/gcc-10/lab-baylibre/baselin=
e-da850-lcdk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/arm/davinci_all_defconfig/gcc-10/lab-baylibre/baselin=
e-da850-lcdk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221107.1/armel/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/6374501e590658a=
8e32abd13
        new failure (last pass: v5.10.145-rt74-1329-ga59fc50f38f6)
        4 lines

    2022-11-16T02:50:48.105257  kern  :emerg : page:c6f51000 count:0 mapcou=
nt:-128 mapping:00000000 index:0x4
    2022-11-16T02:50:48.106000  kern  :emerg : flags: 0x0()
    2022-11-16T02:50:48.106969  kern  :emerg : page:c6f59000 count:0 mapcou=
nt:-128 mapping:00000000 index:0x4
    2022-11-16T02:50:48.108877  kern  :emerg : flags: 0x0()
    2022-11-16T02:50:48.180212  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Deme=
rg RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D4>
    2022-11-16T02:50:48.180953  + set +x   =


  * baseline.dmesg.alert: https://kernelci.org/test/case/id/6374501e590658a=
8e32abd14
        failing since 189 days (last pass: v4.19.233-516-ge5e741fbfc87, fir=
st fail: v5.10.109-cip5-384-g722204542e8a)
        6 lines

    2022-11-16T02:50:47.943420  kern  :alert : BUG: Bad page state in proce=
ss swapper  pfn:c3400
    2022-11-16T02:50:47.944621  kern  :alert : raw: 00000000 00000100 00000=
200 00000000 00000004 0000000a ffffff7f 00000000
    2022-11-16T02:50:47.945203  kern  :alert : page dumped because: nonzero=
 mapcount
    2022-11-16T02:50:47.945606  kern  :alert : BUG: Bad page state in proce=
ss swapper  pfn:c3800
    2022-11-16T02:50:47.946001  kern  :alert : raw: 00000000 00000100 00000=
200 00000000 00000004 0000000a ffffff7f 00000000
    2022-11-16T02:50:47.947199  kern  :alert : page dumped because: nonzero=
 mapcount
    2022-11-16T02:50:47.978619  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dale=
rt RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D6>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6374596f0ed93184492abd3f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboo=
t.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboo=
t.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221107.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6374596f0ed93184492ab=
d40
        new failure (last pass: v5.10.145-rt74-1329-ga59fc50f38f6) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/637457ea76c665b60a2abcfd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/arm64/defconfig/gcc-10/lab-broonie/baseline-meson-gxl=
-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/arm64/defconfig/gcc-10/lab-broonie/baseline-meson-gxl=
-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221107.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/637457ea76c665b60a2ab=
cfe
        new failure (last pass: v5.10.145-rt74-1329-ga59fc50f38f6) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/637454268a67ce9f8d2abd06

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/=
baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/=
baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221107.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/637454268a67ce9f8d2ab=
d07
        new failure (last pass: v5.10.145-rt74-1329-ga59fc50f38f6) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6374575b8a7fb31f982abd31

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm=
64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm=
64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221107.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6374575b8a7fb31f982ab=
d32
        new failure (last pass: v5.10.145-rt74-1329-ga59fc50f38f6) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/637454278637259dc62abd1c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/=
baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/=
baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221107.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/637454278637259dc62ab=
d1d
        new failure (last pass: v5.10.145-rt74-1329-ga59fc50f38f6) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6374575cc4275fa9452abcff

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm=
64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm=
64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221107.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6374575cc4275fa9452ab=
d00
        new failure (last pass: v5.10.145-rt74-1329-ga59fc50f38f6) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63745429a06e7863062abd14

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/=
baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/=
baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221107.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63745429a06e7863062ab=
d15
        new failure (last pass: v5.10.145-rt74-1329-ga59fc50f38f6) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6374575d899963c4d02abd22

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm=
64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm=
64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221107.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6374575d899963c4d02ab=
d23
        new failure (last pass: v5.10.145-rt74-1329-ga59fc50f38f6) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/637454286e9f33c5db2abd09

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/=
baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/=
baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221107.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/637454286e9f33c5db2ab=
d0a
        new failure (last pass: v5.10.145-rt74-1329-ga59fc50f38f6) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63745759af7612dc122abd7a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm=
64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm=
64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221107.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63745759af7612dc122ab=
d7b
        new failure (last pass: v5.10.145-rt74-1329-ga59fc50f38f6) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-baylibre  | gcc-10   | x86_64_d=
efconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/6374503ca651f6e62b2abd51

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/x86_64/x86_64_defconfig/gcc-10/lab-baylibre/baseline-=
qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/x86_64/x86_64_defconfig/gcc-10/lab-baylibre/baseline-=
qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221107.1/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6374503ca651f6e62b2ab=
d52
        new failure (last pass: v5.10.145-rt74-1329-ga59fc50f38f6) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-baylibre  | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63745140780c03144e2abd13

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-bay=
libre/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-bay=
libre/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221107.1/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63745140780c03144e2ab=
d14
        new failure (last pass: v5.10.145-rt74-1329-ga59fc50f38f6) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6374504f24c101dd8d2abcfb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a774=
3-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a774=
3-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221107.1/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6374504f24c101dd8d2ab=
cfc
        failing since 7 days (last pass: v5.10.147-cip18-12-gcb2b164780be, =
first fail: v5.10.147-cip18-15-gef247a3cd0ad) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 5          =


  Details:     https://kernelci.org/test/plan/id/63745afadcf39b07072abd05

  Results:     83 PASS, 7 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora=
/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora=
/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221107.1/arm64/rootfs.cpio.gz =



  * baseline.bootrr.cros-ec-sysfs-probed: https://kernelci.org/test/case/id=
/63745afadcf39b07072abd46
        new failure (last pass: v5.10.145-rt74-1329-ga59fc50f38f6)

    2022-11-16T03:37:18.393593  =

    2022-11-16T03:37:18.393986  =

    2022-11-16T03:37:19.402250  /lava-7991882/1/../bin/lava-test-case
    2022-11-16T03:37:19.410540  <8>[   35.298419] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-sysfs-probed RESULT=3Dfail>   =


  * baseline.bootrr.cros-ec-sysfs-driver-present: https://kernelci.org/test=
/case/id/63745afadcf39b07072abd47
        new failure (last pass: v5.10.145-rt74-1329-ga59fc50f38f6)

    2022-11-16T03:37:18.391500  /lava-7991882/1/../bin/lava-test-case<8>[  =
 34.279450] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dcros-ec-sysfs-driver-prese=
nt RESULT=3Dfail>   =


  * baseline.bootrr.cros-ec-lightbar-driver-present: https://kernelci.org/t=
est/case/id/63745afadcf39b07072abd50
        new failure (last pass: v5.10.145-rt74-1329-ga59fc50f38f6)

    2022-11-16T03:37:17.217935  /lava-7991882/1/../bin/lava-test-case
    2022-11-16T03:37:17.227438  <8>[   33.114812] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-lightbar-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cros-ec-debugfs-probed: https://kernelci.org/test/case/=
id/63745afadcf39b07072abd59
        new failure (last pass: v5.10.145-rt74-1329-ga59fc50f38f6)

    2022-11-16T03:37:15.734848  <4>[   31.622590] cdn-dp fec00000.dp: Direc=
t firmware load for rockchip/dptx.bin failed with error -2
    2022-11-16T03:37:15.735761  =

    2022-11-16T03:37:16.064191  /lava-7991882/1/../bin/lava-test-case
    2022-11-16T03:37:16.072650  <8>[   31.960456] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-debugfs-probed RESULT=3Dfail>   =


  * baseline.bootrr.cros-ec-debugfs-driver-present: https://kernelci.org/te=
st/case/id/63745afadcf39b07072abd5a
        new failure (last pass: v5.10.145-rt74-1329-ga59fc50f38f6)

    2022-11-16T03:37:15.044089  /lava-7991882/1/../bin/lava-test-case
    2022-11-16T03:37:15.053909  <8>[   30.941073] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-debugfs-driver-present RESULT=3Dfail>   =

 =20

