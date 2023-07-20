Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09E1EB64DC
	for <webhook@archiver.kernel.org>; Thu, 20 Jul 2023 12:48:05 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.web10.12087.1689857282206168575
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 20 Jul 2023 05:48:02 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=0+whit0n;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.182, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-666e3b15370so494624b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 20 Jul 2023 05:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689857281; x=1690462081;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MBxlCSlq8tWowQ0JXlHEdcaKoCRnmqlMwCvs9mZS0jY=;
        b=0+whit0nH0ue0FrNKyY/9sGPh6CnU4A4KBaPY0oIM40A8UJzMJZxw7VaTqdbs1L+6T
         rAJpRS6rgTcB7WObb+W7kwk/0E3AEJSJXMSSQKlUSTks+6cwnq4se30Gm4FgSqTakp2Y
         yx19JfJmhCSgwye2jJFUrBuKSyfuVoK/K4oN2+v6hGw9Xd5Z2Fl+1kbfI3MHMxJcCTQw
         tpXxeqLRqxh7oZ0WKPrEZXLkkRJSTSC07io+gwmeZEKkhoNaUBnX3rrexdQ56YjXf+xc
         N06RZ9I6BgfNAUBzPCSL1Xkcra6X5QTkGGauxm4KiYFGPpd9RtuDCc1rch+qC9WjwyMl
         jW6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689857281; x=1690462081;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MBxlCSlq8tWowQ0JXlHEdcaKoCRnmqlMwCvs9mZS0jY=;
        b=Z0eahdEAywmZ23jVDKu+sB8m6UqtggC8RJ6YVUYvYzMLye582lDidICAzuq7OBu3/I
         D4GIC8ZkwKCW2rvmmFXtcEIIhpTf2vKAR47NAys4HkX0LhHaOhmL+OuEfK4PnPyN6vjt
         kC9OsucnWz8SfsFjVl8Knuaz173vytcqj+x8rA3lyVg4ndsmmi47AQgqXWuM3YqJ4mP1
         lniR8pq9qbZ/xdk8pabDnVd2MfdYiVfW9cz/c4IF3eBW3yy2FiLqEDCBRbKXrwVqrbt0
         m8JVF/InFoJMXrdugemst6T0bLRK7uyRKfrisIIsN/I+QyUoPXxI73RQGvX+P7FdETRx
         Hz3A==
X-Gm-Message-State: ABy/qLZaSAWNcLaqUqaLAiRA0BbAFVsw7Cay3CsmhVj1wMKi7gNn/rtP
	OPVoVungn6kcSf8m7Qf5UqCq/R2p9bLy/rp+70mD5A==
X-Google-Smtp-Source: APBJJlFghDmljx+94krWiyhckxRneomFOdCSfC4jfleoPvKFMPcoZ8lwWE4rP89o5y4GNMm0zjot8A==
X-Received: by 2002:a05:6a20:7da9:b0:132:9d33:67a1 with SMTP id v41-20020a056a207da900b001329d3367a1mr8446584pzj.41.1689857280771;
        Thu, 20 Jul 2023 05:48:00 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id o11-20020a63a80b000000b005633778becasm795785pgf.41.2023.07.20.05.47.59
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 05:48:00 -0700 (PDT)
Message-ID: <64b92d00.630a0220.a948d.10d4@mx.google.com>
Date: Thu, 20 Jul 2023 05:48:00 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v6.1.38-cip1-13-ga3621452a4fc
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline: 64 runs,
 13 regressions (v6.1.38-cip1-13-ga3621452a4fc)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Jul 2023 12:48:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12466

cip-gitlab/ci/pavel/linux-test baseline: 64 runs, 13 regressions (v6.1.38-c=
ip1-13-ga3621452a4fc)

Regressions Summary
-------------------

platform          | arch | lab             | compiler | defconfig          =
 | regressions
------------------+------+-----------------+----------+--------------------=
-+------------
bcm2836-rpi-2-b   | arm  | lab-collabora   | gcc-10   | bcm2835_defconfig  =
 | 1          =

bcm2836-rpi-2-b   | arm  | lab-collabora   | gcc-10   | multi_v7_defconfig =
 | 1          =

beaglebone-black  | arm  | lab-broonie     | gcc-10   | omap2plus_defconfig=
 | 1          =

beaglebone-black  | arm  | lab-cip         | gcc-10   | omap2plus_defconfig=
 | 1          =

imx53-qsrb        | arm  | lab-pengutronix | gcc-10   | multi_v7_defconfig =
 | 1          =

imx6dl-udoo       | arm  | lab-broonie     | gcc-10   | imx_v6_v7_defconfig=
 | 1          =

