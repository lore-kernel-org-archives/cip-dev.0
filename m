Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C659C7EE26
	for <webhook@archiver.kernel.org>; Fri, 19 May 2023 14:42:09 +0000 (UTC)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
 by mx.groups.io with SMTP id smtpd.web11.28102.1684507324027766866
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 19 May 2023 07:42:04 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=B9mx7GKk;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.170, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-51b0f9d7d70so3066439a12.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 19 May 2023 07:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684507323; x=1687099323;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yI2DPz38HwGYFIJDsEEpDbe/ubFNir6xEjYw02NFtZY=;
        b=B9mx7GKkqtZavJYwGiDFEMxmagmel7WZEbRpqeYzrHWDAdN2ijiEbI43ie2aAzYrvW
         Obe670pSeMkCLVQgQlFG55RikSQdytVEf7px5ybrf1+4WDNeLPVkTC0JIc/gwis3Ygd1
         xN6sb7RMbdZ3wHNEaemhbCjqwScTWgAIJxHyO9eGRbOeVkdrqNzFjS02shoBDhMo+R+s
         EqtpH5aCyGjpoHsIdHO/0CS1jGW7mQHsB+hKnVvevHTYe24Lv5ZZ0SL79kcgVeTmsuh8
         3neB9mGl6lu7vaX7QSYMNMkJIAE/IBkHIJQMZ2hSQTDYuZ8GL2UxWMfrtd1LXRbEZ2oZ
         nkNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684507323; x=1687099323;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yI2DPz38HwGYFIJDsEEpDbe/ubFNir6xEjYw02NFtZY=;
        b=YMDgrsbe9pR+6JpXWTxtn7Qxfy/jgAXPbpaS/5stYSNT8ICvxtwYt3XF6gY4JJaCcg
         fIvwUTFAK1wgKshvbbbW+lN4H8ARpctSiP00+VPWK9+w5YQuRDd9IwQVDFSa5fgDlmvO
         7n6Qi0TwVkx67zlSkuiaV3oxY+Ydarpr7ag031Fbfl+0Z1XIwaEJ4PJIkOMl6+QvpAuz
         guEfzKf+Sw/GXIV9aFFkrION4Mbl9nI/wp1I/0JxDjtCujf/Cdvg9A1nSjU8uenBD/Gf
         1gYlT6D1ihByFqFJBxZODrv8ty3Okxmepm+sgWFQfF98oQzrtsJBpAVqssBzv9pa0ZjD
         2jhg==
X-Gm-Message-State: AC+VfDz6ltUKBEletOd+y2JCSRawb+cE4iHcubGOY5oUMluqRBZ0PlZt
	tH3mw9Lv5wfm2dMK4ZcHZ/+GH8w9lCa/5XriSXN2SQ==
X-Google-Smtp-Source: ACHHUZ5bNprlk/WfylYioeDYHJNn++hIzBQOe74NnxrZx6lSlD0RnZB5kPKNQzv4JX52x6u5GUcN8g==
X-Received: by 2002:a17:902:e750:b0:1ac:8e0b:281c with SMTP id p16-20020a170902e75000b001ac8e0b281cmr3185619plf.57.1684507322448;
        Fri, 19 May 2023 07:42:02 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k2-20020a170902e90200b001ae12378732sm3513282pld.300.2023.05.19.07.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 07:42:01 -0700 (PDT)
Message-ID: <64678ab9.170a0220.15983.67f2@mx.google.com>
Date: Fri, 19 May 2023 07:42:01 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.180-cip33
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip baseline: 118 runs,
 21 regressions (v5.10.180-cip33)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 May 2023 14:42:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11559

cip/linux-5.10.y-cip baseline: 118 runs, 21 regressions (v5.10.180-cip33)

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

fsl-ls1028a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

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


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.180-cip33/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.180-cip33
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      7f6b02104eb287caf662ade9a67f11896ab01fde =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64678088a63756f22f2e8606

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64678088a63756f22f2e860b
        failing since 125 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-19T13:58:25.659370  + set +x

    2023-05-19T13:58:25.666114  <8>[   12.187884] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10389262_1.4.2.3.1>

    2023-05-19T13:58:25.767904  =


    2023-05-19T13:58:25.868523  / # #export SHELL=3D/bin/sh

    2023-05-19T13:58:25.868695  =


    2023-05-19T13:58:25.969237  / # export SHELL=3D/bin/sh. /lava-10389262/=
