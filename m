Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73681C32793
	for <webhook@archiver.kernel.org>; Wed, 18 Jan 2023 21:55:36 +0000 (UTC)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.web11.30411.1674078932581064056
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 18 Jan 2023 13:55:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=gcsnh2de;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.46, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f46.google.com with SMTP id cx21-20020a17090afd9500b00228f2ecc6dbso2963231pjb.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 18 Jan 2023 13:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lnQxGM8XWH+TVvVXPg4psIC8nDYDT2DAnuu6z0p4eD0=;
        b=gcsnh2deYjg1vy/v1b9B+AOUGvchP6vO74byBwp8ozvechysUxnwLkRp3UbDPoDH2E
         f0YWOMQBPUgrb0DhbQXuzfgwLMzM139jyRnZ+ddbXe4Tmpz5YyAQ7yH9erJxKkHKKZ8n
         yiz+lEi4l1oYFTN1v2ys668fUqT5hDX3N99Os6hVGBJw5i5iRI+qO+Es9vw3GITHcmGl
         LsATzUbB8iiX1EHMN5qSQjhxU9w3WOGmRcCzy0dG8KYdbMf9nfF5UAPy32gBMR1rBghd
         bi/kL/vmY7RNegVF6naeAFA0CYvWPEW6KPrwOruy8f9Ew4uX62qPtBjBn1yVH4leyffm
         sEDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lnQxGM8XWH+TVvVXPg4psIC8nDYDT2DAnuu6z0p4eD0=;
        b=L6Qi5fYCGjGgzjjJ4wq/BfRlze59UfD1rWA8DkM2y6EROK71lxjqjQnSrli0WhTfoW
         QWeXxks3bEsyxYqO34H0D+irbF7yBMNJMit8OIKYwtFSl0ZEdbtZCltsHeWFXiBb4QUY
         R6/7E0m+CaXGV4J/+FwwwYv+Q/zFFqAo/cQeH0c07QM7v04DsGuMGTKFuR/seGzbWnhR
         TcL464Z8Te1EwwLwHzWxyl3Ytvy69kRY+Rv8PVvwD71GRgCPWgg04jfdbhqzeDvxVo31
         tjDjKVrbvVf0pRfTpSMKFQRamGshl0S2DXDyh/TtFmXT0MyPB0+P71J6Gp2VdRNb129H
         PkBQ==
X-Gm-Message-State: AFqh2kpTyOr005lgatPSDzDxcayExFOL0nkYuncv6hXfjSI9hm+ccnWE
	A/75uyP77h8AYa2NMaGfkgUoSJ2NI/PzbQoZZfZpew==
X-Google-Smtp-Source: AMrXdXuBLBdS8trWPvTGaNao7p2C7a8dRMOMRl/E0lOrIn4YlQnIQGhOOK63IJFqEU+b1mTSD15jdQ==
X-Received: by 2002:a05:6a21:3a48:b0:ad:4be8:5984 with SMTP id zu8-20020a056a213a4800b000ad4be85984mr8936693pzb.27.1674078930988;
        Wed, 18 Jan 2023 13:55:30 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id v11-20020a65460b000000b004b0591f673csm17659863pgq.33.2023.01.18.13.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 13:55:30 -0800 (PST)
Message-ID: <63c86ad2.650a0220.f5c8e.b3ed@mx.google.com>
Date: Wed, 18 Jan 2023 13:55:30 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip-rt
X-Kernelci-Kernel: v4.19.269-cip88-rt28
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip-rt baseline-nfs: 48 runs,
 19 regressions (v4.19.269-cip88-rt28)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Jan 2023 21:55:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10408

cip/linux-4.19.y-cip-rt baseline-nfs: 48 runs, 19 regressions (v4.19.269-ci=
p88-rt28)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =

asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =

at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | defconfi=
g+preempt_rt         | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | defconfi=
g+preempt_rt         | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defc...g+preempt_rt | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defc...g+preempt_rt | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =

dell-latitude...8665U-sarien | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =

imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | defconfi=
g+preempt_rt         | 1          =

imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =

imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defc...g+preempt_rt | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g+preempt_rt         | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip-rt/ke=
rnel/v4.19.269-cip88-rt28/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.19.y-cip-rt
  Describe: v4.19.269-cip88-rt28
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      2b470889b91ffbff27aafaf122ef1ff24fa4e82c =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/63c85c77fe504647f0915ed4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63c85c77fe504647f0915ed9
        new failure (last pass: v4.19.265-cip85-rt27)

    2023-01-18T20:54:08.176249  + set<8>[   17.986506] <LAVA_SIGNAL_ENDRUN =
0_dmesg 8785146_1.5.2.3.1>
    2023-01-18T20:54:08.176336   +x
    2023-01-18T20:54:08.285707  / # #
    2023-01-18T20:54:08.386703  export SHELL=3D/bin/sh
    2023-01-18T20:54:08.386913  #
    2023-01-18T20:54:08.487786  / # export SHELL=3D/bin/sh. /lava-8785146/e=
nvironment
    2023-01-18T20:54:08.488002  =

    2023-01-18T20:54:08.588914  / # . /lava-8785146/environment/lava-878514=
6/bin/lava-test-runner /lava-8785146/1
    2023-01-18T20:54:08.589229  =

    2023-01-18T20:54:08.593853  / # /lava-8785146/bin/lava-test-runner /lav=
a-8785146/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/63c85b723627c9d346915eb9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63c85b723627c9d346915ebe
        new failure (last pass: v4.19.265-cip85-rt27)

    2023-01-18T20:49:29.300265  + set +x
    2023-01-18T20:49:29.306761  <8>[   18.558473] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 8785073_1.5.2.3.1>
    2023-01-18T20:49:29.411579  / # #
    2023-01-18T20:49:29.512591  export SHELL=3D/bin/sh
    2023-01-18T20:49:29.512779  #
    2023-01-18T20:49:29.613506  / # export SHELL=3D/bin/sh. /lava-8785073/e=
nvironment
    2023-01-18T20:49:29.613760  =

    2023-01-18T20:49:29.714578  / # . /lava-8785073/environment/lava-878507=
3/bin/lava-test-runner /lava-8785073/1
    2023-01-18T20:49:29.714869  =

    2023-01-18T20:49:29.719690  / # /lava-8785073/bin/lava-test-runner /lav=
a-8785073/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63c85f5a70c839a4c8915f39

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-nfs-at91s=
am9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-nfs-at91s=
am9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/armel/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63c85f5a70c839a4c8915f3e
        new failure (last pass: v4.19.265-cip85-rt27)

    2023-01-18T21:06:21.568995  + set +x<LAVA_SIGNAL_ENDRUN 0_dmesg 138420_=
1.6.2.4.1>
    2023-01-18T21:06:21.685796  #
    2023-01-18T21:06:21.790866  / # #export SHELL=3D/bin/sh
    2023-01-18T21:06:21.791696  =

    2023-01-18T21:06:21.893598  / # export SHELL=3D/bin/sh. /lava-138420/en=
vironment
    2023-01-18T21:06:21.894393  =

    2023-01-18T21:06:21.996493  / # . /lava-138420/environment/lava-138420/=
bin/lava-test-runner /lava-138420/1
    2023-01-18T21:06:21.997896  =

    2023-01-18T21:06:22.004184  / # /lava-138420/bin/lava-test-runner /lava=
-138420/1
    2023-01-18T21:06:22.358841  + export TESTRUN_ID=3D1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c85f789d3faa6398915ed7

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-bla=
ck.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-bla=
ck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63c85f789d3faa6398915edc
        new failure (last pass: v4.19.265-cip85-rt27)

    2023-01-18T21:06:55.272000  <8>[   46.707618] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 138514_1.6.2.4.1>
    2023-01-18T21:06:55.396689  / # #
    2023-01-18T21:06:55.499726  export SHELL=3D/bin/sh
    2023-01-18T21:06:55.500477  #
    2023-01-18T21:06:55.602189  / # export SHELL=3D/bin/sh. /lava-138514/en=
