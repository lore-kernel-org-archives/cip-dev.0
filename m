Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA96EB64DB
	for <webhook@archiver.kernel.org>; Wed, 14 Jun 2023 12:46:45 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web11.10726.1686746803882053484
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 14 Jun 2023 05:46:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=y1dWnLX5;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.176, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1b4fef08c71so4710335ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 14 Jun 2023 05:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686746803; x=1689338803;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wHOlelNBE/yK4fo9bq6xsY2dGEIOgxCIUr8U7A9VB94=;
        b=y1dWnLX5rnAEPLE3Xv7ineeKHakvz5LhNRZ/IijyiNpuxkg/vnllMNFau5C/DWBr8m
         n2LhAPIiN6Mrz2BsFX4wIgHCCCNCoxO6OwgHkjlNv8reUfkxN+4Ia0IA9iAdAY1oEcoB
         KKzPyIcnOKcBY5Y1QE3BVWL7ThyX7Y67TYzZq9KRsll8c0EvaGRodWrkv//TN5ffmNrj
         Agfu2BJtJL0nCMnpT+tM8sodm7IC0n4yk5qBPSRiPp/9E0yiUNxviWphxtFYqOzPRuYj
         AdEIDNuQDOw08nYKqWmuOPEFgzm5UTcLPzWkWyXnhurWeIc2M42iIzbndZfFmgWrDx0/
         gqeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686746803; x=1689338803;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wHOlelNBE/yK4fo9bq6xsY2dGEIOgxCIUr8U7A9VB94=;
        b=GiHyV1/5mKoXfl8+yW2lM+dU+nk5RQNm/HSgBNbaI8bfDGe0mbXMNiPCFE1DQcfb5E
         IsxqcnEMMOdiKwAkxHSJyUnSQBUtIflhj6/X3IROlh061R0XMrpMCvR2xH0m+n38eJ1N
         3qbjlwIlvcVrQwkNlJofFr0nTGpOhowi5NGUnfNhG/AvM9yTyLNMzSgx+qlwBq9cOdlu
         G0r+eNmdVan2ww2X1Mpv5z1qbI3zJTgc7rBxYCWGKJy6c1bKSSbxNZddUf10PYXQFCfM
         q+SubBx8zBY/AhqcYfXRr5chY9tijpOrVM/EgqBrdtVnAiD62+T+kzJSC+sQ3Zqy/5SJ
         ZuTw==
X-Gm-Message-State: AC+VfDy1N3ro9itjkJU4QBRDSH2SPatMmgRL35ddheyq+tRmBSIz03Up
	Zbktxlmn700B61oy43dHVBucLMc5eo+RzK7+iM1Tnw==
X-Google-Smtp-Source: ACHHUZ70hygiG1vKG5h8vKpCyW8mtC6QoGiNQpJtlyS5SDc0Pep041eI8jx72K87InyxXV5l+THzoQ==
X-Received: by 2002:a17:902:e5ca:b0:1b0:637e:e25a with SMTP id u10-20020a170902e5ca00b001b0637ee25amr15657882plf.67.1686746801514;
        Wed, 14 Jun 2023 05:46:41 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a7-20020a170902ecc700b00198d7b52eefsm12080200plh.257.2023.06.14.05.46.40
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 05:46:40 -0700 (PDT)
Message-ID: <6489b6b0.170a0220.8ca9b.7b62@mx.google.com>
Date: Wed, 14 Jun 2023 05:46:40 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.284-cip99-114-g02e97826987bf
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 95 runs,
 33 regressions (v4.19.284-cip99-114-g02e97826987bf)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Jun 2023 12:46:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12014

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 95 runs, 33 regression=
s (v4.19.284-cip99-114-g02e97826987bf)

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

beaglebone-black           | arm    | lab-cip         | gcc-10   | omap2plu=
s_defconfig          | 1          =

dove-cubox                 | arm    | lab-pengutronix | gcc-10   | mvebu_v7=
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

rk3288-veyron-jaq          | arm    | lab-collabora   | gcc-10   | multi_v7=
_defconfig           | 3          =

rk3399-gru-kevin           | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

sun50i-h6-pine-h64         | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =

zynqmp-zcu102              | arm64  | lab-cip         | gcc-10   | defconfi=
g                    | 1          =

zynqmp-zcu102              | arm64  | lab-cip         | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.284-cip99-114-g02e97826987bf/plan/baselin=
e/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.284-cip99-114-g02e97826987bf
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      02e97826987bf9401c9a3fb9d2d52ab90340ea1d =



