Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE5BC6FA90
	for <webhook@archiver.kernel.org>; Sun, 18 Sep 2022 15:17:01 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.web12.9641.1663514212653118778
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 18 Sep 2022 08:16:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=VgeX28Cm;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.50,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f50.google.com with SMTP id y11so8557894pjv.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 18 Sep 2022 08:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=pZ1I0A9RubY2SKGOMuT2y+p4Sn00TbGWGORn/WSde0s=;
        b=VgeX28CmbYHFe7NzQ/xONX4K1om0gEeGjYF3bUvnzWGyy4hxthR2lT7Ds5/k4dDGsF
         5R4LZGQebJFKZFiC+ZQfQDg6t9kHLJ6ExmGCb9/g9FXhQy2VKBwYFqTChBAF7cKhsNC5
         7G+Fxw4y10j8Pif3AXrpiiWXDNSxWUf1lChoAksocwcMfCK8AC6G6S5AZU9mBpKx1yO0
         phE8fOuMCiU1v2lHiYWvfNCVJbyLmBWb7cQ1Vyod80r2Mm5uxvg8e0CeOl3ry+zAPHW2
         Aa842+HhVOa0FXR27alruoxJwLoE/hOy3q3/6LG13sM6RKSIPiCJnFwZZVcfwRIwlrK+
         FL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=pZ1I0A9RubY2SKGOMuT2y+p4Sn00TbGWGORn/WSde0s=;
        b=dXmUwlzUQ2rOwWX4XlGBxRzZKt2HNddcHgWtctDzCiwk9RfJVeEOPE2Qes1aTSdhuJ
         6Hy2Kit4Z4qWxNPjNasLkUQaOR/Cl1dxmKqL4+4yINVJ9Z13o4vCILET3klq5ECbmo8n
         yReFE/LBXcrOYmddG018sBCwLSRhsiKvZhU1u2yVeZtDsZPA+G9gFvuITaLAYtcgwmft
         8iHz7vJWbWLPEpBTL+fMxZszKbUiz3iX40izNOpM0347QsRlmhvLzZ4CLoDm2hEeQqcA
         u89ISR2c7yZVirv+6mb4tIyu8sbA0Vvnqa6Ez10yh0BvZYzhHfWHhi5Zf/l6VrK8LDdX
         YMDA==
X-Gm-Message-State: ACrzQf20bvyeP0xcdfaj/sOrXh5/6QZ7Iru4bgJigpgMlklmlIFmDEA2
	lBOOdmgzk3fQnn4tWs9FdlcOLUXYvTbOQXMGh08=
X-Google-Smtp-Source: 
 AMsMyM78WMBt6a2bPgynfYBPJQVjqKtsG3D3IXTLHKIVg7SkZQyo4SSoXLE5Pa6JtHhCyEenYD3zHQ==
X-Received: by 2002:a17:903:25d3:b0:176:e9d3:64bc with SMTP id
 jc19-20020a17090325d300b00176e9d364bcmr8777871plb.45.1663514211071;
        Sun, 18 Sep 2022 08:16:51 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 y62-20020a62ce41000000b0053e72ed5252sm18124819pfg.42.2022.09.18.08.16.49
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Sep 2022 08:16:50 -0700 (PDT)
Message-ID: <63273662.620a0220.ad16a.efe7@mx.google.com>
Date: Sun, 18 Sep 2022 08:16:50 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st20-231-g7349cef09ddd2
Subject: cip-gitlab/ci/pavel/linux-test baseline: 85 runs,
 55 regressions (v4.4-st20-231-g7349cef09ddd2)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 18 Sep 2022 15:17:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9511

cip-gitlab/ci/pavel/linux-test baseline: 85 runs, 55 regressions (v4.4-st20=
-231-g7349cef09ddd2)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

bcm2835-rpi-b-rev2           | arm    | lab-broonie   | gcc-10   | bcm2835_=
defconfig            | 1          =

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

odroid-xu3                   | arm    | lab-collabora | gcc-10   | exynos_d=
efconfig             | 1          =

qemu_arm-virt-gicv2          | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

qemu_arm-virt-gicv2          | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

qemu_arm-virt-gicv2          | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =

qemu_arm-virt-gicv2-uefi     | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

