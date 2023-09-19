Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9027FCE79A9
	for <webhook@archiver.kernel.org>; Tue, 19 Sep 2023 23:12:15 +0000 (UTC)
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
 by mx.groups.io with SMTP id smtpd.web10.24704.1695165127103379185
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 19 Sep 2023 16:12:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=oAgAecwL;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.161.47, mailfrom: bot@kernelci.org)
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-578d992c8efso3510290eaf.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 19 Sep 2023 16:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695165126; x=1695769926; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BGGUSxQthjtcVcPM4adKm6dqUukZgAUZ62W3rq3xSsk=;
        b=oAgAecwLfZwzbisvkJb/bzsmeB34kD0DV16sPda862mWw004ce5uHrOK+Gq8KG2Mn7
         ZUKp6oSyZTy4Fo0icIkbJFhZ2xhnTazOpCveZup6AqyVW5FZrfMOPXsR//9zxoG3yMcO
         m5fcXxhR6Yw5PINPK5lk1dNWkHrZAF9HhgYjtuZG/Y6TyZU2TtLRZsCikcGlX/HhBKiQ
         3YWQtFKwz2EwfIlgnBNZvnkzZoa5Tn30yyl8RPD0nDmjQ/sZ93hZUpYdX1467wA9LbJw
         pHKIdq6xcHS0KNUhLvqBMRipPVsPg3AWBbIpQHvYgyCQu+q9TUb3ybtKLhOmf5Z7cuoM
         F6GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695165126; x=1695769926;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BGGUSxQthjtcVcPM4adKm6dqUukZgAUZ62W3rq3xSsk=;
        b=XDdQQ/cbP7a3NH0CfR0URYjVI2UE/3FGN+4IJILkZcEiWHnlLL/Gb1SnM7FbKF+zdN
         bIPkHEJH0l8YyHJR2DhUR1uUyeOYdYmYeLgwOMxt/RakoHMMWkqmtKrCTqZGFDVvvzb6
         4xJRmcYmeyrmEAa30gOs402g4uaCSBf2frKG6II4S7sbg+3AdvdrphJeMKGGdJ7v6qKN
         PtXoEfoc9skN3gkTGEESMwM8z7jhhrQIaajSfwF2Lz+fYp1PIX1WCpYP4Iis2aLaf14M
         wwMHIAN0hD+kTBY8+Fblhw/bmA0PpW8lRRWZgjcnbbHtdwkdV4Pg8Uh4jQObFvQW6iJu
         gNAA==
X-Gm-Message-State: AOJu0Yzeu8ejOra5U6d6cGEldlZswLUnY1m6nqzEPMPBHhgXiDA8x9om
	AaWUwdSXr8lUSgFxoFBprZu5gVWX3r77fesQ2NTbrg==
X-Google-Smtp-Source: AGHT+IG0N/zbI77mh6NfoUBBYwJB62iQHyUOZOq7B89SXLsiRWcLonJg61RC45myL36ayt00WESDUw==
X-Received: by 2002:a05:6870:a691:b0:1bf:df47:7b5e with SMTP id i17-20020a056870a69100b001bfdf477b5emr1030726oam.16.1695165125173;
        Tue, 19 Sep 2023 16:12:05 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id r11-20020a62e40b000000b006879493aca0sm9028911pfh.26.2023.09.19.16.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 16:12:04 -0700 (PDT)
Message-ID: <650a2ac4.620a0220.a63d0.019f@mx.google.com>
Date: Tue, 19 Sep 2023 16:12:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.194-cip39-rt16
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip-rt baseline: 187 runs,
 32 regressions (v5.10.194-cip39-rt16)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 19 Sep 2023 23:12:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13169

cip/linux-5.10.y-cip-rt baseline: 187 runs, 32 regressions (v5.10.194-cip39=
-rt16)

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

bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | bcm283=
5_defconfig            | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | defcon=
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

juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig+preempt_rt         | 1          =

r8a77960-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig+preempt_rt         | 1          =

r8a77960-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 4          =

rk3399-rock-pi-4b            | arm64  | lab-collabora   | gcc-10   | defcon=
fig+preempt_rt         | 1          =

