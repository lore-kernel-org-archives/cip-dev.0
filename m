Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3D4C636D4
	for <webhook@archiver.kernel.org>; Tue,  7 Feb 2023 05:37:49 +0000 (UTC)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
 by mx.groups.io with SMTP id smtpd.web11.77282.1675748265938021543
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 06 Feb 2023 21:37:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=K0GIFyKC;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.177, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f177.google.com with SMTP id 141so9778753pgc.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 06 Feb 2023 21:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6d/HxSQH9EbEbl8nb0Vhiij/4r92GYQ4Eyr2bHTPUo=;
        b=K0GIFyKCJfwkgWeux7cemNGqYvWhHBrowu3+WF9O9MiW5kZjKic7zn+bEiWAbO2mBI
         IfVw8I/7popKmwQsL+dDVFqlKEs0+8kML/GmxaMwZdWijC1bcvS4/KLJ+QTtszVZGE7k
         MoQ6K6sIpnBEUFYzKUdZbA7cf2zBfwdiD+YHFAdDtbtf346r6IGUgTL9LUDuQkW/ObQK
         0mCEpts1RmQNxPgZQ0TzCYdMZrP1pcDryZ4CGcQwdavCqcybH2tCEYixuSNXuPJypnbx
         BvLpIOeckX45jXA7wlGeMtjFVCgqfgMmANpywSh9z9v87ajVvKhEAq3UqvxEyZXZwof8
         cGyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q6d/HxSQH9EbEbl8nb0Vhiij/4r92GYQ4Eyr2bHTPUo=;
        b=N7E7uUSsy3B53irxfz8Y31h3iIeUwzPUmS5FvHcao0PLjmk0W0P8jg5N+hHTTeW332
         N28/Z6ZmPSvfcfHozJSfPSz9/l7V20hr+RXP8IrgUzv+QPbkmtFcHfrA7cHLsAAE1g1E
         wla26PtMFljb6gIH7tGPxz2V9H6tp2Eub829cHpPo9vUZZjombbVTqlS3sG1L2NNWa1D
         9CUs1nybIUrKWFDCttJIvByGQ4Q6hJOB1AOq8D4ETB7H2OMwsmIYqOWz4jmdfv2hcFNo
         H5siiWnHpiryq2L/f4XLNtm6MArNuwCfOUv4KNNvEvPudRFUF7M4NCWVBvOx4YSioELU
         yLiQ==
X-Gm-Message-State: AO0yUKURkgoIAU/8xF0GRtNQjr04BkoNHO3PfTAJcAxltYkyfyBNxcb/
	HIjMyhajEKQr/IeUgYmVilZPFwDPDRLC6q/8Dp/zkg==
X-Google-Smtp-Source: AK7set/clEp+4mTbCJkV/CVGqy2Yds1Nq3IimLB1MJFiVyGRCKmo7WhCArmEyZ7gysVA2FnJgd71Rg==
X-Received: by 2002:a62:3385:0:b0:593:407b:11f0 with SMTP id z127-20020a623385000000b00593407b11f0mr1486900pfz.34.1675748265046;
        Mon, 06 Feb 2023 21:37:45 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y9-20020aa78f29000000b0058d9b68042fsm8389691pfr.14.2023.02.06.21.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 21:37:44 -0800 (PST)
Message-ID: <63e1e3a8.a70a0220.1d061.e8e1@mx.google.com>
Date: Mon, 06 Feb 2023 21:37:44 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-cip-rt
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.4.302-cip72-rt42
X-Kernelci-Report-Type: test
Subject: cip/linux-4.4.y-cip-rt baseline: 90 runs,
 7 regressions (v4.4.302-cip72-rt42)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 Feb 2023 05:37:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10613

cip/linux-4.4.y-cip-rt baseline: 90 runs, 7 regressions (v4.4.302-cip72-rt4=
2)

Regressions Summary
-------------------

platform              | arch  | lab           | compiler | defconfig       =
             | regressions
----------------------+-------+---------------+----------+-----------------=
-------------+------------
qemu_arm64-virt-gicv2 | arm64 | lab-broonie   | gcc-10   | defconfig       =
             | 1          =

qemu_arm64-virt-gicv2 | arm64 | lab-collabora | gcc-10   | defconfig       =
             | 1          =

qemu_arm64-virt-gicv3 | arm64 | lab-broonie   | gcc-10   | defconfig       =
             | 1          =

rk3288-veyron-jaq     | arm   | lab-collabora | gcc-10   | multi_v7_defconf=
ig           | 2          =

rk3288-veyron-jaq     | arm   | lab-collabora | gcc-10   | multi_v7_defc...=
g+preempt_rt | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip-rt/ker=
nel/v4.4.302-cip72-rt42/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.4.y-cip-rt
  Describe: v4.4.302-cip72-rt42
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      fe1cf8ef6e9d76107c4a6e1bf8cc27263abe6698 =



Test Regressions
---------------- =



platform              | arch  | lab           | compiler | defconfig       =
             | regressions
