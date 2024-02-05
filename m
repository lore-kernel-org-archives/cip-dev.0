Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81534C48260
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 23:54:51 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
 by mx.groups.io with SMTP id smtpd.web11.10100.1707177286375165492
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Feb 2024 15:54:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=mm2M67nf;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.176, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e04d24bd39so926349b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Feb 2024 15:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707177285; x=1707782085; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZdFk/VZMADHY+IERi+VVMwGVI6lImUhVBfydee4Flys=;
        b=mm2M67nf3dZD8z5fxEZw7rB55JCHg/4+oow8/ZlkLVHonkZk8VBMBY81fnwqQ7lPEU
         j/9L70v+CKijT9uZ7gmxgdmop5ln+dYTs5wmodOeDMxLjl/gYXz2c78l9fM126XtBtpf
         q0bsp1Z3R4S68soQMv49feJIGTScV9XrnS7Yftz/gDN9WbXjhcimVvfqziSQQBihuwQ+
         uTbTDNt1RtfW4nZ6mE8hsQ+IX/9c5F1NSA0H48hsenrS1bUNMIiM2I2kwN5Wy83zicBk
         s+FqquQ4UT0849P9JJzxpSyNyqFD1a6uGOIf2fAfgDMy9pSkjTZ5dMmhWfoHtGUO5kJZ
         kxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707177285; x=1707782085;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZdFk/VZMADHY+IERi+VVMwGVI6lImUhVBfydee4Flys=;
        b=KRfd3lWFinMFaCLL2Ah3VQU+DvZFIWh9SRdBmAaSV6DFjMTTFTE69AxQF+6f/Qwv1/
         ueN2yVPco9FM6OB/SI2GwGSSEi85o23Ntf1yJZoF3mRESZVFrf3besaXO2i53UfesEXg
         YaaV1YTjOjdH7vsghsKG4KO61ZSilY/wD3XnrE9CV3rtDSiQ9r7qDpyCuevvmNDVashG
         kyRu6lXBA0gupNfI7KI6/68N8MxvpSUXgOVfVn78j84X7869H/2AtLKFAoa05NR5ga7o
         RsUrARKXoUQic3P1YZvPY1FshPjwHMlPTQK4eslZ9rcJN6Ej5+5dWSGKUvfxI25f/ilF
         Wmrw==
X-Gm-Message-State: AOJu0YymxM5hxnJFLzLHSOuU3UPX1gr1ShmdsXBH34YK+IKy70BfT/zc
	VNGTIjj6fuGRescEFa3Wz3Bx87GKLoyKepvrdLqm0Ca+miXOUjrbjE6fEuTUP7AyPoQ64x132K2
	V
X-Google-Smtp-Source: AGHT+IEbWRwqNadT8Flc5Vgr9wGt5AEc426m5OXjOvnKOhD1ATIg/RaWWkglEO1P6TRatm/u67lU4Q==
X-Received: by 2002:aa7:8758:0:b0:6e0:25d7:debc with SMTP id g24-20020aa78758000000b006e025d7debcmr691353pfo.24.1707177284654;
        Mon, 05 Feb 2024 15:54:44 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id s14-20020a62e70e000000b006dde1337d31sm447643pfh.186.2024.02.05.15.54.43
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 15:54:44 -0800 (PST)
Message-ID: <65c17544.620a0220.a917e.2b5e@mx.google.com>
Date: Mon, 05 Feb 2024 15:54:44 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v5.10.209-cip44-526-gbbb905888ca85
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 51 runs,
 52 regressions (v5.10.209-cip44-526-gbbb905888ca85)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Feb 2024 23:54:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14760

cip-gitlab/ci/pavel/linux-test baseline-nfs: 51 runs, 52 regressions (v5.10=
.209-cip44-526-gbbb905888ca85)

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

beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig         | 7          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig         | 7          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig        | 2          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

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

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook | 1          =

mt8173-elm-hana              | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                  | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook | 2          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 5          =

sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.209-cip44-526-gbbb905888ca85/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.209-cip44-526-gbbb905888ca85
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      bbb905888ca85ace83da9e4113b4957345c47d70 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
acer-cbv514-1h-34uz-brya     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c169d37c5ae4b3cc00a06a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-nfs-acer-cbv514-1h-34uz-brya.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-nfs-acer-cbv514-1h-34uz-brya.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c169d37c5ae4b3c=
c00a06b
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
acer-chromebox-cxi5-brask    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c169cd5868a7521600a03e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-nfs-acer-chromebox-cxi5-brask.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-nfs-acer-chromebox-cxi5-brask.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c169cd5868a7521=
600a03f
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | at91_dt_=
defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/65c166118f763e99e700a049

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm/at91_dt_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm/at91_dt_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armel/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c166118f763e99e=
700a04a
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig         | 7          =


  Details:     https://kernelci.org/test/plan/id/65c167de6165df905f00a041

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.hdmi-audio: https://kernelci.org/test/case/id/65c16=
7de6165df905f00a048
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T22:57:15.868363  /lava-546697/1/../bin/lava-test-case
    2024-02-05T22:57:15.927106  <8>[   80.323048] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/i=
d/65c167de6165df905f00a049
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T22:57:14.763028  /lava-546697/1/../bin/lava-test-case
    2024-02-05T22:57:14.817834  <8>[   79.213657] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-codec-driver-present: https://kernelci.org/tes=
t/case/id/65c167de6165df905f00a04b
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T22:57:12.467427  /lava-546697/1/../bin/lava-test-case
    2024-02-05T22:57:12.527834  <8>[   76.920184] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2024-02-05T22:57:13.567178  /lava-546697/1/../bin/lava-test-case
    2024-02-05T22:57:13.636031  /opt/bootrr/libexec/bootrr/boards/ti,am335x=
-bone-black: 84: <8>[   78.019473] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dhdm=
i-codec-driver-present RESULT=3Dfail>
    2024-02-05T22:57:13.636371  assert_device-present: not found   =


  * baseline-nfs.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case=
/id/65c167de6165df905f00a04c
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T22:57:10.257957  /lava-546697/1/../bin/lava-test-case
    2024-02-05T22:57:10.317906  <8>[   74.710952] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2024-02-05T22:57:11.364674  /lava-546697/1/../bin/lava-test-case
    2024-02-05T22:57:11.427999  <8>[   75.814871] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tda19988-driver-present: https://kernelci.org/test/=
case/id/65c167de6165df905f00a04d
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T22:57:08.045551  /lava-546697/1/../bin/lava-test-case
    2024-02-05T22:57:08.107827  <8>[   72.495319] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2024-02-05T22:57:09.145155  /lava-546697/1/../bin/lava-test-case
    2024-02-05T22:57:09.209062  <8>[   73.603987] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/65c167de6165df905f00a059
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T22:56:55.405483  /lava-546697/1/../bin/lava-test-case
    2024-02-05T22:56:55.470197  <8>[   59.859068] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65c167de6165df905f00a071
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T22:56:47.956151  <8>[   52.342277] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 546697_1.6.2.4.1>
    2024-02-05T22:56:48.068303  / # #
    2024-02-05T22:56:48.170413  export SHELL=3D/bin/sh
    2024-02-05T22:56:48.171041  #
    2024-02-05T22:56:48.272771  / # export SHELL=3D/bin/sh. /lava-546697/en=
vironment
    2024-02-05T22:56:48.273409  =

    2024-02-05T22:56:48.374979  / # . /lava-546697/environment/lava-546697/=
bin/lava-test-runner /lava-546697/1
    2024-02-05T22:56:48.375894  =

    2024-02-05T22:56:48.380340  / # /lava-546697/bin/lava-test-runner /lava=
-546697/1
    2024-02-05T22:56:48.580943  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig         | 7          =


  Details:     https://kernelci.org/test/plan/id/65c16af7fc3edee0b000a093

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm/multi_v7_defconfig/gcc-10/lab-cip/b=
aseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm/multi_v7_defconfig/gcc-10/lab-cip/b=
aseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.hdmi-audio: https://kernelci.org/test/case/id/65c16=
af7fc3edee0b000a09a
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:10:21.283470  /lava-1088969/1/../bin/lava-test-case
    2024-02-05T23:10:21.458662  <8>[   83.651615] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/i=
d/65c16af7fc3edee0b000a09b
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:10:20.080285  /lava-1088969/1/../bin/lava-test-case
    2024-02-05T23:10:20.232368  <8>[   82.421069] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-codec-driver-present: https://kernelci.org/tes=
