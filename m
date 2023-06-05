Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B641C77B73
	for <webhook@archiver.kernel.org>; Mon,  5 Jun 2023 10:59:32 +0000 (UTC)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
 by mx.groups.io with SMTP id smtpd.web11.4654.1685962764229871688
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Jun 2023 03:59:24 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=Zo5zCH19;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.174, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6532671ccc7so3444347b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Jun 2023 03:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685962763; x=1688554763;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Rwv01nZpozA/vZJHA5WPIwq0bUSaXwqbIw9TLMVyS9E=;
        b=Zo5zCH199eXLGZi47kbp6Hx6X6jDuTbmEQ0Sc6uJBuO/qjEiNjf6WGZdeRjw3IeTRP
         hTbxDC006nZJGXJOwPuigHJAixjJIVAzMZNKxKMTk4vKNn22YbQw0sZaMcXVZSZ5iWDL
         r3FReXdjwuKHuOujeWUPqrlSnuVDjDt0XbzPSmnyxUXRYsqC+e4etkSXC1DJKEOYDLp8
         iHoiSem8QvjopYY29UAeGm3TsG51gh430PTugjHMYS+x4qJk9gSJ+yHqn11+eqrK3Gu8
         XzGBqFik1F1ZxvhNyMqfSWyzSH62SJR7Rkg5KkfeJd4/EBa63KXLeneTeB0RjXii4igc
         Hbrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685962763; x=1688554763;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rwv01nZpozA/vZJHA5WPIwq0bUSaXwqbIw9TLMVyS9E=;
        b=S2j5Tnz30Zk8VXFmaxr5KG8tfA2dcJ4yoIBKyWasJM7TCU0iKBgZYxWh3xo6BSsYdf
         5l9kmhaFkHIXxjJ539+NEgFPCz9t4al+GjRjNR/n6lPmy7nu2TBAFtmyXMwh8aRumkbC
         bT0C+LFQ5OJAPeTzrrBV1rYTV/LHbreM3F3yPwEpb0Wzpi4ILMOo0k/jSJ2W/l14uXvE
         hBd9L5h9WOWVMWHaZdIWY2VNrRoMH8AE6DpCEmxNXX/JtWsD/UxsysDiwoA2Pp4llhW9
         6n3IHgvVIY06mIHG62yIdAonmy+bJFQPF9gc6lk4oEqB2qv1106+56gnPhlBSin4M03j
         bs1A==
X-Gm-Message-State: AC+VfDwyE7l6S04O7CYEbxJg5l6VhR03zTjr6DqTLQaWbPNtEi0ptLO2
	E9q4jhuPajj9wTjTE4NrBbHZARxmdtpoddrXKPqIcw==
X-Google-Smtp-Source: ACHHUZ5RM0/LQtbXyuLlKS07UDGwMVG9GFV9cJUru39rAsCjMxoY3oJL51oHo8RHf4XEd8SYxsFG0w==
X-Received: by 2002:a05:6a00:8c4:b0:639:a518:3842 with SMTP id s4-20020a056a0008c400b00639a5183842mr26061766pfu.7.1685962762651;
        Mon, 05 Jun 2023 03:59:22 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 8-20020aa79208000000b00625d84a0194sm4949417pfo.107.2023.06.05.03.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 03:59:21 -0700 (PDT)
Message-ID: <647dc009.a70a0220.582d.8030@mx.google.com>
Date: Mon, 05 Jun 2023 03:59:21 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.180-cip34-19-gf0f6960f132cd
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip baseline: 139 runs,
 25 regressions (v5.10.180-cip34-19-gf0f6960f132cd)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jun 2023 10:59:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11785

cip/linux-5.10.y-cip baseline: 139 runs, 25 regressions (v5.10.180-cip34-19=
-gf0f6960f132cd)

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

r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =

rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 4          =

rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.180-cip34-19-gf0f6960f132cd/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.180-cip34-19-gf0f6960f132cd
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      f0f6960f132cdf82ed0fcb61de7c496d33f0998f =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647db783f07d36533bf5de59

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647db783f07d36533bf5de62
        failing since 142 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-05T10:22:31.678699  <8>[   12.085601] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10590405_1.4.2.3.1>

    2023-06-05T10:22:31.682085  + set +x

    2023-06-05T10:22:31.783428  #

    2023-06-05T10:22:31.884251  / # #export SHELL=3D/bin/sh

    2023-06-05T10:22:31.884488  =


    2023-06-05T10:22:31.985067  / # export SHELL=3D/bin/sh. /lava-10590405/=
