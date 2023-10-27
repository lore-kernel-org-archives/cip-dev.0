Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AD9C25B48
	for <webhook@archiver.kernel.org>; Fri, 27 Oct 2023 13:08:36 +0000 (UTC)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
 by mx.groups.io with SMTP id smtpd.web10.6472.1698412112281867771
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 27 Oct 2023 06:08:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=m+Jfc3BR;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.173, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-565e54cb93aso1633273a12.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 27 Oct 2023 06:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698412111; x=1699016911; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=r4mhFD+8hqux6FXR3mdiRSU6xrdqmfufezrVzEmVv18=;
        b=m+Jfc3BRQy0w2/kSCdiHC5dsakf2pG70D7N5PVOdxysU3uW3ALoeUiDA6+kuEsVxHf
         TV05V3zv9J1LgCLOzd9Jx5Dz2qgGJUCie57XOcHGZpi1qJq16TFFxLVvqwjD+U7FkcGF
         Z9l3mP6rbLUp3dDca1MXQyKiWpIBzZ7v3btWjdWMGD0EL6ZAuTYyeEHxxLw0aSkgmK9z
         ozBP/RWWoM7FgT0LY1sNXg6q7AJPIzON0tr31eFI9oNGDTfMYUqNfzSRg08tEnyuatRt
         O7D31IAYsaHome8vvE0y5XCfLKiYdikhkomigtad98MT8mRT5tDBP0FiakRs4U0Qu2l5
         RJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698412111; x=1699016911;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r4mhFD+8hqux6FXR3mdiRSU6xrdqmfufezrVzEmVv18=;
        b=YD9aa8pUDGFVg179JguO9SA84wusByeEayluZ1+IrB3BV5rUraWNPW5Glknk067+0T
         nLBRUjG+4nfzciIXZPa/ow/PaYoX6TGhhRMZ6aZzMnfBRiZaz6ZdU4KAAJ+T4CXiJr40
         a4zN6e6e8Znp8Url9SK8oObeazoETF9SLetdCcQSzOVVzf2q9NZ0BJYZ9JjnKOdJoCIl
         +k7TQiyfGl4KvA9Piyfeb2uPZ3WOGlmc0t3U6J5tIuR8koIE+tP7njf85wwFvRBMDA0i
         DNhP2VW3LBOkYLuF9jhv0VvRUtMyKe2z5k5huJs4m6A92YXxS1mrfvgO0rvajQQJrsU4
         5XIA==
X-Gm-Message-State: AOJu0YwIv7w/BFP9cG9cBrKs+J9rrjrvApeBuc9e+2/rtGgMCSJCigmK
	WrkixYStXxIKQa+mioiQnIMUBNJ30vRRN2xc7c0=
X-Google-Smtp-Source: AGHT+IGRPowctmHWGCbXRYJvxZxB4jt3we32HcjFqpG9rafX8XUfqQOUKirMeP2QvJ7LLjtxSrXK3w==
X-Received: by 2002:a17:90b:947:b0:27e:3ae3:eae0 with SMTP id dw7-20020a17090b094700b0027e3ae3eae0mr2469757pjb.16.1698412110935;
        Fri, 27 Oct 2023 06:08:30 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id o4-20020a17090ab88400b0027df6ff00eesm1213730pjr.19.2023.10.27.06.08.29
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 06:08:29 -0700 (PDT)
Message-ID: <653bb64d.170a0220.13fa.32da@mx.google.com>
Date: Fri, 27 Oct 2023 06:08:29 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.58-cip7-132-gb38ea1474c159
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test baseline: 106 runs,
 7 regressions (v6.1.58-cip7-132-gb38ea1474c159)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 27 Oct 2023 13:08:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13477

cip-gitlab/ci/pavel/linux-test baseline: 106 runs, 7 regressions (v6.1.58-c=
ip7-132-gb38ea1474c159)

Regressions Summary
-------------------

platform            | arch   | lab           | compiler | defconfig        =
          | regressions
