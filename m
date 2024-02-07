Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C915C4829C
	for <webhook@archiver.kernel.org>; Wed,  7 Feb 2024 04:28:29 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.web11.13378.1707280100742414332
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 06 Feb 2024 20:28:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=jtWQqoo0;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.171, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6de2f8d6fb9so170880b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 06 Feb 2024 20:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707280099; x=1707884899; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Vn5WOFUH5PQCqJ7wv7a1N0Wikicx9iB8TT8B4mLwZK8=;
        b=jtWQqoo0YqbAUUcKgmTXAOFs0KcW5YIfmfFNoZqCC1bfrEfW1Ny/Bq7diml04RqJRk
         peuLwc2CmCr/75PIDPJ7fCYena1r5XEPGYflVLnNUkI9kLejYmgs/RUVaRA8KeV2sx2f
         01LfHUGwJaikHbvvoZ3On1w9vT+q+aG+B09fLEV9LlNQSdRXTN0s0wvdgllFkDAeHuFq
         GoUyFpUOo8bC9++3yiPZNRfD2bqXQl7AZ08Xe6vdglfTsNMszbU5xipe6ruqrjMj2A1F
         uALfnBfrhp86r9Z1tvcLqChGcI4pTWKuHYdmMJGvWhdYFoKnL6JfcVmB/jgrnUyHX/YX
         HEuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707280099; x=1707884899;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vn5WOFUH5PQCqJ7wv7a1N0Wikicx9iB8TT8B4mLwZK8=;
        b=GfOgJm+Vcv61HgiEBRDEvvR4N788CfP6cbX6WkFoZ973l2lr33+nZzgfxE3t1kb1s1
         rFiZIONSlUIZGOuOmGxAndjLAW8Hz8OhTaG+s+X4sIQWnbtQnk5Q0gXh6BR5FYp0H50m
         bvpW7iwfq3sAbZbYh5YjK66AkDJpY4PlLxxn9tJtdSxsvnXQPDfEUZ3noFMt56yVWv4w
         8uFvnY3p4ytQszqt4ze/5I+MvGI1cwqUrLs5muUwNaM/co3V5VPXluoOwCmGwNzOfAmf
         K8DyREim46oYeJlL5xSb+rsAa7/pGtD3sOYvWPP1l5vgSRX6ycJW1UAvY2T+FY2qEbOu
         omdA==
X-Gm-Message-State: AOJu0YxpT+SR+wnFgBOIwjGcepo8WLON1Mk4K2ax9am31/6lw30WS1Mf
	3NaMHlvkP5MMYClOnB8eQhHWgm1Cl8+dfyG96Tdzru2adqFM8LtPhI1jZlzvcWox2gVw+W3uTmj
	g
X-Google-Smtp-Source: AGHT+IFDhidxpx7JAT75Ej4KUYFh+ySH+9qCBbKK2mJGUCagaYfpk5Geap+3JRbg8KJT4CjMuotrZw==
X-Received: by 2002:a05:6a20:9588:b0:19e:4790:25dc with SMTP id iu8-20020a056a20958800b0019e479025dcmr4702600pzb.60.1707280099269;
        Tue, 06 Feb 2024 20:28:19 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id sv12-20020a17090b538c00b0029659674bbesm426035pjb.43.2024.02.06.20.28.18
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 20:28:18 -0800 (PST)
Message-ID: <65c306e2.170a0220.f2364.151c@mx.google.com>
Date: Tue, 06 Feb 2024 20:28:18 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip72-1250-g39ff255b75f5
Subject: cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 5 runs,
 3 regressions (v4.4.302-cip72-1250-g39ff255b75f5)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Feb 2024 04:28:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14859

cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 5 runs, 3 regressions (v4.=
4.302-cip72-1250-g39ff255b75f5)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-cip     | gcc-10   | multi_v7_defconfig  | 1 =
         =

beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =

beaglebone-black | arm  | lab-cip     | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip72-1250-g39ff255b75f5/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip72-1250-g39ff255b75f5
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      39ff255b75f5caee714b345c0c47b1c44b88dbe0 =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-cip     | gcc-10   | multi_v7_defconfig  | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/65c2ffbff2dc57e55e8e1e7b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/arm/multi_v7_defconfig/gcc-10/lab-cip/ba=
seline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/arm/multi_v7_defconfig/gcc-10/lab-cip/ba=
seline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65c2ffbff2dc5=
7e55e8e1e7c
        failing since 78 days (last pass: v4.4-st20-231-g7349cef09ddd2, fir=
st fail: v5.10.200-cip40-513-g195b5d2b5c744) =

 =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/65c2fa3e980bbd9ade8e1e79

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/arm/omap2plus_defconfig/gcc-10/lab-broon=
ie/baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/arm/omap2plus_defconfig/gcc-10/lab-broon=
ie/baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65c2fa3e980bb=
d9ade8e1e7a
        failing since 78 days (last pass: v4.4-st20-231-g7349cef09ddd2, fir=
st fail: v5.10.200-cip40-513-g195b5d2b5c744) =

 =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-cip     | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/65c2fe2331c96b858f8e1e87

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/arm/omap2plus_defconfig/gcc-10/lab-cip/b=
aseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/arm/omap2plus_defconfig/gcc-10/lab-cip/b=
aseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65c2fe2331c96=
b858f8e1e88
        failing since 78 days (last pass: v4.4-st20-231-g7349cef09ddd2, fir=
st fail: v5.10.200-cip40-513-g195b5d2b5c744) =

 =20

