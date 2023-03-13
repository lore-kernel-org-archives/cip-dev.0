Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14400C6FD19
	for <webhook@archiver.kernel.org>; Mon, 13 Mar 2023 13:01:15 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
 by mx.groups.io with SMTP id smtpd.web10.18643.1678712472872714506
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 13 Mar 2023 06:01:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=wL3M8HSp;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.51, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f51.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so4112666pjb.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 13 Mar 2023 06:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1678712472;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=C1wr4MNvTJ95SAJexUwROJAxAAiYUIEMwk/M2YmRZGQ=;
        b=wL3M8HSpOgFWPIiYiy8FEnBu8Bl96yvdU+kWyMIuHVAGdh786RwQjjpCVbPMSexWdv
         PwPNw/JSBfJgeC0+nhAGbj7MBtOjVidIJK4IfXouEHEryj430qTDTpElnd/qAW8AKQJb
         n3CLKZbjBcU0b3PpZQGZqoEpJWGA/2g9AbbauBwJegONtI/VgcotIJZpeHjpf0a+4g3c
         QeyPY553xDIRrP/BdY4UxYvUUF5FhDk5yKF4hOPfoDPi+OrklBoeaDLHehOepzr1i1NU
         Z5q6aiaJsXShWE9dFyTh/oi91rSyStv5OOofdh0xdzzJkHQS0eticZ0SCCMp56+gh8LF
         sj5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678712472;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C1wr4MNvTJ95SAJexUwROJAxAAiYUIEMwk/M2YmRZGQ=;
        b=w0stFFXOV28t6dUctMRxv0fQTsny69a1E82iRCrYHLo6XSJLkCAGEp7IYYjwDi005P
         iPYUg8zUFNWGg7yIjqmJ0wlf0ZPv5OMrtpQejZGk0iy9LgxYLeOryEMWy/hz5EY440G7
         hrDaEsJOC8jq/0vXhI8THKjHDN7GXxgTo95IjzAH96arWOoj6li3ERyK9Ilipns/AOma
         zVzPTZji23xJpQCci19BzAqAS1IOddhHg/Z+cGqgNlzctwPP6gc8GeCOSA2L5FLDxokU
         /Dad0O4HYwUtXeETIBvWMH6VSGa/hWerG1ZROwKeWxfrVXuJYIEUI6YJxfcF2U8IN+cB
         eKiQ==
X-Gm-Message-State: AO0yUKXT31GoydWg4K27igShHj70JziWl0R8/RjJ8N/MqazCZYZAa3a7
	BSCuKfzQDUWjzpAVWJomzIn9sW9osgxiYBU1BSa7VycU
X-Google-Smtp-Source: AK7set/E5qU7j3K1JoDOEXpD5HcKIkoqnc2aCR2v5sl1FnJ8bEpyhS88cb13c3hW6vnzjiVIO5qyow==
X-Received: by 2002:a17:90b:4b0c:b0:234:656d:235a with SMTP id lx12-20020a17090b4b0c00b00234656d235amr35075928pjb.43.1678712464460;
        Mon, 13 Mar 2023 06:01:04 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y4-20020a170902ed4400b0019a87ede846sm4692072plb.285.2023.03.13.06.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 06:01:03 -0700 (PDT)
Message-ID: <640f1e8f.170a0220.a7548.782b@mx.google.com>
Date: Mon, 13 Mar 2023 06:01:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.173-cip28
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip baseline-nfs: 39 runs,
 17 regressions (v5.10.173-cip28)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Mar 2023 13:01:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11004

cip/linux-5.10.y-cip baseline-nfs: 39 runs, 17 regressions (v5.10.173-cip28)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =

imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 5          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.173-cip28/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.173-cip28
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      2988848bfa1d1f2c02318f2193b06874fb5f62eb =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/640f168a4bad46b0e28c8643

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230303.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/640f168a4bad46b0e28c864c
        failing since 58 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-13T12:26:34.815896  [   17.733587] <LAVA_SIGNAL_ENDRUN 0_dmesg =
