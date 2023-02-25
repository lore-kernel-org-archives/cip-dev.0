Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045F0C7EE2E
	for <webhook@archiver.kernel.org>; Sat, 25 Feb 2023 19:21:10 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.web10.51189.1677352866020680765
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 25 Feb 2023 11:21:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=F2OXHZBj;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.50, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f50.google.com with SMTP id q31-20020a17090a17a200b0023750b69614so2447653pja.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 25 Feb 2023 11:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9cgUDTBdfyWULwnauSUUam1xUMUPD5Cp0Fa2eL5kNb8=;
        b=F2OXHZBjJWlc4aQEkSbTgzypZ92rHebtTXbIX73XDF+vgLSqPJOu4eiMYprfLmJQmW
         sBfmXLvJMj64FY8HA6fN70EcI65DUv/c7Tw1D1wEJ6WrYvs88Vlj5pteCx4ug1z4KRt6
         9lU4VaStWwHK2+3qgg6WG5BkgCVGzq8Hz+9zWy7WyuWjOGs+zoyoU1xfXSUAkDgiyPlu
         utTuZzihDG/roa5JySjo0lzJpn3cg1apETWR1tzjG0B47FBGLL+8WFm2PNyEMPUFBRE5
         TkbwUvM2Hs/GfFphd2Y8cUaCgCokR2QYfYy1vyPs8am5i3pa6S4X6unOMjEQkydzJwo1
         1iow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9cgUDTBdfyWULwnauSUUam1xUMUPD5Cp0Fa2eL5kNb8=;
        b=oCiuRAz1MLS+w2AqqeXJw3DyQWd7m63SQv8pWMryq9xNBQiXeIkGalzS80aDn9FCxw
         xNkVeW6ej+nlc/EcVcOanBAhDeigWz5KeqqL/xLBo6MMnLQYOFpFKldvDlULULu42+p+
         gbi4p/WJS525m7a/ye/A2vaDslgMpXwpDbDKGV5TQqyDnhGDintLDT+WnYoazyV0U5oD
         ZZNpC5MY1j6ae87Is/WIf8K1TaBIY44x+egWY6Pb7gcJ9FsjxIPz3TorkNq2lPnwSLfK
         ClUDGKH2TyiWSqEOTNWoleCHQcy4FZwzRpBaw7FcRQJ/fkCVuF1Pdv08LR05RPBdTXcz
         T1Qw==
X-Gm-Message-State: AO0yUKV96ebMowfgJGIrYHazjR6JyEYLXtRSlQi6xt0XUHPmCzHv9DTI
	96SBOstQ9oqmyJsDqpl+8SINR+a9WLnduMQw1fI=
X-Google-Smtp-Source: AK7set+2Uf5vmQLmDqBh5eunNUDng7FNLxB14xYKIw1FLlro0YWVHqkjCRvKBsIKREt63FL7GkrCrg==
X-Received: by 2002:a05:6a21:7899:b0:cb:6869:ca66 with SMTP id bf25-20020a056a21789900b000cb6869ca66mr22169389pzc.19.1677352864162;
        Sat, 25 Feb 2023 11:21:04 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j20-20020a62e914000000b0058bc7453285sm1502111pfh.217.2023.02.25.11.21.03
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 11:21:03 -0800 (PST)
Message-ID: <63fa5f9f.620a0220.d1900.23d7@mx.google.com>
Date: Sat, 25 Feb 2023 11:21:03 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.19.273-cip92-14-ga8d1f73f2a28
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 86 runs,
 31 regressions (v4.19.273-cip92-14-ga8d1f73f2a28)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 25 Feb 2023 19:21:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10845

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 86 runs, 31 regression=
s (v4.19.273-cip92-14-ga8d1f73f2a28)

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

qemu_arm64-virt-gicv2-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

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
Flinux-4.19.y-cip-rc/kernel/v4.19.273-cip92-14-ga8d1f73f2a28/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.273-cip92-14-ga8d1f73f2a28
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      a8d1f73f2a28c0a328e74bee5d79d0e91de0df9f =



