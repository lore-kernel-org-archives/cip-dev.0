Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AD4C636BD
	for <webhook@archiver.kernel.org>; Thu, 23 Nov 2023 23:49:01 +0000 (UTC)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
 by mx.groups.io with SMTP id smtpd.web10.120105.1700783335666992727
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 23 Nov 2023 15:48:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=ENcxRVcs;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.175, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5c1a75a4b6cso858719a12.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 23 Nov 2023 15:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700783334; x=1701388134; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QDQMuNxt65/cXqqdWMBcwkgTrwFss91aJziV6BZJuJw=;
        b=ENcxRVcspAh6e1XLpJIS+ZSFrit92J9x6xCMOe2voe88/FDZhO93bm3253PZf3B0JM
         F8VvE1tCs3XFH6A/4OqIowTp6v+oKebC66bs9K1h9FNNRvmGxAXZjYpIZyXIjSOPsduc
         Xh8l8RBDs9GTzfIB9oQHu5QMJ0/3U1n6yxMMJXChvub8PC3S5S0INWzRf+8UPdii8rFU
         S139kTZNorPiSWZ2xMCNq0y/gN32BZ9j28wSGirXjUT60e9ACGeVgk/pqxHSmk6gvtx3
         c5mthcx74w2U5XyrJcjrw/d9aEJD8FhYFJC+7XRSipITWSzBmKBN5l1PfpmgFxAKvIfT
         b5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700783334; x=1701388134;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QDQMuNxt65/cXqqdWMBcwkgTrwFss91aJziV6BZJuJw=;
        b=hzy0fkg1iMSgXj9JgjhpYwU6nCn+L5lda26QezloiSX1dZ2gBaqmJut7g890ViUivj
         ikvPWALCaL1GWPGsThKYHKq0Oq4Aa8RytYdCC7cD/fEhZyucZtPp1ga2uieae1v5oDsw
         2Qsoz6+qxmn5IyxmQnXfyMyrdxKSRI5Bi8G1fvK9pDRN9qT7aGAV7dcHzzcVbG0aHyrs
         gLZabpWEvZ9EgdebpyhYZzkWyyQmN1CDQhWMjpMdWWVSrP0g6ShOTiqYcR1agF+SuqIQ
         pHb85Oqllw2BKdpKcxPzBXlcHtY+anbU41BLBvXKYyvtYC0veMEmeOukfcL2hyJryx+2
         rrmg==
X-Gm-Message-State: AOJu0YyIuZHe2G8FlwOTTrKkwT+poBHC7BV4FnKmxMcJPv4jpNnuqWBZ
	xZe2yHjIK/C3QjAcjUNkouCOSJCgJllRMYJkFJo=
X-Google-Smtp-Source: AGHT+IGE+gR9qVjrQh9Ab6FGCjKzqI8i0hsqwSC+8c+/8T/fPUZ7VLuK8keHGPG4LpV1vTSaHv7ngg==
X-Received: by 2002:a17:90b:4a42:b0:281:2634:f81e with SMTP id lb2-20020a17090b4a4200b002812634f81emr905645pjb.37.1700783334049;
        Thu, 23 Nov 2023 15:48:54 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id o9-20020a170902d4c900b001c3be750900sm1889905plg.163.2023.11.23.15.48.53
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 15:48:53 -0800 (PST)
Message-ID: <655fe4e5.170a0220.22efb.509b@mx.google.com>
Date: Thu, 23 Nov 2023 15:48:53 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.201-rt98-828-g27523c64bc5dd
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 45 runs,
 41 regressions (v5.10.201-rt98-828-g27523c64bc5dd)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Nov 2023 23:49:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13693

cip-gitlab/ci/pavel/linux-test baseline-nfs: 45 runs, 41 regressions (v5.10=
.201-rt98-828-g27523c64bc5dd)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
acer-cbv514-1h-34uz-brya     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

acer-chromebox-cxi5-brask    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | at91_dt_=
defconfig          | 1          =

at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig         | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig         | 7          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig         | 7          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig        | 1          =

imx6dl-udoo                  | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig         | 1          =

imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig         | 1          =

juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 10         =

kontron-kbox-a-230-ls        | arm64  | lab-kontron   | gcc-10   | defconfi=
g                  | 3          =

kontron-sl28-var3-ads2       | arm64  | lab-kontron   | gcc-10   | defconfi=
g                  | 3          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 2          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =

sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.201-rt98-828-g27523c64bc5dd/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.201-rt98-828-g27523c64bc5dd
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      27523c64bc5dd6f1af1b227b80017fea69e616b6 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
acer-cbv514-1h-34uz-brya     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/655fdaee037a21a61b7e4aae

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-nfs-acer-cbv514-1h-34uz-brya.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-nfs-acer-cbv514-1h-34uz-brya.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/655fdaee037a21a61=
b7e4aaf
        new failure (last pass: v6.1.58-cip7-132-gb38ea1474c159) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
acer-chromebox-cxi5-brask    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/655fdae2ac3fe675c47e4a85

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-nfs-acer-chromebox-cxi5-brask.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-nfs-acer-chromebox-cxi5-brask.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/655fdae2ac3fe675c=
47e4a86
        new failure (last pass: v6.1.58-cip7-132-gb38ea1474c159) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | at91_dt_=
defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/655fde15a83729d7a67e4ac2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm/at91_dt_defconfig/gcc-10/lab-broonie=
/baseline-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm/at91_dt_defconfig/gcc-10/lab-broonie=
/baseline-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armel/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/655fde15a83729d7a=
67e4ac3
        new failure (last pass: v6.1.62-cip9-13-g34c303883a305) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/655fdc0d17951dd93f7e4ac2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm/multi_v5_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm/multi_v5_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armel/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/655fdc0d17951dd93=
f7e4ac3
        new failure (last pass: v6.1.62-cip9-13-g34c303883a305) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig         | 7          =


  Details:     https://kernelci.org/test/plan/id/655fde49bb77f99d1c7e4a77

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.hdmi-audio: https://kernelci.org/test/case/id/655fd=
e49bb77f99d1c7e4a7e
        failing since 3 days (last pass: v6.1.59-cip8-106-g65bd536c294e, fi=
rst fail: v5.10.200-cip40-513-g195b5d2b5c744)

    2023-11-23T23:20:30.859365  /lava-267172/1/../bin/lava-test-case
    2023-11-23T23:20:30.939625  <8>[   81.379211] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/i=
d/655fde49bb77f99d1c7e4a7f
        failing since 3 days (last pass: v6.1.59-cip8-106-g65bd536c294e, fi=
rst fail: v5.10.200-cip40-513-g195b5d2b5c744)

    2023-11-23T23:20:29.712698  /lava-267172/1/../bin/lava-test-case
    2023-11-23T23:20:29.800591  <8>[   80.232434] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-codec-driver-present: https://kernelci.org/tes=
t/case/id/655fde49bb77f99d1c7e4a81
        failing since 3 days (last pass: v6.1.59-cip8-106-g65bd536c294e, fi=
rst fail: v5.10.200-cip40-513-g195b5d2b5c744)

    2023-11-23T23:20:27.275355  /lava-267172/1/../bin/lava-test-case
    2023-11-23T23:20:27.358823  <8>[   77.797965] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-11-23T23:20:28.420802  /lava-267172/1/../bin/lava-test-case
    2023-11-23T23:20:28.510045  <8>[   78.950631] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case=
/id/655fde49bb77f99d1c7e4a82
        failing since 3 days (last pass: v6.1.59-cip8-106-g65bd536c294e, fi=
rst fail: v5.10.200-cip40-513-g195b5d2b5c744)

    2023-11-23T23:20:24.986077  /lava-267172/1/../bin/lava-test-case
    2023-11-23T23:20:25.069012  <8>[   75.506634] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-11-23T23:20:26.129686  /lava-267172/1/../bin/lava-test-case
    2023-11-23T23:20:26.220701  <8>[   76.653510] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tda19988-driver-present: https://kernelci.org/test/=
