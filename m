Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AD7C64ED6
	for <webhook@archiver.kernel.org>; Thu, 23 Feb 2023 22:47:55 +0000 (UTC)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
 by mx.groups.io with SMTP id smtpd.web10.3997.1677192470346497395
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 23 Feb 2023 14:47:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=wwQQDIM2;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.52, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f52.google.com with SMTP id oe18-20020a17090b395200b00236a0d55d3aso846615pjb.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 23 Feb 2023 14:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mreChKIvlUdXu+HORS7v53b0FGOJ3dgfDkoQETd+k34=;
        b=wwQQDIM2DPAjMH0xO0WeiNVQthcBUw53oxwvK0hbqRjKpl/+nQXzpaX5fD2AqueaDe
         r/RQqHMhXdeILuuBaVjPgzre/XPpF8ag2ECeW2nczPlwTXFrVG8pDhrpUOc7RHYYbaw/
         SkZPq1VHmMysC/5f4NkVUjmwPuKS5T0mRt0u17rqaK7IDpRYAf15O6LMcsjwNUV5/HNj
         WXOjTj7CN+AhEAZZOaxmcz8Bltyq3h9q+2EAdJ23SxLFI3I+QitRruyOY30NWk2MbUxc
         avbnx90kphHpzjTs8E6pemxRrPH4v8qZofTtAfhQPBo/pNlWjJOIYU1UAvG+bzE6kg65
         bSkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mreChKIvlUdXu+HORS7v53b0FGOJ3dgfDkoQETd+k34=;
        b=nrKQ/RYJZoAI0suMxrr3151/6EqvP1/z3QzWh75KaBKxWSI+S3kToDJAeSWLaG6lEZ
         l2PC9Ztip7uXFEaOuJRPGdfRr8bHote+wvbgyh+xBMXoYzyx3TjVyvYDP6PC6Z8jdPJk
         Xpl4xZ/iefVYOFmLxhwFXLvubg+22AGo5Czqz6Sd2oqgMaMFBBqYN3CmO+Y1KgwDB1IZ
         pv5gUbYVENwNvMtmLHVmIfLFCguTReRa3gjoRTpkKOGyqgUVrIbNB0QOc9/fI+CHZF+c
         u0EL2OLQkVIMjQloOM5xPJl5hgO6i5WLfEKMpA7um6A4SrX1gXg4aN38usAketW5GVJQ
         zYCQ==
X-Gm-Message-State: AO0yUKXBxWeJVOZR5Ym8ouLscRmuo0icJAWSn0XOKmoLwxMRt21WTVVm
	+7jSNtZmH2+566YzGNjZpHWf/oMMnH7Q1JKETEM=
X-Google-Smtp-Source: AK7set/d+cej6ySBsC9wMmHfR91/NcQLlxhgc+NzIJArUkm1dYa5kiozGrr7sMDYB7UGVOPMh6oNhQ==
X-Received: by 2002:a05:6a20:9151:b0:cc:126f:1949 with SMTP id x17-20020a056a20915100b000cc126f1949mr3978143pzc.21.1677192468828;
        Thu, 23 Feb 2023 14:47:48 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y5-20020a62b505000000b005df0c2b1b6asm1254214pfe.153.2023.02.23.14.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 14:47:48 -0800 (PST)
Message-ID: <63f7ed14.620a0220.d7c98.2bab@mx.google.com>
Date: Thu, 23 Feb 2023 14:47:48 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.167-cip26-2-g1e87e7748b91
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip baseline: 135 runs,
 29 regressions (v5.10.167-cip26-2-g1e87e7748b91)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Feb 2023 22:47:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10800

cip/linux-5.10.y-cip baseline: 135 runs, 29 regressions (v5.10.167-cip26-2-=
g1e87e7748b91)

Regressions Summary
-------------------

platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
acer-cb317-1h-c3z6-dedede | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =

asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =

at91sam9g20ek             | arm    | lab-broonie     | gcc-10   | multi_v5_=
defconfig           | 1          =

beaglebone-black          | arm    | lab-broonie     | gcc-10   | multi_v7_=
defconfig           | 1          =

beaglebone-black          | arm    | lab-broonie     | gcc-10   | omap2plus=
_defconfig          | 1          =

imx6q-sabrelite           | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 1          =

imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | imx_v6_v7=
_defconfig          | 1          =

imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | multi_v7_=
defconfig           | 1          =

mt8173-elm-hana           | arm64  | lab-collabora   | gcc-10   | defconfig=
+arm64-chromebook   | 1          =

