Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E205CC001B0
	for <webhook@archiver.kernel.org>; Sat, 15 Jul 2023 02:01:09 +0000 (UTC)
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
 by mx.groups.io with SMTP id smtpd.web10.4485.1689386469358633057
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 14 Jul 2023 19:01:09 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=N44dW6KX;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.160.44, mailfrom: bot@kernelci.org)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1b8eb69d641so1813010fac.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 14 Jul 2023 19:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689386468; x=1691978468;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KlZRYupaDKJuabXxN71CQUTAyNTswdkbda9o3WpvXMw=;
        b=N44dW6KXoQc9EL1Vlt0kbtEfIKpLSeAOv/vahr5MhPBr+zeW55PALz0AaHCYFBYksP
         rs1/G2Y3B6LqGnlvauNb65XPkGXLCN/oKeZdWwTTKHq0XdOUE5mvoFYaALxHKme+E981
         tOBGvPGvoY3Yqdf8WTX1qgUOwyQ1nCXXlHHI0oU//SfhJkaCyc7gQ/l3gTHgXta5ZBir
         xCZJQxzOWGfP048lFHsp3u4i9pYdm8uLJfr+jMwPVJuxwrnSfN8Svct6aqYYG6ufAgaQ
         MGi5EPXk8lwU8jHDtVgDAjJD8RcmZ4+44tVhhcAS65qe0Pt5kC1+mwaDMa+uN/GhUZ/7
         JkwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689386468; x=1691978468;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KlZRYupaDKJuabXxN71CQUTAyNTswdkbda9o3WpvXMw=;
        b=XyUR7vnO5QbMSAvMGQxS7m7TZr8zIO/0pIrPLO18BXR7oz68r868y0lhBDt8T6KfJu
         DY32xyqrcbprXbSs9IrbgUOL3qfIDQtQ7anFPInAnfOqMDmP0I8bhYiJM593iGP/JouE
         SioF7I4ExwElwlHJkSKtIZwLFpDm3Zb83U1zqjWm+pmzEQoAXw2fZKxxIwmgCgXJNllg
         Bn/1mImcsl/1PncUq57Ypf3hDIuHdPS2RPBnApTwJHZs+2A/wlFF9k5LBxorS34Qb9MZ
         M+UOLsPTcBqyQFm46QSlD2KiUMFwSCJVgUbM8v2NjhswPrcxqpHSe6VdxahyaJUyRPsB
         w09g==
X-Gm-Message-State: ABy/qLYIrU0b4eS49H0uN1TF0QASRDpqVSPT6taIfrJTQN68Ua9KOamZ
	ZlKQzpRSAbp7EFJXytGSnvpp+u4T9ItVCj9K3AhBVw==
X-Google-Smtp-Source: APBJJlFHHdoGmuH1xP4K/rLqbzZQlB2H4kA8axwF/N2wnE45RAcVftMxR1Cvde4B4OCxPsRu2wxVBA==
X-Received: by 2002:a05:6870:d288:b0:1b7:5ec6:80e1 with SMTP id d8-20020a056870d28800b001b75ec680e1mr7152927oae.55.1689386467916;
        Fri, 14 Jul 2023 19:01:07 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ji19-20020a170903325300b001b7cbc5871csm8430176plb.53.2023.07.14.19.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 19:01:07 -0700 (PDT)
Message-ID: <64b1fde3.170a0220.7559b.2ea3@mx.google.com>
Date: Fri, 14 Jul 2023 19:01:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Kernel: v5.10.186-cip37-rt15
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip-rt baseline-nfs: 29 runs,
 9 regressions (v5.10.186-cip37-rt15)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 15 Jul 2023 02:01:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12355

cip/linux-5.10.y-cip-rt baseline-nfs: 29 runs, 9 regressions (v5.10.186-cip=
37-rt15)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =

imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.186-cip37-rt15/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.186-cip37-rt15
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      db05335d4d4ee47b8fc64652b2c2ad8e57eeaf52 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/64b1f431d1f6807b5a8ace1c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64b1f431d1f6807b5a8ace21
        failing since 169 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-07-15T01:19:31.102939  + set +x

    2023-07-15T01:19:31.108353  <8>[   17.331212] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11090608_1.5.2.3.1>

    2023-07-15T01:19:31.216639  / # #

    2023-07-15T01:19:31.319249  export SHELL=3D/bin/sh

    2023-07-15T01:19:31.320037  #

    2023-07-15T01:19:31.421832  / # export SHELL=3D/bin/sh. /lava-11090608/=
