Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C5EC83F11
	for <webhook@archiver.kernel.org>; Mon, 28 Aug 2023 01:53:16 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web10.5227.1693187587539398567
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 27 Aug 2023 18:53:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=lItcMgYw;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.177, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1bf11b1c7d0so24243055ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 27 Aug 2023 18:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1693187586; x=1693792386;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kdN/19YX4O7PUefKUOVXfwQtmkDQije6vrWvUXDAzIk=;
        b=lItcMgYwiCPqojRt2KbePxDdeYvLWpvrrZ6yjc3j9XNNeICXI+HOZolqNEIXUOHNoj
         BxczLoRaiDYjiqvzrfJHsrh7qjzncyrnzTtrmNuEVWD8S6qNNE3wprc/I/Mjba3EM2cP
         B1xMHuJlIKQhOqM+J9UYyhKOk8boYSn78dU2Elw2RiIhkyewcnq2woEd0aL/goFOLbH5
         i9DjySnzy27EIrNxw2uSXfC0wKvqHNUqrGO7BP5AeaTFE/Hmz5X5r2G5bow9aQ90VjVI
         z3gvCERhRfdv/Ws148KYFL2WQDSj2+PiJJ8iWwJkw32NBDcRZoa0BlDNwo5Zoix5OhY5
         J50w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693187586; x=1693792386;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kdN/19YX4O7PUefKUOVXfwQtmkDQije6vrWvUXDAzIk=;
        b=SkJHSG1LXbRpcGHdVpzTnDOqJ2D4aUw5cCLj0Zt7QRke/Tqxvjtmu1HDTOxZqIrlbW
         2sI88ZkLJaWuTLGw9TPvcEH0ZK4UOL1QqXpBXcIwW+URm1gp3g4oAbBKqRgJv1n5Z+jo
         exdfEXQ8qf1vbG8VAisLlG/fpdwDRKN8wHlOjO40vBWGiKrgvK4y4PRbpWmxhaJfVPDe
         SEr1IkHNpLDsDr8U2exWNW7CPf8fg9Bdc4Z9XOnNTM7fZaKo7y8fOY/Saba1A4eE00BD
         pujVOOttxJxg+XCe753RJmXqF7bOwu02xYO/MXwVq1p7KzYK3ifj45S5Z8VJFHGTom3y
         c4vQ==
X-Gm-Message-State: AOJu0YzgSJcB71/I2ZyEFCrBsSD4sELoStvIvWVObd3mPw18PbG1+aKJ
	K5xO120b7083SvvcMrLousvg8e8ZWvBpWwjC6us=
X-Google-Smtp-Source: AGHT+IHKRdIatSpHzhSSJFrW4vNFKnppUpp7k/qrUQZqNVxefmDot4NvlQkCB7AxSgZ8uvYCaXjkvg==
X-Received: by 2002:a17:902:f547:b0:1bd:ea18:925d with SMTP id h7-20020a170902f54700b001bdea18925dmr33292672plf.6.1693187586509;
        Sun, 27 Aug 2023 18:53:06 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902748600b001b2069072ccsm5933319pll.18.2023.08.27.18.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 18:53:06 -0700 (PDT)
Message-ID: <64ebfe02.170a0220.fe928.942c@mx.google.com>
Date: Sun, 27 Aug 2023 18:53:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.46-cip4
Subject: cip/linux-6.1.y-cip baseline: 145 runs, 7 regressions (v6.1.46-cip4)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Aug 2023 01:53:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12866

cip/linux-6.1.y-cip baseline: 145 runs, 7 regressions (v6.1.46-cip4)

Regressions Summary
-------------------

platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
acer-chromebox-cxi4-puff | x86_64 | lab-collabora   | gcc-10   | x86_64_def=
con...6-chromebook | 1          =

imx6dl-riotboard         | arm    | lab-pengutronix | gcc-10   | multi_v7_d=
efconfig           | 1          =

juno-uboot               | arm64  | lab-broonie     | gcc-10   | cip://6.1.=
y-c...64_defconfig | 2          =

juno-uboot               | arm64  | lab-broonie     | gcc-10   | defconfig =
                   | 1          =

r8a77960-ulcb            | arm64  | lab-collabora   | gcc-10   | defconfig =
                   | 1          =

sun50i-h6-pine-h64       | arm64  | lab-collabora   | gcc-10   | defconfig =
                   | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.46-cip4/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.46-cip4
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      58f7d1bf36cb697e7cab922b71d04f7d925e3b1f =



Test Regressions
---------------- =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
acer-chromebox-cxi4-puff | x86_64 | lab-collabora   | gcc-10   | x86_64_def=
con...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebed7baf2b6c8c5d286da1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.46-ci=
p4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-ace=
r-chromebox-cxi4-puff.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.46-ci=
p4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-ace=
r-chromebox-cxi4-puff.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ebed7baf2b6c8c5d286=
da2
        failing since 14 days (last pass: v6.1.42-cip2-1-g47d13938e615, fir=
st fail: v6.1.45-cip3) =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
imx6dl-riotboard         | arm    | lab-pengutronix | gcc-10   | multi_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebed1b3d9547b3fc286d7b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.46-ci=
p4/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6dl-riotboard.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.46-ci=
p4/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6dl-riotboard.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ebed1b3d9547b3fc286d84
        failing since 4 days (last pass: v6.1.42-cip2-1-g47d13938e615, firs=
t fail: v6.1.45-cip3-31-gc9451d303f3d)

    2023-08-28T00:40:36.278049  + set[   14.963129] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 998647_1.5.2.3.1>
    2023-08-28T00:40:36.278211   +x
    2023-08-28T00:40:36.383932  / # #
    2023-08-28T00:40:36.485562  export SHELL=3D/bin/sh
    2023-08-28T00:40:36.486051  #
    2023-08-28T00:40:36.587212  / # export SHELL=3D/bin/sh. /lava-998647/en=
