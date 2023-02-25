Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB481C7EE2E
	for <webhook@archiver.kernel.org>; Sat, 25 Feb 2023 00:02:03 +0000 (UTC)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
 by mx.groups.io with SMTP id smtpd.web10.34250.1677283315696990071
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 24 Feb 2023 16:01:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=rCqXrW6S;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.175, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f175.google.com with SMTP id ay18so466469pfb.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 24 Feb 2023 16:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8eN86reYEkbm2pkMqFpIURxsI6eFFOuiGlNZYmQiYjw=;
        b=rCqXrW6SQbWX4SqQVKH+kJ8c24YtifowE8nN+bGrQz6uNAtMX7i0ddYcLwbQZEWpIH
         PsPoovw28EA05qwD56onkcj7orX3zkFn63VamWiqPb8rKmMlYtjzdGxx55xK843uFnOc
         EUnb+NeDsPyXoZ7qMjJBx3pgXXrY7chzQ1O+Fw1EdLaKkgk9RjpoEgPXC1FTb6hRHtew
         RMsYwHru7NZJPU24TfW78LuBBs/xYc31Nn3i5/qwcr/Ofv5IA3TjDTvQuaNgJ7DtNABx
         ipC1xHdp2ihYIKMy/5qerEBxOji1BZ/QS1bQN0HkT9qUFoecQ62RGD7OJnhYH+tz8ryd
         8+Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8eN86reYEkbm2pkMqFpIURxsI6eFFOuiGlNZYmQiYjw=;
        b=dF/gyclOSB76RllWNG5bTcL5wMXqWCYlsB3oANScuf3z8KtvhhBk2JumKTeu8V44cZ
         GV+CJqpSUtqA9sbSQbtuy1jqWSZSqN3LKQeM/c3UDFEUGu67vZ9sHfUzATclNN8bgwzW
         NSWsFuqkoRH9qGxpTJm9HDbcOYLflBBfqyCpb1o92kFwcOL1y/FTIBrk2JufnKha6jfP
         4WTsKgDHE2sW61cByApDrNf0hvAUHoMeONqD0R9E3ZW9w/Oqw/UEM1Q0s/GF4dCN7EkQ
         XIW2WVjlsF8MZv2spx3owH83bwga8zC6HyONOLU2pKIWrFbggQAaH5uzmlC3E4UTO7uf
         w7AA==
X-Gm-Message-State: AO0yUKWi4Ck7K/f33i07diNQRYsIGAPks93i7rWtb/hEupFMsE6j4f+v
	+C6qpCgchQZAcBtpLemf62bLbAFVY1nlF2Z57IhXHQ==
X-Google-Smtp-Source: AK7set/CfcbPpyhHdAhdeB3PBKx59dYZMZ13w7bMOD8biXI0XRZ9Ok1DM3OE8k20M4r1OZ3vHFCR9Q==
X-Received: by 2002:a62:546:0:b0:5e6:84d0:d0da with SMTP id 67-20020a620546000000b005e684d0d0damr1960644pff.26.1677283314213;
        Fri, 24 Feb 2023 16:01:54 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x27-20020aa793bb000000b005a8dd86018dsm115775pff.64.2023.02.24.16.01.53
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 16:01:53 -0800 (PST)
Message-ID: <63f94ff1.a70a0220.57867.0586@mx.google.com>
Date: Fri, 24 Feb 2023 16:01:53 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.168-cip27-456-g42a59c4e5329
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline: 97 runs,
 27 regressions (v5.10.168-cip27-456-g42a59c4e5329)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 25 Feb 2023 00:02:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10831

cip-gitlab/ci/pavel/linux-test baseline: 97 runs, 27 regressions (v5.10.168=
-cip27-456-g42a59c4e5329)

Regressions Summary
-------------------

platform               | arch   | lab             | compiler | defconfig   =
                 | regressions
-----------------------+--------+-----------------+----------+-------------=
-----------------+------------
bcm2836-rpi-2-b        | arm    | lab-collabora   | gcc-10   | multi_v7_def=
config           | 1          =

imx6dl-udoo            | arm    | lab-broonie     | gcc-10   | imx_v6_v7_de=
fconfig          | 1          =

imx6dl-udoo            | arm    | lab-broonie     | gcc-10   | multi_v7_def=
config           | 1          =

imx6q-udoo             | arm    | lab-broonie     | gcc-10   | imx_v6_v7_de=
fconfig          | 1          =

