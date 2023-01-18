Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76984C46467
	for <webhook@archiver.kernel.org>; Wed, 18 Jan 2023 21:55:36 +0000 (UTC)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
 by mx.groups.io with SMTP id smtpd.web11.30414.1674078933733744397
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 18 Jan 2023 13:55:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=2C0cMb6J;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.54, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f54.google.com with SMTP id n20-20020a17090aab9400b00229ca6a4636so3039196pjq.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 18 Jan 2023 13:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zwhyAwao7EztJgM9s7DxeXiS8YoKh1EZnrgMvzwbn/o=;
        b=2C0cMb6J1Yzr/A19d14nlB6hxI0irQc+mKPBa5Gt3Es4cdxGdBB9vSxgIDF64iXVDx
         rR7Ac6nJPe2cfbJSjcTFe0S+iyBuRwyU+RoXSMGKiwC1JW5xPdpig2eTtLPNkf9oNf1H
         QaY+Eiun7IF09no8jAfP+OZ/fQq04XcA58CuxCdLkjY7k7TtRJbo/bgRKrXdeS+u7qL5
         9snfoU5Odlhgg0Zt209fIbFbBAy2jVxDj5/Djp6Z+Ge/Je5NghH3/MADhp226coq4kFy
         854SakDAIl+funBwZr4G6doRituvHIGRXNSQS03y/Xbb3cXaIh0O1LHCkRdllduboLaB
         kWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zwhyAwao7EztJgM9s7DxeXiS8YoKh1EZnrgMvzwbn/o=;
        b=SFgmn0n5KTS8O6ViNeN1PxoKnGxsd2w9BeBAVjtX7GbBNKahXWx3p65FoQ8/q0kNMA
         Mkd25yCz47guPI3xLTN2wvLgb1XswEnsuSVzpc8k2jnhwyPwiWGCecpdRnuKFDZv/v5C
         Qcke7ZfmbOaZtZJeLULAl9gDqXFhq5y13hXXSVunL0Y7Wkxn0YxnBsf5u2KNoggR3esL
         iyzt0A13KWCvsQx6UhGyxDIpliVLhURaoqnijnBtF4HyfrkrVKbNTpaP5U6z2kaxuZ0y
         JCsZmxdX0ZZN3FqLZUi5PdIG2gmkFmoAHGwqsba38S0CfJieTc04j6GMQHOrw6Dd4KUW
         qFVw==
X-Gm-Message-State: AFqh2kpvAxcSjkt3B6rdsMEDEFSeG3I4VsNE0ixLZU5risuykeAMv6ns
	MGGqi/PO3VUD0lKGWJ0HoiWKpFQFX2c5b1AOm7R/YA==
X-Google-Smtp-Source: AMrXdXuIO4pZFsDdADCz4AqOoOR2d0sXRoC66FqzQpCk4IyvaHJ2YR49HpQdZYmFFUmm0LcaZlJlbQ==
X-Received: by 2002:a17:902:e845:b0:192:f45e:4197 with SMTP id t5-20020a170902e84500b00192f45e4197mr12113659plg.31.1674078931464;
        Wed, 18 Jan 2023 13:55:31 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e8-20020a17090301c800b0019498ee0cf4sm5910831plh.109.2023.01.18.13.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 13:55:31 -0800 (PST)
Message-ID: <63c86ad3.170a0220.eb336.9cc9@mx.google.com>
Date: Wed, 18 Jan 2023 13:55:31 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip-rt
X-Kernelci-Kernel: v4.19.269-cip88-rt28
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip-rt baseline: 183 runs,
 47 regressions (v4.19.269-cip88-rt28)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Jan 2023 21:55:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10409

cip/linux-4.19.y-cip-rt baseline: 183 runs, 47 regressions (v4.19.269-cip88=
-rt28)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora   | gcc-10   | defcon=
fig+x86-chromebook     | 1          =

asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...k+preempt_rt | 1          =

at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | defcon=
fig+preempt_rt         | 1          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | defcon=
fig                    | 1          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | defcon=
fig+preempt_rt         | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defc...g+preempt_rt | 1          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig           | 1          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defc...g+preempt_rt | 1          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =

imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | defcon=
fig+preempt_rt         | 1          =

imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =

imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defc...g+preempt_rt | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | defcon=
fig                    | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | defcon=
fig+preempt_rt         | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defc...g+preempt_rt | 1          =

imx6sx-sdb                   | arm    | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

imx6sx-sdb                   | arm    | lab-nxp         | gcc-10   | defcon=
fig+preempt_rt         | 1          =

imx6sx-sdb                   | arm    | lab-nxp         | gcc-10   | multi_=
v7_defc...g+preempt_rt | 1          =

imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | defcon=
fig+preempt_rt         | 1          =

imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =

imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | multi_=
v7_defc...g+preempt_rt | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

r8a7796-m3ulcb               | arm64  | lab-collabora   | gcc-10   | defcon=
fig+preempt_rt         | 1          =

r8a7796-m3ulcb               | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig+preempt_rt         | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-baylibre    | gcc-10   | defcon=
fig+preempt_rt         | 1          =

sun50i-h6-pine-h64           | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-10   | defcon=
fig+preempt_rt         | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

sun8i-h2-plus...ch-all-h3-cc | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =

sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =

zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig+preempt_rt         | 1          =

zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip-rt/ke=
rnel/v4.19.269-cip88-rt28/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.19.y-cip-rt
  Describe: v4.19.269-cip88-rt28
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      2b470889b91ffbff27aafaf122ef1ff24fa4e82c =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora   | gcc-10   | defcon=
fig+x86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/63c85c276a98f86ef7915ec0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c85c276a98f86ef7915ec5
        new failure (last pass: v4.19.265-cip85-rt27)

    2023-01-18T20:52:35.725359  + set +x
    2023-01-18T20:52:35.731993  <8>[    9.150585] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 8785128_1.4.2.3.1>
    2023-01-18T20:52:35.834353  =

    2023-01-18T20:52:35.935339  / # #export SHELL=3D/bin/sh
    2023-01-18T20:52:35.935526  =

    2023-01-18T20:52:36.036418  / # export SHELL=3D/bin/sh. /lava-8785128/e=
