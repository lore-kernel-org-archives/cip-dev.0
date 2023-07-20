Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61735C0015E
	for <webhook@archiver.kernel.org>; Thu, 20 Jul 2023 21:50:47 +0000 (UTC)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
 by mx.groups.io with SMTP id smtpd.web10.2862.1689889845815785267
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 20 Jul 2023 14:50:45 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=oEO3vXah;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.180, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-56345ab18b0so695056a12.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 20 Jul 2023 14:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689889844; x=1690494644;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=crAdMVhqFurItrE5JrJMXrCkm9RaCsrcsvqIag+yYp8=;
        b=oEO3vXahG6XcTz0YH6IPwl4yiLVs6HcBCy+JaHnF81l82X+CI4FdQ0aO9C3+1oi2+7
         uCQ1xsEYXC+cZ6zGt+iKPXiuAyDnayUo/r5rjxnIlXv/ZXaDKj9y+ZK9zdx41i6zETmv
         bhBPIUyILuBL5C0rekdQGz3rZAebb5VZ6m+w/iB74ZB8XDYOF37oJnjlzAUJ3FyinMf9
         eKREHVWkG7TBw7BTLQcLu6Yrz9TuNMF1iOkHE3F9qwXMUdHxcpqlcGjMvsaCrbF0MeOJ
         tFS6M1EGpGKQ2M6Jc1FP9juzV0T3Ae0dks+pkhL5KI0YJb1coMiTXhZ1yvE8vQS8OYx+
         HpyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689889844; x=1690494644;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=crAdMVhqFurItrE5JrJMXrCkm9RaCsrcsvqIag+yYp8=;
        b=P2F1LgVjEiqI2I0zJYFvpUo0+VXft5v5PS1wQAKleJgEzH7nVIMKmgXM8zMzbXs63D
         jeVaFLcGMKQ4HYl5Xkx5vGTpT/xtsYP6Stle0dR2HoZnJ2Fe29idfp/RWy6duLSLyfG5
         HCCQuBxzV+Zu0An6a/cFCUHlCQQTjgl9t9gvR7Um0uaOtU44WCyyJcyjSreOIh2hFN1G
         jaNFNI4nmHiIdmveR2CeYTolpZirTvhDeQ6GNGErEY4BnWYFQgNEjhzirCdc1OOEuQAi
         +FhS/73HaoephPgwFYltauw8L2FIyfJGuwQ7XB0zek71rjV74xELmCesIr4Yjn2oZp+C
         /cCA==
X-Gm-Message-State: ABy/qLZ76uBC29kE+3u3Zh35Zudoi8ggnyD4lRCbiwGXD64RWuaOjF/z
	1hHEHA88owa2add+svJ5Jky+Cu32KAxft8rg5RTl+w==
X-Google-Smtp-Source: APBJJlFGnQPsdwhxiWMv58gKV6xPVIHFt3f0Ohg+bFdjkxHwzf7OgU5OVFeRQQcvG2EicFLb9Znuug==
X-Received: by 2002:a17:902:d4c4:b0:1bb:35b6:4490 with SMTP id o4-20020a170902d4c400b001bb35b64490mr241213plg.22.1689889844024;
        Thu, 20 Jul 2023 14:50:44 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id s9-20020a170902b18900b001b9de39905asm1895241plr.59.2023.07.20.14.50.42
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 14:50:42 -0700 (PDT)
Message-ID: <64b9ac32.170a0220.5acc8.4225@mx.google.com>
Date: Thu, 20 Jul 2023 14:50:42 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v5.10.186-cip37-11-gafa55beeffce9
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline: 65 runs,
 34 regressions (v5.10.186-cip37-11-gafa55beeffce9)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Jul 2023 21:50:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12488

cip-gitlab/ci/pavel/linux-test baseline: 65 runs, 34 regressions (v5.10.186=
-cip37-11-gafa55beeffce9)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cbv514-1h-34uz-brya     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | bcm283=
5_defconfig            | 1          =

bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 7          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig           | 7          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =

imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =

imx7ulp-evk                  | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =

rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 5          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.186-cip37-11-gafa55beeffce9/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.186-cip37-11-gafa55beeffce9
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      afa55beeffce969994d148ab3f2c8871b09e8945 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cbv514-1h-34uz-brya     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64b9953a6c132387508ace2c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-11-gafa55beeffce9/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/baseline-acer-cbv514-1h-34uz-brya.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-11-gafa55beeffce9/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/baseline-acer-cbv514-1h-34uz-brya.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64b9953a6c132387508ac=
e2d
        failing since 1 day (last pass: v6.1.38-cip1-10-g02aa22be941dd, fir=
st fail: v5.10.186-cip37-2-gfcd111609480) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | bcm283=
5_defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/64b99eeeb56195c50f8ace24

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-11-gafa55beeffce9/arm/bcm2835_defconfig/gcc-10/lab-collabo=
ra/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-11-gafa55beeffce9/arm/bcm2835_defconfig/gcc-10/lab-collabo=
ra/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b99eeeb56195c50f8ace29
        failing since 1 day (last pass: v5.10.184-cip36-13-g8201543bbc8b6, =
first fail: v6.1.38-cip1-10-g02aa22be941dd)

    2023-07-20T20:55:24.608984  / # #

    2023-07-20T20:55:24.711184  export SHELL=3D/bin/sh

    2023-07-20T20:55:24.711899  #

    2023-07-20T20:55:24.813340  / # export SHELL=3D/bin/sh. /lava-11121040/=
environment

    2023-07-20T20:55:24.814124  =


    2023-07-20T20:55:24.915628  / # . /lava-11121040/environment/lava-11121=
040/bin/lava-test-runner /lava-11121040/1

    2023-07-20T20:55:24.916732  =


    2023-07-20T20:55:24.961466  / # /lava-11121040/bin/lava-test-runner /la=
