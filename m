Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C37EB64D8
	for <webhook@archiver.kernel.org>; Wed, 14 Jun 2023 12:52:45 +0000 (UTC)
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
 by mx.groups.io with SMTP id smtpd.web10.10846.1686747161660741490
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 14 Jun 2023 05:52:41 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=rWUajoAe;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.160.46, mailfrom: bot@kernelci.org)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1a693718ffbso2967334fac.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 14 Jun 2023 05:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686747160; x=1689339160;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wxGyn5bTUCyWv0Uv7EWpBipuRAbMd6FgkAeTCI+2M38=;
        b=rWUajoAeJR7fDNI5Zp5Ep58r56TNh5XVZqyIhaUGBcfWEnGMgGkz+fcUUEGFN1ZRTt
         l9VpxcnbzYT5LCS4JyXPlVt/DSDyedYfvnRPW7SkisX9+dbzUV0YiYGkKbgarVFyAcHN
         7p1f3YDcx+Esc2A8aRxpbXFgzwl2yb2m0ClvLiLEKRqKvOqW/jgkiVwSdE+GhAFTHvNG
         YnBZc3BTa4wHlm4THbae+9yL6aoYZZolJbVfeHfCUs+ll+gyYsNTTHz0XVBRXPCNWrhT
         CfQw1XsGhF8UocIHCMkCpFnYSs0tk2srR/JLJSD3KzWMpZ3pWfVNCMHTfC/l1EdDp3LY
         Nd5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686747160; x=1689339160;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wxGyn5bTUCyWv0Uv7EWpBipuRAbMd6FgkAeTCI+2M38=;
        b=Itx4MAossQuH9orT+ShEbVOeGlzbpvBQf1vz1e/P0NY9//ARU2hEkW4nGr0t2psXAu
         YiklUKR3vcdi/U1yrPM/cVIfNJa7X10urNfaFDsLACdPhRmDmPi9sGK3kjOyrq5+vh/S
         0qbiSj1xvOJVnLVaOqGBuIjXQC8zHPqWdtlpnwHc/uR4Tbs4YO/9s9qqwXq1fL7fEtxa
         H8yWGi2hYXEGd/MpecPbKBVXqZkxbgAT5VUtgNkIN1mk00xnrTUFOWQ1PdgoO/aastMa
         vJtuDXRbQphPYo29OO1PVQ8F+O2Ll84RzLUA2qHDkxSAhB1DRWn3DL0Zw+p0GkiBtUyJ
         dlDw==
X-Gm-Message-State: AC+VfDwmwgCAaQd27SuzIIiTKk00ON8hrJb2VxEd+U16bvshTPftXcg0
	msoQkMy5BECk4u+xH6KR9kSGrMapcEboogQmN9/6bA==
X-Google-Smtp-Source: ACHHUZ4kFeuD3wNFHX0D7Np14bwTH/5ivlNnwPHlYblgGJXs4TWuNWKSYb0YLXPgTgGnvM5XLp6D7w==
X-Received: by 2002:a05:6808:f07:b0:39a:9e6e:9a90 with SMTP id m7-20020a0568080f0700b0039a9e6e9a90mr12697396oiw.28.1686747159943;
        Wed, 14 Jun 2023 05:52:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id bx10-20020a17090af48a00b0024e05b7ba8bsm11030910pjb.25.2023.06.14.05.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 05:52:39 -0700 (PDT)
Message-ID: <6489b817.170a0220.1ba00.5c19@mx.google.com>
Date: Wed, 14 Jun 2023 05:52:39 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.182-cip35-1-g7cde3fba93966
Subject: cip/linux-5.10.y-cip baseline: 114 runs,
 17 regressions (v5.10.182-cip35-1-g7cde3fba93966)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Jun 2023 12:52:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12017

cip/linux-5.10.y-cip baseline: 114 runs, 17 regressions (v5.10.182-cip35-1-=
g7cde3fba93966)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =

hp-14-db0003na-grunt         | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 4          =

rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.182-cip35-1-g7cde3fba93966/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.182-cip35-1-g7cde3fba93966
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      7cde3fba93966b9614ca285f91928a57a79f7f3f =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6489ad2b96daa7e61030614d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-1-g7cde3fba93966/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-1-g7cde3fba93966/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6489ad2b96daa7e610306152
        failing since 151 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-14T12:05:50.185275  + set +x

    2023-06-14T12:05:50.191670  <8>[   11.838323] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10724121_1.4.2.3.1>

    2023-06-14T12:05:50.296293  / # #

    2023-06-14T12:05:50.396983  export SHELL=3D/bin/sh

    2023-06-14T12:05:50.397203  #

    2023-06-14T12:05:50.497747  / # export SHELL=3D/bin/sh. /lava-10724121/=
