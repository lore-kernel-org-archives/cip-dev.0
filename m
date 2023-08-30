Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B0CC6FA8F
	for <webhook@archiver.kernel.org>; Wed, 30 Aug 2023 08:32:01 +0000 (UTC)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
 by mx.groups.io with SMTP id smtpd.web10.9542.1693384312306875459
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 30 Aug 2023 01:31:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=fm7/UpvG;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.175, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-68a3f1d8be2so4202601b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 30 Aug 2023 01:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1693384311; x=1693989111; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QAbxagA5XJJhPnEv0rkKtmDi0d72qQnkcqvXK10Avjg=;
        b=fm7/UpvGJdKG5yejq8Px/XjEAdJ6efcJVdDYpi2DYszLoD4N0ZemeZlTCGg0kpVajF
         ReXoXgGhUJTlF0syDnB3O2oi6vmLMV2jYyifeOxXJqx6cYoCuykmvPM3bEkukawwtdaR
         gShJwRut/s3xSoQAqfUYQPNIQcu+iSbtA1TjoNzAqtck7b3PvbeR/JRISl9FSmr/kKlN
         bap67DJ1SCjA6OucJaA6MgoaNVtf3ueOMclXtvzJWC+SExe94+BXD4J9++uFSjSjl7TJ
         oZQUAc9+QxRDhJbqLWYxYtAZsBzBYG7LYAVXQ92jqkRfLtZUDZOACiJbbvKwEpORVCZi
         1A9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693384311; x=1693989111;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QAbxagA5XJJhPnEv0rkKtmDi0d72qQnkcqvXK10Avjg=;
        b=NOBjc4zDJSI0TSy7NzlxlC2TALEiS8FX1aGB0auq7mJ4NqmqnnJIFkC4k7j4XNwt+b
         Or2DLhEsnoFMkBnYosEpWcht1vDsMJOPJGx3Cg2CrBQHB65d533F8ihA2w3zePpcvv+9
         riO4CiuGRQRBC0SE235defYme/MiizjHBNxm6D2MfWqso6UV7pbITtPXacD3xQxA3J75
         ub5wV/73mFnof3SRyUmgUTmEDtvRhsCE3d/Ol369qa/NmI6pU4TGUv/nGuFYC3y7ju0k
         BEKu/q9A+g6Pr+IXXyx3k2ktzlJDTXBZMOh5bMckACJ1G7zp6h+IJWHwyK693RPjS6M7
         nGgA==
X-Gm-Message-State: AOJu0YwswhOWGQVFXEXx+WY49LcGjP1Y37To4OTOh6oubna+uSSkxloJ
	e0U3C6O3DrDCVZGssir6moGn5iuzmuuIpPWB0QA=
X-Google-Smtp-Source: AGHT+IGpvVHLLXz3UwLUjAE0LhV+o/WQrTzfTc6fZQxJKQU2aEeCfMCMOiDTKtnr0H6w85urTHzc0w==
X-Received: by 2002:a05:6a21:4886:b0:14d:d9f8:83ee with SMTP id av6-20020a056a21488600b0014dd9f883eemr1901878pzc.61.1693384310084;
        Wed, 30 Aug 2023 01:31:50 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id f4-20020a17090274c400b001b891259eddsm10600789plt.197.2023.08.30.01.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 01:31:49 -0700 (PDT)
Message-ID: <64eefe75.170a0220.c2b1d.2f23@mx.google.com>
Date: Wed, 30 Aug 2023 01:31:49 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.191-cip38-2-g09e5ecd8645b
Subject: cip/linux-5.10.y-cip baseline: 111 runs,
 20 regressions (v5.10.191-cip38-2-g09e5ecd8645b)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Aug 2023 08:32:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12911

cip/linux-5.10.y-cip baseline: 111 runs, 20 regressions (v5.10.191-cip38-2-=
g09e5ecd8645b)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

bcm2836-rpi-2-b              | arm    | lab-collabora | gcc-10   | bcm2835_=
defconfig            | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =

fsl-ls1028a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =

fsl-ls1088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =

fsl-ls2088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =

fsl-lx2160a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

juno-uboot                   | arm64  | lab-broonie   | gcc-10   | cip://5.=
10.y-...64_defconfig | 1          =

juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =

mt8173-elm-hana              | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+kselftest          | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.191-cip38-2-g09e5ecd8645b/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.191-cip38-2-g09e5ecd8645b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      09e5ecd8645b66c95202559dbcf24b99bdfa5a85 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64eef0bbe9b4e4f23b286da8

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-2-g09e5ecd8645b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-2-g09e5ecd8645b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64eef0bbe9b4e4f23b286db1
        failing since 228 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-30T07:32:23.822333  + set +x

    2023-08-30T07:32:23.828512  <8>[   12.792061] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11381197_1.4.2.3.1>

    2023-08-30T07:32:23.932849  / # #

    2023-08-30T07:32:24.033460  export SHELL=3D/bin/sh

    2023-08-30T07:32:24.033674  #

    2023-08-30T07:32:24.134201  / # export SHELL=3D/bin/sh. /lava-11381197/=
environment

    2023-08-30T07:32:24.134406  =


    2023-08-30T07:32:24.234922  / # . /lava-11381197/environment/lava-11381=
197/bin/lava-test-runner /lava-11381197/1

    2023-08-30T07:32:24.235247  =


    2023-08-30T07:32:24.240776  / # /lava-11381197/bin/lava-test-runner /la=
va-11381197/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64eef085a408892c2d286d7e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-2-g09e5ecd8645b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-2-g09e5ecd8645b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64eef085a408892c2d286d83
        failing since 228 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-30T07:32:12.959812  + set<8>[   11.631302] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11381186_1.4.2.3.1>

    2023-08-30T07:32:12.960227   +x

    2023-08-30T07:32:13.065543  / # #

    2023-08-30T07:32:13.167624  export SHELL=3D/bin/sh

    2023-08-30T07:32:13.168361  #

    2023-08-30T07:32:13.270158  / # export SHELL=3D/bin/sh. /lava-11381186/=
environment

    2023-08-30T07:32:13.271062  =


    2023-08-30T07:32:13.372410  / # . /lava-11381186/environment/lava-11381=
186/bin/lava-test-runner /lava-11381186/1

    2023-08-30T07:32:13.372792  =


    2023-08-30T07:32:13.420941  / # /lava-11381186/bin/lava-test-runner /la=
va-11381186/1<4>[   12.051039] i2c_designware i2c_designware.5: timeout in =
disabling adapter
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora | gcc-10   | bcm2835_=
defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/64eee8c851c6f55448286d6c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-2-g09e5ecd8645b/arm/bcm2835_defconfig/gcc-10/lab-collabora/baseline-=
bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-2-g09e5ecd8645b/arm/bcm2835_defconfig/gcc-10/lab-collabora/baseline-=
bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64eee8c851c6f55448286d75
        failing since 35 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-08-30T07:00:39.936581  / # #

    2023-08-30T07:00:40.038852  export SHELL=3D/bin/sh

    2023-08-30T07:00:40.039563  #

    2023-08-30T07:00:40.141064  / # export SHELL=3D/bin/sh. /lava-11380804/=
environment

    2023-08-30T07:00:40.141779  =


    2023-08-30T07:00:40.243257  / # . /lava-11380804/environment/lava-11380=
804/bin/lava-test-runner /lava-11380804/1

    2023-08-30T07:00:40.244360  =


    2023-08-30T07:00:40.260855  / # /lava-11380804/bin/lava-test-runner /la=
va-11380804/1

    2023-08-30T07:00:40.324859  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-30T07:00:40.368772  + cd /lava-11380804/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64eee924741aa97c01286d6c

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-2-g09e5ecd8645b/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-=
beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-2-g09e5ecd8645b/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-=
beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64eee924741aa97c01286da3
        failing since 228 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-30T07:00:34.061291  <8>[   19.066390] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 78680_1.5.2.4.1>
    2023-08-30T07:00:34.171705  / # #
    2023-08-30T07:00:34.274731  export SHELL=3D/bin/sh
    2023-08-30T07:00:34.275479  #
    2023-08-30T07:00:34.377813  / # export SHELL=3D/bin/sh. /lava-78680/env=
ironment
    2023-08-30T07:00:34.378565  =

    2023-08-30T07:00:34.481063  / # . /lava-78680/environment/lava-78680/bi=
n/lava-test-runner /lava-78680/1
    2023-08-30T07:00:34.482139  =

    2023-08-30T07:00:34.487147  / # /lava-78680/bin/lava-test-runner /lava-=
