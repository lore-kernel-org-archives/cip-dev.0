Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E609C61D97
	for <webhook@archiver.kernel.org>; Fri, 24 Nov 2023 11:37:16 +0000 (UTC)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
 by mx.groups.io with SMTP id smtpd.web10.133495.1700825831310157209
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 24 Nov 2023 03:37:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=QFuhGk0L;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.44, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-27ff83feb29so1524745a91.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 24 Nov 2023 03:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700825830; x=1701430630; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NP+qN4RcD0GTLcHwa8hh4Q9OZ+BBaOQ8JclzMZX5ZZk=;
        b=QFuhGk0Lm5BdadwkMkcuXnPlyRj4BvqUeZXy7b7ROtmgWvSZV9UKM4jTZ09YpEDNVq
         OIjgzxWwU0DHrMoEu3kDyYO/DGMTPPY/B64b6ysIebEM7tYK3L/B+jsXpZ+nCoMmz3Lx
         WopgyXxKDFl5ZCyXsAM0jLDJtHuVdn0GXaOZuOR/db6nfLcZYeXyKo5SUe6oTRQUMgTw
         Sp60gSEXGnwKGbV18NpMbsd19P+ZUhBUKMEI1NYDThWf5if+JAGJ8poOCk2KsCk+/UwN
         HeNJ8bAKR6uxmfSsYhFo9COrozEQ0PXAMRp+EYnxN6OWLAUViaD+lN0wUwyOBrX9W7xG
         pdiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700825830; x=1701430630;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NP+qN4RcD0GTLcHwa8hh4Q9OZ+BBaOQ8JclzMZX5ZZk=;
        b=HtfM/8KEamsnX0gNDZpFUBBlt4NzWM2LY2ra3L5qB0QkLS5eorGi2OqCyKKyMOSxj8
         /S25qp8aa/O4z8u54XkNGk61f+jJif3lFUYzriexB0Ect9XC6yBHaAUX71FZuPNbb+tb
         EzMSfQo3M3XcWOrASjL/tjfRUPNnM0eLoR0TDD4PnblfV7eqebvG5HN4CZWZAScUD6r2
         6JEj1mJ6k2FcSIpXNisjppC5Vrigh/patz0rVXg1t9Vo/d97VTBgjBge58lsObqoU4nh
         0CNhDOtfVZ6KMVSjFeYyg+unWcE5eDvFfQEt2TVDhWHpN/SHsK+asCvHUtSI1cB54Bcf
         0MQA==
X-Gm-Message-State: AOJu0Yyxc3u2Q/nMTokqPsGNag76Ce9NPzSk+fazFYuvhCVnZhxeCh6w
	qea6hrNrkvLCnVwUvKs1ImapDzb8fUBJNniZIpc=
X-Google-Smtp-Source: AGHT+IH0aN2mBsGVAIPc7FFjP2b+zWiRYevVILAVurIgA/F49jkDNb+FVJyJVlTbDBUaqKVtEG9hBg==
X-Received: by 2002:a17:90a:1944:b0:280:235:19d with SMTP id 4-20020a17090a194400b002800235019dmr2443015pjh.36.1700825830101;
        Fri, 24 Nov 2023 03:37:10 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p16-20020a17090adf9000b00283991e2b8esm2764708pjv.57.2023.11.24.03.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 03:37:09 -0800 (PST)
Message-ID: <65608ae5.170a0220.2cc90.60a0@mx.google.com>
Date: Fri, 24 Nov 2023 03:37:09 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.201-cip41-11-ga539098fe70dd
Subject: cip/linux-5.10.y-cip baseline-nfs: 47 runs,
 11 regressions (v5.10.201-cip41-11-ga539098fe70dd)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Nov 2023 11:37:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13726

cip/linux-5.10.y-cip baseline-nfs: 47 runs, 11 regressions (v5.10.201-cip41=
-11-ga539098fe70dd)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
       | regressions
-------------------------+-------+---------------+----------+--------------=
-------+------------
beaglebone-black         | arm   | lab-broonie   | gcc-10   | multi_v7_defc=
onfig  | 1          =

beaglebone-black         | arm   | lab-cip       | gcc-10   | multi_v7_defc=
onfig  | 1          =

beaglebone-black         | arm   | lab-broonie   | gcc-10   | omap2plus_def=
config | 1          =

beaglebone-black         | arm   | lab-cip       | gcc-10   | omap2plus_def=
config | 1          =

