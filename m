Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6D1C4828E
	for <webhook@archiver.kernel.org>; Thu,  1 Feb 2024 21:50:43 +0000 (UTC)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
 by mx.groups.io with SMTP id smtpd.web10.8421.1706824235375099651
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 01 Feb 2024 13:50:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=x1AQ+F0J;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.174, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5d3912c9a83so1175553a12.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 01 Feb 2024 13:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1706824234; x=1707429034; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OJ71IX5LRM8PiHsSADCTvvXOJb7HssLKlK4qQf8Qukk=;
        b=x1AQ+F0J9r3NyuvXPUNAWggp+N1lipivxuuO+/SxZr77QxRMuqBsUyhLqeT5bwWJEt
         m000cuxA/pxXRSYBNdFeDKUrU8p1sBKXgE4nCjCjaxA8UyqtVGAYpjaDrh4DPoDCus64
         btldW5GkRDjsAJCW8bPlaFmIQnFyHoNaF6g5ZdeSITCXmubkO5kKS+6FaItCXi37DJFb
         PJVkG2Riwg9lqt64XzJEhdIrNtgWKS+eHbe7AS/WJsbesfEwgZ5xkkN4JtjmSWXTXNTL
         SozEr0cFmtxL2BJcOYhb9a4dohQkIz9wkG8MUSCj9y6tgks8V4LIYlizRdGV30tVIgiA
         yWzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706824234; x=1707429034;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OJ71IX5LRM8PiHsSADCTvvXOJb7HssLKlK4qQf8Qukk=;
        b=C/0UBGB3PYguVFOcJ3Ei2Lzllp/b/VUIrcBjN3ifBOZYwhwfDpniWEAcYci4U78+cF
         d6W1djtEc/OF0woWarQIMiQdGrkbS06mV7ED6RrtdC7dIpDq2CtUAA5UenLTg6DlBL/f
         5R7lx1GRP8EmxWIXVyn9Z+zAxYMg9WR/pOKoC7sLrqtnnQBeX6UtENqGjAybgsoWdmPD
         nCkShVtZ1mB0dgiOsDdh+DdvGZpbnDTeoWQdUJc1s5FOhk9sOPlMcxMnUjd7lY+N2kFj
         ssG37g4CwzjARI+EFF4fND2i/9GQH3ebMoUAY45tM98lkePM+F9QFbfhrzWEtqkWQGdA
         i6Bw==
X-Gm-Message-State: AOJu0YxbBCD91cnG5xAkkpxWpi+VzmaWewXgJX8gtp8CZOHb8p11Nfwb
	aTqWpAkXsGNgnHQXTZMJpGDd7EVYHgyflWH6SFqMFijMzMqwgsh+/3H2jK6Sdbc5EAmeJxmcGzO
	Z
X-Google-Smtp-Source: AGHT+IFa1JVeMseHP4P0vTjkYlaACS+PZ1ceofnuZ8jHK6YZcfgxhTcKA2Up8rJmRhSHsoU7cC8IQg==
X-Received: by 2002:a05:6a21:2d09:b0:19e:3c51:7d37 with SMTP id tw9-20020a056a212d0900b0019e3c517d37mr3504873pzb.8.1706824233623;
        Thu, 01 Feb 2024 13:50:33 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXdUgaboVT89fD7X06nBVKEZNdJUzOcxEimjta4a44XJWtvKfiJgnJA9UAEixNrlqBgaBV+ICXx+0YrcdBWdmiEqk64Jr7476awaXGe+lBOKuxvMgx2E9ckTEqOAn73DZqMpfhwgr6JAQNnULfmuYLi/w==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id w27-20020aa79a1b000000b006ddc30172c7sm221840pfj.30.2024.02.01.13.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 13:50:32 -0800 (PST)
Message-ID: <65bc1228.a70a0220.bcf4f.17b3@mx.google.com>
Date: Thu, 01 Feb 2024 13:50:32 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.208-cip43-4-g1c63c70fb18b8
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip baseline: 135 runs,
 25 regressions (v5.10.208-cip43-4-g1c63c70fb18b8)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Feb 2024 21:50:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14588

