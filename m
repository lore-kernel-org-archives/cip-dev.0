Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A43C77B7A
	for <webhook@archiver.kernel.org>; Mon, 29 May 2023 07:36:42 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web11.44899.1685345797524724377
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 29 May 2023 00:36:37 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=G01jRJHS;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.182, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1b0201d9a9eso14683975ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 29 May 2023 00:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685345796; x=1687937796;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VIBCFem2AuiMm3HXOJfsBIAI4LarsZlufXrsOozcBoI=;
        b=G01jRJHSQfEtOVFBKRps5NV/7yzzdTpojW1n8aIFKSTEB3WxXZSnn6duPOBo/Uxu9m
         r1OOp0nhHKYW/lT+lN9yl3S+chNqtevI29bB9NHcvrhxzhU5DHvMU+BhBkdXT0iddrN7
         8wX5T/jSFlF/+C6FAAS3Xm8LDwT/38aC6foqZIiPW6JM7oWdW1JN+EEkf+lQeM1FhzaM
         JZz7FmvF/Q/eHWjgVfb1YFeNv5vLgWpquekd3R52UC7nFriHJZMf8zsmlG37YpuZwC3e
         KUDjDGU6xQPYCdS54+dyGJKQYn5REXYsp9XxUN6dhAqT3/zoLSOnhsa14ZI5TcHgDq+i
         nwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685345796; x=1687937796;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VIBCFem2AuiMm3HXOJfsBIAI4LarsZlufXrsOozcBoI=;
        b=ED/7YWHk1MdUuRwnVXFawL/bqm+E5M9olXyb70JcSdP2+F2Ho/4vju7mot9nq3dT0c
         vIoZ4b/1fyegL6NiZh5jmUX4jhqSmOKCEShsNFltCddf9uPA5mUClRDvHqykv2pCUVev
         X/4fUG6QJRcfz7jNz96u8Dvosrsxs/4E8x+W/ambSKrkWtakH7Q0NimXfEARAZe1jffw
         lWO4pXwk04d4dqi7x/2aYQy+aC/qMg5X1FpyizNc5IbSPAGnuOuSxPVrKVcgo4TpV3Rf
         acSJgb9WQ9JJuLGTZz5i1EkbNAdNB6f6zk6xLaZadGtjWk4rORXZnsyyaefkhco51tGR
         H9Xg==
X-Gm-Message-State: AC+VfDzVgg/wjo6goBgoJ/mp554T4GEx/HVCCWs2HJh8VJ57BHi2tZQF
	xx8AgdMgHMm5evtquLyC2VFlbxCxMRtm2lJEEO9rkg==
X-Google-Smtp-Source: ACHHUZ52ZRXKMfDSpOGpHixbzLUSxDMViKGVZIcRBOxHNdGNqECtEWpOOcIavuNEpzX35D1mB9QhUQ==
X-Received: by 2002:a17:902:e54b:b0:1af:ee04:5ca6 with SMTP id n11-20020a170902e54b00b001afee045ca6mr8234546plf.33.1685345795890;
        Mon, 29 May 2023 00:36:35 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902b60400b001a6f7744a27sm7520180pls.87.2023.05.29.00.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 00:36:35 -0700 (PDT)
Message-ID: <64745603.170a0220.8fb29.dfa6@mx.google.com>
Date: Mon, 29 May 2023 00:36:35 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.180-cip34
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip baseline: 133 runs,
 23 regressions (v5.10.180-cip34)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 May 2023 07:36:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11684

cip/linux-5.10.y-cip baseline: 133 runs, 23 regressions (v5.10.180-cip34)

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

fsl-ls1088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
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

rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 4          =

rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.180-cip34/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.180-cip34
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      aa80091745d6b40c944d419c12ba8cb65b1a57a5 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64744ce2b5d2d5520b2e85e7

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64744ce2b5d2d5520b2e85ec
        failing since 135 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-29T06:57:13.521905  <8>[   11.383467] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10505854_1.4.2.3.1>

    2023-05-29T06:57:13.525319  + set +x

    2023-05-29T06:57:13.626465  /#

    2023-05-29T06:57:13.727351   # #export SHELL=3D/bin/sh

    2023-05-29T06:57:13.727594  =


    2023-05-29T06:57:13.828152  / # export SHELL=3D/bin/sh. /lava-10505854/=
environment

    2023-05-29T06:57:13.828400  =


    2023-05-29T06:57:13.928979  / # . /lava-10505854/environment/lava-10505=
854/bin/lava-test-runner /lava-10505854/1

    2023-05-29T06:57:13.929393  =


    2023-05-29T06:57:13.934926  / # /lava-10505854/bin/lava-test-runner /la=