imx6q-sabrelite          | arm   | lab-collabora | gcc-10   | multi_v7_defc=
onfig  | 1          =

juno-uboot               | arm64 | lab-broonie   | gcc-10   | defconfig+kse=
lftest | 1          =

juno-uboot               | arm64 | lab-broonie   | gcc-10   | defconfig    =
       | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+kse=
lftest | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
       | 1          =

rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig+kse=
lftest | 1          =

rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig    =
       | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-11-ga539098fe70dd/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-11-ga539098fe70dd
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a539098fe70dd29de0ce67ad5a39c40867ba5b2c =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
       | regressions
-------------------------+-------+---------------+----------+--------------=
-------+------------
beaglebone-black         | arm   | lab-broonie   | gcc-10   | multi_v7_defc=
onfig  | 1          =


  Details:     https://kernelci.org/test/plan/id/656084f9b276184e147e4a6e

  Results:     14 PASS, 4 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline=
-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline=
-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/656084f9b276184e147e4a83
        failing since 314 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-11-24T11:10:24.178708  + set +x
    2023-11-24T11:10:24.182527  <8>[   79.226236] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 269338_1.6.2.4.1>
    2023-11-24T11:10:27.777245  #
    2023-11-24T11:10:27.880584  / # #export SHELL=3D/bin/sh
    2023-11-24T11:10:27.881492  =

    2023-11-24T11:10:27.983565  / # export SHELL=3D/bin/sh. /lava-269338/en=
vironment
    2023-11-24T11:10:27.984448  =

    2023-11-24T11:10:28.086619  / # . /lava-269338/environment/lava-269338/=
bin/lava-test-runner /lava-269338/1
    2023-11-24T11:10:28.088061  =

    2023-11-24T11:10:28.091745  / # /lava-269338/bin/lava-test-runner /lava=
-269338/1 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
       | regressions
-------------------------+-------+---------------+----------+--------------=
-------+------------
beaglebone-black         | arm   | lab-cip       | gcc-10   | multi_v7_defc=
onfig  | 1          =


  Details:     https://kernelci.org/test/plan/id/656084b6f88598e4507e4a6f

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs=
-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs=
-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/656084b7f88598e4507e4aa0
        failing since 314 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-11-24T11:09:48.771451  + set +x
    2023-11-24T11:09:48.775728  <8>[   49.860131] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1044708_1.6.2.4.1>
    2023-11-24T11:09:48.966201  #
    2023-11-24T11:09:49.068519  / # #export SHELL=3D/bin/sh
    2023-11-24T11:09:49.069177  =

    2023-11-24T11:09:49.170473  / # export SHELL=3D/bin/sh. /lava-1044708/e=
nvironment
    2023-11-24T11:09:49.171125  =

    2023-11-24T11:09:49.272437  / # . /lava-1044708/environment/lava-104470=
8/bin/lava-test-runner /lava-1044708/1
    2023-11-24T11:09:49.273498  =

    2023-11-24T11:09:49.280031  / # /lava-1044708/bin/lava-test-runner /lav=
a-1044708/1 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
       | regressions
-------------------------+-------+---------------+----------+--------------=
-------+------------
beaglebone-black         | arm   | lab-broonie   | gcc-10   | omap2plus_def=
config | 1          =


  Details:     https://kernelci.org/test/plan/id/6560828a5cd5071ea57e4b25

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm/omap2plus_defconfig/gcc-10/lab-broonie/baselin=
e-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm/omap2plus_defconfig/gcc-10/lab-broonie/baselin=
e-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6560828a5cd5071ea57e4b5c
        failing since 314 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-11-24T11:01:04.936604  + set +x
    2023-11-24T11:01:04.940773  <8>[   95.175555] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 269262_1.6.2.4.1>
    2023-11-24T11:01:05.061704  / # #
    2023-11-24T11:01:05.163118  export SHELL=3D/bin/sh
    2023-11-24T11:01:05.163484  #
    2023-11-24T11:01:05.264606  / # export SHELL=3D/bin/sh. /lava-269262/en=
vironment
    2023-11-24T11:01:05.264966  =

    2023-11-24T11:01:05.366088  / # . /lava-269262/environment/lava-269262/=
bin/lava-test-runner /lava-269262/1
    2023-11-24T11:01:05.366685  =

    2023-11-24T11:01:05.371140  / # /lava-269262/bin/lava-test-runner /lava=
