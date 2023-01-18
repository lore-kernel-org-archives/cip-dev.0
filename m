Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C501C38159
	for <webhook@archiver.kernel.org>; Wed, 18 Jan 2023 23:58:57 +0000 (UTC)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
 by mx.groups.io with SMTP id smtpd.web10.33271.1674086327648769584
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 18 Jan 2023 15:58:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=SWCHe+Uq;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.41, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f41.google.com with SMTP id u1-20020a17090a450100b0022936a63a21so4150082pjg.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 18 Jan 2023 15:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VJiocofieY63XWMw3Tm+9sJUrLUcJmv4XejC+1LWSxk=;
        b=SWCHe+UqwxwBrJ+EK4p/IvjlaGwurZNPyzujV/zLnzZ61oQpI9BG96JPyELNEzSexn
         Id942NZpmiIcld9YHFTDFpsCRo2KH2FSFHqek+zzOPStPOoALYHGb9CilGAe3BURhlP8
         n22X5ZrIb3CIW8Xlbk2mNughs8CEW8WGfzPPtywaPlytzy/5WcCOtoQ5dx8yfMe+mxDl
         aQAoTGh2iIrx8oMaQ02mt8GAD7bivqWDRUJv/G+HaA+6ZAoy8oNXJMWrpgbg9h2LF3+m
         drvDoLhdZczUqcX1kSnZ//IY2S7ApXwrk1XFlPSwzBnf38WPgLDCN1f8HZwSdoo6r0DN
         1OTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VJiocofieY63XWMw3Tm+9sJUrLUcJmv4XejC+1LWSxk=;
        b=y/6FcqucUt8SQAewK4+LxkTRYVJFwGCXmbVvMdXJijfOtU6afhwOuPqVi/llSY51Cr
         RqnzC3+EKMDfyBV/N+9739itcrX70Y9L8zPdYsffI/THeGVkeUzE3Jzj9UkZEJrKILCA
         o/4cpHuZGzkaKOFvQfKFMUYBWvydOxT41MpoZ9R1xUHRTcqVaprVFOL33WLnM2rd4fwO
         pXT4XbC4h720a8AWsXt7rUYBbSBXk+AkKLQJP7rjN8ZzdG/jrMquDvXui/vQ3mPPegeu
         4aZP4BG6zCuehUwjLDAlw+AsFQFQVCpADwe/hOBvJPsmCrYrQewjAsPpedO5v4aGgXFS
         Qk0g==
X-Gm-Message-State: AFqh2kqym9DodZ6Wy87756YksXZPnY5gHj0E/jcoYjS1rLOX6BZYrcml
	37c+jct0/GsJVVpRVd51DHYtfYF4q67BW7iWGfC16g==
X-Google-Smtp-Source: AMrXdXsya6s9flFhR7mWGTE6QBpcntysLy6XupxqrVtUpbiokDi+ibqEn25RM979VX+YJekVuLAHdQ==
X-Received: by 2002:a17:902:e5d2:b0:192:7258:dfb1 with SMTP id u18-20020a170902e5d200b001927258dfb1mr9257992plf.59.1674086325045;
        Wed, 18 Jan 2023 15:58:45 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u20-20020a170902e21400b0019311ec72e8sm8024228plb.253.2023.01.18.15.58.44
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 15:58:44 -0800 (PST)
Message-ID: <63c887b4.170a0220.8c363.c8d2@mx.google.com>
Date: Wed, 18 Jan 2023 15:58:44 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.19.269-rt119-858-g4aae57dbf650
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline: 116 runs,
 53 regressions (v4.19.269-rt119-858-g4aae57dbf650)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Jan 2023 23:58:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10414

cip-gitlab/ci/pavel/linux-test baseline: 116 runs, 53 regressions (v4.19.26=
9-rt119-858-g4aae57dbf650)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig           | 1          =

beagle-xm                    | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 2          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig           | 2          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =

imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

imx6sx-sdb                   | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =

juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-baylibre    | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-baylibre    | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-baylibre    | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-baylibre    | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

qemu_x86_64-uefi-mixed       | x86_64 | lab-baylibre    | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

qemu_x86_64-uefi-mixed       | x86_64 | lab-baylibre    | gcc-10   | x86_64=
_defconfig             | 1          =

qemu_x86_64-uefi-mixed       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

qemu_x86_64-uefi-mixed       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig             | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =

r8a7796-m3ulcb               | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 7          =

sun50i-h6-pine-h64           | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

sun8i-h2-plus...ch-all-h3-cc | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =

sun8i-h2-plus...ch-all-h3-cc | arm    | lab-baylibre    | gcc-10   | sunxi_=
defconfig              | 1          =

sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =

sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre    | gcc-10   | sunxi_=
defconfig              | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.269-rt119-858-g4aae57dbf650/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.269-rt119-858-g4aae57dbf650
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      4aae57dbf650bb88d187f251ebdbd3984020b619 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c87a7d943618118a915eba

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/baseline-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/baseline-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c87a7d943618118a915=
ebb
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8797641f758edcc915ed7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/baseline-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/baseline-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c8797641f758edcc915edc
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-18T22:57:37.660061  + set<8>[   10.628039] <LAVA_SIGNAL_ENDRUN =
0_dmesg 8786518_1.4.2.3.1>
    2023-01-18T22:57:37.660150   +x
    2023-01-18T22:57:37.762222  #
    2023-01-18T22:57:37.863427  / # #export SHELL=3D/bin/sh
    2023-01-18T22:57:37.863642  =

    2023-01-18T22:57:37.964507  / # export SHELL=3D/bin/sh. /lava-8786518/e=
nvironment
    2023-01-18T22:57:37.964726  =

    2023-01-18T22:57:38.065421  / # . /lava-8786518/environment/lava-878651=
8/bin/lava-test-runner /lava-8786518/1
    2023-01-18T22:57:38.065758  =

    2023-01-18T22:57:38.070747  / # /lava-8786518/bin/lava-test-runner /lav=
a-8786518/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c87be330ea1a740c915eb9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c87be330ea1a740c915=
eba
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c87a7c6e12afc26c915ef5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c87a7c6e12afc26c915=
ef6
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63c87bbb5c639bea40915ec4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm/multi_v5_defconfig/gcc-10/lab-brooni=
e/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm/multi_v5_defconfig/gcc-10/lab-brooni=
e/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c87bbb5c639bea40915ec9
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-18T23:07:21.560321  + set +x
    2023-01-18T23:07:21.565723  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 139064_1.5.2=
.4.1>
    2023-01-18T23:07:21.680023  / # #
    2023-01-18T23:07:21.783442  export SHELL=3D/bin/sh
    2023-01-18T23:07:21.784498  #
    2023-01-18T23:07:21.886746  / # export SHELL=3D/bin/sh. /lava-139064/en=
vironment
    2023-01-18T23:07:21.887855  =

    2023-01-18T23:07:21.989950  / # . /lava-139064/environment/lava-139064/=
bin/lava-test-runner /lava-139064/1
    2023-01-18T23:07:21.991480  =

    2023-01-18T23:07:21.997713  / # /lava-139064/bin/lava-test-runner /lava=
-139064/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beagle-xm                    | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63c87cfec161147c3b915f14

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm/multi_v7_defconfig/gcc-10/lab-baylib=
re/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm/multi_v7_defconfig/gcc-10/lab-baylib=
re/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c87cfec161147c3b915f19
        failing since 0 day (last pass: v5.10.145-rt74-1329-ga59fc50f38f6, =
first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-18T23:12:36.405489  <8>[   20.892730] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3164131_1.5.2.4.1>
    2023-01-18T23:12:36.518565  / # #
    2023-01-18T23:12:36.621776  export SHELL=3D/bin/sh
    2023-01-18T23:12:36.622465  #
    2023-01-18T23:12:36.724332  / # export SHELL=3D/bin/sh. /lava-3164131/e=
nvironment
    2023-01-18T23:12:36.724896  =

    2023-01-18T23:12:36.826348  / # . /lava-3164131/environment/lava-316413=
1/bin/lava-test-runner /lava-3164131/1
    2023-01-18T23:12:36.828023  =

    2023-01-18T23:12:36.831526  / # /lava-3164131/bin/lava-test-runner /lav=
a-3164131/1
    2023-01-18T23:12:36.917885  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 2          =


  Details:     https://kernelci.org/test/plan/id/63c87c8d6868e2b2f3915ecc

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c87c8d6868e2b2f3915ed1
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-18T23:10:48.047384  <8>[   16.392371] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 139106_1.5.2.4.1>
    2023-01-18T23:10:48.155286  / # #
    2023-01-18T23:10:48.257701  export SHELL=3D/bin/sh
    2023-01-18T23:10:48.258253  #
    2023-01-18T23:10:48.360117  / # export SHELL=3D/bin/sh. /lava-139106/en=
vironment
    2023-01-18T23:10:48.360641  =

    2023-01-18T23:10:48.462461  / # . /lava-139106/environment/lava-139106/=
bin/lava-test-runner /lava-139106/1
    2023-01-18T23:10:48.463352  =

    2023-01-18T23:10:48.466897  / # /lava-139106/bin/lava-test-runner /lava=
-139106/1
    2023-01-18T23:10:48.534010  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =


  * baseline.dmesg.crit: https://kernelci.org/test/case/id/63c87c8d6868e2b2=
f3915ed5
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)
        1 lines

    2023-01-18T23:10:47.362080  / # =

    2023-01-18T23:10:47.367397  =

    2023-01-18T23:10:47.471955  / # #
    2023-01-18T23:10:47.477418  #
    2023-01-18T23:10:47.579579  / # export SHELL=3D/bin/sh
    2023-01-18T23:10:47.585346  export SHELL=3D/bin/sh
    2023-01-18T23:10:47.687164  / # . /lava-139106/environment
    2023-01-18T23:10:47.693092  . /lava-139106/environment
    2023-01-18T23:10:47.795083  / # /lava-139106/bin/lava-test-runner /lava=