9584299_1.5.2.3.1>

    2023-03-13T12:26:34.819119  + set +x

    2023-03-13T12:26:34.920675  / ##

    2023-03-13T12:26:35.021568  export SHELL=3D/bin/sh

    2023-03-13T12:26:35.021767   #

    2023-03-13T12:26:35.122669  / # export SHELL=3D/bin/sh. /lava-9584299/e=
nvironment

    2023-03-13T12:26:35.122867  =


    2023-03-13T12:26:35.223843  / # . /lava-9584299/environment/lava-958429=
9/bin/lava-test-runner /lava-9584299/1

    2023-03-13T12:26:35.225071  =


    2023-03-13T12:26:35.230176  / # /lava-9584299/bin/lava-test-runner /lav=
a-9584299/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/640f169112909a44f88c862f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230303.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/640f169112909a44f88c8638
        failing since 58 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-13T12:26:48.933384  + [   14.279775] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 9584346_1.5.2.3.1>

    2023-03-13T12:26:48.936738  set +x

    2023-03-13T12:26:49.038103  /#

    2023-03-13T12:26:49.139324   # #export SHELL=3D/bin/sh

    2023-03-13T12:26:49.139530  =


    2023-03-13T12:26:49.240441  / # export SHELL=3D/bin/sh. /lava-9584346/e=
nvironment

    2023-03-13T12:26:49.240707  =


    2023-03-13T12:26:49.341767  / # . /lava-9584346/environment/lava-958434=
6/bin/lava-test-runner /lava-9584346/1

    2023-03-13T12:26:49.342126  =


    2023-03-13T12:26:49.347114  / # /lava-9584346/bin/lava-test-runner /lav=
a-9584346/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/640f168dfba2f87b238c8630

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230303.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/640f168dfba2f87b238c8639
        failing since 58 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-13T12:26:39.063235  + set +x

    2023-03-13T12:26:39.069251  <8>[   19.835421] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9584325_1.5.2.3.1>

    2023-03-13T12:26:39.176700  #

    2023-03-13T12:26:39.176928  =


    2023-03-13T12:26:39.277993  / # #export SHELL=3D/bin/sh

    2023-03-13T12:26:39.278195  =


    2023-03-13T12:26:39.379112  / # export SHELL=3D/bin/sh. /lava-9584325/e=
nvironment

    2023-03-13T12:26:39.379310  =


    2023-03-13T12:26:39.480242  / # . /lava-9584325/environment/lava-958432=
5/bin/lava-test-runner /lava-9584325/1

    2023-03-13T12:26:39.480493  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/640f16226af02b04888c863a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-nfs-at91sam9g20ek=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-nfs-at91sam9g20ek=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230303.0/armel/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/640f16226af02b04888c8643
        failing since 58 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-13T12:24:52.011557  + set +x
    2023-03-13T12:24:52.133138  #
    2023-03-13T12:24:52.236398  / # #export SHELL=3D/bin/sh
    2023-03-13T12:24:52.237261  =

    2023-03-13T12:24:52.339209  / # export SHELL=3D/bin/sh. /lava-151453/en=
vironment
    2023-03-13T12:24:52.340063  =

    2023-03-13T12:24:52.441918  / # . /lava-151453/environment/lava-151453/=
bin/lava-test-runner /lava-151453/1
    2023-03-13T12:24:52.442691  =

    2023-03-13T12:24:52.449349  / # /lava-151453/bin/lava-test-runner /lava=
-151453/1
    2023-03-13T12:24:52.832734  + export TESTRUN_ID=3D1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/640f15b9461ada9c3f8c8631

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-bl=
ack.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-bl=
ack.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230303.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/640f15b9461ada9c3f8c863a
        failing since 58 days (last pass: v5.10.158-cip22, first fail: v5.1=
0.162-cip24)

    2023-03-13T12:23:03.762385  + set +x
    2023-03-13T12:23:03.765519  [   53.242020] <LAVA_SIGNAL_ENDRUN 0_dmesg =
151468_1.6.2.4.1>
    2023-03-13T12:23:03.882144  #
    2023-03-13T12:23:03.985022  / # #export SHELL=3D/bin/sh
    2023-03-13T12:23:03.985782  =

    2023-03-13T12:23:04.087715  / # export SHELL=3D/bin/sh. /lava-151468/en=
