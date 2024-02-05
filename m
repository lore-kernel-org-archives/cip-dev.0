Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C7CC48297
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 15:37:57 +0000 (UTC)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
 by mx.groups.io with SMTP id smtpd.web11.65581.1707147475155098406
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Feb 2024 07:37:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=zNaikIib;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.173, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e05456a010so58670b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Feb 2024 07:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707147474; x=1707752274; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SPra0Vdx407+8WorX16ZqT2tq1Mf/hMPhHXCiRGeH8A=;
        b=zNaikIibljU64z3K47ZIw5FNRI1Bugnz7tTIOebWRta+Z3w01bm+Zb8ZX60Ck3x/xn
         kjGLU0EYtEbLZWxG5yt1JS5hOxLx1tkJOSzj+iAR/Tw+kJxO4p5sNO4BcTJsDAOm/ezN
         hDk8HrnrHZr/yPJqYNKlin50++ifFmz+uQ+TAvqSvrMsuFXZIIU/Klhtk5EgnQsyVfYe
         Btm7+kNSZPxLHjuAiOkg7jPHVABw6e2Yv+0fK8r7BoNeP/O6lfXnF5fBaH1qpl/5JwGO
         gYe49yGdeS3pVlM5FfaFA9RUPmeSUaMBPlPlot6oG1pI9S/1Ab5OMwlfCGkcsx5eQbWV
         KJbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707147474; x=1707752274;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SPra0Vdx407+8WorX16ZqT2tq1Mf/hMPhHXCiRGeH8A=;
        b=O21KgXJjK3Ni8ZxUund8i+R8vfII0fD8zgWOqLoVDgBXKC5KZv38298TRzD3PffyWa
         23Ohpt+s4+NzENRvXwX0/dc9PH4e7veklpU4A3l2KB32nIir2FuZbBKBMnHpqDXeJg77
         OFDu6WKYgpPX2udWGegIaR0um5Tr65FUZCQ6eS2bvCS3dM3hV1mcs9quylPrzdKezbYd
         NQK0udvbj/MDSwTC0jhHd3DW42QjePuizSziBf/lZhUSbjTJr8l3zYrvDiaFyyRWFNTE
         SZckEmQxA0gGmiF5SlXvuhJA6U8IvggynR5WFQKpof/bhB3SSGT91Ao+9GrPYJxDkJif
         T5aw==
X-Gm-Message-State: AOJu0YxxPsLkfcs1gWJlseVsrF+f3Eb+XBnd4+dtfq17FEs2v9M+k3d9
	DdqoLRp8X19SHCXfoJhDiHKpUcDR4CqHI1rMW94LNNxp53Y3hlxI8eKEnW38NYOL43toSH9Auf6
	U
X-Google-Smtp-Source: AGHT+IGG3NQ1MsJMRsDNXuQxquekxPHIZEE3sBhZSvB69nMo93eTMgHtj4EAR4Yrkwi1yvoRBWcKFg==
X-Received: by 2002:aa7:84d2:0:b0:6e0:4c92:600d with SMTP id x18-20020aa784d2000000b006e04c92600dmr1593386pfn.13.1707147473242;
        Mon, 05 Feb 2024 07:37:53 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id fa33-20020a056a002d2100b006e046085ee8sm2049395pfb.174.2024.02.05.07.37.51
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 07:37:51 -0800 (PST)
Message-ID: <65c100cf.050a0220.f6184.6bda@mx.google.com>
Date: Mon, 05 Feb 2024 07:37:51 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v5.10.209-cip44-rebase
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline: 119 runs,
 64 regressions (v5.10.209-cip44-rebase)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Feb 2024 15:37:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14733

cip-gitlab/ci/pavel/linux-test baseline: 119 runs, 64 regressions (v5.10.20=
9-cip44-rebase)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
acer-cbv514-1h-34uz-brya     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =

acer-chromebox-cxi5-brask    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =

at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | at91_d=
t_defconfig          | 5          =

at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig         | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig         | 7          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig         | 7          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig        | 1          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig        | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =

imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig         | 1          =

imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig         | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig        | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig         | 1          =

juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                  | 10         =