imx6q-udoo             | arm    | lab-broonie     | gcc-10   | multi_v7_def=
config           | 1          =

imx6qp-wandboard-revd1 | arm    | lab-pengutronix | gcc-10   | imx_v6_v7_de=
fconfig          | 1          =

imx6qp-wandboard-revd1 | arm    | lab-pengutronix | gcc-10   | multi_v7_def=
config           | 1          =

qemu_i386-uefi         | i386   | lab-broonie     | gcc-10   | i386_defconf=
ig               | 1          =

qemu_i386-uefi         | i386   | lab-collabora   | gcc-10   | i386_defconf=
ig               | 1          =

qemu_x86_64-uefi       | x86_64 | lab-broonie     | gcc-10   | x86_64_defco=
nfig             | 1          =

qemu_x86_64-uefi       | x86_64 | lab-broonie     | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =

qemu_x86_64-uefi       | x86_64 | lab-collabora   | gcc-10   | x86_64_defco=
nfig             | 1          =

qemu_x86_64-uefi-mixed | x86_64 | lab-broonie     | gcc-10   | x86_64_defco=
nfig             | 1          =

qemu_x86_64-uefi-mixed | x86_64 | lab-broonie     | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =

qemu_x86_64-uefi-mixed | x86_64 | lab-collabora   | gcc-10   | x86_64_defco=
nfig             | 1          =

r8a7743-iwg20d-q7      | arm    | lab-cip         | gcc-10   | shmobile_def=
config           | 1          =

rk3288-veyron-jaq      | arm    | lab-collabora   | gcc-10   | multi_v7_def=
config           | 3          =

rk3399-gru-kevin       | arm64  | lab-collabora   | gcc-10   | defconfig+ar=
m64-chromebook   | 4          =

rk3399-rock-pi-4b      | arm64  | lab-collabora   | gcc-10   | defconfig   =
                 | 1          =

sun50i-a64-pine64-plus | arm64  | lab-broonie     | gcc-10   | defconfig   =
                 | 1          =

zynqmp-zcu102          | arm64  | lab-cip         | gcc-10   | defconfig+ar=
m64-chromebook   | 1          =

zynqmp-zcu102          | arm64  | lab-cip         | gcc-10   | defconfig   =
                 | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.168-cip27-456-g42a59c4e5329/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.168-cip27-456-g42a59c4e5329
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      42a59c4e5329312aec627def5fefeaf40a482f9c =



Test Regressions
---------------- =



platform               | arch   | lab             | compiler | defconfig   =
                 | regressions
-----------------------+--------+-----------------+----------+-------------=
-----------------+------------
bcm2836-rpi-2-b        | arm    | lab-collabora   | gcc-10   | multi_v7_def=
config           | 1          =


  Details:     https://kernelci.org/test/plan/id/63f9441891e227f9658c8638

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/arm/multi_v7_defconfig/gcc-10/lab-collab=
ora/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/arm/multi_v7_defconfig/gcc-10/lab-collab=
ora/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f9441891e227f9658c8=
639
        failing since 28 days (last pass: v4.19.269-cip88-rt28-rebase, firs=
t fail: v5.10.162-cip24-443-g1f8fb81fe752) =

 =



platform               | arch   | lab             | compiler | defconfig   =
                 | regressions
-----------------------+--------+-----------------+----------+-------------=
-----------------+------------
imx6dl-udoo            | arm    | lab-broonie     | gcc-10   | imx_v6_v7_de=
fconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63f943f224611dc46d8c862f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f943f224611dc46d8c8=
630
        failing since 3 days (last pass: v4.4.302-cip72-rt42, first fail: v=
5.10.167-cip26-2-g28bb49f7179b) =

 =



platform               | arch   | lab             | compiler | defconfig   =
                 | regressions
-----------------------+--------+-----------------+----------+-------------=
-----------------+------------
imx6dl-udoo            | arm    | lab-broonie     | gcc-10   | multi_v7_def=
config           | 1          =


  Details:     https://kernelci.org/test/plan/id/63f9454348fa4304488c8650

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f9454348fa4304488c8=
651
        failing since 3 days (last pass: v4.4.302-cip72-rt42, first fail: v=
5.10.167-cip26-2-g28bb49f7179b) =

 =



platform               | arch   | lab             | compiler | defconfig   =
                 | regressions
-----------------------+--------+-----------------+----------+-------------=
-----------------+------------
imx6q-udoo             | arm    | lab-broonie     | gcc-10   | imx_v6_v7_de=
fconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63f943f324611dc46d8c8632

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f943f324611dc46d8c8=
633
        failing since 3 days (last pass: v4.4.302-cip72-rt42, first fail: v=
5.10.167-cip26-2-g28bb49f7179b) =

 =



