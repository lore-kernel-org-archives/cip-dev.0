Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD1FC4707B
	for <webhook@archiver.kernel.org>; Sat, 13 Jan 2024 10:43:00 +0000 (UTC)
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
 by mx.groups.io with SMTP id smtpd.web10.16777.1705142576729079626
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 13 Jan 2024 02:42:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=xe9oQfhi;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.161.51, mailfrom: bot@kernelci.org)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5955a4a9b23so3884127eaf.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 13 Jan 2024 02:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1705142575; x=1705747375; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/aamiaaGdmT+PtbHKopY7kQJdkDcWaSKBZuzGZ4b4tQ=;
        b=xe9oQfhi+oGLczlNP/33S7cajeJgyi5SATH2tfPES9jI9wrOlN0bBYDaOO4laUHM3X
         h4MAyyG47lZebWw+7MhHOHsztuiz+M7cLeUxVP7HLK2f2siPs2l5Ahd8BNxg9zMO7LB7
         ZbzsVaS+M7LwQp6KSQ6cYNu+wTebdV/gl3qY6keSd/srzwamHJ8CQ2+BCUUbgX/PgIuT
         Ia+7cmctg5X9IIAL9FFRjyH8oPjzTdxXTP9gCjeUqpWqeXLZkAQUN5DE4us7VTygRC7X
         AumWw0tUjzUxxwICN5xY+3pW4PPbN46k3xuKyoz/T+OOcqPKA84DHnltoSfAfE/bEfOQ
         xwIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705142575; x=1705747375;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/aamiaaGdmT+PtbHKopY7kQJdkDcWaSKBZuzGZ4b4tQ=;
        b=WAAcEN7pzfGC0U8FLXSEBk+2doj2KmQLEZS6Ka1dV5M8aDKkFMa0hE9Q6E+N8yNxi6
         2J3AC+WiEqfc91T95t+Cm6EJ4f70C6RDJ8i/Ulclnw/iWBt65fTF4gzxw54yWhQyrsfN
         VhynvFYfwP/WSlaMF9wS01Ep+aghgvkLae68RLn7vkqaM3M2Aa7rlF9pCymWFvU/zewB
         Ltlw0ERF/16ZvPbORV0Veqd/wvlhU1SAd0sHzv+WKneSy5Z6XjonyoECUFryo7YE2jxy
         U0GnyO7ZVgEW5s2n1VcYzt2NvSe6bcp5UjYRGGvmVyMCech5Hriec3KHk5ArPtWv19Lg
         uGHw==
X-Gm-Message-State: AOJu0Yx0hhYBQ+tuEufFc2g1oNsa87hwmxgX9+K4WMFvQxfBJvQth+hH
	4JYkViffoRPDSqSHDJeStr5jp3j4YP8Rnm+JbnnMyF00jjM=
X-Google-Smtp-Source: AGHT+IGWPprr+nW9V90CGmSf54GqlzL4q9gyVf3uh7/Uqjv6BJCGOQHiiuhojJrHIvM0LzeWVI3wDg==
X-Received: by 2002:a05:6358:4694:b0:175:a5d9:63fd with SMTP id w20-20020a056358469400b00175a5d963fdmr3136473rwl.35.1705142575112;
        Sat, 13 Jan 2024 02:42:55 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a22-20020a17090abe1600b0028cda1c68b9sm7951459pjs.19.2024.01.13.02.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jan 2024 02:42:53 -0800 (PST)
Message-ID: <65a2692d.170a0220.949c4.ccc5@mx.google.com>
Date: Sat, 13 Jan 2024 02:42:53 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.19.304-cip106
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip baseline-cip-nfs: 9 runs,
 6 regressions (v4.19.304-cip106)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 13 Jan 2024 10:43:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14371

cip/linux-4.19.y-cip baseline-cip-nfs: 9 runs, 6 regressions (v4.19.304-cip=
106)

Regressions Summary
-------------------

platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | omap2plus_defco=
nfig        | 1          =

beaglebone-black         | arm   | lab-cip     | gcc-10   | omap2plus_defco=
nfig        | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
            | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =

r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig      =
            | 1          =

r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.304-cip106/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.304-cip106
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      6617f4528449a329abd3b2dab36052b341610d99 =



Test Regressions
---------------- =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | omap2plus_defco=
nfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/65a261587108854e5e52a41e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-cip-nfs-beagleb=
one-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-cip-nfs-beagleb=
one-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65a2615871088=
54e5e52a41f
        failing since 36 days (last pass: v4.19.251-cip77, first fail: v4.1=
9.299-cip105) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
beaglebone-black         | arm   | lab-cip     | gcc-10   | omap2plus_defco=
nfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/65a262347d0512b32852a40c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-cip-nfs-beaglebone-=
black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-cip-nfs-beaglebone-=
black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65a262347d051=
2b32852a40d
        failing since 36 days (last pass: v4.19.251-cip77, first fail: v4.1=
9.299-cip105) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
            | 1          =


  Details:     https://kernelci.org/test/plan/id/65a2626fd8064e6e9652a469

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8a774a1-hihope-rzg=
2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8a774a1-hihope-rzg=
2m-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65a2626fd8064=
e6e9652a46a
        failing since 36 days (last pass: v4.19.256-cip80, first fail: v4.1=
9.299-cip105) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65a263daee4adfbaa952a4df

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-cip-nfs-r8=
a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-cip-nfs-r8=
a774a1-hihope-rzg2m-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65a263daee4ad=
fbaa952a4e0
        failing since 36 days (last pass: v4.19.256-cip80, first fail: v4.1=
9.299-cip105) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig      =
            | 1          =


  Details:     https://kernelci.org/test/plan/id/65a262a6c5d083c66152a411

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8a774c0-ek874.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65a262a6c5d08=
3c66152a412
        failing since 36 days (last pass: v4.19.256-cip80, first fail: v4.1=
9.299-cip105) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65a2653a1f09ccbccb52a3fd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-cip-nfs-r8=
a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-cip-nfs-r8=
a774c0-ek874.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65a2653a1f09c=
cbccb52a3fe
        failing since 36 days (last pass: v4.19.256-cip80, first fail: v4.1=
9.299-cip105) =

 =20

