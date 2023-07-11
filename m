Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8EBC001DD
	for <webhook@archiver.kernel.org>; Tue, 11 Jul 2023 15:37:29 +0000 (UTC)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
 by mx.groups.io with SMTP id smtpd.web11.2946.1689089839776215166
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 11 Jul 2023 08:37:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=Wxq3DTKQ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.169, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-55b5a3915f5so4082254a12.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 11 Jul 2023 08:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689089839; x=1691681839;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EuqtB+8jTXvCtKhkgmPOYQ8AZDSYpazYW/pQxEOBijQ=;
        b=Wxq3DTKQF8H/DGsm5UH/xic45ijcamMyBAahEixmP1uJSkmCnQeNlo1KG90GTgmaeH
         zvVoGpFO8FP7F+c0vIaSkZtNryc3U7SeNqXwLX1oRK5WwtilcJO0S6wnAeHLpFLOHQiw
         uoU49x0pY0ZCoGWoLzmj0m78hfH9wvpj4OJsVDi21seQeHSCqUEFnCLxSMjTG8PprofG
         MWh6Orscw6iWMELDTeuC/MtlIPrRqUGdHczAj57O3bhSf8XVeDozbQmPP8XTI9XrkpFg
         HXbtvf9dn6viLWBLNF9uU4qwurH/rZqH3nIjkGrxl204dXot0EubiFx0kFeRziiJ7yZq
         0YSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689089839; x=1691681839;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EuqtB+8jTXvCtKhkgmPOYQ8AZDSYpazYW/pQxEOBijQ=;
        b=RfVnEpaD/uI/LQuQDPonKMaWVn2BhrcXpogBSXkpFhjg/oZpplOST3apBsSWXFpmKU
         U8d0h54o6eqaGy6vvg6/tEHK20+lQdBQS/jRc7KYtDBhrJKVw5M9isj5bku7YeJO+DhW
         nceRKaYT1EFgDqpOxjzYdoJPYNsdsIw3Qeg1b29KNjDdVw/2ABbC+O8x1kD3vbp8AzNm
         eWIPjOXIG5RciQ+1v14vs8YQbdFw5koIm6xJIuPs3/lRWmSEa10v4z3qAIM+8+0ldU2i
         vmoo+OjRYrvBReGJbNZWkTWyAVZ3pOJy8qwABCRRTK9ohkk+UWD9oMtGAsrYHqKY8ewQ
         iluA==
X-Gm-Message-State: ABy/qLYtRLf5H7O4a0WS23JIDucb4jwx7Wp5lpHMcZ+IYoQmfZWI5ja6
	Vb6HIl1e3SmNla/uF0LIXncnXHJ8RpA6G5XXWVQfcA==
X-Google-Smtp-Source: APBJJlGMV3+LniicmVoEQxV6IcbMNy7jH/cYjizeui5P34G8bbdSkw2GlHixq09w9pGflwUfUcnirw==
X-Received: by 2002:a17:90b:1189:b0:263:1fc2:9bdb with SMTP id gk9-20020a17090b118900b002631fc29bdbmr9675692pjb.30.1689089838023;
        Tue, 11 Jul 2023 08:37:18 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id q7-20020a63ae07000000b004fab4455748sm1777117pgf.75.2023.07.11.08.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 08:37:17 -0700 (PDT)
Message-ID: <64ad772d.630a0220.8205a.3588@mx.google.com>
Date: Tue, 11 Jul 2023 08:37:17 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.184-cip36-13-g8fae18103387
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y-cip
Subject: cip/linux-5.10.y-cip baseline: 134 runs,
 21 regressions (v5.10.184-cip36-13-g8fae18103387)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Jul 2023 15:37:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12318

cip/linux-5.10.y-cip baseline: 134 runs, 21 regressions (v5.10.184-cip36-13=
-g8fae18103387)

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
l/v5.10.184-cip36-13-g8fae18103387/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.184-cip36-13-g8fae18103387
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      8fae18103387e09e360941d7df884a2fc6010f66 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ad6ea0b71dc573c6bb2ac0

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-13-g8fae18103387/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-13-g8fae18103387/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ad6ea0b71dc573c6bb2ac5
        failing since 178 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-07-11T15:00:27.439158  <8>[   12.305578] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11062035_1.4.2.3.1>

    2023-07-11T15:00:27.442658  + set +x

    2023-07-11T15:00:27.547339  #

    2023-07-11T15:00:27.649626  / # #export SHELL=3D/bin/sh

    2023-07-11T15:00:27.649810  =


    2023-07-11T15:00:27.750269  / # export SHELL=3D/bin/sh. /lava-11062035/=
