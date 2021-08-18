Return-Path: <SRS0=vu8r=NJ=lists.cip-project.org=bounce+64572+6690+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A48C432BE
	for <cip-dev@archiver.kernel.org>; Wed, 18 Aug 2021 17:05:10 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B726F606A5
	for <cip-dev@archiver.kernel.org>; Wed, 18 Aug 2021 17:05:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B726F606A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id gQPBYY4521723xep64rBf7eN; Wed, 18 Aug 2021 10:05:09 -0700
X-Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web09.57507.1629306309030703042
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 18 Aug 2021 10:05:09 -0700
X-Received: by mail-pl1-f178.google.com with SMTP id e15so2181579plh.8
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 18 Aug 2021 10:05:08 -0700 (PDT)
X-Gm-Message-State: zH5PidINnQQiV9IMRI8ZUmSJx4520388AA=
X-Google-Smtp-Source: ABdhPJx4YAfolsket1/SFQKVEUjOKVS66N0dHKUCinKnqNh/G1hJ4Naxn1tBS9Ek6FVYFrtqX1AzYg==
X-Received: by 2002:a17:90b:378c:: with SMTP id mz12mr10042720pjb.187.1629306308234;
        Wed, 18 Aug 2021 10:05:08 -0700 (PDT)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id r92sm363738pjg.7.2021.08.18.10.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 10:05:08 -0700 (PDT)
Message-ID: <611d3dc4.1c69fb81.53f4c.1437@mx.google.com>
Date: Wed, 18 Aug 2021 10:05:08 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.4.281-cip61
X-Kernelci-Report-Type: test
Subject: [cip-dev] cip/linux-4.4.y-cip baseline: 168 runs, 14 regressions (v4.4.281-cip61) #kernelci
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
Content-Type: multipart/mixed; boundary="AVKLhSk9qWUFnSP443wA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1629306309;
 bh=ZlByJVdWRUM8H72ZtUHX/OYKFkrguKjd6ZqVqCPyqG8=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=GzUhLWnN+OpMqaW+k7k8vStxhAZJfOZ1rf1J5tOdyh4xMjm4n1eLuaYXLdrzGXW8yHH
 w7Ifa8nRXjfMH/M3aBzXlEEuqt3iVn+UzWeQ8mTMx9IuBQ0w2KnGSdBmU9yNsoriBwP6u
 pDL9dlu2jyz3I9sZh9TJ/iy5UuS0G6jLMbU=

--AVKLhSk9qWUFnSP443wA
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.4.y-cip baseline: 168 runs, 14 regressions (v4.4.281-cip61)

Regressions Summary
-------------------

platform            | arch | lab             | compiler | defconfig        =
            | regressions
--------------------+------+-----------------+----------+------------------=
------------+------------
dove-cubox          | arm  | lab-pengutronix | gcc-8    | mvebu_v7_defconfi=
g           | 1          =

imx6q-sabresd       | arm  | lab-nxp         | gcc-8    | multi_v7_defconfi=
g+ima       | 1          =

qemu_arm-virt-gicv2 | arm  | lab-baylibre    | gcc-8    | multi_v7_defc...C=
ONFIG_SMP=3Dn | 1          =

qemu_arm-virt-gicv2 | arm  | lab-baylibre    | gcc-8    | multi_v7_defconfi=
g           | 1          =

qemu_arm-virt-gicv2 | arm  | lab-cip         | gcc-8    | multi_v7_defc...C=
ONFIG_SMP=3Dn | 1          =

qemu_arm-virt-gicv2 | arm  | lab-cip         | gcc-8    | multi_v7_defconfi=
g           | 1          =

qemu_arm-virt-gicv2 | arm  | lab-collabora   | gcc-8    | multi_v7_defc...C=
ONFIG_SMP=3Dn | 1          =

qemu_arm-virt-gicv2 | arm  | lab-collabora   | gcc-8    | multi_v7_defconfi=
g           | 1          =

qemu_arm-virt-gicv3 | arm  | lab-baylibre    | gcc-8    | multi_v7_defc...C=
ONFIG_SMP=3Dn | 1          =

qemu_arm-virt-gicv3 | arm  | lab-baylibre    | gcc-8    | multi_v7_defconfi=
g           | 1          =

qemu_arm-virt-gicv3 | arm  | lab-cip         | gcc-8    | multi_v7_defc...C=
ONFIG_SMP=3Dn | 1          =

qemu_arm-virt-gicv3 | arm  | lab-cip         | gcc-8    | multi_v7_defconfi=
g           | 1          =

