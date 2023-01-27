Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4148FC61DA4
	for <webhook@archiver.kernel.org>; Fri, 27 Jan 2023 01:56:07 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web10.92980.1674784566393929507
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 26 Jan 2023 17:56:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=0hXxAcvd;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.170, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f170.google.com with SMTP id v23so3618447plo.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 26 Jan 2023 17:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aaxeBbrJxxVlUx7xqa2IzZzxi7XNISm4Qn3IBvnAFiM=;
        b=0hXxAcvdyuPXa3w4PobgIIxTTVIeApq+gI60OdfwuCjCXjvpiAxJhL/4IkRPe23gT6
         C5Tvb19NbPnv/hD5QamigNpqVv4e1UJq/QYh6cOa7q8nu/nzZofzXbI6LJpune3HbBG8
         GIoyfR5P1EJNz2gaglt3j0jni6nGX5D1xURO3EuXXMD+WrCiSAAxNjbDNTf6hRP4YDSG
         8oyUOvJO1hUIUvAkESoHxA5GRD9IlhZiBY+3C6JxXVTYRQeJT4VfrN1dw45y53vRNiJ5
         lEH5GBkINR8AsFBbRRmkZBjlVL03Wmn3VBUiQeHNjQOfyfTwhGI+y26Sn/7fHjJh7uwy
         yfRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aaxeBbrJxxVlUx7xqa2IzZzxi7XNISm4Qn3IBvnAFiM=;
        b=Wbjo9AcBA1AXDD8zfnnlIttcc8h02/jKNft7v4Awly/K49x3x9Va691vey15px5z16
         pxMmnTI5YkthSr8Z3g7ARVLRaOxxBKojiRAX+uVdYOTmvo7Va80h8vfGZdzyDzlTBDfo
         OuWdlDEeLFiq3EFyTdMgzKduflZzCfzVuBsDp36bfFlOR0orMucKNr89TuxWPa3fWYLu
         ByZE5Cj3yYHQfKHCY8MZvnCi9hZekrY/IRi4X4Xrco/svuwPuNAw+6UPV2Re+yEZYr5v
         jK1yi4gkRIgDSeNgQ0VhCxatfR1lCjHvBCP3cj34MM4XExxmv47sLptO+LoDEdjUhpvt
         V8nw==
X-Gm-Message-State: AO0yUKWYIKy79aZn+Em30G4Orq2HxxuFn5g/vMieICKpTtcqEmmmFheZ
	oZhinPpbSxWrbBIP7MAklSij1JVOigEC/eQHxsJs8A==
X-Google-Smtp-Source: AK7set9ZFinHtR5L6XDaYPZABRrEE/AoHCAwCo8tK2nlSVLDRisKM3F4aP+q5chgTP3qzJQrAsuiig==
X-Received: by 2002:a17:902:ec82:b0:196:125a:e4b8 with SMTP id x2-20020a170902ec8200b00196125ae4b8mr15911344plg.12.1674784564391;
        Thu, 26 Jan 2023 17:56:04 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902ed8c00b00188ea79fae0sm1648870plj.48.2023.01.26.17.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 17:56:03 -0800 (PST)
Message-ID: <63d32f33.170a0220.c75f.3042@mx.google.com>
Date: Thu, 26 Jan 2023 17:56:03 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Kernel: v5.10.162-cip24-rt10
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip-rt baseline: 238 runs,
 34 regressions (v5.10.162-cip24-rt10)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 27 Jan 2023 01:56:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10492

cip/linux-5.10.y-cip-rt baseline: 238 runs, 34 regressions (v5.10.162-cip24=
-rt10)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | defcon=
fig+x86-chromebook     | 1          =

acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...k+preempt_rt | 1          =

asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora   | gcc-10   | defcon=
fig+x86-chromebook     | 1          =

asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...k+preempt_rt | 1          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora   | gcc-10   | defcon=
fig+x86-chromebook     | 1          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...k+preempt_rt | 1          =

at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig           | 1          =

beagle-xm                    | arm    | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

beagle-xm                    | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | defcon=
fig                    | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig           | 1          =

cubietruck                   | arm    | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

cubietruck                   | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =

da850-lcdk                   | arm    | lab-baylibre    | gcc-10   | davinc=
i_all_defconfig        | 1          =

da850-lcdk                   | arm    | lab-baylibre    | gcc-10   | multi_=
v5_defconfig           | 1          =

fsl-ls1088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig+preempt_rt         | 1          =

fsl-ls1088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | defcon=
fig                    | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig+preempt_rt         | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig+preempt_rt         | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =

tegra124-nyan-big            | arm    | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

tegra124-nyan-big            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.162-cip24-rt10/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.162-cip24-rt10
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      55fa0afa2bb00f24b1721b532102d34eb18be47e =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | defcon=
fig+x86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/63d3231605c3011cd3915eba

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d3231605c3011cd3915ebf
        new failure (last pass: v5.10.158-cip22-rt9)

    2023-01-27T01:03:57.354323  <8>[    9.119563] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 8894405_1.4.2.3.1>
    2023-01-27T01:03:57.459168  / # #
    2023-01-27T01:03:57.560195  export SHELL=3D/bin/sh
    2023-01-27T01:03:57.560389  #
    2023-01-27T01:03:57.661246  / # export SHELL=3D/bin/sh. /lava-8894405/e=
