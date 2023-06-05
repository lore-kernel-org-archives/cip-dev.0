Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04C0C77B73
	for <webhook@archiver.kernel.org>; Mon,  5 Jun 2023 23:10:46 +0000 (UTC)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
 by mx.groups.io with SMTP id smtpd.web10.1294.1686006640208299132
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Jun 2023 16:10:40 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=XzmgMjm3;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.181, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-53f832298acso3205152a12.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Jun 2023 16:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686006639; x=1688598639;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=His2QI547W0qL3KJHwGygNl3ciSh7YcARWUq8n+bfLs=;
        b=XzmgMjm3ZME7iFQaLy7SWtVVq0n5zxv0PDSIF1Q0r3oy8rHlFquIeQ6BTiBYoMFHjv
         Pz1KlnwU/PPKuKK3YiJ2DxNVbuj4Xwk4Wf6P3JlNb4F1hgqN00F37U/WOeG3D/5Kgs9Y
         XCmifGhKRR6uBJsEU+PkrPUYiekvcoQ30owGMNi/IuB6VHylTpZj5AvFkea/r8eobnkB
         UDCnWu5j2ALYOo6cF5f/stZYAXsEaebtMuQovK9IB5DAMEKK9vd1jMjvG3X8qvlQYFmL
         R+liKH6YmGtuuSJEeBUTiNK90UqfuWGo38i0ie9m8k8Ow24yG9gs2bJF6821JgGNcj1g
         k4xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686006639; x=1688598639;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=His2QI547W0qL3KJHwGygNl3ciSh7YcARWUq8n+bfLs=;
        b=MkH+97vyImoJg7Uj9/u628P/48Hmi4v+SyGBCjtY7mcIQ6Tmb4GVBaVVv84KPyfwwp
         g8y3cWwEZohhy0xZMmvqQMAoviivKF6Uc6LPJz9QFJ45fdgYYK9oJep4+YW6OWfTQqiG
         nb4htQYAhqUG9ExbWqbam/QBWXiK6GPMd6SHSANe7DSZtBKiZooc73oS+4xY2ofhUyYf
         H9wWUGfvxLL084PTqkbfSpNyPr/DWF1UYQ38i4y/P24RKzGc7GdQRZnOzAoClEQdJ5Uv
         V1ymARgWRWf4GYtb++8gr4Od17hPtQTb0L6eXnNMKduNjJj7nVGZ3PfwFMh8pFtwJF+b
         8+JQ==
X-Gm-Message-State: AC+VfDzax65xII6FezCHjfjmDiF74GeBWC/zs6TeGZCG34SzvbNwMzJY
	xm08/2vrLqSQFDuVjFFz65cAJ6klNzlV15xxD22Txg==
X-Google-Smtp-Source: ACHHUZ7zWo+vkl6W+6OjkplojS8qKsmcFwwqXKc4siPDwLwTYrCbReNg3zIiyscpLX2VDgDdaOOjuA==
X-Received: by 2002:a17:902:ec81:b0:1b0:4687:ba0c with SMTP id x1-20020a170902ec8100b001b04687ba0cmr414741plg.8.1686006638108;
        Mon, 05 Jun 2023 16:10:38 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q3-20020a17090311c300b001b0295de9acsm7091157plh.179.2023.06.05.16.10.37
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 16:10:37 -0700 (PDT)
Message-ID: <647e6b6d.170a0220.42ec6.d0da@mx.google.com>
Date: Mon, 05 Jun 2023 16:10:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.26-1314-g1ab0ac1d7e2e3
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test baseline: 117 runs,
 20 regressions (v6.1.26-1314-g1ab0ac1d7e2e3)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jun 2023 23:10:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11827

cip-gitlab/ci/pavel/linux-test baseline: 117 runs, 20 regressions (v6.1.26-=
1314-g1ab0ac1d7e2e3)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | bcm283=
5_defconfig            | 1          =

bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =

fsl-ls1088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx8mn-ddr4-evk              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 2          =

rk3399-rock-pi-4b            | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.26-1314-g1ab0ac1d7e2e3/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.26-1314-g1ab0ac1d7e2e3
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      1ab0ac1d7e2e3aeca50f8616b469772a5f010acc =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647e5f356607e439ecf5de26

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647e5f356607e439ecf5de2f
        new failure (last pass: v5.10.180-cip34-26-gc198172c84b6a)

    2023-06-05T22:18:12.151365  <8>[    7.867137] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10597387_1.4.2.3.1>

    2023-06-05T22:18:12.155194  + set +x

    2023-06-05T22:18:12.256799  /#

    2023-06-05T22:18:12.357754   # #export SHELL=3D/bin/sh

    2023-06-05T22:18:12.357998  =


    2023-06-05T22:18:12.458576  / # export SHELL=3D/bin/sh. /lava-10597387/=
environment

    2023-06-05T22:18:12.458779  =


    2023-06-05T22:18:12.559318  / # . /lava-10597387/environment/lava-10597=
387/bin/lava-test-runner /lava-10597387/1

    2023-06-05T22:18:12.559638  =


    2023-06-05T22:18:12.565332  / # /lava-10597387/bin/lava-test-runner /la=
va-10597387/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647e5f3184f24cf3ccf5de81

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647e5f3184f24cf3ccf5de8a
        new failure (last pass: v5.10.180-cip34-26-gc198172c84b6a)

    2023-06-05T22:18:14.582187  + <8>[   11.999937] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10597372_1.4.2.3.1>

    2023-06-05T22:18:14.582758  set +x

    2023-06-05T22:18:14.690368  / # #

    2023-06-05T22:18:14.792729  export SHELL=3D/bin/sh

    2023-06-05T22:18:14.793594  #

    2023-06-05T22:18:14.895230  / # export SHELL=3D/bin/sh. /lava-10597372/=
environment

    2023-06-05T22:18:14.896023  =


    2023-06-05T22:18:14.997704  / # . /lava-10597372/environment/lava-10597=
372/bin/lava-test-runner /lava-10597372/1

    2023-06-05T22:18:14.998993  =


    2023-06-05T22:18:15.003878  / # /lava-10597372/bin/lava-test-runner /la=
va-10597372/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647e5f32656eccfc99f5de53

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647e5f32656eccfc99f5de5c
        new failure (last pass: v5.10.180-cip34-26-gc198172c84b6a)

    2023-06-05T22:18:07.533629  <8>[   10.791107] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10597317_1.4.2.3.1>

    2023-06-05T22:18:07.537094  + set +x

    2023-06-05T22:18:07.638467  =


    2023-06-05T22:18:07.739028  / # #export SHELL=3D/bin/sh

    2023-06-05T22:18:07.739199  =


    2023-06-05T22:18:07.839689  / # export SHELL=3D/bin/sh. /lava-10597317/=
environment

    2023-06-05T22:18:07.839911  =


    2023-06-05T22:18:07.940416  / # . /lava-10597317/environment/lava-10597=
317/bin/lava-test-runner /lava-10597317/1

    2023-06-05T22:18:07.940643  =


    2023-06-05T22:18:07.945528  / # /lava-10597317/bin/lava-test-runner /la=
va-10597317/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | bcm283=
5_defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/647e5fc5b0ef17ce37f5de2b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/arm/bcm2835_defconfig/gcc-10/lab-collabora/bas=
eline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/arm/bcm2835_defconfig/gcc-10/lab-collabora/bas=
eline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647e5fc5b0ef17ce37f5de34
        new failure (last pass: v5.10.180-cip34-26-gc198172c84b6a)

    2023-06-05T22:21:06.392918  / # #

    2023-06-05T22:21:06.495067  export SHELL=3D/bin/sh

    2023-06-05T22:21:06.495767  #

    2023-06-05T22:21:06.597148  / # export SHELL=3D/bin/sh. /lava-10597306/=