vironment
    2023-01-18T21:06:55.602947  =

    2023-01-18T21:06:55.704696  / # . /lava-138514/environment/lava-138514/=
bin/lava-test-runner /lava-138514/1
    2023-01-18T21:06:55.705879  =

    2023-01-18T21:06:55.709824  / # /lava-138514/bin/lava-test-runner /lava=
-138514/1
    2023-01-18T21:06:55.894834  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | defconfi=
g+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/63c85fc649f5d8d898915eb9

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-nfs-bea=
glebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-nfs-bea=
glebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63c85fc649f5d8d898915ebe
        new failure (last pass: v4.19.265-cip85-rt27)

    2023-01-18T21:07:59.177041  <8>[   51.643136] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 138528_1.6.2.4.1>
    2023-01-18T21:07:59.291053  / # #
    2023-01-18T21:07:59.392829  export SHELL=3D/bin/sh
    2023-01-18T21:07:59.393302  #
    2023-01-18T21:07:59.494862  / # export SHELL=3D/bin/sh. /lava-138528/en=
vironment
    2023-01-18T21:07:59.495308  =

    2023-01-18T21:07:59.596806  / # . /lava-138528/environment/lava-138528/=
bin/lava-test-runner /lava-138528/1
    2023-01-18T21:07:59.597579  =

    2023-01-18T21:07:59.601307  / # /lava-138528/bin/lava-test-runner /lava=
-138528/1
    2023-01-18T21:07:59.800894  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c865ac06df8890d8915ed5

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/defconfig/gcc-10/lab-cip/baseline-nfs-beaglebone-black.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/defconfig/gcc-10/lab-cip/baseline-nfs-beaglebone-black.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63c865ac06df8890d8915ed8
        new failure (last pass: v4.19.265-cip85-rt27)

    2023-01-18T21:33:04.155923  [  105.240622] <LAVA_SIGNAL_ENDRUN 0_dmesg =
828043_1.6.2.4.1>
    2023-01-18T21:33:04.476363  / # #
    2023-01-18T21:33:04.579220  export SHELL=3D/bin/sh
    2023-01-18T21:33:04.580117  #
    2023-01-18T21:33:04.682067  / # export SHELL=3D/bin/sh. /lava-828043/en=
vironment
    2023-01-18T21:33:04.682817  =

    2023-01-18T21:33:04.784774  / # . /lava-828043/environment/lava-828043/=
bin/lava-test-runner /lava-828043/1
    2023-01-18T21:33:04.785983  =

    2023-01-18T21:33:04.791944  / # /lava-828043/bin/lava-test-runner /lava=
-828043/1
    2023-01-18T21:33:07.887656  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | defconfi=
g+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/63c86701c7e9d7ff40915ec4

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/defconfig+preempt_rt/gcc-10/lab-cip/baseline-nfs-beagleb=
one-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/defconfig+preempt_rt/gcc-10/lab-cip/baseline-nfs-beagleb=
one-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63c86701c7e9d7ff40915ec7
        new failure (last pass: v4.19.265-cip85-rt27)

    2023-01-18T21:38:57.362986  <8>[   52.644632] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 828049_1.6.2.4.1>
    2023-01-18T21:38:57.524400  / # #
    2023-01-18T21:38:57.627193  export SHELL=3D/bin/sh
    2023-01-18T21:38:57.627988  #
    2023-01-18T21:38:57.729943  / # export SHELL=3D/bin/sh. /lava-828049/en=
vironment
    2023-01-18T21:38:57.730707  =

    2023-01-18T21:38:57.832675  / # . /lava-828049/environment/lava-828049/=
bin/lava-test-runner /lava-828049/1
    2023-01-18T21:38:57.833921  =

    2023-01-18T21:38:57.839965  / # /lava-828049/bin/lava-test-runner /lava=
