Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E649C77B7C
	for <webhook@archiver.kernel.org>; Mon, 29 May 2023 00:27:00 +0000 (UTC)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
 by mx.groups.io with SMTP id smtpd.web10.40087.1685320018738199029
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 28 May 2023 17:26:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=LGzq8P5e;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.174, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-64fd7723836so390450b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 28 May 2023 17:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685320018; x=1687912018;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2ShU3Quj+OfE0iWXw0XseRUO47s+/4peufmm+x56gOI=;
        b=LGzq8P5eNiqkyraRu2IgI+xmOHZM1JoZ/yU4UqgOCuf0ABB6Ylw3UdMRwXWKSNHYyd
         ggfN4zqzjBmFyVtH2cXGcB7s8ZUPwYDQ7rKkqnpOCucUMPS2g7Co7IK4W2tSS//D92lI
         MvretojZhHpRma8dxN0bJWtF4qZFVZ9LsWt9n1WPqF0lxtOVGu7JvHvEf5O+u0ZO6v8J
         cNXqI1XIfHd6LE3n0P4oO0ndXJfWstKSyef10RQCxh8TWwHmxL+HH6/3aqMWT37SNces
         IAjav1vIGY4oDwhlC425LWzhdYw1SOKNfvmgmFxBCOLhefUcPzbusP4FwD3NY0rKrEnG
         JLKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685320018; x=1687912018;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ShU3Quj+OfE0iWXw0XseRUO47s+/4peufmm+x56gOI=;
        b=dASofGX0FCgUSs1t7b5X+irli9LnxnfIc6n6kwT12zC2wcH09QzFR8geo5i+2ll5oA
         gNLydifVu5a1rb5Mx6oizDkuM6AawQV/qJRsZxvwTC+CU5dgU++AmJHNgSk54K0MWkvO
         vE/LWfcNqsgvPJMRPCZ3YBCXqiccb7ivaFDZvRrNbDRlmW5sPi1tHhhCVRAk2qVq01n2
         iGpNzmdY30SC0PjQL8y2+UGLG6V9bP3mpP5ZFj0htmkFQ1dAKsLyJ9s0GOluKPzUVSmS
         E6U/FvVvwYq/h5DlOLGmQIK3Va+NVqYbkdFXA3AIQZoUpxJCUkUMoiBPaBDlDNmqfJ2z
         qrcQ==
X-Gm-Message-State: AC+VfDykU/h6UpAdyp66Ijql4Ju9M+3hxhNUYV8/w7y5Il+Y2Zk1Hu+7
	CIAtKvEW4WU7Rz0XKdG5MsdcrCU5REXkOKjrsmhEyg==
X-Google-Smtp-Source: ACHHUZ5W8C+E2fzI7A3vMS2M9RDfDqmF00YC/5553HmlO9zFEf1/9WZI5o54QfSiv9OoNDpMYb3hZg==
X-Received: by 2002:a05:6a20:3c9f:b0:10b:2ed8:1859 with SMTP id b31-20020a056a203c9f00b0010b2ed81859mr8892981pzj.6.1685320017427;
        Sun, 28 May 2023 17:26:57 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u2-20020aa78382000000b00625037cf695sm5629857pfm.86.2023.05.28.17.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 17:26:56 -0700 (PDT)
Message-ID: <6473f150.a70a0220.63ff4.b03d@mx.google.com>
Date: Sun, 28 May 2023 17:26:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.180-cip33-21-g8eb0cdf459a2
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip baseline-nfs: 52 runs,
 12 regressions (v5.10.180-cip33-21-g8eb0cdf459a2)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 May 2023 00:27:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11673

cip/linux-5.10.y-cip baseline-nfs: 52 runs, 12 regressions (v5.10.180-cip33=
-21-g8eb0cdf459a2)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.180-cip33-21-g8eb0cdf459a2/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.180-cip33-21-g8eb0cdf459a2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      8eb0cdf459a2bb2971bbf3eecc4f894d2717cff9 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6473e4cf71b0c9a4b42e85f4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-nfs-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-nfs-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230519.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6473e4cf71b0c9a4b42e85f9
        failing since 134 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-28T23:33:21.290781  [   18.438904] <LAVA_SIGNAL_ENDRUN 0_dmesg =
10500356_1.5.2.3.1>

    2023-05-28T23:33:21.294030  + set +x

    2023-05-28T23:33:21.398616  / # #

    2023-05-28T23:33:21.499330  export SHELL=3D/bin/sh

    2023-05-28T23:33:21.499519  #

    2023-05-28T23:33:21.599984  / # export SHELL=3D/bin/sh. /lava-10500356/=
environment

    2023-05-28T23:33:21.600207  =


    2023-05-28T23:33:21.700753  / # . /lava-10500356/environment/lava-10500=
356/bin/lava-test-runner /lava-10500356/1

    2023-05-28T23:33:21.701091  =


    2023-05-28T23:33:21.706280  / # /lava-10500356/bin/lava-test-runner /la=