environment

    2023-06-05T22:21:06.597889  =


    2023-06-05T22:21:06.699337  / # . /lava-10597306/environment/lava-10597=
306/bin/lava-test-runner /lava-10597306/1

    2023-06-05T22:21:06.700440  =


    2023-06-05T22:21:06.717417  / # /lava-10597306/bin/lava-test-runner /la=
va-10597306/1

    2023-06-05T22:21:06.826233  + export 'TESTRUN_ID=3D1_bootrr'

    2023-06-05T22:21:06.826751  + cd /lava-10597306/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647e5f2584f24cf3ccf5de4f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/arm/multi_v7_defconfig/gcc-10/lab-collabora/ba=
seline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/arm/multi_v7_defconfig/gcc-10/lab-collabora/ba=
seline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647e5f2584f24cf3ccf5d=
e50
        failing since 2 days (last pass: v4.19.280-cip95-rt30, first fail: =
v6.1.26-1281-g84d5372e0f31) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647e5f017fd80b5e50f5de4e

  Results:     52 PASS, 3 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/arm/omap2plus_defconfig/gcc-10/lab-broonie/bas=
eline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/arm/omap2plus_defconfig/gcc-10/lab-broonie/bas=
eline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647e5f017fd80b5e50f5de87
        failing since 2 days (last pass: v4.19.280-cip95-rt30, first fail: =
v6.1.26-1281-g84d5372e0f31)

    2023-06-05T22:17:23.095434  <8>[   20.788215] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 566137_1.5.2.4.1>
    2023-06-05T22:17:23.205832  / # #
    2023-06-05T22:17:23.308448  export SHELL=3D/bin/sh
    2023-06-05T22:17:23.309205  #
    2023-06-05T22:17:23.411555  / # export SHELL=3D/bin/sh. /lava-566137/en=
vironment
    2023-06-05T22:17:23.412352  =

    2023-06-05T22:17:23.514799  / # . /lava-566137/environment/lava-566137/=
bin/lava-test-runner /lava-566137/1
    2023-06-05T22:17:23.516004  =

    2023-06-05T22:17:23.520489  / # /lava-566137/bin/lava-test-runner /lava=
-566137/1
    2023-06-05T22:17:23.630775  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647e66bb2f183edd61f5de25

  Results:     52 PASS, 3 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/arm/omap2plus_defconfig/gcc-10/lab-cip/baselin=
e-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/arm/omap2plus_defconfig/gcc-10/lab-cip/baselin=
e-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647e66bb2f183edd61f5de2c
        failing since 2 days (last pass: v4.19.280-cip95-rt30, first fail: =
v6.1.26-1281-g84d5372e0f31)

    2023-06-05T22:50:24.921338  + set +x
    2023-06-05T22:50:24.923427  <8>[   15.907190] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 953764_1.5.2.4.1>
    2023-06-05T22:50:25.033137  / # #
    2023-06-05T22:50:25.135009  export SHELL=3D/bin/sh
    2023-06-05T22:50:25.135512  #
    2023-06-05T22:50:25.236921  / # export SHELL=3D/bin/sh. /lava-953764/en=
vironment
    2023-06-05T22:50:25.237387  =

    2023-06-05T22:50:25.338835  / # . /lava-953764/environment/lava-953764/=
bin/lava-test-runner /lava-953764/1
    2023-06-05T22:50:25.339798  =

    2023-06-05T22:50:25.341924  / # /lava-953764/bin/lava-test-runner /lava=
