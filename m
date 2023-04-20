Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FF7C77B72
	for <webhook@archiver.kernel.org>; Thu, 20 Apr 2023 14:23:28 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
 by mx.groups.io with SMTP id smtpd.web10.9324.1682000606671684558
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 20 Apr 2023 07:23:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=nKXKSyIE;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.178, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-63b73203e0aso7245431b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 20 Apr 2023 07:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682000606; x=1684592606;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ednpWCmggIyQODuKrp7xm3MapKrvPxtukmUeQJeRWsw=;
        b=nKXKSyIEZzcuB7hv+AxEY2/2pS84gZBX2j6JjBZdpqnkYqQuJJjBXQYUe3rq96yD6e
         ZAVWoJ3MUMo8uNrx/v4m4GQXG1UpGYJRmKDTiorbcH2pKREaAky5BsNQ56y48KFm+Pds
         mkviHLnjUQ6V49O7g4hgrcSsXm1bTXmR5mWTTa9lO0UDuVK68Iyl87SW/xv+E499j+y5
         jySx2YvmjKeCWhE/NPL38VYAeTCYVeNxDAYlre1+8py/BUMdPRGcH2JQKMmjc9n1PuTL
         eTuFUciUG7ZF3Z1a3aZX54gQ6+Dvim2h3gIPxpqy9Qja/jvgEfSkX4imb6c298VmkD2g
         FFIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682000606; x=1684592606;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ednpWCmggIyQODuKrp7xm3MapKrvPxtukmUeQJeRWsw=;
        b=dsaDTPN3rOXhIyXG3mlM8eQQpaJJAwf1t6iKLAaAHZHftXkuTRtgV0af6oP3YbSspa
         EXqKfRnPby6PsgFwMr0T4cSPnjz6dZUF4qmLMnxMttMoBoGZxx3EjAW3DhYVCtUHW5e5
         zDldJ2soz941Ibk9REzEvcN9ZgM4eZS781zy6ExPMMiTHpo4DqRhSltSc9clTqL9AMmZ
         E31T9cSESMChnBASvHBCFne78EtUbq3SQ9zSJt5RcfA7OIghm0xdPnS9Pp8jSBPBd8mq
         LT8XpswIwXyW+VRvoD8yGv0blnQ1v4uHo1e2ngRbxEksXIjyc1ZsKo5IiuX6wR3ZHwp3
         La8Q==
X-Gm-Message-State: AAQBX9fqO/jFYYE3yywZnw+VWnzG8BI3QmWaQhbTgJXCMfOp4HbM8qBX
	q+vzjn4YH9fmXQM8GSzWYvRBXtdrcKEPsI2aIAx7veMo
