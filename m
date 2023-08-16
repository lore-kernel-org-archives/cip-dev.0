Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D589CC001E0
	for <webhook@archiver.kernel.org>; Wed, 16 Aug 2023 15:07:19 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web10.163287.1692198433628680802
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 16 Aug 2023 08:07:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=Nuw7c9Dj;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.182, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1bc63ef9959so55813715ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 16 Aug 2023 08:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692198432; x=1692803232;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nPx0pD09aLUBIh6RzNiBnRmA6hG7cZtaV9/6Z8HuwaM=;
        b=Nuw7c9DjTCHVmb4AL6altOCg7Tqly0ARxNl14m0R42vV28gRfnylZO1k1jOsHd/dQT
         JMMBW39nC+bGq0OyTR+q0h+doozxIgRFCj1GiK9IKiErQ3hHd8/4AnoPjVZB6kZT+yGC
         QnLBoDGm0/UeYJV5Zl3SBIZl6c6SJ9cNXuiQOCVPh47uu/FWn4XAh63u6uqc0TT8B0m9
         Js1/sMyaqpPWBePVZU/AKswTHKJkrVauOc+5XcC2sq+n4s9Pab8c49mw/UUot3JIi/4u
         0sZF6n64iKWXPXrC3g73JfBAEwIK/+g6YMRDFDFnom4Lo1JS5B1yEjB52HyINpOjaU3P
         VTew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692198432; x=1692803232;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nPx0pD09aLUBIh6RzNiBnRmA6hG7cZtaV9/6Z8HuwaM=;
        b=c3KKXYV/JM++Ps9bmjs6Zhf/d+thEZuE4WTe0KdhMYyzUhfB5i423HMQN75HtOngBp
         nHA9xdimboq8glIXuCaf4RuK2uzVT4Unc8AtL7wzgNZTFAWFdq8D5oJSNmGIx+wj6v2o
         OdepbPOcz6WuElSEQ0dPecxpYL0AR/5o9cHiy7+AUra65qaLfBk2SHNQvUPYMPLc7geQ
         xo3kGKVbOZ0NVC9sKde1ZeEqUC+/J8hHQ9uFt122DFxcr1nTTSfQ5c2LnFHm1J2EjHLf
         miN/uhCg1JwE4LWrN+Gq8Yn5AlC7Km+eSURAtOMu3H77/nWG1pyDFawNkBn6Q98PwRqa
         EcEQ==
X-Gm-Message-State: AOJu0YxE9qDikbsQT0MhuAaSkuzZbIfpprZ9bkLlsa3IWqlq4jYSl+kn
	uYZ/rRywQBKlrZ8aRQ+iyKjkm1A4za+LKrsK1Mb+Lg==
X-Google-Smtp-Source: AGHT+IHSv/3Wpq2Hyqumgc3LY1+ePibLSWzYWYuJ3PKPxo3CmXRWoAGAwcsI/JXsswCctixRCOIiKw==
X-Received: by 2002:a17:902:c949:b0:1bb:7b6c:983a with SMTP id i9-20020a170902c94900b001bb7b6c983amr2413352pla.59.1692198431750;
        Wed, 16 Aug 2023 08:07:11 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902cec900b001a80ad9c599sm13242122plg.294.2023.08.16.08.07.10
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 08:07:11 -0700 (PDT)
Message-ID: <64dce61f.170a0220.e2dad.880e@mx.google.com>
Date: Wed, 16 Aug 2023 08:07:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st20-3262-g667bb8d8b2cb
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 15 runs,
 48 regressions (v4.4-st20-3262-g667bb8d8b2cb)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Aug 2023 15:07:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12733

cip-gitlab/ci/pavel/linux-test baseline-nfs: 15 runs, 48 regressions (v4.4-=
st20-3262-g667bb8d8b2cb)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 13         =

beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 13         =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 15         =

beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =

hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st20-3262-g667bb8d8b2cb/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st20-3262-g667bb8d8b2cb
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      667bb8d8b2cb1a46bab0ddda1cf60f6e73eff4c6 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dce28f0610b355b135b1dc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64dce28f0610b355b=
135b1dd
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dce2b5eb67bcc00135b1e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-nfs-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-nfs-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64dce2b5eb67bcc00=
135b1e7
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dce07a0eecd1139c35b216

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-nfs-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-nfs-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64dce07a0eecd1139=
c35b217
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 13         =


  Details:     https://kernelci.org/test/plan/id/64dce00cd881b84b7c35b22a

  Results:     15 PASS, 21 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/arm/multi_v7_defconfig/gcc-10/lab-broonie/bas=
eline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/arm/multi_v7_defconfig/gcc-10/lab-broonie/bas=
eline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/t=
est/case/id/64dce00cd881b84b7c35b235
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:40:40.387813  /lava-57232/1/../bin/lava-test-case
    2023-08-16T14:40:40.423549  [   60.312457] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2023-08-16T14:40:41.461281  /lava-57232/1/../bin/lava-test-case
    2023-08-16T14:40:41.497473  [   61.385032] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/64dce00cd881b84b7c35b236
        failing since 27 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-16T14:40:39.313233  /lava-57232/1/../bin/lava-test-case
    2023-08-16T14:40:39.349599  [   59.237461] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.am335x-phy-driver-present: https://kernelci.org/tes=
t/case/id/64dce00cd881b84b7c35b239
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:40:34.868667  /lava-57232/1/../bin/lava-test-case
    2023-08-16T14:40:34.906674  [   54.794426] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dusb0-musb-dsps-probed RESULT=3Dblocked>
    2023-08-16T14:40:35.948249  /lava-57232/1/../bin/lava-test-case
    2023-08-16T14:40:35.983671  [   55.871428] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dusb1-musb-dsps-probed RESULT=3Dblocked>
    2023-08-16T14:40:37.024391  /lava-57232/1/../bin/lava-test-case
    2023-08-16T14:40:37.062297  [   56.949656] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dam335x-phy-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.musb-dsps-driver-present: https://kernelci.org/test=
/case/id/64dce00cd881b84b7c35b23a
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:40:31.632506  /lava-57232/1/../bin/lava-test-case
    2023-08-16T14:40:31.670390  [   51.558874] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmmc0-probed RESULT=3Dblocked>
    2023-08-16T14:40:32.711417  /lava-57232/1/../bin/lava-test-case
    2023-08-16T14:40:32.747016  [   52.636401] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmmc1-probed RESULT=3Dblocked>
    2023-08-16T14:40:33.786732  /lava-57232/1/../bin/lava-test-case
    2023-08-16T14:40:33.827559  [   53.715287] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmusb-dsps-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sdhci-omap-driver-present: https://kernelci.org/tes=
t/case/id/64dce00cd881b84b7c35b23b
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:40:30.550503  /lava-57232/1/../bin/lava-test-case
    2023-08-16T14:40:30.591387  [   50.478871] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsdhci-omap-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tps65217-driver-present: https://kernelci.org/test/=
case/id/64dce00cd881b84b7c35b241
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:40:25.975344  /lava-57232/1/../bin/lava-test-case
    2023-08-16T14:40:26.018350  [   45.905977] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtps65217-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.omap8240-driver-present: https://kernelci.org/test/=
case/id/64dce00cd881b84b7c35b245
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:40:23.583704  /lava-57232/1/../bin/lava-test-case
    2023-08-16T14:40:23.622312  [   43.509899] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap8240-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-audio: https://kernelci.org/test/case/id/64dce=
00cd881b84b7c35b249
        failing since 27 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-16T14:41:03.357548  /lava-57232/1/../bin/lava-test-case
    2023-08-16T14:41:03.416933  [   83.306043] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio-probed RESULT=3Dblocked>
    2023-08-16T14:41:04.456704  /lava-57232/1/../bin/lava-test-case
    2023-08-16T14:41:04.516653  [   84.406776] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline-nfs.bootrr.simple-audio-driver-present: https://kernelci.org/t=
