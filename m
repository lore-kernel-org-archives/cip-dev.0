Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49964C761A6
	for <webhook@archiver.kernel.org>; Tue,  4 Apr 2023 10:48:11 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.web11.98133.1680605288162962561
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 04 Apr 2023 03:48:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=vsmjI5hD;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.182, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f182.google.com with SMTP id cm5so15330498pfb.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 04 Apr 2023 03:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1680605287;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MFPifOrsz+u7Z69J2C6gDnlQhOZs2HzRW1SSHFEQrEU=;
        b=vsmjI5hDNuOc8lVlWDoCXSeQG+rZ0LMjx6IL4+odnL9JcCfzyx5bNa8jd+JbJ+8FQv
         i62F0n3aBsUsBOpgI60xDU0+6XINKnM4XQWfDtaruplGerfJynJNMFXRIGbN254o7Lpb
         2EOReZfTpDgNC1jLnXBWr+tOyMaO9UJhf37QIzkby15qvhVmGeGzkqqKRPm0ii8bNg7c
         PWiqSG5ipa6d78BK1C+K8I10MF/F9/+MizuVNUoA6qwhepAcIO4sYN7VxlGM82vv9XBz
         C9ka3xQTWGGzxHypSckMK/6lU+2B7+JPvtQzpLkk+TW/OtL0cz3O3oMC4I8iNte5AiqG
         86UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680605287;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MFPifOrsz+u7Z69J2C6gDnlQhOZs2HzRW1SSHFEQrEU=;
        b=Lf5Kbc8A5b0sGgnXdp/52e105+AQBx5YiaKsC6Cj6emNyyLGh3QSQdi4dLKg/oSPOj
         ZRcaYNBJ05YqyXjj+drYBmBHzyCHOMcqiu+B7bOWTQSGOJ2q0iN4tjtKJ2ritcRNd3ll
         gQyo8zbtjo3MqjpTBk91BpH8+QoA2m3rl9L/C2K4c070Lh4LcvW1hdSdfveSx9vbWdAg
         HW/gkcxFjDdMzfJTRbdlMbWrlQF54O6H7XjDt76HsuvkEFO7GuLOYWjb+9RZqUtSuueF
         evTgjYgmk5QLw53oAFy4Wulc5iZxPi7UMfXsGPkVfbgTH814qKsWGWTqOGImkjXlfmeZ
         Qs4Q==
X-Gm-Message-State: AAQBX9cSzCYX2RGABjdqxeau3NSmIiSoZl4eq7FtAPDYlUt20zlW6BK0
	cm1B/Ag6GbqeKT3ZepGUkN71ECjwPTlKam5qmaEiuw==
X-Google-Smtp-Source: AKy350Z5jdhUi14LeCJkimuOdODCtg7zLDdIkNhjnON2rR2ttri2ngv2odoTxlNo03M09j5C4hQxpw==
X-Received: by 2002:aa7:9478:0:b0:625:a012:a59c with SMTP id t24-20020aa79478000000b00625a012a59cmr1911574pfq.9.1680605286782;
        Tue, 04 Apr 2023 03:48:06 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p3-20020a634f43000000b0050f85ef50d1sm7407219pgl.26.2023.04.04.03.48.06
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 03:48:06 -0700 (PDT)
Message-ID: <642c0066.630a0220.a3b23.e58b@mx.google.com>
Date: Tue, 04 Apr 2023 03:48:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip74-rt43
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 20 runs,
 37 regressions (v4.4.302-cip74-rt43)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Apr 2023 10:48:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11163

cip-gitlab/ci/pavel/linux-test baseline-nfs: 20 runs, 37 regressions (v4.4.=
302-cip74-rt43)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 8          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 15         =

dell-latitude...4305U-sarien | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

dell-latitude...8665U-sarien | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-14-db0003na-grunt         | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip74-rt43/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip74-rt43
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      22456e8b8d35c6bd1313511bfa4dd945ce7a0c1e =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/642bf96b306f07b97e79e928

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230331.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/642bf96b306f07b97=
e79e929
        new failure (last pass: v5.10.175-cip29-rt12) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/642bfa52afba35e18779e92a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230331.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/642bfa52afba35e18=
