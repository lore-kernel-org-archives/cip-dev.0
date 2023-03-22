Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1FDC6FD1C
	for <webhook@archiver.kernel.org>; Wed, 22 Mar 2023 13:00:33 +0000 (UTC)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
 by mx.groups.io with SMTP id smtpd.web10.42045.1679490031607848146
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 22 Mar 2023 06:00:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=RCs57Yec;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.45, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f45.google.com with SMTP id o6-20020a17090a9f8600b0023f32869993so19595355pjp.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 22 Mar 2023 06:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1679490031;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gwFu/wthpnYAs78GOJi1Fvb3HNJMOnqaxXmfR2h3hI8=;
        b=RCs57YecOhlgzCVA6di8p05HsUBQE7Ia8GZFS3iW4AnchfSrNxphwgsReP1hj8EEoV
         DXQ8PTycjNgu4+CF0zsOYBTQQA4Srv7o++pCEqHQiQ4oQ6EIpC1GR/jHxboEJmy70HSC
         arT3q12OMtfohCUTv2TVuQyZ3qsj/sYPqaAazS37raKRnjUeCIROr1oku9Z3QdeIh6p8
         d2s8klvEk3duzEab93QtUuCOILGwVaLv3Ln+Y7spAbhbfEGUvSn5Nz4OhqPuYF7CXGCA
         FWzrRfbowJmpZCllOqSZ8MbTx8FITR4nA6WbeHVuvZ/57QQHrkv5wxkDOdgTT/0AhPLD
         gh8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679490031;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gwFu/wthpnYAs78GOJi1Fvb3HNJMOnqaxXmfR2h3hI8=;
        b=yEWQteAs79/XCaeO4+RHzfRcX+7QXTkA/Pyw1bwXD2uD0u+LxM3Zl/TXtF6cs5rg0Q
         kyag4WYOLfvxXpF9oAtw8bKVFDUa3R1cAzWdgHwKAxJNK6ze9L7TiZ0lqkQB3AdA3bY0
         kIcwOoIVYXWXnxIXYValw6K0LLEdNjzFwafdzz+HEkiK4C281/0tfQCZKrlETrCLyS/j
         xpGEWnRaBKfzvTNeUKh/sWCG+P088Rp9BvpoTZ6gsy02aG1Ahobi3auyw4pj53G9m5CY
         fw3WuQGs9B/qlPiODARbpz6dzjkUb4PH1BzyGx89EnnY2ITnnaBOCmvg4BWleW9m7rG5
         2zMQ==
X-Gm-Message-State: AO0yUKVD+DpaamJtcfdy3CA+0MRaF+M4BI/8AX70JLVl0jFTogsBUpwX
	OJEqTftAOu4clfHVKcOI55Q1HGCcw1YfmjWEMy3suA==
X-Google-Smtp-Source: AK7set/zEF2xxreA4Pl1L24Dto/VtufU/XEnF1DWHHt0uEIrSzJWG1oNojQJAH3OkawMdi6MQ2iq8g==
X-Received: by 2002:a17:903:288c:b0:19c:b4e3:c65b with SMTP id ku12-20020a170903288c00b0019cb4e3c65bmr2412617plb.8.1679490030250;
        Wed, 22 Mar 2023 06:00:30 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a13-20020a170902ee8d00b0019f11a68c42sm10433183pld.297.2023.03.22.06.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 06:00:29 -0700 (PDT)
Message-ID: <641afbed.170a0220.12aa4.33a5@mx.google.com>
Date: Wed, 22 Mar 2023 06:00:29 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip-rt
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.277-cip94-rt29
Subject: cip/linux-4.19.y-cip-rt baseline-nfs: 60 runs,
 16 regressions (v4.19.277-cip94-rt29)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Mar 2023 13:00:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11075

cip/linux-4.19.y-cip-rt baseline-nfs: 60 runs, 16 regressions (v4.19.277-ci=
p94-rt29)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | defconfig+x=
86-chromebook     | 1          =

asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | defconfig+x=
86-chromebook     | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 1          =

beaglebone-black          | arm    | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =

beaglebone-black          | arm    | lab-cip       | gcc-10   | defconfig  =
                  | 1          =

beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fc...g+preempt_rt | 1          =

beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =

beaglebone-black          | arm    | lab-cip       | gcc-10   | multi_v7_de=
fc...g+preempt_rt | 1          =

imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | defconfig  =
                  | 1          =

imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | defconfig+p=
reempt_rt         | 1          =

imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fc...g+preempt_rt | 1          =

imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =

r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig+p=
reempt_rt         | 1          =