nvironment
    2023-01-27T01:03:57.661430  =

    2023-01-27T01:03:57.762333  / # . /lava-8894405/environment/lava-889440=
5/bin/lava-test-runner /lava-8894405/1
    2023-01-27T01:03:57.762620  =

    2023-01-27T01:03:57.767949  / # /lava-8894405/bin/lava-test-runner /lav=
a-8894405/1
    2023-01-27T01:03:57.780481  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/63d320c375d4dee3b0915edc

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d320c375d4dee3b0915ee1
        new failure (last pass: v5.10.158-cip22-rt9)

    2023-01-27T00:54:03.486067  + set +x
    2023-01-27T00:54:03.593579  =

    2023-01-27T00:54:03.594014  <8>[    9.067913] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 8894105_1.4.2.3.1>
    2023-01-27T00:54:03.696063  / # #export SHELL=3D/bin/sh
    2023-01-27T00:54:03.696873  =

    2023-01-27T00:54:03.798790  / # export SHELL=3D/bin/sh. /lava-8894105/e=
nvironment
    2023-01-27T00:54:03.799590  =

    2023-01-27T00:54:03.901485  / # . /lava-8894105/environment/lava-889410=
5/bin/lava-test-runner /lava-8894105/1
    2023-01-27T00:54:03.902777  =

    2023-01-27T00:54:03.908700  / # /lava-8894105/bin/lava-test-runner /lav=
a-8894105/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora   | gcc-10   | defcon=
fig+x86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/63d323a9d3c55d5a26915ebe

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d323a9d3c55d5a26915ec3
        new failure (last pass: v5.10.158-cip22-rt9)

    2023-01-27T01:06:29.746808  <8>[    5.2#
    2023-01-27T01:06:29.748250  06269] <LAVA_SIGNAL_ENDRUN 0_dmesg 8894425_=
1.4.2.3.1>
    2023-01-27T01:06:29.850477  / # #export SHELL=3D/bin/sh
    2023-01-27T01:06:29.851327  =

    2023-01-27T01:06:29.953240  / # export SHELL=3D/bin/sh. /lava-8894425/e=
nvironment
    2023-01-27T01:06:29.954114  =

    2023-01-27T01:06:30.056217  / # . /lava-8894425/environment/lava-889442=
5/bin/lava-test-runner /lava-8894425/1
    2023-01-27T01:06:30.057487  =

    2023-01-27T01:06:30.062630  / # /lava-8894425/bin/lava-test-runner /lav=
a-8894425/1
    2023-01-27T01:06:30.076917  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/63d320ed8637ff1025915ebe

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d320ed8637ff1025915ec3
        new failure (last pass: v5.10.158-cip22-rt9)

    2023-01-27T00:54:47.538790  / # <8>[ #
    2023-01-27T00:54:47.641758  export SHELL=3D/bin/sh
    2023-01-27T00:54:47.642683     7.219146] <LAVA_SIGNAL_ENDRUN 0_dmesg 88=
94099_1.4.2.3.1>
    2023-01-27T00:54:47.643135  #
    2023-01-27T00:54:47.745093  / # export SHELL=3D/bin/sh. /lava-8894099/e=
nvironment
    2023-01-27T00:54:47.745972  =

    2023-01-27T00:54:47.847915  / # . /lava-8894099/environment/lava-889409=
9/bin/lava-test-runner /lava-8894099/1
    2023-01-27T00:54:47.849210  =

    2023-01-27T00:54:47.854201  / # /lava-8894099/bin/lava-test-runner /lav=
a-8894099/1
    2023-01-27T00:54:47.871100  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora   | gcc-10   | defcon=
fig+x86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/63d3231226f84af69d915eb9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d3231226f84af69d915ebe
        new failure (last pass: v5.10.158-cip22-rt9)

    2023-01-27T01:03:57.382821  + set +x
    2023-01-27T01:03:57.390861  <8>[    7.137954] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 8894388_1.4.2.3.1>
    2023-01-27T01:03:57.496309  / # #
    2023-01-27T01:03:57.599664  export SHELL=3D/bin/sh
    2023-01-27T01:03:57.600556  #
    2023-01-27T01:03:57.702527  / # export SHELL=3D/bin/sh. /lava-8894388/e=
nvironment
    2023-01-27T01:03:57.703434  =

    2023-01-27T01:03:57.805542  / # . /lava-8894388/environment/lava-889438=
8/bin/lava-test-runner /lava-8894388/1
    2023-01-27T01:03:57.807010  =

    2023-01-27T01:03:57.809013  / # /lava-8894388/bin/lava-test-runner /lav=
