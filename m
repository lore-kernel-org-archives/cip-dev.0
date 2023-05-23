Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08AFC7EE29
	for <webhook@archiver.kernel.org>; Tue, 23 May 2023 01:41:26 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web11.10934.1684806081114623467
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 22 May 2023 18:41:21 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=qPaI1+vB;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.48, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-253570deb8dso4225065a91.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 22 May 2023 18:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684806080; x=1687398080;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PapDJakjqa9tigctKxcxF1v68bcCCJFiyCCT1ksL4gc=;
        b=qPaI1+vBd6PrHrtparKC+Ez0Uj41puHPwbYrS4Hhtl9Ik2/lxmUl+4gpVYZPsHnv56
         pWbUVlH9YRye0XZ6hwcuB0DmD29d4a7fhTnNo1RSjlAp+wqIfAvWbBo+G/3jqB4uwKFj
         /0HT0oP9uXalFAClPRR/P4+2d2OBQVtw/s+xkK4bEjyXM9UyImjQt9imT8w47kctkX5t
         cd13nSAmt3Mm6XTbYLKa0mbZwlpU0Ur8Tp+YkYFKHD94muuqTjqkdUs6H6gFkn88/pQy
         J6VrpXO0ULiVI8ZtkvbdH8N3S0mxJ1Bg9n94B1JcIhzZXIzIF5Rq9B53g6wSk2SGc6jQ
         76Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684806080; x=1687398080;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PapDJakjqa9tigctKxcxF1v68bcCCJFiyCCT1ksL4gc=;
        b=Qj/NKcLK0KfGRL15wk/cpc2S1omutJPjUta1kDUlyZXHjQI6kIlMAbkFez4yu3LJqa
         NoN+6dL54F1INQ0GYe8UcsWb8AvtJu+2cmsxq7noaVPFWqYDwhDaisIoxnFGz4vauvMW
         vqYnGKsf5r5D3iq2VBIvLqmb6lhgz1Rl9vJ0ISgDVjGaVabspm4/GiLcRDcqglzo4KIW
         KqTi9Ro/G0pscBXs4Ri3ed0JvbpsdiZJkICzzp4yZN/cSSONnK/d7eC9yaJ2Lc8vqPkC
         lbYAyT4He/tKYIV9rG+fb8/wOo2Z5lKbdVaCuJ8Euwhuh0fLJFjJoAdZ+0W4s7d5XOxr
         i3CA==
X-Gm-Message-State: AC+VfDx7dbqZr2QFGQuvtjz08E4kkTU//FtWiwNpsC+VBAnPFc5gZvME
	CLfn3YgI0zN2yhuiu8GQV4XtZmJuKoSCksKiVDIiJw==
X-Google-Smtp-Source: ACHHUZ6SiObEfkHSxLzOylVaPfYh8LVy/kPH3jiGlWmHdblePqwATn37n5cje/YhY5tL5MzrOBhmIg==
X-Received: by 2002:a17:90b:438d:b0:24d:e929:56cf with SMTP id in13-20020a17090b438d00b0024de92956cfmr11259262pjb.39.1684806079625;
        Mon, 22 May 2023 18:41:19 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id gj13-20020a17090b108d00b00250ad795d72sm4633226pjb.44.2023.05.22.18.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 18:41:18 -0700 (PDT)
Message-ID: <646c19be.170a0220.61fea.7fb2@mx.google.com>
Date: Mon, 22 May 2023 18:41:18 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip-rt
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.19.280-cip95-rt30
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip-rt baseline-nfs: 73 runs,
 16 regressions (v4.19.280-cip95-rt30)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 May 2023 01:41:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11595

cip/linux-4.19.y-cip-rt baseline-nfs: 73 runs, 16 regressions (v4.19.280-ci=
p95-rt30)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | defconfig+x=
86-chromebook     | 1          =

asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | defconfig+x=
86-chromebook     | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 1          =

beaglebone-black          | arm    | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =

beaglebone-black          | arm    | lab-broonie   | gcc-10   | defconfig+p=
reempt_rt         | 1          =

beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fc...g+preempt_rt | 1          =

beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =

beaglebone-black          | arm    | lab-broonie   | gcc-10   | omap2plus_d=
efconfig          | 1          =

hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 1          =

imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | defconfig  =
                  | 1          =

imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | defconfig+p=
reempt_rt         | 1          =

imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fc...g+preempt_rt | 1          =

imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =

sun50i-a64-pine64-plus    | arm64  | lab-broonie   | gcc-10   | defconfig+p=
reempt_rt         | 1          =

