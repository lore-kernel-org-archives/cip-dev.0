Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0162DC6FD1F
	for <webhook@archiver.kernel.org>; Sun, 12 Mar 2023 07:50:12 +0000 (UTC)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
 by mx.groups.io with SMTP id smtpd.web10.62740.1678607403120486314
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 11 Mar 2023 23:50:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=YQ+TLy0l;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.53, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f53.google.com with SMTP id h11-20020a17090a2ecb00b00237c740335cso8857276pjs.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 11 Mar 2023 23:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1678607402;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1B6IqcqtDnFRnWp2iB38REHVymBot55T0RyUbgypTeY=;
        b=YQ+TLy0l6EKZca9nfe6j0f8+2Grd3fR9BQWnXL2sEnY8DeA+Kv7bbBW6aq0lMv+cGS
         NJQQ4/nH4YmkppbNa+qAjKDIJx9gWqcp3GEGGFZ+jIRFBqF94nfkSzzH7gSHUjJQrWVs
         sCJ128eGiesQa/Olomcl2qvmSb3UauP9YpUUc8PFVeRlFXkOzQHFyRzxujAB3kY1hzTq
         QNpojjKloCD/Jg5SkJ8iNlDNhuA2qXAX2FwRpVN6cfUlQKTt92il0UZbhLIdQjEri3FY
         7gMFwA0MznXlRL6WwvsJ7rT2lKtwpdVe64u8+Aj48yzS1LmfOxw29+bT0sbx9oJssUt5
         qC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678607402;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1B6IqcqtDnFRnWp2iB38REHVymBot55T0RyUbgypTeY=;
        b=GVwmgdmpoVzDxA8CGCFyqhG3/ekh29uduFCe2eAydB1SonEko91bhzE1DN1keVeIfS
         nttI9T5DuGlY4ganjMT7uEN745uTQ0DnszeNqiBwFBv2LZXvDTJILWUA7VuFuDOURpzq
         jsBHq4hYw6MoP8lMX3+LDhq/fZm0uhhkNuZxUC0xkVhv9R2zqjf17xqwLvN4iLw8c+ZU
         +Qz8EPAwCIa7RJsLKTpq6GE/ysTCK9gLCMN5nP6zNVoSiUK7KvneJV07nWwd6XjXZ1lU
         r6DoXXhoTcKPhTeAgp1jp3JizIVdv1fd9w7hq9paHNDzj6W7HAHuzH3cxeEVlYyKJHQJ
         RMsQ==
X-Gm-Message-State: AO0yUKWVjOA1cFbtyBEc+6S7acdOz4tLwvhfZ+oZMBDTghUE0NgWdAKT
	0SIKB6On5/qgARyVQQoorxVjCJSKeHtxpSUN+Uo=
X-Google-Smtp-Source: AK7set+Khwt+oYViMX1P+ugjmfFIaImAgTmF0L3Rdd3yGD1fsxfJB/p3of2nznbilAAnkIC3J5i0fQ==
X-Received: by 2002:a05:6a20:8403:b0:cc:76ec:70dc with SMTP id c3-20020a056a20840300b000cc76ec70dcmr38165805pzd.26.1678607401230;
        Sat, 11 Mar 2023 23:50:01 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d17-20020aa78151000000b005a8b4dcd21asm2451486pfn.15.2023.03.11.23.50.00
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 23:50:00 -0800 (PST)
Message-ID: <640d8428.a70a0220.2f036.430c@mx.google.com>
Date: Sat, 11 Mar 2023 23:50:00 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.19.273-cip92-277-g507c8d80b9e20
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 105 runs,
 40 regressions (v4.19.273-cip92-277-g507c8d80b9e20)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 12 Mar 2023 07:50:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10982

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 105 runs, 40 regressio=
ns (v4.19.273-cip92-277-g507c8d80b9e20)

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

beaglebone-black           | arm    | lab-broonie     | gcc-10   | omap2plu=
s_defconfig          | 1          =

imx6q-sabrelite            | arm    | lab-collabora   | gcc-10   | multi_v7=
_defconfig           | 1          =

imx6qp-wandboard-revd1     | arm    | lab-pengutronix | gcc-10   | imx_v6_v=
7_defconfig          | 1          =

imx6qp-wandboard-revd1     | arm    | lab-pengutronix | gcc-10   | multi_v7=
_defconfig           | 1          =

