X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web09.705.1652901231431017927
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 18 May 2022 12:13:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=L4DlOYgg;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.174, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f174.google.com with SMTP id n18so2683880plg.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 18 May 2022 12:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=nizLbgkzCEQ42EnWKh6Hyabnh3oL2uTafMXccHt+O/Y=;
        b=L4DlOYggek84R4+lOOm8ObyIiSDN0vF8R5eFpQgItPrYb+7BDCMiFWCnpxFKw935yu
         MKHy/0/9qZBmqTR6zz+zAV1K6NDnplVMYepO2Fwfr/u12Fn3mM2y173IfgXpBNfv3ddB
         ifYxuwtrVncUAYQ/j1SofE2Wjewwjf1idMkdZL6AT7BZ543soMN1SN/sq+VPgl7kc7Du
         zZWEHF/Sudb8hwrI2iDV2H9T5uXnilTkrBnqw6GmTmm8bKVXtRK/lV6/vxA2QRrKr0V6
         HVfAFNb7HLSwNYVPJ90U6oSr1R8SoWQfwd4ZeNEr0ssRMgP2hwe9Q4gB0cZOFXBHO0XN
         C6bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=nizLbgkzCEQ42EnWKh6Hyabnh3oL2uTafMXccHt+O/Y=;
        b=Q5HXSlli3gHoRPybeyzPBWMksetMkRMiwMECBchzercQIQjEWlM+y9+AzQPtB5hSYU
         69zhjPkan6gOZCpHw7T8luByJGq3eXR7H7ihu6AIMcxxdWtwNLQIOZO61IGerbvBQ0DC
         GPChSdgFnkKZtUhttmicKIzH23a9V3oPUrmaMmWc9SahKcvyx/Md9De1elhmAdTn6vzE
         liVqUO+eB4ef8DUhMB3ueIYO1h1DL2RbyOfvfTyB/uJteq+XT/RpjOIpPmiFp4JnhFdg
         w/JgSMPHBH9qQMOA6lmwi69HXyfYZmJaoxG7HedEvSU0CQHdicdr/lU9JETHkcyBADSm
         NUyg==
X-Gm-Message-State: AOAM530YmvfvB/SarwWdsgc6yRq10gIfNEBVFSyD7GvDznSdHvA7lm9b
	GwGBNB+xwbl2tMz7ksofE8ld0fmp226614P7lYQ=
X-Google-Smtp-Source: ABdhPJxrAHUw0ck8zbrqFb/PE88qqnuB+O+6MxGIfYCzKC9aoJx8F0DVQ0vRqhJOjfTX4lVv+QOw4g==
X-Received: by 2002:a17:902:f652:b0:156:701b:9a2a with SMTP id m18-20020a170902f65200b00156701b9a2amr1078114plg.14.1652901230697;
        Wed, 18 May 2022 12:13:50 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z15-20020a1709027e8f00b0015f33717612sm2038411pla.128.2022.05.18.12.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 12:13:50 -0700 (PDT)
Message-ID: <6285456e.1c69fb81.8beee.4e8d@mx.google.com>
Date: Wed, 18 May 2022 12:13:50 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip69-296-g52de9431d314
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-4.4.y-cip baseline: 75 runs, 8 regressions (v4.4.302-cip69-296-g52de9431d314) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-4.4.y-cip baseline: 75 runs, 8 regressions (v4.4.302-cip69-296-g5=
2de9431d314)

Regressions Summary
-------------------

platform              | arch  | lab          | compiler | defconfig        =
          | regressions
----------------------+-------+--------------+----------+------------------=
----------+------------
qemu_arm64-virt-gicv2 | arm64 | lab-baylibre | gcc-10   | defconfig+arm64-c=
hromebook | 1          =

qemu_arm64-virt-gicv2 | arm64 | lab-baylibre | gcc-10   | defconfig        =
          | 1          =

qemu_arm64-virt-gicv2 | arm64 | lab-broonie  | gcc-10   | defconfig+arm64-c=
hromebook | 1          =

qemu_arm64-virt-gicv2 | arm64 | lab-broonie  | gcc-10   | defconfig        =
          | 1          =

qemu_arm64-virt-gicv3 | arm64 | lab-baylibre | gcc-10   | defconfig+arm64-c=
hromebook | 1          =

qemu_arm64-virt-gicv3 | arm64 | lab-baylibre | gcc-10   | defconfig        =
          | 1          =

