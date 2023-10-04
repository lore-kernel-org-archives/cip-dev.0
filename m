Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE671E7B5F9
	for <webhook@archiver.kernel.org>; Wed,  4 Oct 2023 11:53:00 +0000 (UTC)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
 by mx.groups.io with SMTP id smtpd.web11.16290.1696420380293631332
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 04 Oct 2023 04:53:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=J4sTNtpM;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.49, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2791747288cso1400983a91.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 04 Oct 2023 04:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696420379; x=1697025179; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qkpkUe6XxLrWhyG0C4ejwIgxU4pYOty67L3DkWBFHHU=;
        b=J4sTNtpMoL4//uKrHPrMXpfADAgPGYyfUfH0iOuUbhCOOM3zSfJTsCZuynu+to5slf
         ihe3Biesib43uP+AwqLvJi5zitqH6K8lrPe1lXqoU9r+hCIENPYMXjWCUPkITz4OKq0w
         BIXHYGYVkrfwEs+YUcfnRydzduVsLdNJZUlwCfjeCouHizqlaIT9JcUwuWiajnQyYXgK
         6WB2LkKTxf0jrAb4vkH05QimssZ3+kNi5MKReLqKJONDWp+JLCExUceH4v8v2aDeVIu6
         kL8PPqwgRg0i1wuHm4Z0cvNQ5AWG9vEyilY0Dxc4snzdyjz9JgWYz819uS/MwnGUQIkF
         t7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696420379; x=1697025179;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qkpkUe6XxLrWhyG0C4ejwIgxU4pYOty67L3DkWBFHHU=;
        b=vybk2TKGsJrynWPHiYXe2B/5fIaMmTg4Ibcu4GuxSQx1wmh3kgrMc4qtPv+SAuIY89
         59zCapYgeEcGhcfE4gySVhbYU2kkDLsidF4DRtK1NS8wFDGJuHxrZDqzitHfJYc6rROW
         1xB3GiwTaGmUBCSszB9gkqrm0msNNWaebTBNJ+luPW1PC191JHI6LYesaVadStRb0dPo
         /DKFz+X6awQ8RIMA0DXSm2Ale6AMCgAJmgJLR3LQyBT4uR4vyEXaxX8RDEn/C3txFyR1
         H8kHDfIW0QgiwfE7Ig2Is03Hh4wC1igBCH8Bl/ObIhkPDlG/msBNft8l7IFEiRwR2t9e
         37bg==
X-Gm-Message-State: AOJu0YwbQlGiDZH+I7fK+wz8iwRD0Zw2DjY7uaDeQaQ6zLGzV79MJUYM
	LkcBj4PAcbJBiz5g2/o3kcg2QYlLJWoJS5A/rB2TAw==
X-Google-Smtp-Source: AGHT+IH1m9FWpbG0bkEVDH8fNplQnFbzgfXhqX42Zr/Zj7dI5FCw3oxMlDgG72Bpx28RveD+Kd0eVw==
X-Received: by 2002:a17:90b:4f44:b0:26d:5cd0:979f with SMTP id pj4-20020a17090b4f4400b0026d5cd0979fmr1928962pjb.43.1696420377904;
        Wed, 04 Oct 2023 04:52:57 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x18-20020a17090aa39200b002609cadc56esm1351640pjp.11.2023.10.04.04.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 04:52:57 -0700 (PDT)
Message-ID: <651d5219.170a0220.7d58c.2801@mx.google.com>
Date: Wed, 04 Oct 2023 04:52:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.194-cip39-1-g53e59f50ca3ff
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip baseline: 137 runs,
 39 regressions (v5.10.194-cip39-1-g53e59f50ca3ff)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Oct 2023 11:53:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13278

cip/linux-5.10.y-cip baseline: 137 runs, 39 regressions (v5.10.194-cip39-1-=
g53e59f50ca3ff)

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

beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =

fsl-ls1028a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

fsl-ls1028a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig+kselftest          | 1          =

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

juno-uboot                   | arm64  | lab-broonie     | gcc-10   | cip://=
5.10.y-...64_defconfig | 1          =

juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig+kselftest          | 1          =

kontron-kbox-a-230-ls        | arm64  | lab-kontron     | gcc-10   | defcon=
fig+kselftest          | 1          =

kontron-sl28-var3-ads2       | arm64  | lab-kontron     | gcc-10   | defcon=
fig+kselftest          | 1          =

meson-g12b-a311d-khadas-vim3 | arm64  | lab-collabora   | gcc-10   | defcon=
fig+kselftest          | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig+kselftest          | 1          =

mt8173-elm-hana              | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =

r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =

