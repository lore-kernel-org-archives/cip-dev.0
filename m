Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004ACC61D97
	for <webhook@archiver.kernel.org>; Fri, 27 Jan 2023 00:52:46 +0000 (UTC)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
 by mx.groups.io with SMTP id smtpd.web11.91999.1674780759331868598
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 26 Jan 2023 16:52:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=S+TOmoSn;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.45, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f45.google.com with SMTP id z1-20020a17090a66c100b00226f05b9595so3458569pjl.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 26 Jan 2023 16:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Cru7JiRc4hVftqrL9WpGp+/Ftz/JnphTOmWCH2TVnlM=;
        b=S+TOmoSnYgX5P0Y1m3pBA4jGsXNNmfq5sDeo5ujwzW9ozTS9C/83xhfl9PUIxBfPKq
         5ax7BiP+drZYU+kuglS290vV20UAT6MGwUyBeVVATJpI188aPpmqeIUR2euX1gbeuAz2
         9Nc+Tv5USIUYOMSGGPTwqsWS1HuYvKVSC4H9lI2Ou6cm55HllW5pLHQ21+jz0Etklx2F
         UICm75ELHieae0cvupnOXD3OL0+t6Hhadl3CKfq9sYp86EyHAPsbfXmeoYeAybYx4mH4
         9SmWadN/ra5PhvD7Ttlx7m8uacS1xys2OPQ76L33iv6Q4iiUS8+HbYiqJksdIuJcWNSg
         dN0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cru7JiRc4hVftqrL9WpGp+/Ftz/JnphTOmWCH2TVnlM=;
        b=TK0YBElyFpS9dmYCN3JTdFOqtlnVVOJwky46c9u1nLh2p3iNfC9ZVBO8D5N9Zx326n
         EVaE8VM3Q9Gh666iEtoHuPusttVbFalc9VeuOvyF2c/opL3FVhkrbYjZO79Xh1WVeuTP
         XMp9YILceI36MYpllP31l+MnnxRnAyxbbHmwf9+UBnm3NHrBTSkQ3iHTPWLXu9HgU8NR
         5RUh79jSuDwqZifIjM5vmeJfd8cQ62z5PtFL4EhsJvWA/PiqkDJtksar2GpmEaI9QiiR
         XZi40UcM30qpYYukXB1hyhOmiKrv06wYyFzEbb8/IgAnXpMvAOi9RMD85WAlCD8mZPK0
         tE8g==
X-Gm-Message-State: AFqh2koM+ItR3EkvzKet1FVgzCbUrY2UdGyFOtBkDYWYyp1k5ioc7yRv
	NMaGXq4Wb1cBMa0Nxu2BOq7D9/ZUp/6YDd9OqtQ=
X-Google-Smtp-Source: AMrXdXtxsWY8YpTIn4gzjBvcfQB1drISNm0fGOdk3vU1kRde7XmNzh0PAMx+5pHS4AT/zV1NfP5JoA==
X-Received: by 2002:a17:90a:4587:b0:229:bc1:7cd1 with SMTP id v7-20020a17090a458700b002290bc17cd1mr40309962pjg.33.1674780757751;
        Thu, 26 Jan 2023 16:52:37 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id r63-20020a17090a43c500b0022bacef5fbdsm3841969pjg.52.2023.01.26.16.52.36
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 16:52:37 -0800 (PST)
Message-ID: <63d32055.170a0220.f93e.6b2a@mx.google.com>
Date: Thu, 26 Jan 2023 16:52:37 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v5.10.162-cip24-443-g1f8fb81fe752
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline: 170 runs,
 29 regressions (v5.10.162-cip24-443-g1f8fb81fe752)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 27 Jan 2023 00:52:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10486

cip-gitlab/ci/pavel/linux-test baseline: 170 runs, 29 regressions (v5.10.16=
2-cip24-443-g1f8fb81fe752)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig           | 1          =

bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =

beagle-xm                    | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =

cubietruck                   | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =

da850-lcdk                   | arm    | lab-baylibre    | gcc-10   | davinc=
i_all_defconfig        | 2          =

da850-lcdk                   | arm    | lab-baylibre    | gcc-10   | multi_=
v5_defconfig           | 1          =

fsl-ls1088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =

imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =

imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 4          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =

zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =

zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.162-cip24-443-g1f8fb81fe752/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.162-cip24-443-g1f8fb81fe752
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      1f8fb81fe7523922b7ff40bbacc9ac4aa9e11796 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63d317f8d362caecaa915ebd

  Results:     5 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/baseline-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/baseline-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d317f8d362caecaa915ec2
        failing since 8 days (last pass: v5.10.158-cip22-435-g2c52868ae1cbc=
, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-27T00:16:32.194331  <8>[    6#
    2023-01-27T00:16:32.194616  .755411] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=
=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-01-27T00:16:32.194694  <8>[    6.761386] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 8893600_1.4.2.3.1>
    2023-01-27T00:16:32.295622  / # #export SHELL=3D/bin/sh
    2023-01-27T00:16:32.295809  =

    2023-01-27T00:16:32.396500  / # export SHELL=3D/bin/sh. /lava-8893600/e=
nvironment
    2023-01-27T00:16:32.396691  =

    2023-01-27T00:16:32.497578  / # . /lava-8893600/environment/lava-889360=
0/bin/lava-test-runner /lava-8893600/1
    2023-01-27T00:16:32.497847  =

    2023-01-27T00:16:32.502740  / # /lava-8893600/bin/lava-test-runner /lav=
a-8893600/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63d318507821595d2e915eb9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/baseline-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/baseline-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d318507821595d2e915ebe
        failing since 8 days (last pass: v5.10.158-cip22-435-g2c52868ae1cbc=
, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-27T00:18:04.422711  + set +x
    2023-01-27T00:18:04.427990  <8>[    7.497224] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 8893593_1.4.2.3.1>
    2023-01-27T00:18:04.428717  =

    2023-01-27T00:18:04.532587  / # #
    2023-01-27T00:18:04.635547  export SHELL=3D/bin/sh
    2023-01-27T00:18:04.636373  #
    2023-01-27T00:18:04.738325  / # export SHELL=3D/bin/sh. /lava-8893593/e=
nvironment
    2023-01-27T00:18:04.739217  =

    2023-01-27T00:18:04.841131  / # . /lava-8893593/environment/lava-889359=
3/bin/lava-test-runner /lava-8893593/1
    2023-01-27T00:18:04.841467   =

    ... (16 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63d316b0da9aa8a9a7915ecf

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm/multi_v5_defconfig/gcc-10/lab-brooni=
e/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm/multi_v5_defconfig/gcc-10/lab-brooni=
e/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d316b0da9aa8a9a7915ed4
        new failure (last pass: v4.19.269-cip88-rt28-rebase)

    2023-01-27T00:10:25.184620  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 188156_1.5.2=
.4.1>
    2023-01-27T00:10:25.297026  / # #
    2023-01-27T00:10:25.400034  export SHELL=3D/bin/sh
    2023-01-27T00:10:25.400866  #
    2023-01-27T00:10:25.502857  / # export SHELL=3D/bin/sh. /lava-188156/en=
vironment
    2023-01-27T00:10:25.503659  =

    2023-01-27T00:10:25.605628  / # . /lava-188156/environment/lava-188156/=
bin/lava-test-runner /lava-188156/1
    2023-01-27T00:10:25.606984  =

    2023-01-27T00:10:25.613488  / # /lava-188156/bin/lava-test-runner /lava=
-188156/1
    2023-01-27T00:10:25.779068  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63d31c54065d64a013915ebb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm/multi_v7_defconfig/gcc-10/lab-collab=
ora/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm/multi_v7_defconfig/gcc-10/lab-collab=
ora/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63d31c54065d64a013915=
ebc
        new failure (last pass: v4.19.269-cip88-rt28-rebase) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beagle-xm                    | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63d318ae1cc5df0c94915eca

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm/multi_v7_defconfig/gcc-10/lab-baylib=
re/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm/multi_v7_defconfig/gcc-10/lab-baylib=
re/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d318ae1cc5df0c94915ecf
        failing since 8 days (last pass: v5.10.145-rt74-1329-ga59fc50f38f6,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-27T00:19:50.673549  + set +x
    2023-01-27T00:19:50.782564  TESTCASE TEST_CASE_ID=3Demerg RESULT=3Dpass=
 UNITS=3Dlines MEASUREMENT=3D0>
    2023-01-27T00:19:50.783016  =

    2023-01-27T00:19:50.783415  <8>[   25.883941] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3222045_1.5.2.4.1>
    2023-01-27T00:19:50.885872  / # #export SHELL=3D/bin/sh
    2023-01-27T00:19:50.886884  =

    2023-01-27T00:19:50.989060  / # export SHELL=3D/bin/sh. /lava-3222045/e=
nvironment
    2023-01-27T00:19:50.989938  =

    2023-01-27T00:19:51.091973  / # . /lava-3222045/environment/lava-322204=
5/bin/lava-test-runner /lava-3222045/1
    2023-01-27T00:19:51.093851   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63d318bd8dbfb382b9915ef3

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d318bd8dbfb382b9915ef8
        failing since 8 days (last pass: v5.10.158-cip22-435-g2c52868ae1cbc=
, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-27T00:19:59.755615  + set +x
    2023-01-27T00:19:59.861774  TESTCASE TEST_CASE_ID=3Demerg RESULT=3Dpass=
 UNITS=3Dlines MEASUREMENT=3D0>
    2023-01-27T00:19:59.862052  =

    2023-01-27T00:19:59.862349  / # <8>[   21.712137] <LAVA_SIGNAL_ENDRUN 0=
_dmesg 188256_1.5.2.4.1>
    2023-01-27T00:19:59.964313  #export SHELL=3D/bin/sh
    2023-01-27T00:19:59.964934  =

    2023-01-27T00:20:00.066468  / # export SHELL=3D/bin/sh. /lava-188256/en=
vironment
    2023-01-27T00:20:00.067043  =

    2023-01-27T00:20:00.168453  / # . /lava-188256/environment/lava-188256/=
bin/lava-test-runner /lava-188256/1
    2023-01-27T00:20:00.169379   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63d318b31cc5df0c94915ed6

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm/multi_v7_defconfig/gcc-10/lab-cip/ba=
seline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm/multi_v7_defconfig/gcc-10/lab-cip/ba=
seline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d318b31cc5df0c94915ed9
        failing since 8 days (last pass: v5.10.158-cip22-435-g2c52868ae1cbc=
, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-27T00:19:53.340707  + set +x
    2023-01-27T00:19:53.449569  TEST_CASE_ID=3Demerg RESULT=3Dpass UNITS=3D=
lines MEASUREMENT=3D0>
    2023-01-27T00:19:53.449681  =

    2023-01-27T00:19:53.449785  / # <8>[   16.542125] <LAVA_SIGNAL_ENDRUN 0=
_dmesg 834168_1.5.2.4.1>
    2023-01-27T00:19:53.550844  #export SHELL=3D/bin/sh
    2023-01-27T00:19:53.551077  =

    2023-01-27T00:19:53.652052  / # export SHELL=3D/bin/sh. /lava-834168/en=
vironment
    2023-01-27T00:19:53.652276  =

    2023-01-27T00:19:53.753271  / # . /lava-834168/environment/lava-834168/=
bin/lava-test-runner /lava-834168/1
    2023-01-27T00:19:53.753640   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63d31a14e3497ee852915eb9

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm/omap2plus_defconfig/gcc-10/lab-broon=
ie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm/omap2plus_defconfig/gcc-10/lab-broon=
ie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d31a14e3497ee852915ebe
        failing since 7 days (last pass: v4.19.269-rt119-858-g4aae57dbf650,=
 first fail: v4.19.269-cip88-rt28-rebase)

    2023-01-27T00:25:36.645654  + set +x
    2023-01-27T00:25:36.750606  TESTCASE TEST_CASE_ID=3Demerg RESULT=3Dpass=
 UNITS=3Dlines MEASUREMENT=3D0>
    2023-01-27T00:25:36.750925  =

    2023-01-27T00:25:36.751187  / # <8>[   19.393206] <LAVA_SIGNAL_ENDRUN 0=
_dmesg 188291_1.5.2.4.1>
    2023-01-27T00:25:36.852777  #export SHELL=3D/bin/sh
    2023-01-27T00:25:36.853272  =

    2023-01-27T00:25:36.955053  / # export SHELL=3D/bin/sh. /lava-188291/en=
vironment
    2023-01-27T00:25:36.955696  =

    2023-01-27T00:25:37.057637  / # . /lava-188291/environment/lava-188291/=
bin/lava-test-runner /lava-188291/1
    2023-01-27T00:25:37.058816   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63d319b72651b38e0f915ef9

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm/omap2plus_defconfig/gcc-10/lab-cip/b=
aseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm/omap2plus_defconfig/gcc-10/lab-cip/b=
aseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d319b72651b38e0f915efc
        failing since 7 days (last pass: v4.19.269-rt119-858-g4aae57dbf650,=
 first fail: v4.19.269-cip88-rt28-rebase)

    2023-01-27T00:24:10.531471  + set +x
    2023-01-27T00:24:10.640020  / # #
    2023-01-27T00:24:10.742184  export SHELL=3D/bin/sh
    2023-01-27T00:24:10.742807  <8>[   14.234452] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-01-27T00:24:10.743098  <8>[   14.236651] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 834204_1.5.2.4.1>
    2023-01-27T00:24:10.743349  #
    2023-01-27T00:24:10.844690  / # export SHELL=3D/bin/sh. /lava-834204/en=
vironment
    2023-01-27T00:24:10.845167  =

    2023-01-27T00:24:10.946561  / # . /lava-834204/environment/lava-834204/=
bin/lava-test-runner /lava-834204/1
    2023-01-27T00:24:10.947350   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
cubietruck                   | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63d318b08dbfb382b9915ee6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm/multi_v7_defconfig/gcc-10/lab-baylib=
re/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm/multi_v7_defconfig/gcc-10/lab-baylib=
re/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d318b08dbfb382b9915eeb
        failing since 7 days (last pass: v5.10.158-cip22-435-g2c52868ae1cbc=
, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-27T00:19:51.917694  <8>[   10.883876] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3222060_1.5.2.4.1>
    2023-01-27T00:19:52.027209  / # #
    2023-01-27T00:19:52.130864  export SHELL=3D/bin/sh
    2023-01-27T00:19:52.131964  #
    2023-01-27T00:19:52.132541  / # <3>[   11.044673] Bluetooth: hci0: comm=
and 0xfc18 tx timeout
    2023-01-27T00:19:52.234762  export SHELL=3D/bin/sh. /lava-3222060/envir=
onment
    2023-01-27T00:19:52.235606  =

    2023-01-27T00:19:52.337807  / # . /lava-3222060/environment/lava-322206=
0/bin/lava-test-runner /lava-3222060/1
    2023-01-27T00:19:52.339598  =

    2023-01-27T00:19:52.344387  / # /lava-3222060/bin/lava-test-runner /lav=
a-3222060/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
da850-lcdk                   | arm    | lab-baylibre    | gcc-10   | davinc=
i_all_defconfig        | 2          =


  Details:     https://kernelci.org/test/plan/id/63d316f600b1aa9a29915eb9

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: davinci_all_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm/davinci_all_defconfig/gcc-10/lab-bay=
libre/baseline-da850-lcdk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm/davinci_all_defconfig/gcc-10/lab-bay=
libre/baseline-da850-lcdk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d316f600b1aa9a29915ebe
        new failure (last pass: v4.19.269-cip88-rt28-rebase)

    2023-01-27T00:12:28.777451  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 3222019_1.5.=
2.4.1>
    2023-01-27T00:12:28.890649  / # #
    2023-01-27T00:12:28.994474  export SHELL=3D/bin/sh
    2023-01-27T00:12:28.994831  #
    2023-01-27T00:12:29.096075  / # export SHELL=3D/bin/sh. /lava-3222019/e=
nvironment
    2023-01-27T00:12:29.097060  =

    2023-01-27T00:12:29.199098  / # . /lava-3222019/environment/lava-322201=
9/bin/lava-test-runner /lava-3222019/1
    2023-01-27T00:12:29.200483  =

    2023-01-27T00:12:29.242147  / # /lava-3222019/bin/lava-test-runner /lav=
a-3222019/1
    2023-01-27T00:12:29.454267  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =


  * baseline.dmesg.alert: https://kernelci.org/test/case/id/63d316f600b1aa9=
a29915ec1
        new failure (last pass: v4.19.269-cip88-rt28-rebase)
        4 lines

    2023-01-27T00:12:28.550097  kern  :alert : BUG: Bad page state in proce=
ss swapper  pfn:c3000
    2023-01-27T00:12:28.550784  kern  :alert : BUG: Bad page state in proce=
ss swapper  pfn:c3400
    2023-01-27T00:12:28.551342  kern  :alert : BUG: Bad page state in proce=
ss swapper  pfn:c3800
    2023-01-27T00:12:28.553646  kern  :alert : BUG: Bad page state in proce=
ss swapper  pfn:c3c00
    2023-01-27T00:12:28.600544  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dale=
rt RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D4>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
da850-lcdk                   | arm    | lab-baylibre    | gcc-10   | multi_=
v5_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63d315f1b8cdc8d839915ef9

  Results:     3 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm/multi_v5_defconfig/gcc-10/lab-baylib=
re/baseline-da850-lcdk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm/multi_v5_defconfig/gcc-10/lab-baylib=
re/baseline-da850-lcdk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d315f1b8cdc8d839915efe
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc)

    2023-01-27T00:08:09.587898  + set +x
    2023-01-27T00:08:09.717660  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3De#
    2023-01-27T00:08:09.718235  merg RESULT=3Dpass UNITS=3Dlines MEASUREMEN=
T=3D0>
    2023-01-27T00:08:09.718369  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 3221946_1.5.=
2.4.1>
    2023-01-27T00:08:09.819651  / # #export SHELL=3D/bin/sh
    2023-01-27T00:08:09.820009  =

    2023-01-27T00:08:09.921166  / # export SHELL=3D/bin/sh. /lava-3221946/e=
nvironment
    2023-01-27T00:08:09.921558  =

    2023-01-27T00:08:10.022786  / # . /lava-3221946/environment/lava-322194=
6/bin/lava-test-runner /lava-3221946/1
    2023-01-27T00:08:10.023342   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls1088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63d318e128bec4483e915eb9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm64/defconfig/gcc-10/lab-nxp/baseline-=
fsl-ls1088a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm64/defconfig/gcc-10/lab-nxp/baseline-=
fsl-ls1088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d318e128bec4483e915ebc
        new failure (last pass: v4.19.269-cip88-rt28-rebase)

    2023-01-27T00:18:35.995576  / # [   13.254235] <LAVA_SIGNAL_ENDRUN 0_dm=
esg 1147064_1.5.2.4.1>
    2023-01-27T00:19:36.616638  #
    2023-01-27T00:19:36.619506  #
    2023-01-27T00:19:36.720733  / # export SHELL=3D/bin/sh
    2023-01-27T00:19:36.723724  export SHELL=3D/bin/sh
    2023-01-27T00:19:36.824935  / # . /lava-1147064/environment
    2023-01-27T00:19:36.828206  . /lava-1147064/environment
    2023-01-27T00:19:36.929289  / # /lava-1147064/bin/lava-test-runner /lav=
a-1147064/0
    2023-01-27T00:19:36.931935  /lava-1147064/bin/lava-test-runner /lava-11=
47064/0
    2023-01-27T00:19:36.947077  mv: can't rename '/lava-1147064/0/lava-test=
-runner.conf': No such file or directory =

    ... (23 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63d31aee927b3f963e915eba

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63d31aee927b3f963e915=
ebb
        new failure (last pass: v4.19.269-cip88-rt28-rebase) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63d319998d95f2467d915ede

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63d319998d95f2467d915=
edf
        new failure (last pass: v4.19.269-cip88-rt28-rebase) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63d31893b3bfc9378f915eb9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm/multi_v7_defconfig/gcc-10/lab-collab=
ora/baseline-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm/multi_v7_defconfig/gcc-10/lab-collab=
ora/baseline-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d31893b3bfc9378f915ebe
        failing since 8 days (last pass: v5.10.158-cip22-435-g2c52868ae1cbc=
, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-27T00:19:18.346387  / # #
    2023-01-27T00:19:18.448900  export SHELL=3D/bin/sh
    2023-01-27T00:19:18.449723  #
    2023-01-27T00:19:18.551785  / # export SHELL=3D/bin/sh. /lava-8893658/e=
nvironment
    2023-01-27T00:19:18.552659  =

    2023-01-27T00:19:18.655059  / # . /lava-8893658/environment/lava-889365=
8/bin/lava-test-runner /lava-8893658/1
    2023-01-27T00:19:18.656301  =

    2023-01-27T00:19:18.668391  / # /lava-8893658/bin/lava-test-runner /lav=
a-8893658/1
    2023-01-27T00:19:18.761194  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-27T00:19:18.761746  + cd /lava-8893658/1/tests/1_bootrr =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63d31b2b4ec094f3a5915eea

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63d31b2b4ec094f3a5915=
eeb
        new failure (last pass: v4.19.269-cip88-rt28-rebase) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63d319d7706d6c71fb915ed5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63d319d7706d6c71fb915=
ed6
        new failure (last pass: v4.19.269-cip88-rt28-rebase) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63d318cd8dbfb382b9915f0a

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm/imx_v6_v7_defconfig/gcc-10/lab-pengu=
tronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm/imx_v6_v7_defconfig/gcc-10/lab-pengu=
tronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d318cd8dbfb382b9915f0f
        failing since 8 days (last pass: v5.10.158-cip22-435-g2c52868ae1cbc=
, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-27T00:20:06.021636  + set +x
    2023-01-27T00:20:06.129908  / # #
    2023-01-27T00:20:06.231404  export SHELL=3D/bin/sh
    2023-01-27T00:20:06.231845  [   10.059347] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-01-27T00:20:06.231982  [   10.062396] <LAVA_SIGNAL_ENDRUN 0_dmesg =
888921_1.5.2.3.1>
    2023-01-27T00:20:06.232092  #
    2023-01-27T00:20:06.333236  / # export SHELL=3D/bin/sh. /lava-888921/en=
vironment
    2023-01-27T00:20:06.333693  =

    2023-01-27T00:20:06.435027  / # . /lava-888921/environment/lava-888921/=
bin/lava-test-runner /lava-888921/1
    2023-01-27T00:20:06.435744   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63d3187e7821595d2e915f06

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm/multi_v7_defconfig/gcc-10/lab-pengut=
ronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm/multi_v7_defconfig/gcc-10/lab-pengut=
ronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d3187e7821595d2e915f0b
        failing since 8 days (last pass: v5.10.158-cip22-435-g2c52868ae1cbc=
, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-27T00:18:46.493131  + set +x
    2023-01-27T00:18:46.599155  / # #
    2023-01-27T00:18:46.700788  export SHELL=3D/bin/sh
    2023-01-27T00:18:46.701267  [    7.128171] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-01-27T00:18:46.701420  [    7.129542] <LAVA_SIGNAL_ENDRUN 0_dmesg =
888918_1.5.2.3.1>
    2023-01-27T00:18:46.701537  #
    2023-01-27T00:18:46.802738  / # export SHELL=3D/bin/sh. /lava-888918/en=
vironment
    2023-01-27T00:18:46.803134  =

    2023-01-27T00:18:46.904312  / # . /lava-888918/environment/lava-888918/=
bin/lava-test-runner /lava-888918/1
    2023-01-27T00:18:46.904915   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 4          =


  Details:     https://kernelci.org/test/plan/id/63d319d0fb46909e45915eb9

  Results:     84 PASS, 6 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rk3399-gru-sound-driver-rt5514-present: https://kernelc=
i.org/test/case/id/63d319d0fb46909e45915eef
        failing since 8 days (last pass: v5.10.158-cip22-435-g2c52868ae1cbc=
, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-27T00:24:26.173759  Print num<8>[   30.586002] <LAVA_SIGNAL_TES=
TCASE TEST_CASE_ID=3Drk3399-gru-sound-driver-max98357A-present RESULT=3Dfai=
l>
    2023-01-27T00:24:26.177769  bers from FIRST to LAST, in steps of INC.
    2023-01-27T00:24:26.180187  FIRST, INC default to 1.
    2023-01-27T00:24:26.180476  =

    2023-01-27T00:24:26.180551  =

    2023-01-27T00:24:26.180799  =

    2023-01-27T00:24:26.184146  	-w	Pad to last with leading zeros   =


  * baseline.bootrr.rk3399-gru-sound-driver-max98357A-present: https://kern=
elci.org/test/case/id/63d319d0fb46909e45915ef0
        failing since 8 days (last pass: v5.10.158-cip22-435-g2c52868ae1cbc=
, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-27T00:24:26.150694  /lava-8893684/1/../bin/lava-tes<8>[   30.55=
7771] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Drk3399-gru-sound-driver-dp-prese=
nt RESULT=3Dfail>
    2023-01-27T00:24:26.151284  t-case
    2023-01-27T00:24:26.157267  BusyBox v1.31.1 (2023-01-20 17:48:38 UTC) m=
ulti-call binary.
    2023-01-27T00:24:26.157519  =

    2023-01-27T00:24:26.161875  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST
    2023-01-27T00:24:26.161951  =

    2023-01-27T00:24:26.162193     =


  * baseline.bootrr.rk3399-gru-sound-driver-dp-present: https://kernelci.or=
g/test/case/id/63d319d0fb46909e45915ef1
        failing since 8 days (last pass: v5.10.158-cip22-435-g2c52868ae1cbc=
, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-27T00:24:26.122083  Usage: seq [-w] [-s SEP] [FI<8>[   30.54116=
5] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Drk3399-gru-sound-driver-da7219-pres=
ent RESULT=3Dfail>
    2023-01-27T00:24:26.123453  RST [INC]] LAST
    2023-01-27T00:24:26.123705  =

    2023-01-27T00:24:26.123776  =

    2023-01-27T00:24:26.128601  Print numbers from FIRST to LAST, in steps =
of INC.
    2023-01-27T00:24:26.128854  =

    2023-01-27T00:24:26.131466  FIRST, INC default to 1.
    2023-01-27T00:24:26.131553  =

    2023-01-27T00:24:26.131807  =

    2023-01-27T00:24:26.135019  	-w	Pad to last with leading zeros =

    ... (1 line(s) more)  =


  * baseline.bootrr.rk3399-gru-sound-driver-da7219-present: https://kernelc=
i.org/test/case/id/63d319d0fb46909e45915ef2
        failing since 8 days (last pass: v5.10.158-cip22-435-g2c52868ae1cbc=
, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-27T00:24:26.099237  /la<8>[   30.532741] <LAVA_SIGNAL_TESTCASE =
TEST_CASE_ID=3Drk3399-gru-sound-driver-present RESULT=3Dpass>
    2023-01-27T00:24:26.102646  va-8893684/1/../bin/lava-test-case
    2023-01-27T00:24:26.108427  BusyBox v1.31.1 (2023-01-20 17:48:38 UTC) m=
ulti-call binary.
    2023-01-27T00:24:26.108691  =

    2023-01-27T00:24:26.108764  =

    2023-01-27T00:24:26.109012     =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63d3186e0d5273b1c7915ee8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63d3186e0d5273b1c7915=
ee9
        new failure (last pass: v4.19.269-cip88-rt28-rebase) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63d31896b3bfc9378f915ec4

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm/multi_v7_defconfig/gcc-10/lab-baylib=
re/baseline-sun8i-h3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm/multi_v7_defconfig/gcc-10/lab-baylib=
re/baseline-sun8i-h3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d31896b3bfc9378f915ec9
        failing since 8 days (last pass: v5.10.158-cip22-435-g2c52868ae1cbc=
, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-27T00:19:07.484943  + set +x
    2023-01-27T00:19:07.589058  / # #
    2023-01-27T00:19:07.690860  export SHELL=3D/bin/sh
    2023-01-27T00:19:07.691364  <8>[    8.333194] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-01-27T00:19:07.691614  <8>[    8.334622] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3222052_1.5.2.4.1>
    2023-01-27T00:19:07.691841  #
    2023-01-27T00:19:07.793120  / # export SHELL=3D/bin/sh. /lava-3222052/e=
nvironment
    2023-01-27T00:19:07.793508  =

    2023-01-27T00:19:07.894872  / # . /lava-3222052/environment/lava-322205=
2/bin/lava-test-runner /lava-3222052/1
    2023-01-27T00:19:07.895538   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63d317c39b7a0d4808915ec0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm64/defconfig/gcc-10/lab-cip/baseline-=
zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm64/defconfig/gcc-10/lab-cip/baseline-=
zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63d317c39b7a0d4808915=
ec1
        new failure (last pass: v4.19.269-cip88-rt28-rebase) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63d319cb19f4921e04915ed8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63d319cb19f4921e04915=
ed9
        new failure (last pass: v4.19.269-cip88-rt28-rebase) =

 =20

