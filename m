Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4E2C0015E
	for <webhook@archiver.kernel.org>; Fri, 11 Aug 2023 14:06:53 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.web10.43589.1691762805034017261
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 11 Aug 2023 07:06:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=sV4VYFaF;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.171, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-686f19b6dd2so1521758b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 11 Aug 2023 07:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691762804; x=1692367604;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FvttYEgyPZ3Adn36SavgMrZLfbBZjZlgqqI2aq9L7Bw=;
        b=sV4VYFaFQSb+cf+0Sw69MmYiMpttX1AIoM+uGaaKMfowWSzkJzol9mfJHRVIKkoMoE
         JklZkwSYk5tJ3ezx0dyYD9XZV5IboiMu8hmjIZDnKTg8xOShqZ6LQgYRutEkr8Xn600E
         ikDSeZT/JLx7kFPJLl3PavDy59Ky6qo5aUTeLK55LprsLH2LnTXkj0/AowS7p1R0vLtK
         8MdDy/CmYvV6HH4WiXjo1RMcQvf5MNr1huTCtsG4s8tdUnU3JgOov4fRhSk46m62ahRN
         /PnyPlizeqHJBjrBjd+K4ZnjmH9A3cbOERmIcFMO/SSFrlbgZwkElP/PPKUfAuOabd1T
         UL7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691762804; x=1692367604;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FvttYEgyPZ3Adn36SavgMrZLfbBZjZlgqqI2aq9L7Bw=;
        b=hWIdyqVm7RxUgNQziZYIjzBGbwFgd2FsoM3KVwXjrO2aQ7xIf2X5Q1lLzRGSIi1k+8
         wo7bLBb1JXIG6+BBh/xI3IbYyraqyBxVsGeSALv3bcpCgtNnj8mF+7nTLZR47SshTvFu
         Nue0AvbGxZEA8W8eiVbMAEmJbA+P8T4LRyhLmaNGkBUwnZT2ClBut0Reuv/ynfZWfZoW
         +il5RJ3wueyjWjdSJfAB21PGhU+gWY6XSCJMfkSIhe3hkAkgTI/FxmQXXzj5xBmd2c0e
         k6BQSnw7Nn2Jt4i8/O/V4mRq6r86bYexJ5pIwlo1t4nuxDLQKCUGzEYvI7/7JXpxRDCp
         BqNQ==
X-Gm-Message-State: AOJu0YyInnQixtyPudQZokR597jgZN65czNAfdb0jMxtZUg/yTcCwZ/G
	G+ln5afhsRods8/b6N4Qutc4Qt7pazXkniqg5ksaag==
X-Google-Smtp-Source: AGHT+IG46r5Qjctg1JTyrNi1mifrfVFZrG56Zzz35JCzrpCCGiXnfgvceiOrn5lUpfL9dSdTlUau/w==
X-Received: by 2002:a05:6a20:8f01:b0:133:faf4:ed2f with SMTP id b1-20020a056a208f0100b00133faf4ed2fmr2296854pzk.40.1691762803873;
        Fri, 11 Aug 2023 07:06:43 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p23-20020a62ab17000000b0068703879d3esm3364201pff.113.2023.08.11.07.06.42
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 07:06:43 -0700 (PDT)
Message-ID: <64d64073.620a0220.861fd.620d@mx.google.com>
Date: Fri, 11 Aug 2023 07:06:43 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.288-cip101-354-g730e5876ef02
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 10 runs,
 5 regressions (v4.19.288-cip101-354-g730e5876ef02)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Aug 2023 14:06:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12613

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 10 runs, 5 regress=
ions (v4.19.288-cip101-354-g730e5876ef02)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
beaglebone-black | arm   | lab-broonie   | gcc-10   | multi_v7_defconfig   =
      | 1          =

beaglebone-black | arm   | lab-cip       | gcc-10   | multi_v7_defconfig   =
      | 1          =

imx6q-sabrelite  | arm   | lab-collabora | gcc-10   | multi_v7_defconfig   =
      | 1          =

rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.288-cip101-354-g730e5876ef02/plan/baselin=
e-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.288-cip101-354-g730e5876ef02
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      730e5876ef0219ea7ab928b05c6f4ae92d8baef6 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
beaglebone-black | arm   | lab-broonie   | gcc-10   | multi_v7_defconfig   =
      | 1          =


  Details:     https://kernelci.org/test/plan/id/64d63a087a9c9c635a35b1df

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-354-g730e5876ef02/arm/multi_v7_defconfig/gcc-=
10/lab-broonie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-354-g730e5876ef02/arm/multi_v7_defconfig/gcc-=
10/lab-broonie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64d63a087a9c9c635a35b20a
        failing since 204 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-08-11T13:38:30.211504  <8>[   48.241172] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 45767_1.6.2.4.1>
    2023-08-11T13:38:30.327381  / # #
    2023-08-11T13:38:30.430513  export SHELL=3D/bin/sh
    2023-08-11T13:38:30.431109  #
    2023-08-11T13:38:30.533532  / # export SHELL=3D/bin/sh. /lava-45767/env=
