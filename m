Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30918CD98E6
	for <webhook@archiver.kernel.org>; Wed, 11 Oct 2023 02:21:08 +0000 (UTC)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
 by mx.groups.io with SMTP id smtpd.web10.8191.1696990860645150865
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 10 Oct 2023 19:21:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=cE/n1WdF;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.167.182, mailfrom: bot@kernelci.org)
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3ae2896974bso4355735b6e.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 10 Oct 2023 19:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696990859; x=1697595659; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GkUgziKpluaZips/r1TksLb1g7iStLhO+MdkK4FqtLw=;
        b=cE/n1WdFNgPJyeVInQ+pSTIzc5UjDaIFsx4mrGielBxHdFYZfUmo8y5mykGbXY2+3Z
         nuub6QM/poGlbmhztuYrKJ61XqXi0QMHReOUn9Cuid8i4qrW7uepTGgDg6cu19JJJ/vM
         Nbm7sMnuiMDGwRL0fZ6TxR37sfsLjHPGjdWhZDJjYYY8zEN4nd1IdGZM3xRCG3R3hoxn
         L2ba2TTIN6wsRUgve7JD31gt6qN4Hw+8jcgAR9guHwFDLHUuMHbqFsWjnSzWb8b/Ff8k
         C3AmQYSjOFiPoaFAEDIIpaMuS6+1X5FxpwI038adiIAco5q/SLZkF0Xik5DE5nesypud
         efuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696990859; x=1697595659;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GkUgziKpluaZips/r1TksLb1g7iStLhO+MdkK4FqtLw=;
        b=Lru5QUHKMJXlxouAZll4zpCTMz+NJ/AaOtv/143jKg9kzrU5TTzrPYWE+bVQnTdNfF
         twc5H0OdYzm8egrpHALy5BBJtlokJYhY2t6ZYUmCXRj9bUoJ0zWFtmIQzZzDAV1Kjbty
         XKP+5wDrqukwnTFgCnIm++SB6EWqIA/yi1+2CRdUDPi5ifgM5pTQxDLemEkZj35OdXEN
         u/yrpv9Z2OIuU1qPOQWizTuVB1RUKGBulXIv4yuqSqX2+UFig5YIMOCV+OB+21NCYKQY
         laEUuLn5KbuSEDD7non5E27HkqEiNYsiEyLn2W8+bRrfHGTqZkoDjykhFwSsuGxxR6EO
         0FvA==
X-Gm-Message-State: AOJu0YztLtTuJ7u84I5pORmfUskzuxAEpYtkdvEZpW7b3+pmo/uPiN4w
	dnYxoh7QYvMbiogyrZrKLFypZiLJEipjbjohx6e8+w==
X-Google-Smtp-Source: AGHT+IG6qjKoBwCXDoxCoN5H94PujcMQh1trbD11Ak8aBT10Tsd/Qm27Xxia2RvwelwcYunNEMNndw==
X-Received: by 2002:a54:4486:0:b0:3a8:1c07:17d3 with SMTP id v6-20020a544486000000b003a81c0717d3mr20750934oiv.19.1696990858945;
        Tue, 10 Oct 2023 19:20:58 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id i13-20020a63bf4d000000b0057c449977efsm9541501pgo.39.2023.10.10.19.20.57
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 19:20:58 -0700 (PDT)
Message-ID: <6526068a.630a0220.ee11b.9709@mx.google.com>
Date: Tue, 10 Oct 2023 19:20:58 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.19.295-cip103-95-ge42cfc8bb88b7
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 41 runs,
 8 regressions (v4.19.295-cip103-95-ge42cfc8bb88b7)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Oct 2023 02:21:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13384

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 41 runs, 8 regress=
ions (v4.19.295-cip103-95-ge42cfc8bb88b7)

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

at91sam9g20ek             | arm    | lab-broonie   | gcc-10   | multi_v5_de=
fconfig           | 1          =

beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =

imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =

sun50i-a64-pine64-plus    | arm64  | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.295-cip103-95-ge42cfc8bb88b7/plan/baselin=
e-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.295-cip103-95-ge42cfc8bb88b7
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      e42cfc8bb88b7ac345bd44cd4a1eb3cae3dea954 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6525ff48b158f21734efcf23

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6525ff48b158f21734efcf2c
        failing since 264 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-10-11T01:51:06.424734  + set +x

    2023-10-11T01:51:06.431332  <8>[   14.445664] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11733054_1.5.2.3.1>

    2023-10-11T01:51:06.536314  / # #

    2023-10-11T01:51:06.636881  export SHELL=3D/bin/sh

    2023-10-11T01:51:06.637062  #

    2023-10-11T01:51:06.737558  / # export SHELL=3D/bin/sh. /lava-11733054/=
environment

    2023-10-11T01:51:06.737776  =


    2023-10-11T01:51:06.838325  / # . /lava-11733054/environment/lava-11733=
054/bin/lava-test-runner /lava-11733054/1

    2023-10-11T01:51:06.838628  =


    2023-10-11T01:51:06.843297  / # /lava-11733054/bin/lava-test-runner /la=
va-11733054/1
 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6526002f80b165d6aaefcef3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6526002f80b165d6a=
aefcef4
        new failure (last pass: v4.19.292-cip102-406-g9efaa60a8cb4) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