va-10505854/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64744cddf6f8feac512e862e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64744cddf6f8feac512e8633
        failing since 135 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-29T06:57:23.069165  <8>[   11.998413] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-05-29T06:57:23.069595  + set +x

    2023-05-29T06:57:23.078731  <8>[   12.009193] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10505823_1.4.2.3.1>

    2023-05-29T06:57:23.183971  / # #

    2023-05-29T06:57:23.284925  export SHELL=3D/bin/sh

    2023-05-29T06:57:23.285808  #

    2023-05-29T06:57:23.387348  / # export SHELL=3D/bin/sh. /lava-10505823/=
environment

    2023-05-29T06:57:23.388105  =


    2023-05-29T06:57:23.489613  / # . /lava-10505823/environment/lava-10505=
823/bin/lava-test-runner /lava-10505823/1

    2023-05-29T06:57:23.490754  =

 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64744bff504c1b00f82e8628

  Results:     47 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64744bff504c1b00f82e8654
        failing since 135 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-29T06:53:17.649430  + set +x
    2023-05-29T06:53:17.654609  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 530076_1.5.2=
.4.1>
    2023-05-29T06:53:17.768574  / # #
    2023-05-29T06:53:17.871394  export SHELL=3D/bin/sh
    2023-05-29T06:53:17.872175  #
    2023-05-29T06:53:17.974076  / # export SHELL=3D/bin/sh. /lava-530076/en=
vironment
    2023-05-29T06:53:17.974914  =

    2023-05-29T06:53:18.076971  / # . /lava-530076/environment/lava-530076/=
bin/lava-test-runner /lava-530076/1
    2023-05-29T06:53:18.078290  =

    2023-05-29T06:53:18.084713  / # /lava-530076/bin/lava-test-runner /lava=
-530076/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64744e850b9dd8d7ee2e8655

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64744e850b9dd8d7ee2e8682
        failing since 135 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-29T07:03:58.725382  <8>[   21.378233] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 530145_1.5.2.4.1>
    2023-05-29T07:03:58.834042  / # #
    2023-05-29T07:03:58.936187  export SHELL=3D/bin/sh
    2023-05-29T07:03:58.936794  #
    2023-05-29T07:03:59.038616  / # export SHELL=3D/bin/sh. /lava-530145/en=
vironment
    2023-05-29T07:03:59.039572  =

    2023-05-29T07:03:59.141440  / # . /lava-530145/environment/lava-530145/=
bin/lava-test-runner /lava-530145/1
    2023-05-29T07:03:59.142260  =

    2023-05-29T07:03:59.147130  / # /lava-530145/bin/lava-test-runner /lava=
-530145/1
    2023-05-29T07:03:59.242080  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647453690fdaa19b852e85e6

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647453690fdaa19b852e85e9
        failing since 135 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-29T07:24:40.784929  <8>[   15.669287] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 946375_1.5.2.4.1>
    2023-05-29T07:24:40.893523  / # #
    2023-05-29T07:24:40.995987  export SHELL=3D/bin/sh
    2023-05-29T07:24:40.996690  #
    2023-05-29T07:24:41.098526  / # export SHELL=3D/bin/sh. /lava-946375/en=
vironment
    2023-05-29T07:24:41.099262  =

    2023-05-29T07:24:41.201099  / # . /lava-946375/environment/lava-946375/=
bin/lava-test-runner /lava-946375/1
    2023-05-29T07:24:41.202252  =

    2023-05-29T07:24:41.209227  / # /lava-946375/bin/lava-test-runner /lava=
-946375/1
    2023-05-29T07:24:41.303369  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64744d19bf4048d78e2e861f

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64744d19bf4048d78e2e8655
        failing since 135 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-29T06:58:15.398785  <8>[   20.409427] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 530100_1.5.2.4.1>
    2023-05-29T06:58:15.511128  / # #
    2023-05-29T06:58:15.614557  export SHELL=3D/bin/sh
    2023-05-29T06:58:15.615503  #
    2023-05-29T06:58:15.717644  / # export SHELL=3D/bin/sh. /lava-530100/en=
vironment
    2023-05-29T06:58:15.718597  =

    2023-05-29T06:58:15.820836  / # . /lava-530100/environment/lava-530100/=
bin/lava-test-runner /lava-530100/1
    2023-05-29T06:58:15.822400  =

    2023-05-29T06:58:15.825680  / # /lava-530100/bin/lava-test-runner /lava=
