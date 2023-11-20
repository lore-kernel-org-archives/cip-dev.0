Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB31C197A0
	for <webhook@archiver.kernel.org>; Mon, 20 Nov 2023 10:51:49 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.web10.47742.1700477506226702260
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 20 Nov 2023 02:51:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=h75uVTs9;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.171, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6c431b91b2aso3578893b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 20 Nov 2023 02:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700477505; x=1701082305; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=No91P7QHvKuioqm9nNCjPUuBy6OKbPCzUpQthXDVn1Q=;
        b=h75uVTs92Tz5d5FAPhPsItDsoVqbBRiF+noUv/aRJfcp8gPyoSx80a19hzkYXBSyD2
         OrKSa8asY6gJQ7pnedMum8DGAkDOg5bQX8cX6TzzBXr7HgqdbZS/cux1UX78yKjx8lBN
         RAZ10BozyTDhqbohedLNYkurz2sUSagjboknOaOdH+PrkMgJTQJL+tzVwHC/44e69KQa
         Ph2OOMQC4agXI4NymgmrdoOV0DStLvKuTvUtqLPeMhdGPsMwh+bZp3hK14wcCcbiFo0O
         ih/zR83U07q6PBfD8XFwYDZ5htApoEbhBKBtL2VMlaEu3356Uxd/qYzUgXPTX8BkDJXu
         oB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700477505; x=1701082305;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=No91P7QHvKuioqm9nNCjPUuBy6OKbPCzUpQthXDVn1Q=;
        b=WnM4dMMOaKqiMvAng/l3qT4ZNOCBkG3nIUCgSE3cYEb+T60Mz0dTDmQnc8yOz5FkCv
         3acpZctCT4Olcn9CmtqHTWR+MSB6Se3W4zPEkBHt4nX6ldSBcVS8xhMY1WhrJbMnpPN6
         Sird5vKNP88dj+kndfVzgcDf7K1S0PLi1X52/unIUyGCl5PZ7K2nkLte+PxYeMGvl3zw
         +H9dCopKu+B//Zy+aJ6NKpO449khNkwK/MTE5tdrcrQ2Rcn2ZAunLOjqhYJaOycKtY17
         R0DbzHn/lKe/yZoLwm8SnffYEKrVXCl0KjTVFVWTFuNDW1JsA5ICqDLw2EyEpWiHHbJu
         qovg==
X-Gm-Message-State: AOJu0YwW4ngqoCw0TtMuPqp4UymfidWUSDEOEPB+uq8+CzgzwdKfyBO4
	cXUQ2kXSqlE+72hmIrT4OelZalRlL2Tcv+LExlI=
X-Google-Smtp-Source: AGHT+IFULB1tigsVaZowYEKBI5DJ6jND/Gm2R5/KRldvudTNR0TF075pYJjyy3FT/mDK03fJgS+XwQ==
X-Received: by 2002:a05:6a00:179e:b0:6bd:3157:2dfe with SMTP id s30-20020a056a00179e00b006bd31572dfemr5526372pfg.7.1700477504908;
        Mon, 20 Nov 2023 02:51:44 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id q6-20020a056a00088600b0068620bee456sm5780558pfj.209.2023.11.20.02.51.43
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 02:51:44 -0800 (PST)
Message-ID: <655b3a40.050a0220.9598b.e42b@mx.google.com>
Date: Mon, 20 Nov 2023 02:51:44 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.200-cip40-513-g195b5d2b5c744
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 25 runs,
 36 regressions (v5.10.200-cip40-513-g195b5d2b5c744)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Nov 2023 10:51:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13598

cip-gitlab/ci/pavel/linux-test baseline-nfs: 25 runs, 36 regressions (v5.10=
.200-cip40-513-g195b5d2b5c744)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
at91sam9g20ek                | arm   | lab-broonie | gcc-10   | at91_dt_def=
config   | 1          =

at91sam9g20ek                | arm   | lab-broonie | gcc-10   | multi_v5_de=
fconfig  | 1          =

beaglebone-black             | arm   | lab-broonie | gcc-10   | multi_v7_de=
fconfig  | 7          =

