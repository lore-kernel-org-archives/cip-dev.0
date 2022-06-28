Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF143C43334
	for <webhook@archiver.kernel.org>; Tue, 28 Jun 2022 04:34:52 +0000 (UTC)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by mx.groups.io with SMTP id smtpd.web10.51538.1656390888612088270
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 27 Jun 2022 21:34:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=hV72Kkla;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.170,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f170.google.com with SMTP id e63so11040527pgc.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 27 Jun 2022 21:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=w0UQS/hidf6Wij6fko02QNyxYUxRyuwerBNgcqGZbAk=;
        b=hV72KklawgRPn9c4mUAp/ALjE5LReIeCTdcJ0q6oYhKG8FdY7tCslGqPo1Qqd/XvUq
         vqt3B7663cpivG7dLw9xId780Ea3lnHAIRoXB4Q0YNt0ppdSCKiT/xLchxgPCvKmdrTL
         YHCvVPkw8lbL63BmQot7cBrDp+ug/f2FIolOPBYNkFCh0KevaDpet4nW5XLpYgbNXpVe
         RUMqxeJsO4VmQrAUG8gxj0P5KpcI1XlxMP6FiJdTQXA38koYxn8YcX2X7JjxBo88PZBH
         nJ9kWqEDl1gb3uAmuxBf2uylrhWwILxyU5YQ7tnKIZe4xOmfGXft0AQvfRCRnASpnT3h
         7Xmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=w0UQS/hidf6Wij6fko02QNyxYUxRyuwerBNgcqGZbAk=;
        b=GzxNYumIqS9RODpMpip+gFQTJNImUGeO7R8i65EvItL8uHXpEM0MeySKTnu82oWZnV
         5tBnuJqt6PT4iq94ugbOoJxjJsrTKjVge37yl77ACwuuOzKoD+kbl90TxPNG6nO0r+yq
         RUm6YyEoQt4xY6vRXT0zIiIZagzgSPrJpctaqCbsIX/jxyX3sZFrZ1PhoPzAOFKGi6nZ
         s2uvvEMBPApUPXq/f5vXpA+VWjIAnIvyduF+W2zl51Es6jHFBZCOWqzTHOWaxUxOhd03
         9XStyLfOz1i1jorXgu/RjLsfUKAmFoUW2Ofnj6umk6+x3UZKv+ucf1bY7+4wAvUNhxLi
         ejzA==
X-Gm-Message-State: AJIora/Ykb/KEMoMOebAf/9P5b+wBV2l4SpOFktz5MT0204ILYnCQ8ta
	YxMYlm6J/632gjygDDrAvtXsQmw4EKUspeYB
X-Google-Smtp-Source: 
 AGRyM1vFEHT5IiWUq93pVgyEjOyHKkKx6fMPpox9Es6Q0HQcEMYfR8XqlzlVtiGGMTjCRsUM56NcLw==
X-Received: by 2002:a63:b514:0:b0:40c:9fc8:babe with SMTP id
 y20-20020a63b514000000b0040c9fc8babemr16382239pge.197.1656390887632;
        Mon, 27 Jun 2022 21:34:47 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 v19-20020aa78093000000b0051b693baadcsm8170618pff.205.2022.06.27.21.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 21:34:46 -0700 (PDT)
Message-ID: <62ba84e6.1c69fb81.62b34.b42c@mx.google.com>
Date: Mon, 27 Jun 2022 21:34:46 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.125-cip10
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip baseline: 135 runs,
 10 regressions (v5.10.125-cip10)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Jun 2022 04:34:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8620

cip/linux-5.10.y-cip baseline: 135 runs, 10 regressions (v5.10.125-cip10)

Regressions Summary
-------------------

platform                   | arch  | lab          | compiler | defconfig   =
       | regressions
---------------------------+-------+--------------+----------+-------------=
-------+------------
imx6q-var-dt6customboard   | arm   | lab-baylibre | gcc-10   | multi_v7_def=
config | 2          =

qemu_arm64-virt-gicv2      | arm64 | lab-baylibre | gcc-10   | defconfig   =
       | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-broonie  | gcc-10   | defconfig   =
       | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-baylibre | gcc-10   | defconfig   =
       | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie  | gcc-10   | defconfig   =
       | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-baylibre | gcc-10   | defconfig   =
       | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-broonie  | gcc-10   | defconfig   =
       | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-baylibre | gcc-10   | defconfig   =
       | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie  | gcc-10   | defconfig   =
       | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.125-cip10/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.125-cip10
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      93e5c28cd0bdd8a2d89059fe7218ce98dd7c81ce =



Test Regressions
---------------- =



platform                   | arch  | lab          | compiler | defconfig   =
       | regressions
