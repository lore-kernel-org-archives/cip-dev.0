X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web10.35.1652369103182335202
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 12 May 2022 08:25:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=AqDBxBCz;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.176, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f176.google.com with SMTP id d17so5237008plg.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 12 May 2022 08:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=pqHyr/Uzbc9lESqnTH2oXDtQTe3dzKl6RjBorxX/bck=;
        b=AqDBxBCzQkpIV5ozWz1tydV0hYIHQBC+SZiBpUMSThPR40P/oB7ClbCXZLmsdJ//6/
         QjCITdUZo26EGgCb51jhmZrbqYmxmy5EKAzfKpFY9JAdoYFoHiZHdUThCEC8NwIIDrhi
         OiKSZlGQFdIhMmBzOBh0i/pWoQJEyVYsa7Jb0KyS8e2di7gw0028fd1rVJuXadMo9BCY
         D2bafPDs3d/Pn90xtBt/mB0GDnh+rRAl3SXyIHuxA/mQ/ShE81XC1CsJyLOfLntY82h5
         NRbs94YiEMEM1rbfIWRgE7/fII315MdUF+72r5eDJiUl03j4yo8ZTqD2SlFM7zTG3pyS
         we6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=pqHyr/Uzbc9lESqnTH2oXDtQTe3dzKl6RjBorxX/bck=;
        b=0T0QNflXOzeaIFlu5LXXfoG8MeDfXHEcXOHSPb3szUMw6rHbqLzTMG4XZ83ESft4bW
         NXqwQaE+O32O5XChGgOfQa8rKiNvJ5K6jyGkmL0oZIpnAVCdQ8kTBVc/hy4mSIc0cSz7
         tU40mf6kfgG/MF2NuZMHtYJ9G5g2WO5h1vMJV3Wf2GqGc0qPHsgvePYDPTkzgkLRwOTu
         vGQFwyzF588U2mNxYc65c1OcCIwXna4oNRBUoEr+V4zJWUQMnLGd/VTQLP5K0ARem13j
         Gvf78H9JNBJXmwzjPIZBgxRh3F0tdSWaeHLtYeFuVFdCYybuXbQrtFy2ul4le/qjND9a
         0ugg==
X-Gm-Message-State: AOAM532PR7Gle3eVO/Hi4GbVWOr+RGaqBOfuKKdBpeUmttubRE9/beTx
	ckkpVBohiFqCSu3/G0iYZjPRRcGmP6mVXS/lhJs=
X-Google-Smtp-Source: ABdhPJzZVlc3ilpChkIZUhISyPHCZSs8i64QY3ko/q4H4EIADGDSApg6/sKub/IjpzvrDK27RbR/yQ==
X-Received: by 2002:a17:903:2348:b0:15f:2b4a:29c2 with SMTP id c8-20020a170903234800b0015f2b4a29c2mr275280plh.37.1652369102395;
        Thu, 12 May 2022 08:25:02 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id o12-20020a170902d4cc00b0015ebb3bf277sm6218plg.238.2022.05.12.08.25.01
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 08:25:02 -0700 (PDT)
Message-ID: <627d26ce.1c69fb81.c8755.003c@mx.google.com>
Date: Thu, 12 May 2022 08:25:02 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.112-cip6-289-g2969e096d186
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 134 runs, 12 regressions (v5.10.112-cip6-289-g2969e096d186) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 134 runs, 12 regressio=
ns (v5.10.112-cip6-289-g2969e096d186)

Regressions Summary
-------------------

platform                   | arch  | lab          | compiler | defconfig   =
               | regressions
---------------------------+-------+--------------+----------+-------------=
---------------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-baylibre | gcc-10   | defconfig   =
               | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-baylibre | gcc-10   | defconfig+ar=
m64-chromebook | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-broonie  | gcc-10   | defconfig   =
               | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-baylibre | gcc-10   | defconfig   =
               | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-baylibre | gcc-10   | defconfig+ar=
m64-chromebook | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie  | gcc-10   | defconfig   =
               | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-baylibre | gcc-10   | defconfig   =
               | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-baylibre | gcc-10   | defconfig+ar=
m64-chromebook | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-broonie  | gcc-10   | defconfig   =
               | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-baylibre | gcc-10   | defconfig   =
               | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-baylibre | gcc-10   | defconfig+ar=
m64-chromebook | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie  | gcc-10   | defconfig   =
               | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.112-cip6-289-g2969e096d186/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.112-cip6-289-g2969e096d186
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      2969e096d186c13cc3c3fc8927147105d46895c3 =



Test Regressions
---------------- =



platform                   | arch  | lab          | compiler | defconfig   =
               | regressions
---------------------------+-------+--------------+----------+-------------=
---------------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-baylibre | gcc-10   | defconfig   =
               | 1          =


  Details:     https://kernelci.org/test/plan/id/627d1b77412e2cebef8f57a8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.112-cip6-289-g2969e096d186/arm64/defconfig/gcc-10/lab-ba=
ylibre/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.112-cip6-289-g2969e096d186/arm64/defconfig/gcc-10/lab-ba=
ylibre/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627d1b77412e2cebef8f5=
7a9
        failing since 2 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6, =
first fail: v5.10.112-cip6-218-g8253434cd56a) =

 =



platform                   | arch  | lab          | compiler | defconfig   =
               | regressions
---------------------------+-------+--------------+----------+-------------=
---------------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-baylibre | gcc-10   | defconfig+ar=
m64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627d2020ccb49a56c48f573f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.112-cip6-289-g2969e096d186/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.112-cip6-289-g2969e096d186/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627d2020ccb49a56c48f5=
740
        new failure (last pass: v5.10.112-cip6-88-gf3397cadb2dd6) =

 =