cip/linux-5.10.y-cip baseline: 135 runs, 25 regressions (v5.10.208-cip43-4-=
g1c63c70fb18b8)

Regressions Summary
-------------------

platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
at91sam9g20ek            | arm   | lab-broonie     | gcc-10   | multi_v5_de=
fconfig           | 1          =

bcm2836-rpi-2-b          | arm   | lab-collabora   | gcc-10   | bcm2835_def=
config            | 1          =

beaglebone-black         | arm   | lab-broonie     | gcc-10   | multi_v7_de=
fconfig           | 1          =

beaglebone-black         | arm   | lab-broonie     | gcc-10   | omap2plus_d=
efconfig          | 1          =

beaglebone-black         | arm   | lab-cip         | gcc-10   | omap2plus_d=
efconfig          | 1          =

imx6q-sabrelite          | arm   | lab-collabora   | gcc-10   | multi_v7_de=
fconfig           | 1          =

imx6qp-wandboard-revd1   | arm   | lab-pengutronix | gcc-10   | imx_v6_v7_d=
efconfig          | 1          =

imx6qp-wandboard-revd1   | arm   | lab-pengutronix | gcc-10   | multi_v7_de=
fconfig           | 1          =

juno-uboot               | arm64 | lab-broonie     | gcc-10   | cip://5.10.=
y-...64_defconfig | 1          =

juno-uboot               | arm64 | lab-broonie     | gcc-10   | defconfig+k=
selftest          | 1          =

mt8173-elm-hana          | arm64 | lab-collabora   | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =

r8a7743-iwg20d-q7        | arm   | lab-cip         | gcc-10   | shmobile_de=
fconfig           | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip         | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip         | gcc-10   | defconfig+k=
selftest          | 1          =

r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip         | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =

r8a774c0-ek874           | arm64 | lab-cip         | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =

r8a774c0-ek874           | arm64 | lab-cip         | gcc-10   | defconfig  =
                  | 1          =

r8a77960-ulcb            | arm64 | lab-collabora   | gcc-10   | defconfig  =
                  | 1          =

rk3288-veyron-jaq        | arm   | lab-collabora   | gcc-10   | multi_v7_de=
fconfig           | 4          =

rk3399-rock-pi-4b        | arm64 | lab-collabora   | gcc-10   | defconfig  =
                  | 1          =

sun50i-a64-pine64-plus   | arm64 | lab-broonie     | gcc-10   | defconfig  =
                  | 1          =

sun50i-h6-pine-h64       | arm64 | lab-collabora   | gcc-10   | defconfig  =
                  | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.208-cip43-4-g1c63c70fb18b8/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.208-cip43-4-g1c63c70fb18b8
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      1c63c70fb18b87b5bcfe5d7ddf0096c92a1557ed =



Test Regressions
---------------- =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
at91sam9g20ek            | arm   | lab-broonie     | gcc-10   | multi_v5_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65bc06cd87d39e919a00a047

  Results:     47 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-=
at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-=
at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65bc06cd87d39e919a00a07e
        failing since 383 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-01T21:01:36.673185  + set +x
    2024-02-01T21:01:36.673705  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 532928_1.5.2=
.4.1>
    2024-02-01T21:01:36.787551  / # #
    2024-02-01T21:01:36.890445  export SHELL=3D/bin/sh
    2024-02-01T21:01:36.891237  #
    2024-02-01T21:01:36.993125  / # export SHELL=3D/bin/sh. /lava-532928/en=
vironment
    2024-02-01T21:01:36.993897  =

    2024-02-01T21:01:37.095909  / # . /lava-532928/environment/lava-532928/=
bin/lava-test-runner /lava-532928/1
    2024-02-01T21:01:37.097222  =

    2024-02-01T21:01:37.100862  / # /lava-532928/bin/lava-test-runner /lava=
