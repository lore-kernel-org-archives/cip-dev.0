X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
 by mx.groups.io with SMTP id smtpd.web10.30278.1652715313143952964
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 16 May 2022 08:35:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=5fMOEm0/;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.177, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f177.google.com with SMTP id v10so14398237pgl.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 16 May 2022 08:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=ESJvRKpxiFF5tewRVFxBhd9fA/X5DlYAA53moiq1ufE=;
        b=5fMOEm0/wLy89Aso1G6W7VrDf1I4KnoheNu6FDnk8rhOITa6oAxZzNYqQeDysupLqg
         xFPy1IE1RhpT/MrG5XA7JDP8YObFelL1N7uxQW3n/+VUXBXtvuSEY0TDklECIJFcz2Ea
         38hkRqqqtKR1UGi6QSLurjsrYWpPHUpb1DknBnoXDH6YM61oXHHmiSjdFpwtutpeXC22
         Ilk1NBysAITmArXQ1W+QMeRbV3twudRD0SAAJNAUvHgxlWBhiC3kKPsK8Hhd0+l6y8Qz
         BAc7PWVU3MxMfUKqVKrlPgbiVlQ5DTicubM7vGCP19l+AybjBy+kYLY6mxtCaI09FDjM
         LRsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=ESJvRKpxiFF5tewRVFxBhd9fA/X5DlYAA53moiq1ufE=;
        b=EyPfta+/tTSRE3NT1j/KkRfaO0twyauYIcJprG4zOMOQU5RGhro45F6IcxrNpQgZHG
         V9SQbORFOiuIQbq0nBcma84dWhTwV4xrkgth29ctoYpEX0RNA7fTWfP/o8p7bgDEYI11
         3L0AYF7Xnk3fEwNpBmuI5NxWrttF29F1ZKs8tIdNY2PpndSpTb2yqHMX+PzhIoNcGCRo
         h3kPuICvG6RSNZOkae/7jPMP6lW806LQvoVdKPqWDeqMw8BdXB2glGxGGWTP784939qX
         J6mPMjbtGILxQildmA152es1QM8ht3tv/kU5d6dE5WAR2OesSTUwmEGwhvWih5ZxhX1w
         qoOQ==
X-Gm-Message-State: AOAM533FPONfqWS3m+NFcObUOghGNSEydYpx8eQKoATPBbM0p3McU3Ci
	DFvYSk+Mg8g5smN4H0BUsHYu5+4/F63PNUnEW4k=
X-Google-Smtp-Source: ABdhPJxC3qkTG8iKNr3OnXedocE0szqig6kEsMibY7yJ5//2BBiutRG2wKLMS2EGpPAG4iokTAxK2w==
X-Received: by 2002:a05:6a00:349b:b0:50e:570:180e with SMTP id cp27-20020a056a00349b00b0050e0570180emr17985268pfb.13.1652715311601;
        Mon, 16 May 2022 08:35:11 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id r5-20020a170902e3c500b001617541c94fsm2755314ple.60.2022.05.16.08.35.10
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 08:35:10 -0700 (PDT)
Message-ID: <62826f2e.1c69fb81.81079.6508@mx.google.com>
Date: Mon, 16 May 2022 08:35:10 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4-st5-208-g5e70bc68d09e
Subject: cip-gitlab/ci/pavel/linux-test baseline: 55 runs, 26 regressions (v4.4-st5-208-g5e70bc68d09e) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test baseline: 55 runs, 26 regressions (v4.4-st5-=
208-g5e70bc68d09e)

Regressions Summary
-------------------

platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
asus-C436FA-Flip-hatch     | x86_64 | lab-collabora | gcc-10   | x86_64_def=
con...6-chromebook | 1          =

asus-cx9400-volteer        | x86_64 | lab-collabora | gcc-10   | x86_64_def=
con...6-chromebook | 1          =

at91-sama5d4_xplained      | arm    | lab-baylibre  | gcc-10   | multi_v7_d=
efconfig           | 1          =

beagle-xm                  | arm    | lab-baylibre  | gcc-10   | omap2plus_=
defconfig          | 2          =

beaglebone-black           | arm    | lab-broonie   | gcc-10   | multi_v7_d=
efconfig           | 1          =

