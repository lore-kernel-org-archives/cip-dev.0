X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.web11.8619.1652254722617147670
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 11 May 2022 00:38:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=aGFiLwlh;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.46, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f46.google.com with SMTP id w17-20020a17090a529100b001db302efed6so1314777pjh.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 11 May 2022 00:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=y6uGPJ1UBQ+dAn9dW1IRMGEjVJYpSHgD4+9Okn+byaM=;
        b=aGFiLwlhsWhxzIf5G0xr1xqsekTv1dDu62xhpuaT5lqeTNpT4fsaKcVlmvZYrnXyY3
         sK4YxND4bFFWVFeJ2Yvt/Hr+cg/iGBjRPDE1E+ET8+4W53qJ32iLeI/4F65c3Rw7eo6S
         jNE9F+Z+HaWkcYZxpXMX/GPN6TRu5yW3tUV/Ne3g2yVt6RB3/FWWpUv/1UdOroPy8vma
         hnqhs/v6NX2YsKIAsFnV2ukw5BS4FMAFG+UlAC5pbopX3qsLiipWqKD9DUFcQNKBpFOJ
         DG0aUCeeHxC2oN37kdUi5uMTCrS0nS8OGLWZrfeal5m2Vu7/5q8ILs3s2ir3Smwr9s5T
         efJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=y6uGPJ1UBQ+dAn9dW1IRMGEjVJYpSHgD4+9Okn+byaM=;
        b=QwRnZp6PSPC8EytFzmJhJ00p6AlVpGS99gynzZYtxu87n2/7pm++Rh/ano19YY6LPy
         yH/3DW93EaZXp/8QGAcJhqihSxRbo8b827iZIa3M783GZ9bBFYJtrD7BvYSS4NiwD430
         /90A7j56//4rIXJRNZiSu7FZwL0I2bGEIg1zA0av2h/Q8IDQnyMbi/vC0rL6Tkyg6I9u
         2NhpQJy19N7eXRxaNglnQ9UCtWzXnbfTVwHd2Yt5rbYxhP8hTFimRzRW2tFh1/lOd1YI
         oHvU4rak9FCZtyziuqGz8URmQztzLfqC5Zn/flggW8mpjRV7/65fyK8Q/ql81dYN5hOM
         EnQQ==
X-Gm-Message-State: AOAM531KoBDMBzjMTlHL8XiSIAEXb1k14EyC4CY/ook4xyNTToxFNJEF
	myzlEBuHHYRAot5R9kCzuwcooEPdq1/6UZeNX8M=
X-Google-Smtp-Source: ABdhPJzt4Or0f8IOZJ9hQqMv9GCVx3PTlYI1wqSjBeutC8xSY7pqjyf+v3eaeilXIyTUM6wT/Bsonw==
X-Received: by 2002:a17:902:da8c:b0:15e:c90a:8a8d with SMTP id j12-20020a170902da8c00b0015ec90a8a8dmr24105802plx.165.1652254721644;
        Wed, 11 May 2022 00:38:41 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id bb1-20020a170902bc8100b0015e8d4eb29asm956313plb.228.2022.05.11.00.38.40
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 00:38:40 -0700 (PDT)
Message-ID: <627b6800.1c69fb81.9019f.25cd@mx.google.com>
Date: Wed, 11 May 2022 00:38:40 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4-st5-260-gb0fe64f485ff
Subject: cip-gitlab/ci/pavel/linux-test baseline: 45 runs, 22 regressions (v4.4-st5-260-gb0fe64f485ff) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test baseline: 45 runs, 22 regressions (v4.4-st5-=
260-gb0fe64f485ff)

Regressions Summary
-------------------

platform                   | arch  | lab          | compiler | defconfig   =
               | regressions
---------------------------+-------+--------------+----------+-------------=
---------------+------------
at91-sama5d4_xplained      | arm   | lab-baylibre | gcc-10   | multi_v7_def=
config         | 1          =

