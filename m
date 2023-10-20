Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BDBC001DF
	for <webhook@archiver.kernel.org>; Fri, 20 Oct 2023 14:52:39 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
 by mx.groups.io with SMTP id smtpd.web11.56493.1697813557802980631
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 20 Oct 2023 07:52:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=GH4/Qao/;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.181, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-692c02adeefso776829b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 20 Oct 2023 07:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1697813556; x=1698418356; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QY4P1eYn+YCmyLQ9vYVsmKiDrr4lijsE114PVOrhbGQ=;
        b=GH4/Qao/gr3QjJ/7lOpFggNH6CQOfQcxu1mNa1AJ5/5LA6ug57RV9Wzd0ZvoRMk177
         64UnUokS6Snc2KBqtnF/Bp5sLYL79Nsz6sy2tLUlBpH0CmRrAhTuQ2e3u+l9z4J/gI6p
         xfCmdy2BFEeZyQTgZjBMPp5uqEuI/+hKA4LNY8IJ1Oz/F9bJTzLfhbusNuRYW5DFYbN8
         EsMBVqojdlm34H/ta5XbVQIyOW4kW8D4Z+Wt/sENXnnYW07vwE+qjUaVXU2pDtK/lBde
         rNKA9lBOCjL/OayQWRWEwTb8b1zU+Mxgnx/2DwF39C4Mm+H77orpj3toUEaHz7c0xARn
         lTLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697813556; x=1698418356;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QY4P1eYn+YCmyLQ9vYVsmKiDrr4lijsE114PVOrhbGQ=;
        b=mWPyFtdQuDOI6w1ePnXo7o4HB7bGvZA4CReus8Gl59lPxyX+8DK6aT4goXAoIVnH1p
         J3fjfCXr+mIuSa1urZ8yrhhaE5ekXq9XlV/yZid1Bgj0DVLFXVHt2UNE27v5W8yDQbBa
         +G/ZM2zKxPIPdZ7LKwWqNRxOzwGQd0DG4yy/v7xVMfD2CHvW/3W1SCa3CE0h3IjX3pIp
         GYVdSU3cKdkhd64QJ8U+IsneRkyWfNuS9PeaDkqXcb8P3QWUN7oxpD4Fipjd7NmLQy2e
         hsom27+MW0wTMBiTKpV6mEFRP+JOJN9qlVBzusOULDQbDWyzb1NfJlOvq9g1bS47uWni
         vPQA==
X-Gm-Message-State: AOJu0YwgxTyZZpRXsY7X+IMTfV1CJknUDBFOMVMXFf/olh87PeHVFmmg
	6V3nlWkafOE8eie9aYzc2NQs9ieB/661ekvtQymXLw==
X-Google-Smtp-Source: AGHT+IFPw+4QGlVifOSXT7UrKuhC5LkecXgxpBngQATuraNZ8i527BG5gtR0MueGbkgnXAHm6oGHaQ==
X-Received: by 2002:a05:6a20:cea3:b0:174:af85:954b with SMTP id if35-20020a056a20cea300b00174af85954bmr2160132pzb.22.1697813556068;
        Fri, 20 Oct 2023 07:52:36 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id gc21-20020a17090b311500b0027d0de51454sm3359019pjb.19.2023.10.20.07.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 07:52:34 -0700 (PDT)
Message-ID: <65329432.170a0220.1f132.b49c@mx.google.com>
Date: Fri, 20 Oct 2023 07:52:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.19.295-cip103-rt33
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-4.19.y-cip-rt
X-Kernelci-Tree: cip
Subject: cip/linux-4.19.y-cip-rt baseline-nfs: 81 runs,
 18 regressions (v4.19.295-cip103-rt33)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 20 Oct 2023 14:52:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13414

cip/linux-4.19.y-cip-rt baseline-nfs: 81 runs, 18 regressions (v4.19.295-ci=
p103-rt33)

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

beaglebone-black          | arm    | lab-broonie   | gcc-10   | defconfig+p=
reempt_rt         | 1          =

beaglebone-black          | arm    | lab-cip       | gcc-10   | defconfig  =
                  | 1          =

beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =

beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fc...g+preempt_rt | 1          =

beaglebone-black          | arm    | lab-cip       | gcc-10   | multi_v7_de=
fconfig           | 1          =

beaglebone-black          | arm    | lab-cip       | gcc-10   | multi_v7_de=
fc...g+preempt_rt | 1          =

imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | defconfig  =
                  | 1          =

imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | defconfig+p=
reempt_rt         | 1          =

imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =

imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fc...g+preempt_rt | 1          =

r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig+p=
reempt_rt         | 1          =

sun50i-a64-pine64-plus    | arm64  | lab-broonie   | gcc-10   | defconfig+p=
reempt_rt         | 1          =

sun50i-a64-pine64-plus    | arm64  | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip-rt/ke=
rnel/v4.19.295-cip103-rt33/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.19.y-cip-rt
  Describe: v4.19.295-cip103-rt33
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      28d064262557c550e33da563b323e56c214e60fd =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | defconfig+x=
86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/65328cfad671958e21efcfc2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baseli=
ne-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baseli=
ne-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65328cfad671958e21efcfcb
        failing since 274 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-10-20T14:23:10.107162  + set +x<8>[   14.896992] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11829240_1.5.2.3.1>

    2023-10-20T14:23:10.107246  =


    2023-10-20T14:23:10.211534  / # #

    2023-10-20T14:23:10.312119  export SHELL=3D/bin/sh

    2023-10-20T14:23:10.312389  #

    2023-10-20T14:23:10.413089  / # export SHELL=3D/bin/sh. /lava-11829240/=
environment

    2023-10-20T14:23:10.413284  =


    2023-10-20T14:23:10.513803  / # . /lava-11829240/environment/lava-11829=
240/bin/lava-test-runner /lava-11829240/1

    2023-10-20T14:23:10.514076  =


    2023-10-20T14:23:10.518604  / # /lava-11829240/bin/lava-test-runner /la=
va-11829240/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/65328dff5fcdd631d0efcf08

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/la=
b-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/la=
b-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65328e005fcdd631d0efcf11
        failing since 274 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-10-20T14:27:31.344353  <6>[   14.766251] sh (1631) used greatest s=
tack depth: 11928 bytes left

    2023-10-20T14:27:31.350830  + <8>[   14.773519] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11829362_1.5.2.3.1>

    2023-10-20T14:27:31.350917  set +x

    2023-10-20T14:27:31.455200  / # #

    2023-10-20T14:27:31.555797  export SHELL=3D/bin/sh

    2023-10-20T14:27:31.555980  #

    2023-10-20T14:27:31.656530  / # export SHELL=3D/bin/sh. /lava-11829362/=
environment

    2023-10-20T14:27:31.656723  =


    2023-10-20T14:27:31.757260  / # . /lava-11829362/environment/lava-11829=
362/bin/lava-test-runner /lava-11829362/1

    2023-10-20T14:27:31.757543  =

 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | defconfig+x=
86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/65328cf87126f13351efcf17

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baseli=
ne-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baseli=
ne-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65328cf87126f13351efcf20
        failing since 274 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-10-20T14:21:31.387144  <8>[   21.981880] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-10-20T14:21:31.387908  + set +x

    2023-10-20T14:21:31.393919  <8>[   21.992323] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11829223_1.5.2.3.1>

    2023-10-20T14:21:31.504188  #

    2023-10-20T14:21:31.606975  / # #export SHELL=3D/bin/sh

    2023-10-20T14:21:31.607767  =


    2023-10-20T14:21:31.709282  / # export SHELL=3D/bin/sh. /lava-11829223/=
environment

    2023-10-20T14:21:31.710015  =


    2023-10-20T14:21:31.811378  / # . /lava-11829223/environment/lava-11829=
223/bin/lava-test-runner /lava-11829223/1

    2023-10-20T14:21:31.812541  =

 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/65328ec55fd4c4f155efcf14

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/la=
b-collabora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/la=
b-collabora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65328ec55fd4c4f15=
5efcf15
        new failure (last pass: v4.19.288-cip101-rt32) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65328f2353959509a6efcf3c

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-bl=
ack.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-bl=
ack.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65328f2353959509a6efcf6a
        failing since 274 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-10-20T14:30:01.327894  <8>[   49.258302] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 181392_1.6.2.4.1>
    2023-10-20T14:30:01.446387  / # #
    2023-10-20T14:30:01.548830  export SHELL=3D/bin/sh
    2023-10-20T14:30:01.549671  #
    2023-10-20T14:30:01.651193  / # export SHELL=3D/bin/sh. /lava-181392/en=
