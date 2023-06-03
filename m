Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C9FC77B7A
	for <webhook@archiver.kernel.org>; Sat,  3 Jun 2023 17:13:26 +0000 (UTC)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
 by mx.groups.io with SMTP id smtpd.web11.1541.1685812397568361814
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 03 Jun 2023 10:13:17 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=icIVGf2N;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.169, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-52cbd7d0c37so1808412a12.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 03 Jun 2023 10:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685812396; x=1688404396;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XILE8yO2s84UWQpiFcYLVsmQFxc5vZO4TcCFHVabe64=;
        b=icIVGf2NTo1wXtSdlMQaGo8sl8GBKoMXf8x89MgF09Tcvr4Bd69FnM3JZdYDN8Sztt
         ZuC4VgSVymIn4zvJehr8AMaAXb9h0g3qd+sMCIoSGOW9zkcid4xmNb+ajRYZ7IdJ0VtQ
         xKkQ2extZ1YLC4uLweMy50q84Mkf7/prxBN7nCocY0hvdOPqCOrzTYeVIkUiQnCj3f8x
         Jh6Qf+sm1C+uceaRNwlMzPTKtrJ0/WQG2lcfUIPcms3z/C9PysUA1ml+XWvCdhQNsLg2
         VvNMcxTh6ulMpKJMqvHtNkb0ujFTs7IJiEpXTz9n+dLc7BnJd7GBAQhNoTb6a7IC7s9q
         Va+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685812396; x=1688404396;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XILE8yO2s84UWQpiFcYLVsmQFxc5vZO4TcCFHVabe64=;
        b=Uc+TxNOgLtduuIx4mB72jcMt+KVlzaqop9UYP/7HWLDHTeKJwA3QPUR8YwlCLw80f/
         wCEELntInK6r6iCKi9zKNqjFyQu1qhGDJEKbCH/7AXwaLIngFDlSkdjTNNF6MtDz1r5h
         uTbr5EVK13yVHtheoJgHulNzvpH+ge+4ItxA3uPrjPjkQTGF5mO0Ybg87uJxNczHwjYl
         MmjJ4N5UgzrNmLNDh92ZacOyGjWCM5hArl4hlaCk9lmGnLWo2h/yM9BKRtFzlamcv3KX
         3ZS769LVYkRW6/ttuURZBUtBkgYBJrLI+HI/9k9tYy8EAqnfi7pqkqM6vPgxXQYP6XGa
         mjDw==
X-Gm-Message-State: AC+VfDyhGnZPtYXHdMBBDMl6I/3b1arqxsmrxUoxC1QqTwt08ipaf0M8
	5fL6z/KlHHMJMTpwQHRh4Oo9+0KuB3KYQqn1R7GxRg==
X-Google-Smtp-Source: ACHHUZ5PRMjA7rW1mQujbpyLqTRvpFvOfzm/QIlkSml1HbhrgGztOi4v4KWI3PM0ZD8Y2+Gba+Cqjw==
X-Received: by 2002:a05:6a20:3d02:b0:10b:26b9:57c3 with SMTP id y2-20020a056a203d0200b0010b26b957c3mr855120pzi.14.1685812395820;
        Sat, 03 Jun 2023 10:13:15 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z3-20020a170903018300b001b1a2bf5277sm3449393plg.39.2023.06.03.10.13.14
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jun 2023 10:13:15 -0700 (PDT)
Message-ID: <647b74ab.170a0220.ed87d.6325@mx.google.com>
Date: Sat, 03 Jun 2023 10:13:15 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.26-1281-g84d5372e0f31
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test baseline: 121 runs,
 16 regressions (v6.1.26-1281-g84d5372e0f31)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 03 Jun 2023 17:13:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11754

cip-gitlab/ci/pavel/linux-test baseline: 121 runs, 16 regressions (v6.1.26-=
1281-g84d5372e0f31)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | bcm283=
5_defconfig            | 1          =

bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =

fsl-ls1088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx7ulp-evk                  | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =

imx8mn-ddr4-evk              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 2          =

rk3399-rock-pi-4b            | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.26-1281-g84d5372e0f31/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.26-1281-g84d5372e0f31
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      84d5372e0f314fb85258229768641315d1a95773 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647b6680bde92e0b98f5de8f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1281-g84d5372e0f31/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1281-g84d5372e0f31/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647b6680bde92e0b98f5de98
        new failure (last pass: v4.19.280-cip95-rt30)

    2023-06-03T16:12:30.239629  + set<8>[   11.527530] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10575893_1.4.2.3.1>

    2023-06-03T16:12:30.240286   +x

    2023-06-03T16:12:30.348561  / # #

    2023-06-03T16:12:30.450882  export SHELL=3D/bin/sh

    2023-06-03T16:12:30.451588  #

    2023-06-03T16:12:30.553168  / # export SHELL=3D/bin/sh. /lava-10575893/=
