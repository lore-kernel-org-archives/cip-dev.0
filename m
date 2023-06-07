Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0011BC7EE29
	for <webhook@archiver.kernel.org>; Wed,  7 Jun 2023 14:28:27 +0000 (UTC)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
 by mx.groups.io with SMTP id smtpd.web11.10137.1686148102580286697
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 07 Jun 2023 07:28:22 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=ccuWryI3;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.174, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-543ae674f37so1814165a12.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 07 Jun 2023 07:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686148101; x=1688740101;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3VGmIk/47fJXl/w+lbDXESPOAL9bFjVuv+tDqf4ZDK4=;
        b=ccuWryI3Drmm7mQVeOoOGQxCFn/WwZtXCxkAj7jOjNkARLlzBx3Xxx8vBnoNDbIBOW
         9aViFprHZ+MGCaFHH+qK36RozYZ3VsnOgOwon5rD+2nf4rqkZ1+hDLQ9/tK5BFYE3vXc
         zkoCT1U4QgNOm6MHqmWGKwV17A3/zcqcTcnxoyh+VQv6/iJ1lw5wnOEylkUJsDoWtv/j
         X/bHvPN7uewTOofbG4srkmxevEh32Ru8shgciHjXNOIkHjeR5VAtKv3gee0kvyod7Rc3
         XHRqYbpTXDTPh2h4J19+ZuuvJyrAeg1gNmji+64z9sjWvTBgmx/5TFkjQ2RuRsCzFhi/
         LyKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686148101; x=1688740101;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3VGmIk/47fJXl/w+lbDXESPOAL9bFjVuv+tDqf4ZDK4=;
        b=TsoVOgtaYsCGbDHmbLFdQhqUfWhCI427fBv0q4+UzWS31l4JRMY6LIFCdwiF9oD0bY
         jwtM8JxzcPx/n5iLI2Daq2gi8VpxT2WBORfeu3fpA8AF2xZ8zpoGzNvfyZd/Tn9Qh5G7
         L+7BbeOmPe2tQl+Ug01rR3q3pwbquypxuWaE/lARcYXgG3hiISXN9Cbp2tJtc3j4D6sq
         HgS1vNcLf7YxNA0uES43MM8mqls8pTQAtXcrKRJTYngH+IhyZcBCx+jBdHaXVpbP373L
         foYCgYji3OM21hJ/qHIBCLigZI2Z1/PJfS7Gs6zUkzrG6o6/Z1kJ1KbXGut9gZJ0eVv6
         +04w==
X-Gm-Message-State: AC+VfDxG3QNov5yfJ5hlJgp6YpbukY+QFTW34RUdJSiIHmND92T/QOcr
	AdKoLXlNyluPgYOzTSvl/pQEDQCcFvFGak2GHImrLA==
X-Google-Smtp-Source: ACHHUZ52AHMWPNjUPz44q7b23BVebspcz5VE9TQtIo/Uq4kvy/V80cWoO0E+n0JeErX2+W3jAk6XGg==
X-Received: by 2002:a17:90a:74cd:b0:258:c4b5:c6b4 with SMTP id p13-20020a17090a74cd00b00258c4b5c6b4mr1702619pjl.12.1686148101015;
        Wed, 07 Jun 2023 07:28:21 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id mv21-20020a17090b199500b00253311d508esm1466900pjb.27.2023.06.07.07.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 07:28:20 -0700 (PDT)
Message-ID: <64809404.170a0220.fd8e8.2e39@mx.google.com>
Date: Wed, 07 Jun 2023 07:28:20 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-cip-rt
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip76-rt44
Subject: cip/linux-4.4.y-cip-rt baseline: 140 runs,
 7 regressions (v4.4.302-cip76-rt44)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Jun 2023 14:28:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11913

cip/linux-4.4.y-cip-rt baseline: 140 runs, 7 regressions (v4.4.302-cip76-rt=
44)

Regressions Summary
-------------------

platform              | arch  | lab           | compiler | defconfig       =
             | regressions
----------------------+-------+---------------+----------+-----------------=
-------------+------------
odroid-xu3            | arm   | lab-collabora | gcc-10   | multi_v7_defc...=
g+preempt_rt | 1          =

qemu_arm64-virt-gicv2 | arm64 | lab-broonie   | gcc-10   | defconfig       =
             | 1          =

qemu_arm64-virt-gicv2 | arm64 | lab-collabora | gcc-10   | defconfig       =
             | 1          =

qemu_arm64-virt-gicv3 | arm64 | lab-broonie   | gcc-10   | defconfig       =
             | 1          =

qemu_arm64-virt-gicv3 | arm64 | lab-collabora | gcc-10   | defconfig       =
             | 1          =

