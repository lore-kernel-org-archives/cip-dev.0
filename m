Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853A6C6379F
	for <webhook@archiver.kernel.org>; Tue, 21 Feb 2023 13:52:47 +0000 (UTC)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.web11.42979.1676987560504279831
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 21 Feb 2023 05:52:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=69bQMv6X;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.46, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f46.google.com with SMTP id v3-20020a17090a6b0300b002341a2656e5so4679273pjj.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 21 Feb 2023 05:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/uFrNvZjgau94WaQwElKWGoj7lV4p62ifYPzb1WgY6g=;
        b=69bQMv6XJ909qVsRgDUe5rWWtpuQ40OPvE6XhTVQG2HY2GWdl6hs4SCdxh0Y2jn3bM
         VRTja6Q/nYQb80xHBTQ5kscAq/sYAm6cYMVfwRA05+ekpwq1/x5LrH4OqHQS267owFTX
         9Eqtgi6NX8ciSCoSEV27Txu7rlXRpTxykW7MsefQvsi9H3sx89Y5kNQWwekTAYn7UIhI
         Y9xz7aPBWTRXG0zIcxrs1K9S6UPZmz1OoK0tWkyORBkCSuJK2LcW17l3z1VZoZupi8h+
         Udzs3iYcQBm0Tpw8L04kbSUk+B2fquKlC2w45vcXkvu18wwVQig+XBOaH8McVQR60nc5
         l5sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/uFrNvZjgau94WaQwElKWGoj7lV4p62ifYPzb1WgY6g=;
        b=ZEOviEiSg0c/WT1DORNzCvbx+97GwprVaLfp0b3TCL0wIW2D1SIY4+fBk5r9YKv24S
         cDJ38jhiC9AXl4cGDW99KqAzvGhbBjBV99COfG597KyC7jUogUv7PUxqe85uRbm/TueO
         1WUanDkXIlRhj2ScyH4O5MSOLB+sG+cXl1OMQQ3DQYxzwBsQARBRimyA3J5qUBMNzOsR
         pgWLAJaioxTbOhD2l5XJ8IyWdDg22UgNXJnI852f1Yk14nIepXkArPogDN2VTiTBXGzo
         g1wDO/cC50pK1cwopQX0JZggESUO58A/YNCIeiWYi1WJzMWMMlriwIQbk6U9sTWJNPxA
         1+6A==
X-Gm-Message-State: AO0yUKUuLpMS5bd7ZNwb1EETnFysu/RrNO7sPXdQBeboX+hJhbIHxv/c
	1aLeKCHa/nHqzOkYu/azHzdFZjknUk4ktmer
X-Google-Smtp-Source: AK7set/BsoKKTtRaiwnlkcqK6yCDDcUFcLR6LpAswLuWg6xYVDyrl5MIM+wuiGjCFPlov8+TLT+BAA==
X-Received: by 2002:a17:902:d4c4:b0:199:16c6:8a24 with SMTP id o4-20020a170902d4c400b0019916c68a24mr6549510plg.61.1676987559103;
        Tue, 21 Feb 2023 05:52:39 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id l11-20020a170902d34b00b0019ac69a6348sm9956780plk.133.2023.02.21.05.52.38
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 05:52:38 -0800 (PST)
Message-ID: <63f4cca6.170a0220.1cdc0.1899@mx.google.com>
Date: Tue, 21 Feb 2023 05:52:38 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.167-cip26-2-g28bb49f7179b
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline: 100 runs,
 24 regressions (v5.10.167-cip26-2-g28bb49f7179b)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 21 Feb 2023 13:52:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10753

cip-gitlab/ci/pavel/linux-test baseline: 100 runs, 24 regressions (v5.10.16=
7-cip26-2-g28bb49f7179b)

Regressions Summary
-------------------

platform               | arch   | lab             | compiler | defconfig   =
                 | regressions
-----------------------+--------+-----------------+----------+-------------=
-----------------+------------
at91sam9g20ek          | arm    | lab-broonie     | gcc-10   | multi_v5_def=
config           | 1          =