environment

    2023-06-05T10:22:31.985277  =


    2023-06-05T10:22:32.085795  / # . /lava-10590405/environment/lava-10590=
405/bin/lava-test-runner /lava-10590405/1

    2023-06-05T10:22:32.086098  =


    2023-06-05T10:22:32.091243  / # /lava-10590405/bin/lava-test-runner /la=
va-10590405/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647db551e7a2575e97f5deb4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647db551e7a2575e97f5debd
        failing since 142 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-05T10:13:21.210550  + set<8>[   11.842398] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10590433_1.4.2.3.1>

    2023-06-05T10:13:21.211604   +x

    2023-06-05T10:13:21.315854  #

    2023-06-05T10:13:21.316192  =


    2023-06-05T10:13:21.416831  / # #export SHELL=3D/bin/sh

    2023-06-05T10:13:21.417027  =


    2023-06-05T10:13:21.517577  / # export SHELL=3D/bin/sh. /lava-10590433/=
environment

    2023-06-05T10:13:21.517796  =


    2023-06-05T10:13:21.618346  / # . /lava-10590433/environment/lava-10590=
433/bin/lava-test-runner /lava-10590433/1

    2023-06-05T10:13:21.618667  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647db26d9ba08e5e8df5de62

  Results:     47 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline=
-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline=
-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647db26e9ba08e5e8df5de9b
        failing since 142 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-05T10:00:40.827157  + set +x
    2023-06-05T10:00:40.832307  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 562201_1.5.2=
.4.1>
    2023-06-05T10:00:40.946765  / # #
    2023-06-05T10:00:41.049967  export SHELL=3D/bin/sh
    2023-06-05T10:00:41.050799  #
    2023-06-05T10:00:41.152836  / # export SHELL=3D/bin/sh. /lava-562201/en=
vironment
    2023-06-05T10:00:41.153672  =

    2023-06-05T10:00:41.255659  / # . /lava-562201/environment/lava-562201/=
bin/lava-test-runner /lava-562201/1
    2023-06-05T10:00:41.257024  =

    2023-06-05T10:00:41.263462  / # /lava-562201/bin/lava-test-runner /lava=
-562201/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647db3a584da08a3b9f5de31

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline=
-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline=
-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647db3a684da08a3b9f5de5f
        failing since 142 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-05T10:05:51.751030  <8>[   21.403169] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 562270_1.5.2.4.1>
    2023-06-05T10:05:51.858787  / # #
    2023-06-05T10:05:51.961212  export SHELL=3D/bin/sh
    2023-06-05T10:05:51.961560  #
    2023-06-05T10:05:52.062838  / # export SHELL=3D/bin/sh. /lava-562270/en=
vironment
    2023-06-05T10:05:52.063265  =

    2023-06-05T10:05:52.164584  / # . /lava-562270/environment/lava-562270/=
bin/lava-test-runner /lava-562270/1
    2023-06-05T10:05:52.165196  =

    2023-06-05T10:05:52.169901  / # /lava-562270/bin/lava-test-runner /lava=
-562270/1
    2023-06-05T10:05:52.264499  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647db9e677bc667a2cf5de2b

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-bea=
glebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-bea=
glebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647db9e677bc667a2cf5de32
        failing since 142 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-05T10:32:41.538260  <8>[   16.709119] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 953046_1.5.2.4.1>
    2023-06-05T10:32:41.644515  / # #
    2023-06-05T10:32:41.746971  export SHELL=3D/bin/sh
    2023-06-05T10:32:41.747713  #
    2023-06-05T10:32:41.849198  / # export SHELL=3D/bin/sh. /lava-953046/en=
vironment
    2023-06-05T10:32:41.849910  =

    2023-06-05T10:32:41.951320  / # . /lava-953046/environment/lava-953046/=
bin/lava-test-runner /lava-953046/1
    2023-06-05T10:32:41.952042  =

    2023-06-05T10:32:41.959030  / # /lava-953046/bin/lava-test-runner /lava=