est/case/id/64dce00cd881b84b7c35b24a
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:41:01.231378  /opt/bootrr/libexec/bootrr/boards/ti,am335x=
-bone-black: 84: assert_device-present: not found
    2023-08-16T14:41:02.259716  /lava-57232/1/../bin/lava-test-case
    2023-08-16T14:41:02.318923  [   82.207310] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsimple-audio-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-codec-driver-present: https://kernelci.org/tes=
t/case/id/64dce00cd881b84b7c35b24b
        failing since 27 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-16T14:40:59.657321  /lava-57232/1/../bin/lava-test-case
    2023-08-16T14:41:00.122455  [   80.011805] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-08-16T14:41:01.162982  /lava-57232/1/../bin/lava-test-case
    2023-08-16T14:41:01.219364  [   81.107512] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case=
/id/64dce00cd881b84b7c35b24c
        failing since 27 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-16T14:40:56.641568  /lava-57232/1/../bin/lava-test-case
    2023-08-16T14:40:56.877362  [   76.766397] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-08-16T14:40:57.917289  /lava-57232/1/../bin/lava-test-case
    2023-08-16T14:40:58.619222  [   78.508218] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tda19988-driver-present: https://kernelci.org/test/=
case/id/64dce00cd881b84b7c35b24d
        failing since 27 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-16T14:40:54.446512  /lava-57232/1/../bin/lava-test-case
    2023-08-16T14:40:54.505694  [   74.395104] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-08-16T14:40:55.543516  /lava-57232/1/../bin/lava-test-case
    2023-08-16T14:40:55.601966  [   75.490473] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/64dce00cd881=
b84b7c35b252
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)
        1 lines

    2023-08-16T14:40:13.426669  / # =

    2023-08-16T14:40:13.433499  =

    2023-08-16T14:40:18.384997  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/57232/extract-nfsrootfs-vay2qevb'
    2023-08-16T14:40:18.395711  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/57232/extract-nfsrootfs-vay2qevb'
    2023-08-16T14:40:20.632105  / # export NFS_SERVER_IP=3D'192.168.56.75'
    2023-08-16T14:40:20.643202  export NFS_SERVER_IP=3D'192.168.56.75'
    2023-08-16T14:40:20.747705  / # #
    2023-08-16T14:40:20.753969  #
    2023-08-16T14:40:20.856571  / # export SHELL=3D/bin/sh
    2023-08-16T14:40:20.863558  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 13         =


  Details:     https://kernelci.org/test/plan/id/64dce1af7cb3b6378b35b1d9

  Results:     15 PASS, 21 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/arm/multi_v7_defconfig/gcc-10/lab-cip/baselin=
e-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/arm/multi_v7_defconfig/gcc-10/lab-cip/baselin=
e-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.omap8240-driver-present: https://kernelci.org/test/=
case/id/64dce1af7cb3b6378b35b1df
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:47:20.333092  /lava-997933/1/../bin/lava-test-case
    2023-08-16T14:47:20.372717  [   40.143721] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap8240-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tps65217-driver-present: https://kernelci.org/test/=
case/id/64dce1af7cb3b6378b35b1e3
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:47:22.710180  /lava-997933/1/../bin/lava-test-case
    2023-08-16T14:47:22.752174  [   42.523186] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtps65217-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sdhci-omap-driver-present: https://kernelci.org/tes=
t/case/id/64dce1af7cb3b6378b35b1e9
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:47:27.283069  /lava-997933/1/../bin/lava-test-case
    2023-08-16T14:47:27.324815  [   47.095903] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsdhci-omap-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.musb-dsps-driver-present: https://kernelci.org/test=
