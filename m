Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B5CC05027
	for <webhook@archiver.kernel.org>; Fri, 27 Jan 2023 00:52:46 +0000 (UTC)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
 by mx.groups.io with SMTP id smtpd.web11.91998.1674780758833281756
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 26 Jan 2023 16:52:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=NliVhZdp;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.179, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f179.google.com with SMTP id 78so2264918pgb.8
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 26 Jan 2023 16:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qGXVgWoysiDE+sUx8xVwnT609zwe+0heOfxIV47nU0o=;
        b=NliVhZdpc746hoycTQBFEeGXDNhXF+4echQvpSfdT6VZcfPZHqKlkMLjlal7mZz4Hx
         E2qZLSeosmGe0nhBfY/iJ2iLTQnFHNo6ykxXtOTsYts8017YYiPQGOoIaKkI5g3lT6g1
         NyG0oFlhFxCG7DY9Xyq2GG8AeaAEljVTDdoC/qadHin1gsz6jA2egyIkVqsm8ClIeJsf
         KGSDvXiKLLQzB8WjQflJNAZVze5FNWeKIRe/0LRpGtI3IjQapFXMMqiYLZpdZ3eGUlFE
         9b2eO4+rrlqwXNrBynsrs1IaTRHwalDNoo6iX5CnbLeGdpmHNvEmtawkQCN371QyiMnm
         mrAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qGXVgWoysiDE+sUx8xVwnT609zwe+0heOfxIV47nU0o=;
        b=Ttt/JMWtQV03D/7NqNHNHi3T4TdAQNXV6HUgEYbWnJ8mDmccJebiQ1TNjrBcIeXk9z
         WRJpIP6yL3Q6wtUHih2ZnydtdV8J0hF7BR6sK6hE+rEmhpzJqIixlmc5IQdniBNgpFeo
         RXPmtEAVxCN9rs6fso3YfpgFxk7ZyhW3VySISkJzYDsTS57Ak9mqEXgNdzqm6I9kfrUD
         mHsRt/CDUVVBK276UzJJwSMdjicXEXhNoqb3Rlr2xCSinj8CYWj5CnWCpcFJsNbTOtvW
         nZgy7KtgoFZysJWTpSIF5FBW6NqEnHcZN9BGSNN54D3JyRCfFr0Z6WMp2lD32b9w2X8N
         iH9w==
X-Gm-Message-State: AFqh2krCfiCwktdEyYJYqXYIxPuyJtYTSDJMFxrcx6aEGKKBQJYdEvLp
	Q014IuhxAStrtBclHaYL0USRXdmwbhB7d33cvgs=
X-Google-Smtp-Source: AMrXdXvFqqDtjRseyh/h70jMjCriiGq8ww9OaE5M23raH4bjj/bh95rUGFOtxk/hif41p5jU3cvZ+Q==
X-Received: by 2002:aa7:874c:0:b0:58d:a1e9:36d with SMTP id g12-20020aa7874c000000b0058da1e9036dmr36651872pfo.31.1674780757388;
        Thu, 26 Jan 2023 16:52:37 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id r30-20020aa79ede000000b00582388bd80csm1427450pfq.83.2023.01.26.16.52.36
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 16:52:36 -0800 (PST)
Message-ID: <63d32054.a70a0220.5bbc4.26cb@mx.google.com>
Date: Thu, 26 Jan 2023 16:52:36 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v5.10.162-cip24-443-g1f8fb81fe752
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 47 runs,
 19 regressions (v5.10.162-cip24-443-g1f8fb81fe752)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 27 Jan 2023 00:52:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10485

cip-gitlab/ci/pavel/linux-test baseline-nfs: 47 runs, 19 regressions (v5.10=
.162-cip24-443-g1f8fb81fe752)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

imx6dl-udoo                  | arm    | lab-broonie   | gcc-10   | imx_v6_v=
7_defconfig          | 1          =

imx6dl-udoo                  | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =

imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | imx_v6_v=
7_defconfig          | 1          =

imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

