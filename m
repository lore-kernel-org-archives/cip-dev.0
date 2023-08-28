Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F27C83F10
	for <webhook@archiver.kernel.org>; Mon, 28 Aug 2023 00:24:15 +0000 (UTC)
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
 by mx.groups.io with SMTP id smtpd.web10.3804.1693182251759050442
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 27 Aug 2023 17:24:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=QkZDz5Zz;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.166.175, mailfrom: bot@kernelci.org)
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-34992058e95so9892115ab.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 27 Aug 2023 17:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1693182250; x=1693787050;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xqKQG05pdK5lVXYZYJP71CgzKjFp6Md9a7SnQIRjxvg=;
        b=QkZDz5ZzCBo8rETLgG4myCWdbTVqbOS6gq0Lf5Dx08UjGL5sVVHptLR/rnGcuchpl7
         y4sUbF7jjLdNhQFmFUk5k4eGb807llJU8w0zCiRSXrC9yNEMC83U+Baw7m0pCg1xLyV7
         4b7tCz+wxat6VqgMpUlyBZ7qGBJRNjCcxbhufOO/Pb1HGy0KdTHRYMC3xxoy6rZ6E4Sa
         GWlTcyiED/IhInJpAMWwLnkXzXBrpAxlmeOdSb+Z1sCCrQqkxt79PpHqLqBMshfTJDmG
         dlR8vKw3q0bdRiVub3t/cFRl7w5Twy6qKbPFgcgU6RKN5LwwpjMIH/bUGsM8dJkPMZww
         bZ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693182250; x=1693787050;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xqKQG05pdK5lVXYZYJP71CgzKjFp6Md9a7SnQIRjxvg=;
        b=Du98q+WtENIFXkGsagJpoXPAgcmNbMTeVNLzr6RaWYGvklTfKuogwtoPHlBNXnNUjY
         ozaWhZcR3R/Sjrq+nUqZPJ3qhSkTCwcrYzEVlua3HKiTaPxGPApmMmlYvfMk5DsPlJ3G
         fZv8ZjosRE3bB1uD0RuuMCDLpOixzpIAGuq7RvZCK4C39x7zb4OKk5YdTe2/aUYOdMyK
         6OyWR9UMGybeM2TTvkTfiaCOoMYm1RwRn+Jj+Nd2WyIsbWBNx7Jd5eCpcThqh7cTwsmB
         lcMhUHP3jupGACss8RseyX2yE7lC4mH1Jntb5lNALwLRDlvC1Ju14iXoWIbSq7y/nKfn
         q9GA==
X-Gm-Message-State: AOJu0YxwFV+KqA2M8884QGG8K+tA6uSmcxuy302UWgbuuDFpaNUhxJhK
	FiC4FeslrT90x5UKSp53nOl13KlugJQRMgbrpjY=
X-Google-Smtp-Source: AGHT+IFerfxHLH8dFLYrh5BnHOYSivhwYulN3JtjZohGkgDbltTrlpENhgTpyfT6y9cB3qUJbTodDA==
X-Received: by 2002:a05:6e02:1aaf:b0:347:223f:92f4 with SMTP id l15-20020a056e021aaf00b00347223f92f4mr19333777ilv.24.1693182250368;
        Sun, 27 Aug 2023 17:24:10 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id o29-20020a637e5d000000b00565e96d9874sm6033267pgn.89.2023.08.27.17.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 17:24:09 -0700 (PDT)
Message-ID: <64ebe929.630a0220.20ee2.77ab@mx.google.com>
Date: Sun, 27 Aug 2023 17:24:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.292-cip102
Subject: cip/linux-4.19.y-cip baseline: 141 runs,
 22 regressions (v4.19.292-cip102)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Aug 2023 00:24:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12859

cip/linux-4.19.y-cip baseline: 141 runs, 22 regressions (v4.19.292-cip102)

Regressions Summary
-------------------

platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
at91sam9g20ek              | arm   | lab-broonie   | gcc-10   | multi_v5_de=
fconfig           | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-collabora | gcc-10   | defconfig  =
                  | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-collabora | gcc-10   | defconfig  =
                  | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | cip://4.19.=
