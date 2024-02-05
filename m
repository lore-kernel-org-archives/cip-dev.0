Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E9EC4828D
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 17:51:28 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web11.503.1707155480869506373
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Feb 2024 09:51:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=qj+gjT8B;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.170, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d918008b99so35029905ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Feb 2024 09:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707155480; x=1707760280; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SKCS1FqpL2hNEkcDuThpucq23HuH+jdfviNArulWuK4=;
        b=qj+gjT8B4Zqpu/4hsrXci9/xdmHk3lS3CUEbfy5Nt4ynQwgmFIXxRIVOQnBG6b/KyF
         EzTFmuucUc+WpqOmxaDEUR/X+f5kqooZpiaooBrl884NVKgFsBBJUtiEXMgLSDCOqcT2
         jAkPf4mV1K458IfkmpCvYe9887UMKVnscui7M3X3s/gmkIulOBYW2hNSaH4ZHRF4gAmQ
         pP9aljWigj0Y1xIhXfhkjgbZyuiPp0bwFJEqvHWnkK+V26e45oE5aDE6V4dSPtiMVefm
         wyzjjOimo0m64iYGLj7bROS+2oaVDSQdWcYf6fU/HW6CbQyJxd0RVVetl1p69viA+8Fj
         9aYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707155480; x=1707760280;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SKCS1FqpL2hNEkcDuThpucq23HuH+jdfviNArulWuK4=;
        b=Vc6t2v8gxZenLe0sVBOgCNRVrJglNyo1DWOWra1+XwAgBawHADOG6LXTJXml3TsGPB
         PuRWuLEYALSfv6Jzjm+aZKMu+T82xE2CYeD5MoxmWgx+wM6zLETavmtwRIYoeoJkSd8m
         rsst8JYRhYLUSLF9Z1DKDx2UYoEMm2DPVJzwNBNYaQdigX6xYOP5bMRZGWgt7cNh8As+
         FX/HnqUUlYqKJlMR7QGG1OiTTSEtKyg9Whupy0YbJ/UCqWIaN2ikVdznEG2EJLX4lXz+
         vrrglcfa+eqOkOZ+lS/vA046S36Csf1XF6ZzzowUJLMs1zexF5mcSkXb7iHTCRipDZlp
         fB7Q==
X-Gm-Message-State: AOJu0Yyl1lju0u5IgZqil3JkyUeRMJPV4/m675QD2nYVyEov7Js4zY1Q
	O231uw7SomzvfAdg7nzxsutkBcnTQ/0QY5HNtiUh9YEotZsovBCyXbjzVzWKJxqde74gNUzhNnz
	C
X-Google-Smtp-Source: AGHT+IG4Dn1SKGscEIwZdEMsC15A3CJm+Ko1EWtA2Mjn2mtfX/EU3lXU2ggqjKmpZOghrVe1lHSJ4g==
X-Received: by 2002:a17:902:d50b:b0:1d9:7046:fbcd with SMTP id b11-20020a170902d50b00b001d97046fbcdmr295403plg.3.1707155479641;
        Mon, 05 Feb 2024 09:51:19 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUlME3QZEkmOpU4/2r07lKBLm/0pNNU/E8JYiJwiTU4l5IkteMp1ob3oTX+V4gktK38kmdGit7tGvcKDfrLRQ2AifBbeazUev/RtjvEwi0tEjsrMyDhehswpJxHTWdvUouGDt8uV2YxtcADpWirOpPBMQ==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id m1-20020a170902f20100b001d9ce370415sm146213plc.90.2024.02.05.09.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 09:51:18 -0800 (PST)
Message-ID: <65c12016.170a0220.fca3f.1085@mx.google.com>
Date: Mon, 05 Feb 2024 09:51:18 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.209-cip44
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip baseline-nfs: 63 runs,
 17 regressions (v5.10.209-cip44)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Feb 2024 17:51:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14743