case/id/655fde49bb77f99d1c7e4a83
        failing since 3 days (last pass: v6.1.59-cip8-106-g65bd536c294e, fi=
rst fail: v5.10.200-cip40-513-g195b5d2b5c744)

    2023-11-23T23:20:22.707512  /lava-267172/1/../bin/lava-test-case
    2023-11-23T23:20:22.788525  <8>[   73.224348] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-11-23T23:20:23.845223  /lava-267172/1/../bin/lava-test-case
    2023-11-23T23:20:23.929062  <8>[   74.364565] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/655fde49bb77f99d1c7e4a8f
        failing since 3 days (last pass: v6.1.59-cip8-106-g65bd536c294e, fi=
rst fail: v5.10.200-cip40-513-g195b5d2b5c744)

    2023-11-23T23:20:09.183867  /lava-267172/1/../bin/lava-test-case
    2023-11-23T23:20:09.289163  <8>[   59.720362] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/655fde49bb77f99d1c7e4aa7
        failing since 3 days (last pass: v6.1.59-cip8-106-g65bd536c294e, fi=
rst fail: v5.10.200-cip40-513-g195b5d2b5c744)

    2023-11-23T23:20:00.844536  <8>[   51.271817] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 267172_1.6.2.4.1>
    2023-11-23T23:20:00.951353  / # #
    2023-11-23T23:20:01.054655  export SHELL=3D/bin/sh
    2023-11-23T23:20:01.055276  #
    2023-11-23T23:20:01.156963  / # export SHELL=3D/bin/sh. /lava-267172/en=
vironment
    2023-11-23T23:20:01.157902  =

    2023-11-23T23:20:01.260052  / # . /lava-267172/environment/lava-267172/=
bin/lava-test-runner /lava-267172/1
    2023-11-23T23:20:01.261562  =

    2023-11-23T23:20:01.264987  / # /lava-267172/bin/lava-test-runner /lava=
-267172/1
    2023-11-23T23:20:01.548035  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig         | 7          =


  Details:     https://kernelci.org/test/plan/id/655fdffacceccea6f67e4a7e

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm/multi_v7_defconfig/gcc-10/lab-cip/ba=
seline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm/multi_v7_defconfig/gcc-10/lab-cip/ba=
seline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.hdmi-audio: https://kernelci.org/test/case/id/655fd=
ffacceccea6f67e4a85
        failing since 3 days (last pass: v6.1.59-cip8-106-g65bd536c294e, fi=
rst fail: v5.10.200-cip40-513-g195b5d2b5c744)

    2023-11-23T23:27:42.912894  /lava-1044092/1/../bin/lava-test-case
    2023-11-23T23:27:42.980669  <8>[   75.098060] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/i=
d/655fdffacceccea6f67e4a86
        failing since 3 days (last pass: v6.1.59-cip8-106-g65bd536c294e, fi=
rst fail: v5.10.200-cip40-513-g195b5d2b5c744)

    2023-11-23T23:27:41.791554  /lava-1044092/1/../bin/lava-test-case
    2023-11-23T23:27:41.860787  <8>[   73.977940] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-codec-driver-present: https://kernelci.org/tes=
t/case/id/655fdffacceccea6f67e4a88
        failing since 3 days (last pass: v6.1.59-cip8-106-g65bd536c294e, fi=
rst fail: v5.10.200-cip40-513-g195b5d2b5c744)

    2023-11-23T23:27:39.452665  /lava-1044092/1/../bin/lava-test-case
    2023-11-23T23:27:39.521032  <8>[   71.637163] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-11-23T23:27:40.572076  /lava-1044092/1/../bin/lava-test-case
    2023-11-23T23:27:40.639992  <8>[   72.757784] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case=
/id/655fdffacceccea6f67e4a89
        failing since 3 days (last pass: v6.1.59-cip8-106-g65bd536c294e, fi=
rst fail: v5.10.200-cip40-513-g195b5d2b5c744)

    2023-11-23T23:27:37.209075  /lava-1044092/1/../bin/lava-test-case
    2023-11-23T23:27:37.281508  <8>[   69.399390] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-11-23T23:27:37.516779  <6>[   69.636978] platform sound: deferred =
probe pending
    2023-11-23T23:27:38.330623  /lava-1044092/1/../bin/lava-test-case
    2023-11-23T23:27:38.401113  <8>[   70.515999] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tda19988-driver-present: https://kernelci.org/test/=
