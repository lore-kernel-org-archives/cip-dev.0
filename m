Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30B4C001DF
	for <webhook@archiver.kernel.org>; Sat, 15 Jul 2023 02:01:09 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web11.4485.1689386468529797141
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 14 Jul 2023 19:01:08 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=bPMu8kTX;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.169, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1b8a462e0b0so15987875ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 14 Jul 2023 19:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689386467; x=1691978467;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OKY2sS1R+QK8s5iNqoT4Xhr3jc/RROmQGyVlGwClLMI=;
        b=bPMu8kTXDCjAp30FQBLH0qmLXXsLK0uX2C5Pjul4tNrF2zi8/kBNMgxNod/ATf2qIg
         VmIJd+RIQkk8VA1P8oMGkX3K2xvKSj1zs5I83T1MxLYigtv1T58PfOG+donU6E3orLcz
         Jo+gP7L2IHxp8kYwqGcvxg6pJHs1+OMpbLm2HiFFzqZ2IkrdZehQO2CaXK1NQ2TDOU9m
         3I0rWZc2WWS85c0gi5jPxeq1mTVk1cL+YgZGYO/GHg84PmqXHwW9cR/yTWh8dVuCzNo7
         hJ2a75M67MdruEt8UekI8F9UkcF7NjUK24ZGGwCcbp5bMdfy4bxD/UXZZezUsIM7kXXK
         o9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689386467; x=1691978467;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OKY2sS1R+QK8s5iNqoT4Xhr3jc/RROmQGyVlGwClLMI=;
        b=E7lmh7y7QqNTd0+qeNz2wXOFODPL2Mqm0X+Vey8z94ZiWwvLH1RBAM0Yo632MhNF76
         knuZBoeOPAHrWopSUHfIrFJ++GJGD1bM4Z5BUOecIVjs+XZBm5SViaVs5IMwagcE9qtO
         mKzBL9qJoaDhoDKYEY/m6MsysSzN1CDu4slL8+OJzuou1jN7FgvSwegYDtiZ8fk9A5B+
         wwNdmDHGIqpjTVvGUVPjBlbFtMq/jGnIfNpWk5UIviS8wrLt32RGkuOKKAvY2tIG/r3f
         6+FkSZG8RBXfKNWPvT+4C02Yj/yuR/tt1heezg5tX4jVdS1Ou0/2bS+8KFHt/eHfhtJ1
         2LnQ==
X-Gm-Message-State: ABy/qLbJjhXC2hc2xNtY45vvt7KX94BbzAi1gQZ4uuh+uAfHd2N5+Mio
	BWOOkqWaHOGdRFCjvMQN0P+bnY454NHkza2XGt0Iow==
X-Google-Smtp-Source: APBJJlGUral/Qt96ccoyTmPTG+sAwtHxn4rBrlgen0RjrVMdf+gBy11IgKVqYN9kexTxLcSlCElrxQ==
X-Received: by 2002:a17:902:e851:b0:1b9:cf52:2c08 with SMTP id t17-20020a170902e85100b001b9cf522c08mr6299403plg.62.1689386466212;
        Fri, 14 Jul 2023 19:01:06 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 20-20020a170902ee5400b001b81a97860asm8365928plo.27.2023.07.14.19.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 19:01:05 -0700 (PDT)
Message-ID: <64b1fde1.170a0220.ac06d.3ccd@mx.google.com>
Date: Fri, 14 Jul 2023 19:01:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Kernel: v5.10.186-cip37-rt15
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip-rt baseline: 179 runs,
 31 regressions (v5.10.186-cip37-rt15)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 15 Jul 2023 02:01:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12354

cip/linux-5.10.y-cip-rt baseline: 179 runs, 31 regressions (v5.10.186-cip37=
-rt15)

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

asus-C523NA-A20057-coral     | x86_64 | lab-collabora   | gcc-10   | defcon=
fig+x86-chromebook     | 1          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...k+preempt_rt | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =

fsl-ls1028a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

fsl-ls1088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

fsl-ls2088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig+preempt_rt         | 1          =

fsl-lx2160a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig+preempt_rt         | 1          =

fsl-lx2160a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | defcon=
fig+x86-chromebook     | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
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

r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =

rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 4          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.186-cip37-rt15/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.186-cip37-rt15
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      db05335d4d4ee47b8fc64652b2c2ad8e57eeaf52 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | defcon=
fig+x86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/64b1f42e98e94b4ca68ace8a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b1f42e98e94b4ca68ace8f
        failing since 169 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-07-15T01:19:08.839875  + set +x

    2023-07-15T01:19:08.846296  <8>[   10.066249] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11090635_1.4.2.3.1>

    2023-07-15T01:19:08.954493  / #

    2023-07-15T01:19:09.057464  # #export SHELL=3D/bin/sh

    2023-07-15T01:19:09.058283  =


    2023-07-15T01:19:09.159812  / # export SHELL=3D/bin/sh. /lava-11090635/=
environment

    2023-07-15T01:19:09.160644  =


    2023-07-15T01:19:09.262326  / # . /lava-11090635/environment/lava-11090=
635/bin/lava-test-runner /lava-11090635/1

    2023-07-15T01:19:09.263655  =


    2023-07-15T01:19:09.269826  / # /lava-11090635/bin/lava-test-runner /la=
va-11090635/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/64b1f56eb0e39d51148ace6b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b1f56eb0e39d51148ace70
        failing since 169 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-07-15T01:24:42.310860  + cat uuid

    2023-07-15T01:24:42.311348  + UUID=3D11090681_1.4.2.3.1

    2023-07-15T01:24:42.314714  + set +x

    2023-07-15T01:24:42.320860  + KERNELCI_<8>[    7.953412] <LAVA_SIGNAL_E=
NDRUN 0_dmesg 11090681_1.4.2.3.1>

    2023-07-15T01:24:42.324347  LAVA=3Dy /bin/sh /opt/kernelci/dmesg.sh

    2023-07-15T01:24:42.324731  + set +x

    2023-07-15T01:24:42.432095  / # #

    2023-07-15T01:24:42.534424  export SHELL=3D/bin/sh

    2023-07-15T01:24:42.535204  #

    2023-07-15T01:24:42.636753  / # export SHELL=3D/bin/sh. /lava-11090681/=
