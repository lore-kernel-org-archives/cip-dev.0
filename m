Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9780C71153
	for <webhook@archiver.kernel.org>; Mon, 28 Aug 2023 14:29:49 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
 by mx.groups.io with SMTP id smtpd.web11.15351.1693232980431596241
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 28 Aug 2023 07:29:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=bdLVSwpN;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.178, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-68becf931bfso2247595b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 28 Aug 2023 07:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1693232979; x=1693837779;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8tDkMVO8QzZsNFnWoh+NaX5QX2DuF5J25N7vg3po4Eo=;
        b=bdLVSwpNj/9HK9K30cPxf//J32JrUNVtlSK+Xgn+irpZTMOgHWZHj1l77q3ttxseWY
         5InrOV1LX8vcVz5wC6AvsIIlugj08guUBP6KAoaAxeUfvKxWdkCQZaWOkOsuiV+w1q6d
         ryk4yL3g5ikIR3BHJz2HQSeFjyrMqGyk+N+i7FhtMkZ9vUSBaczvtytOm7T0dn7MIGvf
         kmsavmUG18tzq56A2bp8tZxXFBYwt7y9o244Fs/ebWoPC9vCxH/L3K5pvJr4CGLimIqo
         qS0gyY1qwksk4da7iXuGGBasAjs5Yp9LRNM3fHz0mKKIN3SkjuZ/+7hXeUhv2rMFssXC
         8sYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693232979; x=1693837779;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8tDkMVO8QzZsNFnWoh+NaX5QX2DuF5J25N7vg3po4Eo=;
        b=KOL3r8g1a7luJuUvF58Tpdt/EdTqOHuVmfxeOD+2JuCTNX/D3ZYoEsfSy9rl5I0C2C
         g0JqNy+thnIS9eLb1I8sEjdIbZbv2gJRcQg99cD1coOUZZBoQRCA0W6mzQ5hB094klF7
         UaGhCUZrSg6/c1HsX56MNNQmVmHHzTIMiZ1LjhI+IrJk9D/VNkhB15js/0EpFzm+Cfj6
         VKXh4DomScnFPGTqNThGyym9GyzskmqD7/GbiaFS8MjCAYqWQhrVWlSA1b34J6z9tKHT
         RpHaWdgj2wuP2YuC/YawLH9cIfnuKPhN77UcQb/pnfcQk28WdN1nmIT3c1oXhGgDYcGH
         go4Q==
X-Gm-Message-State: AOJu0YwDBG+gzgPyrYpjjquaDKgymCi0LUm7qZZvTkHVBOxzTKTaqPuC
	WYzA9esZea7I8aiDyKhKNpqygRQ1yiXpyxy8Trc=
X-Google-Smtp-Source: AGHT+IFpdahYvOg7n4NXE5dqqfyJk3j3GAwPpERXaC2dudGBtxwXXoUyvwPblrhYVPRhTo28eyhc+A==
X-Received: by 2002:a05:6a20:1398:b0:14c:e527:fab9 with SMTP id hn24-20020a056a20139800b0014ce527fab9mr3656571pzc.19.1693232979236;
        Mon, 28 Aug 2023 07:29:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u11-20020aa7838b000000b0068be7119c70sm6616092pfm.186.2023.08.28.07.29.38
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 07:29:38 -0700 (PDT)
Message-ID: <64ecaf52.a70a0220.91bf3.a0c8@mx.google.com>
Date: Mon, 28 Aug 2023 07:29:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.46-cip4-rt2
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 24 runs,
 4 regressions (v6.1.46-cip4-rt2)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Aug 2023 14:29:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12888

cip-gitlab/ci/pavel/linux-test baseline-nfs: 24 runs, 4 regressions (v6.1.4=
6-cip4-rt2)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
imx6q-udoo                   | arm   | lab-broonie | gcc-10   | imx_v6_v7_d=
efconfig        | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig  =
                | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.46-cip4-rt2/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.46-cip4-rt2
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c4800588c47085de12fb82c4790e49fdee561258 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
imx6q-udoo                   | arm   | lab-broonie | gcc-10   | imx_v6_v7_d=
efconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/64eca3c0818f442746286d6f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-rt2/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-i=
mx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-rt2/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-i=
mx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64eca3c0818f44274=
6286d70
        failing since 5 days (last pass: v4.4-st20-3262-g667bb8d8b2cb, firs=
t fail: v6.1.45-cip3-31-gbae6b8e9a2cff) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64eca86714a38f3dd8286e3b

  Results:     51 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-rt2/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/basel=
ine-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-rt2/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/basel=
ine-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.cpufreq-probed: https://kernelci.org/test/case/id/6=
4eca86714a38f3dd8286e64
        new failure (last pass: v6.1.45-cip3-31-gbae6b8e9a2cff)

    2023-08-28T13:59:49.531173  /lava-75594/1/../bin/lava-test-case
    2023-08-28T13:59:49.589039  <8>[   35.576739] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpufreq-probed RESULT=3Dfail>
    2023-08-28T13:59:49.589849  /lava-75594/1/../bin/lava-test-case   =

 =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/64eca3e0a55c2f1b83286d7a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-rt2/arm64/defconfig/gcc-10/lab-cip/baseline-nfs-r8a774a1-hiho=
pe-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-rt2/arm64/defconfig/gcc-10/lab-cip/baseline-nfs-r8a774a1-hiho=
pe-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64eca3e0a55c2f1b8=
3286d7b
        failing since 12 days (last pass: v4.19.288-cip101-1117-g1f3468542a=
a9e, first fail: v5.10.186-cip37-16-gf8567732a40d) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64eca89f93a9944d3c286d76

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-rt2/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-=
nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-rt2/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-=
nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64eca89f93a9944d3=
c286d77
        failing since 5 days (last pass: v5.10.186-cip37-16-gf8567732a40d, =
first fail: v6.1.45-cip3-31-gbae6b8e9a2cff) =

 =20

