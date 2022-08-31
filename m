Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7D3ECAAD1
	for <webhook@archiver.kernel.org>; Wed, 31 Aug 2022 12:52:31 +0000 (UTC)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by mx.groups.io with SMTP id smtpd.web11.25190.1661950348077048024
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 31 Aug 2022 05:52:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=rOr2Y5A/;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.54,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f54.google.com with SMTP id
 w88-20020a17090a6be100b001fbb0f0b013so14856851pjj.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 31 Aug 2022 05:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=RUHeN0jkpSsFauIj1zt7qdAyuY4FLxfcPHwB1MinN1I=;
        b=rOr2Y5A/504T2GNA/D1V0NFHR7cCx8TNEzWPnVc+cwoOiqqgeyU+u+wV2D/tYzKnmS
         bsACgJK+2EcgZQq4wfk6mUsFuUuPym4poJt9FY3Zv5uIZC3+PIYJk0K7vB7z8xiBDst8
         S5mGd0xdfqaumpscfGlZpArxW7phMnF/rA1NFFQ8PbBKN+NyhHeF1TlsJoyEMXKTxbBg
         Nw7n7L57Doi2Ob7gKJVTNo87GeuwLYwJLDR4fxlQPtDJzz/Dk7IY+sWObzYJewklQosc
         PPupQip8LT1ihk4z2S0zTg93OYxgMLM9OhYfLR6tNDPjOmPMFM8D66RV+y4ae7sn7Xfr
         yLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=RUHeN0jkpSsFauIj1zt7qdAyuY4FLxfcPHwB1MinN1I=;
        b=JCXDKbsYmzqrboZqBIDfZ29lfGTrg78keXRHrKjQ6i004jFf0AaYu76/rTmkT5V15S
         +Dp3kiQUmGgoEwPXbmiA6OL6Awdkrxh1AfI1xOCbKUgHETbFl3Ow7W2K+lEGiHQLmW5F
         A831+sS0mVedZFZQSKg4w4Y8By5d771GlqnbXY9oVYpPMIyWuNwb65bXRwW9Ug8vRvss
         QAjNtdWVhhmPXcWnVRui8Eaec+AMzwt6eyFMznOUVZvd0h8kZiIHeQ+raJy/OlWtnoeT
         YYkwcmUYc9MlZ1+kfAoE4WrNIRnN7430kdVIkpX8XnFGJYNpqbiq4n3yOMgbhIZ6j2xt
         MGoQ==
X-Gm-Message-State: ACgBeo2LT3LfHOpPA95Ilf2DChcNdj6ZxdcljhvwI+tAT3ahxJu2pf+y
	eK1T9eyrsmNH00b8kDxBVz459m8211iuYsijZBk=
X-Google-Smtp-Source: 
 AA6agR7P6/QDdb75OW6S1ULJsHA0iB/+6fDEhzGIv6mhXAkAMXPMEq60NTyOyYmRxTuxBVK4zem+dg==
X-Received: by 2002:a17:902:bd48:b0:172:bb9d:d6d5 with SMTP id
 b8-20020a170902bd4800b00172bb9dd6d5mr25545015plx.59.1661950346922;
        Wed, 31 Aug 2022 05:52:26 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 1-20020a170902c20100b0016be834d54asm11447496pll.306.2022.08.31.05.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 05:52:26 -0700 (PDT)
Message-ID: <630f598a.170a0220.853c5.4c76@mx.google.com>
Date: Wed, 31 Aug 2022 05:52:26 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.138-cip15
Subject: cip/linux-5.10.y-cip baseline: 172 runs,
 19 regressions (v5.10.138-cip15)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Aug 2022 12:52:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9338

cip/linux-5.10.y-cip baseline: 172 runs, 19 regressions (v5.10.138-cip15)

Regressions Summary
-------------------

platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
panda                      | arm   | lab-baylibre  | gcc-10   | multi_v7_de=
fconfig         | 1          =

panda                      | arm   | lab-baylibre  | gcc-10   | omap2plus_d=
efconfig        | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-broonie   | gcc-10   | defconfig  =
                | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-collabora | gcc-10   | defconfig  =
                | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
                | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-collabora | gcc-10   | defconfig  =
                | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig  =
                | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-collabora | gcc-10   | defconfig  =
                | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
                | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-collabora | gcc-10   | defconfig  =
                | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

rk3399-gru-kevin           | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.138-cip15/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.138-cip15
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      f2d94917db95e02bef61288aba5b06e0dfef3a73 =



