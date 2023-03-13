Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1443CC6FD1C
	for <webhook@archiver.kernel.org>; Mon, 13 Mar 2023 13:01:15 +0000 (UTC)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
 by mx.groups.io with SMTP id smtpd.web10.18639.1678712466514530195
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 13 Mar 2023 06:01:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=mz1XTGgQ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.41, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f41.google.com with SMTP id rj10so1388932pjb.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 13 Mar 2023 06:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1678712466;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SX8IiDHRxoNeG3OU8JGA5EbysbHDtkDfSdVTiSTUAX0=;
        b=mz1XTGgQ7NQmjJX2M7F22p1OTELhknlCJmD5GaNszs+wNQ/OI95uGFBpFHKKylcRFd
         PekjkyjTKVPQhmOaWuFQ9YPtF9TeZaWFMzMUc0OlemlcCbuClKVemOXCgIqdVJdlpL70
         5504ds1ZyY5jlCPx/ztHsiu6DXEb/S7uiAI/Z3iPjcN/afABB16b9eGAigompD7BNxxa
         TuSu/M0theUVAdV/JTJ6q1JJ129/e9hqxifT3uNL4x5sDr0kmQzPuwTZ3V7FDLyHuSIr
         eiCLRvW5zAwyCvviWohbHcpRNuWNog/bmC4UaPgftfqGrxo6w9FLYBLhxHcod9hu8edO
         SsPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678712466;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SX8IiDHRxoNeG3OU8JGA5EbysbHDtkDfSdVTiSTUAX0=;
        b=hHEJ7WxbvsWf6qwm+MY8HA8tsJuR1wGT0TeUqUgAtRNnJ1UnsxSoGKbJxnujCpSaRl
         JER0NDaCriPJ6G6YtKh4iWufKADyqHYY8yVptsoDnSiylxYc+GUVhllqkPB37M5ImqR9
         0QlhOnGF7Cb2cufMG53eGyjHijD8FlGudmGtEgzIPowUE2smOA7a/zQ8/2KAxG08VBSg
         hAV4dmk7frws8XgmXZStLyRK9Y1KLfwaDsv92XnMeJVsDa3OG1h0a6K95o05x6bH/zwT
         hP7CSlxvf7sHiXCBV36sEEaWup/cBJAyv5cFgOR4W0TWQBvCcl2q38anR7WmMekGXEUs
         GzsA==
X-Gm-Message-State: AO0yUKVynDbFsodHhyZxnpfmkTzn/TBVQybyF/sNqLKsdC0TvUR1KUZr
	9eH9bdjPkX0zjQmqIdsWiGmy6OmuG0Wy7KKbWdWFBtXz
X-Google-Smtp-Source: AK7set9mXEngcp3xgWjib3FRRqkkA14xw89s4AzenyYaXoZlxXvRd4pEeo2OpZFc5qEE+e4Maqz+ag==
X-Received: by 2002:a17:90a:4a83:b0:23d:1fc0:dd1f with SMTP id f3-20020a17090a4a8300b0023d1fc0dd1fmr1022393pjh.38.1678712464249;
        Mon, 13 Mar 2023 06:01:04 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id gf3-20020a17090ac7c300b00230b8402760sm2752461pjb.38.2023.03.13.06.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 06:01:03 -0700 (PDT)
Message-ID: <640f1e8f.170a0220.4f15f.3de4@mx.google.com>
Date: Mon, 13 Mar 2023 06:01:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.173-cip28
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip baseline: 106 runs,
 33 regressions (v5.10.173-cip28)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Mar 2023 13:01:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11003

cip/linux-5.10.y-cip baseline: 106 runs, 33 regressions (v5.10.173-cip28)

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

beaglebone-black          | arm    | lab-cip         | gcc-10   | multi_v7_=
defconfig           | 1          =

beaglebone-black          | arm    | lab-broonie     | gcc-10   | omap2plus=
_defconfig          | 1          =

beaglebone-black          | arm    | lab-cip         | gcc-10   | omap2plus=
_defconfig          | 1          =

fsl-ls1028a-rdb           | arm64  | lab-nxp         | gcc-10   | defconfig=
                    | 1          =

