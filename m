Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80D3C25B4E
	for <webhook@archiver.kernel.org>; Tue, 24 Jan 2023 13:06:29 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web11.14259.1674565581838098615
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 24 Jan 2023 05:06:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=2mg6BWsr;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.174, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f174.google.com with SMTP id p24so14623281plw.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 24 Jan 2023 05:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G78IUiN/bpkKTX8p3BPG6Bvfq/L/QhobOKpfMOQ+4IQ=;
        b=2mg6BWsrT6+T5noyobdAfdgX7exuk+IypNmYXte9eadbirKKsxnstkwxG+vTXsPyX/
         QF9pLRKYgLpvH38y+V80Y4DyAR63VJ/vWtc718xdNNYUJOqUiZ84vj5eTcCoZDJcZ6EY
         65qNHtX9MoU2pOmtfoaifnATsA9XRHD/MnjR0m5hPCgng6+RThXbKzwCiTAAjUXkdpl/
         aolw3WKngLJe28KLSJvOMXeU2IWnKEO0YM6KgkUm4h75Oqnj6J2t0KVOR1VhjtzELIUS
         Rbyq0XMwkEx4+KTHSDBEva59r1B5UysCFBUQZXIM9/VvGvQoVJ+2ol0rYpaKZihVv1zE
         RGJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G78IUiN/bpkKTX8p3BPG6Bvfq/L/QhobOKpfMOQ+4IQ=;
        b=SWdjkYu6w7dnqKklI03B7v8lCcEcjpvs5zBCiiAouyb3Sz/tab8GsdO8XCBiJVmZst
         ZpuI4wF26kO+3NnyDP0WjXNg1pwBmkLjKekxACqhSemo5MpAPaKyksCFTRPMqFchAV5w
         1X262rRBI+kQ0ksoVZnAMTz03bIfmxA31abciaj5Dc/j+4V9QFguSZi6XFlwOFTGLbrI
         4mDkHycH5TbchxfN+FU9xiC+4kK6VXbDmFwRndHpFIshRz9QnBe69L2NSuxmaEpCfEiM
         +RogiM6+Bg0cKyfovBN9jrdJbX1PD7Jhje83lGdslUqVjztfR3q8s6HYqtqdx4+FwXMS
         ooSA==
X-Gm-Message-State: AO0yUKWcHRjZ/cMW4m8PypqVLEcGY4gOcyhN2phABYXCfRt5LB6gRc5n
	e4p8iAmIhnaXq9Bravn9v2Kw0S/6HG8NCq2ttWI=
X-Google-Smtp-Source: AK7set/wtc3RSwTONpqjEkRwYidtlDCDqMg9uMg9wi8Pqzp1mHh4+FmgZj2a7kBl4qDaLsJBzI37Yw==
X-Received: by 2002:a17:902:d490:b0:196:fdc:4b20 with SMTP id c16-20020a170902d49000b001960fdc4b20mr3853055plg.52.1674565579659;
        Tue, 24 Jan 2023 05:06:19 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h15-20020a170902f7cf00b00189c536c72asm1611863plw.148.2023.01.24.05.06.19
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 05:06:19 -0800 (PST)
Message-ID: <63cfd7cb.170a0220.41910.29d2@mx.google.com>
Date: Tue, 24 Jan 2023 05:06:19 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Kernel: v4.19.270-cip89-39-g43ce130174aa
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 112 runs,
 40 regressions (v4.19.270-cip89-39-g43ce130174aa)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 24 Jan 2023 13:06:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10465

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 112 runs, 40 regressio=
ns (v4.19.270-cip89-39-g43ce130174aa)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora   | gcc-10   | x86_64=
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

cubietruck                   | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =

dove-cubox                   | arm    | lab-pengutronix | gcc-10   | mvebu_=
v7_defconfig           | 1          =

imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =

meson-gxbb-p200              | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-baylibre    | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-baylibre    | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-baylibre    | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-baylibre    | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 5          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
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
Flinux-4.19.y-cip-rc/kernel/v4.19.270-cip89-39-g43ce130174aa/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.270-cip89-39-g43ce130174aa
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      43ce130174aa6b725d4f63d43ad3736296ef2736 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63cfca869cbb5219f8915f74

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/baseline-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/baseline-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63cfca869cbb5219f8915f79
        failing since 5 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576, =
