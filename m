Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCDEC7EE2A
	for <webhook@archiver.kernel.org>; Mon,  5 Jun 2023 10:59:32 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
 by mx.groups.io with SMTP id smtpd.web10.4608.1685962764576368006
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Jun 2023 03:59:24 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=NhoMjOPq;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.51, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2564dc37c3eso4273203a91.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Jun 2023 03:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685962763; x=1688554763;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VVcak2mW+M7b3n4QR9hRarJ+HWlK4MlVwFyeKol71i8=;
        b=NhoMjOPqO4t0zoE0m5RQFJ0opaDLfmFqIfjsjMSOqMsGOaPX2GxggzTJZQGo7LrMLl
         aqENKN14Okd/ASiV5KnAVbT2teLDtNZvSI7VC402IJfaoVb7xGpotQuaPfscizE82QrG
         bMVcKtlPhgITaJj8oew51ezrltAgxK5byh6qni0OT+bA3Ql4lNxe5HavPgK1oV2FgSHy
         3wOxsFM2sgauzZWIwHXAw3/EBW6WoIax7VycLcW+6lSxe28pDTFRcvFDK8PRzlMd7KS6
         UPQg9XSiIG9m3c+JLR0sGSNQkOycBpnNvgfA0KznkkGMBvnH5tO2+YPWuNw3btLVot9b
         IZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685962763; x=1688554763;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VVcak2mW+M7b3n4QR9hRarJ+HWlK4MlVwFyeKol71i8=;
        b=VxBmo7OfUE/qp7bERT3geVS8xZlRIyssqufl/icQ3zEmD/t3qDdUExnIxhqmFtmRq0
         +QVg7VPBte0tfD7T63AnwBqnTsoFZPDjBAjZZwdFW6yqL1yTkYY5Py1ijNy6UtuXI0cD
         tgfC53j1AbPb/diIT/kiAZtSrACsnpMRYpG8Jgni5GXs7QeJ468DBNp48G0qIxRZThC0
         6uL8Fqu0+GIL989SzPvIQYrZhiIx2vROKtCq/0NhxQKLKznw3pAcuHasw86Ax3T30Dsa
         YiEKVtsxhIMKHNkzcxrtJBP+bKmfiuC9gTBSXLclE96YDpdFT8dZljn6P/881w5BXPd3
         PpVQ==
X-Gm-Message-State: AC+VfDw0YtIUgu9dcH5NoOVRvW26LSR775+X9DOxyYmfAQT8OtbileeV
	9FeLpNPq210dbJiuKVsPllLZBKmNVypOJ+LTrSml7w==
X-Google-Smtp-Source: ACHHUZ6siXtNcJfNmybucSsFMc1rJgXqQdeBrw0w4NsmgsdLPspH0jdlIiOQkvBuwzv5OBIJ4D3rDg==
X-Received: by 2002:a17:90a:ee92:b0:255:38ed:9dcd with SMTP id i18-20020a17090aee9200b0025538ed9dcdmr8059695pjz.0.1685962763109;
        Mon, 05 Jun 2023 03:59:23 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id lx5-20020a17090b4b0500b002591f7ff90csm3063529pjb.43.2023.06.05.03.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 03:59:22 -0700 (PDT)
Message-ID: <647dc00a.170a0220.d2b18.45f0@mx.google.com>
Date: Mon, 05 Jun 2023 03:59:22 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.180-cip34-19-gf0f6960f132cd
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip baseline-nfs: 52 runs,
 13 regressions (v5.10.180-cip34-19-gf0f6960f132cd)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jun 2023 10:59:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11786

cip/linux-5.10.y-cip baseline-nfs: 52 runs, 13 regressions (v5.10.180-cip34=
-19-gf0f6960f132cd)

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

beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
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
l/v5.10.180-cip34-19-gf0f6960f132cd/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.180-cip34-19-gf0f6960f132cd
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      f0f6960f132cdf82ed0fcb61de7c496d33f0998f =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647db84c02273211c1f5de35

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-nfs-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-nfs-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647db84c02273211c1f5de3e
        failing since 142 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-05T10:26:04.343476  <8>[   18.379413] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10590445_1.5.2.3.1>

    2023-06-05T10:26:04.346957  + set +x

    2023-06-05T10:26:04.451054  / # #

    2023-06-05T10:26:04.551631  export SHELL=3D/bin/sh

    2023-06-05T10:26:04.551831  #

    2023-06-05T10:26:04.652385  / # export SHELL=3D/bin/sh. /lava-10590445/=
environment

    2023-06-05T10:26:04.652573  =


    2023-06-05T10:26:04.753117  / # . /lava-10590445/environment/lava-10590=
445/bin/lava-test-runner /lava-10590445/1

    2023-06-05T10:26:04.753485  =


    2023-06-05T10:26:04.758504  / # /lava-10590445/bin/lava-test-runner /la=
va-10590445/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647db3c2591ea62963f5de87

  Results:     47 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline=
-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline=
-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armel/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647db3c2591ea62963f5dec0
        failing since 142 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-05T10:06:28.468901  + set +x
    2023-06-05T10:06:28.474138  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 562202_1.6.2=
