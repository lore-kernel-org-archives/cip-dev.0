Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4C0EE49A3
	for <webhook@archiver.kernel.org>; Tue, 22 Aug 2023 16:24:35 +0000 (UTC)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
 by mx.groups.io with SMTP id smtpd.web11.530.1692721466854739822
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 22 Aug 2023 09:24:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=JT/HKVXp;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.173, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-68a3de5f231so1747847b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 22 Aug 2023 09:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692721466; x=1693326266;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oW9bLt2Lq39QntMHOg9PF5HQkLU1jKABUTVKnKys/Z4=;
        b=JT/HKVXpfjsMblT4QyVfuf9GY6p6kk5k3hxpfQiqr+n4SKUQI5U0xcQSjplkNc5T3d
         XcfbUIr+Wv+xlGQ85TT7K5eKMedbqCjgDdMoY4EL49wG8L7GFq4eMgCC4J7yDvbnUBHv
         l138DRYNDjbUkEBKDp9KRY6YGRq15uqLO/DMGe3Zv19mIgST3h4m6otWYx8hMcAK/jdd
         n8QmuB3iPSm4yV2PhaNT3ppjfNCt97y1unOX++uQZhT5CFI/cO3bStDeEC281WW0HwXv
         3825EymxkAa0HVbkTm3U3czX7ICOHpV+hQ0t/pMbGmPYpUy/rxtpzRs00zAqyIKYPEbo
         2H1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692721466; x=1693326266;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oW9bLt2Lq39QntMHOg9PF5HQkLU1jKABUTVKnKys/Z4=;
        b=LCvx+SK9fy9+hL40AUjz1C7YCnfMRVlobQrbIblLc8wNl0C3y7bySql/lHqrH2Dk4Q
         OAh/BvMpYAmQ6+vCAgDGi26hiFohB3/bK02Jbv0sDGm1Cm614w272aTMxMT5n6+KUmaD
         S/WSogf5wVK8U181zhKvGx9UUelU3ApZmea0WnNg1OJYKH4OTprrCu/YmtLKPpuvOBx3
         p2Ubv52Ju76x5YKNo4ywQY44pY5UOhshLnkGcOSahppam0efecvuXycizoVJv2vvxXt+
         GaSQ1Rwc4XSrIeONg1L7atlLYqb1kl23pLBsHAzfZDdoCePReYOOP6FsR6wgP0rSZrZ4
         x29g==
X-Gm-Message-State: AOJu0YzmbRxxIZnEIv2dM5MhrF2a1ft2gDsHMx1JhMcZZckRE2KKXKas
	uti7bGRN0QQYqUy/F+R4JD/fC4I0anHJE6uae7M=
X-Google-Smtp-Source: AGHT+IG9F+8jPBnDkUBqPUV/uayeCCYmOkNPGq3a0AAmcFEKg0Ciu5gKZ7zeXyv1LPsxjnpGrLhwVA==
X-Received: by 2002:a05:6a21:66c4:b0:149:3555:5fcc with SMTP id ze4-20020a056a2166c400b0014935555fccmr4994121pzb.61.1692721465050;
        Tue, 22 Aug 2023 09:24:25 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 10-20020aa7914a000000b00689f1ce7dacsm3966589pfi.23.2023.08.22.09.24.24
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 09:24:24 -0700 (PDT)
Message-ID: <64e4e138.a70a0220.8046d.7deb@mx.google.com>
Date: Tue, 22 Aug 2023 09:24:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.45-cip3-31-gbae6b8e9a2cff
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
Subject: cip-gitlab/ci/pavel/linux-test baseline: 130 runs,
 20 regressions (v6.1.45-cip3-31-gbae6b8e9a2cff)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Aug 2023 16:24:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12828

cip-gitlab/ci/pavel/linux-test baseline: 130 runs, 20 regressions (v6.1.45-=
cip3-31-gbae6b8e9a2cff)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
acer-chromebox-cxi4-puff | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =

bcm2836-rpi-2-b          | arm    | lab-collabora | gcc-10   | bcm2835_defc=
onfig            | 1          =

