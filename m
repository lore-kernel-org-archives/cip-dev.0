Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF26DC46CA0
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 13:32:06 +0000 (UTC)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
 by mx.groups.io with SMTP id smtpd.web11.83616.1701955918358016625
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 07 Dec 2023 05:31:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=WQV0Jdt2;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.179, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5bdb0be3591so702863a12.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 07 Dec 2023 05:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701955917; x=1702560717; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9gdDgGNSMZclEMKaKqcBjUcdbHPqKQ84l+nbst3jkN8=;
        b=WQV0Jdt2y62Fqa4Zz33zUNs8UYqbmA6zSSDTt1tdZF+s4MIlDu8/OO50MG4nhoYTsi
         72pkcwSUrA35LxfQCQDln+Ki4bIsJmQjdIrmoxf3GsGWArE0oKFAe0b7FJsPtK7vQd8f
         l1vK2SnXc9ZQry1TkSy9P0GV4slZ+2dpkv69xHn93ROQft3gQ36JFfvZz3Ggpdw9pHSa
         bjQiHS9J8NtxG5JKOS2KXZ7bB/qsek7RBp9VlrYnMOykMLxJmiwU3VSODHXiFSGI1EDn
         3wfbsF18rh+QIX5DT/i1JrG0sntL2RVtDpUPCY3tK6DVUIl7YTw7/a3O9LEyRZSYTkZq
         WcJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701955917; x=1702560717;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9gdDgGNSMZclEMKaKqcBjUcdbHPqKQ84l+nbst3jkN8=;
        b=gGpLSAD/neuMfVqOv1IDx1qhNZhyWr2LVZ23z2oOKNGvwMhW8cG1dKNgOq9R9AkMAX
         r1EZV5JodyBv+VAnwYdZZDGghOGtfejtp7VJ0jL4MEGJHda/0HVjubI5mAON0hDVFFPC
         j8ayywTtoitvJYNE80XmezEoWSxaQV7PgZ5nrKyTbKfrBwGEqiiaj/3nxdWRxY0iC1/Q
         jeSq3LNwVZ+SJFaab9rPra3xPkuL9d3CLv6rXXNmV5Ls+LlDN81C7sXBwLJj6ha010t8
         O3oRqMbDiFCBsMBW1FKKLSdYfA5B9+TRqDaCRSbinhzG/bcIiwn4llyK3TkpdRr/YzOY
         kecg==
X-Gm-Message-State: AOJu0Yy74XZ2aoO90L/BzCfmxHOybX4DHKobrgs9xNGCWxHJGgA3ehCd
	7u2hXeq2IzKuCW+z1LNFegJrChg2GON8BvNeJw4xxw==
X-Google-Smtp-Source: AGHT+IFyT4BgKgLnWbVATAD3fy+IW4KsUH1g1yfqX4OYbpUkVft7Vg3TZwAA/JWJ1hgkslC7/3Kzgg==
X-Received: by 2002:a17:90a:c084:b0:286:6cc1:3eff with SMTP id o4-20020a17090ac08400b002866cc13effmr2714259pjs.54.1701955916949;
        Thu, 07 Dec 2023 05:31:56 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id g16-20020a17090a7d1000b002851c9f7a77sm1330706pjl.38.2023.12.07.05.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 05:31:55 -0800 (PST)
