Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AF4C46CA0
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 12:57:56 +0000 (UTC)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
 by mx.groups.io with SMTP id smtpd.web11.82899.1701953874447764561
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 07 Dec 2023 04:57:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=K2GrSRJg;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.167.179, mailfrom: bot@kernelci.org)
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3b8b8372e30so583083b6e.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 07 Dec 2023 04:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701953873; x=1702558673; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=27qKxuUoRc7udVaLyWF517MvlZ/TzNz+nTBtw/ie6lA=;
        b=K2GrSRJgMLV6q1xipK9Fhr5olVcj+mcXT37nWlElnhritM7nSTixP7PWVJIUHjjmI3
         0uJbCJ9Kip4hFmTMVpqFHC6VaSBqZokCB88rmLNEQv6h5bUe5sEqYbpThp7xC8TpO32p
         GZ2bJaVCH1cZvk1TF7LG8OflFlSWLb2fCLYMKB8L78DmZEWR4cqronDTuRPlJd7tG3Hd
         Z0Kudfb3t6/0MzXrP5j3N073B94yDzyq4DCd/J7PRR8HAlWLmg5YDpGf3XyT0WNEQEwr
         VYgF3VnndtuEH7TJessBncMspD+eBBf3EqM7cs4eE4qv/s0eDd1cbEO1hW7x0+Jrbu5P
         +RLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701953873; x=1702558673;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=27qKxuUoRc7udVaLyWF517MvlZ/TzNz+nTBtw/ie6lA=;
        b=Eh1+BRyepvB7WYNpiyIfT2fJFURcwfMBwjE5RoMRFVWohMn981NtC+hzD/H67Zz9zj
         7INBEFrfOMOmrWAUjbHUMd+PPygwY5XkysZH7NB4uswR0ba7ijXzsp0mJ1DozM9H5RC3
         lLD3ZWcX66pH/XY7/VKdxM2jBi4yqoKgpo00n+tFcc24DlZSQzLdWxQgerDhpnbhkcGC
         brULWZwsKst5u6sziakKfR1UGcDcY+5Is2Nn9OvaA1LHwAeYFnKmZE6ho21vOtHMGTYO
         y16Ty5bA1FHJgUFArUMIR1ErJKFvR8/Dcg0tia2h6Xa78/cpkAw9WQthaqRQMLTiJA+6
         ersA==
X-Gm-Message-State: AOJu0Yx4USbhMJAzgKjzIMrPp6T5GVpCGw/KFhBzFSOzSQ3DIxN6jzPj
	POQ082X+/fn809IOs3sqSWh0ZdGXtpDoACtuGW6LhQ==
X-Google-Smtp-Source: AGHT+IHu1bHIapx+sfQYxvejhZs9QowlAm+xW7+mM1QR38m2/TTnR+Fxk5X+gCw5xEs0UJ0LKy8d1A==
X-Received: by 2002:a05:6870:d182:b0:1fb:3840:4fcb with SMTP id a2-20020a056870d18200b001fb38404fcbmr2727820oac.49.1701953872111;
        Thu, 07 Dec 2023 04:57:52 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id v19-20020aa78513000000b006cea1e12564sm1227678pfn.81.2023.12.07.04.57.51
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 04:57:51 -0800 (PST)
Message-ID: <6571c14f.a70a0220.3b022.2b64@mx.google.com>
Date: Thu, 07 Dec 2023 04:57:51 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-28-g38e219eb6aa85
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 42 runs,
 38 regressions (v5.10.201-cip41-28-g38e219eb6aa85)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 12:57:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13832

cip-gitlab/ci/pavel/linux-test baseline-nfs: 42 runs, 38 regressions (v5.10=
.201-cip41-28-g38e219eb6aa85)

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
g                  | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.201-cip41-28-g38e219eb6aa85/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.201-cip41-28-g38e219eb6aa85
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      38e219eb6aa85cc3be6dec326b24dcf8cf438d01 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
acer-cbv514-1h-34uz-brya     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/6571b69a05bb774fe2e134b1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-nfs-acer-cbv514-1h-34uz-brya.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-nfs-acer-cbv514-1h-34uz-brya.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6571b69a05bb774fe=
2e134b2
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
acer-chromebox-cxi5-brask    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/6571b68605bb774fe2e1349f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-nfs-acer-chromebox-cxi5-brask.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-nfs-acer-chromebox-cxi5-brask.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6571b68605bb774fe=
2e134a0
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | at91_dt_=
defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6571b786617ad8721ae134d7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/arm/at91_dt_defconfig/gcc-10/lab-broonie=
/baseline-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/arm/at91_dt_defconfig/gcc-10/lab-broonie=
/baseline-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armel/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6571b786617ad8721=
ae134d8
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/6571b4a2a228c278dbe134b3

  Results:     48 PASS, 6 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/arm/multi_v5_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/arm/multi_v5_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armel/initrd.cpio.gz =



  * baseline-nfs.bootrr.gpio-keys-probed: https://kernelci.org/test/case/id=
