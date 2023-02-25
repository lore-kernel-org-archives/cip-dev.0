Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08173C7EE2F
	for <webhook@archiver.kernel.org>; Sat, 25 Feb 2023 19:21:10 +0000 (UTC)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
 by mx.groups.io with SMTP id smtpd.web10.51188.1677352865651013705
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 25 Feb 2023 11:21:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=M0ndLPgl;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.52, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f52.google.com with SMTP id h11-20020a17090a2ecb00b00237c740335cso1423093pjs.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 25 Feb 2023 11:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Iv+A7LPnyh6MUA9b0wq7G0nFrTQ+U9e1hIDqJTGGHA0=;
        b=M0ndLPglHVvnFB7/tVTKl16RmOrzgJ/eu+nNfV+RvsQxMa/0SfgDMOVxkQmU0eSPXn
         V7ImAv/ZBgKHTaElPHEAXs7roZEM0RuwIckRS36pixmz9nhMaw1ej9GLzPw8vRZyG+zE
         FGS3/i46yYI58f+lwHwVBAfbLO6nhabLV9ExTAWFKpIg2hthOvSUN/0gcAEaXH1VkQY3
         DDbIf82QP9UGBzFw6DOHEO88slfdGLWr4UuKslvZZtQmCH+GCTjJEdaxwUu78by+ISMc
         iN4uWzUTZxKz8dWckWKJi/ZaoRf92tc1j9P/Ku2Pg8CzmLbb0Wbl/gQdC+cMAC8sarmr
         hBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iv+A7LPnyh6MUA9b0wq7G0nFrTQ+U9e1hIDqJTGGHA0=;
        b=0V0/AKgBkqTn7pQT/boJHBsJhEnT9/zj6JGlEHDeamSpkhLgLgynlT0aVOOeIpYpKL
         lh08G6zk/GRFu/cmfOMn2Ts/0P/8b9NjybkrEHY3nDE/vkukFN4ufedZniPymnxwwgqN
         pEi6/1wmI6gR/t3szGYACB6PFwC/xKy5UNlC3aOgncNhShvxpX9DXmbXv5DZ6Rohk3Vb
         VQQtHvukmzaO5BUKI6dqZBcfzoRGLlsNR5zq/X1UaHLiXVEKB64fB93fOYQgz2xVP4ZZ
         fnGWEO1WpRRvd7rAFQ0lADc+W+1SQL3VnVAho0ggR1kNtq1asWurhuuP6Stp4RirZNZa
         TzLw==
X-Gm-Message-State: AO0yUKX9m7Bsu9V8E7ukQzCI2oPkZ7yG1enEwvD62Wcuy0GLwPONEiwp
	XNg4a1EIB6SuYlQy7KwSrZaX04PTtqwU4XkpI5I=
X-Google-Smtp-Source: AK7set+hI3hjN+/7d2KtuM8raoc37J/n0O2jDYAdNWl8QQXrw8MEij32MO7pnYtx/j1QQlOaqyiPgg==
X-Received: by 2002:a05:6a20:3d22:b0:bc:96bd:d701 with SMTP id y34-20020a056a203d2200b000bc96bdd701mr24338072pzi.13.1677352864524;
        Sat, 25 Feb 2023 11:21:04 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e25-20020a62aa19000000b005d98fbf82d8sm1564939pff.171.2023.02.25.11.21.03
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 11:21:04 -0800 (PST)
Message-ID: <63fa5fa0.620a0220.336bb.2517@mx.google.com>
Date: Sat, 25 Feb 2023 11:21:04 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.19.273-cip92-14-ga8d1f73f2a28
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 33 runs,
 9 regressions (v4.19.273-cip92-14-ga8d1f73f2a28)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 25 Feb 2023 19:21:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10844

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 33 runs, 9 regress=
ions (v4.19.273-cip92-14-ga8d1f73f2a28)

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
rm64-chromebook   | 4          =

