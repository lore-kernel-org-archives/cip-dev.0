Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45ABEB64D9
	for <webhook@archiver.kernel.org>; Thu,  6 Jul 2023 04:00:17 +0000 (UTC)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
 by mx.groups.io with SMTP id smtpd.web10.14037.1688616010312959189
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 05 Jul 2023 21:00:10 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=WNYi8l2o;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.171, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-52cb8e5e9f5so170056a12.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 05 Jul 2023 21:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1688616009; x=1691208009;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4iTTHbQUDFi9rFVMjHcYOxdg6qKtVvXpZFqlJ1jECIU=;
        b=WNYi8l2og/BnBrxo8Lc27kI2WiFj2b1jrwkWV9EbrwVg1tCpb8ZDG+KsbdhPd7IMAx
         1dvthNCAbkwLiv1Lhkaxi5XMcxiGXaxZEn2gPAsl89/NNLBfWKZe6KmW9zVjD7OpItvQ
         4J6GC3+JrJ4MkedMYxoGlpIqKbSNvG6YTVoIe8GKb0LYW3R+pgVc+lb5uRU/EH8lKd9n
         KHAcQEil11OzS09WXHJ6JfFi5pd7px7sRtYaR6UQisphXwKy3y7J2crF/PV5/9DYsUyk
         ILaXg5wI9HtAODnxhhiQENo5VqmCibj+DRnfFwTpuQrbNTcclVMhu8n23Jfy1gkIpjsF
         c+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688616009; x=1691208009;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4iTTHbQUDFi9rFVMjHcYOxdg6qKtVvXpZFqlJ1jECIU=;
        b=DuiJt6fVzFDxkQx+Br5SpsYXYfspbeknAHLnbVM8CjpfQYIKobB+jcI4dWDYIFuWQv
         naR5MKu8bq2Y9vTdRz1yM4twM6KR+fABwcKTYBxM8ISfNLKybw0EjfKlkDEc7fP1QdWT
         VM62rv2SXIsNnw9oh+X9oRZCixMGMLpTb/JdiTGZlzhHj4bd9Be/MKNtzXerH46dWZR6
         maGtm6tVR740jNMfzg+8ehuK9w+54lTRz5edKsZfa/d7pylCecia2eR1/eu2Z0zKshYM
         ibWaNYHmRJkazfg72VXAU4nU9+ccv+V7RqoHbD8yGBZfscgJkXKu8ucNfVS9L9c5S0LY
         g3Bw==
X-Gm-Message-State: ABy/qLYRy0Sxd6rv6sLCzezm19m0L/MCNCuhgtlnJQCFEjlEECuCHY2Z
	hUv1dKxKFDbNrNecJdD8qM0shJEuDTJhMArzlFSVig==
X-Google-Smtp-Source: APBJJlFa43SLOEE4XCc65mYEYdVKfhVSzv3NIPy1vWwh9p5MOD/bQx3SETqncgYIg1T382HY0M686w==
X-Received: by 2002:a05:6a20:1591:b0:122:cb18:2e8c with SMTP id h17-20020a056a20159100b00122cb182e8cmr1690578pzj.6.1688616008705;
        Wed, 05 Jul 2023 21:00:08 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x15-20020a62fb0f000000b00682936d04ccsm256865pfm.180.2023.07.05.21.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 21:00:07 -0700 (PDT)
Message-ID: <64a63c47.620a0220.92af5.0a2e@mx.google.com>
Date: Wed, 05 Jul 2023 21:00:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.184-cip36-8-gb192df20e8c9
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y-cip
Subject: cip/linux-5.10.y-cip baseline: 56 runs,
 11 regressions (v5.10.184-cip36-8-gb192df20e8c9)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Jul 2023 04:00:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12245

cip/linux-5.10.y-cip baseline: 56 runs, 11 regressions (v5.10.184-cip36-8-g=
b192df20e8c9)

Regressions Summary
-------------------

platform          | arch | lab           | compiler | defconfig           |=
 regressions
------------------+------+---------------+----------+---------------------+=
------------
at91sam9g20ek     | arm  | lab-broonie   | gcc-10   | multi_v5_defconfig  |=
 1          =

