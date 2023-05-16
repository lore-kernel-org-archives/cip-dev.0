Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0982C77B75
	for <webhook@archiver.kernel.org>; Tue, 16 May 2023 18:27:54 +0000 (UTC)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
 by mx.groups.io with SMTP id smtpd.web11.29584.1684261671167219004
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 16 May 2023 11:27:51 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=Zweq90p4;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.177, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-643990c5319so10502106b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 16 May 2023 11:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684261670; x=1686853670;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KWV6rTkDm749YtH+ZtIpPaK68tSbBN8ZaNZVcWMn0YE=;
        b=Zweq90p4bIivExMGX5CO1eC3AMtTeglG2hueN8Mt/6bmijKZKpf1mNpBYOFAHiWiOd
         CkW0V7uM1bRHO4O6fNxt6nJx8uB7EYqXX6Af/HO2+JDdSj2PO2sKHl75/eJTVrw5ajhT
         yQbxbG3h7ArxgOOa6mhveGuI8XJ5jWr3qs7L9fvilohtGOx6gg8HMJdIfBwe9L/ynWqX
         B6lvcof4mjinHPdf19ysW7WnRMfzx5HHCchOBbRPHzrj6JkAOXxctPqB7aXkm8d1htxe
         0WWGOe1jQN8+IvEN7tO5iht1YUB6JGNAAE/sOea8EeKbFgjzunCJPAxEfYMhwMMZfBvV
         tMlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684261670; x=1686853670;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KWV6rTkDm749YtH+ZtIpPaK68tSbBN8ZaNZVcWMn0YE=;
        b=fyLEIKhADZBp8A/9tEU70YlVWZm5FsYMJU8e+MI8sYnTNpPLiuon5+h/CRlEwh4R/c
         EytxgkumF1UtoaFWvrEFbHFQKIguiuzrQCQYnxlIoEh5bskTYNceg9bDN4x4YhpbNBF1
         8xLAHmUdAdan7IO6ifQoejYIzGnrc6DocWjmLrDPlHqHbxHWIskwl/rOmhE1DdUXL0af
         eHd4nSCGwfRfXXzJF4hMwd6RHhg6Zq3alJkagU7IuN3NV+XKqyfju+By8RZa1AITlC7T
         H45fXZaC70MMHY+xruWvJwoUTCFjCbklqA0R94z6h8bOlFki01pezzOj3MDMZOpQqa+p
         LSkw==
X-Gm-Message-State: AC+VfDwMLBQhX7GKPLnbmYqaBahYrDjTRIM9hMs4qQazFrNK4yt2j43q
	TIaIpFxd690ohE5yxYpzaUFvVZM8gwO+89GgypXaLg==
X-Google-Smtp-Source: ACHHUZ5wUgbGmVw0cdl4mhjJndjVswPduYlmtr+wzeN2fb/DOdcgflaE8wEaj7WLiIcLuHYKXZed5w==
X-Received: by 2002:a05:6a00:218a:b0:640:defd:a6d5 with SMTP id h10-20020a056a00218a00b00640defda6d5mr45082721pfi.12.1684261669412;
        Tue, 16 May 2023 11:27:49 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 3-20020aa79203000000b00627f054a3cdsm13754829pfo.31.2023.05.16.11.27.48
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 11:27:48 -0700 (PDT)
Message-ID: <6463cb24.a70a0220.80c6a.ac54@mx.google.com>
Date: Tue, 16 May 2023 11:27:48 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.179-cip32-4-g580ea5dd85ae
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline: 108 runs,
 13 regressions (v5.10.179-cip32-4-g580ea5dd85ae)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 May 2023 18:27:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11472

cip-gitlab/ci/pavel/linux-test baseline: 108 runs, 13 regressions (v5.10.17=
9-cip32-4-g580ea5dd85ae)

Regressions Summary
-------------------

platform               | arch  | lab             | compiler | defconfig    =
              | regressions
-----------------------+-------+-----------------+----------+--------------=
--------------+------------
bcm2836-rpi-2-b        | arm   | lab-collabora   | gcc-10   | multi_v7_defc=
onfig         | 1          =

fsl-lx2160a-rdb        | arm64 | lab-nxp         | gcc-10   | defconfig    =
              | 1          =

imx6qp-wandboard-revd1 | arm   | lab-pengutronix | gcc-10   | imx_v6_v7_def=
config        | 1          =

imx6qp-wandboard-revd1 | arm   | lab-pengutronix | gcc-10   | multi_v7_defc=
onfig         | 1          =