kontron-kbox-a-230-ls        | arm64  | lab-kontron     | gcc-10   | defcon=
fig                  | 3          =

kontron-sl28-var3-ads2       | arm64  | lab-kontron     | gcc-10   | defcon=
fig                  | 3          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig+arm64-chromebook | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig                  | 1          =

mt8173-elm-hana              | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook | 1          =

qemu_mips-malta              | mips   | lab-broonie     | gcc-10   | malta_=
defconfig            | 1          =

qemu_mips-malta              | mips   | lab-collabora   | gcc-10   | malta_=
defconfig            | 1          =

rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig         | 3          =

rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook | 2          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                  | 5          =

sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig                  | 1          =

zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook | 1          =

zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig                  | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.209-cip44-rebase/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.209-cip44-rebase
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      17e47f846f71ff31baabe74a720660536794686d =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
acer-cbv514-1h-34uz-brya     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c0eeef1459c859bd00a04e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collab=
ora/baseline-acer-cbv514-1h-34uz-brya.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collab=
ora/baseline-acer-cbv514-1h-34uz-brya.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65c0eeef1459c859bd00a=
04f
        new failure (last pass: v6.1.75-cip14-132-g6e54756fbd6c2) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
acer-chromebox-cxi5-brask    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c0ef01fa50970a6e00a045

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collab=
ora/baseline-acer-chromebox-cxi5-brask.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collab=
ora/baseline-acer-chromebox-cxi5-brask.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65c0ef01fa50970a6e00a=
046
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | at91_d=
t_defconfig          | 5          =


  Details:     https://kernelci.org/test/plan/id/65c0f18329109a69c100a03d

  Results:     47 PASS, 6 FAIL, 1 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm/at91_dt_defconfig/gcc-10/lab-broonie/baseline-a=
t91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm/at91_dt_defconfig/gcc-10/lab-broonie/baseline-a=
t91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.gpio-keys-probed: https://kernelci.org/test/case/id/65c=
0f18329109a69c100a046
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:32:18.183884  /lava-545298/1/../bin/lava-test-case
    2024-02-05T14:32:18.222087  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dgpi=
o-keys-probed RESULT=3Dfail>   =


  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/65c0f1832=
9109a69c100a04c
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:32:16.629419  /lava-545298/1/../bin/lava-test-case
    2024-02-05T14:32:16.667510  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dsou=
nd-card RESULT=3Dfail>   =


  * baseline.bootrr.audio-card-probed: https://kernelci.org/test/case/id/65=
c0f18329109a69c100a04d
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:32:15.535469  /lava-545298/1/../bin/lava-test-case
    2024-02-05T14:32:15.574753  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Daud=
io-card-probed RESULT=3Dfail>   =


  * baseline.bootrr.wm8731-driver-present: https://kernelci.org/test/case/i=
d/65c0f18329109a69c100a051
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:32:11.949638  /lava-545298/1/../bin/lava-test-case
    2024-02-05T14:32:11.988624  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Deep=
rom-probed RESULT=3Dblocked>
    2024-02-05T14:32:12.035214  sh: /sys/bus/spi/drivers/wm8731: unknown op=
erand
    2024-02-05T14:32:13.051227  /lava-545298/1/../bin/lava-test-case
    2024-02-05T14:32:13.090552  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dwm8=
731-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.at24-driver-present: https://kernelci.org/test/case/id/=
65c0f18329109a69c100a052
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:32:10.848133  /lava-545298/1/../bin/lava-test-case
    2024-02-05T14:32:10.887521  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dat2=
4-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65c0f3772f8d48e1b200a04f

  Results:     48 PASS, 6 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-=
at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-=
at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.gpio-keys-probed: https://kernelci.org/test/case/id/65c=
0f3772f8d48e1b200a058
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:40:37.193586  /lava-545309/1/../bin/lava-test-case
    2024-02-05T14:40:37.231634  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dgpi=
o-keys-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig         | 7          =


  Details:     https://kernelci.org/test/plan/id/65c0f5221b5fe6c3b100a067

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-=
beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-=
beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.hdmi-audio: https://kernelci.org/test/case/id/65c0f5221=
b5fe6c3b100a06e
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:47:56.045485  /lava-545321/1/../bin/lava-test-case
    2024-02-05T14:47:56.079260  <8>[   47.696092] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/id/65=
