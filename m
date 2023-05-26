Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEB7C7EE2D
	for <webhook@archiver.kernel.org>; Fri, 26 May 2023 07:58:02 +0000 (UTC)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
 by mx.groups.io with SMTP id smtpd.web10.3363.1685087880862854835
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 26 May 2023 00:58:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=BtW0kgOT;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.180, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-64d5b4c400fso792562b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 26 May 2023 00:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685087880; x=1687679880;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VisHmLDQgqc3vFOSAtNq6oepKBqGAWAFReYSm7KwxAc=;
        b=BtW0kgOTmTIdYIGtZnKk97rz311zy1YtaA7aOsQ5b2JSFyUNpW4oJxe6VenPqjvR2W
         FjsIDENW4sZOpJyLBbXFa91kWJbz+IzztY878cBL2Zs2MA0STawlp/VIZc6YEDk+IUnU
         x91dDo/7k9v0IgSAFuON050llbargVFO3pLyGk59Qlg31UYqiwHHDB6jbEfs6fI8fVMc
         jzWMZ+vyjPRS1kRRzIVHg9JQyzdbBTVnyrtfnJgwhPAPHz5URUc8FXoXlJhpf1SbYR2z
         A1GbmtZRm2e5MJ00z+iCwB56PGbeyMjfYBeSjMmXJiCyVakessh7hz8jkUTlK7Wt+FFX
         FyVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685087880; x=1687679880;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VisHmLDQgqc3vFOSAtNq6oepKBqGAWAFReYSm7KwxAc=;
        b=InqIX/8BnQ39pGXey5wq9msUaJgZ0vrDrqZvnUu06oCZx9RZrGg33DJkPGRBApoN+z
         mk8OTlgaTp/jPIPcPVpErk3MKzYIEaA+8z0o8FiUtzryu2iokcmXu6hOYLVpMY7bbwB1
         GnolYHc7cjv23Gsh4F+v779ajZr10PLIP5bvZ1TE/eWiw6CbGzXO/IDASaKarqAD/GbU
         iPM9xGp0Wmso90HjEoiVci7Vg3Hr3ZcHnj/SRxTF1IeJUXQ0JhOJKL9p9HXQk7o3LqCe
         OYK4SCn2NZpktypxSo9FBezGjJk+PHxOH7GAlMMxUe+JtjYU5wUXYi4L3u8X3lb9JhAt
         bH6w==
X-Gm-Message-State: AC+VfDy9EjfpMBEndtk7nfGkqUhr3+U4mjSuh32iLbLrhIm78tmfGFZI
	5tnP+97lNKknxJO91Wzhq8yE+4b+/WRUZBtKBFBT7A==
