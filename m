Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4BDEB64DA
	for <webhook@archiver.kernel.org>; Wed, 28 Jun 2023 11:23:07 +0000 (UTC)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
 by mx.groups.io with SMTP id smtpd.web10.13559.1687951380386501571
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 28 Jun 2023 04:23:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=PL56X3oT;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.180, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-553a1f13d9fso4537641a12.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 28 Jun 2023 04:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687951379; x=1690543379;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=idlSa+TK/EKIGU4LlZW51Hu74bpq0krAtfE6KTeMDjg=;
        b=PL56X3oT08UO5HjbaK2ByjWO+KuN2YRvH5DZCrBqEXPn8acznU5u2te4eiw49FTBzI
         ZzLbuwNcTuboiy2BfdG+LUodRVB7uKHdFfu+GmHuGAijoTX3lsVBZUvlInE+Y2/pslYl
         cU4d4+LKCxqoEAxg3SZyZzwd35AqASrKKO4YgVKe9nys1nNua2dNr0bcmr4xsOLApZtS
         uif9MvWnAUoOVLyHsNJsOvF7nHaoGlq5fdtCn6rZQo6VERUDUcIjs/7ffkg6+lFZ7RYU
         p9TieIweFMp/ikfXUTdID1+yNS3Lb51KH91GTFe3gVgmQBRr9bz6nedvGoslbgDS2SKh
         oCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687951379; x=1690543379;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=idlSa+TK/EKIGU4LlZW51Hu74bpq0krAtfE6KTeMDjg=;
        b=hdPhERdbNdUgtm2al7NzynFV9Husk3eA4apeyi4B9xZZZX9B/VgaQZbuQ/DbAeGRAZ
         TSOrWVSDHll3a+OAwNTPEGPIKYyzes2YBO90CLS/uM8XxG+z8ZLSUfeLfwM2tJ5RuuMT
         haUFQ+W1Zeqbpg8RHfkyJPqx3zlSHwWdQA+1/sqS7T4ZGxNqp0Tqu3hj8Tnf/zWjPjoi
         HSYw8NOSIBrdfVYM3buuIVwA0jSPh1HrqDbw0hF7UVK1vlt8JJS+8loAn3LxuWye7QbO
         zpXB+KPvf4Wy6M2pItJDMcdnB3IAdvdu5xCf24cvuccCaj79a5mc0gWlEwHQTniWpvpB
         dbKA==
X-Gm-Message-State: AC+VfDzelRRF6zHsIO4WmVkcaufbwLoP//2JuYyI36VsUK6QxrDXuzNt
	9Te+ya+78cZgvhn4B2ou7LhoIjg3rs/GkaoF3vsogQ==
X-Google-Smtp-Source: ACHHUZ4ETgMiXLEDM9n3MGoBgPK/l6pTVyTaLe36N14WgApIeZdX9SbsuCmH4xiHXwBcfgEU+ltjOA==
X-Received: by 2002:a17:90a:1089:b0:25b:c8b7:9e5b with SMTP id c9-20020a17090a108900b0025bc8b79e5bmr34194577pja.31.1687951378856;
        Wed, 28 Jun 2023 04:22:58 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 29-20020a17090a199d00b0026334010a4fsm1617577pji.35.2023.06.28.04.22.57
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 04:22:57 -0700 (PDT)
Message-ID: <649c1811.170a0220.fbae1.3bd0@mx.google.com>
Date: Wed, 28 Jun 2023 04:22:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Kernel: v4.19.287-cip100-43-g1a6518aa81690
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 35 runs,
 7 regressions (v4.19.287-cip100-43-g1a6518aa81690)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 28 Jun 2023 11:23:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12157

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 35 runs, 7 regress=
ions (v4.19.287-cip100-43-g1a6518aa81690)

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

imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =

sun50i-a64-pine64-plus    | arm64  | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.287-cip100-43-g1a6518aa81690/plan/baselin=
e-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.287-cip100-43-g1a6518aa81690
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      1a6518aa81690648c06d59e0ab6b686571c63fed =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649c0bea9ed001ab47306141

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.287-cip100-43-g1a6518aa81690/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.287-cip100-43-g1a6518aa81690/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/649c0bea9ed001ab4730614a
        failing since 160 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-06-28T10:30:47.160641  + set +x

    2023-06-28T10:30:47.167023  <8>[   18.888672] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10935859_1.5.2.3.1>

    2023-06-28T10:30:47.275585  / # #

    2023-06-28T10:30:47.378125  export SHELL=3D/bin/sh

    2023-06-28T10:30:47.378907  #

    2023-06-28T10:30:47.480608  / # export SHELL=3D/bin/sh. /lava-10935859/=
environment

    2023-06-28T10:30:47.481435  =


    2023-06-28T10:30:47.583054  / # . /lava-10935859/environment/lava-10935=
859/bin/lava-test-runner /lava-10935859/1

    2023-06-28T10:30:47.584160  =


    2023-06-28T10:30:47.589149  / # /lava-10935859/bin/lava-test-runner /la=
va-10935859/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649c0aed2a4bcdfe4530614b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.287-cip100-43-g1a6518aa81690/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.287-cip100-43-g1a6518aa81690/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/649c0aed2a4bcdfe45306154
        failing since 159 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-06-28T10:26:31.803019  + set +x

    2023-06-28T10:26:31.809748  <8>[   22.878715] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10935891_1.5.2.3.1>

    2023-06-28T10:26:31.915591  / # #

    2023-06-28T10:26:32.016295  export SHELL=3D/bin/sh

    2023-06-28T10:26:32.016477  #

    2023-06-28T10:26:32.116987  / # export SHELL=3D/bin/sh. /lava-10935891/=
