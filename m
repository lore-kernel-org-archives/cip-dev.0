Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9FEC6FD1D
	for <webhook@archiver.kernel.org>; Tue,  4 Apr 2023 10:48:11 +0000 (UTC)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
 by mx.groups.io with SMTP id smtpd.web10.98021.1680605288494598815
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 04 Apr 2023 03:48:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=mOr3QLzc;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.47, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f47.google.com with SMTP id qe8-20020a17090b4f8800b0023f07253a2cso33476813pjb.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 04 Apr 2023 03:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1680605288;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Gk+Cxx32uf360ILJXndLrGXkd7CD+MFTUb5tCWPTzQ8=;
        b=mOr3QLzcElb3e6Qwi0K3xTxhmyNrpdQ8wtwMaDH9zhI+VJ8j28CbO+qpOBGULKcXKW
         bA0ab3l4IYHFrQCFzAtg+S9gPeVlFLrLW87EvXSNAH+hc4jQEw9kJM1cTLYdYpaiLf3r
         f9dlMRE/WaG3T9jdNJ+EiNZc7f/IAiBEs/4tebviqy8F2uVTjeevN3JTW5bctnqzxOCl
         C+mJhvvIbPvYTgYQmMTrYDiV6c96RZfUnh9z5r3eErTwZxLbEVRcAQdTGsTccDCyI5G6
         lMn73gzkczX2mRLXxj/ipDv18UCldV7FFnQpFGH9KozmDXjLViuSmM6IqefuL2dgrU4K
         C8bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680605288;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gk+Cxx32uf360ILJXndLrGXkd7CD+MFTUb5tCWPTzQ8=;
        b=TLQd2Pk8yPU4WjkZO1vscH2qzgn/iXU3YJsSm5UYJoccBj7w7hOwoJUzNEz+5jaETr
         fX0E1Oqwl/RTetI03eW6hsSDFhtPJV572Ekr9qknPAHGnsPVSfrBDvPW/hosPBKD/TZ7
         raEeKvkk3J6RA2U01FpgIG7xiIjyamSAcyQYN1fm31t8DSzEzdgLFtiaEaKS0Qt5ccN1
         FtCupUAZUI2i9YbOnyExy4C752T95g8cg0hJYyUNZx5g//QvvuMLy2444MTrHMIuqEoH
         6SkKer3XmonyRPgydmY2JcQdLyntCe2tohfhEgEl/2E69jiUm5BO1nKS2BJRnSFRY9ls
         PL6g==
X-Gm-Message-State: AAQBX9fU3cWmXHCyaRTWfLkXt5J3pg6YJRgk4Q+LEM5nu58WK2V7IE4R
	HCC2lLqXM+OZTABQowi4bYkbX1crQhLs2KJKNAybeQ==
X-Google-Smtp-Source: AKy350ZpHeYDQfLRmhMqoqw6fb69x51UeL9mTuWTmyDyqj0UmMoM4NcgUqCaLGKsWaFe7PB1gSEdjw==
X-Received: by 2002:a05:6a20:4c29:b0:e3:763e:555 with SMTP id fm41-20020a056a204c2900b000e3763e0555mr1583159pzb.57.1680605286630;
        Tue, 04 Apr 2023 03:48:06 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x47-20020a056a000bef00b005ded4825201sm8552064pfu.112.2023.04.04.03.48.06
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 03:48:06 -0700 (PDT)
Message-ID: <642c0066.050a0220.44e1b.0c07@mx.google.com>
Date: Tue, 04 Apr 2023 03:48:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip74-rt43
Subject: cip-gitlab/ci/pavel/linux-test baseline: 60 runs,
 69 regressions (v4.4.302-cip74-rt43)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Apr 2023 10:48:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11164

cip-gitlab/ci/pavel/linux-test baseline: 60 runs, 69 regressions (v4.4.302-=
cip74-rt43)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

bcm2835-rpi-b-rev2           | arm    | lab-broonie     | gcc-10   | bcm283=
5_defconfig            | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 8          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 15         =

dell-latitude...4305U-sarien | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

dell-latitude...8665U-sarien | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx28-duckbill               | arm    | lab-pengutronix | gcc-10   | mxs_de=
fconfig                | 1          =