.4.1>
    2023-06-05T10:06:28.595929  #
    2023-06-05T10:06:28.699097  / # #export SHELL=3D/bin/sh
    2023-06-05T10:06:28.699933  =

    2023-06-05T10:06:28.802065  / # export SHELL=3D/bin/sh. /lava-562202/en=
vironment
    2023-06-05T10:06:28.802880  =

    2023-06-05T10:06:28.904874  / # . /lava-562202/environment/lava-562202/=
bin/lava-test-runner /lava-562202/1
    2023-06-05T10:06:28.906170  =

    2023-06-05T10:06:28.912878  / # /lava-562202/bin/lava-test-runner /lava=
-562202/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647db40a61e6efdf95f5de32

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline=
-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline=
-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647db40a61e6efdf95f5de63
        failing since 142 days (last pass: v5.10.158-cip22, first fail: v5.=
10.162-cip24)

    2023-06-05T10:07:34.765899  [   50.017367] <LAVA_SIGNAL_ENDRUN 0_dmesg =
562266_1.6.2.4.1>
    2023-06-05T10:07:34.882078  / # #
    2023-06-05T10:07:34.984409  export SHELL=3D/bin/sh
    2023-06-05T10:07:34.984944  #
    2023-06-05T10:07:35.086569  / # export SHELL=3D/bin/sh. /lava-562266/en=
vironment
    2023-06-05T10:07:35.087095  =

    2023-06-05T10:07:35.188669  / # . /lava-562266/environment/lava-562266/=
bin/lava-test-runner /lava-562266/1
    2023-06-05T10:07:35.189351  =

    2023-06-05T10:07:35.194189  / # /lava-562266/bin/lava-test-runner /lava=
-562266/1
    2023-06-05T10:07:35.402745  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647db95a8867c39eb6f5de2f

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs=
-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs=
-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647db95a8867c39eb6f5de36
        failing since 142 days (last pass: v5.10.158-cip22, first fail: v5.=
10.162-cip24)

    2023-06-05T10:30:01.922491  [   49.011091] <LAVA_SIGNAL_ENDRUN 0_dmesg =
953042_1.6.2.4.1>
    2023-06-05T10:30:02.186603  #
    2023-06-05T10:30:02.289657  / # #export SHELL=3D/bin/sh
    2023-06-05T10:30:02.290369  =

    2023-06-05T10:30:02.392186  / # export SHELL=3D/bin/sh. /lava-953042/en=
vironment
    2023-06-05T10:30:02.392918  =

    2023-06-05T10:30:02.494803  / # . /lava-953042/environment/lava-953042/=
bin/lava-test-runner /lava-953042/1
    2023-06-05T10:30:02.495957  =

    2023-06-05T10:30:02.502351  / # /lava-953042/bin/lava-test-runner /lava=
-953042/1
    2023-06-05T10:30:02.858885  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647db522d0694cb58bf5de4c

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/arm/omap2plus_defconfig/gcc-10/lab-broonie/baselin=
e-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/arm/omap2plus_defconfig/gcc-10/lab-broonie/baselin=
e-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647db522d0694cb58bf5de85
        failing since 124 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.165-cip25)

    2023-06-05T10:12:36.181926  <8>[   46.733659] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 562294_1.6.2.4.1>
    2023-06-05T10:12:36.301192  / # #
    2023-06-05T10:12:36.404141  export SHELL=3D/bin/sh
    2023-06-05T10:12:36.404898  #
    2023-06-05T10:12:36.507072  / # export SHELL=3D/bin/sh. /lava-562294/en=
vironment
    2023-06-05T10:12:36.507806  =

    2023-06-05T10:12:36.610268  / # . /lava-562294/environment/lava-562294/=
bin/lava-test-runner /lava-562294/1
    2023-06-05T10:12:36.611418  =

    2023-06-05T10:12:36.615009  / # /lava-562294/bin/lava-test-runner /lava=
-562294/1
    2023-06-05T10:12:36.876403  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647dba9a98307da503f5de29

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nf=
s-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nf=
s-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647dba9a98307da503f5de30
        failing since 124 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.165-cip25)

    2023-06-05T10:35:42.162282  / # #
    2023-06-05T10:35:42.265730  export SHELL=3D/bin/sh
    2023-06-05T10:35:42.266812  #
    2023-06-05T10:35:42.369022  / # export SHELL=3D/bin/sh. /lava-953053/en=
vironment
    2023-06-05T10:35:42.370010  =

    2023-06-05T10:35:42.472165  / # . /lava-953053/environment/lava-953053/=
bin/lava-test-runner /lava-953053/1
    2023-06-05T10:35:42.473927  =

    2023-06-05T10:35:42.483354  / # /lava-953053/bin/lava-test-runner /lava=