environment

    2023-07-15T01:19:31.422617  =


    2023-07-15T01:19:31.524148  / # . /lava-11090608/environment/lava-11090=
608/bin/lava-test-runner /lava-11090608/1

    2023-07-15T01:19:31.524708  =


    2023-07-15T01:19:31.526335  / # /lava-11090608/bin/lava-test-runner /la=
va-11090608/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/64b1f56fb0e39d51148ace76

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64b1f56fb0e39d51148ace7b
        failing since 169 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-07-15T01:24:50.609901  + set +x

    2023-07-15T01:24:50.615593  [   19.182950] <LAVA_SIGNAL_ENDRUN 0_dmesg =
11090678_1.5.2.3.1>

    2023-07-15T01:24:50.723018  / #

    2023-07-15T01:24:50.825867  # #export SHELL=3D/bin/sh

    2023-07-15T01:24:50.826649  =


    2023-07-15T01:24:50.928378  / # export SHELL=3D/bin/sh. /lava-11090678/=
environment

    2023-07-15T01:24:50.929199  =


    2023-07-15T01:24:51.030774  / # . /lava-11090678/environment/lava-11090=
678/bin/lava-test-runner /lava-11090678/1

    2023-07-15T01:24:51.031977  =


    2023-07-15T01:24:51.034546  / # /lava-11090678/bin/lava-test-runner /la=
va-11090678/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64b1eedd0e0ad887518ace24

  Results:     30 PASS, 8 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-beagl=
ebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-beagl=
ebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64b1eedd0e0ad887518ace48
        failing since 168 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-07-15T00:55:44.243467  <8>[   76.794623] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 720553_1.6.2.4.1>
    2023-07-15T00:55:44.429546  #
    2023-07-15T00:55:44.532558  / # #export SHELL=3D/bin/sh
    2023-07-15T00:55:44.533194  =

    2023-07-15T00:55:44.634763  / # export SHELL=3D/bin/sh. /lava-720553/en=
vironment
    2023-07-15T00:55:44.635599  =

    2023-07-15T00:55:44.737522  / # . /lava-720553/environment/lava-720553/=
bin/lava-test-runner /lava-720553/1
    2023-07-15T00:55:44.738790  =

    2023-07-15T00:55:44.741864  / # /lava-720553/bin/lava-test-runner /lava=
-720553/1
    2023-07-15T00:55:45.070252  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64b1ef8eaa2bde27238ace21

  Results:     30 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebon=
e-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebon=
e-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64b1ef8eaa2bde27238ace24
        failing since 168 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-07-15T00:59:22.678710  + set +x
    2023-07-15T00:59:22.794737  TEST_CASE_ID=3Demerg RESULT=3Dpass UNITS=3D=
lines MEASUREMENT=3D0>
    2023-07-15T00:59:22.794994  =

    2023-07-15T00:59:22.795239  <8>[   43.796102] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 986260_1.6.2.4.1>
    2023-07-15T00:59:22.896895  / # #export SHELL=3D/bin/sh
    2023-07-15T00:59:22.897357  =

    2023-07-15T00:59:22.998769  / # export SHELL=3D/bin/sh. /lava-986260/en=
vironment
    2023-07-15T00:59:22.999339  =

    2023-07-15T00:59:23.100748  / # . /lava-986260/environment/lava-986260/=
bin/lava-test-runner /lava-986260/1
    2023-07-15T00:59:23.101512   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64b1f589ddbba9120a8ace76

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nfs-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nfs-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64b1f589ddbba9120a8aceac
        failing since 114 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.175-cip29-rt12)

    2023-07-15T01:25:14.601941  <8>[   47.327904] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 720585_1.6.2.4.1>
    2023-07-15T01:25:14.718539  / # #
    2023-07-15T01:25:14.820697  export SHELL=3D/bin/sh
    2023-07-15T01:25:14.821399  #
    2023-07-15T01:25:14.923190  / # export SHELL=3D/bin/sh. /lava-720585/en=
vironment
    2023-07-15T01:25:14.923770  =

    2023-07-15T01:25:15.025716  / # . /lava-720585/environment/lava-720585/=
bin/lava-test-runner /lava-720585/1
    2023-07-15T01:25:15.026989  =

    2023-07-15T01:25:15.030405  / # /lava-720585/bin/lava-test-runner /lava=
