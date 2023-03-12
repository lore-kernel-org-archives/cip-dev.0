Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E44C6FD1F
	for <webhook@archiver.kernel.org>; Sun, 12 Mar 2023 08:38:31 +0000 (UTC)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
 by mx.groups.io with SMTP id smtpd.web10.63131.1678610302166644966
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 12 Mar 2023 00:38:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=HjkIqX6z;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.52, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f52.google.com with SMTP id y2so9186207pjg.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 12 Mar 2023 00:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1678610301;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PjYJLXhFfQSPySv5xFWIq95p/4UrPfch5bxjhFKfQhs=;
        b=HjkIqX6zkMEZarPjbbn4/Dj9swmZ7Yq2HnQd5KNi2v5b4RUzPy54F1/DM5+Eln0m5h
         MX+u+KA7lmRZRunPCRZFvw/fjK9ZbuQGv9wzAdJPOnJK3B9CVtYmSoFM3U6ikVRnm5lP
         TnFBKZL3rifcwJF0i5LEOoopWGA+KS3D9HCs59wz98EOs/Vjb9GiPDPGkbM7vvvMgn9T
         zy48Vmjd3YDRKWstvs9p/XvUA4dc8twuQ3x908l3zV2lfHAOdGX9RC6AlnTLuMn4ewru
         DYAE9Rc0HwMw0zxN1GGQoNmqi8gyUauXaNrLj86pmLfBBkiB3K2eXVWLKdsy3CqshGua
         REwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678610301;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PjYJLXhFfQSPySv5xFWIq95p/4UrPfch5bxjhFKfQhs=;
        b=O7flSK2xg/FnsZMx7mwExd9r63SEtrQxsj2hU4MTMZ8z9iGyiI43w9wi7QfxbSaw5T
         y083smj8c0IyxD9p2ILxiovIlq90PAWIxQW00dSyWuwsj/UBJ2X+vmPCPk5SWVELitjh
         +AlpHUdHyIqdCX8QI+1uaRqUTr2WDmxhSQDVkbepnFP7Tv7mmPnCQrTevBHySILZDQWq
         nxIKhpnal9nQpjRTARL2PLplUHNqBC6DQ4LxTVR2rvVxH93cj9rxLoEnCCiYxH2ZpQhJ
         aQnDGpgyuYfUVwEO6xHzyS/WqxjXqUzL0rhZAHUIHdbBP0ZXRGjpoNHqHxzYTCDByaOV
         ByrQ==
X-Gm-Message-State: AO0yUKX9EIArEOKQmY6xSnUJf3RuyT2HnfZ87NA8Y1Jx6sNUVnz1X3iZ
	r852GBgtBMyNiRD++sSljCPglSD7y17muc0cxAU=
X-Google-Smtp-Source: AK7set8adsXHgy7vcf/2Q5gXTbhuRqLQqxpxUbupT3KiBNsGQYAMEL3XNx6zb7uy2o9IeAqPDX+88A==
X-Received: by 2002:a05:6a20:918a:b0:d3:78ab:77a9 with SMTP id v10-20020a056a20918a00b000d378ab77a9mr4050947pzd.46.1678610300979;
        Sun, 12 Mar 2023 00:38:20 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p12-20020aa7860c000000b005a8c16fcb78sm2437583pfn.56.2023.03.12.00.38.20
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 00:38:20 -0800 (PST)
Message-ID: <640d8f7c.a70a0220.47c50.40f9@mx.google.com>
Date: Sun, 12 Mar 2023 00:38:20 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.168-cip27-638-g0d599cd2b6695
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 160 runs,
 13 regressions (v5.10.168-cip27-638-g0d599cd2b6695)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 12 Mar 2023 08:38:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10986

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 160 runs, 13 regressio=
ns (v5.10.168-cip27-638-g0d599cd2b6695)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
beaglebone-black         | arm    | lab-broonie   | gcc-10   | omap2plus_de=
fconfig          | 1          =

qemu_i386-uefi           | i386   | lab-broonie   | gcc-10   | i386_defconf=
ig               | 1          =

qemu_i386-uefi           | i386   | lab-collabora | gcc-10   | i386_defconf=
ig               | 1          =

