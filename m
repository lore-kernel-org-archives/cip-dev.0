Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912E4EB64DD
	for <webhook@archiver.kernel.org>; Sun,  9 Jul 2023 13:00:03 +0000 (UTC)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
 by mx.groups.io with SMTP id smtpd.web11.16649.1688907598239382068
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 09 Jul 2023 05:59:58 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=q7xlhroi;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.44, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-26309247002so1803422a91.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 09 Jul 2023 05:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1688907597; x=1691499597;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ok+fHdtYCxYfEuQ+DtVSq5SGP/oPsu+6KQbfR44Ggxg=;
        b=q7xlhroijXPM7aQ+91NlnCgtBKLWTgAWgqkUGdYO19/P8AeLgiG3W5mMxZ0DIjCAHN
         nA1uqunmYBlOkEKStBXM/87QBKCuVSIzW39qnRdvZCJIm2NqGwPJAMhHQ4BUknZHStpD
         pCTZEvj+28TpXQY1oSwIMd8ClK2oratGMKXIaYwuKRq7xjkIrg7lpVN/CDQ0Z029cb6A
         HwXHnlUOAta1lyGON49gkOvb94sOxZyp0KiDKrNTojcYipQoDuvVMXAL50vZVL6ZRPoG
         b1axSMe/IosqIqkZTgTgvPblqO54bsLy+bWrKZ5S+G1aFRW0AyKdaF81k+1KeB0XWxvX
         elXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688907597; x=1691499597;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ok+fHdtYCxYfEuQ+DtVSq5SGP/oPsu+6KQbfR44Ggxg=;
        b=TQD7g9LMcTE3DGIbekGThJpK/BLRuORN9sWYzeRgubrLVtQ+V0MzAl7y046lljXOTd
         WauXnO3A93kZk2Cfo9hklTUuBgkNPNPF0sIG7OlWTFvzSfT8XnXO7DGzs/DamxubbZ8C
         hrfMe8HMiMwGPsx08tpRqIr0IDcdNr5z66LdL6UN87mbgxlUz67T/hMbVM2kqijUl4t0
         nSqDeVQ0U32RP5jSe8Y0g/vrvkLQd9dJkP25z+L5+kEELLJGOHa6FZbZqK8FjLD2oRpr
         0/23GqlABAh7ZxYZcWtlDHCCxqCPpgy1TuiSBC91vcel5Ok4FqDm/+RrBdAudFK6LWaV
         Nxwg==
X-Gm-Message-State: ABy/qLYf/x5dmZJtlrH3ti644h8kTI2u5lWQtTkNVVJDljoZoxmMQRch
	nn4nEcKOdNNz/luM+K54jpEEnz6jEkAAGfHY2ZA=
X-Google-Smtp-Source: APBJJlGt9aN1yFCI4T7VDHjtfIcIwWfS72n4ltC+Jyt0gdEyIuvwXcD17FTIYmnFcl7uYJlvAkmdkg==
X-Received: by 2002:a17:90b:1d89:b0:263:41ae:8163 with SMTP id pf9-20020a17090b1d8900b0026341ae8163mr7902642pjb.12.1688907596768;
        Sun, 09 Jul 2023 05:59:56 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id m8-20020a17090a34c800b00263fd82106asm4739518pjf.35.2023.07.09.05.59.55
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jul 2023 05:59:56 -0700 (PDT)
Message-ID: <64aaaf4c.170a0220.8d12d.8e58@mx.google.com>
Date: Sun, 09 Jul 2023 05:59:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.31-65-geef5a19d48f6
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 48 runs,
 17 regressions (v6.1.31-65-geef5a19d48f6)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 09 Jul 2023 13:00:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12280

cip-gitlab/ci/pavel/linux-test baseline-nfs: 48 runs, 17 regressions (v6.1.=
31-65-geef5a19d48f6)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

kontron-pitx-imx8m           | arm64  | lab-kontron     | gcc-10   | defcon=
fig                    | 2          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