-953046/1
    2023-06-05T10:32:42.054023  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647db482b4794746c7f5de6c

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/arm/omap2plus_defconfig/gcc-10/lab-broonie/baselin=
e-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/arm/omap2plus_defconfig/gcc-10/lab-broonie/baselin=
e-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647db482b4794746c7f5dea4
        failing since 142 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-05T10:09:49.968851  <8>[   21.012223] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 562292_1.5.2.4.1>
    2023-06-05T10:09:50.078202  / # #
    2023-06-05T10:09:50.181434  export SHELL=3D/bin/sh
    2023-06-05T10:09:50.181965  #
    2023-06-05T10:09:50.283309  / # export SHELL=3D/bin/sh. /lava-562292/en=
vironment
    2023-06-05T10:09:50.283669  =

    2023-06-05T10:09:50.385424  / # . /lava-562292/environment/lava-562292/=
bin/lava-test-runner /lava-562292/1
    2023-06-05T10:09:50.385929  =

    2023-06-05T10:09:50.390455  / # /lava-562292/bin/lava-test-runner /lava=
-562292/1
    2023-06-05T10:09:50.491959  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647dba5e77323fc52cf5de3c

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-be=
aglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-be=
aglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647dba5e77323fc52cf5de43
        failing since 142 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-05T10:34:55.682277  <8>[   13.086305] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 953051_1.5.2.4.1>
    2023-06-05T10:34:55.792099  / # #
    2023-06-05T10:34:55.894472  export SHELL=3D/bin/sh
    2023-06-05T10:34:55.895167  #
    2023-06-05T10:34:55.996947  / # export SHELL=3D/bin/sh. /lava-953051/en=
vironment
    2023-06-05T10:34:55.997649  =

    2023-06-05T10:34:56.099458  / # . /lava-953051/environment/lava-953051/=
bin/lava-test-runner /lava-953051/1
    2023-06-05T10:34:56.100635  =

    2023-06-05T10:34:56.106815  / # /lava-953051/bin/lava-test-runner /lava=
-953051/1
    2023-06-05T10:34:56.209229  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls1028a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/647db3a8d6f24bd346f5de3b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1028=
a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1028=
a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647db3a8d6f24bd346f5de42
        failing since 83 days (last pass: v5.10.155-cip21, first fail: v5.1=
0.173-cip28)

    2023-06-05T10:05:39.087462  [   20.803646] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1233484_1.5.2.4.1>
    2023-06-05T10:05:39.193194  / # #
    2023-06-05T10:05:39.295018  export SHELL=3D/bin/sh
    2023-06-05T10:05:39.295454  #
    2023-06-05T10:05:39.396819  / # export SHELL=3D/bin/sh. /lava-1233484/e=
nvironment
    2023-06-05T10:05:39.397260  =

    2023-06-05T10:05:39.498633  / # . /lava-1233484/environment/lava-123348=
4/bin/lava-test-runner /lava-1233484/1
    2023-06-05T10:05:39.499373  =

    2023-06-05T10:05:39.501588  / # /lava-1233484/bin/lava-test-runner /lav=
a-1233484/1
    2023-06-05T10:05:39.522161  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls1088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/647db3833b44b717b9f5de95

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1088=
a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1088=
a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647db3833b44b717b9f5de9c
        failing since 142 days (last pass: v5.10.155-cip21, first fail: v5.=
10.162-cip24)

    2023-06-05T10:05:31.022742  [   10.367335] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1233483_1.5.2.4.1>
    2023-06-05T10:05:31.128746  / # #
    2023-06-05T10:05:31.229903  export SHELL=3D/bin/sh
    2023-06-05T10:05:31.230148  #
    2023-06-05T10:05:31.331172  / # export SHELL=3D/bin/sh. /lava-1233483/e=
nvironment
    2023-06-05T10:05:31.331392  =

    2023-06-05T10:05:31.432394  / # . /lava-1233483/environment/lava-123348=
3/bin/lava-test-runner /lava-1233483/1
    2023-06-05T10:05:31.432801  =

    2023-06-05T10:05:31.434647  / # /lava-1233483/bin/lava-test-runner /lav=
