Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2261C5475B
	for <webhook@archiver.kernel.org>; Sat,  2 Mar 2024 00:35:52 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web10.39874.1709339743091714012
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 01 Mar 2024 16:35:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=i0geet/p;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.174, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dca8b86ee7so26061745ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 01 Mar 2024 16:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709339742; x=1709944542; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zS4t/kK8muZSX3Y7uQrmDag8fuce8KjITNrHz0poZ6g=;
        b=i0geet/po0Ju8qHugFitzjMZRMtqkXtMgLvAOz3OUzqFD7swo0O0GHXMCX7+mFrsRI
         3ZRUSIbHcSGzxEhzOm64lqA2PB/JFiPTq0+W9d0+uZG/+LTWy21/g8hS3R2CVJsArQNk
         t4Z8LVsfOMWJmtFFFhLsbvhSRKkRR0+gRQwDb3pW7nwct9S0NFm76Nm8GpaSQFpN4m9Z
         HfYI8bEyGSe4eywwVwmRjp4obFcJSEpCwKGs7K0lum+RunGSafBz2YRzMn3qodtejO7K
         d+n1MhlHVH1+6CJ9yKUJL54moC/LTfSHFvKfxtWgu5PcZ79o+vFqRc8EUkYHNlE8Z8f3
         57gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709339742; x=1709944542;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zS4t/kK8muZSX3Y7uQrmDag8fuce8KjITNrHz0poZ6g=;
        b=og4EqS3D8lJMQglCKHKYhNasEh7TI6gOOrSyVHR4M7f0ScUnee1y6klFmfO6V7Y54E
         GCb8hIF/doxTZl70IytmjZ0vdMhlo1gbZ9SshlUGQ3t0ox3H8SqDi2y/XW/hVCjHb1c3
         AvDS1icSmQhRjXCFAcE2+hY2Vu3PDkJV4PaV+ZbaGV09moLQWD4VZnsnNafsPxjq9+UC
         Arb0vmynNLNxpn+X2cYV45InQUpPUU+oLuljpgmsVM6d1VyiZQsMRyCwbsQDTpu8gjqF
         2Crmm4G4Ywu4V7XNR3XTrTkyNbT8f8j93FPfSu7xb7mo92N+Z0+h/VL0a4zjpv1T2Ijv
         190A==
X-Gm-Message-State: AOJu0YwNN5cOqlG7zasCiHboy+o12UCz5/EobefUglNBuRXELaIwjr0Q
	9ZgToaXoMrKqJHNt2Dx/PQFdpRlQTRapi9YEZUuAX0rFHm1/gBXVpUmxRI4dQfrB971UL5Qu427
	nR+U=
