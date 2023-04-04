Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE86FC761A6
	for <webhook@archiver.kernel.org>; Tue,  4 Apr 2023 16:26:32 +0000 (UTC)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
 by mx.groups.io with SMTP id smtpd.web10.106511.1680625591731301694
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 04 Apr 2023 09:26:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=OdGJYZnJ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.49, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f49.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso1798119pjc.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 04 Apr 2023 09:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1680625591;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=S4e43Rd8h0LK4GDip/lMiI5GaAxRhWpat6RqZcc88KQ=;
        b=OdGJYZnJmDKnYSjcMR8AY4tpv1cI0BtdKWh/vM5vlbIBqb6Odf5IRJO+zwH0jusPM/
         WlKd2O7cT4F9L+PCeRk+lWUV6LUfOu4uuNfP9WQevDZzIal+Pkv2NKMxrImO72vmntg1
         uau4x/oN1G4Qr9YkeuF4S8AD9Ix1UfyhsMNl22Xtpc2luIT4ztDwUcUHkHmg3DCONvDa
         3JLtXh7DyxxksCOprrkNP/Fj01c+gqu48ux6aQRtO4Ihcb3JLlWhd06oexLQW4cL/X0c
         JpW5QNMN5nAv2hv1lyoRz274OQXZkDuOVWH0piA3tv0HwQbn5NeSp8OV7LTJ5672RRF5
         LR5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680625591;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S4e43Rd8h0LK4GDip/lMiI5GaAxRhWpat6RqZcc88KQ=;
        b=jjuUX/G1hdiQzqMwZJSjuqvY6gtSwImniPmkZ4fQxniQlHo5PcYjVAdCwZTYftVDUA
         eDAKFuLyk8DasLS/q+fhmyGV3EK4GkgN6Iv0DAgmK0XBCNa94vRX4YfjKAyrUAaZbxJF
         3heLbGHmdrB2OanH3O4o9NBlS5Di8nipaUU8Sx47i/QsS9azX4IHY3vHGRnQTPcmlCfR
         tnWbNjaw4D9nroXEptm1Am97sNWxHW8ppuy4tTFDR7z2T7LUE2UejleaDYv+BVrPnF2w
         oxHR3tnonSTemsEavKC1+p6iAoy3kt/Fk4jxUYgBq91QQK8MBkcbsRjDycaV3WwP/f11
         Xkzw==
X-Gm-Message-State: AAQBX9dv+rBm9b9u9AYz7HQtXBmJQGqA+eBoyK01aFXngnkrU3vsSIBB
	yW2eMxrJTZVjaFcYVe3Ow47eYBGAX3bmy9QnzHJRLg==
X-Google-Smtp-Source: AKy350aCaTBtSH4c57BOYaheYtQmf/BuYWuB+qdTu3YnWvlsAKQx4sUSYaMxHsRIKx/EIxxbiY+ujA==
X-Received: by 2002:a17:90b:1b0f:b0:23f:91e5:1038 with SMTP id nu15-20020a17090b1b0f00b0023f91e51038mr3450720pjb.11.1680625590849;
        Tue, 04 Apr 2023 09:26:30 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p19-20020a17090a429300b0023acdac248dsm8178719pjg.15.2023.04.04.09.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 09:26:30 -0700 (PDT)
Message-ID: <642c4fb6.170a0220.2e67d.fbf2@mx.google.com>
Date: Tue, 04 Apr 2023 09:26:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-cip-rt
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip74-rt43
Subject: cip/linux-4.4.y-cip-rt baseline: 130 runs,
 8 regressions (v4.4.302-cip74-rt43)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Apr 2023 16:26:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11172

cip/linux-4.4.y-cip-rt baseline: 130 runs, 8 regressions (v4.4.302-cip74-rt=
43)

Regressions Summary
-------------------

platform              | arch  | lab           | compiler | defconfig       =
             | regressions
----------------------+-------+---------------+----------+-----------------=
-------------+------------
imx6q-sabrelite       | arm   | lab-collabora | gcc-10   | multi_v7_defc...=
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

rk3288-veyron-jaq     | arm   | lab-collabora | gcc-10   | multi_v7_defc...=
g+preempt_rt | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip-rt/ker=
nel/v4.4.302-cip74-rt43/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.4.y-cip-rt
  Describe: v4.4.302-cip74-rt43
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      22456e8b8d35c6bd1313511bfa4dd945ce7a0c1e =



Test Regressions
---------------- =



platform              | arch  | lab           | compiler | defconfig       =
             | regressions
----------------------+-------+---------------+----------+-----------------=
-------------+------------
imx6q-sabrelite       | arm   | lab-collabora | gcc-10   | multi_v7_defc...=
g+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/642c428c8f00992a0179e932

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip74-rt43/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-collabora/baselin=
e-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip74-rt43/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-collabora/baselin=
e-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230324.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/642c428c8f00992a0179e=
933
        new failure (last pass: v4.4.302-cip72-rt42) =

 =