vironment
    2023-08-28T00:40:36.587656  =

    2023-08-28T00:40:36.688953  / # . /lava-998647/environment/lava-998647/=
bin/lava-test-runner /lava-998647/1
    2023-08-28T00:40:36.689582  =

    2023-08-28T00:40:36.692516  / # /lava-998647/bin/lava-test-runner /lava=
-998647/1 =

    ... (12 line(s) more)  =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
juno-uboot               | arm64  | lab-broonie     | gcc-10   | cip://6.1.=
y-c...64_defconfig | 2          =


  Details:     https://kernelci.org/test/plan/id/64ebed92af2b6c8c5d286dac

  Results:     55 PASS, 5 FAIL, 1 SKIP
  Full config: cip://6.1.y-cip/arm64/qemu_arm64_defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.46-ci=
p4/arm64/cip---6.1.y-cip-arm64-qemu_arm64_defconfig/gcc-10/lab-broonie/base=
line-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.46-ci=
p4/arm64/cip---6.1.y-cip-arm64-qemu_arm64_defconfig/gcc-10/lab-broonie/base=
line-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.1c050000_mmc-probed: https://kernelci.org/test/case/id/=
64ebed92af2b6c8c5d286de3
        failing since 28 days (last pass: v6.1.31-65-ge66be31505fa, first f=
ail: v6.1.42-cip2)

    2023-08-28T00:42:41.689741  /lava-73555/1/../bin/lava-test-case
    2023-08-28T00:42:41.728497  <8>[   35.053667] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3D1c050000.mmc-probed RESULT=3Dfail>
    2023-08-28T00:42:41.729003  /lava-73555/1/../bin/lava-test-case   =


  * baseline.bootrr.ethernet-probed: https://kernelci.org/test/case/id/64eb=
ed92af2b6c8c5d286de5
        failing since 28 days (last pass: v6.1.31-65-ge66be31505fa, first f=
ail: v6.1.42-cip2)

    2023-08-28T00:42:40.634853  /lava-73555/1/../bin/lava-test-case
    2023-08-28T00:42:40.659871  <8>[   34.000311] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dethernet-probed RESULT=3Dfail>
    2023-08-28T00:42:40.660376  /lava-73555/1/../bin/lava-test-case   =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
juno-uboot               | arm64  | lab-broonie     | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebef71ab156a9673286d6e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.46-ci=
p4/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.46-ci=
p4/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ebef71ab156a9673286=
d6f
        new failure (last pass: v6.1.45-cip3-31-gc9451d303f3d) =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
r8a77960-ulcb            | arm64  | lab-collabora   | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebee751cd653e2a4286d94

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.46-ci=
p4/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.46-ci=
p4/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ebee751cd653e2a4286d9d
        failing since 28 days (last pass: v6.1.31-46-g4cc1cc26e90f, first f=
ail: v6.1.42-cip2)

    2023-08-28T00:48:18.140478  / # #

    2023-08-28T00:48:18.242615  export SHELL=3D/bin/sh

    2023-08-28T00:48:18.243315  #

    2023-08-28T00:48:18.344708  / # export SHELL=3D/bin/sh. /lava-11368125/=
environment

    2023-08-28T00:48:18.345450  =


    2023-08-28T00:48:18.446860  / # . /lava-11368125/environment/lava-11368=
125/bin/lava-test-runner /lava-11368125/1

    2023-08-28T00:48:18.447933  =


    2023-08-28T00:48:18.464592  / # /lava-11368125/bin/lava-test-runner /la=
va-11368125/1

    2023-08-28T00:48:18.512800  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-28T00:48:18.513323  + cd /lav<8>[   19.124195] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11368125_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
sun50i-h6-pine-h64       | arm64  | lab-collabora   | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebee8926e2d2d38a286d74

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.46-ci=
p4/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.46-ci=
p4/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ebee8926e2d2d38a286d7d
        failing since 28 days (last pass: v6.1.31-53-g486caac40d06, first f=
ail: v6.1.42-cip2)

    2023-08-28T00:48:31.938337  / # #

    2023-08-28T00:48:32.039026  export SHELL=3D/bin/sh

    2023-08-28T00:48:32.039158  #

    2023-08-28T00:48:32.139707  / # export SHELL=3D/bin/sh. /lava-11368116/=
environment

    2023-08-28T00:48:32.139880  =


    2023-08-28T00:48:32.240606  / # . /lava-11368116/environment/lava-11368=
116/bin/lava-test-runner /lava-11368116/1

    2023-08-28T00:48:32.241799  =


    2023-08-28T00:48:32.246490  / # /lava-11368116/bin/lava-test-runner /la=
va-11368116/1

    2023-08-28T00:48:32.326630  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-28T00:48:32.327135  + cd /lava-11368116/1/tests/1_boot<8>[   16=
.960297] <LAVA_SIGNAL_STARTRUN 1_bootrr 11368116_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20

