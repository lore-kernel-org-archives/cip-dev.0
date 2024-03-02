Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FA1C54E55
	for <webhook@archiver.kernel.org>; Sat,  2 Mar 2024 00:35:52 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web11.40164.1709339745422612041
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 01 Mar 2024 16:35:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=oQgY71kn;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.169, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d7232dcb3eso21796545ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 01 Mar 2024 16:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709339744; x=1709944544; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7vdi1/Zxp5yCCNvPNTESkKOxfHX5sRoF9Ipq83lx70I=;
        b=oQgY71knFqVup2nYwZhuEvTj2xlXj1UAl3tf2I4BCK+05a775BZzCFSVveVzS3Iba1
         ZYLhbcKybbsz8q2oVpDvzF4HWyYkMH7VUgrAz1H26M6xGJ5e7gI9fomDbpvBAlxM6Gr6
         Jv1p8Jl0sBdMe2coItHdgWn4hPXvnGBqi1GdVEzYP7ylO6Gt0PvmCxtFymhOp4h43gry
         fZa2qmbLtLy/bGmX0MN3qBEpdTYfNZi0GVpSphF7a8Z68W7Yi1oIsr2if/0G/Bf8n6BM
         G5qxTZHpTLI5g9umIrM2I4VNK4IoQb9YwUFCkbqJWaGEwBd7rbqBdBwUptp1LRyUUssJ
         9x6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709339744; x=1709944544;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7vdi1/Zxp5yCCNvPNTESkKOxfHX5sRoF9Ipq83lx70I=;
        b=Celrqw2gBnNviEhjA+m/FjY6rVgWfCTsVg5WcIUueoJ+bewgvpZy+8LrOCghvUTZec
         38m0mdyylPvpbFtB18ozrkJ1lu0iZ/y+NUDLrFCSUCE7vE/RwDc5mfUSvg5yXWqBYx2O
         1APYhg1ITXye8u2sG4gIhYaNHNUx33b8mBugsgPMc5hH3LnwxcZa+yLXTsiP9viyZfwz
         ZE0rnYPfCRyhnCyhmcjt1g0YbMy06hzmVP0OADUxKAYfyjUAx9+ghjn1digKlcDJ36XE
         c+yJr9dDYDFSs6Y7UZfgCSOlP8wLcvLj3fhXN6MvzrjMssxGL1Giddq9W8J2yNoGZnOb
         g7mA==
X-Gm-Message-State: AOJu0Yyd9BfeHI6MwhXEPP2KuA1lnVr/QFh5t2+MD8oKtRl1SE10ySCq
	/AP08JwauvReaXeE+D1SkPFpQC+LqkLqWz2MP7WmTN5gYSRtG/ZIftmjpeBHB5PvOwGwPq2l85k
	eDJw=
X-Google-Smtp-Source: AGHT+IH8UIjN6OBw8xvYN9a80AbyMhlmOhilgUznN4QNx5IYxcVFu2s1lAMvH6gtFcDAHVTRy3ZR6g==
X-Received: by 2002:a17:902:ce85:b0:1dc:dfa8:7bd4 with SMTP id f5-20020a170902ce8500b001dcdfa87bd4mr3356886plg.42.1709339743471;
        Fri, 01 Mar 2024 16:35:43 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d8-20020a170903230800b001db5bdd5e33sm4064846plh.48.2024.03.01.16.35.41
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 16:35:42 -0800 (PST)
Message-ID: <65e2745e.170a0220.7b9c4.3c30@mx.google.com>
Date: Fri, 01 Mar 2024 16:35:42 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.19.306-cip107-1142-gdcbd51e7744f
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline: 94 runs,
 86 regressions (v4.19.306-cip107-1142-gdcbd51e7744f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 02 Mar 2024 00:35:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15152

cip-gitlab/ci/pavel/linux-test baseline: 94 runs, 86 regressions (v4.19.306=
-cip107-1142-gdcbd51e7744f)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =

acer-cbv514-1h-34uz-brya     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =

acer-chromebox-cxi4-puff     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =

acer-chromebox-cxi5-brask    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =

at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | at91_d=
t_defconfig          | 7          =

at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig         | 3          =

bcm2835-rpi-b-rev2           | arm    | lab-broonie     | gcc-10   | bcm283=
5_defconfig          | 2          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig         | 10         =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig        | 7          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig        | 7          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig        | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig         | 1          =

juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                  | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-broonie     | gcc-10   | defcon=
fig                  | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-collabora   | gcc-10   | defcon=
fig                  | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                  | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-collabora   | gcc-10   | defcon=
fig                  | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-broonie     | gcc-10   | defcon=
fig                  | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-collabora   | gcc-10   | defcon=
fig                  | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                  | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-collabora   | gcc-10   | defcon=
fig                  | 1          =

qemu_mips-malta              | mips   | lab-broonie     | gcc-10   | malta_=
defconfig            | 1          =

qemu_mips-malta              | mips   | lab-collabora   | gcc-10   | malta_=
defconfig            | 1          =

qemu_x86_64-uefi-mixed       | x86_64 | lab-broonie     | gcc-10   | x86_64=
_defconfig+x86-board | 1          =

qemu_x86_64-uefi-mixed       | x86_64 | lab-broonie     | gcc-10   | x86_64=
_defconfig           | 1          =

qemu_x86_64-uefi-mixed       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =

qemu_x86_64-uefi-mixed       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig           | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig         | 1          =

r8a7796-m3ulcb               | arm64  | lab-collabora   | gcc-10   | defcon=
fig                  | 1          =

rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig         | 4          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                  | 12         =

sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig                  | 9          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.306-cip107-1142-gdcbd51e7744f/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.306-cip107-1142-gdcbd51e7744f
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      dcbd51e7744fcf9baa3ea87a028b574fda95d428 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65e26996957b7c43d663703a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/x86_64/x86_64_defconfig+x86-board/gcc-=
10/lab-collabora/baseline-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/x86_64/x86_64_defconfig+x86-board/gcc-=
10/lab-collabora/baseline-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65e26996957b7c43d6637=
03b
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
acer-cbv514-1h-34uz-brya     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65e26991957b7c43d663702e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/x86_64/x86_64_defconfig+x86-board/gcc-=
10/lab-collabora/baseline-acer-cbv514-1h-34uz-brya.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/x86_64/x86_64_defconfig+x86-board/gcc-=
10/lab-collabora/baseline-acer-cbv514-1h-34uz-brya.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65e26991957b7c43d6637=
02f
        failing since 25 days (last pass: v6.1.75-cip14-132-g6e54756fbd6c2,=
 first fail: v5.10.209-cip44-rebase) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
acer-chromebox-cxi4-puff     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65e26977fee3aecac9637018

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/x86_64/x86_64_defconfig+x86-board/gcc-=
10/lab-collabora/baseline-acer-chromebox-cxi4-puff.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/x86_64/x86_64_defconfig+x86-board/gcc-=
10/lab-collabora/baseline-acer-chromebox-cxi4-puff.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65e26977fee3aecac9637=
019
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
acer-chromebox-cxi5-brask    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65e2698d739d0fe5e4637057

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/x86_64/x86_64_defconfig+x86-board/gcc-=
10/lab-collabora/baseline-acer-chromebox-cxi5-brask.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/x86_64/x86_64_defconfig+x86-board/gcc-=
10/lab-collabora/baseline-acer-chromebox-cxi5-brask.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65e2698d739d0fe5e4637=
058
        failing since 25 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65e26981739d0fe5e4637051

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/x86_64/x86_64_defconfig+x86-board/gcc-=
10/lab-collabora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/x86_64/x86_64_defconfig+x86-board/gcc-=
10/lab-collabora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65e26981739d0fe5e4637=
052
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65e2697e768d92b80263701d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/x86_64/x86_64_defconfig+x86-board/gcc-=
10/lab-collabora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/x86_64/x86_64_defconfig+x86-board/gcc-=
10/lab-collabora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65e2697e768d92b802637=
01e
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | at91_d=
t_defconfig          | 7          =


  Details:     https://kernelci.org/test/plan/id/65e266abdd5b257479637021

  Results:     42 PASS, 8 FAIL, 1 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm/at91_dt_defconfig/gcc-10/lab-broon=
ie/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm/at91_dt_defconfig/gcc-10/lab-broon=
ie/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.gpio-keys-probed: https://kernelci.org/test/case/id/65e=
266abdd5b257479637026
        failing since 25 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase)

    2024-03-01T23:36:57.281085  /lava-652054/1/../bin/lava-test-case
    2024-03-01T23:36:57.316011  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dgpi=