rk3399-rock-pi-4b            | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.194-cip39-rt16/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.194-cip39-rt16
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      7aa1fa8ed3b5d0130443043c96b985082bf55241 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | defcon=
fig+x86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/650a1d319b190551258a0a75

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650a1d319b190551258a0a7e
        failing since 235 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-09-19T22:13:47.798685  + set +x

    2023-09-19T22:13:47.804956  <8>[    9.723007] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11574710_1.4.2.3.1>

    2023-09-19T22:13:47.913150  / ##

    2023-09-19T22:13:48.015818  export SHELL=3D/bin/sh

    2023-09-19T22:13:48.016564   #

    2023-09-19T22:13:48.118235  / # export SHELL=3D/bin/sh. /lava-11574710/=
environment

    2023-09-19T22:13:48.119024  =


    2023-09-19T22:13:48.220833  / # . /lava-11574710/environment/lava-11574=
710/bin/lava-test-runner /lava-11574710/1

    2023-09-19T22:13:48.222262  =


    2023-09-19T22:13:48.227785  / # /lava-11574710/bin/lava-test-runner /la=
va-11574710/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/650a1e5b692cdc98568a0a4d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650a1e5b692cdc98568a0a56
        failing since 235 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-09-19T22:18:47.639894  + set +x

    2023-09-19T22:18:47.646250  <8>[    8.620239] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11574763_1.4.2.3.1>

    2023-09-19T22:18:47.754296  #

    2023-09-19T22:18:47.755678  =


    2023-09-19T22:18:47.857628  / # #export SHELL=3D/bin/sh

    2023-09-19T22:18:47.858495  =


    2023-09-19T22:18:47.960082  / # export SHELL=3D/bin/sh. /lava-11574763/=
environment

    2023-09-19T22:18:47.960870  =


    2023-09-19T22:18:48.062466  / # . /lava-11574763/environment/lava-11574=
763/bin/lava-test-runner /lava-11574763/1

    2023-09-19T22:18:48.063758  =

 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora   | gcc-10   | defcon=
fig+x86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/650a1e05758552759a8a0a53

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650a1e05758552759a8a0a5c
        failing since 235 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-09-19T22:18:50.230142  + set +x

    2023-09-19T22:18:50.236723  <8>[    7.696925] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11574703_1.4.2.3.1>

    2023-09-19T22:18:50.338522  =


    2023-09-19T22:18:50.439113  / # #export SHELL=3D/bin/sh

    2023-09-19T22:18:50.439304  =


    2023-09-19T22:18:50.539895  / # export SHELL=3D/bin/sh. /lava-11574703/=
environment

    2023-09-19T22:18:50.540053  =


    2023-09-19T22:18:50.640545  / # . /lava-11574703/environment/lava-11574=
703/bin/lava-test-runner /lava-11574703/1

    2023-09-19T22:18:50.640790  =


    2023-09-19T22:18:50.645963  / # /lava-11574703/bin/lava-test-runner /la=
va-11574703/1
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/650a1e56692cdc98568a0a42

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650a1e56692cdc98568a0a4b
        failing since 235 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-09-19T22:20:11.004642  + set +x

    2023-09-19T22:20:11.011559  <8>[    8.119348] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11574762_1.4.2.3.1>

    2023-09-19T22:20:11.113130  #

    2023-09-19T22:20:11.213853  / # #export SHELL=3D/bin/sh

    2023-09-19T22:20:11.214019  =


    2023-09-19T22:20:11.314505  / # export SHELL=3D/bin/sh. /lava-11574762/=
environment

    2023-09-19T22:20:11.314683  =


    2023-09-19T22:20:11.415191  / # . /lava-11574762/environment/lava-11574=
762/bin/lava-test-runner /lava-11574762/1

    2023-09-19T22:20:11.415478  =


    2023-09-19T22:20:11.417453  / # /lava-11574762/bin/lava-test-runner /la=
va-11574762/1<4>[    8.524796] i2c_designware i2c_designware.5: timeout in =
disabling adapter
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | bcm283=
5_defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/650a1f0ee4f7986faa8a0a5d

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm/bcm2835_defconfig/gcc-10/lab-collabora/baseline-bcm2836-=
rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm/bcm2835_defconfig/gcc-10/lab-collabora/baseline-bcm2836-=
rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650a1f0ee4f7986faa8a0a65
        new failure (last pass: v5.10.184-cip36-rt14)

    2023-09-19T22:26:08.583439  + set +x

    2023-09-19T22:26:08.583662  <8>[   13.545790] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-09-19T22:26:08.583725  / # <8>[   13.548080] <LAVA_SIGNAL_ENDRUN 0=