78680/1
    2023-08-30T07:00:34.592159  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64eee90c32c5c7405a286d6c

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-2-g09e5ecd8645b/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-2-g09e5ecd8645b/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64eee90c32c5c7405a286d6f
        failing since 228 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-30T07:00:16.961275  + set +x
    2023-08-30T07:00:16.963433  <8>[   14.065343] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1002725_1.5.2.4.1>
    2023-08-30T07:00:17.072135  / # #
    2023-08-30T07:00:17.173975  export SHELL=3D/bin/sh
    2023-08-30T07:00:17.174419  #
    2023-08-30T07:00:17.275769  / # export SHELL=3D/bin/sh. /lava-1002725/e=
nvironment
    2023-08-30T07:00:17.276214  =

    2023-08-30T07:00:17.377597  / # . /lava-1002725/environment/lava-100272=
5/bin/lava-test-runner /lava-1002725/1
    2023-08-30T07:00:17.378322  =

    2023-08-30T07:00:17.380604  / # /lava-1002725/bin/lava-test-runner /lav=
a-1002725/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-ls1028a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64eef1e5d6d7890028286dd7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-2-g09e5ecd8645b/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1028a-=
rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-2-g09e5ecd8645b/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1028a-=
rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64eef1e5d6d7890028286dda
        failing since 169 days (last pass: v5.10.155-cip21, first fail: v5.=
10.173-cip28)

    2023-08-30T07:37:50.187870  [   21.319426] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1247984_1.5.2.4.1>
    2023-08-30T07:37:50.293027  =

    2023-08-30T07:37:50.394183  / # #export SHELL=3D/bin/sh
    2023-08-30T07:37:50.394584  =

    2023-08-30T07:37:50.495551  / # export SHELL=3D/bin/sh. /lava-1247984/e=
nvironment
    2023-08-30T07:37:50.495955  =

    2023-08-30T07:37:50.596928  / # . /lava-1247984/environment/lava-124798=
4/bin/lava-test-runner /lava-1247984/1
    2023-08-30T07:37:50.597598  =

    2023-08-30T07:37:50.601690  / # /lava-1247984/bin/lava-test-runner /lav=
a-1247984/1
    2023-08-30T07:37:50.620342  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-ls1088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64eef1d1d6d7890028286dc9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-2-g09e5ecd8645b/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1088a-=
rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-2-g09e5ecd8645b/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1088a-=
rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64eef1d1d6d7890028286dcc
        failing since 228 days (last pass: v5.10.155-cip21, first fail: v5.=
10.162-cip24)

    2023-08-30T07:37:43.590126  [   10.495466] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1247982_1.5.2.4.1>
    2023-08-30T07:37:43.695328  =

    2023-08-30T07:37:43.796601  / # #export SHELL=3D/bin/sh
    2023-08-30T07:37:43.797067  =

    2023-08-30T07:37:43.898044  / # export SHELL=3D/bin/sh. /lava-1247982/e=
nvironment
    2023-08-30T07:37:43.898445  =

    2023-08-30T07:37:43.999449  / # . /lava-1247982/environment/lava-124798=
2/bin/lava-test-runner /lava-1247982/1
    2023-08-30T07:37:44.000139  =

    2023-08-30T07:37:44.004211  / # /lava-1247982/bin/lava-test-runner /lav=
a-1247982/1
    2023-08-30T07:37:44.020060  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-ls2088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64eef1be623c172a45286de8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-2-g09e5ecd8645b/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-=
rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-2-g09e5ecd8645b/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-=
rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64eef1be623c172a45286deb
        failing since 48 days (last pass: v5.10.155-cip21, first fail: v5.1=
0.165-cip25)

    2023-08-30T07:37:10.841703  [    9.732448] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1247985_1.5.2.4.1>
    2023-08-30T07:37:10.947098  =

    2023-08-30T07:37:11.048404  / # #export SHELL=3D/bin/sh
    2023-08-30T07:37:11.048803  =

    2023-08-30T07:37:11.149783  / # export SHELL=3D/bin/sh. /lava-1247985/e=
nvironment
    2023-08-30T07:37:11.150270  =

    2023-08-30T07:37:11.251314  / # . /lava-1247985/environment/lava-124798=
5/bin/lava-test-runner /lava-1247985/1
    2023-08-30T07:37:11.251976  =

    2023-08-30T07:37:11.255983  / # /lava-1247985/bin/lava-test-runner /lav=