o-keys-probed RESULT=3Dfail>   =


  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/65e266acd=
d5b25747963702c
        failing since 25 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase)

    2024-03-01T23:36:55.781072  /lava-652054/1/../bin/lava-test-case
    2024-03-01T23:36:55.815512  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dsou=
nd-card RESULT=3Dfail>   =


  * baseline.bootrr.audio-card-probed: https://kernelci.org/test/case/id/65=
e266acdd5b25747963702d
        failing since 25 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase)

    2024-03-01T23:36:54.695166  /lava-652054/1/../bin/lava-test-case
    2024-03-01T23:36:54.730564  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Daud=
io-card-probed RESULT=3Dfail>   =


  * baseline.bootrr.wm8731-driver-present: https://kernelci.org/test/case/i=
d/65e266acdd5b257479637031
        failing since 25 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase)

    2024-03-01T23:36:51.164012  /lava-652054/1/../bin/lava-test-case
    2024-03-01T23:36:51.199136  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Deep=
rom-probed RESULT=3Dblocked>
    2024-03-01T23:36:51.237352  sh: /sys/bus/spi/drivers/wm8731: unknown op=
erand
    2024-03-01T23:36:52.257814  /lava-652054/1/../bin/lava-test-case
    2024-03-01T23:36:52.293399  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dwm8=
731-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.at24-driver-present: https://kernelci.org/test/case/id/=
65e266acdd5b257479637032
        failing since 25 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase)

    2024-03-01T23:36:50.078160  /lava-652054/1/../bin/lava-test-case
    2024-03-01T23:36:50.113632  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dat2=
4-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.atmel-usart-serial-driver-present: https://kernelci.org=
/test/case/id/65e266acdd5b25747963704e
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1)

    2024-03-01T23:36:41.422374  /lava-652054/1/../bin/lava-test-case
    2024-03-01T23:36:41.459678  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Datm=
el-usart-serial-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.at91-usart-mode-driver-present: https://kernelci.org/te=
st/case/id/65e266acdd5b25747963704f
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1)

    2024-03-01T23:36:40.328506  /lava-652054/1/../bin/lava-test-case
    2024-03-01T23:36:40.366641  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dat9=
1-usart-mode-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig         | 3          =


  Details:     https://kernelci.org/test/plan/id/65e2697c739d0fe5e4637014

  Results:     43 PASS, 8 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm/multi_v5_defconfig/gcc-10/lab-broo=
nie/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm/multi_v5_defconfig/gcc-10/lab-broo=
nie/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.gpio-keys-probed: https://kernelci.org/test/case/id/65e=
2697c739d0fe5e4637019
        failing since 25 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase)

    2024-03-01T23:48:57.717175  /lava-652088/1/../bin/lava-test-case
    2024-03-01T23:48:57.756309  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dgpi=
o-keys-probed RESULT=3Dfail>   =


  * baseline.bootrr.atmel-usart-serial-driver-present: https://kernelci.org=
/test/case/id/65e2697c739d0fe5e463703d
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1)

    2024-03-01T23:48:42.898538  /lava-652088/1/../bin/lava-test-case
    2024-03-01T23:48:42.934331  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Datm=
