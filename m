Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98D6C2FC0E
	for <webhook@archiver.kernel.org>; Wed, 16 Aug 2023 23:59:45 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web10.175972.1692230379183901313
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 16 Aug 2023 16:59:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=nCRPsvL0;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.170, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1bddac1b7bfso2879735ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 16 Aug 2023 16:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692230378; x=1692835178;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fXcmLhE1SgZcgu0wzq1U+0KnxB9wf2mlfO1lf1xOHu8=;
        b=nCRPsvL0nxGxBPMrjp4sgoML1ehwfhX4zgvTi5bqTICqE9sesgzT34TpfUElLAcIkK
         lDhX/RZjYvQ+RRWbQmS+cE/pptVwDHCRKE7yvEB76JG59zdavrowdtc2ELhl6LS8iaf9
         7Q6QZ/IVaQLHQMhv1fqkXIiMuWkP/d8JJ6dpzgqeguZhCVcGn6BBfcDLQv87UBUVAqIf
         qlAB/HH5wCfxrrYt9sF42PltqqV2X+MCHbK1zp947WHQKmOWQEifIBQx2EY7eJ59G1xu
         oZZLpj/CXXcrM3v+AF2WvvXhsSLKDrfwdPaK2YlHvXgBQJP+GtEnCvZdPGRJPJ5RwCdO
         hvNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692230378; x=1692835178;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fXcmLhE1SgZcgu0wzq1U+0KnxB9wf2mlfO1lf1xOHu8=;
        b=HGaGH1MyM++bCOrth/mRBSCDaqGExujsFFO9i7BfzHApO3KcsRKmXlXR5C+IkF1uzP
         bQpYLrVNP1m4xrFU6lGiDtlRHOqe1YYkNfXNP2STydcrIJxPnc5yGO0qblAo3P4zTlWv
         gQIqP47OAV2qsL4ifScQ8PluOW0CgdP0mkBdcrMriE7dx6YdbMMhGObxLbCV0jGjUMFw
         0uPHlT2pdH/kmI4E/vNs7ewysM++astFYt6OlraZ3wJetSOY3mw8zFKSDLT+M6qk/tOm
         h1zUOU3bP7vnbetfuVRt8V0geOqiZ9pDXFM7AAoE4sOEIWDJZ7TrKRJKsWepKKQzqr4a
         j1Gg==
X-Gm-Message-State: AOJu0YwKbMe5eJZ7c5D7pAulFtGsQwcjmjN4IBDjvHkAadOX7g2gBFZ9
	gVRiZTaK96u3pM61EPAcYwhvs41Djh0bwTEq0Whkhg==
X-Google-Smtp-Source: AGHT+IEzzZKrlEOhH+QCibqFjfKtKKZlr6ZNyvscz9g8okqMVVf3jJiTPvDBmtKMMaUE/DjxdjNYLQ==
X-Received: by 2002:a17:903:191:b0:1b8:af5e:853c with SMTP id z17-20020a170903019100b001b8af5e853cmr1482944plg.26.1692230377600;
        Wed, 16 Aug 2023 16:59:37 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id iy12-20020a170903130c00b001bde12178b4sm370370plb.33.2023.08.16.16.59.36
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 16:59:36 -0700 (PDT)
Message-ID: <64dd62e8.170a0220.49f26.143d@mx.google.com>
Date: Wed, 16 Aug 2023 16:59:36 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.288-cip101-388-g468a029f1562
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 101 runs,
 35 regressions (v4.19.288-cip101-388-g468a029f1562)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Aug 2023 23:59:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12743

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 101 runs, 35 regressio=
ns (v4.19.288-cip101-388-g468a029f1562)

Regressions Summary
-------------------

platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
asus-C433TA-AJ0005-rammus  | x86_64 | lab-collabora | gcc-10   | x86_64_def=
con...6-chromebook | 1          =

