Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E20C4829C
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 23:54:51 +0000 (UTC)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
 by mx.groups.io with SMTP id smtpd.web10.10010.1707177286138798839
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Feb 2024 15:54:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=miJJoYv8;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.51, mailfrom: bot@kernelci.org)
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6e2af0bc0dbso92328a34.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Feb 2024 15:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707177285; x=1707782085; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RyLdEU1tuRZnLxIrTmumls1+xO56CJyTp8+q1OfXO4c=;
        b=miJJoYv8TU8Ax4uiS2E3wfV2j+Jo0NMijLias83y4Ao0Jco9USfeoHnunbkSl2lgnb
         sIWWlQH3J4fCeyJJjRu2kZT0j9QP2Pjhu0KJwKhwVc3Rdni2NquhwZY/A8XOJ+IxfTUN
         r9TNzurBISOdlwn2sv9/HKpI+ilg47GXl+h/M/5IKIExsVQVWZRO7juEeCCs7tl8bHXz
         vpdhWBp5Paa8Kc5pYp45TrX4RXjcqpa50Rf7ivkA09+s8faTWPeIhJQ2Jyv5TL7SWsN5
         XtRx7R/44d596RRAaiPpDrra2CczktEzMftHUHPlmd8XyGyHm973KMSZb07DkA/wYlOj
         rAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707177285; x=1707782085;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RyLdEU1tuRZnLxIrTmumls1+xO56CJyTp8+q1OfXO4c=;
        b=iDcf/8CwkGMY+X50TNvsCQQpeAKEfM0PetAfPag+I6GJ5j97Qc1YMABARUIezu7gEK
         7n9WdMcV6KFvNhdz5/vYQSzVLV6UuISDf+Kx0g272TU21cH9l6iWrtHi0tgu2aszHpqD
         b+tpyryxDzc7HP1I5ip+nlBhggFGWOxas811SVpL1w8JKTEB9VtPAiwNA+a0bZsQWdWQ
         EgVWCNj2W0x7pBtRCN0Eq/vsj5qNLdG8hiwxyQ1YAN1gv+mbsvQBAGcbZo9+BynhjIUY
         gDCCA0biZm46a+75qF8qXcQzSDfXqcNlFQwWxvx6r0aXRWSr4+J7A/gVo83i86vg0k89
         /BXw==
X-Gm-Message-State: AOJu0Yx3tQHJxKRbDZij4dVF7M3qeIzyEGV7ToP3RfQueDBGU4YGJFUx
	AJwVZ2yWesDH0H2ic3jy8lBq7QrCMbuWdaa7quiY1fgX31GE/Dzh0uodyVCB/E1OxJamwb3q6B1
	/
X-Google-Smtp-Source: AGHT+IFDRIG8zIENJQVZiRfOpKjnUxt/1BVLVvot1R7j0+bi/v5v3knVuBhfBOkzy/XNRAt4CumaQQ==
X-Received: by 2002:a05:6830:1e3b:b0:6e2:af2b:ad7a with SMTP id t27-20020a0568301e3b00b006e2af2bad7amr254608otr.25.1707177283575;
        Mon, 05 Feb 2024 15:54:43 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u18-20020a634552000000b005d34cf68664sm653330pgk.25.2024.02.05.15.54.42
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 15:54:42 -0800 (PST)
Message-ID: <65c17542.630a0220.3396e.3f6c@mx.google.com>
Date: Mon, 05 Feb 2024 15:54:42 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v5.10.209-cip44-526-gbbb905888ca85
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline: 119 runs,
 63 regressions (v5.10.209-cip44-526-gbbb905888ca85)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Feb 2024 23:54:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14759

cip-gitlab/ci/pavel/linux-test baseline: 119 runs, 63 regressions (v5.10.20=
9-cip44-526-gbbb905888ca85)

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
fig                  | 11         =

kontron-kbox-a-230-ls        | arm64  | lab-kontron     | gcc-10   | defcon=
fig                  | 3          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig                  | 2          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig+arm64-chromebook | 2          =

qemu_mips-malta              | mips   | lab-broonie     | gcc-10   | malta_=
defconfig            | 1          =

qemu_mips-malta              | mips   | lab-collabora   | gcc-10   | malta_=
defconfig            | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig         | 1          =

rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig         | 3          =

rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook | 2          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                  | 5          =

sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig                  | 1          =

zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig                  | 1          =

zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.209-cip44-526-gbbb905888ca85/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.209-cip44-526-gbbb905888ca85
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      bbb905888ca85ace83da9e4113b4957345c47d70 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
acer-cbv514-1h-34uz-brya     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c169d97c5ae4b3cc00a06d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-acer-cbv514-1h-34uz-brya.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-acer-cbv514-1h-34uz-brya.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65c169d97c5ae4b3cc00a=
06e
        failing since 0 day (last pass: v6.1.75-cip14-132-g6e54756fbd6c2, f=
irst fail: v5.10.209-cip44-rebase) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
acer-chromebox-cxi5-brask    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c169d17c5ae4b3cc00a067

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-acer-chromebox-cxi5-brask.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-acer-chromebox-cxi5-brask.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65c169d17c5ae4b3cc00a=
068
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | at91_d=
t_defconfig          | 5          =


  Details:     https://kernelci.org/test/plan/id/65c164a9050f458b6200a04c

  Results:     47 PASS, 6 FAIL, 1 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm/at91_dt_defconfig/gcc-10/lab-brooni=
e/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm/at91_dt_defconfig/gcc-10/lab-brooni=
e/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.gpio-keys-probed: https://kernelci.org/test/case/id/65c=
164a9050f458b6200a055
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T22:43:38.526181  /lava-546675/1/../bin/lava-test-case
    2024-02-05T22:43:38.566558  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dgpi=
o-keys-probed RESULT=3Dfail>   =


  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/65c164a90=
50f458b6200a05b
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T22:43:36.963842  /lava-546675/1/../bin/lava-test-case
    2024-02-05T22:43:37.003609  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dsou=
nd-card RESULT=3Dfail>   =


  * baseline.bootrr.audio-card-probed: https://kernelci.org/test/case/id/65=
c164a9050f458b6200a05c
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T22:43:35.862150  /lava-546675/1/../bin/lava-test-case
    2024-02-05T22:43:35.902222  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Daud=
io-card-probed RESULT=3Dfail>   =


  * baseline.bootrr.wm8731-driver-present: https://kernelci.org/test/case/i=
d/65c164a9050f458b6200a060
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T22:43:32.276496  /lava-546675/1/../bin/lava-test-case
    2024-02-05T22:43:32.324255  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Deep=
rom-probed RESULT=3Dblocked>
    2024-02-05T22:43:32.362799  sh: /sys/bus/spi/drivers/wm8731: unknown op=
erand
    2024-02-05T22:43:33.377962  /lava-546675/1/../bin/lava-test-case
    2024-02-05T22:43:33.418818  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dwm8=
731-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.at24-driver-present: https://kernelci.org/test/case/id/=
65c164a9050f458b6200a061
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T22:43:31.174861  /lava-546675/1/../bin/lava-test-case
    2024-02-05T22:43:31.215462  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dat2=
4-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65c1669e3968248ed600a049

  Results:     48 PASS, 6 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm/multi_v5_defconfig/gcc-10/lab-broon=
ie/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm/multi_v5_defconfig/gcc-10/lab-broon=
ie/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.gpio-keys-probed: https://kernelci.org/test/case/id/65c=
1669e3968248ed600a052
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T22:51:56.346515  /lava-546680/1/../bin/lava-test-case
    2024-02-05T22:51:56.393033  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dgpi=
o-keys-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig         | 7          =


  Details:     https://kernelci.org/test/plan/id/65c1679e1b8657b6b900a060

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.hdmi-audio: https://kernelci.org/test/case/id/65c1679f1=
b8657b6b900a067
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T22:56:23.880694  /lava-546694/1/../bin/lava-test-case
    2024-02-05T22:56:23.917938  <8>[   47.968039] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/id/65=
c1679f1b8657b6b900a068
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T22:56:22.815318  /lava-546694/1/../bin/lava-test-case
    2024-02-05T22:56:22.857989  <8>[   46.905832] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-codec-driver-present: https://kernelci.org/test/ca=
se/id/65c1679f1b8657b6b900a06a
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T22:56:20.641189  /lava-546694/1/../bin/lava-test-case
    2024-02-05T22:56:20.678614  <8>[   44.721369] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2024-02-05T22:56:21.701479  /lava-546694/1/../bin/lava-test-case
    2024-02-05T22:56:21.744868  /opt/bootrr/libexec/bootrr/boards/ti,am335x=