imx7d-sdb                  | arm    | lab-nxp         | gcc-10   | multi_v7=
_defconfig           | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
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
Flinux-4.19.y-cip-rc/kernel/v4.19.273-cip92-277-g507c8d80b9e20/plan/baselin=
e/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.273-cip92-277-g507c8d80b9e20
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      507c8d80b9e20db87bb0fbf5ce478b7f2c81093a =



Test Regressions
---------------- =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus  | x86_64 | lab-collabora   | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/640d7c0f611e5176da8c864e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/640d7c0f611e5176da8c8657
        failing since 51 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-12T07:15:05.656485  + set +x<8>[    9.691003] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 9567964_1.4.2.3.1>

    2023-03-12T07:15:05.656573  =


    2023-03-12T07:15:05.761297  #

    2023-03-12T07:15:05.864208  / # #export SHELL=3D/bin/sh

    2023-03-12T07:15:05.865065  =


    2023-03-12T07:15:05.966833  / # export SHELL=3D/bin/sh. /lava-9567964/e=
nvironment

    2023-03-12T07:15:05.967684  =


    2023-03-12T07:15:06.069433  / # . /lava-9567964/environment/lava-956796=
4/bin/lava-test-runner /lava-9567964/1

    2023-03-12T07:15:06.070679  =


    2023-03-12T07:15:06.072594  / # /lava-9567964/bin/lava-test-runner /lav=
a-9567964/1
 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral   | x86_64 | lab-collabora   | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/640d7c0179fe70d7668c86c1

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/640d7c0179fe70d7668c86ca
        failing since 51 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-12T07:15:03.454868  + set +x

    2023-03-12T07:15:03.461367  <8>[   11.567157] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9567908_1.4.2.3.1>

    2023-03-12T07:15:03.570171  / # #

    2023-03-12T07:15:03.673170  export SHELL=3D/bin/sh

    2023-03-12T07:15:03.673989  #

    2023-03-12T07:15:03.775859  / # export SHELL=3D/bin/sh. /lava-9567908/e=
nvironment

    2023-03-12T07:15:03.776655  =


    2023-03-12T07:15:03.878245  / # . /lava-9567908/environment/lava-956790=
8/bin/lava-test-runner /lava-9567908/1

    2023-03-12T07:15:03.879401  =


    2023-03-12T07:15:03.884541  / # /lava-9567908/bin/lava-test-runner /lav=