-532928/1 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
bcm2836-rpi-2-b          | arm   | lab-collabora   | gcc-10   | bcm2835_def=
config            | 1          =


  Details:     https://kernelci.org/test/plan/id/65bc0954a59e276f0700a049

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm/bcm2835_defconfig/gcc-10/lab-collabora/baseline=
-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm/bcm2835_defconfig/gcc-10/lab-collabora/baseline=
-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65bc0954a59e276f0700a052
        failing since 191 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2024-02-01T21:20:07.141831  / # #

    2024-02-01T21:20:07.243947  export SHELL=3D/bin/sh

    2024-02-01T21:20:07.244677  #

    2024-02-01T21:20:07.346000  / # export SHELL=3D/bin/sh. /lava-12684715/=
environment

    2024-02-01T21:20:07.346707  =


    2024-02-01T21:20:07.448158  / # . /lava-12684715/environment/lava-12684=
715/bin/lava-test-runner /lava-12684715/1

    2024-02-01T21:20:07.449307  =


    2024-02-01T21:20:07.451322  / # /lava-12684715/bin/lava-test-runner /la=
va-12684715/1

    2024-02-01T21:20:07.531396  + export 'TESTRUN_ID=3D1_bootrr'

    2024-02-01T21:20:07.569141  + cd /lava-12684715/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
beaglebone-black         | arm   | lab-broonie     | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65bc0b7da7274bacb000a055

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-=
beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-=
beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65bc0b7ea7274bacb000a086
        failing since 383 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-01T21:21:35.974701  <8>[   22.862015] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 533011_1.5.2.4.1>
    2024-02-01T21:21:36.085461  / # #
    2024-02-01T21:21:36.188491  export SHELL=3D/bin/sh
    2024-02-01T21:21:36.189362  #
    2024-02-01T21:21:36.291450  / # export SHELL=3D/bin/sh. /lava-533011/en=
vironment
    2024-02-01T21:21:36.292360  =

    2024-02-01T21:21:36.394411  / # . /lava-533011/environment/lava-533011/=
bin/lava-test-runner /lava-533011/1
    2024-02-01T21:21:36.395824  =

    2024-02-01T21:21:36.400324  / # /lava-533011/bin/lava-test-runner /lava=
-533011/1
    2024-02-01T21:21:36.494436  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
beaglebone-black         | arm   | lab-broonie     | gcc-10   | omap2plus_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/65bc084b03f4eb0e6700a06b

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline=
-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline=
-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65bc084b03f4eb0e6700a0a4
        failing since 383 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-01T21:08:15.939740  <8>[   20.937683] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 532972_1.5.2.4.1>
    2024-02-01T21:08:16.047224  / # #
    2024-02-01T21:08:16.149734  export SHELL=3D/bin/sh
    2024-02-01T21:08:16.150411  #
    2024-02-01T21:08:16.252302  / # export SHELL=3D/bin/sh. /lava-532972/en=
vironment
    2024-02-01T21:08:16.252950  =

    2024-02-01T21:08:16.354886  / # . /lava-532972/environment/lava-532972/=
bin/lava-test-runner /lava-532972/1
    2024-02-01T21:08:16.355778  =

    2024-02-01T21:08:16.360750  / # /lava-532972/bin/lava-test-runner /lava=
-532972/1
    2024-02-01T21:08:16.469015  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
beaglebone-black         | arm   | lab-cip         | gcc-10   | omap2plus_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/65bc09d0b7b55d61ad00a072

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-bea=
glebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-bea=
glebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65bc09d0b7b55d61ad00a0a9
        failing since 383 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-01T21:14:41.465272  <8>[   13.087830] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1086324_1.5.2.4.1>
    2024-02-01T21:14:41.575288  / # #
    2024-02-01T21:14:41.677374  export SHELL=3D/bin/sh
    2024-02-01T21:14:41.678019  #
    2024-02-01T21:14:41.779325  / # export SHELL=3D/bin/sh. /lava-1086324/e=
nvironment
    2024-02-01T21:14:41.779971  =

    2024-02-01T21:14:41.881307  / # . /lava-1086324/environment/lava-108632=
