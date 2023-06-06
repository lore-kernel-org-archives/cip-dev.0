Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90418C7EE24
	for <webhook@archiver.kernel.org>; Tue,  6 Jun 2023 10:56:30 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web11.5987.1686048990038039890
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 06 Jun 2023 03:56:30 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=CUpm8d/E;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.170, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-64d18d772bdso6638800b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 06 Jun 2023 03:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686048989; x=1688640989;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3tCjeR4/hDn6m/R7fkqquzAcGkH+c371t8I7YunEjy4=;
        b=CUpm8d/ERUwXH5BgyEAoSOSuM3duQQvL8x2REyVNNnSlrx4xWleEBAvueiQAUm0L+W
         Ta7maNY/111Eji7TZpfAm5azL+xExWT2S545jCHDX7aR6BJ74RQocty1c/8zrnHbHLaL
         GRGE4FhgCM5e/YOuxRY60vlwYv78KZPgfvIHyNrfoDVxSEEbbhqWHMKam2nS40/yERyK
         8tQbA6kv0VisollQ+/qXkcpZXkMaEqxJH7TDBz0dL6ac8Vax8tI3OLk5en6MnDiDC6kd
         B/Tv1n7JhMjbK0L879X4stPkO7lcxdYj99Lqgq47Ra1POp0JAzCaoAFK5ZiNoL97bCof
         J1qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686048989; x=1688640989;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3tCjeR4/hDn6m/R7fkqquzAcGkH+c371t8I7YunEjy4=;
        b=khwNeFENMFwa2GraV4AuCDQDtX9aGPs97LKPHOtRRJfHfRljkDaMwzJQGVyfQALAgQ
         fqMNEDRbk4PVUuxImp0mkJJfSYXLcIxQbTCr8nDeZtD6KcrQ+Zi/O8avCsP0ncCeSu2W
         3dj3BK+ZTNz0h2iIB3TvRLXMPxdH+QiOusptKFGsS0rVRomwyWbmApmGKK//dK0NKydq
         MCHYPN2Qq28kJTjqFaRHDLicDSXNxwo95V+82PNlWcWeamj4v3YGOmsAR9dHnH3teCYj
         AaT+LXcnxPRoi9rTA5nQNKakeWEOWiP3aN9dGQXcM9+myBF4Ldlb4mTf0DObyIRWNcAw
         fs3Q==
X-Gm-Message-State: AC+VfDzrZrW7dUMCH/bI2mtf2zNFEz79mhgTiepfLFav/yzTHyAjkPSQ
	j8MjrEvQiPGC5DrZbV9Aukx581/3UYWFy0gigZ2PEw==
X-Google-Smtp-Source: ACHHUZ6ZK+oZ/UFZBfGWr/sQrNQxxcOHvCh//brNYoaumqyW0H5Lc5iJbOPR1Wf8UlVcEjN2FI4rFg==
X-Received: by 2002:a17:902:9309:b0:1af:d724:63ed with SMTP id bc9-20020a170902930900b001afd72463edmr1674293plb.42.1686048988659;
        Tue, 06 Jun 2023 03:56:28 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902e5c400b001ae5d21f760sm8214212plf.146.2023.06.06.03.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 03:56:28 -0700 (PDT)
Message-ID: <647f10dc.170a0220.695f4.ebf4@mx.google.com>
Date: Tue, 06 Jun 2023 03:56:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.180-cip34-26-g462b2292d23e6
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip baseline-nfs: 48 runs,
 11 regressions (v5.10.180-cip34-26-g462b2292d23e6)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jun 2023 10:56:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11866

cip/linux-5.10.y-cip baseline-nfs: 48 runs, 11 regressions (v5.10.180-cip34=
-26-g462b2292d23e6)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.180-cip34-26-g462b2292d23e6/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.180-cip34-26-g462b2292d23e6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      462b2292d23e6b1dc941676861a2951dd3a98d13 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647f02ff4c9555b8a1f5de39

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-nfs-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-nfs-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647f02ff4c9555b8a1f5de42
        failing since 143 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-06T09:56:59.023026  <8>[   18.120535] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10603962_1.5.2.3.1>

    2023-06-06T09:56:59.026271  + set +x

    2023-06-06T09:56:59.130806  / # #

    2023-06-06T09:56:59.231440  export SHELL=3D/bin/sh

    2023-06-06T09:56:59.231646  #

    2023-06-06T09:56:59.332128  / # export SHELL=3D/bin/sh. /lava-10603962/=
