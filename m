Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B44EB64DC
	for <webhook@archiver.kernel.org>; Tue, 11 Jul 2023 14:33:18 +0000 (UTC)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
 by mx.groups.io with SMTP id smtpd.web11.1103.1689085991019466129
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 11 Jul 2023 07:33:11 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=iIJR7pgL;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.182, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-55ae51a45deso2907344a12.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 11 Jul 2023 07:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689085990; x=1691677990;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dbF90V+kcORro73it0QhHmjstaezd85vQ31KMlBcJE8=;
        b=iIJR7pgLqsbxFd9S/3FvlMxEZKzU2PX4QF+TYxvXg5b55ORBWdhGoP+GC5n5VpUGFH
         yP8UQ3HZO6oAXYgqTANvMftZkciCd88zg3edQ+TJO4x1X6f+2w+NWKeo+ev4dpc+N3mx
         lZeyTOH/JnjDyHCqRoFb8eo8jwVjmoD07z5SxD1Zbn9ZtQVAuh18i0JT5MRPA7QYUQaM
         usUy0q2tJ+IE34f/BRo7QruXc7ORBmuZ/tCnnaou1AuqNB3I8Zl0Q2KBbtzhct1Er45V
         JCEvBi/AeSbraA/zxKnsSs7cxe7jhVbwXmbiPpWvr6WX2IzCQ4lgNiK7/wKQGyzsAAcf
         q3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689085990; x=1691677990;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dbF90V+kcORro73it0QhHmjstaezd85vQ31KMlBcJE8=;
        b=L/+wQCDCqqKu0tmiLYMGHKL8PDMW+eda/UfZsostTImfHiyxknUufT9i6aWyiURWXb
         5oBVxWwoTnkAmhfckzrTLgKb8gix8HMBbXJKhKLX1f7iseLVLFF8WoLzosHCFbY40XEO
         1pcVOgs8C2dfYl8oOZH4RFdgfK7HkqikaUZ2G5C7Pivo+jDX0XpXgQQ0tdF7n9LGQa5Z
         OKmJm8fAlpsQv74XomwKTHePavHEZPvLheTdhU4hyAWKVf6G3CbC2uxkBLm3NpS816ZC
         o+vwXoMbI22zbsbZ/PKIC8Ezm/XBJaLfmJuTU5oUNKU2z2fYrF54+RZ/zBSgqaElSAwW
         jkoQ==
X-Gm-Message-State: ABy/qLZzE/rpxE5MvstvuIjGIiGS0SbSsCv5YZb+w6bbrXmVraAt5PJw
	bI1Hpiq6kYRTqVnNiWcR0NhFoxKKOKb3cZrJsxL4gg==
X-Google-Smtp-Source: APBJJlF7gpfMSQ6SenUk9r0JRsP8v2uUhR1Z2mhvOo6RVhjnyxGGQT3wyo37t8z+yp1HDfOsJp3QcA==
X-Received: by 2002:a17:903:2447:b0:1b8:a70d:412a with SMTP id l7-20020a170903244700b001b8a70d412amr16466264pls.67.1689085989456;
        Tue, 11 Jul 2023 07:33:09 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j6-20020a170902690600b001b9cf6342e2sm2005124plk.42.2023.07.11.07.33.08
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 07:33:08 -0700 (PDT)
Message-ID: <64ad6824.170a0220.1ae9f.3f45@mx.google.com>
Date: Tue, 11 Jul 2023 07:33:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.184-cip36-13-g8201543bbc8b6
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 15 runs,
 11 regressions (v5.10.184-cip36-13-g8201543bbc8b6)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Jul 2023 14:33:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12308

cip-gitlab/ci/pavel/linux-test baseline-nfs: 15 runs, 11 regressions (v5.10=
.184-cip36-13-g8201543bbc8b6)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 2          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 2          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | imx_v6_v=
7_defconfig          | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

mt8173-elm-hana              | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.184-cip36-13-g8201543bbc8b6/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.184-cip36-13-g8201543bbc8b6
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      8201543bbc8b67c2cfc76e71fda24c2e1f8a7920 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 2          =


  Details:     https://kernelci.org/test/plan/id/64ad5fb9526f37feb9bb2a88

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.184-cip36-13-g8201543bbc8b6/arm/omap2plus_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.184-cip36-13-g8201543bbc8b6/arm/omap2plus_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/=
id/64ad5fb9526f37feb9bb2aa3
        new failure (last pass: v6.1.31-65-geef5a19d48f6)

    2023-07-11T13:56:47.482695  /lava-714185/1/../bin/lava-test-case
    2023-07-11T13:56:47.562898  <8>[   52.642755] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64ad5fb9526f37feb9bb2abe
        failing since 27 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-07-11T13:56:40.845562  + set +x
    2023-07-11T13:56:40.849510  <8>[   45.930537] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 714185_1.6.2.4.1>
    2023-07-11T13:56:40.973623  / # #
    2023-07-11T13:56:41.076895  export SHELL=3D/bin/sh
    2023-07-11T13:56:41.077788  #
    2023-07-11T13:56:41.179843  / # export SHELL=3D/bin/sh. /lava-714185/en=
vironment
    2023-07-11T13:56:41.180749  =

    2023-07-11T13:56:41.282897  / # . /lava-714185/environment/lava-714185/=
bin/lava-test-runner /lava-714185/1
    2023-07-11T13:56:41.284308  =

    2023-07-11T13:56:41.287665  / # /lava-714185/bin/lava-test-runner /lava=
