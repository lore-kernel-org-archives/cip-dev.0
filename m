Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811E8C77B7E
	for <webhook@archiver.kernel.org>; Mon, 29 May 2023 07:36:42 +0000 (UTC)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
 by mx.groups.io with SMTP id smtpd.web10.44780.1685345799201186325
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 29 May 2023 00:36:39 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=1nYKWkSy;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.43, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-25669acf1b0so1040023a91.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 29 May 2023 00:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685345798; x=1687937798;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IClPoNCBss2QeHoShn5m/nhMz8/x6HrdR99vqQaVTYQ=;
        b=1nYKWkSyZwPerxNkRrTHRcllv2FlYmUaTp1drWhLRzDEwhCNcr3CNZQhR5tahOaxiT
         jYPrZSFT63FAkAzCYqMx2MpGkZwiJDYfK+zJJOKO3Z6BKyHtWB0Xwn5yTT3UvNkX1GTB
         VtbLSCfPxe6vs7kwKFH1R8XTKB1rtxGO/sJ8s31kmfSonXL/ovrFfeDCy4/nGaGfAil9
         JK7CehAakDER+m/xVcufmzuJM4TI5IGD/S/yIYEC/CDYKt3Jes9zENPZvg8NffSI0Z6Y
         3LMn448aCdb8LPK5T5KGjwHywwEed+lx9v7AEnilVIqPKbyvWYwMPr722huo8MlLbvSb
         p6+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685345798; x=1687937798;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IClPoNCBss2QeHoShn5m/nhMz8/x6HrdR99vqQaVTYQ=;
        b=QVAurAJM7LFvTQ+NWvv0ieWa58scFqrNtbJq5migMPLYEhYVPipkYaIr21hwe0QMsN
         zvz46yBzMAmqzys3+DR6Fhg/no2zPyNwCeyOiDcZN19PYy320eEgqeD813r3TdlW1/4K
         qz6aZgRllFbuGqG3NPdF4Xao8JM19OguUaTV6EMLR9H7uPK28lSCkDtDABJteiZZ+WuU
         Ew0MCyNyc1nRPcAt1CmJwaeDp2rv/gmfjNjGZ1FX2XF5nrTANLp5yxZjWhsW1SQzaMEo
         vCNf4Y5f411eDNEH2Y036tx6ZosvtE42fmbKRfuN5mOD/H8bA28UIzOAYxrlW91dez8v
         apdg==
X-Gm-Message-State: AC+VfDxOTaXgCPdeTRnqcrgNlpGs4EwwkiN4daug13qb/F62yxZgVfPI
	/W3he81eW2wKupXtjYAvM19oiCb7qlJnbQwkUe4Qqg==
X-Google-Smtp-Source: ACHHUZ5iVQ62TxpF5megmARSAjffTqlGqZa/uSOChslzgUJ+OxLIaiIaxezKg902P5xpAghiXUMX6w==
X-Received: by 2002:a17:90a:7c01:b0:247:afed:6d62 with SMTP id v1-20020a17090a7c0100b00247afed6d62mr10036982pjf.46.1685345797889;
        Mon, 29 May 2023 00:36:37 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 10-20020a63144a000000b00519c3475f21sm6453949pgu.46.2023.05.29.00.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 00:36:37 -0700 (PDT)
Message-ID: <64745605.630a0220.99a67.bf05@mx.google.com>
Date: Mon, 29 May 2023 00:36:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.180-cip34
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip baseline-nfs: 52 runs,
 14 regressions (v5.10.180-cip34)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 May 2023 07:36:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11685

cip/linux-5.10.y-cip baseline-nfs: 52 runs, 14 regressions (v5.10.180-cip34)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.180-cip34/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.180-cip34
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      aa80091745d6b40c944d419c12ba8cb65b1a57a5 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64744cefb5d2d5520b2e861c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230519.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64744cefb5d2d5520b2e8621
        failing since 135 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-29T06:57:33.920380  [   18.020465] <LAVA_SIGNAL_ENDRUN 0_dmesg =
10505822_1.5.2.3.1>

    2023-05-29T06:57:33.923844  + set +x

    2023-05-29T06:57:34.025356  / # #

    2023-05-29T06:57:34.126054  export SHELL=3D/bin/sh

    2023-05-29T06:57:34.126279  #

    2023-05-29T06:57:34.226805  / # export SHELL=3D/bin/sh. /lava-10505822/=
environment

    2023-05-29T06:57:34.227000  =


    2023-05-29T06:57:34.327570  / # . /lava-10505822/environment/lava-10505=
822/bin/lava-test-runner /lava-10505822/1

    2023-05-29T06:57:34.327859  =


    2023-05-29T06:57:34.333320  / # /lava-10505822/bin/lava-test-runner /la=
va-10505822/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64744d53aa60f9e0fa2e85ee

  Results:     47 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-nfs-at91sam9g20ek=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-nfs-at91sam9g20ek=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230519.0/armel/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64744d54aa60f9e0fa2e8621
        failing since 135 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-29T06:58:59.518519  + set +x
    2023-05-29T06:58:59.523558  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 530075_1.6.2=