--------------------+--------+---------------+----------+------------------=
----------+------------
asus-cx9400-volteer | x86_64 | lab-collabora | gcc-10   | x86_64_defconfig+=
x86-board | 1          =

imx6dl-udoo         | arm    | lab-broonie   | gcc-10   | imx_v6_v7_defconf=
ig        | 1          =

imx6q-udoo          | arm    | lab-broonie   | gcc-10   | imx_v6_v7_defconf=
ig        | 1          =

imx6ul-14x14-evk    | arm    | lab-nxp       | gcc-10   | imx_v6_v7_defconf=
ig        | 1          =

imx8mp-evk          | arm64  | lab-broonie   | gcc-10   | defconfig        =
          | 1          =

juno-uboot          | arm64  | lab-broonie   | gcc-10   | defconfig        =
          | 1          =

odroid-xu3          | arm    | lab-collabora | gcc-10   | exynos_defconfig =
          | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.58-cip7-132-gb38ea1474c159/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.58-cip7-132-gb38ea1474c159
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b38ea1474c1591eafe6d4659c33713917887c7a2 =



Test Regressions
---------------- =



platform            | arch   | lab           | compiler | defconfig        =
          | regressions
--------------------+--------+---------------+----------+------------------=
----------+------------
asus-cx9400-volteer | x86_64 | lab-collabora | gcc-10   | x86_64_defconfig+=
x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/653bab91af5c750b28efcf22

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.58-cip7-132-gb38ea1474c159/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.58-cip7-132-gb38ea1474c159/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/653bab91af5c750b28efcf2b
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-27T12:22:15.839000  <8>[    8.387708] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11893231_1.4.2.3.1>

    2023-10-27T12:22:15.842425  + set +x

    2023-10-27T12:22:15.948402  #

    2023-10-27T12:22:15.949576  =


    2023-10-27T12:22:16.051388  / # #export SHELL=3D/bin/sh

    2023-10-27T12:22:16.052233  =


    2023-10-27T12:22:16.153760  / # export SHELL=3D/bin/sh. /lava-11893231/=
environment

    2023-10-27T12:22:16.154555  =


    2023-10-27T12:22:16.256051  / # . /lava-11893231/environment/lava-11893=
231/bin/lava-test-runner /lava-11893231/1

    2023-10-27T12:22:16.257226  =

 =

    ... (13 line(s) more)  =

 =



platform            | arch   | lab           | compiler | defconfig        =
          | regressions
--------------------+--------+---------------+----------+------------------=
----------+------------
imx6dl-udoo         | arm    | lab-broonie   | gcc-10   | imx_v6_v7_defconf=
ig        | 1          =


  Details:     https://kernelci.org/test/plan/id/653ba52fddfb230c2eefcef5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.58-cip7-132-gb38ea1474c159/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie=
/baseline-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.58-cip7-132-gb38ea1474c159/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie=
/baseline-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/653ba52fddfb230c2eefc=
ef6
        new failure (last pass: v4.4-st20-3596-g73e7f2b880d98) =

 =



platform            | arch   | lab           | compiler | defconfig        =
          | regressions
--------------------+--------+---------------+----------+------------------=
----------+------------
imx6q-udoo          | arm    | lab-broonie   | gcc-10   | imx_v6_v7_defconf=
ig        | 1          =


  Details:     https://kernelci.org/test/plan/id/653ba52e91cdc7f2f9efcf89

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.58-cip7-132-gb38ea1474c159/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie=
/baseline-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.58-cip7-132-gb38ea1474c159/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie=
/baseline-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/653ba52e91cdc7f2f9efc=
f8a
        new failure (last pass: v4.4-st20-3596-g73e7f2b880d98) =

 =



platform            | arch   | lab           | compiler | defconfig        =
          | regressions
--------------------+--------+---------------+----------+------------------=
----------+------------
imx6ul-14x14-evk    | arm    | lab-nxp       | gcc-10   | imx_v6_v7_defconf=
ig        | 1          =


  Details:     https://kernelci.org/test/plan/id/653ba557ddfb230c2eefcefc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.58-cip7-132-gb38ea1474c159/arm/imx_v6_v7_defconfig/gcc-10/lab-nxp/bas=
