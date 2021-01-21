Return-Path: <SRS0=me0m=GY=lists.cip-project.org=bounce+64572+6130+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 949DBC433E0
	for <cip-dev@archiver.kernel.org>; Thu, 21 Jan 2021 14:36:44 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F000620691
	for <cip-dev@archiver.kernel.org>; Thu, 21 Jan 2021 14:36:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F000620691
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6130+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id KbTtYY4521723x5WwAp7Ub95; Thu, 21 Jan 2021 06:36:43 -0800
X-Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
 by mx.groups.io with SMTP id smtpd.web11.56.1611239512944490563
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 Jan 2021 06:31:53 -0800
X-Received: by mail-pg1-f170.google.com with SMTP id i5so1480185pgo.1
        for <cip-dev@lists.cip-project.org>; Thu, 21 Jan 2021 06:31:52 -0800 (PST)
X-Gm-Message-State: TTYA9RaeZNrYUfx8q8bbe3xCx4520388AA=
X-Google-Smtp-Source: ABdhPJzf28exR3pgLst9JAR2SRXYMFVQXUUZY4K/SEWq/3dD01vUjIU7EOTaPErdqWCzZbBA1NQ3KA==
X-Received: by 2002:a63:5fcb:: with SMTP id t194mr14452089pgb.394.1611239511812;
        Thu, 21 Jan 2021 06:31:51 -0800 (PST)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b12sm6248050pgr.9.2021.01.21.06.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 06:31:50 -0800 (PST)
Message-ID: <60099056.1c69fb81.ee7dd.e5b3@mx.google.com>
Date: Thu, 21 Jan 2021 06:31:50 -0800 (PST)
MIME-Version: 1.0
X-Kernelci-Branch: linux-4.4.y-cip-rt
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.249-cip53-rt33
Subject: [cip-dev] cip/linux-4.4.y-cip-rt baseline: 118 runs, 17 regressions (v4.4.249-cip53-rt33)
To: cip-dev@lists.cip-project.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="XwqGir0fXfNLQ5qzVE4d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1611239803;
 bh=jEG38n9N+Wkpxy792+Z7l35RtQE0QnGf3kPTP1Z5TbU=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=BSFNKBj1FOhBiiJQyMe3zTuMwdOnZgdEFh9VX9ns5Lp0w1iJagaVcMhxIbVw8lZh7iL
 ISbGfZ8uARJMASqypkBAQPZYAGniV0otDHj/6Dw/slL+tdW2pXJHNhO/pzy3xYDoNiVB9
 J9lm+BMVyxhd3ASUo4jc6ioPVfXjEE5qZhs=

--XwqGir0fXfNLQ5qzVE4d
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.4.y-cip-rt baseline: 118 runs, 17 regressions (v4.4.249-cip53-r=
t33)

Regressions Summary
-------------------

platform            | arch   | lab           | compiler | defconfig        =
            | regressions
--------------------+--------+---------------+----------+------------------=
------------+------------
qemu_arm-virt-gicv2 | arm    | lab-baylibre  | gcc-8    | multi_v7_defc...C=
ONFIG_SMP=3Dn | 1          =

qemu_arm-virt-gicv2 | arm    | lab-baylibre  | gcc-8    | multi_v7_defconfi=
g           | 1          =

qemu_arm-virt-gicv2 | arm    | lab-broonie   | gcc-8    | multi_v7_defc...C=
ONFIG_SMP=3Dn | 1          =

qemu_arm-virt-gicv2 | arm    | lab-broonie   | gcc-8    | multi_v7_defconfi=
g           | 1          =

qemu_arm-virt-gicv2 | arm    | lab-cip       | gcc-8    | multi_v7_defc...C=
ONFIG_SMP=3Dn | 1          =

qemu_arm-virt-gicv2 | arm    | lab-cip       | gcc-8    | multi_v7_defconfi=
g           | 1          =

qemu_arm-virt-gicv2 | arm    | lab-collabora | gcc-8    | multi_v7_defc...C=
ONFIG_SMP=3Dn | 1          =

qemu_arm-virt-gicv2 | arm    | lab-collabora | gcc-8    | multi_v7_defconfi=
g           | 1          =

qemu_arm-virt-gicv3 | arm    | lab-baylibre  | gcc-8    | multi_v7_defc...C=
ONFIG_SMP=3Dn | 1          =

qemu_arm-virt-gicv3 | arm    | lab-baylibre  | gcc-8    | multi_v7_defconfi=
g           | 1          =

qemu_arm-virt-gicv3 | arm    | lab-broonie   | gcc-8    | multi_v7_defc...C=
ONFIG_SMP=3Dn | 1          =

