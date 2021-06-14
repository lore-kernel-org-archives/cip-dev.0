Return-Path: <SRS0=6B/c=LI=lists.cip-project.org=bounce+64572+6519+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085C5C4743C
	for <cip-dev@archiver.kernel.org>; Mon, 14 Jun 2021 16:02:45 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92D6D6120E
	for <cip-dev@archiver.kernel.org>; Mon, 14 Jun 2021 16:02:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92D6D6120E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6519+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id LkCjYY4521723xn4oNdb8CAo; Mon, 14 Jun 2021 09:02:44 -0700
X-Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web09.32268.1623686563744253043
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 14 Jun 2021 09:02:43 -0700
X-Received: by mail-pl1-f182.google.com with SMTP id h12so6810455plf.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 14 Jun 2021 09:02:43 -0700 (PDT)
X-Gm-Message-State: 97GbYf2OSFa54dgL4r0m6a38x4520388AA=
X-Google-Smtp-Source: ABdhPJxSNT8EzSZGVW6Wm1EeTYRy0Uyvfj1gxRIA5DUjgcNGqLjVSD7DrVzsB8n09R459/CorhEgRw==
X-Received: by 2002:a17:902:a70f:b029:ea:d4a8:6a84 with SMTP id w15-20020a170902a70fb02900ead4a86a84mr17563859plq.42.1623686563065;
        Mon, 14 Jun 2021 09:02:43 -0700 (PDT)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b80sm9686842pfb.151.2021.06.14.09.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 09:02:42 -0700 (PDT)
Message-ID: <60c77da2.1c69fb81.6b776.afb2@mx.google.com>
Date: Mon, 14 Jun 2021 09:02:42 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.272-cip58
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Tree: cip
Subject: [cip-dev] cip/linux-4.4.y-cip baseline: 82 runs, 11 regressions (v4.4.272-cip58) #kernelci
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
Content-Type: multipart/mixed; boundary="5v1mmxmzZeu5zbJ2lnJx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1623686564;
 bh=MYYJDAZ+D4KB8A5+/jPM1pBqxCnDsvVqT2zMDNeuuhs=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=asFJ0OdqUOcl6RFIU225yE+WF44/4gRLpsjdrDBZHZ7IzBAcQfnvx+atVTrKeP/9cWZ
 55xxqaJ5W1C6eZL1yJf63dCNQI7SyN/pI6qi/enWgWQcc1pT8rv12egnuWsAw50j25n58
 3z317+ILpNBVznABihU6vVJJtdaTmG60zgo=

--5v1mmxmzZeu5zbJ2lnJx
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.4.y-cip baseline: 82 runs, 11 regressions (v4.4.272-cip58)

Regressions Summary
-------------------

platform            | arch | lab             | compiler | defconfig        =
            | regressions
--------------------+------+-----------------+----------+------------------=
------------+------------
dove-cubox          | arm  | lab-pengutronix | gcc-8    | mvebu_v7_defconfi=
g           | 1          =

qemu_arm-virt-gicv2 | arm  | lab-baylibre    | gcc-8    | multi_v7_defc...C=
ONFIG_SMP=3Dn | 1          =

qemu_arm-virt-gicv2 | arm  | lab-baylibre    | gcc-8    | multi_v7_defconfi=
g           | 1          =

qemu_arm-virt-gicv2 | arm  | lab-broonie     | gcc-8    | multi_v7_defc...C=
ONFIG_SMP=3Dn | 1          =

qemu_arm-virt-gicv2 | arm  | lab-cip         | gcc-8    | multi_v7_defc...C=
ONFIG_SMP=3Dn | 1          =

qemu_arm-virt-gicv2 | arm  | lab-cip         | gcc-8    | multi_v7_defconfi=
g           | 1          =

qemu_arm-virt-gicv3 | arm  | lab-baylibre    | gcc-8    | multi_v7_defc...C=
ONFIG_SMP=3Dn | 1          =

qemu_arm-virt-gicv3 | arm  | lab-baylibre    | gcc-8    | multi_v7_defconfi=
g           | 1          =

qemu_arm-virt-gicv3 | arm  | lab-broonie     | gcc-8    | multi_v7_defc...C=
ONFIG_SMP=3Dn | 1          =

qemu_arm-virt-gicv3 | arm  | lab-cip         | gcc-8    | multi_v7_defc...C=
ONFIG_SMP=3Dn | 1          =

qemu_arm-virt-gicv3 | arm  | lab-cip         | gcc-8    | multi_v7_defconfi=
g           | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.272-cip58/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.272-cip58
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      91a8e96603d53c19b112388602066978c42cdc97 =



Test Regressions
---------------- =



platform            | arch | lab             | compiler | defconfig        =
            | regressions
--------------------+------+-----------------+----------+------------------=
------------+------------
dove-cubox          | arm  | lab-pengutronix | gcc-8    | mvebu_v7_defconfi=
g           | 1          =


  Details:     https://kernelci.org/test/plan/id/60c7749641d4609197413267

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: mvebu_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.272-c=
ip58/arm/mvebu_v7_defconfig/gcc-8/lab-pengutronix/baseline-dove-cubox.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.272-c=
ip58/arm/mvebu_v7_defconfig/gcc-8/lab-pengutronix/baseline-dove-cubox.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60c7749641d4609197413=
268
        new failure (last pass: v4.4.268-cip57) =

 =



platform            | arch | lab             | compiler | defconfig        =
            | regressions
