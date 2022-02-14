X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web10.3168.1644881981298836108
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 14 Feb 2022 15:39:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=ESjK/kPy;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.181, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f181.google.com with SMTP id l8so5735690pls.7
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 14 Feb 2022 15:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=B5GMa0grLOR3uUKdX4sFZNEW3qukNp321KjSWiRoZmc=;
        b=ESjK/kPy9JnaP4IkN1Y0doxAquiU311YZ5NuVAnRhVFsTgQ7ofwcAEgOHQ6rHPsf4d
         CitQtoUxSOjegNxx0RnPMxhUdug7GutNoJPvqHb4Vaf38XOJkTMdLoXdUIeS2QE40JLl
         as7CNsX1u5zdXt9u3n5QhFLc6g+uFa4CTJPNLFmj69MJEQc+UJnYH1RlloS/YB4ns2no
         WerCTOLfa8TVkMDrwhcMk3Yk2ihBmMM2bfE6/JpEHl0mdjFgP47PliQqeTFj4pyIetsc
         vqsxpnkK3QHiF7ccIWCWQsJcEN1GAu9/M0WWmDYo5pDjInJoqlBf57vtklNWhYl3a1R2
         ysvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=B5GMa0grLOR3uUKdX4sFZNEW3qukNp321KjSWiRoZmc=;
        b=Sx3Ig8DNYbvYknzy3MUjnojXb2J0kjVKLkbmPlt6s3xYvQl+m5Sb/raHYAocZtr32K
         txAgWIRcE6uEZuJhE4nIQ3WOQZMOH5q5jnYViBUyz2bxVvSS6o5f8tQNoGfwG1TLTmv4
         2O4AvYuZ9Nklnan7lIS5W1beEZHQkGbt93hT4nXi2mVUVvwpc6X9fxbAZMR4OtOsY/Ta
         uyZzGG/NhWYTgj2ZvUQgT3nvS7RecaOLWfWbNk2nCamSvfbWkSr36ZAOe/yzTvFLVnPW
         xxafJBhBYHLXjPnLj1YhEW5+ZICG/hODBfdZQ+uU6v9vpQdUo1zYXecdrvSQBMQKAnUG
         LN/g==
X-Gm-Message-State: AOAM533NegvlLubCusK8lplVL866hmBrIrmd3xMgxb8fjBYnhBVJWwLh
	WLuYSGvEV4hzmS1QRrGAPNdoLSCLz7GxbpgK
X-Google-Smtp-Source: ABdhPJwgOLe0pq6kQDota2sthDDVRptbzl2tmRKi2EeDf0wkW+foYz+Q8uuIG81kE96z0UZdnKjQdQ==
X-Received: by 2002:a17:903:228c:: with SMTP id b12mr1321842plh.36.1644881980419;
        Mon, 14 Feb 2022 15:39:40 -0800 (PST)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g4sm573250pgw.9.2022.02.14.15.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 15:39:40 -0800 (PST)
Message-ID: <620ae83c.1c69fb81.6c240.235e@mx.google.com>
Date: Mon, 14 Feb 2022 15:39:40 -0800 (PST)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Kernel: v4.4.302-cip68
Subject: cip/linux-4.4.y-cip baseline: 85 runs, 12 regressions (v4.4.302-cip68) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-4.4.y-cip baseline: 85 runs, 12 regressions (v4.4.302-cip68)

Regressions Summary
-------------------

platform              | arch  | lab          | compiler | defconfig        =
          | regressions
----------------------+-------+--------------+----------+------------------=
----------+------------
qemu_arm64-virt-gicv2 | arm64 | lab-baylibre | gcc-10   | defconfig        =
          | 1          =

qemu_arm64-virt-gicv2 | arm64 | lab-baylibre | gcc-10   | defconfig+arm64-c=
hromebook | 1          =

qemu_arm64-virt-gicv2 | arm64 | lab-broonie  | gcc-10   | defconfig        =
          | 1          =

qemu_arm64-virt-gicv2 | arm64 | lab-broonie  | gcc-10   | defconfig+arm64-c=
hromebook | 1          =

qemu_arm64-virt-gicv2 | arm64 | lab-cip      | gcc-10   | defconfig        =
          | 1          =

qemu_arm64-virt-gicv2 | arm64 | lab-cip      | gcc-10   | defconfig+arm64-c=
hromebook | 1          =

qemu_arm64-virt-gicv3 | arm64 | lab-baylibre | gcc-10   | defconfig        =
          | 1          =

qemu_arm64-virt-gicv3 | arm64 | lab-baylibre | gcc-10   | defconfig+arm64-c=
hromebook | 1          =

qemu_arm64-virt-gicv3 | arm64 | lab-broonie  | gcc-10   | defconfig        =
          | 1          =

qemu_arm64-virt-gicv3 | arm64 | lab-broonie  | gcc-10   | defconfig+arm64-c=
hromebook | 1          =

qemu_arm64-virt-gicv3 | arm64 | lab-cip      | gcc-10   | defconfig        =
          | 1          =

qemu_arm64-virt-gicv3 | arm64 | lab-cip      | gcc-10   | defconfig+arm64-c=
hromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip68/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip68
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      ea2b25643aed790866a050f9605bbe7b845b8f31 =



Test Regressions
---------------- =



platform              | arch  | lab          | compiler | defconfig        =
          | regressions