t/case/id/65c16af7fc3edee0b000a09d
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:10:17.435387  /lava-1088969/1/../bin/lava-test-case
    2024-02-05T23:10:17.581115  <8>[   79.767259] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2024-02-05T23:10:18.631042  /lava-1088969/1/../bin/lava-test-case
    2024-02-05T23:10:18.811682  <8>[   81.000942] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case=
/id/65c16af7fc3edee0b000a09e
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:10:14.968173  /lava-1088969/1/../bin/lava-test-case
    2024-02-05T23:10:15.131720  <8>[   77.322051] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2024-02-05T23:10:16.184992  /lava-1088969/1/../bin/lava-test-case
    2024-02-05T23:10:16.379229  <8>[   78.567467] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tda19988-driver-present: https://kernelci.org/test/=
case/id/65c16af7fc3edee0b000a09f
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:10:12.552498  /lava-1088969/1/../bin/lava-test-case
    2024-02-05T23:10:12.718092  <8>[   74.914199] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2024-02-05T23:10:13.775472  /lava-1088969/1/../bin/lava-test-case
    2024-02-05T23:10:13.910824  <8>[   76.103019] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/65c16af7fc3edee0b000a0ab
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:09:57.777439  /lava-1088969/1/../bin/lava-test-case
    2024-02-05T23:09:57.981425  <8>[   60.168806] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65c16af7fc3edee0b000a0c3
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:09:46.286538  <8>[   48.471959] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1088969_1.6.2.4.1>
    2024-02-05T23:09:46.470574  #
    2024-02-05T23:09:46.573003  / # #export SHELL=3D/bin/sh
    2024-02-05T23:09:46.573694  =

    2024-02-05T23:09:46.675041  / # export SHELL=3D/bin/sh. /lava-1088969/e=
nvironment
    2024-02-05T23:09:46.675743  =

    2024-02-05T23:09:46.777052  / # . /lava-1088969/environment/lava-108896=
9/bin/lava-test-runner /lava-1088969/1
    2024-02-05T23:09:46.778183  =

    2024-02-05T23:09:46.784745  / # /lava-1088969/bin/lava-test-runner /lav=
a-1088969/1
    2024-02-05T23:09:47.152185  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig        | 2          =


  Details:     https://kernelci.org/test/plan/id/65c168d52e8b77b8ee00a0d9

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm/omap2plus_defconfig/gcc-10/lab-broo=
nie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm/omap2plus_defconfig/gcc-10/lab-broo=
nie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/=
id/65c168d52e8b77b8ee00a0f8
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:01:25.408128  /lava-546712/1/../bin/lava-test-case
    2024-02-05T23:01:25.494365  <8>[   53.319232] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65c168d52e8b77b8ee00a110
        failing since 17 days (last pass: v4.19.299-cip105-1134-gc868d5e4ad=
aa, first fail: v6.1.72-cip13-30-g79e2886a5da69)

    2024-02-05T23:01:18.812011  <8>[   46.633959] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 546712_1.6.2.4.1>
    2024-02-05T23:01:18.934351  / # #
    2024-02-05T23:01:19.036583  export SHELL=3D/bin/sh
    2024-02-05T23:01:19.037082  #
    2024-02-05T23:01:19.138608  / # export SHELL=3D/bin/sh. /lava-546712/en=
vironment
    2024-02-05T23:01:19.139151  =

    2024-02-05T23:01:19.240757  / # . /lava-546712/environment/lava-546712/=
bin/lava-test-runner /lava-546712/1
    2024-02-05T23:01:19.241602  =

    2024-02-05T23:01:19.246392  / # /lava-546712/bin/lava-test-runner /lava=
-546712/1
    2024-02-05T23:01:19.536163  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c168ddacb10d8ed100a066

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65c168ddacb10d8ed100a06f
        failing since 17 days (last pass: v4.19.299-cip105-1134-gc868d5e4ad=
aa, first fail: v6.1.72-cip13-30-g79e2886a5da69)

    2024-02-05T23:02:06.599726  + set +x

    2024-02-05T23:02:06.606090  <8>[   15.248441] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12704877_1.5.2.3.1>

    2024-02-05T23:02:06.711066  / # #

    2024-02-05T23:02:06.811715  export SHELL=3D/bin/sh

    2024-02-05T23:02:06.811892  #

    2024-02-05T23:02:06.912394  / # export SHELL=3D/bin/sh. /lava-12704877/=