-828049/1
    2023-01-18T21:38:58.129110  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63c85ed810bd636001915eb9

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-beagl=
ebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-beagl=
ebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63c85ed810bd636001915ebe
        new failure (last pass: v4.19.265-cip85-rt27)

    2023-01-18T21:03:59.173367  <8>[   52.802925] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 138503_1.6.2.4.1>
    2023-01-18T21:03:59.292514  / # #
    2023-01-18T21:03:59.394269  export SHELL=3D/bin/sh
    2023-01-18T21:03:59.394779  #
    2023-01-18T21:03:59.496044  / # export SHELL=3D/bin/sh. /lava-138503/en=
vironment
    2023-01-18T21:03:59.496365  =

    2023-01-18T21:03:59.597782  / # . /lava-138503/environment/lava-138503/=
bin/lava-test-runner /lava-138503/1
    2023-01-18T21:03:59.598347  =

    2023-01-18T21:03:59.602165  / # /lava-138503/bin/lava-test-runner /lava=
-138503/1
    2023-01-18T21:03:59.751346  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defc...g+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/63c861344c1e7875ea915ec7

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-broonie/baselin=
e-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-broonie/baselin=
e-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63c861344c1e7875ea915ecc
        new failure (last pass: v4.19.265-cip85-rt27)

    2023-01-18T21:13:45.842978  <8>[   60.544408] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 138538_1.6.2.4.1>
    2023-01-18T21:13:46.114848  / # #
    2023-01-18T21:13:46.229742  export SHELL=3D/bin/sh
    2023-01-18T21:13:46.234201  #
    2023-01-18T21:13:46.341875  / # export SHELL=3D/bin/sh. /lava-138538/en=
vironment
    2023-01-18T21:13:46.348862  =

    2023-01-18T21:13:46.353120  / # . /lava-138538/environment
    2023-01-18T21:13:46.464109  /lava-138538/bin/lava-test-runner /lava-138=
538/1
    2023-01-18T21:13:46.474985  / # /lava-138538/bin/lava-test-runner /lava=
-138538/1
    2023-01-18T21:13:47.069824  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8641c1b7b380965915ebb

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebon=
e-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebon=
e-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63c8641c1b7b380965915ebe
        new failure (last pass: v4.19.265-cip85-rt27)

    2023-01-18T21:26:31.047351  [  214.442065] <LAVA_SIGNAL_ENDRUN 0_dmesg =
828039_1.6.2.4.1>
    2023-01-18T21:26:31.470429  / # #
    2023-01-18T21:26:31.573337  export SHELL=3D/bin/sh
    2023-01-18T21:26:31.574131  #
    2023-01-18T21:26:31.675983  / # export SHELL=3D/bin/sh. /lava-828039/en=
vironment
    2023-01-18T21:26:31.676756  =

    2023-01-18T21:26:31.778717  / # . /lava-828039/environment/lava-828039/=
bin/lava-test-runner /lava-828039/1
    2023-01-18T21:26:31.780024  =

    2023-01-18T21:26:31.785338  / # /lava-828039/bin/lava-test-runner /lava=
-828039/1
    2023-01-18T21:26:35.167129  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defc...g+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/63c868b642bbc4f72f915ef5

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-cip/baseline-nf=
s-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-cip/baseline-nf=
s-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63c868b642bbc4f72f915ef8
        new failure (last pass: v4.19.265-cip85-rt27)

    2023-01-18T21:46:15.328887  + set +x
    2023-01-18T21:46:15.336830  [   50.347119] <LAVA_SIGNAL_ENDRUN 0_dmesg =
828057_1.6.2.4.1>
    2023-01-18T21:46:15.585508  / # #
    2023-01-18T21:46:15.687850  export SHELL=3D/bin/sh
    2023-01-18T21:46:15.688347  #
    2023-01-18T21:46:15.789714  / # export SHELL=3D/bin/sh. /lava-828057/en=
vironment
    2023-01-18T21:46:15.790083  =

    2023-01-18T21:46:15.891264  / # . /lava-828057/environment/lava-828057/=
bin/lava-test-runner /lava-828057/1
    2023-01-18T21:46:15.892094  =

    2023-01-18T21:46:15.897957  / # /lava-828057/bin/lava-test-runner /lava=
