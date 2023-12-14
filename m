Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8DBC4167D
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 13:20:48 +0000 (UTC)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
 by mx.groups.io with SMTP id smtpd.web11.21738.1702560038234626451
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 14 Dec 2023 05:20:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=Wv/wMMdq;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.177, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5c229dabbb6so4396626a12.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 14 Dec 2023 05:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702560037; x=1703164837; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cz17vXYAjSS1ZCpc13fA48esPcJBsH47aR+4hvF4swA=;
        b=Wv/wMMdqlmuR9FSuGLMnd47CQfwJNnCiPN5I+bb/C3PhCjydyIjytvRuvRcSZYR1fj
         EiXPni9sQM+YGG32VlR2sGdz5a508iS3w4Wa+PP19MkG7Z0G/hsRrfmz8CTHuBtfDhK3
         Zj7eme151Z8CM/4zLuFM4Sz6C1z0uS1bjZy1xadClAbOj3+n5qKfeI4qQ1ROZ4U9oasC
         zGAyCaiMV+sRVFDbBbgW52OTOeIpyChc/xVED3foPn/pLRSr79KUJgzrUdXne7POCvrv
         1lqcGu3/oo+vpJrOAa1p1z8G9kH4f75mJjnDyopw8BMMhJY2FLrAAzZSeEMBSaeGkWdS
         wveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702560037; x=1703164837;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cz17vXYAjSS1ZCpc13fA48esPcJBsH47aR+4hvF4swA=;
        b=aeYLRrPXb8kVHHeOupSYXQFyYsov6bhqNrgW8jFmMiOKkUfLABYWs4D0vIcnm0k10c
         CWAYN+A52XOdEOGmEEaByFFFv2sQqHT9lXiS9vhSAfrEVyeS42m5lDEAsPtIx8ATi8wJ
         PE2wBu51yEdm4Wl+/Oyk/p1IH++qOUxal/SILros6eo4roIEW630vTFB0grK/ZyEykAp
         jkbqM4m7lx0Q+CQgg4Ghkznh9FWsPbi0w+WZD1rZIF+MMnVX15bJAMc+12gBxkPkOTNM
         qAxC5bgFAMP00mj8vmr74fNGN14/q9kJ+1PZV2Uy64AVoWfus6QQ3jU/blAM8SgrMVxZ
         kyPw==
X-Gm-Message-State: AOJu0YzGJO7S4AsM66Re2p9zPXuGLlPFEgKAXAJ1GquOhoYxZD2QPQOJ
	u2Lto8cFh4/4E/yw/enKVoglaDYoPWeqCsX53Z5OWw==
X-Google-Smtp-Source: AGHT+IHZfM78ESEnRxjjE5tiQBaGXYuVvWcaJzgQOiStwr616m4u3XokasYOhlroRC2kuh4FBI5bUA==
X-Received: by 2002:a05:6a21:a59d:b0:190:85d9:9d40 with SMTP id gd29-20020a056a21a59d00b0019085d99d40mr6455077pzc.106.1702560036524;
        Thu, 14 Dec 2023 05:20:36 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id o10-20020a17090ac08a00b0028ae9a419f0sm3149826pjs.44.2023.12.14.05.20.35
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 05:20:36 -0800 (PST)
Message-ID: <657b0124.170a0220.939a2.8d77@mx.google.com>
Date: Thu, 14 Dec 2023 05:20:36 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-69-g8f7b450fc28ed
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 75 runs,
 8 regressions (v5.10.201-cip41-69-g8f7b450fc28ed)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Dec 2023 13:20:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14099

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 75 runs, 8 regress=
ions (v5.10.201-cip41-69-g8f7b450fc28ed)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
at91sam9g20ek                | arm   | lab-broonie   | gcc-10   | multi_v5_=
defconfig  | 1          =

juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest | 1          =

juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
           | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
+kselftest | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
           | 1          =

rk3399-rock-pi-4b            | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest | 1          =

rk3399-rock-pi-4b            | arm64 | lab-collabora | gcc-10   | defconfig=
           | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.201-cip41-69-g8f7b450fc28ed/plan/baseline=