nvironment
    2023-01-18T20:52:36.036622  =

    2023-01-18T20:52:36.137551  / # . /lava-8785128/environment/lava-878512=
8/bin/lava-test-runner /lava-8785128/1
    2023-01-18T20:52:36.137819  =

    2023-01-18T20:52:36.142807  / # /lava-8785128/bin/lava-test-runner /lav=
a-8785128/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/63c85c4f60f66aacc8915ecd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c85c4f60f66aacc8915=
ece
        new failure (last pass: v4.19.265-cip85-rt27) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63c85ea689091f6ef7915ee9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g=
20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g=
20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c85ea689091f6ef7915eee
        new failure (last pass: v4.19.265-cip85-rt27)

    2023-01-18T21:03:15.227508  + set +x
    2023-01-18T21:03:15.232624  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 138421_1.5.2=
.4.1>
    2023-01-18T21:03:15.343531  / # #
    2023-01-18T21:03:15.445121  export SHELL=3D/bin/sh
    2023-01-18T21:03:15.445486  #
    2023-01-18T21:03:15.546765  / # export SHELL=3D/bin/sh. /lava-138421/en=
vironment
    2023-01-18T21:03:15.547240  =

    2023-01-18T21:03:15.648597  / # . /lava-138421/environment/lava-138421/=
bin/lava-test-runner /lava-138421/1
    2023-01-18T21:03:15.649404  =

    2023-01-18T21:03:15.655582  / # /lava-138421/bin/lava-test-runner /lava=
-138421/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c85dfc06cec1dac1915ec3

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c85dfc06cec1dac1915ec8
        new failure (last pass: v4.19.265-cip85-rt27)

    2023-01-18T21:00:20.778891  <8>[   15.037547] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 138519_1.5.2.4.1>
    2023-01-18T21:00:20.888592  / # #
    2023-01-18T21:00:20.990984  export SHELL=3D/bin/sh
    2023-01-18T21:00:20.991426  #
    2023-01-18T21:00:21.092836  / # export SHELL=3D/bin/sh. /lava-138519/en=
vironment
    2023-01-18T21:00:21.093314  =

    2023-01-18T21:00:21.195267  / # . /lava-138519/environment/lava-138519/=
bin/lava-test-runner /lava-138519/1
    2023-01-18T21:00:21.196422  =

    2023-01-18T21:00:21.200563  / # /lava-138519/bin/lava-test-runner /lava=
-138519/1
    2023-01-18T21:00:21.267541  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | defcon=
fig+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/63c85e24cac74ef883915eca

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-beagleb=
one-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-beagleb=
one-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c85e24cac74ef883915ecf
        new failure (last pass: v4.19.265-cip85-rt27)

    2023-01-18T21:01:04.100016  <8>[   16.725340] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 138530_1.5.2.4.1>
    2023-01-18T21:01:04.209988  / # #
    2023-01-18T21:01:04.312384  export SHELL=3D/bin/sh
    2023-01-18T21:01:04.313198  #
    2023-01-18T21:01:04.415001  / # export SHELL=3D/bin/sh. /lava-138530/en=
vironment
    2023-01-18T21:01:04.415554  =

    2023-01-18T21:01:04.517200  / # . /lava-138530/environment/lava-138530/=
bin/lava-test-runner /lava-138530/1
    2023-01-18T21:01:04.518586  =

    2023-01-18T21:01:04.522377  / # /lava-138530/bin/lava-test-runner /lava=
-138530/1
    2023-01-18T21:01:04.604232  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c866004d3ab5bcb7915ed5

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/defconfig/gcc-10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/defconfig/gcc-10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c866004d3ab5bcb7915ed8
        new failure (last pass: v4.19.265-cip85-rt27)

    2023-01-18T21:34:32.586554  <8>[    9.903382] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 828045_1.5.2.4.1>
    2023-01-18T21:34:32.697003  / # #
    2023-01-18T21:34:32.799707  export SHELL=3D/bin/sh
    2023-01-18T21:34:32.800550  #
    2023-01-18T21:34:32.902446  / # export SHELL=3D/bin/sh. /lava-828045/en=
vironment
    2023-01-18T21:34:32.903090  =

    2023-01-18T21:34:33.004925  / # . /lava-828045/environment/lava-828045/=
bin/lava-test-runner /lava-828045/1
    2023-01-18T21:34:33.006131  =

    2023-01-18T21:34:33.011637  / # /lava-828045/bin/lava-test-runner /lava=
-828045/1
    2023-01-18T21:34:33.077903  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | defcon=
fig+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8678c24241f6da8915ec1

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/defconfig+preempt_rt/gcc-10/lab-cip/baseline-beaglebone-=
black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/defconfig+preempt_rt/gcc-10/lab-cip/baseline-beaglebone-=
black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c8678c24241f6da8915ec4
        new failure (last pass: v4.19.265-cip85-rt27)

    2023-01-18T21:41:11.925467  <8>[   10.198448] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 828051_1.5.2.4.1>
    2023-01-18T21:41:12.035531  / # #
    2023-01-18T21:41:12.138317  export SHELL=3D/bin/sh
    2023-01-18T21:41:12.138977  #
    2023-01-18T21:41:12.240685  / # export SHELL=3D/bin/sh. /lava-828051/en=
vironment
    2023-01-18T21:41:12.241171  =

    2023-01-18T21:41:12.342769  / # . /lava-828051/environment/lava-828051/=
bin/lava-test-runner /lava-828051/1
    2023-01-18T21:41:12.343998  =

    2023-01-18T21:41:12.350476  / # /lava-828051/bin/lava-test-runner /lava=
-828051/1
    2023-01-18T21:41:12.430642  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63c85dab9fec2acb74915ef0

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebon=
e-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebon=
e-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c85dab9fec2acb74915ef5
        new failure (last pass: v4.19.265-cip85-rt27)

    2023-01-18T20:59:01.170781  <8>[   16.846298] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 138499_1.5.2.4.1>
    2023-01-18T20:59:01.277013  / # #
    2023-01-18T20:59:01.378894  export SHELL=3D/bin/sh
    2023-01-18T20:59:01.379407  #
    2023-01-18T20:59:01.480983  / # export SHELL=3D/bin/sh. /lava-138499/en=
