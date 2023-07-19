Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C97C001B0
	for <webhook@archiver.kernel.org>; Wed, 19 Jul 2023 14:22:07 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
 by mx.groups.io with SMTP id smtpd.web10.15023.1689776525159870847
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 19 Jul 2023 07:22:05 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=dpkQo63U;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.179, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6686ef86110so4725612b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 19 Jul 2023 07:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689776524; x=1692368524;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8rE66fdzq0jdPSE07PK+xmzCODixdpftbIHO1sc3joc=;
        b=dpkQo63UdOti7R1lHXD8D6yGgzJRNnwKJlT3JI35x9BmpSuf/ejs/AAMzCyKhdBwC7
         SkYxA9lemWCw9N43dFOtbafn6Y6DHAF3T7TETfDVFsyMD7125fHEN/ac8nrno3TcYD3L
         U4JEEFx+xjSiFe3jxGa8di4BMMk+Bg43iOCYf7wH0J/UOWmgQKqpPQxEl8/+BUWF2We+
         6NHCBOI8V9RKbb9fQgMIXdaEui4tJ/POGaMekIr6Tqr7uMcPTNrQl8dHd0vmDXEdM9TS
         Z6DxLLxauM8OjOO0nfZi/CkRh2UE9VdS8bGgOjCf8monzaV/8UjMM1cB+io2rrDDR8AB
         8gZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689776524; x=1692368524;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8rE66fdzq0jdPSE07PK+xmzCODixdpftbIHO1sc3joc=;
        b=LB+4xwdW6bV/DkT2jxbkOplIoXqV609Wb73PNRNieU2LGAusWKfIYQ5ulHbNd5Ohs/
         /XNMPzdUam50+sg8ARf0KW8n7qfwUXPsJNZkOopzo9heaO9AWsS3gnCLnp7uiyy64yxG
         CIgomL3BwHR6LZdDwGxqk17JeljcuUWQZi/Sh38glLclZ5kQLc/AAr7U0pxMo83KVKaz
         82DDjyUyarJYaLORfn4Cnp62bie2jep4HRb2TWaGP3a4hU+oKpq2pC2PThM90pk/QQNk
         O2O8aXsjZsoZKoz+wkIXU6YtD1Zgu1UwuZQfBoKIZAd+UVhx2WX5FraKf6JwgeermoMM
         4+NA==
X-Gm-Message-State: ABy/qLZAa/98OdYnzQ951uZstrfOkcImTAEXVVLAgVjQsbWdtcyvZCzA
	MwqDzXLjRKsMcY7SNJmrZ2jsbm34xlQv6r9W1iVEUA==
X-Google-Smtp-Source: APBJJlFy7Zi291k5M3YpXPZ/PSHK9htzfW+FO9LM8qnFdkZa+KO0xPWIOr/1rGuci9l+1l76Z5S1RQ==
X-Received: by 2002:a05:6a00:1813:b0:668:7e84:32e6 with SMTP id y19-20020a056a00181300b006687e8432e6mr2987895pfa.29.1689776522565;
        Wed, 19 Jul 2023 07:22:02 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id n19-20020aa79053000000b00662610cf7a8sm3447057pfo.172.2023.07.19.07.22.01
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 07:22:01 -0700 (PDT)
Message-ID: <64b7f189.a70a0220.1c922.7144@mx.google.com>
Date: Wed, 19 Jul 2023 07:22:01 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v5.10.186-cip37-2-gfcd111609480
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline: 127 runs,
 71 regressions (v5.10.186-cip37-2-gfcd111609480)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Jul 2023 14:22:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12436

cip-gitlab/ci/pavel/linux-test baseline: 127 runs, 71 regressions (v5.10.18=
6-cip37-2-gfcd111609480)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cbv514-1h-34uz-brya     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

bcm2835-rpi-b-rev2           | arm    | lab-broonie     | gcc-10   | bcm283=
5_defconfig            | 1          =

bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | bcm283=
5_defconfig            | 1          =

bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 7          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig           | 7          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 2          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 2          =

fsl-ls1028a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

fsl-ls1088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

fsl-ls2088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

fsl-lx2160a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =

imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =

imx7ulp-evk                  | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =

kontron-kbox-a-230-ls        | arm64  | lab-kontron     | gcc-10   | defcon=
fig                    | 3          =

kontron-sl28-var3-ads2       | arm64  | lab-kontron     | gcc-10   | defcon=
fig                    | 3          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

mt8173-elm-hana              | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

qemu_mips-malta              | mips   | lab-broonie     | gcc-10   | malta_=
defconfig              | 1          =

qemu_mips-malta              | mips   | lab-collabora   | gcc-10   | malta_=
defconfig              | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =

r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

r8a77960-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 5          =

rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 5          =

sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =

zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.186-cip37-2-gfcd111609480/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.186-cip37-2-gfcd111609480
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      fcd111609480c664a9d1e68c5ec8c352c2312db5 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cbv514-1h-34uz-brya     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7e1ef229cd6de358ace1c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-collabora/baseline-acer-cbv514-1h-34uz-brya.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-collabora/baseline-acer-cbv514-1h-34uz-brya.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64b7e1ef229cd6de358ac=
e1d
        new failure (last pass: v6.1.38-cip1-10-g02aa22be941dd) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
bcm2835-rpi-b-rev2           | arm    | lab-broonie     | gcc-10   | bcm283=
5_defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7e3225f4e588e858ace20

  Results:     50 PASS, 2 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm/bcm2835_defconfig/gcc-10/lab-broonie/b=
aseline-bcm2835-rpi-b-rev2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm/bcm2835_defconfig/gcc-10/lab-broonie/b=
aseline-bcm2835-rpi-b-rev2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b7e3225f4e588e858ace53
        new failure (last pass: v5.10.177-cip31-33-gd59f246891e73)

    2023-07-19T13:20:12.649850  + set +x
    2023-07-19T13:20:12.653665  <8>[   18.511718] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1369_1.5.2.4.1>
    2023-07-19T13:20:12.771478  / # #
    2023-07-19T13:20:12.873636  export SHELL=3D/bin/sh
    2023-07-19T13:20:12.874299  #
    2023-07-19T13:20:12.975988  / # export SHELL=3D/bin/sh. /lava-1369/envi=
ronment
    2023-07-19T13:20:12.976584  =

    2023-07-19T13:20:13.078294  / # . /lava-1369/environment/lava-1369/bin/=
lava-test-runner /lava-1369/1
    2023-07-19T13:20:13.079346  =

    2023-07-19T13:20:13.085508  / # /lava-1369/bin/lava-test-runner /lava-1=
