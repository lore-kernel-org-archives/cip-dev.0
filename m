Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBBAC77B7A
	for <webhook@archiver.kernel.org>; Wed,  7 Jun 2023 14:54:25 +0000 (UTC)
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
 by mx.groups.io with SMTP id smtpd.web11.224.1686149663962085337
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 07 Jun 2023 07:54:24 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=WcNnLkr8;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.166.181, mailfrom: bot@kernelci.org)
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-33b1da9a8acso6071415ab.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 07 Jun 2023 07:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686149662; x=1688741662;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SjPA18j1ZN22zTGqzjMc0SXa7UjbUuoMBE9Wqe0I+a4=;
        b=WcNnLkr8hMCq8x0CqT2a3ea1E5JunWtHq1tujDaRvkBPSgQGOygeJNbJ9FY9Plum4q
         7ZXOHugBXWOwF7xRXUKAoaG14EoHkA2M41Stq9NHX02J18KugbzCV/IXeoCAxPHjQzBu
         rEywETXdFjw344JH29ArfNK/WkwHmEPhWnXKta4/iHRzdlvlHkM+FPxFqj22DL6fRpIs
         fOgB5d5svg2BXLGKjSsbNr65MecOiX3PjCPmTKXhYPvhvuY7zAd7S+vBkpud2yp0gr+c
         iAVVge15Xqs0IW12jNFcnl6Y95qm/wky2V5QyhPghp3gkD2J9YffK1Tbd2ikAj2BHF6J
         D3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686149662; x=1688741662;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SjPA18j1ZN22zTGqzjMc0SXa7UjbUuoMBE9Wqe0I+a4=;
        b=IHkXymSL4lYJnRLzgqCvVBZOPcpr9+6BrLvQOOlQOyF0HYm1AmI0ZnNZ8NCKvL10jg
         0gu5eJdts3r6HrkakBkjKx32/W2WARAgz9UCCZdaOWnIZ/xomJ25fNUjwJ1xsDAQo3CZ
         S/V5eRQuNvrn9HoWkhixfD5uHMQ6HOZkX5DIE0hIesX/g/asjQAiY86x3O5wS0H8JHNV
         e/C/iodA3B+2XVLQX0odavfn9VvniyS4RztwDt9+GXw0YTq7lAk13BiiOkiUuijP1Dvv
         oaF29EzuFXBYtdQyWU6JBNd+QuWmklhVh5nSHA9Rc9xou1L1y4Mf8fUqBS3yihIZSkf6
         MV0Q==
X-Gm-Message-State: AC+VfDym14TLVGuJrl8IVTmZLWkwJVmkHrpcXqNNWj+RV1ASVGMhqk6N
	iZosla4MmB9AKBM81qah1DwQDFDQo9VIiMvkA+VQWw==
X-Google-Smtp-Source: ACHHUZ4WknNP61j+ZX8mufChupER5esTIMU2L3BI2Jrdy8Q40eMg7gOGpXvBWIfTH4DloJvyzdK4mw==
X-Received: by 2002:a92:d8c7:0:b0:33b:893c:9fd6 with SMTP id l7-20020a92d8c7000000b0033b893c9fd6mr8094691ilo.23.1686149661164;
        Wed, 07 Jun 2023 07:54:21 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id nd11-20020a17090b4ccb00b0024e1172c1d3sm1479101pjb.32.2023.06.07.07.54.19
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 07:54:20 -0700 (PDT)
Message-ID: <64809a1c.170a0220.103cd.31b9@mx.google.com>
Date: Wed, 07 Jun 2023 07:54:20 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip74-rt43-218-g246f4be89a77
Subject: cip-gitlab/ci/pavel/linux-test baseline: 66 runs,
 125 regressions (v4.4.302-cip74-rt43-218-g246f4be89a77)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Jun 2023 14:54:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11917

cip-gitlab/ci/pavel/linux-test baseline: 66 runs, 125 regressions (v4.4.302=
-cip74-rt43-218-g246f4be89a77)

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
v7_defconfig           | 13         =

beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig           | 13         =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 15         =

beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
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

imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 10         =

imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 10         =

odroid-xu3                   | arm    | lab-collabora   | gcc-10   | exynos=
_defconfig             | 1          =

qemu_arm-virt-gicv2          | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =

qemu_arm-virt-gicv2          | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =

qemu_arm-virt-gicv2-uefi     | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =

qemu_arm-virt-gicv2-uefi     | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =

qemu_arm-virt-gicv3          | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =

qemu_arm-virt-gicv3          | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =

qemu_arm-virt-gicv3-uefi     | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =

qemu_arm-virt-gicv3-uefi     | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =

qemu_mips-malta              | mips   | lab-broonie     | gcc-10   | malta_=
defconfig              | 1          =

qemu_mips-malta              | mips   | lab-collabora   | gcc-10   | malta_=
defconfig              | 1          =

qemu_x86_64-uefi-mixed       | x86_64 | lab-broonie     | gcc-10   | x86_64=
_defconfig             | 1          =

qemu_x86_64-uefi-mixed       | x86_64 | lab-broonie     | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

qemu_x86_64-uefi-mixed       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig             | 1          =

qemu_x86_64-uefi-mixed       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =

rk3288-rock2-square          | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 2          =

rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 22         =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip74-rt43-218-g246f4be89a77/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip74-rt43-218-g246f4be89a77
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      246f4be89a7760f90649094cbfabcccfce7dafd1 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648091a889bb8a213b306144

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/baseline-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/baseline-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/648091a889bb8a213b306=
145
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648091bc2e8d8174e830614b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/648091bc2e8d8174e8306=
14c
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648091bc08562f963c306149

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/648091bc08562f963c306=
14a
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648091be08562f963c306155

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/648091be08562f963c306=
156
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 13         =


  Details:     https://kernelci.org/test/plan/id/6480904fb95d5ccf86306137

  Results:     15 PASS, 21 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/arm/multi_v7_defconfig/gcc-10/lab-br=
oonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/arm/multi_v7_defconfig/gcc-10/lab-br=
oonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.hdmi-audio: https://kernelci.org/test/case/id/6480904fb=
95d5ccf8630613a
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:12:23.075901  /lava-575502/1/../bin/lava-test-case
    2023-06-07T14:12:23.092893  [   52.393684] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio-probed RESULT=3Dblocked>
    2023-06-07T14:12:24.115731  /lava-575502/1/../bin/lava-test-case
    2023-06-07T14:12:24.132257  [   53.433766] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline.bootrr.simple-audio-driver-present: https://kernelci.org/test/=
case/id/6480904fb95d5ccf8630613b
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:12:21.018649  /opt/bootrr/libexec/bootrr/boards/ti,am335x=
-bone-black: line 84: assert_device-present: not found
    2023-06-07T14:12:22.034447  /lava-575502/1/../bin/lava-test-case
    2023-06-07T14:12:22.052242  [   51.352133] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsimple-audio-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-codec-driver-present: https://kernelci.org/test/ca=
