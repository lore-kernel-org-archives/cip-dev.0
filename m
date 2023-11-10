Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21DAC4167B
	for <webhook@archiver.kernel.org>; Fri, 10 Nov 2023 06:46:42 +0000 (UTC)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
 by mx.groups.io with SMTP id smtpd.web10.22603.1699598797379176166
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 09 Nov 2023 22:46:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=Fl4WvIQO;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.52, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-27ff7fe7fbcso1512252a91.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 09 Nov 2023 22:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1699598796; x=1700203596; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hxjwxMzQ3+8fdvXUpPrTTenSUDXm/3lacgewVjxXoY0=;
        b=Fl4WvIQOyvJLl2YZXo9GN98paXX1I9VxhSZue5DEa/f5rLEzeg+828tz0pGr1FSRUi
         XX779gAXLttkUmeGBtE7L9VUoijj1V15tawIVNx2hwRiouCB1u2tT1r2y4C299mZcKJt
         ZYGznnl3Y++/PvHeCbbsMJG3itVUTa4TtYaUSXDOGQzNewJeZFwbQl5+E/N3NV6ihY16
         bWFXhLfzPZGLoGLm6sP+YQZ+5YjQpBcdaoE3LzqgAsp4WIUBnN1LlREBw/VAExe4kVPV
         kMwvSx4BDh1+LRma/k1uw0RGHkulC97hjnZrc4gIfBSodB8kGmC71gu/bm02N1Tm6IdX
         ROPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699598796; x=1700203596;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hxjwxMzQ3+8fdvXUpPrTTenSUDXm/3lacgewVjxXoY0=;
        b=gQOZMwBtkIHpmb1YNAbIoJ65/Jlx7BNBvI3eL+G7SgCmSefqx+52i6dVyTprZowCd8
         UhoFlWJjJuQMt9mYi3CXpsP5M2lG/DOV88Mq6Vz+Hg7VUZE5iw+2YH5C/3Niygsh1WrY
         u68M3OSX0hVbqHhurxQxitwNSc0lQVyAzcHB4UDKV3P+j9fWKfiS5o5tPVuoeO4IZBMn
         D3ij15xfBB3uCpOTLAbwbPqGfUv9RRAEcSEj/DUthPRAZyHZbfxMRH9kmS76gJcNGopU
         1tZQvuSX0yReOGwhSnnTZ7wZkyEMf6IKbA3xJjNiC1RLqH9OWqVEPdDjDk3DtXksZzZS
         ef+w==
X-Gm-Message-State: AOJu0YxN6SbQmbJCUKfjT2oHE4R0rt44vRKilA3Y+ahkU1IQD6NIeqUs
	dkUEmsktstXUUpZf5DDPdUgxi45qaytyaRxQHSYNqw==
X-Google-Smtp-Source: AGHT+IFAtb1uM4IDcqjNnJTLoaVoG+S8Ol3FoRnLZucTyfBNbQTrF6DSIjjxFvTwR5zkEmqLJnArNw==
X-Received: by 2002:a17:90b:180d:b0:282:cb42:246b with SMTP id lw13-20020a17090b180d00b00282cb42246bmr3467947pjb.40.1699598796032;
        Thu, 09 Nov 2023 22:46:36 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t9-20020a17090ad14900b00280976d4ce3sm862086pjw.37.2023.11.09.22.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 22:46:35 -0800 (PST)
Message-ID: <654dd1cb.170a0220.a0047.2cf1@mx.google.com>
Date: Thu, 09 Nov 2023 22:46:35 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.200-cip40
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip baseline-nfs: 37 runs,
 10 regressions (v5.10.200-cip40)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Nov 2023 06:46:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13554

cip/linux-5.10.y-cip baseline-nfs: 37 runs, 10 regressions (v5.10.200-cip40)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
beaglebone-black         | arm   | lab-broonie   | gcc-10   | multi_v7_defc=
onfig           | 1          =

beaglebone-black         | arm   | lab-cip       | gcc-10   | multi_v7_defc=
onfig           | 1          =

imx6q-sabrelite          | arm   | lab-collabora | gcc-10   | multi_v7_defc=
onfig           | 1          =

juno-uboot               | arm64 | lab-broonie   | gcc-10   | cip://5.10.y-=
...64_defconfig | 1          =

juno-uboot               | arm64 | lab-broonie   | gcc-10   | defconfig    =
                | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
                | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+kse=
lftest          | 1          =

rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig    =
                | 1          =

rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig+kse=
lftest          | 1          =

sun50i-a64-pine64-plus   | arm64 | lab-broonie   | gcc-10   | defconfig    =
                | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.200-cip40/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.200-cip40
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      166400a23a22e665f5d880a99149b73abede402d =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
beaglebone-black         | arm   | lab-broonie   | gcc-10   | multi_v7_defc=
onfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/654dc6a53110fb3044efcefe

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-bl=
ack.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-bl=
ack.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/654dc6a53110fb3044efcf2f
        failing since 300 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-11-10T05:58:15.526032  <8>[   49.571709] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 230807_1.6.2.4.1>
    2023-11-10T05:58:15.646594  / # #
    2023-11-10T05:58:15.749793  export SHELL=3D/bin/sh
    2023-11-10T05:58:15.750974  #
    2023-11-10T05:58:15.853191  / # export SHELL=3D/bin/sh. /lava-230807/en=