environment

    2023-06-14T12:05:50.497951  =


    2023-06-14T12:05:50.598525  / # . /lava-10724121/environment/lava-10724=
121/bin/lava-test-runner /lava-10724121/1

    2023-06-14T12:05:50.598825  =


    2023-06-14T12:05:50.604309  / # /lava-10724121/bin/lava-test-runner /la=
va-10724121/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6489ad15440370710930614c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-1-g7cde3fba93966/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-1-g7cde3fba93966/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6489ad154403707109306151
        failing since 151 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-14T12:05:31.254427  <8>[   11.481290] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-06-14T12:05:31.262337  + set<8>[   11.492053] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10724143_1.4.2.3.1>

    2023-06-14T12:05:31.263097   +x

    2023-06-14T12:05:31.366660  #

    2023-06-14T12:05:31.467417  / # #export SHELL=3D/bin/sh

    2023-06-14T12:05:31.467642  =


    2023-06-14T12:05:31.568149  / # export SHELL=3D/bin/sh. /lava-10724143/=
environment

    2023-06-14T12:05:31.568335  =


    2023-06-14T12:05:31.568418  / # <4>[   11.742317] i2c_designware i2c_de=
signware.5: timeout in disabling adapter

    2023-06-14T12:05:31.668967  . /lava-10724143/environment/lava-10724143/=
bin/lava-test-runner /lava-10724143/1
 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6489b15c1f4ee56b9630612e

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-1-g7cde3fba93966/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-=
beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-1-g7cde3fba93966/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-=
beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6489b15c1f4ee56b9630615a
        failing since 151 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-14T12:23:18.866545  <8>[   21.415502] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 610349_1.5.2.4.1>
    2023-06-14T12:23:18.977279  / # #
    2023-06-14T12:23:19.079571  export SHELL=3D/bin/sh
    2023-06-14T12:23:19.080375  #
    2023-06-14T12:23:19.182545  / # export SHELL=3D/bin/sh. /lava-610349/en=
vironment
    2023-06-14T12:23:19.183394  =

    2023-06-14T12:23:19.285321  / # . /lava-610349/environment/lava-610349/=
bin/lava-test-runner /lava-610349/1
    2023-06-14T12:23:19.286347  =

    2023-06-14T12:23:19.291045  / # /lava-610349/bin/lava-test-runner /lava=
-610349/1
    2023-06-14T12:23:19.384012  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6489b0bc37d20b6cc8306196

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-1-g7cde3fba93966/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline=
-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-1-g7cde3fba93966/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline=
-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6489b0bc37d20b6cc83061cc
        failing since 151 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-14T12:20:57.573540  <8>[   20.718666] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 610160_1.5.2.4.1>
    2023-06-14T12:20:57.681386  / # #
    2023-06-14T12:20:57.783054  export SHELL=3D/bin/sh
    2023-06-14T12:20:57.783532  #
    2023-06-14T12:20:57.884744  / # export SHELL=3D/bin/sh. /lava-610160/en=
vironment
    2023-06-14T12:20:57.885245  =

    2023-06-14T12:20:57.986713  / # . /lava-610160/environment/lava-610160/=
bin/lava-test-runner /lava-610160/1
    2023-06-14T12:20:57.987709  =

    2023-06-14T12:20:57.992188  / # /lava-610160/bin/lava-test-runner /lava=
-610160/1
    2023-06-14T12:20:58.087410  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6489b0b937d20b6cc8306157

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-1-g7cde3fba93966/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-bea=
glebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-1-g7cde3fba93966/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-bea=
glebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6489b0b937d20b6cc830615a
        failing since 151 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-14T12:20:57.191589  <8>[   13.108212] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 962901_1.5.2.4.1>
    2023-06-14T12:20:57.302163  / # #
    2023-06-14T12:20:57.404718  export SHELL=3D/bin/sh
    2023-06-14T12:20:57.405410  #
    2023-06-14T12:20:57.507247  / # export SHELL=3D/bin/sh. /lava-962901/en=
vironment
    2023-06-14T12:20:57.507942  =

    2023-06-14T12:20:57.609746  / # . /lava-962901/environment/lava-962901/=
bin/lava-test-runner /lava-962901/1
    2023-06-14T12:20:57.610938  =

    2023-06-14T12:20:57.617140  / # /lava-962901/bin/lava-test-runner /lava=
-962901/1
    2023-06-14T12:20:57.722476  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-14-db0003na-grunt         | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6489ad11fae8199a81306144

  Results:     17 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-1-g7cde3fba93966/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-hp-14-db0003na-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-1-g7cde3fba93966/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-hp-14-db0003na-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/6489ad11fae8199=
