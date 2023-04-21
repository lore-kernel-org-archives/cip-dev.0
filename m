Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B94EC7EE20
	for <webhook@archiver.kernel.org>; Fri, 21 Apr 2023 12:50:12 +0000 (UTC)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
 by mx.groups.io with SMTP id smtpd.web11.10624.1682081409139850322
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 21 Apr 2023 05:50:09 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=stAQoMIf;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.172, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-517bfdf55c3so1289673a12.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 21 Apr 2023 05:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682081408; x=1684673408;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HLuZcz7ChZ49G7xAX/E5l3ajEjx8leuJdAogIXpDDCo=;
        b=stAQoMIf/R4Eaymw3HLGPMuHjjyu4EmXUc1T9LTTlsvElxt9D7A7VP/y/zk/MO3u6Y
         nXlEEt5acprcaAvg9mPJAUzYaJ3qWCzUcJPPR5ADa+WUJw0abWo68xcHaV36IqaoQ/GX
         0d6LlC/EMSOixjRa2IvxeB6SSRw0NPUDxhjYetEDhl6pGZ8fULZ/Q1Fi1KDa8T+/vF8T
         QybHSowVFW2I7m+RVs6XEcP1AzFSdsAnThI12ADhYG5yLtILsvPflnI3CKVMoqJfRkaP
         rZdPimgVtevv9mZzuS1q3Da516cQj5R/oXLSWBB71r5SeAL6rpZKZNTDy0r+rubg7JPH
         grxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682081408; x=1684673408;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HLuZcz7ChZ49G7xAX/E5l3ajEjx8leuJdAogIXpDDCo=;
        b=JtBHL4g84W5/9ReX/lvBJ382fXfF6Wz5PVUV9ade2i7pCqYFlPWLOmqT2LqJ9MS6C8
         hsawud57tlpD1VGtugCoNvccJWRO3gei4gNxmMlAahBR6zyhS0JkzUbS8ntkJdmO6X61
         qw2eoPM91iuKC6+xASnMmFYos15e7vjM8GgfVydFQTaVU/bgejqFAPXgBbCbyGI79Sj+
         uvwKIRE5m3vXfvcAroWKskoQhaK28pYhzqOBxyV8zTUo9CrMD38uOM6BJMkpRDLzi1qV
         ZmcI371A8JS9knwyVz56HB4B6WhEmdyKL39KHq3o6d+6/wzYwhY8HxHyDa/GIpQzhgnV
         f5aw==
X-Gm-Message-State: AAQBX9fkWCIE/blF7YFsgMkmH8by+LVt4fhYpDgY31DBSUyzAK6kJjHe
	ouLIPm14A0fK4ErDdCQine1IYnl1dgkI6RjD+DkHLYz3
X-Google-Smtp-Source: AKy350Ye6w44NsEdG0Jy4WtltDgAJIheaFyXr2P6wv4oqQ90EgqO/810iFny5Dj+gO+QgWEmVoekEQ==
X-Received: by 2002:a05:6a21:3a82:b0:ef:cb4c:c24c with SMTP id zv2-20020a056a213a8200b000efcb4cc24cmr6400304pzb.23.1682081407680;
        Fri, 21 Apr 2023 05:50:07 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b9-20020aa79509000000b00627df889420sm3038028pfp.173.2023.04.21.05.50.07
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 05:50:07 -0700 (PDT)
Message-ID: <6442867f.a70a0220.6140c.6360@mx.google.com>
Date: Fri, 21 Apr 2023 05:50:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.177-cip31-33-gd59f246891e73
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline: 123 runs,
 18 regressions (v5.10.177-cip31-33-gd59f246891e73)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Apr 2023 12:50:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11311

cip-gitlab/ci/pavel/linux-test baseline: 123 runs, 18 regressions (v5.10.17=
7-cip31-33-gd59f246891e73)

Regressions Summary
-------------------

platform               | arch  | lab             | compiler | defconfig    =
              | regressions
-----------------------+-------+-----------------+----------+--------------=
--------------+------------
bcm2836-rpi-2-b        | arm   | lab-collabora   | gcc-10   | multi_v7_defc=
onfig         | 1          =

fsl-ls1088a-rdb        | arm64 | lab-nxp         | gcc-10   | defconfig    =
              | 1          =

fsl-lx2160a-rdb        | arm64 | lab-nxp         | gcc-10   | defconfig    =
              | 1          =

imx6dl-udoo            | arm   | lab-broonie     | gcc-10   | imx_v6_v7_def=
config        | 1          =

