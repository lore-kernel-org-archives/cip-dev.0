Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD16EB64D9
	for <webhook@archiver.kernel.org>; Wed, 14 Jun 2023 13:21:05 +0000 (UTC)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
 by mx.groups.io with SMTP id smtpd.web11.11560.1686748855701599782
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 14 Jun 2023 06:20:55 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=eIqsmUg4;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.173, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-54fba092ef5so1194666a12.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 14 Jun 2023 06:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686748854; x=1689340854;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YBgANNgPDBnN2G4UiaSOEu7LXVKG2V91V+EAx5xRXjQ=;
        b=eIqsmUg4qd2k3CmwluRbKSL3GWt1I/6No0hlehI6AeJziANc674QGj7AjxOErjU+um
         DKScYJiAVvYhjUpQCUCd/82quLKgcxo+m2Pui3rPQA6tWx1T8n2lkKYJx+UWb9YPBmpk
         oRZdkvzQh9DY+w6pTK3VfEI87f6fty8D2WiVGd0RYEIOQKaL1htta4gxC8wiUpYMjNSM
         yLLy428cIaavbXWgKPXxIJHLfZtENHQt5KZsIt9TAYL6GsDTGyUskMuXM3pNKqBkoHqD
         TCzEt76PBbZu7aBprBS23rAXJDAlSRHZhVEtGCfR3Cz0FIFDGA8o7TMwrAlYSJF2VDt2
         9Kyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686748854; x=1689340854;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YBgANNgPDBnN2G4UiaSOEu7LXVKG2V91V+EAx5xRXjQ=;
        b=Elh41L5q7ORyt4bPWog3Ap3ZAokWS/rn2zKVXHdPcHkfxCQJl82SoFtOifCuPYJmcJ
         QKvG6zSNGKCoEDGxCY6AQWnyzg9y+MQGVBq2aw16ws4Cpi23sajpun+n7HJmnqYhhk5/
         hDZBkp+ygJ/clR7nmvSvgrxVzCm2XV12Jm/6NowdsLmSxH7TEE9mEOgDdY0Phq1orUlz
         ncD9tvk2w+q/bXml9quAgJdX+8fHLODzQ3uIdZOhdveNHEQWT0tqVUwPfSZ7y2I99YSf
         ft3Tt1iHgf4GX3yD74jQbOQ7/ZPUseGWrhprc03HMz2sGPuXeuwAfU8sL3Eedh1bO70F
         vIXQ==
X-Gm-Message-State: AC+VfDwt9sVYhTKMfgS6X8AbI+QaQt2INDV9BYp8HWqyr9+I4fenIBuG
	wfTUBLtYHJPFVfyhvUuc+Iojrj4mhsspJpz7ryCCZQ==
X-Google-Smtp-Source: ACHHUZ6gcU6ropO/ruyvssd1wB7BO1IWE9C0E7qxz9PB8bGiE58HHDZNL9GW0lVimmth3lhCzqSrgQ==
X-Received: by 2002:a17:90a:2e03:b0:256:2cb7:406e with SMTP id q3-20020a17090a2e0300b002562cb7406emr1495388pjd.45.1686748853077;
        Wed, 14 Jun 2023 06:20:53 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id nn4-20020a17090b38c400b002562cfb81dfsm12750451pjb.28.2023.06.14.06.20.52
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 06:20:52 -0700 (PDT)
Message-ID: <6489beb4.170a0220.807c2.9500@mx.google.com>
Date: Wed, 14 Jun 2023 06:20:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.182-cip35-8-g2391124f19a70
Subject: cip-gitlab/ci/pavel/linux-test baseline: 106 runs,
 46 regressions (v5.10.182-cip35-8-g2391124f19a70)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Jun 2023 13:21:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12025

cip-gitlab/ci/pavel/linux-test baseline: 106 runs, 46 regressions (v5.10.18=
2-cip35-8-g2391124f19a70)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 5          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =

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

juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 10         =

kontron-kbox-a-230-ls        | arm64  | lab-kontron     | gcc-10   | defcon=
fig                    | 3          =

kontron-sl28-var3-ads2       | arm64  | lab-kontron     | gcc-10   | defcon=
fig                    | 3          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