sun50i-a64-pine64-plus    | arm64  | lab-broonie   | gcc-10   | defconfig+p=
reempt_rt         | 1          =

sun50i-a64-pine64-plus    | arm64  | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip-rt/ke=
rnel/v4.19.277-cip94-rt29/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.19.y-cip-rt
  Describe: v4.19.277-cip94-rt29
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      26d9f86d942d1c22bb7542618e47ea5c0e6b4026 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | defconfig+x=
86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/641af2a2a4b0b817b69c9515

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/641af2a2a4b0b817b69c951e
        failing since 62 days (last pass: v4.19.265-cip85-rt27, first fail:=
 v4.19.269-cip88-rt28)

    2023-03-22T12:20:25.379772  + set +x

    2023-03-22T12:20:25.386093  [   17.418347] <LAVA_SIGNAL_ENDRUN 0_dmesg =
9729446_1.5.2.3.1>

    2023-03-22T12:20:25.490312  / # #

    2023-03-22T12:20:25.591344  export SHELL=3D/bin/sh

    2023-03-22T12:20:25.591530  #

    2023-03-22T12:20:25.692442  / # export SHELL=3D/bin/sh. /lava-9729446/e=
nvironment

    2023-03-22T12:20:25.692644  =


    2023-03-22T12:20:25.793558  / # . /lava-9729446/environment/lava-972944=
6/bin/lava-test-runner /lava-9729446/1

    2023-03-22T12:20:25.793829  =


    2023-03-22T12:20:25.799485  / # /lava-9729446/bin/lava-test-runner /lav=
a-9729446/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/641af18bcf33f43c879c9586

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/641af18bcf33f43c879c958f
        failing since 62 days (last pass: v4.19.265-cip85-rt27, first fail:=
 v4.19.269-cip88-rt28)

    2023-03-22T12:15:48.037547  + set +x

    2023-03-22T12:15:48.043289  <8>[   19.766159] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9729335_1.5.2.3.1>

    2023-03-22T12:15:48.155752  #

    2023-03-22T12:15:48.259112  / # #export SHELL=3D/bin/sh

    2023-03-22T12:15:48.260095  =


    2023-03-22T12:15:48.362022  / # export SHELL=3D/bin/sh. /lava-9729335/e=
nvironment

    2023-03-22T12:15:48.362899  =


    2023-03-22T12:15:48.465044  / # . /lava-9729335/environment/lava-972933=
5/bin/lava-test-runner /lava-9729335/1

    2023-03-22T12:15:48.466399  =


    2023-03-22T12:15:48.468891  / # /lava-9729335/bin/lava-test-runner /lav=
a-9729335/1
 =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | defconfig+x=
86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/641af266fae400f5cf9c952d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/641af266fae400f5cf9c9536
        failing since 62 days (last pass: v4.19.265-cip85-rt27, first fail:=
 v4.19.269-cip88-rt28)

    2023-03-22T12:19:37.381545  + [   21.470136] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 9729464_1.5.2.3.1>

    2023-03-22T12:19:37.385137  set +x

    2023-03-22T12:19:37.494309  / # #

    2023-03-22T12:19:37.597206  export SHELL=3D/bin/sh

    2023-03-22T12:19:37.597708  #

    2023-03-22T12:19:37.699237  / # export SHELL=3D/bin/sh. /lava-9729464/e=
nvironment

    2023-03-22T12:19:37.700069  =


    2023-03-22T12:19:37.801862  / # . /lava-9729464/environment/lava-972946=
4/bin/lava-test-runner /lava-9729464/1

    2023-03-22T12:19:37.803484  =


    2023-03-22T12:19:37.808624  / # /lava-9729464/bin/lava-test-runner /lav=
a-9729464/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/641af18a6fbaec799e9c9565

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/641af18a6fbaec799e9c956e
        failing since 62 days (last pass: v4.19.265-cip85-rt27, first fail:=
 v4.19.269-cip88-rt28)

    2023-03-22T12:15:49.601448  <8>[   22.371726] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-03-22T12:15:49.602182  + set +x

    2023-03-22T12:15:49.607885  <8>[   22.381929] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9729328_1.5.2.3.1>

    2023-03-22T12:15:49.719777  #

    2023-03-22T12:15:49.823052  / # #export SHELL=3D/bin/sh

    2023-03-22T12:15:49.823926  =


    2023-03-22T12:15:49.925915  / # export SHELL=3D/bin/sh. /lava-9729328/e=
nvironment

    2023-03-22T12:15:49.926834  =


    2023-03-22T12:15:50.028957  / # . /lava-9729328/environment/lava-972932=
