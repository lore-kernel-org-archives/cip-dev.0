Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C22C54798
	for <webhook@archiver.kernel.org>; Fri, 23 Feb 2024 12:22:27 +0000 (UTC)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
 by mx.groups.io with SMTP id smtpd.web11.9293.1708690944186335329
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 23 Feb 2024 04:22:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=j4nU8fFA;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.41, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-299354e5f01so174810a91.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 23 Feb 2024 04:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1708690943; x=1709295743; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PKWTufcsstg0OrdoAiNmcY7WphxDl4MDSq0Xhi4gSjE=;
        b=j4nU8fFA98eYco15dOU9SrDFGDnNhPd02it9+t6WOiaJyGJJi1SKHAMhX5bagEh13f
         D16GWbGNQX6yyrvMXtJv7YuIElJdxUfGRuDU43lgybtroAqxfUo2h76+tsEMlpcdocqp
         zu+ee4eTAYdfFC0Gb6GRupugF3MZ9Vjp+MRG/JfbttljCTuRvr6hgx3khIfhYrClrWYn
         RS+mkNnfCTsQKqJkyp1xZ+av2upbDAdJXpmXwlmMP5q10JwIyqciB0w4WScjBMtEgqte
         9GUm2vEaQNWQNBeZqhi0VTYTqfOnhMT8UngSPwBUZgmfEHoWrcIoviJ8iL/0npZ1rh7T
         GK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708690943; x=1709295743;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PKWTufcsstg0OrdoAiNmcY7WphxDl4MDSq0Xhi4gSjE=;
        b=D6T0UskJat3fTYByYROEYhKDSFGFinpc4tYeZ/AQfibgYBJ9j4X48DjQ/YQ7Gf/Su2
         5Dqg1GS30E4D0XWGkiVwlELxVxjzgCljXnqbMIEJ96JJoV0owbHUmIbkjJQm/G6dB0Zi
         YTXoKRIFsNx+IaiEizJr4brrtNoh6BxnVrXHTFG6YEAmC0niD0T9i9YHM9vop1lk32Ew
         WKZ5jLZ79o9jCMNDfF6EsfP0TGl1rC6Bf0Qj1P4HN+9TqeSpTeGmVhw7XUAi8uUpbyxI
         WoPsv8ltQlv3T7/urKlXvDNoO7ZL8SHOI4R2DQOy/4K8G5TkWjru2b1betrp4eCIRh0R
         MEQg==
X-Gm-Message-State: AOJu0YxRi0YJxGR89pQyE67G2fTX2hzFcxsWqJ1/arghNjwhF2mVHetK
	DsftvScrxux7n2Pbuo6Ie5H3KN6hCJF+mVfU+QjwVOnzjgTPdPF7Dk2HSt/UOaIzfPpHwt/dgPS
	Bl1M=
X-Google-Smtp-Source: AGHT+IFOOstwzh42s786kesg/DfMDArHsX8Oj15XCusMzFJjYJsstnsqQ21ZxnU3vnvVU3DTdDnyxg==
X-Received: by 2002:a17:90a:970a:b0:299:88b6:7d93 with SMTP id x10-20020a17090a970a00b0029988b67d93mr7530542pjo.17.1708690942805;
        Fri, 23 Feb 2024 04:22:22 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u3-20020a17090ac88300b0029a4db713b9sm1307851pjt.39.2024.02.23.04.22.22
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 04:22:22 -0800 (PST)
Message-ID: <65d88dfe.170a0220.c8d70.32ee@mx.google.com>
Date: Fri, 23 Feb 2024 04:22:22 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Kernel: v4.19.306-cip107-201-gc2afc54e2d6bb
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-cip-nfs: 9 runs,
 7 regressions (v4.19.306-cip107-201-gc2afc54e2d6bb)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 23 Feb 2024 12:22:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15078

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-cip-nfs: 9 runs, 7 regr=
essions (v4.19.306-cip107-201-gc2afc54e2d6bb)

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

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =

r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =

r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.306-cip107-201-gc2afc54e2d6bb/plan/baseli=
ne-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.306-cip107-201-gc2afc54e2d6bb
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c2afc54e2d6bb0bb2a9214444545a17298928975 =