mt8173-elm-hana              | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

qemu_mips-malta              | mips   | lab-broonie     | gcc-10   | malta_=
defconfig              | 1          =

qemu_mips-malta              | mips   | lab-collabora   | gcc-10   | malta_=
defconfig              | 1          =

rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 4          =

rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =

sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.182-cip35-8-g2391124f19a70/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.182-cip35-8-g2391124f19a70
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      2391124f19a7085376080a6a95b6e45ff525076a =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6489b3cec0c24c7f0e30612e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm/multi_v7_defconfig/gcc-10/lab-collabo=
ra/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm/multi_v7_defconfig/gcc-10/lab-collabo=
ra/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6489b3cec0c24c7f0e306=
12f
        new failure (last pass: v4.19.283-cip98-1248-gcaf6e8ee921e9) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 5          =


  Details:     https://kernelci.org/test/plan/id/6489b363e50ab2c82830612e

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm/multi_v7_defconfig/gcc-10/lab-broonie=
/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm/multi_v7_defconfig/gcc-10/lab-broonie=
/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.hdmi-audio: https://kernelci.org/test/case/id/6489b363e=
50ab2c828306131
        failing since 6 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77)

    2023-06-14T12:32:26.278138  /lava-610465/1/../bin/lava-test-case
    2023-06-14T12:32:26.312932  <8>[   47.826134] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-codec-driver-present: https://kernelci.org/test/ca=
se/id/6489b363e50ab2c828306134
        failing since 6 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77)

    2023-06-14T12:32:23.046636  /lava-610465/1/../bin/lava-test-case
    2023-06-14T12:32:23.081766  <8>[   44.595368] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-06-14T12:32:24.108717  /lava-610465/1/../bin/lava-test-case
    2023-06-14T12:32:24.146644  <8>[   45.656517] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case/id/=
6489b363e50ab2c828306135
        failing since 6 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77)

    2023-06-14T12:32:20.923509  /lava-610465/1/../bin/lava-test-case
    2023-06-14T12:32:20.953189  <8>[   42.465696] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-06-14T12:32:21.981727  /lava-610465/1/../bin/lava-test-case
    2023-06-14T12:32:22.020356  <8>[   43.533166] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline.bootrr.tda19988-driver-present: https://kernelci.org/test/case=
/id/6489b363e50ab2c828306136
        failing since 6 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77)

    2023-06-14T12:32:18.795110  /lava-610465/1/../bin/lava-test-case
    2023-06-14T12:32:18.831566  <8>[   40.344287] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-06-14T12:32:19.858359  /lava-610465/1/../bin/lava-test-case
    2023-06-14T12:32:19.894383  <8>[   41.406271] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/6489b363e50ab2c828306141
        failing since 6 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77)

    2023-06-14T12:32:06.859371  /lava-610465/1/../bin/lava-test-case
    2023-06-14T12:32:06.894819  <8>[   28.405985] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6489b1711f4ee56b96306182

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm/omap2plus_defconfig/gcc-10/lab-brooni=
e/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm/omap2plus_defconfig/gcc-10/lab-brooni=
e/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6489b1711f4ee56b963061b7
        new failure (last pass: v4.19.283-cip98-1248-gcaf6e8ee921e9)

    2023-06-14T12:23:58.762774  + set +x
    2023-06-14T12:23:58.766680  <8>[   19.955964] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 610428_1.5.2.4.1>
    2023-06-14T12:23:58.879245  / # #
    2023-06-14T12:23:58.982402  export SHELL=3D/bin/sh
    2023-06-14T12:23:58.983201  #
    2023-06-14T12:23:59.085169  / # export SHELL=3D/bin/sh. /lava-610428/en=
vironment
    2023-06-14T12:23:59.085979  =

    2023-06-14T12:23:59.187959  / # . /lava-610428/environment/lava-610428/=
bin/lava-test-runner /lava-610428/1
    2023-06-14T12:23:59.189445  =

    2023-06-14T12:23:59.193261  / # /lava-610428/bin/lava-test-runner /lava=
