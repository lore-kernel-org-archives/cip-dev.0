Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F44CC6FA8F
	for <webhook@archiver.kernel.org>; Wed, 30 Aug 2023 08:31:51 +0000 (UTC)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
 by mx.groups.io with SMTP id smtpd.web10.9541.1693384311001954664
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 30 Aug 2023 01:31:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=QpE/RJfX;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.128.174, mailfrom: bot@kernelci.org)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-58cbdf3eecaso59501827b3.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 30 Aug 2023 01:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1693384310; x=1693989110; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lGkXpvsIPLs1NburnumGl+AYBWz4VXRJedRw+jVMvXE=;
        b=QpE/RJfX9obPBDVBvF0ruVtMbTpqzPqanmaN4iKqIRc3+1Irn7QVJcRSqwnN2rjpdo
         m0StpEZrW0tmeCFsWzxmIg8rAExZBG6O+Fer3yaOz5S+owpvdtvcZzeNM5m59h+uIbHF
         ansKXlBnKNXZr2MCdGY+UZWyUpTD2sFKS1Dvqu5oJUyRDL3BT9NDK0tWvkZSJw5HgaK4
         6haw6UBshhUdccb0arNXTFAhb6V26Fxjk20xPNK8T6pflhRFOqr8caVhgKB3/aBrL0Yt
         +ex3PqnU+kS8fjDz9YIkvkWS0njxo7PCS5d/qTYlU/XmupD2AqFC/FlkhnQ9eipW7q3h
         dekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693384310; x=1693989110;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lGkXpvsIPLs1NburnumGl+AYBWz4VXRJedRw+jVMvXE=;
        b=HT4SRBbPXrP3Y0V3Se3eBcuKg2dmdBCCnSs2xejhX/hxgvPrbaWt8guVsg3l6F15hU
         kPze2hfkkemSS2LkPFSQhee/8x+1VQCXGKRO9WSCnqQsBdMilKqVOOViqUnVxGK3dNXc
         vcjo+c1sFOzonNRB0sRjicjbBs8edROmGc2v1zvYC4bdumcHQyFlIiEqCDkYr+e1Jlat
         7RDnJjSxPxVc9f9BbI0el/8VuD+UfDqOY+GVVmSRCTUWbWJbSY7sJ0YtYOxzawen9MHQ
         YpY00k/p6GQF82oK7oVSCeqxrWaD4Q8S45GUQlWGQplgWEYGap+CFt5TZBH1PDoZ8T4z
         THWw==
X-Gm-Message-State: AOJu0Yx9omjviqts2uFJEl6SWxx9OTK/qnRcwIalzpm5nLuQkHuZthj8
	aChvfJmtU8T6wxzLR6TDXc+C/DhBnntyA4EoN2U=
X-Google-Smtp-Source: AGHT+IGjTsemK/R/L6S+7AxLui/0FoqEiKl1aSfTWS/7jfA/scPXKexN42fH5cGW+LfD63H+3vhbzA==
X-Received: by 2002:a0d:cdc4:0:b0:592:8cd:6e10 with SMTP id p187-20020a0dcdc4000000b0059208cd6e10mr1300076ywd.49.1693384309574;
        Wed, 30 Aug 2023 01:31:49 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id bu25-20020a632959000000b0056365ee8603sm10040222pgb.67.2023.08.30.01.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 01:31:48 -0700 (PDT)
Message-ID: <64eefe74.630a0220.107c.f13b@mx.google.com>
Date: Wed, 30 Aug 2023 01:31:48 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.191-cip38-2-g09e5ecd8645b
Subject: cip/linux-5.10.y-cip baseline-nfs: 22 runs,
 9 regressions (v5.10.191-cip38-2-g09e5ecd8645b)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Aug 2023 08:31:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12910

cip/linux-5.10.y-cip baseline-nfs: 22 runs, 9 regressions (v5.10.191-cip38-=
2-g09e5ecd8645b)

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
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+kselftest          | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.191-cip38-2-g09e5ecd8645b/plan/baseline-nfs/

  Test:     baseline-nfs
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
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64eee958fe24afe528286d71

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-2-g09e5ecd8645b/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-=
nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-2-g09e5ecd8645b/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-=
nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64eee958fe24afe528286dab
        failing since 228 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-30T07:01:16.683496  <8>[   42.334140] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 78679_1.6.2.4.1>
    2023-08-30T07:01:16.806714  / # #
    2023-08-30T07:01:16.910067  export SHELL=3D/bin/sh
    2023-08-30T07:01:16.911011  #
    2023-08-30T07:01:17.012937  / # export SHELL=3D/bin/sh. /lava-78679/env=
ironment
    2023-08-30T07:01:17.013558  =

    2023-08-30T07:01:17.115349  / # . /lava-78679/environment/lava-78679/bi=
n/lava-test-runner /lava-78679/1
    2023-08-30T07:01:17.116878  =

    2023-08-30T07:01:17.121235  / # /lava-78679/bin/lava-test-runner /lava-=