at91sam9g20ek             | arm    | lab-broonie   | gcc-10   | multi_v5_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/652602a04144b0b511efcf60

  Results:     42 PASS, 9 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm/multi_v5_defconfig/gcc-=
10/lab-broonie/baseline-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm/multi_v5_defconfig/gcc-=
10/lab-broonie/baseline-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armel/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/652602a04144b0b511efcf96
        new failure (last pass: v4.19.284-cip99-114-g02e97826987bf)

    2023-10-11T02:03:36.311232  + set +x<8><LAVA_SIGNAL_ENDRUN 0_dmesg 1637=
94_1.6.2.4.1>
    2023-10-11T02:03:36.425389  #
    2023-10-11T02:03:36.528673  / # #export SHELL=3D/bin/sh
    2023-10-11T02:03:36.529139  =

    2023-10-11T02:03:36.630611  / # export SHELL=3D/bin/sh. /lava-163794/en=
vironment
    2023-10-11T02:03:36.631412  =

    2023-10-11T02:03:36.733444  / # . /lava-163794/environment/lava-163794/=
bin/lava-test-runner /lava-163794/1
    2023-10-11T02:03:36.734810  =

    2023-10-11T02:03:36.738190  / # /lava-163794/bin/lava-test-runner /lava=
-163794/1
    2023-10-11T02:03:37.099812  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/652601069e21a629f1efcefa

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm/multi_v7_defconfig/gcc-=
10/lab-broonie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm/multi_v7_defconfig/gcc-=
10/lab-broonie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/652601069e21a629f1efcf26
        failing since 264 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-10-11T01:56:30.016084  <8>[  108.127474] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 163784_1.6.2.4.1>
    2023-10-11T01:56:30.147839  / # #
    2023-10-11T01:56:30.250626  export SHELL=3D/bin/sh
    2023-10-11T01:56:30.251295  #
    2023-10-11T01:56:30.353135  / # export SHELL=3D/bin/sh. /lava-163784/en=
vironment
    2023-10-11T01:56:30.354023  =

    2023-10-11T01:56:30.457167  / # . /lava-163784/environment/lava-163784/=
bin/lava-test-runner /lava-163784/1
    2023-10-11T01:56:30.458159  =

    2023-10-11T01:56:30.462339  / # /lava-163784/bin/lava-test-runner /lava=
-163784/1
    2023-10-11T01:56:30.641997  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6525ffca718ea130a1efceff

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm/multi_v7_defconfig/gcc-=
10/lab-collabora/baseline-nfs-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm/multi_v7_defconfig/gcc-=
10/lab-collabora/baseline-nfs-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6525ffca718ea130a1efcf08
        failing since 264 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-10-11T01:52:23.584736  / # #

    2023-10-11T01:52:23.686754  export SHELL=3D/bin/sh

    2023-10-11T01:52:23.687428  #

    2023-10-11T01:52:23.788751  / # export SHELL=3D/bin/sh. /lava-11733170/=
environment

    2023-10-11T01:52:23.789438  =


    2023-10-11T01:52:23.890877  / # . /lava-11733170/environment/lava-11733=
170/bin/lava-test-runner /lava-11733170/1

    2023-10-11T01:52:23.891965  =


    2023-10-11T01:52:23.893282  / # /lava-11733170/bin/lava-test-runner /la=
va-11733170/1

    2023-10-11T01:52:24.033951  + export TESTRUN_ID=3D1_bootrr

    2023-10-11T01:52:24.034104  + cd /lava-11733170/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6525ffbe641f781e4aefcefa

  Results:     77 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/6525ffbe641f781e4aefcf04
        failing since 210 days (last pass: v4.19.273-cip92-277-g507c8d80b9e=
20, first fail: v4.19.276-cip93-5-g2eb2a953ab59)

    2023-10-11T01:53:24.173142  /lava-11733148/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/6525ffbe641f781e4aefcf05
        failing since 210 days (last pass: v4.19.273-cip92-277-g507c8d80b9e=
20, first fail: v4.19.276-cip93-5-g2eb2a953ab59)

    2023-10-11T01:53:22.082182  <8>[   38.034494] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-10-11T01:53:23.110772  /lava-11733148/1/../bin/lava-test-case

    2023-10-11T01:53:23.137718  <8>[   39.090932] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
sun50i-a64-pine64-plus    | arm64  | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6526019fd177f8fdadefcef8

  Results:     23 PASS, 16 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm64/defconfig/gcc-10/lab-=
broonie/baseline-nfs-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm64/defconfig/gcc-10/lab-=
broonie/baseline-nfs-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6526019fd177f8fdadefcf22
        failing since 264 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-10-11T01:58:44.129990  + set +x
    2023-10-11T01:58:44.133350  <8>[   43.852207] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 163730_1.6.2.4.1>
    2023-10-11T01:58:44.282710  / # #
    2023-10-11T01:58:44.385138  export SHELL=3D/bin/sh
    2023-10-11T01:58:44.385720  #
    2023-10-11T01:58:44.487555  / # export SHELL=3D/bin/sh. /lava-163730/en=
vironment
    2023-10-11T01:58:44.488002  =

    2023-10-11T01:58:44.589805  / # . /lava-163730/environment/lava-163730/=
bin/lava-test-runner /lava-163730/1
    2023-10-11T01:58:44.590655  =

    2023-10-11T01:58:44.594867  / # /lava-163730/bin/lava-test-runner /lava=
-163730/1 =

    ... (13 line(s) more)  =

 =20