-610428/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6489be99c56e24bee0306183

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm/omap2plus_defconfig/gcc-10/lab-cip/ba=
seline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm/omap2plus_defconfig/gcc-10/lab-cip/ba=
seline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6489be99c56e24bee0306186
        new failure (last pass: v4.19.283-cip98-1248-gcaf6e8ee921e9)

    2023-06-14T13:20:11.437005  + set +x
    2023-06-14T13:20:11.439063  <8>[   13.979146] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 963032_1.5.2.4.1>
    2023-06-14T13:20:11.548288  / # #
    2023-06-14T13:20:11.650308  export SHELL=3D/bin/sh
    2023-06-14T13:20:11.650811  #
    2023-06-14T13:20:11.752495  / # export SHELL=3D/bin/sh. /lava-963032/en=
vironment
    2023-06-14T13:20:11.752936  =

    2023-06-14T13:20:11.854330  / # . /lava-963032/environment/lava-963032/=
bin/lava-test-runner /lava-963032/1
    2023-06-14T13:20:11.855046  =

    2023-06-14T13:20:11.857199  / # /lava-963032/bin/lava-test-runner /lava=
-963032/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6489b16a27eff684ef30613f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6489b16a27eff684ef306144
        new failure (last pass: v4.19.283-cip98-1248-gcaf6e8ee921e9)

    2023-06-14T12:24:11.143729  + set +x

    2023-06-14T12:24:11.150158  <8>[   15.666932] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10724497_1.4.2.3.1>

    2023-06-14T12:24:11.255301  / # #

    2023-06-14T12:24:11.356052  export SHELL=3D/bin/sh

    2023-06-14T12:24:11.356289  #

    2023-06-14T12:24:11.456834  / # export SHELL=3D/bin/sh. /lava-10724497/=
environment

    2023-06-14T12:24:11.457096  =


    2023-06-14T12:24:11.557668  / # . /lava-10724497/environment/lava-10724=
497/bin/lava-test-runner /lava-10724497/1

    2023-06-14T12:24:11.558012  =


    2023-06-14T12:24:11.563296  / # /lava-10724497/bin/lava-test-runner /la=
va-10724497/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6489b0f63a9c574c9f30619d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6489b0f63a9c574c9f3061a2
        new failure (last pass: v4.19.283-cip98-1248-gcaf6e8ee921e9)

    2023-06-14T12:21:54.320815  + set +x

    2023-06-14T12:21:54.327528  <8>[   12.057321] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10724406_1.4.2.3.1>

    2023-06-14T12:21:54.429508  #

    2023-06-14T12:21:54.429809  =


    2023-06-14T12:21:54.530387  / # #export SHELL=3D/bin/sh

    2023-06-14T12:21:54.530547  =


    2023-06-14T12:21:54.631070  / # export SHELL=3D/bin/sh. /lava-10724406/=
environment

    2023-06-14T12:21:54.631256  =


    2023-06-14T12:21:54.731784  / # . /lava-10724406/environment/lava-10724=
406/bin/lava-test-runner /lava-10724406/1

    2023-06-14T12:21:54.732031  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6489bb211aa5eb2c7930616d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm/imx_v6_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm/imx_v6_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6489bb211aa5eb2c79306=
16e
        new failure (last pass: v4.19.283-cip98-1248-gcaf6e8ee921e9) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6489bdcce4c4ca79bc30613c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm/multi_v7_defconfig/gcc-10/lab-broonie=
/baseline-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm/multi_v7_defconfig/gcc-10/lab-broonie=
/baseline-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6489bdcce4c4ca79bc306=
13d
        new failure (last pass: v4.19.283-cip98-1248-gcaf6e8ee921e9) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6489ba20a58fc1cd073061a7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm/imx_v6_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm/imx_v6_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6489ba20a58fc1cd07306=
1a8
        new failure (last pass: v4.19.283-cip98-1248-gcaf6e8ee921e9) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6489bcd9b4e0a4140930613b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm/multi_v7_defconfig/gcc-10/lab-broonie=