rk3399-rock-pi-4b            | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.31-65-geef5a19d48f6/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.31-65-geef5a19d48f6
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      eef5a19d48f6fa603cebb6b0341962fd9acc0e3b =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64aaa5658dfd62a223bb2b03

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/baseline-nfs-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/baseline-nfs-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64aaa5658dfd62a22=
3bb2b04
        new failure (last pass: v6.1.31-61-g32a95f5a4e3b) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64aaa57988a3df549cbb2ab4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64aaa57988a3df549=
cbb2ab5
        failing since 16 days (last pass: v5.10.182-cip35-8-g2391124f19a70,=
 first fail: v6.1.31-61-g32a95f5a4e3b) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64aaa4a0ff8bac9230bb2a8d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/baseline-nfs-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/baseline-nfs-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64aaa4a0ff8bac9230bb2a92
        failing since 16 days (last pass: v5.10.182-cip35-8-g2391124f19a70,=
 first fail: v6.1.31-61-g32a95f5a4e3b)

    2023-07-09T12:14:02.184891  + set +x<8>[   25.944988] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11049048_1.5.2.3.1>

    2023-07-09T12:14:02.184981  =


    2023-07-09T12:14:02.289664  / # #

    2023-07-09T12:14:02.390296  export SHELL=3D/bin/sh

    2023-07-09T12:14:02.390532  #

    2023-07-09T12:14:02.491067  / # export SHELL=3D/bin/sh. /lava-11049048/=
environment

    2023-07-09T12:14:02.491275  =


    2023-07-09T12:14:02.591834  / # . /lava-11049048/environment/lava-11049=
048/bin/lava-test-runner /lava-11049048/1

    2023-07-09T12:14:02.592125  =


    2023-07-09T12:14:02.597533  / # /lava-11049048/bin/lava-test-runner /la=
va-11049048/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64aaa462bbceb0d1e5bb2aac

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/baseline-nfs-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/baseline-nfs-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64aaa462bbceb0d1e5bb2ab1
        failing since 16 days (last pass: v5.10.182-cip35-8-g2391124f19a70,=
 first fail: v6.1.31-61-g32a95f5a4e3b)

    2023-07-09T12:13:11.364481  <8>[   18.699382] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11049040_1.5.2.3.1>

    2023-07-09T12:13:11.470043  / # #

    2023-07-09T12:13:11.572766  export SHELL=3D/bin/sh

    2023-07-09T12:13:11.573401  #

    2023-07-09T12:13:11.674773  / # export SHELL=3D/bin/sh. /lava-11049040/=
environment

    2023-07-09T12:13:11.675541  =


    2023-07-09T12:13:11.776952  / # . /lava-11049040/environment/lava-11049=
040/bin/lava-test-runner /lava-11049040/1

    2023-07-09T12:13:11.778369  =


    2023-07-09T12:13:11.783663  / # /lava-11049040/bin/lava-test-runner /la=
va-11049040/1

    2023-07-09T12:13:11.879071  + export TESTRUN_ID=3D1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64aaa473cbd92d5477bb2a93

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/baseline-nfs-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/baseline-nfs-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64aaa473cbd92d5477bb2a98
        failing since 16 days (last pass: v5.10.182-cip35-8-g2391124f19a70,=
 first fail: v6.1.31-61-g32a95f5a4e3b)

    2023-07-09T12:13:17.901221  <8>[   18.090746] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11049026_1.5.2.3.1>

    2023-07-09T12:13:17.904770  + set +x

    2023-07-09T12:13:18.009196  / # #

    2023-07-09T12:13:18.109985  export SHELL=3D/bin/sh

    2023-07-09T12:13:18.110210  #

    2023-07-09T12:13:18.210679  / # export SHELL=3D/bin/sh. /lava-11049026/=
environment

    2023-07-09T12:13:18.210911  =


    2023-07-09T12:13:18.311475  / # . /lava-11049026/environment/lava-11049=
