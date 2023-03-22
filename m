Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43DAC6FD1F
	for <webhook@archiver.kernel.org>; Wed, 22 Mar 2023 13:00:43 +0000 (UTC)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
 by mx.groups.io with SMTP id smtpd.web11.41769.1679490033822923190
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 22 Mar 2023 06:00:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=KMZFSlJc;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.43, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f43.google.com with SMTP id d13so18448831pjh.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 22 Mar 2023 06:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1679490033;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tN982H7QSeAR++z7wG+sM0mmsOl0ET+F0QVy1I1vOgU=;
        b=KMZFSlJc0zWbmbgJP6rxKAjq4AaLgKanZk3wGfI/CPID78+6ZrvlrxzQ4fgkUQUbPJ
         S6WOsDpCAxRc62fMgM8PR7JEUmVTFDkH4TXvtx6QPu9OXDqDK2YIlzdfT9QQPXOwyz3p
         ZWowcpw5fDllQeJdbun6XKB3gbbsvygDIAxaLPxhUkrhvSlHgbdQsOBkiPgDTxmd2b2C
         2uCYDFT1Orki3Alj7dWmNJbAWZmSuMIY1Uo+NWj/5VI2vcCC5Lc1IOXmkSFD2R4A5kvP
         xwdGGMZAxqZeUh8ZbHg4oW0rW3ySbGvDNcZB7TcxLEkv0BwuTyeMyeybDidxYhY04yua
         9BYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679490033;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tN982H7QSeAR++z7wG+sM0mmsOl0ET+F0QVy1I1vOgU=;
        b=mGoFEbdp5FjhZMkmtgzvPYv8t/Fp7jxkBIjzBWsSO0FZGSrRkn8GbcKbYfh+nP94ZU
         qoMMd/t1PGu32ILLk1CNBsLqh7WXsMuLQ6SbUfKbIV8bwyyGPwWmy36TE7XQ3z0XOfEA
         nAzqvV6aOIfyszJ2PPKgzEs+x7xcMPbPj+RLpVTKTA1MhGVZ8LzfJxFQn9cmLuDtUsMl
         kFjoRPJlf9jfZb4G+uHe3eL3WcX8ZLCNnjeqShfKGR0L/TJIFRlfRn4+EBTJ76tUEVK8
         ZyRn3q0A668UyQa487AqTUeDscdrCwWS8GMybLh09CsJNpolydHIXnAXGCuHN5pxZlDT
         0BrQ==
X-Gm-Message-State: AO0yUKXBOAKlbDhNCZBviem4/EqKRCPDV4p9jk/B/JMirYlFH3disEja
	XOLHep/coFGLHKfupKdA3XEXo2hMqMeQ1wC6Ck5qlw==
X-Google-Smtp-Source: AK7set87J9hTY+iHoUr+5Ho41WonFOibWNVQO8pDszRg52bnY+EEfgjWPuSZiZYuTyxvlZh3Mklg6Q==
X-Received: by 2002:a17:90b:4d83:b0:23d:50c6:2d17 with SMTP id oj3-20020a17090b4d8300b0023d50c62d17mr3602895pjb.10.1679490029953;
        Wed, 22 Mar 2023 06:00:29 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g7-20020a170902934700b001994a0f3380sm10503607plp.265.2023.03.22.06.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 06:00:29 -0700 (PDT)
Message-ID: <641afbed.170a0220.ebbc4.28e3@mx.google.com>
Date: Wed, 22 Mar 2023 06:00:29 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip-rt
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.277-cip94-rt29
Subject: cip/linux-4.19.y-cip-rt baseline: 191 runs,
 51 regressions (v4.19.277-cip94-rt29)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Mar 2023 13:00:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11076

cip/linux-4.19.y-cip-rt baseline: 191 runs, 51 regressions (v4.19.277-cip94=
-rt29)

Regressions Summary
-------------------

platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora   | gcc-10   | defconfig=
+x86-chromebook     | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora   | gcc-10   | defconfig=
+x86-chromebook     | 1          =

at91sam9g20ek             | arm    | lab-broonie     | gcc-10   | multi_v5_=
defconfig           | 1          =

beaglebone-black          | arm    | lab-broonie     | gcc-10   | defconfig=
                    | 1          =

beaglebone-black          | arm    | lab-broonie     | gcc-10   | defconfig=
+preempt_rt         | 1          =

beaglebone-black          | arm    | lab-cip         | gcc-10   | defconfig=
                    | 1          =

beaglebone-black          | arm    | lab-broonie     | gcc-10   | multi_v7_=
defc...g+preempt_rt | 1          =

beaglebone-black          | arm    | lab-broonie     | gcc-10   | multi_v7_=
defconfig           | 1          =

beaglebone-black          | arm    | lab-cip         | gcc-10   | multi_v7_=
defc...g+preempt_rt | 1          =

beaglebone-black          | arm    | lab-broonie     | gcc-10   | omap2plus=
_defconfig          | 1          =

hp-x360-14-G1-sona        | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...k+preempt_rt | 1          =

imx6q-sabrelite           | arm    | lab-collabora   | gcc-10   | defconfig=
                    | 1          =

imx6q-sabrelite           | arm    | lab-collabora   | gcc-10   | defconfig=
+preempt_rt         | 1          =

imx6q-sabrelite           | arm    | lab-collabora   | gcc-10   | multi_v7_=
defc...g+preempt_rt | 1          =

imx6q-sabrelite           | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 1          =

imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | defconfig=
                    | 1          =

imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | defconfig=
+preempt_rt         | 1          =

imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | imx_v6_v7=
_defconfig          | 1          =

imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | multi_v7_=
defc...g+preempt_rt | 1          =

imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | multi_v7_=
defconfig           | 1          =

imx6ul-14x14-evk          | arm    | lab-nxp         | gcc-10   | defconfig=
                    | 1          =

imx6ul-14x14-evk          | arm    | lab-nxp         | gcc-10   | defconfig=
+preempt_rt         | 1          =

imx6ul-14x14-evk          | arm    | lab-nxp         | gcc-10   | multi_v7_=
defc...g+preempt_rt | 1          =

imx6ul-14x14-evk          | arm    | lab-nxp         | gcc-10   | multi_v7_=
defconfig           | 1          =

imx7d-sdb                 | arm    | lab-nxp         | gcc-10   | defconfig=
                    | 1          =

imx7d-sdb                 | arm    | lab-nxp         | gcc-10   | defconfig=
+preempt_rt         | 1          =

imx7d-sdb                 | arm    | lab-nxp         | gcc-10   | multi_v7_=
defc...g+preempt_rt | 1          =

imx7d-sdb                 | arm    | lab-nxp         | gcc-10   | multi_v7_=
defconfig           | 1          =

odroid-xu3                | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 1          =

rk3288-veyron-jaq         | arm    | lab-collabora   | gcc-10   | defconfig=
                    | 3          =

rk3288-veyron-jaq         | arm    | lab-collabora   | gcc-10   | defconfig=
+preempt_rt         | 3          =

rk3288-veyron-jaq         | arm    | lab-collabora   | gcc-10   | multi_v7_=
defc...g+preempt_rt | 3          =

rk3288-veyron-jaq         | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 3          =

sun50i-a64-pine64-plus    | arm64  | lab-broonie     | gcc-10   | defconfig=
+preempt_rt         | 1          =

sun50i-a64-pine64-plus    | arm64  | lab-broonie     | gcc-10   | defconfig=
                    | 1          =

sun50i-h6-pine-h64        | arm64  | lab-collabora   | gcc-10   | defconfig=
+preempt_rt         | 1          =