beaglebone-black  | arm  | lab-broonie   | gcc-10   | multi_v7_defconfig  |=
 1          =

beaglebone-black  | arm  | lab-cip       | gcc-10   | multi_v7_defconfig  |=
 1          =

beaglebone-black  | arm  | lab-broonie   | gcc-10   | omap2plus_defconfig |=
 1          =

beaglebone-black  | arm  | lab-cip       | gcc-10   | omap2plus_defconfig |=
 1          =

imx6q-sabrelite   | arm  | lab-collabora | gcc-10   | multi_v7_defconfig  |=
 1          =

r8a7743-iwg20d-q7 | arm  | lab-cip       | gcc-10   | shmobile_defconfig  |=
 1          =

rk3288-veyron-jaq | arm  | lab-collabora | gcc-10   | multi_v7_defconfig  |=
 4          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.184-cip36-8-gb192df20e8c9/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.184-cip36-8-gb192df20e8c9
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      b192df20e8c9dda03e005d4cb4909d846ea437bb =



Test Regressions
---------------- =



platform          | arch | lab           | compiler | defconfig           |=
 regressions
------------------+------+---------------+----------+---------------------+=
------------
at91sam9g20ek     | arm  | lab-broonie   | gcc-10   | multi_v5_defconfig  |=
 1          =


  Details:     https://kernelci.org/test/plan/id/64a62f549db1be218bbb2a75

  Results:     47 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-8-gb192df20e8c9/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-a=
t91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-8-gb192df20e8c9/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-a=
t91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a62f549db1be218bbb2aaa
        failing since 173 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-07-06T03:04:12.479675  + set +x
    2023-07-06T03:04:12.484890  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 700318_1.5.2=
.4.1>
    2023-07-06T03:04:12.598751  / # #
    2023-07-06T03:04:12.701646  export SHELL=3D/bin/sh
    2023-07-06T03:04:12.702438  #
    2023-07-06T03:04:12.804419  / # export SHELL=3D/bin/sh. /lava-700318/en=
vironment
    2023-07-06T03:04:12.805196  =

    2023-07-06T03:04:12.907218  / # . /lava-700318/environment/lava-700318/=
bin/lava-test-runner /lava-700318/1
    2023-07-06T03:04:12.908586  =

    2023-07-06T03:04:12.915030  / # /lava-700318/bin/lava-test-runner /lava=
-700318/1 =

    ... (12 line(s) more)  =

 =



platform          | arch | lab           | compiler | defconfig           |=
 regressions
------------------+------+---------------+----------+---------------------+=
------------
beaglebone-black  | arm  | lab-broonie   | gcc-10   | multi_v7_defconfig  |=
 1          =


  Details:     https://kernelci.org/test/plan/id/64a63335cb19873726bb2a97

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-8-gb192df20e8c9/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-b=
eaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-8-gb192df20e8c9/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-b=
eaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a63335cb19873726bb2ac1
        failing since 173 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-07-06T03:20:51.931794  <8>[   23.217255] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 700372_1.5.2.4.1>
    2023-07-06T03:20:52.041046  / # #
    2023-07-06T03:20:52.143600  export SHELL=3D/bin/sh
    2023-07-06T03:20:52.144340  #
    2023-07-06T03:20:52.246748  / # export SHELL=3D/bin/sh. /lava-700372/en=
vironment
    2023-07-06T03:20:52.247530  =

    2023-07-06T03:20:52.349906  / # . /lava-700372/environment/lava-700372/=
bin/lava-test-runner /lava-700372/1
    2023-07-06T03:20:52.351131  =

    2023-07-06T03:20:52.354658  / # /lava-700372/bin/lava-test-runner /lava=
-700372/1
    2023-07-06T03:20:52.450128  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform          | arch | lab           | compiler | defconfig           |=
 regressions
