Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B477AC48260
	for <webhook@archiver.kernel.org>; Tue, 13 Feb 2024 19:16:06 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web10.22175.1707851756730925475
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 13 Feb 2024 11:15:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=zYv9XCTU;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.178, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d911c2103aso23655675ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 13 Feb 2024 11:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707851756; x=1708456556; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MLDs6xGvA2+3sypClbXrs7oJUxA0n8Tcvt+rYtVwWA0=;
        b=zYv9XCTUS0/ifTeCfY6+gS/nmtdpRFT2aWzqdAzfM2DlY6pXOhPIrh8KtO5W/GBO+G
         cvSwoGExmIR+i6OZdV1eg3gk/rVuq0zWX1zAzAdFL6b5LLvZKD7Y1BrKbEYwhjWRYlgp
         VnXlpNjwXOcUvaY7o+4lX0xEXzXaOifkADnvOI2CwwPk0YX/7KiIhqlRXa7SsyM+f9KU
         VD8HbqI8kqBTLv32qFZcDNniWS4KPeiT6xJE2DYHkZuTq5veK1NhvaWNeFUvHQXoMaeG
         v3Z+UD6aYYjG9IeKY12EYQDFvrIOQFcJ+67IUDXba0LLJ7J4kWJmT6DaBlimJmafewU+
         1E/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707851756; x=1708456556;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MLDs6xGvA2+3sypClbXrs7oJUxA0n8Tcvt+rYtVwWA0=;
        b=amRSamoddFutoxrxATku2Xs9qG4QkMywRS8gidhs4x+fTJaWLbFRK00FG+Y1xWD64M
         3fPa5Q21yoAH+65jleFARbAngX1R3rigDt+kgGvUNkRXqF2vHV7Z8lvyw4CprhfQCcE5
         ItsVRrgGW6ki0XmGg4ESSVn4InliynJXw6h92kqbann9yBg/KbGJil3hP0oDtCbcFew0
         3woQmoyj8OKE5TtVP/EqnK6sYGOZUfJOqGxoQEO41eNLqq5MV0kCx+4hQfffraRuzbKW
         1+ZYM00n47jdVzBEqD2Nz51cMKavzc2nsNwq6bcZc/s4IKqBJWoJQBi/c8sNU5rbfIgn
         nuYQ==
X-Gm-Message-State: AOJu0YwkngVeJ7NtZZCkiu4kvf52Zgb2skLBOkXMQZwAC3y9m/4IjvmX
	GyMhiV1LfN9a2x56OssYWspQ0KidxdjX5nL6puLfp16CYb36U4PUDyelYWFu4FNawwFSNQiq/V7
	xzYU=
X-Google-Smtp-Source: AGHT+IGk23rxIW0ZrLX5uuifgBvrwbDS1uRKj/pURN6zYJpHJBB6ug6JyiNJB90vFwPf1WWZOTMhjA==
X-Received: by 2002:a17:902:8206:b0:1db:4f01:bcc8 with SMTP id x6-20020a170902820600b001db4f01bcc8mr432977pln.54.1707851755483;
        Tue, 13 Feb 2024 11:15:55 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x20-20020a170902ea9400b001d987771271sm2405809plb.123.2024.02.13.11.15.53
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 11:15:54 -0800 (PST)
Message-ID: <65cbbfea.170a0220.61e50.8e43@mx.google.com>
Date: Tue, 13 Feb 2024 11:15:54 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v5.10.209-cip44-51-gdb99ac443b0da
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline: 101 runs,
 21 regressions (v5.10.209-cip44-51-gdb99ac443b0da)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Feb 2024 19:16:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14956

cip-gitlab/ci/pavel/linux-test baseline: 101 runs, 21 regressions (v5.10.20=
9-cip44-51-gdb99ac443b0da)

Regressions Summary
-------------------

platform                  | arch   | lab             | compiler | defconfig=
                  | regressions
--------------------------+--------+-----------------+----------+----------=
------------------+------------
acer-cbv514-1h-34uz-brya  | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fconfig+x86-board | 1          =

