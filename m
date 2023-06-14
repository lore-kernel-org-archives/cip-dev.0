Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0779EB64D8
	for <webhook@archiver.kernel.org>; Wed, 14 Jun 2023 13:20:55 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.web10.11508.1686748855149917878
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 14 Jun 2023 06:20:55 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=vEiM4/XX;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.173, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1b506a66882so2488285ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 14 Jun 2023 06:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686748854; x=1689340854;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BDHxbUKw3n1mR28mxRCX7T6L1oTztoCpbkb4fCot9Ys=;
        b=vEiM4/XX2+LgC74mtT4D3oN1E85uT7TvXFZweJiiUq1toI3/4j8bOe2WYv6CxbpxTH
         z/6fex0dX+vrVsp9nkQE7fJjAPMiGZmgtOUwEttsdXYlHpYMNlE6sRMpsRPcf4aRR095
         VivQ73EmCol2lGVPDgChg0iwJ2uhHbsZiw2AY975HCnPfraGom+q8QnsrU4tJghXkRbb
         JPQRVAsrm2Ym8RB3oXhz6NIaSHqInwp8E3wDAGbK3YBaZVqPv96pCxVgdip5HTSyzmjK
         EWoff9Ee2S2sYgo+ahmFcZzVM6tJDNBc5eGY+WjTUsaLKr5sOAS5hurI7tQvajQhjyPq
         xaaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686748854; x=1689340854;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BDHxbUKw3n1mR28mxRCX7T6L1oTztoCpbkb4fCot9Ys=;
        b=THfVRIR/HkwDs5q0/tAH682NIxuGiRcVTjPGQU2fLMx7ExakorP3G5MqdlCKZd54dn
         pRxcoF+0qpD4h9V7OTPUcIBFKYvHNLSboxx6riN0DDw3KHTqKEOCPXjxFKUcS/YXOiXo
         Dqs1BhGX4CBQrLPpdcIGx1vLEaW3LRG1uaYsLry8qfJSxglsr9rtrczq7n/7WAOos+qi
         8/HNRTRCUPITVLWWSMxxAgZ7uOHsUqYXKPm8PvsqsCFlFjiaHzh867VdMIwiUl04/cE3
         DVrGTRspVPPzQ66jmP4yjN9la5Ua0e+8oy5zi/NCVDW7jeOEaeBSUj5xWRdZj0sSvT0Q
         DA3Q==
X-Gm-Message-State: AC+VfDy/boUGQxt9D7D0kfc4K3DKAzI/SOWU34dYCAU67cTENRDh4/r1
	OglxreS7AVZcrRjWLF2TFIcfkURRSLaCVrYn2oxMIw==
X-Google-Smtp-Source: ACHHUZ4LLGLsJxyxVqVsrjNVGl00IFtKiT1nYbUJF6vjScNsOqVaXXMpMSLENFp9BdCOAZOCI3Tjjw==
X-Received: by 2002:a17:902:f816:b0:1b3:f3c7:89d4 with SMTP id ix22-20020a170902f81600b001b3f3c789d4mr2950813plb.12.1686748853500;
        Wed, 14 Jun 2023 06:20:53 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id k5-20020a170902ba8500b001ae5fe602c3sm12192035pls.159.2023.06.14.06.20.52
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 06:20:52 -0700 (PDT)
Message-ID: <6489beb4.170a0220.85f97.8173@mx.google.com>
Date: Wed, 14 Jun 2023 06:20:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.182-cip35-8-g2391124f19a70
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 34 runs,
 16 regressions (v5.10.182-cip35-8-g2391124f19a70)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Jun 2023 13:20:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12024

cip-gitlab/ci/pavel/linux-test baseline-nfs: 34 runs, 16 regressions (v5.10=
.182-cip35-8-g2391124f19a70)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

kontron-kbox-a-230-ls        | arm64  | lab-kontron   | gcc-10   | defconfi=
g                    | 3          =

kontron-sl28-var3-ads2       | arm64  | lab-kontron   | gcc-10   | defconfi=
g                    | 3          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

