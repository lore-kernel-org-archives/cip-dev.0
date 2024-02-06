Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6A2C48297
	for <webhook@archiver.kernel.org>; Tue,  6 Feb 2024 23:11:07 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web10.7921.1707261066438705038
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 06 Feb 2024 15:11:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=2fqgRNmu;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.172, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d7393de183so523615ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 06 Feb 2024 15:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707261065; x=1707865865; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7JQ3DJ0x2aTZSadQp7YyJuqMOCBLMoiIeWm6QCgIdbM=;
        b=2fqgRNmuZezKa0lwRVbWC1IAMb8ab4wrIrWkAkhNrXoDNB8VFlfqAAXuFeqL3BXfHp
         r+QwN8kqubPXlqh9js5d84T9L62d1pCGLORaMfgo0ENzmHuKl/1UZZEX11TZeeD3IX6F
         CJ0/9bEyHfxJn7TjFBnj/DTsVC3X/aux8KK+IdKiKOfHY8RIMEEnYezC10gKGCS87hzU
         Bklvkokq31pIhwu//5/1bGw60jazt/xxBOejcStxICC8sHdciTBPwDCHuw4U7b2v4H6G
         yNaIBZt2TiGlT98azskJS5Lg4RuqeA14ah8Ye/7ejeQanB2xoSXt+caLU61ulrjDTpJQ
         aPvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707261065; x=1707865865;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7JQ3DJ0x2aTZSadQp7YyJuqMOCBLMoiIeWm6QCgIdbM=;
        b=uNBpRPhv3YI6zx3b0jCbXCu0xhXdIWL/ewWPZn4UKztC1N250ysr8gou3/L5DD93qP
         wGzgJmoq6giCC5WfG/BkxXoRoArVn5AalNvc1Y3r8X3OTu+PqqEMJJn3IrI94wirhPr2
         AsdjpD9w22QRNPcFc/DIe6KQNmVcAwn09xyFo5z7MEiObwljrwx+a24tQIHYlma92WWS
         jZz9msORSTD9BLJ0Ceyu1OQgPPhRQImYkAdvqUYoThyX172mUiXvjiiYHl01dMRO8cMR
         Hw2CZmKzJhQoWdD8K9c7qiQDgU+IMJyOYFLGJ03op21pqJ8qqBnwJssRNVgHYh+ugj6T
         2qyw==
X-Gm-Message-State: AOJu0Yw3wDvQKOaRFNCkERq5VqmYBMPxx2mCo5ptufCf7pcEsYOWAJNi
	mm40Jf4dBMK/Sk3kSWzqaRYsy73RAgZtgaxYhbPmDp4CJITuf2c9RpkPpb8dUnQ722HIMi/14t7
	L
X-Google-Smtp-Source: AGHT+IEBptJRb5U2lkUpSSAJ2da2dSTCfj6+cCF6yOs1kEbUkWsVWnENTJBemPGIE+zKL2j5r21cHQ==
X-Received: by 2002:a17:902:ce86:b0:1d9:65e6:4acc with SMTP id f6-20020a170902ce8600b001d965e64accmr3487020plg.42.1707261064680;
        Tue, 06 Feb 2024 15:11:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV2jsYQOXpQDdKCbAMILyXm8+1HYuGcw/cxKZzHesx3MvI1vEo2Gnx4C+quvT03vh0knmEl67YLJvZVlj3oyx3HKawpsT5PZuhKNsxfRXgulmaYh/0joQEJfhN6ab8GFA0Mbe6aqqGZ9zBkw2WpvZXkYQ==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id k11-20020a170902f28b00b001d94c54b3bcsm55609plc.264.2024.02.06.15.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 15:11:04 -0800 (PST)
Message-ID: <65c2bc88.170a0220.e806c.038b@mx.google.com>
Date: Tue, 06 Feb 2024 15:11:04 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.304-cip106-2-g5723c66be3b0
Subject: cip/linux-4.19.y-cip baseline-cip-nfs: 12 runs,
 10 regressions (v4.19.304-cip106-2-g5723c66be3b0)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Feb 2024 23:11:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14840

cip/linux-4.19.y-cip baseline-cip-nfs: 12 runs, 10 regressions (v4.19.304-c=
ip106-2-g5723c66be3b0)

Regressions Summary
-------------------

platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | multi_v7_defcon=
fig         | 1          =