---------------------------+-------+--------------+----------+-------------=
-------+------------
imx6q-var-dt6customboard   | arm   | lab-baylibre | gcc-10   | multi_v7_def=
config | 2          =


  Details:     https://kernelci.org/test/plan/id/62ba76abfdf1ba6394a39c11

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.125=
-cip10/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-imx6q-var-dt6cus=
tomboard.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.125=
-cip10/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-imx6q-var-dt6cus=
tomboard.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/armel/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/62ba76abfdf1ba6=
394a39c14
        new failure (last pass: v5.10.121-cip9)
        26 lines

    2022-06-28T03:33:41.576639  kern  :emerg : Internal error: : 1 [#1] SMP=
 ARM
    2022-06-28T03:33:41.616514  kern  :emerg : Process kworker/1:3 (pid: 75=
, stack limit =3D 0x(ptrval))
    2022-06-28T03:33:41.616769  kern  :emerg : Stack: (0xc329beb0 to<8>[   =
43.882113] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Demerg RESULT=3Dfail UNITS=
=3Dlines MEASUREMENT=3D26>
    2022-06-28T03:33:41.616997   0xc329c000)
    2022-06-28T03:33:41.617210  kern  :emerg : bea0<8>[   43.893439] <LAVA_=
SIGNAL_ENDRUN 0_dmesg 2133504_1.5.2.4.1>   =


  * baseline.dmesg.alert: https://kernelci.org/test/case/id/62ba76abfdf1ba6=
394a39c15
        new failure (last pass: v5.10.121-cip9)
        4 lines

    2022-06-28T03:33:41.528636  kern  :alert : 8<--- cut here ---
    2022-06-28T03:33:41.557509  kern  :alert : Unhandled fault: alignment e=
xception (0x001) at 0xcec60217
    2022-06-28T03:33:41.557762  kern  :alert : pgd =3D (ptrval)
    2022-06-28T03:33:41.560728  kern  :alert : [<8>[   43.834627] <LAVA_SIG=
NAL_TESTCASE TEST_CASE_ID=3Dalert RESULT=3Dfail UNITS=3Dlines MEASUREMENT=
=3D4>
    2022-06-28T03:33:41.560984  cec60217] *pgd=3D1ec1141e(bad)   =

 =



platform                   | arch  | lab          | compiler | defconfig   =
       | regressions
---------------------------+-------+--------------+----------+-------------=
-------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-baylibre | gcc-10   | defconfig   =
       | 1          =


  Details:     https://kernelci.org/test/plan/id/62ba7abb0851728ec7a39be2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.125=
-cip10/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.125=
-cip10/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62ba7abb0851728ec7a39=
be3
        new failure (last pass: v5.10.112-cip6) =

 =



platform                   | arch  | lab          | compiler | defconfig   =
       | regressions
---------------------------+-------+--------------+----------+-------------=
-------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-broonie  | gcc-10   | defconfig   =
       | 1          =


  Details:     https://kernelci.org/test/plan/id/62ba785096200bf8eea39c41

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.125=
-cip10/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.125=
-cip10/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62ba785096200bf8eea39=
c42
        new failure (last pass: v5.10.112-cip6) =

 =



platform                   | arch  | lab          | compiler | defconfig   =
       | regressions
---------------------------+-------+--------------+----------+-------------=
-------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-baylibre | gcc-10   | defconfig   =
       | 1          =


  Details:     https://kernelci.org/test/plan/id/62ba7a6b11c81e402aa39bf8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.125=
-cip10/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2-u=
efi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.125=
-cip10/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2-u=
efi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62ba7a6b11c81e402aa39=
bf9
        new failure (last pass: v5.10.112-cip6) =

 =



platform                   | arch  | lab          | compiler | defconfig   =
       | regressions
---------------------------+-------+--------------+----------+-------------=
-------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie  | gcc-10   | defconfig   =
       | 1          =


  Details:     https://kernelci.org/test/plan/id/62ba784d96200bf8eea39c3b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.125=
-cip10/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-ue=
fi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.125=
-cip10/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-ue=
fi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62ba784d96200bf8eea39=
c3c
        new failure (last pass: v5.10.112-cip6) =

 =



platform                   | arch  | lab          | compiler | defconfig   =
       | regressions
---------------------------+-------+--------------+----------+-------------=
-------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-baylibre | gcc-10   | defconfig   =
       | 1          =


  Details:     https://kernelci.org/test/plan/id/62ba7acfd9d32f60e3a39c42

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.125=
-cip10/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.125=
-cip10/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62ba7acfd9d32f60e3a39=
c43
        new failure (last pass: v5.10.112-cip6) =

 =



platform                   | arch  | lab          | compiler | defconfig   =
       | regressions
---------------------------+-------+--------------+----------+-------------=
-------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-broonie  | gcc-10   | defconfig   =
       | 1          =


  Details:     https://kernelci.org/test/plan/id/62ba7861fbe4e404b6a39bf6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.125=
-cip10/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.125=
-cip10/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62ba7861fbe4e404b6a39=
bf7
        new failure (last pass: v5.10.112-cip6) =

 =



platform                   | arch  | lab          | compiler | defconfig   =
       | regressions
---------------------------+-------+--------------+----------+-------------=
-------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-baylibre | gcc-10   | defconfig   =
       | 1          =


  Details:     https://kernelci.org/test/plan/id/62ba7aa70851728ec7a39bcd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.125=
-cip10/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3-u=
efi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.125=
-cip10/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3-u=
efi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62ba7aa70851728ec7a39=
bce
        new failure (last pass: v5.10.112-cip6) =

 =



platform                   | arch  | lab          | compiler | defconfig   =
       | regressions
---------------------------+-------+--------------+----------+-------------=
-------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie  | gcc-10   | defconfig   =
       | 1          =


  Details:     https://kernelci.org/test/plan/id/62ba784f96200bf8eea39c3e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.125=
-cip10/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-ue=
fi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.125=
-cip10/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-ue=
fi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62ba784f96200bf8eea39=
c3f
        new failure (last pass: v5.10.112-cip6) =

 =20