-828057/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63c86992d6c324ca46915f3f

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebo=
ne-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebo=
ne-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63c86992d6c324ca46915f42
        new failure (last pass: v4.19.265-cip85-rt27)

    2023-01-18T21:49:55.587959  + set +x<8>[   52.703428] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 828065_1.6.2.4.1>
    2023-01-18T21:49:55.588462  =

    2023-01-18T21:49:55.759668  #
    2023-01-18T21:49:55.862926  / # #export SHELL=3D/bin/sh
    2023-01-18T21:49:55.863687  =

    2023-01-18T21:49:55.965653  / # export SHELL=3D/bin/sh. /lava-828065/en=
vironment
    2023-01-18T21:49:55.966417  =

    2023-01-18T21:49:56.068398  / # . /lava-828065/environment/lava-828065/=
bin/lava-test-runner /lava-828065/1
    2023-01-18T21:49:56.069633  =

    2023-01-18T21:49:56.076597  / # /lava-828065/bin/lava-test-runner /lava=
-828065/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
dell-latitude...8665U-sarien | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/63c85d7aea4ddb9aed915f1e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-nfs-dell-latitude-5400-8665U-sarien.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-nfs-dell-latitude-5400-8665U-sarien.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63c85d7aea4ddb9ae=
d915f1f
        new failure (last pass: v4.19.265-cip85-rt27) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | defconfi=
g+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/63c85e0fec0ebb8af3915ed9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-nfs-i=
mx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-nfs-i=
mx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63c85e0fec0ebb8af3915ede
        new failure (last pass: v4.19.265-cip85-rt27)

    2023-01-18T21:00:56.734123  / # #
    2023-01-18T21:00:56.837183  export SHELL=3D/bin/sh
    2023-01-18T21:00:56.838016  #
    2023-01-18T21:00:56.939984  / # export SHELL=3D/bin/sh. /lava-8785246/e=
nvironment
    2023-01-18T21:00:56.940851  =

    2023-01-18T21:00:57.043016  / # . /lava-8785246/environment/lava-878524=
6/bin/lava-test-runner /lava-8785246/1
    2023-01-18T21:00:57.044291  =

    2023-01-18T21:00:57.056543  / # /lava-8785246/bin/lava-test-runner /lav=
a-8785246/1
    2023-01-18T21:00:57.238669  + export TESTRUN_ID=3D1_bootrr
    2023-01-18T21:00:57.238837  + cd /lava-8785246/1/tests/1_bootrr =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c85e1f09e6be4cda915ed8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/defconfig/gcc-10/lab-collabora/baseline-nfs-imx6q-sabrel=
ite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/defconfig/gcc-10/lab-collabora/baseline-nfs-imx6q-sabrel=
ite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63c85e1f09e6be4cda915edd
        new failure (last pass: v4.19.265-cip85-rt27)

    2023-01-18T21:01:05.531107  + set +x
    2023-01-18T21:01:05.536057  <8>[   30.429427] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 8785233_1.6.2.4.1>
    2023-01-18T21:01:05.649141  #
    2023-01-18T21:01:05.751231  / # #export SHELL=3D/bin/sh
    2023-01-18T21:01:05.751634  =

    2023-01-18T21:01:05.852954  / # export SHELL=3D/bin/sh. /lava-8785233/e=
nvironment
    2023-01-18T21:01:05.853473  =

    2023-01-18T21:01:05.954861  / # . /lava-8785233/environment/lava-878523=
3/bin/lava-test-runner /lava-8785233/1
    2023-01-18T21:01:05.955656  =

    2023-01-18T21:01:05.957068  / # /lava-8785233/bin/lava-test-runner /lav=
a-8785233/1 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63c85da79fec2acb74915ec7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-nfs-imx=
6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-nfs-imx=
6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63c85da79fec2acb74915ecc
        new failure (last pass: v4.19.265-cip85-rt27)

    2023-01-18T20:59:11.004877  / # #
    2023-01-18T20:59:11.107606  export SHELL=3D/bin/sh
    2023-01-18T20:59:11.108473  #
    2023-01-18T20:59:11.210215  / # export SHELL=3D/bin/sh. /lava-8785200/e=
