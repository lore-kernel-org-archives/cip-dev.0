X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web08.3539.1644884272920964480
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 14 Feb 2022 16:17:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=N9mIB3Xe;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.177, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f177.google.com with SMTP id z17so11781292plb.9
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 14 Feb 2022 16:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=aNYT2iFKXLvxh2MCmym6dAZ1FYBKfslYLg65b8In0ms=;
        b=N9mIB3Xev+0LupCJNM1TR/kSEbvJ2B4bjifioRQi2FMhj3DwcF0K81tC4JNxZ/ZYUX
         NbSk9r33HdwRnzoNR20YoSD4ubCkTRDDKDdSPkxPwOuNY0W/smJUFKxP90gtr6zkg3AR
         xHJaDq3A7du2YX6yD/dT8uVPKAfne8UWCjQSjvtM20DtUDbMkI5gAwAYaGWS/v8GBXBg
         s4MU1h5Md7Wyv4KGoFTx+/t/qInKInw2XMrs4T4uGSJtQabe+/NXsTTxucNYufm/tzrw
         FJAdkkbhfST5LtY/DEL3EB8TnTLm/oumVg+JaP3tjsB74aHh8EIy4ICmOvUeRXNoHiJc
         8eXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=aNYT2iFKXLvxh2MCmym6dAZ1FYBKfslYLg65b8In0ms=;
        b=vaSFGyrA3YleQSGD7ecy/HpLYFVgAR5wUzo2d/sjUH8+GY4oT7r2D3JrDlcyPF05+m
         vFIlpVfNiBaCm+4EtsaUR4H7qZ6jlbodsG23olADBFl4Bk2CBJ/X8nCZ20A2NNkMTXe1
         sldQiMaesr57SHY0s5ZFgt/ti93jajRebUhjStauLog17aHVbNcI/Sh+1satNZa/lPwQ
         VQcL3DduqIRHx3PE6TtdTQHNkxJGgVn2GAJeFSUTm2tTOHRgYwVHRARm+klwAqkR0OEx
         UhLO6TqJkbELbNXWqBv9IVoDlCG9nIeMr/UyqUsjovn+a7STBhz1Dt4Uk+Szq8DhBJmL
         WCXg==
X-Gm-Message-State: AOAM531IsRG2bGBZlFBHtbwP55yf98tGM0ZhW3txy2r3roThz9z46/6N
	uW9fjxfMzrrxHEx63LlOJlCbVBEqatLUOUFt
X-Google-Smtp-Source: ABdhPJyJey8sJEL7xB1uQeuhUTHKYCo0NujNcXewGEHbC/23lPJlX8mAIFkElfwU4KrlAQ34nNGAzg==
X-Received: by 2002:a17:90a:1987:: with SMTP id 7mr1334602pji.215.1644884271972;
        Mon, 14 Feb 2022 16:17:51 -0800 (PST)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z13sm38561673pfj.23.2022.02.14.16.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 16:17:51 -0800 (PST)
Message-ID: <620af12f.1c69fb81.73451.f75f@mx.google.com>
Date: Mon, 14 Feb 2022 16:17:51 -0800 (PST)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-cip-rt
X-Kernelci-Kernel: v4.4.302-cip68-rt38
Subject: cip/linux-4.4.y-cip-rt baseline: 72 runs, 6 regressions (v4.4.302-cip68-rt38) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-4.4.y-cip-rt baseline: 72 runs, 6 regressions (v4.4.302-cip68-rt3=
8)

Regressions Summary
-------------------

platform              | arch  | lab          | compiler | defconfig | regre=
ssions
----------------------+-------+--------------+----------+-----------+------=
------
qemu_arm64-virt-gicv2 | arm64 | lab-baylibre | gcc-10   | defconfig | 1    =
      =

qemu_arm64-virt-gicv2 | arm64 | lab-broonie  | gcc-10   | defconfig | 1    =
      =

qemu_arm64-virt-gicv2 | arm64 | lab-cip      | gcc-10   | defconfig | 1    =
      =

qemu_arm64-virt-gicv3 | arm64 | lab-baylibre | gcc-10   | defconfig | 1    =
      =