369/1 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | bcm283=
5_defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7e31835fe3e3c518ace31

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm/bcm2835_defconfig/gcc-10/lab-collabora=
/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm/bcm2835_defconfig/gcc-10/lab-collabora=
/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b7e31835fe3e3c518ace36
        failing since 0 day (last pass: v5.10.184-cip36-13-g8201543bbc8b6, =
first fail: v6.1.38-cip1-10-g02aa22be941dd)

    2023-07-19T13:21:43.787333  / # #

    2023-07-19T13:21:43.889358  export SHELL=3D/bin/sh

    2023-07-19T13:21:43.890076  #

    2023-07-19T13:21:43.991478  / # export SHELL=3D/bin/sh. /lava-11111967/=
environment

    2023-07-19T13:21:43.992194  =


    2023-07-19T13:21:44.093672  / # . /lava-11111967/environment/lava-11111=
967/bin/lava-test-runner /lava-11111967/1

    2023-07-19T13:21:44.094752  =


    2023-07-19T13:21:44.111812  / # /lava-11111967/bin/lava-test-runner /la=
va-11111967/1

    2023-07-19T13:21:44.175790  + export 'TESTRUN_ID=3D1_bootrr'

    2023-07-19T13:21:44.219731  + cd /lava-11111967/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7e070bab19fa7428ace2f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm/multi_v7_defconfig/gcc-10/lab-collabor=
a/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm/multi_v7_defconfig/gcc-10/lab-collabor=
a/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64b7e070bab19fa7428ac=
e30
        failing since 35 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 7          =


  Details:     https://kernelci.org/test/plan/id/64b7e0638eb554af698ace2a

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm/multi_v7_defconfig/gcc-10/lab-broonie/=
baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm/multi_v7_defconfig/gcc-10/lab-broonie/=
baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.hdmi-audio: https://kernelci.org/test/case/id/64b7e0648=
eb554af698ace2d
        new failure (last pass: v6.1.38-cip1-10-g02aa22be941dd)

    2023-07-19T13:08:44.807944  /lava-1323/1/../bin/lava-test-case
    2023-07-19T13:08:44.842011  <8>[   46.788996] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/id/64=
b7e0648eb554af698ace2e
        new failure (last pass: v6.1.38-cip1-10-g02aa22be941dd)

    2023-07-19T13:08:43.747409  /lava-1323/1/../bin/lava-test-case
    2023-07-19T13:08:43.782634  <8>[   45.728917] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-codec-driver-present: https://kernelci.org/test/ca=
se/id/64b7e0648eb554af698ace30
        new failure (last pass: v6.1.38-cip1-10-g02aa22be941dd)

    2023-07-19T13:08:41.577045  /lava-1323/1/../bin/lava-test-case
    2023-07-19T13:08:41.612147  <8>[   43.558593] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-07-19T13:08:42.639263  /lava-1323/1/../bin/lava-test-case
    2023-07-19T13:08:42.675903  <8>[   44.619408] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case/id/=
64b7e0648eb554af698ace31
        new failure (last pass: v6.1.38-cip1-10-g02aa22be941dd)

    2023-07-19T13:08:39.451000  /lava-1323/1/../bin/lava-test-case
    2023-07-19T13:08:39.484415  <8>[   41.430524] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-07-19T13:08:40.510651  /lava-1323/1/../bin/lava-test-case
    2023-07-19T13:08:40.550527  <8>[   42.496527] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline.bootrr.tda19988-driver-present: https://kernelci.org/test/case=
/id/64b7e0648eb554af698ace32
        new failure (last pass: v6.1.38-cip1-10-g02aa22be941dd)

    2023-07-19T13:08:37.328521  /lava-1323/1/../bin/lava-test-case
    2023-07-19T13:08:37.362655  <8>[   39.309065] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-07-19T13:08:38.389100  /lava-1323/1/../bin/lava-test-case
    2023-07-19T13:08:38.424795  <8>[   40.370261] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/64b7e0648eb554af698ace3d
        new failure (last pass: v6.1.38-cip1-10-g02aa22be941dd)

    2023-07-19T13:08:25.403218  /lava-1323/1/../bin/lava-test-case
    2023-07-19T13:08:25.441753  <8>[   27.385974] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b7e0648eb554af698ace56
        new failure (last pass: v6.1.38-cip1-10-g02aa22be941dd)

    2023-07-19T13:08:19.640187  <8>[   21.586248] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1323_1.5.2.4.1>
    2023-07-19T13:08:19.751322  / # #
    2023-07-19T13:08:19.854789  export SHELL=3D/bin/sh
    2023-07-19T13:08:19.855427  #
    2023-07-19T13:08:19.956881  / # export SHELL=3D/bin/sh. /lava-1323/envi=
ronment
    2023-07-19T13:08:19.957543  =

    2023-07-19T13:08:20.059250  / # . /lava-1323/environment/lava-1323/bin/=
lava-test-runner /lava-1323/1
    2023-07-19T13:08:20.060246  =

    2023-07-19T13:08:20.064568  / # /lava-1323/bin/lava-test-runner /lava-1=
323/1
    2023-07-19T13:08:20.157973  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig           | 7          =


  Details:     https://kernelci.org/test/plan/id/64b7e211229cd6de358ace2d

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm/multi_v7_defconfig/gcc-10/lab-cip/base=
line-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm/multi_v7_defconfig/gcc-10/lab-cip/base=
line-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b7e211229cd6de358ace30
        new failure (last pass: v6.1.38-cip1-10-g02aa22be941dd)

    2023-07-19T13:15:32.861634  + set +x
    2023-07-19T13:15:32.863603  <8>[   16.697778] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 987479_1.5.2.4.1>
    2023-07-19T13:15:32.972411  / # #
    2023-07-19T13:15:33.074287  export SHELL=3D/bin/sh
    2023-07-19T13:15:33.074733  #
    2023-07-19T13:15:33.176151  / # export SHELL=3D/bin/sh. /lava-987479/en=
vironment
    2023-07-19T13:15:33.176646  =

    2023-07-19T13:15:33.278113  / # . /lava-987479/environment/lava-987479/=
bin/lava-test-runner /lava-987479/1
    2023-07-19T13:15:33.279027  =

    2023-07-19T13:15:33.281130  / # /lava-987479/bin/lava-test-runner /lava=
-987479/1 =

    ... (12 line(s) more)  =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/64b7e211229cd6de358ace49
        new failure (last pass: v6.1.38-cip1-10-g02aa22be941dd)

    2023-07-19T13:15:38.614774  /lava-987479/1/../bin/lava-test-case
    2023-07-19T13:15:38.653353  <8>[   22.485685] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.tda19988-driver-present: https://kernelci.org/test/case=
