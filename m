Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19A7C6FD1C
	for <webhook@archiver.kernel.org>; Fri, 24 Mar 2023 09:53:45 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web10.97444.1679651618825596941
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 24 Mar 2023 02:53:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=Q0DUwHUE;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.174, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f174.google.com with SMTP id bc12so1392761plb.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 24 Mar 2023 02:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1679651618;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YCG6jrt/S30r/+9AS7dOltQcA+Th/p30wXbXSD5jRVA=;
        b=Q0DUwHUETyxG3gsGDX6N0GQjRK7lqYmXo3P3FN1BWJJQVXldqNAGTBhISdAQcmf72N
         JEkH86kGzsQEklndBlajeNZqieGuZge1OA+OOdENrVm0x69p/szrCCkwic+k1DbIf+3a
         ZujhrtIsOr4Sj8BezU3/LFtiDu9RG1oYjOTYc6CUSa8Oe7B77jaQ4bE4mrHBG5iEREe5
         ceBU1DthHKVCwqtVd75gi3GKbLghoufQKaFw2I3sW+UEia+dsIf049SMWdJ8f5LMxLe8
         Ph+LJeHhw/A+MW7JbQaVs66lAVESay/H4aM0xwMLIjh0+Xt6kPvUUM++P7M0QdKh+QsU
         DzWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679651618;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YCG6jrt/S30r/+9AS7dOltQcA+Th/p30wXbXSD5jRVA=;
        b=y+tw3bvFL8TCUa5j1ihRqBe6UoQoQMTlajgIEiyTHlyEznWlVeWrhsvgCNMfa93GRG
         uO5gI6/WGDE9CxrWCClslLsUqdTIOA7IJLXDd+siUAUWRDB4x/Ol8GJiDwjI2dH9Jj0R
         2Rsxw+AZfWFjUSkEl4GEnI1Nq93Z3IijLiG/hYsM+ta4MLgWlStCWmKqFFrMt58PxDs2
         1qeFQ5cN+sqz6QpD41oP1bcdwU/dkcSgKMPS7iaXNLearNbRXMW38U4D4de5BxbwLNQr
         L8lr0qNKMD9v797Pq13oNXOUDUgO6VYCUM16R0wWJO11y7k7XNkWlXdnENmjTCr17E8N
         fCUg==
X-Gm-Message-State: AAQBX9edTGdShmrTn/uHN9Uu2UnYEtuAdI/hsnAru1xU+0jfQkaEGK7y
	r2ixDu/b0+l1Rr4c69mccLX7PFkMf6l14633uI6wJg==
X-Google-Smtp-Source: AKy350YEggsnQcyspHFfOXi9VgNyWlqZ+gcxd3koA2+J1LJcC/QqUJwWkUMEC+J2dW3D7E+lu5xRjQ==
X-Received: by 2002:a17:903:228b:b0:1a1:e112:4607 with SMTP id b11-20020a170903228b00b001a1e1124607mr2645856plh.50.1679651617587;
        Fri, 24 Mar 2023 02:53:37 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j1-20020a17090276c100b00195f0fb0c18sm13791014plt.31.2023.03.24.02.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 02:53:37 -0700 (PDT)
Message-ID: <641d7321.170a0220.cef2d.928d@mx.google.com>
Date: Fri, 24 Mar 2023 02:53:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.176-cip30
Subject: cip/linux-5.10.y-cip baseline: 136 runs,
 23 regressions (v5.10.176-cip30)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Mar 2023 09:53:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11111

cip/linux-5.10.y-cip baseline: 136 runs, 23 regressions (v5.10.176-cip30)

Regressions Summary
-------------------

platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
acer-cb317-1h-c3z6-dedede | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =

at91sam9g20ek             | arm    | lab-broonie     | gcc-10   | multi_v5_=
defconfig           | 1          =

beaglebone-black          | arm    | lab-broonie     | gcc-10   | multi_v7_=
defconfig           | 1          =

beaglebone-black          | arm    | lab-broonie     | gcc-10   | omap2plus=
_defconfig          | 1          =

fsl-ls1028a-rdb           | arm64  | lab-nxp         | gcc-10   | defconfig=
                    | 1          =

fsl-ls1088a-rdb           | arm64  | lab-nxp         | gcc-10   | defconfig=
                    | 1          =

fsl-lx2160a-rdb           | arm64  | lab-nxp         | gcc-10   | defconfig=
                    | 1          =

imx6q-sabrelite           | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 1          =

imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | imx_v6_v7=
_defconfig          | 1          =

imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | multi_v7_=
defconfig           | 1          =

imx6sx-sdb                | arm    | lab-nxp         | gcc-10   | multi_v7_=
defconfig           | 1          =

imx6ul-14x14-evk          | arm    | lab-nxp         | gcc-10   | multi_v7_=
defconfig           | 1          =

imx7d-sdb                 | arm    | lab-nxp         | gcc-10   | multi_v7_=
defconfig           | 1          =

imx7ulp-evk               | arm    | lab-nxp         | gcc-10   | multi_v7_=
defconfig           | 1          =

mt8173-elm-hana           | arm64  | lab-collabora   | gcc-10   | defconfig=
+arm64-chromebook   | 1          =

rk3288-veyron-jaq         | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 4          =

rk3399-gru-kevin          | arm64  | lab-collabora   | gcc-10   | defconfig=
+arm64-chromebook   | 2          =

sun50i-a64-pine64-plus    | arm64  | lab-broonie     | gcc-10   | defconfig=
                    | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.176-cip30/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.176-cip30
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      530cf8a4dace471f6e04e5887f4993ba1fcd3109 =



Test Regressions
---------------- =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
acer-cb317-1h-c3z6-dedede | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641d67c7ded4d0bc259c9525

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641d67c7ded4d0bc259c952e
        failing since 69 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-24T09:04:59.463114  <8>[   11.772780] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9759684_1.4.2.3.1>

    2023-03-24T09:04:59.466752  + set +x

    2023-03-24T09:04:59.568285  #

    2023-03-24T09:04:59.669466  / # #export SHELL=3D/bin/sh

    2023-03-24T09:04:59.669714  =


    2023-03-24T09:04:59.770673  / # export SHELL=3D/bin/sh. /lava-9759684/e=
nvironment

    2023-03-24T09:04:59.770892  =


    2023-03-24T09:04:59.871810  / # . /lava-9759684/environment/lava-975968=
4/bin/lava-test-runner /lava-9759684/1

    2023-03-24T09:04:59.872132  =


    2023-03-24T09:04:59.872205  / # <4>[   12.122395] i2c_designware i2c_de=
signware.2: timeout in disabling adapter
 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641d67dbd6f6a7ae759c9517

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641d67dbd6f6a7ae759c9520
        failing since 69 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-24T09:05:11.694199  + set +x

    2023-03-24T09:05:11.700991  <8>[   10.279593] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9759651_1.4.2.3.1>

    2023-03-24T09:05:11.805719  / # #

    2023-03-24T09:05:11.906792  export SHELL=3D/bin/sh

    2023-03-24T09:05:11.907010  #

    2023-03-24T09:05:12.007957  / # export SHELL=3D/bin/sh. /lava-9759651/e=
nvironment

    2023-03-24T09:05:12.008177  =


    2023-03-24T09:05:12.109109  / # . /lava-9759651/environment/lava-975965=
1/bin/lava-test-runner /lava-9759651/1

    2023-03-24T09:05:12.109394  =


    2023-03-24T09:05:12.114085  / # /lava-9759651/bin/lava-test-runner /lav=
a-9759651/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
at91sam9g20ek             | arm    | lab-broonie     | gcc-10   | multi_v5_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/641d68986b3e715b029c9558

  Results:     47 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641d68986b3e715b029c9591
        failing since 69 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-24T09:08:03.426020  + set +x
    2023-03-24T09:08:03.431160  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 221044_1.5.2=
.4.1>
    2023-03-24T09:08:03.545518  / # #
    2023-03-24T09:08:03.648320  export SHELL=3D/bin/sh
    2023-03-24T09:08:03.649164  #
    2023-03-24T09:08:03.751131  / # export SHELL=3D/bin/sh. /lava-221044/en=
vironment
    2023-03-24T09:08:03.751923  =

    2023-03-24T09:08:03.853952  / # . /lava-221044/environment/lava-221044/=
bin/lava-test-runner /lava-221044/1
    2023-03-24T09:08:03.855357  =

    2023-03-24T09:08:03.860854  / # /lava-221044/bin/lava-test-runner /lava=