bcm2836-rpi-2-b          | arm    | lab-collabora | gcc-10   | multi_v7_def=
config           | 1          =

fsl-ls1088a-rdb          | arm64  | lab-nxp       | gcc-10   | defconfig   =
                 | 1          =

fsl-ls2088a-rdb          | arm64  | lab-nxp       | gcc-10   | defconfig   =
                 | 1          =

fsl-lx2160a-rdb          | arm64  | lab-nxp       | gcc-10   | defconfig   =
                 | 1          =

hp-x360-14-G1-sona       | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =

imx6dl-udoo              | arm    | lab-broonie   | gcc-10   | imx_v6_v7_de=
fconfig          | 1          =

imx6q-udoo               | arm    | lab-broonie   | gcc-10   | imx_v6_v7_de=
fconfig          | 1          =

imx6ul-14x14-evk         | arm    | lab-nxp       | gcc-10   | imx_v6_v7_de=
fconfig          | 1          =

imx7ulp-evk              | arm    | lab-nxp       | gcc-10   | multi_v7_def=
config           | 1          =

imx8mp-evk               | arm64  | lab-broonie   | gcc-10   | defconfig   =
                 | 1          =

r8a774c0-ek874           | arm64  | lab-cip       | gcc-10   | defconfig+ar=
m64-chromebook   | 1          =

r8a774c0-ek874           | arm64  | lab-cip       | gcc-10   | defconfig   =
                 | 1          =

r8a77960-ulcb            | arm64  | lab-collabora | gcc-10   | defconfig   =
                 | 1          =

r8a779m1-ulcb            | arm64  | lab-collabora | gcc-10   | defconfig   =
                 | 1          =

rk3288-veyron-jaq        | arm    | lab-collabora | gcc-10   | multi_v7_def=
config           | 2          =

rk3399-rock-pi-4b        | arm64  | lab-collabora | gcc-10   | defconfig   =
                 | 1          =