acer-chromebox-cxi5-brask | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fconfig+x86-board | 1          =

beaglebone-black          | arm    | lab-cip         | gcc-10   | multi_v7_=
defconfig         | 5          =

imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | imx_v6_v7=
_defconfig        | 1          =

imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | multi_v7_=
defconfig         | 1          =

kontron-kbox-a-230-ls     | arm64  | lab-kontron     | gcc-10   | defconfig=
                  | 3          =

qemu_mips-malta           | mips   | lab-broonie     | gcc-10   | malta_def=
config            | 1          =

qemu_mips-malta           | mips   | lab-collabora   | gcc-10   | malta_def=
config            | 1          =

r8a7743-iwg20d-q7         | arm    | lab-cip         | gcc-10   | shmobile_=
defconfig         | 1          =

rk3288-veyron-jaq         | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig         | 2          =

rk3399-gru-kevin          | arm64  | lab-collabora   | gcc-10   | defconfig=
+arm64-chromebook | 2          =

zynqmp-zcu102             | arm64  | lab-cip         | gcc-10   | defconfig=
+arm64-chromebook | 1          =

zynqmp-zcu102             | arm64  | lab-cip         | gcc-10   | defconfig=
                  | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.209-cip44-51-gdb99ac443b0da/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.209-cip44-51-gdb99ac443b0da
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      db99ac443b0da75f00a4fc49e0040ac5dfa47e72 =



Test Regressions
---------------- =



platform                  | arch   | lab             | compiler | defconfig=
                  | regressions
--------------------------+--------+-----------------+----------+----------=
------------------+------------
acer-cbv514-1h-34uz-brya  | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65cbb4ae924a2bdb3e63705f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-acer-cbv514-1h-34uz-brya.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-acer-cbv514-1h-34uz-brya.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65cbb4ae924a2bdb3e637=
060
        failing since 8 days (last pass: v6.1.75-cip14-132-g6e54756fbd6c2, =
first fail: v5.10.209-cip44-rebase) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                  | regressions
--------------------------+--------+-----------------+----------+----------=
------------------+------------
acer-chromebox-cxi5-brask | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65cbb4b93f44492f9e63702b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-acer-chromebox-cxi5-brask.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-acer-chromebox-cxi5-brask.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65cbb4b93f44492f9e637=
02c
        failing since 8 days (last pass: v6.1.75-cip14-6-ga817aa655908, fir=
st fail: v5.10.209-cip44-rebase) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                  | regressions
--------------------------+--------+-----------------+----------+----------=
------------------+------------
beaglebone-black          | arm    | lab-cip         | gcc-10   | multi_v7_=
defconfig         | 5          =


  Details:     https://kernelci.org/test/plan/id/65cbb6293719521b74637013

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/arm/multi_v7_defconfig/gcc-10/lab-cip/ba=
seline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/arm/multi_v7_defconfig/gcc-10/lab-cip/ba=
seline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.hdmi-audio: https://kernelci.org/test/case/id/65cbb6293=
719521b7463701a
        failing since 8 days (last pass: v6.1.75-cip14-6-ga817aa655908, fir=
st fail: v5.10.209-cip44-rebase)

    2024-02-13T18:33:57.137331  /lava-1092734/1/../bin/lava-test-case
    2024-02-13T18:33:57.170805  <8>[   41.999381] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-codec-driver-present: https://kernelci.org/test/ca=
se/id/65cbb6293719521b7463701d
        failing since 8 days (last pass: v6.1.75-cip14-6-ga817aa655908, fir=
st fail: v5.10.209-cip44-rebase)

    2024-02-13T18:33:53.906855  /lava-1092734/1/../bin/lava-test-case
    2024-02-13T18:33:53.941301  <8>[   38.769144] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2024-02-13T18:33:54.968176  /lava-1092734/1/../bin/lava-test-case
    2024-02-13T18:33:55.005314  <8>[   39.830273] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case/id/=
