Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B67C61D97
	for <webhook@archiver.kernel.org>; Fri, 24 Nov 2023 12:29:47 +0000 (UTC)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
 by mx.groups.io with SMTP id smtpd.web10.134203.1700828981403287685
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 24 Nov 2023 04:29:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=OKz5rJry;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.167.175, mailfrom: bot@kernelci.org)
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3b83398cfc7so1089818b6e.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 24 Nov 2023 04:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700828980; x=1701433780; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0Ys1nOjrNh3QQ+4w9D408hb+3JeqlXCiplFvdQ/wMjc=;
        b=OKz5rJryvrRyBYXfEruxm5xTcfMB8i1+fkvnrZ5Fe4teDSg7gqhoN1TAhglBLHAjRG
         xT+twsVLqiQ6oNR2QXdl0eF69CpVTDITCxwdE1Y18W9WTF6z1T25gc8pITaCXiDEa4Ij
         13PFxSwlsXX/u4uvoiFLj4OZKXeMoWwUA0L3I2ac5YIrQePQEgF6IFxWU1KVA1fviHFT
         tK4ZF622jLMU8ci50dIl2plrH8AItk7/xQ/prhM4h+zHRwewqGFsTnpzFeX281ymbhLR
         9qxZTFRYByYNn621s4zcPeekV8NdkPokjFp06hb8qBGPVg/QSG1lhILyWG7lQnSobvhm
         OYFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700828980; x=1701433780;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Ys1nOjrNh3QQ+4w9D408hb+3JeqlXCiplFvdQ/wMjc=;
        b=m5tB7RJsvyiAgapc4XYx1//97dlE8fk5I+ucl8lkSBR0hl46zh/emhFyWe5e0fO2jh
         IIq2p19C6uTOXgV7k390KpN5RdzAjEep7mj/0o6mQ9e/EDuSzYZJoU1tp6zLlktjmzhK
         CuXitcs76G1rD8NkKTkCKLipJvm+XhUO6oQcugD6xi8ACMd849vY4g7nbEzFJh8IAUtc
         0n3LQtyMlFgFJ4Gd+yYodE0cuTHyyQWqMgmaFYBmvYplQ6rPHZitW1gINZjW4zgwElBH
         flTE0V26Zv/Z1FMnnYqCuzLcEEAb3nUPeYMLagk12Y46MWOf6jinfrQjVf6Xu0iZ6C8v
         B1+w==
X-Gm-Message-State: AOJu0YxOeCujb2hca+WTthYjbUHA36/8qqwh0okv7we5vomaefqhXazA
	zGRc3B50RBYXb8jD5ALzK49MHagDJOiZLkGfF34=
X-Google-Smtp-Source: AGHT+IET2GLtV+Qh9xGxalAJTcQyjQXJi8pmsZ+ZaMbYOCElQZ81yYdV10s1HLvXixgFxUQjDWvRRA==
X-Received: by 2002:a05:6808:3024:b0:3ae:3bd:d3d2 with SMTP id ay36-20020a056808302400b003ae03bdd3d2mr2794520oib.10.1700828980065;
        Fri, 24 Nov 2023 04:29:40 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c13-20020a631c4d000000b0058988954686sm2949098pgm.90.2023.11.24.04.29.39
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 04:29:39 -0800 (PST)
Message-ID: <65609733.630a0220.1ac29.6e4a@mx.google.com>
Date: Fri, 24 Nov 2023 04:29:39 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v6.1.62-cip9-12-g3a5321f469b07
Subject: cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 10 runs,
 7 regressions (v6.1.62-cip9-12-g3a5321f469b07)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Nov 2023 12:29:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13739

cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 10 runs, 7 regressions (v6=
.1.62-cip9-12-g3a5321f469b07)

Regressions Summary
-------------------

platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | multi_v7_defcon=
fig         | 1          =

beaglebone-black         | arm   | lab-broonie | gcc-10   | omap2plus_defco=
nfig        | 1          =