environment
 =

    ... (17 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora   | gcc-10   | defcon=
fig+x86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/64b1f42b98e94b4ca68ace42

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b1f42b98e94b4ca68ace47
        failing since 169 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-07-15T01:19:42.081067  <8#

    2023-07-15T01:19:42.082100  >[    7.800347] <LAVA_SIGNAL_ENDRUN 0_dmesg=
 11090621_1.4.2.3.1>

    2023-07-15T01:19:42.184014  / # #export SHELL=3D/bin/sh

    2023-07-15T01:19:42.184901  =


    2023-07-15T01:19:42.286692  / # export SHELL=3D/bin/sh. /lava-11090621/=
environment

    2023-07-15T01:19:42.287430  =


    2023-07-15T01:19:42.388908  / # . /lava-11090621/environment/lava-11090=
621/bin/lava-test-runner /lava-11090621/1

    2023-07-15T01:19:42.389965  =


    2023-07-15T01:19:42.390304  / # /lava-11090621/bin/lava-test-runner /la=
va-11090621/1<4>[    8.215016] i2c_designware i2c_designware.5: timeout in =
disabling adapter

    2023-07-15T01:19:42.395833  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/64b1f559aab5774d708ace29

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b1f559aab5774d708ace2e
        failing since 169 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-07-15T01:25:02.799435  + set +x

    2023-07-15T01:25:02.806265  <8>[    8.631626] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11090668_1.4.2.3.1>

    2023-07-15T01:25:02.910463  / # #

    2023-07-15T01:25:03.011049  export SHELL=3D/bin/sh

    2023-07-15T01:25:03.011211  #

    2023-07-15T01:25:03.111706  / # export SHELL=3D/bin/sh. /lava-11090668/=
environment

    2023-07-15T01:25:03.111873  =


    2023-07-15T01:25:03.212396  / # . /lava-11090668/environment/lava-11090=
668/bin/lava-test-runner /lava-11090668/1

    2023-07-15T01:25:03.212653  =


    2023-07-15T01:25:03.212723  / # /lava-11090668/bin/lava-test-runner /la=
va-11090668/1<4>[    9.036796] i2c_designware i2c_designware.5: timeout in =
disabling adapter
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64b1f58d98d8f5709e8ace80

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/arm/defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/arm/defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b1f58d98d8f5709e8aceac
        failing since 169 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-07-15T01:24:59.080720  / # #
    2023-07-15T01:24:59.182657  export SHELL=3D/bin/sh
    2023-07-15T01:24:59.183116  <8>[   21.583478] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 720592_1.5.2.4.1>
    2023-07-15T01:24:59.183378  #
    2023-07-15T01:24:59.284544  / # export SHELL=3D/bin/sh. /lava-720592/en=
vironment
    2023-07-15T01:24:59.285144  =

    2023-07-15T01:24:59.386475  / # . /lava-720592/environment/lava-720592/=
bin/lava-test-runner /lava-720592/1
    2023-07-15T01:24:59.387246  =

    2023-07-15T01:24:59.391590  / # /lava-720592/bin/lava-test-runner /lava=
-720592/1
    2023-07-15T01:24:59.476168  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64b1ee43bfdd33a5428ace8c

  Results:     30 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebon=
e-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebon=
e-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b1ee43bfdd33a5428aceaf
        failing since 168 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-07-15T00:53:55.095238  + set +x
    2023-07-15T00:53:55.201353  TESTCASE TEST_CASE_ID=3Demerg RESULT=3Dpass=
 UNITS=3Dlines MEASUREMENT=3D0>
    2023-07-15T00:53:55.201683  =

    2023-07-15T00:53:55.201927  <8>[   22.103560] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 720545_1.5.2.4.1>
    2023-07-15T00:53:55.303773  / # #export SHELL=3D/bin/sh
    2023-07-15T00:53:55.304744  =

    2023-07-15T00:53:55.406608  / # export SHELL=3D/bin/sh. /lava-720545/en=
vironment
    2023-07-15T00:53:55.407189  =

    2023-07-15T00:53:55.508978  / # . /lava-720545/environment/lava-720545/=
bin/lava-test-runner /lava-720545/1
    2023-07-15T00:53:55.509856   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64b1ee43bfdd33a5428ace58

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beaglebone-bl=
ack.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beaglebone-bl=
ack.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b1ee43bfdd33a5428ace5b
        failing since 168 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-07-15T00:53:57.310737  <8>[   15.700940] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 986256_1.5.2.4.1>
    2023-07-15T00:53:57.420162  / # #
    2023-07-15T00:53:57.522934  export SHELL=3D/bin/sh
    2023-07-15T00:53:57.523639  #
    2023-07-15T00:53:57.625498  / # export SHELL=3D/bin/sh. /lava-986256/en=
vironment
    2023-07-15T00:53:57.626207  =

    2023-07-15T00:53:57.728047  / # . /lava-986256/environment/lava-986256/=
bin/lava-test-runner /lava-986256/1
    2023-07-15T00:53:57.729240  =

    2023-07-15T00:53:57.735547  / # /lava-986256/bin/lava-test-runner /lava=
-986256/1
    2023-07-15T00:53:57.827376  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64b1f54c5dcfc641048ace3c

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beaglebo=
ne-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beaglebo=
ne-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b1f54c5dcfc641048ace72
        failing since 114 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.175-cip29-rt12)

    2023-07-15T01:24:12.659525  <8>[   20.128286] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 720588_1.5.2.4.1>
    2023-07-15T01:24:12.768211  / # #
    2023-07-15T01:24:12.871508  export SHELL=3D/bin/sh
    2023-07-15T01:24:12.872204  #
    2023-07-15T01:24:12.974096  / # export SHELL=3D/bin/sh. /lava-720588/en=
vironment
    2023-07-15T01:24:12.974781  =

    2023-07-15T01:24:13.076542  / # . /lava-720588/environment/lava-720588/=
bin/lava-test-runner /lava-720588/1
    2023-07-15T01:24:13.077583  =

    2023-07-15T01:24:13.082190  / # /lava-720588/bin/lava-test-runner /lava=
-720588/1
    2023-07-15T01:24:13.186476  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64b1f5e20a46ea7d148ace3d

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beaglebone-b=
lack.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beaglebone-b=
lack.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b1f5e20a46ea7d148ace40
        failing since 114 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.175-cip29-rt12)

    2023-07-15T01:26:45.114667  <8>[   14.196754] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 986270_1.5.2.4.1>
    2023-07-15T01:26:45.221944  / # #
    2023-07-15T01:26:45.323919  export SHELL=3D/bin/sh
    2023-07-15T01:26:45.324380  #
    2023-07-15T01:26:45.425789  / # export SHELL=3D/bin/sh. /lava-986270/en=