_dmesg 11574767_1.5.2.4.1>

    2023-09-19T22:26:08.684854  #

    2023-09-19T22:26:08.785416  export SHELL=3D/bin/sh

    2023-09-19T22:26:08.785550  #

    2023-09-19T22:26:08.886095  / # export SHELL=3D/bin/sh. /lava-11574767/=
environment

    2023-09-19T22:26:08.886241  =


    2023-09-19T22:26:08.986769  / # . /lava-11574767/environment/lava-11574=
767/bin/lava-test-runner /lava-11574767/1

    2023-09-19T22:26:08.986965  =

 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/650a21e053f0b333b88a0a5f

  Results:     30 PASS, 14 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm/defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm/defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650a21e053f0b333b88a0a8b
        failing since 235 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-09-19T22:33:39.034577  + set +x
    2023-09-19T22:33:39.140377  / # <8>[   22.816854] <LAVA_S#
    2023-09-19T22:33:39.243557  export SHELL=3D/bin/sh
    2023-09-19T22:33:39.244260  IGNAL_TESTCASE TEST_CASE_ID=3Demerg RESULT=
=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-09-19T22:33:39.244738  <8>[   22.818828] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 119044_1.5.2.4.1>
    2023-09-19T22:33:39.244935  #
    2023-09-19T22:33:39.347039  / # export SHELL=3D/bin/sh. /lava-119044/en=
vironment
    2023-09-19T22:33:39.347744  =

    2023-09-19T22:33:39.449938  / # . /lava-119044/environment/lava-119044/=
bin/lava-test-runner /lava-119044/1
    2023-09-19T22:33:39.451101   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/650a22cb849ce47c808a0a43

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm/defconfig/gcc-10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm/defconfig/gcc-10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650a22cb849ce47c808a0a4a
        failing since 235 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-09-19T22:37:34.988227  <8>[   15.744953] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1010674_1.5.2.4.1>
    2023-09-19T22:37:35.096516  / # #
    2023-09-19T22:37:35.198804  export SHELL=3D/bin/sh
    2023-09-19T22:37:35.199516  #
    2023-09-19T22:37:35.301278  / # export SHELL=3D/bin/sh. /lava-1010674/e=
nvironment
    2023-09-19T22:37:35.301988  =

    2023-09-19T22:37:35.403774  / # . /lava-1010674/environment/lava-101067=
4/bin/lava-test-runner /lava-1010674/1
    2023-09-19T22:37:35.404366  =

    2023-09-19T22:37:35.411370  / # /lava-1010674/bin/lava-test-runner /lav=
a-1010674/1
    2023-09-19T22:37:35.504381  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/650a1fda20ba73bf9c8a0a43

  Results:     30 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebon=
e-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebon=
e-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650a1fdb20ba73bf9c8a0a73
        failing since 235 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-09-19T22:24:43.790606  + set +x
    2023-09-19T22:24:43.897205  TESTCASE TEST_CASE_ID=3Demerg RESULT=3Dpass=
 UNITS=3Dlines MEASUREMENT=3D0>
    2023-09-19T22:24:43.897541  =

    2023-09-19T22:24:43.897742  / # <8>[   21.934467] <LAVA_SIGNAL_ENDRUN 0=
_dmesg 118999_1.5.2.4.1>
    2023-09-19T22:24:43.999507  #export SHELL=3D/bin/sh
    2023-09-19T22:24:43.999954  =

    2023-09-19T22:24:44.101364  / # export SHELL=3D/bin/sh. /lava-118999/en=
vironment
    2023-09-19T22:24:44.101807  =

    2023-09-19T22:24:44.203284  / # . /lava-118999/environment/lava-118999/=
bin/lava-test-runner /lava-118999/1
    2023-09-19T22:24:44.204499   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/650a20b661439f914e8a0a55

  Results:     30 PASS, 14 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beaglebone-bl=
ack.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beaglebone-bl=
ack.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650a20b661439f914e8a0a5b
        failing since 235 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-09-19T22:28:22.199186  + set +x
    2023-09-19T22:28:22.307545  / # #
    2023-09-19T22:28:22.409438  export SHELL=3D/bin/sh
    2023-09-19T22:28:22.409923  <8>[   16.626964] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-09-19T22:28:22.410218  <8>[   16.628785] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1010660_1.5.2.4.1>
    2023-09-19T22:28:22.410484  #
    2023-09-19T22:28:22.511848  / # export SHELL=3D/bin/sh. /lava-1010660/e=