qemu_arm-virt-gicv2-uefi     | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

qemu_arm-virt-gicv2-uefi     | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =

qemu_arm-virt-gicv3          | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

qemu_arm-virt-gicv3          | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

qemu_arm-virt-gicv3          | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =

qemu_arm-virt-gicv3-uefi     | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

qemu_arm-virt-gicv3-uefi     | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

qemu_arm-virt-gicv3-uefi     | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =

qemu_x86_64-uefi-mixed       | x86_64 | lab-baylibre  | gcc-10   | x86_64_d=
efconfig             | 1          =

qemu_x86_64-uefi-mixed       | x86_64 | lab-baylibre  | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

qemu_x86_64-uefi-mixed       | x86_64 | lab-broonie   | gcc-10   | x86_64_d=
efconfig             | 1          =

qemu_x86_64-uefi-mixed       | x86_64 | lab-broonie   | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

qemu_x86_64-uefi-mixed       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig             | 1          =

qemu_x86_64-uefi-mixed       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

rk3288-veyron-jaq            | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 28         =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st20-231-g7349cef09ddd2/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st20-231-g7349cef09ddd2
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      7349cef09ddd27c4d55cc11d23fdf232c9184ccc =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63273136e13cd32000355654

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63273136e13cd32000355=
655
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63272ff9b3730f4785355652

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63272ff9b3730f4785355=
653
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
bcm2835-rpi-b-rev2           | arm    | lab-broonie   | gcc-10   | bcm2835_=
defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/63272ecc530df17110355660

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/arm/bcm2835_defconfig/gcc-10/lab-broonie/base=
line-bcm2835-rpi-b-rev2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/arm/bcm2835_defconfig/gcc-10/lab-broonie/base=
line-bcm2835-rpi-b-rev2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63272ecc530df17110355=
661
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63272fa9018d59c4a0355686

  Results:     4 PASS, 1 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/arm/multi_v7_defconfig/gcc-10/lab-broonie/bas=
eline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/arm/multi_v7_defconfig/gcc-10/lab-broonie/bas=
eline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/armel/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/63272fa9018d59c4=
a035568f
        failing since 0 day (last pass: v5.10.131-cip13-84-g5fcbe4a63ab4d, =
first fail: v4.4-st20-229-gb433f12afe250)
        1 lines

    2022-09-18T14:48:02.248904  / # =

    2022-09-18T14:48:02.255017  =

    2022-09-18T14:48:02.359002  / # #
    2022-09-18T14:48:02.365149  #
    2022-09-18T14:48:02.467225  / # export SHELL=3D/bin/sh
    2022-09-18T14:48:02.473475  export SHELL=3D/bin/sh
    2022-09-18T14:48:02.575229  / # . /lava-530034/environment
    2022-09-18T14:48:02.581364  . /lava-530034/environment
    2022-09-18T14:48:02.683232  / # /lava-530034/bin/lava-test-runner /lava=
-530034/0
    2022-09-18T14:48:02.688813  /lava-530034/bin/lava-test-runner /lava-530=
