Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB832EB64DD
	for <webhook@archiver.kernel.org>; Tue, 25 Jul 2023 20:38:01 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web11.173.1690317477530024309
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 25 Jul 2023 13:37:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=UAHzW/ts;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1bb8e45185bso16508405ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 25 Jul 2023 13:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690317476; x=1690922276;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=k5L9SX84TDELpYYi3v7KDxYqcrs9X97H/Pa4ocG0AZo=;
        b=UAHzW/tsbWolfknU+tUnJ0zwH1LrcYNdzkVTc/PVstZs+iumin1Df0Aa1RbidvlgG4
         +bk/B5u4WuhRs2nQrWr6fiIIwkTP1mg6IvaoMA4yqrpYqvuv56CnQSLfbdJ/OIFpOTJH
         elgIxwPjqvQ9lcMqxORZrxpZBnB5SOlbAQYdRh++4DBT6EfUlbYwzH6Kk2B4cv3FZsR9
         42cH02jKfO+iROZpG0J8wr4V7bfaETH16okhQNYob04SgmPJRdaIYF0bzvG9MsQi7jc6
         O4cAKPJV4VxTc3rVP6lGaLTd07gIiPJ5fx/V5WS5SrIT5LqYgm8yFTouF4dDAwCbvgUv
         qBUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690317476; x=1690922276;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k5L9SX84TDELpYYi3v7KDxYqcrs9X97H/Pa4ocG0AZo=;
        b=hbWp5BnP19R20eZpWNkbHu2GDW+gZypfaiXwGUJmIC9aAWhtNouvj5KAapHSEbzSf/
         dq4QEi3Jx5weROZAwGrWxhzn5Dm75r1ZHGkpUcJu5wSDHTqG5r/PfyKotAeOvZbKdLVO
         hmUVORrCzA2L2o1Hny+byAcTqFW0APFFmY657fdSHDzztjoIzzITUIiT2CLSqBqXJH+r
         uiipCyV5QVPEPWQdDLTNA772Cq8XWN9m+YeC0hy0eqPIHZ1236YSLYBbXy6sDEoMI/Vy
         Uxq2KR3eKMSA+9PCpwiq+e1RxOHl0EMn16x/p8u+KPzgw7Rs+7Tdt+unjS0CC3uq/Esb
         9eyw==
X-Gm-Message-State: ABy/qLYyD8ETZg/x4iEN52mmdr0L4zKc4DSI8JBQVRx5gCiUDq569c6/
	bYafx01aqKizcClqfYaS+mxq9m783SHqTYZogigdcA==
X-Google-Smtp-Source: APBJJlHs6GpQa3HSY+Is4LRmf5ICo/UYWc9pi0o1fzBf/r42wPRF+rJvrkMhGPsoKmdqkkUnYYc51Q==
X-Received: by 2002:a17:902:e54a:b0:1b9:ebf4:5d2 with SMTP id n10-20020a170902e54a00b001b9ebf405d2mr276371plf.33.1690317476006;
        Tue, 25 Jul 2023 13:37:56 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id bd3-20020a170902830300b001b9e9f191f2sm11546768plb.15.2023.07.25.13.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 13:37:55 -0700 (PDT)
Message-ID: <64c032a3.170a0220.fec61.5f87@mx.google.com>
Date: Tue, 25 Jul 2023 13:37:55 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.186-cip37-12-g2710acbceb751
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip baseline-nfs: 24 runs,
 12 regressions (v5.10.186-cip37-12-g2710acbceb751)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Jul 2023 20:38:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12503

cip/linux-5.10.y-cip baseline-nfs: 24 runs, 12 regressions (v5.10.186-cip37=
-12-g2710acbceb751)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+kselftest          | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.186-cip37-12-g2710acbceb751/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.186-cip37-12-g2710acbceb751
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      2710acbceb751c864f5fbbd3521374e60d9802fe =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64c029f8c2d9e23c968acee2

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline=
-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline=
-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64c029f8c2d9e23c968acf0e
        failing since 192 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-07-25T20:00:04.443874  + set +x
    2023-07-25T20:00:04.447607  <8>[   52.280546] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9625_1.6.2.4.1>
    2023-07-25T20:00:04.565147  / # #
    2023-07-25T20:00:04.668041  export SHELL=3D/bin/sh
    2023-07-25T20:00:04.668862  #
    2023-07-25T20:00:04.771010  / # export SHELL=3D/bin/sh. /lava-9625/envi=
ronment
    2023-07-25T20:00:04.771713  =

    2023-07-25T20:00:04.873824  / # . /lava-9625/environment/lava-9625/bin/=
lava-test-runner /lava-9625/1
    2023-07-25T20:00:04.874967  =

    2023-07-25T20:00:04.879431  / # /lava-9625/bin/lava-test-runner /lava-9=
625/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64c02c51a1bffa06b58acec1

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs=
-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs=
-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64c02c51a1bffa06b58acec4
        failing since 192 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-07-25T20:10:09.620591  + set +x
    2023-07-25T20:10:09.622538  <8>[   43.980698] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 989123_1.6.2.4.1>
    2023-07-25T20:10:09.741135  / # #
    2023-07-25T20:10:09.843127  export SHELL=3D/bin/sh
    2023-07-25T20:10:09.843736  #
    2023-07-25T20:10:09.945069  / # export SHELL=3D/bin/sh. /lava-989123/en=
vironment
    2023-07-25T20:10:09.945359  =

    2023-07-25T20:10:10.046574  / # . /lava-989123/environment/lava-989123/=