sun50i-a64-pine64-plus    | arm64  | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.273-cip92-14-ga8d1f73f2a28/plan/baseline-=
nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.273-cip92-14-ga8d1f73f2a28
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      a8d1f73f2a28c0a328e74bee5d79d0e91de0df9f =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63fa55d50e24d9f7318c863b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230217.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63fa55d50e24d9f7318c8644
        failing since 37 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-25T18:38:53.096687  + set +x<8>[   18.507619] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 9334722_1.5.2.3.1>

    2023-02-25T18:38:53.096812  =


    2023-02-25T18:38:53.202318  / # #

    2023-02-25T18:38:53.305450  export SHELL=3D/bin/sh

    2023-02-25T18:38:53.306314  #

    2023-02-25T18:38:53.408270  / # export SHELL=3D/bin/sh. /lava-9334722/e=
nvironment

    2023-02-25T18:38:53.409190  =


    2023-02-25T18:38:53.511069  / # . /lava-9334722/environment/lava-933472=
2/bin/lava-test-runner /lava-9334722/1

    2023-02-25T18:38:53.512379  =


    2023-02-25T18:38:53.517341  / # /lava-9334722/bin/lava-test-runner /lav=
a-9334722/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63fa55f78b9069bcc68c8652

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230217.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63fa55f78b9069bcc68c865b
        failing since 37 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-25T18:39:30.891200  + set +x

    2023-02-25T18:39:30.897771  [   20.016247] <LAVA_SIGNAL_ENDRUN 0_dmesg =
9334687_1.5.2.3.1>

    2023-02-25T18:39:31.006032  / # #

    2023-02-25T18:39:31.108971  export SHELL=3D/bin/sh

    2023-02-25T18:39:31.109912  #

    2023-02-25T18:39:31.212003  / # export SHELL=3D/bin/sh. /lava-9334687/e=
nvironment

    2023-02-25T18:39:31.212896  =


    2023-02-25T18:39:31.315017  / # . /lava-9334687/environment/lava-933468=
7/bin/lava-test-runner /lava-9334687/1

    2023-02-25T18:39:31.316346  =


    2023-02-25T18:39:31.321533  / # /lava-9334687/bin/lava-test-runner /lav=
a-9334687/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63fa57bfbe538b60bb8c8641

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/arm/multi_v7_defconfig/gcc-10=
/lab-broonie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/arm/multi_v7_defconfig/gcc-10=
/lab-broonie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230217.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63fa57bfbe538b60bb8c864a
        failing since 37 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-25T18:47:16.211773  [   49.063473] <LAVA_SIGNAL_ENDRUN 0_dmesg =
76054_1.6.2.4.1>
    2023-02-25T18:47:16.337467  / # #
    2023-02-25T18:47:16.439734  export SHELL=3D/bin/sh
    2023-02-25T18:47:16.440631  #
    2023-02-25T18:47:16.542423  / # export SHELL=3D/bin/sh. /lava-76054/env=
ironment
    2023-02-25T18:47:16.543046  =

    2023-02-25T18:47:16.644642  / # . /lava-76054/environment/lava-76054/bi=
n/lava-test-runner /lava-76054/1
    2023-02-25T18:47:16.645506  =

    2023-02-25T18:47:16.649582  / # /lava-76054/bin/lava-test-runner /lava-=
76054/1
    2023-02-25T18:47:16.835686  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63fa5756a354b099a08c864f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/arm/multi_v7_defconfig/gcc-10=
/lab-collabora/baseline-nfs-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/arm/multi_v7_defconfig/gcc-10=
/lab-collabora/baseline-nfs-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230217.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63fa5756a354b099a08c8658
        failing since 37 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-25T18:45:34.411796  + set +x

    2023-02-25T18:45:34.420399  <8>[   31.035835] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9334795_1.6.2.4.1>

    2023-02-25T18:45:34.532263  / ##

    2023-02-25T18:45:34.635119  export SHELL=3D/bin/sh

    2023-02-25T18:45:34.636035   #

    2023-02-25T18:45:34.738136  / # export SHELL=3D/bin/sh. /lava-9334795/e=
