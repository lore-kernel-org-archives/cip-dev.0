Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA1EEB64DD
	for <webhook@archiver.kernel.org>; Wed,  9 Aug 2023 05:40:34 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
 by mx.groups.io with SMTP id smtpd.web10.82185.1691559626227375174
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 08 Aug 2023 22:40:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=1gqoyaP/;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.179, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-686f94328a4so416947b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 08 Aug 2023 22:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691559625; x=1692164425;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RQwicp3A06W83bf2PpcrM8MjzbXIRJrbajbvc/0Bf6E=;
        b=1gqoyaP/BEXLjEDBh0jj2duwdBvNmcVdyRaLbkMEqrtDgGixRKv2B8RGaCTyC6tA9y
         RcoDd1CEG07wEfkoteI5e3zJl5vs+P6cKfc0L4U/nhfBSBjmTh7LsKwUpxs6Wiiug1/V
         JywFjbqhWt2G/+7W5mm+IMICpf4Ghs5MCNNdQhYzfJVXHArRYlBa5eHLbHKxKvg5LlUF
         kZ36+sKlk9Xdf44OVSk2/OKcmUGA1pH/yH+KS/ygZjz+tYhgF3BbIi4eKucclOzcQ8IN
         sm+uY/0fL41tZHORdOX7b4HrpXRm1et1qz1HBVH7nBlZzO8+fInOopdqFRqw2exV4UuE
         YmQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691559625; x=1692164425;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RQwicp3A06W83bf2PpcrM8MjzbXIRJrbajbvc/0Bf6E=;
        b=Het1efLS4wkzLFf2ONI4UsZbizYH3TQ3sjTYLtL4d8+y+Dok+Dt7F5c0Td7PrS+9KR
         mgzkPZ58kliWwLI63Wd6PgYK7R+oLunbIgr9nugumDb1Wff/mTzGya2naDkEFoMAH7wv
         CSPlQjJ3iYyxUF+bMRVbj9msDR9YdKS3SrtqxJq5xeDuHKfp5YeLIsCxDONrQ5gOE1gE
         XgiLLs6cxCa0Gjog0jWVmw3TR09JznsLmWMd8vQ9a3TchZ9H8zfVz7Een06glhXismxl
         aklEJg6sgu3NiVUukXakmH91m0gnV4jwU2ajFiqRXUGut7/uY5EEhim61bbSokBHhl9w
         TEow==
X-Gm-Message-State: AOJu0YyMHS8DVeBK5STp+f5e1MjZi2QptHPvES/7bVeNWYSwTPEkkYwy
	X8wJ1DOpem7fH2p5Ir0aRRcDFInoXtwxj34QnsVoVw==
X-Google-Smtp-Source: AGHT+IFKsQn38dVD4H0OjG0cWHndmg1OzuMgDJmWW9WIcNsUDRqKHU67w757eagV8rfeJ+GGK0uGpA==
X-Received: by 2002:a05:6a00:24d2:b0:67b:77e7:f467 with SMTP id d18-20020a056a0024d200b0067b77e7f467mr16000566pfv.16.1691559624150;
        Tue, 08 Aug 2023 22:40:24 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id g26-20020aa7875a000000b00682a9325ffcsm9022326pfo.5.2023.08.08.22.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 22:40:23 -0700 (PDT)
Message-ID: <64d326c7.a70a0220.6ee14.0ac1@mx.google.com>
Date: Tue, 08 Aug 2023 22:40:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.186-cip37-13-g260094841fe1a
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
Subject: cip/linux-5.10.y-cip baseline: 146 runs,
 41 regressions (v5.10.186-cip37-13-g260094841fe1a)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Aug 2023 05:40:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12579

cip/linux-5.10.y-cip baseline: 146 runs, 41 regressions (v5.10.186-cip37-13=
-g260094841fe1a)

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

bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | bcm283=
5_defconfig            | 1          =

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

fsl-ls1088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

fsl-ls2088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

fsl-lx2160a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
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

juno-uboot                   | arm64  | lab-broonie     | gcc-10   | cip://=
5.10.y-...64_defconfig | 1          =

juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig+kselftest          | 1          =

mt8173-elm-hana              | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip         | gcc-10   | defcon=
fig+kselftest          | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =

r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig+kselftest          | 1          =

r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 4          =

rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =

rk3399-rock-pi-4b            | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.186-cip37-13-g260094841fe1a/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.186-cip37-13-g260094841fe1a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      260094841fe1a0a9e5ab7b9ae32450e8e4e0a4f4 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d319e1deff29061135b20d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d319e1deff29061135b212
        failing since 207 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-09T04:45:01.347668  + set +x

    2023-08-09T04:45:01.354002  <8>[   12.042208] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11241451_1.4.2.3.1>

    2023-08-09T04:45:01.458798  / # #

    2023-08-09T04:45:01.559370  export SHELL=3D/bin/sh

    2023-08-09T04:45:01.559575  #

    2023-08-09T04:45:01.660109  / # export SHELL=3D/bin/sh. /lava-11241451/=
environment

    2023-08-09T04:45:01.660354  =


    2023-08-09T04:45:01.760854  / # . /lava-11241451/environment/lava-11241=