-bone-black: <8>[   45.787600] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dhdmi-co=
dec-driver-present RESULT=3Dfail>
    2024-02-05T22:56:21.745448  line 84: assert_device-present: not found   =


  * baseline.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case/id/=
65c1679f1b8657b6b900a06b
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T22:56:18.513592  /lava-546694/1/../bin/lava-test-case
    2024-02-05T22:56:18.558425  <8>[   42.599566] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2024-02-05T22:56:19.575774  /lava-546694/1/../bin/lava-test-case
    2024-02-05T22:56:19.617680  <8>[   43.665746] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline.bootrr.tda19988-driver-present: https://kernelci.org/test/case=
/id/65c1679f1b8657b6b900a06c
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T22:56:16.386118  /lava-546694/1/../bin/lava-test-case
    2024-02-05T22:56:16.428053  <8>[   40.475588] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2024-02-05T22:56:17.451346  /lava-546694/1/../bin/lava-test-case
    2024-02-05T22:56:17.489298  <8>[   41.537994] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/65c1679f1b8657b6b900a078
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T22:56:04.447439  /lava-546694/1/../bin/lava-test-case
    2024-02-05T22:56:04.489857  <8>[   28.535335] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c1679f1b8657b6b900a08d
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T22:55:58.794703  / # #
    2024-02-05T22:55:58.897989  export SHELL=3D/bin/sh
    2024-02-05T22:55:58.898913  <8>[   22.740497] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 546694_1.5.2.4.1>
    2024-02-05T22:55:58.899561  #
    2024-02-05T22:55:59.002046  / # export SHELL=3D/bin/sh. /lava-546694/en=
vironment
    2024-02-05T22:55:59.002891  =

    2024-02-05T22:55:59.105005  / # . /lava-546694/environment/lava-546694/=
bin/lava-test-runner /lava-546694/1
    2024-02-05T22:55:59.106309  =

    2024-02-05T22:55:59.110566  / # /lava-546694/bin/lava-test-runner /lava=
-546694/1
    2024-02-05T22:55:59.197704  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig         | 7          =


  Details:     https://kernelci.org/test/plan/id/65c169fceb2646a9d900a03a

  Results:     30 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm/multi_v7_defconfig/gcc-10/lab-cip/b=
aseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm/multi_v7_defconfig/gcc-10/lab-cip/b=
aseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.hdmi-audio: https://kernelci.org/test/case/id/65c169fce=
b2646a9d900a040
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:06:16.488061  /lava-1088967/1/../bin/lava-test-case
    2024-02-05T23:06:16.524220  <8>[   41.898445] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/id/65=
c169fceb2646a9d900a041
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:06:15.426817  /lava-1088967/1/../bin/lava-test-case
    2024-02-05T23:06:15.464240  <8>[   40.837974] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-codec-driver-present: https://kernelci.org/test/ca=
se/id/65c169fceb2646a9d900a043
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:06:13.250793  /lava-1088967/1/../bin/lava-test-case
    2024-02-05T23:06:13.294495  <8>[   38.660282] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2024-02-05T23:06:14.311320  /lava-1088967/1/../bin/lava-test-case
    2024-02-05T23:06:14.358365  /opt/bootrr/libexec/bootrr/boards/ti,am335x=
-bone-black: <8>[   39.725876] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dhdmi-co=
dec-driver-present RESULT=3Dfail>
    2024-02-05T23:06:14.358636  line 84: assert_device-present: not found   =


  * baseline.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case/id/=
65c169fceb2646a9d900a044
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:06:11.122281  /lava-1088967/1/../bin/lava-test-case
    2024-02-05T23:06:11.164813  <8>[   36.536176] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2024-02-05T23:06:12.187462  /lava-1088967/1/../bin/lava-test-case
    2024-02-05T23:06:12.224988  <8>[   37.598952] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline.bootrr.tda19988-driver-present: https://kernelci.org/test/case=