el-usart-serial-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.at91-usart-mode-driver-present: https://kernelci.org/te=
st/case/id/65e2697c739d0fe5e463703e
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1)

    2024-03-01T23:48:41.813747  /lava-652088/1/../bin/lava-test-case
    2024-03-01T23:48:41.849534  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dat9=
1-usart-mode-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
bcm2835-rpi-b-rev2           | arm    | lab-broonie     | gcc-10   | bcm283=
5_defconfig          | 2          =


  Details:     https://kernelci.org/test/plan/id/65e2633a240438668b6370c6

  Results:     48 PASS, 3 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm/bcm2835_defconfig/gcc-10/lab-broon=
ie/baseline-bcm2835-rpi-b-rev2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm/bcm2835_defconfig/gcc-10/lab-broon=
ie/baseline-bcm2835-rpi-b-rev2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.raspberrypi-cpufreq-driver-present: https://kernelci.or=
g/test/case/id/65e2633a240438668b6370cc
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1)

    2024-03-01T23:22:12.087422  /lava-652026/1/../bin/lava-test-case
    2024-03-01T23:22:12.121723  <8>[   27.707952] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Draspberrypi-cpufreq-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.watchdog-probed: https://kernelci.org/test/case/id/65e2=
633a240438668b6370ef
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1)

    2024-03-01T23:22:08.115550  /lava-652026/1/../bin/lava-test-case
    2024-03-01T23:22:08.148910  <8>[   23.736536] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dwatchdog-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig         | 10         =


  Details:     https://kernelci.org/test/plan/id/65e26817c140fc3803637051

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm/multi_v7_defconfig/gcc-10/lab-broo=
nie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm/multi_v7_defconfig/gcc-10/lab-broo=
nie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.hdmi-audio: https://kernelci.org/test/case/id/65e26817c=
140fc3803637054
        failing since 25 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase)

    2024-03-01T23:43:10.224542  /lava-652078/1/../bin/lava-test-case
    2024-03-01T23:43:10.241229  <8>[   46.687413] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-codec-driver-present: https://kernelci.org/test/ca=
se/id/65e26817c140fc3803637057
        failing since 25 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase)

    2024-03-01T23:43:07.053949  /lava-652078/1/../bin/lava-test-case
    2024-03-01T23:43:07.071404  <8>[   43.516810] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2024-03-01T23:43:08.095407  /lava-652078/1/../bin/lava-test-case
    2024-03-01T23:43:08.115737  <8>[   44.558526] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case/id/=
65e26817c140fc3803637058
        failing since 25 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase)

    2024-03-01T23:43:04.969184  /lava-652078/1/../bin/lava-test-case
    2024-03-01T23:43:04.986901  <8>[   41.432024] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2024-03-01T23:43:06.011637  /lava-652078/1/../bin/lava-test-case
    2024-03-01T23:43:06.029182  <8>[   42.474319] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline.bootrr.tda19988-driver-present: https://kernelci.org/test/case=
/id/65e26817c140fc3803637059
        failing since 25 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase)

    2024-03-01T23:43:02.885327  /lava-652078/1/../bin/lava-test-case
    2024-03-01T23:43:02.902631  <8>[   39.347984] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2024-03-01T23:43:03.926904  /lava-652078/1/../bin/lava-test-case
    2024-03-01T23:43:03.944974  <8>[   40.389500] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/test/=
case/id/65e26817c140fc3803637063
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1)

    2024-03-01T23:42:50.215542  /lava-652078/1/../bin/lava-test-case
    2024-03-01T23:42:50.233434  <8>[   26.677838] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2024-03-01T23:42:51.257659  /lava-652078/1/../bin/lava-test-case
    2024-03-01T23:42:51.275813  <8>[   27.719846] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/65e26817c140fc3803637064
        failing since 25 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase)

    2024-03-01T23:42:49.172785  /lava-652078/1/../bin/lava-test-case
    2024-03-01T23:42:49.190846  <8>[   25.634809] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mmc1-probed: https://kernelci.org/test/case/id/65e26817=
c140fc380363706c
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1)

    2024-03-01T23:42:47.843427  /lava-652078/1/../bin/lava-test-case
    2024-03-01T23:42:47.860096  <8>[   24.305399] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmmc1-probed RESULT=3Dfail>   =


  * baseline.bootrr.mmc0-probed: https://kernelci.org/test/case/id/65e26817=
c140fc380363706d
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1)

    2024-03-01T23:42:46.794451  /lava-652078/1/../bin/lava-test-case
    2024-03-01T23:42:46.810342  <8>[   23.256496] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmmc0-probed RESULT=3Dfail>   =


  * baseline.bootrr.omap8240-driver-present: https://kernelci.org/test/case=
/id/65e26818c140fc380363707b
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1)

    2024-03-01T23:42:42.237747  /lava-652078/1/../bin/lava-test-case
    2024-03-01T23:42:42.255973  <8>[   18.699788] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Domap8240-driver-present RESULT=3Dfail>   =


  * baseline.dmesg.crit: https://kernelci.org/test/case/id/65e26818c140fc38=
03637080
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1)
        1 lines

    2024-03-01T23:42:38.872891  / # =

    2024-03-01T23:42:38.878359  =

    2024-03-01T23:42:38.981046  / # #
    2024-03-01T23:42:38.986333  #
    2024-03-01T23:42:39.087779  / # export SHELL=3D/bin/sh
    2024-03-01T23:42:39.093113  export SHELL=3D/bin/sh
    2024-03-01T23:42:39.194396  / # . /lava-652078/environment
    2024-03-01T23:42:39.199628  . /lava-652078/environment
    2024-03-01T23:42:39.300918  / # /lava-652078/bin/lava-test-runner /lava=
-652078/0
    2024-03-01T23:42:39.305563  /lava-652078/bin/lava-test-runner /lava-652=
