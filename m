Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1120AC61D9D
	for <webhook@archiver.kernel.org>; Wed, 22 Nov 2023 20:04:52 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
 by mx.groups.io with SMTP id smtpd.web10.34262.1700683484599984908
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 22 Nov 2023 12:04:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=PJliu7HU;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.178, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6b1d1099a84so210909b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 22 Nov 2023 12:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700683483; x=1701288283; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=N0UlUOtevLy4Yol18oMf6l35BOiWvj+2bj7DKKfwlkc=;
        b=PJliu7HUJf4J0YxnneSFXA89hDNWTRFuzranp+TZa6Ds7hLop3YJwA/niVd0OdtKNv
         hF2/dFHrKj+tUgfmOe+qNQceIAfNs5NAJOICWXh3gPf8nI0Z0R9MiMyJIvsEUYBXTG8P
         zERtJDAPw7OFsixI1RSLmD1VMyELQaH70QhmbrxHmkhBoR8AtSvo21mtsQjH2Sp4fmSD
         q9FrpgGTgY+YG2LOmgBjfVmGMftxW50W29j4rx/nBms4iPUrwk/8p7gTIJpM5NDZM5/n
         htFNYudf6D1yUvHrJMbQ6akDT+b2qaKIVj/BmSKYGn31NDxinnvL2oumyxEqiR34LZ/o
         SuSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700683483; x=1701288283;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N0UlUOtevLy4Yol18oMf6l35BOiWvj+2bj7DKKfwlkc=;
        b=BNlhr16uzIDxtpCC5MWFGMZPSkvPRWEVSznsQOk3MeoSAtSIKnERS6gN+bArFWP9oA
         1QUvVtcavg3hvPAKhjaDhsX1prOgU/ueAE3Q1PmrIBSy4IDDZAiI1TbEsEybitSohi7C
         hnzBd7+OdWRYe+YiTLKgdzwtu2Gq9gCLmS7CJszPterGB9wnbjSkMwYhQqKsTrFDpVqi
         eV/VMBrJ1nzoaNbm9HSwnYitMJCQ8CZBwqY+XInDZzOBnRTB3CHoctTsIhXSi4BwEFJ3
         YDNXO0hAssMHMyUrALbEn0d/0/h5i64dLwYZ/rF6tqTgZMUcuGV29iUW97EpqywvPRTc
         +plw==
X-Gm-Message-State: AOJu0YypirnwaGj/+7nxKzvLZ7/X92WMt79QUuvWILbaG1OX5yN6GVGl
	YG+XNnA3l+zQLZEu/uvF9N0dXhpBTTFknXBF2+4=
X-Google-Smtp-Source: AGHT+IH5j26CSs+Vmn4a9yyzw5cTfOx40jNey5+RRlWvaDP8+DCysszpX4slbqwioIJufLx4UCuFvw==
X-Received: by 2002:a05:6a20:144f:b0:187:ef24:358 with SMTP id a15-20020a056a20144f00b00187ef240358mr3664335pzi.60.1700683483351;
        Wed, 22 Nov 2023 12:04:43 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j4-20020a63ec04000000b005b8f3293bf2sm73836pgh.88.2023.11.22.12.04.42
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 12:04:42 -0800 (PST)
Message-ID: <655e5eda.630a0220.36778.06e4@mx.google.com>
Date: Wed, 22 Nov 2023 12:04:42 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.200-cip40-188-g33d0b44cd71d
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-cip-nfs: 8 runs,
 6 regressions (v5.10.200-cip40-188-g33d0b44cd71d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Nov 2023 20:04:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13641

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-cip-nfs: 8 runs, 6 regr=
essions (v5.10.200-cip40-188-g33d0b44cd71d)

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

beaglebone-black         | arm   | lab-cip     | gcc-10   | omap2plus_defco=
nfig | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
     | 1          =

r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
     | 1          =

r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig      =
     | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.200-cip40-188-g33d0b44cd71d/plan/baseline=
-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.200-cip40-188-g33d0b44cd71d
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      33d0b44cd71d9f81944784e605bc1def7fa0b71e =



Test Regressions
---------------- =



platform                 | arch  | lab         | compiler | defconfig      =
     | regressions
-------------------------+-------+-------------+----------+----------------=
-----+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | multi_v7_defcon=
fig  | 1          =


  Details:     https://kernelci.org/test/plan/id/655e59b02de5b76c677e4ab8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm/multi_v7_defconfig/gcc-1=
0/lab-broonie/baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm/multi_v7_defconfig/gcc-1=
0/lab-broonie/baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/655e59b02de5b=
76c677e4ab9
        failing since 424 days (last pass: v5.10.131-cip13-493-ge1293082790=
43, first fail: v5.10.140-cip16-261-g8fa62effa305f) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
     | regressions
-------------------------+-------+-------------+----------+----------------=
-----+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | omap2plus_defco=
nfig | 1          =


  Details:     https://kernelci.org/test/plan/id/655e55110ca86f311b7e4a7c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm/omap2plus_defconfig/gcc-=
10/lab-broonie/baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm/omap2plus_defconfig/gcc-=
10/lab-broonie/baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/655e55110ca86=
f311b7e4a7d
        failing since 424 days (last pass: v5.10.131-cip13-493-ge1293082790=
43, first fail: v5.10.140-cip16-261-g8fa62effa305f) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
     | regressions
-------------------------+-------+-------------+----------+----------------=
-----+------------
beaglebone-black         | arm   | lab-cip     | gcc-10   | omap2plus_defco=
nfig | 1          =


  Details:     https://kernelci.org/test/plan/id/655e59b72de5b76c677e4abe

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm/omap2plus_defconfig/gcc-=
10/lab-cip/baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm/omap2plus_defconfig/gcc-=
10/lab-cip/baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/655e59b72de5b=
76c677e4abf
        failing since 424 days (last pass: v5.10.131-cip13-493-ge1293082790=
43, first fail: v5.10.140-cip16-261-g8fa62effa305f) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
     | regressions
-------------------------+-------+-------------+----------+----------------=
-----+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
     | 1          =


  Details:     https://kernelci.org/test/plan/id/655e5297576232149d7e4a80

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm64/defconfig/gcc-10/lab-c=
ip/baseline-cip-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm64/defconfig/gcc-10/lab-c=
ip/baseline-cip-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/655e529757623=
2149d7e4a81
        failing since 20 days (last pass: v5.10.138-cip15-90-gd4130d0ee3c7,=
 first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
     | regressions
-------------------------+-------+-------------+----------+----------------=
-----+------------
r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
     | 1          =


  Details:     https://kernelci.org/test/plan/id/655e54158338354c717e4a7d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm64/defconfig/gcc-10/lab-c=
ip/baseline-cip-nfs-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm64/defconfig/gcc-10/lab-c=
ip/baseline-cip-nfs-r8a774b1-hihope-rzg2n-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/655e541583383=
54c717e4a7e
        failing since 20 days (last pass: v5.10.138-cip15-90-gd4130d0ee3c7,=
 first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
     | regressions
-------------------------+-------+-------------+----------+----------------=
-----+------------
r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig      =
     | 1          =


  Details:     https://kernelci.org/test/plan/id/655e52353255545aa57e4a73

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm64/defconfig/gcc-10/lab-c=
ip/baseline-cip-nfs-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm64/defconfig/gcc-10/lab-c=
ip/baseline-cip-nfs-r8a774c0-ek874.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/655e523532555=
45aa57e4a74
        failing since 20 days (last pass: v5.10.138-cip15-90-gd4130d0ee3c7,=
 first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =20

