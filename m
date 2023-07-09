Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2CAEB64DC
	for <webhook@archiver.kernel.org>; Sun,  9 Jul 2023 13:00:03 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
 by mx.groups.io with SMTP id smtpd.web10.16837.1688907598879214145
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 09 Jul 2023 05:59:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=VXUqQ+sF;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.178, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-676f16e0bc4so1560766b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 09 Jul 2023 05:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1688907598; x=1691499598;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zMFF9KBYpTL3m8CpxGH6cSW7rzsVwZ1ilCBUkQMlQUE=;
        b=VXUqQ+sFZ4ETZfE8AOXU7nuOcovrxx1fQOkQwaCuH0dAZ47oyyrFBB0WeBeLvxOuwF
         7jH69Ha2+lwlUt5/k3NmB3BvuCpTYwtUNALbiApIpJ5Wg9Oe9zv8FmeRSpvYcZz5X6tg
         rOzO7fNgU/xKEdPgKcImGYndpOKbuUSoQzoOcqdExmpPN1aypg98AeuSCoK+CmLfxvRV
         ITAGGMIP+fF9AMNkDIE7IY63YYA1ukt4DkW92kid/R9GO+H9+lnRNqQBfa/lMiLkYYNO
         z8V2upzFjtAIzc1/nD9K+zZxo0oVqgyG6uu66oCrT50aKcaO+S4qkOQItniz4nN/yOgp
         RLfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688907598; x=1691499598;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zMFF9KBYpTL3m8CpxGH6cSW7rzsVwZ1ilCBUkQMlQUE=;
        b=M2pcFMCN5sDdTxpUsv/eYbuy5mEqPIhsh/Oxc1i73DR7Fwxe3G+nC70s2i/HuFNYxC
         PTCLkbKfPbOeGSB1mavZFhja0W0L7Dq3hZCMORIvTL6k8zvnYfAgIK1uiEh5SiKZ2Zcv
         rY0hNRciL0YyINtZLJPeZAYpL9brjJ7KRwLQ3bBBWLUPUle8ldi5X9fJhVQEBcAy+Cus
         BwhtfsicPr2/6c8cpG90oOxMLoAfKvozFzdRl6E+bVWcsTafPSeaT7D4Yj9Fo1r1fNyy
         8rhPYlwMAt/9KCDyI7yRIEGw4wtST8K/GM20rm1VbYGB0DflmBINYry6RszrIeURrvIS
         sPGg==
X-Gm-Message-State: ABy/qLYz+2bc1Pgn5igOJcGcytJ46uFQLCK2/M+YS09sqEEAC4ZNfMmu
	i5UlIQacBzv82HECCMphZAj5Kt3NYciVMMNmM5U=
X-Google-Smtp-Source: APBJJlF96/Gwiiteq0Ao79w87q4Ps/GbOhq47PilTZv1IefDmC0YDmlH30TBkVUyexSkK3q6fCteSA==
X-Received: by 2002:a05:6a20:938b:b0:12e:ae96:a363 with SMTP id x11-20020a056a20938b00b0012eae96a363mr9559125pzh.34.1688907597299;
        Sun, 09 Jul 2023 05:59:57 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h23-20020aa786d7000000b006826df9e286sm5608670pfo.143.2023.07.09.05.59.55
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jul 2023 05:59:56 -0700 (PDT)
Message-ID: <64aaaf4c.a70a0220.5c83f.a7c6@mx.google.com>
Date: Sun, 09 Jul 2023 05:59:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.31-65-geef5a19d48f6
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
Subject: cip-gitlab/ci/pavel/linux-test baseline: 91 runs,
 19 regressions (v6.1.31-65-geef5a19d48f6)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 09 Jul 2023 13:00:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12281

cip-gitlab/ci/pavel/linux-test baseline: 91 runs, 19 regressions (v6.1.31-6=
5-geef5a19d48f6)

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

juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =

rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 2          =