-139106/0
    2023-01-18T23:10:47.800422  /lava-139106/bin/lava-test-runner /lava-139=
106/0 =

    ... (9 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig           | 2          =


  Details:     https://kernelci.org/test/plan/id/63c880b8ad93e7ced9915eb9

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm/multi_v7_defconfig/gcc-10/lab-cip/ba=
seline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm/multi_v7_defconfig/gcc-10/lab-cip/ba=
seline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c880b8ad93e7ced9915ebc
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-18T23:28:36.473362  + set +x
    2023-01-18T23:28:36.475399  <8>[   11.861891] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 828168_1.5.2.4.1>
    2023-01-18T23:28:36.584029  / # #
    2023-01-18T23:28:36.686003  export SHELL=3D/bin/sh
    2023-01-18T23:28:36.686462  #
    2023-01-18T23:28:36.787920  / # export SHELL=3D/bin/sh. /lava-828168/en=
vironment
    2023-01-18T23:28:36.788476  =

    2023-01-18T23:28:36.889899  / # . /lava-828168/environment/lava-828168/=
bin/lava-test-runner /lava-828168/1
    2023-01-18T23:28:36.890653  =

    2023-01-18T23:28:36.892217  / # /lava-828168/bin/lava-test-runner /lava=
-828168/1 =

    ... (12 line(s) more)  =


  * baseline.dmesg.crit: https://kernelci.org/test/case/id/63c880b8ad93e7ce=
d9915ec0
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)
        1 lines

    2023-01-18T23:28:35.808393  / # =

    2023-01-18T23:28:35.811757  =

    2023-01-18T23:28:35.916235  / # #
    2023-01-18T23:28:35.919233  #
    2023-01-18T23:28:36.020948  / # export SHELL=3D/bin/sh
    2023-01-18T23:28:36.023897  export SHELL=3D/bin/sh
    2023-01-18T23:28:36.125320  / # . /lava-828168/environment
    2023-01-18T23:28:36.128175  . /lava-828168/environment
    2023-01-18T23:28:36.229634  / # /lava-828168/bin/lava-test-runner /lava=
-828168/0
    2023-01-18T23:28:36.231926  /lava-828168/bin/lava-test-runner /lava-828=
168/0 =

    ... (9 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63c87ac0113106cf8c915eff

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm/omap2plus_defconfig/gcc-10/lab-broon=
ie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm/omap2plus_defconfig/gcc-10/lab-broon=
ie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/63c87ac0113106cf=
8c915f08
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)
        1 lines

    2023-01-18T23:03:09.326607  / # =

    2023-01-18T23:03:09.611596  =

    2023-01-18T23:03:09.714082  / # #
    2023-01-18T23:03:09.721962  #
    2023-01-18T23:03:09.823537  / # export SHELL=3D/bin/sh
    2023-01-18T23:03:09.831351  export SHELL=3D/bin/sh
    2023-01-18T23:03:09.932821  / # . /lava-139061/environment
    2023-01-18T23:03:09.940875  . /lava-139061/environment
    2023-01-18T23:03:10.042276  / # /lava-139061/bin/lava-test-runner /lava=