vironment
    2023-07-15T01:26:45.426275  =

    2023-07-15T01:26:45.527684  / # . /lava-986270/environment/lava-986270/=
bin/lava-test-runner /lava-986270/1
    2023-07-15T01:26:45.528409  =

    2023-07-15T01:26:45.530637  / # /lava-986270/bin/lava-test-runner /lava=
-986270/1
    2023-07-15T01:26:45.640838  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls1028a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64b1f77bcd94f13f3c8ace63

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1028a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1028a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b1f77bcd94f13f3c8ace68
        failing since 114 days (last pass: v5.10.153-cip19-rt8, first fail:=
 v5.10.175-cip29-rt12)

    2023-07-15T01:33:39.000771  / # [   20.072237] <LAVA#
    2023-07-15T01:33:39.102136  export SHELL=3D/bin/sh
    2023-07-15T01:33:39.102543  _SIGNAL_ENDRUN 0_dmesg 1236717_1.5.2.4.1>
    2023-07-15T01:33:39.102799  #
    2023-07-15T01:33:39.203688  / # export SHELL=3D/bin/sh. /lava-1236717/e=
nvironment
    2023-07-15T01:33:39.204092  =

    2023-07-15T01:33:39.305076  / # . /lava-1236717/environment/lava-123671=
7/bin/lava-test-runner /lava-1236717/1
    2023-07-15T01:33:39.305762  =

    2023-07-15T01:33:39.309892  / # /lava-1236717/bin/lava-test-runner /lav=
a-1236717/1
    2023-07-15T01:33:39.327917  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls1088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64b1f78faad0a7f3938ace36

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1088a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b1f78faad0a7f3938ace3b
        failing since 169 days (last pass: v5.10.153-cip19-rt8, first fail:=
 v5.10.162-cip24-rt10)

    2023-07-15T01:33:50.267225  kernelci/dmesg.s[   14.278613] <LAVA_SIGNAL=
_ENDRUN 0_dmesg 1236714_1.5.2.4.1>
    2023-07-15T01:33:50.267511  h
    2023-07-15T01:33:50.267748  + set +x
    2023-07-15T01:33:50.370810  / # #
    2023-07-15T01:33:50.472188  export SHELL=3D/bin/sh
    2023-07-15T01:33:50.472591  #
    2023-07-15T01:33:50.573528  / # export SHELL=3D/bin/sh. /lava-1236714/e=
nvironment
    2023-07-15T01:33:50.573926  =

    2023-07-15T01:33:50.674884  / # . /lava-1236714/environment/lava-123671=
4/bin/lava-test-runner /lava-1236714/1
    2023-07-15T01:33:50.675555   =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls2088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/64b1eae7bedfae97cc8ace1d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/arm64/defconfig+preempt_rt/gcc-10/lab-nxp/baseline-fsl-ls208=
8a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/arm64/defconfig+preempt_rt/gcc-10/lab-nxp/baseline-fsl-ls208=
8a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b1eae7bedfae97cc8ace22
        failing since 2 days (last pass: v5.10.153-cip19-rt8, first fail: v=
5.10.162-cip24-rt10)

    2023-07-15T00:39:54.994669  / # [   13.802384] <LAVA#
    2023-07-15T00:39:55.096076  export SHELL=3D/bin/sh
    2023-07-15T00:39:55.096488  _SIGNAL_ENDRUN 0_dmesg 1236697_1.5.2.4.1>
    2023-07-15T00:39:55.096729  #
    2023-07-15T00:39:55.197649  / # export SHELL=3D/bin/sh. /lava-1236697/e=
nvironment
    2023-07-15T00:39:55.198061  =

    2023-07-15T00:39:55.299021  / # . /lava-1236697/environment/lava-123669=
7/bin/lava-test-runner /lava-1236697/1
    2023-07-15T00:39:55.299714  =

    2023-07-15T00:39:55.304079  / # /lava-1236697/bin/lava-test-runner /lav=