rk3399-rock-pi-4b            | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.31-65-geef5a19d48f6/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.31-65-geef5a19d48f6
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      eef5a19d48f6fa603cebb6b0341962fd9acc0e3b =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64aaa45730964e92cdbb2aee

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64aaa45730964e92cdbb2af3
        failing since 16 days (last pass: v5.10.182-cip35-8-g2391124f19a70,=
 first fail: v6.1.31-61-g32a95f5a4e3b)

    2023-07-09T12:12:58.750083  <8>[    7.924350] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11049053_1.4.2.3.1>

    2023-07-09T12:12:58.753085  + set +x

    2023-07-09T12:12:58.854468  #

    2023-07-09T12:12:58.955419  / # #export SHELL=3D/bin/sh

    2023-07-09T12:12:58.955625  =


    2023-07-09T12:12:59.056166  / # export SHELL=3D/bin/sh. /lava-11049053/=
environment

    2023-07-09T12:12:59.056371  =


    2023-07-09T12:12:59.156882  / # . /lava-11049053/environment/lava-11049=
053/bin/lava-test-runner /lava-11049053/1

    2023-07-09T12:12:59.157173  =


    2023-07-09T12:12:59.162980  / # /lava-11049053/bin/lava-test-runner /la=
va-11049053/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64aaa46440d5a532b0bb2ac6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64aaa46440d5a532b0bb2acb
        failing since 16 days (last pass: v5.10.182-cip35-8-g2391124f19a70,=
 first fail: v6.1.31-61-g32a95f5a4e3b)

    2023-07-09T12:13:03.715890  + set<8>[   12.146887] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11049044_1.4.2.3.1>

    2023-07-09T12:13:03.716548   +x

    2023-07-09T12:13:03.825346  / # #

    2023-07-09T12:13:03.926880  export SHELL=3D/bin/sh

    2023-07-09T12:13:03.927284  #

    2023-07-09T12:13:04.028109  / # export SHELL=3D/bin/sh. /lava-11049044/=
environment

    2023-07-09T12:13:04.028503  =


    2023-07-09T12:13:04.129514  / # . /lava-11049044/environment/lava-11049=
044/bin/lava-test-runner /lava-11049044/1

    2023-07-09T12:13:04.130924  =


    2023-07-09T12:13:04.135669  / # /lava-11049044/bin/lava-test-runner /la=
va-11049044/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64aaa45f40d5a532b0bb2a77

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64aaa45f40d5a532b0bb2a7c
        failing since 16 days (last pass: v5.10.182-cip35-8-g2391124f19a70,=
 first fail: v6.1.31-61-g32a95f5a4e3b)

    2023-07-09T12:13:03.369417  <8>[   11.287754] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11049056_1.4.2.3.1>

    2023-07-09T12:13:03.372784  + set +x

    2023-07-09T12:13:03.474297  =


    2023-07-09T12:13:03.574868  / # #export SHELL=3D/bin/sh

    2023-07-09T12:13:03.575049  =


    2023-07-09T12:13:03.675556  / # export SHELL=3D/bin/sh. /lava-11049056/=
environment

    2023-07-09T12:13:03.675732  =


    2023-07-09T12:13:03.776252  / # . /lava-11049056/environment/lava-11049=
056/bin/lava-test-runner /lava-11049056/1

    2023-07-09T12:13:03.776548  =


    2023-07-09T12:13:03.781168  / # /lava-11049056/bin/lava-test-runner /la=
va-11049056/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | bcm283=
5_defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/64aaa2ceda9b63c9eebb2add

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/arm/bcm2835_defconfig/gcc-10/lab-collabora/baseli=
ne-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/arm/bcm2835_defconfig/gcc-10/lab-collabora/baseli=
ne-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64aaa2ceda9b63c9eebb2ae2
        failing since 16 days (last pass: v5.10.182-cip35-8-g2391124f19a70,=
 first fail: v6.1.31-61-g32a95f5a4e3b)

    2023-07-09T12:07:55.407579  / # #

    2023-07-09T12:07:55.509928  export SHELL=3D/bin/sh

    2023-07-09T12:07:55.510692  #

    2023-07-09T12:07:55.612147  / # export SHELL=3D/bin/sh. /lava-11048889/=
