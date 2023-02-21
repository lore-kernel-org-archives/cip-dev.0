Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFFDC61DA3
	for <webhook@archiver.kernel.org>; Tue, 21 Feb 2023 13:52:47 +0000 (UTC)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
 by mx.groups.io with SMTP id smtpd.web10.42276.1676987560834709797
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 21 Feb 2023 05:52:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=aXxYriYu;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.53, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f53.google.com with SMTP id na9-20020a17090b4c0900b0023058bbd7b2so4754778pjb.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 21 Feb 2023 05:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5swHvKeWMT9xCHqOf/T395ApEa3wgMzZpPIFuAkk4p4=;
        b=aXxYriYusO+Vx/bPH2fSgWPFzre9Wqok7eXwlxBa0yyVv/Yk1OQkjUUNkHGw1raUDg
         PL8/ceOQcSJHM+I7rMWrveRqqTijR2UApxeVrB9gdZoklvJFNiBiChDjZMt52F0zhBlu
         4ejqjLZUFjtyHgl4gVZkI8UWW5/Vdwx8mAniqnI+Lk5HtjTN+b44WhJ1ItVvSNLTmh6y
         TeUSTLhPyxVdSAZQFJS6tQgcxkNLm4AuPHX2elh9segfQf9nZPwsyvBlZe7IweQq3ckF
         sDgmMu5Y9YBFTQcXeZEyBhtzmLjAblMSrZH1+7Mb6n+4eURiNBNEF3QWmGC/onwYyljo
         V1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5swHvKeWMT9xCHqOf/T395ApEa3wgMzZpPIFuAkk4p4=;
        b=uRqITMS91bnNT/Jw+UDLze0dQ0jtWI4d1gBhjlMh7gCMhHzXv1wd6pT0BWbshsHpB+
         p5GQJNTgQp9mHCkaVxbweOakdBaqDUP4CXVxkWpms7v71tV56WXXWLBNmq+vSD8RBr/Z
         XytNB6qxJcTmrZye3KYSPbKGAslE8I8Eqr7CNPNFUGL3NlcTCUPNLY0wg1ezGMzh2EgP
         3jPj6pJiNOCBbNu09S4kznCdxOusITsurTh6xGCTqXo/o6Z5N2xdZHfJy21zObtA9oL8
         jFzByqr1YF61VP1ByNnBRQCUdAFBwYTDyypN7TcY6446rnoLzmF0w5lCsH6mR9TtWGEV
         vOBQ==
X-Gm-Message-State: AO0yUKX4+rHdeDtmnKMz8TVmVTSnIEReD3h2gnldOG2gdlURYlUxD2se
	RIOmJ3W56Wi9i4nnJ5RXt8SMsYsNVi3dASty
X-Google-Smtp-Source: AK7set/96+BPntuqavNKLoNuqGnvdEQ+HW2CIFIIMXAv749fxb0qKweABaIPFGWRXvDrqO6BYHd9qA==
X-Received: by 2002:a05:6a20:144e:b0:c6:d4e7:b882 with SMTP id a14-20020a056a20144e00b000c6d4e7b882mr14359200pzi.16.1676987560020;
        Tue, 21 Feb 2023 05:52:40 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p10-20020a62ab0a000000b005a8ce67874asm3646811pff.86.2023.02.21.05.52.39
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 05:52:39 -0800 (PST)
Message-ID: <63f4cca7.620a0220.cccef.635b@mx.google.com>
Date: Tue, 21 Feb 2023 05:52:39 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.167-cip26-2-g28bb49f7179b
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 39 runs,
 9 regressions (v5.10.167-cip26-2-g28bb49f7179b)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 21 Feb 2023 13:52:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10754

cip-gitlab/ci/pavel/linux-test baseline-nfs: 39 runs, 9 regressions (v5.10.=
167-cip26-2-g28bb49f7179b)

Regressions Summary
-------------------

platform               | arch  | lab           | compiler | defconfig      =
            | regressions
-----------------------+-------+---------------+----------+----------------=
------------+------------
imx6dl-udoo            | arm   | lab-broonie   | gcc-10   | imx_v6_v7_defco=
nfig        | 1          =

