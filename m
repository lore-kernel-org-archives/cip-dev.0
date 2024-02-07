Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D7BC4829B
	for <webhook@archiver.kernel.org>; Wed,  7 Feb 2024 01:09:37 +0000 (UTC)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
 by mx.groups.io with SMTP id smtpd.web10.10427.1707268174146912597
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 06 Feb 2024 17:09:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=miUsoAhi;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.174, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e04f29c7bcso119142b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 06 Feb 2024 17:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707268173; x=1707872973; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2nys9/YDKdR5r8/q8xUITIcxTRiG8I9D8a/cAX76N2c=;
        b=miUsoAhiCapPJkimBQiOeJYFd5b9NW9gGgMyX+BGVih8HMe2AaiZU3VJjkSTHqrgnA
         gSVo2V0bDINKoPb8mclel0a045ZV1QXhunwtNwgtjJwxddqQpzD+qtwWhkz4uHMdFxHE
         YTl57xRHkW/q5IL93NXHWx5YE9jCjwMuTFwZTljuz/0GVTnipI0hQgwYEBeWdZAC9FDA
         UNdBPrl9szEIIQySW1MnGB+fdS0jObyb5AyllRgxwDYP5ZJt8wwHfXkqcrScbBw3xX7h
         1XqyM1XCNOeYYS9j+lwzT+li9fXEkf5gIqWRobLVuciQrbFv31/VuUKtMhozW1jYLRSN
         bp5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707268173; x=1707872973;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2nys9/YDKdR5r8/q8xUITIcxTRiG8I9D8a/cAX76N2c=;
        b=hhPhadTXCnvX69jN6U6zjwW5l2848IqCDUVnIZunIyj7lIjTWlgpC2cr+7rFWsOG2g
         3zogqX50DIyV7o26vPBN2vCc8kFfv4fbSJV8YnX+OnE/IJoX0lC/md9W2hBAAgKRzm+0
         zpmLLDf9n4PNlQa00hwOmOAkk9CMJaSgEAArbj9WroPtudt96vnCN2N8J1CfyKgygLh1
         NQlsS7RPwCmH3BVEYejWyZzA3Ij8TfXFw1O0kW8MS8fn+3jI9I3zoeE6RyJRuoBiuXbv
         lMYQKczDPvM+ZX2yaitmSpULPVBOiigRbOtzahCLw2PPCQweDGk4Fz1PP3yEgbT6gNrf
         7ADQ==
X-Gm-Message-State: AOJu0Yz0if1EqVxV+gz/RGFLEDzTnEhwHB7CPoBoSk+ykbpJ9/fNj3xq
	4Tk94s9mQEYMkrl9XuxV1OtPtgqEZ1wqoNeZIi1/wGzu8ZWlR6462qOr0xOXV/mJC4sel0uVgH4
	h
X-Google-Smtp-Source: AGHT+IG4os5UTN8MhmmsljPl0T8hpNi7OhMT5VNbbBLWrEN5ONZ0+DOYPVgltwusg5PApCkO1M6Gaw==
X-Received: by 2002:a05:6a00:300b:b0:6dd:db87:6356 with SMTP id ay11-20020a056a00300b00b006dddb876356mr1784973pfb.7.1707268172906;
        Tue, 06 Feb 2024 17:09:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVJNDlbojMxXrvWGtmrYnni8FTsPqMmMp+NzRwiXbWIXQy6L2mxuKFkc598IsDQomoz8xKmh9yyx58GUzGGM6Gr1Q14CYK9ohK5L4c5k4JTHi2c6nQb+X3Xys3mBT9jdDRG2oawNURm5wM4pBDii3Zqzw==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t7-20020a625f07000000b006d94291679asm145906pfb.78.2024.02.06.17.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 17:09:31 -0800 (PST)
Message-ID: <65c2d84b.620a0220.b4a5b.0982@mx.google.com>
Date: Tue, 06 Feb 2024 17:09:31 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.209-cip44-50-ga624abaa85d7
Subject: cip/linux-5.10.y-cip baseline-nfs: 44 runs,
 18 regressions (v5.10.209-cip44-50-ga624abaa85d7)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Feb 2024 01:09:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14849

