Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78D2C77B6E
	for <webhook@archiver.kernel.org>; Fri, 14 Apr 2023 10:53:10 +0000 (UTC)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
 by mx.groups.io with SMTP id smtpd.web10.6223.1681469584981075733
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 14 Apr 2023 03:53:05 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=YmMxTZxB;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.41, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f41.google.com with SMTP id f2so9440729pjs.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 14 Apr 2023 03:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1681469584; x=1684061584;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yAOPYE303ThHfSFKdHi4rheKuejO93bdUn+axZquDRM=;
        b=YmMxTZxB/2+scdXLPU4uRF7G5CJZPGs/gYXttlkDqCh0sDqeAK4jHu4S2gyQjopoYz
         nsz5v/jSZy0MjMCxnuzlLMsX3cyttBvSewSJh6Tf9diDrZFajLVPd2zoGgllQeYpd+1/
         VVbWY2h/ik4Bf0ANpLaqqhPdmH5ekQFIOjF0IbfsH34iua7A00Sf7+OSvIbCjTpg2RW2
         04aU7uK8Hpqf3J7cvkHjzLFOOJZ5APAAjeboAt4pffLhMxctMMGx5kjJrvrCbWs5suoB
         4zwbOKsxb4A0sBryr86pYxEyiBpUc7+mGGgNVfiUhPm1nrItfvtx47JzGp+GBguqddud
         hSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681469584; x=1684061584;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yAOPYE303ThHfSFKdHi4rheKuejO93bdUn+axZquDRM=;
        b=NA6zu2H8ZJMtR0GIjso3BF92jiJDHdqDDK5IQYgnSvnVfq2CL5ik6slHCGxPX/G7Pv
         gZIy4fjAkF0YNNKEAjl+SOFEj/GYHJBPRXFP+pB6KAb8RgoCNMQFzd1AcK4tRUQ/uhZ5
         oFbC+zP9Z64pchFlZNV83AG4UHlFt1CY86JlvcjxB+yHIad3ovE4sK80XK0ICglQnKXT
         fO+DT3EVsbKKOx41COR122+5/kBrkKmwGLBQQCDdKDuL9JRwOMYaUjc/DWyGMz7BfrV8
         jHkArOU9uD1V3gqCqIWaOKi9LHChQ68FB5fN4pzxFYR08k01JIDf+jmam5L633QfTThy
         ZpUg==
X-Gm-Message-State: AAQBX9e1jK0woKLEo8I9Zsrh6QbS3+Dk6HgsU+5ZOmHnjRQfBGWG9ZvH
	ZFyVGX3V/35hEFSbPrNQfcaQxucVEoiFt7FSuCuk7jMo
X-Google-Smtp-Source: AKy350Z28xhh7xdn0cvFC/6fHjFAgxo23snSwWDIn1e0Mc3cSv4D9rtu6Ow1XkGcU8bqCHBUAzasvA==
X-Received: by 2002:a17:902:f68e:b0:1a6:8f8c:fa1a with SMTP id l14-20020a170902f68e00b001a68f8cfa1amr2944036plg.16.1681469583557;
        Fri, 14 Apr 2023 03:53:03 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s1-20020a170902988100b001a69305ae3asm1679441plp.288.2023.04.14.03.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 03:53:03 -0700 (PDT)
Message-ID: <6439308f.170a0220.b9045.4740@mx.google.com>
Date: Fri, 14 Apr 2023 03:53:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.177-cip31
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip baseline-nfs: 47 runs,
 15 regressions (v5.10.177-cip31)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Apr 2023 10:53:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11208

cip/linux-5.10.y-cip baseline-nfs: 47 runs, 15 regressions (v5.10.177-cip31)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
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
g+kselftest          | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.177-cip31/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.177-cip31
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      deb75c99ed78d677587a345854b8a00fb2cac68c =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64392514868ad49c152e8622

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230407.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64392514868ad49c152e8627
        failing since 90 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-04-14T10:03:53.103234  [   18.627477] <LAVA_SIGNAL_ENDRUN 0_dmesg =