78679/1
    2023-08-30T07:01:17.430332  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64eee956741aa97c01286dae

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-2-g09e5ecd8645b/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs-=
beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-2-g09e5ecd8645b/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs-=
beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64eee956741aa97c01286db1
        failing since 228 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-30T07:01:19.919876  / # #
    2023-08-30T07:01:20.023557  export SHELL=3D/bin/sh
    2023-08-30T07:01:20.024644  #
    2023-08-30T07:01:20.127146  / # export SHELL=3D/bin/sh. /lava-1002724/e=
nvironment
    2023-08-30T07:01:20.128247  =

    2023-08-30T07:01:20.230610  / # . /lava-1002724/environment/lava-100272=
4/bin/lava-test-runner /lava-1002724/1
    2023-08-30T07:01:20.232398  =

    2023-08-30T07:01:20.240346  / # /lava-1002724/bin/lava-test-runner /lav=
a-1002724/1
    2023-08-30T07:01:20.556859  + export TESTRUN_ID=3D1_bootrr
    2023-08-30T07:01:20.557523  + cd /lava-1002724/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64eef2bfed8e561fd2286d7f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-2-g09e5ecd8645b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-2-g09e5ecd8645b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64eef2bfed8e561fd2286d88
        failing since 137 days (last pass: v5.10.176-cip30, first fail: v5.=
10.177-cip31)

    2023-08-30T07:41:52.559452  + <8>[   22.898518] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11381218_1.5.2.3.1>

    2023-08-30T07:41:52.559648  set +x

    2023-08-30T07:41:52.665021  / # #

    2023-08-30T07:41:52.767452  export SHELL=3D/bin/sh

    2023-08-30T07:41:52.768238  #

    2023-08-30T07:41:52.869808  / # export SHELL=3D/bin/sh. /lava-11381218/=
environment

    2023-08-30T07:41:52.870786  =


    2023-08-30T07:41:52.972636  / # . /lava-11381218/environment/lava-11381=
218/bin/lava-test-runner /lava-11381218/1

    2023-08-30T07:41:52.973753  =


    2023-08-30T07:41:52.978201  / # /lava-11381218/bin/lava-test-runner /la=
va-11381218/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64eef08ca408892c2d286dae

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-2-g09e5ecd8645b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-2-g09e5ecd8645b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64eef08ca408892c2d286db7
        failing since 137 days (last pass: v5.10.176-cip30, first fail: v5.=
10.177-cip31)

    2023-08-30T07:32:10.017224  + set +x

    2023-08-30T07:32:10.024188  <8>[   18.750325] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11381211_1.5.2.3.1>

    2023-08-30T07:32:10.128164  / # #

    2023-08-30T07:32:10.228831  export SHELL=3D/bin/sh

    2023-08-30T07:32:10.229054  #

    2023-08-30T07:32:10.329671  / # export SHELL=3D/bin/sh. /lava-11381211/=
environment

    2023-08-30T07:32:10.329862  =


    2023-08-30T07:32:10.430407  / # . /lava-11381211/environment/lava-11381=
211/bin/lava-test-runner /lava-11381211/1

    2023-08-30T07:32:10.430686  =


    2023-08-30T07:32:10.435541  / # /lava-11381211/bin/lava-test-runner /la=
va-11381211/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64eeecf89fdbc2713d286d6c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-2-g09e5ecd8645b/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/base=
line-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-2-g09e5ecd8645b/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/base=
line-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64eeecf89fdbc2713=
d286d6d
        failing since 7 days (last pass: v5.10.186-cip37-14-gc9b5a049d8ea, =
first fail: v5.10.186-cip37-27-gd6d928db0a620) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64eeef785dcda4b8c7286d71

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-2-g09e5ecd8645b/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-nf=
s-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-2-g09e5ecd8645b/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-nf=
s-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64eeef785dcda4b8c=
7286d72
        failing since 13 days (last pass: v5.10.186-cip37-13-g260094841fe1a=
, first fail: v5.10.186-cip37-14-gc9b5a049d8ea) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64eef248549f4d6c71286d6c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-2-g09e5ecd8645b/arm64/defconfig/gcc-10/lab-cip/baseline-nfs-r8a774a1=
-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-2-g09e5ecd8645b/arm64/defconfig/gcc-10/lab-cip/baseline-nfs-r8a774a1=
-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64eef248549f4d6c7=
1286d6d
        failing since 35 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64eeee3b9e2f69b415286d70

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-2-g09e5ecd8645b/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabor=
a/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-2-g09e5ecd8645b/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabor=
a/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/64eeee3b9e2f69b415286d7a
        failing since 160 days (last pass: v5.10.173-cip28, first fail: v5.=
10.175-cip29)

    2023-08-30T07:23:20.984668  /lava-11380953/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/64eeee3b9e2f69b415286d7b
        failing since 160 days (last pass: v5.10.173-cip28, first fail: v5.=
10.175-cip29)

    2023-08-30T07:23:18.842400  <8>[   45.216590] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-08-30T07:23:19.901222  /lava-11380953/1/../bin/lava-test-case

    2023-08-30T07:23:19.933330  <8>[   46.308797] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =20