environment

    2024-02-05T23:02:06.912563  =


    2024-02-05T23:02:07.013113  / # . /lava-12704877/environment/lava-12704=
877/bin/lava-test-runner /lava-12704877/1

    2024-02-05T23:02:07.013403  =


    2024-02-05T23:02:07.018706  / # /lava-12704877/bin/lava-test-runner /la=
va-12704877/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c168e1f43b262c5300a065

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65c168e1f43b262c5300a06e
        failing since 17 days (last pass: v4.19.299-cip105-1134-gc868d5e4ad=
aa, first fail: v6.1.72-cip13-30-g79e2886a5da69)

    2024-02-05T23:01:29.886891  + set +x

    2024-02-05T23:01:29.894108  <8>[   14.703115] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12704857_1.5.2.3.1>

    2024-02-05T23:01:29.995703  /#

    2024-02-05T23:01:30.096453   # #export SHELL=3D/bin/sh

    2024-02-05T23:01:30.096634  =


    2024-02-05T23:01:30.197103  / # export SHELL=3D/bin/sh. /lava-12704857/=
environment

    2024-02-05T23:01:30.197287  =


    2024-02-05T23:01:30.297764  / # . /lava-12704857/environment/lava-12704=
857/bin/lava-test-runner /lava-12704857/1

    2024-02-05T23:01:30.298053  =


    2024-02-05T23:01:30.302804  / # /lava-12704857/bin/lava-test-runner /la=
va-12704857/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
imx6dl-udoo                  | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65c16b4583a496431000a076

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c16b4583a496431=
000a077
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65c16b449620510bc100a11d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c16b449620510bc=
100a11e
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 10         =


  Details:     https://kernelci.org/test/plan/id/65c16cde105e27692b00a048

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm64/defconfig/gcc-10/lab-broonie/base=
line-nfs-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm64/defconfig/gcc-10/lab-broonie/base=
line-nfs-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.led7-probed: https://kernelci.org/test/case/id/65c1=
6cdf105e27692b00a059
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:18:34.555677  /lava-546741/1/../bin/lava-test-case
    2024-02-05T23:18:34.608373  <8>[   56.883730] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled7-probed RESULT=3Dfail>
    2024-02-05T23:18:34.608674  /lava-546741/1/../bin/lava-test-case   =


  * baseline-nfs.bootrr.led6-probed: https://kernelci.org/test/case/id/65c1=
6cdf105e27692b00a05a
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:18:33.487713  /lava-546741/1/../bin/lava-test-case
    2024-02-05T23:18:33.532781  <8>[   55.808127] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled6-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led5-probed: https://kernelci.org/test/case/id/65c1=
6cdf105e27692b00a05b
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:18:32.419879  /lava-546741/1/../bin/lava-test-case
    2024-02-05T23:18:32.464500  <8>[   54.739494] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled5-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led4-probed: https://kernelci.org/test/case/id/65c1=
6cdf105e27692b00a05c
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:18:31.355863  /lava-546741/1/../bin/lava-test-case
    2024-02-05T23:18:31.396814  <8>[   53.670367] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled4-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led3-probed: https://kernelci.org/test/case/id/65c1=
6cdf105e27692b00a05d
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:18:30.260029  /lava-546741/1/../bin/lava-test-case
    2024-02-05T23:18:30.317078  <8>[   52.591937] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled3-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led2-probed: https://kernelci.org/test/case/id/65c1=
6cdf105e27692b00a05e
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:18:29.184221  /lava-546741/1/../bin/lava-test-case
    2024-02-05T23:18:29.236883  <8>[   51.510160] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled2-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led1-probed: https://kernelci.org/test/case/id/65c1=
6cdf105e27692b00a05f
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:18:28.108394  /lava-546741/1/../bin/lava-test-case
    2024-02-05T23:18:28.161315  <8>[   50.435972] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled1-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led0-probed: https://kernelci.org/test/case/id/65c1=
6cdf105e27692b00a060
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:18:27.032502  /lava-546741/1/../bin/lava-test-case
    2024-02-05T23:18:27.085367  <8>[   49.359772] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled0-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.iommu1-probed: https://kernelci.org/test/case/id/65=
c16cdf105e27692b00a073
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:18:24.911475  /lava-546741/1/../bin/lava-test-case
    2024-02-05T23:18:24.952550  <8>[   47.225641] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Diommu1-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.1c050000_mmc-probed: https://kernelci.org/test/case=
