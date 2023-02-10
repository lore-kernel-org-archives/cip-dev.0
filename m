Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8BAC05027
	for <webhook@archiver.kernel.org>; Fri, 10 Feb 2023 11:07:45 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web11.11714.1676027264597668870
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 10 Feb 2023 03:07:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=uONjG5qy;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.177, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f177.google.com with SMTP id k13so6162994plg.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 10 Feb 2023 03:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ah6tktMjQLSsdzXp2XcVHQ5Y6XPam6RpuuBYWFBIUho=;
        b=uONjG5qy7X7n1i3ebFJ8zzPls8Nuokru8bG+opUXosLuavkGP9oEKzf1iUFcWmx5EI
         iw/upVYhKmo/SDaCAdVSxyx1itMh7VuqAwRTLxapcJxLyMsjmv6hRhOTPU3Iqm5Zlnem
         2sIawXkebKsOD/Y2WT0IG3/pIezowumxwTW28YuNaHjTdRVOgTyrxejW9dEw8ARgVF2l
         TIeAnPUG+Ymh8eKnMQJw0yGeQjePwW+rYvppRBdqlyoqtYeb9+madVxxFssPLHmtBw2D
         kIpbCWit3aKIKA1OxB/7F7P8zC4b/AkLQIXG/j2cTGOarvPoZeWuj2L9oVU6xqQFRnTi
         8YSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ah6tktMjQLSsdzXp2XcVHQ5Y6XPam6RpuuBYWFBIUho=;
        b=wV+9j4CQdRs41/3x1SmChiRVe0p098runehw2vEf/DsUpBsmV3eXuYvTb64eoWcI44
         6HwEZSvziuOjzTbwATlKffQAy4+Dk5Jk84F25Ybv4rN+WujPbLKg+oj+sL2eNi/Pmu7d
         /Wxdjf43j7TP1D+Hvk5yWwGQqd5U/3bkR8PCP0SYEI/pqrdSGy3yWSFXulvWWPfCzdi3
         Mt0kEWeE6czm+ACLalxnH8t6CVtgcc8HPuReQgOD1fZfTwUHQ2vUqICe1JkN7Xqxu/3p
         2QhzDBPnIy6OTXjaDzZiGjSe4juukdpBx/0xlmAWUP4Qk3pVHQDkUolEw+elTFoIjePa
         RBjg==
X-Gm-Message-State: AO0yUKVwgEocMBbDFZfRBsUrxV7RX2n+Q5V4rdjehhXaAgbT9vchg8GG
	opLxqW4ii7jJYxeYAy2jY0N1UKvwjdbO++u3FAntwA==
X-Google-Smtp-Source: AK7set93KXFrn57LcMRkr+5G37R2t3u1Zv5m/D1uuKk3zWpv2VoAdSbAcYCuRTbeKMgZENLSc1QOVA==
X-Received: by 2002:a17:902:d18b:b0:199:e58f:b28b with SMTP id m11-20020a170902d18b00b00199e58fb28bmr4394623plb.42.1676027263217;
        Fri, 10 Feb 2023 03:07:43 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d2-20020a170902b70200b0019a7c890c5asm72652pls.263.2023.02.10.03.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 03:07:42 -0800 (PST)
Message-ID: <63e6257e.170a0220.8fa6c.0174@mx.google.com>
Date: Fri, 10 Feb 2023 03:07:42 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.167-cip26
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip baseline-nfs: 58 runs,
 19 regressions (v5.10.167-cip26)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Feb 2023 11:07:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10639

cip/linux-5.10.y-cip baseline-nfs: 58 runs, 19 regressions (v5.10.167-cip26)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
acer-cb317-1h-c3z6-dedede | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

at91sam9g20ek             | arm    | lab-broonie   | gcc-10   | multi_v5_de=
fconfig           | 1          =

beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =

beaglebone-black          | arm    | lab-cip       | gcc-10   | multi_v7_de=
fconfig           | 1          =

beaglebone-black          | arm    | lab-broonie   | gcc-10   | omap2plus_d=
efconfig          | 1          =