qemu_arm-virt-gicv3 | arm  | lab-collabora   | gcc-8    | multi_v7_defc...C=
ONFIG_SMP=3Dn | 1          =

qemu_arm-virt-gicv3 | arm  | lab-collabora   | gcc-8    | multi_v7_defconfi=
g           | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.281-cip61/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.281-cip61
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      4efaeea21a7699c04fddc3381cd86c6e37676d20 =



Test Regressions
---------------- =



platform            | arch | lab             | compiler | defconfig        =
            | regressions
--------------------+------+-----------------+----------+------------------=
------------+------------
dove-cubox          | arm  | lab-pengutronix | gcc-8    | mvebu_v7_defconfi=
g           | 1          =


  Details:     https://kernelci.org/test/plan/id/611d30246e62eb7898b1366e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: mvebu_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.281-c=
ip61/arm/mvebu_v7_defconfig/gcc-8/lab-pengutronix/baseline-dove-cubox.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.281-c=
ip61/arm/mvebu_v7_defconfig/gcc-8/lab-pengutronix/baseline-dove-cubox.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/611d30246e62eb7898b13=
66f
        failing since 13 days (last pass: v4.4.274-cip59, first fail: v4.4.=
277-cip60) =

 =



platform            | arch | lab             | compiler | defconfig        =
            | regressions
--------------------+------+-----------------+----------+------------------=
------------+------------
imx6q-sabresd       | arm  | lab-nxp         | gcc-8    | multi_v7_defconfi=
g+ima       | 1          =


  Details:     https://kernelci.org/test/plan/id/611d3210aa4e73d2b5b1369a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+ima
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.281-c=
ip61/arm/multi_v7_defconfig+ima/gcc-8/lab-nxp/baseline-imx6q-sabresd.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.281-c=
ip61/arm/multi_v7_defconfig+ima/gcc-8/lab-nxp/baseline-imx6q-sabresd.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/611d3210aa4e73d2b5b13=
69b
        new failure (last pass: v4.4.277-cip60) =

 =



platform            | arch | lab             | compiler | defconfig        =
            | regressions
--------------------+------+-----------------+----------+------------------=
------------+------------
qemu_arm-virt-gicv2 | arm  | lab-baylibre    | gcc-8    | multi_v7_defc...C=
ONFIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/611d353fd8621310d6b136b0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.281-c=
ip61/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-baylibre/baseline-qemu=
_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.281-c=
ip61/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-baylibre/baseline-qemu=
_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/611d353fd8621310d6b13=
6b1
        failing since 266 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab             | compiler | defconfig        =
            | regressions
--------------------+------+-----------------+----------+------------------=
------------+------------
qemu_arm-virt-gicv2 | arm  | lab-baylibre    | gcc-8    | multi_v7_defconfi=
g           | 1          =


  Details:     https://kernelci.org/test/plan/id/611d365969fb811bc0b13682

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.281-c=
ip61/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-qemu_arm-virt-gicv2=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.281-c=
ip61/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-qemu_arm-virt-gicv2=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/611d365969fb811bc0b13=
683
        failing since 266 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab             | compiler | defconfig        =
            | regressions
--------------------+------+-----------------+----------+------------------=
------------+------------
qemu_arm-virt-gicv2 | arm  | lab-cip         | gcc-8    | multi_v7_defc...C=
ONFIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/611d32aff68e2f47dbb136a0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.281-c=
ip61/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-cip/baseline-qemu_arm-=
virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.281-c=
ip61/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-cip/baseline-qemu_arm-=
virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/611d32aff68e2f47dbb13=
6a1
        failing since 266 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab             | compiler | defconfig        =
            | regressions
--------------------+------+-----------------+----------+------------------=
------------+------------
qemu_arm-virt-gicv2 | arm  | lab-cip         | gcc-8    | multi_v7_defconfi=
g           | 1          =


  Details:     https://kernelci.org/test/plan/id/611d33c41792c101b0b13693

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.281-c=
ip61/arm/multi_v7_defconfig/gcc-8/lab-cip/baseline-qemu_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.281-c=
ip61/arm/multi_v7_defconfig/gcc-8/lab-cip/baseline-qemu_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/611d33c41792c101b0b13=
694
        failing since 266 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab             | compiler | defconfig        =
            | regressions