078/0 =

    ... (9 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig        | 7          =


  Details:     https://kernelci.org/test/plan/id/65e2678c865d7dc4d7637046

  Results:     42 PASS, 9 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm/omap2plus_defconfig/gcc-10/lab-bro=
onie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm/omap2plus_defconfig/gcc-10/lab-bro=
onie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.omap-sham-driver-present: https://kernelci.org/test/cas=
e/id/65e2678c865d7dc4d7637057
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1)

    2024-03-01T23:40:34.382855  /lava-652056/1/../bin/lava-test-case
    2024-03-01T23:40:34.441481  <8>[   30.951759] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Domap-sham-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.omap-aes-driver-present: https://kernelci.org/test/case=
/id/65e2678c865d7dc4d763705a
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1)

    2024-03-01T23:40:32.021113  /lava-652056/1/../bin/lava-test-case
    2024-03-01T23:40:32.074549  <8>[   28.584858] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Domap-aes-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/test/=
case/id/65e2678c865d7dc4d763705d
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1)

    2024-03-01T23:40:28.548228  /lava-652056/1/../bin/lava-test-case
    2024-03-01T23:40:28.601063  <8>[   25.111295] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2024-03-01T23:40:29.655028  /lava-652056/1/../bin/lava-test-case
    2024-03-01T23:40:29.712851  <8>[   26.222582] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/65e2678c865d7dc4d763705e
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1)

    2024-03-01T23:40:27.440838  /lava-652056/1/../bin/lava-test-case
    2024-03-01T23:40:27.494448  <8>[   24.004168] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mmc1-probed: https://kernelci.org/test/case/id/65e2678c=
865d7dc4d7637066
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1)

    2024-03-01T23:40:25.774725  /lava-652056/1/../bin/lava-test-case
    2024-03-01T23:40:25.820317  <8>[   22.331179] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmmc1-probed RESULT=3Dfail>   =


  * baseline.bootrr.mmc0-probed: https://kernelci.org/test/case/id/65e2678c=
865d7dc4d7637067
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1)

    2024-03-01T23:40:24.655043  /lava-652056/1/../bin/lava-test-case
    2024-03-01T23:40:24.704877  <8>[   21.215667] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmmc0-probed RESULT=3Dfail>   =


  * baseline.dmesg.crit: https://kernelci.org/test/case/id/65e2678c865d7dc4=
d763707c
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1)
        1 lines

    2024-03-01T23:40:20.544666  / # =

    2024-03-01T23:40:20.557462  =

    2024-03-01T23:40:20.663661  / # #
    2024-03-01T23:40:20.671244  #
    2024-03-01T23:40:20.773928  / # export SHELL=3D/bin/sh
    2024-03-01T23:40:20.781361  export SHELL=3D/bin/sh
    2024-03-01T23:40:20.883683  / # . /lava-652056/environment
    2024-03-01T23:40:20.891413  . /lava-652056/environment
    2024-03-01T23:40:20.993719  / # /lava-652056/bin/lava-test-runner /lava=
-652056/0
    2024-03-01T23:40:20.999855  /lava-652056/bin/lava-test-runner /lava-652=
056/0 =

    ... (9 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig        | 7          =


  Details:     https://kernelci.org/test/plan/id/65e2677e55c38d37f363703d

  Results:     41 PASS, 10 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm/omap2plus_defconfig/gcc-10/lab-cip=
/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm/omap2plus_defconfig/gcc-10/lab-cip=
/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.omap-sham-driver-present: https://kernelci.org/test/cas=
e/id/65e2677e55c38d37f363704e
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1)

    2024-03-01T23:40:25.454682  /lava-1101475/1/../bin/lava-test-case
    2024-03-01T23:40:25.512643  <8>[   25.530703] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Domap-sham-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.omap-aes-driver-present: https://kernelci.org/test/case=
/id/65e2677e55c38d37f3637051
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1)

    2024-03-01T23:40:23.075167  /lava-1101475/1/../bin/lava-test-case
    2024-03-01T23:40:23.132909  <8>[   23.151005] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Domap-aes-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/test/=
case/id/65e2677e55c38d37f3637054
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1)

    2024-03-01T23:40:19.586799  /lava-1101475/1/../bin/lava-test-case
    2024-03-01T23:40:19.643254  <8>[   19.661375] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2024-03-01T23:40:20.699598  /lava-1101475/1/../bin/lava-test-case
    2024-03-01T23:40:20.754559  <8>[   20.772008] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/65e2677e55c38d37f3637055
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1)

    2024-03-01T23:40:18.475313  /lava-1101475/1/../bin/lava-test-case
    2024-03-01T23:40:18.533596  <8>[   18.551158] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mmc1-probed: https://kernelci.org/test/case/id/65e2677e=
55c38d37f363705d
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1)

    2024-03-01T23:40:16.799995  /lava-1101475/1/../bin/lava-test-case
    2024-03-01T23:40:16.853074  <8>[   16.871868] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmmc1-probed RESULT=3Dfail>   =


  * baseline.bootrr.mmc0-probed: https://kernelci.org/test/case/id/65e2677e=
55c38d37f363705e
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1)

    2024-03-01T23:40:15.674263  /lava-1101475/1/../bin/lava-test-case
    2024-03-01T23:40:15.728202  <8>[   15.746946] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmmc0-probed RESULT=3Dfail>   =


  * baseline.dmesg.crit: https://kernelci.org/test/case/id/65e2677e55c38d37=
f3637073
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1)
        1 lines

    2024-03-01T23:40:10.573656  / # =

    2024-03-01T23:40:10.582566  =

    2024-03-01T23:40:10.685870  / # #
    2024-03-01T23:40:10.692223  #
    2024-03-01T23:40:10.793404  / # export SHELL=3D/bin/sh
    2024-03-01T23:40:10.799713  export SHELL=3D/bin/sh
    2024-03-01T23:40:10.900644  / # . /lava-1101475/environment
    2024-03-01T23:40:10.907230  . /lava-1101475/environment
    2024-03-01T23:40:11.008230  / # /lava-1101475/bin/lava-test-runner /lav=
a-1101475/0
    2024-03-01T23:40:11.013243  /lava-1101475/bin/lava-test-runner /lava-11=