/baseline-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm/multi_v7_defconfig/gcc-10/lab-broonie=
/baseline-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6489bcd9b4e0a41409306=
13c
        new failure (last pass: v4.19.283-cip98-1248-gcaf6e8ee921e9) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6489b1b09d956ae751306152

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm/imx_v6_v7_defconfig/gcc-10/lab-pengut=
ronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm/imx_v6_v7_defconfig/gcc-10/lab-pengut=
ronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6489b1b09d956ae751306157
        failing since 4 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.19.283-cip98-1248-gcaf6e8ee921e9)

    2023-06-14T12:25:14.226313  + set +x
    2023-06-14T12:25:14.226578  [   10.266429] <LAVA_SIGNAL_ENDRUN 0_dmesg =
977210_1.5.2.3.1>
    2023-06-14T12:25:14.335282  / # #
    2023-06-14T12:25:14.437740  export SHELL=3D/bin/sh
    2023-06-14T12:25:14.438295  #
    2023-06-14T12:25:14.539673  / # export SHELL=3D/bin/sh. /lava-977210/en=
vironment
    2023-06-14T12:25:14.540164  =

    2023-06-14T12:25:14.641510  / # . /lava-977210/environment/lava-977210/=
bin/lava-test-runner /lava-977210/1
    2023-06-14T12:25:14.642318  =

    2023-06-14T12:25:14.645237  / # /lava-977210/bin/lava-test-runner /lava=
-977210/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6489b31ad3a0e0a98a306131

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm/multi_v7_defconfig/gcc-10/lab-pengutr=
onix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm/multi_v7_defconfig/gcc-10/lab-pengutr=
onix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6489b31ad3a0e0a98a306136
        failing since 4 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.19.283-cip98-1248-gcaf6e8ee921e9)

    2023-06-14T12:31:12.111383  + set[    7.174151] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 977229_1.5.2.3.1>
    2023-06-14T12:31:12.111596   +x
    2023-06-14T12:31:12.217326  / # #
    2023-06-14T12:31:12.318975  export SHELL=3D/bin/sh
    2023-06-14T12:31:12.319435  #
    2023-06-14T12:31:12.420727  / # export SHELL=3D/bin/sh. /lava-977229/en=
vironment
    2023-06-14T12:31:12.421263  =

    2023-06-14T12:31:12.522596  / # . /lava-977229/environment/lava-977229/=
bin/lava-test-runner /lava-977229/1
    2023-06-14T12:31:12.523275  =

    2023-06-14T12:31:12.525513  / # /lava-977229/bin/lava-test-runner /lava=
-977229/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 10         =


  Details:     https://kernelci.org/test/plan/id/6489be9ac56e24bee03061c0

  Results:     51 PASS, 10 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm64/defconfig/gcc-10/lab-broonie/baseli=
ne-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm64/defconfig/gcc-10/lab-broonie/baseli=
ne-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.led7-probed: https://kernelci.org/test/case/id/6489be9a=
c56e24bee03061cd
        new failure (last pass: v6.1.26-1314-g1ab0ac1d7e2e3)

    2023-06-14T13:20:10.909719  /lava-610683/1/../bin/lava-test-case
    2023-06-14T13:20:10.932729  <8>[   27.840631] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled7-probed RESULT=3Dfail>
    2023-06-14T13:20:10.933261  /lava-610683/1/../bin/lava-test-case   =


  * baseline.bootrr.led6-probed: https://kernelci.org/test/case/id/6489be9a=
c56e24bee03061ce
        new failure (last pass: v6.1.26-1314-g1ab0ac1d7e2e3)

    2023-06-14T13:20:09.879708  /lava-610683/1/../bin/lava-test-case
    2023-06-14T13:20:09.902851  <8>[   26.810969] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled6-probed RESULT=3Dfail>   =


  * baseline.bootrr.led5-probed: https://kernelci.org/test/case/id/6489be9a=
c56e24bee03061cf
        new failure (last pass: v6.1.26-1314-g1ab0ac1d7e2e3)

    2023-06-14T13:20:08.851653  /lava-610683/1/../bin/lava-test-case
    2023-06-14T13:20:08.872772  <8>[   25.781026] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled5-probed RESULT=3Dfail>   =


  * baseline.bootrr.led4-probed: https://kernelci.org/test/case/id/6489be9a=