vironment
    2023-03-13T12:23:04.088397  =

    2023-03-13T12:23:04.190651  / # . /lava-151468/environment/lava-151468/=
bin/lava-test-runner /lava-151468/1
    2023-03-13T12:23:04.191840  =

    2023-03-13T12:23:04.196098  / # /lava-151468/bin/lava-test-runner /lava=
-151468/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/640f1a8cfd436891f88c863e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebone-black.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebone-black.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230303.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/640f1a8cfd436891f88c8645
        failing since 58 days (last pass: v5.10.158-cip22, first fail: v5.1=
0.162-cip24)

    2023-03-13T12:43:35.999173  + set +x
    2023-03-13T12:43:36.002523  <8>[   55.106153] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 874205_1.6.2.4.1>
    2023-03-13T12:43:36.174589  / # #
    2023-03-13T12:43:36.276915  export SHELL=3D/bin/sh
    2023-03-13T12:43:36.277235  #
    2023-03-13T12:43:36.378407  / # export SHELL=3D/bin/sh. /lava-874205/en=
vironment
    2023-03-13T12:43:36.378774  =

    2023-03-13T12:43:36.480113  / # . /lava-874205/environment/lava-874205/=
bin/lava-test-runner /lava-874205/1
    2023-03-13T12:43:36.480948  =

    2023-03-13T12:43:36.486805  / # /lava-874205/bin/lava-test-runner /lava=
-874205/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/640f13394dd0c7f9f88c8646

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-b=
lack.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-b=
lack.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230303.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/640f13394dd0c7f9f88c864f
        failing since 40 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.165-cip25)

    2023-03-13T12:12:19.028520  <8>[   43.750864] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 151420_1.6.2.4.1>
    2023-03-13T12:12:19.147110  / # #
    2023-03-13T12:12:19.250055  export SHELL=3D/bin/sh
    2023-03-13T12:12:19.250778  #
    2023-03-13T12:12:19.352661  / # export SHELL=3D/bin/sh. /lava-151420/en=
vironment
    2023-03-13T12:12:19.353384  =

    2023-03-13T12:12:19.455431  / # . /lava-151420/environment/lava-151420/=
bin/lava-test-runner /lava-151420/1
    2023-03-13T12:12:19.456550  =

    2023-03-13T12:12:19.461001  / # /lava-151420/bin/lava-test-runner /lava=
-151420/1
    2023-03-13T12:12:19.724187  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/640f15bef53955e5968c8659

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebone-black=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebone-black=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230303.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/640f15bef53955e5968c8660
        failing since 40 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.165-cip25)

    2023-03-13T12:23:04.830166  + set +x
    2023-03-13T12:23:04.832136  <8>[   39.395386] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 874174_1.6.2.4.1>
    2023-03-13T12:23:04.947816  #
    2023-03-13T12:23:05.049885  / # #export SHELL=3D/bin/sh
    2023-03-13T12:23:05.050325  =

    2023-03-13T12:23:05.151405  / # export SHELL=3D/bin/sh. /lava-874174/en=
vironment
    2023-03-13T12:23:05.151791  =

    2023-03-13T12:23:05.252865  / # . /lava-874174/environment/lava-874174/=
bin/lava-test-runner /lava-874174/1
    2023-03-13T12:23:05.253430  =

    2023-03-13T12:23:05.256183  / # /lava-874174/bin/lava-test-runner /lava=
-874174/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/640f154ae528718c128c862f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-nfs-imx6q-sabre=
lite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-nfs-imx6q-sabre=
lite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230303.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/640f154ae528718c128c8638
        failing since 58 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-13T12:21:17.339971  + set<8>[   31.992807] <LAVA_SIGNAL_ENDRUN =
0_dmesg 9584111_1.6.2.4.1>

    2023-03-13T12:21:17.340392   +x

    2023-03-13T12:21:17.450675  / # #

    2023-03-13T12:21:17.554146  export SHELL=3D/bin/sh

    2023-03-13T12:21:17.554994  #

    2023-03-13T12:21:17.657102  / # export SHELL=3D/bin/sh. /lava-9584111/e=