a-8894388/1 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/63d32225294ff504d1915ed2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d32225294ff504d1915ed7
        new failure (last pass: v5.10.158-cip22-rt9)

    2023-01-27T01:00:00.751804  + set +x
    2023-01-27T01:00:00.758334  <8>[    7.889194] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 8894095_1.4.2.3.1>
    2023-01-27T01:00:00.866703  / # #
    2023-01-27T01:00:00.969245  export SHELL=3D/bin/sh
    2023-01-27T01:00:00.970034  #
    2023-01-27T01:00:01.071639  / # export SHELL=3D/bin/sh. /lava-8894095/e=
nvironment
    2023-01-27T01:00:01.072515  =

    2023-01-27T01:00:01.174293  / # . /lava-8894095/environment/lava-889409=
5/bin/lava-test-runner /lava-8894095/1
    2023-01-27T01:00:01.174791  =

    2023-01-27T01:00:01.179674  / # /lava-8894095/bin/lava-test-runner /lav=
a-8894095/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63d322e2eecaa1f82d915ec7

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g=
20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g=
20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d322e2eecaa1f82d915ecc
        new failure (last pass: v5.10.158-cip22-rt9)

    2023-01-27T01:03:23.753811  + set +x
    2023-01-27T01:03:23.864646  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3De#
    2023-01-27T01:03:23.865914  merg RESULT=3Dpass UNITS=3Dlines MEASUREMEN=
T=3D0>
    2023-01-27T01:03:23.866305  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 188443_1.5.2=
.4.1>
    2023-01-27T01:03:23.968473  / # #export SHELL=3D/bin/sh
    2023-01-27T01:03:23.969276  =

    2023-01-27T01:03:24.071129  / # export SHELL=3D/bin/sh. /lava-188443/en=
vironment
    2023-01-27T01:03:24.071896  =

    2023-01-27T01:03:24.173780  / # . /lava-188443/environment/lava-188443/=
bin/lava-test-runner /lava-188443/1
    2023-01-27T01:03:24.175003   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beagle-xm                    | arm    | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63d32222294ff504d1915ec8

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm/defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm/defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d32222294ff504d1915ecd
        new failure (last pass: v5.10.153-cip19-rt8)

    2023-01-27T01:00:07.944485  + set +x
    2023-01-27T01:00:08.053209  TESTCASE TEST_CASE_ID=3Demerg RESULT=3Dpass=
 UNITS=3Dlines MEASUREMENT=3D0>
    2023-01-27T01:00:08.053660  =

    2023-01-27T01:00:08.054124  <8>[   25.967163] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3222139_1.5.2.4.1>
    2023-01-27T01:00:08.156463  / # #export SHELL=3D/bin/sh
    2023-01-27T01:00:08.157548  =

    2023-01-27T01:00:08.259840  / # export SHELL=3D/bin/sh. /lava-3222139/e=
nvironment
    2023-01-27T01:00:08.260952  =

    2023-01-27T01:00:08.363433  / # . /lava-3222139/environment/lava-322213=
9/bin/lava-test-runner /lava-3222139/1
    2023-01-27T01:00:08.365143   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beagle-xm                    | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63d3229a68dba599e3915f2e

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-beagle-x=
m.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-beagle-x=
m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d3229a68dba599e3915f33
        new failure (last pass: v5.10.153-cip19-rt8)

    2023-01-27T01:02:03.225251  + set +x
    2023-01-27T01:02:03.333953  / # <8>[   25.921936] <LAVA_S#
    2023-01-27T01:02:03.437474  export SHELL=3D/bin/sh
    2023-01-27T01:02:03.438825  IGNAL_TESTCASE TEST_CASE_ID=3Demerg RESULT=
=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-01-27T01:02:03.439710  <8>[   25.923828] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3222165_1.5.2.4.1>
    2023-01-27T01:02:03.440362  #
    2023-01-27T01:02:03.542552  / # export SHELL=3D/bin/sh. /lava-3222165/e=
nvironment
    2023-01-27T01:02:03.542916  =

    2023-01-27T01:02:03.644199  / # . /lava-3222165/environment/lava-322216=
5/bin/lava-test-runner /lava-3222165/1
    2023-01-27T01:02:03.645575   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63d32236294ff504d1915f1c

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm/defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm/defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d32236294ff504d1915f21
        new failure (last pass: v5.10.158-cip22-rt9)

    2023-01-27T01:00:25.352315  + set +x
    2023-01-27T01:00:25.455468  / # <8>[   22.846091] <LAVA_S#
    2023-01-27T01:00:25.557855  export SHELL=3D/bin/sh
    2023-01-27T01:00:25.558594  IGNAL_TESTCASE TEST_CASE_ID=3Demerg RESULT=
=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-01-27T01:00:25.558984  <8>[   22.847883] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 188460_1.5.2.4.1>
    2023-01-27T01:00:25.559211  #
    2023-01-27T01:00:25.660518  / # export SHELL=3D/bin/sh. /lava-188460/en=
