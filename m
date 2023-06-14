Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCB8EB64D8
	for <webhook@archiver.kernel.org>; Wed, 14 Jun 2023 12:46:45 +0000 (UTC)
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
 by mx.groups.io with SMTP id smtpd.web11.10725.1686746803665398179
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 14 Jun 2023 05:46:43 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=NZtZcXXf;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.161.46, mailfrom: bot@kernelci.org)
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-55ab0f7778cso520664eaf.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 14 Jun 2023 05:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686746802; x=1689338802;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zZwRJ0DbQsl04Kb0dRv61muQLK1JtKPWjQp0SppGWKM=;
        b=NZtZcXXfs8DUo6mCLFfQVGZRAnl0ix9tUZBAzc3ppi3UuXXkV3ETEtBeIbDqsjFx/S
         RlBVRW1qlfG63MFssqm0/yib8/gbkRW/NZLZOU6ZBEVtEjrrAUMrySY55U/+LT34b4Ix
         scqTpR5xDMAVQE4IfYaMkU2nFXTDShFmli4bbAm6e2vLfnmVWbc9nA9x9N+76DV1/ZDj
         YzkJCNWHuIteEOtliLceAnMXue9u6gt2VaA2MBA9hPuxDUPWrqi67W7EhaOep/lvv40X
         wbUA35md5alICUz+RvZUNJpVRL9uig3H0NYxw/4T9GafNFNXQELk9apCpkdu+BvAK/0v
         ijfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686746802; x=1689338802;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zZwRJ0DbQsl04Kb0dRv61muQLK1JtKPWjQp0SppGWKM=;
        b=Xk+Be+jSJjYqcoHs2DkY5t0UOTOxcIl8b1aNDhtbP+wMhF/xBR9DkYPtw3JR20jKLz
         yJpc2Sp6YeH6C/syvpkmn/F1qucX5C1lBchoRfx5+QD7iJ7sKFBGaLfQtn8V/G4a1rdJ
         L+HypUr1Ohs7aaQ7Cw3lWcl1unc4JGd3TLjmqZqHwkAYhevZdWYd0NSS7e6apVTKRbu/
         M0MmMj0CWHjc/u1MLU/HSK+qlgHsp9aCzOaHOX/Er86//e6Wy/mCR/uhHb3f1FqYBRgv
         CU7m4nxD6h2Wg1D87doiwVqD4PKzhNRwoA07y6i2fWo4DMko61gK0vLIv4PBUNa0OQWX
         DTyg==
X-Gm-Message-State: AC+VfDymeos7R02qIa+h4x4nH8a9xWiYQDsKfCUPYBfUlfLklGI5l1Rb
	7AOVopHZFW0e5OBLszNCzpEFVnHGCJWgzwjfYNIVOQ==
X-Google-Smtp-Source: ACHHUZ43gZB5BK1vHQI5RGukyHMbA0WfFvSkONG5vOLErFGoRWkiF/bPXxl0d7BOSQkfi2SQkKptUA==
X-Received: by 2002:a05:6808:1386:b0:39a:bd0e:43d with SMTP id c6-20020a056808138600b0039abd0e043dmr10655029oiw.36.1686746802258;
        Wed, 14 Jun 2023 05:46:42 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x35-20020a17090a6c2600b0025bdaaf0cfesm6435845pjj.28.2023.06.14.05.46.41
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 05:46:41 -0700 (PDT)
Message-ID: <6489b6b1.170a0220.cdf2f.c3e6@mx.google.com>
Date: Wed, 14 Jun 2023 05:46:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.284-cip99-114-g02e97826987bf
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 30 runs,
 7 regressions (v4.19.284-cip99-114-g02e97826987bf)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Jun 2023 12:46:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12013

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 30 runs, 7 regress=
ions (v4.19.284-cip99-114-g02e97826987bf)

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
Flinux-4.19.y-cip-rc/kernel/v4.19.284-cip99-114-g02e97826987bf/plan/baselin=
e-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.284-cip99-114-g02e97826987bf
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      02e97826987bf9401c9a3fb9d2d52ab90340ea1d =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6489b02556ed828cf330612e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6489b02556ed828cf3306133
        failing since 146 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-06-14T12:18:32.124281  + set +x

    2023-06-14T12:18:32.130898  <8>[   17.996145] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10724531_1.5.2.3.1>

    2023-06-14T12:18:32.235503  / # #

    2023-06-14T12:18:32.336244  export SHELL=3D/bin/sh

    2023-06-14T12:18:32.336466  #

    2023-06-14T12:18:32.437022  / # export SHELL=3D/bin/sh. /lava-10724531/=
environment

    2023-06-14T12:18:32.437259  =


    2023-06-14T12:18:32.537804  / # . /lava-10724531/environment/lava-10724=
531/bin/lava-test-runner /lava-10724531/1

    2023-06-14T12:18:32.538158  =


    2023-06-14T12:18:32.542986  / # /lava-10724531/bin/lava-test-runner /la=
