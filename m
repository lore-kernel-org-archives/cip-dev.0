Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D956EC001DF
	for <webhook@archiver.kernel.org>; Mon, 31 Jul 2023 00:45:23 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.web11.85470.1690764314610720361
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 30 Jul 2023 17:45:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=ii7nc9jM;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.173, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1bbf3da0ea9so12004495ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 30 Jul 2023 17:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690764314; x=1691369114;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iLblvmXhSmjoTY8I6riMr5bw26xeOzklFYQ74WDczQ8=;
        b=ii7nc9jMvKOByihN3r62Vfdoa7ypBa8NYfW/ocq08dTfL2nP0qQgBiTn3NrpVC8iXe
         1/0ahQEtParDlq/b+1vT3pYFUNwsJ3Yh0MZ5mbn2xA+sAy8zQjrZR0T+Tcea3eiOL1dv
         L7YYs7RDqHowgZQ1ARfn9ljfl9WQAhRW5fVKZeIOkjfszAOUiCR/E+bz45cYpfOTfS+N
         iAwQoyuzPufyQrLkaaoaq/tfbnx+uOMHy3MxPpEWaPWWFiFQ11hE+f06hDAGLAQhMaXd
         lnmAXowWOFVVEJKBFPHVRCY5S4ddWN8tk5+FoiGyTSopR4T3gViRBGN2xYSz4+ie1sES
         +UDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690764314; x=1691369114;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iLblvmXhSmjoTY8I6riMr5bw26xeOzklFYQ74WDczQ8=;
        b=KirJCyRP5BM5Nfj18/PLlwPrIfTUrw5L7MvKXEK7mHA/bbnft6fk7q0ibVAiX/g9FE
         4dDUOt2lvQ/NaStw2lJDDlVekYGy3Mmx5qGf+eAWQZPzDCifB/z5X4hawMUg9QDhfFus
         A+O8zWVGcWkIK/ZlaDTxpyhP2A9AsXPm+AneEQVwehjbYVlgP31O5ZJ8MVXcdEoB1S+F
         VL/gScH3weHVdM3Muvj1ksysAG0w9s8jq/Px0vfMe3vxgSUMqWnS5nvUvbpU3WiM3Qlm
         /1g0O2TZ3ha38v/63P5GmV8KsMN9k9RJZISfad1brKt4JmHi5kPwYkQXGkOpaxxJ9aIy
         jsIQ==
X-Gm-Message-State: ABy/qLZxZe+0t0Z2HQ0b8Xx9QICzZ/zuj654eCUgCMdDndfYkvj71gdQ
	1Bnlcf8+L4dD3Uv4DYB/6tzMR/ehDt2gKOT0EMUGJg==
X-Google-Smtp-Source: APBJJlFOQK3duynO6devHBJwzlIG0/N7/V+Wqt63uatH11DhaDFv/oG9JVmOuNie/+QHY8C+JtgRzQ==
X-Received: by 2002:a17:903:18c:b0:1bb:30c5:835a with SMTP id z12-20020a170903018c00b001bb30c5835amr8190263plg.7.1690764313691;
        Sun, 30 Jul 2023 17:45:13 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902ee4600b001b8a3a0c928sm7157884plo.181.2023.07.30.17.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 17:45:12 -0700 (PDT)
Message-ID: <64c70418.170a0220.9a037.cc7e@mx.google.com>
Date: Sun, 30 Jul 2023 17:45:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Kernel: v6.1.42-cip2
X-Kernelci-Report-Type: test
Subject: cip/linux-6.1.y-cip baseline: 107 runs, 4 regressions (v6.1.42-cip2)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Jul 2023 00:45:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12526

cip/linux-6.1.y-cip baseline: 107 runs, 4 regressions (v6.1.42-cip2)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig          =
          | regressions
-------------------+-------+---------------+----------+--------------------=
----------+------------
juno-uboot         | arm64 | lab-broonie   | gcc-10   | cip://6.1.y-c...64_=
defconfig | 2          =

r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig          =
          | 1          =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
          | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.42-cip2/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.42-cip2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      0d2ec524c820bab8eabc0f1b34aa41ff55d4e9b1 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig          =
          | regressions
