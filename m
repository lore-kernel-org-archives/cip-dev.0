Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D5BC54E41
	for <webhook@archiver.kernel.org>; Thu, 29 Feb 2024 09:27:01 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web10.20634.1709198813844582550
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 29 Feb 2024 01:26:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=roCUH1Rk;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.178, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dc29f1956cso6213475ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 29 Feb 2024 01:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709198813; x=1709803613; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=62oHSC8TASEnSdPmzZ0v9SF+FpRcQIUvuqD/cZa177w=;
        b=roCUH1Rke1PH2FprzbjbyELOaXdS10g+X1fpcjZI5FwLZ02WveEFU+GQIYM+Ob8+kS
         +AY182vakcPdMis1rETL9UdGvS32vcFAbTWUjHO8ygOXCxXTB8h1YOxBS3tn0bUd4a0C
         kH6435lM0RGXrcYMNTkWMEaM8Nb65i+YG3KRPrk2mFjJbzMBWCxJYtfIpZZoE67f3oXp
         wTWk+lroTr0wVQz3igWOkU4JQyJ29NvYqkQJKD2njX58f+MTtm0jrV3YdtShXmStJUXi
         XqPRgvG43/66hrfYG5bDovU3HcYU9od79NA2qWJv9dSB9BX5xcyK+/JdHShSunpw44IK
         uBUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709198813; x=1709803613;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=62oHSC8TASEnSdPmzZ0v9SF+FpRcQIUvuqD/cZa177w=;
        b=nQclk6L1feMGtH51ls1O4sed8bkP1HAKxukiU4c+CaOkmN/0m59pqV4j9Q8vEd1/BX
         sbtwgGqqwwkGhIqJz5UduTdqqRBHDA8hbyVSIHsqGL2Ypc6NFsvdkznYfkhF6aBXt8By
         E7wizj6NC8GYfUjro+CMQnThROSY6e/ZYICH+7AHZUUUjYMw1BLPEBu7UGEtpSyr6XwY
         y9BIk7lBLPGNR/RVTCtzRo8nticVflacR6cPPWtBfTFBZgQ7wAB9XoKpF/rdnJzNudLl
         eGjSVotWfnHY3oQ+ydugOtWJ5bogz7RU6k7rACOgvTPOGoaoOhJ/pNCZr8kNV12PO/Ca
         5n4g==
X-Gm-Message-State: AOJu0YwcJJn+Nl5I3kl2xrwrC8ipRPK6QfH6CqrjVRuqqxWaEUcKNpOy
	y6NVlgl+MYHLrDySn9oN8bc5PTsf4UdVtweZBkOOpHwgq3db7K2N9mg6Ubtw6hdMVOASvVQ3SDv
	wk+Y=
X-Google-Smtp-Source: AGHT+IFRFLXXu1cm/O7u5c952X8KN7Y+2RDbc+Fh+Mo4IdExOUE1o3Hx0f9d7YS/g0IZZuSbQ9Szgg==
X-Received: by 2002:a17:902:6847:b0:1dc:b73b:ec35 with SMTP id f7-20020a170902684700b001dcb73bec35mr1125074pln.4.1709198812563;
        Thu, 29 Feb 2024 01:26:52 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id q15-20020a170902a3cf00b001db3efca159sm970875plb.132.2024.02.29.01.26.51
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 01:26:52 -0800 (PST)
Message-ID: <65e04ddc.170a0220.3ca89.2a1f@mx.google.com>
Date: Thu, 29 Feb 2024 01:26:52 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.209-cip44-56-g55117716ac0fd
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-cip-nfs: 9 runs,
 7 regressions (v5.10.209-cip44-56-g55117716ac0fd)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 29 Feb 2024 09:27:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15102

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-cip-nfs: 9 runs, 7 regr=
essions (v5.10.209-cip44-56-g55117716ac0fd)

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


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.209-cip44-56-g55117716ac0fd/plan/baseline=
-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.209-cip44-56-g55117716ac0fd
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      55117716ac0fd541adb5a35e66eb21c45107b040 =



Test Regressions
---------------- =



platform                 | arch  | lab         | compiler | defconfig      =
     | regressions