se/id/6480904fb95d5ccf8630613c
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:12:19.950614  /lava-575502/1/../bin/lava-test-case
    2023-06-07T14:12:19.967573  [   49.268471] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-06-07T14:12:20.991655  /lava-575502/1/../bin/lava-test-case
    2023-06-07T14:12:21.011068  [   50.309358] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case/id/=
6480904fb95d5ccf8630613d
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:12:17.867983  /lava-575502/1/../bin/lava-test-case
    2023-06-07T14:12:17.885399  [   47.186247] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-06-07T14:12:18.909271  /lava-575502/1/../bin/lava-test-case
    2023-06-07T14:12:18.926650  [   48.227218] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline.bootrr.tda19988-driver-present: https://kernelci.org/test/case=
/id/6480904fb95d5ccf8630613e
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:12:15.786300  /lava-575502/1/../bin/lava-test-case
    2023-06-07T14:12:15.802696  [   45.103692] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-06-07T14:12:16.826976  /lava-575502/1/../bin/lava-test-case
    2023-06-07T14:12:16.844303  [   46.144334] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/test/=
case/id/6480904fb95d5ccf86306148
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:12:03.135120  /lava-575502/1/../bin/lava-test-case
    2023-06-07T14:12:03.152317  [   32.452221] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2023-06-07T14:12:04.176159  /lava-575502/1/../bin/lava-test-case
    2023-06-07T14:12:04.193771  [   33.493262] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/6480904fb95d5ccf86306149
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:12:02.093200  /lava-575502/1/../bin/lava-test-case
    2023-06-07T14:12:02.111199  [   31.410603] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.am335x-phy-driver-present: https://kernelci.org/test/ca=
se/id/6480904fb95d5ccf8630614c
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:11:57.847974  /lava-575502/1/../bin/lava-test-case
    2023-06-07T14:11:57.864770  [   27.165349] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dusb0-musb-dsps-probed RESULT=3Dblocked>
    2023-06-07T14:11:58.889368  /lava-575502/1/../bin/lava-test-case
    2023-06-07T14:11:58.907249  [   28.207095] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dusb1-musb-dsps-probed RESULT=3Dblocked>
    2023-06-07T14:11:59.931189  /lava-575502/1/../bin/lava-test-case
    2023-06-07T14:11:59.948758  [   29.248310] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dam335x-phy-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.musb-dsps-driver-present: https://kernelci.org/test/cas=
e/id/6480904fb95d5ccf8630614d
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:11:54.724275  /lava-575502/1/../bin/lava-test-case
    2023-06-07T14:11:54.741366  [   24.042095] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmmc0-probed RESULT=3Dblocked>
    2023-06-07T14:11:55.764759  /lava-575502/1/../bin/lava-test-case
    2023-06-07T14:11:55.781361  [   25.082893] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmmc1-probed RESULT=3Dblocked>
    2023-06-07T14:11:56.805324  /lava-575502/1/../bin/lava-test-case
    2023-06-07T14:11:56.823520  [   26.123397] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmusb-dsps-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sdhci-omap-driver-present: https://kernelci.org/test/ca=
se/id/6480904fb95d5ccf8630614e
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:11:53.683312  /lava-575502/1/../bin/lava-test-case
    2023-06-07T14:11:53.700906  [   23.000274] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsdhci-omap-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.tps65217-driver-present: https://kernelci.org/test/case=
/id/6480904fb95d5ccf86306154
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:11:49.382390  /lava-575502/1/../bin/lava-test-case
    2023-06-07T14:11:49.399895  [   18.699453] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtps65217-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.omap8240-driver-present: https://kernelci.org/test/case=
/id/6480904fb95d5ccf86306158
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:11:47.178653  /lava-575502/1/../bin/lava-test-case
    2023-06-07T14:11:47.196092  [   16.495633] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap8240-driver-present RESULT=3Dfail>   =


  * baseline.dmesg.crit: https://kernelci.org/test/case/id/6480904fb95d5ccf=
8630615f
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)
        1 lines

    2023-06-07T14:11:44.842224  / # =

    2023-06-07T14:11:44.846614  =

    2023-06-07T14:11:44.951080  / # #
    2023-06-07T14:11:44.956005  #
    2023-06-07T14:11:45.058233  / # export SHELL=3D/bin/sh
    2023-06-07T14:11:45.062451  export SHELL=3D/bin/sh
    2023-06-07T14:11:45.164407  / # . /lava-575502/environment
    2023-06-07T14:11:45.169725  . /lava-575502/environment
    2023-06-07T14:11:45.271687  / # /lava-575502/bin/lava-test-runner /lava=
-575502/0
    2023-06-07T14:11:45.275518  /lava-575502/bin/lava-test-runner /lava-575=