mt8173-elm-hana              | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.182-cip35-8-g2391124f19a70/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.182-cip35-8-g2391124f19a70
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      2391124f19a7085376080a6a95b6e45ff525076a =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6489b4f531da63363230612f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm/multi_v7_defconfig/gcc-10/lab-broonie=
/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm/multi_v7_defconfig/gcc-10/lab-broonie=
/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6489b4f531da63363=
2306130
        failing since 6 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6489b2d76b9d7bbddf306144

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm/omap2plus_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm/omap2plus_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6489b2d76b9d7bbddf30617a
        new failure (last pass: v4.19.283-cip98-1248-gcaf6e8ee921e9)

    2023-06-14T12:29:54.972726  [   47.729787] <LAVA_SIGNAL_ENDRUN 0_dmesg =
610423_1.6.2.4.1>
    2023-06-14T12:29:55.099374  / # #
    2023-06-14T12:29:55.202368  export SHELL=3D/bin/sh
    2023-06-14T12:29:55.202973  #
    2023-06-14T12:29:55.304739  / # export SHELL=3D/bin/sh. /lava-610423/en=
vironment
    2023-06-14T12:29:55.305364  =

    2023-06-14T12:29:55.406769  / # . /lava-610423/environment/lava-610423/=
bin/lava-test-runner /lava-610423/1
    2023-06-14T12:29:55.407720  =

    2023-06-14T12:29:55.411924  / # /lava-610423/bin/lava-test-runner /lava=
-610423/1
    2023-06-14T12:29:55.661400  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6489be365e0f53756b3061d2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm/omap2plus_defconfig/gcc-10/lab-cip/ba=
seline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm/omap2plus_defconfig/gcc-10/lab-cip/ba=
seline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6489be365e0f53756=
b3061d3
        new failure (last pass: v4.19.283-cip98-1248-gcaf6e8ee921e9) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6489b1fa53f5899c45306133

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6489b1fa53f5899c45306138
        new failure (last pass: v4.19.283-cip98-1248-gcaf6e8ee921e9)

    2023-06-14T12:26:14.481040  + set<8>[   20.235358] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10724449_1.5.2.3.1>

    2023-06-14T12:26:14.481132   +x

    2023-06-14T12:26:14.588814  / # #

    2023-06-14T12:26:14.689380  export SHELL=3D/bin/sh

    2023-06-14T12:26:14.689577  #

    2023-06-14T12:26:14.790069  / # export SHELL=3D/bin/sh. /lava-10724449/=
environment

    2023-06-14T12:26:14.790290  =


    2023-06-14T12:26:14.890834  / # . /lava-10724449/environment/lava-10724=
449/bin/lava-test-runner /lava-10724449/1

    2023-06-14T12:26:14.891184  =


    2023-06-14T12:26:14.896006  / # /lava-10724449/bin/lava-test-runner /la=
va-10724449/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6489b1424fa50f93fd30614e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6489b1424fa50f93fd306153
        new failure (last pass: v4.19.283-cip98-1248-gcaf6e8ee921e9)

    2023-06-14T12:23:21.688579  + set[   19.776804] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10724390_1.5.2.3.1>

    2023-06-14T12:23:21.688666   +x

    2023-06-14T12:23:21.792726  / # #

    2023-06-14T12:23:21.893405  export SHELL=3D/bin/sh

    2023-06-14T12:23:21.893602  #

    2023-06-14T12:23:21.994105  / # export SHELL=3D/bin/sh. /lava-10724390/=
environment

    2023-06-14T12:23:21.994332  =


    2023-06-14T12:23:22.094872  / # . /lava-10724390/environment/lava-10724=
390/bin/lava-test-runner /lava-10724390/1

    2023-06-14T12:23:22.095150  =


    2023-06-14T12:23:22.100604  / # /lava-10724390/bin/lava-test-runner /la=
va-10724390/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
kontron-kbox-a-230-ls        | arm64  | lab-kontron   | gcc-10   | defconfi=
g                    | 3          =


  Details:     https://kernelci.org/test/plan/id/6489b8f900bbf9d7c93061b3

  Results:     89 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm64/defconfig/gcc-10/lab-kontron/baseli=