platform               | arch   | lab             | compiler | defconfig   =
                 | regressions
-----------------------+--------+-----------------+----------+-------------=
-----------------+------------
imx6q-udoo             | arm    | lab-broonie     | gcc-10   | multi_v7_def=
config           | 1          =


  Details:     https://kernelci.org/test/plan/id/63f945440d7289b7e08c8690

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f945440d7289b7e08c8=
691
        failing since 3 days (last pass: v4.4.302-cip72-rt42, first fail: v=
5.10.167-cip26-2-g28bb49f7179b) =

 =



platform               | arch   | lab             | compiler | defconfig   =
                 | regressions
-----------------------+--------+-----------------+----------+-------------=
-----------------+------------
imx6qp-wandboard-revd1 | arm    | lab-pengutronix | gcc-10   | imx_v6_v7_de=
fconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63f942fd9548a0e4218c8696

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/arm/imx_v6_v7_defconfig/gcc-10/lab-pengu=
tronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/arm/imx_v6_v7_defconfig/gcc-10/lab-pengu=
tronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63f942fd9548a0e4218c869f
        failing since 37 days (last pass: v5.10.158-cip22-435-g2c52868ae1cb=
c, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-02-24T23:06:12.279762  =

    2023-02-24T23:06:12.382389  / # #
    2023-02-24T23:06:12.484078  export SHELL=3D/bin/sh
    2023-02-24T23:06:12.484484  #
    2023-02-24T23:06:12.585685  / # export SHELL=3D/bin/sh. /lava-912785/en=
vironment
    2023-02-24T23:06:12.586060  =

    2023-02-24T23:06:12.687253  / # . /lava-912785/environment/lava-912785/=
bin/lava-test-runner /lava-912785/1
    2023-02-24T23:06:12.687788  =

    2023-02-24T23:06:12.690564  / # /lava-912785/bin/lava-test-runner /lava=
-912785/1
    2023-02-24T23:06:12.875845  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform               | arch   | lab             | compiler | defconfig   =
                 | regressions
-----------------------+--------+-----------------+----------+-------------=
-----------------+------------
imx6qp-wandboard-revd1 | arm    | lab-pengutronix | gcc-10   | multi_v7_def=
config           | 1          =


  Details:     https://kernelci.org/test/plan/id/63f9434a0b978449da8c8631

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/arm/multi_v7_defconfig/gcc-10/lab-pengut=
ronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/arm/multi_v7_defconfig/gcc-10/lab-pengut=
ronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63f9434a0b978449da8c8639
        failing since 37 days (last pass: v5.10.158-cip22-435-g2c52868ae1cb=
c, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-02-24T23:07:35.943663  + set +x
    2023-02-24T23:07:36.056791  EASUREMENT=3D0>
    2023-02-24T23:07:36.056950  [    7.208281] <LAVA_SIGNAL_ENDRUN 0_dmesg =
912789_1.5.2.3.1>
    2023-02-24T23:07:36.057115  =

    2023-02-24T23:07:36.158524  / # #export SHELL=3D/bin/sh
    2023-02-24T23:07:36.158942  =

    2023-02-24T23:07:36.260406  / # export SHELL=3D/bin/sh. /lava-912789/en=
vironment
    2023-02-24T23:07:36.260931  =

    2023-02-24T23:07:36.362379  / # . /lava-912789/environment/lava-912789/=
bin/lava-test-runner /lava-912789/1
    2023-02-24T23:07:36.363202   =

    ... (12 line(s) more)  =

 =



platform               | arch   | lab             | compiler | defconfig   =
                 | regressions
-----------------------+--------+-----------------+----------+-------------=
-----------------+------------
qemu_i386-uefi         | i386   | lab-broonie     | gcc-10   | i386_defconf=
ig               | 1          =


  Details:     https://kernelci.org/test/plan/id/63f941b1974feee2ed8c862f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: i386_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/i386/i386_defconfig/gcc-10/lab-broonie/b=
aseline-qemu_i386-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/i386/i386_defconfig/gcc-10/lab-broonie/b=
aseline-qemu_i386-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f941b1974feee2ed8c8=
630
        failing since 3 days (last pass: v4.4.302-cip72-rt42, first fail: v=
5.10.167-cip26-2-g28bb49f7179b) =

 =



platform               | arch   | lab             | compiler | defconfig   =
                 | regressions
-----------------------+--------+-----------------+----------+-------------=
-----------------+------------
qemu_i386-uefi         | i386   | lab-collabora   | gcc-10   | i386_defconf=
ig               | 1          =


  Details:     https://kernelci.org/test/plan/id/63f9415fa7dad07c578c8637

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: i386_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/i386/i386_defconfig/gcc-10/lab-collabora=
/baseline-qemu_i386-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/i386/i386_defconfig/gcc-10/lab-collabora=
/baseline-qemu_i386-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f9415fa7dad07c578c8=
638
        failing since 3 days (last pass: v4.4.302-cip72-rt42, first fail: v=
5.10.167-cip26-2-g28bb49f7179b) =

 =



platform               | arch   | lab             | compiler | defconfig   =
                 | regressions
-----------------------+--------+-----------------+----------+-------------=
-----------------+------------
qemu_x86_64-uefi       | x86_64 | lab-broonie     | gcc-10   | x86_64_defco=
nfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/63f9427ac001c7fdfc8c866d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/x86_64/x86_64_defconfig/gcc-10/lab-broon=
ie/baseline-qemu_x86_64-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/x86_64/x86_64_defconfig/gcc-10/lab-broon=
ie/baseline-qemu_x86_64-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f9427ac001c7fdfc8c8=
66e
        failing since 3 days (last pass: v4.4.302-cip72-rt42, first fail: v=
5.10.167-cip26-2-g28bb49f7179b) =

 =



platform               | arch   | lab             | compiler | defconfig   =
                 | regressions
-----------------------+--------+-----------------+----------+-------------=
-----------------+------------
qemu_x86_64-uefi       | x86_64 | lab-broonie     | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63f9440bff258710ea8c8636

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-broonie/baseline-qemu_x86_64-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-broonie/baseline-qemu_x86_64-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f9440bff258710ea8c8=
637
        failing since 3 days (last pass: v4.4.302-cip72-rt42, first fail: v=
5.10.167-cip26-2-g28bb49f7179b) =

 =



platform               | arch   | lab             | compiler | defconfig   =
                 | regressions
-----------------------+--------+-----------------+----------+-------------=
-----------------+------------
qemu_x86_64-uefi       | x86_64 | lab-collabora   | gcc-10   | x86_64_defco=
nfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/63f9422819d5d207e48c865a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/x86_64/x86_64_defconfig/gcc-10/lab-colla=
bora/baseline-qemu_x86_64-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/x86_64/x86_64_defconfig/gcc-10/lab-colla=
bora/baseline-qemu_x86_64-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f9422819d5d207e48c8=
65b
        failing since 3 days (last pass: v4.4.302-cip72-rt42, first fail: v=
5.10.167-cip26-2-g28bb49f7179b) =

 =



platform               | arch   | lab             | compiler | defconfig   =
                 | regressions
-----------------------+--------+-----------------+----------+-------------=
-----------------+------------
qemu_x86_64-uefi-mixed | x86_64 | lab-broonie     | gcc-10   | x86_64_defco=
nfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/63f94265c001c7fdfc8c8651

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/x86_64/x86_64_defconfig/gcc-10/lab-broon=
ie/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/x86_64/x86_64_defconfig/gcc-10/lab-broon=
ie/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f94265c001c7fdfc8c8=
652
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752) =

 =



platform               | arch   | lab             | compiler | defconfig   =
                 | regressions
-----------------------+--------+-----------------+----------+-------------=
-----------------+------------
qemu_x86_64-uefi-mixed | x86_64 | lab-broonie     | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63f9440a24611dc46d8c866d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-broonie/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-broonie/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f9440a24611dc46d8c8=
66e
        failing since 17 days (last pass: v5.10.162-cip24-443-g1f8fb81fe752=
, first fail: v4.4.302-cip72-rt42) =

 =



platform               | arch   | lab             | compiler | defconfig   =
                 | regressions
-----------------------+--------+-----------------+----------+-------------=
-----------------+------------
qemu_x86_64-uefi-mixed | x86_64 | lab-collabora   | gcc-10   | x86_64_defco=
nfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/63f9422719d5d207e48c8657

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/x86_64/x86_64_defconfig/gcc-10/lab-colla=
bora/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/x86_64/x86_64_defconfig/gcc-10/lab-colla=
bora/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f9422719d5d207e48c8=
658
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752) =

 =