/id/65c169fceb2646a9d900a045
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:06:09.000976  /lava-1088967/1/../bin/lava-test-case
    2024-02-05T23:06:09.044496  <8>[   34.410416] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2024-02-05T23:06:10.061670  /lava-1088967/1/../bin/lava-test-case
    2024-02-05T23:06:10.105049  <8>[   35.470455] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/65c169fceb2646a9d900a051
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:05:57.062135  /lava-1088967/1/../bin/lava-test-case
    2024-02-05T23:05:57.106094  <8>[   22.475464] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c169fceb2646a9d900a06a
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:05:51.322110  + set +x
    2024-02-05T23:05:51.426337  TESTCASE TEST_CASE_ID=3Demerg RESULT=3Dpass=
 UNITS=3Dlines MEASUREMENT=3D0>
    2024-02-05T23:05:51.426564  =

    2024-02-05T23:05:51.426779  <8>[   16.700434] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1088967_1.5.2.4.1>
    2024-02-05T23:05:51.527900  / # #export SHELL=3D/bin/sh
    2024-02-05T23:05:51.528405  =

    2024-02-05T23:05:51.629345  / # export SHELL=3D/bin/sh. /lava-1088967/e=
nvironment
    2024-02-05T23:05:51.629776  =

    2024-02-05T23:05:51.730743  / # . /lava-1088967/environment/lava-108896=
7/bin/lava-test-runner /lava-1088967/1
    2024-02-05T23:05:51.731423   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/65c168eb208e25705f00a087

  Results:     49 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm/omap2plus_defconfig/gcc-10/lab-broo=
nie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm/omap2plus_defconfig/gcc-10/lab-broo=
nie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/id/6=
5c168eb208e25705f00a0a3
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:01:49.087025  /lava-546713/1/../bin/lava-test-case
    2024-02-05T23:01:49.134180  <8>[   24.296999] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c168d6bb9f39877300a066

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c168d6bb9f39877300a06f
        failing since 17 days (last pass: v4.19.299-cip105-1134-gc868d5e4ad=
aa, first fail: v6.1.72-cip13-30-g79e2886a5da69)

    2024-02-05T23:01:32.806426  <8>[    7.411058] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12704889_1.4.2.3.1>

    2024-02-05T23:01:32.908344  /#

    2024-02-05T23:01:33.009170   # #export SHELL=3D/bin/sh

    2024-02-05T23:01:33.009310  =


    2024-02-05T23:01:33.109854  / # export SHELL=3D/bin/sh. /lava-12704889/=
environment

    2024-02-05T23:01:33.110001  =


    2024-02-05T23:01:33.210503  / # . /lava-12704889/environment/lava-12704=
889/bin/lava-test-runner /lava-12704889/1

    2024-02-05T23:01:33.210818  =


    2024-02-05T23:01:33.215246  / # /lava-12704889/bin/lava-test-runner /la=
va-12704889/1

    2024-02-05T23:01:33.231756  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c168c4bb9f39877300a046

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c168c4bb9f39877300a04f
        failing since 17 days (last pass: v4.19.299-cip105-1134-gc868d5e4ad=
aa, first fail: v6.1.72-cip13-30-g79e2886a5da69)

    2024-02-05T23:01:48.924447  <8>[    9.307466] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12704882_1.4.2.3.1>

    2024-02-05T23:01:49.029352  / # #

    2024-02-05T23:01:49.130000  export SHELL=3D/bin/sh

    2024-02-05T23:01:49.130179  #

    2024-02-05T23:01:49.230639  / # export SHELL=3D/bin/sh. /lava-12704882/=
environment

    2024-02-05T23:01:49.230795  =


    2024-02-05T23:01:49.331352  / # . /lava-12704882/environment/lava-12704=
882/bin/lava-test-runner /lava-12704882/1

    2024-02-05T23:01:49.331585  =


    2024-02-05T23:01:49.336846  / # /lava-12704882/bin/lava-test-runner /la=
va-12704882/1

    2024-02-05T23:01:49.354037  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65c1689c537491ada900a04c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65c1689c537491ada900a=
