X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
 by mx.groups.io with SMTP id smtpd.web08.25719.1653835801692612634
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 29 May 2022 07:50:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=vWZqeTmo;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.178, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f178.google.com with SMTP id j21so7992393pga.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 29 May 2022 07:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=sjomx0CiCLlku2XeoST+Ik5BlaXejO9nCDR5qiMq3WQ=;
        b=vWZqeTmoAMpcRzkgRUUKuBY6GznASYr4OWhQsOZ1vevix01RTYnBFH2Y6nFTv6ZJWn
         +xBzeNF91fNutqiSTbkpULXcEkwmuKAtBDLnRk1uL0ZkSBZo4dyPSwaglKeQFN7nfO32
         pMsTeM5U2YZXR1yCSpbbx24td5H2Q5Xg3B3iSDt+YfwseUDNXbgAocquYoxKzmtD+tmI
         248p0f/8pHbWhY4Oj7Fvmm4BeiPagkOYKyxLAxdGau/PVPvSq1Z0/KEjrnTg1AAhlfWo
         8e9gqaQstViNHDxGPBuKQv+bd9AsXgSbjkeMPnnEfqLgQDu7yqG9nsz80IqRSGfcdEnT
         YMAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=sjomx0CiCLlku2XeoST+Ik5BlaXejO9nCDR5qiMq3WQ=;
        b=CtS2mCfgMIpJT9Z+e4UD3GsQEuoh0s5XZwJhMrhsKCEhpNxoo8xIJLfmo/ad0dnUDf
         MnyQfQ6RyCUGKPaBnWfEG9Ep48yYrOLo7YNUhS7DWh/BvJQaMSDKCO14k9D28tRcJYzy
         tiTIzUdmBc2mjAIeZz9smVbufMSlbo+DPe4ni6yr+c8lxlIZ4jQ3S4eYgaZYv/pbTEeF
         TtwHt+b+uJGB97LX0z7ubmhZ42X6L6QbUjhReX+9d08Y6zQDVobpMqiFw8nSbDV4RkLm
         5jkuvMi6K6V7XMioER8LlqQ1YkQPyo3Hzs02gXucS5hEZMkaKIpe3gRIyKpYsfJYhx9q
         fmRQ==
X-Gm-Message-State: AOAM53191QsBKHv2QoWP/UH/JU+39MRrclpMLtsBSgLrkP+auMpmjipL
	hVCzuUoi5Uh3N2O7kc9VU0/RtMw2x4A87Pm1HmA=
X-Google-Smtp-Source: ABdhPJzYG5wdIOJlv14U1LZckvoMXm3Z3YqxYPsVzp1sTeyHZ9x/siwvFgsdWMmu3sQNbRlrC6RR8w==
X-Received: by 2002:a63:d557:0:b0:3fc:2282:6463 with SMTP id v23-20020a63d557000000b003fc22826463mr141387pgi.618.1653835800597;
        Sun, 29 May 2022 07:50:00 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f3-20020a170902f38300b0016368840c41sm2760340ple.14.2022.05.29.07.49.59
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 May 2022 07:49:59 -0700 (PDT)
Message-ID: <62938817.1c69fb81.8d925.5607@mx.google.com>
Date: Sun, 29 May 2022 07:49:59 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st5-297-gc0d53c2a5c03d
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test baseline: 65 runs, 52 regressions (v4.4-st5-297-gc0d53c2a5c03d) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test baseline: 65 runs, 52 regressions (v4.4-st5-=
297-gc0d53c2a5c03d)

Regressions Summary
-------------------

platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
asus-C436FA-Flip-hatch     | x86_64 | lab-collabora | gcc-10   | x86_64_def=
con...6-chromebook | 1          =

asus-cx9400-volteer        | x86_64 | lab-collabora | gcc-10   | x86_64_def=
con...6-chromebook | 1          =

at91-sama5d4_xplained      | arm    | lab-baylibre  | gcc-10   | multi_v7_d=
efconfig           | 1          =

beaglebone-black           | arm    | lab-broonie   | gcc-10   | multi_v7_d=
efconfig           | 1          =

