Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA78C636D6
	for <webhook@archiver.kernel.org>; Wed, 22 Feb 2023 19:37:48 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
 by mx.groups.io with SMTP id smtpd.web10.2814.1677094664795786399
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 22 Feb 2023 11:37:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=QMS2W21z;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.176, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f176.google.com with SMTP id a7so5291364pfx.10
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 22 Feb 2023 11:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sl0SIYdU7j0vN9Q89f39miUd9WyZ1IuyYbhzmLiq3AM=;
        b=QMS2W21z/3Qkyl77hb1U8f0Benv5bN8mjJwS/Q7NDqm5eIYPU43mOfB//Bf/k6I8Ny
         1v0CWr7WzNoH97va2nHcQ4Lg1AmcJUuVWhVs66iSCjvidj/V0xRDuuXytR+4EwcYDpC1
         wfuSUW99up86qEaAHHf8Stc1WLOuGMsWtRkskiMl4O4DAmu7AbEJFFtFWgRrt2NI/oGh
         4Gb1j17lGxh/umsyOnh3Br0TMcih0nML/YKpvO5cWBmc5del65Sw4gaXIaqt3T6Mf1up
         6zZUcDFL3TTA0LNdGPW92r7+2aOTRRqzgAlIWbS/v1lUxc8NyrieiRg5xg2jaUZKn7KJ
         45hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sl0SIYdU7j0vN9Q89f39miUd9WyZ1IuyYbhzmLiq3AM=;
        b=yhtMnclOTXPlWdkJ3jBiD+l1r/0UXAygj6FYQ6PeQSwf6aqgVmtlQvOHtEkggeNhDk
         2UcEGL10aDQf8TiwlU38vKoPjCR4C6mU2cAzPkoLZtYU+3PE9u6sd1LdwivdrWnbJNC3
         0JQ/USoG0+exzyNzvz/PoRDQqyDrDuBZHXGZWm5DLfmYarIkgawNlitmjOnhZXznpj31
         TmA1vfxWkCUsnpQZP/2L7NkAuYZBfBwtFY5N1PQCpofupgOyfZjY6WVk/LyLlG/Ianrg
         Wts3NRP2r8GbPk08CqnG9LANcnoLfGhdsnaOH62cXTjii3vWhc/K6hzf2jUXOvXpcFYh
         sJBQ==
X-Gm-Message-State: AO0yUKXE1wLumD48wF+XUOybRQvP52RP7/YdOBK3QS92KCygncf4kU4i
	WPM56Opep2oG0Ra0K6F4WCsZM5sTZJwxZUchthWoUA==
X-Google-Smtp-Source: AK7set+joDoneVjPpMUJ3dvsr7nX2vezQF8nKp9/HTzZ8MYKSGgaJh1vkYYiRG+2Al+FDydiGoOXHg==
X-Received: by 2002:a62:1ad1:0:b0:5a8:4de2:e94e with SMTP id a200-20020a621ad1000000b005a84de2e94emr9276321pfa.33.1677094663717;
        Wed, 22 Feb 2023 11:37:43 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h5-20020a62b405000000b005ac86f7b87fsm66927pfn.77.2023.02.22.11.37.43
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 11:37:43 -0800 (PST)
Message-ID: <63f66f07.620a0220.4315c.04db@mx.google.com>
Date: Wed, 22 Feb 2023 11:37:43 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.19.272-cip91-91-gb4755c11cb57
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 28 runs,
 10 regressions (v4.19.272-cip91-91-gb4755c11cb57)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Feb 2023 19:37:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10788

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 28 runs, 10 regres=
sions (v4.19.272-cip91-91-gb4755c11cb57)

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

beaglebone-black          | arm    | lab-broonie   | gcc-10   | omap2plus_d=
efconfig          | 1          =

imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 4          =

