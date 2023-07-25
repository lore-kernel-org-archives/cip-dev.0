Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD841C00528
	for <webhook@archiver.kernel.org>; Tue, 25 Jul 2023 20:38:01 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.web10.163.1690317479124856341
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 25 Jul 2023 13:37:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=m53vOKqt;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.173, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1bb893e6365so19252115ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 25 Jul 2023 13:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690317478; x=1690922278;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kY7D0IkZXmvUelI2+QNpQ1J4Vsh8Q9rBx0FDinHEtuA=;
        b=m53vOKqtH9p8ElZn1OFi56ANOuUZVFjbtULFHsN+cDvF5znw+06fvJyCNNB+P4f0+M
         WcO7Lpuyuq7l4PwaSIKj+EGevwhBh5E84dc6z4UlEY3FJUr9lOGMsbjRbYWXSkmD4GWk
         vfxjQPpgpMEpxSrQuu5+IYNAXannrfmsZMI43vQUy60gq8XVr8Tyhx//UCHk67XEcqYh
         kZRjTWnh2nxosIam09OHsIGd7Yg6y1rpD8fJIXnR2Jaa5fNBqMHjjmHFhtFtilAc3vO0
         CG7Kuh8ssK+TFLr2bNUYgeMB6zbsOClKSN5uBRpjgMoBSMkWXQX28ZI2KJCUWYb8lFb/
         LSyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690317478; x=1690922278;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kY7D0IkZXmvUelI2+QNpQ1J4Vsh8Q9rBx0FDinHEtuA=;
        b=LlpLqnubF96+wHXRz+sSTcpxcrE4N4tNJSln+x5oplA0is/Onb40YYFhJ8ALOUcRe3
         KDE0bU9NEI7Bbjj72+YIy+lhE5vuv5QQjjz9cLfnFgSRfSVP8Dy8wfcbGvW3FBayJTMG
         uBRIO3YsZM409WTV5lD8muZWJVuEBJWRLVcoEYVesaC8LmnAQBu3NZ2Q3CLveIdRZoNv
         imVlOlZQQ2+84Ef/mWDKhNOR/jbiebLtpukh5S9+fIn1UllgjWTXPgNBp1OJ6PupTHCE
         K5h/AqmpuuQHDIR0m3OPHpV0ZoEUHwr2CIFcIE9ZzcJ0OJ6cTasC4U2DlDIk4oGIyLA/
         rTxg==
X-Gm-Message-State: ABy/qLZXjjjd1RhwU47ytuuM1AjU0t/GoN/0BKNJ/1uVNmro/DAMHwLx
	38vjjqFBCaNQsOu5TktmDUDC4R8TOICpkPKL+B2L0w==
X-Google-Smtp-Source: APBJJlG0VbMW27K6tjqybq3chn1g5KxUxeLgdJUWLdtPiydxSWJlndeU3Y8NmH0Y98+KbhDj5bgONw==
X-Received: by 2002:a17:902:d48e:b0:1bb:b86e:8d60 with SMTP id c14-20020a170902d48e00b001bbb86e8d60mr231931plg.46.1690317476923;
        Tue, 25 Jul 2023 13:37:56 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 1-20020a170902c10100b001bb9aadfb04sm5614120pli.220.2023.07.25.13.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 13:37:56 -0700 (PDT)
Message-ID: <64c032a4.170a0220.ea57.adbf@mx.google.com>
Date: Tue, 25 Jul 2023 13:37:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.186-cip37-12-g2710acbceb751
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip baseline: 147 runs,
 38 regressions (v5.10.186-cip37-12-g2710acbceb751)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Jul 2023 20:38:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12504

cip/linux-5.10.y-cip baseline: 147 runs, 38 regressions (v5.10.186-cip37-12=
-g2710acbceb751)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig           | 1          =

bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | bcm283=
5_defconfig            | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig           | 1          =

fsl-ls1028a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

fsl-ls1088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

fsl-ls2088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

fsl-lx2160a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

imx6ul-14x14-evk             | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =

imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =

imx7ulp-evk                  | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =

juno-uboot                   | arm64  | lab-broonie     | gcc-10   | cip://=
5.10.y-...64_defconfig | 1          =

juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig+kselftest          | 1          =

mt8173-elm-hana              | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =

r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig+kselftest          | 1          =

r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

r8a77960-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

r8a77960-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig+kselftest          | 1          =

rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 4          =

rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.186-cip37-12-g2710acbceb751/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.186-cip37-12-g2710acbceb751
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      2710acbceb751c864f5fbbd3521374e60d9802fe =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c02784077554127f8ace44

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c02784077554127f8ace49
        failing since 192 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-07-25T19:50:18.633045  <8>[   13.227057] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11139075_1.4.2.3.1>

    2023-07-25T19:50:18.636646  + set +x

    2023-07-25T19:50:18.741742  #

    2023-07-25T19:50:18.743137  =


    2023-07-25T19:50:18.844899  / # #export SHELL=3D/bin/sh

    2023-07-25T19:50:18.845537  =


    2023-07-25T19:50:18.946778  / # export SHELL=3D/bin/sh. /lava-11139075/=