qemu_arm-virt-gicv3 | arm    | lab-broonie   | gcc-8    | multi_v7_defconfi=
g           | 1          =

qemu_arm-virt-gicv3 | arm    | lab-cip       | gcc-8    | multi_v7_defc...C=
ONFIG_SMP=3Dn | 1          =

qemu_arm-virt-gicv3 | arm    | lab-cip       | gcc-8    | multi_v7_defconfi=
g           | 1          =

qemu_arm-virt-gicv3 | arm    | lab-collabora | gcc-8    | multi_v7_defc...C=
ONFIG_SMP=3Dn | 1          =

qemu_arm-virt-gicv3 | arm    | lab-collabora | gcc-8    | multi_v7_defconfi=
g           | 1          =

qemu_x86_64-uefi    | x86_64 | lab-baylibre  | gcc-8    | x86_64_defconfig =
            | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip-rt/ker=
nel/v4.4.249-cip53-rt33/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.4.y-cip-rt
  Describe: v4.4.249-cip53-rt33
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      2f358d27f27c9e54e3f45e48d2c15a6e0ebdf893 =



Test Regressions
---------------- =



platform            | arch   | lab           | compiler | defconfig        =
            | regressions
--------------------+--------+---------------+----------+------------------=
------------+------------
qemu_arm-virt-gicv2 | arm    | lab-baylibre  | gcc-8    | multi_v7_defc...C=
ONFIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/600987f09162044565bb5d0e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.24=
9-cip53-rt33/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-baylibre/basel=
ine-qemu_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.24=
9-cip53-rt33/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-baylibre/basel=
ine-qemu_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/600987f09162044565bb5=
d0f
        failing since 60 days (last pass: v4.4.231-cip47-rt30, first fail: =
v4.4.244-cip51-rt32) =

 =



platform            | arch   | lab           | compiler | defconfig        =
            | regressions
--------------------+--------+---------------+----------+------------------=
------------+------------
qemu_arm-virt-gicv2 | arm    | lab-baylibre  | gcc-8    | multi_v7_defconfi=
g           | 1          =


  Details:     https://kernelci.org/test/plan/id/600988f6d979d9c82ebb5d30

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.24=
9-cip53-rt33/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-qemu_arm-vi=
rt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.24=
9-cip53-rt33/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-qemu_arm-vi=
rt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/600988f6d979d9c82ebb5=
d31
        failing since 60 days (last pass: v4.4.231-cip47-rt30, first fail: =
v4.4.244-cip51-rt32) =

 =



platform            | arch   | lab           | compiler | defconfig        =
            | regressions
--------------------+--------+---------------+----------+------------------=
------------+------------
qemu_arm-virt-gicv2 | arm    | lab-broonie   | gcc-8    | multi_v7_defc...C=
ONFIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/6009884adcafb9aedfbb5d18

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.24=
9-cip53-rt33/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-broonie/baseli=
ne-qemu_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.24=
9-cip53-rt33/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-broonie/baseli=
ne-qemu_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6009884adcafb9aedfbb5=
d19
        failing since 60 days (last pass: v4.4.231-cip47-rt30, first fail: =
v4.4.244-cip51-rt32) =

 =



platform            | arch   | lab           | compiler | defconfig        =
            | regressions
--------------------+--------+---------------+----------+------------------=
------------+------------
qemu_arm-virt-gicv2 | arm    | lab-broonie   | gcc-8    | multi_v7_defconfi=
g           | 1          =


  Details:     https://kernelci.org/test/plan/id/60098a05fb8295fdadbb5d21

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.24=
9-cip53-rt33/arm/multi_v7_defconfig/gcc-8/lab-broonie/baseline-qemu_arm-vir=
t-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.24=
9-cip53-rt33/arm/multi_v7_defconfig/gcc-8/lab-broonie/baseline-qemu_arm-vir=
t-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60098a05fb8295fdadbb5=
d22
        failing since 60 days (last pass: v4.4.231-cip47-rt30, first fail: =
v4.4.244-cip51-rt32) =

 =



platform            | arch   | lab           | compiler | defconfig        =
            | regressions
--------------------+--------+---------------+----------+------------------=
------------+------------
qemu_arm-virt-gicv2 | arm    | lab-cip       | gcc-8    | multi_v7_defc...C=
ONFIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/600987f59162044565bb5d1d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.24=
9-cip53-rt33/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-cip/baseline-q=
emu_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.24=
9-cip53-rt33/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-cip/baseline-q=
emu_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/600987f59162044565bb5=
d1e
        failing since 60 days (last pass: v4.4.231-cip47-rt30, first fail: =
v4.4.244-cip51-rt32) =

 =