r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig+kselftest          | 1          =

r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

r8a77960-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

r8a77960-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig+kselftest          | 1          =

rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 4          =

rk3399-rock-pi-4b            | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig+kselftest          | 1          =

sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig+kselftest          | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.194-cip39-1-g53e59f50ca3ff/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.194-cip39-1-g53e59f50ca3ff
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      53e59f50ca3ff023b612a48397ad7e057a9fd408 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/651d4ae47a35402b538a0a76

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651d4ae47a35402b538a0a7f
        failing since 263 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-10-04T11:21:52.620488  + set +x

    2023-10-04T11:21:52.627382  <8>[   11.946543] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11676178_1.4.2.3.1>

    2023-10-04T11:21:52.734772  / # #

    2023-10-04T11:21:52.836981  export SHELL=3D/bin/sh

    2023-10-04T11:21:52.837671  #

    2023-10-04T11:21:52.939199  / # export SHELL=3D/bin/sh. /lava-11676178/=
environment

    2023-10-04T11:21:52.939950  =


    2023-10-04T11:21:53.041309  / # . /lava-11676178/environment/lava-11676=
178/bin/lava-test-runner /lava-11676178/1

    2023-10-04T11:21:53.042645  =


    2023-10-04T11:21:53.047491  / # /lava-11676178/bin/lava-test-runner /la=
va-11676178/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/651d4ae57a35402b538a0a81

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651d4ae57a35402b538a0a8a
        failing since 263 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-10-04T11:21:57.445962  + set<8>[   11.646566] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11676235_1.4.2.3.1>

    2023-10-04T11:21:57.446051   +x

    2023-10-04T11:21:57.550755  / # #

    2023-10-04T11:21:57.651409  export SHELL=3D/bin/sh

    2023-10-04T11:21:57.651615  #

    2023-10-04T11:21:57.752174  / # export SHELL=3D/bin/sh. /lava-11676235/=
environment

    2023-10-04T11:21:57.752406  =


    2023-10-04T11:21:57.852952  / # . /lava-11676235/environment/lava-11676=
235/bin/lava-test-runner /lava-11676235/1

    2023-10-04T11:21:57.853283  =


    2023-10-04T11:21:57.858088  / # /lava-11676235/bin/lava-test-runner /la=
va-11676235/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/651d4a8d72d66f4b808a0a61

  Results:     47 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-=
at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-=
at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651d4a8e72d66f4b808a0a9a
        failing since 263 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-10-04T11:20:21.188614  + set +x
    2023-10-04T11:20:21.189080  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 152336_1.5.2=
.4.1>
    2023-10-04T11:20:21.302541  / # #
    2023-10-04T11:20:21.405714  export SHELL=3D/bin/sh
    2023-10-04T11:20:21.406599  #
    2023-10-04T11:20:21.508518  / # export SHELL=3D/bin/sh. /lava-152336/en=
vironment
    2023-10-04T11:20:21.509297  =

    2023-10-04T11:20:21.611399  / # . /lava-152336/environment/lava-152336/=
bin/lava-test-runner /lava-152336/1
    2023-10-04T11:20:21.612809  =

    2023-10-04T11:20:21.616445  / # /lava-152336/bin/lava-test-runner /lava=
-152336/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | bcm283=
5_defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/651d47efcea7d033918a0a61

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm/bcm2835_defconfig/gcc-10/lab-collabora/baseline=
-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm/bcm2835_defconfig/gcc-10/lab-collabora/baseline=
-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651d47efcea7d033918a0a6a
        failing since 70 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-10-04T11:13:34.348534  / # #

    2023-10-04T11:13:34.450572  export SHELL=3D/bin/sh

    2023-10-04T11:13:34.451408  #

    2023-10-04T11:13:34.553105  / # export SHELL=3D/bin/sh. /lava-11676032/=
environment

    2023-10-04T11:13:34.553826  =


    2023-10-04T11:13:34.655271  / # . /lava-11676032/environment/lava-11676=
032/bin/lava-test-runner /lava-11676032/1

    2023-10-04T11:13:34.656399  =


    2023-10-04T11:13:34.673036  / # /lava-11676032/bin/lava-test-runner /la=
va-11676032/1

    2023-10-04T11:13:34.781079  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-04T11:13:34.781592  + cd /lava-11676032/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/651d48eda329bad4398a0a4d

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-=
beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-=
beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651d48eea329bad4398a0a7e
        failing since 263 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-10-04T11:13:01.814278  <8>[   23.393238] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 152255_1.5.2.4.1>
    2023-10-04T11:13:01.923005  / # #
    2023-10-04T11:13:02.025608  export SHELL=3D/bin/sh
    2023-10-04T11:13:02.026332  #
    2023-10-04T11:13:02.127967  / # export SHELL=3D/bin/sh. /lava-152255/en=
