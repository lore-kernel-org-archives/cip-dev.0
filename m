Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD241C77B73
	for <webhook@archiver.kernel.org>; Tue, 30 May 2023 15:06:08 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.web11.73.1685459158868214361
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 30 May 2023 08:05:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=eG0tf+mG;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.173, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1b01dac1a82so25013255ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 30 May 2023 08:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685459158; x=1688051158;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MV3Bdfwq/QWLIUSkaVPOGzIrqKQreS/TUBxDYmFvCS4=;
        b=eG0tf+mGBAW9/xn10Vkm8feqGiv8VE4STqsr0PhldYv1mr0Vc/6NVgYx8XgJoxJaLx
         Zb/ju1iM4wDl8skbQbQ//o/+AAiCZ8/xHAK58cIqMer12ApmZ9jg9NemRVbLSKHZcl6D
         VEoyIxqA/orQ6ihJWjWUIv+m26xDeme4P0NSnIpqbcW+DkeiQ0YGZh1hZVRKpyaXpfb2
         XaxT7+zlCvHVhKPKxNZ2zHsMPl4F7lALn9eurGqvkzY1zOs0UlNYJhl5zugHMfRlHJCo
         32A2AKk/eqfPL6ySyk1k4ksv5v713YFHgm8LiALQKPyw4RPZLv5BSBuhibcC+q3x1szN
         G7sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685459158; x=1688051158;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MV3Bdfwq/QWLIUSkaVPOGzIrqKQreS/TUBxDYmFvCS4=;
        b=CJ6xfUxRrSd+tvIVLduwRKFhodJ+oJXQ3nDf19a6K47y3gwN7zDrOAPI5oZcj6kfQB
         G9Qv4wqa2AXmNrjFS2rgWASi0i9/bs3z1iUaYf98uLlOA2Ya9zjknUIPu/td7ViTRXoH
         6c+Mz0e3YQ7iKpkDErnLnBoJcpJL2gfH+UsRrqK1DKenzM5nyGAoKo90qVWirFG2WF4B
         oob5kyBgZbOahKwdEaOfMfU4keCTd5w/4HqQodcL7ASEKWeFShmB4p8t4VrzQ+1uzl9m
         lclVsYRZUV3mhULiyeI/IhIz8A+V3LgRGbaSj18i6e4jfRv/lNWkRhla1MqMjuimMDs6
         K9Rg==
X-Gm-Message-State: AC+VfDzVbPxTzpTEJhpcf8OLZqpYoHJGPZKTdpKbIEIWKFAtbHlEA6NZ
	EfHQOmUULTkzv+VtrGIOE4XXzsgwI7tZNrT52/PMNg==
X-Google-Smtp-Source: ACHHUZ6LYCWUF70fbV3MH6POjHhXl9AYiWrsKSjYFCupqcoJHYf5kA0qYJoDSr1iWRYTbPvj5bmMFw==
X-Received: by 2002:a17:902:b907:b0:1ab:160c:526d with SMTP id bf7-20020a170902b90700b001ab160c526dmr2362961plb.22.1685459157654;
        Tue, 30 May 2023 08:05:57 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w16-20020a1709029a9000b001ac897026cesm10399325plp.102.2023.05.30.08.05.56
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 08:05:57 -0700 (PDT)
Message-ID: <647610d5.170a0220.344be.36ca@mx.google.com>
Date: Tue, 30 May 2023 08:05:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.19.283-cip98-135-g4ed206c5dc11
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 27 runs,
 7 regressions (v4.19.283-cip98-135-g4ed206c5dc11)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 May 2023 15:06:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11702

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 27 runs, 7 regress=
ions (v4.19.283-cip98-135-g4ed206c5dc11)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =

beaglebone-black          | arm    | lab-cip       | gcc-10   | multi_v7_de=
fconfig           | 1          =

imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.283-cip98-135-g4ed206c5dc11/plan/baseline=
-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.283-cip98-135-g4ed206c5dc11
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      4ed206c5dc11f3047430e9e28f6b0ba48980512a =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6476068f65edba0b732e8617

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6476068f65edba0b732e861c
        failing since 131 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-05-30T14:21:46.936745  + set<8>[   17.960366] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10525249_1.5.2.3.1>

    2023-05-30T14:21:46.936849   +x

    2023-05-30T14:21:47.040872  / # #

    2023-05-30T14:21:47.141593  export SHELL=3D/bin/sh

    2023-05-30T14:21:47.141795  #

    2023-05-30T14:21:47.242307  / # export SHELL=3D/bin/sh. /lava-10525249/=
environment

    2023-05-30T14:21:47.242510  =


    2023-05-30T14:21:47.343053  / # . /lava-10525249/environment/lava-10525=
249/bin/lava-test-runner /lava-10525249/1

    2023-05-30T14:21:47.343416  =


    2023-05-30T14:21:47.348307  / # /lava-10525249/bin/lava-test-runner /la=