4/bin/lava-test-runner /lava-1086324/1
    2024-02-01T21:14:41.882352  =

    2024-02-01T21:14:41.888804  / # /lava-1086324/bin/lava-test-runner /lav=
a-1086324/1
    2024-02-01T21:14:41.996856  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
imx6q-sabrelite          | arm   | lab-collabora   | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65bc0b6179e39a5cf900a05a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm/multi_v7_defconfig/gcc-10/lab-collabora/baselin=
e-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm/multi_v7_defconfig/gcc-10/lab-collabora/baselin=
e-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65bc0b6179e39a5cf900a063
        failing since 383 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-01T21:27:09.802422  / # #

    2024-02-01T21:27:09.904599  export SHELL=3D/bin/sh

    2024-02-01T21:27:09.905334  #

    2024-02-01T21:27:10.006770  / # export SHELL=3D/bin/sh. /lava-12684736/=
environment

    2024-02-01T21:27:10.007566  =


    2024-02-01T21:27:10.109043  / # . /lava-12684736/environment/lava-12684=
736/bin/lava-test-runner /lava-12684736/1

    2024-02-01T21:27:10.110239  =


    2024-02-01T21:27:10.126508  / # /lava-12684736/bin/lava-test-runner /la=
va-12684736/1

    2024-02-01T21:27:10.174546  + export 'TESTRUN_ID=3D1_bootrr'

    2024-02-01T21:27:10.232183  + cd /lava-12684736/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
imx6qp-wandboard-revd1   | arm   | lab-pengutronix | gcc-10   | imx_v6_v7_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/65bc07944e1668f01a00a065

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/base=
line-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/base=
line-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65bc07944e1668f01a00a06e
        failing since 383 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-01T21:05:16.959741  + set +x
    2024-02-01T21:05:16.959926  [   10.445861] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1023222_1.5.2.3.1>
    2024-02-01T21:05:17.067228  / # #
    2024-02-01T21:05:17.168392  export SHELL=3D/bin/sh
    2024-02-01T21:05:17.168887  #
    2024-02-01T21:05:17.269741  / # export SHELL=3D/bin/sh. /lava-1023222/e=
nvironment
    2024-02-01T21:05:17.270236  =

    2024-02-01T21:05:17.371101  / # . /lava-1023222/environment/lava-102322=
2/bin/lava-test-runner /lava-1023222/1
    2024-02-01T21:05:17.371696  =

    2024-02-01T21:05:17.374639  / # /lava-1023222/bin/lava-test-runner /lav=
a-1023222/1 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
imx6qp-wandboard-revd1   | arm   | lab-pengutronix | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65bc0b4060941113aa00a08d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/basel=
ine-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/basel=
ine-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65bc0b4160941113aa00a096
        failing since 383 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-01T21:20:57.670027  + set[    7.310415] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 1023223_1.5.2.3.1>
    2024-02-01T21:20:57.670201   +x
    2024-02-01T21:20:57.775395  / # #
    2024-02-01T21:20:57.876527  export SHELL=3D/bin/sh
    2024-02-01T21:20:57.876928  #
    2024-02-01T21:20:57.977751  / # export SHELL=3D/bin/sh. /lava-1023223/e=
nvironment
    2024-02-01T21:20:57.978176  =

    2024-02-01T21:20:58.078946  / # . /lava-1023223/environment/lava-102322=
3/bin/lava-test-runner /lava-1023223/1
    2024-02-01T21:20:58.079515  =

    2024-02-01T21:20:58.081802  / # /lava-1023223/bin/lava-test-runner /lav=
a-1023223/1 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
juno-uboot               | arm64 | lab-broonie     | gcc-10   | cip://5.10.=
y-...64_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/65bc0c4602c011a67200a039

  Results:     47 PASS, 13 FAIL, 1 SKIP
  Full config: cip://5.10.y-cip/arm64/qemu_arm64_defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/cip---5.10.y-cip-arm64-qemu_arm64_defconfig/g=