imx6q-udoo        | arm  | lab-broonie     | gcc-10   | imx_v6_v7_defconfig=
 | 1          =

imx6ul-14x14-evk  | arm  | lab-nxp         | gcc-10   | imx_v6_v7_defconfig=
 | 1          =

imx7ulp-evk       | arm  | lab-nxp         | gcc-10   | imx_v6_v7_defconfig=
 | 1          =

imx7ulp-evk       | arm  | lab-nxp         | gcc-10   | multi_v7_defconfig =
 | 1          =

r8a7743-iwg20d-q7 | arm  | lab-cip         | gcc-10   | shmobile_defconfig =
 | 1          =

rk3288-veyron-jaq | arm  | lab-collabora   | gcc-10   | multi_v7_defconfig =
 | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.38-cip1-13-ga3621452a4fc/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.38-cip1-13-ga3621452a4fc
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      a3621452a4fc3c78df12c07b61aa0b03d9af5fec =



Test Regressions
---------------- =



platform          | arch | lab             | compiler | defconfig          =
 | regressions
------------------+------+-----------------+----------+--------------------=
-+------------
bcm2836-rpi-2-b   | arm  | lab-collabora   | gcc-10   | bcm2835_defconfig  =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/64b917e8be03450e288ace1c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-13-ga3621452a4fc/arm/bcm2835_defconfig/gcc-10/lab-collabora/b=
aseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-13-ga3621452a4fc/arm/bcm2835_defconfig/gcc-10/lab-collabora/b=
aseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b917e8be03450e288ace21
        failing since 0 day (last pass: v5.10.184-cip36-13-g8201543bbc8b6, =
first fail: v6.1.38-cip1-10-g02aa22be941dd)

    2023-07-20T11:19:18.589920  / # #

    2023-07-20T11:19:18.690856  export SHELL=3D/bin/sh

    2023-07-20T11:19:18.691560  #

    2023-07-20T11:19:18.792794  / # export SHELL=3D/bin/sh. /lava-11118386/=
environment

    2023-07-20T11:19:18.793047  =


    2023-07-20T11:19:18.893641  / # . /lava-11118386/environment/lava-11118=
386/bin/lava-test-runner /lava-11118386/1

    2023-07-20T11:19:18.894104  =


    2023-07-20T11:19:18.898698  / # /lava-11118386/bin/lava-test-runner /la=
va-11118386/1

    2023-07-20T11:19:18.978761  + export 'TESTRUN_ID=3D1_bootrr'

    2023-07-20T11:19:19.023106  + cd /lava-11118386/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform          | arch | lab             | compiler | defconfig          =
 | regressions
------------------+------+-----------------+----------+--------------------=
-+------------
bcm2836-rpi-2-b   | arm  | lab-collabora   | gcc-10   | multi_v7_defconfig =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/64b921e9fff160cd398ace6f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-13-ga3621452a4fc/arm/multi_v7_defconfig/gcc-10/lab-collabora/=
baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-13-ga3621452a4fc/arm/multi_v7_defconfig/gcc-10/lab-collabora/=
baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64b921e9fff160cd398ac=
e70
        failing since 35 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70) =

 =



platform          | arch | lab             | compiler | defconfig          =
 | regressions
------------------+------+-----------------+----------+--------------------=
-+------------
beaglebone-black  | arm  | lab-broonie     | gcc-10   | omap2plus_defconfig=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/64b9220188a624c7698ace34

  Results:     52 PASS, 3 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-13-ga3621452a4fc/arm/omap2plus_defconfig/gcc-10/lab-broonie/b=
aseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-13-ga3621452a4fc/arm/omap2plus_defconfig/gcc-10/lab-broonie/b=
aseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b9220188a624c7698ace6a
        failing since 35 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-07-20T12:00:46.785260  <8>[   18.030868] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 2890_1.5.2.4.1>
    2023-07-20T12:00:46.896959  / # #
    2023-07-20T12:00:46.999966  export SHELL=3D/bin/sh
    2023-07-20T12:00:47.000610  #
    2023-07-20T12:00:47.102245  / # export SHELL=3D/bin/sh. /lava-2890/envi=
ronment
    2023-07-20T12:00:47.102966  =

    2023-07-20T12:00:47.205054  / # . /lava-2890/environment/lava-2890/bin/=
lava-test-runner /lava-2890/1
    2023-07-20T12:00:47.206486  =

    2023-07-20T12:00:47.211193  / # /lava-2890/bin/lava-test-runner /lava-2=
890/1
    2023-07-20T12:00:47.327116  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform          | arch | lab             | compiler | defconfig          =
 | regressions
