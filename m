Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEADC43334
	for <webhook@archiver.kernel.org>; Fri, 15 Jul 2022 12:21:15 +0000 (UTC)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by mx.groups.io with SMTP id smtpd.web09.5815.1657887673680774794
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 15 Jul 2022 05:21:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=EMKDOF/3;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.172,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f172.google.com with SMTP id r186so4267762pgr.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 15 Jul 2022 05:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=SP1Hh0TcDYmG7WMAB9aYDU9LugF7nn5EW55HBBVvpm4=;
        b=EMKDOF/3qr84QCSgzxwjm04Hu1mSmXOTFFE6JTpL1R9WORbBwy/IQNmrJSaiWrs1rO
         MvZPhtgCaVBpfIYShdnEoNjUfaj9SRHRT+RSMiuJvOvm5Ace8zLZBrg2yQmRzUyw16SJ
         xS5I9XbvVFVQxbR7COuYmlLgkeBkuqRX7ZRtri1DPgN79hF0qADq+JXHAxu6VW+KEntw
         1h0rpiUVTq1Kcz7WHTJE0O/TKhFhSQNrzseWMl7GvTuioxd6dMs6cALeMrm4T6QZwxIR
         ehrJ+X8qZObj4DmYh3TwVVoo4kmzpTkaphPRnkGLJclzKjwGaW34Ls5ba/auuEW33F2r
         kX0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=SP1Hh0TcDYmG7WMAB9aYDU9LugF7nn5EW55HBBVvpm4=;
        b=U2TmVXyNo4yNJrfb9NWWBhd2CACVu2IBkaZqNZVIz9Dmtkvfa4dA5i7nDGrLVka95d
         AW2QLOoWL0ylht9WWuzs5kOEGdSL4yvSIpfQJULDflxol64tTBOJZ2RVCzoCmpN5pWZ9
         S3m3MbmN2JkGctXwNhtRLnhmWYssRkgJKmXPNC4YFLIXgg0sKei6EJYAQSN4p/4FfQVi
         zOrOieNI3nYDTg3dlChDQ1KXPN2As6ixAgZJ5EQE9BSn7MBjQrifheuEM7D3I06y1e57
         s1zf9u2tvQb6T6QVr2pMvEecRc868umisX7g80sYRFqYBCP3o/DcS7RjUADc+vGimouZ
         thsg==
X-Gm-Message-State: AJIora/9LD/PCsRCqvAHbYg7SThb72hzh3Qje59eGtWjJaJuFhCy72Ds
	JYXB4znzS4SSanUduOKbfPnKh+VH+DBfqdEh
X-Google-Smtp-Source: 
 AGRyM1tPOLXT2Eo16NJJo4Mj2YR3w9+O8GZFnzQUx3Ry4z6b7guphXlehHFpgV8cJOWRTlzCEusIuA==
X-Received: by 2002:a63:f90d:0:b0:419:b112:91ea with SMTP id
 h13-20020a63f90d000000b00419b11291eamr7760034pgi.592.1657887672718;
        Fri, 15 Jul 2022 05:21:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 oj4-20020a17090b4d8400b001ef8fb72224sm5522359pjb.53.2022.07.15.05.21.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 05:21:12 -0700 (PDT)
Message-ID: <62d15bb8.1c69fb81.60223.8c7e@mx.google.com>
Date: Fri, 15 Jul 2022 05:21:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.129-cip12-59-ge5b19636ca9c4
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 121 runs,
 10 regressions (v5.10.129-cip12-59-ge5b19636ca9c4)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 15 Jul 2022 12:21:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8830

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 121 runs, 10 regressio=
ns (v5.10.129-cip12-59-ge5b19636ca9c4)

Regressions Summary
-------------------

platform                   | arch  | lab          | compiler | defconfig   =
       | regressions
---------------------------+-------+--------------+----------+-------------=
-------+------------
jetson-tk1                 | arm   | lab-baylibre | gcc-10   | multi_v7_def=
config | 1          =

