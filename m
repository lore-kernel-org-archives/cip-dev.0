Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA70C61D97
	for <webhook@archiver.kernel.org>; Fri, 24 Nov 2023 02:30:23 +0000 (UTC)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
 by mx.groups.io with SMTP id smtpd.web11.128217.1700793014046842030
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 23 Nov 2023 18:30:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=Bh6WU69U;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.41, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-285196556fcso1139808a91.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 23 Nov 2023 18:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700793013; x=1701397813; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=N8ddVK+F5dh4RdWgzlvQs6YpIphXlZodCvvpBC/3EoQ=;
        b=Bh6WU69U7eIPgMMFhwHT+/czdquIpyhn4kEaSrOlOK4wWp45NY5+k3B1ZhNrfhLjsA
         U95B5EA7P9ELBY4F2OvoFGmRg77k2q/QTZg6UHWIhrYj+DeEY+LJu0HBIKMywYWi+Y6l
         SLbLb7mxfqX8DPswnY1uErGZPgpKnR+0kGJO4g63arCCTL4kZJ7vmEw/6JZ03+TyLTdH
         YiDxjjyx3pgYX7lT56lyJTRCUvg8OXySgROux4arw+g/pFwXJ8sJUt3BlE1sYtQEy4+X
         KOqDIuw2O9HUB/zjVCKB6gi1ZEbmL9Duu7u8ZzFj/4Na0MvYYZPJ7FykqAL3HDeVpjeD
         Tzcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700793013; x=1701397813;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N8ddVK+F5dh4RdWgzlvQs6YpIphXlZodCvvpBC/3EoQ=;
        b=TtfPt0xhRH7eb6asIzc+51HeT0PN2Q98lBhH6FHVKDIJU2GyLIHl7wlZoLVk+xp8GC
         cIv+jWrbjyYTJqgV6/pkaLzKaM4TY4hLKI61hwXB/n6a5TGz5EXAPQomw+689IalODw2
         9nMAYiOrYA4ObcujDRNVftyA4UZyyOR6ECdmjefLuErz74h4J4nT+TGQIOYS2LnD4exU
         hmpg1cNz+1Em+7S4sbNV89c9r4ZP5WK9l7VEKtlHnvdIiHDCm8Iyn5EH6gNWOBW1F5fR
         NaWdI625e7ZkY+4I1bN7qwFoia8Qc6ArznKTo7AepR+G+CyrAeHB52MRMZLE3Fqamavo
         6hyw==
X-Gm-Message-State: AOJu0Yw99Sj1fGRehiprQI4Bb/zR0hnui6KdnfVx70DITqXmUikAGI+t
	3ru1LMor69ztDHhOc737SSVp/WsgfjbJR8CKECI=
X-Google-Smtp-Source: AGHT+IHGohNKGvrRqaK+UUlkFsoONqNCvRsSaLNcC0Xwn5eSRNnoRiN/a0ggvbnyRQ9KcANoBKwItQ==
X-Received: by 2002:a17:90b:4c87:b0:285:5b53:73c6 with SMTP id my7-20020a17090b4c8700b002855b5373c6mr1487404pjb.1.1700793012600;
        Thu, 23 Nov 2023 18:30:12 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a5-20020a170902ee8500b001cf8a4882absm2044787pld.196.2023.11.23.18.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 18:30:11 -0800 (PST)
Message-ID: <65600ab3.170a0220.2c073.55f3@mx.google.com>
Date: Thu, 23 Nov 2023 18:30:11 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.201-cip41-rt17
Subject: cip/linux-5.10.y-cip-rt baseline-nfs: 80 runs,
 17 regressions (v5.10.201-cip41-rt17)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Nov 2023 02:30:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13703

cip/linux-5.10.y-cip-rt baseline-nfs: 80 runs, 17 regressions (v5.10.201-ci=
p41-rt17)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
            | regressions
-----------------------------+-------+---------------+----------+----------=
------------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | multi_v7_=
defconfig   | 1          =

beaglebone-black             | arm   | lab-cip       | gcc-10   | multi_v7_=
defconfig   | 1          =

beaglebone-black             | arm   | lab-broonie   | gcc-10   | omap2plus=
_defconfig  | 1          =

beaglebone-black             | arm   | lab-cip       | gcc-10   | omap2plus=
_defconfig  | 1          =

imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | defconfig=
            | 1          =

imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig   | 1          =

juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
+preempt_rt | 1          =

juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
            | 1          =

meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+preempt_rt | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
            | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