034/0 =

    ... (9 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/632732acf331268b9e355657

  Results:     4 PASS, 1 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/arm/multi_v7_defconfig/gcc-10/lab-cip/baselin=
e-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/arm/multi_v7_defconfig/gcc-10/lab-cip/baselin=
e-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/armel/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/632732acf331268b=
9e35565e
        failing since 0 day (last pass: v5.10.131-cip13-84-g5fcbe4a63ab4d, =
first fail: v4.4-st20-229-gb433f12afe250)
        1 lines

    2022-09-18T15:00:37.572098  / # =

    2022-09-18T15:00:37.578667  =

    2022-09-18T15:00:37.682056  / # #
    2022-09-18T15:00:37.689035  #
    2022-09-18T15:00:37.790687  / # export SHELL=3D/bin/sh
    2022-09-18T15:00:37.797475  export SHELL=3D/bin/sh
    2022-09-18T15:00:37.898714  / # . /lava-744990/environment
    2022-09-18T15:00:37.906132  . /lava-744990/environment
    2022-09-18T15:00:38.007594  / # /lava-744990/bin/lava-test-runner /lava=
-744990/0
    2022-09-18T15:00:38.013928  /lava-744990/bin/lava-test-runner /lava-744=
990/0 =

    ... (9 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6327300c81ef292161355668

  Results:     4 PASS, 1 FAIL, 2 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/arm/omap2plus_defconfig/gcc-10/lab-broonie/ba=
seline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/arm/omap2plus_defconfig/gcc-10/lab-broonie/ba=
seline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/armel/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/6327300c81ef2921=
61355671
        failing since 0 day (last pass: v5.10.131-cip13-84-g5fcbe4a63ab4d, =
first fail: v4.4-st20-229-gb433f12afe250)
        1 lines

    2022-09-18T14:49:39.407078  / # =

    2022-09-18T14:49:39.414333  =

    2022-09-18T14:49:39.516053  / # #
    2022-09-18T14:49:39.521838  #
    2022-09-18T14:49:39.622870  / # export SHELL=3D/bin/sh
    2022-09-18T14:49:39.628650  export SHELL=3D/bin/sh
    2022-09-18T14:49:39.729601  / # . /lava-530052/environment
    2022-09-18T14:49:39.735187  . /lava-530052/environment
    2022-09-18T14:49:39.836148  / # /lava-530052/bin/lava-test-runner /lava=
-530052/0
    2022-09-18T14:49:39.841270  /lava-530052/bin/lava-test-runner /lava-530=
052/0 =

    ... (9 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/632733b02a70247134355761

  Results:     4 PASS, 1 FAIL, 2 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/arm/omap2plus_defconfig/gcc-10/lab-cip/baseli=
ne-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/arm/omap2plus_defconfig/gcc-10/lab-cip/baseli=
ne-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/armel/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/632733b02a702471=
34355768
        failing since 0 day (last pass: v5.10.131-cip13-84-g5fcbe4a63ab4d, =
first fail: v4.4-st20-229-gb433f12afe250)
        1 lines

    2022-09-18T15:04:57.645646  / # =

    2022-09-18T15:04:57.654602  =

    2022-09-18T15:04:57.759085  / # #
    2022-09-18T15:04:57.767228  #
    2022-09-18T15:04:57.869567  / # export SHELL=3D/bin/sh
    2022-09-18T15:04:57.876898  export SHELL=3D/bin/sh
    2022-09-18T15:04:57.978790  / # . /lava-744993/environment
    2022-09-18T15:04:57.988050  . /lava-744993/environment
    2022-09-18T15:04:58.089980  / # /lava-744993/bin/lava-test-runner /lava=
-744993/0
    2022-09-18T15:04:58.097324  /lava-744993/bin/lava-test-runner /lava-744=
993/0 =

    ... (9 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63272ff5c9992ad7b1355661

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63272ff5c9992ad7b1355=
662
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
odroid-xu3                   | arm    | lab-collabora | gcc-10   | exynos_d=
efconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/63273122d949be4e90355642

  Results:     4 PASS, 1 FAIL, 2 SKIP
  Full config: exynos_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/arm/exynos_defconfig/gcc-10/lab-collabora/bas=
eline-odroid-xu3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/arm/exynos_defconfig/gcc-10/lab-collabora/bas=
eline-odroid-xu3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.all-cpus-are-online: https://kernelci.org/test/case/id/=
63273122d949be4e90355646
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250)

    2022-09-18T14:54:07.876947  /lava-7305177/1/../bin/lava-test-case
    2022-09-18T14:54:07.894133  [   14.434791] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dall-cpus-are-online RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-virt-gicv2          | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63272ecc249218ddae355643

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/arm/multi_v7_defconfig/gcc-10/lab-baylibre/ba=
seline-qemu_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/arm/multi_v7_defconfig/gcc-10/lab-baylibre/ba=
seline-qemu_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63272ecc249218ddae355=
644
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-virt-gicv2          | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63272efab34dab689935567a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/arm/multi_v7_defconfig/gcc-10/lab-broonie/bas=
eline-qemu_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/arm/multi_v7_defconfig/gcc-10/lab-broonie/bas=
eline-qemu_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63272efab34dab6899355=
67b
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-virt-gicv2          | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63272ec53e6f1cc873355678

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/arm/multi_v7_defconfig/gcc-10/lab-collabora/b=
aseline-qemu_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/arm/multi_v7_defconfig/gcc-10/lab-collabora/b=
aseline-qemu_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63272ec53e6f1cc873355=
679
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-virt-gicv2-uefi     | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63272f94018d59c4a035565e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/arm/multi_v7_defconfig/gcc-10/lab-baylibre/ba=
seline-qemu_arm-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/arm/multi_v7_defconfig/gcc-10/lab-baylibre/ba=
seline-qemu_arm-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63272f94018d59c4a0355=
65f
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-virt-gicv2-uefi     | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63272fae018d59c4a0355691

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/arm/multi_v7_defconfig/gcc-10/lab-broonie/bas=
eline-qemu_arm-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/arm/multi_v7_defconfig/gcc-10/lab-broonie/bas=
eline-qemu_arm-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63272fae018d59c4a0355=
692
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-virt-gicv2-uefi     | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63272fa0018d59c4a0355673

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/arm/multi_v7_defconfig/gcc-10/lab-collabora/b=
aseline-qemu_arm-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/arm/multi_v7_defconfig/gcc-10/lab-collabora/b=
aseline-qemu_arm-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63272fa0018d59c4a0355=
674
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-virt-gicv3          | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63272ecd530df17110355666

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/arm/multi_v7_defconfig/gcc-10/lab-baylibre/ba=
seline-qemu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/arm/multi_v7_defconfig/gcc-10/lab-baylibre/ba=
seline-qemu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63272ecd530df17110355=
667
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-virt-gicv3          | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63272f0ed27ffc3de635565b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/arm/multi_v7_defconfig/gcc-10/lab-broonie/bas=
eline-qemu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/arm/multi_v7_defconfig/gcc-10/lab-broonie/bas=
eline-qemu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63272f0ed27ffc3de6355=
65c
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-virt-gicv3          | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63272ec63e6f1cc87335567e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/arm/multi_v7_defconfig/gcc-10/lab-collabora/b=
aseline-qemu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/arm/multi_v7_defconfig/gcc-10/lab-collabora/b=
aseline-qemu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63272ec63e6f1cc873355=
67f
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-virt-gicv3-uefi     | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63272f95018d59c4a0355662

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/arm/multi_v7_defconfig/gcc-10/lab-baylibre/ba=
seline-qemu_arm-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/arm/multi_v7_defconfig/gcc-10/lab-baylibre/ba=
seline-qemu_arm-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63272f95018d59c4a0355=
663
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-virt-gicv3-uefi     | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63272feac9992ad7b1355652

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/arm/multi_v7_defconfig/gcc-10/lab-broonie/bas=
eline-qemu_arm-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/arm/multi_v7_defconfig/gcc-10/lab-broonie/bas=
eline-qemu_arm-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63272feac9992ad7b1355=
653
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-virt-gicv3-uefi     | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63272faf018d59c4a0355694

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/arm/multi_v7_defconfig/gcc-10/lab-collabora/b=
aseline-qemu_arm-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/arm/multi_v7_defconfig/gcc-10/lab-collabora/b=
aseline-qemu_arm-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63272faf018d59c4a0355=
695
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-baylibre  | gcc-10   | x86_64_d=
efconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/63272f6cb2204d7c89355642

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/x86_64/x86_64_defconfig/gcc-10/lab-baylibre/b=
aseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/x86_64/x86_64_defconfig/gcc-10/lab-baylibre/b=
aseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63272f6cb2204d7c89355=
643
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-baylibre  | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63272fe4c9992ad7b1355642

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-baylibre/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-baylibre/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63272fe4c9992ad7b1355=
643
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-broonie   | gcc-10   | x86_64_d=
efconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/63272f9a018d59c4a0355670

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/x86_64/x86_64_defconfig/gcc-10/lab-broonie/ba=
seline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/x86_64/x86_64_defconfig/gcc-10/lab-broonie/ba=
seline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63272f9a018d59c4a0355=
671
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-broonie   | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6327303acf004a8f90355650

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-broonie/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-broonie/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6327303acf004a8f90355=
651
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/63272f6411c5227ef435566b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/x86_64/x86_64_defconfig/gcc-10/lab-collabora/=
baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/x86_64/x86_64_defconfig/gcc-10/lab-collabora/=
baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63272f6411c5227ef4355=
66c
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6327300481ef29216135565a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6327300481ef292161355=
65b
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 28         =


  Details:     https://kernelci.org/test/plan/id/63273316d1c63c843f355654

  Results:     39 PASS, 30 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/arm/multi_v7_defconfig/gcc-10/lab-collabora/b=
aseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/arm/multi_v7_defconfig/gcc-10/lab-collabora/b=
aseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-vopl-probed: https://kernelci.org/test/case/id=
/63273316d1c63c843f355659
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250)

    2022-09-18T15:02:42.388399  /lava-7305202/1/../bin/lava-test-case
    2022-09-18T15:02:42.412070  [   48.221459] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-vopl-probed RESULT=3Dfail>   =


  * baseline.bootrr.rockchip-vopb-probed: https://kernelci.org/test/case/id=
/63273316d1c63c843f35565a
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250)

    2022-09-18T15:02:41.327800  /lava-7305202/1/../bin/lava-test-case
    2022-09-18T15:02:41.351636  [   47.160880] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-vopb-probed RESULT=3Dfail>   =


  * baseline.bootrr.rockchip-usb-phy-grf-probed: https://kernelci.org/test/=
case/id/63273316d1c63c843f35565c
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250)

    2022-09-18T15:02:40.245358  /lava-7305202/1/../bin/lava-test-case
    2022-09-18T15:02:40.263902  [   46.072812] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-usb-phy-grf-probed RESULT=3Dfail>   =


  * baseline.bootrr.rockchip-pwm0-probed: https://kernelci.org/test/case/id=