/case/id/64dce1af7cb3b6378b35b1ea
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:47:28.364319  /lava-997933/1/../bin/lava-test-case
    2023-08-16T14:47:28.405222  [   48.177394] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmmc0-probed RESULT=3Dblocked>
    2023-08-16T14:47:29.445622  /lava-997933/1/../bin/lava-test-case
    2023-08-16T14:47:29.486065  [   49.258277] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmmc1-probed RESULT=3Dblocked>
    2023-08-16T14:47:30.526466  /lava-997933/1/../bin/lava-test-case
    2023-08-16T14:47:30.566864  [   50.338155] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmusb-dsps-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.am335x-phy-driver-present: https://kernelci.org/tes=
t/case/id/64dce1af7cb3b6378b35b1eb
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:47:31.605411  /lava-997933/1/../bin/lava-test-case
    2023-08-16T14:47:31.648145  [   51.419540] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dusb0-musb-dsps-probed RESULT=3Dblocked>
    2023-08-16T14:47:32.688324  /lava-997933/1/../bin/lava-test-case
    2023-08-16T14:47:32.729597  [   52.500980] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dusb1-musb-dsps-probed RESULT=3Dblocked>
    2023-08-16T14:47:33.770334  /lava-997933/1/../bin/lava-test-case
    2023-08-16T14:47:33.811402  [   53.582810] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dam335x-phy-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/64dce1af7cb3b6378b35b1ee
        failing since 27 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-16T14:47:36.076090  /lava-997933/1/../bin/lava-test-case
    2023-08-16T14:47:36.116359  [   55.887911] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/t=
est/case/id/64dce1af7cb3b6378b35b1ef
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:47:37.155165  /lava-997933/1/../bin/lava-test-case
    2023-08-16T14:47:37.197924  [   56.969855] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2023-08-16T14:47:38.239424  /lava-997933/1/../bin/lava-test-case
    2023-08-16T14:47:38.282201  [   58.053598] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tda19988-driver-present: https://kernelci.org/test/=
case/id/64dce1af7cb3b6378b35b1f9
        failing since 27 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-16T14:47:50.409980  /lava-997933/1/../bin/lava-test-case
    2023-08-16T14:47:50.450844  [   70.223926] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-08-16T14:47:51.488796  /lava-997933/1/../bin/lava-test-case
    2023-08-16T14:47:51.532265  [   71.304614] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case=
/id/64dce1af7cb3b6378b35b1fa
        failing since 27 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-16T14:47:52.571189  /lava-997933/1/../bin/lava-test-case
    2023-08-16T14:47:52.611560  [   72.384286] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-08-16T14:47:53.652192  /lava-997933/1/../bin/lava-test-case
    2023-08-16T14:47:53.691506  [   73.464303] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-codec-driver-present: https://kernelci.org/tes=
t/case/id/64dce1af7cb3b6378b35b1fb
        failing since 27 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-16T14:47:54.730805  /lava-997933/1/../bin/lava-test-case
    2023-08-16T14:47:54.771115  [   74.544265] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-08-16T14:47:55.809024  /lava-997933/1/../bin/lava-test-case
    2023-08-16T14:47:55.848688  [   75.621122] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.simple-audio-driver-present: https://kernelci.org/t=
est/case/id/64dce1af7cb3b6378b35b1fc
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:47:55.861057  /opt/bootrr/libexec/bootrr/boards/ti,am335x=
-bone-black: 84: assert_device-present: not found
    2023-08-16T14:47:56.891126  /lava-997933/1/../bin/lava-test-case
    2023-08-16T14:47:56.932103  [   76.704283] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsimple-audio-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-audio: https://kernelci.org/test/case/id/64dce=
1af7cb3b6378b35b1fd
        failing since 27 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-16T14:47:57.971642  /lava-997933/1/../bin/lava-test-case
    2023-08-16T14:47:58.015402  [   77.788259] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio-probed RESULT=3Dblocked>
    2023-08-16T14:47:59.054774  /lava-997933/1/../bin/lava-test-case
    2023-08-16T14:47:59.094492  [   78.868364] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/64dce1af7cb3=