beaglebone-black             | arm   | lab-cip     | gcc-10   | multi_v7_de=
fconfig  | 7          =

beaglebone-black             | arm   | lab-broonie | gcc-10   | omap2plus_d=
efconfig | 1          =

imx6dl-udoo                  | arm   | lab-broonie | gcc-10   | multi_v7_de=
fconfig  | 1          =

imx6q-udoo                   | arm   | lab-broonie | gcc-10   | multi_v7_de=
fconfig  | 1          =

juno-uboot                   | arm64 | lab-broonie | gcc-10   | defconfig  =
         | 10         =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig  =
         | 1          =

sun50i-a64-pine64-plus       | arm64 | lab-broonie | gcc-10   | defconfig  =
         | 5          =

sun50i-h5-lib...ch-all-h3-cc | arm64 | lab-broonie | gcc-10   | defconfig  =
         | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.200-cip40-513-g195b5d2b5c744/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.200-cip40-513-g195b5d2b5c744
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      195b5d2b5c7445a89862b44b490b78e540906e81 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
at91sam9g20ek                | arm   | lab-broonie | gcc-10   | at91_dt_def=
config   | 1          =


  Details:     https://kernelci.org/test/plan/id/655b321a0cbd1a167a7e4aa7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/arm/at91_dt_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/arm/at91_dt_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armel/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/655b321a0cbd1a167=
a7e4aa8
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
at91sam9g20ek                | arm   | lab-broonie | gcc-10   | multi_v5_de=
fconfig  | 1          =


  Details:     https://kernelci.org/test/plan/id/655b3436f026a5aea17e4a7a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/arm/multi_v5_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/arm/multi_v5_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armel/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/655b3436f026a5aea=
17e4a7b
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
beaglebone-black             | arm   | lab-broonie | gcc-10   | multi_v7_de=
fconfig  | 7          =


  Details:     https://kernelci.org/test/plan/id/655b31a3f4590d38d77e4a78

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.hdmi-audio: https://kernelci.org/test/case/id/655b3=
1a3f4590d38d77e4a7f
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:14:37.250037  /lava-255346/1/../bin/lava-test-case
    2023-11-20T10:14:37.311248  <8>[   78.472325] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/i=
d/655b31a3f4590d38d77e4a80
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:14:36.137357  /lava-255346/1/../bin/lava-test-case
    2023-11-20T10:14:36.202040  <8>[   77.357887] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-codec-driver-present: https://kernelci.org/tes=
t/case/id/655b31a3f4590d38d77e4a82
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:14:33.817464  /lava-255346/1/../bin/lava-test-case
    2023-11-20T10:14:33.881626  <8>[   75.032633] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-11-20T10:14:34.922204  /lava-255346/1/../bin/lava-test-case
    2023-11-20T10:14:34.994404  <8>[   76.149244] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case=
/id/655b31a3f4590d38d77e4a83
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:14:31.592112  /lava-255346/1/../bin/lava-test-case
    2023-11-20T10:14:31.661855  <8>[   72.813010] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-11-20T10:14:32.702016  /lava-255346/1/../bin/lava-test-case
    2023-11-20T10:14:32.761704  <8>[   73.921867] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tda19988-driver-present: https://kernelci.org/test/=
case/id/655b31a3f4590d38d77e4a84
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:14:28.479405  <6>[   69.638591] platform sound: deferred =
probe pending
    2023-11-20T10:14:29.383099  /lava-255346/1/../bin/lava-test-case
    2023-11-20T10:14:29.441316  <8>[   70.596430] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-11-20T10:14:30.483260  /lava-255346/1/../bin/lava-test-case
    2023-11-20T10:14:30.541386  <8>[   71.698791] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/655b31a3f4590d38d77e4a90
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:14:16.734876  /lava-255346/1/../bin/lava-test-case
    2023-11-20T10:14:16.792309  <8>[   57.949390] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/655b31a3f4590d38d77e4aa7
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:14:09.686946  #
    2023-11-20T10:14:09.687495  / # <8>[   50.743819] <LAVA_SIGNAL_ENDRUN 0=