c0f5221b5fe6c3b100a06f
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:47:54.986035  /lava-545321/1/../bin/lava-test-case
    2024-02-05T14:47:55.019919  <8>[   46.636182] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-codec-driver-present: https://kernelci.org/test/ca=
se/id/65c0f5221b5fe6c3b100a071
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:47:52.817856  /lava-545321/1/../bin/lava-test-case
    2024-02-05T14:47:52.851328  <8>[   44.467998] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2024-02-05T14:47:53.877805  /lava-545321/1/../bin/lava-test-case
    2024-02-05T14:47:53.915581  <8>[   45.528376] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case/id/=
65c0f5221b5fe6c3b100a072
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:47:50.695928  /lava-545321/1/../bin/lava-test-case
    2024-02-05T14:47:50.730593  <8>[   42.346763] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2024-02-05T14:47:51.756523  /lava-545321/1/../bin/lava-test-case
    2024-02-05T14:47:51.790827  <8>[   43.407244] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline.bootrr.tda19988-driver-present: https://kernelci.org/test/case=
/id/65c0f5221b5fe6c3b100a073
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:47:48.577490  /lava-545321/1/../bin/lava-test-case
    2024-02-05T14:47:48.612035  <8>[   40.228011] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2024-02-05T14:47:49.637614  /lava-545321/1/../bin/lava-test-case
    2024-02-05T14:47:49.666987  <8>[   41.283042] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/65c0f5221b5fe6c3b100a078
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:47:36.639811  /lava-545321/1/../bin/lava-test-case
    2024-02-05T14:47:36.679408  <8>[   28.293601] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c0f5221b5fe6c3b100a091
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:47:30.898019  <8>[   22.512800] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 545321_1.5.2.4.1>
    2024-02-05T14:47:31.008766  / # #
    2024-02-05T14:47:31.111901  export SHELL=3D/bin/sh
    2024-02-05T14:47:31.112757  #
    2024-02-05T14:47:31.214708  / # export SHELL=3D/bin/sh. /lava-545321/en=
vironment
    2024-02-05T14:47:31.215597  =

    2024-02-05T14:47:31.317765  / # . /lava-545321/environment/lava-545321/=
bin/lava-test-runner /lava-545321/1
    2024-02-05T14:47:31.319363  =

    2024-02-05T14:47:31.323609  / # /lava-545321/bin/lava-test-runner /lava=
-545321/1
    2024-02-05T14:47:31.410564  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig         | 7          =


  Details:     https://kernelci.org/test/plan/id/65c0f716b58404ba3900a039

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.hdmi-audio: https://kernelci.org/test/case/id/65c0f716b=
58404ba3900a040
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:56:17.620359  /lava-1088660/1/../bin/lava-test-case
    2024-02-05T14:56:17.654166  <8>[   40.887215] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/id/65=
c0f716b58404ba3900a041
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:56:16.560015  /lava-1088660/1/../bin/lava-test-case
    2024-02-05T14:56:16.595237  <8>[   39.827293] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-codec-driver-present: https://kernelci.org/test/ca=
se/id/65c0f716b58404ba3900a043
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:56:14.392788  /lava-1088660/1/../bin/lava-test-case
    2024-02-05T14:56:14.425963  <8>[   37.658435] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2024-02-05T14:56:15.453477  /lava-1088660/1/../bin/lava-test-case
    2024-02-05T14:56:15.485652  <8>[   38.718681] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case/id/=
65c0f716b58404ba3900a044
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:56:12.268522  /lava-1088660/1/../bin/lava-test-case
    2024-02-05T14:56:12.305611  <8>[   35.537018] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2024-02-05T14:56:13.331264  /lava-1088660/1/../bin/lava-test-case
    2024-02-05T14:56:13.364727  <8>[   36.598488] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline.bootrr.tda19988-driver-present: https://kernelci.org/test/case=
