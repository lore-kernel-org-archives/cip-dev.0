Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74ABC04A94
	for <webhook@archiver.kernel.org>; Wed,  9 Aug 2023 00:46:33 +0000 (UTC)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
 by mx.groups.io with SMTP id smtpd.web11.78232.1691541985174920678
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 08 Aug 2023 17:46:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=sM6DXrgt;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.173, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-686efb9ee0cso5929515b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 08 Aug 2023 17:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691541984; x=1692146784;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=p5ANLf9BeCv/Cz70wwa7RELmIBmAibT111fI+lqsidY=;
        b=sM6DXrgt+lo+XCSXMF5EnpXlrNWv0g74LYnMfBLQQqRtn/HqNP6nerpzZhwZSzuCgU
         tHDvY1eWTskjkfOzuK89XbzVPSPgZWFF7eFij2JH7aj+SJsIiF7Joq8wf8LTEXP9G61/
         gOxKzW2orkqtGH0M5buB5ZyIB7GVkHaT6Df2Jih8+n/m3ZN/FI7jfeXWUheGMR/5bjr/
         wqVsHdAHnP7skd4N9wDMunT4S5WYuq9tPoZ94NDW79mBLumXWx3X4ftSng24fp3fBpTs
         FQZNQhuk2aksV8cM/JZC3XONnyOZ4BeVjjNwjmg1E5rrX6TLUP3sqLsW1X/3/CO/IbUQ
         mDAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691541984; x=1692146784;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p5ANLf9BeCv/Cz70wwa7RELmIBmAibT111fI+lqsidY=;
        b=P92OfQskonW4y/bq1p2mwWR2xhKGqKoC3xcel+NfLW9QJfSHKCqCe0eOzfln0y7AI0
         PeqorpuaBTGkb0o5rkeqfDZxN0JCn/w3IoYku2Tyz8QQcuGtKk1Jr7y4gME5SU4FQsa1
         FfiiqHZlFj3mkwXK0b8c039xBZGwOoHyRBVZRUb0t7ZqBQjgNdk7YT2BFwBNuN+kZyph
         9Bth9sqO9GZwCQy0RvUnqQ9mDwyd1y8P/wbLHGBeIMvSwO6M4Cotwz0pIa1TG0Psvd4q
         +knSnH+odqRuY09MLFjxCaAx7BAChqGnc7AIz0CgQ0Y5JnzZSVldR6lNVvX0wWv2mI+A
         iKoQ==
X-Gm-Message-State: AOJu0Yy6EYG3ooZZmYVgj7oegEavFTCREJlEp5BRnAd2N1Gkft0dh2i7
	Dxcs3W+zyLX/wn6+tcEmgLgIiTVpv1+E43d3k2ERhQ==
X-Google-Smtp-Source: AGHT+IFXD1rLEgx8Q83C2svVH2fXd6uTx+lgJIOgfKpH1Qt0XbX7i0rrGH/oe+roQT5IJKFSVyRKVg==
X-Received: by 2002:a05:6a21:4987:b0:131:47f7:e811 with SMTP id ax7-20020a056a21498700b0013147f7e811mr1172851pzc.22.1691541983113;
        Tue, 08 Aug 2023 17:46:23 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d17-20020aa78151000000b0064398fe3451sm8610310pfn.217.2023.08.08.17.46.22
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 17:46:22 -0700 (PDT)
Message-ID: <64d2e1de.a70a0220.f41e7.fcfa@mx.google.com>
Date: Tue, 08 Aug 2023 17:46:22 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.288-cip101-29-g16cdb005f330
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 107 runs,
 39 regressions (v4.19.288-cip101-29-g16cdb005f330)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Aug 2023 00:46:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12570

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 107 runs, 39 regressio=
ns (v4.19.288-cip101-29-g16cdb005f330)

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

imx6ul-14x14-evk           | arm    | lab-nxp         | gcc-10   | multi_v7=
_defconfig           | 1          =

imx7d-sdb                  | arm    | lab-nxp         | gcc-10   | multi_v7=
_defconfig           | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =

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
g+arm64-chromebook   | 1          =

