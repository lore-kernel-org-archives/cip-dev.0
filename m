Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A2DC64EC4
	for <webhook@archiver.kernel.org>; Wed, 22 Feb 2023 05:16:44 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.web10.1997.1677043001934283760
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 21 Feb 2023 21:16:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=8GGzzZGj;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.50, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f50.google.com with SMTP id g14so7585883pjb.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 21 Feb 2023 21:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2NFLxV/q+rg9dmOKMIJ4W3jo6yhKUuhhrit5avZMM9I=;
        b=8GGzzZGjmg22qKR36afkb01o4J28TQvsRAB+TbULNR1jFElH4bwHkkcXP4dHaBOMSB
         p/dyVI+Lv4aG7YooA2PPMPQjHWEXE5ZbElaMgrDoFoni27E8mhQIApedB/pUiIbXvDeX
         rek1XFAlfRn1AUvAhql8kV2aSDc7XXQTRi74qbi1qMBZsmnolaXcXb6CeSU7wEOooOcB
         x4dGUVBCN0EUJUa8sD1L0aTkKIrtg2/FOpIcX9tlemTUeR0YN6h468qRwSky+IUmkWIa
         tuIUB436n79Z8Urnx/etQg8+EFyFS274iteuW8c7BUtD8cpZtKSjAx4zHR06xddaMS3m
         Plbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2NFLxV/q+rg9dmOKMIJ4W3jo6yhKUuhhrit5avZMM9I=;
        b=jDkkAebJZaAeRC8iwBtjD8sCLCOBnPDFMRLTb3sbq5i6mClumAPgTdVNahmtvZctRv
         ge0PLlf3YsEpz+gjXulZHHzy4quTxi+cVUXMpCz4/9S2a4ojyUngbx3p27PRhCAycPpe
         95Poo7e+wMCOe1UCjNSgG3SWox107L++z0tuco6b1zCzgrjFWPPoCMqmCdJxqCIoMlIW
         /+25WE6RCIqsBityuaq8m1EC1WOPfUJ5HbnVKT8jP5qRwxa+cSwaoFPYsYd7M4uGUgz1
         pSf//BLpXGjUG7QN11lct6pODSvQx7uwmubohLsxwm56zBtwwr21jeJxadsl4Q8lfY3i
         EUKw==
X-Gm-Message-State: AO0yUKVI18O2uWZIQ8BaENVmrUeAS6sHQ+D7vqC1/8h1YCvyTwcDtwx/
	M6toE19sqbIZaUxrJzePQMVf9j3MAhT7k43g/Cg=
X-Google-Smtp-Source: AK7set+HV8f6/t8uu8dfmPa+M4QerLSEkzKs57yjOhZVgoRY4DM/Z8n4en6zt28ByZdblt9wlL1HIw==
X-Received: by 2002:a05:6a21:7898:b0:cb:cfb1:6639 with SMTP id bf24-20020a056a21789800b000cbcfb16639mr916599pzc.31.1677043000550;
        Tue, 21 Feb 2023 21:16:40 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 12-20020aa7914c000000b005ac419804d5sm7288228pfi.98.2023.02.21.21.16.39
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 21:16:40 -0800 (PST)
Message-ID: <63f5a538.a70a0220.595ce.d859@mx.google.com>
Date: Tue, 21 Feb 2023 21:16:40 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.167-cip26-2-g1e87e7748b91
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 102 runs,
 10 regressions (v5.10.167-cip26-2-g1e87e7748b91)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Feb 2023 05:16:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10769

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 102 runs, 10 regressio=
ns (v5.10.167-cip26-2-g1e87e7748b91)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
at91sam9g20ek            | arm    | lab-broonie   | gcc-10   | at91_dt_defc=
onfig            | 1          =

beaglebone-black         | arm    | lab-broonie   | gcc-10   | omap2plus_de=
fconfig          | 1          =

qemu_i386-uefi           | i386   | lab-broonie   | gcc-10   | i386_defconf=
ig               | 1          =

qemu_x86_64-uefi         | x86_64 | lab-broonie   | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =

qemu_x86_64-uefi         | x86_64 | lab-broonie   | gcc-10   | x86_64_defco=
nfig             | 1          =

qemu_x86_64-uefi         | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =

qemu_x86_64-uefi-mixed   | x86_64 | lab-broonie   | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =

qemu_x86_64-uefi-mixed   | x86_64 | lab-broonie   | gcc-10   | x86_64_defco=
nfig             | 1          =

r8a7743-iwg20d-q7        | arm    | lab-cip       | gcc-10   | shmobile_def=
config           | 1          =

r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig   =
                 | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.167-cip26-2-g1e87e7748b91/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.167-cip26-2-g1e87e7748b91
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      1e87e7748b91cc6ec7f9f32d6d156ee15f651805 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
at91sam9g20ek            | arm    | lab-broonie   | gcc-10   | at91_dt_defc=
onfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/63f599ab52110b3f788c86f3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.167-cip26-2-g1e87e7748b91/arm/at91_dt_defconfig/gcc-10/l=
ab-broonie/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.167-cip26-2-g1e87e7748b91/arm/at91_dt_defconfig/gcc-10/l=
ab-broonie/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f599ab52110b3f788c8=
6f4
        new failure (last pass: v5.10.165-cip25-154-gb7e05ba4f61a2) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