asus-C523NA-A20057-coral   | x86_64 | lab-collabora | gcc-10   | x86_64_def=
con...6-chromebook | 1          =

at91sam9g20ek              | arm    | lab-broonie   | gcc-10   | multi_v5_d=
efconfig           | 1          =

beaglebone-black           | arm    | lab-broonie   | gcc-10   | multi_v7_d=
efconfig           | 1          =

beaglebone-black           | arm    | lab-cip       | gcc-10   | multi_v7_d=
efconfig           | 1          =

imx6q-sabrelite            | arm    | lab-collabora | gcc-10   | multi_v7_d=
efconfig           | 1          =

imx6ul-14x14-evk           | arm    | lab-nxp       | gcc-10   | multi_v7_d=
efconfig           | 1          =

imx7d-sdb                  | arm    | lab-nxp       | gcc-10   | multi_v7_d=
efconfig           | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-broonie   | gcc-10   | defconfig =
                   | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-broonie   | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-collabora | gcc-10   | defconfig =
                   | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-collabora | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie   | gcc-10   | defconfig =
                   | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie   | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-collabora | gcc-10   | defconfig =
                   | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-collabora | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-broonie   | gcc-10   | defconfig =
                   | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-broonie   | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-collabora | gcc-10   | defconfig =
                   | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-collabora | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie   | gcc-10   | defconfig =
                   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie   | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora | gcc-10   | defconfig =
                   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

r8a7743-iwg20d-q7          | arm    | lab-cip       | gcc-10   | shmobile_d=
efconfig           | 1          =

r8a7796-m3ulcb             | arm64  | lab-collabora | gcc-10   | defconfig =
                   | 1          =

rk3288-veyron-jaq          | arm    | lab-collabora | gcc-10   | multi_v7_d=
efconfig           | 3          =

rk3399-gru-kevin           | arm64  | lab-collabora | gcc-10   | defconfig+=
arm64-chromebook   | 2          =

sun50i-a64-pine64-plus     | arm64  | lab-broonie   | gcc-10   | defconfig =
                   | 1          =

sun50i-h6-pine-h64         | arm64  | lab-collabora | gcc-10   | defconfig =
                   | 1          =

zynqmp-zcu102              | arm64  | lab-cip       | gcc-10   | defconfig =
                   | 1          =

zynqmp-zcu102              | arm64  | lab-cip       | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.288-cip101-388-g468a029f1562/plan/baselin=
e/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.288-cip101-388-g468a029f1562
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      468a029f1562d963ca820d7d6b9caa90569b3420 =



Test Regressions
---------------- =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
asus-C433TA-AJ0005-rammus  | x86_64 | lab-collabora | gcc-10   | x86_64_def=
con...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd5995ac13a55d4135b1e0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd5995ac13a55d4135b1e5
        failing since 209 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-08-16T23:20:37.614758  + set<8>[   10.870610] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11303944_1.4.2.3.1>

    2023-08-16T23:20:37.614848   +x

    2023-08-16T23:20:37.716441  #

    2023-08-16T23:20:37.817291  / # #export SHELL=3D/bin/sh

    2023-08-16T23:20:37.817568  =


    2023-08-16T23:20:37.918142  / # export SHELL=3D/bin/sh. /lava-11303944/=
environment

    2023-08-16T23:20:37.918355  =


    2023-08-16T23:20:38.018911  / # . /lava-11303944/environment/lava-11303=
944/bin/lava-test-runner /lava-11303944/1

    2023-08-16T23:20:38.019274  =


    2023-08-16T23:20:38.023913  / # /lava-11303944/bin/lava-test-runner /la=
va-11303944/1
 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