case/id/655fdffacceccea6f67e4a8a
        failing since 3 days (last pass: v6.1.59-cip8-106-g65bd536c294e, fi=
rst fail: v5.10.200-cip40-513-g195b5d2b5c744)

    2023-11-23T23:27:34.970789  /lava-1044092/1/../bin/lava-test-case
    2023-11-23T23:27:35.039080  <8>[   67.156646] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-11-23T23:27:36.087143  /lava-1044092/1/../bin/lava-test-case
    2023-11-23T23:27:36.159955  <8>[   68.272803] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/655fdffacceccea6f67e4a96
        failing since 3 days (last pass: v6.1.59-cip8-106-g65bd536c294e, fi=
rst fail: v5.10.200-cip40-513-g195b5d2b5c744)

    2023-11-23T23:27:22.187161  /lava-1044092/1/../bin/lava-test-case
    2023-11-23T23:27:22.260097  <8>[   54.371702] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/655fdffacceccea6f67e4aaf
        failing since 3 days (last pass: v6.1.59-cip8-106-g65bd536c294e, fi=
rst fail: v5.10.200-cip40-513-g195b5d2b5c744)

    2023-11-23T23:27:14.882560  <8>[   46.982730] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1044092_1.6.2.4.1>
    2023-11-23T23:27:14.987149  / #
    2023-11-23T23:27:15.088805  # #export SHELL=3D/bin/sh
    2023-11-23T23:27:15.089251  =

    2023-11-23T23:27:15.190192  / # export SHELL=3D/bin/sh. /lava-1044092/e=
nvironment
    2023-11-23T23:27:15.190639  =

    2023-11-23T23:27:15.291588  / # . /lava-1044092/environment/lava-104409=
2/bin/lava-test-runner /lava-1044092/1
    2023-11-23T23:27:15.292308  =

    2023-11-23T23:27:15.296264  / # /lava-1044092/bin/lava-test-runner /lav=
a-1044092/1
    2023-11-23T23:27:15.521347  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/655fdf1b7e9b8682317e4a72

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm/omap2plus_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm/omap2plus_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/=
id/655fdf1b7e9b8682317e4a91
        failing since 3 days (last pass: v6.1.59-cip8-106-g65bd536c294e, fi=
rst fail: v5.10.200-cip40-513-g195b5d2b5c744)

    2023-11-23T23:23:50.639870  /lava-267203/1/../bin/lava-test-case
    2023-11-23T23:23:50.729915  <8>[   59.365546] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
imx6dl-udoo                  | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/655fe0671c3d5c0cb47e4a78

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/655fe0671c3d5c0cb=
47e4a79
        failing since 3 days (last pass: v6.1.59-cip8-106-g65bd536c294e, fi=
rst fail: v5.10.200-cip40-513-g195b5d2b5c744) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/655fe0655a1c84f1397e4a89

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/655fe0655a1c84f13=
97e4a8a
        failing since 3 days (last pass: v6.1.59-cip8-106-g65bd536c294e, fi=
rst fail: v5.10.200-cip40-513-g195b5d2b5c744) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 10         =


  Details:     https://kernelci.org/test/plan/id/655fde6500e3dae7027e4a8a

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-nfs-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-nfs-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.led7-probed: https://kernelci.org/test/case/id/655f=
de6500e3dae7027e4a9b
        new failure (last pass: v6.1.62-cip9-13-g34c303883a305)

    2023-11-23T23:20:50.527385  /lava-267153/1/../bin/lava-test-case
    2023-11-23T23:20:50.572162  <8>[   70.093992] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled7-probed RESULT=3Dfail>
    2023-11-23T23:20:50.572504  /lava-267153/1/../bin/lava-test-case   =


  * baseline-nfs.bootrr.led6-probed: https://kernelci.org/test/case/id/655f=
de6500e3dae7027e4a9c
        new failure (last pass: v6.1.62-cip9-13-g34c303883a305)

    2023-11-23T23:20:49.450398  /lava-267153/1/../bin/lava-test-case
    2023-11-23T23:20:49.488443  <8>[   69.012758] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled6-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led5-probed: https://kernelci.org/test/case/id/655f=
de6500e3dae7027e4a9d
        new failure (last pass: v6.1.62-cip9-13-g34c303883a305)

    2023-11-23T23:20:48.363637  /lava-267153/1/../bin/lava-test-case
    2023-11-23T23:20:48.411373  <8>[   67.935082] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled5-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led4-probed: https://kernelci.org/test/case/id/655f=
de6500e3dae7027e4a9e
        new failure (last pass: v6.1.62-cip9-13-g34c303883a305)

    2023-11-23T23:20:47.287683  /lava-267153/1/../bin/lava-test-case
    2023-11-23T23:20:47.340300  <8>[   66.861423] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled4-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led3-probed: https://kernelci.org/test/case/id/655f=
de6500e3dae7027e4a9f
        new failure (last pass: v6.1.62-cip9-13-g34c303883a305)

    2023-11-23T23:20:45.284014  <4>[   64.785396] amba 20010000.etf: deferr=
