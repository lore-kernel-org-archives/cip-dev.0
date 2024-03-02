Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7802C54E41
	for <webhook@archiver.kernel.org>; Sat,  2 Mar 2024 03:19:43 +0000 (UTC)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
 by mx.groups.io with SMTP id smtpd.web10.42480.1709349578796440345
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 01 Mar 2024 19:19:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=l+kenP04;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.167.173, mailfrom: bot@kernelci.org)
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3c19aaedfdaso1478122b6e.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 01 Mar 2024 19:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709349577; x=1709954377; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8e/qjk1r2kAl658mgNVnnWHrqYfF0X2nexGhkvunesU=;
        b=l+kenP04v7JdzLfAj2RrAExo5YzvbaG8cpKTeOypxuvb4h3UEZ3ZXt0X32wd7OJ71j
         KqBZIY4groobp4fqhTT+sEk2lLF/5UEKKpb1QWPQXlCGliknpnr8fSV3d8IT1HeHp28b
         Dc7Di7oW6OS3Ydp+RUN/sARJ6yb/3Xx9qx+sitUmr3eCOgGWDFAG16klm8OrhGP7V+Wn
         19CML0gY6hyEX32FnG29nvP0fFUqyxWk+s2TGCnJ3fU0F8lCnHIVVXZJVVkPsUPQIZ2x
         LDMJr5SmjkXenXu2GHEKnAYRO0nvkKF0wKOwWib/Oaf6ezSsIOXXFX1Co2ZvGJDFYFiV
         rkrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709349577; x=1709954377;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8e/qjk1r2kAl658mgNVnnWHrqYfF0X2nexGhkvunesU=;
        b=jBd2nVxQ8+JJ6zURkB29HYzpqXKa24910qn7ZeR6JERzmi88rZUY3YEjzNtSHNsbym
         1MPJ8FW6kogPU9cgdm3G8FaMikPq5dlxuG2IXXydbGOz1hyXT5X2jTZBYxLs6gk+SSmc
         4ZsOIeaonh6PkYJil6H41Dotmx+d5dPdYsuFGxNGZ29oLrNNbF4KJUWMUcH8eQLMlsPj
         IuUb/HTXSMkCZio3zmL9wvsWaatmYKUdv4Y+C5XI4DbosQzKKzVDWmVGwoV/eqdWk/2I
         MWEv9NA7dLl55u1EApbz0Ss8qMYPR2NKjW8cU5yy3jtNZ/xQssE2/whprlmz/YWy5hY+
         HXwQ==
X-Gm-Message-State: AOJu0Yy0+bfnXV0+ULo43Z9jEEl5qNNU+d+1r/XiAhvJ7uwSmcNktpIL
	Yn9d1eye3LTBADWR/hv8an2+8lhW0a9G+deSQQPURMLvgMUnTS72GnYTFAtgp+7c8BdxWnCkt5U
	0LrM=
X-Google-Smtp-Source: AGHT+IGsVix76aXOuVZSEVZ3Od4BGU3dXMlpX5jAhcBBY2zd+yCeWCXAn5kurKwQbZ8s8oUvFH/N1Q==
X-Received: by 2002:a05:6808:2085:b0:3c1:d369:7e7 with SMTP id s5-20020a056808208500b003c1d36907e7mr3826473oiw.28.1709349577282;
        Fri, 01 Mar 2024 19:19:37 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id cz13-20020a17090ad44d00b0029ad44cc063sm6016653pjb.35.2024.03.01.19.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 19:19:36 -0800 (PST)
Message-ID: <65e29ac8.170a0220.fcb5e.e3bc@mx.google.com>
Date: Fri, 01 Mar 2024 19:19:36 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip-rt
X-Kernelci-Kernel: v4.19.306-cip107-rt35
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip-rt baseline-nfs: 76 runs,
 12 regressions (v4.19.306-cip107-rt35)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 02 Mar 2024 03:19:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15160

cip/linux-4.19.y-cip-rt baseline-nfs: 76 runs, 12 regressions (v4.19.306-ci=
p107-rt35)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | defconfig+x8=
6-board          | 1          =

beaglebone-black         | arm    | lab-broonie   | gcc-10   | defconfig+pr=
eempt_rt         | 1          =

beaglebone-black         | arm    | lab-broonie   | gcc-10   | multi_v7_def=
c...g+preempt_rt | 1          =

