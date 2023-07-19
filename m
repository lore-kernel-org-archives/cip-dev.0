Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4330C001DE
	for <webhook@archiver.kernel.org>; Wed, 19 Jul 2023 13:21:56 +0000 (UTC)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
 by mx.groups.io with SMTP id smtpd.web11.13535.1689772915506686191
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 19 Jul 2023 06:21:55 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=GbnJpy7h;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.173, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-66f5faba829so5109754b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 19 Jul 2023 06:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689772914; x=1692364914;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SE887gjuGVi8uYcuzDXdvbxn8rMrGFGfbZbhaJ5tZ+c=;
        b=GbnJpy7hh3oDJiHvnf+vStC48MHTzaPVYvoG0MR28fLYsnQOBy2/ZFrX1AvmOoUEFK
         wIAHX/rCLC7aTlmJHxTmKrMckj9XW3dDYDxl0L1uL12csUVlRU6NXfCi8v18UzZgV+N2
         P0dYixqVn6mFNoq8Y1WCxnRv9N26d+Z2dfJ56i4jzafT6LUbScdw+YqJMx+QQNtZGthh
         TmkcRYo0d4Wt257g9XAEVbSpg3DPDmOcmAMLAn0B64Ty9nE++uG0NSFoJiuVmU1NqF9z
         F0arSpREgiskLrlmPzE+X4vjQWDFsZ2EZgEYKA6K0GUL1Nm5vooZgQDN60tyqfg5ReD/
         YFHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689772914; x=1692364914;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SE887gjuGVi8uYcuzDXdvbxn8rMrGFGfbZbhaJ5tZ+c=;
        b=gM5Ce+sHoPXJc2lo4gzdSdbjYfZWOMaPQvd4iF2GFC3/i8Q270tQhRv2TQUdCx1JH0
         SSyZ86N3qUTSktIWh9OYu+7AinNA+WLbt6DIE5biBaQGCzc7Ay6zzs2O3L9RxfcgM35N
         0BzLuTR7E3lkoPmZ6TeS42irxLmOeUVbKGFY/+4iicBqbxmkZ71h4FYoRykl/cVP6W6k
         d+cGzXi5jVAr0G48NoIjowkwhl+yQZXflGRdYEMisbsnfcoVZRo3zWfP8anvvnx41riB
         QEMw/Zw2n5Iu1B07Vyb2c0M6ctwZDW5wDnX3Wnzid1HzjQu3pDxI8ZO7XVJQkrgXIb2/
         9HLA==
X-Gm-Message-State: ABy/qLbDw/wKONaDz4hBGnwuG+8fQZX9aFrA9a8TEAlLUjrxClYc1IVF
	EvrWwCMFObxRu+OjY0DvKsUh+XITMWqiTGuGIcukDA==
X-Google-Smtp-Source: APBJJlEr1rfG+2OE3UZOhMnZZoU/lNZ9E/n4GqDJJUnFyz1xxKhN3ljghK9DexZgCTuROmt7JHRqOg==
X-Received: by 2002:a17:90a:5315:b0:262:fe45:85f6 with SMTP id x21-20020a17090a531500b00262fe4585f6mr4024521pjh.0.1689772913830;
        Wed, 19 Jul 2023 06:21:53 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id gp20-20020a17090adf1400b0025023726fc4sm1184968pjb.26.2023.07.19.06.21.52
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 06:21:52 -0700 (PDT)
Message-ID: <64b7e370.170a0220.db4ea.1b34@mx.google.com>
Date: Wed, 19 Jul 2023 06:21:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v6.1.38-cip1-10-g02aa22be941dd
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline: 86 runs,
 20 regressions (v6.1.38-cip1-10-g02aa22be941dd)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Jul 2023 13:21:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12429

cip-gitlab/ci/pavel/linux-test baseline: 86 runs, 20 regressions (v6.1.38-c=
ip1-10-g02aa22be941dd)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-chromebox-cxi4-puff     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

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