ed probe timeout, ignoring dependency
    2023-11-23T23:20:45.284595  <4>[   64.785421] amba 20030000.tpiu: defer=
red probe timeout, ignoring dependency
    2023-11-23T23:20:45.285009  <4>[   64.785438] amba 20040000.funnel: def=
erred probe timeout, ignoring dependency
    2023-11-23T23:20:45.285687  <4>[   64.785456] amba 20070000.etr: deferr=
ed probe timeout, ignoring dependency
    2023-11-23T23:20:45.286121  <4>[   64.785471] amba 20100000.stm: deferr=
ed probe timeout, ignoring dependency
    2023-11-23T23:20:45.327404  <4>[   64.785487] amba 20120000.replicator:=
 deferred probe timeout, ignoring dependency
    2023-11-23T23:20:45.327948  <4>[   64.785503] amba 22010000.cpu-debug: =
deferred probe timeout, ignoring dependency
    2023-11-23T23:20:45.328349  <4>[   64.785517] amba 22040000.etm: deferr=
ed probe timeout, ignoring dependency
    2023-11-23T23:20:45.329050  <4>[   64.785532] amba 220c0000.funnel: def=
erred probe timeout, ignoring dependency
    2023-11-23T23:20:45.329452  <4>[   64.785547] amba 22110000.cpu-debug: =
deferred probe timeout, ignoring dependency =

    ... (12 line(s) more)  =


  * baseline-nfs.bootrr.led2-probed: https://kernelci.org/test/case/id/655f=
de6500e3dae7027e4aa0
        new failure (last pass: v6.1.62-cip9-13-g34c303883a305)

    2023-11-23T23:20:45.155520  /lava-267153/1/../bin/lava-test-case
    2023-11-23T23:20:45.192338  <8>[   64.715185] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled2-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led1-probed: https://kernelci.org/test/case/id/655f=
de6500e3dae7027e4aa1
        new failure (last pass: v6.1.62-cip9-13-g34c303883a305)

    2023-11-23T23:20:44.063649  /lava-267153/1/../bin/lava-test-case
    2023-11-23T23:20:44.116614  <8>[   63.638442] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled1-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led0-probed: https://kernelci.org/test/case/id/655f=
de6500e3dae7027e4aa2
        new failure (last pass: v6.1.62-cip9-13-g34c303883a305)

    2023-11-23T23:20:42.962601  <4>[   62.482480] arm-smmu 2b600000.iommu: =
deferred probe timeout, ignoring dependency
    2023-11-23T23:20:42.965817  <4>[   62.482498] arm-smmu: probe of 2b6000=
00.iommu failed with error -110
    2023-11-23T23:20:42.981562  /lava-267153/1/../bin/lava-test-case
    2023-11-23T23:20:43.040526  <8>[   62.564428] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled0-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.iommu1-probed: https://kernelci.org/test/case/id/65=
5fde6500e3dae7027e4ab5
        new failure (last pass: v6.1.62-cip9-13-g34c303883a305)

    2023-11-23T23:20:40.866591  /lava-267153/1/../bin/lava-test-case
    2023-11-23T23:20:40.920482  <8>[   60.445234] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Diommu1-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.1c050000_mmc-probed: https://kernelci.org/test/case=
/id/655fde6500e3dae7027e4ac2
        new failure (last pass: v6.1.62-cip9-13-g34c303883a305)

    2023-11-23T23:20:39.058496  /lava-267153/1/../bin/lava-test-case
    2023-11-23T23:20:39.112099  <8>[   58.635712] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3D1c050000.mmc-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
kontron-kbox-a-230-ls        | arm64  | lab-kontron   | gcc-10   | defconfi=
g                  | 3          =


  Details:     https://kernelci.org/test/plan/id/655fdc1efc21df66b37e4a6d

  Results:     89 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-nfs-kontron-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-nfs-kontron-kbox-a-230-ls.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rcpm-driver-present: https://kernelci.org/test/case=
/id/655fdc1efc21df66b37e4ab1
        new failure (last pass: v6.1.62-cip9-13-g34c303883a305)

    2023-11-23T23:11:12.979391  /lava-397896/1/../bin/lava-test-case
    2023-11-23T23:11:13.004196  <8>[   21.837488] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.ftm-alarm-driver-present: https://kernelci.org/test=