environment

    2023-07-25T19:50:18.947470  =


    2023-07-25T19:50:19.048740  / # . /lava-11139075/environment/lava-11139=
075/bin/lava-test-runner /lava-11139075/1

    2023-07-25T19:50:19.049908  =

 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c027cdb860efb63f8ace21

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c027cdb860efb63f8ace26
        failing since 192 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-07-25T19:51:26.554913  + set<8>[   12.172790] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11139072_1.4.2.3.1>

    2023-07-25T19:51:26.558148   +x

    2023-07-25T19:51:26.663259  / # #

    2023-07-25T19:51:26.765842  export SHELL=3D/bin/sh

    2023-07-25T19:51:26.766634  #

    2023-07-25T19:51:26.868182  / # export SHELL=3D/bin/sh. /lava-11139072/=
environment

    2023-07-25T19:51:26.868958  =


    2023-07-25T19:51:26.970571  / # . /lava-11139072/environment/lava-11139=
072/bin/lava-test-runner /lava-11139072/1

    2023-07-25T19:51:26.971768  =


    2023-07-25T19:51:26.974341  / # /lava-11139072/bin/lava-test-runner /la=
va-11139072/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64c028c24cc375ae308ace2e

  Results:     47 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline=
-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline=
-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c028c24cc375ae308ace61
        failing since 192 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-07-25T19:55:12.620201  + set +x
    2023-07-25T19:55:12.625175  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 9583_1.5.2.4=
.1>
    2023-07-25T19:55:12.740169  / # #
    2023-07-25T19:55:12.843141  export SHELL=3D/bin/sh
    2023-07-25T19:55:12.844009  #
    2023-07-25T19:55:12.945720  / # export SHELL=3D/bin/sh. /lava-9583/envi=
ronment
    2023-07-25T19:55:12.946547  =

    2023-07-25T19:55:13.048547  / # . /lava-9583/environment/lava-9583/bin/=
lava-test-runner /lava-9583/1
    2023-07-25T19:55:13.049902  =

    2023-07-25T19:55:13.056272  / # /lava-9583/bin/lava-test-runner /lava-9=
583/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | bcm283=
5_defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/64c026c300bc1333658ace87

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm/bcm2835_defconfig/gcc-10/lab-collabora/baselin=
e-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm/bcm2835_defconfig/gcc-10/lab-collabora/baselin=
e-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c026c300bc1333658ace8c
        new failure (last pass: v5.10.184-cip36-13-g8fae18103387)

    2023-07-25T19:48:31.722114  / # #

    2023-07-25T19:48:31.824356  export SHELL=3D/bin/sh

    2023-07-25T19:48:31.824560  #

    2023-07-25T19:48:31.925168  / # export SHELL=3D/bin/sh. /lava-11139022/=
environment

    2023-07-25T19:48:31.925423  =


    2023-07-25T19:48:32.026135  / # . /lava-11139022/environment/lava-11139=
022/bin/lava-test-runner /lava-11139022/1

    2023-07-25T19:48:32.026495  =


    2023-07-25T19:48:32.035434  / # /lava-11139022/bin/lava-test-runner /la=
va-11139022/1

    2023-07-25T19:48:32.145412  + export 'TESTRUN_ID=3D1_bootrr'

    2023-07-25T19:48:32.145569  + cd /lava-11139022/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64c029b55fb0fc8db78ace44

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline=
-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline=
-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c029b55fb0fc8db78ace6f
        failing since 192 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-07-25T19:59:11.023590  <8>[   18.678884] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9624_1.5.2.4.1>
    2023-07-25T19:59:11.132802  / # #
    2023-07-25T19:59:11.235515  export SHELL=3D/bin/sh
    2023-07-25T19:59:11.236191  #
    2023-07-25T19:59:11.337878  / # export SHELL=3D/bin/sh. /lava-9624/envi=
ronment
    2023-07-25T19:59:11.338942  =

    2023-07-25T19:59:11.441400  / # . /lava-9624/environment/lava-9624/bin/=
lava-test-runner /lava-9624/1
    2023-07-25T19:59:11.442815  =

    2023-07-25T19:59:11.447339  / # /lava-9624/bin/lava-test-runner /lava-9=
624/1
    2023-07-25T19:59:11.542078  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64c02b753313f71ee78ace1f

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-bea=
glebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-bea=
glebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c02b753313f71ee78ace22
        failing since 192 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-07-25T20:06:30.521223  + set +x
    2023-07-25T20:06:30.523286  <8>[   16.651580] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 989122_1.5.2.4.1>
    2023-07-25T20:06:30.632265  / # #
    2023-07-25T20:06:30.734172  export SHELL=3D/bin/sh
    2023-07-25T20:06:30.734670  #
    2023-07-25T20:06:30.836142  / # export SHELL=3D/bin/sh. /lava-989122/en=
vironment
    2023-07-25T20:06:30.836734  =

    2023-07-25T20:06:30.938165  / # . /lava-989122/environment/lava-989122/=