------------------+------+---------------+----------+---------------------+=
------------
beaglebone-black  | arm  | lab-cip       | gcc-10   | multi_v7_defconfig  |=
 1          =


  Details:     https://kernelci.org/test/plan/id/64a639b5838714ffc9bb2a96

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-8-gb192df20e8c9/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beagl=
ebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-8-gb192df20e8c9/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beagl=
ebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a639b5838714ffc9bb2a99
        failing since 173 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-07-06T03:48:39.975510  + set +x
    2023-07-06T03:48:39.977555  <8>[   16.652974] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 982563_1.5.2.4.1>
    2023-07-06T03:48:40.085658  / # #
    2023-07-06T03:48:40.187534  export SHELL=3D/bin/sh
    2023-07-06T03:48:40.187978  #
    2023-07-06T03:48:40.289400  / # export SHELL=3D/bin/sh. /lava-982563/en=
vironment
    2023-07-06T03:48:40.289855  =

    2023-07-06T03:48:40.391273  / # . /lava-982563/environment/lava-982563/=
bin/lava-test-runner /lava-982563/1
    2023-07-06T03:48:40.392037  =

    2023-07-06T03:48:40.394181  / # /lava-982563/bin/lava-test-runner /lava=
-982563/1 =

    ... (12 line(s) more)  =

 =



platform          | arch | lab           | compiler | defconfig           |=
 regressions
------------------+------+---------------+----------+---------------------+=
------------
beaglebone-black  | arm  | lab-broonie   | gcc-10   | omap2plus_defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/64a62a62c1d156eaeabb2abe

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-8-gb192df20e8c9/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-=
beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-8-gb192df20e8c9/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-=
beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a62a62c1d156eaeabb2af1
        failing since 172 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-07-06T02:43:30.291061  <8>[   21.449250] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 700261_1.5.2.4.1>
    2023-07-06T02:43:30.402114  / # #
    2023-07-06T02:43:30.505017  export SHELL=3D/bin/sh
    2023-07-06T02:43:30.505748  #
    2023-07-06T02:43:30.608208  / # export SHELL=3D/bin/sh. /lava-700261/en=
vironment
    2023-07-06T02:43:30.609003  =

    2023-07-06T02:43:30.711430  / # . /lava-700261/environment/lava-700261/=
bin/lava-test-runner /lava-700261/1
    2023-07-06T02:43:30.712588  =

    2023-07-06T02:43:30.717361  / # /lava-700261/bin/lava-test-runner /lava=
-700261/1
    2023-07-06T02:43:30.822034  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform          | arch | lab           | compiler | defconfig           |=
 regressions
------------------+------+---------------+----------+---------------------+=
------------
beaglebone-black  | arm  | lab-cip       | gcc-10   | omap2plus_defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/64a62a50c1d156eaeabb2a77

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-8-gb192df20e8c9/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-8-gb192df20e8c9/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a62a50c1d156eaeabb2a7a
        failing since 172 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-07-06T02:43:15.039377  + set +x
    2023-07-06T02:43:15.041423  <8>[   13.925334] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 982540_1.5.2.4.1>
    2023-07-06T02:43:15.150582  / # #
    2023-07-06T02:43:15.252382  export SHELL=3D/bin/sh
    2023-07-06T02:43:15.252825  #
    2023-07-06T02:43:15.354203  / # export SHELL=3D/bin/sh. /lava-982540/en=
vironment
    2023-07-06T02:43:15.354702  =

    2023-07-06T02:43:15.456100  / # . /lava-982540/environment/lava-982540/=
bin/lava-test-runner /lava-982540/1
    2023-07-06T02:43:15.456830  =

    2023-07-06T02:43:15.458978  / # /lava-982540/bin/lava-test-runner /lava=
-982540/1 =

    ... (12 line(s) more)  =

 =



platform          | arch | lab           | compiler | defconfig           |=
 regressions
------------------+------+---------------+----------+---------------------+=
------------
imx6q-sabrelite   | arm  | lab-collabora | gcc-10   | multi_v7_defconfig  |=
 1          =


  Details:     https://kernelci.org/test/plan/id/64a632fb02e0792c47bb2a9d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-8-gb192df20e8c9/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline=
-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-8-gb192df20e8c9/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline=
-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a632fb02e0792c47bb2aa2
        failing since 173 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-07-06T03:20:21.818034  / # #

    2023-07-06T03:20:21.920211  export SHELL=3D/bin/sh

    2023-07-06T03:20:21.920891  #

    2023-07-06T03:20:22.022601  / # export SHELL=3D/bin/sh. /lava-11025640/=
