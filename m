Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2DAC3DA6E
	for <webhook@archiver.kernel.org>; Thu, 21 Dec 2023 01:00:05 +0000 (UTC)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
 by mx.groups.io with SMTP id smtpd.web11.41410.1703120396405841718
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 20 Dec 2023 16:59:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=TY/iBjXz;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.49, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-28b09aeca73so192379a91.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 20 Dec 2023 16:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703120395; x=1703725195; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qJnJvaH6B5X2QjxBJ3lEdMILzNH6G9ziDTvlhziyx9I=;
        b=TY/iBjXzqB2J2YNfBiskRdE17f3klBIozqwLubVue8d9/aOYNskBzSshG0ackr5i0m
         uPtYsorzD0OCBk13uTqJxlAFfVAYJCgfc+CZdosfwE/PgMflXx6SEV53DKtnrlfpT+n0
         RI5CFgWRhZXipnHUezooYxCbGofCRBxrUC3CKrycyormOGv/YmW/FWDE9oICqrJ49iRq
         dkA9cllbJTpnnVJfE1vL1HoebapvstD1JP1vamh96dX3zl9d6a74jgMLxviwCXsF1I4o
         mtKD+r+/oQdWS4n6s9ohVtr0vjk4eG2yC8ic4Ix8RJ8ycSgSQULdGDl7oqOKjE7X4yvb
         6jSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703120395; x=1703725195;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qJnJvaH6B5X2QjxBJ3lEdMILzNH6G9ziDTvlhziyx9I=;
        b=nETpSfg2JmhvGXvAP+hGvdzTYqWJQwHXF0o1aeQJIYeiqQMqWCrY1ZAkEW3OkpwUD5
         rM9P5nKJVqjGiibvMEhPhSg3DrPilP7qLFl8ZI1r2xvITInE5n3WqsVkNRfTIrgcXrxK
         H9bCTkKhEwn9MRybcEKJ2n/umoSD9R/pAViljjyD8KM200qWnzN6PdVI8LNRWuCJWYV5
         65vO7W+6Yfc7k7Cqi3Cy1uW9pbC7gpGyXb2RtmClDheOjJ8JbDqdPUKrlYlER6l5TPTt
         a+EmLzbMZA9kd5l/t9imtjoTsc1nLqPQh1hSERDtvLyUNAOxtH7dTG4r1pOAd8y2vVEL
         xmeQ==
X-Gm-Message-State: AOJu0YxOr8aAvb0buk6uO/WuGSkSVLOu5ZjzNth6b8XgIS6Tcm0vEZZN
	HQ50WmtRPiwxPI4kzOqe9/o1X815NT2orxMNCSEA/Te4dYM=
X-Google-Smtp-Source: AGHT+IHszU4DHu9Y+/vT1vvqAbAEeCEaM4QHiez9SITWbdPtFq9fX3SLxafp5mHlC1txL/UYLmQxrA==
X-Received: by 2002:a17:90a:c394:b0:28b:bbc0:c555 with SMTP id h20-20020a17090ac39400b0028bbbc0c555mr4623764pjt.8.1703120394742;
        Wed, 20 Dec 2023 16:59:54 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id on11-20020a17090b1d0b00b0028bc1df95c7sm464087pjb.4.2023.12.20.16.59.53
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 16:59:54 -0800 (PST)
Message-ID: <65838e0a.170a0220.85cc9.22fc@mx.google.com>
Date: Wed, 20 Dec 2023 16:59:54 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-540-g3640150b3b169
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 158 runs,
 18 regressions (v5.10.201-cip41-540-g3640150b3b169)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Dec 2023 01:00:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14170

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 158 runs, 18 regressio=
ns (v5.10.201-cip41-540-g3640150b3b169)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
bcm2836-rpi-2-b          | arm   | lab-collabora | gcc-10   | bcm2835_defco=
nfig            | 1          =

beaglebone-black         | arm   | lab-broonie   | gcc-10   | omap2plus_def=
config          | 1          =

beaglebone-black         | arm   | lab-cip       | gcc-10   | omap2plus_def=
config          | 1          =

juno-uboot               | arm64 | lab-broonie   | gcc-10   | defconfig+kse=
lftest          | 1          =

r8a7743-iwg20d-q7        | arm   | lab-cip       | gcc-10   | shmobile_defc=
onfig           | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook   | 1          =

r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook   | 1          =