va-10525249/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647606a129fd6b68e22e8605

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647606a129fd6b68e22e860a
        failing since 131 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-05-30T14:22:05.639050  + set<8>[   24.739320] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10525287_1.5.2.3.1>

    2023-05-30T14:22:05.639162   +x

    2023-05-30T14:22:05.746740  / # #

    2023-05-30T14:22:05.847386  export SHELL=3D/bin/sh

    2023-05-30T14:22:05.847575  #

    2023-05-30T14:22:05.948176  / # export SHELL=3D/bin/sh. /lava-10525287/=
environment

    2023-05-30T14:22:05.948368  =


    2023-05-30T14:22:06.048926  / # . /lava-10525287/environment/lava-10525=
287/bin/lava-test-runner /lava-10525287/1

    2023-05-30T14:22:06.049203  =


    2023-05-30T14:22:06.054947  / # /lava-10525287/bin/lava-test-runner /la=
va-10525287/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6476080d521ea2b9502e861e

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm/multi_v7_defconfig/gcc-1=
0/lab-broonie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm/multi_v7_defconfig/gcc-1=
0/lab-broonie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6476080d521ea2b9502e8648
        failing since 131 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-05-30T14:27:39.445503  <8>[   45.172728] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 535945_1.6.2.4.1>
    2023-05-30T14:27:39.559897  / # #
    2023-05-30T14:27:39.662859  export SHELL=3D/bin/sh
    2023-05-30T14:27:39.663614  #
    2023-05-30T14:27:39.765870  / # export SHELL=3D/bin/sh. /lava-535945/en=
vironment
    2023-05-30T14:27:39.766586  =

    2023-05-30T14:27:39.868998  / # . /lava-535945/environment/lava-535945/=
bin/lava-test-runner /lava-535945/1
    2023-05-30T14:27:39.870136  =

    2023-05-30T14:27:39.874339  / # /lava-535945/bin/lava-test-runner /lava=
-535945/1
    2023-05-30T14:27:40.047390  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-cip       | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647610bde76e91abfe2e8607

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm/multi_v7_defconfig/gcc-1=
0/lab-cip/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm/multi_v7_defconfig/gcc-1=
0/lab-cip/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647610bde76e91abfe2e860a
        failing since 131 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-05-30T15:04:46.325931  / # #
    2023-05-30T15:04:46.429356  export SHELL=3D/bin/sh
    2023-05-30T15:04:46.430505  #
    2023-05-30T15:04:46.532959  / # export SHELL=3D/bin/sh. /lava-947290/en=
vironment
    2023-05-30T15:04:46.534158  =

    2023-05-30T15:04:46.636532  / # . /lava-947290/environment/lava-947290/=
bin/lava-test-runner /lava-947290/1
    2023-05-30T15:04:46.638403  =

    2023-05-30T15:04:46.648054  / # /lava-947290/bin/lava-test-runner /lava=
-947290/1
    2023-05-30T15:04:46.855485  + export TESTRUN_ID=3D1_bootrr
    2023-05-30T15:04:46.871571  + cd /lava-947290/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6476077325e9d0248a2e8601

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm/multi_v7_defconfig/gcc-1=
0/lab-collabora/baseline-nfs-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm/multi_v7_defconfig/gcc-1=
0/lab-collabora/baseline-nfs-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6476077325e9d0248a2e8606
        failing since 131 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-05-30T14:25:30.939992  / # #

    2023-05-30T14:25:31.042187  export SHELL=3D/bin/sh

    2023-05-30T14:25:31.042915  #

    2023-05-30T14:25:31.144313  / # export SHELL=3D/bin/sh. /lava-10525309/=
environment

    2023-05-30T14:25:31.145042  =


    2023-05-30T14:25:31.246543  / # . /lava-10525309/environment/lava-10525=
309/bin/lava-test-runner /lava-10525309/1

    2023-05-30T14:25:31.247669  =


    2023-05-30T14:25:31.252422  / # /lava-10525309/bin/lava-test-runner /la=
va-10525309/1

    2023-05-30T14:25:31.432935  + export TESTRUN_ID=3D1_bootrr

    2023-05-30T14:25:31.433100  + cd /lava-10525309/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6476091bd54e666bf02e860d

  Results:     77 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/6476091bd54e666bf02e8613
        failing since 77 days (last pass: v4.19.273-cip92-277-g507c8d80b9e2=
0, first fail: v4.19.276-cip93-5-g2eb2a953ab59)

    2023-05-30T14:32:35.938980  <8>[   39.301746] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-05-30T14:32:36.970545  /lava-10525355/1/../bin/lava-test-case

    2023-05-30T14:32:36.992983  <8>[   40.355866] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/6476091bd54e666bf02e8614
        failing since 77 days (last pass: v4.19.273-cip92-277-g507c8d80b9e2=
0, first fail: v4.19.276-cip93-5-g2eb2a953ab59)

    2023-05-30T14:32:35.918330  /lava-10525355/1/../bin/lava-test-case
   =

 =20