026/bin/lava-test-runner /lava-11049026/1

    2023-07-09T12:13:18.311796  =


    2023-07-09T12:13:18.316453  / # /lava-11049026/bin/lava-test-runner /la=
va-11049026/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64aaa6326f5d389692bb2cb4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/arm/multi_v5_defconfig/gcc-10/lab-broonie/baselin=
e-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/arm/multi_v5_defconfig/gcc-10/lab-broonie/baselin=
e-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armel/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64aaa6326f5d38969=
2bb2cb5
        failing since 17 days (last pass: v5.10.182-cip35-8-g2391124f19a70,=
 first fail: v6.1.31-61-g32a95f5a4e3b) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64aaa3ddcb8052c0b1bb2ab2

  Results:     52 PASS, 3 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseli=
ne-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseli=
ne-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64aaa3ddcb8052c0b1bb2ae7
        failing since 24 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-07-09T12:10:51.724686  + set +x
    2023-07-09T12:10:51.728704  <8>[   47.579277] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 705173_1.6.2.4.1>
    2023-07-09T12:10:51.847835  / # #
    2023-07-09T12:10:51.949680  export SHELL=3D/bin/sh
    2023-07-09T12:10:51.950253  #
    2023-07-09T12:10:52.051638  / # export SHELL=3D/bin/sh. /lava-705173/en=
vironment
    2023-07-09T12:10:52.052104  =

    2023-07-09T12:10:52.153480  / # . /lava-705173/environment/lava-705173/=
bin/lava-test-runner /lava-705173/1
    2023-07-09T12:10:52.153878  =

    2023-07-09T12:10:52.158056  / # /lava-705173/bin/lava-test-runner /lava=
-705173/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64aaa507a067570f16bb2af7

  Results:     52 PASS, 3 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-n=
fs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-n=
fs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64aaa507a067570f16bb2afa
        failing since 24 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-07-09T12:15:54.056007  + set +x
    2023-07-09T12:15:54.057705  [   39.908889] <LAVA_SIGNAL_ENDRUN 0_dmesg =
984105_1.6.2.4.1>
    2023-07-09T12:15:54.176357  #
    2023-07-09T12:15:54.278420  / # #export SHELL=3D/bin/sh
    2023-07-09T12:15:54.278864  =

    2023-07-09T12:15:54.380248  / # export SHELL=3D/bin/sh. /lava-984105/en=
vironment
    2023-07-09T12:15:54.380692  =

    2023-07-09T12:15:54.482092  / # . /lava-984105/environment/lava-984105/=
bin/lava-test-runner /lava-984105/1
    2023-07-09T12:15:54.482832  =

    2023-07-09T12:15:54.484964  / # /lava-984105/bin/lava-test-runner /lava=
-984105/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64aaa6cb6380571037bb2a97

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64aaa6cb6380571037bb2a9c
        failing since 24 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-07-09T12:23:37.313143  + <8>[   21.128517] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11048975_1.5.2.3.1>

    2023-07-09T12:23:37.313566  set +x

    2023-07-09T12:23:37.420489  / # #

    2023-07-09T12:23:37.522827  export SHELL=3D/bin/sh

    2023-07-09T12:23:37.523079  #

    2023-07-09T12:23:37.624015  / # export SHELL=3D/bin/sh. /lava-11048975/=
environment

    2023-07-09T12:23:37.624781  =


    2023-07-09T12:23:37.726388  / # . /lava-11048975/environment/lava-11048=
975/bin/lava-test-runner /lava-11048975/1

    2023-07-09T12:23:37.727677  =


    2023-07-09T12:23:37.732246  / # /lava-11048975/bin/lava-test-runner /la=
va-11048975/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64aaa62d6f5d389692bb2aa6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64aaa62d6f5d389692bb2aab
        failing since 24 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-07-09T12:20:48.254663  + set[   24.675963] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11048998_1.5.2.3.1>

    2023-07-09T12:20:48.255205   +x

    2023-07-09T12:20:48.365601  / # #

    2023-07-09T12:20:48.468721  export SHELL=3D/bin/sh

    2023-07-09T12:20:48.469374  #

    2023-07-09T12:20:48.570634  / # export SHELL=3D/bin/sh. /lava-11048998/=