environment

    2023-07-09T12:07:55.612943  =


    2023-07-09T12:07:55.714432  / # . /lava-11048889/environment/lava-11048=
889/bin/lava-test-runner /lava-11048889/1

    2023-07-09T12:07:55.715644  =


    2023-07-09T12:07:55.732424  / # /lava-11048889/bin/lava-test-runner /la=
va-11048889/1

    2023-07-09T12:07:55.843310  + export 'TESTRUN_ID=3D1_bootrr'

    2023-07-09T12:07:55.843826  + cd /lava-11048889/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64aaa5a85a56518972bb2b0c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/arm/multi_v7_defconfig/gcc-10/lab-collabora/basel=
ine-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/arm/multi_v7_defconfig/gcc-10/lab-collabora/basel=
ine-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64aaa5a85a56518972bb2=
b0d
        failing since 24 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64aaa3a7f64ca09728bb2a7d

  Results:     52 PASS, 3 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseli=
ne-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseli=
ne-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64aaa3a7f64ca09728bb2ab1
        failing since 24 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-07-09T12:10:01.042786  <8>[   18.109200] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 705174_1.5.2.4.1>
    2023-07-09T12:10:01.154839  / # #
    2023-07-09T12:10:01.258068  export SHELL=3D/bin/sh
    2023-07-09T12:10:01.258964  #
    2023-07-09T12:10:01.360979  / # export SHELL=3D/bin/sh. /lava-705174/en=
vironment
    2023-07-09T12:10:01.361875  =

    2023-07-09T12:10:01.463974  / # . /lava-705174/environment/lava-705174/=
bin/lava-test-runner /lava-705174/1
    2023-07-09T12:10:01.465411  =

    2023-07-09T12:10:01.470073  / # /lava-705174/bin/lava-test-runner /lava=
-705174/1
    2023-07-09T12:10:01.585046  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64aaa56bc111ecb59fbb2a7e

  Results:     52 PASS, 3 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-b=
eaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-b=
eaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64aaa56bc111ecb59fbb2a81
        failing since 24 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-07-09T12:17:36.811784  + set +x
    2023-07-09T12:17:36.813728  <8>[   15.883388] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 984106_1.5.2.4.1>
    2023-07-09T12:17:36.922408  / # #
    2023-07-09T12:17:37.024293  export SHELL=3D/bin/sh
    2023-07-09T12:17:37.024748  #
    2023-07-09T12:17:37.126147  / # export SHELL=3D/bin/sh. /lava-984106/en=
vironment
    2023-07-09T12:17:37.126711  =

    2023-07-09T12:17:37.228126  / # . /lava-984106/environment/lava-984106/=
bin/lava-test-runner /lava-984106/1
    2023-07-09T12:17:37.228874  =

    2023-07-09T12:17:37.231143  / # /lava-984106/bin/lava-test-runner /lava=
-984106/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64aaa694dd691c4985bb2a75

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64aaa694dd691c4985bb2a7a
        failing since 24 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-07-09T12:23:02.369040  + set +x

    2023-07-09T12:23:02.375711  <8>[   12.328775] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11048984_1.4.2.3.1>

    2023-07-09T12:23:02.480321  / # #

    2023-07-09T12:23:02.580977  export SHELL=3D/bin/sh

    2023-07-09T12:23:02.581182  #

    2023-07-09T12:23:02.681697  / # export SHELL=3D/bin/sh. /lava-11048984/=
environment

    2023-07-09T12:23:02.681899  =


    2023-07-09T12:23:02.782435  / # . /lava-11048984/environment/lava-11048=
984/bin/lava-test-runner /lava-11048984/1

    2023-07-09T12:23:02.782743  =


    2023-07-09T12:23:02.787408  / # /lava-11048984/bin/lava-test-runner /la=