environment

    2023-06-06T09:56:59.332319  =


    2023-06-06T09:56:59.432825  / # . /lava-10603962/environment/lava-10603=
962/bin/lava-test-runner /lava-10603962/1

    2023-06-06T09:56:59.433118  =


    2023-06-06T09:56:59.438238  / # /lava-10603962/bin/lava-test-runner /la=
va-10603962/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647f025668e4a6cf7af5de3d

  Results:     47 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline=
-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline=
-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armel/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647f025668e4a6cf7af5de75
        failing since 143 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-06T09:53:58.728216  + set +x
    2023-06-06T09:53:58.866056  #
    2023-06-06T09:53:58.969602  / # #export SHELL=3D/bin/sh
    2023-06-06T09:53:58.970472  =

    2023-06-06T09:53:59.072488  / # export SHELL=3D/bin/sh. /lava-568540/en=
vironment
    2023-06-06T09:53:59.073298  =

    2023-06-06T09:53:59.175463  / # . /lava-568540/environment/lava-568540/=
bin/lava-test-runner /lava-568540/1
    2023-06-06T09:53:59.176833  =

    2023-06-06T09:53:59.183624  / # /lava-568540/bin/lava-test-runner /lava=
-568540/1
    2023-06-06T09:53:59.589718  + export TESTRUN_ID=3D1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647f068069e71379fcf5de3b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline=
-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline=
-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/647f068069e71379f=
cf5de3c
        new failure (last pass: v5.10.180-cip34-19-gf0f6960f132cd) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647f059b4d883d3421f5de55

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/arm/omap2plus_defconfig/gcc-10/lab-broonie/baselin=
e-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/arm/omap2plus_defconfig/gcc-10/lab-broonie/baselin=
e-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647f059b4d883d3421f5de8e
        failing since 125 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.165-cip25)

    2023-06-06T10:08:00.189330  [   46.120181] <LAVA_SIGNAL_ENDRUN 0_dmesg =
568647_1.6.2.4.1>
    2023-06-06T10:08:00.309503  / # #
    2023-06-06T10:08:00.412381  export SHELL=3D/bin/sh
    2023-06-06T10:08:00.413131  #
    2023-06-06T10:08:00.515469  / # export SHELL=3D/bin/sh. /lava-568647/en=
vironment
    2023-06-06T10:08:00.516240  =

    2023-06-06T10:08:00.618617  / # . /lava-568647/environment/lava-568647/=
bin/lava-test-runner /lava-568647/1
    2023-06-06T10:08:00.619771  =

    2023-06-06T10:08:00.624299  / # /lava-568647/bin/lava-test-runner /lava=
-568647/1
    2023-06-06T10:08:00.893852  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647f030385337d223af5ded9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647f030385337d223af5dee2
        failing since 52 days (last pass: v5.10.176-cip30, first fail: v5.1=
0.177-cip31)

    2023-06-06T09:57:29.717904  + set +x<8>[   21.880894] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10603940_1.5.2.3.1>

    2023-06-06T09:57:29.718336  =


    2023-06-06T09:57:29.825347  / # #

    2023-06-06T09:57:29.926068  export SHELL=3D/bin/sh

    2023-06-06T09:57:29.926328  #

    2023-06-06T09:57:30.027105  / # export SHELL=3D/bin/sh. /lava-10603940/=
environment

    2023-06-06T09:57:30.027826  =


    2023-06-06T09:57:30.129096  / # . /lava-10603940/environment/lava-10603=
940/bin/lava-test-runner /lava-10603940/1

    2023-06-06T09:57:30.129372  =


    2023-06-06T09:57:30.134157  / # /lava-10603940/bin/lava-test-runner /la=