platform               | arch   | lab             | compiler | defconfig   =
                 | regressions
-----------------------+--------+-----------------+----------+-------------=
-----------------+------------
r8a7743-iwg20d-q7      | arm    | lab-cip         | gcc-10   | shmobile_def=
config           | 1          =


  Details:     https://kernelci.org/test/plan/id/63f944870ee9b0adf98c8638

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/arm/shmobile_defconfig/gcc-10/lab-cip/ba=
seline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/arm/shmobile_defconfig/gcc-10/lab-cip/ba=
seline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f944870ee9b0adf98c8=
639
        failing since 3 days (last pass: v4.4.302-cip72-rt42, first fail: v=
5.10.167-cip26-2-g28bb49f7179b) =

 =



platform               | arch   | lab             | compiler | defconfig   =
                 | regressions
-----------------------+--------+-----------------+----------+-------------=
-----------------+------------
rk3288-veyron-jaq      | arm    | lab-collabora   | gcc-10   | multi_v7_def=
config           | 3          =


  Details:     https://kernelci.org/test/plan/id/63f94329a69026796e8c862f

  Results:     61 PASS, 8 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/arm/multi_v7_defconfig/gcc-10/lab-collab=
ora/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/arm/multi_v7_defconfig/gcc-10/lab-collab=
ora/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwmmc_rockchip-sdmmc-probed: https://kernelci.org/test/=
case/id/63f94329a69026796e8c865d
        failing since 3 days (last pass: v4.4.302-cip72-rt42, first fail: v=
5.10.167-cip26-2-g28bb49f7179b)

    2023-02-24T23:07:03.851246  Usage<8>[   22.048215] <LAVA_SIGNAL_TESTCAS=
