Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99508C54E49
	for <webhook@archiver.kernel.org>; Sat,  2 Mar 2024 03:19:43 +0000 (UTC)
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
 by mx.groups.io with SMTP id smtpd.web11.42715.1709349578212331370
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 01 Mar 2024 19:19:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=c2Lfu0Qd;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.160.49, mailfrom: bot@kernelci.org)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-21fed501addso1414498fac.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 01 Mar 2024 19:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709349577; x=1709954377; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=azLLvvdJYabBL0eGjezxGkWaJD3F2mGFZi5nksGbrwI=;
        b=c2Lfu0QdWqUf6g6bjUQXV7IxafJL1oEzeeIDPc79qa6+7ihausbj16aa0xSG84pFhw
         3mGjulUt2DKx14aLWCC3hDQ1G3I1l43tncYrtRO22Ai8X9LUDKpMa/rDVgwLUWYs9PFu
         JS6/fBgFMrxYKB6Spid7wNJb4Qzm7nIdi9JHlJBpqeIrLXwZzr/gyjUa9Vin+GO52GAj
         lYPgrFp/TIjs6Kjyq2Si5ETeIwOboO90WVXgZwGMc+A7Nf/wr635EXCqAZfbxYN0Q1v1
         yzi2qpvViNaLMSfAwJJCnPVrrn104RLaRU/J/cxGLkujrV7GhF5v0htC3dGbgBX0fieb
         OjOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709349577; x=1709954377;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=azLLvvdJYabBL0eGjezxGkWaJD3F2mGFZi5nksGbrwI=;
        b=EfPyBkHk9dDHysX0H0P1GCbyQdIseUj2yngpPb7cfJ1nIJSng/v/ilJMcL+Wrtxc07
         GLDdxRCvOurv4VXHq/1PjVBhhPcZimXuOrklVzhYB3Q9M/AHHUN3Bsf/yEk7yy3xq1My
         f9ilunTdRDQoQmRiFGWW8/1zbUwyOFlqArKV1s8j1P73aVDx/V14xoR9Y1+BAm+rE66n
         z5RiBVW/y+h5kkk9CZtzXptQ81pEmq9jRlGXu4xNEapZjI5FC44zANPjwfTEciDau3GI
         E9Kg7vnFulCEVMpotJxpgzLvy94oy6xG8LvJGFSDRO4ELX9LjNCoh4wneeDbcCvhHBib
         C4mw==
X-Gm-Message-State: AOJu0YxGdlR54aRVJ2UmRovWTLkKfdM68L1LD5Ce+Zm1gqNgMzNprKCd
	MrFWAISyLNkxEwIsjOx7mupWoza78/DjpOsbl+pDBUH58lfAwcCrqpPDuVemta0P+KtJgplw5K0
	4qfM=
X-Google-Smtp-Source: AGHT+IHd3I6AwVRZ3HSSNqm/0n6V1Nls8Vs9F7hZ/UluSZCmK9k5m3D2O2XI6CsWxmZVTrKE+oxrJA==
X-Received: by 2002:a05:6870:2009:b0:220:c521:7e74 with SMTP id o9-20020a056870200900b00220c5217e74mr2805919oab.9.1709349576179;
        Fri, 01 Mar 2024 19:19:36 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id w17-20020a056a0014d100b006e58da8bb6asm2967243pfu.132.2024.03.01.19.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 19:19:35 -0800 (PST)
Message-ID: <65e29ac7.050a0220.9a2ad.fc70@mx.google.com>
Date: Fri, 01 Mar 2024 19:19:35 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip-rt
X-Kernelci-Kernel: v4.19.306-cip107-rt35
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip-rt baseline: 167 runs,
 37 regressions (v4.19.306-cip107-rt35)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 02 Mar 2024 03:19:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15159

cip/linux-4.19.y-cip-rt baseline: 167 runs, 37 regressions (v4.19.306-cip10=
7-rt35)

Regressions Summary
-------------------

platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora   | gcc-10   | defconfig=
+x86-board          | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...d+preempt_rt | 1          =

at91sam9g20ek             | arm    | lab-broonie     | gcc-10   | at91_dt_d=
efconfig            | 2          =

beaglebone-black          | arm    | lab-broonie     | gcc-10   | defconfig=
+preempt_rt         | 1          =

beaglebone-black          | arm    | lab-broonie     | gcc-10   | defconfig=
                    | 1          =

beaglebone-black          | arm    | lab-broonie     | gcc-10   | multi_v7_=
defc...g+preempt_rt | 1          =

beaglebone-black          | arm    | lab-broonie     | gcc-10   | multi_v7_=
defconfig           | 1          =