odroid-xu3                   | arm    | lab-collabora   | gcc-10   | exynos=
_defconfig             | 1          =

qemu_arm-virt-gicv2          | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =

qemu_arm-virt-gicv2          | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =

qemu_arm-virt-gicv2-uefi     | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =

qemu_arm-virt-gicv2-uefi     | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =

qemu_arm-virt-gicv3          | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =

qemu_arm-virt-gicv3          | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =

qemu_arm-virt-gicv3-uefi     | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =

qemu_arm-virt-gicv3-uefi     | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =

qemu_x86_64-uefi-mixed       | x86_64 | lab-broonie     | gcc-10   | x86_64=
_defconfig             | 1          =

qemu_x86_64-uefi-mixed       | x86_64 | lab-broonie     | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

qemu_x86_64-uefi-mixed       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig             | 1          =

qemu_x86_64-uefi-mixed       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

rk3288-rock2-square          | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 2          =

rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 21         =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip74-rt43/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip74-rt43
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      22456e8b8d35c6bd1313511bfa4dd945ce7a0c1e =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/642bf96a306f07b97e79e925

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230324.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/642bf96a306f07b97e79e=
926
        new failure (last pass: v5.10.175-cip29-rt12) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/642bf9773c00286a3279e95b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230324.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/642bf9773c00286a3279e=
95c
        failing since 13 days (last pass: v5.10.168-cip27-456-g42a59c4e5329=
, first fail: v4.19.277-cip94-1098-g26d9f86d942d) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/642bf96c306f07b97e79e92b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230324.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/642bf96c306f07b97e79e=
92c
        new failure (last pass: v5.10.175-cip29-rt12) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/642bf9723c00286a3279e922

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230324.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/642bf9723c00286a3279e=
923
        failing since 13 days (last pass: v5.10.168-cip27-456-g42a59c4e5329=
, first fail: v4.19.277-cip94-1098-g26d9f86d942d) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
bcm2835-rpi-b-rev2           | arm    | lab-broonie     | gcc-10   | bcm283=
5_defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/642bf6369603c315ce79ee6a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/arm/bcm2835_defconfig/gcc-10/lab-broonie/baseline-bcm2=
835-rpi-b-rev2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/arm/bcm2835_defconfig/gcc-10/lab-broonie/baseline-bcm2=
835-rpi-b-rev2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230324.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/642bf6369603c315ce79e=
e6b
        new failure (last pass: v5.10.175-cip29-rt12) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 8          =


  Details:     https://kernelci.org/test/plan/id/642bf8bbae37c805b579e924

  Results:     15 PASS, 21 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-bea=
glebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-bea=
glebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230324.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.simple-audio-driver-present: https://kernelci.org/test/=
case/id/642bf8bbae37c805b579e928
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:14:50.312899  /opt/bootrr/libexec/bootrr/boards/ti,am335x=
-bone-black: line 84: assert_device-present: not found
    2023-04-04T10:14:51.321553  /lava-272401/1/../bin/lava-test-case
    2023-04-04T10:14:51.338553  [   51.919257] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsimple-audio-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/test/=
case/id/642bf8bbae37c805b579e935
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:14:32.426057  /lava-272401/1/../bin/lava-test-case
    2023-04-04T10:14:32.442715  [   33.022854] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2023-04-04T10:14:33.467208  /lava-272401/1/../bin/lava-test-case
    2023-04-04T10:14:33.484400  [   34.063909] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.am335x-phy-driver-present: https://kernelci.org/test/ca=
se/id/642bf8bbae37c805b579e939
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:14:27.139810  /lava-272401/1/../bin/lava-test-case
    2023-04-04T10:14:27.157109  [   27.736661] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dusb0-musb-dsps-probed RESULT=3Dblocked>
    2023-04-04T10:14:28.181415  /lava-272401/1/../bin/lava-test-case
    2023-04-04T10:14:28.199210  [   28.778377] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dusb1-musb-dsps-probed RESULT=3Dblocked>
    2023-04-04T10:14:29.223147  /lava-272401/1/../bin/lava-test-case
    2023-04-04T10:14:29.240656  [   29.819931] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dam335x-phy-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.musb-dsps-driver-present: https://kernelci.org/test/cas=