va-11048984/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64aaa5ef552c39d6c2bb2af5

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64aaa5ef552c39d6c2bb2afa
        failing since 24 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-07-09T12:19:41.584100  + set +x

    2023-07-09T12:19:41.590695  <8>[   10.592449] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11049055_1.4.2.3.1>

    2023-07-09T12:19:41.697936  =


    2023-07-09T12:19:41.798517  / # #export SHELL=3D/bin/sh

    2023-07-09T12:19:41.798709  =


    2023-07-09T12:19:41.899234  / # export SHELL=3D/bin/sh. /lava-11049055/=
environment

    2023-07-09T12:19:41.899461  =


    2023-07-09T12:19:42.000185  / # . /lava-11049055/environment/lava-11049=
055/bin/lava-test-runner /lava-11049055/1

    2023-07-09T12:19:42.001483  =


    2023-07-09T12:19:42.006845  / # /lava-11049055/bin/lava-test-runner /la=
va-11049055/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64aaa45f40d5a532b0bb2a82

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64aaa45f40d5a532b0bb2a87
        failing since 16 days (last pass: v5.10.182-cip35-8-g2391124f19a70,=
 first fail: v6.1.31-61-g32a95f5a4e3b)

    2023-07-09T12:13:05.441118  + set<8>[   10.762469] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11048989_1.4.2.3.1>

    2023-07-09T12:13:05.441321   +x

    2023-07-09T12:13:05.546616  / # #

    2023-07-09T12:13:05.647810  export SHELL=3D/bin/sh

    2023-07-09T12:13:05.648512  #

    2023-07-09T12:13:05.749879  / # export SHELL=3D/bin/sh. /lava-11048989/=
environment

    2023-07-09T12:13:05.750584  =


    2023-07-09T12:13:05.851949  / # . /lava-11048989/environment/lava-11048=
989/bin/lava-test-runner /lava-11048989/1

    2023-07-09T12:13:05.853113  =


    2023-07-09T12:13:05.857655  / # /lava-11048989/bin/lava-test-runner /la=
va-11048989/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64aaa4beff8bac9230bb2afc

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/bas=
eline-imx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/bas=
eline-imx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64aaa4beff8bac9230bb2b01
        failing since 17 days (last pass: v5.10.182-cip35-8-g2391124f19a70,=
 first fail: v6.1.31-61-g32a95f5a4e3b)

    2023-07-09T12:14:29.246126  + set +x
    2023-07-09T12:14:29.246285  [   12.893144] <LAVA_SIGNAL_ENDRUN 0_dmesg =
994529_1.5.2.3.1>
    2023-07-09T12:14:29.353953  / # #
    2023-07-09T12:14:29.455716  export SHELL=3D/bin/sh
    2023-07-09T12:14:29.456116  #
    2023-07-09T12:14:29.557449  / # export SHELL=3D/bin/sh. /lava-994529/en=
vironment
    2023-07-09T12:14:29.557927  =

    2023-07-09T12:14:29.659144  / # . /lava-994529/environment/lava-994529/=
bin/lava-test-runner /lava-994529/1
    2023-07-09T12:14:29.659659  =

    2023-07-09T12:14:29.663106  / # /lava-994529/bin/lava-test-runner /lava=
-994529/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64aaa6ba0dfd1cc1cbbb2a75

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseli=
ne-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseli=
ne-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64aaa6ba0dfd1cc1cbbb2=
a76
        failing since 24 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64aaa6a1dd691c4985bb2a9f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseli=
ne-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseli=
ne-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64aaa6a1dd691c4985bb2=
aa0
        failing since 24 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64aaa9b7d4baebe125bb2a77

  Results:     60 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-=
uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-=
uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64aaa9b7d4baebe125bb2aaa
        failing since 16 days (last pass: v5.10.182-cip35-8-g2391124f19a70,=
 first fail: v6.1.31-61-g32a95f5a4e3b)

    2023-07-09T12:35:43.490016  <8>[   14.147299] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 705320_1.5.2.4.1>
    2023-07-09T12:35:43.597717  / # #
    2023-07-09T12:35:43.700530  export SHELL=3D/bin/sh
    2023-07-09T12:35:43.701258  #
    2023-07-09T12:35:43.803171  / # export SHELL=3D/bin/sh. /lava-705320/en=