beaglebone-black           | arm    | lab-cip       | gcc-10   | multi_v7_d=
efconfig           | 1          =

beaglebone-black           | arm    | lab-broonie   | gcc-10   | omap2plus_=
defconfig          | 1          =

beaglebone-black           | arm    | lab-cip       | gcc-10   | omap2plus_=
defconfig          | 1          =

hp-x360-12b-n4000-octopus  | x86_64 | lab-collabora | gcc-10   | x86_64_def=
con...6-chromebook | 1          =

juno-uboot                 | arm64  | lab-broonie   | gcc-10   | defconfig =
                   | 1          =

meson8b-odroidc1           | arm    | lab-baylibre  | gcc-10   | multi_v7_d=
efconfig           | 1          =

qemu_arm-virt-gicv2        | arm    | lab-baylibre  | gcc-10   | multi_v7_d=
efconfig           | 1          =

qemu_arm-virt-gicv2-uefi   | arm    | lab-baylibre  | gcc-10   | multi_v7_d=
efconfig           | 1          =

qemu_arm-virt-gicv3        | arm    | lab-baylibre  | gcc-10   | multi_v7_d=
efconfig           | 1          =

qemu_arm-virt-gicv3-uefi   | arm    | lab-baylibre  | gcc-10   | multi_v7_d=
efconfig           | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-baylibre  | gcc-10   | defconfig =
                   | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-baylibre  | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-baylibre  | gcc-10   | defconfig =
                   | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-baylibre  | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-baylibre  | gcc-10   | defconfig =
                   | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-baylibre  | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-baylibre  | gcc-10   | defconfig =
                   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-baylibre  | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

qemu_x86_64-uefi-mixed     | x86_64 | lab-baylibre  | gcc-10   | x86_64_def=
config             | 1          =

qemu_x86_64-uefi-mixed     | x86_64 | lab-baylibre  | gcc-10   | x86_64_def=
con...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-208-g5e70bc68d09e/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-208-g5e70bc68d09e
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      5e70bc68d09e77ff437512cfdec26dcf5710d90e =



Test Regressions
---------------- =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
asus-C436FA-Flip-hatch     | x86_64 | lab-collabora | gcc-10   | x86_64_def=
con...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62826b3291e811c5118f5736

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62826b3291e811c5118f5=
737
        failing since 5 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
asus-cx9400-volteer        | x86_64 | lab-collabora | gcc-10   | x86_64_def=
con...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6282688eeec7c425088f5733

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6282688eeec7c425088f5=
734
        failing since 5 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
at91-sama5d4_xplained      | arm    | lab-baylibre  | gcc-10   | multi_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/62826947be91616ad78f5737

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/arm/multi_v7_defconfig/gcc-10/lab-baylibre/base=
line-at91-sama5d4_xplained.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/arm/multi_v7_defconfig/gcc-10/lab-baylibre/base=
line-at91-sama5d4_xplained.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62826947be91616ad78f5=
738
        failing since 5 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-260-gb0fe64f485ff) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
beagle-xm                  | arm    | lab-baylibre  | gcc-10   | omap2plus_=
defconfig          | 2          =


  Details:     https://kernelci.org/test/plan/id/62826a394c0f58ecf48f5749

  Results:     3 PASS, 2 FAIL, 2 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/arm/omap2plus_defconfig/gcc-10/lab-baylibre/bas=
eline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/arm/omap2plus_defconfig/gcc-10/lab-baylibre/bas=
eline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/armel/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/62826a394c0f58e=
cf48f5750
        new failure (last pass: v4.4.302-cip69-50-gba851b77071ca)
        29 lines

    2022-05-16T15:13:41.473876  [   49.764984] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dalert RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2022-05-16T15:13:41.526589  kern  :emerg : Internal error: Oops - BUG: =
