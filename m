Return-Path: <SRS0=ZVIj=KM=lists.cip-project.org=bounce+64572+6467+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E348C433ED
	for <cip-dev@archiver.kernel.org>; Mon, 17 May 2021 07:50:34 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 210A2610FA
	for <cip-dev@archiver.kernel.org>; Mon, 17 May 2021 07:50:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 210A2610FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6467+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id bUcDYY4521723xLxucNmFuSQ; Mon, 17 May 2021 00:50:33 -0700
X-Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.web12.16047.1621237833313641655
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 17 May 2021 00:50:33 -0700
X-Received: by mail-pl1-f173.google.com with SMTP id s4so1104342plg.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 17 May 2021 00:50:33 -0700 (PDT)
X-Gm-Message-State: JbTXsHY4d8o0oFFuy03iHiZGx4520388AA=
X-Google-Smtp-Source: ABdhPJx3jGzlI5x7gNCdH9ktYJIMnM3tABtM0wGf4Y+8Untqaihf6/fn+2zdaoyUuF6mcI2IZ7XeJQ==
X-Received: by 2002:a17:90a:bc4a:: with SMTP id t10mr26266151pjv.4.1621237832653;
        Mon, 17 May 2021 00:50:32 -0700 (PDT)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c16sm9562753pgl.79.2021.05.17.00.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 00:50:32 -0700 (PDT)
Message-ID: <60a22048.1c69fb81.2b161.fd1f@mx.google.com>
Date: Mon, 17 May 2021 00:50:32 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.4.268-cip57
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Report-Type: test
Subject: [cip-dev] cip/linux-4.4.y-cip baseline: 89 runs, 13 regressions (v4.4.268-cip57) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="H8BoTDsKzoZ1injQl5wV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1621237833;
 bh=iQeOeoj6jF6mygwjtMW2Jl/1G19xJU+NKUW14g0q5cs=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=XeGoPBnI6Jo1IQqrWjU5nlgbEzzzkHt0tlOT2VH7cCMevzTVT8TqZyEM5I0cHlOZysE
 sWpqb8v1IIwfP3MJBNG+Jn0f/JstH1JyD5LMyKI5QJRAXDha2+hirGkkIlSEG7vUBTanz
 YKdPdStfBOG0eq0qjoGFGIHpg/3Oega7Hh4=

--H8BoTDsKzoZ1injQl5wV
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.4.y-cip baseline: 89 runs, 13 regressions (v4.4.268-cip57)

Regressions Summary
-------------------

platform            | arch | lab          | compiler | defconfig           =
         | regressions
--------------------+------+--------------+----------+---------------------=
---------+------------
qemu_arm-virt-gicv2 | arm  | lab-baylibre | gcc-8    | multi_v7_defconfig  =
         | 1          =

qemu_arm-virt-gicv2 | arm  | lab-baylibre | gcc-8    | multi_v7_defc...CONF=
IG_SMP=3Dn | 1          =

qemu_arm-virt-gicv2 | arm  | lab-broonie  | gcc-8    | multi_v7_defconfig  =
         | 1          =

qemu_arm-virt-gicv2 | arm  | lab-broonie  | gcc-8    | multi_v7_defc...CONF=
IG_SMP=3Dn | 1          =

qemu_arm-virt-gicv2 | arm  | lab-cip      | gcc-8    | multi_v7_defconfig  =
         | 1          =

qemu_arm-virt-gicv2 | arm  | lab-cip      | gcc-8    | multi_v7_defc...CONF=
IG_SMP=3Dn | 1          =

qemu_arm-virt-gicv3 | arm  | lab-baylibre | gcc-8    | multi_v7_defconfig  =
         | 1          =

qemu_arm-virt-gicv3 | arm  | lab-baylibre | gcc-8    | multi_v7_defc...CONF=
IG_SMP=3Dn | 1          =

qemu_arm-virt-gicv3 | arm  | lab-broonie  | gcc-8    | multi_v7_defconfig  =
         | 1          =

qemu_arm-virt-gicv3 | arm  | lab-broonie  | gcc-8    | multi_v7_defc...CONF=
IG_SMP=3Dn | 1          =

