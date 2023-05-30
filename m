Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4F4C77B7A
	for <webhook@archiver.kernel.org>; Tue, 30 May 2023 17:25:48 +0000 (UTC)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
 by mx.groups.io with SMTP id smtpd.web10.234.1685467542830847970
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 30 May 2023 10:25:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=eYJCh3aj;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.174, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-64d604cc0aaso3740924b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 30 May 2023 10:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685467542; x=1688059542;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=etDxM2XeI9tKlPF5u556xdWWd30MAma3ZLTkcwqwLPo=;
        b=eYJCh3ajq4o8LxoifwApYRQeOY4anOW8l2lNFaq5i4FvwoNK9p4k9KhUkHkte/IWht
         KKTL+V3jXiTBv5y8S1rfREMAkFzLpwmKr4EOLrbpogDhs+NJqL6SRjtKaVzjF+YhULFo
         dHvK3U0HxnXR92MWCERSDweyI8Tz5OoC7XSQ+xSyUmCwLYmbCyu/2kP1sqFqpi1O/clT
         lVM8XUhBxbSHy66KglucmM5mFqsLJFEMDGGHQTQ1ocTTJroiFywRdCoybQJzVZ+eVVeV
         PM/KHaWN6L/OxuJHje5Rkhr4XuxA+eyqGJIA0n5PMmeeV7p1HhCQW8+F768K7KjiOQkq
         GEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685467542; x=1688059542;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=etDxM2XeI9tKlPF5u556xdWWd30MAma3ZLTkcwqwLPo=;
        b=hIPIpsTUJtUCx1Hyb5J/P0ZfuJwoeF9a7LYsWaUyLIYX3pxO+yNDEhyttUj7dxB1ru
         Wps8ycKEp/3gfKHf3elMEh6CLFy237LQTVGDawExdg96WF/AMZFioLZ2EBefEKkmD2P7
         FFem5moj8yiSIsod2DbvYKXVxSmnv+lHpa9HqXEW1x3T1VEpSMCClFMKFKZ6dbf3h8hy
         FWSkC4dl+3Gf0Ju6x6bLaxrgUitpWi30CZkEJKMfm1k3x28Z6uZ7+h+1X/O1p2DQjRzs
         LtzOSNjAOZ2dRlYcIT4jZo+P9Ds7vLshttfNC1wYP1LQKrol19Oo+bFfWhef/6PoVRn2
         w7rg==
X-Gm-Message-State: AC+VfDxNPZchtqOE0a/E5rOPUw1wrCsg01GZBKt1yYiXZqLJNRpyB4UX
	+vcwTDVzWTCIYQ7mklA+eUvLvCkAPJmwP84ZXCgvJA==
X-Google-Smtp-Source: ACHHUZ6+1dECzrjTFsvXZ+jecUwmZVI/zVGl1moHQwqFpsC/1oSxygY8QB2YTLSdAM2dReVwtu9F5w==
X-Received: by 2002:a05:6a20:ce44:b0:111:c8a6:88ca with SMTP id id4-20020a056a20ce4400b00111c8a688camr3086739pzb.58.1685467541465;
        Tue, 30 May 2023 10:25:41 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y18-20020a631812000000b0052871962579sm8877701pgl.63.2023.05.30.10.25.40
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 10:25:40 -0700 (PDT)
Message-ID: <64763194.630a0220.5b90a.0719@mx.google.com>
Date: Tue, 30 May 2023 10:25:40 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.180-cip34-213-g6582dd41d2c22
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 10 runs,
 11 regressions (v5.10.180-cip34-213-g6582dd41d2c22)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 May 2023 17:25:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11708

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 10 runs, 11 regressi=
ons (v5.10.180-cip34-213-g6582dd41d2c22)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C436FA-Flip-hatch   | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =

asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =

hp-11A-G6-EE-grunt       | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =

qemu_riscv64             | riscv  | lab-collabora | gcc-10   | defconfig   =
                 | 2          =

qemu_smp8_riscv64        | riscv  | lab-collabora | gcc-10   | defconfig   =
                 | 1          =

rk3399-gru-kevin         | arm64  | lab-collabora | gcc-10   | defconfig+ar=
m64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.180-cip34-213-g6582dd41d2c22/plan/ltp-tim=
ers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.180-cip34-213-g6582dd41d2c22
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      6582dd41d2c22c9ea2ddcf80d06886b8470ab496

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  604701dc19c5499403ae5afe48103b8e2872952b =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C436FA-Flip-hatch   | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/64761f56000ac4e7152e8642

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-213-g6582dd41d2c22/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-213-g6582dd41d2c22/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64761f56000=
ac4e7152e8647
        failing since 215 days (last pass: v5.10.147-cip18-56-g87bd4289362b=
e, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64761f56000=
ac4e7152e8647
        failing since 215 days (last pass: v5.10.147-cip18-56-g87bd4289362b=
e, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/647623b8ef9e0bf26a2e85f8

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-213-g6582dd41d2c22/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-213-g6582dd41d2c22/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647623b8ef9=
e0bf26a2e85fd
        failing since 215 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7=
f, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647623b8ef9=
e0bf26a2e85fd
        failing since 215 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7=
f, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
hp-11A-G6-EE-grunt       | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/64762f19b2219ff8ee2e861f

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-213-g6582dd41d2c22/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-213-g6582dd41d2c22/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64762f19b22=
19ff8ee2e8624
        failing since 97 days (last pass: v5.10.165-cip25-154-gb7e05ba4f61a=
2, first fail: v5.10.167-cip26-2-g1e87e7748b91) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64762f19b22=
19ff8ee2e8624
        failing since 97 days (last pass: v5.10.165-cip25-154-gb7e05ba4f61a=
2, first fail: v5.10.167-cip26-2-g1e87e7748b91) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
qemu_riscv64             | riscv  | lab-collabora | gcc-10   | defconfig   =
                 | 2          =


  Details:     https://kernelci.org/test/plan/id/6476201833c90c22d92e85e7

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-213-g6582dd41d2c22/riscv/defconfig/gcc-10/lab-=
collabora/ltp-timers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-213-g6582dd41d2c22/riscv/defconfig/gcc-10/lab-=
collabora/ltp-timers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30527.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6476201833c=
90c22d92e85ec
        new failure (last pass: v5.10.180-cip33-21-g090289427e8b2)

    2023-05-30T16:10:53.500462  =

   =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6476201833c=
90c22d92e85ec
        new failure (last pass: v5.10.180-cip33-21-g090289427e8b2)

    2023-05-30T16:10:53.500462  =

   =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
qemu_smp8_riscv64        | riscv  | lab-collabora | gcc-10   | defconfig   =
                 | 1          =


  Details:     https://kernelci.org/test/plan/id/647623c485253663b12e85fc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-213-g6582dd41d2c22/riscv/defconfig/gcc-10/lab-=
collabora/ltp-timers-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-213-g6582dd41d2c22/riscv/defconfig/gcc-10/lab-=
collabora/ltp-timers-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30527.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/647623c485253663b12=
e85fd
        failing since 4 days (last pass: v5.10.179-cip32-384-g291adc46abef0=
, first fail: v5.10.180-cip33-21-g090289427e8b2) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
rk3399-gru-kevin         | arm64  | lab-collabora | gcc-10   | defconfig+ar=
m64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64762abf58f5b113732e85f7

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-213-g6582dd41d2c22/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-213-g6582dd41d2c22/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64762abf58f=
5b113732e85fc
        failing since 215 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7=
f, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64762abf58f=
5b113732e85fc
        failing since 215 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7=
f, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =

 =20