-221044/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
beaglebone-black          | arm    | lab-broonie     | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/641d6a60b125ed01a09c950e

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641d6a60b125ed01a09c953f
        failing since 69 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-24T09:15:30.029041  <8>[   18.571453] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 221138_1.5.2.4.1>
    2023-03-24T09:15:30.247645  / # #
    2023-03-24T09:15:30.366256  export SHELL=3D/bin/sh
    2023-03-24T09:15:30.376801  #
    2023-03-24T09:15:30.382382  / # export SHELL=3D/bin/sh
    2023-03-24T09:15:30.500422  / # . /lava-221138/environment
    2023-03-24T09:15:30.614042  /lava-221138/bin/lava-test-runner /lava-221=
138/1
    2023-03-24T09:15:30.623062  . /lava-221138/environment
    2023-03-24T09:15:30.626770  / # /lava-221138/bin/lava-test-runner /lava=
-221138/1
    2023-03-24T09:15:30.721021  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
beaglebone-black          | arm    | lab-broonie     | gcc-10   | omap2plus=
_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/641d69ee347551c6219c95bf

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641d69ee347551c6219c95f7
        failing since 69 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-24T09:14:13.106781  <8>[   20.976871] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 221163_1.5.2.4.1>
    2023-03-24T09:14:13.214930  / # #
    2023-03-24T09:14:13.317265  export SHELL=3D/bin/sh
    2023-03-24T09:14:13.317905  #
    2023-03-24T09:14:13.419556  / # export SHELL=3D/bin/sh. /lava-221163/en=
vironment
    2023-03-24T09:14:13.420119  =

    2023-03-24T09:14:13.521910  / # . /lava-221163/environment/lava-221163/=
bin/lava-test-runner /lava-221163/1
    2023-03-24T09:14:13.522792  =

    2023-03-24T09:14:13.527345  / # /lava-221163/bin/lava-test-runner /lava=
-221163/1
    2023-03-24T09:14:13.631320  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
fsl-ls1028a-rdb           | arm64  | lab-nxp         | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/641d6b07a603abdd3c9c950a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1028a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1028a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641d6b07a603abdd3c9c9511
        failing since 10 days (last pass: v5.10.155-cip21, first fail: v5.1=
0.173-cip28)

    2023-03-24T09:18:44.701104  + [   19.551654] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 1184979_1.5.2.4.1>
    2023-03-24T09:18:44.701396  set +x
    2023-03-24T09:18:44.807138  / # #
    2023-03-24T09:18:44.908993  export SHELL=3D/bin/sh
    2023-03-24T09:18:44.909456  #
    2023-03-24T09:18:45.010839  / # export SHELL=3D/bin/sh. /lava-1184979/e=
nvironment
    2023-03-24T09:18:45.011326  =

    2023-03-24T09:18:45.112725  / # . /lava-1184979/environment/lava-118497=
9/bin/lava-test-runner /lava-1184979/1
    2023-03-24T09:18:45.113481  =

    2023-03-24T09:18:45.115464  / # /lava-1184979/bin/lava-test-runner /lav=
a-1184979/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
fsl-ls1088a-rdb           | arm64  | lab-nxp         | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/641d6b3665568019099c9510

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1088a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641d6b3665568019099c9517
        failing since 69 days (last pass: v5.10.155-cip21, first fail: v5.1=
0.162-cip24)

    2023-03-24T09:19:15.419370  [    9.602088] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1184982_1.5.2.4.1>
    2023-03-24T09:19:15.526860  / # #
    2023-03-24T09:19:15.628713  export SHELL=3D/bin/sh
    2023-03-24T09:19:15.629160  #
    2023-03-24T09:19:15.730528  / # export SHELL=3D/bin/sh. /lava-1184982/e=
nvironment
    2023-03-24T09:19:15.731002  =

    2023-03-24T09:19:15.832381  / # . /lava-1184982/environment/lava-118498=
2/bin/lava-test-runner /lava-1184982/1
    2023-03-24T09:19:15.833134  =

    2023-03-24T09:19:15.835056  / # /lava-1184982/bin/lava-test-runner /lav=
a-1184982/1
    2023-03-24T09:19:15.853065  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
fsl-lx2160a-rdb           | arm64  | lab-nxp         | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/641d6aa4b11a397c449c950b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641d6aa4b11a397c449c9512
        failing since 2 days (last pass: v5.10.154-cip20, first fail: v5.10=
.175-cip29)

    2023-03-24T09:17:02.419931  [   10.750425] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1184981_1.5.2.4.1>
    2023-03-24T09:17:02.526228  / # #
    2023-03-24T09:17:02.628292  export SHELL=3D/bin/sh
    2023-03-24T09:17:02.628784  #
    2023-03-24T09:17:02.730229  / # export SHELL=3D/bin/sh. /lava-1184981/e=