beaglebone-black           | arm    | lab-cip       | gcc-10   | multi_v7_d=
efconfig           | 1          =

beaglebone-black           | arm    | lab-broonie   | gcc-10   | omap2plus_=
defconfig          | 1          =

beaglebone-black           | arm    | lab-cip       | gcc-10   | omap2plus_=
defconfig          | 1          =

hp-x360-12b-n4000-octopus  | x86_64 | lab-collabora | gcc-10   | x86_64_def=
con...6-chromebook | 1          =

juno-uboot                 | arm64  | lab-broonie   | gcc-10   | defconfig =
                   | 1          =

odroid-xu3                 | arm    | lab-collabora | gcc-10   | exynos_def=
config             | 1          =

qemu_arm-virt-gicv2        | arm    | lab-broonie   | gcc-10   | multi_v7_d=
efconfig           | 1          =

qemu_arm-virt-gicv2-uefi   | arm    | lab-broonie   | gcc-10   | multi_v7_d=
efconfig           | 1          =

qemu_arm-virt-gicv3        | arm    | lab-broonie   | gcc-10   | multi_v7_d=
efconfig           | 1          =

qemu_arm-virt-gicv3-uefi   | arm    | lab-broonie   | gcc-10   | multi_v7_d=
efconfig           | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-broonie   | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-broonie   | gcc-10   | defconfig =
                   | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie   | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie   | gcc-10   | defconfig =
                   | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-broonie   | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-broonie   | gcc-10   | defconfig =
                   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie   | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie   | gcc-10   | defconfig =
                   | 1          =

qemu_x86_64-uefi-mixed     | x86_64 | lab-broonie   | gcc-10   | x86_64_def=
config             | 1          =

qemu_x86_64-uefi-mixed     | x86_64 | lab-broonie   | gcc-10   | x86_64_def=
con...6-chromebook | 1          =

rk3288-veyron-jaq          | arm    | lab-collabora | gcc-10   | multi_v7_d=
efconfig           | 28         =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-297-gc0d53c2a5c03d/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-297-gc0d53c2a5c03d
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c0d53c2a5c03d0b2672a56140f211b51b3e047c1 =



Test Regressions
---------------- =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
asus-C436FA-Flip-hatch     | x86_64 | lab-collabora | gcc-10   | x86_64_def=
con...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62937bf8472253be9ea39bd5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62937bf8472253be9ea39=
bd6
        new failure (last pass: v5.10.112-cip6) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
asus-cx9400-volteer        | x86_64 | lab-collabora | gcc-10   | x86_64_def=
con...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62937a84c2cbec76d8a39c05

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62937a84c2cbec76d8a39=
c06
        new failure (last pass: v5.10.112-cip6) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
at91-sama5d4_xplained      | arm    | lab-baylibre  | gcc-10   | multi_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/62937b00688199fc02a39bf3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm/multi_v7_defconfig/gcc-10/lab-baylibre/bas=
eline-at91-sama5d4_xplained.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm/multi_v7_defconfig/gcc-10/lab-baylibre/bas=
eline-at91-sama5d4_xplained.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62937b00688199fc02a39=
bf4
        new failure (last pass: v5.10.112-cip6) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
beaglebone-black           | arm    | lab-broonie   | gcc-10   | multi_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/629378bd98dd07edfaa39be0

  Results:     4 PASS, 1 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm/multi_v7_defconfig/gcc-10/lab-broonie/base=
line-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm/multi_v7_defconfig/gcc-10/lab-broonie/base=
line-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/armel/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/629378bd98dd07ed=
faa39be9
        new failure (last pass: v5.10.112-cip6)
        1 lines

    2022-05-29T13:44:16.321487  / # =

    2022-05-29T13:44:16.327227  =

    2022-05-29T13:44:16.433206  / # #
    2022-05-29T13:44:16.438834  #
    2022-05-29T13:44:16.541309  / # export SHELL=3D/bin/sh
    2022-05-29T13:44:16.546964  export SHELL=3D/bin/sh
    2022-05-29T13:44:16.648942  / # . /lava-182641/environment
    2022-05-29T13:44:16.654538  . /lava-182641/environment
    2022-05-29T13:44:16.756542  / # /lava-182641/bin/lava-test-runner /lava=