/case/id/655fdc1efc21df66b37e4ab2
        new failure (last pass: v6.1.62-cip9-13-g34c303883a305)

    2023-11-23T23:11:14.010414  /lava-397896/1/../bin/lava-test-case
    2023-11-23T23:11:14.038412  <8>[   22.872717] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2023-11-23T23:11:15.044244  /lava-397896/1/../bin/lava-test-case
    2023-11-23T23:11:15.076146  <8>[   23.908793] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dftm-alarm-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.layerscape-sfp-driver-present: https://kernelci.org=
/test/case/id/655fdc1efc21df66b37e4ac9
        new failure (last pass: v6.1.62-cip9-13-g34c303883a305)

    2023-11-23T23:11:17.867290  /lava-397896/1/../bin/lava-test-case
    2023-11-23T23:11:17.888309  <8>[   26.721839] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
kontron-sl28-var3-ads2       | arm64  | lab-kontron   | gcc-10   | defconfi=
g                  | 3          =


  Details:     https://kernelci.org/test/plan/id/655fdc0a0e869dd7f07e4aa8

  Results:     97 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-nfs-kontron-sl28-var3-ads2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-nfs-kontron-sl28-var3-ads2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rcpm-driver-present: https://kernelci.org/test/case=
/id/655fdc0a0e869dd7f07e4af3
        new failure (last pass: v6.1.62-cip9-13-g34c303883a305)

    2023-11-23T23:10:49.375085  /lava-397899/1/../bin/lava-test-case
    2023-11-23T23:10:49.406023  <8>[   16.123354] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.ftm-alarm-driver-present: https://kernelci.org/test=
/case/id/655fdc0a0e869dd7f07e4af4
        new failure (last pass: v6.1.62-cip9-13-g34c303883a305)

    2023-11-23T23:10:50.413557  /lava-397899/1/../bin/lava-test-case
    2023-11-23T23:10:50.441508  <8>[   17.161481] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2023-11-23T23:10:51.449169  /lava-397899/1/../bin/lava-test-case
    2023-11-23T23:10:51.474273  <8>[   18.194221] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dftm-alarm-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.layerscape-sfp-driver-present: https://kernelci.org=
/test/case/id/655fdc0a0e869dd7f07e4b09
        new failure (last pass: v6.1.62-cip9-13-g34c303883a305)

    2023-11-23T23:10:54.174985  /lava-397899/1/../bin/lava-test-case
    2023-11-23T23:10:54.202324  <8>[   20.920218] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 2          =


  Details:     https://kernelci.org/test/plan/id/655fdbbf6b0ac1b7f27e4a6d

  Results:     50 PASS, 4 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.sound-card: https://kernelci.org/test/case/id/655fd=
bbf6b0ac1b7f27e4a74
        new failure (last pass: v6.1.62-cip9-13-g34c303883a305)

    2023-11-23T23:09:29.813200  /lava-267129/1/../bin/lava-test-case
    2023-11-23T23:09:29.896036  <8>[   38.532079] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>
    2023-11-23T23:09:29.896375  + set +x   =


  * baseline-nfs.bootrr.cpufreq-probed: https://kernelci.org/test/case/id/6=
55fdbbf6b0ac1b7f27e4a9d
        new failure (last pass: v6.1.62-cip9-13-g34c303883a305)

    2023-11-23T23:09:25.468485  /lava-267129/1/../bin/lava-test-case
    2023-11-23T23:09:25.537455  <8>[   34.168754] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpufreq-probed RESULT=3Dfail>
    2023-11-23T23:09:25.537809  /lava-267129/1/../bin/lava-test-case   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/655fddf5a83729d7a67e4aad

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-nfs-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-nfs-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/655fddf5a83729d7a=
67e4aae
        new failure (last pass: v6.1.62-cip9-13-g34c303883a305) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/655fdcb4c307fbe1ca7e4abd

  Results:     40 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-nfs-sun50i-h5-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-nfs-sun50i-h5-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.sun8-codec-analog-driver-present: https://kernelci.=
org/test/case/id/655fdcb4c307fbe1ca7e4acc
        new failure (last pass: v6.1.62-cip9-13-g34c303883a305)

    2023-11-23T23:13:24.668140  /lava-267138/1/../bin/lava-test-case
    2023-11-23T23:13:24.717631  <8>[   46.963316] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8-codec-analog-driver-present RESULT=3Dfail>   =

 =20