environment

    2023-07-06T03:20:22.023292  =


    2023-07-06T03:20:22.124893  / # . /lava-11025640/environment/lava-11025=
640/bin/lava-test-runner /lava-11025640/1

    2023-07-06T03:20:22.125970  =


    2023-07-06T03:20:22.141411  / # /lava-11025640/bin/lava-test-runner /la=
va-11025640/1

    2023-07-06T03:20:22.205581  + export 'TESTRUN_ID=3D1_bootrr'

    2023-07-06T03:20:22.245654  + cd /lava-11025640/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform          | arch | lab           | compiler | defconfig           |=
 regressions
------------------+------+---------------+----------+---------------------+=
------------
r8a7743-iwg20d-q7 | arm  | lab-cip       | gcc-10   | shmobile_defconfig  |=
 1          =


  Details:     https://kernelci.org/test/plan/id/64a637e39341b856c4bb2ad3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-8-gb192df20e8c9/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a77=
43-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-8-gb192df20e8c9/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a77=
43-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64a637e39341b856c4bb2=
ad4
        failing since 30 days (last pass: v5.10.180-cip34, first fail: v5.1=
0.180-cip34-19-gf0f6960f132cd) =

 =



platform          | arch | lab           | compiler | defconfig           |=
 regressions
------------------+------+---------------+----------+---------------------+=
------------
rk3288-veyron-jaq | arm  | lab-collabora | gcc-10   | multi_v7_defconfig  |=
 4          =


  Details:     https://kernelci.org/test/plan/id/64a632fb7d0f2760c5bb2aa8

  Results:     63 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-8-gb192df20e8c9/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline=
-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-8-gb192df20e8c9/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline=
-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-i2c-present: https://kernelci.or=
g/test/case/id/64a632fb7d0f2760c5bb2ad7
        failing since 171 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-07-06T03:21:53.724605  FIRST,<8>[   21.006810] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>

    2023-07-06T03:21:53.726328   INC default to 1.

    2023-07-06T03:21:53.726572  =


    2023-07-06T03:21:53.730142  	-w	Pad to last with leading zeros

    2023-07-06T03:21:53.732765  	-s SEP	String separator

    2023-07-06T03:21:53.736491  /lava-11025644/1/../bin/lava-test-case

    2023-07-06T03:21:53.742435  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.

    2023-07-06T03:21:53.742820  =


    2023-07-06T03:21:53.752986  Usag<8>[   21.035950] <LAVA_SIGNAL_TESTCASE=
 TEST_CASE_ID=3Ddwhdmi-rockchip-driver-i2c-present RESULT=3Dfail>
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/64a632fb7d0f2760c5bb2ad8
        failing since 171 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-07-06T03:21:53.702188  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC)<8=
>[   20.987585] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-07-06T03:21:53.703988   multi-call binary.

    2023-07-06T03:21:53.704204  =


    2023-07-06T03:21:53.708665  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-07-06T03:21:53.709116  =


    2023-07-06T03:21:53.714035  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/64a632fb7d0f2760c5bb2ad9
        failing since 171 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-07-06T03:21:53.683174  /lava-11025644/1/../bin/lava-test-case<8>[ =
  20.969891] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-probed RE=
SULT=3Dpass>

    2023-07-06T03:21:53.683399  =

   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a632fb7d0f2760c5bb2aed
        failing since 171 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-07-06T03:21:41.621832  <8>[    8.908209] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-07-06T03:21:41.631308  + <8>[    8.920647] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11025644_1.5.2.3.1>

    2023-07-06T03:21:41.631875  set +x

    2023-07-06T03:21:41.738020  #

    2023-07-06T03:21:41.739124  =


    2023-07-06T03:21:41.840741  / # #export SHELL=3D/bin/sh

    2023-07-06T03:21:41.841429  =


    2023-07-06T03:21:41.942780  / # export SHELL=3D/bin/sh. /lava-11025644/=
environment

    2023-07-06T03:21:41.943444  =


    2023-07-06T03:21:42.044743  / # . /lava-11025644/environment/lava-11025=
644/bin/lava-test-runner /lava-11025644/1
 =

    ... (19 line(s) more)  =

 =20