Message-ID: <6571c94b.170a0220.b188a.2be8@mx.google.com>
Date: Thu, 07 Dec 2023 05:31:55 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-16-g3c85fba3b6e5d
Subject: cip/linux-5.10.y-cip baseline: 114 runs,
 19 regressions (v5.10.201-cip41-16-g3c85fba3b6e5d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 13:32:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13842

cip/linux-5.10.y-cip baseline: 114 runs, 19 regressions (v5.10.201-cip41-16=
-g3c85fba3b6e5d)

Regressions Summary
-------------------

platform                 | arch  | lab             | compiler | defconfig  =
         | regressions
-------------------------+-------+-----------------+----------+------------=
---------+------------
at91sam9g20ek            | arm   | lab-broonie     | gcc-10   | multi_v5_de=
fconfig  | 1          =

bcm2836-rpi-2-b          | arm   | lab-collabora   | gcc-10   | bcm2835_def=
config   | 1          =

beaglebone-black         | arm   | lab-broonie     | gcc-10   | multi_v7_de=
fconfig  | 1          =

beaglebone-black         | arm   | lab-broonie     | gcc-10   | omap2plus_d=
efconfig | 1          =

imx6q-sabrelite          | arm   | lab-collabora   | gcc-10   | multi_v7_de=
fconfig  | 1          =

imx6qp-wandboard-revd1   | arm   | lab-pengutronix | gcc-10   | imx_v6_v7_d=
efconfig | 1          =

imx6qp-wandboard-revd1   | arm   | lab-pengutronix | gcc-10   | multi_v7_de=
fconfig  | 1          =

juno-uboot               | arm64 | lab-broonie     | gcc-10   | defconfig  =
         | 1          =

juno-uboot               | arm64 | lab-broonie     | gcc-10   | defconfig+k=
selftest | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip         | gcc-10   | defconfig+k=
selftest | 1          =

r8a774c0-ek874           | arm64 | lab-cip         | gcc-10   | defconfig  =
         | 1          =

r8a77960-ulcb            | arm64 | lab-collabora   | gcc-10   | defconfig  =
         | 1          =

rk3288-veyron-jaq        | arm   | lab-collabora   | gcc-10   | multi_v7_de=
fconfig  | 4          =

rk3399-rock-pi-4b        | arm64 | lab-collabora   | gcc-10   | defconfig  =
         | 1          =

sun50i-a64-pine64-plus   | arm64 | lab-broonie     | gcc-10   | defconfig  =
         | 1          =

sun50i-h6-pine-h64       | arm64 | lab-collabora   | gcc-10   | defconfig  =
         | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-16-g3c85fba3b6e5d/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-16-g3c85fba3b6e5d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      3c85fba3b6e5da8b112e7ecd142649674648028f =



Test Regressions
---------------- =



platform                 | arch  | lab             | compiler | defconfig  =
         | regressions
-------------------------+-------+-----------------+----------+------------=
---------+------------
at91sam9g20ek            | arm   | lab-broonie     | gcc-10   | multi_v5_de=
fconfig  | 1          =


  Details:     https://kernelci.org/test/plan/id/6571ba6ad42b494f1be1348f

  Results:     47 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline=
-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline=
-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6571ba6bd42b494f1be134c4
        failing since 327 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-07T12:27:55.141078  + set +x
    2023-12-07T12:27:55.141604  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 318217_1.5.2=
.4.1>
    2023-12-07T12:27:55.255758  / # #
    2023-12-07T12:27:55.358908  export SHELL=3D/bin/sh
    2023-12-07T12:27:55.359712  #
    2023-12-07T12:27:55.461729  / # export SHELL=3D/bin/sh. /lava-318217/en=
vironment
    2023-12-07T12:27:55.462638  =

    2023-12-07T12:27:55.564791  / # . /lava-318217/environment/lava-318217/=
bin/lava-test-runner /lava-318217/1
    2023-12-07T12:27:55.566297  =

    2023-12-07T12:27:55.569800  / # /lava-318217/bin/lava-test-runner /lava=
-318217/1 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
         | regressions
-------------------------+-------+-----------------+----------+------------=
---------+------------
bcm2836-rpi-2-b          | arm   | lab-collabora   | gcc-10   | bcm2835_def=
config   | 1          =


  Details:     https://kernelci.org/test/plan/id/6571baf2cd919ee535e134af

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm/bcm2835_defconfig/gcc-10/lab-collabora/baselin=
e-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm/bcm2835_defconfig/gcc-10/lab-collabora/baselin=
e-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6571baf2cd919ee535e134b4
        failing since 134 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-12-07T12:37:56.893464  / # #

    2023-12-07T12:37:56.995746  export SHELL=3D/bin/sh

    2023-12-07T12:37:56.996489  #

    2023-12-07T12:37:57.097883  / # export SHELL=3D/bin/sh. /lava-12207302/=
environment

    2023-12-07T12:37:57.098569  =


    2023-12-07T12:37:57.200042  / # . /lava-12207302/environment/lava-12207=
302/bin/lava-test-runner /lava-12207302/1

    2023-12-07T12:37:57.201366  =


    2023-12-07T12:37:57.217804  / # /lava-12207302/bin/lava-test-runner /la=
va-12207302/1

    2023-12-07T12:37:57.281846  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-07T12:37:57.325679  + cd /lava-12207302/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
         | regressions
-------------------------+-------+-----------------+----------+------------=
---------+------------
beaglebone-black         | arm   | lab-broonie     | gcc-10   | multi_v7_de=
fconfig  | 1          =


  Details:     https://kernelci.org/test/plan/id/6571bfce1ec814c8b1e1349a

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline=
-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline=
-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6571bfce1ec814c8b1e134c6
        failing since 327 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-07T12:50:55.340528  <8>[   22.447574] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 318347_1.5.2.4.1>
    2023-12-07T12:50:55.447927  / # #
    2023-12-07T12:50:55.549791  export SHELL=3D/bin/sh
    2023-12-07T12:50:55.550271  #
    2023-12-07T12:50:55.651592  / # export SHELL=3D/bin/sh. /lava-318347/en=
vironment
    2023-12-07T12:50:55.652109  =

    2023-12-07T12:50:55.753560  / # . /lava-318347/environment/lava-318347/=
bin/lava-test-runner /lava-318347/1
    2023-12-07T12:50:55.754303  =

    2023-12-07T12:50:55.758772  / # /lava-318347/bin/lava-test-runner /lava=
-318347/1
    2023-12-07T12:50:55.853577  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
         | regressions
-------------------------+-------+-----------------+----------+------------=
---------+------------
beaglebone-black         | arm   | lab-broonie     | gcc-10   | omap2plus_d=
efconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6571bafc014391bd44e13476

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm/omap2plus_defconfig/gcc-10/lab-broonie/baselin=
e-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm/omap2plus_defconfig/gcc-10/lab-broonie/baselin=
e-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6571bafc014391bd44e134ac
        failing since 327 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-07T12:30:32.240147  <8>[   18.718608] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 318225_1.5.2.4.1>
    2023-12-07T12:30:32.347734  / # #
    2023-12-07T12:30:32.449987  export SHELL=3D/bin/sh
    2023-12-07T12:30:32.450639  #
    2023-12-07T12:30:32.552347  / # export SHELL=3D/bin/sh. /lava-318225/en=
vironment
    2023-12-07T12:30:32.552891  =

    2023-12-07T12:30:32.654329  / # . /lava-318225/environment/lava-318225/=
bin/lava-test-runner /lava-318225/1
    2023-12-07T12:30:32.655107  =

    2023-12-07T12:30:32.659832  / # /lava-318225/bin/lava-test-runner /lava=
-318225/1
    2023-12-07T12:30:32.763564  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
         | regressions
-------------------------+-------+-----------------+----------+------------=
---------+------------
imx6q-sabrelite          | arm   | lab-collabora   | gcc-10   | multi_v7_de=
fconfig  | 1          =


  Details:     https://kernelci.org/test/plan/id/6571bfa398fb7617cfe134ee

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6571bfa398fb7617cfe134f3
        failing since 327 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-07T12:55:06.026614  / # #

    2023-12-07T12:55:06.128818  export SHELL=3D/bin/sh

    2023-12-07T12:55:06.129545  #

    2023-12-07T12:55:06.230986  / # export SHELL=3D/bin/sh. /lava-12207400/=
environment

    2023-12-07T12:55:06.231752  =


    2023-12-07T12:55:06.333250  / # . /lava-12207400/environment/lava-12207=
400/bin/lava-test-runner /lava-12207400/1

    2023-12-07T12:55:06.334366  =


    2023-12-07T12:55:06.350549  / # /lava-12207400/bin/lava-test-runner /la=
va-12207400/1

    2023-12-07T12:55:06.435519  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-07T12:55:06.436030  + cd /lava-12207400/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
         | regressions
-------------------------+-------+-----------------+----------+------------=
---------+------------
imx6qp-wandboard-revd1   | arm   | lab-pengutronix | gcc-10   | imx_v6_v7_d=
efconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6571bb10014391bd44e134b2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/bas=
eline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/bas=
eline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6571bb10014391bd44e134b7
        failing since 327 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-07T12:31:05.511458  + set +x
    2023-12-07T12:31:05.511671  [   10.402520] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1015293_1.5.2.3.1>
    2023-12-07T12:31:05.619164  / # #
    2023-12-07T12:31:05.720421  export SHELL=3D/bin/sh
    2023-12-07T12:31:05.720950  #
    2023-12-07T12:31:05.821814  / # export SHELL=3D/bin/sh. /lava-1015293/e=
nvironment
    2023-12-07T12:31:05.822386  =

    2023-12-07T12:31:05.923297  / # . /lava-1015293/environment/lava-101529=
3/bin/lava-test-runner /lava-1015293/1
    2023-12-07T12:31:05.924000  =

    2023-12-07T12:31:05.926536  / # /lava-1015293/bin/lava-test-runner /lav=
a-1015293/1 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
         | regressions
-------------------------+-------+-----------------+----------+------------=
---------+------------
imx6qp-wandboard-revd1   | arm   | lab-pengutronix | gcc-10   | multi_v7_de=
fconfig  | 1          =


  Details:     https://kernelci.org/test/plan/id/6571bf8598fb7617cfe13475

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/base=
line-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/base=
line-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6571bf8598fb7617cfe1347a
        failing since 327 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-07T12:50:04.715822  + set[    7.396509] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 1015300_1.5.2.3.1>
    2023-12-07T12:50:04.716043   +x
    2023-12-07T12:50:04.821101  / # #
    2023-12-07T12:50:04.927376  export SHELL=3D/bin/sh
    2023-12-07T12:50:04.927942  #
    2023-12-07T12:50:05.028798  / # export SHELL=3D/bin/sh. /lava-1015300/e=
nvironment
    2023-12-07T12:50:05.029335  =

    2023-12-07T12:50:05.130325  / # . /lava-1015300/environment/lava-101530=
0/bin/lava-test-runner /lava-1015300/1
    2023-12-07T12:50:05.131013  =

    2023-12-07T12:50:05.133356  / # /lava-1015300/bin/lava-test-runner /lav=
a-1015300/1 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
         | regressions
-------------------------+-------+-----------------+----------+------------=
---------+------------
juno-uboot               | arm64 | lab-broonie     | gcc-10   | defconfig  =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/6571b93eecdeafe083e134a2

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-u=
boot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-u=
boot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6571b93eecdeafe083e134de
        new failure (last pass: v5.10.201-cip41-11-ga539098fe70dd)

    2023-12-07T12:22:56.546077  / # #
    2023-12-07T12:22:56.648990  export SHELL=3D/bin/sh
    2023-12-07T12:22:56.649802  #
    2023-12-07T12:22:56.751836  / # export SHELL=3D/bin/sh. /lava-318163/en=
vironment
    2023-12-07T12:22:56.752615  =

    2023-12-07T12:22:56.854660  / # . /lava-318163/environment/lava-318163/=
bin/lava-test-runner /lava-318163/1
    2023-12-07T12:22:56.855983  =

    2023-12-07T12:22:56.870429  / # /lava-318163/bin/lava-test-runner /lava=
-318163/1
    2023-12-07T12:22:56.929274  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-07T12:22:56.929769  + cd /lava-318163/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
         | regressions
-------------------------+-------+-----------------+----------+------------=
---------+------------
juno-uboot               | arm64 | lab-broonie     | gcc-10   | defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6571c06f0cde427255e134af

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm64/defconfig+kselftest/gcc-10/lab-broonie/basel=
ine-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm64/defconfig+kselftest/gcc-10/lab-broonie/basel=
ine-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6571c06f0cde427255e134eb
        failing since 134 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-12-07T12:53:33.477024  <8>[   19.471232] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 318306_1.5.2.4.1>
    2023-12-07T12:53:33.586132  / # #
    2023-12-07T12:53:33.689207  export SHELL=3D/bin/sh
    2023-12-07T12:53:33.690045  #
    2023-12-07T12:53:33.792024  / # export SHELL=3D/bin/sh. /lava-318306/en=
vironment
    2023-12-07T12:53:33.792900  =

    2023-12-07T12:53:33.894980  / # . /lava-318306/environment/lava-318306/=
bin/lava-test-runner /lava-318306/1
    2023-12-07T12:53:33.896326  =

    2023-12-07T12:53:33.908731  / # /lava-318306/bin/lava-test-runner /lava=
-318306/1
    2023-12-07T12:53:34.086395  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (13 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
         | regressions
-------------------------+-------+-----------------+----------+------------=
---------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip         | gcc-10   | defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6571bdcc4bd1ef04c2e13475

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-=
r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-=
r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6571bdcc4bd1ef04c2e1347a
        failing since 120 days (last pass: v5.10.182-cip35, first fail: v5.=
10.186-cip37-13-g260094841fe1a)

    2023-12-07T12:42:32.043074  + set +x
    2023-12-07T12:42:32.046224  <8>[   87.576997] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1053352_1.5.2.4.1>
    2023-12-07T12:42:32.156694  / # #
    2023-12-07T12:42:33.611828  export SHELL=3D/bin/sh
    2023-12-07T12:42:33.632246  #
    2023-12-07T12:42:33.632424  / # export SHELL=3D/bin/sh
    2023-12-07T12:42:35.578481  / # . /lava-1053352/environment
    2023-12-07T12:42:39.160027  /lava-1053352/bin/lava-test-runner /lava-10=
53352/1
    2023-12-07T12:42:39.180661  . /lava-1053352/environment
    2023-12-07T12:42:39.180980  / # /lava-1053352/bin/lava-test-runner /lav=
a-1053352/1 =

    ... (27 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
         | regressions
-------------------------+-------+-----------------+----------+------------=
---------+------------
r8a774c0-ek874           | arm64 | lab-cip         | gcc-10   | defconfig  =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/6571bb96d78e023f2de134d3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-e=
k874.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-e=
k874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6571bb96d78e023f2de134d8
        failing since 134 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-12-07T12:33:07.524854  / # #
    2023-12-07T12:33:08.983944  export SHELL=3D/bin/sh
    2023-12-07T12:33:09.004957  #
    2023-12-07T12:33:09.005504  / # export SHELL=3D/bin/sh
    2023-12-07T12:33:10.956933  / # . /lava-1053316/environment
    2023-12-07T12:33:14.545246  /lava-1053316/bin/lava-test-runner /lava-10=
53316/1
    2023-12-07T12:33:14.566954  . /lava-1053316/environment
    2023-12-07T12:33:14.567492  / # /lava-1053316/bin/lava-test-runner /lav=
a-1053316/1
    2023-12-07T12:33:14.643300  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-07T12:33:14.644206  + cd /lava-1053316/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
         | regressions
-------------------------+-------+-----------------+----------+------------=
---------+------------
r8a77960-ulcb            | arm64 | lab-collabora   | gcc-10   | defconfig  =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/6571b89887911f0bade1348d

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a7=
7960-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a7=
7960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6571b89887911f0bade13492
        failing since 134 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-12-07T12:28:00.291524  / # #

    2023-12-07T12:28:00.393695  export SHELL=3D/bin/sh

    2023-12-07T12:28:00.394418  #

    2023-12-07T12:28:00.495836  / # export SHELL=3D/bin/sh. /lava-12207163/=
environment

    2023-12-07T12:28:00.496588  =


    2023-12-07T12:28:00.598016  / # . /lava-12207163/environment/lava-12207=
163/bin/lava-test-runner /lava-12207163/1

    2023-12-07T12:28:00.599100  =


    2023-12-07T12:28:00.615863  / # /lava-12207163/bin/lava-test-runner /la=
va-12207163/1

    2023-12-07T12:28:00.665218  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-07T12:28:00.665725  + cd /lav<8>[   16.450608] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12207163_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
         | regressions
-------------------------+-------+-----------------+----------+------------=
---------+------------
rk3288-veyron-jaq        | arm   | lab-collabora   | gcc-10   | multi_v7_de=
fconfig  | 4          =


  Details:     https://kernelci.org/test/plan/id/6571bf8f98fb7617cfe13495

  Results:     63 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-i2c-present: https://kernelci.or=
g/test/case/id/6571bf8f98fb7617cfe134c4
        failing since 325 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-07T12:57:48.566043  FIRST,<8>[   18.705952] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>

    2023-12-07T12:57:48.567763   INC default to 1.

    2023-12-07T12:57:48.567987  =


    2023-12-07T12:57:48.571316  	-w	Pad to last with leading zeros

    2023-12-07T12:57:48.573971  	-s SEP	String separator

    2023-12-07T12:57:48.577880  /lava-12207399/1/../bin/lava-test-case

    2023-12-07T12:57:48.583690  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.

    2023-12-07T12:57:48.584010  =

   =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/6571bf8f98fb7617cfe134c5
        failing since 325 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-07T12:57:48.545930   multi-call binary.

    2023-12-07T12:57:48.545996  =


    2023-12-07T12:57:48.550058  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-12-07T12:57:48.550285  =


    2023-12-07T12:57:48.555362  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/6571bf8f98fb7617cfe134c6
        failing since 325 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-07T12:57:48.543600  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC)<8=
>[   18.686728] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6571bf8f98fb7617cfe134da
        failing since 325 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-07T12:57:36.460157  <8>[    6.604335] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-12-07T12:57:36.469375  + <8>[    6.616738] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 12207399_1.5.2.3.1>

    2023-12-07T12:57:36.470395  set +x

    2023-12-07T12:57:36.576882  =


    2023-12-07T12:57:36.678459  / # #export SHELL=3D/bin/sh

    2023-12-07T12:57:36.679173  =


    2023-12-07T12:57:36.780567  / # export SHELL=3D/bin/sh. /lava-12207399/=
environment

    2023-12-07T12:57:36.781287  =


    2023-12-07T12:57:36.882732  / # . /lava-12207399/environment/lava-12207=
399/bin/lava-test-runner /lava-12207399/1

    2023-12-07T12:57:36.883875  =

 =

    ... (19 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
         | regressions
-------------------------+-------+-----------------+----------+------------=
---------+------------
rk3399-rock-pi-4b        | arm64 | lab-collabora   | gcc-10   | defconfig  =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/6571b8bea6ebfe2441e1348f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm64/defconfig/gcc-10/lab-collabora/baseline-rk33=
99-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm64/defconfig/gcc-10/lab-collabora/baseline-rk33=
99-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6571b8bea6ebfe2441e13494
        failing since 78 days (last pass: v5.10.191-cip38-29-g9e1aa2001db8,=
 first fail: v5.10.194-cip39)

    2023-12-07T12:21:13.740145  / # #

    2023-12-07T12:21:14.999394  export SHELL=3D/bin/sh

    2023-12-07T12:21:15.010043  #

    2023-12-07T12:21:15.010499  / # export SHELL=3D/bin/sh

    2023-12-07T12:21:16.753962  / # . /lava-12207164/environment

    2023-12-07T12:21:19.956516  /lava-12207164/bin/lava-test-runner /lava-1=
2207164/1

    2023-12-07T12:21:19.968016  . /lava-12207164/environment

    2023-12-07T12:21:19.973554  / # /lava-12207164/bin/lava-test-runner /la=
va-12207164/1

    2023-12-07T12:21:20.022456  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-07T12:21:20.022951  + cd /lava-12207164/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
         | regressions
-------------------------+-------+-----------------+----------+------------=
---------+------------
sun50i-a64-pine64-plus   | arm64 | lab-broonie     | gcc-10   | defconfig  =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/6571c57f33b7f34bf2e13477

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i=
-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i=
-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6571c57f33b7f34bf2e134a3
        failing since 327 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-07T13:15:07.830929  <8>[   17.051882] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 318167_1.5.2.4.1>
    2023-12-07T13:15:07.941816  / # #
    2023-12-07T13:15:08.044318  export SHELL=3D/bin/sh
    2023-12-07T13:15:08.044954  #
    2023-12-07T13:15:08.146870  / # export SHELL=3D/bin/sh. /lava-318167/en=
vironment
    2023-12-07T13:15:08.147434  =

    2023-12-07T13:15:08.249335  / # . /lava-318167/environment/lava-318167/=
bin/lava-test-runner /lava-318167/1
    2023-12-07T13:15:08.250247  =

    2023-12-07T13:15:08.254493  / # /lava-318167/bin/lava-test-runner /lava=
-318167/1
    2023-12-07T13:15:08.300083  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
         | regressions
-------------------------+-------+-----------------+----------+------------=
---------+------------
sun50i-h6-pine-h64       | arm64 | lab-collabora   | gcc-10   | defconfig  =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/6571b8aca6ebfe2441e13482

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm64/defconfig/gcc-10/lab-collabora/baseline-sun5=
0i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm64/defconfig/gcc-10/lab-collabora/baseline-sun5=
0i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6571b8aca6ebfe2441e13487
        failing since 134 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-12-07T12:28:12.046392  / # #

    2023-12-07T12:28:12.148513  export SHELL=3D/bin/sh

    2023-12-07T12:28:12.149207  #

    2023-12-07T12:28:12.250651  / # export SHELL=3D/bin/sh. /lava-12207168/=
environment

    2023-12-07T12:28:12.251350  =


    2023-12-07T12:28:12.352780  / # . /lava-12207168/environment/lava-12207=
168/bin/lava-test-runner /lava-12207168/1

    2023-12-07T12:28:12.353859  =


    2023-12-07T12:28:12.370618  / # /lava-12207168/bin/lava-test-runner /la=
va-12207168/1

    2023-12-07T12:28:12.412810  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-07T12:28:12.428394  + cd /lava-1220716<8>[   18.198745] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12207168_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