sun50i-h6-pine-h64       | arm64  | lab-collabora | gcc-10   | defconfig   =
                 | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.45-cip3-31-gbae6b8e9a2cff/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.45-cip3-31-gbae6b8e9a2cff
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      bae6b8e9a2cff1558da85b327d6a7bd4a5d21d0a =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
acer-chromebox-cxi4-puff | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4d62f59ffaf2694b1e485

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.45-cip3-31-gbae6b8e9a2cff/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-acer-chromebox-cxi4-puff.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.45-cip3-31-gbae6b8e9a2cff/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-acer-chromebox-cxi4-puff.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64e4d62f59ffaf2694b1e=
486
        failing since 6 days (last pass: v5.10.186-cip37-16-gf8567732a40d, =
first fail: v4.4-st20-3262-g667bb8d8b2cb) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
bcm2836-rpi-2-b          | arm    | lab-collabora | gcc-10   | bcm2835_defc=
onfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4d3b63caf1531c9b1e3b1

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.45-cip3-31-gbae6b8e9a2cff/arm/bcm2835_defconfig/gcc-10/lab-collabora/=
baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.45-cip3-31-gbae6b8e9a2cff/arm/bcm2835_defconfig/gcc-10/lab-collabora/=
baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e4d3b63caf1531c9b1e3b6
        failing since 6 days (last pass: v4.19.288-cip101-1117-g1f3468542aa=
9e, first fail: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-22T15:28:05.139568  / # #

    2023-08-22T15:28:05.241727  export SHELL=3D/bin/sh

    2023-08-22T15:28:05.242439  #

    2023-08-22T15:28:05.343760  / # export SHELL=3D/bin/sh. /lava-11331333/=
environment

    2023-08-22T15:28:05.344400  =


    2023-08-22T15:28:05.445759  / # . /lava-11331333/environment/lava-11331=
333/bin/lava-test-runner /lava-11331333/1

    2023-08-22T15:28:05.446830  =


    2023-08-22T15:28:05.463982  / # /lava-11331333/bin/lava-test-runner /la=
va-11331333/1

    2023-08-22T15:28:05.573824  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-22T15:28:05.574342  + cd /lava-11331333/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
bcm2836-rpi-2-b          | arm    | lab-collabora | gcc-10   | multi_v7_def=
config           | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4d5e80008ae959bb1e40a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.45-cip3-31-gbae6b8e9a2cff/arm/multi_v7_defconfig/gcc-10/lab-collabora=
/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.45-cip3-31-gbae6b8e9a2cff/arm/multi_v7_defconfig/gcc-10/lab-collabora=
/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64e4d5e80008ae959bb1e=
40b
        failing since 6 days (last pass: v4.19.288-cip101-1117-g1f3468542aa=
9e, first fail: v5.10.186-cip37-16-gf8567732a40d) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
fsl-ls1088a-rdb          | arm64  | lab-nxp       | gcc-10   | defconfig   =
                 | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4d725471ea157c6b1e3f4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.45-cip3-31-gbae6b8e9a2cff/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl=
-ls1088a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.45-cip3-31-gbae6b8e9a2cff/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl=
-ls1088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e4d725471ea157c6b1e3f7
        failing since 6 days (last pass: v4.19.288-cip101-1117-g1f3468542aa=
9e, first fail: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-22T15:41:17.557740  + [   14.008555] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 1244899_1.5.2.4.1>
    2023-08-22T15:41:17.558022  set +x
    2023-08-22T15:41:17.663895  =

    2023-08-22T15:41:17.765166  / # #export SHELL=3D/bin/sh
    2023-08-22T15:41:17.765618  =

    2023-08-22T15:41:17.866615  / # export SHELL=3D/bin/sh. /lava-1244899/e=
nvironment
    2023-08-22T15:41:17.867077  =

    2023-08-22T15:41:17.968131  / # . /lava-1244899/environment/lava-124489=
9/bin/lava-test-runner /lava-1244899/1
    2023-08-22T15:41:17.968921  =

    2023-08-22T15:41:17.971907  / # /lava-1244899/bin/lava-test-runner /lav=
a-1244899/1 =

    ... (12 line(s) more)  =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
fsl-ls2088a-rdb          | arm64  | lab-nxp       | gcc-10   | defconfig   =
                 | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4d765d69a2c8479b1e3c6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.45-cip3-31-gbae6b8e9a2cff/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl=
-ls2088a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.45-cip3-31-gbae6b8e9a2cff/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl=
-ls2088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e4d765d69a2c8479b1e3c9
        failing since 6 days (last pass: v4.19.288-cip101-1117-g1f3468542aa=
9e, first fail: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-22T15:42:09.939214  + [   18.030988] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 1244898_1.5.2.4.1>
    2023-08-22T15:42:09.939503  set +x
    2023-08-22T15:42:10.045256  =

    2023-08-22T15:42:10.146494  / # #export SHELL=3D/bin/sh
    2023-08-22T15:42:10.146973  =

    2023-08-22T15:42:10.247953  / # export SHELL=3D/bin/sh. /lava-1244898/e=
nvironment
    2023-08-22T15:42:10.248392  =

    2023-08-22T15:42:10.349374  / # . /lava-1244898/environment/lava-124489=
8/bin/lava-test-runner /lava-1244898/1
    2023-08-22T15:42:10.350171  =

    2023-08-22T15:42:10.354465  / # /lava-1244898/bin/lava-test-runner /lav=
a-1244898/1 =

    ... (12 line(s) more)  =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
fsl-lx2160a-rdb          | arm64  | lab-nxp       | gcc-10   | defconfig   =
                 | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4d7133d8da24d83b1e3db

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.45-cip3-31-gbae6b8e9a2cff/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl=
-lx2160a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.45-cip3-31-gbae6b8e9a2cff/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl=
-lx2160a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e4d7133d8da24d83b1e3de
        failing since 123 days (last pass: v5.10.145-rt74-1329-ga59fc50f38f=
6, first fail: v5.10.177-cip31-33-gd59f246891e73)

    2023-08-22T15:40:57.484029  [   17.304142] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1244897_1.5.2.4.1>
    2023-08-22T15:40:57.588913  =

    2023-08-22T15:40:57.690113  / # #export SHELL=3D/bin/sh
    2023-08-22T15:40:57.690490  =

    2023-08-22T15:40:57.791124  / # export SHELL=3D/bin/sh. /lava-1244897/e=
nvironment
    2023-08-22T15:40:57.791482  =

    2023-08-22T15:40:57.892168  / # . /lava-1244897/environment/lava-124489=
7/bin/lava-test-runner /lava-1244897/1
    2023-08-22T15:40:57.892636  =

    2023-08-22T15:40:57.896522  / # /lava-1244897/bin/lava-test-runner /lav=
a-1244897/1
    2023-08-22T15:40:57.917489  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
hp-x360-14-G1-sona       | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4d5fc2c12898915b1e3b1

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.45-cip3-31-gbae6b8e9a2cff/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.45-cip3-31-gbae6b8e9a2cff/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e4d5fc2c12898915b1e3b6
        failing since 6 days (last pass: v4.19.288-cip101-1117-g1f3468542aa=
9e, first fail: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-22T15:36:15.717971  + set +x<8>[   10.237584] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11331411_1.4.2.3.1>

    2023-08-22T15:36:15.718398  =


    2023-08-22T15:36:15.825942  #

    2023-08-22T15:36:15.928728  / # #export SHELL=3D/bin/sh

    2023-08-22T15:36:15.929432  =


    2023-08-22T15:36:16.030972  / # export SHELL=3D/bin/sh. /lava-11331411/=
environment

    2023-08-22T15:36:16.031677  =


    2023-08-22T15:36:16.133184  / # . /lava-11331411/environment/lava-11331=
411/bin/lava-test-runner /lava-11331411/1

    2023-08-22T15:36:16.134576  =


    2023-08-22T15:36:16.140176  / # /lava-11331411/bin/lava-test-runner /la=
va-11331411/1
 =

    ... (12 line(s) more)  =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
imx6dl-udoo              | arm    | lab-broonie   | gcc-10   | imx_v6_v7_de=
fconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4d8060802937246b1e3bf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.45-cip3-31-gbae6b8e9a2cff/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/=
baseline-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.45-cip3-31-gbae6b8e9a2cff/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/=
baseline-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64e4d8060802937246b1e=
3c0
        new failure (last pass: v4.4-st20-3262-g667bb8d8b2cb) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
imx6q-udoo               | arm    | lab-broonie   | gcc-10   | imx_v6_v7_de=
fconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4d8050802937246b1e3bc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.45-cip3-31-gbae6b8e9a2cff/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/=
baseline-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.45-cip3-31-gbae6b8e9a2cff/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/=
baseline-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64e4d8050802937246b1e=
3bd
        new failure (last pass: v4.4-st20-3262-g667bb8d8b2cb) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
imx6ul-14x14-evk         | arm    | lab-nxp       | gcc-10   | imx_v6_v7_de=
fconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4d83dc04d0b1c83b1e3bd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.45-cip3-31-gbae6b8e9a2cff/arm/imx_v6_v7_defconfig/gcc-10/lab-nxp/base=
line-imx6ul-14x14-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.45-cip3-31-gbae6b8e9a2cff/arm/imx_v6_v7_defconfig/gcc-10/lab-nxp/base=
line-imx6ul-14x14-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64e4d83dc04d0b1c83b1e=
3be
        new failure (last pass: v4.4-st20-3262-g667bb8d8b2cb) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
imx7ulp-evk              | arm    | lab-nxp       | gcc-10   | multi_v7_def=
config           | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4d5d3dbd57dc626b1e3da

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.45-cip3-31-gbae6b8e9a2cff/arm/multi_v7_defconfig/gcc-10/lab-nxp/basel=
ine-imx7ulp-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.45-cip3-31-gbae6b8e9a2cff/arm/multi_v7_defconfig/gcc-10/lab-nxp/basel=
ine-imx7ulp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e4d5d3dbd57dc626b1e3dd
        failing since 153 days (last pass: v5.10.145-rt74-1329-ga59fc50f38f=
6, first fail: v5.10.175-cip29-rt12)

    2023-08-22T15:35:32.918024  + set +x
    2023-08-22T15:35:32.921184  <8>[   33.529563] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1244894_1.5.2.4.1>
    2023-08-22T15:35:33.030282  / # #
    2023-08-22T15:35:34.186198  export SHELL=3D/bin/sh
    2023-08-22T15:35:34.191809  #
    2023-08-22T15:35:34.192096  / # export SHELL=3D/bin/sh
    2023-08-22T15:35:35.733987  / # . /lava-1244894/environment
    2023-08-22T15:35:38.551174  /lava-1244894/bin/lava-test-runner /lava-12=
44894/1
    2023-08-22T15:35:38.557190  . /lava-1244894/environment
    2023-08-22T15:35:38.557454  / # /lava-1244894/bin/lava-test-runner /lav=
a-1244894/1 =

    ... (12 line(s) more)  =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
imx8mp-evk               | arm64  | lab-broonie   | gcc-10   | defconfig   =
                 | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4d6eb22c5e666a6b1e419

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.45-cip3-31-gbae6b8e9a2cff/arm64/defconfig/gcc-10/lab-broonie/baseline=
-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.45-cip3-31-gbae6b8e9a2cff/arm64/defconfig/gcc-10/lab-broonie/baseline=
-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e4d6eb22c5e666a6b1e41e
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-22T15:40:03.353360  + set<8>[   24.137111] <LAVA_SIGNAL_ENDRUN =
0_dmesg 64619_1.5.2.4.1>
    2023-08-22T15:40:03.353756   +x
    2023-08-22T15:40:03.463021  =

    2023-08-22T15:40:04.627949  / # #export SHELL=3D/bin/sh
    2023-08-22T15:40:04.634059  =

    2023-08-22T15:40:06.077280  / # export SHELL=3D/bin/sh. /lava-64619/env=
ironment
    2023-08-22T15:40:06.083405  =

    2023-08-22T15:40:08.695784  / # . /lava-64619/environment/lava-64619/bi=
n/lava-test-runner /lava-64619/1
    2023-08-22T15:40:08.702591  =

    2023-08-22T15:40:08.714031  / # /lava-64619/bin/lava-test-runner /lava-=
64619/1 =

    ... (17 line(s) more)  =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
r8a774c0-ek874           | arm64  | lab-cip       | gcc-10   | defconfig+ar=
m64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4d67c48e0227bd9b1e3c2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.45-cip3-31-gbae6b8e9a2cff/arm64/defconfig+arm64-chromebook/gcc-10/lab=
-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.45-cip3-31-gbae6b8e9a2cff/arm64/defconfig+arm64-chromebook/gcc-10/lab=
-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e4d67c48e0227bd9b1e3c5
        failing since 6 days (last pass: v4.19.288-cip101-1117-g1f3468542aa=
9e, first fail: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-22T15:37:58.228173  / # #
    2023-08-22T15:37:59.693287  export SHELL=3D/bin/sh
    2023-08-22T15:37:59.713960  #
    2023-08-22T15:37:59.714166  / # export SHELL=3D/bin/sh
    2023-08-22T15:38:01.600777  / # . /lava-999455/environment
    2023-08-22T15:38:05.061147  /lava-999455/bin/lava-test-runner /lava-999=
455/1
    2023-08-22T15:38:05.082048  . /lava-999455/environment
    2023-08-22T15:38:05.082167  / # /lava-999455/bin/lava-test-runner /lava=
-999455/1
    2023-08-22T15:38:05.172107  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-22T15:38:05.172685  + cd /lava-999455/1/tests/1_bootrr =

    ... (26 line(s) more)  =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
r8a774c0-ek874           | arm64  | lab-cip       | gcc-10   | defconfig   =
                 | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4d78cf893bcb088b1e3c0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.45-cip3-31-gbae6b8e9a2cff/arm64/defconfig/gcc-10/lab-cip/baseline-r8a=
774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.45-cip3-31-gbae6b8e9a2cff/arm64/defconfig/gcc-10/lab-cip/baseline-r8a=
774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e4d78cf893bcb088b1e3c3
        failing since 6 days (last pass: v4.19.288-cip101-1117-g1f3468542aa=
9e, first fail: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-22T15:42:54.101238  / # #
    2023-08-22T15:42:55.560896  export SHELL=3D/bin/sh
    2023-08-22T15:42:55.581395  #
    2023-08-22T15:42:55.581585  / # export SHELL=3D/bin/sh
    2023-08-22T15:42:57.463778  / # . /lava-999461/environment
    2023-08-22T15:43:00.919114  /lava-999461/bin/lava-test-runner /lava-999=
461/1
    2023-08-22T15:43:00.939895  . /lava-999461/environment
    2023-08-22T15:43:00.940002  / # /lava-999461/bin/lava-test-runner /lava=
-999461/1
    2023-08-22T15:43:00.981171  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-22T15:43:01.032916  + cd /lava-999461/1/tests/1_bootrr =

    ... (26 line(s) more)  =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
r8a77960-ulcb            | arm64  | lab-collabora | gcc-10   | defconfig   =
                 | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4d6d722c5e666a6b1e3b8

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.45-cip3-31-gbae6b8e9a2cff/arm64/defconfig/gcc-10/lab-collabora/baseli=
ne-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.45-cip3-31-gbae6b8e9a2cff/arm64/defconfig/gcc-10/lab-collabora/baseli=
ne-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e4d6d722c5e666a6b1e3bd
        failing since 34 days (last pass: v6.1.31-65-geef5a19d48f6, first f=
ail: v5.10.186-cip37-2-gfcd111609480)

    2023-08-22T15:41:37.578887  / # #

    2023-08-22T15:41:37.681033  export SHELL=3D/bin/sh

    2023-08-22T15:41:37.681806  #

    2023-08-22T15:41:37.783235  / # export SHELL=3D/bin/sh. /lava-11331455/=
environment

    2023-08-22T15:41:37.783950  =


    2023-08-22T15:41:37.885403  / # . /lava-11331455/environment/lava-11331=
455/bin/lava-test-runner /lava-11331455/1

    2023-08-22T15:41:37.886491  =


    2023-08-22T15:41:37.903059  / # /lava-11331455/bin/lava-test-runner /la=
va-11331455/1

    2023-08-22T15:41:37.951459  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-22T15:41:37.951965  + cd /lav<8>[   19.083497] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11331455_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
r8a779m1-ulcb            | arm64  | lab-collabora | gcc-10   | defconfig   =
                 | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4d6e122c5e666a6b1e40e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.45-cip3-31-gbae6b8e9a2cff/arm64/defconfig/gcc-10/lab-collabora/baseli=
ne-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.45-cip3-31-gbae6b8e9a2cff/arm64/defconfig/gcc-10/lab-collabora/baseli=
ne-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e4d6e122c5e666a6b1e413
        new failure (last pass: v6.1.31-65-geef5a19d48f6)

    2023-08-22T15:40:07.070497  / # #

    2023-08-22T15:40:08.150444  export SHELL=3D/bin/sh

    2023-08-22T15:40:08.152329  #

    2023-08-22T15:40:09.642733  / # export SHELL=3D/bin/sh. /lava-11331466/=
environment

    2023-08-22T15:40:09.644504  =


    2023-08-22T15:40:12.366363  / # . /lava-11331466/environment/lava-11331=
466/bin/lava-test-runner /lava-11331466/1

    2023-08-22T15:40:12.368538  =


    2023-08-22T15:40:12.378082  / # /lava-11331466/bin/lava-test-runner /la=
va-11331466/1

    2023-08-22T15:40:12.437228  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-22T15:40:12.437735  + cd /lava-113314<8>[   28.448120] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11331466_1.5.2.4.5>
 =

    ... (44 line(s) more)  =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
rk3288-veyron-jaq        | arm    | lab-collabora | gcc-10   | multi_v7_def=
config           | 2          =


  Details:     https://kernelci.org/test/plan/id/64e4d5ab191184e7bdb1e3f1

  Results:     66 PASS, 4 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.45-cip3-31-gbae6b8e9a2cff/arm/multi_v7_defconfig/gcc-10/lab-collabora=
/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.45-cip3-31-gbae6b8e9a2cff/arm/multi_v7_defconfig/gcc-10/lab-collabora=
/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/64e4d5ab191184e7bdb1e421
        failing since 214 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-08-22T15:36:22.694761  Usage: seq [-w] [-s SEP] [FIRST [INC]] LA<8=
>[   19.658424] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-08-22T15:36:22.695010  ST

    2023-08-22T15:36:22.695252  =


    2023-08-22T15:36:22.700132  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-08-22T15:36:22.703514  FIRST, INC default to 1.

    2023-08-22T15:36:22.703567  =


    2023-08-22T15:36:22.706331  	-w	Pad to last with leading zeros
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/64e4d5ab191184e7bdb1e422
        failing since 214 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-08-22T15:36:22.662095  <8>[   19.631758] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>

    2023-08-22T15:36:22.680253  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.

    2023-08-22T15:36:22.680478  =

   =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
rk3399-rock-pi-4b        | arm64  | lab-collabora | gcc-10   | defconfig   =
                 | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4d6f75620707716b1e3f9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.45-cip3-31-gbae6b8e9a2cff/arm64/defconfig/gcc-10/lab-collabora/baseli=
ne-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.45-cip3-31-gbae6b8e9a2cff/arm64/defconfig/gcc-10/lab-collabora/baseli=
ne-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e4d6f75620707716b1e3fe
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-22T15:40:26.767877  / # #

    2023-08-22T15:40:28.028782  export SHELL=3D/bin/sh

    2023-08-22T15:40:28.039750  #

    2023-08-22T15:40:28.040221  / # export SHELL=3D/bin/sh

    2023-08-22T15:40:29.783421  / # . /lava-11331452/environment

    2023-08-22T15:40:32.978979  /lava-11331452/bin/lava-test-runner /lava-1=
1331452/1

    2023-08-22T15:40:32.990033  . /lava-11331452/environment

    2023-08-22T15:40:32.990328  / # /lava-11331452/bin/lava-test-runner /la=
va-11331452/1

    2023-08-22T15:40:33.047048  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-22T15:40:33.047437  + cd /lava-11331452/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
sun50i-h6-pine-h64       | arm64  | lab-collabora | gcc-10   | defconfig   =
                 | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4d6eb99ee66ace6b1e4ec

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.45-cip3-31-gbae6b8e9a2cff/arm64/defconfig/gcc-10/lab-collabora/baseli=
ne-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.45-cip3-31-gbae6b8e9a2cff/arm64/defconfig/gcc-10/lab-collabora/baseli=
ne-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e4d6eb99ee66ace6b1e4f1
        failing since 34 days (last pass: v6.1.31-65-geef5a19d48f6, first f=
ail: v5.10.186-cip37-2-gfcd111609480)

    2023-08-22T15:41:47.488944  / # #

    2023-08-22T15:41:47.590916  export SHELL=3D/bin/sh

    2023-08-22T15:41:47.591608  #

    2023-08-22T15:41:47.692974  / # export SHELL=3D/bin/sh. /lava-11331461/=
environment

    2023-08-22T15:41:47.693681  =


    2023-08-22T15:41:47.795127  / # . /lava-11331461/environment/lava-11331=
461/bin/lava-test-runner /lava-11331461/1

    2023-08-22T15:41:47.796196  =


    2023-08-22T15:41:47.841453  / # /lava-11331461/bin/lava-test-runner /la=
va-11331461/1

    2023-08-22T15:41:47.879479  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-22T15:41:47.879996  + cd /lava-1133146<8>[   16.997081] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11331461_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20