va-10500356/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6473e6c3b4292ec5702e85f0

  Results:     47 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-=
nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-=
nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230519.0/armel/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6473e6c4b4292ec5702e8625
        failing since 134 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-28T23:41:31.870976  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 528446_1.6.2=
.4.1>
    2023-05-28T23:41:32.003609  #
    2023-05-28T23:41:32.106761  / # #export SHELL=3D/bin/sh
    2023-05-28T23:41:32.107619  =

    2023-05-28T23:41:32.209538  / # export SHELL=3D/bin/sh. /lava-528446/en=
vironment
    2023-05-28T23:41:32.210322  =

    2023-05-28T23:41:32.312397  / # . /lava-528446/environment/lava-528446/=
bin/lava-test-runner /lava-528446/1
    2023-05-28T23:41:32.313685  =

    2023-05-28T23:41:32.320082  / # /lava-528446/bin/lava-test-runner /lava=
-528446/1
    2023-05-28T23:41:32.727850  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6473e6c8292551cf422e85fe

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-=
nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-=
nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230519.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6473e6c8292551cf422e8629
        failing since 134 days (last pass: v5.10.158-cip22, first fail: v5.=
10.162-cip24)

    2023-05-28T23:41:24.098735  <8>[   50.955472] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 528484_1.6.2.4.1>
    2023-05-28T23:41:24.215116  / # #
    2023-05-28T23:41:24.317455  export SHELL=3D/bin/sh
    2023-05-28T23:41:24.318055  #
    2023-05-28T23:41:24.419724  / # export SHELL=3D/bin/sh. /lava-528484/en=
vironment
    2023-05-28T23:41:24.420386  =

    2023-05-28T23:41:24.522025  / # . /lava-528484/environment/lava-528484/=
bin/lava-test-runner /lava-528484/1
    2023-05-28T23:41:24.522997  =

    2023-05-28T23:41:24.527013  / # /lava-528484/bin/lava-test-runner /lava=
-528484/1
    2023-05-28T23:41:24.723345  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6473ea4fe8425705db2e85e7

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-=
beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-=
beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230519.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6473ea4fe8425705db2e85ea
        failing since 134 days (last pass: v5.10.158-cip22, first fail: v5.=
10.162-cip24)

    2023-05-28T23:56:25.140987  / # #
    2023-05-28T23:56:25.242567  export SHELL=3D/bin/sh
    2023-05-28T23:56:25.242901  #
    2023-05-28T23:56:25.343975  / # export SHELL=3D/bin/sh. /lava-945902/en=
vironment
    2023-05-28T23:56:25.344299  =

    2023-05-28T23:56:25.445402  / # . /lava-945902/environment/lava-945902/=
bin/lava-test-runner /lava-945902/1
    2023-05-28T23:56:25.445904  =

    2023-05-28T23:56:25.454266  / # /lava-945902/bin/lava-test-runner /lava=
-945902/1
    2023-05-28T23:56:25.925911  + export TESTRUN_ID=3D1_bootrr
    2023-05-28T23:56:25.926120  + cd /lava-945902/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6473eb80943f5bdd7b2e85ec

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline=
-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline=
-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230519.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6473eb80943f5bdd7b2e8622
        failing since 117 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.165-cip25)

    2023-05-29T00:01:41.789359  <8>[   45.093922] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 528623_1.6.2.4.1>
    2023-05-29T00:01:41.917165  / # #
    2023-05-29T00:01:42.018982  export SHELL=3D/bin/sh
    2023-05-29T00:01:42.019560  #
    2023-05-29T00:01:42.120969  / # export SHELL=3D/bin/sh. /lava-528623/en=
vironment
    2023-05-29T00:01:42.121400  =

    2023-05-29T00:01:42.222793  / # . /lava-528623/environment/lava-528623/=
bin/lava-test-runner /lava-528623/1
    2023-05-29T00:01:42.223474  =

    2023-05-29T00:01:42.227870  / # /lava-528623/bin/lava-test-runner /lava=
-528623/1
    2023-05-29T00:01:42.492739  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6473ee73405d8bd3fd2e85f5

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs=
-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs=
-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230519.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6473ee73405d8bd3fd2e85f8
        failing since 117 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.165-cip25)

    2023-05-29T00:14:18.387975  / # #
    2023-05-29T00:14:18.491647  export SHELL=3D/bin/sh
    2023-05-29T00:14:18.492724  #
    2023-05-29T00:14:18.595192  / # export SHELL=3D/bin/sh. /lava-945970/en=
vironment
    2023-05-29T00:14:18.596259  =

    2023-05-29T00:14:18.698787  / # . /lava-945970/environment/lava-945970/=
bin/lava-test-runner /lava-945970/1
    2023-05-29T00:14:18.700484  =

    2023-05-29T00:14:18.713834  / # /lava-945970/bin/lava-test-runner /lava=