beaglebone-black          | arm    | lab-cip       | gcc-10   | omap2plus_d=
efconfig          | 1          =

imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =

rk3288-veyron-jaq         | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 4          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 5          =

sun50i-a64-pine64-plus    | arm64  | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.167-cip26/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.167-cip26
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      dd0dd3e572fd82c1c232ad1f089ca628d7dc16de =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
acer-cb317-1h-c3z6-dedede | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63e619e2c65877f8588c8638

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230203.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63e619e2c65877f8588c8641
        failing since 27 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-10T10:18:00.750119  [   14.680242] <LAVA_SIGNAL_ENDRUN 0_dmesg =
9097412_1.5.2.3.1>

    2023-02-10T10:18:00.753661  + set +x

    2023-02-10T10:18:00.855361  / ##

    2023-02-10T10:18:00.956368  export SHELL=3D/bin/sh

    2023-02-10T10:18:00.956572   #

    2023-02-10T10:18:01.057576  / # export SHELL=3D/bin/sh. /lava-9097412/e=
nvironment

    2023-02-10T10:18:01.057845  =


    2023-02-10T10:18:01.158818  / # . /lava-9097412/environment/lava-909741=
2/bin/lava-test-runner /lava-9097412/1

    2023-02-10T10:18:01.159104  =


    2023-02-10T10:18:01.164333  / # /lava-9097412/bin/lava-test-runner /lav=
a-9097412/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63e61a6d1e452208d78c867f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230203.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63e61a6d1e452208d78c8688
        failing since 27 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-10T10:20:18.686664  + set<8>[   14.781202] <LAVA_SIGNAL_ENDRUN =
0_dmesg 9097432_1.5.2.3.1>

    2023-02-10T10:20:18.686754   +x

    2023-02-10T10:20:18.791574  <6>[   14.789315] lava-test#

    2023-02-10T10:20:18.792868  -runne (265) used greatest stack depth: 130=
16 bytes left

    2023-02-10T10:20:18.894865  / # #export SHELL=3D/bin/sh

    2023-02-10T10:20:18.895665  =


    2023-02-10T10:20:18.997470  / # export SHELL=3D/bin/sh. /lava-9097432/e=
nvironment

    2023-02-10T10:20:18.998322  =


    2023-02-10T10:20:19.099966  / # . /lava-9097432/environment/lava-909743=
2/bin/lava-test-runner /lava-9097432/1

    2023-02-10T10:20:19.100282  =

 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63e61a3d1b7a0d8d1d8c8644

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230203.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63e61a3d1b7a0d8d1d8c864d
        failing since 27 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-10T10:19:19.074484  + set +x

    2023-02-10T10:19:19.081219  <8>[   19.466363] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9097444_1.5.2.3.1>

    2023-02-10T10:19:19.191246  / # #

    2023-02-10T10:19:19.294422  export SHELL=3D/bin/sh

    2023-02-10T10:19:19.295389  #

    2023-02-10T10:19:19.397406  / # export SHELL=3D/bin/sh. /lava-9097444/e=
nvironment

    2023-02-10T10:19:19.398406  =


    2023-02-10T10:19:19.500381  / # . /lava-9097444/environment/lava-909744=
4/bin/lava-test-runner /lava-9097444/1

    2023-02-10T10:19:19.501946  =


    2023-02-10T10:19:19.506674  / # /lava-9097444/bin/lava-test-runner /lav=
a-9097444/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
at91sam9g20ek             | arm    | lab-broonie   | gcc-10   | multi_v5_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63e61e26ac6614c44c8c8716

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-nfs-at91sam9g20ek=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-nfs-at91sam9g20ek=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230203.0/armel/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63e61e26ac6614c44c8c871f
        failing since 27 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-10T10:35:57.103457  + set +x
    2023-02-10T10:35:57.108501  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 295967_1.6.2=
.4.1>
    2023-02-10T10:35:57.225597  #
    2023-02-10T10:35:57.328822  / # #export SHELL=3D/bin/sh
    2023-02-10T10:35:57.329594  =

    2023-02-10T10:35:57.431526  / # export SHELL=3D/bin/sh. /lava-295967/en=