Test Regressions
---------------- =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus  | x86_64 | lab-collabora   | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63fa55b7d6a2ae26498c866f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/baseline-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/baseline-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63fa55b7d6a2ae26498c8678
        failing since 37 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-25T18:38:25.333417  <8>[   10.000216] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9334746_1.4.2.3.1>

    2023-02-25T18:38:25.337192  + set +x

    2023-02-25T18:38:25.444077  =


    2023-02-25T18:38:25.546588  / # #export SHELL=3D/bin/sh

    2023-02-25T18:38:25.547600  =


    2023-02-25T18:38:25.649461  / # export SHELL=3D/bin/sh. /lava-9334746/e=
nvironment

    2023-02-25T18:38:25.650318  =


    2023-02-25T18:38:25.752567  / # . /lava-9334746/environment/lava-933474=
6/bin/lava-test-runner /lava-9334746/1

    2023-02-25T18:38:25.753995  =


    2023-02-25T18:38:25.759677  / # /lava-9334746/bin/lava-test-runner /lav=
a-9334746/1
 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral   | x86_64 | lab-collabora   | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63fa55c2012653814e8c86cd

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/baseline-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/baseline-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63fa55c2012653814e8c86d6
        failing since 37 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-25T18:38:33.721082  + set +x

    2023-02-25T18:38:33.727863  <8>[   10.320075] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9334697_1.4.2.3.1>

    2023-02-25T18:38:33.832507  / # #

    2023-02-25T18:38:33.933457  export SHELL=3D/bin/sh

    2023-02-25T18:38:33.933666  #

    2023-02-25T18:38:34.034605  / # export SHELL=3D/bin/sh. /lava-9334697/e=
nvironment

    2023-02-25T18:38:34.034807  =


    2023-02-25T18:38:34.135768  / # . /lava-9334697/environment/lava-933469=
7/bin/lava-test-runner /lava-9334697/1

    2023-02-25T18:38:34.136066  =


    2023-02-25T18:38:34.140920  / # /lava-9334697/bin/lava-test-runner /lav=
a-9334697/1
 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
beaglebone-black           | arm    | lab-broonie     | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63fa57530ac7b3e26b8c864d

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/arm/multi_v7_defconfig/gcc-10=
/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/arm/multi_v7_defconfig/gcc-10=
/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63fa57530ac7b3e26b8c8656
        failing since 37 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-25T18:45:10.472308  <8>[   16.332336] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 76077_1.5.2.4.1>
    2023-02-25T18:45:10.579581  / # #
    2023-02-25T18:45:10.681870  export SHELL=3D/bin/sh
    2023-02-25T18:45:10.682633  #
    2023-02-25T18:45:10.784333  / # export SHELL=3D/bin/sh. /lava-76077/env=
ironment
    2023-02-25T18:45:10.785482  =

    2023-02-25T18:45:10.888056  / # . /lava-76077/environment/lava-76077/bi=
n/lava-test-runner /lava-76077/1
    2023-02-25T18:45:10.889478  =

    2023-02-25T18:45:10.893542  / # /lava-76077/bin/lava-test-runner /lava-=
76077/1
    2023-02-25T18:45:10.961393  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx6q-sabrelite            | arm    | lab-collabora   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63fa57376b6fe726a08c8649

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/arm/multi_v7_defconfig/gcc-10=
/lab-collabora/baseline-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/arm/multi_v7_defconfig/gcc-10=
/lab-collabora/baseline-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63fa57376b6fe726a08c8652
        failing since 37 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-25T18:44:59.178750  / # #

    2023-02-25T18:44:59.281661  export SHELL=3D/bin/sh

    2023-02-25T18:44:59.282498  #

    2023-02-25T18:44:59.384478  / # export SHELL=3D/bin/sh. /lava-9334807/e=
nvironment

    2023-02-25T18:44:59.385318  =


    2023-02-25T18:44:59.487245  / # . /lava-9334807/environment/lava-933480=
7/bin/lava-test-runner /lava-9334807/1

    2023-02-25T18:44:59.488507  =


    2023-02-25T18:44:59.501344  / # /lava-9334807/bin/lava-test-runner /lav=
a-9334807/1

    2023-02-25T18:44:59.600201  + export 'TESTRUN_ID=3D1_bootrr'

    2023-02-25T18:44:59.600760  + cd /lava-9334807/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx6qp-wandboard-revd1     | arm    | lab-pengutronix | gcc-10   | imx_v6_v=