vironment
    2023-10-04T11:13:02.128575  =

    2023-10-04T11:13:02.230164  / # . /lava-152255/environment/lava-152255/=
bin/lava-test-runner /lava-152255/1
    2023-10-04T11:13:02.231097  =

    2023-10-04T11:13:02.234774  / # /lava-152255/bin/lava-test-runner /lava=
-152255/1
    2023-10-04T11:13:02.330216  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/651d4889b3134414158a0a4c

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline=
-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline=
-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651d4889b3134414158a0a86
        failing since 263 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-10-04T11:11:52.819552  <8>[   21.155206] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 152247_1.5.2.4.1>
    2023-10-04T11:11:52.929548  / # #
    2023-10-04T11:11:53.032218  export SHELL=3D/bin/sh
    2023-10-04T11:11:53.032764  #
    2023-10-04T11:11:53.134805  / # export SHELL=3D/bin/sh. /lava-152247/en=
vironment
    2023-10-04T11:11:53.135535  =

    2023-10-04T11:11:53.237896  / # . /lava-152247/environment/lava-152247/=
bin/lava-test-runner /lava-152247/1
    2023-10-04T11:11:53.239040  =

    2023-10-04T11:11:53.244056  / # /lava-152247/bin/lava-test-runner /lava=
-152247/1
    2023-10-04T11:11:53.344358  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls1028a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/651d47eaa6f54444fc8a0a60

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1028a=
-rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1028a=
-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651d47eaa6f54444fc8a0a67
        failing since 204 days (last pass: v5.10.155-cip21, first fail: v5.=
10.173-cip28)

    2023-10-04T11:09:08.532148  [   24.032476] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1253648_1.5.2.4.1>
    2023-10-04T11:09:08.637375  =

    2023-10-04T11:09:08.738541  / # #export SHELL=3D/bin/sh
    2023-10-04T11:09:08.738970  =

    2023-10-04T11:09:08.839937  / # export SHELL=3D/bin/sh. /lava-1253648/e=
nvironment
    2023-10-04T11:09:08.840358  =

    2023-10-04T11:09:08.941331  / # . /lava-1253648/environment/lava-125364=
8/bin/lava-test-runner /lava-1253648/1
    2023-10-04T11:09:08.942039  =

    2023-10-04T11:09:08.946201  / # /lava-1253648/bin/lava-test-runner /lav=
a-1253648/1
    2023-10-04T11:09:08.964560  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls1028a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/651d4a5554dadb954c8a0b78

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+kselftest/gcc-10/lab-nxp/baseline-f=
sl-ls1028a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+kselftest/gcc-10/lab-nxp/baseline-f=
sl-ls1028a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651d4a5554dadb954c8a0=
b79
        failing since 14 days (last pass: v5.10.191-cip38-29-g9e1aa2001db8,=
 first fail: v5.10.194-cip39) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/651d4af0f1a1b4d4ae8a0a47

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651d4af0f1a1b4d4ae8a0a50
        failing since 173 days (last pass: v5.10.176-cip30, first fail: v5.=
10.177-cip31)

    2023-10-04T11:22:08.584843  + set +x

    2023-10-04T11:22:08.591019  <8>[   14.269819] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11676207_1.4.2.3.1>

    2023-10-04T11:22:08.695595  / # #

    2023-10-04T11:22:08.796363  export SHELL=3D/bin/sh

    2023-10-04T11:22:08.796557  #

    2023-10-04T11:22:08.897038  / # export SHELL=3D/bin/sh. /lava-11676207/=
environment

    2023-10-04T11:22:08.897256  =


    2023-10-04T11:22:08.997811  / # . /lava-11676207/environment/lava-11676=
207/bin/lava-test-runner /lava-11676207/1

    2023-10-04T11:22:08.998107  =


    2023-10-04T11:22:09.002356  / # /lava-11676207/bin/lava-test-runner /la=
va-11676207/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/651d4aee7a35402b538a0ab2

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651d4aee7a35402b538a0abb
        failing since 173 days (last pass: v5.10.176-cip30, first fail: v5.=
10.177-cip31)

    2023-10-04T11:23:34.579899  + set +x

    2023-10-04T11:23:34.586884  <8>[   13.194026] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11676239_1.4.2.3.1>

    2023-10-04T11:23:34.688696  #

    2023-10-04T11:23:34.688976  =


    2023-10-04T11:23:34.789560  / # #export SHELL=3D/bin/sh

    2023-10-04T11:23:34.789781  =


    2023-10-04T11:23:34.890331  / # export SHELL=3D/bin/sh. /lava-11676239/=