environment

    2023-05-19T13:58:25.969424  =


    2023-05-19T13:58:26.069933  / # . /lava-10389262/environment/lava-10389=
262/bin/lava-test-runner /lava-10389262/1

    2023-05-19T13:58:26.070214  =


    2023-05-19T13:58:26.070284  / # <4>[   12.527233] i2c_designware i2c_de=
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


  Details:     https://kernelci.org/test/plan/id/64678073f7736678e02e8626

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64678073f7736678e02e862b
        failing since 125 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-19T13:57:54.167551  + set +x

    2023-05-19T13:57:54.173648  <8>[   11.947523] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10389286_1.4.2.3.1>

    2023-05-19T13:57:54.278615  / # #

    2023-05-19T13:57:54.379179  export SHELL=3D/bin/sh

    2023-05-19T13:57:54.379399  #

    2023-05-19T13:57:54.479960  / # export SHELL=3D/bin/sh. /lava-10389286/=
environment

    2023-05-19T13:57:54.480191  =


    2023-05-19T13:57:54.580773  / # . /lava-10389286/environment/lava-10389=
286/bin/lava-test-runner /lava-10389286/1

    2023-05-19T13:57:54.581042  =


    2023-05-19T13:57:54.585742  / # /lava-10389286/bin/lava-test-runner /la=
va-10389286/1
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/646783385de80dd8d72e8632

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646783385de80dd8d72e865f
        failing since 125 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-19T14:09:23.439732  <8>[   18.936372] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 485627_1.5.2.4.1>
    2023-05-19T14:09:23.550253  / # #
    2023-05-19T14:09:23.653252  export SHELL=3D/bin/sh
    2023-05-19T14:09:23.654116  #
    2023-05-19T14:09:23.756196  / # export SHELL=3D/bin/sh. /lava-485627/en=
vironment
    2023-05-19T14:09:23.757104  =

    2023-05-19T14:09:23.859335  / # . /lava-485627/environment/lava-485627/=
bin/lava-test-runner /lava-485627/1
    2023-05-19T14:09:23.860795  =

    2023-05-19T14:09:23.865314  / # /lava-485627/bin/lava-test-runner /lava=
-485627/1
    2023-05-19T14:09:23.961873  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64678284750874e70d2e85f3

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64678284750874e70d2e8629
        failing since 125 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-19T14:06:37.919839  <8>[   15.978462] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 485567_1.5.2.4.1>
    2023-05-19T14:06:38.031337  / # #
    2023-05-19T14:06:38.134494  export SHELL=3D/bin/sh
    2023-05-19T14:06:38.135411  #
    2023-05-19T14:06:38.237497  / # export SHELL=3D/bin/sh. /lava-485567/en=
vironment
    2023-05-19T14:06:38.238417  =

    2023-05-19T14:06:38.340561  / # . /lava-485567/environment/lava-485567/=
bin/lava-test-runner /lava-485567/1
    2023-05-19T14:06:38.342036  =

    2023-05-19T14:06:38.346819  / # /lava-485567/bin/lava-test-runner /lava=
-485567/1
    2023-05-19T14:06:38.454053  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64678860477f286f262e865a

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64678861477f286f262e865d
        failing since 125 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-19T14:31:48.005051  <8>[   13.001913] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 937117_1.5.2.4.1>
    2023-05-19T14:31:48.115377  / # #
    2023-05-19T14:31:48.217280  export SHELL=3D/bin/sh
    2023-05-19T14:31:48.217917  #
    2023-05-19T14:31:48.319342  / # export SHELL=3D/bin/sh. /lava-937117/en=
vironment
    2023-05-19T14:31:48.319918  =

    2023-05-19T14:31:48.421247  / # . /lava-937117/environment/lava-937117/=
bin/lava-test-runner /lava-937117/1
    2023-05-19T14:31:48.422118  =

    2023-05-19T14:31:48.428661  / # /lava-937117/bin/lava-test-runner /lava=
-937117/1
    2023-05-19T14:31:48.536401  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls1028a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64678460d6454e43ea2e868c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1028a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1028a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64678460d6454e43ea2e868f
        failing since 67 days (last pass: v5.10.155-cip21, first fail: v5.1=
0.173-cip28)

    2023-05-19T14:14:41.802504  [   23.587045] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1225394_1.5.2.4.1>
    2023-05-19T14:14:41.909978  / # #
    2023-05-19T14:14:42.011739  export SHELL=3D/bin/sh
    2023-05-19T14:14:42.012115  #
    2023-05-19T14:14:42.113293  / # export SHELL=3D/bin/sh. /lava-1225394/e=