Test Regressions
---------------- =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
panda                      | arm   | lab-baylibre  | gcc-10   | multi_v7_de=
fconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/630f531243b1f1afe335567f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-panda.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-panda.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/630f531243b1f1afe3355=
680
        new failure (last pass: v5.10.136-cip14) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
panda                      | arm   | lab-baylibre  | gcc-10   | omap2plus_d=
efconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/630f4f8de81ba31e0c3556cc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-panda.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-panda.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/630f4f8de81ba31e0c355=
6cd
        new failure (last pass: v5.10.136-cip14) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-broonie   | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/630f50f9497dd9005435566a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/630f50f9497dd90054355=
66b
        failing since 35 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81, =
first fail: v5.10.129-cip12-36-g21d9d56f4de5a) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/630f53e0a657d6edc835567c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_ar=
m64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_ar=
m64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/630f53e0a657d6edc8355=
67d
        failing since 27 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81, =
first fail: v5.10.131-cip13-24-ga6f4ea41fe167) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-collabora | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/630f50b260d26097ca355656

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/630f50b260d26097ca355=
657
        failing since 35 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81, =
first fail: v5.10.129-cip12-36-g21d9d56f4de5a) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/630f53bea657d6edc8355645

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_=
arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_=
arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/630f53bea657d6edc8355=
646
        failing since 27 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81, =
first fail: v5.10.131-cip13-24-ga6f4ea41fe167) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/630f50d1e4b8fb4e23355649

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-ue=
fi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-ue=
fi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/630f50d1e4b8fb4e23355=
64a
        failing since 27 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81, =
first fail: v5.10.131-cip13-24-ga6f4ea41fe167) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/630f53f2cc77696fe1355642

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_ar=
m64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_ar=
m64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/630f53f2cc77696fe1355=
643
        failing since 26 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81, =
first fail: v5.10.131-cip13-37-ge3a52725ce96) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-collabora | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/630f50b160d26097ca355650

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2-=
uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2-=
uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/630f50b160d26097ca355=
651
        failing since 27 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81, =
first fail: v5.10.131-cip13-24-ga6f4ea41fe167) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/630f53be963933ea66355643

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_=
arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_=
arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/630f53be963933ea66355=
644
        failing since 26 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81, =
first fail: v5.10.131-cip13-37-ge3a52725ce96) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/630f50e5e4b8fb4e233556db

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/630f50e5e4b8fb4e23355=
6dc
        failing since 27 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81, =
first fail: v5.10.131-cip13-24-ga6f4ea41fe167) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/630f53dea657d6edc8355679

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_ar=
m64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_ar=
m64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/630f53dea657d6edc8355=
67a
        failing since 35 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81, =
first fail: v5.10.129-cip12-36-g21d9d56f4de5a) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-collabora | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/630f50b264b0f842ce355657

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/630f50b264b0f842ce355=
658
        failing since 27 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81, =
first fail: v5.10.131-cip13-24-ga6f4ea41fe167) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/630f53bd887bbb442c35564e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_=
arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_=
arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/630f53bd887bbb442c355=
64f
        failing since 35 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81, =
first fail: v5.10.129-cip12-36-g21d9d56f4de5a) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/630f50d34a54218f2935564b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-ue=
fi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-ue=
fi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/630f50d34a54218f29355=
64c
        failing since 14 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81, =
first fail: v5.10.131-cip13-49-g1145e9c6352e6) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/630f53e1a657d6edc835567f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_ar=
m64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_ar=
m64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/630f53e1a657d6edc8355=
680
        failing since 27 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81, =
first fail: v5.10.131-cip13-24-ga6f4ea41fe167) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-collabora | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/630f50b164b0f842ce355651

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3-=
uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3-=
uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/630f50b164b0f842ce355=
652
        failing since 14 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81, =
first fail: v5.10.131-cip13-49-g1145e9c6352e6) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/630f53d2887bbb442c355670

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_=
arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_=
arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/630f53d2887bbb442c355=
671
        failing since 27 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81, =
first fail: v5.10.131-cip13-24-ga6f4ea41fe167) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
rk3399-gru-kevin           | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/630f536e98a8163f7435566a

  Results:     90 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk339=
9-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk339=
9-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/case/id=
/630f536e98a8163f7435568c
        failing since 155 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81,=
 first fail: v5.10.106-cip4)

    2022-08-31T12:26:17.400209  /lava-7147888/1/../bin/lava-test-case   =

 =20