-945970/1
    2023-05-29T00:14:19.001287  + export TESTRUN_ID=3D1_bootrr
    2023-05-29T00:14:19.017135  + cd /lava-945970/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6473e4d9525e7997ca2e8666

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230519.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6473e4d9525e7997ca2e866b
        failing since 44 days (last pass: v5.10.176-cip30, first fail: v5.1=
0.177-cip31)

    2023-05-28T23:33:21.092780  + <8>[   17.895446] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10500406_1.5.2.3.1>

    2023-05-28T23:33:21.092917  set +x

    2023-05-28T23:33:21.198091  / # #

    2023-05-28T23:33:21.300723  export SHELL=3D/bin/sh

    2023-05-28T23:33:21.301577  #

    2023-05-28T23:33:21.403245  / # export SHELL=3D/bin/sh. /lava-10500406/=
environment

    2023-05-28T23:33:21.403443  =


    2023-05-28T23:33:21.503963  / # . /lava-10500406/environment/lava-10500=
406/bin/lava-test-runner /lava-10500406/1

    2023-05-28T23:33:21.504209  =


    2023-05-28T23:33:21.508755  / # /lava-10500406/bin/lava-test-runner /la=
va-10500406/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6473e4ce32b82ebdb22e85f7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230519.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6473e4ce32b82ebdb22e85fc
        failing since 44 days (last pass: v5.10.176-cip30, first fail: v5.1=
0.177-cip31)

    2023-05-28T23:33:06.546331  + set +x

    2023-05-28T23:33:06.552811  [   19.829539] <LAVA_SIGNAL_ENDRUN 0_dmesg =
10500373_1.5.2.3.1>

    2023-05-28T23:33:06.656745  / # #

    2023-05-28T23:33:06.757547  export SHELL=3D/bin/sh

    2023-05-28T23:33:06.757750  #

    2023-05-28T23:33:06.858235  / # export SHELL=3D/bin/sh. /lava-10500373/=
environment

    2023-05-28T23:33:06.858444  =


    2023-05-28T23:33:06.958962  / # . /lava-10500373/environment/lava-10500=
373/bin/lava-test-runner /lava-10500373/1

    2023-05-28T23:33:06.959321  =


    2023-05-28T23:33:06.964728  / # /lava-10500373/bin/lava-test-runner /la=
va-10500373/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6473e607f7892a05852e8618

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/arm/multi_v7_defconfig/gcc-10/lab-collabora/baselin=
e-nfs-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/arm/multi_v7_defconfig/gcc-10/lab-collabora/baselin=
e-nfs-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230519.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6473e607f7892a05852e861d
        failing since 134 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-28T23:38:28.809109  / # #

    2023-05-28T23:38:28.911769  export SHELL=3D/bin/sh

    2023-05-28T23:38:28.912461  #

    2023-05-28T23:38:29.014150  / # export SHELL=3D/bin/sh. /lava-10500440/=
environment

    2023-05-28T23:38:29.014929  =


    2023-05-28T23:38:29.116488  / # . /lava-10500440/environment/lava-10500=
440/bin/lava-test-runner /lava-10500440/1

    2023-05-28T23:38:29.116818  =


    2023-05-28T23:38:29.120846  / # /lava-10500440/bin/lava-test-runner /la=
va-10500440/1

    2023-05-28T23:38:29.327578  + export TESTRUN_ID=3D1_bootrr

    2023-05-28T23:38:29.327665  + cd /lava-10500440/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6473e7147080ddab042e860e

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230519.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/6473e7147080ddab042e8659
        failing since 67 days (last pass: v5.10.173-cip28, first fail: v5.1=
0.175-cip29)

    2023-05-28T23:43:04.019559  [   37.601292] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-05-28T23:43:05.076587  /lava-10500568/1/../bin/lava-test-case

    2023-05-28T23:43:05.115658  [   38.698298] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/6473e7147080ddab042e865a
        failing since 67 days (last pass: v5.10.173-cip28, first fail: v5.1=
0.175-cip29)

    2023-05-28T23:43:02.920387  [   36.502966] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-05-28T23:43:03.979188  /lava-10500568/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6473e883299102c78e2e86b0

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-sun=
50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-sun=
50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230519.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6473e883299102c78e2e86dc
        failing since 134 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-28T23:48:50.599867  [   35.417146] <LAVA_SIGNAL_ENDRUN 0_dmesg =
528551_1.6.2.4.1>
    2023-05-28T23:48:50.725820  #
    2023-05-28T23:48:50.829188  / # #export SHELL=3D/bin/sh
    2023-05-28T23:48:50.829897  =

    2023-05-28T23:48:50.932115  / # export SHELL=3D/bin/sh. /lava-528551/en=
vironment
    2023-05-28T23:48:50.932712  =

    2023-05-28T23:48:51.034969  / # . /lava-528551/environment/lava-528551/=
bin/lava-test-runner /lava-528551/1
    2023-05-28T23:48:51.036386  =

    2023-05-28T23:48:51.040807  / # /lava-528551/bin/lava-test-runner /lava=
-528551/1
    2023-05-28T23:48:51.200820  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =20