fsl-ls1088a-rdb           | arm64  | lab-nxp         | gcc-10   | defconfig=
                    | 1          =

imx6q-sabrelite           | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 1          =

imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | imx_v6_v7=
_defconfig          | 1          =

imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | multi_v7_=
defconfig           | 1          =

imx7d-sdb                 | arm    | lab-nxp         | gcc-10   | multi_v7_=
defconfig           | 1          =

imx7ulp-evk               | arm    | lab-nxp         | gcc-10   | multi_v7_=
defconfig           | 1          =

mt8173-elm-hana           | arm64  | lab-collabora   | gcc-10   | defconfig=
+arm64-chromebook   | 1          =

qemu_x86_64-uefi          | x86_64 | lab-broonie     | gcc-10   | x86_64_de=
fconfig             | 1          =

qemu_x86_64-uefi          | x86_64 | lab-broonie     | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =

qemu_x86_64-uefi-mixed    | x86_64 | lab-broonie     | gcc-10   | x86_64_de=
fconfig             | 1          =

qemu_x86_64-uefi-mixed    | x86_64 | lab-broonie     | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =

qemu_x86_64-uefi-mixed    | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fconfig             | 1          =

r8a7743-iwg20d-q7         | arm    | lab-cip         | gcc-10   | shmobile_=
defconfig           | 1          =

rk3288-veyron-jaq         | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 4          =

rk3399-gru-kevin          | arm64  | lab-collabora   | gcc-10   | defconfig=
+arm64-chromebook   | 5          =

sun50i-a64-pine64-plus    | arm64  | lab-broonie     | gcc-10   | defconfig=
                    | 1          =

tegra124-nyan-big         | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.173-cip28/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.173-cip28
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      2988848bfa1d1f2c02318f2193b06874fb5f62eb =



Test Regressions
---------------- =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
acer-cb317-1h-c3z6-dedede | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/640f168b3d593f4e148c866a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/640f168b3d593f4e148c8673
        failing since 58 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-13T12:26:32.592202  <8>[   11.485006] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9584309_1.4.2.3.1>

    2023-03-13T12:26:32.595644  + set +x

    2023-03-13T12:26:32.697293  #

    2023-03-13T12:26:32.800422  / # #export SHELL=3D/bin/sh

    2023-03-13T12:26:32.801275  =


    2023-03-13T12:26:32.903099  / # export SHELL=3D/bin/sh. /lava-9584309/e=
nvironment

    2023-03-13T12:26:32.903950  =


    2023-03-13T12:26:33.005987  / # . /lava-9584309/environment/lava-958430=
9/bin/lava-test-runner /lava-9584309/1

    2023-03-13T12:26:33.007433  =


    2023-03-13T12:26:33.013196  / # /lava-9584309/bin/lava-test-runner /lav=
a-9584309/1
 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/640f168d4bad46b0e28c866a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/640f168d4bad46b0e28c8672
        failing since 58 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-13T12:26:30.010533  + set +x<8>[   11.077240] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 9584357_1.4.2.3.1>

    2023-03-13T12:26:30.010624  =


    2023-03-13T12:26:30.112743  #

    2023-03-13T12:26:30.213904  / # #export SHELL=3D/bin/sh

    2023-03-13T12:26:30.214123  =


    2023-03-13T12:26:30.315086  / # export SHELL=3D/bin/sh. /lava-9584357/e=
nvironment

    2023-03-13T12:26:30.315275  =


    2023-03-13T12:26:30.416296  / # . /lava-9584357/environment/lava-958435=
7/bin/lava-test-runner /lava-9584357/1

    2023-03-13T12:26:30.416614  =


    2023-03-13T12:26:30.422086  / # /lava-9584357/bin/lava-test-runner /lav=
a-9584357/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/640f16a2551ba554bc8c866a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/640f16a2551ba554bc8c8673
        failing since 58 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-13T12:26:54.701788  + set +x

    2023-03-13T12:26:54.708507  <8>[   11.044867] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9584339_1.4.2.3.1>

    2023-03-13T12:26:54.818216  /#

    2023-03-13T12:26:54.921893   # #export SHELL=3D/bin/sh

    2023-03-13T12:26:54.922891  =


    2023-03-13T12:26:55.024997  / # export SHELL=3D/bin/sh. /lava-9584339/e=