+preempt_rt | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
            | 1          =

rk3399-rock-pi-4b            | arm64 | lab-collabora | gcc-10   | defconfig=
+preempt_rt | 1          =

rk3399-rock-pi-4b            | arm64 | lab-collabora | gcc-10   | defconfig=
            | 1          =

sun50i-a64-pine64-plus       | arm64 | lab-broonie   | gcc-10   | defconfig=
+preempt_rt | 1          =

sun50i-a64-pine64-plus       | arm64 | lab-broonie   | gcc-10   | defconfig=
            | 1          =

sun50i-h5-lib...ch-all-h3-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
            | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.201-cip41-rt17/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.201-cip41-rt17
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      78ed1354cecc021db9a1d8a8b4755fdfcd826e33 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
            | regressions
-----------------------------+-------+---------------+----------+----------=
------------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | multi_v7_=
defconfig   | 1          =


  Details:     https://kernelci.org/test/plan/id/656001e5b2d59d214a7e4a7e

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-beagl=
ebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-beagl=
ebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/656001e5b2d59d214a7e4aaf
        failing since 301 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-11-24T01:51:45.475695  <8>[   49.261136] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 267659_1.6.2.4.1>
    2023-11-24T01:51:45.598871  / # #
    2023-11-24T01:51:45.701501  export SHELL=3D/bin/sh
    2023-11-24T01:51:45.702171  #
    2023-11-24T01:51:45.804122  / # export SHELL=3D/bin/sh. /lava-267659/en=
vironment
    2023-11-24T01:51:45.804783  =

    2023-11-24T01:51:45.906491  / # . /lava-267659/environment/lava-267659/=
bin/lava-test-runner /lava-267659/1
    2023-11-24T01:51:45.907467  =

    2023-11-24T01:51:45.911236  / # /lava-267659/bin/lava-test-runner /lava=
-267659/1
    2023-11-24T01:51:46.161619  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
            | regressions
-----------------------------+-------+---------------+----------+----------=
------------+------------
beaglebone-black             | arm   | lab-cip       | gcc-10   | multi_v7_=
defconfig   | 1          =


  Details:     https://kernelci.org/test/plan/id/656006cea8577ca8bd7e4a83

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebon=
e-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebon=
e-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/656006cea8577ca8bd7e4ab4
        failing since 301 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-11-24T02:13:03.218708  <8>[   45.334516] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1044238_1.6.2.4.1>
    2023-11-24T02:13:03.330390  / # #
    2023-11-24T02:13:03.431859  export SHELL=3D/bin/sh
    2023-11-24T02:13:03.432311  #
    2023-11-24T02:13:03.533260  / # export SHELL=3D/bin/sh. /lava-1044238/e=
nvironment
    2023-11-24T02:13:03.533709  =

    2023-11-24T02:13:03.634690  / # . /lava-1044238/environment/lava-104423=
8/bin/lava-test-runner /lava-1044238/1
    2023-11-24T02:13:03.635450  =

    2023-11-24T02:13:03.639435  / # /lava-1044238/bin/lava-test-runner /lav=
a-1044238/1
    2023-11-24T02:13:03.860955  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
            | regressions
-----------------------------+-------+---------------+----------+----------=
------------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | omap2plus=
_defconfig  | 1          =


  Details:     https://kernelci.org/test/plan/id/656001ef97af0acb5e7e4acb

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nfs-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nfs-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/656001ef97af0acb5e7e4b05
        failing since 246 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.175-cip29-rt12)

    2023-11-24T01:52:18.048202  <8>[   49.455741] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 267670_1.6.2.4.1>
    2023-11-24T01:52:18.163596  / # #
    2023-11-24T01:52:18.266869  export SHELL=3D/bin/sh
    2023-11-24T01:52:18.267768  #
    2023-11-24T01:52:18.369901  / # export SHELL=3D/bin/sh. /lava-267670/en=
vironment
    2023-11-24T01:52:18.370778  =

    2023-11-24T01:52:18.472832  / # . /lava-267670/environment/lava-267670/=
bin/lava-test-runner /lava-267670/1
    2023-11-24T01:52:18.474354  =

    2023-11-24T01:52:18.477387  / # /lava-267670/bin/lava-test-runner /lava=
-267670/1
    2023-11-24T01:52:18.771514  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
            | regressions