cip/linux-5.10.y-cip baseline-nfs: 63 runs, 17 regressions (v5.10.209-cip44)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | multi_v7_=
defconfig           | 1          =

beaglebone-black             | arm   | lab-cip       | gcc-10   | multi_v7_=
defconfig           | 1          =

beaglebone-black             | arm   | lab-broonie   | gcc-10   | omap2plus=
_defconfig          | 1          =

beaglebone-black             | arm   | lab-cip       | gcc-10   | omap2plus=
_defconfig          | 1          =

imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig           | 1          =

juno-uboot                   | arm64 | lab-broonie   | gcc-10   | cip://5.1=
0.y-...64_defconfig | 1          =

juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =

juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
                    | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+arm64-chromebook   | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
+kselftest          | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
+arm64-chromebook   | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
                    | 1          =

rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook   | 2          =

rk3399-rock-pi-4b            | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =

rk3399-rock-pi-4b            | arm64 | lab-collabora | gcc-10   | defconfig=
                    | 1          =

sun50i-a64-pine64-plus       | arm64 | lab-broonie   | gcc-10   | defconfig=
                    | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.209-cip44/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.209-cip44
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      2fa4c25ee66abaa707e8d165c790bb96e883cca4 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65c1155331b401588100a07e

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-bl=
ack.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-bl=
ack.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65c1155331b401588100a0ae
        failing since 387 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-05T17:04:31.769207  <8>[   54.030934] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 546345_1.6.2.4.1>
    2024-02-05T17:04:31.889191  / # #
    2024-02-05T17:04:31.990928  export SHELL=3D/bin/sh
    2024-02-05T17:04:31.991258  #
    2024-02-05T17:04:32.092941  / # export SHELL=3D/bin/sh. /lava-546345/en=
vironment
    2024-02-05T17:04:32.093311  =

    2024-02-05T17:04:32.194619  / # . /lava-546345/environment/lava-546345/=
bin/lava-test-runner /lava-546345/1
    2024-02-05T17:04:32.195162  =

    2024-02-05T17:04:32.199475  / # /lava-546345/bin/lava-test-runner /lava=
-546345/1
    2024-02-05T17:04:32.400000  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
beaglebone-black             | arm   | lab-cip       | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65c11822474136c4b300a05e

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebone-black.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebone-black.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65c11823474136c4b300a08f
        failing since 387 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-05T17:16:28.073363  <8>[   51.918012] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1088712_1.6.2.4.1>
    2024-02-05T17:16:28.238182  #
    2024-02-05T17:16:28.339280  / # #export SHELL=3D/bin/sh
    2024-02-05T17:16:28.339570  =

    2024-02-05T17:16:28.440221  / # export SHELL=3D/bin/sh. /lava-1088712/e=
nvironment
    2024-02-05T17:16:28.440512  =

    2024-02-05T17:16:28.541180  / # . /lava-1088712/environment/lava-108871=
2/bin/lava-test-runner /lava-1088712/1
    2024-02-05T17:16:28.541641  =

    2024-02-05T17:16:28.548513  / # /lava-1088712/bin/lava-test-runner /lav=
a-1088712/1
    2024-02-05T17:16:28.830232  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | omap2plus=
_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/65c1199ff2453463f300a0cd

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-b=
lack.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-b=
lack.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65c1199ff2453463f300a107
        failing since 387 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-05T17:23:25.163167  <8>[   46.350644] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 546410_1.6.2.4.1>
    2024-02-05T17:23:25.290198  #
    2024-02-05T17:23:25.392111  / # #export SHELL=3D/bin/sh
    2024-02-05T17:23:25.392609  =

    2024-02-05T17:23:25.493931  / # export SHELL=3D/bin/sh. /lava-546410/en=
vironment
    2024-02-05T17:23:25.494480  =

    2024-02-05T17:23:25.595749  / # . /lava-546410/environment/lava-546410/=