environment

    2023-07-09T12:20:48.571412  =


    2023-07-09T12:20:48.672978  / # . /lava-11048998/environment/lava-11048=
998/bin/lava-test-runner /lava-11048998/1

    2023-07-09T12:20:48.674212  =


    2023-07-09T12:20:48.679187  / # /lava-11048998/bin/lava-test-runner /la=
va-11048998/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64aaa473bbceb0d1e5bb2aba

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/baseline-nfs-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/baseline-nfs-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64aaa473bbceb0d1e5bb2abf
        failing since 16 days (last pass: v5.10.182-cip35-8-g2391124f19a70,=
 first fail: v6.1.31-61-g32a95f5a4e3b)

    2023-07-09T12:13:15.434678  <8>[   17.471939] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11048993_1.5.2.3.1>

    2023-07-09T12:13:15.539527  / # #

    2023-07-09T12:13:15.640158  export SHELL=3D/bin/sh

    2023-07-09T12:13:15.640333  #

    2023-07-09T12:13:15.740830  / # export SHELL=3D/bin/sh. /lava-11048993/=
environment

    2023-07-09T12:13:15.741026  =


    2023-07-09T12:13:15.841551  / # . /lava-11048993/environment/lava-11048=
993/bin/lava-test-runner /lava-11048993/1

    2023-07-09T12:13:15.841803  =


    2023-07-09T12:13:15.847033  / # /lava-11048993/bin/lava-test-runner /la=
va-11048993/1

    2023-07-09T12:13:15.925764  + export TESTRUN_ID=3D1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64aaa6d90dfd1cc1cbbb2a8d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/ba=
seline-nfs-imx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/ba=
seline-nfs-imx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64aaa6d90dfd1cc1c=
bbb2a8e
        failing since 16 days (last pass: v5.10.182-cip35-8-g2391124f19a70,=
 first fail: v6.1.31-61-g32a95f5a4e3b) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64aaaaf859be4595f9bb2a78

  Results:     60 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-j=
uno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-j=
uno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64aaaaf859be4595f9bb2ab3
        failing since 16 days (last pass: v5.10.182-cip35-8-g2391124f19a70,=
 first fail: v6.1.31-61-g32a95f5a4e3b)

    2023-07-09T12:41:03.188978  [   58.644825] <LAVA_SIGNAL_ENDRUN 0_dmesg =
705323_1.6.2.4.1>
    2023-07-09T12:41:03.308025  / # #
    2023-07-09T12:41:03.410973  export SHELL=3D/bin/sh
    2023-07-09T12:41:03.411792  #
    2023-07-09T12:41:03.513691  / # export SHELL=3D/bin/sh. /lava-705323/en=
vironment
    2023-07-09T12:41:03.514465  =

    2023-07-09T12:41:03.616526  / # . /lava-705323/environment/lava-705323/=
bin/lava-test-runner /lava-705323/1
    2023-07-09T12:41:03.617856  =

    2023-07-09T12:41:03.636588  / # /lava-705323/bin/lava-test-runner /lava=