01475/0 =

    ... (9 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/65e265a68a527b0ed263701a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm/imx_v6_v7_defconfig/gcc-10/lab-pen=
gutronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm/imx_v6_v7_defconfig/gcc-10/lab-pen=
gutronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e265a68a527b0ed263701f
        failing since 25 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase)

    2024-03-01T23:32:43.589173  + set +x
    2024-03-01T23:32:43.589325  [    7.338183] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1031235_1.5.2.3.1>
    2024-03-01T23:32:43.695710  / # #
    2024-03-01T23:32:43.796851  export SHELL=3D/bin/sh
    2024-03-01T23:32:43.797332  #
    2024-03-01T23:32:43.898149  / # export SHELL=3D/bin/sh. /lava-1031235/e=
nvironment
    2024-03-01T23:32:43.898690  =

    2024-03-01T23:32:43.999632  / # . /lava-1031235/environment/lava-103123=
5/bin/lava-test-runner /lava-1031235/1
    2024-03-01T23:32:44.000506  =

    2024-03-01T23:32:44.003520  / # /lava-1031235/bin/lava-test-runner /lav=
a-1031235/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65e2674c3e7c925310637027

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm/multi_v7_defconfig/gcc-10/lab-peng=
utronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm/multi_v7_defconfig/gcc-10/lab-peng=
utronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e2674c3e7c92531063702c
        failing since 25 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase)

    2024-03-01T23:39:43.831240  + set +x
    2024-03-01T23:39:43.831385  [    4.826118] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1031244_1.5.2.3.1>
    2024-03-01T23:39:43.936916  / # #
    2024-03-01T23:39:44.037981  export SHELL=3D/bin/sh
    2024-03-01T23:39:44.038445  #
    2024-03-01T23:39:44.139178  / # export SHELL=3D/bin/sh. /lava-1031244/e=
nvironment
    2024-03-01T23:39:44.139566  =

    2024-03-01T23:39:44.240703  / # . /lava-1031244/environment/lava-103124=
4/bin/lava-test-runner /lava-1031244/1
    2024-03-01T23:39:44.241241  =

    2024-03-01T23:39:44.243890  / # /lava-1031244/bin/lava-test-runner /lav=
a-1031244/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65e2683c31e8320ce9637029

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm64/defconfig/gcc-10/lab-broonie/bas=
eline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm64/defconfig/gcc-10/lab-broonie/bas=
eline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65e2683c31e8320ce9637=
02a
        new failure (last pass: v5.10.209-cip44-51-gdb99ac443b0da) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-broonie     | gcc-10   | defcon=
fig                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65e266c4a7c35e761b637029

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm64/defconfig/gcc-10/lab-broonie/bas=
eline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm64/defconfig/gcc-10/lab-broonie/bas=
eline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65e266c4a7c35e761b637=
02a
        new failure (last pass: v5.10.209-cip44-51-gdb99ac443b0da) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-collabora   | gcc-10   | defcon=
fig                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65e266c0a7c35e761b637020

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm64/defconfig/gcc-10/lab-collabora/b=
aseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm64/defconfig/gcc-10/lab-collabora/b=
aseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65e266c0a7c35e761b637=
021
        new failure (last pass: v5.10.209-cip44-51-gdb99ac443b0da) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65e266e52a70b58063637028

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm64/defconfig/gcc-10/lab-broonie/bas=
eline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm64/defconfig/gcc-10/lab-broonie/bas=
eline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65e266e52a70b58063637=
029
        new failure (last pass: v5.10.209-cip44-51-gdb99ac443b0da) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-collabora   | gcc-10   | defcon=
fig                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65e266c1ef9c7ea65563701a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm64/defconfig/gcc-10/lab-collabora/b=
aseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm64/defconfig/gcc-10/lab-collabora/b=
aseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65e266c1ef9c7ea655637=
01b
        new failure (last pass: v5.10.209-cip44-51-gdb99ac443b0da) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-broonie     | gcc-10   | defcon=
fig                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65e266e62a70b5806363702e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm64/defconfig/gcc-10/lab-broonie/bas=
eline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm64/defconfig/gcc-10/lab-broonie/bas=
eline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65e266e62a70b58063637=
02f
        new failure (last pass: v5.10.209-cip44-51-gdb99ac443b0da) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-collabora   | gcc-10   | defcon=
fig                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65e266b7621d457e50637017

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm64/defconfig/gcc-10/lab-collabora/b=
aseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm64/defconfig/gcc-10/lab-collabora/b=
aseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65e266b7621d457e50637=
018
        new failure (last pass: v5.10.209-cip44-51-gdb99ac443b0da) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65e266d12a70b5806363701f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm64/defconfig/gcc-10/lab-broonie/bas=
eline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm64/defconfig/gcc-10/lab-broonie/bas=
eline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65e266d12a70b58063637=
020
        new failure (last pass: v5.10.209-cip44-51-gdb99ac443b0da) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-collabora   | gcc-10   | defcon=
fig                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65e266b6ef9c7ea655637012

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm64/defconfig/gcc-10/lab-collabora/b=
aseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm64/defconfig/gcc-10/lab-collabora/b=
aseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65e266b6ef9c7ea655637=
013
        new failure (last pass: v5.10.209-cip44-51-gdb99ac443b0da) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
qemu_mips-malta              | mips   | lab-broonie     | gcc-10   | malta_=
defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/65e26b3283c122876d637023

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/mips/malta_defconfig/gcc-10/lab-brooni=
e/baseline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/mips/malta_defconfig/gcc-10/lab-brooni=
e/baseline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65e26b3283c122876d637=
024
        failing since 25 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
qemu_mips-malta              | mips   | lab-collabora   | gcc-10   | malta_=
defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/65e26b1783c122876d63701f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/mips/malta_defconfig/gcc-10/lab-collab=
ora/baseline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/mips/malta_defconfig/gcc-10/lab-collab=
ora/baseline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65e26b1783c122876d637=
020
        failing since 25 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-broonie     | gcc-10   | x86_64=
_defconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65e26980fee3aecac9637021

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/x86_64/x86_64_defconfig+x86-board/gcc-=
10/lab-broonie/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/x86_64/x86_64_defconfig+x86-board/gcc-=
10/lab-broonie/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65e26980fee3aecac9637=
022
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-broonie     | gcc-10   | x86_64=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65e26b5a06db39c1bd637022

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/x86_64/x86_64_defconfig/gcc-10/lab-bro=
onie/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/x86_64/x86_64_defconfig/gcc-10/lab-bro=
onie/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65e26b5a06db39c1bd637=
023
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65e2697d739d0fe5e463704c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/x86_64/x86_64_defconfig+x86-board/gcc-=
10/lab-collabora/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/x86_64/x86_64_defconfig+x86-board/gcc-=
10/lab-collabora/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65e2697d739d0fe5e4637=
04d
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65e26b4956746dc08d637028

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/x86_64/x86_64_defconfig/gcc-10/lab-col=
labora/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/x86_64/x86_64_defconfig/gcc-10/lab-col=
labora/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65e26b4956746dc08d637=
029
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65e26c5213028dc8e963701c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm/shmobile_defconfig/gcc-10/lab-cip/=
baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm/shmobile_defconfig/gcc-10/lab-cip/=
baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65e26c5213028dc8e9637=
01d
        failing since 25 days (last pass: v5.10.209-cip44-rebase, first fai=
l: v5.10.209-cip44-526-gbbb905888ca85) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
r8a7796-m3ulcb               | arm64  | lab-collabora   | gcc-10   | defcon=
fig                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65e265ce009b20270263701c

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm64/defconfig/gcc-10/lab-collabora/b=
aseline-r8a7796-m3ulcb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm64/defconfig/gcc-10/lab-collabora/b=
aseline-r8a7796-m3ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e265ce009b202702637021
        failing since 408 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-rt119-1495-gc851fb1e222f)

    2024-03-01T23:43:58.450733  / # #

    2024-03-01T23:43:58.551160  export SHELL=3D/bin/sh

    2024-03-01T23:43:58.551299  #

    2024-03-01T23:43:58.651753  / # export SHELL=3D/bin/sh. /lava-12911237/=
environment

    2024-03-01T23:43:58.651920  =


    2024-03-01T23:43:58.752387  / # . /lava-12911237/environment/lava-12911=
237/bin/lava-test-runner /lava-12911237/1

    2024-03-01T23:43:58.752586  =


    2024-03-01T23:43:58.764664  / # /lava-12911237/bin/lava-test-runner /la=
va-12911237/1

    2024-03-01T23:43:58.817623  + export 'TESTRUN_ID=3D1_bootrr'

    2024-03-01T23:43:58.817696  +<8>[   12.684648] <LAVA_SIGNAL_STARTRUN 1_=
bootrr 12911237_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig         | 4          =


  Details:     https://kernelci.org/test/plan/id/65e2677e1306c9846c637023

  Results:     61 PASS, 8 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm/multi_v7_defconfig/gcc-10/lab-coll=
abora/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm/multi_v7_defconfig/gcc-10/lab-coll=
abora/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.rk_iommu-vpu_mmu-probed: https://kernelci.org/test/case=
/id/65e2677f1306c9846c637041
        new failure (last pass: v5.10.209-cip44-51-gdb99ac443b0da)

    2024-03-01T23:51:26.041473  /lava-12911262/1/../bin/lava-test-case
   =


  * baseline.bootrr.dwmmc_rockchip-sdio0-probed: https://kernelci.org/test/=
case/id/65e2677f1306c9846c637050
        failing since 25 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase)

    2024-03-01T23:51:23.746527  <8>[   14.036504] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwmmc_rockchip-sdmmc-probed RESULT=3Dfail>

    2024-03-01T23:51:24.757423  /lava-12911262/1/../bin/lava-test-case
   =


  * baseline.bootrr.dwmmc_rockchip-sdmmc-probed: https://kernelci.org/test/=
case/id/65e2677f1306c9846c637051
        failing since 17 days (last pass: v4.4.302-cip72-1251-g57b839f01594=
4, first fail: v5.10.209-cip44-51-gdb99ac443b0da)

    2024-03-01T23:51:22.730873  Box v1.31.1 (2023-06-23 08:10:20 UTC) multi=
-call binary.

    2024-03-01T23:51:22.730937  =


    2024-03-01T23:51:22.735347  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2024-03-01T23:51:22.735569  =


    2024-03-01T23:51:22.740833  Print numbers from FIRST to LAST, in steps =
of INC.

    2024-03-01T23:51:22.743280  FIRST, INC default to 1.

    2024-03-01T23:51:22.743611  =


    2024-03-01T23:51:22.747331  	-w	Pad to last with leading zeros

    2024-03-01T23:51:22.749674  	-s SEP	String separator

    2024-03-01T23:51:22.753324  /lava-12911262/1/../bin/lava-test-case
 =

    ... (2 line(s) more)  =


  * baseline.bootrr.cros-ec-dev-driver-present: https://kernelci.org/test/c=
ase/id/65e2677f1306c9846c637064
        new failure (last pass: v5.10.209-cip44-51-gdb99ac443b0da)

    2024-03-01T23:51:20.336048  =


    2024-03-01T23:51:21.351329  /lava-12911262/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                  | 12         =


  Details:     https://kernelci.org/test/plan/id/65e2673bf8b6d11523637017

  Results:     23 PASS, 16 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm64/defconfig/gcc-10/lab-broonie/bas=
eline-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm64/defconfig/gcc-10/lab-broonie/bas=
eline-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.lima-driver-present: https://kernelci.org/test/case/id/=
65e2673bf8b6d1152363701a
        new failure (last pass: v5.10.209-cip44-51-gdb99ac443b0da)

    2024-03-01T23:39:16.384310  x v1.31.1 (2023-06-23 08:09:45 UTC) multi-c=