bin/lava-test-runner /lava-546410/1
    2024-02-05T17:23:25.596465  =

    2024-02-05T17:23:25.599739  / # /lava-546410/bin/lava-test-runner /lava=
-546410/1
    2024-02-05T17:23:25.849412  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
beaglebone-black             | arm   | lab-cip       | gcc-10   | omap2plus=
_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/65c119c7d7a1f253c400a083

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebone-black=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebone-black=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65c119c7d7a1f253c400a0b9
        failing since 387 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-05T17:23:57.695371  + set +x
    2024-02-05T17:23:57.699750  <8>[   42.387144] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1088751_1.6.2.4.1>
    2024-02-05T17:23:57.868269  #
    2024-02-05T17:23:57.970500  / # #export SHELL=3D/bin/sh
    2024-02-05T17:23:57.970922  =

    2024-02-05T17:23:58.072143  / # export SHELL=3D/bin/sh. /lava-1088751/e=
nvironment
    2024-02-05T17:23:58.072783  =

    2024-02-05T17:23:58.174093  / # . /lava-1088751/environment/lava-108875=
1/bin/lava-test-runner /lava-1088751/1
    2024-02-05T17:23:58.175057  =

    2024-02-05T17:23:58.181282  / # /lava-1088751/bin/lava-test-runner /lav=
a-1088751/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65c1150fb01d5631ca00a07f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-nfs-imx6q-sabre=
lite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-nfs-imx6q-sabre=
lite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65c1150fb01d5631ca00a088
        failing since 387 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-05T17:04:02.718899  / # #

    2024-02-05T17:04:02.821637  export SHELL=3D/bin/sh

    2024-02-05T17:04:02.822430  #

    2024-02-05T17:04:02.924189  / # export SHELL=3D/bin/sh. /lava-12704432/=
environment

    2024-02-05T17:04:02.924988  =


    2024-02-05T17:04:03.026690  / # . /lava-12704432/environment/lava-12704=
432/bin/lava-test-runner /lava-12704432/1

    2024-02-05T17:04:03.027945  =


    2024-02-05T17:04:03.041566  / # /lava-12704432/bin/lava-test-runner /la=
va-12704432/1

    2024-02-05T17:04:03.242192  + export TESTRUN_ID=3D1_bootrr

    2024-02-05T17:04:03.242716  + cd /lava-12704432/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
juno-uboot                   | arm64 | lab-broonie   | gcc-10   | cip://5.1=
0.y-...64_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/65c11ab64d9069645300a03a

  Results:     47 PASS, 13 FAIL, 1 SKIP
  Full config: cip://5.10.y-cip/arm64/qemu_arm64_defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/cip---5.10.y-cip-arm64-qemu_arm64_defconfig/gcc-10/lab-broonie=
