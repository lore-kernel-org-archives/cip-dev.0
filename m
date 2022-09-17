Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8167EECAAA1
	for <webhook@archiver.kernel.org>; Sat, 17 Sep 2022 16:15:35 +0000 (UTC)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by mx.groups.io with SMTP id smtpd.web12.122.1663431332186583596
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 17 Sep 2022 09:15:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=MqrlbbdD;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.52,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f52.google.com with SMTP id
 q15-20020a17090a304f00b002002ac83485so2358727pjl.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 17 Sep 2022 09:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=GEsCqpdxWmfbhvYDIMusmpN3C6zmLG2Q6xnACXQHZr0=;
        b=MqrlbbdDjqm770us5fqhkZSxf4Rqv6k1zS/lmBUmllQUTKVdSUO8D/fvhU+t8/M37+
         hqlNy2ms3sYzrI7MzpIvrfR6+Ao/1hBezB7fU9GaR8ZaLqHfWw+AYhLKe8OpUGT/ccBA
         ysXlKdu5jBEcQZO+TyAZxZb263b5FVM0PRLcY05bdc0XnftsxjWYXYoLS+le8KOkNWsZ
         cTgmcEPb7r/phvFyq6hhztgDqyJ0ZktHTrR00UpoN/dwiPMymocldt3EpWmA32swxKem
         qFYsvPlbVNuSSV5uL5rld5Deb/H5YMYjdY9QGnC93P8l4iXag/Gj1Efj5W5y4bPKYfJi
         3LyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=GEsCqpdxWmfbhvYDIMusmpN3C6zmLG2Q6xnACXQHZr0=;
        b=YH75xZiIusd/NYfAC8/NTCv4y8cBjv844z9/oao1qQ0g+j5jXNl/eMUyhvzUc/Nuwp
         zkToouBXv6CU5hX0vwtxo+vxAGsBDTxADyDXtneBIZUS66bt8gQtns7+vjyLCjIslqUO
         qGj1+dkMJLcotYI9/uTKTx5sqJx569BLK0pQlMG/ZoQJfG45i6maFTNw1xPHKcD67QFL
         fcXnYaPU+1Zuvi9KRsV+xszoyv+8+VHmS5/BgZIUw5zl6mNIU9a9dacW5xkxSXfCyuhs
         pmZHrZqlkIkxfxjcExtPMFz+mlQEQ11L314ZqJ5b2DMK0jyw8AUSA2WgkQfZ7NIdqjrd
         kcRg==
X-Gm-Message-State: ACrzQf17CjLn8ssukUZlr7RjXV78LH1E8Z4F0vR2UMhmov5V1cLc4n9G
	+fXJ0vK1UBKJsNFANnnFJhoKxS+rRYKbi2Ag06Y=
X-Google-Smtp-Source: 
 AMsMyM64w318M/DB7i8rgTVq8KaHBTwXAiKNmXFhWs544DosVJili8cdN/ppCM61fhmtuKQ+x26uJg==
X-Received: by 2002:a17:903:489:b0:176:e84a:90be with SMTP id
 jj9-20020a170903048900b00176e84a90bemr5283279plb.34.1663431330426;
        Sat, 17 Sep 2022 09:15:30 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 w70-20020a628249000000b005363bc65bafsm16633464pfd.57.2022.09.17.09.15.29
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Sep 2022 09:15:30 -0700 (PDT)
Message-ID: <6325f2a2.620a0220.54138.d9e7@mx.google.com>
Date: Sat, 17 Sep 2022 09:15:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st20-229-gb433f12afe250
Subject: cip-gitlab/ci/pavel/linux-test baseline: 83 runs,
 53 regressions (v4.4-st20-229-gb433f12afe250)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 17 Sep 2022 16:15:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9499

cip-gitlab/ci/pavel/linux-test baseline: 83 runs, 53 regressions (v4.4-st20=
-229-gb433f12afe250)

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

beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
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
nux-test/kernel/v4.4-st20-229-gb433f12afe250/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st20-229-gb433f12afe250
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b433f12afe2506afd30066f5b2b826129a20bc03 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6325edc7273601364e355654

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6325edc7273601364e355=
655
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6325ec7a823e7de34f35565a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6325ec7a823e7de34f355=
65b
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6325ec2cffd552ae27355643

  Results:     4 PASS, 1 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/arm/multi_v7_defconfig/gcc-10/lab-broonie/bas=
