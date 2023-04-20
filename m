Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D54AC77B72
	for <webhook@archiver.kernel.org>; Thu, 20 Apr 2023 15:00:19 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
 by mx.groups.io with SMTP id smtpd.web11.10512.1682002814422784974
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 20 Apr 2023 08:00:14 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=WFmiRBtV;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.176, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-63b52ad6311so1425382b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 20 Apr 2023 08:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682002813; x=1684594813;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mxHR03W/iEh3BZV3FUuRrX1NmzcMgCrfYl6MSaDwY+8=;
        b=WFmiRBtVAdDtwg+9AmAF+uQ6+ZYrdZw4WcfeX8wR9BrzjOSS64HBwGBHg+QHeKM6BS
         g55JnBPIliiOmevGuclf6Du7j014Bdygfy+fAEO9WI1S6QrKo1rYM30x2E6DDslP94uk
         7/e2F+vh/qar4rw6a2BvgRxJuhNwedWoWLOjgInDLGwEswMKg0+/HSAcho3HCI6a3gTP
         Pxh04smXpOQgnExTatRdiETMcwmEyvPXYzIzMAlsOcBYWpV1Mh1MCCNtpnClK+fqzpkv
         vWJuQImbVPUJxE0TZFXmTG/VufsXw70pQSwGzRUiUbTpe4H9UCETsJ8+9KsFEYch1aVo
         9vUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682002813; x=1684594813;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mxHR03W/iEh3BZV3FUuRrX1NmzcMgCrfYl6MSaDwY+8=;
        b=jZUg+1uEyFJjtTG9V3RBI5R6+bMzGjAKWvexRR779nRNenGxgi1IMSUWEQSaEY/Ugo
         ayjJcoKXuiqq4HrgGX1dLYUNN64wZDiWGr50mu8QKI4JDqlS+HLUmz0xBz33war6xXbM
         t2ZtAyPguOiG3Uz1n6xSffas+gxKV9IicWsPMRhTxzNFZX9IghcSkcsTTNwQKPoHDBM6
         HgHrD6D0ks77+jqe1NswkGpFob4ztsTKEuEPUHJfdL9gAYietf3EX9564JXAphTrDSOs
         khDorlvfIi2e75TLtG4F/3bnn3S74Envex78Fv9FSV2SOrIP/4fCA7yOoWjwbYck3/pM
         2G4A==
X-Gm-Message-State: AAQBX9fufA5CoaVoR698UbyTlqaxOc40hySwf0X7NEkMPRLztd0Iq6bH
	U/gcTuDV1mDyXTOBLBBc8ZJJOoQNLgxtSJtOED+P6rcP
X-Google-Smtp-Source: AKy350bGMFtc+BRfEp2PPQ1F7FR/icBqa2c4NNiZdpwO6AYv3Ev/wgt5eWJMf1gRBDFN4ZJ2V0xCrg==
X-Received: by 2002:a05:6a20:734c:b0:ec:9d9c:4a05 with SMTP id v12-20020a056a20734c00b000ec9d9c4a05mr2858507pzc.13.1682002811881;
        Thu, 20 Apr 2023 08:00:11 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g4-20020a056a001a0400b0062a7462d398sm1400835pfv.170.2023.04.20.08.00.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 08:00:11 -0700 (PDT)
Message-ID: <6441537b.050a0220.c0aff.2677@mx.google.com>
Date: Thu, 20 Apr 2023 08:00:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.4-st20-1099-g7b2580e1565dd
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline: 54 runs,
 62 regressions (v4.4-st20-1099-g7b2580e1565dd)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Apr 2023 15:00:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11248

cip-gitlab/ci/pavel/linux-test baseline: 54 runs, 62 regressions (v4.4-st20=
-1099-g7b2580e1565dd)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 8          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 15         =

dell-latitude...4305U-sarien | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

dell-latitude...8665U-sarien | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx28-duckbill               | arm    | lab-pengutronix | gcc-10   | mxs_de=
fconfig                | 1          =

