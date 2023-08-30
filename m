Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BAEC83F15
	for <webhook@archiver.kernel.org>; Wed, 30 Aug 2023 19:04:20 +0000 (UTC)
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
 by mx.groups.io with SMTP id smtpd.web11.3334.1693422253072784505
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 30 Aug 2023 12:04:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=XMTVH0Jj;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.160.54, mailfrom: bot@kernelci.org)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-1c4c5375329so4065967fac.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 30 Aug 2023 12:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1693422252; x=1694027052; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bHKyYCixjMGBIS+OeibTX+UWqTciSDpgPnyYHPy7GUM=;
        b=XMTVH0Jj1MpOST9mNxGnF9XW/6FMbPKeNyji4kiRTAH9mHxMzv9HUn9FhOVLK81jnA
         8fOPLLLLAcRR5qYm/sfJtZNJtxjqX4jED0y5UHsvEgvhkiywbmK47Xn+xbU/ZYgHhTve
         dJnWfexWBjAEG5U4jgK+GLES+/pjczqP7x72Qs6wFZS1ydF+zo/3PvYHD3bMzujSzzTe
         uvse4rJNN8/MJyIqWQ6Xyb3sBE6LS9LnbIf1hktZf4+GZnBlririMyZuTq+3DYcQEiHc
         hOLNzZyoXufa2x7CHga2plHelpqH5/TbbJtxEoYM+a+l72vuF8bVuNDQG9Q0BhATsOsn
         zBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693422252; x=1694027052;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bHKyYCixjMGBIS+OeibTX+UWqTciSDpgPnyYHPy7GUM=;
        b=dMmuXvU9nuRYl1x05PBZ2jqTBQqWMH2zaPUWOJjDveLjveIIS+SJuBQmGGay/un150
         d1IyQHdxHo5Bnb7/KSfDwi9jiWL1oxlFvnMxI2FbfRFiDUs5clLvtry3SxTOGqLjjTV6
         SxeL7n99mQShQiQbh1gZs+0+2o0Z5haKNRxq5Jm/6Y075WmpxDP1ztcLoyH1w+jWWRwc
         Yr2Ywc/pmYvAII+RWvJy/hMfnPFc7XGwnpvZaUVx8J4LrRYN+jNDEcj+7M4pMWhd7AWT
         b0/l5SNqEtfQ3S5wB9iabQ4hebfrKucmCFpsa/Ab82etimzZZLFqMS5hnR95xMetjRR/
         5Hbw==
X-Gm-Message-State: AOJu0Yz0k0nxW2sFxUfLW07OTMArdZNOE0Dzbg2QGxgX3qdTbR/v5Ht2
	4HNVtYNzSXTNEq70u4f689s9+24+9AIb7ZqCFKs=
X-Google-Smtp-Source: AGHT+IHOvPCsfb2Dpoa9zPTkpXZV850N0TLYiR9OuO/yjk81mk3H6jecGkXxzYHzkQ03XKKcklM4/g==
X-Received: by 2002:a05:6871:1c4:b0:1b0:25b4:4b7a with SMTP id q4-20020a05687101c400b001b025b44b7amr3137589oad.51.1693422251592;
        Wed, 30 Aug 2023 12:04:11 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h7-20020a17090a3d0700b00268dac826d4sm1694867pjc.0.2023.08.30.12.04.10
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 12:04:10 -0700 (PDT)
Message-ID: <64ef92aa.170a0220.5af34.3b24@mx.google.com>
Date: Wed, 30 Aug 2023 12:04:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.292-cip102-130-g18b864070345b
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 20 runs,
 7 regressions (v4.19.292-cip102-130-g18b864070345b)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Aug 2023 19:04:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12918

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 20 runs, 7 regress=
ions (v4.19.292-cip102-130-g18b864070345b)

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
Flinux-4.19.y-cip-rc/kernel/v4.19.292-cip102-130-g18b864070345b/plan/baseli=
ne-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.292-cip102-130-g18b864070345b
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      18b864070345b810401a67174ba9abccd8dc9dd8 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef84424c38bed67e286d94

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/x86_64/x86_64_defconfig+x8=
6-chromebook/gcc-10/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/x86_64/x86_64_defconfig+x8=
6-chromebook/gcc-10/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64ef84424c38bed67e286d9d
        failing since 223 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-08-30T18:02:20.591681  + set<8>[   18.770787] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11385828_1.5.2.3.1>

    2023-08-30T18:02:20.592153   +x

    2023-08-30T18:02:20.698788  #

    2023-08-30T18:02:20.801612  / # #export SHELL=3D/bin/sh

    2023-08-30T18:02:20.802411  =


    2023-08-30T18:02:20.904028  / # export SHELL=3D/bin/sh. /lava-11385828/=
environment

    2023-08-30T18:02:20.904784  =


    2023-08-30T18:02:21.006528  / # . /lava-11385828/environment/lava-11385=
828/bin/lava-test-runner /lava-11385828/1

    2023-08-30T18:02:21.007789  =


    2023-08-30T18:02:21.010348  / # /lava-11385828/bin/lava-test-runner /la=