E TEST_CASE_ID=3Ddwmmc_rockchip-driver-present RESULT=3Dpass>

    2023-02-24T23:07:03.854809  : seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-02-24T23:07:03.855024  =


    2023-02-24T23:07:03.859767  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-02-24T23:07:03.862255  FIRST, INC default to 1.

    2023-02-24T23:07:03.862752  =


    2023-02-24T23:07:03.865793  	-w	Pad to last with leading zeros

    2023-02-24T23:07:03.868709  	-s SEP	String separator

    2023-02-24T23:07:03.872212  /lava-9323819/1/../bin/lava-test-case

    2023-02-24T23:07:03.878686  BusyBox v1.31.1 (2023-02-17 15:41:33 UTC) m=
ulti-call binary.
 =

    ... (12 line(s) more)  =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/63f94329a69026796e8c8660
        failing since 35 days (last pass: v5.10.158-cip22-435-g2c52868ae1cb=
c, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-02-24T23:07:03.797291  Usage: seq [-w] [-s SEP] [FIRST [INC]] LA<8=
>[   22.002701] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-02-24T23:07:03.797559  ST

    2023-02-24T23:07:03.797762  =


    2023-02-24T23:07:03.802180  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/63f94329a69026796e8c8661
        failing since 35 days (last pass: v5.10.158-cip22-435-g2c52868ae1cb=
c, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-02-24T23:07:03.776966  <8>[   21.978975] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>

    2023-02-24T23:07:03.782183  BusyBox v1.31.1 (2023-02-17 15:41:33 UTC) m=
ulti-call binary.

    2023-02-24T23:07:03.782694  =

   =

 =



platform               | arch   | lab             | compiler | defconfig   =
                 | regressions
-----------------------+--------+-----------------+----------+-------------=
-----------------+------------
rk3399-gru-kevin       | arm64  | lab-collabora   | gcc-10   | defconfig+ar=
m64-chromebook   | 4          =


  Details:     https://kernelci.org/test/plan/id/63f942b713849a61858c867e

  Results:     84 PASS, 6 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rk3399-gru-sound-driver-rt5514-present: https://kernelc=
i.org/test/case/id/63f942b713849a61858c86b7
        failing since 37 days (last pass: v5.10.158-cip22-435-g2c52868ae1cb=
c, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-02-24T23:05:18.946811  t-case

    2023-02-24T23:05:18.952864  BusyBox v1.31.1 (2023-02-17 14:37:44 UTC) m=
ulti-call binary.

    2023-02-24T23:05:18.952955  =


    2023-02-24T23:05:18.957319  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-02-24T23:05:18.957405  =

   =


  * baseline.bootrr.rk3399-gru-sound-driver-max98357A-present: https://kern=
elci.org/test/case/id/63f942b713849a61858c86b8
        failing since 37 days (last pass: v5.10.158-cip22-435-g2c52868ae1cb=
c, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-02-24T23:05:18.923339   INC.

    2023-02-24T23:05:18.925981  FIRST, INC default to 1.

    2023-02-24T23:05:18.926253  =


    2023-02-24T23:05:18.929636  	-w	Pad to last with leading zeros

    2023-02-24T23:05:18.932380  	-s SEP	String separator

    2023-02-24T23:05:18.945757  /lava-9323664/1/../bin/lava-tes<8>[   57.53=
0184] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Drk3399-gru-sound-driver-max98357=
A-present RESULT=3Dfail>
   =


  * baseline.bootrr.rk3399-gru-sound-driver-dp-present: https://kernelci.or=
g/test/case/id/63f942b713849a61858c86b9
        failing since 37 days (last pass: v5.10.158-cip22-435-g2c52868ae1cb=
c, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-02-24T23:05:18.900457  BusyBox v1.31.1 (2023-02-17 <8>[   57.49413=
2] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Drk3399-gru-sound-driver-da7219-pres=
ent RESULT=3Dfail>

    2023-02-24T23:05:18.903757  14:37:44 UTC) multi-call binary.

    2023-02-24T23:05:18.903856  =


    2023-02-24T23:05:18.908118  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-02-24T23:05:18.908388  =


    2023-02-24T23:05:18.922763  Print numbers from FIRST to LAST, in steps =
of<8>[   57.513667] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Drk3399-gru-sound-d=
river-dp-present RESULT=3Dfail>
   =


  * baseline.bootrr.rk3399-gru-sound-driver-da7219-present: https://kernelc=
i.org/test/case/id/63f942b713849a61858c86ba
        failing since 37 days (last pass: v5.10.158-cip22-435-g2c52868ae1cb=
c, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-02-24T23:05:18.880977  -w	Pad to last with leading zeros

    2023-02-24T23:05:18.883449  	-s SEP	String separator

    2023-02-24T23:05:18.887430  /lava-9323664/1/../bin/lava-test-case
   =

 =



platform               | arch   | lab             | compiler | defconfig   =
                 | regressions
-----------------------+--------+-----------------+----------+-------------=
-----------------+------------
rk3399-rock-pi-4b      | arm64  | lab-collabora   | gcc-10   | defconfig   =
                 | 1          =


  Details:     https://kernelci.org/test/plan/id/63f9464a9ba3a6eeff8c8711

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/arm64/defconfig/gcc-10/lab-collabora/bas=
eline-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/arm64/defconfig/gcc-10/lab-collabora/bas=
eline-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f9464a9ba3a6eeff8c8=
712
        new failure (last pass: v5.10.167-cip26-2-g28bb49f7179b) =

 =



platform               | arch   | lab             | compiler | defconfig   =
                 | regressions
-----------------------+--------+-----------------+----------+-------------=
-----------------+------------
sun50i-a64-pine64-plus | arm64  | lab-broonie     | gcc-10   | defconfig   =
                 | 1          =


  Details:     https://kernelci.org/test/plan/id/63f946e7d8ec7fa89a8c8631

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f946e7d8ec7fa89a8c8=
632
        new failure (last pass: v5.10.167-cip26-2-g28bb49f7179b) =

 =



platform               | arch   | lab             | compiler | defconfig   =
                 | regressions
-----------------------+--------+-----------------+----------+-------------=
-----------------+------------
zynqmp-zcu102          | arm64  | lab-cip         | gcc-10   | defconfig+ar=
m64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63f94378ed5a93d1508c8685

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f94378ed5a93d1508c8=
686
        failing since 28 days (last pass: v4.19.269-cip88-rt28-rebase, firs=
t fail: v5.10.162-cip24-443-g1f8fb81fe752) =

 =



platform               | arch   | lab             | compiler | defconfig   =
                 | regressions
-----------------------+--------+-----------------+----------+-------------=
-----------------+------------
zynqmp-zcu102          | arm64  | lab-cip         | gcc-10   | defconfig   =
                 | 1          =


  Details:     https://kernelci.org/test/plan/id/63f946489ba3a6eeff8c870e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/arm64/defconfig/gcc-10/lab-cip/baseline-=
zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/arm64/defconfig/gcc-10/lab-cip/baseline-=
zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f946489ba3a6eeff8c8=
70f
        failing since 28 days (last pass: v4.19.269-cip88-rt28-rebase, firs=
t fail: v5.10.162-cip24-443-g1f8fb81fe752) =

 =20