odroid-xu3                   | arm    | lab-collabora   | gcc-10   | exynos=
_defconfig             | 1          =

qemu_arm-virt-gicv2          | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =

qemu_arm-virt-gicv2-uefi     | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =

qemu_arm-virt-gicv3          | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =

qemu_arm-virt-gicv3-uefi     | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =

qemu_x86_64-uefi-mixed       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig             | 1          =

qemu_x86_64-uefi-mixed       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

rk3288-rock2-square          | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 2          =

rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 21         =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st20-1099-g7b2580e1565dd/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st20-1099-g7b2580e1565dd
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      7b2580e1565ddf95b5123aaa9a1f4c33e354e397 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64414dafbf50149cb02e8625

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/baseline-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/baseline-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64414dafbf50149cb02e8=
626
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64414db13c629900692e8635

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64414db13c629900692e8=
636
        failing since 29 days (last pass: v5.10.168-cip27-456-g42a59c4e5329=
, first fail: v4.19.277-cip94-1098-g26d9f86d942d) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64414dbf5e11ba0b9f2e85ee

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64414dbf5e11ba0b9f2e8=
5ef
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64414dbb7eb1f92fbf2e85e7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64414dbb7eb1f92fbf2e8=
5e8
        failing since 29 days (last pass: v5.10.168-cip27-456-g42a59c4e5329=
, first fail: v4.19.277-cip94-1098-g26d9f86d942d) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 8          =


  Details:     https://kernelci.org/test/plan/id/64414d5407f6b185e72e8606

  Results:     15 PASS, 21 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/arm/multi_v7_defconfig/gcc-10/lab-broonie/ba=
seline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/arm/multi_v7_defconfig/gcc-10/lab-broonie/ba=
seline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.simple-audio-driver-present: https://kernelci.org/test/=
case/id/64414d5407f6b185e72e860a
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43)

    2023-04-20T14:33:47.205642  /opt/bootrr/libexec/bootrr/boards/ti,am335x=
-bone-black: line 84: assert_device-present: not found
    2023-04-20T14:33:48.220800  /lava-361849/1/../bin/lava-test-case
    2023-04-20T14:33:48.238368  [   51.305637] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsimple-audio-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/test/=
case/id/64414d5407f6b185e72e8616
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43)

    2023-04-20T14:33:29.329150  /lava-361849/1/../bin/lava-test-case
    2023-04-20T14:33:29.346325  [   32.413414] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2023-04-20T14:33:30.370283  /lava-361849/1/../bin/lava-test-case
    2023-04-20T14:33:30.387803  [   33.454081] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.am335x-phy-driver-present: https://kernelci.org/test/ca=
se/id/64414d5407f6b185e72e8619
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43)

    2023-04-20T14:33:24.044926  /lava-361849/1/../bin/lava-test-case
    2023-04-20T14:33:24.062162  [   27.128639] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dusb0-musb-dsps-probed RESULT=3Dblocked>
    2023-04-20T14:33:25.085864  /lava-361849/1/../bin/lava-test-case
    2023-04-20T14:33:25.103091  [   28.169771] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dusb1-musb-dsps-probed RESULT=3Dblocked>
    2023-04-20T14:33:26.127177  /lava-361849/1/../bin/lava-test-case
    2023-04-20T14:33:26.144866  [   29.211362] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dam335x-phy-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.musb-dsps-driver-present: https://kernelci.org/test/cas=
e/id/64414d5407f6b185e72e861a
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43)

    2023-04-20T14:33:20.922531  /lava-361849/1/../bin/lava-test-case
    2023-04-20T14:33:20.939075  [   24.006415] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmmc0-probed RESULT=3Dblocked>
    2023-04-20T14:33:21.962875  /lava-361849/1/../bin/lava-test-case
    2023-04-20T14:33:21.979422  [   25.046995] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmmc1-probed RESULT=3Dblocked>
    2023-04-20T14:33:23.003352  /lava-361849/1/../bin/lava-test-case
    2023-04-20T14:33:23.020896  [   26.087570] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmusb-dsps-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sdhci-omap-driver-present: https://kernelci.org/test/ca=
