Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F1DEB8FDD
	for <webhook@archiver.kernel.org>; Wed,  6 Sep 2023 14:16:13 +0000 (UTC)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
 by mx.groups.io with SMTP id smtpd.web11.9968.1694009771494921812
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 06 Sep 2023 07:16:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=S9t3Hh7g;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.175, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-68a410316a2so2546174b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 06 Sep 2023 07:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694009770; x=1694614570; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=C7xzXmN+zZ5omkyJPFRkEURJORlkxHERRKoP9PCdphE=;
        b=S9t3Hh7gy1CJ/Mb//YGyJgqYhcf69eHkhh+f2sC8ZSFd2WHtY9CUcnqMZ5Tz7oOybT
         5ixI2VE7ps5rCsYgkhr9rWu1fZYUg4ytrDf1sBdZakGieWCck8pMc5tgzQmSK2G9o5jQ
         UKuNEPKJUv8T/U+ADuRO/Vc0Pz3gq2e5MA1VT3KpCuAqRXXs9rHaT0KAAqcHqcbnTLPx
         yFy9hYzUuYtLVbBa08Mh9ovvK8NJD1Ycuuyt0CFmZoMhbcgz9D2IT/OysXCx5na9dCon
         k/7m+n58O6MJLTxtW8D7+DBrux5hkafINog5I/F4EyeD3+oeIi61E0V3NC6atb3tYsfr
         cSog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694009770; x=1694614570;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C7xzXmN+zZ5omkyJPFRkEURJORlkxHERRKoP9PCdphE=;
        b=ZO3FIIhHtnW+cY4othrEH/ZP2pMd7ednWI+/S87ZvRE7YwFrs5vZ7MD6gMVDq+l4lC
         QKS1sRZGYhVF61j43KTvSW/AqW7F4G0hvd8B6jx1pB6gS+oVqGcg2IGtZjZYAqr0pSAa
         hWrOLCkVVZsunEMKtXj3x8ufvF+cQh/MZ/lsGIjRZRHn5K6EbT7aCX2ly2gQwdSjgxOJ
         Q412I5kIySfCHBTVYaz1du1hDaX3nfYc7jvETuBE8SevsdNZmiGRhF25OVBsnFvOl7Pc
         /Stvn9l5A8XRQOm8LeV2uCR9wI62u9KGIXvo2lcUbgSB09qWKio/btdTfP+7gWMrVTWO
         gmdw==
X-Gm-Message-State: AOJu0YxTfoSmcUUofnX+YQgeh9iOetOI6PSBQ3sh+wkMQ7KdZefj6kIn
	0kW7tbpKZic5wuwyqWaY/YGy0mA5TwGuHGWtaYo=
X-Google-Smtp-Source: AGHT+IGAlIGIFwwk5XnhCaS2lX3QduoX8qPbmxUcu48Bn26UyKKTQh/Pko6JPeyU/tmPCgBvqd8i5g==
X-Received: by 2002:a05:6a00:124c:b0:68a:4e3c:eb43 with SMTP id u12-20020a056a00124c00b0068a4e3ceb43mr15328103pfi.10.1694009770287;
        Wed, 06 Sep 2023 07:16:10 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d6-20020aa78686000000b00666b3706be6sm10927833pfo.107.2023.09.06.07.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 07:16:09 -0700 (PDT)
Message-ID: <64f889a9.a70a0220.bda5.773f@mx.google.com>
Date: Wed, 06 Sep 2023 07:16:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.46-cip4-14-g09ffd7fb38ff
Subject: cip/linux-6.1.y-cip baseline: 140 runs,
 6 regressions (v6.1.46-cip4-14-g09ffd7fb38ff)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Sep 2023 14:16:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12992

cip/linux-6.1.y-cip baseline: 140 runs, 6 regressions (v6.1.46-cip4-14-g09f=
fd7fb38ff)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
acer-chromebox-cxi4-puff | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =

fsl-ls2088a-rdb          | arm64  | lab-nxp       | gcc-10   | defconfig+ks=
elftest          | 1          =

juno-uboot               | arm64  | lab-broonie   | gcc-10   | cip://6.1.y-=
c...64_defconfig | 2          =

r8a77960-ulcb            | arm64  | lab-collabora | gcc-10   | defconfig   =
                 | 1          =

sun50i-h6-pine-h64       | arm64  | lab-collabora | gcc-10   | defconfig   =
                 | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.46-cip4-14-g09ffd7fb38ff/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.46-cip4-14-g09ffd7fb38ff
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      09ffd7fb38ffdf82d678f31aa0cdf232090410d5 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
acer-chromebox-cxi4-puff | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f87dd9b343c99bab286d90

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.46-ci=
p4-14-g09ffd7fb38ff/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-acer-chromebox-cxi4-puff.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.46-ci=
p4-14-g09ffd7fb38ff/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-acer-chromebox-cxi4-puff.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f87dd9b343c99bab286=
d91
        failing since 23 days (last pass: v6.1.42-cip2-1-g47d13938e615, fir=
st fail: v6.1.45-cip3) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
fsl-ls2088a-rdb          | arm64  | lab-nxp       | gcc-10   | defconfig+ks=
elftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64f881d2a4e08de4be286d7a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.46-ci=
p4-14-g09ffd7fb38ff/arm64/defconfig+kselftest/gcc-10/lab-nxp/baseline-fsl-l=
s2088a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.46-ci=
p4-14-g09ffd7fb38ff/arm64/defconfig+kselftest/gcc-10/lab-nxp/baseline-fsl-l=
s2088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f881d2a4e08de4be286=
d7b
        new failure (last pass: v6.1.46-cip4) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
