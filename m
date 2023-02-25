Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA38BC6FA8E
	for <webhook@archiver.kernel.org>; Sat, 25 Feb 2023 00:02:03 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web11.34166.1677283316402404979
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 24 Feb 2023 16:01:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=SFbLTmOQ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.170, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f170.google.com with SMTP id i10so1131436plr.9
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 24 Feb 2023 16:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6REKQzRHWxh6bZcK1J+kcEoyZjVgJQGgjubF1DUQtt4=;
        b=SFbLTmOQSi0NWJTCcujmGCb+93UECjTjzp2e0JquuvutuaFKNfMOOefHpRNmoYQSQ3
         N6PLSddaKPreYNcNYkt4qyE9ZkmwHH1uxDwcKhi7p2cIGBsR+Zy5zMlthH0siJ7qo8mx
         mRCvZ1Y5T3uXqZxM9vyRTNxn3EkkTHcAm59KWqhxvOI126NvN/xmsVTrHY6hQcIsQikr
         Moa8sa1UjcDAobJ+aRqUyo+YfnEeDQiFq0FiArov1EMkzYJxZT2rISHp9X4RO2QmLex1
         slxE/VyoTON7pra/LM3VtETmZaWvvlc8TcyRRN7ZmPO5jNQpK8EJUFQOho0GaovkOZsX
         IJ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6REKQzRHWxh6bZcK1J+kcEoyZjVgJQGgjubF1DUQtt4=;
        b=NKpC1BGrhOixCbjBw8Iir4Z4C8sERntZzsv6mZMuBE85b6rRKIWijXMbEY1hOtMGXf
         jDdz9ZAPsiOXcXNpgXYkOLYrs5UPXovJUNMcogVn6WxeU+eidQSPP8wryU1Hs4v3vqPz
         LOt+RSg+5oZZmbPauRkanyiV7Bw38hg4RYGo2DAjKzpcbsg/E/LeYzD4u03RDgv4QpH/
         lPi6C+NIIVEIVCYkrFeOlG9sHVAPzhF/dvyuqxobUd2IH5PmM9BZ1ovcl4dGgGfJa0Dv
         jEnZqHaX/xDp+acWLbWdkFk/K+k1M+Dm3ELGwZ8+m7mpBUt/EMFrPMpeMARBDK+dtdUs
         q/xA==
X-Gm-Message-State: AO0yUKX15tQvQ7tkyDAhBzVXkAc9lcytFPK8eEGQelI+EXs+08iiJ7Ej
	VJSliWX15Wz0+zH2HduGLtgF735Ymi7A03sWdLEnMg==
X-Google-Smtp-Source: AK7set+0nt+8X9/PvvVMYZ2kecgS59vwIq0JKYSPbZMCAFfteviW/zYM0Ol7DoV783+x3xa6NV9QzA==
X-Received: by 2002:a17:903:41cd:b0:199:10d2:b9da with SMTP id u13-20020a17090341cd00b0019910d2b9damr17236673ple.58.1677283315031;
        Fri, 24 Feb 2023 16:01:55 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s6-20020a17090302c600b00196519d8647sm85749plk.4.2023.02.24.16.01.54
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 16:01:54 -0800 (PST)
Message-ID: <63f94ff2.170a0220.e4f3b.03c7@mx.google.com>
Date: Fri, 24 Feb 2023 16:01:54 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.168-cip27-456-g42a59c4e5329
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 36 runs,
 8 regressions (v5.10.168-cip27-456-g42a59c4e5329)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 25 Feb 2023 00:02:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10832

cip-gitlab/ci/pavel/linux-test baseline-nfs: 36 runs, 8 regressions (v5.10.=
168-cip27-456-g42a59c4e5329)

Regressions Summary
-------------------

platform               | arch  | lab           | compiler | defconfig      =
            | regressions
-----------------------+-------+---------------+----------+----------------=
------------+------------
at91sam9g20ek          | arm   | lab-broonie   | gcc-10   | multi_v5_defcon=
fig         | 1          =

imx6dl-udoo            | arm   | lab-broonie   | gcc-10   | imx_v6_v7_defco=
nfig        | 1          =

imx6q-udoo             | arm   | lab-broonie   | gcc-10   | imx_v6_v7_defco=
nfig        | 1          =

rk3399-gru-kevin       | arm64 | lab-collabora | gcc-10   | defconfig+arm64=
-chromebook | 4          =

sun50i-a64-pine64-plus | arm64 | lab-broonie   | gcc-10   | defconfig      =
            | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.168-cip27-456-g42a59c4e5329/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.168-cip27-456-g42a59c4e5329
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      42a59c4e5329312aec627def5fefeaf40a482f9c =



Test Regressions
---------------- =



platform               | arch  | lab           | compiler | defconfig      =
            | regressions
-----------------------+-------+---------------+----------+----------------=
------------+------------
at91sam9g20ek          | arm   | lab-broonie   | gcc-10   | multi_v5_defcon=
fig         | 1          =


  Details:     https://kernelci.org/test/plan/id/63f944d7cc7f46004d8c8668

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/arm/multi_v5_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/arm/multi_v5_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230217.0/armel/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63f944d7cc7f46004=
d8c8669
        new failure (last pass: v5.10.167-cip26-2-g28bb49f7179b) =

 =