/63273316d1c63c843f355664
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250)

    2022-09-18T15:02:39.015843  /lava-7305202/1/../bin/lava-test-case
    2022-09-18T15:02:39.033200  [   44.841758] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-pwm0-probed RESULT=3Dfail>   =


  * baseline.bootrr.rockchip-pm-domain-pmu-probed: https://kernelci.org/tes=
t/case/id/63273316d1c63c843f355666
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250)

    2022-09-18T15:02:37.903352  /lava-7305202/1/../bin/lava-test-case
    2022-09-18T15:02:37.928191  [   43.736363] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-pm-domain-pmu-probed RESULT=3Dfail>   =


  * baseline.bootrr.rockchip-pm-domain-driver-present: https://kernelci.org=
/test/case/id/63273316d1c63c843f355667
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250)

    2022-09-18T15:02:36.841534  /lava-7305202/1/../bin/lava-test-case
    2022-09-18T15:02:36.865642  [   42.674367] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-pm-domain-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.rockchip-iodomain-driver-present: https://kernelci.org/=
test/case/id/63273316d1c63c843f355669
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250)

    2022-09-18T15:02:34.717482  /lava-7305202/1/../bin/lava-test-case
    2022-09-18T15:02:34.744428  [   40.552010] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-iodomain-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.rockchip-i2s-probed: https://kernelci.org/test/case/id/=
