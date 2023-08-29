Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3BCC83F17
	for <webhook@archiver.kernel.org>; Tue, 29 Aug 2023 23:58:09 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.web10.2797.1693353484168089353
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 29 Aug 2023 16:58:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=ez8yG0a4;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.171, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-68c3b9f83f4so2829235b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 29 Aug 2023 16:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1693353483; x=1693958283; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=r6dFMV4yhGrTwG/V62V6U2cohGARN122CbiDw1EuZU8=;
        b=ez8yG0a4brChYIecBQz/Wbn5APFkojT+cF2KRJo5FKw6lLBK9EvcworZWmiRzn0nzZ
         dAugWT0n+741qyoDF5OQ/SwmM0fswX5wImQPaKLs9Py7X57AFenQedOshcuNAuPX4xo5
         hyq/tB/paoyif0emmU+gXD6nng4llDtIPQ4ubq7uOdXoHtPdUmyoqn692PnenvgZPJLv
         YU0sDq7kF/PwRC/+xucdLtJkwf/okvg3um/CJFbEs2x/eS95YEA8suOmBillcr0Srtcz
         dt6ITITM/kqaNnSnQpSIEujVXQXofxLUGQ4cwSDZa4KtTXsp+m3UdKlEPFSlOZAEkEBd
         f4Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693353483; x=1693958283;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r6dFMV4yhGrTwG/V62V6U2cohGARN122CbiDw1EuZU8=;
        b=b18pbGvJKczXbRbqklOn/CINbTDmEsuDJPoMxc67Bik60CUNXdOXQ/BZVBDHT/yXbP
         EznPB2H6gGtKGdw9KxMwe/00VV/nExGX1AAXMNLDzj5QtJWRcdQME8DxlkRP+o4URvzA
         LFztbVXbSZf8fvULgTgLucz/ZBy4hWT0mDn0k2btzpPQY7pX/tQT/fGzoLNLZBWhCJsJ
         smRpxEArIGwIFybob3TfCokqnK6fuZqAvIBjdJ8XhKHbUFjX8JTJMOsaNIGQClDE6zaF
         A3sYVZStlZM1+NMqHGSMZqJtTnhST5P+p38fTrwFZlZAZG6s8NFFte6ZiV6MCNKhSOpQ
         bxyA==
X-Gm-Message-State: AOJu0YwY2L58ybB1ZaxUy9GRi4Yt/FoDsGTTtm5vIe3rsQjTg0xlnCzO
	c3DcADsTfnT4yQeEUIokheX3RGKphJxfgbv/Mb8=
X-Google-Smtp-Source: AGHT+IFWJA26ZFKPYXBXK7rLUoh7+gUovgZau+787IBFRgceU1QF4qxUKIECN/9bNgdxNn5g+kWOtA==
X-Received: by 2002:a05:6a00:2ea6:b0:68b:ed83:9005 with SMTP id fd38-20020a056a002ea600b0068bed839005mr757278pfb.28.1693353482297;
        Tue, 29 Aug 2023 16:58:02 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id z16-20020aa785d0000000b0068bbf578694sm9317453pfn.18.2023.08.29.16.58.01
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 16:58:01 -0700 (PDT)
Message-ID: <64ee8609.a70a0220.dcf1.fbfe@mx.google.com>
Date: Tue, 29 Aug 2023 16:58:01 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.191-cip38-2-g05fb42f86d06a
Subject: cip-gitlab/ci/pavel/linux-test baseline: 96 runs,
 42 regressions (v5.10.191-cip38-2-g05fb42f86d06a)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 29 Aug 2023 23:58:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12899

cip-gitlab/ci/pavel/linux-test baseline: 96 runs, 42 regressions (v5.10.191=
-cip38-2-g05fb42f86d06a)

Regressions Summary
-------------------

platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
acer-cbv514-1h-34uz-brya | x86_64 | lab-collabora   | gcc-10   | x86_64_def=
con...6-chromebook | 1          =

bcm2836-rpi-2-b          | arm    | lab-collabora   | gcc-10   | bcm2835_de=
fconfig            | 1          =

bcm2836-rpi-2-b          | arm    | lab-collabora   | gcc-10   | multi_v7_d=
efconfig           | 1          =

beaglebone-black         | arm    | lab-broonie     | gcc-10   | multi_v7_d=
efconfig           | 7          =