/6571b4a2a228c278dbe134b8
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:03:39.562416  /lava-318059/1/../bin/lava-test-case
    2023-12-07T12:03:39.655957  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dgpi=
o-keys-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig         | 7          =


  Details:     https://kernelci.org/test/plan/id/6571b5fb8b1b697f28e1347d

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.hdmi-audio: https://kernelci.org/test/case/id/6571b=
5fb8b1b697f28e13480
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:09:22.391648  /lava-318086/1/../bin/lava-test-case
    2023-12-07T12:09:22.471785  <8>[   81.530564] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/i=
d/6571b5fb8b1b697f28e13481
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:09:21.241404  /lava-318086/1/../bin/lava-test-case
    2023-12-07T12:09:21.330353  <8>[   80.388708] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-codec-driver-present: https://kernelci.org/tes=
t/case/id/6571b5fb8b1b697f28e13483
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:09:18.826674  /lava-318086/1/../bin/lava-test-case
    2023-12-07T12:09:18.910414  <8>[   77.968790] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-12-07T12:09:19.972044  /lava-318086/1/../bin/lava-test-case
    2023-12-07T12:09:20.055810  <8>[   79.113474] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case=
/id/6571b5fb8b1b697f28e13484
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:09:16.532509  /lava-318086/1/../bin/lava-test-case
    2023-12-07T12:09:16.615699  <8>[   75.673455] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-12-07T12:09:17.677077  /lava-318086/1/../bin/lava-test-case
    2023-12-07T12:09:17.762980  <8>[   76.821082] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tda19988-driver-present: https://kernelci.org/test/=
case/id/6571b5fb8b1b697f28e13485
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:09:14.234903  /lava-318086/1/../bin/lava-test-case
    2023-12-07T12:09:14.324693  <8>[   73.382801] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-12-07T12:09:15.386830  /lava-318086/1/../bin/lava-test-case
    2023-12-07T12:09:15.470593  <8>[   74.527933] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/6571b5fb8b1b697f28e13491
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:09:00.903139  /lava-318086/1/../bin/lava-test-case
    2023-12-07T12:09:00.991239  <8>[   60.048357] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6571b5fb8b1b697f28e134aa
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:08:52.619282  + set +x
    2023-12-07T12:08:52.623211  <8>[   51.681785] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 318086_1.6.2.4.1>
    2023-12-07T12:08:52.744762  / # #
    2023-12-07T12:08:52.847121  export SHELL=3D/bin/sh
    2023-12-07T12:08:52.847771  #
    2023-12-07T12:08:52.949366  / # export SHELL=3D/bin/sh. /lava-318086/en=
vironment
    2023-12-07T12:08:52.950011  =

    2023-12-07T12:08:53.051903  / # . /lava-318086/environment/lava-318086/=
bin/lava-test-runner /lava-318086/1
    2023-12-07T12:08:53.052772  =

    2023-12-07T12:08:53.056892  / # /lava-318086/bin/lava-test-runner /lava=
-318086/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig         | 7          =


  Details:     https://kernelci.org/test/plan/id/6571b86cdcfa2f7ecae13481

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/arm/multi_v7_defconfig/gcc-10/lab-cip/ba=
seline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/arm/multi_v7_defconfig/gcc-10/lab-cip/ba=
seline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.hdmi-audio: https://kernelci.org/test/case/id/6571b=
86cdcfa2f7ecae13484
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:19:37.880816  /lava-1053272/1/../bin/lava-test-case
    2023-12-07T12:19:37.939830  <8>[   74.652264] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/i=