0 [#1] SMP ARM
    2022-05-16T15:13:41.533922  kern  :emerg : Process udevd (pid: 111, sta=
ck limit =3D 0xc9896218)
    2022-05-16T15:13:41.536466  kern  :emerg : Stack: (0xc9897cf8 to 0xc989=
8000)
    2022-05-16T15:13:41.545517  kern  :emerg : 7ce0:                       =
                                bf02bdc4 60000013   =


  * baseline.dmesg.crit: https://kernelci.org/test/case/id/62826a394c0f58ec=
f48f5752
        new failure (last pass: v4.4.302-cip69-50-gba851b77071ca)
        1 lines

    2022-05-16T15:13:40.600944  =

    2022-05-16T15:13:40.703768  / # #
    2022-05-16T15:13:40.704274  =

    2022-05-16T15:13:40.805451  / # #export SHELL=3D/bin/sh
    2022-05-16T15:13:40.805792  =

    2022-05-16T15:13:40.906885  / # export SHELL=3D/bin/sh. /lava-1971784/e=
nvironment
    2022-05-16T15:13:40.907233  =

    2022-05-16T15:13:41.008335  / # . /lava-1971784/environment/lava-197178=
4/bin/lava-test-runner /lava-1971784/0
    2022-05-16T15:13:41.009290  =

    2022-05-16T15:13:41.011619  / # /lava-1971784/bin/lava-test-runner /lav=
a-1971784/0 =

    ... (8 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
beaglebone-black           | arm    | lab-broonie   | gcc-10   | multi_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6282684fc11569d6e88f575f

  Results:     4 PASS, 1 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/arm/multi_v7_defconfig/gcc-10/lab-broonie/basel=
ine-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/arm/multi_v7_defconfig/gcc-10/lab-broonie/basel=
ine-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/armel/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/6282684fc11569d6=
e88f5768
        failing since 5 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-260-gb0fe64f485ff)
        1 lines

    2022-05-16T15:05:40.542308  / # =

    2022-05-16T15:05:40.548013  =

    2022-05-16T15:05:40.654700  / # #
    2022-05-16T15:05:40.660302  #
    2022-05-16T15:05:40.762865  / # export SHELL=3D/bin/sh
    2022-05-16T15:05:40.768528  export SHELL=3D/bin/sh
    2022-05-16T15:05:40.870555  / # . /lava-148212/environment
    2022-05-16T15:05:40.875842  . /lava-148212/environment
    2022-05-16T15:05:40.977525  / # /lava-148212/bin/lava-test-runner /lava=
-148212/0
    2022-05-16T15:05:40.982708  /lava-148212/bin/lava-test-runner /lava-148=
212/0 =

    ... (9 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
beaglebone-black           | arm    | lab-cip       | gcc-10   | multi_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/628269335549a6c6768f5733

  Results:     4 PASS, 1 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-=
beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-=
beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/armel/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/628269335549a6c6=
768f573a
        failing since 5 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-260-gb0fe64f485ff)
        1 lines

    2022-05-16T15:09:17.245881  / # =

    2022-05-16T15:09:17.252620  =

    2022-05-16T15:09:17.358975  / # #
    2022-05-16T15:09:17.366126  #
    2022-05-16T15:09:17.468220  / # export SHELL=3D/bin/sh
    2022-05-16T15:09:17.475598  export SHELL=3D/bin/sh
    2022-05-16T15:09:17.577524  / # . /lava-680997/environment
    2022-05-16T15:09:17.584042  . /lava-680997/environment
    2022-05-16T15:09:17.685949  / # /lava-680997/bin/lava-test-runner /lava=
-680997/0
    2022-05-16T15:09:17.692776  /lava-680997/bin/lava-test-runner /lava-680=
997/0 =

    ... (9 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
beaglebone-black           | arm    | lab-broonie   | gcc-10   | omap2plus_=
defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6282692b10a1e907dc8f5787

  Results:     4 PASS, 1 FAIL, 2 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/arm/omap2plus_defconfig/gcc-10/lab-broonie/base=
line-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/arm/omap2plus_defconfig/gcc-10/lab-broonie/base=
line-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/armel/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/6282692b10a1e907=
dc8f5790
        failing since 5 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-260-gb0fe64f485ff)
        1 lines

    2022-05-16T15:09:22.141521  / # =

    2022-05-16T15:09:22.149355  =

    2022-05-16T15:09:22.255268  / # #
    2022-05-16T15:09:22.261235  #
    2022-05-16T15:09:22.370127  / # export SHELL=3D/bin/sh
    2022-05-16T15:09:22.377146  export SHELL=3D/bin/sh
    2022-05-16T15:09:22.479125  / # . /lava-148225/environment
    2022-05-16T15:09:22.486203  . /lava-148225/environment
    2022-05-16T15:09:22.588204  / # /lava-148225/bin/lava-test-runner /lava=
-148225/0
    2022-05-16T15:09:22.593725  /lava-148225/bin/lava-test-runner /lava-148=
225/0 =

    ... (9 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
beaglebone-black           | arm    | lab-cip       | gcc-10   | omap2plus_=
defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/62826b154a57359bff8f573d

  Results:     4 PASS, 1 FAIL, 2 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline=
-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline=
-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/armel/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/62826b154a57359b=
ff8f5744
        failing since 5 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-260-gb0fe64f485ff)
        1 lines

    2022-05-16T15:17:21.708215  / # =

    2022-05-16T15:17:21.713325  =

    2022-05-16T15:17:21.817638  / # #
    2022-05-16T15:17:21.821191  #
    2022-05-16T15:17:21.922904  / # export SHELL=3D/bin/sh
    2022-05-16T15:17:21.925616  export SHELL=3D/bin/sh
    2022-05-16T15:17:22.028534  / # . /lava-681004/environment
    2022-05-16T15:17:22.031255  . /lava-681004/environment
    2022-05-16T15:17:22.133991  / # /lava-681004/bin/lava-test-runner /lava=
-681004/0
    2022-05-16T15:17:22.136855  /lava-681004/bin/lava-test-runner /lava-681=
004/0 =

    ... (9 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
hp-x360-12b-n4000-octopus  | x86_64 | lab-collabora | gcc-10   | x86_64_def=
con...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62826c8484864369468f5717

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-hp-x360-12b-n4000-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-hp-x360-12b-n4000-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62826c8484864369468f5=
718
        failing since 5 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
juno-uboot                 | arm64  | lab-broonie   | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/62826c749552a442b28f573f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/arm64/defconfig/gcc-10/lab-broonie/baseline-jun=
o-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/arm64/defconfig/gcc-10/lab-broonie/baseline-jun=
o-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62826c749552a442b28f5=
740
        failing since 5 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-261-g4f0b5ddda6cf) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
meson8b-odroidc1           | arm    | lab-baylibre  | gcc-10   | multi_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/62826891edaba664568f5718

  Results:     4 PASS, 1 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/arm/multi_v7_defconfig/gcc-10/lab-baylibre/base=
line-meson8b-odroidc1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/arm/multi_v7_defconfig/gcc-10/lab-baylibre/base=
line-meson8b-odroidc1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.all-cpus-are-online: https://kernelci.org/test/case/id/=
62826891edaba664568f571c
        failing since 5 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-260-gb0fe64f485ff)

    2022-05-16T15:06:47.725596  /lava-1971782/1/../bin/lava-test-case
    2022-05-16T15:06:47.726077  [   17.327444] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dall-cpus-are-online RESULT=3Dfail>
    2022-05-16T15:06:47.726374  /lava-1971782/1/../bin/lava-test-case   =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm-virt-gicv2        | arm    | lab-baylibre  | gcc-10   | multi_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/628269325549a6c6768f5730

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/arm/multi_v7_defconfig/gcc-10/lab-baylibre/base=
line-qemu_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/arm/multi_v7_defconfig/gcc-10/lab-baylibre/base=
line-qemu_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/628269325549a6c6768f5=
731
        failing since 5 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-260-gb0fe64f485ff) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm-virt-gicv2-uefi   | arm    | lab-baylibre  | gcc-10   | multi_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/62826a344c0f58ecf48f5725

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/arm/multi_v7_defconfig/gcc-10/lab-baylibre/base=
line-qemu_arm-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/arm/multi_v7_defconfig/gcc-10/lab-baylibre/base=
line-qemu_arm-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62826a344c0f58ecf48f5=
726
        failing since 5 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-260-gb0fe64f485ff) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm-virt-gicv3        | arm    | lab-baylibre  | gcc-10   | multi_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6282692410a1e907dc8f575d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/arm/multi_v7_defconfig/gcc-10/lab-baylibre/base=