qemu_i386-uefi            | i386   | lab-broonie     | gcc-10   | i386_defc=
onfig               | 1          =

qemu_x86_64-uefi          | x86_64 | lab-broonie     | gcc-10   | x86_64_de=
fconfig             | 1          =

qemu_x86_64-uefi          | x86_64 | lab-broonie     | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =

qemu_x86_64-uefi          | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fconfig             | 1          =

qemu_x86_64-uefi-mixed    | x86_64 | lab-broonie     | gcc-10   | x86_64_de=
fconfig             | 1          =

qemu_x86_64-uefi-mixed    | x86_64 | lab-broonie     | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =

qemu_x86_64-uefi-mixed    | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fconfig             | 1          =

qemu_x86_64-uefi-mixed    | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =

rk3288-veyron-jaq         | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 4          =

rk3399-gru-kevin          | arm64  | lab-collabora   | gcc-10   | defconfig=
+arm64-chromebook   | 5          =

sun50i-a64-pine64-plus    | arm64  | lab-broonie     | gcc-10   | defconfig=
                    | 1          =

tegra124-nyan-big         | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.167-cip26-2-g1e87e7748b91/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.167-cip26-2-g1e87e7748b91
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      1e87e7748b91cc6ec7f9f32d6d156ee15f651805 =



Test Regressions
---------------- =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
acer-cb317-1h-c3z6-dedede | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63f7e1b19b66a07fff8c865e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63f7e1b19b66a07fff8c8667
        failing since 40 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-23T21:59:01.129127  + set +x

    2023-02-23T21:59:01.135583  <8>[   10.857709] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9305534_1.4.2.3.1>

    2023-02-23T21:59:01.240075  / # #

    2023-02-23T21:59:01.341019  export SHELL=3D/bin/sh

    2023-02-23T21:59:01.341213  #

    2023-02-23T21:59:01.442089  / # export SHELL=3D/bin/sh. /lava-9305534/e=
nvironment

    2023-02-23T21:59:01.442278  =


    2023-02-23T21:59:01.543176  / # . /lava-9305534/environment/lava-930553=
4/bin/lava-test-runner /lava-9305534/1

    2023-02-23T21:59:01.543447  =


    2023-02-23T21:59:01.548917  / # /lava-9305534/bin/lava-test-runner /lav=
a-9305534/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63f7e19cb7c3e5dc988c862f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63f7e19cb7c3e5dc988c8638
        failing since 40 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-23T21:58:34.372332  + <8>[    7.822099] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 9305488_1.4.2.3.1>

    2023-02-23T21:58:34.375526  set +x

    2023-02-23T21:58:34.480919  #

    2023-02-23T21:58:34.482243  =


    2023-02-23T21:58:34.584449  / # #export SHELL=3D/bin/sh

    2023-02-23T21:58:34.585290  =


    2023-02-23T21:58:34.687031  / # export SHELL=3D/bin/sh. /lava-9305488/e=
nvironment

    2023-02-23T21:58:34.687860  =


    2023-02-23T21:58:34.789623  / # . /lava-9305488/environment/lava-930548=
8/bin/lava-test-runner /lava-9305488/1

    2023-02-23T21:58:34.790934  =

 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63f7e28c1d244b96ee8c8631

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63f7e28c1d244b96ee8c863a
        failing since 40 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-23T22:02:35.289635  + set +x

    2023-02-23T22:02:35.296064  <8>[   10.777471] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9305523_1.4.2.3.1>

    2023-02-23T22:02:35.401173  /#

    2023-02-23T22:02:35.504343   # #export SHELL=3D/bin/sh

    2023-02-23T22:02:35.505142  =


    2023-02-23T22:02:35.607004  / # export SHELL=3D/bin/sh. /lava-9305523/e=
nvironment

    2023-02-23T22:02:35.607876  =


    2023-02-23T22:02:35.709793  / # . /lava-9305523/environment/lava-930552=
3/bin/lava-test-runner /lava-9305523/1

    2023-02-23T22:02:35.710127  =


    2023-02-23T22:02:35.712263  / # /lava-9305523/bin/lava-test-runner /lav=
a-9305523/1
 =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
at91sam9g20ek             | arm    | lab-broonie     | gcc-10   | multi_v5_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63f7e1efd72eb9091b8c8676

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-a=
t91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-a=
t91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63f7e1efd72eb9091b8c867f
        failing since 40 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-23T21:59:55.992362  + set +x
    2023-02-23T21:59:55.997471  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 65505_1.5.2.=