/id/64b7e211229cd6de358ace55
        new failure (last pass: v6.1.38-cip1-10-g02aa22be941dd)

    2023-07-19T13:15:50.549174  /lava-987479/1/../bin/lava-test-case
    2023-07-19T13:15:50.583817  <8>[   34.417592] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-07-19T13:15:51.610638  /lava-987479/1/../bin/lava-test-case
    2023-07-19T13:15:51.645668  <8>[   35.478788] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case/id/=
64b7e211229cd6de358ace56
        new failure (last pass: v6.1.38-cip1-10-g02aa22be941dd)

    2023-07-19T13:15:52.672695  /lava-987479/1/../bin/lava-test-case
    2023-07-19T13:15:52.711551  <8>[   36.545226] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-07-19T13:15:53.738447  /lava-987479/1/../bin/lava-test-case
    2023-07-19T13:15:53.774255  <8>[   37.607881] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-codec-driver-present: https://kernelci.org/test/ca=
se/id/64b7e211229cd6de358ace57
        new failure (last pass: v6.1.38-cip1-10-g02aa22be941dd)

    2023-07-19T13:15:54.801935  /lava-987479/1/../bin/lava-test-case
    2023-07-19T13:15:54.835934  <8>[   38.669783] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-07-19T13:15:55.862461  /lava-987479/1/../bin/lava-test-case
    2023-07-19T13:15:55.902284  <8>[   39.735458] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/id/64=
b7e211229cd6de358ace59
        new failure (last pass: v6.1.38-cip1-10-g02aa22be941dd)

    2023-07-19T13:15:56.975956  /lava-987479/1/../bin/lava-test-case
    2023-07-19T13:15:57.012776  <8>[   40.846650] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-audio: https://kernelci.org/test/case/id/64b7e2112=
29cd6de358ace5a
        new failure (last pass: v6.1.38-cip1-10-g02aa22be941dd)

    2023-07-19T13:15:58.038334  /lava-987479/1/../bin/lava-test-case
    2023-07-19T13:15:58.073452  <8>[   41.908076] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 2          =


  Details:     https://kernelci.org/test/plan/id/64b7df4a7a8cd572138ace79

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm/omap2plus_defconfig/gcc-10/lab-broonie=
/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm/omap2plus_defconfig/gcc-10/lab-broonie=
/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/id/6=
4b7df4a7a8cd572138ace94
        new failure (last pass: v6.1.38-cip1-10-g02aa22be941dd)

    2023-07-19T13:03:58.097397  /lava-1303/1/../bin/lava-test-case
    2023-07-19T13:03:58.136542  <8>[   23.415024] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b7df4b7a8cd572138aceaf
        failing since 34 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-07-19T13:03:54.194265  + set +x
    2023-07-19T13:03:54.197103  <8>[   19.477866] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1303_1.5.2.4.1>
    2023-07-19T13:03:54.306726  / # #
    2023-07-19T13:03:54.408699  export SHELL=3D/bin/sh
    2023-07-19T13:03:54.409254  #
    2023-07-19T13:03:54.510574  / # export SHELL=3D/bin/sh. /lava-1303/envi=
ronment
    2023-07-19T13:03:54.511109  =

    2023-07-19T13:03:54.612423  / # . /lava-1303/environment/lava-1303/bin/=
lava-test-runner /lava-1303/1
    2023-07-19T13:03:54.613285  =

    2023-07-19T13:03:54.616852  / # /lava-1303/bin/lava-test-runner /lava-1=
303/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 2          =


  Details:     https://kernelci.org/test/plan/id/64b7df2d7a8cd572138ace31

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm/omap2plus_defconfig/gcc-10/lab-cip/bas=
eline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm/omap2plus_defconfig/gcc-10/lab-cip/bas=
eline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b7df2d7a8cd572138ace34
        failing since 34 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-07-19T13:03:29.387378  + set +x
    2023-07-19T13:03:29.389389  <8>[   13.975207] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 987445_1.5.2.4.1>
    2023-07-19T13:03:29.497792  / # #
    2023-07-19T13:03:29.599668  export SHELL=3D/bin/sh
    2023-07-19T13:03:29.600150  #
    2023-07-19T13:03:29.701526  / # export SHELL=3D/bin/sh. /lava-987445/en=
vironment
    2023-07-19T13:03:29.701976  =

    2023-07-19T13:03:29.803446  / # . /lava-987445/environment/lava-987445/=
bin/lava-test-runner /lava-987445/1
    2023-07-19T13:03:29.804295  =

    2023-07-19T13:03:29.806446  / # /lava-987445/bin/lava-test-runner /lava=
-987445/1 =

    ... (12 line(s) more)  =


  * baseline.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/id/6=
4b7df2d7a8cd572138ace4f
        new failure (last pass: v6.1.38-cip1-10-g02aa22be941dd)

    2023-07-19T13:03:33.282627  /lava-987445/1/../bin/lava-test-case
    2023-07-19T13:03:33.320805  <8>[   17.905421] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls1028a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7e98d59647424f98aceb2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm64/defconfig/gcc-10/lab-nxp/baseline-fs=
l-ls1028a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm64/defconfig/gcc-10/lab-nxp/baseline-fs=
l-ls1028a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b7e98d59647424f98aceb5
        new failure (last pass: v6.1.26-1314-g1ab0ac1d7e2e3)

    2023-07-19T13:47:36.362968  + [   20.274533] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 1237600_1.5.2.4.1>
    2023-07-19T13:47:36.363278  set +x
    2023-07-19T13:47:36.468502  =

    2023-07-19T13:47:36.569721  / # #export SHELL=3D/bin/sh
    2023-07-19T13:47:36.570134  =

    2023-07-19T13:47:36.671101  / # export SHELL=3D/bin/sh. /lava-1237600/e=
nvironment
    2023-07-19T13:47:36.671535  =

    2023-07-19T13:47:36.772521  / # . /lava-1237600/environment/lava-123760=
0/bin/lava-test-runner /lava-1237600/1
    2023-07-19T13:47:36.773157  =

    2023-07-19T13:47:36.777146  / # /lava-1237600/bin/lava-test-runner /lav=
a-1237600/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls1088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7e991db7b29fa908ace23

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm64/defconfig/gcc-10/lab-nxp/baseline-fs=
l-ls1088a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm64/defconfig/gcc-10/lab-nxp/baseline-fs=
l-ls1088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b7e991db7b29fa908ace26
        failing since 45 days (last pass: v4.19.280-cip95-rt30, first fail:=
 v6.1.26-1281-g84d5372e0f31)

    2023-07-19T13:47:41.118409  + [    9.964175] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 1237601_1.5.2.4.1>
    2023-07-19T13:47:41.118699  set +x
    2023-07-19T13:47:41.223801  =

    2023-07-19T13:47:41.324978  / # #export SHELL=3D/bin/sh
    2023-07-19T13:47:41.325484  =

    2023-07-19T13:47:41.426479  / # export SHELL=3D/bin/sh. /lava-1237601/e=
