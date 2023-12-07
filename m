Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FF0C4167B
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 22:44:51 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web11.106031.1701989090927369023
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 07 Dec 2023 14:44:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=Ww0RkLxL;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.181, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d0b2752dc6so13200265ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 07 Dec 2023 14:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701989090; x=1702593890; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QGZ+D0BoP8r86y/KPbTALh32dSy/naHq/BO4A7ob3Ok=;
        b=Ww0RkLxLP/1Wdp7tkWEMSzDR5CCj+5CppN3iSV67bFzlyQ1qzWnjdpg5vEmichiARI
         B0HcRxSKs/XjRrQZdfu/NImy98YnjCrecLonOsGB36SkQfL3i/L05gzZ2x9ASgS6LbwS
         WYerKmmyVcy2cLltgY/aZzG3KV6zyZk/Nzs40LohNlirNP4Fm6BqDpSnjgF1xZq4Ep8H
         v59hhOkJ8tFDGJqE/eSa6T4j++ZytqtrUT1r/Biu4pwPD7RxUtiQqb8gVQsJhodY5Xf2
         9tLwCMOrYOGkivG2VeG0fnL8ybVmGxfiM1PZIDC8S03c8IY1xJc16eorMyGbm9NSs10R
         zS2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701989090; x=1702593890;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QGZ+D0BoP8r86y/KPbTALh32dSy/naHq/BO4A7ob3Ok=;
        b=na8VMN1jKdDgT+TDn0IKpwxoq55V8LtMvWe1H7+mfo759UXiD3E2VbtMuFIlgh/5iz
         OhvMMfJClMqGQrnVhPMeG6gz4HghwzVHfJ2/FDoLRvge5EZQQwchmwBUhBH7ZESPmXEz
         3nyV0KOzwMYRlffxDNyt0pe4CrC7TnHUr8OkQQC9dedqTdhr73QrEUM5BoHYwJa1OgSQ
         aQKKSRCFNmMAvZ3L2PNlfFVSoWY5JUCC6PLSuy/dXOGvS/KrQjhQaTgAITDzrwpIJQr0
         z8QyVpAyA4Blr7n9+ygq8tZx8a6Lnk8xkwMVc1NyungKMDCuAU9lEGWIcdZcAAGBmhG0
         KK6g==
X-Gm-Message-State: AOJu0Yx17S1aQAXjfvRrn18z6se32mvznluW4Axux9ZalatpOMxQDM1d
	ulq8coyMuON/dyj8Z9CF1fWpIKiheGzlDX4fXz6Dvg==
X-Google-Smtp-Source: AGHT+IH/ygMLm0T19wVW3B9G82IJUl5nuqynUh51xoY8fZwj3O689ja2odb63cBUC+J4p16RiMbz7g==
X-Received: by 2002:a17:902:e882:b0:1d0:b3f5:c318 with SMTP id w2-20020a170902e88200b001d0b3f5c318mr3731666plg.106.1701989089794;
        Thu, 07 Dec 2023 14:44:49 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y16-20020a17090322d000b001d09c5424d4sm319669plg.297.2023.12.07.14.44.49
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 14:44:49 -0800 (PST)
Message-ID: <65724ae1.170a0220.86c67.1efa@mx.google.com>
Date: Thu, 07 Dec 2023 14:44:49 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-63-g2bc5a8583f4a8
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 25 runs,
 22 regressions (v5.10.201-cip41-63-g2bc5a8583f4a8)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 22:44:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13930

cip-gitlab/ci/pavel/linux-test baseline-nfs: 25 runs, 22 regressions (v5.10=
.201-cip41-63-g2bc5a8583f4a8)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
at91sam9g20ek                | arm   | lab-broonie | gcc-10   | at91_dt_def=
config   | 1          =

at91sam9g20ek                | arm   | lab-broonie | gcc-10   | multi_v5_de=
fconfig  | 1          =

beaglebone-black             | arm   | lab-broonie | gcc-10   | omap2plus_d=
efconfig | 1          =

imx6dl-udoo                  | arm   | lab-broonie | gcc-10   | multi_v7_de=
fconfig  | 1          =

imx6q-udoo                   | arm   | lab-broonie | gcc-10   | multi_v7_de=
fconfig  | 1          =

juno-uboot                   | arm64 | lab-broonie | gcc-10   | defconfig  =
         | 10         =

kontron-kbox-a-230-ls        | arm64 | lab-kontron | gcc-10   | defconfig  =
         | 3          =

