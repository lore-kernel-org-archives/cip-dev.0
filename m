Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF5AC6FA99
	for <webhook@archiver.kernel.org>; Sun, 12 Mar 2023 07:50:11 +0000 (UTC)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
 by mx.groups.io with SMTP id smtpd.web10.62739.1678607402698797802
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 11 Mar 2023 23:50:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=7UI0Ihx+;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.54, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f54.google.com with SMTP id ce8-20020a17090aff0800b0023a61cff2c6so11059646pjb.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 11 Mar 2023 23:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1678607402;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mLW1HU0XieC3kXZSqMMkcFsSOOv4uPaNQqCzBbjagEs=;
        b=7UI0Ihx+IYNDui0NBdeHF6k5Tr+Lbpgm9IojOzE9nQc1WaRmKCL3BTo5GWOk9XPuwE
         cuHiVqCz/Rzq8RLdcUM63KzlpNccodzN4gjpc6xdzwhMwvK0sNasPDElpb4y5mEUNvoc
         c+5pLTR2CjaLZtJJuwjBfmL/qhXqdmHz22StkowlqJRnT4H1/hpxwoCxZZt8M3c/P0Pk
         P9alzyCz6KwdEtDgs3cxFacfKsIRVdSEB11rVQFwmnnPBZGUqanFr57PUXiPDnwOwb8/
         FC9woOfLe7RwpVEoXibX86xLK4LRFYpenNxhyc/32D0Y6gVj7puqo20w6cStO2xSP+6u
         ZSJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678607402;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mLW1HU0XieC3kXZSqMMkcFsSOOv4uPaNQqCzBbjagEs=;
        b=08s2j+dWIMAtvBsLALkHLqbqhY5Xcke4CNYAS4Qxssr1YoO7KOyVXaEfl0BzrlgKzU
         +BQNnwi16HjQawWsYSnzVO6G5l5dUlvzVa46osmnd0qYpP4sn6MtdGxYTmLo7j+YpxNN
         EL9jBaDHRquByezX+vktxeChNZP5Aa7oJTbyy3+ssIyx4rvgOTh24nqyt6tr+sJ7bp2F
         ANBfH1vY8F75JSYKmycHyshg1oRWsYQnFS2eZkZvQudsZD8DwaRQofV4MumTA1R+Wbaj
         VLLBMJiaZ2vFvoHxqZlvgKD7mfjTqTJ55r/RWtQav2OZzkM5dRTXbRnbklfS2R9J2Bvp
         L30g==
X-Gm-Message-State: AO0yUKWWeFhEGTuJufsgH7IuknTVp8SEyLZWUDsiQsdDO+kWFqYjab39
	ACbooKXCrxtAqEVWCApIESFpnhp4TeMBCL7Rm8M=
X-Google-Smtp-Source: AK7set+A6gqOTib3KrzkFom/9mF34+pYZ6mhVhtIQK7JIno42s7XNXd8trJiCruSxy4qnbt+/EBA0A==
X-Received: by 2002:a17:902:c949:b0:19e:416e:abf5 with SMTP id i9-20020a170902c94900b0019e416eabf5mr7391595pla.34.1678607401508;
        Sat, 11 Mar 2023 23:50:01 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a20-20020a170902b59400b0019ac23cb6edsm2439728pls.181.2023.03.11.23.50.00
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 23:50:01 -0800 (PST)
Message-ID: <640d8429.170a0220.51cab.4332@mx.google.com>
Date: Sat, 11 Mar 2023 23:50:01 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.19.273-cip92-277-g507c8d80b9e20
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 35 runs,
 11 regressions (v4.19.273-cip92-277-g507c8d80b9e20)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 12 Mar 2023 07:50:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10981

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 35 runs, 11 regres=
sions (v4.19.273-cip92-277-g507c8d80b9e20)

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

hip07-d05                 | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =

imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 4          =

sun50i-a64-pine64-plus    | arm64  | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.273-cip92-277-g507c8d80b9e20/plan/baselin=
e-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.273-cip92-277-g507c8d80b9e20
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      507c8d80b9e20db87bb0fbf5ce478b7f2c81093a =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/640d7c1501896985408c862f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230303.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/640d7c1501896985408c8638
        failing since 51 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-12T07:15:18.557737  + set +x[   19.157795] <LAVA_SIGNAL_ENDRUN =