nvironment

    2023-02-25T18:45:34.739107  =


    2023-02-25T18:45:34.841172  / # . /lava-9334795/environment/lava-933479=
5/bin/lava-test-runner /lava-9334795/1

    2023-02-25T18:45:34.842715  =


    2023-02-25T18:45:34.844616  / # /lava-9334795/bin/lava-test-runner /lav=
a-9334795/1
 =

    ... (15 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 4          =


  Details:     https://kernelci.org/test/plan/id/63fa591d51c6d32c4a8c86d4

  Results:     79 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230217.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rk3399-gru-sound-driver-rt5514-present: https://ker=
nelci.org/test/case/id/63fa591d51c6d32c4a8c870e
        failing since 37 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-25T18:52:49.531036  seq: invalid floating point argument: =E2=
=80=98sound/RT5514=E2=80=99

    2023-02-25T18:52:49.535242  Try 'seq --help' for more information.

    2023-02-25T18:52:49.538581  /lava-9334832/1/../bin/lava-test-case

    2023-02-25T18:52:49.552872  <8>[   37.255323] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-rt5514-present RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-max98357A-present: https://=
kernelci.org/test/case/id/63fa591d51c6d32c4a8c870f
        failing since 37 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-25T18:52:49.490274  seq: invalid floating point argument: =E2=
=80=98sound/MAX98357A=E2=80=99

    2023-02-25T18:52:49.494824  Try 'seq --help' for more information.

    2023-02-25T18:52:49.497900  /lava-9334832/1/../bin/lava-test-case

    2023-02-25T18:52:49.513201  <8>[   37.214944] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-max98357A-present RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-dp-present: https://kernelc=
i.org/test/case/id/63fa591d51c6d32c4a8c8710
        failing since 37 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-25T18:52:49.425456  <8>[   37.126314] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-da7219-present RESULT=3Dfail>

    2023-02-25T18:52:49.443992  seq: invalid floating point argument: =E2=
=80=98sound/DP=E2=80=99

    2023-02-25T18:52:49.448460  Try 'seq --help' for more information.

    2023-02-25T18:52:49.451739  /lava-9334832/1/../bin/lava-test-case

    2023-02-25T18:52:49.469576  <8>[   37.172439] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-dp-present RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-da7219-present: https://ker=
nelci.org/test/case/id/63fa591d51c6d32c4a8c8711
        failing since 37 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-25T18:52:49.395824  seq: invalid floating point argument: =E2=
=80=98sound/DA7219=E2=80=99

    2023-02-25T18:52:49.400257  Try 'seq --help' for more information.

    2023-02-25T18:52:49.403876  /lava-9334832/1/../bin/lava-test-case
   =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
sun50i-a64-pine64-plus    | arm64  | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/63fa590851c6d32c4a8c869f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-nfs-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-14-ga8d1f73f2a28/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-nfs-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230217.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63fa590851c6d32c4a8c86a8
        failing since 37 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-25T18:52:42.486303  [   24.240838] <LAVA_SIGNAL_ENDRUN 0_dmesg =
76097_1.6.2.4.1>
    2023-02-25T18:52:42.594459  / # #
    2023-02-25T18:52:42.696274  export SHELL=3D/bin/sh
    2023-02-25T18:52:42.696931  #
    2023-02-25T18:52:42.799492  / # export SHELL=3D/bin/sh. /lava-76097/env=
ironment
    2023-02-25T18:52:42.799982  =

    2023-02-25T18:52:42.902015  / # . /lava-76097/environment/lava-76097/bi=
n/lava-test-runner /lava-76097/1
    2023-02-25T18:52:42.902679  =

    2023-02-25T18:52:42.907446  / # /lava-76097/bin/lava-test-runner /lava-=
76097/1
    2023-02-25T18:52:42.982035  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =20