environment

    2023-06-03T16:12:30.553872  =


    2023-06-03T16:12:30.655117  / # . /lava-10575893/environment/lava-10575=
893/bin/lava-test-runner /lava-10575893/1

    2023-06-03T16:12:30.655375  =


    2023-06-03T16:12:30.660026  / # /lava-10575893/bin/lava-test-runner /la=
va-10575893/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | bcm283=
5_defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/647b68c6db5a51347cf5de25

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1281-g84d5372e0f31/arm/bcm2835_defconfig/gcc-10/lab-collabora/base=
line-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1281-g84d5372e0f31/arm/bcm2835_defconfig/gcc-10/lab-collabora/base=
line-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647b68c6db5a51347cf5de2e
        new failure (last pass: v4.19.280-cip95-rt30)

    2023-06-03T16:22:09.654469  / # #

    2023-06-03T16:22:09.755155  export SHELL=3D/bin/sh

    2023-06-03T16:22:09.755400  #

    2023-06-03T16:22:09.855982  / # export SHELL=3D/bin/sh. /lava-10575993/=
environment

    2023-06-03T16:22:09.856257  =


    2023-06-03T16:22:09.956841  / # . /lava-10575993/environment/lava-10575=
993/bin/lava-test-runner /lava-10575993/1

    2023-06-03T16:22:09.957210  =


    2023-06-03T16:22:09.967813  / # /lava-10575993/bin/lava-test-runner /la=
va-10575993/1

    2023-06-03T16:22:10.084667  + export 'TESTRUN_ID=3D1_bootrr'

    2023-06-03T16:22:10.084855  + cd /lava-10575993/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647b69533ed1500945f5de37

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1281-g84d5372e0f31/arm/multi_v7_defconfig/gcc-10/lab-collabora/bas=
eline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1281-g84d5372e0f31/arm/multi_v7_defconfig/gcc-10/lab-collabora/bas=
eline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647b69533ed1500945f5d=
e38
        new failure (last pass: v4.19.280-cip95-rt30) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls1088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/647b6b21bc54ae2a38f5de8b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1281-g84d5372e0f31/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1=
088a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1281-g84d5372e0f31/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1=
088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647b6b21bc54ae2a38f5de92
        new failure (last pass: v4.19.280-cip95-rt30)

    2023-06-03T16:32:06.735897  + [   19.350139] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 1232991_1.5.2.4.1>
    2023-06-03T16:32:06.736165  set +x
    2023-06-03T16:32:06.841752  / # #
    2023-06-03T16:32:06.943586  export SHELL=3D/bin/sh
    2023-06-03T16:32:06.944029  #
    2023-06-03T16:32:07.045374  / # export SHELL=3D/bin/sh. /lava-1232991/e=
nvironment
    2023-06-03T16:32:07.045817  =

    2023-06-03T16:32:07.147198  / # . /lava-1232991/environment/lava-123299=
1/bin/lava-test-runner /lava-1232991/1
    2023-06-03T16:32:07.147912  =

    2023-06-03T16:32:07.149879  / # /lava-1232991/bin/lava-test-runner /lav=
a-1232991/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647b66b3a6e548f0dff5de79

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1281-g84d5372e0f31/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1281-g84d5372e0f31/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647b66b3a6e548f0dff5de82
        new failure (last pass: v4.19.280-cip95-rt30)

    2023-06-03T16:13:24.531563  + set +x

    2023-06-03T16:13:24.538637  <8>[   11.320676] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10575897_1.4.2.3.1>

    2023-06-03T16:13:24.642936  / # #

    2023-06-03T16:13:24.743631  export SHELL=3D/bin/sh

    2023-06-03T16:13:24.743858  #

    2023-06-03T16:13:24.844426  / # export SHELL=3D/bin/sh. /lava-10575897/=
environment

    2023-06-03T16:13:24.844650  =


    2023-06-03T16:13:24.945228  / # . /lava-10575897/environment/lava-10575=
897/bin/lava-test-runner /lava-10575897/1

    2023-06-03T16:13:24.945545  =


    2023-06-03T16:13:24.950230  / # /lava-10575897/bin/lava-test-runner /la=
va-10575897/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647b667485650aa797f5de33

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1281-g84d5372e0f31/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1281-g84d5372e0f31/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647b667485650aa797f5de3c
        new failure (last pass: v4.19.280-cip95-rt30)

    2023-06-03T16:12:25.215987  <8>[   14.312605] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10575925_1.4.2.3.1>

    2023-06-03T16:12:25.219611  + set +x

    2023-06-03T16:12:25.325194  /#

    2023-06-03T16:12:25.427661   # #export SHELL=3D/bin/sh

    2023-06-03T16:12:25.428397  =


    2023-06-03T16:12:25.529693  / # export SHELL=3D/bin/sh. /lava-10575925/=