va-11385828/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef843a4c38bed67e286d70

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/x86_64/x86_64_defconfig+x8=
6-chromebook/gcc-10/lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/x86_64/x86_64_defconfig+x8=
6-chromebook/gcc-10/lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64ef843a4c38bed67e286d79
        failing since 223 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-08-30T18:02:20.661764  + <8>[   20.898106] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11385850_1.5.2.3.1>

    2023-08-30T18:02:20.661900  set +x

    2023-08-30T18:02:20.767221  / # #

    2023-08-30T18:02:20.867916  export SHELL=3D/bin/sh

    2023-08-30T18:02:20.868130  #

    2023-08-30T18:02:20.968698  / # export SHELL=3D/bin/sh. /lava-11385850/=
environment

    2023-08-30T18:02:20.968893  =


    2023-08-30T18:02:21.069430  / # . /lava-11385850/environment/lava-11385=
850/bin/lava-test-runner /lava-11385850/1

    2023-08-30T18:02:21.069780  =


    2023-08-30T18:02:21.074307  / # /lava-11385850/bin/lava-test-runner /la=
va-11385850/1
 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef84ff1998cc4557286d8a

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm/multi_v7_defconfig/gcc=
-10/lab-broonie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm/multi_v7_defconfig/gcc=
-10/lab-broonie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64ef84ff1998cc4557286db9
        failing since 223 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-08-30T18:05:12.285559  <8>[   47.611701] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 79645_1.6.2.4.1>
    2023-08-30T18:05:12.403556  / # #
    2023-08-30T18:05:12.506670  export SHELL=3D/bin/sh
    2023-08-30T18:05:12.507555  #
    2023-08-30T18:05:12.609614  / # export SHELL=3D/bin/sh. /lava-79645/env=
ironment
    2023-08-30T18:05:12.610499  =

    2023-08-30T18:05:12.712683  / # . /lava-79645/environment/lava-79645/bi=
n/lava-test-runner /lava-79645/1
    2023-08-30T18:05:12.714059  =

    2023-08-30T18:05:12.718124  / # /lava-79645/bin/lava-test-runner /lava-=
79645/1
    2023-08-30T18:05:12.919284  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-cip       | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef84ebdc3e3f7c34286d6c

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm/multi_v7_defconfig/gcc=
-10/lab-cip/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm/multi_v7_defconfig/gcc=
-10/lab-cip/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64ef84ebdc3e3f7c34286d6f
        failing since 223 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-08-30T18:04:51.529137  + set +x
    2023-08-30T18:04:51.531384  <8>[   40.895719] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1002990_1.6.2.4.1>
    2023-08-30T18:04:51.646541  / # #
    2023-08-30T18:04:51.748373  export SHELL=3D/bin/sh
    2023-08-30T18:04:51.748867  #
    2023-08-30T18:04:51.850272  / # export SHELL=3D/bin/sh. /lava-1002990/e=
nvironment
    2023-08-30T18:04:51.850767  =

    2023-08-30T18:04:51.952207  / # . /lava-1002990/environment/lava-100299=
0/bin/lava-test-runner /lava-1002990/1
    2023-08-30T18:04:51.953029  =

    2023-08-30T18:04:51.954500  / # /lava-1002990/bin/lava-test-runner /lav=
a-1002990/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef84c594f726db75286ddc

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm/multi_v7_defconfig/gcc=
-10/lab-collabora/baseline-nfs-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm/multi_v7_defconfig/gcc=
-10/lab-collabora/baseline-nfs-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64ef84c594f726db75286de5
        failing since 223 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-08-30T18:05:48.242625  / # #

    2023-08-30T18:05:48.344614  export SHELL=3D/bin/sh

    2023-08-30T18:05:48.345236  #

    2023-08-30T18:05:48.446536  / # export SHELL=3D/bin/sh. /lava-11385871/=
environment

    2023-08-30T18:05:48.447225  =


    2023-08-30T18:05:48.548692  / # . /lava-11385871/environment/lava-11385=
871/bin/lava-test-runner /lava-11385871/1

    2023-08-30T18:05:48.549785  =


    2023-08-30T18:05:48.551555  / # /lava-11385871/bin/lava-test-runner /la=
va-11385871/1

    2023-08-30T18:05:48.714347  + export TESTRUN_ID=3D1_bootrr

    2023-08-30T18:05:48.714759  + cd /lava-11385871/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64ef8b07684e71fb98286d6e

  Results:     77 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm64/defconfig+arm64-chro=
mebook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-130-g18b864070345b/arm64/defconfig+arm64-chro=
mebook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/64ef8b07684e71fb98286d78
        failing since 169 days (last pass: v4.19.273-cip92-277-g507c8d80b9e=
20, first fail: v4.19.276-cip93-5-g2eb2a953ab59)

    2023-08-30T18:31:16.183308  <8>[   39.583538] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-08-30T18:31:17.222807  /lava-11385909/1/../bin/lava-test-case

    2023-08-30T18:31:17.250448  <8>[   40.652531] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/64ef8b07684e71fb98286d79
        failing since 169 days (last pass: v4.19.273-cip92-277-g507c8d80b9e=
20, first fail: v4.19.276-cip93-5-g2eb2a953ab59)

    2023-08-30T18:31:16.155000  /lava-11385909/1/../bin/lava-test-case
   =

 =20

