Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93EBC7EE2E
	for <webhook@archiver.kernel.org>; Sat, 25 Feb 2023 19:25:59 +0000 (UTC)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.web10.51281.1677353157259143916
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 25 Feb 2023 11:25:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=cipM/4gZ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.169, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f169.google.com with SMTP id cp12so605716pfb.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 25 Feb 2023 11:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8EdT+Rnxd+DwwuVyqPOd07b2KX0vg+JriYSuJNJBDIo=;
        b=cipM/4gZXamxZE3vq+Wb/TlAMEY7oMEo4DLHubb3jJSFYC289LGzal1DGpZyEkhzCe
         lZfvFwcCKp+ZZzXQTlMq/3dvlddYmuH3YZ3ASAHwPadnQKummq2vfMv8wGVBJqAdZdQ7
         ZudkYzf8GKsix+3UUFBmA61bvpY2XifLwjg8ze6WuWI/M0gQ4aPEmom46HskKkmG8f8p
         hi0roI4tWpDLMZGGhgslhiaVgKQ405dsQEl1EOHu0lJ8IM/Rpt3JD0ssG7Kzab5t4pJv
         QyGnvajZbkoUdk2B0AWvDipuJRiJReXdAa4G/yuRDZKgK5zlmMSSfNBL8S5tFoqm/ba9
         2E/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8EdT+Rnxd+DwwuVyqPOd07b2KX0vg+JriYSuJNJBDIo=;
        b=yPYv1RF1Y3O7O5Ov9TILqzd46JYfJ7Q542o2Jun+s755la2wzxCaZ1+9FbhpR35yY1
         oE0KD4+b9znFa1Z8H8V6M03eT3hlO39B6pn8ukrdq2VKnx23PGY3GCZ9uHvr7CLZi4Eq
         uD8lnm0+Hua5aPkEQ3aAUduiANpWoZ3m/WIueUjrli/9niH84gNDvKTMRz1qE29fauLW
         oCED6KaR6d5O2CzM6Pu/MIL7hi1kLHoWYaRRwh1bSKFHc4g7jgOITygQzwfOcabqHi2O
         ljz1MEElPQ6D5jFXaZCsEXY99Z96a1hcYeHqAFmiEVmD/iOLl1kP5A4IzfAM6gU63Gtd
         Do4g==
X-Gm-Message-State: AO0yUKXAdc44WGljnWRCUmko1mlzu9jDEB7QsxeYbrz1VKr1Nlew9IF7
	kaqpOmTiNbh7thB20D5BuEIlcFWIzAUv986aNdQ=
X-Google-Smtp-Source: AK7set8jTJgtZQzXGQOvj9HJmpDGRD7tdVtecgon1AGO20GobQyJB9+T7pCI0j1wYdl4wgEN3Fp9ug==
X-Received: by 2002:a05:6a00:c83:b0:5a8:16b7:ce6e with SMTP id a3-20020a056a000c8300b005a816b7ce6emr3865304pfv.10.1677353156434;
        Sat, 25 Feb 2023 11:25:56 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e13-20020aa78c4d000000b005a75d85c0c7sm1538926pfd.51.2023.02.25.11.25.55
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 11:25:56 -0800 (PST)
Message-ID: <63fa60c4.a70a0220.34c45.27f6@mx.google.com>
Date: Sat, 25 Feb 2023 11:25:56 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.168-cip27-86-g19cf8cd2dd993
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 113 runs,
 6 regressions (v5.10.168-cip27-86-g19cf8cd2dd993)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 25 Feb 2023 19:25:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10847

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 113 runs, 6 regression=
s (v5.10.168-cip27-86-g19cf8cd2dd993)

Regressions Summary
-------------------

platform               | arch   | lab         | compiler | defconfig       =
             | regressions
-----------------------+--------+-------------+----------+-----------------=
-------------+------------
qemu_i386-uefi         | i386   | lab-broonie | gcc-10   | i386_defconfig  =
             | 1          =

qemu_x86_64-uefi       | x86_64 | lab-broonie | gcc-10   | x86_64_defconfig=
             | 1          =

qemu_x86_64-uefi       | x86_64 | lab-broonie | gcc-10   | x86_64_defcon...=
6-chromebook | 1          =

qemu_x86_64-uefi-mixed | x86_64 | lab-broonie | gcc-10   | x86_64_defconfig=
             | 1          =

qemu_x86_64-uefi-mixed | x86_64 | lab-broonie | gcc-10   | x86_64_defcon...=
6-chromebook | 1          =

r8a7743-iwg20d-q7      | arm    | lab-cip     | gcc-10   | shmobile_defconf=
ig           | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.168-cip27-86-g19cf8cd2dd993/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.168-cip27-86-g19cf8cd2dd993
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      19cf8cd2dd99376e3a8b44aa56fbc1e1f7bfb770 =