vironment
    2023-01-18T20:59:01.481441  =

    2023-01-18T20:59:01.582883  / # . /lava-138499/environment/lava-138499/=
bin/lava-test-runner /lava-138499/1
    2023-01-18T20:59:01.583590  =

    2023-01-18T20:59:01.587785  / # /lava-138499/bin/lava-test-runner /lava=
-138499/1
    2023-01-18T20:59:01.655537  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defc...g+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/63c85e9d89091f6ef7915ed3

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-broonie/baselin=
e-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-broonie/baselin=
e-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c85e9d89091f6ef7915ed8
        new failure (last pass: v4.19.265-cip85-rt27)

    2023-01-18T21:03:03.390322  <8>[   17.112979] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 138532_1.5.2.4.1>
    2023-01-18T21:03:03.500086  / # #
    2023-01-18T21:03:03.602358  export SHELL=3D/bin/sh
    2023-01-18T21:03:03.602873  #
    2023-01-18T21:03:03.704363  / # export SHELL=3D/bin/sh. /lava-138532/en=
vironment
    2023-01-18T21:03:03.705101  =

    2023-01-18T21:03:03.806563  / # . /lava-138532/environment/lava-138532/=
bin/lava-test-runner /lava-138532/1
    2023-01-18T21:03:03.807368  =

    2023-01-18T21:03:03.811775  / # /lava-138532/bin/lava-test-runner /lava=
-138532/1
    2023-01-18T21:03:03.894070  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63c862dc802f67b66b915ec3

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beaglebone-bl=
ack.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beaglebone-bl=
ack.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c862dc802f67b66b915ec6
        new failure (last pass: v4.19.265-cip85-rt27)

    2023-01-18T21:21:14.168505  + set +x
    2023-01-18T21:21:14.170537  <8>[    9.808160] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 828038_1.5.2.4.1>
    2023-01-18T21:21:14.279000  / # #
    2023-01-18T21:21:14.380904  export SHELL=3D/bin/sh
    2023-01-18T21:21:14.381351  #
    2023-01-18T21:21:14.482803  / # export SHELL=3D/bin/sh. /lava-828038/en=
vironment
    2023-01-18T21:21:14.483400  =

    2023-01-18T21:21:14.584852  / # . /lava-828038/environment/lava-828038/=
bin/lava-test-runner /lava-828038/1
    2023-01-18T21:21:14.585600  =

    2023-01-18T21:21:14.587170  / # /lava-828038/bin/lava-test-runner /lava=
-828038/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defc...g+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/63c867dcccbd3c5bf5915ef5

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-cip/baseline-be=
aglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-cip/baseline-be=
aglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c867dcccbd3c5bf5915ef8
        new failure (last pass: v4.19.265-cip85-rt27)

    2023-01-18T21:42:34.227510  <8>[   10.109121] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 828054_1.5.2.4.1>
    2023-01-18T21:42:34.337114  / # #
    2023-01-18T21:42:34.439220  export SHELL=3D/bin/sh
    2023-01-18T21:42:34.439805  #
    2023-01-18T21:42:34.541425  / # export SHELL=3D/bin/sh. /lava-828054/en=
vironment
    2023-01-18T21:42:34.542203  =

    2023-01-18T21:42:34.644072  / # . /lava-828054/environment/lava-828054/=
bin/lava-test-runner /lava-828054/1
    2023-01-18T21:42:34.644714  =

    2023-01-18T21:42:34.651284  / # /lava-828054/bin/lava-test-runner /lava=
-828054/1
    2023-01-18T21:42:34.731926  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63c868cc2b5c7ded69915eba

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beaglebone-b=
lack.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beaglebone-b=
lack.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c868cc2b5c7ded69915ebd
        new failure (last pass: v4.19.265-cip85-rt27)

    2023-01-18T21:46:34.660298  + set +x<8>[   11.631389] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 828064_1.5.2.4.1>
    2023-01-18T21:46:34.660571  =

    2023-01-18T21:46:34.771848  / # #
    2023-01-18T21:46:34.873749  export SHELL=3D/bin/sh
    2023-01-18T21:46:34.874313  #
    2023-01-18T21:46:34.975737  / # export SHELL=3D/bin/sh. /lava-828064/en=
vironment
    2023-01-18T21:46:34.976196  =

    2023-01-18T21:46:35.077623  / # . /lava-828064/environment/lava-828064/=
bin/lava-test-runner /lava-828064/1
    2023-01-18T21:46:35.078383  =

    2023-01-18T21:46:35.080611  / # /lava-828064/bin/lava-test-runner /lava=
-828064/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c85de6785f0e98e5915ee3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c85de6785f0e98e5915ee8
        new failure (last pass: v4.19.265-cip85-rt27)

    2023-01-18T21:00:05.639898  + set +x
    2023-01-18T21:00:05.644319  <8>[    7.693028] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 8785232_1.5.2.4.1>
    2023-01-18T21:00:05.753370  / # #
    2023-01-18T21:00:05.857011  export SHELL=3D/bin/sh
    2023-01-18T21:00:05.857997  #
    2023-01-18T21:00:05.960292  / # export SHELL=3D/bin/sh. /lava-8785232/e=
nvironment
    2023-01-18T21:00:05.961451  =

    2023-01-18T21:00:06.063749  / # . /lava-8785232/environment/lava-878523=
2/bin/lava-test-runner /lava-8785232/1
    2023-01-18T21:00:06.065228  =

    2023-01-18T21:00:06.067907  / # /lava-8785232/bin/lava-test-runner /lav=
a-8785232/1 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | defcon=
fig+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/63c85e0b8e0e0fcffe915ec3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-imx6q=
-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-imx6q=
-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c85e0b8e0e0fcffe915ec8
        new failure (last pass: v4.19.265-cip85-rt27)

    2023-01-18T21:00:42.595514  + set +x
    2023-01-18T21:00:42.599787  <8>[    8.966152] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 8785239_1.5.2.4.1>
    2023-01-18T21:00:42.708386  / ##
    2023-01-18T21:00:42.810949  export SHELL=3D/bin/sh
    2023-01-18T21:00:42.811738   #
    2023-01-18T21:00:42.913402  / # export SHELL=3D/bin/sh. /lava-8785239/e=