8/bin/lava-test-runner /lava-9729328/1

    2023-03-22T12:15:50.030284  =

 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/641af50e51a40fc0359c9575

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-bla=
ck.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-bla=
ck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/641af50e51a40fc0359c95a4
        failing since 62 days (last pass: v4.19.265-cip85-rt27, first fail:=
 v4.19.269-cip88-rt28)

    2023-03-22T12:30:16.982133  <8>[   49.050393] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 206593_1.6.2.4.1>
    2023-03-22T12:30:17.111538  / # #
    2023-03-22T12:30:17.214270  export SHELL=3D/bin/sh
    2023-03-22T12:30:17.214895  #
    2023-03-22T12:30:17.316852  / # export SHELL=3D/bin/sh. /lava-206593/en=
vironment
    2023-03-22T12:30:17.317601  =

    2023-03-22T12:30:17.419597  / # . /lava-206593/environment/lava-206593/=
bin/lava-test-runner /lava-206593/1
    2023-03-22T12:30:17.420426  =

    2023-03-22T12:30:17.423875  / # /lava-206593/bin/lava-test-runner /lava=
-206593/1
    2023-03-22T12:30:17.602141  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-cip       | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/641af98e33625f22a09c9509

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/defconfig/gcc-10/lab-cip/baseline-nfs-beaglebone-black.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/defconfig/gcc-10/lab-cip/baseline-nfs-beaglebone-black.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/641af98e33625f22a09c9510
        failing since 62 days (last pass: v4.19.265-cip85-rt27, first fail:=
 v4.19.269-cip88-rt28)

    2023-03-22T12:49:39.739288  + set +x
    2023-03-22T12:49:39.741154  [   40.577456] <LAVA_SIGNAL_ENDRUN 0_dmesg =
883584_1.6.2.4.1>
    2023-03-22T12:49:39.855575  / # #
    2023-03-22T12:49:39.957510  export SHELL=3D/bin/sh
    2023-03-22T12:49:39.957976  #
    2023-03-22T12:49:40.059398  / # export SHELL=3D/bin/sh. /lava-883584/en=
vironment
    2023-03-22T12:49:40.059863  =

    2023-03-22T12:49:40.161321  / # . /lava-883584/environment/lava-883584/=
bin/lava-test-runner /lava-883584/1
    2023-03-22T12:49:40.162085  =

    2023-03-22T12:49:40.163572  / # /lava-883584/bin/lava-test-runner /lava=
-883584/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fc...g+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/641af05d78af3e32719c9508

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-broonie/baselin=
e-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-broonie/baselin=
e-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/641af05d78af3e32719c9537
        failing since 62 days (last pass: v4.19.265-cip85-rt27, first fail:=
 v4.19.269-cip88-rt28)

    2023-03-22T12:10:23.478672  <8>[   55.067938] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 206350_1.6.2.4.1>
    2023-03-22T12:10:24.040821  / # #
    2023-03-22T12:10:24.143345  export SHELL=3D/bin/sh
    2023-03-22T12:10:24.143895  #
    2023-03-22T12:10:24.245534  / # export SHELL=3D/bin/sh. /lava-206350/en=
vironment
    2023-03-22T12:10:24.246079  =

    2023-03-22T12:10:24.347987  / # . /lava-206350/environment/lava-206350/=
bin/lava-test-runner /lava-206350/1
    2023-03-22T12:10:24.348887  =

    2023-03-22T12:10:24.353273  / # /lava-206350/bin/lava-test-runner /lava=
-206350/1
    2023-03-22T12:10:24.573217  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/641af596250a7de2079c9568

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-beagl=
ebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-beagl=
ebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/641af596250a7de2079c9597
        failing since 62 days (last pass: v4.19.265-cip85-rt27, first fail:=
 v4.19.269-cip88-rt28)

    2023-03-22T12:32:40.646423  [   47.242928] <LAVA_SIGNAL_ENDRUN 0_dmesg =
206611_1.6.2.4.1>
    2023-03-22T12:32:40.764470  / # #
    2023-03-22T12:32:40.867601  export SHELL=3D/bin/sh
    2023-03-22T12:32:40.868550  #
    2023-03-22T12:32:40.970440  / # export SHELL=3D/bin/sh. /lava-206611/en=
vironment
    2023-03-22T12:32:40.970953  =

    2023-03-22T12:32:41.072565  / # . /lava-206611/environment/lava-206611/=
bin/lava-test-runner /lava-206611/1
    2023-03-22T12:32:41.073433  =

    2023-03-22T12:32:41.077055  / # /lava-206611/bin/lava-test-runner /lava=