imx6dl-udoo            | arm   | lab-broonie     | gcc-10   | multi_v7_defc=
onfig         | 1          =

imx6q-udoo             | arm   | lab-broonie     | gcc-10   | imx_v6_v7_def=
config        | 1          =

imx6q-udoo             | arm   | lab-broonie     | gcc-10   | multi_v7_defc=
onfig         | 1          =

imx6qp-wandboard-revd1 | arm   | lab-pengutronix | gcc-10   | imx_v6_v7_def=
config        | 1          =

imx6qp-wandboard-revd1 | arm   | lab-pengutronix | gcc-10   | multi_v7_defc=
onfig         | 1          =

imx7ulp-evk            | arm   | lab-nxp         | gcc-10   | multi_v7_defc=
onfig         | 1          =

r8a7743-iwg20d-q7      | arm   | lab-cip         | gcc-10   | shmobile_defc=
onfig         | 1          =

rk3288-veyron-jaq      | arm   | lab-collabora   | gcc-10   | multi_v7_defc=
onfig         | 3          =

rk3399-gru-kevin       | arm64 | lab-collabora   | gcc-10   | defconfig+arm=
64-chromebook | 2          =

zynqmp-zcu102          | arm64 | lab-cip         | gcc-10   | defconfig    =
              | 1          =

zynqmp-zcu102          | arm64 | lab-cip         | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.177-cip31-33-gd59f246891e73/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.177-cip31-33-gd59f246891e73
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      d59f246891e73b9c221f394dd91c309755c3e8ce =



Test Regressions
---------------- =



platform               | arch  | lab             | compiler | defconfig    =
              | regressions
-----------------------+-------+-----------------+----------+--------------=
--------------+------------
bcm2836-rpi-2-b        | arm   | lab-collabora   | gcc-10   | multi_v7_defc=
onfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/64427f5113ab96fcdd2e860e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.177-cip31-33-gd59f246891e73/arm/multi_v7_defconfig/gcc-10/lab-collab=
ora/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.177-cip31-33-gd59f246891e73/arm/multi_v7_defconfig/gcc-10/lab-collab=
ora/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64427f5113ab96fcdd2e8=
60f
        failing since 29 days (last pass: v4.19.277-cip94-1098-g26d9f86d942=
d, first fail: v5.10.175-cip29-rt12) =

 =



platform               | arch  | lab             | compiler | defconfig    =
              | regressions
-----------------------+-------+-----------------+----------+--------------=
--------------+------------
fsl-ls1088a-rdb        | arm64 | lab-nxp         | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/64427c975c4d8be50d2e85f8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.177-cip31-33-gd59f246891e73/arm64/defconfig/gcc-10/lab-nxp/baseline-=
fsl-ls1088a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.177-cip31-33-gd59f246891e73/arm64/defconfig/gcc-10/lab-nxp/baseline-=
fsl-ls1088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64427c975c4d8be50d2e85fc
        failing since 29 days (last pass: v4.19.277-cip94-1098-g26d9f86d942=
d, first fail: v5.10.175-cip29-rt12)

    2023-04-21T12:07:21.726196  [   20.646643] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1205494_1.5.2.4.1>
    2023-04-21T12:07:21.833420  / # #
    2023-04-21T12:07:21.935226  export SHELL=3D/bin/sh
    2023-04-21T12:07:21.935667  #
    2023-04-21T12:07:22.037009  / # export SHELL=3D/bin/sh. /lava-1205494/e=
nvironment
    2023-04-21T12:07:22.037449  =

    2023-04-21T12:07:22.138810  / # . /lava-1205494/environment/lava-120549=
4/bin/lava-test-runner /lava-1205494/1
    2023-04-21T12:07:22.139557  =

    2023-04-21T12:07:22.141584  / # /lava-1205494/bin/lava-test-runner /lav=
a-1205494/1
    2023-04-21T12:07:22.159768  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform               | arch  | lab             | compiler | defconfig    =
              | regressions
-----------------------+-------+-----------------+----------+--------------=
--------------+------------
fsl-lx2160a-rdb        | arm64 | lab-nxp         | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/64427cb68bbd9932262e85f6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.177-cip31-33-gd59f246891e73/arm64/defconfig/gcc-10/lab-nxp/baseline-=
fsl-lx2160a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.177-cip31-33-gd59f246891e73/arm64/defconfig/gcc-10/lab-nxp/baseline-=
fsl-lx2160a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64427cb68bbd9932262e85fb
        new failure (last pass: v5.10.145-rt74-1329-ga59fc50f38f6)

    2023-04-21T12:07:56.495527  [   17.042351] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1205491_1.5.2.4.1>
    2023-04-21T12:07:56.599286  / # #
    2023-04-21T12:07:56.700622  export SHELL=3D/bin/sh
    2023-04-21T12:07:56.700980  #
    2023-04-21T12:07:56.801963  / # export SHELL=3D/bin/sh. /lava-1205491/e=