------------------+------+-----------------+----------+--------------------=
-+------------
beaglebone-black  | arm  | lab-cip         | gcc-10   | omap2plus_defconfig=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/64b9236b8bd0355f9a8ace22

  Results:     52 PASS, 3 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-13-ga3621452a4fc/arm/omap2plus_defconfig/gcc-10/lab-cip/basel=
ine-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-13-ga3621452a4fc/arm/omap2plus_defconfig/gcc-10/lab-cip/basel=
ine-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b9236b8bd0355f9a8ace25
        failing since 35 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-07-20T12:06:57.866104  <8>[   14.904685] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 987846_1.5.2.4.1>
    2023-07-20T12:06:57.975338  / # #
    2023-07-20T12:06:58.077764  export SHELL=3D/bin/sh
    2023-07-20T12:06:58.078474  #
    2023-07-20T12:06:58.180185  / # export SHELL=3D/bin/sh. /lava-987846/en=
vironment
    2023-07-20T12:06:58.180913  =

    2023-07-20T12:06:58.282707  / # . /lava-987846/environment/lava-987846/=
bin/lava-test-runner /lava-987846/1
    2023-07-20T12:06:58.283856  =

    2023-07-20T12:06:58.289955  / # /lava-987846/bin/lava-test-runner /lava=
-987846/1
    2023-07-20T12:06:58.404144  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform          | arch | lab             | compiler | defconfig          =
 | regressions
------------------+------+-----------------+----------+--------------------=
-+------------
imx53-qsrb        | arm  | lab-pengutronix | gcc-10   | multi_v7_defconfig =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/64b921aeede1699d8a8ace49

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-13-ga3621452a4fc/arm/multi_v7_defconfig/gcc-10/lab-pengutroni=
x/baseline-imx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-13-ga3621452a4fc/arm/multi_v7_defconfig/gcc-10/lab-pengutroni=
x/baseline-imx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b921aeede1699d8a8ace4e
        new failure (last pass: v5.10.186-cip37-2-gfcd111609480)

    2023-07-20T11:59:23.083316  + set +x
    2023-07-20T11:59:23.083486  [   12.805854] <LAVA_SIGNAL_ENDRUN 0_dmesg =
995825_1.5.2.3.1>
    2023-07-20T11:59:23.191090  / # #
    2023-07-20T11:59:23.292921  export SHELL=3D/bin/sh
    2023-07-20T11:59:23.293391  #
    2023-07-20T11:59:23.394636  / # export SHELL=3D/bin/sh. /lava-995825/en=
vironment
    2023-07-20T11:59:23.395116  =

    2023-07-20T11:59:23.496359  / # . /lava-995825/environment/lava-995825/=
bin/lava-test-runner /lava-995825/1
    2023-07-20T11:59:23.496995  =

    2023-07-20T11:59:23.500193  / # /lava-995825/bin/lava-test-runner /lava=
-995825/1 =

    ... (12 line(s) more)  =

 =



platform          | arch | lab             | compiler | defconfig          =
 | regressions
------------------+------+-----------------+----------+--------------------=
-+------------
imx6dl-udoo       | arm  | lab-broonie     | gcc-10   | imx_v6_v7_defconfig=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/64b921b5380f78fa818ace1d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-13-ga3621452a4fc/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/b=
aseline-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-13-ga3621452a4fc/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/b=
aseline-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64b921b5380f78fa818ac=
e1e
        failing since 35 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70) =

 =



platform          | arch | lab             | compiler | defconfig          =
 | regressions
------------------+------+-----------------+----------+--------------------=
-+------------
imx6q-udoo        | arm  | lab-broonie     | gcc-10   | imx_v6_v7_defconfig=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/64b921b67adaff43678ace1e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-13-ga3621452a4fc/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/b=
aseline-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-13-ga3621452a4fc/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/b=
aseline-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64b921b67adaff43678ac=
e1f
        failing since 35 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70) =

 =



platform          | arch | lab             | compiler | defconfig          =
 | regressions
------------------+------+-----------------+----------+--------------------=
-+------------
imx6ul-14x14-evk  | arm  | lab-nxp         | gcc-10   | imx_v6_v7_defconfig=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/64b921d67adaff43678ace68

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-13-ga3621452a4fc/arm/imx_v6_v7_defconfig/gcc-10/lab-nxp/basel=
ine-imx6ul-14x14-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-13-ga3621452a4fc/arm/imx_v6_v7_defconfig/gcc-10/lab-nxp/basel=
ine-imx6ul-14x14-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64b921d67adaff43678ac=
e69
        new failure (last pass: v5.10.186-cip37-2-gfcd111609480) =

 =