04d
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65c1689b31940ab0d900a05d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65c1689b31940ab0d900a=
05e
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/65c166208f763e99e700a04f

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm/imx_v6_v7_defconfig/gcc-10/lab-peng=
utronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm/imx_v6_v7_defconfig/gcc-10/lab-peng=
utronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c166208f763e99e700a057
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T22:50:00.730050  + set +x
    2024-02-05T22:50:00.837257  / # #
    2024-02-05T22:50:00.938500  export SHELL=3D/bin/sh
    2024-02-05T22:50:00.939026  [    9.198575] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2024-02-05T22:50:00.939157  [    9.201096] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1023830_1.5.2.3.1>
    2024-02-05T22:50:00.939267  #
    2024-02-05T22:50:01.039981  / # export SHELL=3D/bin/sh. /lava-1023830/e=
nvironment
    2024-02-05T22:50:01.040549  =

    2024-02-05T22:50:01.141421  / # . /lava-1023830/environment/lava-102383=
0/bin/lava-test-runner /lava-1023830/1
    2024-02-05T22:50:01.142102   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65c1674c587278d31e00a040

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm/multi_v7_defconfig/gcc-10/lab-pengu=
tronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm/multi_v7_defconfig/gcc-10/lab-pengu=
tronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c1674c587278d31e00a048
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T22:55:00.731543  + set +x
    2024-02-05T22:55:00.837023  / # #
    2024-02-05T22:55:00.938172  export SHELL=3D/bin/sh
    2024-02-05T22:55:00.938664  [    7.309460] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2024-02-05T22:55:00.938826  [    7.310798] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1023833_1.5.2.3.1>
    2024-02-05T22:55:00.938942  #
    2024-02-05T22:55:01.039866  / # export SHELL=3D/bin/sh. /lava-1023833/e=
nvironment
    2024-02-05T22:55:01.040433  =

    2024-02-05T22:55:01.141313  / # . /lava-1023833/environment/lava-102383=
3/bin/lava-test-runner /lava-1023833/1
    2024-02-05T22:55:01.142012   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                  | 11         =


  Details:     https://kernelci.org/test/plan/id/65c16bb234e7f559da00a087

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm64/defconfig/gcc-10/lab-broonie/base=
line-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm64/defconfig/gcc-10/lab-broonie/base=
line-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.led7-probed: https://kernelci.org/test/case/id/65c16bb2=
34e7f559da00a098
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:13:46.683910  /lava-546724/1/../bin/lava-test-case
    2024-02-05T23:13:46.684499  <8>[   39.937694] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled7-probed RESULT=3Dfail>   =


  * baseline.bootrr.led6-probed: https://kernelci.org/test/case/id/65c16bb2=
34e7f559da00a099
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:13:45.603207  /lava-546724/1/../bin/lava-test-case
    2024-02-05T23:13:45.624245  <8>[   38.915292] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled6-probed RESULT=3Dfail>   =


  * baseline.bootrr.led5-probed: https://kernelci.org/test/case/id/65c16bb2=
34e7f559da00a09a
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:13:44.592942  /lava-546724/1/../bin/lava-test-case
    2024-02-05T23:13:44.596211  <8>[   37.893065] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled5-probed RESULT=3Dfail>   =


  * baseline.bootrr.led4-probed: https://kernelci.org/test/case/id/65c16bb2=
34e7f559da00a09b
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:13:43.559067  /lava-546724/1/../bin/lava-test-case
    2024-02-05T23:13:43.580149  <8>[   36.870664] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled4-probed RESULT=3Dfail>   =


  * baseline.bootrr.led3-probed: https://kernelci.org/test/case/id/65c16bb2=
34e7f559da00a09c
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:13:42.548906  /lava-546724/1/../bin/lava-test-case
    2024-02-05T23:13:42.552163  <8>[   35.849141] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled3-probed RESULT=3Dfail>   =


  * baseline.bootrr.led2-probed: https://kernelci.org/test/case/id/65c16bb2=
34e7f559da00a09d
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:13:41.514864  /lava-546724/1/../bin/lava-test-case
    2024-02-05T23:13:41.535850  <8>[   34.827021] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled2-probed RESULT=3Dfail>   =


  * baseline.bootrr.led1-probed: https://kernelci.org/test/case/id/65c16bb2=
34e7f559da00a09e
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:13:40.504652  /lava-546724/1/../bin/lava-test-case
    2024-02-05T23:13:40.507905  <8>[   33.804057] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled1-probed RESULT=3Dfail>   =


  * baseline.bootrr.led0-probed: https://kernelci.org/test/case/id/65c16bb2=