all binary.
    2024-03-01T23:39:16.384451  =

    2024-03-01T23:39:16.384557  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST
    2024-03-01T23:39:16.384652  =

    2024-03-01T23:39:16.389976  Print numbers from FIRST to LAST, in steps =
of INC.
    2024-03-01T23:39:16.395372  FIRST, INC default to 1.
    2024-03-01T23:39:16.395525  =

    2024-03-01T23:39:16.395623  	-w	Pad to last with leading zeros
    2024-03-01T23:39:16.403215  	-s SEP	String separator
    2024-03-01T23:39:16.403364  /lava-652052/1/../bin/lava-test-case =

    ... (2 line(s) more)  =


  * baseline.bootrr.sun8i-mixer-driver-present: https://kernelci.org/test/c=
ase/id/65e2673bf8b6d1152363701c
        new failure (last pass: v5.10.209-cip44-51-gdb99ac443b0da)

    2024-03-01T23:39:15.297810  /lava-652052/1/../bin/lava-test-case
    2024-03-01T23:39:15.305846  <8>[   35.369430] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-phy-probed RESULT=3Dblocked>
    2024-03-01T23:39:16.321581  /lava-652052/1/../bin/lava-test-case
    2024-03-01T23:39:16.330476  <8>[   36.393351] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8i-mixer-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sun8i-hdmi-phy-driver-present: https://kernelci.org/tes=
t/case/id/65e2673bf8b6d1152363701d
        new failure (last pass: v5.10.209-cip44-51-gdb99ac443b0da)

    2024-03-01T23:39:14.270375  /lava-652052/1/../bin/lava-test-case
    2024-03-01T23:39:14.281766  <8>[   34.344444] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8i-hdmi-phy-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sunxi-wdt-driver-present: https://kernelci.org/test/cas=
e/id/65e2673bf8b6d11523637020
        new failure (last pass: v5.10.209-cip44-51-gdb99ac443b0da)

    2024-03-01T23:39:10.136663  <8>[   30.200012] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8i-ce-driver-present RESULT=3Dfail>
    2024-03-01T23:39:11.150516  /lava-652052/1/../bin/lava-test-case
    2024-03-01T23:39:11.160954  <8>[   31.224555] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsoc-crypto-probed RESULT=3Dblocked>
    2024-03-01T23:39:12.174488  /lava-652052/1/../bin/lava-test-case
    2024-03-01T23:39:12.185448  <8>[   32.248673] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsunxi-wdt-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sun8i-ce-driver-present: https://kernelci.org/test/case=
/id/65e2673bf8b6d11523637021
        new failure (last pass: v5.10.209-cip44-51-gdb99ac443b0da)

    2024-03-01T23:39:09.104160  /lava-652052/1/../bin/lava-test-case
    2024-03-01T23:39:09.112273  <8>[   29.176387] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsid-probed RESULT=3Dblocked>
    2024-03-01T23:39:10.128013  /lava-652052/1/../bin/lava-test-case   =


  * baseline.bootrr.eeprom-sunxi-sid-driver-present: https://kernelci.org/t=
est/case/id/65e2673bf8b6d11523637022
        new failure (last pass: v5.10.209-cip44-51-gdb99ac443b0da)

    2024-03-01T23:39:08.076851  /lava-652052/1/../bin/lava-test-case
    2024-03-01T23:39:08.088517  <8>[   28.151205] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Deeprom-sunxi-sid-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sun8i-dw-hdmi-driver-present: https://kernelci.org/test=
/case/id/65e2673bf8b6d11523637025
        new failure (last pass: v5.10.209-cip44-51-gdb99ac443b0da)

    2024-03-01T23:39:05.990885  /lava-652052/1/../bin/lava-test-case
    2024-03-01T23:39:06.000092  <8>[   26.063235] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8i-dw-hdmi-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/65e2673bf=
8b6d11523637026
        failing since 25 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase)

    2024-03-01T23:39:02.929194  <8>[   22.992594] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun4i-i2s-driver-present RESULT=3Dfail>
    2024-03-01T23:39:03.944685  /lava-652052/1/../bin/lava-test-case
    2024-03-01T23:39:03.952499  <8>[   24.016988] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Di2s-probed RESULT=3Dblocked>
    2024-03-01T23:39:04.967637  /lava-652052/1/../bin/lava-test-case
    2024-03-01T23:39:04.975106  <8>[   25.039856] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>   =


  * baseline.bootrr.sun4i-i2s-driver-present: https://kernelci.org/test/cas=
e/id/65e2673bf8b6d11523637028
        failing since 25 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase)

    2024-03-01T23:39:01.895683  /lava-652052/1/../bin/lava-test-case
    2024-03-01T23:39:01.904439  <8>[   21.968118] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcodec-digital-probed RESULT=3Dblocked>
    2024-03-01T23:39:02.920456  /lava-652052/1/../bin/lava-test-case   =


  * baseline.bootrr.sun8i-codec-driver-present: https://kernelci.org/test/c=
ase/id/65e2673bf8b6d11523637029
        failing since 25 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase)

    2024-03-01T23:38:59.846720  /lava-652052/1/../bin/lava-test-case
    2024-03-01T23:38:59.852098  <8>[   19.919128] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcodec-analog-probed RESULT=3Dblocked>
    2024-03-01T23:39:00.871089  /lava-652052/1/../bin/lava-test-case
    2024-03-01T23:39:00.880178  <8>[   20.943373] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8i-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sun50i-codec-analog-driver-present: https://kernelci.or=
g/test/case/id/65e2673bf8b6d1152363702a
        failing since 25 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase)

    2024-03-01T23:38:58.821104  /lava-652052/1/../bin/lava-test-case
    2024-03-01T23:38:58.830802  <8>[   18.893555] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun50i-codec-analog-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e2673bf8b6d1152363703d
        failing since 25 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase)

    2024-03-01T23:38:55.883035  <8>[   15.948902] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 652052_1.5.2.4.1>
    2024-03-01T23:38:55.987612  / # #
    2024-03-01T23:38:56.088931  export SHELL=3D/bin/sh
    2024-03-01T23:38:56.089214  #
    2024-03-01T23:38:56.190312  / # export SHELL=3D/bin/sh. /lava-652052/en=
