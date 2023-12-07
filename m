Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6409C4167B
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 21:14:20 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web10.104271.1701983659517345710
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 07 Dec 2023 13:14:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=Ih75GNje;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.176, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d03bcf27e9so12046505ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 07 Dec 2023 13:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701983658; x=1702588458; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ev7SMwungZcq7T6EVbyJC3lzC8ChxRalzyyVkcz+REI=;
        b=Ih75GNjeSIkI+t/UZSkWAd6PnPXxiX29CABolcbw74LR+eqCNMisI/+fvTVYA5U5S8
         Mbhiq565FQrBZIvnNmGM5XwKDEX1027840m6be+V/STK/xuTncPq8q2gCh2zQDltB0W6
         R1XASfspubLcbGnb9NwV5OnPdvNlVm2tvWUIfHOwaKkYZ6+D2ARhpArIdo75o3bArw7p
         cRLtdQvGccfN20rBQ7TC4DqXIIxbwPhh9Ep1ggS2zGhRDvi43ozmplFgLbFgQyuUOeRy
         s333lbvtp/GmdvpVYCxHDgOQgjzgBIIF1dFvhuk8FuDtzZNzMWmBy9wT/P2AW0IoU4+E
         5+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701983658; x=1702588458;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ev7SMwungZcq7T6EVbyJC3lzC8ChxRalzyyVkcz+REI=;
        b=B+sO1VucIOfp6OyVlHNb1PvrRUeBO3jGBnwKSpWYO/TeOrKNjCSX/zowrhkpGuNIqa
         j+01wSnr37gW+G+zh3S8QefJ6WaCSJCc2GKuUiY6o/t3wZu390k+iwv4Iqb5b6JRwAoc
         +ec7AJIS35MyVOlGomLWZ6JpSMhCirmtd1NY3Akc83L0P4wuQZnQ2aZJLboLVY42UJhU
         iBmqMKw4sObkpkDKDxQ1zJ+V5TAw+IyUacju/P+xXleVrC3GRfEt5gBcytnqQjiM/16B
         1tgv9hhGdEQjlpIbkUqiKJhwnJ2yEZC2VamAJkM+RctjuvjX9CLBNN08L8XIGl6yRchn
         JhGw==
X-Gm-Message-State: AOJu0YyCTYIK+mEBG0Jl6c4wirCfcMtWBcRNohnnWhuIAHciDTveRBMA
	pa4IskklkiHk3BbOe3JiFA9r5adf+rBoZnroO5+F7w==
X-Google-Smtp-Source: AGHT+IFag3/R+7urXKMZci7rB15gBwNoKqCa9Kn2UhZVrHNj2TNBasvx0q3YdektAxYen/vO0k1NkA==
X-Received: by 2002:a17:903:4cf:b0:1d0:6ffe:1e84 with SMTP id jm15-20020a17090304cf00b001d06ffe1e84mr2648733plb.103.1701983658541;
        Thu, 07 Dec 2023 13:14:18 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a21-20020a1709027d9500b001cfed5524easm252627plm.288.2023.12.07.13.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 13:14:18 -0800 (PST)
Message-ID: <657235aa.170a0220.2f8c5.1864@mx.google.com>
Date: Thu, 07 Dec 2023 13:14:18 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.299-cip105
Subject: cip/linux-4.19.y-cip baseline-nfs: 52 runs,
 7 regressions (v4.19.299-cip105)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 21:14:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13922

cip/linux-4.19.y-cip baseline-nfs: 52 runs, 7 regressions (v4.19.299-cip105)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
at91sam9g20ek                | arm   | lab-broonie   | gcc-10   | multi_v5_=
defconfig           | 1          =

beaglebone-black             | arm   | lab-broonie   | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =

imx6dl-udoo                  | arm   | lab-broonie   | gcc-10   | imx_v6_v7=
_defconfig          | 1          =

imx6q-udoo                   | arm   | lab-broonie   | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =

rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook   | 2          =

sun50i-h5-lib...ch-all-h3-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.299-cip105/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.299-cip105
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      d152f9dce44a3068c74de8c2046a16b8dd3c1544 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
at91sam9g20ek                | arm   | lab-broonie   | gcc-10   | multi_v5_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65722f7151f18a1e89e13475

  Results:     42 PASS, 9 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.299=
-cip105/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-nfs-at91sam9g20e=
k.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.299=
-cip105/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-nfs-at91sam9g20e=
k.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armel/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65722f7151f18a1e89e134ab
        failing since 69 days (last pass: v4.19.287-cip100, first fail: v4.=
19.295-cip103)

    2023-12-07T20:47:03.928903  + set +x<8><LAVA_SIGNAL_ENDRUN 0_dmesg 3198=
64_1.6.2.4.1>
    2023-12-07T20:47:04.048524  #
    2023-12-07T20:47:04.151880  / # #export SHELL=3D/bin/sh
    2023-12-07T20:47:04.152740  =

    2023-12-07T20:47:04.254738  / # export SHELL=3D/bin/sh. /lava-319864/en=
vironment
    2023-12-07T20:47:04.255625  =

    2023-12-07T20:47:04.357747  / # . /lava-319864/environment/lava-319864/=
bin/lava-test-runner /lava-319864/1
    2023-12-07T20:47:04.359171  =

    2023-12-07T20:47:04.362511  / # /lava-319864/bin/lava-test-runner /lava=
-319864/1
    2023-12-07T20:47:04.705240  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65723073088659c5eee134af

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.299=
-cip105/arm/multi_v7_defconfig+kselftest/gcc-10/lab-broonie/baseline-nfs-be=
aglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.299=
-cip105/arm/multi_v7_defconfig+kselftest/gcc-10/lab-broonie/baseline-nfs-be=
aglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65723073088659c5e=
ee134b0
        new failure (last pass: v4.19.295-cip103) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6dl-udoo                  | arm   | lab-broonie   | gcc-10   | imx_v6_v7=
_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/657231ae3f93371966e13492

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.299=
-cip105/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-imx6dl-udoo=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.299=
-cip105/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-imx6dl-udoo=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/657231ae3f9337196=
6e13493
        new failure (last pass: v4.19.295-cip103) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-udoo                   | arm   | lab-broonie   | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/657231e564bd8bdf07e13486

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.299=
-cip105/arm/multi_v7_defconfig+kselftest/gcc-10/lab-broonie/baseline-nfs-im=
x6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.299=
-cip105/arm/multi_v7_defconfig+kselftest/gcc-10/lab-broonie/baseline-nfs-im=
x6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/657231e564bd8bdf0=
7e13487
        new failure (last pass: v4.19.295-cip103) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/65722ea7625a80465ee1348b

  Results:     77 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.299=
-cip105/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-=
rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.299=
-cip105/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-=
rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/65722ea7625a80465ee13495
        failing since 260 days (last pass: v4.19.276-cip93, first fail: v4.=
19.277-cip94)

    2023-12-07T20:44:28.233735  <8>[   38.274962] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-12-07T20:44:29.260274  /lava-12210390/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/65722ea7625a80465ee13496
        failing since 260 days (last pass: v4.19.276-cip93, first fail: v4.=
19.277-cip94)

    2023-12-07T20:44:28.211444  /lava-12210390/1/../bin/lava-test-case
   =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
sun50i-h5-lib...ch-all-h3-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/657230843073f909b4e13476

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.299=
-cip105/arm64/defconfig+kselftest/gcc-10/lab-broonie/baseline-nfs-sun50i-h5=
-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.299=
-cip105/arm64/defconfig+kselftest/gcc-10/lab-broonie/baseline-nfs-sun50i-h5=
-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/657230843073f909b=
4e13477
        new failure (last pass: v4.19.297-cip104) =

 =20