vironment
    2023-11-10T05:58:15.854064  =

    2023-11-10T05:58:15.956157  / # . /lava-230807/environment/lava-230807/=
bin/lava-test-runner /lava-230807/1
    2023-11-10T05:58:15.957610  =

    2023-11-10T05:58:15.962195  / # /lava-230807/bin/lava-test-runner /lava=
-230807/1
    2023-11-10T05:58:16.226405  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
beaglebone-black         | arm   | lab-cip       | gcc-10   | multi_v7_defc=
onfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/654dc69430acc2890defcf16

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebone-black.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebone-black.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/654dc69430acc2890defcf46
        failing since 300 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-11-10T05:58:01.267726  + set +x
    2023-11-10T05:58:01.271961  <8>[   47.292017] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1036356_1.6.2.4.1>
    2023-11-10T05:58:01.475583  / # #
    2023-11-10T05:58:01.577727  export SHELL=3D/bin/sh
    2023-11-10T05:58:01.578376  #
    2023-11-10T05:58:01.679694  / # export SHELL=3D/bin/sh. /lava-1036356/e=
nvironment
    2023-11-10T05:58:01.680399  =

    2023-11-10T05:58:01.781804  / # . /lava-1036356/environment/lava-103635=
6/bin/lava-test-runner /lava-1036356/1
    2023-11-10T05:58:01.782859  =

    2023-11-10T05:58:01.789566  / # /lava-1036356/bin/lava-test-runner /lav=
a-1036356/1 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
imx6q-sabrelite          | arm   | lab-collabora | gcc-10   | multi_v7_defc=
onfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/654dc65b1603c5e506efcf00

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-nfs-imx6q-sabre=
lite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-nfs-imx6q-sabre=
lite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/654dc65b1603c5e506efcf09
        failing since 300 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-11-10T05:57:35.125358  / # #

    2023-11-10T05:57:35.226964  export SHELL=3D/bin/sh

    2023-11-10T05:57:35.227704  #

    2023-11-10T05:57:35.329412  / # export SHELL=3D/bin/sh. /lava-11982368/=
environment

    2023-11-10T05:57:35.329667  =


    2023-11-10T05:57:35.430915  / # . /lava-11982368/environment/lava-11982=
368/bin/lava-test-runner /lava-11982368/1

    2023-11-10T05:57:35.432060  =


    2023-11-10T05:57:35.448331  / # /lava-11982368/bin/lava-test-runner /la=
va-11982368/1

    2023-11-10T05:57:35.621168  + export TESTRUN_ID=3D1_bootrr

    2023-11-10T05:57:35.621626  + cd /lava-11982368/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
juno-uboot               | arm64 | lab-broonie   | gcc-10   | cip://5.10.y-=
...64_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/654dc9a3eee9c1b968efcf49

  Results:     47 PASS, 13 FAIL, 1 SKIP
  Full config: cip://5.10.y-cip/arm64/qemu_arm64_defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm64/cip---5.10.y-cip-arm64-qemu_arm64_defconfig/gcc-10/lab-broonie=