environment

    2023-07-11T15:00:27.750468  =


    2023-07-11T15:00:27.851082  / # . /lava-11062035/environment/lava-11062=
035/bin/lava-test-runner /lava-11062035/1

    2023-07-11T15:00:27.851361  =


    2023-07-11T15:00:27.851458  / # <4>[   12.656628] i2c_designware i2c_de=
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


  Details:     https://kernelci.org/test/plan/id/64ad6e9f7a644c1facbb2a79

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-13-g8fae18103387/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-13-g8fae18103387/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ad6e9f7a644c1facbb2a7e
        failing since 178 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-07-11T15:00:34.658474  + set<8>[   11.764017] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11062054_1.4.2.3.1>

    2023-07-11T15:00:34.658876   +x

    2023-07-11T15:00:34.764062  / # #

    2023-07-11T15:00:34.866737  export SHELL=3D/bin/sh

    2023-07-11T15:00:34.867548  #

    2023-07-11T15:00:34.969267  / # export SHELL=3D/bin/sh. /lava-11062054/=
environment

    2023-07-11T15:00:34.970133  =


    2023-07-11T15:00:35.071805  / # . /lava-11062054/environment/lava-11062=
054/bin/lava-test-runner /lava-11062054/1

    2023-07-11T15:00:35.073020  =


    2023-07-11T15:00:35.073417  / # /lava-11062054/bin/lava-test-runner /la=
va-11062054/1<4>[   12.179490] i2c_designware i2c_designware.5: timeout in =
disabling adapter
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ad6f4e3af0a0c750bb2a77

  Results:     47 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-13-g8fae18103387/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-=
at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-13-g8fae18103387/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-=
at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ad6f4e3af0a0c750bb2aac
        failing since 178 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-07-11T15:03:07.254837  + set +x
    2023-07-11T15:03:07.259986  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 714257_1.5.2=
.4.1>
    2023-07-11T15:03:07.373968  / # #
    2023-07-11T15:03:07.477036  export SHELL=3D/bin/sh
    2023-07-11T15:03:07.477886  #
    2023-07-11T15:03:07.579869  / # export SHELL=3D/bin/sh. /lava-714257/en=
vironment
    2023-07-11T15:03:07.580710  =

    2023-07-11T15:03:07.682733  / # . /lava-714257/environment/lava-714257/=
bin/lava-test-runner /lava-714257/1
    2023-07-11T15:03:07.684158  =

    2023-07-11T15:03:07.690661  / # /lava-714257/bin/lava-test-runner /lava=
-714257/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ad6edb3fdecb8534bb2a77

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-13-g8fae18103387/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-=
beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-13-g8fae18103387/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-=
beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ad6edb3fdecb8534bb2aa4
        failing since 178 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-07-11T15:01:13.124856  <8>[   23.550000] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 714297_1.5.2.4.1>
    2023-07-11T15:01:13.236187  / # #
    2023-07-11T15:01:13.339066  export SHELL=3D/bin/sh
    2023-07-11T15:01:13.339620  #
    2023-07-11T15:01:13.441816  / # export SHELL=3D/bin/sh. /lava-714297/en=
vironment
    2023-07-11T15:01:13.442407  =

    2023-07-11T15:01:13.544397  / # . /lava-714297/environment/lava-714297/=
bin/lava-test-runner /lava-714297/1
    2023-07-11T15:01:13.545521  =

    2023-07-11T15:01:13.549425  / # /lava-714297/bin/lava-test-runner /lava=
-714297/1
    2023-07-11T15:01:13.642909  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ad70b4fd9dd1805cbb2a7c

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-13-g8fae18103387/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-13-g8fae18103387/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ad70b4fd9dd1805cbb2a7f
        failing since 178 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-07-11T15:08:58.738892  + set +x
    2023-07-11T15:08:58.740843  <8>[   16.579604] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 985116_1.5.2.4.1>
    2023-07-11T15:08:58.850162  / # #
    2023-07-11T15:08:58.952519  export SHELL=3D/bin/sh
    2023-07-11T15:08:58.953065  #
    2023-07-11T15:08:59.054456  / # export SHELL=3D/bin/sh. /lava-985116/en=