X-Google-Smtp-Source: AKy350al+7jCHjyz3CiePPTUuaVmcI1+DPRU8htwcPpVYBl566IEkwt7+cL1YcZg9d77OOqHlVCFyA==
X-Received: by 2002:a17:90a:ea85:b0:246:7582:b76f with SMTP id h5-20020a17090aea8500b002467582b76fmr6952966pjz.0.1682000605047;
        Thu, 20 Apr 2023 07:23:25 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id lt24-20020a17090b355800b00247735d1463sm1262783pjb.39.2023.04.20.07.23.24
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 07:23:24 -0700 (PDT)
Message-ID: <64414adc.170a0220.f903c.2512@mx.google.com>
Date: Thu, 20 Apr 2023 07:23:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.19.280-cip96-59-g4b02e7efb967d
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 86 runs,
 20 regressions (v4.19.280-cip96-59-g4b02e7efb967d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Apr 2023 14:23:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11241

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 86 runs, 20 regression=
s (v4.19.280-cip96-59-g4b02e7efb967d)

Regressions Summary
-------------------

platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =

beaglebone-black          | arm    | lab-broonie     | gcc-10   | multi_v7_=
defconfig           | 1          =

beaglebone-black          | arm    | lab-cip         | gcc-10   | multi_v7_=
defconfig           | 1          =

dove-cubox                | arm    | lab-pengutronix | gcc-10   | mvebu_v7_=
defconfig           | 1          =

imx6q-sabrelite           | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 1          =

imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | imx_v6_v7=
_defconfig          | 1          =

imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | multi_v7_=
defconfig           | 1          =

imx6ul-14x14-evk          | arm    | lab-nxp         | gcc-10   | multi_v7_=
defconfig           | 1          =

imx7d-sdb                 | arm    | lab-nxp         | gcc-10   | multi_v7_=
defconfig           | 1          =

r8a7743-iwg20d-q7         | arm    | lab-cip         | gcc-10   | shmobile_=
defconfig           | 1          =

rk3288-veyron-jaq         | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 3          =

rk3399-gru-kevin          | arm64  | lab-collabora   | gcc-10   | defconfig=
+arm64-chromebook   | 2          =

sun50i-a64-pine64-plus    | arm64  | lab-broonie     | gcc-10   | defconfig=
                    | 1          =

sun50i-h6-pine-h64        | arm64  | lab-collabora   | gcc-10   | defconfig=
                    | 1          =

zynqmp-zcu102             | arm64  | lab-cip         | gcc-10   | defconfig=
                    | 1          =

zynqmp-zcu102             | arm64  | lab-cip         | gcc-10   | defconfig=
+arm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.280-cip96-59-g4b02e7efb967d/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.280-cip96-59-g4b02e7efb967d
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      4b02e7efb967d05ce70d86cf0c7bdfaba7678818 =



Test Regressions
---------------- =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6441438767503bb13c2e860b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-59-g4b02e7efb967d/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-59-g4b02e7efb967d/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6441438767503bb13c2e8610
        failing since 91 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-04-20T13:51:50.312123  <8>[    9.564186] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10062344_1.4.2.3.1>

    2023-04-20T13:51:50.315467  + set +x

    2023-04-20T13:51:50.419895  / # #

    2023-04-20T13:51:50.520831  export SHELL=3D/bin/sh

    2023-04-20T13:51:50.521063  #

    2023-04-20T13:51:50.622019  / # export SHELL=3D/bin/sh. /lava-10062344/=
environment

    2023-04-20T13:51:50.622210  =


    2023-04-20T13:51:50.723109  / # . /lava-10062344/environment/lava-10062=
344/bin/lava-test-runner /lava-10062344/1

    2023-04-20T13:51:50.723387  =


    2023-04-20T13:51:50.728608  / # /lava-10062344/bin/lava-test-runner /la=
va-10062344/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6441438633f7e1ea892e861f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-59-g4b02e7efb967d/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-59-g4b02e7efb967d/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6441438633f7e1ea892e8624
        failing since 91 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-04-20T13:52:00.930118  + set +x

    2023-04-20T13:52:00.936866  <8>[   12.259565] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10062350_1.4.2.3.1>

    2023-04-20T13:52:01.041449  / # #

    2023-04-20T13:52:01.142344  export SHELL=3D/bin/sh

    2023-04-20T13:52:01.142558  #

    2023-04-20T13:52:01.243437  / # export SHELL=3D/bin/sh. /lava-10062350/=
environment

    2023-04-20T13:52:01.243645  =


    2023-04-20T13:52:01.344585  / # . /lava-10062350/environment/lava-10062=
350/bin/lava-test-runner /lava-10062350/1

    2023-04-20T13:52:01.344859  =


    2023-04-20T13:52:01.349692  / # /lava-10062350/bin/lava-test-runner /la=
va-10062350/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
beaglebone-black          | arm    | lab-broonie     | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6441435181548a82e82e85f0

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-59-g4b02e7efb967d/arm/multi_v7_defconfig/gcc-1=
0/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-59-g4b02e7efb967d/arm/multi_v7_defconfig/gcc-1=
0/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6441435181548a82e82e861a
        failing since 91 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-04-20T13:50:29.978238  <8>[   16.919532] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 361621_1.5.2.4.1>
    2023-04-20T13:50:30.086294  / # #
    2023-04-20T13:50:30.188470  export SHELL=3D/bin/sh
    2023-04-20T13:50:30.189119  #
    2023-04-20T13:50:30.290968  / # export SHELL=3D/bin/sh. /lava-361621/en=
vironment
    2023-04-20T13:50:30.291517  =

    2023-04-20T13:50:30.393189  / # . /lava-361621/environment/lava-361621/=
bin/lava-test-runner /lava-361621/1
    2023-04-20T13:50:30.394117  =

    2023-04-20T13:50:30.398026  / # /lava-361621/bin/lava-test-runner /lava=
-361621/1
    2023-04-20T13:50:30.466043  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
beaglebone-black          | arm    | lab-cip         | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6441472815675e780a2e86cf

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-59-g4b02e7efb967d/arm/multi_v7_defconfig/gcc-1=
0/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-59-g4b02e7efb967d/arm/multi_v7_defconfig/gcc-1=
0/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6441472815675e780a2e86d2
        failing since 91 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-04-20T14:06:56.595417  <8>[    8.882915] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 910586_1.5.2.4.1>
    2023-04-20T14:06:56.705532  / # #
    2023-04-20T14:06:56.808067  export SHELL=3D/bin/sh
    2023-04-20T14:06:56.808787  #
    2023-04-20T14:06:56.910627  / # export SHELL=3D/bin/sh. /lava-910586/en=
vironment
    2023-04-20T14:06:56.911263  =

    2023-04-20T14:06:57.012857  / # . /lava-910586/environment/lava-910586/=
bin/lava-test-runner /lava-910586/1
    2023-04-20T14:06:57.013856  =

    2023-04-20T14:06:57.020517  / # /lava-910586/bin/lava-test-runner /lava=
-910586/1
    2023-04-20T14:06:57.086649  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
dove-cubox                | arm    | lab-pengutronix | gcc-10   | mvebu_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64413fc449a3a56e532e8737

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: mvebu_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-59-g4b02e7efb967d/arm/mvebu_v7_defconfig/gcc-1=
0/lab-pengutronix/baseline-dove-cubox.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-59-g4b02e7efb967d/arm/mvebu_v7_defconfig/gcc-1=
0/lab-pengutronix/baseline-dove-cubox.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64413fc449a3a56e532e873c
        failing since 91 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-04-20T13:35:47.727972  + set +x
    2023-04-20T13:35:47.728142  [    4.248038] <LAVA_SIGNAL_ENDRUN 0_dmesg =
932278_1.5.2.3.1>
    2023-04-20T13:35:47.834797  / # #
    2023-04-20T13:35:47.936487  export SHELL=3D/bin/sh
    2023-04-20T13:35:47.936944  #
    2023-04-20T13:35:48.038232  / # export SHELL=3D/bin/sh. /lava-932278/en=
vironment
    2023-04-20T13:35:48.038794  =

    2023-04-20T13:35:48.140335  / # . /lava-932278/environment/lava-932278/=
bin/lava-test-runner /lava-932278/1
    2023-04-20T13:35:48.141134  =

    2023-04-20T13:35:48.143688  / # /lava-932278/bin/lava-test-runner /lava=
-932278/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6q-sabrelite           | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6441432c1f0452eb072e860d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-59-g4b02e7efb967d/arm/multi_v7_defconfig/gcc-1=
0/lab-collabora/baseline-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-59-g4b02e7efb967d/arm/multi_v7_defconfig/gcc-1=
0/lab-collabora/baseline-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6441432c1f0452eb072e8612
        failing since 91 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-04-20T13:50:19.815982  / # #

    2023-04-20T13:50:19.918635  export SHELL=3D/bin/sh

    2023-04-20T13:50:19.919044  #

    2023-04-20T13:50:20.020700  / # export SHELL=3D/bin/sh. /lava-10062267/=
environment

    2023-04-20T13:50:20.021521  =


    2023-04-20T13:50:20.123733  / # . /lava-10062267/environment/lava-10062=
267/bin/lava-test-runner /lava-10062267/1

    2023-04-20T13:50:20.124990  =


    2023-04-20T13:50:20.139166  / # /lava-10062267/bin/lava-test-runner /la=
va-10062267/1

    2023-04-20T13:50:20.242231  + export 'TESTRUN_ID=3D1_bootrr'

    2023-04-20T13:50:20.242768  + cd /lava-10062267/1/tests/1_bo<8>[    9.2=
25958] <LAVA_SIGNAL_STARTRUN 1_bootrr 10062267_1.5.2.4.5>
 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | imx_v6_v7=
_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/644141cc7edc269de82e8604

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-59-g4b02e7efb967d/arm/imx_v6_v7_defconfig/gcc-=
10/lab-pengutronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-59-g4b02e7efb967d/arm/imx_v6_v7_defconfig/gcc-=
10/lab-pengutronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644141cc7edc269de82e8609
        failing since 91 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-04-20T13:44:33.810411  + set +x[    7.190226] <LAVA_SIGNAL_ENDRUN =
0_dmesg 932294_1.5.2.3.1>
    2023-04-20T13:44:33.810587  =

    2023-04-20T13:44:33.918332  / # #
    2023-04-20T13:44:34.019937  export SHELL=3D/bin/sh
    2023-04-20T13:44:34.020465  #
    2023-04-20T13:44:34.121743  / # export SHELL=3D/bin/sh. /lava-932294/en=
vironment
    2023-04-20T13:44:34.122261  =

    2023-04-20T13:44:34.223476  / # . /lava-932294/environment/lava-932294/=
bin/lava-test-runner /lava-932294/1
    2023-04-20T13:44:34.224106  =

    2023-04-20T13:44:34.226880  / # /lava-932294/bin/lava-test-runner /lava=
-932294/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/644142fbb53de9ef612e8641

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-59-g4b02e7efb967d/arm/multi_v7_defconfig/gcc-1=
0/lab-pengutronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-59-g4b02e7efb967d/arm/multi_v7_defconfig/gcc-1=
0/lab-pengutronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644142fbb53de9ef612e8646
        failing since 91 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-04-20T13:49:33.269397  + set +x
    2023-04-20T13:49:33.269933  [    4.886290] <LAVA_SIGNAL_ENDRUN 0_dmesg =
932303_1.5.2.3.1>
    2023-04-20T13:49:33.376805  / # #
    2023-04-20T13:49:33.478769  export SHELL=3D/bin/sh
    2023-04-20T13:49:33.479152  #
    2023-04-20T13:49:33.580313  / # export SHELL=3D/bin/sh. /lava-932303/en=
vironment
    2023-04-20T13:49:33.580685  =

    2023-04-20T13:49:33.681908  / # . /lava-932303/environment/lava-932303/=
bin/lava-test-runner /lava-932303/1
    2023-04-20T13:49:33.682651  =

    2023-04-20T13:49:33.684805  / # /lava-932303/bin/lava-test-runner /lava=
-932303/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6ul-14x14-evk          | arm    | lab-nxp         | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/644143db01fe845c7c2e85f4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-59-g4b02e7efb967d/arm/multi_v7_defconfig/gcc-1=
0/lab-nxp/baseline-imx6ul-14x14-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-59-g4b02e7efb967d/arm/multi_v7_defconfig/gcc-1=
0/lab-nxp/baseline-imx6ul-14x14-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644143db01fe845c7c2e85f9
        new failure (last pass: v4.19.259-cip82-57-ge54228ee5a88d)

    2023-04-20T13:52:45.159860  + set +x<8>[   22.938808] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 1204664_1.5.2.4.1>
    2023-04-20T13:52:45.160165  =

    2023-04-20T13:52:45.268950  =

    2023-04-20T13:52:46.428802  / # #export SHELL=3D/bin/sh
    2023-04-20T13:52:46.434495  =

    2023-04-20T13:52:46.434800  / # export SHELL=3D/bin/sh
    2023-04-20T13:52:47.981743  . /lava-1204664/environment
    2023-04-20T13:52:47.987216  / # . /lava-1204664/environment
    2023-04-20T13:52:50.808064  /lava-1204664/bin/lava-test-runner /lava-12=
04664/1
    2023-04-20T13:52:50.814080  / # /lava-1204664/bin/lava-test-runner /lav=
a-1204664/1 =

    ... (15 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx7d-sdb                 | arm    | lab-nxp         | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6441435781548a82e82e86bf

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-59-g4b02e7efb967d/arm/multi_v7_defconfig/gcc-1=
0/lab-nxp/baseline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-59-g4b02e7efb967d/arm/multi_v7_defconfig/gcc-1=
0/lab-nxp/baseline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6441435781548a82e82e86c4
        failing since 86 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.270-cip89-39-g43ce130174aa)

    2023-04-20T13:50:51.882229  / # #
    2023-04-20T13:50:53.041195  export SHELL=3D/bin/sh
    2023-04-20T13:50:53.046798  #
    2023-04-20T13:50:54.594226  / # export SHELL=3D/bin/sh. /lava-1204665/e=
nvironment
    2023-04-20T13:50:54.599939  =

    2023-04-20T13:50:57.422097  / # . /lava-1204665/environment/lava-120466=
5/bin/lava-test-runner /lava-1204665/1
    2023-04-20T13:50:57.428176  =

    2023-04-20T13:50:57.439462  / # /lava-1204665/bin/lava-test-runner /lav=
a-1204665/1
    2023-04-20T13:50:57.536640  + export 'TESTRUN_ID=3D1_bootrr'
    2023-04-20T13:50:57.537159  + cd /lava-1204665/1/tests/1_bootrr =

    ... (15 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
r8a7743-iwg20d-q7         | arm    | lab-cip         | gcc-10   | shmobile_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/644142db043d8281762e85e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-59-g4b02e7efb967d/arm/shmobile_defconfig/gcc-1=
0/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-59-g4b02e7efb967d/arm/shmobile_defconfig/gcc-1=
0/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644142db043d8281762e8=
5e7
        failing since 15 days (last pass: v4.19.276-cip93-5-g2eb2a953ab59, =
first fail: v4.19.279-cip95-86-g16c082d0be46) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
rk3288-veyron-jaq         | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 3          =


  Details:     https://kernelci.org/test/plan/id/6441432dbe9a57968c2e8682

  Results:     61 PASS, 8 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-59-g4b02e7efb967d/arm/multi_v7_defconfig/gcc-1=
0/lab-collabora/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-59-g4b02e7efb967d/arm/multi_v7_defconfig/gcc-1=
0/lab-collabora/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/6441432dbe9a57968c2e86b2
        failing since 89 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-04-20T13:50:08.534636   multi-call binary.

    2023-04-20T13:50:08.534869  =


    2023-04-20T13:50:08.548477  Usage: seq [-w] [-s SEP] [FIRST [INC]] LA<8=
>[   12.577496] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-cec-present RESULT=3Dfail>
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/6441432dbe9a57968c2e86b3
        failing since 89 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-04-20T13:50:08.512720  <8>[   12.541354] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>

    2023-04-20T13:50:08.530803  BusyBox v1.31.1 (2023-04-14 10:59:35 UTC)<8=
>[   12.558986] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6441432dbe9a57968c2e86c6
        failing since 89 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-04-20T13:50:04.685141  + <8>[    8.716217] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10062264_1.5.2.3.1>

    2023-04-20T13:50:04.685376  set +x

    2023-04-20T13:50:04.792960  =


    2023-04-20T13:50:04.895611  / # #export SHELL=3D/bin/sh

    2023-04-20T13:50:04.896434  =


    2023-04-20T13:50:04.998636  / # export SHELL=3D/bin/sh. /lava-10062264/=
environment

    2023-04-20T13:50:04.999508  =


    2023-04-20T13:50:05.101622  / # . /lava-10062264/environment/lava-10062=
264/bin/lava-test-runner /lava-10062264/1

    2023-04-20T13:50:05.102994  =


    2023-04-20T13:50:05.104988  / # /lava-10062264/bin/lava-test-runner /la=
va-10062264/1
 =

    ... (16 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora   | gcc-10   | defconfig=
+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64414518ea9e86dc2b2e8603

  Results:     77 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-59-g4b02e7efb967d/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-59-g4b02e7efb967d/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/64414518ea9e86dc2b2e8609
        failing since 37 days (last pass: v4.19.273-cip92-277-g507c8d80b9e2=
0, first fail: v4.19.276-cip93-5-g2eb2a953ab59)

    2023-04-20T13:58:33.077301  <8>[   36.331290] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-04-20T13:58:34.088902  /lava-10062461/1/../bin/lava-test-case

    2023-04-20T13:58:34.097622  <8>[   37.353201] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/64414518ea9e86dc2b2e860a
        failing since 37 days (last pass: v4.19.273-cip92-277-g507c8d80b9e2=
0, first fail: v4.19.276-cip93-5-g2eb2a953ab59)

    2023-04-20T13:58:32.054899  <8>[   35.308417] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-04-20T13:58:33.066152  /lava-10062461/1/../bin/lava-test-case
   =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
sun50i-a64-pine64-plus    | arm64  | lab-broonie     | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/644145abca86f62ff72e85e6

  Results:     23 PASS, 16 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-59-g4b02e7efb967d/arm64/defconfig/gcc-10/lab-b=
roonie/baseline-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-59-g4b02e7efb967d/arm64/defconfig/gcc-10/lab-b=
roonie/baseline-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644145abca86f62ff72e860c
        failing since 91 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-04-20T14:00:38.706412  <8>[   15.950838] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 361477_1.5.2.4.1>
    2023-04-20T14:00:38.813669  / # #
    2023-04-20T14:00:38.917736  export SHELL=3D/bin/sh
    2023-04-20T14:00:38.918694  #
    2023-04-20T14:00:39.020524  / # export SHELL=3D/bin/sh. /lava-361477/en=
vironment
    2023-04-20T14:00:39.021138  =

    2023-04-20T14:00:39.122586  / # . /lava-361477/environment/lava-361477/=
bin/lava-test-runner /lava-361477/1
    2023-04-20T14:00:39.123439  =

    2023-04-20T14:00:39.127715  / # /lava-361477/bin/lava-test-runner /lava=
-361477/1
    2023-04-20T14:00:39.159552  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
sun50i-h6-pine-h64        | arm64  | lab-collabora   | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64413ff80c658b7bb42e85e6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-59-g4b02e7efb967d/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-59-g4b02e7efb967d/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64413ff80c658b7bb42e85eb
        failing since 91 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-04-20T13:36:33.980359  / # #

    2023-04-20T13:36:34.082907  export SHELL=3D/bin/sh

    2023-04-20T13:36:34.083611  #

    2023-04-20T13:36:34.185392  / # export SHELL=3D/bin/sh. /lava-10061947/=
environment

    2023-04-20T13:36:34.186160  =


    2023-04-20T13:36:34.288016  / # . /lava-10061947/environment/lava-10061=
947/bin/lava-test-runner /lava-10061947/1

    2023-04-20T13:36:34.289100  =


    2023-04-20T13:36:34.304247  / # /lava-10061947/bin/lava-test-runner /la=
va-10061947/1

    2023-04-20T13:36:34.346115  + export 'TESTRUN_ID=3D1_bootrr'

    2023-04-20T13:36:34.362169  + cd /lava-1006194<8>[   15.636201] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 10061947_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
zynqmp-zcu102             | arm64  | lab-cip         | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64413fd8882c48b8902e85eb

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-59-g4b02e7efb967d/arm64/defconfig/gcc-10/lab-c=
ip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-59-g4b02e7efb967d/arm64/defconfig/gcc-10/lab-c=
ip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64413fd8882c48b8902e85ee
        failing since 91 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-04-20T13:36:03.738964  <8>[    3.758001] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 910558_1.5.2.4.1>
    2023-04-20T13:36:03.843803  / # #
    2023-04-20T13:36:03.945080  export SHELL=3D/bin/sh
    2023-04-20T13:36:03.945409  #
    2023-04-20T13:36:04.046415  / # export SHELL=3D/bin/sh. /lava-910558/en=
vironment
    2023-04-20T13:36:04.046647  =

    2023-04-20T13:36:04.147655  / # . /lava-910558/environment/lava-910558/=
bin/lava-test-runner /lava-910558/1
    2023-04-20T13:36:04.148056  =

    2023-04-20T13:36:04.150849  / # /lava-910558/bin/lava-test-runner /lava=
-910558/1
    2023-04-20T13:36:04.187802  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
zynqmp-zcu102             | arm64  | lab-cip         | gcc-10   | defconfig=
+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/644144107bb48ad5b52e861b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-59-g4b02e7efb967d/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-59-g4b02e7efb967d/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644144107bb48ad5b52e861e
        failing since 91 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-04-20T13:54:13.463228  + set +x
    2023-04-20T13:54:13.465152  <8>[    3.737348] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 910602_1.5.2.4.1>
    2023-04-20T13:54:13.570871  / # #
    2023-04-20T13:54:13.673066  export SHELL=3D/bin/sh
    2023-04-20T13:54:13.673561  #
    2023-04-20T13:54:13.774856  / # export SHELL=3D/bin/sh. /lava-910602/en=
vironment
    2023-04-20T13:54:13.775360  =

    2023-04-20T13:54:13.876761  / # . /lava-910602/environment/lava-910602/=
bin/lava-test-runner /lava-910602/1
    2023-04-20T13:54:13.877511  =

    2023-04-20T13:54:13.881258  / # /lava-910602/bin/lava-test-runner /lava=
-910602/1 =

    ... (13 line(s) more)  =

 =20

