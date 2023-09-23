Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F89CE7A88
	for <webhook@archiver.kernel.org>; Sat, 23 Sep 2023 13:22:09 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web10.20119.1695475321572815374
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 23 Sep 2023 06:22:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=IpQZOMn2;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.174, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1c5dd017b30so25624475ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 23 Sep 2023 06:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695475320; x=1696080120; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qURDMUCeejOOzdxMdbWL7h+nTgqUvZUIZyTMZBYbZcQ=;
        b=IpQZOMn21E2oZM97StLPvg68kScgcd7E5Q/4dOn92tEwLwUyUkOAod9MWbb4sjkD2G
         ZUSzGBRTJdnmAEKHWPAoiHCYvBG6iQKSAbbq2tF3eOSb174eCJ+0mC4+XKEJXznKCM7A
         toUIZBDLQSVkiK8Z3sew2EYptuOxKXvIIIythi75Edw9v+NT/z9S+8OS5BaWgWk+2sa0
         nWKUAzAxFNyfnKhQl/3EUZ/wXXjfIdc2GpOqNO703xPEqRSQGfY9tczA+BUPId44BUR0
         jSXr0AybwFTc6b/p6gmHzig+J+Makgkm2j4KP1UHBZpgjPQASWk7SPgwcCx09LrFEJYX
         G9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695475320; x=1696080120;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qURDMUCeejOOzdxMdbWL7h+nTgqUvZUIZyTMZBYbZcQ=;
        b=kokGRl8qUKI9vz3pqmY25MjjlQ2/4YbTBacmTcj024S8JV0UeeL6snMQlRoGcpbgyI
         HeC9QPBYVU3Y0Z3zp01hr93IMjRioJbpWjcdWlcTadOXlHu/cXU7E8qm4k3i2pOjqs6e
         xcl4f/OGz+y1NUJ4d3STWwiaAJ7c3IosR2s9QgQlrI9CJG8eA/v1kt70PFT4ZxXCMlAH
         E9YmBeFuYAMGWh62W3M0CXiMozIjqee+mTLHOiPYRTTUUSh1rJWrRM9Hzb0uuAM0UlJ0
         zU2bGmlla+l9bckX7FGdOLu1FlIQRW3o/33RanCjnUPSVD/aluRJ5UaJqm7nIrw8MY7I
         elsw==
X-Gm-Message-State: AOJu0YwEQGTjbfBScoFYvgbo6KE9hIDziz+L/sB1RNA1H+2qNfv8b6rN
	10L9SlM2addbgp69gsuKfiUKOyBNOcOeP1TVAH2jJA==
X-Google-Smtp-Source: AGHT+IF5pWqgoXDd0rTzqFv4UvHoAYSH19GyTICL+yOBQ5AaFgU95Km+9C1VeDqcMZL7YeK2/1RS+A==
X-Received: by 2002:a17:902:e887:b0:1c3:b0c7:38bf with SMTP id w7-20020a170902e88700b001c3b0c738bfmr8092133plg.12.1695475320295;
        Sat, 23 Sep 2023 06:22:00 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u3-20020a17090282c300b001c0de73564dsm274116plz.205.2023.09.23.06.21.59
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 06:21:59 -0700 (PDT)
Message-ID: <650ee677.170a0220.d3d96.0634@mx.google.com>
Date: Sat, 23 Sep 2023 06:21:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.19.292-cip102-406-g9efaa60a8cb4
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 17 runs,
 7 regressions (v4.19.292-cip102-406-g9efaa60a8cb4)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 23 Sep 2023 13:22:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13214

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 17 runs, 7 regress=
ions (v4.19.292-cip102-406-g9efaa60a8cb4)

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
Flinux-4.19.y-cip-rc/kernel/v4.19.292-cip102-406-g9efaa60a8cb4/plan/baselin=
e-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.292-cip102-406-g9efaa60a8cb4
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      9efaa60a8cb4536f9f628645bafb460099be9df5 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/650edf64a80cc07de48a0a85

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-406-g9efaa60a8cb4/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-406-g9efaa60a8cb4/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/650edf64a80cc07de48a0a8e
        failing since 247 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-09-23T12:51:29.850068  + set +x

    2023-09-23T12:51:29.856674  <8>[   17.542581] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11602058_1.5.2.3.1>

    2023-09-23T12:51:29.966249  / # #

    2023-09-23T12:51:30.066786  export SHELL=3D/bin/sh

    2023-09-23T12:51:30.066927  #

    2023-09-23T12:51:30.167378  / # export SHELL=3D/bin/sh. /lava-11602058/=
environment

    2023-09-23T12:51:30.167524  =


    2023-09-23T12:51:30.267996  / # . /lava-11602058/environment/lava-11602=
058/bin/lava-test-runner /lava-11602058/1

    2023-09-23T12:51:30.268239  =


    2023-09-23T12:51:30.273033  / # /lava-11602058/bin/lava-test-runner /la=