/id/65c16cdf105e27692b00a080
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:18:22.963671  /lava-546741/1/../bin/lava-test-case
    2024-02-05T23:18:23.011603  <8>[   45.286781] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3D1c050000.mmc-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
kontron-kbox-a-230-ls        | arm64  | lab-kontron   | gcc-10   | defconfi=
g                  | 3          =


  Details:     https://kernelci.org/test/plan/id/65c16b7437c5eed67f00a053

  Results:     89 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm64/defconfig/gcc-10/lab-kontron/base=
line-nfs-kontron-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm64/defconfig/gcc-10/lab-kontron/base=
line-nfs-kontron-kbox-a-230-ls.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rcpm-driver-present: https://kernelci.org/test/case=
/id/65c16b7437c5eed67f00a097
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:12:36.632649  /lava-426319/1/../bin/lava-test-case
    2024-02-05T23:12:36.635692  <8>[   19.343665] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.ftm-alarm-driver-present: https://kernelci.org/test=
/case/id/65c16b7437c5eed67f00a098
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:12:37.641507  /lava-426319/1/../bin/lava-test-case
    2024-02-05T23:12:37.668438  <8>[   20.376123] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2024-02-05T23:12:38.674311  /lava-426319/1/../bin/lava-test-case
    2024-02-05T23:12:38.696372  <8>[   21.403793] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dftm-alarm-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.layerscape-sfp-driver-present: https://kernelci.org=
/test/case/id/65c16b7437c5eed67f00a0af
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:12:41.438544  /lava-426319/1/../bin/lava-test-case
    2024-02-05T23:12:41.464554  <8>[   24.171442] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
kontron-sl28-var3-ads2       | arm64  | lab-kontron   | gcc-10   | defconfi=
g                  | 3          =


  Details:     https://kernelci.org/test/plan/id/65c16bd84307f71d9200a080

  Results:     97 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm64/defconfig/gcc-10/lab-kontron/base=
line-nfs-kontron-sl28-var3-ads2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm64/defconfig/gcc-10/lab-kontron/base=
line-nfs-kontron-sl28-var3-ads2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rcpm-driver-present: https://kernelci.org/test/case=
/id/65c16bd84307f71d9200a0cb
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T23:13:17.283119  /lava-426318/1/../bin/lava-test-case
    2024-02-05T23:13:17.310005  <8>[   16.260418] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.ftm-alarm-driver-present: https://kernelci.org/test=
/case/id/65c16bd84307f71d9200a0cc
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T23:13:18.316522  /lava-426318/1/../bin/lava-test-case
    2024-02-05T23:13:18.346278  <8>[   17.294348] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2024-02-05T23:13:19.369784  /lava-426318/1/../bin/lava-test-case   =


  * baseline-nfs.bootrr.layerscape-sfp-driver-present: https://kernelci.org=
/test/case/id/65c16bd84307f71d9200a0e1
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908)

    2024-02-05T23:13:22.066819  /lava-426318/1/../bin/lava-test-case
    2024-02-05T23:13:22.088811  <8>[   21.038318] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 2          =


  Details:     https://kernelci.org/test/plan/id/65c16b5f56c7cd76aa00a04e

  Results:     50 PASS, 4 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm64/defconfig/gcc-10/lab-broonie/base=
line-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm64/defconfig/gcc-10/lab-broonie/base=
line-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.sound-card: https://kernelci.org/test/case/id/65c16=
b5f56c7cd76aa00a055
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:12:07.089920  /lava-546726/1/../bin/lava-test-case
    2024-02-05T23:12:07.137184  <8>[   38.975198] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>
    2024-02-05T23:12:07.137435  + set +x   =


  * baseline-nfs.bootrr.cpufreq-probed: https://kernelci.org/test/case/id/6=
