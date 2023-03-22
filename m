Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1268C74A5B
	for <webhook@archiver.kernel.org>; Wed, 22 Mar 2023 13:56:23 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web11.43258.1679493374696403386
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 22 Mar 2023 06:56:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=y3uUwJuU;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.174, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f174.google.com with SMTP id kc4so4734510plb.10
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 22 Mar 2023 06:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1679493374;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=23zuLm+/LP8hWJ+ZOJCTLJRix1gmwu2idE2wy4WVtGk=;
        b=y3uUwJuUWqtua/vm/F9mHlkVvGVO20614zNEDMKZpkcg00ZS+Kg9jKzCcWVFZhzgQi
         LBLmHkkbY9UXj1je30pstiy+d+WqUTs64z3hHpvtOGRB+LE22YK5dPN+MJcFk9ygd75/
         ZZM6jHm1YyA5WN1lORJcMNhVBCG5KlU7tyW1wrNSkNUXSaLO3IMV167Zfp0RTem+NUqv
         DpPu9DGJRdFj9cp0YA1/aChDqX3jYd8cqSMp4uKi4uE3nSEc05xXleEtgt8DwrRFyx9e
         FCO0/QKFrk7/AKwM1+nduDYfT8zGH6q4bUFPe8xgry29j+/02qBoBX94aG/9sw0bXROe
         qRkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679493374;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=23zuLm+/LP8hWJ+ZOJCTLJRix1gmwu2idE2wy4WVtGk=;
        b=xTNXBZbTh4X5Ys5eP3dxZuNSFTssflcHzwaD3p/lRn7OyjowDfc3s9gtxwKvvwqcfi
         9XByu0W4NxMvNXkRjA7U1Q/sLoVrE19G0OvY+0S9H+Kj5d7vd/X6mbyfsLHxQQbo/J7d
         nKYIUARTVvcxSCQ811uGu6j0M4o3D0bBw3pHTGi3hZLSh4SMGNZoD9Wd8kmXUvEg8LMZ
         IfVMJmwBXMBRwhaNtKaEf0qF51At3LusMGsIHNHQCDOmal/J6+IT2NsGcE9Rn0M45kle
         QG+3EyTt6A5z9He7pQtvyTnWTrgTFOYlgTfyNVurduJWcZ6MdXFzujR3uSL0tRNlvoL8
         cjvA==
X-Gm-Message-State: AO0yUKVfPLlT2km1sA5Rey5B72ZEP1+igfIEnaDTZ2f2Kr2U18D6ou2Y
	Wuvrm1OKY6s04p16K1th426ORy40iX4AUm9bDfeXHQ==
X-Google-Smtp-Source: AK7set+xwl46JOrUV3r3KhANaSFUfIsRPFuSMN+eCSPJaTT/1CcXIgWc/tLPJKtxhtV+NJ7NVwJbyg==
X-Received: by 2002:a05:6a20:7925:b0:da:f1a6:9547 with SMTP id b37-20020a056a20792500b000daf1a69547mr3615578pzg.16.1679493372680;
        Wed, 22 Mar 2023 06:56:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s22-20020aa78d56000000b006243e706195sm10065726pfe.196.2023.03.22.06.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 06:56:12 -0700 (PDT)
Message-ID: <641b08fc.a70a0220.e3cf9.1f0f@mx.google.com>
Date: Wed, 22 Mar 2023 06:56:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.175-cip29-rt12
Subject: cip/linux-5.10.y-cip-rt baseline: 177 runs,
 45 regressions (v5.10.175-cip29-rt12)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Mar 2023 13:56:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11083

cip/linux-5.10.y-cip-rt baseline: 177 runs, 45 regressions (v5.10.175-cip29=
-rt12)

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

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | defcon=
fig+x86-chromebook     | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...k+preempt_rt | 1          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora   | gcc-10   | defcon=
fig+x86-chromebook     | 1          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...k+preempt_rt | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | defcon=
fig+x86-chromebook     | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...k+preempt_rt | 1          =

at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =

dell-latitude...4305U-sarien | x86_64 | lab-collabora   | gcc-10   | defcon=
fig+x86-chromebook     | 1          =

dell-latitude...4305U-sarien | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...k+preempt_rt | 1          =

dell-latitude...8665U-sarien | x86_64 | lab-collabora   | gcc-10   | defcon=
fig+x86-chromebook     | 1          =

dell-latitude...8665U-sarien | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...k+preempt_rt | 1          =

fsl-ls1028a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

fsl-ls1088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

fsl-ls1088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig+preempt_rt         | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | defcon=
fig+x86-chromebook     | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...k+preempt_rt | 1          =

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

imx6ul-14x14-evk             | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =

imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =

imx7ulp-evk                  | arm    | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

imx7ulp-evk                  | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =

rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | defcon=
fig                    | 4          =

rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 4          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-10   | defcon=
fig+preempt_rt         | 1          =

tegra124-nyan-big            | arm    | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