65cbb6293719521b7463701e
        failing since 8 days (last pass: v6.1.75-cip14-6-ga817aa655908, fir=
st fail: v5.10.209-cip44-rebase)

    2024-02-13T18:33:51.779691  /lava-1092734/1/../bin/lava-test-case
    2024-02-13T18:33:51.813772  <8>[   36.641360] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2024-02-13T18:33:52.840366  /lava-1092734/1/../bin/lava-test-case
    2024-02-13T18:33:52.879954  <8>[   37.707390] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline.bootrr.tda19988-driver-present: https://kernelci.org/test/case=
/id/65cbb6293719521b7463701f
        failing since 8 days (last pass: v6.1.75-cip14-6-ga817aa655908, fir=
st fail: v5.10.209-cip44-rebase)

    2024-02-13T18:33:49.651003  /lava-1092734/1/../bin/lava-test-case
    2024-02-13T18:33:49.689647  <8>[   34.517544] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2024-02-13T18:33:50.716323  /lava-1092734/1/../bin/lava-test-case
    2024-02-13T18:33:50.752632  <8>[   35.579714] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/65cbb6293719521b7463702b
        failing since 8 days (last pass: v6.1.75-cip14-6-ga817aa655908, fir=
st fail: v5.10.209-cip44-rebase)

    2024-02-13T18:33:37.721126  /lava-1092734/1/../bin/lava-test-case
    2024-02-13T18:33:37.755175  <8>[   22.581407] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =

 =



platform                  | arch   | lab             | compiler | defconfig=
                  | regressions
--------------------------+--------+-----------------+----------+----------=
------------------+------------
imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | imx_v6_v7=
_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/65cbb326d00007172763704e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/arm/imx_v6_v7_defconfig/gcc-10/lab-pengu=
tronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/arm/imx_v6_v7_defconfig/gcc-10/lab-pengu=
tronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65cbb326d000071727637057
        failing since 8 days (last pass: v6.1.75-cip14-6-ga817aa655908, fir=
st fail: v5.10.209-cip44-rebase)

    2024-02-13T18:21:18.997402  + set +x
    2024-02-13T18:21:18.997560  [   10.242477] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1024609_1.5.2.3.1>
    2024-02-13T18:21:19.104795  / # #
    2024-02-13T18:21:19.206242  export SHELL=3D/bin/sh
    2024-02-13T18:21:19.206788  #
    2024-02-13T18:21:19.307587  / # export SHELL=3D/bin/sh. /lava-1024609/e=
nvironment
    2024-02-13T18:21:19.308200  =

    2024-02-13T18:21:19.409035  / # . /lava-1024609/environment/lava-102460=
9/bin/lava-test-runner /lava-1024609/1
    2024-02-13T18:21:19.409673  =

    2024-02-13T18:21:19.412490  / # /lava-1024609/bin/lava-test-runner /lav=
a-1024609/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                  | regressions
--------------------------+--------+-----------------+----------+----------=
------------------+------------
imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65cbb5e22b3805a7f363702d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/arm/multi_v7_defconfig/gcc-10/lab-pengut=
ronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/arm/multi_v7_defconfig/gcc-10/lab-pengut=
ronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65cbb5e22b3805a7f3637036
        failing since 8 days (last pass: v6.1.75-cip14-6-ga817aa655908, fir=
st fail: v5.10.209-cip44-rebase)

    2024-02-13T18:32:58.630242  + set[    7.260990] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 1024612_1.5.2.3.1>
    2024-02-13T18:32:58.630514   +x
    2024-02-13T18:32:58.735846  / # #
    2024-02-13T18:32:58.837091  export SHELL=3D/bin/sh
    2024-02-13T18:32:58.837611  #
    2024-02-13T18:32:58.938420  / # export SHELL=3D/bin/sh. /lava-1024612/e=
nvironment
    2024-02-13T18:32:58.938883  =

    2024-02-13T18:32:59.039744  / # . /lava-1024612/environment/lava-102461=