sun50i-h6-pine-h64        | arm64  | lab-collabora   | gcc-10   | defconfig=
                    | 1          =

tegra124-nyan-big         | arm    | lab-collabora   | gcc-10   | defconfig=
                    | 1          =

tegra124-nyan-big         | arm    | lab-collabora   | gcc-10   | defconfig=
+preempt_rt         | 1          =

tegra124-nyan-big         | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 1          =

tegra124-nyan-big         | arm    | lab-collabora   | gcc-10   | tegra_def=
config              | 1          =

zynqmp-zcu102             | arm64  | lab-cip         | gcc-10   | defconfig=
+preempt_rt         | 1          =

zynqmp-zcu102             | arm64  | lab-cip         | gcc-10   | defconfig=
                    | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip-rt/ke=
rnel/v4.19.277-cip94-rt29/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.19.y-cip-rt
  Describe: v4.19.277-cip94-rt29
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      26d9f86d942d1c22bb7542618e47ea5c0e6b4026 =



Test Regressions
---------------- =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora   | gcc-10   | defconfig=
+x86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/641af32d8ab49c5b679c9524

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/641af32d8ab49c5b679c9=
525
        new failure (last pass: v4.19.269-cip88-rt28) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora   | gcc-10   | defconfig=
+x86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/641af21909c03db9e39c954f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641af21909c03db9e39c9558
        failing since 62 days (last pass: v4.19.265-cip85-rt27, first fail:=
 v4.19.269-cip88-rt28)

    2023-03-22T12:18:17.681289  <8>[   11.304890] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-03-22T12:18:17.682032  + set +x

    2023-03-22T12:18:17.690697  <8>[   11.315124] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9729453_1.4.2.3.1>

    2023-03-22T12:18:17.796856  / # #

    2023-03-22T12:18:17.899948  export SHELL=3D/bin/sh

    2023-03-22T12:18:17.900846  #

    2023-03-22T12:18:18.002874  / # export SHELL=3D/bin/sh. /lava-9729453/e=
nvironment

    2023-03-22T12:18:18.003770  =


    2023-03-22T12:18:18.105871  / # . /lava-9729453/environment/lava-972945=