beaglebone-black          | arm    | lab-broonie     | gcc-10   | omap2plus=
_defconfig          | 1          =

dove-cubox                | arm    | lab-pengutronix | gcc-10   | mvebu_v7_=
defconfig           | 1          =

hp-x360-14-G1-sona        | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...d+preempt_rt | 1          =

imx6q-sabrelite           | arm    | lab-collabora   | gcc-10   | defconfig=
+preempt_rt         | 1          =

imx6q-sabrelite           | arm    | lab-collabora   | gcc-10   | defconfig=
                    | 1          =

imx6q-sabrelite           | arm    | lab-collabora   | gcc-10   | multi_v7_=
defc...g+preempt_rt | 1          =

imx6q-sabrelite           | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 1          =

imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | defconfig=
+preempt_rt         | 1          =

imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | defconfig=
                    | 1          =

imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | imx_v6_v7=
_defconfig          | 1          =

imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | multi_v7_=
defc...g+preempt_rt | 1          =

imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | multi_v7_=
defconfig           | 1          =

r8a7743-iwg20d-q7         | arm    | lab-cip         | gcc-10   | shmobile_=
defconfig           | 1          =

r8a7796-m3ulcb            | arm64  | lab-collabora   | gcc-10   | defconfig=
                    | 1          =

rk3288-veyron-jaq         | arm    | lab-collabora   | gcc-10   | defconfig=
+preempt_rt         | 3          =

rk3288-veyron-jaq         | arm    | lab-collabora   | gcc-10   | defconfig=
                    | 3          =

rk3288-veyron-jaq         | arm    | lab-collabora   | gcc-10   | multi_v7_=
defc...g+preempt_rt | 3          =

rk3288-veyron-jaq         | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 3          =

sun50i-a64-pine64-plus    | arm64  | lab-broonie     | gcc-10   | defconfig=
                    | 1          =

sun50i-h6-pine-h64        | arm64  | lab-collabora   | gcc-10   | defconfig=
                    | 1          =

zynqmp-zcu102             | arm64  | lab-cip         | gcc-10   | defconfig=
                    | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip-rt/ke=
rnel/v4.19.306-cip107-rt35/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.19.y-cip-rt
  Describe: v4.19.306-cip107-rt35
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      dcbd51e7744fcf9baa3ea87a028b574fda95d428 =



Test Regressions
---------------- =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora   | gcc-10   | defconfig=
+x86-board          | 1          =


  Details:     https://kernelci.org/test/plan/id/65e28dcc24b42cf93863701c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/x86_64/defconfig+x86-board/gcc-10/lab-collabora/baseline-as=
us-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/x86_64/defconfig+x86-board/gcc-10/lab-collabora/baseline-as=
us-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65e28dcc24b42cf938637=
01d
        new failure (last pass: v4.19.299-cip105-rt34) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...d+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/65e2884e4a420be32f637085

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/x86_64/x86_64_defconfig+x86-board+preempt_rt/gcc-10/lab-col=
labora/baseline-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/x86_64/x86_64_defconfig+x86-board+preempt_rt/gcc-10/lab-col=
labora/baseline-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65e2884e4a420be32f637=
086
        new failure (last pass: v4.19.299-cip105-rt34) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
at91sam9g20ek             | arm    | lab-broonie     | gcc-10   | at91_dt_d=
efconfig            | 2          =


  Details:     https://kernelci.org/test/plan/id/65e28780c1b8f2826a63702d

  Results:     42 PASS, 8 FAIL, 1 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm/at91_dt_defconfig/gcc-10/lab-broonie/baseline-at91sam9g=
20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm/at91_dt_defconfig/gcc-10/lab-broonie/baseline-at91sam9g=
20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/65e28780c=
1b8f2826a637038
        new failure (last pass: v4.19.299-cip105-rt34)

    2024-03-02T01:56:55.701461  /lava-652303/1/../bin/lava-test-case
    2024-03-02T01:56:55.735641  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dsou=
nd-card RESULT=3Dfail>   =


  * baseline.bootrr.audio-card-probed: https://kernelci.org/test/case/id/65=
e28780c1b8f2826a637039
        new failure (last pass: v4.19.299-cip105-rt34)

    2024-03-02T01:56:54.615515  /lava-652303/1/../bin/lava-test-case
    2024-03-02T01:56:54.650429  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Daud=
io-card-probed RESULT=3Dfail>   =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
beaglebone-black          | arm    | lab-broonie     | gcc-10   | defconfig=
+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/65e28cea866574468c63701a

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-beagle=
bone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-beagle=
bone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e28cea866574468c637045
        failing since 408 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2024-03-02T02:19:45.994570  <8>[   12.990699] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 652460_1.5.2.4.1>
    2024-03-02T02:19:46.106409  / # #
    2024-03-02T02:19:46.209653  export SHELL=3D/bin/sh
    2024-03-02T02:19:46.210613  #
    2024-03-02T02:19:46.312754  / # export SHELL=3D/bin/sh. /lava-652460/en=
