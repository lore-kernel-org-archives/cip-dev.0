Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50FCC77B6F
	for <webhook@archiver.kernel.org>; Fri, 14 Apr 2023 10:53:10 +0000 (UTC)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.web10.6224.1681469585241300604
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 14 Apr 2023 03:53:05 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=ZLjVWCWS;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.46, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f46.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso8279952pjc.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 14 Apr 2023 03:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1681469584; x=1684061584;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=g9PbZzpsZfcx41KLg5D0lDYKb9pU6+f6wukbsRzHHyQ=;
        b=ZLjVWCWSN383yCP7uK98X2jcWiewbCp2lm75KwlnAaXt3KjIY9FakMzgn6doTY3q/i
         5S8+TjWWj5XrU6QzlOsBDdf3tXc8OAHY5rTxdDZ0gdWrBDlJHMHmJeZa+UEHDpIN2GW1
         jRrw6/e3ZIEatOZtztYvsXN41H+TC3AD77ngfsMxriTcDikYDePDUjQUYBzEq5x2BJLF
         an2v9I4/BqBzftYZ6TUkKg3moz8GP32AEfo5QQVzN5Thf4UhmgAQ00ORkV30b/cTJvmQ
         RxkgYAemLmJgxIL0Elqu48lof/Kjsj/tB++Crpt4+aPt76r1fpOx5JSjRk8dpXfstyM5
         ejKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681469584; x=1684061584;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g9PbZzpsZfcx41KLg5D0lDYKb9pU6+f6wukbsRzHHyQ=;
        b=Ttj8a1gSTUF1S5INxuJg+a+tmmOyBjwwoR3AOdisHqInrdA/AezLufp6uRaNd0Tu31
         SEC7k9Obd+H/z4nHtaXPH2XVp1UWkG/twK5i96yNoVoeCEg35Go2f30Jhz4f4yBRlGUZ
         /lSEoJK8UvAza7G8Lt41jefi1iihua10p4PsLM1JP9faC76W/yi+/7VDTk0H8iE9soaz
         MN8Ggb6LOscpemY74fxYNg238vcSwgwHtazASPtvsmgdkC3W8dk2tupmJIJm8iyuVoe4
         hcztJdtPAdU6MiYu0bMaiJqC1Lw4WJx/40YCGj5nGpOjUEG8GTYsEbcWyOv/S+NKfwV3
         FHbA==
X-Gm-Message-State: AAQBX9db6ATsGwnePGhwzk+iPRbbEjeuzw0232dbULPYG7nH9j3TvZtO
	bFmgUbLv/FO3m390P8+4nxY7b6+J+7YxKVCVcceqZivl
X-Google-Smtp-Source: AKy350aZBHF00mm+Zb3J2SSsXIWDH/IXQc3N5Vw/4EHnrBgpcKgQY+qA5HwzI1hseZxO2mO64TBhRA==
X-Received: by 2002:a05:6a20:b546:b0:dd:b941:5d99 with SMTP id ev6-20020a056a20b54600b000ddb9415d99mr4301446pzb.51.1681469583790;
        Fri, 14 Apr 2023 03:53:03 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x24-20020a62fb18000000b0062de9ef6915sm2762852pfm.216.2023.04.14.03.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 03:53:03 -0700 (PDT)
Message-ID: <6439308f.620a0220.fba0c.610c@mx.google.com>
Date: Fri, 14 Apr 2023 03:53:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.177-cip31
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip baseline: 131 runs,
 25 regressions (v5.10.177-cip31)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Apr 2023 10:53:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11209

cip/linux-5.10.y-cip baseline: 131 runs, 25 regressions (v5.10.177-cip31)

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

imx6ul-14x14-evk             | arm    | lab-nxp         | gcc-10   | multi_=
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
l/v5.10.177-cip31/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.177-cip31
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      deb75c99ed78d677587a345854b8a00fb2cac68c =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6439250178ad1dbac02e85e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230407.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6439250178ad1dbac02e85eb
        failing since 90 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-04-14T10:03:30.976852  + set +x

    2023-04-14T10:03:30.983181  <8>[   11.821742] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9975357_1.4.2.3.1>

    2023-04-14T10:03:31.087953  / # #

    2023-04-14T10:03:31.189038  export SHELL=3D/bin/sh

    2023-04-14T10:03:31.189212  #

    2023-04-14T10:03:31.290130  / # export SHELL=3D/bin/sh. /lava-9975357/e=
