Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BFCEB64DB
	for <webhook@archiver.kernel.org>; Thu, 15 Jun 2023 10:08:10 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web11.14624.1686823683784697664
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 15 Jun 2023 03:08:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=EA0T6q0M;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.181, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1b520c77de0so965075ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 15 Jun 2023 03:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686823683; x=1689415683;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oAvSd2WhpJEQvpRarCsrrsNwkZfvMY4bZNN8mDssOdA=;
        b=EA0T6q0MHPnzBAEEvIYgyfQkug4wQUAXAOX21GAnLS330ZQ/chJCGTqBaGV/x2/a1J
         OlQQRaPNeUImrnPMDGTEisQ6X/o1epQC5qbZX/SN+Hnws8SGBxXu1TWwoog0hPC0Zdgr
         TbFzaih6DfB73KGkj3VSmnsIcmRe5jsCOEUtuFWfcDrT+ctWAV6puaKOckSNxThAA/MG
         yd2/VQRb9YVLgHlawed+HR+vMMKLg0KxLlF03L7XoNclPyfwyizC7YRoDU5ue0fHEaXm
         rAeN6ge7ZliiCJ3PsX2h76/yAYhAyBIvpLp2XcU0NKx9NG9ZG32YbMkv/QZocB/LjLOr
         3B6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686823683; x=1689415683;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oAvSd2WhpJEQvpRarCsrrsNwkZfvMY4bZNN8mDssOdA=;
        b=kJTsImWcHAGwL9QurHE4oF597cibfA+5wKeK3AB6tBgyUxOhLDM94J6hwDQBqcz469
         2FX92eDAYHjkK2BAfQxXwrYbvgjkK38JTYWXIAiM5hRwrVPcg01iE4Dpz9jXNwDUOz2K
         9JHhA0EC7qAaBjmq+KJEywEXNr3XmuHiN7HVEUfisVA51EJUPQn2vPp6kZxsm8sx7MRB
         Y8KTPOmYakHj6ZWg0ShMpmzCWxi38eH8DPOJy5G2u9TVu4kubbHF5DZrqyXEmR7T7EWW
         JdrzUuzgzTJXZqrMXI5hGgRH43FT9Wud9KXdI40vmt/e2VLm1uNDtGgto6+IDGWu/rz3
         z0iw==
X-Gm-Message-State: AC+VfDxmgCqOmu6Yp2SwIsZGRCTGfKN/Z6vm6rZKf0SeE/BnaS/wnv4O
	wTbkIs6GilGm03Ti8XyYAVTSVRKTI/xyS8hXDKJqVg==
X-Google-Smtp-Source: ACHHUZ4qglsOMghOLtxmb2cvBrQ7YKof9gojCDhQxybRBoI8HehVqkT+mMBWt7r1MhNRwquIVT/fEQ==
X-Received: by 2002:a17:902:9b8c:b0:1b1:99d8:4361 with SMTP id y12-20020a1709029b8c00b001b199d84361mr11873117plp.6.1686823681469;
        Thu, 15 Jun 2023 03:08:01 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id o7-20020a170902bcc700b001b052483e9csm13678832pls.231.2023.06.15.03.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 03:08:00 -0700 (PDT)
Message-ID: <648ae300.170a0220.3ee65.cac3@mx.google.com>
Date: Thu, 15 Jun 2023 03:08:00 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.182-cip35-8-gdba81ae6f2be
Subject: cip/linux-5.10.y-cip baseline: 136 runs,
 24 regressions (v5.10.182-cip35-8-gdba81ae6f2be)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jun 2023 10:08:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12047

cip/linux-5.10.y-cip baseline: 136 runs, 24 regressions (v5.10.182-cip35-8-=
gdba81ae6f2be)

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

at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =

fsl-ls1028a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

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

imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =

imx7ulp-evk                  | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =

mt8173-elm-hana              | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =

rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 4          =

rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.182-cip35-8-gdba81ae6f2be/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.182-cip35-8-gdba81ae6f2be
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      dba81ae6f2be7f7d87f3a29a8566758d2e0017ae =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648ad6ab519631ea2e306165

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648ad6ab519631ea2e30616a
        failing since 152 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-15T09:15:04.168300  + set +x

    2023-06-15T09:15:04.175190  <8>[   11.400096] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10740246_1.4.2.3.1>

    2023-06-15T09:15:04.277093  =


    2023-06-15T09:15:04.377648  / # #export SHELL=3D/bin/sh

    2023-06-15T09:15:04.377838  =


    2023-06-15T09:15:04.478320  / # export SHELL=3D/bin/sh. /lava-10740246/=
environment

    2023-06-15T09:15:04.478509  =


    2023-06-15T09:15:04.579105  / # . /lava-10740246/environment/lava-10740=
246/bin/lava-test-runner /lava-10740246/1

    2023-06-15T09:15:04.579392  =


    2023-06-15T09:15:04.579462  / # <4>[   11.745935] i2c_designware i2c_de=
signware.2: timeout in disabling adapter
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648ad699792ad0d8cb306141

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648ad699792ad0d8cb306146
        failing since 152 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-15T09:14:56.363627  + set +x

    2023-06-15T09:14:56.373462  <8>[   12.019140] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10740281_1.4.2.3.1>

    2023-06-15T09:14:56.478352  / # #

    2023-06-15T09:14:56.580714  export SHELL=3D/bin/sh

    2023-06-15T09:14:56.581448  #

    2023-06-15T09:14:56.682851  / # export SHELL=3D/bin/sh. /lava-10740281/=
environment

    2023-06-15T09:14:56.683656  =


    2023-06-15T09:14:56.684041  / # <4>[   12.273167] i2c_designware i2c_de=
signware.5: timeout in disabling adapter

    2023-06-15T09:14:56.785374  . /lava-10740281/environment/lava-10740281/=
bin/lava-test-runner /lava-10740281/1

    2023-06-15T09:14:56.786489  =

 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/648ad572e6568cd32130612e

  Results:     47 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-a=
t91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-a=
t91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648ad572e6568cd321306163
        failing since 152 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-15T09:09:35.277383  + set +x
    2023-06-15T09:09:35.282571  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 614932_1.5.2=
.4.1>
    2023-06-15T09:09:35.396083  / # #
    2023-06-15T09:09:35.498988  export SHELL=3D/bin/sh
    2023-06-15T09:09:35.499805  #
    2023-06-15T09:09:35.601712  / # export SHELL=3D/bin/sh. /lava-614932/en=
vironment
    2023-06-15T09:09:35.602507  =

    2023-06-15T09:09:35.704505  / # . /lava-614932/environment/lava-614932/=
bin/lava-test-runner /lava-614932/1
    2023-06-15T09:09:35.705839  =

    2023-06-15T09:09:35.712338  / # /lava-614932/bin/lava-test-runner /lava=
-614932/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/648ad6ccf89df0731830615e

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-b=
eaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-b=
eaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648ad6ccf89df0731830618b
        failing since 152 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-15T09:15:18.984495  <8>[   21.785224] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 614969_1.5.2.4.1>
    2023-06-15T09:15:19.094331  / # #
    2023-06-15T09:15:19.197412  export SHELL=3D/bin/sh
    2023-06-15T09:15:19.198345  #
    2023-06-15T09:15:19.300467  / # export SHELL=3D/bin/sh. /lava-614969/en=
vironment
    2023-06-15T09:15:19.301226  =

    2023-06-15T09:15:19.403685  / # . /lava-614969/environment/lava-614969/=
bin/lava-test-runner /lava-614969/1
    2023-06-15T09:15:19.404806  =

    2023-06-15T09:15:19.409483  / # /lava-614969/bin/lava-test-runner /lava=
-614969/1
    2023-06-15T09:15:19.495934  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/648addf5a139d0466e30612e

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beagl=
ebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beagl=
ebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648addf5a139d0466e306131
        failing since 152 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-15T09:45:43.671006  / # #
    2023-06-15T09:45:43.774956  export SHELL=3D/bin/sh
    2023-06-15T09:45:43.775869  #
    2023-06-15T09:45:43.878154  / # export SHELL=3D/bin/sh. /lava-963642/en=
