Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61A8C636CD
	for <webhook@archiver.kernel.org>; Tue,  7 Feb 2023 07:45:59 +0000 (UTC)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
 by mx.groups.io with SMTP id smtpd.web11.78551.1675755954447048290
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 06 Feb 2023 23:45:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=i0HdYZtM;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.41, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f41.google.com with SMTP id o16-20020a17090ad25000b00230759a8c06so11023416pjw.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 06 Feb 2023 23:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=u7x03KGmkEPiIYiRqcPHWp7it6MG/Lzb6HwgUfokEXM=;
        b=i0HdYZtM3OVMZiSBzmVVWoBhPl9+CkDNwSyTgsR+9zQlcxm8V66wgraZGA53FZICYJ
         fvyC43NEBlf0JT1I65VjBIZMDuWLHWyBEZeE4MXzbYYvVbv3sQIlD4P5aVnB06hVNzcI
         iLXdKtacO5y1VV6T9TR/hIylTKrFKbtHwFsuGM/odNAfVeREKEnltE0xI+B5CS8eVnFo
         qUhr8KaLp0En7gnx1QXrMYtyXGkULRvgmTP66rQdYxphP9cmsaZhlAmzwGaIa+tJCu2Y
         uZnttQLB9NpBF/5zxcB28IfRVik+3l3WhCd/ciuuu0G52ghLYl7nWbixG4cOZAVkOCRR
         LRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u7x03KGmkEPiIYiRqcPHWp7it6MG/Lzb6HwgUfokEXM=;
        b=Vz0FciQV2wVmxPo+P1qfReeK31LzKjK+YXlTfLKwYHYs4fTIIst97mYVJ3aQWbgX/r
         uSWFlGWglhasQ5sZaGEYSEYoLWZ6l7XtNgNYaoJUzEWIDuysO7gH0k7v2Nzq4BpHt24S
         BWLt8V9SRZyHHDODmrMKQQO8Qyge1XqkZb+huDC1zXWbX4y39KDXWWLnkPoIn5P+6Stx
         fXHpvreEJDHUffdAnbF0q195WaL2YK4btCAn7CwKdfpk4mpsn7w5xy+C4fHdkQQ+m8zC
         yzi59DrZfju95U19Xly5t0w/mowjQfOmuGQfR7KEn6axEjaEKg+vpzRqLGihhNLTCXwE
         SdoQ==
X-Gm-Message-State: AO0yUKWARXlPpsgxXPwNiDrKUKLxt51ssVx9TiSh2WsO/E4zLZlmPsJq
	J4exlDoLDkn50o5Jcdj6dWFGKvVMbdCp96bIh5d+pw==
X-Google-Smtp-Source: AK7set/c6Dvsn7Ie09nfuqaOanHYWWVY1JLnWDMr98qPPIO4sDn9zz6cxLG8vCKljnCFypoX8TFzFg==
X-Received: by 2002:a17:902:d40d:b0:198:f979:14b3 with SMTP id b13-20020a170902d40d00b00198f97914b3mr1526868ple.60.1675755952952;
        Mon, 06 Feb 2023 23:45:52 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id n12-20020a170902968c00b001949b92f8a8sm8104744plp.279.2023.02.06.23.45.52
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 23:45:52 -0800 (PST)
Message-ID: <63e201b0.170a0220.955c6.dc2c@mx.google.com>
Date: Mon, 06 Feb 2023 23:45:52 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.4.302-cip72-rt42
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline: 51 runs,
 37 regressions (v4.4.302-cip72-rt42)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 Feb 2023 07:45:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10615

cip-gitlab/ci/pavel/linux-test baseline: 51 runs, 37 regressions (v4.4.302-=
cip72-rt42)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

bcm2835-rpi-b-rev2           | arm    | lab-broonie   | gcc-10   | bcm2835_=
defconfig            | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

dell-latitude...4305U-sarien | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

dell-latitude...8665U-sarien | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

odroid-xu3                   | arm    | lab-collabora | gcc-10   | exynos_d=
efconfig             | 1          =

qemu_arm-virt-gicv2          | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

qemu_arm-virt-gicv2          | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =

qemu_arm-virt-gicv2-uefi     | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =

qemu_arm-virt-gicv3          | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

qemu_arm-virt-gicv3-uefi     | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =

qemu_x86_64-uefi-mixed       | x86_64 | lab-broonie   | gcc-10   | x86_64_d=
efconfig             | 1          =

rk3288-veyron-jaq            | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 21         =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip72-rt42/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip72-rt42
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      fe1cf8ef6e9d76107c4a6e1bf8cc27263abe6698 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63e1f947a6c180e1998c865f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230203.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63e1f947a6c180e1998c8=
660
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63e1f94e21ba1e418b8c864a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230203.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63e1f94e21ba1e418b8c8=
64b
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63e1f949a6c180e1998c8666

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230203.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63e1f949a6c180e1998c8=
667
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
bcm2835-rpi-b-rev2           | arm    | lab-broonie   | gcc-10   | bcm2835_=
defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/63e1f97bf47500da748c865a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/arm/bcm2835_defconfig/gcc-10/lab-broonie/baseline-bcm2=
835-rpi-b-rev2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/arm/bcm2835_defconfig/gcc-10/lab-broonie/baseline-bcm2=
835-rpi-b-rev2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230203.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63e1f97bf47500da748c8=
65b
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63e1f88aca2f4c61318c8635

  Results:     4 PASS, 1 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-bea=
glebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-bea=
glebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230203.0/armel/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/63e1f88aca2f4c61=
318c863a
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752)
        1 lines

    2023-02-07T07:06:45.355581  / # =

    2023-02-07T07:06:45.361553  =

    2023-02-07T07:06:45.468613  / # #
    2023-02-07T07:06:45.474527  #
    2023-02-07T07:06:45.577367  / # export SHELL=3D/bin/sh
    2023-02-07T07:06:45.583352  export SHELL=3D/bin/sh
    2023-02-07T07:06:45.685642  / # . /lava-266459/environment
    2023-02-07T07:06:45.691626  . /lava-266459/environment
    2023-02-07T07:06:45.794001  / # /lava-266459/bin/lava-test-runner /lava=
-266459/0
    2023-02-07T07:06:45.799352  /lava-266459/bin/lava-test-runner /lava-266=
459/0 =

    ... (9 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63e1f6c0aa298f11a88c8691

  Results:     4 PASS, 1 FAIL, 2 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-be=
aglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-be=
aglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230203.0/armel/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/63e1f6c0aa298f11=
a88c8696
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752)
        1 lines

    2023-02-07T06:58:50.642387  / # =

    2023-02-07T06:58:50.650522  =

    2023-02-07T06:58:50.756412  / # #
    2023-02-07T06:58:50.763543  #
    2023-02-07T06:58:50.866335  / # export SHELL=3D/bin/sh
    2023-02-07T06:58:50.873326  export SHELL=3D/bin/sh
    2023-02-07T06:58:50.975680  / # . /lava-266158/environment
    2023-02-07T06:58:50.982780  . /lava-266158/environment
    2023-02-07T06:58:51.084881  / # /lava-266158/bin/lava-test-runner /lava=
-266158/0
    2023-02-07T06:58:51.091047  /lava-266158/bin/lava-test-runner /lava-266=