-139061/0
    2023-01-18T23:03:10.047447  /lava-139061/bin/lava-test-runner /lava-139=
061/0 =

    ... (9 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63c87a9ece49e1718f915ee2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm/omap2plus_defconfig/gcc-10/lab-cip/b=
aseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm/omap2plus_defconfig/gcc-10/lab-cip/b=
aseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/63c87a9ece49e171=
8f915ee9
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)
        1 lines

    2023-01-18T23:02:34.749234  / # =

    2023-01-18T23:02:34.756202  =

    2023-01-18T23:02:34.860588  / # #
    2023-01-18T23:02:34.864985  #
    2023-01-18T23:02:34.966716  / # export SHELL=3D/bin/sh
    2023-01-18T23:02:34.969742  export SHELL=3D/bin/sh
    2023-01-18T23:02:35.072271  / # . /lava-828148/environment
    2023-01-18T23:02:35.076739  . /lava-828148/environment
    2023-01-18T23:02:35.178196  / # /lava-828148/bin/lava-test-runner /lava=
-828148/0
    2023-01-18T23:02:35.181224  /lava-828148/bin/lava-test-runner /lava-828=
148/0 =

    ... (9 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63c87c289dc9ace1ca915eb9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm/multi_v7_defconfig/gcc-10/lab-collab=
ora/baseline-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm/multi_v7_defconfig/gcc-10/lab-collab=
ora/baseline-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c87c289dc9ace1ca915ebe
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-18T23:09:11.378630  / # #
    2023-01-18T23:09:11.481816  export SHELL=3D/bin/sh
    2023-01-18T23:09:11.482589  #
    2023-01-18T23:09:11.584659  / # export SHELL=3D/bin/sh. /lava-8786655/e=
nvironment
    2023-01-18T23:09:11.585476  =

    2023-01-18T23:09:11.687631  / # . /lava-8786655/environment/lava-878665=
5/bin/lava-test-runner /lava-8786655/1
    2023-01-18T23:09:11.688810  =

    2023-01-18T23:09:11.701247  / # /lava-8786655/bin/lava-test-runner /lav=
a-8786655/1
    2023-01-18T23:09:11.809086  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-18T23:09:11.809593  + cd /lava-8786655/1/tests/1_bootrr =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8796ad7149d426d915ef1

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm/imx_v6_v7_defconfig/gcc-10/lab-pengu=
tronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm/imx_v6_v7_defconfig/gcc-10/lab-pengu=
tronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c8796ad7149d426d915ef6
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-18T22:57:37.828963  + set +x[    7.157210] <LAVA_SIGNAL_ENDRUN =
0_dmesg 882692_1.5.2.3.1>
    2023-01-18T22:57:37.829124  =

    2023-01-18T22:57:37.936571  / # #
    2023-01-18T22:57:38.038049  export SHELL=3D/bin/sh
    2023-01-18T22:57:38.038412  #
    2023-01-18T22:57:38.139536  / # export SHELL=3D/bin/sh. /lava-882692/en=
vironment
    2023-01-18T22:57:38.139916  =

    2023-01-18T22:57:38.241173  / # . /lava-882692/environment/lava-882692/=
bin/lava-test-runner /lava-882692/1
    2023-01-18T22:57:38.241771  =

    2023-01-18T22:57:38.244381  / # /lava-882692/bin/lava-test-runner /lava=
-882692/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63c87c1128589615dd915ebf

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm/multi_v7_defconfig/gcc-10/lab-pengut=
ronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm/multi_v7_defconfig/gcc-10/lab-pengut=
ronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c87c1128589615dd915ec4
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-18T23:08:41.775942  + set +x
    2023-01-18T23:08:41.776104  [    4.938409] <LAVA_SIGNAL_ENDRUN 0_dmesg =
882699_1.5.2.3.1>
    2023-01-18T23:08:41.882046  / # #
    2023-01-18T23:08:41.983506  export SHELL=3D/bin/sh
    2023-01-18T23:08:41.983895  #
    2023-01-18T23:08:42.085075  / # export SHELL=3D/bin/sh. /lava-882699/en=
vironment
    2023-01-18T23:08:42.085461  =

    2023-01-18T23:08:42.186608  / # . /lava-882699/environment/lava-882699/=
bin/lava-test-runner /lava-882699/1
    2023-01-18T23:08:42.187157  =

    2023-01-18T23:08:42.189588  / # /lava-882699/bin/lava-test-runner /lava=
-882699/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6sx-sdb                   | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63c87c673170def3f6915ebf

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm/multi_v7_defconfig/gcc-10/lab-nxp/ba=
seline-imx6sx-sdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm/multi_v7_defconfig/gcc-10/lab-nxp/ba=
seline-imx6sx-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c87c673170def3f6915ec2
        failing since 0 day (last pass: v5.10.145-rt74-1329-ga59fc50f38f6, =
first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-18T23:09:41.780321  / # #
    2023-01-18T23:09:42.938588  export SHELL=3D/bin/sh
    2023-01-18T23:09:42.943968  #
    2023-01-18T23:09:44.489218  / # export SHELL=3D/bin/sh. /lava-1140312/e=
nvironment
    2023-01-18T23:09:44.494595  =

    2023-01-18T23:09:47.314932  / # . /lava-1140312/environment/lava-114031=
2/bin/lava-test-runner /lava-1140312/1
    2023-01-18T23:09:47.320692  =

    2023-01-18T23:09:47.324366  / # /lava-1140312/bin/lava-test-runner /lav=
a-1140312/1
    2023-01-18T23:09:47.427443  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-18T23:09:47.427751  + cd /lava-1140312/1/tests/1_bootrr =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c87b07cbdb9e4678915eba

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c87b07cbdb9e4678915=
ebb
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c87b72ff5030ba62915eb9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c87b72ff5030ba62915=
eba
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c87b8bff5030ba62915eeb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm64/defconfig/gcc-10/lab-baylibre/base=
line-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm64/defconfig/gcc-10/lab-baylibre/base=
line-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c87b8bff5030ba62915=
eec
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-baylibre    | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63c87b8d029ddcb09f915ebc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-baylibre/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-baylibre/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c87b8d029ddcb09f915=
ebd
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c87adf786dd7ee5b915eba

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm64/defconfig/gcc-10/lab-collabora/bas=
eline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm64/defconfig/gcc-10/lab-collabora/bas=
eline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c87adf786dd7ee5b915=
ebb
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63c87be730ea1a740c915ec7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c87be730ea1a740c915=
ec8
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-baylibre    | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63c87b9e029ddcb09f915ec3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-baylibre/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-baylibre/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c87b9e029ddcb09f915=
ec4
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c87be57df42ca9a1915ed3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm64/defconfig/gcc-10/lab-baylibre/base=
line-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm64/defconfig/gcc-10/lab-baylibre/base=
line-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c87be57df42ca9a1915=
ed4
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c87ae0786dd7ee5b915ed1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm64/defconfig/gcc-10/lab-collabora/bas=
eline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm64/defconfig/gcc-10/lab-collabora/bas=
eline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c87ae0786dd7ee5b915=
ed2
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63c87af4e59a560a35915f56

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c87af4e59a560a35915=
f57
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-baylibre    | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63c87b8c029ddcb09f915eb9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-baylibre/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-baylibre/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c87b8c029ddcb09f915=
eba
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c87bb35c639bea40915eb9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm64/defconfig/gcc-10/lab-baylibre/base=
line-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm64/defconfig/gcc-10/lab-baylibre/base=
line-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c87bb35c639bea40915=
eba
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c87afae59a560a35915f59

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm64/defconfig/gcc-10/lab-collabora/bas=
eline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm64/defconfig/gcc-10/lab-collabora/bas=
eline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c87afae59a560a35915=
f5a
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63c87b0fcbdb9e4678915ed6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c87b0fcbdb9e4678915=
ed7
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-baylibre    | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63c87bb4e4394d5f32915ebf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-baylibre/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-baylibre/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c87bb4e4394d5f32915=
ec0
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c87be730ea1a740c915ec4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm64/defconfig/gcc-10/lab-baylibre/base=
line-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm64/defconfig/gcc-10/lab-baylibre/base=
line-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c87be730ea1a740c915=
ec5
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c87afbe59a560a35915f5c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm64/defconfig/gcc-10/lab-collabora/bas=
eline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm64/defconfig/gcc-10/lab-collabora/bas=
eline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c87afbe59a560a35915=
f5d
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63c87afce59a560a35915f5f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c87afce59a560a35915=
f60
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-baylibre    | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c87ad795a19044dd915ed8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-baylibre/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-baylibre/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c87ad795a19044dd915=
ed9
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-baylibre    | gcc-10   | x86_64=
_defconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/63c87ad995a19044dd915edb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/x86_64/x86_64_defconfig/gcc-10/lab-bayli=
bre/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/x86_64/x86_64_defconfig/gcc-10/lab-bayli=
bre/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c87ad995a19044dd915=
edc
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c87a7bb5751106e8915edc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c87a7bb5751106e8915=
edd
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/63c87a8fc87f8b907c915ed0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/x86_64/x86_64_defconfig/gcc-10/lab-colla=
bora/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/x86_64/x86_64_defconfig/gcc-10/lab-colla=
bora/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c87a8fc87f8b907c915=
ed1
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63c87a2bc5b2dc4083915eed

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm/shmobile_defconfig/gcc-10/lab-cip/ba=
seline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm/shmobile_defconfig/gcc-10/lab-cip/ba=
seline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c87a2bc5b2dc4083915=
eee
        new failure (last pass: v4.19.269-rt119-1495-gc851fb1e222f) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a7796-m3ulcb               | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c879f3bd8d8247f2915ecb

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm64/defconfig/gcc-10/lab-collabora/bas=
eline-r8a7796-m3ulcb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm64/defconfig/gcc-10/lab-collabora/bas=
eline-r8a7796-m3ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c879f3bd8d8247f2915ed0
        failing since 0 day (last pass: v4.19.265-cip85-rt27, first fail: v=
4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-18T22:59:44.169411  / # #
    2023-01-18T22:59:44.270999  export SHELL=3D/bin/sh
    2023-01-18T22:59:44.271440  #
    2023-01-18T22:59:44.372786  / # export SHELL=3D/bin/sh. /lava-8786564/e=
nvironment
    2023-01-18T22:59:44.373229  =

    2023-01-18T22:59:44.474596  / # . /lava-8786564/environment/lava-878656=
4/bin/lava-test-runner /lava-8786564/1
    2023-01-18T22:59:44.475264  =

    2023-01-18T22:59:44.479018  / # /lava-8786564/bin/lava-test-runner /lav=
a-8786564/1
    2023-01-18T22:59:44.537817  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-18T22:59:44.538061  + cd /lav<8>[   21.081961] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 8786564_1.5.2.4.5> =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 7          =


  Details:     https://kernelci.org/test/plan/id/63c87ba7029ddcb09f915ec9

  Results:     79 PASS, 9 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rk3399-gru-sound-driver-rt5514-present: https://kernelc=
i.org/test/case/id/63c87ba7029ddcb09f915f00
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-18T23:06:56.204584  ox v1.31.1 (2023-01-15 00:20:44 UTC) multi-=
call binary.
    2023-01-18T23:06:56.204850  =

    2023-01-18T23:06:56.205516  =

    2023-01-18T23:06:56.210139  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST
    2023-01-18T23:06:56.210225  =

    2023-01-18T23:06:56.214413  Print numbers from FIRST to LAST, in steps =
of INC.
    2023-01-18T23:06:56.214885  =

    2023-01-18T23:06:56.217164  FIRST, INC default to 1.
    2023-01-18T23:06:56.217632  =

    2023-01-18T23:06:56.228150  	-w	Pa<8>[   34.757133] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Drk3399-gru-sound-driver-rt5514-present RESULT=3Dfail>   =


  * baseline.bootrr.rk3399-gru-sound-driver-max98357A-present: https://kern=
elci.org/test/case/id/63c87ba7029ddcb09f915f01
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-18T23:06:56.169623  FIRST,<8>[   34.700445] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Drk3399-gru-sound-driver-dp-present RESULT=3Dfail>
    2023-01-18T23:06:56.170397  =

    2023-01-18T23:06:56.178466   INC default to 1.
    2023-01-18T23:06:56.178552  =

    2023-01-18T23:06:56.182227  	-w	Pad to last with leading zeros
    2023-01-18T23:06:56.184822  	-s SEP	String separator
    2023-01-18T23:06:56.188260  /lava-8786592/1/../bin/lava-test-case
    2023-01-18T23:06:56.199479  BusyB<8>[   34.726568] <LAVA_SIGNAL_TESTCAS=
E TEST_CASE_ID=3Drk3399-gru-sound-driver-max98357A-present RESULT=3Dfail>   =


  * baseline.bootrr.rk3399-gru-sound-driver-dp-present: https://kernelci.or=
g/test/case/id/63c87ba7029ddcb09f915f02
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-18T23:06:56.148767   multi-call binary.
    2023-01-18T23:06:56.148845  =

    2023-01-18T23:06:56.149096  =

    2023-01-18T23:06:56.154076  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST
    2023-01-18T23:06:56.154159  =

    2023-01-18T23:06:56.159035  Print numbers from FIRST to LAST, in steps =
of INC.   =


  * baseline.bootrr.rk3399-gru-sound-driver-da7219-present: https://kernelc=
i.org/test/case/id/63c87ba7029ddcb09f915f03
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-18T23:06:56.146733  BusyBox v1.31.1 (2023-01-15 00:20:44 UTC)<8=
>[   34.679130] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Drk3399-gru-sound-drive=
r-da7219-present RESULT=3Dfail>   =


  * baseline.bootrr.cros-ec-sysfs-driver-present: https://kernelci.org/test=
/case/id/63c87ba7029ddcb09f915f0a
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-18T23:06:54.961474  /lava-8786592/1/../bin/lava-test-case
    2023-01-18T23:06:54.970880  <8>[   33.504054] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-sysfs-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cros-ec-lightbar-driver-present: https://kernelci.org/t=
est/case/id/63c87ba7029ddcb09f915f13
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =


  * baseline.bootrr.cros-ec-debugfs-driver-present: https://kernelci.org/te=
st/case/id/63c87ba7029ddcb09f915f1c
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-18T23:06:50.514626  =

    2023-01-18T23:06:51.530619  /lava-8786592/1/../bin/lava-test-case
    2023-01-18T23:06:51.540076  <8>[   30.072979] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-debugfs-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c879fe260b3b10d7915f30

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm64/defconfig/gcc-10/lab-baylibre/base=
line-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm64/defconfig/gcc-10/lab-baylibre/base=
line-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c879fe260b3b10d7915f35
        failing since 0 day (last pass: v5.10.145-cip17-rt7, first fail: v4=
.19.269-rt119-1495-gc851fb1e222f)

    2023-01-18T22:59:53.176620  / # #
    2023-01-18T22:59:53.278509  export SHELL=3D/bin/sh
    2023-01-18T22:59:53.278869  #
    2023-01-18T22:59:53.380244  / # export SHELL=3D/bin/sh. /lava-3164066/e=
nvironment
    2023-01-18T22:59:53.380850  =

    2023-01-18T22:59:53.482266  / # . /lava-3164066/environment/lava-316406=
6/bin/lava-test-runner /lava-3164066/1
    2023-01-18T22:59:53.483160  =

    2023-01-18T22:59:53.487736  / # /lava-3164066/bin/lava-test-runner /lav=
a-3164066/1
    2023-01-18T22:59:53.557656  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-18T22:59:53.558346  + cd /lava-3164066<8>[   15.593301] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 3164066_1.5.2.4.5> =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c879f4110de2596f915ec2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm64/defconfig/gcc-10/lab-collabora/bas=
eline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm64/defconfig/gcc-10/lab-collabora/bas=
eline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c879f4110de2596f915ec7
        failing since 0 day (last pass: v5.10.145-cip17-rt7, first fail: v4=
.19.269-rt119-1495-gc851fb1e222f)

    2023-01-18T22:59:48.310395  / # #
    2023-01-18T22:59:48.412225  export SHELL=3D/bin/sh
    2023-01-18T22:59:48.412844  #
    2023-01-18T22:59:48.514232  / # export SHELL=3D/bin/sh. /lava-8786565/e=
nvironment
    2023-01-18T22:59:48.514756  =

    2023-01-18T22:59:48.616176  / # . /lava-8786565/environment/lava-878656=
5/bin/lava-test-runner /lava-8786565/1
    2023-01-18T22:59:48.617211  =

    2023-01-18T22:59:48.620077  / # /lava-8786565/bin/lava-test-runner /lav=
a-8786565/1
    2023-01-18T22:59:48.691759  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-18T22:59:48.692081  + cd /lava-8786565<8>[   15.597202] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 8786565_1.5.2.4.5> =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun8i-h2-plus...ch-all-h3-cc | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63c87c2e9dc9ace1ca915ecf

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm/multi_v7_defconfig/gcc-10/lab-baylib=
re/baseline-sun8i-h2-plus-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm/multi_v7_defconfig/gcc-10/lab-baylib=
re/baseline-sun8i-h2-plus-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c87c2e9dc9ace1ca915ed4
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-18T23:09:14.083811  / # #
    2023-01-18T23:09:14.185611  export SHELL=3D/bin/sh
    2023-01-18T23:09:14.185977  #
    2023-01-18T23:09:14.287316  / # export SHELL=3D/bin/sh. /lava-3164130/e=
nvironment
    2023-01-18T23:09:14.287729  =

    2023-01-18T23:09:14.389095  / # . /lava-3164130/environment/lava-316413=
0/bin/lava-test-runner /lava-3164130/1
    2023-01-18T23:09:14.389752  =

    2023-01-18T23:09:14.395094  / # /lava-3164130/bin/lava-test-runner /lav=
a-3164130/1
    2023-01-18T23:09:14.443185  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-18T23:09:14.482934  + cd /lava-3164130/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun8i-h2-plus...ch-all-h3-cc | arm    | lab-baylibre    | gcc-10   | sunxi_=
defconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/63c87a63cf56dd1770915ed6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: sunxi_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm/sunxi_defconfig/gcc-10/lab-baylibre/=
baseline-sun8i-h2-plus-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm/sunxi_defconfig/gcc-10/lab-baylibre/=
baseline-sun8i-h2-plus-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c87a63cf56dd1770915edb
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-18T23:01:33.236282  + set +x
    2023-01-18T23:01:33.238355  <8>[    7.977816] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3164112_1.5.2.4.1>
    2023-01-18T23:01:33.343581  / # #
    2023-01-18T23:01:33.445361  export SHELL=3D/bin/sh
    2023-01-18T23:01:33.445869  #
    2023-01-18T23:01:33.547167  / # export SHELL=3D/bin/sh. /lava-3164112/e=
nvironment
    2023-01-18T23:01:33.547555  =

    2023-01-18T23:01:33.648956  / # . /lava-3164112/environment/lava-316411=
2/bin/lava-test-runner /lava-3164112/1
    2023-01-18T23:01:33.649746  =

    2023-01-18T23:01:33.669118  / # /lava-3164112/bin/lava-test-runner /lav=
a-3164112/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63c87c2c9dc9ace1ca915ec4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm/multi_v7_defconfig/gcc-10/lab-baylib=
re/baseline-sun8i-h3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm/multi_v7_defconfig/gcc-10/lab-baylib=
re/baseline-sun8i-h3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c87c2c9dc9ace1ca915ec9
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-18T23:09:11.628406  / # #
    2023-01-18T23:09:11.730122  export SHELL=3D/bin/sh
    2023-01-18T23:09:11.730507  #
    2023-01-18T23:09:11.831861  / # export SHELL=3D/bin/sh. /lava-3164125/e=
nvironment
    2023-01-18T23:09:11.832230  =

    2023-01-18T23:09:11.933568  / # . /lava-3164125/environment/lava-316412=
5/bin/lava-test-runner /lava-3164125/1
    2023-01-18T23:09:11.934174  =

    2023-01-18T23:09:11.939798  / # /lava-3164125/bin/lava-test-runner /lav=
a-3164125/1
    2023-01-18T23:09:11.987856  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-18T23:09:12.027518  + cd /lava-3164125/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre    | gcc-10   | sunxi_=
defconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/63c87a60cf56dd1770915ec9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: sunxi_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm/sunxi_defconfig/gcc-10/lab-baylibre/=
baseline-sun8i-h3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm/sunxi_defconfig/gcc-10/lab-baylibre/=
baseline-sun8i-h3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c87a60cf56dd1770915ece
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-18T23:01:30.411017  / # #
    2023-01-18T23:01:30.512807  export SHELL=3D/bin/sh
    2023-01-18T23:01:30.513371  #
    2023-01-18T23:01:30.614713  / # export SHELL=3D/bin/sh. /lava-3164109/e=
nvironment
    2023-01-18T23:01:30.615157  =

    2023-01-18T23:01:30.716525  / # . /lava-3164109/environment/lava-316410=
9/bin/lava-test-runner /lava-3164109/1
    2023-01-18T23:01:30.717150  =

    2023-01-18T23:01:30.722047  / # /lava-3164109/bin/lava-test-runner /lav=
a-3164109/1
    2023-01-18T23:01:30.800902  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-18T23:01:30.801386  + cd /lava-3164109/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20