nvironment
    2023-07-19T13:47:41.426883  =

    2023-07-19T13:47:41.527908  / # . /lava-1237601/environment/lava-123760=
1/bin/lava-test-runner /lava-1237601/1
    2023-07-19T13:47:41.528682  =

    2023-07-19T13:47:41.532731  / # /lava-1237601/bin/lava-test-runner /lav=
a-1237601/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls2088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7e9932d8a54e5ce8ace2d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm64/defconfig/gcc-10/lab-nxp/baseline-fs=
l-ls2088a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm64/defconfig/gcc-10/lab-nxp/baseline-fs=
l-ls2088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b7e9932d8a54e5ce8ace30
        new failure (last pass: v4.19.269-cip88-rt28-rebase)

    2023-07-19T13:47:33.595029  [   16.076288] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1237602_1.5.2.4.1>
    2023-07-19T13:47:33.700639  =

    2023-07-19T13:47:33.801839  / # #export SHELL=3D/bin/sh
    2023-07-19T13:47:33.802332  =

    2023-07-19T13:47:33.903314  / # export SHELL=3D/bin/sh. /lava-1237602/e=
nvironment
    2023-07-19T13:47:33.903727  =

    2023-07-19T13:47:34.004702  / # . /lava-1237602/environment/lava-123760=
2/bin/lava-test-runner /lava-1237602/1
    2023-07-19T13:47:34.005416  =

    2023-07-19T13:47:34.008479  / # /lava-1237602/bin/lava-test-runner /lav=
a-1237602/1
    2023-07-19T13:47:34.030630  + export 'TESTRUN_[   16.511348] <LAVA_SIGN=
AL_STARTRUN 1_bootrr 1237602_1.5.2.4.5> =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-lx2160a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7e98a59647424f98ace9c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm64/defconfig/gcc-10/lab-nxp/baseline-fs=
l-lx2160a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm64/defconfig/gcc-10/lab-nxp/baseline-fs=
l-lx2160a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b7e98a59647424f98ace9f
        failing since 89 days (last pass: v5.10.145-rt74-1329-ga59fc50f38f6=
, first fail: v5.10.177-cip31-33-gd59f246891e73)

    2023-07-19T13:47:43.945760  [   11.400438] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1237599_1.5.2.4.1>
    2023-07-19T13:47:44.050913  =

    2023-07-19T13:47:44.152111  / # #export SHELL=3D/bin/sh
    2023-07-19T13:47:44.152597  =

    2023-07-19T13:47:44.253744  / # export SHELL=3D/bin/sh. /lava-1237599/e=
nvironment
    2023-07-19T13:47:44.254323  =

    2023-07-19T13:47:44.355492  / # . /lava-1237599/environment/lava-123759=
9/bin/lava-test-runner /lava-1237599/1
    2023-07-19T13:47:44.356261  =

    2023-07-19T13:47:44.360179  / # /lava-1237599/bin/lava-test-runner /lav=
a-1237599/1
    2023-07-19T13:47:44.375958  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7e2f835fe3e3c518ace1c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b7e2f835fe3e3c518ace21
        failing since 35 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-07-19T13:19:50.001103  + set +x

    2023-07-19T13:19:50.007950  <8>[   14.376144] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11111939_1.4.2.3.1>

    2023-07-19T13:19:50.116317  / # #

    2023-07-19T13:19:50.219353  export SHELL=3D/bin/sh

    2023-07-19T13:19:50.220176  #

    2023-07-19T13:19:50.321655  / # export SHELL=3D/bin/sh. /lava-11111939/=
environment

    2023-07-19T13:19:50.322506  =


    2023-07-19T13:19:50.424220  / # . /lava-11111939/environment/lava-11111=
939/bin/lava-test-runner /lava-11111939/1

    2023-07-19T13:19:50.425544  =


    2023-07-19T13:19:50.430894  / # /lava-11111939/bin/lava-test-runner /la=
va-11111939/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7e0f3c26b6678a68ace55

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b7e0f3c26b6678a68ace5a
        failing since 35 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-07-19T13:11:00.641674  + set +x

    2023-07-19T13:11:00.647987  <8>[   11.518439] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11111922_1.4.2.3.1>

    2023-07-19T13:11:00.755240  / # #

    2023-07-19T13:11:00.857470  export SHELL=3D/bin/sh

    2023-07-19T13:11:00.858173  #

    2023-07-19T13:11:00.959596  / # export SHELL=3D/bin/sh. /lava-11111922/=
environment

    2023-07-19T13:11:00.960301  =


    2023-07-19T13:11:01.061691  / # . /lava-11111922/environment/lava-11111=
922/bin/lava-test-runner /lava-11111922/1

    2023-07-19T13:11:01.062904  =


    2023-07-19T13:11:01.068050  / # /lava-11111922/bin/lava-test-runner /la=
va-11111922/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7e85e6d463b70ed8ace1c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie=
/baseline-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie=
/baseline-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64b7e85e6d463b70ed8ac=
e1d
        failing since 35 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7e6428e1fd6c0178ace21

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm/multi_v7_defconfig/gcc-10/lab-broonie/=
baseline-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm/multi_v7_defconfig/gcc-10/lab-broonie/=
baseline-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64b7e6428e1fd6c0178ac=
e22
        new failure (last pass: v6.1.38-cip1-10-g02aa22be941dd) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7e782b00e441f878ace21

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie=
/baseline-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie=
/baseline-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64b7e782b00e441f878ac=
e22
        failing since 35 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7e62eaeb2da8d548ace27

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm/multi_v7_defconfig/gcc-10/lab-broonie/=
baseline-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm/multi_v7_defconfig/gcc-10/lab-broonie/=
baseline-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64b7e62eaeb2da8d548ac=
e28
        new failure (last pass: v6.1.38-cip1-10-g02aa22be941dd) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7e4dbf9ca6c90308ace30

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutr=
onix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutr=
onix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b7e4dbf9ca6c90308ace35
        new failure (last pass: v6.1.38-cip1-10-g02aa22be941dd)

    2023-07-19T13:27:31.793525  + set +x
    2023-07-19T13:27:31.793710  [   10.417938] <LAVA_SIGNAL_ENDRUN 0_dmesg =
995708_1.5.2.3.1>
    2023-07-19T13:27:31.901779  / # #
    2023-07-19T13:27:32.003421  export SHELL=3D/bin/sh
    2023-07-19T13:27:32.003878  #
    2023-07-19T13:27:32.105112  / # export SHELL=3D/bin/sh. /lava-995708/en=