502/0 =

    ... (9 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig           | 13         =


  Details:     https://kernelci.org/test/plan/id/6480924f179b01963e30613e

  Results:     15 PASS, 21 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/arm/multi_v7_defconfig/gcc-10/lab-ci=
p/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/arm/multi_v7_defconfig/gcc-10/lab-ci=
p/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.omap8240-driver-present: https://kernelci.org/test/case=
/id/6480924f179b01963e306144
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:20:04.119400  /lava-955493/1/../bin/lava-test-case
    2023-06-07T14:20:04.137763  [   10.173164] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap8240-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.tps65217-driver-present: https://kernelci.org/test/case=
/id/6480924f179b01963e306148
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:20:06.324014  /lava-955493/1/../bin/lava-test-case
    2023-06-07T14:20:06.342616  [   12.377531] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtps65217-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sdhci-omap-driver-present: https://kernelci.org/test/ca=
se/id/6480924f179b01963e30614e
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:20:10.623210  /lava-955493/1/../bin/lava-test-case
    2023-06-07T14:20:10.640570  [   16.676871] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsdhci-omap-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.musb-dsps-driver-present: https://kernelci.org/test/cas=
e/id/6480924f179b01963e30614f
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:20:11.665138  /lava-955493/1/../bin/lava-test-case
    2023-06-07T14:20:11.681055  [   17.718381] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmmc0-probed RESULT=3Dblocked>
    2023-06-07T14:20:12.704669  /lava-955493/1/../bin/lava-test-case
    2023-06-07T14:20:12.721661  [   18.759115] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmmc1-probed RESULT=3Dblocked>
    2023-06-07T14:20:13.746070  /lava-955493/1/../bin/lava-test-case
    2023-06-07T14:20:13.763141  [   19.799750] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmusb-dsps-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.am335x-phy-driver-present: https://kernelci.org/test/ca=
se/id/6480924f179b01963e306150
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:20:14.787654  /lava-955493/1/../bin/lava-test-case
    2023-06-07T14:20:14.804882  [   20.841553] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dusb0-musb-dsps-probed RESULT=3Dblocked>
    2023-06-07T14:20:15.829248  /lava-955493/1/../bin/lava-test-case
    2023-06-07T14:20:15.846468  [   21.882829] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dusb1-musb-dsps-probed RESULT=3Dblocked>
    2023-06-07T14:20:16.869754  /lava-955493/1/../bin/lava-test-case
    2023-06-07T14:20:16.888212  [   22.923974] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dam335x-phy-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/6480924f179b01963e306153
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:20:19.031624  /lava-955493/1/../bin/lava-test-case
    2023-06-07T14:20:19.047581  [   25.084528] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/test/=
case/id/6480924f179b01963e306154
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:20:20.072233  /lava-955493/1/../bin/lava-test-case
    2023-06-07T14:20:20.089435  [   26.125938] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2023-06-07T14:20:21.112976  /lava-955493/1/../bin/lava-test-case
    2023-06-07T14:20:21.131075  [   27.167419] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.tda19988-driver-present: https://kernelci.org/test/case=
/id/6480924f179b01963e30615e
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:20:32.722327  /lava-955493/1/../bin/lava-test-case
    2023-06-07T14:20:32.738562  [   38.776728] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-06-07T14:20:33.761687  /lava-955493/1/../bin/lava-test-case
    2023-06-07T14:20:33.779826  [   39.817178] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case/id/=
6480924f179b01963e30615f
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:20:34.803261  /lava-955493/1/../bin/lava-test-case
    2023-06-07T14:20:34.819153  [   40.858221] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-06-07T14:20:35.843767  /lava-955493/1/../bin/lava-test-case
    2023-06-07T14:20:35.860670  [   41.899015] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-codec-driver-present: https://kernelci.org/test/ca=
se/id/6480924f179b01963e306160
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:20:36.884753  /lava-955493/1/../bin/lava-test-case
    2023-06-07T14:20:36.900963  [   42.940220] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-06-07T14:20:37.926261  /lava-955493/1/../bin/lava-test-case
    2023-06-07T14:20:37.945502  [   43.980886] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.simple-audio-driver-present: https://kernelci.org/test/=
case/id/6480924f179b01963e306161
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:20:37.952608  /opt/bootrr/libexec/bootrr/boards/ti,am335x=
-bone-black: line 84: assert_device-present: not found
    2023-06-07T14:20:38.967254  /lava-955493/1/../bin/lava-test-case
    2023-06-07T14:20:38.985588  [   45.023135] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsimple-audio-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-audio: https://kernelci.org/test/case/id/6480924f1=
79b01963e306162
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:20:40.010327  /lava-955493/1/../bin/lava-test-case
    2023-06-07T14:20:40.026077  [   46.065192] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio-probed RESULT=3Dblocked>
    2023-06-07T14:20:41.049572  /lava-955493/1/../bin/lava-test-case
    2023-06-07T14:20:41.066483  [   47.105397] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline.dmesg.crit: https://kernelci.org/test/case/id/6480924f179b0196=
3e306164
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)
        1 lines

    2023-06-07T14:20:01.766150  / # =

    2023-06-07T14:20:01.772886  =

    2023-06-07T14:20:01.879488  / # #
    2023-06-07T14:20:01.887595  #
    2023-06-07T14:20:01.990000  / # export SHELL=3D/bin/sh
    2023-06-07T14:20:01.997091  export SHELL=3D/bin/sh
    2023-06-07T14:20:02.099029  / # . /lava-955493/environment
    2023-06-07T14:20:02.106698  . /lava-955493/environment
    2023-06-07T14:20:02.208629  / # /lava-955493/bin/lava-test-runner /lava=
-955493/0
    2023-06-07T14:20:02.214567  /lava-955493/bin/lava-test-runner /lava-955=
493/0 =

    ... (9 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 15         =


  Details:     https://kernelci.org/test/plan/id/64809289722445528e306149

  Results:     24 PASS, 17 FAIL, 2 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/arm/omap2plus_defconfig/gcc-10/lab-b=
roonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/arm/omap2plus_defconfig/gcc-10/lab-b=
roonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.hdmi-audio: https://kernelci.org/test/case/id/648092897=
22445528e30614c
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:21:49.263199  /lava-575550/1/../bin/lava-test-case
    2023-06-07T14:21:49.341308  [   50.538705] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio-probed RESULT=3Dblocked>
    2023-06-07T14:21:50.458407  /lava-575550/1/../bin/lava-test-case
    2023-06-07T14:21:50.502179  [   51.699581] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline.bootrr.simple-audio-driver-present: https://kernelci.org/test/=
case/id/64809289722445528e30614d
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:21:46.948419  /opt/bootrr/libexec/bootrr/boards/ti,am335x=
-bone-black: line 84: assert_device-present: not found
    2023-06-07T14:21:48.059547  /lava-575550/1/../bin/lava-test-case
    2023-06-07T14:21:48.140207  [   49.335968] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsimple-audio-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-codec-driver-present: https://kernelci.org/test/ca=
se/id/64809289722445528e30614e
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:21:45.674035  /lava-575550/1/../bin/lava-test-case
    2023-06-07T14:21:45.717860  [   46.914641] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-06-07T14:21:46.845713  /lava-575550/1/../bin/lava-test-case
    2023-06-07T14:21:46.926580  [   48.122538] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case/id/=
64809289722445528e30614f
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:21:43.362600  /lava-575550/1/../bin/lava-test-case
    2023-06-07T14:21:43.405600  [   44.602370] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-06-07T14:21:44.474931  /lava-575550/1/../bin/lava-test-case
    2023-06-07T14:21:44.552122  [   45.749394] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline.bootrr.tda19988-driver-present: https://kernelci.org/test/case=
/id/64809289722445528e306150
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:21:40.958232  /lava-575550/1/../bin/lava-test-case
    2023-06-07T14:21:41.038284  [   42.234781] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-06-07T14:21:42.163331  /lava-575550/1/../bin/lava-test-case
    2023-06-07T14:21:42.241281  [   43.437749] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.tilcdc-driver-probed: https://kernelci.org/test/case/id=
/64809289722445528e306151
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:21:39.753728  /lava-575550/1/../bin/lava-test-case
    2023-06-07T14:21:39.833886  [   41.029899] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtilcdc-driver-probed RESULT=3Dfail>   =


  * baseline.bootrr.omap-sham-driver-present: https://kernelci.org/test/cas=
e/id/64809289722445528e306156
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:21:36.903586  /lava-575550/1/../bin/lava-test-case
    2023-06-07T14:21:36.991486  [   38.185277] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap-sham-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.omap-aes-driver-present: https://kernelci.org/test/case=
/id/64809289722445528e306159
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:21:34.349392  /lava-575550/1/../bin/lava-test-case
    2023-06-07T14:21:34.393850  [   35.589999] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap-aes-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/test/=
case/id/64809289722445528e30615c
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:21:30.555957  /lava-575550/1/../bin/lava-test-case
    2023-06-07T14:21:30.637579  [   31.833801] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2023-06-07T14:21:31.721735  /lava-575550/1/../bin/lava-test-case
    2023-06-07T14:21:31.808858  [   33.004413] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/64809289722445528e30615d
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:21:29.458288  /lava-575550/1/../bin/lava-test-case
    2023-06-07T14:21:29.494723  [   30.691587] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sdhci-omap-driver-present: https://kernelci.org/test/ca=
se/id/64809289722445528e306165
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:21:24.068939  /lava-575550/1/../bin/lava-test-case
    2023-06-07T14:21:24.146936  [   25.342395] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dbaseboard-eeprom-probed RESULT=3Dblocked>
    2023-06-07T14:21:25.233662  /lava-575550/1/../bin/lava-test-case
    2023-06-07T14:21:25.312409  [   26.508007] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsdhci-omap-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.at24-driver-present: https://kernelci.org/test/case/id/=
64809289722445528e306166
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:21:22.865792  /lava-575550/1/../bin/lava-test-case
    2023-06-07T14:21:22.945637  [   24.141251] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dat24-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.pwrbutton-driver-present: https://kernelci.org/test/cas=
e/id/64809289722445528e306169
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:21:20.260649  /lava-575550/1/../bin/lava-test-case
    2023-06-07T14:21:20.340593  [   21.535791] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dpwrbutton-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.omap8240-driver-present: https://kernelci.org/test/case=
/id/64809289722445528e30616f
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:21:17.420930  /lava-575550/1/../bin/lava-test-case
    2023-06-07T14:21:17.464897  [   18.660568] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap8240-driver-present RESULT=3Dfail>   =


  * baseline.dmesg.crit: https://kernelci.org/test/case/id/6480928972244552=
8e306176
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)
        1 lines

    2023-06-07T14:21:14.130273  / # =

    2023-06-07T14:21:14.137400  =

    2023-06-07T14:21:14.239539  / # #
    2023-06-07T14:21:14.245229  #
    2023-06-07T14:21:14.346727  / # export SHELL=3D/bin/sh
    2023-06-07T14:21:14.352710  export SHELL=3D/bin/sh
    2023-06-07T14:21:14.454325  / # . /lava-575550/environment
    2023-06-07T14:21:14.462162  . /lava-575550/environment
    2023-06-07T14:21:14.563534  / # /lava-575550/bin/lava-test-runner /lava=