3/bin/lava-test-runner /lava-9729453/1

    2023-03-22T12:18:18.107264  =

 =

    ... (14 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
at91sam9g20ek             | arm    | lab-broonie     | gcc-10   | multi_v5_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/641af1e8d590501e979c955b

  Results:     42 PASS, 9 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g=
20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g=
20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641af1e8d590501e979c9591
        failing since 62 days (last pass: v4.19.265-cip85-rt27, first fail:=
 v4.19.269-cip88-rt28)

    2023-03-22T12:17:21.211509  + set +x
    2023-03-22T12:17:21.216817  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 206530_1.5.2=
.4.1>
    2023-03-22T12:17:21.328853  / # #
    2023-03-22T12:17:21.431827  export SHELL=3D/bin/sh
    2023-03-22T12:17:21.432612  #
    2023-03-22T12:17:21.534571  / # export SHELL=3D/bin/sh. /lava-206530/en=
vironment
    2023-03-22T12:17:21.535374  =

    2023-03-22T12:17:21.637373  / # . /lava-206530/environment/lava-206530/=
bin/lava-test-runner /lava-206530/1
    2023-03-22T12:17:21.638806  =

    2023-03-22T12:17:21.645205  / # /lava-206530/bin/lava-test-runner /lava=
-206530/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
beaglebone-black          | arm    | lab-broonie     | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/641af50351a40fc0359c952a

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641af50351a40fc0359c9559
        failing since 62 days (last pass: v4.19.265-cip85-rt27, first fail:=
 v4.19.269-cip88-rt28)

    2023-03-22T12:30:06.943209  <8>[   15.872257] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 206595_1.5.2.4.1>
    2023-03-22T12:30:07.092035  / # #
    2023-03-22T12:30:07.206249  export SHELL=3D/bin/sh
    2023-03-22T12:30:07.210496  #
    2023-03-22T12:30:07.318590  / # export SHELL=3D/bin/sh. /lava-206595/en=
vironment
    2023-03-22T12:30:07.322800  =

    2023-03-22T12:30:07.431259  / # . /lava-206595/environment/lava-206595/=
bin/lava-test-runner /lava-206595/1
    2023-03-22T12:30:07.438457  =

    2023-03-22T12:30:07.442178  / # /lava-206595/bin/lava-test-runner /lava=
-206595/1
    2023-03-22T12:30:07.508075  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
beaglebone-black          | arm    | lab-broonie     | gcc-10   | defconfig=
+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/641af545683aba9cd59c950a

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-beagleb=
one-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-beagleb=
one-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641af545683aba9cd59c9534
        failing since 62 days (last pass: v4.19.265-cip85-rt27, first fail:=
 v4.19.269-cip88-rt28)

    2023-03-22T12:31:20.421140  <8>[   15.731626] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 206656_1.5.2.4.1>
    2023-03-22T12:31:20.533165  / # #
    2023-03-22T12:31:20.636701  export SHELL=3D/bin/sh
    2023-03-22T12:31:20.637579  #
    2023-03-22T12:31:20.739893  / # export SHELL=3D/bin/sh. /lava-206656/en=
vironment
    2023-03-22T12:31:20.740899  =

    2023-03-22T12:31:20.843087  / # . /lava-206656/environment/lava-206656/=
bin/lava-test-runner /lava-206656/1
    2023-03-22T12:31:20.844721  =

    2023-03-22T12:31:20.848786  / # /lava-206656/bin/lava-test-runner /lava=
-206656/1
    2023-03-22T12:31:20.930417  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
beaglebone-black          | arm    | lab-cip         | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/641af9e93b9b6b45879c9505

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/defconfig/gcc-10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/defconfig/gcc-10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641af9e93b9b6b45879c950c
        failing since 62 days (last pass: v4.19.265-cip85-rt27, first fail:=
 v4.19.269-cip88-rt28)

    2023-03-22T12:51:17.000658  <8>[    8.907074] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 883585_1.5.2.4.1>
    2023-03-22T12:51:17.111148  / # #
    2023-03-22T12:51:17.212711  export SHELL=3D/bin/sh
    2023-03-22T12:51:17.213311  #
    2023-03-22T12:51:17.314904  / # export SHELL=3D/bin/sh. /lava-883585/en=
vironment
    2023-03-22T12:51:17.315568  =

    2023-03-22T12:51:17.417282  / # . /lava-883585/environment/lava-883585/=
bin/lava-test-runner /lava-883585/1
    2023-03-22T12:51:17.418372  =

    2023-03-22T12:51:17.424495  / # /lava-883585/bin/lava-test-runner /lava=
-883585/1
    2023-03-22T12:51:17.491054  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
beaglebone-black          | arm    | lab-broonie     | gcc-10   | multi_v7_=
defc...g+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/641af053edd681ee629c9540

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-broonie/baselin=
e-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-broonie/baselin=
e-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641af053edd681ee629c956f
        failing since 62 days (last pass: v4.19.265-cip85-rt27, first fail:=
 v4.19.269-cip88-rt28)

    2023-03-22T12:10:04.252489  <8>[   13.184282] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 206342_1.5.2.4.1>
    2023-03-22T12:10:04.413092  / # #
    2023-03-22T12:10:04.529175  export SHELL=3D/bin/sh
    2023-03-22T12:10:04.534455  #
    2023-03-22T12:10:04.643304  / # export SHELL=3D/bin/sh. /lava-206342/en=
vironment
    2023-03-22T12:10:04.650137  =

    2023-03-22T12:10:04.759664  / # . /lava-206342/environment/lava-206342/=
bin/lava-test-runner /lava-206342/1
    2023-03-22T12:10:04.769333  =

    2023-03-22T12:10:04.773074  / # /lava-206342/bin/lava-test-runner /lava=
-206342/1
    2023-03-22T12:10:04.853474  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
beaglebone-black          | arm    | lab-broonie     | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/641af4bde0db35a10a9c9530

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebon=
e-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebon=
e-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641af4bde0db35a10a9c955f
        failing since 62 days (last pass: v4.19.265-cip85-rt27, first fail:=
 v4.19.269-cip88-rt28)

    2023-03-22T12:29:04.772247  <8>[   16.176645] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 206616_1.5.2.4.1>
    2023-03-22T12:29:04.880148  / # #
    2023-03-22T12:29:04.983376  export SHELL=3D/bin/sh
    2023-03-22T12:29:04.984057  #
    2023-03-22T12:29:05.086224  / # export SHELL=3D/bin/sh. /lava-206616/en=
vironment
    2023-03-22T12:29:05.086855  =

    2023-03-22T12:29:05.188692  / # . /lava-206616/environment/lava-206616/=
bin/lava-test-runner /lava-206616/1
    2023-03-22T12:29:05.189852  =

    2023-03-22T12:29:05.194235  / # /lava-206616/bin/lava-test-runner /lava=
-206616/1
    2023-03-22T12:29:05.261320  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
beaglebone-black          | arm    | lab-cip         | gcc-10   | multi_v7_=
defc...g+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/641aef71922357061c9c9526

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-cip/baseline-be=
aglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-cip/baseline-be=
aglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641aef71922357061c9c952d
        failing since 62 days (last pass: v4.19.265-cip85-rt27, first fail:=
 v4.19.269-cip88-rt28)

    2023-03-22T12:06:18.958538  <8>[   10.129812] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 883521_1.5.2.4.1>
    2023-03-22T12:06:19.068304  / # #
    2023-03-22T12:06:19.171198  export SHELL=3D/bin/sh
    2023-03-22T12:06:19.172011  #
    2023-03-22T12:06:19.273967  / # export SHELL=3D/bin/sh. /lava-883521/en=
vironment
    2023-03-22T12:06:19.274750  =

    2023-03-22T12:06:19.376796  / # . /lava-883521/environment/lava-883521/=
bin/lava-test-runner /lava-883521/1
    2023-03-22T12:06:19.378072  =

    2023-03-22T12:06:19.384629  / # /lava-883521/bin/lava-test-runner /lava=
-883521/1
    2023-03-22T12:06:19.465164  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
beaglebone-black          | arm    | lab-broonie     | gcc-10   | omap2plus=
_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/641af09962c17a7e3c9c9516

  Results:     41 PASS, 10 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beaglebo=
ne-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beaglebo=
ne-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641af09962c17a7e3c9c954c
        new failure (last pass: v4.19.269-cip88-rt28)

    2023-03-22T12:11:43.933584  + set +x
    2023-03-22T12:11:43.937696  <8>[   16.935551] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 206394_1.5.2.4.1>
    2023-03-22T12:11:44.049047  / # #
    2023-03-22T12:11:44.151509  export SHELL=3D/bin/sh
    2023-03-22T12:11:44.152119  #
    2023-03-22T12:11:44.254331  / # export SHELL=3D/bin/sh. /lava-206394/en=
vironment
    2023-03-22T12:11:44.255001  =

    2023-03-22T12:11:44.356830  / # . /lava-206394/environment/lava-206394/=
bin/lava-test-runner /lava-206394/1
    2023-03-22T12:11:44.357631  =

    2023-03-22T12:11:44.362263  / # /lava-206394/bin/lava-test-runner /lava=
-206394/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
hp-x360-14-G1-sona        | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/641af2018909029bde9c950d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/641af2018909029bde9c9=
50e
        new failure (last pass: v4.19.269-cip88-rt28) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6q-sabrelite           | arm    | lab-collabora   | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/641af45efe26ce267c9c9528

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641af45efe26ce267c9c9531
        failing since 62 days (last pass: v4.19.265-cip85-rt27, first fail:=
 v4.19.269-cip88-rt28)

    2023-03-22T12:27:59.078766  / # #

    2023-03-22T12:27:59.181713  export SHELL=3D/bin/sh

    2023-03-22T12:27:59.182552  #

    2023-03-22T12:27:59.284709  / # export SHELL=3D/bin/sh. /lava-9729535/e=
nvironment

    2023-03-22T12:27:59.285549  =


    2023-03-22T12:27:59.387554  / # . /lava-9729535/environment/lava-972953=
5/bin/lava-test-runner /lava-9729535/1

    2023-03-22T12:27:59.388764  =


    2023-03-22T12:27:59.401042  / # /lava-9729535/bin/lava-test-runner /lav=
a-9729535/1

    2023-03-22T12:27:59.491411  + export 'TESTRUN_ID=3D1_bootrr'

    2023-03-22T12:27:59.491965  + cd /lava-9729535/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6q-sabrelite           | arm    | lab-collabora   | gcc-10   | defconfig=
+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/641af4dbc13ffdaec09c9523

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-imx6q=
-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-imx6q=
-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641af4dbc13ffdaec09c952c
        failing since 62 days (last pass: v4.19.265-cip85-rt27, first fail:=
 v4.19.269-cip88-rt28)

    2023-03-22T12:30:07.116812  + set +x

    2023-03-22T12:30:07.120797  <8>[    9.356189] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9729568_1.5.2.4.1>

    2023-03-22T12:30:07.229159  / # #

    2023-03-22T12:30:07.331853  export SHELL=3D/bin/sh

    2023-03-22T12:30:07.332605  #

    2023-03-22T12:30:07.434638  / # export SHELL=3D/bin/sh. /lava-9729568/e=
nvironment

    2023-03-22T12:30:07.435388  =


    2023-03-22T12:30:07.537438  / # . /lava-9729568/environment/lava-972956=
8/bin/lava-test-runner /lava-9729568/1

    2023-03-22T12:30:07.538703  =


    2023-03-22T12:30:07.540960  / # /lava-9729568/bin/lava-test-runner /lav=
a-9729568/1
 =

    ... (15 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6q-sabrelite           | arm    | lab-collabora   | gcc-10   | multi_v7_=
defc...g+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/641aef374e7438e88f9c958b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-collabora/basel=
ine-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-collabora/basel=
ine-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641aef374e7438e88f9c9594
        failing since 62 days (last pass: v4.19.265-cip85-rt27, first fail:=
 v4.19.269-cip88-rt28)

    2023-03-22T12:06:00.362981  / # #

    2023-03-22T12:06:00.466127  export SHELL=3D/bin/sh

    2023-03-22T12:06:00.467014  #

    2023-03-22T12:06:00.569379  / # export SHELL=3D/bin/sh. /lava-9729094/e=
nvironment

    2023-03-22T12:06:00.570305  =


    2023-03-22T12:06:00.672457  / # . /lava-9729094/environment/lava-972909=
4/bin/lava-test-runner /lava-9729094/1

    2023-03-22T12:06:00.673887  =


    2023-03-22T12:06:00.687304  / # /lava-9729094/bin/lava-test-runner /lav=
a-9729094/1

    2023-03-22T12:06:00.750659  + export 'TESTRUN_ID=3D1_bootrr'

    2023-03-22T12:06:00.787727  + cd /lava-9729094/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6q-sabrelite           | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/641af4867876c934c49c950e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-s=
abrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-s=
abrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641af4867876c934c49c9517
        failing since 62 days (last pass: v4.19.265-cip85-rt27, first fail:=
 v4.19.269-cip88-rt28)

    2023-03-22T12:28:39.427805  / # #

    2023-03-22T12:28:39.530738  export SHELL=3D/bin/sh

    2023-03-22T12:28:39.531603  #

    2023-03-22T12:28:39.633818  / # export SHELL=3D/bin/sh. /lava-9729543/e=
nvironment

    2023-03-22T12:28:39.634708  =


    2023-03-22T12:28:39.737045  / # . /lava-9729543/environment/lava-972954=
3/bin/lava-test-runner /lava-9729543/1

    2023-03-22T12:28:39.738388  =


    2023-03-22T12:28:39.749945  / # /lava-9729543/bin/lava-test-runner /lav=
a-9729543/1

    2023-03-22T12:28:39.798172  + export 'TESTRUN_ID=3D1_bootrr'

    2023-03-22T12:28:39.850230  + cd /lava-9729543/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/641af44157bc37340f9c957d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandboa=
rd-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandboa=
rd-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641af44157bc37340f9c9586
        failing since 62 days (last pass: v4.19.265-cip85-rt27, first fail:=
 v4.19.269-cip88-rt28)

    2023-03-22T12:27:34.127890  + set +x
    2023-03-22T12:27:34.128083  [    4.935856] <LAVA_SIGNAL_ENDRUN 0_dmesg =
921740_1.5.2.3.1>
    2023-03-22T12:27:34.234503  / # #
    2023-03-22T12:27:34.336207  export SHELL=3D/bin/sh
    2023-03-22T12:27:34.336707  #
    2023-03-22T12:27:34.437998  / # export SHELL=3D/bin/sh. /lava-921740/en=
vironment
    2023-03-22T12:27:34.438531  =

    2023-03-22T12:27:34.539767  / # . /lava-921740/environment/lava-921740/=
bin/lava-test-runner /lava-921740/1
    2023-03-22T12:27:34.540319  =

    2023-03-22T12:27:34.542966  / # /lava-921740/bin/lava-test-runner /lava=
-921740/1 =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | defconfig=
+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/641af4e1c13ffdaec09c9539

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/defconfig+preempt_rt/gcc-10/lab-pengutronix/baseline-imx=
6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/defconfig+preempt_rt/gcc-10/lab-pengutronix/baseline-imx=
6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641af4e1c13ffdaec09c9542
        failing since 62 days (last pass: v4.19.265-cip85-rt27, first fail:=
 v4.19.269-cip88-rt28)

    2023-03-22T12:30:16.675579  + set[    6.779162] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 921742_1.5.2.3.1>
    2023-03-22T12:30:16.675733   +x
    2023-03-22T12:30:16.781904  / # #
    2023-03-22T12:30:16.883407  export SHELL=3D/bin/sh
    2023-03-22T12:30:16.883814  #
    2023-03-22T12:30:16.985006  / # export SHELL=3D/bin/sh. /lava-921742/en=
vironment
    2023-03-22T12:30:16.985478  =

    2023-03-22T12:30:17.086776  / # . /lava-921742/environment/lava-921742/=
bin/lava-test-runner /lava-921742/1
    2023-03-22T12:30:17.087455  =

    2023-03-22T12:30:17.090106  / # /lava-921742/bin/lava-test-runner /lava=
-921742/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | imx_v6_v7=
_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/641af149aeb8fadb029c953f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6=
qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6=
qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641af149aeb8fadb029c9548
        failing since 62 days (last pass: v4.19.265-cip85-rt27, first fail:=
 v4.19.269-cip88-rt28)

    2023-03-22T12:14:54.242476  + set +x
    2023-03-22T12:14:54.242744  [    7.071452] <LAVA_SIGNAL_ENDRUN 0_dmesg =
921735_1.5.2.3.1>
    2023-03-22T12:14:54.350399  / # #
    2023-03-22T12:14:54.452479  export SHELL=3D/bin/sh
    2023-03-22T12:14:54.453131  #
    2023-03-22T12:14:54.554547  / # export SHELL=3D/bin/sh. /lava-921735/en=
vironment
    2023-03-22T12:14:54.555223  =

    2023-03-22T12:14:54.656684  / # . /lava-921735/environment/lava-921735/=
bin/lava-test-runner /lava-921735/1
    2023-03-22T12:14:54.657463  =

    2023-03-22T12:14:54.660417  / # /lava-921735/bin/lava-test-runner /lava=
-921735/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | multi_v7_=
defc...g+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/641aef0589ee67cd9b9c9533

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-pengutronix/bas=
eline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-pengutronix/bas=
eline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641aef0589ee67cd9b9c953c
        failing since 62 days (last pass: v4.19.265-cip85-rt27, first fail:=
 v4.19.269-cip88-rt28)

    2023-03-22T12:05:16.614955  + set +x[    6.656480] <LAVA_SIGNAL_ENDRUN =
0_dmesg 921730_1.5.2.3.1>
    2023-03-22T12:05:16.615436  =

    2023-03-22T12:05:16.721925  / # #
    2023-03-22T12:05:16.823955  export SHELL=3D/bin/sh
    2023-03-22T12:05:16.824547  #
    2023-03-22T12:05:16.925894  / # export SHELL=3D/bin/sh. /lava-921730/en=
vironment
    2023-03-22T12:05:16.926452  =

    2023-03-22T12:05:17.027857  / # . /lava-921730/environment/lava-921730/=
bin/lava-test-runner /lava-921730/1
    2023-03-22T12:05:17.028791  =

    2023-03-22T12:05:17.031298  / # /lava-921730/bin/lava-test-runner /lava=
-921730/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/641af4917876c934c49c9529

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6q=
p-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6q=
p-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641af4917876c934c49c9532
        failing since 62 days (last pass: v4.19.265-cip85-rt27, first fail:=
 v4.19.269-cip88-rt28)

    2023-03-22T12:28:53.753477  + set +x
    2023-03-22T12:28:53.753633  [    4.915593] <LAVA_SIGNAL_ENDRUN 0_dmesg =
921741_1.5.2.3.1>
    2023-03-22T12:28:53.860195  / # #
    2023-03-22T12:28:53.962082  export SHELL=3D/bin/sh
    2023-03-22T12:28:53.962549  #
    2023-03-22T12:28:54.063770  / # export SHELL=3D/bin/sh. /lava-921741/en=
vironment
    2023-03-22T12:28:54.064238  =

    2023-03-22T12:28:54.165524  / # . /lava-921741/environment/lava-921741/=
bin/lava-test-runner /lava-921741/1
    2023-03-22T12:28:54.166163  =

    2023-03-22T12:28:54.168578  / # /lava-921741/bin/lava-test-runner /lava=
-921741/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6ul-14x14-evk          | arm    | lab-nxp         | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/641af4ace0db35a10a9c9508

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/defconfig/gcc-10/lab-nxp/baseline-imx6ul-14x14-evk.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/defconfig/gcc-10/lab-nxp/baseline-imx6ul-14x14-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641af4ace0db35a10a9c9511
        new failure (last pass: v4.19.245-cip74-rt25)

    2023-03-22T12:29:14.616137  + set +x<8>[   22.391599] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 1181701_1.5.2.4.1>
    2023-03-22T12:29:14.616277  =

    2023-03-22T12:29:14.723308  =

    2023-03-22T12:29:15.881669  / # #export SHELL=3D/bin/sh
    2023-03-22T12:29:15.887366  =

    2023-03-22T12:29:15.887687  / # export SHELL=3D/bin/sh
    2023-03-22T12:29:17.435071  . /lava-1181701/environment
    2023-03-22T12:29:17.440753  / # . /lava-1181701/environment
    2023-03-22T12:29:20.262249  /lava-1181701/bin/lava-test-runner /lava-11=
81701/1
    2023-03-22T12:29:20.268150  / # /lava-1181701/bin/lava-test-runner /lav=
a-1181701/1 =

    ... (15 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6ul-14x14-evk          | arm    | lab-nxp         | gcc-10   | defconfig=
+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/641af5c0250a7de2079c95d0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/defconfig+preempt_rt/gcc-10/lab-nxp/baseline-imx6ul-14x1=
4-evk.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/defconfig+preempt_rt/gcc-10/lab-nxp/baseline-imx6ul-14x1=
4-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641af5c0250a7de2079c95d9
        new failure (last pass: v4.19.245-cip74-rt25)

    2023-03-22T12:33:38.363639  + set +x
    2023-03-22T12:33:38.364775  <8>[   24.978971] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1181708_1.5.2.4.1>
    2023-03-22T12:33:38.474111  / # #
    2023-03-22T12:33:39.634370  export SHELL=3D/bin/sh
    2023-03-22T12:33:39.640068  #
    2023-03-22T12:33:41.187068  / # export SHELL=3D/bin/sh. /lava-1181708/e=
nvironment
    2023-03-22T12:33:41.192575  =

    2023-03-22T12:33:44.013505  / # . /lava-1181708/environment/lava-118170=
8/bin/lava-test-runner /lava-1181708/1
    2023-03-22T12:33:44.019646  =

    2023-03-22T12:33:44.020215  / # /lava-1181708/bin/lava-test-runner /lav=
a-1181708/1 =

    ... (15 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6ul-14x14-evk          | arm    | lab-nxp         | gcc-10   | multi_v7_=
defc...g+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/641aefe4f505339c829c9512

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-nxp/baseline-im=
x6ul-14x14-evk.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-nxp/baseline-im=
x6ul-14x14-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641aefe4f505339c829c951b
        new failure (last pass: v4.19.245-cip74-rt25)

    2023-03-22T12:08:35.993543  + set +x
    2023-03-22T12:08:35.994673  <8>[   24.895825] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1181668_1.5.2.4.1>
    2023-03-22T12:08:36.103965  =

    2023-03-22T12:08:37.263860  / # #export SHELL=3D/bin/sh
    2023-03-22T12:08:37.269541  =

    2023-03-22T12:08:38.817203  / # export SHELL=3D/bin/sh. /lava-1181668/e=
nvironment
    2023-03-22T12:08:38.822882  =

    2023-03-22T12:08:41.643286  / # . /lava-1181668/environment/lava-118166=
8/bin/lava-test-runner /lava-1181668/1
    2023-03-22T12:08:41.649196  =

    2023-03-22T12:08:41.649667  / # /lava-1181668/bin/lava-test-runner /lav=
a-1181668/1 =

    ... (15 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6ul-14x14-evk          | arm    | lab-nxp         | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/641af51fb31ad809b89c9513

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx6ul-14x14-=
evk.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx6ul-14x14-=
evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641af51fb31ad809b89c951c
        new failure (last pass: v4.19.245-cip74-rt25)

    2023-03-22T12:31:12.188001  + set +x
    2023-03-22T12:31:12.189029  <8>[   22.657039] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1181704_1.5.2.4.1>
    2023-03-22T12:31:12.296027  / # #
    2023-03-22T12:31:13.454462  export SHELL=3D/bin/sh
    2023-03-22T12:31:13.460157  #
    2023-03-22T12:31:13.460477  / # export SHELL=3D/bin/sh
    2023-03-22T12:31:15.007783  . /lava-1181704/environment
    2023-03-22T12:31:15.013447  / # . /lava-1181704/environment
    2023-03-22T12:31:17.835562  /lava-1181704/bin/lava-test-runner /lava-11=
81704/1
    2023-03-22T12:31:17.841813  / # /lava-1181704/bin/lava-test-runner /lav=
a-1181704/1 =

    ... (15 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx7d-sdb                 | arm    | lab-nxp         | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/641af46c74bf4ed3c59c956c

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641af46c74bf4ed3c59c9575
        failing since 62 days (last pass: v4.19.265-cip85-rt27, first fail:=
 v4.19.269-cip88-rt28)

    2023-03-22T12:28:09.238568  <8>[   12.911977] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1181702_1.5.2.4.1>
    2023-03-22T12:28:09.342562  / # #
    2023-03-22T12:28:10.501091  export SHELL=3D/bin/sh
    2023-03-22T12:28:10.506511  #
    2023-03-22T12:28:12.051444  / # export SHELL=3D/bin/sh. /lava-1181702/e=
nvironment
    2023-03-22T12:28:12.056930  =

    2023-03-22T12:28:14.875467  / # . /lava-1181702/environment/lava-118170=
2/bin/lava-test-runner /lava-1181702/1
    2023-03-22T12:28:14.881044  =

    2023-03-22T12:28:14.881654  / # /lava-1181702/bin/lava-test-runner /lav=
a-1181702/1
    2023-03-22T12:28:14.983748  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (17 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx7d-sdb                 | arm    | lab-nxp         | gcc-10   | defconfig=
+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/641af4eaddc784d3849c9513

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/defconfig+preempt_rt/gcc-10/lab-nxp/baseline-imx7d-sdb.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/defconfig+preempt_rt/gcc-10/lab-nxp/baseline-imx7d-sdb.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641af4eaddc784d3849c951c
        failing since 62 days (last pass: v4.19.245-cip74-rt25, first fail:=
 v4.19.269-cip88-rt28)

    2023-03-22T12:30:10.732456  <8>[   14.346755] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1181707_1.5.2.4.1>
    2023-03-22T12:30:10.835636  / # #
    2023-03-22T12:30:11.993585  export SHELL=3D/bin/sh
    2023-03-22T12:30:11.998994  #
    2023-03-22T12:30:11.999118  / # export SHELL=3D/bin/sh
    2023-03-22T12:30:13.544295  . /lava-1181707/environment
    2023-03-22T12:30:13.549880  / # . /lava-1181707/environment
    2023-03-22T12:30:16.372503  /lava-1181707/bin/lava-test-runner /lava-11=
81707/1
    2023-03-22T12:30:16.378520  / # /lava-1181707/bin/lava-test-runner /lav=
a-1181707/1
    2023-03-22T12:30:16.485348  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (17 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx7d-sdb                 | arm    | lab-nxp         | gcc-10   | multi_v7_=
defc...g+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/641aef4353f8bec24d9c956b

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-nxp/baseline-im=
x7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-nxp/baseline-im=
x7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641aef4353f8bec24d9c9574
        failing since 62 days (last pass: v4.19.265-cip85-rt27, first fail:=
 v4.19.269-cip88-rt28)

    2023-03-22T12:06:06.994774  <8>[   14.393525] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1181667_1.5.2.4.1>
    2023-03-22T12:06:07.100406  / # #
    2023-03-22T12:06:08.260742  export SHELL=3D/bin/sh
    2023-03-22T12:06:08.266436  #
    2023-03-22T12:06:09.814207  / # export SHELL=3D/bin/sh. /lava-1181667/e=
nvironment
    2023-03-22T12:06:09.819905  =

    2023-03-22T12:06:12.642372  / # . /lava-1181667/environment/lava-118166=
7/bin/lava-test-runner /lava-1181667/1
    2023-03-22T12:06:12.648609  =

    2023-03-22T12:06:12.651846  / # /lava-1181667/bin/lava-test-runner /lav=
a-1181667/1
    2023-03-22T12:06:12.757760  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (17 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx7d-sdb                 | arm    | lab-nxp         | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/641af494665add3e379c952c

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641af494665add3e379c9535
        failing since 62 days (last pass: v4.19.265-cip85-rt27, first fail:=
 v4.19.269-cip88-rt28)

    2023-03-22T12:28:51.728843  / # #
    2023-03-22T12:28:52.887804  export SHELL=3D/bin/sh
    2023-03-22T12:28:52.893437  #
    2023-03-22T12:28:54.440994  / # export SHELL=3D/bin/sh. /lava-1181703/e=
nvironment
    2023-03-22T12:28:54.446720  =

    2023-03-22T12:28:57.268449  / # . /lava-1181703/environment/lava-118170=
3/bin/lava-test-runner /lava-1181703/1
    2023-03-22T12:28:57.274514  =

    2023-03-22T12:28:57.281210  / # /lava-1181703/bin/lava-test-runner /lav=
a-1181703/1
    2023-03-22T12:28:57.380330  + export 'TESTRUN_ID=3D1_bootrr'
    2023-03-22T12:28:57.380697  + cd /lava-1181703/1/tests/1_bootrr =

    ... (15 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
odroid-xu3                | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/641af5b352778ae8bd9c9560

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-odroid-=
xu3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-odroid-=
xu3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/641af5b352778ae8bd9c9=
561
        new failure (last pass: v4.19.269-cip88-rt28) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
rk3288-veyron-jaq         | arm    | lab-collabora   | gcc-10   | defconfig=
                    | 3          =


  Details:     https://kernelci.org/test/plan/id/641af46074bf4ed3c59c9517

  Results:     61 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-ja=
q.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-ja=
q.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/641af46074bf4ed3c59c954b
        failing since 61 days (last pass: v4.19.265-cip85-rt27, first fail:=
 v4.19.269-cip88-rt28)

    2023-03-22T12:27:47.741940   multi-call binary.

    2023-03-22T12:27:47.742290  =


    2023-03-22T12:27:47.746384  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-03-22T12:27:47.746966  =


    2023-03-22T12:27:47.751679  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-03-22T12:27:47.762262  FIRST,<8>[   10.405602] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/641af46074bf4ed3c59c954c
        failing since 61 days (last pass: v4.19.265-cip85-rt27, first fail:=
 v4.19.269-cip88-rt28)

    2023-03-22T12:27:47.739678  BusyBox v1.31.1 (2023-03-10 17:51:43 UTC)<8=
>[   10.386829] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641af46074bf4ed3c59c955f
        failing since 61 days (last pass: v4.19.265-cip85-rt27, first fail:=
 v4.19.269-cip88-rt28)

    2023-03-22T12:27:43.889634  <8>[    6.537468] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-03-22T12:27:43.899711  + <8>[    6.549671] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 9729533_1.5.2.3.1>

    2023-03-22T12:27:43.899920  set +x

    2023-03-22T12:27:44.006195  #

    2023-03-22T12:27:44.007050  =


    2023-03-22T12:27:44.108770  / # #export SHELL=3D/bin/sh

    2023-03-22T12:27:44.109347  =


    2023-03-22T12:27:44.210721  / # export SHELL=3D/bin/sh. /lava-9729533/e=
nvironment

    2023-03-22T12:27:44.211254  =


    2023-03-22T12:27:44.312726  / # . /lava-9729533/environment/lava-972953=
3/bin/lava-test-runner /lava-9729533/1
 =

    ... (17 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
rk3288-veyron-jaq         | arm    | lab-collabora   | gcc-10   | defconfig=
+preempt_rt         | 3          =


  Details:     https://kernelci.org/test/plan/id/641af4d93f99639e979c951c

  Results:     61 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-rk328=
8-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-rk328=
8-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/641af4d93f99639e979c9550
        failing since 61 days (last pass: v4.19.265-cip85-rt27, first fail:=
 v4.19.269-cip88-rt28)

    2023-03-22T12:29:49.543163  BusyBox v1.31.1 (2023-03-10 17:51:43 UTC)<8=
>[   14.699691] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-03-22T12:29:49.544429   multi-call binary.

    2023-03-22T12:29:49.544901  =


    2023-03-22T12:29:49.549210  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-03-22T12:29:49.549463  =


    2023-03-22T12:29:49.554095  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/641af4d93f99639e979c9551
        failing since 61 days (last pass: v4.19.265-cip85-rt27, first fail:=
 v4.19.269-cip88-rt28)

    2023-03-22T12:29:49.523710  <8>[   14.681563] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641af4d93f99639e979c9564
        failing since 61 days (last pass: v4.19.265-cip85-rt27, first fail:=
 v4.19.269-cip88-rt28)

    2023-03-22T12:29:45.658076  <8>[   10.814190] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-03-22T12:29:45.667117  + <8>[   10.826304] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 9729564_1.5.2.3.1>

    2023-03-22T12:29:45.667323  set +x

    2023-03-22T12:29:45.774535  =


    2023-03-22T12:29:45.877439  / # #export SHELL=3D/bin/sh

    2023-03-22T12:29:45.879101  =


    2023-03-22T12:29:45.982014  / # export SHELL=3D/bin/sh. /lava-9729564/e=
nvironment

    2023-03-22T12:29:45.983109  =


    2023-03-22T12:29:46.085260  / # . /lava-9729564/environment/lava-972956=
4/bin/lava-test-runner /lava-9729564/1

    2023-03-22T12:29:46.086937  =

 =

    ... (18 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
rk3288-veyron-jaq         | arm    | lab-collabora   | gcc-10   | multi_v7_=
defc...g+preempt_rt | 3          =


  Details:     https://kernelci.org/test/plan/id/641aef384e7438e88f9c9596

  Results:     61 PASS, 8 FAIL, 1 SKIP
  Full config: multi_v7_defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-collabora/basel=
ine-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-collabora/basel=
ine-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/641aef384e7438e88f9c95ae
        failing since 61 days (last pass: v4.19.265-cip85-rt27, first fail:=
 v4.19.269-cip88-rt28)

    2023-03-22T12:05:47.650367   multi-call binary.

    2023-03-22T12:05:47.650923  =


    2023-03-22T12:05:47.655351  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-03-22T12:05:47.655592  =


    2023-03-22T12:05:47.660503  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/641aef384e7438e88f9c95af
        failing since 61 days (last pass: v4.19.265-cip85-rt27, first fail:=
 v4.19.269-cip88-rt28)

    2023-03-22T12:05:47.648438  BusyBox v1.31.1 (2023-03-10 17:51:43 UTC)<8=
>[   11.775564] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641aef384e7438e88f9c95c2
        failing since 61 days (last pass: v4.19.265-cip85-rt27, first fail:=
 v4.19.269-cip88-rt28)

    2023-03-22T12:05:43.768299  + set +x

    2023-03-22T12:05:43.775665  <8>[    7.904563] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9729092_1.5.2.3.1>

    2023-03-22T12:05:43.882513  #

    2023-03-22T12:05:43.883782  =


    2023-03-22T12:05:43.985868  / # #export SHELL=3D/bin/sh

    2023-03-22T12:05:43.986709  =


    2023-03-22T12:05:44.088727  / # export SHELL=3D/bin/sh. /lava-9729092/e=
nvironment

    2023-03-22T12:05:44.089573  =


    2023-03-22T12:05:44.191704  / # . /lava-9729092/environment/lava-972909=
2/bin/lava-test-runner /lava-9729092/1

    2023-03-22T12:05:44.192897  =

 =

    ... (18 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
rk3288-veyron-jaq         | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 3          =


  Details:     https://kernelci.org/test/plan/id/641af49d665add3e379c9548

  Results:     61 PASS, 8 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-=
veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-=
veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/641af49d665add3e379c957c
        failing since 61 days (last pass: v4.19.265-cip85-rt27, first fail:=
 v4.19.269-cip88-rt28)

    2023-03-22T12:28:46.960579   multi-call binary.

    2023-03-22T12:28:46.960783  =


    2023-03-22T12:28:46.964840  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-03-22T12:28:46.965361  =


    2023-03-22T12:28:46.969976  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-03-22T12:28:46.980326  FIRST,<8>[   13.162383] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/641af49d665add3e379c957d
        failing since 61 days (last pass: v4.19.265-cip85-rt27, first fail:=
 v4.19.269-cip88-rt28)

    2023-03-22T12:28:46.940513  =


    2023-03-22T12:28:46.958027  BusyBox v1.31.1 (2023-03-10 17:51:43 UTC)<8=
>[   13.143591] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641af49d665add3e379c9590
        failing since 61 days (last pass: v4.19.265-cip85-rt27, first fail:=
 v4.19.269-cip88-rt28)

    2023-03-22T12:28:43.117095  + <8>[    9.305885] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 9729551_1.5.2.3.1>

    2023-03-22T12:28:43.117294  set +x

    2023-03-22T12:28:43.224019  / #

    2023-03-22T12:28:43.326508  # #export SHELL=3D/bin/sh

    2023-03-22T12:28:43.327162  =


    2023-03-22T12:28:43.428638  / # export SHELL=3D/bin/sh. /lava-9729551/e=
nvironment

    2023-03-22T12:28:43.429006  =


    2023-03-22T12:28:43.530394  / # . /lava-9729551/environment/lava-972955=
1/bin/lava-test-runner /lava-9729551/1

    2023-03-22T12:28:43.531223  =


    2023-03-22T12:28:43.533407  / # /lava-9729551/bin/lava-test-runner /lav=
a-9729551/1
 =

    ... (16 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
sun50i-a64-pine64-plus    | arm64  | lab-broonie     | gcc-10   | defconfig=
+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/641af4a5665add3e379c95e5

  Results:     23 PASS, 16 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm64/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-sun50=
i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm64/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-sun50=
i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641af4a5665add3e379c960e
        failing since 62 days (last pass: v4.19.265-cip85-rt27, first fail:=
 v4.19.269-cip88-rt28)

    2023-03-22T12:28:49.197884  <8>[   16.895791] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 206634_1.5.2.4.1>
    2023-03-22T12:28:49.305600  / # #
    2023-03-22T12:28:49.407990  export SHELL=3D/bin/sh
    2023-03-22T12:28:49.408683  #
    2023-03-22T12:28:49.510920  / # export SHELL=3D/bin/sh. /lava-206634/en=
vironment
    2023-03-22T12:28:49.511505  =

    2023-03-22T12:28:49.613033  / # . /lava-206634/environment/lava-206634/=
bin/lava-test-runner /lava-206634/1
    2023-03-22T12:28:49.613877  =

    2023-03-22T12:28:49.618186  / # /lava-206634/bin/lava-test-runner /lava=
-206634/1
    2023-03-22T12:28:49.659270  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
sun50i-a64-pine64-plus    | arm64  | lab-broonie     | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/641af5ab250a7de2079c959b

  Results:     23 PASS, 16 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine6=
4-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine6=
4-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641af5ab250a7de2079c95c5
        failing since 62 days (last pass: v4.19.265-cip85-rt27, first fail:=
 v4.19.269-cip88-rt28)

    2023-03-22T12:33:05.119574  <8>[   15.936068] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 206666_1.5.2.4.1>
    2023-03-22T12:33:05.226236  / # #
    2023-03-22T12:33:05.328731  export SHELL=3D/bin/sh
    2023-03-22T12:33:05.329464  #
    2023-03-22T12:33:05.431123  / # export SHELL=3D/bin/sh. /lava-206666/en=
vironment
    2023-03-22T12:33:05.431699  =

    2023-03-22T12:33:05.533558  / # . /lava-206666/environment/lava-206666/=
bin/lava-test-runner /lava-206666/1
    2023-03-22T12:33:05.534472  =

    2023-03-22T12:33:05.538963  / # /lava-206666/bin/lava-test-runner /lava=
-206666/1
    2023-03-22T12:33:05.569584  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
sun50i-h6-pine-h64        | arm64  | lab-collabora   | gcc-10   | defconfig=
+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/641af49f665add3e379c9592

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm64/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-sun=
50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm64/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-sun=
50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641af49f665add3e379c959b
        failing since 62 days (last pass: v4.19.265-cip85-rt27, first fail:=
 v4.19.269-cip88-rt28)

    2023-03-22T12:29:05.586910  / # #

    2023-03-22T12:29:05.688729  export SHELL=3D/bin/sh

    2023-03-22T12:29:05.689237  #

    2023-03-22T12:29:05.790613  / # export SHELL=3D/bin/sh. /lava-9729557/e=
nvironment

    2023-03-22T12:29:05.791162  =


    2023-03-22T12:29:05.892516  / # . /lava-9729557/environment/lava-972955=
7/bin/lava-test-runner /lava-9729557/1

    2023-03-22T12:29:05.893266  =


    2023-03-22T12:29:05.898216  / # /lava-9729557/bin/lava-test-runner /lav=
a-9729557/1

    2023-03-22T12:29:05.972145  + export 'TESTRUN_ID=3D1_bootrr'

    2023-03-22T12:29:05.972444  + cd /lava-9729557/1/tes<8>[   16.507209] <=
LAVA_SIGNAL_STARTRUN 1_bootrr 9729557_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
sun50i-h6-pine-h64        | arm64  | lab-collabora   | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/641af53c149d51dcd49c9506

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine=
-h64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine=
-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641af53c149d51dcd49c950f
        failing since 62 days (last pass: v4.19.265-cip85-rt27, first fail:=
 v4.19.269-cip88-rt28)

    2023-03-22T12:31:44.817235  / # #

    2023-03-22T12:31:44.919814  export SHELL=3D/bin/sh

    2023-03-22T12:31:44.920455  #

    2023-03-22T12:31:45.022340  / # export SHELL=3D/bin/sh. /lava-9729578/e=
nvironment

    2023-03-22T12:31:45.023091  =


    2023-03-22T12:31:45.125050  / # . /lava-9729578/environment/lava-972957=
8/bin/lava-test-runner /lava-9729578/1

    2023-03-22T12:31:45.126267  =


    2023-03-22T12:31:45.139160  / # /lava-9729578/bin/lava-test-runner /lav=
a-9729578/1

    2023-03-22T12:31:45.197173  + export 'TESTRUN_ID=3D1_bootrr'

    2023-03-22T12:31:45.197522  + cd /lava-9729578<8>[   15.610572] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 9729578_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
tegra124-nyan-big         | arm    | lab-collabora   | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/641af473a8de9d3f9f9c951b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/defconfig/gcc-10/lab-collabora/baseline-tegra124-nyan-bi=
g.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/defconfig/gcc-10/lab-collabora/baseline-tegra124-nyan-bi=
g.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641af473a8de9d3f9f9c9524
        failing since 60 days (last pass: v4.19.265-cip85-rt27, first fail:=
 v4.19.269-cip88-rt28)

    2023-03-22T12:28:18.515580  <8>[   17.827404] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-03-22T12:28:18.520515  + set +x

    2023-03-22T12:28:18.527442  <8>[   17.840623] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9729529_1.5.2.3.1>

    2023-03-22T12:28:18.635874  #

    2023-03-22T12:28:18.738219  / # #export SHELL=3D/bin/sh

    2023-03-22T12:28:18.738815  =


    2023-03-22T12:28:18.840284  / # export SHELL=3D/bin/sh. /lava-9729529/e=
nvironment

    2023-03-22T12:28:18.840711  =


    2023-03-22T12:28:18.942062  / # . /lava-9729529/environment/lava-972952=
9/bin/lava-test-runner /lava-9729529/1

    2023-03-22T12:28:18.942788  =

 =

    ... (14 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
tegra124-nyan-big         | arm    | lab-collabora   | gcc-10   | defconfig=
+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/641af6551393ce5e4d9c9517

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-tegra=
124-nyan-big.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-tegra=
124-nyan-big.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/641af6551393ce5e4d9c9=
518
        new failure (last pass: v4.19.269-cip88-rt28) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
tegra124-nyan-big         | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/641af4ebddc784d3849c951e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-tegra12=
4-nyan-big.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-tegra12=
4-nyan-big.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641af4ebddc784d3849c9527
        failing since 60 days (last pass: v4.19.265-cip85-rt27, first fail:=
 v4.19.269-cip88-rt28)

    2023-03-22T12:30:21.017001  + set +x

    2023-03-22T12:30:21.022527  <8>[   18.134400] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9729548_1.5.2.3.1>

    2023-03-22T12:30:21.132169  =


    2023-03-22T12:30:21.233609  / # #export SHELL=3D/bin/sh

    2023-03-22T12:30:21.233977  =


    2023-03-22T12:30:21.335403  / # export SHELL=3D/bin/sh. /lava-9729548/e=
nvironment

    2023-03-22T12:30:21.336159  =


    2023-03-22T12:30:21.437901  / # . /lava-9729548/environment/lava-972954=
8/bin/lava-test-runner /lava-9729548/1

    2023-03-22T12:30:21.438660  =


    2023-03-22T12:30:21.440712  / # /lava-9729548/bin/lava-test-runner /lav=
a-9729548/1
 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
tegra124-nyan-big         | arm    | lab-collabora   | gcc-10   | tegra_def=
config              | 1          =


  Details:     https://kernelci.org/test/plan/id/641af1b7486d026bf49c9572

  Results:     3 PASS, 3 FAIL, 1 SKIP
  Full config: tegra_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/tegra_defconfig/gcc-10/lab-collabora/baseline-tegra124-n=
yan-big.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm/tegra_defconfig/gcc-10/lab-collabora/baseline-tegra124-n=
yan-big.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641af1b7486d026bf49c957b
        failing since 60 days (last pass: v4.19.265-cip85-rt27, first fail:=
 v4.19.269-cip88-rt28)

    2023-03-22T12:16:34.076773  tack limit =3D 0x(ptrval))

    2023-03-22T12:16:34.085546  kern  :emerg : Stack: (0xc2c8bf2c to 0<8>[ =
  18.244848] <LAVA_SIGNAL_ENDRUN 0_dmesg 9729347_1.5.2.3.1>

    2023-03-22T12:16:34.089826  xc2c8c000)

    2023-03-22T12:16:34.095124  kern  :emerg : bf20:                       =
     c02e7aa8 00000000 00000000 c026e014 00000003

    2023-03-22T12:16:34.103060  kern  :emerg : bf40: c2c2a840 bed5af74 c2c8=
bf80 00000000 c2c8a000 00000004 00000003 c0270ea8

    2023-03-22T12:16:34.111126  kern  :emerg : bf60: c2404c88 c026e014 c2c2=
a840 c2c2a840 bed5af74 00000003 c0101264 c027110c

    2023-03-22T12:16:34.119110  kern  :emerg : bf80: 00000000 00000000 c2c8=
a000 25831dc7 b6fb07c0 00000003 b6fb07c0 bed5a468

    2023-03-22T12:16:34.127426  kern  :emerg : bfa0: 00000004 c0101000 0000=
0003 b6fb07c0 00000003 bed5af74 00000003 00000000

    2023-03-22T12:16:34.135607  kern  :emerg : bfc0: 00000003 b6fb07c0 bed5=
a468 00000004 00000003 0003c90c bed5ae58 00000003

    2023-03-22T12:16:34.143430  kern  :emerg : bfe0: 00059120 bed5a440 b6c7=
6960 b6c7697c 60000010 00000003 00000000 00000000
 =

    ... (23 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
zynqmp-zcu102             | arm64  | lab-cip         | gcc-10   | defconfig=
+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/641af47afe26ce267c9c9549

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm64/defconfig+preempt_rt/gcc-10/lab-cip/baseline-zynqmp-zc=
u102.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm64/defconfig+preempt_rt/gcc-10/lab-cip/baseline-zynqmp-zc=
u102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641af47afe26ce267c9c9550
        failing since 62 days (last pass: v4.19.265-cip85-rt27, first fail:=
 v4.19.269-cip88-rt28)

    2023-03-22T12:28:21.198774  + set +x
    2023-03-22T12:28:21.199905  <8>[    4.486693] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 883619_1.5.2.4.1>
    2023-03-22T12:28:21.307172  / # #
    2023-03-22T12:28:21.409124  export SHELL=3D/bin/sh
    2023-03-22T12:28:21.409583  #
    2023-03-22T12:28:21.511017  / # export SHELL=3D/bin/sh. /lava-883619/en=
vironment
    2023-03-22T12:28:21.511467  =

    2023-03-22T12:28:21.612903  / # . /lava-883619/environment/lava-883619/=
bin/lava-test-runner /lava-883619/1
    2023-03-22T12:28:21.613652  =

    2023-03-22T12:28:21.616786  / # /lava-883619/bin/lava-test-runner /lava=
-883619/1 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
zynqmp-zcu102             | arm64  | lab-cip         | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/641af542e1db9ff2d49c9507

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm64/defconfig/gcc-10/lab-cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/arm64/defconfig/gcc-10/lab-cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641af542e1db9ff2d49c950e
        failing since 62 days (last pass: v4.19.265-cip85-rt27, first fail:=
 v4.19.269-cip88-rt28)

    2023-03-22T12:31:39.079253  + set +x
    2023-03-22T12:31:39.080401  <8>[    3.759249] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 883660_1.5.2.4.1>
    2023-03-22T12:31:39.187836  / # #
    2023-03-22T12:31:39.289719  export SHELL=3D/bin/sh
    2023-03-22T12:31:39.290176  #
    2023-03-22T12:31:39.391568  / # export SHELL=3D/bin/sh. /lava-883660/en=
vironment
    2023-03-22T12:31:39.392020  =

    2023-03-22T12:31:39.493446  / # . /lava-883660/environment/lava-883660/=
bin/lava-test-runner /lava-883660/1
    2023-03-22T12:31:39.494182  =

    2023-03-22T12:31:39.497238  / # /lava-883660/bin/lava-test-runner /lava=
-883660/1 =

    ... (13 line(s) more)  =

 =20