a-1233483/1
    2023-06-05T10:05:31.452731  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647db755147084d7bdf5de41

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647db755147084d7bdf5de4a
        failing since 52 days (last pass: v5.10.176-cip30, first fail: v5.1=
0.177-cip31)

    2023-06-05T10:22:08.868279  + set +x

    2023-06-05T10:22:08.875426  <8>[   14.164330] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10590448_1.4.2.3.1>

    2023-06-05T10:22:08.979521  / # #

    2023-06-05T10:22:09.080146  export SHELL=3D/bin/sh

    2023-06-05T10:22:09.080348  #

    2023-06-05T10:22:09.180883  / # export SHELL=3D/bin/sh. /lava-10590448/=
environment

    2023-06-05T10:22:09.181070  =


    2023-06-05T10:22:09.281547  / # . /lava-10590448/environment/lava-10590=
448/bin/lava-test-runner /lava-10590448/1

    2023-06-05T10:22:09.281818  =


    2023-06-05T10:22:09.286708  / # /lava-10590448/bin/lava-test-runner /la=
va-10590448/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647db6cf55d165df5df5de35

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647db6cf55d165df5df5de3e
        failing since 52 days (last pass: v5.10.176-cip30, first fail: v5.1=
0.177-cip31)

    2023-06-05T10:19:47.876882  + set +x<8>[   12.862261] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10590435_1.4.2.3.1>

    2023-06-05T10:19:47.877369  =


    2023-06-05T10:19:47.984749  /#

    2023-06-05T10:19:48.087418   # #export SHELL=3D/bin/sh

    2023-06-05T10:19:48.088169  =


    2023-06-05T10:19:48.189761  / # export SHELL=3D/bin/sh. /lava-10590435/=
environment

    2023-06-05T10:19:48.190545  =


    2023-06-05T10:19:48.291927  / # . /lava-10590435/environment/lava-10590=
435/bin/lava-test-runner /lava-10590435/1

    2023-06-05T10:19:48.293076  =


    2023-06-05T10:19:48.298705  / # /lava-10590435/bin/lava-test-runner /la=
va-10590435/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647db39cff06d798c7f5de56

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647db39cff06d798c7f5de5f
        failing since 142 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-05T10:06:01.945971  / # #

    2023-06-05T10:06:02.048592  export SHELL=3D/bin/sh

    2023-06-05T10:06:02.049291  #

    2023-06-05T10:06:02.151091  / # export SHELL=3D/bin/sh. /lava-10590262/=
environment

    2023-06-05T10:06:02.151866  =


    2023-06-05T10:06:02.253553  / # . /lava-10590262/environment/lava-10590=
262/bin/lava-test-runner /lava-10590262/1

    2023-06-05T10:06:02.254707  =


    2023-06-05T10:06:02.268594  / # /lava-10590262/bin/lava-test-runner /la=
va-10590262/1

    2023-06-05T10:06:02.374643  + export 'TESTRUN_ID=3D1_bootrr'

    2023-06-05T10:06:02.375177  + cd /lava-10590262/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647db2c37e0a326e4ff5de5a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/bas=
eline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/bas=
eline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647db2c37e0a326e4ff5de63
        failing since 142 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-05T10:02:22.324647  + set +x
    2023-06-05T10:02:22.324830  [   10.266676] <LAVA_SIGNAL_ENDRUN 0_dmesg =
967477_1.5.2.3.1>
    2023-06-05T10:02:22.433030  / # #
    2023-06-05T10:02:22.534797  export SHELL=3D/bin/sh
    2023-06-05T10:02:22.535331  #
    2023-06-05T10:02:22.636621  / # export SHELL=3D/bin/sh. /lava-967477/en=
vironment
    2023-06-05T10:02:22.637122  =

    2023-06-05T10:02:22.738369  / # . /lava-967477/environment/lava-967477/=
bin/lava-test-runner /lava-967477/1
    2023-06-05T10:02:22.739041  =

    2023-06-05T10:02:22.741919  / # /lava-967477/bin/lava-test-runner /lava=