-206611/1
    2023-03-22T12:32:41.232059  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-cip       | gcc-10   | multi_v7_de=
fc...g+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/641af056edd681ee629c9587

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-cip/baseline-nf=
s-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-cip/baseline-nf=
s-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/641af056edd681ee629c958e
        failing since 62 days (last pass: v4.19.265-cip85-rt27, first fail:=
 v4.19.269-cip88-rt28)

    2023-03-22T12:10:22.573664  + set +x
    2023-03-22T12:10:22.576853  [   45.184375] <LAVA_SIGNAL_ENDRUN 0_dmesg =
883525_1.6.2.4.1>
    2023-03-22T12:10:22.690430  #
    2023-03-22T12:10:22.792580  / # #export SHELL=3D/bin/sh
    2023-03-22T12:10:22.793122  =

    2023-03-22T12:10:22.894542  / # export SHELL=3D/bin/sh. /lava-883525/en=
vironment
    2023-03-22T12:10:22.895025  =

    2023-03-22T12:10:22.996451  / # . /lava-883525/environment/lava-883525/=
bin/lava-test-runner /lava-883525/1
    2023-03-22T12:10:22.997207  =

    2023-03-22T12:10:22.999177  / # /lava-883525/bin/lava-test-runner /lava=
-883525/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/641af49c665add3e379c953a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/defconfig/gcc-10/lab-collabora/baseline-nfs-imx6q-sabrel=
ite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/defconfig/gcc-10/lab-collabora/baseline-nfs-imx6q-sabrel=
ite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/641af49c665add3e379c9543
        failing since 62 days (last pass: v4.19.265-cip85-rt27, first fail:=
 v4.19.269-cip88-rt28)

    2023-03-22T12:28:55.495150  + set +x

    2023-03-22T12:28:55.498825  <8>[   30.529052] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9729530_1.6.2.4.1>

    2023-03-22T12:28:55.640998  =


    2023-03-22T12:28:55.743320  / # #export SHELL=3D/bin/sh

    2023-03-22T12:28:55.744151  =


    2023-03-22T12:28:55.846039  / # export SHELL=3D/bin/sh. /lava-9729530/e=
nvironment

    2023-03-22T12:28:55.847308  =


    2023-03-22T12:28:55.949483  / # . /lava-9729530/environment/lava-972953=
0/bin/lava-test-runner /lava-9729530/1

    2023-03-22T12:28:55.951021  =


    2023-03-22T12:28:55.953025  / # /lava-9729530/bin/lava-test-runner /lav=
