Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04D6C4829A
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 15:37:57 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web10.65931.1707147475446980338
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Feb 2024 07:37:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=KIZ2MFej;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.169, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d94b222a3aso37084635ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Feb 2024 07:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707147474; x=1707752274; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=D5uAmcBtOccmv4GCo0gXq8SlbNW1G9HVd3llaDvJMak=;
        b=KIZ2MFej2FPJk1b808WjCY1SblJY104QXpSlyhY7zqg0GouuyH/Oym1u+8rnsNYjS7
         U+J3q114ChMG6lfAgUGVjWh03t9eM6BXnXVxDiCRxgwfyia2qAsWu02r4cmPtZ9xQGco
         jx27gMeJJFOWVB29ynNLb/SwfEVopx68n/j0IlXSu1gFa3sjhC0fixQr4WofbztLCzE5
         00v6yy3p6/aqzuqPMyFXKt0zaieDRJvNIBcE24jKOKba9J9UdZKcG58Q7aRMb/u3xNOQ
         zEo9P2mtmKHIoHR85Avk+srjUBBFaELH+4T8GPj0VWEGRCu5eaWQPNmN+M/f5vFNiSxQ
         Eteg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707147474; x=1707752274;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D5uAmcBtOccmv4GCo0gXq8SlbNW1G9HVd3llaDvJMak=;
        b=Mex+btXlncMSSCcX5Az/RLZ9iYYFQJsgRXBFcljw0MBRgpBkDeAqqzoHV5crxoUlrs
         eHsa9mHKiQjqm5FHaMLqW3b1BbbS8HD8O4SF5IDeD0xx3/IaMOzR5Ax2k0ll5u31YBTc
         WjJplgdpXYSqfcqCjmoWXYAus77fLFznrdLoTE4EmiRx3tjT+S5oBYnbdSQTUEkgaExY
         rBtGGhbyrv500tHxB/HWAF+m1YflxLYA9xAgTTnjEkDlpta8QIdlmTZakUdiVwnzfZdR
         yzs5weuHGbPT1ep36Av/tGpSAhRRCBwZLpWf3YGwca5Fv/8eceFfcJEP+REizrNXEKNo
         jb7w==
X-Gm-Message-State: AOJu0YxI4TGJB28JVXHGyM7FmRYCh87bC7OxygsXjrgdfvVbr/ZYTcfa
	n3/+Pv9RYPVi1U90leSFOfIsLwPYroTqgVWFz2Z97IuFBvfX2qKplQl3MzKyIJiSMGDit7L2fIv
	u
X-Google-Smtp-Source: AGHT+IFUMRQWvZfvhktabEE2DkanLJrKFTMA1NNjkmSIcZ3+Ta99M+K4LJbMJn813KCgp35FZv0ZAg==
X-Received: by 2002:a17:902:db11:b0:1d7:8541:f914 with SMTP id m17-20020a170902db1100b001d78541f914mr14552706plx.26.1707147473811;
        Mon, 05 Feb 2024 07:37:53 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id m1-20020a170902f20100b001d9ce370415sm11511plc.90.2024.02.05.07.37.52
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 07:37:53 -0800 (PST)
Message-ID: <65c100d1.170a0220.fca3f.0141@mx.google.com>
Date: Mon, 05 Feb 2024 07:37:53 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v5.10.209-cip44-rebase
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 47 runs,
 35 regressions (v5.10.209-cip44-rebase)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Feb 2024 15:37:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14734

cip-gitlab/ci/pavel/linux-test baseline-nfs: 47 runs, 35 regressions (v5.10=
.209-cip44-rebase)

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
s_defconfig        | 2          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig        | 2          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig         | 1          =

kontron-kbox-a-230-ls        | arm64  | lab-kontron   | gcc-10   | defconfi=
g                  | 3          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =

mt8173-elm-hana              | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                  | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook | 2          =

sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.209-cip44-rebase/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.209-cip44-rebase
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      17e47f846f71ff31baabe74a720660536794686d =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
acer-cbv514-1h-34uz-brya     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c0eef4be7484439700a03e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collab=
ora/baseline-nfs-acer-cbv514-1h-34uz-brya.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collab=
ora/baseline-nfs-acer-cbv514-1h-34uz-brya.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c0eef4be7484439=
700a03f
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
acer-chromebox-cxi5-brask    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c0eefcbe7484439700a049

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collab=
ora/baseline-nfs-acer-chromebox-cxi5-brask.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collab=
ora/baseline-nfs-acer-chromebox-cxi5-brask.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c0eefcbe7484439=
700a04a
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | at91_dt_=
defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/65c0f2eb794c55976400a04d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm/at91_dt_defconfig/gcc-10/lab-broonie/baseline-n=
fs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm/at91_dt_defconfig/gcc-10/lab-broonie/baseline-n=
fs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armel/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c0f2eb794c55976=
400a04e
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65c0f43f05e6f9181300a03b

  Results:     48 PASS, 6 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-=
nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-=
nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armel/initrd.cpio.gz =



  * baseline-nfs.bootrr.gpio-keys-probed: https://kernelci.org/test/case/id=
/65c0f43f05e6f9181300a044
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:43:59.025559  /lava-545310/1/../bin/lava-test-case
    2024-02-05T14:43:59.124509  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dgpi=
o-keys-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig         | 7          =


  Details:     https://kernelci.org/test/plan/id/65c0f55ee878b7ddf000a03a

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-=
nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-=
nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.hdmi-audio: https://kernelci.org/test/case/id/65c0f=
55ee878b7ddf000a041
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:48:46.112573  /lava-545317/1/../bin/lava-test-case
    2024-02-05T14:48:46.177705  <8>[   79.746745] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/i=
d/65c0f55ee878b7ddf000a042
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:48:44.993724  /lava-545317/1/../bin/lava-test-case
    2024-02-05T14:48:45.058938  <8>[   78.627517] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-codec-driver-present: https://kernelci.org/tes=
t/case/id/65c0f55ee878b7ddf000a044
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:48:42.598545  /lava-545317/1/../bin/lava-test-case
    2024-02-05T14:48:42.675597  <8>[   76.243887] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2024-02-05T14:48:43.733745  /lava-545317/1/../bin/lava-test-case
    2024-02-05T14:48:43.800078  <8>[   77.367632] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case=
/id/65c0f55ee878b7ddf000a045
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:48:40.344285  /lava-545317/1/../bin/lava-test-case
    2024-02-05T14:48:40.417248  <8>[   73.985413] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2024-02-05T14:48:41.478160  /lava-545317/1/../bin/lava-test-case
    2024-02-05T14:48:41.544333  <8>[   75.112556] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tda19988-driver-present: https://kernelci.org/test/=
case/id/65c0f55ee878b7ddf000a046
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:48:38.068870  /lava-545317/1/../bin/lava-test-case
    2024-02-05T14:48:38.142897  <8>[   71.711893] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2024-02-05T14:48:39.205042  /lava-545317/1/../bin/lava-test-case
    2024-02-05T14:48:39.283506  <8>[   72.851307] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/65c0f55ee878b7ddf000a052
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:48:25.194656  /lava-545317/1/../bin/lava-test-case
    2024-02-05T14:48:25.263466  <8>[   58.830389] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65c0f55ee878b7ddf000a06b
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:48:17.292682  <8>[   50.862545] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 545317_1.6.2.4.1>
    2024-02-05T14:48:17.415745  / # #
    2024-02-05T14:48:17.519308  export SHELL=3D/bin/sh
    2024-02-05T14:48:17.520494  #
    2024-02-05T14:48:17.622705  / # export SHELL=3D/bin/sh. /lava-545317/en=
vironment
    2024-02-05T14:48:17.623594  =

    2024-02-05T14:48:17.725723  / # . /lava-545317/environment/lava-545317/=