a-9567908/1
 =

    ... (13 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
beaglebone-black           | arm    | lab-broonie     | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/640d7c601f26c891128c8685

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm/multi_v7_defconfig/gcc-=
10/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm/multi_v7_defconfig/gcc-=
10/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/640d7c601f26c891128c868e
        failing since 51 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-12T07:16:27.077611  <8>[   16.196112] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 148180_1.5.2.4.1>
    2023-03-12T07:16:27.185210  / # #
    2023-03-12T07:16:27.288341  export SHELL=3D/bin/sh
    2023-03-12T07:16:27.289513  #
    2023-03-12T07:16:27.391637  / # export SHELL=3D/bin/sh. /lava-148180/en=
vironment
    2023-03-12T07:16:27.392606  =

    2023-03-12T07:16:27.495102  / # . /lava-148180/environment/lava-148180/=
bin/lava-test-runner /lava-148180/1
    2023-03-12T07:16:27.496540  =

    2023-03-12T07:16:27.499963  / # /lava-148180/bin/lava-test-runner /lava=
-148180/1
    2023-03-12T07:16:27.568265  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
beaglebone-black           | arm    | lab-cip         | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/640d831939005709478c8643

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm/multi_v7_defconfig/gcc-=
10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm/multi_v7_defconfig/gcc-=
10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/640d831939005709478c864a
        failing since 51 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-12T07:45:08.831703  <8>[    8.922110] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 873122_1.5.2.4.1>
    2023-03-12T07:45:08.944163  / # #
    2023-03-12T07:45:09.046645  export SHELL=3D/bin/sh
    2023-03-12T07:45:09.047401  #
    2023-03-12T07:45:09.149369  / # export SHELL=3D/bin/sh. /lava-873122/en=
vironment
    2023-03-12T07:45:09.150128  =

    2023-03-12T07:45:09.252073  / # . /lava-873122/environment/lava-873122/=
bin/lava-test-runner /lava-873122/1
    2023-03-12T07:45:09.253373  =

    2023-03-12T07:45:09.259865  / # /lava-873122/bin/lava-test-runner /lava=
-873122/1
    2023-03-12T07:45:09.326512  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
beaglebone-black           | arm    | lab-broonie     | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/640d7bed79fe70d7668c863b

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm/omap2plus_defconfig/gcc=
-10/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm/omap2plus_defconfig/gcc=
-10/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/640d7bed79fe70d7668c8644
        new failure (last pass: v4.19.273-cip92-24-g2070ce514972)

    2023-03-12T07:14:29.635491  + set +x<8>[   17.675314] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 148138_1.5.2.4.1>
    2023-03-12T07:14:29.636065  =

    2023-03-12T07:14:29.747945  / # #
    2023-03-12T07:14:29.851634  export SHELL=3D/bin/sh
    2023-03-12T07:14:29.852491  #
    2023-03-12T07:14:29.954459  / # export SHELL=3D/bin/sh. /lava-148138/en=
vironment
    2023-03-12T07:14:29.955162  =

    2023-03-12T07:14:30.056834  / # . /lava-148138/environment/lava-148138/=
bin/lava-test-runner /lava-148138/1
    2023-03-12T07:14:30.057825  =

    2023-03-12T07:14:30.062281  / # /lava-148138/bin/lava-test-runner /lava=
-148138/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx6q-sabrelite            | arm    | lab-collabora   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/640d7ffe3f9f794b838c8641

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm/multi_v7_defconfig/gcc-=
10/lab-collabora/baseline-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm/multi_v7_defconfig/gcc-=
10/lab-collabora/baseline-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/640d7ffe3f9f794b838c864a
        failing since 51 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-12T07:31:59.864827  / # #

    2023-03-12T07:31:59.966063  export SHELL=3D/bin/sh

    2023-03-12T07:31:59.966414  #

    2023-03-12T07:32:00.067435  / # export SHELL=3D/bin/sh. /lava-9567991/e=
nvironment

    2023-03-12T07:32:00.067751  =


    2023-03-12T07:32:00.168733  / # . /lava-9567991/environment/lava-956799=
1/bin/lava-test-runner /lava-9567991/1

    2023-03-12T07:32:00.169200  =


    2023-03-12T07:32:00.176502  / # /lava-9567991/bin/lava-test-runner /lav=
a-9567991/1

    2023-03-12T07:32:00.281381  + export 'TESTRUN_ID=3D1_bootrr'

    2023-03-12T07:32:00.281579  + cd /lava-9567991/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx6qp-wandboard-revd1     | arm    | lab-pengutronix | gcc-10   | imx_v6_v=
7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/640d7bf579fe70d7668c8651

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm/imx_v6_v7_defconfig/gcc=
-10/lab-pengutronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm/imx_v6_v7_defconfig/gcc=
-10/lab-pengutronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/640d7bf579fe70d7668c865a
        failing since 51 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-12T07:14:50.994220  + set +x[    7.084031] <LAVA_SIGNAL_ENDRUN =
0_dmesg 919695_1.5.2.3.1>
    2023-03-12T07:14:50.994388  =

    2023-03-12T07:14:51.101386  / # #
    2023-03-12T07:14:51.202947  export SHELL=3D/bin/sh
    2023-03-12T07:14:51.203425  #
    2023-03-12T07:14:51.304696  / # export SHELL=3D/bin/sh. /lava-919695/en=
vironment
    2023-03-12T07:14:51.305147  =

    2023-03-12T07:14:51.406440  / # . /lava-919695/environment/lava-919695/=
bin/lava-test-runner /lava-919695/1
    2023-03-12T07:14:51.407048  =

    2023-03-12T07:14:51.409981  / # /lava-919695/bin/lava-test-runner /lava=
-919695/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx6qp-wandboard-revd1     | arm    | lab-pengutronix | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/640d7c31c28734078b8c864d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm/multi_v7_defconfig/gcc-=
10/lab-pengutronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm/multi_v7_defconfig/gcc-=
10/lab-pengutronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/640d7c31c28734078b8c8656
        failing since 51 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-12T07:15:49.884610  + set +x
    2023-03-12T07:15:49.884809  [    4.948713] <LAVA_SIGNAL_ENDRUN 0_dmesg =
919696_1.5.2.3.1>
    2023-03-12T07:15:49.991064  / # #
    2023-03-12T07:15:50.092684  export SHELL=3D/bin/sh
    2023-03-12T07:15:50.093264  #
    2023-03-12T07:15:50.194631  / # export SHELL=3D/bin/sh. /lava-919696/en=
vironment
    2023-03-12T07:15:50.195294  =

    2023-03-12T07:15:50.296760  / # . /lava-919696/environment/lava-919696/=
bin/lava-test-runner /lava-919696/1
    2023-03-12T07:15:50.297336  =

    2023-03-12T07:15:50.300068  / # /lava-919696/bin/lava-test-runner /lava=
-919696/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx7d-sdb                  | arm    | lab-nxp         | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/640d7c4b1f26c891128c866f

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm/multi_v7_defconfig/gcc-=
10/lab-nxp/baseline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm/multi_v7_defconfig/gcc-=
10/lab-nxp/baseline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/640d7c4b1f26c891128c8676
        failing since 46 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.270-cip89-39-g43ce130174aa)

    2023-03-12T07:16:00.747305  <8>[   12.943092] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1170924_1.5.2.4.1>
    2023-03-12T07:16:00.852827  / # #
    2023-03-12T07:16:02.013083  export SHELL=3D/bin/sh
    2023-03-12T07:16:02.018773  #
    2023-03-12T07:16:03.566382  / # export SHELL=3D/bin/sh. /lava-1170924/e=