environment

    2023-10-04T11:23:34.890522  =


    2023-10-04T11:23:34.991091  / # . /lava-11676239/environment/lava-11676=
239/bin/lava-test-runner /lava-11676239/1

    2023-10-04T11:23:34.991377  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/651d4896688eff25ab8a0a57

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm/multi_v7_defconfig/gcc-10/lab-collabora/baselin=
e-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm/multi_v7_defconfig/gcc-10/lab-collabora/baselin=
e-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651d4896688eff25ab8a0a60
        failing since 263 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-10-04T11:12:17.509302  / # #

    2023-10-04T11:12:17.611506  export SHELL=3D/bin/sh

    2023-10-04T11:12:17.612173  #

    2023-10-04T11:12:17.713841  / # export SHELL=3D/bin/sh. /lava-11676065/=
environment

    2023-10-04T11:12:17.714523  =


    2023-10-04T11:12:17.816357  / # . /lava-11676065/environment/lava-11676=
065/bin/lava-test-runner /lava-11676065/1

    2023-10-04T11:12:17.817501  =


    2023-10-04T11:12:17.832369  / # /lava-11676065/bin/lava-test-runner /la=
va-11676065/1

    2023-10-04T11:12:17.942493  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-04T11:12:17.943013  + cd /lava-11676065/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/651d4af8f1a1b4d4ae8a0a55

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/base=
line-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/base=
line-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651d4af8f1a1b4d4ae8a0a5e
        failing since 263 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-10-04T11:22:24.887445  + set +x
    2023-10-04T11:22:24.887692  [   10.493082] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1002477_1.5.2.3.1>
    2023-10-04T11:22:24.995593  / # #
    2023-10-04T11:22:25.097306  export SHELL=3D/bin/sh
    2023-10-04T11:22:25.097784  #
    2023-10-04T11:22:25.199088  / # export SHELL=3D/bin/sh. /lava-1002477/e=
nvironment
    2023-10-04T11:22:25.199555  =

    2023-10-04T11:22:25.300906  / # . /lava-1002477/environment/lava-100247=
7/bin/lava-test-runner /lava-1002477/1
    2023-10-04T11:22:25.301564  =

    2023-10-04T11:22:25.304663  / # /lava-1002477/bin/lava-test-runner /lav=
a-1002477/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/651d48633cdf7a8a688a0a52

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/basel=
ine-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/basel=
ine-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651d48633cdf7a8a688a0a5b
        failing since 263 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-10-04T11:11:24.986226  + set[    7.317737] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 1002471_1.5.2.3.1>
    2023-10-04T11:11:24.986414   +x
    2023-10-04T11:11:25.092332  / # #
    2023-10-04T11:11:25.193948  export SHELL=3D/bin/sh
    2023-10-04T11:11:25.194503  #
    2023-10-04T11:11:25.295821  / # export SHELL=3D/bin/sh. /lava-1002471/e=
nvironment
    2023-10-04T11:11:25.296267  =

    2023-10-04T11:11:25.397536  / # . /lava-1002471/environment/lava-100247=
1/bin/lava-test-runner /lava-1002471/1
    2023-10-04T11:11:25.398119  =

    2023-10-04T11:11:25.400531  / # /lava-1002471/bin/lava-test-runner /lav=
a-1002471/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6ul-14x14-evk             | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/651d48c4b3134414158a0a93

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx6=
ul-14x14-evk.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx6=
ul-14x14-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651d48c4b3134414158a0a9a
        failing since 196 days (last pass: v5.10.145-cip17, first fail: v5.=
10.175-cip29)

    2023-10-04T11:12:46.594493  + set +x
    2023-10-04T11:12:46.597657  <8>[   29.557818] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1253650_1.5.2.4.1>
    2023-10-04T11:12:46.708774  / # #
    2023-10-04T11:12:47.864927  export SHELL=3D/bin/sh
    2023-10-04T11:12:47.870620  #
    2023-10-04T11:12:49.412948  / # export SHELL=3D/bin/sh. /lava-1253650/e=
nvironment
    2023-10-04T11:12:49.418635  =

    2023-10-04T11:12:52.231104  / # . /lava-1253650/environment/lava-125365=
0/bin/lava-test-runner /lava-1253650/1
    2023-10-04T11:12:52.237149  =

    2023-10-04T11:12:52.239162  / # /lava-1253650/bin/lava-test-runner /lav=