e/id/642bf8bbae37c805b579e93a
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:14:24.017052  /lava-272401/1/../bin/lava-test-case
    2023-04-04T10:14:24.033934  [   24.613701] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmmc0-probed RESULT=3Dblocked>
    2023-04-04T10:14:25.057940  /lava-272401/1/../bin/lava-test-case
    2023-04-04T10:14:25.074054  [   25.654586] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmmc1-probed RESULT=3Dblocked>
    2023-04-04T10:14:26.097406  /lava-272401/1/../bin/lava-test-case
    2023-04-04T10:14:26.115361  [   26.695069] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmusb-dsps-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sdhci-omap-driver-present: https://kernelci.org/test/ca=
se/id/642bf8bbae37c805b579e93b
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:14:22.975371  /lava-272401/1/../bin/lava-test-case
    2023-04-04T10:14:22.993243  [   23.572096] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsdhci-omap-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.tps65217-driver-present: https://kernelci.org/test/case=
/id/642bf8bbae37c805b579e941
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:14:18.675552  /lava-272401/1/../bin/lava-test-case
    2023-04-04T10:14:18.693312  [   19.271524] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtps65217-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.omap8240-driver-present: https://kernelci.org/test/case=
/id/642bf8bbae37c805b579e945
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:14:16.471229  /lava-272401/1/../bin/lava-test-case
    2023-04-04T10:14:16.488645  [   17.067892] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap8240-driver-present RESULT=3Dfail>   =


  * baseline.dmesg.crit: https://kernelci.org/test/case/id/642bf8bbae37c805=
b579e94c
        new failure (last pass: v5.10.175-cip29-rt12)
        1 lines

    2023-04-04T10:14:13.968410  / # =

    2023-04-04T10:14:13.978263  =

    2023-04-04T10:14:14.107747  / # #
    2023-04-04T10:14:14.117878  #
    2023-04-04T10:14:14.228390  / # export SHELL=3D/bin/sh
    2023-04-04T10:14:14.238174  export SHELL=3D/bin/sh
    2023-04-04T10:14:14.345496  / # . /lava-272401/environment
    2023-04-04T10:14:14.355295  . /lava-272401/environment
    2023-04-04T10:14:14.463216  / # /lava-272401/bin/lava-test-runner /lava=
-272401/0
    2023-04-04T10:14:14.476798  /lava-272401/bin/lava-test-runner /lava-272=