nvironment

    2023-03-13T12:26:55.025963  =


    2023-03-13T12:26:55.128068  / # . /lava-9584339/environment/lava-958433=
9/bin/lava-test-runner /lava-9584339/1

    2023-03-13T12:26:55.129633  =


    2023-03-13T12:26:55.132128  / # /lava-9584339/bin/lava-test-runner /lav=
a-9584339/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
at91sam9g20ek             | arm    | lab-broonie     | gcc-10   | multi_v5_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/640f14f66797d64c848c867c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/640f14f66797d64c848c8685
        failing since 58 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-13T12:19:51.363151  + set +x
    2023-03-13T12:19:51.368310  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 151454_1.5.2=
.4.1>
    2023-03-13T12:19:51.482522  / # #
    2023-03-13T12:19:51.585504  export SHELL=3D/bin/sh
    2023-03-13T12:19:51.586342  #
    2023-03-13T12:19:51.688322  / # export SHELL=3D/bin/sh. /lava-151454/en=
vironment
    2023-03-13T12:19:51.689142  =

    2023-03-13T12:19:51.791125  / # . /lava-151454/environment/lava-151454/=
bin/lava-test-runner /lava-151454/1
    2023-03-13T12:19:51.792449  =

    2023-03-13T12:19:51.798805  / # /lava-151454/bin/lava-test-runner /lava=
-151454/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
beaglebone-black          | arm    | lab-broonie     | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/640f151fd4da42e3968c862f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/640f151fd4da42e3968c8636
        failing since 58 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-13T12:20:26.428220  <8>[   18.515183] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 151465_1.5.2.4.1>
    2023-03-13T12:20:26.535412  / # #
    2023-03-13T12:20:26.637568  export SHELL=3D/bin/sh
    2023-03-13T12:20:26.638037  #
    2023-03-13T12:20:26.739542  / # export SHELL=3D/bin/sh. /lava-151465/en=
vironment
    2023-03-13T12:20:26.740024  =

    2023-03-13T12:20:26.841535  / # . /lava-151465/environment/lava-151465/=
bin/lava-test-runner /lava-151465/1
    2023-03-13T12:20:26.842346  =

    2023-03-13T12:20:26.846953  / # /lava-151465/bin/lava-test-runner /lava=
-151465/1
    2023-03-13T12:20:26.943156  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
beaglebone-black          | arm    | lab-cip         | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/640f196011c92f81b48c862f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/640f196011c92f81b48c8636
        failing since 58 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-13T12:38:34.623629  <8>[   15.539424] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 874203_1.5.2.4.1>
    2023-03-13T12:38:34.732111  / # #
    2023-03-13T12:38:34.833659  export SHELL=3D/bin/sh
    2023-03-13T12:38:34.834244  #
    2023-03-13T12:38:34.935597  / # export SHELL=3D/bin/sh. /lava-874203/en=
vironment
    2023-03-13T12:38:34.936015  =

    2023-03-13T12:38:35.037207  / # . /lava-874203/environment/lava-874203/=
bin/lava-test-runner /lava-874203/1
    2023-03-13T12:38:35.037923  =

    2023-03-13T12:38:35.044300  / # /lava-874203/bin/lava-test-runner /lava=
-874203/1
    2023-03-13T12:38:35.137286  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
beaglebone-black          | arm    | lab-broonie     | gcc-10   | omap2plus=
_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/640f12c1dc847951ad8c8650

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/640f12c1dc847951ad8c8659
        failing since 58 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-13T12:10:26.767010  <8>[   19.150031] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 151426_1.5.2.4.1>
    2023-03-13T12:10:26.874686  / # #
    2023-03-13T12:10:26.976922  export SHELL=3D/bin/sh
    2023-03-13T12:10:26.977449  #
    2023-03-13T12:10:27.079405  / # export SHELL=3D/bin/sh. /lava-151426/en=
vironment
    2023-03-13T12:10:27.079870  =

    2023-03-13T12:10:27.181915  / # . /lava-151426/environment/lava-151426/=