4.1>
    2023-02-23T21:59:56.111835  / # #
    2023-02-23T21:59:56.215010  export SHELL=3D/bin/sh
    2023-02-23T21:59:56.215834  #
    2023-02-23T21:59:56.317831  / # export SHELL=3D/bin/sh. /lava-65505/env=
ironment
    2023-02-23T21:59:56.318716  =

    2023-02-23T21:59:56.420704  / # . /lava-65505/environment/lava-65505/bi=
n/lava-test-runner /lava-65505/1
    2023-02-23T21:59:56.422100  =

    2023-02-23T21:59:56.428356  / # /lava-65505/bin/lava-test-runner /lava-=
65505/1 =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
beaglebone-black          | arm    | lab-broonie     | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63f7e460b7fe4c4fc58c8691

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-b=
eaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-b=
eaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63f7e460b7fe4c4fc58c869a
        failing since 40 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-23T22:10:24.913634  <8>[   21.512391] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 65590_1.5.2.4.1>
    2023-02-23T22:10:25.023972  / # #
    2023-02-23T22:10:25.126213  export SHELL=3D/bin/sh
    2023-02-23T22:10:25.126771  #
    2023-02-23T22:10:25.228387  / # export SHELL=3D/bin/sh. /lava-65590/env=
ironment
    2023-02-23T22:10:25.228970  =

    2023-02-23T22:10:25.330894  / # . /lava-65590/environment/lava-65590/bi=
n/lava-test-runner /lava-65590/1
    2023-02-23T22:10:25.331815  =

    2023-02-23T22:10:25.335434  / # /lava-65590/bin/lava-test-runner /lava-=
65590/1
    2023-02-23T22:10:25.419020  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
beaglebone-black          | arm    | lab-broonie     | gcc-10   | omap2plus=
_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63f7e2cf0990ea2bca8c863e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-=
beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-=
beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63f7e2cf0990ea2bca8c8647
        failing since 40 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-23T22:03:41.750540  <8>[   19.244336] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 65537_1.5.2.4.1>
    2023-02-23T22:03:41.857498  / # #
    2023-02-23T22:03:41.959747  export SHELL=3D/bin/sh
    2023-02-23T22:03:41.960194  #
    2023-02-23T22:03:42.061619  / # export SHELL=3D/bin/sh. /lava-65537/env=
ironment
    2023-02-23T22:03:42.062192  =

    2023-02-23T22:03:42.163688  / # . /lava-65537/environment/lava-65537/bi=
n/lava-test-runner /lava-65537/1
    2023-02-23T22:03:42.164597  =

    2023-02-23T22:03:42.167952  / # /lava-65537/bin/lava-test-runner /lava-=
65537/1
    2023-02-23T22:03:42.272895  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6q-sabrelite           | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63f7e807e48b09483b8c867a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline=
-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline=
-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63f7e807e48b09483b8c8683
        failing since 40 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-23T22:26:02.361022  / # #

    2023-02-23T22:26:02.464226  export SHELL=3D/bin/sh

    2023-02-23T22:26:02.465105  #

    2023-02-23T22:26:02.567152  / # export SHELL=3D/bin/sh. /lava-9305692/e=
nvironment

    2023-02-23T22:26:02.568031  =


    2023-02-23T22:26:02.670209  / # . /lava-9305692/environment/lava-930569=
2/bin/lava-test-runner /lava-9305692/1

    2023-02-23T22:26:02.671585  =


    2023-02-23T22:26:02.683714  / # /lava-9305692/bin/lava-test-runner /lav=
a-9305692/1

    2023-02-23T22:26:02.776604  + export 'TESTRUN_ID=3D1_bootrr'

    2023-02-23T22:26:02.777209  + cd /lava-9305692/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | imx_v6_v7=
_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63f7e2c0f5c5d35bd98c8657

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/basel=
ine-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/basel=
ine-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63f7e2c0f5c5d35bd98c8660
        failing since 40 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-23T22:03:21.837383  + set +x
    2023-02-23T22:03:21.837682  [   11.638765] <LAVA_SIGNAL_ENDRUN 0_dmesg =
912081_1.5.2.3.1>
    2023-02-23T22:03:21.946879  / # #
    2023-02-23T22:03:22.048454  export SHELL=3D/bin/sh
    2023-02-23T22:03:22.048888  #
    2023-02-23T22:03:22.150476  / # export SHELL=3D/bin/sh. /lava-912081/en=
