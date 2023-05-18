Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B04C77B7D
	for <webhook@archiver.kernel.org>; Thu, 18 May 2023 22:55:54 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web11.6571.1684450549791342864
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 18 May 2023 15:55:49 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=krwVrRWC;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.170, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-64d11974b45so1054275b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 18 May 2023 15:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684450548; x=1687042548;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YorXOgQmM+fsX5c3ox/GHwYAAX20oR/5I8ODmVmaUKg=;
        b=krwVrRWChDp5rgwx5dAMAchpLmzNgMYgNrO6FCxdDnevy1pC8PdYMdBn1TtTc+X7ne
         1ZFwa05VPynf/KDmEJRJtHIQ0gttzukoQRXN7KmDkaRVUUEBgtO7Snr9P3nWf49cxBAX
         7AZ+LU5TZ79t2K3A51+eJQnJOcLFx6szrnjIuAQjRJdMRv8nP7Ij/rblSRKhNg1Bq1nJ
         l0oBIk/s7kJnG+Qpa2P1QMAoZiaJmPQFvlC/Mu1WG2JQ1pe5JIKK5zj9GHjqZqUW65ls
         WK5T9/6W70f7sQ911kDhBiYTSeEjUEJk3068Givu/GyUOTt9GCzHQVoW+mRwb0oFTvxC
         AzLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684450548; x=1687042548;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YorXOgQmM+fsX5c3ox/GHwYAAX20oR/5I8ODmVmaUKg=;
        b=jZZUGWYFsv+2DZTfvAo7JaxFUFgcLbmkcCiI7ukUeODMr0+z5E0mNFMZttKLWbGFum
         WeStjmU6Fplv4SoAB6Dzf8TxGekGPWg+u1ersJm1KpIK+aVVGM30YEmfsY8q9tFnZ0Qp
         ry5eQ35e1nz1ckeZtVmpv7HpkH98zg/RIRZX2osEAWeDyF1OVWsdk4fmjWaO/SKRDHQC
         KsmjTH1wyiPWEPK3glYCvzJf1B4Jin6ck7fp4SFt7VObTp4tJBagdzFYuEI9vww3UNsa
         HbEStng5pNFeiOrgFfOi8IKwFJK1a7eI9XIOXbOz3ymLwDB5whYtIcG+XBxyhE0T7INJ
         RKew==
X-Gm-Message-State: AC+VfDwatHfvUCU01CXRi+KgEilDXBXJWLxEyBlpCmiVc76NsRYYJ+mV
	yKd2+FbOHlHXmqJbhGQ31omHfNh2+54VqoehcqeAug==
X-Google-Smtp-Source: ACHHUZ4Sol/dw0Chf3fpLhquoDs2CVBpYqzVy077Gg2rcbEHTqN1RAlrHC1pTp1grdgCerlt9tJhCQ==
X-Received: by 2002:a05:6a20:3d1c:b0:102:a593:a158 with SMTP id y28-20020a056a203d1c00b00102a593a158mr1505138pzi.47.1684450548214;
        Thu, 18 May 2023 15:55:48 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u5-20020aa78485000000b0064358d032a4sm1872139pfn.145.2023.05.18.15.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 15:55:47 -0700 (PDT)
Message-ID: <6466acf3.a70a0220.26cc7.3d39@mx.google.com>
Date: Thu, 18 May 2023 15:55:47 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.179-cip32-rt13
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip-rt baseline-nfs: 43 runs,
 11 regressions (v5.10.179-cip32-rt13)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 May 2023 22:55:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11527

cip/linux-5.10.y-cip-rt baseline-nfs: 43 runs, 11 regressions (v5.10.179-ci=
p32-rt13)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

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

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+preempt_rt         | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.179-cip32-rt13/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.179-cip32-rt13
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      1f0aef82759c2eef50bcbfaab1bad1aaa64a721c =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/6466acd3ccd936fa462e85e6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-nfs-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-nfs-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6466acd3ccd936fa462e85eb
        failing since 111 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-05-18T22:54:57.098155  <6>[   15.175141] sh (284) used greatest st=
ack depth: 12344 bytes left

    2023-05-18T22:54:57.104742  <8>[   15.175186] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10379781_1.5.2.3.1>

    2023-05-18T22:54:57.209208  / # #

    2023-05-18T22:54:57.309953  export SHELL=3D/bin/sh

    2023-05-18T22:54:57.310156  #

    2023-05-18T22:54:57.410680  / # export SHELL=3D/bin/sh. /lava-10379781/=