eline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/arm/multi_v7_defconfig/gcc-10/lab-broonie/bas=
eline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/armel/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/6325ec2cffd552ae=
2735564c
        new failure (last pass: v5.10.131-cip13-84-g5fcbe4a63ab4d)
        1 lines

    2022-09-17T15:47:44.539807  / # =

    2022-09-17T15:47:44.544980  =

    2022-09-17T15:47:44.646758  / # #
    2022-09-17T15:47:44.651610  #
    2022-09-17T15:47:44.752769  / # export SHELL=3D/bin/sh
    2022-09-17T15:47:44.757341  export SHELL=3D/bin/sh
    2022-09-17T15:47:44.858896  / # . /lava-527895/environment
    2022-09-17T15:47:44.865015  . /lava-527895/environment
    2022-09-17T15:47:44.966712  / # /lava-527895/bin/lava-test-runner /lava=
-527895/0
    2022-09-17T15:47:44.971455  /lava-527895/bin/lava-test-runner /lava-527=
895/0 =

    ... (9 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6325eb1207709ce07235566f

  Results:     4 PASS, 1 FAIL, 2 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/arm/omap2plus_defconfig/gcc-10/lab-broonie/ba=
seline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/arm/omap2plus_defconfig/gcc-10/lab-broonie/ba=
seline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/armel/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/6325eb1207709ce0=
72355678
        new failure (last pass: v5.10.131-cip13-84-g5fcbe4a63ab4d)
        1 lines

    2022-09-17T15:43:03.746928  / # =

    2022-09-17T15:43:03.755417  =

    2022-09-17T15:43:03.859449  / # #
    2022-09-17T15:43:03.866349  #
    2022-09-17T15:43:03.968470  / # export SHELL=3D/bin/sh
    2022-09-17T15:43:03.976023  export SHELL=3D/bin/sh
    2022-09-17T15:43:04.077888  / # . /lava-527839/environment
    2022-09-17T15:43:04.085340  . /lava-527839/environment
    2022-09-17T15:43:04.187241  / # /lava-527839/bin/lava-test-runner /lava=
-527839/0
    2022-09-17T15:43:04.192226  /lava-527839/bin/lava-test-runner /lava-527=
839/0 =

    ... (9 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6325ec49ce18982055355652

  Results:     4 PASS, 1 FAIL, 2 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/arm/omap2plus_defconfig/gcc-10/lab-cip/baseli=
ne-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/arm/omap2plus_defconfig/gcc-10/lab-cip/baseli=
ne-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/armel/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/6325ec49ce189820=
55355659
        new failure (last pass: v5.10.131-cip13-84-g5fcbe4a63ab4d)
        1 lines

    2022-09-17T15:48:04.007086  / # =

    2022-09-17T15:48:04.012294  =

    2022-09-17T15:48:04.116712  / # #
    2022-09-17T15:48:04.120471  #
    2022-09-17T15:48:04.222199  / # export SHELL=3D/bin/sh
    2022-09-17T15:48:04.225739  export SHELL=3D/bin/sh
    2022-09-17T15:48:04.327210  / # . /lava-744690/environment
    2022-09-17T15:48:04.330396  . /lava-744690/environment
    2022-09-17T15:48:04.434098  / # /lava-744690/bin/lava-test-runner /lava=
-744690/0
    2022-09-17T15:48:04.437208  /lava-744690/bin/lava-test-runner /lava-744=
690/0 =

    ... (9 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6325ef34f9317112b435566f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6325ef34f9317112b4355=
670
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
odroid-xu3                   | arm    | lab-collabora | gcc-10   | exynos_d=
efconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/6325ebf8f77bbf7a2b355677

  Results:     4 PASS, 1 FAIL, 2 SKIP
  Full config: exynos_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/arm/exynos_defconfig/gcc-10/lab-collabora/bas=
eline-odroid-xu3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/arm/exynos_defconfig/gcc-10/lab-collabora/bas=
eline-odroid-xu3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.all-cpus-are-online: https://kernelci.org/test/case/id/=
6325ebf8f77bbf7a2b35567b
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e)

    2022-09-17T15:46:56.078131  /lava-7300420/1/../bin/lava-test-case
    2022-09-17T15:46:56.095186  [   14.891784] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dall-cpus-are-online RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-virt-gicv2          | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6325ec14157bcf77b735566f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/arm/multi_v7_defconfig/gcc-10/lab-baylibre/ba=
seline-qemu_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/arm/multi_v7_defconfig/gcc-10/lab-baylibre/ba=
seline-qemu_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6325ec14157bcf77b7355=
670
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-virt-gicv2          | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6325ec5cce18982055355673

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/arm/multi_v7_defconfig/gcc-10/lab-broonie/bas=
eline-qemu_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/arm/multi_v7_defconfig/gcc-10/lab-broonie/bas=
eline-qemu_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6325ec5cce18982055355=
674
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-virt-gicv2          | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6325ec06f77bbf7a2b355798

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/arm/multi_v7_defconfig/gcc-10/lab-collabora/b=
aseline-qemu_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/arm/multi_v7_defconfig/gcc-10/lab-collabora/b=
aseline-qemu_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6325ec06f77bbf7a2b355=
799
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-virt-gicv2-uefi     | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6325ecdcdee6aa573235564d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/arm/multi_v7_defconfig/gcc-10/lab-baylibre/ba=
seline-qemu_arm-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/arm/multi_v7_defconfig/gcc-10/lab-baylibre/ba=
seline-qemu_arm-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6325ecdcdee6aa5732355=
64e
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-virt-gicv2-uefi     | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6325ecfc7dd64900cc35566d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/arm/multi_v7_defconfig/gcc-10/lab-broonie/bas=
eline-qemu_arm-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/arm/multi_v7_defconfig/gcc-10/lab-broonie/bas=
eline-qemu_arm-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6325ecfc7dd64900cc355=
66e
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-virt-gicv2-uefi     | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6325ecd3dee6aa5732355643

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/arm/multi_v7_defconfig/gcc-10/lab-collabora/b=
aseline-qemu_arm-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/arm/multi_v7_defconfig/gcc-10/lab-collabora/b=
aseline-qemu_arm-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6325ecd3dee6aa5732355=
644
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-virt-gicv3          | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6325ec13157bcf77b735566c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/arm/multi_v7_defconfig/gcc-10/lab-baylibre/ba=
seline-qemu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/arm/multi_v7_defconfig/gcc-10/lab-baylibre/ba=
seline-qemu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6325ec13157bcf77b7355=
66d
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-virt-gicv3          | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6325ec4725264f72cd355657

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/arm/multi_v7_defconfig/gcc-10/lab-broonie/bas=
eline-qemu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/arm/multi_v7_defconfig/gcc-10/lab-broonie/bas=
eline-qemu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6325ec4725264f72cd355=
658
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-virt-gicv3          | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6325ebf77df780f379355673

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/arm/multi_v7_defconfig/gcc-10/lab-collabora/b=
aseline-qemu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/arm/multi_v7_defconfig/gcc-10/lab-collabora/b=
aseline-qemu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6325ebf77df780f379355=
674
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-virt-gicv3-uefi     | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6325ecdbdee6aa5732355649

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/arm/multi_v7_defconfig/gcc-10/lab-baylibre/ba=
seline-qemu_arm-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/arm/multi_v7_defconfig/gcc-10/lab-baylibre/ba=
seline-qemu_arm-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6325ecdbdee6aa5732355=
64a
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-virt-gicv3-uefi     | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6325ecfb7dd64900cc355669

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/arm/multi_v7_defconfig/gcc-10/lab-broonie/bas=
eline-qemu_arm-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/arm/multi_v7_defconfig/gcc-10/lab-broonie/bas=
eline-qemu_arm-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6325ecfb7dd64900cc355=
66a
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-virt-gicv3-uefi     | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6325ece2dee6aa5732355653

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/arm/multi_v7_defconfig/gcc-10/lab-collabora/b=
aseline-qemu_arm-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/arm/multi_v7_defconfig/gcc-10/lab-collabora/b=
aseline-qemu_arm-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6325ece2dee6aa5732355=
654
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-baylibre  | gcc-10   | x86_64_d=
efconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/6325ec3b25264f72cd355651

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig/gcc-10/lab-baylibre/b=
aseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig/gcc-10/lab-baylibre/b=
aseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6325ec3b25264f72cd355=
652
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-baylibre  | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6325ec63ce1898205535567a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-baylibre/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-baylibre/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6325ec63ce18982055355=
67b
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-broonie   | gcc-10   | x86_64_d=
efconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/6325ec5b03d018c340355642

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig/gcc-10/lab-broonie/ba=
seline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig/gcc-10/lab-broonie/ba=
seline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6325ec5b03d018c340355=
643
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-broonie   | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6325ecbfe65ab0b251355682

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-broonie/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-broonie/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6325ecbfe65ab0b251355=
683
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/6325ec56ce1898205535566c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig/gcc-10/lab-collabora/=
baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig/gcc-10/lab-collabora/=
baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6325ec56ce18982055355=
66d
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6325ec83823e7de34f35567c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6325ec83823e7de34f355=
67d
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 28         =


  Details:     https://kernelci.org/test/plan/id/6325ebfc7df780f379355677

  Results:     39 PASS, 30 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/arm/multi_v7_defconfig/gcc-10/lab-collabora/b=
aseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/arm/multi_v7_defconfig/gcc-10/lab-collabora/b=
aseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-vopl-probed: https://kernelci.org/test/case/id=
/6325ebfc7df780f37935567c
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e)

    2022-09-17T15:46:47.138272  /lava-7300508/1/../bin/lava-test-case
    2022-09-17T15:46:47.162897  [   48.083046] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-vopl-probed RESULT=3Dfail>   =


  * baseline.bootrr.rockchip-vopb-probed: https://kernelci.org/test/case/id=
/6325ebfc7df780f37935567d
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e)

    2022-09-17T15:46:46.079731  /lava-7300508/1/../bin/lava-test-case
    2022-09-17T15:46:46.106181  [   47.024640] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-vopb-probed RESULT=3Dfail>   =


  * baseline.bootrr.rockchip-usb-phy-grf-probed: https://kernelci.org/test/=