_dmesg 255346_1.6.2.4.1>
    2023-11-20T10:14:09.788795  #export SHELL=3D/bin/sh
    2023-11-20T10:14:09.789177  =

    2023-11-20T10:14:09.890359  / # export SHELL=3D/bin/sh. /lava-255346/en=
vironment
    2023-11-20T10:14:09.890908  =

    2023-11-20T10:14:09.992304  / # . /lava-255346/environment/lava-255346/=
bin/lava-test-runner /lava-255346/1
    2023-11-20T10:14:09.992877  =

    2023-11-20T10:14:09.997408  / # /lava-255346/bin/lava-test-runner /lava=
-255346/1
    2023-11-20T10:14:10.199801  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
beaglebone-black             | arm   | lab-cip     | gcc-10   | multi_v7_de=
fconfig  | 7          =


  Details:     https://kernelci.org/test/plan/id/655b36c16b9891d0bc7e4a9f

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/arm/multi_v7_defconfig/gcc-10/lab-cip/b=
aseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/arm/multi_v7_defconfig/gcc-10/lab-cip/b=
aseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.hdmi-audio: https://kernelci.org/test/case/id/655b3=
6c16b9891d0bc7e4aa6
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:36:30.491187  /lava-1041892/1/../bin/lava-test-case
    2023-11-20T10:36:30.699431  <8>[   86.079175] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/i=
d/655b36c16b9891d0bc7e4aa7
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:36:29.273263  /lava-1041892/1/../bin/lava-test-case
    2023-11-20T10:36:29.432734  <8>[   84.803512] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-codec-driver-present: https://kernelci.org/tes=
t/case/id/655b36c16b9891d0bc7e4aa9
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:36:26.587823  /lava-1041892/1/../bin/lava-test-case
    2023-11-20T10:36:26.763334  <8>[   82.136805] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-11-20T10:36:27.819407  /lava-1041892/1/../bin/lava-test-case
    2023-11-20T10:36:27.989455  <8>[   83.363355] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case=
/id/655b36c16b9891d0bc7e4aaa
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:36:23.930293  /lava-1041892/1/../bin/lava-test-case
    2023-11-20T10:36:24.101383  <8>[   79.474931] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-11-20T10:36:25.160958  /lava-1041892/1/../bin/lava-test-case
    2023-11-20T10:36:25.530461  <8>[   80.909645] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tda19988-driver-present: https://kernelci.org/test/=
case/id/655b36c16b9891d0bc7e4aab
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:36:21.449087  /lava-1041892/1/../bin/lava-test-case
    2023-11-20T10:36:21.609559  <8>[   76.988064] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-11-20T10:36:22.667833  /lava-1041892/1/../bin/lava-test-case
    2023-11-20T10:36:22.870942  <8>[   78.248437] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/655b36c16b9891d0bc7e4ab7
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:36:05.053960  /lava-1041892/1/../bin/lava-test-case
    2023-11-20T10:36:05.203264  <8>[   60.576192] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/655b36c16b9891d0bc7e4acf
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:35:54.139038  <8>[   49.511829] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1041892_1.6.2.4.1>
    2023-11-20T10:35:54.407552  #
    2023-11-20T10:35:54.509893  / # #export SHELL=3D/bin/sh
    2023-11-20T10:35:54.510545  =

    2023-11-20T10:35:54.611818  / # export SHELL=3D/bin/sh. /lava-1041892/e=
nvironment
    2023-11-20T10:35:54.612493  =

    2023-11-20T10:35:54.713825  / # . /lava-1041892/environment/lava-104189=
2/bin/lava-test-runner /lava-1041892/1
    2023-11-20T10:35:54.714875  =

    2023-11-20T10:35:54.721272  / # /lava-1041892/bin/lava-test-runner /lav=
a-1041892/1
    2023-11-20T10:35:55.052822  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