63273316d1c63c843f35566a
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250)

    2022-09-18T15:02:33.659174  /lava-7305202/1/../bin/lava-test-case
    2022-09-18T15:02:33.684181  [   39.493382] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-i2s-probed RESULT=3Dfail>   =


  * baseline.bootrr.rockcip-i2s-driver-present: https://kernelci.org/test/c=
ase/id/63273316d1c63c843f35566b
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250)

    2022-09-18T15:02:32.600003  /lava-7305202/1/../bin/lava-test-case
    2022-09-18T15:02:32.623892  [   38.432880] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockcip-i2s-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.rockchip-dp-phy-grf-probed: https://kernelci.org/test/c=
ase/id/63273316d1c63c843f35566c
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250)

    2022-09-18T15:02:31.541294  /lava-7305202/1/../bin/lava-test-case
    2022-09-18T15:02:31.565547  [   37.373421] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-dp-phy-grf-probed RESULT=3Dfail>   =


  * baseline.bootrr.rockchip-dp-phy-driver-present: https://kernelci.org/te=
st/case/id/63273316d1c63c843f35566d
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250)

    2022-09-18T15:02:30.480995  /lava-7305202/1/../bin/lava-test-case
    2022-09-18T15:02:30.506624  [   36.314652] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-dp-phy-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.rockchip-dp-edp-probed: https://kernelci.org/test/case/=