-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.201-cip41-69-g8f7b450fc28ed
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      8f7b450fc28ed99196853536c98ae36c2567e160 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
at91sam9g20ek                | arm   | lab-broonie   | gcc-10   | multi_v5_=
defconfig  | 1          =


  Details:     https://kernelci.org/test/plan/id/657af55443a1667b75e13483

  Results:     47 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-69-g8f7b450fc28ed/arm/multi_v5_defconfig/gcc-1=
0/lab-broonie/baseline-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-69-g8f7b450fc28ed/arm/multi_v5_defconfig/gcc-1=
0/lab-broonie/baseline-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armel/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/657af55443a1667b75e134b9
        failing since 0 day (last pass: v5.10.201-cip41-197-g2d08925b44e52,=
 first fail: v5.10.201-cip41-473-gc43d7b7bbe83a)

    2023-12-14T12:29:37.883993  + set +x
    2023-12-14T12:29:37.884319  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 353465_1.6.2=
.4.1>
    2023-12-14T12:29:38.012812  #
    2023-12-14T12:29:38.116154  / # #export SHELL=3D/bin/sh
    2023-12-14T12:29:38.116983  =

    2023-12-14T12:29:38.219048  / # export SHELL=3D/bin/sh. /lava-353465/en=
vironment
    2023-12-14T12:29:38.219849  =

    2023-12-14T12:29:38.322131  / # . /lava-353465/environment/lava-353465/=
bin/lava-test-runner /lava-353465/1
    2023-12-14T12:29:38.323592  =

    2023-12-14T12:29:38.327363  / # /lava-353465/bin/lava-test-runner /lava=
-353465/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/657af464860a7cbaf5e134bc

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-69-g8f7b450fc28ed/arm64/defconfig+kselftest/gc=
c-10/lab-broonie/baseline-nfs-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-69-g8f7b450fc28ed/arm64/defconfig+kselftest/gc=
c-10/lab-broonie/baseline-nfs-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/657af464860a7cbaf5e134fc
        new failure (last pass: v5.10.201-cip41-473-gc43d7b7bbe83a)

    2023-12-14T12:25:30.150695  <8>[   53.747189] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 353416_1.6.2.4.1>
    2023-12-14T12:25:30.269504  / # #
    2023-12-14T12:25:30.372127  export SHELL=3D/bin/sh
    2023-12-14T12:25:30.372942  #
    2023-12-14T12:25:30.474861  / # export SHELL=3D/bin/sh. /lava-353416/en=
vironment
    2023-12-14T12:25:30.475632  =

    2023-12-14T12:25:30.577654  / # . /lava-353416/environment/lava-353416/=
bin/lava-test-runner /lava-353416/1
    2023-12-14T12:25:30.579042  =

    2023-12-14T12:25:30.598371  / # /lava-353416/bin/lava-test-runner /lava=
-353416/1
    2023-12-14T12:25:30.949967  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
           | 1          =


  Details:     https://kernelci.org/test/plan/id/657afb45e726f5a851e13475

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-69-g8f7b450fc28ed/arm64/defconfig/gcc-10/lab-b=
roonie/baseline-nfs-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-69-g8f7b450fc28ed/arm64/defconfig/gcc-10/lab-b=
roonie/baseline-nfs-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/657afb45e726f5a851e134b4
        failing since 41 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.194-cip39-915-g96fa7f16cf02)

    2023-12-14T12:55:10.389842  / # #
    2023-12-14T12:55:10.492491  export SHELL=3D/bin/sh
    2023-12-14T12:55:10.493269  #
    2023-12-14T12:55:10.595163  / # export SHELL=3D/bin/sh. /lava-353520/en=
vironment
    2023-12-14T12:55:10.596008  =

    2023-12-14T12:55:10.698146  / # . /lava-353520/environment/lava-353520/=
bin/lava-test-runner /lava-353520/1
    2023-12-14T12:55:10.699505  =

    2023-12-14T12:55:10.718745  / # /lava-353520/bin/lava-test-runner /lava=
