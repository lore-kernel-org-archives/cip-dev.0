Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C47C0015E
	for <webhook@archiver.kernel.org>; Fri, 11 Aug 2023 14:57:23 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.web11.44812.1691765839691410003
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 11 Aug 2023 07:57:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=Tpjj0BFc;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.173, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1bdc6867ec4so700875ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 11 Aug 2023 07:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691765839; x=1692370639;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yJ+Rva7Xe6WbI105XmbL03O5CMk8eYeOLu1RzWgbcoU=;
        b=Tpjj0BFcGGvETTg+FU9PTZ/sUSZZLkDSZJN6Q/22RM8g1RG5qHBVrU3pHtYjcNzhgz
         /PgxQFLOOMUZNmL4rcYkaaZfZnzDemHYk/wK1xIQWGSvzrdwp3XzSroEXpGbI9E4JtcI
         ZTXvbsqJSjGtj3VJ12c3itoDk1bl/4cAcwt2zumwIy7cwSOTWFOHySNyN6zHqcqlAmws
         sFRq5PLCZrPCXi/Jeq1/ohEmW+a/G1jwmRX/CPPQmSItDMcSj5K2jEAqjU9gy0NNkp6K
         dw8jcpRqBceNXhvjRRcKQxqvw/P+eKD9h2/SEWocrsIjNyOtHvP8qt4u7r4GfnomUV6s
         8BFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691765839; x=1692370639;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yJ+Rva7Xe6WbI105XmbL03O5CMk8eYeOLu1RzWgbcoU=;
        b=GEZ7lObbmuNKTSPEsFp1G47Dst2cJzfqVpvEjN5+0BuA8+lfXWTu6mMm2DvDr+ELqN
         jQFgyCX5/ULrwxvCyn+uvcUboCX32NzRZVDFO8VAW0HA0nH41p0LHEdjBeQHWf7gBdyo
         cP+5y+bO8ZGefDJ8EI0vJhCSMsSMHFFMDsrW8jJfRQ+3MhSYRfMIXLJm7E4uNpAvjnqh
         jfLmBBHA6hH78RmAJ9k9SBCE5wW60SOAiB4mqZPVsKE6gZbTACspw0TGHuZpJCSmz0TL
         S29PccLTkJKus6zmCmR5nnD0p0v6C79nx84EuWz0Y4XeQQZ8k95i2augIaR4RD/FAdbp
         6fKA==
X-Gm-Message-State: AOJu0YwAh9i6McUH38lpopJEk8JQFR/xs22Tl7i+LHLHg29B9LiiWp1z
	4wgRHUbk+ewQ6HtO/Gj4vNdOXe37m7T+w1gjXTG1lw==
X-Google-Smtp-Source: AGHT+IGuH0nyMh+kP8+lIYm3yBcWqoUJzgL+kPSoxw0JCplFPKH2otZIqgRUceaeoRCQdai1fhQPZg==
X-Received: by 2002:a17:903:228b:b0:1b8:4ec2:5200 with SMTP id b11-20020a170903228b00b001b84ec25200mr1923482plh.2.1691765838011;
        Fri, 11 Aug 2023 07:57:18 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id bh9-20020a170902a98900b001b89a6164desm3997348plb.118.2023.08.11.07.57.17
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 07:57:17 -0700 (PDT)
Message-ID: <64d64c4d.170a0220.1ebea.763e@mx.google.com>
Date: Fri, 11 Aug 2023 07:57:17 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.186-cip37-770-gddd36cfc4c4c8
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 169 runs,
 21 regressions (v5.10.186-cip37-770-gddd36cfc4c4c8)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Aug 2023 14:57:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12617

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 169 runs, 21 regressio=
ns (v5.10.186-cip37-770-gddd36cfc4c4c8)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora | gcc-10   | bcm2835_=
defconfig            | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =

juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+kselftest          | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g+kselftest          | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 2          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.186-cip37-770-gddd36cfc4c4c8/plan/baselin=
e/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.186-cip37-770-gddd36cfc4c4c8
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      ddd36cfc4c4c8e772fc77e48315307e9956bad25 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora | gcc-10   | bcm2835_=
defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/64d63fab40a60e476f35b22e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-770-gddd36cfc4c4c8/arm/bcm2835_defconfig/gcc-1=
0/lab-collabora/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-770-gddd36cfc4c4c8/arm/bcm2835_defconfig/gcc-1=
0/lab-collabora/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d63fab40a60e476f35b233
        failing since 15 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-08-11T14:04:46.101311  / # #

    2023-08-11T14:04:46.203451  export SHELL=3D/bin/sh

    2023-08-11T14:04:46.204152  #

    2023-08-11T14:04:46.305602  / # export SHELL=3D/bin/sh. /lava-11263747/=
