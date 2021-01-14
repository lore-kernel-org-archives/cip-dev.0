Return-Path: <SRS0=DG+S=GR=lists.cip-project.org=bounce+64572+6089+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF21C433E6
	for <cip-dev@archiver.kernel.org>; Thu, 14 Jan 2021 12:37:49 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D17B239FD
	for <cip-dev@archiver.kernel.org>; Thu, 14 Jan 2021 12:37:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D17B239FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6089+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id grPyYY4521723xK2waPK2YaC; Thu, 14 Jan 2021 04:37:48 -0800
X-Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
 by mx.groups.io with SMTP id smtpd.web08.5262.1610612736177985189
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Jan 2021 00:25:36 -0800
X-Received: by mail-pf1-f172.google.com with SMTP id h10so2909263pfo.9
        for <cip-dev@lists.cip-project.org>; Thu, 14 Jan 2021 00:25:36 -0800 (PST)
X-Gm-Message-State: wUwLBnKFctMIveaBon8stbtrx4520388AA=
X-Google-Smtp-Source: ABdhPJyL2hSZyo1p3LarslNG/5tjUT2n1ss70pKOUF/M+2yFtTEfXHF2bgi+T306EZN0peLCNHz5dw==
X-Received: by 2002:a63:4746:: with SMTP id w6mr6269027pgk.377.1610612735197;
        Thu, 14 Jan 2021 00:25:35 -0800 (PST)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j3sm4806707pjs.50.2021.01.14.00.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 00:25:34 -0800 (PST)
Message-ID: <5ffffffe.1c69fb81.f49c2.b3b9@mx.google.com>
Date: Thu, 14 Jan 2021 00:25:34 -0800 (PST)
MIME-Version: 1.0
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.4.249-cip53-9-g5fa136ab4d24
X-Kernelci-Report-Type: test
Subject: [cip-dev] cip/linux-4.4.y-cip baseline: 80 runs, 10 regressions (v4.4.249-cip53-9-g5fa136ab4d24)
To: cip-dev@lists.cip-project.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="vdHnHub5jsnNfqDvYPml"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1610627868;
 bh=2TnaDGThGr8TqmBSmN6nEwPcpjEXggjKUg9dQDzxId0=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=jXDZxKKg8B7GY7lVLurZMEy4rzxcnkgWPmk4AOs84OuHKfBBpCeindXBr1PfqR4SwG+
 bI3ScPF3Zt3KH4bVq2mhuPL1paM/KgpDbwPqsNTEVsCQ4Y3+hryrr33D1U+1FKo8x7HNA
 CPhBpsZ/MHKrVuAQ3pv5OLDzm+QrKcD7eY0=

--vdHnHub5jsnNfqDvYPml
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.4.y-cip baseline: 80 runs, 10 regressions (v4.4.249-cip53-9-g5f=
a136ab4d24)

Regressions Summary
-------------------

platform            | arch   | lab           | compiler | defconfig        =
            | regressions
--------------------+--------+---------------+----------+------------------=
------------+------------
panda               | arm    | lab-collabora | gcc-8    | omap2plus_defconf=
ig          | 1          =

qemu_arm-virt-gicv2 | arm    | lab-baylibre  | gcc-8    | multi_v7_defc...C=
ONFIG_SMP=3Dn | 1          =

qemu_arm-virt-gicv2 | arm    | lab-broonie   | gcc-8    | multi_v7_defc...C=
ONFIG_SMP=3Dn | 1          =

qemu_arm-virt-gicv2 | arm    | lab-cip       | gcc-8    | multi_v7_defc...C=
ONFIG_SMP=3Dn | 1          =

qemu_arm-virt-gicv2 | arm    | lab-collabora | gcc-8    | multi_v7_defc...C=
ONFIG_SMP=3Dn | 1          =

qemu_arm-virt-gicv3 | arm    | lab-baylibre  | gcc-8    | multi_v7_defc...C=
ONFIG_SMP=3Dn | 1          =

qemu_arm-virt-gicv3 | arm    | lab-broonie   | gcc-8    | multi_v7_defc...C=
ONFIG_SMP=3Dn | 1          =

qemu_arm-virt-gicv3 | arm    | lab-cip       | gcc-8    | multi_v7_defc...C=
ONFIG_SMP=3Dn | 1          =