nvironment
    2023-05-19T14:14:42.113871  =

    2023-05-19T14:14:42.215273  / # . /lava-1225394/environment/lava-122539=
4/bin/lava-test-runner /lava-1225394/1
    2023-05-19T14:14:42.215993  =

    2023-05-19T14:14:42.218073  / # /lava-1225394/bin/lava-test-runner /lav=
a-1225394/1
    2023-05-19T14:14:42.238495  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls1088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/646784e913e0d6be1b2e85f8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1088a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646784e913e0d6be1b2e85fb
        failing since 125 days (last pass: v5.10.155-cip21, first fail: v5.=
10.162-cip24)

    2023-05-19T14:15:16.572367  + [    9.763678] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 1225392_1.5.2.4.1>
    2023-05-19T14:15:16.572504  set +x
    2023-05-19T14:15:16.675995  / # #
    2023-05-19T14:15:16.777073  export SHELL=3D/bin/sh
    2023-05-19T14:15:16.777269  #
    2023-05-19T14:15:16.878243  / # export SHELL=3D/bin/sh. /lava-1225392/e=
nvironment
    2023-05-19T14:15:16.878441  =

    2023-05-19T14:15:16.979429  / # . /lava-1225392/environment/lava-122539=
2/bin/lava-test-runner /lava-1225392/1
    2023-05-19T14:15:16.979760  =

    2023-05-19T14:15:16.981623  / # /lava-1225392/bin/lava-test-runner /lav=
a-1225392/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6467873e718a18d24d2e862b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6467873f718a18d24d2e8630
        failing since 35 days (last pass: v5.10.176-cip30, first fail: v5.1=
0.177-cip31)

    2023-05-19T14:26:58.506420  + set +x

    2023-05-19T14:26:58.512985  <8>[   14.624594] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10389263_1.4.2.3.1>

    2023-05-19T14:26:58.617154  / # #

    2023-05-19T14:26:58.717702  export SHELL=3D/bin/sh

    2023-05-19T14:26:58.717900  #

    2023-05-19T14:26:58.818370  / # export SHELL=3D/bin/sh. /lava-10389263/=
environment

    2023-05-19T14:26:58.818610  =


    2023-05-19T14:26:58.919117  / # . /lava-10389263/environment/lava-10389=
263/bin/lava-test-runner /lava-10389263/1

    2023-05-19T14:26:58.919452  =


    2023-05-19T14:26:58.924064  / # /lava-10389263/bin/lava-test-runner /la=
va-10389263/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64678702b30c05e7aa2e86c4

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64678702b30c05e7aa2e86c9
        failing since 35 days (last pass: v5.10.176-cip30, first fail: v5.1=
0.177-cip31)

    2023-05-19T14:25:57.081834  <8>[   13.583225] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10389256_1.4.2.3.1>

    2023-05-19T14:25:57.085546  + set +x

    2023-05-19T14:25:57.190070  / # #

    2023-05-19T14:25:57.290723  export SHELL=3D/bin/sh

    2023-05-19T14:25:57.291056  #

    2023-05-19T14:25:57.391720  / # export SHELL=3D/bin/sh. /lava-10389256/=
environment

    2023-05-19T14:25:57.392058  =


    2023-05-19T14:25:57.492743  / # . /lava-10389256/environment/lava-10389=
256/bin/lava-test-runner /lava-10389256/1

    2023-05-19T14:25:57.493100  =


    2023-05-19T14:25:57.498120  / # /lava-10389256/bin/lava-test-runner /la=
va-10389256/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64678314fd0b8edb962e85f8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64678314fd0b8edb962e85fd
        failing since 125 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-19T14:09:12.995546  / # #

    2023-05-19T14:09:13.098232  export SHELL=3D/bin/sh

    2023-05-19T14:09:13.098979  #

    2023-05-19T14:09:13.200874  / # export SHELL=3D/bin/sh. /lava-10389592/=
environment

    2023-05-19T14:09:13.201678  =


    2023-05-19T14:09:13.303508  / # . /lava-10389592/environment/lava-10389=
