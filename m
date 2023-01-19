Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680ACC6379F
	for <webhook@archiver.kernel.org>; Thu, 19 Jan 2023 09:59:10 +0000 (UTC)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
 by mx.groups.io with SMTP id smtpd.web11.42128.1674122348926941196
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 19 Jan 2023 01:59:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=8USaH4GM;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.43, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f43.google.com with SMTP id n20-20020a17090aab9400b00229ca6a4636so4476872pjq.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 19 Jan 2023 01:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wBxDfkivvALWmNPyDw9HgcUHkljcEBNaX0iPNSrAjb4=;
        b=8USaH4GMOxYWfLFQSyz4mUWULuZbyOWGvrSxRvZAQuHuGJKELxLAMoxMWivXrWCQ5v
         t5qE76bBH74iBYAhLXdKvDAAbeHzjf4SbUqAfTQ7YciUJDXO/OvmYheVlZY3EAxXFeU6
         M2qtq1K99W+xVxhUgWTcT/1434qWmxAMH0lwoX62Nz/RWVC2ICjPcUlwn1LHkoxpwSiC
         YjcT61n3LMlzZBNo3bhJlcZI6TGYXsHdSYFyktiW5R401N1i36bjJa+1D/8AZpW5Od6n
         lRZmCpIXFZNnNyk93UU764kKIYhRBEC58DVsApnuhAQ3ZSGWuWIK4m+pDcdU7nevgAD2
         mFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wBxDfkivvALWmNPyDw9HgcUHkljcEBNaX0iPNSrAjb4=;
        b=UmLC9mLfjh0jqRc+RjFncPN5qv+0VvbTBiEJ2S58XAGved7ePLZK4LmYbka65xOyAc
         CVGSoofNcRCMm8mGs54dnuFgH3dWqbXkvu2e5GP/tP1ZMOoEC9+T3IEh9Rcx2Tb1N3EY
         e4MR7lcggMXs0VOk6KSz2CZXRwDiGnK0sZqwEop7Gco0ds3MFiFCLpxqIFDS9SCTRQTc
         MO+mYhZjH2qJ7nKAi290bQQceGqk7GJzAyv+UWzyQgzBuz6LTJnAghSDrLvRu6n/ww5b
         J6KoyJ0RXxzfvtjsWkIM1iBikOAUMUlg4VZOPxB5brl1cGGLSmD1ID6GHT8VXwiOGC6Q
         n1hA==
X-Gm-Message-State: AFqh2kq3+OeHJwRHpRS1iAT3hhWuwOYOPLYLYPgB6XqKkz/HO5/lH+Hs
	l6Av2zuWJ4TzVxDjvawVhatqyfcQAJgokSARjJSohQ==
X-Google-Smtp-Source: AMrXdXsbEJ7o9bbffUsZRnP4v70ZGvxZ51UEw1HuJDueZaGRVCmPZQwFax80VjLQSUBVqt8E3tq/5Q==
X-Received: by 2002:a17:902:f70e:b0:193:3845:de53 with SMTP id h14-20020a170902f70e00b001933845de53mr12040247plo.39.1674122347808;
        Thu, 19 Jan 2023 01:59:07 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y13-20020a170902b48d00b00192f7f8db8esm11507300plr.297.2023.01.19.01.59.07
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 01:59:07 -0800 (PST)
Message-ID: <63c9146b.170a0220.31228.1b66@mx.google.com>
Date: Thu, 19 Jan 2023 01:59:07 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Kernel: v4.19.269-cip88-479-g3f9e11225caa5
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 101 runs,
 43 regressions (v4.19.269-cip88-479-g3f9e11225caa5)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Jan 2023 09:59:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10433

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 101 runs, 43 regressio=
ns (v4.19.269-cip88-479-g3f9e11225caa5)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

beagle-xm                    | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =

beagle-xm                    | arm    | lab-baylibre    | gcc-10   | omap2p=
lus_defconfig          | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig           | 1          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =

dove-cubox                   | arm    | lab-pengutronix | gcc-10   | mvebu_=
v7_defconfig           | 1          =

imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

imx6sx-sdb                   | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =

meson-gxbb-p200              | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

meson-gxl-s905d-p230         | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-broonie     | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-broonie     | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-baylibre    | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-broonie     | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-baylibre    | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-broonie     | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 5          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

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

zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.269-cip88-479-g3f9e11225caa5/plan/baselin=
e/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.269-cip88-479-g3f9e11225caa5
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      3f9e11225caa53af6e56924348b7fb20ccc15806 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c9113716c964ae83915eb9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c9113716c964ae83915ebe
        new failure (last pass: v4.19.265-cip85-36-gf1ffb3de9576)

    2023-01-19T09:45:02.142836  + set +x<8>[    9.596902] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 8794213_1.4.2.3.1>
    2023-01-19T09:45:02.143357  =

    2023-01-19T09:45:02.252105  #
    2023-01-19T09:45:02.355264  / # #export SHELL=3D/bin/sh
    2023-01-19T09:45:02.356172  =

    2023-01-19T09:45:02.458124  / # export SHELL=3D/bin/sh. /lava-8794213/e=
nvironment
    2023-01-19T09:45:02.458451  =

    2023-01-19T09:45:02.559729  / # . /lava-8794213/environment/lava-879421=
3/bin/lava-test-runner /lava-8794213/1
    2023-01-19T09:45:02.561024  =

    2023-01-19T09:45:02.566156  / # /lava-8794213/bin/lava-test-runner /lav=
a-8794213/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beagle-xm                    | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63c9128d17d54adccf915f2d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm/multi_v7_defconfig/gcc-=
10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm/multi_v7_defconfig/gcc-=
10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c9128d17d54adccf915f32
        new failure (last pass: v4.19.259-cip82-57-ge54228ee5a88d)

    2023-01-19T09:50:42.321164  <8>[   20.571990] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3168747_1.5.2.4.1>
    2023-01-19T09:50:42.434257  / # #
    2023-01-19T09:50:42.536770  export SHELL=3D/bin/sh
    2023-01-19T09:50:42.537630  #
    2023-01-19T09:50:42.639718  / # export SHELL=3D/bin/sh. /lava-3168747/e=
nvironment
    2023-01-19T09:50:42.640552  =

    2023-01-19T09:50:42.742467  / # . /lava-3168747/environment/lava-316874=
7/bin/lava-test-runner /lava-3168747/1
    2023-01-19T09:50:42.743811  =

    2023-01-19T09:50:42.748370  / # /lava-3168747/bin/lava-test-runner /lav=
a-3168747/1
    2023-01-19T09:50:42.832947  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beagle-xm                    | arm    | lab-baylibre    | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63c90cf826fa3c5e72915f87

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm/omap2plus_defconfig/gcc=
-10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm/omap2plus_defconfig/gcc=
-10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c90cf826fa3c5e72915f8c
        new failure (last pass: v4.19.252-cip78-146-g6acc38498265c)

    2023-01-19T09:26:46.648851  + set +x<8>[   25.531951] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3168476_1.5.2.4.1>
    2023-01-19T09:26:46.649076  =

    2023-01-19T09:26:46.759851  / # #
    2023-01-19T09:26:46.861937  export SHELL=3D/bin/sh
    2023-01-19T09:26:46.862268  #
    2023-01-19T09:26:46.963494  / # export SHELL=3D/bin/sh. /lava-3168476/e=
nvironment
    2023-01-19T09:26:46.964331  =

    2023-01-19T09:26:47.066215  / # . /lava-3168476/environment/lava-316847=
6/bin/lava-test-runner /lava-3168476/1
    2023-01-19T09:26:47.068219  =

    2023-01-19T09:26:47.073166  / # /lava-3168476/bin/lava-test-runner /lav=
a-3168476/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63c90dc9745d947a4c915f4e

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm/multi_v7_defconfig/gcc-=
10/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm/multi_v7_defconfig/gcc-=
10/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c90dc9745d947a4c915f53
        new failure (last pass: v4.19.265-cip85-36-gf1ffb3de9576)

    2023-01-19T09:30:31.655311  <8>[   21.095584] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 142246_1.5.2.4.1>
    2023-01-19T09:30:31.763969  / # #
    2023-01-19T09:30:31.866707  export SHELL=3D/bin/sh
    2023-01-19T09:30:31.867434  #
    2023-01-19T09:30:31.969788  / # export SHELL=3D/bin/sh. /lava-142246/en=
vironment
    2023-01-19T09:30:31.970509  =

    2023-01-19T09:30:32.072844  / # . /lava-142246/environment/lava-142246/=
bin/lava-test-runner /lava-142246/1
    2023-01-19T09:30:32.073763  =

    2023-01-19T09:30:32.078409  / # /lava-142246/bin/lava-test-runner /lava=