158/0 =

    ... (9 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
dell-latitude...4305U-sarien | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63e1f944a6c180e1998c8657

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-dell-latitude-5400-4305U-sarien.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-dell-latitude-5400-4305U-sarien.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230203.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63e1f944a6c180e1998c8=
658
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
dell-latitude...8665U-sarien | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63e1f942f9a4f237138c8657

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-dell-latitude-5400-8665U-sarien.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-dell-latitude-5400-8665U-sarien.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230203.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63e1f942f9a4f237138c8=
658
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63e1f957f96106a06e8c8641

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230203.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63e1f957f96106a06e8c8=
642
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
odroid-xu3                   | arm    | lab-collabora | gcc-10   | exynos_d=
efconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/63e1f94821ba1e418b8c8632

  Results:     4 PASS, 1 FAIL, 2 SKIP
  Full config: exynos_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/arm/exynos_defconfig/gcc-10/lab-collabora/baseline-odr=
oid-xu3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/arm/exynos_defconfig/gcc-10/lab-collabora/baseline-odr=
oid-xu3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230203.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.all-cpus-are-online: https://kernelci.org/test/case/id/=
63e1f94821ba1e418b8c863a
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752)

    2023-02-07T07:09:40.185142  /lava-9045266/1/../bin/lava-test-case

    2023-02-07T07:09:40.201487  [   14.052070] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dall-cpus-are-online RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-virt-gicv2          | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63e200f190182179418c8663

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-qem=
u_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-qem=
u_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230203.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63e200f190182179418c8=
664
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-virt-gicv2          | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63e1f9f1a909f046fa8c867e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-q=
emu_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-q=
emu_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230203.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63e1f9f1a909f046fa8c8=
67f
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-virt-gicv2-uefi     | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63e1fab9b5fd2f1d858c8655

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-q=
emu_arm-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-q=
emu_arm-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230203.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63e1fab9b5fd2f1d858c8=
656
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-virt-gicv3          | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63e200dd90182179418c862f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-qem=
u_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-qem=
u_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230203.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63e200dd90182179418c8=
630
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-virt-gicv3-uefi     | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63e1fafbc3cfe40e908c8673

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-q=
emu_arm-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-q=
emu_arm-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230203.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63e1fafbc3cfe40e908c8=
674
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-broonie   | gcc-10   | x86_64_d=
efconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/63e1fd6c0ab8207d528c86fa

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/x86_64/x86_64_defconfig/gcc-10/lab-broonie/baseline-qe=
mu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/x86_64/x86_64_defconfig/gcc-10/lab-broonie/baseline-qe=
mu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230203.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63e1fd6c0ab8207d528c8=
6fb
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 21         =


  Details:     https://kernelci.org/test/plan/id/63e1f8d4f7cb4503db8c86d2

  Results:     37 PASS, 22 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-r=
k3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-r=
k3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230203.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-vopl-probed: https://kernelci.org/test/case/id=
/63e1f8d4f7cb4503db8c86db
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752)

    2023-02-07T07:07:42.510825  /lava-9045540/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-vopb-probed: https://kernelci.org/test/case/id=
/63e1f8d4f7cb4503db8c86dc
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752)

    2023-02-07T07:07:41.451413  /lava-9045540/1/../bin/lava-test-case

    2023-02-07T07:07:41.477572  [   47.869936] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-vopb-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb-phy-grf-probed: https://kernelci.org/test/=
case/id/63e1f8d4f7cb4503db8c86de
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752)

    2023-02-07T07:07:40.320984  /lava-9045540/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-pwm0-probed: https://kernelci.org/test/case/id=
/63e1f8d4f7cb4503db8c86e6
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752)

    2023-02-07T07:07:38.026879  [   44.417265] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-pwm-driver-present RESULT=3Dpass>

    2023-02-07T07:07:39.041931  /lava-9045540/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-pm-domain-driver-present: https://kernelci.org=
/test/case/id/63e1f8d4f7cb4503db8c86e8
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752)

    2023-02-07T07:07:34.734976  [   41.125396] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-iodomain-driver-present RESULT=3Dfail>

    2023-02-07T07:07:35.768660  /lava-9045540/1/../bin/lava-test-case

    2023-02-07T07:07:35.808077  [   42.199481] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-iodomain-grf-probed RESULT=3Dblocked>

    2023-02-07T07:07:36.837622  /lava-9045540/1/../bin/lava-test-case

    2023-02-07T07:07:36.878002  [   43.269331] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-pm-domain-driver-present RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-iodomain-driver-present: https://kernelci.org/=
test/case/id/63e1f8d4f7cb4503db8c86e9
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752)

    2023-02-07T07:07:33.611824  /lava-9045540/1/../bin/lava-test-case

    2023-02-07T07:07:33.651721  [   40.043760] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-i2s-probed RESULT=3Dblocked>

    2023-02-07T07:07:34.707755  /lava-9045540/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockcip-i2s-driver-present: https://kernelci.org/test/c=
ase/id/63e1f8d4f7cb4503db8c86ea
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752)

    2023-02-07T07:07:31.454589  /lava-9045540/1/../bin/lava-test-case

    2023-02-07T07:07:31.482949  [   37.873618] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-dp-phy-grf-probed RESULT=3Dblocked>

    2023-02-07T07:07:32.516351  /lava-9045540/1/../bin/lava-test-case

    2023-02-07T07:07:32.555918  [   38.947552] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockcip-i2s-driver-present RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-dp-phy-driver-present: https://kernelci.org/te=