r8a774c0-ek874           | arm64 | lab-cip       | gcc-10   | defconfig+kse=
lftest          | 1          =

r8a774c0-ek874           | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook   | 1          =

r8a774c0-ek874           | arm64 | lab-cip       | gcc-10   | defconfig    =
                | 1          =

r8a77960-ulcb            | arm64 | lab-collabora | gcc-10   | defconfig    =
                | 1          =

rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
...ok+kselftest | 2          =

rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook   | 2          =

rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig+kse=
lftest          | 1          =

rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig    =
                | 1          =

sun50i-h6-pine-h64       | arm64 | lab-collabora | gcc-10   | defconfig    =
                | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.201-cip41-540-g3640150b3b169/plan/baselin=
e/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.201-cip41-540-g3640150b3b169
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      3640150b3b169fcd03031a9e8aab166a9730a1f9 =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
bcm2836-rpi-2-b          | arm   | lab-collabora | gcc-10   | bcm2835_defco=
nfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/65838345db1f78e6a3e13522

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-540-g3640150b3b169/arm/bcm2835_defconfig/gcc-1=
0/lab-collabora/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-540-g3640150b3b169/arm/bcm2835_defconfig/gcc-1=
0/lab-collabora/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65838345db1f78e6a3e13527
        failing since 146 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-12-21T00:21:13.408689  / # #

    2023-12-21T00:21:13.510765  export SHELL=3D/bin/sh

    2023-12-21T00:21:13.511470  #

    2023-12-21T00:21:13.612920  / # export SHELL=3D/bin/sh. /lava-12331994/=
environment

    2023-12-21T00:21:13.613629  =


    2023-12-21T00:21:13.715038  / # . /lava-12331994/environment/lava-12331=
994/bin/lava-test-runner /lava-12331994/1

    2023-12-21T00:21:13.716139  =


    2023-12-21T00:21:13.732855  / # /lava-12331994/bin/lava-test-runner /la=
va-12331994/1

    2023-12-21T00:21:13.796865  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-21T00:21:13.840396  + cd /lava-12331994/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