cc-10/lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/cip---5.10.y-cip-arm64-qemu_arm64_defconfig/g=
cc-10/lab-broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65bc0c4602c011a67200a078
        failing since 157 days (last pass: v5.10.186-cip37-27-gd6d928db0a62=
0, first fail: v5.10.191-cip38)

    2024-02-01T21:24:51.637636  / # #
    2024-02-01T21:24:51.740556  export SHELL=3D/bin/sh
    2024-02-01T21:24:51.741306  #
    2024-02-01T21:24:51.843290  / # export SHELL=3D/bin/sh. /lava-533028/en=
vironment
    2024-02-01T21:24:51.844095  =

    2024-02-01T21:24:51.946113  / # . /lava-533028/environment/lava-533028/=
bin/lava-test-runner /lava-533028/1
    2024-02-01T21:24:51.947406  =

    2024-02-01T21:24:51.961372  / # /lava-533028/bin/lava-test-runner /lava=
-533028/1
    2024-02-01T21:24:52.017232  + export 'TESTRUN_ID=3D1_bootrr'
    2024-02-01T21:24:52.017753  + cd /lava-533028/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
juno-uboot               | arm64 | lab-broonie     | gcc-10   | defconfig+k=
selftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/65bc0b565599494f3f00a06d

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig+kselftest/gcc-10/lab-broonie/baseli=
ne-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig+kselftest/gcc-10/lab-broonie/baseli=
ne-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65bc0b565599494f3f00a0a9
        failing since 191 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2024-02-01T21:20:53.537900  <8>[   20.351767] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 533002_1.5.2.4.1>
    2024-02-01T21:20:53.645793  / # #
    2024-02-01T21:20:53.748704  export SHELL=3D/bin/sh
    2024-02-01T21:20:53.749475  #
    2024-02-01T21:20:53.851366  / # export SHELL=3D/bin/sh. /lava-533002/en=
vironment
    2024-02-01T21:20:53.852144  =

    2024-02-01T21:20:53.954094  / # . /lava-533002/environment/lava-533002/=
bin/lava-test-runner /lava-533002/1
    2024-02-01T21:20:53.955397  =

    2024-02-01T21:20:53.969308  / # /lava-533002/bin/lava-test-runner /lava=