qemu_arm-virt-gicv3 | arm    | lab-collabora | gcc-8    | multi_v7_defc...C=
ONFIG_SMP=3Dn | 1          =

qemu_x86_64         | x86_64 | lab-baylibre  | gcc-8    | x86_64_defconfig =
            | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.249-cip53-9-g5fa136ab4d24/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.249-cip53-9-g5fa136ab4d24
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      5fa136ab4d246b23565633a275a0ff510bf18545 =



Test Regressions
---------------- =



platform            | arch   | lab           | compiler | defconfig        =
            | regressions
--------------------+--------+---------------+----------+------------------=
------------+------------
panda               | arm    | lab-collabora | gcc-8    | omap2plus_defconf=
ig          | 1          =


  Details:     https://kernelci.org/test/plan/id/5ffff612fa1c0241e6c94cd5

  Results:     3 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.249-c=
ip53-9-g5fa136ab4d24/arm/omap2plus_defconfig/gcc-8/lab-collabora/baseline-p=
anda.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.249-c=
ip53-9-g5fa136ab4d24/arm/omap2plus_defconfig/gcc-8/lab-collabora/baseline-p=
anda.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/5ffff612fa1c024=
1e6c94cda
        failing since 5 days (last pass: v4.4.243-cip51-21-g1d9a9094c010, f=
irst fail: v4.4.249-cip53)
        2 lines

    2021-01-14 07:43:10.377000+00:00  kern  :emerg :  lock: emif_lock+0x0/0=
xfffff26c [emif], .magic: dead4ead, .owner: <none>/-1, .owner_cpu: -1   =

 =



platform            | arch   | lab           | compiler | defconfig        =
            | regressions
--------------------+--------+---------------+----------+------------------=
------------+------------
qemu_arm-virt-gicv2 | arm    | lab-baylibre  | gcc-8    | multi_v7_defc...C=
ONFIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/5ffff647f255b586b8c94cdc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.249-c=
ip53-9-g5fa136ab4d24/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-baylib=
re/baseline-qemu_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.249-c=
ip53-9-g5fa136ab4d24/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-baylib=
re/baseline-qemu_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5ffff647f255b586b8c94=
cdd
        failing since 50 days (last pass: v4.4.243-cip51, first fail: v4.4.=
243-cip51-10-gd7466739b72e9) =

 =



platform            | arch   | lab           | compiler | defconfig        =
            | regressions
--------------------+--------+---------------+----------+------------------=
------------+------------
qemu_arm-virt-gicv2 | arm    | lab-broonie   | gcc-8    | multi_v7_defc...C=
ONFIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/5ffff661f73a2a4693c94cd4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.249-c=
ip53-9-g5fa136ab4d24/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-brooni=
e/baseline-qemu_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.249-c=
ip53-9-g5fa136ab4d24/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-brooni=
e/baseline-qemu_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5ffff661f73a2a4693c94=
cd5
        failing since 50 days (last pass: v4.4.243-cip51, first fail: v4.4.=
243-cip51-10-gd7466739b72e9) =

 =



platform            | arch   | lab           | compiler | defconfig        =
            | regressions
--------------------+--------+---------------+----------+------------------=
------------+------------
qemu_arm-virt-gicv2 | arm    | lab-cip       | gcc-8    | multi_v7_defc...C=
ONFIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/5ffff661f73a2a4693c94cd7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.249-c=
ip53-9-g5fa136ab4d24/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-cip/ba=
seline-qemu_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.249-c=
ip53-9-g5fa136ab4d24/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-cip/ba=
seline-qemu_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5ffff661f73a2a4693c94=
cd8
        failing since 50 days (last pass: v4.4.243-cip51, first fail: v4.4.=
243-cip51-10-gd7466739b72e9) =

 =



platform            | arch   | lab           | compiler | defconfig        =
            | regressions
--------------------+--------+---------------+----------+------------------=
------------+------------
qemu_arm-virt-gicv2 | arm    | lab-collabora | gcc-8    | multi_v7_defc...C=
ONFIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/5ffffa26f3f1100a13c94cbe

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.249-c=
ip53-9-g5fa136ab4d24/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-collab=
ora/baseline-qemu_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.249-c=
ip53-9-g5fa136ab4d24/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-collab=
ora/baseline-qemu_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5ffffa26f3f1100a13c94=
cbf
        failing since 50 days (last pass: v4.4.243-cip51, first fail: v4.4.=
243-cip51-10-gd7466739b72e9) =

 =