vironment
    2024-03-02T02:19:46.313633  =

    2024-03-02T02:19:46.415667  / # . /lava-652460/environment/lava-652460/=
bin/lava-test-runner /lava-652460/1
    2024-03-02T02:19:46.417148  =

    2024-03-02T02:19:46.421171  / # /lava-652460/bin/lava-test-runner /lava=
-652460/1
    2024-03-02T02:19:46.502154  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
beaglebone-black          | arm    | lab-broonie     | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/65e290198b0f67c2cc637028

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm/defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm/defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e290198b0f67c2cc637053
        failing since 408 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2024-03-02T02:33:16.096973  <8>[   16.156560] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 652526_1.5.2.4.1>
    2024-03-02T02:33:16.205664  / # #
    2024-03-02T02:33:16.308304  export SHELL=3D/bin/sh
    2024-03-02T02:33:16.308841  #
    2024-03-02T02:33:16.410487  / # export SHELL=3D/bin/sh. /lava-652526/en=
vironment
    2024-03-02T02:33:16.411097  =

    2024-03-02T02:33:16.512427  / # . /lava-652526/environment/lava-652526/=
bin/lava-test-runner /lava-652526/1
    2024-03-02T02:33:16.512994  =

    2024-03-02T02:33:16.517319  / # /lava-652526/bin/lava-test-runner /lava=
-652526/1
    2024-03-02T02:33:16.584662  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
beaglebone-black          | arm    | lab-broonie     | gcc-10   | multi_v7_=
defc...g+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/65e28a7d6328d2072b63701b

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-broonie/baseli=
ne-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-broonie/baseli=
ne-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e28a7d6328d2072b637046
        failing since 408 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2024-03-02T02:09:23.089841  <8>[   15.792633] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 652429_1.5.2.4.1>
    2024-03-02T02:09:23.199280  / # #
    2024-03-02T02:09:23.301351  export SHELL=3D/bin/sh
    2024-03-02T02:09:23.301943  #
    2024-03-02T02:09:23.403373  / # export SHELL=3D/bin/sh. /lava-652429/en=
vironment
    2024-03-02T02:09:23.403946  =

    2024-03-02T02:09:23.505386  / # . /lava-652429/environment/lava-652429/=
bin/lava-test-runner /lava-652429/1
    2024-03-02T02:09:23.506336  =

    2024-03-02T02:09:23.510284  / # /lava-652429/bin/lava-test-runner /lava=
-652429/1
    2024-03-02T02:09:23.591845  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
beaglebone-black          | arm    | lab-broonie     | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65e28f42663259856763704f

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebo=
ne-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebo=
ne-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e28f42663259856763707a
        failing since 408 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2024-03-02T02:29:45.958124  <8>[   11.607603] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 652482_1.5.2.4.1>
    2024-03-02T02:29:46.068421  / # #
    2024-03-02T02:29:46.171437  export SHELL=3D/bin/sh
    2024-03-02T02:29:46.172358  #
    2024-03-02T02:29:46.172916  / # export SHELL=3D/bin/sh<6>[   11.816147]=
 usb 1-1: new low-speed USB device number 3 using musb-hdrc
    2024-03-02T02:29:46.275064  . /lava-652482/environment
    2024-03-02T02:29:46.276023  =

    2024-03-02T02:29:46.378143  / # . /lava-652482/environment/lava-652482/=
bin/lava-test-runner /lava-652482/1
    2024-03-02T02:29:46.379445  =

    2024-03-02T02:29:46.379908  / # <3>[   11.966151] usb 1-1: device descr=