nvironment
    2023-01-18T21:00:42.914190  =

    2023-01-18T21:00:43.015862  / # . /lava-8785239/environment/lava-878523=
9/bin/lava-test-runner /lava-8785239/1
    2023-01-18T21:00:43.017060  =

    2023-01-18T21:00:43.018579  / # /lava-8785239/bin/lava-test-runner /lav=
a-8785239/1 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63c85d974a88f9a9e9915ef0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-s=
abrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-s=
abrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c85d974a88f9a9e9915ef5
        new failure (last pass: v4.19.265-cip85-rt27)

    2023-01-18T20:58:45.528850  / # #
    2023-01-18T20:58:45.631485  export SHELL=3D/bin/sh
    2023-01-18T20:58:45.632345  #
    2023-01-18T20:58:45.734524  / # export SHELL=3D/bin/sh. /lava-8785224/e=
nvironment
    2023-01-18T20:58:45.735359  =

    2023-01-18T20:58:45.837435  / # . /lava-8785224/environment/lava-878522=
4/bin/lava-test-runner /lava-8785224/1
    2023-01-18T20:58:45.838680  =

    2023-01-18T20:58:45.851633  / # /lava-8785224/bin/lava-test-runner /lav=
a-8785224/1
    2023-01-18T20:58:45.956491  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-18T20:58:45.957048  + cd /lava-8785224/1/tests/1_bootrr =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defc...g+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/63c85e87641d562a2d915ee6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-collabora/basel=
ine-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-collabora/basel=
ine-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c85e87641d562a2d915eeb
        new failure (last pass: v4.19.265-cip85-rt27)

    2023-01-18T21:02:47.015326  / # #
    2023-01-18T21:02:47.116436  export SHELL=3D/bin/sh
    2023-01-18T21:02:47.116699  #
    2023-01-18T21:02:47.217668  / # export SHELL=3D/bin/sh. /lava-8785262/e=
nvironment
    2023-01-18T21:02:47.217958  =

    2023-01-18T21:02:47.318978  / # . /lava-8785262/environment/lava-878526=
2/bin/lava-test-runner /lava-8785262/1
    2023-01-18T21:02:47.319354  =

    2023-01-18T21:02:47.327882  / # /lava-8785262/bin/lava-test-runner /lav=
a-8785262/1
    2023-01-18T21:02:47.434749  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-18T21:02:47.434874  + cd /lava-8785262/1/tests/1_bootrr =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c85dd99c2c623de0915f19

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandboa=
rd-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandboa=
rd-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c85dd99c2c623de0915f1e
        new failure (last pass: v4.19.265-cip85-rt27)

    2023-01-18T20:59:42.225532  + set +x
    2023-01-18T20:59:42.225690  [    4.853340] <LAVA_SIGNAL_ENDRUN 0_dmesg =
882606_1.5.2.3.1>
    2023-01-18T20:59:42.332646  / # #
    2023-01-18T20:59:42.434245  export SHELL=3D/bin/sh
    2023-01-18T20:59:42.434756  #
    2023-01-18T20:59:42.535992  / # export SHELL=3D/bin/sh. /lava-882606/en=
vironment
    2023-01-18T20:59:42.536538  =

    2023-01-18T20:59:42.638036  / # . /lava-882606/environment/lava-882606/=
bin/lava-test-runner /lava-882606/1
    2023-01-18T20:59:42.638808  =

    2023-01-18T20:59:42.641433  / # /lava-882606/bin/lava-test-runner /lava=
-882606/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | defcon=
fig+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/63c85e25ec0ebb8af3915ee7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/defconfig+preempt_rt/gcc-10/lab-pengutronix/baseline-imx=
6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/defconfig+preempt_rt/gcc-10/lab-pengutronix/baseline-imx=
6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c85e25ec0ebb8af3915eec
        new failure (last pass: v4.19.265-cip85-rt27)

    2023-01-18T21:01:01.406369  + set +x[    6.601367] <LAVA_SIGNAL_ENDRUN =
0_dmesg 882611_1.5.2.3.1>
    2023-01-18T21:01:01.406531  =

    2023-01-18T21:01:01.512852  / # #
    2023-01-18T21:01:01.614309  export SHELL=3D/bin/sh
    2023-01-18T21:01:01.614781  #
    2023-01-18T21:01:01.716048  / # export SHELL=3D/bin/sh. /lava-882611/en=
vironment
    2023-01-18T21:01:01.716460  =

    2023-01-18T21:01:01.817648  / # . /lava-882611/environment/lava-882611/=
bin/lava-test-runner /lava-882611/1
    2023-01-18T21:01:01.818179  =

    2023-01-18T21:01:01.820492  / # /lava-882611/bin/lava-test-runner /lava=
-882611/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63c85c597c02ce76ed915eec

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6=
qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6=
qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c85c597c02ce76ed915ef1
        new failure (last pass: v4.19.265-cip85-rt27)

    2023-01-18T20:53:37.806504  + set +x
    2023-01-18T20:53:37.806651  [    7.141955] <LAVA_SIGNAL_ENDRUN 0_dmesg =
882595_1.5.2.3.1>
    2023-01-18T20:53:37.913927  / # #
    2023-01-18T20:53:38.015439  export SHELL=3D/bin/sh
    2023-01-18T20:53:38.015812  #
    2023-01-18T20:53:38.116946  / # export SHELL=3D/bin/sh. /lava-882595/en=
vironment
    2023-01-18T20:53:38.117337  =

    2023-01-18T20:53:38.218469  / # . /lava-882595/environment/lava-882595/=
bin/lava-test-runner /lava-882595/1
    2023-01-18T20:53:38.218944  =

    2023-01-18T20:53:38.221644  / # /lava-882595/bin/lava-test-runner /lava=
-882595/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63c85d72ea4ddb9aed915f13

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6q=
p-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6q=
p-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c85d72ea4ddb9aed915f18
        new failure (last pass: v4.19.265-cip85-rt27)

    2023-01-18T20:58:16.519368  + set +x
    2023-01-18T20:58:16.519741  [    4.943469] <LAVA_SIGNAL_ENDRUN 0_dmesg =