vironment
    2023-01-27T01:00:25.661131  =

    2023-01-27T01:00:25.762673  / # . /lava-188460/environment/lava-188460/=
bin/lava-test-runner /lava-188460/1
    2023-01-27T01:00:25.763705   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63d3221d03c022713f915f3a

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm/defconfig/gcc-10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm/defconfig/gcc-10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d3221d03c022713f915f3d
        new failure (last pass: v5.10.158-cip22-rt9)

    2023-01-27T01:00:06.056036  + set +x
    2023-01-27T01:00:06.163175  / # <8>[   15.578065] <LAVA_S#
    2023-01-27T01:00:06.266014  export SHELL=3D/bin/sh
    2023-01-27T01:00:06.266770  IGNAL_TESTCASE TEST_CASE_ID=3Demerg RESULT=
=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-01-27T01:00:06.267203  <8>[   15.579873] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 834215_1.5.2.4.1>
    2023-01-27T01:00:06.267614  #
    2023-01-27T01:00:06.369551  / # export SHELL=3D/bin/sh. /lava-834215/en=
vironment
    2023-01-27T01:00:06.370305  =

    2023-01-27T01:00:06.472270  / # . /lava-834215/environment/lava-834215/=
bin/lava-test-runner /lava-834215/1
    2023-01-27T01:00:06.473504   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63d322ff5a14d5389c915ec0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebon=
e-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebon=
e-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d322ff5a14d5389c915ec5
        new failure (last pass: v5.10.158-cip22-rt9)

    2023-01-27T01:03:31.757323  / # <8>[   22.975038] <LAVA_SIGNAL_ENDRUN 0=
_dmesg 188474_1.5.2.4.1>
    2023-01-27T01:03:31.900900  #
    2023-01-27T01:03:32.018682  export SHELL=3D/bin/sh
    2023-01-27T01:03:32.023924  #
    2023-01-27T01:03:32.133027  / # export SHELL=3D/bin/sh. /lava-188474/en=
vironment
    2023-01-27T01:03:32.140059  =

    2023-01-27T01:03:32.251396  / # . /lava-188474/environment/lava-188474/=
bin/lava-test-runner /lava-188474/1
    2023-01-27T01:03:32.261910  =

    2023-01-27T01:03:32.265404  / # /lava-188474/bin/lava-test-runner /lava=
-188474/1
    2023-01-27T01:03:32.348970  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63d3229668dba599e3915f03

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beaglebone-bl=
ack.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beaglebone-bl=
ack.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d3229668dba599e3915f06
        new failure (last pass: v5.10.158-cip22-rt9)

    2023-01-27T01:02:07.382301  + set +x
    2023-01-27T01:02:07.490311  TESTCASE TEST_CASE_ID=3Demerg RESULT=3Dpass=
 UNITS=3Dlines MEASUREMENT=3D0>
    2023-01-27T01:02:07.490732  =

    2023-01-27T01:02:07.491132  / # <8>[   16.760238] <LAVA_SIGNAL_ENDRUN 0=
_dmesg 834223_1.5.2.4.1>
    2023-01-27T01:02:07.593485  #export SHELL=3D/bin/sh
    2023-01-27T01:02:07.594233  =

    2023-01-27T01:02:07.695925  / # export SHELL=3D/bin/sh. /lava-834223/en=
vironment
    2023-01-27T01:02:07.696423  =

    2023-01-27T01:02:07.797755  / # . /lava-834223/environment/lava-834223/=
bin/lava-test-runner /lava-834223/1
    2023-01-27T01:02:07.798310   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
cubietruck                   | arm    | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63d322372e7c10d793915ec8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm/defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm/defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d322372e7c10d793915ecd
        new failure (last pass: v5.10.158-cip22-rt9)

    2023-01-27T01:00:14.176961  <8>[   10.883778] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3222149_1.5.2.4.1>
    2023-01-27T01:00:14.284147  / # #
    2023-01-27T01:00:14.385563  export SHELL=3D/bin/sh
    2023-01-27T01:00:14.385904  #
    2023-01-27T01:00:14.487037  / # export SHELL=3D/bin/sh. /lava-3222149/e=
nvironment
    2023-01-27T01:00:14.487414  =

    2023-01-27T01:00:14.588593  / # . /lava-3222149/environment/lava-322214=
9/bin/lava-test-runner /lava-3222149/1
    2023-01-27T01:00:14.589192  =

    2023-01-27T01:00:14.589333  / # /lava-3222149/bin/lava-test-runner /lav=
a-3222149/1<3>[   11.284825] Bluetooth: hci0: command 0x0c03 tx timeout
    2023-01-27T01:00:14.593681   =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
cubietruck                   | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63d322c303d76c1b3c915ee3

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietru=
ck.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietru=
ck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d322c303d76c1b3c915ee8
        new failure (last pass: v5.10.158-cip22-rt9)

    2023-01-27T01:02:44.420438  + set +x
    2023-01-27T01:02:44.527877  <8>[   10.899428] <LAVA_SIGNA#
    2023-01-27T01:02:44.529468  L_TESTCASE TEST_CASE_ID=3Demerg RESULT=3Dpa=