bin/lava-test-runner /lava-989123/1
    2023-07-25T20:10:10.047305  =

    2023-07-25T20:10:10.049378  / # /lava-989123/bin/lava-test-runner /lava=
-989123/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c027fbb860efb63f8ace30

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64c027fbb860efb63f8ace35
        failing since 102 days (last pass: v5.10.176-cip30, first fail: v5.=
10.177-cip31)

    2023-07-25T19:52:44.985451  + set<8>[   22.611511] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11139055_1.5.2.3.1>

    2023-07-25T19:52:44.985536   +x

    2023-07-25T19:52:45.090243  / # #

    2023-07-25T19:52:45.190785  export SHELL=3D/bin/sh

    2023-07-25T19:52:45.190960  #

    2023-07-25T19:52:45.291426  / # export SHELL=3D/bin/sh. /lava-11139055/=
environment

    2023-07-25T19:52:45.291652  =


    2023-07-25T19:52:45.392131  / # . /lava-11139055/environment/lava-11139=
055/bin/lava-test-runner /lava-11139055/1

    2023-07-25T19:52:45.392426  =


    2023-07-25T19:52:45.397065  / # /lava-11139055/bin/lava-test-runner /la=
va-11139055/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c027cf69caebe0978ace21

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64c027cf69caebe0978ace26
        failing since 102 days (last pass: v5.10.176-cip30, first fail: v5.=
10.177-cip31)

    2023-07-25T19:51:16.973993  + <8>[   18.649722] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11139090_1.5.2.3.1>

    2023-07-25T19:51:16.974084  set +x

    2023-07-25T19:51:17.078024  / # #

    2023-07-25T19:51:17.178631  export SHELL=3D/bin/sh

    2023-07-25T19:51:17.178820  #

    2023-07-25T19:51:17.279488  / # export SHELL=3D/bin/sh. /lava-11139090/=
environment

    2023-07-25T19:51:17.279695  =


    2023-07-25T19:51:17.380251  / # . /lava-11139090/environment/lava-11139=
090/bin/lava-test-runner /lava-11139090/1

    2023-07-25T19:51:17.380585  =


    2023-07-25T19:51:17.385796  / # /lava-11139090/bin/lava-test-runner /la=
va-11139090/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64c029ad4b9b87a1948ace2a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-nfs-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-nfs-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64c029ad4b9b87a1948ace2f
        failing since 192 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-07-25T19:59:26.747026  / # #

    2023-07-25T19:59:26.848818  export SHELL=3D/bin/sh

    2023-07-25T19:59:26.849509  #

    2023-07-25T19:59:26.950778  / # export SHELL=3D/bin/sh. /lava-11139145/=
environment

    2023-07-25T19:59:26.951401  =


    2023-07-25T19:59:27.052842  / # . /lava-11139145/environment/lava-11139=
145/bin/lava-test-runner /lava-11139145/1

    2023-07-25T19:59:27.053908  =


    2023-07-25T19:59:27.056491  / # /lava-11139145/bin/lava-test-runner /la=
va-11139145/1

    2023-07-25T19:59:27.220718  + export TESTRUN_ID=3D1_bootrr

    2023-07-25T19:59:27.220847  + cd /lava-11139145/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64c02ac0df8a83fb118ace2e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm64/defconfig+kselftest/gcc-10/lab-broonie/basel=
ine-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm64/defconfig+kselftest/gcc-10/lab-broonie/basel=
ine-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64c02ac0df8a83fb1=
18ace2f
        new failure (last pass: v5.10.184-cip36-13-g8fae18103387) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64c02cf087ae1a97f48ace1c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm64/defconfig+arm64-chromebook/gcc-10/lab-brooni=
e/baseline-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm64/defconfig+arm64-chromebook/gcc-10/lab-brooni=
e/baseline-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64c02cf087ae1a97f=
48ace1d
        new failure (last pass: v5.10.184-cip36-13-g8fae18103387) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c02a8c97e5d0e39a8ace4d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm64/defconfig/gcc-10/lab-cip/baseline-nfs-r8a774=
a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm64/defconfig/gcc-10/lab-cip/baseline-nfs-r8a774=
a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64c02a8c97e5d0e39=
a8ace4e
        new failure (last pass: v5.10.184-cip36-13-g8fae18103387) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64c02d98c3cd97b1a08ace29

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-=
nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-=
nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64c02d98c3cd97b1a=
08ace2a
        new failure (last pass: v5.10.184-cip36-13-g8fae18103387) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64c03018f7583891a78ace2b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ba=
seline-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ba=
seline-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64c03018f7583891a=
78ace2c
        new failure (last pass: v5.10.184-cip36-13-g8fae18103387) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64c02c56a1bffa06b58acef4

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm64/defconfig+arm64-chromebook/gcc-10/lab-collab=
ora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/arm64/defconfig+arm64-chromebook/gcc-10/lab-collab=
ora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/64c02c56a1bffa06b58acefa
        failing since 125 days (last pass: v5.10.173-cip28, first fail: v5.=
10.175-cip29)

    2023-07-25T20:10:51.750563  <8>[   96.838081] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-07-25T20:10:52.811079  /lava-11139195/1/../bin/lava-test-case

    2023-07-25T20:10:52.845409  <8>[   97.934370] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/64c02c56a1bffa06b58acefb
        failing since 125 days (last pass: v5.10.173-cip28, first fail: v5.=
10.175-cip29)

    2023-07-25T20:10:50.655120  <8>[   95.741868] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-07-25T20:10:51.712849  /lava-11139195/1/../bin/lava-test-case
   =

 =20