beaglebone-black         | arm   | lab-cip     | gcc-10   | multi_v7_defcon=
fig         | 1          =

beaglebone-black         | arm   | lab-broonie | gcc-10   | omap2plus_defco=
nfig        | 1          =

beaglebone-black         | arm   | lab-cip     | gcc-10   | omap2plus_defco=
nfig        | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
            | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =

r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
            | 1          =

r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =

r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig      =
            | 1          =

r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.304-cip106-2-g5723c66be3b0/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.304-cip106-2-g5723c66be3b0
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      5723c66be3b09629fae4fec9711e11f0d020e81a =



Test Regressions
---------------- =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | multi_v7_defcon=
fig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2b5874e68427c3e8e1e81

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106-2-g5723c66be3b0/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-=
cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106-2-g5723c66be3b0/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-=
cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65c2b5874e684=
27c3e8e1e82
        failing since 61 days (last pass: v4.19.256-cip80, first fail: v4.1=
9.299-cip105) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
beaglebone-black         | arm   | lab-cip     | gcc-10   | multi_v7_defcon=
fig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2b93e3308a83ac28e1eaa

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106-2-g5723c66be3b0/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-cip-=
nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106-2-g5723c66be3b0/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-cip-=
nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65c2b93e3308a=
83ac28e1eab
        failing since 61 days (last pass: v4.19.256-cip80, first fail: v4.1=
9.299-cip105) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | omap2plus_defco=
nfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2b52fff64e544538e1e7a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106-2-g5723c66be3b0/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline=
-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106-2-g5723c66be3b0/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline=
-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65c2b52fff64e=
544538e1e7b
        failing since 61 days (last pass: v4.19.251-cip77, first fail: v4.1=
9.299-cip105) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
beaglebone-black         | arm   | lab-cip     | gcc-10   | omap2plus_defco=
nfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2b7360d7556a2238e1e87

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106-2-g5723c66be3b0/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-cip=
-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106-2-g5723c66be3b0/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-cip=
-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65c2b7360d755=
6a2238e1e88
        failing since 61 days (last pass: v4.19.251-cip77, first fail: v4.1=
9.299-cip105) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
            | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2b5adb4377e44608e1e7a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106-2-g5723c66be3b0/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8a=
774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106-2-g5723c66be3b0/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8a=
774a1-hihope-rzg2m-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65c2b5adb4377=
e44608e1e7b
        failing since 61 days (last pass: v4.19.256-cip80, first fail: v4.1=
9.299-cip105) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2b7f2cef7cd39a88e1e82

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106-2-g5723c66be3b0/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/bas=
eline-cip-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106-2-g5723c66be3b0/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/bas=
eline-cip-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65c2b7f2cef7c=
d39a88e1e83
        failing since 61 days (last pass: v4.19.256-cip80, first fail: v4.1=
9.299-cip105) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
            | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2b5914e68427c3e8e1ed1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106-2-g5723c66be3b0/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8a=
774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106-2-g5723c66be3b0/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8a=
774b1-hihope-rzg2n-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65c2b5914e684=
27c3e8e1ed2
        failing since 61 days (last pass: v4.19.256-cip80, first fail: v4.1=
9.299-cip105) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2b8ed28b88fe9278e208a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106-2-g5723c66be3b0/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/bas=
eline-cip-nfs-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106-2-g5723c66be3b0/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/bas=
eline-cip-nfs-r8a774b1-hihope-rzg2n-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65c2b8ed28b88=
fe9278e208b
        failing since 61 days (last pass: v4.19.256-cip80, first fail: v4.1=
9.299-cip105) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig      =
            | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2b60936be8342a88e1e95

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106-2-g5723c66be3b0/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8a=
774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106-2-g5723c66be3b0/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8a=
774c0-ek874.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65c2b60936be8=
342a88e1e96
        failing since 61 days (last pass: v4.19.256-cip80, first fail: v4.1=
9.299-cip105) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2b9652ab4b100b38e1e9a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106-2-g5723c66be3b0/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/bas=
eline-cip-nfs-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106-2-g5723c66be3b0/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/bas=
eline-cip-nfs-r8a774c0-ek874.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65c2b9652ab4b=
100b38e1e9b
        failing since 61 days (last pass: v4.19.256-cip80, first fail: v4.1=
9.299-cip105) =

 =20