qemu_x86_64-uefi         | x86_64 | lab-broonie   | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =

qemu_x86_64-uefi         | x86_64 | lab-broonie   | gcc-10   | x86_64_defco=
nfig             | 1          =

qemu_x86_64-uefi         | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =

qemu_x86_64-uefi         | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig             | 1          =

qemu_x86_64-uefi-mixed   | x86_64 | lab-broonie   | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =

qemu_x86_64-uefi-mixed   | x86_64 | lab-broonie   | gcc-10   | x86_64_defco=
nfig             | 1          =

qemu_x86_64-uefi-mixed   | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =

qemu_x86_64-uefi-mixed   | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig             | 1          =

r8a7743-iwg20d-q7        | arm    | lab-cip       | gcc-10   | shmobile_def=
config           | 1          =

r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig   =
                 | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.168-cip27-638-g0d599cd2b6695/plan/baselin=
e/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.168-cip27-638-g0d599cd2b6695
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      0d599cd2b6695e03b8e4b1bdf0c2663d16568070 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
beaglebone-black         | arm    | lab-broonie   | gcc-10   | omap2plus_de=
fconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/640d893682423b9cea8c863d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-638-g0d599cd2b6695/arm/omap2plus_defconfig/gcc=
-10/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-638-g0d599cd2b6695/arm/omap2plus_defconfig/gcc=
-10/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/640d893682423b9cea8c8645
        failing since 66 days (last pass: v5.10.155-cip21-405-g26d566555c3d=
e, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2023-03-12T08:11:17.049054  <8>[   20.334346] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 148372_1.5.2.4.1>
    2023-03-12T08:11:17.156940  / # #
    2023-03-12T08:11:17.259199  export SHELL=3D/bin/sh
    2023-03-12T08:11:17.259797  #
    2023-03-12T08:11:17.361519  / # export SHELL=3D/bin/sh. /lava-148372/en=
vironment
    2023-03-12T08:11:17.362110  =

    2023-03-12T08:11:17.464076  / # . /lava-148372/environment/lava-148372/=
bin/lava-test-runner /lava-148372/1
    2023-03-12T08:11:17.465162  =

    2023-03-12T08:11:17.469936  / # /lava-148372/bin/lava-test-runner /lava=
-148372/1
    2023-03-12T08:11:17.577110  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
qemu_i386-uefi           | i386   | lab-broonie   | gcc-10   | i386_defconf=
ig               | 1          =


  Details:     https://kernelci.org/test/plan/id/640d8790dfa93420758c8660

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: i386_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-638-g0d599cd2b6695/i386/i386_defconfig/gcc-10/=
lab-broonie/baseline-qemu_i386-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-638-g0d599cd2b6695/i386/i386_defconfig/gcc-10/=
lab-broonie/baseline-qemu_i386-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640d8790dfa93420758c8=
661
        new failure (last pass: v5.10.162-cip24-853-g709bb3738fde) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
qemu_i386-uefi           | i386   | lab-collabora | gcc-10   | i386_defconf=
ig               | 1          =


  Details:     https://kernelci.org/test/plan/id/640d878fae68b483758c863f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: i386_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-638-g0d599cd2b6695/i386/i386_defconfig/gcc-10/=
lab-collabora/baseline-qemu_i386-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-638-g0d599cd2b6695/i386/i386_defconfig/gcc-10/=
lab-collabora/baseline-qemu_i386-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640d878fae68b483758c8=
640
        new failure (last pass: v5.10.162-cip24-853-g709bb3738fde) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
qemu_x86_64-uefi         | x86_64 | lab-broonie   | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/640d8679eed6fc298a8c8667

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-638-g0d599cd2b6695/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-broonie/baseline-qemu_x86_64-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-638-g0d599cd2b6695/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-broonie/baseline-qemu_x86_64-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640d8679eed6fc298a8c8=
668
        failing since 18 days (last pass: v5.10.165-cip25-154-gb7e05ba4f61a=
2, first fail: v5.10.167-cip26-2-g1e87e7748b91) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
qemu_x86_64-uefi         | x86_64 | lab-broonie   | gcc-10   | x86_64_defco=
nfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/640d88326b9ccbc7468c8648

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-638-g0d599cd2b6695/x86_64/x86_64_defconfig/gcc=
-10/lab-broonie/baseline-qemu_x86_64-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-638-g0d599cd2b6695/x86_64/x86_64_defconfig/gcc=
-10/lab-broonie/baseline-qemu_x86_64-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640d88326b9ccbc7468c8=
649
        new failure (last pass: v5.10.165-cip25-144-g43e1d8dfbb26) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
qemu_x86_64-uefi         | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/640d86764056c6e8188c8656

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-638-g0d599cd2b6695/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-qemu_x86_64-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-638-g0d599cd2b6695/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-qemu_x86_64-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640d86764056c6e8188c8=
657
        failing since 18 days (last pass: v5.10.165-cip25-154-gb7e05ba4f61a=
2, first fail: v5.10.167-cip26-2-g1e87e7748b91) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
qemu_x86_64-uefi         | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/640d880d17c38645be8c86d3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-638-g0d599cd2b6695/x86_64/x86_64_defconfig/gcc=
-10/lab-collabora/baseline-qemu_x86_64-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-638-g0d599cd2b6695/x86_64/x86_64_defconfig/gcc=
-10/lab-collabora/baseline-qemu_x86_64-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640d880d17c38645be8c8=
6d4
        new failure (last pass: v5.10.165-cip25-144-g43e1d8dfbb26) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
qemu_x86_64-uefi-mixed   | x86_64 | lab-broonie   | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/640d8678b2d5a12f358c8644

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-638-g0d599cd2b6695/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-broonie/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-638-g0d599cd2b6695/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-broonie/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640d8678b2d5a12f358c8=
645
        failing since 18 days (last pass: v5.10.165-cip25-154-gb7e05ba4f61a=
2, first fail: v5.10.167-cip26-2-g1e87e7748b91) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
qemu_x86_64-uefi-mixed   | x86_64 | lab-broonie   | gcc-10   | x86_64_defco=
nfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/640d88307ad6bc59168c864e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-638-g0d599cd2b6695/x86_64/x86_64_defconfig/gcc=
-10/lab-broonie/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-638-g0d599cd2b6695/x86_64/x86_64_defconfig/gcc=
-10/lab-broonie/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640d88307ad6bc59168c8=
64f
        new failure (last pass: v5.10.165-cip25-144-g43e1d8dfbb26) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
qemu_x86_64-uefi-mixed   | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/640d867b645624ec7c8c86c9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-638-g0d599cd2b6695/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-638-g0d599cd2b6695/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640d867b645624ec7c8c8=
6ca
        failing since 18 days (last pass: v5.10.165-cip25-154-gb7e05ba4f61a=
2, first fail: v5.10.167-cip26-2-g1e87e7748b91) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
qemu_x86_64-uefi-mixed   | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/640d880bf8b8f188318c8640

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-638-g0d599cd2b6695/x86_64/x86_64_defconfig/gcc=
-10/lab-collabora/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-638-g0d599cd2b6695/x86_64/x86_64_defconfig/gcc=
-10/lab-collabora/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640d880bf8b8f188318c8=
641
        new failure (last pass: v5.10.165-cip25-144-g43e1d8dfbb26) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
r8a7743-iwg20d-q7        | arm    | lab-cip       | gcc-10   | shmobile_def=
config           | 1          =


  Details:     https://kernelci.org/test/plan/id/640d87ff17c38645be8c862f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-638-g0d599cd2b6695/arm/shmobile_defconfig/gcc-=
10/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-638-g0d599cd2b6695/arm/shmobile_defconfig/gcc-=
10/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640d87ff17c38645be8c8=
630
        new failure (last pass: v5.10.168-cip27-109-g23841ec76bec) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig   =
                 | 1          =


  Details:     https://kernelci.org/test/plan/id/640d8d54c449bed9958c8630

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-638-g0d599cd2b6695/arm64/defconfig/gcc-10/lab-=
cip/baseline-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-638-g0d599cd2b6695/arm64/defconfig/gcc-10/lab-=
cip/baseline-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640d8d54c449bed9958c8=
631
        new failure (last pass: v5.10.168-cip27-86-g19cf8cd2dd993) =

 =20