882601_1.5.2.3.1>
    2023-01-18T20:58:16.625845  / # #
    2023-01-18T20:58:16.727955  export SHELL=3D/bin/sh
    2023-01-18T20:58:16.728589  #
    2023-01-18T20:58:16.829893  / # export SHELL=3D/bin/sh. /lava-882601/en=
vironment
    2023-01-18T20:58:16.830398  =

    2023-01-18T20:58:16.931904  / # . /lava-882601/environment/lava-882601/=
bin/lava-test-runner /lava-882601/1
    2023-01-18T20:58:16.932768  =

    2023-01-18T20:58:16.934889  / # /lava-882601/bin/lava-test-runner /lava=
-882601/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defc...g+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/63c85e75591f7dc517915ec3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-pengutronix/bas=
eline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-pengutronix/bas=
eline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c85e75591f7dc517915ec6
        new failure (last pass: v4.19.265-cip85-rt27)

    2023-01-18T21:02:21.253223  [    6.857513] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-01-18T21:02:21.261117  + set[    6.867425] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 882616_1.5.2.3.1>
    2023-01-18T21:02:21.261231   +x
    2023-01-18T21:02:21.366240  / # #
    2023-01-18T21:02:21.468286  export SHELL=3D/bin/sh
    2023-01-18T21:02:21.468651  #
    2023-01-18T21:02:21.569929  / # export SHELL=3D/bin/sh. /lava-882616/en=
vironment
    2023-01-18T21:02:21.570496  =

    2023-01-18T21:02:21.671887  / # . /lava-882616/environment/lava-882616/=
bin/lava-test-runner /lava-882616/1
    2023-01-18T21:02:21.672787   =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6sx-sdb                   | arm    | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c85e0e06cec1dac1915ed0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/defconfig/gcc-10/lab-nxp/baseline-imx6sx-sdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/defconfig/gcc-10/lab-nxp/baseline-imx6sx-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c85e0e06cec1dac1915ed3
        new failure (last pass: v4.19.245-cip74-rt25)

    2023-01-18T21:00:25.732600  / # #
    2023-01-18T21:00:26.891116  export SHELL=3D/bin/sh
    2023-01-18T21:00:26.896499  #
    2023-01-18T21:00:28.441776  / # export SHELL=3D/bin/sh. /lava-1140213/e=
nvironment
    2023-01-18T21:00:28.447167  =

    2023-01-18T21:00:31.265485  / # . /lava-1140213/environment/lava-114021=
3/bin/lava-test-runner /lava-1140213/1
    2023-01-18T21:00:31.271090  =

    2023-01-18T21:00:31.276807  / # /lava-1140213/bin/lava-test-runner /lav=