eline-imx6ul-14x14-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.58-cip7-132-gb38ea1474c159/arm/imx_v6_v7_defconfig/gcc-10/lab-nxp/bas=
eline-imx6ul-14x14-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/653ba557ddfb230c2eefc=
efd
        new failure (last pass: v4.4-st20-3596-g73e7f2b880d98) =

 =



platform            | arch   | lab           | compiler | defconfig        =
          | regressions
--------------------+--------+---------------+----------+------------------=
----------+------------
imx8mp-evk          | arm64  | lab-broonie   | gcc-10   | defconfig        =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/653ba669e2adc6ab60efcf67

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.58-cip7-132-gb38ea1474c159/arm64/defconfig/gcc-10/lab-broonie/baselin=
e-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.58-cip7-132-gb38ea1474c159/arm64/defconfig/gcc-10/lab-broonie/baselin=
e-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/653ba669e2adc6ab60efcf70
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-27T12:00:12.025404  <8>[   20.658564] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-10-27T12:00:12.028673  + set<8>[   20.667940] <LAVA_SIGNAL_ENDRUN =
0_dmesg 203361_1.5.2.4.1>
    2023-10-27T12:00:12.029338   +x
    2023-10-27T12:00:12.137926  / # #
    2023-10-27T12:00:13.303932  export SHELL=3D/bin/sh
    2023-10-27T12:00:13.310068  #
    2023-10-27T12:00:14.809331  / # export SHELL=3D/bin/sh. /lava-203361/en=
vironment
    2023-10-27T12:00:14.815473  =

    2023-10-27T12:00:17.538958  / # . /lava-203361/environment/lava-203361/=
bin/lava-test-runner /lava-203361/1
    2023-10-27T12:00:17.545692   =

    ... (19 line(s) more)  =

 =



platform            | arch   | lab           | compiler | defconfig        =
          | regressions
--------------------+--------+---------------+----------+------------------=
----------+------------
juno-uboot          | arm64  | lab-broonie   | gcc-10   | defconfig        =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/653ba7358eb730074defcf01

  Results:     60 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.58-cip7-132-gb38ea1474c159/arm64/defconfig/gcc-10/lab-broonie/baselin=
e-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.58-cip7-132-gb38ea1474c159/arm64/defconfig/gcc-10/lab-broonie/baselin=
e-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/653ba7358eb730074defcf41
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-27T12:03:56.305919  / # #
    2023-10-27T12:03:56.408750  export SHELL=3D/bin/sh
    2023-10-27T12:03:56.409515  #
    2023-10-27T12:03:56.511407  / # export SHELL=3D/bin/sh. /lava-203375/en=
vironment
    2023-10-27T12:03:56.512164  =

    2023-10-27T12:03:56.614143  / # . /lava-203375/environment/lava-203375/=
bin/lava-test-runner /lava-203375/1
    2023-10-27T12:03:56.615476  =

    2023-10-27T12:03:56.630242  / # /lava-203375/bin/lava-test-runner /lava=
-203375/1
    2023-10-27T12:03:56.696161  + export 'TESTRUN_ID=3D1_bootrr'
    2023-10-27T12:03:56.696691  + cd /lava-203375/1/tests/1_bootrr =

    ... (40 line(s) more)  =

 =



platform            | arch   | lab           | compiler | defconfig        =
          | regressions
--------------------+--------+---------------+----------+------------------=
----------+------------
odroid-xu3          | arm    | lab-collabora | gcc-10   | exynos_defconfig =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/653ba87e116d67e272efcfe7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: exynos_defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.58-cip7-132-gb38ea1474c159/arm/exynos_defconfig/gcc-10/lab-collabora/=
baseline-odroid-xu3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.58-cip7-132-gb38ea1474c159/arm/exynos_defconfig/gcc-10/lab-collabora/=
baseline-odroid-xu3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/653ba87e116d67e272efc=
fe8
        new failure (last pass: v4.4-st20-3596-g73e7f2b880d98) =

 =20