7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63fa564fa5c8f2086e8c8633

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/arm/imx_v6_v7_defconfig/gcc-1=
0/lab-pengutronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/arm/imx_v6_v7_defconfig/gcc-1=
0/lab-pengutronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63fa564fa5c8f2086e8c863c
        failing since 37 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-25T18:41:11.320638  + set +x
    2023-02-25T18:41:11.320813  [    7.107411] <LAVA_SIGNAL_ENDRUN 0_dmesg =
913048_1.5.2.3.1>
    2023-02-25T18:41:11.428986  / # #
    2023-02-25T18:41:11.530662  export SHELL=3D/bin/sh
    2023-02-25T18:41:11.531086  #
    2023-02-25T18:41:11.632539  / # export SHELL=3D/bin/sh. /lava-913048/en=
vironment
    2023-02-25T18:41:11.632944  =

    2023-02-25T18:41:11.734147  / # . /lava-913048/environment/lava-913048/=
bin/lava-test-runner /lava-913048/1
    2023-02-25T18:41:11.735960  =

    2023-02-25T18:41:11.737339  / # /lava-913048/bin/lava-test-runner /lava=
-913048/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx6qp-wandboard-revd1     | arm    | lab-pengutronix | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63fa5717651415f5aa8c876c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/arm/multi_v7_defconfig/gcc-10=
/lab-pengutronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/arm/multi_v7_defconfig/gcc-10=
/lab-pengutronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63fa5717651415f5aa8c8775
        failing since 37 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-25T18:44:14.394255  + set +x
    2023-02-25T18:44:14.394416  [    4.909180] <LAVA_SIGNAL_ENDRUN 0_dmesg =
913053_1.5.2.3.1>
    2023-02-25T18:44:14.500443  / # #
    2023-02-25T18:44:14.601909  export SHELL=3D/bin/sh
    2023-02-25T18:44:14.602282  #
    2023-02-25T18:44:14.703492  / # export SHELL=3D/bin/sh. /lava-913053/en=
vironment
    2023-02-25T18:44:14.703898  =

    2023-02-25T18:44:14.805249  / # . /lava-913053/environment/lava-913053/=
bin/lava-test-runner /lava-913053/1
    2023-02-25T18:44:14.805765  =

    2023-02-25T18:44:14.807997  / # /lava-913053/bin/lava-test-runner /lava=
-913053/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63fa5953fd034582af8c8630

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63fa5953fd034582af8c8=
631
        failing since 283 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63fa5a41ceccc9f3638c862f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63fa5a41ceccc9f3638c8=
630
        failing since 283 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63fa5954d17a199d568c863a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63fa5954d17a199d568c8=
63b
        failing since 283 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63fa5abc21ad93c2788c8637

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63fa5abc21ad93c2788c8=
638
        failing since 283 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63fa592bd17a199d568c862f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/arm64/defconfig/gcc-10/lab-co=
llabora/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/arm64/defconfig/gcc-10/lab-co=
llabora/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63fa592bd17a199d568c8=
630
        failing since 283 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63fa59f1354b68a1548c8635

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63fa59f1354b68a1548c8=
636
        failing since 283 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63fa5abbaf9dd0341f8c8653

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63fa5abbaf9dd0341f8c8=
654
        failing since 283 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63fa59e1354b68a1548c8630

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63fa59e1354b68a1548c8=
631
        failing since 283 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63fa5955fd034582af8c8636

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63fa5955fd034582af8c8=
637
        failing since 283 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63fa5aba21ad93c2788c8631

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63fa5aba21ad93c2788c8=
632
        failing since 283 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63fa59e0e90a00be138c8666

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63fa59e0e90a00be138c8=
667
        failing since 283 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
rk3288-veyron-jaq          | arm    | lab-collabora   | gcc-10   | multi_v7=
_defconfig           | 3          =


  Details:     https://kernelci.org/test/plan/id/63fa572c54cd62208d8c8655

  Results:     61 PASS, 8 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/arm/multi_v7_defconfig/gcc-10=
/lab-collabora/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/arm/multi_v7_defconfig/gcc-10=
/lab-collabora/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/63fa572d54cd62208d8c8685
        failing since 35 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-25T18:44:35.063474  BusyBox v1.31.1 (2023-02-17 15:41:33 UTC)<8=