va-11121040/1

    2023-07-20T20:55:24.998135  + export 'TESTRUN_ID=3D1_bootrr'

    2023-07-20T20:55:25.036018  + cd /lava-11121040/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64b98a366b0d24c0f88ace65

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-11-gafa55beeffce9/arm/multi_v7_defconfig/gcc-10/lab-collab=
ora/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-11-gafa55beeffce9/arm/multi_v7_defconfig/gcc-10/lab-collab=
ora/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64b98a366b0d24c0f88ac=
e66
        failing since 36 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 7          =


  Details:     https://kernelci.org/test/plan/id/64b98a276b0d24c0f88ace1c

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-11-gafa55beeffce9/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-11-gafa55beeffce9/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.hdmi-audio: https://kernelci.org/test/case/id/64b98a276=
b0d24c0f88ace1f
        failing since 0 day (last pass: v6.1.38-cip1-13-ga3621452a4fc, firs=
t fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-07-20T19:25:19.848831  /lava-4134/1/../bin/lava-test-case
    2023-07-20T19:25:19.883905  <8>[   47.320886] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/id/64=
b98a276b0d24c0f88ace20
        failing since 0 day (last pass: v6.1.38-cip1-13-ga3621452a4fc, firs=
t fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-07-20T19:25:18.786570  /lava-4134/1/../bin/lava-test-case
    2023-07-20T19:25:18.822874  <8>[   46.259114] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-codec-driver-present: https://kernelci.org/test/ca=
se/id/64b98a276b0d24c0f88ace22
        failing since 0 day (last pass: v6.1.38-cip1-13-ga3621452a4fc, firs=
t fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-07-20T19:25:16.610764  /lava-4134/1/../bin/lava-test-case
    2023-07-20T19:25:16.644943  <8>[   44.082008] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-07-20T19:25:17.672598  /lava-4134/1/../bin/lava-test-case
    2023-07-20T19:25:17.714936  <8>[   45.148263] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case/id/=
64b98a276b0d24c0f88ace23
        failing since 0 day (last pass: v6.1.38-cip1-13-ga3621452a4fc, firs=
t fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-07-20T19:25:14.483156  /lava-4134/1/../bin/lava-test-case
    2023-07-20T19:25:14.522183  <8>[   41.958006] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-07-20T19:25:15.548523  /lava-4134/1/../bin/lava-test-case
    2023-07-20T19:25:15.584315  <8>[   43.020099] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline.bootrr.tda19988-driver-present: https://kernelci.org/test/case=
/id/64b98a276b0d24c0f88ace24
        failing since 0 day (last pass: v6.1.38-cip1-13-ga3621452a4fc, firs=
t fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-07-20T19:25:12.362404  /lava-4134/1/../bin/lava-test-case
    2023-07-20T19:25:12.395964  <8>[   39.832075] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-07-20T19:25:13.422442  /lava-4134/1/../bin/lava-test-case
    2023-07-20T19:25:13.456890  <8>[   40.892248] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/64b98a276b0d24c0f88ace30
        failing since 0 day (last pass: v6.1.38-cip1-13-ga3621452a4fc, firs=
t fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-07-20T19:25:00.433757  /lava-4134/1/../bin/lava-test-case
    2023-07-20T19:25:00.473317  <8>[   27.908122] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b98a276b0d24c0f88ace46
        failing since 0 day (last pass: v6.1.38-cip1-13-ga3621452a4fc, firs=
t fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-07-20T19:24:54.687237  <8>[   22.123756] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 4134_1.5.2.4.1>
    2023-07-20T19:24:54.796172  / # #
    2023-07-20T19:24:54.898909  export SHELL=3D/bin/sh
    2023-07-20T19:24:54.899550  #
    2023-07-20T19:24:55.001721  / # export SHELL=3D/bin/sh. /lava-4134/envi=
ronment
    2023-07-20T19:24:55.002364  =

    2023-07-20T19:24:55.104767  / # . /lava-4134/environment/lava-4134/bin/=
lava-test-runner /lava-4134/1
    2023-07-20T19:24:55.105763  =

    2023-07-20T19:24:55.110459  / # /lava-4134/bin/lava-test-runner /lava-4=
134/1
    2023-07-20T19:24:55.202323  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig           | 7          =


  Details:     https://kernelci.org/test/plan/id/64b98a299155931d428ace1e

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-11-gafa55beeffce9/arm/multi_v7_defconfig/gcc-10/lab-cip/ba=
seline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-11-gafa55beeffce9/arm/multi_v7_defconfig/gcc-10/lab-cip/ba=
seline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b98a299155931d428ace21
        failing since 0 day (last pass: v6.1.38-cip1-13-ga3621452a4fc, firs=
t fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-07-20T19:24:40.398520  <8>[   15.748367] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 988052_1.5.2.4.1>
    2023-07-20T19:24:40.508446  / # #
    2023-07-20T19:24:40.611114  export SHELL=3D/bin/sh
    2023-07-20T19:24:40.611817  #
    2023-07-20T19:24:40.713700  / # export SHELL=3D/bin/sh. /lava-988052/en=
vironment
    2023-07-20T19:24:40.714405  =

    2023-07-20T19:24:40.816177  / # . /lava-988052/environment/lava-988052/=
bin/lava-test-runner /lava-988052/1
    2023-07-20T19:24:40.817358  =

    2023-07-20T19:24:40.823489  / # /lava-988052/bin/lava-test-runner /lava=
-988052/1
    2023-07-20T19:24:40.916368  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/64b98a299155931d428ace3a
        failing since 0 day (last pass: v6.1.38-cip1-13-ga3621452a4fc, firs=
t fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-07-20T19:24:46.160383  /lava-988052/1/../bin/lava-test-case
    2023-07-20T19:24:46.194146  <8>[   21.542626] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.tda19988-driver-present: https://kernelci.org/test/case=
/id/64b98a299155931d428ace46
        failing since 0 day (last pass: v6.1.38-cip1-13-ga3621452a4fc, firs=
t fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-07-20T19:24:58.100771  /lava-988052/1/../bin/lava-test-case
    2023-07-20T19:24:58.137916  <8>[   33.488201] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-07-20T19:24:59.165546  /lava-988052/1/../bin/lava-test-case
    2023-07-20T19:24:59.201685  <8>[   34.550652] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case/id/=
64b98a299155931d428ace47
        failing since 0 day (last pass: v6.1.38-cip1-13-ga3621452a4fc, firs=
t fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-07-20T19:25:00.228577  /lava-988052/1/../bin/lava-test-case
    2023-07-20T19:25:00.261540  <8>[   35.611990] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-07-20T19:25:01.289222  /lava-988052/1/../bin/lava-test-case
    2023-07-20T19:25:01.323429  <8>[   36.672593] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-codec-driver-present: https://kernelci.org/test/ca=
se/id/64b98a299155931d428ace48
        failing since 0 day (last pass: v6.1.38-cip1-13-ga3621452a4fc, firs=
t fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-07-20T19:25:02.349009  /lava-988052/1/../bin/lava-test-case
    2023-07-20T19:25:02.382982  <8>[   37.732599] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-07-20T19:25:03.408797  /lava-988052/1/../bin/lava-test-case
    2023-07-20T19:25:03.444576  <8>[   38.792470] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/id/64=
b98a299155931d428ace4a
        failing since 0 day (last pass: v6.1.38-cip1-13-ga3621452a4fc, firs=
t fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-07-20T19:25:04.516533  /lava-988052/1/../bin/lava-test-case
    2023-07-20T19:25:04.550512  <8>[   39.901220] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-audio: https://kernelci.org/test/case/id/64b98a299=
155931d428ace4b
        failing since 0 day (last pass: v6.1.38-cip1-13-ga3621452a4fc, firs=
t fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-07-20T19:25:05.577118  /lava-988052/1/../bin/lava-test-case
    2023-07-20T19:25:05.611108  <8>[   40.961323] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64b9943c24c3d6f13c8ace1e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-11-gafa55beeffce9/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-11-gafa55beeffce9/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b9943c24c3d6f13c8ace23
        failing since 36 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-07-20T20:08:52.804393  + <8>[   10.602071] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11120955_1.4.2.3.1>

    2023-07-20T20:08:52.804475  set +x

    2023-07-20T20:08:52.905622  #

    2023-07-20T20:08:52.905852  =


    2023-07-20T20:08:53.006426  / # #export SHELL=3D/bin/sh

    2023-07-20T20:08:53.006591  =


    2023-07-20T20:08:53.107091  / # export SHELL=3D/bin/sh. /lava-11120955/=
environment

    2023-07-20T20:08:53.107272  =


    2023-07-20T20:08:53.207830  / # . /lava-11120955/environment/lava-11120=
955/bin/lava-test-runner /lava-11120955/1

    2023-07-20T20:08:53.208086  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64b9943e63c3da99668ace5d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-11-gafa55beeffce9/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-11-gafa55beeffce9/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b9943e63c3da99668ace62
        failing since 36 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-07-20T20:08:16.022038  <8>[   12.729041] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11120936_1.4.2.3.1>

    2023-07-20T20:08:16.025577  + set +x

    2023-07-20T20:08:16.130926  =


    2023-07-20T20:08:16.232588  / # #export SHELL=3D/bin/sh

    2023-07-20T20:08:16.233259  =


    2023-07-20T20:08:16.334569  / # export SHELL=3D/bin/sh. /lava-11120936/=
environment

    2023-07-20T20:08:16.335416  =


    2023-07-20T20:08:16.437324  / # . /lava-11120936/environment/lava-11120=
936/bin/lava-test-runner /lava-11120936/1

    2023-07-20T20:08:16.438826  =


    2023-07-20T20:08:16.443817  / # /lava-11120936/bin/lava-test-runner /la=
va-11120936/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64b99428d700933c208ace37

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-11-gafa55beeffce9/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-11-gafa55beeffce9/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64b99428d700933c208ac=
e38
        failing since 36 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64b98aef68ad74c9aa8ace1c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-11-gafa55beeffce9/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-11-gafa55beeffce9/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64b98aef68ad74c9aa8ac=
e1d
        failing since 0 day (last pass: v6.1.38-cip1-13-ga3621452a4fc, firs=
t fail: v5.10.186-cip37-12-gf8c9ce666de7b) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64b9942963c3da99668ace1c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-11-gafa55beeffce9/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-11-gafa55beeffce9/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64b9942963c3da99668ac=
e1d
        failing since 36 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64b98af024b56132338ace28

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-11-gafa55beeffce9/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-11-gafa55beeffce9/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64b98af024b56132338ac=
e29
        failing since 0 day (last pass: v6.1.38-cip1-13-ga3621452a4fc, firs=
t fail: v5.10.186-cip37-12-gf8c9ce666de7b) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64b9932073646f72d78ace1c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-11-gafa55beeffce9/arm/imx_v6_v7_defconfig/gcc-10/lab-pengu=
tronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-11-gafa55beeffce9/arm/imx_v6_v7_defconfig/gcc-10/lab-pengu=
tronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b9932073646f72d78ace21
        failing since 0 day (last pass: v6.1.38-cip1-13-ga3621452a4fc, firs=
t fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-07-20T20:03:37.433477  + set +x
    2023-07-20T20:03:37.433659  [   10.366864] <LAVA_SIGNAL_ENDRUN 0_dmesg =
995863_1.5.2.3.1>
    2023-07-20T20:03:37.542071  / # #
    2023-07-20T20:03:37.643668  export SHELL=3D/bin/sh
    2023-07-20T20:03:37.644106  #
    2023-07-20T20:03:37.745355  / # export SHELL=3D/bin/sh. /lava-995863/en=
vironment
    2023-07-20T20:03:37.745880  =

    2023-07-20T20:03:37.847106  / # . /lava-995863/environment/lava-995863/=
bin/lava-test-runner /lava-995863/1
    2023-07-20T20:03:37.847651  =

    2023-07-20T20:03:37.850387  / # /lava-995863/bin/lava-test-runner /lava=
-995863/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64b989e76469adda348ace9f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-11-gafa55beeffce9/arm/multi_v7_defconfig/gcc-10/lab-pengut=
ronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-11-gafa55beeffce9/arm/multi_v7_defconfig/gcc-10/lab-pengut=
ronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b989e76469adda348acea4
        failing since 0 day (last pass: v6.1.38-cip1-13-ga3621452a4fc, firs=
t fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-07-20T19:24:04.701589  + set[    7.274289] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 995860_1.5.2.3.1>
    2023-07-20T19:24:04.701920   +x
    2023-07-20T19:24:04.808131  / # #
    2023-07-20T19:24:04.909952  export SHELL=3D/bin/sh
    2023-07-20T19:24:04.910422  #
    2023-07-20T19:24:05.011680  / # export SHELL=3D/bin/sh. /lava-995860/en=
vironment
    2023-07-20T19:24:05.012148  =

    2023-07-20T19:24:05.113434  / # . /lava-995860/environment/lava-995860/=
bin/lava-test-runner /lava-995860/1
    2023-07-20T19:24:05.114097  =

    2023-07-20T19:24:05.116295  / # /lava-995860/bin/lava-test-runner /lava=
-995860/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64b99383167d377cb68ace2c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-11-gafa55beeffce9/arm/imx_v6_v7_defconfig/gcc-10/lab-nxp/b=
aseline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-11-gafa55beeffce9/arm/imx_v6_v7_defconfig/gcc-10/lab-nxp/b=
aseline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.all-cpus-are-online: https://kernelci.org/test/case/id/=
64b99383167d377cb68ace30
        failing since 0 day (last pass: v6.1.38-cip1-13-ga3621452a4fc, firs=
t fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-07-20T20:04:59.143996  /lava-1237813/1/../bin/lava-test-case
    2023-07-20T20:04:59.181039  <8>[   32.041086] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dall-cpus-are-online RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64b98a389155931d428ace67

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-11-gafa55beeffce9/arm/multi_v7_defconfig/gcc-10/lab-nxp/ba=
seline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-11-gafa55beeffce9/arm/multi_v7_defconfig/gcc-10/lab-nxp/ba=
seline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.all-cpus-are-online: https://kernelci.org/test/case/id/=
64b98a389155931d428ace6b
        failing since 0 day (last pass: v6.1.38-cip1-13-ga3621452a4fc, firs=
t fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-07-20T19:25:30.402200  /lava-1237809/1/../bin/lava-test-case
    2023-07-20T19:25:30.423612  <8>[   24.924953] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dall-cpus-are-online RESULT=3Dfail>
    2023-07-20T19:25:30.423935  /lava-1237809/1/../bin/lava-test-case   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7ulp-evk                  | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64b98a486b0d24c0f88ace6b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-11-gafa55beeffce9/arm/multi_v7_defconfig/gcc-10/lab-nxp/ba=
seline-imx7ulp-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-11-gafa55beeffce9/arm/multi_v7_defconfig/gcc-10/lab-nxp/ba=
seline-imx7ulp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b98a486b0d24c0f88ace6e
        failing since 120 days (last pass: v5.10.145-rt74-1329-ga59fc50f38f=
6, first fail: v5.10.175-cip29-rt12)

    2023-07-20T19:25:29.618197  + set +x
    2023-07-20T19:25:29.621352  <8>[   28.999886] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1237806_1.5.2.4.1>
    2023-07-20T19:25:29.730204  / # #
    2023-07-20T19:25:30.886259  export SHELL=3D/bin/sh
    2023-07-20T19:25:30.891913  #
    2023-07-20T19:25:30.892236  / # export SHELL=3D/bin/sh
    2023-07-20T19:25:32.434456  / # . /lava-1237806/environment
    2023-07-20T19:25:35.251879  /lava-1237806/bin/lava-test-runner /lava-12=
37806/1
    2023-07-20T19:25:35.257830  . /lava-1237806/environment
    2023-07-20T19:25:35.258073  / # /lava-1237806/bin/lava-test-runner /lav=
a-1237806/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64b98ae624b56132338ace21

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-11-gafa55beeffce9/arm/shmobile_defconfig/gcc-10/lab-cip/ba=
seline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-11-gafa55beeffce9/arm/shmobile_defconfig/gcc-10/lab-cip/ba=
seline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64b98ae624b56132338ac=
e22
        failing since 11 days (last pass: v6.1.31-61-g32a95f5a4e3b, first f=
ail: v6.1.31-65-geef5a19d48f6) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 5          =


  Details:     https://kernelci.org/test/plan/id/64b989e66469adda348ace54

  Results:     63 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-11-gafa55beeffce9/arm/multi_v7_defconfig/gcc-10/lab-collab=
ora/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-11-gafa55beeffce9/arm/multi_v7_defconfig/gcc-10/lab-collab=
ora/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-iodomain-grf-probed: https://kernelci.org/test=
/case/id/64b989e66469adda348ace6c
        failing since 0 day (last pass: v6.1.38-cip1-13-ga3621452a4fc, firs=
t fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-07-20T19:25:54.620654  <8>[   21.563542] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-iodomain-driver-present RESULT=3Dpass>
   =


  * baseline.bootrr.dwmmc_rockchip-sdio0-probed: https://kernelci.org/test/=
case/id/64b989e66469adda348ace82
        failing since 0 day (last pass: v6.1.38-cip1-13-ga3621452a4fc, firs=
t fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-07-20T19:25:53.206160  /lava-11120893/1/../bin/lava-test-case<8>[ =
  20.149567] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwmmc_rockchip-sdmmc-prob=
ed RESULT=3Dfail>

    2023-07-20T19:25:53.206218  =


    2023-07-20T19:25:54.217791  /lava-11120893/1/../bin/lava-test-case

    2023-07-20T19:25:54.226803  <8>[   21.170316] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwmmc_rockchip-sdio0-probed RESULT=3Dfail>
   =


  * baseline.bootrr.dwmmc_rockchip-sdmmc-probed: https://kernelci.org/test/=
case/id/64b989e66469adda348ace83
        failing since 0 day (last pass: v6.1.38-cip1-13-ga3621452a4fc, firs=
t fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-07-20T19:25:52.185322  Print numbers from FI<8>[   19.129158] <LAV=
A_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwmmc_rockchip-driver-present RESULT=3Dpas=
s>

    2023-07-20T19:25:52.188096  RST to LAST, in steps of INC.

    2023-07-20T19:25:52.190558  FIRST, INC default to 1.

    2023-07-20T19:25:52.190778  =


    2023-07-20T19:25:52.194371  	-w	Pad to last with leading zeros

    2023-07-20T19:25:52.196858  	-s SEP	String separator

    2023-07-20T19:25:52.200677  /lava-11120893/1/../bin/lava-test-case

    2023-07-20T19:25:52.206612  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.

    2023-07-20T19:25:52.206831  =


    2023-07-20T19:25:52.211127  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST
 =

    ... (8 line(s) more)  =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/64b989e66469adda348ace86
        failing since 181 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-07-20T19:25:52.116850  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC)<8=
>[   19.059228] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-07-20T19:25:52.118686   multi-call binary.

    2023-07-20T19:25:52.118908  =


    2023-07-20T19:25:52.123269  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-07-20T19:25:52.123490  =


    2023-07-20T19:25:52.128490  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-07-20T19:25:52.138964  FIRST,<8>[   19.078548] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/64b989e66469adda348ace87
        failing since 181 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-07-20T19:25:52.097803  /lava-11120893/1/../bin/lava-test-case<8>[ =
  19.041720] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-probed RE=
SULT=3Dpass>

    2023-07-20T19:25:52.097854  =

   =

 =20