a-1140213/1
    2023-01-18T21:00:31.366613  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-18T21:00:31.366789  + cd /lava-1140213/1/tests/1_bootrr =

    ... (16 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6sx-sdb                   | arm    | lab-nxp         | gcc-10   | defcon=
fig+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/63c85ec1554c71cce2915f0a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/defconfig+preempt_rt/gcc-10/lab-nxp/baseline-imx6sx-sdb.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/defconfig+preempt_rt/gcc-10/lab-nxp/baseline-imx6sx-sdb.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c85ec1554c71cce2915f0d
        new failure (last pass: v4.19.245-cip74-rt25)

    2023-01-18T21:02:51.330236  <8>[   20.488100] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1140216_1.5.2.4.1>
    2023-01-18T21:02:51.435802  / # #
    2023-01-18T21:02:52.596058  export SHELL=3D/bin/sh
    2023-01-18T21:02:52.601766  #
    2023-01-18T21:02:54.149231  / # export SHELL=3D/bin/sh. /lava-1140216/e=
nvironment
    2023-01-18T21:02:54.154697  =

    2023-01-18T21:02:56.975673  / # . /lava-1140216/environment/lava-114021=
6/bin/lava-test-runner /lava-1140216/1
    2023-01-18T21:02:56.981442  =

    2023-01-18T21:02:56.992973  / # /lava-1140216/bin/lava-test-runner /lav=
a-1140216/1
    2023-01-18T21:02:57.091724  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (17 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6sx-sdb                   | arm    | lab-nxp         | gcc-10   | multi_=
v7_defc...g+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/63c85f5970c839a4c8915f2b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-nxp/baseline-im=
x6sx-sdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-nxp/baseline-im=
x6sx-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c85f5970c839a4c8915f2e
        new failure (last pass: v4.19.245-cip74-rt25)

    2023-01-18T21:06:02.209991  <8>[   19.519851] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1140218_1.5.2.4.1>
    2023-01-18T21:06:02.316287  / # #
    2023-01-18T21:06:03.476695  export SHELL=3D/bin/sh
    2023-01-18T21:06:03.482408  #
    2023-01-18T21:06:05.030388  / # export SHELL=3D/bin/sh. /lava-1140218/e=
nvironment
    2023-01-18T21:06:05.036088  =

    2023-01-18T21:06:07.858425  / # . /lava-1140218/environment/lava-114021=
8/bin/lava-test-runner /lava-1140218/1
    2023-01-18T21:06:07.864506  =

    2023-01-18T21:06:07.875273  / # /lava-1140218/bin/lava-test-runner /lav=
a-1140218/1
    2023-01-18T21:06:07.975259  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (17 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c85e3bec0ebb8af3915f0e

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c85e3bec0ebb8af3915f11
        new failure (last pass: v4.19.265-cip85-rt27)

    2023-01-18T21:01:17.792455  <8>[   12.919622] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1140214_1.5.2.4.1>
    2023-01-18T21:01:17.897988  / # #
    2023-01-18T21:01:19.058413  export SHELL=3D/bin/sh
    2023-01-18T21:01:19.064122  #
    2023-01-18T21:01:20.612050  / # export SHELL=3D/bin/sh. /lava-1140214/e=
nvironment
    2023-01-18T21:01:20.617736  =

    2023-01-18T21:01:23.440549  / # . /lava-1140214/environment/lava-114021=
4/bin/lava-test-runner /lava-1140214/1
    2023-01-18T21:01:23.446876  =

    2023-01-18T21:01:23.447612  / # /lava-1140214/bin/lava-test-runner /lav=
a-1140214/1
    2023-01-18T21:01:23.549010  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (17 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | defcon=
fig+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/63c85ebebecd3b8d2a915ed8

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/defconfig+preempt_rt/gcc-10/lab-nxp/baseline-imx7d-sdb.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/defconfig+preempt_rt/gcc-10/lab-nxp/baseline-imx7d-sdb.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c85ebebecd3b8d2a915edb
        new failure (last pass: v4.19.245-cip74-rt25)

    2023-01-18T21:03:20.273836  <8>[   14.452091] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1140215_1.5.2.4.1>
    2023-01-18T21:03:20.379452  / # #
    2023-01-18T21:03:21.539689  export SHELL=3D/bin/sh
    2023-01-18T21:03:21.545395  #
    2023-01-18T21:03:23.093246  / # export SHELL=3D/bin/sh. /lava-1140215/e=
nvironment
    2023-01-18T21:03:23.098956  =

    2023-01-18T21:03:25.921349  / # . /lava-1140215/environment/lava-114021=
5/bin/lava-test-runner /lava-1140215/1
    2023-01-18T21:03:25.927399  =

    2023-01-18T21:03:25.928339  / # /lava-1140215/bin/lava-test-runner /lav=
a-1140215/1
    2023-01-18T21:03:26.034276  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (17 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63c85db68f92785951915ec3

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c85db68f92785951915ec6
        new failure (last pass: v4.19.265-cip85-rt27)

    2023-01-18T20:59:02.569255  <8>[   12.931017] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1140212_1.5.2.4.1>
    2023-01-18T20:59:02.675640  / # #
    2023-01-18T20:59:03.836127  export SHELL=3D/bin/sh
    2023-01-18T20:59:03.841844  #
    2023-01-18T20:59:05.389019  / # export SHELL=3D/bin/sh. /lava-1140212/e=
nvironment
    2023-01-18T20:59:05.394713  =

    2023-01-18T20:59:08.216968  / # . /lava-1140212/environment/lava-114021=
2/bin/lava-test-runner /lava-1140212/1
    2023-01-18T20:59:08.223061  =

    2023-01-18T20:59:08.223944  / # /lava-1140212/bin/lava-test-runner /lav=
a-1140212/1
    2023-01-18T20:59:08.325897  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (17 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | multi_=
v7_defc...g+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/63c85f5570c839a4c8915f1d

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-nxp/baseline-im=
x7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-nxp/baseline-im=
x7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c85f5570c839a4c8915f20
        new failure (last pass: v4.19.265-cip85-rt27)

    2023-01-18T21:05:57.242014  <8>[   14.633379] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1140217_1.5.2.4.1>
    2023-01-18T21:05:57.347676  / # #
    2023-01-18T21:05:58.508160  export SHELL=3D/bin/sh
    2023-01-18T21:05:58.513863  #
    2023-01-18T21:06:00.061860  / # export SHELL=3D/bin/sh. /lava-1140217/e=
nvironment
    2023-01-18T21:06:00.067578  =

    2023-01-18T21:06:02.889826  / # . /lava-1140217/environment/lava-114021=
7/bin/lava-test-runner /lava-1140217/1
    2023-01-18T21:06:02.895889  =

    2023-01-18T21:06:02.900997  / # /lava-1140217/bin/lava-test-runner /lav=
a-1140217/1
    2023-01-18T21:06:03.008893  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (17 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c86461938d98a310915f14

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt=
-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt=
-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c86461938d98a310915=
f15
        failing since 233 days (last pass: vv4.19.233-cip69-rt24, first fai=
l: v4.19.245-cip74-rt25) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c85e71c7182d6cba915ebb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-vir=
t-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-vir=
t-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c85e71c7182d6cba915=
ebc
        failing since 233 days (last pass: vv4.19.233-cip69-rt24, first fai=
l: v4.19.245-cip74-rt25) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c864291b7b380965915ee5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt=
-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt=
-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c864291b7b380965915=
ee6
        failing since 233 days (last pass: vv4.19.233-cip69-rt24, first fai=
l: v4.19.245-cip74-rt25) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c85e5d561cee7210915f32

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-vir=
t-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-vir=
t-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c85e5d561cee7210915=
f33
        failing since 233 days (last pass: vv4.19.233-cip69-rt24, first fai=
l: v4.19.245-cip74-rt25) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c864271b7b380965915edf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt=
-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt=
-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c864271b7b380965915=
ee0
        failing since 233 days (last pass: vv4.19.233-cip69-rt24, first fai=
l: v4.19.245-cip74-rt25) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8642b1b7b380965915ee8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt=
-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt=
-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c8642b1b7b380965915=
ee9
        failing since 233 days (last pass: vv4.19.233-cip69-rt24, first fai=
l: v4.19.245-cip74-rt25) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c85e5f13ec3f2efd915ebb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-vir=
t-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-vir=
t-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c85e5f13ec3f2efd915=
ebc
        failing since 233 days (last pass: vv4.19.233-cip69-rt24, first fai=
l: v4.19.245-cip74-rt25) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a7796-m3ulcb               | arm64  | lab-collabora   | gcc-10   | defcon=
fig+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/63c85c0490e6035661915f61

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm64/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-r8a=
7796-m3ulcb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm64/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-r8a=
7796-m3ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c85c0490e6035661915f66
        new failure (last pass: v4.19.265-cip85-rt27)

    2023-01-18T20:52:03.893125  / # #
    2023-01-18T20:52:03.994949  export SHELL=3D/bin/sh
    2023-01-18T20:52:03.995487  #
    2023-01-18T20:52:04.096838  / # export SHELL=3D/bin/sh. /lava-8785114/e=
nvironment
    2023-01-18T20:52:04.097526  =

    2023-01-18T20:52:04.198932  / # . /lava-8785114/environment/lava-878511=
4/bin/lava-test-runner /lava-8785114/1
    2023-01-18T20:52:04.199909  =

    2023-01-18T20:52:04.202957  / # /lava-8785114/bin/lava-test-runner /lav=
a-8785114/1
    2023-01-18T20:52:04.264880  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-18T20:52:04.265162  + cd /la<8>[   22.557144] <LAVA_SIGNAL_STAR=
TRUN 1_bootrr 8785114_1.5.2.4.5> =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a7796-m3ulcb               | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c85d6bd6964340fc915f1f

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a7796-m3ulcb=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a7796-m3ulcb=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c85d6bd6964340fc915f24
        new failure (last pass: v4.19.265-cip85-rt27)

    2023-01-18T20:58:05.596633  / # #
    2023-01-18T20:58:05.699855  export SHELL=3D/bin/sh
    2023-01-18T20:58:05.700844  #
    2023-01-18T20:58:05.803115  / # export SHELL=3D/bin/sh. /lava-8785182/e=
nvironment
    2023-01-18T20:58:05.804305  =

    2023-01-18T20:58:05.906778  / # . /lava-8785182/environment/lava-878518=
2/bin/lava-test-runner /lava-8785182/1
    2023-01-18T20:58:05.909012  =

    2023-01-18T20:58:05.915769  / # /lava-8785182/bin/lava-test-runner /lav=
a-8785182/1
    2023-01-18T20:58:05.969090  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-18T20:58:05.969570  +<8>[   21.176567] <LAVA_SIGNAL_STARTRUN 1_=
bootrr 8785182_1.5.2.4.5> =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/63c85c6a8999e17deb915ebe

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm64/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-sun50=
i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm64/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-sun50=
i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c85c6a8999e17deb915ec3
        new failure (last pass: v4.19.265-cip85-rt27)

    2023-01-18T20:53:48.601031  <8>[   16.917893] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 138398_1.5.2.4.1>
    2023-01-18T20:53:48.708841  / # #
    2023-01-18T20:53:48.811523  export SHELL=3D/bin/sh
    2023-01-18T20:53:48.812248  #
    2023-01-18T20:53:48.914421  / # export SHELL=3D/bin/sh. /lava-138398/en=
vironment
    2023-01-18T20:53:48.915211  =

    2023-01-18T20:53:49.017396  / # . /lava-138398/environment/lava-138398/=
bin/lava-test-runner /lava-138398/1
    2023-01-18T20:53:49.018568  =

    2023-01-18T20:53:49.022218  / # /lava-138398/bin/lava-test-runner /lava=
-138398/1
    2023-01-18T20:53:49.064851  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c85dd2cde6c15eeb915edf

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine6=
4-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine6=
4-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c85dd2cde6c15eeb915ee4
        new failure (last pass: v4.19.265-cip85-rt27)

    2023-01-18T20:59:50.666040  <8>[   15.894432] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 138467_1.5.2.4.1>
    2023-01-18T20:59:50.771961  / # #
    2023-01-18T20:59:50.874696  export SHELL=3D/bin/sh
    2023-01-18T20:59:50.875215  #
    2023-01-18T20:59:50.976898  / # export SHELL=3D/bin/sh. /lava-138467/en=
vironment
    2023-01-18T20:59:50.977420  =

    2023-01-18T20:59:51.079075  / # . /lava-138467/environment/lava-138467/=
bin/lava-test-runner /lava-138467/1
    2023-01-18T20:59:51.079899  =

    2023-01-18T20:59:51.084398  / # /lava-138467/bin/lava-test-runner /lava=
-138467/1
    2023-01-18T20:59:51.115455  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-baylibre    | gcc-10   | defcon=
fig+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/63c85bfea192fcb86e915eb9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm64/defconfig+preempt_rt/gcc-10/lab-baylibre/baseline-sun5=
0i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm64/defconfig+preempt_rt/gcc-10/lab-baylibre/baseline-sun5=
0i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c85bfea192fcb86e915ebe
        new failure (last pass: v4.19.265-cip85-rt27)

    2023-01-18T20:51:56.729100  / # #
    2023-01-18T20:51:56.830866  export SHELL=3D/bin/sh
    2023-01-18T20:51:56.831230  #
    2023-01-18T20:51:56.932569  / # export SHELL=3D/bin/sh. /lava-3163113/e=
nvironment
    2023-01-18T20:51:56.932919  =

    2023-01-18T20:51:57.034250  / # . /lava-3163113/environment/lava-316311=
3/bin/lava-test-runner /lava-3163113/1
    2023-01-18T20:51:57.034857  =

    2023-01-18T20:51:57.052930  / # /lava-3163113/bin/lava-test-runner /lav=
a-3163113/1
    2023-01-18T20:51:57.118771  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-18T20:51:57.119246  + cd /lava-3163113<8>[   16.463503] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 3163113_1.5.2.4.5> =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c85d83ea4ddb9aed915f28

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-h6-pine-=
h64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-h6-pine-=
h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c85d83ea4ddb9aed915f2d
        new failure (last pass: v4.19.265-cip85-rt27)

    2023-01-18T20:58:07.642086  / # #
    2023-01-18T20:58:07.743744  export SHELL=3D/bin/sh
    2023-01-18T20:58:07.744086  #
    2023-01-18T20:58:07.845409  / # export SHELL=3D/bin/sh. /lava-3163167/e=
nvironment
    2023-01-18T20:58:07.845753  =

    2023-01-18T20:58:07.947056  / # . /lava-3163167/environment/lava-316316=
7/bin/lava-test-runner /lava-3163167/1
    2023-01-18T20:58:07.947727  =

    2023-01-18T20:58:07.953336  / # /lava-3163167/bin/lava-test-runner /lav=
a-3163167/1
    2023-01-18T20:58:08.022102  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-18T20:58:08.022636  + cd /lava-3163167<8>[   15.616721] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 3163167_1.5.2.4.5> =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-10   | defcon=
fig+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/63c85c0390e6035661915f56

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm64/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-sun=
50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm64/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-sun=
50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c85c0390e6035661915f5b
        new failure (last pass: v4.19.265-cip85-rt27)

    2023-01-18T20:52:08.186551  / # #
    2023-01-18T20:52:08.288428  export SHELL=3D/bin/sh
    2023-01-18T20:52:08.289058  #
    2023-01-18T20:52:08.390452  / # export SHELL=3D/bin/sh. /lava-8785112/e=
nvironment
    2023-01-18T20:52:08.391054  =

    2023-01-18T20:52:08.492423  / # . /lava-8785112/environment/lava-878511=
2/bin/lava-test-runner /lava-8785112/1
    2023-01-18T20:52:08.493281  =

    2023-01-18T20:52:08.495606  / # /lava-8785112/bin/lava-test-runner /lav=
a-8785112/1
    2023-01-18T20:52:08.576746  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-18T20:52:08.577100  + cd /lava-8785112/1/tes<8>[   16.449176] <=
LAVA_SIGNAL_STARTRUN 1_bootrr 8785112_1.5.2.4.5> =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c85d6cea4ddb9aed915ebb

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine=
-h64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine=
-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c85d6cea4ddb9aed915ec0
        new failure (last pass: v4.19.265-cip85-rt27)

    2023-01-18T20:58:10.107472  / # #
    2023-01-18T20:58:10.210611  export SHELL=3D/bin/sh
    2023-01-18T20:58:10.211448  #
    2023-01-18T20:58:10.313658  / # export SHELL=3D/bin/sh. /lava-8785185/e=
nvironment
    2023-01-18T20:58:10.314519  =

    2023-01-18T20:58:10.416681  / # . /lava-8785185/environment/lava-878518=
5/bin/lava-test-runner /lava-8785185/1
    2023-01-18T20:58:10.418124  =

    2023-01-18T20:58:10.428712  / # /lava-8785185/bin/lava-test-runner /lav=
a-8785185/1
    2023-01-18T20:58:10.488268  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-18T20:58:10.488969  + cd /lava-8785185<8>[   15.629249] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 8785185_1.5.2.4.5> =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun8i-h2-plus...ch-all-h3-cc | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63c85d97d6c7dfef72915ef0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h2=
-plus-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h2=
-plus-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c85d97d6c7dfef72915ef5
        new failure (last pass: v4.19.217-cip62-rt23)

    2023-01-18T20:58:32.951198  <8>[    9.135867] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3163205_1.5.2.4.1>
    2023-01-18T20:58:33.056419  / # #
    2023-01-18T20:58:33.158134  export SHELL=3D/bin/sh
    2023-01-18T20:58:33.158492  #
    2023-01-18T20:58:33.259842  / # export SHELL=3D/bin/sh. /lava-3163205/e=
nvironment
    2023-01-18T20:58:33.260187  =

    2023-01-18T20:58:33.361514  / # . /lava-3163205/environment/lava-316320=
5/bin/lava-test-runner /lava-3163205/1
    2023-01-18T20:58:33.362154  =

    2023-01-18T20:58:33.368784  / # /lava-3163205/bin/lava-test-runner /lav=
a-3163205/1
    2023-01-18T20:58:33.463746  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63c85d8c4a88f9a9e9915ec7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h3=
-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h3=
-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c85d8c4a88f9a9e9915ecc
        new failure (last pass: v4.19.217-cip62-rt23)

    2023-01-18T20:58:26.756655  + set +x
    2023-01-18T20:58:26.758639  <8>[    9.218920] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3163211_1.5.2.4.1>
    2023-01-18T20:58:26.863870  / # #
    2023-01-18T20:58:26.965549  export SHELL=3D/bin/sh
    2023-01-18T20:58:26.965901  #
    2023-01-18T20:58:27.067156  / # export SHELL=3D/bin/sh. /lava-3163211/e=
nvironment
    2023-01-18T20:58:27.067510  =

    2023-01-18T20:58:27.168854  / # . /lava-3163211/environment/lava-316321=
1/bin/lava-test-runner /lava-3163211/1
    2023-01-18T20:58:27.169497  =

    2023-01-18T20:58:27.174402  / # /lava-3163211/bin/lava-test-runner /lav=
a-3163211/1 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/63c85bd5b8c24df521915ebb

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm64/defconfig+preempt_rt/gcc-10/lab-cip/baseline-zynqmp-zc=
u102.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm64/defconfig+preempt_rt/gcc-10/lab-cip/baseline-zynqmp-zc=
u102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c85bd5b8c24df521915ebe
        new failure (last pass: v4.19.265-cip85-rt27)

    2023-01-18T20:51:27.808148  + set +x
    2023-01-18T20:51:27.809271  <8>[    4.469119] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 827996_1.5.2.4.1>
    2023-01-18T20:51:27.916676  / # #
    2023-01-18T20:51:28.018702  export SHELL=3D/bin/sh
    2023-01-18T20:51:28.019180  #
    2023-01-18T20:51:28.120600  / # export SHELL=3D/bin/sh. /lava-827996/en=
vironment
    2023-01-18T20:51:28.121052  =

    2023-01-18T20:51:28.222463  / # . /lava-827996/environment/lava-827996/=
bin/lava-test-runner /lava-827996/1
    2023-01-18T20:51:28.223224  =

    2023-01-18T20:51:28.226143  / # /lava-827996/bin/lava-test-runner /lava=
-827996/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c85d66d6964340fc915f11

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm64/defconfig/gcc-10/lab-cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm64/defconfig/gcc-10/lab-cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c85d66d6964340fc915f14
        new failure (last pass: v4.19.265-cip85-rt27)

    2023-01-18T20:57:51.768290  / # #
    2023-01-18T20:57:51.869588  export SHELL=3D/bin/sh
    2023-01-18T20:57:51.869952  #
    2023-01-18T20:57:51.971016  / # export SHELL=3D/bin/sh. /lava-828022/en=
vironment
    2023-01-18T20:57:51.971474  =

    2023-01-18T20:57:52.072611  / # . /lava-828022/environment/lava-828022/=
bin/lava-test-runner /lava-828022/1
    2023-01-18T20:57:52.073108  =

    2023-01-18T20:57:52.075891  / # /lava-828022/bin/lava-test-runner /lava=
-828022/1
    2023-01-18T20:57:52.111944  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-18T20:57:52.112291  + cd /lava-828022/1/tests/1_bootrr =

    ... (11 line(s) more)  =

 =20