zynqmp-zcu102              | arm64  | lab-cip         | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.288-cip101-29-g16cdb005f330/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.288-cip101-29-g16cdb005f330
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      16cdb005f330d8d819ec34feac5d718b6d169dcb =



Test Regressions
---------------- =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus  | x86_64 | lab-collabora   | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2d9f41d61ad0ab935b20d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2d9f41d61ad0ab935b212
        failing since 201 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-08-09T00:12:21.008920  + set<8>[   10.344088] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11238400_1.4.2.3.1>

    2023-08-09T00:12:21.009035   +x

    2023-08-09T00:12:21.110881  #

    2023-08-09T00:12:21.211643  / # #export SHELL=3D/bin/sh

    2023-08-09T00:12:21.211832  =


    2023-08-09T00:12:21.312337  / # export SHELL=3D/bin/sh. /lava-11238400/=
environment

    2023-08-09T00:12:21.312517  =


    2023-08-09T00:12:21.413000  / # . /lava-11238400/environment/lava-11238=
400/bin/lava-test-runner /lava-11238400/1

    2023-08-09T00:12:21.413267  =


    2023-08-09T00:12:21.418420  / # /lava-11238400/bin/lava-test-runner /la=
va-11238400/1
 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral   | x86_64 | lab-collabora   | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2da0bd00ab6828f35b1e7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2da0bd00ab6828f35b1ec
        failing since 201 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-08-09T00:12:55.802452  + <8>[   12.060954] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11238390_1.4.2.3.1>

    2023-08-09T00:12:55.802540  set +x

    2023-08-09T00:12:55.903942  #

    2023-08-09T00:12:55.904215  =


    2023-08-09T00:12:56.004827  / # #export SHELL=3D/bin/sh

    2023-08-09T00:12:56.005020  =


    2023-08-09T00:12:56.105531  / # export SHELL=3D/bin/sh. /lava-11238390/=
environment

    2023-08-09T00:12:56.105723  =


    2023-08-09T00:12:56.206277  / # . /lava-11238390/environment/lava-11238=