beaglebone-black         | arm    | lab-broonie   | gcc-10   | omap2plus_de=
fconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63f59a16e74f8cbfc08c8635

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.167-cip26-2-g1e87e7748b91/arm/omap2plus_defconfig/gcc-10=
/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.167-cip26-2-g1e87e7748b91/arm/omap2plus_defconfig/gcc-10=
/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63f59a16e74f8cbfc08c863e
        failing since 48 days (last pass: v5.10.155-cip21-405-g26d566555c3d=
e, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2023-02-22T04:28:48.596917  <8>[   19.833579] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 53299_1.5.2.4.1>
    2023-02-22T04:28:48.706259  / # #
    2023-02-22T04:28:48.809412  export SHELL=3D/bin/sh
    2023-02-22T04:28:48.810251  #
    2023-02-22T04:28:48.912214  / # export SHELL=3D/bin/sh. /lava-53299/env=
ironment
    2023-02-22T04:28:48.913145  =

    2023-02-22T04:28:49.015266  / # . /lava-53299/environment/lava-53299/bi=
n/lava-test-runner /lava-53299/1
    2023-02-22T04:28:49.016736  =

    2023-02-22T04:28:49.021415  / # /lava-53299/bin/lava-test-runner /lava-=
53299/1
    2023-02-22T04:28:49.129042  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
qemu_i386-uefi           | i386   | lab-broonie   | gcc-10   | i386_defconf=
ig               | 1          =


  Details:     https://kernelci.org/test/plan/id/63f5a073c7a7664e088c8663

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: i386_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.167-cip26-2-g1e87e7748b91/i386/i386_defconfig/gcc-10/lab=
-broonie/baseline-qemu_i386-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.167-cip26-2-g1e87e7748b91/i386/i386_defconfig/gcc-10/lab=
-broonie/baseline-qemu_i386-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f5a073c7a7664e088c8=
664
        new failure (last pass: v5.10.165-cip25-154-gb7e05ba4f61a2) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
qemu_x86_64-uefi         | x86_64 | lab-broonie   | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63f59e96be39ad55618c8641

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.167-cip26-2-g1e87e7748b91/x86_64/x86_64_defconfig+x86-ch=
romebook/gcc-10/lab-broonie/baseline-qemu_x86_64-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.167-cip26-2-g1e87e7748b91/x86_64/x86_64_defconfig+x86-ch=
romebook/gcc-10/lab-broonie/baseline-qemu_x86_64-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f59e96be39ad55618c8=
642
        new failure (last pass: v5.10.165-cip25-154-gb7e05ba4f61a2) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
qemu_x86_64-uefi         | x86_64 | lab-broonie   | gcc-10   | x86_64_defco=
nfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/63f5a04b035239df3d8c8675

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.167-cip26-2-g1e87e7748b91/x86_64/x86_64_defconfig/gcc-10=
/lab-broonie/baseline-qemu_x86_64-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.167-cip26-2-g1e87e7748b91/x86_64/x86_64_defconfig/gcc-10=
/lab-broonie/baseline-qemu_x86_64-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f5a04b035239df3d8c8=
676
        new failure (last pass: v5.10.165-cip25-154-gb7e05ba4f61a2) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
qemu_x86_64-uefi         | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63f59792ed618b32928c868f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.167-cip26-2-g1e87e7748b91/x86_64/x86_64_defconfig+x86-ch=
romebook/gcc-10/lab-collabora/baseline-qemu_x86_64-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.167-cip26-2-g1e87e7748b91/x86_64/x86_64_defconfig+x86-ch=
romebook/gcc-10/lab-collabora/baseline-qemu_x86_64-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f59792ed618b32928c8=
690
        new failure (last pass: v5.10.165-cip25-154-gb7e05ba4f61a2) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
qemu_x86_64-uefi-mixed   | x86_64 | lab-broonie   | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63f59e94a7b5577b688c8647

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.167-cip26-2-g1e87e7748b91/x86_64/x86_64_defconfig+x86-ch=
romebook/gcc-10/lab-broonie/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.167-cip26-2-g1e87e7748b91/x86_64/x86_64_defconfig+x86-ch=
romebook/gcc-10/lab-broonie/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f59e94a7b5577b688c8=
648
        new failure (last pass: v5.10.165-cip25-154-gb7e05ba4f61a2) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
qemu_x86_64-uefi-mixed   | x86_64 | lab-broonie   | gcc-10   | x86_64_defco=
nfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/63f5a04d035239df3d8c8678

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.167-cip26-2-g1e87e7748b91/x86_64/x86_64_defconfig/gcc-10=
/lab-broonie/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.167-cip26-2-g1e87e7748b91/x86_64/x86_64_defconfig/gcc-10=
/lab-broonie/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f5a04d035239df3d8c8=
679
        new failure (last pass: v5.10.165-cip25-154-gb7e05ba4f61a2) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
r8a7743-iwg20d-q7        | arm    | lab-cip       | gcc-10   | shmobile_def=
config           | 1          =


  Details:     https://kernelci.org/test/plan/id/63f599a752110b3f788c86f0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.167-cip26-2-g1e87e7748b91/arm/shmobile_defconfig/gcc-10/=
lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.167-cip26-2-g1e87e7748b91/arm/shmobile_defconfig/gcc-10/=
lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f599a752110b3f788c8=
6f1
        new failure (last pass: v5.10.165-cip25-154-gb7e05ba4f61a2) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig   =
                 | 1          =


  Details:     https://kernelci.org/test/plan/id/63f59d7294dc6286648c862f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.167-cip26-2-g1e87e7748b91/arm64/defconfig/gcc-10/lab-cip=
/baseline-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.167-cip26-2-g1e87e7748b91/arm64/defconfig/gcc-10/lab-cip=
/baseline-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f59d7294dc6286648c8=
630
        new failure (last pass: v5.10.165-cip25-144-g43e1d8dfbb26) =

 =20