se/id/64414d5407f6b185e72e861b
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43)

    2023-04-20T14:33:19.880949  /lava-361849/1/../bin/lava-test-case
    2023-04-20T14:33:19.898382  [   22.964782] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsdhci-omap-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.tps65217-driver-present: https://kernelci.org/test/case=
/id/64414d5407f6b185e72e8621
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43)

    2023-04-20T14:33:15.583090  /lava-361849/1/../bin/lava-test-case
    2023-04-20T14:33:15.600264  [   18.666684] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtps65217-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.omap8240-driver-present: https://kernelci.org/test/case=
/id/64414d5407f6b185e72e8625
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43)

    2023-04-20T14:33:13.380451  /lava-361849/1/../bin/lava-test-case
    2023-04-20T14:33:13.397913  [   16.464317] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap8240-driver-present RESULT=3Dfail>   =


  * baseline.dmesg.crit: https://kernelci.org/test/case/id/64414d5407f6b185=
e72e862e
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43)
        1 lines

    2023-04-20T14:33:11.046562  / # =

    2023-04-20T14:33:11.052037  =

    2023-04-20T14:33:11.155384  / # #
    2023-04-20T14:33:11.160983  #
    2023-04-20T14:33:11.262954  / # export SHELL=3D/bin/sh
    2023-04-20T14:33:11.268288  export SHELL=3D/bin/sh
    2023-04-20T14:33:11.369779  / # . /lava-361849/environment
    2023-04-20T14:33:11.375860  . /lava-361849/environment
    2023-04-20T14:33:11.477951  / # /lava-361849/bin/lava-test-runner /lava=
-361849/0
    2023-04-20T14:33:11.482821  /lava-361849/bin/lava-test-runner /lava-361=
849/0 =

    ... (9 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 15         =


  Details:     https://kernelci.org/test/plan/id/64414d29782111a66c2e8701

  Results:     24 PASS, 17 FAIL, 2 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/arm/omap2plus_defconfig/gcc-10/lab-broonie/b=
aseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/arm/omap2plus_defconfig/gcc-10/lab-broonie/b=
aseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.hdmi-audio: https://kernelci.org/test/case/id/64414d297=
82111a66c2e8704
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43)

    2023-04-20T14:32:56.641459  /lava-361829/1/../bin/lava-test-case
    2023-04-20T14:32:56.727041  [   81.247534] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio-probed RESULT=3Dblocked>
    2023-04-20T14:32:57.857075  /lava-361829/1/../bin/lava-test-case
    2023-04-20T14:32:57.942055  [   82.463703] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline.bootrr.simple-audio-driver-present: https://kernelci.org/test/=
case/id/64414d29782111a66c2e8705
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43)

    2023-04-20T14:32:54.399604  /opt/bootrr/libexec/bootrr/boards/ti,am335x=
-bone-black: line 84: assert_device-present: not found
    2023-04-20T14:32:55.467302  /lava-361829/1/../bin/lava-test-case
    2023-04-20T14:32:55.554315  [   80.073697] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsimple-audio-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-codec-driver-present: https://kernelci.org/test/ca=
se/id/64414d29782111a66c2e8706
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43)

    2023-04-20T14:32:53.217933  /lava-361829/1/../bin/lava-test-case
    2023-04-20T14:32:53.262299  [   77.782966] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-04-20T14:32:54.331483  /lava-361829/1/../bin/lava-test-case
    2023-04-20T14:32:54.383053  [   78.902810] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case/id/=
64414d29782111a66c2e8707
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43)

    2023-04-20T14:32:50.831017  /lava-361829/1/../bin/lava-test-case
    2023-04-20T14:32:50.918581  [   75.439378] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-04-20T14:32:51.941904  [   76.457820] udevd[105]: worker [109] /de=
