Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6574C46CA0
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 21:14:20 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web10.104270.1701983659097492594
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 07 Dec 2023 13:14:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=z9ItMCuD;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.177, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d0a7b72203so12480655ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 07 Dec 2023 13:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701983658; x=1702588458; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PbMirlC+Nu7g8GkfXYV9YEkgzoe1If3Q9oC1QIAGwRc=;
        b=z9ItMCuDdg/5zQUuIUeh1v9Dg6E5+HoBBv0bZJMHwloIuBl8zHMi6jX/C6F1Oxm3Ko
         0fLBelYqn2ztgJVlZBrEFO3ZdrJPhc5Aly3tsf/ErPUIVY2X5oH8/+KTR41O5yIhw8/Z
         aO7rdQ781StLc03L7s3+Ycp1KvqxdpWJcjt1PW39LmLFpOjZmzoksyVLwPX61CzMXove
         +8eu0jbYbm3aYUT9kuooxZaIuNlPM6lloUwmJ1NBYJXhkBiFxvlBsMlrPPTYEjbABznL
         2cW2A5TFoCsN72XZR0P59OuYK4Y23MS6Kh8wXQJo7H9mn1XDBPcXVjI5iKWHz38q+mu4
         6XSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701983658; x=1702588458;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PbMirlC+Nu7g8GkfXYV9YEkgzoe1If3Q9oC1QIAGwRc=;
        b=v+7QgqoQBlhAd2OpoVhZ318hkjGgBu4Jer9VCXhMXXhIJGgTIGDJAeegB4rfnMDM5C
         YMQqxAuWLVomp+O0+KomaefUSOs6QIYr9KuFu2hcYiq6ZJYlr7eMVvV72dvVcrvBxiE5
         0082yJcctG7Fc9q4GXhGAZNFpFy1bPcYMctf7uDYouv4Y7f0VRbakBXUOOJ/hntNtwB0
         T4x3scbOyGrDpQoTbXfb109io5MXmnRxopZHaNTGehA0hdoHGsuHoBoElUJf2wYkzOb6
         M5ZoQWRCJI4P1wu5+FdDJSbOIDXaHR+RYAq2PG7o3PGnnbKlPjzHTwFG1XeXp8xZBuoR
         fPtQ==
X-Gm-Message-State: AOJu0Yzhmcyi2LBroZFlveYnEnC0xZjSj5/prmY7p5dsSrOCgcKywo5w
	lS9tXcIYLlI8QHa718HuzyhZJKBHlxUelQnBUwcF5A==
X-Google-Smtp-Source: AGHT+IHB6aEFAzWkSA1HB709NqWggcb+KC9o+9/jOVpa21DbR7lUKfntyhWg88JFsowRqxX8P3LyJg==
X-Received: by 2002:a17:902:f68b:b0:1d0:6ffe:9f7 with SMTP id l11-20020a170902f68b00b001d06ffe09f7mr3543618plg.85.1701983657954;
        Thu, 07 Dec 2023 13:14:17 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y65-20020a636444000000b005b18c53d73csm222701pgb.16.2023.12.07.13.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 13:14:17 -0800 (PST)
Message-ID: <657235a9.630a0220.196b5.1515@mx.google.com>
Date: Thu, 07 Dec 2023 13:14:17 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.299-cip105
Subject: cip/linux-4.19.y-cip baseline-cip-nfs: 9 runs,
 6 regressions (v4.19.299-cip105)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 21:14:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13921

cip/linux-4.19.y-cip baseline-cip-nfs: 9 runs, 6 regressions (v4.19.299-cip=
105)

Regressions Summary
-------------------

platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | omap2plus_defco=
nfig        | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =

r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =

r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
            | 1          =

r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =

r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig      =
            | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.299-cip105/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.299-cip105
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      d152f9dce44a3068c74de8c2046a16b8dd3c1544 =



Test Regressions
---------------- =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | omap2plus_defco=
nfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/65722fb9d202f238ece13485

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.299=
-cip105/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-cip-nfs-beagleb=
one-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.299=
-cip105/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-cip-nfs-beagleb=
one-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65722fb9d202f=
238ece13486
        new failure (last pass: v4.19.251-cip77) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65722f7a51f18a1e89e134da

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.299=
-cip105/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-cip-nfs-r8=
a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.299=
-cip105/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-cip-nfs-r8=
a774a1-hihope-rzg2m-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65722f7a51f18=
a1e89e134db
        new failure (last pass: v4.19.256-cip80) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65723079959a43bedfe134a4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.299=
-cip105/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-cip-nfs-r8=
a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.299=
-cip105/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-cip-nfs-r8=
a774b1-hihope-rzg2n-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65723079959a4=
3bedfe134a5
        new failure (last pass: v4.19.256-cip80) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
            | 1          =


  Details:     https://kernelci.org/test/plan/id/657234629471feef84e13491

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.299=
-cip105/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8a774b1-hihope-rzg=
2n-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.299=
-cip105/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8a774b1-hihope-rzg=
2n-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/657234629471f=
eef84e13492
        new failure (last pass: v4.19.256-cip80) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6572302851f3ae3f02e134a9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.299=
-cip105/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-cip-nfs-r8=
a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.299=
-cip105/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-cip-nfs-r8=
a774c0-ek874.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/6572302851f3a=
e3f02e134aa
        new failure (last pass: v4.19.256-cip80) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig      =
            | 1          =


  Details:     https://kernelci.org/test/plan/id/65723464493c5d308de1347a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.299=
-cip105/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.299=
-cip105/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8a774c0-ek874.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65723464493c5=
d308de1347b
        new failure (last pass: v4.19.256-cip80) =

 =20