451/bin/lava-test-runner /lava-11241451/1

    2023-08-09T04:45:01.761127  =


    2023-08-09T04:45:01.767281  / # /lava-11241451/bin/lava-test-runner /la=
va-11241451/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d319d623c890537435b21d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d319d623c890537435b222
        failing since 207 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-09T04:45:01.415190  <8>[   11.649953] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-08-09T04:45:01.416377  + set +x

    2023-08-09T04:45:01.422508  <8>[   11.660683] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11241428_1.4.2.3.1>

    2023-08-09T04:45:01.527631  =


    2023-08-09T04:45:01.628248  / # #export SHELL=3D/bin/sh

    2023-08-09T04:45:01.628446  =


    2023-08-09T04:45:01.729032  / # export SHELL=3D/bin/sh. /lava-11241428/=
environment

    2023-08-09T04:45:01.729251  =


    2023-08-09T04:45:01.829848  / # . /lava-11241428/environment/lava-11241=
428/bin/lava-test-runner /lava-11241428/1

    2023-08-09T04:45:01.830198  =

 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64d319f10f2286a10c35b1fd

  Results:     47 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline=
-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline=
-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d319f10f2286a10c35b232
        failing since 207 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-09T04:45:03.522560  + set +x
    2023-08-09T04:45:03.527663  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 40168_1.5.2.=
4.1>
    2023-08-09T04:45:03.641412  / # #
    2023-08-09T04:45:03.744309  export SHELL=3D/bin/sh
    2023-08-09T04:45:03.745102  #
    2023-08-09T04:45:03.847046  / # export SHELL=3D/bin/sh. /lava-40168/env=
ironment
    2023-08-09T04:45:03.847872  =

    2023-08-09T04:45:03.949728  / # . /lava-40168/environment/lava-40168/bi=
n/lava-test-runner /lava-40168/1
    2023-08-09T04:45:03.951096  =

    2023-08-09T04:45:03.957570  / # /lava-40168/bin/lava-test-runner /lava-=
40168/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | bcm283=
5_defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/64d31ab1917ad32ed235b20d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm/bcm2835_defconfig/gcc-10/lab-collabora/baselin=
e-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm/bcm2835_defconfig/gcc-10/lab-collabora/baselin=
e-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d31ab1917ad32ed235b212
        failing since 14 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-08-09T04:50:12.635250  / # #

    2023-08-09T04:50:12.737404  export SHELL=3D/bin/sh

    2023-08-09T04:50:12.738107  #

    2023-08-09T04:50:12.839521  / # export SHELL=3D/bin/sh. /lava-11241491/=
environment

    2023-08-09T04:50:12.840228  =


    2023-08-09T04:50:12.941705  / # . /lava-11241491/environment/lava-11241=
491/bin/lava-test-runner /lava-11241491/1

    2023-08-09T04:50:12.942789  =


    2023-08-09T04:50:12.959419  / # /lava-11241491/bin/lava-test-runner /la=
va-11241491/1

    2023-08-09T04:50:13.023513  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-09T04:50:13.061478  + cd /lava-11241491/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64d3201dae9d34a3f835b244

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline=
-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline=
-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d3201eae9d34a3f835b26f
        failing since 207 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-09T05:11:25.034612  <8>[   22.790068] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 40230_1.5.2.4.1>
    2023-08-09T05:11:25.144680  / # #
    2023-08-09T05:11:25.248176  export SHELL=3D/bin/sh
    2023-08-09T05:11:25.248807  #
    2023-08-09T05:11:25.350270  / # export SHELL=3D/bin/sh. /lava-40230/env=
ironment
    2023-08-09T05:11:25.350963  =

    2023-08-09T05:11:25.452382  / # . /lava-40230/environment/lava-40230/bi=
n/lava-test-runner /lava-40230/1
    2023-08-09T05:11:25.453438  =

    2023-08-09T05:11:25.457868  / # /lava-40230/bin/lava-test-runner /lava-=
40230/1
    2023-08-09T05:11:25.551882  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64d32022ae9d34a3f835b277

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-bea=
glebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-bea=
glebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d32022ae9d34a3f835b27a
        failing since 207 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-09T05:11:20.526111  / # #
    2023-08-09T05:11:20.629470  export SHELL=3D/bin/sh
    2023-08-09T05:11:20.630464  #
    2023-08-09T05:11:20.732822  / # export SHELL=3D/bin/sh. /lava-994718/en=
vironment
    2023-08-09T05:11:20.733853  =

    2023-08-09T05:11:20.836072  / # . /lava-994718/environment/lava-994718/=
bin/lava-test-runner /lava-994718/1
    2023-08-09T05:11:20.837635  =

    2023-08-09T05:11:20.848682  / # /lava-994718/bin/lava-test-runner /lava=