imx6ul-14x14-evk             | arm    | lab-nxp         | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx7ulp-evk                  | arm    | lab-nxp         | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx7ulp-evk                  | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.38-cip1-10-g02aa22be941dd/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.38-cip1-10-g02aa22be941dd
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      02aa22be941dd7a72690f834f897a77275f9f6a5 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-chromebox-cxi4-puff     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7d01ca1213fa4808acea5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-10-g02aa22be941dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-acer-chromebox-cxi4-puff.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-10-g02aa22be941dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-acer-chromebox-cxi4-puff.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64b7d01ca1213fa4808ac=
ea6
        new failure (last pass: v5.10.184-cip36-13-g8201543bbc8b6) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7d02667275e5de58ace65

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-10-g02aa22be941dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-10-g02aa22be941dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b7d02667275e5de58ace6a
        new failure (last pass: v5.10.184-cip36-13-g8201543bbc8b6)

    2023-07-19T11:59:12.650531  <8>[   10.370196] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11111612_1.4.2.3.1>

    2023-07-19T11:59:12.654253  + set +x

    2023-07-19T11:59:12.762908  / # #

    2023-07-19T11:59:12.865459  export SHELL=3D/bin/sh

    2023-07-19T11:59:12.866279  #

    2023-07-19T11:59:12.967815  / # export SHELL=3D/bin/sh. /lava-11111612/=
environment

    2023-07-19T11:59:12.968648  =


    2023-07-19T11:59:13.070554  / # . /lava-11111612/environment/lava-11111=
612/bin/lava-test-runner /lava-11111612/1

    2023-07-19T11:59:13.071949  =


    2023-07-19T11:59:13.078070  / # /lava-11111612/bin/lava-test-runner /la=
va-11111612/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7cffdaa6392161f8ace1f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-10-g02aa22be941dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-10-g02aa22be941dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b7cffdaa6392161f8ace24
        new failure (last pass: v5.10.184-cip36-13-g8201543bbc8b6)

    2023-07-19T11:58:43.366798  + set<8>[   11.947141] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11111598_1.4.2.3.1>

    2023-07-19T11:58:43.367331   +x

    2023-07-19T11:58:43.475267  / # #

    2023-07-19T11:58:43.577762  export SHELL=3D/bin/sh

    2023-07-19T11:58:43.578533  #

    2023-07-19T11:58:43.679976  / # export SHELL=3D/bin/sh. /lava-11111598/=
environment

    2023-07-19T11:58:43.680758  =


    2023-07-19T11:58:43.782574  / # . /lava-11111598/environment/lava-11111=
598/bin/lava-test-runner /lava-11111598/1

    2023-07-19T11:58:43.783689  =


    2023-07-19T11:58:43.789028  / # /lava-11111598/bin/lava-test-runner /la=
va-11111598/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7d012a1213fa4808ace76

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-10-g02aa22be941dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-10-g02aa22be941dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b7d012a1213fa4808ace7b
        new failure (last pass: v5.10.184-cip36-13-g8201543bbc8b6)

    2023-07-19T11:59:08.731162  <8>[   10.495565] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11111608_1.4.2.3.1>

    2023-07-19T11:59:08.734701  + set +x

    2023-07-19T11:59:08.836147  =


    2023-07-19T11:59:08.936785  / # #export SHELL=3D/bin/sh

    2023-07-19T11:59:08.937017  =


    2023-07-19T11:59:09.037572  / # export SHELL=3D/bin/sh. /lava-11111608/=
environment

    2023-07-19T11:59:09.037802  =


    2023-07-19T11:59:09.138404  / # . /lava-11111608/environment/lava-11111=
608/bin/lava-test-runner /lava-11111608/1

    2023-07-19T11:59:09.138731  =


    2023-07-19T11:59:09.143426  / # /lava-11111608/bin/lava-test-runner /la=
va-11111608/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | bcm283=
5_defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7d5cefa4899ff1d8ace28

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-10-g02aa22be941dd/arm/bcm2835_defconfig/gcc-10/lab-collabora/=
baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-10-g02aa22be941dd/arm/bcm2835_defconfig/gcc-10/lab-collabora/=
baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b7d5cefa4899ff1d8ace2d
        new failure (last pass: v5.10.184-cip36-13-g8201543bbc8b6)

    2023-07-19T12:25:01.325430  / # #

    2023-07-19T12:25:01.425970  export SHELL=3D/bin/sh

    2023-07-19T12:25:01.426215  #

    2023-07-19T12:25:01.526702  / # export SHELL=3D/bin/sh. /lava-11111659/=
