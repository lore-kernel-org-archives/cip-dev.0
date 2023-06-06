Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF58C7EE32
	for <webhook@archiver.kernel.org>; Tue,  6 Jun 2023 13:14:21 +0000 (UTC)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
 by mx.groups.io with SMTP id smtpd.web11.8568.1686057257384241106
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 06 Jun 2023 06:14:17 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=Co0O2eIP;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.179, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-53f8da65701so3152951a12.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 06 Jun 2023 06:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686057256; x=1688649256;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EtOfT/nt/H2Ius+Lqg/6k//rhigzdhxVeItVMQn/738=;
        b=Co0O2eIPf+Dp9qcitNCjqRSxE3ddZJ4vMOh+dD8glUD9BXTvFolJL293ia6JxmoAtx
         7cFsgR4GUSyPTwcdNk/7g/Q5k5tgU6bAyBvcElB1SbR1Gk23Dk/zk95fbcsxjbNea6ot
         Dw32TibRS7WpksYonITlo2WedKYotrTvoUoNSc+NOshFReyTMhCHkOapaL6BORvFsV1y
         X1+zRvcMb6El5v9DdqG5mjiV+Mtig+H17EwbFhsFYhbLA/ynw78dtvd9nEIEF5MRAjGK
         8gYqzG/UxXeOkPj+v3Og/DcKN8v+JLefy2l2O4iNpX0ywHcEQOIVM+SWJpuWEz7AsH/5
         Gtmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686057256; x=1688649256;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EtOfT/nt/H2Ius+Lqg/6k//rhigzdhxVeItVMQn/738=;
        b=BVcWP/A6gy5w/lU+Kev47Of+voc3cAkiwRH+nkBqI2ShdAXft0AMfoLgLjoT+7cj8k
         w/DEigiVyvJA3PNUk6B/8nZOH228Kf4cbfGjiJ8JCVJ3hWXtToxmN7VAKDdaDquHiVo6
         BhyZ8BDvc1ZNhs8ygDMD1GwHvQIf1ozQ27c8C7kZSNQeauYQ/ma0HQmnOQfnyHfaKbty
         KzxpTuSLlvWo/2stn2jYKMf6AelwIFG40ue2HwJHkuptlZQipnqZWAq+293FtGadB0I2
         +fd4kNPp5SA1COr+nNCSyKwwPGYMjYYO6GGPbfiPbhQzZQ5lfFWSEe1aCBYx8mat8aHy
         0YjA==
X-Gm-Message-State: AC+VfDynVFLQBNnItPgniUXSdIPPJvVLdHEhETgy1R1unK9uBckQoUVP
	fE9hbkK/cophLDVzxUCvmcgLfbs6EMHKt4Z3xeytMQ==
X-Google-Smtp-Source: ACHHUZ54IvmedC0MlS8dLoaZ8VlaWB2XrLYfmUQTM+UvuAfxKNu+9mZ1Bb4OVz1ZaJZvHpUssBEzUw==
X-Received: by 2002:a17:902:ea11:b0:1b2:e0c:a408 with SMTP id s17-20020a170902ea1100b001b20e0ca408mr1284713plg.31.1686057256474;
        Tue, 06 Jun 2023 06:14:16 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z3-20020a170903018300b001b1a2bf5277sm8509561plg.39.2023.06.06.06.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 06:14:15 -0700 (PDT)
Message-ID: <647f3127.170a0220.ed87d.f40a@mx.google.com>
Date: Tue, 06 Jun 2023 06:14:15 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.26-1320-gc38e4a9845945
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-6.1.y-cip baseline-nfs: 58 runs,
 3 regressions (v6.1.26-1320-gc38e4a9845945)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jun 2023 13:14:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11884

cip/linux-6.1.y-cip baseline-nfs: 58 runs, 3 regressions (v6.1.26-1320-gc38=
e4a9845945)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
at91sam9g20ek    | arm   | lab-broonie   | gcc-10   | multi_v5_defconfig   =
      | 1          =

beaglebone-black | arm   | lab-broonie   | gcc-10   | omap2plus_defconfig  =
      | 1          =

rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.26-1320-gc38e4a9845945/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.26-1320-gc38e4a9845945
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      c38e4a98459459f32d3c7c627ff35defa2415935 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
at91sam9g20ek    | arm   | lab-broonie   | gcc-10   | multi_v5_defconfig   =
      | 1          =


  Details:     https://kernelci.org/test/plan/id/647f28cc6b49e0daacf5de2e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.26-13=
20-gc38e4a9845945/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-nfs-at=
91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.26-13=
20-gc38e4a9845945/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-nfs-at=
91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armel/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/647f28cc6b49e0daa=
cf5de2f
        new failure (last pass: v6.1.26-1314-g1ab0ac1d7e2e3) =

 =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
beaglebone-black | arm   | lab-broonie   | gcc-10   | omap2plus_defconfig  =
      | 1          =


  Details:     https://kernelci.org/test/plan/id/647f2449b07631e9bcf5de25

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.26-13=
20-gc38e4a9845945/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nfs-b=
eaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.26-13=
20-gc38e4a9845945/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nfs-b=
eaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/647f2449b07631e9b=
cf5de26
        new failure (last pass: v6.1.26-1314-g1ab0ac1d7e2e3) =

 =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647f27206c8c797ef5f5de9e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.26-13=
20-gc38e4a9845945/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/bas=
eline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.26-13=
20-gc38e4a9845945/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/bas=
eline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/647f27206c8c797ef=
5f5de9f
        new failure (last pass: v6.1.26-1314-g1ab0ac1d7e2e3) =

 =20