first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-01-24T12:09:21.139180  + set<8>[   11.243813] <LAVA_SIGNAL_ENDRUN =
0_dmesg 8853749_1.4.2.3.1>
    2023-01-24T12:09:21.139265   +x
    2023-01-24T12:09:21.241268  /#
    2023-01-24T12:09:21.342507   # #export SHELL=3D/bin/sh
    2023-01-24T12:09:21.342702  =

    2023-01-24T12:09:21.443637  / # export SHELL=3D/bin/sh. /lava-8853749/e=
nvironment
    2023-01-24T12:09:21.443881  =

    2023-01-24T12:09:21.544863  / # . /lava-8853749/environment/lava-885374=
9/bin/lava-test-runner /lava-8853749/1
    2023-01-24T12:09:21.545211  =

    2023-01-24T12:09:21.550588  / # /lava-8853749/bin/lava-test-runner /lav=
a-8853749/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63cfca1f35bbcbd2a6915eb9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/baseline-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/baseline-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63cfca1f35bbcbd2a6915ebe
        failing since 5 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576, =
first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-01-24T12:07:52.321661  + set +x
    2023-01-24T12:07:52.328701  <8>[   10.307500] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 8853709_1.4.2.3.1>
    2023-01-24T12:07:52.433077  / # #
    2023-01-24T12:07:52.534075  export SHELL=3D/bin/sh
    2023-01-24T12:07:52.534300  #
    2023-01-24T12:07:52.635188  / # export SHELL=3D/bin/sh. /lava-8853709/e=
nvironment
    2023-01-24T12:07:52.635404  =

    2023-01-24T12:07:52.736071  / # . /lava-8853709/environment/lava-885370=
9/bin/lava-test-runner /lava-8853709/1
    2023-01-24T12:07:52.736401  =

    2023-01-24T12:07:52.741023  / # /lava-8853709/bin/lava-test-runner /lav=