rk3288-veyron-jaq     | arm   | lab-collabora | gcc-10   | multi_v7_defconf=
ig           | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip-rt/ker=
nel/v4.4.302-cip76-rt44/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.4.y-cip-rt
  Describe: v4.4.302-cip76-rt44
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      246f4be89a7760f90649094cbfabcccfce7dafd1 =



Test Regressions
---------------- =



platform              | arch  | lab           | compiler | defconfig       =
             | regressions
----------------------+-------+---------------+----------+-----------------=
-------------+------------
odroid-xu3            | arm   | lab-collabora | gcc-10   | multi_v7_defc...=
g+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/64808c854868082be530613c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip76-rt44/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-collabora/baselin=
e-odroid-xu3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip76-rt44/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-collabora/baselin=
e-odroid-xu3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64808c854868082be5306=
13d
        new failure (last pass: v4.4.302-cip74-rt43) =

 =



platform              | arch  | lab           | compiler | defconfig       =
             | regressions
----------------------+-------+---------------+----------+-----------------=
-------------+------------
qemu_arm64-virt-gicv2 | arm64 | lab-broonie   | gcc-10   | defconfig       =
             | 1          =


  Details:     https://kernelci.org/test/plan/id/64808e6f0259acfea630615d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip76-rt44/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gi=
cv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip76-rt44/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gi=
cv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64808e6f0259acfea6306=
15e
        failing since 188 days (last pass: v4.4.296-cip67-rt37, first fail:=
 v4.4.302-cip71-rt41) =

 =



platform              | arch  | lab           | compiler | defconfig       =
             | regressions
----------------------+-------+---------------+----------+-----------------=
-------------+------------
qemu_arm64-virt-gicv2 | arm64 | lab-collabora | gcc-10   | defconfig       =
             | 1          =


  Details:     https://kernelci.org/test/plan/id/64808bea08d019a27e306134

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip76-rt44/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-=
gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip76-rt44/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-=
gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64808bea08d019a27e306=
135
        failing since 188 days (last pass: v4.4.296-cip67-rt37, first fail:=
 v4.4.302-cip71-rt41) =

 =



platform              | arch  | lab           | compiler | defconfig       =
             | regressions
----------------------+-------+---------------+----------+-----------------=
-------------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie   | gcc-10   | defconfig       =
             | 1          =


  Details:     https://kernelci.org/test/plan/id/64808e33c9b83f4b95306140

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip76-rt44/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gi=
cv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip76-rt44/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gi=
cv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64808e33c9b83f4b95306=
141
        failing since 188 days (last pass: v4.4.296-cip67-rt37, first fail:=
 v4.4.302-cip71-rt41) =

 =



platform              | arch  | lab           | compiler | defconfig       =
             | regressions
----------------------+-------+---------------+----------+-----------------=
-------------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-collabora | gcc-10   | defconfig       =
             | 1          =


  Details:     https://kernelci.org/test/plan/id/64808be8a9c8d077c3306164

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip76-rt44/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-=
gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip76-rt44/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-=
gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64808be8a9c8d077c3306=
165
        failing since 188 days (last pass: v4.4.296-cip67-rt37, first fail:=
 v4.4.302-cip71-rt41) =

 =



platform              | arch  | lab           | compiler | defconfig       =
             | regressions
----------------------+-------+---------------+----------+-----------------=
-------------+------------
rk3288-veyron-jaq     | arm   | lab-collabora | gcc-10   | multi_v7_defconf=
ig           | 2          =


  Details:     https://kernelci.org/test/plan/id/64808a06973b32351330613d

  Results:     37 PASS, 22 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip76-rt44/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-ve=
yron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip76-rt44/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-ve=
yron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/64808a06973b323513306162
        failing since 120 days (last pass: v4.4.302-cip71-rt41, first fail:=
 v4.4.302-cip72-rt42)

    2023-06-07T13:45:46.926270  Usage: seq [-w] [-s SEP] [FIRST [INC]] LA[ =
  24.633986] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-au=
dio-present RESULT=3Dfail>

    2023-06-07T13:45:46.926500  ST

    2023-06-07T13:45:46.926719  =


    2023-06-07T13:45:46.931258  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-06-07T13:45:46.933567  FIRST, INC default to 1.

    2023-06-07T13:45:46.933788  =


    2023-06-07T13:45:46.936830  	-w	Pad to last with leading zeros

    2023-06-07T13:45:46.938899  	-s SEP	String separator

    2023-06-07T13:45:46.942546  /lava-10624763/1/../bin/lava-test-case
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/64808a06973b323513306163
        failing since 120 days (last pass: v4.4.302-cip71-rt41, first fail:=
 v4.4.302-cip72-rt42)

    2023-06-07T13:45:46.875801  [   24.586839] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dfail>

    2023-06-07T13:45:46.913710  BusyBox v1.31.1 (2023-05-27 14:14:16 UTC) m=
ulti-call binary.

    2023-06-07T13:45:46.913871  =

   =

 =20