vironment
    2023-06-15T09:45:43.879056  =

    2023-06-15T09:45:43.981645  / # . /lava-963642/environment/lava-963642/=
bin/lava-test-runner /lava-963642/1
    2023-06-15T09:45:43.983064  =

    2023-06-15T09:45:43.996165  / # /lava-963642/bin/lava-test-runner /lava=
-963642/1
    2023-06-15T09:45:44.120100  + export 'TESTRUN_ID=3D1_bootrr'
    2023-06-15T09:45:44.120679  + cd /lava-963642/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/648ad744b8ad311d83306136

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-=
beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-=
beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648ad745b8ad311d8330616c
        failing since 152 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-15T09:17:36.846397  <8>[   19.770429] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 615022_1.5.2.4.1>
    2023-06-15T09:17:36.955517  / # #
    2023-06-15T09:17:37.057972  export SHELL=3D/bin/sh
    2023-06-15T09:17:37.058699  #
    2023-06-15T09:17:37.161047  / # export SHELL=3D/bin/sh. /lava-615022/en=
vironment
    2023-06-15T09:17:37.161638  =

    2023-06-15T09:17:37.263493  / # . /lava-615022/environment/lava-615022/=
bin/lava-test-runner /lava-615022/1
    2023-06-15T09:17:37.264644  =

    2023-06-15T09:17:37.269401  / # /lava-615022/bin/lava-test-runner /lava=
-615022/1
    2023-06-15T09:17:37.376402  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/648ae0d0eebf004cc4306170

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648ae0d0eebf004cc4306173
        failing since 152 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-15T09:58:27.563309  <8>[   13.049549] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 963671_1.5.2.4.1>
    2023-06-15T09:58:27.672827  / # #
    2023-06-15T09:58:27.774926  export SHELL=3D/bin/sh
    2023-06-15T09:58:27.775657  #
    2023-06-15T09:58:27.877098  / # export SHELL=3D/bin/sh. /lava-963671/en=
vironment
    2023-06-15T09:58:27.877753  =

    2023-06-15T09:58:27.979201  / # . /lava-963671/environment/lava-963671/=
bin/lava-test-runner /lava-963671/1
    2023-06-15T09:58:27.980201  =

    2023-06-15T09:58:27.986554  / # /lava-963671/bin/lava-test-runner /lava=
-963671/1
    2023-06-15T09:58:28.094225  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls1028a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/648ad73fd3fadee11230612f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1028a-=
rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1028a-=
rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648ad73fd3fadee112306132
        failing since 93 days (last pass: v5.10.155-cip21, first fail: v5.1=
0.173-cip28)

    2023-06-15T09:17:23.899388  + [   23.557433] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 1234892_1.5.2.4.1>
    2023-06-15T09:17:23.899707  set +x
    2023-06-15T09:17:24.005430  / # #
    2023-06-15T09:17:24.107278  export SHELL=3D/bin/sh
    2023-06-15T09:17:24.107723  #
    2023-06-15T09:17:24.209109  / # export SHELL=3D/bin/sh. /lava-1234892/e=
nvironment
    2023-06-15T09:17:24.209526  =

    2023-06-15T09:17:24.310728  / # . /lava-1234892/environment/lava-123489=
2/bin/lava-test-runner /lava-1234892/1
    2023-06-15T09:17:24.311526  =

    2023-06-15T09:17:24.313478  / # /lava-1234892/bin/lava-test-runner /lav=
a-1234892/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648ad68a5f1c9e049e3061de

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648ad68a5f1c9e049e3061e3
        failing since 61 days (last pass: v5.10.176-cip30, first fail: v5.1=
0.177-cip31)

    2023-06-15T09:14:47.516873  + set +x

    2023-06-15T09:14:47.523240  <8>[   14.610458] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10740241_1.4.2.3.1>

    2023-06-15T09:14:47.628073  / # #

    2023-06-15T09:14:47.728838  export SHELL=3D/bin/sh

    2023-06-15T09:14:47.729043  #

    2023-06-15T09:14:47.829535  / # export SHELL=3D/bin/sh. /lava-10740241/=