id/63273316d1c63c843f35566e
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250)

    2022-09-18T15:02:29.423576  /lava-7305202/1/../bin/lava-test-case
    2022-09-18T15:02:29.447502  [   35.255713] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-dp-edp-probed RESULT=3Dfail>   =


  * baseline.bootrr.rockchip-dp-driver-present: https://kernelci.org/test/c=
ase/id/63273316d1c63c843f35566f
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250)

    2022-09-18T15:02:28.363715  /lava-7305202/1/../bin/lava-test-case
    2022-09-18T15:02:28.387997  [   34.196371] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-dp-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.rk_iommu-vpu_mmu-probed: https://kernelci.org/test/case=
/id/63273316d1c63c843f355670
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250)

    2022-09-18T15:02:27.304098  /lava-7305202/1/../bin/lava-test-case
    2022-09-18T15:02:27.328277  [   33.136655] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk_iommu-vpu_mmu-probed RESULT=3Dfail>   =


  * baseline.bootrr.rk_iommu-vopl_mmu-probed: https://kernelci.org/test/cas=
e/id/63273316d1c63c843f355671
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250)

    2022-09-18T15:02:26.251730  /lava-7305202/1/../bin/lava-test-case
    2022-09-18T15:02:26.275662  [   32.084115] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk_iommu-vopl_mmu-probed RESULT=3Dfail>   =


  * baseline.bootrr.rk_iommu-vopb_mmu-probed: https://kernelci.org/test/cas=
e/id/63273316d1c63c843f355672
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250)

    2022-09-18T15:02:25.206110  /lava-7305202/1/../bin/lava-test-case
    2022-09-18T15:02:25.225819  [   31.033695] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk_iommu-vopb_mmu-probed RESULT=3Dfail>   =


  * baseline.bootrr.rk3288-crypto-probed: https://kernelci.org/test/case/id=
/63273316d1c63c843f35567a
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250)

    2022-09-18T15:02:23.946576  /lava-7305202/1/../bin/lava-test-case
    2022-09-18T15:02:23.964734  [   29.772720] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk3288-crypto-probed RESULT=3Dfail>   =


  * baseline.bootrr.rk3288-crypto-driver-present: https://kernelci.org/test=
/case/id/63273316d1c63c843f35567b
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250)

    2022-09-18T15:02:22.901390  /lava-7305202/1/../bin/lava-test-case
    2022-09-18T15:02:22.920810  [   28.728544] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk3288-crypto-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.ramoops-probed: https://kernelci.org/test/case/id/63273=
316d1c63c843f35567c
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250)

    2022-09-18T15:02:21.843469  /lava-7305202/1/../bin/lava-test-case
    2022-09-18T15:02:21.865982  [   27.675924] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dramoops-probed RESULT=3Dfail>   =


  * baseline.bootrr.ramoops-driver-present: https://kernelci.org/test/case/=
id/63273316d1c63c843f35567d
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250)

    2022-09-18T15:02:20.781521  /lava-7305202/1/../bin/lava-test-case
    2022-09-18T15:02:20.807867  [   26.616306] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dramoops-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.dwhdmi-rockchip-probed: https://kernelci.org/test/case/=
id/63273316d1c63c843f355686
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250)

    2022-09-18T15:02:18.505844  /lava-7305202/1/../bin/lava-test-case
    2022-09-18T15:02:18.524967  [   24.332703] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dfail>   =


  * baseline.bootrr.dw_wdt-probed: https://kernelci.org/test/case/id/632733=
16d1c63c843f35568b
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250)

    2022-09-18T15:02:17.346796  /lava-7305202/1/../bin/lava-test-case
    2022-09-18T15:02:17.369830  [   23.178663] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddw_wdt-probed RESULT=3Dfail>   =


  * baseline.bootrr.dw_wdt-driver-present: https://kernelci.org/test/case/i=
d/63273316d1c63c843f35568c
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250)

    2022-09-18T15:02:16.284218  /lava-7305202/1/../bin/lava-test-case
    2022-09-18T15:02:16.309931  [   22.117843] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddw_wdt-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cros-ec-keyb-probed: https://kernelci.org/test/case/id/=
