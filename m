Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C513EC25B4E
	for <webhook@archiver.kernel.org>; Tue, 24 Jan 2023 13:16:59 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web10.14327.1674566211986621269
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 24 Jan 2023 05:16:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=kC2ORy1C;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.176, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f176.google.com with SMTP id jl3so14668537plb.8
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 24 Jan 2023 05:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=s4jXNQkMj8OBTRmBZtfXaCDmDUIzWOjMlwSRlpOk68E=;
        b=kC2ORy1CAyHrLdBVxFO0mUTnHC5gPTm+cQOrjD5vEb4VedoE0mRPf+9EKIipRGLHzZ
         uHDVUOz82xd5eS78FhI7IAv8+clFa2jkCb4B1YWWHC6ciASa5UON3joQCsdZoGm0grC9
         HiZF2fKQrfneXRrfB4Qv7xwZsn5qcQ/QHptbgnxCfJunDfvVV/6PapC9SwTCTpGQ5CQq
         wBDNkRxU+pB+XqE0yvSFx6n/W2pkW+A+lV9ZwN8nUDsDBYDMiTlKT2k4rB8TiGgR4el5
         8/UVneYeiq4tUyg5ywlB7Jsr4hLDs9Fa2TGtEPniuNudMPPa6NF3HbZ1NMQ27RYIlJqF
         ASgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s4jXNQkMj8OBTRmBZtfXaCDmDUIzWOjMlwSRlpOk68E=;
        b=WLK/sc16CYtcA1QtSY6fjZjW2ZBhm4Cn5nzkTS315UuQayKcSgEKOjSBuq+6G2IbD8
         7gA2mfTQD6AIcDQudCQvKudWvurCxW2p4dk582i5NJJzPhTwwdjyVuPFhYWaJwt7V+Mg
         5gVkHTQEaW2C6F2jqRaZzfBlwgkOk44QwDbbKyDlcIaBUiGkGeE5gfZmrI6epl0OTJLx
         eEoasBaLUjrHDfB/U+J8QLZcNLh7BtxANZGKIg3puzFPtsOp9nSmOATVZUAjUH13JRQF
         zlVL+Dapzpl8ri+c9KO8D00h3+H/qGzlnyTPratYTzLpWFwDQD9mYfH+DCOFXq/9/GlR
         w6Rw==
X-Gm-Message-State: AFqh2ko0tsxJfK1NO+UtDpyxsLBO8UNtuBwbMn2pCQWDFI6k/aElZO7E
	D3CB2crV9W0WWi2RMxWXlxb6P+vXJ7tAmOkkI88=
X-Google-Smtp-Source: AMrXdXs9IPD3BpuSZFSU48rjoP/lcDklZ3bhA+SBVC1rBnQGyEvc0DbNlVx2QWpf4ot24Lw/vbhwcQ==
X-Received: by 2002:a17:902:9690:b0:193:6520:739a with SMTP id n16-20020a170902969000b001936520739amr48015938plp.46.1674566211189;
        Tue, 24 Jan 2023 05:16:51 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902768500b001947c617c45sm1603636pll.221.2023.01.24.05.16.50
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 05:16:50 -0800 (PST)
Message-ID: <63cfda42.170a0220.50fef.2d8b@mx.google.com>
Date: Tue, 24 Jan 2023 05:16:50 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.162-cip24-952-gf408044f5bad
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 181 runs,
 6 regressions (v5.10.162-cip24-952-gf408044f5bad)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 24 Jan 2023 13:16:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10467

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 181 runs, 6 regression=
s (v5.10.162-cip24-952-gf408044f5bad)

Regressions Summary
-------------------

platform          | arch | lab          | compiler | defconfig           | =
regressions
------------------+------+--------------+----------+---------------------+-=
-----------
beagle-xm         | arm  | lab-baylibre | gcc-10   | multi_v7_defconfig  | =
1          =

beagle-xm         | arm  | lab-baylibre | gcc-10   | omap2plus_defconfig | =
1          =

beaglebone-black  | arm  | lab-broonie  | gcc-10   | omap2plus_defconfig | =
1          =

beaglebone-black  | arm  | lab-cip      | gcc-10   | omap2plus_defconfig | =
1          =

cubietruck        | arm  | lab-baylibre | gcc-10   | multi_v7_defconfig  | =
1          =

r8a7743-iwg20d-q7 | arm  | lab-cip      | gcc-10   | shmobile_defconfig  | =
1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.162-cip24-952-gf408044f5bad/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.162-cip24-952-gf408044f5bad
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      f408044f5bad2c96806e41c8eac61744913398d4 =



Test Regressions
---------------- =



platform          | arch | lab          | compiler | defconfig           | =
regressions
------------------+------+--------------+----------+---------------------+-=
-----------
beagle-xm         | arm  | lab-baylibre | gcc-10   | multi_v7_defconfig  | =
1          =


  Details:     https://kernelci.org/test/plan/id/63cfd2cd59ef567573915ee3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-952-gf408044f5bad/arm/multi_v7_defconfig/gcc-1=
0/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-952-gf408044f5bad/arm/multi_v7_defconfig/gcc-1=
0/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63cfd2cd59ef567573915=
ee4
        new failure (last pass: v5.10.158-cip22-142-g79bb6f9db05d) =

 =



