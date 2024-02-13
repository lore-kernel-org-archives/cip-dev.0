Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9295C48260
	for <webhook@archiver.kernel.org>; Tue, 13 Feb 2024 19:15:56 +0000 (UTC)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
 by mx.groups.io with SMTP id smtpd.web10.22173.1707851756049658446
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 13 Feb 2024 11:15:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=Dn0qhRJv;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.173, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e0f9bcdcc2so696169b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 13 Feb 2024 11:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707851754; x=1708456554; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Hsk1Bcj7qqtv6BxZoBmhHOunL4X7Bd2JP1dc06e61Bo=;
        b=Dn0qhRJvc5qheE22oxVt5p0Qw7p7Ux0vj/eO+ayfXjqk8phXD0JkQsQ+E9XNhvV1gJ
         BgAQJUCINh4RVUwS5ye31eRQ/40Pu8LaIKKYjE4ESSqt2+rDqAQSpRuzOmBdFtv2uIrS
         GP+6N42NIMbO7GGemKTPQtkZ5eSnhUNKq+CUCGIdy99vyAP2aJ0/eMj1TtY43ZN8njn1
         t8gyDqRUIl4ZFIjlhWteMmKg4WsZTf8Co41+EryFPOl4L3rRoJBiQgCBsmDLlbDWCg3t
         ija6tn2+HEaA4OBVCxwCO1k5G7PZlJvah3I/BADiYgddp6/0yxIWwsbnz9EP0M91GJ+b
         HjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707851754; x=1708456554;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hsk1Bcj7qqtv6BxZoBmhHOunL4X7Bd2JP1dc06e61Bo=;
        b=BJkzRKiDloRaq/bTcCkdb3tH5iHaMsWLgdjkrSxx//4bnxtlFmuEZn4fzYB91TWAOf
         XQDjW0AIcbV+griY1Axcs8STfmD1/ETWPsGQwde12KM0+Knc1vlehhs1+oMXrpcx9igV
         RsKBYaJ65Yx3CySfswFTUbKo84ZcoyIWJU+o/UbCa2mZyZaFfN7i0hnpUyfnez4cVWPg
         j4VsaOpGZbSjnYM2aXoZlXyPTgntZM6KrEGmFN9kfdcDQAaynWk6Ky0ckxqH0/WUVdcL
         WDitdOWINrPEh9OKUBkPI/ANiHAWVor9UVwYPRgUQ/9IxwPQghAVwe8TvPiLfKOdA/Kj
         dWSQ==
X-Gm-Message-State: AOJu0YwY94p5eIPTJMqfkDHzoYm2sQvIZMYDl8Qr3Bywh7gmTCv/LrLa
	VOy63lHSGbtsNJfKKR1pMNnKtD7LvHOv3i/2iLRD7FyEYo+NYUuQcTB5sBJvr9dP4wwbF5mdOCm
	N8iE=
X-Google-Smtp-Source: AGHT+IGY4WO+SnYM93Q3skbgPCSvG8YKlGg3H1DK/tfv4x0cIurr8potrRtNqVKCr9saiW+HiDsWIg==
X-Received: by 2002:a05:6a20:d494:b0:19e:9d92:b6a6 with SMTP id im20-20020a056a20d49400b0019e9d92b6a6mr661900pzb.44.1707851754440;
        Tue, 13 Feb 2024 11:15:54 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id r3-20020a62e403000000b006e02f4bb4e4sm7938600pfh.18.2024.02.13.11.15.53
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 11:15:53 -0800 (PST)
Message-ID: <65cbbfe9.620a0220.43f5f.6dcd@mx.google.com>
Date: Tue, 13 Feb 2024 11:15:53 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v5.10.209-cip44-51-gdb99ac443b0da
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 33 runs,
 21 regressions (v5.10.209-cip44-51-gdb99ac443b0da)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Feb 2024 19:15:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14955