--------------------+------+-----------------+----------+------------------=
------------+------------
qemu_arm-virt-gicv2 | arm  | lab-baylibre    | gcc-8    | multi_v7_defc...C=
ONFIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/60c773c670f1bbd822413282

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.272-c=
ip58/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-baylibre/baseline-qemu=
_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.272-c=
ip58/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-baylibre/baseline-qemu=
_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60c773c670f1bbd822413=
283
        failing since 201 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab             | compiler | defconfig        =
            | regressions
--------------------+------+-----------------+----------+------------------=
------------+------------
qemu_arm-virt-gicv2 | arm  | lab-baylibre    | gcc-8    | multi_v7_defconfi=
g           | 1          =


  Details:     https://kernelci.org/test/plan/id/60c774b74a0de5cdc14132a2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.272-c=
ip58/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-qemu_arm-virt-gicv2=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.272-c=
ip58/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-qemu_arm-virt-gicv2=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60c774b74a0de5cdc1413=
2a3
        failing since 201 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab             | compiler | defconfig        =
            | regressions
--------------------+------+-----------------+----------+------------------=
------------+------------
qemu_arm-virt-gicv2 | arm  | lab-broonie     | gcc-8    | multi_v7_defc...C=
ONFIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/60c77ced48e07057684132a2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.272-c=
ip58/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-broonie/baseline-qemu_=
arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.272-c=
ip58/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-broonie/baseline-qemu_=
arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60c77ced48e0705768413=
2a3
        failing since 201 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab             | compiler | defconfig        =
            | regressions
--------------------+------+-----------------+----------+------------------=
------------+------------
qemu_arm-virt-gicv2 | arm  | lab-cip         | gcc-8    | multi_v7_defc...C=
ONFIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/60c7736c87a1e4d3d041326a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.272-c=
ip58/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-cip/baseline-qemu_arm-=
virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.272-c=
ip58/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-cip/baseline-qemu_arm-=
virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60c7736c87a1e4d3d0413=
26b
        failing since 201 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab             | compiler | defconfig        =
            | regressions
--------------------+------+-----------------+----------+------------------=
------------+------------
qemu_arm-virt-gicv2 | arm  | lab-cip         | gcc-8    | multi_v7_defconfi=
g           | 1          =


  Details:     https://kernelci.org/test/plan/id/60c774697c17886318413275

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.272-c=
ip58/arm/multi_v7_defconfig/gcc-8/lab-cip/baseline-qemu_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.272-c=
ip58/arm/multi_v7_defconfig/gcc-8/lab-cip/baseline-qemu_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60c774697c17886318413=
276
        failing since 201 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab             | compiler | defconfig        =
            | regressions
--------------------+------+-----------------+----------+------------------=
------------+------------
qemu_arm-virt-gicv3 | arm  | lab-baylibre    | gcc-8    | multi_v7_defc...C=
ONFIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/60c773c71dabdd0f1c413297

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.272-c=
ip58/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-baylibre/baseline-qemu=
_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.272-c=
ip58/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-baylibre/baseline-qemu=
_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60c773c71dabdd0f1c413=
298
        failing since 201 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab             | compiler | defconfig        =
            | regressions
--------------------+------+-----------------+----------+------------------=
------------+------------
qemu_arm-virt-gicv3 | arm  | lab-baylibre    | gcc-8    | multi_v7_defconfi=
g           | 1          =


  Details:     https://kernelci.org/test/plan/id/60c77543389e06fca1413277

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.272-c=
ip58/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-qemu_arm-virt-gicv3=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.272-c=
ip58/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-qemu_arm-virt-gicv3=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60c77543389e06fca1413=
278
        failing since 201 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab             | compiler | defconfig        =
            | regressions
--------------------+------+-----------------+----------+------------------=
------------+------------
qemu_arm-virt-gicv3 | arm  | lab-broonie     | gcc-8    | multi_v7_defc...C=
ONFIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/60c77d156f683cfcc0413282

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.272-c=
ip58/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-broonie/baseline-qemu_=
arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.272-c=
ip58/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-broonie/baseline-qemu_=
arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60c77d156f683cfcc0413=
283
        failing since 201 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab             | compiler | defconfig        =
            | regressions
--------------------+------+-----------------+----------+------------------=
------------+------------
qemu_arm-virt-gicv3 | arm  | lab-cip         | gcc-8    | multi_v7_defc...C=
ONFIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/60c77399f528c79ced4132ee

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.272-c=
ip58/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-cip/baseline-qemu_arm-=
virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.272-c=
ip58/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-cip/baseline-qemu_arm-=
virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60c77399f528c79ced413=
2ef
        failing since 201 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab             | compiler | defconfig        =
            | regressions
--------------------+------+-----------------+----------+------------------=
------------+------------
qemu_arm-virt-gicv3 | arm  | lab-cip         | gcc-8    | multi_v7_defconfi=
g           | 1          =


  Details:     https://kernelci.org/test/plan/id/60c774e1211c2a460941328c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.272-c=
ip58/arm/multi_v7_defconfig/gcc-8/lab-cip/baseline-qemu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.272-c=
ip58/arm/multi_v7_defconfig/gcc-8/lab-cip/baseline-qemu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60c774e1211c2a4609413=
28d
        failing since 201 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =20

--5v1mmxmzZeu5zbJ2lnJx
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6519): https://lists.cip-project.org/g/cip-dev/message=
/6519
Mute This Topic: https://lists.cip-project.org/mt/83533958/4520388
Mute #kernelci:https://lists.cip-project.org/g/cip-dev/mutehashtag/kernelc=
i
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--5v1mmxmzZeu5zbJ2lnJx--