imx7ulp-evk            | arm   | lab-nxp         | gcc-10   | multi_v7_defc=
onfig         | 1          =

r8a774c0-ek874         | arm64 | lab-cip         | gcc-10   | defconfig+arm=
64-chromebook | 1          =

rk3288-veyron-jaq      | arm   | lab-collabora   | gcc-10   | multi_v7_defc=
onfig         | 3          =

rk3399-gru-kevin       | arm64 | lab-collabora   | gcc-10   | defconfig+arm=
64-chromebook | 2          =

zynqmp-zcu102          | arm64 | lab-cip         | gcc-10   | defconfig+arm=
64-chromebook | 1          =

zynqmp-zcu102          | arm64 | lab-cip         | gcc-10   | defconfig    =
              | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.179-cip32-4-g580ea5dd85ae/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.179-cip32-4-g580ea5dd85ae
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      580ea5dd85ae9165b28861c2f5ab8bf05a13ecc3 =



Test Regressions
---------------- =



platform               | arch  | lab             | compiler | defconfig    =
              | regressions
-----------------------+-------+-----------------+----------+--------------=
--------------+------------
bcm2836-rpi-2-b        | arm   | lab-collabora   | gcc-10   | multi_v7_defc=
onfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/6463c3f9506dd0f8362e85e9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-4-g580ea5dd85ae/arm/multi_v7_defconfig/gcc-10/lab-collabor=
a/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-4-g580ea5dd85ae/arm/multi_v7_defconfig/gcc-10/lab-collabor=
a/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6463c3f9506dd0f8362e8=
5ea
        failing since 55 days (last pass: v4.19.277-cip94-1098-g26d9f86d942=
d, first fail: v5.10.175-cip29-rt12) =

 =



platform               | arch  | lab             | compiler | defconfig    =
              | regressions
-----------------------+-------+-----------------+----------+--------------=
--------------+------------
fsl-lx2160a-rdb        | arm64 | lab-nxp         | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/6463c501fbbc54e9c62e862a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-4-g580ea5dd85ae/arm64/defconfig/gcc-10/lab-nxp/baseline-fs=
l-lx2160a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-4-g580ea5dd85ae/arm64/defconfig/gcc-10/lab-nxp/baseline-fs=
l-lx2160a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6463c501fbbc54e9c62e862d
        failing since 25 days (last pass: v5.10.145-rt74-1329-ga59fc50f38f6=
, first fail: v5.10.177-cip31-33-gd59f246891e73)

    2023-05-16T18:01:14.472815  [   19.705023] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1222465_1.5.2.4.1>
    2023-05-16T18:01:14.578556  / # #
    2023-05-16T18:01:14.680381  export SHELL=3D/bin/sh
    2023-05-16T18:01:14.680949  #
    2023-05-16T18:01:14.782314  / # export SHELL=3D/bin/sh. /lava-1222465/e=
nvironment
    2023-05-16T18:01:14.782776  =

    2023-05-16T18:01:14.884166  / # . /lava-1222465/environment/lava-122246=
5/bin/lava-test-runner /lava-1222465/1
    2023-05-16T18:01:14.884889  =

    2023-05-16T18:01:14.886747  / # /lava-1222465/bin/lava-test-runner /lav=
a-1222465/1
    2023-05-16T18:01:14.903611  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform               | arch  | lab             | compiler | defconfig    =
              | regressions
-----------------------+-------+-----------------+----------+--------------=
--------------+------------
imx6qp-wandboard-revd1 | arm   | lab-pengutronix | gcc-10   | imx_v6_v7_def=
config        | 1          =


  Details:     https://kernelci.org/test/plan/id/6463bf761d44fcb82d2e8657

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-4-g580ea5dd85ae/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutr=
onix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-4-g580ea5dd85ae/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutr=
onix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6463bf761d44fcb82d2e865c
        failing since 117 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-05-16T17:37:50.283486  + set +x
    2023-05-16T17:37:50.283662  [   10.367800] <LAVA_SIGNAL_ENDRUN 0_dmesg =
951677_1.5.2.3.1>
    2023-05-16T17:37:50.391210  / # #
    2023-05-16T17:37:50.492784  export SHELL=3D/bin/sh
    2023-05-16T17:37:50.493252  #
    2023-05-16T17:37:50.594480  / # export SHELL=3D/bin/sh. /lava-951677/en=
vironment
    2023-05-16T17:37:50.594935  =

    2023-05-16T17:37:50.696312  / # . /lava-951677/environment/lava-951677/=