y-...64_defconfig | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-collabora | gcc-10   | cip://4.19.=
y-...64_defconfig | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-collabora | gcc-10   | defconfig  =
                  | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-collabora | gcc-10   | defconfig  =
                  | 1          =

r8a7743-iwg20d-q7          | arm   | lab-cip       | gcc-10   | shmobile_de=
fconfig           | 1          =

rk3399-gru-kevin           | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.292-cip102/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.292-cip102
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      372689399d20f850142c3d734cb4365cd8a31242 =



Test Regressions
---------------- =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
at91sam9g20ek              | arm   | lab-broonie   | gcc-10   | multi_v5_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebe19b12c41d8520286db6

  Results:     42 PASS, 9 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.292=
-cip102/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.292=
-cip102/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g20ek.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ebe19b12c41d8520286dec
        failing since 167 days (last pass: v4.19.273-cip92, first fail: v4.=
19.276-cip93)

    2023-08-27T23:51:15.037380  + set +x
    2023-08-27T23:51:15.042078  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 73495_1.5.2.=
4.1>
    2023-08-27T23:51:15.156247  / # #
    2023-08-27T23:51:15.259279  export SHELL=3D/bin/sh
    2023-08-27T23:51:15.260158  #
    2023-08-27T23:51:15.362114  / # export SHELL=3D/bin/sh. /lava-73495/env=
ironment
    2023-08-27T23:51:15.362994  =

    2023-08-27T23:51:15.465265  / # . /lava-73495/environment/lava-73495/bi=
n/lava-test-runner /lava-73495/1
    2023-08-27T23:51:15.466839  =

    2023-08-27T23:51:15.472493  / # /lava-73495/bin/lava-test-runner /lava-=
