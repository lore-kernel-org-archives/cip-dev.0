X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
 by mx.groups.io with SMTP id smtpd.web08.38562.1653927687257563634
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 30 May 2022 09:21:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=LEdFXN0F;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.49, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f49.google.com with SMTP id d12-20020a17090abf8c00b001e2eb431ce4so3557092pjs.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 30 May 2022 09:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=TaR5NY7aVLElvasQH2XMsaeVsy4bR5IewwRb1//CgGw=;
        b=LEdFXN0FOKC3+fLQFrZhC8os1EukXQ9tp4UlQ6Guhsosy56sovW/ZkDZW8HYVHB7Rb
         5DPpeZxV9wTpb+9JsSlqb2jWM+Mr/T4SLeKSD9X71REmZFQKngJ2fQn42vc1h8w9DFNH
         gp62qdFbYf2etGziVWyOdlEUNIHHXS5oJ+tA5f/Xq/mwE9NxomL92L4vQOt4TgSiy+74
         Ed41ypDvz3Bl3oryKXKgx9M8NFnDif5n1d9URnr+iTh/NLCO+fSmUt6K23Zvl97t8ntK
         7OI3dpO3Tas0Egm1UPamsu5LlK2RSsH8AH+ppW7Xnsxe4f74LYY3obZ+LPXVqbTvEeM1
         N3uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=TaR5NY7aVLElvasQH2XMsaeVsy4bR5IewwRb1//CgGw=;
        b=qPpcZH28yMPYEEo2gwKiCLaaAuB8UovzxROKahhb4DxBLibaRP51EDx0rE/lYp+adA
         q3LyGc79ON3GLy3cLNbAEN6IepNCnFd2wYthGwO9B5z8Ap08PMEDOXSL/q8Uj7fJapUi
         E+fxBxD6J66jVFM0gRPyuOzL91sLdBup1rCRpvHP7VAeDNBsBfLlp2jpTDXef+nnfWOZ
         0aumPONByrqPJTilbOoO+2lQxr1CWMZsMpJAuROa0NTQueuV8b4wm3rws5f0TnGMTMjh
         8zVN8mSP41WcarvWPPU3bpl2KUS+VS0e/M9cdiuWdnHwad4LFfVVLgBCMt2h81TxxXgX
         4q2Q==
X-Gm-Message-State: AOAM530uiL8QunV+4UvOC7nde9izM/IOhcgpqNFyIgtZJ0qr4+ZEDAyQ
	yOYSJ8tKs9TAdHKL8e7ME4EbehgSpXLmzmCN3NM=
X-Google-Smtp-Source: ABdhPJzd7b4t2kOBCYyDKbt8++crOTEdZzy9e4202l9vcLxG1bINaVRbwbJwU9zdfnLjJC8dnLz/pA==
X-Received: by 2002:a17:90b:388c:b0:1e2:f376:b8d with SMTP id mu12-20020a17090b388c00b001e2f3760b8dmr7144963pjb.148.1653927686332;
        Mon, 30 May 2022 09:21:26 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d10-20020aa797aa000000b0051826824d90sm9267117pfq.177.2022.05.30.09.21.25
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 09:21:25 -0700 (PDT)
Message-ID: <6294ef05.1c69fb81.e9dc3.453a@mx.google.com>
Date: Mon, 30 May 2022 09:21:25 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.118-465-g0af29783a3c9
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 151 runs, 19 regressions (v5.10.118-465-g0af29783a3c9) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 151 runs, 19 regressio=
ns (v5.10.118-465-g0af29783a3c9)

Regressions Summary
-------------------

platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
jetson-tk1                 | arm   | lab-baylibre  | gcc-10   | multi_v7_de=
fconfig         | 1          =

jetson-tk1                 | arm   | lab-baylibre  | gcc-10   | tegra_defco=
nfig            | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-baylibre  | gcc-10   | defconfig  =
                | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-baylibre  | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-broonie   | gcc-10   | defconfig  =
                | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-baylibre  | gcc-10   | defconfig  =
                | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-baylibre  | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
                | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-baylibre  | gcc-10   | defconfig  =
                | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-baylibre  | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig  =
                | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-baylibre  | gcc-10   | defconfig  =
                | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-baylibre  | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
                | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