va-10724531/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6489b0553af022f3d93061bf

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6489b0553af022f3d93061c4
        failing since 146 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-06-14T12:19:16.558784  + set +x

    2023-06-14T12:19:16.565084  <8>[   21.200795] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10724486_1.5.2.3.1>

    2023-06-14T12:19:16.669900  / # #

    2023-06-14T12:19:16.770491  export SHELL=3D/bin/sh

    2023-06-14T12:19:16.770708  #

    2023-06-14T12:19:16.871302  / # export SHELL=3D/bin/sh. /lava-10724486/=
environment

    2023-06-14T12:19:16.871494  =


    2023-06-14T12:19:16.972035  / # . /lava-10724486/environment/lava-10724=
486/bin/lava-test-runner /lava-10724486/1

    2023-06-14T12:19:16.972294  =


    2023-06-14T12:19:16.977350  / # /lava-10724486/bin/lava-test-runner /la=
va-10724486/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6489b2aea9db2a9c06306141

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm/multi_v7_defconfig/gcc-=
10/lab-broonie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm/multi_v7_defconfig/gcc-=
10/lab-broonie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6489b2aea9db2a9c0630616c
        failing since 146 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-06-14T12:28:42.180707  [   57.627540] <LAVA_SIGNAL_ENDRUN 0_dmesg =
610255_1.6.2.4.1>
    2023-06-14T12:28:42.314653  / # #
    2023-06-14T12:28:42.416608  export SHELL=3D/bin/sh
    2023-06-14T12:28:42.417061  #
    2023-06-14T12:28:42.518559  / # export SHELL=3D/bin/sh. /lava-610255/en=
vironment
    2023-06-14T12:28:42.519016  =

    2023-06-14T12:28:42.620474  / # . /lava-610255/environment/lava-610255/=
bin/lava-test-runner /lava-610255/1
    2023-06-14T12:28:42.621267  =

    2023-06-14T12:28:42.624195  / # /lava-610255/bin/lava-test-runner /lava=
-610255/1
    2023-06-14T12:28:42.830013  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-cip       | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6489b4d5b06fcfb0bc306174

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm/multi_v7_defconfig/gcc-=
10/lab-cip/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm/multi_v7_defconfig/gcc-=
10/lab-cip/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6489b4d5b06fcfb0bc306177
        failing since 146 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-06-14T12:38:05.435894  + set +x
    2023-06-14T12:38:05.437963  <8>[   41.728159] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 962947_1.6.2.4.1>
    2023-06-14T12:38:05.552916  / # #
    2023-06-14T12:38:05.654917  export SHELL=3D/bin/sh
    2023-06-14T12:38:05.655373  #
    2023-06-14T12:38:05.756775  / # export SHELL=3D/bin/sh. /lava-962947/en=
vironment
    2023-06-14T12:38:05.757250  =

    2023-06-14T12:38:05.858694  / # . /lava-962947/environment/lava-962947/=
bin/lava-test-runner /lava-962947/1
    2023-06-14T12:38:05.859497  =

    2023-06-14T12:38:05.861127  / # /lava-962947/bin/lava-test-runner /lava=
-962947/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6489ada0a5e2d1f49c306144

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm/multi_v7_defconfig/gcc-=
10/lab-collabora/baseline-nfs-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm/multi_v7_defconfig/gcc-=
10/lab-collabora/baseline-nfs-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6489ada0a5e2d1f49c306149
        failing since 146 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-06-14T12:07:56.493245  / # #

    2023-06-14T12:07:56.595369  export SHELL=3D/bin/sh

    2023-06-14T12:07:56.596112  #

    2023-06-14T12:07:56.697609  / # export SHELL=3D/bin/sh. /lava-10724212/=
environment

    2023-06-14T12:07:56.698284  =


    2023-06-14T12:07:56.799721  / # . /lava-10724212/environment/lava-10724=
212/bin/lava-test-runner /lava-10724212/1

    2023-06-14T12:07:56.800329  =


    2023-06-14T12:07:56.804806  / # /lava-10724212/bin/lava-test-runner /la=
va-10724212/1

    2023-06-14T12:07:56.990756  + export TESTRUN_ID=3D1_bootrr

    2023-06-14T12:07:56.991243  + cd /lava-10724212/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6489b08ed80d37ccdc306140

  Results:     77 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/6489b08ed80d37ccdc306146
        failing since 92 days (last pass: v4.19.273-cip92-277-g507c8d80b9e2=
0, first fail: v4.19.276-cip93-5-g2eb2a953ab59)

    2023-06-14T12:20:29.000407  [   40.316406] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-06-14T12:20:30.027680  /lava-10724257/1/../bin/lava-test-case

    2023-06-14T12:20:30.053198  [   41.370098] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/6489b08ed80d37ccdc306147
        failing since 92 days (last pass: v4.19.273-cip92-277-g507c8d80b9e2=
0, first fail: v4.19.276-cip93-5-g2eb2a953ab59)

    2023-06-14T12:20:28.918174  /lava-10724257/1/../bin/lava-test-case
   =

 =20