.4.1>
    2023-05-29T06:58:59.652493  #
    2023-05-29T06:58:59.755896  / # #export SHELL=3D/bin/sh
    2023-05-29T06:58:59.756681  =

    2023-05-29T06:58:59.858630  / # export SHELL=3D/bin/sh. /lava-530075/en=
vironment
    2023-05-29T06:58:59.859561  =

    2023-05-29T06:58:59.961638  / # . /lava-530075/environment/lava-530075/=
bin/lava-test-runner /lava-530075/1
    2023-05-29T06:58:59.963125  =

    2023-05-29T06:58:59.969801  / # /lava-530075/bin/lava-test-runner /lava=
-530075/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64744f4ddc2aeba3432e85fe

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-bl=
ack.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-bl=
ack.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230519.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64744f4ddc2aeba3432e8621
        failing since 135 days (last pass: v5.10.158-cip22, first fail: v5.=
10.162-cip24)

    2023-05-29T07:07:06.395067  <8>[   51.781092] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 530128_1.6.2.4.1>
    2023-05-29T07:07:06.509332  / # #
    2023-05-29T07:07:06.611862  export SHELL=3D/bin/sh
    2023-05-29T07:07:06.612458  #
    2023-05-29T07:07:06.714019  / # export SHELL=3D/bin/sh. /lava-530128/en=
vironment
    2023-05-29T07:07:06.714483  =

    2023-05-29T07:07:06.816048  / # . /lava-530128/environment/lava-530128/=
bin/lava-test-runner /lava-530128/1
    2023-05-29T07:07:06.817093  =

    2023-05-29T07:07:06.821368  / # /lava-530128/bin/lava-test-runner /lava=
-530128/1
    2023-05-29T07:07:07.015620  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647451bf6aa4828e112e85fd

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebone-black.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebone-black.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230519.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647451bf6aa4828e112e8600
        failing since 135 days (last pass: v5.10.158-cip22, first fail: v5.=
10.162-cip24)

    2023-05-29T07:17:41.822681  + set +x
    2023-05-29T07:17:41.824454  [   48.499401] <LAVA_SIGNAL_ENDRUN 0_dmesg =
946368_1.6.2.4.1>
    2023-05-29T07:17:41.940456  / # #
    2023-05-29T07:17:42.042282  export SHELL=3D/bin/sh
    2023-05-29T07:17:42.042743  #
    2023-05-29T07:17:42.144122  / # export SHELL=3D/bin/sh. /lava-946368/en=
vironment
    2023-05-29T07:17:42.144585  =

    2023-05-29T07:17:42.246060  / # . /lava-946368/environment/lava-946368/=
bin/lava-test-runner /lava-946368/1
    2023-05-29T07:17:42.246928  =

    2023-05-29T07:17:42.248867  / # /lava-946368/bin/lava-test-runner /lava=
-946368/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64744d76baf03178302e8605

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-b=
lack.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-b=
lack.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230519.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64744d76baf03178302e863b
        failing since 117 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.165-cip25)

    2023-05-29T06:59:49.902780  <8>[   44.586473] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 530107_1.6.2.4.1>
    2023-05-29T06:59:50.022286  / # #
    2023-05-29T06:59:50.124853  export SHELL=3D/bin/sh
    2023-05-29T06:59:50.125427  #
    2023-05-29T06:59:50.227488  / # export SHELL=3D/bin/sh. /lava-530107/en=
vironment
    2023-05-29T06:59:50.228053  =

    2023-05-29T06:59:50.330201  / # . /lava-530107/environment/lava-530107/=
bin/lava-test-runner /lava-530107/1
    2023-05-29T06:59:50.331324  =

    2023-05-29T06:59:50.335639  / # /lava-530107/bin/lava-test-runner /lava=
-530107/1
    2023-05-29T06:59:50.564600  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64744e9f0b9dd8d7ee2e8702

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebone-black=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebone-black=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230519.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64744e9f0b9dd8d7ee2e8705
        failing since 117 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.165-cip25)

    2023-05-29T07:04:40.661899  + set +x
    2023-05-29T07:04:40.663939  <8>[   39.557036] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 946361_1.6.2.4.1>
    2023-05-29T07:04:40.782063  / # #
    2023-05-29T07:04:40.884386  export SHELL=3D/bin/sh
    2023-05-29T07:04:40.884906  #
    2023-05-29T07:04:40.986366  / # export SHELL=3D/bin/sh. /lava-946361/en=
vironment
    2023-05-29T07:04:40.987201  =

    2023-05-29T07:04:41.088858  / # . /lava-946361/environment/lava-946361/=
bin/lava-test-runner /lava-946361/1
    2023-05-29T07:04:41.089745  =

    2023-05-29T07:04:41.091610  / # /lava-946361/bin/lava-test-runner /lava=