case/id/6325ebfc7df780f37935567f
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e)

    2022-09-17T15:46:44.968514  /lava-7300508/1/../bin/lava-test-case
    2022-09-17T15:46:44.993836  [   45.912858] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-usb-phy-grf-probed RESULT=3Dfail>   =


  * baseline.bootrr.rockchip-pwm0-probed: https://kernelci.org/test/case/id=
/6325ebfc7df780f379355687
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e)

    2022-09-17T15:46:43.757441  /lava-7300508/1/../bin/lava-test-case
    2022-09-17T15:46:43.781960  [   44.701724] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-pwm0-probed RESULT=3Dfail>   =


  * baseline.bootrr.rockchip-pm-domain-pmu-probed: https://kernelci.org/tes=
t/case/id/6325ebfc7df780f379355689
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e)

    2022-09-17T15:46:42.669319  /lava-7300508/1/../bin/lava-test-case
    2022-09-17T15:46:42.694756  [   43.613602] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-pm-domain-pmu-probed RESULT=3Dfail>   =


  * baseline.bootrr.rockchip-pm-domain-driver-present: https://kernelci.org=
/test/case/id/6325ebfc7df780f37935568a
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e)

    2022-09-17T15:46:41.628176  /lava-7300508/1/../bin/lava-test-case
    2022-09-17T15:46:41.654029  [   42.572471] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-pm-domain-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.rockchip-iodomain-driver-present: https://kernelci.org/=