beaglebone-black         | arm    | lab-cip         | gcc-10   | multi_v7_d=
efconfig           | 7          =

beaglebone-black         | arm    | lab-broonie     | gcc-10   | omap2plus_=
defconfig          | 1          =

beaglebone-black         | arm    | lab-cip         | gcc-10   | omap2plus_=
defconfig          | 1          =

hp-x360-14-G1-sona       | x86_64 | lab-collabora   | gcc-10   | x86_64_def=
con...6-chromebook | 1          =

imx6dl-udoo              | arm    | lab-broonie     | gcc-10   | imx_v6_v7_=
defconfig          | 1          =

imx6dl-udoo              | arm    | lab-broonie     | gcc-10   | multi_v7_d=
efconfig           | 1          =

imx6q-udoo               | arm    | lab-broonie     | gcc-10   | imx_v6_v7_=
defconfig          | 1          =

imx6q-udoo               | arm    | lab-broonie     | gcc-10   | multi_v7_d=
efconfig           | 1          =

imx6qp-wandboard-revd1   | arm    | lab-pengutronix | gcc-10   | imx_v6_v7_=
defconfig          | 1          =

imx6qp-wandboard-revd1   | arm    | lab-pengutronix | gcc-10   | multi_v7_d=
efconfig           | 1          =

imx7d-sdb                | arm    | lab-nxp         | gcc-10   | imx_v6_v7_=
defconfig          | 1          =

imx7d-sdb                | arm    | lab-nxp         | gcc-10   | multi_v7_d=
efconfig           | 1          =

mt8173-elm-hana          | arm64  | lab-collabora   | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

qemu_mips-malta          | mips   | lab-broonie     | gcc-10   | malta_defc=
onfig              | 1          =

qemu_mips-malta          | mips   | lab-collabora   | gcc-10   | malta_defc=
onfig              | 1          =

r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip         | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

r8a774b1-hihope-rzg2n-ex | arm64  | lab-cip         | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

r8a774c0-ek874           | arm64  | lab-cip         | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

rk3288-veyron-jaq        | arm    | lab-collabora   | gcc-10   | multi_v7_d=
efconfig           | 5          =

rk3399-gru-kevin         | arm64  | lab-collabora   | gcc-10   | defconfig+=
arm64-chromebook   | 2          =

zynqmp-zcu102            | arm64  | lab-cip         | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.191-cip38-2-g05fb42f86d06a/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.191-cip38-2-g05fb42f86d06a
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      05fb42f86d06ab31aa144cefe1ccd3c7cd8bbc72 =



Test Regressions
---------------- =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
acer-cbv514-1h-34uz-brya | x86_64 | lab-collabora   | gcc-10   | x86_64_def=
con...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ee7bec3f2f02a232286d6c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-acer-cbv514-1h-34uz-brya.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-acer-cbv514-1h-34uz-brya.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ee7bec3f2f02a232286=
d6d
        new failure (last pass: v6.1.46-cip4-rt2) =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
