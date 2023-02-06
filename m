Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140BFC636D6
	for <webhook@archiver.kernel.org>; Mon,  6 Feb 2023 11:54:44 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web10.51366.1675684474704007032
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 06 Feb 2023 03:54:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=f/+ik9SW;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.170, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f170.google.com with SMTP id t17so8191306pfj.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 06 Feb 2023 03:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BIHQtPRh2jlbu2JNU/c9aJ94iPV8KRA3bYD6FmJWvCI=;
        b=f/+ik9SWpZMvKT3HwYdZLg4MQyUQQJQAzHMELHXUM1s5Xv5Uaeu8ZNfDVeItVj9VQm
         IaNzuUBwBIJoHT+77kUAEb+uCwzxT/tmhmQgr59wJUIFtm79QsT7OOzuovukeYYOSWs6
         4TesLg91WHuP5ULHCgGzR+7dqTUkiFgdrwZi+0FSY2RGlA0lQC+XZTjKxSUW+LummkR+
         BP72ReO5lOjhyy+nAijgH6lqUBEojo/8F3medPuLTHXespmimsXnJiifpmtA1SSHJRV1
         Zj1x5DHDq68zOKlk/Khxo8qMDn1QB8kb6W0VF98cK3kiOZgVRQ4yV7GKzAi41kF2GZOQ
         /yqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BIHQtPRh2jlbu2JNU/c9aJ94iPV8KRA3bYD6FmJWvCI=;
        b=SyLcrfjuAwmdy9jSvwE5n2zeU0N5nYVJHc8pC/w628jJcm6LzCVWHKEIbTfNvPCxDB
         G1w+JtsdR4IaUcnjENSkc1bV+Z4tPjdoAJdoNn+PxMVUFAazjrssA9tV/PzeLyx1LhZj
         ymdn42BYc5UX8/1WxZM4a8/kr00PQnsvb64gu8UpzJsr6dXMQFKU0amkAq3MQYK5EN4U
         TZI9kWoc+9Q9SfCh9yh3Kr4it+BoKdmKpoOYhkmWndvznXz5kDQO0NvMaF3G3TG6fPcx
         UKN87f8T3GlcLhGFQx4rI8QexxTyrXR9qLeG7SCE3TBCjBTSQPlLJVSflOajDWFgy76r
         ju+Q==
X-Gm-Message-State: AO0yUKVDOcvhtMhjxgnz4PFoLDrBwQ33L4w/PbiwHqWHvUZTfstswn3d
	lTz4eHkIVDAXf8jvg0hXEm+Oo7ClJXCXPOtb0MzBCg==
X-Google-Smtp-Source: AK7set/J+V5Nap96iZ55/Wk37fwphK9faS8afm8nkzc5amGVVrEgln1QOnuI1B2FEkG5CVhDffSjnA==
X-Received: by 2002:a05:6a00:180e:b0:593:e5b9:b0b0 with SMTP id y14-20020a056a00180e00b00593e5b9b0b0mr23877147pfa.17.1675684472549;
        Mon, 06 Feb 2023 03:54:32 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y4-20020a056a001c8400b0058bcb42dd1asm6854522pfw.111.2023.02.06.03.54.31
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 03:54:32 -0800 (PST)
Message-ID: <63e0ea78.050a0220.89ba3.aa31@mx.google.com>
Date: Mon, 06 Feb 2023 03:54:32 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Kernel: v4.19.271-cip90-81-g5d0e00d43751
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 141 runs,
 44 regressions (v4.19.271-cip90-81-g5d0e00d43751)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 Feb 2023 11:54:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10597

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 141 runs, 44 regressio=
ns (v4.19.271-cip90-81-g5d0e00d43751)

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

cubietruck                   | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =

imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-baylibre    | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-broonie     | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-baylibre    | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-broonie     | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-baylibre    | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-broonie     | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-baylibre    | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-broonie     | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 3          =

rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 5          =

sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =

sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre    | gcc-10   | sunxi_=
defconfig              | 1          =

zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =

zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.271-cip90-81-g5d0e00d43751/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.271-cip90-81-g5d0e00d43751
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      5d0e00d43751ec5f81c621ca2b1747e2e34d4528 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63e0e1998e840461ca915ee4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/baseline-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/baseline-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63e0e1998e840461ca915ee9
        failing since 18 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-06T11:16:21.716877  + set +x

    2023-02-06T11:16:21.723948  <8>[    9.523371] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9033958_1.4.2.3.1>

    2023-02-06T11:16:21.826362  =


    2023-02-06T11:16:21.927331  / # #export SHELL=3D/bin/sh

    2023-02-06T11:16:21.927568  =


    2023-02-06T11:16:22.028488  / # export SHELL=3D/bin/sh. /lava-9033958/e=
nvironment

    2023-02-06T11:16:22.028741  =


    2023-02-06T11:16:22.129649  / # . /lava-9033958/environment/lava-903395=
8/bin/lava-test-runner /lava-9033958/1

    2023-02-06T11:16:22.130012  =


    2023-02-06T11:16:22.134496  / # /lava-9033958/bin/lava-test-runner /lav=
a-9033958/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63e0e1a5be642ed055915ee7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/baseline-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/baseline-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63e0e1a5be642ed055915eec
        failing since 18 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-06T11:16:30.545804  + set +x

    2023-02-06T11:16:30.552110  <8>[   10.926212] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9033919_1.4.2.3.1>

    2023-02-06T11:16:30.657353  / # #

    2023-02-06T11:16:30.758371  export SHELL=3D/bin/sh

    2023-02-06T11:16:30.758579  #

    2023-02-06T11:16:30.859475  / # export SHELL=3D/bin/sh. /lava-9033919/e=
nvironment

    2023-02-06T11:16:30.859682  =


    2023-02-06T11:16:30.960468  / # . /lava-9033919/environment/lava-903391=
9/bin/lava-test-runner /lava-9033919/1

    2023-02-06T11:16:30.960757  =


    2023-02-06T11:16:30.965705  / # /lava-9033919/bin/lava-test-runner /lav=