bin/lava-test-runner /lava-151426/1
    2023-03-13T12:10:27.183004  =

    2023-03-13T12:10:27.187323  / # /lava-151426/bin/lava-test-runner /lava=
-151426/1
    2023-03-13T12:10:27.290343  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
beaglebone-black          | arm    | lab-cip         | gcc-10   | omap2plus=
_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/640f1744ab12e4d6528c863a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/640f1744ab12e4d6528c8641
        failing since 58 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-13T12:29:40.047896  <8>[   13.044221] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 874180_1.5.2.4.1>
    2023-03-13T12:29:40.159037  / # #
    2023-03-13T12:29:40.261803  export SHELL=3D/bin/sh
    2023-03-13T12:29:40.262562  #
    2023-03-13T12:29:40.364455  / # export SHELL=3D/bin/sh. /lava-874180/en=
vironment
    2023-03-13T12:29:40.365223  =

    2023-03-13T12:29:40.467199  / # . /lava-874180/environment/lava-874180/=
bin/lava-test-runner /lava-874180/1
    2023-03-13T12:29:40.468490  =

    2023-03-13T12:29:40.475377  / # /lava-874180/bin/lava-test-runner /lava=
-874180/1
    2023-03-13T12:29:40.580852  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
fsl-ls1028a-rdb           | arm64  | lab-nxp         | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/640f1722e83ae316628c8664

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1028a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1028a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/640f1722e83ae316628c866b
        new failure (last pass: v5.10.155-cip21)

    2023-03-13T12:29:09.166784  [   22.448034] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1171328_1.5.2.4.1>
    2023-03-13T12:29:09.274485  / # #
    2023-03-13T12:29:09.376551  export SHELL=3D/bin/sh
    2023-03-13T12:29:09.377045  #
    2023-03-13T12:29:09.478408  / # export SHELL=3D/bin/sh. /lava-1171328/e=
nvironment
    2023-03-13T12:29:09.478861  =

    2023-03-13T12:29:09.580251  / # . /lava-1171328/environment/lava-117132=
8/bin/lava-test-runner /lava-1171328/1
    2023-03-13T12:29:09.580989  =

    2023-03-13T12:29:09.582995  / # /lava-1171328/bin/lava-test-runner /lav=
a-1171328/1
    2023-03-13T12:29:09.603351  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
fsl-ls1088a-rdb           | arm64  | lab-nxp         | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/640f17ad6fd5b03df08c8695

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1088a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/640f17ad6fd5b03df08c869c
        failing since 58 days (last pass: v5.10.155-cip21, first fail: v5.1=
0.162-cip24)

    2023-03-13T12:31:23.429144  + [   15.311027] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 1171327_1.5.2.4.1>
    2023-03-13T12:31:23.429454  set +x
    2023-03-13T12:31:23.535477  / # #
    2023-03-13T12:31:23.637454  export SHELL=3D/bin/sh
    2023-03-13T12:31:23.637943  #
    2023-03-13T12:31:23.739318  / # export SHELL=3D/bin/sh. /lava-1171327/e=
nvironment
    2023-03-13T12:31:23.739773  =

    2023-03-13T12:31:23.841173  / # . /lava-1171327/environment/lava-117132=
7/bin/lava-test-runner /lava-1171327/1
    2023-03-13T12:31:23.841932  =

    2023-03-13T12:31:23.843901  / # /lava-1171327/bin/lava-test-runner /lav=
a-1171327/1 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6q-sabrelite           | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/640f150eaaaa837e4f8c863e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/640f150eaaaa837e4f8c8647
        failing since 58 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-13T12:20:24.683790  / # #

    2023-03-13T12:20:24.786521  export SHELL=3D/bin/sh

    2023-03-13T12:20:24.787366  #

    2023-03-13T12:20:24.889618  / # export SHELL=3D/bin/sh. /lava-9584110/e=
nvironment

    2023-03-13T12:20:24.890436  =


    2023-03-13T12:20:24.992592  / # . /lava-9584110/environment/lava-958411=
0/bin/lava-test-runner /lava-9584110/1

    2023-03-13T12:20:24.993821  =


    2023-03-13T12:20:25.006173  / # /lava-9584110/bin/lava-test-runner /lav=