-142246/1
    2023-01-19T09:30:32.146042  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63c90fb068c4240484915ed8

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm/multi_v7_defconfig/gcc-=
10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm/multi_v7_defconfig/gcc-=
10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c90fb068c4240484915edb
        new failure (last pass: v4.19.265-cip85-36-gf1ffb3de9576)

    2023-01-19T09:38:38.143545  + set +x
    2023-01-19T09:38:38.145580  <8>[    9.870263] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 828965_1.5.2.4.1>
    2023-01-19T09:38:38.254362  / # #
    2023-01-19T09:38:38.356355  export SHELL=3D/bin/sh
    2023-01-19T09:38:38.356813  #
    2023-01-19T09:38:38.458265  / # export SHELL=3D/bin/sh. /lava-828965/en=
vironment
    2023-01-19T09:38:38.458730  =

    2023-01-19T09:38:38.560185  / # . /lava-828965/environment/lava-828965/=
bin/lava-test-runner /lava-828965/1
    2023-01-19T09:38:38.560939  =

    2023-01-19T09:38:38.562447  / # /lava-828965/bin/lava-test-runner /lava=
-828965/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63c90a9c66f083c32c915f2e

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm/omap2plus_defconfig/gcc=
-10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm/omap2plus_defconfig/gcc=
-10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c90a9c66f083c32c915f31
        new failure (last pass: v4.19.265-cip85-36-gf1ffb3de9576)

    2023-01-19T09:17:00.050499  + set +x
    2023-01-19T09:17:00.052467  <8>[   11.675042] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 828919_1.5.2.4.1>
    2023-01-19T09:17:00.163881  / # #
    2023-01-19T09:17:00.265790  export SHELL=3D/bin/sh
    2023-01-19T09:17:00.266268  #
    2023-01-19T09:17:00.367702  / # export SHELL=3D/bin/sh. /lava-828919/en=
vironment
    2023-01-19T09:17:00.368182  =

    2023-01-19T09:17:00.469598  / # . /lava-828919/environment/lava-828919/=
bin/lava-test-runner /lava-828919/1
    2023-01-19T09:17:00.470474  =

    2023-01-19T09:17:00.472584  / # /lava-828919/bin/lava-test-runner /lava=
-828919/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
dove-cubox                   | arm    | lab-pengutronix | gcc-10   | mvebu_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63c912c8493ea0b688915ede

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: mvebu_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm/mvebu_v7_defconfig/gcc-=
10/lab-pengutronix/baseline-dove-cubox.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm/mvebu_v7_defconfig/gcc-=
10/lab-pengutronix/baseline-dove-cubox.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c912c8493ea0b688915ee3
        new failure (last pass: v4.19.265-cip85-36-gf1ffb3de9576)

    2023-01-19T09:51:45.397963  + set +x
    2023-01-19T09:51:45.398171  [    4.230960] <LAVA_SIGNAL_ENDRUN 0_dmesg =
883041_1.5.2.3.1>
    2023-01-19T09:51:45.504675  / # #
    2023-01-19T09:51:45.606423  export SHELL=3D/bin/sh
    2023-01-19T09:51:45.606826  #
    2023-01-19T09:51:45.708026  / # export SHELL=3D/bin/sh. /lava-883041/en=
vironment
    2023-01-19T09:51:45.708459  =

    2023-01-19T09:51:45.809664  / # . /lava-883041/environment/lava-883041/=
bin/lava-test-runner /lava-883041/1
    2023-01-19T09:51:45.810596  =

    2023-01-19T09:51:45.812751  / # /lava-883041/bin/lava-test-runner /lava=
-883041/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63c90db5745d947a4c915f0c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm/multi_v7_defconfig/gcc-=
10/lab-collabora/baseline-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm/multi_v7_defconfig/gcc-=
10/lab-collabora/baseline-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c90db5745d947a4c915f11
        new failure (last pass: v4.19.265-cip85-36-gf1ffb3de9576)

    2023-01-19T09:30:14.391032  / # #
    2023-01-19T09:30:14.493982  export SHELL=3D/bin/sh
    2023-01-19T09:30:14.494865  #
    2023-01-19T09:30:14.597116  / # export SHELL=3D/bin/sh. /lava-8794305/e=
nvironment
    2023-01-19T09:30:14.598004  =

    2023-01-19T09:30:14.700164  / # . /lava-8794305/environment/lava-879430=
5/bin/lava-test-runner /lava-8794305/1
    2023-01-19T09:30:14.701587  =

    2023-01-19T09:30:14.711430  / # /lava-8794305/bin/lava-test-runner /lav=
a-8794305/1
    2023-01-19T09:30:14.820119  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-19T09:30:14.820706  + cd /lava-8794305/1/tests/1_bootrr =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63c90c9d5df3ba694f915f9e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm/imx_v6_v7_defconfig/gcc=