/id/65c0f716b58404ba3900a045
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:56:10.142020  /lava-1088660/1/../bin/lava-test-case
    2024-02-05T14:56:10.175998  <8>[   33.408359] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2024-02-05T14:56:11.203522  /lava-1088660/1/../bin/lava-test-case
    2024-02-05T14:56:11.241665  <8>[   34.473939] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/65c0f716b58404ba3900a051
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:55:58.194612  /lava-1088660/1/../bin/lava-test-case
    2024-02-05T14:55:58.233749  <8>[   21.464700] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c0f716b58404ba3900a06a
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:55:52.443733  <8>[   15.677290] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1088660_1.5.2.4.1>
    2024-02-05T14:55:52.551334  / # #
    2024-02-05T14:55:52.652237  export SHELL=3D/bin/sh
    2024-02-05T14:55:52.652635  #
    2024-02-05T14:55:52.753383  / # export SHELL=3D/bin/sh. /lava-1088660/e=
nvironment
    2024-02-05T14:55:52.753855  =

    2024-02-05T14:55:52.854706  / # . /lava-1088660/environment/lava-108866=
0/bin/lava-test-runner /lava-1088660/1
    2024-02-05T14:55:52.855161  =

    2024-02-05T14:55:52.861285  / # /lava-1088660/bin/lava-test-runner /lav=
a-1088660/1
    2024-02-05T14:55:52.957206  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/65c0ef29d4d1dfa14a00a045

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline=
-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline=
-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/id/6=
5c0ef29d4d1dfa14a00a064
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:22:17.433990  /lava-545267/1/../bin/lava-test-case
    2024-02-05T14:22:17.476106  <8>[   24.546352] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/65c0f2376eb387df6f00a066

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-bea=
glebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-bea=
glebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/id/6=
5c0f2376eb387df6f00a085
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:35:26.493270  /lava-1088606/1/../bin/lava-test-case
    2024-02-05T14:35:26.533046  <8>[   17.827364] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c0ee5d8b03fcea7300a04a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c0ee5d8b03fcea7300a053
        failing since 17 days (last pass: v4.19.299-cip105-1134-gc868d5e4ad=
aa, first fail: v6.1.72-cip13-30-g79e2886a5da69)

    2024-02-05T14:21:39.798468  + set +x

    2024-02-05T14:21:39.805094  <8>[   12.326692] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12704113_1.4.2.3.1>

    2024-02-05T14:21:39.912884  / # #

    2024-02-05T14:21:40.015490  export SHELL=3D/bin/sh

    2024-02-05T14:21:40.016378  #

    2024-02-05T14:21:40.118117  / # export SHELL=3D/bin/sh. /lava-12704113/=
environment

    2024-02-05T14:21:40.118966  =


    2024-02-05T14:21:40.220604  / # . /lava-12704113/environment/lava-12704=
113/bin/lava-test-runner /lava-12704113/1

    2024-02-05T14:21:40.222121  =


    2024-02-05T14:21:40.226524  / # /lava-12704113/bin/lava-test-runner /la=
va-12704113/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c0ede6dd64e9c31900a03b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c0ede6dd64e9c31900a044
        failing since 17 days (last pass: v4.19.299-cip105-1134-gc868d5e4ad=
aa, first fail: v6.1.72-cip13-30-g79e2886a5da69)

    2024-02-05T14:19:41.878620  <8>[   13.009923] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12704045_1.4.2.3.1>

    2024-02-05T14:19:41.881999  + set +x

    2024-02-05T14:19:41.983491  #

    2024-02-05T14:19:41.983784  =


    2024-02-05T14:19:42.084412  / # #export SHELL=3D/bin/sh

    2024-02-05T14:19:42.084612  =


    2024-02-05T14:19:42.185152  / # export SHELL=3D/bin/sh. /lava-12704045/=
environment

    2024-02-05T14:19:42.185406  =


    2024-02-05T14:19:42.285972  / # . /lava-12704045/environment/lava-12704=