beaglebone-black           | arm   | lab-broonie  | gcc-10   | multi_v7_def=
config         | 1          =

beaglebone-black           | arm   | lab-cip      | gcc-10   | multi_v7_def=
config         | 1          =

beaglebone-black           | arm   | lab-broonie  | gcc-10   | omap2plus_de=
fconfig        | 1          =

beaglebone-black           | arm   | lab-cip      | gcc-10   | omap2plus_de=
fconfig        | 1          =

meson8b-odroidc1           | arm   | lab-baylibre | gcc-10   | multi_v7_def=
config         | 1          =

qemu_arm-virt-gicv2        | arm   | lab-baylibre | gcc-10   | multi_v7_def=
config         | 1          =

qemu_arm-virt-gicv2        | arm   | lab-broonie  | gcc-10   | multi_v7_def=
config         | 1          =

qemu_arm-virt-gicv2-uefi   | arm   | lab-baylibre | gcc-10   | multi_v7_def=
config         | 1          =

qemu_arm-virt-gicv2-uefi   | arm   | lab-broonie  | gcc-10   | multi_v7_def=
config         | 1          =

qemu_arm-virt-gicv3        | arm   | lab-baylibre | gcc-10   | multi_v7_def=
config         | 1          =

qemu_arm-virt-gicv3        | arm   | lab-broonie  | gcc-10   | multi_v7_def=
config         | 1          =

qemu_arm-virt-gicv3-uefi   | arm   | lab-baylibre | gcc-10   | multi_v7_def=
config         | 1          =

qemu_arm-virt-gicv3-uefi   | arm   | lab-broonie  | gcc-10   | multi_v7_def=
config         | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-baylibre | gcc-10   | defconfig+ar=
m64-chromebook | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-broonie  | gcc-10   | defconfig+ar=
m64-chromebook | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-baylibre | gcc-10   | defconfig+ar=
m64-chromebook | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie  | gcc-10   | defconfig+ar=
m64-chromebook | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-baylibre | gcc-10   | defconfig+ar=
m64-chromebook | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-broonie  | gcc-10   | defconfig+ar=
m64-chromebook | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-baylibre | gcc-10   | defconfig+ar=
m64-chromebook | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie  | gcc-10   | defconfig+ar=
m64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-260-gb0fe64f485ff/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-260-gb0fe64f485ff
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b0fe64f485ff31f848b40c0d6a9ac286d5b2f5df =



Test Regressions
---------------- =



platform                   | arch  | lab          | compiler | defconfig   =
               | regressions
