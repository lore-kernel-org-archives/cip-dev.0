Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37353C7EE23
	for <webhook@archiver.kernel.org>; Sun, 21 May 2023 09:55:14 +0000 (UTC)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
 by mx.groups.io with SMTP id smtpd.web11.5173.1684662906536532417
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 21 May 2023 02:55:06 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=YgStd//7;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.173, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-64d2981e3abso2317372b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 21 May 2023 02:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684662905; x=1687254905;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Xl3KLfood43bhhzYEvWHrnKcoKcj6FPRUrIoFBzF6HU=;
        b=YgStd//7oY2g/Zd7Hu3K1BNDOkjKJcHwhF/XYr8rTYWKXK9j4/Cdc4igtzsHsR4oPZ
         Z+PhJIP+3n84Xk+ToOtII7IorGHOxxm+dzHPJWFchqVQefbj6fEHHf/0pBfDiakihtTZ
         McRV6sgf8L2tAVqLz5BB1ZItMTpVfGd7xDeOvL2aSGrw5FS2AqaV3cCvQnMd/dWbPczh
         97NIj5rtsChlzLRHyAr2YOynBTE0a8ni0yTm+sx8H2HW6Y3fFoqDjaCrb4EzdxaWeY84
         Gt1T5MKLw05t6PG4G9jQNjbOBvxsZiZaKVYjtJ8BBO/AaWQbrnYHjA5o2vXvvFp81/gg
         +SvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684662905; x=1687254905;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xl3KLfood43bhhzYEvWHrnKcoKcj6FPRUrIoFBzF6HU=;
        b=Vx+w1KWhHZpDSKCt+5wDE0lSyQ/nrY6RXnT4ComkHxD3FJYehaPlPaUH9ymwrKwQQe
         Aw9cZeemzKJuUL2hEY9d5MTASefA8+XJJA8VclIoj/cgdsVWWmscQmRnZ5Zq2f+b2m29
         +75rKR6RhQOAY1+fyth4Qv0Ib65kjWHEX7t9BwMxynXy0FClBue4K5JdQpcrzMp54653
         cCs7TdLtUU1mmcmQyU59pyfwKX+cB6BHZGt1ESC0a4+IS8MfqojpcDmFehx44gbaCM8X
         B1MdZdFtoc/10Ihk3G/2DhURTte8A8yOpLW2ocL+y4ehKlGv9yQRbitD/9wQltUga5r9
         T8uA==
X-Gm-Message-State: AC+VfDwjUgSTPFVF1KZtTRP3crob0AsvXEtr9irr1gKrMvWrvBcNIABx
	bf4zsQNqdmQA9+WMwGiqaE+7poxMGcUhaYjkbKBsKQ==
X-Google-Smtp-Source: ACHHUZ6W8qkxmh4UmDImWBZaVjqryE+E3osqX+CUIA4TJrzc5u+WiyxpmEB7wDOwK31CBLFePNoHOA==
X-Received: by 2002:a05:6a00:2188:b0:64d:fd0:dd1a with SMTP id h8-20020a056a00218800b0064d0fd0dd1amr9878700pfi.16.1684662905153;
        Sun, 21 May 2023 02:55:05 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id m6-20020aa79006000000b006372791d708sm2325535pfo.104.2023.05.21.02.55.04
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 02:55:04 -0700 (PDT)
Message-ID: <6469ea78.a70a0220.d28bc.3b96@mx.google.com>
Date: Sun, 21 May 2023 02:55:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.180-cip33-11-gfea7994097935
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline: 97 runs,
 9 regressions (v5.10.180-cip33-11-gfea7994097935)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 21 May 2023 09:55:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11575

cip-gitlab/ci/pavel/linux-test baseline: 97 runs, 9 regressions (v5.10.180-=
cip33-11-gfea7994097935)

Regressions Summary
-------------------

platform               | arch  | lab             | compiler | defconfig    =
              | regressions
-----------------------+-------+-----------------+----------+--------------=
--------------+------------
fsl-ls1088a-rdb        | arm64 | lab-nxp         | gcc-10   | defconfig    =
              | 1          =

imx6qp-wandboard-revd1 | arm   | lab-pengutronix | gcc-10   | imx_v6_v7_def=
config        | 1          =

imx6qp-wandboard-revd1 | arm   | lab-pengutronix | gcc-10   | multi_v7_defc=
onfig         | 1          =

imx7ulp-evk            | arm   | lab-nxp         | gcc-10   | multi_v7_defc=
onfig         | 1          =

r8a7743-iwg20d-q7      | arm   | lab-cip         | gcc-10   | shmobile_defc=
onfig         | 1          =

rk3399-gru-kevin       | arm64 | lab-collabora   | gcc-10   | defconfig+arm=
64-chromebook | 2          =

zynqmp-zcu102          | arm64 | lab-cip         | gcc-10   | defconfig    =
              | 1          =

