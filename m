Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0FEC7EE23
	for <webhook@archiver.kernel.org>; Thu, 18 May 2023 11:46:36 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web10.15001.1684410389512823157
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 18 May 2023 04:46:29 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=YpDKblzc;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.171, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1ae6b4c5a53so3545715ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 18 May 2023 04:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684410388; x=1687002388;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=17cl8A+NVjm+PmWv4WRevJOhhuxld4U3f8IZzLT7nwg=;
        b=YpDKblzcBlPoS6xXSJQrXF9y9XZonm9nLx/haBUTCjS7G7YeoetuUvjvq+Fy0U43MB
         J5QN0EfEaG6QnTlmyOmA94MjkFdfCsEhXbRwzUOkw5ITF58eJ5Li1QvUfR9PAYk089TN
         A0d8YmUJHEdItvJ6Y9RrFzICo6MfJgrCg4ZDxbNsUx4bNXhwgKByFFUZZRtvlBq67TrX
         S5fvXpta80zTysttRz6OY/DqiY5or5fYneHirwyWPZzGsFt9cIxwOLkrQ8g7Fn2x845m
         zzNhA4wTdm03kuWrc+uhY03NOMFpID1AC7pC/caf0dXnlBK/BikdPKZCvkdaohQgGQLV
         s5VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684410388; x=1687002388;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=17cl8A+NVjm+PmWv4WRevJOhhuxld4U3f8IZzLT7nwg=;
        b=bbQeRQxCzAKyCjPwzfrlbTlaYPwljoC4bAU1J5Gog3fAFxWhnMAjZcPcgdgzkLDt5E
         q7EaJvrS5p2xxjgqTalWIQRrm29byffZpBMg6hIeoQCstejG6uYjt3y8rj2xIZ1VCkVR
         Prgch0SxEUbFdKNhxBPQ8dvdovOfQ+ItX5MDOOA0UYqWhpgmDSWyyZ3Be7FeHZbOsTVv
         vYxDmwBnpNKX8JtpOE4VQsC1tAjvD1p7qfbHXJjOmM17MIqoA1arnHopIdQbWXOP3uHc
         cyUFwIqfMZGL03Cv785e351X19LTMAjX41/M9QrBZnuy3S/EY48Ey9kUGX7vNkBrcsop
         I++w==
X-Gm-Message-State: AC+VfDzBpdqyaDRI71i/mpZwItHGS2ZQ68rVjtBXXfOxvHzuCtq3C4hg
	zY3+upWPuvSJMH/ld5fpd0tLqlwbynYe0N6MOzu5dw==
X-Google-Smtp-Source: ACHHUZ5Hd4xiZjw8uwLv5ai5HeNpLj1EImPp8lpkojKJJ71QYTcVO6f9SN/sRv5ob4qzizoDqasH/g==
X-Received: by 2002:a17:902:c410:b0:1ae:6349:559 with SMTP id k16-20020a170902c41000b001ae63490559mr3462328plk.24.1684410388097;
        Thu, 18 May 2023 04:46:28 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id l14-20020a170903120e00b001ae4edac77bsm1194033plh.275.2023.05.18.04.46.27
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 04:46:27 -0700 (PDT)
Message-ID: <64661013.170a0220.34efa.1a4b@mx.google.com>
Date: Thu, 18 May 2023 04:46:27 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.179-cip32-471-g18129e1b68691
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline: 109 runs,
 15 regressions (v5.10.179-cip32-471-g18129e1b68691)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 May 2023 11:46:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11515

cip-gitlab/ci/pavel/linux-test baseline: 109 runs, 15 regressions (v5.10.17=
9-cip32-471-g18129e1b68691)

Regressions Summary
-------------------

platform                     | arch  | lab             | compiler | defconf=
ig                  | regressions
-----------------------------+-------+-----------------+----------+--------=
--------------------+------------
bcm2836-rpi-2-b              | arm   | lab-collabora   | gcc-10   | multi_v=
7_defconfig         | 1          =

