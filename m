Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90267C47258
	for <webhook@archiver.kernel.org>; Wed, 31 Jan 2024 12:51:07 +0000 (UTC)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
 by mx.groups.io with SMTP id smtpd.web11.13058.1706705465367743061
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 31 Jan 2024 04:51:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=TXe5zAWB;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.173, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso3495459a12.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 31 Jan 2024 04:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1706705464; x=1707310264; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=v4JrXTfrsbxa1PDIBkU3I5/nk1YWzuAD7LVQ8YJRqVg=;
        b=TXe5zAWBoDrg1ij4pUe28ujKt4bllmRVNTJf17ZFvhojanUCQgzRG19J/KWbJtsZGD
         fDPM2eYinSDAOAFXj3MRWy28wnFDV3LkZPZQVgJBMHPabGAWhdENxqjmzEx2kjsGv3vz
         oyEGFRl9nodKUVHE3LaDFTrNlPVdjyGjEK6JbXnmUbVmEhRbn0KheE+B3QmbXoqD9cAW
         jwtu4SR6Zp2gTh9wk4AVe7O3z0yhj1YMPmhv2vH7vehTlV3KZAaKtIlAj0eifll/SVzi
         D1+Qk16jTiHyN8qTp2bfCf6uy7MbnC7RMOwMTd6z4Yj318vTzFgFx3MUXHylpV6tUBjy
         ohvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706705464; x=1707310264;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v4JrXTfrsbxa1PDIBkU3I5/nk1YWzuAD7LVQ8YJRqVg=;
        b=Howv0bRy5pXCgtUIlKyOPuNhgCYjLyIIQinC4xr66gJr8e7FqBuCvwqi19PK4N5g3a
         ii6P4EMauwSCmFnZmPpSWiZiLvinr7UxYOq6wQFcXirED8yncp2Ro1KMKoku/63L5uuu
         2RXa2DeyeKcWuiorFW+eOnlYdaW/eYZM+yniYRVFzK5jUQfdpGFJKJw8pz5wGecyPyFP
         gD6Z//kb+opQytJKzj7+/5m2l/0HBUPQRcyhZuEWSzh6TpWbjs2oOCoGMDeKaX5uCLhs
         LY/dvG4BzdeXyFUjUKyHtix+zG/pVyFsTh5zqHKdPypR/6OfgLCMT6hu1q64dnMcIvqj
         TW3w==
X-Gm-Message-State: AOJu0YzocQ+tSJmFeUweA+j1ronusJKpxqFJU6Vl0udiq2OBnECguj6G
	za7u7QSHtRIQJdCRMVxCFPx3gu7sd7GzNGUHwRMYD9p5Gzr1M9izrCf15jlz4CTBaj8q/NtuIOF
	M
X-Google-Smtp-Source: AGHT+IEVA3khumfWnxD3z4eSaZH/h9KEY8F/9d7k4AA6FCEk4FQG5aptihv+j1r2PVna3KbeNcPQeA==
X-Received: by 2002:a05:6a20:3d8b:b0:19e:279b:772d with SMTP id s11-20020a056a203d8b00b0019e279b772dmr1616781pzi.28.1706705463990;
        Wed, 31 Jan 2024 04:51:03 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y15-20020a170902b48f00b001d8921f2058sm8951590plr.205.2024.01.31.04.51.03
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 04:51:03 -0800 (PST)
Message-ID: <65ba4237.170a0220.ab5a8.a739@mx.google.com>
Date: Wed, 31 Jan 2024 04:51:03 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v6.1.72-cip13-32-gf60d2e8cb51c
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 8 runs,
 5 regressions (v6.1.72-cip13-32-gf60d2e8cb51c)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Jan 2024 12:51:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14560

cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 8 runs, 5 regressions (v6.=
1.72-cip13-32-gf60d2e8cb51c)

Regressions Summary
-------------------

platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | omap2plus_defco=
nfig        | 1          =

beaglebone-black         | arm   | lab-cip     | gcc-10   | omap2plus_defco=
nfig        | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =

r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig      =
            | 1          =

r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.72-cip13-32-gf60d2e8cb51c/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.72-cip13-32-gf60d2e8cb51c
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      f60d2e8cb51c9da65ffcfe73144286c27725ceea =



Test Regressions
---------------- =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | omap2plus_defco=
nfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/65ba34cdd708207d7100a03b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-32-gf60d2e8cb51c/arm/omap2plus_defconfig/gcc-10/lab-broonie/=
baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-32-gf60d2e8cb51c/arm/omap2plus_defconfig/gcc-10/lab-broonie/=
baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65ba34cdd7082=
07d7100a03c
        failing since 72 days (last pass: v4.4-st20-231-g7349cef09ddd2, fir=
st fail: v5.10.200-cip40-513-g195b5d2b5c744) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
beaglebone-black         | arm   | lab-cip     | gcc-10   | omap2plus_defco=
nfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/65ba36a62da42cb6e900a03a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-32-gf60d2e8cb51c/arm/omap2plus_defconfig/gcc-10/lab-cip/base=
line-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-32-gf60d2e8cb51c/arm/omap2plus_defconfig/gcc-10/lab-cip/base=
line-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65ba36a62da42=
cb6e900a03b
        failing since 72 days (last pass: v4.4-st20-231-g7349cef09ddd2, fir=
st fail: v5.10.200-cip40-513-g195b5d2b5c744) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65ba3a6b24bdfab5fc00a259

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-32-gf60d2e8cb51c/arm64/defconfig+arm64-chromebook/gcc-10/lab=
-cip/baseline-cip-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-32-gf60d2e8cb51c/arm64/defconfig+arm64-chromebook/gcc-10/lab=
-cip/baseline-cip-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65ba3a6b24bdf=
ab5fc00a25a
        failing since 68 days (last pass: v5.10.138-cip15-10-g52cbd8ad1543e=
, first fail: v6.1.62-cip9-12-g3a5321f469b07) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig      =
            | 1          =


  Details:     https://kernelci.org/test/plan/id/65ba32bd9dfa4d728800a05f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-32-gf60d2e8cb51c/arm64/defconfig/gcc-10/lab-cip/baseline-cip=
-nfs-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-32-gf60d2e8cb51c/arm64/defconfig/gcc-10/lab-cip/baseline-cip=
-nfs-r8a774c0-ek874.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65ba32bd9dfa4=
d728800a060
        failing since 72 days (last pass: v5.10.138-cip15-10-g52cbd8ad1543e=
, first fail: v5.10.200-cip40-513-g195b5d2b5c744) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65ba3a903d47af5b1a00a2d6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-32-gf60d2e8cb51c/arm64/defconfig+arm64-chromebook/gcc-10/lab=
-cip/baseline-cip-nfs-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-32-gf60d2e8cb51c/arm64/defconfig+arm64-chromebook/gcc-10/lab=
-cip/baseline-cip-nfs-r8a774c0-ek874.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65ba3a903d47a=
f5b1a00a2d7
        failing since 69 days (last pass: v5.10.138-cip15-10-g52cbd8ad1543e=
, first fail: v6.1.62-cip9-13-g34c303883a305) =

 =20