779e92b
        failing since 12 days (last pass: v4.19.277-cip94-1098-g26d9f86d942=
d, first fail: v5.10.175-cip29-rt12) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/642bf9743c00286a3279e932

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230331.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/642bf9743c00286a3=
279e933
        failing since 13 days (last pass: v5.10.168-cip27-456-g42a59c4e5329=
, first fail: v4.19.277-cip94-1098-g26d9f86d942d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/642bf93bc6979b3cb779e922

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230331.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/642bf93bc6979b3cb=
779e923
        new failure (last pass: v5.10.175-cip29-rt12) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/642bf95e4175c58fc679e92d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230331.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/642bf95e4175c58fc=
679e92e
        new failure (last pass: v5.10.175-cip29-rt12) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/642bf963909fed10bf79e92d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230331.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/642bf963909fed10b=
f79e92e
        failing since 13 days (last pass: v5.10.168-cip27-456-g42a59c4e5329=
, first fail: v4.19.277-cip94-1098-g26d9f86d942d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 8          =


  Details:     https://kernelci.org/test/plan/id/642bf8c572bd39bec179e988

  Results:     15 PASS, 21 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs=
-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs=
-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230331.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.simple-audio-driver-present: https://kernelci.org/t=
est/case/id/642bf8c572bd39bec179e98c
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:14:49.010982  /opt/bootrr/libexec/bootrr/boards/ti,am335x=
-bone-black: 84: assert_device-present: not found
    2023-04-04T10:14:50.038904  /lava-272396/1/../bin/lava-test-case
    2023-04-04T10:14:50.080702  [   98.850025] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsimple-audio-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/t=
est/case/id/642bf8c572bd39bec179e999
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:14:29.775928  /lava-272396/1/../bin/lava-test-case
    2023-04-04T10:14:29.845095  [   78.614364] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2023-04-04T10:14:30.889475  /lava-272396/1/../bin/lava-test-case
    2023-04-04T10:14:30.948710  [   79.717244] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.am335x-phy-driver-present: https://kernelci.org/tes=
t/case/id/642bf8c572bd39bec179e99d
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:14:24.023582  /lava-272396/1/../bin/lava-test-case
    2023-04-04T10:14:24.076234  [   72.845162] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dusb0-musb-dsps-probed RESULT=3Dblocked>
    2023-04-04T10:14:25.116900  /lava-272396/1/../bin/lava-test-case
    2023-04-04T10:14:25.171309  [   73.940008] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dusb1-musb-dsps-probed RESULT=3Dblocked>
    2023-04-04T10:14:26.207349  /lava-272396/1/../bin/lava-test-case
    2023-04-04T10:14:26.260008  [   75.028481] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dam335x-phy-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.musb-dsps-driver-present: https://kernelci.org/test=
/case/id/642bf8c572bd39bec179e99e
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:14:20.698718  /lava-272396/1/../bin/lava-test-case
    2023-04-04T10:14:20.758145  [   69.527891] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmmc0-probed RESULT=3Dblocked>
    2023-04-04T10:14:21.796025  /lava-272396/1/../bin/lava-test-case
    2023-04-04T10:14:21.892589  [   70.662271] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmmc1-probed RESULT=3Dblocked>
    2023-04-04T10:14:22.929295  /lava-272396/1/../bin/lava-test-case
    2023-04-04T10:14:22.983693  [   71.752424] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmusb-dsps-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sdhci-omap-driver-present: https://kernelci.org/tes=
t/case/id/642bf8c572bd39bec179e99f
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:14:19.596767  /lava-272396/1/../bin/lava-test-case
    2023-04-04T10:14:19.660809  [   68.429353] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsdhci-omap-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tps65217-driver-present: https://kernelci.org/test/=
case/id/642bf8c572bd39bec179e9a5
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:14:14.706558  /lava-272396/1/../bin/lava-test-case
    2023-04-04T10:14:14.767090  [   63.535823] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtps65217-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.omap8240-driver-present: https://kernelci.org/test/=
case/id/642bf8c572bd39bec179e9a9
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:14:10.699175  /lava-272396/1/../bin/lava-test-case
    2023-04-04T10:14:11.785523  [   60.554034] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap8240-driver-present RESULT=3Dfail>   =


  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/642bf8c572bd=
39bec179e9b0
        new failure (last pass: v5.10.175-cip29-rt12)
        1 lines

    2023-04-04T10:13:59.966848  / # =

    2023-04-04T10:13:59.973753  =

    2023-04-04T10:14:04.986829  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/272396/extract-nfsrootfs-y518k3_a'
    2023-04-04T10:14:04.997725  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/272396/extract-nfsrootfs-y518k3_a'
    2023-04-04T10:14:07.228476  / # export NFS_SERVER_IP=3D'192.168.56.75'
    2023-04-04T10:14:07.239219  export NFS_SERVER_IP=3D'192.168.56.75'
    2023-04-04T10:14:07.343240  / # #
    2023-04-04T10:14:07.350314  #
    2023-04-04T10:14:07.452400  / # export SHELL=3D/bin/sh
    2023-04-04T10:14:07.459334  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 15         =


  Details:     https://kernelci.org/test/plan/id/642bf81c53b0fa802e79e925

  Results:     24 PASS, 17 FAIL, 2 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nf=
s-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nf=
s-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230331.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.hdmi-audio: https://kernelci.org/test/case/id/642bf=
81d53b0fa802e79e928
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:12:23.600448  /lava-272347/1/../bin/lava-test-case
    2023-04-04T10:12:23.698634  [  231.843538] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio-probed RESULT=3Dblocked>
    2023-04-04T10:12:24.816466  /lava-272347/1/../bin/lava-test-case
    2023-04-04T10:12:24.915898  [  233.061793] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline-nfs.bootrr.simple-audio-driver-present: https://kernelci.org/t=
est/case/id/642bf81d53b0fa802e79e929
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:12:21.357387  /opt/bootrr/libexec/bootrr/boards/ti,am335x=
-bone-black: 84: assert_device-present: not found
    2023-04-04T10:12:22.460169  /lava-272347/1/../bin/lava-test-case
    2023-04-04T10:12:22.527011  [  230.671346] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsimple-audio-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-codec-driver-present: https://kernelci.org/tes=
t/case/id/642bf81d53b0fa802e79e92a
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:12:20.003581  /lava-272347/1/../bin/lava-test-case
    2023-04-04T10:12:20.113204  [  228.258567] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-04-04T10:12:21.233614  /lava-272347/1/../bin/lava-test-case
    2023-04-04T10:12:21.332203  [  229.476637] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case=
/id/642bf81d53b0fa802e79e92b
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:12:17.589699  /lava-272347/1/../bin/lava-test-case
    2023-04-04T10:12:17.696253  [  225.842163] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-04-04T10:12:18.783235  /lava-272347/1/../bin/lava-test-case
    2023-04-04T10:12:18.877293  [  227.023245] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tda19988-driver-present: https://kernelci.org/test/=
case/id/642bf81d53b0fa802e79e92c
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:12:15.176588  /lava-272347/1/../bin/lava-test-case
    2023-04-04T10:12:15.270760  [  223.416797] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-04-04T10:12:16.391167  /lava-272347/1/../bin/lava-test-case
    2023-04-04T10:12:16.490787  [  224.635451] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tilcdc-driver-probed: https://kernelci.org/test/cas=
e/id/642bf81d53b0fa802e79e92d
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:12:13.954182  /lava-272347/1/../bin/lava-test-case
    2023-04-04T10:12:14.056445  [  222.201650] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtilcdc-driver-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.omap-sham-driver-present: https://kernelci.org/test=
/case/id/642bf81d53b0fa802e79e932
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:12:11.038827  /lava-272347/1/../bin/lava-test-case
    2023-04-04T10:12:11.134152  [  219.279413] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap-sham-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.omap-aes-driver-present: https://kernelci.org/test/=
case/id/642bf81d53b0fa802e79e935
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:12:08.369779  /lava-272347/1/../bin/lava-test-case
    2023-04-04T10:12:08.469728  [  216.613987] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap-aes-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/t=
est/case/id/642bf81d53b0fa802e79e938
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:12:04.534764  /lava-272347/1/../bin/lava-test-case
    2023-04-04T10:12:04.643198  [  212.787665] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2023-04-04T10:12:05.776751  /lava-272347/1/../bin/lava-test-case
    2023-04-04T10:12:05.874481  [  214.018360] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/642bf81d53b0fa802e79e939
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:12:03.318135  /lava-272347/1/../bin/lava-test-case
    2023-04-04T10:12:03.414396  [  211.558474] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sdhci-omap-driver-present: https://kernelci.org/tes=
t/case/id/642bf81d53b0fa802e79e941
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:11:57.612378  /lava-272347/1/../bin/lava-test-case
    2023-04-04T10:11:57.709770  [  205.853659] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dbaseboard-eeprom-probed RESULT=3Dblocked>
    2023-04-04T10:11:58.829029  /lava-272347/1/../bin/lava-test-case
    2023-04-04T10:11:58.926043  [  207.069610] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsdhci-omap-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.at24-driver-present: https://kernelci.org/test/case=
/id/642bf81d53b0fa802e79e942
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:11:56.390835  /lava-272347/1/../bin/lava-test-case
    2023-04-04T10:11:56.492347  [  204.636754] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dat24-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.pwrbutton-driver-present: https://kernelci.org/test=
/case/id/642bf81d53b0fa802e79e945
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:11:53.709739  /lava-272347/1/../bin/lava-test-case
    2023-04-04T10:11:53.814869  [  201.959131] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dpwrbutton-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.omap8240-driver-present: https://kernelci.org/test/=
case/id/642bf81d53b0fa802e79e94b
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:11:50.652911  /lava-272347/1/../bin/lava-test-case
    2023-04-04T10:11:50.749739  [  198.894793] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap8240-driver-present RESULT=3Dfail>   =


  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/642bf81d53b0=
fa802e79e952
        new failure (last pass: v5.10.175-cip29-rt12)
        1 lines

    2023-04-04T10:11:39.473018  / # =

    2023-04-04T10:11:39.477883  =

    2023-04-04T10:11:44.499890  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/272347/extract-nfsrootfs-rk4_nhx1'
    2023-04-04T10:11:44.510484  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/272347/extract-nfsrootfs-rk4_nhx1'
    2023-04-04T10:11:46.805268  / # export NFS_SERVER_IP=3D'192.168.56.193'
    2023-04-04T10:11:46.816084  export NFS_SERVER_IP=3D'192.168.56.193'
    2023-04-04T10:11:46.921069  / # #
    2023-04-04T10:11:46.926281  #
    2023-04-04T10:11:47.035563  / # export SHELL=3D/bin/sh
    2023-04-04T10:11:47.040922  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
dell-latitude...4305U-sarien | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/642bf9ef3c8d40940d79e988

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-dell-latitude-5400-4305U-sarien.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-dell-latitude-5400-4305U-sarien.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230331.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/642bf9ef3c8d40940=
d79e989
        failing since 12 days (last pass: v4.19.277-cip94-1098-g26d9f86d942=
d, first fail: v5.10.175-cip29-rt12) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
dell-latitude...8665U-sarien | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/642bf97a3c00286a3279e961

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-dell-latitude-5400-8665U-sarien.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-dell-latitude-5400-8665U-sarien.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230331.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/642bf97a3c00286a3=
279e962
        failing since 12 days (last pass: v4.19.277-cip94-1098-g26d9f86d942=
d, first fail: v5.10.175-cip29-rt12) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/642bf9d9bcf756b19179e927

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230331.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/642bf9d9bcf756b19=
179e928
        new failure (last pass: v5.10.175-cip29-rt12) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-14-db0003na-grunt         | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/642bf927dfe774358679e949

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-hp-14-db0003na-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-hp-14-db0003na-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230331.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/642bf927dfe774358=
679e94a
        new failure (last pass: v5.10.175-cip29-rt12) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/642bfb58dd2fe8de8379e930

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230331.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/642bfb58dd2fe8de8=
379e931
        new failure (last pass: v5.10.175-cip29-rt12) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/642bfa48afba35e18779e923

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230331.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/642bfa48afba35e18=
779e924
        failing since 12 days (last pass: v4.19.277-cip94-1098-g26d9f86d942=
d, first fail: v5.10.175-cip29-rt12) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/642bf9614175c58fc679e933

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230331.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/642bf9614175c58fc=
679e934
        new failure (last pass: v5.10.175-cip29-rt12) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/642bf92e6f4de6294b79e93e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230331.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/642bf92e6f4de6294=
b79e93f
        new failure (last pass: v5.10.175-cip29-rt12) =

 =20