vironment
    2023-07-19T13:27:32.105582  =

    2023-07-19T13:27:32.206831  / # . /lava-995708/environment/lava-995708/=
bin/lava-test-runner /lava-995708/1
    2023-07-19T13:27:32.207495  =

    2023-07-19T13:27:32.210166  / # /lava-995708/bin/lava-test-runner /lava=
-995708/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7e02b814ac213e38ace48

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm/multi_v7_defconfig/gcc-10/lab-pengutro=
nix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm/multi_v7_defconfig/gcc-10/lab-pengutro=
nix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b7e02b814ac213e38ace4d
        new failure (last pass: v6.1.38-cip1-10-g02aa22be941dd)

    2023-07-19T13:07:33.433430  + set[    7.275279] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 995707_1.5.2.3.1>
    2023-07-19T13:07:33.433585   +x
    2023-07-19T13:07:33.539256  / # #
    2023-07-19T13:07:33.640754  export SHELL=3D/bin/sh
    2023-07-19T13:07:33.641240  #
    2023-07-19T13:07:33.742785  / # export SHELL=3D/bin/sh. /lava-995707/en=
vironment
    2023-07-19T13:07:33.743245  =

    2023-07-19T13:07:33.844539  / # . /lava-995707/environment/lava-995707/=
bin/lava-test-runner /lava-995707/1
    2023-07-19T13:07:33.845175  =

    2023-07-19T13:07:33.847774  / # /lava-995707/bin/lava-test-runner /lava=
-995707/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7e501c33361b27c8ace2f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm/imx_v6_v7_defconfig/gcc-10/lab-nxp/bas=
eline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm/imx_v6_v7_defconfig/gcc-10/lab-nxp/bas=
eline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.all-cpus-are-online: https://kernelci.org/test/case/id/=
64b7e501c33361b27c8ace33
        new failure (last pass: v6.1.38-cip1-10-g02aa22be941dd)

    2023-07-19T13:28:08.004943  /lava-1237594/1/../bin/lava-test-case
    2023-07-19T13:28:08.041998  <8>[   31.812702] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dall-cpus-are-online RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7e07b8eb554af698ace5d

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm/multi_v7_defconfig/gcc-10/lab-nxp/base=
line-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm/multi_v7_defconfig/gcc-10/lab-nxp/base=
line-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.all-cpus-are-online: https://kernelci.org/test/case/id/=
64b7e07b8eb554af698ace61
        new failure (last pass: v6.1.38-cip1-10-g02aa22be941dd)

    2023-07-19T13:08:53.344866  /lava-1237590/1/../bin/lava-test-case
    2023-07-19T13:08:53.388551  <8>[   24.896524] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dall-cpus-are-online RESULT=3Dfail>
    2023-07-19T13:08:53.388867  /lava-1237590/1/../bin/lava-test-case   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7ulp-evk                  | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7e07df16120b34a8ace21

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm/multi_v7_defconfig/gcc-10/lab-nxp/base=
line-imx7ulp-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm/multi_v7_defconfig/gcc-10/lab-nxp/base=
line-imx7ulp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b7e07df16120b34a8ace24
        failing since 119 days (last pass: v5.10.145-rt74-1329-ga59fc50f38f=
6, first fail: v5.10.175-cip29-rt12)

    2023-07-19T13:08:49.365989  + set +x<8>[   29.022144] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 1237591_1.5.2.4.1>
    2023-07-19T13:08:49.366284  =

    2023-07-19T13:08:49.474911  / # #
    2023-07-19T13:08:50.630766  export SHELL=3D/bin/sh
    2023-07-19T13:08:50.636442  #
    2023-07-19T13:08:50.636757  / # export SHELL=3D/bin/sh
    2023-07-19T13:08:52.178853  / # . /lava-1237591/environment
    2023-07-19T13:08:54.996303  /lava-1237591/bin/lava-test-runner /lava-12=
37591/1
    2023-07-19T13:08:55.002315  . /lava-1237591/environment
    2023-07-19T13:08:55.002573  / # /lava-1237591/bin/lava-test-runner /lav=
a-1237591/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
kontron-kbox-a-230-ls        | arm64  | lab-kontron     | gcc-10   | defcon=
fig                    | 3          =


  Details:     https://kernelci.org/test/plan/id/64b7e92c1473751a1c8ace38

  Results:     89 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm64/defconfig/gcc-10/lab-kontron/baselin=
e-kontron-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm64/defconfig/gcc-10/lab-kontron/baselin=
e-kontron-kbox-a-230-ls.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rcpm-driver-present: https://kernelci.org/test/case/id/=
64b7e92d1473751a1c8ace78
        new failure (last pass: v6.1.31-65-geef5a19d48f6)

    2023-07-19T13:45:54.783917  /lava-371788/1/../bin/lava-test-case
    2023-07-19T13:45:54.787165  <8>[   15.118882] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.ftm-alarm-driver-present: https://kernelci.org/test/cas=
e/id/64b7e92d1473751a1c8ace79
        new failure (last pass: v6.1.31-65-geef5a19d48f6)

    2023-07-19T13:45:55.796020  /lava-371788/1/../bin/lava-test-case
    2023-07-19T13:45:55.799157  <8>[   16.135953] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2023-07-19T13:45:56.818943  /lava-371788/1/../bin/lava-test-case   =


  * baseline.bootrr.layerscape-sfp-driver-present: https://kernelci.org/tes=
t/case/id/64b7e92d1473751a1c8ace90
        new failure (last pass: v6.1.31-65-geef5a19d48f6)

    2023-07-19T13:45:59.235669  /lava-371788/1/../bin/lava-test-case
    2023-07-19T13:45:59.238879  <8>[   19.570734] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
kontron-sl28-var3-ads2       | arm64  | lab-kontron     | gcc-10   | defcon=
fig                    | 3          =


  Details:     https://kernelci.org/test/plan/id/64b7e918916ccd23748ace29

  Results:     97 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm64/defconfig/gcc-10/lab-kontron/baselin=
e-kontron-sl28-var3-ads2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm64/defconfig/gcc-10/lab-kontron/baselin=
e-kontron-sl28-var3-ads2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rcpm-driver-present: https://kernelci.org/test/case/id/=
64b7e918916ccd23748ace70
        new failure (last pass: v6.1.31-65-geef5a19d48f6)

    2023-07-19T13:45:45.027312  /lava-371787/1/../bin/lava-test-case
    2023-07-19T13:45:45.030573  <8>[   10.972324] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.ftm-alarm-driver-present: https://kernelci.org/test/cas=
e/id/64b7e918916ccd23748ace71
        new failure (last pass: v6.1.31-65-geef5a19d48f6)

    2023-07-19T13:45:46.039820  /lava-371787/1/../bin/lava-test-case
    2023-07-19T13:45:46.043065  <8>[   11.989340] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2023-07-19T13:45:47.061400  /lava-371787/1/../bin/lava-test-case   =


  * baseline.bootrr.layerscape-sfp-driver-present: https://kernelci.org/tes=