-353520/1
    2023-12-14T12:55:10.891420  + export TESTRUN_ID=3D1_bootrr
    2023-12-14T12:55:10.892036  + cd /lava-353520/1/tests/1_bootrr =

    ... (9 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/657af43cc1388af49de1349f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-69-g8f7b450fc28ed/arm64/defconfig+kselftest/gc=
c-10/lab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-69-g8f7b450fc28ed/arm64/defconfig+kselftest/gc=
c-10/lab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/657af43cc1388af49=
de134a0
        failing since 0 day (last pass: v5.10.201-cip41-197-g2d08925b44e52,=
 first fail: v5.10.201-cip41-473-gc43d7b7bbe83a) =

 =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/657af37f899313b3b9e1347d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-69-g8f7b450fc28ed/arm64/defconfig+kselftest/gc=
c-10/lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-69-g8f7b450fc28ed/arm64/defconfig+kselftest/gc=
c-10/lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/657af37f899313b3b=
9e1347e
        failing since 0 day (last pass: v5.10.201-cip41-197-g2d08925b44e52,=
 first fail: v5.10.201-cip41-473-gc43d7b7bbe83a) =

 =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
           | 1          =


  Details:     https://kernelci.org/test/plan/id/657afb644eec12a79be13481

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-69-g8f7b450fc28ed/arm64/defconfig/gcc-10/lab-c=
ip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-69-g8f7b450fc28ed/arm64/defconfig/gcc-10/lab-c=
ip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/657afb644eec12a79=
be13482
        failing since 139 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.186-cip37-526-g7640d76efb649) =

 =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
rk3399-rock-pi-4b            | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/657af2bf0c91d498c3e1348b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-69-g8f7b450fc28ed/arm64/defconfig+kselftest/gc=
c-10/lab-collabora/baseline-nfs-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-69-g8f7b450fc28ed/arm64/defconfig+kselftest/gc=
c-10/lab-collabora/baseline-nfs-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/657af2bf0c91d498c3e13494
        failing since 41 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.194-cip39-915-g96fa7f16cf02)

    2023-12-14T12:18:45.002024  + set +x

    2023-12-14T12:18:45.002509  <8>[   51.474397] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12269371_1.6.2.4.1>

    2023-12-14T12:18:45.108083  #

    2023-12-14T12:18:46.369359  / # #export SHELL=3D/bin/sh

    2023-12-14T12:18:46.380273  =


    2023-12-14T12:18:46.380724  / # export SHELL=3D/bin/sh

    2023-12-14T12:18:48.123610  . /lava-12269371/environment

    2023-12-14T12:18:48.134594  / # . /lava-12269371/environment

    2023-12-14T12:18:51.320643  /lava-12269371/bin/lava-test-runner /lava-1=
2269371/1

    2023-12-14T12:18:51.331019  / # /lava-12269371/bin/lava-test-runner /la=
va-12269371/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
rk3399-rock-pi-4b            | arm64 | lab-collabora | gcc-10   | defconfig=
           | 1          =


  Details:     https://kernelci.org/test/plan/id/657af9db28070f4973e13496

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-69-g8f7b450fc28ed/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-nfs-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-69-g8f7b450fc28ed/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-nfs-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/657af9db28070f4973e1349f
        failing since 41 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.194-cip39-915-g96fa7f16cf02)

    2023-12-14T12:49:19.185913  / # #

    2023-12-14T12:49:20.443231  export SHELL=3D/bin/sh

    2023-12-14T12:49:20.453562  #

    2023-12-14T12:49:20.453726  / # export SHELL=3D/bin/sh

    2023-12-14T12:49:22.195655  / # . /lava-12269987/environment

    2023-12-14T12:49:25.399760  /lava-12269987/bin/lava-test-runner /lava-1=
2269987/1

    2023-12-14T12:49:25.411247  . /lava-12269987/environment

    2023-12-14T12:49:25.411598  / # /lava-12269987/bin/lava-test-runner /la=
va-12269987/1

    2023-12-14T12:49:25.573494  + export TESTRUN_ID=3D1_bootrr

    2023-12-14T12:49:25.573908  + cd /lava-12269987/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =20