/baseline-nfs-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm64/cip---5.10.y-cip-arm64-qemu_arm64_defconfig/gcc-10/lab-broonie=
/baseline-nfs-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/654dc9a3eee9c1b968efcf88
        failing since 36 days (last pass: v5.10.184-cip36-8-gb192df20e8c9, =
first fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-11-10T06:11:05.441256  <8>[   56.558038] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 230855_1.6.2.4.1>
    2023-11-10T06:11:05.545080  / #
    2023-11-10T06:11:05.648224  # #export SHELL=3D/bin/sh
    2023-11-10T06:11:05.649073  =

    2023-11-10T06:11:05.751093  / # export SHELL=3D/bin/sh. /lava-230855/en=
vironment
    2023-11-10T06:11:05.751927  =

    2023-11-10T06:11:05.853903  / # . /lava-230855/environment/lava-230855/=
bin/lava-test-runner /lava-230855/1
    2023-11-10T06:11:05.854685  =

    2023-11-10T06:11:05.874273  / # /lava-230855/bin/lava-test-runner /lava=
-230855/1
    2023-11-10T06:11:06.011053  + export TESTRUN_ID=3D1_bootrr =

    ... (9 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
juno-uboot               | arm64 | lab-broonie   | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/654dcd4d3a411d9d50efcf07

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/654dcd4e3a411d9d50efcf46
        failing since 36 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.194-cip39-1-g53e59f50ca3ff)

    2023-11-10T06:27:01.174044  <8>[   43.258950] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 230870_1.6.2.4.1>
    2023-11-10T06:27:01.278137  / # #
    2023-11-10T06:27:01.381099  export SHELL=3D/bin/sh
    2023-11-10T06:27:01.381887  #
    2023-11-10T06:27:01.483852  / # export SHELL=3D/bin/sh. /lava-230870/en=
vironment
    2023-11-10T06:27:01.484615  =

    2023-11-10T06:27:01.586738  / # . /lava-230870/environment/lava-230870/=
bin/lava-test-runner /lava-230870/1
    2023-11-10T06:27:01.588143  =

    2023-11-10T06:27:01.605876  / # /lava-230870/bin/lava-test-runner /lava=
-230870/1
    2023-11-10T06:27:01.774721  + export TESTRUN_ID=3D1_bootrr =

    ... (10 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/654dcb1ccea75bebf7efcfe1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm64/defconfig/gcc-10/lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm64/defconfig/gcc-10/lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/654dcb1ccea75bebf=
7efcfe2
        failing since 36 days (last pass: v5.10.194-cip39, first fail: v5.1=
0.194-cip39-1-g53e59f50ca3ff) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+kse=
lftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/654dcdd8d01885c3a2efcef3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-nfs-r8a774a1-hihop=
e-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-nfs-r8a774a1-hihop=
e-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/654dcdd8d01885c3a=
2efcef4
        failing since 85 days (last pass: v5.10.186-cip37-13-g260094841fe1a=
, first fail: v5.10.186-cip37-14-gc9b5a049d8ea) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/654dcab47eced74637efcf91

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm64/defconfig/gcc-10/lab-collabora/baseline-nfs-rk3399-rock-pi-4b.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm64/defconfig/gcc-10/lab-collabora/baseline-nfs-rk3399-rock-pi-4b.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/654dcab47eced74637efcf9a
        failing since 36 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.194-cip39-1-g53e59f50ca3ff)

    2023-11-10T06:16:17.421267  / # #

    2023-11-10T06:16:18.681893  export SHELL=3D/bin/sh

    2023-11-10T06:16:18.692766  #

    2023-11-10T06:16:18.693184  / # export SHELL=3D/bin/sh

    2023-11-10T06:16:20.436494  / # . /lava-11982457/environment

    2023-11-10T06:16:23.640543  /lava-11982457/bin/lava-test-runner /lava-1=
1982457/1

    2023-11-10T06:16:23.651864  . /lava-11982457/environment

    2023-11-10T06:16:23.656392  / # /lava-11982457/bin/lava-test-runner /la=
va-11982457/1

    2023-11-10T06:16:23.832030  + export TESTRUN_ID=3D1_bootrr

    2023-11-10T06:16:23.832371  + cd /lava-11982457/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig+kse=
lftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/654dcb7f63df20d352efcf5e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm64/defconfig+kselftest/gcc-10/lab-collabora/baseline-nfs-rk3399-r=
ock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm64/defconfig+kselftest/gcc-10/lab-collabora/baseline-nfs-rk3399-r=
ock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/654dcb7f63df20d352efcf67
        failing since 36 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.194-cip39-1-g53e59f50ca3ff)

    2023-11-10T06:19:13.929326  / # #

    2023-11-10T06:19:15.188759  export SHELL=3D/bin/sh

    2023-11-10T06:19:15.199726  #

    2023-11-10T06:19:15.200201  / # export SHELL=3D/bin/sh

    2023-11-10T06:19:16.943940  . /lava-11982478/environment

    2023-11-10T06:19:16.955046  / # . /lava-11982478/environment

    2023-11-10T06:19:20.148423  /lava-11982478/bin/lava-test-runner /lava-1=
1982478/1

    2023-11-10T06:19:20.159863  / # /lava-11982478/bin/lava-test-runner /la=
va-11982478/1

    2023-11-10T06:19:20.599970  + export TESTRUN_ID=3D1_bootrr

    2023-11-10T06:19:20.600427  + cd /lava-11982478/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
sun50i-a64-pine64-plus   | arm64 | lab-broonie   | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/654dcc1e241d26cf2befcef3

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-sun50i-a64-pine64-pl=
us.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-sun50i-a64-pine64-pl=
us.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/654dcc1e241d26cf2befcf22
        failing since 300 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-11-10T06:21:50.963993  <8>[   45.442233] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 230897_1.6.2.4.1>
    2023-11-10T06:21:51.094541  / # #
    2023-11-10T06:21:51.196345  export SHELL=3D/bin/sh
    2023-11-10T06:21:51.196799  #
    2023-11-10T06:21:51.298093  / # export SHELL=3D/bin/sh. /lava-230897/en=
vironment
    2023-11-10T06:21:51.298584  =

    2023-11-10T06:21:51.400178  / # . /lava-230897/environment/lava-230897/=
bin/lava-test-runner /lava-230897/1
    2023-11-10T06:21:51.400884  =

    2023-11-10T06:21:51.404254  / # /lava-230897/bin/lava-test-runner /lava=
-230897/1
    2023-11-10T06:21:51.557856  + export TESTRUN_ID=3D1_bootrr =

    ... (15 line(s) more)  =

 =20