-------------------+-------+---------------+----------+--------------------=
----------+------------
juno-uboot         | arm64 | lab-broonie   | gcc-10   | cip://6.1.y-c...64_=
defconfig | 2          =


  Details:     https://kernelci.org/test/plan/id/64c6f5e3f979d4c9218ace21

  Results:     55 PASS, 5 FAIL, 1 SKIP
  Full config: cip://6.1.y-cip/arm64/qemu_arm64_defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.42-ci=
p2/arm64/cip---6.1.y-cip-arm64-qemu_arm64_defconfig/gcc-10/lab-broonie/base=
line-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.42-ci=
p2/arm64/cip---6.1.y-cip-arm64-qemu_arm64_defconfig/gcc-10/lab-broonie/base=
line-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.1c050000_mmc-probed: https://kernelci.org/test/case/id/=
64c6f5e3f979d4c9218ace4e
        new failure (last pass: v6.1.31-65-ge66be31505fa)

    2023-07-30T23:44:22.196752  /lava-19417/1/../bin/lava-test-case
    2023-07-30T23:44:22.235588  <8>[   35.030146] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3D1c050000.mmc-probed RESULT=3Dfail>
    2023-07-30T23:44:22.236151  /lava-19417/1/../bin/lava-test-case   =


  * baseline.bootrr.ethernet-probed: https://kernelci.org/test/case/id/64c6=
f5e3f979d4c9218ace50
        new failure (last pass: v6.1.31-65-ge66be31505fa)

    2023-07-30T23:44:21.142929  /lava-19417/1/../bin/lava-test-case
    2023-07-30T23:44:21.167876  <8>[   33.977371] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dethernet-probed RESULT=3Dfail>
    2023-07-30T23:44:21.168395  /lava-19417/1/../bin/lava-test-case   =

 =



platform           | arch  | lab           | compiler | defconfig          =
          | regressions
-------------------+-------+---------------+----------+--------------------=
----------+------------
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig          =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/64c6f21a73c6829a8e8ace2e

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.42-ci=
p2/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.42-ci=
p2/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c6f21a73c6829a8e8ace33
        new failure (last pass: v6.1.31-46-g4cc1cc26e90f)

    2023-07-30T23:29:52.649760  / # #

    2023-07-30T23:29:52.751874  export SHELL=3D/bin/sh

    2023-07-30T23:29:52.752578  #

    2023-07-30T23:29:52.853962  / # export SHELL=3D/bin/sh. /lava-11171722/=
environment

    2023-07-30T23:29:52.854667  =


    2023-07-30T23:29:52.956042  / # . /lava-11171722/environment/lava-11171=
722/bin/lava-test-runner /lava-11171722/1

    2023-07-30T23:29:52.957150  =


    2023-07-30T23:29:52.974149  / # /lava-11171722/bin/lava-test-runner /la=
va-11171722/1

    2023-07-30T23:29:53.022241  + export 'TESTRUN_ID=3D1_bootrr'

    2023-07-30T23:29:53.022744  + cd /lav<8>[   19.062923] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11171722_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
          | regressions
-------------------+-------+---------------+----------+--------------------=
----------+------------
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/64c6f22fb39db5d47b8aceb0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.42-ci=
p2/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.42-ci=
p2/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c6f22fb39db5d47b8aceb5
        new failure (last pass: v6.1.31-53-g486caac40d06)

    2023-07-30T23:30:05.163682  / # #

    2023-07-30T23:30:05.266087  export SHELL=3D/bin/sh

    2023-07-30T23:30:05.266848  #

    2023-07-30T23:30:05.368286  / # export SHELL=3D/bin/sh. /lava-11171714/=
environment

    2023-07-30T23:30:05.369094  =


    2023-07-30T23:30:05.470577  / # . /lava-11171714/environment/lava-11171=
714/bin/lava-test-runner /lava-11171714/1

    2023-07-30T23:30:05.471811  =


    2023-07-30T23:30:05.488163  / # /lava-11171714/bin/lava-test-runner /la=
va-11171714/1

    2023-07-30T23:30:05.555144  + export 'TESTRUN_ID=3D1_bootrr'

    2023-07-30T23:30:05.555649  + cd /lava-1117171<8>[   16.934009] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11171714_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20