beaglebone-black         | arm    | lab-broonie   | gcc-10   | multi_v7_def=
config           | 1          =

beaglebone-black         | arm    | lab-broonie   | gcc-10   | omap2plus_de=
fconfig          | 1          =

hp-x360-14-G1-sona       | x86_64 | lab-collabora | gcc-10   | defconfig+x8=
6-board          | 1          =

hp-x360-14-G1-sona       | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...d+preempt_rt | 1          =

imx6q-sabrelite          | arm    | lab-collabora | gcc-10   | defconfig+pr=
eempt_rt         | 1          =

imx6q-sabrelite          | arm    | lab-collabora | gcc-10   | defconfig   =
                 | 1          =

imx6q-sabrelite          | arm    | lab-collabora | gcc-10   | multi_v7_def=
c...g+preempt_rt | 1          =

imx6q-sabrelite          | arm    | lab-collabora | gcc-10   | multi_v7_def=
config           | 1          =

sun50i-a64-pine64-plus   | arm64  | lab-broonie   | gcc-10   | defconfig   =
                 | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip-rt/ke=
rnel/v4.19.306-cip107-rt35/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.19.y-cip-rt
  Describe: v4.19.306-cip107-rt35
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      dcbd51e7744fcf9baa3ea87a028b574fda95d428 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | defconfig+x8=
6-board          | 1          =


  Details:     https://kernelci.org/test/plan/id/65e28db09d07a7b721637022

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/x86_64/defconfig+x86-board/gcc-10/lab-collabora/baseline-nf=
s-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/x86_64/defconfig+x86-board/gcc-10/lab-collabora/baseline-nf=
s-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65e28db09d07a7b72=
1637023
        new failure (last pass: v4.19.299-cip105-rt34) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
beaglebone-black         | arm    | lab-broonie   | gcc-10   | defconfig+pr=
eempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/65e28d771d8224d41663701d

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-nfs-be=
aglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-nfs-be=
aglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65e28d771d8224d416637048
        failing since 408 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2024-03-02T02:21:50.533832  <8>[   53.568611] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 652459_1.6.2.4.1>
    2024-03-02T02:21:50.652775  / # #
    2024-03-02T02:21:50.754256  export SHELL=3D/bin/sh
    2024-03-02T02:21:50.754562  #
    2024-03-02T02:21:50.855715  / # export SHELL=3D/bin/sh. /lava-652459/en=
vironment
    2024-03-02T02:21:50.855999  =

    2024-03-02T02:21:50.957181  / # . /lava-652459/environment/lava-652459/=
bin/lava-test-runner /lava-652459/1
    2024-03-02T02:21:50.957700  =

    2024-03-02T02:21:50.961155  / # /lava-652459/bin/lava-test-runner /lava=
-652459/1
    2024-03-02T02:21:51.175770  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
beaglebone-black         | arm    | lab-broonie   | gcc-10   | multi_v7_def=
c...g+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/65e28af16a3441a5da637022

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-broonie/baseli=
ne-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-broonie/baseli=
ne-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65e28af16a3441a5da63704d
        failing since 408 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2024-03-02T02:11:12.557907  <8>[   58.589172] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 652434_1.6.2.4.1>
    2024-03-02T02:11:12.735419  / # #
    2024-03-02T02:11:12.837011  export SHELL=3D/bin/sh
    2024-03-02T02:11:12.837380  #
    2024-03-02T02:11:12.938635  / # export SHELL=3D/bin/sh. /lava-652434/en=
vironment
    2024-03-02T02:11:12.939061  =

    2024-03-02T02:11:13.040427  / # . /lava-652434/environment/lava-652434/=
bin/lava-test-runner /lava-652434/1
    2024-03-02T02:11:13.041213  =

    2024-03-02T02:11:13.045798  / # /lava-652434/bin/lava-test-runner /lava=
-652434/1
    2024-03-02T02:11:13.363820  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
beaglebone-black         | arm    | lab-broonie   | gcc-10   | multi_v7_def=
config           | 1          =


  Details:     https://kernelci.org/test/plan/id/65e2900bef45d40bd4637029

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65e2900bef45d40bd4637056
        failing since 408 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2024-03-02T02:32:52.219913  <8>[   48.082946] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 652508_1.6.2.4.1>
    2024-03-02T02:32:52.338988  / # #
    2024-03-02T02:32:52.442317  export SHELL=3D/bin/sh
    2024-03-02T02:32:52.443244  #
    2024-03-02T02:32:52.545320  / # export SHELL=3D/bin/sh. /lava-652508/en=