-530100/1
    2023-05-29T06:58:15.934383  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64744d247b1d3c21352e85ec

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64744d247b1d3c21352e85ef
        failing since 135 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-29T06:58:19.657283  / # #
    2023-05-29T06:58:19.760560  export SHELL=3D/bin/sh
    2023-05-29T06:58:19.761646  #
    2023-05-29T06:58:19.864018  / # export SHELL=3D/bin/sh. /lava-946354/en=
vironment
    2023-05-29T06:58:19.865080  =

    2023-05-29T06:58:19.969281  / # . /lava-946354/environment/lava-946354/=
bin/lava-test-runner /lava-946354/1
    2023-05-29T06:58:19.970933  =

    2023-05-29T06:58:19.980197  / # /lava-946354/bin/lava-test-runner /lava=
-946354/1
    2023-05-29T06:58:20.119790  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-29T06:58:20.120383  + cd /lava-946354/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls1088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64744ec0061ced1b142e85f4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1088a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64744ec0061ced1b142e85f7
        failing since 135 days (last pass: v5.10.155-cip21, first fail: v5.=
10.162-cip24)

    2023-05-29T07:05:27.614347  + set +x
    2023-05-29T07:05:27.616149  [   14.278609] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1230324_1.5.2.4.1>
    2023-05-29T07:05:27.724206  / # #
    2023-05-29T07:05:27.826251  export SHELL=3D/bin/sh
    2023-05-29T07:05:27.826698  #
    2023-05-29T07:05:27.928143  / # export SHELL=3D/bin/sh. /lava-1230324/e=
nvironment
    2023-05-29T07:05:27.928587  =

    2023-05-29T07:05:28.029947  / # . /lava-1230324/environment/lava-123032=
4/bin/lava-test-runner /lava-1230324/1
    2023-05-29T07:05:28.030676  =

    2023-05-29T07:05:28.032432  / # /lava-1230324/bin/lava-test-runner /lav=
a-1230324/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64744cdbf6f8feac512e8621

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64744cdbf6f8feac512e8624
        failing since 44 days (last pass: v5.10.176-cip30, first fail: v5.1=
0.177-cip31)

    2023-05-29T06:57:23.482343  + set +x

    2023-05-29T06:57:23.489311  <8>[   10.288130] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10505856_1.4.2.3.1>

    2023-05-29T06:57:23.593728  / # #

    2023-05-29T06:57:23.694451  export SHELL=3D/bin/sh

    2023-05-29T06:57:23.694656  #

    2023-05-29T06:57:23.795213  / # export SHELL=3D/bin/sh. /lava-10505856/=
environment

    2023-05-29T06:57:23.795451  =


    2023-05-29T06:57:23.895985  / # . /lava-10505856/environment/lava-10505=
856/bin/lava-test-runner /lava-10505856/1

    2023-05-29T06:57:23.896356  =


    2023-05-29T06:57:23.901379  / # /lava-10505856/bin/lava-test-runner /la=
va-10505856/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64744cd7f6f8feac512e8606

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64744cd7f6f8feac512e860b
        failing since 44 days (last pass: v5.10.176-cip30, first fail: v5.1=
0.177-cip31)

    2023-05-29T06:57:08.245228  <8>[   13.224775] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10505838_1.4.2.3.1>

    2023-05-29T06:57:08.248832  + set +x

    2023-05-29T06:57:08.350050  #

    2023-05-29T06:57:08.350307  =


    2023-05-29T06:57:08.450852  / # #export SHELL=3D/bin/sh

    2023-05-29T06:57:08.451066  =


    2023-05-29T06:57:08.551607  / # export SHELL=3D/bin/sh. /lava-10505838/=
environment

    2023-05-29T06:57:08.551819  =


    2023-05-29T06:57:08.652370  / # . /lava-10505838/environment/lava-10505=
838/bin/lava-test-runner /lava-10505838/1

    2023-05-29T06:57:08.652645  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64744e4f27a85165ff2e85f3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64744e4f27a85165ff2e85f8
        failing since 135 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-29T07:03:35.490786  / # #

    2023-05-29T07:03:35.593386  export SHELL=3D/bin/sh

    2023-05-29T07:03:35.594149  #

    2023-05-29T07:03:35.695643  / # export SHELL=3D/bin/sh. /lava-10505952/=
environment

    2023-05-29T07:03:35.696392  =


    2023-05-29T07:03:35.798062  / # . /lava-10505952/environment/lava-10505=
952/bin/lava-test-runner /lava-10505952/1

    2023-05-29T07:03:35.799201  =


    2023-05-29T07:03:35.813850  / # /lava-10505952/bin/lava-test-runner /la=