--------------------+------+-----------------+----------+------------------=
------------+------------
qemu_arm-virt-gicv2 | arm  | lab-collabora   | gcc-8    | multi_v7_defc...C=
ONFIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/611d382d3a644bcd4cb1368c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.281-c=
ip61/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-collabora/baseline-qem=
u_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.281-c=
ip61/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-collabora/baseline-qem=
u_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/611d382d3a644bcd4cb13=
68d
        failing since 266 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab             | compiler | defconfig        =
            | regressions
--------------------+------+-----------------+----------+------------------=
------------+------------
qemu_arm-virt-gicv2 | arm  | lab-collabora   | gcc-8    | multi_v7_defconfi=
g           | 1          =


  Details:     https://kernelci.org/test/plan/id/611d398bc990c1790eb13663

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.281-c=
ip61/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-qemu_arm-virt-gicv=
2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.281-c=
ip61/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-qemu_arm-virt-gicv=
2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/611d398bc990c1790eb13=
664
        failing since 266 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab             | compiler | defconfig        =
            | regressions
--------------------+------+-----------------+----------+------------------=
------------+------------
qemu_arm-virt-gicv3 | arm  | lab-baylibre    | gcc-8    | multi_v7_defc...C=
ONFIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/611d35cc6cfffb910bb136a0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.281-c=
ip61/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-baylibre/baseline-qemu=
_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.281-c=
ip61/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-baylibre/baseline-qemu=
_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/611d35cc6cfffb910bb13=
6a1
        failing since 266 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab             | compiler | defconfig        =
            | regressions
--------------------+------+-----------------+----------+------------------=
------------+------------
qemu_arm-virt-gicv3 | arm  | lab-baylibre    | gcc-8    | multi_v7_defconfi=
g           | 1          =


  Details:     https://kernelci.org/test/plan/id/611d365869fb811bc0b13675

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.281-c=
ip61/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-qemu_arm-virt-gicv3=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.281-c=
ip61/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-qemu_arm-virt-gicv3=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/611d365869fb811bc0b13=
676
        failing since 266 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab             | compiler | defconfig        =
            | regressions
--------------------+------+-----------------+----------+------------------=
------------+------------
qemu_arm-virt-gicv3 | arm  | lab-cip         | gcc-8    | multi_v7_defc...C=
ONFIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/611d333b3f06c5f627b13662

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.281-c=
ip61/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-cip/baseline-qemu_arm-=
virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.281-c=
ip61/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-cip/baseline-qemu_arm-=
virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/611d333b3f06c5f627b13=
663
        failing since 266 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab             | compiler | defconfig        =
            | regressions
--------------------+------+-----------------+----------+------------------=
------------+------------
qemu_arm-virt-gicv3 | arm  | lab-cip         | gcc-8    | multi_v7_defconfi=
g           | 1          =


  Details:     https://kernelci.org/test/plan/id/611d33b91792c101b0b13672

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.281-c=
ip61/arm/multi_v7_defconfig/gcc-8/lab-cip/baseline-qemu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.281-c=
ip61/arm/multi_v7_defconfig/gcc-8/lab-cip/baseline-qemu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/611d33b91792c101b0b13=
673
        failing since 266 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab             | compiler | defconfig        =
            | regressions
--------------------+------+-----------------+----------+------------------=
------------+------------
qemu_arm-virt-gicv3 | arm  | lab-collabora   | gcc-8    | multi_v7_defc...C=
ONFIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/611d388bc0e35a29beb13661

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.281-c=
ip61/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-collabora/baseline-qem=
u_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.281-c=
ip61/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-collabora/baseline-qem=
u_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/611d388bc0e35a29beb13=
662
        failing since 266 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab             | compiler | defconfig        =
            | regressions
--------------------+------+-----------------+----------+------------------=
------------+------------
qemu_arm-virt-gicv3 | arm  | lab-collabora   | gcc-8    | multi_v7_defconfi=
g           | 1          =


  Details:     https://kernelci.org/test/plan/id/611d3906c786f3bee0b13669

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.281-c=
ip61/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-qemu_arm-virt-gicv=
3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.281-c=
ip61/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-qemu_arm-virt-gicv=
3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/611d3906c786f3bee0b13=
66a
        failing since 266 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =20

--AVKLhSk9qWUFnSP443wA
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6690): https://lists.cip-project.org/g/cip-dev/message/=
6690
Mute This Topic: https://lists.cip-project.org/mt/84977110/4520388
Mute #kernelci:https://lists.cip-project.org/g/cip-dev/mutehashtag/kernelci
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--AVKLhSk9qWUFnSP443wA--
