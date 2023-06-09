Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5A0C7EE25
	for <webhook@archiver.kernel.org>; Fri,  9 Jun 2023 18:09:34 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.web10.1772.1686334169952650516
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 09 Jun 2023 11:09:30 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=u6vuAPgN;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.173, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1b04706c974so10137125ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 09 Jun 2023 11:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686334169; x=1688926169;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ONH7mjnyVVcqCz6xS9iEI999NyChEHVH6nQBQ4JLzI4=;
        b=u6vuAPgN/F0n4lYSUm4COoXDUC89L2sO37WF2Ikx4KefT1xluF2ngGq+kizaJUiu01
         T3637ewC21VonHv2GidklfzKsqt6Mj7DNshJ0EftmVzD+okeswnxRXcQlRRTX12VqXZg
         ubaIDRtRTdHTfdz9VyUKWD4IGhU1dVIIDnhPqzC76s4/11n6SRF39u8prrdyhbA1n0gd
         FwemwcNiGl7WQBiadwUkxMVrsfZa4oy0SJsRn0+Hkb22hmVILcai/N6Hjozqe443yiFq
         FAtBBR2n3U4UB9ii7RbUVnnR/9mayq8bKnDjW9F5KW7VAzRrEygjvJW+NQA+y/8IwA+M
         PLtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686334169; x=1688926169;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ONH7mjnyVVcqCz6xS9iEI999NyChEHVH6nQBQ4JLzI4=;
        b=JaudTtoM5g+q1MDWa4WK0ZHDuu/D46C0VmyCoWWZIe0eXAYiSRXwcrtWSCTIPQB8hR
         U8MmXo48OGAcQp89DPKWhqwq0d1OvTWPGU0dOORFhNl8Q2eY5U1i8iFsuP+O+jsLQwjL
         hB8ot/tnX2FSovSAD1V5qKIPObWrPyxVLyDzMZPEs7updCcD+oQZz3eyfI4CrKDWnrHO
         9virA2wA+oTL6zdJq1+hBA6gwaN+IaeVUTVmRvOpjDTHG2agrWe/Q4zKboUY358nzSLp
         3NIvYUhFuPhJgZpTklb4n4NtmAbVusxaen0iaW24+O9MZpncXVKPfZ35JGy8nRnHB5s0
         yJtQ==
X-Gm-Message-State: AC+VfDyoH/9nEP9M7yFT2uSU4dKgpzysEcch94llUqNe3UwflrU7D/Dc
	cEIOlNVBE8mAl18zfVl/dBnZ/ASzq6gCw2r4DVyhNQ==
X-Google-Smtp-Source: ACHHUZ6WnFxLG9xGdNNWhQPaKPSeTcrIop9y/UADjdK8mB/BKxcHrRMOOs3UM1Bt8kii9Pzm7ycTkA==
X-Received: by 2002:a17:902:704b:b0:1b0:4502:8547 with SMTP id h11-20020a170902704b00b001b045028547mr1841622plt.35.1686334168455;
        Fri, 09 Jun 2023 11:09:28 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t12-20020a170902b20c00b001ac741dfd29sm3527803plr.295.2023.06.09.11.09.27
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 11:09:27 -0700 (PDT)
Message-ID: <64836ad7.170a0220.5087b.785c@mx.google.com>
Date: Fri, 09 Jun 2023 11:09:27 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.283-cip98-1248-gcaf6e8ee921e9
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 25 runs,
 14 regressions (v4.19.283-cip98-1248-gcaf6e8ee921e9)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Jun 2023 18:09:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11952

cip-gitlab/ci/pavel/linux-test baseline-nfs: 25 runs, 14 regressions (v4.19=
.283-cip98-1248-gcaf6e8ee921e9)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
acer-cb317-1h-c3z6-dedede | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =

beaglebone-black          | arm    | lab-broonie   | gcc-10   | omap2plus_d=
efconfig          | 5          =

beaglebone-black          | arm    | lab-cip       | gcc-10   | omap2plus_d=
efconfig          | 5          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.283-cip98-1248-gcaf6e8ee921e9/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.283-cip98-1248-gcaf6e8ee921e9
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      caf6e8ee921e9e7714b8669fc9187fcd56d5a5e6 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
acer-cb317-1h-c3z6-dedede | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6483618f99974ae42830613a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.283-cip98-1248-gcaf6e8ee921e9/x86_64/x86_64_defconfig+x86-chromebook=
/gcc-10/lab-collabora/baseline-nfs-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.283-cip98-1248-gcaf6e8ee921e9/x86_64/x86_64_defconfig+x86-chromebook=
/gcc-10/lab-collabora/baseline-nfs-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6483618f99974ae42=
830613b
        failing since 2 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64835fed9c2f067c2830615a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.283-cip98-1248-gcaf6e8ee921e9/x86_64/x86_64_defconfig+x86-chromebook=
/gcc-10/lab-collabora/baseline-nfs-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.283-cip98-1248-gcaf6e8ee921e9/x86_64/x86_64_defconfig+x86-chromebook=
/gcc-10/lab-collabora/baseline-nfs-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64835fed9c2f067c2=
830615b
        failing since 2 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64835f62e124813a7930612f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.283-cip98-1248-gcaf6e8ee921e9/x86_64/x86_64_defconfig+x86-chromebook=