-10/lab-pengutronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm/imx_v6_v7_defconfig/gcc=
-10/lab-pengutronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c90c9e5df3ba694f915fa3
        new failure (last pass: v4.19.265-cip85-36-gf1ffb3de9576)

    2023-01-19T09:25:41.358321  + set +x[    7.195112] <LAVA_SIGNAL_ENDRUN =
0_dmesg 883045_1.5.2.3.1>
    2023-01-19T09:25:41.358484  =

    2023-01-19T09:25:41.465312  / # #
    2023-01-19T09:25:41.567107  export SHELL=3D/bin/sh
    2023-01-19T09:25:41.567543  #
    2023-01-19T09:25:41.668605  / # export SHELL=3D/bin/sh. /lava-883045/en=
vironment
    2023-01-19T09:25:41.669055  =

    2023-01-19T09:25:41.770212  / # . /lava-883045/environment/lava-883045/=
bin/lava-test-runner /lava-883045/1
    2023-01-19T09:25:41.770835  =

    2023-01-19T09:25:41.773819  / # /lava-883045/bin/lava-test-runner /lava=
-883045/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63c90fd0cbbcb5a2f3915edb

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm/multi_v7_defconfig/gcc-=
10/lab-pengutronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm/multi_v7_defconfig/gcc-=
10/lab-pengutronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c90fd0cbbcb5a2f3915ee0
        new failure (last pass: v4.19.265-cip85-36-gf1ffb3de9576)

    2023-01-19T09:39:20.152517  + set +x
    2023-01-19T09:39:20.152694  [    4.969329] <LAVA_SIGNAL_ENDRUN 0_dmesg =
883061_1.5.2.3.1>
    2023-01-19T09:39:20.259431  / # #
    2023-01-19T09:39:20.361172  export SHELL=3D/bin/sh
    2023-01-19T09:39:20.361800  #
    2023-01-19T09:39:20.463144  / # export SHELL=3D/bin/sh. /lava-883061/en=
vironment
    2023-01-19T09:39:20.463677  =

    2023-01-19T09:39:20.565008  / # . /lava-883061/environment/lava-883061/=
bin/lava-test-runner /lava-883061/1
    2023-01-19T09:39:20.565782  =

    2023-01-19T09:39:20.568143  / # /lava-883061/bin/lava-test-runner /lava=
-883061/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6sx-sdb                   | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63c91180d18052acc1915ebe

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm/multi_v7_defconfig/gcc-=
10/lab-nxp/baseline-imx6sx-sdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm/multi_v7_defconfig/gcc-=
10/lab-nxp/baseline-imx6sx-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c91180d18052acc1915ec1
        new failure (last pass: v4.19.264-cip84-50-g1e56b70eaf66)

    2023-01-19T09:45:59.630174  <8>[   18.398504] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1140766_1.5.2.4.1>
    2023-01-19T09:45:59.735735  / # #
    2023-01-19T09:46:00.896052  export SHELL=3D/bin/sh
    2023-01-19T09:46:00.901751  #
    2023-01-19T09:46:02.449533  / # export SHELL=3D/bin/sh. /lava-1140766/e=
nvironment
    2023-01-19T09:46:02.455205  =

    2023-01-19T09:46:05.277569  / # . /lava-1140766/environment/lava-114076=
6/bin/lava-test-runner /lava-1140766/1
    2023-01-19T09:46:05.283613  =

    2023-01-19T09:46:05.294935  / # /lava-1140766/bin/lava-test-runner /lav=