-----------------------------+-------+---------------+----------+----------=
------------+------------
beaglebone-black             | arm   | lab-cip       | gcc-10   | omap2plus=
_defconfig  | 1          =


  Details:     https://kernelci.org/test/plan/id/65600a5c06dd971bf67e4a6d

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebo=
ne-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebo=
ne-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65600a5c06dd971bf67e4aa7
        failing since 246 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.175-cip29-rt12)

    2023-11-24T02:28:13.984945  <8>[   45.293237] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1044247_1.6.2.4.1>
    2023-11-24T02:28:14.216630  #
    2023-11-24T02:28:14.319029  / # #export SHELL=3D/bin/sh
    2023-11-24T02:28:14.319721  =

    2023-11-24T02:28:14.421044  / # export SHELL=3D/bin/sh. /lava-1044247/e=
nvironment
    2023-11-24T02:28:14.421698  =

    2023-11-24T02:28:14.523043  / # . /lava-1044247/environment/lava-104424=
7/bin/lava-test-runner /lava-1044247/1
    2023-11-24T02:28:14.524132  =

    2023-11-24T02:28:14.530391  / # /lava-1044247/bin/lava-test-runner /lav=
a-1044247/1
    2023-11-24T02:28:14.929390  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
            | regressions
-----------------------------+-------+---------------+----------+----------=
------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | defconfig=
            | 1          =


  Details:     https://kernelci.org/test/plan/id/656000be999fa016d97e4ac4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm/defconfig/gcc-10/lab-collabora/baseline-nfs-imx6q-sabrel=
ite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm/defconfig/gcc-10/lab-collabora/baseline-nfs-imx6q-sabrel=
ite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/656000be999fa016d97e4acd
        failing since 301 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-11-24T01:47:46.725978  / # #

    2023-11-24T01:47:46.828128  export SHELL=3D/bin/sh

    2023-11-24T01:47:46.828817  #

    2023-11-24T01:47:46.929948  / # export SHELL=3D/bin/sh. /lava-12070529/=
environment

    2023-11-24T01:47:46.930124  =


    2023-11-24T01:47:47.030641  / # . /lava-12070529/environment/lava-12070=
529/bin/lava-test-runner /lava-12070529/1

    2023-11-24T01:47:47.030853  =


    2023-11-24T01:47:47.035063  / # /lava-12070529/bin/lava-test-runner /la=
va-12070529/1

    2023-11-24T01:47:47.219635  + export TESTRUN_ID=3D1_bootrr

    2023-11-24T01:47:47.219721  + cd /lava-12070529/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
            | regressions
-----------------------------+-------+---------------+----------+----------=
------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig   | 1          =


  Details:     https://kernelci.org/test/plan/id/6560003276e8c3f5117e4a78

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-nfs-imx=
6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-nfs-imx=
6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6560003276e8c3f5117e4a80
        failing since 301 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-11-24T01:45:23.530337  + set +x

    2023-11-24T01:45:23.531003  / # <8>[   25.713176] <LAVA_SIGNAL_TESTCASE=
 TEST_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-11-24T01:45:23.531204  <8>[   25.714100] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12070506_1.6.2.4.1>

    2023-11-24T01:45:23.634546  #

    2023-11-24T01:45:23.736383  export SHELL=3D/bin/sh

    2023-11-24T01:45:23.737014  #

    2023-11-24T01:45:23.838372  / # export SHELL=3D/bin/sh. /lava-12070506/=
environment

    2023-11-24T01:45:23.839000  =


    2023-11-24T01:45:23.940367  / # . /lava-12070506/environment/lava-12070=