045/bin/lava-test-runner /lava-12704045/1

    2024-02-05T14:19:42.286314  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65c0f5e0cea2b6e79a00a092

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-=
imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-=
imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65c0f5e0cea2b6e79a00a=
093
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65c0f899479e1a4edd00a03a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-=
imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-=
imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65c0f899479e1a4edd00a=
03b
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/65c0f088bd51933c6900a043

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/base=
line-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/base=
line-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c0f088bd51933c6900a04c
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:27:58.926572  + set +x
    2024-02-05T14:27:58.926760  [   10.392421] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1023770_1.5.2.3.1>
    2024-02-05T14:27:59.034133  / # #
    2024-02-05T14:27:59.135133  export SHELL=3D/bin/sh
    2024-02-05T14:27:59.135493  #
    2024-02-05T14:27:59.236172  / # export SHELL=3D/bin/sh. /lava-1023770/e=
nvironment
    2024-02-05T14:27:59.236518  =

    2024-02-05T14:27:59.337301  / # . /lava-1023770/environment/lava-102377=
0/bin/lava-test-runner /lava-1023770/1
    2024-02-05T14:27:59.337900  =

    2024-02-05T14:27:59.340797  / # /lava-1023770/bin/lava-test-runner /lav=
a-1023770/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65c0f4c30e330334c000a05e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/basel=
ine-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/basel=
ine-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c0f4c30e330334c000a067
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:46:19.516149  + set[    7.285621] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 1023773_1.5.2.3.1>
    2024-02-05T14:46:19.516341   +x
    2024-02-05T14:46:19.621559  / # #
    2024-02-05T14:46:19.722692  export SHELL=3D/bin/sh
    2024-02-05T14:46:19.723138  #
    2024-02-05T14:46:19.823913  / # export SHELL=3D/bin/sh. /lava-1023773/e=
nvironment
    2024-02-05T14:46:19.824406  =

    2024-02-05T14:46:19.925208  / # . /lava-1023773/environment/lava-102377=
3/bin/lava-test-runner /lava-1023773/1
    2024-02-05T14:46:19.925782  =

    2024-02-05T14:46:19.928638  / # /lava-1023773/bin/lava-test-runner /lav=
a-1023773/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                  | 10         =


  Details:     https://kernelci.org/test/plan/id/65c0f5bccea2b6e79a00a039

  Results:     51 PASS, 10 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-ub=
oot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-ub=
oot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.led7-probed: https://kernelci.org/test/case/id/65c0f5bc=
cea2b6e79a00a04a
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:50:26.805763  /lava-545348/1/../bin/lava-test-case
    2024-02-05T14:50:26.827769  <8>[   25.612572] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled7-probed RESULT=3Dfail>
    2024-02-05T14:50:26.827994  /lava-545348/1/../bin/lava-test-case   =


  * baseline.bootrr.led6-probed: https://kernelci.org/test/case/id/65c0f5bc=
cea2b6e79a00a04b
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:50:25.776665  /lava-545348/1/../bin/lava-test-case
    2024-02-05T14:50:25.798632  <8>[   24.583637] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled6-probed RESULT=3Dfail>   =


  * baseline.bootrr.led5-probed: https://kernelci.org/test/case/id/65c0f5bc=
cea2b6e79a00a04c
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:50:24.747954  /lava-545348/1/../bin/lava-test-case
    2024-02-05T14:50:24.769943  <8>[   23.554134] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled5-probed RESULT=3Dfail>   =


  * baseline.bootrr.led4-probed: https://kernelci.org/test/case/id/65c0f5bc=
cea2b6e79a00a04d
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:50:23.718815  /lava-545348/1/../bin/lava-test-case
    2024-02-05T14:50:23.740810  <8>[   22.525108] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled4-probed RESULT=3Dfail>   =


  * baseline.bootrr.led3-probed: https://kernelci.org/test/case/id/65c0f5bc=
cea2b6e79a00a04e
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:50:22.689772  /lava-545348/1/../bin/lava-test-case
    2024-02-05T14:50:22.711717  <8>[   21.496245] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled3-probed RESULT=3Dfail>   =


  * baseline.bootrr.led2-probed: https://kernelci.org/test/case/id/65c0f5bc=
cea2b6e79a00a04f
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:50:21.659595  /lava-545348/1/../bin/lava-test-case
    2024-02-05T14:50:21.682490  <8>[   20.467203] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled2-probed RESULT=3Dfail>   =


  * baseline.bootrr.led1-probed: https://kernelci.org/test/case/id/65c0f5bc=
