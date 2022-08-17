Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12BBC32792
	for <webhook@archiver.kernel.org>; Wed, 17 Aug 2022 11:38:14 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by mx.groups.io with SMTP id smtpd.web09.27978.1660736286637712254
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 17 Aug 2022 04:38:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=MeLxQV5E;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.179,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f179.google.com with SMTP id 130so11555779pfy.6
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 17 Aug 2022 04:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=JohdEVbN54XLhyCe/fnOxmBjVoxo5xNIXrPy7iBPPg8=;
        b=MeLxQV5E2sYe8sxo8aowJ7m7yM/98RqGVOXTughyyzpCpaIvKu4R28BwkGtdSWCe+d
         jIRAux6p3CatQsFpIHUq+3Mz7wCDAn7zFO7o0QaWQFRbM27/HPZbahCba8Cy6CkuNuoB
         dELAq6fF/mouY1S/tBDdgNVPEGWZWUxitTphiFD+VVb70cnTLNntcdFRmwcFq3l0iCNB
         KhQFrAy93GHoXAVSL+GNGcEFs6SHlquWd3UZFkBix1dySKQhEUn6doQiVNwDg9pbJHVT
         +h4LvCBhGmqzL6JA4K9LtI8nUZ8V+iRYKkamCxRpX1P4+KvBAoiQ25qG4Kx8ZptGnexJ
         pRRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=JohdEVbN54XLhyCe/fnOxmBjVoxo5xNIXrPy7iBPPg8=;
        b=eu/PiL0kIiyuwaj1JZPyGw0ndXwFPmHmyaG4qVasaYvObKCTcskrnToaMQ8FPbFhUA
         u7+JTlKSmYKAo2C3azfwRllFocK7gDEfyX3moybCTMe9YVTPL/1t95d2DNH5IjO5zKiw
         3jCTB6ewk1HjXL2VstRccvnYJeavqDXM286RU4vzzD1/4NSD1AmTTz5y8C/w5L78v5Ay
         uu9r2BRWx0XdLuUB65Hq+lmvlOhGBlZmo9w7Pl/iz6y8Jlfw+OwDqPsXYg3mdBwHbY4f
         KVJe8/TJxumMvC5vsrqjyWxuz94aDV0EFeyQjdYws+yrFiJlp0FJHidr4yIE/54ZEJJ0
         LfYQ==
X-Gm-Message-State: ACgBeo0A4qnKKriQ7usOgjyks9P8zlFLNcSGD502qHNAvghDOWzhW7wY
	B2vA22R+9k9b8zDV5Ta0B3MFd4JO6SlicLFH
X-Google-Smtp-Source: 
 AA6agR5qFm5SkQLvRRz7SNi1rO+WhwJtJvc6tgsJSy69D6WupC3nhlZEYOo/hhJIajH3MMqh8o1dAQ==
X-Received: by 2002:a63:68d:0:b0:423:317a:1e07 with SMTP id
 135-20020a63068d000000b00423317a1e07mr17492018pgg.172.1660736285558;
        Wed, 17 Aug 2022 04:38:05 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 x28-20020aa7941c000000b0052d63fb109asm10238610pfo.20.2022.08.17.04.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 04:38:03 -0700 (PDT)
Message-ID: <62fcd31b.a70a0220.86062.1188@mx.google.com>
Date: Wed, 17 Aug 2022 04:38:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13-84-g3b53e4dbd9f41
Subject: cip/linux-5.10.y-cip baseline: 80 runs,
 10 regressions (v5.10.131-cip13-84-g3b53e4dbd9f41)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Aug 2022 11:38:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9274

cip/linux-5.10.y-cip baseline: 80 runs, 10 regressions (v5.10.131-cip13-84-=
g3b53e4dbd9f41)

Regressions Summary
-------------------

platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
jetson-tk1                 | arm   | lab-baylibre  | gcc-10   | tegra_defco=
nfig            | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-broonie   | gcc-10   | defconfig  =
                | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
                | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig  =
                | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
                | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.131-cip13-84-g3b53e4dbd9f41/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.131-cip13-84-g3b53e4dbd9f41
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      3b53e4dbd9f41171cf639b3ba0b107f6d6f444ac =