vironment
    2024-03-02T02:32:52.545944  =

    2024-03-02T02:32:52.647670  / # . /lava-652508/environment/lava-652508/=
bin/lava-test-runner /lava-652508/1
    2024-03-02T02:32:52.649192  =

    2024-03-02T02:32:52.652032  / # /lava-652508/bin/lava-test-runner /lava=
-652508/1
    2024-03-02T02:32:52.848202  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
beaglebone-black         | arm    | lab-broonie   | gcc-10   | omap2plus_de=
fconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/65e28f8d28604f5d4d637020

  Results:     41 PASS, 10 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nfs-bea=
glebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nfs-bea=
glebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65e28f8d28604f5d4d637056
        new failure (last pass: v4.19.299-cip105-rt34)

    2024-03-02T02:31:04.110262  + set +x
    2024-03-02T02:31:04.114409  <8>[   51.889564] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 652476_1.6.2.4.1>
    2024-03-02T02:31:04.252108  #
    2024-03-02T02:31:04.354117  / # #export SHELL=3D/bin/sh
    2024-03-02T02:31:04.354356  =

    2024-03-02T02:31:04.456110  / # export SHELL=3D/bin/sh. /lava-652476/en=
vironment
    2024-03-02T02:31:04.456361  =

    2024-03-02T02:31:04.557453  / # . /lava-652476/environment/lava-652476/=
bin/lava-test-runner /lava-652476/1
    2024-03-02T02:31:04.557894  =

    2024-03-02T02:31:04.562300  / # /lava-652476/bin/lava-test-runner /lava=
-652476/1 =

    ... (12 line(s) more)  =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
hp-x360-14-G1-sona       | x86_64 | lab-collabora | gcc-10   | defconfig+x8=
6-board          | 1          =


  Details:     https://kernelci.org/test/plan/id/65e28dbcf0b7956b22637033

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/x86_64/defconfig+x86-board/gcc-10/lab-collabora/baseline-nf=
s-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/x86_64/defconfig+x86-board/gcc-10/lab-collabora/baseline-nf=
s-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65e28dbcf0b7956b2=
2637034
        new failure (last pass: v4.19.299-cip105-rt34) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
hp-x360-14-G1-sona       | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...d+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/65e2888c284268e13d63706f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/x86_64/x86_64_defconfig+x86-board+preempt_rt/gcc-10/lab-col=
labora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/x86_64/x86_64_defconfig+x86-board+preempt_rt/gcc-10/lab-col=
labora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65e2888c284268e13=
d637070
        new failure (last pass: v4.19.299-cip105-rt34) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
imx6q-sabrelite          | arm    | lab-collabora | gcc-10   | defconfig+pr=
eempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/65e28f6a66325985676370ca

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-nfs-=
imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-nfs-=
imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65e28f6a66325985676370cf
        failing since 408 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2024-03-02T02:32:20.469429  / # #

    2024-03-02T02:32:20.571198  export SHELL=3D/bin/sh

    2024-03-02T02:32:20.571487  #

    2024-03-02T02:32:20.672411  / # export SHELL=3D/bin/sh. /lava-12912133/=
environment

    2024-03-02T02:32:20.673056  =


    2024-03-02T02:32:20.774510  / # . /lava-12912133/environment/lava-12912=
133/bin/lava-test-runner /lava-12912133/1

    2024-03-02T02:32:20.775490  =


    2024-03-02T02:32:20.781915  / # /lava-12912133/bin/lava-test-runner /la=
va-12912133/1

    2024-03-02T02:32:20.964120  + export TESTRUN_ID=3D1_bootrr

    2024-03-02T02:32:20.964283  + cd /lava-12912133/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
imx6q-sabrelite          | arm    | lab-collabora | gcc-10   | defconfig   =
                 | 1          =


  Details:     https://kernelci.org/test/plan/id/65e28fe690b6ea910f63709c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm/defconfig/gcc-10/lab-collabora/baseline-nfs-imx6q-sabre=