-------------------------+-------+-------------+----------+----------------=
-----+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | multi_v7_defcon=
fig  | 1          =


  Details:     https://kernelci.org/test/plan/id/65e03f542a5a3c4e1e637025

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm/multi_v7_defconfig/gcc-1=
0/lab-broonie/baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm/multi_v7_defconfig/gcc-1=
0/lab-broonie/baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65e03f542a5a3=
c4e1e637026
        failing since 523 days (last pass: v5.10.131-cip13-493-ge1293082790=
43, first fail: v5.10.140-cip16-261-g8fa62effa305f) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
     | regressions
-------------------------+-------+-------------+----------+----------------=
-----+------------
beaglebone-black         | arm   | lab-cip     | gcc-10   | multi_v7_defcon=
fig  | 1          =


  Details:     https://kernelci.org/test/plan/id/65e04185d36e6ad4ac637057

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm/multi_v7_defconfig/gcc-1=
0/lab-cip/baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm/multi_v7_defconfig/gcc-1=
0/lab-cip/baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65e04185d36e6=
ad4ac637058
        failing since 523 days (last pass: v5.10.131-cip13-493-ge1293082790=
43, first fail: v5.10.140-cip16-261-g8fa62effa305f) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
     | regressions
-------------------------+-------+-------------+----------+----------------=
-----+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | omap2plus_defco=
nfig | 1          =


  Details:     https://kernelci.org/test/plan/id/65e0415ec213e866f66371df

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm/omap2plus_defconfig/gcc-=
10/lab-broonie/baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm/omap2plus_defconfig/gcc-=
10/lab-broonie/baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65e0415ec213e=
866f66371e0
        failing since 523 days (last pass: v5.10.131-cip13-493-ge1293082790=
43, first fail: v5.10.140-cip16-261-g8fa62effa305f) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
     | regressions
-------------------------+-------+-------------+----------+----------------=
-----+------------
beaglebone-black         | arm   | lab-cip     | gcc-10   | omap2plus_defco=
nfig | 1          =


  Details:     https://kernelci.org/test/plan/id/65e049568d523e8b4e63702b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm/omap2plus_defconfig/gcc-=
10/lab-cip/baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm/omap2plus_defconfig/gcc-=
10/lab-cip/baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65e049568d523=
e8b4e63702c
        failing since 523 days (last pass: v5.10.131-cip13-493-ge1293082790=
43, first fail: v5.10.140-cip16-261-g8fa62effa305f) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
     | regressions
-------------------------+-------+-------------+----------+----------------=
-----+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
     | 1          =


  Details:     https://kernelci.org/test/plan/id/65e04426acc1c775bc6370fc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm64/defconfig/gcc-10/lab-c=
ip/baseline-cip-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm64/defconfig/gcc-10/lab-c=
ip/baseline-cip-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65e04426acc1c=
775bc6370fd
        failing since 118 days (last pass: v5.10.138-cip15-90-gd4130d0ee3c7=
, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
     | regressions
-------------------------+-------+-------------+----------+----------------=
-----+------------
r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
     | 1          =


  Details:     https://kernelci.org/test/plan/id/65e046c1cfdd44c7ba63702d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm64/defconfig/gcc-10/lab-c=
ip/baseline-cip-nfs-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm64/defconfig/gcc-10/lab-c=
ip/baseline-cip-nfs-r8a774b1-hihope-rzg2n-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65e046c1cfdd4=
4c7ba63702e
        failing since 118 days (last pass: v5.10.138-cip15-90-gd4130d0ee3c7=
, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
     | regressions
-------------------------+-------+-------------+----------+----------------=
-----+------------
r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig      =
     | 1          =


  Details:     https://kernelci.org/test/plan/id/65e0447f2b2887345063702e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm64/defconfig/gcc-10/lab-c=
ip/baseline-cip-nfs-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm64/defconfig/gcc-10/lab-c=
ip/baseline-cip-nfs-r8a774c0-ek874.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65e0447f2b288=
7345063702f
        failing since 118 days (last pass: v5.10.138-cip15-90-gd4130d0ee3c7=
, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =20