a-1140766/1
    2023-01-19T09:46:05.342992  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (16 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
meson-gxbb-p200              | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c90d38c75f9c22d4915ed0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm64/defconfig/gcc-10/lab-=
baylibre/baseline-meson-gxbb-p200.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm64/defconfig/gcc-10/lab-=
baylibre/baseline-meson-gxbb-p200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c90d38c75f9c22d4915ed5
        new failure (last pass: v4.19.259-cip82-57-ge54228ee5a88d)

    2023-01-19T09:28:11.582315  + set +<8>[   16.220168] <LAVA_SIGNAL_ENDRU=
N 0_dmesg 3168552_1.5.2.4.1>
    2023-01-19T09:28:11.583408  x
    2023-01-19T09:28:11.702566  / # #
    2023-01-19T09:28:11.808154  export SHELL=3D/bin/sh
    2023-01-19T09:28:11.809646  #
    2023-01-19T09:28:11.912990  / # export SHELL=3D/bin/sh. /lava-3168552/e=
nvironment
    2023-01-19T09:28:11.914499  =

    2023-01-19T09:28:12.017941  / # . /lava-3168552/environment/lava-316855=
2/bin/lava-test-runner /lava-3168552/1
    2023-01-19T09:28:12.020632  =

    2023-01-19T09:28:12.028680  / # /lava-3168552/bin/lava-test-runner /lav=
a-3168552/1 =

    ... (19 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
meson-gxl-s905d-p230         | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c90da81127ced854915f44

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm64/defconfig/gcc-10/lab-=
baylibre/baseline-meson-gxl-s905d-p230.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm64/defconfig/gcc-10/lab-=
baylibre/baseline-meson-gxl-s905d-p230.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c90da81127ced854915f49
        new failure (last pass: v4.19.264-cip84-50-g1e56b70eaf66)

    2023-01-19T09:29:56.088250  + set +x<8>[   16.214315] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3168534_1.5.2.4.1>
    2023-01-19T09:29:56.088693  =

    2023-01-19T09:29:56.195320  / # #
    2023-01-19T09:29:56.296835  export SHELL=3D/bin/sh
    2023-01-19T09:29:56.297214  #
    2023-01-19T09:29:56.398297  / # export SHELL=3D/bin/sh. /lava-3168534/e=
nvironment
    2023-01-19T09:29:56.398827  =

    2023-01-19T09:29:56.500339  / # . /lava-3168534/environment/lava-316853=
4/bin/lava-test-runner /lava-3168534/1
    2023-01-19T09:29:56.501032  =

    2023-01-19T09:29:56.504710  / # /lava-3168534/bin/lava-test-runner /lav=
a-3168534/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c912a938d12b78d5915ed0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm64/defconfig/gcc-10/lab-=
baylibre/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm64/defconfig/gcc-10/lab-=
baylibre/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c912a938d12b78d5915=
ed1
        failing since 245 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-broonie     | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63c911c3225fd9e09a915ec9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c911c3225fd9e09a915=
eca
        failing since 245 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c9145800bb6dd95b915ecc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm64/defconfig/gcc-10/lab-=
broonie/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm64/defconfig/gcc-10/lab-=
broonie/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c9145800bb6dd95b915=
ecd
        failing since 245 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63c90c294f5ac4e887915ef7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c90c294f5ac4e887915=
ef8
        failing since 245 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c912a5493ea0b688915ebb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm64/defconfig/gcc-10/lab-=
baylibre/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm64/defconfig/gcc-10/lab-=
baylibre/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c912a5493ea0b688915=
ebc
        failing since 245 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-broonie     | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63c911d860821071a5915eb9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c911d860821071a5915=
eba
        failing since 245 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c9132c8ebdef78a9915ec7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm64/defconfig/gcc-10/lab-=
broonie/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm64/defconfig/gcc-10/lab-=
broonie/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c9132c8ebdef78a9915=
ec8
        failing since 245 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63c90c2b4f5ac4e887915f2c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c90c2b4f5ac4e887915=
f2d
        failing since 245 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c90cb358eff3bd10915ed2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm64/defconfig/gcc-10/lab-=
collabora/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm64/defconfig/gcc-10/lab-=
collabora/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c90cb358eff3bd10915=
ed3
        failing since 245 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-baylibre    | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63c911571ff727be3e915ec9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c911571ff727be3e915=
eca
        failing since 245 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-broonie     | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63c911879d81f04385915ebb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c911879d81f04385915=
ebc
        failing since 245 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c9134033a24e03bd915f25

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm64/defconfig/gcc-10/lab-=
broonie/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm64/defconfig/gcc-10/lab-=
broonie/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c9134033a24e03bd915=
f26
        failing since 245 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63c90c284f5ac4e887915ee6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c90c284f5ac4e887915=
ee7
        failing since 245 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-baylibre    | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63c91159a8dab1e961915ec0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c91159a8dab1e961915=
ec1
        failing since 245 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-broonie     | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63c912f0ab765aed42915eb9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c912f0ab765aed42915=
eba
        failing since 245 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63c909e489996e8a0e915f60

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm/shmobile_defconfig/gcc-=
10/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm/shmobile_defconfig/gcc-=
10/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c909e489996e8a0e915=
f61
        failing since 56 days (last pass: v4.19.261-cip83-311-g41979a0fec1a=
, first fail: v4.19.265-cip85-36-gf1ffb3de9576) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 5          =


  Details:     https://kernelci.org/test/plan/id/63c90d9e1127ced854915ee0

  Results:     79 PASS, 9 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/case/id=
/63c90d9e1127ced854915f02
        failing since 311 days (last pass: v4.19.229-cip67-111-g5c3c0b39cf3=
b, first fail: v4.19.231-cip68-123-g92e3e7f3d4df)

    2023-01-19T09:29:54.552031  =

    2023-01-19T09:29:55.564715  /lava-8793943/1/../bin/lava-test-case
    2023-01-19T09:29:55.573332  <8>[   36.103132] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =


  * baseline.bootrr.rk3399-gru-sound-driver-rt5514-present: https://kernelc=
i.org/test/case/id/63c90d9e1127ced854915f17
        new failure (last pass: v4.19.265-cip85-36-gf1ffb3de9576)

    2023-01-19T09:29:54.083439  BusyB<8>[   34.609002] <LAVA_SIGNAL_TESTCAS=
E TEST_CASE_ID=3Drk3399-gru-sound-driver-max98357A-present RESULT=3Dfail>
    2023-01-19T09:29:54.088846  ox v1.31.1 (2023-01-15 00:20:44 UTC) multi-=
call binary.
    2023-01-19T09:29:54.089109  =

    2023-01-19T09:29:54.093413  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST
    2023-01-19T09:29:54.093846  =

    2023-01-19T09:29:54.098714  Print numbers from FIRST to LAST, in steps =
of INC.
    2023-01-19T09:29:54.101368  FIRST, INC default to 1.
    2023-01-19T09:29:54.101449  =

    2023-01-19T09:29:54.111989  	-w	Pa<8>[   34.636949] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Drk3399-gru-sound-driver-rt5514-present RESULT=3Dfail>   =


  * baseline.bootrr.rk3399-gru-sound-driver-max98357A-present: https://kern=
elci.org/test/case/id/63c90d9e1127ced854915f18
        new failure (last pass: v4.19.265-cip85-36-gf1ffb3de9576)

    2023-01-19T09:29:54.062345   INC default to 1.
    2023-01-19T09:29:54.062606  =

    2023-01-19T09:29:54.062678  =

    2023-01-19T09:29:54.066375  	-w	Pad to last with leading zeros
    2023-01-19T09:29:54.069212  	-s SEP	String separator
    2023-01-19T09:29:54.072495  /lava-8793943/1/../bin/lava-test-case
    2023-01-19T09:29:54.072759     =


  * baseline.bootrr.rk3399-gru-sound-driver-dp-present: https://kernelci.or=
g/test/case/id/63c90d9e1127ced854915f19
        new failure (last pass: v4.19.265-cip85-36-gf1ffb3de9576)

    2023-01-19T09:29:54.039958   multi-call binary.
    2023-01-19T09:29:54.040040  =

    2023-01-19T09:29:54.040317  =

    2023-01-19T09:29:54.045205  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST
    2023-01-19T09:29:54.045552  =

    2023-01-19T09:29:54.049703  Print numbers from FIRST to LAST, in steps =
of INC.
    2023-01-19T09:29:54.060458  FIRST,<8>[   34.586284] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Drk3399-gru-sound-driver-dp-present RESULT=3Dfail>   =


  * baseline.bootrr.rk3399-gru-sound-driver-da7219-present: https://kernelc=
i.org/test/case/id/63c90d9e1127ced854915f1a
        new failure (last pass: v4.19.265-cip85-36-gf1ffb3de9576)

    2023-01-19T09:29:54.038509  BusyBox v1.31.1 (2023-01-15 00:20:44 UTC)<8=
>[   34.565861] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Drk3399-gru-sound-drive=
r-da7219-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c90c264f5ac4e887915ed0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm64/defconfig/gcc-10/lab-=
broonie/baseline-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm64/defconfig/gcc-10/lab-=
broonie/baseline-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c90c264f5ac4e887915ed5
        new failure (last pass: v4.19.265-cip85-36-gf1ffb3de9576)

    2023-01-19T09:23:32.311177  <8>[   15.984285] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 142060_1.5.2.4.1>
    2023-01-19T09:23:32.418924  / # #
    2023-01-19T09:23:32.521664  export SHELL=3D/bin/sh
    2023-01-19T09:23:32.522131  #
    2023-01-19T09:23:32.623872  / # export SHELL=3D/bin/sh. /lava-142060/en=
vironment
    2023-01-19T09:23:32.624636  =

    2023-01-19T09:23:32.726462  / # . /lava-142060/environment/lava-142060/=
bin/lava-test-runner /lava-142060/1
    2023-01-19T09:23:32.728111  =

    2023-01-19T09:23:32.730921  / # /lava-142060/bin/lava-test-runner /lava=
-142060/1
    2023-01-19T09:23:32.763196  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c90bc6c0ff8e08e0915eba

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm64/defconfig/gcc-10/lab-=
baylibre/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm64/defconfig/gcc-10/lab-=
baylibre/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c90bc7c0ff8e08e0915ebf
        new failure (last pass: v4.19.251-cip77-82-g10c370b53152)

    2023-01-19T09:21:44.785260  / # #
    2023-01-19T09:21:44.886986  export SHELL=3D/bin/sh
    2023-01-19T09:21:44.887360  #
    2023-01-19T09:21:44.988744  / # export SHELL=3D/bin/sh. /lava-3168540/e=
nvironment
    2023-01-19T09:21:44.989103  =

    2023-01-19T09:21:45.090493  / # . /lava-3168540/environment/lava-316854=
0/bin/lava-test-runner /lava-3168540/1
    2023-01-19T09:21:45.091279  =

    2023-01-19T09:21:45.096482  / # /lava-3168540/bin/lava-test-runner /lav=
a-3168540/1
    2023-01-19T09:21:45.166372  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-19T09:21:45.166903  + cd /lava-3168540<8>[   15.626135] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 3168540_1.5.2.4.5> =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c90bc74ae22db0b5915ed9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm64/defconfig/gcc-10/lab-=
collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm64/defconfig/gcc-10/lab-=
collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c90bc74ae22db0b5915ede
        new failure (last pass: v4.19.251-cip77-82-g10c370b53152)

    2023-01-19T09:22:05.271306  / # #
    2023-01-19T09:22:05.373542  export SHELL=3D/bin/sh
    2023-01-19T09:22:05.374177  #
    2023-01-19T09:22:05.475704  / # export SHELL=3D/bin/sh. /lava-8794041/e=
nvironment
    2023-01-19T09:22:05.476346  =

    2023-01-19T09:22:05.577826  / # . /lava-8794041/environment/lava-879404=
1/bin/lava-test-runner /lava-8794041/1
    2023-01-19T09:22:05.578802  =

    2023-01-19T09:22:05.593725  / # /lava-8794041/bin/lava-test-runner /lav=
a-8794041/1
    2023-01-19T09:22:05.637328  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-19T09:22:05.652674  + cd /lava-8794041<8>[   15.647476] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 8794041_1.5.2.4.5> =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun8i-h2-plus...ch-all-h3-cc | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63c90f9768c4240484915ebf

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm/multi_v7_defconfig/gcc-=
10/lab-baylibre/baseline-sun8i-h2-plus-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm/multi_v7_defconfig/gcc-=
10/lab-baylibre/baseline-sun8i-h2-plus-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c90f9768c4240484915ec4
        new failure (last pass: v4.19.264-cip84-50-g1e56b70eaf66)

    2023-01-19T09:38:07.391051  / # #
    2023-01-19T09:38:07.492744  export SHELL=3D/bin/sh
    2023-01-19T09:38:07.493088  #
    2023-01-19T09:38:07.594409  / # export SHELL=3D/bin/sh. /lava-3168744/e=
nvironment
    2023-01-19T09:38:07.594756  =

    2023-01-19T09:38:07.696084  / # . /lava-3168744/environment/lava-316874=
4/bin/lava-test-runner /lava-3168744/1
    2023-01-19T09:38:07.696685  =

    2023-01-19T09:38:07.702359  / # /lava-3168744/bin/lava-test-runner /lav=
a-3168744/1
    2023-01-19T09:38:07.799183  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-19T09:38:07.799660  + cd /lava-3168744/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun8i-h2-plus...ch-all-h3-cc | arm    | lab-baylibre    | gcc-10   | sunxi_=
defconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/63c909e17a20ad195f915f71

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: sunxi_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm/sunxi_defconfig/gcc-10/=
lab-baylibre/baseline-sun8i-h2-plus-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm/sunxi_defconfig/gcc-10/=
lab-baylibre/baseline-sun8i-h2-plus-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c909e17a20ad195f915f76
        new failure (last pass: v4.19.264-cip84-50-g1e56b70eaf66)

    2023-01-19T09:13:55.794050  + set +x
    2023-01-19T09:13:55.796006  <8>[    7.839809] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3168386_1.5.2.4.1>
    2023-01-19T09:13:55.901148  / # #
    2023-01-19T09:13:56.002889  export SHELL=3D/bin/sh
    2023-01-19T09:13:56.003340  #
    2023-01-19T09:13:56.104680  / # export SHELL=3D/bin/sh. /lava-3168386/e=
nvironment
    2023-01-19T09:13:56.105111  =

    2023-01-19T09:13:56.206481  / # . /lava-3168386/environment/lava-316838=
6/bin/lava-test-runner /lava-3168386/1
    2023-01-19T09:13:56.207175  =

    2023-01-19T09:13:56.211188  / # /lava-3168386/bin/lava-test-runner /lav=
a-3168386/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63c90ee7a1c0d88dad915f63

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm/multi_v7_defconfig/gcc-=
10/lab-baylibre/baseline-sun8i-h3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm/multi_v7_defconfig/gcc-=
10/lab-baylibre/baseline-sun8i-h3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c90ee7a1c0d88dad915f68
        new failure (last pass: v4.19.259-cip82-57-ge54228ee5a88d)

    2023-01-19T09:35:06.470435  / # #
    2023-01-19T09:35:06.572213  export SHELL=3D/bin/sh
    2023-01-19T09:35:06.572612  #
    2023-01-19T09:35:06.674018  / # export SHELL=3D/bin/sh. /lava-3168745/e=
nvironment
    2023-01-19T09:35:06.674379  =

    2023-01-19T09:35:06.775730  / # . /lava-3168745/environment/lava-316874=
5/bin/lava-test-runner /lava-3168745/1
    2023-01-19T09:35:06.776359  =

    2023-01-19T09:35:06.781826  / # /lava-3168745/bin/lava-test-runner /lav=
a-3168745/1
    2023-01-19T09:35:06.829828  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-19T09:35:06.869531  + cd /lava-3168745/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre    | gcc-10   | sunxi_=
defconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/63c909932477d7e5a2915ebb

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: sunxi_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm/sunxi_defconfig/gcc-10/=
lab-baylibre/baseline-sun8i-h3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm/sunxi_defconfig/gcc-10/=
lab-baylibre/baseline-sun8i-h3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c909932477d7e5a2915ec0
        new failure (last pass: v4.19.259-cip82-57-ge54228ee5a88d)

    2023-01-19T09:12:34.850863  <8>[    8.168648] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3168385_1.5.2.4.1>
    2023-01-19T09:12:34.956065  / # #
    2023-01-19T09:12:35.057820  export SHELL=3D/bin/sh
    2023-01-19T09:12:35.058334  #
    2023-01-19T09:12:35.159701  / # export SHELL=3D/bin/sh. /lava-3168385/e=
nvironment
    2023-01-19T09:12:35.160212  =

    2023-01-19T09:12:35.261597  / # . /lava-3168385/environment/lava-316838=
5/bin/lava-test-runner /lava-3168385/1
    2023-01-19T09:12:35.262267  =

    2023-01-19T09:12:35.281633  / # /lava-3168385/bin/lava-test-runner /lav=
a-3168385/1
    2023-01-19T09:12:35.345429  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63c90b28dfc93296c0915f8f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c90b28dfc93296c0915f92
        new failure (last pass: v4.19.265-cip85-36-gf1ffb3de9576)

    2023-01-19T09:19:14.874924  + set +x
    2023-01-19T09:19:14.876046  <8>[    3.740119] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 828926_1.5.2.4.1>
    2023-01-19T09:19:14.978815  / # #
    2023-01-19T09:19:15.080278  export SHELL=3D/bin/sh
    2023-01-19T09:19:15.080514  #
    2023-01-19T09:19:15.181495  / # export SHELL=3D/bin/sh. /lava-828926/en=
vironment
    2023-01-19T09:19:15.181716  =

    2023-01-19T09:19:15.282694  / # . /lava-828926/environment/lava-828926/=
bin/lava-test-runner /lava-828926/1
    2023-01-19T09:19:15.283066  =

    2023-01-19T09:19:15.285871  / # /lava-828926/bin/lava-test-runner /lava=
-828926/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c90ce0d09958f068915f5f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm64/defconfig/gcc-10/lab-=
cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm64/defconfig/gcc-10/lab-=
cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c90ce0d09958f068915f62
        new failure (last pass: v4.19.265-cip85-36-gf1ffb3de9576)

    2023-01-19T09:26:35.276665  + set +x
    2023-01-19T09:26:35.277802  <8>[    3.747745] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 828943_1.5.2.4.1>
    2023-01-19T09:26:35.384100  / # #
    2023-01-19T09:26:35.486014  export SHELL=3D/bin/sh
    2023-01-19T09:26:35.486670  #
    2023-01-19T09:26:35.588390  / # export SHELL=3D/bin/sh. /lava-828943/en=
vironment
    2023-01-19T09:26:35.589003  =

    2023-01-19T09:26:35.690455  / # . /lava-828943/environment/lava-828943/=
bin/lava-test-runner /lava-828943/1
    2023-01-19T09:26:35.691239  =

    2023-01-19T09:26:35.693616  / # /lava-828943/bin/lava-test-runner /lava=
-828943/1 =

    ... (13 line(s) more)  =

 =20