a-1253650/1 =

    ... (18 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/651d48b1b05b975c0f8a0a58

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7=
d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7=
d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651d48b1b05b975c0f8a0a5f
        failing since 263 days (last pass: v5.10.155-cip21, first fail: v5.=
10.162-cip24)

    2023-10-04T11:12:35.290708  + set<8>[   17.065895] <LAVA_SIGNAL_ENDRUN =
0_dmesg 1253651_1.5.2.4.1>
    2023-10-04T11:12:35.290949   +x
    2023-10-04T11:12:35.396266  / # #
    2023-10-04T11:12:36.552340  export SHELL=3D/bin/sh
    2023-10-04T11:12:36.557985  #
    2023-10-04T11:12:38.100322  / # export SHELL=3D/bin/sh. /lava-1253651/e=
nvironment
    2023-10-04T11:12:38.105986  =

    2023-10-04T11:12:38.106286  / # . /lava-1253651/environment
    2023-10-04T11:12:40.918554  / # /lava-1253651/bin/lava-test-runner /lav=
a-1253651/1
    2023-10-04T11:12:40.935224  /lava-1253651/bin/lava-test-runner /lava-12=
53651/1 =

    ... (21 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
juno-uboot                   | arm64  | lab-broonie     | gcc-10   | cip://=
5.10.y-...64_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/651d4c329c859b9c328a0b7c

  Results:     47 PASS, 13 FAIL, 1 SKIP
  Full config: cip://5.10.y-cip/arm64/qemu_arm64_defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/cip---5.10.y-cip-arm64-qemu_arm64_defconfig/g=
cc-10/lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/cip---5.10.y-cip-arm64-qemu_arm64_defconfig/g=
cc-10/lab-broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651d4c329c859b9c328a0bbb
        failing since 37 days (last pass: v5.10.186-cip37-27-gd6d928db0a620=
, first fail: v5.10.191-cip38)

    2023-10-04T11:27:14.600794  / # #
    2023-10-04T11:27:14.703571  export SHELL=3D/bin/sh
    2023-10-04T11:27:14.704304  #
    2023-10-04T11:27:14.806188  / # export SHELL=3D/bin/sh. /lava-152349/en=
vironment
    2023-10-04T11:27:14.806937  =

    2023-10-04T11:27:14.908910  / # . /lava-152349/environment/lava-152349/=
bin/lava-test-runner /lava-152349/1
    2023-10-04T11:27:14.910210  =

    2023-10-04T11:27:14.925025  / # /lava-152349/bin/lava-test-runner /lava=
-152349/1
    2023-10-04T11:27:14.980935  + export 'TESTRUN_ID=3D1_bootrr'
    2023-10-04T11:27:14.981435  + cd /lava-152349/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/651d489956efb2b0478a0a5c

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-ub=
oot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-ub=
oot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651d489956efb2b0478a0a9c
        failing since 20 days (last pass: v5.10.191-cip38-2-g09e5ecd8645b, =
first fail: v5.10.191-cip38-29-g9e1aa2001db8)

    2023-10-04T11:11:53.760558  / # #
    2023-10-04T11:11:53.863872  export SHELL=3D/bin/sh
    2023-10-04T11:11:53.864668  #
    2023-10-04T11:11:53.966708  / # export SHELL=3D/bin/sh. /lava-152201/en=
vironment
    2023-10-04T11:11:53.967561  =

    2023-10-04T11:11:54.069640  / # . /lava-152201/environment/lava-152201/=
bin/lava-test-runner /lava-152201/1
    2023-10-04T11:11:54.071672  =

    2023-10-04T11:11:54.084508  / # /lava-152201/bin/lava-test-runner /lava=
-152201/1
    2023-10-04T11:11:54.144281  + export 'TESTRUN_ID=3D1_bootrr'
    2023-10-04T11:11:54.144805  + cd /lava-152201/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/651d4b194c89c4f9e48a0a44

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+kselftest/gcc-10/lab-broonie/baseli=
ne-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+kselftest/gcc-10/lab-broonie/baseli=
ne-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651d4b1a4c89c4f9e48a0a84
        failing since 70 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-10-04T11:22:25.342479  <8>[   19.343574] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 152301_1.5.2.4.1>
    2023-10-04T11:22:25.450473  / # #
    2023-10-04T11:22:25.553239  export SHELL=3D/bin/sh
    2023-10-04T11:22:25.554348  #
    2023-10-04T11:22:25.656577  / # export SHELL=3D/bin/sh. /lava-152301/en=
vironment
    2023-10-04T11:22:25.657391  =

    2023-10-04T11:22:25.759359  / # . /lava-152301/environment/lava-152301/=
bin/lava-test-runner /lava-152301/1
    2023-10-04T11:22:25.760668  =

    2023-10-04T11:22:25.773515  / # /lava-152301/bin/lava-test-runner /lava=
-152301/1
    2023-10-04T11:22:25.950367  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
kontron-kbox-a-230-ls        | arm64  | lab-kontron     | gcc-10   | defcon=
fig+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/651d4a6a54dadb954c8a0bc6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+kselftest/gcc-10/lab-kontron/baseli=
ne-kontron-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+kselftest/gcc-10/lab-kontron/baseli=
ne-kontron-kbox-a-230-ls.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651d4a6a54dadb954c8a0=
bc7
        failing since 14 days (last pass: v5.10.191-cip38-29-g9e1aa2001db8,=
 first fail: v5.10.194-cip39) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
kontron-sl28-var3-ads2       | arm64  | lab-kontron     | gcc-10   | defcon=
fig+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/651d4a442ee74bcd538a0aba

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+kselftest/gcc-10/lab-kontron/baseli=
ne-kontron-sl28-var3-ads2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+kselftest/gcc-10/lab-kontron/baseli=
ne-kontron-sl28-var3-ads2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651d4a442ee74bcd538a0=
abb
        failing since 14 days (last pass: v5.10.191-cip38-29-g9e1aa2001db8,=
 first fail: v5.10.194-cip39) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64  | lab-collabora   | gcc-10   | defcon=
fig+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/651d4988a0d702a07a8a0a42

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+kselftest/gcc-10/lab-collabora/base=
line-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+kselftest/gcc-10/lab-collabora/base=
line-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651d4988a0d702a07a8a0=
a43
        failing since 14 days (last pass: v5.10.191-cip38-29-g9e1aa2001db8,=
 first fail: v5.10.194-cip39) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/651d4a2272e6b1b5518a0ac6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+kselftest/gcc-10/lab-broonie/baseli=
ne-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+kselftest/gcc-10/lab-broonie/baseli=
ne-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651d4a2272e6b1b5518a0=
ac7
        failing since 14 days (last pass: v5.10.191-cip38-29-g9e1aa2001db8,=
 first fail: v5.10.194-cip39) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/651d4a1772e6b1b5518a0aa2

  Results:     28 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/baseline-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/baseline-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651d4a1772e6b1b5518a0ac2
        failing since 263 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-10-04T11:18:32.493661  + set +x

    2023-10-04T11:18:32.498921  <8>[   15.623266] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11676150_1.5.2.3.1>

    2023-10-04T11:18:32.606881  #

    2023-10-04T11:18:32.608279  =


    2023-10-04T11:18:32.710612  / # #export SHELL=3D/bin/sh

    2023-10-04T11:18:32.711424  =


    2023-10-04T11:18:32.813195  / # export SHELL=3D/bin/sh. /lava-11676150/=
environment

    2023-10-04T11:18:32.813971  =


    2023-10-04T11:18:32.915581  / # . /lava-11676150/environment/lava-11676=
150/bin/lava-test-runner /lava-11676150/1

    2023-10-04T11:18:32.916784  =

 =

    ... (22 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/651d491f493a7f042e8a0a74

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7=
743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7=
743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651d491f493a7f042e8a0=
a75
        failing since 20 days (last pass: v5.10.191-cip38-2-g09e5ecd8645b, =
first fail: v5.10.191-cip38-17-g8dad6b499cfe5) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/651d4d7fb1a3c0c5ea8a0a50

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/bas=
eline-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/bas=
eline-r8a774b1-hihope-rzg2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651d4d7fb1a3c0c5ea8a0a57
        failing since 70 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-10-04T11:32:48.765858  + set +x
    2023-10-04T11:32:48.765981  <8>[   84.235468] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1016898_1.5.2.4.1>
    2023-10-04T11:32:48.871430  / # #
    2023-10-04T11:32:50.331353  export SHELL=3D/bin/sh
    2023-10-04T11:32:50.351800  #
    2023-10-04T11:32:50.351921  / # export SHELL=3D/bin/sh
    2023-10-04T11:32:52.304854  / # . /lava-1016898/environment
    2023-10-04T11:32:55.898252  /lava-1016898/bin/lava-test-runner /lava-10=
16898/1
    2023-10-04T11:32:55.918913  . /lava-1016898/environment
    2023-10-04T11:32:55.919042  / # /lava-1016898/bin/lava-test-runner /lav=
a-1016898/1 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/651d48a6b379d4adc18a0a52

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek=
874.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek=
874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651d48a6b379d4adc18a0a59
        failing since 70 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-10-04T11:12:18.222209  / # #
    2023-10-04T11:12:19.682300  export SHELL=3D/bin/sh
    2023-10-04T11:12:19.702760  #
    2023-10-04T11:12:19.702936  / # export SHELL=3D/bin/sh
    2023-10-04T11:12:21.656276  / # . /lava-1016837/environment
    2023-10-04T11:12:25.247758  /lava-1016837/bin/lava-test-runner /lava-10=
16837/1
    2023-10-04T11:12:25.268395  . /lava-1016837/environment
    2023-10-04T11:12:25.268523  / # /lava-1016837/bin/lava-test-runner /lav=
a-1016837/1
    2023-10-04T11:12:25.346348  + export 'TESTRUN_ID=3D1_bootrr'
    2023-10-04T11:12:25.346509  + cd /lava-1016837/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/651d4a51cd986e21918a0a43

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-r=
8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-r=
8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651d4a51cd986e21918a0=
a44
        failing since 14 days (last pass: v5.10.191-cip38-29-g9e1aa2001db8,=
 first fail: v5.10.194-cip39) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/651d4ba7c715b1e6c58a0a78

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/bas=
eline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/bas=
eline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651d4ba7c715b1e6c58a0a7f
        failing since 70 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-10-04T11:24:41.150829  / # #
    2023-10-04T11:24:42.610451  export SHELL=3D/bin/sh
    2023-10-04T11:24:42.630963  #
    2023-10-04T11:24:42.631159  / # export SHELL=3D/bin/sh
    2023-10-04T11:24:44.583906  / # . /lava-1016893/environment
    2023-10-04T11:24:48.176701  /lava-1016893/bin/lava-test-runner /lava-10=
16893/1
    2023-10-04T11:24:48.197382  . /lava-1016893/environment
    2023-10-04T11:24:48.197488  / # /lava-1016893/bin/lava-test-runner /lav=
a-1016893/1
    2023-10-04T11:24:48.275409  + export 'TESTRUN_ID=3D1_bootrr'
    2023-10-04T11:24:48.275615  + cd /lava-1016893/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/651d47c9764dd781168a0a7a

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77=
960-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77=
960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651d47c9764dd781168a0a83
        failing since 70 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-10-04T11:12:51.875555  / # #

    2023-10-04T11:12:51.977524  export SHELL=3D/bin/sh

    2023-10-04T11:12:51.978215  #

    2023-10-04T11:12:52.079467  / # export SHELL=3D/bin/sh. /lava-11676034/=
environment

    2023-10-04T11:12:52.080139  =


    2023-10-04T11:12:52.181423  / # . /lava-11676034/environment/lava-11676=
034/bin/lava-test-runner /lava-11676034/1

    2023-10-04T11:12:52.182560  =


    2023-10-04T11:12:52.199554  / # /lava-11676034/bin/lava-test-runner /la=
va-11676034/1

    2023-10-04T11:12:52.248095  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-04T11:12:52.248620  + cd /lav<8>[   16.425842] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11676034_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/651d4980336ceb7b7f8a0ae9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+kselftest/gcc-10/lab-collabora/base=
line-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+kselftest/gcc-10/lab-collabora/base=
line-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651d4980336ceb7b7f8a0=
aea
        failing since 14 days (last pass: v5.10.191-cip38-29-g9e1aa2001db8,=
 first fail: v5.10.194-cip39) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 4          =


  Details:     https://kernelci.org/test/plan/id/651d4890bb4eae68ee8a0a61

  Results:     63 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm/multi_v7_defconfig/gcc-10/lab-collabora/baselin=
e-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm/multi_v7_defconfig/gcc-10/lab-collabora/baselin=
e-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-i2c-present: https://kernelci.or=
g/test/case/id/651d4890bb4eae68ee8a0a94
        failing since 261 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-10-04T11:16:14.671206   INC default to 1.

    2023-10-04T11:16:14.671428  =


    2023-10-04T11:16:14.675033  	-w	Pad to last with leading zeros

    2023-10-04T11:16:14.677683  	-s SEP	String separator

    2023-10-04T11:16:14.681422  /lava-11676069/1/../bin/lava-test-case

    2023-10-04T11:16:14.687370  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.

    2023-10-04T11:16:14.687746  =

   =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/651d4890bb4eae68ee8a0a95
        failing since 261 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-10-04T11:16:14.647221  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC)<8=
>[   21.726575] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-10-04T11:16:14.648933   multi-call binary.

    2023-10-04T11:16:14.649311  =


    2023-10-04T11:16:14.654005  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-10-04T11:16:14.654060  =


    2023-10-04T11:16:14.658846  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-10-04T11:16:14.669410  FIRST,<8>[   21.745648] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/651d4890bb4eae68ee8a0a96
        failing since 261 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-10-04T11:16:14.628130  <8>[   21.708717] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651d4890bb4eae68ee8a0aaa
        failing since 261 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-10-04T11:16:02.563199  <8>[    9.643845] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-10-04T11:16:02.572615  + <8>[    9.656373] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11676069_1.5.2.3.1>

    2023-10-04T11:16:02.575883  set +x

    2023-10-04T11:16:02.679812  #

    2023-10-04T11:16:02.680928  =


    2023-10-04T11:16:02.782349  / # #export SHELL=3D/bin/sh

    2023-10-04T11:16:02.782989  =


    2023-10-04T11:16:02.884174  / # export SHELL=3D/bin/sh. /lava-11676069/=
environment

    2023-10-04T11:16:02.884878  =


    2023-10-04T11:16:02.986176  / # . /lava-11676069/environment/lava-11676=
069/bin/lava-test-runner /lava-11676069/1
 =

    ... (20 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/651d47f247870372258a0a75

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-collabora/baseline-rk339=
9-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-collabora/baseline-rk339=
9-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651d47f247870372258a0a7e
        failing since 14 days (last pass: v5.10.191-cip38-29-g9e1aa2001db8,=
 first fail: v5.10.194-cip39)

    2023-10-04T11:11:40.483031  / # #

    2023-10-04T11:11:41.744263  export SHELL=3D/bin/sh

    2023-10-04T11:11:41.755213  #

    2023-10-04T11:11:41.755681  / # export SHELL=3D/bin/sh

    2023-10-04T11:11:43.499945  / # . /lava-11676037/environment

    2023-10-04T11:11:46.706012  /lava-11676037/bin/lava-test-runner /lava-1=
1676037/1

    2023-10-04T11:11:46.717455  . /lava-11676037/environment

    2023-10-04T11:11:46.717862  / # /lava-11676037/bin/lava-test-runner /la=
va-11676037/1

    2023-10-04T11:11:46.775838  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-04T11:11:46.776320  + cd /lava-11676037/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/651d47f247870372258a0a43

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-=
a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-=
a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651d47f247870372258a0a73
        failing since 263 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-10-04T11:09:23.064480  + set +x
    2023-10-04T11:09:23.068350  <8>[   17.116480] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 152207_1.5.2.4.1>
    2023-10-04T11:09:23.179847  / # #
    2023-10-04T11:09:23.282643  export SHELL=3D/bin/sh
    2023-10-04T11:09:23.283336  #
    2023-10-04T11:09:23.387010  / # export SHELL=3D/bin/sh. /lava-152207/en=
vironment
    2023-10-04T11:09:23.389791  =

    2023-10-04T11:09:23.493536  / # . /lava-152207/environment/lava-152207/=
bin/lava-test-runner /lava-152207/1
    2023-10-04T11:09:23.495738  =

    2023-10-04T11:09:23.499285  / # /lava-152207/bin/lava-test-runner /lava=
-152207/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/651d4b4eafa3763bd08a0a5b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+kselftest/gcc-10/lab-broonie/baseli=
ne-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+kselftest/gcc-10/lab-broonie/baseli=
ne-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651d4b4eafa3763bd08a0=
a5c
        failing since 14 days (last pass: v5.10.191-cip38-29-g9e1aa2001db8,=
 first fail: v5.10.194-cip39) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/651d4a7272d66f4b808a0a42

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+kselftest/gcc-10/lab-broonie/baseli=
ne-sun50i-h5-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+kselftest/gcc-10/lab-broonie/baseli=
ne-sun50i-h5-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651d4a7272d66f4b808a0=
a43
        failing since 14 days (last pass: v5.10.191-cip38-29-g9e1aa2001db8,=
 first fail: v5.10.194-cip39) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/651d47c7764dd781168a0a6f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50=
i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50=
i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651d47c8764dd781168a0a78
        failing since 70 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-10-04T11:13:04.938254  / # #

    2023-10-04T11:13:05.040458  export SHELL=3D/bin/sh

    2023-10-04T11:13:05.041157  #

    2023-10-04T11:13:05.142596  / # export SHELL=3D/bin/sh. /lava-11676033/=
environment

    2023-10-04T11:13:05.143300  =


    2023-10-04T11:13:05.244791  / # . /lava-11676033/environment/lava-11676=
033/bin/lava-test-runner /lava-11676033/1

    2023-10-04T11:13:05.245913  =


    2023-10-04T11:13:05.262465  / # /lava-11676033/bin/lava-test-runner /la=
va-11676033/1

    2023-10-04T11:13:05.304345  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-04T11:13:05.320582  + cd /lava-1167603<8>[   18.262390] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11676033_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