d/6571b86cdcfa2f7ecae13485
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:19:36.769860  /lava-1053272/1/../bin/lava-test-case
    2023-12-07T12:19:36.829579  <8>[   73.541416] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-codec-driver-present: https://kernelci.org/tes=
t/case/id/6571b86cdcfa2f7ecae13487
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:19:34.447721  /lava-1053272/1/../bin/lava-test-case
    2023-12-07T12:19:34.503521  <8>[   71.215326] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-12-07T12:19:35.556480  /lava-1053272/1/../bin/lava-test-case
    2023-12-07T12:19:35.619944  <8>[   72.330938] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case=
/id/6571b86cdcfa2f7ecae13488
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:19:32.222612  /lava-1053272/1/../bin/lava-test-case
    2023-12-07T12:19:32.279441  <8>[   68.991054] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-12-07T12:19:32.923138  <6>[   69.637083] platform sound: deferred =
probe pending
    2023-12-07T12:19:33.330170  /lava-1053272/1/../bin/lava-test-case
    2023-12-07T12:19:33.396639  <8>[   70.108148] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tda19988-driver-present: https://kernelci.org/test/=
case/id/6571b86cdcfa2f7ecae13489
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:19:30.003116  /lava-1053272/1/../bin/lava-test-case
    2023-12-07T12:19:30.060098  <8>[   66.771903] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-12-07T12:19:31.113229  /lava-1053272/1/../bin/lava-test-case
    2023-12-07T12:19:31.171233  <8>[   67.882315] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/6571b86cdcfa2f7ecae13493
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:19:17.252300  /lava-1053272/1/../bin/lava-test-case
    2023-12-07T12:19:17.317329  <8>[   54.027591] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6571b86cdcfa2f7ecae134ac
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:19:09.920652  <8>[   46.632375] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1053272_1.6.2.4.1>
    2023-12-07T12:19:10.038022  / # #
    2023-12-07T12:19:10.139482  export SHELL=3D/bin/sh
    2023-12-07T12:19:10.139922  #
    2023-12-07T12:19:10.240841  / # export SHELL=3D/bin/sh. /lava-1053272/e=
nvironment
    2023-12-07T12:19:10.241277  =

    2023-12-07T12:19:10.342189  / # . /lava-1053272/environment/lava-105327=
2/bin/lava-test-runner /lava-1053272/1
    2023-12-07T12:19:10.342879  =

    2023-12-07T12:19:10.346941  / # /lava-1053272/bin/lava-test-runner /lav=
a-1053272/1
    2023-12-07T12:19:10.565218  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/6571b69c05bb774fe2e134b4

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/arm/omap2plus_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/arm/omap2plus_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/=
id/6571b69c05bb774fe2e134cb
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:12:00.630943  /lava-318125/1/../bin/lava-test-case
    2023-12-07T12:12:00.715445  <8>[   53.146091] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
imx6dl-udoo                  | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/6571b7f9abbde7443de13475

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6571b7f9abbde7443=
de13476
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/6571b7b343e80faefde134c6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6571b7b343e80faef=
de134c7
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 10         =


  Details:     https://kernelci.org/test/plan/id/6571bcaf19ffcbcda7e1347d

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-nfs-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-nfs-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.led7-probed: https://kernelci.org/test/case/id/6571=
bcaf19ffcbcda7e1348a
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:37:55.195811  /lava-318251/1/../bin/lava-test-case
    2023-12-07T12:37:55.234929  <8>[   59.857664] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled7-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led6-probed: https://kernelci.org/test/case/id/6571=
bcaf19ffcbcda7e1348b
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:37:54.124925  /lava-318251/1/../bin/lava-test-case
    2023-12-07T12:37:54.156866  <8>[   58.779734] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled6-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led5-probed: https://kernelci.org/test/case/id/6571=
bcaf19ffcbcda7e1348c
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:37:53.022061  /lava-318251/1/../bin/lava-test-case
    2023-12-07T12:37:53.069869  <8>[   57.695085] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled5-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led4-probed: https://kernelci.org/test/case/id/6571=
bcaf19ffcbcda7e1348d
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:37:51.943103  /lava-318251/1/../bin/lava-test-case
    2023-12-07T12:37:51.983025  <8>[   56.605946] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled4-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led3-probed: https://kernelci.org/test/case/id/6571=