/gcc-10/lab-collabora/baseline-nfs-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.283-cip98-1248-gcaf6e8ee921e9/x86_64/x86_64_defconfig+x86-chromebook=
/gcc-10/lab-collabora/baseline-nfs-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64835f62e124813a7=
9306130
        failing since 2 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6483636a36f6a8368d306164

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.283-cip98-1248-gcaf6e8ee921e9/arm/multi_v7_defconfig/gcc-10/lab-broo=
nie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.283-cip98-1248-gcaf6e8ee921e9/arm/multi_v7_defconfig/gcc-10/lab-broo=
nie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6483636a36f6a8368=
d306165
        failing since 2 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | omap2plus_d=
efconfig          | 5          =


  Details:     https://kernelci.org/test/plan/id/64835f0333d0da88c03061a8

  Results:     42 PASS, 9 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.283-cip98-1248-gcaf6e8ee921e9/arm/omap2plus_defconfig/gcc-10/lab-bro=
onie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.283-cip98-1248-gcaf6e8ee921e9/arm/omap2plus_defconfig/gcc-10/lab-bro=
onie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.omap-sham-driver-present: https://kernelci.org/test=
/case/id/64835f0333d0da88c03061b9
        failing since 2 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77)

    2023-06-09T17:18:36.585868  /lava-589850/1/../bin/lava-test-case
    2023-06-09T17:18:36.729696  [   81.977602] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap-sham-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.omap-aes-driver-present: https://kernelci.org/test/=
case/id/64835f0333d0da88c03061bc
        failing since 2 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77)

    2023-06-09T17:18:33.803938  /lava-589850/1/../bin/lava-test-case
    2023-06-09T17:18:33.921481  [   79.168050] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap-aes-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/t=
est/case/id/64835f0333d0da88c03061bf
        failing since 2 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77)

    2023-06-09T17:18:28.953978  /lava-589850/1/../bin/lava-test-case
    2023-06-09T17:18:29.061839  [   74.308863] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2023-06-09T17:18:30.156423  /lava-589850/1/../bin/lava-test-case
    2023-06-09T17:18:30.269203  [   75.515387] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/64835f0333d0da88c03061c0
        failing since 2 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77)

    2023-06-09T17:18:27.742368  /lava-589850/1/../bin/lava-test-case
    2023-06-09T17:18:27.851574  [   73.097822] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/64835f0333d0=
da88c03061de
        failing since 2 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77)
        1 lines

    2023-06-09T17:17:58.721845  / # =

    2023-06-09T17:17:58.729910  =

    2023-06-09T17:18:03.792131  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/589850/extract-nfsrootfs-d7ws9vwv'
    2023-06-09T17:18:03.803177  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/589850/extract-nfsrootfs-d7ws9vwv'
    2023-06-09T17:18:06.124355  / # export NFS_SERVER_IP=3D'192.168.56.193'
    2023-06-09T17:18:06.135370  export NFS_SERVER_IP=3D'192.168.56.193'
    2023-06-09T17:18:06.248770  / # #
    2023-06-09T17:18:06.255081  #
    2023-06-09T17:18:06.375709  / # export SHELL=3D/bin/sh
    2023-06-09T17:18:06.380780  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-cip       | gcc-10   | omap2plus_d=
efconfig          | 5          =


  Details:     https://kernelci.org/test/plan/id/64835e61ed9c295cde30612e

  Results:     42 PASS, 9 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.283-cip98-1248-gcaf6e8ee921e9/arm/omap2plus_defconfig/gcc-10/lab-cip=
/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.283-cip98-1248-gcaf6e8ee921e9/arm/omap2plus_defconfig/gcc-10/lab-cip=
/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/64835e61ed9c295cde30614b
        failing since 2 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77)

    2023-06-09T17:15:42.188138  /lava-958322/1/../bin/lava-test-case
    2023-06-09T17:15:42.392618  <8>[   61.214759] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/t=
est/case/id/64835e61ed9c295cde30614c
        failing since 2 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77)

    2023-06-09T17:15:43.502494  /lava-958322/1/../bin/lava-test-case
    2023-06-09T17:15:43.704439  <8>[   62.525670] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2023-06-09T17:15:44.806024  /lava-958322/1/../bin/lava-test-case
    2023-06-09T17:15:45.021743  <8>[   63.842962] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.omap-aes-driver-present: https://kernelci.org/test/=
case/id/64835e61ed9c295cde30614f
        failing since 2 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77)

    2023-06-09T17:15:47.988445  /lava-958322/1/../bin/lava-test-case
    2023-06-09T17:15:48.194602  <8>[   67.016182] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Domap-aes-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.omap-sham-driver-present: https://kernelci.org/test=
/case/id/64835e61ed9c295cde306152
        failing since 2 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77)

    2023-06-09T17:15:51.165134  /lava-958322/1/../bin/lava-test-case
    2023-06-09T17:15:51.410472  <8>[   70.231917] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Domap-sham-driver-present RESULT=3Dfail>   =


  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/64835e61ed9c=
295cde306162
        failing since 2 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77)
        1 lines

    2023-06-09T17:15:20.462236  / # =

    2023-06-09T17:15:20.471390  =

    2023-06-09T17:15:25.496817  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/958322/extract-nfsrootfs-nzh8lwe9'
    2023-06-09T17:15:25.507743  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/958322/extract-nfsrootfs-nzh8lwe9'
    2023-06-09T17:15:27.568141  / # export NFS_SERVER_IP=3D'172.16.3.3'
    2023-06-09T17:15:27.579050  export NFS_SERVER_IP=3D'172.16.3.3'
    2023-06-09T17:15:27.693590  / # #
    2023-06-09T17:15:27.701038  #
    2023-06-09T17:15:27.810663  / # export SHELL=3D/bin/sh
    2023-06-09T17:15:27.818304  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =20