sun50i-a64-pine64-plus    | arm64  | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip-rt/ke=
rnel/v4.19.280-cip95-rt30/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.19.y-cip-rt
  Describe: v4.19.280-cip95-rt30
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      dcee20e65677ab5d0e0d47c572f2c71dae6074a1 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | defconfig+x=
86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0d7fcb57a86dc92e860d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/646c0d7fcb57a86dc92e8612
        failing since 124 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-05-23T00:48:57.364089  + set +x

    2023-05-23T00:48:57.370573  [   14.538280] <LAVA_SIGNAL_ENDRUN 0_dmesg =
10419505_1.5.2.3.1>

    2023-05-23T00:48:57.474890  / # #

    2023-05-23T00:48:57.575462  export SHELL=3D/bin/sh

    2023-05-23T00:48:57.575676  #

    2023-05-23T00:48:57.676148  / # export SHELL=3D/bin/sh. /lava-10419505/=
environment

    2023-05-23T00:48:57.676336  =


    2023-05-23T00:48:57.776814  / # . /lava-10419505/environment/lava-10419=
505/bin/lava-test-runner /lava-10419505/1

    2023-05-23T00:48:57.777093  =


    2023-05-23T00:48:57.782831  / # /lava-10419505/bin/lava-test-runner /la=
va-10419505/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0e84c48824e89d2e868d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/646c0e84c48824e89d2e8692
        failing since 124 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-05-23T00:52:59.886940  + set +x

    2023-05-23T00:52:59.893154  <8>[   18.195834] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10419571_1.5.2.3.1>

    2023-05-23T00:52:59.997834  / # #

    2023-05-23T00:53:00.098426  export SHELL=3D/bin/sh

    2023-05-23T00:53:00.098598  #

    2023-05-23T00:53:00.199087  / # export SHELL=3D/bin/sh. /lava-10419571/=
environment

    2023-05-23T00:53:00.199288  =


    2023-05-23T00:53:00.299845  / # . /lava-10419571/environment/lava-10419=
571/bin/lava-test-runner /lava-10419571/1

    2023-05-23T00:53:00.300110  =


    2023-05-23T00:53:00.305274  / # /lava-10419571/bin/lava-test-runner /la=
va-10419571/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | defconfig+x=
86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0da8cd250529c42e860a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/646c0da8cd250529c42e860f
        failing since 124 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-05-23T00:49:22.486429  + set +x

    2023-05-23T00:49:22.492299  <8>[   21.535438] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10419524_1.5.2.3.1>

    2023-05-23T00:49:22.604698  /#

    2023-05-23T00:49:22.705590   # #export SHELL=3D/bin/sh

    2023-05-23T00:49:22.705815  =


    2023-05-23T00:49:22.806402  / # export SHELL=3D/bin/sh. /lava-10419524/=
environment

    2023-05-23T00:49:22.806628  =


    2023-05-23T00:49:22.907157  / # . /lava-10419524/environment/lava-10419=
524/bin/lava-test-runner /lava-10419524/1

    2023-05-23T00:49:22.907440  =


    2023-05-23T00:49:22.909297  / # /lava-10419524/bin/lava-test-runner /la=
va-10419524/1
 =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0e849b2e84b97f2e8621

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/646c0e849b2e84b97f2e8626
        failing since 124 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-05-23T00:53:05.669029  [   21.297232] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-05-23T00:53:05.670380  + set +x

    2023-05-23T00:53:05.676613  [   21.307230] <LAVA_SIGNAL_ENDRUN 0_dmesg =
10419603_1.5.2.3.1>

    2023-05-23T00:53:05.782163  #

    2023-05-23T00:53:05.882839  / # #export SHELL=3D/bin/sh

    2023-05-23T00:53:05.883005  =


    2023-05-23T00:53:05.983489  / # export SHELL=3D/bin/sh. /lava-10419603/=
environment

    2023-05-23T00:53:05.983647  =


    2023-05-23T00:53:06.084115  / # . /lava-10419603/environment/lava-10419=
603/bin/lava-test-runner /lava-10419603/1

    2023-05-23T00:53:06.084458  =

 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/646c104a22e9c5758f2e86b6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm/defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-bla=
ck.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm/defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-bla=
ck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/646c104a22e9c5758=
f2e86b7
        new failure (last pass: v4.19.277-cip94-rt29) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | defconfig+p=
reempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/646c13e77d2c54caac2e85e6

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-nfs-bea=
glebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-nfs-bea=
glebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/646c13e77d2c54caac2e8611
        failing since 124 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-05-23T01:15:37.197479  <8>[   50.541452] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 499079_1.6.2.4.1>
    2023-05-23T01:15:37.314927  / # #
    2023-05-23T01:15:37.418113  export SHELL=3D/bin/sh
    2023-05-23T01:15:37.418697  #
    2023-05-23T01:15:37.520635  / # export SHELL=3D/bin/sh. /lava-499079/en=