platform            | arch   | lab           | compiler | defconfig        =
            | regressions
--------------------+--------+---------------+----------+------------------=
------------+------------
qemu_arm-virt-gicv2 | arm    | lab-cip       | gcc-8    | multi_v7_defconfi=
g           | 1          =


  Details:     https://kernelci.org/test/plan/id/60098931d426712499bb5d0b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.24=
9-cip53-rt33/arm/multi_v7_defconfig/gcc-8/lab-cip/baseline-qemu_arm-virt-gi=
cv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.24=
9-cip53-rt33/arm/multi_v7_defconfig/gcc-8/lab-cip/baseline-qemu_arm-virt-gi=
cv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60098931d426712499bb5=
d0c
        failing since 60 days (last pass: v4.4.231-cip47-rt30, first fail: =
v4.4.244-cip51-rt32) =

 =



platform            | arch   | lab           | compiler | defconfig        =
            | regressions
--------------------+--------+---------------+----------+------------------=
------------+------------
qemu_arm-virt-gicv2 | arm    | lab-collabora | gcc-8    | multi_v7_defc...C=
ONFIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/6009883a3fea4940adbb5d2c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.24=
9-cip53-rt33/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-collabora/base=
line-qemu_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.24=
9-cip53-rt33/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-collabora/base=
line-qemu_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6009883a3fea4940adbb5=
d2d
        failing since 60 days (last pass: v4.4.231-cip47-rt30, first fail: =
v4.4.244-cip51-rt32) =

 =



platform            | arch   | lab           | compiler | defconfig        =
            | regressions
--------------------+--------+---------------+----------+------------------=
------------+------------
qemu_arm-virt-gicv2 | arm    | lab-collabora | gcc-8    | multi_v7_defconfi=
g           | 1          =


  Details:     https://kernelci.org/test/plan/id/6009896622be3f27a6bb5d11

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.24=
9-cip53-rt33/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-qemu_arm-v=
irt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.24=
9-cip53-rt33/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-qemu_arm-v=
irt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6009896622be3f27a6bb5=
d12
        failing since 60 days (last pass: v4.4.231-cip47-rt30, first fail: =
v4.4.244-cip51-rt32) =

 =



platform            | arch   | lab           | compiler | defconfig        =
            | regressions
--------------------+--------+---------------+----------+------------------=
------------+------------
qemu_arm-virt-gicv3 | arm    | lab-baylibre  | gcc-8    | multi_v7_defc...C=
ONFIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/6009880626dbde929bbb5d1a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.24=
9-cip53-rt33/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-baylibre/basel=
ine-qemu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.24=
9-cip53-rt33/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-baylibre/basel=
ine-qemu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6009880626dbde929bbb5=
d1b
        failing since 60 days (last pass: v4.4.235-cip49-rt31, first fail: =
v4.4.244-cip51-rt32) =

 =



platform            | arch   | lab           | compiler | defconfig        =
            | regressions
--------------------+--------+---------------+----------+------------------=
------------+------------
qemu_arm-virt-gicv3 | arm    | lab-baylibre  | gcc-8    | multi_v7_defconfi=
g           | 1          =


  Details:     https://kernelci.org/test/plan/id/60098950bc5afdc73abb5d0b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.24=
9-cip53-rt33/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-qemu_arm-vi=
rt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.24=
9-cip53-rt33/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-qemu_arm-vi=
rt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60098950bc5afdc73abb5=
d0c
        failing since 60 days (last pass: v4.4.231-cip47-rt30, first fail: =
v4.4.244-cip51-rt32) =

 =



platform            | arch   | lab           | compiler | defconfig        =
            | regressions
--------------------+--------+---------------+----------+------------------=
------------+------------
qemu_arm-virt-gicv3 | arm    | lab-broonie   | gcc-8    | multi_v7_defc...C=
ONFIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/60098845aa6f266437bb5d2f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.24=
9-cip53-rt33/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-broonie/baseli=
ne-qemu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.24=
9-cip53-rt33/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-broonie/baseli=
ne-qemu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60098845aa6f266437bb5=
d30
        failing since 60 days (last pass: v4.4.235-cip49-rt31, first fail: =
v4.4.244-cip51-rt32) =

 =



platform            | arch   | lab           | compiler | defconfig        =
            | regressions