0_dmesg 9567914_1.5.2.3.1>

    2023-03-12T07:15:18.558353  =


    2023-03-12T07:15:18.667025  / # #

    2023-03-12T07:15:18.770092  export SHELL=3D/bin/sh

    2023-03-12T07:15:18.771051  #

    2023-03-12T07:15:18.873311  / # export SHELL=3D/bin/sh. /lava-9567914/e=
nvironment

    2023-03-12T07:15:18.874259  =


    2023-03-12T07:15:18.976470  / # . /lava-9567914/environment/lava-956791=
4/bin/lava-test-runner /lava-9567914/1

    2023-03-12T07:15:18.977824  =


    2023-03-12T07:15:18.982943  / # /lava-9567914/bin/lava-test-runner /lav=
a-9567914/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/640d7c231f26c891128c8647

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230303.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/640d7c231f26c891128c8650
        failing since 51 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-12T07:15:26.507390  [   21.134931] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-03-12T07:15:26.514428  + [   21.144720] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 9567977_1.5.2.3.1>

    2023-03-12T07:15:26.514722  set +x

    2023-03-12T07:15:26.627401  #

    2023-03-12T07:15:26.728569  / # #export SHELL=3D/bin/sh

    2023-03-12T07:15:26.728791  =


    2023-03-12T07:15:26.829666  / # export SHELL=3D/bin/sh. /lava-9567977/e=
nvironment

    2023-03-12T07:15:26.829888  =


    2023-03-12T07:15:26.930556  / # . /lava-9567977/environment/lava-956797=
7/bin/lava-test-runner /lava-9567977/1

    2023-03-12T07:15:26.930895  =

 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/640d7cdc687471bc1c8c8648

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm/multi_v7_defconfig/gcc-=
10/lab-broonie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm/multi_v7_defconfig/gcc-=
10/lab-broonie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230303.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/640d7cdc687471bc1c8c8651
        failing since 51 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-12T07:18:31.983552  [   47.243505] <LAVA_SIGNAL_ENDRUN 0_dmesg =
148182_1.6.2.4.1>
    2023-03-12T07:18:32.102959  / # #
    2023-03-12T07:18:32.205134  export SHELL=3D/bin/sh
    2023-03-12T07:18:32.205715  #
    2023-03-12T07:18:32.307183  / # export SHELL=3D/bin/sh. /lava-148182/en=
vironment
    2023-03-12T07:18:32.307763  =

    2023-03-12T07:18:32.410034  / # . /lava-148182/environment/lava-148182/=
bin/lava-test-runner /lava-148182/1
    2023-03-12T07:18:32.411335  =

    2023-03-12T07:18:32.414031  / # /lava-148182/bin/lava-test-runner /lava=
-148182/1
    2023-03-12T07:18:32.595225  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-cip       | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/640d83e037511818a78c8652

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm/multi_v7_defconfig/gcc-=
10/lab-cip/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm/multi_v7_defconfig/gcc-=
10/lab-cip/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230303.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/640d83e037511818a78c8659
        failing since 51 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-12T07:48:35.476787  <8>[   43.381095] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 873124_1.6.2.4.1>
    2023-03-12T07:48:35.635914  / # #
    2023-03-12T07:48:35.738700  export SHELL=3D/bin/sh
    2023-03-12T07:48:35.739455  #
    2023-03-12T07:48:35.841459  / # export SHELL=3D/bin/sh. /lava-873124/en=
vironment
    2023-03-12T07:48:35.842212  =

    2023-03-12T07:48:35.944132  / # . /lava-873124/environment/lava-873124/=
bin/lava-test-runner /lava-873124/1
    2023-03-12T07:48:35.945358  =

    2023-03-12T07:48:35.951393  / # /lava-873124/bin/lava-test-runner /lava=
-873124/1
    2023-03-12T07:48:36.196705  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hip07-d05                 | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/640d809812969639808c8636

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm64/defconfig/gcc-10/lab-=
collabora/baseline-nfs-hip07-d05.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm64/defconfig/gcc-10/lab-=
collabora/baseline-nfs-hip07-d05.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230303.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/640d8098129696398=
08c8637
        new failure (last pass: v4.19.273-cip92-24-g2070ce514972) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/640d804e7ec36a1b978c8665

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm/multi_v7_defconfig/gcc-=
10/lab-collabora/baseline-nfs-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm/multi_v7_defconfig/gcc-=
10/lab-collabora/baseline-nfs-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230303.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/640d804e7ec36a1b978c866e
        failing since 51 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-12T07:33:21.794560  / # #

    2023-03-12T07:33:21.897577  export SHELL=3D/bin/sh

    2023-03-12T07:33:21.898403  #

    2023-03-12T07:33:22.000689  / # export SHELL=3D/bin/sh. /lava-9567994/e=