test/case/id/6325ebfc7df780f37935568c
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e)

    2022-09-17T15:46:39.529387  /lava-7300508/1/../bin/lava-test-case
    2022-09-17T15:46:39.549981  [   40.469125] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-iodomain-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.rockchip-i2s-probed: https://kernelci.org/test/case/id/=
6325ebfc7df780f37935568d
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e)

    2022-09-17T15:46:38.472732  /lava-7300508/1/../bin/lava-test-case
    2022-09-17T15:46:38.496504  [   39.415530] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-i2s-probed RESULT=3Dfail>   =


  * baseline.bootrr.rockcip-i2s-driver-present: https://kernelci.org/test/c=
ase/id/6325ebfc7df780f37935568e
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e)

    2022-09-17T15:46:37.413249  /lava-7300508/1/../bin/lava-test-case
    2022-09-17T15:46:37.437343  [   38.356500] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockcip-i2s-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.rockchip-dp-phy-grf-probed: https://kernelci.org/test/c=
ase/id/6325ebfc7df780f37935568f
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e)

    2022-09-17T15:46:36.350703  /lava-7300508/1/../bin/lava-test-case
    2022-09-17T15:46:36.375874  [   37.294918] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-dp-phy-grf-probed RESULT=3Dfail>   =


  * baseline.bootrr.rockchip-dp-phy-driver-present: https://kernelci.org/te=