nvironment
    2023-09-19T22:28:22.512330  =

    2023-09-19T22:28:22.613751  / # . /lava-1010660/environment/lava-101066=
0/bin/lava-test-runner /lava-1010660/1
    2023-09-19T22:28:22.614574   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/650a1fd3ad06e56c908a0b6b

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beaglebo=
ne-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beaglebo=
ne-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650a1fd3ad06e56c908a0b99
        failing since 181 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.175-cip29-rt12)

    2023-09-19T22:25:09.027686  <8>[   19.093281] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 119010_1.5.2.4.1>
    2023-09-19T22:25:09.136956  / # #
    2023-09-19T22:25:09.239987  export SHELL=3D/bin/sh
    2023-09-19T22:25:09.240898  #
    2023-09-19T22:25:09.342978  / # export SHELL=3D/bin/sh. /lava-119010/en=
vironment
    2023-09-19T22:25:09.343888  =

    2023-09-19T22:25:09.446091  / # . /lava-119010/environment/lava-119010/=
bin/lava-test-runner /lava-119010/1
    2023-09-19T22:25:09.447519  =

    2023-09-19T22:25:09.451891  / # /lava-119010/bin/lava-test-runner /lava=
-119010/1
    2023-09-19T22:25:09.559577  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/650a223f8b19384b128a0a7f

  Results:     50 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beaglebone-b=
lack.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beaglebone-b=
lack.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650a223f8b19384b128a0a85
        failing since 181 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.175-cip29-rt12)

    2023-09-19T22:35:31.508106  + set +x
    2023-09-19T22:35:31.615666  TESTCASE TEST_CASE_ID=3Demerg RESULT=3Dpass=
 UNITS=3Dlines MEASUREMENT=3D0>
    2023-09-19T22:35:31.616111  =

    2023-09-19T22:35:31.616534  / # <8>[   13.370647] <LAVA_SIGNAL_ENDRUN 0=
_dmesg 1010665_1.5.2.4.1>
    2023-09-19T22:35:31.718864  #export SHELL=3D/bin/sh
    2023-09-19T22:35:31.719583  =

    2023-09-19T22:35:31.821461  / # export SHELL=3D/bin/sh. /lava-1010665/e=
nvironment
    2023-09-19T22:35:31.822171  =

    2023-09-19T22:35:31.924018  / # . /lava-1010665/environment/lava-101066=
5/bin/lava-test-runner /lava-1010665/1
    2023-09-19T22:35:31.925253   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls1028a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/650a20fb722577ee838a0a54

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1028a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1028a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650a20fb722577ee838a0a5b
        failing since 181 days (last pass: v5.10.153-cip19-rt8, first fail:=
 v5.10.175-cip29-rt12)

    2023-09-19T22:30:04.900176  / # [   23.668224] <LAVA#
    2023-09-19T22:30:05.001669  export SHELL=3D/bin/sh
    2023-09-19T22:30:05.002114  _SIGNAL_ENDRUN 0_dmesg 1252267_1.5.2.4.1>
    2023-09-19T22:30:05.002363  #
    2023-09-19T22:30:05.103344  / # export SHELL=3D/bin/sh. /lava-1252267/e=
nvironment
    2023-09-19T22:30:05.103799  =

    2023-09-19T22:30:05.204789  / # . /lava-1252267/environment/lava-125226=
7/bin/lava-test-runner /lava-1252267/1
    2023-09-19T22:30:05.205540  =

    2023-09-19T22:30:05.209579  / # /lava-1252267/bin/lava-test-runner /lav=
a-1252267/1
    2023-09-19T22:30:05.227957  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | defcon=
fig+x86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/650a1ef6e4f7986faa8a0a43

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650a1ef6e4f7986faa8a0a4c
        failing since 123 days (last pass: v5.10.175-cip29-rt12, first fail=
: v5.10.179-cip32-rt13)

    2023-09-19T22:21:46.639083  [   12.648977] <LAVA_SIGNAL_ENDRUN 0_dmesg =
11574714_1.4.2.3.1>

    2023-09-19T22:21:46.639157  =


    2023-09-19T22:21:46.739740  / # #export SHELL=3D/bin/sh

    2023-09-19T22:21:46.739924  =


    2023-09-19T22:21:46.840494  / # export SHELL=3D/bin/sh. /lava-11574714/=