bcm2836-rpi-2-b        | arm    | lab-collabora   | gcc-10   | multi_v7_def=
config           | 1          =

imx6dl-udoo            | arm    | lab-broonie     | gcc-10   | imx_v6_v7_de=
fconfig          | 1          =

imx6dl-udoo            | arm    | lab-broonie     | gcc-10   | multi_v7_def=
config           | 1          =

imx6q-udoo             | arm    | lab-broonie     | gcc-10   | imx_v6_v7_de=
fconfig          | 1          =

imx6q-udoo             | arm    | lab-broonie     | gcc-10   | multi_v7_def=
config           | 1          =

imx6qp-wandboard-revd1 | arm    | lab-pengutronix | gcc-10   | imx_v6_v7_de=
fconfig          | 1          =

imx6qp-wandboard-revd1 | arm    | lab-pengutronix | gcc-10   | multi_v7_def=
config           | 1          =

qemu_i386-uefi         | i386   | lab-collabora   | gcc-10   | i386_defconf=
ig               | 1          =

qemu_x86_64-uefi       | x86_64 | lab-broonie     | gcc-10   | x86_64_defco=
nfig             | 1          =

qemu_x86_64-uefi       | x86_64 | lab-broonie     | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =

qemu_x86_64-uefi       | x86_64 | lab-collabora   | gcc-10   | x86_64_defco=
nfig             | 1          =

qemu_x86_64-uefi-mixed | x86_64 | lab-broonie     | gcc-10   | x86_64_defco=
nfig             | 1          =

qemu_x86_64-uefi-mixed | x86_64 | lab-broonie     | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =

r8a7743-iwg20d-q7      | arm    | lab-cip         | gcc-10   | shmobile_def=
config           | 1          =

rk3288-veyron-jaq      | arm    | lab-collabora   | gcc-10   | multi_v7_def=
config           | 3          =

rk3399-gru-kevin       | arm64  | lab-collabora   | gcc-10   | defconfig+ar=
m64-chromebook   | 4          =

zynqmp-zcu102          | arm64  | lab-cip         | gcc-10   | defconfig+ar=
m64-chromebook   | 1          =

zynqmp-zcu102          | arm64  | lab-cip         | gcc-10   | defconfig   =
                 | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.167-cip26-2-g28bb49f7179b/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.167-cip26-2-g28bb49f7179b
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      28bb49f7179b9cb7b4cd5c5a139820ec49c19d6d =



Test Regressions
---------------- =



platform               | arch   | lab             | compiler | defconfig   =
                 | regressions
-----------------------+--------+-----------------+----------+-------------=
-----------------+------------
at91sam9g20ek          | arm    | lab-broonie     | gcc-10   | multi_v5_def=
config           | 1          =


  Details:     https://kernelci.org/test/plan/id/63f4c0bcd29a2fcc648c863b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.167-cip26-2-g28bb49f7179b/arm/multi_v5_defconfig/gcc-10/lab-broonie/=
baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.167-cip26-2-g28bb49f7179b/arm/multi_v5_defconfig/gcc-10/lab-broonie/=
baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230211.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63f4c0bcd29a2fcc648c8644
        failing since 25 days (last pass: v4.19.269-cip88-rt28-rebase, firs=
t fail: v5.10.162-cip24-443-g1f8fb81fe752)

    2023-02-21T13:01:33.476883  + set +x
    2023-02-21T13:01:33.482004  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 50952_1.5.2.=
4.1>
    2023-02-21T13:01:33.596374  / # #
    2023-02-21T13:01:33.699264  export SHELL=3D/bin/sh
    2023-02-21T13:01:33.700108  #
    2023-02-21T13:01:33.801973  / # export SHELL=3D/bin/sh. /lava-50952/env=
ironment
    2023-02-21T13:01:33.802830  =

    2023-02-21T13:01:33.904814  / # . /lava-50952/environment/lava-50952/bi=
n/lava-test-runner /lava-50952/1
    2023-02-21T13:01:33.906232  =

    2023-02-21T13:01:33.912703  / # /lava-50952/bin/lava-test-runner /lava-=