nvironment

    2023-04-14T10:03:31.290306  =


    2023-04-14T10:03:31.391265  / # . /lava-9975357/environment/lava-997535=
7/bin/lava-test-runner /lava-9975357/1

    2023-04-14T10:03:31.391557  =


    2023-04-14T10:03:31.396509  / # /lava-9975357/bin/lava-test-runner /lav=
a-9975357/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64392500868ad49c152e85ee

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230407.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64392500868ad49c152e85f3
        failing since 90 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-04-14T10:03:32.598513  + set<8>[   11.199307] <LAVA_SIGNAL_ENDRUN =
0_dmesg 9975335_1.4.2.3.1>

    2023-04-14T10:03:32.598598   +x

    2023-04-14T10:03:32.703289  / # #

    2023-04-14T10:03:32.804211  export SHELL=3D/bin/sh

    2023-04-14T10:03:32.804424  #

    2023-04-14T10:03:32.905281  / # export SHELL=3D/bin/sh. /lava-9975335/e=
nvironment

    2023-04-14T10:03:32.905488  =


    2023-04-14T10:03:33.006475  / # . /lava-9975335/environment/lava-997533=
5/bin/lava-test-runner /lava-9975335/1

    2023-04-14T10:03:33.006788  =


    2023-04-14T10:03:33.011650  / # /lava-9975335/bin/lava-test-runner /lav=
a-9975335/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6439242bb2800b179e2e8615

  Results:     47 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230407.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6439242bb2800b179e2e8649
        failing since 90 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-04-14T09:59:34.243549  + set +x
    2023-04-14T09:59:34.248777  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 327688_1.5.2=
.4.1>
    2023-04-14T09:59:34.363106  / # #
    2023-04-14T09:59:34.465940  export SHELL=3D/bin/sh
    2023-04-14T09:59:34.466770  #
    2023-04-14T09:59:34.568712  / # export SHELL=3D/bin/sh. /lava-327688/en=
vironment
    2023-04-14T09:59:34.569522  =

    2023-04-14T09:59:34.671538  / # . /lava-327688/environment/lava-327688/=
bin/lava-test-runner /lava-327688/1
    2023-04-14T09:59:34.672860  =

    2023-04-14T09:59:34.679269  / # /lava-327688/bin/lava-test-runner /lava=
-327688/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64392401d7b709dc252e85fc

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230407.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64392401d7b709dc252e8628
        failing since 90 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-04-14T09:58:50.171579  <8>[   13.469577] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 327681_1.5.2.4.1>
    2023-04-14T09:58:50.281190  / # #
    2023-04-14T09:58:50.384052  export SHELL=3D/bin/sh
    2023-04-14T09:58:50.384950  #
    2023-04-14T09:58:50.487240  / # export SHELL=3D/bin/sh. /lava-327681/en=
vironment
    2023-04-14T09:58:50.487963  =

    2023-04-14T09:58:50.590341  / # . /lava-327681/environment/lava-327681/=
bin/lava-test-runner /lava-327681/1
    2023-04-14T09:58:50.591482  =

    2023-04-14T09:58:50.596371  / # /lava-327681/bin/lava-test-runner /lava=
-327681/1
    2023-04-14T09:58:50.680196  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64392ca1137891bfae2e85e8

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230407.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64392ca1137891bfae2e8615
        failing since 90 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-04-14T10:35:32.596528  <8>[   15.620969] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 905138_1.5.2.4.1>
    2023-04-14T10:35:32.704568  / # #
    2023-04-14T10:35:32.806855  export SHELL=3D/bin/sh
    2023-04-14T10:35:32.807557  #
    2023-04-14T10:35:32.909369  / # export SHELL=3D/bin/sh. /lava-905138/en=
vironment
    2023-04-14T10:35:32.910103  =

    2023-04-14T10:35:33.011992  / # . /lava-905138/environment/lava-905138/=