line-qemu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/arm/multi_v7_defconfig/gcc-10/lab-baylibre/base=
line-qemu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6282692410a1e907dc8f5=
75e
        failing since 5 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-260-gb0fe64f485ff) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm-virt-gicv3-uefi   | arm    | lab-baylibre  | gcc-10   | multi_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/62826a4c4c0f58ecf48f5760

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/arm/multi_v7_defconfig/gcc-10/lab-baylibre/base=
line-qemu_arm-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/arm/multi_v7_defconfig/gcc-10/lab-baylibre/base=
line-qemu_arm-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62826a4d4c0f58ecf48f5=
761
        failing since 5 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-260-gb0fe64f485ff) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-baylibre  | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/6282691f9c88d990a68f571a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/arm64/defconfig/gcc-10/lab-baylibre/baseline-qe=
mu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/arm64/defconfig/gcc-10/lab-baylibre/baseline-qe=
mu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6282691f9c88d990a68f5=
71b
        failing since 6 days (last pass: v4.19.233-516-ge5e741fbfc87, first=
 fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-baylibre  | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/62826980217b727ec08f571a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/arm64/defconfig+arm64-chromebook/gcc-10/lab-bay=
libre/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/arm64/defconfig+arm64-chromebook/gcc-10/lab-bay=
libre/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62826980217b727ec08f5=
71b
        failing since 6 days (last pass: v4.19.233-516-ge5e741fbfc87, first=
 fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-baylibre  | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/628269229c88d990a68f5720

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/arm64/defconfig/gcc-10/lab-baylibre/baseline-qe=
mu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/arm64/defconfig/gcc-10/lab-baylibre/baseline-qe=
mu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/628269229c88d990a68f5=
721
        failing since 6 days (last pass: v4.19.233-516-ge5e741fbfc87, first=
 fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-baylibre  | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/62826984c9d99c81d48f574c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/arm64/defconfig+arm64-chromebook/gcc-10/lab-bay=
libre/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/arm64/defconfig+arm64-chromebook/gcc-10/lab-bay=
libre/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62826984c9d99c81d48f5=
74d
        failing since 6 days (last pass: v4.19.233-516-ge5e741fbfc87, first=
 fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-baylibre  | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/628269209c88d990a68f571d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/arm64/defconfig/gcc-10/lab-baylibre/baseline-qe=
mu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/arm64/defconfig/gcc-10/lab-baylibre/baseline-qe=
mu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/628269209c88d990a68f5=
71e
        failing since 6 days (last pass: v4.19.233-516-ge5e741fbfc87, first=
 fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-baylibre  | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/62826983471dc8e8918f5717

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/arm64/defconfig+arm64-chromebook/gcc-10/lab-bay=
libre/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/arm64/defconfig+arm64-chromebook/gcc-10/lab-bay=
libre/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62826983471dc8e8918f5=
718
        failing since 6 days (last pass: v4.19.233-516-ge5e741fbfc87, first=
 fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-baylibre  | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/628269315549a6c6768f572d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/arm64/defconfig/gcc-10/lab-baylibre/baseline-qe=
mu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/arm64/defconfig/gcc-10/lab-baylibre/baseline-qe=
mu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/628269315549a6c6768f5=
72e
        failing since 6 days (last pass: v4.19.233-516-ge5e741fbfc87, first=
 fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-baylibre  | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/62826981217b727ec08f571d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/arm64/defconfig+arm64-chromebook/gcc-10/lab-bay=
libre/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/arm64/defconfig+arm64-chromebook/gcc-10/lab-bay=
libre/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62826981217b727ec08f5=
71e
        failing since 6 days (last pass: v4.19.233-516-ge5e741fbfc87, first=
 fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_x86_64-uefi-mixed     | x86_64 | lab-baylibre  | gcc-10   | x86_64_def=
config             | 1          =


  Details:     https://kernelci.org/test/plan/id/6282679fe244a8dc598f577b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/x86_64/x86_64_defconfig/gcc-10/lab-baylibre/bas=
eline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/x86_64/x86_64_defconfig/gcc-10/lab-baylibre/bas=
eline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6282679fe244a8dc598f5=
77c
        failing since 5 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_x86_64-uefi-mixed     | x86_64 | lab-baylibre  | gcc-10   | x86_64_def=
con...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/628268a45774014a708f5726

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-baylibre/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-baylibre/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/628268a45774014a708f5=
727
        failing since 5 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =20