fsl-ls1088a-rdb              | arm64 | lab-nxp         | gcc-10   | defconf=
ig                  | 1          =

imx6qp-wandboard-revd1       | arm   | lab-pengutronix | gcc-10   | imx_v6_=
v7_defconfig        | 1          =

imx6qp-wandboard-revd1       | arm   | lab-pengutronix | gcc-10   | multi_v=
7_defconfig         | 1          =

imx7ulp-evk                  | arm   | lab-nxp         | gcc-10   | multi_v=
7_defconfig         | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie     | gcc-10   | defconf=
ig+arm64-chromebook | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie     | gcc-10   | defconf=
ig                  | 1          =

r8a7743-iwg20d-q7            | arm   | lab-cip         | gcc-10   | shmobil=
e_defconfig         | 1          =

rk3288-veyron-jaq            | arm   | lab-collabora   | gcc-10   | multi_v=
7_defconfig         | 3          =

rk3399-gru-kevin             | arm64 | lab-collabora   | gcc-10   | defconf=
ig+arm64-chromebook | 2          =

zynqmp-zcu102                | arm64 | lab-cip         | gcc-10   | defconf=
ig+arm64-chromebook | 1          =

zynqmp-zcu102                | arm64 | lab-cip         | gcc-10   | defconf=
ig                  | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.179-cip32-471-g18129e1b68691/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.179-cip32-471-g18129e1b68691
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      18129e1b6869127ae39e5978bb2fe70ecd53f174 =



Test Regressions
---------------- =



platform                     | arch  | lab             | compiler | defconf=
ig                  | regressions
-----------------------------+-------+-----------------+----------+--------=
--------------------+------------
bcm2836-rpi-2-b              | arm   | lab-collabora   | gcc-10   | multi_v=
7_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/646607a12587d99a472e8603

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-471-g18129e1b68691/arm/multi_v7_defconfig/gcc-10/lab-colla=
bora/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-471-g18129e1b68691/arm/multi_v7_defconfig/gcc-10/lab-colla=
bora/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/646607a12587d99a472e8=
604
        failing since 56 days (last pass: v4.19.277-cip94-1098-g26d9f86d942=
d, first fail: v5.10.175-cip29-rt12) =

 =



platform                     | arch  | lab             | compiler | defconf=
ig                  | regressions
-----------------------------+-------+-----------------+----------+--------=
--------------------+------------
fsl-ls1088a-rdb              | arm64 | lab-nxp         | gcc-10   | defconf=
ig                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64660a6dac6350eeac2e860c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-471-g18129e1b68691/arm64/defconfig/gcc-10/lab-nxp/baseline=
-fsl-ls1088a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-471-g18129e1b68691/arm64/defconfig/gcc-10/lab-nxp/baseline=
-fsl-ls1088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64660a6dac6350eeac2e860f
        failing since 56 days (last pass: v4.19.277-cip94-1098-g26d9f86d942=
d, first fail: v5.10.175-cip29-rt12)

    2023-05-18T11:19:04.513694  R EXIT>
    2023-05-18T11:20:05.136158  / # #
    2023-05-18T11:20:05.238152  export SHELL=3D/bin/sh
    2023-05-18T11:20:05.238654  #
    2023-05-18T11:20:05.340028  / # export SHELL=3D/bin/sh. /lava-1224339/e=
nvironment
    2023-05-18T11:20:05.340490  =

    2023-05-18T11:20:05.441886  / # . /lava-1224339/environment/lava-122433=
9/bin/lava-test-runner /lava-1224339/0
    2023-05-18T11:20:05.442665  =

    2023-05-18T11:20:05.444629  / # /lava-1224339/bin/lava-test-runner /lav=
a-1224339/0
    2023-05-18T11:20:05.460031  mv: can't rename '/lava-1224339/0/lava-test=
-runner.conf': No such file or directory =

    ... (23 line(s) more)  =

 =