platform                   | arch  | lab          | compiler | defconfig   =
               | regressions
---------------------------+-------+--------------+----------+-------------=
---------------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-broonie  | gcc-10   | defconfig   =
               | 1          =


  Details:     https://kernelci.org/test/plan/id/627d235db50965550a8f5748

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.112-cip6-289-g2969e096d186/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.112-cip6-289-g2969e096d186/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627d235db50965550a8f5=
749
        failing since 2 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6, =
first fail: v5.10.112-cip6-218-g8253434cd56a) =

 =



platform                   | arch  | lab          | compiler | defconfig   =
               | regressions
---------------------------+-------+--------------+----------+-------------=
---------------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-baylibre | gcc-10   | defconfig   =
               | 1          =


  Details:     https://kernelci.org/test/plan/id/627d1b79877ae0371c8f5761

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.112-cip6-289-g2969e096d186/arm64/defconfig/gcc-10/lab-ba=
ylibre/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.112-cip6-289-g2969e096d186/arm64/defconfig/gcc-10/lab-ba=
ylibre/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627d1b79877ae0371c8f5=
762
        failing since 2 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6, =
first fail: v5.10.112-cip6-218-g8253434cd56a) =

 =



platform                   | arch  | lab          | compiler | defconfig   =
               | regressions
---------------------------+-------+--------------+----------+-------------=
---------------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-baylibre | gcc-10   | defconfig+ar=
m64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627d20227363e7e19d8f573e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.112-cip6-289-g2969e096d186/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.112-cip6-289-g2969e096d186/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627d20227363e7e19d8f5=
73f
        new failure (last pass: v5.10.112-cip6-88-gf3397cadb2dd6) =

 =



platform                   | arch  | lab          | compiler | defconfig   =
               | regressions
---------------------------+-------+--------------+----------+-------------=
---------------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie  | gcc-10   | defconfig   =
               | 1          =


  Details:     https://kernelci.org/test/plan/id/627d2371389905e6998f5741

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.112-cip6-289-g2969e096d186/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.112-cip6-289-g2969e096d186/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627d2371389905e6998f5=
742
        failing since 2 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6, =
first fail: v5.10.112-cip6-218-g8253434cd56a) =

 =



platform                   | arch  | lab          | compiler | defconfig   =
               | regressions
---------------------------+-------+--------------+----------+-------------=
---------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-baylibre | gcc-10   | defconfig   =
               | 1          =


  Details:     https://kernelci.org/test/plan/id/627d1b756b784dd3668f572d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.112-cip6-289-g2969e096d186/arm64/defconfig/gcc-10/lab-ba=
ylibre/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.112-cip6-289-g2969e096d186/arm64/defconfig/gcc-10/lab-ba=
ylibre/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627d1b756b784dd3668f5=
72e
        failing since 2 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6, =
first fail: v5.10.112-cip6-218-g8253434cd56a) =

 =



platform                   | arch  | lab          | compiler | defconfig   =
               | regressions
---------------------------+-------+--------------+----------+-------------=
---------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-baylibre | gcc-10   | defconfig+ar=
m64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627d2021ecc5bc658e8f5738

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.112-cip6-289-g2969e096d186/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.112-cip6-289-g2969e096d186/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627d2021ecc5bc658e8f5=
739
        new failure (last pass: v5.10.112-cip6-88-gf3397cadb2dd6) =

 =



platform                   | arch  | lab          | compiler | defconfig   =
               | regressions
---------------------------+-------+--------------+----------+-------------=
---------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-broonie  | gcc-10   | defconfig   =
               | 1          =


  Details:     https://kernelci.org/test/plan/id/627d23496d6fa13f618f5764

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.112-cip6-289-g2969e096d186/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.112-cip6-289-g2969e096d186/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627d23496d6fa13f618f5=
765
        failing since 2 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6, =
first fail: v5.10.112-cip6-218-g8253434cd56a) =

 =



platform                   | arch  | lab          | compiler | defconfig   =
               | regressions
---------------------------+-------+--------------+----------+-------------=
---------------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-baylibre | gcc-10   | defconfig   =
               | 1          =


  Details:     https://kernelci.org/test/plan/id/627d1b7b6b784dd3668f5748

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.112-cip6-289-g2969e096d186/arm64/defconfig/gcc-10/lab-ba=
ylibre/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.112-cip6-289-g2969e096d186/arm64/defconfig/gcc-10/lab-ba=
ylibre/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627d1b7b6b784dd3668f5=
749
        failing since 2 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6, =
first fail: v5.10.112-cip6-218-g8253434cd56a) =

 =



platform                   | arch  | lab          | compiler | defconfig   =
               | regressions
---------------------------+-------+--------------+----------+-------------=
---------------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-baylibre | gcc-10   | defconfig+ar=
m64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627d2023da6a9bf9078f571c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.112-cip6-289-g2969e096d186/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.112-cip6-289-g2969e096d186/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627d2023da6a9bf9078f5=
71d
        new failure (last pass: v5.10.112-cip6-88-gf3397cadb2dd6) =

 =



platform                   | arch  | lab          | compiler | defconfig   =
               | regressions
---------------------------+-------+--------------+----------+-------------=
---------------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie  | gcc-10   | defconfig   =
               | 1          =


  Details:     https://kernelci.org/test/plan/id/627d239922758a4c588f5786

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.112-cip6-289-g2969e096d186/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.112-cip6-289-g2969e096d186/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627d239922758a4c588f5=
787
        failing since 2 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6, =
first fail: v5.10.112-cip6-218-g8253434cd56a) =

 =20