vironment
    2023-07-11T15:08:59.054906  =

    2023-07-11T15:08:59.156318  / # . /lava-985116/environment/lava-985116/=
bin/lava-test-runner /lava-985116/1
    2023-07-11T15:08:59.157189  =

    2023-07-11T15:08:59.159147  / # /lava-985116/bin/lava-test-runner /lava=
-985116/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64ad6ebbe060757b4ebb2aa5

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-13-g8fae18103387/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline=
-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-13-g8fae18103387/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline=
-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ad6ebbe060757b4ebb2adb
        failing since 178 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-07-11T15:01:00.579144  + set +x
    2023-07-11T15:01:00.582317  <8>[   21.627350] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 714269_1.5.2.4.1>
    2023-07-11T15:01:00.692882  / # #
    2023-07-11T15:01:00.795976  export SHELL=3D/bin/sh
    2023-07-11T15:01:00.796938  #
    2023-07-11T15:01:00.899019  / # export SHELL=3D/bin/sh. /lava-714269/en=
vironment
    2023-07-11T15:01:00.899932  =

    2023-07-11T15:01:01.002108  / # . /lava-714269/environment/lava-714269/=
bin/lava-test-runner /lava-714269/1
    2023-07-11T15:01:01.003531  =

    2023-07-11T15:01:01.007974  / # /lava-714269/bin/lava-test-runner /lava=
-714269/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64ad6ede4f88aa528cbb2ab1

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-13-g8fae18103387/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-bea=
glebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-13-g8fae18103387/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-bea=
glebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ad6ede4f88aa528cbb2ab4
        failing since 178 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-07-11T15:01:35.661343  <8>[   12.980690] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 985111_1.5.2.4.1>
    2023-07-11T15:01:35.768285  / # #
    2023-07-11T15:01:35.870291  export SHELL=3D/bin/sh
    2023-07-11T15:01:35.870926  #
    2023-07-11T15:01:35.972312  / # export SHELL=3D/bin/sh. /lava-985111/en=
vironment
    2023-07-11T15:01:35.972889  =

    2023-07-11T15:01:36.074293  / # . /lava-985111/environment/lava-985111/=
bin/lava-test-runner /lava-985111/1
    2023-07-11T15:01:36.075142  =

    2023-07-11T15:01:36.081840  / # /lava-985111/bin/lava-test-runner /lava=
-985111/1
    2023-07-11T15:01:36.183443  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ad6f8d9ef34b35fbbb2a75

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-13-g8fae18103387/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-13-g8fae18103387/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ad6f8d9ef34b35fbbb2a7a
        failing since 88 days (last pass: v5.10.176-cip30, first fail: v5.1=
0.177-cip31)

    2023-07-11T15:04:27.699077  + set +x

    2023-07-11T15:04:27.705674  <8>[    8.227946] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11062084_1.4.2.3.1>

    2023-07-11T15:04:27.813772  / # #

    2023-07-11T15:04:27.916042  export SHELL=3D/bin/sh

    2023-07-11T15:04:27.916864  #

    2023-07-11T15:04:28.018316  / # export SHELL=3D/bin/sh. /lava-11062084/=
environment

    2023-07-11T15:04:28.019104  =


    2023-07-11T15:04:28.120734  / # . /lava-11062084/environment/lava-11062=
084/bin/lava-test-runner /lava-11062084/1

    2023-07-11T15:04:28.122143  =


    2023-07-11T15:04:28.127415  / # /lava-11062084/bin/lava-test-runner /la=
va-11062084/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ad6ea1b71dc573c6bb2b45

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-13-g8fae18103387/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-13-g8fae18103387/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ad6ea1b71dc573c6bb2b4a
        failing since 88 days (last pass: v5.10.176-cip30, first fail: v5.1=
0.177-cip31)

    2023-07-11T15:00:28.517883  + set +x

    2023-07-11T15:00:28.524388  <8>[   13.377238] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11062052_1.4.2.3.1>

    2023-07-11T15:00:28.631884  #

    2023-07-11T15:00:28.632986  =


    2023-07-11T15:00:28.735061  / # #export SHELL=3D/bin/sh

    2023-07-11T15:00:28.735736  =


    2023-07-11T15:00:28.837383  / # export SHELL=3D/bin/sh. /lava-11062052/=
environment

    2023-07-11T15:00:28.838077  =


    2023-07-11T15:00:28.939529  / # . /lava-11062052/environment/lava-11062=