cea2b6e79a00a050
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:50:20.649212  /lava-545348/1/../bin/lava-test-case
    2024-02-05T14:50:20.652517  <8>[   19.437688] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled1-probed RESULT=3Dfail>   =


  * baseline.bootrr.led0-probed: https://kernelci.org/test/case/id/65c0f5bc=
cea2b6e79a00a051
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:50:19.260795  <6>[   18.035369] input: PS/2 Generic Mouse=
 as /devices/platform/bus@8000000/bus@8000000:motherboard-bus/bus@8000000:m=
otherboard-bus:iofpga-bus@300000000/1c070000.kmi/serio1/input/input4
    2024-02-05T14:50:19.372528  <4>[   18.160992] psmouse serio1: Failed to=
 enable mouse on 1c070000.kmi
    2024-02-05T14:50:19.618123  /lava-545348/1/../bin/lava-test-case
    2024-02-05T14:50:19.621382  <8>[   18.408327] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled0-probed RESULT=3Dfail>   =


  * baseline.bootrr.iommu1-probed: https://kernelci.org/test/case/id/65c0f5=
bccea2b6e79a00a064
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:50:18.143603  /lava-545348/1/../bin/lava-test-case
    2024-02-05T14:50:18.146839  <8>[   16.932133] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Diommu1-probed RESULT=3Dfail>   =


  * baseline.bootrr.1c050000_mmc-probed: https://kernelci.org/test/case/id/=
65c0f5bccea2b6e79a00a071
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:50:16.787964  /lava-545348/1/../bin/lava-test-case
    2024-02-05T14:50:16.809006  <8>[   15.593233] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3D1c050000.mmc-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
kontron-kbox-a-230-ls        | arm64  | lab-kontron     | gcc-10   | defcon=
fig                  | 3          =


  Details:     https://kernelci.org/test/plan/id/65c0f55495fea5755500a063

  Results:     89 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron=
-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron=
-kbox-a-230-ls.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rcpm-driver-present: https://kernelci.org/test/case/id/=
65c0f55595fea5755500a0a7
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:48:25.303769  /lava-426170/1/../bin/lava-test-case
    2024-02-05T14:48:25.307005  <8>[   15.075725] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.ftm-alarm-driver-present: https://kernelci.org/test/cas=
e/id/65c0f55595fea5755500a0a8
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:48:26.315677  /lava-426170/1/../bin/lava-test-case
    2024-02-05T14:48:26.318913  <8>[   16.093342] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2024-02-05T14:48:27.339435  /lava-426170/1/../bin/lava-test-case   =


  * baseline.bootrr.layerscape-sfp-driver-present: https://kernelci.org/tes=
t/case/id/65c0f55595fea5755500a0bf
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:48:29.762988  /lava-426170/1/../bin/lava-test-case
    2024-02-05T14:48:29.766103  <8>[   19.536092] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
kontron-sl28-var3-ads2       | arm64  | lab-kontron     | gcc-10   | defcon=
fig                  | 3          =


  Details:     https://kernelci.org/test/plan/id/65c0f52cef9b31240600a058

  Results:     97 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron=
-sl28-var3-ads2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron=
-sl28-var3-ads2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rcpm-driver-present: https://kernelci.org/test/case/id/=
65c0f52cef9b31240600a0a3
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:47:59.962071  /lava-426172/1/../bin/lava-test-case
    2024-02-05T14:47:59.965413  <8>[   10.947981] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.ftm-alarm-driver-present: https://kernelci.org/test/cas=
e/id/65c0f52cef9b31240600a0a4
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:48:00.974652  /lava-426172/1/../bin/lava-test-case
    2024-02-05T14:48:00.977900  <8>[   11.965349] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2024-02-05T14:48:01.996028  /lava-426172/1/../bin/lava-test-case   =


  * baseline.bootrr.layerscape-sfp-driver-present: https://kernelci.org/tes=
t/case/id/65c0f52cef9b31240600a0b9
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:48:04.417595  /lava-426172/1/../bin/lava-test-case
    2024-02-05T14:48:04.420734  <8>[   15.404098] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65c0f03de46e6acf7700a0da

  Results:     51 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie=
