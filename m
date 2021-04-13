Return-Path: <SRS0=MJ64=JK=lists.cip-project.org=bounce+64572+6367+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060AEC433ED
	for <cip-dev@archiver.kernel.org>; Tue, 13 Apr 2021 11:03:05 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62F20613B7
	for <cip-dev@archiver.kernel.org>; Tue, 13 Apr 2021 11:03:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62F20613B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6367+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id XZilYY4521723xrf9sSoxtc3; Tue, 13 Apr 2021 04:03:04 -0700
X-Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
 by mx.groups.io with SMTP id smtpd.web08.7322.1618311783516863229
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 13 Apr 2021 04:03:03 -0700
X-Received: by mail-pj1-f53.google.com with SMTP id k23-20020a17090a5917b02901043e35ad4aso10490106pji.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 13 Apr 2021 04:03:03 -0700 (PDT)
X-Gm-Message-State: hLQvqitDym2ZlGSTjU6y4FtTx4520388AA=
X-Google-Smtp-Source: ABdhPJw+muNgDwDIBcALOveYJcRC1l+0D5zgnzXcTrikUikpHNWAze+TiRqXDhUKB9VVs9Iwd610yA==
X-Received: by 2002:a17:90a:4593:: with SMTP id v19mr4159194pjg.207.1618311782543;
        Tue, 13 Apr 2021 04:03:02 -0700 (PDT)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 11sm2191772pjm.0.2021.04.13.04.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 04:03:02 -0700 (PDT)
Message-ID: <60757a66.1c69fb81.f7316.6318@mx.google.com>
Date: Tue, 13 Apr 2021 04:03:02 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.266-cip56
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Tree: cip
Subject: [cip-dev] cip/linux-4.4.y-cip baseline: 107 runs, 13 regressions (v4.4.266-cip56) #kernelci
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
Content-Type: multipart/mixed; boundary="YhlBD0H9Yv8yvSqWSXr5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1618311784;
 bh=WXyNhRyXxMR9RdR698qnFjdVdiMt2j7hnE1mmc9DKwc=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=tK/8BskDBrZWW3JJwKRsDxu7UbTIrF3nnSM4wSkA9ts6O3txnBx1Ees11Qn8phfPXj0
 yZPtynVg+4phoTSuI0DYfQc9WpivNadyDua4ou0KbrzmXPmr8vLSk5IpDrcbRXOmhGCxi
 YOuCVuGGO/RM2aUqRdWXk2s0JRmxuzpSwSQ=

--YhlBD0H9Yv8yvSqWSXr5
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.4.y-cip baseline: 107 runs, 13 regressions (v4.4.266-cip56)

Regressions Summary
-------------------

platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
panda               | arm  | lab-collabora | gcc-8    | omap2plus_defconfig=
          | 1          =

qemu_arm-virt-gicv2 | arm  | lab-baylibre  | gcc-8    | multi_v7_defconfig =
          | 1          =

qemu_arm-virt-gicv2 | arm  | lab-baylibre  | gcc-8    | multi_v7_defc...CON=
FIG_SMP=3Dn | 1          =

qemu_arm-virt-gicv2 | arm  | lab-cip       | gcc-8    | multi_v7_defconfig =
          | 1          =

qemu_arm-virt-gicv2 | arm  | lab-cip       | gcc-8    | multi_v7_defc...CON=
FIG_SMP=3Dn | 1          =

qemu_arm-virt-gicv2 | arm  | lab-collabora | gcc-8    | multi_v7_defconfig =
          | 1          =

qemu_arm-virt-gicv2 | arm  | lab-collabora | gcc-8    | multi_v7_defc...CON=
FIG_SMP=3Dn | 1          =

qemu_arm-virt-gicv3 | arm  | lab-baylibre  | gcc-8    | multi_v7_defconfig =
          | 1          =

qemu_arm-virt-gicv3 | arm  | lab-baylibre  | gcc-8    | multi_v7_defc...CON=
FIG_SMP=3Dn | 1          =

qemu_arm-virt-gicv3 | arm  | lab-cip       | gcc-8    | multi_v7_defconfig =
          | 1          =

qemu_arm-virt-gicv3 | arm  | lab-cip       | gcc-8    | multi_v7_defc...CON=
FIG_SMP=3Dn | 1          =

qemu_arm-virt-gicv3 | arm  | lab-collabora | gcc-8    | multi_v7_defconfig =
          | 1          =

qemu_arm-virt-gicv3 | arm  | lab-collabora | gcc-8    | multi_v7_defc...CON=
FIG_SMP=3Dn | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.266-cip56/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.266-cip56
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      cd5f211fda95e43a37ce2bf1d58486233641da9b =



Test Regressions
---------------- =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
panda               | arm  | lab-collabora | gcc-8    | omap2plus_defconfig=
          | 1          =


  Details:     https://kernelci.org/test/plan/id/607571f89b54cb9fdcdac725

  Results:     3 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.266-c=