nvironment
    2023-03-24T09:17:02.730709  =

    2023-03-24T09:17:02.832181  / # . /lava-1184981/environment/lava-118498=
1/bin/lava-test-runner /lava-1184981/1
    2023-03-24T09:17:02.832979  =

    2023-03-24T09:17:02.834758  / # /lava-1184981/bin/lava-test-runner /lav=
a-1184981/1
    2023-03-24T09:17:02.853429  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6q-sabrelite           | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/641d696f5c7a83fa7c9c9505

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641d696f5c7a83fa7c9c950e
        failing since 69 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-24T09:11:56.556047  + set<8>[    9.459078] <LAVA_SIGNAL_ENDRUN =
0_dmesg 9759705_1.5.2.4.1>

    2023-03-24T09:11:56.556559   +x

    2023-03-24T09:11:56.665576  / # #

    2023-03-24T09:11:56.769027  export SHELL=3D/bin/sh

    2023-03-24T09:11:56.769918  #

    2023-03-24T09:11:56.872021  / # export SHELL=3D/bin/sh. /lava-9759705/e=
nvironment

    2023-03-24T09:11:56.872934  =


    2023-03-24T09:11:56.974998  / # . /lava-9759705/environment/lava-975970=
5/bin/lava-test-runner /lava-9759705/1

    2023-03-24T09:11:56.976426  =


    2023-03-24T09:11:56.978460  / # /lava-9759705/bin/lava-test-runner /lav=