-994718/1
    2023-08-09T05:11:20.974675  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-09T05:11:20.975312  + cd /lava-994718/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64d31dde20df41c22235b217

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm/omap2plus_defconfig/gcc-10/lab-broonie/baselin=
e-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm/omap2plus_defconfig/gcc-10/lab-broonie/baselin=
e-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d31dde20df41c22235b24a
        failing since 207 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-09T05:01:58.081890  <8>[   24.687380] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 40224_1.5.2.4.1>
    2023-08-09T05:01:58.191203  / # #
    2023-08-09T05:01:58.293888  export SHELL=3D/bin/sh
    2023-08-09T05:01:58.294580  #
    2023-08-09T05:01:58.396472  / # export SHELL=3D/bin/sh. /lava-40224/env=
ironment
    2023-08-09T05:01:58.397230  =

    2023-08-09T05:01:58.499250  / # . /lava-40224/environment/lava-40224/bi=
n/lava-test-runner /lava-40224/1
    2023-08-09T05:01:58.500442  =

    2023-08-09T05:01:58.504227  / # /lava-40224/bin/lava-test-runner /lava-=
40224/1
    2023-08-09T05:01:58.607875  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64d31dbc20df41c22235b1db

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-be=
aglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-be=
aglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d31dbc20df41c22235b1de
        failing since 207 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-09T05:01:31.211683  <8>[   13.022924] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 994712_1.5.2.4.1>
    2023-08-09T05:01:31.321375  / # #
    2023-08-09T05:01:31.424075  export SHELL=3D/bin/sh
    2023-08-09T05:01:31.424813  #
    2023-08-09T05:01:31.526684  / # export SHELL=3D/bin/sh. /lava-994712/en=
vironment
    2023-08-09T05:01:31.527391  =

    2023-08-09T05:01:31.629250  / # . /lava-994712/environment/lava-994712/=
bin/lava-test-runner /lava-994712/1
    2023-08-09T05:01:31.630330  =

    2023-08-09T05:01:31.637225  / # /lava-994712/bin/lava-test-runner /lava=
-994712/1
    2023-08-09T05:01:31.741842  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls1028a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d319d323c890537435b205

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1028=
a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1028=
a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d319d323c890537435b208
        failing since 148 days (last pass: v5.10.155-cip21, first fail: v5.=
10.173-cip28)

    2023-08-09T04:44:47.880114  + [   21.140529] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 1242015_1.5.2.4.1>
    2023-08-09T04:44:47.880403  set +x
    2023-08-09T04:44:47.985534  =

    2023-08-09T04:44:48.086691  / # #export SHELL=3D/bin/sh
    2023-08-09T04:44:48.087085  =

    2023-08-09T04:44:48.188050  / # export SHELL=3D/bin/sh. /lava-1242015/e=
nvironment
    2023-08-09T04:44:48.188450  =

    2023-08-09T04:44:48.289418  / # . /lava-1242015/environment/lava-124201=
5/bin/lava-test-runner /lava-1242015/1
    2023-08-09T04:44:48.290150  =

    2023-08-09T04:44:48.294277  / # /lava-1242015/bin/lava-test-runner /lav=
a-1242015/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls1088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d319cf5aa057cf0635b221

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1088=
a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1088=
a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d319cf5aa057cf0635b224
        failing since 207 days (last pass: v5.10.155-cip21, first fail: v5.=
10.162-cip24)

    2023-08-09T04:44:45.040437  [    9.743926] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1242014_1.5.2.4.1>
    2023-08-09T04:44:45.145886  =

    2023-08-09T04:44:45.247189  / # #export SHELL=3D/bin/sh
    2023-08-09T04:44:45.247626  =

    2023-08-09T04:44:45.348629  / # export SHELL=3D/bin/sh. /lava-1242014/e=
nvironment
    2023-08-09T04:44:45.349123  =

    2023-08-09T04:44:45.450151  / # . /lava-1242014/environment/lava-124201=
4/bin/lava-test-runner /lava-1242014/1
    2023-08-09T04:44:45.450898  =

    2023-08-09T04:44:45.454856  / # /lava-1242014/bin/lava-test-runner /lav=
a-1242014/1
    2023-08-09T04:44:45.470960  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls2088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d319cccfaafb67ef35b31e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088=
a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088=
a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d319cccfaafb67ef35b321
        failing since 27 days (last pass: v5.10.155-cip21, first fail: v5.1=
0.165-cip25)

    2023-08-09T04:44:50.221879  [   10.004712] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1242012_1.5.2.4.1>
    2023-08-09T04:44:50.327500  =

    2023-08-09T04:44:50.428795  / # #export SHELL=3D/bin/sh
    2023-08-09T04:44:50.429290  =

    2023-08-09T04:44:50.530254  / # export SHELL=3D/bin/sh. /lava-1242012/e=
nvironment
    2023-08-09T04:44:50.530728  =

    2023-08-09T04:44:50.631721  / # . /lava-1242012/environment/lava-124201=
2/bin/lava-test-runner /lava-1242012/1
    2023-08-09T04:44:50.632541  =

    2023-08-09T04:44:50.636542  / # /lava-1242012/bin/lava-test-runner /lav=
a-1242012/1
    2023-08-09T04:44:50.658475  + export 'TESTRUN_[   10.440548] <LAVA_SIGN=
