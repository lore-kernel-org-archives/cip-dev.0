Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93444C7EE25
	for <webhook@archiver.kernel.org>; Fri,  9 Jun 2023 12:10:38 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
 by mx.groups.io with SMTP id smtpd.web10.11644.1686312633983217814
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 09 Jun 2023 05:10:34 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=Tu3P3e/Z;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.181, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-650bacd6250so1416034b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 09 Jun 2023 05:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686312633; x=1688904633;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6Pe7/NM0Kj1xvBDzRA/MzQOxMA4jEayo3FHzIZRHaO0=;
        b=Tu3P3e/ZIsA/Uj6i47dUbEz0bUv/EPkqnODIIhzR+C67Zjhiqmvj9QRfRzRWnEJQyO
         b8E53puQMbq672b3CgTJNlJJaMY9leF05SR0123mVAPIXLerdiNCeJGUGz6DESDnjB2k
         jihDQzmjll3IsNxemxOumRfNyrfIxMwMt7is9Cw9FpYZjOsyLBy8/RUbO28DBlXrBPEy
         LPui45un7P5QXX9FcHaGPdxB3bFuDezro5N2uB2DycLOkWf+RVMynBH8zSUNz1F35QMr
         I8llQFXUnR0EECp+d/nZcT52YRFjEs97gBEQcLC7PqpYwquDuJRI2RrpPt4ntcJ3kfA4
         Qd3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686312633; x=1688904633;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Pe7/NM0Kj1xvBDzRA/MzQOxMA4jEayo3FHzIZRHaO0=;
        b=fAWfheQ50kvsBFHdEQfZGh/AaV87Vfr+imtEPZyoNy+HI1hhUMtNrnCWFa+4A+M7/J
         fVPszyDkHq81CEifdrM58qmtFHsxaKx1SrgkFXlFmAigTC9fSvodt0BxKIV11Zzx/1fU
         DGGmA9CU47T3Any27Nhg3gmFHK3dfv0q4YL/ljRZWrPc7qpSoej9d3LCDRT9Ao94mDzp
         k0wBl4eub25TsVBjoE1o0yAfSPYupPeBNoR6w20c1Wj+tphkCjvTm9j5RH01wWUginzO
         1ideOQ6ObMtgXqeb+Fd9uq5Uqa7vuiycjeg1/JmA5PpvolDN8Rvk4W2Qm9S9h+2XvKC0
         3Rdg==
X-Gm-Message-State: AC+VfDxgQYAJ6/zGUW3uChXIbEVYTllQn627MQAjH6nWRv5yeM1t/EdE
	dI9espbGdjp1kkb6BSkUJWrVCSqte7BST+WmGuaVWA==
X-Google-Smtp-Source: ACHHUZ7E0XEOa3AOOjGxcnshXWjv2qK3+NYeaIH1gI4/atX5jI/aaeSx3sQb6+TEDVp6t15yytYkMg==
X-Received: by 2002:a05:6a21:30cb:b0:105:27c3:1bfc with SMTP id yf11-20020a056a2130cb00b0010527c31bfcmr597223pzb.51.1686312631786;
        Fri, 09 Jun 2023 05:10:31 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a11-20020a1709027d8b00b001aadd0d7364sm3132160plm.83.2023.06.09.05.10.30
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 05:10:30 -0700 (PDT)
Message-ID: <648316b6.170a0220.250b2.5f41@mx.google.com>
Date: Fri, 09 Jun 2023 05:10:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.283-cip98-224-g5f5303d7920a9
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 87 runs,
 23 regressions (v4.19.283-cip98-224-g5f5303d7920a9)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Jun 2023 12:10:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11936

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 87 runs, 23 regression=
s (v4.19.283-cip98-224-g5f5303d7920a9)

Regressions Summary
-------------------

platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus  | x86_64 | lab-collabora   | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C523NA-A20057-coral   | x86_64 | lab-collabora   | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

beaglebone-black           | arm    | lab-broonie     | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black           | arm    | lab-cip         | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black           | arm    | lab-broonie     | gcc-10   | omap2plu=
s_defconfig          | 1          =

dove-cubox                 | arm    | lab-pengutronix | gcc-10   | mvebu_v7=
_defconfig           | 1          =