a81306157
        new failure (last pass: v5.10.182-cip35)
        1 lines

    2023-06-14T12:05:20.067602  kern  :emerg : __common_interrupt: 1.55 No =
irq handler for vector

    2023-06-14T12:05:20.077017  <8>[   10.435280] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D1>
   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6489ad1e4403707109306195

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-1-g7cde3fba93966/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-1-g7cde3fba93966/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6489ad1e440370710930619a
        failing since 61 days (last pass: v5.10.176-cip30, first fail: v5.1=
0.177-cip31)

    2023-06-14T12:05:54.767936  + set +x

    2023-06-14T12:05:54.774346  <8>[   11.365679] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10724107_1.4.2.3.1>

    2023-06-14T12:05:54.879049  / # #

    2023-06-14T12:05:54.979738  export SHELL=3D/bin/sh

    2023-06-14T12:05:54.979940  #

    2023-06-14T12:05:55.080442  / # export SHELL=3D/bin/sh. /lava-10724107/=
environment

    2023-06-14T12:05:55.080671  =


    2023-06-14T12:05:55.181251  / # . /lava-10724107/environment/lava-10724=
107/bin/lava-test-runner /lava-10724107/1

    2023-06-14T12:05:55.181538  =


    2023-06-14T12:05:55.186135  / # /lava-10724107/bin/lava-test-runner /la=
va-10724107/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6489ad242e6f55230a306164

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-1-g7cde3fba93966/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-1-g7cde3fba93966/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6489ad242e6f55230a306169
        failing since 61 days (last pass: v5.10.176-cip30, first fail: v5.1=
0.177-cip31)

    2023-06-14T12:05:38.403654  + set +x<8>[   13.356744] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10724160_1.4.2.3.1>

    2023-06-14T12:05:38.403771  =


    2023-06-14T12:05:38.505560  #

    2023-06-14T12:05:38.606449  / # #export SHELL=3D/bin/sh

    2023-06-14T12:05:38.606636  =


    2023-06-14T12:05:38.707136  / # export SHELL=3D/bin/sh. /lava-10724160/=
environment

    2023-06-14T12:05:38.707344  =


    2023-06-14T12:05:38.807838  / # . /lava-10724160/environment/lava-10724=
160/bin/lava-test-runner /lava-10724160/1

    2023-06-14T12:05:38.808183  =


    2023-06-14T12:05:38.812994  / # /lava-10724160/bin/lava-test-runner /la=
va-10724160/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6489aee083081573a5306143

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-1-g7cde3fba93966/arm/multi_v7_defconfig/gcc-10/lab-collabora/baselin=
e-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-1-g7cde3fba93966/arm/multi_v7_defconfig/gcc-10/lab-collabora/baselin=
e-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6489aee083081573a5306148
        failing since 151 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-14T12:13:11.469026  / # #

    2023-06-14T12:13:11.570974  export SHELL=3D/bin/sh

    2023-06-14T12:13:11.571731  #

    2023-06-14T12:13:11.673701  / # export SHELL=3D/bin/sh. /lava-10724295/=
environment

    2023-06-14T12:13:11.674489  =


    2023-06-14T12:13:11.776491  / # . /lava-10724295/environment/lava-10724=
295/bin/lava-test-runner /lava-10724295/1

    2023-06-14T12:13:11.777758  =


    2023-06-14T12:13:11.791571  / # /lava-10724295/bin/lava-test-runner /la=
va-10724295/1

    2023-06-14T12:13:11.839621  + export 'TESTRUN_ID=3D1_bootrr'

    2023-06-14T12:13:11.894785  + cd /lava-10724295/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6489acc4d05ccde83a306154

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-1-g7cde3fba93966/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/base=
line-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-1-g7cde3fba93966/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/base=
line-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6489acc4d05ccde83a306157
        failing since 151 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-14T12:03:56.308822  + set +x
    2023-06-14T12:03:56.309029  [   10.170287] <LAVA_SIGNAL_ENDRUN 0_dmesg =
977186_1.5.2.3.1>
    2023-06-14T12:03:56.416533  / # #
    2023-06-14T12:03:56.518197  export SHELL=3D/bin/sh
    2023-06-14T12:03:56.518669  #
    2023-06-14T12:03:56.620017  / # export SHELL=3D/bin/sh. /lava-977186/en=
vironment
    2023-06-14T12:03:56.620491  =

    2023-06-14T12:03:56.721810  / # . /lava-977186/environment/lava-977186/=
bin/lava-test-runner /lava-977186/1
    2023-06-14T12:03:56.722575  =

    2023-06-14T12:03:56.724955  / # /lava-977186/bin/lava-test-runner /lava=
