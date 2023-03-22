Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07098C7619A
	for <webhook@archiver.kernel.org>; Wed, 22 Mar 2023 13:27:14 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web10.42805.1679491632678194490
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 22 Mar 2023 06:27:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=pKZTcO7T;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id ja10so19259778plb.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 22 Mar 2023 06:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1679491632;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jUwRCNgc/XbyeU580Ezgra/SsbCr+4ScWHHx/FYj6L8=;
        b=pKZTcO7TMlTe1rz/Ka8RxVjOYAc959NdLzcbgbj78QqNDV2QpLNERWjuxQRz1G5gPh
         Ca9D8vqpf4LbsaJB9RA9Wgcp/5gBpWGrbxZUAcxj5LFWVFVVNUzZdLBjvDq3cMEpxtCp
         tvvQVDg6i2RfQ0wkvRzZ0gTsc8R9KmNXdoNJKLJd9lvmgwWU/A+qAJKVm155kG5wGiB/
         wEBBJlpWn3GbWkypVrPNhBVUOdhxryobSXXZV3bcGgxsFUvgfmiOS/JiIaLULAtZWQTX
         U7C/2lZCu9OKPDVIsMwETSOsJ3UIc3zE6KmzrImdV36Z2B6EvCI9swljyXmSZfcPL1xI
         Cwsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679491632;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jUwRCNgc/XbyeU580Ezgra/SsbCr+4ScWHHx/FYj6L8=;
        b=iQ1r+FCy/msjQs82YuCwdnKoviC4PStmTRymNSSKl0sJmzu6V0a7Gt+rw7G6XAUjxU
         Ib1nbhFe1uAxTxkcZ8N0lPvAo5orxkf5ImUr+2OGFC3PujexE4yv1ua0Mqz9SuJgCpwJ
         vmzA0SGtv3jw6ejpvxUmGsZWQRoHYnHrh/booFiqdnt+YTDBSDRb+hTUzo46sFqIna/k
         1iJp1ykM/hj/rVBBJNKuIfsi7xBJhSCg+It0sJZJO+t/80jt5Y5Ul4xoAbS/gDysbHcZ
         kkKmdw+Ort9zFjh0nh2ufVwgTp1rHY50czLDYkS4ukWkg7HP1ENw+ydfmyDVfkpYxXyN
         w73w==
X-Gm-Message-State: AO0yUKWsIC5gy6uqowbPt68bxCjI+vwP0Q2ymMV6e6mhRtj/OQs/qOme
	tQb8Sxbt7AaCrUcaW65gbiUMqo7l6VRgKovkUsXOvQ==
X-Google-Smtp-Source: AK7set/D+MMlZjnxxVecwoNtetZ5PBO+0kq+2dNTjxF3jj3+VF1uTDYD3bgO6dY14fayI7Q7KlG0eg==
X-Received: by 2002:a05:6a20:4f1f:b0:c2:fb92:3029 with SMTP id gi31-20020a056a204f1f00b000c2fb923029mr5069861pzb.33.1679491631178;
        Wed, 22 Mar 2023 06:27:11 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f12-20020aa782cc000000b006255a16be2fsm10068954pfn.132.2023.03.22.06.27.10
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 06:27:10 -0700 (PDT)
Message-ID: <641b022e.a70a0220.31534.1f1b@mx.google.com>
Date: Wed, 22 Mar 2023 06:27:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.175-cip29-rt12
Subject: cip-gitlab/ci/pavel/linux-test baseline: 117 runs,
 25 regressions (v5.10.175-cip29-rt12)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Mar 2023 13:27:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11078

cip-gitlab/ci/pavel/linux-test baseline: 117 runs, 25 regressions (v5.10.17=
5-cip29-rt12)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =

dell-latitude...4305U-sarien | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

dell-latitude...8665U-sarien | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

fsl-ls1088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =

imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

imx6ul-14x14-evk             | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =

imx7ulp-evk                  | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =

rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 3          =

rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =

zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.175-cip29-rt12/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.175-cip29-rt12
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      0a6a8df2de5a8e8f024b47926cff286c6ec0e31f =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641af95b1265ca6ee69c9506

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/641af95b1265ca6ee69c9=
507
        new failure (last pass: v4.19.277-cip94-1098-g26d9f86d942d) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641af95a88e202d9309c9757

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/641af95a88e202d9309c9=
758
        failing since 0 day (last pass: v5.10.168-cip27-456-g42a59c4e5329, =
first fail: v4.19.277-cip94-1098-g26d9f86d942d) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641af9681681224ba89c9519

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/641af9681681224ba89c9=
51a
        failing since 0 day (last pass: v5.10.168-cip27-456-g42a59c4e5329, =
first fail: v4.19.277-cip94-1098-g26d9f86d942d) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/641afb90aba5ecfe409c9505

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-=
bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-=
bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/641afb90aba5ecfe409c9=
506
        new failure (last pass: v4.19.277-cip94-1098-g26d9f86d942d) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
dell-latitude...4305U-sarien | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641af96e1265ca6ee69c9599

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-dell-latitude-5400-4305U-sarien.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-dell-latitude-5400-4305U-sarien.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/641af96e1265ca6ee69c9=
59a
        new failure (last pass: v4.19.277-cip94-1098-g26d9f86d942d) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
dell-latitude...8665U-sarien | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641af96e1a40ecdd619c951b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-dell-latitude-5400-8665U-sarien.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-dell-latitude-5400-8665U-sarien.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/641af96e1a40ecdd619c9=
51c
        new failure (last pass: v4.19.277-cip94-1098-g26d9f86d942d) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls1088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/641afb4d3849de4a519c954d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1088a-r=
db.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1088a-r=
db.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641afb4d3849de4a519c9556
        new failure (last pass: v4.19.277-cip94-1098-g26d9f86d942d)

    2023-03-22T12:57:29.622120  [   15.018933] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1181727_1.5.2.4.1>
    2023-03-22T12:57:29.622513  h
    2023-03-22T12:57:29.622853  + set +x
    2023-03-22T12:57:29.729186  / # #
    2023-03-22T12:57:29.831027  export SHELL=3D/bin/sh
    2023-03-22T12:57:29.831477  #
    2023-03-22T12:57:29.932832  / # export SHELL=3D/bin/sh. /lava-1181727/e=
nvironment
    2023-03-22T12:57:29.933286  =

    2023-03-22T12:57:30.034685  / # . /lava-1181727/environment/lava-118172=
7/bin/lava-test-runner /lava-1181727/1
    2023-03-22T12:57:30.035430   =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641afa8ad27f5d38ec9c950e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/641afa8ad27f5d38ec9c9=