jetson-tk1                 | arm   | lab-baylibre | gcc-10   | tegra_defcon=
fig    | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-baylibre | gcc-10   | defconfig   =
       | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-broonie  | gcc-10   | defconfig   =
       | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-baylibre | gcc-10   | defconfig   =
       | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie  | gcc-10   | defconfig   =
       | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-baylibre | gcc-10   | defconfig   =
       | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-broonie  | gcc-10   | defconfig   =
       | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-baylibre | gcc-10   | defconfig   =
       | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie  | gcc-10   | defconfig   =
       | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.129-cip12-59-ge5b19636ca9c4/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.129-cip12-59-ge5b19636ca9c4
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      e5b19636ca9c43e262a365d756d491479adb3884 =



Test Regressions
---------------- =



platform                   | arch  | lab          | compiler | defconfig   =
       | regressions
---------------------------+-------+--------------+----------+-------------=
-------+------------
jetson-tk1                 | arm   | lab-baylibre | gcc-10   | multi_v7_def=
config | 1          =


  Details:     https://kernelci.org/test/plan/id/62d151b55047525569a39bcd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-59-ge5b19636ca9c4/arm/multi_v7_defconfig/gcc-1=
0/lab-baylibre/baseline-jetson-tk1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-59-ge5b19636ca9c4/arm/multi_v7_defconfig/gcc-1=
0/lab-baylibre/baseline-jetson-tk1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220708.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62d151b55047525569a39=
bce
        failing since 45 days (last pass: v5.10.112-cip6-289-g2969e096d186,=
 first fail: v5.10.118-465-g0af29783a3c9) =

 =



platform                   | arch  | lab          | compiler | defconfig   =
       | regressions
---------------------------+-------+--------------+----------+-------------=
-------+------------
jetson-tk1                 | arm   | lab-baylibre | gcc-10   | tegra_defcon=
fig    | 1          =


  Details:     https://kernelci.org/test/plan/id/62d14e32c1224bf495a39bde

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: tegra_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-59-ge5b19636ca9c4/arm/tegra_defconfig/gcc-10/l=
ab-baylibre/baseline-jetson-tk1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-59-ge5b19636ca9c4/arm/tegra_defconfig/gcc-10/l=
ab-baylibre/baseline-jetson-tk1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220708.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62d14e32c1224bf495a39=
bdf
        failing since 45 days (last pass: v5.10.112-cip6-289-g2969e096d186,=
 first fail: v5.10.118-465-g0af29783a3c9) =

 =



platform                   | arch  | lab          | compiler | defconfig   =
       | regressions
---------------------------+-------+--------------+----------+-------------=
-------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-baylibre | gcc-10   | defconfig   =
       | 1          =


  Details:     https://kernelci.org/test/plan/id/62d152558b61ab73a0a39bcd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-59-ge5b19636ca9c4/arm64/defconfig/gcc-10/lab-b=
aylibre/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-59-ge5b19636ca9c4/arm64/defconfig/gcc-10/lab-b=
aylibre/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220708.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62d152558b61ab73a0a39=
bce
        failing since 66 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6,=
 first fail: v5.10.112-cip6-218-g8253434cd56a) =

 =



platform                   | arch  | lab          | compiler | defconfig   =
       | regressions
---------------------------+-------+--------------+----------+-------------=
-------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-broonie  | gcc-10   | defconfig   =
       | 1          =


  Details:     https://kernelci.org/test/plan/id/62d154c76288de7dd5a39bcd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-59-ge5b19636ca9c4/arm64/defconfig/gcc-10/lab-b=
roonie/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-59-ge5b19636ca9c4/arm64/defconfig/gcc-10/lab-b=
roonie/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220708.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62d154c76288de7dd5a39=
bce
        failing since 66 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6,=
 first fail: v5.10.112-cip6-218-g8253434cd56a) =

 =



platform                   | arch  | lab          | compiler | defconfig   =
       | regressions