st/case/id/6325ebfc7df780f379355690
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e)

    2022-09-17T15:46:35.290163  /lava-7300508/1/../bin/lava-test-case
    2022-09-17T15:46:35.314822  [   36.234168] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-dp-phy-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.rockchip-dp-edp-probed: https://kernelci.org/test/case/=
id/6325ebfc7df780f379355691
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e)

    2022-09-17T15:46:34.247781  /lava-7300508/1/../bin/lava-test-case
    2022-09-17T15:46:34.265411  [   35.184709] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-dp-edp-probed RESULT=3Dfail>   =


  * baseline.bootrr.rockchip-dp-driver-present: https://kernelci.org/test/c=
ase/id/6325ebfc7df780f379355692
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e)

    2022-09-17T15:46:33.187927  /lava-7300508/1/../bin/lava-test-case
    2022-09-17T15:46:33.211988  [   34.131637] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-dp-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.rk_iommu-vpu_mmu-probed: https://kernelci.org/test/case=
/id/6325ebfc7df780f379355693
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e)

    2022-09-17T15:46:32.131019  /lava-7300508/1/../bin/lava-test-case
    2022-09-17T15:46:32.154808  [   33.073822] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk_iommu-vpu_mmu-probed RESULT=3Dfail>   =


  * baseline.bootrr.rk_iommu-vopl_mmu-probed: https://kernelci.org/test/cas=
e/id/6325ebfc7df780f379355694
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e)

    2022-09-17T15:46:31.069045  /lava-7300508/1/../bin/lava-test-case
    2022-09-17T15:46:31.094618  [   32.013879] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk_iommu-vopl_mmu-probed RESULT=3Dfail>   =


  * baseline.bootrr.rk_iommu-vopb_mmu-probed: https://kernelci.org/test/cas=
e/id/6325ebfc7df780f379355695
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e)

    2022-09-17T15:46:30.024089  /lava-7300508/1/../bin/lava-test-case
    2022-09-17T15:46:30.044964  [   30.964146] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk_iommu-vopb_mmu-probed RESULT=3Dfail>   =


  * baseline.bootrr.rk3288-crypto-probed: https://kernelci.org/test/case/id=
/6325ebfc7df780f37935569d
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e)

    2022-09-17T15:46:28.743140  /lava-7300508/1/../bin/lava-test-case
    2022-09-17T15:46:28.767329  [   29.687158] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk3288-crypto-probed RESULT=3Dfail>   =


  * baseline.bootrr.rk3288-crypto-driver-present: https://kernelci.org/test=
/case/id/6325ebfc7df780f37935569e
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e)

    2022-09-17T15:46:27.687434  /lava-7300508/1/../bin/lava-test-case
    2022-09-17T15:46:27.709794  [   28.628346] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk3288-crypto-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.ramoops-probed: https://kernelci.org/test/case/id/6325e=
bfc7df780f37935569f
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e)

    2022-09-17T15:46:26.625273  /lava-7300508/1/../bin/lava-test-case
    2022-09-17T15:46:26.649147  [   27.569809] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dramoops-probed RESULT=3Dfail>   =


  * baseline.bootrr.ramoops-driver-present: https://kernelci.org/test/case/=
id/6325ebfc7df780f3793556a0
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e)

    2022-09-17T15:46:25.564483  /lava-7300508/1/../bin/lava-test-case
    2022-09-17T15:46:25.589492  [   26.509145] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dramoops-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.dwhdmi-rockchip-probed: https://kernelci.org/test/case/=
id/6325ebfc7df780f3793556a9
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e)

    2022-09-17T15:46:23.264812  /lava-7300508/1/../bin/lava-test-case
    2022-09-17T15:46:23.291266  [   24.210792] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dfail>   =


  * baseline.bootrr.dw_wdt-probed: https://kernelci.org/test/case/id/6325eb=
fc7df780f3793556ae
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e)

    2022-09-17T15:46:22.076793  /lava-7300508/1/../bin/lava-test-case
    2022-09-17T15:46:22.100644  [   23.020228] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddw_wdt-probed RESULT=3Dfail>   =


  * baseline.bootrr.dw_wdt-driver-present: https://kernelci.org/test/case/i=
