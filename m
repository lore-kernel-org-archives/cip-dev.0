Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F34EC7EE2D
	for <webhook@archiver.kernel.org>; Fri,  3 Mar 2023 16:20:17 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web10.27672.1677860407764462488
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 03 Mar 2023 08:20:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=tQBmTVao;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.170, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f170.google.com with SMTP id c4so1937546pfl.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 03 Mar 2023 08:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1677860407;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=401bq49C/2mTPjE/s/+aNu7JU2jSFUdu0PvUAzEwgXo=;
        b=tQBmTVaoMjcV1aJBguQJHI0zQuTzAWRavBN+XMASKKXBQnOLPLUiuyEUZXLxh1QGQ0
         g/qrrZZAOC32rnGU/+tlSK2dajoiOYHGgTi1P/kBygitW3sNmxmk5JGz4tgWHAfsOHFH
         XSMlfGcFiuQEWvnJRYPV7sr6Q2YV9vYHPM4bEYkGoo/viFbY9rC2qY2AFDNhHe1hz/Eb
         3esbfLojuNGqOzhRQuRQ+g+UiE8hBblWjlWOZXNLjFTenuIvBOi1cFP86pbT18KaLaa1
         MloeJ47JJC2iCDlMdY914PnwVrIEmxkcPj5HIp7iQlV9iPTgdH8mL/QzZAISiAjUyykn
         qZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677860407;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=401bq49C/2mTPjE/s/+aNu7JU2jSFUdu0PvUAzEwgXo=;
        b=1OiIIlS1x03EyWSaRsp4EbZ9uOi/WRzS6Lslqdbxe7hOdy0q95NMnEPQhn02QrOxSv
         PTz6Dgqy/MGPLnM3axk0PIWvqpyVveKRRMnIi4i3xG+OzlTS4G6RbzGjIRyMJG72CbWX
         ZkZYznF1K6pbT8xh0c0aeUBEFDA1ykdLbwpWXGr3uaTxZttOMAhv867jQqJcSVz0vMkK
         t9C2t7Nscg96SvQ1ZYQfEsd+PakaM5fDd2/T1DQclyx9AoyJPrb4UmDfUyOlHtcPcjws
         7cC9cfx/uy1yz91NvHGYf0PdOsdqSy2c+dknY6gaR1fLfxt5kHPhPy3U3YP+zJa4Gxya
         9mnA==
X-Gm-Message-State: AO0yUKUBtpx7WHGzN0eWPYOc8aU9oJIbzegXPpk+/49UM2n6yPQRbH2S
	XQke6jAYpwM3Ho3cXZSABlHZ5G0O+Zrmq9S3P8qwOQ==
X-Google-Smtp-Source: AK7set9QXsp2iM7bJf2IG1Ea2XEqdXzkr3+oBp64YIzMFmEuJmNOZQxpLCG9InfGMaGDogHGM6JfxA==
X-Received: by 2002:aa7:9607:0:b0:5e4:f700:f876 with SMTP id q7-20020aa79607000000b005e4f700f876mr2278631pfg.28.1677860406620;
        Fri, 03 Mar 2023 08:20:06 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 1-20020aa79241000000b005a7ae8b3a09sm1830682pfp.32.2023.03.03.08.20.06
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 08:20:06 -0800 (PST)
Message-ID: <64021e36.a70a0220.ba373.4070@mx.google.com>
Date: Fri, 03 Mar 2023 08:20:06 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.19.273-cip92-24-g2070ce514972
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 33 runs,
 10 regressions (v4.19.273-cip92-24-g2070ce514972)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Mar 2023 16:20:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10918

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 33 runs, 10 regres=
sions (v4.19.273-cip92-24-g2070ce514972)

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
rm64-chromebook   | 4          =