kontron-sl28-var3-ads2       | arm64 | lab-kontron | gcc-10   | defconfig  =
         | 3          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig  =
         | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.201-cip41-63-g2bc5a8583f4a8/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.201-cip41-63-g2bc5a8583f4a8
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      2bc5a8583f4a8a28f328fe05c444332335079a44 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
at91sam9g20ek                | arm   | lab-broonie | gcc-10   | at91_dt_def=
config   | 1          =


  Details:     https://kernelci.org/test/plan/id/657241e47581d9d0bfe13485

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-g2bc5a8583f4a8/arm/at91_dt_defconfig/gcc-10/lab-broonie=
/baseline-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-g2bc5a8583f4a8/arm/at91_dt_defconfig/gcc-10/lab-broonie=
/baseline-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armel/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/657241e47581d9d0b=
fe13486
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
at91sam9g20ek                | arm   | lab-broonie | gcc-10   | multi_v5_de=
fconfig  | 1          =


  Details:     https://kernelci.org/test/plan/id/65723eece5351569b3e13476

  Results:     48 PASS, 6 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-g2bc5a8583f4a8/arm/multi_v5_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-g2bc5a8583f4a8/arm/multi_v5_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armel/initrd.cpio.gz =



  * baseline-nfs.bootrr.gpio-keys-probed: https://kernelci.org/test/case/id=
/65723eece5351569b3e1347f
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T21:53:33.509698  /lava-320206/1/../bin/lava-test-case
    2023-12-07T21:53:33.609872  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dgpi=
o-keys-probed RESULT=3Dfail>   =

 =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
beaglebone-black             | arm   | lab-broonie | gcc-10   | omap2plus_d=
efconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/657240ef77869d4bcfe13480

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-g2bc5a8583f4a8/arm/omap2plus_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-g2bc5a8583f4a8/arm/omap2plus_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/=
id/657240ef77869d4bcfe1349f
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T22:01:55.767734  /lava-320227/1/../bin/lava-test-case
    2023-12-07T22:01:56.571928  <8>[   77.663201] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =

 =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
imx6dl-udoo                  | arm   | lab-broonie | gcc-10   | multi_v7_de=
fconfig  | 1          =


  Details:     https://kernelci.org/test/plan/id/657244ef0892b8f18be13476

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-g2bc5a8583f4a8/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-g2bc5a8583f4a8/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/657244ef0892b8f18=
be13477
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
imx6q-udoo                   | arm   | lab-broonie | gcc-10   | multi_v7_de=
fconfig  | 1          =


  Details:     https://kernelci.org/test/plan/id/6572454b06ff50bbb7e13477

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-g2bc5a8583f4a8/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-g2bc5a8583f4a8/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6572454b06ff50bbb=
7e13478
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
juno-uboot                   | arm64 | lab-broonie | gcc-10   | defconfig  =
         | 10         =


  Details:     https://kernelci.org/test/plan/id/65724310dd49746d89e13484

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-g2bc5a8583f4a8/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-nfs-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-g2bc5a8583f4a8/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-nfs-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.led7-probed: https://kernelci.org/test/case/id/6572=
4310dd49746d89e13495
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T22:11:20.458433  /lava-320286/1/../bin/lava-test-case
    2023-12-07T22:11:20.501059  <8>[   59.297948] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled7-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led6-probed: https://kernelci.org/test/case/id/6572=
4310dd49746d89e13496
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T22:11:19.374443  /lava-320286/1/../bin/lava-test-case
    2023-12-07T22:11:19.419395  <8>[   58.216076] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled6-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led5-probed: https://kernelci.org/test/case/id/6572=
4310dd49746d89e13497
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T22:11:18.295455  /lava-320286/1/../bin/lava-test-case
    2023-12-07T22:11:18.335431  <8>[   57.132002] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled5-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led4-probed: https://kernelci.org/test/case/id/6572=
4310dd49746d89e13498
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T22:11:17.213587  /lava-320286/1/../bin/lava-test-case
    2023-12-07T22:11:17.256521  <8>[   56.053131] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled4-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led3-probed: https://kernelci.org/test/case/id/6572=
4310dd49746d89e13499
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T22:11:16.131522  /lava-320286/1/../bin/lava-test-case
    2023-12-07T22:11:16.174679  <8>[   54.971610] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled3-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led2-probed: https://kernelci.org/test/case/id/6572=
4310dd49746d89e1349a
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T22:11:15.052593  /lava-320286/1/../bin/lava-test-case
    2023-12-07T22:11:15.092211  <8>[   53.889439] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled2-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led1-probed: https://kernelci.org/test/case/id/6572=