platform                     | arch  | lab             | compiler | defconf=
ig                  | regressions
-----------------------------+-------+-----------------+----------+--------=
--------------------+------------
imx6qp-wandboard-revd1       | arm   | lab-pengutronix | gcc-10   | imx_v6_=
v7_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/6466080adbc1fac5a02e8604

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-471-g18129e1b68691/arm/imx_v6_v7_defconfig/gcc-10/lab-peng=
utronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-471-g18129e1b68691/arm/imx_v6_v7_defconfig/gcc-10/lab-peng=
utronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6466080adbc1fac5a02e8609
        failing since 119 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-05-18T11:12:02.824813  + set +x
    2023-05-18T11:12:02.938839  [    8.916529] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines#
    2023-05-18T11:12:02.939471   MEASUREMENT=3D0>
    2023-05-18T11:12:02.939601  [    8.919053] <LAVA_SIGNAL_ENDRUN 0_dmesg =
953728_1.5.2.3.1>
    2023-05-18T11:12:03.040967  / # #export SHELL=3D/bin/sh
    2023-05-18T11:12:03.041401  =

    2023-05-18T11:12:03.142609  / # export SHELL=3D/bin/sh. /lava-953728/en=
vironment
    2023-05-18T11:12:03.143038  =

    2023-05-18T11:12:03.244268  / # . /lava-953728/environment/lava-953728/=
bin/lava-test-runner /lava-953728/1
    2023-05-18T11:12:03.244825   =

    ... (13 line(s) more)  =

 =



platform                     | arch  | lab             | compiler | defconf=
ig                  | regressions
-----------------------------+-------+-----------------+----------+--------=
--------------------+------------
imx6qp-wandboard-revd1       | arm   | lab-pengutronix | gcc-10   | multi_v=
7_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/646606783d4348b1642e85e6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-471-g18129e1b68691/arm/multi_v7_defconfig/gcc-10/lab-pengu=
tronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-471-g18129e1b68691/arm/multi_v7_defconfig/gcc-10/lab-pengu=
tronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646606783d4348b1642e85eb
        failing since 119 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-05-18T11:05:20.971010  [    7.106929] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-05-18T11:05:20.971200  [    7.108243] <LAVA_SIGNAL_ENDRUN 0_dmesg =
953722_1.5.2.3.1>
    2023-05-18T11:05:21.074740  / # #
    2023-05-18T11:05:21.176477  export SHELL=3D/bin/sh
    2023-05-18T11:05:21.176972  #
    2023-05-18T11:05:21.278185  / # export SHELL=3D/bin/sh. /lava-953722/en=
vironment
    2023-05-18T11:05:21.278696  =

    2023-05-18T11:05:21.380070  / # . /lava-953722/environment/lava-953722/=
bin/lava-test-runner /lava-953722/1
    2023-05-18T11:05:21.380767  =

    2023-05-18T11:05:21.383192  / # /lava-953722/bin/lava-test-runner /lava=
-953722/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch  | lab             | compiler | defconf=
ig                  | regressions
-----------------------------+-------+-----------------+----------+--------=
--------------------+------------
imx7ulp-evk                  | arm   | lab-nxp         | gcc-10   | multi_v=
7_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/646607107e4f0973102e85e7

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-471-g18129e1b68691/arm/multi_v7_defconfig/gcc-10/lab-nxp/b=
aseline-imx7ulp-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-471-g18129e1b68691/arm/multi_v7_defconfig/gcc-10/lab-nxp/b=
aseline-imx7ulp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646607107e4f0973102e85ea
        failing since 56 days (last pass: v5.10.145-rt74-1329-ga59fc50f38f6=
, first fail: v5.10.175-cip29-rt12)

    2023-05-18T11:06:47.547985  + set +x
    2023-05-18T11:06:47.670230  / #
    2023-05-18T11:06:47.671011  # <8>[   29.112297] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 1224331_1.5.2.4.1>
    2023-05-18T11:06:48.831129  #export SHELL=3D/bin/sh
    2023-05-18T11:06:48.836797  =

    2023-05-18T11:06:48.837087  / # export SHELL=3D/bin/sh
    2023-05-18T11:06:50.384893  / # . /lava-1224331/environment
    2023-05-18T11:06:53.211151  /lava-1224331/bin/lava-test-runner /lava-12=