environment

    2023-06-15T09:14:47.829763  =


    2023-06-15T09:14:47.930291  / # . /lava-10740241/environment/lava-10740=
241/bin/lava-test-runner /lava-10740241/1

    2023-06-15T09:14:47.930645  =


    2023-06-15T09:14:47.935296  / # /lava-10740241/bin/lava-test-runner /la=
va-10740241/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648ad69347ae144c77306172

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648ad69347ae144c77306177
        failing since 61 days (last pass: v5.10.176-cip30, first fail: v5.1=
0.177-cip31)

    2023-06-15T09:14:53.473033  <8>[   12.634342] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10740238_1.4.2.3.1>

    2023-06-15T09:14:53.476523  + set +x

    2023-06-15T09:14:53.578093  =


    2023-06-15T09:14:53.679092  / # #export SHELL=3D/bin/sh

    2023-06-15T09:14:53.679809  =


    2023-06-15T09:14:53.781046  / # export SHELL=3D/bin/sh. /lava-10740238/=
environment

    2023-06-15T09:14:53.781225  =


    2023-06-15T09:14:53.881727  / # . /lava-10740238/environment/lava-10740=
238/bin/lava-test-runner /lava-10740238/1

    2023-06-15T09:14:53.882100  =


    2023-06-15T09:14:53.887040  / # /lava-10740238/bin/lava-test-runner /la=
va-10740238/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/648ad6815f1c9e049e3061b7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline=
-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline=
-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648ad6815f1c9e049e3061bc
        failing since 152 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-15T09:14:34.813428  / # #

    2023-06-15T09:14:34.916134  export SHELL=3D/bin/sh

    2023-06-15T09:14:34.916908  #

    2023-06-15T09:14:35.018747  / # export SHELL=3D/bin/sh. /lava-10740206/=
environment

    2023-06-15T09:14:35.019494  =


    2023-06-15T09:14:35.121339  / # . /lava-10740206/environment/lava-10740=
206/bin/lava-test-runner /lava-10740206/1

    2023-06-15T09:14:35.122508  =


    2023-06-15T09:14:35.136679  / # /lava-10740206/bin/lava-test-runner /la=
va-10740206/1

    2023-06-15T09:14:35.240204  + export 'TESTRUN_ID=3D1_bootrr'

    2023-06-15T09:14:35.240701  + cd /lava-10740206/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/648ad7d96849afa87930613a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/basel=
ine-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/basel=
ine-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648ad7d96849afa87930613f
        failing since 152 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-15T09:20:18.690509  + set +x
    2023-06-15T09:20:18.690672  [   10.300335] <LAVA_SIGNAL_ENDRUN 0_dmesg =
978136_1.5.2.3.1>
    2023-06-15T09:20:18.799241  / # #
    2023-06-15T09:20:18.900962  export SHELL=3D/bin/sh
    2023-06-15T09:20:18.901430  #
    2023-06-15T09:20:19.002725  / # export SHELL=3D/bin/sh. /lava-978136/en=
vironment
    2023-06-15T09:20:19.003287  =

    2023-06-15T09:20:19.104610  / # . /lava-978136/environment/lava-978136/=
bin/lava-test-runner /lava-978136/1
    2023-06-15T09:20:19.105309  =

    2023-06-15T09:20:19.108412  / # /lava-978136/bin/lava-test-runner /lava=
-978136/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/648ad74db8ad311d83306175

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseli=
ne-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseli=
ne-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648ad74db8ad311d8330617a
        failing since 152 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-15T09:17:58.148480  + set[    7.162812] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 978121_1.5.2.3.1>
    2023-06-15T09:17:58.148784   +x
    2023-06-15T09:17:58.254871  / # #
    2023-06-15T09:17:58.356698  export SHELL=3D/bin/sh
    2023-06-15T09:17:58.357251  #
    2023-06-15T09:17:58.458795  / # export SHELL=3D/bin/sh. /lava-978121/en=
