Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06772C433EF
	for <webhook@archiver.kernel.org>; Fri,  8 Jul 2022 16:16:20 +0000 (UTC)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by mx.groups.io with SMTP id smtpd.web10.1009.1657296969794413571
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 08 Jul 2022 09:16:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=1p+6ALoM;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.172,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f172.google.com with SMTP id y9so9681412pff.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 08 Jul 2022 09:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=FMRRlhrne21ssk8Ug5+3aeKjPpazi9r4MMsLrSx9HOk=;
        b=1p+6ALoMGCxtRq5FHIFIcWGOREcxauyJa9os6OxUwliwlhpCAKMvGZJ/9lpp1NW+SP
         K30IrSphVYWODGzXWiqk2oOwkewE+ZRHdZ8XOeUOw9lG5NwAkhmWw2aPLNYEg6rkIC77
         f/knUfPmwAnMn+dxF5xyTKNf7/x61IOSSoo07G6YhENVOmEGIRibSk95HVAFs/rqD91r
         wSlUQECa1/bHv19s50SbOlxradD9VeBB4outcv49MAuIvs/1CA3rgIJ5lFa4EVU8wzu2
         DIguuH4PHieF2w8dsrHlClfPrR+YkydSZmZpTzZD+GEXS2Qf5DW9sRe6VhbQKlc8D7Zs
         Oa3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=FMRRlhrne21ssk8Ug5+3aeKjPpazi9r4MMsLrSx9HOk=;
        b=ne2b9Ykzk0ksv2YDGieVACLJypy30GY5yUMoMTFiadG3mBm37WHg1N9z/fuewblix8
         9lT64zDht5f4o0BBtK2eoFmNxI/AMjlDQUXLt7FKeZGTl18DgWkUWQeJ3ssRqVe3JvN7
         XcgCV42j1auejkhHC7tt8hMuEdMeJHPPyhUX45QfPam0c7LK8Vq9NEljuAh1nMqWGf00
         vAxd0TyjpjACz9WrBVPObOwLjgMOJOEstb34836Qus1eL6P4eXRqUn3wKecSbGjPy66k
         PQ1V05d/Bw4fcphyFoAtP4tJf+oB6pCh9434itYlJWQkcksFQsUZsVc+ZR1UwtMvL56n
         ryJw==
X-Gm-Message-State: AJIora/pG9yTSvqAEAnrh6OImoZBkb8e08pt+8CeFrvQPIFM9B0ywQ/o
	iWwARMj3ieMBKqdLpXwwLVGac/hScwH4jN0B
X-Google-Smtp-Source: 
 AGRyM1sKzUYBjZTDCbiw0B2uBMvIXwlhZrE6ykZS2u61VaBMpCuIcT6tSqXfA4blkDn5hzm2KAMcQA==
X-Received: by 2002:a63:84c7:0:b0:412:a0b2:3add with SMTP id
 k190-20020a6384c7000000b00412a0b23addmr3945539pgd.511.1657296968912;
        Fri, 08 Jul 2022 09:16:08 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 d9-20020a655889000000b0040c97f0057dsm27755582pgu.17.2022.07.08.09.16.08
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 09:16:08 -0700 (PDT)
Message-ID: <62c85848.1c69fb81.bd01e.84c6@mx.google.com>
Date: Fri, 08 Jul 2022 09:16:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.249-cip76-57-gef3cc1b9e556
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 53 runs,
 7 regressions (v4.19.249-cip76-57-gef3cc1b9e556)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Jul 2022 16:16:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8723

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 53 runs, 7 regress=
ions (v4.19.249-cip76-57-gef3cc1b9e556)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
beaglebone-black         | arm   | lab-broonie   | gcc-10   | multi_v7_defc=
onfig         | 1          =

beaglebone-black         | arm   | lab-broonie   | gcc-10   | omap2plus_def=
config        | 1          =

jetson-tk1               | arm   | lab-baylibre  | gcc-10   | multi_v7_defc=
onfig         | 1          =

jetson-tk1               | arm   | lab-baylibre  | gcc-10   | tegra_defconf=
ig            | 1          =

rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =

sun4i-a10-olinuxino-lime | arm   | lab-baylibre  | gcc-10   | multi_v7_defc=
onfig         | 1          =