d/6325ebfc7df780f3793556af
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e)

    2022-09-17T15:46:21.018504  /lava-7300508/1/../bin/lava-test-case
    2022-09-17T15:46:21.041470  [   21.960928] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddw_wdt-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cros-ec-keyb-probed: https://kernelci.org/test/case/id/=
6325ebfc7df780f3793556b4
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e)

    2022-09-17T15:46:19.880254  /lava-7300508/1/../bin/lava-test-case
    2022-09-17T15:46:19.904661  [   20.823974] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcros-ec-keyb-probed RESULT=3Dfail>   =


  * baseline.bootrr.cros-ec-i2c-tunnel-probed: https://kernelci.org/test/ca=
se/id/6325ebfc7df780f3793556b6
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e)

    2022-09-17T15:46:18.769976  /lava-7300508/1/../bin/lava-test-case
    2022-09-17T15:46:18.793427  [   19.712357] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcros-ec-i2c-tunnel-probed RESULT=3Dfail>   =


  * baseline.bootrr.cros-ec-i2c-tunnel-driver-present: https://kernelci.org=
/test/case/id/6325ebfc7df780f3793556b7
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e)

    2022-09-17T15:46:17.709482  /lava-7300508/1/../bin/lava-test-case
    2022-09-17T15:46:17.735387  [   18.653291] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcros-ec-i2c-tunnel-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cros-ec-dev-probed: https://kernelci.org/test/case/id/6=
325ebfc7df780f3793556b8
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e)

    2022-09-17T15:46:15.644635  [   16.559685] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcros-ec-dev-driver-present RESULT=3Dfail>
    2022-09-17T15:46:15.829558  [   16.749992] usb 2-1.1: new high-speed US=
B device number 3 using dwc2
    2022-09-17T15:46:15.934320  [   16.858591] smsc95xx v1.0.4
    2022-09-17T15:46:15.999565  [   16.910221] smsc95xx 2-1.1:1.0 eth0: reg=
ister 'smsc95xx' at usb-ff580000.usb-1.1, smsc95xx USB 2.0 Ethernet, 94:eb:=
2c:00:03:cf
    2022-09-17T15:46:16.013885  [   16.929204] dwmmc_rockchip ff0d0000.dwmm=
c: IDMAC supports 32-bit address mode.
    2022-09-17T15:46:16.019226  [   16.937074] dwmmc_rockchip ff0d0000.dwmm=
c: Using internal DMA controller.
    2022-09-17T15:46:16.030727  [   16.943968] dwmmc_rockchip ff0d0000.dwmm=
c: Version ID is 270a
    2022-09-17T15:46:16.036152  [   16.949824] dwmmc_rockchip ff0d0000.dwmm=
c: DW MMC controller at irq 30,32 bit host data width,256 deep fifo
    2022-09-17T15:46:16.369845  [   17.291286] random: nonblocking pool is =
initialized
    2022-09-17T15:46:16.653073  /lava-7300508/1/../bin/lava-test-case =

    ... (1 line(s) more)  =


  * baseline.bootrr.cros-ec-dev-driver-present: https://kernelci.org/test/c=
ase/id/6325ebfc7df780f3793556b9
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e)

    2022-09-17T15:46:14.973665  [   15.890303] dwc2 ff580000.usb: DWC OTG C=
ontroller
    2022-09-17T15:46:14.985932  [   15.895074] dwc2 ff580000.usb: new USB b=
us registered, assigned bus number 2
    2022-09-17T15:46:14.986138  [   15.902168] dwc2 ff580000.usb: irq 43, i=
o mem 0x00000000
    2022-09-17T15:46:14.986315  [   15.908195] hub 2-0:1.0: USB hub found
    2022-09-17T15:46:14.998881  [   15.912001] hub 2-0:1.0: 1 port detected
    2022-09-17T15:46:14.999085  [   15.917860] ehci-platform ff500000.usb: =
EHCI Host Controller
    2022-09-17T15:46:15.003991  [   15.923582] ehci-platform ff500000.usb: =
new USB bus registered, assigned bus number 3
    2022-09-17T15:46:15.010450  [   15.931643] ehci-platform ff500000.usb: =
irq 41, io mem 0xff500000
    2022-09-17T15:46:15.028678  [   15.945001] ehci-platform ff500000.usb: =
USB 2.0 started, EHCI 1.00
    2022-09-17T15:46:15.028885  [   15.951812] hub 3-0:1.0: USB hub found =

    ... (28 line(s) more)  =

 =20