AL_STARTRUN 1_bootrr 1242012_1.5.2.4.5> =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-lx2160a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d319b873f83b1bc235b260

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160=
a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160=
a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d319b873f83b1bc235b263
        failing since 139 days (last pass: v5.10.154-cip20, first fail: v5.=
10.175-cip29)

    2023-08-09T04:44:32.581450  [   10.376521] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1242013_1.5.2.4.1>
    2023-08-09T04:44:32.686678  =

    2023-08-09T04:44:32.787861  / # #export SHELL=3D/bin/sh
    2023-08-09T04:44:32.788263  =

    2023-08-09T04:44:32.889205  / # export SHELL=3D/bin/sh. /lava-1242013/e=
nvironment
    2023-08-09T04:44:32.889608  =

    2023-08-09T04:44:32.990571  / # . /lava-1242013/environment/lava-124201=
3/bin/lava-test-runner /lava-1242013/1
    2023-08-09T04:44:32.991251  =

    2023-08-09T04:44:32.995201  / # /lava-1242013/bin/lava-test-runner /lav=
a-1242013/1
    2023-08-09T04:44:33.010206  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d31a88cf103ec92935b1ff

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d31a88cf103ec92935b204
        failing since 116 days (last pass: v5.10.176-cip30, first fail: v5.=
10.177-cip31)

    2023-08-09T04:47:50.596776  + <8>[    8.154020] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11241441_1.4.2.3.1>

    2023-08-09T04:47:50.596887  set +x

    2023-08-09T04:47:50.698147  #

    2023-08-09T04:47:50.698475  =


    2023-08-09T04:47:50.799172  / # #export SHELL=3D/bin/sh

    2023-08-09T04:47:50.799353  =


    2023-08-09T04:47:50.899950  / # export SHELL=3D/bin/sh. /lava-11241441/=
environment

    2023-08-09T04:47:50.900112  =


    2023-08-09T04:47:51.000648  / # . /lava-11241441/environment/lava-11241=
441/bin/lava-test-runner /lava-11241441/1

    2023-08-09T04:47:51.000905  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d31a30f23835d6fe35b23e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d31a30f23835d6fe35b243
        failing since 116 days (last pass: v5.10.176-cip30, first fail: v5.=
10.177-cip31)

    2023-08-09T04:46:03.569544  + set +x

    2023-08-09T04:46:03.575887  <8>[   13.057212] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11241438_1.4.2.3.1>

    2023-08-09T04:46:03.683783  / # #

    2023-08-09T04:46:03.786526  export SHELL=3D/bin/sh

    2023-08-09T04:46:03.787424  #

    2023-08-09T04:46:03.889118  / # export SHELL=3D/bin/sh. /lava-11241438/=
environment

    2023-08-09T04:46:03.890020  =


    2023-08-09T04:46:03.991673  / # . /lava-11241438/environment/lava-11241=
438/bin/lava-test-runner /lava-11241438/1

    2023-08-09T04:46:03.993194  =


    2023-08-09T04:46:03.999073  / # /lava-11241438/bin/lava-test-runner /la=
va-11241438/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64d3200a705aa050fd35b1d9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d3200a705aa050fd35b1de
        failing since 207 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-09T05:11:31.249951  / # #

    2023-08-09T05:11:31.352484  export SHELL=3D/bin/sh

    2023-08-09T05:11:31.353205  #

    2023-08-09T05:11:31.455234  / # export SHELL=3D/bin/sh. /lava-11241741/=
environment

    2023-08-09T05:11:31.456081  =


    2023-08-09T05:11:31.557786  / # . /lava-11241741/environment/lava-11241=
741/bin/lava-test-runner /lava-11241741/1

    2023-08-09T05:11:31.558953  =


    2023-08-09T05:11:31.573645  / # /lava-11241741/bin/lava-test-runner /la=
va-11241741/1

    2023-08-09T05:11:31.684643  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-09T05:11:31.685173  + cd /lava-11241741/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64d31aab917ad32ed235b202

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/bas=
eline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/bas=
eline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d31aab917ad32ed235b207
        failing since 207 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-09T04:48:19.284531  + set +x
    2023-08-09T04:48:19.284745  [   10.309474] <LAVA_SIGNAL_ENDRUN 0_dmesg =
997486_1.5.2.3.1>
    2023-08-09T04:48:19.392675  / # #
    2023-08-09T04:48:19.494527  export SHELL=3D/bin/sh
    2023-08-09T04:48:19.495110  #
    2023-08-09T04:48:19.596480  / # export SHELL=3D/bin/sh. /lava-997486/en=
vironment
    2023-08-09T04:48:19.597018  =

    2023-08-09T04:48:19.698452  / # . /lava-997486/environment/lava-997486/=
bin/lava-test-runner /lava-997486/1
    2023-08-09T04:48:19.699126  =

    2023-08-09T04:48:19.702198  / # /lava-997486/bin/lava-test-runner /lava=
-997486/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64d31fc03206e5512635b1da

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/base=
line-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/base=
line-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d31fc13206e5512635b1df
        failing since 207 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-09T05:10:17.787429  + set[    7.249778] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 997495_1.5.2.3.1>
    2023-08-09T05:10:17.787597   +x
    2023-08-09T05:10:17.893100  / # #
    2023-08-09T05:10:17.994713  export SHELL=3D/bin/sh
    2023-08-09T05:10:17.995176  #
    2023-08-09T05:10:18.096359  / # export SHELL=3D/bin/sh. /lava-997495/en=