-953053/1
    2023-06-05T10:35:42.800178  + export TESTRUN_ID=3D1_bootrr
    2023-06-05T10:35:42.800842  + cd /lava-953053/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647db8809be6ee2e42f5dfa4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647db8809be6ee2e42f5dfad
        failing since 52 days (last pass: v5.10.176-cip30, first fail: v5.1=
0.177-cip31)

    2023-06-05T10:26:55.686491  + set<8>[   22.303668] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10590416_1.5.2.3.1>

    2023-06-05T10:26:55.686579   +x

    2023-06-05T10:26:55.790606  / # #

    2023-06-05T10:26:55.891248  export SHELL=3D/bin/sh

    2023-06-05T10:26:55.891442  #

    2023-06-05T10:26:55.991974  / # export SHELL=3D/bin/sh. /lava-10590416/=
environment

    2023-06-05T10:26:55.992189  =


    2023-06-05T10:26:56.092734  / # . /lava-10590416/environment/lava-10590=
416/bin/lava-test-runner /lava-10590416/1

    2023-06-05T10:26:56.093030  =


    2023-06-05T10:26:56.097830  / # /lava-10590416/bin/lava-test-runner /la=
va-10590416/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647db7938cbe939d95f5de5d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647db7938cbe939d95f5de66
        failing since 52 days (last pass: v5.10.176-cip30, first fail: v5.1=
0.177-cip31)

    2023-06-05T10:22:52.469397  + set +x<8>[   17.261222] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10590444_1.5.2.3.1>

    2023-06-05T10:22:52.469483  =


    2023-06-05T10:22:52.573363  / # #

    2023-06-05T10:22:52.674463  export SHELL=3D/bin/sh

    2023-06-05T10:22:52.675248  #

    2023-06-05T10:22:52.776720  / # export SHELL=3D/bin/sh. /lava-10590444/=
environment

    2023-06-05T10:22:52.777465  =


    2023-06-05T10:22:52.878861  / # . /lava-10590444/environment/lava-10590=
444/bin/lava-test-runner /lava-10590444/1

    2023-06-05T10:22:52.880100  =


    2023-06-05T10:22:52.884739  / # /lava-10590444/bin/lava-test-runner /la=
va-10590444/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647db4d876dacf0936f5de93

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-nfs-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-nfs-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647db4d876dacf0936f5de9a
        failing since 142 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-05T10:11:18.270574  / # #

    2023-06-05T10:11:18.371113  export SHELL=3D/bin/sh

    2023-06-05T10:11:18.371274  #

    2023-06-05T10:11:18.471853  / # export SHELL=3D/bin/sh. /lava-10590257/=
environment

    2023-06-05T10:11:18.471991  =


    2023-06-05T10:11:18.572536  / # . /lava-10590257/environment/lava-10590=
257/bin/lava-test-runner /lava-10590257/1

    2023-06-05T10:11:18.572796  =


    2023-06-05T10:11:18.583650  / # /lava-10590257/bin/lava-test-runner /la=
va-10590257/1

    2023-06-05T10:11:18.737268  + export TESTRUN_ID=3D1_bootrr

    2023-06-05T10:11:18.737384  + cd /lava-10590257/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/647db7a2087730bde9f5de92

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/arm64/defconfig+arm64-chromebook/gcc-10/lab-brooni=
e/baseline-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/arm64/defconfig+arm64-chromebook/gcc-10/lab-brooni=
e/baseline-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/647db7a2087730bde=
9f5de93
        failing since 7 days (last pass: v5.10.180-cip33-21-g8eb0cdf459a2, =
first fail: v5.10.180-cip34) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/647db864b0bc05cc32f5de47

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/arm64/defconfig+arm64-chromebook/gcc-10/lab-collab=
ora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/arm64/defconfig+arm64-chromebook/gcc-10/lab-collab=
ora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/647db864b0bc05cc32f5de51
        failing since 75 days (last pass: v5.10.173-cip28, first fail: v5.1=
0.175-cip29)

    2023-06-05T10:26:38.759134  /lava-10590613/1/../bin/lava-test-case

    2023-06-05T10:26:38.788647  [   36.955427] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/647db864b0bc05cc32f5de52
        failing since 75 days (last pass: v5.10.173-cip28, first fail: v5.1=
0.175-cip29)

    2023-06-05T10:26:37.661131  /lava-10590613/1/../bin/lava-test-case

    2023-06-05T10:26:37.696519  [   35.863250] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/647db6ad29631f33e4f5de3c

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-su=
n50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-su=
n50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647db6ad29631f33e4f5de6c
        failing since 142 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-05T10:18:54.944449  <8>[   30.150030] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 562187_1.6.2.4.1>
    2023-06-05T10:18:55.058174  / # #
    2023-06-05T10:18:55.160170  export SHELL=3D/bin/sh
    2023-06-05T10:18:55.160651  #
    2023-06-05T10:18:55.262143  / # export SHELL=3D/bin/sh. /lava-562187/en=
vironment
    2023-06-05T10:18:55.262650  =

    2023-06-05T10:18:55.364147  / # . /lava-562187/environment/lava-562187/=
bin/lava-test-runner /lava-562187/1
    2023-06-05T10:18:55.365018  =

    2023-06-05T10:18:55.369362  / # /lava-562187/bin/lava-test-runner /lava=
-562187/1
    2023-06-05T10:18:55.492287  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =20