Test Regressions
---------------- =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
jetson-tk1                 | arm   | lab-baylibre  | gcc-10   | tegra_defco=
nfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/62fcca8c3749891971355644

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: tegra_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-84-g3b53e4dbd9f41/arm/tegra_defconfig/gcc-10/lab-baylibre/baseline-j=
etson-tk1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-84-g3b53e4dbd9f41/arm/tegra_defconfig/gcc-10/lab-baylibre/baseline-j=
etson-tk1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62fcca8c3749891971355=
645
        failing since 67 days (last pass: v5.10.109-cip5, first fail: v5.10=
.121-cip9) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-broonie   | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/62fccabf8604220f1335566a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-84-g3b53e4dbd9f41/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_a=
rm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-84-g3b53e4dbd9f41/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_a=
rm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62fccabf8604220f13355=
66b
        failing since 50 days (last pass: v5.10.112-cip6, first fail: v5.10=
.125-cip10) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62fcccedfcf4c5a1da35568e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-84-g3b53e4dbd9f41/arm64/defconfig+arm64-chromebook/gcc-10/lab-brooni=
e/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-84-g3b53e4dbd9f41/arm64/defconfig+arm64-chromebook/gcc-10/lab-brooni=
e/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62fcccedfcf4c5a1da355=
68f
        failing since 67 days (last pass: v5.10.112-cip6, first fail: v5.10=
.121-cip9) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/62fccabe2a39958769355662

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-84-g3b53e4dbd9f41/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_a=
rm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-84-g3b53e4dbd9f41/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_a=
rm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62fccabe2a39958769355=
663
        failing since 50 days (last pass: v5.10.112-cip6, first fail: v5.10=
.125-cip10) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62fccd012b92691ea5355669

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-84-g3b53e4dbd9f41/arm64/defconfig+arm64-chromebook/gcc-10/lab-brooni=
e/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-84-g3b53e4dbd9f41/arm64/defconfig+arm64-chromebook/gcc-10/lab-brooni=
e/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62fccd012b92691ea5355=
66a
        failing since 67 days (last pass: v5.10.112-cip6, first fail: v5.10=
.121-cip9) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/62fccaa98604220f1335565d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-84-g3b53e4dbd9f41/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_a=
rm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-84-g3b53e4dbd9f41/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_a=
rm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62fccaa98604220f13355=
65e
        failing since 50 days (last pass: v5.10.112-cip6, first fail: v5.10=
.125-cip10) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62fcccc57a6b7bdf29355646

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-84-g3b53e4dbd9f41/arm64/defconfig+arm64-chromebook/gcc-10/lab-brooni=
e/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-84-g3b53e4dbd9f41/arm64/defconfig+arm64-chromebook/gcc-10/lab-brooni=
e/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62fcccc57a6b7bdf29355=
647
        failing since 67 days (last pass: v5.10.112-cip6, first fail: v5.10=
.121-cip9) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62fcd2f7f7ba092f9e35564f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-84-g3b53e4dbd9f41/arm64/defconfig+arm64-chromebook/gcc-10/lab-collab=
ora/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-84-g3b53e4dbd9f41/arm64/defconfig+arm64-chromebook/gcc-10/lab-collab=
ora/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62fcd2f8f7ba092f9e355=
650
        failing since 67 days (last pass: v5.10.112-cip6, first fail: v5.10=
.121-cip9) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/62fccabdb59c89097b355668

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-84-g3b53e4dbd9f41/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_a=
rm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-84-g3b53e4dbd9f41/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_a=
rm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62fccabdb59c89097b355=
669
        failing since 50 days (last pass: v5.10.112-cip6, first fail: v5.10=
.125-cip10) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62fcccd9fcf4c5a1da355655

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-84-g3b53e4dbd9f41/arm64/defconfig+arm64-chromebook/gcc-10/lab-brooni=
e/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-84-g3b53e4dbd9f41/arm64/defconfig+arm64-chromebook/gcc-10/lab-brooni=
e/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62fcccd9fcf4c5a1da355=
656
        failing since 67 days (last pass: v5.10.112-cip6, first fail: v5.10=
.121-cip9) =

 =20