c56e24bee03061d0
        new failure (last pass: v6.1.26-1314-g1ab0ac1d7e2e3)

    2023-06-14T13:20:07.821762  /lava-610683/1/../bin/lava-test-case
    2023-06-14T13:20:07.844828  <8>[   24.752308] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled4-probed RESULT=3Dfail>   =


  * baseline.bootrr.led3-probed: https://kernelci.org/test/case/id/6489be9a=
c56e24bee03061d1
        new failure (last pass: v6.1.26-1314-g1ab0ac1d7e2e3)

    2023-06-14T13:20:06.792935  /lava-610683/1/../bin/lava-test-case
    2023-06-14T13:20:06.815017  <8>[   23.723118] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled3-probed RESULT=3Dfail>   =


  * baseline.bootrr.led2-probed: https://kernelci.org/test/case/id/6489be9a=
c56e24bee03061d2
        new failure (last pass: v6.1.26-1314-g1ab0ac1d7e2e3)

    2023-06-14T13:20:05.762909  /lava-610683/1/../bin/lava-test-case
    2023-06-14T13:20:05.785960  <8>[   22.693482] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled2-probed RESULT=3Dfail>   =


  * baseline.bootrr.led1-probed: https://kernelci.org/test/case/id/6489be9a=
c56e24bee03061d3
        new failure (last pass: v6.1.26-1314-g1ab0ac1d7e2e3)

    2023-06-14T13:20:04.733104  /lava-610683/1/../bin/lava-test-case
    2023-06-14T13:20:04.756097  <8>[   21.664152] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled1-probed RESULT=3Dfail>   =


  * baseline.bootrr.led0-probed: https://kernelci.org/test/case/id/6489be9a=
c56e24bee03061d4
        new failure (last pass: v6.1.26-1314-g1ab0ac1d7e2e3)

    2023-06-14T13:20:03.705166  /lava-610683/1/../bin/lava-test-case
    2023-06-14T13:20:03.726241  <8>[   20.634368] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled0-probed RESULT=3Dfail>   =


  * baseline.bootrr.iommu1-probed: https://kernelci.org/test/case/id/6489be=
9ac56e24bee03061e7
        new failure (last pass: v6.1.26-1314-g1ab0ac1d7e2e3)

    2023-06-14T13:20:01.247527  <4>[   18.155378] psmouse serio1: Failed to=
 enable mouse on 1c070000.kmi
    2023-06-14T13:20:02.244388  /lava-610683/1/../bin/lava-test-case
    2023-06-14T13:20:02.247340  <8>[   19.157419] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Diommu1-probed RESULT=3Dfail>   =


  * baseline.bootrr.1c050000_mmc-probed: https://kernelci.org/test/case/id/=
6489be9ac56e24bee03061f4
        new failure (last pass: v6.1.26-1314-g1ab0ac1d7e2e3)

    2023-06-14T13:20:00.881845  /lava-610683/1/../bin/lava-test-case
    2023-06-14T13:20:00.902873  <8>[   17.810144] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3D1c050000.mmc-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
kontron-kbox-a-230-ls        | arm64  | lab-kontron     | gcc-10   | defcon=
fig                    | 3          =


  Details:     https://kernelci.org/test/plan/id/6489b80b0f388a3e5630612e

  Results:     89 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm64/defconfig/gcc-10/lab-kontron/baseli=
ne-kontron-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm64/defconfig/gcc-10/lab-kontron/baseli=
ne-kontron-kbox-a-230-ls.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rcpm-driver-present: https://kernelci.org/test/case/id/=
6489b80b0f388a3e5630616e
        new failure (last pass: v6.1.26-1314-g1ab0ac1d7e2e3)

    2023-06-14T12:52:02.408061  /lava-357151/1/../bin/lava-test-case
    2023-06-14T12:52:02.411236  <8>[   13.953408] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.ftm-alarm-driver-present: https://kernelci.org/test/cas=
e/id/6489b80b0f388a3e5630616f
        new failure (last pass: v6.1.26-1314-g1ab0ac1d7e2e3)

    2023-06-14T12:52:03.420682  /lava-357151/1/../bin/lava-test-case
    2023-06-14T12:52:03.424031  <8>[   14.970901] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2023-06-14T12:52:04.443091  /lava-357151/1/../bin/lava-test-case   =


  * baseline.bootrr.layerscape-sfp-driver-present: https://kernelci.org/tes=