-533002/1
    2024-02-01T21:20:54.151048  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (13 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
mt8173-elm-hana          | arm64 | lab-collabora   | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/65bc06e287d39e919a00a085

  Results:     28 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/baseline-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/baseline-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65bc06e287d39e919a00a0a5
        failing since 383 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-01T21:02:03.704489  + <8>[   15.561002] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 12684595_1.5.2.3.1>

    2024-02-01T21:02:03.704587  set +x

    2024-02-01T21:02:03.808318  #

    2024-02-01T21:02:03.911000  / # #export SHELL=3D/bin/sh

    2024-02-01T21:02:03.911834  =


    2024-02-01T21:02:04.013435  / # export SHELL=3D/bin/sh. /lava-12684595/=
environment

    2024-02-01T21:02:04.014218  =


    2024-02-01T21:02:04.115977  / # . /lava-12684595/environment/lava-12684=
595/bin/lava-test-runner /lava-12684595/1

    2024-02-01T21:02:04.117275  =


    2024-02-01T21:02:04.119246  / # /lava-12684595/bin/lava-test-runner /la=
va-12684595/1
 =

    ... (20 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
r8a7743-iwg20d-q7        | arm   | lab-cip         | gcc-10   | shmobile_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65bc06e7c06f2f58af00a049

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7=
743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7=
743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65bc06e7c06f2f58af00a=
04a
        failing since 56 days (last pass: v5.10.201-cip41-16-g3c85fba3b6e5d=
, first fail: v5.10.201-cip41-28-ga386bc478aa6b) =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip         | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/65bc084fe6a18d8e8d00a06f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/bas=
eline-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/bas=
eline-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65bc084fe6a18d8e8d00a078
        failing since 191 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2024-02-01T21:08:18.200907  + set +x
    2024-02-01T21:08:18.204227  <8>[   83.978970] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1086312_1.5.2.4.1>
    2024-02-01T21:08:18.311557  / # #
    2024-02-01T21:08:19.774769  export SHELL=3D/bin/sh
    2024-02-01T21:08:19.795523  #
    2024-02-01T21:08:19.796014  / # export SHELL=3D/bin/sh
    2024-02-01T21:08:21.749657  / # . /lava-1086312/environment
    2024-02-01T21:08:25.344452  /lava-1086312/bin/lava-test-runner /lava-10=
86312/1
    2024-02-01T21:08:25.366053  . /lava-1086312/environment
    2024-02-01T21:08:25.366462  / # /lava-1086312/bin/lava-test-runner /lav=
a-1086312/1 =

    ... (28 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip         | gcc-10   | defconfig+k=
selftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/65bc0b0b54827e33b600a10d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-r=
8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-r=
8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65bc0b0b54827e33b600a116
        failing since 176 days (last pass: v5.10.182-cip35, first fail: v5.=
10.186-cip37-13-g260094841fe1a)

    2024-02-01T21:19:56.031625  + set +x
    2024-02-01T21:19:56.034978  <8>[   87.680674] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1086328_1.5.2.4.1>
    2024-02-01T21:19:56.148227  / # #
    2024-02-01T21:19:57.613745  export SHELL=3D/bin/sh
    2024-02-01T21:19:57.634759  #
    2024-02-01T21:19:57.635226  / # export SHELL=3D/bin/sh
    2024-02-01T21:19:59.593201  / # . /lava-1086328/environment
    2024-02-01T21:20:03.197263  /lava-1086328/bin/lava-test-runner /lava-10=
86328/1
    2024-02-01T21:20:03.218801  . /lava-1086328/environment
    2024-02-01T21:20:03.219168  / # /lava-1086328/bin/lava-test-runner /lav=
a-1086328/1 =

    ... (28 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip         | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/65bc09dfb7b55d61ad00a0b0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/bas=
eline-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/bas=
eline-r8a774b1-hihope-rzg2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65bc09dfb7b55d61ad00a0b9
        failing since 191 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2024-02-01T21:14:53.311081  + set +x
    2024-02-01T21:14:53.314405  <8>[   84.218991] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1086308_1.5.2.4.1>
    2024-02-01T21:14:53.423893  / # #
    2024-02-01T21:14:54.884320  export SHELL=3D/bin/sh
    2024-02-01T21:14:54.905329  #
    2024-02-01T21:14:54.905865  / # export SHELL=3D/bin/sh
    2024-02-01T21:14:56.857905  / # . /lava-1086308/environment
    2024-02-01T21:15:00.449528  /lava-1086308/bin/lava-test-runner /lava-10=
86308/1
    2024-02-01T21:15:00.471084  . /lava-1086308/environment
    2024-02-01T21:15:00.471459  / # /lava-1086308/bin/lava-test-runner /lav=
a-1086308/1 =

    ... (15 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
r8a774c0-ek874           | arm64 | lab-cip         | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/65bc09f3e80cf5a90700a03d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/bas=
eline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/bas=
eline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65bc09f3e80cf5a90700a046
        failing since 191 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2024-02-01T21:15:11.007349  / # #
    2024-02-01T21:15:12.467824  export SHELL=3D/bin/sh
    2024-02-01T21:15:12.488639  #
    2024-02-01T21:15:12.488857  / # export SHELL=3D/bin/sh
    2024-02-01T21:15:14.440029  / # . /lava-1086304/environment
    2024-02-01T21:15:18.030862  /lava-1086304/bin/lava-test-runner /lava-10=
86304/1
    2024-02-01T21:15:18.052438  . /lava-1086304/environment
    2024-02-01T21:15:18.052811  / # /lava-1086304/bin/lava-test-runner /lav=
a-1086304/1
    2024-02-01T21:15:18.129259  + export 'TESTRUN_ID=3D1_bootrr'
    2024-02-01T21:15:18.129771  + cd /lava-1086304/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
r8a774c0-ek874           | arm64 | lab-cip         | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65bc0c7471c2efab5d00a06e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek=
874.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek=
874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65bc0c7471c2efab5d00a077
        failing since 191 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2024-02-01T21:25:53.506860  / # #
    2024-02-01T21:25:54.966623  export SHELL=3D/bin/sh
    2024-02-01T21:25:54.987549  #
    2024-02-01T21:25:54.988089  / # export SHELL=3D/bin/sh
    2024-02-01T21:25:56.938673  / # . /lava-1086348/environment
    2024-02-01T21:26:00.527355  /lava-1086348/bin/lava-test-runner /lava-10=
86348/1
    2024-02-01T21:26:00.549009  . /lava-1086348/environment
    2024-02-01T21:26:00.549421  / # /lava-1086348/bin/lava-test-runner /lav=
a-1086348/1
    2024-02-01T21:26:00.625688  + export 'TESTRUN_ID=3D1_bootrr'
    2024-02-01T21:26:00.626202  + cd /lava-1086348/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
r8a77960-ulcb            | arm64 | lab-collabora   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65bc0b5cc7976558ea00a0a9

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77=
960-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77=
960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65bc0b5cc7976558ea00a0b2
        failing since 191 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2024-02-01T21:28:58.236292  / # #

    2024-02-01T21:28:58.336741  export SHELL=3D/bin/sh

    2024-02-01T21:28:58.336853  #

    2024-02-01T21:28:58.437272  / # export SHELL=3D/bin/sh. /lava-12684748/=
environment

    2024-02-01T21:28:58.437377  =


    2024-02-01T21:28:58.537837  / # . /lava-12684748/environment/lava-12684=
748/bin/lava-test-runner /lava-12684748/1

    2024-02-01T21:28:58.538033  =


    2024-02-01T21:28:58.550207  / # /lava-12684748/bin/lava-test-runner /la=
va-12684748/1

    2024-02-01T21:28:58.603644  + export 'TESTRUN_ID=3D1_bootrr'

    2024-02-01T21:28:58.603725  + cd /lav<8>[   16.399666] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12684748_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
rk3288-veyron-jaq        | arm   | lab-collabora   | gcc-10   | multi_v7_de=
fconfig           | 4          =


  Details:     https://kernelci.org/test/plan/id/65bc0b48c7976558ea00a046

  Results:     63 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm/multi_v7_defconfig/gcc-10/lab-collabora/baselin=
e-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm/multi_v7_defconfig/gcc-10/lab-collabora/baselin=
e-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-i2c-present: https://kernelci.or=
g/test/case/id/65bc0b48c7976558ea00a079
        failing since 381 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-01T21:28:37.011752  FIRST,<8>[   18.304272] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>

    2024-02-01T21:28:37.013849   INC default to 1.

    2024-02-01T21:28:37.014085  =


    2024-02-01T21:28:37.017426  	-w	Pad to last with leading zeros

    2024-02-01T21:28:37.019951  	-s SEP	String separator

    2024-02-01T21:28:37.023843  /lava-12684738/1/../bin/lava-test-case

    2024-02-01T21:28:37.029716  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.

    2024-02-01T21:28:37.029962  =

   =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/65bc0b48c7976558ea00a07a
        failing since 381 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-01T21:28:36.990061  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC)<8=
>[   18.285257] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2024-02-01T21:28:36.991219   multi-call binary.

    2024-02-01T21:28:36.991569  =


    2024-02-01T21:28:36.995832  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2024-02-01T21:28:36.996052  =


    2024-02-01T21:28:37.000985  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/65bc0b48c7976558ea00a07b
        failing since 381 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24) =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65bc0b49c7976558ea00a08f
        failing since 381 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-01T21:28:24.908486  <8>[    6.205373] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2024-02-01T21:28:24.917779  + <8>[    6.217792] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 12684738_1.5.2.3.1>

    2024-02-01T21:28:24.918517  set +x

    2024-02-01T21:28:25.024244  #

    2024-02-01T21:28:25.025210  =


    2024-02-01T21:28:25.126686  / # #export SHELL=3D/bin/sh

    2024-02-01T21:28:25.127380  =


    2024-02-01T21:28:25.228624  / # export SHELL=3D/bin/sh. /lava-12684738/=
environment

    2024-02-01T21:28:25.229295  =


    2024-02-01T21:28:25.330577  / # . /lava-12684738/environment/lava-12684=
738/bin/lava-test-runner /lava-12684738/1
 =

    ... (20 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
rk3399-rock-pi-4b        | arm64 | lab-collabora   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65bc0b9d94f6204b0000a039

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig/gcc-10/lab-collabora/baseline-rk339=
9-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig/gcc-10/lab-collabora/baseline-rk339=
9-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65bc0b9d94f6204b0000a042
        failing since 135 days (last pass: v5.10.191-cip38-29-g9e1aa2001db8=
, first fail: v5.10.194-cip39)

    2024-02-01T21:27:51.114740  / # #

    2024-02-01T21:27:52.375442  export SHELL=3D/bin/sh

    2024-02-01T21:27:52.386392  #

    2024-02-01T21:27:52.386871  / # export SHELL=3D/bin/sh

    2024-02-01T21:27:54.130756  / # . /lava-12684754/environment

    2024-02-01T21:27:57.334934  /lava-12684754/bin/lava-test-runner /lava-1=
2684754/1

    2024-02-01T21:27:57.346386  . /lava-12684754/environment

    2024-02-01T21:27:57.351876  / # /lava-12684754/bin/lava-test-runner /la=
va-12684754/1

    2024-02-01T21:27:57.401947  + export 'TESTRUN_ID=3D1_bootrr'

    2024-02-01T21:27:57.402446  + cd /lava-12684754/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
sun50i-a64-pine64-plus   | arm64 | lab-broonie     | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65bc0c0118677bde6600a0c7

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-=
a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-=
a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65bc0c0118677bde6600a0f7
        failing since 383 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-01T21:23:46.800108  + set +x
    2024-02-01T21:23:46.804136  <8>[   17.047828] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 533054_1.5.2.4.1>
    2024-02-01T21:23:46.914311  / # #
    2024-02-01T21:23:47.016750  export SHELL=3D/bin/sh
    2024-02-01T21:23:47.017387  #
    2024-02-01T21:23:47.118965  / # export SHELL=3D/bin/sh. /lava-533054/en=
vironment
    2024-02-01T21:23:47.119620  =

    2024-02-01T21:23:47.221260  / # . /lava-533054/environment/lava-533054/=
bin/lava-test-runner /lava-533054/1
    2024-02-01T21:23:47.222126  =

    2024-02-01T21:23:47.226635  / # /lava-533054/bin/lava-test-runner /lava=
-533054/1 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
sun50i-h6-pine-h64       | arm64 | lab-collabora   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65bc0b70a7274bacb000a03b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50=
i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50=
i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65bc0b70a7274bacb000a044
        failing since 191 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2024-02-01T21:29:20.261895  / # #

    2024-02-01T21:29:20.364244  export SHELL=3D/bin/sh

    2024-02-01T21:29:20.365031  #

    2024-02-01T21:29:20.466429  / # export SHELL=3D/bin/sh. /lava-12684751/=
environment

    2024-02-01T21:29:20.467174  =


    2024-02-01T21:29:20.568666  / # . /lava-12684751/environment/lava-12684=
751/bin/lava-test-runner /lava-12684751/1

    2024-02-01T21:29:20.569867  =


    2024-02-01T21:29:20.585232  / # /lava-12684751/bin/lava-test-runner /la=
va-12684751/1

    2024-02-01T21:29:20.644198  + export 'TESTRUN_ID=3D1_bootrr'

    2024-02-01T21:29:20.644743  + cd /lava-1268475<8>[   18.202018] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12684751_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

