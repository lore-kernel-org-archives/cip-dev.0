Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB41C5478C
	for <webhook@archiver.kernel.org>; Fri,  1 Mar 2024 15:28:05 +0000 (UTC)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.web10.25930.1709306875754665843
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 01 Mar 2024 07:27:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=x6czUBrb;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.169, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e53f3f1f82so1534963b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 01 Mar 2024 07:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709306875; x=1709911675; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rwCCJQjFJ52afl3bTPqBt750S/C3Fu4DjrFctOZ+7f0=;
        b=x6czUBrbgYjIwCIHObs3bgMsJk+i2slIZScUiEFP5jJwKPukZJDDxiXrlzIQvq3Jav
         4m45mDXmAMJrniJn0JikGswtmoNAS4b5ozP5HJ6LII4U4nfg/6Ab+5U/LO1OXyTNQkz6
         kaqqi16fihMA4fV52ZWMf1lvfC71Bmf8DPxBKx+PMKvwd2ne2cVjYV9O9AdtN+yVDNJT
         +Zz/Z3NorxZp6Lqo/kEXr86f1sPB3q8cpMPDprSKtEZRJTZiom8iQh+w2oZpk4p2/vy+
         f1qdvk5+jx17WocEkQIzgErAmFsEaeXi/aMmmLYCKmOvJc3MZJYRwNKpG7Q+10bf3Q3D
         aqpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709306875; x=1709911675;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rwCCJQjFJ52afl3bTPqBt750S/C3Fu4DjrFctOZ+7f0=;
        b=sac3NUj7rHWD1abP6FnqTlgDP/3YtVvR+ppE542SJfTlGM0pgACK8nDZSPz7aJ849G
         p+pv76BmJo8APLe0c/yfolMktJX6iOv0+OXUTKeUxKCBcGjoQgI+PcjQ/DO36JEmm+Sy
         XJhYFYEPY7DBa4PLBBYEoLwD5M4kOI8f3sTjT55knnQCXSnljof+1SvzTvG1HXSExjQZ
         6oPtxHbAvB+I+HTvj+zLlmX1ZUsNICX1Enn85kmb11qwnZbPQNpO34HDwnTA+Cpq3QSm
         EzX3FCpt7qIIQ5giuueQgeasQ/9HNA1BIV6LQNg4vZz4HlipqLZyuZ6nTjK++71zh1vu
         puGg==
X-Gm-Message-State: AOJu0Yyo0t5PFfRaL+IBWFvNWlxKo7s21DdNA1o7SPjoG6b9yq1b1wld
	HcPXtWaoOKcAw/VXz9crSClq0XxK1uO3Fux5ewAd67gInjRyCrk0Pc5n8R8JIrkx1zl2MfiHPuC
	yVTQ=
X-Google-Smtp-Source: AGHT+IEL+gFRuA9Lyv/KFWlb/cKxf/yy4YBEreXqobJux15bGtsieghtZeW70sf+3+i+odstAdzunw==
X-Received: by 2002:a05:6a00:6606:b0:6e5:5bb4:7098 with SMTP id he6-20020a056a00660600b006e55bb47098mr1573812pfb.7.1709306874734;
        Fri, 01 Mar 2024 07:27:54 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id w5-20020a056a0014c500b006e543b59587sm3058855pfu.126.2024.03.01.07.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 07:27:53 -0800 (PST)