imx6q-sabrelite            | arm    | lab-collabora   | gcc-10   | multi_v7=
_defconfig           | 1          =

imx6qp-wandboard-revd1     | arm    | lab-pengutronix | gcc-10   | imx_v6_v=
7_defconfig          | 1          =

imx6qp-wandboard-revd1     | arm    | lab-pengutronix | gcc-10   | multi_v7=
_defconfig           | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

rk3288-veyron-jaq          | arm    | lab-collabora   | gcc-10   | multi_v7=
_defconfig           | 3          =

rk3399-gru-kevin           | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

zynqmp-zcu102              | arm64  | lab-cip         | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.283-cip98-224-g5f5303d7920a9/plan/baselin=
e/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.283-cip98-224-g5f5303d7920a9
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      5f5303d7920a98db8e84681ee6f1318ae918ab84 =



Test Regressions
---------------- =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus  | x86_64 | lab-collabora   | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64830cfbec3427940a306150

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-224-g5f5303d7920a9/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-224-g5f5303d7920a9/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64830cfbec3427940a306155
        failing since 141 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-06-09T11:28:38.334639  + set +x<8>[    9.921540] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10657504_1.4.2.3.1>

    2023-06-09T11:28:38.334731  =


    2023-06-09T11:28:38.436650  #

    2023-06-09T11:28:38.436964  =


    2023-06-09T11:28:38.537594  / # #export SHELL=3D/bin/sh

    2023-06-09T11:28:38.537808  =


    2023-06-09T11:28:38.638341  / # export SHELL=3D/bin/sh. /lava-10657504/=
environment

    2023-06-09T11:28:38.638538  =


    2023-06-09T11:28:38.739097  / # . /lava-10657504/environment/lava-10657=