X-Google-Smtp-Source: AGHT+IF7lqbbah1hEC+9wZhs2DqMq8DJaVlpM2oauR2zyHbm54C/PeaiVPvqrUCix92MOWRo6/T0Kg==
X-Received: by 2002:a17:902:ecd2:b0:1dc:c9f4:2dab with SMTP id a18-20020a170902ecd200b001dcc9f42dabmr4084022plh.1.1709339741714;
        Fri, 01 Mar 2024 16:35:41 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d8-20020a170903230800b001db5bdd5e33sm4064828plh.48.2024.03.01.16.35.41
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 16:35:41 -0800 (PST)
Message-ID: <65e2745d.170a0220.7b9c4.3c2f@mx.google.com>
Date: Fri, 01 Mar 2024 16:35:41 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.19.306-cip107-1142-gdcbd51e7744f
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 9 runs,
 7 regressions (v4.19.306-cip107-1142-gdcbd51e7744f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 02 Mar 2024 00:35:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15150

cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 9 runs, 7 regressions (v4.=
19.306-cip107-1142-gdcbd51e7744f)

Regressions Summary
-------------------

platform                 | arch  | lab         | compiler | defconfig      =
     | regressions
-------------------------+-------+-------------+----------+----------------=
-----+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | multi_v7_defcon=
fig  | 1          =

beaglebone-black         | arm   | lab-cip     | gcc-10   | multi_v7_defcon=
fig  | 1          =

beaglebone-black         | arm   | lab-broonie | gcc-10   | omap2plus_defco=
nfig | 1          =

beaglebone-black         | arm   | lab-cip     | gcc-10   | omap2plus_defco=
nfig | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
     | 1          =

r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
     | 1          =

r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig      =
     | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.306-cip107-1142-gdcbd51e7744f/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.306-cip107-1142-gdcbd51e7744f
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      dcbd51e7744fcf9baa3ea87a028b574fda95d428 =



Test Regressions
---------------- =



platform                 | arch  | lab         | compiler | defconfig      =
     | regressions
-------------------------+-------+-------------+----------+----------------=
-----+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | multi_v7_defcon=
fig  | 1          =


  Details:     https://kernelci.org/test/plan/id/65e269089d88bc486c63701a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm/multi_v7_defconfig/gcc-10/lab-broo=
nie/baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm/multi_v7_defconfig/gcc-10/lab-broo=
nie/baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65e269089d88b=
c486c63701b
        failing since 530 days (last pass: v4.4-st20-229-gb433f12afe250, fi=
rst fail: v4.4-st20-231-g7349cef09ddd2) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
     | regressions
-------------------------+-------+-------------+----------+----------------=
-----+------------
beaglebone-black         | arm   | lab-cip     | gcc-10   | multi_v7_defcon=
fig  | 1          =


  Details:     https://kernelci.org/test/plan/id/65e271e2f0f22de7ec63702d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm/multi_v7_defconfig/gcc-10/lab-cip/=
baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm/multi_v7_defconfig/gcc-10/lab-cip/=
baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65e271e2f0f22=
de7ec63702e
        failing since 530 days (last pass: v4.4-st20-229-gb433f12afe250, fi=
rst fail: v4.4-st20-231-g7349cef09ddd2) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
     | regressions
-------------------------+-------+-------------+----------+----------------=
-----+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | omap2plus_defco=
nfig | 1          =


  Details:     https://kernelci.org/test/plan/id/65e26855b4f534801b63701a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm/omap2plus_defconfig/gcc-10/lab-bro=
onie/baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm/omap2plus_defconfig/gcc-10/lab-bro=
onie/baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65e26855b4f53=
4801b63701b
        failing since 102 days (last pass: v4.4-st20-231-g7349cef09ddd2, fi=
rst fail: v5.10.200-cip40-513-g195b5d2b5c744) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
     | regressions
-------------------------+-------+-------------+----------+----------------=
-----+------------
beaglebone-black         | arm   | lab-cip     | gcc-10   | omap2plus_defco=
nfig | 1          =


  Details:     https://kernelci.org/test/plan/id/65e26a8a8a115059b2637023

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm/omap2plus_defconfig/gcc-10/lab-cip=
/baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm/omap2plus_defconfig/gcc-10/lab-cip=
/baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65e26a8a8a115=
059b2637024
        failing since 102 days (last pass: v4.4-st20-231-g7349cef09ddd2, fi=
rst fail: v5.10.200-cip40-513-g195b5d2b5c744) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
     | regressions
-------------------------+-------+-------------+----------+----------------=
-----+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
     | 1          =


  Details:     https://kernelci.org/test/plan/id/65e2687e60928006b4637051

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm64/defconfig/gcc-10/lab-cip/baselin=
e-cip-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm64/defconfig/gcc-10/lab-cip/baselin=
e-cip-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65e2687e60928=
006b4637052
        failing since 542 days (last pass: v5.10.131-cip13-84-g5fcbe4a63ab4=
d, first fail: v5.10.138-cip15-10-g52cbd8ad1543e) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
     | regressions
-------------------------+-------+-------------+----------+----------------=
-----+------------
r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
     | 1          =


  Details:     https://kernelci.org/test/plan/id/65e267663e7c9253106370bc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm64/defconfig/gcc-10/lab-cip/baselin=
e-cip-nfs-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm64/defconfig/gcc-10/lab-cip/baselin=
e-cip-nfs-r8a774b1-hihope-rzg2n-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65e267663e7c9=
253106370bd
        failing since 102 days (last pass: v5.10.138-cip15-10-g52cbd8ad1543=
e, first fail: v5.10.200-cip40-513-g195b5d2b5c744) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
     | regressions
-------------------------+-------+-------------+----------+----------------=
-----+------------
r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig      =
     | 1          =


  Details:     https://kernelci.org/test/plan/id/65e267ca26cb835e70637038

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm64/defconfig/gcc-10/lab-cip/baselin=
e-cip-nfs-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm64/defconfig/gcc-10/lab-cip/baselin=
e-cip-nfs-r8a774c0-ek874.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65e267ca26cb8=
35e70637039
        failing since 102 days (last pass: v5.10.138-cip15-10-g52cbd8ad1543=
e, first fail: v5.10.200-cip40-513-g195b5d2b5c744) =

 =20