cip/linux-5.10.y-cip baseline-nfs: 44 runs, 18 regressions (v5.10.209-cip44=
-50-ga624abaa85d7)

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
                    | 1          =

juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+arm64-chromebook   | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
                    | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
+kselftest          | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
+arm64-chromebook   | 1          =

rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook   | 2          =

rk3399-rock-pi-4b            | arm64 | lab-collabora | gcc-10   | defconfig=
                    | 1          =

rk3399-rock-pi-4b            | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =

sun50i-a64-pine64-plus       | arm64 | lab-broonie   | gcc-10   | defconfig=
                    | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.209-cip44-50-ga624abaa85d7/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.209-cip44-50-ga624abaa85d7
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a624abaa85d7f3ff289eb2e257db5c4485d11d18 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2d0f8268a5b424c8e1e9a

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-=
nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-=
nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65c2d0f8268a5b424c8e1ec7
        failing since 388 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-07T00:37:30.197073  <8>[   54.069006] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 551075_1.6.2.4.1>
    2024-02-07T00:37:30.312968  / # #
    2024-02-07T00:37:30.415335  export SHELL=3D/bin/sh
    2024-02-07T00:37:30.416003  #
    2024-02-07T00:37:30.517814  / # export SHELL=3D/bin/sh. /lava-551075/en=
vironment
    2024-02-07T00:37:30.518434  =

    2024-02-07T00:37:30.620018  / # . /lava-551075/environment/lava-551075/=
bin/lava-test-runner /lava-551075/1
    2024-02-07T00:37:30.620876  =

    2024-02-07T00:37:30.625328  / # /lava-551075/bin/lava-test-runner /lava=
-551075/1
    2024-02-07T00:37:30.829782  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
beaglebone-black             | arm   | lab-cip       | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2d1763f98510ffe8e1ef7

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-=
beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-=
beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65c2d1763f98510ffe8e1f1f
        failing since 388 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-07T00:39:33.596399  + set +x
    2024-02-07T00:39:33.600567  <8>[   45.995156] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1089498_1.6.2.4.1>
    2024-02-07T00:39:33.715969  / # #
    2024-02-07T00:39:33.817433  export SHELL=3D/bin/sh
    2024-02-07T00:39:33.817978  #
    2024-02-07T00:39:33.918887  / # export SHELL=3D/bin/sh. /lava-1089498/e=
nvironment
    2024-02-07T00:39:33.919356  =

    2024-02-07T00:39:34.020288  / # . /lava-1089498/environment/lava-108949=
8/bin/lava-test-runner /lava-1089498/1
    2024-02-07T00:39:34.021031  =

    2024-02-07T00:39:34.024913  / # /lava-1089498/bin/lava-test-runner /lav=
a-1089498/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | omap2plus=
_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2cdbd2f6a161aaf8e1e80

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline=
-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline=
-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65c2cdbd2f6a161aaf8e1eb1
        failing since 388 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-07T00:23:48.260990  <8>[   54.184826] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 551009_1.6.2.4.1>
    2024-02-07T00:23:48.384351  / # #
    2024-02-07T00:23:48.485978  export SHELL=3D/bin/sh
    2024-02-07T00:23:48.486353  #
    2024-02-07T00:23:48.587560  / # export SHELL=3D/bin/sh. /lava-551009/en=
vironment
    2024-02-07T00:23:48.587923  =

    2024-02-07T00:23:48.689176  / # . /lava-551009/environment/lava-551009/=
bin/lava-test-runner /lava-551009/1
    2024-02-07T00:23:48.689823  =

    2024-02-07T00:23:48.694155  /lava-551009/bin/lava-test-runner /lava-551=
009/1
    2024-02-07T00:23:51.525259  / # + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