bin/lava-test-runner /lava-951677/1
    2023-05-16T17:37:50.696870  =

    2023-05-16T17:37:50.699818  / # /lava-951677/bin/lava-test-runner /lava=
-951677/1 =

    ... (12 line(s) more)  =

 =



platform               | arch  | lab             | compiler | defconfig    =
              | regressions
-----------------------+-------+-----------------+----------+--------------=
--------------+------------
imx6qp-wandboard-revd1 | arm   | lab-pengutronix | gcc-10   | multi_v7_defc=
onfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/6463c2bf179565010b2e864e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-4-g580ea5dd85ae/arm/multi_v7_defconfig/gcc-10/lab-pengutro=
nix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-4-g580ea5dd85ae/arm/multi_v7_defconfig/gcc-10/lab-pengutro=
nix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6463c2bf179565010b2e8653
        failing since 117 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-05-16T17:51:51.409458  + set[    7.345266] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 951683_1.5.2.3.1>
    2023-05-16T17:51:51.409619   +x
    2023-05-16T17:51:51.515136  / # #
    2023-05-16T17:51:51.616599  export SHELL=3D/bin/sh
    2023-05-16T17:51:51.616992  #
    2023-05-16T17:51:51.718132  / # export SHELL=3D/bin/sh. /lava-951683/en=
vironment
    2023-05-16T17:51:51.718566  =

    2023-05-16T17:51:51.819768  / # . /lava-951683/environment/lava-951683/=
bin/lava-test-runner /lava-951683/1
    2023-05-16T17:51:51.820307  =

    2023-05-16T17:51:51.823215  / # /lava-951683/bin/lava-test-runner /lava=
-951683/1 =

    ... (12 line(s) more)  =

 =



platform               | arch  | lab             | compiler | defconfig    =
              | regressions
-----------------------+-------+-----------------+----------+--------------=
--------------+------------
imx7ulp-evk            | arm   | lab-nxp         | gcc-10   | multi_v7_defc=
onfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/6463c3ad085f89dde12e85f5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-4-g580ea5dd85ae/arm/multi_v7_defconfig/gcc-10/lab-nxp/base=
line-imx7ulp-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-4-g580ea5dd85ae/arm/multi_v7_defconfig/gcc-10/lab-nxp/base=
line-imx7ulp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6463c3ad085f89dde12e85f8
        failing since 55 days (last pass: v5.10.145-rt74-1329-ga59fc50f38f6=
, first fail: v5.10.175-cip29-rt12)

    2023-05-16T17:54:04.289687  + set +x
    2023-05-16T17:54:04.290826  <8>[   28.973784] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1222455_1.5.2.4.1>
    2023-05-16T17:54:04.399658  / # #
    2023-05-16T17:54:05.559972  export SHELL=3D/bin/sh
    2023-05-16T17:54:05.565662  #
    2023-05-16T17:54:05.565955  / # export SHELL=3D/bin/sh
    2023-05-16T17:54:07.113735  / # . /lava-1222455/environment
    2023-05-16T17:54:09.939222  /lava-1222455/bin/lava-test-runner /lava-12=
22455/1
    2023-05-16T17:54:09.944863  . /lava-1222455/environment
    2023-05-16T17:54:09.944995  / # /lava-1222455/bin/lava-test-runner /lav=
a-1222455/1 =

    ... (12 line(s) more)  =

 =



platform               | arch  | lab             | compiler | defconfig    =
              | regressions
-----------------------+-------+-----------------+----------+--------------=
--------------+------------
r8a774c0-ek874         | arm64 | lab-cip         | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6463c39244af6c44c32e8606

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-4-g580ea5dd85ae/arm64/defconfig+arm64-chromebook/gcc-10/la=
b-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-4-g580ea5dd85ae/arm64/defconfig+arm64-chromebook/gcc-10/la=
b-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6463c39244af6c44c32e8=
607
        new failure (last pass: v5.10.177-cip31-33-gd59f246891e73) =

 =



platform               | arch  | lab             | compiler | defconfig    =
              | regressions
-----------------------+-------+-----------------+----------+--------------=
--------------+------------
rk3288-veyron-jaq      | arm   | lab-collabora   | gcc-10   | multi_v7_defc=
onfig         | 3          =


  Details:     https://kernelci.org/test/plan/id/6463c2e2e62bf813ac2e8603

  Results:     63 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-4-g580ea5dd85ae/arm/multi_v7_defconfig/gcc-10/lab-collabor=