506/bin/lava-test-runner /lava-12070506/1

    2023-11-24T01:45:23.941326  =

 =

    ... (17 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
            | regressions
-----------------------------+-------+---------------+----------+----------=
------------+------------
juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/6560024734a190320b7e4a8a

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-nfs-j=
uno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-nfs-j=
uno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6560024734a190320b7e4ac9
        new failure (last pass: v5.10.184-cip36-rt14)

    2023-11-24T01:53:41.927157  / # #
    2023-11-24T01:53:42.029960  export SHELL=3D/bin/sh
    2023-11-24T01:53:42.030775  #
    2023-11-24T01:53:42.132499  / # export SHELL=3D/bin/sh. /lava-267685/en=
vironment
    2023-11-24T01:53:42.133367  =

    2023-11-24T01:53:42.235477  / # . /lava-267685/environment/lava-267685/=
bin/lava-test-runner /lava-267685/1
    2023-11-24T01:53:42.236829  =

    2023-11-24T01:53:42.256031  / # /lava-267685/bin/lava-test-runner /lava=
-267685/1
    2023-11-24T01:53:42.411784  + export TESTRUN_ID=3D1_bootrr
    2023-11-24T01:53:42.412366  + cd /lava-267685/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
            | regressions
-----------------------------+-------+---------------+----------+----------=
------------+------------
juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
            | 1          =


  Details:     https://kernelci.org/test/plan/id/656005dfb6c925c0537e4a6d

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-juno-uboot.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-juno-uboot.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/656005e0b6c925c0537e4aad
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-11-24T02:09:10.026820  <8>[   55.907520] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 267743_1.6.2.4.1>
    2023-11-24T02:09:10.131156  / # #
    2023-11-24T02:09:10.233485  export SHELL=3D/bin/sh
    2023-11-24T02:09:10.234324  #
    2023-11-24T02:09:10.336167  / # export SHELL=3D/bin/sh. /lava-267743/en=
vironment
    2023-11-24T02:09:10.336919  =

    2023-11-24T02:09:10.438855  / # . /lava-267743/environment/lava-267743/=
bin/lava-test-runner /lava-267743/1
    2023-11-24T02:09:10.440090  =

    2023-11-24T02:09:10.444214  / # /lava-267743/bin/lava-test-runner /lava=
-267743/1
    2023-11-24T02:09:10.604291  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
            | regressions
-----------------------------+-------+---------------+----------+----------=
------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/6560007d31639a5b807e4a6d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-nfs=
-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-nfs=
-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6560007d31639a5b807e4a76
        new failure (last pass: v5.10.194-cip39-rt16)

    2023-11-24T01:46:13.156399  / # #

    2023-11-24T01:46:13.257020  export SHELL=3D/bin/sh

    2023-11-24T01:46:13.257139  #

    2023-11-24T01:46:13.357715  / # export SHELL=3D/bin/sh. /lava-12070521/=
environment

    2023-11-24T01:46:13.357840  =


    2023-11-24T01:46:13.458352  / # . /lava-12070521/environment/lava-12070=
521/bin/lava-test-runner /lava-12070521/1

    2023-11-24T01:46:13.458529  =


    2023-11-24T01:46:13.469915  / # /lava-12070521/bin/lava-test-runner /la=
va-12070521/1

    2023-11-24T01:46:13.618794  + export TESTRUN_ID=3D1_bootrr

    2023-11-24T01:46:13.618878  + cd /lava-12070521/1/tests/1_bootrr
 =

    ... (10 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
            | regressions
-----------------------------+-------+---------------+----------+----------=
------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
            | 1          =


  Details:     https://kernelci.org/test/plan/id/656006284719e8b8fa7e4a7e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-meson-gxl-s9=
05x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-meson-gxl-s9=
05x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/656006284719e8b8f=
a7e4a7f
        failing since 65 days (last pass: v5.10.179-cip32-rt13, first fail:=
 v5.10.194-cip39-rt16) =

 =



platform                     | arch  | lab           | compiler | defconfig=
            | regressions
-----------------------------+-------+---------------+----------+----------=
------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/6560026cd63070c21e7e4a80

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig+preempt_rt/gcc-10/lab-cip/baseline-nfs-r8a77=
4a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig+preempt_rt/gcc-10/lab-cip/baseline-nfs-r8a77=
4a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6560026cd63070c21=
e7e4a81
        failing since 65 days (last pass: v5.10.186-cip37-rt15, first fail:=
 v5.10.194-cip39-rt16) =

 =



platform                     | arch  | lab           | compiler | defconfig=
            | regressions
-----------------------------+-------+---------------+----------+----------=
------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
            | 1          =


  Details:     https://kernelci.org/test/plan/id/656006eb33079089f87e4a7d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig/gcc-10/lab-cip/baseline-nfs-r8a774a1-hihope-=
rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig/gcc-10/lab-cip/baseline-nfs-r8a774a1-hihope-=
rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/656006eb33079089f=
87e4a7e
        failing since 65 days (last pass: v5.10.186-cip37-rt15, first fail:=
 v5.10.194-cip39-rt16) =

 =



platform                     | arch  | lab           | compiler | defconfig=
            | regressions
-----------------------------+-------+---------------+----------+----------=
------------+------------
rk3399-rock-pi-4b            | arm64 | lab-collabora | gcc-10   | defconfig=
+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/656000a578e5f34ff97e4ac8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-nfs=
-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-nfs=
-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/656000a578e5f34ff97e4ad1
        new failure (last pass: v5.10.184-cip36-rt14)

    2023-11-24T01:47:02.947911  / # #

    2023-11-24T01:47:04.202273  export SHELL=3D/bin/sh

    2023-11-24T01:47:04.212542  #

    2023-11-24T01:47:04.212638  / # export SHELL=3D/bin/sh

    2023-11-24T01:47:05.948567  . /lava-12070517/environment

    2023-11-24T01:47:09.139329  / # . /lava-12070517/environment/lava-12070=
517/bin/lava-test-runner /lava-12070517/1

    2023-11-24T01:47:09.149699  =


    2023-11-24T01:47:09.156376  / # /lava-12070517/bin/lava-test-runner /la=
va-12070517/1

    2023-11-24T01:47:09.315689  + export TESTRUN_ID=3D1_bootrr

    2023-11-24T01:47:09.315769  + cd /lava-12070517/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
            | regressions
-----------------------------+-------+---------------+----------+----------=
------------+------------
rk3399-rock-pi-4b            | arm64 | lab-collabora | gcc-10   | defconfig=
            | 1          =


  Details:     https://kernelci.org/test/plan/id/65600443e9198010077e4a83

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig/gcc-10/lab-collabora/baseline-nfs-rk3399-roc=
k-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig/gcc-10/lab-collabora/baseline-nfs-rk3399-roc=
k-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65600443e9198010077e4a8c
        new failure (last pass: v5.10.179-cip32-rt13)

    2023-11-24T02:02:51.260883  / # #

    2023-11-24T02:02:52.514865  export SHELL=3D/bin/sh

    2023-11-24T02:02:52.525154  #

    2023-11-24T02:02:52.525245  / # export SHELL=3D/bin/sh

    2023-11-24T02:02:54.260951  . /lava-12070626/environment

    2023-11-24T02:02:57.454491  / # . /lava-12070626/environment/lava-12070=
626/bin/lava-test-runner /lava-12070626/1

    2023-11-24T02:02:57.464895  =


    2023-11-24T02:02:57.470962  / # /lava-12070626/bin/lava-test-runner /la=
va-12070626/1

    2023-11-24T02:02:57.638802  + export TESTRUN_ID=3D1_bootrr

    2023-11-24T02:02:57.638912  + cd /lava-12070626/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
            | regressions
-----------------------------+-------+---------------+----------+----------=
------------+------------
sun50i-a64-pine64-plus       | arm64 | lab-broonie   | gcc-10   | defconfig=
+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/656002a3d63070c21e7e4a96

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-nfs-s=
un50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-nfs-s=
un50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/656002a3d63070c21e7e4ac6
        failing since 301 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-11-24T01:54:57.294219  <8>[   68.974103] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 267694_1.6.2.4.1>
    2023-11-24T01:54:57.647261  / # #
    2023-11-24T01:54:57.748842  export SHELL=3D/bin/sh
    2023-11-24T01:54:57.749341  #
    2023-11-24T01:54:57.850594  / # export SHELL=3D/bin/sh. /lava-267694/en=
vironment
    2023-11-24T01:54:57.851008  =

    2023-11-24T01:54:57.952211  / # . /lava-267694/environment/lava-267694/=
bin/lava-test-runner /lava-267694/1
    2023-11-24T01:54:57.952779  =

    2023-11-24T01:54:57.957348  /lava-267694/bin/lava-test-runner /lava-267=
694/1
    2023-11-24T01:55:11.004917  / # + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
            | regressions
-----------------------------+-------+---------------+----------+----------=
------------+------------
sun50i-a64-pine64-plus       | arm64 | lab-broonie   | gcc-10   | defconfig=
            | 1          =


  Details:     https://kernelci.org/test/plan/id/656006b533079089f87e4a6d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-sun50i-a64-p=
ine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-sun50i-a64-p=
ine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/656006b533079089f=
87e4a6e
        failing since 246 days (last pass: v5.10.162-cip24-rt10, first fail=
: v5.10.175-cip29-rt12) =

 =



platform                     | arch  | lab           | compiler | defconfig=
            | regressions
-----------------------------+-------+---------------+----------+----------=
------------+------------
sun50i-h5-lib...ch-all-h3-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
            | 1          =


  Details:     https://kernelci.org/test/plan/id/6560063b49a22e53817e4a8a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-sun50i-h5-li=
bretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-sun50i-h5-li=
bretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6560063b49a22e538=
17e4a8b
        new failure (last pass: v5.10.175-cip29-rt12) =

 =20