bin/lava-test-runner /lava-989122/1
    2023-07-25T20:06:30.938982  =

    2023-07-25T20:06:30.941047  / # /lava-989122/bin/lava-test-runner /lava=
-989122/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls1028a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c0291b6ead851a408ace72

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1028=
a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1028=
a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c0291b6ead851a408ace75
        failing since 134 days (last pass: v5.10.155-cip21, first fail: v5.=
10.173-cip28)

    2023-07-25T19:56:52.735830  [   23.121091] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1238171_1.5.2.4.1>
    2023-07-25T19:56:52.841103  =

    2023-07-25T19:56:52.942268  / # #export SHELL=3D/bin/sh
    2023-07-25T19:56:52.942690  =

    2023-07-25T19:56:53.043668  / # export SHELL=3D/bin/sh. /lava-1238171/e=
nvironment
    2023-07-25T19:56:53.044084  =

    2023-07-25T19:56:53.145055  / # . /lava-1238171/environment/lava-123817=
1/bin/lava-test-runner /lava-1238171/1
    2023-07-25T19:56:53.145719  =

    2023-07-25T19:56:53.149885  / # /lava-1238171/bin/lava-test-runner /lav=
a-1238171/1
    2023-07-25T19:56:53.168521  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls1088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c029184dd8a8e2278ace61

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1088=
a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1088=
a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c029184dd8a8e2278ace64
        failing since 192 days (last pass: v5.10.155-cip21, first fail: v5.=
10.162-cip24)

    2023-07-25T19:56:56.982627  + [   15.807678] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 1238170_1.5.2.4.1>
    2023-07-25T19:56:56.982920  set +x
    2023-07-25T19:56:57.088335  =

    2023-07-25T19:56:57.189597  / # #export SHELL=3D/bin/sh
    2023-07-25T19:56:57.190011  =

    2023-07-25T19:56:57.291009  / # export SHELL=3D/bin/sh. /lava-1238170/e=
nvironment
    2023-07-25T19:56:57.291449  =

    2023-07-25T19:56:57.392466  / # . /lava-1238170/environment/lava-123817=
0/bin/lava-test-runner /lava-1238170/1
    2023-07-25T19:56:57.393183  =

    2023-07-25T19:56:57.397320  / # /lava-1238170/bin/lava-test-runner /lav=
a-1238170/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls2088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c0293081b4d107488ace1f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088=
a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088=
a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c0293081b4d107488ace22
        failing since 13 days (last pass: v5.10.155-cip21, first fail: v5.1=
0.165-cip25)

    2023-07-25T19:57:26.798642  + [    9.777101] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 1238172_1.5.2.4.1>
    2023-07-25T19:57:26.798909  set +x
    2023-07-25T19:57:26.904124  =

    2023-07-25T19:57:27.005322  / # #export SHELL=3D/bin/sh
    2023-07-25T19:57:27.005740  =

    2023-07-25T19:57:27.106706  / # export SHELL=3D/bin/sh. /lava-1238172/e=
nvironment
    2023-07-25T19:57:27.107125  =

    2023-07-25T19:57:27.208115  / # . /lava-1238172/environment/lava-123817=
2/bin/lava-test-runner /lava-1238172/1
    2023-07-25T19:57:27.208799  =

    2023-07-25T19:57:27.212863  / # /lava-1238172/bin/lava-test-runner /lav=
a-1238172/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-lx2160a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c0292d41634191f68ace1c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160=
a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160=
a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c0292d41634191f68ace1f
        failing since 125 days (last pass: v5.10.154-cip20, first fail: v5.=
10.175-cip29)

    2023-07-25T19:57:15.526843  [   10.562954] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1238169_1.5.2.4.1>
    2023-07-25T19:57:15.632359  =

    2023-07-25T19:57:15.733643  / # #export SHELL=3D/bin/sh
    2023-07-25T19:57:15.734100  =

    2023-07-25T19:57:15.835073  / # export SHELL=3D/bin/sh. /lava-1238169/e=
nvironment
    2023-07-25T19:57:15.835510  =

    2023-07-25T19:57:15.936490  / # . /lava-1238169/environment/lava-123816=
9/bin/lava-test-runner /lava-1238169/1
    2023-07-25T19:57:15.937174  =

    2023-07-25T19:57:15.941188  / # /lava-1238169/bin/lava-test-runner /lav=
a-1238169/1
    2023-07-25T19:57:15.955366  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c027974276dcbef98ace22

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c027974276dcbef98ace27
        failing since 102 days (last pass: v5.10.176-cip30, first fail: v5.=
10.177-cip31)

    2023-07-25T19:51:07.170778  + set +x

    2023-07-25T19:51:07.177400  <8>[   12.130660] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11139066_1.4.2.3.1>

    2023-07-25T19:51:07.281569  / # #

    2023-07-25T19:51:07.382354  export SHELL=3D/bin/sh

    2023-07-25T19:51:07.382806  #

    2023-07-25T19:51:07.483778  / # export SHELL=3D/bin/sh. /lava-11139066/=