vironment
    2023-02-23T22:03:22.151096  =

    2023-02-23T22:03:22.252455  / # . /lava-912081/environment/lava-912081/=
bin/lava-test-runner /lava-912081/1
    2023-02-23T22:03:22.253147  =

    2023-02-23T22:03:22.256145  / # /lava-912081/bin/lava-test-runner /lava=
-912081/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63f7e3c6ce843f828b8c8673

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseli=
ne-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseli=
ne-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63f7e3c6ce843f828b8c867c
        failing since 40 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-23T22:07:41.497941  + set[    7.310144] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 912089_1.5.2.3.1>
    2023-02-23T22:07:41.498129   +x
    2023-02-23T22:07:41.603879  / # #
    2023-02-23T22:07:41.705541  export SHELL=3D/bin/sh
    2023-02-23T22:07:41.706126  #
    2023-02-23T22:07:41.807360  / # export SHELL=3D/bin/sh. /lava-912089/en=
vironment
    2023-02-23T22:07:41.807867  =

    2023-02-23T22:07:41.909123  / # . /lava-912089/environment/lava-912089/=
bin/lava-test-runner /lava-912089/1
    2023-02-23T22:07:41.909766  =

    2023-02-23T22:07:41.911851  / # /lava-912089/bin/lava-test-runner /lava=
-912089/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
mt8173-elm-hana           | arm64  | lab-collabora   | gcc-10   | defconfig=
+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63f7e41eb070375aff8c862f

  Results:     28 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabor=
a/baseline-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabor=
a/baseline-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63f7e41eb070375aff8c864f
        failing since 40 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-23T22:09:16.029654  + set +x

    2023-02-23T22:09:16.038633  <8>[   15.690780] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9305715_1.5.2.3.1>

    2023-02-23T22:09:16.144751  / # #

    2023-02-23T22:09:16.247823  export SHELL=3D/bin/sh

    2023-02-23T22:09:16.248781  #

    2023-02-23T22:09:16.350940  / # export SHELL=3D/bin/sh. /lava-9305715/e=
nvironment

    2023-02-23T22:09:16.351851  =


    2023-02-23T22:09:16.454108  / # . /lava-9305715/environment/lava-930571=
5/bin/lava-test-runner /lava-9305715/1

    2023-02-23T22:09:16.455588  =


    2023-02-23T22:09:16.457930  / # /lava-9305715/bin/lava-test-runner /lav=