t/case/id/6489b80b0f388a3e56306186
        new failure (last pass: v6.1.26-1314-g1ab0ac1d7e2e3)

    2023-06-14T12:52:06.864808  /lava-357151/1/../bin/lava-test-case
    2023-06-14T12:52:06.868132  <8>[   18.408752] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
kontron-sl28-var3-ads2       | arm64  | lab-kontron     | gcc-10   | defcon=
fig                    | 3          =


  Details:     https://kernelci.org/test/plan/id/6489b80876f7f8f86430615c

  Results:     97 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm64/defconfig/gcc-10/lab-kontron/baseli=
ne-kontron-sl28-var3-ads2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm64/defconfig/gcc-10/lab-kontron/baseli=
ne-kontron-sl28-var3-ads2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rcpm-driver-present: https://kernelci.org/test/case/id/=
6489b80876f7f8f8643061a3
        new failure (last pass: v6.1.26-1314-g1ab0ac1d7e2e3)

    2023-06-14T12:52:00.129493  /lava-357150/1/../bin/lava-test-case
    2023-06-14T12:52:00.132716  <8>[   11.069843] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.ftm-alarm-driver-present: https://kernelci.org/test/cas=
e/id/6489b80876f7f8f8643061a4
        new failure (last pass: v6.1.26-1314-g1ab0ac1d7e2e3)

    2023-06-14T12:52:01.143008  /lava-357150/1/../bin/lava-test-case
    2023-06-14T12:52:01.146260  <8>[   12.088535] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2023-06-14T12:52:02.164426  /lava-357150/1/../bin/lava-test-case   =


  * baseline.bootrr.layerscape-sfp-driver-present: https://kernelci.org/tes=
t/case/id/6489b80876f7f8f8643061b9
        new failure (last pass: v6.1.26-1314-g1ab0ac1d7e2e3)

    2023-06-14T12:52:04.591856  /lava-357150/1/../bin/lava-test-case
    2023-06-14T12:52:04.594990  <8>[   15.533168] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6489b65ee9ae4831ab306138

  Results:     51 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-broonie/baseline-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-broonie/baseline-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/6489b65ee=
9ae4831ab30613b
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-14T12:45:02.268662  /lava-610632/1/../bin/lava-test-case
    2023-06-14T12:45:02.278590  <8>[   18.777178] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6489b866d0fc47cee3306175

  Results:     51 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm64/defconfig/gcc-10/lab-broonie/baseli=
ne-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm64/defconfig/gcc-10/lab-broonie/baseli=
ne-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/6489b866d=
0fc47cee3306178
        new failure (last pass: v6.1.26-1314-g1ab0ac1d7e2e3)

    2023-06-14T12:53:52.688407  /lava-610684/1/../bin/lava-test-case
    2023-06-14T12:53:52.698120  <8>[   18.816901] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6489b57ce1d8f9b200306136

  Results:     28 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/baseline-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/baseline-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6489b57ce1d8f9b200306152
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-14T12:41:08.002368  <8>[   15.601617] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-06-14T12:41:08.003941  + set +x

    2023-06-14T12:41:08.010496  <8>[   15.611292] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10724962_1.5.2.3.1>

    2023-06-14T12:41:08.114143  / ##

    2023-06-14T12:41:08.214811  export SHELL=3D/bin/sh

    2023-06-14T12:41:08.215013   #

    2023-06-14T12:41:08.315541  / # export SHELL=3D/bin/sh. /lava-10724962/=
environment

    2023-06-14T12:41:08.315748  =


    2023-06-14T12:41:08.416290  / # . /lava-10724962/environment/lava-10724=
