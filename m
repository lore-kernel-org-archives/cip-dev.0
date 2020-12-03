Return-Path: <SRS0=rxBE=FH=lists.cip-project.org=bounce+64572+5940+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CB8C63777
	for <cip-dev@archiver.kernel.org>; Thu,  3 Dec 2020 11:14:39 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F382221D91
	for <cip-dev@archiver.kernel.org>; Thu,  3 Dec 2020 11:14:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F382221D91
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5940+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id gTafYY4521723xTGezZJJUNO; Thu, 03 Dec 2020 03:14:37 -0800
X-Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.web11.5855.1606971758165406386
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Dec 2020 21:02:38 -0800
X-Received: by mail-pf1-f169.google.com with SMTP id 131so494242pfb.9
        for <cip-dev@lists.cip-project.org>; Wed, 02 Dec 2020 21:02:38 -0800 (PST)
X-Gm-Message-State: 7dpqsyVnmXU6irrxVJ254tRgx4520388AA=
X-Google-Smtp-Source: ABdhPJy261GRxiUM9psOX/sY/Ic/4mYSKkba4ZgFY8oqYAtAXMPIO63x21Vg5PCgBYRFooJDlCE9Tw==
X-Received: by 2002:aa7:8699:0:b029:19d:a259:d99a with SMTP id d25-20020aa786990000b029019da259d99amr577743pfo.24.1606971757101;
        Wed, 02 Dec 2020 21:02:37 -0800 (PST)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a12sm109868pfl.191.2020.12.02.21.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 21:02:36 -0800 (PST)
Message-ID: <5fc8716c.1c69fb81.84407.0412@mx.google.com>
Date: Wed, 02 Dec 2020 21:02:36 -0800 (PST)
MIME-Version: 1.0
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.4.243-cip51-21-g1d9a9094c010
X-Kernelci-Report-Type: test
Subject: [cip-dev] cip/linux-4.4.y-cip baseline: 117 runs, 15 regressions (v4.4.243-cip51-21-g1d9a9094c010)
To: cip-dev@lists.cip-project.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="Zi9A9w6VyGEFI4R2aSW3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606994077;
 bh=0yhy5TQ37URUKhP+GoFGQaZwdpFSuQh/rMxqBXPojvk=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=pDtyU8ACCx87y9yHVGPT+pbZXEoH/PclPGjSgfI3UsK6V/4sbF5URwmV4H5ESzjXnrq
 /nzaz5sbSsg+kvzdbExpuclYaewDQFScVvHxfrMtAqhpeCnGuP6B4cmGxhYzx7Ie6+S9A
 LQPG80+JFcj2GWeJ0BvRV0pHWPIzNF+f0T4=

--Zi9A9w6VyGEFI4R2aSW3
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.4.y-cip baseline: 117 runs, 15 regressions (v4.4.243-cip51-21-g=
1d9a9094c010)

Regressions Summary
-------------------

platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
beagle-xm           | arm  | lab-baylibre  | gcc-8    | multi_v7_defconfig =
          | 1          =

qemu_arm-virt-gicv2 | arm  | lab-baylibre  | gcc-8    | multi_v7_defconfig =
          | 1          =

qemu_arm-virt-gicv2 | arm  | lab-baylibre  | gcc-8    | multi_v7_defc...CON=
FIG_SMP=3Dn | 1          =

qemu_arm-virt-gicv2 | arm  | lab-broonie   | gcc-8    | multi_v7_defconfig =
          | 1          =

qemu_arm-virt-gicv2 | arm  | lab-broonie   | gcc-8    | multi_v7_defc...CON=
FIG_SMP=3Dn | 1          =

qemu_arm-virt-gicv2 | arm  | lab-cip       | gcc-8    | multi_v7_defconfig =
          | 1          =

qemu_arm-virt-gicv2 | arm  | lab-cip       | gcc-8    | multi_v7_defc...CON=
FIG_SMP=3Dn | 1          =

qemu_arm-virt-gicv2 | arm  | lab-collabora | gcc-8    | multi_v7_defconfig =
          | 1          =

qemu_arm-virt-gicv3 | arm  | lab-baylibre  | gcc-8    | multi_v7_defconfig =
          | 1          =

qemu_arm-virt-gicv3 | arm  | lab-baylibre  | gcc-8    | multi_v7_defc...CON=
FIG_SMP=3Dn | 1          =