iptor read/64, error -71 =

    ... (17 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
beaglebone-black          | arm    | lab-broonie     | gcc-10   | omap2plus=
_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/65e28f1b5d02835337637015

  Results:     41 PASS, 10 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beagleb=
one-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beagleb=
one-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e28f1b5d02835337637047
        new failure (last pass: v4.19.299-cip105-rt34)

    2024-03-02T02:29:26.198452  + set +x<8>[   16.605416] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 652472_1.5.2.4.1>
    2024-03-02T02:29:26.198580  =

    2024-03-02T02:29:26.307878  / # #
    2024-03-02T02:29:26.408999  export SHELL=3D/bin/sh
    2024-03-02T02:29:26.409222  #
    2024-03-02T02:29:26.510134  / # export SHELL=3D/bin/sh. /lava-652472/en=
vironment
    2024-03-02T02:29:26.510359  =

    2024-03-02T02:29:26.611304  / # . /lava-652472/environment/lava-652472/=
bin/lava-test-runner /lava-652472/1
    2024-03-02T02:29:26.611710  =

    2024-03-02T02:29:26.616589  / # /lava-652472/bin/lava-test-runner /lava=
-652472/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
dove-cubox                | arm    | lab-pengutronix | gcc-10   | mvebu_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65e28bc67031300ba363704c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: mvebu_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm/mvebu_v7_defconfig/gcc-10/lab-pengutronix/baseline-dove=
-cubox.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm/mvebu_v7_defconfig/gcc-10/lab-pengutronix/baseline-dove=
-cubox.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e28bc67031300ba3637051
        failing since 408 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2024-03-02T02:15:17.235218  + set +x
    2024-03-02T02:15:17.235367  [    4.303777] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1031293_1.5.2.3.1>
    2024-03-02T02:15:17.341346  / # #
    2024-03-02T02:15:17.442574  export SHELL=3D/bin/sh
    2024-03-02T02:15:17.443074  #
    2024-03-02T02:15:17.543917  / # export SHELL=3D/bin/sh. /lava-1031293/e=
nvironment
    2024-03-02T02:15:17.544399  =

    2024-03-02T02:15:17.645164  / # . /lava-1031293/environment/lava-103129=
3/bin/lava-test-runner /lava-1031293/1
    2024-03-02T02:15:17.645768  =

    2024-03-02T02:15:17.648254  / # /lava-1031293/bin/lava-test-runner /lav=
a-1031293/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
hp-x360-14-G1-sona        | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...d+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/65e288578c0122ce85637053

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/x86_64/x86_64_defconfig+x86-board+preempt_rt/gcc-10/lab-col=
labora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/x86_64/x86_64_defconfig+x86-board+preempt_rt/gcc-10/lab-col=
labora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65e288578c0122ce85637=
054
        new failure (last pass: v4.19.299-cip105-rt34) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6q-sabrelite           | arm    | lab-collabora   | gcc-10   | defconfig=
+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/65e28e8e9add74300f63701b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-imx6=
q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-imx6=
q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e28e8e9add74300f637020
        failing since 408 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2024-03-02T02:28:34.491520  / # #

    2024-03-02T02:28:34.593585  export SHELL=3D/bin/sh

    2024-03-02T02:28:34.594293  #

    2024-03-02T02:28:34.695724  / # export SHELL=3D/bin/sh. /lava-12912131/=
environment

    2024-03-02T02:28:34.696364  =


    2024-03-02T02:28:34.797791  / # . /lava-12912131/environment/lava-12912=
131/bin/lava-test-runner /lava-12912131/1

    2024-03-02T02:28:34.798852  =


    2024-03-02T02:28:34.800228  / # /lava-12912131/bin/lava-test-runner /la=
va-12912131/1

    2024-03-02T02:28:34.880182  + export 'TESTRUN_ID=3D1_bootrr'

    2024-03-02T02:28:34.916804  + cd /lava-12912131/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6q-sabrelite           | arm    | lab-collabora   | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/65e28fce90b6ea910f637067

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm/defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm/defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e28fce90b6ea910f63706c
        failing since 408 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2024-03-02T02:33:52.888576  / # #

    2024-03-02T02:33:52.990580  export SHELL=3D/bin/sh

    2024-03-02T02:33:52.991226  #

    2024-03-02T02:33:53.092523  / # export SHELL=3D/bin/sh. /lava-12912194/=
environment

    2024-03-02T02:33:53.093181  =


    2024-03-02T02:33:53.194569  / # . /lava-12912194/environment/lava-12912=
194/bin/lava-test-runner /lava-12912194/1

    2024-03-02T02:33:53.195551  =


    2024-03-02T02:33:53.197562  / # /lava-12912194/bin/lava-test-runner /la=
va-12912194/1

    2024-03-02T02:33:53.261530  + export 'TESTRUN_ID=3D1_bootrr'

    2024-03-02T02:33:53.313569  + cd /lava-12912194/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6q-sabrelite           | arm    | lab-collabora   | gcc-10   | multi_v7_=
defc...g+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/65e28e2a832d3c36b6637071

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-collabora/base=
line-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-collabora/base=
line-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e28e2a832d3c36b6637076
        failing since 408 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2024-03-02T02:26:54.456407  / # #

    2024-03-02T02:26:54.556876  export SHELL=3D/bin/sh

    2024-03-02T02:26:54.557045  #

    2024-03-02T02:26:54.657486  / # export SHELL=3D/bin/sh. /lava-12912056/=
environment

    2024-03-02T02:26:54.657590  =


    2024-03-02T02:26:54.758067  / # . /lava-12912056/environment/lava-12912=
056/bin/lava-test-runner /lava-12912056/1

    2024-03-02T02:26:54.758343  =


    2024-03-02T02:26:54.770319  / # /lava-12912056/bin/lava-test-runner /la=
va-12912056/1

    2024-03-02T02:26:54.834065  + export 'TESTRUN_ID=3D1_bootrr'

    2024-03-02T02:26:54.875923  + cd /lava-12912056/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6q-sabrelite           | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65e28ef2e63e641809637054

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-=
sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-=
sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e28ef2e63e641809637059
        failing since 408 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2024-03-02T02:30:13.328786  / # #

    2024-03-02T02:30:13.430672  export SHELL=3D/bin/sh

    2024-03-02T02:30:13.431269  #

    2024-03-02T02:30:13.532546  / # export SHELL=3D/bin/sh. /lava-12912181/=
environment

    2024-03-02T02:30:13.533145  =


    2024-03-02T02:30:13.634449  / # . /lava-12912181/environment/lava-12912=
181/bin/lava-test-runner /lava-12912181/1

    2024-03-02T02:30:13.635326  =


    2024-03-02T02:30:13.637476  / # /lava-12912181/bin/lava-test-runner /la=
va-12912181/1

    2024-03-02T02:30:13.758189  + export 'TESTRUN_ID=3D1_bootrr'

    2024-03-02T02:30:13.758699  + cd /lava-12912181/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | defconfig=
+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/65e28cb80de327c3dd6370a3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm/defconfig+preempt_rt/gcc-10/lab-pengutronix/baseline-im=
x6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm/defconfig+preempt_rt/gcc-10/lab-pengutronix/baseline-im=
x6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e28cb80de327c3dd6370a8
        failing since 408 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2024-03-02T02:19:25.674674  + set +x
    2024-03-02T02:19:25.674833  [    6.866933] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1031295_1.5.2.3.1>
    2024-03-02T02:19:25.780419  / # #
    2024-03-02T02:19:25.881640  export SHELL=3D/bin/sh
    2024-03-02T02:19:25.882097  #
    2024-03-02T02:19:25.982849  / # export SHELL=3D/bin/sh. /lava-1031295/e=
nvironment
    2024-03-02T02:19:25.983317  =

    2024-03-02T02:19:26.084263  / # . /lava-1031295/environment/lava-103129=
5/bin/lava-test-runner /lava-1031295/1
    2024-03-02T02:19:26.084947  =

    2024-03-02T02:19:26.087373  / # /lava-1031295/bin/lava-test-runner /lav=
a-1031295/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/65e28fb028604f5d4d637061

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm/defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandbo=
ard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm/defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandbo=
ard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e28fb028604f5d4d637066
        failing since 408 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2024-03-02T02:32:03.481862  + set +x
    2024-03-02T02:32:03.482013  [    4.949959] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1031310_1.5.2.3.1>
    2024-03-02T02:32:03.587657  / # #
    2024-03-02T02:32:03.689187  export SHELL=3D/bin/sh
    2024-03-02T02:32:03.689654  #
    2024-03-02T02:32:03.790437  / # export SHELL=3D/bin/sh. /lava-1031310/e=
nvironment
    2024-03-02T02:32:03.791094  =

    2024-03-02T02:32:03.892041  / # . /lava-1031310/environment/lava-103131=
0/bin/lava-test-runner /lava-1031310/1
    2024-03-02T02:32:03.892643  =

    2024-03-02T02:32:03.895181  / # /lava-1031310/bin/lava-test-runner /lav=
a-1031310/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | imx_v6_v7=
_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/65e28d0702e1f9e05363705c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx=
6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx=
6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e28d0702e1f9e053637061
        failing since 408 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2024-03-02T02:20:43.844674  + set +x
    2024-03-02T02:20:43.844841  [    7.311199] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1031301_1.5.2.3.1>
    2024-03-02T02:20:43.952149  / # #
    2024-03-02T02:20:44.053313  export SHELL=3D/bin/sh
    2024-03-02T02:20:44.053749  #
    2024-03-02T02:20:44.154610  / # export SHELL=3D/bin/sh. /lava-1031301/e=
nvironment
    2024-03-02T02:20:44.155149  =

    2024-03-02T02:20:44.255988  / # . /lava-1031301/environment/lava-103130=
1/bin/lava-test-runner /lava-1031301/1
    2024-03-02T02:20:44.256560  =

    2024-03-02T02:20:44.259386  / # /lava-1031301/bin/lava-test-runner /lav=
a-1031301/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | multi_v7_=
defc...g+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/65e289c0d9e812f9ff637016

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-pengutronix/ba=
seline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-pengutronix/ba=
seline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e289c0d9e812f9ff63701b
        failing since 408 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2024-03-02T02:06:48.748481  + set +x
    2024-03-02T02:06:48.748779  [    6.959991] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1031291_1.5.2.3.1>
    2024-03-02T02:06:48.854586  / # #
    2024-03-02T02:06:48.955841  export SHELL=3D/bin/sh
    2024-03-02T02:06:48.956314  #
    2024-03-02T02:06:49.057199  / # export SHELL=3D/bin/sh. /lava-1031291/e=
nvironment
    2024-03-02T02:06:49.057700  =

    2024-03-02T02:06:49.158586  / # . /lava-1031291/environment/lava-103129=
1/bin/lava-test-runner /lava-1031291/1
    2024-03-02T02:06:49.159190  =

    2024-03-02T02:06:49.161955  / # /lava-1031291/bin/lava-test-runner /lav=
a-1031291/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65e28ed48aad5e1e5c63708e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6=
qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6=
qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e28ed48aad5e1e5c637093
        failing since 408 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2024-03-02T02:28:22.203426  + set +x
    2024-03-02T02:28:22.203563  [    4.799644] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1031305_1.5.2.3.1>
    2024-03-02T02:28:22.309483  / # #
    2024-03-02T02:28:22.410671  export SHELL=3D/bin/sh
    2024-03-02T02:28:22.411115  #
    2024-03-02T02:28:22.511958  / # export SHELL=3D/bin/sh. /lava-1031305/e=
nvironment
    2024-03-02T02:28:22.512366  =

    2024-03-02T02:28:22.613121  / # . /lava-1031305/environment/lava-103130=
5/bin/lava-test-runner /lava-1031305/1
    2024-03-02T02:28:22.613749  =

    2024-03-02T02:28:22.616572  / # /lava-1031305/bin/lava-test-runner /lav=
a-1031305/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
r8a7743-iwg20d-q7         | arm    | lab-cip         | gcc-10   | shmobile_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65e28bba7031300ba3637049

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-iwg2=
0d-q7.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-iwg2=
0d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65e28bba7031300ba3637=
04a
        failing since 62 days (last pass: v4.19.295-cip103-rt33, first fail=
: v4.19.299-cip105-rt34) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
r8a7796-m3ulcb            | arm64  | lab-collabora   | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/65e28ed08ba8dd32f0637029

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a7796-m3ulc=
b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a7796-m3ulc=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e28ed08ba8dd32f063702e
        failing since 408 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2024-03-02T02:39:21.506622  / # #

    2024-03-02T02:39:21.608736  export SHELL=3D/bin/sh

    2024-03-02T02:39:21.609422  #

    2024-03-02T02:39:21.710724  / # export SHELL=3D/bin/sh. /lava-12912178/=
environment

    2024-03-02T02:39:21.711489  =


    2024-03-02T02:39:21.812807  / # . /lava-12912178/environment/lava-12912=
178/bin/lava-test-runner /lava-12912178/1

    2024-03-02T02:39:21.814061  =


    2024-03-02T02:39:21.815020  / # /lava-12912178/bin/lava-test-runner /la=
va-12912178/1

    2024-03-02T02:39:21.879346  + export 'TESTRUN_ID=3D1_bootrr'

    2024-03-02T02:39:21.879854  + cd /lav<8>[   12.966480] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12912178_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
rk3288-veyron-jaq         | arm    | lab-collabora   | gcc-10   | defconfig=
+preempt_rt         | 3          =


  Details:     https://kernelci.org/test/plan/id/65e28cc66d79c5e67e637055

  Results:     61 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-rk32=
88-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-rk32=
88-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/65e28cc66d79c5e67e637085
        failing since 406 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2024-03-02T02:30:24.078425  <8>[   10.277800] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-driver-audio-present RESULT=3Dfail>

    2024-03-02T02:30:24.078475  =


    2024-03-02T02:30:24.082714  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2024-03-02T02:30:24.083188  =


    2024-03-02T02:30:24.088619  Print numbers from FIRST to LAST, in steps =
of INC.

    2024-03-02T02:30:24.090505  FIRST, INC default to 1.

    2024-03-02T02:30:24.090959  =

   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/65e28cc66d79c5e67e637086
        failing since 406 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2024-03-02T02:30:24.056762  /lava-12912137/1/../bin/lava-test-case<8>[ =
  10.259325] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-probed RE=
SULT=3Dpass>

    2024-03-02T02:30:24.056812  =


    2024-03-02T02:30:24.068277  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e28cc66d79c5e67e637099
        failing since 406 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2024-03-02T02:30:20.192713  <8>[    6.394614] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2024-03-02T02:30:20.202439  + <8>[    6.407135] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 12912137_1.5.2.3.1>

    2024-03-02T02:30:20.202899  set +x

    2024-03-02T02:30:20.308855  =


    2024-03-02T02:30:20.410307  / # #export SHELL=3D/bin/sh

    2024-03-02T02:30:20.410989  =


    2024-03-02T02:30:20.512412  / # export SHELL=3D/bin/sh. /lava-12912137/=
environment

    2024-03-02T02:30:20.513107  =


    2024-03-02T02:30:20.614500  / # . /lava-12912137/environment/lava-12912=
137/bin/lava-test-runner /lava-12912137/1

    2024-03-02T02:30:20.615684  =

 =

    ... (16 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
rk3288-veyron-jaq         | arm    | lab-collabora   | gcc-10   | defconfig=
                    | 3          =


  Details:     https://kernelci.org/test/plan/id/65e28fc090b6ea910f637013

  Results:     61 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm/defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-j=
aq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm/defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-j=
aq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/65e28fc090b6ea910f637043
        failing since 406 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2024-03-02T02:43:08.119787   multi-call binary.

    2024-03-02T02:43:08.119847  =


    2024-03-02T02:43:08.124329  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2024-03-02T02:43:08.124549  =


    2024-03-02T02:43:08.129595  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/65e28fc090b6ea910f637044
        failing since 406 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2024-03-02T02:43:08.098938  <8>[   10.855384] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>

    2024-03-02T02:43:08.117672  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC)<8=
>[   10.873008] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e28fc090b6ea910f637057
        failing since 406 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2024-03-02T02:43:04.266835  <8>[    7.023230] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2024-03-02T02:43:04.276148  + <8>[    7.035485] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 12912195_1.5.2.3.1>

    2024-03-02T02:43:04.276533  set +x

    2024-03-02T02:43:04.382581  =


    2024-03-02T02:43:04.484122  / # #export SHELL=3D/bin/sh

    2024-03-02T02:43:04.484813  =


    2024-03-02T02:43:04.586159  / # export SHELL=3D/bin/sh. /lava-12912195/=
environment

    2024-03-02T02:43:04.586848  =


    2024-03-02T02:43:04.688152  / # . /lava-12912195/environment/lava-12912=
195/bin/lava-test-runner /lava-12912195/1

    2024-03-02T02:43:04.689172  =

 =

    ... (17 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
rk3288-veyron-jaq         | arm    | lab-collabora   | gcc-10   | multi_v7_=
defc...g+preempt_rt | 3          =


  Details:     https://kernelci.org/test/plan/id/65e289d0bdd99ec5dd637032

  Results:     61 PASS, 8 FAIL, 1 SKIP
  Full config: multi_v7_defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-collabora/base=
line-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-collabora/base=
line-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/65e289d0bdd99ec5dd637062
        failing since 406 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2024-03-02T02:17:47.211809  <8>[   12.254663] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-driver-audio-present RESULT=3Dfail>

    2024-03-02T02:17:47.212025  =


    2024-03-02T02:17:47.216425  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2024-03-02T02:17:47.216478  =


    2024-03-02T02:17:47.221479  Print numbers from FIRST to LAST, in steps =
of INC.

    2024-03-02T02:17:47.224093  FIRST, INC default to 1.

    2024-03-02T02:17:47.224310  =

   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/65e289d0bdd99ec5dd637063
        failing since 406 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2024-03-02T02:17:47.190105  <8>[   12.236162] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>

    2024-03-02T02:17:47.201673  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e289d0bdd99ec5dd637076
        failing since 406 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2024-03-02T02:17:43.336395  + <8>[    8.384670] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 12912064_1.5.2.3.1>

    2024-03-02T02:17:43.336959  set +x

    2024-03-02T02:17:43.443092  =


    2024-03-02T02:17:43.544726  / # #export SHELL=3D/bin/sh

    2024-03-02T02:17:43.545481  =


    2024-03-02T02:17:43.646897  / # export SHELL=3D/bin/sh. /lava-12912064/=
environment

    2024-03-02T02:17:43.647629  =


    2024-03-02T02:17:43.749003  / # . /lava-12912064/environment/lava-12912=
064/bin/lava-test-runner /lava-12912064/1

    2024-03-02T02:17:43.750243  =


    2024-03-02T02:17:43.751564  / # /lava-12912064/bin/lava-test-runner /la=
va-12912064/1
 =

    ... (16 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
rk3288-veyron-jaq         | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 3          =


  Details:     https://kernelci.org/test/plan/id/65e28ece8aad5e1e5c63701f

  Results:     61 PASS, 8 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288=
-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288=
-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/65e28ece8aad5e1e5c63704f
        failing since 406 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2024-03-02T02:39:06.505833  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC)<8=
>[   10.576120] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2024-03-02T02:39:06.507511   multi-call binary.

    2024-03-02T02:39:06.508479  =


    2024-03-02T02:39:06.512554  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2024-03-02T02:39:06.512619  =


    2024-03-02T02:39:06.517600  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/65e28ece8aad5e1e5c637050
        failing since 406 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28) =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e28ece8aad5e1e5c637063
        failing since 406 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2024-03-02T02:39:02.660477  <8>[    6.732339] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2024-03-02T02:39:02.670290  + <8>[    6.744504] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 12912169_1.5.2.3.1>

    2024-03-02T02:39:02.670523  set +x

    2024-03-02T02:39:02.775771  / #

    2024-03-02T02:39:02.876441  # #export SHELL=3D/bin/sh

    2024-03-02T02:39:02.876564  =


    2024-03-02T02:39:02.976985  / # export SHELL=3D/bin/sh. /lava-12912169/=
environment

    2024-03-02T02:39:02.977085  =


    2024-03-02T02:39:03.077609  / # . /lava-12912169/environment/lava-12912=
169/bin/lava-test-runner /lava-12912169/1

    2024-03-02T02:39:03.077801  =

 =

    ... (18 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
sun50i-a64-pine64-plus    | arm64  | lab-broonie     | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/65e28ef3e63e64180963705f

  Results:     23 PASS, 16 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine=
64-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine=
64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e28ef3e63e641809637085
        failing since 408 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2024-03-02T02:28:36.993989  <8>[   15.929831] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 652485_1.5.2.4.1>
    2024-03-02T02:28:37.098477  / # #
    2024-03-02T02:28:37.200002  export SHELL=3D/bin/sh
    2024-03-02T02:28:37.200454  #
    2024-03-02T02:28:37.301950  / # export SHELL=3D/bin/sh. /lava-652485/en=
vironment
    2024-03-02T02:28:37.302337  =

    2024-03-02T02:28:37.403673  / # . /lava-652485/environment/lava-652485/=
bin/lava-test-runner /lava-652485/1
    2024-03-02T02:28:37.404361  =

    2024-03-02T02:28:37.408491  / # /lava-652485/bin/lava-test-runner /lava=
-652485/1
    2024-03-02T02:28:37.438438  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
sun50i-h6-pine-h64        | arm64  | lab-collabora   | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/65e28ed28aad5e1e5c637080

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e28ed28aad5e1e5c637085
        failing since 408 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2024-03-02T02:39:22.635644  / # #

    2024-03-02T02:39:22.737436  export SHELL=3D/bin/sh

    2024-03-02T02:39:22.738148  #

    2024-03-02T02:39:22.839366  / # export SHELL=3D/bin/sh. /lava-12912186/=
environment

    2024-03-02T02:39:22.840074  =


    2024-03-02T02:39:22.941304  / # . /lava-12912186/environment/lava-12912=
186/bin/lava-test-runner /lava-12912186/1

    2024-03-02T02:39:22.942359  =


    2024-03-02T02:39:22.943791  / # /lava-12912186/bin/lava-test-runner /la=
va-12912186/1

    2024-03-02T02:39:23.015680  + export 'TESTRUN_ID=3D1_bootrr'

    2024-03-02T02:39:23.016175  + cd /lava-1291218<8>[   15.613050] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12912186_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
zynqmp-zcu102             | arm64  | lab-cip         | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/65e28ecb8ba8dd32f063701a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm64/defconfig/gcc-10/lab-cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm64/defconfig/gcc-10/lab-cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e28ecb8ba8dd32f063701f
        failing since 408 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2024-03-02T02:28:13.659309  + set +x
    2024-03-02T02:28:13.662484  <8>[    3.749310] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1101592_1.5.2.4.1>
    2024-03-02T02:28:13.766773  / # #
    2024-03-02T02:28:13.868175  export SHELL=3D/bin/sh
    2024-03-02T02:28:13.868744  #
    2024-03-02T02:28:13.969803  / # export SHELL=3D/bin/sh. /lava-1101592/e=
nvironment
    2024-03-02T02:28:13.970297  =

    2024-03-02T02:28:14.071223  / # . /lava-1101592/environment/lava-110159=
2/bin/lava-test-runner /lava-1101592/1
    2024-03-02T02:28:14.071953  =

    2024-03-02T02:28:14.076426  / # /lava-1101592/bin/lava-test-runner /lav=
a-1101592/1 =

    ... (13 line(s) more)  =

 =20