environment

    2023-09-19T22:21:46.840673  =


    2023-09-19T22:21:46.941235  / # . /lava-11574714/environment/lava-11574=
714/bin/lava-test-runner /lava-11574714/1

    2023-09-19T22:21:46.941597  =


    2023-09-19T22:21:46.946288  / # /lava-11574714/bin/lava-test-runner /la=
va-11574714/1

    2023-09-19T22:21:46.962461  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/650a1f46cc2a086b8d8a0a78

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650a1f46cc2a086b8d8a0a81
        failing since 123 days (last pass: v5.10.175-cip29-rt12, first fail=
: v5.10.179-cip32-rt13)

    2023-09-19T22:23:05.732544  + set +x

    2023-09-19T22:23:05.739041  <8>[   11.182240] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11574745_1.4.2.3.1>

    2023-09-19T22:23:05.844956  /#

    2023-09-19T22:23:05.946866   # #export SHELL=3D/bin/sh

    2023-09-19T22:23:05.947754  =


    2023-09-19T22:23:06.049222  / # export SHELL=3D/bin/sh. /lava-11574745/=
environment

    2023-09-19T22:23:06.049461  =


    2023-09-19T22:23:06.150032  / # . /lava-11574745/environment/lava-11574=
745/bin/lava-test-runner /lava-11574745/1

    2023-09-19T22:23:06.150385  =


    2023-09-19T22:23:06.155095  / # /lava-11574745/bin/lava-test-runner /la=
va-11574745/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/650a21bdea8b1ecd3d8a0aac

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm/defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm/defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650a21bdea8b1ecd3d8a0ab4
        failing since 235 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-09-19T22:33:28.083403  + set +x

    2023-09-19T22:33:28.188931  <8>[    9.198846] <LA#

    2023-09-19T22:33:28.189992  VA_SIGNAL_TESTCASE TEST_CASE_ID=3Demerg RES=
ULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-09-19T22:33:28.190314  <8>[    9.201193] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11574917_1.5.2.4.1>

    2023-09-19T22:33:28.292312  / # #export SHELL=3D/bin/sh

    2023-09-19T22:33:28.292993  =


    2023-09-19T22:33:28.394785  / # export SHELL=3D/bin/sh. /lava-11574917/=
environment

    2023-09-19T22:33:28.395509  =


    2023-09-19T22:33:28.497198  / # . /lava-11574917/environment/lava-11574=