vices/platform/ocp/47400000.usb/47401c00.usb/musb-hdrc.1.auto/usb1 is takin=
g a long time
    2023-04-20T14:32:51.999589  /lava-361829/1/../bin/lava-test-case
    2023-04-20T14:32:52.086406  [   76.606854] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline.bootrr.tda19988-driver-present: https://kernelci.org/test/case=
/id/64414d29782111a66c2e8708
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43)

    2023-04-20T14:32:48.417073  /lava-361829/1/../bin/lava-test-case
    2023-04-20T14:32:48.501762  [   73.022482] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-04-20T14:32:49.608674  /lava-361829/1/../bin/lava-test-case
    2023-04-20T14:32:49.696417  [   74.216163] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.tilcdc-driver-probed: https://kernelci.org/test/case/id=
/64414d29782111a66c2e8709
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43)

    2023-04-20T14:32:47.318100  /lava-361829/1/../bin/lava-test-case
    2023-04-20T14:32:47.356210  [   71.876330] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtilcdc-driver-probed RESULT=3Dfail>   =


  * baseline.bootrr.omap-sham-driver-present: https://kernelci.org/test/cas=
e/id/64414d29782111a66c2e870e
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43)

    2023-04-20T14:32:44.508521  /lava-361829/1/../bin/lava-test-case
    2023-04-20T14:32:44.547177  [   69.066997] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap-sham-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.omap-aes-driver-present: https://kernelci.org/test/case=
/id/64414d29782111a66c2e8711
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43)

    2023-04-20T14:32:41.909859  /lava-361829/1/../bin/lava-test-case
    2023-04-20T14:32:41.998432  [   66.518226] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap-aes-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/test/=
case/id/64414d29782111a66c2e8714
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43)

    2023-04-20T14:32:38.179811  /lava-361829/1/../bin/lava-test-case
    2023-04-20T14:32:38.224299  [   62.744162] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2023-04-20T14:32:39.293045  /lava-361829/1/../bin/lava-test-case
    2023-04-20T14:32:39.343765  [   63.863349] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/64414d29782111a66c2e8715
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43)

    2023-04-20T14:32:36.958969  /lava-361829/1/../bin/lava-test-case
    2023-04-20T14:32:37.047638  [   61.566753] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sdhci-omap-driver-present: https://kernelci.org/test/ca=
se/id/64414d29782111a66c2e871a
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43)

    2023-04-20T14:32:31.368908  /lava-361829/1/../bin/lava-test-case
    2023-04-20T14:32:31.455715  [   55.974648] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dbaseboard-eeprom-probed RESULT=3Dblocked>
    2023-04-20T14:32:32.587286  /lava-361829/1/../bin/lava-test-case
    2023-04-20T14:32:32.673761  [   57.193217] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsdhci-omap-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.at24-driver-present: https://kernelci.org/test/case/id/=
64414d29782111a66c2e871b
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43)

    2023-04-20T14:32:30.236058  /lava-361829/1/../bin/lava-test-case
    2023-04-20T14:32:30.288307  [   54.807998] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dat24-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.pwrbutton-driver-present: https://kernelci.org/test/cas=
e/id/64414d29782111a66c2e871e
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43)

    2023-04-20T14:32:27.623658  /lava-361829/1/../bin/lava-test-case
    2023-04-20T14:32:27.709667  [   52.228606] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dpwrbutton-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.omap8240-driver-present: https://kernelci.org/test/case=
/id/64414d29782111a66c2e8724
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43)

    2023-04-20T14:32:24.656004  /lava-361829/1/../bin/lava-test-case
    2023-04-20T14:32:24.740602  [   49.259611] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap8240-driver-present RESULT=3Dfail>   =


  * baseline.dmesg.crit: https://kernelci.org/test/case/id/64414d29782111a6=