X-Google-Smtp-Source: ACHHUZ5EClssVOf97p5Q/gRYFnYhYzVAyus4ZD0NBIL4EP9NOk4okVzntZro9j49h1QcDDCN3D1iGw==
X-Received: by 2002:a05:6a20:8f17:b0:10b:c341:935 with SMTP id b23-20020a056a208f1700b0010bc3410935mr1539680pzk.11.1685087879507;
        Fri, 26 May 2023 00:57:59 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s11-20020a63e80b000000b0051b460fd90fsm2262671pgh.8.2023.05.26.00.57.58
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 00:57:59 -0700 (PDT)
Message-ID: <64706687.630a0220.a23e6.448a@mx.google.com>
Date: Fri, 26 May 2023 00:57:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.180-cip33-21-g090289427e8b2
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 161 runs,
 11 regressions (v5.10.180-cip33-21-g090289427e8b2)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 26 May 2023 07:58:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11650

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 161 runs, 11 regressio=
ns (v5.10.180-cip33-21-g090289427e8b2)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.180-cip33-21-g090289427e8b2/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.180-cip33-21-g090289427e8b2
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      090289427e8b2be9dac126c4d1b760b100f2c6b8 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64705d2c0a6cc92e472e867e

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip33-21-g090289427e8b2/arm/omap2plus_defconfig/gcc-=
10/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip33-21-g090289427e8b2/arm/omap2plus_defconfig/gcc-=
10/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64705d2d0a6cc92e472e86b4
        failing since 141 days (last pass: v5.10.155-cip21-405-g26d566555c3=
de, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2023-05-26T07:17:45.410316  <8>[   19.246930] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 515457_1.5.2.4.1>
    2023-05-26T07:17:45.518954  / # #
    2023-05-26T07:17:45.621856  export SHELL=3D/bin/sh
    2023-05-26T07:17:45.622572  #
    2023-05-26T07:17:45.724841  / # export SHELL=3D/bin/sh. /lava-515457/en=
vironment
    2023-05-26T07:17:45.725560  =

    2023-05-26T07:17:45.828045  / # . /lava-515457/environment/lava-515457/=
bin/lava-test-runner /lava-515457/1
    2023-05-26T07:17:45.829184  =

    2023-05-26T07:17:45.834040  / # /lava-515457/bin/lava-test-runner /lava=
-515457/1
    2023-05-26T07:17:45.943374  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64705ee58269649bc22e85f7

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip33-21-g090289427e8b2/arm/omap2plus_defconfig/gcc-=
10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip33-21-g090289427e8b2/arm/omap2plus_defconfig/gcc-=
10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64705ee58269649bc22e85fa
        failing since 141 days (last pass: v5.10.155-cip21-405-g26d566555c3=
de, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2023-05-26T07:25:11.381922  + set +x
    2023-05-26T07:25:11.383950  <8>[   14.032395] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 943670_1.5.2.4.1>
    2023-05-26T07:25:11.492697  / # #
    2023-05-26T07:25:11.594601  export SHELL=3D/bin/sh
    2023-05-26T07:25:11.595079  #
    2023-05-26T07:25:11.696471  / # export SHELL=3D/bin/sh. /lava-943670/en=
vironment
    2023-05-26T07:25:11.696954  =

    2023-05-26T07:25:11.798424  / # . /lava-943670/environment/lava-943670/=
bin/lava-test-runner /lava-943670/1
    2023-05-26T07:25:11.799381  =

    2023-05-26T07:25:11.801567  / # /lava-943670/bin/lava-test-runner /lava=
-943670/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/647058317d6db952292e863b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip33-21-g090289427e8b2/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n40=
20-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip33-21-g090289427e8b2/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n40=
20-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647058317d6db952292e8640
        failing since 35 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-05-26T06:56:38.597932  + set +x<8>[   12.425298] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10462508_1.4.2.3.1>

    2023-05-26T06:56:38.598511  =


    2023-05-26T06:56:38.706163  / # #

    2023-05-26T06:56:38.808604  export SHELL=3D/bin/sh

    2023-05-26T06:56:38.809429  #

    2023-05-26T06:56:38.910972  / # export SHELL=3D/bin/sh. /lava-10462508/=
environment

    2023-05-26T06:56:38.911803  =


    2023-05-26T06:56:39.013288  / # . /lava-10462508/environment/lava-10462=
508/bin/lava-test-runner /lava-10462508/1

    2023-05-26T06:56:39.014569  =


    2023-05-26T06:56:39.019410  / # /lava-10462508/bin/lava-test-runner /la=
va-10462508/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647059dab0b1283deb2e8600

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip33-21-g090289427e8b2/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus=
.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip33-21-g090289427e8b2/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647059dab0b1283deb2e8605
        failing since 35 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-05-26T07:03:37.108703  + set +x

    2023-05-26T07:03:37.115045  <8>[   10.784241] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10462683_1.4.2.3.1>

    2023-05-26T07:03:37.218998  / # #

    2023-05-26T07:03:37.319589  export SHELL=3D/bin/sh

    2023-05-26T07:03:37.319770  #

    2023-05-26T07:03:37.420287  / # export SHELL=3D/bin/sh. /lava-10462683/=
environment

    2023-05-26T07:03:37.420496  =


    2023-05-26T07:03:37.521060  / # . /lava-10462683/environment/lava-10462=
683/bin/lava-test-runner /lava-10462683/1

    2023-05-26T07:03:37.521307  =


    2023-05-26T07:03:37.525971  / # /lava-10462683/bin/lava-test-runner /la=
va-10462683/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/647057f27e390fdc2f2e85f7

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip33-21-g090289427e8b2/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip33-21-g090289427e8b2/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647057f27e390fdc2f2e85fc
        failing since 35 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-05-26T06:55:31.416412  <8>[   12.216273] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10462521_1.4.2.3.1>

    2023-05-26T06:55:31.419771  + set +x

    2023-05-26T06:55:31.527895  / # #

    2023-05-26T06:55:31.628734  export SHELL=3D/bin/sh

    2023-05-26T06:55:31.629456  #

    2023-05-26T06:55:31.730848  / # export SHELL=3D/bin/sh. /lava-10462521/=
environment

    2023-05-26T06:55:31.731566  =


    2023-05-26T06:55:31.832933  / # . /lava-10462521/environment/lava-10462=
521/bin/lava-test-runner /lava-10462521/1

    2023-05-26T06:55:31.833249  =


    2023-05-26T06:55:31.838426  / # /lava-10462521/bin/lava-test-runner /la=
va-10462521/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647059d0a8e0fad06c2e85f3

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip33-21-g090289427e8b2/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip33-21-g090289427e8b2/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647059d0a8e0fad06c2e85f8
        failing since 35 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-05-26T07:03:30.500419  <8>[   13.870227] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10462628_1.4.2.3.1>

    2023-05-26T07:03:30.503436  + set +x

    2023-05-26T07:03:30.604774  =


    2023-05-26T07:03:30.705417  / # #export SHELL=3D/bin/sh

    2023-05-26T07:03:30.705612  =


    2023-05-26T07:03:30.806076  / # export SHELL=3D/bin/sh. /lava-10462628/=
environment

    2023-05-26T07:03:30.806304  =


    2023-05-26T07:03:30.906862  / # . /lava-10462628/environment/lava-10462=
628/bin/lava-test-runner /lava-10462628/1

    2023-05-26T07:03:30.907224  =


    2023-05-26T07:03:30.912040  / # /lava-10462628/bin/lava-test-runner /la=
va-10462628/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647059f60467dfd5cf2e85e8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip33-21-g090289427e8b2/arm/shmobile_defconfig/gcc-1=
0/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip33-21-g090289427e8b2/arm/shmobile_defconfig/gcc-1=
0/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647059f60467dfd5cf2e8=
5e9
        new failure (last pass: v5.10.179-cip32-384-g291adc46abef0) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/647059e8b0b1283deb2e8736

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip33-21-g090289427e8b2/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip33-21-g090289427e8b2/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/647059e8b0b1283deb2e873c
        failing since 35 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-05-26T07:03:44.711331  <8>[   33.644129] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-05-26T07:03:45.735136  /lava-10462598/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/647059e8b0b1283deb2e873d
        failing since 35 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-05-26T07:03:44.699548  /lava-10462598/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 2          =


  Details:     https://kernelci.org/test/plan/id/647062bdb1cdb7dc0d2e85f9

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip33-21-g090289427e8b2/arm64/defconfig+arm64-chrome=
book+kselftest/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip33-21-g090289427e8b2/arm64/defconfig+arm64-chrome=
book+kselftest/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/647062bdb1cdb7dc0d2e85ff
        failing since 35 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-05-26T07:41:30.351972  /lava-10462923/1/../bin/lava-test-case

    2023-05-26T07:41:30.376696  <8>[   70.696910] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/647062bdb1cdb7dc0d2e8600
        failing since 35 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-05-26T07:41:29.263929  /lava-10462923/1/../bin/lava-test-case

    2023-05-26T07:41:29.288910  <8>[   69.609739] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =20