bin/lava-test-runner /lava-905138/1
    2023-04-14T10:35:33.013146  =

    2023-04-14T10:35:33.019597  / # /lava-905138/bin/lava-test-runner /lava=
-905138/1
    2023-04-14T10:35:33.115765  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64392722db58c562142e862c

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230407.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64392722db58c562142e8661
        failing since 90 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-04-14T10:12:34.006204  <8>[   25.690870] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 327841_1.5.2.4.1>
    2023-04-14T10:12:34.113852  / # #
    2023-04-14T10:12:34.215657  export SHELL=3D/bin/sh
    2023-04-14T10:12:34.216095  #
    2023-04-14T10:12:34.317559  / # export SHELL=3D/bin/sh. /lava-327841/en=
vironment
    2023-04-14T10:12:34.318163  =

    2023-04-14T10:12:34.419841  / # . /lava-327841/environment/lava-327841/=
bin/lava-test-runner /lava-327841/1
    2023-04-14T10:12:34.420981  =

    2023-04-14T10:12:34.426151  / # /lava-327841/bin/lava-test-runner /lava=
-327841/1
    2023-04-14T10:12:34.528251  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls1028a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/643926be5a89aa85f52e8609

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1028a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1028a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230407.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/643926be5a89aa85f52e860e
        failing since 31 days (last pass: v5.10.155-cip21, first fail: v5.1=
0.173-cip28)

    2023-04-14T10:10:41.616704  + [   21.299289] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 1199975_1.5.2.4.1>
    2023-04-14T10:10:41.616830  set +x
    2023-04-14T10:10:41.720386  / # #
    2023-04-14T10:10:41.821707  export SHELL=3D/bin/sh
    2023-04-14T10:10:41.822319  #
    2023-04-14T10:10:41.923730  / # export SHELL=3D/bin/sh. /lava-1199975/e=
nvironment
    2023-04-14T10:10:41.924196  =

    2023-04-14T10:10:42.025606  / # . /lava-1199975/environment/lava-119997=
5/bin/lava-test-runner /lava-1199975/1
    2023-04-14T10:10:42.026366  =

    2023-04-14T10:10:42.028401  / # /lava-1199975/bin/lava-test-runner /lav=
a-1199975/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls1088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/643926bb84cf1eb71f2e8613

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1088a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230407.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/643926bb84cf1eb71f2e8618
        failing since 90 days (last pass: v5.10.155-cip21, first fail: v5.1=
0.162-cip24)

    2023-04-14T10:10:55.557748  + [    9.655705] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 1199973_1.5.2.4.1>
    2023-04-14T10:10:55.558057  set +x
    2023-04-14T10:10:55.664014  / # #
    2023-04-14T10:10:55.766070  export SHELL=3D/bin/sh
    2023-04-14T10:10:55.766545  #
    2023-04-14T10:10:55.867957  / # export SHELL=3D/bin/sh. /lava-1199973/e=
nvironment
    2023-04-14T10:10:55.868446  =

    2023-04-14T10:10:55.969934  / # . /lava-1199973/environment/lava-119997=
3/bin/lava-test-runner /lava-1199973/1
    2023-04-14T10:10:55.970699  =

    2023-04-14T10:10:55.973278  / # /lava-1199973/bin/lava-test-runner /lav=
a-1199973/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/643924fa9ececc75c62e85f0

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230407.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/643924fa9ececc75c62e85f5
        new failure (last pass: v5.10.176-cip30)

    2023-04-14T10:03:30.635773  + set +x

    2023-04-14T10:03:30.642014  <8>[   14.925934] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9975362_1.4.2.3.1>

    2023-04-14T10:03:30.746425  / # #

    2023-04-14T10:03:30.847358  export SHELL=3D/bin/sh

    2023-04-14T10:03:30.847537  #

    2023-04-14T10:03:30.948422  / # export SHELL=3D/bin/sh. /lava-9975362/e=
nvironment

    2023-04-14T10:03:30.948619  =


    2023-04-14T10:03:31.049558  / # . /lava-9975362/environment/lava-997536=
2/bin/lava-test-runner /lava-9975362/1

    2023-04-14T10:03:31.049860  =


    2023-04-14T10:03:31.054122  / # /lava-9975362/bin/lava-test-runner /lav=