a-1247985/1
    2023-08-30T07:37:11.273102  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-lx2160a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64eef1d56edb36b684286d73

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-2-g09e5ecd8645b/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-=
rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-2-g09e5ecd8645b/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-=
rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64eef1d56edb36b684286d76
        failing since 161 days (last pass: v5.10.154-cip20, first fail: v5.=
10.175-cip29)

    2023-08-30T07:37:27.123778  [   15.386835] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1247983_1.5.2.4.1>
    2023-08-30T07:37:27.228644  =

    2023-08-30T07:37:27.329818  / # #export SHELL=3D/bin/sh
    2023-08-30T07:37:27.330371  =

    2023-08-30T07:37:27.431285  / # export SHELL=3D/bin/sh. /lava-1247983/e=
nvironment
    2023-08-30T07:37:27.431790  =

    2023-08-30T07:37:27.533037  / # . /lava-1247983/environment/lava-124798=
3/bin/lava-test-runner /lava-1247983/1
    2023-08-30T07:37:27.533724  =

    2023-08-30T07:37:27.536766  / # /lava-1247983/bin/lava-test-runner /lav=
a-1247983/1
    2023-08-30T07:37:27.552049  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64eef25b549f4d6c71286d7b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-2-g09e5ecd8645b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-2-g09e5ecd8645b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64eef25b549f4d6c71286d84
        failing since 137 days (last pass: v5.10.176-cip30, first fail: v5.=
10.177-cip31)

    2023-08-30T07:40:09.236838  + <8>[   10.508589] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11381216_1.4.2.3.1>

    2023-08-30T07:40:09.236923  set +x

    2023-08-30T07:40:09.338111  #

    2023-08-30T07:40:09.439026  / # #export SHELL=3D/bin/sh

    2023-08-30T07:40:09.439262  =


    2023-08-30T07:40:09.539777  / # export SHELL=3D/bin/sh. /lava-11381216/=
environment

    2023-08-30T07:40:09.539983  =


    2023-08-30T07:40:09.640510  / # . /lava-11381216/environment/lava-11381=
216/bin/lava-test-runner /lava-11381216/1

    2023-08-30T07:40:09.640817  =


    2023-08-30T07:40:09.645277  / # /lava-11381216/bin/lava-test-runner /la=
va-11381216/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64eef0863066cac56d286d6d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-2-g09e5ecd8645b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-2-g09e5ecd8645b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64eef0863066cac56d286d76
        failing since 137 days (last pass: v5.10.176-cip30, first fail: v5.=
10.177-cip31)

    2023-08-30T07:32:10.176696  <8>[   12.843842] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11381229_1.4.2.3.1>

    2023-08-30T07:32:10.180277  + set +x

    2023-08-30T07:32:10.281801  #

    2023-08-30T07:32:10.282120  =


    2023-08-30T07:32:10.382725  / # #export SHELL=3D/bin/sh

    2023-08-30T07:32:10.382940  =


    2023-08-30T07:32:10.483480  / # export SHELL=3D/bin/sh. /lava-11381229/=
environment

    2023-08-30T07:32:10.483708  =


    2023-08-30T07:32:10.584340  / # . /lava-11381229/environment/lava-11381=
229/bin/lava-test-runner /lava-11381229/1

    2023-08-30T07:32:10.585848  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | cip://5.=
10.y-...64_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/64eef1589a5f93a860286dd2

  Results:     47 PASS, 13 FAIL, 1 SKIP
  Full config: cip://5.10.y-cip/arm64/qemu_arm64_defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-2-g09e5ecd8645b/arm64/cip---5.10.y-cip-arm64-qemu_arm64_defconfig/gc=
c-10/lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-2-g09e5ecd8645b/arm64/cip---5.10.y-cip-arm64-qemu_arm64_defconfig/gc=
c-10/lab-broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64eef1589a5f93a860286e0b
        failing since 2 days (last pass: v5.10.186-cip37-27-gd6d928db0a620,=
 first fail: v5.10.191-cip38)

    2023-08-30T07:35:14.450312  / # #
    2023-08-30T07:35:14.553121  export SHELL=3D/bin/sh
    2023-08-30T07:35:14.553872  #
    2023-08-30T07:35:14.655844  / # export SHELL=3D/bin/sh. /lava-78741/env=