nvironment

    2023-03-12T07:33:22.001537  =


    2023-03-12T07:33:22.103378  / # . /lava-9567994/environment/lava-956799=
4/bin/lava-test-runner /lava-9567994/1

    2023-03-12T07:33:22.104640  =


    2023-03-12T07:33:22.117201  / # /lava-9567994/bin/lava-test-runner /lav=
a-9567994/1

    2023-03-12T07:33:22.228962  + export TESTRUN_ID=3D1_bootrr

    2023-03-12T07:33:22.277788  + cd /lava-9567994/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 4          =


  Details:     https://kernelci.org/test/plan/id/640d7da52b02ebfb678c865e

  Results:     79 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230303.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rk3399-gru-sound-driver-rt5514-present: https://ker=
nelci.org/test/case/id/640d7da52b02ebfb678c8699
        failing since 51 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-12T07:21:53.108048  <8>[   37.320561] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-max98357A-present RESULT=3Dfail>

    2023-03-12T07:21:53.129233  seq: invalid floating point argument: =E2=
=80=98sound/RT5514=E2=80=99

    2023-03-12T07:21:53.133342  Try 'seq --help' for more information.

    2023-03-12T07:21:53.136919  /lava-9568077/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-max98357A-present: https://=
kernelci.org/test/case/id/640d7da52b02ebfb678c869a
        failing since 51 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-12T07:21:53.058827  <8>[   37.271479] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-dp-present RESULT=3Dfail>

    2023-03-12T07:21:53.080043  seq: invalid floating point argument: =E2=
=80=98sound/MAX98357A=E2=80=99

    2023-03-12T07:21:53.083585  Try 'seq --help' for more information.

    2023-03-12T07:21:53.087238  /lava-9568077/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-dp-present: https://kernelc=
i.org/test/case/id/640d7da52b02ebfb678c869b
        failing since 51 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-12T07:21:53.032300  seq: invalid floating point argument: =E2=
=80=98sound/DP=E2=80=99

    2023-03-12T07:21:53.036027  Try 'seq --help' for more information.

    2023-03-12T07:21:53.040147  /lava-9568077/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-da7219-present: https://ker=
nelci.org/test/case/id/640d7da52b02ebfb678c869c
        failing since 51 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-12T07:21:52.962094  <8>[   37.176522] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-present RESULT=3Dpass>

    2023-03-12T07:21:52.989599  seq: invalid floating point argument: =E2=
=80=98sound/DA7219=E2=80=99

    2023-03-12T07:21:52.993479  Try 'seq --help' for more information.

    2023-03-12T07:21:52.996543  /lava-9568077/1/../bin/lava-test-case

    2023-03-12T07:21:53.013273  <8>[   37.227355] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-da7219-present RESULT=3Dfail>
   =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
sun50i-a64-pine64-plus    | arm64  | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/640d7ddd1a4e3a9b458c8630

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm64/defconfig/gcc-10/lab-=
broonie/baseline-nfs-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm64/defconfig/gcc-10/lab-=
broonie/baseline-nfs-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230303.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/640d7ddd1a4e3a9b458c8638
        failing since 51 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-12T07:22:50.754328  <8>[   22.218103] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 148202_1.6.2.4.1>
    2023-03-12T07:22:50.862460  / # #
    2023-03-12T07:22:50.964152  export SHELL=3D/bin/sh
    2023-03-12T07:22:50.964561  #
    2023-03-12T07:22:51.065937  / # export SHELL=3D/bin/sh. /lava-148202/en=
vironment
    2023-03-12T07:22:51.066313  =

    2023-03-12T07:22:51.167528  / # . /lava-148202/environment/lava-148202/=
bin/lava-test-runner /lava-148202/1
    2023-03-12T07:22:51.167958  =

    2023-03-12T07:22:51.172201  / # /lava-148202/bin/lava-test-runner /lava=
-148202/1
    2023-03-12T07:22:51.246084  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =20