34e7f559da00a09f
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:13:39.485497  /lava-546724/1/../bin/lava-test-case
    2024-02-05T23:13:39.488783  <8>[   32.781520] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled0-probed RESULT=3Dfail>   =


  * baseline.bootrr.iommu1-probed: https://kernelci.org/test/case/id/65c16b=
b234e7f559da00a0b2
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:13:38.186600  /lava-546724/1/../bin/lava-test-case
    2024-02-05T23:13:38.187199  <8>[   31.436087] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Diommu1-probed RESULT=3Dfail>
    2024-02-05T23:13:38.187619  /lava-546724/1/../bin/lava-test-case
    2024-02-05T23:13:38.187990  <8>[   31.455543] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Diommu2-probed RESULT=3Dpass>
    2024-02-05T23:13:38.188339  /lava-546724/1/../bin/lava-test-case   =


  * baseline.bootrr.1c050000_mmc-probed: https://kernelci.org/test/case/id/=
65c16bb234e7f559da00a0bf
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:13:36.894143  /lava-546724/1/../bin/lava-test-case
    2024-02-05T23:13:36.894727  <8>[   30.188182] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3D1c050000.mmc-probed RESULT=3Dfail>   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c16bb234e7f559da00a0c7
        new failure (last pass: v5.10.209-cip44-rebase)

    2024-02-05T23:13:34.340933  / # #
    2024-02-05T23:13:34.443833  export SHELL=3D/bin/sh
    2024-02-05T23:13:34.444562  #
    2024-02-05T23:13:34.546509  / # export SHELL=3D/bin/sh. /lava-546724/en=
vironment
    2024-02-05T23:13:34.547232  =

    2024-02-05T23:13:34.649304  / # . /lava-546724/environment/lava-546724/=
bin/lava-test-runner /lava-546724/1
    2024-02-05T23:13:34.650667  =

    2024-02-05T23:13:34.665145  / # /lava-546724/bin/lava-test-runner /lava=
-546724/1
    2024-02-05T23:13:34.724949  + export 'TESTRUN_ID=3D1_bootrr'
    2024-02-05T23:13:34.725458  + cd /lava-546724/1/tests/1_bootrr =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
kontron-kbox-a-230-ls        | arm64  | lab-kontron     | gcc-10   | defcon=
fig                  | 3          =


  Details:     https://kernelci.org/test/plan/id/65c16b109620510bc100a03a

  Results:     89 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm64/defconfig/gcc-10/lab-kontron/base=
line-kontron-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm64/defconfig/gcc-10/lab-kontron/base=
line-kontron-kbox-a-230-ls.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rcpm-driver-present: https://kernelci.org/test/case/id/=
65c16b109620510bc100a07e
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:10:45.339144  /lava-426317/1/../bin/lava-test-case
    2024-02-05T23:10:45.342340  <8>[   15.310637] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.ftm-alarm-driver-present: https://kernelci.org/test/cas=
e/id/65c16b109620510bc100a07f
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:10:46.345528  /lava-426317/1/../bin/lava-test-case
    2024-02-05T23:10:46.348891  <8>[   16.321096] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2024-02-05T23:10:47.340185  /lava-426317/1/../bin/lava-test-case
    2024-02-05T23:10:47.363586  <8>[   17.332740] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dftm-alarm-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.layerscape-sfp-driver-present: https://kernelci.org/tes=
t/case/id/65c16b109620510bc100a096
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:10:49.640879  /lava-426317/1/../bin/lava-test-case
    2024-02-05T23:10:49.663926  <8>[   19.634315] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig                  | 2          =


  Details:     https://kernelci.org/test/plan/id/65c16b7734e7f559da00a039

  Results:     50 PASS, 4 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm64/defconfig/gcc-10/lab-broonie/base=
line-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm64/defconfig/gcc-10/lab-broonie/base=
line-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/65c16b773=
4e7f559da00a040
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:11:40.603595  /lava-546745/1/../bin/lava-test-case
    2024-02-05T23:11:40.616024  <8>[   19.166012] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>
    2024-02-05T23:11:40.616492  + set +x   =


  * baseline.bootrr.cpufreq-probed: https://kernelci.org/test/case/id/65c16=