vironment
    2023-02-10T10:35:57.432320  =

    2023-02-10T10:35:57.534330  / # . /lava-295967/environment/lava-295967/=
bin/lava-test-runner /lava-295967/1
    2023-02-10T10:35:57.535235  =

    2023-02-10T10:35:57.542061  / # /lava-295967/bin/lava-test-runne =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63e62029fcee96156d8c8632

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-bl=
ack.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-bl=
ack.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230203.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63e62029fcee96156d8c863b
        failing since 27 days (last pass: v5.10.158-cip22, first fail: v5.1=
0.162-cip24)

    2023-02-10T10:44:31.234498  [   52.500502] <LAVA_SIGNAL_ENDRUN 0_dmesg =
296189_1.6.2.4.1>
    2023-02-10T10:44:31.351637  / # #
    2023-02-10T10:44:31.454329  export SHELL=3D/bin/sh
    2023-02-10T10:44:31.455068  #
    2023-02-10T10:44:31.557409  / # export SHELL=3D/bin/sh. /lava-296189/en=
vironment
    2023-02-10T10:44:31.558152  =

    2023-02-10T10:44:31.660509  / # . /lava-296189/environment/lava-296189/=
bin/lava-test-runner /lava-296189/1
    2023-02-10T10:44:31.661698  =

    2023-02-10T10:44:31.666196  / # /lava-296189/bin/lava-test-runner /lava=
-296189/1
    2023-02-10T10:44:31.888849  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-cip       | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63e623f95d9c331b048c8650

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebone-black.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebone-black.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230203.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63e623f95d9c331b048c8657
        failing since 27 days (last pass: v5.10.158-cip22, first fail: v5.1=
0.162-cip24)

    2023-02-10T11:00:50.309937  <8>[   53.429446] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 846677_1.6.2.4.1>
    2023-02-10T11:00:50.790627  #
    2023-02-10T11:00:50.892270  / # #export SHELL=3D/bin/sh
    2023-02-10T11:00:50.892577  =

    2023-02-10T11:00:50.993720  / # export SHELL=3D/bin/sh. /lava-846677/en=
vironment
    2023-02-10T11:00:50.994029  =

    2023-02-10T11:00:51.095187  / # . /lava-846677/environment/lava-846677/=
bin/lava-test-runner /lava-846677/1
    2023-02-10T11:00:51.095700  =

    2023-02-10T11:00:51.101638  / # /lava-846677/bin/lava-test-runner /lava=
-846677/1
    2023-02-10T11:00:51.423028  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | omap2plus_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63e61a9c363e1952ca8c865f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-b=
lack.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-b=
lack.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230203.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63e61a9c363e1952ca8c8668
        failing since 9 days (last pass: v5.10.158-cip22-7-g92462fd9830b, f=
irst fail: v5.10.165-cip25)

    2023-02-10T10:20:59.480094  [   45.614256] <LAVA_SIGNAL_ENDRUN 0_dmesg =
295732_1.6.2.4.1>
    2023-02-10T10:20:59.597384  / # #
    2023-02-10T10:20:59.700133  export SHELL=3D/bin/sh
    2023-02-10T10:20:59.701117  #
    2023-02-10T10:20:59.803594  / # export SHELL=3D/bin/sh. /lava-295732/en=
vironment
    2023-02-10T10:20:59.804352  =

    2023-02-10T10:20:59.906928  / # . /lava-295732/environment/lava-295732/=
bin/lava-test-runner /lava-295732/1
    2023-02-10T10:20:59.908127  =

    2023-02-10T10:20:59.912917  / # /lava-295732/bin/lava-test-runner /lava=
