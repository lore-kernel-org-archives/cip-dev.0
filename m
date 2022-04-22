X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web09.8876.1650636139138739979
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 22 Apr 2022 07:02:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=fqpUk67O;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id q3so11073415plg.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 22 Apr 2022 07:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=FaUfWMjOpK8w56iGUY2isMbXDeclZflPDGG7atWGw84=;
        b=fqpUk67OBBR1ViEuVkw5GgFcI9B/NiPaWAFAzP9n8Xuh9LDrGgKYoVhrQkr99SU2aQ
         hnbTWS1tbwRAgQ6GERssG5YTFYI6JPsUv740a0W9d38XFD//iE7v2x1I9rcKwKJxbk9m
         7nVTGhsRt4bdAIaFG18NFozB0uLrJXyp91HP3vao8zKPQyKTDzx8woEYl+VLhh8HmUcG
         T+jzfVlXf17ARrbAKUZwgbGLXiLhzUczZRa8xTYjCt5yx7epou51FbMbsQTjuZVc2CmV
         smjMUtIoqEli2++QMuWlM9flrtmgg/GQlscKpZOWWhQNQa4hhB67dYQEkPUL8V41aP65
         X1GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=FaUfWMjOpK8w56iGUY2isMbXDeclZflPDGG7atWGw84=;
        b=Htz3Zt70QGilxrb9dFQ/kiFrS+wxzjL04CU/0bx3/EMMXUoDUjvMcJgc0xBm9wvFlv
         ybOfjdVpSVqhYMMw1/4M3mEFuvBMWeWwMtwE8N2e3ZMPPRZ99O+V5oCcJ0WWFu5b8Zts
         2VAy59xOY9IQaiSP1VS3/zCSEBceoOBqtV8vkyaf+RYzDqfWHO0oPAmyRVitzW+YGBWS
         E0JB3mevP1RUcM3t4QJbZ6C3EoLQ3icjWJlQDH/eqIchBzGbc87DfqOsrneX35+wI+Ih
         w0lXUFRlQNEGpcrPgz3oeJ3wczXSIz2y+ihzqNhH5KjDLYJk0IaUhvBNiPdGpi0kTIRp
         opdA==
X-Gm-Message-State: AOAM5308tllSYL3apc1E49uqxhAjT0bx7elUGPzXh/57UOuj6Ds4K1bE
	oyxmP+x9OYNLt4YR2Xw32y6PtX7DD6/9H9mhO1E=
X-Google-Smtp-Source: ABdhPJyWaZ5sWnGCnxCjfz61VSGRigqi4CQ8LSmoE1qFwgasZ6Ei2GhxPgonNKD9ki5ZqIsv0fD2NQ==
X-Received: by 2002:a17:90a:dd45:b0:1bc:9466:9b64 with SMTP id u5-20020a17090add4500b001bc94669b64mr16396518pjv.23.1650636138007;
        Fri, 22 Apr 2022 07:02:18 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p8-20020aa78608000000b005082c3cbfd2sm2666224pfn.218.2022.04.22.07.01.29
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 07:01:40 -0700 (PDT)
Message-ID: <6262b544.1c69fb81.fbb14.656f@mx.google.com>
Date: Fri, 22 Apr 2022 07:01:40 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Kernel: v4.19.233-516-ge5e741fbfc87
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
Subject: cip-gitlab/ci/pavel/linux-test baseline: 36 runs, 2 regressions (v4.19.233-516-ge5e741fbfc87) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test baseline: 36 runs, 2 regressions (v4.19.233-=
516-ge5e741fbfc87)

Regressions Summary
-------------------

platform         | arch | lab     | compiler | defconfig           | regres=
sions
-----------------+------+---------+----------+---------------------+-------=
-----
beaglebone-black | arm  | lab-cip | gcc-10   | multi_v7_defconfig  | 1     =
     =

beaglebone-black | arm  | lab-cip | gcc-10   | omap2plus_defconfig | 1     =
     =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.233-516-ge5e741fbfc87/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.233-516-ge5e741fbfc87
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      e5e741fbfc87d414037c91102d2523f655726811 =



Test Regressions
---------------- =



platform         | arch | lab     | compiler | defconfig           | regres=
sions
-----------------+------+---------+----------+---------------------+-------=
-----
beaglebone-black | arm  | lab-cip | gcc-10   | multi_v7_defconfig  | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/6262a8b71a7ffc573eff947b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.233-516-ge5e741fbfc87/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline=
-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.233-516-ge5e741fbfc87/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline=
-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220411.0/armel/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/6262a8b71a7ffc57=
3eff947e
        failing since 10 days (last pass: v5.10.106-cip4-69-g05f5682c2c593,=
 first fail: v4.4-st5-2498-g49524d978f8eb)
        1 lines

    2022-04-22T13:07:48.840880  / # =

    2022-04-22T13:07:48.847177  =

    2022-04-22T13:07:48.950300  / # #
    2022-04-22T13:07:48.957534  #
    2022-04-22T13:07:49.059098  / # export SHELL=3D/bin/sh
    2022-04-22T13:07:49.065933  export SHELL=3D/bin/sh
    2022-04-22T13:07:49.167053  / # . /lava-667294/environment
    2022-04-22T13:07:49.173399  . /lava-667294/environment
    2022-04-22T13:07:49.274547  / # /lava-667294/bin/lava-test-runner /lava=
-667294/0
    2022-04-22T13:07:49.281185  /lava-667294/bin/lava-test-runner /lava-667=
294/0 =

    ... (9 line(s) more)  =

 =



platform         | arch | lab     | compiler | defconfig           | regres=
sions
-----------------+------+---------+----------+---------------------+-------=
-----
beaglebone-black | arm  | lab-cip | gcc-10   | omap2plus_defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/6262a6c309cdc3d56bff947e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.233-516-ge5e741fbfc87/arm/omap2plus_defconfig/gcc-10/lab-cip/baselin=
e-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.233-516-ge5e741fbfc87/arm/omap2plus_defconfig/gcc-10/lab-cip/baselin=
e-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220411.0/armel/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/6262a6c309cdc3d5=
6bff9481
        failing since 10 days (last pass: v5.10.106-cip4-69-g05f5682c2c593,=
 first fail: v4.4-st5-2498-g49524d978f8eb)
        1 lines

    2022-04-22T12:59:33.941890  / # =

    2022-04-22T12:59:33.953742  =

    2022-04-22T12:59:34.058260  / # #
    2022-04-22T12:59:34.066127  #
    2022-04-22T12:59:34.167966  / # export SHELL=3D/bin/sh
    2022-04-22T12:59:34.176292  export SHELL=3D/bin/sh
    2022-04-22T12:59:34.278019  / # . /lava-667285/environment
    2022-04-22T12:59:34.286627  . /lava-667285/environment
    2022-04-22T12:59:34.388355  / # /lava-667285/bin/lava-test-runner /lava=
-667285/0
    2022-04-22T12:59:34.396632  /lava-667285/bin/lava-test-runner /lava-667=
285/0 =

    ... (9 line(s) more)  =

 =20