platform              | arch  | lab           | compiler | defconfig       =
             | regressions
----------------------+-------+---------------+----------+-----------------=
-------------+------------
qemu_arm64-virt-gicv2 | arm64 | lab-broonie   | gcc-10   | defconfig       =
             | 1          =


  Details:     https://kernelci.org/test/plan/id/642c4460e14d83654379e94f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip74-rt43/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gi=
cv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip74-rt43/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gi=
cv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230324.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/642c4460e14d83654379e=
950
        failing since 124 days (last pass: v4.4.296-cip67-rt37, first fail:=
 v4.4.302-cip71-rt41) =

 =



platform              | arch  | lab           | compiler | defconfig       =
             | regressions
----------------------+-------+---------------+----------+-----------------=
-------------+------------
qemu_arm64-virt-gicv2 | arm64 | lab-collabora | gcc-10   | defconfig       =
             | 1          =


  Details:     https://kernelci.org/test/plan/id/642c432825fbadfb1879e934

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip74-rt43/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-=
gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip74-rt43/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-=
gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230324.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/642c432825fbadfb1879e=
935
        failing since 124 days (last pass: v4.4.296-cip67-rt37, first fail:=
 v4.4.302-cip71-rt41) =

 =



platform              | arch  | lab           | compiler | defconfig       =
             | regressions
----------------------+-------+---------------+----------+-----------------=
-------------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie   | gcc-10   | defconfig       =
             | 1          =


  Details:     https://kernelci.org/test/plan/id/642c44103984519e0779e93f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip74-rt43/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gi=
cv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip74-rt43/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gi=
cv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230324.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/642c44103984519e0779e=
940
        failing since 124 days (last pass: v4.4.296-cip67-rt37, first fail:=
 v4.4.302-cip71-rt41) =

 =



platform              | arch  | lab           | compiler | defconfig       =
             | regressions
----------------------+-------+---------------+----------+-----------------=
-------------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-collabora | gcc-10   | defconfig       =
             | 1          =


  Details:     https://kernelci.org/test/plan/id/642c4327173574f59979e924

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip74-rt43/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-=
gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip74-rt43/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-=
gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230324.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/642c4327173574f59979e=
925
        failing since 124 days (last pass: v4.4.296-cip67-rt37, first fail:=
 v4.4.302-cip71-rt41) =

 =



platform              | arch  | lab           | compiler | defconfig       =
             | regressions
----------------------+-------+---------------+----------+-----------------=
-------------+------------
rk3288-veyron-jaq     | arm   | lab-collabora | gcc-10   | multi_v7_defconf=
ig           | 2          =


  Details:     https://kernelci.org/test/plan/id/642c3f9cc6c60d14b479e94c

  Results:     37 PASS, 22 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip74-rt43/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-ve=
yron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip74-rt43/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-ve=
yron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230324.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/642c3f9cc6c60d14b479e975
        failing since 56 days (last pass: v4.4.302-cip71-rt41, first fail: =
v4.4.302-cip72-rt42)

    2023-04-04T15:17:00.282277  ST

    2023-04-04T15:17:00.282482  =


    2023-04-04T15:17:00.286484  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-04-04T15:17:00.288776  FIRST, INC default to 1.

    2023-04-04T15:17:00.288989  =


    2023-04-04T15:17:00.291765  	-w	Pad to last with leading zeros

    2023-04-04T15:17:00.294406  	-s SEP	String separator

    2023-04-04T15:17:00.297539  /lava-9863556/1/../bin/lava-test-case
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/642c3f9cc6c60d14b479e976
        failing since 56 days (last pass: v4.4.302-cip71-rt41, first fail: =
v4.4.302-cip72-rt42)

    2023-04-04T15:17:00.256375  [   54.452825] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dfail>

    2023-04-04T15:17:00.269082  BusyBox v1.31.1 (2023-03-24 11:38:03 UTC) m=
ulti-call binary.

    2023-04-04T15:17:00.269360  =


    2023-04-04T15:17:00.281215  Usage: seq [-w] [-s SEP] [FIRST [INC]] LA[ =
  54.475899] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-au=
dio-present RESULT=3Dfail>
   =

 =



platform              | arch  | lab           | compiler | defconfig       =
             | regressions
----------------------+-------+---------------+----------+-----------------=
-------------+------------
rk3288-veyron-jaq     | arm   | lab-collabora | gcc-10   | multi_v7_defc...=
g+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/642c42a77adfd59a2579e93b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip74-rt43/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-collabora/baselin=
e-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip74-rt43/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-collabora/baselin=
e-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230324.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/642c42a77adfd59a2579e=
93c
        new failure (last pass: v4.4.302-cip72-rt42) =

 =20