environment

    2023-07-19T12:25:01.526948  =


    2023-07-19T12:25:01.627512  / # . /lava-11111659/environment/lava-11111=
659/bin/lava-test-runner /lava-11111659/1

    2023-07-19T12:25:01.627769  =


    2023-07-19T12:25:01.638892  / # /lava-11111659/bin/lava-test-runner /la=
va-11111659/1

    2023-07-19T12:25:01.755945  + export 'TESTRUN_ID=3D1_bootrr'

    2023-07-19T12:25:01.756112  + cd /lava-11111659/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7da1b577dd68ef98ace6a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-10-g02aa22be941dd/arm/multi_v7_defconfig/gcc-10/lab-collabora=
/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-10-g02aa22be941dd/arm/multi_v7_defconfig/gcc-10/lab-collabora=
/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64b7da1b577dd68ef98ac=
e6b
        failing since 35 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7d9e80ab27872d68aceca

  Results:     52 PASS, 3 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-10-g02aa22be941dd/arm/omap2plus_defconfig/gcc-10/lab-broonie/=
baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-10-g02aa22be941dd/arm/omap2plus_defconfig/gcc-10/lab-broonie/=
baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b7d9e90ab27872d68acf00
        failing since 34 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-07-19T12:41:00.768484  <8>[   22.776554] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1178_1.5.2.4.1>
    2023-07-19T12:41:00.877558  / # #
    2023-07-19T12:41:00.980330  export SHELL=3D/bin/sh
    2023-07-19T12:41:00.980920  #
    2023-07-19T12:41:01.083004  / # export SHELL=3D/bin/sh. /lava-1178/envi=
ronment
    2023-07-19T12:41:01.083710  =

    2023-07-19T12:41:01.185631  / # . /lava-1178/environment/lava-1178/bin/=
lava-test-runner /lava-1178/1
    2023-07-19T12:41:01.186502  =

    2023-07-19T12:41:01.191271  / # /lava-1178/bin/lava-test-runner /lava-1=
178/1
    2023-07-19T12:41:01.303970  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7d9c90ab27872d68ace32

  Results:     52 PASS, 3 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-10-g02aa22be941dd/arm/omap2plus_defconfig/gcc-10/lab-cip/base=
line-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-10-g02aa22be941dd/arm/omap2plus_defconfig/gcc-10/lab-cip/base=
line-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b7d9c90ab27872d68ace35
        failing since 34 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-07-19T12:40:32.640301  + set +x
    2023-07-19T12:40:32.642310  <8>[   15.958173] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 987422_1.5.2.4.1>
    2023-07-19T12:40:32.751857  / # #
    2023-07-19T12:40:32.853705  export SHELL=3D/bin/sh
    2023-07-19T12:40:32.854154  #
    2023-07-19T12:40:32.955584  / # export SHELL=3D/bin/sh. /lava-987422/en=
vironment
    2023-07-19T12:40:32.956065  =

    2023-07-19T12:40:33.057479  / # . /lava-987422/environment/lava-987422/=
bin/lava-test-runner /lava-987422/1
    2023-07-19T12:40:33.058207  =

    2023-07-19T12:40:33.060322  / # /lava-987422/bin/lava-test-runner /lava=
-987422/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7cff9d171af63e58ace82

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-10-g02aa22be941dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-10-g02aa22be941dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b7cff9d171af63e58ace87
        failing since 34 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-07-19T11:58:43.209349  + set +x

    2023-07-19T11:58:43.215872  <8>[   10.460229] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11111626_1.4.2.3.1>

    2023-07-19T11:58:43.320037  / # #

    2023-07-19T11:58:43.420639  export SHELL=3D/bin/sh

    2023-07-19T11:58:43.420854  #

    2023-07-19T11:58:43.521350  / # export SHELL=3D/bin/sh. /lava-11111626/=
environment

    2023-07-19T11:58:43.521600  =


    2023-07-19T11:58:43.622184  / # . /lava-11111626/environment/lava-11111=
626/bin/lava-test-runner /lava-11111626/1

    2023-07-19T11:58:43.622479  =


    2023-07-19T11:58:43.627102  / # /lava-11111626/bin/lava-test-runner /la=