2/bin/lava-test-runner /lava-1024612/1
    2024-02-13T18:32:59.040386  =

    2024-02-13T18:32:59.042828  / # /lava-1024612/bin/lava-test-runner /lav=
a-1024612/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                  | regressions
--------------------------+--------+-----------------+----------+----------=
------------------+------------
kontron-kbox-a-230-ls     | arm64  | lab-kontron     | gcc-10   | defconfig=
                  | 3          =


  Details:     https://kernelci.org/test/plan/id/65cbb35fb8a39ed78d63707f

  Results:     89 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-kontron-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-kontron-kbox-a-230-ls.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rcpm-driver-present: https://kernelci.org/test/case/id/=
65cbb35fb8a39ed78d6370c3
        failing since 8 days (last pass: v6.1.75-cip14-6-ga817aa655908, fir=
st fail: v5.10.209-cip44-rebase)

    2024-02-13T18:21:54.525533  /lava-429067/1/../bin/lava-test-case
    2024-02-13T18:21:54.528841  <8>[   15.444821] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.ftm-alarm-driver-present: https://kernelci.org/test/cas=
e/id/65cbb35fb8a39ed78d6370c4
        failing since 8 days (last pass: v6.1.75-cip14-6-ga817aa655908, fir=
st fail: v5.10.209-cip44-rebase)

    2024-02-13T18:21:55.537431  /lava-429067/1/../bin/lava-test-case
    2024-02-13T18:21:55.540605  <8>[   16.462362] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2024-02-13T18:21:56.560228  /lava-429067/1/../bin/lava-test-case   =


  * baseline.bootrr.layerscape-sfp-driver-present: https://kernelci.org/tes=
t/case/id/65cbb35fb8a39ed78d6370db
        failing since 8 days (last pass: v6.1.75-cip14-6-ga817aa655908, fir=
st fail: v5.10.209-cip44-rebase)

    2024-02-13T18:21:58.992800  /lava-429067/1/../bin/lava-test-case
    2024-02-13T18:21:58.996141  <8>[   19.912207] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =

 =



platform                  | arch   | lab             | compiler | defconfig=
                  | regressions
--------------------------+--------+-----------------+----------+----------=
------------------+------------
qemu_mips-malta           | mips   | lab-broonie     | gcc-10   | malta_def=
config            | 1          =


  Details:     https://kernelci.org/test/plan/id/65cbaed51712acbb42637043

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/mips/malta_defconfig/gcc-10/lab-broonie/=
baseline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/mips/malta_defconfig/gcc-10/lab-broonie/=
baseline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65cbaed51712acbb42637=
044
        failing since 8 days (last pass: v6.1.75-cip14-6-ga817aa655908, fir=
st fail: v5.10.209-cip44-rebase) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                  | regressions
--------------------------+--------+-----------------+----------+----------=
------------------+------------
qemu_mips-malta           | mips   | lab-collabora   | gcc-10   | malta_def=
config            | 1          =


  Details:     https://kernelci.org/test/plan/id/65cbaced845c2d5d8e63701d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/mips/malta_defconfig/gcc-10/lab-collabor=
a/baseline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/mips/malta_defconfig/gcc-10/lab-collabor=
a/baseline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65cbaced845c2d5d8e637=
01e
        failing since 8 days (last pass: v6.1.75-cip14-6-ga817aa655908, fir=
st fail: v5.10.209-cip44-rebase) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                  | regressions
--------------------------+--------+-----------------+----------+----------=
------------------+------------
r8a7743-iwg20d-q7         | arm    | lab-cip         | gcc-10   | shmobile_=
defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65cbac5048a79343ed637032

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/arm/shmobile_defconfig/gcc-10/lab-cip/ba=
seline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/arm/shmobile_defconfig/gcc-10/lab-cip/ba=
seline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65cbac5048a79343ed637=
033
        failing since 7 days (last pass: v5.10.209-cip44-rebase, first fail=
: v5.10.209-cip44-526-gbbb905888ca85) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                  | regressions
--------------------------+--------+-----------------+----------+----------=
------------------+------------
rk3288-veyron-jaq         | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig         | 2          =


  Details:     https://kernelci.org/test/plan/id/65cbb605416b2d1f9d637018

  Results:     63 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/arm/multi_v7_defconfig/gcc-10/lab-collab=