vironment
    2023-07-09T12:35:43.803939  =

    2023-07-09T12:35:43.905910  / # . /lava-705320/environment/lava-705320/=
bin/lava-test-runner /lava-705320/1
    2023-07-09T12:35:43.907227  =

    2023-07-09T12:35:43.921315  / # /lava-705320/bin/lava-test-runner /lava=
-705320/1
    2023-07-09T12:35:43.985558  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (41 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64aaa44bcbd92d5477bb2a76

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64aaa44bcbd92d5477bb2a7b
        failing since 16 days (last pass: v5.10.182-cip35-8-g2391124f19a70,=
 first fail: v6.1.31-61-g32a95f5a4e3b)

    2023-07-09T12:12:53.412730  <8>[   11.777026] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11049003_1.4.2.3.1>

    2023-07-09T12:12:53.517612  / # #

    2023-07-09T12:12:53.618211  export SHELL=3D/bin/sh

    2023-07-09T12:12:53.618435  #

    2023-07-09T12:12:53.719016  / # export SHELL=3D/bin/sh. /lava-11049003/=
environment

    2023-07-09T12:12:53.719222  =


    2023-07-09T12:12:53.819752  / # . /lava-11049003/environment/lava-11049=
003/bin/lava-test-runner /lava-11049003/1

    2023-07-09T12:12:53.820043  =


    2023-07-09T12:12:53.825099  / # /lava-11049003/bin/lava-test-runner /la=
va-11049003/1

    2023-07-09T12:12:53.831598  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64aaa285f07416a459bb2a75

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8=
a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8=
a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64aaa285f07416a459bb2=
a76
        new failure (last pass: v6.1.31-61-g32a95f5a4e3b) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 2          =


  Details:     https://kernelci.org/test/plan/id/64aaa4cce761c04b30bb2b0c

  Results:     66 PASS, 4 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/arm/multi_v7_defconfig/gcc-10/lab-collabora/basel=
ine-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/arm/multi_v7_defconfig/gcc-10/lab-collabora/basel=
ine-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/64aaa4cce761c04b30bb2b3c
        failing since 170 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-07-09T12:16:39.348189  Usage: seq [-w] [-s SEP] [FIRST [INC]] LA<8=
>[   19.597908] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-07-09T12:16:39.348419  ST

    2023-07-09T12:16:39.348481  =


    2023-07-09T12:16:39.353662  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-07-09T12:16:39.356008  FIRST, INC default to 1.

    2023-07-09T12:16:39.356396  =


    2023-07-09T12:16:39.359735  	-w	Pad to last with leading zeros

    2023-07-09T12:16:39.362342  	-s SEP	String separator

    2023-07-09T12:16:39.366220  /lava-11049072/1/../bin/lava-test-case
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/64aaa4cce761c04b30bb2b3d
        failing since 170 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-07-09T12:16:39.318497  <8>[   19.575007] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>

    2023-07-09T12:16:39.333854  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.

    2023-07-09T12:16:39.333925  =

   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64aaa8da2f749a39c4bb2aa5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3=
399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3=
399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64aaa8da2f749a39c4bb2aaa
        failing since 17 days (last pass: v5.10.182-cip35-8-g2391124f19a70,=
 first fail: v6.1.31-61-g32a95f5a4e3b)

    2023-07-09T12:32:05.866827  / # #

    2023-07-09T12:32:07.134318  export SHELL=3D/bin/sh

    2023-07-09T12:32:07.145523  #

    2023-07-09T12:32:08.897619  / # export SHELL=3D/bin/sh. /lava-11049103/=
environment

    2023-07-09T12:32:08.908784  =


    2023-07-09T12:32:08.909280  / # . /lava-11049103/environment

    2023-07-09T12:32:12.119581  / # /lava-11049103/bin/lava-test-runner /la=
va-11049103/1

    2023-07-09T12:32:12.132027  /lava-11049103/bin/lava-test-runner /lava-1=
1049103/1

    2023-07-09T12:32:12.191160  + export 'TESTRUN_ID=3D1_bootrr'

    2023-07-09T12:32:12.191705  + cd /lava-11049103/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =20