Message-ID: <65e1f3f9.050a0220.ca916.de26@mx.google.com>
Date: Fri, 01 Mar 2024 07:27:53 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.209-cip44-56-g6ff909810a18d
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip baseline-nfs: 40 runs,
 6 regressions (v5.10.209-cip44-56-g6ff909810a18d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 01 Mar 2024 15:28:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15126

cip/linux-5.10.y-cip baseline-nfs: 40 runs, 6 regressions (v5.10.209-cip44-=
56-g6ff909810a18d)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
        | regressions
-----------------+-------+---------------+----------+----------------------=
--------+------------
beaglebone-black | arm   | lab-broonie   | gcc-10   | omap2plus_defconfig  =
        | 1          =

beaglebone-black | arm   | lab-cip       | gcc-10   | omap2plus_defconfig  =
        | 1          =

imx6q-sabrelite  | arm   | lab-collabora | gcc-10   | multi_v7_defconfig   =
        | 1          =

juno-uboot       | arm64 | lab-broonie   | gcc-10   | cip://5.10.y-...64_de=
fconfig | 1          =

rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook   | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.209-cip44-56-g6ff909810a18d/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.209-cip44-56-g6ff909810a18d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      6ff909810a18da01523521db983d48116abb28ec =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
        | regressions
-----------------+-------+---------------+----------+----------------------=
--------+------------
beaglebone-black | arm   | lab-broonie   | gcc-10   | omap2plus_defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/65e1e89e2896ff68f3637020

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-56-g6ff909810a18d/arm/omap2plus_defconfig/gcc-10/lab-broonie/baselin=
e-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-56-g6ff909810a18d/arm/omap2plus_defconfig/gcc-10/lab-broonie/baselin=
e-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65e1e89e2896ff68f3637053
        failing since 412 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-03-01T14:38:55.552418  <8>[   44.874550] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 649903_1.6.2.4.1>
    2024-03-01T14:38:55.673871  / # #
    2024-03-01T14:38:55.777092  export SHELL=3D/bin/sh
    2024-03-01T14:38:55.777983  #
    2024-03-01T14:38:55.879818  / # export SHELL=3D/bin/sh. /lava-649903/en=
vironment
    2024-03-01T14:38:55.880773  =

    2024-03-01T14:38:55.982908  / # . /lava-649903/environment/lava-649903/=
bin/lava-test-runner /lava-649903/1
    2024-03-01T14:38:55.984311  =

    2024-03-01T14:38:55.988598  / # /lava-649903/bin/lava-test-runner /lava=
-649903/1
    2024-03-01T14:38:56.268341  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform         | arch  | lab           | compiler | defconfig            =
        | regressions
-----------------+-------+---------------+----------+----------------------=
--------+------------
beaglebone-black | arm   | lab-cip       | gcc-10   | omap2plus_defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/65e1f3f1a20e7587f263702c

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-56-g6ff909810a18d/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nf=
s-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-56-g6ff909810a18d/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nf=
s-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65e1f3f1a20e7587f2637062
        failing since 412 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-03-01T15:27:13.509128  <8>[   40.121732] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1101232_1.6.2.4.1>
    2024-03-01T15:27:13.626586  / # #
    2024-03-01T15:27:13.727947  export SHELL=3D/bin/sh
    2024-03-01T15:27:13.728379  #
    2024-03-01T15:27:13.829265  / # export SHELL=3D/bin/sh. /lava-1101232/e=
nvironment
    2024-03-01T15:27:13.829698  =

    2024-03-01T15:27:13.930690  / # . /lava-1101232/environment/lava-110123=
2/bin/lava-test-runner /lava-1101232/1
    2024-03-01T15:27:13.931544  =

    2024-03-01T15:27:13.935657  / # /lava-1101232/bin/lava-test-runner /lav=
a-1101232/1
    2024-03-01T15:27:14.174082  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform         | arch  | lab           | compiler | defconfig            =
        | regressions
-----------------+-------+---------------+----------+----------------------=
--------+------------
imx6q-sabrelite  | arm   | lab-collabora | gcc-10   | multi_v7_defconfig   =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/65e1eaaa64c9a29a25637043

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-56-g6ff909810a18d/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-nfs-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-56-g6ff909810a18d/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-nfs-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65e1eaaa64c9a29a25637048
        failing since 412 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-03-01T14:47:56.303488  / # #

    2024-03-01T14:47:56.406721  export SHELL=3D/bin/sh

    2024-03-01T14:47:56.407614  #

    2024-03-01T14:47:56.509561  / # export SHELL=3D/bin/sh. /lava-12907254/=
environment

    2024-03-01T14:47:56.510433  =


    2024-03-01T14:47:56.612211  / # . /lava-12907254/environment/lava-12907=
254/bin/lava-test-runner /lava-12907254/1

    2024-03-01T14:47:56.613683  =


    2024-03-01T14:47:56.624908  / # /lava-12907254/bin/lava-test-runner /la=
va-12907254/1

    2024-03-01T14:47:56.800609  + export TESTRUN_ID=3D1_bootrr

    2024-03-01T14:47:56.816593  + cd /lava-12907254/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform         | arch  | lab           | compiler | defconfig            =
        | regressions
-----------------+-------+---------------+----------+----------------------=
--------+------------
juno-uboot       | arm64 | lab-broonie   | gcc-10   | cip://5.10.y-...64_de=
fconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/65e1e6e07567b3e27663702d

  Results:     47 PASS, 13 FAIL, 1 SKIP
  Full config: cip://5.10.y-cip/arm64/qemu_arm64_defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-56-g6ff909810a18d/arm64/cip---5.10.y-cip-arm64-qemu_arm64_defconfig/=
gcc-10/lab-broonie/baseline-nfs-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-56-g6ff909810a18d/arm64/cip---5.10.y-cip-arm64-qemu_arm64_defconfig/=
gcc-10/lab-broonie/baseline-nfs-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65e1e6e07567b3e276637068
        failing since 149 days (last pass: v5.10.184-cip36-8-gb192df20e8c9,=
 first fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2024-03-01T14:31:33.644200  <8>[   39.017571] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 649898_1.6.2.4.1>
    2024-03-01T14:31:33.748982  / # #
    2024-03-01T14:31:33.851529  export SHELL=3D/bin/sh
    2024-03-01T14:31:33.852279  #
    2024-03-01T14:31:33.954129  / # export SHELL=3D/bin/sh. /lava-649898/en=
vironment
    2024-03-01T14:31:33.954887  =

    2024-03-01T14:31:34.056912  / # . /lava-649898/environment/lava-649898/=
bin/lava-test-runner /lava-649898/1
    2024-03-01T14:31:34.058208  =

    2024-03-01T14:31:34.077791  / # /lava-649898/bin/lava-test-runner /lava=
-649898/1
    2024-03-01T14:31:34.230303  + export TESTRUN_ID=3D1_bootrr =

    ... (10 line(s) more)  =

 =



platform         | arch  | lab           | compiler | defconfig            =
        | regressions
-----------------+-------+---------------+----------+----------------------=
--------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/65e1eb9210a735c6b5637012

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-56-g6ff909810a18d/arm64/defconfig+arm64-chromebook/gcc-10/lab-collab=
ora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-56-g6ff909810a18d/arm64/defconfig+arm64-chromebook/gcc-10/lab-collab=
ora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/65e1eb9210a735c6b5637018
        failing since 345 days (last pass: v5.10.173-cip28, first fail: v5.=
10.175-cip29)

    2024-03-01T14:54:40.682971  <8>[   36.248717] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2024-03-01T14:54:41.735477  /lava-12907290/1/../bin/lava-test-case

    2024-03-01T14:54:41.770240  <8>[   37.336249] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/65e1eb9210a735c6b5637019
        failing since 345 days (last pass: v5.10.173-cip28, first fail: v5.=
10.175-cip29)

    2024-03-01T14:54:39.586763  <8>[   35.151869] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2024-03-01T14:54:40.649609  /lava-12907290/1/../bin/lava-test-case
   =

 =20