-575550/0
    2023-06-07T14:21:14.568865  /lava-575550/bin/lava-test-runner /lava-575=
550/0 =

    ... (9 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 15         =


  Details:     https://kernelci.org/test/plan/id/648096735af5bf77e030614a

  Results:     24 PASS, 17 FAIL, 2 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/arm/omap2plus_defconfig/gcc-10/lab-c=
ip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/arm/omap2plus_defconfig/gcc-10/lab-c=
ip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.omap8240-driver-present: https://kernelci.org/test/case=
/id/648096735af5bf77e0306150
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:38:02.363823  /lava-955516/1/../bin/lava-test-case
    2023-06-07T14:38:02.443369  [   11.987379] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap8240-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.pwrbutton-driver-present: https://kernelci.org/test/cas=
e/id/648096735af5bf77e0306156
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:38:05.141746  /lava-955516/1/../bin/lava-test-case
    2023-06-07T14:38:05.223209  [   14.767010] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dpwrbutton-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.at24-driver-present: https://kernelci.org/test/case/id/=
648096735af5bf77e0306159
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:38:07.681829  /lava-955516/1/../bin/lava-test-case
    2023-06-07T14:38:07.761201  [   17.305498] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dat24-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sdhci-omap-driver-present: https://kernelci.org/test/ca=
se/id/648096735af5bf77e030615a
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:38:08.851918  /lava-955516/1/../bin/lava-test-case
    2023-06-07T14:38:08.931896  [   18.475722] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dbaseboard-eeprom-probed RESULT=3Dblocked>
    2023-06-07T14:38:10.056759  /lava-955516/1/../bin/lava-test-case
    2023-06-07T14:38:10.135974  [   19.679496] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsdhci-omap-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/648096735af5bf77e0306162
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:38:14.086521  /lava-955516/1/../bin/lava-test-case
    2023-06-07T14:38:14.166051  [   23.709448] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/test/=
case/id/648096735af5bf77e0306163
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:38:15.288817  /lava-955516/1/../bin/lava-test-case
    2023-06-07T14:38:15.331211  [   24.875940] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2023-06-07T14:38:16.397834  /lava-955516/1/../bin/lava-test-case
    2023-06-07T14:38:16.442097  [   25.985486] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.omap-aes-driver-present: https://kernelci.org/test/case=
/id/648096735af5bf77e0306166
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:38:18.912588  /lava-955516/1/../bin/lava-test-case
    2023-06-07T14:38:18.991855  [   28.535972] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap-aes-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.omap-sham-driver-present: https://kernelci.org/test/cas=
e/id/648096735af5bf77e0306169
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:38:21.390256  /lava-955516/1/../bin/lava-test-case
    2023-06-07T14:38:21.421041  [   30.965236] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap-sham-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.tilcdc-driver-probed: https://kernelci.org/test/case/id=
/648096735af5bf77e030616e
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:38:24.028548  /lava-955516/1/../bin/lava-test-case
    2023-06-07T14:38:24.109032  [   33.654046] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtilcdc-driver-probed RESULT=3Dfail>   =


  * baseline.bootrr.tda19988-driver-present: https://kernelci.org/test/case=
/id/648096735af5bf77e030616f
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:38:25.231637  /lava-955516/1/../bin/lava-test-case
    2023-06-07T14:38:25.273918  [   34.820553] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-06-07T14:38:26.341666  /lava-955516/1/../bin/lava-test-case
    2023-06-07T14:38:26.385105  [   35.930547] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case/id/=
648096735af5bf77e0306170
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:38:27.452720  /lava-955516/1/../bin/lava-test-case
    2023-06-07T14:38:27.528946  [   37.075136] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-06-07T14:38:28.652455  /lava-955516/1/../bin/lava-test-case
    2023-06-07T14:38:28.732768  [   38.277944] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-codec-driver-present: https://kernelci.org/test/ca=
se/id/648096735af5bf77e0306171
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:38:29.836869  /lava-955516/1/../bin/lava-test-case
    2023-06-07T14:38:29.914954  [   39.460757] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-06-07T14:38:31.039603  /lava-955516/1/../bin/lava-test-case
    2023-06-07T14:38:31.121111  [   40.665855] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.simple-audio-driver-present: https://kernelci.org/test/=
case/id/648096735af5bf77e0306172
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:38:31.141422  /opt/bootrr/libexec/bootrr/boards/ti,am335x=
-bone-black: line 84: assert_device-present: not found
    2023-06-07T14:38:32.249608  /lava-955516/1/../bin/lava-test-case
    2023-06-07T14:38:32.294270  [   41.838865] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsimple-audio-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-audio: https://kernelci.org/test/case/id/648096735=
af5bf77e0306173
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:38:33.359899  /lava-955516/1/../bin/lava-test-case
    2023-06-07T14:38:33.404414  [   42.950039] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio-probed RESULT=3Dblocked>
    2023-06-07T14:38:34.468822  /lava-955516/1/../bin/lava-test-case
    2023-06-07T14:38:34.551224  [   44.097908] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline.dmesg.crit: https://kernelci.org/test/case/id/648096735af5bf77=
e0306175
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)
        1 lines

    2023-06-07T14:37:59.190233  / # =

    2023-06-07T14:37:59.199055  =

    2023-06-07T14:37:59.301936  / # #
    2023-06-07T14:37:59.308267  #
    2023-06-07T14:37:59.409529  / # export SHELL=3D/bin/sh
    2023-06-07T14:37:59.417033  export SHELL=3D/bin/sh
    2023-06-07T14:37:59.518112  / # . /lava-955516/environment
    2023-06-07T14:37:59.527137  . /lava-955516/environment
    2023-06-07T14:37:59.628223  / # /lava-955516/bin/lava-test-runner /lava=