environment

    2023-07-25T19:51:07.484163  =


    2023-07-25T19:51:07.585068  / # . /lava-11139066/environment/lava-11139=
066/bin/lava-test-runner /lava-11139066/1

    2023-07-25T19:51:07.586130  =


    2023-07-25T19:51:08.777907  / # /lava-11139066/bin/lava-test-runner /la=
va-11139066/1
 =

    ... (19 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c027a56e6cebd1d18ace43

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c027a56e6cebd1d18ace48
        failing since 102 days (last pass: v5.10.176-cip30, first fail: v5.=
10.177-cip31)

    2023-07-25T19:50:52.456562  <8>[   11.627966] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11139059_1.4.2.3.1>

    2023-07-25T19:50:52.459690  + set +x

    2023-07-25T19:50:52.560877  /#

    2023-07-25T19:50:52.661704   # #export SHELL=3D/bin/sh

    2023-07-25T19:50:52.661903  =


    2023-07-25T19:50:52.762384  / # export SHELL=3D/bin/sh. /lava-11139059/=
environment

    2023-07-25T19:50:52.762628  =


    2023-07-25T19:50:52.863239  / # . /lava-11139059/environment/lava-11139=
059/bin/lava-test-runner /lava-11139059/1

    2023-07-25T19:50:52.863530  =


    2023-07-25T19:50:52.868526  / # /lava-11139059/bin/lava-test-runner /la=
va-11139059/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64c0298393a33b7e038ace4b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c0298393a33b7e038ace50
        failing since 192 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-07-25T19:59:08.090405  / # #

    2023-07-25T19:59:08.192636  export SHELL=3D/bin/sh

    2023-07-25T19:59:08.193342  #

    2023-07-25T19:59:08.294813  / # export SHELL=3D/bin/sh. /lava-11139148/=
environment

    2023-07-25T19:59:08.295523  =


    2023-07-25T19:59:08.397040  / # . /lava-11139148/environment/lava-11139=
148/bin/lava-test-runner /lava-11139148/1

    2023-07-25T19:59:08.398180  =


    2023-07-25T19:59:08.414548  / # /lava-11139148/bin/lava-test-runner /la=
va-11139148/1

    2023-07-25T19:59:08.512537  + export 'TESTRUN_ID=3D1_bootrr'

    2023-07-25T19:59:08.513052  + cd /lava-11139148/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64c0282c69caebe0978ace5c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/bas=
eline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/bas=
eline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c0282c69caebe0978ace61
        failing since 192 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-07-25T19:53:07.565430  + set +x
    2023-07-25T19:53:07.565595  [   10.370102] <LAVA_SIGNAL_ENDRUN 0_dmesg =
996079_1.5.2.3.1>
    2023-07-25T19:53:07.673887  / # #
    2023-07-25T19:53:07.775530  export SHELL=3D/bin/sh
    2023-07-25T19:53:07.775993  #
    2023-07-25T19:53:07.877221  / # export SHELL=3D/bin/sh. /lava-996079/en=
vironment
    2023-07-25T19:53:07.877602  =

    2023-07-25T19:53:07.978807  / # . /lava-996079/environment/lava-996079/=
bin/lava-test-runner /lava-996079/1
    2023-07-25T19:53:07.979380  =

    2023-07-25T19:53:07.982024  / # /lava-996079/bin/lava-test-runner /lava=
-996079/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64c029948ce66169848ace92

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/base=
line-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/base=
line-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c029948ce66169848ace97
        failing since 192 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-07-25T19:59:06.708322  + set[    7.240865] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 996088_1.5.2.3.1>
    2023-07-25T19:59:06.708486   +x
    2023-07-25T19:59:06.814677  / # #
    2023-07-25T19:59:06.916307  export SHELL=3D/bin/sh
    2023-07-25T19:59:06.916853  #
    2023-07-25T19:59:07.018264  / # export SHELL=3D/bin/sh. /lava-996088/en=
vironment
    2023-07-25T19:59:07.018667  =

    2023-07-25T19:59:07.119946  / # . /lava-996088/environment/lava-996088/=
bin/lava-test-runner /lava-996088/1
    2023-07-25T19:59:07.120548  =

    2023-07-25T19:59:07.123015  / # /lava-996088/bin/lava-test-runner /lava=
-996088/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6ul-14x14-evk             | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64c02a6b4dd7aaa7f38acf66

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx=
6ul-14x14-evk.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx=
6ul-14x14-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c02a6b4dd7aaa7f38acf69
        failing since 125 days (last pass: v5.10.145-cip17, first fail: v5.=
10.175-cip29)

    2023-07-25T20:02:24.016304  + set +x
    2023-07-25T20:02:24.019465  <8>[   29.327129] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1238179_1.5.2.4.1>
    2023-07-25T20:02:24.130609  / # #
    2023-07-25T20:02:25.286105  export SHELL=3D/bin/sh
    2023-07-25T20:02:25.291688  #
    2023-07-25T20:02:26.832864  / # export SHELL=3D/bin/sh. /lava-1238179/e=
nvironment
    2023-07-25T20:02:26.838682  =

    2023-07-25T20:02:29.650081  / # . /lava-1238179/environment/lava-123817=
9/bin/lava-test-runner /lava-1238179/1
    2023-07-25T20:02:29.656114  =

    2023-07-25T20:02:29.656757  / # /lava-1238179/bin/lava-test-runner /lav=
a-1238179/1 =

    ... (18 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64c029bb55207b4c738ace29

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx=
7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx=
7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c029bb55207b4c738ace2c
        failing since 192 days (last pass: v5.10.155-cip21, first fail: v5.=
10.162-cip24)

    2023-07-25T19:59:26.308888  / # #
    2023-07-25T19:59:27.464949  export SHELL=3D/bin/sh
    2023-07-25T19:59:27.470588  #
    2023-07-25T19:59:29.012189  / # export SHELL=3D/bin/sh. /lava-1238177/e=
nvironment
    2023-07-25T19:59:29.017798  =

    2023-07-25T19:59:31.829279  / # . /lava-1238177/environment/lava-123817=
7/bin/lava-test-runner /lava-1238177/1
    2023-07-25T19:59:31.835271  =

    2023-07-25T19:59:31.848463  / # /lava-1238177/bin/lava-test-runner /lav=
a-1238177/1
    2023-07-25T19:59:31.934944  + export 'TESTRUN_ID=3D1_bootrr'
    2023-07-25T19:59:31.935298  + cd /lava-1238177/1/tests/1_bootrr =

    ... (19 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7ulp-evk                  | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64c029cc55207b4c738ace44

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx=
7ulp-evk.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx=
7ulp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c029cc55207b4c738ace47
        failing since 134 days (last pass: v5.10.155-cip21, first fail: v5.=
10.173-cip28)

    2023-07-25T19:59:43.490320  + set +x<8>[   28.979346] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 1238178_1.5.2.4.1>
    2023-07-25T19:59:43.490576  =

    2023-07-25T19:59:43.599156  / # #
    2023-07-25T19:59:44.754352  export SHELL=3D/bin/sh
    2023-07-25T19:59:44.759999  #
    2023-07-25T19:59:44.760318  / # export SHELL=3D/bin/sh
    2023-07-25T19:59:46.302056  / # . /lava-1238178/environment
    2023-07-25T19:59:49.118815  /lava-1238178/bin/lava-test-runner /lava-12=
38178/1
    2023-07-25T19:59:49.124820  . /lava-1238178/environment
    2023-07-25T19:59:49.125065  / # /lava-1238178/bin/lava-test-runner /lav=
a-1238178/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
juno-uboot                   | arm64  | lab-broonie     | gcc-10   | cip://=
5.10.y-...64_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/64c02a524dd7aaa7f38acf13

  Results:     47 PASS, 13 FAIL, 1 SKIP
  Full config: cip://5.10.y-cip/arm64/qemu_arm64_defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm64/cip---5.10.y-cip-arm64-qemu_arm64_defconfig/=
gcc-10/lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm64/cip---5.10.y-cip-arm64-qemu_arm64_defconfig/=
gcc-10/lab-broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c02a524dd7aaa7f38acf4c
        new failure (last pass: v5.10.184-cip36-13-g8fae18103387)

    2023-07-25T20:01:50.838409  / # #
    2023-07-25T20:01:50.941316  export SHELL=3D/bin/sh
    2023-07-25T20:01:50.942113  #
    2023-07-25T20:01:51.044096  / # export SHELL=3D/bin/sh. /lava-9607/envi=
ronment
    2023-07-25T20:01:51.044913  =

    2023-07-25T20:01:51.146871  / # . /lava-9607/environment/lava-9607/bin/=
lava-test-runner /lava-9607/1
    2023-07-25T20:01:51.148216  =

    2023-07-25T20:01:51.162669  / # /lava-9607/bin/lava-test-runner /lava-9=
607/1
    2023-07-25T20:01:51.218472  + export 'TESTRUN_ID=3D1_bootrr'
    2023-07-25T20:01:51.218987  + cd /lava-9607/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c0296241634191f68ace4f

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-u=
boot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-u=
boot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c0296241634191f68ace88
        new failure (last pass: v5.10.184-cip36-13-g8fae18103387)

    2023-07-25T19:57:51.740160  / # #
    2023-07-25T19:57:51.843132  export SHELL=3D/bin/sh
    2023-07-25T19:57:51.843935  #
    2023-07-25T19:57:51.945786  / # export SHELL=3D/bin/sh. /lava-9603/envi=
ronment
    2023-07-25T19:57:51.946641  =

    2023-07-25T19:57:52.048654  / # . /lava-9603/environment/lava-9603/bin/=
lava-test-runner /lava-9603/1
    2023-07-25T19:57:52.050030  =

    2023-07-25T19:57:52.063102  / # /lava-9603/bin/lava-test-runner /lava-9=
603/1
    2023-07-25T19:57:52.122935  + export 'TESTRUN_ID=3D1_bootrr'
    2023-07-25T19:57:52.123496  + cd /lava-9603/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64c02b6a4c742c42998ace1c

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm64/defconfig+kselftest/gcc-10/lab-broonie/basel=
ine-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm64/defconfig+kselftest/gcc-10/lab-broonie/basel=
ine-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c02b6a4c742c42998ace58
        new failure (last pass: v5.10.184-cip36-13-g8fae18103387)

    2023-07-25T20:06:27.352599  / ##
    2023-07-25T20:06:27.455530  export SHELL=3D/bin/sh
    2023-07-25T20:06:27.456287   #
    2023-07-25T20:06:27.558203  / # export SHELL=3D/bin/sh. /lava-9629/envi=
ronment
    2023-07-25T20:06:27.558934  =

    2023-07-25T20:06:27.660954  / # . /lava-9629/environment/lava-9629/bin/=
lava-test-runner /lava-9629/1
    2023-07-25T20:06:27.662217  =

    2023-07-25T20:06:27.677569  / # /lava-9629/bin/lava-test-runner /lava-9=
629/1
    2023-07-25T20:06:27.805490  + export 'TESTRUN_ID=3D1_bootrr'
    2023-07-25T20:06:27.849307  + cd /lava-9629/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64c02c0c56aa05479d8ace32

  Results:     28 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm64/defconfig+arm64-chromebook/gcc-10/lab-collab=
ora/baseline-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm64/defconfig+arm64-chromebook/gcc-10/lab-collab=
ora/baseline-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c02c0c56aa05479d8ace4e
        failing since 192 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-07-25T20:09:43.590259  + set +x

    2023-07-25T20:09:43.594433  <8>[   15.580196] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11139201_1.5.2.3.1>

    2023-07-25T20:09:43.702817  / # #

    2023-07-25T20:09:43.805454  export SHELL=3D/bin/sh

    2023-07-25T20:09:43.806222  #

    2023-07-25T20:09:43.907984  / # export SHELL=3D/bin/sh. /lava-11139201/=
environment

    2023-07-25T20:09:43.908743  =


    2023-07-25T20:09:44.010630  / # . /lava-11139201/environment/lava-11139=
201/bin/lava-test-runner /lava-11139201/1

    2023-07-25T20:09:44.011866  =


    2023-07-25T20:09:44.013827  / # /lava-11139201/bin/lava-test-runner /la=
va-11139201/1
 =

    ... (21 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64c029b14b9b87a1948ace35

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a=
7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a=
7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64c029b14b9b87a1948ac=
e36
        failing since 50 days (last pass: v5.10.180-cip34, first fail: v5.1=
0.180-cip34-19-gf0f6960f132cd) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64c030f4471d343bfa8ace1c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ba=
seline-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ba=
seline-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c030f4471d343bfa8ace1f
        new failure (last pass: v5.10.184-cip36-13-g8fae18103387)

    2023-07-25T20:30:13.931465  + set +x
    2023-07-25T20:30:13.931684  <8>[   83.697505] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 989134_1.5.2.4.1>
    2023-07-25T20:30:14.038003  / # #
    2023-07-25T20:30:15.500443  export SHELL=3D/bin/sh
    2023-07-25T20:30:15.521014  #
    2023-07-25T20:30:15.521222  / # export SHELL=3D/bin/sh
    2023-07-25T20:30:17.407344  / # . /lava-989134/environment
    2023-07-25T20:30:20.867162  /lava-989134/bin/lava-test-runner /lava-989=
134/1
    2023-07-25T20:30:20.887948  . /lava-989134/environment
    2023-07-25T20:30:20.888059  / # /lava-989134/bin/lava-test-runner /lava=
-989134/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64c02d0fa4a2a829d18ace29

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ba=
seline-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ba=
seline-r8a774b1-hihope-rzg2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c02d0fa4a2a829d18ace2c
        new failure (last pass: v5.10.184-cip36-13-g8fae18103387)

    2023-07-25T20:13:34.991502  + set +x
    2023-07-25T20:13:34.991716  <8>[   83.985362] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 989133_1.5.2.4.1>
    2023-07-25T20:13:35.097560  / # #
    2023-07-25T20:13:36.560454  export SHELL=3D/bin/sh
    2023-07-25T20:13:36.581026  #
    2023-07-25T20:13:36.581234  / # export SHELL=3D/bin/sh
    2023-07-25T20:13:38.465449  / # . /lava-989133/environment
    2023-07-25T20:13:41.924032  /lava-989133/bin/lava-test-runner /lava-989=
133/1
    2023-07-25T20:13:41.944824  . /lava-989133/environment
    2023-07-25T20:13:41.944935  / # /lava-989133/bin/lava-test-runner /lava=
-989133/1 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c029240aa6aa3c4e8ace1e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-e=
k874.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-e=
k874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c029240aa6aa3c4e8ace21
        new failure (last pass: v5.10.184-cip36-13-g8fae18103387)

    2023-07-25T19:56:58.252190  / # #
    2023-07-25T19:56:59.715945  export SHELL=3D/bin/sh
    2023-07-25T19:56:59.736641  #
    2023-07-25T19:56:59.736850  / # export SHELL=3D/bin/sh
    2023-07-25T19:57:01.622574  / # . /lava-989109/environment
    2023-07-25T19:57:05.080335  /lava-989109/bin/lava-test-runner /lava-989=
109/1
    2023-07-25T19:57:05.101131  . /lava-989109/environment
    2023-07-25T19:57:05.101240  / # /lava-989109/bin/lava-test-runner /lava=
-989109/1
    2023-07-25T19:57:05.180788  + export 'TESTRUN_ID=3D1_bootrr'
    2023-07-25T19:57:05.181008  + cd /lava-989109/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64c02a654dd7aaa7f38acf59

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-=
r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-=
r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c02a654dd7aaa7f38acf5c
        new failure (last pass: v5.10.184-cip36-13-g8fae18103387)

    2023-07-25T20:02:27.711855  / # #
    2023-07-25T20:02:29.175023  export SHELL=3D/bin/sh
    2023-07-25T20:02:29.195459  #
    2023-07-25T20:02:29.195581  / # export SHELL=3D/bin/sh
    2023-07-25T20:02:31.079373  / # . /lava-989128/environment
    2023-07-25T20:02:34.536548  /lava-989128/bin/lava-test-runner /lava-989=
128/1
    2023-07-25T20:02:34.557134  . /lava-989128/environment
    2023-07-25T20:02:34.557243  / # /lava-989128/bin/lava-test-runner /lava=
-989128/1
    2023-07-25T20:02:34.738954  + export 'TESTRUN_ID=3D1_bootrr'
    2023-07-25T20:02:34.739169  + cd /lava-989128/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64c02ca9347a49a9628ace7d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ba=
seline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ba=
seline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c02ca9347a49a9628ace80
        new failure (last pass: v5.10.184-cip36-13-g8fae18103387)

    2023-07-25T20:12:00.941792  / # #
    2023-07-25T20:12:02.403932  export SHELL=3D/bin/sh
    2023-07-25T20:12:02.424437  #
    2023-07-25T20:12:02.424640  / # export SHELL=3D/bin/sh
    2023-07-25T20:12:04.309469  / # . /lava-989138/environment
    2023-07-25T20:12:07.766086  /lava-989138/bin/lava-test-runner /lava-989=
138/1
    2023-07-25T20:12:07.786811  . /lava-989138/environment
    2023-07-25T20:12:07.786921  / # /lava-989138/bin/lava-test-runner /lava=
-989138/1
    2023-07-25T20:12:07.822138  + export 'TESTRUN_ID=3D1_bootrr'
    2023-07-25T20:12:07.870355  + cd /lava-989138/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c028b74dd8a8e2278ace2a

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a7=
7960-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a7=
7960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c028b74dd8a8e2278ace2f
        new failure (last pass: v5.10.184-cip36-13-g8fae18103387)

    2023-07-25T19:56:57.428362  / # #

    2023-07-25T19:56:57.528808  export SHELL=3D/bin/sh

    2023-07-25T19:56:57.528928  #

    2023-07-25T19:56:57.629414  / # export SHELL=3D/bin/sh. /lava-11139112/=
environment

    2023-07-25T19:56:57.629531  =


    2023-07-25T19:56:57.730029  / # . /lava-11139112/environment/lava-11139=
112/bin/lava-test-runner /lava-11139112/1

    2023-07-25T19:56:57.730228  =


    2023-07-25T19:56:57.742090  / # /lava-11139112/bin/lava-test-runner /la=
va-11139112/1

    2023-07-25T19:56:57.795414  + export 'TESTRUN_ID=3D1_bootrr'

    2023-07-25T19:56:57.795489  + cd /lav<8>[   16.400280] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11139112_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64c029cf4cf74b822d8ace1d

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm64/defconfig+kselftest/gcc-10/lab-collabora/bas=
eline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm64/defconfig+kselftest/gcc-10/lab-collabora/bas=
eline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c029cf4cf74b822d8ace22
        new failure (last pass: v5.10.184-cip36-13-g8fae18103387)

    2023-07-25T20:01:37.019868  / # #

    2023-07-25T20:01:37.120837  export SHELL=3D/bin/sh

    2023-07-25T20:01:37.121501  #

    2023-07-25T20:01:37.222781  / # export SHELL=3D/bin/sh. /lava-11139162/=
environment

    2023-07-25T20:01:37.223472  =


    2023-07-25T20:01:37.324925  / # . /lava-11139162/environment/lava-11139=
162/bin/lava-test-runner /lava-11139162/1

    2023-07-25T20:01:37.325904  =


    2023-07-25T20:01:37.334011  / # /lava-11139162/bin/lava-test-runner /la=
va-11139162/1

    2023-07-25T20:01:37.442703  + export 'TESTRUN_ID=3D1_bootrr'

    2023-07-25T20:01:37.443179  + cd /lava-11139162/1/tests/1_bootrr
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 4          =


  Details:     https://kernelci.org/test/plan/id/64c029808ce66169848ace30

  Results:     63 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-i2c-present: https://kernelci.or=
g/test/case/id/64c029808ce66169848ace5f
        failing since 190 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-07-25T20:00:08.471299  FIRST,<8>[   18.608060] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>

    2023-07-25T20:00:08.473133   INC default to 1.

    2023-07-25T20:00:08.473517  =


    2023-07-25T20:00:08.476695  	-w	Pad to last with leading zeros

    2023-07-25T20:00:08.479262  	-s SEP	String separator

    2023-07-25T20:00:08.483094  /lava-11139141/1/../bin/lava-test-case

    2023-07-25T20:00:08.489143  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.

    2023-07-25T20:00:08.489361  =

   =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/64c029808ce66169848ace60
        failing since 190 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-07-25T20:00:08.448965  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC)<8=
>[   18.588924] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-07-25T20:00:08.450772   multi-call binary.

    2023-07-25T20:00:08.450992  =


    2023-07-25T20:00:08.455472  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-07-25T20:00:08.455691  =


    2023-07-25T20:00:08.460643  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/64c029808ce66169848ace61
        failing since 190 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-07-25T20:00:08.429810  /lava-11139141/1/../bin/lava-test-case<8>[ =
  18.571153] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-probed RE=
SULT=3Dpass>

    2023-07-25T20:00:08.429865  =

   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c029808ce66169848ace75
        failing since 190 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-07-25T19:59:56.368310  <8>[    6.509463] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-07-25T19:59:56.377890  + <8>[    6.521894] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11139141_1.5.2.3.1>

    2023-07-25T19:59:56.378430  set +x

    2023-07-25T19:59:56.484765  =


    2023-07-25T19:59:56.586356  / # #export SHELL=3D/bin/sh

    2023-07-25T19:59:56.587049  =


    2023-07-25T19:59:56.688436  / # export SHELL=3D/bin/sh. /lava-11139141/=
environment

    2023-07-25T19:59:56.689190  =


    2023-07-25T19:59:56.790634  / # . /lava-11139141/environment/lava-11139=
141/bin/lava-test-runner /lava-11139141/1

    2023-07-25T19:59:56.791678  =

 =

    ... (19 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64c02c20a1bffa06b58ace1d

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm64/defconfig+arm64-chromebook/gcc-10/lab-collab=
ora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm64/defconfig+arm64-chromebook/gcc-10/lab-collab=
ora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/64c02c20a1bffa06b58ace23
        failing since 125 days (last pass: v5.10.173-cip28, first fail: v5.=
10.175-cip29)

    2023-07-25T20:10:34.172915  <8>[   34.197761] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-07-25T20:10:35.196437  /lava-11139200/1/../bin/lava-test-case

    2023-07-25T20:10:35.207042  <8>[   35.233033] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/64c02c20a1bffa06b58ace24
        failing since 125 days (last pass: v5.10.173-cip28, first fail: v5.=
10.175-cip29)

    2023-07-25T20:10:34.161565  /lava-11139200/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c028dcfc3a671e0f8ace36

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i=
-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i=
-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c028dcfc3a671e0f8ace62
        failing since 192 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-07-25T19:55:47.128147  + set +x
    2023-07-25T19:55:47.132029  <8>[   17.107734] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9598_1.5.2.4.1>
    2023-07-25T19:55:47.242720  / # #
    2023-07-25T19:55:47.344721  export SHELL=3D/bin/sh
    2023-07-25T19:55:47.345250  #
    2023-07-25T19:55:47.447366  / # export SHELL=3D/bin/sh. /lava-9598/envi=
ronment
    2023-07-25T19:55:47.447819  =

    2023-07-25T19:55:47.549432  / # . /lava-9598/environment/lava-9598/bin/=
lava-test-runner /lava-9598/1
    2023-07-25T19:55:47.550396  =

    2023-07-25T19:55:47.554717  / # /lava-9598/bin/lava-test-runner /lava-9=
598/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c028b8302b70b5bf8ace28

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm64/defconfig/gcc-10/lab-collabora/baseline-sun5=
0i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm64/defconfig/gcc-10/lab-collabora/baseline-sun5=
0i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c028b8302b70b5bf8ace2d
        new failure (last pass: v5.10.184-cip36-13-g8fae18103387)

    2023-07-25T19:57:08.786744  / # #

    2023-07-25T19:57:08.887543  export SHELL=3D/bin/sh

    2023-07-25T19:57:08.888224  #

    2023-07-25T19:57:08.989570  / # export SHELL=3D/bin/sh. /lava-11139115/=
environment

    2023-07-25T19:57:08.990266  =


    2023-07-25T19:57:09.091631  / # . /lava-11139115/environment/lava-11139=
115/bin/lava-test-runner /lava-11139115/1

    2023-07-25T19:57:09.092705  =


    2023-07-25T19:57:09.100628  / # /lava-11139115/bin/lava-test-runner /la=
va-11139115/1

    2023-07-25T19:57:09.166569  + export 'TESTRUN_ID=3D1_bootrr'

    2023-07-25T19:57:09.167072  + cd /lava-1113911<8>[   18.359632] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11139115_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