a-9305715/1
 =

    ... (16 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
qemu_i386-uefi            | i386   | lab-broonie     | gcc-10   | i386_defc=
onfig               | 1          =


  Details:     https://kernelci.org/test/plan/id/63f7eb60317cbc21c88c8642

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: i386_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/i386/i386_defconfig/gcc-10/lab-broonie/baseline-qemu=
_i386-uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/i386/i386_defconfig/gcc-10/lab-broonie/baseline-qemu=
_i386-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f7eb60317cbc21c88c8=
643
        new failure (last pass: v5.10.167-cip26) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
qemu_x86_64-uefi          | x86_64 | lab-broonie     | gcc-10   | x86_64_de=
fconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/63f7eb61317cbc21c88c8649

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/x86_64/x86_64_defconfig/gcc-10/lab-broonie/baseline-=
qemu_x86_64-uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/x86_64/x86_64_defconfig/gcc-10/lab-broonie/baseline-=
qemu_x86_64-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f7eb61317cbc21c88c8=
64a
        new failure (last pass: v5.10.162-cip24) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
qemu_x86_64-uefi          | x86_64 | lab-broonie     | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63f7eb9cf95f265cfa8c8632

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-br=
oonie/baseline-qemu_x86_64-uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-br=
oonie/baseline-qemu_x86_64-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f7eb9cf95f265cfa8c8=
633
        new failure (last pass: v5.10.167-cip26) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
qemu_x86_64-uefi          | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/63f7e28d1d244b96ee8c863f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/x86_64/x86_64_defconfig/gcc-10/lab-collabora/baselin=
e-qemu_x86_64-uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/x86_64/x86_64_defconfig/gcc-10/lab-collabora/baselin=
e-qemu_x86_64-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f7e28d1d244b96ee8c8=
640
        new failure (last pass: v5.10.162-cip24) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
qemu_x86_64-uefi-mixed    | x86_64 | lab-broonie     | gcc-10   | x86_64_de=
fconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/63f7eb74fcb74da3908c8651

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/x86_64/x86_64_defconfig/gcc-10/lab-broonie/baseline-=
qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/x86_64/x86_64_defconfig/gcc-10/lab-broonie/baseline-=
qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f7eb74fcb74da3908c8=
652
        new failure (last pass: v5.10.165-cip25) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
qemu_x86_64-uefi-mixed    | x86_64 | lab-broonie     | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63f7eb9df95f265cfa8c8637

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-br=
oonie/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-br=
oonie/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f7eb9df95f265cfa8c8=
638
        new failure (last pass: v5.10.162-cip24) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
qemu_x86_64-uefi-mixed    | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/63f7e28ea17549dc048c8656

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/x86_64/x86_64_defconfig/gcc-10/lab-collabora/baselin=
e-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/x86_64/x86_64_defconfig/gcc-10/lab-collabora/baselin=
e-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f7e28ea17549dc048c8=
657
        new failure (last pass: v5.10.165-cip25) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
qemu_x86_64-uefi-mixed    | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63f7e2b5f5c5d35bd98c8644

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f7e2b5f5c5d35bd98c8=
645
        new failure (last pass: v5.10.162-cip24) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
rk3288-veyron-jaq         | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 4          =


  Details:     https://kernelci.org/test/plan/id/63f7e3ed3153e16d578c8667

  Results:     63 PASS, 8 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline=
-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline=
-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-i2c-present: https://kernelci.or=
g/test/case/id/63f7e3ee3153e16d578c869a
        failing since 38 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-23T22:08:30.035086   INC default to 1.

    2023-02-23T22:08:30.035664  =


    2023-02-23T22:08:30.038829  	-w	Pad to last with leading zeros

    2023-02-23T22:08:30.041496  	-s SEP	String separator

    2023-02-23T22:08:30.044707  /lava-9305694/1/../bin/lava-test-case

    2023-02-23T22:08:30.051195  BusyBox v1.31.1 (2023-02-17 15:41:33 UTC) m=
ulti-call binary.

    2023-02-23T22:08:30.051813  =


    2023-02-23T22:08:30.061614  Usage<8>[   21.525858] <LAVA_SIGNAL_TESTCAS=
E TEST_CASE_ID=3Ddwhdmi-rockchip-driver-i2c-present RESULT=3Dfail>
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/63f7e3ee3153e16d578c869b
        failing since 38 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-23T22:08:30.013041   multi-call binary.

    2023-02-23T22:08:30.013375  =


    2023-02-23T22:08:30.017271  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-02-23T22:08:30.017901  =


    2023-02-23T22:08:30.022345  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-02-23T22:08:30.033274  FIRST,<8>[   21.496849] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/63f7e3ee3153e16d578c869c
        failing since 38 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-23T22:08:30.010847  BusyBox v1.31.1 (2023-02-17 15:41:33 UTC)<8=
>[   21.477799] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63f7e3ee3153e16d578c86ad
        failing since 38 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-23T22:08:17.949038  + <8>[    9.386232] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 9305694_1.5.2.3.1>

    2023-02-23T22:08:17.949388  set +x

    2023-02-23T22:08:18.056996  / # #

    2023-02-23T22:08:18.159545  export SHELL=3D/bin/sh

    2023-02-23T22:08:18.160294  <4>[    9.429739] sbs-battery 20-000b: Unkn=
own chemistry: POLY

    2023-02-23T22:08:18.160741  #

    2023-02-23T22:08:18.262403  / # export SHELL=3D/bin/sh. /lava-9305694/e=
nvironment

    2023-02-23T22:08:18.262828  =


    2023-02-23T22:08:18.364138  / # . /lava-9305694/environment/lava-930569=
4/bin/lava-test-runner /lava-9305694/1

    2023-02-23T22:08:18.364755  =

 =

    ... (19 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora   | gcc-10   | defconfig=
+arm64-chromebook   | 5          =


  Details:     https://kernelci.org/test/plan/id/63f7e445aabe5b587a8c86ac

  Results:     86 PASS, 6 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabor=
a/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabor=
a/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/case/id=
/63f7e445aabe5b587a8c86d2
        failing since 331 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81,=
 first fail: v5.10.106-cip4)

    2023-02-23T22:10:02.030627  /lava-9305732/1/../bin/lava-test-case
   =


  * baseline.bootrr.rk3399-gru-sound-driver-rt5514-present: https://kernelc=
i.org/test/case/id/63f7e445aabe5b587a8c86e7
        failing since 40 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-23T22:10:00.332228  Print numbers from FIRST to LAST, in steps =
of<8>[   58.569772] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Drk3399-gru-sound-d=
river-max98357A-present RESULT=3Dfail>

    2023-02-23T22:10:00.340144   INC.

    2023-02-23T22:10:00.342798  FIRST, INC default to 1.

    2023-02-23T22:10:00.342884  =


    2023-02-23T22:10:00.346253  	-w	Pad to last with leading zeros

    2023-02-23T22:10:00.348511  	-s SEP	String separator
   =


  * baseline.bootrr.rk3399-gru-sound-driver-max98357A-present: https://kern=
elci.org/test/case/id/63f7e445aabe5b587a8c86e8
        failing since 40 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-23T22:10:00.296873  	<8>[   58.539488] <LAVA_SIGNAL_TESTCASE TE=
ST_CASE_ID=3Drk3399-gru-sound-driver-dp-present RESULT=3Dfail>

    2023-02-23T22:10:00.300327  -w	Pad to last with leading zeros

    2023-02-23T22:10:00.302635  	-s SEP	String separator

    2023-02-23T22:10:00.306409  /lava-9305732/1/../bin/lava-test-case

    2023-02-23T22:10:00.312766  BusyBox v1.31.1 (2023-02-17 14:37:44 UTC) m=
ulti-call binary.

    2023-02-23T22:10:00.312859  =


    2023-02-23T22:10:00.317216  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-02-23T22:10:00.317305  =

   =


  * baseline.bootrr.rk3399-gru-sound-driver-dp-present: https://kernelci.or=
g/test/case/id/63f7e445aabe5b587a8c86e9
        failing since 40 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-23T22:10:00.278861  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-02-23T22:10:00.278949  =


    2023-02-23T22:10:00.284141  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-02-23T22:10:00.286764  FIRST, INC default to 1.

    2023-02-23T22:10:00.286848  =

   =


  * baseline.bootrr.rk3399-gru-sound-driver-da7219-present: https://kernelc=
i.org/test/case/id/63f7e445aabe5b587a8c86ea
        failing since 40 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-23T22:10:00.253432  BusyBox v1.31.1 (2023-02-17 14:37:44 UTC) m=
ulti-call binary.

    2023-02-23T22:10:00.253740  =


    2023-02-23T22:10:00.263866  <8>[   58.506339] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-da7219-present RESULT=3Dfail>
   =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
sun50i-a64-pine64-plus    | arm64  | lab-broonie     | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63f7e74ec4c12ad9b88c8665

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a=
64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a=
64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63f7e74ec4c12ad9b88c866e
        failing since 40 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-23T22:23:00.646014  + set +x
    2023-02-23T22:23:00.650193  <8>[   17.123629] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 65647_1.5.2.4.1>
    2023-02-23T22:23:00.760493  / # #
    2023-02-23T22:23:00.862590  export SHELL=3D/bin/sh
    2023-02-23T22:23:00.863119  #
    2023-02-23T22:23:00.964597  / # export SHELL=3D/bin/sh. /lava-65647/env=
ironment
    2023-02-23T22:23:00.965133  =

    2023-02-23T22:23:01.066420  / # . /lava-65647/environment/lava-65647/bi=
n/lava-test-runner /lava-65647/1
    2023-02-23T22:23:01.067304  =

    2023-02-23T22:23:01.071533  / # /lava-65647/bin/lava-test-runner /lava-=
65647/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
tegra124-nyan-big         | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63f7e518c7bd9bf28c8c8644

  Results:     5 PASS, 2 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline=
-tegra124-nyan-big.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline=
-tegra124-nyan-big.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63f7e518c7bd9bf28c8c864d
        failing since 38 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-23T22:13:16.900706  + set +x

    2023-02-23T22:13:16.906136  <8>[   17.492556] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9305693_1.5.2.3.1>

    2023-02-23T22:13:17.013522  #

    2023-02-23T22:13:17.115564  / # #export SHELL=3D/bin/sh

    2023-02-23T22:13:17.116061  =


    2023-02-23T22:13:17.217378  / # export SHELL=3D/bin/sh. /lava-9305693/e=
nvironment

    2023-02-23T22:13:17.217842  =


    2023-02-23T22:13:17.319178  / # . /lava-9305693/environment/lava-930569=
3/bin/lava-test-runner /lava-9305693/1

    2023-02-23T22:13:17.319874  =


    2023-02-23T22:13:17.322384  / # /lava-9305693/bin/lava-test-runner /lav=
a-9305693/1
 =

    ... (15 line(s) more)  =

 =20

