Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E43FC433F5
	for <webhook@archiver.kernel.org>; Tue, 11 Oct 2022 14:32:41 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web11.8093.1665498755967166168
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 11 Oct 2022 07:32:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=MCRuWnkY;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.171,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f171.google.com with SMTP id c24so13349652pls.9
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 11 Oct 2022 07:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MvCv1r26PzKOSXwOoa3H16YtOcl0qxdBs8EMovx+MyY=;
        b=MCRuWnkYfeloXClO6Nm7b7Qp0T+8GU474UNG7sfPtpBkAHg7KZBqU8P0nmOBsPIsRm
         OrVAxckSqI8uY7MxdEButkzxd8S7JiKw98bbgxMAiWpFbKOCDDdSA5wxG9ltZMXg9hqf
         L66Rpay51PO9Xw0tRPv+oVxLoL1Bj99lFdarSJa+R5AU+/09HnDwL/EDWpCvwhxqSqzl
         Ofvz3NRjhpOAPHHm2um6JAtQPdjeX+qzhCdJ0jkYpxZD/oz/WJ9o1SbryeIByIC5gR9C
         sBZ/Ggp21CQP1zipMsQs/ZyvZPugkPh6rYRAmBdVw2iZ0qKlE9wEE8Dr1qAxey4C8P7k
         Fgvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MvCv1r26PzKOSXwOoa3H16YtOcl0qxdBs8EMovx+MyY=;
        b=Dklt6RDCgN71CZXYPRrXJmUFCQtYOUkxToDYk/A3pvGLTtnngliYSip25dWkFsixs1
         Ci/x+Q2dtcNiUQC2WT6+IaPNKg01HxDgyU/tXCzAx0LaHZl38t9GnU1bXbw1K9U2FtH3
         4cciIa0aQw8kojWKvdklPUiQVT+bwW4N6u1FhHntSge7XTqe60tlrxBsOahI4vJUdQEn
         g+eNGGc6Fr2Hh91LgpDKu5m2bKkUHzpiHr0roaXnaDosiJ6NQW9o1UafRKaf69H3er3l
         Rzxwq3+k7ejbxi/aNhOLUR6Jb8Joly3hAoGQzeIafQJjC+qg0axPjbG4wkVmD7Me8o2d
         hS1w==
X-Gm-Message-State: ACrzQf2XNDRPU6YsA+fsBuYpsBwTD7TsubZ39lGQ3v8PjZXoNd/3SKAV
	BVoOLnrN5S4hVXi5nOHUkjROVWuNHHEZ+5yNBa4=
X-Google-Smtp-Source: 
 AMsMyM6ig0RhRQWYt27aVpyMlEVEAGIoaVuXpD3up6BF8qzi2Me5gq8gxYu8pVJQY1R5UTBNHq5Lzg==
X-Received: by 2002:a17:902:a416:b0:178:a030:5f94 with SMTP id
 p22-20020a170902a41600b00178a0305f94mr24585402plq.162.1665498755077;
        Tue, 11 Oct 2022 07:32:35 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 v29-20020aa799dd000000b0056258a3606csm9039607pfi.215.2022.10.11.07.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 07:32:34 -0700 (PDT)
Message-ID: <63457e82.a70a0220.bfdf.f074@mx.google.com>
Date: Tue, 11 Oct 2022 07:32:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.145-cip17-1-ge85493c8cea0
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip baseline: 95 runs,
 10 regressions (v5.10.145-cip17-1-ge85493c8cea0)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Oct 2022 14:32:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9722

cip/linux-5.10.y-cip baseline: 95 runs, 10 regressions (v5.10.145-cip17-1-g=
e85493c8cea0)

Regressions Summary
-------------------

platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
panda                      | arm   | lab-baylibre  | gcc-10   | omap2plus_d=
efconfig        | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

rk3399-gru-kevin           | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.145-cip17-1-ge85493c8cea0/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.145-cip17-1-ge85493c8cea0
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      e85493c8cea0c5b53ef511efe088b0749b4d5aa0 =



Test Regressions
---------------- =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
panda                      | arm   | lab-baylibre  | gcc-10   | omap2plus_d=
efconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/634576e6b0fae2b1e9cab607

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17-1-ge85493c8cea0/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline=
-panda.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17-1-ge85493c8cea0/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline=
-panda.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/634576e6b0fae2b1e9cab=
608
        failing since 41 days (last pass: v5.10.136-cip14, first fail: v5.1=
0.138-cip15) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/634577074c5b799a09cab612

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17-1-ge85493c8cea0/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/=
baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17-1-ge85493c8cea0/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/=
baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/634577074c5b799a09cab=
613
        failing since 68 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81, =
first fail: v5.10.131-cip13-24-ga6f4ea41fe167) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/634576eb791192b34fcab6f7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17-1-ge85493c8cea0/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabor=
a/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17-1-ge85493c8cea0/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabor=
a/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/634576eb791192b34fcab=
6f8
        failing since 68 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81, =
first fail: v5.10.131-cip13-24-ga6f4ea41fe167) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6345786fa3367b21a7cab5ec

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17-1-ge85493c8cea0/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/=
baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17-1-ge85493c8cea0/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/=
baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6345786fa3367b21a7cab=
5ed
        failing since 67 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81, =
first fail: v5.10.131-cip13-37-ge3a52725ce96) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/634576df7c77d6a1adcab605

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17-1-ge85493c8cea0/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabor=
a/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17-1-ge85493c8cea0/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabor=
a/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/634576df7c77d6a1adcab=
606
        failing since 67 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81, =
first fail: v5.10.131-cip13-37-ge3a52725ce96) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6345772ffa5f6a1292cab620

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17-1-ge85493c8cea0/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/=
baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17-1-ge85493c8cea0/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/=
baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6345772ffa5f6a1292cab=
621
        failing since 76 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81, =
first fail: v5.10.129-cip12-36-g21d9d56f4de5a) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/634576de4c5b799a09cab5f0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17-1-ge85493c8cea0/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabor=
a/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17-1-ge85493c8cea0/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabor=
a/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/634576de4c5b799a09cab=
5f1
        failing since 76 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81, =
first fail: v5.10.129-cip12-36-g21d9d56f4de5a) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63457897a3367b21a7cab613

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17-1-ge85493c8cea0/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/=
baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17-1-ge85493c8cea0/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/=
baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63457897a3367b21a7cab=
614
        failing since 68 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81, =
first fail: v5.10.131-cip13-24-ga6f4ea41fe167) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/634576ff4c5b799a09cab60c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17-1-ge85493c8cea0/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabor=
a/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17-1-ge85493c8cea0/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabor=
a/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/634576ff4c5b799a09cab=
60d
        failing since 68 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81, =
first fail: v5.10.131-cip13-24-ga6f4ea41fe167) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
rk3399-gru-kevin           | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/634576c2370a940f01cab60d

  Results:     90 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17-1-ge85493c8cea0/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabor=
a/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17-1-ge85493c8cea0/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabor=
a/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/case/id=
/634576c2370a940f01cab62f
        failing since 196 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81,=
 first fail: v5.10.106-cip4)

    2022-10-11T13:59:10.075715  /lava-7551996/1/../bin/lava-test-case
    2022-10-11T13:59:10.086838  <8>[   33.664399] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20