390/bin/lava-test-runner /lava-11238390/1

    2023-08-09T00:12:56.206554  =

 =

    ... (13 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
at91sam9g20ek              | arm    | lab-broonie     | gcc-10   | multi_v5=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2dac8af5d12914535b1ea

  Results:     42 PASS, 9 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm/multi_v5_defconfig/gcc-1=
0/lab-broonie/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm/multi_v5_defconfig/gcc-1=
0/lab-broonie/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2dac8af5d12914535b21a
        failing since 54 days (last pass: v4.19.283-cip98-224-g5f5303d7920a=
9, first fail: v4.19.284-cip99-114-g02e97826987bf)

    2023-08-09T00:15:28.033718  + set +x
    2023-08-09T00:15:28.038782  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 39589_1.5.2.=
4.1>
    2023-08-09T00:15:28.152251  / # #
    2023-08-09T00:15:28.255150  export SHELL=3D/bin/sh
    2023-08-09T00:15:28.256044  #
    2023-08-09T00:15:28.358010  / # export SHELL=3D/bin/sh. /lava-39589/env=
ironment
    2023-08-09T00:15:28.358813  =

    2023-08-09T00:15:28.460894  / # . /lava-39589/environment/lava-39589/bi=
n/lava-test-runner /lava-39589/1
    2023-08-09T00:15:28.462213  =

    2023-08-09T00:15:28.468649  / # /lava-39589/bin/lava-test-runner /lava-=
39589/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
beaglebone-black           | arm    | lab-broonie     | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2db2a76ee404e2935b276

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm/multi_v7_defconfig/gcc-1=
0/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm/multi_v7_defconfig/gcc-1=
0/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2db2a76ee404e2935b2a1
        failing since 201 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-08-09T00:16:58.847241  <8>[   11.819564] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 39602_1.5.2.4.1>
    2023-08-09T00:16:58.955164  / # #
    2023-08-09T00:16:59.056668  export SHELL=3D/bin/sh
    2023-08-09T00:16:59.057283  #
    2023-08-09T00:16:59.158772  / # export SHELL=3D/bin/sh. /lava-39602/env=
ironment
    2023-08-09T00:16:59.159268  <6>[   12.035124] usb 1-1: new low-speed US=
B device number 3 using musb-hdrc
    2023-08-09T00:16:59.159562  =

    2023-08-09T00:16:59.260832  / # . /lava-39602/environment/lava-39602/bi=
n/lava-test-runner /lava-39602/1
    2023-08-09T00:16:59.261563  =

    2023-08-09T00:16:59.261768  / # <3>[   12.185129] usb 1-1: device descr=
iptor read/64, error -71 =

    ... (17 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
beaglebone-black           | arm    | lab-cip         | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2db2af3ff8505d235b261

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm/multi_v7_defconfig/gcc-1=
0/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm/multi_v7_defconfig/gcc-1=
0/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2db2af3ff8505d235b264
        failing since 201 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-08-09T00:17:07.019274  + set +x
    2023-08-09T00:17:07.026908  <8>[    8.880181] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 994553_1.5.2.4.1>
    2023-08-09T00:17:07.135537  / # #
    2023-08-09T00:17:07.238265  export SHELL=3D/bin/sh
    2023-08-09T00:17:07.238975  #
    2023-08-09T00:17:07.340777  / # export SHELL=3D/bin/sh. /lava-994553/en=
vironment
    2023-08-09T00:17:07.341496  =

    2023-08-09T00:17:07.443375  / # . /lava-994553/environment/lava-994553/=
bin/lava-test-runner /lava-994553/1
    2023-08-09T00:17:07.444580  =

    2023-08-09T00:17:07.450120  / # /lava-994553/bin/lava-test-runner /lava=
-994553/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
beaglebone-black           | arm    | lab-cip         | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2daad047bb2a57235b200

  Results:     41 PASS, 10 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm/omap2plus_defconfig/gcc-=
10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm/omap2plus_defconfig/gcc-=
10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2daad047bb2a57235b203
        new failure (last pass: v4.19.287-cip100-43-g1a6518aa81690)

    2023-08-09T00:15:11.309821  / # #
    2023-08-09T00:15:11.413326  export SHELL=3D/bin/sh
    2023-08-09T00:15:11.414345  #
    2023-08-09T00:15:11.516636  / # export SHELL=3D/bin/sh. /lava-994541/en=
vironment
    2023-08-09T00:15:11.517730  =

    2023-08-09T00:15:11.620125  / # . /lava-994541/environment/lava-994541/=
bin/lava-test-runner /lava-994541/1
    2023-08-09T00:15:11.622076  =

    2023-08-09T00:15:11.661638  / # /lava-994541/bin/lava-test-runner /lava=
-994541/1
    2023-08-09T00:15:11.842004  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-09T00:15:11.842614  + cd /lava-994541/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
dove-cubox                 | arm    | lab-pengutronix | gcc-10   | mvebu_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2da9a6db1b742da35b1dc

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: mvebu_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm/mvebu_v7_defconfig/gcc-1=
0/lab-pengutronix/baseline-dove-cubox.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm/mvebu_v7_defconfig/gcc-1=
0/lab-pengutronix/baseline-dove-cubox.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2da9a6db1b742da35b1e1
        failing since 201 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-08-09T00:15:05.253750  + set +x
    2023-08-09T00:15:05.254092  [    4.247219] <LAVA_SIGNAL_ENDRUN 0_dmesg =
997456_1.5.2.3.1>
    2023-08-09T00:15:05.360670  / # #
    2023-08-09T00:15:05.462729  export SHELL=3D/bin/sh
    2023-08-09T00:15:05.463290  #
    2023-08-09T00:15:05.564585  / # export SHELL=3D/bin/sh. /lava-997456/en=
vironment
    2023-08-09T00:15:05.565270  =

    2023-08-09T00:15:05.666710  / # . /lava-997456/environment/lava-997456/=
bin/lava-test-runner /lava-997456/1
    2023-08-09T00:15:05.667632  =

    2023-08-09T00:15:05.670211  / # /lava-997456/bin/lava-test-runner /lava=
-997456/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx6q-sabrelite            | arm    | lab-collabora   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2dafc263a2720be35b1f0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm/multi_v7_defconfig/gcc-1=
0/lab-collabora/baseline-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm/multi_v7_defconfig/gcc-1=
0/lab-collabora/baseline-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2dafc263a2720be35b1f5
        failing since 201 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-08-09T00:17:25.159217  / # #

    2023-08-09T00:17:25.261317  export SHELL=3D/bin/sh

    2023-08-09T00:17:25.262021  #

    2023-08-09T00:17:25.363382  / # export SHELL=3D/bin/sh. /lava-11238436/=
environment

    2023-08-09T00:17:25.364076  =


    2023-08-09T00:17:25.465458  / # . /lava-11238436/environment/lava-11238=
436/bin/lava-test-runner /lava-11238436/1

    2023-08-09T00:17:25.466572  =


    2023-08-09T00:17:25.483078  / # /lava-11238436/bin/lava-test-runner /la=
va-11238436/1

    2023-08-09T00:17:25.579140  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-09T00:17:25.579648  + cd /lava-11238436/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx6qp-wandboard-revd1     | arm    | lab-pengutronix | gcc-10   | imx_v6_v=
7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2db3a76ee404e2935b2b7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm/imx_v6_v7_defconfig/gcc-=
10/lab-pengutronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm/imx_v6_v7_defconfig/gcc-=
10/lab-pengutronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2db3a76ee404e2935b2bc
        failing since 201 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-08-09T00:17:50.319700  + set +x[    7.395960] <LAVA_SIGNAL_ENDRUN =
0_dmesg 997462_1.5.2.3.1>
    2023-08-09T00:17:50.319918  =

    2023-08-09T00:17:50.426809  / # #
    2023-08-09T00:17:50.528549  export SHELL=3D/bin/sh
    2023-08-09T00:17:50.529033  #
    2023-08-09T00:17:50.630297  / # export SHELL=3D/bin/sh. /lava-997462/en=
vironment
    2023-08-09T00:17:50.630788  =

    2023-08-09T00:17:50.732175  / # . /lava-997462/environment/lava-997462/=
bin/lava-test-runner /lava-997462/1
    2023-08-09T00:17:50.732781  =

    2023-08-09T00:17:50.735574  / # /lava-997462/bin/lava-test-runner /lava=
-997462/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx6qp-wandboard-revd1     | arm    | lab-pengutronix | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2daeb6a6e922b8635b1dd

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm/multi_v7_defconfig/gcc-1=
0/lab-pengutronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm/multi_v7_defconfig/gcc-1=
0/lab-pengutronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2daeb6a6e922b8635b1e2
        failing since 201 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-08-09T00:16:23.778853  + set +x
    2023-08-09T00:16:23.779067  [    4.989874] <LAVA_SIGNAL_ENDRUN 0_dmesg =
997460_1.5.2.3.1>
    2023-08-09T00:16:23.885294  / # #
    2023-08-09T00:16:23.987048  export SHELL=3D/bin/sh
    2023-08-09T00:16:23.987530  #
    2023-08-09T00:16:24.088779  / # export SHELL=3D/bin/sh. /lava-997460/en=
vironment
    2023-08-09T00:16:24.089346  =

    2023-08-09T00:16:24.190709  / # . /lava-997460/environment/lava-997460/=
bin/lava-test-runner /lava-997460/1
    2023-08-09T00:16:24.191364  =

    2023-08-09T00:16:24.193479  / # /lava-997460/bin/lava-test-runner /lava=
-997460/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx6ul-14x14-evk           | arm    | lab-nxp         | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2db3676ee404e2935b2aa

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm/multi_v7_defconfig/gcc-1=
0/lab-nxp/baseline-imx6ul-14x14-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm/multi_v7_defconfig/gcc-1=
0/lab-nxp/baseline-imx6ul-14x14-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2db3676ee404e2935b2ad
        failing since 110 days (last pass: v4.19.259-cip82-57-ge54228ee5a88=
d, first fail: v4.19.280-cip96-59-g4b02e7efb967d)

    2023-08-09T00:17:33.709159  + set +x<8>[   22.903176] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 1241943_1.5.2.4.1>
    2023-08-09T00:17:33.709454  =

    2023-08-09T00:17:33.816900  =

    2023-08-09T00:17:34.972457  / # #export SHELL=3D/bin/sh
    2023-08-09T00:17:34.978082  =

    2023-08-09T00:17:36.520136  / # export SHELL=3D/bin/sh. /lava-1241943/e=
nvironment
    2023-08-09T00:17:36.525800  =

    2023-08-09T00:17:39.337600  / # . /lava-1241943/environment/lava-124194=
3/bin/lava-test-runner /lava-1241943/1
    2023-08-09T00:17:39.343662  =

    2023-08-09T00:17:39.345303  / # /lava-1241943/bin/lava-test-runner /lav=
a-1241943/1 =

    ... (15 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx7d-sdb                  | arm    | lab-nxp         | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2db2276ee404e2935b24a

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm/multi_v7_defconfig/gcc-1=
0/lab-nxp/baseline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm/multi_v7_defconfig/gcc-1=
0/lab-nxp/baseline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2db2276ee404e2935b24d
        failing since 196 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.270-cip89-39-g43ce130174aa)

    2023-08-09T00:17:17.579968  / # #
    2023-08-09T00:17:18.733995  export SHELL=3D/bin/sh
    2023-08-09T00:17:18.739381  #
    2023-08-09T00:17:20.280298  / # export SHELL=3D/bin/sh. /lava-1241942/e=
nvironment
    2023-08-09T00:17:20.285935  =

    2023-08-09T00:17:23.097573  / # . /lava-1241942/environment/lava-124194=
2/bin/lava-test-runner /lava-1241942/1
    2023-08-09T00:17:23.103584  =

    2023-08-09T00:17:23.104938  / # /lava-1241942/bin/lava-test-runner /lav=
a-1241942/1
    2023-08-09T00:17:23.210888  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-09T00:17:23.211311  + cd /lava-1241942/1/tests/1_bootrr =

    ... (16 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2dea8754f0fa59f35b2af

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d2dea8754f0fa59f35b=
2b0
        failing since 447 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2e02402d39393de35b219

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm64/defconfig/gcc-10/lab-b=
roonie/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm64/defconfig/gcc-10/lab-b=
roonie/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d2e02402d39393de35b=
21a
        failing since 447 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2dbf445623b702235b2ae

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d2dbf445623b702235b=
2af
        failing since 447 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2dc45c8f9c389df35b1db

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d2dc45c8f9c389df35b=
1dc
        failing since 447 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2df131ea2936fd135b1e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d2df131ea2936fd135b=
1e7
        failing since 447 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2e04d55de4da57435b1df

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm64/defconfig/gcc-10/lab-b=
roonie/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm64/defconfig/gcc-10/lab-b=
roonie/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d2e04d55de4da57435b=
1e0
        failing since 447 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2dbf545623b702235b2b4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d2dbf545623b702235b=
2b5
        failing since 447 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2dc6bb1182f1f1835b1e7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d2dc6bb1182f1f1835b=
1e8
        failing since 447 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2dd4019c19edd9b35b1de

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d2dd4019c19edd9b35b=
1df
        failing since 447 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2e06145d6f7a85335b1e0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm64/defconfig/gcc-10/lab-b=
roonie/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm64/defconfig/gcc-10/lab-b=
roonie/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d2e06145d6f7a85335b=
1e1
        failing since 447 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2dbf345623b702235b2ab

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d2dbf345623b702235b=
2ac
        failing since 447 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2dc814701027cf535b219

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d2dc814701027cf535b=
21a
        failing since 447 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2ddabd10ad0afe335b1d9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d2ddabd10ad0afe335b=
1da
        failing since 447 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2e03955de4da57435b1db

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm64/defconfig/gcc-10/lab-b=
roonie/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm64/defconfig/gcc-10/lab-b=
roonie/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d2e03955de4da57435b=
1dc
        failing since 447 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2dbf445623b702235b2b1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d2dbf445623b702235b=
2b2
        failing since 447 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2dc58c8f9c389df35b1e0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d2dc58c8f9c389df35b=
1e1
        failing since 447 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
r8a7743-iwg20d-q7          | arm    | lab-cip         | gcc-10   | shmobile=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2db40146e193c6135b1db

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm/shmobile_defconfig/gcc-1=
0/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm/shmobile_defconfig/gcc-1=
0/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d2db40146e193c6135b=
1dc
        failing since 40 days (last pass: v4.19.284-cip99-114-g02e97826987b=
f, first fail: v4.19.287-cip100-43-g1a6518aa81690) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
r8a7796-m3ulcb             | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2db0ef3ff8505d235b1db

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-r8a7796-m3ulcb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-r8a7796-m3ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2db0ef3ff8505d235b1e0
        failing since 201 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-08-09T00:18:51.605400  / # #

    2023-08-09T00:18:51.707504  export SHELL=3D/bin/sh

    2023-08-09T00:18:51.708218  #

    2023-08-09T00:18:51.809731  / # export SHELL=3D/bin/sh. /lava-11238461/=
environment

    2023-08-09T00:18:51.810458  =


    2023-08-09T00:18:51.911973  / # . /lava-11238461/environment/lava-11238=
461/bin/lava-test-runner /lava-11238461/1

    2023-08-09T00:18:51.913161  =


    2023-08-09T00:18:51.929554  / # /lava-11238461/bin/lava-test-runner /la=
va-11238461/1

    2023-08-09T00:18:51.979547  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-09T00:18:51.980043  + cd /lav<8>[   13.386251] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11238461_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
rk3288-veyron-jaq          | arm    | lab-collabora   | gcc-10   | multi_v7=
_defconfig           | 3          =


  Details:     https://kernelci.org/test/plan/id/64d2dae76db1b742da35b255

  Results:     61 PASS, 8 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm/multi_v7_defconfig/gcc-1=
0/lab-collabora/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm/multi_v7_defconfig/gcc-1=
0/lab-collabora/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/64d2dae76db1b742da35b285
        failing since 200 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-08-09T00:17:59.073621  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC)<8=
>[   10.314011] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-08-09T00:17:59.075589   multi-call binary.

    2023-08-09T00:17:59.075807  =


    2023-08-09T00:17:59.080191  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-08-09T00:17:59.080265  =


    2023-08-09T00:17:59.085428  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/64d2dae76db1b742da35b286
        failing since 200 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-08-09T00:17:59.054798  /lava-11238434/1/../bin/lava-test-case<8>[ =
  10.296626] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-probed RE=
SULT=3Dpass>

    2023-08-09T00:17:59.054856  =

   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2dae76db1b742da35b299
        failing since 200 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-08-09T00:17:55.223150  <8>[    6.465014] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-08-09T00:17:55.232586  + <8>[    6.477239] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11238434_1.5.2.3.1>

    2023-08-09T00:17:55.235134  set +x

    2023-08-09T00:17:55.339321  #

    2023-08-09T00:17:55.340454  =


    2023-08-09T00:17:55.442129  / # #export SHELL=3D/bin/sh

    2023-08-09T00:17:55.442833  =


    2023-08-09T00:17:55.544245  / # export SHELL=3D/bin/sh. /lava-11238434/=
environment

    2023-08-09T00:17:55.544982  =


    2023-08-09T00:17:55.646441  / # . /lava-11238434/environment/lava-11238=
434/bin/lava-test-runner /lava-11238434/1
 =

    ... (18 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
rk3399-gru-kevin           | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64d2db2176ee404e2935b1f3

  Results:     77 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/64d2db2176ee404e2935b1f9
        failing since 147 days (last pass: v4.19.273-cip92-277-g507c8d80b9e=
20, first fail: v4.19.276-cip93-5-g2eb2a953ab59)

    2023-08-09T00:17:26.127017  /lava-11238427/1/../bin/lava-test-case

    2023-08-09T00:17:26.136470  <8>[   37.499467] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/64d2db2176ee404e2935b1fa
        failing since 147 days (last pass: v4.19.273-cip92-277-g507c8d80b9e=
20, first fail: v4.19.276-cip93-5-g2eb2a953ab59)

    2023-08-09T00:17:25.104924  /lava-11238427/1/../bin/lava-test-case

    2023-08-09T00:17:25.113469  <8>[   36.477155] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus     | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2db4676ee404e2935b2c5

  Results:     23 PASS, 16 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm64/defconfig/gcc-10/lab-b=
roonie/baseline-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm64/defconfig/gcc-10/lab-b=
roonie/baseline-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2db4676ee404e2935b2eb
        failing since 201 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-08-09T00:17:35.526295  <8>[   15.935848] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 39638_1.5.2.4.1>
    2023-08-09T00:17:35.635057  / # #
    2023-08-09T00:17:35.737558  export SHELL=3D/bin/sh
    2023-08-09T00:17:35.738137  #
    2023-08-09T00:17:35.839992  / # export SHELL=3D/bin/sh. /lava-39638/env=
ironment
    2023-08-09T00:17:35.841298  =

    2023-08-09T00:17:35.944079  / # . /lava-39638/environment/lava-39638/bi=
n/lava-test-runner /lava-39638/1
    2023-08-09T00:17:35.945112  =

    2023-08-09T00:17:35.948612  / # /lava-39638/bin/lava-test-runner /lava-=
39638/1
    2023-08-09T00:17:35.980537  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64         | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2db2276ee404e2935b255

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2db2276ee404e2935b25a
        failing since 201 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-08-09T00:18:55.078010  / # #

    2023-08-09T00:18:55.179710  export SHELL=3D/bin/sh

    2023-08-09T00:18:55.180326  #

    2023-08-09T00:18:55.281452  / # export SHELL=3D/bin/sh. /lava-11238455/=
environment

    2023-08-09T00:18:55.282087  =


    2023-08-09T00:18:55.383171  / # . /lava-11238455/environment/lava-11238=
455/bin/lava-test-runner /lava-11238455/1

    2023-08-09T00:18:55.384076  =


    2023-08-09T00:18:55.386045  / # /lava-11238455/bin/lava-test-runner /la=
va-11238455/1

    2023-08-09T00:18:55.457882  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-09T00:18:55.458340  + cd /lava-1123845<8>[   15.643823] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11238455_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
zynqmp-zcu102              | arm64  | lab-cip         | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2dc3260297b7d5135b1da

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2dc3260297b7d5135b1dd
        failing since 201 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-08-09T00:21:50.562609  + set +x
    2023-08-09T00:21:50.563758  <8>[    3.714267] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 994546_1.5.2.4.1>
    2023-08-09T00:21:50.671197  / # #
    2023-08-09T00:21:50.773022  export SHELL=3D/bin/sh
    2023-08-09T00:21:50.773471  #
    2023-08-09T00:21:50.874880  / # export SHELL=3D/bin/sh. /lava-994546/en=
vironment
    2023-08-09T00:21:50.875492  =

    2023-08-09T00:21:50.976912  / # . /lava-994546/environment/lava-994546/=
bin/lava-test-runner /lava-994546/1
    2023-08-09T00:21:50.977645  =

    2023-08-09T00:21:50.980625  / # /lava-994546/bin/lava-test-runner /lava=
-994546/1 =

    ... (13 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
zynqmp-zcu102              | arm64  | lab-cip         | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2dcbe9162fc5e6835b323

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm64/defconfig/gcc-10/lab-c=
ip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm64/defconfig/gcc-10/lab-c=
ip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2dcbe9162fc5e6835b326
        failing since 201 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-08-09T00:24:10.252892  + set +x
    2023-08-09T00:24:10.254015  <8>[    3.754214] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 994560_1.5.2.4.1>
    2023-08-09T00:24:10.361644  / # #
    2023-08-09T00:24:10.463269  export SHELL=3D/bin/sh
    2023-08-09T00:24:10.463731  #
    2023-08-09T00:24:10.565135  / # export SHELL=3D/bin/sh. /lava-994560/en=
vironment
    2023-08-09T00:24:10.565803  =

    2023-08-09T00:24:10.667532  / # . /lava-994560/environment/lava-994560/=
bin/lava-test-runner /lava-994560/1
    2023-08-09T00:24:10.668663  =

    2023-08-09T00:24:10.670836  / # /lava-994560/bin/lava-test-runner /lava=
-994560/1 =

    ... (13 line(s) more)  =

 =20