50952/1 =

    ... (11 line(s) more)  =

 =



platform               | arch   | lab             | compiler | defconfig   =
                 | regressions
-----------------------+--------+-----------------+----------+-------------=
-----------------+------------
bcm2836-rpi-2-b        | arm    | lab-collabora   | gcc-10   | multi_v7_def=
config           | 1          =


  Details:     https://kernelci.org/test/plan/id/63f4c28c154df13c418c867d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.167-cip26-2-g28bb49f7179b/arm/multi_v7_defconfig/gcc-10/lab-collabor=
a/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.167-cip26-2-g28bb49f7179b/arm/multi_v7_defconfig/gcc-10/lab-collabor=
a/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230211.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f4c28c154df13c418c8=
67e
        failing since 25 days (last pass: v4.19.269-cip88-rt28-rebase, firs=
t fail: v5.10.162-cip24-443-g1f8fb81fe752) =

 =



platform               | arch   | lab             | compiler | defconfig   =
                 | regressions
-----------------------+--------+-----------------+----------+-------------=
-----------------+------------
imx6dl-udoo            | arm    | lab-broonie     | gcc-10   | imx_v6_v7_de=
fconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63f4c28b154df13c418c867a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.167-cip26-2-g28bb49f7179b/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie=
/baseline-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.167-cip26-2-g28bb49f7179b/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie=
/baseline-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230211.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f4c28b154df13c418c8=
67b
        new failure (last pass: v4.4.302-cip72-rt42) =

 =



platform               | arch   | lab             | compiler | defconfig   =
                 | regressions
-----------------------+--------+-----------------+----------+-------------=
-----------------+------------
imx6dl-udoo            | arm    | lab-broonie     | gcc-10   | multi_v7_def=
config           | 1          =


  Details:     https://kernelci.org/test/plan/id/63f4c3f055ce2f53b88c8648

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.167-cip26-2-g28bb49f7179b/arm/multi_v7_defconfig/gcc-10/lab-broonie/=
baseline-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.167-cip26-2-g28bb49f7179b/arm/multi_v7_defconfig/gcc-10/lab-broonie/=
baseline-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230211.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f4c3f055ce2f53b88c8=
649
        new failure (last pass: v4.4.302-cip72-rt42) =

 =



platform               | arch   | lab             | compiler | defconfig   =
                 | regressions
-----------------------+--------+-----------------+----------+-------------=
-----------------+------------
imx6q-udoo             | arm    | lab-broonie     | gcc-10   | imx_v6_v7_de=
fconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63f4c28a154df13c418c8672

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.167-cip26-2-g28bb49f7179b/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie=
/baseline-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.167-cip26-2-g28bb49f7179b/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie=
/baseline-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230211.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f4c28a154df13c418c8=
673
        new failure (last pass: v4.4.302-cip72-rt42) =

 =



platform               | arch   | lab             | compiler | defconfig   =
                 | regressions
-----------------------+--------+-----------------+----------+-------------=
-----------------+------------
imx6q-udoo             | arm    | lab-broonie     | gcc-10   | multi_v7_def=
config           | 1          =


  Details:     https://kernelci.org/test/plan/id/63f4c3dc84a02ed0758c8650

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.167-cip26-2-g28bb49f7179b/arm/multi_v7_defconfig/gcc-10/lab-broonie/=
baseline-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.167-cip26-2-g28bb49f7179b/arm/multi_v7_defconfig/gcc-10/lab-broonie/=
baseline-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230211.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f4c3dc84a02ed0758c8=
651
        new failure (last pass: v4.4.302-cip72-rt42) =

 =



platform               | arch   | lab             | compiler | defconfig   =
                 | regressions