-269262/1 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
       | regressions
-------------------------+-------+---------------+----------+--------------=
-------+------------
beaglebone-black         | arm   | lab-cip       | gcc-10   | omap2plus_def=
config | 1          =


  Details:     https://kernelci.org/test/plan/id/6560831c1ca3fef84e7e4a84

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nf=
s-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nf=
s-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6560831c1ca3fef84e7e4abe
        failing since 314 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-11-24T11:03:39.314053  <8>[   40.382889] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1044675_1.6.2.4.1>
    2023-11-24T11:03:39.434394  / # #
    2023-11-24T11:03:39.535773  export SHELL=3D/bin/sh
    2023-11-24T11:03:39.536204  #
    2023-11-24T11:03:39.637173  / # export SHELL=3D/bin/sh. /lava-1044675/e=
nvironment
    2023-11-24T11:03:39.637790  =

    2023-11-24T11:03:39.738938  / # . /lava-1044675/environment/lava-104467=
5/bin/lava-test-runner /lava-1044675/1
    2023-11-24T11:03:39.739781  =

    2023-11-24T11:03:39.743867  / # /lava-1044675/bin/lava-test-runner /lav=
a-1044675/1
    2023-11-24T11:03:39.995160  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
       | regressions
-------------------------+-------+---------------+----------+--------------=
-------+------------
imx6q-sabrelite          | arm   | lab-collabora | gcc-10   | multi_v7_defc=
onfig  | 1          =


  Details:     https://kernelci.org/test/plan/id/6560845ea34edd2d127e4a77

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-nfs-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-nfs-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6560845ea34edd2d127e4a7e
        failing since 314 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-11-24T11:12:54.068763  / # #

    2023-11-24T11:12:54.170891  export SHELL=3D/bin/sh

    2023-11-24T11:12:54.171583  #

    2023-11-24T11:12:54.272962  / # export SHELL=3D/bin/sh. /lava-12073832/=
environment

    2023-11-24T11:12:54.273664  =


    2023-11-24T11:12:54.375221  / # . /lava-12073832/environment/lava-12073=
832/bin/lava-test-runner /lava-12073832/1

    2023-11-24T11:12:54.376338  =


    2023-11-24T11:12:54.393121  / # /lava-12073832/bin/lava-test-runner /la=
va-12073832/1

    2023-11-24T11:12:54.552814  + export TESTRUN_ID=3D1_bootrr

    2023-11-24T11:12:54.553230  + cd /lava-12073832/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
       | regressions
-------------------------+-------+---------------+----------+--------------=
-------+------------
juno-uboot               | arm64 | lab-broonie   | gcc-10   | defconfig+kse=
lftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6560892092748b9dda7e4a81

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm64/defconfig+kselftest/gcc-10/lab-broonie/basel=
ine-nfs-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm64/defconfig+kselftest/gcc-10/lab-broonie/basel=
ine-nfs-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6560892092748b9dda7e4abb
        new failure (last pass: v5.10.200-cip40)

    2023-11-24T11:28:51.010219  <8>[   50.856170] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 269267_1.6.2.4.1>
    2023-11-24T11:28:51.129027  / # #
    2023-11-24T11:28:51.231810  export SHELL=3D/bin/sh
    2023-11-24T11:28:51.232551  #
    2023-11-24T11:28:51.334461  / # export SHELL=3D/bin/sh. /lava-269267/en=
vironment
    2023-11-24T11:28:51.335263  =

    2023-11-24T11:28:51.437187  / # . /lava-269267/environment/lava-269267/=
bin/lava-test-runner /lava-269267/1
    2023-11-24T11:28:51.438469  =

    2023-11-24T11:28:51.457716  / # /lava-269267/bin/lava-test-runner /lava=
-269267/1
    2023-11-24T11:28:51.837156  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
       | regressions
-------------------------+-------+---------------+----------+--------------=
-------+------------
juno-uboot               | arm64 | lab-broonie   | gcc-10   | defconfig    =
       | 1          =


  Details:     https://kernelci.org/test/plan/id/65608a4cac4a59410d7e4b68

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-ju=
no-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-ju=
no-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65608a4cac4a59410d7e4ba8
        failing since 50 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.194-cip39-1-g53e59f50ca3ff)

    2023-11-24T11:34:11.690461  / # #
    2023-11-24T11:34:11.793289  export SHELL=3D/bin/sh
    2023-11-24T11:34:11.794111  #
    2023-11-24T11:34:11.896054  / # export SHELL=3D/bin/sh. /lava-269303/en=