63273316d1c63c843f355691
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250)

    2022-09-18T15:02:15.115211  /lava-7305202/1/../bin/lava-test-case
    2022-09-18T15:02:15.135079  [   20.943683] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcros-ec-keyb-probed RESULT=3Dfail>   =


  * baseline.bootrr.cros-ec-i2c-tunnel-probed: https://kernelci.org/test/ca=
se/id/63273316d1c63c843f355693
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250)

    2022-09-18T15:02:14.041902  /lava-7305202/1/../bin/lava-test-case
    2022-09-18T15:02:14.060885  [   19.868890] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcros-ec-i2c-tunnel-probed RESULT=3Dfail>   =


  * baseline.bootrr.cros-ec-i2c-tunnel-driver-present: https://kernelci.org=
/test/case/id/63273316d1c63c843f355694
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250)

    2022-09-18T15:02:12.976938  /lava-7305202/1/../bin/lava-test-case
    2022-09-18T15:02:13.000385  [   18.807798] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcros-ec-i2c-tunnel-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cros-ec-dev-probed: https://kernelci.org/test/case/id/6=
3273316d1c63c843f355695
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250)

    2022-09-18T15:02:10.954965  [   16.768248] smsc95xx v1.0.4
    2022-09-18T15:02:11.032168  [   16.820460] smsc95xx 3-1.1:1.0 eth0: reg=
ister 'smsc95xx' at usb-ff580000.usb-1.1, smsc95xx USB 2.0 Ethernet, 94:eb:=
2c:00:03:cf
    2022-09-18T15:02:11.032630  [   16.837850] dwmmc_rockchip ff0d0000.dwmm=
c: IDMAC supports 32-bit address mode.
    2022-09-18T15:02:11.044245  [   16.845452] dwmmc_rockchip ff0d0000.dwmm=
c: Using internal DMA controller.
    2022-09-18T15:02:11.044788  [   16.852344] dwmmc_rockchip ff0d0000.dwmm=
c: Version ID is 270a
    2022-09-18T15:02:11.051809  [   16.858182] dwmmc_rockchip ff0d0000.dwmm=
c: DW MMC controller at irq 30,32 bit host data width,256 deep fifo
    2022-09-18T15:02:11.376961  [   17.187161] random: nonblocking pool is =
initialized
    2022-09-18T15:02:11.914459  /lava-7305202/1/../bin/lava-test-case
    2022-09-18T15:02:11.940002  [   17.748020] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcros-ec-dev-probed RESULT=3Dfail>   =


  * baseline.bootrr.cros-ec-dev-driver-present: https://kernelci.org/test/c=
ase/id/63273316d1c63c843f355696
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250)

    2022-09-18T15:02:10.040025  [   15.845217] dwc2 ff580000.usb: DWC OTG C=
ontroller
    2022-09-18T15:02:10.045624  [   15.849955] dwc2 ff580000.usb: new USB b=
us registered, assigned bus number 3
    2022-09-18T15:02:10.046127  [   15.857058] dwc2 ff580000.usb: irq 43, i=
o mem 0x00000000
    2022-09-18T15:02:10.056674  [   15.864703] hub 3-0:1.0: USB hub found
    2022-09-18T15:02:10.057220  [   15.868669] hub 3-0:1.0: 1 port detected
    2022-09-18T15:02:10.076664  [   15.881753] dwmmc_rockchip ff0d0000.dwmm=
c: IDMAC supports 32-bit address mode.
    2022-09-18T15:02:10.087754  [   15.889439] dwmmc_rockchip ff0d0000.dwmm=
c: Using internal DMA controller.
    2022-09-18T15:02:10.088259  [   15.896397] dwmmc_rockchip ff0d0000.dwmm=
c: Version ID is 270a
    2022-09-18T15:02:10.095866  [   15.902313] dwmmc_rockchip ff0d0000.dwmm=
c: DW MMC controller at irq 30,32 bit host data width,256 deep fifo
    2022-09-18T15:02:10.356235  [   16.165002] usb 3-1: new high-speed USB =
device number 2 using dwc2 =

    ... (9 line(s) more)  =

 =20