-953764/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls1088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/647e5ca3f4a8a4111af5df1b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls=
1088a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls=
1088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647e5ca3f4a8a4111af5df22
        failing since 2 days (last pass: v4.19.280-cip95-rt30, first fail: =
v6.1.26-1281-g84d5372e0f31)

    2023-06-05T22:07:13.578712  + set +x
    2023-06-05T22:07:13.580508  [   19.115142] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1233921_1.5.2.4.1>
    2023-06-05T22:07:13.688132  / # #
    2023-06-05T22:07:13.790011  export SHELL=3D/bin/sh
    2023-06-05T22:07:13.790456  #
    2023-06-05T22:07:13.891857  / # export SHELL=3D/bin/sh. /lava-1233921/e=
nvironment
    2023-06-05T22:07:13.892302  =

    2023-06-05T22:07:13.993722  / # . /lava-1233921/environment/lava-123392=
1/bin/lava-test-runner /lava-1233921/1
    2023-06-05T22:07:13.994474  =

    2023-06-05T22:07:13.996567  / # /lava-1233921/bin/lava-test-runner /lav=
a-1233921/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647e5f1e03428c4eaff5de65

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647e5f1e03428c4eaff5de6e
        failing since 2 days (last pass: v4.19.280-cip95-rt30, first fail: =
v6.1.26-1281-g84d5372e0f31)

    2023-06-05T22:18:02.208104  + set +x

    2023-06-05T22:18:02.214134  <8>[   11.363762] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10597366_1.4.2.3.1>

    2023-06-05T22:18:02.318814  / # #

    2023-06-05T22:18:02.419417  export SHELL=3D/bin/sh

    2023-06-05T22:18:02.419646  #

    2023-06-05T22:18:02.520286  / # export SHELL=3D/bin/sh. /lava-10597366/=
environment

    2023-06-05T22:18:02.520495  =


    2023-06-05T22:18:02.621037  / # . /lava-10597366/environment/lava-10597=
366/bin/lava-test-runner /lava-10597366/1

    2023-06-05T22:18:02.621381  =


    2023-06-05T22:18:02.625546  / # /lava-10597366/bin/lava-test-runner /la=
va-10597366/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647e5f2684f24cf3ccf5de5d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647e5f2684f24cf3ccf5de66
        failing since 2 days (last pass: v4.19.280-cip95-rt30, first fail: =
v6.1.26-1281-g84d5372e0f31)

    2023-06-05T22:18:00.892008  + set +x

    2023-06-05T22:18:00.898429  <8>[   10.243973] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10597362_1.4.2.3.1>

    2023-06-05T22:18:01.006621  / # #

    2023-06-05T22:18:01.108752  export SHELL=3D/bin/sh

    2023-06-05T22:18:01.109386  #

    2023-06-05T22:18:01.210667  / # export SHELL=3D/bin/sh. /lava-10597362/=
environment

    2023-06-05T22:18:01.211423  =


    2023-06-05T22:18:01.312832  / # . /lava-10597362/environment/lava-10597=
362/bin/lava-test-runner /lava-10597362/1

    2023-06-05T22:18:01.313116  =


    2023-06-05T22:18:01.318073  / # /lava-10597362/bin/lava-test-runner /la=
va-10597362/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647e5f31656eccfc99f5de30

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647e5f31656eccfc99f5de39
        new failure (last pass: v5.10.180-cip34-26-gc198172c84b6a)

    2023-06-05T22:18:02.800841  + <8>[    8.638084] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10597383_1.4.2.3.1>

    2023-06-05T22:18:02.800935  set +x

    2023-06-05T22:18:02.905004  / # #

    2023-06-05T22:18:03.005631  export SHELL=3D/bin/sh

    2023-06-05T22:18:03.005832  #

    2023-06-05T22:18:03.106321  / # export SHELL=3D/bin/sh. /lava-10597383/=
environment

    2023-06-05T22:18:03.106528  =


    2023-06-05T22:18:03.207089  / # . /lava-10597383/environment/lava-10597=
383/bin/lava-test-runner /lava-10597383/1

    2023-06-05T22:18:03.207463  =


    2023-06-05T22:18:03.212397  / # /lava-10597383/bin/lava-test-runner /la=