---------------------------+-------+--------------+----------+-------------=
---------------+------------
at91-sama5d4_xplained      | arm   | lab-baylibre | gcc-10   | multi_v7_def=
config         | 1          =


  Details:     https://kernelci.org/test/plan/id/627a9d0d3efe0008708f5741

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm/multi_v7_defconfig/gcc-10/lab-baylibre/base=
line-at91-sama5d4_xplained.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm/multi_v7_defconfig/gcc-10/lab-baylibre/base=
line-at91-sama5d4_xplained.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627a9d0d3efe0008708f5=
742
        new failure (last pass: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch  | lab          | compiler | defconfig   =
               | regressions
---------------------------+-------+--------------+----------+-------------=
---------------+------------
beaglebone-black           | arm   | lab-broonie  | gcc-10   | multi_v7_def=
config         | 1          =


  Details:     https://kernelci.org/test/plan/id/627a8c7e0b442714778f57ac

  Results:     4 PASS, 1 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm/multi_v7_defconfig/gcc-10/lab-broonie/basel=
ine-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm/multi_v7_defconfig/gcc-10/lab-broonie/basel=
ine-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/armel/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/627a8c7e0b442714=
778f57b5
        new failure (last pass: v5.10.109-cip5-384-g722204542e8a)
        1 lines

    2022-05-10T16:01:54.212916  / # =

    2022-05-10T16:01:54.218650  =

    2022-05-10T16:01:54.324759  / # #
    2022-05-10T16:01:54.330481  #
    2022-05-10T16:01:54.432917  / # export SHELL=3D/bin/sh
    2022-05-10T16:01:54.438595  export SHELL=3D/bin/sh
    2022-05-10T16:01:54.540572  / # . /lava-129750/environment
    2022-05-10T16:01:54.546382  . /lava-129750/environment
    2022-05-10T16:01:54.648395  / # /lava-129750/bin/lava-test-runner /lava=
-129750/0
    2022-05-10T16:01:54.654039  /lava-129750/bin/lava-test-runner /lava-129=
750/0 =

    ... (9 line(s) more)  =

 =



platform                   | arch  | lab          | compiler | defconfig   =
               | regressions
---------------------------+-------+--------------+----------+-------------=
---------------+------------
beaglebone-black           | arm   | lab-cip      | gcc-10   | multi_v7_def=
config         | 1          =


  Details:     https://kernelci.org/test/plan/id/627a8c2f97a07f050c8f5747

  Results:     4 PASS, 1 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-=
beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-=
beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/armel/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/627a8c2f97a07f05=
0c8f574e
        new failure (last pass: v5.10.109-cip5-384-g722204542e8a)
        1 lines

    2022-05-10T16:00:29.424762  / # =

    2022-05-10T16:00:29.427737  =

    2022-05-10T16:00:29.532097  / # #
    2022-05-10T16:00:29.534885  #
    2022-05-10T16:00:29.636605  / # export SHELL=3D/bin/sh
    2022-05-10T16:00:29.639449  export SHELL=3D/bin/sh
    2022-05-10T16:00:29.740905  / # . /lava-677160/environment
    2022-05-10T16:00:29.743727  . /lava-677160/environment
    2022-05-10T16:00:29.845172  / # /lava-677160/bin/lava-test-runner /lava=
-677160/0
    2022-05-10T16:00:29.847481  /lava-677160/bin/lava-test-runner /lava-677=
160/0 =

    ... (9 line(s) more)  =

 =



platform                   | arch  | lab          | compiler | defconfig   =
               | regressions
---------------------------+-------+--------------+----------+-------------=
---------------+------------
beaglebone-black           | arm   | lab-broonie  | gcc-10   | omap2plus_de=
fconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/627a8ba0328f409bc98f5764

  Results:     4 PASS, 1 FAIL, 2 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm/omap2plus_defconfig/gcc-10/lab-broonie/base=
line-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm/omap2plus_defconfig/gcc-10/lab-broonie/base=
line-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/armel/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/627a8ba0328f409b=
c98f576d
        new failure (last pass: v5.10.109-cip5-384-g722204542e8a)
        1 lines

    2022-05-10T15:58:10.725062  / # =

    2022-05-10T15:58:10.733068  =

    2022-05-10T15:58:10.839890  / # #
    2022-05-10T15:58:10.846491  #
    2022-05-10T15:58:10.949031  / # export SHELL=3D/bin/sh
    2022-05-10T15:58:10.956112  export SHELL=3D/bin/sh
    2022-05-10T15:58:11.058200  / # . /lava-129704/environment
    2022-05-10T15:58:11.065399  . /lava-129704/environment
    2022-05-10T15:58:11.167968  / # /lava-129704/bin/lava-test-runner /lava=
-129704/0
    2022-05-10T15:58:11.173852  /lava-129704/bin/lava-test-runner /lava-129=
704/0 =

    ... (9 line(s) more)  =

 =



platform                   | arch  | lab          | compiler | defconfig   =
               | regressions
---------------------------+-------+--------------+----------+-------------=
---------------+------------
beaglebone-black           | arm   | lab-cip      | gcc-10   | omap2plus_de=
fconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/627a8b9ca37bf1d1318f573c

  Results:     4 PASS, 1 FAIL, 2 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline=
-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline=
-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/armel/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/627a8b9ca37bf1d1=
318f5743
        new failure (last pass: v5.10.109-cip5-384-g722204542e8a)
        1 lines

    2022-05-10T15:57:54.629660  / # =

    2022-05-10T15:57:54.638250  =

    2022-05-10T15:57:54.744112  / # #
    2022-05-10T15:57:54.751834  #
    2022-05-10T15:57:54.854053  / # export SHELL=3D/bin/sh
    2022-05-10T15:57:54.862937  export SHELL=3D/bin/sh
    2022-05-10T15:57:54.964770  / # . /lava-677157/environment
    2022-05-10T15:57:54.973422  . /lava-677157/environment
    2022-05-10T15:57:55.075326  / # /lava-677157/bin/lava-test-runner /lava=
-677157/0
    2022-05-10T15:57:55.082540  /lava-677157/bin/lava-test-runner /lava-677=
157/0 =

    ... (9 line(s) more)  =

 =



platform                   | arch  | lab          | compiler | defconfig   =
               | regressions
---------------------------+-------+--------------+----------+-------------=
---------------+------------
meson8b-odroidc1           | arm   | lab-baylibre | gcc-10   | multi_v7_def=
config         | 1          =


  Details:     https://kernelci.org/test/plan/id/627a8c004679c1655a8f5717

  Results:     4 PASS, 1 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm/multi_v7_defconfig/gcc-10/lab-baylibre/base=
line-meson8b-odroidc1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm/multi_v7_defconfig/gcc-10/lab-baylibre/base=
line-meson8b-odroidc1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.all-cpus-are-online: https://kernelci.org/test/case/id/=
627a8c004679c1655a8f571b
        new failure (last pass: v5.10.109-cip5-384-g722204542e8a)

    2022-05-10T15:59:44.777219  /lava-1936252/1/../bin/lava-test-case
    2022-05-10T15:59:44.777609  [   17.332305] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dall-cpus-are-online RESULT=3Dfail>
    2022-05-10T15:59:44.777854  /lava-1936252/1/../bin/lava-test-case   =

 =



platform                   | arch  | lab          | compiler | defconfig   =
               | regressions
---------------------------+-------+--------------+----------+-------------=
---------------+------------
qemu_arm-virt-gicv2        | arm   | lab-baylibre | gcc-10   | multi_v7_def=
config         | 1          =


  Details:     https://kernelci.org/test/plan/id/627ab5d30a57c5b0c08f5729

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm/multi_v7_defconfig/gcc-10/lab-baylibre/base=
line-qemu_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm/multi_v7_defconfig/gcc-10/lab-baylibre/base=
line-qemu_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627ab5d30a57c5b0c08f5=
72a
        new failure (last pass: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch  | lab          | compiler | defconfig   =
               | regressions
---------------------------+-------+--------------+----------+-------------=
---------------+------------
qemu_arm-virt-gicv2        | arm   | lab-broonie  | gcc-10   | multi_v7_def=
config         | 1          =


  Details:     https://kernelci.org/test/plan/id/627a9ee8ff7bbe2bbc8f571d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm/multi_v7_defconfig/gcc-10/lab-broonie/basel=
ine-qemu_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm/multi_v7_defconfig/gcc-10/lab-broonie/basel=
ine-qemu_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627a9ee8ff7bbe2bbc8f5=
71e
        new failure (last pass: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch  | lab          | compiler | defconfig   =
               | regressions
---------------------------+-------+--------------+----------+-------------=
---------------+------------
qemu_arm-virt-gicv2-uefi   | arm   | lab-baylibre | gcc-10   | multi_v7_def=
config         | 1          =


  Details:     https://kernelci.org/test/plan/id/627ab6b66149fffe688f5736

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm/multi_v7_defconfig/gcc-10/lab-baylibre/base=
line-qemu_arm-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm/multi_v7_defconfig/gcc-10/lab-baylibre/base=
line-qemu_arm-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627ab6b66149fffe688f5=
737
        new failure (last pass: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch  | lab          | compiler | defconfig   =
               | regressions
---------------------------+-------+--------------+----------+-------------=
---------------+------------
qemu_arm-virt-gicv2-uefi   | arm   | lab-broonie  | gcc-10   | multi_v7_def=
config         | 1          =


  Details:     https://kernelci.org/test/plan/id/627aa002f23d7d515a8f571b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm/multi_v7_defconfig/gcc-10/lab-broonie/basel=
ine-qemu_arm-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm/multi_v7_defconfig/gcc-10/lab-broonie/basel=
ine-qemu_arm-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627aa002f23d7d515a8f5=
71c
        new failure (last pass: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch  | lab          | compiler | defconfig   =
               | regressions
---------------------------+-------+--------------+----------+-------------=
---------------+------------
qemu_arm-virt-gicv3        | arm   | lab-baylibre | gcc-10   | multi_v7_def=
config         | 1          =


  Details:     https://kernelci.org/test/plan/id/627ab63aba3ff6cc428f58ad

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm/multi_v7_defconfig/gcc-10/lab-baylibre/base=
line-qemu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm/multi_v7_defconfig/gcc-10/lab-baylibre/base=
line-qemu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627ab63aba3ff6cc428f5=
8ae
        new failure (last pass: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch  | lab          | compiler | defconfig   =
               | regressions
---------------------------+-------+--------------+----------+-------------=
---------------+------------
qemu_arm-virt-gicv3        | arm   | lab-broonie  | gcc-10   | multi_v7_def=
config         | 1          =


  Details:     https://kernelci.org/test/plan/id/627a9f243133e8ecf28f5719

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm/multi_v7_defconfig/gcc-10/lab-broonie/basel=
ine-qemu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm/multi_v7_defconfig/gcc-10/lab-broonie/basel=
ine-qemu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627a9f243133e8ecf28f5=
71a
        new failure (last pass: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch  | lab          | compiler | defconfig   =
               | regressions
---------------------------+-------+--------------+----------+-------------=
---------------+------------
qemu_arm-virt-gicv3-uefi   | arm   | lab-baylibre | gcc-10   | multi_v7_def=
config         | 1          =


  Details:     https://kernelci.org/test/plan/id/627ab6b46149fffe688f5733

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm/multi_v7_defconfig/gcc-10/lab-baylibre/base=
line-qemu_arm-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm/multi_v7_defconfig/gcc-10/lab-baylibre/base=
line-qemu_arm-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627ab6b46149fffe688f5=
734
        new failure (last pass: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch  | lab          | compiler | defconfig   =
               | regressions
---------------------------+-------+--------------+----------+-------------=
---------------+------------
qemu_arm-virt-gicv3-uefi   | arm   | lab-broonie  | gcc-10   | multi_v7_def=
config         | 1          =


  Details:     https://kernelci.org/test/plan/id/627aa001446cb222108f5726

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm/multi_v7_defconfig/gcc-10/lab-broonie/basel=
ine-qemu_arm-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm/multi_v7_defconfig/gcc-10/lab-broonie/basel=
ine-qemu_arm-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627aa001446cb222108f5=
727
        new failure (last pass: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch  | lab          | compiler | defconfig   =
               | regressions
---------------------------+-------+--------------+----------+-------------=
---------------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-baylibre | gcc-10   | defconfig+ar=
m64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627ab4f8534a1105ff8f575a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm64/defconfig+arm64-chromebook/gcc-10/lab-bay=
libre/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm64/defconfig+arm64-chromebook/gcc-10/lab-bay=
libre/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627ab4f8534a1105ff8f5=
75b
        failing since 0 day (last pass: v4.19.233-516-ge5e741fbfc87, first =
fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch  | lab          | compiler | defconfig   =
               | regressions
---------------------------+-------+--------------+----------+-------------=
---------------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-broonie  | gcc-10   | defconfig+ar=
m64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627a9ca42713f991b48f5764

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm64/defconfig+arm64-chromebook/gcc-10/lab-bro=
onie/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm64/defconfig+arm64-chromebook/gcc-10/lab-bro=
onie/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627a9ca42713f991b48f5=
765
        failing since 0 day (last pass: v4.19.233-516-ge5e741fbfc87, first =
fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch  | lab          | compiler | defconfig   =
               | regressions
---------------------------+-------+--------------+----------+-------------=
---------------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-baylibre | gcc-10   | defconfig+ar=
m64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627ab4bab523667d018f5729

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm64/defconfig+arm64-chromebook/gcc-10/lab-bay=
libre/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm64/defconfig+arm64-chromebook/gcc-10/lab-bay=
libre/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627ab4bab523667d018f5=
72a
        failing since 0 day (last pass: v4.19.233-516-ge5e741fbfc87, first =
fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch  | lab          | compiler | defconfig   =
               | regressions
---------------------------+-------+--------------+----------+-------------=
---------------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie  | gcc-10   | defconfig+ar=
m64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627a9c68b88783517f8f5806

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm64/defconfig+arm64-chromebook/gcc-10/lab-bro=
onie/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm64/defconfig+arm64-chromebook/gcc-10/lab-bro=
onie/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627a9c68b88783517f8f5=
807
        failing since 0 day (last pass: v4.19.233-516-ge5e741fbfc87, first =
fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch  | lab          | compiler | defconfig   =
               | regressions
---------------------------+-------+--------------+----------+-------------=
---------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-baylibre | gcc-10   | defconfig+ar=
m64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627ab4f7534a1105ff8f5757

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm64/defconfig+arm64-chromebook/gcc-10/lab-bay=
libre/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm64/defconfig+arm64-chromebook/gcc-10/lab-bay=
libre/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627ab4f7534a1105ff8f5=
758
        failing since 0 day (last pass: v4.19.233-516-ge5e741fbfc87, first =
fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch  | lab          | compiler | defconfig   =
               | regressions
---------------------------+-------+--------------+----------+-------------=
---------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-broonie  | gcc-10   | defconfig+ar=
m64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627a9c7c974c89dcce8f5739

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm64/defconfig+arm64-chromebook/gcc-10/lab-bro=
onie/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm64/defconfig+arm64-chromebook/gcc-10/lab-bro=
onie/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627a9c7c974c89dcce8f5=
73a
        failing since 0 day (last pass: v4.19.233-516-ge5e741fbfc87, first =
fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch  | lab          | compiler | defconfig   =
               | regressions
---------------------------+-------+--------------+----------+-------------=
---------------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-baylibre | gcc-10   | defconfig+ar=
m64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627ab4fa534a1105ff8f5760

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm64/defconfig+arm64-chromebook/gcc-10/lab-bay=
libre/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm64/defconfig+arm64-chromebook/gcc-10/lab-bay=
libre/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627ab4fa534a1105ff8f5=
761
        failing since 0 day (last pass: v4.19.233-516-ge5e741fbfc87, first =
fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch  | lab          | compiler | defconfig   =
               | regressions
---------------------------+-------+--------------+----------+-------------=
---------------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie  | gcc-10   | defconfig+ar=
m64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627a9cb8915b955ad78f572f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm64/defconfig+arm64-chromebook/gcc-10/lab-bro=
onie/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm64/defconfig+arm64-chromebook/gcc-10/lab-bro=
onie/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627a9cb8915b955ad78f5=
730
        failing since 0 day (last pass: v4.19.233-516-ge5e741fbfc87, first =
fail: v5.10.109-cip5-384-g722204542e8a) =

 =20