/baseline-nfs-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/cip---5.10.y-cip-arm64-qemu_arm64_defconfig/gcc-10/lab-broonie=
/baseline-nfs-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65c11ab64d9069645300a079
        failing since 124 days (last pass: v5.10.184-cip36-8-gb192df20e8c9,=
 first fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2024-02-05T17:27:51.608549  / # #
    2024-02-05T17:27:51.711315  export SHELL=3D/bin/sh
    2024-02-05T17:27:51.712075  #
    2024-02-05T17:27:51.813913  / # export SHELL=3D/bin/sh. /lava-546352/en=
vironment
    2024-02-05T17:27:51.814725  =

    2024-02-05T17:27:51.916636  / # . /lava-546352/environment/lava-546352/=
bin/lava-test-runner /lava-546352/1
    2024-02-05T17:27:51.917868  =

    2024-02-05T17:27:51.937637  / # /lava-546352/bin/lava-test-runner /lava=
-546352/1
    2024-02-05T17:27:52.074105  + export TESTRUN_ID=3D1_bootrr
    2024-02-05T17:27:52.074428  + cd /lava-546352/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/65c1198934df5a296700a0d2

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig+kselftest/gcc-10/lab-broonie/baseline-nfs-juno-uboot=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig+kselftest/gcc-10/lab-broonie/baseline-nfs-juno-uboot=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65c1198934df5a296700a112
        failing since 3 days (last pass: v5.10.201-cip41-69-g8f7b450fc28ed,=
 first fail: v5.10.208-cip43-4-g1c63c70fb18b8)

    2024-02-05T17:22:47.884961  <8>[   54.216080] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 546304_1.6.2.4.1>
    2024-02-05T17:22:48.003804  / # #
    2024-02-05T17:22:48.106550  export SHELL=3D/bin/sh
    2024-02-05T17:22:48.107332  #
    2024-02-05T17:22:48.209163  / # export SHELL=3D/bin/sh. /lava-546304/en=
vironment
    2024-02-05T17:22:48.209987  =

    2024-02-05T17:22:48.311956  / # . /lava-546304/environment/lava-546304/=
bin/lava-test-runner /lava-546304/1
    2024-02-05T17:22:48.313193  =

    2024-02-05T17:22:48.332637  / # /lava-546304/bin/lava-test-runner /lava=
-546304/1
    2024-02-05T17:22:48.705075  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/65c11be2ab0e2dae3c00a03a

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65c11be2ab0e2dae3c00a079
        failing since 124 days (last pass: v5.10.184-cip36, first fail: v5.=
10.194-cip39-1-g53e59f50ca3ff)

    2024-02-05T17:32:57.535089  <8>[   53.365104] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 546380_1.6.2.4.1>
    2024-02-05T17:32:57.639551  / # #
    2024-02-05T17:32:57.742561  export SHELL=3D/bin/sh
    2024-02-05T17:32:57.743373  #
    2024-02-05T17:32:57.845285  / # export SHELL=3D/bin/sh. /lava-546380/en=
vironment
    2024-02-05T17:32:57.846085  =

    2024-02-05T17:32:57.948088  / # . /lava-546380/environment/lava-546380/=
bin/lava-test-runner /lava-546380/1
    2024-02-05T17:32:57.949355  =

    2024-02-05T17:32:57.966717  / # /lava-546380/bin/lava-test-runner /lava=
-546380/1
    2024-02-05T17:32:58.148454  + export TESTRUN_ID=3D1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/65c11a648c24e2cb3400a041

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-nfs-mes=
on-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-nfs-mes=
on-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c11a648c24e2cb3=
400a042
        new failure (last pass: v5.10.208-cip43-4-g1c63c70fb18b8) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/65c11553ead548d3ca00a0dc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-nfs-r8a774a1-hihop=
e-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-nfs-r8a774a1-hihop=
e-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c11553ead548d3c=
a00a0dd
        failing since 3 days (last pass: v5.10.201-cip41-69-g8f7b450fc28ed,=
 first fail: v5.10.208-cip43-4-g1c63c70fb18b8) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/65c1180783a9ef2c5c00a03d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-nfs-r8a774a=
1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-nfs-r8a774a=
1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c1180783a9ef2c5=
c00a03e
        failing since 167 days (last pass: v5.10.186-cip37-14-gc9b5a049d8ea=
, first fail: v5.10.186-cip37-27-gd6d928db0a620) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/65c119dad7a1f253c400a0c2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig/gcc-10/lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig/gcc-10/lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c119dad7a1f253c=
400a0c3
        failing since 124 days (last pass: v5.10.194-cip39, first fail: v5.=
10.194-cip39-1-g53e59f50ca3ff) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/65c1175f8450d8822a00a04a

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-r=
k3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-r=
k3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/65c1175f8450d8822a00a054
        failing since 320 days (last pass: v5.10.173-cip28, first fail: v5.=
10.175-cip29)

    2024-02-05T17:13:55.665291  /lava-12704562/1/../bin/lava-test-case

    2024-02-05T17:13:55.705516  <8>[   38.228510] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/65c1175f8450d8822a00a055
        failing since 320 days (last pass: v5.10.173-cip28, first fail: v5.=
10.175-cip29)

    2024-02-05T17:13:54.590589  /lava-12704562/1/../bin/lava-test-case

    2024-02-05T17:13:54.619443  <8>[   37.142681] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
rk3399-rock-pi-4b            | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/65c1150ff98e96829e00a072

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig+kselftest/gcc-10/lab-collabora/baseline-nfs-rk3399-r=
ock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig+kselftest/gcc-10/lab-collabora/baseline-nfs-rk3399-r=
ock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65c1150ff98e96829e00a07b
        failing since 124 days (last pass: v5.10.184-cip36, first fail: v5.=
10.194-cip39-1-g53e59f50ca3ff)

    2024-02-05T17:03:51.609807  + set +x

    2024-02-05T17:03:51.610255  <8>[   51.395531] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12704422_1.6.2.4.1>

    2024-02-05T17:03:51.715897  #

    2024-02-05T17:03:52.975782  / # #export SHELL=3D/bin/sh

    2024-02-05T17:03:52.986779  =


    2024-02-05T17:03:52.987254  / # export SHELL=3D/bin/sh

    2024-02-05T17:03:54.730233  . /lava-12704422/environment

    2024-02-05T17:03:57.935594  / # . /lava-12704422/environment/lava-12704=
422/bin/lava-test-runner /lava-12704422/1

    2024-02-05T17:03:57.947098  =


    2024-02-05T17:03:57.953743  / # /lava-12704422/bin/lava-test-runner /la=
va-12704422/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
rk3399-rock-pi-4b            | arm64 | lab-collabora | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/65c1172558e47c466500a059

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig/gcc-10/lab-collabora/baseline-nfs-rk3399-rock-pi-4b.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig/gcc-10/lab-collabora/baseline-nfs-rk3399-rock-pi-4b.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65c1172558e47c466500a062
        failing since 124 days (last pass: v5.10.184-cip36, first fail: v5.=
10.194-cip39-1-g53e59f50ca3ff)

    2024-02-05T17:18:36.973082  / # #

    2024-02-05T17:18:38.232787  export SHELL=3D/bin/sh

    2024-02-05T17:18:38.243578  #

    2024-02-05T17:18:39.985767  / # export SHELL=3D/bin/sh. /lava-12704582/=
environment

    2024-02-05T17:18:39.996158  =


    2024-02-05T17:18:39.996232  / # . /lava-12704582/environment

    2024-02-05T17:18:43.186970  /lava-12704582/bin/lava-test-runner /lava-1=
2704582/1

    2024-02-05T17:18:43.200022  / # /lava-12704582/bin/lava-test-runner /la=
va-12704582/1

    2024-02-05T17:18:43.365624  + export TESTRUN_ID=3D1_bootrr

    2024-02-05T17:18:43.365706  + cd /lava-12704582/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
sun50i-a64-pine64-plus       | arm64 | lab-broonie   | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/65c117bc91ef12abc800a1db

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-sun50i-a64-pine64-pl=
us.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-sun50i-a64-pine64-pl=
us.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65c117bc91ef12abc800a20b
        failing since 387 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-05T17:15:23.868108  <8>[   29.996957] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 546381_1.6.2.4.1>
    2024-02-05T17:15:23.985475  / # #
    2024-02-05T17:15:24.087779  export SHELL=3D/bin/sh
    2024-02-05T17:15:24.088375  #
    2024-02-05T17:15:24.190454  / # export SHELL=3D/bin/sh. /lava-546381/en=
vironment
    2024-02-05T17:15:24.191073  =

    2024-02-05T17:15:24.292939  / # . /lava-546381/environment/lava-546381/=
bin/lava-test-runner /lava-546381/1
    2024-02-05T17:15:24.293783  =

    2024-02-05T17:15:24.298128  / # /lava-546381/bin/lava-test-runner /lava=
-546381/1
    2024-02-05T17:15:24.438308  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =20