vironment
    2023-06-15T09:17:58.459695  =

    2023-06-15T09:17:58.561506  / # . /lava-978121/environment/lava-978121/=
bin/lava-test-runner /lava-978121/1
    2023-06-15T09:17:58.562112  =

    2023-06-15T09:17:58.564444  / # /lava-978121/bin/lava-test-runner /lava=
-978121/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/648ad72635baf6fd6f306133

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7d=
-sdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7d=
-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648ad72635baf6fd6f306136
        failing since 152 days (last pass: v5.10.155-cip21, first fail: v5.=
10.162-cip24)

    2023-06-15T09:16:54.204442  <8>[   17.074883] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1234887_1.5.2.4.1>
    2023-06-15T09:16:54.310112  / # #
    2023-06-15T09:16:55.470287  export SHELL=3D/bin/sh
    2023-06-15T09:16:55.475988  #
    2023-06-15T09:16:57.023578  / # export SHELL=3D/bin/sh. /lava-1234887/e=
nvironment
    2023-06-15T09:16:57.029296  =

    2023-06-15T09:16:59.850497  / # . /lava-1234887/environment/lava-123488=
7/bin/lava-test-runner /lava-1234887/1
    2023-06-15T09:16:59.856135  =

    2023-06-15T09:16:59.863918  / # /lava-1234887/bin/lava-test-runner /lav=