beaglebone-black             | arm   | lab-broonie | gcc-10   | omap2plus_d=
efconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/655b33ee7017a3cc4f7e4a7e

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/arm/omap2plus_defconfig/gcc-10/lab-broo=
nie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/arm/omap2plus_defconfig/gcc-10/lab-broo=
nie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/=
id/655b33ee7017a3cc4f7e4a9d
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:24:24.838741  /lava-255423/1/../bin/lava-test-case
    2023-11-20T10:24:24.909199  <8>[   51.823980] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =

 =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
imx6dl-udoo                  | arm   | lab-broonie | gcc-10   | multi_v7_de=
fconfig  | 1          =


  Details:     https://kernelci.org/test/plan/id/655b34e06249cc18857e4a6d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/655b34e06249cc188=
57e4a6e
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
imx6q-udoo                   | arm   | lab-broonie | gcc-10   | multi_v7_de=
fconfig  | 1          =


  Details:     https://kernelci.org/test/plan/id/655b3222c11915fcc77e4a8d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/655b3222c11915fcc=
77e4a8e
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
juno-uboot                   | arm64 | lab-broonie | gcc-10   | defconfig  =
         | 10         =


  Details:     https://kernelci.org/test/plan/id/655b33aae1455153137e4abc

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/arm64/defconfig/gcc-10/lab-broonie/base=
line-nfs-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/arm64/defconfig/gcc-10/lab-broonie/base=
line-nfs-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.led7-probed: https://kernelci.org/test/case/id/655b=
33aae1455153137e4acd
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:23:16.005345  /lava-255400/1/../bin/lava-test-case
    2023-11-20T10:23:16.057946  <8>[   56.304545] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled7-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led6-probed: https://kernelci.org/test/case/id/655b=
33aae1455153137e4ace
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:23:14.929336  /lava-255400/1/../bin/lava-test-case
    2023-11-20T10:23:14.981925  <8>[   55.227349] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled6-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led5-probed: https://kernelci.org/test/case/id/655b=
33aae1455153137e4acf
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:23:13.853365  /lava-255400/1/../bin/lava-test-case
    2023-11-20T10:23:13.906289  <8>[   54.150936] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled5-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led4-probed: https://kernelci.org/test/case/id/655b=
33aae1455153137e4ad0
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:23:12.769350  /lava-255400/1/../bin/lava-test-case
    2023-11-20T10:23:12.830266  <8>[   53.074290] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled4-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led3-probed: https://kernelci.org/test/case/id/655b=
33aae1455153137e4ad1
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:23:11.704156  /lava-255400/1/../bin/lava-test-case
    2023-11-20T10:23:11.746229  <8>[   51.992456] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled3-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led2-probed: https://kernelci.org/test/case/id/655b=
33aae1455153137e4ad2
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:23:10.617212  /lava-255400/1/../bin/lava-test-case
    2023-11-20T10:23:10.664876  <8>[   50.911029] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled2-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led1-probed: https://kernelci.org/test/case/id/655b=
33aae1455153137e4ad3
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:23:09.555048  /lava-255400/1/../bin/lava-test-case
    2023-11-20T10:23:09.593787  <8>[   49.840697] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled1-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led0-probed: https://kernelci.org/test/case/id/655b=
33aae1455153137e4ad4
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:23:08.468308  /lava-255400/1/../bin/lava-test-case
    2023-11-20T10:23:08.516015  <8>[   48.764203] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled0-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.iommu1-probed: https://kernelci.org/test/case/id/65=
5b33aae1455153137e4ae7
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:23:06.401130  /lava-255400/1/../bin/lava-test-case
    2023-11-20T10:23:06.453785  <8>[   46.698706] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Diommu1-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.1c050000_mmc-probed: https://kernelci.org/test/case=
/id/655b33aae1455153137e4af4
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:23:04.568816  /lava-255400/1/../bin/lava-test-case
    2023-11-20T10:23:04.625763  <8>[   44.870544] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3D1c050000.mmc-probed RESULT=3Dfail>   =

 =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig  =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/655b3225c11915fcc77e4a94

  Results:     50 PASS, 4 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/arm64/defconfig/gcc-10/lab-broonie/base=