-295732/1
    2023-02-10T10:21:00.163853  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-cip       | gcc-10   | omap2plus_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63e61c65dfa86fadd98c863d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebone-black=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebone-black=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230203.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63e61c65dfa86fadd98c8644
        failing since 9 days (last pass: v5.10.158-cip22-7-g92462fd9830b, f=
irst fail: v5.10.165-cip25)

    2023-02-10T10:28:36.267427  + set +x
    2023-02-10T10:28:36.270767  <8>[   43.429525] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 846583_1.6.2.4.1>
    2023-02-10T10:28:36.442523  #
    2023-02-10T10:28:36.545583  / # #export SHELL=3D/bin/sh
    2023-02-10T10:28:36.546098  =

    2023-02-10T10:28:36.647691  / # export SHELL=3D/bin/sh. /lava-846583/en=
vironment
    2023-02-10T10:28:36.648375  =

    2023-02-10T10:28:36.750007  / # . /lava-846583/environment/lava-846583/=
bin/lava-test-runner /lava-846583/1
    2023-02-10T10:28:36.750512  =

    2023-02-10T10:28:36.756979  / # /lava-846583/bin/lava-test-runner /lava=
-846583/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63e61ee088fcf5ba1e8c862f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-nfs-imx6q-sabre=
lite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-nfs-imx6q-sabre=
lite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230203.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63e61ee088fcf5ba1e8c8638
        failing since 27 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-10T10:39:22.640851  / # #

    2023-02-10T10:39:22.744062  export SHELL=3D/bin/sh

    2023-02-10T10:39:22.744890  #

    2023-02-10T10:39:22.847249  / # export SHELL=3D/bin/sh. /lava-9097935/e=
nvironment

    2023-02-10T10:39:22.848085  =


    2023-02-10T10:39:22.950336  / # . /lava-9097935/environment/lava-909793=
5/bin/lava-test-runner /lava-9097935/1

    2023-02-10T10:39:22.951602  =


    2023-02-10T10:39:22.963473  / # /lava-9097935/bin/lava-test-runner /lav=
a-9097935/1

    2023-02-10T10:39:23.150127  + export TESTRUN_ID=3D1_bootrr

    2023-02-10T10:39:23.150681  + cd /lava-9097935/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3288-veyron-jaq         | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 4          =


  Details:     https://kernelci.org/test/plan/id/63e6204499c581fd438c8645

  Results:     63 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-nfs-rk3288-veyr=
on-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-nfs-rk3288-veyr=
on-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230203.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.dwhdmi-rockchip-driver-i2c-present: https://kernelc=
i.org/test/case/id/63e6204499c581fd438c8678
        failing since 25 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-10T10:45:00.381709  <8>[   20.868863] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>

    2023-02-10T10:45:00.433623  seq: invalid floating point argument: =E2=
=80=98ff980000.hdmi/i2c-*=E2=80=99

    2023-02-10T10:45:00.437694  Try 'seq --help' for more information.

    2023-02-10T10:45:00.441250  /lava-9097915/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelc=
i.org/test/case/id/63e6204499c581fd438c8679
        failing since 25 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-10T10:45:00.342405  <8>[   20.829384] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-driver-audio-present RESULT=3Dfail>

    2023-02-10T10:45:00.360703  seq: invalid floating point argument: =E2=
=80=98ff980000.hdmi/dw-hdmi-cec.*=E2=80=99

    2023-02-10T10:45:00.364857  Try 'seq --help' for more information.

    2023-02-10T10:45:00.368152  /lava-9097915/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.dwhdmi-rockchip-driver-audio-present: https://kerne=
lci.org/test/case/id/63e6204499c581fd438c867a
        failing since 25 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-10T10:45:00.294823  <8>[   20.783241] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>

    2023-02-10T10:45:00.321465  seq: invalid floating point argument: =E2=
=80=98ff980000.hdmi/dw-hdmi-audio-*=E2=80=99

    2023-02-10T10:45:00.325089  Try 'seq --help' for more information.

    2023-02-10T10:45:00.328877  /lava-9097915/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63e6204499c581fd438c868e
        failing since 25 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-10T10:44:57.739819  + <8>[   18.231082] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 9097915_1.6.2.3.1>

    2023-02-10T10:44:57.742128  set +x

    2023-02-10T10:44:57.847837  /#

    2023-02-10T10:44:57.951156   # #export SHELL=3D/bin/sh

    2023-02-10T10:44:57.951941  =


    2023-02-10T10:44:58.053796  / # export SHELL=3D/bin/sh. /lava-9097915/e=