a-1234887/1
    2023-06-15T09:16:59.956011  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (19 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7ulp-evk                  | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/648ad8523fc9554484306197

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7u=
lp-evk.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7u=
lp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648ad8523fc955448430619a
        failing since 93 days (last pass: v5.10.155-cip21, first fail: v5.1=
0.173-cip28)

    2023-06-15T09:22:06.716670  + set +x<8>[   28.964440] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 1234888_1.5.2.4.1>
    2023-06-15T09:22:06.716974  =

    2023-06-15T09:22:06.825188  / # #
    2023-06-15T09:22:07.985407  export SHELL=3D/bin/sh
    2023-06-15T09:22:07.991094  #
    2023-06-15T09:22:07.991386  / # export SHELL=3D/bin/sh
    2023-06-15T09:22:09.539121  / # . /lava-1234888/environment
    2023-06-15T09:22:12.367103  /lava-1234888/bin/lava-test-runner /lava-12=
34888/1
    2023-06-15T09:22:12.373174  . /lava-1234888/environment
    2023-06-15T09:22:12.373430  / # /lava-1234888/bin/lava-test-runner /lav=
a-1234888/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/648adc75f1964c4b683061a2

  Results:     28 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabor=
a/baseline-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabor=
a/baseline-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648adc75f1964c4b683061be
        failing since 152 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-15T09:39:51.200795  + set +x

    2023-06-15T09:39:51.205266  <8>[   15.632338] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10740414_1.5.2.3.1>

    2023-06-15T09:39:51.313368  =


    2023-06-15T09:39:51.415209  / # #export SHELL=3D/bin/sh

    2023-06-15T09:39:51.415993  =


    2023-06-15T09:39:51.517718  / # export SHELL=3D/bin/sh. /lava-10740414/=
environment

    2023-06-15T09:39:51.518505  =


    2023-06-15T09:39:51.620190  / # . /lava-10740414/environment/lava-10740=
414/bin/lava-test-runner /lava-10740414/1

    2023-06-15T09:39:51.621488  =


    2023-06-15T09:39:51.623436  / # /lava-10740414/bin/lava-test-runner /la=
va-10740414/1
 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/648ad73aacf3405e1730618d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a77=
43-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a77=
43-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/648ad73aacf3405e17306=
18e
        failing since 9 days (last pass: v5.10.180-cip34, first fail: v5.10=
.180-cip34-19-gf0f6960f132cd) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 4          =


  Details:     https://kernelci.org/test/plan/id/648ad6775f1c9e049e30613b

  Results:     63 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline=
-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline=
-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-i2c-present: https://kernelci.or=
g/test/case/id/648ad6775f1c9e049e30616a
        failing since 150 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-15T09:15:16.043985  FIRST,<8>[   18.639726] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>

    2023-06-15T09:15:16.045924   INC default to 1.

    2023-06-15T09:15:16.045981  =


    2023-06-15T09:15:16.049582  	-w	Pad to last with leading zeros

    2023-06-15T09:15:16.051984  	-s SEP	String separator

    2023-06-15T09:15:16.056056  /lava-10740200/1/../bin/lava-test-case

    2023-06-15T09:15:16.061977  BusyBox v1.31.1 (2023-06-09 10:32:04 UTC) m=
ulti-call binary.

    2023-06-15T09:15:16.062203  =

   =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/648ad6775f1c9e049e30616b
        failing since 150 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-15T09:15:16.021646  BusyBox v1.31.1 (2023-06-09 10:32:04 UTC)<8=
>[   18.620747] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-06-15T09:15:16.023661   multi-call binary.

    2023-06-15T09:15:16.023727  =


    2023-06-15T09:15:16.028551  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-06-15T09:15:16.028609  =


    2023-06-15T09:15:16.033380  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/648ad6775f1c9e049e30616c
        failing since 150 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-15T09:15:16.002585  /lava-10740200/1/../bin/lava-test-case<8>[ =
  18.603013] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-probed RE=
SULT=3Dpass>

    2023-06-15T09:15:16.002803  =

   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648ad6775f1c9e049e306180
        failing since 150 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-15T09:15:03.951669  + <8>[    6.554618] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10740200_1.5.2.3.1>

    2023-06-15T09:15:03.952237  set +x

    2023-06-15T09:15:04.058552  =


    2023-06-15T09:15:04.160090  / # #export SHELL=3D/bin/sh

    2023-06-15T09:15:04.160815  =


    2023-06-15T09:15:04.262158  / # export SHELL=3D/bin/sh. /lava-10740200/=
environment

    2023-06-15T09:15:04.262903  =


    2023-06-15T09:15:04.364172  / # . /lava-10740200/environment/lava-10740=
200/bin/lava-test-runner /lava-10740200/1

    2023-06-15T09:15:04.365158  =


    2023-06-15T09:15:04.366343  / # /lava-10740200/bin/lava-test-runner /la=
va-10740200/1
 =

    ... (18 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/648adc703ed4534ad6306150

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabor=
a/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabor=
a/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/648adc703ed4534ad6306156
        failing since 85 days (last pass: v5.10.173-cip28, first fail: v5.1=
0.175-cip29)

    2023-06-15T09:39:56.087407  <8>[   33.904784] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-06-15T09:39:57.111470  /lava-10740426/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/648adc703ed4534ad6306157
        failing since 85 days (last pass: v5.10.173-cip28, first fail: v5.1=
0.175-cip29)

    2023-06-15T09:39:56.075195  /lava-10740426/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/648ad743ba17088d3130615f

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a=
64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a=
64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648ad743ba17088d3130618b
        failing since 152 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-15T09:17:27.284636  + set +x
    2023-06-15T09:17:27.288694  <8>[   17.088946] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 615005_1.5.2.4.1>
    2023-06-15T09:17:27.399925  / # #
    2023-06-15T09:17:27.503107  export SHELL=3D/bin/sh
    2023-06-15T09:17:27.503885  #
    2023-06-15T09:17:27.606339  / # export SHELL=3D/bin/sh. /lava-615005/en=
vironment
    2023-06-15T09:17:27.607135  =

    2023-06-15T09:17:27.709665  / # . /lava-615005/environment/lava-615005/=
bin/lava-test-runner /lava-615005/1
    2023-06-15T09:17:27.710771  =

    2023-06-15T09:17:27.715121  / # /lava-615005/bin/lava-test-runner /lava=
-615005/1 =

    ... (12 line(s) more)  =

 =20