nvironment
    2023-04-21T12:07:56.802206  =

    2023-04-21T12:07:56.903178  / # . /lava-1205491/environment/lava-120549=
1/bin/lava-test-runner /lava-1205491/1
    2023-04-21T12:07:56.903590  =

    2023-04-21T12:07:56.905264  / # /lava-1205491/bin/lava-test-runner /lav=
a-1205491/1
    2023-04-21T12:07:56.921842  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform               | arch  | lab             | compiler | defconfig    =
              | regressions
-----------------------+-------+-----------------+----------+--------------=
--------------+------------
imx6dl-udoo            | arm   | lab-broonie     | gcc-10   | imx_v6_v7_def=
config        | 1          =


  Details:     https://kernelci.org/test/plan/id/64427ebce52704ef6f2e85e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.177-cip31-33-gd59f246891e73/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.177-cip31-33-gd59f246891e73/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64427ebce52704ef6f2e8=
5e7
        new failure (last pass: v4.4-st20-1100-ga8cadce4b9649) =

 =



platform               | arch  | lab             | compiler | defconfig    =
              | regressions
-----------------------+-------+-----------------+----------+--------------=
--------------+------------
imx6dl-udoo            | arm   | lab-broonie     | gcc-10   | multi_v7_defc=
onfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/64428010d3b86dd7942e8617

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.177-cip31-33-gd59f246891e73/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.177-cip31-33-gd59f246891e73/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64428010d3b86dd7942e8=
618
        new failure (last pass: v4.4-st20-1100-ga8cadce4b9649) =

 =



platform               | arch  | lab             | compiler | defconfig    =
              | regressions
-----------------------+-------+-----------------+----------+--------------=
--------------+------------
imx6q-udoo             | arm   | lab-broonie     | gcc-10   | imx_v6_v7_def=
config        | 1          =


  Details:     https://kernelci.org/test/plan/id/64427e1c879f4cfc602e85f3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.177-cip31-33-gd59f246891e73/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.177-cip31-33-gd59f246891e73/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64427e1c879f4cfc602e8=
5f4
        new failure (last pass: v4.4-st20-1100-ga8cadce4b9649) =

 =



platform               | arch  | lab             | compiler | defconfig    =
              | regressions
-----------------------+-------+-----------------+----------+--------------=
--------------+------------
imx6q-udoo             | arm   | lab-broonie     | gcc-10   | multi_v7_defc=
onfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/644280ecaf8616ea362e8601

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.177-cip31-33-gd59f246891e73/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.177-cip31-33-gd59f246891e73/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644280ecaf8616ea362e8=
602
        new failure (last pass: v4.4-st20-1100-ga8cadce4b9649) =

 =



platform               | arch  | lab             | compiler | defconfig    =
              | regressions
-----------------------+-------+-----------------+----------+--------------=
--------------+------------
imx6qp-wandboard-revd1 | arm   | lab-pengutronix | gcc-10   | imx_v6_v7_def=
config        | 1          =


  Details:     https://kernelci.org/test/plan/id/64427ce79be5f0c4b02e861c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.177-cip31-33-gd59f246891e73/arm/imx_v6_v7_defconfig/gcc-10/lab-pengu=
tronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.177-cip31-33-gd59f246891e73/arm/imx_v6_v7_defconfig/gcc-10/lab-pengu=
tronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64427ce79be5f0c4b02e8621
        failing since 92 days (last pass: v5.10.158-cip22-435-g2c52868ae1cb=
c, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-04-21T12:08:48.765328  + set +x
    2023-04-21T12:08:48.765501  [   10.239643] <LAVA_SIGNAL_ENDRUN 0_dmesg =
933311_1.5.2.3.1>
    2023-04-21T12:08:48.873646  / # #
    2023-04-21T12:08:48.975496  export SHELL=3D/bin/sh
    2023-04-21T12:08:48.976063  #
    2023-04-21T12:08:49.077313  / # export SHELL=3D/bin/sh. /lava-933311/en=
vironment
    2023-04-21T12:08:49.077761  =

    2023-04-21T12:08:49.179039  / # . /lava-933311/environment/lava-933311/=
bin/lava-test-runner /lava-933311/1
    2023-04-21T12:08:49.179624  =

    2023-04-21T12:08:49.182218  / # /lava-933311/bin/lava-test-runner /lava=
-933311/1 =

    ... (12 line(s) more)  =

 =



platform               | arch  | lab             | compiler | defconfig    =
              | regressions
-----------------------+-------+-----------------+----------+--------------=
--------------+------------
imx6qp-wandboard-revd1 | arm   | lab-pengutronix | gcc-10   | multi_v7_defc=
onfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/64427edd7ce0b6a45a2e85e6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.177-cip31-33-gd59f246891e73/arm/multi_v7_defconfig/gcc-10/lab-pengut=
ronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.177-cip31-33-gd59f246891e73/arm/multi_v7_defconfig/gcc-10/lab-pengut=
ronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64427edd7ce0b6a45a2e85eb
        failing since 92 days (last pass: v5.10.158-cip22-435-g2c52868ae1cb=
c, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-04-21T12:17:24.905540  + set[    7.246834] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 933325_1.5.2.3.1>
    2023-04-21T12:17:24.905750   +x
    2023-04-21T12:17:25.012018  / # #
    2023-04-21T12:17:25.113644  export SHELL=3D/bin/sh
    2023-04-21T12:17:25.114109  #
    2023-04-21T12:17:25.215336  / # export SHELL=3D/bin/sh. /lava-933325/en=
vironment
    2023-04-21T12:17:25.215751  =

    2023-04-21T12:17:25.317032  / # . /lava-933325/environment/lava-933325/=
bin/lava-test-runner /lava-933325/1
    2023-04-21T12:17:25.317649  =

    2023-04-21T12:17:25.320010  / # /lava-933325/bin/lava-test-runner /lava=
-933325/1 =

    ... (12 line(s) more)  =

 =



platform               | arch  | lab             | compiler | defconfig    =
              | regressions
-----------------------+-------+-----------------+----------+--------------=
--------------+------------
imx7ulp-evk            | arm   | lab-nxp         | gcc-10   | multi_v7_defc=
onfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/64427f6076426d17bf2e85e6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.177-cip31-33-gd59f246891e73/arm/multi_v7_defconfig/gcc-10/lab-nxp/ba=
seline-imx7ulp-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.177-cip31-33-gd59f246891e73/arm/multi_v7_defconfig/gcc-10/lab-nxp/ba=
seline-imx7ulp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64427f6076426d17bf2e85eb
        failing since 29 days (last pass: v5.10.145-rt74-1329-ga59fc50f38f6=
, first fail: v5.10.175-cip29-rt12)

    2023-04-21T12:19:22.262214  + set +x
    2023-04-21T12:19:22.263320  <8>[   28.997476] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1205515_1.5.2.4.1>
    2023-04-21T12:19:22.372994  / # #
    2023-04-21T12:19:23.532962  export SHELL=3D/bin/sh
    2023-04-21T12:19:23.538655  #
    2023-04-21T12:19:23.538967  / # export SHELL=3D/bin/sh
    2023-04-21T12:19:25.086536  / # . /lava-1205515/environment
    2023-04-21T12:19:27.913422  /lava-1205515/bin/lava-test-runner /lava-12=
05515/1
    2023-04-21T12:19:27.919473  . /lava-1205515/environment
    2023-04-21T12:19:27.919742  / # /lava-1205515/bin/lava-test-runner /lav=
a-1205515/1 =

    ... (12 line(s) more)  =

 =



platform               | arch  | lab             | compiler | defconfig    =
              | regressions
-----------------------+-------+-----------------+----------+--------------=
--------------+------------
r8a7743-iwg20d-q7      | arm   | lab-cip         | gcc-10   | shmobile_defc=
onfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/64427b40b5788b2c1a2e85f6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.177-cip31-33-gd59f246891e73/arm/shmobile_defconfig/gcc-10/lab-cip/ba=
seline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.177-cip31-33-gd59f246891e73/arm/shmobile_defconfig/gcc-10/lab-cip/ba=
seline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64427b40b5788b2c1a2e8=
5f7
        new failure (last pass: v4.4.302-cip74-rt43) =

 =



platform               | arch  | lab             | compiler | defconfig    =
              | regressions
-----------------------+-------+-----------------+----------+--------------=
--------------+------------
rk3288-veyron-jaq      | arm   | lab-collabora   | gcc-10   | multi_v7_defc=
onfig         | 3          =


  Details:     https://kernelci.org/test/plan/id/64427f15fead81cfa82e8616

  Results:     63 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.177-cip31-33-gd59f246891e73/arm/multi_v7_defconfig/gcc-10/lab-collab=
ora/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.177-cip31-33-gd59f246891e73/arm/multi_v7_defconfig/gcc-10/lab-collab=
ora/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwmmc_rockchip-sdmmc-probed: https://kernelci.org/test/=
case/id/64427f15fead81cfa82e8643
        new failure (last pass: v4.4-st20-1100-ga8cadce4b9649)

    2023-04-21T12:18:07.649338  	-w	P<8>[   23.418236] <LAVA_SIGNAL_TESTCAS=
E TEST_CASE_ID=3Ddwmmc_rockchip-driver-present RESULT=3Dpass>

    2023-04-21T12:18:07.652160  ad to last with leading zeros

    2023-04-21T12:18:07.654601  	-s SEP	String separator

    2023-04-21T12:18:07.659151  /lava-10074845/1/../bin/lava-test-case

    2023-04-21T12:18:07.664527  BusyBox v1.31.1 (2023-04-14 10:59:35 UTC) m=
ulti-call binary.

    2023-04-21T12:18:07.664761  =


    2023-04-21T12:18:07.669253  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-04-21T12:18:07.669506  =


    2023-04-21T12:18:07.674404  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-04-21T12:18:07.677619  FIRST, INC default to 1.
 =

    ... (5 line(s) more)  =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/64427f15fead81cfa82e8646
        failing since 91 days (last pass: v5.10.158-cip22-435-g2c52868ae1cb=
c, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-04-21T12:18:07.574905  BusyBox v1.31.1 (2023-04-14 10:59:35 UTC)<8=
>[   23.348389] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-04-21T12:18:07.576773   multi-call binary.

    2023-04-21T12:18:07.576995  =


    2023-04-21T12:18:07.581267  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-04-21T12:18:07.581511  =


    2023-04-21T12:18:07.586485  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/64427f15fead81cfa82e8647
        failing since 91 days (last pass: v5.10.158-cip22-435-g2c52868ae1cb=
c, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-04-21T12:18:07.555787  <8>[   23.330511] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>
   =

 =



platform               | arch  | lab             | compiler | defconfig    =
              | regressions
-----------------------+-------+-----------------+----------+--------------=
--------------+------------
rk3399-gru-kevin       | arm64 | lab-collabora   | gcc-10   | defconfig+arm=
64-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/64427f4755bbc9edca2e8620

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.177-cip31-33-gd59f246891e73/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.177-cip31-33-gd59f246891e73/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/64427f4755bbc9edca2e8626
        failing since 30 days (last pass: v5.10.168-cip27-456-g42a59c4e5329=
, first fail: v4.19.277-cip94-1098-g26d9f86d942d)

    2023-04-21T12:18:59.824415  /lava-10074805/1/../bin/lava-test-case

    2023-04-21T12:18:59.835337  <8>[   35.099900] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/64427f4755bbc9edca2e8627
        failing since 30 days (last pass: v5.10.168-cip27-456-g42a59c4e5329=
, first fail: v4.19.277-cip94-1098-g26d9f86d942d)

    2023-04-21T12:18:58.787158  /lava-10074805/1/../bin/lava-test-case

    2023-04-21T12:18:58.798037  <8>[   34.063141] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform               | arch  | lab             | compiler | defconfig    =
              | regressions
-----------------------+-------+-----------------+----------+--------------=
--------------+------------
zynqmp-zcu102          | arm64 | lab-cip         | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/64427cd0b697723c2b2e85f4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.177-cip31-33-gd59f246891e73/arm64/defconfig/gcc-10/lab-cip/baseline-=
zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.177-cip31-33-gd59f246891e73/arm64/defconfig/gcc-10/lab-cip/baseline-=
zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64427cd0b697723c2b2e8=
5f5
        failing since 29 days (last pass: v4.19.277-cip94-1098-g26d9f86d942=
d, first fail: v5.10.175-cip29-rt12) =

 =



platform               | arch  | lab             | compiler | defconfig    =
              | regressions
-----------------------+-------+-----------------+----------+--------------=
--------------+------------
zynqmp-zcu102          | arm64 | lab-cip         | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64427fa0226259a82e2e85e9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.177-cip31-33-gd59f246891e73/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.177-cip31-33-gd59f246891e73/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64427fa0226259a82e2e8=
5ea
        failing since 29 days (last pass: v4.19.277-cip94-1098-g26d9f86d942=
d, first fail: v5.10.175-cip29-rt12) =

 =20