6c2e872e
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43)
        1 lines

    2023-04-20T14:32:21.320248  / # =

    2023-04-20T14:32:21.328863  =

    2023-04-20T14:32:21.434524  / # #
    2023-04-20T14:32:21.441142  #
    2023-04-20T14:32:21.543798  / # export SHELL=3D/bin/sh
    2023-04-20T14:32:21.550647  export SHELL=3D/bin/sh
    2023-04-20T14:32:21.653037  / # . /lava-361829/environment
    2023-04-20T14:32:21.661729  . /lava-361829/environment
    2023-04-20T14:32:21.764161  / # /lava-361829/bin/lava-test-runner /lava=
-361829/0
    2023-04-20T14:32:21.770399  /lava-361829/bin/lava-test-runner /lava-361=
829/0 =

    ... (9 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
dell-latitude...4305U-sarien | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64414db43c629900692e8639

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/baseline-dell-latitude-5400-4305U-sarien.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/baseline-dell-latitude-5400-4305U-sarien.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64414db43c629900692e8=
63a
        failing since 29 days (last pass: v4.19.277-cip94-1098-g26d9f86d942=
d, first fail: v5.10.175-cip29-rt12) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
dell-latitude...8665U-sarien | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64414db0bf50149cb02e8628

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/baseline-dell-latitude-5400-8665U-sarien.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/baseline-dell-latitude-5400-8665U-sarien.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64414db0bf50149cb02e8=
629
        failing since 29 days (last pass: v4.19.277-cip94-1098-g26d9f86d942=
d, first fail: v5.10.175-cip29-rt12) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64414dc34a8952f5372e85f3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64414dc34a8952f5372e8=
5f4
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64414db5f5f8b2b2ff2e8602

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64414db5f5f8b2b2ff2e8=
603
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx28-duckbill               | arm    | lab-pengutronix | gcc-10   | mxs_de=
fconfig                | 1          =


  Details:     https://kernelci.org/test/plan/id/64414c6d0588afbaf02e8607

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: mxs_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/arm/mxs_defconfig/gcc-10/lab-pengutronix/bas=
eline-imx28-duckbill.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/arm/mxs_defconfig/gcc-10/lab-pengutronix/bas=
eline-imx28-duckbill.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64414c6d0588afbaf02e8=
608
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
odroid-xu3                   | arm    | lab-collabora   | gcc-10   | exynos=
_defconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/64414aead0b81158142e86c5

  Results:     4 PASS, 1 FAIL, 2 SKIP
  Full config: exynos_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/arm/exynos_defconfig/gcc-10/lab-collabora/ba=
seline-odroid-xu3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/arm/exynos_defconfig/gcc-10/lab-collabora/ba=
seline-odroid-xu3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.all-cpus-are-online: https://kernelci.org/test/case/id/=
64414aead0b81158142e86c9
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43)

    2023-04-20T14:23:20.006492  /lava-10062717/1/../bin/lava-test-case

    2023-04-20T14:23:20.023613  [   44.805958] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dall-cpus-are-online RESULT=3Dfail>
   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm-virt-gicv2          | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64414cd846ce60d5e12e85e7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/arm/multi_v7_defconfig/gcc-10/lab-collabora/=
baseline-qemu_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/arm/multi_v7_defconfig/gcc-10/lab-collabora/=
baseline-qemu_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64414cd846ce60d5e12e8=
5e8
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm-virt-gicv2-uefi     | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64414db83c629900692e864e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/arm/multi_v7_defconfig/gcc-10/lab-collabora/=
baseline-qemu_arm-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/arm/multi_v7_defconfig/gcc-10/lab-collabora/=
baseline-qemu_arm-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64414db83c629900692e8=
64f
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm-virt-gicv3          | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64414cc64bacf390af2e864e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/arm/multi_v7_defconfig/gcc-10/lab-collabora/=
baseline-qemu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/arm/multi_v7_defconfig/gcc-10/lab-collabora/=
baseline-qemu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64414cc64bacf390af2e8=
64f
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm-virt-gicv3-uefi     | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64414db6a3bd164a952e8618

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/arm/multi_v7_defconfig/gcc-10/lab-collabora/=
baseline-qemu_arm-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/arm/multi_v7_defconfig/gcc-10/lab-collabora/=
baseline-qemu_arm-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64414db6a3bd164a952e8=
619
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/64414db53c629900692e863c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/x86_64/x86_64_defconfig/gcc-10/lab-collabora=
/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/x86_64/x86_64_defconfig/gcc-10/lab-collabora=
/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64414db53c629900692e8=
63d
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64414db75e11ba0b9f2e85e9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64414db75e11ba0b9f2e8=
5ea
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3288-rock2-square          | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 2          =


  Details:     https://kernelci.org/test/plan/id/64414cde46ce60d5e12e8607

  Results:     7 PASS, 2 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/arm/multi_v7_defconfig/gcc-10/lab-collabora/=