bcm2836-rpi-2-b          | arm    | lab-collabora   | gcc-10   | bcm2835_de=
fconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/64ee781d7ee4013467286d71

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/arm/bcm2835_defconfig/gcc-10/lab-collabor=
a/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/arm/bcm2835_defconfig/gcc-10/lab-collabor=
a/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ee781d7ee4013467286d7a
        failing since 13 days (last pass: v4.19.288-cip101-1117-g1f3468542a=
a9e, first fail: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-29T22:59:56.051644  / # #

    2023-08-29T22:59:56.154023  export SHELL=3D/bin/sh

    2023-08-29T22:59:56.154791  #

    2023-08-29T22:59:56.256242  / # export SHELL=3D/bin/sh. /lava-11378954/=
environment

    2023-08-29T22:59:56.257043  =


    2023-08-29T22:59:56.358543  / # . /lava-11378954/environment/lava-11378=
954/bin/lava-test-runner /lava-11378954/1

    2023-08-29T22:59:56.359773  =


    2023-08-29T22:59:56.374925  / # /lava-11378954/bin/lava-test-runner /la=
va-11378954/1

    2023-08-29T22:59:56.482795  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-29T22:59:56.483312  + cd /lava-11378954/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
bcm2836-rpi-2-b          | arm    | lab-collabora   | gcc-10   | multi_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ee7949a5e0edc45c286d86

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/arm/multi_v7_defconfig/gcc-10/lab-collabo=
ra/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/arm/multi_v7_defconfig/gcc-10/lab-collabo=
ra/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ee794aa5e0edc45c286=
d87
        failing since 13 days (last pass: v4.19.288-cip101-1117-g1f3468542a=
a9e, first fail: v5.10.186-cip37-16-gf8567732a40d) =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
beaglebone-black         | arm    | lab-broonie     | gcc-10   | multi_v7_d=
efconfig           | 7          =


  Details:     https://kernelci.org/test/plan/id/64ee7944d33b943edf286df3

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/arm/multi_v7_defconfig/gcc-10/lab-broonie=
/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/arm/multi_v7_defconfig/gcc-10/lab-broonie=
/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.hdmi-audio: https://kernelci.org/test/case/id/64ee7944d=
33b943edf286dfa
        new failure (last pass: v6.1.46-cip4-rt2)

    2023-08-29T23:03:25.987110  /lava-78033/1/../bin/lava-test-case
    2023-08-29T23:03:26.020880  <8>[   49.484817] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/id/64=
ee7944d33b943edf286dfb
        new failure (last pass: v6.1.46-cip4-rt2)

    2023-08-29T23:03:24.926941  /lava-78033/1/../bin/lava-test-case
    2023-08-29T23:03:24.961703  <8>[   48.424771] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-codec-driver-present: https://kernelci.org/test/ca=
se/id/64ee7944d33b943edf286dfd
        new failure (last pass: v6.1.46-cip4-rt2)

    2023-08-29T23:03:22.757473  /lava-78033/1/../bin/lava-test-case
    2023-08-29T23:03:22.790625  <8>[   46.254768] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-08-29T23:03:23.817906  /lava-78033/1/../bin/lava-test-case
    2023-08-29T23:03:23.855746  <8>[   47.316097] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case/id/=
64ee7944d33b943edf286dfe
        new failure (last pass: v6.1.46-cip4-rt2)

    2023-08-29T23:03:20.629498  /lava-78033/1/../bin/lava-test-case
    2023-08-29T23:03:20.669108  <8>[   44.132089] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-08-29T23:03:21.695396  /lava-78033/1/../bin/lava-test-case
    2023-08-29T23:03:21.730865  <8>[   45.193744] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline.bootrr.tda19988-driver-present: https://kernelci.org/test/case=
/id/64ee7944d33b943edf286dff
        new failure (last pass: v6.1.46-cip4-rt2)

    2023-08-29T23:03:18.504533  /lava-78033/1/../bin/lava-test-case
    2023-08-29T23:03:18.541026  <8>[   42.004526] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-08-29T23:03:19.567939  /lava-78033/1/../bin/lava-test-case
    2023-08-29T23:03:19.602890  <8>[   43.065399] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/64ee7944d33b943edf286e0b
        new failure (last pass: v6.1.46-cip4-rt2)

    2023-08-29T23:03:06.560964  /lava-78033/1/../bin/lava-test-case
    2023-08-29T23:03:06.599536  <8>[   30.061865] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ee7944d33b943edf286e20
        new failure (last pass: v6.1.46-cip4-rt2)

    2023-08-29T23:03:00.816934  <8>[   24.281340] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 78033_1.5.2.4.1>
    2023-08-29T23:03:00.927042  / # #
    2023-08-29T23:03:01.029984  export SHELL=3D/bin/sh
    2023-08-29T23:03:01.030721  #
    2023-08-29T23:03:01.132642  / # export SHELL=3D/bin/sh. /lava-78033/env=
ironment
    2023-08-29T23:03:01.133392  =

    2023-08-29T23:03:01.235801  / # . /lava-78033/environment/lava-78033/bi=
n/lava-test-runner /lava-78033/1
    2023-08-29T23:03:01.237254  =

    2023-08-29T23:03:01.241226  / # /lava-78033/bin/lava-test-runner /lava-=
78033/1
    2023-08-29T23:03:01.336009  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
beaglebone-black         | arm    | lab-cip         | gcc-10   | multi_v7_d=
efconfig           | 7          =


  Details:     https://kernelci.org/test/plan/id/64ee7a00365f5350a1286d85

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/arm/multi_v7_defconfig/gcc-10/lab-cip/bas=
eline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/arm/multi_v7_defconfig/gcc-10/lab-cip/bas=
eline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ee7a00365f5350a1286d88
        new failure (last pass: v6.1.46-cip4-rt2)

    2023-08-29T23:06:00.762476  / # #
    2023-08-29T23:06:00.865460  export SHELL=3D/bin/sh
    2023-08-29T23:06:00.866249  #
    2023-08-29T23:06:00.968071  / # export SHELL=3D/bin/sh. /lava-1002641/e=
nvironment
    2023-08-29T23:06:00.968890  =

    2023-08-29T23:06:01.070750  / # . /lava-1002641/environment/lava-100264=
1/bin/lava-test-runner /lava-1002641/1
    2023-08-29T23:06:01.071940  =

    2023-08-29T23:06:01.085773  / # /lava-1002641/bin/lava-test-runner /lav=
a-1002641/1
    2023-08-29T23:06:01.208627  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-29T23:06:01.209171  + cd /lava-1002641/1/tests/1_bootrr =

    ... (10 line(s) more)  =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/64ee7a00365f5350a1286da1
        new failure (last pass: v6.1.46-cip4-rt2)

    2023-08-29T23:06:06.420988  /lava-1002641/1/../bin/lava-test-case
    2023-08-29T23:06:06.458989  <8>[   22.465265] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.tda19988-driver-present: https://kernelci.org/test/case=
/id/64ee7a00365f5350a1286dad
        new failure (last pass: v6.1.46-cip4-rt2)

    2023-08-29T23:06:18.341046  /lava-1002641/1/../bin/lava-test-case
    2023-08-29T23:06:18.378954  <8>[   34.386157] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-08-29T23:06:19.401756  /lava-1002641/1/../bin/lava-test-case
    2023-08-29T23:06:19.438795  <8>[   35.446187] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case/id/=
64ee7a00365f5350a1286dae
        new failure (last pass: v6.1.46-cip4-rt2)

    2023-08-29T23:06:20.461496  /lava-1002641/1/../bin/lava-test-case
    2023-08-29T23:06:20.499243  <8>[   36.506100] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-08-29T23:06:21.522177  /lava-1002641/1/../bin/lava-test-case
    2023-08-29T23:06:21.564143  <8>[   37.571388] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-codec-driver-present: https://kernelci.org/test/ca=
se/id/64ee7a00365f5350a1286daf
        new failure (last pass: v6.1.46-cip4-rt2)

    2023-08-29T23:06:22.587025  /lava-1002641/1/../bin/lava-test-case
    2023-08-29T23:06:22.626062  <8>[   38.633394] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-08-29T23:06:23.648905  /lava-1002641/1/../bin/lava-test-case
    2023-08-29T23:06:23.699726  <8>[   39.694338] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>
    2023-08-29T23:06:23.700286  /opt/bootrr/libexec/bootrr/boards/ti,am335x=
-bone-black: line 84: assert_device-present: not found
    2023-08-29T23:06:23.700638  /lava-1002641/1/../bin/lava-test-case   =


  * baseline.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/id/64=
ee7a00365f5350a1286db1
        new failure (last pass: v6.1.46-cip4-rt2)

    2023-08-29T23:06:24.748346  /lava-1002641/1/../bin/lava-test-case
    2023-08-29T23:06:24.796141  <8>[   40.804936] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-audio: https://kernelci.org/test/case/id/64ee7a003=
65f5350a1286db2
        new failure (last pass: v6.1.46-cip4-rt2)

    2023-08-29T23:06:25.819133  /lava-1002641/1/../bin/lava-test-case
    2023-08-29T23:06:25.877118  <8>[   41.871604] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>
    2023-08-29T23:06:25.877680  + set +x
    2023-08-29T23:06:25.878032  <8>[   41.886162] <LAVA_SIGNAL_ENDRUN 1_boo=
trr 1002641_1.5.2.4.5>   =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
beaglebone-black         | arm    | lab-broonie     | gcc-10   | omap2plus_=
defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64ee7728e740e172c8286d7c

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/arm/omap2plus_defconfig/gcc-10/lab-brooni=
e/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/arm/omap2plus_defconfig/gcc-10/lab-brooni=
e/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/id/6=
4ee7729e740e172c8286d9b
        new failure (last pass: v6.1.46-cip4-rt2)

    2023-08-29T22:54:17.853625  /lava-78005/1/../bin/lava-test-case
    2023-08-29T22:54:17.896238  <8>[   23.721362] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
beaglebone-black         | arm    | lab-cip         | gcc-10   | omap2plus_=
defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64ee77d7317c30cadd286da3

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/arm/omap2plus_defconfig/gcc-10/lab-cip/ba=
seline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/arm/omap2plus_defconfig/gcc-10/lab-cip/ba=
seline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/id/6=
4ee77d7317c30cadd286dc1
        new failure (last pass: v6.1.46-cip4-rt2)

    2023-08-29T22:57:19.484066  /lava-1002625/1/../bin/lava-test-case
    2023-08-29T22:57:19.525968  <8>[   18.059769] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
hp-x360-14-G1-sona       | x86_64 | lab-collabora   | gcc-10   | x86_64_def=
con...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ee7addfde0b24166286dc7

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ee7addfde0b24166286dd0
        failing since 13 days (last pass: v4.19.288-cip101-1117-g1f3468542a=
a9e, first fail: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-29T23:10:13.278048  + set +x<8>[   10.245678] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11378993_1.4.2.3.1>

    2023-08-29T23:10:13.278132  =


    2023-08-29T23:10:13.379781  #

    2023-08-29T23:10:13.480548  / # #export SHELL=3D/bin/sh

    2023-08-29T23:10:13.480728  =


    2023-08-29T23:10:13.581287  / # export SHELL=3D/bin/sh. /lava-11378993/=
environment

    2023-08-29T23:10:13.581490  =


    2023-08-29T23:10:13.682111  / # . /lava-11378993/environment/lava-11378=
993/bin/lava-test-runner /lava-11378993/1

    2023-08-29T23:10:13.682405  =


    2023-08-29T23:10:13.687052  / # /lava-11378993/bin/lava-test-runner /la=
va-11378993/1
 =

    ... (12 line(s) more)  =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
imx6dl-udoo              | arm    | lab-broonie     | gcc-10   | imx_v6_v7_=
defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64ee78457ee4013467286d86

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/arm/imx_v6_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/arm/imx_v6_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ee78457ee4013467286=
d87
        failing since 7 days (last pass: v4.4-st20-3262-g667bb8d8b2cb, firs=
t fail: v6.1.45-cip3-31-gbae6b8e9a2cff) =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
imx6dl-udoo              | arm    | lab-broonie     | gcc-10   | multi_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ee7a11365f5350a1286dbb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/arm/multi_v7_defconfig/gcc-10/lab-broonie=
/baseline-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/arm/multi_v7_defconfig/gcc-10/lab-broonie=
/baseline-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ee7a11365f5350a1286=
dbc
        new failure (last pass: v6.1.46-cip4-rt2) =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
imx6q-udoo               | arm    | lab-broonie     | gcc-10   | imx_v6_v7_=
defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64ee7847433f5204e0286d71

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/arm/imx_v6_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/arm/imx_v6_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ee7847433f5204e0286=
d72
        failing since 7 days (last pass: v4.4-st20-3262-g667bb8d8b2cb, firs=
t fail: v6.1.45-cip3-31-gbae6b8e9a2cff) =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
imx6q-udoo               | arm    | lab-broonie     | gcc-10   | multi_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ee7b16378f6e9754286d6f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/arm/multi_v7_defconfig/gcc-10/lab-broonie=
/baseline-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/arm/multi_v7_defconfig/gcc-10/lab-broonie=
/baseline-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ee7b16378f6e9754286=
d70
        new failure (last pass: v6.1.46-cip4-rt2) =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
imx6qp-wandboard-revd1   | arm    | lab-pengutronix | gcc-10   | imx_v6_v7_=
defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64ee7728ae32362318286d79

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/arm/imx_v6_v7_defconfig/gcc-10/lab-pengut=
ronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/arm/imx_v6_v7_defconfig/gcc-10/lab-pengut=
ronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ee7728ae32362318286d82
        new failure (last pass: v6.1.46-cip4-rt2)

    2023-08-29T22:54:23.447465  + set +x
    2023-08-29T22:54:23.447815  [   10.184354] <LAVA_SIGNAL_ENDRUN 0_dmesg =
998920_1.5.2.3.1>
    2023-08-29T22:54:23.556110  / # #
    2023-08-29T22:54:23.657743  export SHELL=3D/bin/sh
    2023-08-29T22:54:23.658221  #
    2023-08-29T22:54:23.759439  / # export SHELL=3D/bin/sh. /lava-998920/en=
vironment
    2023-08-29T22:54:23.759791  =

    2023-08-29T22:54:23.861148  / # . /lava-998920/environment/lava-998920/=
bin/lava-test-runner /lava-998920/1
    2023-08-29T22:54:23.861739  =

    2023-08-29T22:54:23.864740  / # /lava-998920/bin/lava-test-runner /lava=
-998920/1 =

    ... (12 line(s) more)  =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
imx6qp-wandboard-revd1   | arm    | lab-pengutronix | gcc-10   | multi_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ee78f47f7bd94c90286d81

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/arm/multi_v7_defconfig/gcc-10/lab-pengutr=
onix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/arm/multi_v7_defconfig/gcc-10/lab-pengutr=
onix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ee78f47f7bd94c90286d8a
        new failure (last pass: v6.1.46-cip4-rt2)

    2023-08-29T23:02:04.379563  + set[    7.191574] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 998923_1.5.2.3.1>
    2023-08-29T23:02:04.379838   +x
    2023-08-29T23:02:04.485201  / # #
    2023-08-29T23:02:04.586896  export SHELL=3D/bin/sh
    2023-08-29T23:02:04.587398  #
    2023-08-29T23:02:04.688772  / # export SHELL=3D/bin/sh. /lava-998923/en=
vironment
    2023-08-29T23:02:04.689298  =

    2023-08-29T23:02:04.790658  / # . /lava-998923/environment/lava-998923/=
bin/lava-test-runner /lava-998923/1
    2023-08-29T23:02:04.791322  =

    2023-08-29T23:02:04.793698  / # /lava-998923/bin/lava-test-runner /lava=
-998923/1 =

    ... (12 line(s) more)  =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
imx7d-sdb                | arm    | lab-nxp         | gcc-10   | imx_v6_v7_=
defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64ee778a1100418763286d99

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/arm/imx_v6_v7_defconfig/gcc-10/lab-nxp/ba=
seline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/arm/imx_v6_v7_defconfig/gcc-10/lab-nxp/ba=
seline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.all-cpus-are-online: https://kernelci.org/test/case/id/=
64ee778a1100418763286d9d
        new failure (last pass: v6.1.46-cip4-rt2)

    2023-08-29T22:55:53.584822  /lava-1247800/1/../bin/lava-test-case
    2023-08-29T22:55:53.622763  <8>[   32.709304] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dall-cpus-are-online RESULT=3Dfail>   =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
imx7d-sdb                | arm    | lab-nxp         | gcc-10   | multi_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ee79560afe93212f286d6d

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/arm/multi_v7_defconfig/gcc-10/lab-nxp/bas=
eline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/arm/multi_v7_defconfig/gcc-10/lab-nxp/bas=
eline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.all-cpus-are-online: https://kernelci.org/test/case/id/=
64ee79560afe93212f286d71
        new failure (last pass: v6.1.46-cip4-rt2)

    2023-08-29T23:03:39.863150  /lava-1247804/1/../bin/lava-test-case
    2023-08-29T23:03:39.906474  <8>[   25.002691] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dall-cpus-are-online RESULT=3Dfail>
    2023-08-29T23:03:39.906724  /lava-1247804/1/../bin/lava-test-case   =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
mt8173-elm-hana          | arm64  | lab-collabora   | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64ee78a020a1c3c356286da1

  Results:     28 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/baseline-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/baseline-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ee78a020a1c3c356286dc1
        new failure (last pass: v6.1.46-cip4-rt2)

    2023-08-29T23:00:42.651730  + set +x

    2023-08-29T23:00:42.657065  <8>[   15.631202] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11378964_1.5.2.3.1>

    2023-08-29T23:00:42.765521  =


    2023-08-29T23:00:42.867724  / # #export SHELL=3D/bin/sh

    2023-08-29T23:00:42.868569  =


    2023-08-29T23:00:42.970148  / # export SHELL=3D/bin/sh. /lava-11378964/=
environment

    2023-08-29T23:00:42.970943  =


    2023-08-29T23:00:43.072540  / # . /lava-11378964/environment/lava-11378=
964/bin/lava-test-runner /lava-11378964/1

    2023-08-29T23:00:43.073818  =


    2023-08-29T23:00:43.075656  / # /lava-11378964/bin/lava-test-runner /la=
va-11378964/1
 =

    ... (20 line(s) more)  =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
qemu_mips-malta          | mips   | lab-broonie     | gcc-10   | malta_defc=
onfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/64ee79d117b671cad0286d70

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/mips/malta_defconfig/gcc-10/lab-broonie/b=
aseline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/mips/malta_defconfig/gcc-10/lab-broonie/b=
aseline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ee79d117b671cad0286=
d71
        new failure (last pass: v6.1.46-cip4-rt2) =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
qemu_mips-malta          | mips   | lab-collabora   | gcc-10   | malta_defc=
onfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/64ee79b46865da4200286d6c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/mips/malta_defconfig/gcc-10/lab-collabora=
/baseline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/mips/malta_defconfig/gcc-10/lab-collabora=
/baseline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ee79b46865da4200286=
d6d
        new failure (last pass: v6.1.46-cip4-rt2) =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip         | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64ee7919a5e0edc45c286d6c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-cip/baseline-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-cip/baseline-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ee7919a5e0edc45c286d6f
        new failure (last pass: v6.1.46-cip4-rt2)

    2023-08-29T23:02:35.875428  + set +x
    2023-08-29T23:02:35.875642  <8>[   83.993599] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1002630_1.5.2.4.1>
    2023-08-29T23:02:35.982685  / # #
    2023-08-29T23:02:37.443276  export SHELL=3D/bin/sh
    2023-08-29T23:02:37.463713  #
    2023-08-29T23:02:37.463839  / # export SHELL=3D/bin/sh
    2023-08-29T23:02:39.417985  / # . /lava-1002630/environment
    2023-08-29T23:02:43.015440  /lava-1002630/bin/lava-test-runner /lava-10=
02630/1
    2023-08-29T23:02:43.036257  . /lava-1002630/environment
    2023-08-29T23:02:43.036368  / # /lava-1002630/bin/lava-test-runner /lav=
a-1002630/1 =

    ... (28 line(s) more)  =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
r8a774b1-hihope-rzg2n-ex | arm64  | lab-cip         | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64ee792dd33b943edf286dd7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-cip/baseline-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-cip/baseline-r8a774b1-hihope-rzg2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ee792dd33b943edf286dda
        failing since 13 days (last pass: v4.19.288-cip101-1117-g1f3468542a=
a9e, first fail: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-29T23:02:49.656753  + set +x
    2023-08-29T23:02:49.656995  <8>[   84.191014] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1002629_1.5.2.4.1>
    2023-08-29T23:02:49.763555  / # #
    2023-08-29T23:02:51.225889  export SHELL=3D/bin/sh
    2023-08-29T23:02:51.246746  #
    2023-08-29T23:02:51.247060  / # export SHELL=3D/bin/sh
    2023-08-29T23:02:53.203666  / # . /lava-1002629/environment
    2023-08-29T23:02:56.803713  /lava-1002629/bin/lava-test-runner /lava-10=
02629/1
    2023-08-29T23:02:56.831199  . /lava-1002629/environment
    2023-08-29T23:02:56.831547  / # /lava-1002629/bin/lava-test-runner /lav=
a-1002629/1 =

    ... (15 line(s) more)  =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
r8a774c0-ek874           | arm64  | lab-cip         | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64ee796a75000dc59a286d77

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ee796a75000dc59a286d7a
        failing since 13 days (last pass: v4.19.288-cip101-1117-g1f3468542a=
a9e, first fail: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-29T23:03:49.549274  / # #
    2023-08-29T23:03:51.011541  export SHELL=3D/bin/sh
    2023-08-29T23:03:51.032114  #
    2023-08-29T23:03:51.032342  / # export SHELL=3D/bin/sh
    2023-08-29T23:03:52.987477  / # . /lava-1002638/environment
    2023-08-29T23:03:56.585040  /lava-1002638/bin/lava-test-runner /lava-10=
02638/1
    2023-08-29T23:03:56.605848  . /lava-1002638/environment
    2023-08-29T23:03:56.605961  / # /lava-1002638/bin/lava-test-runner /lav=
a-1002638/1
    2023-08-29T23:03:56.685394  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-29T23:03:56.685707  + cd /lava-1002638/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
rk3288-veyron-jaq        | arm    | lab-collabora   | gcc-10   | multi_v7_d=
efconfig           | 5          =


  Details:     https://kernelci.org/test/plan/id/64ee790ed33b943edf286d70

  Results:     63 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/arm/multi_v7_defconfig/gcc-10/lab-collabo=
ra/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/arm/multi_v7_defconfig/gcc-10/lab-collabo=
ra/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-iodomain-grf-probed: https://kernelci.org/test=
/case/id/64ee790ed33b943edf286d8a
        new failure (last pass: v6.1.46-cip4-rt2)

    2023-08-29T23:04:12.208090  =


    2023-08-29T23:04:13.219047  /lava-11378973/1/../bin/lava-test-case

    2023-08-29T23:04:13.228052  <8>[   21.913080] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-iodomain-grf-probed RESULT=3Dfail>
   =


  * baseline.bootrr.dwmmc_rockchip-sdio0-probed: https://kernelci.org/test/=
case/id/64ee790ed33b943edf286da0
        new failure (last pass: v6.1.46-cip4-rt2)

    2023-08-29T23:04:10.794616  /lava-11378973/1/../bin/lava-test-case<8>[ =
  19.479401] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwmmc_rockchip-sdmmc-prob=
ed RESULT=3Dfail>

    2023-08-29T23:04:10.794677  =


    2023-08-29T23:04:11.805971  /lava-11378973/1/../bin/lava-test-case

    2023-08-29T23:04:11.814985  <8>[   20.499956] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwmmc_rockchip-sdio0-probed RESULT=3Dfail>
   =


  * baseline.bootrr.dwmmc_rockchip-sdmmc-probed: https://kernelci.org/test/=
case/id/64ee790ed33b943edf286da1
        new failure (last pass: v6.1.46-cip4-rt2)

    2023-08-29T23:04:09.773669  	-w	P<8>[   18.454839] <LAVA_SIGNAL_TESTCAS=
E TEST_CASE_ID=3Ddwmmc_rockchip-driver-present RESULT=3Dpass>

    2023-08-29T23:04:09.776625  ad to last with leading zeros

    2023-08-29T23:04:09.779094  	-s SEP	String separator

    2023-08-29T23:04:09.783081  /lava-11378973/1/../bin/lava-test-case

    2023-08-29T23:04:09.788963  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.

    2023-08-29T23:04:09.789188  =


    2023-08-29T23:04:09.793620  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-08-29T23:04:09.793850  =


    2023-08-29T23:04:09.798962  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-08-29T23:04:09.801479  FIRST, INC default to 1.
 =

    ... (5 line(s) more)  =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/64ee790ed33b943edf286da4
        failing since 221 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-08-29T23:04:09.701104  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC)<8=
>[   18.385064] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-08-29T23:04:09.702806   multi-call binary.

    2023-08-29T23:04:09.703025  =


    2023-08-29T23:04:09.707374  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-08-29T23:04:09.707766  =


    2023-08-29T23:04:09.712779  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/64ee790ed33b943edf286da5
        failing since 221 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-08-29T23:04:09.682027  <8>[   18.367060] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>
   =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
rk3399-gru-kevin         | arm64  | lab-collabora   | gcc-10   | defconfig+=
arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64ee78b82468e1cf27286d6f

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/64ee78b82468e1cf27286d79
        new failure (last pass: v6.1.46-cip4-rt2)

    2023-08-29T23:02:09.652273  <8>[   34.100073] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-08-29T23:02:10.675305  /lava-11378970/1/../bin/lava-test-case

    2023-08-29T23:02:10.686435  <8>[   35.135746] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/64ee78b82468e1cf27286d7a
        new failure (last pass: v6.1.46-cip4-rt2)

    2023-08-29T23:02:09.640333  /lava-11378970/1/../bin/lava-test-case
   =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
zynqmp-zcu102            | arm64  | lab-cip         | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64ee79b76865da4200286d72

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ee79b76865da4200286=
d73
        new failure (last pass: v6.1.46-cip4-rt2) =

 =20