environment

    2023-06-03T16:12:25.530485  =


    2023-06-03T16:12:25.631881  / # . /lava-10575925/environment/lava-10575=
925/bin/lava-test-runner /lava-10575925/1

    2023-06-03T16:12:25.633150  =


    2023-06-03T16:12:25.638372  / # /lava-10575925/bin/lava-test-runner /la=
va-10575925/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647b667c8770d4e592f5de27

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1281-g84d5372e0f31/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1281-g84d5372e0f31/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647b667c8770d4e592f5de30
        new failure (last pass: v4.19.280-cip95-rt30)

    2023-06-03T16:12:20.491945  + set<8>[   11.442140] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10575964_1.4.2.3.1>

    2023-06-03T16:12:20.492731   +x

    2023-06-03T16:12:20.601031  / # #

    2023-06-03T16:12:20.701684  export SHELL=3D/bin/sh

    2023-06-03T16:12:20.702407  #

    2023-06-03T16:12:20.803862  / # export SHELL=3D/bin/sh. /lava-10575964/=
environment

    2023-06-03T16:12:20.804566  =


    2023-06-03T16:12:20.906165  / # . /lava-10575964/environment/lava-10575=
964/bin/lava-test-runner /lava-10575964/1

    2023-06-03T16:12:20.907633  =


    2023-06-03T16:12:20.911407  / # /lava-10575964/bin/lava-test-runner /la=
va-10575964/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647b688c7d9eccb42df5de71

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1281-g84d5372e0f31/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/b=
aseline-imx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1281-g84d5372e0f31/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/b=
aseline-imx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647b688c7d9eccb42df5de7a
        new failure (last pass: v4.19.280-cip95-rt30)

    2023-06-03T16:21:08.443757  + set +x
    2023-06-03T16:21:08.443931  [   12.840677] <LAVA_SIGNAL_ENDRUN 0_dmesg =
966656_1.5.2.3.1>
    2023-06-03T16:21:08.551793  / # #
    2023-06-03T16:21:08.653428  export SHELL=3D/bin/sh
    2023-06-03T16:21:08.653918  #
    2023-06-03T16:21:08.755260  / # export SHELL=3D/bin/sh. /lava-966656/en=
vironment
    2023-06-03T16:21:08.755748  =

    2023-06-03T16:21:08.857061  / # . /lava-966656/environment/lava-966656/=
bin/lava-test-runner /lava-966656/1
    2023-06-03T16:21:08.857755  =

    2023-06-03T16:21:08.861092  / # /lava-966656/bin/lava-test-runner /lava=
-966656/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647b6a2b8baec92cecf5de62

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1281-g84d5372e0f31/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/base=
line-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1281-g84d5372e0f31/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/base=
line-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647b6a2b8baec92cecf5d=
e63
        new failure (last pass: v4.19.280-cip95-rt30) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647b6a6b420c07564bf5de4c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1281-g84d5372e0f31/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/base=
line-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1281-g84d5372e0f31/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/base=
line-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647b6a6b420c07564bf5d=
e4d
        new failure (last pass: v4.19.280-cip95-rt30) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7ulp-evk                  | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647b6af497a4500e94f5de62

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1281-g84d5372e0f31/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-=
imx7ulp-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1281-g84d5372e0f31/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-=
imx7ulp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647b6af497a4500e94f5de69
        failing since 73 days (last pass: v5.10.145-rt74-1329-ga59fc50f38f6=
, first fail: v5.10.175-cip29-rt12)

    2023-06-03T16:31:34.684119  + set +x
    2023-06-03T16:31:34.685246  <8>[   33.467416] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1232989_1.5.2.4.1>
    2023-06-03T16:31:34.794598  / # #
    2023-06-03T16:31:35.954560  export SHELL=3D/bin/sh
    2023-06-03T16:31:35.960375  #
    2023-06-03T16:31:35.960742  / # export SHELL=3D/bin/sh
    2023-06-03T16:31:37.507307  / # . /lava-1232989/environment
    2023-06-03T16:31:40.334095  /lava-1232989/bin/lava-test-runner /lava-12=
32989/1
    2023-06-03T16:31:40.340201  . /lava-1232989/environment
    2023-06-03T16:31:40.340496  / # /lava-1232989/bin/lava-test-runner /lav=