>[   10.305587] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-02-25T18:44:35.066306   multi-call binary.

    2023-02-25T18:44:35.066763  =


    2023-02-25T18:44:35.080396  Usage: seq [-w] [-s SEP] [FIRST [INC]] LA<8=
>[   10.324374] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-cec-present RESULT=3Dfail>
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/63fa572d54cd62208d8c8686
        failing since 35 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-25T18:44:35.044691  /lava-9334790/1/../bin/lava-test-case<8>[  =
 10.288443] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-probed RES=
ULT=3Dpass>

    2023-02-25T18:44:35.044899  =

   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63fa572d54cd62208d8c8699
        failing since 35 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-25T18:44:31.222444  + <8>[    6.469737] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 9334790_1.5.2.3.1>

    2023-02-25T18:44:31.225261  set +x

    2023-02-25T18:44:31.330915  #

    2023-02-25T18:44:31.433620  / # #export SHELL=3D/bin/sh

    2023-02-25T18:44:31.434101  =


    2023-02-25T18:44:31.535490  / # export SHELL=3D/bin/sh. /lava-9334790/e=
nvironment

    2023-02-25T18:44:31.535876  =


    2023-02-25T18:44:31.637193  / # . /lava-9334790/environment/lava-933479=
0/bin/lava-test-runner /lava-9334790/1

    2023-02-25T18:44:31.637777  =


    2023-02-25T18:44:31.639853  / # /lava-9334790/bin/lava-test-runner /lav=