baseline-rk3288-rock2-square.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/arm/multi_v7_defconfig/gcc-10/lab-collabora/=
baseline-rk3288-rock2-square.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-pm-domain-driver-present: https://kernelci.org=
/test/case/id/64414cde46ce60d5e12e860c
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43)

    2023-04-20T14:31:43.223544  /lava-10062830/1/../bin/lava-test-case

    2023-04-20T14:31:43.261874  [   43.238790] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk3288-crypto-probed RESULT=3Dblocked>

    2023-04-20T14:31:44.316026  /lava-10062830/1/../bin/lava-test-case

    2023-04-20T14:31:44.344067  [   44.320863] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-pm-domain-driver-present RESULT=3Dfail>
   =


  * baseline.bootrr.rk3288-crypto-driver-present: https://kernelci.org/test=
/case/id/64414cde46ce60d5e12e860d
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43)

    2023-04-20T14:31:42.131596  /lava-10062830/1/../bin/lava-test-case

    2023-04-20T14:31:42.169677  [   42.145879] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk3288-crypto-driver-present RESULT=3Dfail>
   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 21         =


  Details:     https://kernelci.org/test/plan/id/64414cf2782111a66c2e85eb

  Results:     37 PASS, 22 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/arm/multi_v7_defconfig/gcc-10/lab-collabora/=
baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/arm/multi_v7_defconfig/gcc-10/lab-collabora/=
baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.rk_iommu-vopl_mmu-probed: https://kernelci.org/test/cas=
e/id/64414cf2782111a66c2e85ee
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43)

    2023-04-20T14:31:52.060487  /lava-10062827/1/../bin/lava-test-case

    2023-04-20T14:31:52.098499  [   60.131125] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk_iommu-vopl_mmu-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rk_iommu-vopb_mmu-probed: https://kernelci.org/test/cas=
e/id/64414cf2782111a66c2e85ef
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43)

    2023-04-20T14:31:50.964975  /lava-10062827/1/../bin/lava-test-case

    2023-04-20T14:31:50.989759  [   59.022016] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk_iommu-vopb_mmu-probed RESULT=3Dfail>
   =


  * baseline.bootrr.ramoops-driver-present: https://kernelci.org/test/case/=
id/64414cf2782111a66c2e85f7
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43)

    2023-04-20T14:31:47.600641  [   55.631625] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dehci-platform-usb_host0_ehci-probed RESULT=3Dpass>

    2023-04-20T14:31:48.614668  /lava-10062827/1/../bin/lava-test-case

    2023-04-20T14:31:48.653294  [   56.685642] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dramoops-driver-present RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-pwm0-probed: https://kernelci.org/test/case/id=
/64414cf2782111a66c2e8605
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43)

    2023-04-20T14:32:02.707091  /lava-10062827/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-iodomain-driver-present: https://kernelci.org/=