cip-gitlab/ci/pavel/linux-test baseline-nfs: 33 runs, 21 regressions (v5.10=
.209-cip44-51-gdb99ac443b0da)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
acer-cbv514-1h-34uz-brya  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =

acer-chromebox-cxi5-brask | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =

beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig         | 5          =

beaglebone-black          | arm    | lab-cip       | gcc-10   | multi_v7_de=
fconfig         | 5          =

kontron-kbox-a-230-ls     | arm64  | lab-kontron   | gcc-10   | defconfig  =
                | 3          =

kontron-sl28-var3-ads2    | arm64  | lab-kontron   | gcc-10   | defconfig  =
                | 3          =

mt8173-elm-hana           | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.209-cip44-51-gdb99ac443b0da/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.209-cip44-51-gdb99ac443b0da
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      db99ac443b0da75f00a4fc49e0040ac5dfa47e72 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
acer-cbv514-1h-34uz-brya  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65cbb4b6924a2bdb3e637065

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-nfs-acer-cbv514-1h-34uz-brya.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-nfs-acer-cbv514-1h-34uz-brya.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65cbb4b6924a2bdb3=
e637066
        failing since 8 days (last pass: v6.1.75-cip14-6-ga817aa655908, fir=
st fail: v5.10.209-cip44-rebase) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
acer-chromebox-cxi5-brask | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65cbb4ba924a2bdb3e63706b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-nfs-acer-chromebox-cxi5-brask.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-nfs-acer-chromebox-cxi5-brask.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65cbb4ba924a2bdb3=
e63706c
        failing since 8 days (last pass: v6.1.75-cip14-6-ga817aa655908, fir=
st fail: v5.10.209-cip44-rebase) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig         | 5          =


  Details:     https://kernelci.org/test/plan/id/65cbb6e9d12c0b2cc5637033

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.hdmi-audio: https://kernelci.org/test/case/id/65cbb=
6e9d12c0b2cc563703a
        failing since 8 days (last pass: v6.1.75-cip14-6-ga817aa655908, fir=
st fail: v5.10.209-cip44-rebase)

    2024-02-13T18:37:04.963678  /lava-580164/1/../bin/lava-test-case
    2024-02-13T18:37:05.021643  <8>[   81.442199] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-codec-driver-present: https://kernelci.org/tes=
t/case/id/65cbb6e9d12c0b2cc563703d
        failing since 8 days (last pass: v6.1.75-cip14-6-ga817aa655908, fir=
st fail: v5.10.209-cip44-rebase)

    2024-02-13T18:37:01.528718  /lava-580164/1/../bin/lava-test-case
    2024-02-13T18:37:01.582668  <8>[   78.004697] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2024-02-13T18:37:02.631893  /lava-580164/1/../bin/lava-test-case
    2024-02-13T18:37:02.690653  <8>[   79.111806] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case=
/id/65cbb6e9d12c0b2cc563703e
        failing since 8 days (last pass: v6.1.75-cip14-6-ga817aa655908, fir=
st fail: v5.10.209-cip44-rebase)

    2024-02-13T18:36:59.312840  /lava-580164/1/../bin/lava-test-case
    2024-02-13T18:36:59.371693  <8>[   75.793649] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2024-02-13T18:37:00.420022  /lava-580164/1/../bin/lava-test-case
    2024-02-13T18:37:00.479841  <8>[   76.901963] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tda19988-driver-present: https://kernelci.org/test/=
case/id/65cbb6e9d12c0b2cc563703f
        failing since 8 days (last pass: v6.1.75-cip14-6-ga817aa655908, fir=
st fail: v5.10.209-cip44-rebase)

    2024-02-13T18:36:57.101664  /lava-580164/1/../bin/lava-test-case
    2024-02-13T18:36:57.157701  <8>[   73.580001] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2024-02-13T18:36:58.207487  /lava-580164/1/../bin/lava-test-case
    2024-02-13T18:36:58.262357  <8>[   74.683886] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/65cbb6e9d12c0b2cc563704b
        failing since 8 days (last pass: v6.1.75-cip14-6-ga817aa655908, fir=
st fail: v5.10.209-cip44-rebase)

    2024-02-13T18:36:44.421703  /lava-580164/1/../bin/lava-test-case
    2024-02-13T18:36:44.476380  <8>[   60.898114] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