---------------------------+-------+--------------+----------+-------------=
-------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-baylibre | gcc-10   | defconfig   =
       | 1          =


  Details:     https://kernelci.org/test/plan/id/62d15254b23aec9ce4a39bfb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-59-ge5b19636ca9c4/arm64/defconfig/gcc-10/lab-b=
aylibre/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-59-ge5b19636ca9c4/arm64/defconfig/gcc-10/lab-b=
aylibre/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220708.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62d15254b23aec9ce4a39=
bfc
        failing since 66 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6,=
 first fail: v5.10.112-cip6-218-g8253434cd56a) =

 =



platform                   | arch  | lab          | compiler | defconfig   =
       | regressions
---------------------------+-------+--------------+----------+-------------=
-------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie  | gcc-10   | defconfig   =
       | 1          =


  Details:     https://kernelci.org/test/plan/id/62d15387e16573e733a39bda

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-59-ge5b19636ca9c4/arm64/defconfig/gcc-10/lab-b=
roonie/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-59-ge5b19636ca9c4/arm64/defconfig/gcc-10/lab-b=
roonie/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220708.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62d15387e16573e733a39=
bdb
        failing since 66 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6,=
 first fail: v5.10.112-cip6-218-g8253434cd56a) =

 =



platform                   | arch  | lab          | compiler | defconfig   =
       | regressions
---------------------------+-------+--------------+----------+-------------=
-------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-baylibre | gcc-10   | defconfig   =
       | 1          =


  Details:     https://kernelci.org/test/plan/id/62d15252b23aec9ce4a39bf5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-59-ge5b19636ca9c4/arm64/defconfig/gcc-10/lab-b=
aylibre/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-59-ge5b19636ca9c4/arm64/defconfig/gcc-10/lab-b=
aylibre/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220708.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62d15252b23aec9ce4a39=
bf6
        failing since 66 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6,=
 first fail: v5.10.112-cip6-218-g8253434cd56a) =

 =



platform                   | arch  | lab          | compiler | defconfig   =
       | regressions
---------------------------+-------+--------------+----------+-------------=
-------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-broonie  | gcc-10   | defconfig   =
       | 1          =


  Details:     https://kernelci.org/test/plan/id/62d1535e90be4e16aba39bfb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-59-ge5b19636ca9c4/arm64/defconfig/gcc-10/lab-b=
roonie/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-59-ge5b19636ca9c4/arm64/defconfig/gcc-10/lab-b=
roonie/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220708.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62d1535e90be4e16aba39=
bfc
        failing since 66 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6,=
 first fail: v5.10.112-cip6-218-g8253434cd56a) =

 =



platform                   | arch  | lab          | compiler | defconfig   =
       | regressions
---------------------------+-------+--------------+----------+-------------=
-------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-baylibre | gcc-10   | defconfig   =
       | 1          =


  Details:     https://kernelci.org/test/plan/id/62d15253fb50851ca0a39bd6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-59-ge5b19636ca9c4/arm64/defconfig/gcc-10/lab-b=
aylibre/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-59-ge5b19636ca9c4/arm64/defconfig/gcc-10/lab-b=
aylibre/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220708.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62d15253fb50851ca0a39=
bd7
        failing since 66 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6,=
 first fail: v5.10.112-cip6-218-g8253434cd56a) =

 =



platform                   | arch  | lab          | compiler | defconfig   =
       | regressions
---------------------------+-------+--------------+----------+-------------=
-------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie  | gcc-10   | defconfig   =
       | 1          =


  Details:     https://kernelci.org/test/plan/id/62d15373664d535ecea39bf4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-59-ge5b19636ca9c4/arm64/defconfig/gcc-10/lab-b=
roonie/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-59-ge5b19636ca9c4/arm64/defconfig/gcc-10/lab-b=
roonie/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220708.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62d15373664d535ecea39=
bf5
        failing since 66 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6,=
 first fail: v5.10.112-cip6-218-g8253434cd56a) =

 =20