sun50i-a64-pine64-plus    | arm64  | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.273-cip92-24-g2070ce514972/plan/baseline-=
nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.273-cip92-24-g2070ce514972
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      2070ce514972cfaa8912c58feffcc824d465c865 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6402179171a25d1c8d8c8635

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230224.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6402179171a25d1c8d8c863e
        failing since 43 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-03T15:51:19.167981  + <8>[   18.065932] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 9406209_1.5.2.3.1>

    2023-03-03T15:51:19.168482  set +x

    2023-03-03T15:51:19.274282  #

    2023-03-03T15:51:19.377149  / # #export SHELL=3D/bin/sh

    2023-03-03T15:51:19.377908  =


    2023-03-03T15:51:19.479670  / # export SHELL=3D/bin/sh. /lava-9406209/e=
nvironment

    2023-03-03T15:51:19.480456  =


    2023-03-03T15:51:19.582040  / # . /lava-9406209/environment/lava-940620=
9/bin/lava-test-runner /lava-9406209/1

    2023-03-03T15:51:19.582308  =


    2023-03-03T15:51:19.584788  / # /lava-9406209/bin/lava-test-runner /lav=
a-9406209/1
 =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64021560d922d41d338c863c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230224.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64021560d922d41d338c8645
        failing since 43 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-03T15:42:04.321891  + set +x

    2023-03-03T15:42:04.328316  <8>[   19.580664] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9406231_1.5.2.3.1>

    2023-03-03T15:42:04.436945  / # #

    2023-03-03T15:42:04.539811  export SHELL=3D/bin/sh

    2023-03-03T15:42:04.540573  #

    2023-03-03T15:42:04.642204  / # export SHELL=3D/bin/sh. /lava-9406231/e=
nvironment

    2023-03-03T15:42:04.642544  =


    2023-03-03T15:42:04.743873  / # . /lava-9406231/environment/lava-940623=
1/bin/lava-test-runner /lava-9406231/1

    2023-03-03T15:42:04.745097  =


    2023-03-03T15:42:04.749750  / # /lava-9406231/bin/lava-test-runner /lav=
a-9406231/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6402170bb7a4361e278c86e9

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm/multi_v7_defconfig/gcc-10=
/lab-broonie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm/multi_v7_defconfig/gcc-10=
/lab-broonie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230224.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6402170bb7a4361e278c86f2
        failing since 43 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-03T15:49:22.311381  <8>[   47.551401] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 92064_1.6.2.4.1>
    2023-03-03T15:49:22.443035  / # #
    2023-03-03T15:49:22.545870  export SHELL=3D/bin/sh
    2023-03-03T15:49:22.546496  #
    2023-03-03T15:49:22.648348  / # export SHELL=3D/bin/sh. /lava-92064/env=
ironment
    2023-03-03T15:49:22.649074  =

    2023-03-03T15:49:22.750998  / # . /lava-92064/environment/lava-92064/bi=
n/lava-test-runner /lava-92064/1
    2023-03-03T15:49:22.751810  =

    2023-03-03T15:49:22.756127  / # /lava-92064/bin/lava-test-runner /lava-=
92064/1
    2023-03-03T15:49:23.011034  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-cip       | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64021abe048bd24b4a8c862f

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm/multi_v7_defconfig/gcc-10=
/lab-cip/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm/multi_v7_defconfig/gcc-10=
/lab-cip/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230224.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64021abe048bd24b4a8c8636
        failing since 43 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-03T16:05:09.149344  + set +x
    2023-03-03T16:05:09.151351  <8>[   40.608787] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 864645_1.6.2.4.1>
    2023-03-03T16:05:09.266237  / # #
    2023-03-03T16:05:09.368164  export SHELL=3D/bin/sh
    2023-03-03T16:05:09.368634  #
    2023-03-03T16:05:09.470067  / # export SHELL=3D/bin/sh. /lava-864645/en=
vironment
    2023-03-03T16:05:09.470529  =

    2023-03-03T16:05:09.571948  / # . /lava-864645/environment/lava-864645/=
bin/lava-test-runner /lava-864645/1
    2023-03-03T16:05:09.572694  =

    2023-03-03T16:05:09.574200  / # /lava-864645/bin/lava-test-runner /lava=
