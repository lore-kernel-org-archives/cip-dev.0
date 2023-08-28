Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93434C83F01
	for <webhook@archiver.kernel.org>; Mon, 28 Aug 2023 00:24:15 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web10.3803.1693182251022910641
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 27 Aug 2023 17:24:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=sQyid11k;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.179, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1c0c6d4d650so21125495ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 27 Aug 2023 17:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1693182250; x=1693787050;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RCXWUncQNSbnT7m9MxnCoA9MLHjcZyAViJ8GRBg28eQ=;
        b=sQyid11kzHeuV5BJvhZP7EyUyvYNUpWwfmVxjGnOYtwGi7639+kXcyBeH9NRwJ90gy
         C8Pb03CYhq9C+8k9kVYgM0zjwldpn4otYwwfP5lgn4z716Bto2xcLqDhaK/E7JI8/+e9
         9nVn9PahrGjY4zd/zRrIZtdymiialDbb3FZT0MkLFmzETxSfXYqJQTxE5o+Cuv559zRv
         fDKtqy0zVZp3my4rybfsLPrsDHclIFbUXhKGCb90UAQbbPMm4BPBC1c+RgJ9OMd9QNin
         BqFVxn3v2Onq0zHEOMB2yViExBy+QMBmPo6QjboJKiwRPQgqb0Hj/7mFuMdNQeXWcH90
         C3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693182250; x=1693787050;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RCXWUncQNSbnT7m9MxnCoA9MLHjcZyAViJ8GRBg28eQ=;
        b=k2LxD49yAw45Spd+OK97tdKMM0TQzCGxrL4bkOg/k1yfDfujYuthH9Onmu6fN9J509
         8bEboHlL75dd1viGxWegQr5l0daHZy5kAFfXJ97ZeqQ/3R4fxOFY83cMP5LpH/tcoDzX
         lVQQsZjfxXRqSs3n1k+x6+wTy1gv0Vz5q7uZlUOPmHwurKBlkVLqqFGRWc6uWSozxKGX
         /NMQLSwtxNz901kYn8W7JXDgX6p6RQvvO2DyQ2bUidzwnR2iaFpDN3r9FxifhCowSP58
         kAPUk3krklwR+Vd+lpRg2GzdT2UV3dSPaLM6A3WX1zoUQKt3sFFC/Bp6hFGwRNfcgOuE
         Ojog==
X-Gm-Message-State: AOJu0YyXL82ptBtI4LvBvDpHa9k+bpDBv6lW3ldYUbHOa+K6BaOZjbn/
	aAoHgdYjKCy9PyvWXGPt5lcETzR+8Lxd1Ibxl5A=
X-Google-Smtp-Source: AGHT+IEgGfqr9vD32XfyzHX6zgFA1MbLPRmYFPPVGzeoJYgQp47YrupV6I+67IxwMxwRkxT11juiJw==
X-Received: by 2002:a17:902:d2d1:b0:1c1:d730:f0ca with SMTP id n17-20020a170902d2d100b001c1d730f0camr5407036plc.14.1693182249813;
        Sun, 27 Aug 2023 17:24:09 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ik15-20020a170902ab0f00b001bdc7d88ee3sm5950732plb.37.2023.08.27.17.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 17:24:08 -0700 (PDT)
Message-ID: <64ebe928.170a0220.c1415.90a4@mx.google.com>
Date: Sun, 27 Aug 2023 17:24:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.292-cip102
Subject: cip/linux-4.19.y-cip baseline-nfs: 26 runs,
 3 regressions (v4.19.292-cip102)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Aug 2023 00:24:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12858

cip/linux-4.19.y-cip baseline-nfs: 26 runs, 3 regressions (v4.19.292-cip102)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
beaglebone-black | arm   | lab-broonie   | gcc-10   | omap2plus_defconfig  =
      | 1          =

rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.292-cip102/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.292-cip102
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      372689399d20f850142c3d734cb4365cd8a31242 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
beaglebone-black | arm   | lab-broonie   | gcc-10   | omap2plus_defconfig  =
      | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebe17149b98f8397286d94

  Results:     41 PASS, 10 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.292=
-cip102/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-=
black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.292=
-cip102/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-=
black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64ebe17149b98f8397286dca
        new failure (last pass: v4.19.288-cip101)

    2023-08-27T23:50:35.059175  + set +x
    2023-08-27T23:50:35.063107  <8>[   54.603070] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 73476_1.6.2.4.1>
    2023-08-27T23:50:35.187687  #
    2023-08-27T23:50:35.289639  / # #export SHELL=3D/bin/sh
    2023-08-27T23:50:35.289998  =

    2023-08-27T23:50:35.391202  / # export SHELL=3D/bin/sh. /lava-73476/env=
ironment
    2023-08-27T23:50:35.391594  =

    2023-08-27T23:50:35.492824  / # . /lava-73476/environment/lava-73476/bi=
n/lava-test-runner /lava-73476/1
    2023-08-27T23:50:35.493399  =

    2023-08-27T23:50:35.497651  / # /lava-73476/bin/lava-test-runner /lava-=
73476/1 =

    ... (12 line(s) more)  =

 =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 2          =


  Details:     https://kernelci.org/test/plan/id/64ebe0f2471fc745f4286da7

  Results:     77 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.292=
-cip102/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-=
rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.292=
-cip102/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-=
rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/64ebe0f2471fc745f4286db1
        failing since 158 days (last pass: v4.19.276-cip93, first fail: v4.=
19.277-cip94)

    2023-08-27T23:49:00.685904  <8>[   39.479049] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-08-27T23:49:01.726219  /lava-11367966/1/../bin/lava-test-case

    2023-08-27T23:49:01.755261  <8>[   40.549543] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/64ebe0f2471fc745f4286db2
        failing since 158 days (last pass: v4.19.276-cip93, first fail: v4.=
19.277-cip94)

    2023-08-27T23:48:59.621683  <8>[   38.415291] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-08-27T23:49:00.656397  /lava-11367966/1/../bin/lava-test-case
   =

 =20