b6378b35b1ff
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)
        1 lines

    2023-08-16T14:47:10.171763  / # =

    2023-08-16T14:47:10.174038  =

    2023-08-16T14:47:15.184283  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/997933/extract-nfsrootfs-wjt7_pd7'
    2023-08-16T14:47:15.194979  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/997933/extract-nfsrootfs-wjt7_pd7'
    2023-08-16T14:47:17.361827  / # export NFS_SERVER_IP=3D'192.168.11.5'
    2023-08-16T14:47:17.372542  export NFS_SERVER_IP=3D'192.168.11.5'
    2023-08-16T14:47:17.475897  / # #
    2023-08-16T14:47:17.478137  #
    2023-08-16T14:47:17.581423  / # export SHELL=3D/bin/sh
    2023-08-16T14:47:17.583754  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 15         =


  Details:     https://kernelci.org/test/plan/id/64dcdf807e39d218cc35b210

  Results:     24 PASS, 17 FAIL, 2 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/arm/omap2plus_defconfig/gcc-10/lab-broonie/ba=
seline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/arm/omap2plus_defconfig/gcc-10/lab-broonie/ba=
seline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.hdmi-audio: https://kernelci.org/test/case/id/64dcd=
f807e39d218cc35b213
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:38:32.350222  /lava-57194/1/../bin/lava-test-case
    2023-08-16T14:38:32.412980  [   90.224633] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio-probed RESULT=3Dblocked>
    2023-08-16T14:38:33.656755  /lava-57194/1/../bin/lava-test-case
    2023-08-16T14:38:33.657601  [   91.395598] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio RESULT=3Dfail>
    2023-08-16T14:38:33.658028  + set +x
    2023-08-16T14:38:33.658256  [   91.435341] <LAVA_SIGNAL_ENDRUN 1_bootrr=
 57194_1.6.2.4.5>   =


  * baseline-nfs.bootrr.simple-audio-driver-present: https://kernelci.org/t=
est/case/id/64dcdf807e39d218cc35b214
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:38:30.030630  /opt/bootrr/libexec/bootrr/boards/ti,am335x=
-bone-black: 84: assert_device-present: not found
    2023-08-16T14:38:31.137153  /lava-57194/1/../bin/lava-test-case
    2023-08-16T14:38:31.234130  [   89.045888] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsimple-audio-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-codec-driver-present: https://kernelci.org/tes=
t/case/id/64dcdf807e39d218cc35b215
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:38:28.709957  /lava-57194/1/../bin/lava-test-case
    2023-08-16T14:38:28.811931  [   86.625235] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-08-16T14:38:29.907679  /lava-57194/1/../bin/lava-test-case
    2023-08-16T14:38:30.006488  [   87.817694] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case=
/id/64dcdf807e39d218cc35b216
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:38:26.348399  /lava-57194/1/../bin/lava-test-case
    2023-08-16T14:38:26.410869  [   84.222773] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-08-16T14:38:27.485226  /lava-57194/1/../bin/lava-test-case
    2023-08-16T14:38:27.582793  [   85.395686] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tda19988-driver-present: https://kernelci.org/test/=
case/id/64dcdf807e39d218cc35b217
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:38:23.897384  /lava-57194/1/../bin/lava-test-case
    2023-08-16T14:38:23.993363  [   81.806722] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-08-16T14:38:25.113278  /lava-57194/1/../bin/lava-test-case
    2023-08-16T14:38:25.215488  [   83.027784] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tilcdc-driver-probed: https://kernelci.org/test/cas=
e/id/64dcdf817e39d218cc35b218
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:38:22.689261  /lava-57194/1/../bin/lava-test-case
    2023-08-16T14:38:22.790642  [   80.603213] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtilcdc-driver-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.omap-sham-driver-present: https://kernelci.org/test=