Test Regressions
---------------- =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | multi_v7_defcon=
fig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65d87b4d82b9e908a963701e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.306-cip107-201-gc2afc54e2d6bb/arm/multi_v7_defconfig/gcc=
-10/lab-broonie/baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.306-cip107-201-gc2afc54e2d6bb/arm/multi_v7_defconfig/gcc=
-10/lab-broonie/baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65d87b4d82b9e=
908a963701f
        failing since 106 days (last pass: v4.19.252-cip78-113-gb7034e0f773=
f8, first fail: v4.19.297-cip104-63-ge7301d2e196ae) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
beaglebone-black         | arm   | lab-cip     | gcc-10   | multi_v7_defcon=
fig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65d87b6b82b9e908a963702b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.306-cip107-201-gc2afc54e2d6bb/arm/multi_v7_defconfig/gcc=
-10/lab-cip/baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.306-cip107-201-gc2afc54e2d6bb/arm/multi_v7_defconfig/gcc=
-10/lab-cip/baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65d87b6b82b9e=
908a963702c
        failing since 106 days (last pass: v4.19.252-cip78-113-gb7034e0f773=
f8, first fail: v4.19.297-cip104-63-ge7301d2e196ae) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | omap2plus_defco=
nfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/65d87fea094adb5a3763705f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.306-cip107-201-gc2afc54e2d6bb/arm/omap2plus_defconfig/gc=
c-10/lab-broonie/baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.306-cip107-201-gc2afc54e2d6bb/arm/omap2plus_defconfig/gc=
c-10/lab-broonie/baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65d87fea094ad=
b5a37637060
        failing since 560 days (last pass: v4.19.252-cip78-113-gb7034e0f773=
f8, first fail: v4.19.252-cip78-146-g6acc38498265c) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
beaglebone-black         | arm   | lab-cip     | gcc-10   | omap2plus_defco=
nfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/65d881cbd57de9666d63701e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.306-cip107-201-gc2afc54e2d6bb/arm/omap2plus_defconfig/gc=
c-10/lab-cip/baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.306-cip107-201-gc2afc54e2d6bb/arm/omap2plus_defconfig/gc=
c-10/lab-cip/baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65d881cbd57de=
9666d63701f
        failing since 560 days (last pass: v4.19.252-cip78-113-gb7034e0f773=
f8, first fail: v4.19.252-cip78-146-g6acc38498265c) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65d885770515532995637024

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.306-cip107-201-gc2afc54e2d6bb/arm64/defconfig+arm64-chro=
mebook/gcc-10/lab-cip/baseline-cip-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.306-cip107-201-gc2afc54e2d6bb/arm64/defconfig+arm64-chro=
mebook/gcc-10/lab-cip/baseline-cip-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65d8857705155=
32995637025
        failing since 106 days (last pass: v4.19.252-cip78-146-g6acc3849826=
5c, first fail: v4.19.297-cip104-63-ge7301d2e196ae) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65d885ef258dec4001637018

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.306-cip107-201-gc2afc54e2d6bb/arm64/defconfig+arm64-chro=
mebook/gcc-10/lab-cip/baseline-cip-nfs-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.306-cip107-201-gc2afc54e2d6bb/arm64/defconfig+arm64-chro=
mebook/gcc-10/lab-cip/baseline-cip-nfs-r8a774b1-hihope-rzg2n-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65d885ef258de=
c4001637019
        failing since 106 days (last pass: v4.19.252-cip78-146-g6acc3849826=
5c, first fail: v4.19.297-cip104-63-ge7301d2e196ae) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65d88577755e0a1159637020

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.306-cip107-201-gc2afc54e2d6bb/arm64/defconfig+arm64-chro=
mebook/gcc-10/lab-cip/baseline-cip-nfs-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.306-cip107-201-gc2afc54e2d6bb/arm64/defconfig+arm64-chro=
mebook/gcc-10/lab-cip/baseline-cip-nfs-r8a774c0-ek874.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65d88577755e0=
a1159637021
        failing since 106 days (last pass: v4.19.252-cip78-146-g6acc3849826=
5c, first fail: v4.19.297-cip104-63-ge7301d2e196ae) =

 =20