environment

    2023-08-11T14:04:46.306310  =


    2023-08-11T14:04:46.407699  / # . /lava-11263747/environment/lava-11263=
747/bin/lava-test-runner /lava-11263747/1

    2023-08-11T14:04:46.408647  =


    2023-08-11T14:04:46.410810  / # /lava-11263747/bin/lava-test-runner /la=
va-11263747/1

    2023-08-11T14:04:46.490763  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-11T14:04:46.528711  + cd /lava-11263747/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64d63fb440a60e476f35b23c

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-770-gddd36cfc4c4c8/arm/omap2plus_defconfig/gcc=
-10/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-770-gddd36cfc4c4c8/arm/omap2plus_defconfig/gcc=
-10/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d63fb440a60e476f35b272
        failing since 219 days (last pass: v5.10.155-cip21-405-g26d566555c3=
de, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2023-08-11T14:03:14.823506  <8>[   20.430370] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 45825_1.5.2.4.1>
    2023-08-11T14:03:14.932815  / # #
    2023-08-11T14:03:15.035835  export SHELL=3D/bin/sh
    2023-08-11T14:03:15.036712  #
    2023-08-11T14:03:15.138814  / # export SHELL=3D/bin/sh. /lava-45825/env=
ironment
    2023-08-11T14:03:15.139697  =

    2023-08-11T14:03:15.241873  / # . /lava-45825/environment/lava-45825/bi=
n/lava-test-runner /lava-45825/1
    2023-08-11T14:03:15.243206  =

    2023-08-11T14:03:15.248152  / # /lava-45825/bin/lava-test-runner /lava-=
45825/1
    2023-08-11T14:03:15.349981  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64d63faff76de9695135b1eb

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-770-gddd36cfc4c4c8/arm/omap2plus_defconfig/gcc=
-10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-770-gddd36cfc4c4c8/arm/omap2plus_defconfig/gcc=
-10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d63faff76de9695135b1ee
        failing since 219 days (last pass: v5.10.155-cip21-405-g26d566555c3=
de, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2023-08-11T14:03:15.144741  + set +x
    2023-08-11T14:03:15.146694  <8>[   14.129380] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 995817_1.5.2.4.1>
    2023-08-11T14:03:15.256057  / # #
    2023-08-11T14:03:15.357929  export SHELL=3D/bin/sh
    2023-08-11T14:03:15.358397  #
    2023-08-11T14:03:15.459781  / # export SHELL=3D/bin/sh. /lava-995817/en=
vironment
    2023-08-11T14:03:15.460241  =

    2023-08-11T14:03:15.561655  / # . /lava-995817/environment/lava-995817/=
bin/lava-test-runner /lava-995817/1
    2023-08-11T14:03:15.562414  =

    2023-08-11T14:03:15.564587  / # /lava-995817/bin/lava-test-runner /lava=
-995817/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64d63eebf71f5695e735b26f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-770-gddd36cfc4c4c8/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4=
020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-770-gddd36cfc4c4c8/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4=
020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d63eebf71f5695e735b274
        failing since 112 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-08-11T14:00:02.626652  + set +x<8>[   12.276889] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11263711_1.4.2.3.1>

    2023-08-11T14:00:02.626739  =


    2023-08-11T14:00:02.730766  / # #

    2023-08-11T14:00:02.831404  export SHELL=3D/bin/sh

    2023-08-11T14:00:02.831636  #

    2023-08-11T14:00:02.932201  / # export SHELL=3D/bin/sh. /lava-11263711/=
environment

    2023-08-11T14:00:02.932416  =


    2023-08-11T14:00:03.033191  / # . /lava-11263711/environment/lava-11263=
711/bin/lava-test-runner /lava-11263711/1

    2023-08-11T14:00:03.034848  =


    2023-08-11T14:00:03.039417  / # /lava-11263711/bin/lava-test-runner /la=
va-11263711/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d6418978e809387135b1f1

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-770-gddd36cfc4c4c8/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopu=
s.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-770-gddd36cfc4c4c8/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopu=
s.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d6418978e809387135b1f6
        failing since 113 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-08-11T14:11:25.166460  + <8>[   10.738791] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11263776_1.4.2.3.1>

    2023-08-11T14:11:25.166577  set +x

    2023-08-11T14:11:25.268013  #

    2023-08-11T14:11:25.368885  / # #export SHELL=3D/bin/sh

    2023-08-11T14:11:25.369090  =


    2023-08-11T14:11:25.469617  / # export SHELL=3D/bin/sh. /lava-11263776/=
environment

    2023-08-11T14:11:25.469830  =


    2023-08-11T14:11:25.570346  / # . /lava-11263776/environment/lava-11263=
776/bin/lava-test-runner /lava-11263776/1

    2023-08-11T14:11:25.570678  =


    2023-08-11T14:11:25.575168  / # /lava-11263776/bin/lava-test-runner /la=
va-11263776/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64d63e99861b43f62335b1e2

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-770-gddd36cfc4c4c8/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-770-gddd36cfc4c4c8/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d63e99861b43f62335b1e7
        failing since 112 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-08-11T13:59:11.620191  <8>[   14.115467] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11263697_1.4.2.3.1>

    2023-08-11T13:59:11.623278  + set +x

    2023-08-11T13:59:11.728419  #

    2023-08-11T13:59:11.729750  =


    2023-08-11T13:59:11.831699  / # #export SHELL=3D/bin/sh

    2023-08-11T13:59:11.832806  =


    2023-08-11T13:59:11.934486  / # export SHELL=3D/bin/sh. /lava-11263697/=
environment

    2023-08-11T13:59:11.935268  =


    2023-08-11T13:59:12.036985  / # . /lava-11263697/environment/lava-11263=
697/bin/lava-test-runner /lava-11263697/1

    2023-08-11T13:59:12.038438  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d641a350d4794b1535b1e9

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-770-gddd36cfc4c4c8/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-770-gddd36cfc4c4c8/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d641a350d4794b1535b1ee
        failing since 113 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-08-11T14:11:23.833157  + set +x

    2023-08-11T14:11:23.839715  <8>[   12.783057] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11263796_1.4.2.3.1>

    2023-08-11T14:11:23.942134  =


    2023-08-11T14:11:24.042675  / # #export SHELL=3D/bin/sh

    2023-08-11T14:11:24.042872  =


    2023-08-11T14:11:24.143367  / # export SHELL=3D/bin/sh. /lava-11263796/=
environment

    2023-08-11T14:11:24.143544  =


    2023-08-11T14:11:24.244072  / # . /lava-11263796/environment/lava-11263=
796/bin/lava-test-runner /lava-11263796/1

    2023-08-11T14:11:24.244317  =


    2023-08-11T14:11:24.249335  / # /lava-11263796/bin/lava-test-runner /la=
va-11263796/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64d640230434abb45f35b240

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-770-gddd36cfc4c4c8/arm64/defconfig+kselftest/g=
cc-10/lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-770-gddd36cfc4c4c8/arm64/defconfig+kselftest/g=
cc-10/lab-broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d640230434abb45f35b27c
        failing since 2 days (last pass: v5.10.186-cip37-526-g7640d76efb649=
, first fail: v5.10.186-cip37-566-g36076316ef049)

    2023-08-11T14:04:46.305539  <8>[   34.025147] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 45817_1.5.2.4.1>
    2023-08-11T14:04:46.413694  / # #
    2023-08-11T14:04:46.516531  export SHELL=3D/bin/sh
    2023-08-11T14:04:46.517263  #
    2023-08-11T14:04:46.619207  / # export SHELL=3D/bin/sh. /lava-45817/env=
ironment
    2023-08-11T14:04:46.619939  =

    2023-08-11T14:04:46.721710  / # . /lava-45817/environment/lava-45817/bi=
n/lava-test-runner /lava-45817/1
    2023-08-11T14:04:46.722957  =

    2023-08-11T14:04:46.737646  / # /lava-45817/bin/lava-test-runner /lava-=
45817/1
    2023-08-11T14:04:46.916399  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d64433bd4ab8e82235b1d9

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-770-gddd36cfc4c4c8/arm64/defconfig/gcc-10/lab-=
broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-770-gddd36cfc4c4c8/arm64/defconfig/gcc-10/lab-=
broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d64434bd4ab8e82235b215
        failing since 15 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-08-11T14:22:11.426693  / # #
    2023-08-11T14:22:11.529654  export SHELL=3D/bin/sh
    2023-08-11T14:22:11.530430  #
    2023-08-11T14:22:11.632381  / # export SHELL=3D/bin/sh. /lava-45872/env=
ironment
    2023-08-11T14:22:11.633188  =

    2023-08-11T14:22:11.735600  / # . /lava-45872/environment/lava-45872/bi=
n/lava-test-runner /lava-45872/1
    2023-08-11T14:22:11.736848  =

    2023-08-11T14:22:11.749640  / # /lava-45872/bin/lava-test-runner /lava-=
45872/1
    2023-08-11T14:22:11.810433  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-11T14:22:11.810968  + cd /lava-45872/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64d643d19666ec0c6c35b2c1

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-770-gddd36cfc4c4c8/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-770-gddd36cfc4c4c8/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d643d19666ec0c6c35b2c4
        new failure (last pass: v5.10.184-cip36-10-ga711f789c23e1)

    2023-08-11T14:20:34.685807  + set +x
    2023-08-11T14:20:34.686049  <8>[   87.699390] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 995830_1.5.2.4.1>
    2023-08-11T14:20:34.796501  #
    2023-08-11T14:20:36.267963  / # #export SHELL=3D/bin/sh
    2023-08-11T14:20:36.289259  =

    2023-08-11T14:20:36.289824  / # export SHELL=3D/bin/sh
    2023-08-11T14:20:38.184814  / # . /lava-995830/environment
    2023-08-11T14:20:41.660564  /lava-995830/bin/lava-test-runner /lava-995=
830/1
    2023-08-11T14:20:41.682353  . /lava-995830/environment
    2023-08-11T14:20:41.682781  / # /lava-995830/bin/lava-test-runner /lava=
-995830/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d64678d6b74fa1fd35b1e5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-770-gddd36cfc4c4c8/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-770-gddd36cfc4c4c8/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d64678d6b74fa1fd35b1e8
        failing since 14 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-08-11T14:31:56.334522  + set +x
    2023-08-11T14:31:56.334658  <8>[   83.733097] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 995846_1.5.2.4.1>
    2023-08-11T14:31:56.440293  / # #
    2023-08-11T14:31:57.899400  export SHELL=3D/bin/sh
    2023-08-11T14:31:57.919867  #
    2023-08-11T14:31:57.920040  / # export SHELL=3D/bin/sh
    2023-08-11T14:31:59.801079  / # . /lava-995846/environment
    2023-08-11T14:32:03.251457  /lava-995846/bin/lava-test-runner /lava-995=
846/1
    2023-08-11T14:32:03.272146  . /lava-995846/environment
    2023-08-11T14:32:03.272339  / # /lava-995846/bin/lava-test-runner /lava=
-995846/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64d64028531df46a0f35b1dc

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-770-gddd36cfc4c4c8/arm64/defconfig+kselftest/g=
cc-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-770-gddd36cfc4c4c8/arm64/defconfig+kselftest/g=
cc-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d64028531df46a0f35b1df
        failing since 15 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-08-11T14:04:54.465768  / # #
    2023-08-11T14:04:55.924983  export SHELL=3D/bin/sh
    2023-08-11T14:04:55.945431  #
    2023-08-11T14:04:55.945554  / # export SHELL=3D/bin/sh
    2023-08-11T14:04:57.826688  / # . /lava-995813/environment
    2023-08-11T14:05:01.278888  /lava-995813/bin/lava-test-runner /lava-995=
813/1
    2023-08-11T14:05:01.299467  . /lava-995813/environment
    2023-08-11T14:05:01.299564  / # /lava-995813/bin/lava-test-runner /lava=
-995813/1
    2023-08-11T14:05:01.479134  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-11T14:05:01.479337  + cd /lava-995813/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64d6441032adcb2a2f35b20f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-770-gddd36cfc4c4c8/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-770-gddd36cfc4c4c8/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d6441032adcb2a2f35b212
        failing since 15 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-08-11T14:21:50.152886  / # #
    2023-08-11T14:21:51.611980  export SHELL=3D/bin/sh
    2023-08-11T14:21:51.632467  #
    2023-08-11T14:21:51.632629  / # export SHELL=3D/bin/sh
    2023-08-11T14:21:53.513785  / # . /lava-995831/environment
    2023-08-11T14:21:56.964749  /lava-995831/bin/lava-test-runner /lava-995=
831/1
    2023-08-11T14:21:56.985432  . /lava-995831/environment
    2023-08-11T14:21:56.985545  / # /lava-995831/bin/lava-test-runner /lava=
-995831/1
    2023-08-11T14:21:57.167644  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-11T14:21:57.167893  + cd /lava-995831/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d6467ad6b74fa1fd35b1f0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-770-gddd36cfc4c4c8/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-770-gddd36cfc4c4c8/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d6467ad6b74fa1fd35b1f3
        failing since 15 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-08-11T14:32:07.254940  / # #
    2023-08-11T14:32:08.713948  export SHELL=3D/bin/sh
    2023-08-11T14:32:08.734385  #
    2023-08-11T14:32:08.734523  / # export SHELL=3D/bin/sh
    2023-08-11T14:32:10.615487  / # . /lava-995847/environment
    2023-08-11T14:32:14.065594  /lava-995847/bin/lava-test-runner /lava-995=
847/1
    2023-08-11T14:32:14.086241  . /lava-995847/environment
    2023-08-11T14:32:14.086371  / # /lava-995847/bin/lava-test-runner /lava=
-995847/1
    2023-08-11T14:32:14.167122  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-11T14:32:14.167276  + cd /lava-995847/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64d63f6f51abcac11835b1f4

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-770-gddd36cfc4c4c8/arm64/defconfig+kselftest/g=
cc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-770-gddd36cfc4c4c8/arm64/defconfig+kselftest/g=
cc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d63f6f51abcac11835b1f9
        failing since 15 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-08-11T14:03:38.434959  / # #

    2023-08-11T14:03:38.537083  export SHELL=3D/bin/sh

    2023-08-11T14:03:38.537812  #

    2023-08-11T14:03:38.639167  / # export SHELL=3D/bin/sh. /lava-11263743/=
environment

    2023-08-11T14:03:38.639886  =


    2023-08-11T14:03:38.741277  / # . /lava-11263743/environment/lava-11263=
743/bin/lava-test-runner /lava-11263743/1

    2023-08-11T14:03:38.742385  =


    2023-08-11T14:03:38.759113  / # /lava-11263743/bin/lava-test-runner /la=
va-11263743/1

    2023-08-11T14:03:38.860181  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-11T14:03:38.860692  + cd /lava-11263743/1/tests/1_bootrr
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d643a71d6b1813c635b1da

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-770-gddd36cfc4c4c8/arm64/defconfig/gcc-10/lab-=
collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-770-gddd36cfc4c4c8/arm64/defconfig/gcc-10/lab-=
collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d643a71d6b1813c635b1df
        failing since 15 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-08-11T14:21:39.371505  / # #

    2023-08-11T14:21:39.473628  export SHELL=3D/bin/sh

    2023-08-11T14:21:39.474323  #

    2023-08-11T14:21:39.575647  / # export SHELL=3D/bin/sh. /lava-11263837/=
environment

    2023-08-11T14:21:39.576367  =


    2023-08-11T14:21:39.677744  / # . /lava-11263837/environment/lava-11263=
837/bin/lava-test-runner /lava-11263837/1

    2023-08-11T14:21:39.678800  =


    2023-08-11T14:21:39.695926  / # /lava-11263837/bin/lava-test-runner /la=
va-11263837/1

    2023-08-11T14:21:39.744623  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-11T14:21:39.745159  + cd /lav<8>[   16.407997] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11263837_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 2          =


  Details:     https://kernelci.org/test/plan/id/64d643ce9666ec0c6c35b263

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-770-gddd36cfc4c4c8/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-770-gddd36cfc4c4c8/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/64d643ce9666ec0c6c35b269
        failing since 112 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-08-11T14:20:51.395385  <8>[   43.207763] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-08-11T14:20:52.468990  /lava-11263830/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/64d643ce9666ec0c6c35b26a
        failing since 112 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-08-11T14:20:51.369663  /lava-11263830/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64d645d5250ed4f95335b1dd

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-770-gddd36cfc4c4c8/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-770-gddd36cfc4c4c8/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/64d645d5250ed4f95335b1e3
        failing since 113 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-08-11T14:29:31.909454  <8>[   61.006973] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-08-11T14:29:32.933251  /lava-11263857/1/../bin/lava-test-case

    2023-08-11T14:29:32.944401  <8>[   62.042307] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/64d645d5250ed4f95335b1e4
        failing since 113 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-08-11T14:29:31.897648  /lava-11263857/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d643a91d6b1813c635b1e7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-770-gddd36cfc4c4c8/arm64/defconfig/gcc-10/lab-=
collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-770-gddd36cfc4c4c8/arm64/defconfig/gcc-10/lab-=
collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d643a91d6b1813c635b1ec
        failing since 15 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-08-11T14:21:54.217053  / # #

    2023-08-11T14:21:54.318538  export SHELL=3D/bin/sh

    2023-08-11T14:21:54.319244  #

    2023-08-11T14:21:54.420644  / # export SHELL=3D/bin/sh. /lava-11263839/=
environment

    2023-08-11T14:21:54.421382  =


    2023-08-11T14:21:54.522822  / # . /lava-11263839/environment/lava-11263=
839/bin/lava-test-runner /lava-11263839/1

    2023-08-11T14:21:54.523895  =


    2023-08-11T14:21:54.525830  / # /lava-11263839/bin/lava-test-runner /la=
va-11263839/1

    2023-08-11T14:21:54.569499  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-11T14:21:54.599884  + cd /lava-1126383<8>[   18.308347] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11263839_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