-----------------------+--------+-----------------+----------+-------------=
-----------------+------------
imx6qp-wandboard-revd1 | arm    | lab-pengutronix | gcc-10   | imx_v6_v7_de=
fconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63f4c122d3f22626678c8664

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.167-cip26-2-g28bb49f7179b/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutr=
onix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.167-cip26-2-g28bb49f7179b/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutr=
onix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230211.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63f4c122d3f22626678c866d
        failing since 33 days (last pass: v5.10.158-cip22-435-g2c52868ae1cb=
c, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-02-21T13:03:10.950817  + set +x
    2023-02-21T13:03:10.951177  [   11.569210] <LAVA_SIGNAL_ENDRUN 0_dmesg =
910199_1.5.2.3.1>
    2023-02-21T13:03:11.059603  / # #
    2023-02-21T13:03:11.161352  export SHELL=3D/bin/sh
    2023-02-21T13:03:11.161909  #
    2023-02-21T13:03:11.263310  / # export SHELL=3D/bin/sh. /lava-910199/en=
vironment
    2023-02-21T13:03:11.263921  =

    2023-02-21T13:03:11.365349  / # . /lava-910199/environment/lava-910199/=
bin/lava-test-runner /lava-910199/1
    2023-02-21T13:03:11.366235  =

    2023-02-21T13:03:11.370254  / # /lava-910199/bin/lava-test-runner /lava=
-910199/1 =

    ... (12 line(s) more)  =

 =



platform               | arch   | lab             | compiler | defconfig   =
                 | regressions
-----------------------+--------+-----------------+----------+-------------=
-----------------+------------
imx6qp-wandboard-revd1 | arm    | lab-pengutronix | gcc-10   | multi_v7_def=
config           | 1          =


  Details:     https://kernelci.org/test/plan/id/63f4c23bcbcaf785e88c867c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.167-cip26-2-g28bb49f7179b/arm/multi_v7_defconfig/gcc-10/lab-pengutro=
nix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.167-cip26-2-g28bb49f7179b/arm/multi_v7_defconfig/gcc-10/lab-pengutro=
nix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230211.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63f4c23bcbcaf785e88c8685
        failing since 33 days (last pass: v5.10.158-cip22-435-g2c52868ae1cb=
c, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-02-21T13:07:49.714972  + set[    7.231591] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 910203_1.5.2.3.1>
    2023-02-21T13:07:49.715196   +x
    2023-02-21T13:07:49.821071  / # #
    2023-02-21T13:07:49.922573  export SHELL=3D/bin/sh
    2023-02-21T13:07:49.923104  #
    2023-02-21T13:07:50.024506  / # export SHELL=3D/bin/sh. /lava-910203/en=
vironment
    2023-02-21T13:07:50.024920  =

    2023-02-21T13:07:50.126284  / # . /lava-910203/environment/lava-910203/=
bin/lava-test-runner /lava-910203/1
    2023-02-21T13:07:50.127127  =

    2023-02-21T13:07:50.129219  / # /lava-910203/bin/lava-test-runner /lava=
-910203/1 =

    ... (12 line(s) more)  =

 =



platform               | arch   | lab             | compiler | defconfig   =
                 | regressions
-----------------------+--------+-----------------+----------+-------------=
-----------------+------------
qemu_i386-uefi         | i386   | lab-collabora   | gcc-10   | i386_defconf=
ig               | 1          =


  Details:     https://kernelci.org/test/plan/id/63f4c1ac773cd408548c86b5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: i386_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.167-cip26-2-g28bb49f7179b/i386/i386_defconfig/gcc-10/lab-collabora/b=
aseline-qemu_i386-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.167-cip26-2-g28bb49f7179b/i386/i386_defconfig/gcc-10/lab-collabora/b=
aseline-qemu_i386-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230211.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f4c1ac773cd408548c8=
6b6
        new failure (last pass: v4.4.302-cip72-rt42) =

 =



platform               | arch   | lab             | compiler | defconfig   =
                 | regressions
-----------------------+--------+-----------------+----------+-------------=
-----------------+------------
qemu_x86_64-uefi       | x86_64 | lab-broonie     | gcc-10   | x86_64_defco=
nfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/63f4c1f872370164818c9f7e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.167-cip26-2-g28bb49f7179b/x86_64/x86_64_defconfig/gcc-10/lab-broonie=
/baseline-qemu_x86_64-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.167-cip26-2-g28bb49f7179b/x86_64/x86_64_defconfig/gcc-10/lab-broonie=
/baseline-qemu_x86_64-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230211.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f4c1f872370164818c9=
f7f
        new failure (last pass: v4.4.302-cip72-rt42) =

 =



platform               | arch   | lab             | compiler | defconfig   =
                 | regressions
-----------------------+--------+-----------------+----------+-------------=
-----------------+------------
qemu_x86_64-uefi       | x86_64 | lab-broonie     | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63f4c2c06e90aa9cb78c8649

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.167-cip26-2-g28bb49f7179b/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-broonie/baseline-qemu_x86_64-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.167-cip26-2-g28bb49f7179b/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-broonie/baseline-qemu_x86_64-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230211.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f4c2c06e90aa9cb78c8=
64a
        new failure (last pass: v4.4.302-cip72-rt42) =

 =



platform               | arch   | lab             | compiler | defconfig   =
                 | regressions
-----------------------+--------+-----------------+----------+-------------=
-----------------+------------
qemu_x86_64-uefi       | x86_64 | lab-collabora   | gcc-10   | x86_64_defco=
nfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/63f4c1ce72370164818c8634

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.167-cip26-2-g28bb49f7179b/x86_64/x86_64_defconfig/gcc-10/lab-collabo=
ra/baseline-qemu_x86_64-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.167-cip26-2-g28bb49f7179b/x86_64/x86_64_defconfig/gcc-10/lab-collabo=
ra/baseline-qemu_x86_64-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230211.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f4c1ce72370164818c8=
635
        new failure (last pass: v4.4.302-cip72-rt42) =

 =



platform               | arch   | lab             | compiler | defconfig   =
                 | regressions
-----------------------+--------+-----------------+----------+-------------=
-----------------+------------
qemu_x86_64-uefi-mixed | x86_64 | lab-broonie     | gcc-10   | x86_64_defco=
nfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/63f4c2ace54af1801b8c8630

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.167-cip26-2-g28bb49f7179b/x86_64/x86_64_defconfig/gcc-10/lab-broonie=
/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.167-cip26-2-g28bb49f7179b/x86_64/x86_64_defconfig/gcc-10/lab-broonie=
/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230211.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f4c2ace54af1801b8c8=
631
        failing since 14 days (last pass: v5.10.162-cip24-443-g1f8fb81fe752=
, first fail: v4.4.302-cip72-rt42) =

 =



platform               | arch   | lab             | compiler | defconfig   =
                 | regressions
-----------------------+--------+-----------------+----------+-------------=
-----------------+------------
qemu_x86_64-uefi-mixed | x86_64 | lab-broonie     | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63f4c33aefa7e761638c863d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.167-cip26-2-g28bb49f7179b/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-broonie/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.167-cip26-2-g28bb49f7179b/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-broonie/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230211.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f4c33aefa7e761638c8=
63e
        failing since 14 days (last pass: v5.10.162-cip24-443-g1f8fb81fe752=
, first fail: v4.4.302-cip72-rt42) =

 =



platform               | arch   | lab             | compiler | defconfig   =
                 | regressions
-----------------------+--------+-----------------+----------+-------------=
-----------------+------------
r8a7743-iwg20d-q7      | arm    | lab-cip         | gcc-10   | shmobile_def=
config           | 1          =


  Details:     https://kernelci.org/test/plan/id/63f4c1c972370164818c8630

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.167-cip26-2-g28bb49f7179b/arm/shmobile_defconfig/gcc-10/lab-cip/base=
line-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.167-cip26-2-g28bb49f7179b/arm/shmobile_defconfig/gcc-10/lab-cip/base=
line-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230211.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f4c1c972370164818c8=
631
        new failure (last pass: v4.4.302-cip72-rt42) =

 =



platform               | arch   | lab             | compiler | defconfig   =
                 | regressions
-----------------------+--------+-----------------+----------+-------------=
-----------------+------------
rk3288-veyron-jaq      | arm    | lab-collabora   | gcc-10   | multi_v7_def=
config           | 3          =


  Details:     https://kernelci.org/test/plan/id/63f4c24f6312a2a2398c8688

  Results:     63 PASS, 8 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.167-cip26-2-g28bb49f7179b/arm/multi_v7_defconfig/gcc-10/lab-collabor=
a/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.167-cip26-2-g28bb49f7179b/arm/multi_v7_defconfig/gcc-10/lab-collabor=
a/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230211.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwmmc_rockchip-sdmmc-probed: https://kernelci.org/test/=
case/id/63f4c24f6312a2a2398c86b9
        new failure (last pass: v4.4.302-cip72-rt42)

    2023-02-21T13:08:12.469334  d to last with leading zeros

    2023-02-21T13:08:12.472077  	-s SEP	String separator

    2023-02-21T13:08:12.475636  /lava-9265423/1/../bin/lava-test-case

    2023-02-21T13:08:12.481734  BusyBox v1.31.1 (2023-02-11 11:29:18 UTC) m=
ulti-call binary.

    2023-02-21T13:08:12.482195  =


    2023-02-21T13:08:12.486129  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-02-21T13:08:12.486607  =


    2023-02-21T13:08:12.491592  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-02-21T13:08:12.494157  FIRST, INC default to 1.

    2023-02-21T13:08:12.494368  =

 =

    ... (5 line(s) more)  =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/63f4c24f6312a2a2398c86bc
        failing since 32 days (last pass: v5.10.158-cip22-435-g2c52868ae1cb=
c, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-02-21T13:08:12.392552   multi-call binary.

    2023-02-21T13:08:12.392766  =


    2023-02-21T13:08:12.397142  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-02-21T13:08:12.397602  =


    2023-02-21T13:08:12.402292  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/63f4c24f6312a2a2398c86bd
        failing since 32 days (last pass: v5.10.158-cip22-435-g2c52868ae1cb=
c, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-02-21T13:08:12.372008  <8>[   20.244304] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>

    2023-02-21T13:08:12.390279  BusyBox v1.31.1 (2023-02-11 11:29:18 UTC)<8=
>[   20.261978] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>
   =

 =



platform               | arch   | lab             | compiler | defconfig   =
                 | regressions
-----------------------+--------+-----------------+----------+-------------=
-----------------+------------
rk3399-gru-kevin       | arm64  | lab-collabora   | gcc-10   | defconfig+ar=
m64-chromebook   | 4          =


  Details:     https://kernelci.org/test/plan/id/63f4c576be682d21478c867d

  Results:     86 PASS, 6 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.167-cip26-2-g28bb49f7179b/arm64/defconfig+arm64-chromebook/gcc-10/la=
b-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.167-cip26-2-g28bb49f7179b/arm64/defconfig+arm64-chromebook/gcc-10/la=
b-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230211.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rk3399-gru-sound-driver-rt5514-present: https://kernelc=
i.org/test/case/id/63f4c576be682d21478c86b4
        failing since 33 days (last pass: v5.10.158-cip22-435-g2c52868ae1cb=
c, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-02-21T13:21:47.098001  /lava-9265564/1/../bin/lava-tes<8>[   31.90=
0051] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Drk3399-gru-sound-driver-max98357=
A-present RESULT=3Dfail>

    2023-02-21T13:21:47.098292  t-case

    2023-02-21T13:21:47.104699  BusyBox v1.31.1 (2023-02-11 11:58:29 UTC) m=
ulti-call binary.

    2023-02-21T13:21:47.104825  =


    2023-02-21T13:21:47.109062  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-02-21T13:21:47.109161  =


    2023-02-21T13:21:47.114415  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-02-21T13:21:47.116910  FIRST, INC default to 1.

    2023-02-21T13:21:47.117007  =


    2023-02-21T13:21:47.120086  	-w	Pad to last with leading zeros
 =

    ... (1 line(s) more)  =


  * baseline.bootrr.rk3399-gru-sound-driver-max98357A-present: https://kern=
elci.org/test/case/id/63f4c576be682d21478c86b5
        failing since 33 days (last pass: v5.10.158-cip22-435-g2c52868ae1cb=
c, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-02-21T13:21:47.065026  11:58:29 UTC) multi-call binary.

    2023-02-21T13:21:47.065124  =


    2023-02-21T13:21:47.069402  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-02-21T13:21:47.070030  =


    2023-02-21T13:21:47.074612  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-02-21T13:21:47.077818  FIRST, INC default to 1.

    2023-02-21T13:21:47.078099  =


    2023-02-21T13:21:47.081630  	-w	Pad to last with leading zeros

    2023-02-21T13:21:47.084353  	-s SEP	String separator
   =


  * baseline.bootrr.rk3399-gru-sound-driver-dp-present: https://kernelci.or=
g/test/case/id/63f4c576be682d21478c86b6
        failing since 33 days (last pass: v5.10.158-cip22-435-g2c52868ae1cb=
c, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-02-21T13:21:47.031201  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-02-21T13:21:47.031293  =


    2023-02-21T13:21:47.036941  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-02-21T13:21:47.039594  FIRST, INC default to 1.

    2023-02-21T13:21:47.039688  =


    2023-02-21T13:21:47.043589  	-w	Pad to last with leading zeros

    2023-02-21T13:21:47.045503  	-s SEP	String separator

    2023-02-21T13:21:47.049246  /lava-9265564/1/../bin/lava-test-case

    2023-02-21T13:21:47.062245  BusyBox v1.31.1 (2023-02-11 <8>[   31.86593=
3] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Drk3399-gru-sound-driver-dp-present =
RESULT=3Dfail>
   =


  * baseline.bootrr.rk3399-gru-sound-driver-da7219-present: https://kernelc=
i.org/test/case/id/63f4c576be682d21478c86b7
        failing since 33 days (last pass: v5.10.158-cip22-435-g2c52868ae1cb=
c, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-02-21T13:21:46.995906  <8>[   31.802763] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-present RESULT=3Dpass>

    2023-02-21T13:21:47.016552  BusyBox v1.31.1 (2023-02-11 11:58:29 UTC) m=
ulti-call binary.

    2023-02-21T13:21:47.017205  =


    2023-02-21T13:21:47.026675  <8>[   31.832828] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-da7219-present RESULT=3Dfail>
   =

 =



platform               | arch   | lab             | compiler | defconfig   =
                 | regressions
-----------------------+--------+-----------------+----------+-------------=
-----------------+------------
zynqmp-zcu102          | arm64  | lab-cip         | gcc-10   | defconfig+ar=
m64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63f4c65b71d322817d8c8630

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.167-cip26-2-g28bb49f7179b/arm64/defconfig+arm64-chromebook/gcc-10/la=
b-cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.167-cip26-2-g28bb49f7179b/arm64/defconfig+arm64-chromebook/gcc-10/la=
b-cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230211.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f4c65b71d322817d8c8=
631
        failing since 25 days (last pass: v4.19.269-cip88-rt28-rebase, firs=
t fail: v5.10.162-cip24-443-g1f8fb81fe752) =

 =



platform               | arch   | lab             | compiler | defconfig   =
                 | regressions
-----------------------+--------+-----------------+----------+-------------=
-----------------+------------
zynqmp-zcu102          | arm64  | lab-cip         | gcc-10   | defconfig   =
                 | 1          =


  Details:     https://kernelci.org/test/plan/id/63f4c7c35ad55b27958c8642

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.167-cip26-2-g28bb49f7179b/arm64/defconfig/gcc-10/lab-cip/baseline-zy=
nqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.167-cip26-2-g28bb49f7179b/arm64/defconfig/gcc-10/lab-cip/baseline-zy=
nqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230211.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f4c7c35ad55b27958c8=
643
        failing since 25 days (last pass: v4.19.269-cip88-rt28-rebase, firs=
t fail: v5.10.162-cip24-443-g1f8fb81fe752) =

 =20