Test Regressions
---------------- =



platform               | arch   | lab         | compiler | defconfig       =
             | regressions
-----------------------+--------+-------------+----------+-----------------=
-------------+------------
qemu_i386-uefi         | i386   | lab-broonie | gcc-10   | i386_defconfig  =
             | 1          =


  Details:     https://kernelci.org/test/plan/id/63fa53d89fe605d8d68c8668

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: i386_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-86-g19cf8cd2dd993/i386/i386_defconfig/gcc-10/l=
ab-broonie/baseline-qemu_i386-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-86-g19cf8cd2dd993/i386/i386_defconfig/gcc-10/l=
ab-broonie/baseline-qemu_i386-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63fa53d89fe605d8d68c8=
669
        failing since 3 days (last pass: v5.10.165-cip25-154-gb7e05ba4f61a2=
, first fail: v5.10.167-cip26-2-g1e87e7748b91) =

 =



platform               | arch   | lab         | compiler | defconfig       =
             | regressions
-----------------------+--------+-------------+----------+-----------------=
-------------+------------
qemu_x86_64-uefi       | x86_64 | lab-broonie | gcc-10   | x86_64_defconfig=
             | 1          =


  Details:     https://kernelci.org/test/plan/id/63fa51f93bf0be7c9e8c8634

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-86-g19cf8cd2dd993/x86_64/x86_64_defconfig/gcc-=
10/lab-broonie/baseline-qemu_x86_64-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-86-g19cf8cd2dd993/x86_64/x86_64_defconfig/gcc-=
10/lab-broonie/baseline-qemu_x86_64-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63fa51f93bf0be7c9e8c8=
635
        failing since 3 days (last pass: v5.10.165-cip25-154-gb7e05ba4f61a2=
, first fail: v5.10.167-cip26-2-g1e87e7748b91) =

 =



platform               | arch   | lab         | compiler | defconfig       =
             | regressions
-----------------------+--------+-------------+----------+-----------------=
-------------+------------
qemu_x86_64-uefi       | x86_64 | lab-broonie | gcc-10   | x86_64_defcon...=
6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63fa54c9d61c1cd0528c862f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-86-g19cf8cd2dd993/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-broonie/baseline-qemu_x86_64-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-86-g19cf8cd2dd993/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-broonie/baseline-qemu_x86_64-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63fa54c9d61c1cd0528c8=
630
        failing since 3 days (last pass: v5.10.165-cip25-154-gb7e05ba4f61a2=
, first fail: v5.10.167-cip26-2-g1e87e7748b91) =

 =



platform               | arch   | lab         | compiler | defconfig       =
             | regressions
-----------------------+--------+-------------+----------+-----------------=
-------------+------------
qemu_x86_64-uefi-mixed | x86_64 | lab-broonie | gcc-10   | x86_64_defconfig=
             | 1          =


  Details:     https://kernelci.org/test/plan/id/63fa5270306a9faf768c867b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-86-g19cf8cd2dd993/x86_64/x86_64_defconfig/gcc-=
10/lab-broonie/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-86-g19cf8cd2dd993/x86_64/x86_64_defconfig/gcc-=
10/lab-broonie/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63fa5270306a9faf768c8=
67c
        failing since 3 days (last pass: v5.10.165-cip25-154-gb7e05ba4f61a2=
, first fail: v5.10.167-cip26-2-g1e87e7748b91) =

 =



platform               | arch   | lab         | compiler | defconfig       =
             | regressions
-----------------------+--------+-------------+----------+-----------------=
-------------+------------
qemu_x86_64-uefi-mixed | x86_64 | lab-broonie | gcc-10   | x86_64_defcon...=
6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63fa552d92f6a136548c8644

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-86-g19cf8cd2dd993/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-broonie/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-86-g19cf8cd2dd993/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-broonie/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63fa552d92f6a136548c8=
645
        failing since 3 days (last pass: v5.10.165-cip25-154-gb7e05ba4f61a2=
, first fail: v5.10.167-cip26-2-g1e87e7748b91) =

 =



platform               | arch   | lab         | compiler | defconfig       =
             | regressions
-----------------------+--------+-------------+----------+-----------------=
-------------+------------
r8a7743-iwg20d-q7      | arm    | lab-cip     | gcc-10   | shmobile_defconf=
ig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63fa517dfe4896428b8c8634

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-86-g19cf8cd2dd993/arm/shmobile_defconfig/gcc-1=
0/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-86-g19cf8cd2dd993/arm/shmobile_defconfig/gcc-1=
0/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63fa517dfe4896428b8c8=
635
        failing since 3 days (last pass: v5.10.165-cip25-154-gb7e05ba4f61a2=
, first fail: v5.10.167-cip26-2-g1e87e7748b91) =

 =20

