Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D78C2FC05
	for <webhook@archiver.kernel.org>; Wed, 16 Aug 2023 23:59:45 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.web11.175793.1692230378265780744
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 16 Aug 2023 16:59:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=B0K4vTMY;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.173, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1bcad794ad4so48041115ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 16 Aug 2023 16:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692230377; x=1692835177;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6TrGHSMNbs8vYLE22tO1B9L9elaDaKR+j9kE00DRL3g=;
        b=B0K4vTMY8UqFU6W6k0MKvPsfhmaPekRvR6UA/IukJoTSlCgX3aEzR5Ft59nCe6Gg2x
         MZZ4udPY3Wv8YjqcLcCgHYeuC2TP2OQmxXj8HVrzXyKu0NOe/xfY7+YdfnVPJi4EaWV2
         hf7qoqnwRj0pgT8fKpR6yL3nQeJHI5GbYhgagqX6gbwsWUBg5AATV2dXVHOpL0pRNFsr
         2GYHO0FDPBRVOecgA8NjrpPzqjXsC+uMH7gigHGSQhLnUbOPkAByeqji/s13MOSMn5ie
         BPw+x+qEJoOaRFhXGcJt2lwohBNh1j/xGtCn6bAdkIv/v4ve4NNldNQ0L52bsH01iSru
         p7bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692230377; x=1692835177;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6TrGHSMNbs8vYLE22tO1B9L9elaDaKR+j9kE00DRL3g=;
        b=GC9NN7LfpWmOwXfbjAkJGELf8vVlDw1CitykLuuZ3175Hy3kVoDyvY/GlWTrgZgle9
         6xYl5YQjld90oWpW9INXvpt1FkWOzGOmeOpYfaN2bJuc9zXjXxI+0/SAofujJfVoqLWp
         HDTlRMMhZlbZ8HcuO1TT2a9RJ93u2BUO/U/PnQ0TvIhfW9dlsy1L+wmGQsgWkcTAxiTR
         58EtJZOPloeiOBK/9W9YF6bRv17t4uFLcD4vchoofeBcUxE8wQlzCB2cavZNEqsz3fUD
         LkIgt7bEBowOMmvF3K++P0b/nBbQ1i0UwuH7L9b+YMZVIUWGziLekxxYJIo6WaG8dyAJ
         9sMA==
X-Gm-Message-State: AOJu0YxDHjpLyBRfIKDNrsrOTm6FnX3onQglsoe3OVPvbtkyqAL12pmO
	I8daCVODCpQErGnF2j3YU1DQ2iXOlplfUI7y/RnPDQ==
X-Google-Smtp-Source: AGHT+IG6faC9pdoyEvhIkDrRYa3WjrHliQXOV09SFPrHSazcNQdc4XapP310j4dzgu5lES74p47n3g==
X-Received: by 2002:a17:902:ce86:b0:1bf:728:7458 with SMTP id f6-20020a170902ce8600b001bf07287458mr2062896plg.58.1692230376918;
        Wed, 16 Aug 2023 16:59:36 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id bf9-20020a170902b90900b001bc39aa63ebsm13707051plb.121.2023.08.16.16.59.36
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 16:59:36 -0700 (PDT)
Message-ID: <64dd62e8.170a0220.ca98b.a3bc@mx.google.com>
Date: Wed, 16 Aug 2023 16:59:36 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.288-cip101-388-g468a029f1562
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 20 runs,
 7 regressions (v4.19.288-cip101-388-g468a029f1562)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Aug 2023 23:59:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12742

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 20 runs, 7 regress=
ions (v4.19.288-cip101-388-g468a029f1562)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =

beaglebone-black          | arm    | lab-cip       | gcc-10   | multi_v7_de=
fconfig           | 1          =

imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.288-cip101-388-g468a029f1562/plan/baselin=
e-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.288-cip101-388-g468a029f1562
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      468a029f1562d963ca820d7d6b9caa90569b3420 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd599e6864d365f435b1e9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64dd599e6864d365f435b1ee
        failing since 209 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-08-16T23:19:39.766502  + set +x<8>[   18.150006] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11303952_1.5.2.3.1>

    2023-08-16T23:19:39.766583  =


    2023-08-16T23:19:39.870720  / # #

    2023-08-16T23:19:39.971410  export SHELL=3D/bin/sh

    2023-08-16T23:19:39.971648  #

    2023-08-16T23:19:40.072196  / # export SHELL=3D/bin/sh. /lava-11303952/=
environment

    2023-08-16T23:19:40.072392  =


    2023-08-16T23:19:40.172996  / # . /lava-11303952/environment/lava-11303=
952/bin/lava-test-runner /lava-11303952/1

    2023-08-16T23:19:40.173493  =


    2023-08-16T23:19:40.178688  / # /lava-11303952/bin/lava-test-runner /la=