/baseline-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie=
/baseline-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/65c0f03de=
46e6acf7700a0e1
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:26:50.727984  /lava-545279/1/../bin/lava-test-case
    2024-02-05T14:26:50.739313  <8>[   19.167877] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>
    2024-02-05T14:26:50.739761  + set +x   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65c0f5571b5fe6c3b100a0cb

  Results:     51 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm64/defconfig/gcc-10/lab-broonie/baseline-meson-g=
xl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm64/defconfig/gcc-10/lab-broonie/baseline-meson-g=
xl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/65c0f5571=
b5fe6c3b100a0d2
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:48:33.601074  /lava-545341/1/../bin/lava-test-case
    2024-02-05T14:48:33.606434  <8>[   18.670594] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>
    2024-02-05T14:48:33.606645  + set +x   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65c0f024e46e6acf7700a052

  Results:     28 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/baseline-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/baseline-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c0f024e46e6acf7700a072
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:27:07.638209  + set +x

    2024-02-05T14:27:07.643387  <8>[   15.577575] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12704141_1.5.2.3.1>

    2024-02-05T14:27:07.750833  / # #

    2024-02-05T14:27:07.853323  export SHELL=3D/bin/sh

    2024-02-05T14:27:07.854160  #

    2024-02-05T14:27:07.955785  / # export SHELL=3D/bin/sh. /lava-12704141/=
environment

    2024-02-05T14:27:07.956594  =


    2024-02-05T14:27:08.058244  / # . /lava-12704141/environment/lava-12704=
141/bin/lava-test-runner /lava-12704141/1

    2024-02-05T14:27:08.059498  =


    2024-02-05T14:27:08.061195  / # /lava-12704141/bin/lava-test-runner /la=
va-12704141/1
 =

    ... (20 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
qemu_mips-malta              | mips   | lab-broonie     | gcc-10   | malta_=
defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/65c0f032d6784d308f00a0ef

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/mips/malta_defconfig/gcc-10/lab-broonie/baseline-qe=
mu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/mips/malta_defconfig/gcc-10/lab-broonie/baseline-qe=
mu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65c0f032d6784d308f00a=
0f0
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
qemu_mips-malta              | mips   | lab-collabora   | gcc-10   | malta_=
defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/65c0f0067f726b0ed400a0c8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/mips/malta_defconfig/gcc-10/lab-collabora/baseline-=
qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/mips/malta_defconfig/gcc-10/lab-collabora/baseline-=
qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65c0f0067f726b0ed400a=
0c9
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig         | 3          =


  Details:     https://kernelci.org/test/plan/id/65c0f4e8c667db7a6600a03b

  Results:     63 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm/multi_v7_defconfig/gcc-10/lab-collabora/baselin=
e-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm/multi_v7_defconfig/gcc-10/lab-collabora/baselin=
e-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-iodomain-grf-probed: https://kernelci.org/test=
/case/id/65c0f4e8c667db7a6600a055
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908) =


  * baseline.bootrr.dwmmc_rockchip-sdio0-probed: https://kernelci.org/test/=
case/id/65c0f4e8c667db7a6600a06b
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:54:15.798171  <8>[   22.350861] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwmmc_rockchip-sdmmc-probed RESULT=3Dfail>

    2024-02-05T14:54:16.809760  /lava-12704178/1/../bin/lava-test-case
   =


  * baseline.bootrr.dwmmc_rockchip-sdmmc-probed: https://kernelci.org/test/=
case/id/65c0f4e8c667db7a6600a06c
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:54:14.777361  	-w	P<8>[   21.326180] <LAVA_SIGNAL_TESTCAS=
E TEST_CASE_ID=3Ddwmmc_rockchip-driver-present RESULT=3Dpass>

    2024-02-05T14:54:14.780264  ad to last with leading zeros

    2024-02-05T14:54:14.783296  	-s SEP	String separator

    2024-02-05T14:54:14.786571  /lava-12704178/1/../bin/lava-test-case

    2024-02-05T14:54:14.792704  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.

    2024-02-05T14:54:14.792955  =


    2024-02-05T14:54:14.797211  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2024-02-05T14:54:14.797455  =


    2024-02-05T14:54:14.802362  Print numbers from FIRST to LAST, in steps =