052/bin/lava-test-runner /lava-11062052/1

    2023-07-11T15:00:28.940779  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ad6ea7818ec70e70bb2ae3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-13-g8fae18103387/arm/multi_v7_defconfig/gcc-10/lab-collabora/baselin=
e-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-13-g8fae18103387/arm/multi_v7_defconfig/gcc-10/lab-collabora/baselin=
e-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ad6ea7818ec70e70bb2ae8
        failing since 178 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-07-11T15:00:56.746688  / # #

    2023-07-11T15:00:56.847993  export SHELL=3D/bin/sh

    2023-07-11T15:00:56.848711  #

    2023-07-11T15:00:56.950452  / # export SHELL=3D/bin/sh. /lava-11062004/=
environment

    2023-07-11T15:00:56.951221  =


    2023-07-11T15:00:57.053132  / # . /lava-11062004/environment/lava-11062=
004/bin/lava-test-runner /lava-11062004/1

    2023-07-11T15:00:57.054256  =


    2023-07-11T15:00:57.067719  / # /lava-11062004/bin/lava-test-runner /la=
va-11062004/1

    2023-07-11T15:00:57.172626  + export 'TESTRUN_ID=3D1_bootrr'

    2023-07-11T15:00:57.173146  + cd /lava-11062004/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64ad6e8cf6736ced12bb2a7f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-13-g8fae18103387/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/base=
line-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-13-g8fae18103387/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/base=
line-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ad6e8cf6736ced12bb2a84
        failing since 178 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-07-11T15:00:09.265741  + set +x
    2023-07-11T15:00:09.265936  [   10.320807] <LAVA_SIGNAL_ENDRUN 0_dmesg =
994838_1.5.2.3.1>
    2023-07-11T15:00:09.374855  / # #
    2023-07-11T15:00:09.476726  export SHELL=3D/bin/sh
    2023-07-11T15:00:09.477223  #
    2023-07-11T15:00:09.578568  / # export SHELL=3D/bin/sh. /lava-994838/en=
vironment
    2023-07-11T15:00:09.579215  =

    2023-07-11T15:00:09.680757  / # . /lava-994838/environment/lava-994838/=
bin/lava-test-runner /lava-994838/1
    2023-07-11T15:00:09.681380  =

    2023-07-11T15:00:09.684928  / # /lava-994838/bin/lava-test-runner /lava=
-994838/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ad6ec8b4aba68848bb2afb

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-13-g8fae18103387/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/basel=
ine-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-13-g8fae18103387/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/basel=
ine-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ad6ec8b4aba68848bb2b00
        failing since 178 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-07-11T15:01:19.330979  + set[    7.120849] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 994842_1.5.2.3.1>
    2023-07-11T15:01:19.331159   +x
    2023-07-11T15:01:19.436878  / # #
    2023-07-11T15:01:19.538468  export SHELL=3D/bin/sh
    2023-07-11T15:01:19.539073  #
    2023-07-11T15:01:19.640916  / # export SHELL=3D/bin/sh. /lava-994842/en=
vironment
    2023-07-11T15:01:19.641395  =

    2023-07-11T15:01:19.742779  / # . /lava-994842/environment/lava-994842/=
bin/lava-test-runner /lava-994842/1
    2023-07-11T15:01:19.743442  =

    2023-07-11T15:01:19.745980  / # /lava-994842/bin/lava-test-runner /lava=
-994842/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64ad6f393036359ba5bb2a88

  Results:     28 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-13-g8fae18103387/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/baseline-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-13-g8fae18103387/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/baseline-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ad6f393036359ba5bb2aa4
        failing since 178 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-07-11T15:03:03.770022  + set +x

    2023-07-11T15:03:03.775939  <8>[   15.627203] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11062105_1.5.2.3.1>

    2023-07-11T15:03:03.880110  / # #

    2023-07-11T15:03:03.980657  export SHELL=3D/bin/sh

    2023-07-11T15:03:03.980804  #

    2023-07-11T15:03:04.081279  / # export SHELL=3D/bin/sh. /lava-11062105/=
environment

    2023-07-11T15:03:04.081462  =


    2023-07-11T15:03:04.182072  / # . /lava-11062105/environment/lava-11062=
105/bin/lava-test-runner /lava-11062105/1

    2023-07-11T15:03:04.182332  =


    2023-07-11T15:03:04.184558  / # /lava-11062105/bin/lava-test-runner /la=