401/0 =

    ... (9 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 15         =


  Details:     https://kernelci.org/test/plan/id/642bf69a22fe5814b379e95e

  Results:     24 PASS, 17 FAIL, 2 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-be=
aglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-be=
aglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230324.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.hdmi-audio: https://kernelci.org/test/case/id/642bf69a2=
2fe5814b379e961
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:05:57.096627  /lava-272349/1/../bin/lava-test-case
    2023-04-04T10:05:57.140558  [   79.949620] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio-probed RESULT=3Dblocked>
    2023-04-04T10:05:58.207848  /lava-272349/1/../bin/lava-test-case
    2023-04-04T10:05:58.287895  [   81.097661] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline.bootrr.simple-audio-driver-present: https://kernelci.org/test/=
case/id/642bf69a22fe5814b379e962
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:05:54.779015  /opt/bootrr/libexec/bootrr/boards/ti,am335x=
-bone-black: line 84: assert_device-present: not found
    2023-04-04T10:05:55.888748  /lava-272349/1/../bin/lava-test-case
    2023-04-04T10:05:55.971989  [   78.780172] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsimple-audio-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-codec-driver-present: https://kernelci.org/test/ca=
se/id/642bf69a22fe5814b379e963
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:05:53.469062  /lava-272349/1/../bin/lava-test-case
    2023-04-04T10:05:53.550357  [   76.359424] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-04-04T10:05:54.675766  /lava-272349/1/../bin/lava-test-case
    2023-04-04T10:05:54.758276  [   77.566621] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case/id/=
642bf69a22fe5814b379e964
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:05:51.057731  /lava-272349/1/../bin/lava-test-case
    2023-04-04T10:05:51.138323  [   73.947340] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-04-04T10:05:52.096828  [   74.901130] udevd[108]: worker [111] /de=
vices/platform/ocp/47400000.usb/47401c00.usb/musb-hdrc.1.auto/usb1 is takin=
g a long time
    2023-04-04T10:05:52.263185  /lava-272349/1/../bin/lava-test-case
    2023-04-04T10:05:52.342902  [   75.151711] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline.bootrr.tda19988-driver-present: https://kernelci.org/test/case=
/id/642bf69a22fe5814b379e965
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:05:48.648319  /lava-272349/1/../bin/lava-test-case
    2023-04-04T10:05:48.728155  [   71.537275] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-04-04T10:05:49.852094  /lava-272349/1/../bin/lava-test-case
    2023-04-04T10:05:49.931903  [   72.740369] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.tilcdc-driver-probed: https://kernelci.org/test/case/id=
/642bf69a22fe5814b379e966
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:05:47.442477  /lava-272349/1/../bin/lava-test-case
    2023-04-04T10:05:47.522253  [   70.330789] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtilcdc-driver-probed RESULT=3Dfail>   =


  * baseline.bootrr.omap-sham-driver-present: https://kernelci.org/test/cas=
e/id/642bf69a22fe5814b379e96b
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:05:44.604967  /lava-272349/1/../bin/lava-test-case
    2023-04-04T10:05:44.685570  [   67.493592] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap-sham-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.omap-aes-driver-present: https://kernelci.org/test/case=
/id/642bf69a22fe5814b379e96e
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:05:41.974755  /lava-272349/1/../bin/lava-test-case
    2023-04-04T10:05:42.054104  [   64.862372] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap-aes-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/test/=
case/id/642bf69a22fe5814b379e971
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:05:38.230207  /lava-272349/1/../bin/lava-test-case
    2023-04-04T10:05:38.312899  [   61.121115] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2023-04-04T10:05:39.439238  /lava-272349/1/../bin/lava-test-case
    2023-04-04T10:05:39.521364  [   62.329223] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/642bf69a22fe5814b379e972
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:05:37.130698  /lava-272349/1/../bin/lava-test-case
    2023-04-04T10:05:37.169652  [   59.977520] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sdhci-omap-driver-present: https://kernelci.org/test/ca=
se/id/642bf69a22fe5814b379e97a
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:05:31.559764  /lava-272349/1/../bin/lava-test-case
    2023-04-04T10:05:31.642971  [   54.450367] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dbaseboard-eeprom-probed RESULT=3Dblocked>
    2023-04-04T10:05:32.768372  /lava-272349/1/../bin/lava-test-case
    2023-04-04T10:05:32.849167  [   55.656928] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsdhci-omap-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.at24-driver-present: https://kernelci.org/test/case/id/=
642bf69a22fe5814b379e97b
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:05:30.352927  /lava-272349/1/../bin/lava-test-case
    2023-04-04T10:05:30.433815  [   53.241687] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dat24-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.pwrbutton-driver-present: https://kernelci.org/test/cas=
e/id/642bf69a22fe5814b379e97e
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:05:27.764276  /lava-272349/1/../bin/lava-test-case
    2023-04-04T10:05:27.845050  [   50.652426] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dpwrbutton-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.omap8240-driver-present: https://kernelci.org/test/case=
/id/642bf69a22fe5814b379e984
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:05:24.834400  /lava-272349/1/../bin/lava-test-case
    2023-04-04T10:05:24.913815  [   47.721406] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap8240-driver-present RESULT=3Dfail>   =


  * baseline.dmesg.crit: https://kernelci.org/test/case/id/642bf69a22fe5814=
b379e98b
        new failure (last pass: v5.10.175-cip29-rt12)
        1 lines

    2023-04-04T10:05:21.438544  / # =

    2023-04-04T10:05:21.445761  =

    2023-04-04T10:05:21.549803  / # #
    2023-04-04T10:05:21.555976  #
    2023-04-04T10:05:21.657902  / # export SHELL=3D/bin/sh
    2023-04-04T10:05:21.664036  export SHELL=3D/bin/sh
    2023-04-04T10:05:21.765607  / # . /lava-272349/environment
    2023-04-04T10:05:21.771817  . /lava-272349/environment
    2023-04-04T10:05:21.873547  / # /lava-272349/bin/lava-test-runner /lava=
-272349/0
    2023-04-04T10:05:21.878526  /lava-272349/bin/lava-test-runner /lava-272=
349/0 =

    ... (9 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
dell-latitude...4305U-sarien | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/642bf97e3c00286a3279e96f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-dell-latitude-5400-4305U-sarien.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-dell-latitude-5400-4305U-sarien.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230324.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/642bf97e3c00286a3279e=
970
        failing since 12 days (last pass: v4.19.277-cip94-1098-g26d9f86d942=
d, first fail: v5.10.175-cip29-rt12) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
dell-latitude...8665U-sarien | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/642bf969306f07b97e79e922

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-dell-latitude-5400-8665U-sarien.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-dell-latitude-5400-8665U-sarien.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230324.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/642bf969306f07b97e79e=
923
        failing since 12 days (last pass: v4.19.277-cip94-1098-g26d9f86d942=
d, first fail: v5.10.175-cip29-rt12) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/642bfa81988010288379e964

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230324.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/642bfa81988010288379e=
965
        new failure (last pass: v5.10.175-cip29-rt12) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/642bf96d909fed10bf79e944

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230324.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/642bf96d909fed10bf79e=
945
        new failure (last pass: v5.10.175-cip29-rt12) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx28-duckbill               | arm    | lab-pengutronix | gcc-10   | mxs_de=
fconfig                | 1          =


  Details:     https://kernelci.org/test/plan/id/642bf47396dedfb59c79e93a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: mxs_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/arm/mxs_defconfig/gcc-10/lab-pengutronix/baseline-imx2=
8-duckbill.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/arm/mxs_defconfig/gcc-10/lab-pengutronix/baseline-imx2=
8-duckbill.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230324.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/642bf47396dedfb59c79e=
93b
        new failure (last pass: v5.10.175-cip29-rt12) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
odroid-xu3                   | arm    | lab-collabora   | gcc-10   | exynos=
_defconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/642bf9f43c8d40940d79e9fb

  Results:     4 PASS, 1 FAIL, 2 SKIP
  Full config: exynos_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/arm/exynos_defconfig/gcc-10/lab-collabora/baseline-odr=
oid-xu3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/arm/exynos_defconfig/gcc-10/lab-collabora/baseline-odr=
oid-xu3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230324.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.all-cpus-are-online: https://kernelci.org/test/case/id/=
642bf9f43c8d40940d79e9ff
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:20:26.489656  /lava-9858007/1/../bin/lava-test-case

    2023-04-04T10:20:26.505285  [   44.335957] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dall-cpus-are-online RESULT=3Dfail>
   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm-virt-gicv2          | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/642bf7885cc792467479e997

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-qem=
u_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-qem=
u_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230324.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/642bf7885cc792467479e=
998
        new failure (last pass: v5.10.175-cip29-rt12) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm-virt-gicv2          | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/642bf76a9561d1a0c679e936

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-q=
emu_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-q=
emu_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230324.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/642bf76a9561d1a0c679e=
937
        new failure (last pass: v5.10.175-cip29-rt12) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm-virt-gicv2-uefi     | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/642bf879419e2ffed679e92a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-qem=
u_arm-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-qem=
u_arm-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230324.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/642bf879419e2ffed679e=
92b
        new failure (last pass: v5.10.175-cip29-rt12) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm-virt-gicv2-uefi     | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/642bf8463d6de58a6d79e92e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-q=
emu_arm-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-q=
emu_arm-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230324.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/642bf8463d6de58a6d79e=
92f
        new failure (last pass: v5.10.175-cip29-rt12) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm-virt-gicv3          | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/642bf7895cc792467479e9a5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-qem=
u_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-qem=
u_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230324.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/642bf7895cc792467479e=
9a6
        new failure (last pass: v5.10.175-cip29-rt12) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm-virt-gicv3          | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/642bf7659561d1a0c679e928

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-q=
emu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-q=
emu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230324.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/642bf7659561d1a0c679e=
929
        new failure (last pass: v5.10.175-cip29-rt12) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm-virt-gicv3-uefi     | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/642bf8f0d48cbf123579e930

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-qem=
u_arm-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-qem=
u_arm-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230324.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/642bf8f0d48cbf123579e=
931
        new failure (last pass: v5.10.175-cip29-rt12) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm-virt-gicv3-uefi     | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/642bf8553d6de58a6d79e93a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-q=
emu_arm-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-q=
emu_arm-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230324.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/642bf8553d6de58a6d79e=
93b
        new failure (last pass: v5.10.175-cip29-rt12) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-broonie     | gcc-10   | x86_64=
_defconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/642bf9a5b6805562f979e922

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig/gcc-10/lab-broonie/baseline-qe=
mu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig/gcc-10/lab-broonie/baseline-qe=
mu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230324.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/642bf9a5b6805562f979e=
923
        new failure (last pass: v5.10.175-cip29-rt12) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-broonie     | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/642bf9ccf22e3d53f779e964

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-broo=
nie/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-broo=
nie/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230324.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/642bf9ccf22e3d53f779e=
965
        new failure (last pass: v5.10.175-cip29-rt12) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/642bf9864a50717a3f79e928

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig/gcc-10/lab-collabora/baseline-=
qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig/gcc-10/lab-collabora/baseline-=
qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230324.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/642bf9864a50717a3f79e=
929
        new failure (last pass: v5.10.175-cip29-rt12) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/642bf9aba3df8dc08879e923

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230324.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/642bf9aba3df8dc08879e=
924
        new failure (last pass: v5.10.175-cip29-rt12) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3288-rock2-square          | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 2          =


  Details:     https://kernelci.org/test/plan/id/642bf75f1156f9f7ef79e983

  Results:     7 PASS, 2 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-r=
k3288-rock2-square.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-r=
k3288-rock2-square.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230324.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-pm-domain-driver-present: https://kernelci.org=
/test/case/id/642bf75f1156f9f7ef79e988
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:09:28.736593  /lava-9857775/1/../bin/lava-test-case

    2023-04-04T10:09:28.776082  [   43.431610] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk3288-crypto-probed RESULT=3Dblocked>

    2023-04-04T10:09:29.798933  /lava-9857775/1/../bin/lava-test-case

    2023-04-04T10:09:29.846681  [   44.502363] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-pm-domain-driver-present RESULT=3Dfail>
   =


  * baseline.bootrr.rk3288-crypto-driver-present: https://kernelci.org/test=
/case/id/642bf75f1156f9f7ef79e989
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:09:27.642077  /lava-9857775/1/../bin/lava-test-case

    2023-04-04T10:09:27.681577  [   42.337874] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk3288-crypto-driver-present RESULT=3Dfail>
   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 21         =


  Details:     https://kernelci.org/test/plan/id/642bf7748f8eca107279e922

  Results:     37 PASS, 22 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-r=
k3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-r=
k3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230324.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-pm-domain-driver-present: https://kernelci.org=
/test/case/id/642bf7748f8eca107279e927
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:09:33.357500  [   45.651817] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk3288-crypto-driver-present RESULT=3Dfail>

    2023-04-04T10:09:34.412614  /lava-9857781/1/../bin/lava-test-case

    2023-04-04T10:09:34.451458  [   46.746727] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk3288-crypto-probed RESULT=3Dblocked>

    2023-04-04T10:09:35.504003  /lava-9857781/1/../bin/lava-test-case
   =


  * baseline.bootrr.rk3288-crypto-driver-present: https://kernelci.org/test=
/case/id/642bf7748f8eca107279e928
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:09:33.341237  /lava-9857781/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-vopl-probed: https://kernelci.org/test/case/id=
/642bf7748f8eca107279e929
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:09:32.244006  /lava-9857781/1/../bin/lava-test-case

    2023-04-04T10:09:32.279992  [   44.575656] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-vopl-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-vopb-probed: https://kernelci.org/test/case/id=
/642bf7748f8eca107279e92a
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:09:31.151278  /lava-9857781/1/../bin/lava-test-case

    2023-04-04T10:09:31.172067  [   43.467704] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-vopb-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb-phy-grf-probed: https://kernelci.org/test/=
case/id/642bf7748f8eca107279e92c
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:09:29.018453  [   41.311999] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-usb-phy-driver-present RESULT=3Dpass>

    2023-04-04T10:09:30.034015  /lava-9857781/1/../bin/lava-test-case

    2023-04-04T10:09:30.059159  [   42.354242] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-usb-phy-grf-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-pwm0-probed: https://kernelci.org/test/case/id=
/642bf7748f8eca107279e934
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:09:27.749280  [   40.042697] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-pwm-driver-present RESULT=3Dpass>

    2023-04-04T10:09:28.759902  /lava-9857781/1/../bin/lava-test-case

    2023-04-04T10:09:28.797514  [   41.092886] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-pwm0-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-iodomain-driver-present: https://kernelci.org/=
test/case/id/642bf7748f8eca107279e936
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:09:24.492495  [   36.785443] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockcip-i2s-driver-present RESULT=3Dfail>

    2023-04-04T10:09:25.522593  /lava-9857781/1/../bin/lava-test-case

    2023-04-04T10:09:25.561486  [   37.856925] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-i2s-probed RESULT=3Dblocked>

    2023-04-04T10:09:26.615579  /lava-9857781/1/../bin/lava-test-case

    2023-04-04T10:09:26.640945  [   38.935199] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-iodomain-driver-present RESULT=3Dfail>
   =


  * baseline.bootrr.rockcip-i2s-driver-present: https://kernelci.org/test/c=
ase/id/642bf7748f8eca107279e937
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:09:23.428896  /lava-9857781/1/../bin/lava-test-case

    2023-04-04T10:09:23.439588  [   35.734318] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-dp-phy-grf-probed RESULT=3Dblocked>

    2023-04-04T10:09:24.452685  /lava-9857781/1/../bin/lava-test-case
   =


  * baseline.bootrr.rk_iommu-vopb_mmu-probed: https://kernelci.org/test/cas=
e/id/642bf7748f8eca107279e938
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:09:16.934869  /lava-9857781/1/../bin/lava-test-case

    2023-04-04T10:09:16.968531  [   29.263577] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk_iommu-vopb_mmu-probed RESULT=3Dfail>
   =


  * baseline.bootrr.ramoops-driver-present: https://kernelci.org/test/case/=
id/642bf7748f8eca107279e940
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:09:14.535856  /lava-9857781/1/../bin/lava-test-case

    2023-04-04T10:09:14.573110  [   26.868137] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dramoops-driver-present RESULT=3Dfail>
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/642bf7748f8eca107279e947
        failing since 73 days (last pass: v5.10.158-cip22-435-g2c52868ae1cb=
c, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-04-04T10:09:12.226991  Usage: seq [-w] [-s SEP] [FIRST [INC]] LA[ =
  24.516682] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-au=
dio-present RESULT=3Dfail>

    2023-04-04T10:09:12.227275  ST

    2023-04-04T10:09:12.227522  =


    2023-04-04T10:09:12.231129  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-04-04T10:09:12.233514  FIRST, INC default to 1.

    2023-04-04T10:09:12.234055  =


    2023-04-04T10:09:12.236902  	-w	Pad to last with leading zeros

    2023-04-04T10:09:12.238951  	-s SEP	String separator

    2023-04-04T10:09:12.242388  /lava-9857781/1/../bin/lava-test-case
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/642bf7748f8eca107279e948
        failing since 73 days (last pass: v5.10.158-cip22-435-g2c52868ae1cb=
c, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-04-04T10:09:12.213710  BusyBox v1.31.1 (2023-03-24 11:38:03 UTC) m=
ulti-call binary.

    2023-04-04T10:09:12.214260  =

   =


  * baseline.bootrr.dwhdmi-rockchip-probed: https://kernelci.org/test/case/=
id/642bf7748f8eca107279e949
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:09:11.179785  [   23.473012] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddwhdmi-rockchip-driver-present RESULT=3Dpass>

    2023-04-04T10:09:12.193486  /lava-9857781/1/../bin/lava-test-case

    2023-04-04T10:09:12.202643  [   24.497587] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-dp-phy-driver-present: https://kernelci.org/te=
st/case/id/642bf7748f8eca107279e94a
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:09:20.268523  [   32.562271] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-dp-driver-present RESULT=3Dfail>

    2023-04-04T10:09:21.286671  /lava-9857781/1/../bin/lava-test-case

    2023-04-04T10:09:21.302207  [   33.597100] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-dp-edp-probed RESULT=3Dblocked>

    2023-04-04T10:09:22.336418  /lava-9857781/1/../bin/lava-test-case

    2023-04-04T10:09:22.375714  [   34.669975] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-dp-phy-driver-present RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-dp-driver-present: https://kernelci.org/test/c=
ase/id/642bf7748f8eca107279e94b
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:09:20.231210  /lava-9857781/1/../bin/lava-test-case
   =


  * baseline.bootrr.rk_iommu-vpu_mmu-probed: https://kernelci.org/test/case=
/id/642bf7748f8eca107279e94c
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:09:19.149821  /lava-9857781/1/../bin/lava-test-case

    2023-04-04T10:09:19.188050  [   31.482947] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk_iommu-vpu_mmu-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rk_iommu-vopl_mmu-probed: https://kernelci.org/test/cas=
e/id/642bf7748f8eca107279e94d
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:09:18.039011  /lava-9857781/1/../bin/lava-test-case

    2023-04-04T10:09:18.078221  [   30.373202] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk_iommu-vopl_mmu-probed RESULT=3Dfail>
   =


  * baseline.bootrr.cros-ec-dev-driver-present: https://kernelci.org/test/c=
ase/id/642bf7748f8eca107279e94f
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:09:03.436388  [   15.729999] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtpm-chip-is-online RESULT=3Dskip>

    2023-04-04T10:09:03.613066  [   15.910379] dwc2 ff580000.usb: DWC OTG C=
ontroller

    2023-04-04T10:09:03.620323  [   15.915158] dwc2 ff580000.usb: new USB b=
us registered, assigned bus number 2

    2023-04-04T10:09:03.625202  [   15.922265] dwc2 ff580000.usb: irq 43, i=
o mem 0x00000000

    2023-04-04T10:09:03.630478  [   15.929230] hub 2-0:1.0: USB hub found

    2023-04-04T10:09:03.634841  [   15.933138] hub 2-0:1.0: 1 port detected

    2023-04-04T10:09:03.642393  [   15.939264] ehci-platform ff500000.usb: =
EHCI Host Controller

    2023-04-04T10:09:03.650679  [   15.945081] ehci-platform ff500000.usb: =
new USB bus registered, assigned bus number 3

    2023-04-04T10:09:03.657460  [   15.953400] ehci-platform ff500000.usb: =
irq 41, io mem 0xff500000

    2023-04-04T10:09:03.669259  [   15.965123] ehci-platform ff500000.usb: =
USB 2.0 started, EHCI 1.00
 =

    ... (8 line(s) more)  =


  * baseline.bootrr.dw_wdt-driver-present: https://kernelci.org/test/case/i=
d/642bf7748f8eca107279e956
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:09:08.944578  [   21.239056] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddw-apb-uart2-probed RESULT=3Dpass>

    2023-04-04T10:09:09.960028  /lava-9857781/1/../bin/lava-test-case

    2023-04-04T10:09:09.997578  [   22.292365] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddw_wdt-driver-present RESULT=3Dfail>
   =


  * baseline.bootrr.cros-ec-keyb-probed: https://kernelci.org/test/case/id/=
642bf7748f8eca107279e95b
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:09:07.746350  [   20.039288] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcros-ec-keyb-driver-present RESULT=3Dpass>

    2023-04-04T10:09:08.775520  /lava-9857781/1/../bin/lava-test-case

    2023-04-04T10:09:08.799756  [   21.094649] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcros-ec-keyb-probed RESULT=3Dfail>
   =


  * baseline.bootrr.cros-ec-i2c-tunnel-driver-present: https://kernelci.org=
/test/case/id/642bf7748f8eca107279e95d
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-04-04T10:09:05.560129  /lava-9857781/1/../bin/lava-test-case

    2023-04-04T10:09:05.584101  [   17.878757] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcros-ec-dev-probed RESULT=3Dblocked>

    2023-04-04T10:09:06.616073  /lava-9857781/1/../bin/lava-test-case

    2023-04-04T10:09:06.654764  [   18.948616] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcros-ec-i2c-tunnel-driver-present RESULT=3Dfail>
   =

 =20