592/bin/lava-test-runner /lava-10389592/1

    2023-05-19T14:09:13.304769  =


    2023-05-19T14:09:13.318095  / # /lava-10389592/bin/lava-test-runner /la=
va-10389592/1

    2023-05-19T14:09:13.422005  + export 'TESTRUN_ID=3D1_bootrr'

    2023-05-19T14:09:13.422548  + cd /lava-10389592/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64678295750874e70d2e8632

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandb=
oard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandb=
oard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64678295750874e70d2e8637
        failing since 125 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-19T14:07:08.872064  + set +x
    2023-05-19T14:07:08.872266  [   10.306609] <LAVA_SIGNAL_ENDRUN 0_dmesg =
954897_1.5.2.3.1>
    2023-05-19T14:07:08.979914  / # #
    2023-05-19T14:07:09.081526  export SHELL=3D/bin/sh
    2023-05-19T14:07:09.081955  #
    2023-05-19T14:07:09.183295  / # export SHELL=3D/bin/sh. /lava-954897/en=
vironment
    2023-05-19T14:07:09.183771  =

    2023-05-19T14:07:09.285190  / # . /lava-954897/environment/lava-954897/=
bin/lava-test-runner /lava-954897/1
    2023-05-19T14:07:09.285867  =

    2023-05-19T14:07:09.288985  / # /lava-954897/bin/lava-test-runner /lava=
-954897/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/646782e4f98c951f502e864b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandbo=
ard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandbo=
ard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646782e4f98c951f502e8650
        failing since 125 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-19T14:08:27.464360  + set[    7.175299] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 954899_1.5.2.3.1>
    2023-05-19T14:08:27.464690   +x
    2023-05-19T14:08:27.569838  / # #
    2023-05-19T14:08:27.671353  export SHELL=3D/bin/sh
    2023-05-19T14:08:27.671860  #
    2023-05-19T14:08:27.773035  / # export SHELL=3D/bin/sh. /lava-954899/en=
vironment
    2023-05-19T14:08:27.773591  =

    2023-05-19T14:08:27.874866  / # . /lava-954899/environment/lava-954899/=
bin/lava-test-runner /lava-954899/1
    2023-05-19T14:08:27.875461  =

    2023-05-19T14:08:27.877745  / # /lava-954899/bin/lava-test-runner /lava=
-954899/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64678434468b55d06b2e8695

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64678434468b55d06b2e8698
        failing since 125 days (last pass: v5.10.155-cip21, first fail: v5.=
10.162-cip24)

    2023-05-19T14:13:50.387079  / # #
    2023-05-19T14:13:51.546581  export SHELL=3D/bin/sh
    2023-05-19T14:13:51.551969  #
    2023-05-19T14:13:53.097189  / # export SHELL=3D/bin/sh. /lava-1225389/e=
nvironment
    2023-05-19T14:13:53.102594  =

    2023-05-19T14:13:55.920587  / # . /lava-1225389/environment/lava-122538=
9/bin/lava-test-runner /lava-1225389/1
    2023-05-19T14:13:55.926252  =

    2023-05-19T14:13:55.926706  / # /lava-1225389/bin/lava-test-runner /lav=
