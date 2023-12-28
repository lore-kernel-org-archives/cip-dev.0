Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E742DC47072
	for <webhook@archiver.kernel.org>; Thu, 28 Dec 2023 00:07:34 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.web11.113575.1703722050276965033
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 27 Dec 2023 16:07:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=NJoBsTYr;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.173, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d3dee5f534so43558595ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 27 Dec 2023 16:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703722049; x=1704326849; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8Y9PtaAjoBrvW12BzbEgBUdIsR63E/NudzReS1+cz3I=;
        b=NJoBsTYrpWrJH/9ndX9+94oKzyDws4iucS3IJSuIwFgAG02J7vXHIzteWaWxV+q5BI
         TBOsiW2vN6pTp3cvW923K7+YsWKPfN5zdjCcf6It6L1toxow4y2YiL6m1RRotMH1zUxC
         zo24wNOIYNqEASH58fRoZe+mGzLSYpvG9y7vvTkbV4ZhGAIrS9bq1H4c6Vahok6ChIgG
         ZhLRCHFxunO/enmBvJaYh7V/zlwmgZ7fdSk1VYqMRGI73bOBtx/kfKUq9gdTE091h8PT
         3X26yZeC4K3iddowZkFa/Zxb5p9Gepd9fqgeQFrHN8kwJknYHb50J6zo7hFq8KfywJR/
         dZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703722049; x=1704326849;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Y9PtaAjoBrvW12BzbEgBUdIsR63E/NudzReS1+cz3I=;
        b=HQsKXlpAzz3FzXChZW6w3kicSqHbhAiOBeeym8Bh0f8hS9YlAMqiRGW3ccwwdS/D2D
         wT0HeYYytQ+h0nQcaK3Yda9wC+22hzSpxza7spKkxWCWe6/Fmo3rulNF77WueVF8yx+3
         UX4wjCrMGI7QgB8hQoC3NArXYhWlVHyc9N6CIw7BKxYPLnHUvHWvmTe+YzIiQWpPDVOA
         0fxNVZoDXzaTHpLx+T1xfCteJskMX+JD8igq0kDSFiUw7Er7ZSpY49zkG/OE1RrILHw/
         4tiOWAYkaCvb1kk2Vj0ORvx1VD7KGGS864n3NAQfnWhKuyyw4ntf+YpUdBQb6zzLU9jc
         FddA==
X-Gm-Message-State: AOJu0YxvW+3VyZJER+/kpSXHXl3TlSPjEJZ+8ivh71uKJA/SqRcnxIUa
	Z5kQCTXX4StxI6M38VUFuDWckO0l0jwMY2i8fidNIAhCt5g=
X-Google-Smtp-Source: AGHT+IHW843YJCN2INXB+2xGtjSuF7XqXFB8KvSrW8ZSfqxteCgGmjq7HEVA22yTRp5DmguXpE9ngA==
X-Received: by 2002:a17:902:da81:b0:1d3:9f56:b824 with SMTP id j1-20020a170902da8100b001d39f56b824mr10282106plx.12.1703722049100;
        Wed, 27 Dec 2023 16:07:29 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x7-20020a170902820700b001d46274b533sm5444367pln.138.2023.12.27.16.07.28
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 16:07:28 -0800 (PST)
Message-ID: <658cbc40.170a0220.8e1f9.acc6@mx.google.com>
Date: Wed, 27 Dec 2023 16:07:28 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.66-cip11-rt6-10-g38253b8903b4
Subject: cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 9 runs,
 6 regressions (v6.1.66-cip11-rt6-10-g38253b8903b4)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 28 Dec 2023 00:07:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14208

cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 9 runs, 6 regressions (v6.=
1.66-cip11-rt6-10-g38253b8903b4)

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

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =

r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =

r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig      =
            | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.66-cip11-rt6-10-g38253b8903b4/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.66-cip11-rt6-10-g38253b8903b4
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      38253b8903b46da162814048c6f555bba4399ca8 =



Test Regressions
---------------- =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | multi_v7_defcon=
fig         | 1          =


  Details:     https://kernelci.org/test/plan/id/658cb09894c9e903dee13475

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/658cb09894c9e=
903dee13476
        failing since 465 days (last pass: v4.4-st20-229-gb433f12afe250, fi=
rst fail: v4.4-st20-231-g7349cef09ddd2) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
beaglebone-black         | arm   | lab-cip     | gcc-10   | multi_v7_defcon=
fig         | 1          =


  Details:     https://kernelci.org/test/plan/id/658cb534c2debb2f35e1350a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/arm/multi_v7_defconfig/gcc-10/lab-cip/b=
aseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/arm/multi_v7_defconfig/gcc-10/lab-cip/b=
aseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/658cb534c2deb=
b2f35e1350b
        failing since 465 days (last pass: v4.4-st20-229-gb433f12afe250, fi=
rst fail: v4.4-st20-231-g7349cef09ddd2) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | omap2plus_defco=
nfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/658cb6844d66e304eee13475

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/arm/omap2plus_defconfig/gcc-10/lab-broo=
nie/baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/arm/omap2plus_defconfig/gcc-10/lab-broo=
nie/baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/658cb6844d66e=
304eee13476
        failing since 37 days (last pass: v4.4-st20-231-g7349cef09ddd2, fir=
st fail: v5.10.200-cip40-513-g195b5d2b5c744) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/658cb08182e58348f2e1347b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-cip/baseline-cip-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-cip/baseline-cip-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/658cb08182e58=
348f2e1347c
        failing since 33 days (last pass: v5.10.138-cip15-10-g52cbd8ad1543e=
, first fail: v6.1.62-cip9-12-g3a5321f469b07) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/658caf92719bd2ad5ce13484

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-cip/baseline-cip-nfs-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-cip/baseline-cip-nfs-r8a774c0-ek874.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/658caf92719bd=
2ad5ce13485
        failing since 34 days (last pass: v5.10.138-cip15-10-g52cbd8ad1543e=
, first fail: v6.1.62-cip9-13-g34c303883a305) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig      =
            | 1          =


  Details:     https://kernelci.org/test/plan/id/658cb1fec3590f03f4e13499

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/arm64/defconfig/gcc-10/lab-cip/baseline=
-cip-nfs-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/arm64/defconfig/gcc-10/lab-cip/baseline=
-cip-nfs-r8a774c0-ek874.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/658cb1fec3590=
f03f4e1349a
        failing since 37 days (last pass: v5.10.138-cip15-10-g52cbd8ad1543e=
, first fail: v5.10.200-cip40-513-g195b5d2b5c744) =

 =20