tegra124-nyan-big            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.175-cip29-rt12/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.175-cip29-rt12
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      0a6a8df2de5a8e8f024b47926cff286c6ec0e31f =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | defcon=
fig+x86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/641afc557c7d61bd689c951c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641afc557c7d61bd689c9525
        failing since 54 days (last pass: v5.10.158-cip22-rt9, first fail: =
v5.10.162-cip24-rt10)

    2023-03-22T13:01:57.732968  <8>[    7.4925#

    2023-03-22T13:01:57.734199  99] <LAVA_SIGNAL_ENDRUN 0_dmesg 9730009_1.4=
.2.3.1>

    2023-03-22T13:01:57.836287  / # #export SHELL=3D/bin/sh

    2023-03-22T13:01:57.837105  =


    2023-03-22T13:01:57.938927  / # export SHELL=3D/bin/sh. /lava-9730009/e=
nvironment

    2023-03-22T13:01:57.939704  =


    2023-03-22T13:01:58.041522  / # . /lava-9730009/environment/lava-973000=
9/bin/lava-test-runner /lava-9730009/1

    2023-03-22T13:01:58.042937  =


    2023-03-22T13:01:58.043316  / # <4>[    7.866334] i2c_designware i2c_de=
signware.2: timeout in disabling adapter

    2023-03-22T13:01:58.049058  /lava-9730009/bin/lava-test-runner /lava-97=
30009/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/641af9fa3b9b6b45879c9547

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641af9fa3b9b6b45879c9550
        failing since 54 days (last pass: v5.10.158-cip22-rt9, first fail: =
v5.10.162-cip24-rt10)

    2023-03-22T12:51:51.109894  + cat uuid

    2023-03-22T12:51:51.109987  + UUID=3D9729823_1.4.2.3.1

    2023-03-22T12:51:51.113114  + set +x

    2023-03-22T12:51:51.120089  + KERNELCI_LA<8>[    8.118326] <LAVA_SIGNAL=
_ENDRUN 0_dmesg 9729823_1.4.2.3.1>

    2023-03-22T12:51:51.123250  VA=3Dy /bin/sh /opt/kernelci/dmesg.sh

    2023-03-22T12:51:51.123343  + set +x

    2023-03-22T12:51:51.227769  / # #

    2023-03-22T12:51:51.328844  export SHELL=3D/bin/sh

    2023-03-22T12:51:51.329075  #

    2023-03-22T12:51:51.429976  / # export SHELL=3D/bin/sh. /lava-9729823/e=