ironment
    2023-08-30T07:35:14.656543  =

    2023-08-30T07:35:14.758554  / # . /lava-78741/environment/lava-78741/bi=
n/lava-test-runner /lava-78741/1
    2023-08-30T07:35:14.759964  =

    2023-08-30T07:35:14.770658  / # /lava-78741/bin/lava-test-runner /lava-=
78741/1
    2023-08-30T07:35:14.829511  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-30T07:35:14.830047  + cd /lava-78741/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64eeef284913fcc63a286d7f

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-2-g09e5ecd8645b/arm64/defconfig+kselftest/gcc-10/lab-broonie/baselin=
e-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-2-g09e5ecd8645b/arm64/defconfig+kselftest/gcc-10/lab-broonie/baselin=
e-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64eeef284913fcc63a286dbf
        failing since 35 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-08-30T07:25:58.846892  / # #
    2023-08-30T07:25:58.949791  export SHELL=3D/bin/sh
    2023-08-30T07:25:58.950607  #
    2023-08-30T07:25:59.052617  / # export SHELL=3D/bin/sh. /lava-78727/env=
ironment
    2023-08-30T07:25:59.053391  =

    2023-08-30T07:25:59.155361  / # . /lava-78727/environment/lava-78727/bi=
n/lava-test-runner /lava-78727/1
    2023-08-30T07:25:59.156669  =

    2023-08-30T07:25:59.171548  / # /lava-78727/bin/lava-test-runner /lava-=
78727/1
    2023-08-30T07:25:59.351326  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-30T07:25:59.351839  + cd /lava-78727/1/tests/1_bootrr =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64eeebfb6eafcaf78c286d77

  Results:     28 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-2-g09e5ecd8645b/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabor=
a/baseline-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-2-g09e5ecd8645b/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabor=
a/baseline-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64eeebfb6eafcaf78c286d97
        failing since 228 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-30T07:12:50.689620  + set +x

    2023-08-30T07:12:50.696020  <8>[   15.614858] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11380950_1.5.2.3.1>

    2023-08-30T07:12:50.803169  / # #

    2023-08-30T07:12:50.905447  export SHELL=3D/bin/sh

    2023-08-30T07:12:50.906273  #

    2023-08-30T07:12:51.007573  / # export SHELL=3D/bin/sh. /lava-11380950/=
environment

    2023-08-30T07:12:51.008255  =


    2023-08-30T07:12:51.109722  / # . /lava-11380950/environment/lava-11380=
950/bin/lava-test-runner /lava-11380950/1

    2023-08-30T07:12:51.110912  =


    2023-08-30T07:12:51.112460  / # /lava-11380950/bin/lava-test-runner /la=