vironment
    2023-10-20T14:30:01.651679  =

    2023-10-20T14:30:01.753961  / # . /lava-181392/environment/lava-181392/=
bin/lava-test-runner /lava-181392/1
    2023-10-20T14:30:01.754804  =

    2023-10-20T14:30:01.758670  / # /lava-181392/bin/lava-test-runner /lava=
-181392/1
    2023-10-20T14:30:02.052931  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | defconfig+p=
reempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/65328f6189c6846c31efcf37

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-nfs-be=
aglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-nfs-be=
aglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65328f6189c6846c31efcf66
        failing since 274 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-10-20T14:31:03.466430  <8>[   53.278296] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 181438_1.6.2.4.1>
    2023-10-20T14:31:03.579746  / # #
    2023-10-20T14:31:03.682352  export SHELL=3D/bin/sh
    2023-10-20T14:31:03.682986  #
    2023-10-20T14:31:03.784825  / # export SHELL=3D/bin/sh. /lava-181438/en=
vironment
    2023-10-20T14:31:03.785356  =

    2023-10-20T14:31:03.887303  / # . /lava-181438/environment/lava-181438/=
bin/lava-test-runner /lava-181438/1
    2023-10-20T14:31:03.888519  =

    2023-10-20T14:31:03.893064  / # /lava-181438/bin/lava-test-runner /lava=
-181438/1
    2023-10-20T14:31:04.099814  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-cip       | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/653292345bf4cdfe3cefcefc

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/defconfig/gcc-10/lab-cip/baseline-nfs-beaglebone-black.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/defconfig/gcc-10/lab-cip/baseline-nfs-beaglebone-black.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/653292355bf4cdfe3cefcf2b
        failing since 274 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-10-20T14:42:10.018440  <8>[   40.674138] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1023140_1.6.2.4.1>
    2023-10-20T14:42:10.132053  / # #
    2023-10-20T14:42:10.233420  export SHELL=3D/bin/sh
    2023-10-20T14:42:10.233876  #
    2023-10-20T14:42:10.334781  / # export SHELL=3D/bin/sh. /lava-1023140/e=
nvironment
    2023-10-20T14:42:10.335219  =

    2023-10-20T14:42:10.436215  / # . /lava-1023140/environment/lava-102314=
0/bin/lava-test-runner /lava-1023140/1
    2023-10-20T14:42:10.436909  =

    2023-10-20T14:42:10.440473  / # /lava-1023140/bin/lava-test-runner /lav=
a-1023140/1
    2023-10-20T14:42:10.613466  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65328a45a344be6bf1efcf00

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65328a45a344be6bf1efcf2f
        failing since 274 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-10-20T14:09:18.484232  <8>[   43.292335] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-10-20T14:09:18.484410  + set +x
    2023-10-20T14:09:18.488447  <8>[   43.303032] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 181306_1.6.2.4.1>
    2023-10-20T14:09:18.605981  / # #
    2023-10-20T14:09:18.707554  export SHELL=3D/bin/sh
    2023-10-20T14:09:18.707905  #
    2023-10-20T14:09:18.808825  / # export SHELL=3D/bin/sh. /lava-181306/en=
vironment
    2023-10-20T14:09:18.809203  =

    2023-10-20T14:09:18.910337  / # . /lava-181306/environment/lava-181306/=
bin/lava-test-runner /lava-181306/1
    2023-10-20T14:09:18.910890   =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fc...g+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/65328d9454fabac4eeefcf02

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-broonie/baseli=
ne-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-broonie/baseli=
ne-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65328d9454fabac4eeefcf31
        failing since 274 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-10-20T14:23:33.836226  <8>[   53.347790] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 181351_1.6.2.4.1>
    2023-10-20T14:23:33.958080  / # #
    2023-10-20T14:23:34.061037  export SHELL=3D/bin/sh
    2023-10-20T14:23:34.061762  #
    2023-10-20T14:23:34.163887  / # export SHELL=3D/bin/sh. /lava-181351/en=
vironment
    2023-10-20T14:23:34.164623  =

    2023-10-20T14:23:34.267208  / # . /lava-181351/environment/lava-181351/=
bin/lava-test-runner /lava-181351/1
    2023-10-20T14:23:34.268271  =

    2023-10-20T14:23:34.272969  / # /lava-181351/bin/lava-test-runner /lava=
