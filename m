Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8C2CD98E8
	for <webhook@archiver.kernel.org>; Wed, 11 Oct 2023 02:21:08 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web10.8193.1696990862180037099
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 10 Oct 2023 19:21:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=uyL+i2va;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.179, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1c735473d1aso44116795ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 10 Oct 2023 19:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696990861; x=1697595661; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7xRpRNyOXevW1HpPMV7KveRhRNBW30/prSYw1ukZ2RI=;
        b=uyL+i2vaD2xX1u8DcWYEwGfhnCk8o1qqVgc7NQVc334387xdXF1P+HqzXMkSljJSZw
         /mPWlor20j43g8KCosj8ra47v5i0kH3xQeF8+RYHWklUMlVUF9X678fCqHGQlL64Llzl
         qUrzQOcbvu8LFgtVHV5TQlkMvsQUpbLAfIeKKRZcsw7LaDS0dJxYglmpiQcvLyjUwPJ/
         z8dq5dHQWhe4xcOlgCUNZiASs+UqT1/IvzHE3eQjqChTUYHWjh4sbmQ14SI8DPl5Z0rC
         1iHgz2so+jJgyl/ZtfHrTHm9VMrcmkKbFj9/s2YUN2HndmEexI//qxP4WQotX1LESSag
         brTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696990861; x=1697595661;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7xRpRNyOXevW1HpPMV7KveRhRNBW30/prSYw1ukZ2RI=;
        b=qCzk+h2EyF/hEI13RBFoGRuviv/OHUMWweZUXlC3xWeYS/KJSV/NcF1KEiVMICJ2e6
         /mHrFdEt9tr9W+queZTsvH7vWw1hx3UDoV4ZgnFfwLsu/LahCACadCPO3Pm/YBAsDRYV
         d95x0v10RXshkvP9anry0ArIm+lAcIGpbSCzYxELfOkml4+C6CCx8EubAHS7zi91U5ow
         lfxigB4FQjJAo2MH+rKGTXRU96iT4RW8XXtkgqUXLBCmtjGei/3HUB9/38fhWthAsyu0
         k8MYq24b/ZYuFa+BwBi5MQsB93diKMf+gDBjo1m+5smOL3qEleyQhn3CDrqfzbC0wPo+
         WxEw==
X-Gm-Message-State: AOJu0YwCLZ6nmFMzesSsSrRpGntSZWd3BedcV2aWRi8fIQUZsN7JN5r0
	6kPFXdmnwE684K6J+tzdFnadYCGAit7i+AI2Ajgjdg==
X-Google-Smtp-Source: AGHT+IEFTaU9ZXa8lS6R0UQCd+iCA+em1fdQWsGXgQmnFfrdyB8Q5VX61sN77ZHR6OjgOk1yRhaWpg==
X-Received: by 2002:a17:902:cec7:b0:1c9:9144:574b with SMTP id d7-20020a170902cec700b001c99144574bmr7220139plg.49.1696990859917;
        Tue, 10 Oct 2023 19:20:59 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ja2-20020a170902efc200b001c737950e4dsm747219plb.2.2023.10.10.19.20.58
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 19:20:59 -0700 (PDT)
Message-ID: <6526068b.170a0220.19e5c.5222@mx.google.com>
Date: Tue, 10 Oct 2023 19:20:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.19.295-cip103-95-ge42cfc8bb88b7
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 110 runs,
 37 regressions (v4.19.295-cip103-95-ge42cfc8bb88b7)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Oct 2023 02:21:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13385

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 110 runs, 37 regressio=
ns (v4.19.295-cip103-95-ge42cfc8bb88b7)

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

at91sam9g20ek              | arm    | lab-broonie     | gcc-10   | multi_v5=
_defconfig           | 1          =

beaglebone-black           | arm    | lab-broonie     | gcc-10   | multi_v7=
_defconfig           | 1          =

dove-cubox                 | arm    | lab-pengutronix | gcc-10   | mvebu_v7=
_defconfig           | 1          =

imx6q-sabrelite            | arm    | lab-collabora   | gcc-10   | multi_v7=
_defconfig           | 1          =