73495/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebe30f38be2d6945286d7e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.292=
-cip102/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_a=
rm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.292=
-cip102/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_a=
rm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ebe30f38be2d6945286=
d7f
        failing since 369 days (last pass: v4.19.226-cip66, first fail: v4.=
19.255-cip79) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebe4ef9a4ff43b8b286d75

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.292=
-cip102/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.292=
-cip102/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ebe4ef9a4ff43b8b286=
d76
        failing since 369 days (last pass: v4.19.226-cip66, first fail: v4.=
19.255-cip79) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebe19c54a00d5a56286dc6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.292=
-cip102/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu=
_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.292=
-cip102/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu=
_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ebe19c54a00d5a56286=
dc7
        failing since 369 days (last pass: v4.19.226-cip66, first fail: v4.=
19.255-cip79) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebe3043278ac6ffe286d89

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.292=
-cip102/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.292=
-cip102/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ebe3043278ac6ffe286=
d8a
        failing since 369 days (last pass: v4.19.226-cip66, first fail: v4.=
19.255-cip79) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebe3373278ac6ffe286d92

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.292=
-cip102/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_a=
rm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.292=
-cip102/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_a=
rm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ebe3373278ac6ffe286=
d93
        failing since 369 days (last pass: v4.19.226-cip66, first fail: v4.=
19.255-cip79) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebe52bec80a2af87286d78

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.292=
-cip102/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-u=
efi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.292=
-cip102/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-u=
efi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ebe52bec80a2af87286=
d79
        failing since 369 days (last pass: v4.19.226-cip66, first fail: v4.=
19.255-cip79) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebe19e54a00d5a56286dd2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.292=
-cip102/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu=
_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.292=
-cip102/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu=
_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ebe19e54a00d5a56286=
dd3
        failing since 369 days (last pass: v4.19.226-cip66, first fail: v4.=
19.255-cip79) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebe30438be2d6945286d7a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.292=
-cip102/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2=
-uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.292=
-cip102/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2=
-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ebe30438be2d6945286=
d7b
        failing since 369 days (last pass: v4.19.226-cip66, first fail: v4.=
19.255-cip79) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | cip://4.19.=
y-...64_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebe58f9a5657df01286d6c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: cip://4.19.y-cip/arm64/qemu_arm64_defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.292=
-cip102/arm64/cip---4.19.y-cip-arm64-qemu_arm64_defconfig/gcc-10/lab-brooni=
e/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.292=
-cip102/arm64/cip---4.19.y-cip-arm64-qemu_arm64_defconfig/gcc-10/lab-brooni=
e/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ebe58f9a5657df01286=
d6d
        failing since 369 days (last pass: v4.19.226-cip66, first fail: v4.=
19.255-cip79) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-collabora | gcc-10   | cip://4.19.=
y-...64_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebe3a56453dacea0286d8d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: cip://4.19.y-cip/arm64/qemu_arm64_defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.292=
-cip102/arm64/cip---4.19.y-cip-arm64-qemu_arm64_defconfig/gcc-10/lab-collab=
ora/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.292=
-cip102/arm64/cip---4.19.y-cip-arm64-qemu_arm64_defconfig/gcc-10/lab-collab=
ora/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ebe3a56453dacea0286=
d8e
        failing since 369 days (last pass: v4.19.226-cip66, first fail: v4.=
19.255-cip79) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebe2e738be2d6945286d74

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.292=
-cip102/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_a=
rm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.292=
-cip102/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_a=
rm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ebe2e738be2d6945286=
d75
        failing since 369 days (last pass: v4.19.226-cip66, first fail: v4.=
19.255-cip79) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebe4d59a4ff43b8b286d6e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.292=
-cip102/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.292=
-cip102/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ebe4d59a4ff43b8b286=
d6f
        failing since 369 days (last pass: v4.19.226-cip66, first fail: v4.=
19.255-cip79) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebe19c54a00d5a56286dcb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.292=
-cip102/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu=
_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.292=
-cip102/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu=
_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ebe19c54a00d5a56286=
dcc
        failing since 369 days (last pass: v4.19.226-cip66, first fail: v4.=
19.255-cip79) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebe2c838be2d6945286d70

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.292=
-cip102/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.292=
-cip102/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ebe2c838be2d6945286=
d71
        failing since 369 days (last pass: v4.19.226-cip66, first fail: v4.=
19.255-cip79) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebe2fb38be2d6945286d77

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.292=
-cip102/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_a=
rm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.292=
-cip102/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_a=
rm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ebe2fb38be2d6945286=
d78
        failing since 369 days (last pass: v4.19.226-cip66, first fail: v4.=
19.255-cip79) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebe4dbcc6158ed35286d6c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.292=
-cip102/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-u=
efi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.292=
-cip102/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-u=
efi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ebe4dbcc6158ed35286=
d6d
        failing since 369 days (last pass: v4.19.226-cip66, first fail: v4.=
19.255-cip79) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebe19d12c41d8520286df1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.292=
-cip102/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu=
_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.292=
-cip102/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu=
_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ebe19d12c41d8520286=
df2
        failing since 369 days (last pass: v4.19.226-cip66, first fail: v4.=
19.255-cip79) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebe2eff75153bfca286d9c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.292=
-cip102/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3=
-uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.292=
-cip102/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3=
-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ebe2eff75153bfca286=
d9d
        failing since 369 days (last pass: v4.19.226-cip66, first fail: v4.=
19.255-cip79) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
r8a7743-iwg20d-q7          | arm   | lab-cip       | gcc-10   | shmobile_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebe1ac03e49531d5286daf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.292=
-cip102/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.292=
-cip102/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-iwg20d-q7.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ebe1ac03e49531d5286=
db0
        new failure (last pass: v4.19.288-cip101) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin           | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64ebe0b3d7a685b3ec286d81

  Results:     77 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.292=
-cip102/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk33=
99-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.292=
-cip102/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk33=
99-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/64ebe0b3d7a685b3ec286d8b
        failing since 158 days (last pass: v4.19.276-cip93, first fail: v4.=
19.277-cip94)

    2023-08-27T23:48:53.867391  /lava-11367965/1/../bin/lava-test-case<8>[ =
  37.434004] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Drockchip-usb2phy1-probed =
RESULT=3Dfail>

    2023-08-27T23:48:53.868049  =

   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/64ebe0b3d7a685b3ec286d8c
        failing since 158 days (last pass: v4.19.276-cip93, first fail: v4.=
19.277-cip94)

    2023-08-27T23:48:52.835704  /lava-11367965/1/../bin/lava-test-case

    2023-08-27T23:48:52.844776  <8>[   36.411614] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =20