platform          | arch | lab             | compiler | defconfig          =
 | regressions
------------------+------+-----------------+----------+--------------------=
-+------------
imx7ulp-evk       | arm  | lab-nxp         | gcc-10   | imx_v6_v7_defconfig=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/64b921d27adaff43678ace5a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-13-ga3621452a4fc/arm/imx_v6_v7_defconfig/gcc-10/lab-nxp/basel=
ine-imx7ulp-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-13-ga3621452a4fc/arm/imx_v6_v7_defconfig/gcc-10/lab-nxp/basel=
ine-imx7ulp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64b921d27adaff43678ac=
e5b
        new failure (last pass: v5.10.186-cip37-2-gfcd111609480) =

 =



platform          | arch | lab             | compiler | defconfig          =
 | regressions
------------------+------+-----------------+----------+--------------------=
-+------------
imx7ulp-evk       | arm  | lab-nxp         | gcc-10   | multi_v7_defconfig =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/64b92273f0053f023f8ace20

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-13-ga3621452a4fc/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseli=
ne-imx7ulp-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-13-ga3621452a4fc/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseli=
ne-imx7ulp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b92273f0053f023f8ace23
        failing since 119 days (last pass: v5.10.145-rt74-1329-ga59fc50f38f=
6, first fail: v5.10.175-cip29-rt12)

    2023-07-20T12:02:35.873305  + set +x<8>[   33.510290] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 1237777_1.5.2.4.1>
    2023-07-20T12:02:35.873600  =

    2023-07-20T12:02:35.982288  / # #
    2023-07-20T12:02:37.138245  export SHELL=3D/bin/sh
    2023-07-20T12:02:37.143876  #
    2023-07-20T12:02:37.144203  / # export SHELL=3D/bin/sh
    2023-07-20T12:02:38.686181  / # . /lava-1237777/environment
    2023-07-20T12:02:41.503204  /lava-1237777/bin/lava-test-runner /lava-12=
37777/1
    2023-07-20T12:02:41.509173  . /lava-1237777/environment
    2023-07-20T12:02:41.509414  / # /lava-1237777/bin/lava-test-runner /lav=
a-1237777/1 =

    ... (12 line(s) more)  =

 =



platform          | arch | lab             | compiler | defconfig          =
 | regressions
------------------+------+-----------------+----------+--------------------=
-+------------
r8a7743-iwg20d-q7 | arm  | lab-cip         | gcc-10   | shmobile_defconfig =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/64b91fc85a5267da9a8ace25

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-13-ga3621452a4fc/arm/shmobile_defconfig/gcc-10/lab-cip/baseli=
ne-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-13-ga3621452a4fc/arm/shmobile_defconfig/gcc-10/lab-cip/baseli=
ne-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64b91fc85a5267da9a8ac=
e26
        failing since 10 days (last pass: v6.1.31-61-g32a95f5a4e3b, first f=
ail: v6.1.31-65-geef5a19d48f6) =

 =



platform          | arch | lab             | compiler | defconfig          =
 | regressions
------------------+------+-----------------+----------+--------------------=
-+------------
rk3288-veyron-jaq | arm  | lab-collabora   | gcc-10   | multi_v7_defconfig =
 | 2          =


  Details:     https://kernelci.org/test/plan/id/64b92199346d8b5cc08ace49

  Results:     66 PASS, 4 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-13-ga3621452a4fc/arm/multi_v7_defconfig/gcc-10/lab-collabora/=
baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-13-ga3621452a4fc/arm/multi_v7_defconfig/gcc-10/lab-collabora/=
baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/64b92199346d8b5cc08ace79
        failing since 181 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-07-20T12:00:50.729825  Usage: seq [-w] [-s SEP] [FIRST [INC]] LA<8=
>[   19.649933] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-07-20T12:00:50.729887  ST

    2023-07-20T12:00:50.730113  =


    2023-07-20T12:00:50.735124  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-07-20T12:00:50.737752  FIRST, INC default to 1.

    2023-07-20T12:00:50.737806  =


    2023-07-20T12:00:50.741346  	-w	Pad to last with leading zeros

    2023-07-20T12:00:50.743933  	-s SEP	String separator

    2023-07-20T12:00:50.747777  /lava-11118544/1/../bin/lava-test-case
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/64b92199346d8b5cc08ace7a
        failing since 181 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-07-20T12:00:50.702163  <8>[   19.628106] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>

    2023-07-20T12:00:50.715245  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.

    2023-07-20T12:00:50.715507  =

   =

 =20

