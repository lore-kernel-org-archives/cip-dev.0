Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C183EC4167B
	for <webhook@archiver.kernel.org>; Fri,  8 Dec 2023 17:19:05 +0000 (UTC)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
 by mx.groups.io with SMTP id smtpd.web10.41695.1702055943805794143
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 08 Dec 2023 09:19:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=IEB0WTGm;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.169, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5c66988c2eeso1762320a12.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 08 Dec 2023 09:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702055943; x=1702660743; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sbxUKYaWVF94E5ZR2fOCFaf8+WBQ5fZI6aQUm0EVwdo=;
        b=IEB0WTGmhvxXCrUeBuaKwhViAGpQz7thyfqRydV/Wp54kF857VMB3gEkumft0qSVRz
         hyMef5EIC2OySvC9WM0X6hWi0SJJWWfRU+5wWXtIqEde5jk+ROi8AI4/kycDLAuZAKcB
         7LhZWxvKqxWosJxPlUxNOdH3s0VPaN03lHW6+5mH4g8MlP5ii8+fG/px7OzkrYXFswRc
         491E4UPf8GrqzfT58fGDE8oJy0Cj31JU/hN7JzdmvMeBGtF/1PQQPoIWOVJ4a76TjVwT
         nx2Eb5nfLLFRVmzN6kEcewj4t0gObuZVNMFaSdxuFO3IHvwZnaNND+TBM8TmYdB28naO
         qf7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702055943; x=1702660743;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sbxUKYaWVF94E5ZR2fOCFaf8+WBQ5fZI6aQUm0EVwdo=;
        b=kDL2co20RhxGfs4wSXI6FR0QbjRSrbn7vpiLUTUUHa9MuHLpfkBiMBIijKsSttQ2Qv
         oApjdJ4hnzAQO3DTXvnR9mHU+2p93zSCQHKnnfaBJdCvrc59FZWKEsncoF4y2LFZ3/16
         0fB6cSLxcvCWFnx4fJ7uy/Wfdyb/oBkxV+ePrTIcvQu1qGuHYZDig3pBjACogu/XZpks
         yIQ0vSv6Pn/vz9zFDzT64/I2l1hxb1nIim/046ULhhj/PifgySHVet0Dv1XGpHvTZUkL
         Lc/DrAVR47iAaW9FYrP9M/v5bwu2ktF43NQ9j8FirdiaZ6Ii6mVo8EtnsIHFerC+5AIE
         5ZSQ==
X-Gm-Message-State: AOJu0YzJWRkSCvmuRSk+Zf9gCXLau1+XKs8ciQgpUYPPm1JIGbRhEdCZ
	sD/N8+es7V3BoxnfwuFAZacodCG2f/VkGWAwoEJ0Yg==
X-Google-Smtp-Source: AGHT+IGD8yf27udRIF2mtqUwaZ3Pzw7IfwWoHCvtVSGx5trqVic5jV/YBCXINzROUyeT6Didy91Eyg==
X-Received: by 2002:a05:6a20:7788:b0:18f:97c:3854 with SMTP id c8-20020a056a20778800b0018f097c3854mr493399pzg.46.1702055942648;
        Fri, 08 Dec 2023 09:19:02 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b16-20020a056a0002d000b006ce70d26d9csm1828949pft.27.2023.12.08.09.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 09:19:02 -0800 (PST)
Message-ID: <65735006.050a0220.db15e.663e@mx.google.com>
Date: Fri, 08 Dec 2023 09:19:02 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-46-g596f4c151d286
Subject: cip/linux-5.10.y-cip baseline-cip-nfs: 6 runs,
 4 regressions (v5.10.201-cip41-46-g596f4c151d286)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Dec 2023 17:19:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13973

cip/linux-5.10.y-cip baseline-cip-nfs: 6 runs, 4 regressions (v5.10.201-cip=
41-46-g596f4c151d286)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
beaglebone-black         | arm   | lab-cip | gcc-10   | omap2plus_defconfig=
 | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
 | 1          =

r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip | gcc-10   | defconfig          =
 | 1          =

r8a774c0-ek874           | arm64 | lab-cip | gcc-10   | defconfig          =
 | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-46-g596f4c151d286/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-46-g596f4c151d286
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      596f4c151d286c71a3612a2120ab33f4ac885d2e =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
beaglebone-black         | arm   | lab-cip | gcc-10   | omap2plus_defconfig=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/65734ecf644d89feeee13475

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-ci=
p-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-ci=
p-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65734ecf644d8=
9feeee13476
        failing since 28 days (last pass: v5.10.138-cip15, first fail: v5.1=
0.200-cip40) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/6573491f25ec3d8943e1347a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8=
a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8=
a774a1-hihope-rzg2m-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/6573491f25ec3=
d8943e1347b
        failing since 28 days (last pass: v5.10.138-cip15, first fail: v5.1=
0.200-cip40) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip | gcc-10   | defconfig          =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/657349fdd076625efae13486

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8=
a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8=
a774b1-hihope-rzg2n-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/657349fdd0766=
25efae13487
        failing since 28 days (last pass: v5.10.138-cip15, first fail: v5.1=
0.200-cip40) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774c0-ek874           | arm64 | lab-cip | gcc-10   | defconfig          =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/657347f517edfeb95ee1348f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8=
a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8=
a774c0-ek874.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/657347f517edf=
eb95ee13490
        failing since 28 days (last pass: v5.10.138-cip15, first fail: v5.1=
0.200-cip40) =

 =20