qemu_arm-virt-gicv3 | arm  | lab-cip      | gcc-8    | multi_v7_defconfig  =
         | 1          =

qemu_arm-virt-gicv3 | arm  | lab-cip      | gcc-8    | multi_v7_defc...CONF=
IG_SMP=3Dn | 1          =

qemu_i386           | i386 | lab-broonie  | gcc-8    | i386_defconfig      =
         | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.268-cip57/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.268-cip57
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      999b74443ca356daa3b0238d7ff676f19728abed =



Test Regressions
---------------- =



platform            | arch | lab          | compiler | defconfig           =
         | regressions
--------------------+------+--------------+----------+---------------------=
---------+------------
qemu_arm-virt-gicv2 | arm  | lab-baylibre | gcc-8    | multi_v7_defconfig  =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/60a21871a3cbd37164b3afa1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.268-c=
ip57/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-qemu_arm-virt-gicv2=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.268-c=
ip57/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-qemu_arm-virt-gicv2=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60a21871a3cbd37164b3a=
fa2
        failing since 173 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab          | compiler | defconfig           =
         | regressions
--------------------+------+--------------+----------+---------------------=
---------+------------
qemu_arm-virt-gicv2 | arm  | lab-baylibre | gcc-8    | multi_v7_defc...CONF=
IG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/60a21a015ddd17dc55b3af9f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.268-c=
ip57/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-baylibre/baseline-qemu=
_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.268-c=
ip57/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-baylibre/baseline-qemu=
_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60a21a015ddd17dc55b3a=
fa0
        failing since 173 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab          | compiler | defconfig           =
         | regressions
--------------------+------+--------------+----------+---------------------=
---------+------------
qemu_arm-virt-gicv2 | arm  | lab-broonie  | gcc-8    | multi_v7_defconfig  =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/60a21878c4a556cba7b3af97

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.268-c=
ip57/arm/multi_v7_defconfig/gcc-8/lab-broonie/baseline-qemu_arm-virt-gicv2.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.268-c=
ip57/arm/multi_v7_defconfig/gcc-8/lab-broonie/baseline-qemu_arm-virt-gicv2.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60a21878c4a556cba7b3a=
f98
        failing since 173 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab          | compiler | defconfig           =
         | regressions
--------------------+------+--------------+----------+---------------------=
---------+------------
qemu_arm-virt-gicv2 | arm  | lab-broonie  | gcc-8    | multi_v7_defc...CONF=
IG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/60a21984110a83a4a8b3af9c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.268-c=
ip57/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-broonie/baseline-qemu_=
arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.268-c=
ip57/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-broonie/baseline-qemu_=
arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60a21984110a83a4a8b3a=
f9d
        failing since 173 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab          | compiler | defconfig           =
         | regressions
--------------------+------+--------------+----------+---------------------=
---------+------------
qemu_arm-virt-gicv2 | arm  | lab-cip      | gcc-8    | multi_v7_defconfig  =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/60a219e75ddd17dc55b3af99

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.268-c=
ip57/arm/multi_v7_defconfig/gcc-8/lab-cip/baseline-qemu_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.268-c=
ip57/arm/multi_v7_defconfig/gcc-8/lab-cip/baseline-qemu_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60a219e75ddd17dc55b3a=
f9a
        failing since 173 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab          | compiler | defconfig           =
         | regressions
--------------------+------+--------------+----------+---------------------=
---------+------------
qemu_arm-virt-gicv2 | arm  | lab-cip      | gcc-8    | multi_v7_defc...CONF=
IG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/60a21b2ea9f3d6c646b3af9f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.268-c=
ip57/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-cip/baseline-qemu_arm-=
virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.268-c=
ip57/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-cip/baseline-qemu_arm-=
virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60a21b2ea9f3d6c646b3a=
fa0
        failing since 173 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab          | compiler | defconfig           =
         | regressions