a-8853709/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beagle-xm                    | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63cfcb660322cd31b8915edd

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm/multi_v7_defconfig/gcc-10=
/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm/multi_v7_defconfig/gcc-10=
/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63cfcb660322cd31b8915ee2
        failing since 5 days (last pass: v4.19.259-cip82-57-ge54228ee5a88d,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-01-24T12:13:09.973798  <8>[   21.017333] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3198699_1.5.2.4.1>
    2023-01-24T12:13:10.082263  / # #
    2023-01-24T12:13:10.184134  export SHELL=3D/bin/sh
    2023-01-24T12:13:10.184592  #
    2023-01-24T12:13:10.285967  / # export SHELL=3D/bin/sh. /lava-3198699/e=
nvironment
    2023-01-24T12:13:10.286519  =

    2023-01-24T12:13:10.387886  / # . /lava-3198699/environment/lava-319869=
9/bin/lava-test-runner /lava-3198699/1
    2023-01-24T12:13:10.388592  =

    2023-01-24T12:13:10.393211  / # /lava-3198699/bin/lava-test-runner /lav=
a-3198699/1
    2023-01-24T12:13:10.489375  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beagle-xm                    | arm    | lab-baylibre    | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63cfc9211fbf46d71e915ebd

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm/omap2plus_defconfig/gcc-1=
0/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm/omap2plus_defconfig/gcc-1=
0/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63cfc9211fbf46d71e915ec2
        failing since 5 days (last pass: v4.19.252-cip78-146-g6acc38498265c=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-01-24T12:03:33.400532  + set +x<8>[   25.591308] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3198665_1.5.2.4.1>
    2023-01-24T12:03:33.401213  =

    2023-01-24T12:03:33.513287  / # #
    2023-01-24T12:03:33.616978  export SHELL=3D/bin/sh
    2023-01-24T12:03:33.618069  #
    2023-01-24T12:03:33.720474  / # export SHELL=3D/bin/sh. /lava-3198665/e=
nvironment
    2023-01-24T12:03:33.721576  =

    2023-01-24T12:03:33.823923  / # . /lava-3198665/environment/lava-319866=
5/bin/lava-test-runner /lava-3198665/1
    2023-01-24T12:03:33.825986  =

    2023-01-24T12:03:33.830664  / # /lava-3198665/bin/lava-test-runner /lav=
a-3198665/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63cfcbe1068be5b0fd915eba

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm/multi_v7_defconfig/gcc-10=
/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm/multi_v7_defconfig/gcc-10=
/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63cfcbe1068be5b0fd915ebf
        failing since 5 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576, =
first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-01-24T12:15:09.965273  <8>[   14.917573] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 165213_1.5.2.4.1>
    2023-01-24T12:15:10.074264  / # #
    2023-01-24T12:15:10.176320  export SHELL=3D/bin/sh
    2023-01-24T12:15:10.177102  #
    2023-01-24T12:15:10.279187  / # export SHELL=3D/bin/sh. /lava-165213/en=
vironment
    2023-01-24T12:15:10.279981  =

    2023-01-24T12:15:10.381995  / # . /lava-165213/environment/lava-165213/=
bin/lava-test-runner /lava-165213/1
    2023-01-24T12:15:10.383478  =

    2023-01-24T12:15:10.386026  / # /lava-165213/bin/lava-test-runner /lava=
-165213/1
    2023-01-24T12:15:10.454877  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63cfcbb9a5ef95a75d915ebf

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm/multi_v7_defconfig/gcc-10=
/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm/multi_v7_defconfig/gcc-10=
/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63cfcbb9a5ef95a75d915ec2
        failing since 5 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576, =
first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-01-24T12:14:29.940665  + set +x
    2023-01-24T12:14:29.942725  <8>[    9.839716] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 831946_1.5.2.4.1>
    2023-01-24T12:14:30.051402  / # #
    2023-01-24T12:14:30.153259  export SHELL=3D/bin/sh
    2023-01-24T12:14:30.153738  #
    2023-01-24T12:14:30.255101  / # export SHELL=3D/bin/sh. /lava-831946/en=
vironment
    2023-01-24T12:14:30.255552  =

    2023-01-24T12:14:30.356930  / # . /lava-831946/environment/lava-831946/=
bin/lava-test-runner /lava-831946/1
    2023-01-24T12:14:30.357661  =

    2023-01-24T12:14:30.359294  / # /lava-831946/bin/lava-test-runner /lava=
-831946/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63cfc97e1bee80f1b8915ec0

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm/omap2plus_defconfig/gcc-1=
0/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm/omap2plus_defconfig/gcc-1=
0/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63cfc97e1bee80f1b8915ec3
        failing since 5 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576, =
first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-01-24T12:05:02.333805  + set +x<8>[   11.790830] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 831918_1.5.2.4.1>
    2023-01-24T12:05:02.334311  =

    2023-01-24T12:05:02.447396  / # #
    2023-01-24T12:05:02.550278  export SHELL=3D/bin/sh
    2023-01-24T12:05:02.551042  #
    2023-01-24T12:05:02.652982  / # export SHELL=3D/bin/sh. /lava-831918/en=
vironment
    2023-01-24T12:05:02.653745  =

    2023-01-24T12:05:02.755698  / # . /lava-831918/environment/lava-831918/=
bin/lava-test-runner /lava-831918/1
    2023-01-24T12:05:02.756965  =

    2023-01-24T12:05:02.764965  / # /lava-831918/bin/lava-test-runner /lava=
-831918/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
cubietruck                   | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63cfcc2f3b79be2281915eda

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm/multi_v7_defconfig/gcc-10=
/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm/multi_v7_defconfig/gcc-10=
/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63cfcc2f3b79be2281915edf
        failing since 4 days (last pass: v4.19.264-cip84-50-g1e56b70eaf66, =
first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-01-24T12:16:27.747373  + set +x<8>[    7.219651] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3198689_1.5.2.4.1>
    2023-01-24T12:16:27.748062  =

    2023-01-24T12:16:27.856769  / # #
    2023-01-24T12:16:27.959037  export SHELL=3D/bin/sh
    2023-01-24T12:16:27.959476  #
    2023-01-24T12:16:28.060650  / # export SHELL=3D/bin/sh. /lava-3198689/e=
nvironment
    2023-01-24T12:16:28.061176  =

    2023-01-24T12:16:28.163108  / # . /lava-3198689/environment/lava-319868=
9/bin/lava-test-runner /lava-3198689/1
    2023-01-24T12:16:28.163853  =

    2023-01-24T12:16:28.170320  / # /lava-3198689/bin/lava-test-runner /lav=
a-3198689/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
dove-cubox                   | arm    | lab-pengutronix | gcc-10   | mvebu_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63cfcaa588794ce406915f1a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: mvebu_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm/mvebu_v7_defconfig/gcc-10=
/lab-pengutronix/baseline-dove-cubox.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm/mvebu_v7_defconfig/gcc-10=
/lab-pengutronix/baseline-dove-cubox.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63cfcaa588794ce406915f1f
        failing since 5 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576, =
first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-01-24T12:09:59.282775  + set +x
    2023-01-24T12:09:59.283074  [    4.231226] <LAVA_SIGNAL_ENDRUN 0_dmesg =
886107_1.5.2.3.1>
    2023-01-24T12:09:59.389070  / # #
    2023-01-24T12:09:59.490596  export SHELL=3D/bin/sh
    2023-01-24T12:09:59.491143  #
    2023-01-24T12:09:59.592376  / # export SHELL=3D/bin/sh. /lava-886107/en=
vironment
    2023-01-24T12:09:59.592749  =

    2023-01-24T12:09:59.693968  / # . /lava-886107/environment/lava-886107/=
bin/lava-test-runner /lava-886107/1
    2023-01-24T12:09:59.694578  =

    2023-01-24T12:09:59.696950  / # /lava-886107/bin/lava-test-runner /lava=
-886107/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63cfcb5abbbd8267b5915ecf

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm/multi_v7_defconfig/gcc-10=
/lab-collabora/baseline-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm/multi_v7_defconfig/gcc-10=
/lab-collabora/baseline-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63cfcb5abbbd8267b5915ed4
        failing since 5 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576, =
first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-01-24T12:12:56.715466  + set +x
    2023-01-24T12:12:56.716627  <8>[    7.691478] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 8853796_1.5.2.4.1>
    2023-01-24T12:12:56.824471  / # #
    2023-01-24T12:12:56.926446  export SHELL=3D/bin/sh
    2023-01-24T12:12:56.926965  #
    2023-01-24T12:12:57.028298  / # export SHELL=3D/bin/sh. /lava-8853796/e=
nvironment
    2023-01-24T12:12:57.028887  =

    2023-01-24T12:12:57.130248  / # . /lava-8853796/environment/lava-885379=
6/bin/lava-test-runner /lava-8853796/1
    2023-01-24T12:12:57.131073  =

    2023-01-24T12:12:57.132758  / # /lava-8853796/bin/lava-test-runner /lav=
a-8853796/1 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63cfc89d08354438dd915ecd

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm/imx_v6_v7_defconfig/gcc-1=
0/lab-pengutronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm/imx_v6_v7_defconfig/gcc-1=
0/lab-pengutronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63cfc89d08354438dd915ed2
        failing since 5 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576, =
first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-01-24T12:01:25.595316  + set +x
    2023-01-24T12:01:25.595471  [    7.131111] <LAVA_SIGNAL_ENDRUN 0_dmesg =
886104_1.5.2.3.1>
    2023-01-24T12:01:25.702892  / # #
    2023-01-24T12:01:25.804338  export SHELL=3D/bin/sh
    2023-01-24T12:01:25.804979  #
    2023-01-24T12:01:25.907148  / # export SHELL=3D/bin/sh. /lava-886104/en=
vironment
    2023-01-24T12:01:25.907581  =

    2023-01-24T12:01:26.008795  / # . /lava-886104/environment/lava-886104/=
bin/lava-test-runner /lava-886104/1
    2023-01-24T12:01:26.009419  =

    2023-01-24T12:01:26.012093  / # /lava-886104/bin/lava-test-runner /lava=
-886104/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63cfcb319a51f3e35e915eca

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm/multi_v7_defconfig/gcc-10=
/lab-pengutronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm/multi_v7_defconfig/gcc-10=
/lab-pengutronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63cfcb319a51f3e35e915ecf
        failing since 5 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576, =
first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-01-24T12:12:25.301561  + set +x
    2023-01-24T12:12:25.301720  [    4.863804] <LAVA_SIGNAL_ENDRUN 0_dmesg =
886109_1.5.2.3.1>
    2023-01-24T12:12:25.407490  / # #
    2023-01-24T12:12:25.509134  export SHELL=3D/bin/sh
    2023-01-24T12:12:25.509601  #
    2023-01-24T12:12:25.610806  / # export SHELL=3D/bin/sh. /lava-886109/en=
vironment
    2023-01-24T12:12:25.611276  =

    2023-01-24T12:12:25.712693  / # . /lava-886109/environment/lava-886109/=
bin/lava-test-runner /lava-886109/1
    2023-01-24T12:12:25.713364  =

    2023-01-24T12:12:25.715960  / # /lava-886109/bin/lava-test-runner /lava=
-886109/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63cfcb71a05438afbb915ec7

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm/multi_v7_defconfig/gcc-10=
/lab-nxp/baseline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm/multi_v7_defconfig/gcc-10=
/lab-nxp/baseline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63cfcb71a05438afbb915eca
        new failure (last pass: v4.19.265-cip85-36-gf1ffb3de9576)

    2023-01-24T12:13:20.113172  <8>[   12.957532] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1144367_1.5.2.4.1>
    2023-01-24T12:13:20.217891  / # #
    2023-01-24T12:13:21.376898  export SHELL=3D/bin/sh
    2023-01-24T12:13:21.382353  #
    2023-01-24T12:13:22.929175  / # export SHELL=3D/bin/sh. /lava-1144367/e=
nvironment
    2023-01-24T12:13:22.934877  =

    2023-01-24T12:13:25.757233  / # . /lava-1144367/environment/lava-114436=
7/bin/lava-test-runner /lava-1144367/1
    2023-01-24T12:13:25.763382  =

    2023-01-24T12:13:25.770210  / # /lava-1144367/bin/lava-test-runner /lav=
a-1144367/1
    2023-01-24T12:13:25.871134  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (16 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
meson-gxbb-p200              | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63cfcc25376217181b915eb9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm64/defconfig/gcc-10/lab-ba=
ylibre/baseline-meson-gxbb-p200.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm64/defconfig/gcc-10/lab-ba=
ylibre/baseline-meson-gxbb-p200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63cfcc25376217181b915ebe
        failing since 5 days (last pass: v4.19.259-cip82-57-ge54228ee5a88d,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-01-24T12:16:26.029622  + set +<8>[   16.177858] <LAVA_SIGNAL_ENDRU=
N 0_dmesg 3198717_1.5.2.4.1>
    2023-01-24T12:16:26.030620  x
    2023-01-24T12:16:26.149896  / # #
    2023-01-24T12:16:26.255467  export SHELL=3D/bin/sh
    2023-01-24T12:16:26.256972  #
    2023-01-24T12:16:26.360352  / # export SHELL=3D/bin/sh. /lava-3198717/e=
nvironment
    2023-01-24T12:16:26.361862  =

    2023-01-24T12:16:26.465275  / # . /lava-3198717/environment/lava-319871=
7/bin/lava-test-runner /lava-3198717/1
    2023-01-24T12:16:26.467990  =

    2023-01-24T12:16:26.475846  / # /lava-3198717/bin/lava-test-runner /lav=
a-3198717/1 =

    ... (19 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-baylibre    | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63cfcbe625f979bfc3915eff

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63cfcbe625f979bfc3915=
f00
        failing since 250 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63cfcd3a25a66cd251915ec6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm64/defconfig/gcc-10/lab-ba=
ylibre/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm64/defconfig/gcc-10/lab-ba=
ylibre/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63cfcd3a25a66cd251915=
ec7
        failing since 250 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63cfcbb0e83585062b915ec3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63cfcbb0e83585062b915=
ec4
        failing since 250 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-baylibre    | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63cfcbd4c0a3c14bbc915eca

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63cfcbd4c0a3c14bbc915=
ecb
        failing since 250 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63cfcd39b62e2dbb69915eba

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm64/defconfig/gcc-10/lab-ba=
ylibre/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm64/defconfig/gcc-10/lab-ba=
ylibre/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63cfcd39b62e2dbb69915=
ebb
        failing since 250 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63cfcbb3c0a3c14bbc915ebe

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63cfcbb3c0a3c14bbc915=
ebf
        failing since 250 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63cfccef899281459e915ebb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm64/defconfig/gcc-10/lab-co=
llabora/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm64/defconfig/gcc-10/lab-co=
llabora/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63cfccef899281459e915=
ebc
        failing since 250 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-baylibre    | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63cfcbd3d85923be3f915ec6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63cfcbd3d85923be3f915=
ec7
        failing since 250 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63cfcd3cef8d5c4fc9915ec1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm64/defconfig/gcc-10/lab-ba=
ylibre/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm64/defconfig/gcc-10/lab-ba=
ylibre/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63cfcd3cef8d5c4fc9915=
ec2
        failing since 250 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63cfcbb21c08e88c3f915ed5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63cfcbb21c08e88c3f915=
ed6
        failing since 250 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63cfccf00bd9d250f3915ec1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm64/defconfig/gcc-10/lab-co=
llabora/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm64/defconfig/gcc-10/lab-co=
llabora/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63cfccf00bd9d250f3915=
ec2
        failing since 250 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-baylibre    | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63cfcbd125f979bfc3915eda

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63cfcbd125f979bfc3915=
edb
        failing since 250 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63cfcd3b25a66cd251915ec9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm64/defconfig/gcc-10/lab-ba=
ylibre/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm64/defconfig/gcc-10/lab-ba=
ylibre/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63cfcd3b25a66cd251915=
eca
        failing since 250 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 5          =


  Details:     https://kernelci.org/test/plan/id/63cfcae864be6a9259915eef

  Results:     79 PASS, 9 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/case/id=
/63cfcae864be6a9259915f11
        failing since 316 days (last pass: v4.19.229-cip67-111-g5c3c0b39cf3=
b, first fail: v4.19.231-cip68-123-g92e3e7f3d4df)

    2023-01-24T12:11:05.186927  /lava-8853758/1/../bin/lava-test-case
    2023-01-24T12:11:05.187264  =

    2023-01-24T12:11:05.195381  <8>[   36.050555] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =


  * baseline.bootrr.rk3399-gru-sound-driver-rt5514-present: https://kernelc=
i.org/test/case/id/63cfcae864be6a9259915f26
        failing since 5 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576, =
first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-01-24T12:11:03.684416  =

    2023-01-24T12:11:03.687798  : seq [-w] [-s SEP] [FIRST [INC]] LAST
    2023-01-24T12:11:03.688245  =

    2023-01-24T12:11:03.688594  =

    2023-01-24T12:11:03.693132  Print numbers from FIRST to LAST, in steps =
of INC.
    2023-01-24T12:11:03.693402  =

    2023-01-24T12:11:03.695840  FIRST, INC default to 1.
    2023-01-24T12:11:03.696227  =

    2023-01-24T12:11:03.696305     =


  * baseline.bootrr.rk3399-gru-sound-driver-max98357A-present: https://kern=
elci.org/test/case/id/63cfcae864be6a9259915f27
        failing since 5 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576, =
first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-01-24T12:11:03.657095   INC default to 1.
    2023-01-24T12:11:03.657180  =

    2023-01-24T12:11:03.657426  =

    2023-01-24T12:11:03.660665  	-w	Pad to last with leading zeros
    2023-01-24T12:11:03.663091  	-s SEP	String separator
    2023-01-24T12:11:03.666862  /lava-8853758/1/../bin/lava-test-case
    2023-01-24T12:11:03.672731  BusyBox v1.31.1 (2023-01-20 17:48:38 UTC) m=
ulti-call binary.
    2023-01-24T12:11:03.672991  =

    2023-01-24T12:11:03.673244  =

    2023-01-24T12:11:03.683903  Usage<8>[   34.533294] <LAVA_SIGNAL_TESTCAS=
E TEST_CASE_ID=3Drk3399-gru-sound-driver-max98357A-present RESULT=3Dfail>   =


  * baseline.bootrr.rk3399-gru-sound-driver-dp-present: https://kernelci.or=
g/test/case/id/63cfcae864be6a9259915f28
        failing since 5 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576, =
first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-01-24T12:11:03.632941  BusyBox v1.31.1 (2023-01-20 17:48:38 UTC)<8=
>[   34.485928] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Drk3399-gru-sound-drive=
r-da7219-present RESULT=3Dfail>
    2023-01-24T12:11:03.634732   multi-call binary.
    2023-01-24T12:11:03.634808  =

    2023-01-24T12:11:03.639558  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST
    2023-01-24T12:11:03.639641  =

    2023-01-24T12:11:03.644340  Print numbers from FIRST to LAST, in steps =
of INC.
    2023-01-24T12:11:03.644805  =

    2023-01-24T12:11:03.655119  FIRST,<8>[   34.506715] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Drk3399-gru-sound-driver-dp-present RESULT=3Dfail>   =


  * baseline.bootrr.rk3399-gru-sound-driver-da7219-present: https://kernelc=
i.org/test/case/id/63cfcae864be6a9259915f29
        failing since 5 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576, =
first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-01-24T12:11:03.612141  <8>[   34.465406] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-present RESULT=3Dpass>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63cfcc59b566f66414915eff

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63cfcc59b566f66414915f04
        failing since 5 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576, =
first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-01-24T12:17:14.664612  <8>[   15.946605] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 165292_1.5.2.4.1>
    2023-01-24T12:17:14.770872  / # #
    2023-01-24T12:17:14.872908  export SHELL=3D/bin/sh
    2023-01-24T12:17:14.873440  #
    2023-01-24T12:17:14.975304  / # export SHELL=3D/bin/sh. /lava-165292/en=
vironment
    2023-01-24T12:17:14.975913  =

    2023-01-24T12:17:15.077815  / # . /lava-165292/environment/lava-165292/=
bin/lava-test-runner /lava-165292/1
    2023-01-24T12:17:15.078636  =

    2023-01-24T12:17:15.082437  / # /lava-165292/bin/lava-test-runner /lava=
-165292/1
    2023-01-24T12:17:15.114853  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63cfcbf49739e67689915ec5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm64/defconfig/gcc-10/lab-co=
llabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm64/defconfig/gcc-10/lab-co=
llabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63cfcbf49739e67689915eca
        failing since 5 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576, =
first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-01-24T12:15:35.379952  / # #
    2023-01-24T12:15:35.481688  export SHELL=3D/bin/sh
    2023-01-24T12:15:35.482100  #
    2023-01-24T12:15:35.583392  / # export SHELL=3D/bin/sh. /lava-8853821/e=
nvironment
    2023-01-24T12:15:35.583773  =

    2023-01-24T12:15:35.685106  / # . /lava-8853821/environment/lava-885382=
1/bin/lava-test-runner /lava-8853821/1
    2023-01-24T12:15:35.685711  =

    2023-01-24T12:15:35.689567  / # /lava-8853821/bin/lava-test-runner /lav=
a-8853821/1
    2023-01-24T12:15:35.760531  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-24T12:15:35.760769  + cd /lava-8853821<8>[   15.628191] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 8853821_1.5.2.4.5> =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun8i-h2-plus...ch-all-h3-cc | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63cfcb5b48502b61f8915ed4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm/multi_v7_defconfig/gcc-10=
/lab-baylibre/baseline-sun8i-h2-plus-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm/multi_v7_defconfig/gcc-10=
/lab-baylibre/baseline-sun8i-h2-plus-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63cfcb5b48502b61f8915ed9
        failing since 5 days (last pass: v4.19.264-cip84-50-g1e56b70eaf66, =
first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-01-24T12:12:48.938745  / # #
    2023-01-24T12:12:49.040514  export SHELL=3D/bin/sh
    2023-01-24T12:12:49.040912  #
    2023-01-24T12:12:49.142231  / # export SHELL=3D/bin/sh. /lava-3198691/e=
nvironment
    2023-01-24T12:12:49.142594  =

    2023-01-24T12:12:49.243965  / # . /lava-3198691/environment/lava-319869=
1/bin/lava-test-runner /lava-3198691/1
    2023-01-24T12:12:49.244593  =

    2023-01-24T12:12:49.251097  / # /lava-3198691/bin/lava-test-runner /lav=
a-3198691/1
    2023-01-24T12:12:49.299140  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-24T12:12:49.337910  + cd /lava-3198691/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun8i-h2-plus...ch-all-h3-cc | arm    | lab-baylibre    | gcc-10   | sunxi_=
defconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/63cfc76f3b61f21e26915ecc

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: sunxi_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm/sunxi_defconfig/gcc-10/la=
b-baylibre/baseline-sun8i-h2-plus-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm/sunxi_defconfig/gcc-10/la=
b-baylibre/baseline-sun8i-h2-plus-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63cfc76f3b61f21e26915ed1
        failing since 5 days (last pass: v4.19.264-cip84-50-g1e56b70eaf66, =
first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-01-24T11:56:09.321045  + set +x
    2023-01-24T11:56:09.323146  <8>[    7.835561] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3198599_1.5.2.4.1>
    2023-01-24T11:56:09.428780  / # #
    2023-01-24T11:56:09.530774  export SHELL=3D/bin/sh
    2023-01-24T11:56:09.531189  #
    2023-01-24T11:56:09.632618  / # export SHELL=3D/bin/sh. /lava-3198599/e=
nvironment
    2023-01-24T11:56:09.633054  =

    2023-01-24T11:56:09.734503  / # . /lava-3198599/environment/lava-319859=
9/bin/lava-test-runner /lava-3198599/1
    2023-01-24T11:56:09.735184  =

    2023-01-24T11:56:09.753659  / # /lava-3198599/bin/lava-test-runner /lav=
a-3198599/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63cfcb46db6826833e915f1e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm/multi_v7_defconfig/gcc-10=
/lab-baylibre/baseline-sun8i-h3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm/multi_v7_defconfig/gcc-10=
/lab-baylibre/baseline-sun8i-h3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63cfcb46db6826833e915f23
        failing since 5 days (last pass: v4.19.259-cip82-57-ge54228ee5a88d,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-01-24T12:12:37.905977  / # #
    2023-01-24T12:12:38.007908  export SHELL=3D/bin/sh
    2023-01-24T12:12:38.008340  #
    2023-01-24T12:12:38.109714  / # export SHELL=3D/bin/sh. /lava-3198690/e=
nvironment
    2023-01-24T12:12:38.110115  =

    2023-01-24T12:12:38.211602  / # . /lava-3198690/environment/lava-319869=
0/bin/lava-test-runner /lava-3198690/1
    2023-01-24T12:12:38.212425  =

    2023-01-24T12:12:38.217533  / # /lava-3198690/bin/lava-test-runner /lav=
a-3198690/1
    2023-01-24T12:12:38.329392  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-24T12:12:38.329688  + cd /lava-3198690/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre    | gcc-10   | sunxi_=
defconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/63cfc7703b61f21e26915ed7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: sunxi_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm/sunxi_defconfig/gcc-10/la=
b-baylibre/baseline-sun8i-h3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm/sunxi_defconfig/gcc-10/la=
b-baylibre/baseline-sun8i-h3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63cfc7703b61f21e26915edc
        failing since 5 days (last pass: v4.19.259-cip82-57-ge54228ee5a88d,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-01-24T11:56:06.603952  <8>[    7.873332] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3198602_1.5.2.4.1>
    2023-01-24T11:56:06.709705  / # #
    2023-01-24T11:56:06.811650  export SHELL=3D/bin/sh
    2023-01-24T11:56:06.812111  #
    2023-01-24T11:56:06.913562  / # export SHELL=3D/bin/sh. /lava-3198602/e=
nvironment
    2023-01-24T11:56:06.914041  =

    2023-01-24T11:56:07.015493  / # . /lava-3198602/environment/lava-319860=
2/bin/lava-test-runner /lava-3198602/1
    2023-01-24T11:56:07.016270  =

    2023-01-24T11:56:07.034642  / # /lava-3198602/bin/lava-test-runner /lav=
a-3198602/1
    2023-01-24T11:56:07.099535  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63cfcaa1a45bc246f0915ebe

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63cfcaa1a45bc246f0915ec1
        failing since 5 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576, =
first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-01-24T12:09:45.816168  + set +x
    2023-01-24T12:09:45.817305  <8>[    3.758076] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 831939_1.5.2.4.1>
    2023-01-24T12:09:45.923779  / # #
    2023-01-24T12:09:46.025671  export SHELL=3D/bin/sh
    2023-01-24T12:09:46.026122  #
    2023-01-24T12:09:46.127514  / # export SHELL=3D/bin/sh. /lava-831939/en=
vironment
    2023-01-24T12:09:46.127965  =

    2023-01-24T12:09:46.229402  / # . /lava-831939/environment/lava-831939/=
bin/lava-test-runner /lava-831939/1
    2023-01-24T12:09:46.230133  =

    2023-01-24T12:09:46.233168  / # /lava-831939/bin/lava-test-runner /lava=
-831939/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63cfcbe125f979bfc3915ee9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm64/defconfig/gcc-10/lab-ci=
p/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm64/defconfig/gcc-10/lab-ci=
p/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63cfcbe125f979bfc3915eec
        failing since 5 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576, =
first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-01-24T12:15:06.339951  <8>[    3.728513] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 831971_1.5.2.4.1>
    2023-01-24T12:15:06.444798  / # #
    2023-01-24T12:15:06.546580  export SHELL=3D/bin/sh
    2023-01-24T12:15:06.547069  #
    2023-01-24T12:15:06.648515  / # export SHELL=3D/bin/sh. /lava-831971/en=
vironment
    2023-01-24T12:15:06.649089  =

    2023-01-24T12:15:06.750503  / # . /lava-831971/environment/lava-831971/=
bin/lava-test-runner /lava-831971/1
    2023-01-24T12:15:06.751275  =

    2023-01-24T12:15:06.753971  / # /lava-831971/bin/lava-test-runner /lava=
-831971/1
    2023-01-24T12:15:06.790978  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =20