a/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-4-g580ea5dd85ae/arm/multi_v7_defconfig/gcc-10/lab-collabor=
a/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwmmc_rockchip-sdmmc-probed: https://kernelci.org/test/=
case/id/6463c2e2e62bf813ac2e8630
        failing since 25 days (last pass: v4.4-st20-1100-ga8cadce4b9649, fi=
rst fail: v5.10.177-cip31-33-gd59f246891e73)

    2023-05-16T17:52:26.495925  RST to LAST, in steps of INC.

    2023-05-16T17:52:26.498363  FIRST, INC default to 1.

    2023-05-16T17:52:26.498755  =


    2023-05-16T17:52:26.502227  	-w	Pad to last with leading zeros

    2023-05-16T17:52:26.504718  	-s SEP	String separator

    2023-05-16T17:52:26.508805  /lava-10338917/1/../bin/lava-test-case

    2023-05-16T17:52:26.514632  BusyBox v1.31.1 (2023-05-12 17:02:46 UTC) m=
ulti-call binary.

    2023-05-16T17:52:26.514852  =


    2023-05-16T17:52:26.519150  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-05-16T17:52:26.519366  =

 =

    ... (9 line(s) more)  =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/6463c2e2e62bf813ac2e8633
        failing since 116 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-05-16T17:52:26.422949  BusyBox v1.31.1 (2023-05-12 17:02:46 UTC)<8=
>[   20.540109] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-05-16T17:52:26.424948   multi-call binary.

    2023-05-16T17:52:26.425273  =


    2023-05-16T17:52:26.429494  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-05-16T17:52:26.429716  =


    2023-05-16T17:52:26.434801  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/6463c2e2e62bf813ac2e8634
        failing since 116 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-05-16T17:52:26.403874  <8>[   20.522212] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>
   =

 =



platform               | arch  | lab             | compiler | defconfig    =
              | regressions
-----------------------+-------+-----------------+----------+--------------=
--------------+------------
rk3399-gru-kevin       | arm64 | lab-collabora   | gcc-10   | defconfig+arm=
64-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6463c235070e5b32772e8682

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-4-g580ea5dd85ae/arm64/defconfig+arm64-chromebook/gcc-10/la=
b-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-4-g580ea5dd85ae/arm64/defconfig+arm64-chromebook/gcc-10/la=
b-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/6463c235070e5b32772e8688
        failing since 55 days (last pass: v5.10.168-cip27-456-g42a59c4e5329=
, first fail: v4.19.277-cip94-1098-g26d9f86d942d)

    2023-05-16T17:49:30.575237  /lava-10338811/1/../bin/lava-test-case

    2023-05-16T17:49:30.586183  <8>[   33.050166] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/6463c235070e5b32772e8689
        failing since 55 days (last pass: v5.10.168-cip27-456-g42a59c4e5329=
, first fail: v4.19.277-cip94-1098-g26d9f86d942d)

    2023-05-16T17:49:29.539848  /lava-10338811/1/../bin/lava-test-case

    2023-05-16T17:49:29.551340  <8>[   32.014581] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform               | arch  | lab             | compiler | defconfig    =
              | regressions
-----------------------+-------+-----------------+----------+--------------=
--------------+------------
zynqmp-zcu102          | arm64 | lab-cip         | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6463c3405e415025662e8607

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-4-g580ea5dd85ae/arm64/defconfig+arm64-chromebook/gcc-10/la=
b-cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-4-g580ea5dd85ae/arm64/defconfig+arm64-chromebook/gcc-10/la=
b-cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6463c3405e415025662e8=
608
        failing since 55 days (last pass: v4.19.277-cip94-1098-g26d9f86d942=
d, first fail: v5.10.175-cip29-rt12) =

 =



platform               | arch  | lab             | compiler | defconfig    =
              | regressions
-----------------------+-------+-----------------+----------+--------------=
--------------+------------
zynqmp-zcu102          | arm64 | lab-cip         | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/6463c56f35b9991ab72e8639

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-4-g580ea5dd85ae/arm64/defconfig/gcc-10/lab-cip/baseline-zy=
nqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-4-g580ea5dd85ae/arm64/defconfig/gcc-10/lab-cip/baseline-zy=
nqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6463c56f35b9991ab72e8=
63a
        failing since 55 days (last pass: v4.19.277-cip94-1098-g26d9f86d942=
d, first fail: v5.10.175-cip29-rt12) =

 =20