sun50i-a64-pine64-plus    | arm64  | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.272-cip91-91-gb4755c11cb57/plan/baseline-=
nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.272-cip91-91-gb4755c11cb57
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b4755c11cb578851c6f8f50c94fcac17e987653c =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63f6679db668a735b58c865b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230217.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63f6679db668a735b58c8664
        failing since 34 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-22T19:05:40.529186  + set +x

    2023-02-22T19:05:40.535525  <8>[   18.632920] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9284138_1.5.2.3.1>

    2023-02-22T19:05:40.640383  / # #

    2023-02-22T19:05:40.741385  export SHELL=3D/bin/sh

    2023-02-22T19:05:40.741627  #

    2023-02-22T19:05:40.842711  / # export SHELL=3D/bin/sh. /lava-9284138/e=
nvironment

    2023-02-22T19:05:40.843497  =


    2023-02-22T19:05:40.945048  / # . /lava-9284138/environment/lava-928413=
8/bin/lava-test-runner /lava-9284138/1

    2023-02-22T19:05:40.946204  =


    2023-02-22T19:05:40.951479  / # /lava-9284138/bin/lava-test-runner /lav=
a-9284138/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63f6673e1eedc30b028c8636

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230217.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63f6673e1eedc30b028c863f
        failing since 34 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-22T19:04:09.690850  <6>[   19.899550] lava-test-case (1518) use=
d greatest stack depth: 12880 bytes left

    2023-02-22T19:04:09.696724  + <8>[   19.908212] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 9284137_1.5.2.3.1>

    2023-02-22T19:04:09.696878  set +x

    2023-02-22T19:04:09.802880  / # #

    2023-02-22T19:04:09.903897  export SHELL=3D/bin/sh

    2023-02-22T19:04:09.904137  #

    2023-02-22T19:04:10.005035  / # export SHELL=3D/bin/sh. /lava-9284137/e=
nvironment

    2023-02-22T19:04:10.005391  =


    2023-02-22T19:04:10.106353  / # . /lava-9284137/environment/lava-928413=
7/bin/lava-test-runner /lava-9284137/1

    2023-02-22T19:04:10.106675  =

 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63f667ae3fd578fa308c8632

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm/multi_v7_defconfig/gcc-10=
/lab-broonie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm/multi_v7_defconfig/gcc-10=
/lab-broonie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230217.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63f667ae3fd578fa308c863b
        failing since 34 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-22T19:05:58.718655  <8>[   46.493780] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 57203_1.6.2.4.1>
    2023-02-22T19:05:58.833283  / # #
    2023-02-22T19:05:58.934777  export SHELL=3D/bin/sh
    2023-02-22T19:05:58.935174  #
    2023-02-22T19:05:59.036321  / # export SHELL=3D/bin/sh. /lava-57203/env=
ironment
    2023-02-22T19:05:59.036653  =

    2023-02-22T19:05:59.137841  / # . /lava-57203/environment/lava-57203/bi=
n/lava-test-runner /lava-57203/1
    2023-02-22T19:05:59.138455  =

    2023-02-22T19:05:59.142366  / # /lava-57203/bin/lava-test-runner /lava-=
57203/1
    2023-02-22T19:05:59.307569  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | omap2plus_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63f6675ed88b642a9e8c8642

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm/omap2plus_defconfig/gcc-1=
0/lab-broonie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm/omap2plus_defconfig/gcc-1=
0/lab-broonie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230217.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63f6675ed88b642a9e8c864b
        new failure (last pass: v4.19.271-cip90-81-g5d0e00d43751)

    2023-02-22T19:04:42.404757  + set +x
    2023-02-22T19:04:42.408761  <8>[   54.303284] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 57169_1.6.2.4.1>
    2023-02-22T19:04:42.541426  #
    2023-02-22T19:04:42.643649  / # #export SHELL=3D/bin/sh
    2023-02-22T19:04:42.644180  =

    2023-02-22T19:04:42.745582  / # export SHELL=3D/bin/sh. /lava-57169/env=
ironment
    2023-02-22T19:04:42.746155  =

    2023-02-22T19:04:42.847753  / # . /lava-57169/environment/lava-57169/bi=
n/lava-test-runner /lava-57169/1
    2023-02-22T19:04:42.849038  =

    2023-02-22T19:04:42.852786  / # /lava-57169/bin/lava-test-runner /lava-=