juno-uboot               | arm64  | lab-broonie   | gcc-10   | cip://6.1.y-=
c...64_defconfig | 2          =


  Details:     https://kernelci.org/test/plan/id/64f87d4af55a8f20d0286eba

  Results:     55 PASS, 5 FAIL, 1 SKIP
  Full config: cip://6.1.y-cip/arm64/qemu_arm64_defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.46-ci=
p4-14-g09ffd7fb38ff/arm64/cip---6.1.y-cip-arm64-qemu_arm64_defconfig/gcc-10=
/lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.46-ci=
p4-14-g09ffd7fb38ff/arm64/cip---6.1.y-cip-arm64-qemu_arm64_defconfig/gcc-10=
/lab-broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.1c050000_mmc-probed: https://kernelci.org/test/case/id/=
64f87d4af55a8f20d0286eec
        failing since 37 days (last pass: v6.1.31-65-ge66be31505fa, first f=
ail: v6.1.42-cip2)

    2023-09-06T13:23:05.756881  /lava-89135/1/../bin/lava-test-case
    2023-09-06T13:23:05.794625  <8>[   35.062874] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3D1c050000.mmc-probed RESULT=3Dfail>
    2023-09-06T13:23:05.795155  /lava-89135/1/../bin/lava-test-case   =


  * baseline.bootrr.ethernet-probed: https://kernelci.org/test/case/id/64f8=
7d4af55a8f20d0286eee
        failing since 37 days (last pass: v6.1.31-65-ge66be31505fa, first f=
ail: v6.1.42-cip2)

    2023-09-06T13:23:04.701862  /lava-89135/1/../bin/lava-test-case
    2023-09-06T13:23:04.726886  <8>[   34.010653] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dethernet-probed RESULT=3Dfail>
    2023-09-06T13:23:04.727418  /lava-89135/1/../bin/lava-test-case   =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
r8a77960-ulcb            | arm64  | lab-collabora | gcc-10   | defconfig   =
                 | 1          =


  Details:     https://kernelci.org/test/plan/id/64f882fae73077fdd3286d6e

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.46-ci=
p4-14-g09ffd7fb38ff/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.46-ci=
p4-14-g09ffd7fb38ff/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f882fae73077fdd3286d73
        failing since 37 days (last pass: v6.1.31-46-g4cc1cc26e90f, first f=
ail: v6.1.42-cip2)

    2023-09-06T13:48:56.315385  / # #

    2023-09-06T13:48:56.417629  export SHELL=3D/bin/sh

    2023-09-06T13:48:56.418335  #

    2023-09-06T13:48:56.519709  / # export SHELL=3D/bin/sh. /lava-11445946/=
environment

    2023-09-06T13:48:56.520416  =


    2023-09-06T13:48:56.621814  / # . /lava-11445946/environment/lava-11445=
946/bin/lava-test-runner /lava-11445946/1

    2023-09-06T13:48:56.622959  =


    2023-09-06T13:48:56.639934  / # /lava-11445946/bin/lava-test-runner /la=
va-11445946/1

    2023-09-06T13:48:56.687858  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-06T13:48:56.688357  + cd /lava-114459<8>[   19.068467] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11445946_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
sun50i-h6-pine-h64       | arm64  | lab-collabora | gcc-10   | defconfig   =
                 | 1          =


  Details:     https://kernelci.org/test/plan/id/64f882fedcb4f7ff71286e12

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.46-ci=
p4-14-g09ffd7fb38ff/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.46-ci=
p4-14-g09ffd7fb38ff/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f882fedcb4f7ff71286e17
        failing since 37 days (last pass: v6.1.31-53-g486caac40d06, first f=
ail: v6.1.42-cip2)

    2023-09-06T13:49:09.130518  / # #

    2023-09-06T13:49:09.232705  export SHELL=3D/bin/sh

    2023-09-06T13:49:09.233483  #

    2023-09-06T13:49:09.334924  / # export SHELL=3D/bin/sh. /lava-11445951/=
environment

    2023-09-06T13:49:09.335663  =


    2023-09-06T13:49:09.437088  / # . /lava-11445951/environment/lava-11445=
951/bin/lava-test-runner /lava-11445951/1

    2023-09-06T13:49:09.438271  =


    2023-09-06T13:49:09.454493  / # /lava-11445951/bin/lava-test-runner /la=
va-11445951/1

    2023-09-06T13:49:09.522759  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-06T13:49:09.523260  + cd /lava-1144595<8>[   17.012953] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11445951_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20