a-9759705/1
 =

    ... (16 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | imx_v6_v7=
_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/641d6895beb5c49a849c9547

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandb=
oard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandb=
oard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641d6895beb5c49a849c9550
        failing since 69 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-24T09:08:30.992598  + set +x
    2023-03-24T09:08:30.992798  [   10.288616] <LAVA_SIGNAL_ENDRUN 0_dmesg =
922336_1.5.2.3.1>
    2023-03-24T09:08:31.101422  / # #
    2023-03-24T09:08:31.203264  export SHELL=3D/bin/sh
    2023-03-24T09:08:31.203823  #
    2023-03-24T09:08:31.305183  / # export SHELL=3D/bin/sh. /lava-922336/en=
vironment
    2023-03-24T09:08:31.305749  =

    2023-03-24T09:08:31.407453  / # . /lava-922336/environment/lava-922336/=
bin/lava-test-runner /lava-922336/1
    2023-03-24T09:08:31.408263  =

    2023-03-24T09:08:31.411119  / # /lava-922336/bin/lava-test-runner /lava=
-922336/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/641d69353ecc8ce3dc9c9529

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandbo=
ard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandbo=
ard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641d69353ecc8ce3dc9c9532
        failing since 69 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-24T09:11:10.291142  + set[    7.123898] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 922337_1.5.2.3.1>
    2023-03-24T09:11:10.291336   +x
    2023-03-24T09:11:10.397617  / # #
    2023-03-24T09:11:10.499296  export SHELL=3D/bin/sh
    2023-03-24T09:11:10.499812  #
    2023-03-24T09:11:10.601233  / # export SHELL=3D/bin/sh. /lava-922337/en=
vironment
    2023-03-24T09:11:10.601795  =

    2023-03-24T09:11:10.703216  / # . /lava-922337/environment/lava-922337/=
bin/lava-test-runner /lava-922337/1
    2023-03-24T09:11:10.703948  =

    2023-03-24T09:11:10.706309  / # /lava-922337/bin/lava-test-runner /lava=
-922337/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6sx-sdb                | arm    | lab-nxp         | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/641d69b4ab52f9ecd99c952e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx6sx-sdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx6sx-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641d69b4ab52f9ecd99c9535
        failing since 69 days (last pass: v5.10.153-cip19-3-gc76f4e7e5c71, =
first fail: v5.10.162-cip24)

    2023-03-24T09:12:49.411564  <8>[   23.740286] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1184970_1.5.2.4.1>
    2023-03-24T09:12:49.517533  / # #
    2023-03-24T09:12:50.677129  export SHELL=3D/bin/sh
    2023-03-24T09:12:50.682748  #
    2023-03-24T09:12:52.230054  / # export SHELL=3D/bin/sh. /lava-1184970/e=
nvironment
    2023-03-24T09:12:52.235724  =

    2023-03-24T09:12:52.236049  / # . /lava-1184970/environment
    2023-03-24T09:12:55.057911  / # /lava-1184970/bin/lava-test-runner /lav=
a-1184970/1
    2023-03-24T09:12:55.074539  /lava-1184970/bin/lava-test-runner /lava-11=
84970/1
    2023-03-24T09:12:55.167989  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (19 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6ul-14x14-evk          | arm    | lab-nxp         | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/641d69af7022fd124a9c9528

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx6ul-14x14-evk.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx6ul-14x14-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641d69b07022fd124a9c952f
        failing since 2 days (last pass: v5.10.145-cip17, first fail: v5.10=
.175-cip29)

    2023-03-24T09:12:51.910915  + set +x
    2023-03-24T09:12:51.912021  <8>[   29.130491] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1184969_1.5.2.4.1>
    2023-03-24T09:12:52.021585  =

    2023-03-24T09:12:53.180950  / # #export SHELL=3D/bin/sh
    2023-03-24T09:12:53.186628  =

    2023-03-24T09:12:53.186967  / # export SHELL=3D/bin/sh
    2023-03-24T09:12:54.733765  . /lava-1184969/environment
    2023-03-24T09:12:57.560557  / # . /lava-1184969/environment/lava-118496=
9/bin/lava-test-runner /lava-1184969/1
    2023-03-24T09:12:57.566563  =

    2023-03-24T09:12:57.566839  / # /lava-1184969/bin/lava-test-runner /lav=
a-1184969/1 =

    ... (18 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx7d-sdb                 | arm    | lab-nxp         | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/641d69872226fdcc519c9517

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641d69872226fdcc519c951e
        failing since 69 days (last pass: v5.10.155-cip21, first fail: v5.1=
0.162-cip24)

    2023-03-24T09:12:14.351191  / # #
    2023-03-24T09:12:15.510808  export SHELL=3D/bin/sh
    2023-03-24T09:12:15.516513  #
    2023-03-24T09:12:17.064075  / # export SHELL=3D/bin/sh. /lava-1184973/e=
nvironment
    2023-03-24T09:12:17.069790  =

    2023-03-24T09:12:19.892590  / # . /lava-1184973/environment/lava-118497=
3/bin/lava-test-runner /lava-1184973/1
    2023-03-24T09:12:19.898480  =

    2023-03-24T09:12:19.905668  / # /lava-1184973/bin/lava-test-runner /lav=
a-1184973/1
    2023-03-24T09:12:19.998555  + export 'TESTRUN_ID=3D1_bootrr'
    2023-03-24T09:12:19.998839  + cd /lava-1184973/1/tests/1_bootrr =

    ... (18 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx7ulp-evk               | arm    | lab-nxp         | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/641d69c37022fd124a9c9543

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7ulp-evk.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7ulp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641d69c37022fd124a9c954a
        failing since 10 days (last pass: v5.10.155-cip21, first fail: v5.1=
0.173-cip28)

    2023-03-24T09:13:07.589399  + set +x<8>[   28.964878] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 1184971_1.5.2.4.1>
    2023-03-24T09:13:07.589662  =

    2023-03-24T09:13:07.699104  / # #
    2023-03-24T09:13:08.858542  export SHELL=3D/bin/sh
    2023-03-24T09:13:08.864206  #
    2023-03-24T09:13:08.864494  / # export SHELL=3D/bin/sh
    2023-03-24T09:13:10.411986  / # . /lava-1184971/environment
    2023-03-24T09:13:13.239171  /lava-1184971/bin/lava-test-runner /lava-11=
84971/1
    2023-03-24T09:13:13.245227  . /lava-1184971/environment
    2023-03-24T09:13:13.245505  / # /lava-1184971/bin/lava-test-runner /lav=
a-1184971/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
mt8173-elm-hana           | arm64  | lab-collabora   | gcc-10   | defconfig=
+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/641d6c670ea1c9c1939c9583

  Results:     28 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt817=
3-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt817=
3-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641d6c670ea1c9c1939c95a3
        failing since 69 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-24T09:24:46.499461  <8>[   15.652020] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-03-24T09:24:46.500179  + set +x

    2023-03-24T09:24:46.505402  <8>[   15.661632] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9759753_1.5.2.3.1>

    2023-03-24T09:24:46.614665  #

    2023-03-24T09:24:46.616018  =


    2023-03-24T09:24:46.718574  / # #export SHELL=3D/bin/sh

    2023-03-24T09:24:46.719565  =


    2023-03-24T09:24:46.821780  / # export SHELL=3D/bin/sh. /lava-9759753/e=
nvironment

    2023-03-24T09:24:46.822670  =


    2023-03-24T09:24:46.924775  / # . /lava-9759753/environment/lava-975975=
3/bin/lava-test-runner /lava-9759753/1
 =

    ... (17 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
rk3288-veyron-jaq         | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 4          =


  Details:     https://kernelci.org/test/plan/id/641d69705c7a83fa7c9c9513

  Results:     63 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-j=
aq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-j=
aq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641d69705c7a83fa7c9c9544
        failing since 67 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-24T09:11:34.296186  + <8>[   11.431861] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 9759710_1.5.2.3.1>

    2023-03-24T09:11:34.298084  set +x

    2023-03-24T09:11:34.405694  =


    2023-03-24T09:11:34.508300  / # #export SHELL=3D/bin/sh

    2023-03-24T09:11:34.509115  =


    2023-03-24T09:11:34.611139  / # export SHELL=3D/bin/sh. /lava-9759710/e=
nvironment

    2023-03-24T09:11:34.611972  =


    2023-03-24T09:11:34.714142  / # . /lava-9759710/environment/lava-975971=
0/bin/lava-test-runner /lava-9759710/1

    2023-03-24T09:11:34.715482  =


    2023-03-24T09:11:34.717415  / # /lava-9759710/bin/lava-test-runner /lav=
a-9759710/1
 =

    ... (18 line(s) more)  =


  * baseline.bootrr.dwhdmi-rockchip-driver-i2c-present: https://kernelci.or=
g/test/case/id/641d69705c7a83fa7c9c9548
        failing since 67 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-24T09:11:46.394825  FIRST,<8>[   23.520801] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>

    2023-03-24T09:11:46.396239   INC default to 1.

    2023-03-24T09:11:46.396696  =


    2023-03-24T09:11:46.400011  	-w	Pad to last with leading zeros

    2023-03-24T09:11:46.402625  	-s SEP	String separator

    2023-03-24T09:11:46.406066  /lava-9759710/1/../bin/lava-test-case

    2023-03-24T09:11:46.412692  BusyBox v1.31.1 (2023-03-10 17:51:43 UTC) m=
ulti-call binary.

    2023-03-24T09:11:46.412903  =

   =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/641d69705c7a83fa7c9c9549
        failing since 67 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-24T09:11:46.370742  BusyBox v1.31.1 (2023-03-10 17:51:43 UTC)<8=
>[   23.501621] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-03-24T09:11:46.374052   multi-call binary.

    2023-03-24T09:11:46.374291  =


    2023-03-24T09:11:46.378613  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-03-24T09:11:46.379069  =


    2023-03-24T09:11:46.383810  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/641d69705c7a83fa7c9c954a
        failing since 67 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-24T09:11:46.351812  <8>[   23.483928] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>
   =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora   | gcc-10   | defconfig=
+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/641d6c9842154f828b9c9505

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk339=
9-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk339=
9-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/641d6c9842154f828b9c950f
        failing since 2 days (last pass: v5.10.173-cip28, first fail: v5.10=
.175-cip29)

    2023-03-24T09:25:22.439772  /lava-9759759/1/../bin/lava-test-case

    2023-03-24T09:25:22.451150  <8>[   34.900493] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/641d6c9842154f828b9c9510
        failing since 2 days (last pass: v5.10.173-cip28, first fail: v5.10=
.175-cip29)

    2023-03-24T09:25:21.405337  /lava-9759759/1/../bin/lava-test-case

    2023-03-24T09:25:21.415970  <8>[   33.865365] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
sun50i-a64-pine64-plus    | arm64  | lab-broonie     | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/641d6c0db28b0179209c9562

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641d6c0db28b0179209c9592
        failing since 69 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-24T09:22:53.213115  + set +x
    2023-03-24T09:22:53.217268  <8>[   17.214399] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 221182_1.5.2.4.1>
    2023-03-24T09:22:53.327767  / # #
    2023-03-24T09:22:53.429833  export SHELL=3D/bin/sh
    2023-03-24T09:22:53.430283  #
    2023-03-24T09:22:53.531792  / # export SHELL=3D/bin/sh. /lava-221182/en=
vironment
    2023-03-24T09:22:53.532434  =

    2023-03-24T09:22:53.635190  / # . /lava-221182/environment/lava-221182/=
bin/lava-test-runner /lava-221182/1
    2023-03-24T09:22:53.636732  =

    2023-03-24T09:22:53.640321  / # /lava-221182/bin/lava-test-runner /lava=
-221182/1 =

    ... (12 line(s) more)  =

 =20