vironment
    2023-05-23T01:15:37.521385  =

    2023-05-23T01:15:37.623791  / # . /lava-499079/environment/lava-499079/=
bin/lava-test-runner /lava-499079/1
    2023-05-23T01:15:37.625094  =

    2023-05-23T01:15:37.629451  / # /lava-499079/bin/lava-test-runner /lava=
-499079/1
    2023-05-23T01:15:37.848294  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fc...g+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/646c11fd419f07b7912e85fd

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-broonie/baselin=
e-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-broonie/baselin=
e-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/646c11fd419f07b7912e8628
        failing since 124 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-05-23T01:06:58.936086  [   53.012988] <LAVA_SIGNAL_ENDRUN 0_dmesg =
498984_1.6.2.4.1>
    2023-05-23T01:06:59.050799  / # #
    2023-05-23T01:06:59.153683  export SHELL=3D/bin/sh
    2023-05-23T01:06:59.154393  #
    2023-05-23T01:06:59.256685  / # export SHELL=3D/bin/sh. /lava-498984/en=
vironment
    2023-05-23T01:06:59.257394  =

    2023-05-23T01:06:59.359905  / # . /lava-498984/environment/lava-498984/=
bin/lava-test-runner /lava-498984/1
    2023-05-23T01:06:59.361015  =

    2023-05-23T01:06:59.365781  / # /lava-498984/bin/lava-test-runner /lava=
-498984/1
    2023-05-23T01:06:59.574479  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/646c12bb6302d9c7832e8603

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-beagl=
ebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-beagl=
ebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/646c12bb6302d9c7832e862e
        failing since 124 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-05-23T01:10:34.467334  <8>[   46.624061] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 499049_1.6.2.4.1>
    2023-05-23T01:10:34.582214  / # #
    2023-05-23T01:10:34.685130  export SHELL=3D/bin/sh
    2023-05-23T01:10:34.685868  #
    2023-05-23T01:10:34.788301  / # export SHELL=3D/bin/sh. /lava-499049/en=
vironment
    2023-05-23T01:10:34.789013  =

    2023-05-23T01:10:34.891273  / # . /lava-499049/environment/lava-499049/=
bin/lava-test-runner /lava-499049/1
    2023-05-23T01:10:34.892481  =

    2023-05-23T01:10:34.896200  / # /lava-499049/bin/lava-test-runner /lava=
-499049/1
    2023-05-23T01:10:35.068692  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | omap2plus_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/646c137e8ad38d0db02e8602

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nfs-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nfs-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/646c137e8ad38d0db=
02e8603
        new failure (last pass: v4.19.277-cip94-rt29) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/646c109f9e79fae6cf2e8603

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/646c109f9e79fae6c=
f2e8604
        new failure (last pass: v4.19.277-cip94-rt29) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0edbaa4ad557fc2e85fa

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm/defconfig/gcc-10/lab-collabora/baseline-nfs-imx6q-sabrel=
ite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm/defconfig/gcc-10/lab-collabora/baseline-nfs-imx6q-sabrel=
ite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/646c0edbaa4ad557fc2e85ff
        failing since 124 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-05-23T00:54:26.036789  / # #

    2023-05-23T00:54:26.139411  export SHELL=3D/bin/sh

    2023-05-23T00:54:26.140144  #

    2023-05-23T00:54:26.241573  / # export SHELL=3D/bin/sh. /lava-10419643/=
environment

    2023-05-23T00:54:26.242313  =


    2023-05-23T00:54:26.344113  / # . /lava-10419643/environment/lava-10419=
643/bin/lava-test-runner /lava-10419643/1

    2023-05-23T00:54:26.345267  =


    2023-05-23T00:54:26.348323  / # /lava-10419643/bin/lava-test-runner /la=
va-10419643/1

    2023-05-23T00:54:26.538473  + export TESTRUN_ID=3D1_bootrr

    2023-05-23T00:54:26.538640  + cd /lava-10419643/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | defconfig+p=
reempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/646c1320ac52ae6d1e2e8603

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-nfs-i=
mx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-nfs-i=
mx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/646c1320ac52ae6d1e2e8608
        failing since 124 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-05-23T01:12:58.822731  / # #

    2023-05-23T01:12:58.925488  export SHELL=3D/bin/sh

    2023-05-23T01:12:58.926237  #

    2023-05-23T01:12:59.028038  / # export SHELL=3D/bin/sh. /lava-10419837/=
environment

    2023-05-23T01:12:59.028788  =


    2023-05-23T01:12:59.130664  / # . /lava-10419837/environment/lava-10419=