50f
        new failure (last pass: v4.19.277-cip94-1098-g26d9f86d942d) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/641afbff5942fe7b929c9505

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-i=
mx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-i=
mx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/641afbff5942fe7b929c9=
506
        new failure (last pass: v4.19.277-cip94-1098-g26d9f86d942d) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/641afaaa4a3ee71a3c9c9505

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-im=
x6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-im=
x6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/641afaaa4a3ee71a3c9c9=
506
        new failure (last pass: v4.19.277-cip94-1098-g26d9f86d942d) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/641afc4ee1527573ed9c9524

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-i=
mx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-i=
mx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/641afc4ee1527573ed9c9=
525
        new failure (last pass: v4.19.277-cip94-1098-g26d9f86d942d) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/641afae85883c3a59b9c9542

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-im=
x6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-im=
x6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/641afae85883c3a59b9c9=
543
        new failure (last pass: v4.19.277-cip94-1098-g26d9f86d942d) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/641afa1d7e501b567e9c9545

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseli=
ne-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseli=
ne-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641afa1d7e501b567e9c954d
        failing since 62 days (last pass: v5.10.158-cip22-435-g2c52868ae1cb=
c, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-03-22T12:52:38.726766  + set +x
    2023-03-22T12:52:38.841771  EASUREMENT=3D0>
    2023-03-22T12:52:38.841900  =

    2023-03-22T12:52:38.842049  / # [   10.343075] <LAVA_SIGNAL_ENDRUN 0_dm=
esg 921748_1.5.2.3.1>
    2023-03-22T12:52:38.943437  #export SHELL=3D/bin/sh
    2023-03-22T12:52:38.943883  =

    2023-03-22T12:52:39.045140  / # export SHELL=3D/bin/sh. /lava-921748/en=
vironment
    2023-03-22T12:52:39.045529  =

    2023-03-22T12:52:39.146778  / # . /lava-921748/environment/lava-921748/=
bin/lava-test-runner /lava-921748/1
    2023-03-22T12:52:39.147462   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/641af97d107dd8079c9c9518

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baselin=
e-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baselin=
e-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641af97d107dd8079c9c9520
        failing since 62 days (last pass: v5.10.158-cip22-435-g2c52868ae1cb=
c, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-03-22T12:49:58.889512  + set +x
    2023-03-22T12:49:58.996247  / # #
    2023-03-22T12:49:59.098291  export SHELL=3D/bin/sh
    2023-03-22T12:49:59.098921  [    7.196663] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-03-22T12:49:59.099278  [    7.197974] <LAVA_SIGNAL_ENDRUN 0_dmesg =
921746_1.5.2.3.1>
    2023-03-22T12:49:59.099496  #
    2023-03-22T12:49:59.200969  / # export SHELL=3D/bin/sh. /lava-921746/en=
vironment
    2023-03-22T12:49:59.201567  =

    2023-03-22T12:49:59.303551  / # . /lava-921746/environment/lava-921746/=
bin/lava-test-runner /lava-921746/1
    2023-03-22T12:49:59.304153   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6ul-14x14-evk             | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/641af9e32b0f69a0be9c9540

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx6ul=
-14x14-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx6ul=
-14x14-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641af9e32b0f69a0be9c9548
        failing since 0 day (last pass: v5.10.147-cip18-15-gef247a3cd0ad, f=
irst fail: v4.19.277-cip94-1098-g26d9f86d942d)

    2023-03-22T12:51:22.055514  + set +x
    2023-03-22T12:51:22.073827  =

    2023-03-22T12:51:22.177224  / #
    2023-03-22T12:51:22.177736  # <8>[   29.741486] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 1181717_1.5.2.4.1>
    2023-03-22T12:51:23.336437  #export SHELL=3D/bin/sh
    2023-03-22T12:51:23.342103  =

    2023-03-22T12:51:23.342394  / # export SHELL=3D/bin/sh
    2023-03-22T12:51:24.889510  . /lava-1181717/environment
    2023-03-22T12:51:24.895164  / # . /lava-1181717/environment
    2023-03-22T12:51:27.717241  /lava-1181717/bin/lava-test-runner /lava-11=
81717/1 =

    ... (19 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7ulp-evk                  | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/641af9e02b0f69a0be9c9533

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7ul=
p-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7ul=
p-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641af9e02b0f69a0be9c953b
        new failure (last pass: v5.10.145-rt74-1329-ga59fc50f38f6)

    2023-03-22T12:51:17.419350  + set +x
    2023-03-22T12:51:17.527868  / # #
    2023-03-22T12:51:18.688167  export SHELL=3D/bin/sh
    2023-03-22T12:51:18.693861  <8>[   29.018482] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-03-22T12:51:18.694156  <8>[   29.020800] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1181715_1.5.2.4.1>
    2023-03-22T12:51:18.694425  #
    2023-03-22T12:51:18.694665  / # export SHELL=3D/bin/sh
    2023-03-22T12:51:20.242306  / # . /lava-1181715/environment
    2023-03-22T12:51:23.068037  /lava-1181715/bin/lava-test-runner /lava-11=
81715/1
    2023-03-22T12:51:23.073782  . /lava-1181715/environment =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/641af827b58681a16e9c9530

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a774=
3-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a774=
3-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/641af827b58681a16e9c9=
531
        failing since 28 days (last pass: v4.4.302-cip72-rt42, first fail: =
v5.10.167-cip26-2-g28bb49f7179b) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 3          =


  Details:     https://kernelci.org/test/plan/id/641af9b099e69760769c9545

  Results:     59 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-=
rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-=
rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwmmc_rockchip-sdmmc-probed: https://kernelci.org/test/=
case/id/641af9b099e69760769c9571
        failing since 28 days (last pass: v4.4.302-cip72-rt42, first fail: =
v5.10.167-cip26-2-g28bb49f7179b)

    2023-03-22T12:50:35.552265  BusyB<8>[   20.737913] <LAVA_SIGNAL_TESTCAS=
E TEST_CASE_ID=3Ddwmmc_rockchip-driver-present RESULT=3Dpass>

    2023-03-22T12:50:35.557117  ox v1.31.1 (2023-03-10 17:51:43 UTC) multi-=
call binary.

    2023-03-22T12:50:35.557594  =


    2023-03-22T12:50:35.561736  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-03-22T12:50:35.562217  =


    2023-03-22T12:50:35.566908  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-03-22T12:50:35.569359  FIRST, INC default to 1.

    2023-03-22T12:50:35.569827  =


    2023-03-22T12:50:35.573055  	-w	Pad to last with leading zeros

    2023-03-22T12:50:35.575636  	-s SEP	String separator
 =

    ... (13 line(s) more)  =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/641af9b099e69760769c9574
        failing since 61 days (last pass: v5.10.158-cip22-435-g2c52868ae1cb=
c, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-03-22T12:50:35.504679  ST

    2023-03-22T12:50:35.504896  =


    2023-03-22T12:50:35.509621  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/641af9b099e69760769c9575
        failing since 61 days (last pass: v5.10.158-cip22-435-g2c52868ae1cb=
c, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-03-22T12:50:35.488190  BusyBox v1.31.1 (2023-03-10 17:51:43 UTC)<8=
>[   20.679300] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-probed=
 RESULT=3Dpass>

    2023-03-22T12:50:35.489492   multi-call binary.

    2023-03-22T12:50:35.490041  =


    2023-03-22T12:50:35.503527  Usage: seq [-w] [-s SEP] [FIRST [INC]] LA<8=
>[   20.692828] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>
   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/641afb637d3bc656269c9506

  Results:     83 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora=
/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora=
/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/641afb637d3bc656269c950f
        failing since 0 day (last pass: v5.10.168-cip27-456-g42a59c4e5329, =
first fail: v4.19.277-cip94-1098-g26d9f86d942d)

    2023-03-22T12:57:55.485362  /lava-9729951/1/../bin/lava-test-case

    2023-03-22T12:57:55.499829  /lava-9729951/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/641afb637d3bc656269c9510
        failing since 0 day (last pass: v5.10.168-cip27-456-g42a59c4e5329, =
first fail: v4.19.277-cip94-1098-g26d9f86d942d)

    2023-03-22T12:57:54.465145  /lava-9729951/1/../bin/lava-test-case

    2023-03-22T12:57:54.477479  <8>[   32.199417] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/641afbc432aee9c6d99c9519

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a6=
4-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a6=
4-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/641afbc432aee9c6d99c9=
51a
        new failure (last pass: v4.19.277-cip94-1098-g26d9f86d942d) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/641afb827d3bc656269c9578

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/arm64/defconfig/gcc-10/lab-cip/baseline-zynqmp-zcu102=
.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/arm64/defconfig/gcc-10/lab-cip/baseline-zynqmp-zcu102=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/641afb827d3bc656269c9=
579
        new failure (last pass: v4.19.277-cip94-1098-g26d9f86d942d) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/641afcfe8ac3dde7fb9c951b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/basel=
ine-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/basel=
ine-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/641afcfe8ac3dde7fb9c9=
51c
        new failure (last pass: v4.19.277-cip94-1098-g26d9f86d942d) =

 =20