rk3399-gru-kevin           | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.118-465-g0af29783a3c9/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.118-465-g0af29783a3c9
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      0af29783a3c96b3caf71bb01eb38e07102566f10 =



Test Regressions
---------------- =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
jetson-tk1                 | arm   | lab-baylibre  | gcc-10   | multi_v7_de=
fconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/6294eec94d66d3f951a39bd5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.118-465-g0af29783a3c9/arm/multi_v7_defconfig/gcc-10/lab-=
baylibre/baseline-jetson-tk1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.118-465-g0af29783a3c9/arm/multi_v7_defconfig/gcc-10/lab-=
baylibre/baseline-jetson-tk1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6294eec94d66d3f951a39=
bd6
        new failure (last pass: v5.10.112-cip6-289-g2969e096d186) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
jetson-tk1                 | arm   | lab-baylibre  | gcc-10   | tegra_defco=
nfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/6294ec83460eb846eca39c45

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: tegra_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.118-465-g0af29783a3c9/arm/tegra_defconfig/gcc-10/lab-bay=
libre/baseline-jetson-tk1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.118-465-g0af29783a3c9/arm/tegra_defconfig/gcc-10/lab-bay=
libre/baseline-jetson-tk1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6294ec83460eb846eca39=
c46
        new failure (last pass: v5.10.112-cip6-289-g2969e096d186) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-baylibre  | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/6294e4685b95fa4d3aa39bdb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.118-465-g0af29783a3c9/arm64/defconfig/gcc-10/lab-baylibr=
e/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.118-465-g0af29783a3c9/arm64/defconfig/gcc-10/lab-baylibr=
e/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6294e4685b95fa4d3aa39=
bdc
        failing since 20 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6,=
 first fail: v5.10.112-cip6-218-g8253434cd56a) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-baylibre  | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6294e5d02b0b6c44d7a39c3a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.118-465-g0af29783a3c9/arm64/defconfig+arm64-chromebook/g=
cc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.118-465-g0af29783a3c9/arm64/defconfig+arm64-chromebook/g=
cc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6294e5d02b0b6c44d7a39=
c3b
        failing since 18 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6,=
 first fail: v5.10.112-cip6-289-g2969e096d186) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-broonie   | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/6294e4c8f5aaa1ba29a39bce

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.118-465-g0af29783a3c9/arm64/defconfig/gcc-10/lab-broonie=
/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.118-465-g0af29783a3c9/arm64/defconfig/gcc-10/lab-broonie=
/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6294e4c8f5aaa1ba29a39=
bcf
        failing since 20 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6,=
 first fail: v5.10.112-cip6-218-g8253434cd56a) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6294e681f39a574792a39bf7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.118-465-g0af29783a3c9/arm64/defconfig+arm64-chromebook/g=
cc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.118-465-g0af29783a3c9/arm64/defconfig+arm64-chromebook/g=
cc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6294e681f39a574792a39=
bf8
        failing since 18 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6,=
 first fail: v5.10.112-cip6-289-g2969e096d186) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-baylibre  | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/6294e4916bbf3bac65a39bf2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.118-465-g0af29783a3c9/arm64/defconfig/gcc-10/lab-baylibr=
e/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.118-465-g0af29783a3c9/arm64/defconfig/gcc-10/lab-baylibr=
e/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6294e4916bbf3bac65a39=
bf3
        failing since 20 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6,=
 first fail: v5.10.112-cip6-218-g8253434cd56a) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-baylibre  | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6294e51cb98dd47124a39bcd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.118-465-g0af29783a3c9/arm64/defconfig+arm64-chromebook/g=
cc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.118-465-g0af29783a3c9/arm64/defconfig+arm64-chromebook/g=
cc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6294e51cb98dd47124a39=
bce
        failing since 18 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6,=
 first fail: v5.10.112-cip6-289-g2969e096d186) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/6294e5049b2047d0d9a39be2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.118-465-g0af29783a3c9/arm64/defconfig/gcc-10/lab-broonie=
/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.118-465-g0af29783a3c9/arm64/defconfig/gcc-10/lab-broonie=
/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6294e5049b2047d0d9a39=
be3
        failing since 20 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6,=
 first fail: v5.10.112-cip6-218-g8253434cd56a) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6294e66df39a574792a39bdf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.118-465-g0af29783a3c9/arm64/defconfig+arm64-chromebook/g=