-182641/0
    2022-05-29T13:44:16.761600  /lava-182641/bin/lava-test-runner /lava-182=
641/0 =

    ... (9 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
beaglebone-black           | arm    | lab-cip       | gcc-10   | multi_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/629379462b9c305145a39bd8

  Results:     4 PASS, 1 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline=
-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline=
-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/armel/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/629379462b9c3051=
45a39bdf
        new failure (last pass: v5.10.112-cip6)
        1 lines

    2022-05-29T13:46:23.315668  / # =

    2022-05-29T13:46:23.318576  =

    2022-05-29T13:46:23.423019  / # #
    2022-05-29T13:46:23.425847  #
    2022-05-29T13:46:23.527574  / # export SHELL=3D/bin/sh
    2022-05-29T13:46:23.530317  export SHELL=3D/bin/sh
    2022-05-29T13:46:23.631746  / # . /lava-688595/environment
    2022-05-29T13:46:23.634626  . /lava-688595/environment
    2022-05-29T13:46:23.736110  / # /lava-688595/bin/lava-test-runner /lava=
-688595/0
    2022-05-29T13:46:23.738494  /lava-688595/bin/lava-test-runner /lava-688=
595/0 =

    ... (9 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
beaglebone-black           | arm    | lab-broonie   | gcc-10   | omap2plus_=
defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/629379adc0eb3c421aa39be6

  Results:     4 PASS, 1 FAIL, 2 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm/omap2plus_defconfig/gcc-10/lab-broonie/bas=
eline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm/omap2plus_defconfig/gcc-10/lab-broonie/bas=
eline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/armel/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/629379adc0eb3c42=
1aa39bee
        failing since 18 days (last pass: v5.10.109-cip5-384-g722204542e8a,=
 first fail: v4.4-st5-260-gb0fe64f485ff)
        1 lines

    2022-05-29T13:48:20.992038  / # =

    2022-05-29T13:48:20.999803  =

    2022-05-29T13:48:21.105920  / # #
    2022-05-29T13:48:21.112712  #
    2022-05-29T13:48:21.215108  / # export SHELL=3D/bin/sh
    2022-05-29T13:48:21.221819  export SHELL=3D/bin/sh
    2022-05-29T13:48:21.323761  / # . /lava-182664/environment
    2022-05-29T13:48:21.330436  . /lava-182664/environment
    2022-05-29T13:48:21.432472  / # /lava-182664/bin/lava-test-runner /lava=
-182664/0
    2022-05-29T13:48:21.437401  /lava-182664/bin/lava-test-runner /lava-182=
664/0 =

    ... (9 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
beaglebone-black           | arm    | lab-cip       | gcc-10   | omap2plus_=
defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/62937ab69f04ed5000a39bdc

  Results:     4 PASS, 1 FAIL, 2 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm/omap2plus_defconfig/gcc-10/lab-cip/baselin=
e-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm/omap2plus_defconfig/gcc-10/lab-cip/baselin=
e-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/armel/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/62937ab69f04ed50=
00a39be3
        failing since 18 days (last pass: v5.10.109-cip5-384-g722204542e8a,=
 first fail: v4.4-st5-260-gb0fe64f485ff)
        1 lines

    2022-05-29T13:52:31.216109  / # =

    2022-05-29T13:52:31.225415  =

    2022-05-29T13:52:31.329786  / # #
    2022-05-29T13:52:31.337920  #
    2022-05-29T13:52:31.439822  / # export SHELL=3D/bin/sh
    2022-05-29T13:52:31.447874  export SHELL=3D/bin/sh
    2022-05-29T13:52:31.549481  / # . /lava-688601/environment
    2022-05-29T13:52:31.559177  . /lava-688601/environment
    2022-05-29T13:52:31.660851  / # /lava-688601/bin/lava-test-runner /lava=
-688601/0
    2022-05-29T13:52:31.668292  /lava-688601/bin/lava-test-runner /lava-688=
601/0 =

    ... (9 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
hp-x360-12b-n4000-octopus  | x86_64 | lab-collabora | gcc-10   | x86_64_def=
con...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62937aa31d3b5a920ba39beb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-hp-x360-12b-n4000-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-hp-x360-12b-n4000-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62937aa31d3b5a920ba39=
bec
        new failure (last pass: v5.10.112-cip6) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
juno-uboot                 | arm64  | lab-broonie   | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/62937b52a9fd97e1ada39bcd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm64/defconfig/gcc-10/lab-broonie/baseline-ju=
no-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm64/defconfig/gcc-10/lab-broonie/baseline-ju=
no-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62937b52a9fd97e1ada39=
bce
        new failure (last pass: v5.10.112-cip6) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
odroid-xu3                 | arm    | lab-collabora | gcc-10   | exynos_def=
config             | 1          =


  Details:     https://kernelci.org/test/plan/id/6293793d3de8911ba7a39bf7

  Results:     4 PASS, 1 FAIL, 2 SKIP
  Full config: exynos_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm/exynos_defconfig/gcc-10/lab-collabora/base=
line-odroid-xu3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm/exynos_defconfig/gcc-10/lab-collabora/base=
line-odroid-xu3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.all-cpus-are-online: https://kernelci.org/test/case/id/=
6293793d3de8911ba7a39bfb
        new failure (last pass: v5.10.112-cip6)

    2022-05-29T13:46:31.372913  /lava-6497447/1/../bin/lava-test-case
    2022-05-29T13:46:31.389264  [   15.044356] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dall-cpus-are-online RESULT=3Dfail>   =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm-virt-gicv2        | arm    | lab-broonie   | gcc-10   | multi_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/629379d5ef01d07f1ca39bcd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm/multi_v7_defconfig/gcc-10/lab-broonie/base=
line-qemu_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm/multi_v7_defconfig/gcc-10/lab-broonie/base=
line-qemu_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/629379d5ef01d07f1ca39=
bce
        new failure (last pass: v5.10.112-cip6) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm-virt-gicv2-uefi   | arm    | lab-broonie   | gcc-10   | multi_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/62937ab09f04ed5000a39bd6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm/multi_v7_defconfig/gcc-10/lab-broonie/base=
line-qemu_arm-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm/multi_v7_defconfig/gcc-10/lab-broonie/base=
line-qemu_arm-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62937ab09f04ed5000a39=
bd7
        new failure (last pass: v5.10.112-cip6) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm-virt-gicv3        | arm    | lab-broonie   | gcc-10   | multi_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/629379d60c87d0b49ea39bd8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm/multi_v7_defconfig/gcc-10/lab-broonie/base=
line-qemu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm/multi_v7_defconfig/gcc-10/lab-broonie/base=
line-qemu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/629379d60c87d0b49ea39=
bd9
        new failure (last pass: v5.10.112-cip6) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm-virt-gicv3-uefi   | arm    | lab-broonie   | gcc-10   | multi_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/62937ab2cf2dfaea3ba39bdb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm/multi_v7_defconfig/gcc-10/lab-broonie/base=
line-qemu_arm-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm/multi_v7_defconfig/gcc-10/lab-broonie/base=
line-qemu_arm-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62937ab2cf2dfaea3ba39=
bdc
        new failure (last pass: v5.10.112-cip6) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-broonie   | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6293794a7fed14ec6ba39bd3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm64/defconfig+arm64-chromebook/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm64/defconfig+arm64-chromebook/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6293794a7fed14ec6ba39=
bd4
        failing since 19 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-broonie   | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/62937c2e07d296f427a39be8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm64/defconfig/gcc-10/lab-broonie/baseline-qe=
mu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm64/defconfig/gcc-10/lab-broonie/baseline-qe=
mu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62937c2e07d296f427a39=
be9
        failing since 19 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie   | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/629379487fed14ec6ba39bcd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm64/defconfig+arm64-chromebook/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm64/defconfig+arm64-chromebook/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/629379487fed14ec6ba39=
bce
        failing since 19 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie   | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/62937c2d7eb080f440a39bd4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm64/defconfig/gcc-10/lab-broonie/baseline-qe=
mu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm64/defconfig/gcc-10/lab-broonie/baseline-qe=
mu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62937c2d7eb080f440a39=
bd5
        failing since 19 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-broonie   | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6293794b2b9c305145a39bf3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm64/defconfig+arm64-chromebook/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm64/defconfig+arm64-chromebook/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6293794b2b9c305145a39=
bf4
        failing since 19 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-broonie   | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/62937ca59cd0edcc5fa39bcd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm64/defconfig/gcc-10/lab-broonie/baseline-qe=
mu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm64/defconfig/gcc-10/lab-broonie/baseline-qe=
mu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62937ca59cd0edcc5fa39=
bce
        failing since 19 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie   | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6293794c7fed14ec6ba39bd9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm64/defconfig+arm64-chromebook/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm64/defconfig+arm64-chromebook/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6293794c7fed14ec6ba39=
bda
        failing since 19 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie   | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/62937c6932bd5dd26ca39bcd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm64/defconfig/gcc-10/lab-broonie/baseline-qe=
mu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm64/defconfig/gcc-10/lab-broonie/baseline-qe=
mu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62937c6932bd5dd26ca39=
bce
        failing since 19 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_x86_64-uefi-mixed     | x86_64 | lab-broonie   | gcc-10   | x86_64_def=
config             | 1          =


  Details:     https://kernelci.org/test/plan/id/62937b3c9b83b98d4da39bd3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/x86_64/x86_64_defconfig/gcc-10/lab-broonie/bas=
eline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/x86_64/x86_64_defconfig/gcc-10/lab-broonie/bas=
eline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62937b3c9b83b98d4da39=
bd4
        new failure (last pass: v5.10.112-cip6) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_x86_64-uefi-mixed     | x86_64 | lab-broonie   | gcc-10   | x86_64_def=
con...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62937c1907d296f427a39bdc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-broonie/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-broonie/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62937c1907d296f427a39=
bdd
        new failure (last pass: v5.10.112-cip6) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
rk3288-veyron-jaq          | arm    | lab-collabora | gcc-10   | multi_v7_d=
efconfig           | 28         =


  Details:     https://kernelci.org/test/plan/id/62937a868a62931b29a39be8

  Results:     39 PASS, 30 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm/multi_v7_defconfig/gcc-10/lab-collabora/ba=
seline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm/multi_v7_defconfig/gcc-10/lab-collabora/ba=
seline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-vopl-probed: https://kernelci.org/test/case/id=
/62937a868a62931b29a39bed
        new failure (last pass: v5.10.112-cip6)

    2022-05-29T13:51:44.565157  /lava-6497464/1/../bin/lava-test-case
    2022-05-29T13:51:44.586128  [   48.059940] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-vopl-probed RESULT=3Dfail>   =


  * baseline.bootrr.rockchip-vopb-probed: https://kernelci.org/test/case/id=
/62937a868a62931b29a39bee
        new failure (last pass: v5.10.112-cip6)

    2022-05-29T13:51:43.502311  /lava-6497464/1/../bin/lava-test-case
    2022-05-29T13:51:43.526082  [   47.000119] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-vopb-probed RESULT=3Dfail>   =


  * baseline.bootrr.rockchip-usb-phy-grf-probed: https://kernelci.org/test/=
case/id/62937a868a62931b29a39bf0
        new failure (last pass: v5.10.112-cip6)

    2022-05-29T13:51:42.392288  /lava-6497464/1/../bin/lava-test-case
    2022-05-29T13:51:42.417311  [   45.890720] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-usb-phy-grf-probed RESULT=3Dfail>   =


  * baseline.bootrr.rockchip-pwm0-probed: https://kernelci.org/test/case/id=
/62937a868a62931b29a39bf8
        new failure (last pass: v5.10.112-cip6)

    2022-05-29T13:51:41.196852  /lava-6497464/1/../bin/lava-test-case
    2022-05-29T13:51:41.222564  [   44.696057] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-pwm0-probed RESULT=3Dfail>   =


  * baseline.bootrr.rockchip-pm-domain-pmu-probed: https://kernelci.org/tes=
t/case/id/62937a868a62931b29a39bfa
        new failure (last pass: v5.10.112-cip6)

    2022-05-29T13:51:40.109399  /lava-6497464/1/../bin/lava-test-case
    2022-05-29T13:51:40.134262  [   43.607049] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-pm-domain-pmu-probed RESULT=3Dfail>   =


  * baseline.bootrr.rockchip-pm-domain-driver-present: https://kernelci.org=
/test/case/id/62937a868a62931b29a39bfb
        new failure (last pass: v5.10.112-cip6)

    2022-05-29T13:51:39.067465  /lava-6497464/1/../bin/lava-test-case
    2022-05-29T13:51:39.087950  [   42.559932] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-pm-domain-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.dwhdmi-rockchip-probed: https://kernelci.org/test/case/=
id/62937a868a62931b29a39c01
        new failure (last pass: v5.10.112-cip6)

    2022-05-29T13:51:20.712295  /lava-6497464/1/../bin/lava-test-case
    2022-05-29T13:51:20.737197  [   24.209826] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dfail>   =


  * baseline.bootrr.dw_wdt-probed: https://kernelci.org/test/case/id/62937a=
868a62931b29a39c06
        new failure (last pass: v5.10.112-cip6)

    2022-05-29T13:51:19.526558  /lava-6497464/1/../bin/lava-test-case
    2022-05-29T13:51:19.550340  [   23.023764] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddw_wdt-probed RESULT=3Dfail>   =


  * baseline.bootrr.dw_wdt-driver-present: https://kernelci.org/test/case/i=
d/62937a868a62931b29a39c07
        new failure (last pass: v5.10.112-cip6)

    2022-05-29T13:51:18.466323  /lava-6497464/1/../bin/lava-test-case
    2022-05-29T13:51:18.491300  [   21.964595] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddw_wdt-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cros-ec-keyb-probed: https://kernelci.org/test/case/id/=
62937a868a62931b29a39c0c
        new failure (last pass: v5.10.112-cip6)

    2022-05-29T13:51:17.337470  /lava-6497464/1/../bin/lava-test-case
    2022-05-29T13:51:17.360203  [   20.833988] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcros-ec-keyb-probed RESULT=3Dfail>   =


  * baseline.bootrr.cros-ec-i2c-tunnel-probed: https://kernelci.org/test/ca=
se/id/62937a868a62931b29a39c0e
        new failure (last pass: v5.10.112-cip6)

    2022-05-29T13:51:16.241430  /lava-6497464/1/../bin/lava-test-case
    2022-05-29T13:51:16.265185  [   19.738197] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcros-ec-i2c-tunnel-probed RESULT=3Dfail>   =


  * baseline.bootrr.rockchip-iodomain-driver-present: https://kernelci.org/=
test/case/id/62937a868a62931b29a39c0f
        new failure (last pass: v5.10.112-cip6)

    2022-05-29T13:51:36.973447  /lava-6497464/1/../bin/lava-test-case
    2022-05-29T13:51:36.994053  [   40.464908] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-iodomain-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.rockchip-i2s-probed: https://kernelci.org/test/case/id/=
62937a868a62931b29a39c10
        new failure (last pass: v5.10.112-cip6)

    2022-05-29T13:51:35.914275  /lava-6497464/1/../bin/lava-test-case
    2022-05-29T13:51:35.934898  [   39.409777] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-i2s-probed RESULT=3Dfail>   =


  * baseline.bootrr.rockcip-i2s-driver-present: https://kernelci.org/test/c=
ase/id/62937a868a62931b29a39c11
        new failure (last pass: v5.10.112-cip6)

    2022-05-29T13:51:34.855566  /lava-6497464/1/../bin/lava-test-case
    2022-05-29T13:51:34.881435  [   38.350612] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockcip-i2s-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.rockchip-dp-phy-grf-probed: https://kernelci.org/test/c=
ase/id/62937a868a62931b29a39c12
        new failure (last pass: v5.10.112-cip6)

    2022-05-29T13:51:33.791651  /lava-6497464/1/../bin/lava-test-case
    2022-05-29T13:51:33.817274  [   37.290811] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-dp-phy-grf-probed RESULT=3Dfail>   =


  * baseline.bootrr.rockchip-dp-phy-driver-present: https://kernelci.org/te=
st/case/id/62937a868a62931b29a39c13
        new failure (last pass: v5.10.112-cip6)

    2022-05-29T13:51:32.732778  /lava-6497464/1/../bin/lava-test-case
    2022-05-29T13:51:32.758609  [   36.231152] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-dp-phy-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.rockchip-dp-edp-probed: https://kernelci.org/test/case/=
id/62937a868a62931b29a39c14
        new failure (last pass: v5.10.112-cip6)

    2022-05-29T13:51:31.691558  /lava-6497464/1/../bin/lava-test-case
    2022-05-29T13:51:31.706589  [   35.180045] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-dp-edp-probed RESULT=3Dfail>   =


  * baseline.bootrr.rockchip-dp-driver-present: https://kernelci.org/test/c=
ase/id/62937a868a62931b29a39c15
        new failure (last pass: v5.10.112-cip6)

    2022-05-29T13:51:30.629653  /lava-6497464/1/../bin/lava-test-case
    2022-05-29T13:51:30.652624  [   34.125694] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-dp-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.rk_iommu-vpu_mmu-probed: https://kernelci.org/test/case=
/id/62937a868a62931b29a39c16
        new failure (last pass: v5.10.112-cip6)

    2022-05-29T13:51:29.566856  /lava-6497464/1/../bin/lava-test-case
    2022-05-29T13:51:29.591713  [   33.065310] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk_iommu-vpu_mmu-probed RESULT=3Dfail>   =


  * baseline.bootrr.rk_iommu-vopl_mmu-probed: https://kernelci.org/test/cas=
e/id/62937a868a62931b29a39c17
        new failure (last pass: v5.10.112-cip6)

    2022-05-29T13:51:28.510771  /lava-6497464/1/../bin/lava-test-case
    2022-05-29T13:51:28.531726  [   32.004846] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk_iommu-vopl_mmu-probed RESULT=3Dfail>   =


  * baseline.bootrr.rk_iommu-vopb_mmu-probed: https://kernelci.org/test/cas=
e/id/62937a868a62931b29a39c18
        new failure (last pass: v5.10.112-cip6)

    2022-05-29T13:51:27.445865  /lava-6497464/1/../bin/lava-test-case
    2022-05-29T13:51:27.471785  [   30.945265] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk_iommu-vopb_mmu-probed RESULT=3Dfail>   =


  * baseline.bootrr.rk3288-crypto-probed: https://kernelci.org/test/case/id=
/62937a868a62931b29a39c20
        new failure (last pass: v5.10.112-cip6)

    2022-05-29T13:51:26.197187  /lava-6497464/1/../bin/lava-test-case
    2022-05-29T13:51:26.223087  [   29.696445] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk3288-crypto-probed RESULT=3Dfail>   =


  * baseline.bootrr.rk3288-crypto-driver-present: https://kernelci.org/test=
/case/id/62937a868a62931b29a39c21
        new failure (last pass: v5.10.112-cip6)

    2022-05-29T13:51:25.137338  /lava-6497464/1/../bin/lava-test-case
    2022-05-29T13:51:25.163105  [   28.635754] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk3288-crypto-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.ramoops-probed: https://kernelci.org/test/case/id/62937=
a868a62931b29a39c22
        new failure (last pass: v5.10.112-cip6)

    2022-05-29T13:51:24.082773  /lava-6497464/1/../bin/lava-test-case
    2022-05-29T13:51:24.108204  [   27.579556] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dramoops-probed RESULT=3Dfail>   =


  * baseline.bootrr.ramoops-driver-present: https://kernelci.org/test/case/=
id/62937a868a62931b29a39c23
        new failure (last pass: v5.10.112-cip6)

    2022-05-29T13:51:23.022247  /lava-6497464/1/../bin/lava-test-case
    2022-05-29T13:51:23.047990  [   26.520904] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dramoops-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cros-ec-i2c-tunnel-driver-present: https://kernelci.org=
/test/case/id/62937a868a62931b29a39c28
        new failure (last pass: v5.10.112-cip6)

    2022-05-29T13:51:15.183287  /lava-6497464/1/../bin/lava-test-case
    2022-05-29T13:51:15.209131  [   18.677801] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcros-ec-i2c-tunnel-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cros-ec-dev-probed: https://kernelci.org/test/case/id/6=
2937a868a62931b29a39c29
        new failure (last pass: v5.10.112-cip6)

    2022-05-29T13:51:13.196216  [   16.670010] usb 3-1.1: new high-speed US=
B device number 3 using dwc2
    2022-05-29T13:51:13.301252  [   16.778608] smsc95xx v1.0.4
    2022-05-29T13:51:13.363313  [   16.831523] smsc95xx 3-1.1:1.0 eth0: reg=
ister 'smsc95xx' at usb-ff580000.usb-1.1, smsc95xx USB 2.0 Ethernet, 94:eb:=
2c:00:05:24
    2022-05-29T13:51:13.381210  [   16.851158] dwmmc_rockchip ff0d0000.dwmm=
c: IDMAC supports 32-bit address mode.
    2022-05-29T13:51:13.386397  [   16.859139] dwmmc_rockchip ff0d0000.dwmm=
c: Using internal DMA controller.
    2022-05-29T13:51:13.391528  [   16.866093] dwmmc_rockchip ff0d0000.dwmm=
c: Version ID is 270a
    2022-05-29T13:51:13.401271  [   16.871980] dwmmc_rockchip ff0d0000.dwmm=
c: DW MMC controller at irq 30,32 bit host data width,256 deep fifo
    2022-05-29T13:51:13.882373  [   17.357702] random: nonblocking pool is =
initialized
    2022-05-29T13:51:14.124004  /lava-6497464/1/../bin/lava-test-case
    2022-05-29T13:51:14.144558  [   17.619341] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcros-ec-dev-probed RESULT=3Dfail>   =


  * baseline.bootrr.cros-ec-dev-driver-present: https://kernelci.org/test/c=
ase/id/62937a868a62931b29a39c2a
        new failure (last pass: v5.10.112-cip6)

    2022-05-29T13:51:12.394346  [   15.860308] dwc2 ff580000.usb: DWC OTG C=
ontroller
    2022-05-29T13:51:12.394681  [   15.865090] dwc2 ff580000.usb: new USB b=
us registered, assigned bus number 3
    2022-05-29T13:51:12.399442  [   15.872200] dwc2 ff580000.usb: irq 43, i=
o mem 0x00000000
    2022-05-29T13:51:12.404764  [   15.878372] hub 3-0:1.0: USB hub found
    2022-05-29T13:51:12.404998  [   15.882199] hub 3-0:1.0: 1 port detected
    2022-05-29T13:51:12.415125  [   15.889649] dwmmc_rockchip ff0d0000.dwmm=
c: IDMAC supports 32-bit address mode.
    2022-05-29T13:51:12.432312  [   15.897079] dwmmc_rockchip ff0d0000.dwmm=
c: Using internal DMA controller.
    2022-05-29T13:51:12.432548  [   15.903902] dwmmc_rockchip ff0d0000.dwmm=
c: Version ID is 270a
    2022-05-29T13:51:12.437404  [   15.909693] dwmmc_rockchip ff0d0000.dwmm=
c: DW MMC controller at irq 30,32 bit host data width,256 deep fifo
    2022-05-29T13:51:12.699605  [   16.174977] usb 3-1: new high-speed USB =
device number 2 using dwc2 =

    ... (8 line(s) more)  =

 =20