bin/lava-test-runner /lava-545317/1
    2024-02-05T14:48:17.727056  =

    2024-02-05T14:48:17.730102  / # /lava-545317/bin/lava-test-runner /lava=
-545317/1
    2024-02-05T14:48:17.964988  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig         | 7          =


  Details:     https://kernelci.org/test/plan/id/65c0f59acff7d38d5300a0bb

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-=
beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-=
beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.hdmi-audio: https://kernelci.org/test/case/id/65c0f=
59acff7d38d5300a0c2
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:49:56.224534  /lava-1088657/1/../bin/lava-test-case
    2024-02-05T14:49:56.438900  <8>[   92.957628] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/i=
d/65c0f59acff7d38d5300a0c3
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:49:54.981494  /lava-1088657/1/../bin/lava-test-case
    2024-02-05T14:49:55.164080  <8>[   91.682896] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-codec-driver-present: https://kernelci.org/tes=
t/case/id/65c0f59acff7d38d5300a0c5
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:49:52.078990  /lava-1088657/1/../bin/lava-test-case
    2024-02-05T14:49:52.296560  <8>[   88.814440] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2024-02-05T14:49:53.357789  /lava-1088657/1/../bin/lava-test-case
    2024-02-05T14:49:53.539557  <8>[   90.056993] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case=
/id/65c0f59acff7d38d5300a0c6
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:49:49.606222  /lava-1088657/1/../bin/lava-test-case
    2024-02-05T14:49:49.765785  <8>[   86.283275] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2024-02-05T14:49:50.830362  /lava-1088657/1/../bin/lava-test-case
    2024-02-05T14:49:51.016300  <8>[   87.534432] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tda19988-driver-present: https://kernelci.org/test/=
case/id/65c0f59acff7d38d5300a0c7
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:49:47.085504  /lava-1088657/1/../bin/lava-test-case
    2024-02-05T14:49:47.295956  <8>[   83.813401] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2024-02-05T14:49:48.360533  /lava-1088657/1/../bin/lava-test-case
    2024-02-05T14:49:48.544571  <8>[   85.061657] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/65c0f59acff7d38d5300a0cf
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:49:31.329028  /lava-1088657/1/../bin/lava-test-case
    2024-02-05T14:49:31.752530  <8>[   68.269523] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65c0f59acff7d38d5300a0e8
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:49:19.400317  + set +x
    2024-02-05T14:49:19.403494  <8>[   55.921347] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1088657_1.6.2.4.1>
    2024-02-05T14:49:19.618817  / # #
    2024-02-05T14:49:19.720916  export SHELL=3D/bin/sh
    2024-02-05T14:49:19.721572  #
    2024-02-05T14:49:19.822805  / # export SHELL=3D/bin/sh. /lava-1088657/e=
nvironment
    2024-02-05T14:49:19.823484  =

    2024-02-05T14:49:19.924746  / # . /lava-1088657/environment/lava-108865=
7/bin/lava-test-runner /lava-1088657/1
    2024-02-05T14:49:19.925806  =

    2024-02-05T14:49:19.934135  / # /lava-1088657/bin/lava-test-runner /lav=
a-1088657/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig        | 2          =


  Details:     https://kernelci.org/test/plan/id/65c0ef4c2b41d1521e00a057

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline=
-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline=
-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/=
id/65c0ef4c2b41d1521e00a076
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:23:01.567965  /lava-545266/1/../bin/lava-test-case
    2024-02-05T14:23:01.628233  <8>[   52.483395] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65c0ef4c2b41d1521e00a091
        failing since 17 days (last pass: v4.19.299-cip105-1134-gc868d5e4ad=
aa, first fail: v6.1.72-cip13-30-g79e2886a5da69)

    2024-02-05T14:22:55.355147  + set +x
    2024-02-05T14:22:55.358822  <8>[   46.214224] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 545266_1.6.2.4.1>
    2024-02-05T14:22:55.476170  / # #
    2024-02-05T14:22:55.578639  export SHELL=3D/bin/sh
    2024-02-05T14:22:55.579280  #
    2024-02-05T14:22:55.680750  / # export SHELL=3D/bin/sh. /lava-545266/en=