sun4i-a10-olinuxino-lime | arm   | lab-baylibre  | gcc-10   | sunxi_defconf=
ig            | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.249-cip76-57-gef3cc1b9e556/plan/baseline-=
nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.249-cip76-57-gef3cc1b9e556
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      ef3cc1b9e55646468f12d0c0a8caf8874a9e7156 =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
beaglebone-black         | arm   | lab-broonie   | gcc-10   | multi_v7_defc=
onfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/62c584ee99bbfa1d5aa39bf4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.249-cip76-57-gef3cc1b9e556/arm/multi_v7_defconfig/gcc-10=
/lab-broonie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.249-cip76-57-gef3cc1b9e556/arm/multi_v7_defconfig/gcc-10=
/lab-broonie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220624.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62c584ee99bbfa1d5=
aa39bf5
        new failure (last pass: v4.19.249-cip76-54-gb41c396e258f) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
beaglebone-black         | arm   | lab-broonie   | gcc-10   | omap2plus_def=
config        | 1          =


  Details:     https://kernelci.org/test/plan/id/62c589c4c8bd9644bba39c18

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.249-cip76-57-gef3cc1b9e556/arm/omap2plus_defconfig/gcc-1=
0/lab-broonie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.249-cip76-57-gef3cc1b9e556/arm/omap2plus_defconfig/gcc-1=
0/lab-broonie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220624.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62c589c4c8bd9644b=
ba39c19
        new failure (last pass: v4.19.246-cip75-307-g39a7d45c38bb7) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
jetson-tk1               | arm   | lab-baylibre  | gcc-10   | multi_v7_defc=
onfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/62c585dfcbdf204315a39be3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.249-cip76-57-gef3cc1b9e556/arm/multi_v7_defconfig/gcc-10=
/lab-baylibre/baseline-nfs-jetson-tk1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.249-cip76-57-gef3cc1b9e556/arm/multi_v7_defconfig/gcc-10=
/lab-baylibre/baseline-nfs-jetson-tk1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220624.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62c585dfcbdf20431=
5a39be4
        failing since 30 days (last pass: v4.19.239-cip72-68-g407458469172,=
 first fail: v4.19.245-cip74-32-g2d021d7a9e637) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
jetson-tk1               | arm   | lab-baylibre  | gcc-10   | tegra_defconf=
ig            | 1          =


  Details:     https://kernelci.org/test/plan/id/62c588227b5caf41c1a39bef

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: tegra_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.249-cip76-57-gef3cc1b9e556/arm/tegra_defconfig/gcc-10/la=
b-baylibre/baseline-nfs-jetson-tk1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.249-cip76-57-gef3cc1b9e556/arm/tegra_defconfig/gcc-10/la=
b-baylibre/baseline-nfs-jetson-tk1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220624.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62c588227b5caf41c=
1a39bf0
        failing since 30 days (last pass: v4.19.239-cip72-68-g407458469172,=
 first fail: v4.19.245-cip74-32-g2d021d7a9e637) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62c587408c35a2dd20a39bdb

  Results:     82 PASS, 6 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.249-cip76-57-gef3cc1b9e556/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.249-cip76-57-gef3cc1b9e556/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220624.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/62c587408c35a2dd20a39bfd
        failing since 114 days (last pass: v4.19.229-cip67-111-g5c3c0b39cf3=
b, first fail: v4.19.231-cip68-123-g92e3e7f3d4df)

    2022-07-06T12:59:21.722047  /lava-6760913/1/../bin/lava-test-case
    2022-07-06T12:59:21.747522  <8>[   37.461304] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
sun4i-a10-olinuxino-lime | arm   | lab-baylibre  | gcc-10   | multi_v7_defc=
onfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/62c588fe10e4eab4b9a39bd7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.249-cip76-57-gef3cc1b9e556/arm/multi_v7_defconfig/gcc-10=
/lab-baylibre/baseline-nfs-sun4i-a10-olinuxino-lime.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.249-cip76-57-gef3cc1b9e556/arm/multi_v7_defconfig/gcc-10=
/lab-baylibre/baseline-nfs-sun4i-a10-olinuxino-lime.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220624.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62c588fe10e4eab4b=
9a39bd8
        new failure (last pass: v4.19.249-cip76-54-gb41c396e258f) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
sun4i-a10-olinuxino-lime | arm   | lab-baylibre  | gcc-10   | sunxi_defconf=
ig            | 1          =


  Details:     https://kernelci.org/test/plan/id/62c584ed966b481729a39bf4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: sunxi_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.249-cip76-57-gef3cc1b9e556/arm/sunxi_defconfig/gcc-10/la=
b-baylibre/baseline-nfs-sun4i-a10-olinuxino-lime.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.249-cip76-57-gef3cc1b9e556/arm/sunxi_defconfig/gcc-10/la=
b-baylibre/baseline-nfs-sun4i-a10-olinuxino-lime.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220624.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62c584ed966b48172=
9a39bf5
        new failure (last pass: v4.19.249-cip76-54-gb41c396e258f) =

 =20