qemu_arm64-virt-gicv3 | arm64 | lab-broonie  | gcc-10   | defconfig | 1    =
      =

qemu_arm64-virt-gicv3 | arm64 | lab-cip      | gcc-10   | defconfig | 1    =
      =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip-rt/ker=
nel/v4.4.302-cip68-rt38/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.4.y-cip-rt
  Describe: v4.4.302-cip68-rt38
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      94973269ae47d381c543768dad86bdffcd61479d =



Test Regressions
---------------- =



platform              | arch  | lab          | compiler | defconfig | regre=
ssions
----------------------+-------+--------------+----------+-----------+------=
------
qemu_arm64-virt-gicv2 | arm64 | lab-baylibre | gcc-10   | defconfig | 1    =
      =


  Details:     https://kernelci.org/test/plan/id/620ae078bf84d61279c629a5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip68-rt38/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-g=
icv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip68-rt38/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-g=
icv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220211.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/620ae078bf84d61279c62=
9a6
        new failure (last pass: v4.4.296-cip67-rt37) =

 =



platform              | arch  | lab          | compiler | defconfig | regre=
ssions
----------------------+-------+--------------+----------+-----------+------=
------
qemu_arm64-virt-gicv2 | arm64 | lab-broonie  | gcc-10   | defconfig | 1    =
      =


  Details:     https://kernelci.org/test/plan/id/620ae03cd76175826ec62972

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip68-rt38/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gi=
cv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip68-rt38/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gi=
cv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220211.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/620ae03cd76175826ec62=
973
        new failure (last pass: v4.4.296-cip67-rt37) =

 =



platform              | arch  | lab          | compiler | defconfig | regre=
ssions
----------------------+-------+--------------+----------+-----------+------=
------
qemu_arm64-virt-gicv2 | arm64 | lab-cip      | gcc-10   | defconfig | 1    =
      =


  Details:     https://kernelci.org/test/plan/id/620ae34e0801b19a07c62997

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip68-rt38/arm64/defconfig/gcc-10/lab-cip/baseline-qemu_arm64-virt-gicv2.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip68-rt38/arm64/defconfig/gcc-10/lab-cip/baseline-qemu_arm64-virt-gicv2.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220211.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/620ae34e0801b19a07c62=
998
        new failure (last pass: v4.4.296-cip67-rt37) =

 =



platform              | arch  | lab          | compiler | defconfig | regre=
ssions
----------------------+-------+--------------+----------+-----------+------=
------
qemu_arm64-virt-gicv3 | arm64 | lab-baylibre | gcc-10   | defconfig | 1    =
      =


  Details:     https://kernelci.org/test/plan/id/620ae03cf2b63242f6c6296f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip68-rt38/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-g=
icv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip68-rt38/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-g=
icv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220211.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/620ae03cf2b63242f6c62=
970
        new failure (last pass: v4.4.296-cip67-rt37) =

 =



platform              | arch  | lab          | compiler | defconfig | regre=
ssions
----------------------+-------+--------------+----------+-----------+------=
------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie  | gcc-10   | defconfig | 1    =
      =


  Details:     https://kernelci.org/test/plan/id/620ae03afc5d1148f2c62977

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip68-rt38/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gi=
cv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip68-rt38/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gi=
cv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220211.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/620ae03afc5d1148f2c62=
978
        new failure (last pass: v4.4.296-cip67-rt37) =

 =



platform              | arch  | lab          | compiler | defconfig | regre=
ssions
----------------------+-------+--------------+----------+-----------+------=
------
qemu_arm64-virt-gicv3 | arm64 | lab-cip      | gcc-10   | defconfig | 1    =
      =


  Details:     https://kernelci.org/test/plan/id/620ae2d6b65c5446ccc62971

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip68-rt38/arm64/defconfig/gcc-10/lab-cip/baseline-qemu_arm64-virt-gicv3.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip68-rt38/arm64/defconfig/gcc-10/lab-cip/baseline-qemu_arm64-virt-gicv3.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220211.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/620ae2d6b65c5446ccc62=
972
        new failure (last pass: v4.4.296-cip67-rt37) =

 =20