va-11380950/1
 =

    ... (20 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64eeeca8b48844773a286d83

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-2-g09e5ecd8645b/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/base=
line-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-2-g09e5ecd8645b/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/base=
line-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64eeeca8b48844773a286d86
        failing since 35 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-08-30T07:15:39.240433  + set +x
    2023-08-30T07:15:39.240655  <8>[   83.874784] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1002729_1.5.2.4.1>
    2023-08-30T07:15:39.346597  / # #
    2023-08-30T07:15:40.808643  export SHELL=3D/bin/sh
    2023-08-30T07:15:40.829222  #
    2023-08-30T07:15:40.829436  / # export SHELL=3D/bin/sh
    2023-08-30T07:15:42.785333  / # . /lava-1002729/environment
    2023-08-30T07:15:46.384192  /lava-1002729/bin/lava-test-runner /lava-10=
02729/1
    2023-08-30T07:15:46.405008  . /lava-1002729/environment
    2023-08-30T07:15:46.405122  / # /lava-1002729/bin/lava-test-runner /lav=
a-1002729/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64eeeca942af05acf8286d6c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-2-g09e5ecd8645b/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/base=
line-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-2-g09e5ecd8645b/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/base=
line-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64eeeca942af05acf8286d6f
        failing since 35 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-08-30T07:15:39.760203  / # #
    2023-08-30T07:15:41.222066  export SHELL=3D/bin/sh
    2023-08-30T07:15:41.242629  #
    2023-08-30T07:15:41.242836  / # export SHELL=3D/bin/sh
    2023-08-30T07:15:43.198174  / # . /lava-1002731/environment
    2023-08-30T07:15:46.796035  /lava-1002731/bin/lava-test-runner /lava-10=
02731/1
    2023-08-30T07:15:46.816830  . /lava-1002731/environment
    2023-08-30T07:15:46.816940  / # /lava-1002731/bin/lava-test-runner /lav=
a-1002731/1
    2023-08-30T07:15:46.896098  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-30T07:15:46.896332  + cd /lava-1002731/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64eeef3c4913fcc63a286dc3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-2-g09e5ecd8645b/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-r8=
a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-2-g09e5ecd8645b/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-r8=
a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64eeef3c4913fcc63a286dc6
        failing since 35 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-08-30T07:26:30.671905  / # #
    2023-08-30T07:26:32.139620  export SHELL=3D/bin/sh
    2023-08-30T07:26:32.160317  #
    2023-08-30T07:26:32.160526  / # export SHELL=3D/bin/sh
    2023-08-30T07:26:34.116789  / # . /lava-1002755/environment
    2023-08-30T07:26:37.716412  /lava-1002755/bin/lava-test-runner /lava-10=
02755/1
    2023-08-30T07:26:37.737313  . /lava-1002755/environment
    2023-08-30T07:26:37.737424  / # /lava-1002755/bin/lava-test-runner /lav=
a-1002755/1
    2023-08-30T07:26:37.922509  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-30T07:26:37.922731  + cd /lava-1002755/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64eef22075cdb33586286d6e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-2-g09e5ecd8645b/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek8=
74.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-2-g09e5ecd8645b/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek8=
74.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64eef22075cdb33586286d71
        failing since 35 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-08-30T07:38:53.074174  / # #
    2023-08-30T07:38:54.537216  export SHELL=3D/bin/sh
    2023-08-30T07:38:54.557795  #
    2023-08-30T07:38:54.558005  / # export SHELL=3D/bin/sh
    2023-08-30T07:38:56.514117  / # . /lava-1002762/environment
    2023-08-30T07:39:00.114875  /lava-1002762/bin/lava-test-runner /lava-10=
02762/1
    2023-08-30T07:39:00.135761  . /lava-1002762/environment
    2023-08-30T07:39:00.135874  / # /lava-1002762/bin/lava-test-runner /lav=
a-1002762/1
    2023-08-30T07:39:00.213070  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-30T07:39:00.213290  + cd /lava-1002762/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64eef186623c172a45286d6c

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-2-g09e5ecd8645b/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a=
64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-2-g09e5ecd8645b/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a=
64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64eef186623c172a45286d9c
        failing since 228 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-30T07:36:20.621127  + set +x
    2023-08-30T07:36:20.624800  <8>[   17.133136] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 78757_1.5.2.4.1>
    2023-08-30T07:36:20.736618  / # #
    2023-08-30T07:36:20.839296  export SHELL=3D/bin/sh
    2023-08-30T07:36:20.840025  #
    2023-08-30T07:36:20.942301  / # export SHELL=3D/bin/sh. /lava-78757/env=
ironment
    2023-08-30T07:36:20.943035  =

    2023-08-30T07:36:21.045454  / # . /lava-78757/environment/lava-78757/bi=
n/lava-test-runner /lava-78757/1
    2023-08-30T07:36:21.046563  =

    2023-08-30T07:36:21.051001  / # /lava-78757/bin/lava-test-runner /lava-=
78757/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64eef1745019f1dd28286dd9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-2-g09e5ecd8645b/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i=
-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-2-g09e5ecd8645b/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i=
-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64eef1745019f1dd28286de2
        failing since 35 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-08-30T07:37:43.881604  / # #

    2023-08-30T07:37:43.983784  export SHELL=3D/bin/sh

    2023-08-30T07:37:43.984506  #

    2023-08-30T07:37:44.085977  / # export SHELL=3D/bin/sh. /lava-11381289/=
environment

    2023-08-30T07:37:44.086657  =


    2023-08-30T07:37:44.188098  / # . /lava-11381289/environment/lava-11381=
289/bin/lava-test-runner /lava-11381289/1

    2023-08-30T07:37:44.189299  =


    2023-08-30T07:37:44.205659  / # /lava-11381289/bin/lava-test-runner /la=
va-11381289/1

    2023-08-30T07:37:44.253361  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-30T07:37:44.263741  + cd /lava-1138128<8>[   18.239469] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11381289_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