va-10603940/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647f03069518974ee7f5de30

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647f03069518974ee7f5de39
        failing since 52 days (last pass: v5.10.176-cip30, first fail: v5.1=
0.177-cip31)

    2023-06-06T09:57:18.654254  + set +x

    2023-06-06T09:57:18.660880  [   18.702440] <LAVA_SIGNAL_ENDRUN 0_dmesg =
10603969_1.5.2.3.1>

    2023-06-06T09:57:18.765183  / # #

    2023-06-06T09:57:18.865758  export SHELL=3D/bin/sh

    2023-06-06T09:57:18.865917  #

    2023-06-06T09:57:18.966364  / # export SHELL=3D/bin/sh. /lava-10603969/=
environment

    2023-06-06T09:57:18.966524  =


    2023-06-06T09:57:19.066999  / # . /lava-10603969/environment/lava-10603=
969/bin/lava-test-runner /lava-10603969/1

    2023-06-06T09:57:19.067246  =


    2023-06-06T09:57:19.072176  / # /lava-10603969/bin/lava-test-runner /la=
va-10603969/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647f0541c52b4638d0f5de86

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-nfs-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-nfs-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647f0541c52b4638d0f5de8f
        failing since 143 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-06T10:06:40.206271  / # #

    2023-06-06T10:06:40.308954  export SHELL=3D/bin/sh

    2023-06-06T10:06:40.309698  #

    2023-06-06T10:06:40.411627  / # export SHELL=3D/bin/sh. /lava-10604077/=
environment

    2023-06-06T10:06:40.412414  =


    2023-06-06T10:06:40.514313  / # . /lava-10604077/environment/lava-10604=
077/bin/lava-test-runner /lava-10604077/1

    2023-06-06T10:06:40.515474  =


    2023-06-06T10:06:40.528610  / # /lava-10604077/bin/lava-test-runner /la=
va-10604077/1

    2023-06-06T10:06:40.705140  + export TESTRUN_ID=3D1_bootrr

    2023-06-06T10:06:40.705618  + cd /lava-10604077/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/647f053800a6acf332f5de3c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/arm64/defconfig+arm64-chromebook/gcc-10/lab-brooni=
e/baseline-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/arm64/defconfig+arm64-chromebook/gcc-10/lab-brooni=
e/baseline-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/647f053800a6acf33=
2f5de3d
        failing since 8 days (last pass: v5.10.180-cip33-21-g8eb0cdf459a2, =
first fail: v5.10.180-cip34) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/647f045409a88bbeb3f5de50

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/arm64/defconfig+arm64-chromebook/gcc-10/lab-collab=
ora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/arm64/defconfig+arm64-chromebook/gcc-10/lab-collab=
ora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/647f045409a88bbeb3f5de5a
        failing since 76 days (last pass: v5.10.173-cip28, first fail: v5.1=
0.175-cip29)

    2023-06-06T10:02:35.213701  /lava-10604024/1/../bin/lava-test-case

    2023-06-06T10:02:35.255014  <8>[   39.334743] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/647f045409a88bbeb3f5de5b
        failing since 76 days (last pass: v5.10.173-cip28, first fail: v5.1=
0.175-cip29)

    2023-06-06T10:02:34.109572  /lava-10604024/1/../bin/lava-test-case

    2023-06-06T10:02:34.149610  <8>[   38.229693] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/647f0df9aa2129c558f5de6e

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-su=
n50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-su=
n50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647f0dfaaa2129c558f5de9d
        failing since 143 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-06T10:43:30.546776  <8>[   80.993889] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 568580_1.6.2.4.1>
    2023-06-06T10:43:30.727210  / # #
    2023-06-06T10:43:30.829481  export SHELL=3D/bin/sh
    2023-06-06T10:43:30.830018  #
    2023-06-06T10:43:30.931428  / # export SHELL=3D/bin/sh. /lava-568580/en=
vironment
    2023-06-06T10:43:30.931899  =

    2023-06-06T10:43:31.033507  / # . /lava-568580/environment/lava-568580/=
bin/lava-test-runner /lava-568580/1
    2023-06-06T10:43:31.034430  =

    2023-06-06T10:43:31.041678  / # /lava-568580/bin/lava-test-runner /lava=
-568580/1
    2023-06-06T10:43:31.538949  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =20