----------------------+-------+--------------+----------+------------------=
----------+------------
qemu_arm64-virt-gicv2 | arm64 | lab-baylibre | gcc-10   | defconfig        =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/620ad85734c4e9f7f0c6296e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip68/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip68/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220211.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/620ad85734c4e9f7f0c62=
96f
        new failure (last pass: v4.4.296-cip67) =

 =



platform              | arch  | lab          | compiler | defconfig        =
          | regressions
----------------------+-------+--------------+----------+------------------=
----------+------------
qemu_arm64-virt-gicv2 | arm64 | lab-baylibre | gcc-10   | defconfig+arm64-c=
hromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/620ad9830c62d912e8c6297a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip68/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_arm=
64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip68/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_arm=
64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220211.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/620ad9830c62d912e8c62=
97b
        new failure (last pass: v4.4.296-cip67) =

 =



platform              | arch  | lab          | compiler | defconfig        =
          | regressions
----------------------+-------+--------------+----------+------------------=
----------+------------
qemu_arm64-virt-gicv2 | arm64 | lab-broonie  | gcc-10   | defconfig        =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/620ad87e566f1b571cc6298b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip68/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip68/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220211.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/620ad87e566f1b571cc62=
98c
        new failure (last pass: v4.4.296-cip67) =

 =



platform              | arch  | lab          | compiler | defconfig        =
          | regressions
----------------------+-------+--------------+----------+------------------=
----------+------------
qemu_arm64-virt-gicv2 | arm64 | lab-broonie  | gcc-10   | defconfig+arm64-c=
hromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/620ad9a8d8c7b90f1ac629f8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip68/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm6=
4-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip68/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm6=
4-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220211.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/620ad9a8d8c7b90f1ac62=
9f9
        new failure (last pass: v4.4.296-cip67) =

 =



platform              | arch  | lab          | compiler | defconfig        =
          | regressions
----------------------+-------+--------------+----------+------------------=
----------+------------
qemu_arm64-virt-gicv2 | arm64 | lab-cip      | gcc-10   | defconfig        =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/620adab77f6a55e299c62999

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip68/arm64/defconfig/gcc-10/lab-cip/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip68/arm64/defconfig/gcc-10/lab-cip/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220211.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/620adab77f6a55e299c62=
99a
        new failure (last pass: v4.4.296-cip67) =

 =



platform              | arch  | lab          | compiler | defconfig        =
          | regressions
----------------------+-------+--------------+----------+------------------=
----------+------------
qemu_arm64-virt-gicv2 | arm64 | lab-cip      | gcc-10   | defconfig+arm64-c=
hromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/620add36c13481e179c62968

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip68/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-qemu_arm64-vi=
rt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip68/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-qemu_arm64-vi=
rt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220211.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/620add36c13481e179c62=
969
        new failure (last pass: v4.4.296-cip67) =

 =



platform              | arch  | lab          | compiler | defconfig        =
          | regressions
----------------------+-------+--------------+----------+------------------=
----------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-baylibre | gcc-10   | defconfig        =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/620ad86b34c4e9f7f0c62976

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip68/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip68/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220211.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/620ad86b34c4e9f7f0c62=
977
        new failure (last pass: v4.4.296-cip67) =

 =



platform              | arch  | lab          | compiler | defconfig        =
          | regressions
----------------------+-------+--------------+----------+------------------=
----------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-baylibre | gcc-10   | defconfig+arm64-c=
hromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/620ad9a937480b9c17c62a06

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip68/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_arm=
64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip68/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_arm=
64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220211.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/620ad9a937480b9c17c62=
a07
        new failure (last pass: v4.4.296-cip67) =

 =



platform              | arch  | lab          | compiler | defconfig        =
          | regressions
----------------------+-------+--------------+----------+------------------=
----------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie  | gcc-10   | defconfig        =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/620ad8ce47d8c7cb76c62968

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip68/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip68/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220211.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/620ad8ce47d8c7cb76c62=
969
        new failure (last pass: v4.4.296-cip67) =

 =



platform              | arch  | lab          | compiler | defconfig        =
          | regressions
----------------------+-------+--------------+----------+------------------=
----------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie  | gcc-10   | defconfig+arm64-c=
hromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/620ad9bd5cfaa7ebc5c6298a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip68/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm6=
4-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip68/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_arm6=
4-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220211.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/620ad9bd5cfaa7ebc5c62=
98b
        new failure (last pass: v4.4.296-cip67) =

 =



platform              | arch  | lab          | compiler | defconfig        =
          | regressions
----------------------+-------+--------------+----------+------------------=
----------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-cip      | gcc-10   | defconfig        =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/620adb2e07e46475d3c62989

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip68/arm64/defconfig/gcc-10/lab-cip/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip68/arm64/defconfig/gcc-10/lab-cip/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220211.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/620adb2e07e46475d3c62=
98a
        new failure (last pass: v4.4.296-cip67) =

 =



platform              | arch  | lab          | compiler | defconfig        =
          | regressions
----------------------+-------+--------------+----------+------------------=
----------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-cip      | gcc-10   | defconfig+arm64-c=
hromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/620addea1085aef023c6297c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip68/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-qemu_arm64-vi=
rt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip68/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-qemu_arm64-vi=
rt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220211.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/620addea1085aef023c62=
97d
        new failure (last pass: v4.4.296-cip67) =

 =20