va-10597383/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647e5e1b2d7fab8669f5de47

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/=
baseline-imx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/=
baseline-imx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647e5e1b2d7fab8669f5de50
        new failure (last pass: v5.10.180-cip34-26-gc198172c84b6a)

    2023-06-05T22:13:21.789064  + set +x
    2023-06-05T22:13:21.789234  [   12.853561] <LAVA_SIGNAL_ENDRUN 0_dmesg =
968299_1.5.2.3.1>
    2023-06-05T22:13:21.896878  / # #
    2023-06-05T22:13:21.998539  export SHELL=3D/bin/sh
    2023-06-05T22:13:21.999029  #
    2023-06-05T22:13:22.100262  / # export SHELL=3D/bin/sh. /lava-968299/en=
vironment
    2023-06-05T22:13:22.100711  =

    2023-06-05T22:13:22.201941  / # . /lava-968299/environment/lava-968299/=
bin/lava-test-runner /lava-968299/1
    2023-06-05T22:13:22.202559  =

    2023-06-05T22:13:22.206073  / # /lava-968299/bin/lava-test-runner /lava=
-968299/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647e5ff1be7bb2b0b4f5df2c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/bas=
eline-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/bas=
eline-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647e5ff1be7bb2b0b4f5d=
f2d
        failing since 2 days (last pass: v4.19.280-cip95-rt30, first fail: =
v6.1.26-1281-g84d5372e0f31) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647e60401df2b3b621f5df62

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/bas=
eline-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/bas=
eline-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647e60401df2b3b621f5d=
f63
        failing since 2 days (last pass: v4.19.280-cip95-rt30, first fail: =
v6.1.26-1281-g84d5372e0f31) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx8mn-ddr4-evk              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/647e5c7ff392bd900ff5de2e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/arm64/defconfig/gcc-10/lab-nxp/baseline-imx8mn=
-ddr4-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/arm64/defconfig/gcc-10/lab-nxp/baseline-imx8mn=
-ddr4-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647e5c7ff392bd900ff5de35
        new failure (last pass: v5.10.180-cip34-26-gc198172c84b6a)

    2023-06-05T22:06:25.233829  + set<8>[   19.320235] <LAVA_SIGNAL_ENDRUN =
0_dmesg 1233920_1.5.2.4.1>
    2023-06-05T22:06:25.234080   +x
    2023-06-05T22:06:25.339618  / # #
    2023-06-05T22:06:26.499323  export SHELL=3D/bin/sh
    2023-06-05T22:06:26.505011  #
    2023-06-05T22:06:28.052035  / # export SHELL=3D/bin/sh. /lava-1233920/e=
nvironment
    2023-06-05T22:06:28.057740  =

    2023-06-05T22:06:30.878590  / # . /lava-1233920/environment/lava-123392=
0/bin/lava-test-runner /lava-1233920/1
    2023-06-05T22:06:30.884645  =

    2023-06-05T22:06:30.884932  / # /lava-1233920/bin/lava<6>[   23.417987]=
 platform sound-bt-sco: deferred probe pending =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/647e5ecd05f85f5dfcf5de25

  Results:     60 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/arm64/defconfig/gcc-10/lab-broonie/baseline-ju=
no-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/arm64/defconfig/gcc-10/lab-broonie/baseline-ju=
no-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647e5ecd05f85f5dfcf5de63
        new failure (last pass: v5.10.180-cip34-26-gc198172c84b6a)

    2023-06-05T22:16:18.828925  <8>[   11.468432] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 566071_1.5.2.4.1>
    2023-06-05T22:16:18.938100  / # #
    2023-06-05T22:16:19.041233  export SHELL=3D/bin/sh
    2023-06-05T22:16:19.042025  #
    2023-06-05T22:16:19.144023  / # export SHELL=3D/bin/sh. /lava-566071/en=
vironment
    2023-06-05T22:16:19.144895  =

    2023-06-05T22:16:19.246903  / # . /lava-566071/environment/lava-566071/=