----------------------+-------+---------------+----------+-----------------=
-------------+------------
qemu_arm64-virt-gicv2 | arm64 | lab-broonie   | gcc-10   | defconfig       =
             | 1          =


  Details:     https://kernelci.org/test/plan/id/63e1dfa4b23f2922e88c865a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip72-rt42/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gi=
cv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip72-rt42/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gi=
cv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230203.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63e1dfa4b23f2922e88c8=
65b
        failing since 67 days (last pass: v4.4.296-cip67-rt37, first fail: =
v4.4.302-cip71-rt41) =

 =



platform              | arch  | lab           | compiler | defconfig       =
             | regressions
----------------------+-------+---------------+----------+-----------------=
-------------+------------
qemu_arm64-virt-gicv2 | arm64 | lab-collabora | gcc-10   | defconfig       =
             | 1          =


  Details:     https://kernelci.org/test/plan/id/63e1dbc443afee58438c8679

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip72-rt42/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-=
gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip72-rt42/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-=
gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230203.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63e1dbc443afee58438c8=
67a
        failing since 67 days (last pass: v4.4.296-cip67-rt37, first fail: =
v4.4.302-cip71-rt41) =

 =



platform              | arch  | lab           | compiler | defconfig       =
             | regressions
----------------------+-------+---------------+----------+-----------------=
-------------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie   | gcc-10   | defconfig       =
             | 1          =


  Details:     https://kernelci.org/test/plan/id/63e1df90f7e09c73e48c8646

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip72-rt42/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gi=
cv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip72-rt42/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gi=
cv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230203.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63e1df90f7e09c73e48c8=
647
        failing since 357 days (last pass: v4.4.296-cip67-rt37, first fail:=
 v4.4.302-cip68-rt38) =

 =



platform              | arch  | lab           | compiler | defconfig       =
             | regressions
----------------------+-------+---------------+----------+-----------------=
-------------+------------
rk3288-veyron-jaq     | arm   | lab-collabora | gcc-10   | multi_v7_defconf=
ig           | 2          =


  Details:     https://kernelci.org/test/plan/id/63e1d98bad6fd6a7578c8652

  Results:     37 PASS, 22 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip72-rt42/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-ve=
yron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip72-rt42/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-ve=
yron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230203.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/63e1d98bad6fd6a7578c866c
        new failure (last pass: v4.4.302-cip71-rt41)

    2023-02-07T04:53:50.765942  ST

    2023-02-07T04:53:50.766235  =


    2023-02-07T04:53:50.769824  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-02-07T04:53:50.771791  FIRST, INC default to 1.

    2023-02-07T04:53:50.772371  =


    2023-02-07T04:53:50.775202  	-w	Pad to last with leading zeros
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/63e1d98bad6fd6a7578c866d
        new failure (last pass: v4.4.302-cip71-rt41)

    2023-02-07T04:53:50.752075  BusyBox v1.31.1 (2023-02-03 20:15:52 UTC) m=
ulti-call binary.

    2023-02-07T04:53:50.752688  =


    2023-02-07T04:53:50.764496  Usage: seq [-w] [-s SEP] [FIRST [INC]] LA[ =
  24.981083] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-au=
dio-present RESULT=3Dfail>
   =

 =



platform              | arch  | lab           | compiler | defconfig       =
             | regressions
----------------------+-------+---------------+----------+-----------------=
-------------+------------
rk3288-veyron-jaq     | arm   | lab-collabora | gcc-10   | multi_v7_defc...=
g+preempt_rt | 2          =


  Details:     https://kernelci.org/test/plan/id/63e1da036c44e6dd418c8645

  Results:     37 PASS, 22 FAIL, 2 SKIP
  Full config: multi_v7_defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip72-rt42/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-collabora/baselin=
e-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip72-rt42/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-collabora/baselin=
e-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230203.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/63e1da036c44e6dd418c8672
        new failure (last pass: v4.4.302-cip71-rt41)

    2023-02-07T04:55:53.569195  Print numbers fro[   25.556982] <LAVA_SIGNA=
L_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-audio-present RESULT=3Dfai=
l>

    2023-02-07T04:55:53.571500  m FIRST to LAST, in steps of INC.

    2023-02-07T04:55:53.574165  FIRST, INC default to 1.

    2023-02-07T04:55:53.574394  =


    2023-02-07T04:55:53.577083  	-w	Pad to last with leading zeros

    2023-02-07T04:55:53.579266  	-s SEP	String separator

    2023-02-07T04:55:53.582815  /lava-9042822/1/../bin/lava-test-case
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/63e1da036c44e6dd418c8673
        new failure (last pass: v4.4.302-cip71-rt41)

    2023-02-07T04:55:53.517342  [   25.509633] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dfail>

    2023-02-07T04:55:53.554018  BusyBox v1.31.1 (2023-02-03 20:15:52 UTC) m=
ulti-call binary.

    2023-02-07T04:55:53.554250  =


    2023-02-07T04:55:53.558333  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-02-07T04:55:53.558589  =

   =

 =20