917/bin/lava-test-runner /lava-11574917/1

    2023-09-19T22:33:28.498286  =

 =

    ... (18 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/650a1f9aa6dc454d5f8a0a57

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-s=
abrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-s=
abrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650a1f9aa6dc454d5f8a0a60
        failing since 235 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-09-19T22:24:28.453742  / # #

    2023-09-19T22:24:28.555831  export SHELL=3D/bin/sh

    2023-09-19T22:24:28.556517  #

    2023-09-19T22:24:28.657894  / # export SHELL=3D/bin/sh. /lava-11574822/=
environment

    2023-09-19T22:24:28.658582  =


    2023-09-19T22:24:28.760034  / # . /lava-11574822/environment/lava-11574=
822/bin/lava-test-runner /lava-11574822/1

    2023-09-19T22:24:28.761096  =


    2023-09-19T22:24:28.762930  / # /lava-11574822/bin/lava-test-runner /la=
va-11574822/1

    2023-09-19T22:24:28.875844  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-19T22:24:28.876337  + cd /lava-11574822/1/tests/1_bootrr
 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/650a219eea8b1ecd3d8a0a42

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm/defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandboa=
rd-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm/defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandboa=
rd-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650a219eea8b1ecd3d8a0a4a
        failing since 235 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-09-19T22:32:55.198874  + set +x
    2023-09-19T22:32:55.311961  [    7.234052] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines#
    2023-09-19T22:32:55.312613   MEASUREMENT=3D0>
    2023-09-19T22:32:55.312762  [    7.235376] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1001047_1.5.2.3.1>
    2023-09-19T22:32:55.414186  / # #export SHELL=3D/bin/sh
    2023-09-19T22:32:55.414681  =

    2023-09-19T22:32:55.516053  / # export SHELL=3D/bin/sh. /lava-1001047/e=
nvironment
    2023-09-19T22:32:55.516532  =

    2023-09-19T22:32:55.617801  / # . /lava-1001047/environment/lava-100104=
7/bin/lava-test-runner /lava-1001047/1
    2023-09-19T22:32:55.618427   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/650a19f6064c9ccbf18a0a5e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6=
qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6=
qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650a19f6064c9ccbf18a0a67
        failing since 235 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-09-19T22:00:14.719440  =

    2023-09-19T22:00:14.822382  / # #
    2023-09-19T22:00:14.924139  export SHELL=3D/bin/sh
    2023-09-19T22:00:14.924694  #
    2023-09-19T22:00:15.026074  / # export SHELL=3D/bin/sh. /lava-1001035/e=
nvironment
    2023-09-19T22:00:15.026627  =

    2023-09-19T22:00:15.128275  / # . /lava-1001035/environment/lava-100103=
5/bin/lava-test-runner /lava-1001035/1
    2023-09-19T22:00:15.129521  =

    2023-09-19T22:00:15.132272  / # /lava-1001035/bin/lava-test-runner /lav=
a-1001035/1
    2023-09-19T22:00:15.297503  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/650a1f81a6dc454d5f8a0a42

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6q=
p-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6q=
p-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650a1f81a6dc454d5f8a0a4a
        failing since 235 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-09-19T22:23:54.466669  + set +x
    2023-09-19T22:23:54.573623  / # #
    2023-09-19T22:23:54.675741  export SHELL=3D/bin/sh
    2023-09-19T22:23:54.676484  [    7.190315] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-09-19T22:23:54.676673  [    7.191421] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1001042_1.5.2.3.1>
    2023-09-19T22:23:54.676820  #
    2023-09-19T22:23:54.778290  / # export SHELL=3D/bin/sh. /lava-1001042/e=
nvironment
    2023-09-19T22:23:54.778868  =

    2023-09-19T22:23:54.880353  / # . /lava-1001042/environment/lava-100104=
2/bin/lava-test-runner /lava-1001042/1
    2023-09-19T22:23:54.881468   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6ul-14x14-evk             | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/650a1fe320ba73bf9c8a0a87

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx6ul-14x14-=
evk.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx6ul-14x14-=
evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650a1fe320ba73bf9c8a0a8d
        failing since 181 days (last pass: v5.10.100-cip2-rt2, first fail: =
v5.10.175-cip29-rt12)

    2023-09-19T22:25:23.492597  + set +x
    2023-09-19T22:25:23.508400  =

    2023-09-19T22:25:23.612117  <8>[#
    2023-09-19T22:25:23.612819     29.849766] <LAVA_SIGNAL_ENDRUN 0_dmesg 1=
252264_1.5.2.4.1>
    2023-09-19T22:25:24.768374  / # #export SHELL=3D/bin/sh
    2023-09-19T22:25:24.774046  =

    2023-09-19T22:25:26.315815  / # export SHELL=3D/bin/sh. /lava-1252264/e=
nvironment
    2023-09-19T22:25:26.321457  =

    2023-09-19T22:25:29.133188  / # . /lava-1252264/environment/lava-125226=
4/bin/lava-test-runner /lava-1252264/1
    2023-09-19T22:25:29.139182   =

    ... (19 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/650a21d7ea8b1ecd3d8a0ac5

  Results:     3 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm/defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm/defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650a21d7ea8b1ecd3d8a0acb
        failing since 235 days (last pass: v5.10.153-cip19-rt8, first fail:=
 v5.10.162-cip24-rt10)

    2023-09-19T22:33:39.266049  + set +x
    2023-09-19T22:33:39.266586  / # <8>[   17.249536] <LAVA_SIGNAL_TESTCASE=
 TEST_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-09-19T22:33:39.370304  <8>[   17.250996] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1252268_#
    2023-09-19T22:33:40.526318  export SHELL=3D/bin/sh
    2023-09-19T22:33:40.531929  1.5.2.4.1>
    2023-09-19T22:33:40.532225  #
    2023-09-19T22:33:40.532508  / # export SHELL=3D/bin/sh
    2023-09-19T22:33:42.074640  / # . /lava-1252268/environment
    2023-09-19T22:33:44.892174  /lava-1252268/bin/lava-test-runner /lava-12=
52268/1
    2023-09-19T22:33:44.898149  . /lava-1252268/environment =

    ... (22 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/650a1fe520ba73bf9c8a0a91

  Results:     3 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650a1fe520ba73bf9c8a0a97
        failing since 235 days (last pass: v5.10.153-cip19-rt8, first fail:=
 v5.10.162-cip24-rt10)

    2023-09-19T22:25:13.408285  + set +x
    2023-09-19T22:25:13.408824  / # <8>[   17.240219] <LAVA_SIGNAL_TESTCASE=
 TEST_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-09-19T22:25:13.512616  <8>[   17.241826] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1252265_#
    2023-09-19T22:25:14.668506  export SHELL=3D/bin/sh
    2023-09-19T22:25:14.674151  1.5.2.4.1>
    2023-09-19T22:25:14.674468  #
    2023-09-19T22:25:14.674760  / # export SHELL=3D/bin/sh
    2023-09-19T22:25:16.216689  / # . /lava-1252265/environment
    2023-09-19T22:25:19.033765  /lava-1252265/bin/lava-test-runner /lava-12=
52265/1
    2023-09-19T22:25:19.039765  . /lava-1252265/environment =

    ... (22 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/650a20482998d8bd098a0a49

  Results:     49 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm64/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-juno-=
uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm64/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-juno-=
uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650a20482998d8bd098a0a87
        new failure (last pass: v5.10.186-cip37-rt15)

    2023-09-19T22:26:51.382481  + set +x
    2023-09-19T22:26:51.383319  <8>[   20.412304] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-09-19T22:26:51.489117  <8>[   20.413570] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 118987_1.5.2.4.#
    2023-09-19T22:26:51.490379  1>
    2023-09-19T22:26:51.592559  / # #export SHELL=3D/bin/sh
    2023-09-19T22:26:51.593401  =

    2023-09-19T22:26:51.695348  / # export SHELL=3D/bin/sh. /lava-118987/en=
vironment
    2023-09-19T22:26:51.696145  =

    2023-09-19T22:26:51.798020  / # . /lava-118987/environment/lava-118987/=
bin/lava-test-runner /lava-118987/1
    2023-09-19T22:26:51.799219   =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/650a22e1849ce47c808a0a7a

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm64/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-r8a=
77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm64/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-r8a=
77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650a22e1849ce47c808a0a83
        new failure (last pass: v5.10.186-cip37-rt15)

    2023-09-19T22:42:22.884150  <8>[   15.802441] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11574818_1.5.2.4.1>

    2023-09-19T22:42:22.989872  / # #

    2023-09-19T22:42:23.091503  export SHELL=3D/bin/sh

    2023-09-19T22:42:23.091801  #

    2023-09-19T22:42:23.192654  / # export SHELL=3D/bin/sh. /lava-11574818/=
environment

    2023-09-19T22:42:23.193292  =


    2023-09-19T22:42:23.294407  / # . /lava-11574818/environment/lava-11574=
818/bin/lava-test-runner /lava-11574818/1

    2023-09-19T22:42:23.294731  =


    2023-09-19T22:42:23.304165  / # /lava-11574818/bin/lava-test-runner /la=
va-11574818/1

    2023-09-19T22:42:23.348036  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (29 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/650a233116cae821d68a0a42

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650a233116cae821d68a0a4b
        new failure (last pass: v5.10.186-cip37-rt15)

    2023-09-19T22:43:42.780210  <8>[   15.505757] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-09-19T22:43:42.780716  + set +x

    2023-09-19T22:43:42.781426  / # <8>[   15.515384] <LAVA_SIGNAL_ENDRUN 0=
_dmesg 11574898_1.5.2.4.1>

    2023-09-19T22:43:42.886133  #

    2023-09-19T22:43:42.988493  export SHELL=3D/bin/sh

    2023-09-19T22:43:42.989253  #

    2023-09-19T22:43:43.090445  / # export SHELL=3D/bin/sh. /lava-11574898/=
environment

    2023-09-19T22:43:43.090734  =


    2023-09-19T22:43:43.191541  / # . /lava-11574898/environment/lava-11574=
898/bin/lava-test-runner /lava-11574898/1

    2023-09-19T22:43:43.192718  =

 =

    ... (31 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 4          =


  Details:     https://kernelci.org/test/plan/id/650a21a1ea8b1ecd3d8a0a4f

  Results:     63 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-=
veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-=
veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-i2c-present: https://kernelci.or=
g/test/case/id/650a21a1ea8b1ecd3d8a0a82
        failing since 235 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-09-19T22:37:11.287293  	<8>[   18.415256] <LAVA_SIGNAL_TESTCASE TE=
ST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>

    2023-09-19T22:37:11.290787  -w	Pad to last with leading zeros

    2023-09-19T22:37:11.293138  	-s SEP	String separator
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/650a21a1ea8b1ecd3d8a0a83
        failing since 235 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-09-19T22:37:11.271434  Print numbers fro<8>[   18.400047] <LAVA_SI=
GNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-audio-present RESULT=3D=
fail>

    2023-09-19T22:37:11.274421  m FIRST to LAST, in steps of INC.

    2023-09-19T22:37:11.276905  FIRST, INC default to 1.

    2023-09-19T22:37:11.277131  =

   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/650a21a1ea8b1ecd3d8a0a84
        failing since 235 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-09-19T22:37:11.254810  <8>[   18.386386] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>

    2023-09-19T22:37:11.259053  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-09-19T22:37:11.259283  =

   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650a21a1ea8b1ecd3d8a0a98
        failing since 235 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-09-19T22:36:59.759878  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-19T22:36:59.760048  + cd /lava-11574826/1/tests/1_bootrr

    2023-09-19T22:36:59.760110  + cat uuid

    2023-09-19T22:36:59.760345  + UUID=3D11574826_1.5.2.3.5

    2023-09-19T22:36:59.760404  + set +x

    2023-09-19T22:36:59.760456  + export 'P<8>[    6.888858] <LAVA_SIGNAL_S=
TARTRUN 1_bootrr 11574826_1.5.2.3.5>

    2023-09-19T22:36:59.760508  ATH=3D/opt/bootrr/libexec/bootrr/helpers:/l=
ava-11574826/1/../bin:/sbin:/usr/sbin:/bin:/usr/bin'

    2023-09-19T22:36:59.762793  + cd /opt/bootrr/libexec/bootrr

    2023-09-19T22:36:59.765395  + sh helpers/bootrr-auto

    2023-09-19T22:36:59.767917  ff770000.syscon:io-domains	=

 =

    ... (9 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora   | gcc-10   | defcon=
fig+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/650a1fd177e63cc19f8a0a64

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm64/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-rk3=
399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm64/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-rk3=
399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650a1fd177e63cc19f8a0a6d
        new failure (last pass: v5.10.186-cip37-rt15)

    2023-09-19T22:26:53.867839  #

    2023-09-19T22:26:55.129054  export SHELL=3D/bin/sh

    2023-09-19T22:26:55.140049  #

    2023-09-19T22:26:55.140526  / # export SHELL=3D/bin/sh

    2023-09-19T22:26:56.884283  / # . /lava-11574809/environment

    2023-09-19T22:27:00.089461  /lava-11574809/bin/lava-test-runner /lava-1=
1574809/1

    2023-09-19T22:27:00.100479  . /lava-11574809/environment

    2023-09-19T22:27:00.103834  / # /lava-11574809/bin/lava-test-runner /la=
va-11574809/1

    2023-09-19T22:27:00.155811  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-19T22:27:00.156302  + cd /lava-11574809/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/650a20fe722577ee838a0a62

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock-pi=
-4b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock-pi=
-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650a20fe722577ee838a0a6a
        new failure (last pass: v5.10.186-cip37-rt15)

    2023-09-19T22:31:56.793760  + set +x

    2023-09-19T22:31:56.794512  / # <8>[   21.653015] <LAVA_SIGNAL_TESTCASE=
 TEST_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-09-19T22:31:56.794757  <8>[   21.654096] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11574899_1.5.2.4.1>

    2023-09-19T22:31:56.899113  #

    2023-09-19T22:31:58.160417  export SHELL=3D/bin/sh

    2023-09-19T22:31:58.171339  #

    2023-09-19T22:31:58.171800  / # export SHELL=3D/bin/sh

    2023-09-19T22:31:59.915929  / # . /lava-11574899/environment

    2023-09-19T22:32:03.121938  /lava-11574899/bin/lava-test-runner /lava-1=
1574899/1

    2023-09-19T22:32:03.133475  . /lava-11574899/environment
 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/650a21cf53f0b333b88a0a43

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine6=
4-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine6=
4-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650a21cf53f0b333b88a0=
a44
        failing since 66 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v5.10.186-cip37-rt15) =

 =20