/case/id/64dcdf817e39d218cc35b21d
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:38:19.771323  /lava-57194/1/../bin/lava-test-case
    2023-08-16T14:38:19.866907  [   77.679139] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap-sham-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.omap-aes-driver-present: https://kernelci.org/test/=
case/id/64dcdf817e39d218cc35b220
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:38:17.057704  /lava-57194/1/../bin/lava-test-case
    2023-08-16T14:38:17.155942  [   74.968228] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap-aes-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/t=
est/case/id/64dcdf817e39d218cc35b223
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:38:13.133698  /lava-57194/1/../bin/lava-test-case
    2023-08-16T14:38:13.243618  [   71.055917] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2023-08-16T14:38:14.362818  /lava-57194/1/../bin/lava-test-case
    2023-08-16T14:38:14.460017  [   72.271944] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/64dcdf817e39d218cc35b224
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:38:11.915853  /lava-57194/1/../bin/lava-test-case
    2023-08-16T14:38:12.013236  [   69.825173] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sdhci-omap-driver-present: https://kernelci.org/tes=
t/case/id/64dcdf817e39d218cc35b22c
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:38:06.197548  /lava-57194/1/../bin/lava-test-case
    2023-08-16T14:38:06.297769  [   64.109532] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dbaseboard-eeprom-probed RESULT=3Dblocked>
    2023-08-16T14:38:07.415768  /lava-57194/1/../bin/lava-test-case
    2023-08-16T14:38:07.513567  [   65.325376] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsdhci-omap-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.at24-driver-present: https://kernelci.org/test/case=
/id/64dcdf817e39d218cc35b22d
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:38:04.966022  /lava-57194/1/../bin/lava-test-case
    2023-08-16T14:38:05.073427  [   62.885424] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dat24-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.pwrbutton-driver-present: https://kernelci.org/test=
/case/id/64dcdf817e39d218cc35b230
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:38:02.359066  /lava-57194/1/../bin/lava-test-case
    2023-08-16T14:38:02.463735  [   60.274464] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dpwrbutton-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.omap8240-driver-present: https://kernelci.org/test/=
case/id/64dcdf817e39d218cc35b236
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:37:59.288925  /lava-57194/1/../bin/lava-test-case
    2023-08-16T14:37:59.386055  [   57.197622] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap8240-driver-present RESULT=3Dfail>   =


  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/64dcdf817e39=
d218cc35b23d
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)
        1 lines

    2023-08-16T14:37:48.184975  / # =

    2023-08-16T14:37:48.190447  =

    2023-08-16T14:37:53.152414  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/57194/extract-nfsrootfs-7v8etkwq'
    2023-08-16T14:37:53.163064  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/57194/extract-nfsrootfs-7v8etkwq'
    2023-08-16T14:37:55.453692  / # export NFS_SERVER_IP=3D'192.168.56.193'
    2023-08-16T14:37:55.464297  export NFS_SERVER_IP=3D'192.168.56.193'
    2023-08-16T14:37:55.568437  / # #
    2023-08-16T14:37:55.572784  #
    2023-08-16T14:37:55.681629  / # export SHELL=3D/bin/sh
    2023-08-16T14:37:55.686036  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64dce0321cfa37d38335b1f4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/arm/omap2plus_defconfig/gcc-10/lab-cip/baseli=
ne-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/arm/omap2plus_defconfig/gcc-10/lab-cip/baseli=
ne-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64dce0321cfa37d38=
335b1f5
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dcdf99d302560aff35b1e7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-nfs-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-nfs-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64dcdf99d302560af=
f35b1e8
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dce5d631eec4937b35b1da

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64dce5d631eec4937=
b35b1db
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dce244702faa7bc935b1e0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64dce244702faa7bc=
935b1e1
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d) =

 =20