-946361/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64744ce5bde9b0b1262e85f7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230519.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64744ce5bde9b0b1262e85fc
        failing since 44 days (last pass: v5.10.176-cip30, first fail: v5.1=
0.177-cip31)

    2023-05-29T06:57:23.867261  + set +x<8>[   18.600953] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10505819_1.5.2.3.1>

    2023-05-29T06:57:23.867773  =


    2023-05-29T06:57:23.975720  / # #

    2023-05-29T06:57:24.078282  export SHELL=3D/bin/sh

    2023-05-29T06:57:24.079060  #

    2023-05-29T06:57:24.180565  / # export SHELL=3D/bin/sh. /lava-10505819/=
environment

    2023-05-29T06:57:24.181323  =


    2023-05-29T06:57:24.282927  / # . /lava-10505819/environment/lava-10505=
819/bin/lava-test-runner /lava-10505819/1

    2023-05-29T06:57:24.284156  =


    2023-05-29T06:57:24.288623  / # /lava-10505819/bin/lava-test-runner /la=
va-10505819/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64744ce1bde9b0b1262e85e9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230519.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64744ce1bde9b0b1262e85ee
        failing since 44 days (last pass: v5.10.176-cip30, first fail: v5.1=
0.177-cip31)

    2023-05-29T06:57:17.993000  + set +x

    2023-05-29T06:57:17.999626  <8>[   20.156729] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10505835_1.5.2.3.1>

    2023-05-29T06:57:18.104166  / # #

    2023-05-29T06:57:18.204944  export SHELL=3D/bin/sh

    2023-05-29T06:57:18.205196  #

    2023-05-29T06:57:18.305775  / # export SHELL=3D/bin/sh. /lava-10505835/=
environment

    2023-05-29T06:57:18.306039  =


    2023-05-29T06:57:18.406626  / # . /lava-10505835/environment/lava-10505=
835/bin/lava-test-runner /lava-10505835/1

    2023-05-29T06:57:18.407023  =


    2023-05-29T06:57:18.412364  / # /lava-10505835/bin/lava-test-runner /la=
va-10505835/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64744e7717e47e49a62e85f7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-nfs-imx6q-sabre=
lite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-nfs-imx6q-sabre=
lite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230519.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64744e7717e47e49a62e85fc
        failing since 135 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-29T07:04:05.855962  / # #

    2023-05-29T07:04:05.956713  export SHELL=3D/bin/sh

    2023-05-29T07:04:05.956992  #

    2023-05-29T07:04:06.057600  / # export SHELL=3D/bin/sh. /lava-10505954/=
environment

    2023-05-29T07:04:06.057809  =


    2023-05-29T07:04:06.158384  / # . /lava-10505954/environment/lava-10505=
954/bin/lava-test-runner /lava-10505954/1

    2023-05-29T07:04:06.158752  =


    2023-05-29T07:04:06.169098  / # /lava-10505954/bin/lava-test-runner /la=
va-10505954/1

    2023-05-29T07:04:06.325894  + export TESTRUN_ID=3D1_bootrr

    2023-05-29T07:04:06.326070  + cd /lava-10505954/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64744f93013eca89c42e862b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-meson-gxl-s905x-libr=
etech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-meson-gxl-s905x-libr=
etech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230519.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64744f93013eca89c=
42e862c
        new failure (last pass: v5.10.180-cip33-21-g8eb0cdf459a2) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6474507abe635dd18a2e85ea

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-nfs-mes=
on-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-nfs-mes=
on-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230519.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6474507abe635dd18=
a2e85eb
        new failure (last pass: v5.10.180-cip33-21-g8eb0cdf459a2) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64744ef485abf4291b2e85e9

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-r=
k3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-r=
k3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230519.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/64744ef485abf4291b2e85ef
        failing since 67 days (last pass: v5.10.173-cip28, first fail: v5.1=
0.175-cip29)

    2023-05-29T07:06:17.621131  /lava-10505978/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/64744ef485abf4291b2e85f0
        failing since 67 days (last pass: v5.10.173-cip28, first fail: v5.1=
0.175-cip29)

    2023-05-29T07:06:16.534217  /lava-10505978/1/../bin/lava-test-case

    2023-05-29T07:06:16.567658  <8>[   45.278156] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64744f2e57db5161572e862f

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-sun50i-a64-pine64-pl=
us.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-sun50i-a64-pine64-pl=
us.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230519.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64744f2e57db5161572e865b
        failing since 135 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-29T07:06:56.085100  [   29.905175] <LAVA_SIGNAL_ENDRUN 0_dmesg =
530167_1.6.2.4.1>
    2023-05-29T07:06:56.197127  / # #
    2023-05-29T07:06:56.299411  export SHELL=3D/bin/sh
    2023-05-29T07:06:56.300159  #
    2023-05-29T07:06:56.402458  / # export SHELL=3D/bin/sh. /lava-530167/en=
vironment
    2023-05-29T07:06:56.403057  =

    2023-05-29T07:06:56.504443  / # . /lava-530167/environment/lava-530167/=
bin/lava-test-runner /lava-530167/1
    2023-05-29T07:06:56.505150  =

    2023-05-29T07:06:56.509932  / # /lava-530167/bin/lava-test-runner /lava=
-530167/1
    2023-05-29T07:06:56.631473  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =20