zynqmp-zcu102          | arm64 | lab-cip         | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.180-cip33-11-gfea7994097935/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.180-cip33-11-gfea7994097935
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      fea799409793527f9b9b2d2c53f0dc4e3ac7ac6a =



Test Regressions
---------------- =



platform               | arch  | lab             | compiler | defconfig    =
              | regressions
-----------------------+-------+-----------------+----------+--------------=
--------------+------------
fsl-ls1088a-rdb        | arm64 | lab-nxp         | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/6469de217ff01a9f852e863f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip33-11-gfea7994097935/arm64/defconfig/gcc-10/lab-nxp/baseline-=
fsl-ls1088a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip33-11-gfea7994097935/arm64/defconfig/gcc-10/lab-nxp/baseline-=
fsl-ls1088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6469de217ff01a9f852e8642
        failing since 59 days (last pass: v4.19.277-cip94-1098-g26d9f86d942=
d, first fail: v5.10.175-cip29-rt12)

    2023-05-21T09:00:19.978870  / # #
    2023-05-21T09:00:20.080496  export SHELL=3D/bin/sh
    2023-05-21T09:00:20.081101  #
    2023-05-21T09:00:20.182395  / # export SHELL=3D/bin/sh. /lava-1226146/e=
nvironment
    2023-05-21T09:00:20.182955  =

    2023-05-21T09:00:20.284396  / # . /lava-1226146/environment/lava-122614=
6/bin/lava-test-runner /lava-1226146/1
    2023-05-21T09:00:20.285176  =

    2023-05-21T09:00:20.287023  / # /lava-1226146/bin/lava-test-runner /lav=
a-1226146/1
    2023-05-21T09:00:20.304937  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-21T09:00:20.310388  + [   10.962199] <LAVA_SIGNAL_STARTRUN 1_bo=
otrr 1226146_1.5.2.4.5> =

    ... (11 line(s) more)  =

 =



platform               | arch  | lab             | compiler | defconfig    =
              | regressions
-----------------------+-------+-----------------+----------+--------------=
--------------+------------
imx6qp-wandboard-revd1 | arm   | lab-pengutronix | gcc-10   | imx_v6_v7_def=
config        | 1          =


  Details:     https://kernelci.org/test/plan/id/6469df13d0cd12413f2e85ed

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip33-11-gfea7994097935/arm/imx_v6_v7_defconfig/gcc-10/lab-pengu=
tronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip33-11-gfea7994097935/arm/imx_v6_v7_defconfig/gcc-10/lab-pengu=
tronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6469df13d0cd12413f2e85f2
        failing since 122 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-05-21T09:06:19.907262  + set +x
    2023-05-21T09:06:19.907422  [   10.196765] <LAVA_SIGNAL_ENDRUN 0_dmesg =
955742_1.5.2.3.1>
    2023-05-21T09:06:20.015414  / # #
    2023-05-21T09:06:20.117399  export SHELL=3D/bin/sh
    2023-05-21T09:06:20.117952  #
    2023-05-21T09:06:20.219338  / # export SHELL=3D/bin/sh. /lava-955742/en=
vironment
    2023-05-21T09:06:20.219844  =

    2023-05-21T09:06:20.321065  / # . /lava-955742/environment/lava-955742/=
bin/lava-test-runner /lava-955742/1
    2023-05-21T09:06:20.321640  =

    2023-05-21T09:06:20.324390  / # /lava-955742/bin/lava-test-runner /lava=
-955742/1 =

    ... (12 line(s) more)  =

 =



platform               | arch  | lab             | compiler | defconfig    =
              | regressions
-----------------------+-------+-----------------+----------+--------------=
--------------+------------
imx6qp-wandboard-revd1 | arm   | lab-pengutronix | gcc-10   | multi_v7_defc=
onfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/6469dde80691045b202e866b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip33-11-gfea7994097935/arm/multi_v7_defconfig/gcc-10/lab-pengut=
ronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip33-11-gfea7994097935/arm/multi_v7_defconfig/gcc-10/lab-pengut=
ronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6469dde80691045b202e8670
        failing since 122 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-05-21T09:01:19.411962  + set[    7.210934] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 955741_1.5.2.3.1>
    2023-05-21T09:01:19.412117   +x
    2023-05-21T09:01:19.517850  / # #
    2023-05-21T09:01:19.619359  export SHELL=3D/bin/sh
    2023-05-21T09:01:19.619712  #
    2023-05-21T09:01:19.720880  / # export SHELL=3D/bin/sh. /lava-955741/en=
vironment
    2023-05-21T09:01:19.721389  =

    2023-05-21T09:01:19.822670  / # . /lava-955741/environment/lava-955741/=
bin/lava-test-runner /lava-955741/1
    2023-05-21T09:01:19.823331  =

    2023-05-21T09:01:19.825757  / # /lava-955741/bin/lava-test-runner /lava=