-967477/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647db3515210600a51f5de3b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/base=
line-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/base=
line-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647db3515210600a51f5de44
        failing since 142 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-05T10:04:56.319561  + set[    7.170010] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 967482_1.5.2.3.1>
    2023-06-05T10:04:56.319758   +x
    2023-06-05T10:04:56.425408  / # #
    2023-06-05T10:04:56.527103  export SHELL=3D/bin/sh
    2023-06-05T10:04:56.527597  #
    2023-06-05T10:04:56.628987  / # export SHELL=3D/bin/sh. /lava-967482/en=
vironment
    2023-06-05T10:04:56.629481  =

    2023-06-05T10:04:56.730762  / # . /lava-967482/environment/lava-967482/=
bin/lava-test-runner /lava-967482/1
    2023-06-05T10:04:56.731383  =

    2023-06-05T10:04:56.733844  / # /lava-967482/bin/lava-test-runner /lava=
-967482/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647db3b6591ea62963f5de3e

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx=
7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx=
7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647db3b6591ea62963f5de45
        failing since 142 days (last pass: v5.10.155-cip21, first fail: v5.=
10.162-cip24)

    2023-06-05T10:06:24.197026  + set<8>[   17.107600] <LAVA_SIGNAL_ENDRUN =
0_dmesg 1233493_1.5.2.4.1>
    2023-06-05T10:06:24.197283   +x
    2023-06-05T10:06:24.302881  / # #
    2023-06-05T10:06:25.463257  export SHELL=3D/bin/sh
    2023-06-05T10:06:25.468975  #
    2023-06-05T10:06:27.016898  / # export SHELL=3D/bin/sh. /lava-1233493/e=
nvironment
    2023-06-05T10:06:27.022506  =

    2023-06-05T10:06:29.844591  / # . /lava-1233493/environment/lava-123349=
3/bin/lava-test-runner /lava-1233493/1
    2023-06-05T10:06:29.850664  =

    2023-06-05T10:06:29.856688  / # /lava-1233493/bin/lava-test-runner /lav=