vironment
    2024-02-05T14:22:55.681391  =

    2024-02-05T14:22:55.783318  / # . /lava-545266/environment/lava-545266/=
bin/lava-test-runner /lava-545266/1
    2024-02-05T14:22:55.784208  =

    2024-02-05T14:22:55.789030  / # /lava-545266/bin/lava-test-runner /lava=
-545266/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig        | 2          =


  Details:     https://kernelci.org/test/plan/id/65c0f1ee6d241d882800a06e

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs=
-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs=
-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65c0f1ee6d241d882800a0a3
        failing since 17 days (last pass: v4.19.299-cip105-1134-gc868d5e4ad=
aa, first fail: v6.1.72-cip13-30-g79e2886a5da69)

    2024-02-05T14:33:44.645262  + set +x
    2024-02-05T14:33:44.649580  <8>[   45.780518] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1088605_1.6.2.4.1>
    2024-02-05T14:33:44.844751  / # #
    2024-02-05T14:33:44.946788  export SHELL=3D/bin/sh
    2024-02-05T14:33:44.947452  #
    2024-02-05T14:33:45.048786  / # export SHELL=3D/bin/sh. /lava-1088605/e=
nvironment
    2024-02-05T14:33:45.049427  =

    2024-02-05T14:33:45.150683  / # . /lava-1088605/environment/lava-108860=
5/bin/lava-test-runner /lava-1088605/1
    2024-02-05T14:33:45.151764  =

    2024-02-05T14:33:45.157694  / # /lava-1088605/bin/lava-test-runner /lav=
a-1088605/1 =

    ... (12 line(s) more)  =


  * baseline-nfs.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/=
id/65c0f1ee6d241d882800a0a8
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:33:54.870410  /lava-1088605/1/../bin/lava-test-case
    2024-02-05T14:33:55.040208  <8>[   56.170495] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c0ee1ab87730680f00a087

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collab=
ora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collab=
ora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65c0ee1ab87730680f00a090
        failing since 17 days (last pass: v4.19.299-cip105-1134-gc868d5e4ad=
aa, first fail: v6.1.72-cip13-30-g79e2886a5da69)

    2024-02-05T14:17:48.851046  + set<8>[   22.341042] <LAVA_SIGNAL_ENDRUN =
0_dmesg 12704040_1.5.2.3.1>

    2024-02-05T14:17:48.851132   +x

    2024-02-05T14:17:48.955353  / # #

    2024-02-05T14:17:49.055929  export SHELL=3D/bin/sh

    2024-02-05T14:17:49.056085  #

    2024-02-05T14:17:49.156576  / # export SHELL=3D/bin/sh. /lava-12704040/=
environment

    2024-02-05T14:17:49.156776  =


    2024-02-05T14:17:49.257351  / # . /lava-12704040/environment/lava-12704=
040/bin/lava-test-runner /lava-12704040/1

    2024-02-05T14:17:49.257676  =


    2024-02-05T14:17:49.262249  / # /lava-12704040/bin/lava-test-runner /la=
va-12704040/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c0ee00c21acbfc9d00a039

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collab=
ora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collab=
ora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65c0ee00c21acbfc9d00a042
        failing since 17 days (last pass: v4.19.299-cip105-1134-gc868d5e4ad=
aa, first fail: v6.1.72-cip13-30-g79e2886a5da69)

    2024-02-05T14:17:15.086495  + set +x

    2024-02-05T14:17:15.093337  <8>[   17.738266] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12704104_1.5.2.3.1>

    2024-02-05T14:17:15.198852  / # #

    2024-02-05T14:17:15.301697  export SHELL=3D/bin/sh

    2024-02-05T14:17:15.302548  #

    2024-02-05T14:17:15.404641  / # export SHELL=3D/bin/sh. /lava-12704104/=