imx6qp-wandboard-revd1     | arm    | lab-pengutronix | gcc-10   | imx_v6_v=
7_defconfig          | 1          =

imx6qp-wandboard-revd1     | arm    | lab-pengutronix | gcc-10   | multi_v7=
_defconfig           | 1          =

imx6ul-14x14-evk           | arm    | lab-nxp         | gcc-10   | multi_v7=
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

r8a7796-m3ulcb             | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =

rk3288-veyron-jaq          | arm    | lab-collabora   | gcc-10   | multi_v7=
_defconfig           | 3          =

rk3399-gru-kevin           | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

sun50i-a64-pine64-plus     | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64         | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =

zynqmp-zcu102              | arm64  | lab-cip         | gcc-10   | defconfi=
g                    | 1          =

zynqmp-zcu102              | arm64  | lab-cip         | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.295-cip103-95-ge42cfc8bb88b7/plan/baselin=
e/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.295-cip103-95-ge42cfc8bb88b7
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      e42cfc8bb88b7ac345bd44cd4a1eb3cae3dea954 =



Test Regressions
---------------- =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus  | x86_64 | lab-collabora   | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6525ff36dde16d526befcefc

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525ff36dde16d526befcf05
        failing since 264 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-10-11T01:49:28.305940  <8>[    9.700106] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11733020_1.4.2.3.1>

    2023-10-11T01:49:28.309426  + set +x

    2023-10-11T01:49:28.415029  #

    2023-10-11T01:49:28.416298  =


    2023-10-11T01:49:28.518084  / # #export SHELL=3D/bin/sh

    2023-10-11T01:49:28.518911  =


    2023-10-11T01:49:28.620349  / # export SHELL=3D/bin/sh. /lava-11733020/=
environment

    2023-10-11T01:49:28.621298  =


    2023-10-11T01:49:28.722851  / # . /lava-11733020/environment/lava-11733=