bcaf19ffcbcda7e1348e
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:37:50.857039  /lava-318251/1/../bin/lava-test-case
    2023-12-07T12:37:50.903631  <8>[   55.527259] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled3-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led2-probed: https://kernelci.org/test/case/id/6571=
bcaf19ffcbcda7e1348f
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:37:49.774940  /lava-318251/1/../bin/lava-test-case
    2023-12-07T12:37:49.817909  <8>[   54.441187] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled2-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led1-probed: https://kernelci.org/test/case/id/6571=
bcaf19ffcbcda7e13490
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:37:48.695918  /lava-318251/1/../bin/lava-test-case
    2023-12-07T12:37:48.735830  <8>[   53.358689] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled1-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led0-probed: https://kernelci.org/test/case/id/6571=
bcaf19ffcbcda7e13491
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:37:47.613848  /lava-318251/1/../bin/lava-test-case
    2023-12-07T12:37:47.656653  <8>[   52.280059] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled0-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.iommu1-probed: https://kernelci.org/test/case/id/65=
71bcaf19ffcbcda7e134a4
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:37:45.373914  /lava-318251/1/../bin/lava-test-case
    2023-12-07T12:37:45.421879  <8>[   50.045789] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Diommu1-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.1c050000_mmc-probed: https://kernelci.org/test/case=
/id/6571bcaf19ffcbcda7e134b1
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:37:43.394775  /lava-318251/1/../bin/lava-test-case
    2023-12-07T12:37:43.440638  <8>[   48.063691] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3D1c050000.mmc-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
kontron-kbox-a-230-ls        | arm64  | lab-kontron   | gcc-10   | defconfi=
g                  | 3          =


  Details:     https://kernelci.org/test/plan/id/6571bb57014391bd44e134e2

  Results:     89 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-nfs-kontron-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-nfs-kontron-kbox-a-230-ls.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.layerscape-sfp-driver-present: https://kernelci.org=
/test/case/id/6571bb57014391bd44e13511
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:32:03.704382  /lava-402915/1/../bin/lava-test-case
    2023-12-07T12:32:03.732354  <8>[   24.289033] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.rcpm-driver-present: https://kernelci.org/test/case=
/id/6571bb57014391bd44e13527
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:31:58.797967  /lava-402915/1/../bin/lava-test-case
    2023-12-07T12:31:58.827878  <8>[   19.383826] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.ftm-alarm-driver-present: https://kernelci.org/test=
/case/id/6571bb57014391bd44e13528
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:31:59.835390  /lava-402915/1/../bin/lava-test-case
    2023-12-07T12:31:59.866241  <8>[   20.422334] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2023-12-07T12:32:00.872576  /lava-402915/1/../bin/lava-test-case
    2023-12-07T12:32:00.903388  <8>[   21.459641] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dftm-alarm-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
kontron-sl28-var3-ads2       | arm64  | lab-kontron   | gcc-10   | defconfi=
g                  | 3          =


  Details:     https://kernelci.org/test/plan/id/6571bb42cf52a2e661e1347a

  Results:     97 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-nfs-kontron-sl28-var3-ads2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-nfs-kontron-sl28-var3-ads2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rcpm-driver-present: https://kernelci.org/test/case=
/id/6571bb42cf52a2e661e134c1
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:31:53.001241  /lava-402916/1/../bin/lava-test-case
    2023-12-07T12:31:53.028233  <8>[   16.532593] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.ftm-alarm-driver-present: https://kernelci.org/test=
/case/id/6571bb42cf52a2e661e134c2
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:31:54.035682  /lava-402916/1/../bin/lava-test-case
    2023-12-07T12:31:54.062613  <8>[   17.566503] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2023-12-07T12:31:55.070323  /lava-402916/1/../bin/lava-test-case
    2023-12-07T12:31:55.096252  <8>[   18.600004] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dftm-alarm-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.layerscape-sfp-driver-present: https://kernelci.org=
/test/case/id/6571bb42cf52a2e661e134d7
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T12:31:57.815213  /lava-402916/1/../bin/lava-test-case
    2023-12-07T12:31:57.841145  <8>[   21.345098] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6571bc7abf7843ac76e1348d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6571bc7abf7843ac7=
6e1348e
        new failure (last pass: v5.10.201-cip41-16-g3c85fba3b6e5d) =

 =20