-955516/0
    2023-06-07T14:37:59.635232  /lava-955516/bin/lava-test-runner /lava-955=
516/0 =

    ... (9 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
dell-latitude...4305U-sarien | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648091a19df46930d6306146

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/baseline-dell-latitude-5400-4305U-sarien.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/baseline-dell-latitude-5400-4305U-sarien.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/648091a19df46930d6306=
147
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
dell-latitude...8665U-sarien | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648091c165a368c4da30616d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/baseline-dell-latitude-5400-8665U-sarien.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/baseline-dell-latitude-5400-8665U-sarien.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/648091c165a368c4da306=
16e
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648091bf65a368c4da30613f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/648091bf65a368c4da306=
140
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648091be65a368c4da30613c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/648091be65a368c4da306=
13d
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx28-duckbill               | arm    | lab-pengutronix | gcc-10   | mxs_de=
fconfig                | 1          =


  Details:     https://kernelci.org/test/plan/id/6480902de5a98888d4306146

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: mxs_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/arm/mxs_defconfig/gcc-10/lab-pengutr=
onix/baseline-imx28-duckbill.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/arm/mxs_defconfig/gcc-10/lab-pengutr=
onix/baseline-imx28-duckbill.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6480902de5a98888d4306=
147
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 10         =


  Details:     https://kernelci.org/test/plan/id/64809031e5a98888d4306149

  Results:     11 PASS, 12 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/arm/multi_v7_defconfig/gcc-10/lab-br=
oonie/baseline-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/arm/multi_v7_defconfig/gcc-10/lab-br=
oonie/baseline-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.entnaviv-gpu-driver-present: https://kernelci.org/test/=
case/id/64809031e5a98888d430614c
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:11:40.496232  /lava-575511/1/../bin/lava-test-case
    2023-06-07T14:11:40.511931  [   33.205831] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dipu-probed RESULT=3Dblocked>
    2023-06-07T14:11:41.531041  /lava-575511/1/../bin/lava-test-case
    2023-06-07T14:11:41.547903  [   34.240558] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dentnaviv-gpu-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.imx-ipuv3-driver-present: https://kernelci.org/test/cas=
e/id/64809031e5a98888d430614d
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:11:38.425125  /lava-575511/1/../bin/lava-test-case
    2023-06-07T14:11:38.440855  [   31.134546] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-probed RESULT=3Dblocked>
    2023-06-07T14:11:39.460119  /lava-575511/1/../bin/lava-test-case
    2023-06-07T14:11:39.475916  [   32.169632] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dimx-ipuv3-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.fsl-ssi-driver-present: https://kernelci.org/test/case/=
id/64809031e5a98888d430614e
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:11:30.142840  /lava-575511/1/../bin/lava-test-case
    2023-06-07T14:11:30.158785  [   22.852326] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcaam-jr0-probed RESULT=3Dblocked>
    2023-06-07T14:11:31.178351  /lava-575511/1/../bin/lava-test-case
    2023-06-07T14:11:31.194193  [   23.887435] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcaam-jr1-probed RESULT=3Dblocked>
    2023-06-07T14:11:32.213413  /lava-575511/1/../bin/lava-test-case
    2023-06-07T14:11:32.229973  [   24.922705] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dfsl-ssi-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.caam-jr-driver-present: https://kernelci.org/test/case/=
id/64809031e5a98888d430614f
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:11:28.071746  /lava-575511/1/../bin/lava-test-case
    2023-06-07T14:11:28.087733  [   20.781343] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcaam-probed RESULT=3Dblocked>
    2023-06-07T14:11:29.106852  /lava-575511/1/../bin/lava-test-case
    2023-06-07T14:11:29.123397  [   21.816522] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcaam-jr-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.caam-driver-present: https://kernelci.org/test/case/id/=
64809031e5a98888d4306150
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:11:26.001038  /lava-575511/1/../bin/lava-test-case
    2023-06-07T14:11:26.016305  [   18.710565] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dwatchdog-probed RESULT=3Dblocked>
    2023-06-07T14:11:27.036731  /lava-575511/1/../bin/lava-test-case
    2023-06-07T14:11:27.052441  [   19.745795] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcaam-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.imx2-wdt-driver-present: https://kernelci.org/test/case=
/id/64809031e5a98888d4306151
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:11:24.965372  /lava-575511/1/../bin/lava-test-case
    2023-06-07T14:11:24.981910  [   17.674931] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dimx2-wdt-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.ttymxc3-probed: https://kernelci.org/test/case/id/64809=
031e5a98888d4306158
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:11:23.744162  /lava-575511/1/../bin/lava-test-case
    2023-06-07T14:11:23.760078  [   16.453880] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dttymxc3-probed RESULT=3Dfail>   =


  * baseline.bootrr.fsl-asoc-card-driver-present: https://kernelci.org/test=
/case/id/64809031e5a98888d430615e
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:11:33.249003  /lava-575511/1/../bin/lava-test-case
    2023-06-07T14:11:33.264335  [   25.958232] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dssi-probed RESULT=3Dblocked>
    2023-06-07T14:11:34.283463  /lava-575511/1/../bin/lava-test-case
    2023-06-07T14:11:34.300556  [   26.993141] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dfsl-asoc-card-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.dwhdmi-imx-driver-present: https://kernelci.org/test/ca=
se/id/64809031e5a98888d430615f
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:11:37.389315  /lava-575511/1/../bin/lava-test-case
    2023-06-07T14:11:37.406078  [   30.098911] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddwhdmi-imx-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/64809031e=
5a98888d4306160
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:11:35.319781  /lava-575511/1/../bin/lava-test-case
    2023-06-07T14:11:35.336106  [   28.029320] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsound-card-probed RESULT=3Dblocked>
    2023-06-07T14:11:36.354890  /lava-575511/1/../bin/lava-test-case
    2023-06-07T14:11:36.370128  [   29.064227] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsound-card RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 10         =


  Details:     https://kernelci.org/test/plan/id/64809046e5a98888d43061b0

  Results:     11 PASS, 12 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/arm/multi_v7_defconfig/gcc-10/lab-br=
oonie/baseline-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/arm/multi_v7_defconfig/gcc-10/lab-br=
oonie/baseline-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.entnaviv-gpu-driver-present: https://kernelci.org/test/=
case/id/64809046e5a98888d43061b3
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:11:57.384402  /lava-575518/1/../bin/lava-test-case
    2023-06-07T14:11:57.399285  [   29.633412] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dipu-probed RESULT=3Dblocked>
    2023-06-07T14:11:58.417534  /lava-575518/1/../bin/lava-test-case
    2023-06-07T14:11:58.433750  [   30.666695] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dentnaviv-gpu-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.imx-ipuv3-driver-present: https://kernelci.org/test/cas=
e/id/64809046e5a98888d43061b4
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:11:55.317506  /lava-575518/1/../bin/lava-test-case
    2023-06-07T14:11:55.332544  [   27.566615] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-probed RESULT=3Dblocked>
    2023-06-07T14:11:56.350660  /lava-575518/1/../bin/lava-test-case
    2023-06-07T14:11:56.366565  [   28.599747] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dimx-ipuv3-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.dwhdmi-imx-driver-present: https://kernelci.org/test/ca=
se/id/64809046e5a98888d43061b5
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:11:54.283304  /lava-575518/1/../bin/lava-test-case
    2023-06-07T14:11:54.299540  [   26.532377] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddwhdmi-imx-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/64809046e=
5a98888d43061b6
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:11:52.217209  /lava-575518/1/../bin/lava-test-case
    2023-06-07T14:11:52.232721  [   24.466160] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsound-card-probed RESULT=3Dblocked>
    2023-06-07T14:11:53.250717  /lava-575518/1/../bin/lava-test-case
    2023-06-07T14:11:53.265092  [   25.499476] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsound-card RESULT=3Dfail>   =


  * baseline.bootrr.fsl-asoc-card-driver-present: https://kernelci.org/test=
/case/id/64809046e5a98888d43061b7
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:11:50.149788  /lava-575518/1/../bin/lava-test-case
    2023-06-07T14:11:50.164973  [   22.398892] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dssi-probed RESULT=3Dblocked>
    2023-06-07T14:11:51.183259  /lava-575518/1/../bin/lava-test-case
    2023-06-07T14:11:51.199229  [   23.431920] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dfsl-asoc-card-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.fsl-ssi-driver-present: https://kernelci.org/test/case/=
id/64809046e5a98888d43061b8
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:11:47.049019  /lava-575518/1/../bin/lava-test-case
    2023-06-07T14:11:47.064148  [   19.297890] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcaam-jr0-probed RESULT=3Dblocked>
    2023-06-07T14:11:48.082594  /lava-575518/1/../bin/lava-test-case
    2023-06-07T14:11:48.097672  [   20.331478] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcaam-jr1-probed RESULT=3Dblocked>
    2023-06-07T14:11:49.116154  /lava-575518/1/../bin/lava-test-case
    2023-06-07T14:11:49.132067  [   21.365244] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dfsl-ssi-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.caam-jr-driver-present: https://kernelci.org/test/case/=
id/64809046e5a98888d43061b9
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:11:44.982234  /lava-575518/1/../bin/lava-test-case
    2023-06-07T14:11:44.997104  [   17.230908] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcaam-probed RESULT=3Dblocked>
    2023-06-07T14:11:46.015159  /lava-575518/1/../bin/lava-test-case
    2023-06-07T14:11:46.030628  [   18.264082] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcaam-jr-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.caam-driver-present: https://kernelci.org/test/case/id/=
64809046e5a98888d43061ba
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:11:42.915210  /lava-575518/1/../bin/lava-test-case
    2023-06-07T14:11:42.930778  [   15.164338] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dwatchdog-probed RESULT=3Dblocked>
    2023-06-07T14:11:43.948416  /lava-575518/1/../bin/lava-test-case
    2023-06-07T14:11:43.963760  [   16.197428] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcaam-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.imx2-wdt-driver-present: https://kernelci.org/test/case=
/id/64809046e5a98888d43061bb
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:11:41.881063  /lava-575518/1/../bin/lava-test-case
    2023-06-07T14:11:41.897258  [   14.130403] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dimx2-wdt-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.ttymxc3-probed: https://kernelci.org/test/case/id/64809=
046e5a98888d43061c2
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:11:40.653445  /lava-575518/1/../bin/lava-test-case
    2023-06-07T14:11:40.668435  [   12.902592] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dttymxc3-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
odroid-xu3                   | arm    | lab-collabora   | gcc-10   | exynos=
_defconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/64808eca9141981f09306151

  Results:     4 PASS, 1 FAIL, 2 SKIP
  Full config: exynos_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/arm/exynos_defconfig/gcc-10/lab-coll=
abora/baseline-odroid-xu3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/arm/exynos_defconfig/gcc-10/lab-coll=
abora/baseline-odroid-xu3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.all-cpus-are-online: https://kernelci.org/test/case/id/=
64808eca9141981f09306155
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:06:21.166761  /lava-10624819/1/../bin/lava-test-case

    2023-06-07T14:06:21.182951  [   13.739768] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dall-cpus-are-online RESULT=3Dfail>
   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm-virt-gicv2          | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/648090eff89d0fa4a330612f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/arm/multi_v7_defconfig/gcc-10/lab-br=
oonie/baseline-qemu_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/arm/multi_v7_defconfig/gcc-10/lab-br=
oonie/baseline-qemu_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/648090eff89d0fa4a3306=
130
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm-virt-gicv2          | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64808ff7e3b99a6b62306146

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/arm/multi_v7_defconfig/gcc-10/lab-co=
llabora/baseline-qemu_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/arm/multi_v7_defconfig/gcc-10/lab-co=
llabora/baseline-qemu_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64808ff7e3b99a6b62306=
147
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm-virt-gicv2-uefi     | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6480914009e4521bf9306162

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/arm/multi_v7_defconfig/gcc-10/lab-br=
oonie/baseline-qemu_arm-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/arm/multi_v7_defconfig/gcc-10/lab-br=
oonie/baseline-qemu_arm-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6480914009e4521bf9306=
163
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm-virt-gicv2-uefi     | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/648090e988e217a2d530617c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/arm/multi_v7_defconfig/gcc-10/lab-co=
llabora/baseline-qemu_arm-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/arm/multi_v7_defconfig/gcc-10/lab-co=
llabora/baseline-qemu_arm-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/648090e988e217a2d5306=
17d
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm-virt-gicv3          | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/648090b3d51b83157c30614a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/arm/multi_v7_defconfig/gcc-10/lab-br=
oonie/baseline-qemu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/arm/multi_v7_defconfig/gcc-10/lab-br=
oonie/baseline-qemu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/648090b3d51b83157c306=
14b
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm-virt-gicv3          | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6480900de3b99a6b6230619e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/arm/multi_v7_defconfig/gcc-10/lab-co=
llabora/baseline-qemu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/arm/multi_v7_defconfig/gcc-10/lab-co=
llabora/baseline-qemu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6480900de3b99a6b62306=
19f
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm-virt-gicv3-uefi     | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6480912da0edd132fa306137

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/arm/multi_v7_defconfig/gcc-10/lab-br=
oonie/baseline-qemu_arm-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/arm/multi_v7_defconfig/gcc-10/lab-br=
oonie/baseline-qemu_arm-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6480912da0edd132fa306=
138
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm-virt-gicv3-uefi     | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/648090e8d6d0a944ad306196

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/arm/multi_v7_defconfig/gcc-10/lab-co=
llabora/baseline-qemu_arm-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/arm/multi_v7_defconfig/gcc-10/lab-co=
llabora/baseline-qemu_arm-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/648090e8d6d0a944ad306=
197
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_mips-malta              | mips   | lab-broonie     | gcc-10   | malta_=
defconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/648090f1e24641cc2d30612f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/mips/malta_defconfig/gcc-10/lab-broo=
nie/baseline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/mips/malta_defconfig/gcc-10/lab-broo=
nie/baseline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/648090f1e24641cc2d306=
130
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_mips-malta              | mips   | lab-collabora   | gcc-10   | malta_=
defconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/64809033e5a98888d4306166

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/mips/malta_defconfig/gcc-10/lab-coll=
abora/baseline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/mips/malta_defconfig/gcc-10/lab-coll=
abora/baseline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64809033e5a98888d4306=
167
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-broonie     | gcc-10   | x86_64=
_defconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/6480912beefa5504ce30613a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig/gcc-10/lab-b=
roonie/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig/gcc-10/lab-b=
roonie/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6480912beefa5504ce306=
13b
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-broonie     | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64809257179b01963e306177

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-broonie/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-broonie/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64809257179b01963e306=
178
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/648090ade62d2790033061a8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig/gcc-10/lab-c=
ollabora/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig/gcc-10/lab-c=
ollabora/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/648090ade62d279003306=
1a9
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648091c5873488f3bd30614f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/648091c5873488f3bd306=
150
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64808f7153de227dd9306181

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/arm/shmobile_defconfig/gcc-10/lab-ci=
p/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/arm/shmobile_defconfig/gcc-10/lab-ci=
p/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64808f7153de227dd9306=
182
        failing since 1 day (last pass: v6.1.26-1314-g1ab0ac1d7e2e3, first =
fail: v6.1.26-1321-g3152fb7c8d2d6) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3288-rock2-square          | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 2          =


  Details:     https://kernelci.org/test/plan/id/64808fe29fa2185af230612e

  Results:     7 PASS, 2 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/arm/multi_v7_defconfig/gcc-10/lab-co=
llabora/baseline-rk3288-rock2-square.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/arm/multi_v7_defconfig/gcc-10/lab-co=
llabora/baseline-rk3288-rock2-square.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-pm-domain-driver-present: https://kernelci.org=
/test/case/id/64808fe29fa2185af2306133
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:10:54.957746  /lava-10624834/1/../bin/lava-test-case

    2023-06-07T14:10:54.981668  [   13.130105] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk3288-crypto-probed RESULT=3Dblocked>

    2023-06-07T14:10:56.003974  /lava-10624834/1/../bin/lava-test-case

    2023-06-07T14:10:56.043798  [   14.192637] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-pm-domain-driver-present RESULT=3Dfail>
   =


  * baseline.bootrr.rk3288-crypto-driver-present: https://kernelci.org/test=
/case/id/64808fe29fa2185af2306134
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:10:53.865439  /lava-10624834/1/../bin/lava-test-case

    2023-06-07T14:10:53.903330  [   12.051910] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk3288-crypto-driver-present RESULT=3Dfail>
   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 22         =


  Details:     https://kernelci.org/test/plan/id/64808ff69fa2185af2306161

  Results:     37 PASS, 22 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/arm/multi_v7_defconfig/gcc-10/lab-co=
llabora/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/arm/multi_v7_defconfig/gcc-10/lab-co=
llabora/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-pm-domain-driver-present: https://kernelci.org=
/test/case/id/64808ff69fa2185af2306166
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:11:29.947012  [   45.858557] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk3288-crypto-driver-present RESULT=3Dfail>

    2023-06-07T14:11:30.990028  /lava-10624839/1/../bin/lava-test-case

    2023-06-07T14:11:31.028496  [   46.940469] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk3288-crypto-probed RESULT=3Dblocked>

    2023-06-07T14:11:32.082961  /lava-10624839/1/../bin/lava-test-case

    2023-06-07T14:11:32.122746  [   48.034192] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-pm-domain-driver-present RESULT=3Dfail>
   =


  * baseline.bootrr.rk3288-crypto-driver-present: https://kernelci.org/test=
/case/id/64808ff69fa2185af2306167
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:11:29.907126  /lava-10624839/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-vopl-probed: https://kernelci.org/test/case/id=
/64808ff69fa2185af2306168
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:11:27.708750  [   43.620763] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-vopb-probed RESULT=3Dfail>

    2023-06-07T14:11:28.782347  /lava-10624839/1/../bin/lava-test-case

    2023-06-07T14:11:28.821602  [   44.733932] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-vopl-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-vopb-probed: https://kernelci.org/test/case/id=
/64808ff69fa2185af2306169
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:11:26.654115  [   42.564826] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-vop-driver-present RESULT=3Dpass>

    2023-06-07T14:11:27.670151  /lava-10624839/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb-phy-grf-probed: https://kernelci.org/test/=
case/id/64808ff69fa2185af230616b
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:11:25.511759  [   41.422872] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-usb-phy-driver-present RESULT=3Dpass>

    2023-06-07T14:11:26.531520  /lava-10624839/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-pwm0-probed: https://kernelci.org/test/case/id=
/64808ff69fa2185af2306173
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:11:24.214659  [   40.126011] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-pwm-driver-present RESULT=3Dpass>

    2023-06-07T14:11:25.246390  /lava-10624839/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-iodomain-driver-present: https://kernelci.org/=
test/case/id/64808ff69fa2185af2306175
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:11:20.911405  [   36.822832] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockcip-i2s-driver-present RESULT=3Dfail>

    2023-06-07T14:11:21.929746  /lava-10624839/1/../bin/lava-test-case

    2023-06-07T14:11:21.968653  [   37.880419] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-i2s-probed RESULT=3Dblocked>

    2023-06-07T14:11:23.024551  /lava-10624839/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockcip-i2s-driver-present: https://kernelci.org/test/c=
ase/id/64808ff69fa2185af2306176
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:11:18.748673  [   34.659652] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-dp-phy-driver-present RESULT=3Dfail>

    2023-06-07T14:11:19.802625  /lava-10624839/1/../bin/lava-test-case

    2023-06-07T14:11:19.841867  [   35.752958] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-dp-phy-grf-probed RESULT=3Dblocked>

    2023-06-07T14:11:20.871882  /lava-10624839/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-dp-phy-driver-present: https://kernelci.org/te=
st/case/id/64808ff69fa2185af2306177
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:11:17.648665  /lava-10624839/1/../bin/lava-test-case

    2023-06-07T14:11:17.675804  [   33.587375] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-dp-edp-probed RESULT=3Dblocked>

    2023-06-07T14:11:18.709149  /lava-10624839/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-dp-driver-present: https://kernelci.org/test/c=
ase/id/64808ff69fa2185af2306178
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:11:16.564210  /lava-10624839/1/../bin/lava-test-case

    2023-06-07T14:11:16.602567  [   32.514193] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-dp-driver-present RESULT=3Dfail>
   =


  * baseline.bootrr.rk_iommu-vpu_mmu-probed: https://kernelci.org/test/case=
/id/64808ff69fa2185af2306179
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:11:14.466938  [   30.378221] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk_iommu-vopl_mmu-probed RESULT=3Dfail>

    2023-06-07T14:11:15.500010  /lava-10624839/1/../bin/lava-test-case

    2023-06-07T14:11:15.539599  [   31.451497] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk_iommu-vpu_mmu-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rk_iommu-vopl_mmu-probed: https://kernelci.org/test/cas=
e/id/64808ff69fa2185af230617a
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:11:13.371393  [   29.282758] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk_iommu-vopb_mmu-probed RESULT=3Dfail>

    2023-06-07T14:11:14.429904  /lava-10624839/1/../bin/lava-test-case
   =


  * baseline.bootrr.rk_iommu-vopb_mmu-probed: https://kernelci.org/test/cas=
e/id/64808ff69fa2185af230617b
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:11:12.316836  [   28.228208] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk_iommu-driver-present RESULT=3Dpass>

    2023-06-07T14:11:13.332578  /lava-10624839/1/../bin/lava-test-case
   =


  * baseline.bootrr.ramoops-driver-present: https://kernelci.org/test/case/=
id/64808ff69fa2185af2306183
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:11:10.011627  [   25.922126] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dehci-platform-usb_host0_ehci-probed RESULT=3Dpass>

    2023-06-07T14:11:11.025059  /lava-10624839/1/../bin/lava-test-case
   =


  * baseline.bootrr.dwmmc_rockchip-sdio0-probed: https://kernelci.org/test/=
case/id/64808ff69fa2185af2306187
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:11:08.795220  [   24.706438] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddwmmc_rockchip-sdmmc-probed RESULT=3Dpass>

    2023-06-07T14:11:09.815608  /lava-10624839/1/../bin/lava-test-case

    2023-06-07T14:11:09.854097  [   25.765056] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddwmmc_rockchip-sdio0-probed RESULT=3Dfail>
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/64808ff69fa2185af230618a
        failing since 138 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-06-07T14:11:08.679682  [   24.589907] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddwhdmi-rockchip-driver-audio-present RESULT=3Dfail>

    2023-06-07T14:11:08.714150  BusyBox v1.31.1 (2023-05-27 14:14:16 UTC) m=
ulti-call binary.

    2023-06-07T14:11:08.714370  =

   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/64808ff69fa2185af230618b
        failing since 138 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-06-07T14:11:08.595310  [   24.506765] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dfail>

    2023-06-07T14:11:08.638285  BusyBox v1.31.1 (2023-05-27 14:14:16 UTC) m=
ulti-call binary.

    2023-06-07T14:11:08.638433  =


    2023-06-07T14:11:08.642353  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-06-07T14:11:08.642582  =


    2023-06-07T14:11:08.647120  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-06-07T14:11:08.649396  FIRST, INC default to 1.

    2023-06-07T14:11:08.649455  =


    2023-06-07T14:11:08.652674  	-w	Pad to last with leading zeros

    2023-06-07T14:11:08.654935  	-s SEP	String separator
 =

    ... (1 line(s) more)  =


  * baseline.bootrr.dwhdmi-rockchip-probed: https://kernelci.org/test/case/=
id/64808ff69fa2185af230618c
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:11:07.535966  [   23.446762] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddwhdmi-rockchip-driver-present RESULT=3Dpass>

    2023-06-07T14:11:08.556163  /lava-10624839/1/../bin/lava-test-case
   =


  * baseline.bootrr.dw_wdt-driver-present: https://kernelci.org/test/case/i=
d/64808ff69fa2185af2306191
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:11:05.269565  [   21.181339] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddw-apb-uart2-probed RESULT=3Dpass>

    2023-06-07T14:11:06.284091  /lava-10624839/1/../bin/lava-test-case
   =


  * baseline.bootrr.cros-ec-keyb-probed: https://kernelci.org/test/case/id/=
64808ff69fa2185af2306196
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:11:04.111484  [   20.022299] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcros-ec-keyb-driver-present RESULT=3Dpass>

    2023-06-07T14:11:05.131821  /lava-10624839/1/../bin/lava-test-case
   =


  * baseline.bootrr.cros-ec-i2c-tunnel-driver-present: https://kernelci.org=
/test/case/id/64808ff69fa2185af2306198
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:11:00.817115  [   16.728008] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcros-ec-dev-driver-present RESULT=3Dfail>

    2023-06-07T14:11:01.314046  [   17.222344] asix 3-1:1.0 eth0: register =
'asix' at usb-ff580000.usb-1, ASIX AX88772B USB 2.0 Ethernet, 00:6f:00:09:0=
8:66

    2023-06-07T14:11:01.336453  [   17.248284] dwmmc_rockchip ff0d0000.dwmm=
c: IDMAC supports 32-bit address mode.

    2023-06-07T14:11:01.345791  [   17.258102] dwmmc_rockchip ff0d0000.dwmm=
c: Using internal DMA controller.

    2023-06-07T14:11:01.351954  [   17.265231] dwmmc_rockchip ff0d0000.dwmm=
c: Version ID is 270a

    2023-06-07T14:11:01.361931  [   17.271241] dwmmc_rockchip ff0d0000.dwmm=
c: DW MMC controller at irq 30,32 bit host data width,256 deep fifo

    2023-06-07T14:11:01.873273  /lava-10624839/1/../bin/lava-test-case

    2023-06-07T14:11:01.913369  [   17.824626] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcros-ec-dev-probed RESULT=3Dblocked>

    2023-06-07T14:11:02.935293  /lava-10624839/1/../bin/lava-test-case
   =


  * baseline.bootrr.cros-ec-dev-driver-present: https://kernelci.org/test/c=
ase/id/64808ff69fa2185af2306199
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:10:59.753813  [   15.665401] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtpm-chip-is-online RESULT=3Dskip>

    2023-06-07T14:10:59.980947  [   15.895334] dwc2 ff580000.usb: DWC OTG C=
ontroller

    2023-06-07T14:10:59.987947  [   15.900093] dwc2 ff580000.usb: new USB b=
us registered, assigned bus number 3

    2023-06-07T14:10:59.993377  [   15.907178] dwc2 ff580000.usb: irq 43, i=
o mem 0x00000000

    2023-06-07T14:10:59.997861  [   15.913137] hub 3-0:1.0: USB hub found

    2023-06-07T14:11:00.001951  [   15.916939] hub 3-0:1.0: 1 port detected

    2023-06-07T14:11:00.011825  [   15.923649] dwmmc_rockchip ff0d0000.dwmm=
c: IDMAC supports 32-bit address mode.

    2023-06-07T14:11:00.018745  [   15.931034] dwmmc_rockchip ff0d0000.dwmm=
c: Using internal DMA controller.

    2023-06-07T14:11:00.024559  [   15.937846] dwmmc_rockchip ff0d0000.dwmm=
c: Version ID is 270a

    2023-06-07T14:11:00.034273  [   15.943623] dwmmc_rockchip ff0d0000.dwmm=
c: DW MMC controller at irq 30,32 bit host data width,256 deep fifo
 =

    ... (2 line(s) more)  =

 =20