va-11111626/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7cff8d171af63e58ace77

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-10-g02aa22be941dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-10-g02aa22be941dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b7cff8d171af63e58ace7c
        failing since 34 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-07-19T11:58:30.449468  <8>[   10.775374] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11111620_1.4.2.3.1>

    2023-07-19T11:58:30.452387  + set +x

    2023-07-19T11:58:30.553580  #

    2023-07-19T11:58:30.553872  =


    2023-07-19T11:58:30.654440  / # #export SHELL=3D/bin/sh

    2023-07-19T11:58:30.654602  =


    2023-07-19T11:58:30.755123  / # export SHELL=3D/bin/sh. /lava-11111620/=
environment

    2023-07-19T11:58:30.755294  =


    2023-07-19T11:58:30.855828  / # . /lava-11111620/environment/lava-11111=
620/bin/lava-test-runner /lava-11111620/1

    2023-07-19T11:58:30.856065  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7d012a1213fa4808ace81

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-10-g02aa22be941dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-10-g02aa22be941dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b7d012a1213fa4808ace86
        new failure (last pass: v5.10.184-cip36-13-g8201543bbc8b6)

    2023-07-19T11:58:56.101716  + set<8>[    8.719459] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11111623_1.4.2.3.1>

    2023-07-19T11:58:56.102282   +x

    2023-07-19T11:58:56.209941  / # #

    2023-07-19T11:58:56.312473  export SHELL=3D/bin/sh

    2023-07-19T11:58:56.313255  #

    2023-07-19T11:58:56.414901  / # export SHELL=3D/bin/sh. /lava-11111623/=
environment

    2023-07-19T11:58:56.415692  =


    2023-07-19T11:58:56.517336  / # . /lava-11111623/environment/lava-11111=
623/bin/lava-test-runner /lava-11111623/1

    2023-07-19T11:58:56.518586  =


    2023-07-19T11:58:56.523851  / # /lava-11111623/bin/lava-test-runner /la=
va-11111623/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7d9c3cc67d8ad7e8ace44

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-10-g02aa22be941dd/arm/multi_v7_defconfig/gcc-10/lab-pengutron=
ix/baseline-imx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-10-g02aa22be941dd/arm/multi_v7_defconfig/gcc-10/lab-pengutron=
ix/baseline-imx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b7d9c3cc67d8ad7e8ace49
        failing since 27 days (last pass: v5.10.182-cip35-8-g2391124f19a70,=
 first fail: v6.1.31-61-g32a95f5a4e3b)

    2023-07-19T12:40:13.233236  + set +x
    2023-07-19T12:40:13.233412  [   12.870110] <LAVA_SIGNAL_ENDRUN 0_dmesg =
995698_1.5.2.3.1>
    2023-07-19T12:40:13.341147  / # #
    2023-07-19T12:40:13.442846  export SHELL=3D/bin/sh
    2023-07-19T12:40:13.443375  #
    2023-07-19T12:40:13.545423  / # export SHELL=3D/bin/sh. /lava-995698/en=
vironment
    2023-07-19T12:40:13.545998  =

    2023-07-19T12:40:13.647431  / # . /lava-995698/environment/lava-995698/=
bin/lava-test-runner /lava-995698/1
    2023-07-19T12:40:13.648106  =

    2023-07-19T12:40:13.651290  / # /lava-995698/bin/lava-test-runner /lava=
-995698/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7d1278ca36c33388ace25

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-10-g02aa22be941dd/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/=
baseline-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-10-g02aa22be941dd/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/=
baseline-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64b7d1278ca36c33388ac=
e26
        failing since 34 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7d128c2090aea8f8ace1f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-10-g02aa22be941dd/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/=
baseline-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-10-g02aa22be941dd/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/=
baseline-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64b7d128c2090aea8f8ac=
e20
        failing since 34 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6ul-14x14-evk             | arm    | lab-nxp         | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7d151317b7ecf898ace6b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-10-g02aa22be941dd/arm/imx_v6_v7_defconfig/gcc-10/lab-nxp/base=