nvironment
 =

    ... (17 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora   | gcc-10   | defcon=
fig+x86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/641afd4416f4cb62ea9c9506

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/641afd4416f4cb62ea9c9=
507
        new failure (last pass: v5.10.162-cip24-rt10) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/641afaff0301649d899c9515

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/641afaff0301649d899c9=
516
        new failure (last pass: v5.10.162-cip24-rt10) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | defcon=
fig+x86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/641afd45088e0122399c9512

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/641afd45088e0122399c9=
513
        new failure (last pass: v5.10.162-cip24-rt10) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/641afafe0301649d899c9512

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/641afafe0301649d899c9=
513
        new failure (last pass: v5.10.162-cip24-rt10) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora   | gcc-10   | defcon=
fig+x86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/641afc66457b5fe4ca9c9539

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641afc66457b5fe4ca9c9542
        failing since 54 days (last pass: v5.10.158-cip22-rt9, first fail: =
v5.10.162-cip24-rt10)

    2023-03-22T13:02:25.116673  + set +x

    2023-03-22T13:02:25.122876  <8>[    9.829572] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9730043_1.4.2.3.1>

    2023-03-22T13:02:25.230585  / # #

    2023-03-22T13:02:25.333346  export SHELL=3D/bin/sh

    2023-03-22T13:02:25.334210  #

    2023-03-22T13:02:25.436149  / # export SHELL=3D/bin/sh. /lava-9730043/e=
nvironment

    2023-03-22T13:02:25.436987  =


    2023-03-22T13:02:25.538814  / # . /lava-9730043/environment/lava-973004=
3/bin/lava-test-runner /lava-9730043/1

    2023-03-22T13:02:25.540026  =


    2023-03-22T13:02:25.545198  / # /lava-9730043/bin/lava-test-runner /lav=
a-9730043/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/641afbdbe132c94fbc9c953a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641afbdbe132c94fbc9c9543
        failing since 54 days (last pass: v5.10.158-cip22-rt9, first fail: =
v5.10.162-cip24-rt10)

    2023-03-22T12:59:52.173198  + set +x

    2023-03-22T12:59:52.179625  <8>[    8.831301] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9729834_1.4.2.3.1>

    2023-03-22T12:59:52.284460  / # #

    2023-03-22T12:59:52.385484  export SHELL=3D/bin/sh

    2023-03-22T12:59:52.385682  #

    2023-03-22T12:59:52.486614  / # export SHELL=3D/bin/sh. /lava-9729834/e=
nvironment

    2023-03-22T12:59:52.486810  =


    2023-03-22T12:59:52.587743  / # . /lava-9729834/environment/lava-972983=
4/bin/lava-test-runner /lava-9729834/1

    2023-03-22T12:59:52.588058  =


    2023-03-22T12:59:52.588130  / # /lava-9729834/bin/lava-test-runner /lav=
a-9729834/1<4>[    9.234542] i2c_designware i2c_designware.5: timeout in di=
sabling adapter
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | defcon=
fig+x86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/641afd4516f4cb62ea9c950c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/641afd4516f4cb62ea9c9=
50d
        new failure (last pass: v5.10.162-cip24-rt10) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/641afaff0301649d899c9518

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/641afaff0301649d899c9=
519
        new failure (last pass: v5.10.162-cip24-rt10) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/641afeba57e1ba4bc59c953c

  Results:     47 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g=
20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g=
20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641afeba57e1ba4bc59c9574
        failing since 54 days (last pass: v5.10.158-cip22-rt9, first fail: =
v5.10.162-cip24-rt10)

    2023-03-22T13:11:58.974595  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 206915_1.5.2=
.4.1>
    2023-03-22T13:11:59.082789  / # #
    2023-03-22T13:11:59.185718  export SHELL=3D/bin/sh
    2023-03-22T13:11:59.186549  #
    2023-03-22T13:11:59.288490  / # export SHELL=3D/bin/sh. /lava-206915/en=
vironment
    2023-03-22T13:11:59.289277  =

    2023-03-22T13:11:59.391200  / # . /lava-206915/environment/lava-206915/=
bin/lava-test-runner /lava-206915/1
    2023-03-22T13:11:59.392483  =

    2023-03-22T13:11:59.398485  / # /lava-206915/bin/lava-test-runner /lava=
-206915/1
    2023-03-22T13:11:59.566175  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/641b02a320ca8116c39c955f

  Results:     30 PASS, 15 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/arm/defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/arm/defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641b02a320ca8116c39c958f
        failing since 54 days (last pass: v5.10.158-cip22-rt9, first fail: =
v5.10.162-cip24-rt10)

    2023-03-22T13:28:32.123035  + set +x
    2023-03-22T13:28:32.229995  TESTCASE TEST_CASE_ID=3Demerg RESULT=3Dpass=
 UNITS=3Dlines MEASUREMENT=3D0>
    2023-03-22T13:28:32.230376  =

    2023-03-22T13:28:32.230563  <8>[   23.949910] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 207147_1.5.2.4.1>
    2023-03-22T13:28:32.332726  / # #export SHELL=3D/bin/sh
    2023-03-22T13:28:32.333458  =

    2023-03-22T13:28:32.435612  / # export SHELL=3D/bin/sh. /lava-207147/en=
vironment
    2023-03-22T13:28:32.436342  =

    2023-03-22T13:28:32.538784  / # . /lava-207147/environment/lava-207147/=
bin/lava-test-runner /lava-207147/1
    2023-03-22T13:28:32.539933   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/641afd048ac3dde7fb9c9523

  Results:     31 PASS, 14 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebon=
e-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebon=
e-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641afd048ac3dde7fb9c9550
        failing since 54 days (last pass: v5.10.158-cip22-rt9, first fail: =
v5.10.162-cip24-rt10)

    2023-03-22T13:04:32.258911  / # #
    2023-03-22T13:04:32.361056  export SHELL=3D/bin/sh
    2023-03-22T13:04:32.361676  <8>[   22.520403] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 206881_1.5.2.4.1>
    2023-03-22T13:04:32.362014  #
    2023-03-22T13:04:32.463431  / # export SHELL=3D/bin/sh. /lava-206881/en=
vironment
    2023-03-22T13:04:32.464072  =

    2023-03-22T13:04:32.566038  / # . /lava-206881/environment/lava-206881/=
bin/lava-test-runner /lava-206881/1
    2023-03-22T13:04:32.567363  =

    2023-03-22T13:04:32.570670  / # /lava-206881/bin/lava-test-runner /lava=
-206881/1
    2023-03-22T13:04:32.667324  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/641b00770e0a884e4b9c9505

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beaglebo=
ne-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beaglebo=
ne-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641b00780e0a884e4b9c9538
        new failure (last pass: v5.10.158-cip22-rt9)

    2023-03-22T13:19:34.934041  <8>[   20.717138] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 207001_1.5.2.4.1>
    2023-03-22T13:19:35.043859  =

    2023-03-22T13:19:35.146882  / # #export SHELL=3D/bin/sh
    2023-03-22T13:19:35.147755  =

    2023-03-22T13:19:35.250505  / # export SHELL=3D/bin/sh. /lava-207001/en=
vironment
    2023-03-22T13:19:35.251205  =

    2023-03-22T13:19:35.353105  / # . /lava-207001/environment/lava-207001/=
bin/lava-test-runner /lava-207001/1
    2023-03-22T13:19:35.354634  =

    2023-03-22T13:19:35.359026  / # /lava-207001/bin/lava-test-runner /lava=
-207001/1
    2023-03-22T13:19:35.467007  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
dell-latitude...4305U-sarien | x86_64 | lab-collabora   | gcc-10   | defcon=
fig+x86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/641afd427f35c480b19c9549

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-dell-latitude-5400-4305U-sarien.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-dell-latitude-5400-4305U-sarien.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/641afd427f35c480b19c9=
54a
        new failure (last pass: v5.10.162-cip24-rt10) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
dell-latitude...4305U-sarien | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/641afaff0301649d899c951b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-dell-latitude-5400-4305U-sarien.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-dell-latitude-5400-4305U-sarien.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/641afaff0301649d899c9=
51c
        new failure (last pass: v5.10.162-cip24-rt10) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
dell-latitude...8665U-sarien | x86_64 | lab-collabora   | gcc-10   | defcon=
fig+x86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/641b05eacc0819e5d99c950b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-dell-latitude-5400-8665U-sarien.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-dell-latitude-5400-8665U-sarien.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/641b05eacc0819e5d99c9=
50c
        new failure (last pass: v5.10.162-cip24-rt10) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
dell-latitude...8665U-sarien | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/641afafe0301649d899c950f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-dell-latitude-5400-8665U-sarien.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-dell-latitude-5400-8665U-sarien.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/641afafe0301649d899c9=
510
        new failure (last pass: v5.10.162-cip24-rt10) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls1028a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/641afed318e16017cc9c9507

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1028a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1028a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641afed318e16017cc9c9510
        new failure (last pass: v5.10.153-cip19-rt8)

    2023-03-22T13:11:41.597322  R EXIT>
    2023-03-22T13:12:42.213011  / # #
    2023-03-22T13:12:42.314716  export SHELL=3D/bin/sh
    2023-03-22T13:12:42.315157  #
    2023-03-22T13:12:42.416397  / # export SHELL=3D/bin/sh. /lava-1181734/e=
nvironment
    2023-03-22T13:12:42.416845  =

    2023-03-22T13:12:42.518153  / # . /lava-1181734/environment/lava-118173=
4/bin/lava-test-runner /lava-1181734/0
    2023-03-22T13:12:42.518664  =

    2023-03-22T13:12:42.520716  / # /lava-1181734/bin/lava-test-runner /lav=
a-1181734/0
    2023-03-22T13:12:42.536975  mv: can't rename '/lava-1181734/0/lava-test=
-runner.conf': No such file or directory =

    ... (21 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls1088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/641afe966c3052cdb39c954d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1088a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641afe966c3052cdb39c9556
        failing since 54 days (last pass: v5.10.153-cip19-rt8, first fail: =
v5.10.162-cip24-rt10)

    2023-03-22T13:11:33.507074  [   12.863180] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1181736_1.5.2.4.1>
    2023-03-22T13:11:33.507247  h
    2023-03-22T13:11:33.507393  + set +x
    2023-03-22T13:11:33.613592  / # #
    2023-03-22T13:11:33.715566  export SHELL=3D/bin/sh
    2023-03-22T13:11:33.716035  #
    2023-03-22T13:11:33.817396  / # export SHELL=3D/bin/sh. /lava-1181736/e=
nvironment
    2023-03-22T13:11:33.817855  =

    2023-03-22T13:11:33.919205  / # . /lava-1181736/environment/lava-118173=
6/bin/lava-test-runner /lava-1181736/1
    2023-03-22T13:11:33.919932   =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls1088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/641b0116d5678b12f99c951f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/arm64/defconfig+preempt_rt/gcc-10/lab-nxp/baseline-fsl-ls108=
8a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/arm64/defconfig+preempt_rt/gcc-10/lab-nxp/baseline-fsl-ls108=
8a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641b0116d5678b12f99c9528
        failing since 54 days (last pass: v5.10.153-cip19-rt8, first fail: =
v5.10.162-cip24-rt10)

    2023-03-22T13:22:15.459582  + set +x
    2023-03-22T13:22:15.561970  / # [   14.032036] <LAVA_SIGNAL_ENDR#
    2023-03-22T13:22:15.663065  export SHELL=3D/bin/sh
    2023-03-22T13:22:15.663337  UN 0_dmesg 1181746_1.5.2.4.1>
    2023-03-22T13:22:15.663451  #
    2023-03-22T13:22:15.764405  / # export SHELL=3D/bin/sh. /lava-1181746/e=
nvironment
    2023-03-22T13:22:15.764714  =

    2023-03-22T13:22:15.865722  / # . /lava-1181746/environment/lava-118174=
6/bin/lava-test-runner /lava-1181746/1
    2023-03-22T13:22:15.866112  =

    2023-03-22T13:22:15.868015  / # /lava-1181746/bin/lava-test-runner /lav=
a-1181746/1 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | defcon=
fig+x86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/641afec1ba05fa91c39c956d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/641afec1ba05fa91c39c9=
56e
        new failure (last pass: v5.10.162-cip24-rt10) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/641aff87f238ef07e99c95be

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/641aff87f238ef07e99c9=
5bf
        new failure (last pass: v5.10.162-cip24-rt10) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/641b025c35ba8c5b0d9c968a

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/arm/defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/arm/defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641b025c35ba8c5b0d9c9692
        failing since 54 days (last pass: v5.10.158-cip22-rt9, first fail: =
v5.10.162-cip24-rt10)

    2023-03-22T13:27:47.217783  + set +x

    2023-03-22T13:27:47.319582  / # #

    2023-03-22T13:27:47.420557  export SHELL=3D/bin/sh

    2023-03-22T13:27:47.420714  <8>[    9.895720] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-03-22T13:27:47.420799  <8>[    9.897007] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9730550_1.5.2.4.1>

    2023-03-22T13:27:47.420874  #

    2023-03-22T13:27:47.521794  / # export SHELL=3D/bin/sh. /lava-9730550/e=
nvironment

    2023-03-22T13:27:47.521944  =


    2023-03-22T13:27:47.622876  / # . /lava-9730550/environment/lava-973055=
0/bin/lava-test-runner /lava-9730550/1

    2023-03-22T13:27:47.623112  =

 =

    ... (17 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/641afca7b96fc54c4c9c961d

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-s=
abrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-s=
abrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641afca7b96fc54c4c9c9625
        failing since 54 days (last pass: v5.10.158-cip22-rt9, first fail: =
v5.10.162-cip24-rt10)

    2023-03-22T13:03:25.669477  + set +x

    2023-03-22T13:03:25.698389  / # <8>[    9.856769] <LAVA_SIGNAL_TESTCASE=
 TEST_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-03-22T13:03:25.698756  <8>[    9.858022] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9730066_1.5.2.4.1>

    2023-03-22T13:03:25.804744  #

    2023-03-22T13:03:25.907715  export SHELL=3D/bin/sh

    2023-03-22T13:03:25.908547  #

    2023-03-22T13:03:26.010585  / # export SHELL=3D/bin/sh. /lava-9730066/e=
nvironment

    2023-03-22T13:03:26.011436  =


    2023-03-22T13:03:26.113656  / # . /lava-9730066/environment/lava-973006=
6/bin/lava-test-runner /lava-9730066/1

    2023-03-22T13:03:26.114921  =

 =

    ... (18 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/641b026612bf9e5b359c9514

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/arm/defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandboa=
rd-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/arm/defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandboa=
rd-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641b026612bf9e5b359c951c
        failing since 54 days (last pass: v5.10.158-cip22-rt9, first fail: =
v5.10.162-cip24-rt10)

    2023-03-22T13:27:40.520906  + set +x
    2023-03-22T13:27:40.633970  / # [    7.238890] <LAVA_SIGNAL_TESTCASE TE=
ST_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dl#
    2023-03-22T13:27:40.735917  export SHELL=3D/bin/sh
    2023-03-22T13:27:40.736501  ines MEASUREMENT=3D0>
    2023-03-22T13:27:40.736648  [    7.240215] <LAVA_SIGNAL_ENDRUN 0_dmesg =
921757_1.5.2.3.1>
    2023-03-22T13:27:40.736775  #
    2023-03-22T13:27:40.838169  / # export SHELL=3D/bin/sh. /lava-921757/en=
vironment
    2023-03-22T13:27:40.838742  =

    2023-03-22T13:27:40.940163  / # . /lava-921757/environment/lava-921757/=
bin/lava-test-runner /lava-921757/1
    2023-03-22T13:27:40.940928   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/641aff454d065faa599c9574

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6=
qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6=
qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641aff454d065faa599c957c
        failing since 54 days (last pass: v5.10.158-cip22-rt9, first fail: =
v5.10.162-cip24-rt10)

    2023-03-22T13:14:19.804628  + set +x
    2023-03-22T13:14:19.913370  / # #
    2023-03-22T13:14:20.015164  export SHELL=3D/bin/sh
    2023-03-22T13:14:20.015728  [   10.376215] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-03-22T13:14:20.015895  [   10.379401] <LAVA_SIGNAL_ENDRUN 0_dmesg =
921752_1.5.2.3.1>
    2023-03-22T13:14:20.016029  #
    2023-03-22T13:14:20.117319  / # export SHELL=3D/bin/sh. /lava-921752/en=
vironment
    2023-03-22T13:14:20.117805  =

    2023-03-22T13:14:20.219119  / # . /lava-921752/environment/lava-921752/=
bin/lava-test-runner /lava-921752/1
    2023-03-22T13:14:20.219858   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/641afc76457b5fe4ca9c9554

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6q=
p-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6q=
p-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641afc76457b5fe4ca9c955c
        failing since 54 days (last pass: v5.10.158-cip22-rt9, first fail: =
v5.10.162-cip24-rt10)

    2023-03-22T13:02:38.161734  + set +x
    2023-03-22T13:02:38.267585  / # #
    2023-03-22T13:02:38.369259  export SHELL=3D/bin/sh
    2023-03-22T13:02:38.369749  [    7.125591] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-03-22T13:02:38.369876  [    7.126920] <LAVA_SIGNAL_ENDRUN 0_dmesg =
921751_1.5.2.3.1>
    2023-03-22T13:02:38.369988  #
    2023-03-22T13:02:38.471148  / # export SHELL=3D/bin/sh. /lava-921751/en=
vironment
    2023-03-22T13:02:38.471628  =

    2023-03-22T13:02:38.572816  / # . /lava-921751/environment/lava-921751/=
bin/lava-test-runner /lava-921751/1
    2023-03-22T13:02:38.573411   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6ul-14x14-evk             | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/641afcda59bb7b030a9c953d

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx6ul-14x14-=
evk.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx6ul-14x14-=
evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641afcda59bb7b030a9c9545
        new failure (last pass: v5.10.100-cip2-rt2)

    2023-03-22T13:03:54.648365  + set +x
    2023-03-22T13:03:54.771233  TEST_CASE_ID=3Demerg RESULT=3Dpass UNITS=3D=
lines MEASUREMENT=3D0>
    2023-03-22T13:03:54.771492  =

    2023-03-22T13:03:54.771735  / # <8>[   29.671577] <LAVA_SIGNAL_ENDRUN 0=
_dmesg 1181732_1.5.2.4.1>
    2023-03-22T13:03:55.931298  #export SHELL=3D/bin/sh
    2023-03-22T13:03:55.936769  =

    2023-03-22T13:03:55.936940  / # export SHELL=3D/bin/sh
    2023-03-22T13:03:57.484142  . /lava-1181732/environment
    2023-03-22T13:03:57.489858  / # . /lava-1181732/environment
    2023-03-22T13:04:00.311828  /lava-1181732/bin/lava-test-runner /lava-11=
81732/1 =

    ... (19 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/641b0299bd96ed3f589c955d

  Results:     3 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/arm/defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/arm/defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641b0299bd96ed3f589c9565
        failing since 54 days (last pass: v5.10.153-cip19-rt8, first fail: =
v5.10.162-cip24-rt10)

    2023-03-22T13:28:31.140267  + set +x
    2023-03-22T13:28:31.245961  / # <8>[   17.241894] <LAVA_SIGNAL_TESTCASE=
 TEST_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEAS#
    2023-03-22T13:28:32.406050  export SHELL=3D/bin/sh
    2023-03-22T13:28:32.411686  UREMENT=3D0>
    2023-03-22T13:28:32.411988  <8>[   17.243264] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1181769_1.5.2.4.1>
    2023-03-22T13:28:32.412244  #
    2023-03-22T13:28:33.959528  / # export SHELL=3D/bin/sh. /lava-1181769/e=
nvironment
    2023-03-22T13:28:33.965334  =

    2023-03-22T13:28:36.786605  / # . /lava-1181769/environment/lava-118176=
9/bin/lava-test-runner /lava-1181769/1
    2023-03-22T13:28:36.792415   =

    ... (21 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/641afcd359bb7b030a9c9513

  Results:     3 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641afcd359bb7b030a9c951b
        failing since 54 days (last pass: v5.10.153-cip19-rt8, first fail: =
v5.10.162-cip24-rt10)

    2023-03-22T13:03:53.439408  + set +x
    2023-03-22T13:03:53.544003  / # <8>[   17.131754] <LAVA_SIGNAL_TESTCASE=
 TEST_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEAS#
    2023-03-22T13:03:54.704070  export SHELL=3D/bin/sh
    2023-03-22T13:03:54.709767  UREMENT=3D0>
    2023-03-22T13:03:54.710077  <8>[   17.133179] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1181729_1.5.2.4.1>
    2023-03-22T13:03:54.710333  #
    2023-03-22T13:03:56.258070  / # export SHELL=3D/bin/sh. /lava-1181729/e=
nvironment
    2023-03-22T13:03:56.263774  =

    2023-03-22T13:03:59.085961  / # . /lava-1181729/environment/lava-118172=
9/bin/lava-test-runner /lava-1181729/1
    2023-03-22T13:03:59.092215   =

    ... (21 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7ulp-evk                  | arm    | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/641b03748704cca72d9c954f

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/arm/defconfig/gcc-10/lab-nxp/baseline-imx7ulp-evk.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/arm/defconfig/gcc-10/lab-nxp/baseline-imx7ulp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641b03748704cca72d9c9557
        new failure (last pass: v5.10.153-cip19-rt8)

    2023-03-22T13:32:10.031296  + set +x
    2023-03-22T13:32:10.153672  / #
    2023-03-22T13:32:10.154571  # <8>[   29.023928] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 1181766_1.5.2.4.1>
    2023-03-22T13:32:11.314417  #export SHELL=3D/bin/sh
    2023-03-22T13:32:11.320183  =

    2023-03-22T13:32:11.320505  / # export SHELL=3D/bin/sh
    2023-03-22T13:32:12.868017  / # . /lava-1181766/environment
    2023-03-22T13:32:15.695245  /lava-1181766/bin/lava-test-runner /lava-11=
81766/1
    2023-03-22T13:32:15.701311  . /lava-1181766/environment
    2023-03-22T13:32:15.701605  / # /lava-1181766/bin/lava-test-runner /lav=
a-1181766/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7ulp-evk                  | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/641afcd759bb7b030a9c9533

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7ulp-evk.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7ulp-evk.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641afcd759bb7b030a9c953b
        new failure (last pass: v5.10.153-cip19-rt8)

    2023-03-22T13:03:58.579309  + set +x
    2023-03-22T13:03:58.702056  / #
    2023-03-22T13:03:58.702804  # <8>[   29.033282] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 1181730_1.5.2.4.1>
    2023-03-22T13:03:59.862801  #export SHELL=3D/bin/sh
    2023-03-22T13:03:59.868552  =

    2023-03-22T13:03:59.868899  / # export SHELL=3D/bin/sh
    2023-03-22T13:04:01.416731  / # . /lava-1181730/environment
    2023-03-22T13:04:04.242382  /lava-1181730/bin/lava-test-runner /lava-11=
81730/1
    2023-03-22T13:04:04.248309  . /lava-1181730/environment
    2023-03-22T13:04:04.248508  / # /lava-1181730/bin/lava-test-runner /lav=
a-1181730/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | defcon=
fig                    | 4          =


  Details:     https://kernelci.org/test/plan/id/641b025d5a8d36430c9c9513

  Results:     59 PASS, 7 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/arm/defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-ja=
q.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/arm/defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-ja=
q.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-i2c-present: https://kernelci.or=
g/test/case/id/641b025d5a8d36430c9c9541
        failing since 54 days (last pass: v5.10.158-cip22-rt9, first fail: =
v5.10.162-cip24-rt10)

    2023-03-22T13:27:46.950743   INC default to 1.

    2023-03-22T13:27:46.951244  =


    2023-03-22T13:27:46.954451  	-w	Pad to last with leading zeros
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/641b025d5a8d36430c9c9542
        failing since 54 days (last pass: v5.10.158-cip22-rt9, first fail: =
v5.10.162-cip24-rt10)

    2023-03-22T13:27:46.933260  Usage: seq [-w] [-s SEP] [FIRST [INC]] LA<8=
>[   20.718622] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-03-22T13:27:46.933496  ST

    2023-03-22T13:27:46.933965  =


    2023-03-22T13:27:46.938219  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-03-22T13:27:46.948840  FIRST,<8>[   20.731633] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/641b025d5a8d36430c9c9543
        failing since 54 days (last pass: v5.10.158-cip22-rt9, first fail: =
v5.10.162-cip24-rt10)

    2023-03-22T13:27:46.918601   multi-call binary.

    2023-03-22T13:27:46.919116  =

   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641b025d5a8d36430c9c9557
        failing since 54 days (last pass: v5.10.158-cip22-rt9, first fail: =
v5.10.162-cip24-rt10)

    2023-03-22T13:27:34.424282  / # <3>[

    2023-03-22T13:27:34.425755      7.671181] rockchip-dp ff970000.dp: no D=
P phy configured

    2023-03-22T13:27:34.426056  <3>[    7.672537] reg-fixed-voltage vcc18-l=
cd: Failed to register regulator: -517

    2023-03-22T13:27:34.426353  <6>[    7.675565] dwmmc_rockchip ff0c0000.m=
mc: IDMAC supports 32-bit address mode.

    2023-03-22T13:27:34.426673  <6>[    7.675652] dwmmc_rockchip ff0d0000.m=
mc: IDMAC supports 32-bit address mode.

    2023-03-22T13:27:34.426950  <3>[    7.679457] rockchip-dp ff970000.dp: =
no DP phy configured

    2023-03-22T13:27:34.427236  <3>[    7.680861] reg-fixed-voltage vcc18-l=
cd: Failed to register regulator: -517

    2023-03-22T13:27:34.441366  <6>[    7.684283] dwmmc_rockchip ff0c0000.m=
mc: Using internal DMA controller.

    2023-03-22T13:27:34.441750  =


    2023-03-22T13:27:34.546908  / # <6>[    7.684#
 =

    ... (105 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 4          =


  Details:     https://kernelci.org/test/plan/id/641afcaa7cf57f6d1a9c9534

  Results:     60 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-=
veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-=
veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-i2c-present: https://kernelci.or=
g/test/case/id/641afcaa7cf57f6d1a9c9564
        failing since 54 days (last pass: v5.10.158-cip22-rt9, first fail: =
v5.10.162-cip24-rt10)

    2023-03-22T13:03:22.290537  	<8>[   20.803734] <LAVA_SIGNAL_TESTCASE TE=
ST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>

    2023-03-22T13:03:22.293205  -w	Pad to last with leading zeros

    2023-03-22T13:03:22.295711  	-s SEP	String separator
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/641afcaa7cf57f6d1a9c9565
        failing since 54 days (last pass: v5.10.158-cip22-rt9, first fail: =
v5.10.162-cip24-rt10)

    2023-03-22T13:03:22.274389  Print numbers fro<8>[   20.788912] <LAVA_SI=
GNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-audio-present RESULT=3D=
fail>

    2023-03-22T13:03:22.277164  m FIRST to LAST, in steps of INC.

    2023-03-22T13:03:22.279672  FIRST, INC default to 1.

    2023-03-22T13:03:22.279888  =

   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/641afcaa7cf57f6d1a9c9566
        failing since 54 days (last pass: v5.10.158-cip22-rt9, first fail: =
v5.10.162-cip24-rt10)

    2023-03-22T13:03:22.257915  <8>[   20.775134] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>

    2023-03-22T13:03:22.261672  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-03-22T13:03:22.262143  =

   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641afcaa7cf57f6d1a9c957a
        failing since 54 days (last pass: v5.10.158-cip22-rt9, first fail: =
v5.10.162-cip24-rt10)

    2023-03-22T13:03:10.319307  <8>[    8.839812] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcrit RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-03-22T13:03:10.319605  + set +x

    2023-03-22T13:03:10.426308  #

    2023-03-22T13:03:10.427542  / # <8>[    8.850506] <LAVA_SIGNAL_TESTCASE=
 TEST_CASE_ID=3Dalert RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-03-22T13:03:10.427985  <8>[    8.859086] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-03-22T13:03:10.428401  <8>[    8.860736] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9730079_1.5.2.3.1>

    2023-03-22T13:03:10.530779  #export SHELL=3D/bin/sh

    2023-03-22T13:03:10.531694  =


    2023-03-22T13:03:10.633686  / # export SHELL=3D/bin/sh. /lava-9730079/e=
nvironment

    2023-03-22T13:03:10.634509  =

 =

    ... (21 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/641affe730d79cb2079c956a

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine6=
4-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine6=
4-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641affe730d79cb2079c959a
        failing since 54 days (last pass: v5.10.158-cip22-rt9, first fail: =
v5.10.162-cip24-rt10)

    2023-03-22T13:17:12.233618  <8>[   16.822929] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 206936_1.5.2.4.1>
    2023-03-22T13:17:12.341240  #
    2023-03-22T13:17:12.443309  / # #export SHELL=3D/bin/sh
    2023-03-22T13:17:12.443869  =

    2023-03-22T13:17:12.545542  / # export SHELL=3D/bin/sh. /lava-206936/en=
vironment
    2023-03-22T13:17:12.546305  =

    2023-03-22T13:17:12.648396  / # . /lava-206936/environment/lava-206936/=
bin/lava-test-runner /lava-206936/1
    2023-03-22T13:17:12.649339  =

    2023-03-22T13:17:12.653507  / # /lava-206936/bin/lava-test-runner /lava=
-206936/1
    2023-03-22T13:17:12.699387  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-10   | defcon=
fig+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/641b0181a03c7d07869c9506

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/arm64/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-sun=
50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/arm64/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-sun=
50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/641b0181a03c7d07869c9=
507
        new failure (last pass: v5.10.162-cip24-rt10) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
tegra124-nyan-big            | arm    | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/641b0325a8a514bdf19c9532

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/arm/defconfig/gcc-10/lab-collabora/baseline-tegra124-nyan-bi=
g.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/arm/defconfig/gcc-10/lab-collabora/baseline-tegra124-nyan-bi=
g.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641b0325a8a514bdf19c953b
        failing since 54 days (last pass: v5.10.158-cip22-rt9, first fail: =
v5.10.162-cip24-rt10)

    2023-03-22T13:30:45.207750  <8>[   17.424249] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-03-22T13:30:45.208626  + set +x

    2023-03-22T13:30:45.215997  <8>[   17.433602] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9730548_1.5.2.3.1>

    2023-03-22T13:30:45.320894  / ##

    2023-03-22T13:30:45.422829  export SHELL=3D/bin/sh

    2023-03-22T13:30:45.423310   #

    2023-03-22T13:30:45.524639  / # export SHELL=3D/bin/sh. /lava-9730548/e=
nvironment

    2023-03-22T13:30:45.525111  =


    2023-03-22T13:30:45.626486  / # . /lava-9730548/environment/lava-973054=
8/bin/lava-test-runner /lava-9730548/1

    2023-03-22T13:30:45.627280  =

 =

    ... (16 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
tegra124-nyan-big            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/641afcf8cf4a870f999c950b

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-tegra12=
4-nyan-big.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-tegra12=
4-nyan-big.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641afcf8cf4a870f999c9513
        failing since 54 days (last pass: v5.10.158-cip22-rt9, first fail: =
v5.10.162-cip24-rt10)

    2023-03-22T13:04:28.886732  <8>[   17.399992] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dalert RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-03-22T13:04:28.904487  + set +x

    2023-03-22T13:04:29.013365  #

    2023-03-22T13:04:29.014698  =


    2023-03-22T13:04:29.015100  / # <8>[   17.429608] <LAVA_SIGNAL_TESTCASE=
 TEST_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-03-22T13:04:29.015514  <8>[   17.431120] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9730067_1.5.2.3.1>

    2023-03-22T13:04:29.118360  #export SHELL=3D/bin/sh

    2023-03-22T13:04:29.119251  =


    2023-03-22T13:04:29.221356  / # export SHELL=3D/bin/sh. /lava-9730067/e=
nvironment

    2023-03-22T13:04:29.222197  =

 =

    ... (18 line(s) more)  =

 =20