24331/1
    2023-05-18T11:06:53.216749  . /lava-1224331/environment
    2023-05-18T11:06:53.216872  / # /lava-1224331/bin/lava-test-runner /lav=
a-1224331/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch  | lab             | compiler | defconf=
ig                  | regressions
-----------------------------+-------+-----------------+----------+--------=
--------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie     | gcc-10   | defconf=
ig+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6466078f1f3da59dfe2e8646

  Results:     49 PASS, 4 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-471-g18129e1b68691/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-broonie/baseline-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-471-g18129e1b68691/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-broonie/baseline-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.cpufreq-probed: https://kernelci.org/test/case/id/64660=
78f1f3da59dfe2e8669
        new failure (last pass: v5.10.179-cip32-4-g580ea5dd85ae)

    2023-05-18T11:09:54.916002  /lava-480100/1/../bin/lava-test-case
    2023-05-18T11:09:54.929492  <8>[   17.508531] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpufreq-probed RESULT=3Dfail>
    2023-05-18T11:09:54.929953  /lava-480100/1/../bin/lava-test-case   =

 =



platform                     | arch  | lab             | compiler | defconf=
ig                  | regressions
-----------------------------+-------+-----------------+----------+--------=
--------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie     | gcc-10   | defconf=
ig                  | 1          =


  Details:     https://kernelci.org/test/plan/id/646609e5c07ba0d5ee2e85fb

  Results:     50 PASS, 4 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-471-g18129e1b68691/arm64/defconfig/gcc-10/lab-broonie/base=
line-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-471-g18129e1b68691/arm64/defconfig/gcc-10/lab-broonie/base=
line-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.cpufreq-probed: https://kernelci.org/test/case/id/64660=
9e5c07ba0d5ee2e861f
        new failure (last pass: v5.10.179-cip32-4-g580ea5dd85ae)

    2023-05-18T11:19:55.225982  /lava-480134/1/../bin/lava-test-case
    2023-05-18T11:19:55.238065  <8>[   17.613384] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpufreq-probed RESULT=3Dfail>
    2023-05-18T11:19:55.238585  /lava-480134/1/../bin/lava-test-case   =

 =



platform                     | arch  | lab             | compiler | defconf=
ig                  | regressions
-----------------------------+-------+-----------------+----------+--------=
--------------------+------------
r8a7743-iwg20d-q7            | arm   | lab-cip         | gcc-10   | shmobil=
e_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/646605a0fbe51903222e8605

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-471-g18129e1b68691/arm/shmobile_defconfig/gcc-10/lab-cip/b=
aseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-471-g18129e1b68691/arm/shmobile_defconfig/gcc-10/lab-cip/b=
aseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/646605a0fbe51903222e8=
606
        new failure (last pass: v5.10.179-cip32-4-g580ea5dd85ae) =

 =



platform                     | arch  | lab             | compiler | defconf=
ig                  | regressions
-----------------------------+-------+-----------------+----------+--------=
--------------------+------------
rk3288-veyron-jaq            | arm   | lab-collabora   | gcc-10   | multi_v=
7_defconfig         | 3          =


  Details:     https://kernelci.org/test/plan/id/6466069d3d4348b1642e8606

  Results:     61 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-471-g18129e1b68691/arm/multi_v7_defconfig/gcc-10/lab-colla=