line-imx6ul-14x14-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-10-g02aa22be941dd/arm/imx_v6_v7_defconfig/gcc-10/lab-nxp/base=
line-imx6ul-14x14-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64b7d151317b7ecf898ac=
e6c
        new failure (last pass: v5.10.177-cip31-33-gd59f246891e73) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7ulp-evk                  | arm    | lab-nxp         | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7d1558c692c3e4c8ace2f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-10-g02aa22be941dd/arm/imx_v6_v7_defconfig/gcc-10/lab-nxp/base=
line-imx7ulp-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-10-g02aa22be941dd/arm/imx_v6_v7_defconfig/gcc-10/lab-nxp/base=
line-imx7ulp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64b7d1558c692c3e4c8ac=
e30
        failing since 43 days (last pass: v5.10.180-cip34-26-gc198172c84b6a=
, first fail: v6.1.26-1321-g3152fb7c8d2d6) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7ulp-evk                  | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7da24577dd68ef98ace70

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-10-g02aa22be941dd/arm/multi_v7_defconfig/gcc-10/lab-nxp/basel=
ine-imx7ulp-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-10-g02aa22be941dd/arm/multi_v7_defconfig/gcc-10/lab-nxp/basel=
ine-imx7ulp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b7da24577dd68ef98ace73
        failing since 118 days (last pass: v5.10.145-rt74-1329-ga59fc50f38f=
6, first fail: v5.10.175-cip29-rt12)

    2023-07-19T12:41:52.523237  + set +x<8>[   33.541809] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 1237585_1.5.2.4.1>
    2023-07-19T12:41:52.523529  =

    2023-07-19T12:41:52.632317  / # #
    2023-07-19T12:41:53.788408  export SHELL=3D/bin/sh
    2023-07-19T12:41:53.794100  #
    2023-07-19T12:41:53.794425  / # export SHELL=3D/bin/sh
    2023-07-19T12:41:55.336761  / # . /lava-1237585/environment
    2023-07-19T12:41:58.153912  /lava-1237585/bin/lava-test-runner /lava-12=
37585/1
    2023-07-19T12:41:58.159832  . /lava-1237585/environment
    2023-07-19T12:41:58.160077  / # /lava-1237585/bin/lava-test-runner /lav=
a-1237585/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7cff089932a92eb8ace29

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-10-g02aa22be941dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-10-g02aa22be941dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b7cff089932a92eb8ace2e
        new failure (last pass: v5.10.184-cip36-13-g8201543bbc8b6)

    2023-07-19T11:58:35.474193  <8>[   11.361304] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11111610_1.4.2.3.1>

    2023-07-19T11:58:35.578667  / # #

    2023-07-19T11:58:35.679315  export SHELL=3D/bin/sh

    2023-07-19T11:58:35.679530  #

    2023-07-19T11:58:35.780088  / # export SHELL=3D/bin/sh. /lava-11111610/=
environment

    2023-07-19T11:58:35.780311  =


    2023-07-19T11:58:35.880834  / # . /lava-11111610/environment/lava-11111=
610/bin/lava-test-runner /lava-11111610/1

    2023-07-19T11:58:35.881136  =


    2023-07-19T11:58:35.886367  / # /lava-11111610/bin/lava-test-runner /la=
va-11111610/1

    2023-07-19T11:58:35.892959  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 2          =


  Details:     https://kernelci.org/test/plan/id/64b7d9cc0ab27872d68ace7f

  Results:     66 PASS, 4 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-10-g02aa22be941dd/arm/multi_v7_defconfig/gcc-10/lab-collabora=
/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-10-g02aa22be941dd/arm/multi_v7_defconfig/gcc-10/lab-collabora=
/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/64b7d9cc0ab27872d68aceaf
        failing since 180 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-07-19T12:42:15.047519  Usage: seq [-w] [-s SEP] [FIRST [INC]] LA<8=
>[   19.874002] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-07-19T12:42:15.047905  ST

    2023-07-19T12:42:15.047965  =


    2023-07-19T12:42:15.053092  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-07-19T12:42:15.055603  FIRST, INC default to 1.

    2023-07-19T12:42:15.055818  =


    2023-07-19T12:42:15.059318  	-w	Pad to last with leading zeros
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/64b7d9cc0ab27872d68aceb0
        failing since 180 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-07-19T12:42:15.018477  <8>[   19.851558] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>

    2023-07-19T12:42:15.033112  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.

    2023-07-19T12:42:15.033355  =

   =

 =20

