Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FE2C4707B
	for <webhook@archiver.kernel.org>; Sat, 13 Jan 2024 06:57:28 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web10.15015.1705129047150129499
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 12 Jan 2024 22:57:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=VL6qgD8p;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.48, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-28e0786edb3so1132279a91.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 12 Jan 2024 22:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1705129046; x=1705733846; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9NYGvVnyqn2M/DnqV07gVt+owDQod0J8ohL75CIWydY=;
        b=VL6qgD8pCXwhrX7uDnszCb02mDo0XsDtCGrAi5jyugKwxqmCLEKOFNK8vR4oBq62wJ
         4pXRGbSIQDooVVWhlK5vYDMaa2iwB6gsjTDv50KpnKwhYYex30o14BmsWAwvgr+tw9aZ
         QnqQB7lNvMlAJJLVuuS3XfOLIa/pK/ZZPpy1fX+0s41MoNj54foqRN6R5oc84QZp6egU
         U6YjiZTWy3iWPS9XoOXKKY5sZWVZZmuqwWUYLKNq8ZMiCASS2TzA+864PL5Zyh5IFL8M
         0ykFTx0Xx3fqA4yJbZ29if1kEHToVJd49bqgCq1vI6NMoEqCqgyiTm/ZCIrz71ffkLgn
         Cm2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705129046; x=1705733846;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9NYGvVnyqn2M/DnqV07gVt+owDQod0J8ohL75CIWydY=;
        b=omcu6PTuqrLEfQ9I0z1A70D8WjfU7oTW9UB7DPCEsmxnABcu44esOZBl2+0JFI2imY
         uU2HTKJbWabfUezhu+Ah/LBJE68VvGTPeU/IrLOCQ8NuIMxnz75N80Egy5OhZPFgZQua
         oGFgktvXEwx8cdqYka9pvKDk5xDArDPjdGy8s6D7FywXG9rdmbSHkMbb56LdSSw9aNer
         68bQrsHS6ELKhj5bB5qlOXQjqiKfb2M6G3h5OCFf83hQxzxU3OqOH5nG9utfxzvRgJDI
         l80H07ZEpNSlNKOcIH6PSNuNbn6XpOu1kDwNXuTOlT9qZGlx+fWDMWrtDVUx8bvqb1Ms
         SC3g==
X-Gm-Message-State: AOJu0YyV/oxjs/b80482nWY5B8wMLUfIco+HCiWNjrrLNlGlKTBPQSx9
	0D0aD0Z7WVegEMrgks52XlbywAaVW0VsdxlLcMMyw2DvqVY=
X-Google-Smtp-Source: AGHT+IE5RVmG6BOR+lY0ujACx6tgpeL4W9oEyFmTMFeBx5I5b+Dzs9mxg+rigdG0rAO/zQ1lOWBYfg==
X-Received: by 2002:a05:6a20:e68c:b0:19a:9d9f:6af9 with SMTP id mz12-20020a056a20e68c00b0019a9d9f6af9mr1704936pzb.73.1705129045561;
        Fri, 12 Jan 2024 22:57:25 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id fh28-20020a056a00391c00b006d9bb753d2esm4168810pfb.166.2024.01.12.22.57.24
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 22:57:25 -0800 (PST)
Message-ID: <65a23455.050a0220.d8acd.e9a6@mx.google.com>
Date: Fri, 12 Jan 2024 22:57:25 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.205-905-gb40421b142370
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 82 runs,
 9 regressions (v5.10.205-905-gb40421b142370)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 13 Jan 2024 06:57:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14360

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 82 runs, 9 regress=
ions (v5.10.205-905-gb40421b142370)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
juno-uboot               | arm64 | lab-broonie   | gcc-10   | defconfig    =
                | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook   | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+kse=
lftest          | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
                | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
...ok+kselftest | 1          =

rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook   | 2          =

rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig+kse=
lftest          | 1          =

rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig    =
                | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.205-905-gb40421b142370/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.205-905-gb40421b142370
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b40421b142370404ab8c5dae183e5541de854979 =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
juno-uboot               | arm64 | lab-broonie   | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/65a22d875cd57b567252a3ff

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig/gcc-10/lab-brooni=
e/baseline-nfs-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig/gcc-10/lab-brooni=
e/baseline-nfs-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65a22d875cd57b567252a43f
        failing since 71 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.194-cip39-915-g96fa7f16cf02)

    2024-01-13T06:27:49.669866  <8>[   44.659253] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 454755_1.6.2.4.1>
    2024-01-13T06:27:49.773834  / # #
    2024-01-13T06:27:49.876608  export SHELL=3D/bin/sh
    2024-01-13T06:27:49.877386  #
    2024-01-13T06:27:49.979259  / # export SHELL=3D/bin/sh. /lava-454755/en=
