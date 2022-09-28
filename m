Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE1AC04A95
	for <webhook@archiver.kernel.org>; Wed, 28 Sep 2022 14:42:49 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web08.8835.1664376168096770169
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 28 Sep 2022 07:42:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=hlgKWI40;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.176,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f176.google.com with SMTP id y20so1878098plb.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 28 Sep 2022 07:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=6uogpwM3L7wxTK08PQvdehOgmdhPy1hGxZZLI7NKdYQ=;
        b=hlgKWI40R1JxfVKmoN8Qz6eaAtk2oNuJ8zCkGQ2VZtGybAlfpgTVORMCkZ6nvTgH2W
         eb0lxl+dDJwfS0lrPGagerAdH4dbv9eX4D0t7xmS24yNEeLH+gsf2TzMhE8YYgnfJrxA
         3MJBORxILOPuX/V4MA+y1geAXBV4LsiC4QISxB2FZ3VsI9GCVw6PbqJZ3WxC9pMsWwCV
         yniyYhT6/Z/2kpBZr5ryJyDsiLyGSYdmZw6a0JMdYA8GUX4aBniWXsFu1xa5c8cI/1/I
         Rmu451W0UJ7aIV0nr//07xafEv3Uipu7VlgI6RH3jTK/1Ic1qTiWtMlzMM6fqgbbHq/K
         Eqgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=6uogpwM3L7wxTK08PQvdehOgmdhPy1hGxZZLI7NKdYQ=;
        b=0nNrbDh5/kcan29PdAgzJVUt/pLIg4dqLUzsbmHQ5JRZa4AG5EJ893oFE+Ag2n8D/q
         j3oYP49u4N5yTybU1oekBjrPzD+TzxU87a1d8aEtmlASg8T6jOgQP6BNbciLxR5cBsa0
         yyG17qZuD912OHAfG/W44ZhQHzTFsVu3+uyQZtUikhnVr7aJEwEEY3kMpuqTQDHWpGyV
         TvxB7XpxaNMbq539bUscLFS8pLgW2QwnVgHGxhAtHoiDi0Y1yTeSOobjpRWK3mWirz4e
         qNQ8KFv+xol4qkv7myAr0tY9xa5qeZYL14cD2e7yc2wWJFmbswttdNE1V2FjPdISu7+f
         3ssw==
X-Gm-Message-State: ACrzQf1yP5+Dx5ojZvNloQSCGLQr+znfK1vgWkczGb+sVJpjjCX7V3DN
	fMlve9bugLwGLD8hBN0SWxqyuemxClvi/Oai
X-Google-Smtp-Source: 
 AMsMyM63j/9Pxnk/yL31qcyp0vHwL9i5vzzqzDnV9bfiXrOxv2q0pCNyHLM8mGlzhnRVr9YCqBpsmw==
X-Received: by 2002:a17:90a:8d07:b0:205:f69b:8563 with SMTP id
 c7-20020a17090a8d0700b00205f69b8563mr2787825pjo.216.1664376167236;
        Wed, 28 Sep 2022 07:42:47 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 n9-20020a170903110900b001709b9d292esm3832603plh.268.2022.09.28.07.42.44
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 07:42:44 -0700 (PDT)
Message-ID: <63345d64.170a0220.23677.69bd@mx.google.com>
Date: Wed, 28 Sep 2022 07:42:44 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.145-cip17-140-g62223aebb3a92
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 114 runs,
 9 regressions (v5.10.145-cip17-140-g62223aebb3a92)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 28 Sep 2022 14:42:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9569

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 114 runs, 9 regression=
s (v5.10.145-cip17-140-g62223aebb3a92)

Regressions Summary
-------------------

platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
panda                      | arm   | lab-baylibre  | gcc-10   | multi_v7_de=
fconfig | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-broonie   | gcc-10   | defconfig  =
        | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-collabora | gcc-10   | defconfig  =
        | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
        | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-collabora | gcc-10   | defconfig  =
        | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig  =
        | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-collabora | gcc-10   | defconfig  =
        | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
        | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-collabora | gcc-10   | defconfig  =
        | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.145-cip17-140-g62223aebb3a92/plan/baselin=