a-9033919/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beagle-xm                    | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63e0e2f5ff2fe6cb0b915ee1

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm/multi_v7_defconfig/gcc-10=
/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm/multi_v7_defconfig/gcc-10=
/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63e0e2f5ff2fe6cb0b915ee6
        failing since 18 days (last pass: v4.19.259-cip82-57-ge54228ee5a88d=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-06T11:21:53.803648  <8>[   20.580169] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3295541_1.5.2.4.1>
    2023-02-06T11:21:53.912925  / # #
    2023-02-06T11:21:54.016237  export SHELL=3D/bin/sh
    2023-02-06T11:21:54.017237  #
    2023-02-06T11:21:54.119497  / # export SHELL=3D/bin/sh. /lava-3295541/e=
nvironment
    2023-02-06T11:21:54.120445  =

    2023-02-06T11:21:54.222524  / # . /lava-3295541/environment/lava-329554=
1/bin/lava-test-runner /lava-3295541/1
    2023-02-06T11:21:54.223075  =

    2023-02-06T11:21:54.227894  / # /lava-3295541/bin/lava-test-runner /lav=
a-3295541/1
    2023-02-06T11:21:54.319874  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beagle-xm                    | arm    | lab-baylibre    | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63e0e1e37ba24ce2b0915ed9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm/omap2plus_defconfig/gcc-1=
0/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm/omap2plus_defconfig/gcc-1=
0/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63e0e1e37ba24ce2b0915ede
        failing since 18 days (last pass: v4.19.252-cip78-146-g6acc38498265=
c, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-06T11:17:41.829566  + set +x<8>[   25.589935] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3295482_1.5.2.4.1>
    2023-02-06T11:17:41.830229  =

    2023-02-06T11:17:41.944745  / # #
    2023-02-06T11:17:42.048095  export SHELL=3D/bin/sh
    2023-02-06T11:17:42.049053  #
    2023-02-06T11:17:42.151109  / # export SHELL=3D/bin/sh. /lava-3295482/e=
nvironment
    2023-02-06T11:17:42.152141  =

    2023-02-06T11:17:42.254282  / # . /lava-3295482/environment/lava-329548=
2/bin/lava-test-runner /lava-3295482/1
    2023-02-06T11:17:42.256204  =

    2023-02-06T11:17:42.261285  / # /lava-3295482/bin/lava-test-runner /lav=
a-3295482/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63e0e2fc5248993472915f1d

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm/multi_v7_defconfig/gcc-10=
/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm/multi_v7_defconfig/gcc-10=
/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63e0e2fc5248993472915f22
        failing since 18 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-06T11:22:05.640111  <8>[   15.905247] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 260366_1.5.2.4.1>
    2023-02-06T11:22:05.748566  / # #
    2023-02-06T11:22:05.851113  export SHELL=3D/bin/sh
    2023-02-06T11:22:05.851688  #
    2023-02-06T11:22:05.953327  / # export SHELL=3D/bin/sh. /lava-260366/en=
vironment
    2023-02-06T11:22:05.953860  =

    2023-02-06T11:22:06.055417  / # . /lava-260366/environment/lava-260366/=
bin/lava-test-runner /lava-260366/1
    2023-02-06T11:22:06.056285  =

    2023-02-06T11:22:06.060094  / # /lava-260366/bin/lava-test-runner /lava=
-260366/1
    2023-02-06T11:22:06.127121  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
cubietruck                   | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63e0e2d667188dbd73915ed9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm/multi_v7_defconfig/gcc-10=
/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm/multi_v7_defconfig/gcc-10=
/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63e0e2d667188dbd73915ede
        failing since 17 days (last pass: v4.19.264-cip84-50-g1e56b70eaf66,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-06T11:21:50.529505  <8>[    7.334604] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3295538_1.5.2.4.1>
    2023-02-06T11:21:50.636762  / # #
    2023-02-06T11:21:50.738185  export SHELL=3D/bin/sh
    2023-02-06T11:21:50.738568  #
    2023-02-06T11:21:50.839792  / # export SHELL=3D/bin/sh. /lava-3295538/e=
nvironment
    2023-02-06T11:21:50.840166  =

    2023-02-06T11:21:50.941312  / # . /lava-3295538/environment/lava-329553=
8/bin/lava-test-runner /lava-3295538/1
    2023-02-06T11:21:50.941877  =

    2023-02-06T11:21:50.947306  / # /lava-3295538/bin/lava-test-runner /lav=
a-3295538/1
    2023-02-06T11:21:51.030011  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63e0e2e067188dbd73915f0e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm/multi_v7_defconfig/gcc-10=
/lab-collabora/baseline-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm/multi_v7_defconfig/gcc-10=
/lab-collabora/baseline-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63e0e2e067188dbd73915f13
        failing since 18 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-06T11:21:50.352742  / # #

    2023-02-06T11:21:50.455785  export SHELL=3D/bin/sh

    2023-02-06T11:21:50.456609  #

    2023-02-06T11:21:50.558820  / # export SHELL=3D/bin/sh. /lava-9034055/e=
nvironment

    2023-02-06T11:21:50.559705  =


    2023-02-06T11:21:50.661780  / # . /lava-9034055/environment/lava-903405=
5/bin/lava-test-runner /lava-9034055/1

    2023-02-06T11:21:50.663133  =


    2023-02-06T11:21:50.675183  / # /lava-9034055/bin/lava-test-runner /lav=
a-9034055/1

    2023-02-06T11:21:50.774043  + export 'TESTRUN_ID=3D1_bootrr'

    2023-02-06T11:21:50.774621  + cd /lava-9034055/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63e0e1e47ba24ce2b0915ee4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm/imx_v6_v7_defconfig/gcc-1=
0/lab-pengutronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm/imx_v6_v7_defconfig/gcc-1=
0/lab-pengutronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63e0e1e47ba24ce2b0915ee9
        failing since 18 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-06T11:17:44.330352  + set +x
    2023-02-06T11:17:44.330655  [    7.155228] <LAVA_SIGNAL_ENDRUN 0_dmesg =
899135_1.5.2.3.1>
    2023-02-06T11:17:44.438387  / # #
    2023-02-06T11:17:44.540253  export SHELL=3D/bin/sh
    2023-02-06T11:17:44.540907  #
    2023-02-06T11:17:44.642269  / # export SHELL=3D/bin/sh. /lava-899135/en=
vironment
    2023-02-06T11:17:44.642847  =

    2023-02-06T11:17:44.743912  / # . /lava-899135/environment/lava-899135/=
bin/lava-test-runner /lava-899135/1
    2023-02-06T11:17:44.744563  =

    2023-02-06T11:17:44.747341  / # /lava-899135/bin/lava-test-runner /lava=
-899135/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63e0e2c067188dbd73915ebb

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm/multi_v7_defconfig/gcc-10=
/lab-pengutronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm/multi_v7_defconfig/gcc-10=
/lab-pengutronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63e0e2c067188dbd73915ec0
        failing since 18 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-06T11:21:15.597751  + set +x
    2023-02-06T11:21:15.597908  [    4.884810] <LAVA_SIGNAL_ENDRUN 0_dmesg =
899140_1.5.2.3.1>
    2023-02-06T11:21:15.703974  / # #
    2023-02-06T11:21:15.805711  export SHELL=3D/bin/sh
    2023-02-06T11:21:15.806118  #
    2023-02-06T11:21:15.907339  / # export SHELL=3D/bin/sh. /lava-899140/en=
vironment
    2023-02-06T11:21:15.907717  =

    2023-02-06T11:21:16.008975  / # . /lava-899140/environment/lava-899140/=
bin/lava-test-runner /lava-899140/1
    2023-02-06T11:21:16.009746  =

    2023-02-06T11:21:16.011858  / # /lava-899140/bin/lava-test-runner /lava=
-899140/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63e0e34c375018c771915ef2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm64/defconfig/gcc-10/lab-ba=
ylibre/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm64/defconfig/gcc-10/lab-ba=
ylibre/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63e0e34c375018c771915=
ef3
        failing since 263 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-baylibre    | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63e0e34ea1670970bb915eec

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63e0e34ea1670970bb915=
eed
        failing since 263 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63e0e375610aa3ffec915ecc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63e0e375610aa3ffec915=
ecd
        failing since 263 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-broonie     | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63e0e43d5418d01941915ee9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63e0e43d5418d01941915=
eea
        failing since 263 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63e0e2d967188dbd73915eef

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm64/defconfig/gcc-10/lab-co=
llabora/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm64/defconfig/gcc-10/lab-co=
llabora/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63e0e2d967188dbd73915=
ef0
        failing since 263 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63e0e33ca1670970bb915eb9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm64/defconfig/gcc-10/lab-ba=
ylibre/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm64/defconfig/gcc-10/lab-ba=
ylibre/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63e0e33ca1670970bb915=
eba
        failing since 263 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-baylibre    | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63e0e36024cfcac99f915ee1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63e0e36024cfcac99f915=
ee2
        failing since 263 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63e0e41529b1aa3455915edf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63e0e41529b1aa3455915=
ee0
        failing since 263 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-broonie     | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63e0e4deb6802530b8915ebb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63e0e4deb6802530b8915=
ebc
        failing since 263 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63e0e2ed296d64429b915ec4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm64/defconfig/gcc-10/lab-co=
llabora/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm64/defconfig/gcc-10/lab-co=
llabora/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63e0e2ed296d64429b915=
ec5
        failing since 263 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63e0e33b7aa046eb4a915ef6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm64/defconfig/gcc-10/lab-ba=
ylibre/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm64/defconfig/gcc-10/lab-ba=
ylibre/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63e0e33b7aa046eb4a915=
ef7
        failing since 263 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-baylibre    | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63e0e35124cfcac99f915ebc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63e0e35124cfcac99f915=
ebd
        failing since 263 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63e0e4011921744397915ed5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63e0e4011921744397915=
ed6
        failing since 263 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-broonie     | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63e0e4dd79e891df74915eb9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63e0e4dd79e891df74915=
eba
        failing since 263 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63e0e339dcd8f76690915ebe

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm64/defconfig/gcc-10/lab-ba=
ylibre/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm64/defconfig/gcc-10/lab-ba=
ylibre/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63e0e339dcd8f76690915=
ebf
        failing since 263 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-baylibre    | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63e0e35024cfcac99f915eb9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63e0e35024cfcac99f915=
eba
        failing since 263 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63e0e376842c88541a915ec0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63e0e376842c88541a915=
ec1
        failing since 263 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-broonie     | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63e0e48debd2cb772f915eb9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63e0e48debd2cb772f915=
eba
        failing since 263 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63e0e2ec296d64429b915ebf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm64/defconfig/gcc-10/lab-co=
llabora/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm64/defconfig/gcc-10/lab-co=
llabora/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63e0e2ec296d64429b915=
ec0
        failing since 263 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63e0e3005248993472915f39

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63e0e3005248993472915=
f3a
        failing since 263 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 3          =


  Details:     https://kernelci.org/test/plan/id/63e0e365031b738f51915edc

  Results:     61 PASS, 8 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm/multi_v7_defconfig/gcc-10=
/lab-collabora/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm/multi_v7_defconfig/gcc-10=
/lab-collabora/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/63e0e365031b738f51915f0c
        failing since 16 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-06T11:24:09.073084  BusyBox v1.31.1 (2023-01-27 15:57:34 UTC)<8=
>[   12.486299] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-02-06T11:24:09.076093   multi-call binary.

    2023-02-06T11:24:09.076569  =

   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/63e0e365031b738f51915f0d
        failing since 16 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-06T11:24:09.054335  <8>[   12.468853] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63e0e365031b738f51915f20
        failing since 16 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-06T11:24:05.232157  + <8>[    8.649083] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 9034035_1.5.2.3.1>

    2023-02-06T11:24:05.233725  set +x

    2023-02-06T11:24:05.339532  =


    2023-02-06T11:24:05.441020  / # #export SHELL=3D/bin/sh

    2023-02-06T11:24:05.441523  =


    2023-02-06T11:24:05.542868  / # export SHELL=3D/bin/sh. /lava-9034035/e=
nvironment

    2023-02-06T11:24:05.543417  =


    2023-02-06T11:24:05.644747  / # . /lava-9034035/environment/lava-903403=
5/bin/lava-test-runner /lava-9034035/1

    2023-02-06T11:24:05.645449  =


    2023-02-06T11:24:05.647889  / # /lava-9034035/bin/lava-test-runner /lav=
a-9034035/1
 =

    ... (17 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 5          =


  Details:     https://kernelci.org/test/plan/id/63e0e20731bc18a98c915f13

  Results:     79 PASS, 9 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/case/id=
/63e0e20731bc18a98c915f35
        failing since 329 days (last pass: v4.19.229-cip67-111-g5c3c0b39cf3=
b, first fail: v4.19.231-cip68-123-g92e3e7f3d4df)

    2023-02-06T11:18:12.628293  <8>[   35.048159] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s0-probed RESULT=3Dpass>

    2023-02-06T11:18:13.641267  /lava-9034017/1/../bin/lava-test-case

    2023-02-06T11:18:13.649787  <8>[   36.070241] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rk3399-gru-sound-driver-rt5514-present: https://kernelc=
i.org/test/case/id/63e0e20731bc18a98c915f4a
        failing since 18 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-06T11:18:12.140819  Usage: seq [-w] [-s SEP]<8>[   34.555627] <=
LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Drk3399-gru-sound-driver-max98357A-prese=
nt RESULT=3Dfail>

    2023-02-06T11:18:12.149703   [FIRST [INC]] LAST

    2023-02-06T11:18:12.150248  =


    2023-02-06T11:18:12.155291  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-02-06T11:18:12.157355  FIRST, INC default to 1.

    2023-02-06T11:18:12.157932  =

   =


  * baseline.bootrr.rk3399-gru-sound-driver-max98357A-present: https://kern=
elci.org/test/case/id/63e0e20731bc18a98c915f4b
        failing since 18 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-06T11:18:12.111705  <8>[   34.528398] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-dp-present RESULT=3Dfail>

    2023-02-06T11:18:12.111783  =


    2023-02-06T11:18:12.111866  =


    2023-02-06T11:18:12.115186  	-w	Pad to last with leading zeros

    2023-02-06T11:18:12.118001  	-s SEP	String separator

    2023-02-06T11:18:12.121902  /lava-9034017/1/../bin/lava-test-case

    2023-02-06T11:18:12.127674  BusyBox v1.31.1 (2023-01-27 15:57:07 UTC) m=
ulti-call binary.

    2023-02-06T11:18:12.128074  =

   =


  * baseline.bootrr.rk3399-gru-sound-driver-dp-present: https://kernelci.or=
g/test/case/id/63e0e20731bc18a98c915f4c
        failing since 18 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-06T11:18:12.093987  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-02-06T11:18:12.094262  =


    2023-02-06T11:18:12.099489  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-02-06T11:18:12.101787  FIRST, INC default to 1.
   =


  * baseline.bootrr.rk3399-gru-sound-driver-da7219-present: https://kernelc=
i.org/test/case/id/63e0e20731bc18a98c915f4d
        failing since 18 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-06T11:18:12.066811  =


    2023-02-06T11:18:12.089414  BusyBox v1.31.1 (2023-01-27 15:57:07 UTC) m=
ulti-call binary.<8>[   34.506129] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Drk3=
399-gru-sound-driver-da7219-present RESULT=3Dfail>

    2023-02-06T11:18:12.089504  =


    2023-02-06T11:18:12.089591  =

   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63e0e28da135ac0286915efc

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm64/defconfig/gcc-10/lab-ba=
ylibre/baseline-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm64/defconfig/gcc-10/lab-ba=
ylibre/baseline-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63e0e28da135ac0286915f01
        failing since 18 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-06T11:20:26.009378  <8>[   15.910292] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3295484_1.5.2.4.1>
    2023-02-06T11:20:26.130415  / # #
    2023-02-06T11:20:26.236876  export SHELL=3D/bin/sh
    2023-02-06T11:20:26.238637  #
    2023-02-06T11:20:26.342135  / # export SHELL=3D/bin/sh. /lava-3295484/e=
nvironment
    2023-02-06T11:20:26.343758  =

    2023-02-06T11:20:26.447350  / # . /lava-3295484/environment/lava-329548=
4/bin/lava-test-runner /lava-3295484/1
    2023-02-06T11:20:26.450014  =

    2023-02-06T11:20:26.452686  / # /lava-3295484/bin/lava-test-runner /lav=
a-3295484/1
    2023-02-06T11:20:26.484680  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63e0e2162cc3677eb5915f61

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63e0e2162cc3677eb5915f65
        failing since 18 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-06T11:18:29.774028  <8>[   15.952191] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 260289_1.5.2.4.1>
    2023-02-06T11:18:29.882148  / # #
    2023-02-06T11:18:29.984967  export SHELL=3D/bin/sh
    2023-02-06T11:18:29.985752  #
    2023-02-06T11:18:30.088666  / # export SHELL=3D/bin/sh. /lava-260289/en=
vironment
    2023-02-06T11:18:30.089616  =

    2023-02-06T11:18:30.192815  / # . /lava-260289/environment/lava-260289/=
bin/lava-test-runner /lava-260289/1
    2023-02-06T11:18:30.194383  =

    2023-02-06T11:18:30.198404  / # /lava-260289/bin/lava-test-runner /lava=
-260289/1
    2023-02-06T11:18:30.229663  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63e0e1e8f164e57c52915ed3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm64/defconfig/gcc-10/lab-co=
llabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm64/defconfig/gcc-10/lab-co=
llabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63e0e1e8f164e57c52915ed8
        failing since 18 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-06T11:17:36.494284  / # #

    2023-02-06T11:17:36.597784  export SHELL=3D/bin/sh

    2023-02-06T11:17:36.598800  #

    2023-02-06T11:17:36.700907  / # export SHELL=3D/bin/sh. /lava-9034004/e=
nvironment

    2023-02-06T11:17:36.701819  =


    2023-02-06T11:17:36.804012  / # . /lava-9034004/environment/lava-903400=
4/bin/lava-test-runner /lava-9034004/1

    2023-02-06T11:17:36.805530  =


    2023-02-06T11:17:36.818601  / # /lava-9034004/bin/lava-test-runner /lav=
a-9034004/1

    2023-02-06T11:17:36.877767  + export 'TESTRUN_ID=3D1_bootrr'

    2023-02-06T11:17:36.878336  + cd /lava-9034004<8>[   15.629962] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 9034004_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63e0e2d967188dbd73915efd

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm/multi_v7_defconfig/gcc-10=
/lab-baylibre/baseline-sun8i-h3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm/multi_v7_defconfig/gcc-10=
/lab-baylibre/baseline-sun8i-h3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63e0e2d967188dbd73915f00
        failing since 18 days (last pass: v4.19.259-cip82-57-ge54228ee5a88d=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-06T11:21:39.287085  / # #
    2023-02-06T11:21:39.388922  export SHELL=3D/bin/sh
    2023-02-06T11:21:39.389291  #
    2023-02-06T11:21:39.490672  / # export SHELL=3D/bin/sh. /lava-3295539/e=
nvironment
    2023-02-06T11:21:39.491210  =

    2023-02-06T11:21:39.592574  / # . /lava-3295539/environment/lava-329553=
9/bin/lava-test-runner /lava-3295539/1
    2023-02-06T11:21:39.593191  =

    2023-02-06T11:21:39.598331  / # /lava-3295539/bin/lava-test-runner /lav=
a-3295539/1
    2023-02-06T11:21:39.646421  + export 'TESTRUN_ID=3D1_bootrr'
    2023-02-06T11:21:39.686161  + cd /lava-3295539/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre    | gcc-10   | sunxi_=
defconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/63e0e1170037fa702a915f02

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: sunxi_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm/sunxi_defconfig/gcc-10/la=
b-baylibre/baseline-sun8i-h3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm/sunxi_defconfig/gcc-10/la=
b-baylibre/baseline-sun8i-h3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63e0e1170037fa702a915f07
        failing since 18 days (last pass: v4.19.259-cip82-57-ge54228ee5a88d=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-06T11:14:05.773998  <8>[    7.805885] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3295462_1.5.2.4.1>
    2023-02-06T11:14:05.879768  / # #
    2023-02-06T11:14:05.981718  export SHELL=3D/bin/sh
    2023-02-06T11:14:05.982187  #
    2023-02-06T11:14:06.083597  / # export SHELL=3D/bin/sh. /lava-3295462/e=
nvironment
    2023-02-06T11:14:06.084003  =

    2023-02-06T11:14:06.185340  / # . /lava-3295462/environment/lava-329546=
2/bin/lava-test-runner /lava-3295462/1
    2023-02-06T11:14:06.186036  =

    2023-02-06T11:14:06.204629  / # /lava-3295462/bin/lava-test-runner /lav=
a-3295462/1
    2023-02-06T11:14:06.268498  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63e0e1ca6bca150b4c915edf

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm64/defconfig/gcc-10/lab-ci=
p/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm64/defconfig/gcc-10/lab-ci=
p/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63e0e1ca6bca150b4c915ee2
        failing since 18 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-06T11:17:23.810742  + set +x
    2023-02-06T11:17:23.812715  <8>[    3.748478] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 842117_1.5.2.4.1>
    2023-02-06T11:17:23.919598  / # #
    2023-02-06T11:17:24.021492  export SHELL=3D/bin/sh
    2023-02-06T11:17:24.022023  #
    2023-02-06T11:17:24.123383  / # export SHELL=3D/bin/sh. /lava-842117/en=
vironment
    2023-02-06T11:17:24.123833  =

    2023-02-06T11:17:24.225206  / # . /lava-842117/environment/lava-842117/=
bin/lava-test-runner /lava-842117/1
    2023-02-06T11:17:24.225943  =

    2023-02-06T11:17:24.228563  / # /lava-842117/bin/lava-test-runner /lava=
-842117/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63e0e21a2cc3677eb5915f84

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63e0e21a2cc3677eb5915f87
        failing since 18 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-06T11:18:28.480331  + set +x
    2023-02-06T11:18:28.481452  <8>[    3.757106] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 842151_1.5.2.4.1>
    2023-02-06T11:18:28.588671  / # #
    2023-02-06T11:18:28.690579  export SHELL=3D/bin/sh
    2023-02-06T11:18:28.691085  #
    2023-02-06T11:18:28.792528  / # export SHELL=3D/bin/sh. /lava-842151/en=
vironment
    2023-02-06T11:18:28.792997  =

    2023-02-06T11:18:28.894443  / # . /lava-842151/environment/lava-842151/=
bin/lava-test-runner /lava-842151/1
    2023-02-06T11:18:28.895232  =

    2023-02-06T11:18:28.897302  / # /lava-842151/bin/lava-test-runner /lava=
-842151/1 =

    ... (13 line(s) more)  =

 =20