asus-C523NA-A20057-coral   | x86_64 | lab-collabora | gcc-10   | x86_64_def=
con...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd5994f35137fe2235b1e2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd5994f35137fe2235b1e7
        failing since 209 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-08-16T23:20:42.133748  + set +x

    2023-08-16T23:20:42.140247  <8>[   11.652700] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11303936_1.4.2.3.1>

    2023-08-16T23:20:42.244541  / # #

    2023-08-16T23:20:42.345088  export SHELL=3D/bin/sh

    2023-08-16T23:20:42.345300  #

    2023-08-16T23:20:42.445822  / # export SHELL=3D/bin/sh. /lava-11303936/=
environment

    2023-08-16T23:20:42.446031  =


    2023-08-16T23:20:42.546564  / # . /lava-11303936/environment/lava-11303=
936/bin/lava-test-runner /lava-11303936/1

    2023-08-16T23:20:42.546876  =


    2023-08-16T23:20:42.551420  / # /lava-11303936/bin/lava-test-runner /la=
va-11303936/1
 =

    ... (13 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
at91sam9g20ek              | arm    | lab-broonie   | gcc-10   | multi_v5_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd5c5fce3724c83f35b1e3

  Results:     42 PASS, 9 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm/multi_v5_defconfig/gcc-=
10/lab-broonie/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm/multi_v5_defconfig/gcc-=
10/lab-broonie/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd5c5fce3724c83f35b215
        new failure (last pass: v4.19.288-cip101-354-g730e5876ef02)

    2023-08-16T23:31:03.469391  + set +x
    2023-08-16T23:31:03.474484  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 59006_1.5.2.=
4.1>
    2023-08-16T23:31:03.587709  / # #
    2023-08-16T23:31:03.690501  export SHELL=3D/bin/sh
    2023-08-16T23:31:03.691304  #
    2023-08-16T23:31:03.793219  / # export SHELL=3D/bin/sh. /lava-59006/env=
ironment
    2023-08-16T23:31:03.793984  =

    2023-08-16T23:31:03.895941  / # . /lava-59006/environment/lava-59006/bi=
n/lava-test-runner /lava-59006/1
    2023-08-16T23:31:03.897244  =

    2023-08-16T23:31:03.903651  / # /lava-59006/bin/lava-test-runner /lava-=
59006/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
beaglebone-black           | arm    | lab-broonie   | gcc-10   | multi_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd5c1b6acafa070535b1e5

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm/multi_v7_defconfig/gcc-=
10/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm/multi_v7_defconfig/gcc-=
10/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd5c1b6acafa070535b20c
        failing since 209 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-08-16T23:29:51.546683  <8>[   16.863735] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 58978_1.5.2.4.1>
    2023-08-16T23:29:51.655052  / # #
    2023-08-16T23:29:51.758128  export SHELL=3D/bin/sh
    2023-08-16T23:29:51.758848  #
    2023-08-16T23:29:51.861309  / # export SHELL=3D/bin/sh. /lava-58978/env=
ironment
    2023-08-16T23:29:51.862027  =

    2023-08-16T23:29:51.964503  / # . /lava-58978/environment/lava-58978/bi=
n/lava-test-runner /lava-58978/1
    2023-08-16T23:29:51.965649  =

    2023-08-16T23:29:51.970068  / # /lava-58978/bin/lava-test-runner /lava-=
58978/1
    2023-08-16T23:29:52.037922  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
beaglebone-black           | arm    | lab-cip       | gcc-10   | multi_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd5cbc955bdaf1d735b20c

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm/multi_v7_defconfig/gcc-=
10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm/multi_v7_defconfig/gcc-=
10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd5cbc955bdaf1d735b20f
        failing since 209 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-08-16T23:32:39.742920  + set +x
    2023-08-16T23:32:39.744955  <8>[    9.776673] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 998336_1.5.2.4.1>
    2023-08-16T23:32:39.853464  / # #
    2023-08-16T23:32:39.955578  export SHELL=3D/bin/sh
    2023-08-16T23:32:39.956036  #
    2023-08-16T23:32:40.057529  / # export SHELL=3D/bin/sh. /lava-998336/en=
vironment
    2023-08-16T23:32:40.058174  =

    2023-08-16T23:32:40.159663  / # . /lava-998336/environment/lava-998336/=
bin/lava-test-runner /lava-998336/1
    2023-08-16T23:32:40.160598  =

    2023-08-16T23:32:40.162083  / # /lava-998336/bin/lava-test-runner /lava=
-998336/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
imx6q-sabrelite            | arm    | lab-collabora | gcc-10   | multi_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd5bf7a2c694dda335b202

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm/multi_v7_defconfig/gcc-=
10/lab-collabora/baseline-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm/multi_v7_defconfig/gcc-=
10/lab-collabora/baseline-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd5bf7a2c694dda335b207
        failing since 209 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-08-16T23:29:50.840871  / # #

    2023-08-16T23:29:50.943454  export SHELL=3D/bin/sh

    2023-08-16T23:29:50.944191  #

    2023-08-16T23:29:51.046096  / # export SHELL=3D/bin/sh. /lava-11304000/=
environment

    2023-08-16T23:29:51.046798  =


    2023-08-16T23:29:51.148671  / # . /lava-11304000/environment/lava-11304=
000/bin/lava-test-runner /lava-11304000/1

    2023-08-16T23:29:51.149838  =


    2023-08-16T23:29:51.164119  / # /lava-11304000/bin/lava-test-runner /la=
va-11304000/1

    2023-08-16T23:29:51.244112  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-16T23:29:51.280885  + cd /lava-11304000/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
imx6ul-14x14-evk           | arm    | lab-nxp       | gcc-10   | multi_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd5c276acafa070535b25e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm/multi_v7_defconfig/gcc-=
10/lab-nxp/baseline-imx6ul-14x14-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm/multi_v7_defconfig/gcc-=
10/lab-nxp/baseline-imx6ul-14x14-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd5c276acafa070535b261
        failing since 118 days (last pass: v4.19.259-cip82-57-ge54228ee5a88=
d, first fail: v4.19.280-cip96-59-g4b02e7efb967d)

    2023-08-16T23:30:16.997628  + set +x<8>[   23.118071] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 1244362_1.5.2.4.1>
    2023-08-16T23:30:16.997926  =

    2023-08-16T23:30:17.110733  / # #
    2023-08-16T23:30:18.266803  export SHELL=3D/bin/sh
    2023-08-16T23:30:18.272457  #
    2023-08-16T23:30:19.814598  / # export SHELL=3D/bin/sh. /lava-1244362/e=
nvironment
    2023-08-16T23:30:19.820236  =

    2023-08-16T23:30:22.632510  / # . /lava-1244362/environment/lava-124436=
2/bin/lava-test-runner /lava-1244362/1
    2023-08-16T23:30:22.638495  =

    2023-08-16T23:30:22.640165  / # /lava-1244362/bin/lava-test-runner /lav=
a-1244362/1 =

    ... (15 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
imx7d-sdb                  | arm    | lab-nxp       | gcc-10   | multi_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd5c286acafa070535b269

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm/multi_v7_defconfig/gcc-=
10/lab-nxp/baseline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm/multi_v7_defconfig/gcc-=
10/lab-nxp/baseline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd5c286acafa070535b26c
        failing since 204 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.270-cip89-39-g43ce130174aa)

    2023-08-16T23:30:16.736194  / # #
    2023-08-16T23:30:17.892099  export SHELL=3D/bin/sh
    2023-08-16T23:30:17.897765  #
    2023-08-16T23:30:19.439960  / # export SHELL=3D/bin/sh. /lava-1244363/e=
nvironment
    2023-08-16T23:30:19.445607  =

    2023-08-16T23:30:19.445939  / # . /lava-1244363/environment
    2023-08-16T23:30:22.258145  / # /lava-1244363/bin/lava-test-runner /lav=
a-1244363/1
    2023-08-16T23:30:22.274551  /lava-1244363/bin/lava-test-runner /lava-12=
44363/1
    2023-08-16T23:30:22.371440  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-16T23:30:22.371816  + cd /lava-1244363/1/tests/1_bootrr =

    ... (16 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-broonie   | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd5adb1babc8be4235b1ed

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm64/defconfig/gcc-10/lab-=
broonie/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm64/defconfig/gcc-10/lab-=
broonie/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dd5adb1babc8be4235b=
1ee
        failing since 455 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-broonie   | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd5dd125ed2d063a35b1e1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dd5dd125ed2d063a35b=
1e2
        failing since 455 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-collabora | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd5acda21649488635b1e2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm64/defconfig/gcc-10/lab-=
collabora/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm64/defconfig/gcc-10/lab-=
collabora/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dd5acda21649488635b=
1e3
        failing since 455 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-collabora | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd5d24aea5a3963535b22c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dd5d24aea5a3963535b=
22d
        failing since 455 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie   | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd5b001babc8be4235b1f5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm64/defconfig/gcc-10/lab-=
broonie/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm64/defconfig/gcc-10/lab-=
broonie/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dd5b001babc8be4235b=
1f6
        failing since 455 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie   | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd5dbe29fa320c3135b1e4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dd5dbe29fa320c3135b=
1e5
        failing since 455 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-collabora | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd5aceab5517dc8035b1f1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm64/defconfig/gcc-10/lab-=
collabora/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm64/defconfig/gcc-10/lab-=
collabora/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dd5aceab5517dc8035b=
1f2
        failing since 455 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-collabora | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd5d26aea5a3963535b233

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dd5d26aea5a3963535b=
234
        failing since 455 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-broonie   | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd5ad80d6d25cf0c35b204

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm64/defconfig/gcc-10/lab-=
broonie/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm64/defconfig/gcc-10/lab-=
broonie/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dd5ad80d6d25cf0c35b=
205
        failing since 455 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-broonie   | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd5dbd29fa320c3135b1e1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dd5dbd29fa320c3135b=
1e2
        failing since 455 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-collabora | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd5acdab5517dc8035b1ee

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm64/defconfig/gcc-10/lab-=
collabora/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm64/defconfig/gcc-10/lab-=
collabora/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dd5acdab5517dc8035b=
1ef
        failing since 455 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-collabora | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd5d25aea5a3963535b230

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dd5d25aea5a3963535b=
231
        failing since 455 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie   | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd5ad9a21649488635b1e7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm64/defconfig/gcc-10/lab-=
broonie/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm64/defconfig/gcc-10/lab-=
broonie/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dd5ad9a21649488635b=
1e8
        failing since 455 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie   | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd5dcfb612ad2d8e35b1e9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dd5dcfb612ad2d8e35b=
1ea
        failing since 455 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd5acc0d6d25cf0c35b1ff

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm64/defconfig/gcc-10/lab-=
collabora/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm64/defconfig/gcc-10/lab-=
collabora/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dd5acc0d6d25cf0c35b=
200
        failing since 455 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd5d38aea5a3963535b236

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dd5d38aea5a3963535b=
237
        failing since 455 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
r8a7743-iwg20d-q7          | arm    | lab-cip       | gcc-10   | shmobile_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd5a27bd951d702635b1d9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm/shmobile_defconfig/gcc-=
10/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm/shmobile_defconfig/gcc-=
10/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dd5a27bd951d702635b=
1da
        failing since 48 days (last pass: v4.19.284-cip99-114-g02e97826987b=
f, first fail: v4.19.287-cip100-43-g1a6518aa81690) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
r8a7796-m3ulcb             | arm64  | lab-collabora | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd59c6e9c6c1518535b209

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm64/defconfig/gcc-10/lab-=
collabora/baseline-r8a7796-m3ulcb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm64/defconfig/gcc-10/lab-=
collabora/baseline-r8a7796-m3ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd59c6e9c6c1518535b20e
        failing since 209 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-08-16T23:21:54.463596  / # #

    2023-08-16T23:21:54.564108  export SHELL=3D/bin/sh

    2023-08-16T23:21:54.564211  #

    2023-08-16T23:21:54.664694  / # export SHELL=3D/bin/sh. /lava-11303989/=
environment

    2023-08-16T23:21:54.664805  =


    2023-08-16T23:21:54.765299  / # . /lava-11303989/environment/lava-11303=
989/bin/lava-test-runner /lava-11303989/1

    2023-08-16T23:21:54.765473  =


    2023-08-16T23:21:54.777520  / # /lava-11303989/bin/lava-test-runner /la=
va-11303989/1

    2023-08-16T23:21:54.831394  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-16T23:21:54.831474  +<8>[    8.944959] <LAVA_SIGNAL_STARTRUN 1_=
bootrr 11303989_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
rk3288-veyron-jaq          | arm    | lab-collabora | gcc-10   | multi_v7_d=
efconfig           | 3          =


  Details:     https://kernelci.org/test/plan/id/64dd5be4fdf949e23735b21d

  Results:     61 PASS, 8 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm/multi_v7_defconfig/gcc-=
10/lab-collabora/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm/multi_v7_defconfig/gcc-=
10/lab-collabora/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/64dd5be4fdf949e23735b24d
        failing since 207 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-08-16T23:31:01.552979  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC)<8=
>[   10.391269] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-08-16T23:31:01.554989   multi-call binary.

    2023-08-16T23:31:01.555208  =


    2023-08-16T23:31:01.559528  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-08-16T23:31:01.559745  =


    2023-08-16T23:31:01.564665  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/64dd5be4fdf949e23735b24e
        failing since 207 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-08-16T23:31:01.534066  <8>[   10.373628] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd5be4fdf949e23735b261
        failing since 207 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-08-16T23:30:57.707239  <8>[    6.546843] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-08-16T23:30:57.716537  + <8>[    6.559073] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11303997_1.5.2.3.1>

    2023-08-16T23:30:57.719168  set +x

    2023-08-16T23:30:57.823065  #

    2023-08-16T23:30:57.823356  =


    2023-08-16T23:30:57.923962  / # #export SHELL=3D/bin/sh

    2023-08-16T23:30:57.924190  =


    2023-08-16T23:30:58.024751  / # export SHELL=3D/bin/sh. /lava-11303997/=
environment

    2023-08-16T23:30:58.024969  =


    2023-08-16T23:30:58.125544  / # . /lava-11303997/environment/lava-11303=
997/bin/lava-test-runner /lava-11303997/1
 =

    ... (18 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
rk3399-gru-kevin           | arm64  | lab-collabora | gcc-10   | defconfig+=
arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64dd5c4520bbdb1bc135b219

  Results:     77 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/64dd5c4520bbdb1bc135b21f
        failing since 155 days (last pass: v4.19.273-cip92-277-g507c8d80b9e=
20, first fail: v4.19.276-cip93-5-g2eb2a953ab59)

    2023-08-16T23:31:23.634935  =


    2023-08-16T23:31:24.646657  /lava-11304020/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/64dd5c4520bbdb1bc135b220
        failing since 155 days (last pass: v4.19.273-cip92-277-g507c8d80b9e=
20, first fail: v4.19.276-cip93-5-g2eb2a953ab59)

    2023-08-16T23:31:23.633149  /lava-11304020/1/../bin/lava-test-case<8>[ =
  36.304308] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Drockchip-usb2phy0-probed =
RESULT=3Dfail>
   =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
sun50i-a64-pine64-plus     | arm64  | lab-broonie   | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd59eb9a1ddd1fa635b213

  Results:     23 PASS, 16 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm64/defconfig/gcc-10/lab-=
broonie/baseline-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm64/defconfig/gcc-10/lab-=
broonie/baseline-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd59eb9a1ddd1fa635b239
        failing since 209 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-08-16T23:20:40.063366  <8>[   15.936323] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 58963_1.5.2.4.1>
    2023-08-16T23:20:40.169001  / # #
    2023-08-16T23:20:40.271088  export SHELL=3D/bin/sh
    2023-08-16T23:20:40.271559  #
    2023-08-16T23:20:40.372970  / # export SHELL=3D/bin/sh. /lava-58963/env=
ironment
    2023-08-16T23:20:40.373399  =

    2023-08-16T23:20:40.474863  / # . /lava-58963/environment/lava-58963/bi=
n/lava-test-runner /lava-58963/1
    2023-08-16T23:20:40.475628  =

    2023-08-16T23:20:40.480653  / # /lava-58963/bin/lava-test-runner /lava-=
58963/1
    2023-08-16T23:20:40.511199  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
sun50i-h6-pine-h64         | arm64  | lab-collabora | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd59daa3164f992935b1fc

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm64/defconfig/gcc-10/lab-=
collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm64/defconfig/gcc-10/lab-=
collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd59daa3164f992935b201
        failing since 209 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-08-16T23:22:15.767669  / # #

    2023-08-16T23:22:15.869600  export SHELL=3D/bin/sh

    2023-08-16T23:22:15.870306  #

    2023-08-16T23:22:15.971702  / # export SHELL=3D/bin/sh. /lava-11303983/=
environment

    2023-08-16T23:22:15.972404  =


    2023-08-16T23:22:16.073846  / # . /lava-11303983/environment/lava-11303=
983/bin/lava-test-runner /lava-11303983/1

    2023-08-16T23:22:16.074925  =


    2023-08-16T23:22:16.092163  / # /lava-11303983/bin/lava-test-runner /la=
va-11303983/1

    2023-08-16T23:22:16.150169  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-16T23:22:16.150674  + cd /lava-1130398<8>[   15.617932] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11303983_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
zynqmp-zcu102              | arm64  | lab-cip       | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd59c454f3dde77e35b1f0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm64/defconfig/gcc-10/lab-=
cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm64/defconfig/gcc-10/lab-=
cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd59c454f3dde77e35b1f3
        failing since 209 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-08-16T23:20:16.602606  + set +x
    2023-08-16T23:20:16.603612  <8>[    3.735302] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 998333_1.5.2.4.1>
    2023-08-16T23:20:16.706436  / # #
    2023-08-16T23:20:16.807719  export SHELL=3D/bin/sh
    2023-08-16T23:20:16.807952  #
    2023-08-16T23:20:16.908939  / # export SHELL=3D/bin/sh. /lava-998333/en=
vironment
    2023-08-16T23:20:16.909162  =

    2023-08-16T23:20:17.010136  / # . /lava-998333/environment/lava-998333/=
bin/lava-test-runner /lava-998333/1
    2023-08-16T23:20:17.010537  =

    2023-08-16T23:20:17.012491  / # /lava-998333/bin/lava-test-runner /lava=
-998333/1 =

    ... (13 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
zynqmp-zcu102              | arm64  | lab-cip       | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd5c306acafa070535b27f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dd5c306acafa070535b282
        failing since 209 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-08-16T23:30:37.076275  <8>[    3.713251] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 998348_1.5.2.4.1>
    2023-08-16T23:30:37.181170  / # #
    2023-08-16T23:30:37.282522  export SHELL=3D/bin/sh
    2023-08-16T23:30:37.283078  #
    2023-08-16T23:30:37.384307  / # export SHELL=3D/bin/sh. /lava-998348/en=
vironment
    2023-08-16T23:30:37.384678  =

    2023-08-16T23:30:37.485926  / # . /lava-998348/environment/lava-998348/=
bin/lava-test-runner /lava-998348/1
    2023-08-16T23:30:37.486593  =

    2023-08-16T23:30:37.489173  / # /lava-998348/bin/lava-test-runner /lava=
-998348/1
    2023-08-16T23:30:37.526094  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =20