test/case/id/64414cf2782111a66c2e8607
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43)

    2023-04-20T14:31:58.431571  [   66.463314] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockcip-i2s-driver-present RESULT=3Dfail>

    2023-04-20T14:31:59.485070  /lava-10062827/1/../bin/lava-test-case

    2023-04-20T14:31:59.510194  [   67.541774] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-i2s-probed RESULT=3Dblocked>

    2023-04-20T14:32:00.526783  /lava-10062827/1/../bin/lava-test-case

    2023-04-20T14:32:00.561758  [   68.593955] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-iodomain-driver-present RESULT=3Dfail>
   =


  * baseline.bootrr.rockcip-i2s-driver-present: https://kernelci.org/test/c=
ase/id/64414cf2782111a66c2e8608
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43)

    2023-04-20T14:31:57.392364  /lava-10062827/1/../bin/lava-test-case

    2023-04-20T14:31:57.403054  [   65.434713] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-dp-phy-grf-probed RESULT=3Dblocked>

    2023-04-20T14:31:58.413783  /lava-10062827/1/../bin/lava-test-case
   =


  * baseline.bootrr.cros-ec-i2c-tunnel-driver-present: https://kernelci.org=
/test/case/id/64414cf2782111a66c2e8609
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43)

    2023-04-20T14:31:38.551042  [   46.581048] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcros-ec-dev-driver-present RESULT=3Dfail>

    2023-04-20T14:31:39.573566  /lava-10062827/1/../bin/lava-test-case

    2023-04-20T14:31:39.606612  [   47.638249] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcros-ec-dev-probed RESULT=3Dblocked>

    2023-04-20T14:31:40.624649  /lava-10062827/1/../bin/lava-test-case
   =


  * baseline.bootrr.cros-ec-dev-driver-present: https://kernelci.org/test/c=
ase/id/64414cf2782111a66c2e860a
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43)

    2023-04-20T14:31:37.485692  [   45.517658] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtpm-chip-is-online RESULT=3Dskip>

    2023-04-20T14:31:38.511390  /lava-10062827/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-pm-domain-driver-present: https://kernelci.org=
/test/case/id/64414cf2782111a66c2e860e
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43)

    2023-04-20T14:32:07.959845  [   75.991920] udevd[108]: worker [114] /de=
vices/platform/ff540000.usb/usb2 is taking a long time

    2023-04-20T14:32:07.968457  [   76.000699] udevd[108]: worker [112] /de=
vices/platform/ff500000.usb/usb1 is taking a long time

    2023-04-20T14:32:07.977098  [   76.009426] udevd[108]: worker [118] /de=
vices/platform/ff580000.usb/usb3 is taking a long time

    2023-04-20T14:32:08.364672  /lava-10062827/1/../bin/lava-test-case

    2023-04-20T14:32:08.387691  [   76.419313] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk3288-crypto-probed RESULT=3Dblocked>

    2023-04-20T14:32:09.418634  /lava-10062827/1/../bin/lava-test-case

    2023-04-20T14:32:09.449941  [   77.482159] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-pm-domain-driver-present RESULT=3Dfail>
   =


  * baseline.bootrr.rk3288-crypto-driver-present: https://kernelci.org/test=
/case/id/64414cf2782111a66c2e860f
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43)

    2023-04-20T14:32:07.273429  /lava-10062827/1/../bin/lava-test-case

    2023-04-20T14:32:07.311849  [   75.344432] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk3288-crypto-driver-present RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-vopl-probed: https://kernelci.org/test/case/id=
/64414cf2782111a66c2e8610
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43)

    2023-04-20T14:32:05.148719  [   73.180229] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-vopb-probed RESULT=3Dfail>

    2023-04-20T14:32:06.183528  /lava-10062827/1/../bin/lava-test-case

    2023-04-20T14:32:06.191116  [   74.224514] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-vopl-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-vopb-probed: https://kernelci.org/test/case/id=
/64414cf2782111a66c2e8611
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43)

    2023-04-20T14:32:05.108599  /lava-10062827/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb-phy-grf-probed: https://kernelci.org/test/=
case/id/64414cf2782111a66c2e8613
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43)

    2023-04-20T14:32:02.963161  [   70.994858] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-usb-phy-driver-present RESULT=3Dpass>

    2023-04-20T14:32:03.981253  /lava-10062827/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-dp-phy-driver-present: https://kernelci.org/te=