nvironment
    2023-01-18T20:59:11.211033  =

    2023-01-18T20:59:11.312918  / # . /lava-8785200/environment/lava-878520=
0/bin/lava-test-runner /lava-8785200/1
    2023-01-18T20:59:11.314177  =

    2023-01-18T20:59:11.318321  / # /lava-8785200/bin/lava-test-runner /lav=
a-8785200/1
    2023-01-18T20:59:11.429782  + export TESTRUN_ID=3D1_bootrr
    2023-01-18T20:59:11.477787  + cd /lava-8785200/1/tests/1_bootrr =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defc...g+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/63c85e97554c71cce2915ebe

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-collabora/basel=
ine-nfs-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-collabora/basel=
ine-nfs-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63c85e97554c71cce2915ec3
        new failure (last pass: v4.19.265-cip85-rt27)

    2023-01-18T21:03:10.231132  / # #
    2023-01-18T21:03:10.334437  export SHELL=3D/bin/sh
    2023-01-18T21:03:10.335257  #
    2023-01-18T21:03:10.437552  / # export SHELL=3D/bin/sh. /lava-8785260/e=
nvironment
    2023-01-18T21:03:10.438361  =

    2023-01-18T21:03:10.540667  / # . /lava-8785260/environment/lava-878526=
0/bin/lava-test-runner /lava-8785260/1
    2023-01-18T21:03:10.541944  =

    2023-01-18T21:03:10.552888  / # /lava-8785260/bin/lava-test-runner /lav=
a-8785260/1
    2023-01-18T21:03:10.712652  + export TESTRUN_ID=3D1_bootrr
    2023-01-18T21:03:10.728561  + cd /lava-8785260/1/tests/1_bootrr =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/63c865530981afea4b915ee0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm64/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-nfs-s=
un50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm64/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-nfs-s=
un50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63c865530981afea4b915ee3
        new failure (last pass: v4.19.265-cip85-rt27)

    2023-01-18T21:31:43.793250  <8>[   34.649168] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 138389_1.6.2.4.1>
    2023-01-18T21:31:43.970766  / # #
    2023-01-18T21:31:44.072188  export SHELL=3D/bin/sh
    2023-01-18T21:31:44.073151  #
    2023-01-18T21:31:44.175247  / # export SHELL=3D/bin/sh. /lava-138389/en=
vironment
    2023-01-18T21:31:44.175814  =

    2023-01-18T21:31:44.277318  / # . /lava-138389/environment/lava-138389/=
bin/lava-test-runner /lava-138389/1
    2023-01-18T21:31:44.278003  =

    2023-01-18T21:31:44.284020  / # /lava-138389/bin/lava-test-runner /lava=
-138389/1
    2023-01-18T21:31:44.503343  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c865e2d0ff234ab4915ebf

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-sun50i-a64-p=
ine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-sun50i-a64-p=
ine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63c865e2d0ff234ab4915ec4
        new failure (last pass: v4.19.265-cip85-rt27)

    2023-01-18T21:34:00.582284  <8>[   27.209797] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 138449_1.6.2.4.1>
    2023-01-18T21:34:00.691626  / # #
    2023-01-18T21:34:00.793077  export SHELL=3D/bin/sh
    2023-01-18T21:34:00.793758  #
    2023-01-18T21:34:00.895325  / # export SHELL=3D/bin/sh. /lava-138449/en=
vironment
    2023-01-18T21:34:00.895866  =

    2023-01-18T21:34:00.997713  / # . /lava-138449/environment/lava-138449/=
bin/lava-test-runner /lava-138449/1
    2023-01-18T21:34:00.998458  =

    2023-01-18T21:34:01.001903  / # /lava-138449/bin/lava-test-runner /lava=
-138449/1
    2023-01-18T21:34:01.074659  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =20