beaglebone-black          | arm    | lab-cip       | gcc-10   | multi_v7_de=
fconfig         | 5          =


  Details:     https://kernelci.org/test/plan/id/65cbb72d5fade1115d63701b

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/arm/multi_v7_defconfig/gcc-10/lab-cip/ba=
seline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/arm/multi_v7_defconfig/gcc-10/lab-cip/ba=
seline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.hdmi-audio: https://kernelci.org/test/case/id/65cbb=
72d5fade1115d637022
        failing since 8 days (last pass: v6.1.75-cip14-6-ga817aa655908, fir=
st fail: v5.10.209-cip44-rebase)

    2024-02-13T18:38:32.590662  /lava-1092735/1/../bin/lava-test-case
    2024-02-13T18:38:32.654219  <8>[   72.439725] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-codec-driver-present: https://kernelci.org/tes=
t/case/id/65cbb72d5fade1115d637025
        failing since 8 days (last pass: v6.1.75-cip14-6-ga817aa655908, fir=
st fail: v5.10.209-cip44-rebase)

    2024-02-13T18:38:29.117035  /lava-1092735/1/../bin/lava-test-case
    2024-02-13T18:38:29.181374  <8>[   68.966147] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2024-02-13T18:38:29.852213  <6>[   69.639188] platform sound: deferred =
probe pending
    2024-02-13T18:38:30.238707  /lava-1092735/1/../bin/lava-test-case
    2024-02-13T18:38:30.296501  <8>[   70.080601] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case=
/id/65cbb72d5fade1115d637026
        failing since 8 days (last pass: v6.1.75-cip14-6-ga817aa655908, fir=
st fail: v5.10.209-cip44-rebase)

    2024-02-13T18:38:26.869873  /lava-1092735/1/../bin/lava-test-case
    2024-02-13T18:38:26.940324  <8>[   66.724780] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2024-02-13T18:38:27.995645  /lava-1092735/1/../bin/lava-test-case
    2024-02-13T18:38:28.061832  <8>[   67.846338] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tda19988-driver-present: https://kernelci.org/test/=
case/id/65cbb72d5fade1115d637027
        failing since 8 days (last pass: v6.1.75-cip14-6-ga817aa655908, fir=
st fail: v5.10.209-cip44-rebase)

    2024-02-13T18:38:24.643473  /lava-1092735/1/../bin/lava-test-case
    2024-02-13T18:38:24.702986  <8>[   64.487792] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2024-02-13T18:38:25.753921  /lava-1092735/1/../bin/lava-test-case
    2024-02-13T18:38:25.814880  <8>[   65.598947] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/65cbb72d5fade1115d637030
        failing since 8 days (last pass: v6.1.75-cip14-6-ga817aa655908, fir=
st fail: v5.10.209-cip44-rebase)

    2024-02-13T18:38:11.854786  /lava-1092735/1/../bin/lava-test-case
    2024-02-13T18:38:11.915001  <8>[   51.698173] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
kontron-kbox-a-230-ls     | arm64  | lab-kontron   | gcc-10   | defconfig  =
                | 3          =


  Details:     https://kernelci.org/test/plan/id/65cbb4135019f27cc863702d

  Results:     89 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-nfs-kontron-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-nfs-kontron-kbox-a-230-ls.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rcpm-driver-present: https://kernelci.org/test/case=
/id/65cbb4135019f27cc8637071
        failing since 8 days (last pass: v6.1.75-cip14-6-ga817aa655908, fir=
st fail: v5.10.209-cip44-rebase)

    2024-02-13T18:25:05.814040  <8>[   20.580050] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dpci-host-generic-probed RESULT=3Dpass>
    2024-02-13T18:25:06.847644  /lava-429066/1/../bin/lava-test-case
    2024-02-13T18:25:06.850728  <8>[   21.620312] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.ftm-alarm-driver-present: https://kernelci.org/test=