020/bin/lava-test-runner /lava-11733020/1

    2023-10-11T01:49:28.724136  =

 =

    ... (13 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral   | x86_64 | lab-collabora   | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6525ff49d3c38362bbefcf16

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525ff49d3c38362bbefcf1f
        failing since 264 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-10-11T01:51:14.272497  + set +x

    2023-10-11T01:51:14.279350  <8>[   11.632253] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11733070_1.4.2.3.1>

    2023-10-11T01:51:14.383488  / # #

    2023-10-11T01:51:14.484147  export SHELL=3D/bin/sh

    2023-10-11T01:51:14.484336  #

    2023-10-11T01:51:14.584843  / # export SHELL=3D/bin/sh. /lava-11733070/=
environment

    2023-10-11T01:51:14.585025  =


    2023-10-11T01:51:14.685531  / # . /lava-11733070/environment/lava-11733=
070/bin/lava-test-runner /lava-11733070/1

    2023-10-11T01:51:14.685834  =


    2023-10-11T01:51:14.691003  / # /lava-11733070/bin/lava-test-runner /la=
va-11733070/1
 =

    ... (13 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
at91sam9g20ek              | arm    | lab-broonie     | gcc-10   | multi_v5=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65260048222714a587efcf25

  Results:     42 PASS, 9 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm/multi_v5_defconfig/gcc-=
10/lab-broonie/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm/multi_v5_defconfig/gcc-=
10/lab-broonie/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65260048222714a587efcf5a
        failing since 17 days (last pass: v4.19.292-cip102-130-g18b86407034=
5b, first fail: v4.19.292-cip102-406-g9efaa60a8cb4)

    2023-10-11T01:53:36.202795  + set +x
    2023-10-11T01:53:36.203277  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 163793_1.5.2=
.4.1>
    2023-10-11T01:53:36.316176  / # #
    2023-10-11T01:53:36.419332  export SHELL=3D/bin/sh
    2023-10-11T01:53:36.420130  #
    2023-10-11T01:53:36.522089  / # export SHELL=3D/bin/sh. /lava-163793/en=
vironment
    2023-10-11T01:53:36.522892  =

    2023-10-11T01:53:36.624864  / # . /lava-163793/environment/lava-163793/=
bin/lava-test-runner /lava-163793/1
    2023-10-11T01:53:36.626284  =

    2023-10-11T01:53:36.629805  / # /lava-163793/bin/lava-test-runner /lava=
-163793/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
beaglebone-black           | arm    | lab-broonie     | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6526003669313fbbabefcf0f

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm/multi_v7_defconfig/gcc-=
10/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm/multi_v7_defconfig/gcc-=
10/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6526003669313fbbabefcf39
        failing since 264 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-10-11T01:53:06.926925  <8>[   20.745427] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 163782_1.5.2.4.1>
    2023-10-11T01:53:07.036685  / # #
    2023-10-11T01:53:07.139619  export SHELL=3D/bin/sh
    2023-10-11T01:53:07.140349  #
    2023-10-11T01:53:07.242676  / # export SHELL=3D/bin/sh. /lava-163782/en=
vironment
    2023-10-11T01:53:07.243389  =

    2023-10-11T01:53:07.345734  / # . /lava-163782/environment/lava-163782/=
bin/lava-test-runner /lava-163782/1
    2023-10-11T01:53:07.346877  =

    2023-10-11T01:53:07.351170  / # /lava-163782/bin/lava-test-runner /lava=
-163782/1
    2023-10-11T01:53:07.419663  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
dove-cubox                 | arm    | lab-pengutronix | gcc-10   | mvebu_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6525fe66a60e5355a5efcef3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: mvebu_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm/mvebu_v7_defconfig/gcc-=
10/lab-pengutronix/baseline-dove-cubox.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm/mvebu_v7_defconfig/gcc-=
10/lab-pengutronix/baseline-dove-cubox.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525fe66a60e5355a5efcefc
        failing since 264 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-10-11T01:45:56.585093  + set +x
    2023-10-11T01:45:56.585305  [    4.230090] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1003044_1.5.2.3.1>
    2023-10-11T01:45:56.691641  / # #
    2023-10-11T01:45:56.794655  export SHELL=3D/bin/sh
    2023-10-11T01:45:56.795163  #
    2023-10-11T01:45:56.896533  / # export SHELL=3D/bin/sh. /lava-1003044/e=
nvironment
    2023-10-11T01:45:56.897036  =

    2023-10-11T01:45:56.998480  / # . /lava-1003044/environment/lava-100304=
4/bin/lava-test-runner /lava-1003044/1
    2023-10-11T01:45:56.999234  =

    2023-10-11T01:45:57.001938  / # /lava-1003044/bin/lava-test-runner /lav=
a-1003044/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx6q-sabrelite            | arm    | lab-collabora   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6525ffc1fe732b5a78efcf06

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm/multi_v7_defconfig/gcc-=
10/lab-collabora/baseline-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm/multi_v7_defconfig/gcc-=
10/lab-collabora/baseline-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525ffc1fe732b5a78efcf0f
        failing since 264 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-10-11T01:54:11.546454  / # #

    2023-10-11T01:54:11.648534  export SHELL=3D/bin/sh

    2023-10-11T01:54:11.649271  #

    2023-10-11T01:54:11.750475  / # export SHELL=3D/bin/sh. /lava-11733167/=
environment

    2023-10-11T01:54:11.750679  =


    2023-10-11T01:54:11.851210  / # . /lava-11733167/environment/lava-11733=
167/bin/lava-test-runner /lava-11733167/1

    2023-10-11T01:54:11.851434  =


    2023-10-11T01:54:11.854873  / # /lava-11733167/bin/lava-test-runner /la=
va-11733167/1

    2023-10-11T01:54:11.919006  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-11T01:54:11.970782  + cd /lava-11733167/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx6qp-wandboard-revd1     | arm    | lab-pengutronix | gcc-10   | imx_v6_v=
7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6525ffbb67840e6c8befcf00

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm/imx_v6_v7_defconfig/gcc=
-10/lab-pengutronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm/imx_v6_v7_defconfig/gcc=
-10/lab-pengutronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525ffbb67840e6c8befcf09
        failing since 264 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-10-11T01:51:42.227002  + set +x[    7.258588] <LAVA_SIGNAL_ENDRUN =
0_dmesg 1003053_1.5.2.3.1>
    2023-10-11T01:51:42.227175  =

    2023-10-11T01:51:42.334192  / # #
    2023-10-11T01:51:42.436023  export SHELL=3D/bin/sh
    2023-10-11T01:51:42.436613  #
    2023-10-11T01:51:42.538035  / # export SHELL=3D/bin/sh. /lava-1003053/e=
nvironment
    2023-10-11T01:51:42.538560  =

    2023-10-11T01:51:42.639937  / # . /lava-1003053/environment/lava-100305=
3/bin/lava-test-runner /lava-1003053/1
    2023-10-11T01:51:42.640664  =

    2023-10-11T01:51:42.643242  / # /lava-1003053/bin/lava-test-runner /lav=
a-1003053/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx6qp-wandboard-revd1     | arm    | lab-pengutronix | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6525ff7f36335e5ce1efcf0d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm/multi_v7_defconfig/gcc-=
10/lab-pengutronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm/multi_v7_defconfig/gcc-=
10/lab-pengutronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525ff7f36335e5ce1efcf16
        failing since 264 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-10-11T01:50:42.328953  + set +x
    2023-10-11T01:50:42.329180  [    4.925637] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1003050_1.5.2.3.1>
    2023-10-11T01:50:42.435681  / # #
    2023-10-11T01:50:42.537796  export SHELL=3D/bin/sh
    2023-10-11T01:50:42.538370  #
    2023-10-11T01:50:42.639843  / # export SHELL=3D/bin/sh. /lava-1003050/e=
nvironment
    2023-10-11T01:50:42.640378  =

    2023-10-11T01:50:42.741756  / # . /lava-1003050/environment/lava-100305=
0/bin/lava-test-runner /lava-1003050/1
    2023-10-11T01:50:42.742340  =

    2023-10-11T01:50:42.744645  / # /lava-1003050/bin/lava-test-runner /lav=
a-1003050/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx6ul-14x14-evk           | arm    | lab-nxp         | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6525ffc9718ea130a1efcef4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm/multi_v7_defconfig/gcc-=
10/lab-nxp/baseline-imx6ul-14x14-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm/multi_v7_defconfig/gcc-=
10/lab-nxp/baseline-imx6ul-14x14-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525ffc9718ea130a1efcefb
        failing since 173 days (last pass: v4.19.259-cip82-57-ge54228ee5a88=
d, first fail: v4.19.280-cip96-59-g4b02e7efb967d)

    2023-10-11T01:51:44.585858  + set +x
    2023-10-11T01:51:44.589014  <8>[   22.846734] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1254108_1.5.2.4.1>
    2023-10-11T01:51:44.698580  / # #
    2023-10-11T01:51:45.854358  export SHELL=3D/bin/sh
    2023-10-11T01:51:45.859991  #
    2023-10-11T01:51:47.402098  / # export SHELL=3D/bin/sh. /lava-1254108/e=
nvironment
    2023-10-11T01:51:47.407754  =

    2023-10-11T01:51:50.219483  / # . /lava-1254108/environment/lava-125410=
8/bin/lava-test-runner /lava-1254108/1
    2023-10-11T01:51:50.225537  =

    2023-10-11T01:51:50.227163  / # /lava-1254108/bin/lava-test-runner /lav=
a-1254108/1 =

    ... (15 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx7d-sdb                  | arm    | lab-nxp         | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6525ffb79412fc8470efcf70

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm/multi_v7_defconfig/gcc-=
10/lab-nxp/baseline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm/multi_v7_defconfig/gcc-=
10/lab-nxp/baseline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525ffb79412fc8470efcf77
        failing since 259 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.270-cip89-39-g43ce130174aa)

    2023-10-11T01:51:29.016075  / # #
    2023-10-11T01:51:30.171992  export SHELL=3D/bin/sh
    2023-10-11T01:51:30.177618  #
    2023-10-11T01:51:31.719590  / # export SHELL=3D/bin/sh. /lava-1254107/e=
nvironment
    2023-10-11T01:51:31.725257  =

    2023-10-11T01:51:31.725539  / # . /lava-1254107/environment
    2023-10-11T01:51:34.537401  / # /lava-1254107/bin/lava-test-runner /lav=
a-1254107/1
    2023-10-11T01:51:34.554331  /lava-1254107/bin/lava-test-runner /lava-12=
54107/1
    2023-10-11T01:51:34.650089  + export 'TESTRUN_ID=3D1_bootrr'
    2023-10-11T01:51:34.650482  + cd /lava-1254107/1/tests/1_bootrr =

    ... (16 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/652602a404a0cda36befcf37

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm64/defconfig/gcc-10/lab-=
broonie/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm64/defconfig/gcc-10/lab-=
broonie/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/652602a404a0cda36befc=
f38
        failing since 510 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6526032fcb39b10dc6efcf86

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6526032fcb39b10dc6efc=
f87
        failing since 510 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/652601009e21a629f1efcef5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm64/defconfig/gcc-10/lab-=
collabora/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm64/defconfig/gcc-10/lab-=
collabora/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/652601009e21a629f1efc=
ef6
        failing since 510 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6526027d4144b0b511efcf02

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6526027d4144b0b511efc=
f03
        failing since 510 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6526027cb6cc992ce1efcf32

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm64/defconfig/gcc-10/lab-=
broonie/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm64/defconfig/gcc-10/lab-=
broonie/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6526027cb6cc992ce1efc=
f33
        failing since 510 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6526031ccb39b10dc6efcf30

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6526031ccb39b10dc6efc=
f31
        failing since 510 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/652600a5fbc9862d4cefcef6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm64/defconfig/gcc-10/lab-=
collabora/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm64/defconfig/gcc-10/lab-=
collabora/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/652600a5fbc9862d4cefc=
ef7
        failing since 510 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/65260101037f8c939defcf9a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65260101037f8c939defc=
f9b
        failing since 510 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/652601c792ebf58676efcffc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm64/defconfig/gcc-10/lab-=
broonie/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm64/defconfig/gcc-10/lab-=
broonie/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/652601c792ebf58676efc=
ffd
        failing since 510 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6526031ecb39b10dc6efcf36

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6526031ecb39b10dc6efc=
f37
        failing since 510 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6526009cc2adc847f1efcef5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm64/defconfig/gcc-10/lab-=
collabora/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm64/defconfig/gcc-10/lab-=
collabora/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6526009cc2adc847f1efc=
ef6
        failing since 510 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/652602227130ee3fe2efcf22

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/652602227130ee3fe2efc=
f23
        failing since 510 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/652601b6d177f8fdadefcf33

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm64/defconfig/gcc-10/lab-=
broonie/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm64/defconfig/gcc-10/lab-=
broonie/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/652601b6d177f8fdadefc=
f34
        failing since 510 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/652603e6701076f14aefcef3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/652603e6701076f14aefc=
ef4
        failing since 510 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6526008831855fcba2efcf04

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm64/defconfig/gcc-10/lab-=
collabora/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm64/defconfig/gcc-10/lab-=
collabora/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6526008831855fcba2efc=
f05
        failing since 510 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6526027e182aa75081efcf14

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6526027e182aa75081efc=
f15
        failing since 510 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
r8a7743-iwg20d-q7          | arm    | lab-cip         | gcc-10   | shmobile=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/652600c8037f8c939defcf64

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm/shmobile_defconfig/gcc-=
10/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm/shmobile_defconfig/gcc-=
10/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/652600c8037f8c939defc=
f65
        failing since 103 days (last pass: v4.19.284-cip99-114-g02e97826987=
bf, first fail: v4.19.287-cip100-43-g1a6518aa81690) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
r8a7796-m3ulcb             | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6525ff74732d4137feefcf51

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm64/defconfig/gcc-10/lab-=
collabora/baseline-r8a7796-m3ulcb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm64/defconfig/gcc-10/lab-=
collabora/baseline-r8a7796-m3ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525ff74732d4137feefcf5a
        failing since 264 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-10-11T01:54:57.781521  / # #

    2023-10-11T01:54:57.881897  export SHELL=3D/bin/sh

    2023-10-11T01:54:57.882013  #

    2023-10-11T01:54:57.982444  / # export SHELL=3D/bin/sh. /lava-11733123/=
environment

    2023-10-11T01:54:57.982548  =


    2023-10-11T01:54:58.082955  / # . /lava-11733123/environment/lava-11733=
123/bin/lava-test-runner /lava-11733123/1

    2023-10-11T01:54:58.083110  =


    2023-10-11T01:54:58.094963  / # /lava-11733123/bin/lava-test-runner /la=
va-11733123/1

    2023-10-11T01:54:58.149002  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-11T01:54:58.149086  + cd /lav<8>[    7.993329] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11733123_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
rk3288-veyron-jaq          | arm    | lab-collabora   | gcc-10   | multi_v7=
_defconfig           | 3          =


  Details:     https://kernelci.org/test/plan/id/6525ffaf9412fc8470efcf16

  Results:     61 PASS, 8 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm/multi_v7_defconfig/gcc-=
10/lab-collabora/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm/multi_v7_defconfig/gcc-=
10/lab-collabora/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/6525ffaf9412fc8470efcf4a
        failing since 263 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-10-11T01:55:53.378596  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC)<8=
>[   12.785214] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-10-11T01:55:53.382067   multi-call binary.

    2023-10-11T01:55:53.382290  =

   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/6525ffaf9412fc8470efcf4b
        failing since 263 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-10-11T01:55:53.359785  /lava-11733161/1/../bin/lava-test-case<8>[ =
  12.767827] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-probed RE=
SULT=3Dpass>

    2023-10-11T01:55:53.359835  =

   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525ffaf9412fc8470efcf5e
        failing since 263 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-10-11T01:55:49.535951  + <8>[    8.946602] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11733161_1.5.2.3.1>

    2023-10-11T01:55:49.538335  set +x

    2023-10-11T01:55:49.642973  =


    2023-10-11T01:55:49.744535  / # #export SHELL=3D/bin/sh

    2023-10-11T01:55:49.745226  =


    2023-10-11T01:55:49.846496  / # export SHELL=3D/bin/sh. /lava-11733161/=
environment

    2023-10-11T01:55:49.847180  =


    2023-10-11T01:55:49.948521  / # . /lava-11733161/environment/lava-11733=
161/bin/lava-test-runner /lava-11733161/1

    2023-10-11T01:55:49.949632  =


    2023-10-11T01:55:49.951068  / # /lava-11733161/bin/lava-test-runner /la=
va-11733161/1
 =

    ... (16 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
rk3399-gru-kevin           | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6525ffb379eaa71593efcf24

  Results:     77 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/6525ffb379eaa71593efcf2e
        failing since 210 days (last pass: v4.19.273-cip92-277-g507c8d80b9e=
20, first fail: v4.19.276-cip93-5-g2eb2a953ab59)

    2023-10-11T01:51:34.698524  /lava-11733136/1/../bin/lava-test-case<8>[ =
  36.346997] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Drockchip-usb2phy0-probed =
RESULT=3Dfail>

    2023-10-11T01:51:34.698628  =


    2023-10-11T01:51:35.714267  /lava-11733136/1/../bin/lava-test-case

    2023-10-11T01:51:35.723143  <8>[   37.371740] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/6525ffb379eaa71593efcf2f
        failing since 210 days (last pass: v4.19.273-cip92-277-g507c8d80b9e=
20, first fail: v4.19.276-cip93-5-g2eb2a953ab59) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus     | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6526009451c351eeafefcf04

  Results:     23 PASS, 16 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm64/defconfig/gcc-10/lab-=
broonie/baseline-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm64/defconfig/gcc-10/lab-=
broonie/baseline-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6526009451c351eeafefcf2e
        failing since 264 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-10-11T01:54:38.182608  <8>[   16.001848] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 163738_1.5.2.4.1>
    2023-10-11T01:54:38.288409  / # #
    2023-10-11T01:54:38.390964  export SHELL=3D/bin/sh
    2023-10-11T01:54:38.391634  #
    2023-10-11T01:54:38.493143  / # export SHELL=3D/bin/sh. /lava-163738/en=
vironment
    2023-10-11T01:54:38.493734  =

    2023-10-11T01:54:38.595212  / # . /lava-163738/environment/lava-163738/=
bin/lava-test-runner /lava-163738/1
    2023-10-11T01:54:38.596144  =

    2023-10-11T01:54:38.600534  / # /lava-163738/bin/lava-test-runner /lava=
-163738/1
    2023-10-11T01:54:38.631797  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64         | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6525ff8726a40647ebefcf0a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm64/defconfig/gcc-10/lab-=
collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm64/defconfig/gcc-10/lab-=
collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525ff8726a40647ebefcf13
        failing since 264 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-10-11T01:55:17.566315  / # #

    2023-10-11T01:55:17.666839  export SHELL=3D/bin/sh

    2023-10-11T01:55:17.666982  #

    2023-10-11T01:55:17.767458  / # export SHELL=3D/bin/sh. /lava-11733124/=
environment

    2023-10-11T01:55:17.767598  =


    2023-10-11T01:55:17.868101  / # . /lava-11733124/environment/lava-11733=
124/bin/lava-test-runner /lava-11733124/1

    2023-10-11T01:55:17.868287  =


    2023-10-11T01:55:17.880263  / # /lava-11733124/bin/lava-test-runner /la=
va-11733124/1

    2023-10-11T01:55:17.938420  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-11T01:55:17.938501  + cd /lava-1173312<8>[   15.621460] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11733124_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
zynqmp-zcu102              | arm64  | lab-cip         | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6525ff8526a40647ebefceff

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm64/defconfig/gcc-10/lab-=
cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm64/defconfig/gcc-10/lab-=
cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525ff8526a40647ebefcf06
        failing since 264 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-10-11T01:50:39.304195  + set +x
    2023-10-11T01:50:39.305230  <8>[    3.719126] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1019445_1.5.2.4.1>
    2023-10-11T01:50:39.411081  / # #
    2023-10-11T01:50:39.512320  export SHELL=3D/bin/sh
    2023-10-11T01:50:39.512726  #
    2023-10-11T01:50:39.613822  / # export SHELL=3D/bin/sh. /lava-1019445/e=
nvironment
    2023-10-11T01:50:39.614104  =

    2023-10-11T01:50:39.715103  / # . /lava-1019445/environment/lava-101944=
5/bin/lava-test-runner /lava-1019445/1
    2023-10-11T01:50:39.715515  =

    2023-10-11T01:50:39.718092  / # /lava-1019445/bin/lava-test-runner /lav=
a-1019445/1 =

    ... (13 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
zynqmp-zcu102              | arm64  | lab-cip         | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6526012959358966b1efcf04

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6526012959358966b1efcf0b
        failing since 264 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-10-11T01:57:43.038181  + set +x
    2023-10-11T01:57:43.040041  <8>[    3.726839] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1019478_1.5.2.4.1>
    2023-10-11T01:57:43.145690  / # #
    2023-10-11T01:57:43.247660  export SHELL=3D/bin/sh
    2023-10-11T01:57:43.248207  #
    2023-10-11T01:57:43.349474  / # export SHELL=3D/bin/sh. /lava-1019478/e=
nvironment
    2023-10-11T01:57:43.350207  =

    2023-10-11T01:57:43.451891  / # . /lava-1019478/environment/lava-101947=
8/bin/lava-test-runner /lava-1019478/1
    2023-10-11T01:57:43.452949  =

    2023-10-11T01:57:43.455180  / # /lava-1019478/bin/lava-test-runner /lav=
a-1019478/1 =

    ... (12 line(s) more)  =

 =20