5c16b5f56c7cd76aa00a07d
        new failure (last pass: v5.10.209-cip44-rebase)

    2024-02-05T23:12:03.167971  /lava-546726/1/../bin/lava-test-case
    2024-02-05T23:12:03.219751  <8>[   35.054255] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpufreq-probed RESULT=3Dfail>
    2024-02-05T23:12:03.220073  /lava-546726/1/../bin/lava-test-case   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65c16d741368f55f6800a054

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c16d741368f55f6=
800a055
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65c16c91fb2c3dd3e600a039

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/baseline-nfs-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/baseline-nfs-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c16c91fb2c3dd3e=
600a03a
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65c16c7041dc8d2d6300a099

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm64/defconfig/gcc-10/lab-cip/baseline=
-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm64/defconfig/gcc-10/lab-cip/baseline=
-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c16c7041dc8d2d6=
300a09a
        failing since 5 days (last pass: v4.19.299-cip105-1134-gc868d5e4ada=
a, first fail: v6.1.72-cip13-32-gf60d2e8cb51c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/65c16c82a646d1613100a039

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/65c16c82a646d1613100a043
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:16:59.328425  /lava-12704954/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/65c16c82a646d1613100a044
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:16:58.234187  /lava-12704954/1/../bin/lava-test-case

    2024-02-05T23:16:58.276198  <8>[   35.643402] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 5          =


  Details:     https://kernelci.org/test/plan/id/65c16b9f4307f71d9200a039

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm64/defconfig/gcc-10/lab-broonie/base=
line-nfs-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm64/defconfig/gcc-10/lab-broonie/base=
line-nfs-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.sound-card: https://kernelci.org/test/case/id/65c16=
b9f4307f71d9200a051
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:13:24.738073  /lava-546756/1/../bin/lava-test-case
    2024-02-05T23:13:24.767853  <8>[   38.628799] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Di2s-probed RESULT=3Dblocked>
    2024-02-05T23:13:25.791064  /lava-546756/1/../bin/lava-test-case
    2024-02-05T23:13:25.829185  <8>[   39.688246] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sun4i-i2s-driver-present: https://kernelci.org/test=
/case/id/65c16b9f4307f71d9200a052
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:13:22.633577  /lava-546756/1/../bin/lava-test-case
    2024-02-05T23:13:22.664441  <8>[   36.524314] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcodec-digital-probed RESULT=3Dblocked>
    2024-02-05T23:13:23.686222  /lava-546756/1/../bin/lava-test-case
    2024-02-05T23:13:23.716628  <8>[   37.577417] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun4i-i2s-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sun8i-codec-driver-present: https://kernelci.org/te=
st/case/id/65c16b9f4307f71d9200a053
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:13:20.531345  /lava-546756/1/../bin/lava-test-case
    2024-02-05T23:13:20.563520  <8>[   34.424036] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcodec-analog-probed RESULT=3Dblocked>
    2024-02-05T23:13:21.579059  /lava-546756/1/../bin/lava-test-case
    2024-02-05T23:13:21.612933  <8>[   35.472655] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8i-codec-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sun50i-codec-analog-driver-present: https://kernelc=
i.org/test/case/id/65c16b9f4307f71d9200a054
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:13:19.474541  /lava-546756/1/../bin/lava-test-case
    2024-02-05T23:13:19.508543  <8>[   33.369821] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun50i-codec-analog-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65c16b9f4307f71d9200a067
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:13:15.767057  <8>[   29.624049] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 546756_1.6.2.4.1>
    2024-02-05T23:13:15.869679  / # #
    2024-02-05T23:13:15.971280  export SHELL=3D/bin/sh
    2024-02-05T23:13:15.971678  #
    2024-02-05T23:13:16.072814  / # export SHELL=3D/bin/sh. /lava-546756/en=
vironment
    2024-02-05T23:13:16.073228  =

    2024-02-05T23:13:16.174361  / # . /lava-546756/environment/lava-546756/=
bin/lava-test-runner /lava-546756/1
    2024-02-05T23:13:16.174871  =

    2024-02-05T23:13:16.178354  / # /lava-546756/bin/lava-test-runner /lava=
-546756/1
    2024-02-05T23:13:16.293044  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65c16b4283a496431000a045

  Results:     40 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm64/defconfig/gcc-10/lab-broonie/base=
line-nfs-sun50i-h5-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm64/defconfig/gcc-10/lab-broonie/base=
line-nfs-sun50i-h5-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.sun8-codec-analog-driver-present: https://kernelci.=
org/test/case/id/65c16b4283a496431000a054
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-05T23:11:50.493755  /lava-546734/1/../bin/lava-test-case
    2024-02-05T23:11:50.542682  <8>[   37.354349] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8-codec-analog-driver-present RESULT=3Dfail>   =

 =20