e/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.145-cip17-140-g62223aebb3a92
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      62223aebb3a921dd8f6ae0008df527bf6bd30935 =



Test Regressions
---------------- =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
panda                      | arm   | lab-baylibre  | gcc-10   | multi_v7_de=
fconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/633456a3d3988f936cec4ea6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-140-g62223aebb3a92/arm/multi_v7_defconfig/gcc-=
10/lab-baylibre/baseline-panda.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-140-g62223aebb3a92/arm/multi_v7_defconfig/gcc-=
10/lab-baylibre/baseline-panda.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/633456a3d3988f936cec4=
ea7
        failing since 27 days (last pass: v5.10.136-cip14-542-g97767707d3d0=
, first fail: v5.10.138-cip15-90-gd4130d0ee3c7) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-broonie   | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/63345a5c1ddd5f4443ec4ee0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-140-g62223aebb3a92/arm64/defconfig/gcc-10/lab-=
broonie/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-140-g62223aebb3a92/arm64/defconfig/gcc-10/lab-=
broonie/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63345a5c1ddd5f4443ec4=
ee1
        failing since 141 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6=
, first fail: v5.10.112-cip6-218-g8253434cd56a) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-collabora | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/633455fd53b76b1471ec4eb2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-140-g62223aebb3a92/arm64/defconfig/gcc-10/lab-=
collabora/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-140-g62223aebb3a92/arm64/defconfig/gcc-10/lab-=
collabora/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/633455fd53b76b1471ec4=
eb3
        failing since 141 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6=
, first fail: v5.10.112-cip6-218-g8253434cd56a) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/63345a20b0e52d4309ec4ed9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-140-g62223aebb3a92/arm64/defconfig/gcc-10/lab-=
broonie/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-140-g62223aebb3a92/arm64/defconfig/gcc-10/lab-=
broonie/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63345a20b0e52d4309ec4=
eda
        failing since 141 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6=
, first fail: v5.10.112-cip6-218-g8253434cd56a) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-collabora | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/633455f10f41eceb5eec4eb4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-140-g62223aebb3a92/arm64/defconfig/gcc-10/lab-=
collabora/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-140-g62223aebb3a92/arm64/defconfig/gcc-10/lab-=
collabora/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/633455f10f41eceb5eec4=
eb5
        failing since 141 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6=
, first fail: v5.10.112-cip6-218-g8253434cd56a) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/63345a9964c5aa9028ec4eeb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-140-g62223aebb3a92/arm64/defconfig/gcc-10/lab-=
broonie/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-140-g62223aebb3a92/arm64/defconfig/gcc-10/lab-=
broonie/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63345a9964c5aa9028ec4=
eec
        failing since 141 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6=
, first fail: v5.10.112-cip6-218-g8253434cd56a) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-collabora | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/633455fec8ab5bd74fec4ea9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-140-g62223aebb3a92/arm64/defconfig/gcc-10/lab-=
collabora/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-140-g62223aebb3a92/arm64/defconfig/gcc-10/lab-=
collabora/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/633455fec8ab5bd74fec4=
eaa
        failing since 141 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6=
, first fail: v5.10.112-cip6-218-g8253434cd56a) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/63345a34180636688dec4eb2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-140-g62223aebb3a92/arm64/defconfig/gcc-10/lab-=
broonie/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-140-g62223aebb3a92/arm64/defconfig/gcc-10/lab-=
broonie/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63345a34180636688dec4=
eb3
        failing since 141 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6=
, first fail: v5.10.112-cip6-218-g8253434cd56a) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
        | regressions
---------------------------+-------+---------------+----------+------------=
--------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-collabora | gcc-10   | defconfig  =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/633455f2b1db5b5f6aec4eb6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-140-g62223aebb3a92/arm64/defconfig/gcc-10/lab-=
collabora/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-140-g62223aebb3a92/arm64/defconfig/gcc-10/lab-=
collabora/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/633455f2b1db5b5f6aec4=
eb7
        failing since 141 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6=
, first fail: v5.10.112-cip6-218-g8253434cd56a) =

 =20

