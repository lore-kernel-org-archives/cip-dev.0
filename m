Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D2BC7EE37
	for <webhook@archiver.kernel.org>; Fri,  3 Mar 2023 20:28:00 +0000 (UTC)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
 by mx.groups.io with SMTP id smtpd.web10.1958.1677875271654807819
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 03 Mar 2023 12:27:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=7aTcFg8D;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.53, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f53.google.com with SMTP id cp7-20020a17090afb8700b0023756229427so7351935pjb.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 03 Mar 2023 12:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1677875271;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Vifkp9jvCRxojgMfythrgOHyxtDXU3UJoiVInujVkyU=;
        b=7aTcFg8D5A1Ndx3kiTmcxFuENq6Vx9LUptW6yAhcxqLc/mCpVbsYohAF18+dXUCd4E
         vRSM/RbcZuwbg0NGymyKoCAg0uVpyHA6b6yR7vP9IRGVbRgvSyGsXLtOttXRfNo0LcW9
         Dd0V0JrBIeylHZByBpjn5Z4+1ZVMv8tryuiIxNOn5Shog2Tn1PekvSyW1PjWIWWqpF5R
         If/2X71hIOukDQhYUpm8SDpMpTmidelhX/GQ10xMrN4QoKTay3yPgH9IZ5FLK0oeSbEh
         7QDLyvYker7NY1UiyeT3i6Zt/UkRIuESqolfkxdK7xAmccmQ9CFpIii843o7GdukkPmN
         Is9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677875271;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vifkp9jvCRxojgMfythrgOHyxtDXU3UJoiVInujVkyU=;
        b=NfpgcNvAPd6DvP4kyVnTzuBPmeuc4Bzj6KCTp51KiNLKEPFp6dgBCkeFtm9mc5GfWK
         ApxWESx9qan1w38xGOpgnl6GiBQaVailhVJqJL4gRB0B427P5umkzk5XDf8DYWD/+1Q1
         V5vk3LaPeeWj1QtYb3G2sVWTVstN5KazMBOD25abUodBiTfzUb+/+Dw0zaK+ZMYcmiUL
         w34hShNowRm3J6nEnqx9qGE2gB6aMWxL4JQhluSSQSf4io1Nqs5xelpJ/0WoaQmemChQ
         6w2VLH9hVDWxgS/iy+bx4k9VJyZ3NDpDCZsdSrNTLy7QE7QtVEe2vw18mwVsfuL1m06n
         jEVA==
X-Gm-Message-State: AO0yUKWuvobz5Xf5T6M/WIJMhqOer/V2LsAZtl/w8lWTq7Ek06iHFIPN
	HcHYd/rCjeZCcHaIDaCMlJdqDSChA3TzHW3AHx0gWw==
X-Google-Smtp-Source: AK7set9JcacYNRAMzO8knQiw108v5GFpw9fS4mQsOLtA0jx2tnaY/9K/n0TUUjbrgx6yr56hbz/QcA==
X-Received: by 2002:a17:902:c412:b0:19c:be03:d18b with SMTP id k18-20020a170902c41200b0019cbe03d18bmr4276587plk.22.1677875270497;
        Fri, 03 Mar 2023 12:27:50 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id jx15-20020a170903138f00b0019468fe44d3sm1925691plb.25.2023.03.03.12.27.49
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 12:27:50 -0800 (PST)
Message-ID: <64025846.170a0220.d8a24.4761@mx.google.com>
Date: Fri, 03 Mar 2023 12:27:50 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.168-cip27-109-g23841ec76bec
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 142 runs,
 7 regressions (v5.10.168-cip27-109-g23841ec76bec)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Mar 2023 20:28:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10923

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 142 runs, 7 regression=
s (v5.10.168-cip27-109-g23841ec76bec)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
beaglebone-black       | arm    | lab-broonie   | gcc-10   | omap2plus_defc=
onfig          | 1          =

odroid-xu3             | arm    | lab-collabora | gcc-10   | exynos_defconf=
ig             | 1          =

qemu_i386-uefi         | i386   | lab-broonie   | gcc-10   | i386_defconfig=
               | 1          =

qemu_x86_64-uefi       | x86_64 | lab-broonie   | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =

qemu_x86_64-uefi       | x86_64 | lab-broonie   | gcc-10   | x86_64_defconf=
ig             | 1          =

qemu_x86_64-uefi-mixed | x86_64 | lab-broonie   | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =

qemu_x86_64-uefi-mixed | x86_64 | lab-broonie   | gcc-10   | x86_64_defconf=
ig             | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.168-cip27-109-g23841ec76bec/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.168-cip27-109-g23841ec76bec
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      23841ec76bec7ddf00658918b23753dc2ca930ce =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
beaglebone-black       | arm    | lab-broonie   | gcc-10   | omap2plus_defc=
onfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6402514202b6af4f118c8664

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-109-g23841ec76bec/arm/omap2plus_defconfig/gcc-=
10/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-109-g23841ec76bec/arm/omap2plus_defconfig/gcc-=
10/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230224.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6402514202b6af4f118c866d
        failing since 58 days (last pass: v5.10.155-cip21-405-g26d566555c3d=
e, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2023-03-03T19:57:41.551076  <8>[   20.374051] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 93692_1.5.2.4.1>
    2023-03-03T19:57:41.663624  / # #
    2023-03-03T19:57:41.765055  export SHELL=3D/bin/sh
    2023-03-03T19:57:41.765658  #
    2023-03-03T19:57:41.867191  / # export SHELL=3D/bin/sh. /lava-93692/env=
ironment
    2023-03-03T19:57:41.867522  =

    2023-03-03T19:57:41.969011  / # . /lava-93692/environment/lava-93692/bi=
n/lava-test-runner /lava-93692/1
    2023-03-03T19:57:41.969988  =

    2023-03-03T19:57:41.974381  / # /lava-93692/bin/lava-test-runner /lava-=
93692/1
    2023-03-03T19:57:42.081808  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
odroid-xu3             | arm    | lab-collabora | gcc-10   | exynos_defconf=
ig             | 1          =


  Details:     https://kernelci.org/test/plan/id/64024bdc15f001c97d8c8648

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: exynos_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-109-g23841ec76bec/arm/exynos_defconfig/gcc-10/=
lab-collabora/baseline-odroid-xu3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-109-g23841ec76bec/arm/exynos_defconfig/gcc-10/=
lab-collabora/baseline-odroid-xu3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230224.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64024bdc15f001c97d8c8=
649
        new failure (last pass: v5.10.168-cip27-86-g19cf8cd2dd993) =

 =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
qemu_i386-uefi         | i386   | lab-broonie   | gcc-10   | i386_defconfig=
               | 1          =


  Details:     https://kernelci.org/test/plan/id/64024d351942e4b2908c8637

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: i386_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-109-g23841ec76bec/i386/i386_defconfig/gcc-10/l=
ab-broonie/baseline-qemu_i386-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-109-g23841ec76bec/i386/i386_defconfig/gcc-10/l=
ab-broonie/baseline-qemu_i386-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230224.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64024d351942e4b2908c8=
638
        failing since 9 days (last pass: v5.10.165-cip25-154-gb7e05ba4f61a2=
, first fail: v5.10.167-cip26-2-g1e87e7748b91) =

 =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
qemu_x86_64-uefi       | x86_64 | lab-broonie   | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64024dd63ead9e6f0d8c8659

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-109-g23841ec76bec/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-broonie/baseline-qemu_x86_64-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-109-g23841ec76bec/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-broonie/baseline-qemu_x86_64-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230224.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64024dd63ead9e6f0d8c8=
65a
        failing since 9 days (last pass: v5.10.165-cip25-154-gb7e05ba4f61a2=
, first fail: v5.10.167-cip26-2-g1e87e7748b91) =

 =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
qemu_x86_64-uefi       | x86_64 | lab-broonie   | gcc-10   | x86_64_defconf=
ig             | 1          =


  Details:     https://kernelci.org/test/plan/id/64025042531d2c50658c8683

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-109-g23841ec76bec/x86_64/x86_64_defconfig/gcc-=
10/lab-broonie/baseline-qemu_x86_64-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-109-g23841ec76bec/x86_64/x86_64_defconfig/gcc-=
10/lab-broonie/baseline-qemu_x86_64-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230224.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64025042531d2c50658c8=
684
        failing since 9 days (last pass: v5.10.165-cip25-154-gb7e05ba4f61a2=
, first fail: v5.10.167-cip26-2-g1e87e7748b91) =

 =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
qemu_x86_64-uefi-mixed | x86_64 | lab-broonie   | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64024dc1d29917946e8c8634

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-109-g23841ec76bec/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-broonie/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-109-g23841ec76bec/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-broonie/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230224.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64024dc1d29917946e8c8=
635
        failing since 9 days (last pass: v5.10.165-cip25-154-gb7e05ba4f61a2=
, first fail: v5.10.167-cip26-2-g1e87e7748b91) =

 =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
qemu_x86_64-uefi-mixed | x86_64 | lab-broonie   | gcc-10   | x86_64_defconf=
ig             | 1          =


  Details:     https://kernelci.org/test/plan/id/640250438865ffa0f38c862f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-109-g23841ec76bec/x86_64/x86_64_defconfig/gcc-=
10/lab-broonie/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-109-g23841ec76bec/x86_64/x86_64_defconfig/gcc-=
10/lab-broonie/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230224.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640250438865ffa0f38c8=
630
        failing since 9 days (last pass: v5.10.165-cip25-154-gb7e05ba4f61a2=
, first fail: v5.10.167-cip26-2-g1e87e7748b91) =

 =20