Test Regressions
---------------- =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus  | x86_64 | lab-collabora   | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6489b004c980769bad306133

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6489b004c980769bad306138
        failing since 146 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-06-14T12:18:11.038783  + set<8>[   14.140494] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10724480_1.4.2.3.1>

    2023-06-14T12:18:11.038919   +x

    2023-06-14T12:18:11.141153  #

    2023-06-14T12:18:11.141493  =


    2023-06-14T12:18:11.242126  / # #export SHELL=3D/bin/sh

    2023-06-14T12:18:11.242332  =


    2023-06-14T12:18:11.342821  / # export SHELL=3D/bin/sh. /lava-10724480/=
environment

    2023-06-14T12:18:11.343074  =


    2023-06-14T12:18:11.443639  / # . /lava-10724480/environment/lava-10724=
480/bin/lava-test-runner /lava-10724480/1

    2023-06-14T12:18:11.443979  =

 =

    ... (13 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral   | x86_64 | lab-collabora   | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6489b0173c167e6bee306137

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6489b0173c167e6bee30613c
        failing since 146 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-06-14T12:18:34.432689  + <8>[   12.164841] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10724509_1.4.2.3.1>

    2023-06-14T12:18:34.432822  set +x

    2023-06-14T12:18:34.533985  #

    2023-06-14T12:18:34.634786  / # #export SHELL=3D/bin/sh

    2023-06-14T12:18:34.634994  =


    2023-06-14T12:18:34.735509  / # export SHELL=3D/bin/sh. /lava-10724509/=
environment

    2023-06-14T12:18:34.735736  =


    2023-06-14T12:18:34.836262  / # . /lava-10724509/environment/lava-10724=
509/bin/lava-test-runner /lava-10724509/1

    2023-06-14T12:18:34.836631  =


    2023-06-14T12:18:34.841802  / # /lava-10724509/bin/lava-test-runner /la=
va-10724509/1
 =

    ... (13 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
beaglebone-black           | arm    | lab-broonie     | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6489b10a96a684757c306148

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm/multi_v7_defconfig/gcc-=
10/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm/multi_v7_defconfig/gcc-=
10/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6489b10a96a684757c306172
        failing since 146 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-06-14T12:21:50.731200  <8>[   16.424092] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 610251_1.5.2.4.1>
    2023-06-14T12:21:50.841092  / # #
    2023-06-14T12:21:50.943927  export SHELL=3D/bin/sh
    2023-06-14T12:21:50.944706  #
    2023-06-14T12:21:51.046882  / # export SHELL=3D/bin/sh. /lava-610251/en=
vironment
    2023-06-14T12:21:51.047601  =

    2023-06-14T12:21:51.149763  / # . /lava-610251/environment/lava-610251/=
bin/lava-test-runner /lava-610251/1
    2023-06-14T12:21:51.151010  =

    2023-06-14T12:21:51.154053  / # /lava-610251/bin/lava-test-runner /lava=
-610251/1
    2023-06-14T12:21:51.222827  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
beaglebone-black           | arm    | lab-cip         | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6489b4219f2652d62330613b

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm/multi_v7_defconfig/gcc-=
10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm/multi_v7_defconfig/gcc-=
10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6489b4219f2652d62330613e
        failing since 146 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-06-14T12:35:07.788820  + set +x
    2023-06-14T12:35:07.790764  <8>[    9.849979] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 962945_1.5.2.4.1>
    2023-06-14T12:35:07.899765  / # #
    2023-06-14T12:35:08.001645  export SHELL=3D/bin/sh
    2023-06-14T12:35:08.002090  #
    2023-06-14T12:35:08.103473  / # export SHELL=3D/bin/sh. /lava-962945/en=
vironment
    2023-06-14T12:35:08.103926  =

    2023-06-14T12:35:08.205325  / # . /lava-962945/environment/lava-962945/=
bin/lava-test-runner /lava-962945/1
    2023-06-14T12:35:08.206200  =

    2023-06-14T12:35:08.207814  / # /lava-962945/bin/lava-test-runner /lava=
-962945/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
beaglebone-black           | arm    | lab-cip         | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6489b2eb3002ec113430616e

  Results:     41 PASS, 10 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm/omap2plus_defconfig/gcc=
-10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm/omap2plus_defconfig/gcc=
-10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6489b2eb3002ec1134306171
        new failure (last pass: v4.19.283-cip98-224-g5f5303d7920a9)

    2023-06-14T12:30:12.708403  + set +x<8>[   10.552073] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 962930_1.5.2.4.1>
    2023-06-14T12:30:12.708941  =

    2023-06-14T12:30:12.820586  / # #
    2023-06-14T12:30:12.923204  export SHELL=3D/bin/sh
    2023-06-14T12:30:12.923909  #
    2023-06-14T12:30:13.025702  / # export SHELL=3D/bin/sh. /lava-962930/en=
vironment
    2023-06-14T12:30:13.026400  =

    2023-06-14T12:30:13.128196  / # . /lava-962930/environment/lava-962930/=
bin/lava-test-runner /lava-962930/1
    2023-06-14T12:30:13.129372  =

    2023-06-14T12:30:13.135923  / # /lava-962930/bin/lava-test-runner /lava=
-962930/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
dove-cubox                 | arm    | lab-pengutronix | gcc-10   | mvebu_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6489ab7004b7bad9d730613f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: mvebu_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm/mvebu_v7_defconfig/gcc-=
10/lab-pengutronix/baseline-dove-cubox.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm/mvebu_v7_defconfig/gcc-=
10/lab-pengutronix/baseline-dove-cubox.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6489ab7004b7bad9d7306144
        failing since 146 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-06-14T11:58:22.524401  + set +x
    2023-06-14T11:58:22.524620  [    4.244267] <LAVA_SIGNAL_ENDRUN 0_dmesg =
977182_1.5.2.3.1>
    2023-06-14T11:58:22.631035  / # #
    2023-06-14T11:58:22.733030  export SHELL=3D/bin/sh
    2023-06-14T11:58:22.733574  #
    2023-06-14T11:58:22.834892  / # export SHELL=3D/bin/sh. /lava-977182/en=
vironment
    2023-06-14T11:58:22.835330  =

    2023-06-14T11:58:22.936638  / # . /lava-977182/environment/lava-977182/=
bin/lava-test-runner /lava-977182/1
    2023-06-14T11:58:22.937391  =

    2023-06-14T11:58:22.942416  / # /lava-977182/bin/lava-test-runner /lava=
-977182/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx6q-sabrelite            | arm    | lab-collabora   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6489ad8c342b6f7062306143

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm/multi_v7_defconfig/gcc-=
10/lab-collabora/baseline-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm/multi_v7_defconfig/gcc-=
10/lab-collabora/baseline-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6489ad8c342b6f7062306148
        failing since 146 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-06-14T12:07:25.596429  / # #

    2023-06-14T12:07:25.698296  export SHELL=3D/bin/sh

    2023-06-14T12:07:25.698888  #

    2023-06-14T12:07:25.800001  / # export SHELL=3D/bin/sh. /lava-10724218/=
environment

    2023-06-14T12:07:25.800140  =


    2023-06-14T12:07:25.900651  / # . /lava-10724218/environment/lava-10724=
218/bin/lava-test-runner /lava-10724218/1

    2023-06-14T12:07:25.900929  =


    2023-06-14T12:07:25.904386  / # /lava-10724218/bin/lava-test-runner /la=
va-10724218/1

    2023-06-14T12:07:26.012403  + export 'TESTRUN_ID=3D1_bootrr'

    2023-06-14T12:07:26.012487  + cd /lava-10724218/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx6qp-wandboard-revd1     | arm    | lab-pengutronix | gcc-10   | imx_v6_v=
7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6489ab4876fce5230e30614f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm/imx_v6_v7_defconfig/gcc=
-10/lab-pengutronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm/imx_v6_v7_defconfig/gcc=
-10/lab-pengutronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6489ab4876fce5230e306154
        failing since 146 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-06-14T11:57:51.012337  + set +x[    7.336305] <LAVA_SIGNAL_ENDRUN =
0_dmesg 977178_1.5.2.3.1>
    2023-06-14T11:57:51.012516  =

    2023-06-14T11:57:51.120329  / # #
    2023-06-14T11:57:51.221997  export SHELL=3D/bin/sh
    2023-06-14T11:57:51.222468  #
    2023-06-14T11:57:51.323696  / # export SHELL=3D/bin/sh. /lava-977178/en=
vironment
    2023-06-14T11:57:51.324124  =

    2023-06-14T11:57:51.425524  / # . /lava-977178/environment/lava-977178/=
bin/lava-test-runner /lava-977178/1
    2023-06-14T11:57:51.426341  =

    2023-06-14T11:57:51.428850  / # /lava-977178/bin/lava-test-runner /lava=
-977178/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx6qp-wandboard-revd1     | arm    | lab-pengutronix | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6489ad65b5a23229ef306144

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm/multi_v7_defconfig/gcc-=
10/lab-pengutronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm/multi_v7_defconfig/gcc-=
10/lab-pengutronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6489ad65b5a23229ef306149
        failing since 146 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-06-14T12:06:48.988729  + set +x
    2023-06-14T12:06:48.988900  [    4.911502] <LAVA_SIGNAL_ENDRUN 0_dmesg =
977192_1.5.2.3.1>
    2023-06-14T12:06:49.095094  / # #
    2023-06-14T12:06:49.196745  export SHELL=3D/bin/sh
    2023-06-14T12:06:49.197203  #
    2023-06-14T12:06:49.298426  / # export SHELL=3D/bin/sh. /lava-977192/en=
vironment
    2023-06-14T12:06:49.298875  =

    2023-06-14T12:06:49.400143  / # . /lava-977192/environment/lava-977192/=
bin/lava-test-runner /lava-977192/1
    2023-06-14T12:06:49.400844  =

    2023-06-14T12:06:49.403328  / # /lava-977192/bin/lava-test-runner /lava=
-977192/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6489b0f3dd7b18e5db306174

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm64/defconfig/gcc-10/lab-=
broonie/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm64/defconfig/gcc-10/lab-=
broonie/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6489b0f3dd7b18e5db306=
175
        failing since 391 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6489b259b90b81fb3130613f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6489b259b90b81fb31306=
140
        failing since 391 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6489af032ee46b24cb306146

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm64/defconfig/gcc-10/lab-=
collabora/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm64/defconfig/gcc-10/lab-=
collabora/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6489af032ee46b24cb306=
147
        failing since 391 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6489af2a36b807fb3e306146

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6489af2a36b807fb3e306=
147
        failing since 391 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6489b105b767051166306138

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm64/defconfig/gcc-10/lab-=
broonie/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm64/defconfig/gcc-10/lab-=
broonie/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6489b105b767051166306=
139
        failing since 391 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6489b39ac032f547a4306149

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6489b39ac032f547a4306=
14a
        failing since 391 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6489af042ee46b24cb30614e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm64/defconfig/gcc-10/lab-=
collabora/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm64/defconfig/gcc-10/lab-=
collabora/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6489af042ee46b24cb306=
14f
        failing since 391 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6489aff74a89cb69d1306142

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6489aff74a89cb69d1306=
143
        failing since 391 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6489b0f1b19877f1f8306140

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm64/defconfig/gcc-10/lab-=
broonie/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm64/defconfig/gcc-10/lab-=
broonie/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6489b0f1b19877f1f8306=
141
        failing since 391 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6489b26d3fc4d2825e30613f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6489b26d3fc4d2825e306=
140
        failing since 391 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6489af075bf917c6c7306150

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm64/defconfig/gcc-10/lab-=
collabora/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm64/defconfig/gcc-10/lab-=
collabora/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6489af075bf917c6c7306=
151
        failing since 391 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6489afbb1871a2a0bd30614a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6489afbb1871a2a0bd306=
14b
        failing since 391 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6489b231585a9359ab306180

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm64/defconfig/gcc-10/lab-=
broonie/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm64/defconfig/gcc-10/lab-=
broonie/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6489b231585a9359ab306=
181
        failing since 391 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6489b25af6d80256b4306133

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6489b25af6d80256b4306=
134
        failing since 391 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6489af082ee46b24cb306154

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm64/defconfig/gcc-10/lab-=
collabora/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm64/defconfig/gcc-10/lab-=
collabora/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6489af082ee46b24cb306=
155
        failing since 391 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6489af2f36b807fb3e30614f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6489af2f36b807fb3e306=
150
        failing since 391 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
rk3288-veyron-jaq          | arm    | lab-collabora   | gcc-10   | multi_v7=
_defconfig           | 3          =


  Details:     https://kernelci.org/test/plan/id/6489ad7a877b04a2c430614b

  Results:     61 PASS, 8 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm/multi_v7_defconfig/gcc-=
10/lab-collabora/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm/multi_v7_defconfig/gcc-=
10/lab-collabora/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/6489ad7a877b04a2c430617b
        failing since 144 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-06-14T12:07:55.766643  BusyBox v1.31.1 (2023-06-09 10:32:04 UTC)<8=
>[   10.174750] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-06-14T12:07:55.768666   multi-call binary.

    2023-06-14T12:07:55.768935  =


    2023-06-14T12:07:55.773334  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-06-14T12:07:55.773386  =


    2023-06-14T12:07:55.778435  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-06-14T12:07:55.789179  FIRST,<8>[   10.193597] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/6489ad7a877b04a2c430617c
        failing since 144 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-06-14T12:07:55.748039  <8>[   10.157211] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6489ad7a877b04a2c430618f
        failing since 144 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-06-14T12:07:51.922916  <8>[    6.332257] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-06-14T12:07:51.932260  + <8>[    6.344525] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10724215_1.5.2.3.1>

    2023-06-14T12:07:51.932714  set +x

    2023-06-14T12:07:52.038186  #

    2023-06-14T12:07:52.038386  =


    2023-06-14T12:07:52.138876  / # #export SHELL=3D/bin/sh

    2023-06-14T12:07:52.138975  =


    2023-06-14T12:07:52.239399  / # export SHELL=3D/bin/sh. /lava-10724215/=
environment

    2023-06-14T12:07:52.239527  =


    2023-06-14T12:07:52.339952  / # . /lava-10724215/environment/lava-10724=
215/bin/lava-test-runner /lava-10724215/1
 =

    ... (18 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
rk3399-gru-kevin           | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6489b0373af022f3d9306138

  Results:     77 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/6489b0373af022f3d930613e
        failing since 92 days (last pass: v4.19.273-cip92-277-g507c8d80b9e2=
0, first fail: v4.19.276-cip93-5-g2eb2a953ab59)

    2023-06-14T12:18:48.586310  /lava-10724260/1/../bin/lava-test-case

    2023-06-14T12:18:48.594917  <8>[   36.441186] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/6489b0373af022f3d930613f
        failing since 92 days (last pass: v4.19.273-cip92-277-g507c8d80b9e2=
0, first fail: v4.19.276-cip93-5-g2eb2a953ab59)

    2023-06-14T12:18:47.563769  /lava-10724260/1/../bin/lava-test-case

    2023-06-14T12:18:47.572321  <8>[   35.418525] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64         | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6489aece2bd0a2677d30614a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm64/defconfig/gcc-10/lab-=
collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm64/defconfig/gcc-10/lab-=
collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6489aece2bd0a2677d30614f
        failing since 146 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-06-14T12:13:45.067048  / # #

    2023-06-14T12:13:45.167838  export SHELL=3D/bin/sh

    2023-06-14T12:13:45.168453  #

    2023-06-14T12:13:45.269358  / # export SHELL=3D/bin/sh. /lava-10724246/=
environment

    2023-06-14T12:13:45.269501  =


    2023-06-14T12:13:45.370151  / # . /lava-10724246/environment/lava-10724=
246/bin/lava-test-runner /lava-10724246/1

    2023-06-14T12:13:45.370466  =


    2023-06-14T12:13:45.375227  / # /lava-10724246/bin/lava-test-runner /la=
va-10724246/1

    2023-06-14T12:13:45.445777  + export 'TESTRUN_ID=3D1_bootrr'

    2023-06-14T12:13:45.446274  + cd /lava-1072424<8>[   15.624282] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 10724246_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
zynqmp-zcu102              | arm64  | lab-cip         | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6489b0d9eb552f25d0306194

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm64/defconfig/gcc-10/lab-=
cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm64/defconfig/gcc-10/lab-=
cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6489b0d9eb552f25d0306197
        failing since 146 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-06-14T12:21:23.095382  <8>[    3.749649] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 962980_1.5.2.4.1>
    2023-06-14T12:21:23.201139  / # #
    2023-06-14T12:21:23.303009  export SHELL=3D/bin/sh
    2023-06-14T12:21:23.303483  #
    2023-06-14T12:21:23.404952  / # export SHELL=3D/bin/sh. /lava-962980/en=
vironment
    2023-06-14T12:21:23.405585  =

    2023-06-14T12:21:23.507043  / # . /lava-962980/environment/lava-962980/=
bin/lava-test-runner /lava-962980/1
    2023-06-14T12:21:23.507826  =

    2023-06-14T12:21:23.510513  / # /lava-962980/bin/lava-test-runner /lava=
-962980/1
    2023-06-14T12:21:23.547541  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
zynqmp-zcu102              | arm64  | lab-cip         | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6489b1298cf340015b306195

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6489b1298cf340015b306198
        failing since 146 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-06-14T12:22:47.320579  <8>[    3.710304] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 962987_1.5.2.4.1>
    2023-06-14T12:22:47.426153  / # #
    2023-06-14T12:22:47.528044  export SHELL=3D/bin/sh
    2023-06-14T12:22:47.528579  #
    2023-06-14T12:22:47.629974  / # export SHELL=3D/bin/sh. /lava-962987/en=
vironment
    2023-06-14T12:22:47.630474  =

    2023-06-14T12:22:47.732575  / # . /lava-962987/environment/lava-962987/=
bin/lava-test-runner /lava-962987/1
    2023-06-14T12:22:47.733490  =

    2023-06-14T12:22:47.735721  / # /lava-962987/bin/lava-test-runner /lava=
-962987/1
    2023-06-14T12:22:47.773766  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =20