a-9975362/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64392514a4c62ebe502e8601

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230407.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64392514a4c62ebe502e8606
        new failure (last pass: v5.10.176-cip30)

    2023-04-14T10:03:47.164491  <8>[   13.061513] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9975352_1.4.2.3.1>

    2023-04-14T10:03:47.167885  + set +x

    2023-04-14T10:03:47.273570  =


    2023-04-14T10:03:47.375601  / # #export SHELL=3D/bin/sh

    2023-04-14T10:03:47.376357  =


    2023-04-14T10:03:47.478023  / # export SHELL=3D/bin/sh. /lava-9975352/e=
nvironment

    2023-04-14T10:03:47.478240  =


    2023-04-14T10:03:47.579230  / # . /lava-9975352/environment/lava-997535=
2/bin/lava-test-runner /lava-9975352/1

    2023-04-14T10:03:47.579780  =


    2023-04-14T10:03:47.584866  / # /lava-9975352/bin/lava-test-runner /lav=
a-9975352/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/643923c55aa6d44ce62e8617

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230407.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/643923c55aa6d44ce62e861c
        failing since 90 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-04-14T09:58:21.604279  / # #

    2023-04-14T09:58:21.707297  export SHELL=3D/bin/sh

    2023-04-14T09:58:21.708135  #

    2023-04-14T09:58:21.810296  / # export SHELL=3D/bin/sh. /lava-9975271/e=
nvironment

    2023-04-14T09:58:21.811142  =


    2023-04-14T09:58:21.913258  / # . /lava-9975271/environment/lava-997527=
1/bin/lava-test-runner /lava-9975271/1

    2023-04-14T09:58:21.914650  =


    2023-04-14T09:58:21.927917  / # /lava-9975271/bin/lava-test-runner /lav=
a-9975271/1

    2023-04-14T09:58:22.033878  + export 'TESTRUN_ID=3D1_bootrr'

    2023-04-14T09:58:22.034590  + cd /lava-9975271/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6439266ae101c20c7d2e85ed

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandb=
oard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandb=
oard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230407.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6439266ae101c20c7d2e85f2
        failing since 90 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-04-14T10:09:40.794514  + set +x
    2023-04-14T10:09:40.794697  [   10.286505] <LAVA_SIGNAL_ENDRUN 0_dmesg =
926363_1.5.2.3.1>
    2023-04-14T10:09:40.902973  / # #
    2023-04-14T10:09:41.004639  export SHELL=3D/bin/sh
    2023-04-14T10:09:41.005125  #
    2023-04-14T10:09:41.106467  / # export SHELL=3D/bin/sh. /lava-926363/en=
vironment
    2023-04-14T10:09:41.106899  =

    2023-04-14T10:09:41.208317  / # . /lava-926363/environment/lava-926363/=
bin/lava-test-runner /lava-926363/1
    2023-04-14T10:09:41.208931  =

    2023-04-14T10:09:41.212022  / # /lava-926363/bin/lava-test-runner /lava=
-926363/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/643923865aa6d44ce62e85ea

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandbo=
ard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandbo=
ard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230407.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/643923865aa6d44ce62e85ef
        failing since 90 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-04-14T09:57:20.340855  + set[    7.123332] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 926356_1.5.2.3.1>
    2023-04-14T09:57:20.341112   +x
    2023-04-14T09:57:20.446683  / # #
    2023-04-14T09:57:20.548340  export SHELL=3D/bin/sh
    2023-04-14T09:57:20.548793  #
    2023-04-14T09:57:20.650081  / # export SHELL=3D/bin/sh. /lava-926356/en=
vironment
    2023-04-14T09:57:20.650581  =

    2023-04-14T09:57:20.752146  / # . /lava-926356/environment/lava-926356/=
bin/lava-test-runner /lava-926356/1
    2023-04-14T09:57:20.752730  =

    2023-04-14T09:57:20.755506  / # /lava-926356/bin/lava-test-runner /lava=