-705323/1
    2023-07-09T12:41:03.798159  + export TESTRUN_ID=3D1_bootrr =

    ... (40 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
kontron-pitx-imx8m           | arm64  | lab-kontron     | gcc-10   | defcon=
fig                    | 2          =


  Details:     https://kernelci.org/test/plan/id/64aaa91a84e81643b7bb2bd7

  Results:     50 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/arm64/defconfig/gcc-10/lab-kontron/baseline-nfs-k=
ontron-pitx-imx8m.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/arm64/defconfig/gcc-10/lab-kontron/baseline-nfs-k=
ontron-pitx-imx8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64aaa91a84e81643b7bb2bda
        failing since 17 days (last pass: v6.1.26-1314-g1ab0ac1d7e2e3, firs=
t fail: v6.1.31-61-g32a95f5a4e3b)

    2023-07-09T12:33:04.659896  + set<8>[   16.933055] <LAVA_SIGNAL_ENDRUN =
0_dmesg 370377_1.6.2.4.1>
    2023-07-09T12:33:04.660172   +x
    2023-07-09T12:33:04.766335  / # #
    2023-07-09T12:33:04.868942  export SHELL=3D/bin/sh
    2023-07-09T12:33:04.869723  #
    2023-07-09T12:33:04.971651  / # export SHELL=3D/bin/sh. /lava-370377/en=
vironment
    2023-07-09T12:33:04.972398  =

    2023-07-09T12:33:05.074604  / # . /lava-370377/environment/lava-370377/=
bin/lava-test-runner /lava-370377/1
    2023-07-09T12:33:05.075859  =

    2023-07-09T12:33:05.093053  / # /lava-370377/bin/lava-test-runner /lava=
-370377/1 =

    ... (12 line(s) more)  =


  * baseline-nfs.bootrr.dwc3-usb1-probed: https://kernelci.org/test/case/id=
/64aaa91a84e81643b7bb2bea
        failing since 17 days (last pass: v6.1.26-1314-g1ab0ac1d7e2e3, firs=
t fail: v6.1.31-61-g32a95f5a4e3b)

    2023-07-09T12:33:09.331312  /lava-370377/1/../bin/lava-test-case
    2023-07-09T12:33:09.392301  <8>[   21.868475] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwc3-usb1-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64aaa4731864d284d3bb2ac2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64aaa4731864d284d3bb2ac7
        failing since 16 days (last pass: v5.10.182-cip35-8-g2391124f19a70,=
 first fail: v6.1.31-61-g32a95f5a4e3b)

    2023-07-09T12:13:18.845856  [   27.134358] <LAVA_SIGNAL_ENDRUN 0_dmesg =
11049016_1.5.2.3.1>

    2023-07-09T12:13:18.950097  / # #

    2023-07-09T12:13:19.050904  export SHELL=3D/bin/sh

    2023-07-09T12:13:19.051124  #

    2023-07-09T12:13:19.151731  / # export SHELL=3D/bin/sh. /lava-11049016/=
environment

    2023-07-09T12:13:19.151930  =


    2023-07-09T12:13:19.252468  / # . /lava-11049016/environment/lava-11049=
016/bin/lava-test-runner /lava-11049016/1

    2023-07-09T12:13:19.252802  =


    2023-07-09T12:13:19.257317  / # /lava-11049016/bin/lava-test-runner /la=
va-11049016/1

    2023-07-09T12:13:19.302687  + export TESTRUN_ID=3D1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64aaa8dc2f749a39c4bb2abb

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/arm64/defconfig/gcc-10/lab-collabora/baseline-nfs=
-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-65-geef5a19d48f6/arm64/defconfig/gcc-10/lab-collabora/baseline-nfs=
-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64aaa8dc2f749a39c4bb2ac0
        failing since 17 days (last pass: v5.10.182-cip35-8-g2391124f19a70,=
 first fail: v6.1.31-61-g32a95f5a4e3b)

    2023-07-09T12:32:20.935679  / # #

    2023-07-09T12:32:22.201047  export SHELL=3D/bin/sh

    2023-07-09T12:32:22.212044  #

    2023-07-09T12:32:22.212533  / # export SHELL=3D/bin/sh

    2023-07-09T12:32:23.954970  / # . /lava-11049107/environment

    2023-07-09T12:32:27.161836  /lava-11049107/bin/lava-test-runner /lava-1=
1049107/1

    2023-07-09T12:32:27.172520  . /lava-11049107/environment

    2023-07-09T12:32:27.175095  / # /lava-11049107/bin/lava-test-runner /la=
va-11049107/1

    2023-07-09T12:32:27.363144  + export TESTRUN_ID=3D1_bootrr

    2023-07-09T12:32:27.363669  + cd /lava-11049107/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =20