--------------------+--------+---------------+----------+------------------=
------------+------------
qemu_arm-virt-gicv3 | arm    | lab-broonie   | gcc-8    | multi_v7_defconfi=
g           | 1          =


  Details:     https://kernelci.org/test/plan/id/60098a436ea22e28aebb5d29

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.24=
9-cip53-rt33/arm/multi_v7_defconfig/gcc-8/lab-broonie/baseline-qemu_arm-vir=
t-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.24=
9-cip53-rt33/arm/multi_v7_defconfig/gcc-8/lab-broonie/baseline-qemu_arm-vir=
t-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60098a436ea22e28aebb5=
d2a
        failing since 60 days (last pass: v4.4.231-cip47-rt30, first fail: =
v4.4.244-cip51-rt32) =

 =



platform            | arch   | lab           | compiler | defconfig        =
            | regressions
--------------------+--------+---------------+----------+------------------=
------------+------------
qemu_arm-virt-gicv3 | arm    | lab-cip       | gcc-8    | multi_v7_defc...C=
ONFIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/600988009162044565bb5d3e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.24=
9-cip53-rt33/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-cip/baseline-q=
emu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.24=
9-cip53-rt33/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-cip/baseline-q=
emu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/600988009162044565bb5=
d3f
        failing since 60 days (last pass: v4.4.235-cip49-rt31, first fail: =
v4.4.244-cip51-rt32) =

 =



platform            | arch   | lab           | compiler | defconfig        =
            | regressions
--------------------+--------+---------------+----------+------------------=
------------+------------
qemu_arm-virt-gicv3 | arm    | lab-cip       | gcc-8    | multi_v7_defconfi=
g           | 1          =


  Details:     https://kernelci.org/test/plan/id/600989cbaa800c9b1abb5d0c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.24=
9-cip53-rt33/arm/multi_v7_defconfig/gcc-8/lab-cip/baseline-qemu_arm-virt-gi=
cv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.24=
9-cip53-rt33/arm/multi_v7_defconfig/gcc-8/lab-cip/baseline-qemu_arm-virt-gi=
cv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/600989cbaa800c9b1abb5=
d0d
        failing since 60 days (last pass: v4.4.231-cip47-rt30, first fail: =
v4.4.244-cip51-rt32) =

 =



platform            | arch   | lab           | compiler | defconfig        =
            | regressions
--------------------+--------+---------------+----------+------------------=
------------+------------
qemu_arm-virt-gicv3 | arm    | lab-collabora | gcc-8    | multi_v7_defc...C=
ONFIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/6009883caa6f266437bb5d1d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.24=
9-cip53-rt33/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-collabora/base=
line-qemu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.24=
9-cip53-rt33/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-collabora/base=
line-qemu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6009883caa6f266437bb5=
d1e
        failing since 60 days (last pass: v4.4.235-cip49-rt31, first fail: =
v4.4.244-cip51-rt32) =

 =



platform            | arch   | lab           | compiler | defconfig        =
            | regressions
--------------------+--------+---------------+----------+------------------=
------------+------------
qemu_arm-virt-gicv3 | arm    | lab-collabora | gcc-8    | multi_v7_defconfi=
g           | 1          =


  Details:     https://kernelci.org/test/plan/id/600989fbfb8295fdadbb5d10

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.24=
9-cip53-rt33/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-qemu_arm-v=
irt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.24=
9-cip53-rt33/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-qemu_arm-v=
irt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/600989fbfb8295fdadbb5=
d11
        failing since 60 days (last pass: v4.4.231-cip47-rt30, first fail: =
v4.4.244-cip51-rt32) =

 =



platform            | arch   | lab           | compiler | defconfig        =
            | regressions
--------------------+--------+---------------+----------+------------------=
------------+------------
qemu_x86_64-uefi    | x86_64 | lab-baylibre  | gcc-8    | x86_64_defconfig =
            | 1          =


  Details:     https://kernelci.org/test/plan/id/6009887c881db03f80bb5d33

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-8 (gcc (Debian 8.3.0-6) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.24=
9-cip53-rt33/x86_64/x86_64_defconfig/gcc-8/lab-baylibre/baseline-qemu_x86_6=
4-uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.24=
9-cip53-rt33/x86_64/x86_64_defconfig/gcc-8/lab-baylibre/baseline-qemu_x86_6=
4-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/x86/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6009887c881db03f80bb5=
d34
        new failure (last pass: v4.4.244-cip51-rt32) =

 =20

--XwqGir0fXfNLQ5qzVE4d
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6130): https://lists.cip-project.org/g/cip-dev/message=
/6130
Mute This Topic: https://lists.cip-project.org/mt/80004781/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--XwqGir0fXfNLQ5qzVE4d--