a-9729530/1
 =

    ... (14 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | defconfig+p=
reempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/641af51303c91dac759c9511

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-nfs-i=
mx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-nfs-i=
mx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/641af51303c91dac759c951a
        failing since 62 days (last pass: v4.19.265-cip85-rt27, first fail:=
 v4.19.269-cip88-rt28)

    2023-03-22T12:30:55.882023  + set[   32.900874] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 9729563_1.6.2.4.1>

    2023-03-22T12:30:55.882308   +x

    2023-03-22T12:30:55.989419  / # #

    2023-03-22T12:30:56.092445  export SHELL=3D/bin/sh

    2023-03-22T12:30:56.093327  #

    2023-03-22T12:30:56.195362  / # export SHELL=3D/bin/sh. /lava-9729563/e=
nvironment

    2023-03-22T12:30:56.196183  =


    2023-03-22T12:30:56.196762  / # [   33.129603] panel-simple panel-lvds0=
: panel-lvds0 supply power not found, using dummy regulator

    2023-03-22T12:30:56.197183  [   33.138570] panel-simple panel-lvds0: Li=
nked as a consumer to regulator.0

    2023-03-22T12:30:56.197629  [   33.145624] panel-simple panel-lvds0: Dr=
opping the link to regulator.0
 =

    ... (29 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fc...g+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/641aef5da71c84e3369c9546

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-collabora/basel=
ine-nfs-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-collabora/basel=
ine-nfs-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/641aef5da71c84e3369c954f
        failing since 62 days (last pass: v4.19.265-cip85-rt27, first fail:=
 v4.19.269-cip88-rt28)

    2023-03-22T12:06:30.896015  / # #

    2023-03-22T12:06:30.999041  export SHELL=3D/bin/sh

    2023-03-22T12:06:30.999923  #

    2023-03-22T12:06:31.101928  / # export SHELL=3D/bin/sh. /lava-9729097/e=
nvironment

    2023-03-22T12:06:31.102793  =


    2023-03-22T12:06:31.205085  / # . /lava-9729097/environment/lava-972909=
7/bin/lava-test-runner /lava-9729097/1

    2023-03-22T12:06:31.206384  =


    2023-03-22T12:06:31.207651  / # /lava-9729097/bin/lava-test-runner /lav=
a-9729097/1

    2023-03-22T12:06:31.423323  + export TESTRUN_ID=3D1_bootrr

    2023-03-22T12:06:31.423812  + cd /lava-9729097/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/641af49c7876c934c49c9537

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-nfs-imx=
6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-nfs-imx=
6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/641af49c7876c934c49c9540
        failing since 62 days (last pass: v4.19.265-cip85-rt27, first fail:=
 v4.19.269-cip88-rt28)

    2023-03-22T12:29:08.957121  / # #

    2023-03-22T12:29:09.059804  export SHELL=3D/bin/sh

    2023-03-22T12:29:09.060059  #

    2023-03-22T12:29:09.161087  / # export SHELL=3D/bin/sh. /lava-9729552/e=
nvironment

    2023-03-22T12:29:09.161946  =


    2023-03-22T12:29:09.263977  / # . /lava-9729552/environment/lava-972955=
2/bin/lava-test-runner /lava-9729552/1

    2023-03-22T12:29:09.265115  =


    2023-03-22T12:29:09.279813  / # /lava-9729552/bin/lava-test-runner /lav=
a-9729552/1

    2023-03-22T12:29:09.456568  + export TESTRUN_ID=3D1_bootrr

    2023-03-22T12:29:09.457117  + cd /lava-9729552/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig+p=
reempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/641af6abdf0a8d35e59c953a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm64/defconfig+preempt_rt/gcc-10/lab-cip/baseline-nfs-r8a77=
4a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm64/defconfig+preempt_rt/gcc-10/lab-cip/baseline-nfs-r8a77=
4a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/641af6abdf0a8d35e=
59c953b
        failing since 62 days (last pass: v4.19.265-cip85-rt27, first fail:=
 v4.19.269-cip88-rt28) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
sun50i-a64-pine64-plus    | arm64  | lab-broonie   | gcc-10   | defconfig+p=
reempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/641af84151a948cb539c9585

  Results:     23 PASS, 16 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm64/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-nfs-s=
un50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm64/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-nfs-s=
un50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/641af84151a948cb539c95af
        failing since 62 days (last pass: v4.19.265-cip85-rt27, first fail:=
 v4.19.269-cip88-rt28)

    2023-03-22T12:44:02.323080  [   98.355507] <LAVA_SIGNAL_ENDRUN 0_dmesg =
206630_1.6.2.4.1>
    2023-03-22T12:44:02.444949  / # #
    2023-03-22T12:44:02.548033  export SHELL=3D/bin/sh
    2023-03-22T12:44:02.549065  #
    2023-03-22T12:44:02.650907  / # export SHELL=3D/bin/sh. /lava-206630/en=
vironment
    2023-03-22T12:44:02.651495  =

    2023-03-22T12:44:02.753144  / # . /lava-206630/environment/lava-206630/=
bin/lava-test-runner /lava-206630/1
    2023-03-22T12:44:02.754367  =

    2023-03-22T12:44:02.757599  / # /lava-206630/bin/lava-test-runner /lava=
-206630/1
    2023-03-22T12:44:02.885290  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
sun50i-a64-pine64-plus    | arm64  | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/641af8e1b8cd2a82699c955c

  Results:     23 PASS, 16 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-sun50i-a64-p=
ine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-sun50i-a64-p=
ine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/641af8e1b8cd2a82699c9586
        failing since 62 days (last pass: v4.19.265-cip85-rt27, first fail:=
 v4.19.269-cip88-rt28)

    2023-03-22T12:46:55.660946  <8>[   22.328618] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 206668_1.6.2.4.1>
    2023-03-22T12:46:55.771088  / # #
    2023-03-22T12:46:55.873875  export SHELL=3D/bin/sh
    2023-03-22T12:46:55.874588  #
    2023-03-22T12:46:55.976513  / # export SHELL=3D/bin/sh. /lava-206668/en=
vironment
    2023-03-22T12:46:55.977686  =

    2023-03-22T12:46:56.079790  / # . /lava-206668/environment/lava-206668/=
bin/lava-test-runner /lava-206668/1
    2023-03-22T12:46:56.080606  =

    2023-03-22T12:46:56.084140  / # /lava-206668/bin/lava-test-runner /lava=
-206668/1
    2023-03-22T12:46:56.156768  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =20