-720585/1
    2023-07-15T01:25:15.254164  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64b1f57de8336e173d8ace1d

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebo=
ne-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebo=
ne-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64b1f57de8336e173d8ace20
        failing since 114 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.175-cip29-rt12)

    2023-07-15T01:24:56.625750  <8>[   39.160163] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 986267_1.6.2.4.1>
    2023-07-15T01:24:56.741040  #
    2023-07-15T01:24:56.843180  / # #export SHELL=3D/bin/sh
    2023-07-15T01:24:56.843631  =

    2023-07-15T01:24:56.945039  / # export SHELL=3D/bin/sh. /lava-986267/en=
vironment
    2023-07-15T01:24:56.945612  =

    2023-07-15T01:24:57.047029  / # . /lava-986267/environment/lava-986267/=
bin/lava-test-runner /lava-986267/1
    2023-07-15T01:24:57.047788  =

    2023-07-15T01:24:57.049691  / # /lava-986267/bin/lava-test-runner /lava=
-986267/1
    2023-07-15T01:24:57.291546  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/64b1f43fd1f6807b5a8ace46

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64b1f43fd1f6807b5a8ace4b
        failing since 57 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v5.10.179-cip32-rt13)

    2023-07-15T01:20:10.153779  + set +x<8>[   14.958161] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11090631_1.5.2.3.1>

    2023-07-15T01:20:10.154345  =


    2023-07-15T01:20:10.262100  / # #

    2023-07-15T01:20:10.364586  export SHELL=3D/bin/sh

    2023-07-15T01:20:10.365383  #

    2023-07-15T01:20:10.467105  / # export SHELL=3D/bin/sh. /lava-11090631/=
environment

    2023-07-15T01:20:10.467970  =


    2023-07-15T01:20:10.569754  / # . /lava-11090631/environment/lava-11090=
631/bin/lava-test-runner /lava-11090631/1

    2023-07-15T01:20:10.571000  =


    2023-07-15T01:20:10.576161  / # /lava-11090631/bin/lava-test-runner /la=
va-11090631/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/64b1f573aab5774d708ace72

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64b1f573aab5774d708ace77
        failing since 57 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v5.10.179-cip32-rt13)

    2023-07-15T01:24:54.742345  [ #

    2023-07-15T01:24:54.742637    20.847006] <LAVA_SIGNAL_ENDRUN 0_dmesg 11=
090688_1.5.2.3.1>

    2023-07-15T01:24:54.843314  / # #export SHELL=3D/bin/sh

    2023-07-15T01:24:54.843599  =


    2023-07-15T01:24:54.944141  / # export SHELL=3D/bin/sh. /lava-11090688/=
environment

    2023-07-15T01:24:54.944375  =


    2023-07-15T01:24:55.044962  / # . /lava-11090688/environment/lava-11090=
688/bin/lava-test-runner /lava-11090688/1

    2023-07-15T01:24:55.045211  =


    2023-07-15T01:24:55.049980  / # /lava-11090688/bin/lava-test-runner /la=
va-11090688/1

    2023-07-15T01:24:55.129228  + export TESTRUN_ID=3D1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64b1f5c10a46ea7d148ace1c

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/arm/defconfig/gcc-10/lab-collabora/baseline-nfs-imx6q-sabrel=
ite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/arm/defconfig/gcc-10/lab-collabora/baseline-nfs-imx6q-sabrel=
ite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64b1f5c10a46ea7d148ace21
        failing since 169 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-07-15T01:26:14.946351  + set +x

    2023-07-15T01:26:14.982170  / # <8>[   28.640625] <LAVA_SIGNAL_TESTCASE=
 TEST_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-07-15T01:26:14.982457  <8>[   28.641566] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11090657_1.6.2.4.1>

    2023-07-15T01:26:15.087173  #

    2023-07-15T01:26:15.189689  export SHELL=3D/bin/sh

    2023-07-15T01:26:15.190422  #

    2023-07-15T01:26:15.292226  / # export SHELL=3D/bin/sh. /lava-11090657/=
environment

    2023-07-15T01:26:15.292960  =


    2023-07-15T01:26:15.394709  / # . /lava-11090657/environment/lava-11090=
657/bin/lava-test-runner /lava-11090657/1

    2023-07-15T01:26:15.395909  =

 =

    ... (17 line(s) more)  =

 =20