bin/lava-test-runner /lava-566071/1
    2023-06-05T22:16:19.248336  =

    2023-06-05T22:16:19.260278  / # /lava-566071/bin/lava-test-runner /lava=
-566071/1
    2023-06-05T22:16:19.326224  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (41 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647e5f2784f24cf3ccf5de68

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647e5f2784f24cf3ccf5de71
        new failure (last pass: v5.10.180-cip34-26-gc198172c84b6a)

    2023-06-05T22:18:00.309028  <8>[   11.999101] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10597358_1.4.2.3.1>

    2023-06-05T22:18:00.413308  / # #

    2023-06-05T22:18:00.513899  export SHELL=3D/bin/sh

    2023-06-05T22:18:00.514148  #

    2023-06-05T22:18:00.614694  / # export SHELL=3D/bin/sh. /lava-10597358/=
environment

    2023-06-05T22:18:00.614911  =


    2023-06-05T22:18:00.715424  / # . /lava-10597358/environment/lava-10597=
358/bin/lava-test-runner /lava-10597358/1

    2023-06-05T22:18:00.715657  =


    2023-06-05T22:18:00.719813  / # /lava-10597358/bin/lava-test-runner /la=
va-10597358/1

    2023-06-05T22:18:00.726791  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 2          =


  Details:     https://kernelci.org/test/plan/id/647e5e350ae28f6be1f5de3b

  Results:     66 PASS, 4 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/arm/multi_v7_defconfig/gcc-10/lab-collabora/ba=
seline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/arm/multi_v7_defconfig/gcc-10/lab-collabora/ba=
seline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/647e5e350ae28f6be1f5de6f
        failing since 136 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-06-05T22:14:42.349645  Usage: seq [-w] [-s SEP] [FIRST [INC]] LA<8=
>[   20.711098] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-06-05T22:14:42.350111  ST

    2023-06-05T22:14:42.350331  =


    2023-06-05T22:14:42.355209  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-06-05T22:14:42.357798  FIRST, INC default to 1.

    2023-06-05T22:14:42.357855  =


    2023-06-05T22:14:42.361361  	-w	Pad to last with leading zeros

    2023-06-05T22:14:42.363833  	-s SEP	String separator

    2023-06-05T22:14:42.367856  /lava-10597211/1/../bin/lava-test-case
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/647e5e350ae28f6be1f5de70
        failing since 136 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-06-05T22:14:42.319032  <8>[   20.687879] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>

    2023-06-05T22:14:42.335289  BusyBox v1.31.1 (2023-05-27 14:14:16 UTC) m=
ulti-call binary.

    2023-06-05T22:14:42.335355  =

   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/647e5c3c645101ed8cf5dea1

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/arm64/defconfig/gcc-10/lab-collabora/baseline-=
rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/arm64/defconfig/gcc-10/lab-collabora/baseline-=
rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647e5c3c645101ed8cf5deaa
        new failure (last pass: v5.10.180-cip34-26-gc198172c84b6a)

    2023-06-05T22:05:34.415827  / # #

    2023-06-05T22:05:35.670312  export SHELL=3D/bin/sh

    2023-06-05T22:05:35.680635  #

    2023-06-05T22:05:37.417352  / # export SHELL=3D/bin/sh. /lava-10597188/=
environment

    2023-06-05T22:05:37.427876  =


    2023-06-05T22:05:40.631375  / # . /lava-10597188/environment/lava-10597=
188/bin/lava-test-runner /lava-10597188/1

    2023-06-05T22:05:40.642987  =


    2023-06-05T22:05:40.643375  / # /lava-10597188/bin/lava-test-runner /la=
va-10597188/1

    2023-06-05T22:05:40.700969  + export 'TESTRUN_ID=3D1_bootrr'

    2023-06-05T22:05:40.701505  + cd /lava-10597188/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =20