9975327_1.5.2.3.1>

    2023-04-14T10:03:53.106000  + set +x

    2023-04-14T10:03:53.217360  / # #

    2023-04-14T10:03:53.318428  export SHELL=3D/bin/sh

    2023-04-14T10:03:53.318617  #

    2023-04-14T10:03:53.419498  / # export SHELL=3D/bin/sh. /lava-9975327/e=
nvironment

    2023-04-14T10:03:53.419751  =


    2023-04-14T10:03:53.520704  / # . /lava-9975327/environment/lava-997532=
7/bin/lava-test-runner /lava-9975327/1

    2023-04-14T10:03:53.521006  =


    2023-04-14T10:03:53.526615  / # /lava-9975327/bin/lava-test-runner /lav=
a-9975327/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6439250f238fcc51042e861e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230407.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6439250f238fcc51042e8623
        failing since 90 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-04-14T10:03:41.716645  + set +x

    2023-04-14T10:03:41.722628  <8>[   20.210911] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9975371_1.5.2.3.1>

    2023-04-14T10:03:41.835393  #

    2023-04-14T10:03:41.936553  / # #export SHELL=3D/bin/sh

    2023-04-14T10:03:41.936722  =


    2023-04-14T10:03:42.037715  / # export SHELL=3D/bin/sh. /lava-9975371/e=
nvironment

    2023-04-14T10:03:42.037882  =


    2023-04-14T10:03:42.138695  / # . /lava-9975371/environment/lava-997537=
1/bin/lava-test-runner /lava-9975371/1

    2023-04-14T10:03:42.138994  =


    2023-04-14T10:03:42.141559  / # /lava-9975371/bin/lava-test-runner /lav=
a-9975371/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6439257fae09e064c82e85fd

  Results:     47 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-nfs-at91sam9g20ek=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-nfs-at91sam9g20ek=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230407.0/armel/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6439257fae09e064c82e8632
        failing since 90 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-04-14T10:05:17.543866  + set +x
    2023-04-14T10:05:17.669973  #
    2023-04-14T10:05:17.773124  / # #export SHELL=3D/bin/sh
    2023-04-14T10:05:17.773907  =

    2023-04-14T10:05:17.875840  / # export SHELL=3D/bin/sh. /lava-327689/en=
vironment
    2023-04-14T10:05:17.876610  =

    2023-04-14T10:05:17.978728  / # . /lava-327689/environment/lava-327689/=
bin/lava-test-runner /lava-327689/1
    2023-04-14T10:05:17.979982  =

    2023-04-14T10:05:17.986706  / # /lava-327689/bin/lava-test-runner /lava=
-327689/1
    2023-04-14T10:05:18.383788  + export TESTRUN_ID=3D1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/643925de09b52da7972e85f2

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-bl=
ack.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-bl=
ack.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230407.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/643925de09b52da7972e861e
        failing since 90 days (last pass: v5.10.158-cip22, first fail: v5.1=
0.162-cip24)

    2023-04-14T10:06:04.641041  [   61.359549] <LAVA_SIGNAL_ENDRUN 0_dmesg =
327665_1.6.2.4.1>
    2023-04-14T10:06:04.901940  #
    2023-04-14T10:06:05.023468  / # #export SHELL=3D/bin/sh
    2023-04-14T10:06:05.031322  =

    2023-04-14T10:06:05.036476  / # export SHELL=3D/bin/sh
    2023-04-14T10:06:05.148462  / # . /lava-327665/environment
    2023-04-14T10:06:05.261005  /lava-327665/bin/lava-test-runner /lava-327=
665/1
    2023-04-14T10:06:05.272630  . /lava-327665/environment
    2023-04-14T10:06:05.276716  / # /lava-327665/bin/lava-test-runner /lava=