qemu_arm-virt-gicv3 | arm  | lab-broonie   | gcc-8    | multi_v7_defconfig =
          | 1          =

qemu_arm-virt-gicv3 | arm  | lab-broonie   | gcc-8    | multi_v7_defc...CON=
FIG_SMP=3Dn | 1          =

qemu_arm-virt-gicv3 | arm  | lab-cip       | gcc-8    | multi_v7_defconfig =
          | 1          =

qemu_arm-virt-gicv3 | arm  | lab-cip       | gcc-8    | multi_v7_defc...CON=
FIG_SMP=3Dn | 1          =

qemu_arm-virt-gicv3 | arm  | lab-collabora | gcc-8    | multi_v7_defconfig =
          | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.243-cip51-21-g1d9a9094c010/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.243-cip51-21-g1d9a9094c010
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      1d9a9094c01054b624cd936e8b130a2c27e38c49 =



Test Regressions
---------------- =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
beagle-xm           | arm  | lab-baylibre  | gcc-8    | multi_v7_defconfig =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/5fc869da05de919409c94cd4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.243-c=
ip51-21-g1d9a9094c010/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-be=
agle-xm.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.243-c=
ip51-21-g1d9a9094c010/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-be=
agle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5fc869da05de919409c94=
cd5
        new failure (last pass: v4.4.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv2 | arm  | lab-baylibre  | gcc-8    | multi_v7_defconfig =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/5fc8690820b4b4e275c94d76

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.243-c=
ip51-21-g1d9a9094c010/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-qe=
mu_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.243-c=
ip51-21-g1d9a9094c010/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-qe=
mu_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5fc8690820b4b4e275c94=
d77
        failing since 7 days (last pass: v4.4.243-cip51, first fail: v4.4.2=
43-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv2 | arm  | lab-baylibre  | gcc-8    | multi_v7_defc...CON=
FIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/5fc86a19805158d8c1c94cc4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.243-c=
ip51-21-g1d9a9094c010/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-bayli=
bre/baseline-qemu_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.243-c=
ip51-21-g1d9a9094c010/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-bayli=
bre/baseline-qemu_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5fc86a19805158d8c1c94=
cc5
        failing since 7 days (last pass: v4.4.243-cip51, first fail: v4.4.2=
43-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv2 | arm  | lab-broonie   | gcc-8    | multi_v7_defconfig =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/5fc8699a4debac6ffbc94cd7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.243-c=
ip51-21-g1d9a9094c010/arm/multi_v7_defconfig/gcc-8/lab-broonie/baseline-qem=
u_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.243-c=
ip51-21-g1d9a9094c010/arm/multi_v7_defconfig/gcc-8/lab-broonie/baseline-qem=
u_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5fc8699a4debac6ffbc94=
cd8
        failing since 7 days (last pass: v4.4.243-cip51, first fail: v4.4.2=
43-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv2 | arm  | lab-broonie   | gcc-8    | multi_v7_defc...CON=
FIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/5fc86b40549f339b71c94ce1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.243-c=
ip51-21-g1d9a9094c010/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-broon=
ie/baseline-qemu_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.243-c=
ip51-21-g1d9a9094c010/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-broon=
ie/baseline-qemu_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5fc86b40549f339b71c94=
ce2
        failing since 7 days (last pass: v4.4.243-cip51, first fail: v4.4.2=
43-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv2 | arm  | lab-cip       | gcc-8    | multi_v7_defconfig =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/5fc868f3e91ba010cac94cfd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.243-c=
ip51-21-g1d9a9094c010/arm/multi_v7_defconfig/gcc-8/lab-cip/baseline-qemu_ar=
m-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.243-c=
ip51-21-g1d9a9094c010/arm/multi_v7_defconfig/gcc-8/lab-cip/baseline-qemu_ar=
m-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5fc868f3e91ba010cac94=
cfe
        failing since 7 days (last pass: v4.4.243-cip51, first fail: v4.4.2=
43-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv2 | arm  | lab-cip       | gcc-8    | multi_v7_defc...CON=
FIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/5fc86a0d51dca9c0f1c94cc7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.243-c=
ip51-21-g1d9a9094c010/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-cip/b=
aseline-qemu_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.243-c=
ip51-21-g1d9a9094c010/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-cip/b=
aseline-qemu_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5fc86a0d51dca9c0f1c94=
cc8
        failing since 7 days (last pass: v4.4.243-cip51, first fail: v4.4.2=
43-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv2 | arm  | lab-collabora | gcc-8    | multi_v7_defconfig =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/5fc86f7e1b7fc47ffec94ce7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.243-c=
ip51-21-g1d9a9094c010/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-q=
emu_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.243-c=
ip51-21-g1d9a9094c010/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-q=
emu_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5fc86f7e1b7fc47ffec94=
ce8
        failing since 7 days (last pass: v4.4.243-cip51, first fail: v4.4.2=
43-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv3 | arm  | lab-baylibre  | gcc-8    | multi_v7_defconfig =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/5fc8690920b4b4e275c94d79

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.243-c=
ip51-21-g1d9a9094c010/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-qe=
mu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.243-c=
ip51-21-g1d9a9094c010/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-qe=
mu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5fc8690920b4b4e275c94=
d7a
        failing since 7 days (last pass: v4.4.243-cip51, first fail: v4.4.2=
43-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv3 | arm  | lab-baylibre  | gcc-8    | multi_v7_defc...CON=
FIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/5fc869f0d1fc0afa02c94cc0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.243-c=
ip51-21-g1d9a9094c010/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-bayli=
bre/baseline-qemu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.243-c=
ip51-21-g1d9a9094c010/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-bayli=
bre/baseline-qemu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5fc869f0d1fc0afa02c94=
cc1
        failing since 7 days (last pass: v4.4.243-cip51, first fail: v4.4.2=
43-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv3 | arm  | lab-broonie   | gcc-8    | multi_v7_defconfig =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/5fc869218be7fe092fc94cc8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.243-c=
ip51-21-g1d9a9094c010/arm/multi_v7_defconfig/gcc-8/lab-broonie/baseline-qem=
u_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.243-c=
ip51-21-g1d9a9094c010/arm/multi_v7_defconfig/gcc-8/lab-broonie/baseline-qem=
u_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5fc869218be7fe092fc94=
cc9
        failing since 7 days (last pass: v4.4.243-cip51, first fail: v4.4.2=
43-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv3 | arm  | lab-broonie   | gcc-8    | multi_v7_defc...CON=
FIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/5fc86a8529909f332ac94cc3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.243-c=
ip51-21-g1d9a9094c010/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-broon=
ie/baseline-qemu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.243-c=
ip51-21-g1d9a9094c010/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-broon=
ie/baseline-qemu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5fc86a8529909f332ac94=
cc4
        failing since 7 days (last pass: v4.4.243-cip51, first fail: v4.4.2=
43-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv3 | arm  | lab-cip       | gcc-8    | multi_v7_defconfig =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/5fc868e9f574d1aad3c94cdb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.243-c=
ip51-21-g1d9a9094c010/arm/multi_v7_defconfig/gcc-8/lab-cip/baseline-qemu_ar=
m-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.243-c=
ip51-21-g1d9a9094c010/arm/multi_v7_defconfig/gcc-8/lab-cip/baseline-qemu_ar=
m-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5fc868e9f574d1aad3c94=
cdc
        failing since 7 days (last pass: v4.4.243-cip51, first fail: v4.4.2=
43-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv3 | arm  | lab-cip       | gcc-8    | multi_v7_defc...CON=
FIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/5fc8699f4debac6ffbc94ce3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.243-c=
ip51-21-g1d9a9094c010/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-cip/b=
aseline-qemu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.243-c=
ip51-21-g1d9a9094c010/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-cip/b=
aseline-qemu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5fc8699f4debac6ffbc94=
ce4
        failing since 7 days (last pass: v4.4.243-cip51, first fail: v4.4.2=
43-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv3 | arm  | lab-collabora | gcc-8    | multi_v7_defconfig =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/5fc86dbebeda556124c94cd9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.243-c=
ip51-21-g1d9a9094c010/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-q=
emu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.243-c=
ip51-21-g1d9a9094c010/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-q=
emu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5fc86dbebeda556124c94=
cda
        failing since 7 days (last pass: v4.4.243-cip51, first fail: v4.4.2=
43-cip51-10-gd7466739b72e9) =

 =20

--Zi9A9w6VyGEFI4R2aSW3
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5940): https://lists.cip-project.org/g/cip-dev/message=
/5940
Mute This Topic: https://lists.cip-project.org/mt/78682104/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--Zi9A9w6VyGEFI4R2aSW3--