st/case/id/63e1f8d4f7cb4503db8c86eb
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752)

    2023-02-07T07:07:29.322361  /lava-9045540/1/../bin/lava-test-case

    2023-02-07T07:07:29.360667  [   35.752603] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-dp-edp-probed RESULT=3Dblocked>

    2023-02-07T07:07:30.395798  /lava-9045540/1/../bin/lava-test-case

    2023-02-07T07:07:30.435966  [   36.827213] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-dp-phy-driver-present RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-dp-driver-present: https://kernelci.org/test/c=
ase/id/63e1f8d4f7cb4503db8c86ec
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752)

    2023-02-07T07:07:28.226182  /lava-9045540/1/../bin/lava-test-case

    2023-02-07T07:07:28.267123  [   34.658381] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-dp-driver-present RESULT=3Dfail>
   =


  * baseline.bootrr.rk_iommu-vpu_mmu-probed: https://kernelci.org/test/case=
/id/63e1f8d4f7cb4503db8c86ed
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752)

    2023-02-07T07:07:26.075043  [   32.466010] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk_iommu-vopl_mmu-probed RESULT=3Dfail>

    2023-02-07T07:07:27.148576  /lava-9045540/1/../bin/lava-test-case

    2023-02-07T07:07:27.187967  [   33.579873] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk_iommu-vpu_mmu-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rk_iommu-vopl_mmu-probed: https://kernelci.org/test/cas=
e/id/63e1f8d4f7cb4503db8c86ee
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752)

    2023-02-07T07:07:26.034766  /lava-9045540/1/../bin/lava-test-case
   =


  * baseline.bootrr.rk_iommu-vopb_mmu-probed: https://kernelci.org/test/cas=
e/id/63e1f8d4f7cb4503db8c86ef
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752)

    2023-02-07T07:07:23.953596  [   30.344831] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk_iommu-driver-present RESULT=3Dpass>

    2023-02-07T07:07:24.967298  /lava-9045540/1/../bin/lava-test-case

    2023-02-07T07:07:25.007275  [   31.399013] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk_iommu-vopb_mmu-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rk3288-crypto-driver-present: https://kernelci.org/test=
/case/id/63e1f8d4f7cb4503db8c86f7
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752)

    2023-02-07T07:07:21.540518  /lava-9045540/1/../bin/lava-test-case

    2023-02-07T07:07:21.579613  [   27.971678] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dramoops-probed RESULT=3Dblocked>

    2023-02-07T07:07:22.634923  /lava-9045540/1/../bin/lava-test-case

    2023-02-07T07:07:22.675108  [   29.066466] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk3288-crypto-driver-present RESULT=3Dfail>
   =


  * baseline.bootrr.ramoops-driver-present: https://kernelci.org/test/case/=
id/63e1f8d4f7cb4503db8c86f8
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752)

    2023-02-07T07:07:19.449516  [   25.839290] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dehci-platform-usb_host0_ehci-probed RESULT=3Dpass>

    2023-02-07T07:07:20.463489  /lava-9045540/1/../bin/lava-test-case

    2023-02-07T07:07:20.501834  [   26.893491] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dramoops-driver-present RESULT=3Dfail>
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/63e1f8d4f7cb4503db8c86ff
        failing since 17 days (last pass: v5.10.158-cip22-435-g2c52868ae1cb=
c, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-02-07T07:07:18.202032  ST

    2023-02-07T07:07:18.202222  =


    2023-02-07T07:07:18.205964  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-02-07T07:07:18.208370  FIRST, INC default to 1.

    2023-02-07T07:07:18.208572  =


    2023-02-07T07:07:18.211623  	-w	Pad to last with leading zeros

    2023-02-07T07:07:18.213833  	-s SEP	String separator

    2023-02-07T07:07:18.217025  /lava-9045540/1/../bin/lava-test-case
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/63e1f8d4f7cb4503db8c8700
        failing since 17 days (last pass: v5.10.158-cip22-435-g2c52868ae1cb=
c, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-02-07T07:07:18.169748  [   24.560628] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dfail>

    2023-02-07T07:07:18.188706  BusyBox v1.31.1 (2023-02-03 20:15:52 UTC) m=
ulti-call binary.

    2023-02-07T07:07:18.189187  =


    2023-02-07T07:07:18.201025  Usage: seq [-w] [-s SEP] [FIRST [INC]] LA[ =
  24.590258] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-au=
dio-present RESULT=3Dfail>
   =


  * baseline.bootrr.dwhdmi-rockchip-probed: https://kernelci.org/test/case/=
id/63e1f8d4f7cb4503db8c8701
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752)

    2023-02-07T07:07:18.129299  /lava-9045540/1/../bin/lava-test-case
   =


  * baseline.bootrr.dw_wdt-driver-present: https://kernelci.org/test/case/i=
d/63e1f8d4f7cb4503db8c8706
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752)

    2023-02-07T07:07:15.877167  /lava-9045540/1/../bin/lava-test-case
   =


  * baseline.bootrr.cros-ec-keyb-probed: https://kernelci.org/test/case/id/=