ss UNITS=3Dlines MEASUREMENT=3D0>
    2023-01-27T01:02:44.529933  / # <8>[   10.901165] <LAVA_SIGNAL_ENDRUN 0=
_dmesg 3222156_1.5.2.4.1>
    2023-01-27T01:02:44.632538  #export SHELL=3D/bin/sh
    2023-01-27T01:02:44.633582  =

    2023-01-27T01:02:44.735949  / # export SHELL=3D/bin/sh. /lava-3222156/e=
nvironment
    2023-01-27T01:02:44.737152  =

    2023-01-27T01:02:44.839684  / # . /lava-3222156/environment/lava-322215=
6/bin/lava-test-runner /lava-3222156/1
    2023-01-27T01:02:44.841335   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
da850-lcdk                   | arm    | lab-baylibre    | gcc-10   | davinc=
i_all_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/63d321320616bbbcc3915ed2

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: davinci_all_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm/davinci_all_defconfig/gcc-10/lab-baylibre/baseline-da850=
-lcdk.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm/davinci_all_defconfig/gcc-10/lab-baylibre/baseline-da850=
-lcdk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d321320616bbbcc3915ed7
        new failure (last pass: v5.10.158-cip22-rt9)

    2023-01-27T00:56:06.576840  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 3222118_1.5.=
2.4.1>
    2023-01-27T00:56:06.685508  / # #
    2023-01-27T00:56:06.789403  export SHELL=3D/bin/sh
    2023-01-27T00:56:06.790685  #
    2023-01-27T00:56:06.893294  / # export SHELL=3D/bin/sh. /lava-3222118/e=
nvironment
    2023-01-27T00:56:06.894694  =

    2023-01-27T00:56:06.997323  / # . /lava-3222118/environment/lava-322211=
8/bin/lava-test-runner /lava-3222118/1
    2023-01-27T00:56:06.999205  =

    2023-01-27T00:56:07.042276  / # /lava-3222118/bin/lava-test-runner /lav=
a-3222118/1
    2023-01-27T00:56:07.259281  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
da850-lcdk                   | arm    | lab-baylibre    | gcc-10   | multi_=
v5_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63d321d2474cbf0b33915ee6

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm/multi_v5_defconfig/gcc-10/lab-baylibre/baseline-da850-lc=
dk.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm/multi_v5_defconfig/gcc-10/lab-baylibre/baseline-da850-lc=
dk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d321d2474cbf0b33915eeb
        new failure (last pass: v5.10.158-cip22-rt9)

    2023-01-27T00:57:46.367816  / # <8><LAVA_SIGNAL_ENDRUN 0_dmesg 3222119_=
1.5.2.4.1>
    2023-01-27T00:57:46.475891  #
    2023-01-27T00:57:46.580175  export SHELL=3D/bin/sh
    2023-01-27T00:57:46.581350  #
    2023-01-27T00:57:46.683684  / # export SHELL=3D/bin/sh. /lava-3222119/e=
nvironment
    2023-01-27T00:57:46.684817  =

    2023-01-27T00:57:46.787122  / # . /lava-3222119/environment/lava-322211=
9/bin/lava-test-runner /lava-3222119/1
    2023-01-27T00:57:46.788938  =

    2023-01-27T00:57:46.830477  / # /lava-3222119/bin/lava-test-runner /lav=
a-3222119/1
    2023-01-27T00:57:47.045843  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls1088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/63d32541504ebd263f915ec8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm64/defconfig+preempt_rt/gcc-10/lab-nxp/baseline-fsl-ls108=
8a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm64/defconfig+preempt_rt/gcc-10/lab-nxp/baseline-fsl-ls108=
8a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d32541504ebd263f915ecb
        new failure (last pass: v5.10.153-cip19-rt8)

    2023-01-27T01:13:22.025925  [   14.062695] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1147092_1.5.2.4.1>
    2023-01-27T01:13:22.026203  h
    2023-01-27T01:13:22.026438  + set +x
    2023-01-27T01:13:22.132798  / # #
    2023-01-27T01:13:22.234743  export SHELL=3D/bin/sh
    2023-01-27T01:13:22.235220  #
    2023-01-27T01:13:22.336580  / # export SHELL=3D/bin/sh. /lava-1147092/e=
nvironment
    2023-01-27T01:13:22.337025  =

    2023-01-27T01:13:22.438400  / # . /lava-1147092/environment/lava-114709=
2/bin/lava-test-runner /lava-1147092/1
    2023-01-27T01:13:22.439147   =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls1088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63d32699a99958bd5f915ede

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1088a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d32699a99958bd5f915ee1
        new failure (last pass: v5.10.153-cip19-rt8)

    2023-01-27T01:19:04.594398  [   13.055205] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1147098_1.5.2.4.1>
    2023-01-27T01:19:04.701321  / # #
    2023-01-27T01:19:04.803167  export SHELL=3D/bin/sh
    2023-01-27T01:19:04.803614  #
    2023-01-27T01:19:04.904952  / # export SHELL=3D/bin/sh. /lava-1147098/e=