vironment
    2024-01-13T06:27:49.980014  =

    2024-01-13T06:27:50.081973  / # . /lava-454755/environment/lava-454755/=
bin/lava-test-runner /lava-454755/1
    2024-01-13T06:27:50.083247  =

    2024-01-13T06:27:50.101554  / # /lava-454755/bin/lava-test-runner /lava=
-454755/1
    2024-01-13T06:27:50.213628  + export TESTRUN_ID=3D1_bootrr =

    ... (10 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/65a228b5b6d727fbfd52a431

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig+arm64-chromebook/=
gcc-10/lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig+arm64-chromebook/=
gcc-10/lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65a228b5b6d727fbf=
d52a432
        failing since 154 days (last pass: v5.10.186-cip37-566-g36076316ef0=
49, first fail: v5.10.186-cip37-770-gddd36cfc4c4c8) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+kse=
lftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/65a229e141b2468be752a414

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig+kselftest/gcc-10/=
lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig+kselftest/gcc-10/=
lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65a229e141b2468be=
752a415
        failing since 30 days (last pass: v5.10.201-cip41-197-g2d08925b44e5=
2, first fail: v5.10.201-cip41-473-gc43d7b7bbe83a) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/65a22c36741a75a55752a3ff

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig/gcc-10/lab-cip/ba=
seline-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig/gcc-10/lab-cip/ba=
seline-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65a22c36741a75a55=
752a400
        failing since 169 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.186-cip37-526-g7640d76efb649) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65a22ee19b0bc24cfc52a3f1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig+arm64-chromebook+=
kselftest/gcc-10/lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig+arm64-chromebook+=
kselftest/gcc-10/lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65a22ee19b0bc24cf=
c52a3f2
        failing since 169 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.186-cip37-526-g7640d76efb649) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/65a226e531e97f86c852a461

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig+arm64-chromebook/=
gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig+arm64-chromebook/=
gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/65a226e531e97f86c852a46b
        failing since 267 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2024-01-13T06:02:27.665576  <8>[   36.345676] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2024-01-13T06:02:28.722188  /lava-12521705/1/../bin/lava-test-case

    2024-01-13T06:02:28.760335  <8>[   37.440507] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/65a226e531e97f86c852a46c
        failing since 267 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2024-01-13T06:02:26.568156  <8>[   35.247302] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2024-01-13T06:02:27.632051  /lava-12521705/1/../bin/lava-test-case
   =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig+kse=
lftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/65a22773c945818d6952a40a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig+kselftest/gcc-10/=
lab-collabora/baseline-nfs-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig+kselftest/gcc-10/=
lab-collabora/baseline-nfs-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65a22773c945818d6952a413
        failing since 71 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.194-cip39-915-g96fa7f16cf02)

    2024-01-13T06:02:09.418364  / # #

    2024-01-13T06:02:10.678686  export SHELL=3D/bin/sh

    2024-01-13T06:02:10.689586  #

    2024-01-13T06:02:10.690019  / # export SHELL=3D/bin/sh

    2024-01-13T06:02:12.433364  . /lava-12521739/environment

    2024-01-13T06:02:12.444295  / # . /lava-12521739/environment

    2024-01-13T06:02:15.638158  /lava-12521739/bin/lava-test-runner /lava-1=
2521739/1

    2024-01-13T06:02:15.653058  / # /lava-12521739/bin/lava-test-runner /la=
va-12521739/1

    2024-01-13T06:02:16.068073  + export TESTRUN_ID=3D1_bootrr

    2024-01-13T06:02:16.068517  + cd /lava-12521739/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/65a22bfd56d815311652a405

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig/gcc-10/lab-collab=
ora/baseline-nfs-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig/gcc-10/lab-collab=
ora/baseline-nfs-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65a22bfd56d815311652a40e
        failing since 71 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.194-cip39-915-g96fa7f16cf02)

    2024-01-13T06:21:32.825081  / # #

    2024-01-13T06:21:34.086046  export SHELL=3D/bin/sh

    2024-01-13T06:21:34.097009  #

    2024-01-13T06:21:34.097473  / # export SHELL=3D/bin/sh

    2024-01-13T06:21:35.841402  / # . /lava-12521956/environment

    2024-01-13T06:21:39.047063  /lava-12521956/bin/lava-test-runner /lava-1=
2521956/1

    2024-01-13T06:21:39.058601  . /lava-12521956/environment

    2024-01-13T06:21:39.062657  / # /lava-12521956/bin/lava-test-runner /la=
va-12521956/1

    2024-01-13T06:21:39.253218  + export TESTRUN_ID=3D1_bootrr

    2024-01-13T06:21:39.253367  + cd /lava-12521956/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =20