nvironment

    2023-03-13T12:21:17.657946  =


    2023-03-13T12:21:17.760034  / # . /lava-9584111/environment/lava-958411=
1/bin/lava-test-runner /lava-9584111/1

    2023-03-13T12:21:17.761334  =


    2023-03-13T12:21:17.762951  / # /lava-9584111/bin/lava-test-runner /lav=
a-9584111/1
 =

    ... (16 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/640f17eac502a876848c865f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-meson-gxl-s905x-libr=
etech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-meson-gxl-s905x-libr=
etech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230303.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/640f17eac502a8768=
48c8660
        new failure (last pass: v5.10.168-cip27) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/640f1966d7d4790f348c863a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-nfs-mes=
on-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-nfs-mes=
on-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230303.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/640f1966d7d4790f3=
48c863b
        new failure (last pass: v5.10.168-cip27) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/640f19c42d454e9bc88c868f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/arm64/defconfig+kselftest/gcc-10/lab-broonie/baseline-nfs-meson-gxl-=
s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/arm64/defconfig+kselftest/gcc-10/lab-broonie/baseline-nfs-meson-gxl-=
s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230303.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/640f19c42d454e9bc=
88c8690
        new failure (last pass: v5.10.168-cip27) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 5          =


  Details:     https://kernelci.org/test/plan/id/640f18498a0d4556e38c86a5

  Results:     86 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-r=
k3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-r=
k3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230303.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/640f18498a0d4556e38c86cb
        failing since 349 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81,=
 first fail: v5.10.106-cip4)

    2023-03-13T12:33:58.581413  [   33.983147] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-i2s0-probed RESULT=3Dpass>

    2023-03-13T12:33:59.636397  /lava-9584492/1/../bin/lava-test-case

    2023-03-13T12:33:59.664573  [   35.066361] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-rt5514-present: https://ker=
nelci.org/test/case/id/640f18498a0d4556e38c86e0
        failing since 58 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-13T12:33:57.289056  [   32.688592] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk3399-gru-sound-driver-max98357A-present RESULT=3Dfail>

    2023-03-13T12:33:57.313185  seq: invalid floating point argument: =E2=
=80=98sound/RT5514=E2=80=99

    2023-03-13T12:33:57.316476  Try 'seq --help' for more information.

    2023-03-13T12:33:57.320563  /lava-9584492/1/../bin/lava-test-case

    2023-03-13T12:33:57.344854  [   32.744264] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk3399-gru-sound-driver-rt5514-present RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-max98357A-present: https://=
kernelci.org/test/case/id/640f18498a0d4556e38c86e1
        failing since 58 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-13T12:33:57.259923  seq: invalid floating point argument: =E2=
=80=98sound/MAX98357A=E2=80=99

    2023-03-13T12:33:57.264039  Try 'seq --help' for more information.

    2023-03-13T12:33:57.268365  /lava-9584492/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-dp-present: https://kernelc=
i.org/test/case/id/640f18498a0d4556e38c86e2
        failing since 58 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-13T12:33:57.181936  [   32.581082] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk3399-gru-sound-driver-da7219-present RESULT=3Dfail>

    2023-03-13T12:33:57.204406  seq: invalid floating point argument: =E2=
=80=98sound/DP=E2=80=99

    2023-03-13T12:33:57.207877  Try 'seq --help' for more information.

    2023-03-13T12:33:57.211750  /lava-9584492/1/../bin/lava-test-case

    2023-03-13T12:33:57.234764  [   32.635001] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk3399-gru-sound-driver-dp-present RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-da7219-present: https://ker=
nelci.org/test/case/id/640f18498a0d4556e38c86e3
        failing since 58 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-13T12:33:57.153928  seq: invalid floating point argument: =E2=
=80=98sound/DA7219=E2=80=99

    2023-03-13T12:33:57.158769  Try 'seq --help' for more information.

    2023-03-13T12:33:57.161824  /lava-9584492/1/../bin/lava-test-case
   =

 =20

