Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AF2C197A0
	for <webhook@archiver.kernel.org>; Mon, 20 Nov 2023 14:11:09 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web11.51109.1700489468459725121
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 20 Nov 2023 06:11:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=Ngq/50xF;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.182, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1cc938f9612so26697815ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 20 Nov 2023 06:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700489467; x=1701094267; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UW6lW+32EWtS5WoBaRT68KILEtlcyHFc4qrz1enlQqQ=;
        b=Ngq/50xF1yaOc+C4R1JdAvzXIANj5QhbC9lOHyCSUf1o6HoC83PrBUA6cTIjIvV6iR
         oMJaNrLv1r2np6A9RuQ6fcWssQr4XE8JX9l/CaeS4Unqd+M+PNb/jeClVVHxDxJXMZCx
         Y75CSnDqNpfjGBN7ogy+C9MvfyXS4DWC17TlI7x4VVtHuHcCeVzdkm8gASdggoIbNtY/
         LEZCp8K7DblGhRAk8iICQj7b3c5OxLGm/Q0fnfXb/U1ZGfyiC7xtLABcbZs7BWX6TQco
         i8rITp9xddDQ9buefPhCbhKGM8p6KLgRxI0crk9JI7BEZ+A+yAnHN1IOUPtEtSPOg4h4
         aJXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700489467; x=1701094267;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UW6lW+32EWtS5WoBaRT68KILEtlcyHFc4qrz1enlQqQ=;
        b=HvcLiCtaZ8gmNCC2Mp8ujPNBvLEevylv3K9bz2dozTFzQGOe5h9ZCcpj0f64AKRZHt
         d2SnsV4mYQx25ZcKjLFcPY/MixVT9upip1rHv/IuOzCAI2eMTIWDDR/fm6C8eG+5GNkq
         xKdzxKk2BD/KbkF5BvY2jiNJMro0ZPs1cYLdWdmdPd5Qb8jPz2LsLy/w6vTheh/o5IE5
         nMQkylHSXQKH6SMCL/Cc5Ibu0VOzTIlwROu8quve6VVs/luBJbimtC4Gf66/F6X50Qaj
         JSj/AY+fXl7qJoROeX+Cw9NgfcjgIcvz3oRblIVoBHP0vemVlPi6KMkoS2JIEeC63Q+H
         kAWQ==
X-Gm-Message-State: AOJu0YxvP71tfNQ4fzdV5LiVJ5grjH+0QkQIBh5i+tegF6/BLZE65p+I
	AMs3cUKKjlYalf4Ge8K/BVkF5X7DS8kg7zyINXE=
X-Google-Smtp-Source: AGHT+IEcb+BtvtVd0y59IiBC7AYduH65vg+cLOY7g4p6tksT3FT+cUQTuKpyAR7fhlc8PsjVO7Ii6w==
X-Received: by 2002:a17:902:d50b:b0:1cf:66a3:16c with SMTP id b11-20020a170902d50b00b001cf66a3016cmr1309213plg.21.1700489467019;
        Mon, 20 Nov 2023 06:11:07 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p4-20020a1709026b8400b001b7fd27144dsm6123114plk.40.2023.11.20.06.11.06
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 06:11:06 -0800 (PST)
Message-ID: <655b68fa.170a0220.1117a.ed6c@mx.google.com>
Date: Mon, 20 Nov 2023 06:11:06 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.19.297-cip104-152-g5bde1c076bf53
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-cip-nfs: 4 runs,
 4 regressions (v4.19.297-cip104-152-g5bde1c076bf53)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Nov 2023 14:11:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13604

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-cip-nfs: 4 runs, 4 regr=
essions (v4.19.297-cip104-152-g5bde1c076bf53)

Regressions Summary
-------------------

platform                 | arch  | lab         | compiler | defconfig      =
     | regressions
-------------------------+-------+-------------+----------+----------------=
-----+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | multi_v7_defcon=
fig  | 1          =

beaglebone-black         | arm   | lab-broonie | gcc-10   | omap2plus_defco=
nfig | 1          =

r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
     | 1          =

r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig      =
     | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.297-cip104-152-g5bde1c076bf53/plan/baseli=
ne-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.297-cip104-152-g5bde1c076bf53
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      5bde1c076bf539d6bb2f2eb64fd95e7d2a5c3214 =



Test Regressions
---------------- =



platform                 | arch  | lab         | compiler | defconfig      =
     | regressions
-------------------------+-------+-------------+----------+----------------=
-----+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | multi_v7_defcon=
fig  | 1          =


  Details:     https://kernelci.org/test/plan/id/655b6412c581cb75fb7e4af9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.297-cip104-152-g5bde1c076bf53/arm/multi_v7_defconfig/gcc=
-10/lab-broonie/baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.297-cip104-152-g5bde1c076bf53/arm/multi_v7_defconfig/gcc=
-10/lab-broonie/baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/655b6412c581c=
b75fb7e4afa
        failing since 12 days (last pass: v4.19.252-cip78-113-gb7034e0f773f=
8, first fail: v4.19.297-cip104-63-ge7301d2e196ae) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
     | regressions
-------------------------+-------+-------------+----------+----------------=
-----+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | omap2plus_defco=
nfig | 1          =


  Details:     https://kernelci.org/test/plan/id/655b64230cb0ffd5277e4a84

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.297-cip104-152-g5bde1c076bf53/arm/omap2plus_defconfig/gc=
c-10/lab-broonie/baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.297-cip104-152-g5bde1c076bf53/arm/omap2plus_defconfig/gc=
c-10/lab-broonie/baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/655b64230cb0f=
fd5277e4a85
        failing since 465 days (last pass: v4.19.252-cip78-113-gb7034e0f773=
f8, first fail: v4.19.252-cip78-146-g6acc38498265c) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
     | regressions
-------------------------+-------+-------------+----------+----------------=
-----+------------
r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
     | 1          =


  Details:     https://kernelci.org/test/plan/id/655b639c0cb0ffd5277e4a6f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.297-cip104-152-g5bde1c076bf53/arm64/defconfig/gcc-10/lab=
-cip/baseline-cip-nfs-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.297-cip104-152-g5bde1c076bf53/arm64/defconfig/gcc-10/lab=
-cip/baseline-cip-nfs-r8a774b1-hihope-rzg2n-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/655b639c0cb0f=
fd5277e4a70
        failing since 12 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0,=
 first fail: v4.19.297-cip104-63-ge7301d2e196ae) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
     | regressions
-------------------------+-------+-------------+----------+----------------=
-----+------------
r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig      =
     | 1          =


  Details:     https://kernelci.org/test/plan/id/655b639de93deeeca47e4aad

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.297-cip104-152-g5bde1c076bf53/arm64/defconfig/gcc-10/lab=
-cip/baseline-cip-nfs-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.297-cip104-152-g5bde1c076bf53/arm64/defconfig/gcc-10/lab=
-cip/baseline-cip-nfs-r8a774c0-ek874.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/655b639de93de=
eeca47e4aae
        failing since 12 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0,=
 first fail: v4.19.297-cip104-63-ge7301d2e196ae) =

 =20