-181351/1
    2023-10-20T14:23:34.490063  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-cip       | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65328d04b741cb5a27efcf19

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebo=
ne-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebo=
ne-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65328d04b741cb5a27efcf43
        failing since 274 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-10-20T14:20:57.496024  <8>[   48.328507] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1023104_1.6.2.4.1>
    2023-10-20T14:20:57.666153  / # #
    2023-10-20T14:20:57.767316  export SHELL=3D/bin/sh
    2023-10-20T14:20:57.767885  #
    2023-10-20T14:20:57.869017  / # export SHELL=3D/bin/sh. /lava-1023104/e=
nvironment
    2023-10-20T14:20:57.869322  =

    2023-10-20T14:20:57.970138  / # . /lava-1023104/environment/lava-102310=
4/bin/lava-test-runner /lava-1023104/1
    2023-10-20T14:20:57.971187  =

    2023-10-20T14:20:57.977072  / # /lava-1023104/bin/lava-test-runner /lav=
a-1023104/1
    2023-10-20T14:20:58.222971  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-cip       | gcc-10   | multi_v7_de=
fc...g+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/653290f320a2f6d1f5efcef6

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-cip/baseline-n=
fs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-cip/baseline-n=
fs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/653290f320a2f6d1f5efcf25
        failing since 274 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-10-20T14:36:36.674454  <8>[   45.455922] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1023120_1.6.2.4.1>
    2023-10-20T14:36:36.789478  / # #
    2023-10-20T14:36:36.890926  export SHELL=3D/bin/sh
    2023-10-20T14:36:36.891360  #
    2023-10-20T14:36:36.992299  / # export SHELL=3D/bin/sh. /lava-1023120/e=
nvironment
    2023-10-20T14:36:36.992735  =

    2023-10-20T14:36:37.093714  / # . /lava-1023120/environment/lava-102312=
0/bin/lava-test-runner /lava-1023120/1
    2023-10-20T14:36:37.094434  =

    2023-10-20T14:36:37.098235  / # /lava-1023120/bin/lava-test-runner /lav=
a-1023120/1
    2023-10-20T14:36:37.316176  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65328da0cf7ef2c6eeefcf0e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/defconfig/gcc-10/lab-collabora/baseline-nfs-imx6q-sabre=
lite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/defconfig/gcc-10/lab-collabora/baseline-nfs-imx6q-sabre=
lite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65328da0cf7ef2c6eeefcf17
        failing since 274 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-10-20T14:24:14.032060  / # #

    2023-10-20T14:24:14.134382  export SHELL=3D/bin/sh

    2023-10-20T14:24:14.135176  #

    2023-10-20T14:24:14.236994  / # export SHELL=3D/bin/sh. /lava-11829287/=
environment

    2023-10-20T14:24:14.237720  =


    2023-10-20T14:24:14.339411  / # . /lava-11829287/environment/lava-11829=
287/bin/lava-test-runner /lava-11829287/1

    2023-10-20T14:24:14.340552  =


    2023-10-20T14:24:14.356001  / # /lava-11829287/bin/lava-test-runner /la=
va-11829287/1

    2023-10-20T14:24:14.511888  + export TESTRUN_ID=3D1_bootrr

    2023-10-20T14:24:14.512346  + cd /lava-11829287/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | defconfig+p=
reempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/65328dafcf7ef2c6eeefcf66

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-nfs-=
imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-nfs-=
imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65328dafcf7ef2c6eeefcf6f
        failing since 274 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-10-20T14:24:51.272785  / # #

    2023-10-20T14:24:51.374766  export SHELL=3D/bin/sh

    2023-10-20T14:24:51.375440  #

    2023-10-20T14:24:51.476796  / # export SHELL=3D/bin/sh. /lava-11829320/=
environment

    2023-10-20T14:24:51.477445  =


    2023-10-20T14:24:51.578821  / # . /lava-11829320/environment/lava-11829=
320/bin/lava-test-runner /lava-11829320/1

    2023-10-20T14:24:51.579859  =


    2023-10-20T14:24:51.581813  / # /lava-11829320/bin/lava-test-runner /la=
va-11829320/1

    2023-10-20T14:24:51.766307  + export TESTRUN_ID=3D1_bootrr

    2023-10-20T14:24:51.766715  + cd /lava-11829320/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/653289f4af891c101fefcf1a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-nfs-im=