cc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.118-465-g0af29783a3c9/arm64/defconfig+arm64-chromebook/g=
cc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6294e66df39a574792a39=
be0
        failing since 18 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6,=
 first fail: v5.10.112-cip6-289-g2969e096d186) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-baylibre  | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/6294e453d989476bb5a39bcd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.118-465-g0af29783a3c9/arm64/defconfig/gcc-10/lab-baylibr=
e/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.118-465-g0af29783a3c9/arm64/defconfig/gcc-10/lab-baylibr=
e/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6294e453d989476bb5a39=
bce
        failing since 20 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6,=
 first fail: v5.10.112-cip6-218-g8253434cd56a) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-baylibre  | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6294e5bd05e234c4d9a39c72

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.118-465-g0af29783a3c9/arm64/defconfig+arm64-chromebook/g=
cc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.118-465-g0af29783a3c9/arm64/defconfig+arm64-chromebook/g=
cc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6294e5bd05e234c4d9a39=
c73
        failing since 18 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6,=
 first fail: v5.10.112-cip6-289-g2969e096d186) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/6294e4b4bf401664dda39beb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.118-465-g0af29783a3c9/arm64/defconfig/gcc-10/lab-broonie=
/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.118-465-g0af29783a3c9/arm64/defconfig/gcc-10/lab-broonie=
/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6294e4b4bf401664dda39=
bec
        failing since 20 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6,=
 first fail: v5.10.112-cip6-218-g8253434cd56a) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6294e66e8d4f752082a39bd4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.118-465-g0af29783a3c9/arm64/defconfig+arm64-chromebook/g=
cc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.118-465-g0af29783a3c9/arm64/defconfig+arm64-chromebook/g=
cc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6294e66e8d4f752082a39=
bd5
        failing since 18 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6,=
 first fail: v5.10.112-cip6-289-g2969e096d186) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-baylibre  | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/6294e4806245451266a39bcd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.118-465-g0af29783a3c9/arm64/defconfig/gcc-10/lab-baylibr=
e/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.118-465-g0af29783a3c9/arm64/defconfig/gcc-10/lab-baylibr=
e/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6294e4806245451266a39=
bce
        failing since 20 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6,=
 first fail: v5.10.112-cip6-218-g8253434cd56a) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-baylibre  | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6294e5089b2047d0d9a39bf1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.118-465-g0af29783a3c9/arm64/defconfig+arm64-chromebook/g=
cc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.118-465-g0af29783a3c9/arm64/defconfig+arm64-chromebook/g=
cc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6294e5089b2047d0d9a39=
bf2
        failing since 18 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6,=
 first fail: v5.10.112-cip6-289-g2969e096d186) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/6294e4f00366542036a39c1f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.118-465-g0af29783a3c9/arm64/defconfig/gcc-10/lab-broonie=
/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.118-465-g0af29783a3c9/arm64/defconfig/gcc-10/lab-broonie=
/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6294e4f00366542036a39=
c20
        failing since 20 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6,=
 first fail: v5.10.112-cip6-218-g8253434cd56a) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6294e65825b3a5276ea39c22

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.118-465-g0af29783a3c9/arm64/defconfig+arm64-chromebook/g=
cc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.118-465-g0af29783a3c9/arm64/defconfig+arm64-chromebook/g=
cc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6294e65825b3a5276ea39=
c23
        failing since 18 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6,=
 first fail: v5.10.112-cip6-289-g2969e096d186) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
rk3399-gru-kevin           | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6294e6004c1ab7ecafa39bdf

  Results:     90 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.118-465-g0af29783a3c9/arm64/defconfig+arm64-chromebook/g=
cc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.118-465-g0af29783a3c9/arm64/defconfig+arm64-chromebook/g=
cc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/case/id=
/6294e6004c1ab7ecafa39c01
        failing since 82 days (last pass: v5.10.100-cip2-319-gcbff87047566,=
 first fail: v5.10.100-cip2-425-g0a0d92194f39)

    2022-05-30T15:42:50.302303  <8>[   59.719190] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s0-probed RESULT=3Dpass>
    2022-05-30T15:42:51.326053  /lava-6503524/1/../bin/lava-test-case
    2022-05-30T15:42:51.336585  <8>[   60.753848] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20