environment

    2024-02-05T14:17:15.405515  =


    2024-02-05T14:17:15.507248  / # . /lava-12704104/environment/lava-12704=
104/bin/lava-test-runner /lava-12704104/1

    2024-02-05T14:17:15.508697  =


    2024-02-05T14:17:15.514427  / # /lava-12704104/bin/lava-test-runner /la=
va-12704104/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65c0f5ddcea2b6e79a00a08c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-=
nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-=
nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c0f5ddcea2b6e79=
a00a08d
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
kontron-kbox-a-230-ls        | arm64  | lab-kontron   | gcc-10   | defconfi=
g                  | 3          =


  Details:     https://kernelci.org/test/plan/id/65c0f5cdcff7d38d5300a134

  Results:     89 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm64/defconfig/gcc-10/lab-kontron/baseline-nfs-kon=
tron-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm64/defconfig/gcc-10/lab-kontron/baseline-nfs-kon=
tron-kbox-a-230-ls.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rcpm-driver-present: https://kernelci.org/test/case=
/id/65c0f5cdcff7d38d5300a178
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:50:36.354613  /lava-426173/1/../bin/lava-test-case
    2024-02-05T14:50:36.357704  <8>[   21.305675] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.ftm-alarm-driver-present: https://kernelci.org/test=
/case/id/65c0f5cdcff7d38d5300a179
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:50:37.390399  /lava-426173/1/../bin/lava-test-case
    2024-02-05T14:50:37.393457  <8>[   22.340777] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2024-02-05T14:50:38.399507  /lava-426173/1/../bin/lava-test-case
    2024-02-05T14:50:38.427368  <8>[   23.373560] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dftm-alarm-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.layerscape-sfp-driver-present: https://kernelci.org=
/test/case/id/65c0f5cdcff7d38d5300a190
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:50:41.167605  /lava-426173/1/../bin/lava-test-case
    2024-02-05T14:50:41.183578  <8>[   26.130645] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65c0f11d5f23113bf400a05c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie=
/baseline-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie=
/baseline-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c0f11d5f23113bf=
400a05d
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65c0f572cff7d38d5300a039

  Results:     51 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-mes=
on-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-mes=
on-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.sound-card: https://kernelci.org/test/case/id/65c0f=
572cff7d38d5300a040
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:49:15.024686  /lava-545361/1/../bin/lava-test-case
    2024-02-05T14:49:15.080653  <8>[   39.433265] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65c0f065ca9173c13100a049

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/baseline-nfs-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/baseline-nfs-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c0f065ca9173c13=
100a04a
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65c0f6758433f8d9e500a039

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm64/defconfig/gcc-10/lab-cip/baseline-nfs-r8a774a=
1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm64/defconfig/gcc-10/lab-cip/baseline-nfs-r8a774a=
1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c0f6758433f8d9e=
500a03a
        failing since 5 days (last pass: v4.19.299-cip105-1134-gc868d5e4ada=
a, first fail: v6.1.72-cip13-32-gf60d2e8cb51c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/65c0f035e46e6acf7700a07a

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/65c0f035e46e6acf7700a084
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:26:54.574833  <8>[   38.092064] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2024-02-05T14:26:55.638341  /lava-12704129/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/65c0f035e46e6acf7700a085
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:26:53.460380  <8>[   36.975576] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2024-02-05T14:26:54.533760  /lava-12704129/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65c0f558ef9b31240600a0fc

  Results:     40 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-sun=
50i-h5-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-sun=
50i-h5-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.sun8-codec-analog-driver-present: https://kernelci.=
org/test/case/id/65c0f558ef9b31240600a10b
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:48:39.620900  /lava-545363/1/../bin/lava-test-case
    2024-02-05T14:48:39.656820  <8>[   38.163745] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8-codec-analog-driver-present RESULT=3Dfail>   =

 =20