vironment
    2023-08-09T05:10:18.096795  =

    2023-08-09T05:10:18.198003  / # . /lava-997495/environment/lava-997495/=
bin/lava-test-runner /lava-997495/1
    2023-08-09T05:10:18.198635  =

    2023-08-09T05:10:18.201399  / # /lava-997495/bin/lava-test-runner /lava=
-997495/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6ul-14x14-evk             | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64d32036705aa050fd35b1f7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx=
6ul-14x14-evk.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx=
6ul-14x14-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d32036705aa050fd35b1fa
        failing since 139 days (last pass: v5.10.145-cip17, first fail: v5.=
10.175-cip29)

    2023-08-09T05:12:04.430617  + set +x
    2023-08-09T05:12:04.433784  <8>[   30.033036] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1242030_1.5.2.4.1>
    2023-08-09T05:12:04.542051  / # #
    2023-08-09T05:12:05.698143  export SHELL=3D/bin/sh
    2023-08-09T05:12:05.703756  #
    2023-08-09T05:12:07.245972  / # export SHELL=3D/bin/sh. /lava-1242030/e=
nvironment
    2023-08-09T05:12:07.251627  =

    2023-08-09T05:12:10.063857  / # . /lava-1242030/environment/lava-124203=
0/bin/lava-test-runner /lava-1242030/1
    2023-08-09T05:12:10.069884  =

    2023-08-09T05:12:10.071616  / # /lava-1242030/bin/lava-test-runner /lav=