beaglebone-black             | arm   | lab-cip       | gcc-10   | omap2plus=
_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2ce5e61dc3a52a08e1f09

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs=
-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs=
-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65c2ce5e61dc3a52a08e1f3d
        failing since 388 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-07T00:26:30.468970  + set +x
    2024-02-07T00:26:30.473193  <8>[   45.254236] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1089474_1.6.2.4.1>
    2024-02-07T00:26:30.696408  #
    2024-02-07T00:26:30.798721  / # #export SHELL=3D/bin/sh
    2024-02-07T00:26:30.799403  =

    2024-02-07T00:26:30.900717  / # export SHELL=3D/bin/sh. /lava-1089474/e=
nvironment
    2024-02-07T00:26:30.901379  =

    2024-02-07T00:26:31.002773  / # . /lava-1089474/environment/lava-108947=
4/bin/lava-test-runner /lava-1089474/1
    2024-02-07T00:26:31.003860  =

    2024-02-07T00:26:31.010498  / # /lava-1089474/bin/lava-test-runner /lav=
a-1089474/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2d0b56e38672c998e1e8d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm/multi_v7_defconfig/gcc-10/lab-collabora/baselin=
e-nfs-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm/multi_v7_defconfig/gcc-10/lab-collabora/baselin=
e-nfs-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65c2d0b56e38672c998e1e92
        failing since 388 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-07T00:36:53.339885  / # #

    2024-02-07T00:36:53.442407  export SHELL=3D/bin/sh

    2024-02-07T00:36:53.443250  #

    2024-02-07T00:36:53.544956  / # export SHELL=3D/bin/sh. /lava-12710310/=
environment

    2024-02-07T00:36:53.545750  =


    2024-02-07T00:36:53.647473  / # . /lava-12710310/environment/lava-12710=
310/bin/lava-test-runner /lava-12710310/1

    2024-02-07T00:36:53.648792  =


    2024-02-07T00:36:53.652853  / # /lava-12710310/bin/lava-test-runner /la=
va-12710310/1

    2024-02-07T00:36:53.845385  + export TESTRUN_ID=3D1_bootrr

    2024-02-07T00:36:53.845540  + cd /lava-12710310/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
juno-uboot                   | arm64 | lab-broonie   | gcc-10   | cip://5.1=
0.y-...64_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2d2f0afbda7b6fe8e1e93

  Results:     47 PASS, 13 FAIL, 1 SKIP
  Full config: cip://5.10.y-cip/arm64/qemu_arm64_defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/cip---5.10.y-cip-arm64-qemu_arm64_defconfig/g=