beaglebone-black         | arm   | lab-broonie   | gcc-10   | omap2plus_def=
config          | 1          =


  Details:     https://kernelci.org/test/plan/id/6583850dd063bf6492e13482

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-540-g3640150b3b169/arm/omap2plus_defconfig/gcc=
-10/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-540-g3640150b3b169/arm/omap2plus_defconfig/gcc=
-10/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6583850dd063bf6492e134b5
        failing since 350 days (last pass: v5.10.155-cip21-405-g26d566555c3=
de, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2023-12-21T00:21:19.553308  <8>[   20.251964] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 380060_1.5.2.4.1>
    2023-12-21T00:21:19.662200  / # #
    2023-12-21T00:21:19.764375  export SHELL=3D/bin/sh
    2023-12-21T00:21:19.764956  #
    2023-12-21T00:21:19.866578  / # export SHELL=3D/bin/sh. /lava-380060/en=
vironment
    2023-12-21T00:21:19.867204  =

    2023-12-21T00:21:19.969042  / # . /lava-380060/environment/lava-380060/=
bin/lava-test-runner /lava-380060/1
    2023-12-21T00:21:19.969984  =

    2023-12-21T00:21:19.974239  / # /lava-380060/bin/lava-test-runner /lava=
-380060/1
    2023-12-21T00:21:20.077055  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
beaglebone-black         | arm   | lab-cip       | gcc-10   | omap2plus_def=
config          | 1          =


  Details:     https://kernelci.org/test/plan/id/6583854894b41f3184e13476

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-540-g3640150b3b169/arm/omap2plus_defconfig/gcc=
-10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-540-g3640150b3b169/arm/omap2plus_defconfig/gcc=
-10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6583854894b41f3184e134a9
        failing since 350 days (last pass: v5.10.155-cip21-405-g26d566555c3=
de, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2023-12-21T00:22:19.365302  / # #
    2023-12-21T00:22:19.466204  export SHELL=3D/bin/sh
    2023-12-21T00:22:19.466547  #
    2023-12-21T00:22:19.567213  / # export SHELL=3D/bin/sh. /lava-1063198/e=
nvironment
    2023-12-21T00:22:19.567684  =

    2023-12-21T00:22:19.668450  / # . /lava-1063198/environment/lava-106319=
8/bin/lava-test-runner /lava-1063198/1
    2023-12-21T00:22:19.669074  =

    2023-12-21T00:22:19.679437  / # /lava-1063198/bin/lava-test-runner /lav=
a-1063198/1
    2023-12-21T00:22:19.816179  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-21T00:22:19.816494  + cd /lava-1063198/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
juno-uboot               | arm64 | lab-broonie   | gcc-10   | defconfig+kse=
lftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/658384b283ad3d5b04e134f6

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-540-g3640150b3b169/arm64/defconfig+kselftest/g=
cc-10/lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-540-g3640150b3b169/arm64/defconfig+kselftest/g=
cc-10/lab-broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/658384b283ad3d5b04e13530
        failing since 90 days (last pass: v5.10.191-cip38-661-g112a3073ff26=
, first fail: v5.10.194-cip39-407-g664623343843d)

    2023-12-21T00:19:36.792458  <8>[   18.429049] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 380042_1.5.2.4.1>
    2023-12-21T00:19:36.900274  / # #
    2023-12-21T00:19:37.002970  export SHELL=3D/bin/sh
    2023-12-21T00:19:37.003716  #
    2023-12-21T00:19:37.105575  / # export SHELL=3D/bin/sh. /lava-380042/en=
vironment
    2023-12-21T00:19:37.106410  =

    2023-12-21T00:19:37.208329  / # . /lava-380042/environment/lava-380042/=
bin/lava-test-runner /lava-380042/1
    2023-12-21T00:19:37.209559  =

    2023-12-21T00:19:37.223973  / # /lava-380042/bin/lava-test-runner /lava=
-380042/1
    2023-12-21T00:19:37.400619  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a7743-iwg20d-q7        | arm   | lab-cip       | gcc-10   | shmobile_defc=
onfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6583842443af6d8f7de134e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-540-g3640150b3b169/arm/shmobile_defconfig/gcc-=
10/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-540-g3640150b3b169/arm/shmobile_defconfig/gcc-=
10/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6583842543af6d8f7de13=
4e7
        failing since 6 days (last pass: v5.10.201-cip41-473-gc43d7b7bbe83a=
, first fail: v5.10.201-cip41-69-g8f7b450fc28ed) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6583896c350dad0c00e13498

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-540-g3640150b3b169/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-540-g3640150b3b169/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6583896c350dad0c00e1349d
        failing since 146 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-12-21T00:39:45.236859  + set +x
    2023-12-21T00:39:45.240498  <8>[   83.931499] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1063246_1.5.2.4.1>
    2023-12-21T00:39:45.346749  / # #
    2023-12-21T00:39:46.802374  export SHELL=3D/bin/sh
    2023-12-21T00:39:46.822860  #
    2023-12-21T00:39:46.823086  / # export SHELL=3D/bin/sh
    2023-12-21T00:39:48.769484  / # . /lava-1063246/environment
    2023-12-21T00:39:52.351450  /lava-1063246/bin/lava-test-runner /lava-10=
63246/1
    2023-12-21T00:39:52.372074  . /lava-1063246/environment
    2023-12-21T00:39:52.372201  / # /lava-1063246/bin/lava-test-runner /lav=
a-1063246/1 =

    ... (28 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/65838a8bf5eb266dfce13476

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-540-g3640150b3b169/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-540-g3640150b3b169/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-r8a774b1-hihope-rzg2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65838a8bf5eb266dfce1347b
        failing since 146 days (last pass: v5.10.182-cip35-289-g3c054954070=
6, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-12-21T00:44:38.517761  + set +x
    2023-12-21T00:44:38.520950  <8>[   84.309607] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1063237_1.5.2.4.1>
    2023-12-21T00:44:38.628122  / # #
    2023-12-21T00:44:40.083273  export SHELL=3D/bin/sh
    2023-12-21T00:44:40.103928  #
    2023-12-21T00:44:40.104245  / # export SHELL=3D/bin/sh
    2023-12-21T00:44:42.052084  / # . /lava-1063237/environment
    2023-12-21T00:44:45.635143  /lava-1063237/bin/lava-test-runner /lava-10=
63237/1
    2023-12-21T00:44:45.656263  . /lava-1063237/environment
    2023-12-21T00:44:45.656544  / # /lava-1063237/bin/lava-test-runner /lav=
a-1063237/1 =

    ... (15 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a774c0-ek874           | arm64 | lab-cip       | gcc-10   | defconfig+kse=
lftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/658385db2031d3e4b2e13482

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-540-g3640150b3b169/arm64/defconfig+kselftest/g=
cc-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-540-g3640150b3b169/arm64/defconfig+kselftest/g=
cc-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/658385db2031d3e4b2e13487
        failing since 146 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-12-21T00:24:37.939856  / # #
    2023-12-21T00:24:39.399837  export SHELL=3D/bin/sh
    2023-12-21T00:24:39.420830  #
    2023-12-21T00:24:39.421367  / # export SHELL=3D/bin/sh
    2023-12-21T00:24:41.373217  / # . /lava-1063191/environment
    2023-12-21T00:24:44.964507  /lava-1063191/bin/lava-test-runner /lava-10=
63191/1
    2023-12-21T00:24:44.986071  . /lava-1063191/environment
    2023-12-21T00:24:44.986442  / # /lava-1063191/bin/lava-test-runner /lav=
a-1063191/1
    2023-12-21T00:24:45.166742  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-21T00:24:45.167213  + cd /lava-1063191/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a774c0-ek874           | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/658387e397512a3d80e13536

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-540-g3640150b3b169/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-540-g3640150b3b169/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/658387e397512a3d80e1353b
        failing since 146 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-12-21T00:33:22.297164  / # #
    2023-12-21T00:33:23.754840  export SHELL=3D/bin/sh
    2023-12-21T00:33:23.775680  #
    2023-12-21T00:33:23.776105  / # export SHELL=3D/bin/sh
    2023-12-21T00:33:25.724355  / # . /lava-1063231/environment
    2023-12-21T00:33:29.308215  /lava-1063231/bin/lava-test-runner /lava-10=
63231/1
    2023-12-21T00:33:29.329871  . /lava-1063231/environment
    2023-12-21T00:33:29.330334  / # /lava-1063231/bin/lava-test-runner /lav=
a-1063231/1
    2023-12-21T00:33:29.406775  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-21T00:33:29.407507  + cd /lava-1063231/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a774c0-ek874           | arm64 | lab-cip       | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/65838a9ff5eb266dfce13482

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-540-g3640150b3b169/arm64/defconfig/gcc-10/lab-=
cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-540-g3640150b3b169/arm64/defconfig/gcc-10/lab-=
cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65838a9ff5eb266dfce13487
        failing since 146 days (last pass: v5.10.182-cip35-289-g3c054954070=
6, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-12-21T00:44:50.833902  / # #
    2023-12-21T00:44:52.292244  export SHELL=3D/bin/sh
    2023-12-21T00:44:52.313174  #
    2023-12-21T00:44:52.313654  / # export SHELL=3D/bin/sh
    2023-12-21T00:44:54.262318  / # . /lava-1063253/environment
    2023-12-21T00:44:57.846256  /lava-1063253/bin/lava-test-runner /lava-10=
63253/1
    2023-12-21T00:44:57.867022  . /lava-1063253/environment
    2023-12-21T00:44:57.867190  / # /lava-1063253/bin/lava-test-runner /lav=
a-1063253/1
    2023-12-21T00:44:57.902417  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-21T00:44:57.946803  + cd /lava-1063253/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a77960-ulcb            | arm64 | lab-collabora | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/658387583b3c44ad01e13498

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-540-g3640150b3b169/arm64/defconfig/gcc-10/lab-=
collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-540-g3640150b3b169/arm64/defconfig/gcc-10/lab-=
collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/658387583b3c44ad01e1349d
        failing since 146 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-12-21T00:38:28.635673  / # #

    2023-12-21T00:38:28.738062  export SHELL=3D/bin/sh

    2023-12-21T00:38:28.738830  #

    2023-12-21T00:38:28.840264  / # export SHELL=3D/bin/sh. /lava-12332379/=
environment

    2023-12-21T00:38:28.841077  =


    2023-12-21T00:38:28.942598  / # . /lava-12332379/environment/lava-12332=
379/bin/lava-test-runner /lava-12332379/1

    2023-12-21T00:38:28.943825  =


    2023-12-21T00:38:28.959049  / # /lava-12332379/bin/lava-test-runner /la=
va-12332379/1

    2023-12-21T00:38:29.009659  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-21T00:38:29.010169  + cd /lav<8>[   16.425160] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12332379_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
...ok+kselftest | 2          =


  Details:     https://kernelci.org/test/plan/id/658383f1e1a70c1abee13490

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-540-g3640150b3b169/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-540-g3640150b3b169/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/658383f1e1a70c1abee13496
        failing since 244 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-12-21T00:19:02.475284  /lava-12332106/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/658383f1e1a70c1abee13497
        failing since 244 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-12-21T00:19:01.373507  /lava-12332106/1/../bin/lava-test-case

    2023-12-21T00:19:01.399359  <8>[   43.911864] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6583878edab32a9700e134f0

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-540-g3640150b3b169/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-540-g3640150b3b169/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/6583878edab32a9700e134f6
        failing since 244 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-12-21T00:32:00.225598  /lava-12332336/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/6583878edab32a9700e134f7
        failing since 244 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-12-21T00:31:58.164121  <8>[   60.128727] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-12-21T00:31:59.188044  /lava-12332336/1/../bin/lava-test-case

    2023-12-21T00:31:59.198845  <8>[   61.164583] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig+kse=
lftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6583843943af6d8f7de13513

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-540-g3640150b3b169/arm64/defconfig+kselftest/g=
cc-10/lab-collabora/baseline-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-540-g3640150b3b169/arm64/defconfig+kselftest/g=
cc-10/lab-collabora/baseline-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6583843943af6d8f7de13518
        failing since 116 days (last pass: v5.10.186-cip37-770-gddd36cfc4c4=
c8, first fail: v5.10.186-cip37-982-g80a0585c0aa62)

    2023-12-21T00:17:47.451443  / # #

    2023-12-21T00:17:48.712110  export SHELL=3D/bin/sh

    2023-12-21T00:17:48.723062  #

    2023-12-21T00:17:48.723538  / # export SHELL=3D/bin/sh

    2023-12-21T00:17:50.466910  / # . /lava-12332117/environment

    2023-12-21T00:17:53.670882  /lava-12332117/bin/lava-test-runner /lava-1=
2332117/1

    2023-12-21T00:17:53.682345  . /lava-12332117/environment

    2023-12-21T00:17:53.687945  / # /lava-12332117/bin/lava-test-runner /la=
va-12332117/1

    2023-12-21T00:17:53.813982  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-21T00:17:53.814476  + cd /lava-12332117/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/65838782dab32a9700e134e2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-540-g3640150b3b169/arm64/defconfig/gcc-10/lab-=
collabora/baseline-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-540-g3640150b3b169/arm64/defconfig/gcc-10/lab-=
collabora/baseline-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65838782dab32a9700e134e7
        failing since 116 days (last pass: v5.10.186-cip37-770-gddd36cfc4c4=
c8, first fail: v5.10.186-cip37-982-g80a0585c0aa62)

    2023-12-21T00:36:20.993207  / # #

    2023-12-21T00:36:22.253226  export SHELL=3D/bin/sh

    2023-12-21T00:36:22.264088  #

    2023-12-21T00:36:24.003710  / # export SHELL=3D/bin/sh. /lava-12332382/=
environment

    2023-12-21T00:36:24.014011  =


    2023-12-21T00:36:24.014100  / # . /lava-12332382/environment

    2023-12-21T00:36:27.200158  / # /lava-12332382/bin/lava-test-runner /la=
va-12332382/1

    2023-12-21T00:36:27.210635  /lava-12332382/bin/lava-test-runner /lava-1=
2332382/1

    2023-12-21T00:36:27.265003  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-21T00:36:27.265146  + cd /lava-12332382/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
sun50i-h6-pine-h64       | arm64 | lab-collabora | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/658387566c77dbee3ee13475

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-540-g3640150b3b169/arm64/defconfig/gcc-10/lab-=
collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-540-g3640150b3b169/arm64/defconfig/gcc-10/lab-=
collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/658387566c77dbee3ee1347a
        failing since 146 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-12-21T00:38:39.174671  / # #

    2023-12-21T00:38:39.276802  export SHELL=3D/bin/sh

    2023-12-21T00:38:39.277510  #

    2023-12-21T00:38:39.378810  / # export SHELL=3D/bin/sh. /lava-12332374/=
environment

    2023-12-21T00:38:39.379532  =


    2023-12-21T00:38:39.481005  / # . /lava-12332374/environment/lava-12332=
374/bin/lava-test-runner /lava-12332374/1

    2023-12-21T00:38:39.482095  =


    2023-12-21T00:38:39.498900  / # /lava-12332374/bin/lava-test-runner /la=
va-12332374/1

    2023-12-21T00:38:39.540903  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-21T00:38:39.557992  + cd /lava-1233237<8>[   18.262201] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12332374_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