vironment
    2023-11-24T11:34:11.896827  =

    2023-11-24T11:34:11.998754  / # . /lava-269303/environment/lava-269303/=
bin/lava-test-runner /lava-269303/1
    2023-11-24T11:34:12.000067  =

    2023-11-24T11:34:12.019197  / # /lava-269303/bin/lava-test-runner /lava=
-269303/1
    2023-11-24T11:34:12.184829  + export TESTRUN_ID=3D1_bootrr
    2023-11-24T11:34:12.185350  + cd /lava-269303/1/tests/1_bootrr =

    ... (9 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
       | regressions
-------------------------+-------+---------------+----------+--------------=
-------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+kse=
lftest | 1          =


  Details:     https://kernelci.org/test/plan/id/656081d11fce80641a7e4a96

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-=
nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-=
nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/656081d11fce80641=
a7e4a97
        failing since 100 days (last pass: v5.10.186-cip37-13-g260094841fe1=
a, first fail: v5.10.186-cip37-14-gc9b5a049d8ea) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
       | regressions
-------------------------+-------+---------------+----------+--------------=
-------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
       | 1          =


  Details:     https://kernelci.org/test/plan/id/656083261ca3fef84e7e4add

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm64/defconfig/gcc-10/lab-cip/baseline-nfs-r8a774=
a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm64/defconfig/gcc-10/lab-cip/baseline-nfs-r8a774=
a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/656083261ca3fef84=
e7e4ade
        failing since 50 days (last pass: v5.10.194-cip39, first fail: v5.1=
0.194-cip39-1-g53e59f50ca3ff) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
       | regressions
-------------------------+-------+---------------+----------+--------------=
-------+------------
rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig+kse=
lftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6560818ed5e824b2e07e4a81

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm64/defconfig+kselftest/gcc-10/lab-collabora/bas=
eline-nfs-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm64/defconfig+kselftest/gcc-10/lab-collabora/bas=
eline-nfs-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6560818ed5e824b2e07e4a8a
        failing since 50 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.194-cip39-1-g53e59f50ca3ff)

    2023-11-24T10:56:56.943685  / # #

    2023-11-24T10:56:58.204282  export SHELL=3D/bin/sh

    2023-11-24T10:56:58.215243  #

    2023-11-24T10:56:59.959568  / # export SHELL=3D/bin/sh. /lava-12073791/=
environment

    2023-11-24T10:56:59.970522  =


    2023-11-24T10:57:03.156221  / # . /lava-12073791/environment/lava-12073=
791/bin/lava-test-runner /lava-12073791/1

    2023-11-24T10:57:03.166642  =


    2023-11-24T10:57:03.169961  / # /lava-12073791/bin/lava-test-runner /la=
va-12073791/1

    2023-11-24T10:57:03.554459  + export TESTRUN_ID=3D1_bootrr

    2023-11-24T10:57:03.554564  + cd /lava-12073791/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
       | regressions
-------------------------+-------+---------------+----------+--------------=
-------+------------
rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig    =
       | 1          =


  Details:     https://kernelci.org/test/plan/id/656081bb36ed1da9207e4abb

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm64/defconfig/gcc-10/lab-collabora/baseline-nfs-=
rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm64/defconfig/gcc-10/lab-collabora/baseline-nfs-=
rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/656081bc36ed1da9207e4ac4
        failing since 50 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.194-cip39-1-g53e59f50ca3ff)

    2023-11-24T10:58:00.829751  / # #

    2023-11-24T10:58:02.090378  export SHELL=3D/bin/sh

    2023-11-24T10:58:02.101307  #

    2023-11-24T10:58:02.101831  / # export SHELL=3D/bin/sh

    2023-11-24T10:58:03.844479  / # . /lava-12073808/environment

    2023-11-24T10:58:07.049515  /lava-12073808/bin/lava-test-runner /lava-1=
2073808/1

    2023-11-24T10:58:07.060825  . /lava-12073808/environment

    2023-11-24T10:58:07.064495  / # /lava-12073808/bin/lava-test-runner /la=
va-12073808/1

    2023-11-24T10:58:07.244777  + export TESTRUN_ID=3D1_bootrr

    2023-11-24T10:58:07.244901  + cd /lava-12073808/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =20