meson-g12b-a311d-khadas-vim3 | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 4          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.162-cip24-443-g1f8fb81fe752/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.162-cip24-443-g1f8fb81fe752
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      1f8fb81fe7523922b7ff40bbacc9ac4aa9e11796 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63d317fdd362caecaa915edd

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230120.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63d317fdd362caecaa915ee2
        failing since 8 days (last pass: v5.10.158-cip22-435-g2c52868ae1cbc=
, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-27T00:16:48.029122  <8>[   10.851044] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 8893615_1.5.2.3.1>
    2023-01-27T00:16:48.131145  <6>[#
    2023-01-27T00:16:48.131435     10.868077] lava-test-runne (271) used gr=
eatest stack depth: 13016 bytes left
    2023-01-27T00:16:48.232249  / # #export SHELL=3D/bin/sh
    2023-01-27T00:16:48.232457  =

    2023-01-27T00:16:48.333371  / # export SHELL=3D/bin/sh. /lava-8893615/e=
nvironment
    2023-01-27T00:16:48.333609  =

    2023-01-27T00:16:48.434305  / # . /lava-8893615/environment/lava-889361=
5/bin/lava-test-runner /lava-8893615/1
    2023-01-27T00:16:48.434596  =

    2023-01-27T00:16:48.440150  / # /lava-8893615/bin/lava-test-runner /lav=
a-8893615/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63d3189db3bfc9378f915ed2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230120.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63d3189db3bfc9378f915ed7
        failing since 8 days (last pass: v5.10.158-cip22-435-g2c52868ae1cbc=
, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-27T00:19:16.048615  + set +x
    2023-01-27T00:19:16.055051  <8>[   16.461158] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 8893599_1.5.2.3.1>
    2023-01-27T00:19:16.160721  / # #
    2023-01-27T00:19:16.263678  export SHELL=3D/bin/sh
    2023-01-27T00:19:16.264563  #
    2023-01-27T00:19:16.366488  / # export SHELL=3D/bin/sh. /lava-8893599/e=
nvironment
    2023-01-27T00:19:16.367252  =

    2023-01-27T00:19:16.469014  / # . /lava-8893599/environment/lava-889359=
9/bin/lava-test-runner /lava-8893599/1
    2023-01-27T00:19:16.470307  =

    2023-01-27T00:19:16.475672  / # /lava-8893599/bin/lava-test-runner /lav=
a-8893599/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63d319818d95f2467d915ed0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm/multi_v5_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm/multi_v5_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230120.0/armel/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63d319818d95f2467=
d915ed1
        new failure (last pass: v4.19.269-cip88-rt28-rebase) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63d3199b8d95f2467d915eec

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230120.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63d3199b8d95f2467d915ef1
        failing since 8 days (last pass: v5.10.158-cip22-435-g2c52868ae1cbc=
, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-27T00:23:28.766241  <8>[   50.774272] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 188266_1.6.2.4.1>
    2023-01-27T00:23:28.879786  / # #
    2023-01-27T00:23:28.981755  export SHELL=3D/bin/sh
    2023-01-27T00:23:28.982323  #
    2023-01-27T00:23:29.083991  / # export SHELL=3D/bin/sh. /lava-188266/en=
vironment
    2023-01-27T00:23:29.084537  =

    2023-01-27T00:23:29.186315  / # . /lava-188266/environment/lava-188266/=
bin/lava-test-runner /lava-188266/1
    2023-01-27T00:23:29.187535  =

    2023-01-27T00:23:29.191623  / # /lava-188266/bin/lava-test-runner /lava=
-188266/1
    2023-01-27T00:23:29.386595  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63d31953f6392e0f20915eb9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm/multi_v7_defconfig/gcc-10/lab-cip/ba=
seline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm/multi_v7_defconfig/gcc-10/lab-cip/ba=
seline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230120.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63d31953f6392e0f20915ebc
        failing since 8 days (last pass: v5.10.158-cip22-435-g2c52868ae1cbc=
, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-27T00:22:36.126881  [   44.218807] <LAVA_SIGNAL_ENDRUN 0_dmesg =
834176_1.6.2.4.1>
    2023-01-27T00:22:36.241597  / # #
    2023-01-27T00:22:36.343428  export SHELL=3D/bin/sh
    2023-01-27T00:22:36.343877  #
    2023-01-27T00:22:36.445273  / # export SHELL=3D/bin/sh. /lava-834176/en=
vironment
    2023-01-27T00:22:36.445936  =

    2023-01-27T00:22:36.547438  / # . /lava-834176/environment/lava-834176/=
bin/lava-test-runner /lava-834176/1
    2023-01-27T00:22:36.548284  =

    2023-01-27T00:22:36.550295  / # /lava-834176/bin/lava-test-runner /lava=
-834176/1
    2023-01-27T00:22:36.747807  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63d31a8ac4fe7509eb915ee5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm/omap2plus_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm/omap2plus_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230120.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63d31a8ac4fe7509eb915eea
        new failure (last pass: v4.19.269-cip88-rt28-rebase)

    2023-01-27T00:27:29.936059  [   47.613823] <LAVA_SIGNAL_ENDRUN 0_dmesg =
188285_1.6.2.4.1>
    2023-01-27T00:27:30.069430  / # #
    2023-01-27T00:27:30.171363  export SHELL=3D/bin/sh
    2023-01-27T00:27:30.171889  #
    2023-01-27T00:27:30.273351  / # export SHELL=3D/bin/sh. /lava-188285/en=
vironment
    2023-01-27T00:27:30.273837  =

    2023-01-27T00:27:30.375298  / # . /lava-188285/environment/lava-188285/=
bin/lava-test-runner /lava-188285/1
    2023-01-27T00:27:30.375914  =

    2023-01-27T00:27:30.380797  / # /lava-188285/bin/lava-test-runner /lava=
-188285/1
    2023-01-27T00:27:30.640836  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6dl-udoo                  | arm    | lab-broonie   | gcc-10   | imx_v6_v=
7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63d31dd2cdc4ce24ce915ecf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230120.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63d31dd2cdc4ce24c=
e915ed0
        new failure (last pass: v4.19.269-cip88-rt28-rebase) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6dl-udoo                  | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63d31c57065d64a013915ed4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230120.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63d31c57065d64a01=
3915ed5
        new failure (last pass: v4.19.269-cip88-rt28-rebase) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63d318a7b3bfc9378f915f06

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm/multi_v7_defconfig/gcc-10/lab-collab=
ora/baseline-nfs-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm/multi_v7_defconfig/gcc-10/lab-collab=
ora/baseline-nfs-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230120.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63d318a7b3bfc9378f915f0b
        failing since 8 days (last pass: v5.10.158-cip22-435-g2c52868ae1cbc=
, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-27T00:19:42.360849  + set +x
    2023-01-27T00:19:42.396156  / # [   25.844922] <LAVA_SIGNAL_TESTCASE TE=
ST_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-01-27T00:19:42.396245  [   25.845854] <LAVA_SIGNAL_ENDRUN 0_dmesg =
8893640_1.6.2.4.1>
    2023-01-27T00:19:42.498769  #
    2023-01-27T00:19:42.601812  export SHELL=3D/bin/sh
    2023-01-27T00:19:42.602664  #
    2023-01-27T00:19:42.704782  / # export SHELL=3D/bin/sh. /lava-8893640/e=
nvironment
    2023-01-27T00:19:42.705634  =

    2023-01-27T00:19:42.807806  / # . /lava-8893640/environment/lava-889364=
0/bin/lava-test-runner /lava-8893640/1
    2023-01-27T00:19:42.809112   =

    ... (17 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | imx_v6_v=
7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63d31e0ebb6b1dc9cf915ed2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230120.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63d31e0ebb6b1dc9c=
f915ed3
        new failure (last pass: v4.19.269-cip88-rt28-rebase) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63d31ca6049e57eb96915ec5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230120.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63d31ca6049e57eb9=
6915ec6
        new failure (last pass: v4.19.269-cip88-rt28-rebase) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63d318f628bec4483e915ee7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm64/defconfig/gcc-10/lab-baylibre/base=
line-nfs-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm64/defconfig/gcc-10/lab-baylibre/base=
line-nfs-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230120.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63d318f628bec4483=
e915ee8
        failing since 84 days (last pass: v5.10.145-518-gc75907dbbb95a, fir=
st fail: v5.10.147-cip18-12-gcb2b164780be) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63d31ad74ec094f3a5915ebb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm64/defconfig/gcc-10/lab-baylibre/base=
line-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm64/defconfig/gcc-10/lab-baylibre/base=
line-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230120.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63d31ad74ec094f3a=
5915ebc
        failing since 8 days (last pass: v5.10.158-cip22-435-g2c52868ae1cbc=
, first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63d318a90c0619d336915f10

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230120.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63d318a90c0619d33=
6915f11
        failing since 8 days (last pass: v5.10.158-cip22-435-g2c52868ae1cbc=
, first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 4          =


  Details:     https://kernelci.org/test/plan/id/63d31926ffc9696247915ec6

  Results:     86 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230120.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rk3399-gru-sound-driver-rt5514-present: https://ker=
nelci.org/test/case/id/63d31926ffc9696247915efd
        failing since 8 days (last pass: v5.10.158-cip22-435-g2c52868ae1cbc=
, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-27T00:21:37.754263  <8>[   91.250468] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-max98357A-present RESULT=3Dfail>
    2023-01-27T00:21:37.754518  =

    2023-01-27T00:21:37.762521  seq: invalid floating point argument: =E2=
=80=98sound/RT5514=E2=80=99
    2023-01-27T00:21:37.765836  Try 'seq --help' for more information.
    2023-01-27T00:21:37.770032  /lava-8893669/1/../bin/lava-test-case
    2023-01-27T00:21:37.790360  <8>[   91.288112] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-rt5514-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-max98357A-present: https://=
kernelci.org/test/case/id/63d31926ffc9696247915efe
        failing since 8 days (last pass: v5.10.158-cip22-435-g2c52868ae1cbc=
, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-27T00:21:37.702500  <8>[   91.200158] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-dp-present RESULT=3Dfail>
    2023-01-27T00:21:37.702803  =

    2023-01-27T00:21:37.725081  seq: invalid floating point argument: =E2=
=80=98sound/MAX98357A=E2=80=99
    2023-01-27T00:21:37.728493  Try 'seq --help' for more information.
    2023-01-27T00:21:37.729247  =

    2023-01-27T00:21:37.732548  /lava-8893669/1/../bin/lava-test-case   =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-dp-present: https://kernelc=
i.org/test/case/id/63d31926ffc9696247915eff
        failing since 8 days (last pass: v5.10.158-cip22-435-g2c52868ae1cbc=
, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-27T00:21:37.672747  seq: invalid floating point argument: =E2=
=80=98sound/DP=E2=80=99
    2023-01-27T00:21:37.675935  Try 'seq --help' for more information.
    2023-01-27T00:21:37.676365  =

    2023-01-27T00:21:37.679946  /lava-8893669/1/../bin/lava-test-case   =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-da7219-present: https://ker=
nelci.org/test/case/id/63d31926ffc9696247915f00
        failing since 8 days (last pass: v5.10.158-cip22-435-g2c52868ae1cbc=
, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-27T00:21:37.622650  seq: invalid floating point argument: =E2=
=80=98sound/DA7219=E2=80=99
    2023-01-27T00:21:37.622917  =

    2023-01-27T00:21:37.626289  Try 'seq --help' for more information.
    2023-01-27T00:21:37.630026  /lava-8893669/1/../bin/lava-test-case
    2023-01-27T00:21:37.630718  =

    2023-01-27T00:21:37.650276  <8>[   91.148208] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-da7219-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63d318fb799ef21758915f33

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-nfs-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-nfs-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230120.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63d318fb799ef21758915f38
        failing since 8 days (last pass: v5.10.158-cip22-435-g2c52868ae1cbc=
, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-27T00:20:59.634079  [   29.052538] <LAVA_SIGNAL_ENDRUN 0_dmesg =
188169_1.6.2.4.1>#
    2023-01-27T00:20:59.634843  =

    2023-01-27T00:20:59.736427  / # #export SHELL=3D/bin/sh
    2023-01-27T00:20:59.737098  =

    2023-01-27T00:20:59.838828  / # export SHELL=3D/bin/sh. /lava-188169/en=
vironment
    2023-01-27T00:20:59.839427  =

    2023-01-27T00:20:59.940879  / # . /lava-188169/environment/lava-188169/=
bin/lava-test-runner /lava-188169/1
    2023-01-27T00:20:59.941597  =

    2023-01-27T00:20:59.945037  / # /lava-188169/bin/lava-test-runner /lava=
-188169/1
    2023-01-27T00:21:00.064229  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =20