platform            | arch   | lab           | compiler | defconfig        =
            | regressions
--------------------+--------+---------------+----------+------------------=
------------+------------
qemu_arm-virt-gicv3 | arm    | lab-baylibre  | gcc-8    | multi_v7_defc...C=
ONFIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/5ffff642f97d3501edc94ce2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.249-c=
ip53-9-g5fa136ab4d24/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-baylib=
re/baseline-qemu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.249-c=
ip53-9-g5fa136ab4d24/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-baylib=
re/baseline-qemu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5ffff642f97d3501edc94=
ce3
        failing since 50 days (last pass: v4.4.243-cip51, first fail: v4.4.=
243-cip51-10-gd7466739b72e9) =

 =



platform            | arch   | lab           | compiler | defconfig        =
            | regressions
--------------------+--------+---------------+----------+------------------=
------------+------------
qemu_arm-virt-gicv3 | arm    | lab-broonie   | gcc-8    | multi_v7_defc...C=
ONFIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/5ffff663f255b586b8c94ce0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.249-c=
ip53-9-g5fa136ab4d24/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-brooni=
e/baseline-qemu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.249-c=
ip53-9-g5fa136ab4d24/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-brooni=
e/baseline-qemu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5ffff663f255b586b8c94=
ce1
        failing since 50 days (last pass: v4.4.243-cip51, first fail: v4.4.=
243-cip51-10-gd7466739b72e9) =

 =



platform            | arch   | lab           | compiler | defconfig        =
            | regressions
--------------------+--------+---------------+----------+------------------=
------------+------------
qemu_arm-virt-gicv3 | arm    | lab-cip       | gcc-8    | multi_v7_defc...C=
ONFIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/5ffff679f73a2a4693c94e3a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.249-c=
ip53-9-g5fa136ab4d24/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-cip/ba=
seline-qemu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.249-c=
ip53-9-g5fa136ab4d24/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-cip/ba=
seline-qemu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5ffff679f73a2a4693c94=
e3b
        failing since 50 days (last pass: v4.4.243-cip51, first fail: v4.4.=
243-cip51-10-gd7466739b72e9) =

 =



platform            | arch   | lab           | compiler | defconfig        =
            | regressions
--------------------+--------+---------------+----------+------------------=
------------+------------
qemu_arm-virt-gicv3 | arm    | lab-collabora | gcc-8    | multi_v7_defc...C=
ONFIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/5ffff9b8ad5e00457dc94cbd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.249-c=
ip53-9-g5fa136ab4d24/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-collab=
ora/baseline-qemu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.249-c=
ip53-9-g5fa136ab4d24/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-collab=
ora/baseline-qemu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5ffff9b8ad5e00457dc94=
cbe
        failing since 50 days (last pass: v4.4.243-cip51, first fail: v4.4.=
243-cip51-10-gd7466739b72e9) =

 =



platform            | arch   | lab           | compiler | defconfig        =
            | regressions
--------------------+--------+---------------+----------+------------------=
------------+------------
qemu_x86_64         | x86_64 | lab-baylibre  | gcc-8    | x86_64_defconfig =
            | 1          =


  Details:     https://kernelci.org/test/plan/id/5ffff5331b1d321627c94cc0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-8 (gcc (Debian 8.3.0-6) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.249-c=
ip53-9-g5fa136ab4d24/x86_64/x86_64_defconfig/gcc-8/lab-baylibre/baseline-qe=
mu_x86_64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.249-c=
ip53-9-g5fa136ab4d24/x86_64/x86_64_defconfig/gcc-8/lab-baylibre/baseline-qe=
mu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/x86/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5ffff5331b1d321627c94=
cc1
        new failure (last pass: v4.4.249-cip53) =

 =20

--vdHnHub5jsnNfqDvYPml
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6089): https://lists.cip-project.org/g/cip-dev/message=
/6089
Mute This Topic: https://lists.cip-project.org/mt/79674008/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--vdHnHub5jsnNfqDvYPml--