504/bin/lava-test-runner /lava-10657504/1

    2023-06-09T11:28:38.739381  =

 =

    ... (13 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral   | x86_64 | lab-collabora   | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64830cfc33678b1819306151

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-224-g5f5303d7920a9/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-224-g5f5303d7920a9/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64830cfc33678b1819306156
        failing since 141 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-06-09T11:28:59.680163  + set +x

    2023-06-09T11:28:59.687119  <8>[   12.368719] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10657539_1.4.2.3.1>

    2023-06-09T11:28:59.791404  / # #

    2023-06-09T11:28:59.892049  export SHELL=3D/bin/sh

    2023-06-09T11:28:59.892279  #

    2023-06-09T11:28:59.992840  / # export SHELL=3D/bin/sh. /lava-10657539/=
environment

    2023-06-09T11:28:59.993044  =


    2023-06-09T11:29:00.093603  / # . /lava-10657539/environment/lava-10657=
539/bin/lava-test-runner /lava-10657539/1

    2023-06-09T11:29:00.093931  =


    2023-06-09T11:29:00.099028  / # /lava-10657539/bin/lava-test-runner /la=
va-10657539/1
 =

    ... (13 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
beaglebone-black           | arm    | lab-broonie     | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/648308a1d719b8ff7a306152

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-224-g5f5303d7920a9/arm/multi_v7_defconfig/gcc-=
10/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-224-g5f5303d7920a9/arm/multi_v7_defconfig/gcc-=
10/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648308a1d719b8ff7a30617c
        failing since 141 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-06-09T11:09:37.448498  <8>[   16.636520] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 585806_1.5.2.4.1>
    2023-06-09T11:09:37.556146  / # #
    2023-06-09T11:09:37.658623  export SHELL=3D/bin/sh
    2023-06-09T11:09:37.659131  #
    2023-06-09T11:09:37.760831  / # export SHELL=3D/bin/sh. /lava-585806/en=
vironment
    2023-06-09T11:09:37.761574  =

    2023-06-09T11:09:37.863812  / # . /lava-585806/environment/lava-585806/=
bin/lava-test-runner /lava-585806/1
    2023-06-09T11:09:37.865180  =

    2023-06-09T11:09:37.868868  / # /lava-585806/bin/lava-test-runner /lava=
-585806/1
    2023-06-09T11:09:37.935978  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
beaglebone-black           | arm    | lab-cip         | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64830bdf7482b44173306152

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-224-g5f5303d7920a9/arm/multi_v7_defconfig/gcc-=
10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-224-g5f5303d7920a9/arm/multi_v7_defconfig/gcc-=
10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64830bdf7482b44173306155
        failing since 141 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-06-09T11:23:35.645674  <8>[    8.880661] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 957987_1.5.2.4.1>
    2023-06-09T11:23:35.754792  / # #
    2023-06-09T11:23:35.857069  export SHELL=3D/bin/sh
    2023-06-09T11:23:35.857773  #
    2023-06-09T11:23:35.959631  / # export SHELL=3D/bin/sh. /lava-957987/en=
vironment
    2023-06-09T11:23:35.960337  =

    2023-06-09T11:23:36.062237  / # . /lava-957987/environment/lava-957987/=
bin/lava-test-runner /lava-957987/1
    2023-06-09T11:23:36.063392  =

    2023-06-09T11:23:36.069332  / # /lava-957987/bin/lava-test-runner /lava=
-957987/1
    2023-06-09T11:23:36.135907  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
beaglebone-black           | arm    | lab-broonie     | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/648307877116cf772230612e

  Results:     41 PASS, 10 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-224-g5f5303d7920a9/arm/omap2plus_defconfig/gcc=
-10/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-224-g5f5303d7920a9/arm/omap2plus_defconfig/gcc=
-10/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648307877116cf7722306160
        failing since 43 days (last pass: v4.19.280-cip96-59-g4b02e7efb967d=
, first fail: v4.19.280-cip96-89-g355dfa824cb4)

    2023-06-09T11:05:17.999677  + set +x<8>[   16.892250] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 585776_1.5.2.4.1>
    2023-06-09T11:05:18.000566  =

    2023-06-09T11:05:18.117867  / # #
    2023-06-09T11:05:18.219632  export SHELL=3D/bin/sh
    2023-06-09T11:05:18.220010  #
    2023-06-09T11:05:18.322026  / # export SHELL=3D/bin/sh. /lava-585776/en=
vironment
    2023-06-09T11:05:18.323113  =

    2023-06-09T11:05:18.425423  / # . /lava-585776/environment/lava-585776/=
bin/lava-test-runner /lava-585776/1
    2023-06-09T11:05:18.425949  =

    2023-06-09T11:05:18.430968  / # /lava-585776/bin/lava-test-runner /lava=
-585776/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
dove-cubox                 | arm    | lab-pengutronix | gcc-10   | mvebu_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/648307b46b71a712df30612e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: mvebu_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-224-g5f5303d7920a9/arm/mvebu_v7_defconfig/gcc-=
10/lab-pengutronix/baseline-dove-cubox.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-224-g5f5303d7920a9/arm/mvebu_v7_defconfig/gcc-=
10/lab-pengutronix/baseline-dove-cubox.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648307b46b71a712df306133
        failing since 141 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-06-09T11:06:11.357104  + set +x
    2023-06-09T11:06:11.357368  [    4.235913] <LAVA_SIGNAL_ENDRUN 0_dmesg =
972315_1.5.2.3.1>
    2023-06-09T11:06:11.464240  / # #
    2023-06-09T11:06:11.566163  export SHELL=3D/bin/sh
    2023-06-09T11:06:11.566727  #
    2023-06-09T11:06:11.667955  / # export SHELL=3D/bin/sh. /lava-972315/en=
vironment
    2023-06-09T11:06:11.668475  =

    2023-06-09T11:06:11.770034  / # . /lava-972315/environment/lava-972315/=
bin/lava-test-runner /lava-972315/1
    2023-06-09T11:06:11.770618  =

    2023-06-09T11:06:11.773233  / # /lava-972315/bin/lava-test-runner /lava=
-972315/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx6q-sabrelite            | arm    | lab-collabora   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6483087f7d6700e919306145

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-224-g5f5303d7920a9/arm/multi_v7_defconfig/gcc-=
10/lab-collabora/baseline-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-224-g5f5303d7920a9/arm/multi_v7_defconfig/gcc-=
10/lab-collabora/baseline-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6483087f7d6700e91930614a
        failing since 141 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-06-09T11:09:41.179640  / # #

    2023-06-09T11:09:41.282208  export SHELL=3D/bin/sh

    2023-06-09T11:09:41.282543  #

    2023-06-09T11:09:41.383923  / # export SHELL=3D/bin/sh. /lava-10657154/=
environment

    2023-06-09T11:09:41.384715  =


    2023-06-09T11:09:41.486435  / # . /lava-10657154/environment/lava-10657=
154/bin/lava-test-runner /lava-10657154/1

    2023-06-09T11:09:41.487824  =


    2023-06-09T11:09:41.492240  / # /lava-10657154/bin/lava-test-runner /la=
va-10657154/1

    2023-06-09T11:09:41.604205  + export 'TESTRUN_ID=3D1_bootrr'

    2023-06-09T11:09:41.604735  + cd /lava-10657154/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx6qp-wandboard-revd1     | arm    | lab-pengutronix | gcc-10   | imx_v6_v=
7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/648306efedb3007959306160

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-224-g5f5303d7920a9/arm/imx_v6_v7_defconfig/gcc=
-10/lab-pengutronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-224-g5f5303d7920a9/arm/imx_v6_v7_defconfig/gcc=
-10/lab-pengutronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648306efedb3007959306165
        failing since 141 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-06-09T11:03:00.477150  + set +x[    7.302056] <LAVA_SIGNAL_ENDRUN =
0_dmesg 972314_1.5.2.3.1>
    2023-06-09T11:03:00.477312  =

    2023-06-09T11:03:00.584429  / # #
    2023-06-09T11:03:00.686078  export SHELL=3D/bin/sh
    2023-06-09T11:03:00.686527  #
    2023-06-09T11:03:00.787857  / # export SHELL=3D/bin/sh. /lava-972314/en=
vironment
    2023-06-09T11:03:00.788415  =

    2023-06-09T11:03:00.889914  / # . /lava-972314/environment/lava-972314/=
bin/lava-test-runner /lava-972314/1
    2023-06-09T11:03:00.890544  =

    2023-06-09T11:03:00.893358  / # /lava-972314/bin/lava-test-runner /lava=
-972314/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx6qp-wandboard-revd1     | arm    | lab-pengutronix | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64830857ec59c6f06130617a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-224-g5f5303d7920a9/arm/multi_v7_defconfig/gcc-=
10/lab-pengutronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-224-g5f5303d7920a9/arm/multi_v7_defconfig/gcc-=
10/lab-pengutronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64830857ec59c6f06130617f
        failing since 141 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-06-09T11:08:58.101746  + set +x
    2023-06-09T11:08:58.101901  [    4.921635] <LAVA_SIGNAL_ENDRUN 0_dmesg =
972320_1.5.2.3.1>
    2023-06-09T11:08:58.208030  / # #
    2023-06-09T11:08:58.309440  export SHELL=3D/bin/sh
    2023-06-09T11:08:58.309813  #
    2023-06-09T11:08:58.411007  / # export SHELL=3D/bin/sh. /lava-972320/en=
vironment
    2023-06-09T11:08:58.411398  =

    2023-06-09T11:08:58.512540  / # . /lava-972320/environment/lava-972320/=
bin/lava-test-runner /lava-972320/1
    2023-06-09T11:08:58.513068  =

    2023-06-09T11:08:58.515923  / # /lava-972320/bin/lava-test-runner /lava=
-972320/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64830ac5b8b322805a306141

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-224-g5f5303d7920a9/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-224-g5f5303d7920a9/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64830ac5b8b322805a306=
142
        failing since 386 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/648309d68b3a3996a5306152

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-224-g5f5303d7920a9/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-224-g5f5303d7920a9/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/648309d68b3a3996a5306=
153
        failing since 386 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64830c2e1cc3c4335d30613d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-224-g5f5303d7920a9/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-224-g5f5303d7920a9/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64830c2e1cc3c4335d306=
13e
        failing since 386 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/648309d74232e71b4630612e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-224-g5f5303d7920a9/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-224-g5f5303d7920a9/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/648309d74232e71b46306=
12f
        failing since 386 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64830b29195640e266306139

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-224-g5f5303d7920a9/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-224-g5f5303d7920a9/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64830b29195640e266306=
13a
        failing since 386 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/648309d78b3a3996a5306156

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-224-g5f5303d7920a9/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-224-g5f5303d7920a9/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/648309d78b3a3996a5306=
157
        failing since 386 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64830aede726b9792a30612f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-224-g5f5303d7920a9/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-224-g5f5303d7920a9/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64830aede726b9792a306=
130
        failing since 386 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/648309d6dd6090123e306156

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-224-g5f5303d7920a9/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-224-g5f5303d7920a9/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/648309d6dd6090123e306=
157
        failing since 386 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
rk3288-veyron-jaq          | arm    | lab-collabora   | gcc-10   | multi_v7=
_defconfig           | 3          =


  Details:     https://kernelci.org/test/plan/id/648308796deb65a99e306149

  Results:     61 PASS, 8 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-224-g5f5303d7920a9/arm/multi_v7_defconfig/gcc-=
10/lab-collabora/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-224-g5f5303d7920a9/arm/multi_v7_defconfig/gcc-=
10/lab-collabora/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/648308796deb65a99e306179
        failing since 139 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-06-09T11:09:57.472609  BusyBox v1.31.1 (2023-05-27 14:14:16 UTC)<8=
>[   10.009585] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-06-09T11:09:57.476156   multi-call binary.

    2023-06-09T11:09:57.476376  =

   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/648308796deb65a99e30617a
        failing since 139 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-06-09T11:09:57.453780  /lava-10657163/1/../bin/lava-test-case<8>[ =
   9.992032] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-probed RE=
SULT=3Dpass>

    2023-06-09T11:09:57.453841  =

   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648308796deb65a99e30618d
        failing since 139 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-06-09T11:09:53.634888  + <8>[    6.176365] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10657163_1.5.2.3.1>

    2023-06-09T11:09:53.635644  set +x

    2023-06-09T11:09:53.741564  =


    2023-06-09T11:09:53.843145  / # #export SHELL=3D/bin/sh

    2023-06-09T11:09:53.843857  =


    2023-06-09T11:09:53.945195  / # export SHELL=3D/bin/sh. /lava-10657163/=
environment

    2023-06-09T11:09:53.945948  =


    2023-06-09T11:09:54.047318  / # . /lava-10657163/environment/lava-10657=
163/bin/lava-test-runner /lava-10657163/1

    2023-06-09T11:09:54.048470  =


    2023-06-09T11:09:54.049426  / # /lava-10657163/bin/lava-test-runner /la=
va-10657163/1
 =

    ... (16 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
rk3399-gru-kevin           | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64830904686b106d29306148

  Results:     77 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-224-g5f5303d7920a9/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-224-g5f5303d7920a9/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/64830904686b106d2930614e
        failing since 87 days (last pass: v4.19.273-cip92-277-g507c8d80b9e2=
0, first fail: v4.19.276-cip93-5-g2eb2a953ab59)

    2023-06-09T11:11:43.689320  /lava-10657184/1/../bin/lava-test-case<8>[ =
  37.691794] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Drockchip-usb2phy1-probed =
RESULT=3Dfail>

    2023-06-09T11:11:43.689451  =

   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/64830904686b106d2930614f
        failing since 87 days (last pass: v4.19.273-cip92-277-g507c8d80b9e2=
0, first fail: v4.19.276-cip93-5-g2eb2a953ab59)

    2023-06-09T11:11:42.658782  /lava-10657184/1/../bin/lava-test-case

    2023-06-09T11:11:42.667250  <8>[   36.669568] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
zynqmp-zcu102              | arm64  | lab-cip         | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/648308e7de72392fac306155

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-224-g5f5303d7920a9/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-224-g5f5303d7920a9/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648308e7de72392fac306158
        failing since 141 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-06-09T11:11:12.949466  + set +x
    2023-06-09T11:11:12.950607  <8>[    3.752565] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 958010_1.5.2.4.1>
    2023-06-09T11:11:13.056232  / # #
    2023-06-09T11:11:13.158123  export SHELL=3D/bin/sh
    2023-06-09T11:11:13.158571  #
    2023-06-09T11:11:13.259966  / # export SHELL=3D/bin/sh. /lava-958010/en=
vironment
    2023-06-09T11:11:13.260417  =

    2023-06-09T11:11:13.361852  / # . /lava-958010/environment/lava-958010/=
bin/lava-test-runner /lava-958010/1
    2023-06-09T11:11:13.362583  =

    2023-06-09T11:11:13.365422  / # /lava-958010/bin/lava-test-runner /lava=
-958010/1 =

    ... (13 line(s) more)  =

 =20