va-10505952/1

    2023-05-29T07:03:35.919737  + export 'TESTRUN_ID=3D1_bootrr'

    2023-05-29T07:03:35.920275  + cd /lava-10505952/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64744dd4f8f8949a582e8616

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandb=
oard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandb=
oard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64744dd4f8f8949a582e861b
        failing since 135 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-29T07:01:33.124618  + set +x
    2023-05-29T07:01:33.124794  [   10.243152] <LAVA_SIGNAL_ENDRUN 0_dmesg =
962032_1.5.2.3.1>
    2023-05-29T07:01:33.232382  / # #
    2023-05-29T07:01:33.334110  export SHELL=3D/bin/sh
    2023-05-29T07:01:33.334546  #
    2023-05-29T07:01:33.435765  / # export SHELL=3D/bin/sh. /lava-962032/en=
vironment
    2023-05-29T07:01:33.436265  =

    2023-05-29T07:01:33.537614  / # . /lava-962032/environment/lava-962032/=
bin/lava-test-runner /lava-962032/1
    2023-05-29T07:01:33.538246  =

    2023-05-29T07:01:33.540959  / # /lava-962032/bin/lava-test-runner /lava=
-962032/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64744e3e61d83b50e72e85f6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandbo=
ard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandbo=
ard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64744e3e61d83b50e72e85fb
        failing since 135 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-29T07:02:52.566849  + set[    7.230701] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 962035_1.5.2.3.1>
    2023-05-29T07:02:52.567034   +x
    2023-05-29T07:02:52.672751  / # #
    2023-05-29T07:02:52.774546  export SHELL=3D/bin/sh
    2023-05-29T07:02:52.775035  #
    2023-05-29T07:02:52.876363  / # export SHELL=3D/bin/sh. /lava-962035/en=
vironment
    2023-05-29T07:02:52.876853  =

    2023-05-29T07:02:52.978221  / # . /lava-962035/environment/lava-962035/=
bin/lava-test-runner /lava-962035/1
    2023-05-29T07:02:52.978946  =

    2023-05-29T07:02:52.981092  / # /lava-962035/bin/lava-test-runner /lava=
-962035/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64744f2f57db5161572e8661

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64744f2f57db5161572e8664
        failing since 135 days (last pass: v5.10.155-cip21, first fail: v5.=
10.162-cip24)

    2023-05-29T07:07:01.282452  <8>[   17.180552] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1230322_1.5.2.4.1>
    2023-05-29T07:07:01.386550  / # #
    2023-05-29T07:07:02.544857  export SHELL=3D/bin/sh
    2023-05-29T07:07:02.550519  #
    2023-05-29T07:07:04.096794  / # export SHELL=3D/bin/sh. /lava-1230322/e=
nvironment
    2023-05-29T07:07:04.102487  =

    2023-05-29T07:07:06.923423  / # . /lava-1230322/environment/lava-123032=
2/bin/lava-test-runner /lava-1230322/1
    2023-05-29T07:07:06.929483  =

    2023-05-29T07:07:06.941151  / # /lava-1230322/bin/lava-test-runner /lav=