a-1233493/1 =

    ... (20 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7ulp-evk                  | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647db439bcd03beafbf5de27

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx=
7ulp-evk.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx=
7ulp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647db439bcd03beafbf5de2e
        failing since 83 days (last pass: v5.10.155-cip21, first fail: v5.1=
0.173-cip28)

    2023-06-05T10:08:28.528286  + set +x
    2023-06-05T10:08:28.529300  <8>[   28.953668] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1233494_1.5.2.4.1>
    2023-06-05T10:08:28.636238  / # #
    2023-06-05T10:08:29.794190  export SHELL=3D/bin/sh
    2023-06-05T10:08:29.799574  #
    2023-06-05T10:08:29.799721  / # export SHELL=3D/bin/sh
    2023-06-05T10:08:31.346344  / # . /lava-1233494/environment
    2023-06-05T10:08:34.169885  /lava-1233494/bin/lava-test-runner /lava-12=
33494/1
    2023-06-05T10:08:34.175694  . /lava-1233494/environment
    2023-06-05T10:08:34.176025  / # /lava-1233494/bin/lava-test-runner /lav=
a-1233494/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/647db6bf35850e79a2f5de3e

  Results:     28 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/arm64/defconfig+arm64-chromebook/gcc-10/lab-collab=
ora/baseline-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/arm64/defconfig+arm64-chromebook/gcc-10/lab-collab=
ora/baseline-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647db6bf35850e79a2f5de5e
        failing since 142 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-05T10:19:23.224362  + set +x

    2023-06-05T10:19:23.230943  <8>[   15.653072] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10590595_1.5.2.3.1>

    2023-06-05T10:19:23.334888  #

    2023-06-05T10:19:23.335172  =


    2023-06-05T10:19:23.435737  / # #export SHELL=3D/bin/sh

    2023-06-05T10:19:23.435952  =


    2023-06-05T10:19:23.536473  / # export SHELL=3D/bin/sh. /lava-10590595/=
environment

    2023-06-05T10:19:23.536678  =


    2023-06-05T10:19:23.637218  / # . /lava-10590595/environment/lava-10590=
595/bin/lava-test-runner /lava-10590595/1

    2023-06-05T10:19:23.637503  =

 =

    ... (17 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647db4659d384a0f24f5de8b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a=
7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a=
7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647db4659d384a0f24f5d=
e8c
        new failure (last pass: v5.10.180-cip34) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 4          =


  Details:     https://kernelci.org/test/plan/id/647db7b4de0b3e4a29f5df05

  Results:     63 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-i2c-present: https://kernelci.or=
g/test/case/id/647db7b4de0b3e4a29f5df38
        failing since 140 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-05T10:24:15.062487  FIRST,<8>[   20.895606] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>

    2023-06-05T10:24:15.066167   INC default to 1.

    2023-06-05T10:24:15.066228  =


    2023-06-05T10:24:15.069635  	-w	Pad to last with leading zeros

    2023-06-05T10:24:15.072332  	-s SEP	String separator

    2023-06-05T10:24:15.076089  /lava-10590256/1/../bin/lava-test-case

    2023-06-05T10:24:15.082158  BusyBox v1.31.1 (2023-05-27 14:14:16 UTC) m=
ulti-call binary.

    2023-06-05T10:24:15.082510  =


    2023-06-05T10:24:15.092726  Usag<8>[   20.924762] <LAVA_SIGNAL_TESTCASE=
 TEST_CASE_ID=3Ddwhdmi-rockchip-driver-i2c-present RESULT=3Dfail>
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/647db7b4de0b3e4a29f5df39
        failing since 140 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-05T10:24:15.040068  BusyBox v1.31.1 (2023-05-27 14:14:16 UTC)<8=
>[   20.876530] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-06-05T10:24:15.042168   multi-call binary.

    2023-06-05T10:24:15.042241  =


    2023-06-05T10:24:15.046535  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-06-05T10:24:15.046598  =


    2023-06-05T10:24:15.051682  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/647db7b4de0b3e4a29f5df3a
        failing since 140 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24) =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647db7b4de0b3e4a29f5df4e
        failing since 140 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-05T10:24:02.967912  + <8>[    8.808306] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10590256_1.5.2.3.1>

    2023-06-05T10:24:02.968315  set +x

    2023-06-05T10:24:03.074947  =


    2023-06-05T10:24:03.176472  / # #export SHELL=3D/bin/sh

    2023-06-05T10:24:03.177175  =


    2023-06-05T10:24:03.278588  / # export SHELL=3D/bin/sh. /lava-10590256/=
environment

    2023-06-05T10:24:03.279296  =


    2023-06-05T10:24:03.380752  / # . /lava-10590256/environment/lava-10590=
256/bin/lava-test-runner /lava-10590256/1

    2023-06-05T10:24:03.381800  =


    2023-06-05T10:24:03.383526  / # /lava-10590256/bin/lava-test-runner /la=
va-10590256/1
 =

    ... (18 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/647db7536e6e2dfcfef5de4b

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/arm64/defconfig+arm64-chromebook/gcc-10/lab-collab=
ora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/arm64/defconfig+arm64-chromebook/gcc-10/lab-collab=
ora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/647db7536e6e2dfcfef5de57
        failing since 75 days (last pass: v5.10.173-cip28, first fail: v5.1=
0.175-cip29)

    2023-06-05T10:21:47.526169  <8>[   61.086225] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-06-05T10:21:48.552862  /lava-10590627/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/647db7536e6e2dfcfef5de58
        failing since 75 days (last pass: v5.10.173-cip28, first fail: v5.1=
0.175-cip29)

    2023-06-05T10:21:47.516303  /lava-10590627/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/647db3c63ea2526667f5de28

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i=
-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i=
-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647db3c63ea2526667f5de54
        failing since 142 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-05T10:06:33.670709  + set +x
    2023-06-05T10:06:33.675140  <8>[   17.139100] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 562179_1.5.2.4.1>
    2023-06-05T10:06:33.786499  / # #
    2023-06-05T10:06:33.889524  export SHELL=3D/bin/sh
    2023-06-05T10:06:33.890374  #
    2023-06-05T10:06:33.992656  / # export SHELL=3D/bin/sh. /lava-562179/en=
vironment
    2023-06-05T10:06:33.993501  =

    2023-06-05T10:06:34.095801  / # . /lava-562179/environment/lava-562179/=
bin/lava-test-runner /lava-562179/1
    2023-06-05T10:06:34.097093  =

    2023-06-05T10:06:34.101798  / # /lava-562179/bin/lava-test-runner /lava=
-562179/1 =

    ... (12 line(s) more)  =

 =20