st/case/id/64414cf2782111a66c2e8614
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43)

    2023-04-20T14:31:55.274773  /lava-10062827/1/../bin/lava-test-case

    2023-04-20T14:31:55.292987  [   63.325313] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-dp-edp-probed RESULT=3Dblocked>

    2023-04-20T14:31:56.317317  /lava-10062827/1/../bin/lava-test-case

    2023-04-20T14:31:56.355513  [   64.387661] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-dp-phy-driver-present RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-dp-driver-present: https://kernelci.org/test/c=
ase/id/64414cf2782111a66c2e8615
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43)

    2023-04-20T14:31:53.181937  [   61.213082] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk_iommu-vpu_mmu-probed RESULT=3Dfail>

    2023-04-20T14:31:54.232618  /lava-10062827/1/../bin/lava-test-case

    2023-04-20T14:31:54.250988  [   62.283130] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-dp-driver-present RESULT=3Dfail>
   =


  * baseline.bootrr.rk_iommu-vpu_mmu-probed: https://kernelci.org/test/case=
/id/64414cf2782111a66c2e8616
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43)

    2023-04-20T14:31:53.141773  /lava-10062827/1/../bin/lava-test-case
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/64414cf2782111a66c2e8619
        failing since 90 days (last pass: v5.10.158-cip22-435-g2c52868ae1cb=
c, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-04-20T14:31:46.397892  	-s SE[   54.424218] <LAVA_SIGNAL_TESTCASE =
TEST_CASE_ID=3Ddwhdmi-rockchip-driver-audio-present RESULT=3Dfail>

    2023-04-20T14:31:46.399116  P	String separator

    2023-04-20T14:31:46.402496  /lava-10062827/1/../bin/lava-test-case

    2023-04-20T14:31:46.407893  BusyBox v1.31.1 (2023-04-14 10:59:35 UTC) m=
ulti-call binary.

    2023-04-20T14:31:46.408115  =

   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/64414cf2782111a66c2e861a
        failing since 90 days (last pass: v5.10.158-cip22-435-g2c52868ae1cb=
c, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-04-20T14:31:46.333972  [   54.364858] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dfail>

    2023-04-20T14:31:46.374004  BusyBox v1.31.1 (2023-04-14 10:59:35 UTC) m=
ulti-call binary.

    2023-04-20T14:31:46.374528  =


    2023-04-20T14:31:46.377957  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-04-20T14:31:46.378436  =


    2023-04-20T14:31:46.382337  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-04-20T14:31:46.384772  FIRST, INC default to 1.

    2023-04-20T14:31:46.385246  =


    2023-04-20T14:31:46.387909  	-w	Pad to last with leading zeros
   =


  * baseline.bootrr.dwhdmi-rockchip-probed: https://kernelci.org/test/case/=
id/64414cf2782111a66c2e861b
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43)

    2023-04-20T14:31:46.301995  /lava-10062827/1/../bin/lava-test-case
   =


  * baseline.bootrr.dw_wdt-driver-present: https://kernelci.org/test/case/i=
d/64414cf2782111a66c2e8620
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43)

    2023-04-20T14:31:42.987828  [   51.019974] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddw-apb-uart2-probed RESULT=3Dpass>

    2023-04-20T14:31:43.999733  /lava-10062827/1/../bin/lava-test-case
   =


  * baseline.bootrr.cros-ec-keyb-probed: https://kernelci.org/test/case/id/=
64414cf2782111a66c2e8625
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43)

    2023-04-20T14:31:41.796799  [   49.828215] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcros-ec-keyb-driver-present RESULT=3Dpass>

    2023-04-20T14:31:42.812281  /lava-10062827/1/../bin/lava-test-case

    2023-04-20T14:31:42.846746  [   50.879369] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcros-ec-keyb-probed RESULT=3Dfail>
   =

 =20