b7734e7f559da00a069
        new failure (last pass: v5.10.209-cip44-rebase)

    2024-02-05T23:11:38.994673  /lava-546745/1/../bin/lava-test-case
    2024-02-05T23:11:39.008016  <8>[   17.557515] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpufreq-probed RESULT=3Dfail>
    2024-02-05T23:11:39.008487  /lava-546745/1/../bin/lava-test-case   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig+arm64-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/65c16ca3a7c82646ea00a03b

  Results:     49 PASS, 4 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-broonie/baseline-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-broonie/baseline-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/65c16ca3a=
7c82646ea00a041
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:16:36.675720  /lava-546767/1/../bin/lava-test-case
    2024-02-05T23:16:36.688114  <8>[   19.127815] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>
    2024-02-05T23:16:36.688467  + set +x   =


  * baseline.bootrr.cpufreq-probed: https://kernelci.org/test/case/id/65c16=
ca3a7c82646ea00a065
        new failure (last pass: v5.10.209-cip44-rebase)

    2024-02-05T23:16:34.052137  <8>[   16.493086] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dscpi-cpufreq-driver-present RESULT=3Dpass>
    2024-02-05T23:16:35.060544  /lava-546767/1/../bin/lava-test-case
    2024-02-05T23:16:35.073662  <8>[   17.512806] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpufreq-probed RESULT=3Dfail>
    2024-02-05T23:16:35.073927  /lava-546767/1/../bin/lava-test-case   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
qemu_mips-malta              | mips   | lab-broonie     | gcc-10   | malta_=
defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/65c167941b8657b6b900a05a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/mips/malta_defconfig/gcc-10/lab-broonie=
/baseline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/mips/malta_defconfig/gcc-10/lab-broonie=
/baseline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65c167941b8657b6b900a=
05b
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
qemu_mips-malta              | mips   | lab-collabora   | gcc-10   | malta_=
defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/65c16748587278d31e00a03a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/mips/malta_defconfig/gcc-10/lab-collabo=
ra/baseline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/mips/malta_defconfig/gcc-10/lab-collabo=
ra/baseline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65c16748587278d31e00a=
03b
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65c1692039bfbada1200a03a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm/shmobile_defconfig/gcc-10/lab-cip/b=
aseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm/shmobile_defconfig/gcc-10/lab-cip/b=
aseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65c1692039bfbada1200a=
03b
        new failure (last pass: v5.10.209-cip44-rebase) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig         | 3          =


  Details:     https://kernelci.org/test/plan/id/65c16770c35faec56b00a052

  Results:     61 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm/multi_v7_defconfig/gcc-10/lab-colla=
bora/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm/multi_v7_defconfig/gcc-10/lab-colla=
bora/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-iodomain-grf-probed: https://kernelci.org/test=
/case/id/65c16770c35faec56b00a06a
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:03:12.796886  <8>[   20.783473] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-iodomain-driver-present RESULT=3Dpass>

    2024-02-05T23:03:13.786983  /lava-12704826/1/../bin/lava-test-case

    2024-02-05T23:03:13.793257  /lava-12704826/1/../bin/lava-test-case
   =


  * baseline.bootrr.dwmmc_rockchip-sdio0-probed: https://kernelci.org/test/=
case/id/65c16770c35faec56b00a080
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:03:11.501301  <8>[   19.496068] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwmmc_rockchip-sdmmc-probed RESULT=3Dfail>

    2024-02-05T23:03:12.499356  /lava-12704826/1/../bin/lava-test-case
   =


  * baseline.bootrr.dwmmc_rockchip-sdmmc-probed: https://kernelci.org/test/=
case/id/65c16770c35faec56b00a081
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:03:10.508524  Busy<8>[   18.486808] <LAVA_SIGNAL_TESTCASE=
 TEST_CASE_ID=3Ddwmmc_rockchip-driver-present RESULT=3Dpass>

    2024-02-05T23:03:10.514079  Box v1.31.1 (2023-06-23 08:10:20 UTC) multi=
-call binary.

    2024-02-05T23:03:10.514300  =


    2024-02-05T23:03:10.518656  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2024-02-05T23:03:10.518910  =


    2024-02-05T23:03:10.524033  Print numbers from FIRST to LAST, in steps =