beaglebone-black         | arm   | lab-cip     | gcc-10   | omap2plus_defco=
nfig        | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
            | 1          =

r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =

r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig      =
            | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.62-cip9-12-g3a5321f469b07/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.62-cip9-12-g3a5321f469b07
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      3a5321f469b07e6124d325d7faaa2f8f1993f67c =



Test Regressions
---------------- =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | multi_v7_defcon=
fig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65608fc95eb2a5c0417e4a82

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-12-g3a5321f469b07/arm/multi_v7_defconfig/gcc-10/lab-broonie/b=
aseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-12-g3a5321f469b07/arm/multi_v7_defconfig/gcc-10/lab-broonie/b=
aseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65608fc95eb2a=
5c0417e4a83
        failing since 431 days (last pass: v4.4-st20-229-gb433f12afe250, fi=
rst fail: v4.4-st20-231-g7349cef09ddd2) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | omap2plus_defco=
nfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/65608ddf5b7f5c21a67e4a7b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-12-g3a5321f469b07/arm/omap2plus_defconfig/gcc-10/lab-broonie/=
baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-12-g3a5321f469b07/arm/omap2plus_defconfig/gcc-10/lab-broonie/=
baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65608ddf5b7f5=
c21a67e4a7c
        failing since 4 days (last pass: v4.4-st20-231-g7349cef09ddd2, firs=
t fail: v5.10.200-cip40-513-g195b5d2b5c744) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
beaglebone-black         | arm   | lab-cip     | gcc-10   | omap2plus_defco=
nfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/65608fc45eb2a5c0417e4a7b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-12-g3a5321f469b07/arm/omap2plus_defconfig/gcc-10/lab-cip/base=
line-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-12-g3a5321f469b07/arm/omap2plus_defconfig/gcc-10/lab-cip/base=
line-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65608fc45eb2a=
5c0417e4a7c
        failing since 4 days (last pass: v4.4-st20-231-g7349cef09ddd2, firs=
t fail: v5.10.200-cip40-513-g195b5d2b5c744) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65608d3a70050505a27e4b2c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-12-g3a5321f469b07/arm64/defconfig+arm64-chromebook/gcc-10/lab=
-cip/baseline-cip-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-12-g3a5321f469b07/arm64/defconfig+arm64-chromebook/gcc-10/lab=
-cip/baseline-cip-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65608d3a70050=
505a27e4b2d
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
            | 1          =


  Details:     https://kernelci.org/test/plan/id/65609227accbdf9c867e4a71

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-12-g3a5321f469b07/arm64/defconfig/gcc-10/lab-cip/baseline-cip=
-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-12-g3a5321f469b07/arm64/defconfig/gcc-10/lab-cip/baseline-cip=
-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65609227accbd=
f9c867e4a72
        failing since 444 days (last pass: v5.10.131-cip13-84-g5fcbe4a63ab4=
d, first fail: v5.10.138-cip15-10-g52cbd8ad1543e) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65608e222aeba3b9837e4a94

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-12-g3a5321f469b07/arm64/defconfig+arm64-chromebook/gcc-10/lab=
-cip/baseline-cip-nfs-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-12-g3a5321f469b07/arm64/defconfig+arm64-chromebook/gcc-10/lab=
-cip/baseline-cip-nfs-r8a774c0-ek874.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65608e222aeba=
3b9837e4a95
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v6.1.62-cip9-13-g34c303883a305) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig      =
            | 1          =


  Details:     https://kernelci.org/test/plan/id/656091e36beb899f047e4ac7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-12-g3a5321f469b07/arm64/defconfig/gcc-10/lab-cip/baseline-cip=
-nfs-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-12-g3a5321f469b07/arm64/defconfig/gcc-10/lab-cip/baseline-cip=
-nfs-r8a774c0-ek874.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/656091e36beb8=
99f047e4ac8
        failing since 4 days (last pass: v5.10.138-cip15-10-g52cbd8ad1543e,=
 first fail: v5.10.200-cip40-513-g195b5d2b5c744) =

 =20