bora/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-471-g18129e1b68691/arm/multi_v7_defconfig/gcc-10/lab-colla=
bora/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwmmc_rockchip-sdmmc-probed: https://kernelci.org/test/=
case/id/6466069d3d4348b1642e8632
        failing since 26 days (last pass: v4.4-st20-1100-ga8cadce4b9649, fi=
rst fail: v5.10.177-cip31-33-gd59f246891e73)

    2023-05-18T11:05:57.557006  Busy<8>[   21.515322] <LAVA_SIGNAL_TESTCASE=
 TEST_CASE_ID=3Ddwmmc_rockchip-driver-present RESULT=3Dpass>

    2023-05-18T11:05:57.562103  Box v1.31.1 (2023-05-12 17:02:46 UTC) multi=
-call binary.

    2023-05-18T11:05:57.562375  =


    2023-05-18T11:05:57.566895  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-05-18T11:05:57.566968  =


    2023-05-18T11:05:57.571861  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-05-18T11:05:57.574453  FIRST, INC default to 1.

    2023-05-18T11:05:57.574711  =


    2023-05-18T11:05:57.578128  	-w	Pad to last with leading zeros

    2023-05-18T11:05:57.580860  	-s SEP	String separator
 =

    ... (14 line(s) more)  =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/6466069d3d4348b1642e8635
        failing since 117 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-05-18T11:05:57.509038  ST

    2023-05-18T11:05:57.509257  =


    2023-05-18T11:05:57.514334  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/6466069d3d4348b1642e8636
        failing since 117 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-05-18T11:05:57.494540   multi-call binary.

    2023-05-18T11:05:57.494592  =


    2023-05-18T11:05:57.508473  Usage: seq [-w] [-s SEP] [FIRST [INC]] LA<8=
>[   21.470166] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>
   =

 =



platform                     | arch  | lab             | compiler | defconf=
ig                  | regressions
-----------------------------+-------+-----------------+----------+--------=
--------------------+------------
rk3399-gru-kevin             | arm64 | lab-collabora   | gcc-10   | defconf=
ig+arm64-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6466077c1f3da59dfe2e85e7

  Results:     83 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-471-g18129e1b68691/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-471-g18129e1b68691/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/6466077c1f3da59dfe2e85ed
        failing since 57 days (last pass: v5.10.168-cip27-456-g42a59c4e5329=
, first fail: v4.19.277-cip94-1098-g26d9f86d942d)

    2023-05-18T11:09:34.835971  /lava-10371777/1/../bin/lava-test-case

    2023-05-18T11:09:34.850002  <8>[   33.186586] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/6466077c1f3da59dfe2e85ee
        failing since 57 days (last pass: v5.10.168-cip27-456-g42a59c4e5329=
, first fail: v4.19.277-cip94-1098-g26d9f86d942d)

    2023-05-18T11:09:33.817246  /lava-10371777/1/../bin/lava-test-case

    2023-05-18T11:09:33.830672  <8>[   32.167523] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch  | lab             | compiler | defconf=
ig                  | regressions
-----------------------------+-------+-----------------+----------+--------=
--------------------+------------
zynqmp-zcu102                | arm64 | lab-cip         | gcc-10   | defconf=
ig+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64660878f81c2544f22e85f0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-471-g18129e1b68691/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-471-g18129e1b68691/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64660878f81c2544f22e8=
5f1
        failing since 56 days (last pass: v4.19.277-cip94-1098-g26d9f86d942=
d, first fail: v5.10.175-cip29-rt12) =

 =



platform                     | arch  | lab             | compiler | defconf=
ig                  | regressions
-----------------------------+-------+-----------------+----------+--------=
--------------------+------------
zynqmp-zcu102                | arm64 | lab-cip         | gcc-10   | defconf=
ig                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64660a6c4944ebfb312e85ff

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-471-g18129e1b68691/arm64/defconfig/gcc-10/lab-cip/baseline=
-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-471-g18129e1b68691/arm64/defconfig/gcc-10/lab-cip/baseline=
-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64660a6c4944ebfb312e8=
600
        failing since 56 days (last pass: v4.19.277-cip94-1098-g26d9f86d942=
d, first fail: v5.10.175-cip29-rt12) =

 =20