837/bin/lava-test-runner /lava-10419837/1

    2023-05-23T01:12:59.131828  =


    2023-05-23T01:12:59.135138  / # /lava-10419837/bin/lava-test-runner /la=
va-10419837/1

    2023-05-23T01:12:59.294907  + export TESTRUN_ID=3D1_bootrr

    2023-05-23T01:12:59.310853  + cd /lava-10419837/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fc...g+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/646c11675142db92542e85e8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-collabora/basel=
ine-nfs-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-collabora/basel=
ine-nfs-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/646c11675142db92542e85ed
        failing since 124 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-05-23T01:05:24.319110  / # #

    2023-05-23T01:05:24.421745  export SHELL=3D/bin/sh

    2023-05-23T01:05:24.422498  #

    2023-05-23T01:05:24.524409  / # export SHELL=3D/bin/sh. /lava-10419789/=
environment

    2023-05-23T01:05:24.525163  =


    2023-05-23T01:05:24.626786  / # . /lava-10419789/environment/lava-10419=
789/bin/lava-test-runner /lava-10419789/1

    2023-05-23T01:05:24.628030  =


    2023-05-23T01:05:24.631390  / # /lava-10419789/bin/lava-test-runner /la=
va-10419789/1

    2023-05-23T01:05:24.790705  + export TESTRUN_ID=3D1_bootrr

    2023-05-23T01:05:24.806969  + cd /lava-10419789/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/646c11b7d7f8a1620f2e85ea

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-nfs-imx=
6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-nfs-imx=
6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/646c11b7d7f8a1620f2e85ef
        failing since 124 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-05-23T01:06:57.102593  / # #

    2023-05-23T01:06:57.205186  export SHELL=3D/bin/sh

    2023-05-23T01:06:57.205956  #

    2023-05-23T01:06:57.307751  / # export SHELL=3D/bin/sh. /lava-10419808/=
environment

    2023-05-23T01:06:57.308478  =


    2023-05-23T01:06:57.410185  / # . /lava-10419808/environment/lava-10419=
808/bin/lava-test-runner /lava-10419808/1

    2023-05-23T01:06:57.411323  =


    2023-05-23T01:06:57.425655  / # /lava-10419808/bin/lava-test-runner /la=
va-10419808/1

    2023-05-23T01:06:57.552449  + export TESTRUN_ID=3D1_bootrr

    2023-05-23T01:06:57.552907  + cd /lava-10419808/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
sun50i-a64-pine64-plus    | arm64  | lab-broonie   | gcc-10   | defconfig+p=
reempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/646c1102fba08abfc82e85f9

  Results:     23 PASS, 16 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm64/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-nfs-s=
un50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm64/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-nfs-s=
un50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/646c1102fba08abfc82e861f
        failing since 124 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-05-23T01:03:28.127924  <8>[   27.229531] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 498889_1.6.2.4.1>
    2023-05-23T01:03:28.238221  / # #
    2023-05-23T01:03:28.339724  export SHELL=3D/bin/sh
    2023-05-23T01:03:28.340570  #
    2023-05-23T01:03:28.442674  / # export SHELL=3D/bin/sh. /lava-498889/en=
vironment
    2023-05-23T01:03:28.443344  =

    2023-05-23T01:03:28.545281  / # . /lava-498889/environment/lava-498889/=
bin/lava-test-runner /lava-498889/1
    2023-05-23T01:03:28.545949  =

    2023-05-23T01:03:28.550383  / # /lava-498889/bin/lava-test-runner /lava=
-498889/1
    2023-05-23T01:03:28.646627  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
sun50i-a64-pine64-plus    | arm64  | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/646c13b931407a87142e8610

  Results:     23 PASS, 12 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-sun50i-a64-p=
ine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-sun50i-a64-p=
ine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/646c13ba31407a87142e8632
        failing since 124 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-05-23T01:14:13.793012  <8>[   27.944839] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 499013_1.6.2.4.1>
    2023-05-23T01:14:13.919836  / # #
    2023-05-23T01:14:14.022208  export SHELL=3D/bin/sh
    2023-05-23T01:14:14.022784  #
    2023-05-23T01:14:14.124309  / # export SHELL=3D/bin/sh. /lava-499013/en=
vironment
    2023-05-23T01:14:14.124902  =

    2023-05-23T01:14:14.226550  / # . /lava-499013/environment/lava-499013/=
bin/lava-test-runner /lava-499013/1
    2023-05-23T01:14:14.227050  =

    2023-05-23T01:14:14.231343  / # /lava-499013/bin/lava-test-runner /lava=
-499013/1
    2023-05-23T01:14:14.340325  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =20