ip56/arm/omap2plus_defconfig/gcc-8/lab-collabora/baseline-panda.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.266-c=
ip56/arm/omap2plus_defconfig/gcc-8/lab-collabora/baseline-panda.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/607571f89b54cb9=
fdcdac72c
        new failure (last pass: v4.4.262-cip55)
        2 lines

    2021-04-13 10:27:00.896000+00:00  kern  :emerg :  lock: emif_lock+0x0/0=
xfffff26c [emif], .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0   =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv2 | arm  | lab-baylibre  | gcc-8    | multi_v7_defconfig =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/607571513bccaffd21dac708

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.266-c=
ip56/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-qemu_arm-virt-gicv2=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.266-c=
ip56/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-qemu_arm-virt-gicv2=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/607571513bccaffd21dac=
709
        failing since 139 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv2 | arm  | lab-baylibre  | gcc-8    | multi_v7_defc...CON=
FIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/607572bba9c9c2cdb2dac6b4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.266-c=
ip56/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-baylibre/baseline-qemu=
_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.266-c=
ip56/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-baylibre/baseline-qemu=
_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/607572bba9c9c2cdb2dac=
6b5
        failing since 139 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv2 | arm  | lab-cip       | gcc-8    | multi_v7_defconfig =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/6075717d27e9efb168dac701

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.266-c=
ip56/arm/multi_v7_defconfig/gcc-8/lab-cip/baseline-qemu_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.266-c=
ip56/arm/multi_v7_defconfig/gcc-8/lab-cip/baseline-qemu_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6075717d27e9efb168dac=
702
        failing since 139 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv2 | arm  | lab-cip       | gcc-8    | multi_v7_defc...CON=
FIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/6075731cb6f5a6c597dac6bc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.266-c=
ip56/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-cip/baseline-qemu_arm-=
virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.266-c=
ip56/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-cip/baseline-qemu_arm-=
virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6075731cb6f5a6c597dac=
6bd
        failing since 139 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv2 | arm  | lab-collabora | gcc-8    | multi_v7_defconfig =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/607571572ca80ca362dac6cf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.266-c=
ip56/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-qemu_arm-virt-gicv=
2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.266-c=
ip56/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-qemu_arm-virt-gicv=
2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/607571572ca80ca362dac=
6d0
        failing since 139 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv2 | arm  | lab-collabora | gcc-8    | multi_v7_defc...CON=
FIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/6075738229fdc08f15dac6be

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.266-c=
ip56/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-collabora/baseline-qem=
u_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.266-c=
ip56/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-collabora/baseline-qem=
u_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6075738229fdc08f15dac=
6bf
        failing since 139 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv3 | arm  | lab-baylibre  | gcc-8    | multi_v7_defconfig =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/607571c99b54cb9fdcdac6b5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.266-c=
ip56/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-qemu_arm-virt-gicv3=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.266-c=
ip56/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-qemu_arm-virt-gicv3=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/607571c99b54cb9fdcdac=
6b6
        failing since 139 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv3 | arm  | lab-baylibre  | gcc-8    | multi_v7_defc...CON=
FIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/607572a5c06d8d952bdac816

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.266-c=
ip56/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-baylibre/baseline-qemu=
_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.266-c=
ip56/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-baylibre/baseline-qemu=
_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/607572a5c06d8d952bdac=
817
        failing since 139 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv3 | arm  | lab-cip       | gcc-8    | multi_v7_defconfig =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/607571fe9b54cb9fdcdac731

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.266-c=
ip56/arm/multi_v7_defconfig/gcc-8/lab-cip/baseline-qemu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.266-c=
ip56/arm/multi_v7_defconfig/gcc-8/lab-cip/baseline-qemu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/607571fe9b54cb9fdcdac=
732
        failing since 139 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv3 | arm  | lab-cip       | gcc-8    | multi_v7_defc...CON=
FIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/607572bd1451302ca2dac6b3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.266-c=
ip56/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-cip/baseline-qemu_arm-=
virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.266-c=
ip56/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-cip/baseline-qemu_arm-=
virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/607572bd1451302ca2dac=
6b4
        failing since 139 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv3 | arm  | lab-collabora | gcc-8    | multi_v7_defconfig =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/60757258f4bd5a6a6fdac722

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.266-c=
ip56/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-qemu_arm-virt-gicv=
3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.266-c=
ip56/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-qemu_arm-virt-gicv=
3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60757258f4bd5a6a6fdac=
723
        failing since 139 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv3 | arm  | lab-collabora | gcc-8    | multi_v7_defc...CON=
FIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/6075731da17fc368d8dac6bf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.266-c=
ip56/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-collabora/baseline-qem=
u_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.266-c=
ip56/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-collabora/baseline-qem=
u_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6075731da17fc368d8dac=
6c0
        failing since 139 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =20

--YhlBD0H9Yv8yvSqWSXr5
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6367): https://lists.cip-project.org/g/cip-dev/message=
/6367
Mute This Topic: https://lists.cip-project.org/mt/82061853/4520388
Mute #kernelci:https://lists.cip-project.org/g/cip-dev/mutehashtag/kernelc=
i
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--YhlBD0H9Yv8yvSqWSXr5--