qemu_arm64-virt-gicv3 | arm64 | lab-broonie  | gcc-10   | defconfig+arm64-c=
hromebook | 1          =

qemu_arm64-virt-gicv3 | arm64 | lab-broonie  | gcc-10   | defconfig        =
          | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip69-296-g52de9431d314/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip69-296-g52de9431d314
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      52de9431d314a28c4aa66d8f81144c9958c11168 =



Test Regressions
---------------- =



platform              | arch  | lab          | compiler | defconfig        =
          | regressions
----------------------+-------+--------------+----------+------------------=
----------+------------
qemu_arm64-virt-gicv2 | arm64 | lab-baylibre | gcc-10   | defconfig+arm64-c=
hromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62853c3d805cf1fe3da39c04

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip69-296-g52de9431d314/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre=
/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip69-296-g52de9431d314/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre=
/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62853c3d805cf1fe3da39=
c05
        new failure (last pass: v4.4.302-cip69) =

 =



platform              | arch  | lab          | compiler | defconfig        =
          | regressions
----------------------+-------+--------------+----------+------------------=
----------+------------
qemu_arm64-virt-gicv2 | arm64 | lab-baylibre | gcc-10   | defconfig        =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/62853eb66497df3deca39be0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip69-296-g52de9431d314/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_ar=
m64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip69-296-g52de9431d314/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_ar=
m64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62853eb66497df3deca39=
be1
        new failure (last pass: v4.4.302-cip69) =

 =



platform              | arch  | lab          | compiler | defconfig        =
          | regressions
----------------------+-------+--------------+----------+------------------=
----------+------------
qemu_arm64-virt-gicv2 | arm64 | lab-broonie  | gcc-10   | defconfig+arm64-c=
hromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62853ccf842964f72da39bd4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip69-296-g52de9431d314/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/=
baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip69-296-g52de9431d314/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/=
baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62853ccf842964f72da39=
bd5
        new failure (last pass: v4.4.302-cip69) =

 =



platform              | arch  | lab          | compiler | defconfig        =
          | regressions
----------------------+-------+--------------+----------+------------------=
----------+------------
qemu_arm64-virt-gicv2 | arm64 | lab-broonie  | gcc-10   | defconfig        =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/62853eeb908a673a02a39bf0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip69-296-g52de9431d314/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm=
64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip69-296-g52de9431d314/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm=
64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62853eeb908a673a02a39=
bf1
        new failure (last pass: v4.4.302-cip69) =

 =



platform              | arch  | lab          | compiler | defconfig        =
          | regressions
----------------------+-------+--------------+----------+------------------=
----------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-baylibre | gcc-10   | defconfig+arm64-c=
hromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62853c38876f3d499ca39bfb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip69-296-g52de9431d314/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre=
/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip69-296-g52de9431d314/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre=
/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62853c38876f3d499ca39=
bfc
        new failure (last pass: v4.4.302-cip69) =

 =



platform              | arch  | lab          | compiler | defconfig        =
          | regressions
----------------------+-------+--------------+----------+------------------=
----------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-baylibre | gcc-10   | defconfig        =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/62853eba6497df3deca39be6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip69-296-g52de9431d314/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_ar=
m64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip69-296-g52de9431d314/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_ar=
m64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62853eba6497df3deca39=
be7
        new failure (last pass: v4.4.302-cip69) =

 =



platform              | arch  | lab          | compiler | defconfig        =
          | regressions
----------------------+-------+--------------+----------+------------------=
----------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie  | gcc-10   | defconfig+arm64-c=
hromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62853c42d71282b190a39bd2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip69-296-g52de9431d314/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/=
baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip69-296-g52de9431d314/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/=
baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62853c42d71282b190a39=
bd3
        new failure (last pass: v4.4.302-cip69) =

 =



platform              | arch  | lab          | compiler | defconfig        =
          | regressions
----------------------+-------+--------------+----------+------------------=
----------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie  | gcc-10   | defconfig        =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/62853f3be73f0b8d95a39bec

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip69-296-g52de9431d314/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm=
64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip69-296-g52de9431d314/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm=
64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220513.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62853f3be73f0b8d95a39=
bed
        new failure (last pass: v4.4.302-cip69) =

 =20