-327665/1
    2023-04-14T10:06:05.905837  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/643929591c3c1013e42e85f6

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebone-black.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebone-black.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230407.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/643929591c3c1013e42e8623
        failing since 90 days (last pass: v5.10.158-cip22, first fail: v5.1=
0.162-cip24)

    2023-04-14T10:21:39.215903  + set +x
    2023-04-14T10:21:39.220267  <8>[   47.747049] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 905130_1.6.2.4.1>
    2023-04-14T10:21:39.446901  / # #
    2023-04-14T10:21:39.549674  export SHELL=3D/bin/sh
    2023-04-14T10:21:39.550360  #
    2023-04-14T10:21:39.651981  / # export SHELL=3D/bin/sh. /lava-905130/en=
vironment
    2023-04-14T10:21:39.652293  =

    2023-04-14T10:21:39.753873  / # . /lava-905130/environment/lava-905130/=
bin/lava-test-runner /lava-905130/1
    2023-04-14T10:21:39.754882  =

    2023-04-14T10:21:39.761657  / # /lava-905130/bin/lava-test-runner /lava=
-905130/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/643927ae77f4de9adc2e863b

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-b=
lack.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-b=
lack.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230407.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/643927ae77f4de9adc2e8670
        failing since 72 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.165-cip25)

    2023-04-14T10:14:54.346849  [   45.155712] <LAVA_SIGNAL_ENDRUN 0_dmesg =
327845_1.6.2.4.1>
    2023-04-14T10:14:54.460110  #
    2023-04-14T10:14:54.562313  / # #export SHELL=3D/bin/sh
    2023-04-14T10:14:54.562932  =

    2023-04-14T10:14:54.665023  / # export SHELL=3D/bin/sh. /lava-327845/en=
vironment
    2023-04-14T10:14:54.665647  =

    2023-04-14T10:14:54.767876  / # . /lava-327845/environment/lava-327845/=
bin/lava-test-runner /lava-327845/1
    2023-04-14T10:14:54.768770  =

    2023-04-14T10:14:54.773696  / # /lava-327845/bin/lava-test-runner /lava=
-327845/1
    2023-04-14T10:14:55.035490  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/643925c1d37d6a20152e860e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230407.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/643925c1d37d6a20152e8613
        new failure (last pass: v5.10.176-cip30)

    2023-04-14T10:06:35.078470  + set<8>[   18.550069] <LAVA_SIGNAL_ENDRUN =
0_dmesg 9975382_1.5.2.3.1>

    2023-04-14T10:06:35.078558   +x

    2023-04-14T10:06:35.183627  / # #

    2023-04-14T10:06:35.284708  export SHELL=3D/bin/sh

    2023-04-14T10:06:35.284887  #

    2023-04-14T10:06:35.385759  / # export SHELL=3D/bin/sh. /lava-9975382/e=
nvironment

    2023-04-14T10:06:35.385952  =


    2023-04-14T10:06:35.486718  / # . /lava-9975382/environment/lava-997538=
2/bin/lava-test-runner /lava-9975382/1

    2023-04-14T10:06:35.486993  =


    2023-04-14T10:06:35.491862  / # /lava-9975382/bin/lava-test-runner /lav=
a-9975382/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6439251578ad1dbac02e862b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230407.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6439251578ad1dbac02e8630
        new failure (last pass: v5.10.176-cip30)

    2023-04-14T10:03:43.778843  + set +x

    2023-04-14T10:03:43.785696  <8>[   18.020498] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9975358_1.5.2.3.1>

    2023-04-14T10:03:43.792431  <6>[   18.028029] sh (338) used greatest st=
ack depth: 13056 bytes left

    2023-04-14T10:03:43.896794  / # #

    2023-04-14T10:03:43.997983  export SHELL=3D/bin/sh

    2023-04-14T10:03:43.998199  #

    2023-04-14T10:03:44.099148  / # export SHELL=3D/bin/sh. /lava-9975358/e=
nvironment

    2023-04-14T10:03:44.099343  =


    2023-04-14T10:03:44.200277  / # . /lava-9975358/environment/lava-997535=