va-11062105/1
 =

    ... (16 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ad6f8876c0c23c06bb2a7a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-13-g8fae18103387/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7=
743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-13-g8fae18103387/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7=
743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ad6f8876c0c23c06bb2=
a7b
        failing since 36 days (last pass: v5.10.180-cip34, first fail: v5.1=
0.180-cip34-19-gf0f6960f132cd) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 4          =


  Details:     https://kernelci.org/test/plan/id/64ad6ef1becccb4a8bbb2a97

  Results:     63 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-13-g8fae18103387/arm/multi_v7_defconfig/gcc-10/lab-collabora/baselin=
e-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-13-g8fae18103387/arm/multi_v7_defconfig/gcc-10/lab-collabora/baselin=
e-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-i2c-present: https://kernelci.or=
g/test/case/id/64ad6ef1becccb4a8bbb2ac6
        failing since 176 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-07-11T15:03:34.300650  FIRST,<8>[   19.268971] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>

    2023-07-11T15:03:34.302294   INC default to 1.

    2023-07-11T15:03:34.302515  =


    2023-07-11T15:03:34.306116  	-w	Pad to last with leading zeros

    2023-07-11T15:03:34.308582  	-s SEP	String separator

    2023-07-11T15:03:34.312367  /lava-11062020/1/../bin/lava-test-case

    2023-07-11T15:03:34.318443  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.

    2023-07-11T15:03:34.318670  =

   =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/64ad6ef1becccb4a8bbb2ac7
        failing since 176 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-07-11T15:03:34.278257  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC)<8=
>[   19.249984] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-07-11T15:03:34.280077   multi-call binary.

    2023-07-11T15:03:34.280294  =


    2023-07-11T15:03:34.284792  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-07-11T15:03:34.284844  =


    2023-07-11T15:03:34.289840  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/64ad6ef1becccb4a8bbb2ac8
        failing since 176 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-07-11T15:03:34.259164  <8>[   19.232201] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ad6ef1becccb4a8bbb2adc
        failing since 176 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-07-11T15:03:22.199029  <8>[    7.171971] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-07-11T15:03:22.208617  + <8>[    7.184369] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11062020_1.5.2.3.1>

    2023-07-11T15:03:22.209040  set +x

    2023-07-11T15:03:22.315640  =


    2023-07-11T15:03:22.417293  / # #export SHELL=3D/bin/sh

    2023-07-11T15:03:22.417995  =


    2023-07-11T15:03:22.519347  / # export SHELL=3D/bin/sh. /lava-11062020/=
environment

    2023-07-11T15:03:22.520044  =


    2023-07-11T15:03:22.621457  / # . /lava-11062020/environment/lava-11062=
020/bin/lava-test-runner /lava-11062020/1

    2023-07-11T15:03:22.622466  =

 =

    ... (18 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64ad6f5270063d32e2bb2a76

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-13-g8fae18103387/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-13-g8fae18103387/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/64ad6f5270063d32e2bb2a7c
        failing since 111 days (last pass: v5.10.173-cip28, first fail: v5.=
10.175-cip29)

    2023-07-11T15:03:33.399500  /lava-11062102/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/64ad6f5270063d32e2bb2a7d
        failing since 111 days (last pass: v5.10.173-cip28, first fail: v5.=
10.175-cip29)

    2023-07-11T15:03:32.362473  /lava-11062102/1/../bin/lava-test-case

    2023-07-11T15:03:32.373682  <8>[   33.882281] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ad6f1d2c713ef2a1bb2a8e

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-13-g8fae18103387/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-=
a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-13-g8fae18103387/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-=
a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ad6f1d2c713ef2a1bb2aba
        failing since 178 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-07-11T15:02:24.166650  + set +x
    2023-07-11T15:02:24.170845  <8>[   17.079695] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 714343_1.5.2.4.1>
    2023-07-11T15:02:24.281505  / # #
    2023-07-11T15:02:24.383696  export SHELL=3D/bin/sh
    2023-07-11T15:02:24.384489  #
    2023-07-11T15:02:24.486251  / # export SHELL=3D/bin/sh. /lava-714343/en=
vironment
    2023-07-11T15:02:24.487059  =

    2023-07-11T15:02:24.588899  / # . /lava-714343/environment/lava-714343/=
bin/lava-test-runner /lava-714343/1
    2023-07-11T15:02:24.589979  =

    2023-07-11T15:02:24.593060  / # /lava-714343/bin/lava-test-runner /lava=
-714343/1 =

    ... (12 line(s) more)  =

 =20