ora/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/arm/multi_v7_defconfig/gcc-10/lab-collab=
ora/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwmmc_rockchip-sdio0-probed: https://kernelci.org/test/=
case/id/65cbb605416b2d1f9d637048
        failing since 8 days (last pass: v6.1.75-cip14-6-ga817aa655908, fir=
st fail: v5.10.209-cip44-rebase)

    2024-02-13T18:41:07.353695  /lava-12758030/1/../bin/lava-test-case<8>[ =
  19.654156] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwmmc_rockchip-sdmmc-prob=
ed RESULT=3Dfail>

    2024-02-13T18:41:07.353753  =


    2024-02-13T18:41:08.365023  /lava-12758030/1/../bin/lava-test-case
   =


  * baseline.bootrr.dwmmc_rockchip-sdmmc-probed: https://kernelci.org/test/=
case/id/65cbb605416b2d1f9d637049
        new failure (last pass: v4.4.302-cip72-1251-g57b839f015944)

    2024-02-13T18:41:06.332843  	-w	Pad to last with lea<8>[   18.629271] <=
LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwmmc_rockchip-driver-present RESULT=3D=
pass>

    2024-02-13T18:41:06.333718  ding zeros

    2024-02-13T18:41:06.336339  	-s SEP	String separator

    2024-02-13T18:41:06.340045  /lava-12758030/1/../bin/lava-test-case

    2024-02-13T18:41:06.346051  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.

    2024-02-13T18:41:06.346580  =


    2024-02-13T18:41:06.351139  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2024-02-13T18:41:06.351197  =


    2024-02-13T18:41:06.355885  Print numbers from FIRST to LAST, in steps =
of INC.

    2024-02-13T18:41:06.358402  FIRST, INC default to 1.
 =

    ... (5 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                  | regressions
--------------------------+--------+-----------------+----------+----------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora   | gcc-10   | defconfig=
+arm64-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/65cbb35eb8a39ed78d637024

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/65cbb35eb8a39ed78d63702e
        failing since 8 days (last pass: v6.1.75-cip14-6-ga817aa655908, fir=
st fail: v5.10.209-cip44-rebase)

    2024-02-13T18:22:05.368556  /lava-12757892/1/../bin/lava-test-case

    2024-02-13T18:22:05.379250  <8>[   62.134738] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/65cbb35eb8a39ed78d63702f
        failing since 8 days (last pass: v6.1.75-cip14-6-ga817aa655908, fir=
st fail: v5.10.209-cip44-rebase)

    2024-02-13T18:22:03.309173  <8>[   60.062291] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2024-02-13T18:22:04.330459  /lava-12757892/1/../bin/lava-test-case

    2024-02-13T18:22:04.341408  <8>[   61.097064] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                  | arch   | lab             | compiler | defconfig=
                  | regressions
--------------------------+--------+-----------------+----------+----------=
------------------+------------
zynqmp-zcu102             | arm64  | lab-cip         | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65cbb3e5fb210f9e7a637034

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65cbb3e5fb210f9e7a637=
035
        failing since 8 days (last pass: v6.1.75-cip14-6-ga817aa655908, fir=
st fail: v5.10.209-cip44-rebase) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                  | regressions
--------------------------+--------+-----------------+----------+----------=
------------------+------------
zynqmp-zcu102             | arm64  | lab-cip         | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65cbb561c5eed138e6637037

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/arm64/defconfig/gcc-10/lab-cip/baseline-=
zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/arm64/defconfig/gcc-10/lab-cip/baseline-=
zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65cbb561c5eed138e6637=
038
        failing since 8 days (last pass: v6.1.75-cip14-6-ga817aa655908, fir=
st fail: v5.10.209-cip44-rebase) =

 =20