lite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm/defconfig/gcc-10/lab-collabora/baseline-nfs-imx6q-sabre=
lite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65e28fe690b6ea910f6370a1
        failing since 408 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2024-03-02T02:39:23.555330  / # #

    2024-03-02T02:39:23.657676  export SHELL=3D/bin/sh

    2024-03-02T02:39:23.658427  #

    2024-03-02T02:39:23.759704  / # export SHELL=3D/bin/sh. /lava-12912192/=
environment

    2024-03-02T02:39:23.760395  =


    2024-03-02T02:39:23.861667  / # . /lava-12912192/environment/lava-12912=
192/bin/lava-test-runner /lava-12912192/1

    2024-03-02T02:39:23.862857  =


    2024-03-02T02:39:23.864447  / # /lava-12912192/bin/lava-test-runner /la=
va-12912192/1

    2024-03-02T02:39:24.013909  + export TESTRUN_ID=3D1_bootrr

    2024-03-02T02:39:24.014041  + cd /lava-12912192/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
imx6q-sabrelite          | arm    | lab-collabora | gcc-10   | multi_v7_def=
c...g+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/65e28f1bbf296a5ed5637015

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-collabora/base=
line-nfs-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-collabora/base=
line-nfs-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65e28f1bbf296a5ed563701a
        failing since 408 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2024-03-02T02:30:58.977127  / # #

    2024-03-02T02:30:59.078883  export SHELL=3D/bin/sh

    2024-03-02T02:30:59.079484  #

    2024-03-02T02:30:59.180608  / # export SHELL=3D/bin/sh. /lava-12912059/=
environment

    2024-03-02T02:30:59.180770  =


    2024-03-02T02:30:59.281250  / # . /lava-12912059/environment/lava-12912=
059/bin/lava-test-runner /lava-12912059/1

    2024-03-02T02:30:59.281519  =


    2024-03-02T02:30:59.286741  / # /lava-12912059/bin/lava-test-runner /la=
va-12912059/1

    2024-03-02T02:30:59.473427  + export TESTRUN_ID=3D1_bootrr

    2024-03-02T02:30:59.473499  + cd /lava-12912059/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
imx6q-sabrelite          | arm    | lab-collabora | gcc-10   | multi_v7_def=
config           | 1          =


  Details:     https://kernelci.org/test/plan/id/65e28f9204886a3e4263703b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-nfs-im=
x6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-nfs-im=
x6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65e28f9204886a3e42637040
        failing since 408 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2024-03-02T02:32:57.279834  / # #

    2024-03-02T02:32:57.380350  export SHELL=3D/bin/sh

    2024-03-02T02:32:57.380979  #

    2024-03-02T02:32:57.482289  / # export SHELL=3D/bin/sh. /lava-12912187/=
environment

    2024-03-02T02:32:57.482955  =


    2024-03-02T02:32:57.584247  / # . /lava-12912187/environment/lava-12912=
187/bin/lava-test-runner /lava-12912187/1

    2024-03-02T02:32:57.585304  =


    2024-03-02T02:32:57.594357  / # /lava-12912187/bin/lava-test-runner /la=
va-12912187/1

    2024-03-02T02:32:57.731830  + export TESTRUN_ID=3D1_bootrr

    2024-03-02T02:32:57.731961  + cd /lava-12912187/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
sun50i-a64-pine64-plus   | arm64  | lab-broonie   | gcc-10   | defconfig   =
                 | 1          =


  Details:     https://kernelci.org/test/plan/id/65e28f7f7726eecc02637023

  Results:     23 PASS, 16 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-sun50i-a64-=
pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-sun50i-a64-=
pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65e28f7f7726eecc02637046
        failing since 408 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2024-03-02T02:30:44.558443  <8>[   24.982668] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 652491_1.6.2.4.1>
    2024-03-02T02:30:44.688420  / # #
    2024-03-02T02:30:44.789823  export SHELL=3D/bin/sh
    2024-03-02T02:30:44.790229  #
    2024-03-02T02:30:44.891362  / # export SHELL=3D/bin/sh. /lava-652491/en=
vironment
    2024-03-02T02:30:44.891777  =

    2024-03-02T02:30:44.992913  / # . /lava-652491/environment/lava-652491/=
bin/lava-test-runner /lava-652491/1
    2024-03-02T02:30:44.993529  =

    2024-03-02T02:30:44.997717  / # /lava-652491/bin/lava-test-runner /lava=
-652491/1
    2024-03-02T02:30:45.077204  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =20