of INC.

    2024-02-05T23:03:10.526442  FIRST, INC default to 1.

    2024-02-05T23:03:10.526663  =


    2024-02-05T23:03:10.530181  	-w	Pad to last with leading zeros

    2024-02-05T23:03:10.532584  	-s SEP	String separator
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/65c16c6315e7d5028e00a047

  Results:     83 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/65c16c6315e7d5028e00a050
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:19:25.043837  /lava-12704933/1/../bin/lava-test-case

    2024-02-05T23:19:25.056938  <8>[   33.139046] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/65c16c6315e7d5028e00a051
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:19:24.023480  /lava-12704933/1/../bin/lava-test-case

    2024-02-05T23:19:24.044694  <8>[   32.118869] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                  | 5          =


  Details:     https://kernelci.org/test/plan/id/65c16b279620510bc100a0a9

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm64/defconfig/gcc-10/lab-broonie/base=
line-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm64/defconfig/gcc-10/lab-broonie/base=
line-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/65c16b279=
620510bc100a0c3
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:11:18.593153  /lava-546737/1/../bin/lava-test-case
    2024-02-05T23:11:18.607404  <8>[   24.892372] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Di2s-probed RESULT=3Dblocked>
    2024-02-05T23:11:19.614667  /lava-546737/1/../bin/lava-test-case
    2024-02-05T23:11:19.630421  <8>[   25.913819] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>
    2024-02-05T23:11:19.630822  /lava-546737/1/../bin/lava-test-case   =


  * baseline.bootrr.sun4i-i2s-driver-present: https://kernelci.org/test/cas=
e/id/65c16b279620510bc100a0c4
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:11:16.543078  /lava-546737/1/../bin/lava-test-case
    2024-02-05T23:11:16.556837  <8>[   22.842420] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcodec-digital-probed RESULT=3Dblocked>
    2024-02-05T23:11:17.564735  /lava-546737/1/../bin/lava-test-case
    2024-02-05T23:11:17.576495  <8>[   23.863515] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun4i-i2s-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sun8i-codec-driver-present: https://kernelci.org/test/c=
ase/id/65c16b279620510bc100a0c5
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:11:14.493193  /lava-546737/1/../bin/lava-test-case
    2024-02-05T23:11:14.504216  <8>[   20.792233] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcodec-analog-probed RESULT=3Dblocked>
    2024-02-05T23:11:15.522796  /lava-546737/1/../bin/lava-test-case
    2024-02-05T23:11:15.536066  <8>[   21.821490] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8i-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sun50i-codec-analog-driver-present: https://kernelci.or=
g/test/case/id/65c16b279620510bc100a0c6
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:11:13.464531  /lava-546737/1/../bin/lava-test-case
    2024-02-05T23:11:13.478000  <8>[   19.764284] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun50i-codec-analog-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c16b279620510bc100a0d9
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:11:10.607633  <8>[   16.783831] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 546737_1.5.2#
    2024-02-05T23:11:10.608583  .4.1>
    2024-02-05T23:11:10.710648  / # #export SHELL=3D/bin/sh
    2024-02-05T23:11:10.711316  =

    2024-02-05T23:11:10.812974  / # export SHELL=3D/bin/sh. /lava-546737/en=
vironment
    2024-02-05T23:11:10.813649  =

    2024-02-05T23:11:10.915555  / # . /lava-546737/environment/lava-546737/=
bin/lava-test-runner /lava-546737/1
    2024-02-05T23:11:10.916498  =

    2024-02-05T23:11:10.920035  / # /lava-546737/bin/lava-test-runner /lava=
-546737/1
    2024-02-05T23:11:10.969254  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65c16b309620510bc100a0e2

  Results:     40 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm64/defconfig/gcc-10/lab-broonie/base=
line-sun50i-h5-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm64/defconfig/gcc-10/lab-broonie/base=
line-sun50i-h5-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.sun8-codec-analog-driver-present: https://kernelci.org/=
test/case/id/65c16b309620510bc100a0f1
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:11:37.437218  /lava-546732/1/../bin/lava-test-case
    2024-02-05T23:11:37.455334  <8>[   19.412429] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8-codec-analog-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65c16c2c15e7d5028e00a03d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm64/defconfig/gcc-10/lab-cip/baseline=
-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm64/defconfig/gcc-10/lab-cip/baseline=
-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65c16c2c15e7d5028e00a=
03e
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65c16dd06cc26e353f00a039

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65c16dd06cc26e353f00a=
03a
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase) =

 =20