ne-nfs-kontron-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm64/defconfig/gcc-10/lab-kontron/baseli=
ne-nfs-kontron-kbox-a-230-ls.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rcpm-driver-present: https://kernelci.org/test/case=
/id/6489b8f900bbf9d7c93061f3
        new failure (last pass: v6.1.26-1314-g1ab0ac1d7e2e3)

    2023-06-14T12:56:04.732769  /lava-357148/1/../bin/lava-test-case
    2023-06-14T12:56:04.758654  [   19.596144] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drcpm-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.ftm-alarm-driver-present: https://kernelci.org/test=
/case/id/6489b8f900bbf9d7c93061f4
        new failure (last pass: v6.1.26-1314-g1ab0ac1d7e2e3)

    2023-06-14T12:56:05.766188  /lava-357148/1/../bin/lava-test-case
    2023-06-14T12:56:05.789098  [   20.626106] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2023-06-14T12:56:06.796729  /lava-357148/1/../bin/lava-test-case
    2023-06-14T12:56:06.820679  [   21.657744] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dftm-alarm-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.layerscape-sfp-driver-present: https://kernelci.org=
/test/case/id/6489b8f900bbf9d7c930620b
        new failure (last pass: v6.1.26-1314-g1ab0ac1d7e2e3)

    2023-06-14T12:56:09.610753  /lava-357148/1/../bin/lava-test-case
    2023-06-14T12:56:09.634714  [   24.471762] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
kontron-sl28-var3-ads2       | arm64  | lab-kontron   | gcc-10   | defconfi=
g                    | 3          =


  Details:     https://kernelci.org/test/plan/id/6489b8e500bbf9d7c9306145

  Results:     97 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm64/defconfig/gcc-10/lab-kontron/baseli=
ne-nfs-kontron-sl28-var3-ads2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm64/defconfig/gcc-10/lab-kontron/baseli=
ne-nfs-kontron-sl28-var3-ads2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rcpm-driver-present: https://kernelci.org/test/case=
/id/6489b8e500bbf9d7c930618c
        new failure (last pass: v6.1.26-1314-g1ab0ac1d7e2e3)

    2023-06-14T12:55:52.377513  /lava-357149/1/../bin/lava-test-case
    2023-06-14T12:55:52.402446  [   16.043844] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drcpm-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.ftm-alarm-driver-present: https://kernelci.org/test=
/case/id/6489b8e500bbf9d7c930618d
        new failure (last pass: v6.1.26-1314-g1ab0ac1d7e2e3)

    2023-06-14T12:55:53.410308  /lava-357149/1/../bin/lava-test-case
    2023-06-14T12:55:53.436140  [   17.077110] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2023-06-14T12:55:54.442941  /lava-357149/1/../bin/lava-test-case
    2023-06-14T12:55:54.472520  [   18.113533] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dftm-alarm-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.layerscape-sfp-driver-present: https://kernelci.org=
/test/case/id/6489b8e500bbf9d7c93061a2
        new failure (last pass: v6.1.26-1314-g1ab0ac1d7e2e3)

    2023-06-14T12:55:57.314668  /lava-357149/1/../bin/lava-test-case
    2023-06-14T12:55:57.317800  [   20.960098] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6489b7ee01476f215d306156

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6489b7ee01476f215=
d306157
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6489b9672b3aa3ea42306145

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm64/defconfig/gcc-10/lab-broonie/baseli=
ne-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm64/defconfig/gcc-10/lab-broonie/baseli=
ne-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6489b9672b3aa3ea4=
2306146
        new failure (last pass: v6.1.26-1314-g1ab0ac1d7e2e3) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6489b5eeaca2e7c9c3306147

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/baseline-nfs-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/baseline-nfs-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6489b5eeaca2e7c9c=
3306148
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6489b6f872456a1b0d306194

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/6489b6f872456a1b0d30619a
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-14T12:47:59.884079  /lava-10724953/1/../bin/lava-test-case

    2023-06-14T12:47:59.923801  <8>[   38.920491] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/6489b6f872456a1b0d30619b
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-14T12:47:58.780048  /lava-10724953/1/../bin/lava-test-case

    2023-06-14T12:47:58.820836  <8>[   37.817368] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =20