962/bin/lava-test-runner /lava-10724962/1

    2023-06-14T12:41:08.416607  =

 =

    ... (17 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_mips-malta              | mips   | lab-broonie     | gcc-10   | malta_=
defconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/6489b4b31601e5d4fd306175

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/mips/malta_defconfig/gcc-10/lab-broonie/b=
aseline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/mips/malta_defconfig/gcc-10/lab-broonie/b=
aseline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6489b4b31601e5d4fd306=
176
        failing since 6 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_mips-malta              | mips   | lab-collabora   | gcc-10   | malta_=
defconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/6489b1388cf340015b3061e7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/mips/malta_defconfig/gcc-10/lab-collabora=
/baseline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/mips/malta_defconfig/gcc-10/lab-collabora=
/baseline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6489b1388cf340015b306=
1e8
        failing since 6 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 4          =


  Details:     https://kernelci.org/test/plan/id/6489b3439f692e5c11306152

  Results:     63 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm/multi_v7_defconfig/gcc-10/lab-collabo=
ra/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm/multi_v7_defconfig/gcc-10/lab-collabo=
ra/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwmmc_rockchip-sdio0-probed: https://kernelci.org/test/=
case/id/6489b3439f692e5c1130617e
        failing since 6 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77)

    2023-06-14T12:32:37.080658  <8>[   24.540619] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwmmc_rockchip-sdmmc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.dwmmc_rockchip-sdmmc-probed: https://kernelci.org/test/=
case/id/6489b3439f692e5c1130617f
        failing since 4 days (last pass: v4.4.302-cip74-rt43-218-g246f4be89=
a77, first fail: v4.19.283-cip98-1248-gcaf6e8ee921e9)

    2023-06-14T12:32:36.059781  	-w	P<8>[   23.516045] <LAVA_SIGNAL_TESTCAS=
E TEST_CASE_ID=3Ddwmmc_rockchip-driver-present RESULT=3Dpass>

    2023-06-14T12:32:36.063176  ad to last with leading zeros

    2023-06-14T12:32:36.065189  	-s SEP	String separator

    2023-06-14T12:32:36.068885  /lava-10724640/1/../bin/lava-test-case

    2023-06-14T12:32:36.074975  BusyBox v1.31.1 (2023-06-09 10:32:04 UTC) m=
ulti-call binary.

    2023-06-14T12:32:36.075192  =


    2023-06-14T12:32:36.079535  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-06-14T12:32:36.079762  =


    2023-06-14T12:32:36.084651  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-06-14T12:32:36.087535  FIRST, INC default to 1.
 =

    ... (6 line(s) more)  =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/6489b3439f692e5c11306182
        failing since 145 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-06-14T12:32:35.986884  BusyBox v1.31.1 (2023-06-09 10:32:04 UTC)<8=
>[   23.446082] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-06-14T12:32:35.988842   multi-call binary.

    2023-06-14T12:32:35.989216  =


    2023-06-14T12:32:35.993265  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-06-14T12:32:35.993641  =


    2023-06-14T12:32:35.998578  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/6489b3439f692e5c11306183
        failing since 145 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-06-14T12:32:35.967626  <8>[   23.428140] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>
   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6489b680ab075dec8e306130

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/6489b680ab075dec8e306136
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-14T12:45:56.552713  <8>[   34.420193] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-06-14T12:45:57.576355  /lava-10724928/1/../bin/lava-test-case

    2023-06-14T12:45:57.587979  <8>[   35.456934] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/6489b680ab075dec8e306137
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-14T12:45:56.539688  /lava-10724928/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6489babf9f47df772c30615e

  Results:     40 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm64/defconfig/gcc-10/lab-broonie/baseli=
ne-sun50i-h5-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm64/defconfig/gcc-10/lab-broonie/baseli=
ne-sun50i-h5-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.sun8-codec-analog-driver-present: https://kernelci.org/=
test/case/id/6489babf9f47df772c306169
        new failure (last pass: v6.1.26-1314-g1ab0ac1d7e2e3)

    2023-06-14T13:03:33.938434  /lava-610695/1/../bin/lava-test-case
    2023-06-14T13:03:33.954308  <8>[   20.014236] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8-codec-analog-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6489b6651f5fdfa49330614d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6489b6651f5fdfa493306=
14e
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6489b8f9f81bca94793061cd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm64/defconfig/gcc-10/lab-cip/baseline-z=
ynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm64/defconfig/gcc-10/lab-cip/baseline-z=
ynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6489b8f9f81bca9479306=
1ce
        new failure (last pass: v6.1.26-1314-g1ab0ac1d7e2e3) =

 =20