/case/id/65cbb4135019f27cc8637072
        failing since 8 days (last pass: v6.1.75-cip14-6-ga817aa655908, fir=
st fail: v5.10.209-cip44-rebase)

    2024-02-13T18:25:07.872672  /lava-429066/1/../bin/lava-test-case
    2024-02-13T18:25:07.894653  <8>[   22.662657] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2024-02-13T18:25:08.916160  /lava-429066/1/../bin/lava-test-case
    2024-02-13T18:25:08.942050  <8>[   23.709560] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dftm-alarm-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.layerscape-sfp-driver-present: https://kernelci.org=
/test/case/id/65cbb4135019f27cc8637089
        failing since 8 days (last pass: v6.1.75-cip14-6-ga817aa655908, fir=
st fail: v5.10.209-cip44-rebase)

    2024-02-13T18:25:11.812903  /lava-429066/1/../bin/lava-test-case
    2024-02-13T18:25:11.833798  <8>[   26.601779] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
kontron-sl28-var3-ads2    | arm64  | lab-kontron   | gcc-10   | defconfig  =
                | 3          =


  Details:     https://kernelci.org/test/plan/id/65cbb43b9f0b7ec179637073

  Results:     97 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-nfs-kontron-sl28-var3-ads2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-nfs-kontron-sl28-var3-ads2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rcpm-driver-present: https://kernelci.org/test/case=
/id/65cbb43b9f0b7ec1796370be
        failing since 7 days (last pass: v6.1.75-cip14-6-ga817aa655908, fir=
st fail: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-13T18:25:39.223512  <8>[   15.234162] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dpci-host-generic-probed RESULT=3Dpass>
    2024-02-13T18:25:40.230106  /lava-429068/1/../bin/lava-test-case
    2024-02-13T18:25:40.255046  <8>[   16.267631] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.ftm-alarm-driver-present: https://kernelci.org/test=
/case/id/65cbb43b9f0b7ec1796370bf
        failing since 7 days (last pass: v6.1.75-cip14-6-ga817aa655908, fir=
st fail: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-13T18:25:41.261557  /lava-429068/1/../bin/lava-test-case
    2024-02-13T18:25:41.290352  <8>[   17.302697] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2024-02-13T18:25:42.296948  /lava-429068/1/../bin/lava-test-case
    2024-02-13T18:25:42.321886  <8>[   18.334655] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dftm-alarm-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.layerscape-sfp-driver-present: https://kernelci.org=
/test/case/id/65cbb43b9f0b7ec1796370d4
        failing since 7 days (last pass: v6.1.75-cip14-6-ga817aa655908, fir=
st fail: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-13T18:25:45.052808  /lava-429068/1/../bin/lava-test-case
    2024-02-13T18:25:45.078789  <8>[   21.091125] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
mt8173-elm-hana           | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65cbb33cd9f4ae86c26370b1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/baseline-nfs-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/baseline-nfs-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65cbb33cd9f4ae86c=
26370b2
        failing since 8 days (last pass: v6.1.75-cip14-6-ga817aa655908, fir=
st fail: v5.10.209-cip44-rebase) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/65cbb325d45c55a198637016

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/65cbb325d45c55a198637020
        failing since 8 days (last pass: v6.1.75-cip14-6-ga817aa655908, fir=
st fail: v5.10.209-cip44-rebase)

    2024-02-13T18:21:51.419163  /lava-12757876/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/65cbb325d45c55a198637021
        failing since 8 days (last pass: v6.1.75-cip14-6-ga817aa655908, fir=
st fail: v5.10.209-cip44-rebase)

    2024-02-13T18:21:50.314792  /lava-12757876/1/../bin/lava-test-case

    2024-02-13T18:21:50.355524  <8>[   37.838091] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =20