vironment
    2024-03-01T23:38:56.190599  =

    2024-03-01T23:38:56.291733  / # . /lava-652052/environment/lava-652052/=
bin/lava-test-runner /lava-652052/1
    2024-03-01T23:38:56.292210  =

    2024-03-01T23:38:56.295496  / # /lava-652052/bin/lava-test-runner /lava=
-652052/1
    2024-03-01T23:38:56.326546  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig                  | 9          =


  Details:     https://kernelci.org/test/plan/id/65e265e921d4d2154a637012

  Results:     24 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm64/defconfig/gcc-10/lab-broonie/bas=
eline-sun50i-h5-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm64/defconfig/gcc-10/lab-broonie/bas=
eline-sun50i-h5-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.lima-driver-present: https://kernelci.org/test/case/id/=
65e265e921d4d2154a637015
        new failure (last pass: v5.10.209-cip44-51-gdb99ac443b0da)

    2024-03-01T23:33:46.340043  /lava-652043/1/../bin/lava-test-case
    2024-03-01T23:33:46.350523  <8>[   33.460992] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-phy-probed RESULT=3Dblocked>
    2024-03-01T23:33:47.366459  /lava-652043/1/../bin/lava-test-case
    2024-03-01T23:33:47.374735  <8>[   34.485059] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlima-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sun8i-hdmi-phy-driver-present: https://kernelci.org/tes=
t/case/id/65e265e921d4d2154a637016
        new failure (last pass: v5.10.209-cip44-51-gdb99ac443b0da)

    2024-03-01T23:33:44.293195  /lava-652043/1/../bin/lava-test-case
    2024-03-01T23:33:44.301031  <8>[   31.411858] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-probed RESULT=3Dblocked>
    2024-03-01T23:33:45.317101  /lava-652043/1/../bin/lava-test-case
    2024-03-01T23:33:45.326265  <8>[   32.435720] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8i-hdmi-phy-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sun8i-dw-hdmi-driver-present: https://kernelci.org/test=
/case/id/65e265e921d4d2154a637017
        new failure (last pass: v5.10.209-cip44-51-gdb99ac443b0da)

    2024-03-01T23:33:42.243948  /lava-652043/1/../bin/lava-test-case
    2024-03-01T23:33:42.252347  <8>[   29.362109] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8i-mixer-probed RESULT=3Dblocked>
    2024-03-01T23:33:43.268271  /lava-652043/1/../bin/lava-test-case
    2024-03-01T23:33:43.277152  <8>[   30.386576] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8i-dw-hdmi-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sun8i-mixer-driver-present: https://kernelci.org/test/c=
ase/id/65e265e921d4d2154a637018
        new failure (last pass: v5.10.209-cip44-51-gdb99ac443b0da)

    2024-03-01T23:33:40.194248  /lava-652043/1/../bin/lava-test-case
    2024-03-01T23:33:40.199789  <8>[   27.312842] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Danalog-audio-probed RESULT=3Dblocked>
    2024-03-01T23:33:41.216751  /lava-652043/1/../bin/lava-test-case
    2024-03-01T23:33:41.227979  <8>[   28.337251] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8i-mixer-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sun8-codec-analog-driver-present: https://kernelci.org/=
test/case/id/65e265e921d4d2154a637019
        failing since 25 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase)

    2024-03-01T23:33:37.129288  <8>[   24.238643] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8i-ce-driver-present RESULT=3Dfail>
    2024-03-01T23:33:38.145113  /lava-652043/1/../bin/lava-test-case
    2024-03-01T23:33:38.153230  <8>[   25.263332] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcrypto-probed RESULT=3Dblocked>
    2024-03-01T23:33:39.166880  /lava-652043/1/../bin/lava-test-case
    2024-03-01T23:33:39.178621  <8>[   26.287322] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8-codec-analog-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sun8i-ce-driver-present: https://kernelci.org/test/case=
/id/65e265e921d4d2154a63701a
        new failure (last pass: v5.10.209-cip44-51-gdb99ac443b0da)

    2024-03-01T23:33:36.096802  /lava-652043/1/../bin/lava-test-case
    2024-03-01T23:33:36.104672  <8>[   23.215052] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dir-probed RESULT=3Dblocked>
    2024-03-01T23:33:37.120565  /lava-652043/1/../bin/lava-test-case   =


  * baseline.bootrr.sunxi-ir-driver-present: https://kernelci.org/test/case=
/id/65e265e921d4d2154a63701b
        new failure (last pass: v5.10.209-cip44-51-gdb99ac443b0da)

    2024-03-01T23:33:35.070158  /lava-652043/1/../bin/lava-test-case
    2024-03-01T23:33:35.081091  <8>[   22.190558] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsunxi-ir-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sunxi-wdt-driver-present: https://kernelci.org/test/cas=
e/id/65e265e921d4d2154a63701e
        new failure (last pass: v5.10.209-cip44-51-gdb99ac443b0da)

    2024-03-01T23:33:31.950126  /lava-652043/1/../bin/lava-test-case
    2024-03-01T23:33:31.960203  <8>[   19.070741] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsid-probed RESULT=3Dblocked>
    2024-03-01T23:33:32.973959  /lava-652043/1/../bin/lava-test-case
    2024-03-01T23:33:32.984633  <8>[   20.094487] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsunxi-wdt-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.eeprom-sunxi-sid-driver-present: https://kernelci.org/t=
est/case/id/65e265e921d4d2154a63701f
        new failure (last pass: v5.10.209-cip44-51-gdb99ac443b0da)

    2024-03-01T23:33:30.924516  /lava-652043/1/../bin/lava-test-case
    2024-03-01T23:33:30.936128  <8>[   18.045112] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Deeprom-sunxi-sid-driver-present RESULT=3Dfail>   =

 =20