-864645/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64021677ee1ad8b4f58c8666

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm/multi_v7_defconfig/gcc-10=
/lab-collabora/baseline-nfs-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm/multi_v7_defconfig/gcc-10=
/lab-collabora/baseline-nfs-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230224.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64021677ee1ad8b4f58c866f
        failing since 43 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-03T15:46:55.628155  / # #

    2023-03-03T15:46:55.730692  export SHELL=3D/bin/sh

    2023-03-03T15:46:55.731585  #

    2023-03-03T15:46:55.833782  / # export SHELL=3D/bin/sh. /lava-9406453/e=
nvironment

    2023-03-03T15:46:55.834667  =


    2023-03-03T15:46:55.936992  / # . /lava-9406453/environment/lava-940645=
3/bin/lava-test-runner /lava-9406453/1

    2023-03-03T15:46:55.938358  =


    2023-03-03T15:46:55.951059  / # /lava-9406453/bin/lava-test-runner /lav=
a-9406453/1

    2023-03-03T15:46:56.118150  + export TESTRUN_ID=3D1_bootrr

    2023-03-03T15:46:56.118311  + cd /lava-9406453/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 4          =


  Details:     https://kernelci.org/test/plan/id/64021534d97a836a498c8631

  Results:     79 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230224.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rk3399-gru-sound-driver-rt5514-present: https://ker=
nelci.org/test/case/id/64021534d97a836a498c866c
        failing since 43 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-03T15:41:16.326104  seq: invalid floating point argument: =E2=
=80=98sound/RT5514=E2=80=99

    2023-03-03T15:41:16.330755  Try 'seq --help' for more information.

    2023-03-03T15:41:16.334812  /lava-9406028/1/../bin/lava-test-case

    2023-03-03T15:41:16.349235  <8>[   35.697690] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-rt5514-present RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-max98357A-present: https://=
kernelci.org/test/case/id/64021534d97a836a498c866d
        failing since 43 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-03T15:41:16.270739  <8>[   35.618690] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-dp-present RESULT=3Dfail>

    2023-03-03T15:41:16.288316  seq: invalid floating point argument: =E2=
=80=98sound/MAX98357A=E2=80=99

    2023-03-03T15:41:16.291857  Try 'seq --help' for more information.

    2023-03-03T15:41:16.295996  /lava-9406028/1/../bin/lava-test-case

    2023-03-03T15:41:16.308342  <8>[   35.656558] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-max98357A-present RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-dp-present: https://kernelc=
i.org/test/case/id/64021534d97a836a498c866e
        failing since 43 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-03T15:41:16.248339  seq: invalid floating point argument: =E2=
=80=98sound/DP=E2=80=99

    2023-03-03T15:41:16.251813  Try 'seq --help' for more information.

    2023-03-03T15:41:16.255775  /lava-9406028/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-da7219-present: https://ker=
nelci.org/test/case/id/64021534d97a836a498c866f
        failing since 43 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-03T15:41:16.208367  seq: invalid floating point argument: =E2=
=80=98sound/DA7219=E2=80=99

    2023-03-03T15:41:16.211273  Try 'seq --help' for more information.

    2023-03-03T15:41:16.215935  /lava-9406028/1/../bin/lava-test-case

    2023-03-03T15:41:16.230869  <8>[   35.578995] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-da7219-present RESULT=3Dfail>
   =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
sun50i-a64-pine64-plus    | arm64  | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64021749332731011f8c863d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-nfs-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-nfs-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230224.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64021749332731011f8c8646
        failing since 43 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-03T15:50:12.526823  <8>[   22.760465] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 91964_1.6.2.4.1>
    2023-03-03T15:50:12.635706  / # #
    2023-03-03T15:50:12.738063  export SHELL=3D/bin/sh
    2023-03-03T15:50:12.738687  #
    2023-03-03T15:50:12.840767  / # export SHELL=3D/bin/sh. /lava-91964/env=
ironment
    2023-03-03T15:50:12.841109  =

    2023-03-03T15:50:12.942305  / # . /lava-91964/environment/lava-91964/bi=
n/lava-test-runner /lava-91964/1
    2023-03-03T15:50:12.942787  =

    2023-03-03T15:50:12.947102  / # /lava-91964/bin/lava-test-runner /lava-=
91964/1
    2023-03-03T15:50:13.024547  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =20