nvironment
    2023-03-12T07:16:03.572057  =

    2023-03-12T07:16:06.394518  / # . /lava-1170924/environment/lava-117092=
4/bin/lava-test-runner /lava-1170924/1
    2023-03-12T07:16:06.400680  =

    2023-03-12T07:16:06.407146  / # /lava-1170924/bin/lava-test-runner /lav=
a-1170924/1
    2023-03-12T07:16:06.508172  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (16 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/640d7e43eede11505c8c863a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm64/defconfig/gcc-10/lab-=
broonie/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm64/defconfig/gcc-10/lab-=
broonie/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640d7e43eede11505c8c8=
63b
        failing since 297 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/640d7e7f63a5b47d618c862f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640d7e7f63a5b47d618c8=
630
        failing since 297 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/640d7e33eede11505c8c8630

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm64/defconfig/gcc-10/lab-=
collabora/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm64/defconfig/gcc-10/lab-=
collabora/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640d7e33eede11505c8c8=
631
        failing since 297 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/640d7e690a185bad138c863d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640d7e690a185bad138c8=
63e
        failing since 297 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/640d7e2f97dd54aa398c86b2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm64/defconfig/gcc-10/lab-=
broonie/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm64/defconfig/gcc-10/lab-=
broonie/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640d7e2f97dd54aa398c8=
6b3
        failing since 297 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/640d7f98f0e89268af8c863d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640d7f98f0e89268af8c8=
63e
        failing since 297 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/640d7e3277cdd002a68c862f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm64/defconfig/gcc-10/lab-=
collabora/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm64/defconfig/gcc-10/lab-=
collabora/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640d7e3277cdd002a68c8=
630
        failing since 297 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/640d7e6a0a185bad138c8641

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640d7e6a0a185bad138c8=
642
        failing since 297 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/640d7e3197dd54aa398c86b8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm64/defconfig/gcc-10/lab-=
broonie/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm64/defconfig/gcc-10/lab-=
broonie/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640d7e3197dd54aa398c8=
6b9
        failing since 297 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/640d7f99340ab91c1b8c8637

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640d7f99340ab91c1b8c8=
638
        failing since 297 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/640d7e2e1a4e3a9b458c865b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm64/defconfig/gcc-10/lab-=
collabora/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm64/defconfig/gcc-10/lab-=
collabora/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640d7e2e1a4e3a9b458c8=
65c
        failing since 297 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/640d7e6b26f7b19efe8c8631

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640d7e6b26f7b19efe8c8=
632
        failing since 297 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/640d7e301a4e3a9b458c8660

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm64/defconfig/gcc-10/lab-=
broonie/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm64/defconfig/gcc-10/lab-=
broonie/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640d7e301a4e3a9b458c8=
661
        failing since 297 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/640d7f97340ab91c1b8c8631

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640d7f97340ab91c1b8c8=
632
        failing since 297 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/640d7e2d97dd54aa398c86ad

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm64/defconfig/gcc-10/lab-=
collabora/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm64/defconfig/gcc-10/lab-=
collabora/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640d7e2d97dd54aa398c8=
6ae
        failing since 297 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/640d7e6e0a185bad138c8646

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640d7e6e0a185bad138c8=
647
        failing since 297 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
r8a7743-iwg20d-q7          | arm    | lab-cip         | gcc-10   | shmobile=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/640d7b3468cdb8b1778c8664

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm/shmobile_defconfig/gcc-=
10/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm/shmobile_defconfig/gcc-=
10/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640d7b3468cdb8b1778c8=
665
        failing since 8 days (last pass: v4.19.273-cip92-14-ga8d1f73f2a28, =
first fail: v4.19.273-cip92-24-g2070ce514972) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
rk3288-veyron-jaq          | arm    | lab-collabora   | gcc-10   | multi_v7=
_defconfig           | 3          =


  Details:     https://kernelci.org/test/plan/id/640d7c2701896985408c8650

  Results:     61 PASS, 8 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm/multi_v7_defconfig/gcc-=
10/lab-collabora/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm/multi_v7_defconfig/gcc-=
10/lab-collabora/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/640d7c2701896985408c8684
        failing since 50 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-12T07:15:19.581680  BusyBox v1.31.1 (2023-03-03 12:54:59 UTC)<8=
>[   10.476997] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-03-12T07:15:19.583338   multi-call binary.

    2023-03-12T07:15:19.583563  =


    2023-03-12T07:15:19.587644  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-03-12T07:15:19.588144  =


    2023-03-12T07:15:19.592966  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/640d7c2701896985408c8685
        failing since 50 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-12T07:15:19.563040  <8>[   10.459764] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/640d7c2701896985408c8698
        failing since 50 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-12T07:15:15.735029  + <8>[    6.635590] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 9567996_1.5.2.3.1>

    2023-03-12T07:15:15.738339  set +x

    2023-03-12T07:15:15.843826  #

    2023-03-12T07:15:15.947859  / # #export SHELL=3D/bin/sh

    2023-03-12T07:15:15.948955  =


    2023-03-12T07:15:16.051837  / # export SHELL=3D/bin/sh. /lava-9567996/e=
nvironment

    2023-03-12T07:15:16.052621  =


    2023-03-12T07:15:16.154419  / # . /lava-9567996/environment/lava-956799=
6/bin/lava-test-runner /lava-9567996/1

    2023-03-12T07:15:16.156357  =


    2023-03-12T07:15:16.158055  / # /lava-9567996/bin/lava-test-runner /lav=
a-9567996/1
 =

    ... (16 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
rk3399-gru-kevin           | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 5          =


  Details:     https://kernelci.org/test/plan/id/640d7d918c7c8193608c8651

  Results:     79 PASS, 9 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/case/id=
/640d7d918c7c8193608c8677
        failing since 363 days (last pass: v4.19.229-cip67-111-g5c3c0b39cf3=
b, first fail: v4.19.231-cip68-123-g92e3e7f3d4df)

    2023-03-12T07:21:34.543620  /lava-9568081/1/../bin/lava-test-case

    2023-03-12T07:21:34.552215  <8>[   35.895854] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rk3399-gru-sound-driver-rt5514-present: https://kernelc=
i.org/test/case/id/640d7d918c7c8193608c868c
        failing since 51 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-12T07:21:33.067635  BusyBox v1.31.1 (2023-03-03 <8>[   34.40684=
1] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Drk3399-gru-sound-driver-max98357A-p=
resent RESULT=3Dfail>

    2023-03-12T07:21:33.070210  12:31:33 UTC) multi-call binary.

    2023-03-12T07:21:33.070744  =


    2023-03-12T07:21:33.075721  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-03-12T07:21:33.075806  =


    2023-03-12T07:21:33.089773  Print numbers from FIRST to LAST, in steps =
of<8>[   34.429342] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Drk3399-gru-sound-d=
river-rt5514-present RESULT=3Dfail>
   =


  * baseline.bootrr.rk3399-gru-sound-driver-max98357A-present: https://kern=
elci.org/test/case/id/640d7d918c7c8193608c868d
        failing since 51 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-12T07:21:33.047285  -w	Pad to last with leading zeros

    2023-03-12T07:21:33.050387  	-s SEP	String separator

    2023-03-12T07:21:33.054179  /lava-9568081/1/../bin/lava-test-case
   =


  * baseline.bootrr.rk3399-gru-sound-driver-dp-present: https://kernelci.or=
g/test/case/id/640d7d918c7c8193608c868e
        failing since 51 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-12T07:21:33.022558  <8>[   34.361129] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-da7219-present RESULT=3Dfail>

    2023-03-12T07:21:33.026930  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-03-12T07:21:33.027016  =


    2023-03-12T07:21:33.031413  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-03-12T07:21:33.033923  FIRST, INC default to 1.

    2023-03-12T07:21:33.034184  =


    2023-03-12T07:21:33.044255  	<8>[   34.384011] <LAVA_SIGNAL_TESTCASE TE=
ST_CASE_ID=3Drk3399-gru-sound-driver-dp-present RESULT=3Dfail>
   =


  * baseline.bootrr.rk3399-gru-sound-driver-da7219-present: https://kernelc=
i.org/test/case/id/640d7d918c7c8193608c868f
        failing since 51 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-12T07:21:33.011074  BusyBox v1.31.1 (2023-03-03 12:31:33 UTC) m=
ulti-call binary.

    2023-03-12T07:21:33.011363  =

   =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus     | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/640d7d3f66f9cfe8338c8666

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm64/defconfig/gcc-10/lab-=
broonie/baseline-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm64/defconfig/gcc-10/lab-=
broonie/baseline-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/640d7d3f66f9cfe8338c866f
        failing since 51 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-12T07:20:09.877208  <8>[   15.967996] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 148203_1.5.2.4.1>
    2023-03-12T07:20:09.983442  / # #
    2023-03-12T07:20:10.085972  export SHELL=3D/bin/sh
    2023-03-12T07:20:10.086533  #
    2023-03-12T07:20:10.188106  / # export SHELL=3D/bin/sh. /lava-148203/en=
vironment
    2023-03-12T07:20:10.188753  =

    2023-03-12T07:20:10.290323  / # . /lava-148203/environment/lava-148203/=
bin/lava-test-runner /lava-148203/1
    2023-03-12T07:20:10.291299  =

    2023-03-12T07:20:10.295227  / # /lava-148203/bin/lava-test-runner /lava=
-148203/1
    2023-03-12T07:20:10.327150  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64         | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/640d7d51d945e1db928c8636

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm64/defconfig/gcc-10/lab-=
collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm64/defconfig/gcc-10/lab-=
collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/640d7d51d945e1db928c863f
        failing since 51 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-12T07:20:24.917840  / # #

    2023-03-12T07:20:25.020869  export SHELL=3D/bin/sh

    2023-03-12T07:20:25.021683  #

    2023-03-12T07:20:25.123735  / # export SHELL=3D/bin/sh. /lava-9568060/e=
nvironment

    2023-03-12T07:20:25.124142  =


    2023-03-12T07:20:25.225980  / # . /lava-9568060/environment/lava-956806=
0/bin/lava-test-runner /lava-9568060/1

    2023-03-12T07:20:25.227226  =


    2023-03-12T07:20:25.238217  / # /lava-9568060/bin/lava-test-runner /lav=
a-9568060/1

    2023-03-12T07:20:25.302707  + export 'TESTRUN_ID=3D1_bootrr'

    2023-03-12T07:20:25.303295  + cd /lava-9568060<8>[   15.638460] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 9568060_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
tegra124-nyan-big          | arm    | lab-collabora   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/640d7c25149a611a5f8c863e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm/multi_v7_defconfig/gcc-=
10/lab-collabora/baseline-tegra124-nyan-big.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm/multi_v7_defconfig/gcc-=
10/lab-collabora/baseline-tegra124-nyan-big.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/640d7c25149a611a5f8c8647
        failing since 50 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-12T07:15:40.098289  <8>[   18.013960] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-03-12T07:15:40.102761  + set +x

    2023-03-12T07:15:40.110006  <8>[   18.027294] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9567995_1.5.2.3.1>

    2023-03-12T07:15:40.219405  #

    2023-03-12T07:15:40.220535  =


    2023-03-12T07:15:40.322402  / # #export SHELL=3D/bin/sh

    2023-03-12T07:15:40.322890  =


    2023-03-12T07:15:40.424296  / # export SHELL=3D/bin/sh. /lava-9567995/e=
nvironment

    2023-03-12T07:15:40.424889  =


    2023-03-12T07:15:40.526621  / # . /lava-9567995/environment/lava-956799=
5/bin/lava-test-runner /lava-9567995/1
 =

    ... (14 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
tegra124-nyan-big          | arm    | lab-collabora   | gcc-10   | tegra_de=
fconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/640d7b4768cdb8b1778c8672

  Results:     3 PASS, 3 FAIL, 1 SKIP
  Full config: tegra_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm/tegra_defconfig/gcc-10/=
lab-collabora/baseline-tegra124-nyan-big.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm/tegra_defconfig/gcc-10/=
lab-collabora/baseline-tegra124-nyan-big.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/640d7b4768cdb8b1778c867b
        failing since 50 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-12T07:11:48.516441  kern  :emerg : Process udevadm (pid<8>[   1=
8.674209] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Demerg RESULT=3Dfail UNITS=3D=
lines MEASUREMENT=3D11>

    2023-03-12T07:11:48.520089  : 141, stack limit =3D 0x(ptrval))

    2023-03-12T07:11:48.528668  kern  :emerg :<8>[   18.688255] <LAVA_SIGNA=
L_ENDRUN 0_dmesg 9567860_1.5.2.3.1>

    2023-03-12T07:11:48.530092   Stack: (0xc2c75f2c to 0xc2c76000)

    2023-03-12T07:11:48.538319  kern  :emerg : 5f20:                       =
     c02e8180 00000000 00000000 c026d82c 00000003

    2023-03-12T07:11:48.546394  kern  :emerg : 5f40: c2bee900 bebbbf74 c2c7=
5f80 00000000 c2c74000 00000004 00000003 c02706e0

    2023-03-12T07:11:48.554626  kern  :emerg : 5f60: edfe8048 c026d82c c2be=
e900 c2bee900 bebbbf74 00000003 c0101264 c0270944

    2023-03-12T07:11:48.562763  kern  :emerg : 5f80: 00000000 00000000 c2c7=
5fb0 9ce979d2 b6f417c0 00000003 b6f417c0 bebbb468

    2023-03-12T07:11:48.570651  kern  :emerg : 5fa0: 00000004 c0101000 0000=
0003 b6f417c0 00000003 bebbbf74 00000003 00000000

    2023-03-12T07:11:48.579040  kern  :emerg : 5fc0: 00000003 b6f417c0 bebb=
b468 00000004 00000003 0003c90c bebbbe58 00000003
 =

    ... (23 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
zynqmp-zcu102              | arm64  | lab-cip         | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/640d7d1f9061d0d2e58c867c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm64/defconfig/gcc-10/lab-=
cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm64/defconfig/gcc-10/lab-=
cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/640d7d1f9061d0d2e58c8683
        failing since 51 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-12T07:19:46.489901  + set +x
    2023-03-12T07:19:46.490951  <8>[    3.755286] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 873129_1.5.2.4.1>
    2023-03-12T07:19:46.593710  / # #
    2023-03-12T07:19:46.694977  export SHELL=3D/bin/sh
    2023-03-12T07:19:46.695221  #
    2023-03-12T07:19:46.796190  / # export SHELL=3D/bin/sh. /lava-873129/en=
vironment
    2023-03-12T07:19:46.796425  =

    2023-03-12T07:19:46.897401  / # . /lava-873129/environment/lava-873129/=
bin/lava-test-runner /lava-873129/1
    2023-03-12T07:19:46.897786  =

    2023-03-12T07:19:46.899851  / # /lava-873129/bin/lava-test-runner /lava=
-873129/1 =

    ... (13 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
zynqmp-zcu102              | arm64  | lab-cip         | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/640d7d708c7c8193608c8637

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/640d7d708c7c8193608c863e
        failing since 51 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-12T07:20:59.471667  <8>[    3.769107] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 873155_1.5.2.4.1>
    2023-03-12T07:20:59.577714  / # #
    2023-03-12T07:20:59.680081  export SHELL=3D/bin/sh
    2023-03-12T07:20:59.680912  #
    2023-03-12T07:20:59.782546  / # export SHELL=3D/bin/sh. /lava-873155/en=
vironment
    2023-03-12T07:20:59.783220  =

    2023-03-12T07:20:59.884861  / # . /lava-873155/environment/lava-873155/=
bin/lava-test-runner /lava-873155/1
    2023-03-12T07:20:59.885560  =

    2023-03-12T07:20:59.888100  / # /lava-873155/bin/lava-test-runner /lava=
-873155/1
    2023-03-12T07:20:59.925386  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =20