-714185/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 2          =


  Details:     https://kernelci.org/test/plan/id/64ad5fcaff0e5b25d3bb2a81

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.184-cip36-13-g8201543bbc8b6/arm/omap2plus_defconfig/gcc-10/lab-cip/b=
aseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.184-cip36-13-g8201543bbc8b6/arm/omap2plus_defconfig/gcc-10/lab-cip/b=
aseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64ad5fcaff0e5b25d3bb2a84
        failing since 27 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-07-11T13:57:08.052298  + set +x
    2023-07-11T13:57:08.056666  <8>[   44.013459] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 985060_1.6.2.4.1>
    2023-07-11T13:57:08.307945  #
    2023-07-11T13:57:08.409657  / # #export SHELL=3D/bin/sh
    2023-07-11T13:57:08.410183  =

    2023-07-11T13:57:08.511438  / # export SHELL=3D/bin/sh. /lava-985060/en=
vironment
    2023-07-11T13:57:08.512014  =

    2023-07-11T13:57:08.613433  / # . /lava-985060/environment/lava-985060/=
bin/lava-test-runner /lava-985060/1
    2023-07-11T13:57:08.614467  =

    2023-07-11T13:57:08.620974  / # /lava-985060/bin/lava-test-runner /lava=
-985060/1 =

    ... (12 line(s) more)  =


  * baseline-nfs.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/=
id/64ad5fcaff0e5b25d3bb2a9f
        new failure (last pass: v6.1.31-65-geef5a19d48f6)

    2023-07-11T13:57:18.928216  /lava-985060/1/../bin/lava-test-case
    2023-07-11T13:57:19.275604  <8>[   55.230825] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ad5e30def370d6bdbb2a77

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.184-cip36-13-g8201543bbc8b6/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.184-cip36-13-g8201543bbc8b6/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64ad5e30def370d6bdbb2a7c
        failing since 27 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-07-11T13:50:56.758951  + <8>[   18.061401] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11061534_1.5.2.3.1>

    2023-07-11T13:50:56.759035  set +x

    2023-07-11T13:50:56.863098  / # #

    2023-07-11T13:50:56.963732  export SHELL=3D/bin/sh

    2023-07-11T13:50:56.963900  #

    2023-07-11T13:50:57.064433  / # export SHELL=3D/bin/sh. /lava-11061534/=
environment

    2023-07-11T13:50:57.064615  =


    2023-07-11T13:50:57.165144  / # . /lava-11061534/environment/lava-11061=
534/bin/lava-test-runner /lava-11061534/1

    2023-07-11T13:50:57.165424  =


    2023-07-11T13:50:57.169787  / # /lava-11061534/bin/lava-test-runner /la=
va-11061534/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ad5e1fb87cfa1d93bb2af7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.184-cip36-13-g8201543bbc8b6/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.184-cip36-13-g8201543bbc8b6/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64ad5e1fb87cfa1d93bb2afc
        failing since 27 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-07-11T13:50:12.932366  + [   20.534142] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 11061517_1.5.2.3.1>

    2023-07-11T13:50:12.935999  set +x

    2023-07-11T13:50:13.043687  / # #

    2023-07-11T13:50:13.145915  export SHELL=3D/bin/sh

    2023-07-11T13:50:13.146743  #

    2023-07-11T13:50:13.248368  / # export SHELL=3D/bin/sh. /lava-11061517/=
environment

    2023-07-11T13:50:13.249145  =


    2023-07-11T13:50:13.350706  / # . /lava-11061517/environment/lava-11061=
517/bin/lava-test-runner /lava-11061517/1

    2023-07-11T13:50:13.351802  =


    2023-07-11T13:50:13.357250  / # /lava-11061517/bin/lava-test-runner /la=
va-11061517/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | imx_v6_v=
7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64ad60e0d9c8c86d50bb2a75

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.184-cip36-13-g8201543bbc8b6/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.184-cip36-13-g8201543bbc8b6/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64ad60e0d9c8c86d5=
0bb2a76
        new failure (last pass: v6.1.31-65-geef5a19d48f6) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64ad628955406c5bd6bb2a94

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.184-cip36-13-g8201543bbc8b6/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.184-cip36-13-g8201543bbc8b6/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64ad628955406c5bd=
6bb2a95
        failing since 27 days (last pass: v6.1.26-1320-g1ddf4b637f785, firs=
t fail: v5.10.182-cip35-8-g2391124f19a70) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64ad61b8de825429ebbb2ab1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.184-cip36-13-g8201543bbc8b6/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/baseline-nfs-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.184-cip36-13-g8201543bbc8b6/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/baseline-nfs-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64ad61b8de825429e=
bbb2ab2
        failing since 27 days (last pass: v6.1.26-1320-g1ddf4b637f785, firs=
t fail: v5.10.182-cip35-8-g2391124f19a70) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64ad621bb0e8c27c40bb2a75

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.184-cip36-13-g8201543bbc8b6/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.184-cip36-13-g8201543bbc8b6/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/64ad621bb0e8c27c40bb2a7b
        failing since 27 days (last pass: v6.1.26-1320-g1ddf4b637f785, firs=
t fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-07-11T14:07:08.963460  /lava-11061667/1/../bin/lava-test-case

    2023-07-11T14:07:08.995023  <8>[   38.056365] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/64ad621bb0e8c27c40bb2a7c
        failing since 27 days (last pass: v6.1.26-1320-g1ddf4b637f785, firs=
t fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-07-11T14:07:07.868808  /lava-11061667/1/../bin/lava-test-case

    2023-07-11T14:07:07.905922  <8>[   36.966456] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =20