platform          | arch | lab          | compiler | defconfig           | =
regressions
------------------+------+--------------+----------+---------------------+-=
-----------
beagle-xm         | arm  | lab-baylibre | gcc-10   | omap2plus_defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/63cfd1635a236f6340915ec8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-952-gf408044f5bad/arm/omap2plus_defconfig/gcc-=
10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-952-gf408044f5bad/arm/omap2plus_defconfig/gcc-=
10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63cfd1635a236f6340915=
ec9
        failing since 33 days (last pass: v5.10.155-cip21-405-g26d566555c3d=
e, first fail: v5.10.158-cip22-142-g79bb6f9db05d) =

 =



platform          | arch | lab          | compiler | defconfig           | =
regressions
------------------+------+--------------+----------+---------------------+-=
-----------
beaglebone-black  | arm  | lab-broonie  | gcc-10   | omap2plus_defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/63cfd0e174cc6f678a915ef8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-952-gf408044f5bad/arm/omap2plus_defconfig/gcc-=
10/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-952-gf408044f5bad/arm/omap2plus_defconfig/gcc-=
10/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63cfd0e174cc6f678a915efb
        failing since 20 days (last pass: v5.10.155-cip21-405-g26d566555c3d=
e, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2023-01-24T12:36:32.467527  <8>[   19.360442] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 165409_1.5.2.4.1>
    2023-01-24T12:36:32.620208  / # #
    2023-01-24T12:36:32.736167  export SHELL=3D/bin/sh
    2023-01-24T12:36:32.742249  #
    2023-01-24T12:36:32.852794  / # export SHELL=3D/bin/sh. /lava-165409/en=
vironment
    2023-01-24T12:36:32.859051  =

    2023-01-24T12:36:32.970277  / # . /lava-165409/environment/lava-165409/=
bin/lava-test-runner /lava-165409/1
    2023-01-24T12:36:32.980627  =

    2023-01-24T12:36:32.984877  / # /lava-165409/bin/lava-test-runner /lava=
-165409/1
    2023-01-24T12:36:33.080091  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform          | arch | lab          | compiler | defconfig           | =
regressions
------------------+------+--------------+----------+---------------------+-=
-----------
beaglebone-black  | arm  | lab-cip      | gcc-10   | omap2plus_defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/63cfd0d7bbb55938d8915f04

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-952-gf408044f5bad/arm/omap2plus_defconfig/gcc-=
10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-952-gf408044f5bad/arm/omap2plus_defconfig/gcc-=
10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63cfd0d7bbb55938d8915f07
        failing since 20 days (last pass: v5.10.155-cip21-405-g26d566555c3d=
e, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2023-01-24T12:36:24.814749  <8>[   13.048703] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 832016_1.5.2.4.1>
    2023-01-24T12:36:24.926143  / # #
    2023-01-24T12:36:25.028976  export SHELL=3D/bin/sh
    2023-01-24T12:36:25.029798  #
    2023-01-24T12:36:25.131685  / # export SHELL=3D/bin/sh. /lava-832016/en=
vironment
    2023-01-24T12:36:25.132586  =

    2023-01-24T12:36:25.234912  / # . /lava-832016/environment/lava-832016/=
bin/lava-test-runner /lava-832016/1
    2023-01-24T12:36:25.236021  =

    2023-01-24T12:36:25.241944  / # /lava-832016/bin/lava-test-runner /lava=
-832016/1
    2023-01-24T12:36:25.345379  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform          | arch | lab          | compiler | defconfig           | =
regressions
------------------+------+--------------+----------+---------------------+-=
-----------
cubietruck        | arm  | lab-baylibre | gcc-10   | multi_v7_defconfig  | =
1          =


  Details:     https://kernelci.org/test/plan/id/63cfd1b1f8a432e5a0915eba

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-952-gf408044f5bad/arm/multi_v7_defconfig/gcc-1=
0/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-952-gf408044f5bad/arm/multi_v7_defconfig/gcc-1=
0/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63cfd1b1f8a432e5a0915ebf
        failing since 5 days (last pass: v5.10.155-cip21-405-g26d566555c3de=
, first fail: v5.10.162-cip24-853-g709bb3738fde)

    2023-01-24T12:40:02.093526  <8>[   11.070166] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3198885_1.5.2.4.1>
    2023-01-24T12:40:02.204747  / # #
    2023-01-24T12:40:02.308945  export SHELL=3D/bin/sh
    2023-01-24T12:40:02.310276  #
    2023-01-24T12:40:02.413206  / # export SHELL=3D/bin/sh. /lava-3198885/e=
nvironment
    2023-01-24T12:40:02.414438  =

    2023-01-24T12:40:02.517202  / # . /lava-3198885/environment/lava-319888=
5/bin/lava-test-runner /lava-3198885/1
    2023-01-24T12:40:02.519149  =

    2023-01-24T12:40:02.523569  / # /lava-3198885/bin/lava-test-runner /lav=
a-3198885/1
    2023-01-24T12:40:02.567864  <3>[   11.530208] Bluetooth: hci0: command =
0xfc18 tx timeout =

    ... (12 line(s) more)  =

 =



platform          | arch | lab          | compiler | defconfig           | =
regressions
------------------+------+--------------+----------+---------------------+-=
-----------
r8a7743-iwg20d-q7 | arm  | lab-cip      | gcc-10   | shmobile_defconfig  | =
1          =


  Details:     https://kernelci.org/test/plan/id/63cfcd40ef8d5c4fc9915ec4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-952-gf408044f5bad/arm/shmobile_defconfig/gcc-1=
0/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-952-gf408044f5bad/arm/shmobile_defconfig/gcc-1=
0/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63cfcd40ef8d5c4fc9915=
ec5
        failing since 90 days (last pass: v5.10.147-cip18-56-g87bd4289362be=
, first fail: v5.10.147-cip18-12-g7bc9523ecfb7f) =

 =20