57169/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63f66753d88b642a9e8c8634

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm/multi_v7_defconfig/gcc-10=
/lab-collabora/baseline-nfs-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm/multi_v7_defconfig/gcc-10=
/lab-collabora/baseline-nfs-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230217.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63f66753d88b642a9e8c863d
        failing since 34 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-22T19:04:43.967676  / # #

    2023-02-22T19:04:44.070934  export SHELL=3D/bin/sh

    2023-02-22T19:04:44.071749  #

    2023-02-22T19:04:44.173821  / # export SHELL=3D/bin/sh. /lava-9284184/e=
nvironment

    2023-02-22T19:04:44.174648  =


    2023-02-22T19:04:44.276766  / # . /lava-9284184/environment/lava-928418=
4/bin/lava-test-runner /lava-9284184/1

    2023-02-22T19:04:44.278009  =


    2023-02-22T19:04:44.290214  / # /lava-9284184/bin/lava-test-runner /lav=
a-9284184/1

    2023-02-22T19:04:44.456587  + export TESTRUN_ID=3D1_bootrr

    2023-02-22T19:04:44.456756  + cd /lava-9284184/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 4          =


  Details:     https://kernelci.org/test/plan/id/63f66868ab50fe85e78c8631

  Results:     79 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230217.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rk3399-gru-sound-driver-rt5514-present: https://ker=
nelci.org/test/case/id/63f66868ab50fe85e78c866b
        failing since 34 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-22T19:09:02.159554  <8>[   35.624518] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-max98357A-present RESULT=3Dfail>

    2023-02-22T19:09:02.176969  seq: invalid floating point argument: =E2=
=80=98sound/RT5514=E2=80=99

    2023-02-22T19:09:02.180295  Try 'seq --help' for more information.

    2023-02-22T19:09:02.184726  /lava-9284229/1/../bin/lava-test-case

    2023-02-22T19:09:02.196414  <8>[   35.662391] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-rt5514-present RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-max98357A-present: https://=
kernelci.org/test/case/id/63f66868ab50fe85e78c866c
        failing since 34 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-22T19:09:02.138969  seq: invalid floating point argument: =E2=
=80=98sound/MAX98357A=E2=80=99

    2023-02-22T19:09:02.142788  Try 'seq --help' for more information.

    2023-02-22T19:09:02.146228  /lava-9284229/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-dp-present: https://kernelc=
i.org/test/case/id/63f66868ab50fe85e78c866d
        failing since 34 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-22T19:09:02.099280  seq: invalid floating point argument: =E2=
=80=98sound/DP=E2=80=99

    2023-02-22T19:09:02.102719  Try 'seq --help' for more information.

    2023-02-22T19:09:02.106405  /lava-9284229/1/../bin/lava-test-case

    2023-02-22T19:09:02.120880  <8>[   35.586707] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-dp-present RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-da7219-present: https://ker=
nelci.org/test/case/id/63f66868ab50fe85e78c866e
        failing since 34 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-22T19:09:02.048063  seq: invalid floating point argument: =E2=
=80=98sound/DA7219=E2=80=99

    2023-02-22T19:09:02.051134  Try 'seq --help' for more information.

    2023-02-22T19:09:02.055570  /lava-9284229/1/../bin/lava-test-case

    2023-02-22T19:09:02.069232  <8>[   35.534710] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-da7219-present RESULT=3Dfail>
   =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
sun50i-a64-pine64-plus    | arm64  | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/63f66b7190ef93d7d38c8631

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-nfs-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-nfs-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230217.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63f66b7190ef93d7d38c863a
        failing since 34 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-22T19:22:12.446228  <8>[   22.367116] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 57104_1.6.2.4.1>
    2023-02-22T19:22:12.555944  / # #
    2023-02-22T19:22:12.658587  export SHELL=3D/bin/sh
    2023-02-22T19:22:12.659248  #
    2023-02-22T19:22:12.761375  / # export SHELL=3D/bin/sh. /lava-57104/env=
ironment
    2023-02-22T19:22:12.762202  =

    2023-02-22T19:22:12.864538  / # . /lava-57104/environment/lava-57104/bi=
n/lava-test-runner /lava-57104/1
    2023-02-22T19:22:12.865795  =

    2023-02-22T19:22:12.869051  / # /lava-57104/bin/lava-test-runner /lava-=
57104/1
    2023-02-22T19:22:12.948647  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =20