environment

    2023-05-18T22:54:57.410873  =


    2023-05-18T22:54:57.511420  / # . /lava-10379781/environment/lava-10379=
781/bin/lava-test-runner /lava-10379781/1

    2023-05-18T22:54:57.511793  =


    2023-05-18T22:54:57.516550  / # /lava-10379781/bin/lava-test-runner /la=
va-10379781/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/6466a255cf9135439e2e85f3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6466a255cf9135439e2e85f8
        failing since 111 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-05-18T22:10:17.050333  + set +x

    2023-05-18T22:10:17.056627  <8>[   29.199556] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10380094_1.5.2.3.1>

    2023-05-18T22:10:17.241678  / # #

    2023-05-18T22:10:17.342702  export SHELL=3D/bin/sh

    2023-05-18T22:10:17.343113  #

    2023-05-18T22:10:17.444021  / # export SHELL=3D/bin/sh. /lava-10380094/=
environment

    2023-05-18T22:10:17.444729  =


    2023-05-18T22:10:17.546106  / # . /lava-10380094/environment/lava-10380=
094/bin/lava-test-runner /lava-10380094/1

    2023-05-18T22:10:17.547928  =


    2023-05-18T22:10:17.552630  / # /lava-10380094/bin/lava-test-runner /la=
va-10380094/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/64669e9c6ce9341fad2e85f2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64669e9c6ce9341fad2e85f7
        failing since 111 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-05-18T21:54:28.734364  + set +x

    2023-05-18T21:54:28.740706  <8>[   18.711294] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10379744_1.5.2.3.1>

    2023-05-18T21:54:28.844459  #

    2023-05-18T21:54:28.945278  / # #export SHELL=3D/bin/sh

    2023-05-18T21:54:28.945480  =


    2023-05-18T21:54:29.045983  / # export SHELL=3D/bin/sh. /lava-10379744/=
environment

    2023-05-18T21:54:29.046172  =


    2023-05-18T21:54:29.146670  / # . /lava-10379744/environment/lava-10379=
744/bin/lava-test-runner /lava-10379744/1

    2023-05-18T21:54:29.146980  =


    2023-05-18T21:54:29.149189  / # /lava-10379744/bin/lava-test-runner /la=
va-10379744/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6466a14aec11801a0d2e85e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/arm/defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-bla=
ck.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/arm/defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-bla=
ck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6466a14aec11801a0=
d2e85e7
        new failure (last pass: v5.10.175-cip29-rt12) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6466a17fe56c7db52a2e860b

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/arm/defconfig/gcc-10/lab-cip/baseline-nfs-beaglebone-black.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/arm/defconfig/gcc-10/lab-cip/baseline-nfs-beaglebone-black.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6466a17fe56c7db52a2e860e
        failing since 111 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-05-18T22:05:56.694335  + set +x
    2023-05-18T22:05:56.708155  <8>[   47.115576] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 936516_1.6.2.4.1>
    2023-05-18T22:05:56.922680  #
    2023-05-18T22:05:57.025679  / # #export SHELL=3D/bin/sh
    2023-05-18T22:05:57.026415  =

    2023-05-18T22:05:57.128238  / # export SHELL=3D/bin/sh. /lava-936516/en=
vironment
    2023-05-18T22:05:57.128940  =

    2023-05-18T22:05:57.230852  / # . /lava-936516/environment/lava-936516/=
bin/lava-test-runner /lava-936516/1
    2023-05-18T22:05:57.232008  =

    2023-05-18T22:05:57.238668  / # /lava-936516/bin/lava-test-runner /lava=
-936516/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6466a077e77f234ebd2e85fa

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nfs-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nfs-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6466a077e77f234ebd2e862a
        failing since 57 days (last pass: v5.10.158-cip22-rt9, first fail: =
v5.10.175-cip29-rt12)

    2023-05-18T22:02:00.343106  <8>[   64.323960] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 482971_1.6.2.4.1>
    2023-05-18T22:02:00.462743  / # #
    2023-05-18T22:02:00.565816  export SHELL=3D/bin/sh
    2023-05-18T22:02:00.566354  #
    2023-05-18T22:02:00.668291  / # export SHELL=3D/bin/sh. /lava-482971/en=
vironment
    2023-05-18T22:02:00.669203  =

    2023-05-18T22:02:00.771187  / # . /lava-482971/environment/lava-482971/=
bin/lava-test-runner /lava-482971/1
    2023-05-18T22:02:00.772446  =

    2023-05-18T22:02:00.776369  / # /lava-482971/bin/lava-test-runner /lava=