x6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-nfs-im=
x6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/653289f4af891c101fefcf23
        failing since 274 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-10-20T14:08:40.687115  / # #

    2023-10-20T14:08:40.789805  export SHELL=3D/bin/sh

    2023-10-20T14:08:40.790504  #

    2023-10-20T14:08:40.892488  / # export SHELL=3D/bin/sh. /lava-11829133/=
environment

    2023-10-20T14:08:40.893230  =


    2023-10-20T14:08:40.995172  / # . /lava-11829133/environment/lava-11829=
133/bin/lava-test-runner /lava-11829133/1

    2023-10-20T14:08:40.995567  =


    2023-10-20T14:08:40.998860  / # /lava-11829133/bin/lava-test-runner /la=
va-11829133/1

    2023-10-20T14:08:41.200744  + export TESTRUN_ID=3D1_bootrr

    2023-10-20T14:08:41.201244  + cd /lava-11829133/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fc...g+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/65328c5a3feb071417efcf19

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-collabora/base=
line-nfs-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-collabora/base=
line-nfs-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65328c5a3feb071417efcf22
        failing since 274 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-10-20T14:19:08.821550  / # #

    2023-10-20T14:19:08.923761  export SHELL=3D/bin/sh

    2023-10-20T14:19:08.924450  #

    2023-10-20T14:19:09.025859  / # export SHELL=3D/bin/sh. /lava-11829193/=
environment

    2023-10-20T14:19:09.026566  =


    2023-10-20T14:19:09.128060  / # . /lava-11829193/environment/lava-11829=
193/bin/lava-test-runner /lava-11829193/1

    2023-10-20T14:19:09.129174  =


    2023-10-20T14:19:09.130123  / # /lava-11829193/bin/lava-test-runner /la=
va-11829193/1

    2023-10-20T14:19:09.319932  + export TESTRUN_ID=3D1_bootrr

    2023-10-20T14:19:09.320419  + cd /lava-11829193/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig+p=
reempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/65328e801036c0d158efcf24

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm64/defconfig+preempt_rt/gcc-10/lab-cip/baseline-nfs-r8a7=
74a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm64/defconfig+preempt_rt/gcc-10/lab-cip/baseline-nfs-r8a7=
74a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65328e801036c0d15=
8efcf25
        new failure (last pass: v4.19.288-cip101-rt32) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
sun50i-a64-pine64-plus    | arm64  | lab-broonie   | gcc-10   | defconfig+p=
reempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/65328f3753959509a6efcf6f

  Results:     23 PASS, 16 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm64/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-nfs-=
sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm64/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-nfs-=
sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65328f3753959509a6efcf99
        failing since 274 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-10-20T14:30:47.664668  <8>[   25.689503] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 181379_1.6.2.4.1>
    2023-10-20T14:30:47.775397  / # #
    2023-10-20T14:30:47.877586  export SHELL=3D/bin/sh
    2023-10-20T14:30:47.878130  #
    2023-10-20T14:30:47.979689  / # export SHELL=3D/bin/sh. /lava-181379/en=
vironment
    2023-10-20T14:30:47.980265  =

    2023-10-20T14:30:48.082495  / # . /lava-181379/environment/lava-181379/=
bin/lava-test-runner /lava-181379/1
    2023-10-20T14:30:48.083543  =

    2023-10-20T14:30:48.087415  / # /lava-181379/bin/lava-test-runner /lava=
-181379/1
    2023-10-20T14:30:48.188952  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
sun50i-a64-pine64-plus    | arm64  | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65328feb5469ecc565efcef3

  Results:     23 PASS, 16 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-sun50i-a64-=
pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-sun50i-a64-=
pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65328feb5469ecc565efcf1d
        failing since 274 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-10-20T14:33:43.065978  <8>[   34.133464] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 181433_1.6.2.4.1>
    2023-10-20T14:33:43.261300  / # #
    2023-10-20T14:33:43.364511  export SHELL=3D/bin/sh
    2023-10-20T14:33:43.365656  #
    2023-10-20T14:33:43.467747  / # export SHELL=3D/bin/sh. /lava-181433/en=
vironment
    2023-10-20T14:33:43.468236  =

    2023-10-20T14:33:43.569616  / # . /lava-181433/environment/lava-181433/=
bin/lava-test-runner /lava-181433/1
    2023-10-20T14:33:43.571404  =

    2023-10-20T14:33:43.575010  /lava-181433/bin/lava-test-runner /lava-181=
433/1
    2023-10-20T14:33:43.869443  / # + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =20