nvironment
    2023-01-27T01:19:04.905393  =

    2023-01-27T01:19:05.006762  / # . /lava-1147098/environment/lava-114709=
8/bin/lava-test-runner /lava-1147098/1
    2023-01-27T01:19:05.007595  =

    2023-01-27T01:19:05.009603  / # /lava-1147098/bin/lava-test-runner /lav=
a-1147098/1
    2023-01-27T01:19:05.027752  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63d3220703c022713f915ebd

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm/defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm/defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d3220703c022713f915ec2
        new failure (last pass: v5.10.158-cip22-rt9)

    2023-01-27T00:59:42.206455  + set +x
    2023-01-27T00:59:42.313803  / # #
    2023-01-27T00:59:42.415558  export SHELL=3D/bin/sh
    2023-01-27T00:59:42.416048  <8>[    9.005683] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-01-27T00:59:42.416262  <8>[    9.006939] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 8894150_1.5.2.4.1>
    2023-01-27T00:59:42.416462  #
    2023-01-27T00:59:42.517812  / # export SHELL=3D/bin/sh. /lava-8894150/e=
nvironment
    2023-01-27T00:59:42.518675  =

    2023-01-27T00:59:42.621453  / # . /lava-8894150/environment/lava-889415=
0/bin/lava-test-runner /lava-8894150/1
    2023-01-27T00:59:42.622270   =

    ... (17 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63d32262edb49603b8915ec6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-s=
abrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-s=
abrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d32262edb49603b8915ecb
        new failure (last pass: v5.10.158-cip22-rt9)

    2023-01-27T01:01:08.637250  / # #
    2023-01-27T01:01:08.738848  export SHELL=3D/bin/sh
    2023-01-27T01:01:08.739148  #
    2023-01-27T01:01:08.840114  / # export SHELL=3D/bin/sh. /lava-8894178/e=
nvironment
    2023-01-27T01:01:08.840443  =

    2023-01-27T01:01:08.941788  / # . /lava-8894178/environment/lava-889417=
8/bin/lava-test-runner /lava-8894178/1
    2023-01-27T01:01:08.942291  =

    2023-01-27T01:01:08.949876  / # /lava-8894178/bin/lava-test-runner /lav=
a-8894178/1
    2023-01-27T01:01:09.049326  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-27T01:01:09.049505  + cd /lava-8894178/1/tests/1_bootrr =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63d321f141c08393e2915ec5

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm/defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandboa=
rd-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm/defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandboa=
rd-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d321f141c08393e2915eca
        new failure (last pass: v5.10.158-cip22-rt9)

    2023-01-27T00:59:05.228055  [    7.143220] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dalert RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-01-27T00:59:05.248729  + set +x
    2023-01-27T00:59:05.354591  / # #
    2023-01-27T00:59:05.456104  export SHELL=3D/bin/sh
    2023-01-27T00:59:05.456493  [    7.177630] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-01-27T00:59:05.456649  [    7.178941] <LAVA_SIGNAL_ENDRUN 0_dmesg =
888933_1.5.2.3.1>
    2023-01-27T00:59:05.456767  #
    2023-01-27T00:59:05.558087  / # export SHELL=3D/bin/sh. /lava-888933/en=
vironment
    2023-01-27T00:59:05.558488  =

    2023-01-27T00:59:05.659664  / # . /lava-888933/environment/lava-888933/=
bin/lava-test-runner /lava-888933/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63d321028637ff1025915edf

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6=
qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6=
qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d321028637ff1025915ee4
        new failure (last pass: v5.10.158-cip22-rt9)

    2023-01-27T00:55:06.195917  + set +x
    2023-01-27T00:55:06.196101  [   10.248536] <LAVA_SIGNAL_ENDRUN 0_dmesg =
888930_1.5.2.3.1>
    2023-01-27T00:55:06.301677  / # #
    2023-01-27T00:55:06.403365  export SHELL=3D/bin/sh
    2023-01-27T00:55:06.403918  #
    2023-01-27T00:55:06.505159  / # export SHELL=3D/bin/sh. /lava-888930/en=
vironment
    2023-01-27T00:55:06.505835  =

    2023-01-27T00:55:06.607233  / # . /lava-888930/environment/lava-888930/=
bin/lava-test-runner /lava-888930/1
    2023-01-27T00:55:06.607959  =

    2023-01-27T00:55:06.610444  / # /lava-888930/bin/lava-test-runner /lava=
-888930/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63d32255edb49603b8915eb9

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6q=
p-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6q=
p-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d32255edb49603b8915ebe
        new failure (last pass: v5.10.158-cip22-rt9)

    2023-01-27T01:00:50.564643  + set +x
    2023-01-27T01:00:50.676847  / # [    7.050668] <LAVA_SIGNAL_TESTCASE TE=
ST_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dl#
    2023-01-27T01:00:50.778629  export SHELL=3D/bin/sh
    2023-01-27T01:00:50.779199  ines MEASUREMENT=3D0>
    2023-01-27T01:00:50.779339  [    7.052029] <LAVA_SIGNAL_ENDRUN 0_dmesg =
888938_1.5.2.3.1>
    2023-01-27T01:00:50.779452  #
    2023-01-27T01:00:50.880766  / # export SHELL=3D/bin/sh. /lava-888938/en=
vironment
    2023-01-27T01:00:50.881241  =

    2023-01-27T01:00:50.982642  / # . /lava-888938/environment/lava-888938/=
bin/lava-test-runner /lava-888938/1
    2023-01-27T01:00:50.983380   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63d3221203c022713f915ef9

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm/defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm/defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d3221203c022713f915efc
        new failure (last pass: v5.10.153-cip19-rt8)

    2023-01-27T00:59:41.665751  =

    2023-01-27T00:59:41.770012  / # #
    2023-01-27T00:59:42.930313  export SHELL=3D/bin/sh
    2023-01-27T00:59:42.936001  #
    2023-01-27T00:59:44.483833  / # export SHELL=3D/bin/sh. /lava-1147085/e=
nvironment
    2023-01-27T00:59:44.489531  =

    2023-01-27T00:59:47.312181  / # . /lava-1147085/environment/lava-114708=
5/bin/lava-test-runner /lava-1147085/1
    2023-01-27T00:59:47.318218  =

    2023-01-27T00:59:47.321615  / # /lava-1147085/bin/lava-test-runner /lav=
a-1147085/1
    2023-01-27T00:59:47.420691  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (19 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63d3228d68dba599e3915ecd

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d3228d68dba599e3915ed0
        new failure (last pass: v5.10.153-cip19-rt8)

    2023-01-27T01:01:40.743990  <8>[   17.177197] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1147086_1.5.2.4.1>
    2023-01-27T01:01:40.849658  / # #
    2023-01-27T01:01:42.010020  export SHELL=3D/bin/sh
    2023-01-27T01:01:42.015720  #
    2023-01-27T01:01:43.563541  / # export SHELL=3D/bin/sh. /lava-1147086/e=
nvironment
    2023-01-27T01:01:43.569233  =

    2023-01-27T01:01:46.392118  / # . /lava-1147086/environment/lava-114708=
6/bin/lava-test-runner /lava-1147086/1
    2023-01-27T01:01:46.398244  =

    2023-01-27T01:01:46.400301  / # /lava-1147086/bin/lava-test-runner /lav=
a-1147086/1
    2023-01-27T01:01:46.489271  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (19 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/63d328831f2bfb319c915ede

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm64/defconfig+preempt_rt/gcc-10/lab-baylibre/baseline-sun5=
0i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm64/defconfig+preempt_rt/gcc-10/lab-baylibre/baseline-sun5=
0i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63d328831f2bfb319c915=
edf
        new failure (last pass: v5.10.158-cip22-rt9) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63d32a8be5f0ee7204915eb9

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-pine=
64-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-pine=
64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d32a8be5f0ee7204915ebe
        new failure (last pass: v5.10.158-cip22-rt9)

    2023-01-27T01:35:54.977884  + set +x
    2023-01-27T01:35:55.098342  / # <8>[   16.704746] <LAVA_S#
    2023-01-27T01:35:55.204470  export SHELL=3D/bin/sh
    2023-01-27T01:35:55.206401  IGNAL_TESTCASE TEST_CASE_ID=3Demerg RESULT=
=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-01-27T01:35:55.207860  <8>[   16.705691] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3222349_1.5.2.4.1>
    2023-01-27T01:35:55.208939  #
    2023-01-27T01:35:55.312633  / # export SHELL=3D/bin/sh. /lava-3222349/e=
nvironment
    2023-01-27T01:35:55.314156  =

    2023-01-27T01:35:55.417641  / # . /lava-3222349/environment/lava-322234=
9/bin/lava-test-runner /lava-3222349/1
    2023-01-27T01:35:55.420385   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/63d3265784218d42d5915ebb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm64/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-sun50=
i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm64/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-sun50=
i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63d3265784218d42d5915=
ebc
        new failure (last pass: v5.10.158-cip22-rt9) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63d3275ccca4efa8f5915ed2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine6=
4-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine6=
4-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d3275ccca4efa8f5915ed7
        new failure (last pass: v5.10.158-cip22-rt9)

    2023-01-27T01:21:24.693206  <8>[   16.819739] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 188739_1.5.2.4.1>
    2023-01-27T01:21:24.801776  / # #
    2023-01-27T01:21:24.904054  export SHELL=3D/bin/sh
    2023-01-27T01:21:24.904937  #
    2023-01-27T01:21:25.006685  / # export SHELL=3D/bin/sh. /lava-188739/en=
vironment
    2023-01-27T01:21:25.007146  =

    2023-01-27T01:21:25.108700  / # . /lava-188739/environment/lava-188739/=
bin/lava-test-runner /lava-188739/1
    2023-01-27T01:21:25.109696  =

    2023-01-27T01:21:25.113529  / # /lava-188739/bin/lava-test-runner /lava=
-188739/1
    2023-01-27T01:21:25.157404  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63d3221403c022713f915f0f

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm/defconfig/gcc-10/lab-baylibre/baseline-sun8i-h3-libretec=
h-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm/defconfig/gcc-10/lab-baylibre/baseline-sun8i-h3-libretec=
h-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d3221403c022713f915f14
        new failure (last pass: v5.10.158-cip22-rt9)

    2023-01-27T00:59:37.380057  + set +x
    2023-01-27T00:59:37.514849  / # <8>[    8.396134] <LAVA_SIGNAL_TESTCASE=
 TE#
    2023-01-27T00:59:37.616887  export SHELL=3D/bin/sh
    2023-01-27T00:59:37.617462  ST_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dli=
nes MEASUREMENT=3D0>
    2023-01-27T00:59:37.617701  <8>[    8.397523] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3222137_1.5.2.4.1>
    2023-01-27T00:59:37.617921  #
    2023-01-27T00:59:37.719235  / # export SHELL=3D/bin/sh. /lava-3222137/e=
nvironment
    2023-01-27T00:59:37.719793  =

    2023-01-27T00:59:37.821273  / # . /lava-3222137/environment/lava-322213=
7/bin/lava-test-runner /lava-3222137/1
    2023-01-27T00:59:37.822103   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63d32271108eb74108915ebf

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h3=
-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h3=
-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d32271108eb74108915ec4
        new failure (last pass: v5.10.158-cip22-rt9)

    2023-01-27T01:01:08.205027  + set +x
    2023-01-27T01:01:08.309777  <8>[    8.387904] <LAVA_SIGNA#
    2023-01-27T01:01:08.310479  L_TESTCASE TEST_CASE_ID=3Demerg RESULT=3Dpa=
ss UNITS=3Dlines MEASUREMENT=3D0>
    2023-01-27T01:01:08.310712  / # <8>[    8.389339] <LAVA_SIGNAL_ENDRUN 0=
_dmesg 3222159_1.5.2.4.1>
    2023-01-27T01:01:08.412266  #export SHELL=3D/bin/sh
    2023-01-27T01:01:08.412644  =

    2023-01-27T01:01:08.513958  / # export SHELL=3D/bin/sh. /lava-3222159/e=
nvironment
    2023-01-27T01:01:08.514352  =

    2023-01-27T01:01:08.615693  / # . /lava-3222159/environment/lava-322215=
9/bin/lava-test-runner /lava-3222159/1
    2023-01-27T01:01:08.616373   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
tegra124-nyan-big            | arm    | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63d324887317a39b82915eda

  Results:     4 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm/defconfig/gcc-10/lab-collabora/baseline-tegra124-nyan-bi=
g.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm/defconfig/gcc-10/lab-collabora/baseline-tegra124-nyan-bi=
g.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d324887317a39b82915edf
        new failure (last pass: v5.10.158-cip22-rt9)

    2023-01-27T01:10:03.597331  + set +x
    2023-01-27T01:10:03.597900  =

    2023-01-27T01:10:03.704101  =

    2023-01-27T01:10:03.704304  / # <8>[   17.291274] <LAVA_SIGNAL_TESTCASE=
 TEST_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-01-27T01:10:03.704500  <8>[   17.292245] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 8894156_1.5.2.3.1>
    2023-01-27T01:10:03.806034  #export SHELL=3D/bin/sh
    2023-01-27T01:10:03.806754  =

    2023-01-27T01:10:03.908101  / # export SHELL=3D/bin/sh. /lava-8894156/e=
nvironment
    2023-01-27T01:10:03.908493  =

    2023-01-27T01:10:04.009846  / # . /lava-8894156/environment/lava-889415=
6/bin/lava-test-runner /lava-8894156/1 =

    ... (23 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
tegra124-nyan-big            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63d3294c3d3641af99915ed7

  Results:     4 PASS, 2 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-tegra12=
4-nyan-big.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-tegra12=
4-nyan-big.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d3294c3d3641af99915edc
        new failure (last pass: v5.10.158-cip22-rt9)

    2023-01-27T01:30:19.947191  + set +x
    2023-01-27T01:30:19.947759  =

    2023-01-27T01:30:20.056182  #
    2023-01-27T01:30:20.057042  =

    2023-01-27T01:30:20.057255  / # <8>[   17.124936] <LAVA_SIGNAL_TESTCASE=
 TEST_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-01-27T01:30:20.057447  <8>[   17.126118] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 8894174_1.5.2.3.1>
    2023-01-27T01:30:20.159209  #export SHELL=3D/bin/sh
    2023-01-27T01:30:20.159765  =

    2023-01-27T01:30:20.261186  / # export SHELL=3D/bin/sh. /lava-8894174/e=
nvironment
    2023-01-27T01:30:20.262116   =

    ... (22 line(s) more)  =

 =20