-482971/1
    2023-05-18T22:02:01.020459  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64669fce482fd49d842e85ef

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebo=
ne-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebo=
ne-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64669fce482fd49d842e85f2
        failing since 57 days (last pass: v5.10.158-cip22-rt9, first fail: =
v5.10.175-cip29-rt12)

    2023-05-18T21:59:22.681493  <8>[   39.410159] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 936509_1.6.2.4.1>
    2023-05-18T21:59:22.800072  / # #
    2023-05-18T21:59:22.902087  export SHELL=3D/bin/sh
    2023-05-18T21:59:22.902547  #
    2023-05-18T21:59:23.003930  / # export SHELL=3D/bin/sh. /lava-936509/en=
vironment
    2023-05-18T21:59:23.004382  =

    2023-05-18T21:59:23.105820  / # . /lava-936509/environment/lava-936509/=
bin/lava-test-runner /lava-936509/1
    2023-05-18T21:59:23.106598  =

    2023-05-18T21:59:23.108724  / # /lava-936509/bin/lava-test-runner /lava=
-936509/1
    2023-05-18T21:59:23.358096  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/6466abb8fead49b1a12e85ff

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6466abb8fead49b1a12e8604
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-05-18T22:50:09.030038  + set +x

    2023-05-18T22:50:09.036445  <8>[   16.187382] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10380081_1.5.2.3.1>

    2023-05-18T22:50:09.141015  / # #

    2023-05-18T22:50:09.243253  export SHELL=3D/bin/sh

    2023-05-18T22:50:09.244026  #

    2023-05-18T22:50:09.345532  / # export SHELL=3D/bin/sh. /lava-10380081/=
environment

    2023-05-18T22:50:09.346384  =


    2023-05-18T22:50:09.447965  / # . /lava-10380081/environment/lava-10380=
081/bin/lava-test-runner /lava-10380081/1

    2023-05-18T22:50:09.449107  =


    2023-05-18T22:50:09.454208  / # /lava-10380081/bin/lava-test-runner /la=
va-10380081/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/6466ab920ac8382c632e85ef

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6466ab920ac8382c632e85f4
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-05-18T22:49:38.732608  + set +x

    2023-05-18T22:49:38.739168  <8>[   19.880636] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10379747_1.5.2.3.1>

    2023-05-18T22:49:38.843541  / # #

    2023-05-18T22:49:38.944130  export SHELL=3D/bin/sh

    2023-05-18T22:49:38.944329  #

    2023-05-18T22:49:39.044808  / # export SHELL=3D/bin/sh. /lava-10379747/=
environment

    2023-05-18T22:49:39.044963  =


    2023-05-18T22:49:39.145451  / # . /lava-10379747/environment/lava-10379=
747/bin/lava-test-runner /lava-10379747/1

    2023-05-18T22:49:39.145710  =


    2023-05-18T22:49:39.150301  / # /lava-10379747/bin/lava-test-runner /la=
va-10379747/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64669ff9ccf9c1883b2e861e

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/arm/defconfig/gcc-10/lab-collabora/baseline-nfs-imx6q-sabrel=
ite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/arm/defconfig/gcc-10/lab-collabora/baseline-nfs-imx6q-sabrel=
ite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64669ff9ccf9c1883b2e8623
        failing since 111 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-05-18T22:00:01.018025  + set +x

    2023-05-18T22:00:01.119942  / # #

    2023-05-18T22:00:01.222206  export SHELL=3D/bin/sh

    2023-05-18T22:00:01.222886  [   25.852520] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-05-18T22:00:01.223253  [   25.853536] <LAVA_SIGNAL_ENDRUN 0_dmesg =
10379963_1.6.2.4.1>

    2023-05-18T22:00:01.223576  #

    2023-05-18T22:00:01.324989  / # export SHELL=3D/bin/sh. /lava-10379963/=
environment

    2023-05-18T22:00:01.325748  =


    2023-05-18T22:00:01.427169  / # . /lava-10379963/environment/lava-10379=
963/bin/lava-test-runner /lava-10379963/1

    2023-05-18T22:00:01.428260  =

 =

    ... (17 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/6466a3473821e2e7c92e8677

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/arm64/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-nfs-m=
eson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/arm64/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-nfs-m=
eson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6466a3473821e2e7c=
92e8678
        failing since 57 days (last pass: v5.10.162-cip24-rt10, first fail:=
 v5.10.175-cip29-rt12) =

 =20