-977186/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6489aeb9483f7440cf30614c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-1-g7cde3fba93966/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/basel=
ine-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-1-g7cde3fba93966/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/basel=
ine-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6489aeb9483f7440cf306151
        failing since 151 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-14T12:12:33.629342  + set[    7.209661] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 977204_1.5.2.3.1>
    2023-06-14T12:12:33.629700   +x
    2023-06-14T12:12:33.735254  / # #
    2023-06-14T12:12:33.837050  export SHELL=3D/bin/sh
    2023-06-14T12:12:33.837419  #
    2023-06-14T12:12:33.938580  / # export SHELL=3D/bin/sh. /lava-977204/en=
vironment
    2023-06-14T12:12:33.939018  =

    2023-06-14T12:12:34.040212  / # . /lava-977204/environment/lava-977204/=
bin/lava-test-runner /lava-977204/1
    2023-06-14T12:12:34.040867  =

    2023-06-14T12:12:34.043144  / # /lava-977204/bin/lava-test-runner /lava=
-977204/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 4          =


  Details:     https://kernelci.org/test/plan/id/6489aed12bd0a2677d306166

  Results:     63 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-1-g7cde3fba93966/arm/multi_v7_defconfig/gcc-10/lab-collabora/baselin=
e-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-1-g7cde3fba93966/arm/multi_v7_defconfig/gcc-10/lab-collabora/baselin=
e-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-i2c-present: https://kernelci.or=
g/test/case/id/6489aed12bd0a2677d306195
        failing since 149 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-14T12:13:48.676787  FIRST,<8>[   18.607175] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>

    2023-06-14T12:13:48.680464   INC default to 1.

    2023-06-14T12:13:48.680687  =


    2023-06-14T12:13:48.684072  	-w	Pad to last with leading zeros

    2023-06-14T12:13:48.686805  	-s SEP	String separator

    2023-06-14T12:13:48.690492  /lava-10724297/1/../bin/lava-test-case

    2023-06-14T12:13:48.696526  BusyBox v1.31.1 (2023-06-09 10:32:04 UTC) m=
ulti-call binary.

    2023-06-14T12:13:48.696823  =

   =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/6489aed12bd0a2677d306196
        failing since 149 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-14T12:13:48.656144   multi-call binary.

    2023-06-14T12:13:48.656581  =


    2023-06-14T12:13:48.660792  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-06-14T12:13:48.661009  =


    2023-06-14T12:13:48.666300  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/6489aed12bd0a2677d306197
        failing since 149 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-14T12:13:48.635274  /lava-10724297/1/../bin/lava-test-case<8>[ =
  18.570237] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-probed RE=
SULT=3Dpass>

    2023-06-14T12:13:48.635489  =


    2023-06-14T12:13:48.654135  BusyBox v1.31.1 (2023-06-09 10:32:04 UTC)<8=
>[   18.588054] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6489aed12bd0a2677d3061ab
        failing since 149 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-14T12:13:36.551518  <8>[    6.486332] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-06-14T12:13:36.561496  + <8>[    6.498942] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10724297_1.5.2.3.1>

    2023-06-14T12:13:36.561722  set +x

    2023-06-14T12:13:36.667491  =


    2023-06-14T12:13:36.768055  / # #export SHELL=3D/bin/sh

    2023-06-14T12:13:36.768195  =


    2023-06-14T12:13:36.868684  / # export SHELL=3D/bin/sh. /lava-10724297/=
environment

    2023-06-14T12:13:36.868822  =


    2023-06-14T12:13:36.969283  / # . /lava-10724297/environment<6>[    6.8=
10456] sbs-battery 2/lava-10724297/bin/lava-test-runner /lava-10724297/1

    2023-06-14T12:13:36.969531  0-000b: Disabling PEC because of broken Cro=
s-EC implementation
 =

    ... (23 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6489accdd05ccde83a30616d

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-1-g7cde3fba93966/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-1-g7cde3fba93966/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/6489accdd05ccde83a306173
        failing since 84 days (last pass: v5.10.173-cip28, first fail: v5.1=
0.175-cip29)

    2023-06-14T12:04:14.949517  <8>[   61.084043] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-06-14T12:04:15.973751  /lava-10724047/1/../bin/lava-test-case

    2023-06-14T12:04:15.984789  <8>[   62.119559] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/6489accdd05ccde83a306174
        failing since 84 days (last pass: v5.10.173-cip28, first fail: v5.1=
0.175-cip29)

    2023-06-14T12:04:14.938147  /lava-10724047/1/../bin/lava-test-case
   =

 =20