line-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/arm64/defconfig/gcc-10/lab-broonie/base=
line-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.sound-card: https://kernelci.org/test/case/id/655b3=
225c11915fcc77e4a9b
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:16:56.829995  /lava-255403/1/../bin/lava-test-case
    2023-11-20T10:16:56.872297  <8>[   37.330019] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>
    2023-11-20T10:16:56.872665  + set +x   =

 =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
sun50i-a64-pine64-plus       | arm64 | lab-broonie | gcc-10   | defconfig  =
         | 5          =


  Details:     https://kernelci.org/test/plan/id/655b32747bd4b2adc57e4b88

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/arm64/defconfig/gcc-10/lab-broonie/base=
line-nfs-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/arm64/defconfig/gcc-10/lab-broonie/base=
line-nfs-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.sound-card: https://kernelci.org/test/case/id/655b3=
2747bd4b2adc57e4ba2
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:18:11.941441  /lava-255386/1/../bin/lava-test-case
    2023-11-20T10:18:11.972384  <8>[   39.037731] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Di2s-probed RESULT=3Dblocked>
    2023-11-20T10:18:12.993228  /lava-255386/1/../bin/lava-test-case
    2023-11-20T10:18:13.024851  <8>[   40.088822] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sun4i-i2s-driver-present: https://kernelci.org/test=
/case/id/655b32747bd4b2adc57e4ba3
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:18:09.820695  /lava-255386/1/../bin/lava-test-case
    2023-11-20T10:18:09.855615  <8>[   36.917150] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcodec-digital-probed RESULT=3Dblocked>
    2023-11-20T10:18:10.884280  /lava-255386/1/../bin/lava-test-case
    2023-11-20T10:18:10.916720  <8>[   37.981314] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun4i-i2s-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sun8i-codec-driver-present: https://kernelci.org/te=
st/case/id/655b32747bd4b2adc57e4ba4
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:18:07.703442  /lava-255386/1/../bin/lava-test-case
    2023-11-20T10:18:07.733600  <8>[   34.799668] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcodec-analog-probed RESULT=3Dblocked>
    2023-11-20T10:18:08.763466  /lava-255386/1/../bin/lava-test-case
    2023-11-20T10:18:08.793054  <8>[   35.859518] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8i-codec-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sun50i-codec-analog-driver-present: https://kernelc=
i.org/test/case/id/655b32747bd4b2adc57e4ba5
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:18:06.645116  /lava-255386/1/../bin/lava-test-case
    2023-11-20T10:18:06.678711  <8>[   33.742536] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun50i-codec-analog-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/655b32747bd4b2adc57e4bb8
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:18:02.877291  <8>[   29.942260] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 255386_1.6.2.4.1>
    2023-11-20T10:18:02.985808  #
    2023-11-20T10:18:03.087351  / # #export SHELL=3D/bin/sh
    2023-11-20T10:18:03.087684  =

    2023-11-20T10:18:03.188725  / # export SHELL=3D/bin/sh. /lava-255386/en=
vironment
    2023-11-20T10:18:03.189238  =

    2023-11-20T10:18:03.290358  / # . /lava-255386/environment/lava-255386/=
bin/lava-test-runner /lava-255386/1
    2023-11-20T10:18:03.290821  =

    2023-11-20T10:18:03.294383  / # /lava-255386/bin/lava-test-runner /lava=
-255386/1
    2023-11-20T10:18:03.428007  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
sun50i-h5-lib...ch-all-h3-cc | arm64 | lab-broonie | gcc-10   | defconfig  =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/655b33b2e1455153137e4afe

  Results:     40 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/arm64/defconfig/gcc-10/lab-broonie/base=
line-nfs-sun50i-h5-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/arm64/defconfig/gcc-10/lab-broonie/base=
line-nfs-sun50i-h5-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.sun8-codec-analog-driver-present: https://kernelci.=
org/test/case/id/655b33b2e1455153137e4b0d
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e)

    2023-11-20T10:23:27.724925  /lava-255391/1/../bin/lava-test-case
    2023-11-20T10:23:27.762316  <8>[   39.034284] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8-codec-analog-driver-present RESULT=3Dfail>   =

 =20