platform               | arch  | lab           | compiler | defconfig      =
            | regressions
-----------------------+-------+---------------+----------+----------------=
------------+------------
imx6dl-udoo            | arm   | lab-broonie   | gcc-10   | imx_v6_v7_defco=
nfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/63f946c4b21000516a8c862f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230217.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63f946c4b21000516=
a8c8630
        failing since 3 days (last pass: v4.4.302-cip72-rt42, first fail: v=
5.10.167-cip26-2-g28bb49f7179b) =

 =



platform               | arch  | lab           | compiler | defconfig      =
            | regressions
-----------------------+-------+---------------+----------+----------------=
------------+------------
imx6q-udoo             | arm   | lab-broonie   | gcc-10   | imx_v6_v7_defco=
nfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/63f946c6a4462cf7838c8644

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230217.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63f946c6a4462cf78=
38c8645
        failing since 3 days (last pass: v4.4.302-cip72-rt42, first fail: v=
5.10.167-cip26-2-g28bb49f7179b) =

 =



platform               | arch  | lab           | compiler | defconfig      =
            | regressions
-----------------------+-------+---------------+----------+----------------=
------------+------------
rk3399-gru-kevin       | arm64 | lab-collabora | gcc-10   | defconfig+arm64=
-chromebook | 4          =


  Details:     https://kernelci.org/test/plan/id/63f94344da3b0087a38c8664

  Results:     86 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230217.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rk3399-gru-sound-driver-rt5514-present: https://ker=
nelci.org/test/case/id/63f94344da3b0087a38c869a
        failing since 37 days (last pass: v5.10.158-cip22-435-g2c52868ae1cb=
c, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-02-24T23:07:37.402283  seq: invalid floating point argument: =E2=
=80=98sound/RT5514=E2=80=99

    2023-02-24T23:07:37.406428  Try 'seq --help' for more information.

    2023-02-24T23:07:37.410228  /lava-9323663/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-max98357A-present: https://=
kernelci.org/test/case/id/63f94344da3b0087a38c869b
        failing since 37 days (last pass: v5.10.158-cip22-435-g2c52868ae1cb=
c, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-02-24T23:07:37.343719  seq: invalid floating point argument: =E2=
=80=98sound/MAX98357A=E2=80=99

    2023-02-24T23:07:37.347619  Try 'seq --help' for more information.

    2023-02-24T23:07:37.351199  /lava-9323663/1/../bin/lava-test-case

    2023-02-24T23:07:37.379093  <8>[   40.576359] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-max98357A-present RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-dp-present: https://kernelc=
i.org/test/case/id/63f94344da3b0087a38c869c
        failing since 37 days (last pass: v5.10.158-cip22-435-g2c52868ae1cb=
c, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-02-24T23:07:37.298003  seq: invalid floating point argument: =E2=
=80=98sound/DP=E2=80=99

    2023-02-24T23:07:37.302013  Try 'seq --help' for more information.

    2023-02-24T23:07:37.305726  /lava-9323663/1/../bin/lava-test-case

    2023-02-24T23:07:37.330521  <8>[   40.529964] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-dp-present RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-da7219-present: https://ker=
nelci.org/test/case/id/63f94344da3b0087a38c869d
        failing since 37 days (last pass: v5.10.158-cip22-435-g2c52868ae1cb=
c, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-02-24T23:07:37.234414  <8>[   40.431341] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-present RESULT=3Dpass>

    2023-02-24T23:07:37.243340  seq: invalid floating point argument: =E2=
=80=98sound/DA7219=E2=80=99

    2023-02-24T23:07:37.247388  Try 'seq --help' for more information.

    2023-02-24T23:07:37.251103  /lava-9323663/1/../bin/lava-test-case

    2023-02-24T23:07:37.274858  <8>[   40.473674] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-da7219-present RESULT=3Dfail>
   =

 =



platform               | arch  | lab           | compiler | defconfig      =
            | regressions
-----------------------+-------+---------------+----------+----------------=
------------+------------
sun50i-a64-pine64-plus | arm64 | lab-broonie   | gcc-10   | defconfig      =
            | 1          =


  Details:     https://kernelci.org/test/plan/id/63f94778920f1f8c528c864e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-nfs-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-nfs-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230217.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63f94778920f1f8c528c8657
        failing since 37 days (last pass: v5.10.158-cip22-435-g2c52868ae1cb=
c, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-02-24T23:25:24.971002  [   30.918017] <LAVA_SIGNAL_ENDRUN 0_dmesg =
71912_1.6.2.4.1>
    2023-02-24T23:25:25.090885  / # #
    2023-02-24T23:25:25.193234  export SHELL=3D/bin/sh
    2023-02-24T23:25:25.193804  #
    2023-02-24T23:25:25.295711  / # export SHELL=3D/bin/sh. /lava-71912/env=
ironment
    2023-02-24T23:25:25.296594  =

    2023-02-24T23:25:25.398697  / # . /lava-71912/environment/lava-71912/bi=
n/lava-test-runner /lava-71912/1
    2023-02-24T23:25:25.399495  =

    2023-02-24T23:25:25.404295  / # /lava-71912/bin/lava-test-runner /lava-=
71912/1
    2023-02-24T23:25:25.556908  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =20