va-11602058/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/650edf81ffbb0b6bfe8a0a6e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-406-g9efaa60a8cb4/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-406-g9efaa60a8cb4/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/650edf81ffbb0b6bfe8a0a77
        failing since 247 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-09-23T12:53:26.472936  + set +x

    2023-09-23T12:53:26.479676  <8>[   21.131664] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11602094_1.5.2.3.1>

    2023-09-23T12:53:26.590333  / # #

    2023-09-23T12:53:26.690989  export SHELL=3D/bin/sh

    2023-09-23T12:53:26.691369  #

    2023-09-23T12:53:26.791935  / # export SHELL=3D/bin/sh. /lava-11602094/=
environment

    2023-09-23T12:53:26.792162  =


    2023-09-23T12:53:26.892662  / # . /lava-11602094/environment/lava-11602=
094/bin/lava-test-runner /lava-11602094/1

    2023-09-23T12:53:26.893008  =


    2023-09-23T12:53:26.897949  / # /lava-11602094/bin/lava-test-runner /la=
va-11602094/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/650ee01618ddd99c538a0aea

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-406-g9efaa60a8cb4/arm/multi_v7_defconfig/gcc-=
10/lab-broonie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-406-g9efaa60a8cb4/arm/multi_v7_defconfig/gcc-=
10/lab-broonie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/650ee01618ddd99c538a0b19
        failing since 247 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-09-23T12:53:57.159905  <8>[   43.300692] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 127796_1.6.2.4.1>
    2023-09-23T12:53:57.276280  / # #
    2023-09-23T12:53:57.379638  export SHELL=3D/bin/sh
    2023-09-23T12:53:57.380564  #
    2023-09-23T12:53:57.482729  / # export SHELL=3D/bin/sh. /lava-127796/en=
vironment
    2023-09-23T12:53:57.483663  =

    2023-09-23T12:53:57.585967  / # . /lava-127796/environment/lava-127796/=
bin/lava-test-runner /lava-127796/1
    2023-09-23T12:53:57.587468  =

    2023-09-23T12:53:57.590677  / # /lava-127796/bin/lava-test-runner /lava=
-127796/1
    2023-09-23T12:53:57.797446  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-cip       | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/650ee02a695e1df0178a0a4d

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-406-g9efaa60a8cb4/arm/multi_v7_defconfig/gcc-=
10/lab-cip/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-406-g9efaa60a8cb4/arm/multi_v7_defconfig/gcc-=
10/lab-cip/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/650ee02a695e1df0178a0a54
        failing since 247 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-09-23T12:54:06.181207  <8>[   45.962329] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1012403_1.6.2.4.1>
    2023-09-23T12:54:06.467444  / # #
    2023-09-23T12:54:06.570150  export SHELL=3D/bin/sh
    2023-09-23T12:54:06.570869  #
    2023-09-23T12:54:06.672693  / # export SHELL=3D/bin/sh. /lava-1012403/e=
nvironment
    2023-09-23T12:54:06.673416  =

    2023-09-23T12:54:06.775269  / # . /lava-1012403/environment/lava-101240=
3/bin/lava-test-runner /lava-1012403/1
    2023-09-23T12:54:06.776458  =

    2023-09-23T12:54:06.782314  / # /lava-1012403/bin/lava-test-runner /lav=
a-1012403/1
    2023-09-23T12:54:07.046502  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/650edfb4e2012e98f78a0a42

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-406-g9efaa60a8cb4/arm/multi_v7_defconfig/gcc-=
10/lab-collabora/baseline-nfs-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-406-g9efaa60a8cb4/arm/multi_v7_defconfig/gcc-=
10/lab-collabora/baseline-nfs-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/650edfb4e2012e98f78a0a4b
        failing since 247 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-09-23T12:55:08.342310  / # #

    2023-09-23T12:55:08.444369  export SHELL=3D/bin/sh

    2023-09-23T12:55:08.445056  #

    2023-09-23T12:55:08.546505  / # export SHELL=3D/bin/sh. /lava-11602119/=
environment

    2023-09-23T12:55:08.547191  =


    2023-09-23T12:55:08.648721  / # . /lava-11602119/environment/lava-11602=
119/bin/lava-test-runner /lava-11602119/1

    2023-09-23T12:55:08.649816  =


    2023-09-23T12:55:08.650722  / # /lava-11602119/bin/lava-test-runner /la=
va-11602119/1

    2023-09-23T12:55:08.798253  + export TESTRUN_ID=3D1_bootrr

    2023-09-23T12:55:08.798402  + cd /lava-11602119/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/650edfd2e2012e98f78a0a77

  Results:     77 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-406-g9efaa60a8cb4/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.292-cip102-406-g9efaa60a8cb4/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/650edfd2e2012e98f78a0a81
        failing since 193 days (last pass: v4.19.273-cip92-277-g507c8d80b9e=
20, first fail: v4.19.276-cip93-5-g2eb2a953ab59)

    2023-09-23T12:53:32.875826  /lava-11602143/1/../bin/lava-test-case

    2023-09-23T12:53:32.895044  <8>[   39.528520] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/650edfd2e2012e98f78a0a82
        failing since 193 days (last pass: v4.19.273-cip92-277-g507c8d80b9e=
20, first fail: v4.19.276-cip93-5-g2eb2a953ab59)

    2023-09-23T12:53:31.813446  /lava-11602143/1/../bin/lava-test-case

    2023-09-23T12:53:31.839056  <8>[   38.472312] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =20