8/bin/lava-test-runner /lava-9975358/1

    2023-04-14T10:03:44.200535  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/643923e7492ca740262e860c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-nfs-imx6q-sabre=
lite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-nfs-imx6q-sabre=
lite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230407.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/643923e7492ca740262e8611
        failing since 90 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-04-14T09:58:40.090410  / # #

    2023-04-14T09:58:40.192822  export SHELL=3D/bin/sh

    2023-04-14T09:58:40.193044  #

    2023-04-14T09:58:40.294001  / # export SHELL=3D/bin/sh. /lava-9975270/e=
nvironment

    2023-04-14T09:58:40.294154  =


    2023-04-14T09:58:40.395640  / # . /lava-9975270/environment/lava-997527=
0/bin/lava-test-runner /lava-9975270/1

    2023-04-14T09:58:40.396774  =


    2023-04-14T09:58:40.401475  / # /lava-9975270/bin/lava-test-runner /lav=
a-9975270/1

    2023-04-14T09:58:40.575138  + export TESTRUN_ID=3D1_bootrr

    2023-04-14T09:58:40.575626  + cd /lava-9975270/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/643929e2e2cd334f612e867e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-meson-gxl-s905x-libr=
etech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-meson-gxl-s905x-libr=
etech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230407.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/643929e2e2cd334f6=
12e867f
        failing since 21 days (last pass: v5.10.175-cip29, first fail: v5.1=
0.176-cip30) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/643929fd5f0205cc042e8605

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/arm64/defconfig+kselftest/gcc-10/lab-broonie/baseline-nfs-meson-gxl-=
s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/arm64/defconfig+kselftest/gcc-10/lab-broonie/baseline-nfs-meson-gxl-=
s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230407.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/643929fd5f0205cc0=
42e8606
        new failure (last pass: v5.10.176-cip30) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64392b7873feda08bc2e8608

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-nfs-mes=
on-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-nfs-mes=
on-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230407.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64392b7873feda08b=
c2e8609
        failing since 31 days (last pass: v5.10.168-cip27, first fail: v5.1=
0.173-cip28) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64392c5956d2af004c2e8675

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-r=
k3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-r=
k3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230407.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/64392c5956d2af004c2e86c6
        failing since 23 days (last pass: v5.10.173-cip28, first fail: v5.1=
0.175-cip29)

    2023-04-14T10:34:47.877324  <8>[   36.355949] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-04-14T10:34:48.935226  /lava-9975743/1/../bin/lava-test-case

    2023-04-14T10:34:48.969401  <8>[   37.449370] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/64392c5956d2af004c2e86c7
        failing since 23 days (last pass: v5.10.173-cip28, first fail: v5.1=
0.175-cip29)

    2023-04-14T10:34:47.839536  /lava-9975743/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64392772e9b65c92562e86da

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-sun50i-a64-pine64-pl=
us.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-sun50i-a64-pine64-pl=
us.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230407.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64392772e9b65c92562e8706
        failing since 90 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-04-14T10:13:41.468542  + set +x
    2023-04-14T10:13:41.472041  [   32.437464] <LAVA_SIGNAL_ENDRUN 0_dmesg =
327831_1.6.2.4.1>
    2023-04-14T10:13:41.584713  / # #
    2023-04-14T10:13:41.686405  export SHELL=3D/bin/sh
    2023-04-14T10:13:41.686997  #
    2023-04-14T10:13:41.788536  / # export SHELL=3D/bin/sh. /lava-327831/en=
vironment
    2023-04-14T10:13:41.789136  =

    2023-04-14T10:13:41.890829  / # . /lava-327831/environment/lava-327831/=
bin/lava-test-runner /lava-327831/1
    2023-04-14T10:13:41.891814  =

    2023-04-14T10:13:41.895355  / # /lava-327831/bin/lava-test-runner /lava=
-327831/1 =

    ... (12 line(s) more)  =

 =20