a-1236697/1
    2023-07-15T00:39:55.320499  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-lx2160a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/64b1eaead150b5e1868ace2f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/arm64/defconfig+preempt_rt/gcc-10/lab-nxp/baseline-fsl-lx216=
0a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/arm64/defconfig+preempt_rt/gcc-10/lab-nxp/baseline-fsl-lx216=
0a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b1eaead150b5e1868ace34
        new failure (last pass: v5.10.153-cip19-rt8)

    2023-07-15T00:39:48.330489  [    9.975173] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1236698_1.5.2.4.1>
    2023-07-15T00:39:48.435195  / # #
    2023-07-15T00:39:48.536695  export SHELL=3D/bin/sh
    2023-07-15T00:39:48.537165  #
    2023-07-15T00:39:48.638157  / # export SHELL=3D/bin/sh. /lava-1236698/e=
nvironment
    2023-07-15T00:39:48.638569  =

    2023-07-15T00:39:48.739544  / # . /lava-1236698/environment/lava-123669=
8/bin/lava-test-runner /lava-1236698/1
    2023-07-15T00:39:48.740220  =

    2023-07-15T00:39:48.744214  / # /lava-1236698/bin/lava-test-runner /lav=
a-1236698/1
    2023-07-15T00:39:48.760374  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-lx2160a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64b1f792cd94f13f3c8ace70

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b1f792cd94f13f3c8ace75
        new failure (last pass: v5.10.153-cip19-rt8)

    2023-07-15T01:33:41.724351  / # [    9.665878] <LAVA#
    2023-07-15T01:33:41.825764  export SHELL=3D/bin/sh
    2023-07-15T01:33:41.826166  _SIGNAL_ENDRUN 0_dmesg 1236715_1.5.2.4.1>
    2023-07-15T01:33:41.826447  #
    2023-07-15T01:33:41.927427  / # export SHELL=3D/bin/sh. /lava-1236715/e=
nvironment
    2023-07-15T01:33:41.927948  =

    2023-07-15T01:33:42.029017  / # . /lava-1236715/environment/lava-123671=
5/bin/lava-test-runner /lava-1236715/1
    2023-07-15T01:33:42.029899  =

    2023-07-15T01:33:42.242994  / # /lava-1236715/bin/lava-test-runner /lav=
a-1236715/1
    2023-07-15T01:33:42.259289  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | defcon=
fig+x86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/64b1f41f279f95cbb28ace4e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b1f41f279f95cbb28ace53
        failing since 57 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v5.10.179-cip32-rt13)

    2023-07-15T01:19:13.971319  + set +x

    2023-07-15T01:19:13.978071  <8>[    6.403143] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11090622_1.4.2.3.1>

    2023-07-15T01:19:14.079601  /#

    2023-07-15T01:19:14.180539   # #export SHELL=3D/bin/sh

    2023-07-15T01:19:14.180701  =


    2023-07-15T01:19:14.281359  / # export SHELL=3D/bin/sh. /lava-11090622/=
environment

    2023-07-15T01:19:14.281531  =


    2023-07-15T01:19:14.382232  / # . /lava-11090622/environment/lava-11090=
622/bin/lava-test-runner /lava-11090622/1

    2023-07-15T01:19:14.382925  =


    2023-07-15T01:19:14.387934  / # /lava-11090622/bin/lava-test-runner /la=
va-11090622/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/64b1f558b0e39d51148ace1d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b1f558b0e39d51148ace22
        failing since 57 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v5.10.179-cip32-rt13)

    2023-07-15T01:25:06.780472  + set<8>[   11.219171] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11090663_1.4.2.3.1>

    2023-07-15T01:25:06.780629   +x

    2023-07-15T01:25:06.883244  #

    2023-07-15T01:25:06.883572  =


    2023-07-15T01:25:06.984138  / # #export SHELL=3D/bin/sh

    2023-07-15T01:25:06.984334  =


    2023-07-15T01:25:07.084870  / # export SHELL=3D/bin/sh. /lava-11090663/=
environment

    2023-07-15T01:25:07.085032  =


    2023-07-15T01:25:07.185546  / # . /lava-11090663/environment/lava-11090=