t/case/id/64b7e918916ccd23748ace86
        new failure (last pass: v6.1.31-65-geef5a19d48f6)

    2023-07-19T13:45:49.480285  /lava-371787/1/../bin/lava-test-case
    2023-07-19T13:45:49.483522  <8>[   15.425196] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7f0ce605d5152bc8ace3d

  Results:     51 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm64/defconfig/gcc-10/lab-broonie/baselin=
e-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm64/defconfig/gcc-10/lab-broonie/baselin=
e-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/64b7f0ce6=
05d5152bc8ace40
        new failure (last pass: v6.1.31-65-geef5a19d48f6)

    2023-07-19T14:18:49.899685  /lava-1426/1/../bin/lava-test-case
    2023-07-19T14:18:49.912093  <8>[   18.764561] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>
    2023-07-19T14:18:49.912688  + set +x   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7f0e4f01e4265b88ace45

  Results:     51 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm64/defconfig+arm64-chromebook/gcc-10/la=
b-broonie/baseline-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm64/defconfig+arm64-chromebook/gcc-10/la=
b-broonie/baseline-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/64b7f0e4f=
01e4265b88ace48
        failing since 35 days (last pass: v6.1.26-1320-g1ddf4b637f785, firs=
t fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-07-19T14:19:09.016128  /lava-1501/1/../bin/lava-test-case
    2023-07-19T14:19:09.026416  <8>[   19.134005] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7eb001c76a96d9a8ace7c

  Results:     28 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm64/defconfig+arm64-chromebook/gcc-10/la=
b-collabora/baseline-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm64/defconfig+arm64-chromebook/gcc-10/la=
b-collabora/baseline-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b7eb011c76a96d9a8ace98
        failing since 35 days (last pass: v6.1.26-1320-g1ddf4b637f785, firs=
t fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-07-19T13:54:24.744676  + set +x

    2023-07-19T13:54:24.750141  <8>[   15.594406] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11112183_1.5.2.3.1>

    2023-07-19T13:54:24.854321  #

    2023-07-19T13:54:24.854570  =


    2023-07-19T13:54:24.955094  / # #export SHELL=3D/bin/sh

    2023-07-19T13:54:24.955273  =


    2023-07-19T13:54:25.055773  / # export SHELL=3D/bin/sh. /lava-11112183/=
environment

    2023-07-19T13:54:25.055968  =


    2023-07-19T13:54:25.156473  / # . /lava-11112183/environment/lava-11112=
183/bin/lava-test-runner /lava-11112183/1

    2023-07-19T13:54:25.156741  =

 =

    ... (21 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_mips-malta              | mips   | lab-broonie     | gcc-10   | malta_=
defconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7e433364c43b6a78ace1e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/mips/malta_defconfig/gcc-10/lab-broonie/ba=
seline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/mips/malta_defconfig/gcc-10/lab-broonie/ba=
seline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64b7e433364c43b6a78ac=
e1f
        new failure (last pass: v6.1.38-cip1-10-g02aa22be941dd) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_mips-malta              | mips   | lab-collabora   | gcc-10   | malta_=
defconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7e42c46cb2e48e58ace44

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/mips/malta_defconfig/gcc-10/lab-collabora/=
baseline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/mips/malta_defconfig/gcc-10/lab-collabora/=
baseline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64b7e42c46cb2e48e58ac=
e45
        new failure (last pass: v6.1.38-cip1-10-g02aa22be941dd) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7dcef95c5a392958ace28

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm/shmobile_defconfig/gcc-10/lab-cip/base=
line-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm/shmobile_defconfig/gcc-10/lab-cip/base=
line-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64b7dcef95c5a392958ac=
e29
        failing since 10 days (last pass: v6.1.31-61-g32a95f5a4e3b, first f=
ail: v6.1.31-65-geef5a19d48f6) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7e99edb7b29fa908ace31

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm64/defconfig/gcc-10/lab-cip/baseline-r8=
a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm64/defconfig/gcc-10/lab-cip/baseline-r8=
a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b7e99edb7b29fa908ace34
        new failure (last pass: v6.1.31-65-geef5a19d48f6)

    2023-07-19T13:47:50.555304  + set +x
    2023-07-19T13:47:50.558554  <8>[   83.847437] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 987489_1.5.2.4.1>
    2023-07-19T13:47:50.666763  / # #
    2023-07-19T13:47:52.130758  export SHELL=3D/bin/sh
    2023-07-19T13:47:52.151678  #
    2023-07-19T13:47:52.152135  / # export SHELL=3D/bin/sh
    2023-07-19T13:47:54.039350  / # . /lava-987489/environment
    2023-07-19T13:47:57.499998  /lava-987489/bin/lava-test-runner /lava-987=
489/1
    2023-07-19T13:47:57.521417  . /lava-987489/environment
    2023-07-19T13:47:57.521833  / # /lava-987489/bin/lava-test-runner /lava=
-987489/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7eb56d6bc2a291b8acf5b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm64/defconfig+arm64-chromebook/gcc-10/la=
b-cip/baseline-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm64/defconfig+arm64-chromebook/gcc-10/la=
b-cip/baseline-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b7eb56d6bc2a291b8acf5e
        new failure (last pass: v5.10.184-cip36-13-g8201543bbc8b6)

    2023-07-19T13:55:19.242477  + set +x
    2023-07-19T13:55:19.245687  <8>[   83.820127] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 987504_1.5.2.4.1>
    2023-07-19T13:55:19.353406  / # #
    2023-07-19T13:55:20.817633  export SHELL=3D/bin/sh
    2023-07-19T13:55:20.838583  #
    2023-07-19T13:55:20.839049  / # export SHELL=3D/bin/sh
    2023-07-19T13:55:22.726257  / # . /lava-987504/environment
    2023-07-19T13:55:26.186944  /lava-987504/bin/lava-test-runner /lava-987=
504/1
    2023-07-19T13:55:26.208378  . /lava-987504/environment
    2023-07-19T13:55:26.208831  / # /lava-987504/bin/lava-test-runner /lava=
-987504/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7ebb6a816bb0b5f8ace2b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm64/defconfig+arm64-chromebook/gcc-10/la=
b-cip/baseline-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm64/defconfig+arm64-chromebook/gcc-10/la=
b-cip/baseline-r8a774b1-hihope-rzg2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b7ebb6a816bb0b5f8ace2e
        new failure (last pass: v5.10.184-cip36-13-g8201543bbc8b6)

    2023-07-19T13:56:41.566324  + set +x
    2023-07-19T13:56:41.566543  <8>[   84.070747] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 987508_1.5.2.4.1>
    2023-07-19T13:56:41.672788  / # #
    2023-07-19T13:56:43.136072  export SHELL=3D/bin/sh
    2023-07-19T13:56:43.156802  #
    2023-07-19T13:56:43.157008  / # export SHELL=3D/bin/sh
    2023-07-19T13:56:45.042644  / # . /lava-987508/environment
    2023-07-19T13:56:48.502181  /lava-987508/bin/lava-test-runner /lava-987=
508/1
    2023-07-19T13:56:48.523762  . /lava-987508/environment
    2023-07-19T13:56:48.524059  / # /lava-987508/bin/lava-test-runner /lava=
-987508/1 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7e9e9a2e978a1d28ace2e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm64/defconfig/gcc-10/lab-cip/baseline-r8=
a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm64/defconfig/gcc-10/lab-cip/baseline-r8=
a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b7e9e9a2e978a1d28ace31
        new failure (last pass: v6.1.31-65-geef5a19d48f6)

    2023-07-19T13:49:01.446290  / # #
    2023-07-19T13:49:02.908866  export SHELL=3D/bin/sh
    2023-07-19T13:49:02.929609  #
    2023-07-19T13:49:02.929842  / # export SHELL=3D/bin/sh
    2023-07-19T13:49:04.815282  / # . /lava-987494/environment
    2023-07-19T13:49:08.273914  /lava-987494/bin/lava-test-runner /lava-987=
494/1
    2023-07-19T13:49:08.294669  . /lava-987494/environment
    2023-07-19T13:49:08.294780  / # /lava-987494/bin/lava-test-runner /lava=
-987494/1
    2023-07-19T13:49:08.374936  + export 'TESTRUN_ID=3D1_bootrr'
    2023-07-19T13:49:08.375208  + cd /lava-987494/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7eba2a816bb0b5f8ace1c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm64/defconfig+arm64-chromebook/gcc-10/la=
b-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm64/defconfig+arm64-chromebook/gcc-10/la=
b-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b7eba2a816bb0b5f8ace1f
        new failure (last pass: v5.10.184-cip36-13-g8201543bbc8b6)

    2023-07-19T13:56:28.127010  / # #
    2023-07-19T13:56:29.589145  export SHELL=3D/bin/sh
    2023-07-19T13:56:29.609723  #
    2023-07-19T13:56:29.609931  / # export SHELL=3D/bin/sh
    2023-07-19T13:56:31.494846  / # . /lava-987503/environment
    2023-07-19T13:56:34.951435  /lava-987503/bin/lava-test-runner /lava-987=
503/1
    2023-07-19T13:56:34.972225  . /lava-987503/environment
    2023-07-19T13:56:34.972354  / # /lava-987503/bin/lava-test-runner /lava=
-987503/1
    2023-07-19T13:56:35.007296  + export 'TESTRUN_ID=3D1_bootrr'
    2023-07-19T13:56:35.055787  + cd /lava-987503/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7e9201473751a1c8ace2a

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm64/defconfig/gcc-10/lab-collabora/basel=
ine-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm64/defconfig/gcc-10/lab-collabora/basel=
ine-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b7e9201473751a1c8ace2f
        new failure (last pass: v6.1.31-65-geef5a19d48f6)

    2023-07-19T13:47:24.495073  / # #

    2023-07-19T13:47:24.597433  export SHELL=3D/bin/sh

    2023-07-19T13:47:24.598190  #

    2023-07-19T13:47:24.699612  / # export SHELL=3D/bin/sh. /lava-11112073/=
environment

    2023-07-19T13:47:24.700368  =


    2023-07-19T13:47:24.801809  / # . /lava-11112073/environment/lava-11112=
073/bin/lava-test-runner /lava-11112073/1

    2023-07-19T13:47:24.803006  =


    2023-07-19T13:47:24.818096  / # /lava-11112073/bin/lava-test-runner /la=
va-11112073/1

    2023-07-19T13:47:24.868571  + export 'TESTRUN_ID=3D1_bootrr'

    2023-07-19T13:47:24.869107  + cd /lav<8>[   16.463818] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11112073_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 5          =


  Details:     https://kernelci.org/test/plan/id/64b7e7f119c95be8258ace1c

  Results:     63 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm/multi_v7_defconfig/gcc-10/lab-collabor=
a/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm/multi_v7_defconfig/gcc-10/lab-collabor=
a/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-iodomain-grf-probed: https://kernelci.org/test=
/case/id/64b7e7f219c95be8258ace32
        new failure (last pass: v6.1.38-cip1-10-g02aa22be941dd)

    2023-07-19T13:42:32.426139  <8>[   20.987180] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-iodomain-driver-present RESULT=3Dpass>

    2023-07-19T13:42:33.437169  /lava-11111895/1/../bin/lava-test-case

    2023-07-19T13:42:33.447006  <8>[   22.007985] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-iodomain-grf-probed RESULT=3Dfail>
   =


  * baseline.bootrr.dwmmc_rockchip-sdio0-probed: https://kernelci.org/test/=
case/id/64b7e7f219c95be8258ace48
        new failure (last pass: v6.1.38-cip1-10-g02aa22be941dd)

    2023-07-19T13:42:31.013458  <8>[   19.574428] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwmmc_rockchip-sdmmc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.dwmmc_rockchip-sdmmc-probed: https://kernelci.org/test/=
case/id/64b7e7f219c95be8258ace49
        new failure (last pass: v6.1.38-cip1-10-g02aa22be941dd)

    2023-07-19T13:42:29.992042  	-w	P<8>[   18.548279] <LAVA_SIGNAL_TESTCAS=
E TEST_CASE_ID=3Ddwmmc_rockchip-driver-present RESULT=3Dpass>

    2023-07-19T13:42:29.996513  ad to last with leading zeros

    2023-07-19T13:42:29.999096  	-s SEP	String separator

    2023-07-19T13:42:30.003087  /lava-11111895/1/../bin/lava-test-case

    2023-07-19T13:42:30.008981  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.

    2023-07-19T13:42:30.009197  =


    2023-07-19T13:42:30.013520  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-07-19T13:42:30.013736  =


    2023-07-19T13:42:30.018844  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-07-19T13:42:30.021434  FIRST, INC default to 1.
 =

    ... (6 line(s) more)  =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/64b7e7f219c95be8258ace4c
        failing since 180 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-07-19T13:42:29.915801  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC)<8=
>[   18.476581] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-07-19T13:42:29.917795   multi-call binary.

    2023-07-19T13:42:29.918016  =


    2023-07-19T13:42:29.922483  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-07-19T13:42:29.922542  =


    2023-07-19T13:42:29.927506  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/64b7e7f219c95be8258ace4d
        failing since 180 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-07-19T13:42:29.896724  <8>[   18.458647] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>
   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64b7eb29eb30fe31368ace1f

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm64/defconfig+arm64-chromebook/gcc-10/la=
b-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm64/defconfig+arm64-chromebook/gcc-10/la=
b-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/64b7eb29eb30fe31368ace25
        failing since 35 days (last pass: v6.1.26-1320-g1ddf4b637f785, firs=
t fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-07-19T13:54:58.811895  <8>[   33.946677] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-07-19T13:54:59.837093  /lava-11112177/1/../bin/lava-test-case

    2023-07-19T13:54:59.848049  <8>[   34.983345] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/64b7eb29eb30fe31368ace26
        failing since 35 days (last pass: v6.1.26-1320-g1ddf4b637f785, firs=
t fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-07-19T13:54:57.775624  <8>[   32.909859] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-07-19T13:54:58.800882  /lava-11112177/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 5          =


  Details:     https://kernelci.org/test/plan/id/64b7e927916ccd23748ace9f

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm64/defconfig/gcc-10/lab-broonie/baselin=
e-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm64/defconfig/gcc-10/lab-broonie/baselin=
e-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.sun4i-i2s-driver-present: https://kernelci.org/test/cas=
e/id/64b7e927916ccd23748aceb5
        new failure (last pass: v6.1.31-65-geef5a19d48f6)

    2023-07-19T13:46:04.707601  /lava-1427/1/../bin/lava-test-case
    2023-07-19T13:46:04.719460  <8>[   23.285224] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcodec-digital-probed RESULT=3Dblocked>
    2023-07-19T13:46:05.743851  /lava-1427/1/../bin/lava-test-case
    2023-07-19T13:46:05.755543  <8>[   24.321051] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun4i-i2s-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sun8i-codec-driver-present: https://kernelci.org/test/c=
ase/id/64b7e927916ccd23748aceb6
        new failure (last pass: v6.1.31-65-geef5a19d48f6)

    2023-07-19T13:46:02.633937  /lava-1427/1/../bin/lava-test-case
    2023-07-19T13:46:02.645306  <8>[   21.211197] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcodec-analog-probed RESULT=3Dblocked>
    2023-07-19T13:46:03.669745  /lava-1427/1/../bin/lava-test-case
    2023-07-19T13:46:03.681806  <8>[   22.247373] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8i-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sun50i-codec-analog-driver-present: https://kernelci.or=
g/test/case/id/64b7e927916ccd23748aceb7
        new failure (last pass: v6.1.31-65-geef5a19d48f6)

    2023-07-19T13:46:01.601730  /lava-1427/1/../bin/lava-test-case
    2023-07-19T13:46:01.614653  <8>[   20.179467] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun50i-codec-analog-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b7e927916ccd23748aceca
        new failure (last pass: v6.1.31-65-geef5a19d48f6)

    2023-07-19T13:45:58.457295  <8>[   17.025024] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1427_1.5.2.4.1>
    2023-07-19T13:45:58.568249  / # #
    2023-07-19T13:45:58.670252  export SHELL=3D/bin/sh
    2023-07-19T13:45:58.670777  #
    2023-07-19T13:45:58.772386  / # export SHELL=3D/bin/sh. /lava-1427/envi=
ronment
    2023-07-19T13:45:58.772939  =

    2023-07-19T13:45:58.875209  / # . /lava-1427/environment/lava-1427/bin/=
lava-test-runner /lava-1427/1
    2023-07-19T13:45:58.876293  =

    2023-07-19T13:45:58.880193  / # /lava-1427/bin/lava-test-runner /lava-1=
427/1
    2023-07-19T13:45:58.924783  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =


  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/64b7e9279=
16ccd23748acecb
        new failure (last pass: v6.1.31-65-geef5a19d48f6)

    2023-07-19T13:46:06.780628  /lava-1427/1/../bin/lava-test-case
    2023-07-19T13:46:06.791561  <8>[   25.357873] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Di2s-probed RESULT=3Dblocked>
    2023-07-19T13:46:07.816743  /lava-1427/1/../bin/lava-test-case
    2023-07-19T13:46:07.827410  <8>[   26.394085] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7e93b1473751a1c8ace9c

  Results:     40 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm64/defconfig/gcc-10/lab-broonie/baselin=
e-sun50i-h5-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm64/defconfig/gcc-10/lab-broonie/baselin=
e-sun50i-h5-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.sun8-codec-analog-driver-present: https://kernelci.org/=
test/case/id/64b7e93b1473751a1c8acea7
        new failure (last pass: v6.1.31-65-geef5a19d48f6)

    2023-07-19T13:46:24.607653  /lava-1429/1/../bin/lava-test-case
    2023-07-19T13:46:24.624306  <8>[   19.879551] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8-codec-analog-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7e91e1473751a1c8ace1c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm64/defconfig/gcc-10/lab-collabora/basel=
ine-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm64/defconfig/gcc-10/lab-collabora/basel=
ine-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b7e91e1473751a1c8ace21
        new failure (last pass: v6.1.31-65-geef5a19d48f6)

    2023-07-19T13:47:36.388440  / # #

    2023-07-19T13:47:36.490604  export SHELL=3D/bin/sh

    2023-07-19T13:47:36.491297  #

    2023-07-19T13:47:36.592697  / # export SHELL=3D/bin/sh. /lava-11112069/=
environment

    2023-07-19T13:47:36.593429  =


    2023-07-19T13:47:36.694870  / # . /lava-11112069/environment/lava-11112=
069/bin/lava-test-runner /lava-11112069/1

    2023-07-19T13:47:36.695922  =


    2023-07-19T13:47:36.699409  / # /lava-11112069/bin/lava-test-runner /la=
va-11112069/1

    2023-07-19T13:47:36.741476  + export 'TESTRUN_ID=3D1_bootrr'

    2023-07-19T13:47:36.773458  + cd /lava-1111206<8>[   18.313026] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11112069_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7ea1d2ba065debf8ace1c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm64/defconfig/gcc-10/lab-cip/baseline-zy=
nqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm64/defconfig/gcc-10/lab-cip/baseline-zy=
nqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64b7ea1d2ba065debf8ac=
e1d
        new failure (last pass: v6.1.31-65-geef5a19d48f6) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7ebd53524a4b3598ace29

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm64/defconfig+arm64-chromebook/gcc-10/la=
b-cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/arm64/defconfig+arm64-chromebook/gcc-10/la=
b-cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64b7ebd53524a4b3598ac=
e2a
        failing since 35 days (last pass: v6.1.26-1320-g1ddf4b637f785, firs=
t fail: v5.10.182-cip35-8-g2391124f19a70) =

 =20