environment

    2023-06-28T10:26:32.117202  =


    2023-06-28T10:26:32.217946  / # . /lava-10935891/environment/lava-10935=
891/bin/lava-test-runner /lava-10935891/1

    2023-06-28T10:26:32.219463  =


    2023-06-28T10:26:32.224011  / # /lava-10935891/bin/lava-test-runner /la=
va-10935891/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/649c0ecc12c04c95c9306174

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.287-cip100-43-g1a6518aa81690/arm/multi_v7_defconfig/gcc-=
10/lab-broonie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.287-cip100-43-g1a6518aa81690/arm/multi_v7_defconfig/gcc-=
10/lab-broonie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/649c0ecc12c04c95c93061a3
        failing since 160 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-06-28T10:42:15.905958  [   52.297533] <LAVA_SIGNAL_ENDRUN 0_dmesg =
671978_1.6.2.4.1>
    2023-06-28T10:42:16.024093  / # #
    2023-06-28T10:42:16.126112  export SHELL=3D/bin/sh
    2023-06-28T10:42:16.126641  #
    2023-06-28T10:42:16.228243  / # export SHELL=3D/bin/sh. /lava-671978/en=
vironment
    2023-06-28T10:42:16.228777  =

    2023-06-28T10:42:16.330317  / # . /lava-671978/environment/lava-671978/=
bin/lava-test-runner /lava-671978/1
    2023-06-28T10:42:16.331365  =

    2023-06-28T10:42:16.335222  / # /lava-671978/bin/lava-test-runner /lava=
-671978/1
    2023-06-28T10:42:16.493589  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/649c0d925eca886316306136

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.287-cip100-43-g1a6518aa81690/arm/multi_v7_defconfig/gcc-=
10/lab-collabora/baseline-nfs-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.287-cip100-43-g1a6518aa81690/arm/multi_v7_defconfig/gcc-=
10/lab-collabora/baseline-nfs-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/649c0d925eca88631630613d
        failing since 160 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-06-28T10:38:11.778183  / # #

    2023-06-28T10:38:11.880823  export SHELL=3D/bin/sh

    2023-06-28T10:38:11.881556  #

    2023-06-28T10:38:11.983014  / # export SHELL=3D/bin/sh. /lava-10936015/=
environment

    2023-06-28T10:38:11.983670  =


    2023-06-28T10:38:12.084992  / # . /lava-10936015/environment/lava-10936=
015/bin/lava-test-runner /lava-10936015/1

    2023-06-28T10:38:12.085332  =


    2023-06-28T10:38:12.101039  / # /lava-10936015/bin/lava-test-runner /la=
va-10936015/1

    2023-06-28T10:38:12.249471  + export TESTRUN_ID=3D1_bootrr

    2023-06-28T10:38:12.249611  + cd /lava-10936015/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/649c0ccc0d9e9e6eb230614b

  Results:     77 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.287-cip100-43-g1a6518aa81690/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.287-cip100-43-g1a6518aa81690/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/649c0ccc0d9e9e6eb2306155
        failing since 106 days (last pass: v4.19.273-cip92-277-g507c8d80b9e=
20, first fail: v4.19.276-cip93-5-g2eb2a953ab59)

    2023-06-28T10:34:37.478913  /lava-10935985/1/../bin/lava-test-case

    2023-06-28T10:34:37.500734  <8>[   39.134238] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/649c0ccc0d9e9e6eb2306156
        failing since 106 days (last pass: v4.19.273-cip92-277-g507c8d80b9e=
20, first fail: v4.19.276-cip93-5-g2eb2a953ab59)

    2023-06-28T10:34:35.402273  <8>[   37.034805] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-06-28T10:34:36.428911  /lava-10935985/1/../bin/lava-test-case

    2023-06-28T10:34:36.448919  <8>[   38.082986] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
sun50i-a64-pine64-plus    | arm64  | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/649c0fe3b3c6ba2284d7d60e

  Results:     23 PASS, 16 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.287-cip100-43-g1a6518aa81690/arm64/defconfig/gcc-10/lab-=
broonie/baseline-nfs-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.287-cip100-43-g1a6518aa81690/arm64/defconfig/gcc-10/lab-=
broonie/baseline-nfs-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/649c0fe3b3c6ba2284d7d637
        failing since 160 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-06-28T10:47:24.279873  [   22.351246] <LAVA_SIGNAL_ENDRUN 0_dmesg =
672023_1.6.2.4.1>
    2023-06-28T10:47:24.389413  / # #
    2023-06-28T10:47:24.492090  export SHELL=3D/bin/sh
    2023-06-28T10:47:24.492629  #
    2023-06-28T10:47:24.594492  / # export SHELL=3D/bin/sh. /lava-672023/en=
vironment
    2023-06-28T10:47:24.594927  =

    2023-06-28T10:47:24.696888  / # . /lava-672023/environment/lava-672023/=
bin/lava-test-runner /lava-672023/1
    2023-06-28T10:47:24.698348  =

    2023-06-28T10:47:24.702600  / # /lava-672023/bin/lava-test-runner /lava=
-672023/1
    2023-06-28T10:47:24.781287  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =20