a-1225389/1
    2023-05-19T14:13:56.015628  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-19T14:13:56.015857  + cd /lava-1225389/1/tests/1_bootrr =

    ... (17 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7ulp-evk                  | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/646784e890a5a95d612e85f1

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7ulp-evk.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7ulp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646784e890a5a95d612e85f4
        failing since 67 days (last pass: v5.10.155-cip21, first fail: v5.1=
0.173-cip28)

    2023-05-19T14:15:06.075197  + set +x<8>[   28.975083] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 1225388_1.5.2.4.1>
    2023-05-19T14:15:06.075506  =

    2023-05-19T14:15:06.184418  / # #
    2023-05-19T14:15:07.344490  export SHELL=3D/bin/sh
    2023-05-19T14:15:07.350144  #
    2023-05-19T14:15:07.350434  / # export SHELL=3D/bin/sh
    2023-05-19T14:15:08.897318  / # . /lava-1225388/environment
    2023-05-19T14:15:11.722213  /lava-1225388/bin/lava-test-runner /lava-12=
25388/1
    2023-05-19T14:15:11.727872  . /lava-1225388/environment
    2023-05-19T14:15:11.728030  / # /lava-1225388/bin/lava-test-runner /lav=
a-1225388/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/646783e2cded63ae522e860c

  Results:     28 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt817=
3-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt817=
3-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646783e2cded63ae522e8628
        failing since 125 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-19T14:12:31.108289  + set +x

    2023-05-19T14:12:31.114926  <8>[   15.668681] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10389624_1.5.2.3.1>

    2023-05-19T14:12:31.218983  #

    2023-05-19T14:12:31.219496  =


    2023-05-19T14:12:31.320316  / # #export SHELL=3D/bin/sh

    2023-05-19T14:12:31.320569  =


    2023-05-19T14:12:31.421769  / # export SHELL=3D/bin/sh. /lava-10389624/=
environment

    2023-05-19T14:12:31.422099  =


    2023-05-19T14:12:31.522768  / # . /lava-10389624/environment/lava-10389=
624/bin/lava-test-runner /lava-10389624/1

    2023-05-19T14:12:31.523118  =

 =

    ... (17 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 4          =


  Details:     https://kernelci.org/test/plan/id/64678302b0d624ca672e85f0

  Results:     63 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-j=
aq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-j=
aq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-i2c-present: https://kernelci.or=
g/test/case/id/64678302b0d624ca672e861f
        failing since 123 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-19T14:08:58.443292  	-s SE<8>[   18.857552] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>

    2023-05-19T14:08:58.445196  P	String separator

    2023-05-19T14:08:58.449029  /lava-10389594/1/../bin/lava-test-case

    2023-05-19T14:08:58.454953  BusyBox v1.31.1 (2023-05-12 17:02:46 UTC) m=
ulti-call binary.

    2023-05-19T14:08:58.455048  =


    2023-05-19T14:08:58.459501  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-05-19T14:08:58.459952  =

   =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/64678302b0d624ca672e8620
        failing since 123 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-19T14:08:58.418949  Usage: seq [-w] [-s SEP] [FIRST [INC]] LA<8=
>[   18.831337] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-05-19T14:08:58.421189  ST

    2023-05-19T14:08:58.421562  =


    2023-05-19T14:08:58.426354  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-05-19T14:08:58.428990  FIRST, INC default to 1.

    2023-05-19T14:08:58.429064  =


    2023-05-19T14:08:58.432607  	-w	Pad to last with leading zeros
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/64678302b0d624ca672e8621
        failing since 123 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-19T14:08:58.393591  =


    2023-05-19T14:08:58.404532  BusyBox v1.31.1 (2023-05-12 17:02:46 UTC) m=
ulti-call binary.

    2023-05-19T14:08:58.404764  =

   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64678302b0d624ca672e8635
        failing since 123 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-19T14:08:46.285044  <8>[    6.703594] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-05-19T14:08:46.294164  + <8>[    6.716128] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10389594_1.5.2.3.1>

    2023-05-19T14:08:46.295273  set +x

    2023-05-19T14:08:46.401736  =


    2023-05-19T14:08:46.402027  / # #<6>[    6.799465] sbs-battery 20-000b:=
 Disabling PEC because of broken Cros-EC implementation

    2023-05-19T14:08:46.503579  export SHELL=3D/bin/sh

    2023-05-19T14:08:46.504332  =


    2023-05-19T14:08:46.605744  / # export SHELL=3D/bin/sh. /lava-10389594/=
environment

    2023-05-19T14:08:46.606458  =


    2023-05-19T14:08:46.707601  / # . /lava-10389594/environment/lava-10389=
594/bin/lava-test-runner /lava-10389594/1
 =

    ... (23 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64678417b82d3f8a292e8602

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk339=
9-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk339=
9-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/64678417b82d3f8a292e8608
        failing since 58 days (last pass: v5.10.173-cip28, first fail: v5.1=
0.175-cip29)

    2023-05-19T14:13:21.537052  /lava-10389629/1/../bin/lava-test-case

    2023-05-19T14:13:21.548562  <8>[   35.444874] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/64678417b82d3f8a292e8609
        failing since 58 days (last pass: v5.10.173-cip28, first fail: v5.1=
0.175-cip29)

    2023-05-19T14:13:19.475900  <8>[   33.371486] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-05-19T14:13:20.501967  /lava-10389629/1/../bin/lava-test-case

    2023-05-19T14:13:20.512560  <8>[   34.409301] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =20