663/bin/lava-test-runner /lava-11090663/1

    2023-07-15T01:25:07.185890  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64b1f571ac792303b98ace28

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/arm/defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/arm/defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b1f571ac792303b98ace2d
        failing since 169 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-07-15T01:24:59.213345  + set +x

    2023-07-15T01:24:59.214244  / # <8>[    9.048069] <LAVA_SIGNAL_TESTCASE=
 TEST_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-07-15T01:24:59.214580  <8>[    9.050454] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11090656_1.5.2.4.1>

    2023-07-15T01:24:59.319893  #

    2023-07-15T01:24:59.422431  export SHELL=3D/bin/sh

    2023-07-15T01:24:59.423196  #

    2023-07-15T01:24:59.525190  / # export SHELL=3D/bin/sh. /lava-11090656/=
environment

    2023-07-15T01:24:59.525951  =


    2023-07-15T01:24:59.627925  / # . /lava-11090656/environment/lava-11090=
656/bin/lava-test-runner /lava-11090656/1

    2023-07-15T01:24:59.629151  =

 =

    ... (18 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64b1ee18bfdd33a5428ace35

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-s=
abrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-s=
abrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b1ee18bfdd33a5428ace3a
        failing since 168 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-07-15T00:53:38.213287  + set +x

    2023-07-15T00:53:38.214102  / # <8>[    9.037682] <LAVA_SIGNAL_TESTCASE=
 TEST_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-07-15T00:53:38.214400  <8>[    9.038932] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11090588_1.5.2.4.1>

    2023-07-15T00:53:38.319450  #

    2023-07-15T00:53:38.422077  export SHELL=3D/bin/sh

    2023-07-15T00:53:38.422768  #

    2023-07-15T00:53:38.524655  / # export SHELL=3D/bin/sh. /lava-11090588/=
environment

    2023-07-15T00:53:38.525351  =


    2023-07-15T00:53:38.627190  / # . /lava-11090588/environment/lava-11090=
588/bin/lava-test-runner /lava-11090588/1

    2023-07-15T00:53:38.628411  =

 =

    ... (18 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64b1f539fd0e6d618c8ace31

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/arm/defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandboa=
rd-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/arm/defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandboa=
rd-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b1f539fd0e6d618c8ace36
        failing since 169 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-07-15T01:24:02.708901  + set +x
    2023-07-15T01:24:02.814994  / # #
    2023-07-15T01:24:02.916622  export SHELL=3D/bin/sh
    2023-07-15T01:24:02.917097  [    7.123412] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-07-15T01:24:02.917246  [    7.124751] <LAVA_SIGNAL_ENDRUN 0_dmesg =
995312_1.5.2.3.1>
    2023-07-15T01:24:02.917366  #
    2023-07-15T01:24:03.018618  / # export SHELL=3D/bin/sh. /lava-995312/en=
vironment
    2023-07-15T01:24:03.019175  =

    2023-07-15T01:24:03.120616  / # . /lava-995312/environment/lava-995312/=
bin/lava-test-runner /lava-995312/1
    2023-07-15T01:24:03.121304   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64b1f575ac792303b98ace37

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6=
qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6=
qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b1f575ac792303b98ace3c
        failing since 169 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-07-15T01:24:59.911241  + set +x
    2023-07-15T01:25:00.025771  [    8.905842] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines#
    2023-07-15T01:25:00.026448   MEASUREMENT=3D0>
    2023-07-15T01:25:00.026591  / # [    8.908451] <LAVA_SIGNAL_ENDRUN 0_dm=
esg 995316_1.5.2.3.1>
    2023-07-15T01:25:00.128090  #export SHELL=3D/bin/sh
    2023-07-15T01:25:00.128606  =

    2023-07-15T01:25:00.229955  / # export SHELL=3D/bin/sh. /lava-995316/en=
vironment
    2023-07-15T01:25:00.230449  =

    2023-07-15T01:25:00.331803  / # . /lava-995316/environment/lava-995316/=
bin/lava-test-runner /lava-995316/1
    2023-07-15T01:25:00.332427   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64b1ee09ef6a9a3a698ace41

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6q=
p-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6q=
p-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b1ee09ef6a9a3a698ace46
        failing since 168 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-07-15T00:53:11.351873  + set +x
    2023-07-15T00:53:11.457987  / # #
    2023-07-15T00:53:11.559698  export SHELL=3D/bin/sh
    2023-07-15T00:53:11.560150  [    7.072982] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-07-15T00:53:11.560319  [    7.074317] <LAVA_SIGNAL_ENDRUN 0_dmesg =
995309_1.5.2.3.1>
    2023-07-15T00:53:11.560461  #
    2023-07-15T00:53:11.661724  / # export SHELL=3D/bin/sh. /lava-995309/en=
vironment
    2023-07-15T00:53:11.662188  =

    2023-07-15T00:53:11.763538  / # . /lava-995309/environment/lava-995309/=
bin/lava-test-runner /lava-995309/1
    2023-07-15T00:53:11.764156   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6ul-14x14-evk             | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64b1ee692fb8a232038ace49

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx6ul-14x14-=
evk.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx6ul-14x14-=
evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b1ee692fb8a232038ace4e
        failing since 114 days (last pass: v5.10.100-cip2-rt2, first fail: =
v5.10.175-cip29-rt12)

    2023-07-15T00:54:53.759395  <8>[   29.623392] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1236703_1.5.2.4.1>
    2023-07-15T00:54:53.865167  / #
    2023-07-15T00:54:55.021577  # #export SHELL=3D/bin/sh
    2023-07-15T00:54:55.027237  =

    2023-07-15T00:54:56.569446  / # export SHELL=3D/bin/sh. /lava-1236703/e=
nvironment
    2023-07-15T00:54:56.575107  =

    2023-07-15T00:54:59.387651  / # . /lava-1236703/environment/lava-123670=
3/bin/lava-test-runner /lava-1236703/1
    2023-07-15T00:54:59.393603  =

    2023-07-15T00:54:59.395357  / # /lava-1236703/bin/lava-test-runner /lav=
a-1236703/1
    2023-07-15T00:54:59.494239  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (17 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64b1f59a45cbc047fb8ace4a

  Results:     3 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/arm/defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/arm/defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b1f59a45cbc047fb8ace4f
        failing since 169 days (last pass: v5.10.153-cip19-rt8, first fail:=
 v5.10.162-cip24-rt10)

    2023-07-15T01:25:26.466284  + set +x
    2023-07-15T01:25:26.496085  =

    2023-07-15T01:25:26.599632  <8>[   1#
    2023-07-15T01:25:26.600353  7.188580] <LAVA_SIGNAL_ENDRUN 0_dmesg 12367=
07_1.5.2.4.1>
    2023-07-15T01:25:27.755839  / # #export SHELL=3D/bin/sh
    2023-07-15T01:25:27.761459  =

    2023-07-15T01:25:29.303701  / # export SHELL=3D/bin/sh. /lava-1236707/e=
nvironment
    2023-07-15T01:25:29.309357  =

    2023-07-15T01:25:32.121555  / # . /lava-1236707/environment/lava-123670=
7/bin/lava-test-runner /lava-1236707/1
    2023-07-15T01:25:32.127557   =

    ... (21 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64b1ee562fb8a232038ace27

  Results:     3 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b1ee562fb8a232038ace2c
        failing since 168 days (last pass: v5.10.153-cip19-rt8, first fail:=
 v5.10.162-cip24-rt10)

    2023-07-15T00:54:24.721675  + set +x
    2023-07-15T00:54:24.722519  / # <8>[   17.171253] <LAVA_SIGNAL_TESTCASE=
 TEST_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-07-15T00:54:24.826693  <8>[   17.172678] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1236702_#
    2023-07-15T00:54:25.982802  export SHELL=3D/bin/sh
    2023-07-15T00:54:25.988518  1.5.2.4.1>
    2023-07-15T00:54:25.988825  #
    2023-07-15T00:54:25.989061  / # export SHELL=3D/bin/sh
    2023-07-15T00:54:27.530799  / # . /lava-1236702/environment
    2023-07-15T00:54:30.348393  /lava-1236702/bin/lava-test-runner /lava-12=
36702/1
    2023-07-15T00:54:30.354371  . /lava-1236702/environment =

    ... (21 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7ulp-evk                  | arm    | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64b1f5c40a46ea7d148ace28

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/arm/defconfig/gcc-10/lab-nxp/baseline-imx7ulp-evk.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/arm/defconfig/gcc-10/lab-nxp/baseline-imx7ulp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b1f5c40a46ea7d148ace2d
        failing since 114 days (last pass: v5.10.153-cip19-rt8, first fail:=
 v5.10.175-cip29-rt12)

    2023-07-15T01:25:59.286084  + set +x
    2023-07-15T01:25:59.394140  / # #
    2023-07-15T01:26:00.550217  export SHELL=3D/bin/sh
    2023-07-15T01:26:00.555853  <8>[   28.979750] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-07-15T01:26:00.556170  <8>[   28.982045] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1236708_1.5.2.4.1>
    2023-07-15T01:26:00.556477  #
    2023-07-15T01:26:00.556768  / # export SHELL=3D/bin/sh
    2023-07-15T01:26:02.098968  / # . /lava-1236708/environment
    2023-07-15T01:26:04.916437  /lava-1236708/bin/lava-test-runner /lava-12=
36708/1
    2023-07-15T01:26:04.922422  . /lava-1236708/environment =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7ulp-evk                  | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64b1ee7d897726ba8a8ace1c

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7ulp-evk.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7ulp-evk.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b1ee7e897726ba8a8ace21
        failing since 114 days (last pass: v5.10.153-cip19-rt8, first fail:=
 v5.10.175-cip29-rt12)

    2023-07-15T00:54:58.991389  + set +x
    2023-07-15T00:54:59.111040  / # #
    2023-07-15T00:55:00.267018  export SHELL=3D/bin/sh
    2023-07-15T00:55:00.272673  <8>[   29.014360] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1236704_1.5.2.4.1>
    2023-07-15T00:55:00.272967  #
    2023-07-15T00:55:00.273205  / # export SHELL=3D/bin/sh
    2023-07-15T00:55:01.815087  / # . /lava-1236704/environment
    2023-07-15T00:55:04.632515  /lava-1236704/bin/lava-test-runner /lava-12=
36704/1
    2023-07-15T00:55:04.638509  . /lava-1236704/environment
    2023-07-15T00:55:04.638753  / # /lava-1236704/bin/lava-test-runner /lav=
a-1236704/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64b1edb08be7a5fe648ace2a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-iwg20=
d-q7.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-iwg20=
d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64b1edb08be7a5fe648ac=
e2b
        failing since 57 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v5.10.179-cip32-rt13) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 4          =


  Details:     https://kernelci.org/test/plan/id/64b1ee1e545559c8898ace3b

  Results:     60 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-=
veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-=
veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-i2c-present: https://kernelci.or=
g/test/case/id/64b1ee1e545559c8898ace69
        failing since 168 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-07-15T00:55:20.924633   INC default to 1.

    2023-07-15T00:55:20.924856  =


    2023-07-15T00:55:20.928333  	-w	Pad to last with leading zeros
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/64b1ee1e545559c8898ace6a
        failing since 168 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-07-15T00:55:20.906698  Usage: seq [-w] [-s SEP] [FIRST [INC]] LA<8=
>[   18.381119] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-07-15T00:55:20.906950  ST

    2023-07-15T00:55:20.907334  =


    2023-07-15T00:55:20.912102  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-07-15T00:55:20.922597  FIRST,<8>[   18.393783] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/64b1ee1e545559c8898ace6b
        failing since 168 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-07-15T00:55:20.890477  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC)<8=
>[   18.369076] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-probed=
 RESULT=3Dpass>

    2023-07-15T00:55:20.892347   multi-call binary.

    2023-07-15T00:55:20.892579  =

   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b1ee1e545559c8898ace7f
        failing since 168 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-07-15T00:55:08.942906  <8>[    6.421554] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcrit RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-07-15T00:55:08.943629  + set +x

    2023-07-15T00:55:09.048294  =


    2023-07-15T00:55:09.048546  / # <8>[    6.430459] <LAVA_SIGNAL_TESTCASE=
 TEST_CASE_ID=3Dalert RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-07-15T00:55:09.048767  <8>[    6.439433] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-07-15T00:55:09.049010  <8>[    6.442589] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11090594_1.5.2.3.1>

    2023-07-15T00:55:09.150384  #export SHELL=3D/bin/sh

    2023-07-15T00:55:09.151102  =


    2023-07-15T00:55:09.252530  / # export SHELL=3D/bin/sh. /lava-11090594/=
environment

    2023-07-15T00:55:09.253288  =

 =

    ... (21 line(s) more)  =

 =20