imx6dl-udoo            | arm   | lab-broonie   | gcc-10   | multi_v7_defcon=
fig         | 1          =

imx6q-udoo             | arm   | lab-broonie   | gcc-10   | imx_v6_v7_defco=
nfig        | 1          =

imx6q-udoo             | arm   | lab-broonie   | gcc-10   | multi_v7_defcon=
fig         | 1          =

rk3399-gru-kevin       | arm64 | lab-collabora | gcc-10   | defconfig+arm64=
-chromebook | 4          =

sun50i-a64-pine64-plus | arm64 | lab-broonie   | gcc-10   | defconfig      =
            | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.167-cip26-2-g28bb49f7179b/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.167-cip26-2-g28bb49f7179b
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      28bb49f7179b9cb7b4cd5c5a139820ec49c19d6d =



Test Regressions
---------------- =



platform               | arch  | lab           | compiler | defconfig      =
            | regressions
-----------------------+-------+---------------+----------+----------------=
------------+------------
imx6dl-udoo            | arm   | lab-broonie   | gcc-10   | imx_v6_v7_defco=
nfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/63f4c83451781812528c863f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.167-cip26-2-g28bb49f7179b/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie=
/baseline-nfs-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.167-cip26-2-g28bb49f7179b/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie=
/baseline-nfs-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230211.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63f4c834517818125=
28c8640
        new failure (last pass: v4.4.302-cip72-rt42) =

 =



platform               | arch  | lab           | compiler | defconfig      =
            | regressions
-----------------------+-------+---------------+----------+----------------=
------------+------------
imx6dl-udoo            | arm   | lab-broonie   | gcc-10   | multi_v7_defcon=
fig         | 1          =


  Details:     https://kernelci.org/test/plan/id/63f4c9b96b9b48c9f68c8668

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.167-cip26-2-g28bb49f7179b/arm/multi_v7_defconfig/gcc-10/lab-broonie/=
baseline-nfs-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.167-cip26-2-g28bb49f7179b/arm/multi_v7_defconfig/gcc-10/lab-broonie/=
baseline-nfs-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230211.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63f4c9b96b9b48c9f=
68c8669
        new failure (last pass: v4.4.302-cip72-rt42) =

 =



platform               | arch  | lab           | compiler | defconfig      =
            | regressions
-----------------------+-------+---------------+----------+----------------=
------------+------------
imx6q-udoo             | arm   | lab-broonie   | gcc-10   | imx_v6_v7_defco=
nfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/63f4c6c16d611bbd238c864e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.167-cip26-2-g28bb49f7179b/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie=
/baseline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.167-cip26-2-g28bb49f7179b/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie=
/baseline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230211.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63f4c6c16d611bbd2=
38c864f
        new failure (last pass: v4.4.302-cip72-rt42) =

 =



platform               | arch  | lab           | compiler | defconfig      =
            | regressions
-----------------------+-------+---------------+----------+----------------=
------------+------------
imx6q-udoo             | arm   | lab-broonie   | gcc-10   | multi_v7_defcon=
fig         | 1          =


  Details:     https://kernelci.org/test/plan/id/63f4c83637ad7e61c08c8643

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.167-cip26-2-g28bb49f7179b/arm/multi_v7_defconfig/gcc-10/lab-broonie/=
baseline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.167-cip26-2-g28bb49f7179b/arm/multi_v7_defconfig/gcc-10/lab-broonie/=
baseline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230211.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63f4c83637ad7e61c=
08c8644
        new failure (last pass: v4.4.302-cip72-rt42) =

 =



platform               | arch  | lab           | compiler | defconfig      =
            | regressions
-----------------------+-------+---------------+----------+----------------=
------------+------------
rk3399-gru-kevin       | arm64 | lab-collabora | gcc-10   | defconfig+arm64=
-chromebook | 4          =


  Details:     https://kernelci.org/test/plan/id/63f4c5e41f13184db68c8636

  Results:     86 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.167-cip26-2-g28bb49f7179b/arm64/defconfig+arm64-chromebook/gcc-10/la=