a-9334790/1
 =

    ... (16 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
rk3399-gru-kevin           | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 5          =


  Details:     https://kernelci.org/test/plan/id/63fa590c6caf1f98068c8646

  Results:     79 PASS, 9 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/case/id=
/63fa590c6caf1f98068c866a
        failing since 348 days (last pass: v4.19.229-cip67-111-g5c3c0b39cf3=
b, first fail: v4.19.231-cip68-123-g92e3e7f3d4df)

    2023-02-25T18:52:41.135125  /lava-9334835/1/../bin/lava-test-case

    2023-02-25T18:52:41.142898  <8>[   35.999484] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rk3399-gru-sound-driver-rt5514-present: https://kernelc=
i.org/test/case/id/63fa590c6caf1f98068c867f
        failing since 37 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-25T18:52:39.621549  s of INC.

    2023-02-25T18:52:39.623547  FIRST, INC default to 1.

    2023-02-25T18:52:39.624414  =


    2023-02-25T18:52:39.627459  	-w	Pad to last with leading zeros

    2023-02-25T18:52:39.629499  	-s SEP	String separator

    2023-02-25T18:52:39.643638  /lava-9334835/1/../bin/lava<8>[   34.492730=
] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Drk3399-gru-sound-driver-rt5514-prese=
nt RESULT=3Dfail>
   =


  * baseline.bootrr.rk3399-gru-sound-driver-max98357A-present: https://kern=
elci.org/test/case/id/63fa590c6caf1f98068c8680
        failing since 37 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-25T18:52:39.585571  =


    2023-02-25T18:52:39.587507  /lava-9334835/1/../bin/lava-test-case

    2023-02-25T18:52:39.593865  BusyBox v1.31.1 (2023-02-17 14:37:44 UTC) m=
ulti-call binary.

    2023-02-25T18:52:39.594342  =


    2023-02-25T18:52:39.598930  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-02-25T18:52:39.599386  =


    2023-02-25T18:52:39.612909  Print numbers from FIRST to LAST, in step<8=
>[   34.463526] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Drk3399-gru-sound-drive=
r-max98357A-present RESULT=3Dfail>
   =


  * baseline.bootrr.rk3399-gru-sound-driver-dp-present: https://kernelci.or=
g/test/case/id/63fa590c6caf1f98068c8681
        failing since 37 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-25T18:52:39.558480  =


    2023-02-25T18:52:39.560497  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-02-25T18:52:39.560955  =


    2023-02-25T18:52:39.565146  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-02-25T18:52:39.567826  FIRST, INC default to 1.

    2023-02-25T18:52:39.568300  =


    2023-02-25T18:52:39.571305  	-w	Pad to last with leading zeros

    2023-02-25T18:52:39.574111  	-s SEP	String separator
    2023-02-25T18:52:39.583584  <8>[   34.435040] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-dp-present RESULT=3Dfail>
   =


  * baseline.bootrr.rk3399-gru-sound-driver-da7219-present: https://kernelc=
i.org/test/case/id/63fa590c6caf1f98068c8682
        failing since 37 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-25T18:52:39.556010  BusyBox v1.31.1 (2023-02-17 14:37:44 UTC) m=
ulti-call binary.<8>[   34.408133] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Drk3=
399-gru-sound-driver-da7219-present RESULT=3Dfail>

    2023-02-25T18:52:39.556524  =

   =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus     | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63fa588e35c5c520e68c8642

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63fa588e35c5c520e68c864b
        failing since 37 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-25T18:50:36.124145  <8>[   16.004916] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 76090_1.5.2.4.1>
    2023-02-25T18:50:36.231170  / # #
    2023-02-25T18:50:36.334272  export SHELL=3D/bin/sh
    2023-02-25T18:50:36.334846  #
    2023-02-25T18:50:36.436979  / # export SHELL=3D/bin/sh. /lava-76090/env=
ironment
    2023-02-25T18:50:36.437711  =

    2023-02-25T18:50:36.539656  / # . /lava-76090/environment/lava-76090/bi=
n/lava-test-runner /lava-76090/1
    2023-02-25T18:50:36.540849  =

    2023-02-25T18:50:36.544938  / # /lava-76090/bin/lava-test-runner /lava-=
76090/1
    2023-02-25T18:50:36.576538  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64         | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63fa584442683aedc98c8637

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/arm64/defconfig/gcc-10/lab-co=
llabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/arm64/defconfig/gcc-10/lab-co=
llabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63fa584442683aedc98c8640
        failing since 37 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-25T18:49:29.361469  / # #

    2023-02-25T18:49:29.464550  export SHELL=3D/bin/sh

    2023-02-25T18:49:29.465361  #

    2023-02-25T18:49:29.567428  / # export SHELL=3D/bin/sh. /lava-9334821/e=
nvironment

    2023-02-25T18:49:29.568276  =


    2023-02-25T18:49:29.670368  / # . /lava-9334821/environment/lava-933482=
1/bin/lava-test-runner /lava-9334821/1

    2023-02-25T18:49:29.671795  =


    2023-02-25T18:49:29.682881  / # /lava-9334821/bin/lava-test-runner /lav=
a-9334821/1

    2023-02-25T18:49:29.746770  + export 'TESTRUN_ID=3D1_bootrr'

    2023-02-25T18:49:29.747294  + cd /lava-9334821<8>[   15.631366] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 9334821_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
tegra124-nyan-big          | arm    | lab-collabora   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63fa577c30c5ea3a5b8c863e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/arm/multi_v7_defconfig/gcc-10=
/lab-collabora/baseline-tegra124-nyan-big.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/arm/multi_v7_defconfig/gcc-10=
/lab-collabora/baseline-tegra124-nyan-big.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63fa577c30c5ea3a5b8c8647
        failing since 35 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-25T18:46:06.141746  + set +x

    2023-02-25T18:46:06.147339  <8>[   18.147239] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9334799_1.5.2.3.1>

    2023-02-25T18:46:06.257047  #

    2023-02-25T18:46:06.258248  =


    2023-02-25T18:46:06.360539  / # #export SHELL=3D/bin/sh

    2023-02-25T18:46:06.361356  =


    2023-02-25T18:46:06.463372  / # export SHELL=3D/bin/sh. /lava-9334799/e=
nvironment

    2023-02-25T18:46:06.464285  =


    2023-02-25T18:46:06.566290  / # . /lava-9334799/environment/lava-933479=
9/bin/lava-test-runner /lava-9334799/1

    2023-02-25T18:46:06.567921  =

 =

    ... (15 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
tegra124-nyan-big          | arm    | lab-collabora   | gcc-10   | tegra_de=
fconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/63fa55d877f35ba0b08c865b

  Results:     3 PASS, 3 FAIL, 1 SKIP
  Full config: tegra_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/arm/tegra_defconfig/gcc-10/la=
b-collabora/baseline-tegra124-nyan-big.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/arm/tegra_defconfig/gcc-10/la=
b-collabora/baseline-tegra124-nyan-big.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63fa55d877f35ba0b08c8664
        failing since 35 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-25T18:39:02.090148  : 139, stack limit =3D 0x(ptrval))

    2023-02-25T18:39:02.099797  kern  :emerg : Stack: (0xee0d9<8>[   18.718=
758] <LAVA_SIGNAL_ENDRUN 0_dmesg 9334682_1.5.2.3.1>

    2023-02-25T18:39:02.101432  f2c to 0xee0da000)

    2023-02-25T18:39:02.109515  kern  :emerg : 9f20:                       =
     c02e8030 00000000 00000000 c026d6dc 00000003

    2023-02-25T18:39:02.117665  kern  :emerg : 9f40: c298b0c0 bee41f74 ee0d=
9f80 00000000 ee0d8000 00000004 00000003 c0270590

    2023-02-25T18:39:02.125750  kern  :emerg : 9f60: edfe5b00 c026d6dc c298=
b0c0 c298b0c0 bee41f74 00000003 c0101264 c02707f4

    2023-02-25T18:39:02.134050  kern  :emerg : 9f80: 00000000 00000000 ee0d=
9fb0 d2d239d3 b6f277c0 00000003 b6f277c0 bee41468

    2023-02-25T18:39:02.142125  kern  :emerg : 9fa0: 00000004 c0101000 0000=
0003 b6f277c0 00000003 bee41f74 00000003 00000000

    2023-02-25T18:39:02.150406  kern  :emerg : 9fc0: 00000003 b6f277c0 bee4=
1468 00000004 00000003 0003c90c bee41e58 00000003

    2023-02-25T18:39:02.158585  kern  :emerg : 9fe0: 00059120 bee41440 b6be=
d960 b6bed97c 60000010 00000003 00000000 00000000
 =

    ... (21 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
zynqmp-zcu102              | arm64  | lab-cip         | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63fa582113ea342bea8c8659

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/arm64/defconfig/gcc-10/lab-ci=
p/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/arm64/defconfig/gcc-10/lab-ci=
p/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63fa582113ea342bea8c8660
        failing since 37 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-25T18:48:53.243532  / # #
    2023-02-25T18:48:53.345450  export SHELL=3D/bin/sh
    2023-02-25T18:48:53.345960  #
    2023-02-25T18:48:53.447288  / # export SHELL=3D/bin/sh. /lava-861472/en=
vironment
    2023-02-25T18:48:53.447823  =

    2023-02-25T18:48:53.549253  / # . /lava-861472/environment/lava-861472/=
bin/lava-test-runner /lava-861472/1
    2023-02-25T18:48:53.549997  =

    2023-02-25T18:48:53.552658  / # /lava-861472/bin/lava-test-runner /lava=
-861472/1
    2023-02-25T18:48:53.589678  + export 'TESTRUN_ID=3D1_bootrr'
    2023-02-25T18:48:53.590277  + cd /lava-861472/1/tests/1_bootrr =

    ... (11 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
zynqmp-zcu102              | arm64  | lab-cip         | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63fa58d519c165d90c8c8695

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63fa58d519c165d90c8c869c
        failing since 37 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-25T18:51:44.526586  / # #
    2023-02-25T18:51:44.628673  export SHELL=3D/bin/sh
    2023-02-25T18:51:44.629156  #
    2023-02-25T18:51:44.730566  / # export SHELL=3D/bin/sh. /lava-861484/en=
vironment
    2023-02-25T18:51:44.731059  =

    2023-02-25T18:51:44.832533  / # . /lava-861484/environment/lava-861484/=
bin/lava-test-runner /lava-861484/1
    2023-02-25T18:51:44.833299  =

    2023-02-25T18:51:44.836301  / # /lava-861484/bin/lava-test-runner /lava=
-861484/1
    2023-02-25T18:51:44.873297  + export 'TESTRUN_ID=3D1_bootrr'
    2023-02-25T18:51:44.873607  + cd /lava-861484/1/tests/1_bootrr =

    ... (11 line(s) more)  =

 =20