a-9584110/1

    2023-03-13T12:20:25.110119  + export 'TESTRUN_ID=3D1_bootrr'

    2023-03-13T12:20:25.110666  + cd /lava-9584110/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | imx_v6_v7=
_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/640f1200572365831b8c865f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandb=
oard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandb=
oard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/640f1200572365831b8c8668
        failing since 58 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-13T12:07:04.098059  + set +x
    2023-03-13T12:07:04.098317  [   11.832897] <LAVA_SIGNAL_ENDRUN 0_dmesg =
919766_1.5.2.3.1>
    2023-03-13T12:07:04.207372  / # #
    2023-03-13T12:07:04.308969  export SHELL=3D/bin/sh
    2023-03-13T12:07:04.309486  #
    2023-03-13T12:07:04.410845  / # export SHELL=3D/bin/sh. /lava-919766/en=
vironment
    2023-03-13T12:07:04.411349  =

    2023-03-13T12:07:04.512661  / # . /lava-919766/environment/lava-919766/=
bin/lava-test-runner /lava-919766/1
    2023-03-13T12:07:04.513273  =

    2023-03-13T12:07:04.516402  / # /lava-919766/bin/lava-test-runner /lava=
-919766/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/640f14f813191cc1cd8c8643

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandbo=
ard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandbo=
ard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/640f14f913191cc1cd8c864c
        failing since 58 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-13T12:19:46.497497  + set[    7.249871] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 919772_1.5.2.3.1>
    2023-03-13T12:19:46.497669   +x
    2023-03-13T12:19:46.603482  / # #
    2023-03-13T12:19:46.705093  export SHELL=3D/bin/sh
    2023-03-13T12:19:46.705599  #
    2023-03-13T12:19:46.806843  / # export SHELL=3D/bin/sh. /lava-919772/en=
vironment
    2023-03-13T12:19:46.807371  =

    2023-03-13T12:19:46.908704  / # . /lava-919772/environment/lava-919772/=
bin/lava-test-runner /lava-919772/1
    2023-03-13T12:19:46.909333  =

    2023-03-13T12:19:46.911758  / # /lava-919772/bin/lava-test-runner /lava=
-919772/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx7d-sdb                 | arm    | lab-nxp         | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/640f1534f4cbacfde58c86ab

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/640f1534f4cbacfde58c86b2
        failing since 58 days (last pass: v5.10.155-cip21, first fail: v5.1=
0.162-cip24)

    2023-03-13T12:20:37.286923  + set<8>[   17.167673] <LAVA_SIGNAL_ENDRUN =
0_dmesg 1171316_1.5.2.4.1>
    2023-03-13T12:20:37.287069   +x
    2023-03-13T12:20:37.391981  / # #
    2023-03-13T12:20:38.552087  export SHELL=3D/bin/sh
    2023-03-13T12:20:38.557767  #
    2023-03-13T12:20:40.105650  / # export SHELL=3D/bin/sh. /lava-1171316/e=
nvironment
    2023-03-13T12:20:40.111344  =

    2023-03-13T12:20:42.934072  / # . /lava-1171316/environment/lava-117131=
6/bin/lava-test-runner /lava-1171316/1
    2023-03-13T12:20:42.940139  =

    2023-03-13T12:20:42.944697  / # /lava-1171316/bin/lava-test-runner /lav=