-955741/1 =

    ... (12 line(s) more)  =

 =



platform               | arch  | lab             | compiler | defconfig    =
              | regressions
-----------------------+-------+-----------------+----------+--------------=
--------------+------------
imx7ulp-evk            | arm   | lab-nxp         | gcc-10   | multi_v7_defc=
onfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/6469dec6647478f6272e85f6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip33-11-gfea7994097935/arm/multi_v7_defconfig/gcc-10/lab-nxp/ba=
seline-imx7ulp-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip33-11-gfea7994097935/arm/multi_v7_defconfig/gcc-10/lab-nxp/ba=
seline-imx7ulp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6469dec6647478f6272e85f9
        failing since 59 days (last pass: v5.10.145-rt74-1329-ga59fc50f38f6=
, first fail: v5.10.175-cip29-rt12)

    2023-05-21T09:04:40.974421  + set +x<8>[   28.961456] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 1226148_1.5.2.4.1>
    2023-05-21T09:04:40.974745  =

    2023-05-21T09:04:41.083759  / # #
    2023-05-21T09:04:42.244075  export SHELL=3D/bin/sh
    2023-05-21T09:04:42.249773  #
    2023-05-21T09:04:42.250090  / # export SHELL=3D/bin/sh
    2023-05-21T09:04:43.797958  / # . /lava-1226148/environment
    2023-05-21T09:04:46.626320  /lava-1226148/bin/lava-test-runner /lava-12=
26148/1
    2023-05-21T09:04:46.632509  . /lava-1226148/environment
    2023-05-21T09:04:46.632805  / # /lava-1226148/bin/lava-test-runner /lav=
a-1226148/1 =

    ... (12 line(s) more)  =

 =



platform               | arch  | lab             | compiler | defconfig    =
              | regressions
-----------------------+-------+-----------------+----------+--------------=
--------------+------------
r8a7743-iwg20d-q7      | arm   | lab-cip         | gcc-10   | shmobile_defc=
onfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/6469dd4ef9dbc189e72e860f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip33-11-gfea7994097935/arm/shmobile_defconfig/gcc-10/lab-cip/ba=
seline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip33-11-gfea7994097935/arm/shmobile_defconfig/gcc-10/lab-cip/ba=
seline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6469dd4ef9dbc189e72e8=
610
        failing since 2 days (last pass: v5.10.179-cip32-4-g580ea5dd85ae, f=
irst fail: v5.10.179-cip32-471-g18129e1b68691) =

 =



platform               | arch  | lab             | compiler | defconfig    =
              | regressions
-----------------------+-------+-----------------+----------+--------------=
--------------+------------
rk3399-gru-kevin       | arm64 | lab-collabora   | gcc-10   | defconfig+arm=
64-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6469e3ec6c6effc6982e864a

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip33-11-gfea7994097935/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip33-11-gfea7994097935/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/6469e3ec6c6effc6982e8650
        failing since 59 days (last pass: v5.10.168-cip27-456-g42a59c4e5329=
, first fail: v4.19.277-cip94-1098-g26d9f86d942d)

    2023-05-21T09:27:04.965628  /lava-10402839/1/../bin/lava-test-case

    2023-05-21T09:27:04.974616  <8>[   33.418978] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/6469e3ec6c6effc6982e8651
        failing since 59 days (last pass: v5.10.168-cip27-456-g42a59c4e5329=
, first fail: v4.19.277-cip94-1098-g26d9f86d942d)

    2023-05-21T09:27:03.929069  /lava-10402839/1/../bin/lava-test-case

    2023-05-21T09:27:03.939930  <8>[   32.384255] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform               | arch  | lab             | compiler | defconfig    =
              | regressions
-----------------------+-------+-----------------+----------+--------------=
--------------+------------
zynqmp-zcu102          | arm64 | lab-cip         | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/6469de2e7ff01a9f852e8659

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip33-11-gfea7994097935/arm64/defconfig/gcc-10/lab-cip/baseline-=
zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip33-11-gfea7994097935/arm64/defconfig/gcc-10/lab-cip/baseline-=
zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6469de2e7ff01a9f852e8=
65a
        failing since 59 days (last pass: v4.19.277-cip94-1098-g26d9f86d942=
d, first fail: v5.10.175-cip29-rt12) =

 =



platform               | arch  | lab             | compiler | defconfig    =
              | regressions
-----------------------+-------+-----------------+----------+--------------=
--------------+------------
zynqmp-zcu102          | arm64 | lab-cip         | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6469e4be739b91e74e2e8635

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip33-11-gfea7994097935/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip33-11-gfea7994097935/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6469e4be739b91e74e2e8=
636
        failing since 59 days (last pass: v4.19.277-cip94-1098-g26d9f86d942=
d, first fail: v5.10.175-cip29-rt12) =

 =20