a-1242030/1 =

    ... (18 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64d32033ae9d34a3f835b2ad

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx=
7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx=
7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d32033ae9d34a3f835b2b0
        failing since 207 days (last pass: v5.10.155-cip21, first fail: v5.=
10.162-cip24)

    2023-08-09T05:11:51.916851  / # #
    2023-08-09T05:11:53.073551  export SHELL=3D/bin/sh
    2023-08-09T05:11:53.079243  #
    2023-08-09T05:11:54.621614  / # export SHELL=3D/bin/sh. /lava-1242029/e=
nvironment
    2023-08-09T05:11:54.627277  =

    2023-08-09T05:11:54.627647  / # . /lava-1242029/environment
    2023-08-09T05:11:57.440223  / # /lava-1242029/bin/lava-test-runner /lav=
a-1242029/1
    2023-08-09T05:11:57.457170  /lava-1242029/bin/lava-test-runner /lava-12=
42029/1
    2023-08-09T05:11:57.546013  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-09T05:11:57.546399  + cd /lava-1242029/1/tests/1_bootrr =

    ... (19 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7ulp-evk                  | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64d32037ae9d34a3f835b2bb

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx=
7ulp-evk.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx=
7ulp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d32037ae9d34a3f835b2be
        failing since 148 days (last pass: v5.10.155-cip21, first fail: v5.=
10.173-cip28)

    2023-08-09T05:12:06.527351  + set +x<8>[   29.041237] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 1242032_1.5.2.4.1>
    2023-08-09T05:12:06.527650  =

    2023-08-09T05:12:06.635427  / # #
    2023-08-09T05:12:07.791272  export SHELL=3D/bin/sh
    2023-08-09T05:12:07.796849  #
    2023-08-09T05:12:07.797143  / # export SHELL=3D/bin/sh
    2023-08-09T05:12:09.339217  / # . /lava-1242032/environment
    2023-08-09T05:12:12.156821  /lava-1242032/bin/lava-test-runner /lava-12=
42032/1
    2023-08-09T05:12:12.162781  . /lava-1242032/environment
    2023-08-09T05:12:12.163000  / # /lava-1242032/bin/lava-test-runner /lav=
a-1242032/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
juno-uboot                   | arm64  | lab-broonie     | gcc-10   | cip://=
5.10.y-...64_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/64d31c36f56d86875735b1d9

  Results:     47 PASS, 13 FAIL, 1 SKIP
  Full config: cip://5.10.y-cip/arm64/qemu_arm64_defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm64/cip---5.10.y-cip-arm64-qemu_arm64_defconfig/=
gcc-10/lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm64/cip---5.10.y-cip-arm64-qemu_arm64_defconfig/=
gcc-10/lab-broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d31c36f56d86875735b214
        failing since 14 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-08-09T04:54:40.813226  / # #
    2023-08-09T04:54:40.916176  export SHELL=3D/bin/sh
    2023-08-09T04:54:40.917008  #
    2023-08-09T04:54:41.018997  / # export SHELL=3D/bin/sh. /lava-40209/env=
ironment
    2023-08-09T04:54:41.019836  =

    2023-08-09T04:54:41.121711  / # . /lava-40209/environment/lava-40209/bi=
n/lava-test-runner /lava-40209/1
    2023-08-09T04:54:41.123062  =

    2023-08-09T04:54:41.137282  / # /lava-40209/bin/lava-test-runner /lava-=
40209/1
    2023-08-09T04:54:41.193028  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-09T04:54:41.193564  + cd /lava-40209/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d31a19c67590cead35b1d9

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-u=
boot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-u=
boot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d31a19c67590cead35b210
        failing since 14 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-08-09T04:45:50.640480  / # #
    2023-08-09T04:45:50.743455  export SHELL=3D/bin/sh
    2023-08-09T04:45:50.744240  #
    2023-08-09T04:45:50.846171  / # export SHELL=3D/bin/sh. /lava-40166/env=
ironment
    2023-08-09T04:45:50.846919  =

    2023-08-09T04:45:50.948984  / # . /lava-40166/environment/lava-40166/bi=
n/lava-test-runner /lava-40166/1
    2023-08-09T04:45:50.950280  =

    2023-08-09T04:45:50.964065  / # /lava-40166/bin/lava-test-runner /lava-=
40166/1
    2023-08-09T04:45:51.022952  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-09T04:45:51.023507  + cd /lava-40166/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64d31b1e2e2b9cfaa335b240

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm64/defconfig+kselftest/gcc-10/lab-broonie/basel=
ine-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm64/defconfig+kselftest/gcc-10/lab-broonie/basel=
ine-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d31b1e2e2b9cfaa335b27c
        failing since 14 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-08-09T04:50:16.019505  <8>[   18.119786] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 40179_1.5.2.4.1>
    2023-08-09T04:50:16.128659  / # #
    2023-08-09T04:50:16.231094  export SHELL=3D/bin/sh
    2023-08-09T04:50:16.231722  #
    2023-08-09T04:50:16.333152  / # export SHELL=3D/bin/sh. /lava-40179/env=
ironment
    2023-08-09T04:50:16.333658  =

    2023-08-09T04:50:16.435212  / # . /lava-40179/environment/lava-40179/bi=
n/lava-test-runner /lava-40179/1
    2023-08-09T04:50:16.436639  =

    2023-08-09T04:50:16.442772  / # /lava-40179/bin/lava-test-runner /lava-=
40179/1
    2023-08-09T04:50:16.629503  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d31dd2cdd03cb6a935b1e4

  Results:     28 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm64/defconfig+arm64-chromebook/gcc-10/lab-collab=
ora/baseline-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm64/defconfig+arm64-chromebook/gcc-10/lab-collab=
ora/baseline-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d31dd2cdd03cb6a935b200
        failing since 207 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-09T05:01:58.486825  + set +x

    2023-08-09T05:01:58.492828  <8>[   15.643154] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11241647_1.5.2.3.1>

    2023-08-09T05:01:58.596852  =


    2023-08-09T05:01:58.697466  / # #export SHELL=3D/bin/sh

    2023-08-09T05:01:58.697691  =


    2023-08-09T05:01:58.798257  / # export SHELL=3D/bin/sh. /lava-11241647/=
environment

    2023-08-09T05:01:58.798465  =


    2023-08-09T05:01:58.899010  / # . /lava-11241647/environment/lava-11241=
647/bin/lava-test-runner /lava-11241647/1

    2023-08-09T05:01:58.899295  =


    2023-08-09T05:01:58.901361  / # /lava-11241647/bin/lava-test-runner /la=
va-11241647/1
 =

    ... (21 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64d31a11bd7807fbef35b1eb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a=
7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a=
7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d31a11bd7807fbef35b=
1ec
        failing since 64 days (last pass: v5.10.180-cip34, first fail: v5.1=
0.180-cip34-19-gf0f6960f132cd) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d319e81f46154f7235b1d9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774a1-h=
ihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774a1-h=
ihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d319e81f46154f7235b1dc
        new failure (last pass: v5.10.182-cip35-1-g7cde3fba93966)

    2023-08-09T04:45:04.971309  + set +x
    2023-08-09T04:45:04.974642  <8>[   83.807381] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 994686_1.5.2.4.1>
    2023-08-09T04:45:05.082621  / # #
    2023-08-09T04:45:06.546592  export SHELL=3D/bin/sh
    2023-08-09T04:45:06.567545  #
    2023-08-09T04:45:06.567996  / # export SHELL=3D/bin/sh
    2023-08-09T04:45:08.454672  / # . /lava-994686/environment
    2023-08-09T04:45:11.915157  /lava-994686/bin/lava-test-runner /lava-994=
686/1
    2023-08-09T04:45:11.936660  . /lava-994686/environment
    2023-08-09T04:45:11.937079  / # /lava-994686/bin/lava-test-runner /lava=
-994686/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip         | gcc-10   | defcon=
fig+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64d31a96f3c53f132d35b1f3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-=
r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-=
r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d31a96f3c53f132d35b1f6
        new failure (last pass: v5.10.182-cip35)

    2023-08-09T04:47:51.434049  + set +x
    2023-08-09T04:47:51.434626  <8>[   87.502441] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 994695_1.5.2.4.1>
    2023-08-09T04:47:51.545132  #
    2023-08-09T04:47:53.015855  / # #export SHELL=3D/bin/sh
    2023-08-09T04:47:53.037112  =

    2023-08-09T04:47:53.037728  / # export SHELL=3D/bin/sh
    2023-08-09T04:47:54.932232  / # . /lava-994695/environment
    2023-08-09T04:47:58.407165  /lava-994695/bin/lava-test-runner /lava-994=
695/1
    2023-08-09T04:47:58.429206  . /lava-994695/environment
    2023-08-09T04:47:58.429659  / # /lava-994695/bin/lava-test-runner /lava=
-994695/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d31e35bc676b989435b387

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ba=
seline-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ba=
seline-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d31e35bc676b989435b38a
        failing since 14 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-08-09T05:03:35.890444  + set +x
    2023-08-09T05:03:35.890664  <8>[   83.771568] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 994706_1.5.2.4.1>
    2023-08-09T05:03:35.996770  / # #
    2023-08-09T05:03:37.458482  export SHELL=3D/bin/sh
    2023-08-09T05:03:37.479359  #
    2023-08-09T05:03:37.479732  / # export SHELL=3D/bin/sh
    2023-08-09T05:03:39.364567  / # . /lava-994706/environment
    2023-08-09T05:03:42.818784  /lava-994706/bin/lava-test-runner /lava-994=
706/1
    2023-08-09T05:03:42.839350  . /lava-994706/environment
    2023-08-09T05:03:42.839445  / # /lava-994706/bin/lava-test-runner /lava=
-994706/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d31e71ec3dc36ef935b210

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ba=
seline-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ba=
seline-r8a774b1-hihope-rzg2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d31e71ec3dc36ef935b213
        failing since 14 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-08-09T05:04:25.645887  + set +x
    2023-08-09T05:04:25.646115  <8>[   83.980856] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 994710_1.5.2.4.1>
    2023-08-09T05:04:25.751545  / # #
    2023-08-09T05:04:27.213894  export SHELL=3D/bin/sh
    2023-08-09T05:04:27.234478  #
    2023-08-09T05:04:27.234686  / # export SHELL=3D/bin/sh
    2023-08-09T05:04:29.119242  / # . /lava-994710/environment
    2023-08-09T05:04:32.576332  /lava-994710/bin/lava-test-runner /lava-994=
710/1
    2023-08-09T05:04:32.597087  . /lava-994710/environment
    2023-08-09T05:04:32.597198  / # /lava-994710/bin/lava-test-runner /lava=
-994710/1 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d31a13bc42d3d70035b20f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-e=
k874.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-e=
k874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d31a13bc42d3d70035b212
        failing since 14 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-08-09T04:45:45.342206  / # #
    2023-08-09T04:45:46.801232  export SHELL=3D/bin/sh
    2023-08-09T04:45:46.821657  #
    2023-08-09T04:45:46.821794  / # export SHELL=3D/bin/sh
    2023-08-09T04:45:48.703069  / # . /lava-994688/environment
    2023-08-09T04:45:52.154343  /lava-994688/bin/lava-test-runner /lava-994=
688/1
    2023-08-09T04:45:52.174957  . /lava-994688/environment
    2023-08-09T04:45:52.175065  / # /lava-994688/bin/lava-test-runner /lava=
-994688/1
    2023-08-09T04:45:52.206324  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-09T04:45:52.254446  + cd /lava-994688/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64d31b292e2b9cfaa335b282

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-=
r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-=
r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d31b292e2b9cfaa335b285
        failing since 14 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-08-09T04:50:20.100853  / # #
    2023-08-09T04:50:21.562205  export SHELL=3D/bin/sh
    2023-08-09T04:50:21.582724  #
    2023-08-09T04:50:21.582917  / # export SHELL=3D/bin/sh
    2023-08-09T04:50:23.465109  / # . /lava-994696/environment
    2023-08-09T04:50:26.919467  /lava-994696/bin/lava-test-runner /lava-994=
696/1
    2023-08-09T04:50:26.940207  . /lava-994696/environment
    2023-08-09T04:50:26.940332  / # /lava-994696/bin/lava-test-runner /lava=
-994696/1
    2023-08-09T04:50:27.122216  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-09T04:50:27.122441  + cd /lava-994696/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d31e71524f6afbba35b1d9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ba=
seline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ba=
seline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d31e71524f6afbba35b1dc
        failing since 14 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-08-09T05:04:23.948115  / # #
    2023-08-09T05:04:25.410519  export SHELL=3D/bin/sh
    2023-08-09T05:04:25.431093  #
    2023-08-09T05:04:25.431301  / # export SHELL=3D/bin/sh
    2023-08-09T05:04:27.316363  / # . /lava-994707/environment
    2023-08-09T05:04:30.774256  /lava-994707/bin/lava-test-runner /lava-994=
707/1
    2023-08-09T05:04:30.795046  . /lava-994707/environment
    2023-08-09T05:04:30.795159  / # /lava-994707/bin/lava-test-runner /lava=
-994707/1
    2023-08-09T05:04:30.827272  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-09T05:04:30.876399  + cd /lava-994707/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 4          =


  Details:     https://kernelci.org/test/plan/id/64d32016ae9d34a3f835b1ed

  Results:     63 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-i2c-present: https://kernelci.or=
g/test/case/id/64d32016ae9d34a3f835b21c
        failing since 205 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-09T05:13:04.412337   INC default to 1.

    2023-08-09T05:13:04.412570  =


    2023-08-09T05:13:04.416042  	-w	Pad to last with leading zeros

    2023-08-09T05:13:04.418658  	-s SEP	String separator

    2023-08-09T05:13:04.422593  /lava-11241737/1/../bin/lava-test-case

    2023-08-09T05:13:04.428452  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.

    2023-08-09T05:13:04.428684  =

   =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/64d32016ae9d34a3f835b21d
        failing since 205 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-09T05:13:04.384513  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC)<8=
>[   18.481413] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-08-09T05:13:04.388250   multi-call binary.

    2023-08-09T05:13:04.388470  =


    2023-08-09T05:13:04.393001  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-08-09T05:13:04.393223  =


    2023-08-09T05:13:04.398079  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-08-09T05:13:04.408530  FIRST,<8>[   18.500686] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/64d32016ae9d34a3f835b21e
        failing since 205 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-09T05:13:04.365641  /lava-11241737/1/../bin/lava-test-case<8>[ =
  18.463836] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-probed RE=
SULT=3Dpass>

    2023-08-09T05:13:04.365691  =

   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d32016ae9d34a3f835b232
        failing since 205 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-09T05:12:52.304591  <8>[    6.402602] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-08-09T05:12:52.314441  + <8>[    6.415196] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11241737_1.5.2.3.1>

    2023-08-09T05:12:52.314840  set +x

    2023-08-09T05:12:52.420544  #

    2023-08-09T05:12:52.421705  =


    2023-08-09T05:12:52.523377  / # #export SHELL=3D/bin/sh

    2023-08-09T05:12:52.524070  =


    2023-08-09T05:12:52.625559  / # export SHELL=3D/bin/sh. /lava-11241737/=
environment

    2023-08-09T05:12:52.626261  =


    2023-08-09T05:12:52.727753  / # . /lava-11241737/environment/lava-11241=
737/bin/lava-test-runner /lava-11241737/1
 =

    ... (20 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64d31e20bc676b989435b32c

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm64/defconfig+arm64-chromebook/gcc-10/lab-collab=
ora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm64/defconfig+arm64-chromebook/gcc-10/lab-collab=
ora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/64d31e20bc676b989435b332
        failing since 139 days (last pass: v5.10.173-cip28, first fail: v5.=
10.175-cip29)

    2023-08-09T05:03:53.563220  /lava-11241653/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/64d31e20bc676b989435b333
        failing since 139 days (last pass: v5.10.173-cip28, first fail: v5.=
10.175-cip29)

    2023-08-09T05:03:51.500549  <8>[   32.910034] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-08-09T05:03:52.526187  /lava-11241653/1/../bin/lava-test-case

    2023-08-09T05:03:52.537152  <8>[   33.947445] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d31a78a5199bb99235b1e5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm64/defconfig/gcc-10/lab-collabora/baseline-rk33=
99-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm64/defconfig/gcc-10/lab-collabora/baseline-rk33=
99-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d31a78a5199bb99235b=
1e6
        new failure (last pass: v5.10.186-cip37-12-g2710acbceb751) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d3196d5b8ceb066235b25d

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i=
-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i=
-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d3196d5b8ceb066235b289
        failing since 207 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-09T04:43:11.019344  <8>[   17.104359] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 40146_1.5.2.4.1>
    2023-08-09T04:43:11.130873  / # #
    2023-08-09T04:43:11.233899  export SHELL=3D/bin/sh
    2023-08-09T04:43:11.234657  #
    2023-08-09T04:43:11.336993  / # export SHELL=3D/bin/sh. /lava-40146/env=
ironment
    2023-08-09T04:43:11.337717  =

    2023-08-09T04:43:11.439823  / # . /lava-40146/environment/lava-40146/bi=
n/lava-test-runner /lava-40146/1
    2023-08-09T04:43:11.440957  =

    2023-08-09T04:43:11.445350  / # /lava-40146/bin/lava-test-runner /lava-=
40146/1
    2023-08-09T04:43:11.490239  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d3199bd7fb2364d935b1da

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm64/defconfig/gcc-10/lab-collabora/baseline-sun5=
0i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/arm64/defconfig/gcc-10/lab-collabora/baseline-sun5=
0i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d3199bd7fb2364d935b1df
        failing since 14 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-08-09T04:45:06.916323  / # #

    2023-08-09T04:45:07.018286  export SHELL=3D/bin/sh

    2023-08-09T04:45:07.018514  #

    2023-08-09T04:45:07.119094  / # export SHELL=3D/bin/sh. /lava-11241405/=
environment

    2023-08-09T04:45:07.119336  =


    2023-08-09T04:45:07.220078  / # . /lava-11241405/environment/lava-11241=
405/bin/lava-test-runner /lava-11241405/1

    2023-08-09T04:45:07.221149  =


    2023-08-09T04:45:07.224200  / # /lava-11241405/bin/lava-test-runner /la=
va-11241405/1

    2023-08-09T04:45:07.265477  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-09T04:45:07.298269  + cd /lava-1124140<8>[   18.319679] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11241405_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