a-1232989/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx8mn-ddr4-evk              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/647b6b0fbc54ae2a38f5de6e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1281-g84d5372e0f31/arm64/defconfig/gcc-10/lab-nxp/baseline-imx8mn-=
ddr4-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1281-g84d5372e0f31/arm64/defconfig/gcc-10/lab-nxp/baseline-imx8mn-=
ddr4-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647b6b0fbc54ae2a38f5de75
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935)

    2023-06-03T16:31:55.682311  / # #
    2023-06-03T16:31:56.842510  export SHELL=3D/bin/sh
    2023-06-03T16:31:56.848242  #
    2023-06-03T16:31:58.395876  / # export SHELL=3D/bin/sh. /lava-1232990/e=
nvironment
    2023-06-03T16:31:58.401581  =

    2023-06-03T16:32:01.223745  / # . /lava-1232990/environment/lava-123299=
0/bin/lava-test-runner /lava-1232990/1
    2023-06-03T16:32:01.229879  =

    2023-06-03T16:32:01.233674  / # /lava-1232990/bin/lava-test-runner /lav=
a-1232990/1
    2023-06-03T16:32:01.301690  + export 'TESTRUN_ID=3D1_bootrr'
    2023-06-03T16:32:01.302227  + cd /l<8>[   29.837654] <LAVA_SIGNAL_START=
RUN 1_bootrr 1232990_1.5.2.4.5> =

    ... (9 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647b666c8ffe44fd7df5de6d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1281-g84d5372e0f31/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1281-g84d5372e0f31/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647b666c8ffe44fd7df5de76
        new failure (last pass: v4.19.280-cip95-rt30)

    2023-06-03T16:12:18.023771  <8>[   12.704814] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10575953_1.4.2.3.1>

    2023-06-03T16:12:18.128224  / # #

    2023-06-03T16:12:18.228789  export SHELL=3D/bin/sh

    2023-06-03T16:12:18.228969  #

    2023-06-03T16:12:18.329441  / # export SHELL=3D/bin/sh. /lava-10575953/=
environment

    2023-06-03T16:12:18.329641  =


    2023-06-03T16:12:18.430139  / # . /lava-10575953/environment/lava-10575=
953/bin/lava-test-runner /lava-10575953/1

    2023-06-03T16:12:18.430446  =


    2023-06-03T16:12:18.434794  / # /lava-10575953/bin/lava-test-runner /la=
va-10575953/1

    2023-06-03T16:12:18.441684  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 2          =


  Details:     https://kernelci.org/test/plan/id/647b688a7d9eccb42df5de26

  Results:     66 PASS, 4 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1281-g84d5372e0f31/arm/multi_v7_defconfig/gcc-10/lab-collabora/bas=
eline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1281-g84d5372e0f31/arm/multi_v7_defconfig/gcc-10/lab-collabora/bas=
eline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/647b688a7d9eccb42df5de5a
        failing since 134 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-06-03T16:21:24.526768  Usage: seq [-w] [-s SEP] [FIRST [INC]] LA<8=
>[   19.608738] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-06-03T16:21:24.527012  ST

    2023-06-03T16:21:24.527078  =


    2023-06-03T16:21:24.532485  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-06-03T16:21:24.534841  FIRST, INC default to 1.

    2023-06-03T16:21:24.535064  =


    2023-06-03T16:21:24.538707  	-w	Pad to last with leading zeros
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/647b688a7d9eccb42df5de5b
        failing since 134 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-06-03T16:21:24.495583  <8>[   19.583401] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>

    2023-06-03T16:21:24.512367  BusyBox v1.31.1 (2023-05-27 14:14:16 UTC) m=
ulti-call binary.

    2023-06-03T16:21:24.512630  =

   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/647b69fe528e481ed9f5de4e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1281-g84d5372e0f31/arm64/defconfig/gcc-10/lab-collabora/baseline-r=
k3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1281-g84d5372e0f31/arm64/defconfig/gcc-10/lab-collabora/baseline-r=
k3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647b69fe528e481ed9f5de57
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935)

    2023-06-03T16:27:36.117637  / # #

    2023-06-03T16:27:36.219983  export SHELL=3D/bin/sh

    2023-06-03T16:27:36.220781  #

    2023-06-03T16:27:36.322669  / # export SHELL=3D/bin/sh. /lava-10576054/=
environment

    2023-06-03T16:27:36.323472  =


    2023-06-03T16:27:36.425290  / # . /lava-10576054/environment/lava-10576=
054/bin/lava-test-runner /lava-10576054/1

    2023-06-03T16:27:36.426625  =


    2023-06-03T16:27:36.440358  / # /lava-10576054/bin/lava-test-runner /la=
va-10576054/1

    2023-06-03T16:27:36.496440  + export 'TESTRUN_ID=3D1_bootrr'

    2023-06-03T16:27:36.496983  + cd /lava-10576054/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =20