cc-10/lab-broonie/baseline-nfs-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/cip---5.10.y-cip-arm64-qemu_arm64_defconfig/g=
cc-10/lab-broonie/baseline-nfs-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65c2d2f0afbda7b6fe8e1ece
        failing since 125 days (last pass: v5.10.184-cip36-8-gb192df20e8c9,=
 first fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2024-02-07T00:46:11.462830  <8>[   55.258313] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 551025_1.6.2.4.1>
    2024-02-07T00:46:11.581581  / # #
    2024-02-07T00:46:11.683477  export SHELL=3D/bin/sh
    2024-02-07T00:46:11.684282  #
    2024-02-07T00:46:11.786202  / # export SHELL=3D/bin/sh. /lava-551025/en=
vironment
    2024-02-07T00:46:11.787066  =

    2024-02-07T00:46:11.889126  / # . /lava-551025/environment/lava-551025/=
bin/lava-test-runner /lava-551025/1
    2024-02-07T00:46:11.890516  =

    2024-02-07T00:46:11.894482  / # /lava-551025/bin/lava-test-runner /lava=
-551025/1
    2024-02-07T00:46:12.066329  + export TESTRUN_ID=3D1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2d520be4cfa6eb88e1e83

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-jun=
o-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-jun=
o-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65c2d520be4cfa6eb88e1ebf
        failing since 125 days (last pass: v5.10.184-cip36, first fail: v5.=
10.194-cip39-1-g53e59f50ca3ff)

    2024-02-07T00:55:29.857827  <8>[   43.820046] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 551050_1.6.2.4.1>
    2024-02-07T00:55:29.962194  / # #
    2024-02-07T00:55:30.065149  export SHELL=3D/bin/sh
    2024-02-07T00:55:30.065961  #
    2024-02-07T00:55:30.167916  / # export SHELL=3D/bin/sh. /lava-551050/en=
vironment
    2024-02-07T00:55:30.168715  =

    2024-02-07T00:55:30.270674  / # . /lava-551050/environment/lava-551050/=
bin/lava-test-runner /lava-551050/1
    2024-02-07T00:55:30.272019  =

    2024-02-07T00:55:30.289546  / # /lava-551050/bin/lava-test-runner /lava=
-551050/1
    2024-02-07T00:55:30.457345  + export TESTRUN_ID=3D1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2d660804d6b9fca8e1ecb

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig+kselftest/gcc-10/lab-broonie/baseli=
ne-nfs-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig+kselftest/gcc-10/lab-broonie/baseli=
ne-nfs-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65c2d660804d6b9fca8e1eff
        failing since 5 days (last pass: v5.10.201-cip41-69-g8f7b450fc28ed,=
 first fail: v5.10.208-cip43-4-g1c63c70fb18b8)

    2024-02-07T01:00:48.939473  <8>[   55.980869] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 551104_1.6.2.4.1>
    2024-02-07T01:00:49.058129  / # #
    2024-02-07T01:00:49.160839  export SHELL=3D/bin/sh
    2024-02-07T01:00:49.161296  #
    2024-02-07T01:00:49.262674  / # export SHELL=3D/bin/sh. /lava-551104/en=
vironment
    2024-02-07T01:00:49.263442  =

    2024-02-07T01:00:49.365391  / # . /lava-551104/environment/lava-551104/=
bin/lava-test-runner /lava-551104/1
    2024-02-07T01:00:49.366746  =

    2024-02-07T01:00:49.371081  / # /lava-551104/bin/lava-test-runner /lava=
-551104/1
    2024-02-07T01:00:49.770910  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2d23813234ad7468e202f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig+kselftest/gcc-10/lab-broonie/baseli=
ne-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig+kselftest/gcc-10/lab-broonie/baseli=
ne-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c2d23813234ad74=
68e2030
        new failure (last pass: v5.10.209-cip44) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2d2b0a94a0ad8ce8e1e7a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie=
/baseline-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie=
/baseline-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c2d2b0a94a0ad8c=
e8e1e7b
        failing since 1 day (last pass: v5.10.208-cip43-4-g1c63c70fb18b8, f=
irst fail: v5.10.209-cip44) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2d164db043fbd398e1e79

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig/gcc-10/lab-cip/baseline-nfs-r8a774a=
1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig/gcc-10/lab-cip/baseline-nfs-r8a774a=
1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c2d164db043fbd3=
98e1e7a
        failing since 125 days (last pass: v5.10.194-cip39, first fail: v5.=
10.194-cip39-1-g53e59f50ca3ff) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2d1f70ae5a9e8418e1f38

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-n=
fs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-n=
fs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c2d1f70ae5a9e84=
18e1f39
        failing since 5 days (last pass: v5.10.201-cip41-69-g8f7b450fc28ed,=
 first fail: v5.10.208-cip43-4-g1c63c70fb18b8) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2d46204978d2f488e1e7a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/bas=
eline-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/bas=
eline-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c2d46204978d2f4=
88e1e7b
        failing since 168 days (last pass: v5.10.186-cip37-14-gc9b5a049d8ea=
, first fail: v5.10.186-cip37-27-gd6d928db0a620) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/65c2d1dc0ae5a9e8418e1e79

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/65c2d1dc0ae5a9e8418e1e7f
        failing since 321 days (last pass: v5.10.173-cip28, first fail: v5.=
10.175-cip29)

    2024-02-07T00:41:41.855201  /lava-12710338/1/../bin/lava-test-case

    2024-02-07T00:41:41.890453  <8>[   37.942917] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/65c2d1dc0ae5a9e8418e1e80
        failing since 321 days (last pass: v5.10.173-cip28, first fail: v5.=
10.175-cip29)

    2024-02-07T00:41:39.680494  <8>[   35.730946] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2024-02-07T00:41:40.753200  /lava-12710338/1/../bin/lava-test-case

    2024-02-07T00:41:40.793313  <8>[   36.845899] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
rk3399-rock-pi-4b            | arm64 | lab-collabora | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2d0355d9dba30b18e1eb7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig/gcc-10/lab-collabora/baseline-nfs-r=
k3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig/gcc-10/lab-collabora/baseline-nfs-r=
k3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65c2d0355d9dba30b18e1ebc
        failing since 125 days (last pass: v5.10.184-cip36, first fail: v5.=
10.194-cip39-1-g53e59f50ca3ff)

    2024-02-07T00:40:38.423530  / # #

    2024-02-07T00:40:39.680556  export SHELL=3D/bin/sh

    2024-02-07T00:40:39.691512  #

    2024-02-07T00:40:41.433598  / # export SHELL=3D/bin/sh. /lava-12710294/=
environment

    2024-02-07T00:40:41.444534  =


    2024-02-07T00:40:41.445007  / # . /lava-12710294/environment

    2024-02-07T00:40:44.639087  /lava-12710294/bin/lava-test-runner /lava-1=
2710294/1

    2024-02-07T00:40:44.650827  / # /lava-12710294/bin/lava-test-runner /la=
va-12710294/1

    2024-02-07T00:40:44.830621  + export TESTRUN_ID=3D1_bootrr

    2024-02-07T00:40:44.831029  + cd /lava-12710294/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
rk3399-rock-pi-4b            | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2d157d5477164478e1e88

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig+kselftest/gcc-10/lab-collabora/base=
line-nfs-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig+kselftest/gcc-10/lab-collabora/base=
line-nfs-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65c2d157d5477164478e1e8d
        failing since 125 days (last pass: v5.10.184-cip36, first fail: v5.=
10.194-cip39-1-g53e59f50ca3ff)

    2024-02-07T00:39:33.301109  #

    2024-02-07T00:39:34.562528  / # #export SHELL=3D/bin/sh

    2024-02-07T00:39:34.573488  =


    2024-02-07T00:39:34.573963  / # export SHELL=3D/bin/sh

    2024-02-07T00:39:36.316883  . /lava-12710332/environment

    2024-02-07T00:39:36.327869  / # . /lava-12710332/environment

    2024-02-07T00:39:39.521827  /lava-12710332/bin/lava-test-runner /lava-1=
2710332/1

    2024-02-07T00:39:39.535627  / # /lava-12710332/bin/lava-test-runner /la=
va-12710332/1

    2024-02-07T00:39:39.969099  + export TESTRUN_ID=3D1_bootrr

    2024-02-07T00:39:39.969600  + cd /lava-12710332/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
sun50i-a64-pine64-plus       | arm64 | lab-broonie   | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2d0bf6e38672c998e1ec7

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-sun=
50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-sun=
50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65c2d0bf6e38672c998e1ef3
        failing since 388 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-07T00:36:45.405555  + set +x
    2024-02-07T00:36:45.408619  <8>[   29.868642] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 551058_1.6.2.4.1>
    2024-02-07T00:36:45.522580  / # #
    2024-02-07T00:36:45.624368  export SHELL=3D/bin/sh
    2024-02-07T00:36:45.624835  #
    2024-02-07T00:36:45.726457  / # export SHELL=3D/bin/sh. /lava-551058/en=
vironment
    2024-02-07T00:36:45.726924  =

    2024-02-07T00:36:45.828403  / # . /lava-551058/environment/lava-551058/=
bin/lava-test-runner /lava-551058/1
    2024-02-07T00:36:45.829140  =

    2024-02-07T00:36:45.832141  / # /lava-551058/bin/lava-test-runner /lava=
-551058/1 =

    ... (12 line(s) more)  =

 =20

