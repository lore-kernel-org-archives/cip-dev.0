Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F5DC4167B
	for <webhook@archiver.kernel.org>; Mon, 11 Dec 2023 10:22:52 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web11.5367.1702290164293658555
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 11 Dec 2023 02:22:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=VX+NdFMs;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.177, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d0897e99e0so23578585ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 11 Dec 2023 02:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702290163; x=1702894963; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8MUvEgLRA/R9ON2ARWV67JsxRzKrCiSVYrfX2MC6fr8=;
        b=VX+NdFMs8TGvH6X+XdTconw84EepvS5uHesph1Y4XwqGy1S0/2j2XwDHBlZXBHU7E2
         mVQC62ZgDCRAgupIoCvzAJceYoqzKPFqd1n3WM30KJ1m0QSaGw9yJQJgj9nN8kxyxR0n
         OZ3qsWUbZQ53JUHHV0Wv1eAG8sxGZoD8FZxgDsNKj+OpKPHnxp/cf/bEsjNh4o541Z/f
         zDMZK/WiyGVeyAnlrVJtzskIkV3zJkXWS4xFTFGLalRrEf4PiPVx8juSjiDSVBs9eIlu
         7/6hahmfnq4pTTUS0a10E6BQ44Od1MO5igsFrXDFXGOFTw4PI8jo8+iht1hun0r5ko/R
         YQJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702290163; x=1702894963;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8MUvEgLRA/R9ON2ARWV67JsxRzKrCiSVYrfX2MC6fr8=;
        b=NCO+XOUdrc1YE1p4K+vVqD9nNngjcJuQ96Pk9VkPHauqJqyi/WhOPo4zyB/wUDNt6z
         CItJI/evwtLUYWh1uyh0vBC3XfCMSa+VR8Gs5biwHou7lOWxfO6omXCZaOwMHxza7hRq
         6b6phXKRn9Ix/hMr91n4mYXBGtFpG18IF0ClO6YFWcJCWL9gNXSbYN/81dg/JcSTADs5
         5obqMGO1pmR3CDHN2tMN80SUzotIqrx4RFVVSaxwkZ1OOiZB5sQKSixtX2yQkTdNpsqm
         /KdPHBh213GswWUdf1lW0FeFGzqbNxlgQgQO8ntuPQgSKiJXyIBcBUGhy4hRS/2VEGW+
         TKHQ==
X-Gm-Message-State: AOJu0YysfdHuM13pJ0NbV1j28hFLU0SqRmIu2Nt4tpas+AaYw/TnCDmJ
	FFN84Mh4RtKZV6Beq9pHN4non0JPfINnDkNl3pidNw==
X-Google-Smtp-Source: AGHT+IEg4CxWHdow5T25X1yKtstKWLQ5xZ3BXm6DYp6hDK34NUmp2JiRM60+mxz8TAnpxMGVDuIC5A==
X-Received: by 2002:a17:902:d58e:b0:1d3:141:cb0f with SMTP id k14-20020a170902d58e00b001d30141cb0fmr676262plh.28.1702290163309;
        Mon, 11 Dec 2023 02:22:43 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id bi1-20020a170902bf0100b001cf594f71f3sm6233974plb.157.2023.12.11.02.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 02:22:42 -0800 (PST)
Message-ID: <6576e2f2.170a0220.b00c0.0b09@mx.google.com>
Date: Mon, 11 Dec 2023 02:22:42 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-63-gfdfe1fbf93bc6
Subject: cip/linux-5.10.y-cip baseline-cip-nfs: 6 runs,
 4 regressions (v5.10.201-cip41-63-gfdfe1fbf93bc6)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Dec 2023 10:22:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14005

cip/linux-5.10.y-cip baseline-cip-nfs: 6 runs, 4 regressions (v5.10.201-cip=
41-63-gfdfe1fbf93bc6)

Regressions Summary
-------------------

platform                 | arch  | lab         | compiler | defconfig      =
     | regressions
-------------------------+-------+-------------+----------+----------------=
-----+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | multi_v7_defcon=
fig  | 1          =

beaglebone-black         | arm   | lab-broonie | gcc-10   | omap2plus_defco=
nfig | 1          =

beaglebone-black         | arm   | lab-cip     | gcc-10   | omap2plus_defco=
nfig | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
     | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-63-gfdfe1fbf93bc6/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-63-gfdfe1fbf93bc6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      fdfe1fbf93bc6fe6ed2708f11c2613bef556fdeb =



Test Regressions
---------------- =



platform                 | arch  | lab         | compiler | defconfig      =
     | regressions
-------------------------+-------+-------------+----------+----------------=
-----+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | multi_v7_defcon=
fig  | 1          =


  Details:     https://kernelci.org/test/plan/id/6576dc83a63f106809e134b1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline=
-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline=
-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/6576dc83a63f1=
06809e134b2
        failing since 31 days (last pass: v5.10.131-cip13-37-ge3a52725ce96,=
 first fail: v5.10.200-cip40) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
     | regressions
-------------------------+-------+-------------+----------+----------------=
-----+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | omap2plus_defco=
nfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6576dc13d57e4f9b95e13476

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm/omap2plus_defconfig/gcc-10/lab-broonie/baselin=
e-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm/omap2plus_defconfig/gcc-10/lab-broonie/baselin=
e-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/6576dc13d57e4=
f9b95e13477
        failing since 31 days (last pass: v5.10.131-cip13-38-ga8671b4cc3c74=
, first fail: v5.10.200-cip40) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
     | regressions
-------------------------+-------+-------------+----------+----------------=
-----+------------
beaglebone-black         | arm   | lab-cip     | gcc-10   | omap2plus_defco=
nfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6576dfc1584c0dc745e1347b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-ci=
p-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-ci=
p-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/6576dfc1584c0=
dc745e1347c
        failing since 31 days (last pass: v5.10.131-cip13-38-ga8671b4cc3c74=
, first fail: v5.10.200-cip40) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
     | regressions
-------------------------+-------+-------------+----------+----------------=
-----+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
     | 1          =


  Details:     https://kernelci.org/test/plan/id/6576dc2c9861e6aa2ce13475

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8=
a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8=
a774a1-hihope-rzg2m-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/6576dc2c9861e=
6aa2ce13476
        failing since 31 days (last pass: v5.10.138-cip15, first fail: v5.1=
0.200-cip40) =

 =20