of INC.

    2024-02-05T14:54:14.804965  FIRST, INC default to 1.
 =

    ... (6 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/65c0f063ad9ba3efb700a044

  Results:     81 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/65c0f063ad9ba3efb700a04b
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:27:24.483749  /lava-12704138/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/65c0f063ad9ba3efb700a04c
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:27:23.446756  /lava-12704138/1/../bin/lava-test-case

    2024-02-05T14:27:23.457715  <8>[   33.869063] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                  | 5          =


  Details:     https://kernelci.org/test/plan/id/65c0f544a85903f61700a07e

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-=
a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-=
a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/65c0f544a=
85903f61700a097
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:48:12.158753  /lava-545347/1/../bin/lava-test-case
    2024-02-05T14:48:12.169613  <8>[   25.386497] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Di2s-probed RESULT=3Dblocked>
    2024-02-05T14:48:13.193296  /lava-545347/1/../bin/lava-test-case
    2024-02-05T14:48:13.203753  <8>[   26.420649] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>   =


  * baseline.bootrr.sun4i-i2s-driver-present: https://kernelci.org/test/cas=
e/id/65c0f544a85903f61700a098
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:48:10.086265  /lava-545347/1/../bin/lava-test-case
    2024-02-05T14:48:10.099402  <8>[   23.315190] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcodec-digital-probed RESULT=3Dblocked>
    2024-02-05T14:48:11.120957  /lava-545347/1/../bin/lava-test-case
    2024-02-05T14:48:11.132699  <8>[   24.348828] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun4i-i2s-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sun8i-codec-driver-present: https://kernelci.org/test/c=
ase/id/65c0f544a85903f61700a099
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:48:08.015414  /lava-545347/1/../bin/lava-test-case
    2024-02-05T14:48:08.026881  <8>[   21.243836] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcodec-analog-probed RESULT=3Dblocked>
    2024-02-05T14:48:09.052304  /lava-545347/1/../bin/lava-test-case
    2024-02-05T14:48:09.065162  <8>[   22.280743] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8i-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sun50i-codec-analog-driver-present: https://kernelci.or=
g/test/case/id/65c0f544a85903f61700a09b
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:48:06.978913  /lava-545347/1/../bin/lava-test-case
    2024-02-05T14:48:06.992744  <8>[   20.207739] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun50i-codec-analog-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c0f544a85903f61700a0ae
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:48:03.830712  + set +x
    2024-02-05T14:48:03.833875  <8>[   17.052669] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 545347_1.5.2.4.1>
    2024-02-05T14:48:03.944932  / # #
    2024-02-05T14:48:04.047050  export SHELL=3D/bin/sh
    2024-02-05T14:48:04.047752  #
    2024-02-05T14:48:04.149223  / # export SHELL=3D/bin/sh. /lava-545347/en=
vironment
    2024-02-05T14:48:04.149724  =

    2024-02-05T14:48:04.251023  / # . /lava-545347/environment/lava-545347/=
bin/lava-test-runner /lava-545347/1
    2024-02-05T14:48:04.251698  =

    2024-02-05T14:48:04.254930  / # /lava-545347/bin/lava-test-runner /lava=
-545347/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65c0f551ef9b31240600a0cc

  Results:     40 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-=
h5-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-=
h5-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.sun8-codec-analog-driver-present: https://kernelci.org/=
test/case/id/65c0f551ef9b31240600a0db
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T14:48:26.126815  /lava-545360/1/../bin/lava-test-case
    2024-02-05T14:48:26.142292  <8>[   19.950976] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8-codec-analog-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65c0f1e728cf8c50ea00a078

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/bas=
eline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/bas=
eline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65c0f1e728cf8c50ea00a=
079
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65c0f633c917228d4f00a039

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm64/defconfig/gcc-10/lab-cip/baseline-zynqmp-zcu1=
02.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm64/defconfig/gcc-10/lab-cip/baseline-zynqmp-zcu1=
02.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65c0f633c917228d4f00a=
03a
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908) =

 =20