nvironment

    2023-02-10T10:44:58.054366  =


    2023-02-10T10:44:58.155719  / # . /lava-9097915/environment/lava-909791=
5/bin/lava-test-runner /lava-9097915/1

    2023-02-10T10:44:58.156611  =


    2023-02-10T10:44:58.158528  / # /lava-9097915/bin/lava-test-runner /lav=
a-9097915/1
 =

    ... (19 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 5          =


  Details:     https://kernelci.org/test/plan/id/63e61ed97a496cedb28c86cc

  Results:     86 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-r=
k3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-r=
k3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230203.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/63e61ed97a496cedb28c86f2
        failing since 318 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81,=
 first fail: v5.10.106-cip4)

    2023-02-10T10:39:01.048369  /lava-9097833/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-rt5514-present: https://ker=
nelci.org/test/case/id/63e61ed97a496cedb28c8707
        failing since 27 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-10T10:38:58.597972  seq: invalid floating point argument: =E2=
=80=98sound/RT5514=E2=80=99

    2023-02-10T10:38:58.602002  Try 'seq --help' for more information.

    2023-02-10T10:38:58.605485  /lava-9097833/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-max98357A-present: https://=
kernelci.org/test/case/id/63e61ed97a496cedb28c8708
        failing since 27 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-10T10:38:58.537209  seq: invalid floating point argument: =E2=
=80=98sound/MAX98357A=E2=80=99

    2023-02-10T10:38:58.541078  Try 'seq --help' for more information.

    2023-02-10T10:38:58.544973  /lava-9097833/1/../bin/lava-test-case

    2023-02-10T10:38:58.570945  <8>[   32.325343] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-max98357A-present RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-dp-present: https://kernelc=
i.org/test/case/id/63e61ed97a496cedb28c8709
        failing since 27 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-10T10:38:58.443835  <8>[   32.198125] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-da7219-present RESULT=3Dfail>

    2023-02-10T10:38:58.474461  seq: invalid floating point argument: =E2=
=80=98sound/DP=E2=80=99

    2023-02-10T10:38:58.477437  Try 'seq --help' for more information.

    2023-02-10T10:38:58.481693  /lava-9097833/1/../bin/lava-test-case

    2023-02-10T10:38:58.509614  <8>[   32.264300] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-dp-present RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-da7219-present: https://ker=
nelci.org/test/case/id/63e61ed97a496cedb28c870a
        failing since 27 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-10T10:38:58.407706  seq: invalid floating point argument: =E2=
=80=98sound/DA7219=E2=80=99

    2023-02-10T10:38:58.411105  Try 'seq --help' for more information.

    2023-02-10T10:38:58.414434  /lava-9097833/1/../bin/lava-test-case
   =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
sun50i-a64-pine64-plus    | arm64  | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/63e6247061fdbeaff98c8639

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-sun50i-a64-pine64-pl=
us.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-sun50i-a64-pine64-pl=
us.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230203.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63e6247061fdbeaff98c8642
        failing since 27 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-10T11:02:58.523324  + set +x
    2023-02-10T11:02:58.526417  <8>[   36.907808] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 295846_1.6.2.4.1>
    2023-02-10T11:02:58.654890  #
    2023-02-10T11:02:58.757033  / # #export SHELL=3D/bin/sh
    2023-02-10T11:02:58.757522  =

    2023-02-10T11:02:58.859185  / # export SHELL=3D/bin/sh. /lava-295846/en=
vironment
    2023-02-10T11:02:58.860667  =

    2023-02-10T11:02:58.964330  / # . /lava-295846/environment/lava-295846/=
bin/lava-test-runner /lava-295846/1
    2023-02-10T11:02:58.965176  =

    2023-02-10T11:02:58.968089  / # /lava-295846/bin/lava-test-runner /lava=
-295846/1 =

    ... (12 line(s) more)  =

 =20