63e1f8d4f7cb4503db8c870b
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752)

    2023-02-07T07:07:13.644534  [   20.034712] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcros-ec-keyb-driver-present RESULT=3Dpass>

    2023-02-07T07:07:14.659936  /lava-9045540/1/../bin/lava-test-case
   =


  * baseline.bootrr.cros-ec-i2c-tunnel-driver-present: https://kernelci.org=
/test/case/id/63e1f8d4f7cb4503db8c870d
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752)

    2023-02-07T07:07:10.407871  [   16.797702] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcros-ec-dev-driver-present RESULT=3Dfail>

    2023-02-07T07:07:10.839052  [   17.227242] asix 3-1:1.0 eth0: register =
'asix' at usb-ff580000.usb-1, ASIX AX88772B USB 2.0 Ethernet, 00:6f:00:09:0=
8:66

    2023-02-07T07:07:10.860695  [   17.252638] dwmmc_rockchip ff0d0000.dwmm=
c: IDMAC supports 32-bit address mode.

    2023-02-07T07:07:10.868762  [   17.261029] dwmmc_rockchip ff0d0000.dwmm=
c: Using internal DMA controller.

    2023-02-07T07:07:10.874875  [   17.268090] dwmmc_rockchip ff0d0000.dwmm=
c: Version ID is 270a

    2023-02-07T07:07:10.884733  [   17.274115] dwmmc_rockchip ff0d0000.dwmm=
c: DW MMC controller at irq 30,32 bit host data width,256 deep fifo

    2023-02-07T07:07:11.430391  /lava-9045540/1/../bin/lava-test-case

    2023-02-07T07:07:11.460501  [   17.850695] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcros-ec-dev-probed RESULT=3Dblocked>

    2023-02-07T07:07:12.479981  /lava-9045540/1/../bin/lava-test-case
   =


  * baseline.bootrr.cros-ec-dev-driver-present: https://kernelci.org/test/c=
ase/id/63e1f8d4f7cb4503db8c870e
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752)

    2023-02-07T07:07:09.500949  [   15.895287] dwc2 ff580000.usb: DWC OTG C=
ontroller

    2023-02-07T07:07:09.508194  [   15.900071] dwc2 ff580000.usb: new USB b=
us registered, assigned bus number 3

    2023-02-07T07:07:09.513653  [   15.907178] dwc2 ff580000.usb: irq 43, i=
o mem 0x00000000

    2023-02-07T07:07:09.519642  [   15.914203] hub 3-0:1.0: USB hub found

    2023-02-07T07:07:09.523132  [   15.918102] hub 3-0:1.0: 1 port detected

    2023-02-07T07:07:09.536994  [   15.928578] dwmmc_rockchip ff0d0000.dwmm=
c: IDMAC supports 32-bit address mode.

    2023-02-07T07:07:09.543863  [   15.936166] dwmmc_rockchip ff0d0000.dwmm=
c: Using internal DMA controller.

    2023-02-07T07:07:09.550022  [   15.943048] dwmmc_rockchip ff0d0000.dwmm=
c: Version ID is 270a

    2023-02-07T07:07:09.559662  [   15.948903] dwmmc_rockchip ff0d0000.dwmm=
c: DW MMC controller at irq 30,32 bit host data width,256 deep fifo

    2023-02-07T07:07:09.822573  [   16.215224] usb 3-1: new high-speed USB =
device number 2 using dwc2
 =

    ... (1 line(s) more)  =

 =20