va-11303952/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd59a9a3164f992935b1e4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64dd59a9a3164f992935b1e9
        failing since 209 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-08-16T23:19:52.230582  + set +x<8>[   21.014473] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11303969_1.5.2.3.1>

    2023-08-16T23:19:52.230720  =


    2023-08-16T23:19:52.335933  #

    2023-08-16T23:19:52.436804  / # #export SHELL=3D/bin/sh

    2023-08-16T23:19:52.437031  =


    2023-08-16T23:19:52.537574  / # export SHELL=3D/bin/sh. /lava-11303969/=
environment

    2023-08-16T23:19:52.537837  =


    2023-08-16T23:19:52.638386  / # . /lava-11303969/environment/lava-11303=
969/bin/lava-test-runner /lava-11303969/1

    2023-08-16T23:19:52.638706  =


    2023-08-16T23:19:52.640602  / # /lava-11303969/bin/lava-test-runner /la=
va-11303969/1
 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd5c5c20bbdb1bc135b273

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm/multi_v7_defconfig/gcc-=
10/lab-broonie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm/multi_v7_defconfig/gcc-=
10/lab-broonie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64dd5c5c20bbdb1bc135b296
        failing since 209 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-08-16T23:30:46.177611  <8>[   43.831306] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 58977_1.6.2.4.1>
    2023-08-16T23:30:46.292597  / # #
    2023-08-16T23:30:46.395454  export SHELL=3D/bin/sh
    2023-08-16T23:30:46.396359  #
    2023-08-16T23:30:46.498445  / # export SHELL=3D/bin/sh. /lava-58977/env=
ironment
    2023-08-16T23:30:46.499335  =

    2023-08-16T23:30:46.601523  / # . /lava-58977/environment/lava-58977/bi=
n/lava-test-runner /lava-58977/1
    2023-08-16T23:30:46.602852  =

    2023-08-16T23:30:46.605752  / # /lava-58977/bin/lava-test-runner /lava-=
58977/1
    2023-08-16T23:30:46.809266  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-cip       | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd5c4420bbdb1bc135b1e7

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm/multi_v7_defconfig/gcc-=
10/lab-cip/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm/multi_v7_defconfig/gcc-=
10/lab-cip/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64dd5c4520bbdb1bc135b1ea
        failing since 209 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-08-16T23:30:37.385683  + set +x
    2023-08-16T23:30:37.388000  <8>[   40.881476] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 998335_1.6.2.4.1>
    2023-08-16T23:30:37.500528  / # #
    2023-08-16T23:30:37.601713  export SHELL=3D/bin/sh
    2023-08-16T23:30:37.602065  #
    2023-08-16T23:30:37.703119  / # export SHELL=3D/bin/sh. /lava-998335/en=
vironment
    2023-08-16T23:30:37.703509  =

    2023-08-16T23:30:37.804592  / # . /lava-998335/environment/lava-998335/=
bin/lava-test-runner /lava-998335/1
    2023-08-16T23:30:37.805119  =

    2023-08-16T23:30:37.806541  / # /lava-998335/bin/lava-test-runner /lava=
-998335/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd5c0d00914754c635b1da

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm/multi_v7_defconfig/gcc-=
10/lab-collabora/baseline-nfs-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm/multi_v7_defconfig/gcc-=
10/lab-collabora/baseline-nfs-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64dd5c0d00914754c635b1df
        failing since 209 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-08-16T23:30:19.673114  / # #

    2023-08-16T23:30:19.775082  export SHELL=3D/bin/sh

    2023-08-16T23:30:19.775719  #

    2023-08-16T23:30:19.877148  / # export SHELL=3D/bin/sh. /lava-11304002/=
environment

    2023-08-16T23:30:19.877787  =


    2023-08-16T23:30:19.979204  / # . /lava-11304002/environment/lava-11304=
002/bin/lava-test-runner /lava-11304002/1

    2023-08-16T23:30:19.980277  =


    2023-08-16T23:30:19.982106  / # /lava-11304002/bin/lava-test-runner /la=
va-11304002/1

    2023-08-16T23:30:20.133565  + export TESTRUN_ID=3D1_bootrr

    2023-08-16T23:30:20.133715  + cd /lava-11304002/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64dd5c6420bbdb1bc135b2a6

  Results:     77 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-388-g468a029f1562/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/64dd5c6520bbdb1bc135b2ac
        failing since 155 days (last pass: v4.19.273-cip92-277-g507c8d80b9e=
20, first fail: v4.19.276-cip93-5-g2eb2a953ab59)

    2023-08-16T23:32:37.165596  /lava-11304015/1/../bin/lava-test-case

    2023-08-16T23:32:37.195708  <8>[   41.018129] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/64dd5c6520bbdb1bc135b2ad
        failing since 155 days (last pass: v4.19.273-cip92-277-g507c8d80b9e=
20, first fail: v4.19.276-cip93-5-g2eb2a953ab59)

    2023-08-16T23:32:35.061844  <8>[   38.884123] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-08-16T23:32:36.096753  /lava-11304015/1/../bin/lava-test-case

    2023-08-16T23:32:36.125555  <8>[   39.949064] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =20