4310dd49746d89e1349b
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T22:11:13.975590  /lava-320286/1/../bin/lava-test-case
    2023-12-07T22:11:14.013695  <8>[   52.810369] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled1-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led0-probed: https://kernelci.org/test/case/id/6572=
4310dd49746d89e1349c
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T22:11:12.867979  /lava-320286/1/../bin/lava-test-case
    2023-12-07T22:11:12.920842  <8>[   51.717745] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled0-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.iommu1-probed: https://kernelci.org/test/case/id/65=
724310dd49746d89e134af
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T22:11:10.603176  /lava-320286/1/../bin/lava-test-case
    2023-12-07T22:11:10.651030  <8>[   49.450793] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Diommu1-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.1c050000_mmc-probed: https://kernelci.org/test/case=
/id/65724310dd49746d89e134bc
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T22:11:08.667004  /lava-320286/1/../bin/lava-test-case
    2023-12-07T22:11:08.709932  <8>[   47.506508] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3D1c050000.mmc-probed RESULT=3Dfail>   =

 =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
kontron-kbox-a-230-ls        | arm64 | lab-kontron | gcc-10   | defconfig  =
         | 3          =


  Details:     https://kernelci.org/test/plan/id/6572416bee748b6c97e13493

  Results:     89 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-g2bc5a8583f4a8/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-nfs-kontron-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-g2bc5a8583f4a8/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-nfs-kontron-kbox-a-230-ls.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rcpm-driver-present: https://kernelci.org/test/case=
/id/6572416bee748b6c97e134d3
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T22:04:01.765093  <8>[   18.733259] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dpci-host-generic-probed RESULT=3Dpass>
    2023-12-07T22:04:02.771099  /lava-403055/1/../bin/lava-test-case
    2023-12-07T22:04:02.796806  <8>[   19.767559] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.ftm-alarm-driver-present: https://kernelci.org/test=
/case/id/6572416bee748b6c97e134d4
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T22:04:03.802826  /lava-403055/1/../bin/lava-test-case
    2023-12-07T22:04:03.832788  <8>[   20.803375] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2023-12-07T22:04:04.838656  /lava-403055/1/../bin/lava-test-case
    2023-12-07T22:04:04.870490  <8>[   21.842215] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dftm-alarm-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.layerscape-sfp-driver-present: https://kernelci.org=
/test/case/id/6572416bee748b6c97e134eb
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T22:04:07.718363  /lava-403055/1/../bin/lava-test-case
    2023-12-07T22:04:07.745328  <8>[   24.716110] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =

 =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
kontron-sl28-var3-ads2       | arm64 | lab-kontron | gcc-10   | defconfig  =
         | 3          =


  Details:     https://kernelci.org/test/plan/id/6572413062aaab0300e134b5

  Results:     97 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-g2bc5a8583f4a8/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-nfs-kontron-sl28-var3-ads2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-g2bc5a8583f4a8/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-nfs-kontron-sl28-var3-ads2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rcpm-driver-present: https://kernelci.org/test/case=
/id/6572413062aaab0300e134fc
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T22:03:14.687549  /lava-403052/1/../bin/lava-test-case
    2023-12-07T22:03:14.708261  <8>[   16.734995] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.ftm-alarm-driver-present: https://kernelci.org/test=
/case/id/6572413062aaab0300e134fd
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T22:03:15.714865  /lava-403052/1/../bin/lava-test-case
    2023-12-07T22:03:15.742640  <8>[   17.770809] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2023-12-07T22:03:16.749461  /lava-403052/1/../bin/lava-test-case
    2023-12-07T22:03:16.776268  <8>[   18.803602] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dftm-alarm-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.layerscape-sfp-driver-present: https://kernelci.org=
/test/case/id/6572413062aaab0300e13512
        failing since 1 day (last pass: v6.1.64-cip10-rt5, first fail: v5.1=
0.201-cip41-16-g3c85fba3b6e5d)

    2023-12-07T22:03:19.570180  /lava-403052/1/../bin/lava-test-case
    2023-12-07T22:03:19.595053  <8>[   21.622912] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =

 =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig  =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/65724291fa6fe22542e13506

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-g2bc5a8583f4a8/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-g2bc5a8583f4a8/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65724291fa6fe2254=
2e13507
        failing since 0 day (last pass: v5.10.201-cip41-16-g3c85fba3b6e5d, =
first fail: v5.10.201-cip41-28-g38e219eb6aa85) =

 =20