b-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.167-cip26-2-g28bb49f7179b/arm64/defconfig+arm64-chromebook/gcc-10/la=
b-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230211.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rk3399-gru-sound-driver-rt5514-present: https://ker=
nelci.org/test/case/id/63f4c5e41f13184db68c8671
        failing since 33 days (last pass: v5.10.158-cip22-435-g2c52868ae1cb=
c, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-02-21T13:23:28.367259  <8>[   91.101369] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-max98357A-present RESULT=3Dfail>

    2023-02-21T13:23:28.399448  seq: invalid floating point argument: =E2=
=80=98sound/RT5514=E2=80=99

    2023-02-21T13:23:28.403613  Try 'seq --help' for more information.

    2023-02-21T13:23:28.407352  /lava-9265558/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-max98357A-present: https://=
kernelci.org/test/case/id/63f4c5e41f13184db68c8672
        failing since 33 days (last pass: v5.10.158-cip22-435-g2c52868ae1cb=
c, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-02-21T13:23:28.340822  seq: invalid floating point argument: =E2=
=80=98sound/MAX98357A=E2=80=99

    2023-02-21T13:23:28.344573  Try 'seq --help' for more information.

    2023-02-21T13:23:28.348226  /lava-9265558/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-dp-present: https://kernelc=
i.org/test/case/id/63f4c5e41f13184db68c8673
        failing since 33 days (last pass: v5.10.158-cip22-435-g2c52868ae1cb=
c, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-02-21T13:23:28.290620  seq: invalid floating point argument: =E2=
=80=98sound/DP=E2=80=99

    2023-02-21T13:23:28.294330  Try 'seq --help' for more information.

    2023-02-21T13:23:28.298193  /lava-9265558/1/../bin/lava-test-case

    2023-02-21T13:23:28.315934  <8>[   91.051110] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-dp-present RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-da7219-present: https://ker=
nelci.org/test/case/id/63f4c5e41f13184db68c8674
        failing since 33 days (last pass: v5.10.158-cip22-435-g2c52868ae1cb=
c, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-02-21T13:23:28.222278  <8>[   90.957377] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-present RESULT=3Dpass>

    2023-02-21T13:23:28.242425  seq: invalid floating point argument: =E2=
=80=98sound/DA7219=E2=80=99

    2023-02-21T13:23:28.246498  Try 'seq --help' for more information.

    2023-02-21T13:23:28.250243  /lava-9265558/1/../bin/lava-test-case

    2023-02-21T13:23:28.267809  <8>[   91.002268] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-da7219-present RESULT=3Dfail>
   =

 =



platform               | arch  | lab           | compiler | defconfig      =
            | regressions
-----------------------+-------+---------------+----------+----------------=
------------+------------
sun50i-a64-pine64-plus | arm64 | lab-broonie   | gcc-10   | defconfig      =
            | 1          =


  Details:     https://kernelci.org/test/plan/id/63f4c6c22db73367fb8c87c6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.167-cip26-2-g28bb49f7179b/arm64/defconfig/gcc-10/lab-broonie/baselin=
e-nfs-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.167-cip26-2-g28bb49f7179b/arm64/defconfig/gcc-10/lab-broonie/baselin=
e-nfs-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230211.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63f4c6c22db73367fb8c87cf
        failing since 33 days (last pass: v5.10.158-cip22-435-g2c52868ae1cb=
c, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-02-21T13:27:11.029648  [   30.937030] <LAVA_SIGNAL_ENDRUN 0_dmesg =
51057_1.6.2.4.1>
    2023-02-21T13:27:11.157546  #
    2023-02-21T13:27:11.259843  / # #export SHELL=3D/bin/sh
    2023-02-21T13:27:11.261054  =

    2023-02-21T13:27:11.363714  / # export SHELL=3D/bin/sh. /lava-51057/env=
ironment
    2023-02-21T13:27:11.364361  =

    2023-02-21T13:27:11.466538  / # . /lava-51057/environment/lava-51057/bi=
n/lava-test-runner /lava-51057/1
    2023-02-21T13:27:11.467505  =

    2023-02-21T13:27:11.471473  / # /lava-51057/bin/lava-test-runner /lava-=
51057/1
    2023-02-21T13:27:11.611736  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =20