a-1230322/1
    2023-05-29T07:07:07.029524  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (19 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7ulp-evk                  | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64744ffdc5a419ba032e85e6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7ulp-evk.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7ulp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64744ffdc5a419ba032e85e9
        failing since 76 days (last pass: v5.10.155-cip21, first fail: v5.1=
0.173-cip28)

    2023-05-29T07:09:05.457996  + set +x<8>[   28.966455] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 1230323_1.5.2.4.1>
    2023-05-29T07:09:05.458131  =

    2023-05-29T07:09:05.566079  / # #
    2023-05-29T07:09:06.726064  export SHELL=3D/bin/sh
    2023-05-29T07:09:06.731735  #
    2023-05-29T07:09:06.732056  / # export SHELL=3D/bin/sh
    2023-05-29T07:09:08.278432  / # . /lava-1230323/environment
    2023-05-29T07:09:11.104659  /lava-1230323/bin/lava-test-runner /lava-12=
30323/1
    2023-05-29T07:09:11.110764  . /lava-1230323/environment
    2023-05-29T07:09:11.111114  / # /lava-1230323/bin/lava-test-runner /lav=
a-1230323/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64744ee51e2ddb28442e8696

  Results:     28 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt817=
3-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt817=
3-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64744ee51e2ddb28442e86b2
        failing since 135 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-29T07:05:59.366272  <8>[   15.632982] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-05-29T07:05:59.367767  + set +x

    2023-05-29T07:05:59.374399  <8>[   15.642586] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10505997_1.5.2.3.1>

    2023-05-29T07:05:59.478741  #

    2023-05-29T07:05:59.479104  =


    2023-05-29T07:05:59.579842  / # #export SHELL=3D/bin/sh

    2023-05-29T07:05:59.580087  =


    2023-05-29T07:05:59.680714  / # export SHELL=3D/bin/sh. /lava-10505997/=
environment

    2023-05-29T07:05:59.680961  =


    2023-05-29T07:05:59.781592  / # . /lava-10505997/environment/lava-10505=
997/bin/lava-test-runner /lava-10505997/1
 =

    ... (18 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 4          =


  Details:     https://kernelci.org/test/plan/id/64744e5948d19f424b2e863c

  Results:     63 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-j=
aq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-j=
aq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64744e5948d19f424b2e8640
        failing since 133 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-29T07:03:15.490676  <8>[    6.740973] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-05-29T07:03:15.500594  + <8>[    6.753516] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10505944_1.5.2.3.1>

    2023-05-29T07:03:15.500866  set +x

    2023-05-29T07:03:15.607320  =


    2023-05-29T07:03:15.708904  / # #export SHELL=3D/bin/sh

    2023-05-29T07:03:15.709631  =


    2023-05-29T07:03:15.810934  / # export SHELL=3D/bin/sh. /lava-10505944/=
environment

    2023-05-29T07:03:15.811635  =


    2023-05-29T07:03:15.913056  / # . /lava-10505944/environment/lava-10505=
944/bin/lava-test-runner /lava-10505944/1

    2023-05-29T07:03:15.913455  =

 =

    ... (18 line(s) more)  =


  * baseline.bootrr.dwhdmi-rockchip-driver-i2c-present: https://kernelci.or=
g/test/case/id/64744e5948d19f424b2e866d
        failing since 133 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-29T07:03:27.595086  FIRST,<8>[   18.839313] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>

    2023-05-29T07:03:27.598556   INC default to 1.

    2023-05-29T07:03:27.598952  =


    2023-05-29T07:03:27.602279  	-w	Pad to last with leading zeros

    2023-05-29T07:03:27.604796  	-s SEP	String separator

    2023-05-29T07:03:27.609009  /lava-10505944/1/../bin/lava-test-case

    2023-05-29T07:03:27.615651  BusyBox v1.31.1 (2023-05-19 20:50:34 UTC) m=
ulti-call binary.

    2023-05-29T07:03:27.615711  =

   =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/64744e5948d19f424b2e866e
        failing since 133 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-29T07:03:27.570945  BusyBox v1.31.1 (2023-05-19 20:50:34 UTC)<8=
>[   18.820201] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-05-29T07:03:27.574547   multi-call binary.

    2023-05-29T07:03:27.575036  =


    2023-05-29T07:03:27.579172  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-05-29T07:03:27.579394  =


    2023-05-29T07:03:27.584364  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/64744e5948d19f424b2e866f
        failing since 133 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-29T07:03:27.551964  <8>[   18.802331] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>
   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64744ef918adaa992d2e85e6

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk339=
9-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk339=
9-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/64744ef918adaa992d2e85ec
        failing since 67 days (last pass: v5.10.173-cip28, first fail: v5.1=
0.175-cip29)

    2023-05-29T07:06:11.783558  /lava-10506007/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/64744ef918adaa992d2e85ed
        failing since 67 days (last pass: v5.10.173-cip28, first fail: v5.1=
0.175-cip29)

    2023-05-29T07:06:09.722051  <8>[   31.467855] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-05-29T07:06:10.748504  /lava-10506007/1/../bin/lava-test-case

    2023-05-29T07:06:10.759163  <8>[   32.506082] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64744ea227a85165ff2e8611

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64744ea227a85165ff2e863d
        failing since 135 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-29T07:04:40.208321  + set +x
    2023-05-29T07:04:40.212244  <8>[   17.058853] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 530179_1.5.2.4.1>
    2023-05-29T07:04:40.323426  / # #
    2023-05-29T07:04:40.426116  export SHELL=3D/bin/sh
    2023-05-29T07:04:40.426834  #
    2023-05-29T07:04:40.529187  / # export SHELL=3D/bin/sh. /lava-530179/en=
vironment
    2023-05-29T07:04:40.529904  =

    2023-05-29T07:04:40.632020  / # . /lava-530179/environment/lava-530179/=
bin/lava-test-runner /lava-530179/1
    2023-05-29T07:04:40.633155  =

    2023-05-29T07:04:40.637418  / # /lava-530179/bin/lava-test-runner /lava=
-530179/1 =

    ... (12 line(s) more)  =

 =20