--------------------+------+--------------+----------+---------------------=
---------+------------
qemu_arm-virt-gicv3 | arm  | lab-baylibre | gcc-8    | multi_v7_defconfig  =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/60a2185cc41fa8fe5bb3afd4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.268-c=
ip57/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-qemu_arm-virt-gicv3=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.268-c=
ip57/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-qemu_arm-virt-gicv3=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60a2185cc41fa8fe5bb3a=
fd5
        failing since 173 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab          | compiler | defconfig           =
         | regressions
--------------------+------+--------------+----------+---------------------=
---------+------------
qemu_arm-virt-gicv3 | arm  | lab-baylibre | gcc-8    | multi_v7_defc...CONF=
IG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/60a219c4d7acb42d8eb3afc7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.268-c=
ip57/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-baylibre/baseline-qemu=
_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.268-c=
ip57/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-baylibre/baseline-qemu=
_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60a219c4d7acb42d8eb3a=
fc8
        failing since 173 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab          | compiler | defconfig           =
         | regressions
--------------------+------+--------------+----------+---------------------=
---------+------------
qemu_arm-virt-gicv3 | arm  | lab-broonie  | gcc-8    | multi_v7_defconfig  =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/60a21880c4a556cba7b3af9d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.268-c=
ip57/arm/multi_v7_defconfig/gcc-8/lab-broonie/baseline-qemu_arm-virt-gicv3.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.268-c=
ip57/arm/multi_v7_defconfig/gcc-8/lab-broonie/baseline-qemu_arm-virt-gicv3.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60a21880c4a556cba7b3a=
f9e
        failing since 173 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab          | compiler | defconfig           =
         | regressions
--------------------+------+--------------+----------+---------------------=
---------+------------
qemu_arm-virt-gicv3 | arm  | lab-broonie  | gcc-8    | multi_v7_defc...CONF=
IG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/60a21970b87b8c2d29b3afb3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.268-c=
ip57/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-broonie/baseline-qemu_=
arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.268-c=
ip57/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-broonie/baseline-qemu_=
arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60a21970b87b8c2d29b3a=
fb4
        failing since 173 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab          | compiler | defconfig           =
         | regressions
--------------------+------+--------------+----------+---------------------=
---------+------------
qemu_arm-virt-gicv3 | arm  | lab-cip      | gcc-8    | multi_v7_defconfig  =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/60a219e1191e53dfa4b3afa5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.268-c=
ip57/arm/multi_v7_defconfig/gcc-8/lab-cip/baseline-qemu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.268-c=
ip57/arm/multi_v7_defconfig/gcc-8/lab-cip/baseline-qemu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60a219e1191e53dfa4b3a=
fa6
        failing since 173 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab          | compiler | defconfig           =
         | regressions
--------------------+------+--------------+----------+---------------------=
---------+------------
qemu_arm-virt-gicv3 | arm  | lab-cip      | gcc-8    | multi_v7_defc...CONF=
IG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/60a21b21a9f3d6c646b3af99

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.268-c=
ip57/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-cip/baseline-qemu_arm-=
virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.268-c=
ip57/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-cip/baseline-qemu_arm-=
virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60a21b21a9f3d6c646b3a=
f9a
        failing since 173 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab          | compiler | defconfig           =
         | regressions
--------------------+------+--------------+----------+---------------------=
---------+------------
qemu_i386           | i386 | lab-broonie  | gcc-8    | i386_defconfig      =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/60a21830c8bba69d8db3afa4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: i386_defconfig
  Compiler:    gcc-8 (gcc (Debian 8.3.0-6) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.268-c=
ip57/i386/i386_defconfig/gcc-8/lab-broonie/baseline-qemu_i386.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.268-c=
ip57/i386/i386_defconfig/gcc-8/lab-broonie/baseline-qemu_i386.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/x86/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60a21830c8bba69d8db3a=
fa5
        new failure (last pass: v4.4.262-cip55) =

 =20

--H8BoTDsKzoZ1injQl5wV
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6467): https://lists.cip-project.org/g/cip-dev/message=
/6467
Mute This Topic: https://lists.cip-project.org/mt/82881605/4520388
Mute #kernelci:https://lists.cip-project.org/g/cip-dev/mutehashtag/kernelc=
i
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--H8BoTDsKzoZ1injQl5wV--