-926356/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6ul-14x14-evk             | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64392427295960fdad2e860c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx6ul-14x14-evk.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx6ul-14x14-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230407.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64392427295960fdad2e8611
        failing since 23 days (last pass: v5.10.145-cip17, first fail: v5.1=
0.175-cip29)

    2023-04-14T09:59:16.380463  + set +x
    2023-04-14T09:59:16.381594  <8>[   34.772895] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1199963_1.5.2.4.1>
    2023-04-14T09:59:16.490249  / # #
    2023-04-14T09:59:17.650365  export SHELL=3D/bin/sh
    2023-04-14T09:59:17.656060  #
    2023-04-14T09:59:17.656351  / # export SHELL=3D/bin/sh
    2023-04-14T09:59:19.203809  . /lava-1199963/environment
    2023-04-14T09:59:19.209502  / # . /lava-1199963/environment
    2023-04-14T09:59:22.031631  /lava-1199963/bin/lava-test-runner /lava-11=
99963/1
    2023-04-14T09:59:22.037678  / # /lava-1199963/bin/lava-test-runner /lav=
a-1199963/1 =

    ... (18 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/643923f500c4bf650b2e85f9

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230407.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/643923f500c4bf650b2e85fe
        failing since 90 days (last pass: v5.10.155-cip21, first fail: v5.1=
0.162-cip24)

    2023-04-14T09:58:51.803525  / # #
    2023-04-14T09:58:52.962825  export SHELL=3D/bin/sh
    2023-04-14T09:58:52.968326  #
    2023-04-14T09:58:54.515552  / # export SHELL=3D/bin/sh. /lava-1199961/e=
nvironment
    2023-04-14T09:58:54.521238  =

    2023-04-14T09:58:57.343644  / # . /lava-1199961/environment/lava-119996=
1/bin/lava-test-runner /lava-1199961/1
    2023-04-14T09:58:57.349460  =

    2023-04-14T09:58:57.360407  / # /lava-1199961/bin/lava-test-runner /lav=
a-1199961/1
    2023-04-14T09:58:57.447239  + export 'TESTRUN_ID=3D1_bootrr'
    2023-04-14T09:58:57.447820  + cd /lava-1199961/1/tests/1_bootrr =

    ... (18 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7ulp-evk                  | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/643923f86e439ed0572e85fd

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7ulp-evk.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7ulp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230407.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/643923f86e439ed0572e8602
        failing since 31 days (last pass: v5.10.155-cip21, first fail: v5.1=
0.173-cip28)

    2023-04-14T09:58:50.330004  + set +x<8>[   29.020220] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 1199962_1.5.2.4.1>
    2023-04-14T09:58:50.330191  =

    2023-04-14T09:58:50.438782  / # #
    2023-04-14T09:58:51.597579  export SHELL=3D/bin/sh
    2023-04-14T09:58:51.603000  #
    2023-04-14T09:58:51.603180  / # export SHELL=3D/bin/sh
    2023-04-14T09:58:53.149586  / # . /lava-1199962/environment
    2023-04-14T09:58:55.977077  /lava-1199962/bin/lava-test-runner /lava-11=
99962/1
    2023-04-14T09:58:55.983157  . /lava-1199962/environment
    2023-04-14T09:58:55.983439  / # /lava-1199962/bin/lava-test-runner /lav=
a-1199962/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/643929dae2cd334f612e85f3

  Results:     28 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt817=
3-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt817=
3-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230407.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/643929dae2cd334f612e860d
        failing since 90 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-04-14T10:24:16.989207  <8>[   15.632620] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-04-14T10:24:16.989888  + set +x

    2023-04-14T10:24:16.995370  <8>[   15.642329] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9975746_1.5.2.3.1>

    2023-04-14T10:24:17.100980  =


    2023-04-14T10:24:17.203244  / # #export SHELL=3D/bin/sh

    2023-04-14T10:24:17.204016  =


    2023-04-14T10:24:17.305654  / # export SHELL=3D/bin/sh. /lava-9975746/e=
nvironment

    2023-04-14T10:24:17.305878  =


    2023-04-14T10:24:17.407093  / # . /lava-9975746/environment/lava-997574=
6/bin/lava-test-runner /lava-9975746/1

    2023-04-14T10:24:17.408411  =

 =

    ... (17 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/643924fb16128328982e863e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230407.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/643924fb16128328982e8=
63f
        new failure (last pass: v5.10.176-cip30) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 4          =


  Details:     https://kernelci.org/test/plan/id/643923dd5d97699dcf2e860d

  Results:     63 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-j=
aq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-j=
aq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230407.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/643923dd5d97699dcf2e8639
        failing since 88 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-04-14T09:58:17.047427  + <8>[    9.705432] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 9975276_1.5.2.3.1>

    2023-04-14T09:58:17.049277  set +x

    2023-04-14T09:58:17.155599  =


    2023-04-14T09:58:17.257075  / # #export SHELL=3D/bin/sh

    2023-04-14T09:58:17.257502  =


    2023-04-14T09:58:17.358809  / # export SHELL=3D/bin/sh. /lava-9975276/e=
nvironment

    2023-04-14T09:58:17.359221  =


    2023-04-14T09:58:17.460546  / # . /lava-9975276/environment/lava-997527=
6/bin/lava-test-runner /lava-9975276/1

    2023-04-14T09:58:17.461208  =


    2023-04-14T09:58:17.463400  / # /lava-9975276/bin/lava-test-runner /lav=
a-9975276/1
 =

    ... (18 line(s) more)  =


  * baseline.bootrr.dwhdmi-rockchip-driver-i2c-present: https://kernelci.or=
g/test/case/id/643923dd5d97699dcf2e863d
        failing since 88 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-04-14T09:58:29.135803  FIRST,<8>[   21.785245] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>

    2023-04-14T09:58:29.138167   INC default to 1.

    2023-04-14T09:58:29.138773  =


    2023-04-14T09:58:29.142153  	-w	Pad to last with leading zeros

    2023-04-14T09:58:29.144724  	-s SEP	String separator

    2023-04-14T09:58:29.148331  /lava-9975276/1/../bin/lava-test-case

    2023-04-14T09:58:29.154386  BusyBox v1.31.1 (2023-04-07 11:10:08 UTC) m=
ulti-call binary.

    2023-04-14T09:58:29.154621  =

   =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/643923dd5d97699dcf2e863e
        failing since 88 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-04-14T09:58:29.113559  BusyBox v1.31.1 (2023-04-07 11:10:08 UTC)<8=
>[   21.766464] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-04-14T09:58:29.114651   multi-call binary.

    2023-04-14T09:58:29.115138  =


    2023-04-14T09:58:29.119310  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-04-14T09:58:29.119848  =


    2023-04-14T09:58:29.124474  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/643923dd5d97699dcf2e863f
        failing since 88 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-04-14T09:58:29.094371  <8>[   21.748905] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>
   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64392c1d56d2af004c2e85eb

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk339=
9-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk339=
9-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230407.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/64392c1d56d2af004c2e85f1
        failing since 23 days (last pass: v5.10.173-cip28, first fail: v5.1=
0.175-cip29)

    2023-04-14T10:33:50.217787  /lava-9975732/1/../bin/lava-test-case

    2023-04-14T10:33:50.229173  <8>[   62.148336] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/64392c1d56d2af004c2e85f2
        failing since 23 days (last pass: v5.10.173-cip28, first fail: v5.1=
0.175-cip29)

    2023-04-14T10:33:49.183428  /lava-9975732/1/../bin/lava-test-case

    2023-04-14T10:33:49.194722  <8>[   61.113352] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/643926d29f467658142e8663

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230407.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/643926d29f467658142e868f
        failing since 90 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-04-14T10:11:14.946405  + set +x
    2023-04-14T10:11:14.950446  <8>[   17.070561] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 327814_1.5.2.4.1>
    2023-04-14T10:11:15.061097  / # #
    2023-04-14T10:11:15.163038  export SHELL=3D/bin/sh
    2023-04-14T10:11:15.163572  #
    2023-04-14T10:11:15.264985  / # export SHELL=3D/bin/sh. /lava-327814/en=
vironment
    2023-04-14T10:11:15.265518  =

    2023-04-14T10:11:15.366953  / # . /lava-327814/environment/lava-327814/=
bin/lava-test-runner /lava-327814/1
    2023-04-14T10:11:15.367772  =

    2023-04-14T10:11:15.372166  / # /lava-327814/bin/lava-test-runner /lava=
-327814/1 =

    ... (12 line(s) more)  =

 =20