a-1171316/1 =

    ... (20 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx7ulp-evk               | arm    | lab-nxp         | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/640f1545df61e480628c8632

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7ulp-evk.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7ulp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/640f1545df61e480628c8639
        new failure (last pass: v5.10.155-cip21)

    2023-03-13T12:21:07.410496  + set +x<8>[   28.977438] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 1171315_1.5.2.4.1>
    2023-03-13T12:21:07.410802  =

    2023-03-13T12:21:07.519527  / # #
    2023-03-13T12:21:08.679423  export SHELL=3D/bin/sh
    2023-03-13T12:21:08.685108  #
    2023-03-13T12:21:08.685426  / # export SHELL=3D/bin/sh
    2023-03-13T12:21:10.232916  / # . /lava-1171315/environment
    2023-03-13T12:21:13.060125  /lava-1171315/bin/lava-test-runner /lava-11=
71315/1
    2023-03-13T12:21:13.066232  . /lava-1171315/environment
    2023-03-13T12:21:13.066527  / # /lava-1171315/bin/lava-test-runner /lav=
a-1171315/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
mt8173-elm-hana           | arm64  | lab-collabora   | gcc-10   | defconfig=
+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/640f17dfc5e8e017798c8663

  Results:     28 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt817=
3-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt817=
3-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/640f17dfc5e8e017798c8683
        failing since 58 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-13T12:32:20.452561  <8>[   15.683569] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-03-13T12:32:20.454185  + set +x

    2023-03-13T12:32:20.460353  <8>[   15.692986] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9584476_1.5.2.3.1>

    2023-03-13T12:32:20.566415  =


    2023-03-13T12:32:20.668718  / # #export SHELL=3D/bin/sh

    2023-03-13T12:32:20.669569  =


    2023-03-13T12:32:20.771372  / # export SHELL=3D/bin/sh. /lava-9584476/e=
nvironment

    2023-03-13T12:32:20.772293  =


    2023-03-13T12:32:20.874343  / # . /lava-9584476/environment/lava-958447=
6/bin/lava-test-runner /lava-9584476/1

    2023-03-13T12:32:20.875692  =

 =

    ... (17 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
qemu_x86_64-uefi          | x86_64 | lab-broonie     | gcc-10   | x86_64_de=
fconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/640f18722ea0d3552c8c8636

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/x86_64/x86_64_defconfig/gcc-10/lab-broonie/baseline-qemu_x86_64-uefi=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/x86_64/x86_64_defconfig/gcc-10/lab-broonie/baseline-qemu_x86_64-uefi=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640f18722ea0d3552c8c8=
637
        failing since 17 days (last pass: v5.10.167-cip26, first fail: v5.1=
0.167-cip26-2-g1e87e7748b91) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
qemu_x86_64-uefi          | x86_64 | lab-broonie     | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/640f1d495931b6f60f8c863c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-broonie/baseline-q=
emu_x86_64-uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-broonie/baseline-q=
emu_x86_64-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640f1d495931b6f60f8c8=
63d
        failing since 17 days (last pass: v5.10.167-cip26, first fail: v5.1=
0.167-cip26-2-g1e87e7748b91) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
qemu_x86_64-uefi-mixed    | x86_64 | lab-broonie     | gcc-10   | x86_64_de=
fconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/640f18d4c582af69dc8c8641

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/x86_64/x86_64_defconfig/gcc-10/lab-broonie/baseline-qemu_x86_64-uefi=
-mixed.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/x86_64/x86_64_defconfig/gcc-10/lab-broonie/baseline-qemu_x86_64-uefi=
-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640f18d4c582af69dc8c8=
642
        failing since 17 days (last pass: v5.10.165-cip25, first fail: v5.1=
0.167-cip26-2-g1e87e7748b91) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
qemu_x86_64-uefi-mixed    | x86_64 | lab-broonie     | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/640f1d5dedf36c78088c8685

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-broonie/baseline-q=
emu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-broonie/baseline-q=
emu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640f1d5dedf36c78088c8=
686
        failing since 17 days (last pass: v5.10.167-cip26, first fail: v5.1=
0.167-cip26-2-g1e87e7748b91) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
qemu_x86_64-uefi-mixed    | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/640f12b7dc847951ad8c8635

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/x86_64/x86_64_defconfig/gcc-10/lab-collabora/baseline-qemu_x86_64-ue=
fi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/x86_64/x86_64_defconfig/gcc-10/lab-collabora/baseline-qemu_x86_64-ue=
fi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640f12b7dc847951ad8c8=
636
        failing since 17 days (last pass: v5.10.165-cip25, first fail: v5.1=
0.167-cip26-2-g1e87e7748b91) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
r8a7743-iwg20d-q7         | arm    | lab-cip         | gcc-10   | shmobile_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/640f14d2629c5a99248c8644

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640f14d2629c5a99248c8=
645
        failing since 17 days (last pass: v5.10.167-cip26-2-g1e87e7748b91, =
first fail: v5.10.168-cip27) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
rk3288-veyron-jaq         | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 4          =


  Details:     https://kernelci.org/test/plan/id/640f1522f4cbacfde58c863d

  Results:     63 PASS, 8 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-j=
aq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-j=
aq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-i2c-present: https://kernelci.or=
g/test/case/id/640f1522f4cbacfde58c8670
        failing since 56 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-13T12:20:23.194298  FIRST,<8>[   19.280332] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>

    2023-03-13T12:20:23.195726   INC default to 1.

    2023-03-13T12:20:23.195958  =


    2023-03-13T12:20:23.199098  	-w	Pad to last with leading zeros

    2023-03-13T12:20:23.201945  	-s SEP	String separator

    2023-03-13T12:20:23.205735  /lava-9584107/1/../bin/lava-test-case

    2023-03-13T12:20:23.211465  BusyBox v1.31.1 (2023-03-03 12:54:59 UTC) m=
ulti-call binary.

    2023-03-13T12:20:23.211921  =


    2023-03-13T12:20:23.222073  Usage<8>[   19.309360] <LAVA_SIGNAL_TESTCAS=
E TEST_CASE_ID=3Ddwhdmi-rockchip-driver-i2c-present RESULT=3Dfail>
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/640f1522f4cbacfde58c8671
        failing since 56 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-13T12:20:23.171919  BusyBox v1.31.1 (2023-03-03 12:54:59 UTC)<8=
>[   19.261605] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-03-13T12:20:23.173121   multi-call binary.

    2023-03-13T12:20:23.173592  =


    2023-03-13T12:20:23.177950  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-03-13T12:20:23.178449  =


    2023-03-13T12:20:23.182951  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/640f1522f4cbacfde58c8672
        failing since 56 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-13T12:20:23.154074  =

   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/640f1522f4cbacfde58c8686
        failing since 56 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-13T12:20:11.108081  + <8>[    7.201298] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 9584107_1.5.2.3.1>

    2023-03-13T12:20:11.108288  set +x

    2023-03-13T12:20:11.214926  #

    2023-03-13T12:20:11.318201  / # #export SHELL=3D/bin/sh

    2023-03-13T12:20:11.319186  =


    2023-03-13T12:20:11.421142  / # export SHELL=3D/bin/sh. /lava-9584107/e=
nvironment

    2023-03-13T12:20:11.421837  =


    2023-03-13T12:20:11.523895  / # . /lava-9584107/environment/lava-958410=
7/bin/lava-test-runner /lava-9584107/1

    2023-03-13T12:20:11.525111  =


    2023-03-13T12:20:11.526972  / # /lava-9584107/bin/lava-test-runner /lav=
a-9584107/1
 =

    ... (19 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora   | gcc-10   | defconfig=
+arm64-chromebook   | 5          =


  Details:     https://kernelci.org/test/plan/id/640f182eecb872b3078c864a

  Results:     86 PASS, 6 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk339=
9-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk339=
9-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/case/id=
/640f182fecb872b3078c8670
        failing since 349 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81,=
 first fail: v5.10.106-cip4)

    2023-03-13T12:33:32.734432  /lava-9584464/1/../bin/lava-test-case
   =


  * baseline.bootrr.rk3399-gru-sound-driver-rt5514-present: https://kernelc=
i.org/test/case/id/640f182fecb872b3078c8685
        failing since 58 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-13T12:33:31.004974  BusyBox v1.31.1 (2023-03-03 <8>[   32.05647=
2] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Drk3399-gru-sound-driver-max98357A-p=
resent RESULT=3Dfail>

    2023-03-13T12:33:31.016381  12:31:33 UTC) multi-call binary.

    2023-03-13T12:33:31.016907  =


    2023-03-13T12:33:31.020641  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-03-13T12:33:31.021433  =


    2023-03-13T12:33:31.035555  Print numbers from FIRST to LAST, in steps =
of<8>[   32.090740] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Drk3399-gru-sound-d=
river-rt5514-present RESULT=3Dfail>
   =


  * baseline.bootrr.rk3399-gru-sound-driver-max98357A-present: https://kern=
elci.org/test/case/id/640f182fecb872b3078c8686
        failing since 58 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-13T12:33:30.972967  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-03-13T12:33:30.973416  =


    2023-03-13T12:33:30.978057  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-03-13T12:33:30.980413  FIRST, INC default to 1.

    2023-03-13T12:33:30.981166  =


    2023-03-13T12:33:30.984223  	-w	Pad to last with leading zeros

    2023-03-13T12:33:30.986902  	-s SEP	String separator

    2023-03-13T12:33:30.990141  /lava-9584464/1/../bin/lava-test-case
   =


  * baseline.bootrr.rk3399-gru-sound-driver-dp-present: https://kernelci.or=
g/test/case/id/640f182fecb872b3078c8687
        failing since 58 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-13T12:33:30.935752  ST

    2023-03-13T12:33:30.936164  =


    2023-03-13T12:33:30.939889  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-03-13T12:33:30.941822  FIRST, INC default to 1.

    2023-03-13T12:33:30.942720  =


    2023-03-13T12:33:30.945546  	-w	Pad to last with leading zeros

    2023-03-13T12:33:30.948123  	-s SEP	String separator

    2023-03-13T12:33:30.951728  /lava-9584464/1/../bin/lava-test-case

    2023-03-13T12:33:30.958159  BusyBox v1.31.1 (2023-03-03 12:31:33 UTC) m=
ulti-call binary.

    2023-03-13T12:33:30.958632  =

 =

    ... (1 line(s) more)  =


  * baseline.bootrr.rk3399-gru-sound-driver-da7219-present: https://kernelc=
i.org/test/case/id/640f182fecb872b3078c8688
        failing since 58 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-13T12:33:30.919564  BusyBox v1.31.1 (2023-03-03 12:31:33 UTC) m=
ulti-call binary.

    2023-03-13T12:33:30.920458  =


    2023-03-13T12:33:30.933668  Usage: seq [-w] [-s SEP] [FIRST [INC]] LA<8=
>[   31.985322] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Drk3399-gru-sound-drive=
r-da7219-present RESULT=3Dfail>
   =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
sun50i-a64-pine64-plus    | arm64  | lab-broonie     | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/640f17eef6b749255a8c86a6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/640f17eef6b749255a8c86af
        failing since 58 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-13T12:32:28.032117  + set +x
    2023-03-13T12:32:28.035416  <8>[   17.102996] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 151588_1.5.2.4.1>
    2023-03-13T12:32:28.147941  / # #
    2023-03-13T12:32:28.250549  export SHELL=3D/bin/sh
    2023-03-13T12:32:28.252603  #
    2023-03-13T12:32:28.356007  / # export SHELL=3D/bin/sh. /lava-151588/en=
vironment
    2023-03-13T12:32:28.357695  =

    2023-03-13T12:32:28.460329  / # . /lava-151588/environment/lava-151588/=
bin/lava-test-runner /lava-151588/1
    2023-03-13T12:32:28.462020  =

    2023-03-13T12:32:28.465429  / # /lava-151588/bin/lava-test-runner /lava=
-151588/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
tegra124-nyan-big         | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/640f16c655824b4fc38c8664

  Results:     5 PASS, 2 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-tegra124-nyan-b=
ig.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-tegra124-nyan-b=
ig.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/640f16c655824b4fc38c866d
        failing since 56 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-13T12:27:21.227704  <8>[   17.497610] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-03-13T12:27:21.229604  + set +x

    2023-03-13T12:27:21.236525  <8>[   17.508086] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9584113_1.5.2.3.1>

    2023-03-13T12:27:21.342732  #

    2023-03-13T12:27:21.446047  / # #export SHELL=3D/bin/sh

    2023-03-13T12:27:21.446877  =


    2023-03-13T12:27:21.548787  / # export SHELL=3D/bin/sh. /lava-9584113/e=
nvironment

    2023-03-13T12:27:21.549462  =


    2023-03-13T12:27:21.651304  / # . /lava-9584113/environment/lava-958411=
3/bin/lava-test-runner /lava-9584113/1

    2023-03-13T12:27:21.652562  =

 =

    ... (16 line(s) more)  =

 =20