ironment
    2023-08-11T13:38:30.534701  =

    2023-08-11T13:38:30.637624  / # . /lava-45767/environment/lava-45767/bi=
n/lava-test-runner /lava-45767/1
    2023-08-11T13:38:30.638568  =

    2023-08-11T13:38:30.642241  / # /lava-45767/bin/lava-test-runner /lava-=
45767/1
    2023-08-11T13:38:30.807602  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
beaglebone-black | arm   | lab-cip       | gcc-10   | multi_v7_defconfig   =
      | 1          =


  Details:     https://kernelci.org/test/plan/id/64d63a0fb908e1546c35b29c

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-354-g730e5876ef02/arm/multi_v7_defconfig/gcc-=
10/lab-cip/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-354-g730e5876ef02/arm/multi_v7_defconfig/gcc-=
10/lab-cip/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64d63a0fb908e1546c35b29f
        failing since 204 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-08-11T13:38:41.668367  + set +x
    2023-08-11T13:38:41.670387  <8>[   46.941202] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 995795_1.6.2.4.1>
    2023-08-11T13:38:41.785181  / # #
    2023-08-11T13:38:41.887059  export SHELL=3D/bin/sh
    2023-08-11T13:38:41.887506  #
    2023-08-11T13:38:41.988913  / # export SHELL=3D/bin/sh. /lava-995795/en=
vironment
    2023-08-11T13:38:41.989359  =

    2023-08-11T13:38:42.090769  / # . /lava-995795/environment/lava-995795/=
bin/lava-test-runner /lava-995795/1
    2023-08-11T13:38:42.091511  =

    2023-08-11T13:38:42.093060  / # /lava-995795/bin/lava-test-runner /lava=
-995795/1 =

    ... (12 line(s) more)  =

 =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
imx6q-sabrelite  | arm   | lab-collabora | gcc-10   | multi_v7_defconfig   =
      | 1          =


  Details:     https://kernelci.org/test/plan/id/64d639de4a999a467635b20d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-354-g730e5876ef02/arm/multi_v7_defconfig/gcc-=
10/lab-collabora/baseline-nfs-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-354-g730e5876ef02/arm/multi_v7_defconfig/gcc-=
10/lab-collabora/baseline-nfs-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64d639de4a999a467635b212
        failing since 204 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-08-11T13:38:31.669960  / # #

    2023-08-11T13:38:31.772717  export SHELL=3D/bin/sh

    2023-08-11T13:38:31.773499  #

    2023-08-11T13:38:31.875467  / # export SHELL=3D/bin/sh. /lava-11263499/=
environment

    2023-08-11T13:38:31.876304  =


    2023-08-11T13:38:31.978296  / # . /lava-11263499/environment/lava-11263=
499/bin/lava-test-runner /lava-11263499/1

    2023-08-11T13:38:31.979601  =


    2023-08-11T13:38:31.981802  / # /lava-11263499/bin/lava-test-runner /la=
va-11263499/1

    2023-08-11T13:38:32.182437  + export TESTRUN_ID=3D1_bootrr

    2023-08-11T13:38:32.182952  + cd /lava-11263499/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 2          =


  Details:     https://kernelci.org/test/plan/id/64d639e9cd37376d1d35b238

  Results:     77 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-354-g730e5876ef02/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-354-g730e5876ef02/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/64d639e9cd37376d1d35b23e
        failing since 150 days (last pass: v4.19.273-cip92-277-g507c8d80b9e=
20, first fail: v4.19.276-cip93-5-g2eb2a953ab59)

    2023-08-11T13:38:59.359354  <8>[   39.465088] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-08-11T13:39:00.400466  /lava-11263506/1/../bin/lava-test-case

    2023-08-11T13:39:00.428591  <8>[   40.535780] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/64d639e9cd37376d1d35b23f
        failing since 150 days (last pass: v4.19.273-cip92-277-g507c8d80b9e=
20, first fail: v4.19.276-cip93-5-g2eb2a953ab59)

    2023-08-11T13:38:58.293371  <8>[   38.399551] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-08-11T13:38:59.328430  /lava-11263506/1/../bin/lava-test-case
   =

 =20

